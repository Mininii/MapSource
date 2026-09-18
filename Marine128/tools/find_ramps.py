"""Find which ISOM type-tuples produce ramp tiles (walkable low<->high links)."""
import sys, os, struct, collections, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tileset import Tileset, WALKABLE, RAMP, HIGH_GROUND, MID_GROUND
from isom_gen import EVEN, ODD

era = int(sys.argv[1])
ts = Tileset(era)
d = pickle.load(open(sys.argv[2], "rb"))
best = d["table"]

ramp_keys = collections.Counter()
type_ramp = collections.Counter()
for k, cnt in best.items():
    total = sum(cnt.values())
    pair = max(cnt.items(), key=lambda kv: kv[1])[0]
    isramp = False
    for g in pair:
        if g >= len(ts.groups):
            continue
        for sub in range(16):
            mt = ts.groups[g].megatiles[sub]
            if mt == 0 or mt >= ts.nmega:
                continue
            fl = struct.unpack_from("<16H", ts.vf4, mt * 32)
            if any(f & RAMP for f in fl):
                isramp = True
                break
        if isramp:
            break
    if isramp:
        types = tuple(v >> 4 for v in k)
        ramp_keys[types] += total
        for t in types:
            type_ramp[t] += total

print("ramp-producing type tuples:", len(ramp_keys))
for t, n in ramp_keys.most_common(30):
    print("  ", t, n)
print("\ntypes appearing in ramp tuples:")
for t, n in type_ramp.most_common(30):
    print("   type %-4d %d" % (t, n))
