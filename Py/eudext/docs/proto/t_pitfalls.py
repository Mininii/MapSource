"""0.76.14 함정 실험.

1. EUDVariable 변수끼리 a < b (b == 0 일 때), a > b (b == 0xFFFFFFFF 일 때)
2. EUDLightVariable -= (Subtract 액션 = 0 포화)
3. epScript 'var x = i64.Int64()' 가 번역되는 _LVAR 의 오류 문구
4. 인쇄: f_dbstr_print(x) (fmt 훅), f_sprintf("{}", x) , f_sprintf("{}", x.fmt())
5. EUDTypedFunc([Int64]) 인자
6. eps 'return a < b;' -> EUDReturn(EUDNot(a >= b))
7. 같은 Condition 객체를 두 번 쓰기
"""
import os
import sys
import tempfile
import traceback

HERE = os.path.dirname(os.path.abspath(__file__))
SCR = os.path.dirname(HERE)
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(SCR, "edtest", "shared"))
sys.dont_write_bytecode = True
tempfile.tempdir = os.path.join(SCR, "tmp")

from eudplib import *  # noqa: E402,F403
from eudplib.epscript.helper import _LVAR  # noqa: E402

import emu  # noqa: E402
from eudext.i64 import Int64  # noqa: E402

LoadMap(os.path.join(SCR, "edtest", "map", "base.scx"))
CompressPayload(True)


def attempt(label, f):
    try:
        r = f()
        print(f"[OK]   {label} -> {r!r}"[:300])
    except Exception as e:  # noqa: BLE001
        print(f"[ERR]  {label} -> {type(e).__name__}: {str(e)[:300]}")


# ---- 1, 2 : emulator
a, b = EUDVariable(), EUDVariable()
r_lt, r_gt, r_le = EUDVariable(), EUDVariable(), EUDVariable()
lv = EUDLightVariable(3)
ev = EUDVariable(3)


def body():
    for cond, r in ((a < b, r_lt), (a > b, r_gt), (a <= b, r_le)):
        if EUDIf()(cond):
            r << 1
        if EUDElse()():
            r << 0
        EUDEndIf()
    lv.__isub__(5)
    ev.__isub__(5)


p = emu.Program(body, loop=True)
for n, v in (("a", a), ("b", b), ("lt", r_lt), ("gt", r_gt), ("le", r_le)):
    p.watch(n, v.getValueAddr())
p.watch("lv", lv.getValueAddr())
p.watch("ev", ev.getValueAddr())
m = p.build()
for av, bv in ((5, 0), (5, 7), (0xFFFFFFFE, 0xFFFFFFFF), (3, 3), (0, 0)):
    m.setdw(m.addrs["a"], av)
    m.setdw(m.addrs["b"], bv)
    m.cycle()
    print("a=%#x b=%#x : a<b -> %d (정답 %d), a>b -> %d (정답 %d), a<=b -> %d" % (
        av, bv, m.var("lt"), int(av < bv), m.var("gt"), int(av > bv), m.var("le")))
    if (av, bv) == (5, 0):
        print("  EUDLightVariable(3) -= 5 ->", hex(m.var("lv")), " / EUDVariable(3) -= 5 ->", hex(m.var("ev")))


# ---- 3..7 : 컴파일 단계 오류 문구 (SaveMap 안에서)
def main():
    x = Int64(5)
    attempt("_LVAR([Int64(5)])  (eps: var q = i64.Int64(5);)", lambda: _LVAR([Int64(5)]))
    buf = DBString(64)
    attempt("f_dbstr_print(buf, x)  (fmt 훅)", lambda: f_dbstr_print(buf, x))
    attempt("f_sprintf(buf, '{}', x)", lambda: f_sprintf(buf, "{}", x))
    attempt("f_sprintf(buf, '{}', x.fmt())", lambda: f_sprintf(buf, "{}", x.fmt()))

    @EUDTypedFunc([Int64])
    def typed(v):
        return 0

    attempt("EUDTypedFunc([Int64])(x)", lambda: typed(x))

    @EUDFunc
    def ret_cond(p, q):
        EUDReturn(EUDNot(p >= q))   # eps 'return p < q;' 번역 결과

    attempt("EUDReturn(EUDNot(p >= q)) 호출", lambda: ret_cond(1, 2))

    cond = a.Exactly(3)
    attempt("같은 Condition 두 번 (1)", lambda: RawTrigger(conditions=cond))
    attempt("같은 Condition 두 번 (2)", lambda: RawTrigger(conditions=cond))


out = os.path.join(SCR, "tmp", "pitfalls.scx")
attempt("SaveMap", lambda: SaveMap(out, main))
