# -*- coding: utf-8 -*-
"""eudplib 페이로드를 게임 없이 돌려 보는 작은 트리거 에뮬레이터 (SNQC 시험용, eudplib 0.76.14 / 0.81 공용).

출처: DPS_eud `eud/tests/emu.py`(0.76.14) 와 eudext `eudext/testing/emu.py`(0.81) 를 합쳐 옮겼다 (원본은 고치지 않음).
두 판 모두 SaveMap 안의 `maprw.savemap.apply_injector`, `maprw.injector.apply_injector.initialize_payload` 를
바꿔 끼워 재배치 전 페이로드와 루트 트리거를 잡는다.

지원: 트리거 연결 목록(next 자기수정 포함), 보존/비활성 플래그, Deaths/Memory 조건(마스크 포함),
SetDeaths/SetMemory 액션(SetTo/Add/Subtract, 마스크 포함, Subtract 는 0 포화), CurrentPlayer(0x6509B0),
Always/Never. SNQC 에 필요한 만큼의 CreateUnit(빈 유닛 칸에 종류·주인을 쓰고 다음 칸으로). 그 밖의 조건은 거짓,
그 밖의 액션은 기록만 한다(GiveUnits, DisplayText 등).
"""
import os
import random
import struct
import tempfile

from eudplib import EUDObject, Never, SetMemory, SetTo
from eudplib import core as c

try:
    from eudplib import EUDDoEvents
except ImportError:  # 0.76 은 최상위에 없을 수 있다
    from eudplib.maprw.injector.mainloop import EUDDoEvents

BASE = 0x10000000          # 페이로드를 올릴 주소 (4의 배수)
EPD0 = 0x58A364
CP_ADDR = 0x6509B0
END = 0x80000000
M32 = 0xFFFFFFFF
CUNIT0 = 0x59CCA8
CUNIT_SIZE = 336
FREE_UNIT = 0x628438


class EmuError(RuntimeError):
    pass


class _Probe(EUDObject):
    """페이로드를 쓰는 단계에서 식들의 (offset, rlocmode) 를 기록한다."""

    def __new__(cls, *a, **k):
        return super().__new__(cls)

    def __init__(self, exprs):
        super().__init__()
        self.exprs = exprs
        self.result = None

    def GetDataSize(self):  # noqa: N802
        return 4

    def WritePayload(self, buf):  # noqa: N802
        self.result = {}
        for name, e in self.exprs.items():
            r = e.Evaluate() if hasattr(e, "Evaluate") else e
            self.result[name] = r
        buf.WriteDword(0)


