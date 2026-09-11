"""Scan real maps for ramp tiles and record the exact ISOM cell type-tuples,
plus the surrounding side-type context, so ramps can be reproduced."""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tileset import Tileset, RAMP, WALKABLE
from isom_table import load_map
from sides_probe import sides_of

era = int(sys.argv[1])
ts = Tileset(era)


def tile_has_ramp(t):
    mt = ts.megatile(t)
    if mt is None or mt >= ts.nmega:
        return False
    fl = struct.unpack_from("<16H", ts.vf4, mt * 32)
    return any(f & RAMP for f in fl)


tuples = collections.Counter()
ctx = collections.Counter()
for p in sys.argv[2:]:
    try:
        m = load_map(p)
    except Exception:
        continue
    if not m or m["era"] != era:
        continue
    w, h, iw, ih, cells, tiles = m["w"], m["h"], m["iw"], m["ih"], m["cells"], m["tiles"]
    V, H = sides_of(m)
    for iy in range(min(ih, h)):
        for ix in range(iw):
            tx = ix * 2
            if tx + 1 >= w:
                continue
            t0, t1 = tiles[iy * w + tx], tiles[iy * w + tx + 1]
            if (t0 >> 4) >= 1024 or (t1 >> 4) >= 1024:
                continue
            if tile_has_ramp(t0) or tile_has_ramp(t1):
                types = (V[iy][ix], H[iy][ix], V[iy][ix + 1], H[iy + 1][ix])
                tuples[types] += 1
                ctx[tuple(sorted(set(types)))] += 1

print("distinct ramp cell tuples:", len(tuples), " total cells:", sum(tuples.values()))
for t, n in tuples.most_common(40):
    print("   ", t, n)
print("\nramp type sets:")
for t, n in ctx.most_common(20):
    print("   ", t, n)
