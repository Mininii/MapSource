"""Report preplaced units that ended up on terrain they do not belong on:
stranded on an unreachable plateau, or standing in a cliff face."""
import sys, os, struct, collections, io
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from walk import from_chk
from units import parse_units
from decompile import load_unit_names

# ids that are decoration or map machinery and do not care where they sit
IGNORE = {101, 214}          # Map Revealer, Start Location


def main(chk_path, out_txt=None):
    c = CHK(open(chk_path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    names = load_unit_names()
    wg = from_chk(c)
    clear = wg.clearance(2)
    m = c.get("MRGN")
    L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, 0)
    cx, cy = ((L + R) // 2) // 8, ((T + B) // 2) // 8
    dist = wg.bfs([(cx + dx, cy + dy) for dx in range(-8, 9) for dy in range(-8, 9)], clear)
    MW = wg.MW
    units = parse_units(c.get("UNIT"))
    stats = collections.Counter()
    bad = collections.Counter()
    for u in units:
        if u["uid"] in IGNORE:
            stats["ignored"] += 1
            continue
        mx, my = u["x"] // 8, u["y"] // 8
        if not (0 <= mx < MW and 0 <= my < wg.MH):
            stats["offmap"] += 1
            continue
        i = my * MW + mx
        if not wg.walk[i]:
            stats["on_cliff"] += 1
            bad[(names[u["uid"]] if u["uid"] < len(names) else "?", u["player"] + 1)] += 1
        elif dist[i] < 0:
            stats["stranded"] += 1
        else:
            stats["ok"] += 1
    out = io.StringIO()
    tot = sum(stats.values())
    out.write("units checked: %d\n" % tot)
    for k in ("ok", "stranded", "on_cliff", "offmap", "ignored"):
        out.write("  %-10s %5d  (%.1f%%)\n" % (k, stats[k], 100.0 * stats[k] / max(1, tot)))
    out.write("\nunits standing in a cliff face:\n")
    for (nm, pl), n in bad.most_common(25):
        out.write("  %-30s P%-3d %d\n" % (nm[:30], pl, n))
    txt = out.getvalue()
    if out_txt:
        open(out_txt, "w", encoding="utf-8").write(txt)
    return txt, stats


if __name__ == "__main__":
    txt, stats = main(sys.argv[1], sys.argv[2] if len(sys.argv) > 2 else None)
    print(txt)
