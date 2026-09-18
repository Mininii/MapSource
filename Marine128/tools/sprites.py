"""THG2 sprite support: learn which decorative sprites sit on which terrain in
real maps, then scatter them over the generated map.

THG2 entry: u16 sprite/unit id, u16 x px, u16 y px, u8 owner, u8 unused, u16 flags.
Flag 0x1000 marks it as a pure sprite (graphics only - no unit, no collision),
which is what melee maps use for trees, rocks and rubble.
"""
import sys, os, struct, collections, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from mpq import MPQ
from isom_table import load_map
from sides_probe import sides_of

BASE_TYPES = set(range(1, 14))
SPRITE_FLAG = 0x1000


def read_chk(path):
    try:
        with MPQ(path) as m:
            return CHK(m.read("staredit\\scenario.chk"))
    except Exception:
        return CHK(open(path, "rb").read())


def build_library(paths, era=7):
    """[(sprite id, flags, terrain type)] with how often each combination occurs."""
    lib = collections.Counter()
    for p in paths:
        try:
            m = load_map(p)
            c = read_chk(p)
        except Exception:
            continue
        if not m or m["era"] != era:
            continue
        thg2 = c.get("THG2") or b""
        V, H = sides_of(m)
        iw, ih = m["iw"], m["ih"]
        for i in range(len(thg2) // 10):
            uid, x, y, owner, unused, flags = struct.unpack_from("<HHHBBH", thg2, i * 10)
            if not (flags & SPRITE_FLAG):
                continue
            ix, iy = (x // 32) // 2, y // 32
            if not (0 <= ix < iw and 0 <= iy < ih):
                continue
            t = collections.Counter()
            for v in (V[iy][ix], H[iy][ix], V[iy][ix + 1], H[iy + 1][ix]):
                if v in BASE_TYPES:
                    t[v] += 1
            if not t:
                continue
            lib[(uid, flags, t.most_common(1)[0][0])] += 1
    return lib


class SpritePlacer:
    def __init__(self, lib):
        self.by_terrain = collections.defaultdict(list)
        for (uid, flags, terr), n in lib.items():
            self.by_terrain[terr].extend([(uid, flags)] * min(n, 6))

    def place(self, w, h, region_of_tile, avoid, rng, count=150, tries_per=80):
        out = []
        used = set()
        tries = 0
        terrains = [t for t in self.by_terrain if self.by_terrain[t]]
        if not terrains:
            return out
        while len(out) < count and tries < count * tries_per:
            tries += 1
            terr = rng.choice(terrains)
            uid, flags = rng.choice(self.by_terrain[terr])
            tx = rng.randrange(2, w - 2)
            ty = rng.randrange(2, h - 2)
            if (tx, ty) in used or (tx, ty) in avoid:
                continue
            if any(region_of_tile(tx + dx, ty + dy) != terr
                   for dx in (-1, 0, 1) for dy in (-1, 0, 1)):
                continue
            used.add((tx, ty))
            out.append((uid, tx * 32 + 16, ty * 32 + 16, flags))
        return out


def thg2_bytes(placed):
    b = bytearray()
    for (uid, x, y, flags) in placed:
        b += struct.pack("<HHHBBH", uid, x, y, 0, 0, flags)
    return bytes(b)


if __name__ == "__main__":
    era = int(sys.argv[1])
    paths = []
    for root in sys.argv[2:]:
        for dp, dn, fn in os.walk(root):
            for f in fn:
                if f.lower().endswith((".scm", ".scx")):
                    paths.append(os.path.join(dp, f))
    lib = build_library(paths, era)
    print("sprite kinds: %d, total seen: %d" % (len(lib), sum(lib.values())))
    byt = collections.Counter()
    for (uid, flags, terr), n in lib.items():
        byt[terr] += n
    print("by terrain:", dict(byt.most_common()))
    print("top:", [(k[0], "%04X" % k[1], k[2], v) for k, v in lib.most_common(10)])
    pickle.dump(dict(lib), open("work/sprites_%d.pkl" % era, "wb"))
    print("wrote work/sprites_%d.pkl" % era)
