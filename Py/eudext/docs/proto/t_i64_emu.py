"""eudext.i64 시제품을 트리거 에뮬레이터(emu.py, DPS_eud 에서 복사)로 검사한다.

python t_i64_emu.py  -> 무작위 값으로 add/sub/비교/부호비교/32비트 부호비교 검사 + 트리거 수 측정
"""
import os
import random
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
SCR = os.path.dirname(HERE)
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(SCR, "edtest", "shared"))
sys.dont_write_bytecode = True
tempfile.tempdir = os.path.join(SCR, "tmp")
os.makedirs(tempfile.tempdir, exist_ok=True)

from eudplib import *  # noqa: E402,F403
from eudplib.core.rawtrigger.rawtriggerdef import GetTriggerCounter  # noqa: E402

import emu  # noqa: E402
from eudext import i64  # noqa: E402
from eudext.i64 import Int64  # noqa: E402

LoadMap(os.path.join(SCR, "edtest", "map", "base.scx"))
CompressPayload(True)

M64 = (1 << 64) - 1
KS = [0, 1, 0xFFFFFFFF, 0x100000000, 0x123456789, (1 << 63), M64, (1 << 63) - 1, 0xFFFFFFFF00000000]

A = Int64(0)
B = Int64(0)
x32 = EUDVariable()
y32 = EUDVariable()

outs = {}


def out(name):
    v = EUDVariable()
    outs[name] = v
    return v


def out64(name):
    v = Int64(0)
    outs[name + ".lo"] = v.lo
    outs[name + ".hi"] = v.hi
    return v


def flag_to(cond, var):
    if EUDIf()(cond):
        var << 1
    if EUDElse()():
        var << 0
    EUDEndIf()


counts = {}


def measure(name, f):
    t0 = GetTriggerCounter()
    f()
    counts[name] = GetTriggerCounter() - t0


def body():
    S = out64("add")
    D = out64("sub")
    measure("S << A + B (var)", lambda: S << A + B)
    measure("D << A - B (var)", lambda: D << A - B)
    measure("ge var (flag_to 포함)", lambda: flag_to(A >= B, out("ge")))
    flag_to(A <= B, out("le"))
    flag_to(A < B, out("lt"))
    flag_to(A > B, out("gt"))
    flag_to(A == B, out("eq"))
    flag_to(A != B, out("ne"))
    measure("sge var", lambda: flag_to(A.sge(B), out("sge")))
    measure("sge32 var", lambda: flag_to(i64.f_sge32(x32, y32), out("sge32")))
    for j, k in enumerate(KS):
        T = out64(f"addk{j}")
        measure(f"T << A; T += K{j} (const)", lambda T=T, k=k: (T.__lshift__(A), T.__iadd__(k)))
        U = out64(f"subk{j}")
        U << A
        U -= k
        measure(f"ge const K{j}", lambda j=j, k=k: flag_to(A >= k, out(f"gek{j}")))
        flag_to(A <= k, out(f"lek{j}"))
        flag_to(A.sge(k), out(f"sgek{j}"))
        flag_to(A == k, out(f"eqk{j}"))
    for j, k in enumerate([0, 5, 0x7FFFFFFF, -1, -5, -0x80000000]):
        measure(f"sge32 const {k}", lambda j=j, k=k: flag_to(i64.f_sge32(x32, k), out(f"s32k{j}")))


p = emu.Program(body)
for part, v in (("A.lo", A.lo), ("A.hi", A.hi), ("B.lo", B.lo), ("B.hi", B.hi), ("x", x32), ("y", y32)):
    p.watch(part, v.getValueAddr())
# watch 는 body 가 돌기 전에 이름이 있어야 하므로 build 안에서 outs 를 채운 뒤 등록한다
orig_build = p.build


