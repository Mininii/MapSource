"""Learn the DD2 doodad format: which tiles a doodad stamps into MTXM."""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from isom_table import load_map
from chk import CHK
from mpq import MPQ
from tileset import Tileset


def read_chk(path):
    try:
        with MPQ(path) as m:
            return CHK(m.read("staredit\\scenario.chk"))
    except Exception:
        return CHK(open(path, "rb").read())


def main(path, era=7):
    c = read_chk(path)
    w, h = struct.unpack("<HH", c.get("DIM"))
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    dd2 = c.get("DD2 ") or b""
    ts = Tileset(era)
    print("map %dx%d  DD2 entries %d" % (w, h, len(dd2) // 8))
    print("\n-- cv5 doodad group fields (>=1024) --")
    shown = 0
    for g in range(1024, min(len(ts.groups), 1120)):
        grp = ts.groups[g]
        if grp.u1 == 0 and grp.u2 == 0:
            continue
        print("  g%-5d idx=%-4d build=%-4d h=%-3d L=%-5d T=%-5d R=%-5d B=%-5d "
              "u1=%-5d u2=%-3d u3=%-3d u4=%-4d" % (
                  g, grp.index, grp.buildability, grp.ground_height, grp.left, grp.top,
                  grp.right, grp.bottom, grp.u1, grp.u2, grp.u3, grp.u4))
        shown += 1
        if shown > 12:
            break
    print("\n-- DD2 entries and the tiles under them --")
    for i in range(min(12, len(dd2) // 8)):
        num, x, y, owner, state = struct.unpack_from("<HHHBB", dd2, i * 8)
        t = tiles[y * w + x] if (0 <= x < w and 0 <= y < h) else -1
        print("  dd2 num=%-6d tile=(%3d,%3d) owner=%-2d state=%-2d  mtxm=%d (group %d sub %d)"
              % (num, x, y, owner, state, t, t >> 4, t & 15))
    # which groups appear in MTXM that are doodad groups
    dg = collections.Counter(t >> 4 for t in tiles if (t >> 4) >= 1024)
    print("\ndoodad groups stamped in MTXM: %d distinct, %d tiles" % (len(dg), sum(dg.values())))
    for g, n in dg.most_common(12):
        grp = ts.groups[g]
        print("   g%-5d n=%-5d u1=%-5d w=%-3d h=%-3d" % (g, n, grp.u1, grp.u2, grp.u3))


if __name__ == "__main__":
    main(sys.argv[1], int(sys.argv[2]) if len(sys.argv) > 2 else 7)
