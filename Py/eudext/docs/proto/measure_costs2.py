"""Measure trigger counts (EUDFuncN.size) and emulator steps of reusable routines in DPS_eud/eud/ctrig.
Read-only w.r.t. the repo: only imports modules. Output files go to TEMP (redirected to scratchpad by caller)."""
import os
import sys

EUD = r"C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2\DPS_eud\eud"
sys.path.insert(0, os.path.join(EUD, "tests"))
sys.path.insert(0, EUD)
for s in (sys.stdout, sys.stderr):
    s.reconfigure(encoding="utf-8", errors="replace")

from eudplib import *  # noqa
import emu  # noqa
from ctrig import war, text, arrays, arith  # noqa

BASEMAP = os.path.join(os.path.dirname(EUD), "DPS_headless.scx")
LoadMap(BASEMAP)
CompressPayload(True)

# ---- 1. static trigger counts ----
funcs = {
    "war._add64": war._add64, "war._neg64": war._neg64, "war._subwrap64": war._subwrap64,
    "war._subsat64": war._subsat64, "war._mul64": war._mul64, "war._div6432": war._div6432,
    "war._div64big": war._div64big, "war._divmod64": war._divmod64, "war._rand64": war._rand64,
    "text._itodec16": text._itodec16, "text._itodec48": text._itodec48, "text._itohex12": text._itohex12,
    "text._lidec_body": text._lidec_body, "arith._swrand": arith._swrand,
}

sizes = {}


def body_sizes():
    for k, f in funcs.items():
        try:
            sizes[k] = f.size()
        except Exception as e:  # noqa
            sizes[k] = "ERR %s" % e


# ---- 2. runtime steps per call (emulator) ----
M32 = 0xFFFFFFFF
cases = []  # (name, fn(inputs vars)->outputs, inputs)
A, B, C, D = EUDCreateVariables(4)
outs = [EUDVariable() for _ in range(5)]
mode = EUDVariable()


def split(n):
    return n & M32, n >> 32


def body():
    body_sizes() if not sizes else None
    # mode selects which routine runs this cycle; A..D inputs set by Machine before cycle
    if EUDIf()(mode == 0):
        pass
    if EUDElseIf()(mode == 1):
        r = war._mul64(A, B, C, D)
        outs[0] << r[0]; outs[1] << r[1]
    if EUDElseIf()(mode == 2):
        r = war._divmod64(A, B, C, D)
        outs[0] << r[0]; outs[1] << r[1]; outs[2] << r[2]; outs[3] << r[3]
    if EUDElseIf()(mode == 3):
        r = war._add64(A, B, C, D)
        outs[0] << r[0]; outs[1] << r[1]
    if EUDElseIf()(mode == 4):
        r = text._itodec16(A)
        outs[0] << r[0]; outs[1] << r[1]; outs[2] << r[2]
    if EUDElseIf()(mode == 5):
        r = text._lidec_body(A, B)
        for i in range(5):
            outs[i] << r[i]
    if EUDElseIf()(mode == 6):
        q, rr = f_div(A, C)
        outs[0] << q; outs[1] << rr
    if EUDElseIf()(mode == 8):
        outs[0] << f_mul(A, C)
    if EUDElseIf()(mode == 7):
        r = war._subsat64(A, B, C, D)
        outs[0] << r[0]; outs[1] << r[1]
    EUDEndIf()


p = emu.Program(body)
for n, v in (("A", A), ("B", B), ("C", C), ("D", D), ("mode", mode)):
    p.watch(n, v.getValueAddr())
for i, v in enumerate(outs):
    p.watch("o%d" % i, v.getValueAddr())
m = p.build()


def run(md, a=0, b=0, c=0, d=0):
    m.setdw(m.addrs["mode"], 0)
    m.cycle(1)
    base = m.steps
    m.cycle(1)
    idle = m.steps - base
    for n, v in (("A", a), ("B", b), ("C", c), ("D", d), ("mode", md)):
        m.setdw(m.addrs[n], v)
    s0 = m.steps
    m.cycle(1)
    used = m.steps - s0 - idle
    o = [m.var("o%d" % i) for i in range(5)]
    return used, o


print("== EUDFuncN.size() (triggers in body) ==")
for k, v in sizes.items():
    print("  %-18s %s" % (k, v))

print("== emulator steps per call (minus idle cycle) ==")
x, y = 0xFFFFFFFFFFFFFFFF, 0xFFFFFFFFFFFFFFFF
st, o = run(1, *split(x), *split(y))
print("  mul64 all-ones      steps=%d ok=%s" % (st, (o[0] | o[1] << 32) == (x * y) & 0xFFFFFFFFFFFFFFFF))
x, y = 0x123456789, 3
st, o = run(1, *split(x), *split(y))
print("  mul64 small         steps=%d ok=%s" % (st, (o[0] | o[1] << 32) == (x * y) & 0xFFFFFFFFFFFFFFFF))
for x, y, label in ((1000, 7, "32/32"), (0xFFFFFFFFFFFFFFFF, 10, "64/32"), (0xFEDCBA9876543210, 0x123456789, "64/64"),
                    (5, 0, "div0"), (0x7FFFFFFFFFFFFFFF, 0x8000000000000000, "n<d")):
    st, o = run(2, *split(x), *split(y))
    q = o[0] | o[1] << 32
    r = o[2] | o[3] << 32
    want = (x // y, x % y) if y else (0xFFFFFFFFFFFFFFFF, x)
    print("  divmod64 %-10s steps=%d ok=%s" % (label, st, (q, r) == want))
st, o = run(3, *split(0xFFFFFFFF), *split(1))
print("  add64               steps=%d ok=%s" % (st, (o[0] | o[1] << 32) == 0x100000000))
st, o = run(7, *split(0x1234567800000000), *split(0x0000000100000001))
print("  subsat64            steps=%d ok=%s" % (st, (o[0] | o[1] << 32) == 0x1234567800000000 - 0x0000000100000001))
st, o = run(6, 0xFFFFFFFF, 0, 10, 0)
print("  eudplib f_div 32    steps=%d ok=%s" % (st, o[0] == 0xFFFFFFFF // 10))
for v in (0, 5, 0xFFFFFFFB, 2147483647):
    st, o = run(4, v)
    bs = b"".join(x.to_bytes(4, "little") for x in (0x0D0D0D0D, o[0], o[1], o[2]))
    print("  itodec16 %-10d steps=%d bytes=%r" % (v, st, bs))
for v in (0, 12345678901234, 0xFFFFFFFFFFFFFFFF, 0x8000000000000000):
    st, o = run(5, *split(v))
    bs = b"".join(x.to_bytes(4, "little") for x in o[:5])
    print("  lidec    %-20d steps=%d bytes=%r" % (v, st, bs))
for a_, c_ in ((0xFFFFFFFF, 0xFFFFFFFF), (12345, 678), (3, 0xFFFFFFFF)):
    st, o = run(8, a_, 0, c_, 0)
    print("  eudplib f_mul var*var %08X*%08X steps=%d ok=%s" % (a_, c_, st, o[0] == (a_ * c_) & M32))
print("unknown cond/act kinds:", sorted({x[:2] for x in m.log})[:10])