def build_with_outs():
    # body 는 build 중에 실행되므로, _Probe 가 WritePayload 할 때 outs 가 채워져 있다
    class LazyDict(dict):
        def items(self):
            for k, v in outs.items():
                dict.__setitem__(self, k, v.getValueAddr())
            return dict.items(self)
    lazy = LazyDict(p.exprs)
    p.exprs = lazy
    return orig_build()


m = build_with_outs()


def s64(v):
    return v - (1 << 64) if v >> 63 else v


def s32(v):
    return v - (1 << 32) if v >> 31 else v


def setvar(name, value):
    m.setdw(m.addrs[name], value)


def get64(name):
    return m.var(name + ".lo") | (m.var(name + ".hi") << 32)


rng = random.Random(1234)
special = [0, 1, 0xFFFFFFFF, 1 << 32, (1 << 63) - 1, 1 << 63, M64, 0xFFFFFFFF00000000] + KS
fails = 0
N = 400
for it in range(N):
    if it < len(special) ** 2 and it < 200:
        a = special[it // len(special) % len(special)]
        b = special[it % len(special)]
    else:
        a, b = rng.getrandbits(64), rng.getrandbits(64)
        if rng.random() < 0.3:
            b = (a & 0xFFFFFFFF00000000) | rng.getrandbits(32)  # hi 같게
        if rng.random() < 0.1:
            b = a
    x, y = rng.getrandbits(32), rng.getrandbits(32)
    if rng.random() < 0.2:
        y = rng.choice([0, 0x7FFFFFFF, 0x80000000, 0xFFFFFFFF, x])
    for name, v in (("A.lo", a & 0xFFFFFFFF), ("A.hi", a >> 32), ("B.lo", b & 0xFFFFFFFF), ("B.hi", b >> 32),
                    ("x", x), ("y", y)):
        setvar(name, v)
    m.cycle()
    exp = {
        "add": (a + b) & M64, "sub": (a - b) & M64,
        "ge": int(a >= b), "le": int(a <= b), "lt": int(a < b), "gt": int(a > b),
        "eq": int(a == b), "ne": int(a != b), "sge": int(s64(a) >= s64(b)),
        "sge32": int(s32(x) >= s32(y)),
    }
    got = {"add": get64("add"), "sub": get64("sub")}
    for k in ("ge", "le", "lt", "gt", "eq", "ne", "sge", "sge32"):
        got[k] = m.var(k)
    for j, k in enumerate(KS):
        exp[f"addk{j}"] = (a + k) & M64
        exp[f"subk{j}"] = (a - k) & M64
        exp[f"gek{j}"] = int(a >= k)
        exp[f"lek{j}"] = int(a <= k)
        exp[f"sgek{j}"] = int(s64(a) >= s64(k))
        exp[f"eqk{j}"] = int(a == k)
        got[f"addk{j}"] = get64(f"addk{j}")
        got[f"subk{j}"] = get64(f"subk{j}")
        for n in ("gek", "lek", "sgek", "eqk"):
            got[f"{n}{j}"] = m.var(f"{n}{j}")
    for j, k in enumerate([0, 5, 0x7FFFFFFF, -1, -5, -0x80000000]):
        exp[f"s32k{j}"] = int(s32(x) >= k)
        got[f"s32k{j}"] = m.var(f"s32k{j}")
    bad = {k: (hex(got[k]), hex(exp[k])) for k in exp if got[k] != exp[k]}
    if bad:
        fails += 1
        if fails <= 5:
            print("FAIL a=%#x b=%#x x=%#x y=%#x" % (a, b, x, y), bad)

print("cases", N, "fails", fails, "steps/cycle avg", m.steps // N)
print("trigger counts (호출 자리에서 새로 생긴 트리거 수; 함수 본문은 첫 호출 때 한 번만 포함):")
for k, v in counts.items():
    print("  %-40s %d" % (k, v))
for f in (i64._add64, i64._sub64, i64._geu64, i64._ges64):
    print("  EUDFunc %-10s size() = %s" % (f.__name__, f.size()))
print("emu log (unknown cond/act):", m.log[:5])
