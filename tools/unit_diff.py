"""Compare, per location, which unit types sit inside it in the source and in the
rebuilt map. Anything a trigger counts must not have gone missing."""
import sys, os, struct, collections, io
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from units import parse_units
from decompile import Ctx, load_unit_names
from trig import parse_triggers


def snapshot(path):
    c = CHK(open(path, "rb").read())
    cx = Ctx(c)
    m = c.get("MRGN")
    locs = {}
    for i in range(len(m) // 20):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        locs[i + 1] = (L, T, R, B, cx.locnames.get(i + 1, ""))
    us = parse_units(c.get("UNIT"))
    inside = collections.defaultdict(collections.Counter)
    for i, (L, T, R, B, nm) in locs.items():
        if (L, T, R, B) == (0, 0, 0, 0) or (R - L) > 3500 or (B - T) > 3500:
            continue
        for u in us:
            if L <= u["x"] < R and T <= u["y"] < B:
                inside[i][(u["uid"], u["player"])] += 1
    return locs, inside, c


def main(src_path, new_path, out_txt=None):
    names = load_unit_names()
    slocs, sin, sc = snapshot(src_path)
    nlocs, nin, nc = snapshot(new_path)

    # unit types that triggers actually count at a location
    counted = set()
    for t in parse_triggers(sc.get("TRIG")):
        for x in t.active_conds():
            if x.ctype in (3, 7, 17) and x.loc:      # Bring, CommandTheMostAt, CommandLeastAt
                counted.add(x.unit)
    out = io.StringIO()
    out.write("unit types counted at a location by triggers: %d\n\n" % len(counted))
    problems = []
    for i in sorted(slocs):
        if i not in nlocs:
            continue
        s, n = sin.get(i, collections.Counter()), nin.get(i, collections.Counter())
        lost = []
        for (uid, pl), cnt in s.items():
            got = n.get((uid, pl), 0)
            if got < cnt and (uid in counted or cnt - got > 3):
                lost.append("%s/P%d %d->%d%s" % (
                    names[uid] if uid < len(names) else "?", pl + 1, cnt, got,
                    " [COUNTED]" if uid in counted else ""))
        if lost:
            line = "loc%-4d %-16s  %s" % (i, slocs[i][4][:16], "; ".join(lost[:6]))
            out.write(line + "\n")
            if any("[COUNTED]" in x for x in lost):
                problems.append(line)
    out.write("\n=== locations that lost a trigger-counted unit: %d ===\n" % len(problems))
    for p in problems:
        out.write("  " + p + "\n")
    txt = out.getvalue()
    if out_txt:
        open(out_txt, "w", encoding="utf-8").write(txt)
    return txt, problems


if __name__ == "__main__":
    txt, problems = main(sys.argv[1], sys.argv[2],
                         sys.argv[3] if len(sys.argv) > 3 else None)
    lines = txt.splitlines()
    print("\n".join(lines[:3]))
    print("... %d lines total" % len(lines))
    print("\n".join(lines[-(len(problems) + 2):]))
