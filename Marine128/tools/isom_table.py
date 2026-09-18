"""Build an ISOM-cell -> tile-group lookup table from clean Blizzard melee maps."""
import sys, os, struct, collections, json, pickle
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from mpq import MPQ
from chk import CHK


def load_map(path):
    try:
        with MPQ(path) as m:
            d = m.read("staredit\\scenario.chk")
    except Exception:
        d = open(path, "rb").read()
    c = CHK(d)
    if not c.get("DIM") or not c.get("ERA") or not c.get("MTXM"):
        return None
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    isom = c.get("ISOM")
    iw, ih = w // 2 + 1, h + 1
    if not isom or len(isom) != iw * ih * 8:
        return None
    cells = [struct.unpack_from("<4H", isom, i * 8) for i in range(iw * ih)]
    return dict(w=w, h=h, era=era, tiles=tiles, cells=cells, iw=iw, ih=ih)


def build(paths, era_want):
    table = collections.defaultdict(collections.Counter)
    nmaps = 0
    for p in paths:
        try:
            m = load_map(p)
        except Exception:
            m = None
        if not m or m["era"] != era_want:
            continue
        nmaps += 1
        w, h, tiles, cells, iw, ih = m["w"], m["h"], m["tiles"], m["cells"], m["iw"], m["ih"]
        for iy in range(ih):
            for ix in range(iw):
                cl = cells[iy * iw + ix]
                tx, ty = ix * 2, iy
                if tx + 1 >= w or ty >= h:
                    continue
                t0, t1 = tiles[ty * w + tx], tiles[ty * w + tx + 1]
                g0, g1 = t0 >> 4, t1 >> 4
                if g0 >= 1024 or g1 >= 1024:
                    continue          # doodad-stamped tile
                table[cl][(g0, g1)] += 1
    return table, nmaps


def report(table):
    n = sum(sum(c.values()) for c in table.values())
    good = sum(c.most_common(1)[0][1] for c in table.values())
    print("cells keys=%d samples=%d determinism=%.4f" % (len(table), n, good / n))
    amb = [(k, c) for k, c in table.items() if len(c) > 1]
    amb.sort(key=lambda kc: -sum(kc[1].values()))
    print("ambiguous keys:", len(amb))
    for k, c in amb[:8]:
        print("  ", k, c.most_common(4))


if __name__ == "__main__":
    era = int(sys.argv[1])
    out = sys.argv[2]
    roots = sys.argv[3:]
    paths = []
    for r in roots:
        for dp, dn, fn in os.walk(r):
            for f in fn:
                if f.lower().endswith((".scm", ".scx")):
                    paths.append(os.path.join(dp, f))
    table, nmaps = build(paths, era)
    print("maps used:", nmaps)
    report(table)
    best = {k: c.most_common(1)[0][0] for k, c in table.items()}
    pickle.dump(dict(table={k: dict(c) for k, c in table.items()}, best=best),
                open(out, "wb"))
    print("wrote", out, len(best), "entries")
