"""Where is the playable floor, and where is nothing happening on it?

Reports how much of the reachable floor is covered by locations / preplaced
units, and finds the largest stretches of open ground that nothing uses.
"""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from walk import from_chk
from units import parse_units
import png

HP1 = 1


def analyse(chk_path, out_png=None, cell=4):
    c = CHK(open(chk_path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    wg = from_chk(c)
    clear = wg.clearance(2)
    m = c.get("MRGN")
    L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, 0)
    cx, cy = ((L + R) // 2) // 8, ((T + B) // 2) // 8
    dist = wg.bfs([(cx + dx, cy + dy) for dx in range(-8, 9) for dy in range(-8, 9)], clear)
    MW = wg.MW

    # per tile: reachable?  covered by a location?  has a unit nearby?
    reach = [[False] * w for _ in range(h)]
    for ty in range(h):
        for tx in range(w):
            i = (ty * 4 + 2) * MW + tx * 4 + 2
            reach[ty][tx] = dist[i] >= 0
    loc = [[False] * w for _ in range(h)]
    nloc = 0
    for i in range(len(m) // 20):
        a, b2, c2, d2, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        if (a, b2, c2, d2) == (0, 0, 0, 0) or (c2 - a) > 3000 or (d2 - b2) > 3000:
            continue
        nloc += 1
        for ty in range(max(0, b2 // 32), min(h, d2 // 32 + 1)):
            for tx in range(max(0, a // 32), min(w, c2 // 32 + 1)):
                loc[ty][tx] = True
    units = parse_units(c.get("UNIT"))
    unit = [[0] * w for _ in range(h)]
    for u in units:
        tx, ty = u["x"] // 32, u["y"] // 32
        if 0 <= tx < w and 0 <= ty < h:
            unit[ty][tx] += 1

    # distance from every reachable tile to the nearest location rectangle
    INF = 10 ** 6
    d2loc = [[0 if loc[ty][tx] else INF for tx in range(w)] for ty in range(h)]
    for ty in range(h):
        for tx in range(w):
            v = d2loc[ty][tx]
            if ty:
                v = min(v, d2loc[ty - 1][tx] + 1)
            if tx:
                v = min(v, d2loc[ty][tx - 1] + 1)
            d2loc[ty][tx] = v
    for ty in range(h - 1, -1, -1):
        for tx in range(w - 1, -1, -1):
            v = d2loc[ty][tx]
            if ty + 1 < h:
                v = min(v, d2loc[ty + 1][tx] + 1)
            if tx + 1 < w:
                v = min(v, d2loc[ty][tx + 1] + 1)
            d2loc[ty][tx] = v

    nreach = sum(1 for r in reach for v in r if v)
    ncov = sum(1 for ty in range(h) for tx in range(w) if reach[ty][tx] and loc[ty][tx])
    far = [(d2loc[ty][tx], tx, ty) for ty in range(h) for tx in range(w)
           if reach[ty][tx] and d2loc[ty][tx] >= 6]
    far.sort(reverse=True)
    print("map %dx%d  reachable floor %d tiles (%.0f%% of map)" % (
        w, h, nreach, 100.0 * nreach / (w * h)))
    print("locations: %d, covering %d reachable tiles (%.0f%% of the floor)" % (
        nloc, ncov, 100.0 * ncov / max(1, nreach)))
    print("floor more than 6 tiles from any location: %d tiles (%.0f%% of the floor)" % (
        len(far), 100.0 * len(far) / max(1, nreach)))
    # cluster the far tiles into blobs so we can name the empty pockets
    seen = set()
    blobs = []
    farset = {(tx, ty) for (_, tx, ty) in far}
    for (dd, tx, ty) in far:
        if (tx, ty) in seen:
            continue
        q = [(tx, ty)]
        seen.add((tx, ty))
        cells = []
        while q:
            x, y = q.pop()
            cells.append((x, y))
            for nx, ny in ((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)):
                if (nx, ny) in farset and (nx, ny) not in seen:
                    seen.add((nx, ny))
                    q.append((nx, ny))
        if len(cells) >= 12:
            xs = [p[0] for p in cells]
            ys = [p[1] for p in cells]
            blobs.append((len(cells), sum(xs) // len(xs), sum(ys) // len(ys),
                          min(xs), min(ys), max(xs), max(ys)))
    blobs.sort(reverse=True)
    print("\nempty pockets (>=12 tiles, more than 6 tiles from any location):")
    for (n, mx, my, x0, y0, x1, y1) in blobs[:14]:
        print("   %4d tiles  centre (%3d,%3d)  box (%3d,%3d)-(%3d,%3d)" % (n, mx, my, x0, y0, x1, y1))
    if out_png:
        rows = []
        for ty in range(h):
            row = bytearray()
            for tx in range(w):
                if not reach[ty][tx]:
                    col = (40, 40, 48)
                elif loc[ty][tx]:
                    col = (70, 150, 80)
                elif d2loc[ty][tx] >= 6:
                    col = (230, 70, 60)
                else:
                    col = (120, 140, 100)
                if unit[ty][tx]:
                    col = (250, 230, 90)
                row += bytes(col) * cell
            for _ in range(cell):
                rows.append(bytes(row))
        png.write_rgb(out_png, w * cell, h * cell, rows)
        print("\nwrote", out_png)
    return blobs


if __name__ == "__main__":
    analyse(sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else None)
