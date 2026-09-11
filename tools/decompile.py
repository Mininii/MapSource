"""Decompile CHK TRIG into readable text."""
import sys, struct, os, io
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from trig import parse_triggers, COND_NAMES, ACT_NAMES

STAT_TXT = r"C:\Users\USER\Documents\theSeed\stat_txt.tbl"


def load_unit_names(path=STAT_TXT):
    d = open(path, "rb").read()
    n = struct.unpack_from("<H", d, 0)[0]
    offs = struct.unpack_from("<%dH" % n, d, 2)

    def g(i):
        o = offs[i]
        e = d.find(b"\0", o)
        return d[o:e].decode("latin1")
    return [g(i) for i in range(n)]


PLAYERS = {0: "P1", 1: "P2", 2: "P3", 3: "P4", 4: "P5", 5: "P6", 6: "P7", 7: "P8",
           8: "P9", 9: "P10", 10: "P11", 11: "P12", 12: "None", 13: "CurrentPlayer",
           14: "Foes", 15: "Allies", 16: "NeutralPlayers", 17: "AllPlayers",
           18: "Force1", 19: "Force2", 20: "Force3", 21: "Force4", 22: "Unused1",
           23: "Unused2", 24: "Unused3", 25: "Unused4", 26: "NonAlliedVictoryPlayers"}
CMP = {0: "AtLeast", 1: "AtMost", 10: "Exactly"}
MOD = {7: "SetTo", 8: "Add", 9: "Subtract"}
RES = {0: "ore", 1: "gas", 2: "oreAndGas"}
SCORE = {0: "total", 1: "units", 2: "buildings", 3: "unitsAndBuildings", 4: "kills",
         5: "razings", 6: "killsAndRazings", 7: "custom"}
SWSTATE = {2: "set", 3: "cleared"}
SWACT = {4: "set", 5: "clear", 6: "toggle", 11: "randomize"}
ORDER = {0: "Move", 1: "Patrol", 2: "Attack"}
PROPSTATE = {0: "disable", 1: "enable", 2: "toggle"}
ALLY = {0: "Enemy", 1: "Ally", 2: "AlliedVictory"}
UNITMOD = {0: "NoUnits", 1: "SetTo", 2: "Add", 3: "Subtract", 7: "AllUnits"}


