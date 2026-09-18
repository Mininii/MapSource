"""Recover the side-type field of a real map and print a neighbourhood."""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from isom_table import load_map


def sides_of(m):
    iw, ih, cells = m["iw"], m["ih"], m["cells"]
    V = [[None] * (iw + 1) for _ in range(ih)]
    H = [[None] * iw for _ in range(ih + 1)]
    for iy in range(ih):
        for ix in range(iw):
            l, t, r, b = (v >> 4 for v in cells[iy * iw + ix])
            V[iy][ix] = l
            V[iy][ix + 1] = r
            H[iy][ix] = t
            H[iy + 1][ix] = b
    return V, H


def main(path, cx, cy, rad):
    m = load_map(path)
    V, H = sides_of(m)
    iw, ih = m["iw"], m["ih"]
    print("map %dx%d isom %dx%d era %d" % (m["w"], m["h"], iw, ih, m["era"]))
    print("\n-- interleaved side field (rows = isom rows; H above each cell, V between) --")
    for iy in range(max(0, cy - rad), min(ih, cy + rad)):
        hrow = "      " + " ".join("%4d" % H[iy][ix] for ix in range(max(0, cx - rad), min(iw, cx + rad)))
        vrow = "%4d: " % iy + " ".join("%4d" % V[iy][ix] for ix in range(max(0, cx - rad), min(iw + 1, cx + rad)))
        print(hrow)
        print(vrow)
    print("\n-- type histogram --")
    c = collections.Counter()
    for row in V:
        c.update(x for x in row if x is not None)
    for row in H:
        c.update(x for x in row if x is not None)
    print(c.most_common(25))


if __name__ == "__main__":
    main(sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]) if len(sys.argv) > 4 else 8)
