"""Work out, for any tileset, which ISOM terrain types to use as floor, cliff,
water and peak - and which floor variants can sit next to the main floor without
a cliff growing between them.

Everything is measured, not hard-coded: the pure-cell tiles of each type give its
height and walkability, and a band test tells us which pairs actually work.
"""
import sys, os, struct, pickle, collections, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tileset import Tileset
from isom_gen import EVEN, ODD

CACHE_DIR = "work"


def pure_key(t, parity):
    off = EVEN if parity == 0 else ODD
    return tuple((t << 4) | o for o in off)


def describe_types(era, tablepath):
    """{type: dict(height, walk, build, freq, tiles)} for every type with a pure cell."""
    ts = Tileset(era)
    d = pickle.load(open(tablepath, "rb"))
    best = d["best"]
    freq = collections.Counter()
    for k, cnt in d["table"].items():
        n = sum(cnt.values())
        for v in k:
            freq[v >> 4] += n
    out = {}
    for t in range(1, 256):
        pair = None
        for parity in (0, 1):
            pair = best.get(pure_key(t, parity))
            if pair:
                break
        if not pair:
            continue
        g0, g1 = pair
        if g0 >= len(ts.groups) or g1 >= len(ts.groups):
            continue
        walk = tot = 0
        for g in (g0, g1):
            for sub in range(16):
                mt = ts.groups[g].megatiles[sub]
                if mt == 0 or mt >= ts.nmega:
                    continue
                fl = struct.unpack_from("<16H", ts.vf4, mt * 32)
                walk += sum(1 for f in fl if f & 1)
                tot += 16
        out[t] = dict(height=ts.groups[g0].ground_height,
                      build=ts.groups[g0].buildability,
                      cv5idx=ts.groups[g0].index,
                      freq=freq[t],
                      walk=(walk / tot) if tot else 0.0,
                      tiles=pair)
    return out


def band_walkable(era, tablepath, a, b, seed=11):
    """Generate a straight A|B boundary and measure how walkable the seam is.
    Returns None when the tileset cannot make that boundary at all."""
    from terrain import TerrainBuilder
    W = H = 64
    ts = Tileset(era)
    tb = TerrainBuilder(W, H, tablepath, era=era, seed=seed)
    mid = tb.ih // 2
    tb.set_region(lambda ix, iy: a if iy < mid else b)
    if not tb.build(pin_radius=2, max_repair=30, log=lambda s: None):
        return None
    tiles, _ = tb.tiles()
    n = ok = 0
    for ty in range(H // 2 - 4, H // 2 + 4):
        for tx in range(W):
            t = tiles[ty * W + tx]
            mt = ts.megatile(t)
            if mt is None or mt >= ts.nmega:
                continue
            fl = struct.unpack_from("<16H", ts.vf4, mt * 32)
            n += 16
            ok += sum(1 for f in fl if f & 1)
    return (ok / n) if n else 0.0


def build_profile(era, tablepath, log=print):
    info = describe_types(era, tablepath)
    # the most used type of each kind is the tileset's "default" terrain
    by_freq = lambda t: -info[t]["freq"]
    lows = sorted((t for t, v in info.items() if v["height"] == 0 and v["walk"] > 0.99),
                  key=by_freq)
    highs = sorted((t for t, v in info.items() if v["height"] == 2 and v["walk"] > 0.99),
                   key=by_freq)
    peaks = sorted((t for t, v in info.items() if v["height"] >= 4 and v["walk"] > 0.99),
                   key=by_freq)
    waters = sorted((t for t, v in info.items() if v["walk"] < 0.02), key=by_freq)
    if not lows or not highs:
        raise SystemExit("tileset %d has no usable floor/cliff pair" % era)
    low = lows[0]
    high = highs[0]
    log("era %d: floor candidates %s, cliff %s, peak %s, water %s"
        % (era, lows, highs, peaks, waters))
    variants = []
    for t in lows[1:]:
        f = band_walkable(era, tablepath, low, t)
        log("   floor %-3d vs %-3d -> %s" % (low, t, "fail" if f is None else "%.2f" % f))
        if f is not None and f > 0.995:
            variants.append(t)
    water = None
    for t in waters:
        if band_walkable(era, tablepath, low, t) is not None:
            water = t
            break
    peak = None
    for t in peaks:
        # a peak has to sit inside the cliff type, not next to the floor
        W = H = 64
        from terrain import TerrainBuilder
        tb = TerrainBuilder(W, H, tablepath, era=era, seed=5)
        my, mx = tb.ih // 2, tb.iw // 2
        tb.set_region(lambda ix, iy: t if abs(ix - mx) + abs(iy - my) <= 6
                      else (high if abs(ix - mx) + abs(iy - my) <= 14 else low))
        if tb.build(pin_radius=2, max_repair=25, log=lambda s: None):
            peak = t
            break
    prof = dict(era=era, low=low, high=high, water=water, peak=peak,
                variants=variants[:4],
                passable=sorted(set([low] + variants[:4])))
    log("era %d profile: %s" % (era, prof))
    return prof


def load_profile(era, tablepath, log=print):
    path = os.path.join(CACHE_DIR, "profile_%d.json" % era)
    if os.path.exists(path):
        return json.load(open(path))
    prof = build_profile(era, tablepath, log)
    json.dump(prof, open(path, "w"), indent=1)
    return prof


if __name__ == "__main__":
    era = int(sys.argv[1])
    tablepath = sys.argv[2]
    print(json.dumps(load_profile(era, tablepath), indent=1))
