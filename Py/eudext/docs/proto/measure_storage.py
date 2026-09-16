"""Payload size of 1700*6 per-unit slots: VarBlock (EUDVarBuffer, 72B/slot) vs EUDArray (4B/slot).
Imports repo modules read-only; writes maps only under TEMP (scratchpad)."""
import os
import sys
import tempfile

EUD = r"C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2\DPS_eud\eud"
sys.path.insert(0, EUD)
for s in (sys.stdout, sys.stderr):
    s.reconfigure(encoding="utf-8", errors="replace")

import eudplib as ep  # noqa
from eudplib.core.variable.vbuf import EUDVarBuffer  # noqa

BASEMAP = os.path.join(os.path.dirname(EUD), "DPS_headless.scx")
N = 1700 * 6


def build(kind, compress):
    ep.LoadMap(BASEMAP)
    ep.CompressPayload(compress)
    out = os.path.join(tempfile.gettempdir(), "stor_%s_%d.scx" % (kind, compress))

    def main():
        v = ep.EUDVariable()
        if kind == "vbuf":
            buf = EUDVarBuffer()
            buf._initvals.extend([0] * N)
            v << ep.EPD(buf + 72 * 17 + 348)
        elif kind == "array":
            arr = ep.EUDArray(N)
            v << ep.EPD(arr)
        ep.DoActions(v.SetNumber(0))

    ep.SaveMap(out, main)
    return os.path.getsize(out)


import io, contextlib  # noqa
res = {}
for compress in (True,):
    for kind in ("none", "vbuf", "array"):
        f = io.StringIO()
        with contextlib.redirect_stdout(f):
            res[(kind, compress)] = build(kind, compress)
for compress in (True,):
    base = res[("none", compress)]
    print("CompressPayload=%s  base=%d  vbuf(+%d)  EUDArray(+%d)" % (
        compress, base, res[("vbuf", compress)] - base, res[("array", compress)] - base))