def _reloc_value(r, base):
    if isinstance(r, int):
        return r & M32
    off, mode = r.offset, r.rlocmode
    return (off + mode * (base // 4)) & M32


class Program:
    """setup(): 첫 사이클에 한 번 (euddraft 의 onPluginStart 자리), body(): 매 사이클 (beforeTriggerExec 자리)."""

    def __init__(self, body, setup=None):
        self.body = body
        self.setup = setup
        self.exprs = {}

    def watch(self, name, expr):
        if hasattr(expr, "getValueAddr"):
            expr = expr.getValueAddr()
        self.exprs[name] = expr

    def build(self, out_dir, base=BASE):
        probe = _Probe(self.exprs)
        from eudplib import EUDEndInfLoop, EUDInfLoop, SaveMap
        from eudplib.maprw import savemap as sm
        from eudplib.maprw.injector import apply_injector as ai
        from eudplib.maprw.injector import mainloop as ml

        def mf():
            c.RawTrigger(conditions=Never(), actions=SetMemory(probe, SetTo, 0))
            if self.setup is not None:
                self.setup()
            if EUDInfLoop()():
                if hasattr(ml, "_set_game_loop_start"):  # 0.81: euddraft 처럼 게임 루프 시작점
                    ml._set_game_loop_start()
                self.body()
                EUDDoEvents()
            EUDEndInfLoop()

        captured = {}
        orig_apply, orig_init = sm.apply_injector, ai.initialize_payload

        def fake_init(chkt, payload, mrgndata=None):
            captured["payload"] = payload

        def patched_apply(chkt, root):
            probe.exprs["__root__"] = root
            return orig_apply(chkt, root)

        sm.apply_injector = patched_apply
        ai.initialize_payload = fake_init
        out = os.path.join(out_dir, "emu_out_%d.scx" % os.getpid())
        try:
            SaveMap(out, mf)
        except Exception:
            if "payload" not in captured:
                raise
        finally:
            sm.apply_injector, ai.initialize_payload = orig_apply, orig_init
            try:
                os.remove(out)
            except OSError:
                pass
        payload = captured["payload"]
        data = bytearray(payload.data)
        for prt in payload.prttable:
            v = struct.unpack_from("<I", data, prt)[0]
            struct.pack_into("<I", data, prt, (v + base // 4) & M32)
        for ort in payload.orttable:
            v = struct.unpack_from("<I", data, ort)[0]
            struct.pack_into("<I", data, ort, (v + base) & M32)
        addrs = {k: _reloc_value(v, base) for k, v in probe.result.items()}
        return Machine(bytes(data), base, addrs)


class Machine:
    def __init__(self, data, base, addrs):
        self.mem = {}
        pad = -len(data) & 3
        data = data + bytes(pad)
        for i in range(0, len(data), 4):
            v = struct.unpack_from("<I", data, i)[0]
            if v:
                self.mem[base + i] = v
        self.base = base
        self.size = len(data)
        self.addrs = addrs
        self.root = addrs["__root__"]
        self.log = []
        self.steps = 0
        self.ends = []
        self.rng = random.Random(20260917)
        self.writes = None   # set 이면 SetDeaths/SetMemory 가 쓴 주소를 모은다

    # --- 메모리 ---
    def dw(self, addr):
        return self.mem.get(addr & M32, 0)

    def setdw(self, addr, v):
        addr &= M32
        if addr & 3:
            raise EmuError("정렬 안 된 주소 쓰기 0x%X" % addr)
        self.mem[addr] = v & M32

    def db(self, addr):
        addr &= M32
        return (self.dw(addr & ~3) >> (8 * (addr & 3))) & 0xFF

    def setdb(self, addr, v):
        addr &= M32
        a = addr & ~3
        sh = 8 * (addr & 3)
        self.setdw(a, (self.dw(a) & ~(0xFF << sh)) | ((v & 0xFF) << sh))

    def read_bytes(self, addr, n):
        return bytes(self.db(addr + i) for i in range(n))

    def write_bytes(self, addr, data):
        for i, b in enumerate(data):
            self.setdb(addr + i, b)

    def var(self, name):
        return self.dw(self.addrs[name])

    def snapshot(self):
        return dict(self.mem)

    def restore(self, snap):
        self.mem = dict(snap)

    def in_payload(self, addr):
        return self.base <= addr < self.base + self.size

    # --- 실행 ---
    def _epd_addr(self, player, unit):
        if player == 13:
            player = self.dw(CP_ADDR)
        elif 12 <= player <= 26:
            return None
        idx = (unit * 12 + player) & M32  # 데스 테이블 = [유닛][플레이어]
        return (EPD0 + 4 * idx) & M32

    def _cond(self, t, i):
        o = t + 8 + i * 20
        locid, player, amount = self.dw(o), self.dw(o + 4), self.dw(o + 8)
        w3 = self.dw(o + 12)
        unit, cmp_, ctype = w3 & 0xFFFF, (w3 >> 16) & 0xFF, (w3 >> 24) & 0xFF
        w4 = self.dw(o + 16)
        flags = (w4 >> 8) & 0xFF
        eudx = (w4 >> 16) & 0xFFFF
        if ctype == 0:
            return None
        if flags & 2:
            return True
        if ctype == 22:
            return True
        if ctype == 23:
            return False
        if ctype == 15:
            a = self._epd_addr(player, unit)
            if a is None:
                raise EmuError("Deaths 의 특수 플레이어 %d" % player)
            v = self.dw(a)
            if eudx == 0x4353:
                v &= locid
            if cmp_ == 0:
                return v >= amount
            if cmp_ == 1:
                return v <= amount
            if cmp_ == 10:
                return v == amount
            raise EmuError("비교 %d" % cmp_)
        self.log.append(("cond?", ctype))
        return False

    def _create_unit(self, player, unit, count):
        for _ in range(count):
            ptr = self.dw(FREE_UNIT)
            if not ptr:
                return
            self.setdw(ptr + 0x64, (self.dw(ptr + 0x64) & ~0xFFFF) | unit)
            self.setdb(ptr + 0x4C, player)
            self.setdb(ptr + 0x4D, 1)            # 오더 (살아 있음)
            self.setdw(ptr + 0xF8, 0)            # 랠리
            nxt = ptr + CUNIT_SIZE
            self.setdw(FREE_UNIT, nxt if nxt < CUNIT0 + CUNIT_SIZE * 1700 else 0)
            self.log.append(("create", player, unit, ptr))

    def _act(self, t, i):
        o = t + 8 + 320 + i * 32
        locid, strid, wavid, time_, p1, p2 = (self.dw(o + k) for k in range(0, 24, 4))
        w6 = self.dw(o + 24)
        unit, atype, amount = w6 & 0xFFFF, (w6 >> 16) & 0xFF, (w6 >> 24) & 0xFF
        w7 = self.dw(o + 28)
        flags = w7 & 0xFF
        eudx = (w7 >> 16) & 0xFFFF
        if atype == 0:
            return False
        if flags & 2:
            return True
        if atype == 45:
            a = self._epd_addr(p1, unit)
            if a is None:
                raise EmuError("SetDeaths 의 특수 플레이어 %d" % p1)
            old, v = self.dw(a), p2
            m = locid if eudx == 0x4353 else M32
            if amount == 7:
                new = (old & ~m) | (v & m)
            elif amount == 8:
                new = (old & ~m) | (((old & m) + (v & m)) & m)
            elif amount == 9:
                s = (old & m) - (v & m)
                new = (old & ~m) | (max(s, 0) & m)
            else:
                raise EmuError("수정자 %d" % amount)
            self.setdw(a, new)
            if self.writes is not None:
                self.writes.append((a, m, t))
        elif atype == 44:                   # CreateUnit(Count, Unit, Where, Player)
            self._create_unit(p1 if p1 < 12 else self.dw(CP_ADDR), unit, amount)
        else:
            self.log.append(("act", atype, strid, p1, p2, unit, locid, amount))
        return True

    def cycle(self, n=1, limit=5_000_000):
        for _ in range(n):
            t = self.root
            start = self.steps
            while t not in (0, END):
                if not (self.base <= t < self.base + self.size):
                    self.ends.append((self.steps - start, t))
                    raise EmuError("페이로드 밖으로 점프: 0x%X (직전 0x%X)" % (t, getattr(self, "last", 0)))
                self.last = t
                self.steps += 1
                if self.steps - start > limit:
                    raise EmuError("실행 한도 초과 (무한 루프?) 마지막 트리거 0x%X" % t)
                flags = self.dw(t + 8 + 2368)
                if not (flags & 8):
                    ok = True
                    for i in range(16):
                        r = self._cond(t, i)
                        if r is None:
                            break
                        if not r:
                            ok = False
                            break
                    if ok:
                        for i in range(64):
                            if not self._act(t, i):
                                break
                        if not (flags & 4):
                            self.setdw(t + 8 + 2368, self.dw(t + 8 + 2368) | 8)
                t = self.dw(t + 4)
            self.ends.append((self.steps - start, t))
        return self.ends[-1]
