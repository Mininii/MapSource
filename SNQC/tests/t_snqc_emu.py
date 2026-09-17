# -*- coding: utf-8 -*-
"""SNQC.py 에뮬레이터 회귀 시험 (eudplib 0.76.14 / 0.81 공용, 1.3 에서 만듦).

게임 없이 SNQC 페이로드를 `emu.py` 로 돌리고, 턴 버퍼(0x654880)를 파이썬에서 "보내고 실행" 해서
보내기(로컬) → 턴 → 받기(공유) 한 바퀴를 본다. 턴 모델: K 사이클마다 버퍼의 명령(09/0A/0B 선택, 15 랠리)을
차례로 실행하고(같은 건물에 두 번이면 마지막 값) 길이를 7(맨 앞 Sync)로 되돌린다. 실제 게임의 지연은 흉내 내지 않는다.

  python t_snqc_emu.py MAP [--plugin SNQC.py] [--work 폴더]
    MAP     사람 슬롯이 P1 에 있는 128x128 맵 **사본** (예: eudext/testing/base_multi.scx 를 작업 폴더로 복사한 것.
            Windows 는 여러 프로세스가 같은 scx 를 열면 오류 32 - 원본을 직접 주지 말고, 두 판을 동시에 돌리면 사본도 판마다 따로)
    --plugin  시험할 SNQC.py (기본: ../SNQC.py)
    --work    임시 출력 폴더 (기본: 시스템 임시 폴더)
    --no-array-lines  EUDArray·EUDVArray 결과 줄을 뺀다 (1.2 를 0.81 로 돌려 볼 때 - 1.2 는 그 줄에서 빌드가 멈춘다)

시험 (하나라도 틀리면 끝에 FAIL 과 종료 코드 1)
  keyaddr   키 눌림 기억(KeyUpdate)이 쓰는 칸이 KeyArray 32바이트 안인지, 비트가 (키 // 32 번째 dword, 키 % 32 비트) 인지
            - 1.2 는 eudplib 0.81 에서 EUDArray 값이 EPD 라 `KeyArray + 키//8` 이 dword 색인이 되어 밖에 썼다
  turn1     턴 = 1사이클 (싱글·LAN): 키·값·EUDArray·EUDVArray 결과가 한 번씩 들어오는지
  turn3     턴 = 3사이클 (배틀넷 흉내): 사이클마다 다른 키를 눌러도 한 턴에 모두 들어오는지(합치기),
            채널마다 패킷이 하나인지, 값은 마지막 값인지 - 1.2 는 합치기 판정 뺄셈이 wrap 이라 합치지 못했다
  stale     턴이 나간 뒤 지난 턴의 자리(PendOff)를 합치기로 건드리지 않는지

2026-09-17: 1.3 은 eudplib 0.76.14·0.81.0 모두 PASS (검사 45개, 'EPD on EPD' 경고 0).
  1.2 는 0.76.14 에서 turn3 6개 FAIL, 0.81.0 에서 빌드 TypeError (--no-array-lines 면 경고 38 + keyaddr 5 + turn3 6 FAIL).
"""
import argparse
import os
import sys
import tempfile
import warnings

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

import eudplib  # noqa: E402
from eudplib import (  # noqa: E402
    EPD, CompressPayload, EUDArray, EUDRegisterObjectToNamespace, EUDVArray, EUDVariable, LoadMap,
)

import emu  # noqa: E402

TURNBUF, TURNLEN, MAXBUF = 0x654880, 0x654AA0, 0x57F0D8
KEYSTATE, MOUSESTATE, TYPING = 0x596A18, 0x6CDDC0, 0x68C144
USERPL, SHARED_VIS = 0x512684, 0x57F1EC
SYNC_LEN = 7
LOCAL = 0            # 이 PC = P1
UNIT = 106

