"""Verify the ISOM encoding model:
   cell(ix,iy) = (left, top, right, bottom); value = (type<<4) | (shape<<1)
   shape depends only on (ix+iy) parity:
       even -> l=4, t=5, r=0, b=1     (offsets  8, 10,  0,  2)
       odd  -> l=2, t=6, r=7, b=3     (offsets  4, 12, 14,  6)
   and neighbouring cells share side types:
       cell(ix,iy).right  == cell(ix+1,iy).left
       cell(ix,iy).bottom == cell(ix,iy+1).top
"""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from isom_table import load_map

EVEN = (8, 10, 0, 2)
ODD = (4, 12, 14, 6)


def verify(path):
    m = load_map(path)
    if not m:
        return None
    iw, ih, cells = m["iw"], m["ih"], m["cells"]
    shape_ok = shape_bad = 0
    share_ok = share_bad = 0
    badshapes = collections.Counter()
    for iy in range(ih):
        for ix in range(iw):
            cl = cells[iy * iw + ix]
            exp = EVEN if (ix + iy) % 2 == 0 else ODD
            for k in range(4):
                if (cl[k] & 0xF) == exp[k]:
                    shape_ok += 1
                else:
                    shape_bad += 1
                    badshapes[(ix + iy) % 2, k, cl[k] & 0xF] += 1
            if ix + 1 < iw:
                r = cl[2] >> 4
                l = cells[iy * iw + ix + 1][0] >> 4
                share_ok += (r == l); share_bad += (r != l)
            if iy + 1 < ih:
                b = cl[3] >> 4
                t = cells[(iy + 1) * iw + ix][1] >> 4
                share_ok += (b == t); share_bad += (b != t)
    return dict(map=os.path.basename(path), w=m["w"], h=m["h"], era=m["era"],
                shape_ok=shape_ok, shape_bad=shape_bad,
                share_ok=share_ok, share_bad=share_bad, badshapes=badshapes)


if __name__ == "__main__":
    tot = collections.Counter()
    allbad = collections.Counter()
    for p in sys.argv[1:]:
        try:
            r = verify(p)
        except Exception as e:
            print("skip", p, e)
            continue
        if not r:
            continue
        tot["shape_ok"] += r["shape_ok"]; tot["shape_bad"] += r["shape_bad"]
        tot["share_ok"] += r["share_ok"]; tot["share_bad"] += r["share_bad"]
        tot["maps"] += 1
        allbad.update(r["badshapes"])
        print("%-40s %3dx%-3d era=%d shape %d/%d  share %d/%d" % (
            r["map"][:40], r["w"], r["h"], r["era"],
            r["shape_ok"], r["shape_ok"] + r["shape_bad"],
            r["share_ok"], r["share_ok"] + r["share_bad"]))
    print("TOTAL maps=%d shape %.6f  share %.6f" % (
        tot["maps"], tot["shape_ok"] / max(1, tot["shape_ok"] + tot["shape_bad"]),
        tot["share_ok"] / max(1, tot["share_ok"] + tot["share_bad"])))
    if allbad:
        print("bad shapes:", allbad.most_common(10))
