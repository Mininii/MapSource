"""Terrain generation: region map -> ISOM side field (WFC) -> ISOM + MTXM.

Pinning strategy: every cell whose distance to the nearest differently-typed cell
is at least `pin_radius` gets its four sides fixed to its region type, so only the
transition bands are left to the solver. A small radius keeps cliffs thin but can
over-constrain awkward corners, so failures are repaired by locally relaxing the
pins around the failing cell and retrying.
"""
import sys, os, struct, pickle, random, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from isom_gen import IsomTable, EVEN, ODD, cell_value, offsets, pick_sub
from tileset import Tileset
from wfc import TupleSet, Field


def load_tuplesets(tablepath):
    """Returns ({parity: TupleSet}, {parity: {types: (g0,g1)}}, value weights)."""
    d = pickle.load(open(tablepath, "rb"))
    raw, best = d["table"], d["best"]
    tup = {0: collections.Counter(), 1: collections.Counter()}
    tiles = {0: {}, 1: {}}
    for k, cnt in raw.items():
        total = sum(cnt.values())
        for parity in (0, 1):
            off = EVEN if parity == 0 else ODD
            if all((k[i] == 0) or ((k[i] & 0xF) == off[i]) for i in range(4)):
                types = tuple(x >> 4 for x in k)
                tup[parity][types] += total
                if types not in tiles[parity] or total > tiles[parity][types][1]:
                    tiles[parity][types] = (best[k], total)
    tsets = {p: TupleSet(list(tup[p].keys()), dict(tup[p])) for p in (0, 1)}
    tilemap = {p: {t: v[0] for t, v in tiles[p].items()} for p in (0, 1)}
    valw = collections.Counter()
    for p in (0, 1):
        for types, n in tup[p].items():
            for v in types:
                valw[v] += n
    return tsets, tilemap, valw


class TerrainBuilder:
    def __init__(self, w, h, tablepath, era=7, seed=1234):
        assert w % 2 == 0 and h % 2 == 0
        self.w, self.h = w, h
        self.iw, self.ih = w // 2 + 1, h + 1
        self.tsets, self.tilemap, self.valw = load_tuplesets(tablepath)
        self.ts = Tileset(era)
        self.era = era
        self.rng = random.Random(seed)
        self.region = [[1] * self.iw for _ in range(self.ih)]
        self.repairs = 0
        self.pinned = 0

    def set_region(self, fn):
        for iy in range(self.ih):
            for ix in range(self.iw):
                self.region[iy][ix] = fn(ix, iy)

    # ------------------------------------------------------------- distances
    def boundary_distance(self):
        """L1 distance from every cell to the nearest differently-typed cell."""
        ih, iw, R = self.ih, self.iw, self.region
        INF = 10 ** 6
        d = [[INF] * iw for _ in range(ih)]
        q = collections.deque()
        for iy in range(ih):
            for ix in range(iw):
                t = R[iy][ix]
                for jx, jy in ((ix - 1, iy), (ix + 1, iy), (ix, iy - 1), (ix, iy + 1)):
                    if 0 <= jx < iw and 0 <= jy < ih and R[jy][jx] != t:
                        d[iy][ix] = 0
                        q.append((ix, iy))
                        break
        while q:
            ix, iy = q.popleft()
            nd = d[iy][ix] + 1
            for jx, jy in ((ix - 1, iy), (ix + 1, iy), (ix, iy - 1), (ix, iy + 1)):
                if 0 <= jx < iw and 0 <= jy < ih and d[jy][jx] > nd:
                    d[jy][jx] = nd
                    q.append((jx, jy))
        return d

    # ----------------------------------------------------------------- build
    def build(self, pin_radius=1, max_repair=250, log=print):
        bd = self.boundary_distance()
        relax = [[0] * self.iw for _ in range(self.ih)]
        for attempt in range(max_repair):
            f = Field(self.iw, self.ih, self.tsets)
            npin = 0
            for iy in range(self.ih):
                for ix in range(self.iw):
                    if bd[iy][ix] < pin_radius + relax[iy][ix]:
                        continue
                    t = self.region[iy][ix]
                    for var in f.cell_vars(ix, iy):
                        if len(f.dom(var)) != 1:
                            f.pin(var, t)
                            npin += 1
            if f.propagate():
                ok = f.solve(self.rng, weights=self.valw, log=lambda s: None)
                if ok:
                    self.V, self.H = f.result()
                    self.repairs = attempt
                    self.pinned = npin
                    log("terrain: pinned %d sides, %d repair rounds" % (npin, attempt))
                    return True
                fc = getattr(f, "fail_cell", None) or self._random_cell()
            else:
                fc = f.fail_cell or self._random_cell()
            ix, iy = fc
            for dy in range(-2, 3):
                for dx in range(-2, 3):
                    jy, jx = iy + dy, ix + dx
                    if 0 <= jy < self.ih and 0 <= jx < self.iw:
                        relax[jy][jx] += 1
        log("terrain build failed after %d repair rounds" % max_repair)
        return False

    def _random_cell(self):
        return (self.rng.randrange(self.iw), self.rng.randrange(self.ih))

    # ---------------------------------------------------------------- output
    def cell_types(self, ix, iy):
        return (self.V[iy][ix], self.H[iy][ix], self.V[iy][ix + 1], self.H[iy + 1][ix])

    def isom_bytes(self):
        out = bytearray()
        for iy in range(self.ih):
            for ix in range(self.iw):
                off = offsets(ix, iy)
                tt = self.cell_types(ix, iy)
                out += struct.pack("<4H", *[cell_value(tt[i], off[i]) for i in range(4)])
        return bytes(out)

    def tiles(self):
        tiles = [0] * (self.w * self.h)
        missing = []
        for iy in range(self.ih):
            if iy >= self.h:
                break
            for ix in range(self.iw):
                tx = ix * 2
                if tx + 1 >= self.w:
                    continue
                parity = (ix + iy) % 2
                types = self.cell_types(ix, iy)
                pair = self.tilemap[parity].get(types)
                if pair is None:
                    missing.append((ix, iy, types))
                    pair = (1, 1)
                g0, g1 = pair
                tiles[iy * self.w + tx] = (g0 << 4) | pick_sub(self.ts, g0, self.rng)
                tiles[iy * self.w + tx + 1] = (g1 << 4) | pick_sub(self.ts, g1, self.rng)
        return tiles, missing
