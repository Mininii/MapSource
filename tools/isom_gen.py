"""ISOM generation: side-type field -> ISOM cells -> MTXM tiles."""
import sys, os, struct, pickle, random, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tileset import Tileset

EVEN = (8, 10, 0, 2)     # left, top, right, bottom shape offsets when (ix+iy) even
ODD = (4, 12, 14, 6)     # ... when odd


def offsets(ix, iy):
    return EVEN if (ix + iy) % 2 == 0 else ODD


def cell_value(t, off):
    return 0 if t == 0 else ((t << 4) | off)


class IsomTable:
    def __init__(self, path):
        d = pickle.load(open(path, "rb"))
        self.raw = d["table"]
        self.best = d["best"]
        # key set by parity, in terms of side types
        self.keys = {0: set(), 1: set()}
        self.by_types = {0: {}, 1: {}}
        for k, v in self.best.items():
            for parity in (0, 1):
                off = EVEN if parity == 0 else ODD
                ok = all((k[i] == 0) or ((k[i] & 0xF) == off[i]) for i in range(4))
                if ok:
                    types = tuple(x >> 4 for x in k)
                    self.keys[parity].add(types)
                    self.by_types[parity][types] = v
        # variant pool per key: all observed tile pairs with counts
        self.variants = {}
        for k, c in self.raw.items():
            self.variants[k] = c

    def tiles_for(self, types, parity):
        return self.by_types[parity].get(types)


class IsomMap:
    """Side-type field for a w x h tile map."""

    def __init__(self, w, h, fill=1):
        assert w % 2 == 0 and h % 2 == 0
        self.w, self.h = w, h
        self.iw, self.ih = w // 2 + 1, h + 1
        # vertical sides: V[iy][ix] for ix in 0..iw  (iw+1 per row)
        self.V = [[fill] * (self.iw + 1) for _ in range(self.ih)]
        # horizontal sides: H[iy][ix] for iy in 0..ih (ih+1 rows)
        self.H = [[fill] * self.iw for _ in range(self.ih + 1)]

    def cell_types(self, ix, iy):
        return (self.V[iy][ix], self.H[iy][ix], self.V[iy][ix + 1], self.H[iy + 1][ix])

    def cell_values(self, ix, iy):
        off = offsets(ix, iy)
        return tuple(cell_value(t, off[i]) for i, t in enumerate(self.cell_types(ix, iy)))

    def build_isom(self):
        out = bytearray()
        for iy in range(self.ih):
            for ix in range(self.iw):
                out += struct.pack("<4H", *self.cell_values(ix, iy))
        return bytes(out)

    def build_tiles(self, table, rng=None, ts=None, unknown=None):
        """Returns (tiles list, list of (ix,iy) cells that had no table entry)."""
        rng = rng or random.Random(1234)
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
                pair = table.tiles_for(types, parity)
                if pair is None:
                    missing.append((ix, iy, types, parity))
                    pair = unknown or (0, 0)
                g0, g1 = pair
                tiles[iy * self.w + tx] = (g0 << 4) | (rng.randrange(16) if ts is None else pick_sub(ts, g0, rng))
                tiles[iy * self.w + tx + 1] = (g1 << 4) | (rng.randrange(16) if ts is None else pick_sub(ts, g1, rng))
        return tiles, missing


def pick_sub(ts, g, rng):
    """Pick a random valid subtile index within a CV5 group (skip zero megatiles)."""
    grp = ts.groups[g]
    cand = [i for i, mt in enumerate(grp.megatiles) if mt != 0]
    if not cand:
        return 0
    return rng.choice(cand)


def tiles_to_mtxm(tiles):
    return struct.pack("<%dH" % len(tiles), *tiles)
