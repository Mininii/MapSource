"""Doodad support: learn tile stamps from real maps, then place them.

A DD2 entry is (doodad id, centre x px, centre y px, owner, state) and the tile
block it stamps has its top-left at (x//32 - w//2, y//32 - h//2), where w and h
come from the tileset's CV5 doodad group (fields u2 and u3, keyed by u1 = id).
"""
import sys, os, struct, collections, random, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tileset import Tileset
from doodad_probe import read_chk
from sides_probe import sides_of
from isom_table import load_map

BASE_TYPES = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13}


def doodad_groups(ts):
    by_id = {}
    for g in range(1024, len(ts.groups)):
        grp = ts.groups[g]
        if grp.u2 == 0 or grp.u3 == 0:
            continue
        by_id.setdefault(grp.u1, []).append(g)
    return by_id


def build_library(paths, era=7):
    """Extract (id, w, h, tiles, terrain) stamps from real maps."""
    ts = Tileset(era)
    by_id = doodad_groups(ts)
    lib = {}
    for p in paths:
        try:
            m = load_map(p)
            c = read_chk(p)
        except Exception:
            continue
        if not m or m["era"] != era:
            continue
        w, h = m["w"], m["h"]
        tiles = m["tiles"]
        V, H = sides_of(m)
        iw, ih = m["iw"], m["ih"]
        dd2 = c.get("DD2 ") or b""
        for i in range(len(dd2) // 8):
            num, x, y, owner, state = struct.unpack_from("<HHHBB", dd2, i * 8)
            groups = by_id.get(num)
            if not groups:
                continue
            gw, gh = ts.groups[groups[0]].u2, ts.groups[groups[0]].u3
            tx = x // 32 - gw // 2
            ty = y // 32 - gh // 2
            if not (0 <= tx and tx + gw <= w and 0 <= ty and ty + gh <= h):
                continue
            block = []
            ok = True
            for dy in range(gh):
                for dx in range(gw):
                    t = tiles[(ty + dy) * w + tx + dx]
                    if (t >> 4) not in groups:
                        ok = False
                        break
                    block.append(t)
                if not ok:
                    break
            if not ok:
                continue
            # terrain the doodad sits on, from the ISOM sides just outside it
            terr = collections.Counter()
            for dy in range(-1, gh + 1):
                for dx in range(-1, gw + 1):
                    if 0 <= dx < gw and 0 <= dy < gh:
                        continue
                    ix, iy = (tx + dx) // 2, ty + dy
                    if 0 <= ix < iw and 0 <= iy < ih:
                        for t in (V[iy][ix], H[iy][ix], V[iy][ix + 1], H[iy + 1][ix]):
                            if t in BASE_TYPES:
                                terr[t] += 1
            if not terr:
                continue
            base = terr.most_common(1)[0][0]
            key = (num, gw, gh, base, tuple(block))
            lib[key] = lib.get(key, 0) + 1
    out = []
    for (num, gw, gh, base, block), n in lib.items():
        out.append(dict(id=num, w=gw, h=gh, terrain=base, tiles=list(block), seen=n))
    return out


def walkable_fraction(ts, tiles):
    n = ok = 0
    for t in tiles:
        mt = ts.megatile(t)
        if mt is None or mt >= ts.nmega:
            continue
        fl = struct.unpack_from("<16H", ts.vf4, mt * 32)
        n += 16
        ok += sum(1 for f in fl if f & 1)
    return (ok / float(n)) if n else 0.0


class DoodadPlacer:
    def __init__(self, lib, era=7):
        self.ts = Tileset(era)
        self.lib = lib
        self.by_terrain = collections.defaultdict(list)
        for s in lib:
            s["walk"] = walkable_fraction(self.ts, s["tiles"])
            self.by_terrain[s["terrain"]].append(s)

    def place(self, tiles, w, h, region_of_tile, avoid, rng, count=140, tries_per=200,
              blocking_ok=False):
        """Stamp doodads into `tiles`. `region_of_tile(tx,ty)` gives the intended
        base type, `avoid` is a set of tiles that must stay clear."""
        placed = []
        used = set()
        tries = 0
        while len(placed) < count and tries < count * tries_per:
            tries += 1
            terr = rng.choice(list(self.by_terrain.keys()))
            pool = self.by_terrain[terr]
            if not pool:
                continue
            s = rng.choice(pool)
            if not blocking_ok and s["walk"] < 0.999 and terr != 2:
                # blocking doodads only on the cliff plateaus, which nothing walks on
                continue
            tx = rng.randrange(2, w - s["w"] - 2)
            ty = rng.randrange(2, h - s["h"] - 2)
            cells = [(tx + dx, ty + dy) for dy in range(s["h"]) for dx in range(s["w"])]
            pad = [(tx + dx, ty + dy) for dy in range(-1, s["h"] + 1)
                   for dx in range(-1, s["w"] + 1)]
            if any(c in used or c in avoid for c in pad):
                continue
            if any(region_of_tile(cx, cy) != terr for cx, cy in pad
                   if 0 <= cx < w and 0 <= cy < h):
                continue
            for k, (cx, cy) in enumerate(cells):
                tiles[cy * w + cx] = s["tiles"][k]
                used.add((cx, cy))
            placed.append((s["id"], (tx + s["w"] // 2) * 32 + 16,
                           (ty + s["h"] // 2) * 32 + 16))
        return placed


def dd2_bytes(placed):
    b = bytearray()
    for (num, x, y) in placed:
        b += struct.pack("<HHHBB", num, x, y, 0, 0)   # owner 0, state 0, as melee maps use
    return bytes(b)


if __name__ == "__main__":
    import glob
    paths = []
    for root in sys.argv[2:]:
        for dp, dn, fn in os.walk(root):
            for f in fn:
                if f.lower().endswith((".scm", ".scx")):
                    paths.append(os.path.join(dp, f))
    lib = build_library(paths, int(sys.argv[1]))
    print("stamps: %d" % len(lib))
    byt = collections.Counter(s["terrain"] for s in lib)
    print("by terrain:", dict(byt))
    sizes = collections.Counter((s["w"], s["h"]) for s in lib)
    print("sizes:", sizes.most_common(10))
    pickle.dump(lib, open("work/doodads_%d.pkl" % int(sys.argv[1]), "wb"))
    print("wrote work/doodads_%d.pkl" % int(sys.argv[1]))
