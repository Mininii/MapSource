"""부작용(앞 계산)이 있는 조건이 EUDWhile / EUDSCAnd / EUDSCOr 안에서 매번 다시 계산되는지."""
import os
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
SCR = os.path.dirname(HERE)
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(SCR, "edtest", "shared"))
sys.dont_write_bytecode = True
tempfile.tempdir = os.path.join(SCR, "tmp")

from eudplib import *  # noqa: E402,F403

import emu  # noqa: E402
from eudext.i64 import Int64  # noqa: E402

LoadMap(os.path.join(SCR, "edtest", "map", "base.scx"))
CompressPayload(True)

A = Int64(0)
n = EUDVariable()
m1 = EUDVariable()
m2 = EUDVariable()
z = EUDVariable()


def body():
    global A, n  # 파이썬 함수 안의 A += 1 은 전역 선언 필요 (eps 는 __iadd__ 로 번역하므로 무관)
    A << 0xFFFFFFF0         # 경계 넘기 (hi 올림 포함)
    n << 0
    if EUDWhile()(A < 0x100000005):          # 부작용 조건 (Int64 상수 비교 = 트리거 3개 + 플래그)
        A += 1
        n += 1
    EUDEndWhile()
    # epScript 가 만드는 모양 그대로: a < b && c
    if EUDIf()(EUDSCAnd()(A >= 0x100000005)(z == 0)()):
        m1 << 1
    EUDEndIf()
    if EUDIf()(EUDSCOr()(z == 1)(A >= 0x100000006, neg=True)()):
        m2 << 1
    EUDEndIf()


p = emu.Program(body, loop=True)
p.watch("n", n.getValueAddr())
p.watch("m1", m1.getValueAddr())
p.watch("m2", m2.getValueAddr())
p.watch("lo", A.lo.getValueAddr())
p.watch("hi", A.hi.getValueAddr())
mm = p.build()
mm.cycle()
print("while 반복 수 n =", mm.var("n"), "(정답 21)", "A = %#x" % (mm.var("lo") | mm.var("hi") << 32))
print("SCAnd m1 =", mm.var("m1"), "(정답 1)  SCOr(neg) m2 =", mm.var("m2"), "(정답 1)")
