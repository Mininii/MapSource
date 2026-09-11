"""Place the source map's 255 locations into the new arena.

Reachable locations keep their polar position relative to the defence point
(hp1): the same bearing, and a walking distance scaled by the ratio of the two
maps' maximum walking distances. Locations that are isolated in the source (the
menu room and the boss arena) are mapped by an affine transform of their room.
"""
import sys, os, struct, math, json, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

HP1 = 1

# Locations that live in the source map's isolated rooms.
CONTROL_ROOM = [5, 6, 14, 102, 119, 120, 121, 122, 123, 124, 125, 127, 132, 136, 149, 244]
BOSS_ROOM = [46, 100, 101, 184, 185, 234, 235]
# 'Anywhere' style locations that must cover the whole map
WHOLE_MAP = [64]
# Locations with no meaningful position (pure random markers / off-map camera)
FREE = [126, 164, 218]


class Placer:
    def __init__(self, src_locs, new_dist, wg, arena, src_max, tile_w, tile_h):
        self.src = src_locs                 # {idx: dict from roles.json}
        self.dist = new_dist                # minitile distance field of the new map
        self.wg = wg
        self.ar = arena
        self.W, self.H = tile_w, tile_h
        self.MW, self.MH = wg.MW, wg.MH
        self.src_max = src_max
        self.new_max = max([d for d in new_dist if d >= 0] or [1])
        self.scale = self.new_max / float(src_max)
        hp = src_locs[str(HP1)] if str(HP1) in src_locs else src_locs[HP1]
        self.src_hp = ((hp["L"] + hp["R"]) / 2.0, (hp["T"] + hp["B"]) / 2.0)
        self.fort = (arena.fx * 2 * 32 + 32, arena.fy * 32 + 16)   # pixel centre
        self.placed = []                    # (cx, cy) pixel centres already used

    # ------------------------------------------------------------- candidates
    def build_candidates(self, step=2, clearance=None):
        """Reachable tile centres, as (mx, my, dist, angle)."""
        cands = []
        fx, fy = self.fort[0] / 8.0, self.fort[1] / 8.0
        for ty in range(1, self.H - 1, step):
            for tx in range(1, self.W - 1, step):
                mx, my = tx * 4 + 2, ty * 4 + 2
                d = self.dist[my * self.MW + mx]
                if d < 0:
                    continue
                if not self._room(mx, my, 6):
                    continue
                a = math.atan2(mx - fx, -(my - fy))
                cands.append((mx, my, d, a))
        self.cands = cands
        return cands

    def _room(self, mx, my, rad):
        """True when a rad x rad minitile block around (mx,my) is reachable."""
        n = 0
        tot = 0
        h = rad // 2
        for dy in range(-h, h + 1):
            yy = my + dy
            if yy < 0 or yy >= self.MH:
                continue
            row = yy * self.MW
            for dx in range(-h, h + 1):
                xx = mx + dx
                if xx < 0 or xx >= self.MW:
                    continue
                tot += 1
                if self.dist[row + xx] >= 0:
                    n += 1
        return tot and n >= tot * 0.8

    # ------------------------------------------------------------- placement
    def polar(self, L):
        cx = (L["L"] + L["R"]) / 2.0
        cy = (L["T"] + L["B"]) / 2.0
        dx, dy = cx - self.src_hp[0], cy - self.src_hp[1]
        return math.atan2(dx, -dy)

    def rect_coverage(self, rect):
        """Fraction of a pixel rectangle that is reachable."""
        L, T, R, B = rect
        x0, y0 = L // 8, T // 8
        x1, y1 = max(x0, R // 8 - 1), max(y0, B // 8 - 1)
        tot = ok = 0
        for my in range(y0, min(y1 + 1, self.MH)):
            row = my * self.MW
            for mx in range(x0, min(x1 + 1, self.MW)):
                tot += 1
                if self.dist[row + mx] >= 0:
                    ok += 1
        return (ok / float(tot)) if tot else 0.0

    def ranked(self, L, spread=1.0, topk=60):
        """Top candidate centres for a location, cheapest cost first."""
        target = (L["dist"] or 0) * self.scale
        ang = self.polar(L)
        scored = []
        for (mx, my, d, a) in self.cands:
            da = abs(((a - ang + math.pi) % (2 * math.pi)) - math.pi)
            cost = abs(d - target) / 12.0 + da * 4.0
            pen = 0.0
            for (px, py) in self.placed:
                dd = abs(px - mx) + abs(py - my)
                if dd < 12:
                    pen += (12 - dd) * 0.25
            cost += min(pen, 3.0) * spread
            scored.append((cost, mx, my))
        scored.sort()
        return [(mx, my) for (_, mx, my) in scored[:topk]]

    def place_arena(self, L, spread=1.0, want=0.85, topk=150):
        """Best candidate for a reachable source location: matching bearing and
        scaled distance, spread out from earlier picks, and with a rectangle that
        actually sits on reachable ground."""
        target = (L["dist"] or 0) * self.scale
        ang = self.polar(L)
        scored = []
        for (mx, my, d, a) in self.cands:
            da = abs(((a - ang + math.pi) % (2 * math.pi)) - math.pi)
            cost = abs(d - target) / 12.0 + da * 4.0
            pen = 0.0
            for (px, py) in self.placed:
                dd = abs(px - mx) + abs(py - my)
                if dd < 12:
                    pen += (12 - dd) * 0.25
            cost += min(pen, 3.0) * spread     # spread is a tie-breaker, not a driver
            scored.append((cost, mx, my))
        scored.sort()
        fallback = None
        bestcov = -1.0
        for (cost, mx, my) in scored[:topk]:
            rect = self.rect_for(L, mx * 8 + 4, my * 8 + 4)
            cov = self.rect_coverage(rect)
            if cov >= want:
                return (mx, my)
            if cov > bestcov:
                bestcov = cov
                fallback = (mx, my)
        if bestcov >= want - 0.15:
            return fallback
        # Nothing near the wanted bearing has room. Drop the bearing term and take
        # the closest distance match that the location actually fits on - a spawn
        # point on a cliff is worse than one that is 30 degrees off.
        relaxed = sorted((abs(d - target), mx, my) for (mx, my, d, a) in self.cands)
        for (_, mx, my) in relaxed[:topk * 2]:
            rect = self.rect_for(L, mx * 8 + 4, my * 8 + 4)
            cov = self.rect_coverage(rect)
            if cov >= want:
                return (mx, my)
            if cov > bestcov:
                bestcov = cov
                fallback = (mx, my)
        return fallback

    def rect_for(self, L, cx_px, cy_px, scale=0.5, minsize=2):
        w = max(minsize, int(round((L["R"] - L["L"]) / 32.0 * scale)))
        h = max(minsize, int(round((L["B"] - L["T"]) / 32.0 * scale)))
        w = min(w, self.W - 2)
        h = min(h, self.H - 2)
        left = int(cx_px - w * 16)
        top = int(cy_px - h * 16)
        left = max(0, min(left, (self.W - w) * 32))
        top = max(0, min(top, (self.H - h) * 32))
        return (left, top, left + w * 32, top + h * 32)


def clusters(src_locs, skip, max_area_tiles=3000, overlap=0.5):
    """Group locations whose rectangles overlap heavily, so a preplaced unit that
    sits in several of them at once keeps sitting in all of them afterwards."""
    items = []
    for k, v in src_locs.items():
        i = int(k)
        if i in skip:
            continue
        w = (v["R"] - v["L"]) / 32.0
        h = (v["B"] - v["T"]) / 32.0
        if w <= 0 or h <= 0 or w * h > max_area_tiles:
            continue
        items.append((i, v))
    par = {i: i for i, _ in items}

    def find(a):
        while par[a] != a:
            par[a] = par[par[a]]
            a = par[a]
        return a

    def union(a, b):
        ra, rb = find(a), find(b)
        if ra != rb:
            par[rb] = ra
    for ai in range(len(items)):
        i, a = items[ai]
        aa = (a["R"] - a["L"]) * (a["B"] - a["T"])
        for bi in range(ai + 1, len(items)):
            j, b = items[bi]
            ox = min(a["R"], b["R"]) - max(a["L"], b["L"])
            oy = min(a["B"], b["B"]) - max(a["T"], b["T"])
            if ox <= 0 or oy <= 0:
                continue
            bb = (b["R"] - b["L"]) * (b["B"] - b["T"])
            if ox * oy >= overlap * min(aa, bb):
                union(i, j)
    groups = {}
    for i, _ in items:
        groups.setdefault(find(i), []).append(i)
    return list(groups.values())


def containment(src_locs, max_area_tiles=3000, tol=64):
    """parent[i] = the smallest other location that fully contains i.

    The source map nests small marker locations inside big spawn rectangles, and
    preplaced units are counted by triggers at both. Keeping the nesting means a
    unit stays inside every location it started in."""
    items = []
    for k, v in src_locs.items():
        i = int(k)
        w = (v["R"] - v["L"]) / 32.0
        h = (v["B"] - v["T"]) / 32.0
        if w <= 0 or h <= 0 or w * h > max_area_tiles:
            continue
        items.append((w * h, i, v))
    items.sort()
    parent = {}
    for area, i, v in items:
        best = None
        for area2, j, w2 in items:
            if j == i or area2 <= area:
                continue
            if (w2["L"] - tol <= v["L"] and w2["T"] - tol <= v["T"]
                    and w2["R"] + tol >= v["R"] and w2["B"] + tol >= v["B"]):
                if best is None or area2 < best[0]:
                    best = (area2, j)
        if best:
            parent[i] = best[1]
    return parent


def affine_rect(src_parent, dst_parent, rect, minsize=32):
    """Map a rectangle from one enclosing rectangle onto another."""
    sl, st, sr, sb = src_parent
    dl, dt, dr, db = dst_parent
    fx = (dr - dl) / float(max(1, sr - sl))
    fy = (db - dt) / float(max(1, sb - st))
    l = dl + (rect[0] - sl) * fx
    r = dl + (rect[2] - sl) * fx
    t = dt + (rect[1] - st) * fy
    b = dt + (rect[3] - st) * fy
    if r - l < minsize:
        r = l + minsize
    if b - t < minsize:
        b = t + minsize
    return (int(l), int(t), int(r), int(b))


def affine_room(src_locs, ids, src_rect, dst_rect):
    """Map a group of locations from one room's bounding box onto another."""
    xs = [src_locs[str(i)]["L"] for i in ids] + [src_locs[str(i)]["R"] for i in ids]
    ys = [src_locs[str(i)]["T"] for i in ids] + [src_locs[str(i)]["B"] for i in ids]
    sx0, sx1 = min(xs), max(xs)
    sy0, sy1 = min(ys), max(ys)
    dx0, dy0, dx1, dy1 = dst_rect
    fx = (dx1 - dx0) / float(max(1, sx1 - sx0))
    fy = (dy1 - dy0) / float(max(1, sy1 - sy0))
    out = {}
    for i in ids:
        L = src_locs[str(i)]
        nl = dx0 + (L["L"] - sx0) * fx
        nr = dx0 + (L["R"] - sx0) * fx
        nt = dy0 + (L["T"] - sy0) * fy
        nb = dy0 + (L["B"] - sy0) * fy
        if nr - nl < 32:
            nr = nl + 32
        if nb - nt < 32:
            nb = nt + 32
        out[i] = (int(nl), int(nt), int(nr), int(nb))
    return out
