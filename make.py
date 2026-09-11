"""One-shot pipeline: terrain -> locations -> units -> CHK -> SCX -> verify -> render."""
import sys, os, time
sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), "tools"))
import build_map
from pack import pack
from verify import verify
from overlay import build as overlay
from render import render
from room_check import main as room_check
from unit_diff import main as unit_diff
from unit_terrain import main as unit_terrain

OUT_CHK = "out/marine128.chk"
OUT_SCX = "out/marine128.scx"

SRC_SCX = "work/src.scx"


def main(seed=19, tag="", era=7):
    t0 = time.time()
    out_chk = OUT_CHK if not tag else "out/marine128_%s.chk" % tag
    out_scx = OUT_SCX if not tag else "out/marine128_%s.scx" % tag
    res = build_map.build(seed, out_chk, era=era)
    pack(out_chk, out_scx, SRC_SCX)
    txt, problems = verify(out_chk, out_txt="work/verify%s.txt" % (("_" + tag) if tag else ""))
    print("\n".join(txt.splitlines()[:4]))
    print("problems: %d" % len(problems))
    for p in problems:
        print("   " + p)
    ok_rooms = room_check(out_chk)
    _, lost = unit_diff("work/src.chk", out_chk,
                        "work/unit_diff%s.txt" % (("_" + tag) if tag else ""))
    print("locations that lost a trigger-counted unit: %d" % len(lost))
    _, ustats = unit_terrain(out_chk, "work/unit_terrain%s.txt" % (("_" + tag) if tag else ""))
    tot = max(1, sum(ustats.values()))
    print("units on open ground %.0f%%, stranded %.0f%%, in a cliff face %.0f%%"
          % (100.0 * ustats["ok"] / tot, 100.0 * ustats["stranded"] / tot,
             100.0 * ustats["on_cliff"] / tot))
    for l in lost:
        print("   " + l)
    overlay(out_chk, "work/new_overlay%s.png" % (("_" + tag) if tag else ""), 4)
    print("rooms: %s   units: %s" % ("PASS" if ok_rooms else "FAIL",
                                     "PASS" if not lost else "FAIL"))
    print("done in %.1fs" % (time.time() - t0))
    return res


if __name__ == "__main__":
    main(int(sys.argv[1]) if len(sys.argv) > 1 else 19,
         sys.argv[2] if len(sys.argv) > 2 else "",
         int(sys.argv[3]) if len(sys.argv) > 3 else 7)
