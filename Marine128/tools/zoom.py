"""Zoomed render of a tile rectangle with location boxes and unit markers."""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from tileset import Tileset
import png


def render(chk_path, out, x0, y0, x1, y1, px=8):
    c = CHK(open(chk_path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    ts = Tileset(era)
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    W = (x1 - x0) * px
    H = (y1 - y0) * px
    buf = bytearray(W * H * 3)

    def put(x, y, rgb):
        if 0 <= x < W and 0 <= y < H:
            i = (y * W + x) * 3
            buf[i], buf[i + 1], buf[i + 2] = rgb
    for ty in range(y0, y1):
        for tx in range(x0, x1):
            t = tiles[ty * w + tx]
            fl = ts.minitile_flags(t)
            dood = (t >> 4) >= 1024
            for sy in range(px):
                my = sy * 4 // px
                for sx in range(px):
                    mx = sx * 4 // px
                    f = fl[my * 4 + mx]
                    walk = f & 1
                    gh = ts.height(t)          # cv5 ground height: 0 low, 2 high, 4 peak
                    idx = ts.groups[t >> 4].index if (t >> 4) < len(ts.groups) else 0
                    if dood:
                        col = (150, 110, 60) if walk else (108, 68, 38)
                    elif idx == 5:
                        col = (26, 44, 86)                        # water
                    elif not walk:
                        col = {0: (74, 60, 44), 2: (92, 76, 54), 4: (112, 94, 68)}.get(gh, (74, 60, 44))
                    elif gh == 0:
                        # low ground, tinted by which floor type it is
                        col = {2: (58, 92, 58), 4: (96, 104, 96), 8: (92, 84, 56),
                               15: (86, 78, 62), 11: (70, 88, 72), 13: (74, 96, 66),
                               23: (62, 96, 62), 22: (64, 90, 62)}.get(idx, (58, 92, 58))
                    else:
                        col = {2: (116, 150, 94), 4: (182, 200, 150)}.get(gh, (116, 150, 94))
                    put((tx - x0) * px + sx, (ty - y0) * px + sy, col)
    m = c.get("MRGN")
    for i in range(len(m) // 20):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, i * 20)
        if (L, T, R, B) == (0, 0, 0, 0) or (R - L) > 3000:
            continue
        ax, ay = (L // 32 - x0) * px, (T // 32 - y0) * px
        bx, by = (R // 32 - x0) * px, (B // 32 - y0) * px
        for x in range(ax, bx + 1):
            put(x, ay, (255, 255, 255)); put(x, by, (255, 255, 255))
        for y in range(ay, by + 1):
            put(ax, y, (255, 255, 255)); put(bx, y, (255, 255, 255))
    u = c.get("UNIT")
    for i in range(len(u) // 36):
        (cls, ux, uy, uid, rel, sf, vf, pl) = struct.unpack_from("<IHHHHHHB", u, i * 36)
        X = (ux / 32.0 - x0) * px
        Y = (uy / 32.0 - y0) * px
        col = {0: (255, 90, 90), 1: (90, 130, 255), 2: (90, 255, 230), 3: (210, 90, 255),
               4: (255, 150, 50), 5: (150, 100, 40), 6: (70, 255, 70), 7: (255, 255, 130),
               11: (180, 180, 180)}.get(pl, (255, 255, 255))
        for dy in range(-2, 3):
            for dx in range(-2, 3):
                put(int(X) + dx, int(Y) + dy, col)
    rows = [bytes(buf[y * W * 3:(y + 1) * W * 3]) for y in range(H)]
    png.write_rgb(out, W, H, rows)
    print("wrote", out, W, H)


if __name__ == "__main__":
    render(sys.argv[1], sys.argv[2], *[int(v) for v in sys.argv[3:7]],
           px=int(sys.argv[7]) if len(sys.argv) > 7 else 8)