# 줄 (MSQC 줄 문법). 키 A·B·F12·` 는 0.81 의 1.2 에서 KeyArray 8칸 밖을 가리키던 키 (색인 8, 8, 15, 24)
SETTINGS = {
    "SNQCCreator": "P2",
    "A": "200, 1",
    "B": "201, 1",
    "F12": "202, 1",
    "`": "203, 1",
    "1": "204, 1",
    "KeyPress(C)": "205, 1",
    "MouseDown(L)": "206, 1",
    "Memory(0x58F604,AtLeast,1);val, 0x58F600": "210",
    "Memory(0x58F60C,AtLeast,1);val, 0x58F608": "QCArr",
    "Memory(0x58F614,AtLeast,1);val, 0x58F610": "QCVArr",
}
KEYS = {"A": 0x41, "B": 0x42, "F12": 0x7B, "`": 0xC0, "1": 0x31, "C": 0x43}
KEY_DEATH = {"A": 200, "B": 201, "F12": 202, "`": 203, "1": 204, "C": 205}

failures = []


def check(name, cond, detail=""):
    print("  [%s] %s %s" % ("ok" if cond else "FAIL", name, detail))
    if not cond:
        failures.append(name + " " + detail)


def epd_of(obj):
    """배열·Db 의 EPD 식 (0.76/0.81 공통 - EUDArray/EUDVArray 는 _epd, Db 는 EPD())"""
    return obj._epd if hasattr(obj, "_epd") else EPD(obj)


def addr_of_epd(v):
    return (emu.EPD0 + 4 * v) & emu.M32


class World:
    def __init__(self, m, ns, W, H):
        self.m, self.ns, self.W, self.H = m, ns, W, H
        self.turn_log = []

    def death(self, p, u):
        return self.m.dw(emu.EPD0 + 4 * (u * 12 + p))

    def key(self, name, down):
        self.m.setdb(KEYSTATE + KEYS[name], 1 if down else 0)

    def keys(self, *names):
        for k in KEYS:
            self.key(k, k in names)

    def flush(self):
        """턴을 보내고 실행한다. 돌려주는 값: {건물 포인터: 받은 랠리 명령 수}"""
        m = self.m
        L = m.dw(TURNLEN)
        buf = m.read_bytes(TURNBUF, L)
        i, sel, got, cmds = SYNC_LEN, [], {}, []
        while i < L:
            op = buf[i]
            if op in (0x09, 0x0A, 0x0B):
                n = buf[i + 1]
                ids = [buf[i + 2 + 2 * k] | buf[i + 3 + 2 * k] << 8 for k in range(n)]
                if op == 0x09:
                    sel = ids
                elif op == 0x0A:
                    sel = sel + ids
                else:
                    sel = [s for s in sel if s not in ids]
                cmds.append((op, ids))
                i += 2 + 2 * n
            elif op == 0x15:
                x, y = buf[i + 1] | buf[i + 2] << 8, buf[i + 3] | buf[i + 4] << 8
                order = buf[i + 9]
                cmds.append((op, x, y, order))
                if order == 40 and x < self.W and y < self.H:
                    for uid in sel:
                        idx, gen = (uid & 0x7FF) - 1, uid >> 11
                        ptr = emu.CUNIT0 + emu.CUNIT_SIZE * idx
                        if (m.dw(ptr + 0x64) & 0xFFFF) == UNIT and m.db(ptr + 0x4C) == LOCAL \
                                and m.db(ptr + 0xA5) % 32 == gen:
                            m.setdw(ptr + 0xF8, x | y << 16)
                            got[ptr] = got.get(ptr, 0) + 1
                i += 11
            else:
                raise emu.EmuError("모르는 명령 0x%02X (위치 %d, 버퍼 %s)" % (op, i, buf.hex()))
        self.turn_log.append((L, cmds))
        m.write_bytes(TURNBUF, bytes(L))
        m.setdw(TURNLEN, SYNC_LEN)
        return got

    def my_channel_ptrs(self):
        n = self.ns["NCh"]
        return [self.m.dw(addr_of_epd(self.m.addrs["MyPtr_epd"] + c)) for c in range(n)]


