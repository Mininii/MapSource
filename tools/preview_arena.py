"""Fast layout preview: region grid stats + connectivity, no WFC."""
import sys, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from arena import Arena, WATER, LOW, HIGH, MUD, PASSABLE
import png

COL = {WATER: (20, 40, 90), LOW: (70, 110, 60), HIGH: (150, 180, 120), MUD: (120, 100, 60),
       13: (95, 105, 75), 6: (110, 95, 70), 7: (85, 95, 85)}


def flood(g, iw, ih, sx, sy, passable=None):
    passable = passable or PASSABLE
    dist = [[-1] * iw for _ in range(ih)]
    if g[sy][sx] not in passable:
        return dist, 0, 0
    q = collections.deque([(sx, sy)])
    dist[sy][sx] = 0
    n = 1
    mx = 0
    while q:
        x, y = q.popleft()
        d = dist[y][x] + 1
        for nx, ny in ((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)):
            if 0 <= nx < iw and 0 <= ny < ih and dist[ny][nx] < 0 and g[ny][nx] in passable:
                dist[ny][nx] = d
                mx = max(mx, d)
                n += 1
                q.append((nx, ny))
    return dist, n, mx


def main(out="work/region_grid.png"):
    ar = Arena()
    g = ar.grid()
    cnt = collections.Counter(v for row in g for v in row)
    total = ar.iw * ar.ih
    print("cells %d  " % total + "  ".join("%s=%d(%.0f%%)" % (
        {WATER: "water", LOW: "low", HIGH: "high", MUD: "mud"}.get(k, k), v, 100.0 * v / total)
        for k, v in sorted(cnt.items())))
    dist, n, mx = flood(g, ar.iw, ar.ih, ar.fx, ar.fy, ar.PASSABLE)
    print("arena connected cells: %d (%.0f%% of floor)  max cell-hops from fortress: %d"
          % (n, 100.0 * n / max(1, cnt[LOW] + cnt[MUD]), mx))
    # isolated rooms should NOT be connected
    for nm, rect in (("control_room", ar.control_room), ("boss_island", ar.boss_island)):
        x0, y0, x1, y1 = rect
        con = dist[(y0 + y1) // 2][(x0 + x1) // 2] >= 0
        print("  %-13s isolated=%s" % (nm, not con))
    SC = 4
    rows = []
    for iy in range(ar.ih):
        row = bytearray()
        for ix in range(ar.iw):
            c = COL.get(g[iy][ix], (255, 0, 255))
            if dist[iy][ix] >= 0:
                f = min(1.0, dist[iy][ix] / max(1, mx))
                c = (int(40 + 200 * f), int(220 - 160 * f), 60)
            row += bytes(c) * SC * 2
        for _ in range(SC):
            rows.append(bytes(row))
    png.write_rgb(out, ar.iw * SC * 2, ar.ih * SC, rows)
    print("wrote", out)


if __name__ == "__main__":
    main(*sys.argv[1:])
