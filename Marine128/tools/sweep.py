"""Try arena ridge configurations and report reachability / walking distance."""
import sys, os, struct, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import arena as arena_mod
from arena import Arena, PASSABLE
from terrain import TerrainBuilder
from walk import WalkGrid

TABLE = "work/isom_twilight.pkl"

CONFIGS = [
    ("3 staggered (current)", [(15, 5), (40, 5), (68, 5)],
     [[(16, 24), (40, 48)], [(3, 11), (51, 59)], [(27, 35)]]),
    ("3 narrow gaps", [(15, 5), (40, 5), (68, 5)],
     [[(17, 23), (41, 47)], [(4, 10), (52, 58)], [(29, 35)]]),
    ("4 staggered", [(15, 5), (34, 5), (54, 5), (76, 5)],
     [[(16, 24), (40, 48)], [(3, 11), (51, 59)], [(27, 35)], [(6, 14), (48, 56)]]),
    ("4 single-gap zigzag", [(15, 5), (34, 5), (54, 5), (76, 5)],
     [[(16, 24), (40, 48)], [(48, 58)], [(6, 16)], [(44, 54)]]),
    ("5 staggered", [(15, 5), (31, 5), (48, 5), (65, 5), (84, 5)],
     [[(16, 24), (40, 48)], [(4, 12), (52, 60)], [(27, 35)], [(6, 14), (50, 58)], [(26, 34)]]),
]


def run(name, rings, gaps, seed=7):
    ar = Arena()
    ar.rings = rings
    ar.ring_gaps = gaps
    grid = ar.grid()
    tb = TerrainBuilder(ar.w, ar.h, TABLE, era=7, seed=seed, low_types=PASSABLE)
    tb.set_region(lambda ix, iy: grid[iy][ix])
    if not tb.build(pin_radius=2, log=lambda s: None):
        print("%-22s WFC FAILED" % name)
        return
    tiles, missing = tb.tiles()
    wg = WalkGrid(tiles, ar.w, ar.h, 7)
    clear = wg.clearance(2)
    tx, ty = ar.fx * 2, ar.fy
    cx, cy = tx * 4 + 2, ty * 4 + 2
    starts = [(cx + dx, cy + dy) for dx in range(-6, 7) for dy in range(-6, 7)]
    dist = wg.bfs(starts, clear)
    ds = sorted(d for d in dist if d >= 0)
    if not ds:
        print("%-22s no reachable area" % name)
        return
    n = len(ds)
    print("%-22s reach=%-7d (%.0f%%) max=%-5d p90=%-5d median=%-5d"
          % (name, n, 100.0 * n / (wg.MW * wg.MH), ds[-1], ds[int(n * 0.9)], ds[n // 2]))


if __name__ == "__main__":
    for (name, rings, gaps) in CONFIGS:
        run(name, rings, gaps)