def build(plugin, mappath, work, array_lines=True):
    from eudplib import GetChkTokenized, b2i2

    LoadMap(mappath)
    CompressPayload(True)
    chkt = GetChkTokenized()
    dim = chkt.getsection("DIM")
    W, H = b2i2(dim[0:2]) * 32, b2i2(dim[2:4]) * 32
    # euddraft 의 이름표처럼: 배열이 아닌 것도 섞어 둔다 (0.81 에서 isinstance(v, EUDVArray(8)) 가 TypeError 를 내던 경로)
    EUDRegisterObjectToNamespace("QCVar", EUDVariable())
    qcarr = EUDRegisterObjectToNamespace("QCArr", EUDArray(8))
    qcvarr = EUDRegisterObjectToNamespace("QCVArr", EUDVArray(8)())
    settings = {k: v for k, v in SETTINGS.items() if array_lines or v not in ("QCArr", "QCVArr")}
    ns = {"__name__": "SNQC", "settings": settings}
    with open(plugin, encoding="utf-8") as f:
        src = f.read()
    with warnings.catch_warnings(record=True) as wlist:
        warnings.simplefilter("always")
        exec(compile(src, "SNQC.py", "exec"), ns)
        prog = emu.Program(lambda: ns["beforeTriggerExec"](), setup=lambda: ns["onPluginStart"]())
        prog.watch("KeyArray_epd", epd_of(ns["KeyArray"]))
        prog.watch("MouseArray_epd", epd_of(ns["MouseArray"]))
        for name in ("ChEPD", "MyHdr", "MyHdr2", "MyPtr", "PendOff", "PendLen", "LastPtr"):
            prog.watch(name + "_epd", epd_of(ns[name]))
        prog.watch("PB", ns["PB"])
        prog.watch("QCArr_epd", epd_of(qcarr))
        prog.watch("QCVArr_epd", epd_of(qcvarr))
        m = prog.build(work)
    epd_warn = sum(1 for w in wlist if "EPD on EPD" in str(w.message))
    print("[build] eudplib %s, plugin %s, channels %d, payload %d B, 'EPD on EPD' 경고 %d"
          % (eudplib.__version__, ns.get("SNQC_VERSION"), ns["NCh"], m.size, epd_warn))
    m.setdw(emu.FREE_UNIT, emu.CUNIT0 + emu.CUNIT_SIZE * 20)
    m.setdw(MAXBUF, 496)
    m.setdw(TURNLEN, SYNC_LEN)
    m.write_bytes(TURNBUF, b"\x37" + bytes(SYNC_LEN - 1))
    m.setdw(USERPL, LOCAL)
    m.setdw(SHARED_VIS + 4 * 1, 0x3)   # P2(만드는 쪽)의 공유 시야 - 만드는 동안 0, 뒤에 되돌림
    return World(m, ns, W, H), epd_warn


