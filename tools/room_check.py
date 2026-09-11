"""Check the isolated rooms internally: the menu room's control unit must be able
to walk to every difficulty beacon, and the boss arena must be self-connected."""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from walk import from_chk
from decompile import Ctx

MENU_START = 124                     # 'player1' - where the control probe spawns
MENU_TARGETS = [119, 120, 121, 122, 123, 125, 127, 132, 136, 149, 244, 5, 14, 102]
BOSS_START = 100                     # 'T4' - where the player is teleported in
BOSS_TARGETS = [101, 184, 185, 234, 235, 46]


def centre(L):
    return (((L["L"] + L["R"]) // 2) // 8, ((L["T"] + L["B"]) // 2) // 8)


def main(chk_path):
    c = CHK(open(chk_path, "rb").read())
    cx = Ctx(c)
    m = c.get("MRGN")
    locs = {}
    for i in range(len(m) // 20):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        locs[i + 1] = dict(idx=i + 1, name=cx.locnames.get(i + 1, ""), L=L, T=T, R=R, B=B)
    wg = from_chk(c)
    clear = wg.clearance(2)
    ok = True
    for start, targets, label in ((MENU_START, MENU_TARGETS, "menu room"),
                                  (BOSS_START, BOSS_TARGETS, "boss arena")):
        s = locs[start]
        sx, sy = centre(s)
        seeds = [(sx + dx, sy + dy) for dx in range(-3, 4) for dy in range(-3, 4)]
        dist = wg.bfs(seeds, clear)
        print("\n%s: start '%s' at tile (%d,%d)" % (label, s["name"], s["L"] // 32, s["T"] // 32))
        if all(d < 0 for d in dist):
            print("   start tile is not walkable!")
            ok = False
            continue
        for t in targets:
            L = locs[t]
            x0, y0 = L["L"] // 8, L["T"] // 8
            x1, y1 = max(x0, L["R"] // 8 - 1), max(y0, L["B"] // 8 - 1)
            best = None
            for my in range(y0, min(y1 + 1, wg.MH)):
                row = my * wg.MW
                for mx in range(x0, min(x1 + 1, wg.MW)):
                    d = dist[row + mx]
                    if d >= 0 and (best is None or d < best):
                        best = d
            mark = "ok " if best is not None else "NOT REACHABLE"
            if best is None:
                ok = False
            print("   %-5d %-16s %s%s" % (
                t, L["name"][:16], mark, (" (%d minitiles)" % best) if best is not None else ""))
    print("\nroom check:", "PASS" if ok else "FAIL")
    return ok


if __name__ == "__main__":
    main(sys.argv[1])
