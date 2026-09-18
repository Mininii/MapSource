"""Round-trip test: read a real map's ISOM, rebuild MTXM from the learned table,
compare with the map's own MTXM."""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from isom_table import load_map
from isom_gen import IsomTable, EVEN, ODD


def test(path, table):
    m = load_map(path)
    if not m:
        return None
    w, h, iw, ih, cells, tiles = m["w"], m["h"], m["iw"], m["ih"], m["cells"], m["tiles"]
    same = diff = miss = dood = 0
    for iy in range(min(ih, h)):
        for ix in range(iw):
            tx = ix * 2
            if tx + 1 >= w:
                continue
            k = cells[iy * iw + ix]
            g0 = tiles[iy * w + tx] >> 4
            g1 = tiles[iy * w + tx + 1] >> 4
            if g0 >= 1024 or g1 >= 1024:
                dood += 1
                continue
            pred = table.best.get(k)
            if pred is None:
                miss += 1
                continue
            if pred == (g0, g1):
                same += 1
            else:
                diff += 1
    return dict(map=os.path.basename(path), era=m["era"], w=w, h=h,
                same=same, diff=diff, miss=miss, dood=dood)


if __name__ == "__main__":
    ERA = int(os.environ.get("ERA", "7"))
    table = IsomTable(sys.argv[1])
    print("table: parity0 keys=%d parity1 keys=%d" % (
        len(table.keys[0]), len(table.keys[1])))
    tot = collections.Counter()
    for p in sys.argv[2:]:
        try:
            r = test(p, table)
        except Exception as e:
            continue
        if not r or r["era"] != ERA:
            continue
        n = r["same"] + r["diff"] + r["miss"]
        print("%-38s %3dx%-3d match=%.4f miss=%d doodad=%d" % (
            r["map"][:38], r["w"], r["h"], r["same"] / max(1, n), r["miss"], r["dood"]))
        for k in ("same", "diff", "miss", "dood"):
            tot[k] += r[k]
    n = tot["same"] + tot["diff"] + tot["miss"]
    print("TOTAL match=%.4f (same=%d diff=%d miss=%d doodadskipped=%d)" % (
        tot["same"] / max(1, n), tot["same"], tot["diff"], tot["miss"], tot["dood"]))