def t_keyaddr(w):
    print("[keyaddr]")
    m = w.m
    ka = addr_of_epd(m.addrs["KeyArray_epd"])
    named = {}
    for name in ("MouseArray", "ChEPD", "MyHdr", "MyHdr2", "MyPtr", "PendOff", "PendLen", "LastPtr", "QCArr"):
        named[name] = addr_of_epd(m.addrs[name + "_epd"])
    snap = m.snapshot()
    keyoffs = w.ns["KeyOffset"]
    check("KeyDown 키 5개", sorted(keyoffs) == sorted(KEYS[k] for k in ("A", "B", "F12", "`", "1")), str(sorted(keyoffs)))
    for k, off in KEYS.items():
        if off not in keyoffs:
            continue
        m.restore(snap)
        w.keys(k)
        m.writes = []
        m.cycle()
        hits = set()
        for a, mask, t in m.writes:
            # KeyUpdate 트리거: 첫 조건이 MemoryX(0x596A18 + off - off%4, Exactly, m, m)
            c0_player, c0_mask = m.dw(t + 8 + 4), m.dw(t + 8)
            if mask != emu.M32 and c0_player == (KEYSTATE + off - off % 4 - emu.EPD0) // 4 \
                    and c0_mask == 256 ** (off % 4):
                hits.add((a, mask))
        m.writes = None
        want = {(ka + 4 * (off // 32), 1 << (off % 32))}
        where = ""
        for a, _mask in hits:
            if not ka <= a < ka + 32:
                owner = [n for n, b in named.items() if b <= a < b + 32]
                where += " 밖 +%d%s" % (a - ka, " (%s 근처)" % owner[0] if owner else "")
        check("key %s(0x%02X)" % (k, off), hits == want,
              "쓴 칸 %s, 기대 %s%s" % (sorted((hex(a - ka), hex(b)) for a, b in hits),
                                      sorted((hex(a - ka), hex(b)) for a, b in want), where))
    m.restore(snap)


def _cycle_turn(w, K, per_cycle):
    """per_cycle: 사이클마다 부를 함수 목록 (길이 K). 턴을 보내고 한 사이클 더 돌려 받게 한다."""
    for f in per_cycle:
        f()
        w.m.cycle()
    got = w.flush()
    w.m.cycle()
    return got


def _array_lines(w):
    return any(isinstance(ch[2][-1], str) for ch in w.ns["channels"] if ch[0] == "val")


def t_turn1(w):
    print("[turn1] 턴 = 1사이클")
    m = w.m
    m.cycle(2)   # 채널 만들기
    ch_ptrs = [m.dw(addr_of_epd(m.addrs["MyPtr_epd"] + c)) for c in range(w.ns["NCh"])]
    check("채널 건물 만들어짐", all(ch_ptrs), str([hex(p) for p in ch_ptrs]))
    for k in ("A", "B", "F12", "`", "1"):
        w.keys(k)
        got = _cycle_turn(w, 1, [lambda: None])
        check("키 %s 들어옴" % k, w.death(LOCAL, KEY_DEATH[k]) == 1, "데스 %d" % w.death(LOCAL, KEY_DEATH[k]))
        others = [w.death(LOCAL, d) for kk, d in KEY_DEATH.items() if kk != k]
        check("키 %s 만" % k, not any(others), str(others))
        w.keys()
        _cycle_turn(w, 1, [lambda: None])
        check("키 %s 한 번만" % k, w.death(LOCAL, KEY_DEATH[k]) == 0)
    # 선택 되돌리기: 아무것도 안 골랐으면 0B 01 채널, 골랐으면 09 n 원래 선택
    alpha0 = m.dw(addr_of_epd(m.addrs["MyHdr_epd"])) >> 16
    w.keys("A")
    _cycle_turn(w, 1, [lambda: None])
    cmds = w.turn_log[-1][1]
    check("선택 없음 → 09 채널, 15, 0B 채널", [c[0] for c in cmds] == [0x09, 0x15, 0x0B]
          and cmds[0][1] == [alpha0] and cmds[2][1] == [alpha0], str(cmds))
    w.keys()
    _cycle_turn(w, 1, [lambda: None])
    m.setdw(0x6284B8, emu.CUNIT0 + emu.CUNIT_SIZE * 5)   # 유닛 칸 5 (ID 6) 를 고른 채
    w.keys("B")
    _cycle_turn(w, 1, [lambda: None])
    cmds = w.turn_log[-1][1]
    check("선택 있음 → 09 채널, 15, 09 원래 선택", [c[0] for c in cmds] == [0x09, 0x15, 0x09]
          and cmds[2][1] == [6], str(cmds))
    check("선택 있음: B 들어옴", w.death(LOCAL, 201) == 1)
    m.setdw(0x6284B8, 0)
    w.keys()
    _cycle_turn(w, 1, [lambda: None])
    # 마우스
    m.setdw(MOUSESTATE, 2)
    _cycle_turn(w, 1, [lambda: None])
    check("마우스 L 들어옴", w.death(LOCAL, 206) == 1)
    m.setdw(MOUSESTATE, 0)
    _cycle_turn(w, 1, [lambda: None])
    # 값 줄
    m.setdw(0x58F600, 123456)
    m.setdw(0x58F604, 1)
    m.setdw(0x58F608, 777)
    m.setdw(0x58F60C, 1)
    m.setdw(0x58F610, 4242)
    m.setdw(0x58F614, 1)
    _cycle_turn(w, 1, [lambda: None])
    check("값 → 데스", w.death(LOCAL, 210) == 123456, str(w.death(LOCAL, 210)))
    if not _array_lines(w):
        print("  (배열 결과 줄 뺌)")
    else:
        qa = addr_of_epd(m.addrs["QCArr_epd"])
        qv = addr_of_epd(m.addrs["QCVArr_epd"] + 87 + 18 * LOCAL)
        qv2 = addr_of_epd(m.addrs["QCVArr_epd"] + 87 + 18 * 1)
        check("값 → EUDArray[P1]", m.dw(qa + 4 * LOCAL) == 777, str(m.dw(qa + 4 * LOCAL)))
        check("값 → EUDVArray[P1]", m.dw(qv) == 4242, str(m.dw(qv)))
        check("안 받은 칸(P2)은 -1", m.dw(qa + 4 * 1) == 0xFFFFFFFF and m.dw(qv2) == 0xFFFFFFFF)
    for a in (0x58F604, 0x58F60C, 0x58F614):
        m.setdw(a, 0)
    _cycle_turn(w, 1, [lambda: None])   # 받는 사이클에 한 번 더 보낸 것이 이 턴에 온다
    _cycle_turn(w, 1, [lambda: None])
    check("값 줄 조건 거짓이면 안 보냄", w.death(LOCAL, 210) == 0)


def t_turn3(w):
    print("[turn3] 턴 = 3사이클")
    m = w.m
    m.cycle(2)
    w.flush()
    m.cycle()
    ch = w.my_channel_ptrs()

    def press(*names):
        return lambda: w.keys(*names)

    def val(v):
        def f():
            m.setdw(0x58F600, v)
            m.setdw(0x58F604, 1)
        return f

    # 사이클 1: A, 사이클 2: A 누른 채 B, 사이클 3: A·B 누른 채 (새 눌림 없음)
    got = _cycle_turn(w, 3, [press("A"), press("A", "B"), press("A", "B")])
    L, cmds = w.turn_log[-1]
    check("합치기: A 들어옴", w.death(LOCAL, 200) == 1, "데스 %d" % w.death(LOCAL, 200))
    check("합치기: B 들어옴", w.death(LOCAL, 201) == 1, "데스 %d" % w.death(LOCAL, 201))
    check("합치기: 키 채널 패킷 1개", got.get(ch[0], 0) == 1, "랠리 %d개, 턴 길이 %d" % (got.get(ch[0], 0), L))
    w.keys()
    _cycle_turn(w, 1, [lambda: None])
    # 누른 채 있는 키(KeyPress) 는 매 사이클 보내도 한 턴에 한 번
    got = _cycle_turn(w, 3, [press("C"), press("C"), press("C")])
    check("KeyPress 한 턴 한 번", w.death(LOCAL, 205) == 1 and got.get(ch[0], 0) == 1,
          "데스 %d, 패킷 %d" % (w.death(LOCAL, 205), got.get(ch[0], 0)))
    w.keys()
    _cycle_turn(w, 1, [lambda: None])
    # 값: 사이클마다 바뀌면 마지막 값, 패킷 1개
    vch = [c for c, chn in enumerate(w.ns["channels"]) if chn[0] == "val"][0]
    got = _cycle_turn(w, 3, [val(111), val(222), val(333)])
    check("값: 마지막 값", w.death(LOCAL, 210) == 333, str(w.death(LOCAL, 210)))
    check("값: 패킷 1개", got.get(ch[vch], 0) == 1, "랠리 %d개" % got.get(ch[vch], 0))
    m.setdw(0x58F604, 0)
    # 여러 채널이 섞여도: 사이클 1 값, 사이클 2 키 A, 사이클 3 값 + 키 B
    got = _cycle_turn(w, 3, [lambda: (val(5)(), w.keys()), lambda: (m.setdw(0x58F604, 0), w.keys("A")),
                             lambda: (val(6)(), w.keys("A", "B"))])
    check("섞임: A·B 들어옴", w.death(LOCAL, 200) == 1 and w.death(LOCAL, 201) == 1,
          "%d %d" % (w.death(LOCAL, 200), w.death(LOCAL, 201)))
    check("섞임: 값 6", w.death(LOCAL, 210) == 6, str(w.death(LOCAL, 210)))
    check("섞임: 채널마다 패킷 1개", got.get(ch[0], 0) == 1 and got.get(ch[vch], 0) == 1,
          "키 %d, 값 %d" % (got.get(ch[0], 0), got.get(ch[vch], 0)))
    m.setdw(0x58F604, 0)
    w.keys()


def t_stale(w):
    print("[stale] 턴이 나간 뒤 지난 자리")
    m = w.m
    m.cycle(2)
    w.flush()
    m.cycle()
    ch = w.my_channel_ptrs()
    vch = [c for c, chn in enumerate(w.ns["channels"]) if chn[0] == "val"][0]
    # 턴 1: 키 A (자리 7). 턴 2: 사이클 1 값(자리 7 - 지난 키 패킷 자리), 사이클 2 키 B → 값 패킷을 고치면 안 된다
    w.keys("A")
    _cycle_turn(w, 1, [lambda: None])
    w.keys()

    def c1():
        m.setdw(0x58F600, 99)
        m.setdw(0x58F604, 1)

    def c2():
        m.setdw(0x58F604, 0)
        w.keys("B")

    got = _cycle_turn(w, 2, [c1, c2])
    check("지난 자리: 값 99 그대로", w.death(LOCAL, 210) == 99, str(w.death(LOCAL, 210)))
    check("지난 자리: B 들어옴", w.death(LOCAL, 201) == 1)
    check("지난 자리: A 다시 안 옴", w.death(LOCAL, 200) == 0)
    check("지난 자리: 채널마다 1개", got.get(ch[0], 0) == 1 and got.get(ch[vch], 0) == 1)
    w.keys()


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("map")
    ap.add_argument("--plugin", default=os.path.join(HERE, "..", "SNQC.py"))
    ap.add_argument("--work", default=tempfile.gettempdir())
    ap.add_argument("--only", default="keyaddr,turn1,turn3,stale")
    ap.add_argument("--no-array-lines", action="store_true")
    a = ap.parse_args()
    try:
        w, _nwarn = build(os.path.abspath(a.plugin), a.map, a.work, not a.no_array_lines)
    except Exception as e:  # 빌드 실패도 결과로 적는다
        print("[build] FAIL %s: %s" % (type(e).__name__, e))
        sys.exit(1)
    check("'EPD on EPD' 경고 0", _nwarn == 0, "(%d)" % _nwarn)
    snap = w.m.snapshot()
    for name in a.only.split(","):
        w.m.restore(snap)
        w.turn_log = []
        try:
            globals()["t_" + name](w)
        except emu.EmuError as e:
            check(name + " 실행", False, str(e))
    print("RESULT %s (%d FAIL)" % ("PASS" if not failures else "FAIL", len(failures)))
    sys.exit(1 if failures else 0)


if __name__ == "__main__":
    main()
