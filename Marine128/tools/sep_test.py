"""Measure the minimum LOW separation the tileset needs between two region types."""
import sys, os, random
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from terrain import TerrainBuilder

W = H = 64
TABLE = "work/isom_twilight.pkl"
NAMES = {1: "dirt", 2: "high", 3: "water", 4: "mud", 9: "t9", 11: "t11", 13: "t13"}


def trial(a, b, sep, pin_radius=2, seed=3):
    tb = TerrainBuilder(W, H, TABLE, era=7, seed=seed)
    mid = tb.ih // 2

    def region(ix, iy):
        if iy < mid - sep // 2 - 8:
            return a
        if iy < mid - (sep - sep // 2):
            return a
        if iy < mid + sep - (sep - sep // 2):
            return 1
        return b
    tb.set_region(lambda ix, iy: region(ix, iy))
    ok = tb.build(pin_radius=pin_radius, log=lambda s: None)
    return bool(ok)


if __name__ == "__main__":
    pairs = [(2, 3), (2, 4), (3, 4), (2, 9), (1, 2), (1, 3), (1, 4), (4, 3)]
    for (a, b) in pairs:
        line = []
        for sep in range(0, 8):
            line.append("%d:%s" % (sep, "Y" if trial(a, b, sep) else "."))
        print("%-6s vs %-6s  %s" % (NAMES.get(a, a), NAMES.get(b, b), "  ".join(line)))
