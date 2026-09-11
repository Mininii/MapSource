"""Classify every location of the source map by role, and measure its walking
distance to the defence point hp1."""
import sys, os, struct, io, collections, json
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from trig import parse_triggers, COND_NAMES, ACT_NAMES
from decompile import Ctx
from walk import from_chk

HP1 = 1


def main(chk_path, out_txt, out_json):
    c = CHK(open(chk_path, "rb").read())
    cx = Ctx(c)
    tr = parse_triggers(c.get("TRIG"))
    m = c.get("MRGN")
    n = len(m) // 20
    locs = {}
    for i in range(n):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        locs[i + 1] = dict(idx=i + 1, name=cx.locnames.get(i + 1, ""), L=L, T=T, R=R, B=B,
                           flags=fl, used=collections.Counter(), spawn_units=collections.Counter(),
                           spawn_total=0, spawn_players=collections.Counter(),
                           order_to=collections.Counter(), order_from=collections.Counter(),
                           bring_players=collections.Counter())
    for t in tr:
        players = [j for j, v in enumerate(t.players) if v]
        for x in t.active_conds():
            if x.loc and x.loc in locs:
                locs[x.loc]["used"][COND_NAMES.get(x.ctype, str(x.ctype))] += 1
                if x.ctype == 3:
                    locs[x.loc]["bring_players"][x.player] += 1
        for a in t.active_acts():
            if a.loc and a.loc in locs:
                locs[a.loc]["used"][ACT_NAMES.get(a.atype, str(a.atype))] += 1
                if a.atype in (44, 11):
                    locs[a.loc]["spawn_units"][a.unit] += a.n
                    locs[a.loc]["spawn_total"] += a.n
                    locs[a.loc]["spawn_players"][a.p1] += 1
                if a.atype == 46 and a.p2 in locs:
                    locs[a.loc]["order_to"][a.p2] += 1
                    locs[a.p2]["order_from"][a.loc] += 1

    wg = from_chk(c)
    clear = wg.clearance(2)
    hp = locs[HP1]
    cxm = ((hp["L"] + hp["R"]) // 2) // 8
    cym = ((hp["T"] + hp["B"]) // 2) // 8
    starts = [(cxm + dx, cym + dy) for dx in range(-8, 9) for dy in range(-8, 9)]
    dist = wg.bfs(starts, clear)
    MW = wg.MW

    def loc_dist(L):
        x0, y0 = L["L"] // 8, L["T"] // 8
        x1, y1 = max(x0, L["R"] // 8 - 1), max(y0, L["B"] // 8 - 1)
        best = None
        cnt = 0
        for my in range(y0, min(y1 + 1, wg.MH)):
            row = my * MW
            for mx in range(x0, min(x1 + 1, MW)):
                d = dist[row + mx]
                if d >= 0:
                    cnt += 1
                    if best is None or d < best:
                        best = d
        return best, cnt, (x1 - x0 + 1) * (y1 - y0 + 1)

    out = io.StringIO()
    out.write("%-5s %-20s %-9s %-7s %-7s %-6s %-8s %s\n" % (
        "idx", "name", "tilepos", "size", "dist", "walk%", "spawns", "roles"))
    js = {}
    for i in sorted(locs):
        L = locs[i]
        if (L["L"], L["T"], L["R"], L["B"]) == (0, 0, 0, 0) and not L["name"]:
            continue
        d, walkn, tot = loc_dist(L)
        role = []
        if L["spawn_total"]:
            role.append("SPAWN(%d)" % L["spawn_total"])
        if L["order_from"]:
            role.append("ORDERDST(%d)" % sum(L["order_from"].values()))
        if L["used"].get("Bring"):
            role.append("BRING")
        if L["used"].get("CommandLeastAt"):
            role.append("RANDOM")
        if L["used"].get("CenterView"):
            role.append("VIEW")
        if L["used"].get("RunAIScriptAt"):
            role.append("AI")
        if L["used"].get("MoveUnit") or L["used"].get("MoveLocation"):
            role.append("MOVE")
        wpc = (100.0 * walkn / tot) if tot else 0
        out.write("%-5d %-20s %3d,%-5d %3dx%-3d %-7s %-6.0f %-8d %s\n" % (
            i, L["name"][:20], L["L"] // 32, L["T"] // 32,
            (L["R"] - L["L"]) // 32, (L["B"] - L["T"]) // 32,
            str(d) if d is not None else "-", wpc, L["spawn_total"], ",".join(role)))
        js[i] = dict(idx=i, name=L["name"], L=L["L"], T=L["T"], R=L["R"], B=L["B"],
                     flags=L["flags"], dist=d, walkpct=wpc, spawn=L["spawn_total"],
                     roles=role, used=dict(L["used"]),
                     spawn_units=dict(L["spawn_units"]),
                     spawn_players=dict(L["spawn_players"]),
                     order_to=dict(L["order_to"]), order_from=dict(L["order_from"]))
    open(out_txt, "w", encoding="utf-8").write(out.getvalue())
    json.dump(js, open(out_json, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print("wrote", out_txt, out_json)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], sys.argv[3])
