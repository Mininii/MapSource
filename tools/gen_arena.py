"""Generate the arena terrain, compute the distance field from the fortress,
and render both for inspection."""
import sys, os, struct, time, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from arena import Arena, WATER, LOW, HIGH, PASSABLE
from profile import load_profile
from terrain import TerrainBuilder
from walk import WalkGrid
from render import render
import png

TABLES = {7: "work/isom_twilight.pkl", 4: "work/isom_jungle.pkl"}
TABLE = TABLES[7]


def build(seed=7, pin_radius=2, log=print, era=7):
    table = TABLES[era]
    prof = load_profile(era, table, log=lambda s: None)
    ar = Arena(seed=1700 + seed * 37, profile=prof)
    tb = TerrainBuilder(ar.w, ar.h, table, era=era, seed=seed, low_types=ar.PASSABLE)
    grid = ar.grid()
    tb.set_region(lambda ix, iy: grid[iy][ix])
    tb.set_protected(lambda ix, iy: any(
        ar.in_rect(ix, iy, r, pad=ar.room_wall + 1) for r in (ar.control_room, ar.boss_island)))
    t0 = time.time()
    ok = False
    for pr in (pin_radius, pin_radius + 1, pin_radius + 2):
        ok = tb.build(pin_radius=pr, log=log)
        if ok:
            if pr != pin_radius:
                log("terrain needed a looser pin radius (%d)" % pr)
            break
    log("wfc solved=%s %.1fs" % (ok, time.time() - t0))
    if not ok:
        return None, None, None
    tiles, missing = tb.tiles()
    log("missing table entries: %d" % len(missing))
    return ar, tb, tiles


def distances(ar, tiles, era=7):
    wg = WalkGrid(tiles, ar.w, ar.h, era)
    clear = wg.clearance(2)
    # fortress centre in minitiles: cell (fx, fy) -> tile (2*fx, fy)
    tx, ty = ar.fx * 2, ar.fy
    cx, cy = tx * 4 + 2, ty * 4 + 2
    starts = [(cx + dx, cy + dy) for dx in range(-6, 7) for dy in range(-6, 7)]
    dist = wg.bfs(starts, clear)
    return wg, clear, dist


def render_dist(wg, dist, path, sc=2):
    MW, MH = wg.MW, wg.MH
    maxd = max([d for d in dist if d >= 0] or [1])
    OW, OH = MW // sc, MH // sc
    rows = []
    for y in range(OH):
        row = bytearray()
        for x in range(OW):
            best = -1
            walk = 0
            for dy in range(sc):
                for dx in range(sc):
                    i = (y * sc + dy) * MW + x * sc + dx
                    walk |= wg.walk[i]
                    if dist[i] >= 0 and (best < 0 or dist[i] < best):
                        best = dist[i]
            if best >= 0:
                f = min(1.0, best / maxd)
                row += bytes((int(30 + 220 * f), int(230 - 180 * f), 60))
            elif walk:
                row += bytes((110, 110, 130))
            else:
                row += bytes((18, 26, 45))
        rows.append(bytes(row))
    png.write_rgb(path, OW, OH, rows)
    return maxd


if __name__ == "__main__":
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 7
    ar, tb, tiles = build(seed)
    if tiles is None:
        sys.exit("wfc failed")
    mtxm = struct.pack("<%dH" % len(tiles), *tiles)
    open("work/arena.mtxm", "wb").write(mtxm)
    open("work/arena.isom", "wb").write(tb.isom_bytes())
    render(None, "work/arena_terrain.png", 4, mtxm=mtxm, dims=(ar.w, ar.h), era=7)
    wg, clear, dist = distances(ar, tiles)
    maxd = render_dist(wg, dist, "work/arena_dist.png")
    reach = sum(1 for d in dist if d >= 0)
    print("max reachable distance: %d minitiles (%d tiles)" % (maxd, maxd // 4))
    print("reachable minitiles: %d of %d" % (reach, wg.MW * wg.MH))