class Ctx:
    def __init__(self, chk):
        self.c = chk
        s = chk.get("STR")
        self.s = s
        self.nstr = struct.unpack_from("<H", s, 0)[0]
        self.offs = struct.unpack_from("<%dH" % self.nstr, s, 2)
        m = chk.get("MRGN")
        self.locnames = {}
        for i in range(len(m) // 20):
            L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
            self.locnames[i + 1] = self.str(sid) or ("Location %d" % (i + 1))
        self.units = load_unit_names()

    def str(self, i):
        if i <= 0 or i > self.nstr:
            return ""
        o = self.offs[i - 1]
        e = self.s.find(b"\0", o)
        return self.s[o:e].decode("utf-8", "replace")

    def loc(self, i):
        if i == 0:
            return "-"
        return "'%s'#%d" % (self.locnames.get(i, "?"), i)

    def unit(self, i):
        special = {229: "AnyUnit", 230: "Men", 231: "Buildings", 232: "Factories"}
        if i in special:
            return special[i]
        return "%s#%d" % (self.units[i] if i < len(self.units) else "?", i)


def cond_text(x, cx):
    n = COND_NAMES.get(x.ctype, "Cond%d" % x.ctype)
    p = PLAYERS.get(x.player, "Player%d" % x.player)
    t = x.ctype
    if t == 1:
        return "CountdownTimer(%s, %d)" % (CMP.get(x.cmp, x.cmp), x.qty)
    if t == 2:
        return "Command(%s, %s, %s, %d)" % (p, cx.unit(x.unit), CMP.get(x.cmp, x.cmp), x.qty)
    if t == 3:
        return "Bring(%s, %s, %s, %s, %d)" % (p, cx.unit(x.unit), cx.loc(x.loc), CMP.get(x.cmp, x.cmp), x.qty)
    if t == 4:
        return "Accumulate(%s, %s, %d, %s)" % (p, CMP.get(x.cmp, x.cmp), x.qty, RES.get(x.flags10, x.flags10))
    if t == 5:
        return "Kill(%s, %s, %s, %d)" % (p, cx.unit(x.unit), CMP.get(x.cmp, x.cmp), x.qty)
    if t == 11:
        return "Switch(Switch%d, %s)" % (x.qty, SWSTATE.get(x.cmp, x.cmp))
    if t == 12:
        return "ElapsedTime(%s, %d)" % (CMP.get(x.cmp, x.cmp), x.qty)
    if t == 14:
        return "Opponents(%s, %s, %d)" % (p, CMP.get(x.cmp, x.cmp), x.qty)
    if t == 15:
        return "Deaths(%s, %s, %s, %d)" % (p, cx.unit(x.unit), CMP.get(x.cmp, x.cmp), x.qty)
    if t in (7, 17):
        return "%s(%s, %s, %s)" % (n, p, cx.unit(x.unit), cx.loc(x.loc))
    if t in (6, 16, 8, 18):
        return "%s(%s, %s)" % (n, p, cx.unit(x.unit))
    if t in (9, 19):
        return "%s(%s, %s)" % (n, p, SCORE.get(x.flags10, x.flags10))
    if t in (10, 20):
        return "%s(%s, %s)" % (n, p, RES.get(x.flags10, x.flags10))
    if t == 21:
        return "Score(%s, %s, %s, %d)" % (p, SCORE.get(x.flags10, x.flags10), CMP.get(x.cmp, x.cmp), x.qty)
    if t == 22:
        return "Always()"
    if t == 23:
        return "Never()"
    return "%s(loc=%s p=%s qty=%d unit=%s cmp=%d f10=%d f11=%d mask=%04X)" % (
        n, cx.loc(x.loc), p, x.qty, cx.unit(x.unit), x.cmp, x.flags10, x.flags11, x.mask)


def act_text(a, cx):
    n = ACT_NAMES.get(a.atype, "Act%d" % a.atype)
    p1 = PLAYERS.get(a.p1, "Player%d" % a.p1)
    p2 = PLAYERS.get(a.p2, "Player%d" % a.p2)

    def S(i):
        if not i:
            return "-"
        return "'%s'" % cx.str(i).replace("\r", "\\r").replace("\n", "\\n")
    t = a.atype
    if t == 3:
        return "PreserveTrigger()"
    if t == 4:
        return "Wait(%d)" % a.time
    if t == 7:
        return "Transmission(%s, %s, %s, %s, %d, %s)" % (
            cx.unit(a.unit), cx.loc(a.loc), p1, MOD.get(a.n, a.n), a.time, S(a.strid))
    if t == 8:
        return "PlayWAV(%s)" % S(a.wav)
    if t == 9:
        return "DisplayText(%s)" % S(a.strid)
    if t == 10:
        return "CenterView(%s)" % cx.loc(a.loc)
    if t == 11:
        return "CreateUnitWithProperties(%d, %s, %s, %s, prop=%d)" % (
            a.n, cx.unit(a.unit), cx.loc(a.loc), p1, a.p2)
    if t == 12:
        return "SetMissionObjectives(%s)" % S(a.strid)
    if t == 13:
        return "SetSwitch(Switch%d, %s)" % (a.p2, SWACT.get(a.n, a.n))
    if t == 14:
        return "SetCountdownTimer(%s, %d)" % (MOD.get(a.n, a.n), a.time)
    if t == 15:
        return "RunAIScript(%s)" % struct.pack("<I", a.p1).decode("latin1")
    if t == 16:
        return "RunAIScriptAt(%s, %s)" % (struct.pack("<I", a.p1).decode("latin1"), cx.loc(a.loc))
    if t in (17, 18):
        return "%s(%s, %s, %s)" % (n, S(a.strid), cx.unit(a.unit), cx.loc(a.loc))
    if t == 19:
        return "LeaderBoardResources(%s, %s)" % (S(a.strid), RES.get(a.unit, a.unit))
    if t in (20, 21):
        return "%s(%s, %s)" % (n, S(a.strid), cx.unit(a.unit))
    if t == 22:
        return "KillUnit(%s, %s)" % (cx.unit(a.unit), p1)
    if t == 23:
        return "KillUnitAt(%s, %s, %s, %s)" % (a.n, cx.unit(a.unit), cx.loc(a.loc), p1)
    if t == 24:
        return "RemoveUnit(%s, %s)" % (cx.unit(a.unit), p1)
    if t == 25:
        return "RemoveUnitAt(%s, %s, %s, %s)" % (a.n, cx.unit(a.unit), cx.loc(a.loc), p1)
    if t == 26:
        return "SetResources(%s, %s, %d, %s)" % (p1, MOD.get(a.n, a.n), a.time, RES.get(a.unit, a.unit))
    if t == 27:
        return "SetScore(%s, %s, %d, %s)" % (p1, MOD.get(a.n, a.n), a.time, SCORE.get(a.unit, a.unit))
    if t == 28:
        return "MinimapPing(%s)" % cx.loc(a.loc)
    if t == 29:
        return "TalkingPortrait(%s, %d)" % (cx.unit(a.unit), a.time)
    if t in (30, 31):
        return "%s(%s)" % (n, p1)
    if t == 38:
        return "MoveLocation(%s, %s, %s, %s)" % (cx.loc(a.p2), cx.unit(a.unit), p1, cx.loc(a.loc))
    if t == 39:
        return "MoveUnit(%s, %s, %s, %s, %s)" % (a.n, cx.unit(a.unit), p1, cx.loc(a.loc), cx.loc(a.p2))
    if t == 41:
        return "SetNextScenario(%s)" % S(a.strid)
    if t == 42:
        return "SetDoodadState(%s, %s, %s, %s)" % (PROPSTATE.get(a.n, a.n), cx.unit(a.unit), cx.loc(a.loc), p1)
    if t == 43:
        return "SetInvincibility(%s, %s, %s, %s)" % (PROPSTATE.get(a.n, a.n), cx.unit(a.unit), cx.loc(a.loc), p1)
    if t == 44:
        return "CreateUnit(%d, %s, %s, %s)" % (a.n, cx.unit(a.unit), cx.loc(a.loc), p1)
    if t == 45:
        return "SetDeaths(%s, %s, %d, %s)" % (p1, MOD.get(a.n, a.n), a.time, cx.unit(a.unit))
    if t == 46:
        return "Order(%s, %s, %s, %s, %s)" % (cx.unit(a.unit), p1, cx.loc(a.loc), cx.loc(a.p2), ORDER.get(a.n, a.n))
    if t == 47:
        return "Comment(%s)" % S(a.strid)
    if t == 48:
        return "GiveUnitsToPlayer(%s, %s, %s, %s, %s)" % (a.n, cx.unit(a.unit), p1, cx.loc(a.loc), p2)
    if t in (49, 50, 51, 52, 53):
        return "%s(%s, %s, %s, %s, %d)" % (n, a.n, cx.unit(a.unit), p1, cx.loc(a.loc), a.time)
    if t == 57:
        return "SetAllianceStatus(%s, %s)" % (p1, ALLY.get(a.unit, a.unit))
    if t in (0, 1, 2, 5, 6, 54, 55, 56, 58, 59):
        return "%s()" % n
    return "%s(loc=%s str=%s wav=%s time=%d p1=%s p2=%s unit=%s n=%d fl=%d)" % (
        n, cx.loc(a.loc), S(a.strid), S(a.wav), a.time, p1, p2, cx.unit(a.unit), a.n, a.flags)


def decompile(chk_path, out_path):
    c = CHK(open(chk_path, "rb").read())
    cx = Ctx(c)
    tr = parse_triggers(c.get("TRIG"))
    out = io.StringIO()
    for i, t in enumerate(tr):
        pl = [PLAYERS.get(j, "P%d" % j) for j, v in enumerate(t.players) if v]
        out.write("Trigger(%d) players=%s\n" % (i, ",".join(pl)))
        out.write("Conditions:\n")
        for x in t.active_conds():
            out.write("    " + cond_text(x, cx) + ("  [mask=%04X]" % x.mask if x.mask else "") + "\n")
        out.write("Actions:\n")
        for a in t.active_acts():
            out.write("    " + act_text(a, cx) + "\n")
        out.write("\n")
    open(out_path, "w", encoding="utf-8").write(out.getvalue())
    return len(tr)


if __name__ == "__main__":
    print(decompile(sys.argv[1], sys.argv[2]), "triggers ->", sys.argv[2])
