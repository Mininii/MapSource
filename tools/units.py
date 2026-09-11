"""Analyse the preplaced UNIT section: what is decoration, what is functional."""
import sys, os, struct, io, collections, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from decompile import Ctx, load_unit_names
from trig import parse_triggers

UNIT_SIZE = 36


def parse_units(data):
    out = []
    for i in range(len(data) // UNIT_SIZE):
        (cls, x, y, uid, rel, sflags, vflags, player, hp, sh, en, res, hangar,
         uflags, unused, rel2) = struct.unpack_from("<IHHHHHHBBBBIHHII", data, i * UNIT_SIZE)
        out.append(dict(i=i, cls=cls, x=x, y=y, uid=uid, rel=rel, sflags=sflags,
                        vflags=vflags, player=player, hp=hp, sh=sh, en=en, res=res,
                        hangar=hangar, uflags=uflags, rel2=rel2))
    return out


def pack_units(units):
    b = bytearray()
    for u in units:
        b += struct.pack("<IHHHHHHBBBBIHHII", u["cls"], u["x"], u["y"], u["uid"], u["rel"],
                         u["sflags"], u["vflags"], u["player"], u["hp"], u["sh"], u["en"],
                         u["res"], u["hangar"], u["uflags"], u["unused"] if "unused" in u else 0,
                         u["rel2"])
    return bytes(b)


def main(chk_path, out_txt):
    c = CHK(open(chk_path, "rb").read())
    cx = Ctx(c)
    names = load_unit_names()
    units = parse_units(c.get("UNIT"))
    m = c.get("MRGN")
    locs = []
    for i in range(len(m) // 20):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        locs.append((i + 1, L, T, R, B, cx.locnames.get(i + 1, "")))

    # which unit types are referenced by triggers, and how
    tr = parse_triggers(c.get("TRIG"))
    ref_bring = collections.Counter()
    ref_cmd = collections.Counter()
    ref_deaths = collections.Counter()
    for t in tr:
        for x in t.active_conds():
            if x.ctype == 3:
                ref_bring[x.unit] += 1
            elif x.ctype in (2, 6, 7, 16, 17):
                ref_cmd[x.unit] += 1
            elif x.ctype == 15:
                ref_deaths[x.unit] += 1

    out = io.StringIO()
    byplayer = collections.Counter()
    bytype = collections.Counter()
    for u in units:
        byplayer[u["player"]] += 1
        bytype[(u["player"], u["uid"])] += 1
    out.write("total units: %d\n" % len(units))
    out.write("by player: %s\n\n" % dict(sorted(byplayer.items())))
    out.write("%-4s %-30s %-6s %-8s %-8s %-8s %s\n" % (
        "pl", "unit", "count", "bringRef", "cmdRef", "deathRef", "note"))
    for (pl, uid), n in sorted(bytype.items(), key=lambda kv: (kv[0][0], -kv[1])):
        nm = names[uid] if uid < len(names) else "?"
        out.write("%-4d %-30s %-6d %-8d %-8d %-8d\n" % (
            pl, "%s#%d" % (nm, uid), n, ref_bring.get(uid, 0), ref_cmd.get(uid, 0),
            ref_deaths.get(uid, 0)))

    # units inside each location
    out.write("\n--- units per location ---\n")
    inloc = collections.defaultdict(list)
    for u in units:
        for (idx, L, T, R, B, nm) in locs:
            if (R - L) > 4000 or (B - T) > 4000:
                continue
            if L <= u["x"] < R and T <= u["y"] < B:
                inloc[idx].append(u)
    for idx in sorted(inloc):
        nm = [l[5] for l in locs if l[0] == idx][0]
        cc = collections.Counter("%s#%d/P%d" % (names[u["uid"]] if u["uid"] < len(names) else "?",
                                                u["uid"], u["player"] + 1) for u in inloc[idx])
        out.write("loc%-4d %-18s %s\n" % (idx, nm[:18], dict(cc.most_common(8))))
    nofree = [u for u in units if not any(
        L <= u["x"] < R and T <= u["y"] < B and (R - L) <= 4000 and (B - T) <= 4000
        for (idx, L, T, R, B, nm) in locs)]
    out.write("\nunits not inside any location: %d\n" % len(nofree))
    cc = collections.Counter("%s#%d/P%d" % (names[u["uid"]] if u["uid"] < len(names) else "?",
                                            u["uid"], u["player"] + 1) for u in nofree)
    for k, v in cc.most_common(40):
        out.write("   %-34s %d\n" % (k, v))
    open(out_txt, "w", encoding="utf-8").write(out.getvalue())
    print("wrote", out_txt)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
