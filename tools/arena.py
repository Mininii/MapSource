"""The new 128x128 twilight arena: region layout in ISOM-cell space.

Terrain type ids (Twilight ISOM):
    1  Dirt        low  walkable   - arena floor, every unit path
    2  High Dirt   high walkable   - WALLS; with no ramps these are unreachable
                                     islands, so they act as impassable cliffs
    3  Water            unwalkable - decorative lakes, kept clear of cliffs
    4  Mud         low  walkable   - decorative floor variant

Rules learned from the tileset: only LOW may touch HIGH, WATER or MUD, and a
feature must be ~5 cells thick to survive the transition bands.

Cell (ix,iy) covers tiles (2*ix, iy) and (2*ix+1, iy): one cell is 2 tiles wide
and 1 tile tall, so L1 distance in cell space is the natural isometric metric.
All shapes are perturbed by value noise so the coastlines look hand-drawn.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from noise import fbm

WATER, LOW, HIGH, MUD = 3, 1, 2, 4
# low-ground variants whose transition to Dirt stays fully walkable (measured
# with tools/sep_test.py): 4 mud, 6 rocky, 7 rough, 13 flagstone-ish.
FLOOR_VARIANTS = [4, 13, 6, 7]
FORTRESS_FLOOR = 13   # paving inside the fortress rim; transition to Dirt is walkable
PEAK = 12          # highest ground: sits inside a High Dirt plateau (1 -> 2 -> 12)
PLATEAU_VARIANTS = [9, 10]
PASSABLE = {LOW, MUD, 13, 6, 7}


W = H = 128


class Arena:
    def __init__(self, w=W, h=H, seed=1701):
        self.w, self.h = w, h
        self.iw, self.ih = w // 2 + 1, h + 1          # 65 x 129
        self.seed = seed
        self.bx, self.by = 3, 4                       # border thickness (cells)
        self.fx, self.fy = 32, 108                    # fortress centre
        self.control_room = (6, 8, 18, 26)            # top-left menu room
        self.boss_island = (46, 8, 58, 26)            # top-right boss arena
        self.room_wall = 5
        # ridges: (L1 radius, thickness) around the fortress
        self.rings = [(15, 5), (40, 5), (68, 5)]
        # corridors through the ridges: vertical strips of cell columns.
        # A ridge is an L1 diamond so a column strip always cuts it exactly once
        # per side, wherever the ridge happens to run.
        self.ring_gaps = [
            [(16, 24), (40, 48)],      # fortress rim: west and east gate
            [(3, 11), (51, 59)],       # middle ridge: far west and far east
            [(27, 35)],                # outer ridge: centre pass only
        ]
        # scattered plateaus (cx, cy, L1 radius) - deliberately asymmetric
        self.blobs = [
            (12, 93, 6), (50, 90, 5), (24, 82, 6), (41, 78, 5), (33, 88, 5),
            (9, 71, 5), (56, 73, 6), (19, 37, 6), (46, 40, 5), (30, 29, 5),
            (13, 117, 5), (52, 114, 6), (37, 47, 5), (22, 51, 4), (57, 52, 5),
            (7, 46, 5), (43, 62, 4), (18, 64, 4),
        ]
        self.lakes = [(33, 68, 6), (15, 22, 5), (50, 21, 5), (60, 92, 5), (6, 84, 5)]
        self.patches = [(22, 103, 6), (44, 105, 6), (32, 80, 5), (15, 54, 6),
                        (50, 57, 5), (33, 41, 6), (10, 106, 5), (55, 100, 5),
                        (26, 68, 5), (40, 92, 5)]

    # ---------------------------------------------------------------- helpers
    def n(self, ix, iy, scale, salt):
        return fbm(ix, iy, scale, self.seed + salt, 3)

    def in_rect(self, ix, iy, rect, pad=0):
        x0, y0, x1, y1 = rect
        return (x0 - pad) <= ix <= (x1 + pad) and (y0 - pad) <= iy <= (y1 + pad)

    def blobby(self, ix, iy, cx, cy, r, salt, amp=2.6):
        return abs(ix - cx) + abs(iy - cy) <= r + amp * self.n(ix, iy, 7.0, salt)

    # ---------------------------------------------------------------- regions
    def region(self, ix, iy):
        iw, ih = self.iw, self.ih
        bx = self.bx + 1.3 * self.n(ix, iy, 9.0, 11)
        by = self.by + 1.6 * self.n(ix, iy, 9.0, 23)
        if ix < bx or iy < by or ix > iw - 1 - bx or iy > ih - 1 - by:
            return HIGH
        for k, room in enumerate((self.control_room, self.boss_island)):
            if self.in_rect(ix, iy, room, pad=self.room_wall):
                return LOW if self.in_rect(ix, iy, room) else HIGH
        r = abs(ix - self.fx) + abs(iy - self.fy)
        # the fortress floor gets its own paving so the base reads as a place
        if r < 11 + 1.6 * self.n(ix, iy, 6.0, 61):
            return FORTRESS_FLOOR
        for k, (rad, thick) in enumerate(self.rings):
            lo = rad + 2.4 * self.n(ix, iy, 8.0, 31 + k * 7)
            if lo <= r < lo + thick:
                gaps = self.ring_gaps[k] if k < len(self.ring_gaps) else []
                if not any(a <= ix <= b for (a, b) in gaps):
                    return HIGH
        for k, (cx, cy, rr) in enumerate(self.blobs):
            if self.blobby(ix, iy, cx, cy, rr, 41 + k * 13):
                return HIGH
        return LOW

    # ---------------------------------------------------------------- buffers
    def grid(self, buf=2, decorate=True):
        g = [[self.region(ix, iy) for ix in range(self.iw)] for iy in range(self.ih)]
        if decorate:
            g = self.decorate(g, buf)
            g = self.decorate_peaks(g, buf)
        return g

    def type_distance(self, g, kind):
        """L1 distance from every cell of type `kind` to the nearest cell that is
        not of that type."""
        ih, iw = self.ih, self.iw
        INF = 10 ** 6
        d = [[0 if g[iy][ix] != kind else INF for ix in range(iw)] for iy in range(ih)]
        for iy in range(ih):
            for ix in range(iw):
                v = d[iy][ix]
                if iy: v = min(v, d[iy - 1][ix] + 1)
                if ix: v = min(v, d[iy][ix - 1] + 1)
                d[iy][ix] = v
        for iy in range(ih - 1, -1, -1):
            for ix in range(iw - 1, -1, -1):
                v = d[iy][ix]
                if iy + 1 < ih: v = min(v, d[iy + 1][ix] + 1)
                if ix + 1 < iw: v = min(v, d[iy][ix + 1] + 1)
                d[iy][ix] = v
        return d

    def decorate_peaks(self, g, buf=2):
        """Put a highest-ground core inside the fat plateaus, and a texture patch
        inside the thinner ones, so the cliffs read as more than one tier."""
        ih, iw = self.ih, self.iw
        d = self.type_distance(g, HIGH)
        cand = sorted(((d[iy][ix], ix, iy) for iy in range(ih) for ix in range(iw)
                       if d[iy][ix] >= buf + 3
                       and not any(self.in_rect(ix, iy, r, pad=self.room_wall + 2)
                                   for r in (self.control_room, self.boss_island))),
                      reverse=True)
        out = [row[:] for row in g]
        placed = []
        for (dd, ix, iy) in cand:
            if any(abs(ix - px) + abs(iy - py) < pr + 7 for (px, py, pr) in placed):
                continue
            r = min(6, dd - buf - 2)
            if r < 2:
                continue
            kind = PEAK if dd >= buf + 5 else PLATEAU_VARIANTS[len(placed) % len(PLATEAU_VARIANTS)]
            for jy in range(max(0, iy - r - 3), min(ih, iy + r + 4)):
                for jx in range(max(0, ix - r - 3), min(iw, ix + r + 4)):
                    if out[jy][jx] != HIGH or d[jy][jx] <= buf:
                        continue
                    if self.blobby(jx, jy, ix, iy, r, 700 + len(placed) * 23, amp=1.8):
                        out[jy][jx] = kind
            placed.append((ix, iy, r))
            if len(placed) >= 24:
                break
        self.peaks = placed
        return out

    # ------------------------------------------------------------ decoration
    def open_distance(self, g):
        """L1 distance from every LOW cell to the nearest non-LOW cell."""
        ih, iw = self.ih, self.iw
        INF = 10 ** 6
        d = [[0 if g[iy][ix] != LOW else INF for ix in range(iw)] for iy in range(ih)]
        for iy in range(ih):
            for ix in range(iw):
                v = d[iy][ix]
                if iy: v = min(v, d[iy - 1][ix] + 1)
                if ix: v = min(v, d[iy][ix - 1] + 1)
                d[iy][ix] = v
        for iy in range(ih - 1, -1, -1):
            for ix in range(iw - 1, -1, -1):
                v = d[iy][ix]
                if iy + 1 < ih: v = min(v, d[iy + 1][ix] + 1)
                if ix + 1 < iw: v = min(v, d[iy][ix + 1] + 1)
                d[iy][ix] = v
        return d

    def connected(self, g, sx=None, sy=None):
        """Cells reachable on foot from the fortress (LOW and MUD are passable)."""
        import collections as _c
        ih, iw = self.ih, self.iw
        sx = self.fx if sx is None else sx
        sy = self.fy if sy is None else sy
        seen = [[False] * iw for _ in range(ih)]
        if g[sy][sx] not in PASSABLE:
            return seen, 0
        q = _c.deque([(sx, sy)])
        seen[sy][sx] = True
        n = 1
        while q:
            x, y = q.popleft()
            for nx, ny in ((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)):
                if 0 <= nx < iw and 0 <= ny < ih and not seen[ny][nx] and g[ny][nx] in PASSABLE:
                    seen[ny][nx] = True
                    n += 1
                    q.append((nx, ny))
        return seen, n

    def decorate(self, g, buf=2):
        """Drop lakes and mud patches into the middle of open floor, far enough
        from any cliff that the tileset transition band has room. Any patch that
        would cut the arena into pieces is rolled back."""
        ih, iw = self.ih, self.iw
        d = self.open_distance(g)
        cand = []
        for iy in range(ih):
            for ix in range(iw):
                if d[iy][ix] < buf + 2:
                    continue
                if abs(ix - self.fx) + abs(iy - self.fy) < 18:
                    continue                      # keep the fortress clear
                if any(self.in_rect(ix, iy, r, pad=2)
                       for r in (self.control_room, self.boss_island)):
                    continue                      # the isolated rooms stay plain floor
                cand.append((d[iy][ix], ix, iy))
        cand.sort(reverse=True)
        placed = []
        out = [row[:] for row in g]
        _, base_conn = self.connected(out)
        for (dd, ix, iy) in cand:
            if any(abs(ix - px) + abs(iy - py) < pr + 8 for (px, py, pr) in placed):
                continue
            r = min(7, dd - buf - 1)
            if r < 2:
                continue
            if dd >= buf + 6 and (len(placed) % 4 == 1):
                kind = WATER
            else:
                kind = FLOOR_VARIANTS[len(placed) % len(FLOOR_VARIANTS)]
            trial = [row[:] for row in out]
            for jy in range(max(0, iy - r - 3), min(ih, iy + r + 4)):
                for jx in range(max(0, ix - r - 3), min(iw, ix + r + 4)):
                    if trial[jy][jx] != LOW:
                        continue
                    if self.blobby(jx, jy, ix, iy, r, 300 + len(placed) * 29, amp=2.0):
                        if d[jy][jx] > buf:
                            trial[jy][jx] = kind
            if kind == WATER:
                _, n_after = self.connected(trial)
                if n_after < base_conn - 4:
                    continue                      # this lake would wall a route off
            out = trial
            placed.append((ix, iy, r))
            if len(placed) >= 34:
                break
        self.decor = placed
        return out

    def _separate(self, g, a, b, dist):
        ih, iw = self.ih, self.iw
        out = [row[:] for row in g]
        for iy in range(ih):
            for ix in range(iw):
                if g[iy][ix] != a:
                    continue
                hit = False
                for dy in range(-dist, dist + 1):
                    jy = iy + dy
                    if jy < 0 or jy >= ih:
                        continue
                    rem = dist - abs(dy)
                    row = g[jy]
                    for dx in range(-rem, rem + 1):
                        jx = ix + dx
                        if 0 <= jx < iw and row[jx] == b:
                            hit = True
                            break
                    if hit:
                        break
                if hit:
                    out[iy][ix] = LOW
        return out
