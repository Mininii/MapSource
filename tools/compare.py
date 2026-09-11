"""Compare source and rebuilt maps: walking distance and bearing of every location."""
import sys, os, struct, json, math, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from walk import from_chk

HP1 = 1


def dists(chk_path):
    c = CHK(open(chk_path, "rb").read())
    m = c.get("MRGN")
    locs = {}
    for i in range(len(m) // 20):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        locs[i + 1] = (L, T, R, B)
    wg = from_chk(c)
    clear = wg.clearance(2)
    L, T, R, B = locs[HP1]
    cx, cy = ((L + R) // 2) // 8, ((T + B) // 2) // 8
    starts = [(cx + dx, cy + dy) for dx in range(-8, 9) for dy in range(-8, 9)]
    d = wg.bfs(starts, clear)
    out = {}
    for i, (L, T, R, B) in locs.items():
        if (L, T, R, B) == (0, 0, 0, 0):
            continue
        x0, y0 = L // 8, T // 8
        x1, y1 = max(x0, R // 8 - 1), max(y0, B // 8 - 1)
        best = None
        for my in range(y0, min(y1 + 1, wg.MH)):
            row = my * wg.MW
            for mx in range(x0, min(x1 + 1, wg.MW)):
                v = d[row + mx]
                if v >= 0 and (best is None or v < best):
                    best = v
        mcx, mcy = (L + R) / 16.0, (T + B) / 16.0
        ang = math.atan2(mcx - cx, -(mcy - cy))
        out[i] = (best, ang)
    return out


def main(src, new):
    a = dists(src)
    b = dists(new)
    amax = max(v[0] for v in a.values() if v[0] is not None)
    bmax = max(v[0] for v in b.values() if v[0] is not None)
    print("source max %d, new max %d, ratio %.2f" % (amax, bmax, bmax / float(amax)))
    rows = []
    for i in sorted(a):
        if i not in b:
            continue
        da, aa = a[i]
        db, ab = b[i]
        if da is None or db is None:
            continue
        want = da * bmax / float(amax)
        derr = db - want
        aerr = abs(((ab - aa + math.pi) % (2 * math.pi)) - math.pi) * 180 / math.pi
        rows.append((i, da, db, want, derr, aerr))
    derrs = sorted(abs(r[4]) for r in rows)
    aerrs = sorted(r[5] for r in rows)
    n = len(rows)
    print("locations compared: %d" % n)
    print("distance error   median %.0f  p90 %.0f  max %.0f minitiles" % (
        derrs[n // 2], derrs[int(n * 0.9)], derrs[-1]))
    print("bearing error    median %.0f  p90 %.0f  max %.0f degrees" % (
        aerrs[n // 2], aerrs[int(n * 0.9)], aerrs[-1]))
    print("\nworst 15 by distance error:")
    for r in sorted(rows, key=lambda r: -abs(r[4]))[:15]:
        print("  loc%-4d src=%-5d new=%-5d want=%-5.0f err=%+6.0f  bearing err %3.0f deg"
              % (r[0], r[1], r[2], r[3], r[4], r[5]))
    # spread: how far apart are the nearest neighbours?
    for name, dd in (("source", a), ("new", b)):
        pts = []
        c = CHK(open(src if name == "source" else new, "rb").read())
        m = c.get("MRGN")
        for i in range(len(m) // 20):
            L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
            if (L, T, R, B) != (0, 0, 0, 0) and (R - L) < 4000:
                pts.append(((L + R) / 2.0, (T + B) / 2.0))
        nn = []
        for j, p in enumerate(pts):
            best = min((abs(p[0] - q[0]) + abs(p[1] - q[1]))
                       for k, q in enumerate(pts) if k != j)
            nn.append(best)
        nn.sort()
        print("%s: %d locations, nearest-neighbour median %.0f px (%.1f tiles)"
              % (name, len(pts), nn[len(nn) // 2], nn[len(nn) // 2] / 32.0))


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
