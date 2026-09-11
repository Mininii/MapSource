"""Verify a built map: every spawn location must be able to walk to the defence
point, the isolated rooms must stay isolated, and unit/location data must be sane.
"""
import sys, os, struct, json, collections, io
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from walk import from_chk
from trig import parse_triggers, COND_NAMES, ACT_NAMES
from decompile import Ctx

HP1 = 1

# Locations that are unreachable from the defence point in the SOURCE map too:
# the menu room and the boss arena are reached by MoveUnit teleports, by design.
EXPECTED_ISOLATED = {5, 6, 14, 46, 100, 101, 102, 119, 120, 121, 122, 123, 124,
                     125, 127, 132, 136, 149, 184, 185, 234, 235, 244, 126, 164, 218}


def verify(chk_path, roles_path="work/roles.json", out_txt=None):
    c = CHK(open(chk_path, "rb").read())
    cx = Ctx(c)
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    m = c.get("MRGN")
    locs = {}
    for i in range(len(m) // 20):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        locs[i + 1] = dict(idx=i + 1, name=cx.locnames.get(i + 1, ""), L=L, T=T, R=R, B=B)
    roles = json.load(open(roles_path, encoding="utf-8")) if os.path.exists(roles_path) else {}

    wg = from_chk(c)
    clear = wg.clearance(2)
    hp = locs[HP1]
    cxm = ((hp["L"] + hp["R"]) // 2) // 8
    cym = ((hp["T"] + hp["B"]) // 2) // 8
    starts = [(cxm + dx, cym + dy) for dx in range(-8, 9) for dy in range(-8, 9)]
    dist = wg.bfs(starts, clear)
    MW, MH = wg.MW, wg.MH

    def coverage(L):
        x0, y0 = L["L"] // 8, L["T"] // 8
        x1, y1 = max(x0, L["R"] // 8 - 1), max(y0, L["B"] // 8 - 1)
        tot = ok = 0
        best = None
        for my in range(y0, min(y1 + 1, MH)):
            row = my * MW
            for mx in range(x0, min(x1 + 1, MW)):
                tot += 1
                d = dist[row + mx]
                if d >= 0:
                    ok += 1
                    if best is None or d < best:
                        best = d
        return (100.0 * ok / tot if tot else 0.0), best

    tr = parse_triggers(c.get("TRIG"))
    used_spawn = collections.Counter()
    used_order_dst = collections.Counter()
    used_any = collections.Counter()
    for t in tr:
        for x in t.active_conds():
            if x.loc:
                used_any[x.loc] += 1
        for a in t.active_acts():
            if a.loc:
                used_any[a.loc] += 1
                if a.atype in (44, 11):
                    used_spawn[a.loc] += a.n
                if a.atype == 46 and a.p2:
                    used_order_dst[a.p2] += 1
                    used_any[a.p2] += 1

    out = io.StringIO()
    out.write("map %dx%d era=%d  locations=%d  units=%d  triggers=%d\n" % (
        w, h, era, len(locs), len(c.get("UNIT")) // 36, len(tr)))
    maxd = max([d for d in dist if d >= 0] or [0])
    out.write("reachable minitiles: %d of %d, max walk distance %d\n\n" % (
        sum(1 for d in dist if d >= 0), MW * MH, maxd))

    problems = []
    out.write("%-5s %-18s %-11s %-7s %-7s %-7s %s\n" % (
        "idx", "name", "tile", "size", "reach%", "dist", "spawns"))
    for i in sorted(locs):
        L = locs[i]
        if (L["L"], L["T"], L["R"], L["B"]) == (0, 0, 0, 0):
            if used_any.get(i):
                problems.append("loc %d '%s' is empty but used %d times" %
                                (i, L["name"], used_any[i]))
            continue
        cov, d = coverage(L)
        sp = used_spawn.get(i, 0)
        flag = ""
        if i in EXPECTED_ISOLATED:
            flag = "  (isolated room - same as source)"
        elif sp and cov < 40:
            flag = "  <-- SPAWN UNREACHABLE"
            problems.append("spawn loc %d '%s' only %.0f%% reachable" % (i, L["name"], cov))
        elif used_order_dst.get(i) and cov < 40 and i != HP1:
            flag += "  <-- ORDER TARGET UNREACHABLE"
            problems.append("order target loc %d '%s' only %.0f%% reachable" % (i, L["name"], cov))
        out.write("%-5d %-18s %3d,%-7d %2dx%-4d %-7.0f %-7s %-7d%s\n" % (
            i, L["name"][:18], L["L"] // 32, L["T"] // 32,
            (L["R"] - L["L"]) // 32, (L["B"] - L["T"]) // 32,
            cov, str(d) if d is not None else "-", sp, flag))

    # the rooms that must stay isolated, and the ones that must stay connected
    for i in (5, 100, 101, 124):
        if i in locs:
            cov, d = coverage(locs[i])
            if cov > 10:
                problems.append("loc %d '%s' should be isolated but is %.0f%% reachable"
                                % (i, locs[i]["name"], cov))
    missing_rect = [i for i in used_any
                    if i in locs and (locs[i]["L"], locs[i]["T"], locs[i]["R"], locs[i]["B"]) == (0, 0, 0, 0)]
    for i in missing_rect:
        problems.append("loc %d '%s' has an empty rectangle but is used by triggers"
                        % (i, locs[i]["name"]))

    out.write("\n=== PROBLEMS (%d) ===\n" % len(problems))
    for p in problems:
        out.write("  " + p + "\n")
    txt = out.getvalue()
    if out_txt:
        open(out_txt, "w", encoding="utf-8").write(txt)
    return txt, problems


if __name__ == "__main__":
    txt, problems = verify(sys.argv[1], out_txt=sys.argv[2] if len(sys.argv) > 2 else None)
    lines = txt.splitlines()
    print("\n".join(lines[:6]))
    print("...")
    print("\n".join(lines[-(len(problems) + 3):]))
