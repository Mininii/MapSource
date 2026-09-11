"""Try arena ridge configurations and report reachability / walking distance."""
import sys, os, struct, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import arena as arena_mod
from arena import Arena
from terrain import TerrainBuilder
from walk import WalkGrid

TABLE = "work/isom_twilight.pkl"

CONFIGS = [
    ("2 ridges (current)", [(15, 5), (46, 5)],
     [[(15, 21), (43, 49)], [(6, 12), (29, 36), (52, 58)]]),
    ("3 ridges", [(15, 5), (40, 5), (68, 5)],
     [[(15, 21), (43, 49)], [(8, 14), (46, 52)], [(24, 30), (54, 60)]]),
    ("3 ridges, staggered", [(15, 5), (40, 5), (68, 5)],
     [[(17, 23), (41, 47)], [(4, 10), (52, 58)], [(28, 34)]]),
    ("4 ridges", [(15, 5), (34, 5), (55, 5), (78, 5)],
     [[(15, 21), (43, 49)], [(6, 12), (50, 56)], [(28, 34)], [(8, 14), (50, 56)]]),
]


def run(name, rings, gaps, seed=7):
    ar = Arena()
    ar.rings = rings
    ar.ring_gaps = gaps
    grid = ar.grid()
    tb = TerrainBuilder(ar.w, ar.h, TABLE, era=7, seed=seed)
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
    print("%-22s reach=%-7d max=%-5d p90=%-5d median=%-5d missing=%d"
          % (name, n, ds[-1], ds[int(n * 0.9)], ds[n // 2], len(missing)))


if __name__ == "__main__":
    for (name, rings, gaps) in CONFIGS:
        run(name, rings, gaps)
