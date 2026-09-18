"""Try layout variants and report how open the resulting map actually is."""
import sys, os, struct, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from arena import Arena
from terrain import TerrainBuilder
from walk import WalkGrid
from profile import load_profile

TABLE = "work/isom_twilight.pkl"


def measure(name, tweak, seed=19, log=print):
    prof = load_profile(7, TABLE, log=lambda s: None)
    ar = Arena(seed=1700 + seed * 37, profile=prof)
    tweak(ar)
    grid = ar.grid()
    tb = TerrainBuilder(ar.w, ar.h, TABLE, era=7, seed=seed, low_types=ar.PASSABLE)
    tb.set_region(lambda ix, iy: grid[iy][ix])
    tb.set_protected(lambda ix, iy: any(
        ar.in_rect(ix, iy, r, pad=ar.room_wall + 1) for r in (ar.control_room, ar.boss_island)))
    t0 = time.time()
    ok = False
    for pr in (2, 3, 4):
        ok = tb.build(pin_radius=pr, log=lambda s: None)
        if ok:
            break
    if not ok:
        log("%-26s WFC FAILED" % name)
        return None
    tiles, _ = tb.tiles()
    wg = WalkGrid(tiles, ar.w, ar.h, 7)
    clear = wg.clearance(2)
    cx, cy = ar.fx * 2 * 4 + 4, ar.fy * 4 + 2
    dist = wg.bfs([(cx + dx, cy + dy) for dx in range(-6, 7) for dy in range(-6, 7)], clear)
    ds = sorted(d for d in dist if d >= 0)
    if not ds:
        log("%-26s no reachable area" % name)
        return None
    # rooms must stay sealed
    leaks = []
    for nm, rect in (("menu", ar.control_room), ("boss", ar.boss_island)):
        mx = ((rect[0] + rect[2]) // 2) * 2 * 4 + 4
        my = ((rect[1] + rect[3]) // 2) * 4 + 2
        if dist[my * wg.MW + mx] >= 0:
            leaks.append(nm)
    n = len(ds)
    log("%-26s open=%2.0f%%  max=%-4d p90=%-4d  %s  %.0fs"
        % (name, 100.0 * n / (wg.MW * wg.MH), ds[-1], ds[int(n * 0.9)],
           ("LEAK:" + ",".join(leaks)) if leaks else "sealed", time.time() - t0))
    return n, ds[-1]


def base(ar):
    pass


def rooms_small(ar):
    ar.control_room = (4, 6, 14, 21)
    ar.boss_island = (50, 6, 60, 21)
    ar.room_wall = 5


def fewer_blobs(ar):
    ar.blobs = [(12, 93, 8), (50, 90, 7), (23, 80, 7), (42, 76, 6), (9, 68, 7),
                (56, 71, 7), (19, 38, 8), (46, 40, 7), (30, 28, 6), (13, 114, 6)]


def two_ridges(ar):
    ar.rings = [(13, 5), (48, 5)]
    ar.ring_gaps = [[(16, 24), (40, 48)], [(3, 12), (28, 37), (52, 61)]]


def combo(ar):
    rooms_small(ar)
    fewer_blobs(ar)


def combo2(ar):
    rooms_small(ar)
    fewer_blobs(ar)
    two_ridges(ar)


def combo3(ar):
    rooms_small(ar)
    fewer_blobs(ar)
    two_ridges(ar)
    ar.fy = 114
    ar.bx, ar.by = 2, 3


if __name__ == "__main__":
    for nm, fn in (("baseline", base), ("small rooms", rooms_small),
                   ("10 big blobs", fewer_blobs), ("2 ridges", two_ridges),
                   ("rooms+blobs", combo), ("rooms+blobs+ridges", combo2),
                   ("all + low fortress", combo3)):
        measure(nm, fn)
