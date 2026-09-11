"""Compare the intended region grid with what WFC actually produced."""
import sys, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from arena import Arena, WATER, LOW, HIGH, MUD
from terrain import TerrainBuilder
import png

BASE = {LOW, HIGH, WATER, MUD}
NAME = {LOW: "low", HIGH: "high", WATER: "water", MUD: "mud"}


def actual_type(tb, ix, iy):
    """Majority base type among the cell's four side types; None if it is a
    transition cell."""
    c = collections.Counter(t for t in tb.cell_types(ix, iy) if t in BASE)
    if not c:
        return None
    t, n = c.most_common(1)[0]
    return t if n >= 3 else None


def compare(ar, tb, grid, out=None):
    same = diff = trans = 0
    conf = collections.Counter()
    rows = []
    SC = 4
    for iy in range(ar.ih):
        row = bytearray()
        for ix in range(ar.iw):
            want = grid[iy][ix]
            got = actual_type(tb, ix, iy)
            if got is None:
                trans += 1
                col = (90, 90, 90)
            elif got == want:
                same += 1
                col = {LOW: (70, 110, 60), HIGH: (150, 180, 120),
                       WATER: (20, 40, 90), MUD: (120, 100, 60)}[want]
            else:
                diff += 1
                conf[(NAME.get(want, want), NAME.get(got, got))] += 1
                col = (230, 40, 40)
            row += bytes(col) * SC * 2
        for _ in range(SC):
            rows.append(bytes(row))
    tot = same + diff + trans
    print("cells %d  match=%.1f%%  mismatch=%.1f%%  transition=%.1f%%" % (
        tot, 100.0 * same / tot, 100.0 * diff / tot, 100.0 * trans / tot))
    for k, v in conf.most_common(8):
        print("   wanted %-6s got %-6s  %d" % (k[0], k[1], v))
    if out:
        png.write_rgb(out, ar.iw * SC * 2, ar.ih * SC, rows)
        print("wrote", out)


if __name__ == "__main__":
    from gen_arena import build
    ar, tb, tiles = build(int(sys.argv[1]) if len(sys.argv) > 1 else 7)
    if tb is None:
        sys.exit("wfc failed")
    compare(ar, tb, ar.grid(), "work/fidelity.png")
