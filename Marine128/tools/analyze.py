"""Extract the game structure (stages, spawn->order graph) from the source map."""
import sys, struct, os, io, collections, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from trig import parse_triggers
from decompile import Ctx, cond_text, act_text

STAGE_UNIT = 76          # Tassadar/Zeratul - stage counter held by P6
DIFF_UNITS = {195: "NORMAL", 194: "HARD", 173: "VETERAN", 157: "CLASSIC"}


def main(chk_path, outdir):
    c = CHK(open(chk_path, "rb").read())
    cx = Ctx(c)
    tr = parse_triggers(c.get("TRIG"))

    m = c.get("MRGN")
    locs = {}
    for i in range(len(m) // 20):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        locs[i + 1] = dict(idx=i + 1, name=cx.locnames.get(i + 1, ""), L=L, T=T, R=R, B=B, flags=fl)

    info = []
    for ti, t in enumerate(tr):
        stage_min = None
        stage_max = None
        diff = set()
        for x in t.active_conds():
            if x.ctype == 15 and x.unit == STAGE_UNIT and x.player == 5:
                if x.cmp == 0:
                    stage_min = x.qty if stage_min is None else max(stage_min, x.qty)
                elif x.cmp == 1:
                    stage_max = x.qty if stage_max is None else min(stage_max, x.qty)
                else:
                    stage_min = stage_max = x.qty
            if x.ctype == 15 and x.player == 6 and x.unit in DIFF_UNITS:
                diff.add(DIFF_UNITS[x.unit])
        spawn = []      # (loc, unit, count, player)
        orders = []     # (src, dst, order)
        stage_delta = 0
        for a in t.active_acts():
            if a.atype == 44:
                spawn.append((a.loc, a.unit, a.n, a.p1))
            elif a.atype == 11:
                spawn.append((a.loc, a.unit, a.n, a.p1))
            elif a.atype == 46:
                orders.append((a.loc, a.p2, a.n))
            elif a.atype == 45 and a.unit == STAGE_UNIT and a.p1 == 5:
                stage_delta = a.time if a.n == 8 else (-a.time if a.n == 9 else ("=%d" % a.time))
        info.append(dict(i=ti, players=[j for j, v in enumerate(t.players) if v],
                         stage_min=stage_min, stage_max=stage_max, diff=sorted(diff),
                         spawn=spawn, orders=orders, stage_delta=stage_delta))

    os.makedirs(outdir, exist_ok=True)
    out = io.StringIO()

    # 1. stage progression triggers
    out.write("=== STAGE COUNTER CHANGES (P6 Deaths of Tassadar/Zeratul) ===\n")
    for d in info:
        if d["stage_delta"]:
            t = tr[d["i"]]
            out.write("T%-5d stage[%s..%s] diff=%s delta=%s\n" % (
                d["i"], d["stage_min"], d["stage_max"], ",".join(d["diff"]), d["stage_delta"]))
            for x in t.active_conds():
                out.write("        C: " + cond_text(x, cx) + "\n")
    out.write("\n")

    # 2. per-stage spawn locations
    bystage = collections.defaultdict(lambda: collections.Counter())
    for d in info:
        s = d["stage_min"]
        if s is None:
            continue
        for (loc, unit, n, pl) in d["spawn"]:
            if loc:
                bystage[s][loc] += n
    out.write("=== SPAWN LOCATIONS PER STAGE GATE ===\n")
    for s in sorted(bystage):
        names = ", ".join("%s#%d(%d)" % (locs[l]["name"], l, cnt)
                          for l, cnt in bystage[s].most_common())
        out.write("stage>=%-3d : %s\n" % (s, names))
    out.write("\n")

    # 3. order graph src -> dst
    g = collections.Counter()
    for d in info:
        for (src, dst, o) in d["orders"]:
            if src and dst:
                g[(src, dst)] += 1
    out.write("=== ORDER GRAPH (src loc -> dst loc, count) ===\n")
    dstcount = collections.Counter()
    for (src, dst), n in g.most_common():
        dstcount[dst] += n
    out.write("-- top order destinations --\n")
    for dst, n in dstcount.most_common(40):
        out.write("   %-24s #%-4d  %d\n" % (locs[dst]["name"], dst, n))
    out.write("-- edges --\n")
    for (src, dst), n in sorted(g.items(), key=lambda kv: -kv[1]):
        out.write("   %-22s#%-4d -> %-22s#%-4d  x%d\n" % (
            locs[src]["name"], src, locs[dst]["name"], dst, n))
    open(os.path.join(outdir, "structure.txt"), "w", encoding="utf-8").write(out.getvalue())

    json.dump(dict(locs=locs, triggers=info), open(os.path.join(outdir, "structure.json"), "w"),
              ensure_ascii=False)
    print("wrote", outdir)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
