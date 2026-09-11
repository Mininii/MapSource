"""Enumerate ISOM terrain types for a tileset and describe them
(pure-cell tile group, walkability, height, buildability)."""
import sys, os, struct, collections, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tileset import Tileset, WALKABLE, HIGH_GROUND, MID_GROUND, RAMP

EVEN = (8, 10, 0, 2)
ODD = (4, 12, 14, 6)


def pure_key(t, parity):
    off = EVEN if parity == 0 else ODD
    return tuple((t << 4) | o for o in off)


def main(era, tablepath):
    ts = Tileset(era)
    d = pickle.load(open(tablepath, "rb"))
    table = d["table"]
    best = d["best"]
    types = collections.Counter()
    for k in table:
        for v in k:
            types[v >> 4] += sum(table[k].values())
    print("distinct ISOM types seen: %d" % len(types))
    print("%-6s %-9s %-28s %-9s %-6s %-6s %s" % (
        "type", "samples", "pure-cell tiles", "walk%", "height", "build", "cv5idx"))
    rows = []
    for t in sorted(types):
        found = None
        for parity in (0, 1):
            k = pure_key(t, parity)
            if k in best:
                found = best[k]
                break
        if not found:
            rows.append((t, types[t], None, None, None, None, None))
            continue
        g0, g1 = found
        walk = 0
        tot = 0
        for g in (g0, g1):
            grp = ts.groups[g]
            mt = grp.megatiles[0]
            fl = struct.unpack_from("<16H", ts.vf4, mt * 32) if mt < ts.nmega else [0] * 16
            walk += sum(1 for f in fl if f & WALKABLE)
            tot += 16
        grp = ts.groups[g0]
        rows.append((t, types[t], (g0, g1), 100.0 * walk / tot, grp.ground_height,
                     grp.buildability, grp.index))
    for r in rows:
        print("%-6s %-9s %-28s %-9s %-6s %-6s %s" % (
            r[0], r[1], r[2], ("%.0f" % r[3]) if r[3] is not None else "-",
            r[4], r[5], r[6]))


if __name__ == "__main__":
    main(int(sys.argv[1]), sys.argv[2])
