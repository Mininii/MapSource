"""eudplib 페이로드를 게임 없이 돌려 보는 작은 트리거 에뮬레이터 (연산·흐름 검증용).

지원: 트리거 연결 목록(다음 포인터 자기수정 포함), 보존/비활성 플래그, Deaths/Memory 조건(마스크 포함),
SetDeaths/SetMemory 액션(SetTo/Add/Subtract, 마스크 포함, Subtract 는 0 포화), CurrentPlayer(0x6509B0),
Always/Never, 비활성 조건·액션 건너뛰기. 그 밖의 조건은 거짓, 그 밖의 액션은 기록만 한다(DisplayText 등).

사용:
    from eudplib import *
    import emu
    LoadMap(base); CompressPayload(True)
    run = emu.Program(main_body)          # main_body: 코드를 만드는 함수 (한 사이클 분량)
    v = EUDVariable() ...                 # 확인할 값은 run.watch(이름, ConstExpr 주소)
    m = run.build()                       # 페이로드 생성 + 재배치 → Machine
    m.cycle(n)                            # n 사이클 실행
    m.dw(addr)                            # 메모리 읽기
"""
import struct

from eudplib import EUDObject, Never, SetMemory, SetTo
from eudplib import core as c
from eudplib.maprw.injector.mainloop import EUDDoEvents

BASE = 0x10000000          # 페이로드를 올릴 주소 (4의 배수)
EPD0 = 0x58A364
CP_ADDR = 0x6509B0
END = 0x80000000


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
        return r & 0xFFFFFFFF
    off, mode = r.offset, r.rlocmode
    return (off + mode * (base // 4)) & 0xFFFFFFFF


class Program:
    def __init__(self, body, loop=True):
        self.body = body
        self.loop = loop
        self.exprs = {}

    def watch(self, name, expr):
        self.exprs[name] = expr

    def build(self, base=BASE):
        probe = _Probe(self.exprs)

        def mf():
            # 탐침을 페이로드에 붙잡아 둔다 (흐름 안에 있지만 Never 라 실행되지 않는 트리거가 주소를 참조)
            c.RawTrigger(conditions=Never(), actions=SetMemory(probe, SetTo, 0))
            if self.loop:
                from eudplib import EUDEndInfLoop, EUDInfLoop
                if EUDInfLoop()():
                    self.body()
                    EUDDoEvents()
                EUDEndInfLoop()
            else:
                self.body()

        # SaveMap 을 그대로 돌리되 주입 단계를 가로채 재배치 전 페이로드와 루트(main_starter 의 jumper)를 잡는다
        import os
        import tempfile

        from eudplib import SaveMap
        from eudplib.maprw import savemap as sm
        from eudplib.maprw.injector import apply_injector as ai

        captured = {}
        orig_apply, orig_init = sm.apply_injector, ai.initialize_payload

        def fake_init(chkt, payload, mrgndata=None):
            captured["payload"] = payload

        def patched_apply(chkt, root):
            probe.exprs["__root__"] = root
            return orig_apply(chkt, root)

        sm.apply_injector = patched_apply
        ai.initialize_payload = fake_init
        try:
            out = os.path.join(tempfile.gettempdir(), "eud_emu_out.scx")
            SaveMap(out, mf)
        except Exception:
            if "payload" not in captured:
                raise
        finally:
            sm.apply_injector, ai.initialize_payload = orig_apply, orig_init
        payload = captured["payload"]
        data = bytearray(payload.data)
        for prt in payload.prttable:
            v = struct.unpack_from("<I", data, prt)[0]
            struct.pack_into("<I", data, prt, (v + base // 4) & 0xFFFFFFFF)
        for ort in payload.orttable:
            v = struct.unpack_from("<I", data, ort)[0]
            struct.pack_into("<I", data, ort, (v + base) & 0xFFFFFFFF)
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
        self.addrs = addrs
        self.root = addrs["__root__"]
        self.log = []
        self.steps = 0

    # --- 메모리 ---
    def dw(self, addr):
        return self.mem.get(addr & 0xFFFFFFFF, 0)

    def setdw(self, addr, v):
        addr &= 0xFFFFFFFF
        if addr & 3:
            raise RuntimeError("정렬 안 된 주소 쓰기 0x%X" % addr)
        self.mem[addr] = v & 0xFFFFFFFF

    def var(self, name):
        return self.dw(self.addrs[name])

    # --- 실행 ---
    def _epd_addr(self, player, unit):
        if player == 13:
            player = self.dw(CP_ADDR)
        elif 12 <= player <= 26 and player != 13:
            return None
        idx = (unit * 12 + player) & 0xFFFFFFFF  # 데스 테이블 = [유닛][플레이어]
        return (EPD0 + 4 * idx) & 0xFFFFFFFF

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
                raise RuntimeError("Deaths 의 특수 플레이어 %d" % player)
            v = self.dw(a)
            if eudx == 0x4353:
                v &= locid
            if cmp_ == 0:
                return v >= amount
            if cmp_ == 1:
                return v <= amount
            if cmp_ == 10:
                return v == amount
            raise RuntimeError("비교 %d" % cmp_)
        self.log.append(("cond?", ctype))
        return False

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
                raise RuntimeError("SetDeaths 의 특수 플레이어 %d" % p1)
            old, v = self.dw(a), p2
            m = locid if eudx == 0x4353 else 0xFFFFFFFF
            if amount == 7:
                new = (old & ~m) | (v & m)
            elif amount == 8:
                new = (old & ~m) | (((old & m) + (v & m)) & m)
            elif amount == 9:
                s = (old & m) - (v & m)
                new = (old & ~m) | (max(s, 0) & m)
            else:
                raise RuntimeError("수정자 %d" % amount)
            self.setdw(a, new)
        else:
            self.log.append(("act", atype, strid, p1, p2, unit))
        return True

    def cycle(self, n=1, limit=5_000_000):
        """n 사이클 실행. 사이클마다 (실행한 트리거 수, 끝난 곳) 을 self.ends 에 남긴다 — 정상 끝은 END."""
        self.ends = getattr(self, "ends", [])
        for _ in range(n):
            t = self.root
            start = self.steps
            while t not in (0, END):
                if not (self.base <= t < self.base + 0x10000000):
                    self.ends.append((self.steps - start, t))
                    raise RuntimeError("페이로드 밖으로 점프: 0x%X (직전 0x%X)" % (t, getattr(self, "last", 0)))
                self.last = t
                self.steps += 1
                if self.steps > limit:
                    raise RuntimeError("실행 한도 초과 (무한 루프?) 마지막 트리거 0x%X" % t)
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
