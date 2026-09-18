"""Where does the generated terrain block movement that the layout wanted open?"""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from arena import Arena, PASSABLE, LOW, HIGH, WATER, MUD
from tileset import Tileset
import png


def main(chk_path, out, seed=17):
    c = CHK(open(chk_path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    ts = Tileset(era)
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    ar = Arena(seed=1700 + seed * 37)
    grid = ar.grid()
    cache = {}

    def walkfrac(t):
        v = cache.get(t)
        if v is None:
            mt = ts.megatile(t)
            if mt is None or mt >= ts.nmega:
                v = 0.0
            else:
                fl = struct.unpack_from("<16H", ts.vf4, mt * 32)
                v = sum(1 for f in fl if f & 1) / 16.0
            cache[t] = v
        return v

    SC = 4
    rows = []
    stats = collections.Counter()
    for ty in range(h):
        row = bytearray()
        for tx in range(w):
            ix, iy = tx // 2, ty
            want = grid[iy][ix] if (0 <= iy < len(grid) and 0 <= ix < len(grid[0])) else -1
            wf = walkfrac(tiles[ty * w + tx])
            open_wanted = want in PASSABLE
            if open_wanted and wf < 0.5:
                col = (230, 40, 40)          # wanted floor, got a wall
                stats["blocked"] += 1
            elif open_wanted:
                col = (60, 110, 60)
                stats["open"] += 1
            elif wf >= 0.5:
                col = (200, 180, 60)         # wanted wall, got floor
                stats["leak"] += 1
            else:
                col = (50, 50, 60)
                stats["wall"] += 1
            row += bytes(col) * SC
        for _ in range(SC):
            rows.append(bytes(row))
    png.write_rgb(out, w * SC, h * SC, rows)
    tot = sum(stats.values())
    print("tiles %d  open %.1f%%  blocked-but-wanted-open %.1f%%  wall %.1f%%  leak %.1f%%"
          % (tot, 100.0 * stats["open"] / tot, 100.0 * stats["blocked"] / tot,
             100.0 * stats["wall"] / tot, 100.0 * stats["leak"] / tot))
    print("wrote", out)


if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2], int(sys.argv[3]) if len(sys.argv) > 3 else 17)
