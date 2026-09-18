"""Work out where a DD2 entry's tile block sits, by testing candidate offsets."""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from doodad_probe import read_chk
from tileset import Tileset


def main(path, era=7):
    c = read_chk(path)
    w, h = struct.unpack("<HH", c.get("DIM"))
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    dd2 = c.get("DD2 ") or b""
    ts = Tileset(era)
    # doodad id -> (first cv5 group, width, height)
    by_id = {}
    for g in range(1024, len(ts.groups)):
        grp = ts.groups[g]
        if grp.u2 == 0 or grp.u3 == 0:
            continue
        by_id.setdefault(grp.u1, []).append(g)
    print("doodad ids in tileset: %d" % len(by_id))

    best = collections.Counter()
    for i in range(len(dd2) // 8):
        num, x, y, owner, state = struct.unpack_from("<HHHBB", dd2, i * 8)
        groups = by_id.get(num)
        if not groups:
            continue
        gw = ts.groups[groups[0]].u2
        gh = ts.groups[groups[0]].u3
        tx, ty = x // 32, y // 32
        for ox in range(-gw, 1):
            for oy in range(-gh, 1):
                ok = True
                for dy in range(gh):
                    for dx in range(gw):
                        px, py = tx + ox + dx, ty + oy + dy
                        if not (0 <= px < w and 0 <= py < h):
                            ok = False
                            break
                        if (tiles[py * w + px] >> 4) not in groups:
                            ok = False
                            break
                    if not ok:
                        break
                if ok:
                    best[(ox, oy, gw, gh)] += 1
    print("matching offsets (ox, oy, w, h):")
    for k, v in best.most_common(12):
        print("   ", k, v)


if __name__ == "__main__":
    main(sys.argv[1], int(sys.argv[2]) if len(sys.argv) > 2 else 7)
