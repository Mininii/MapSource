"""Side-by-side sheet of the source map and the generated variants."""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from tileset import Tileset
import png

TILE_PX = {256: 1, 128: 2}


def tile_image(chk_path):
    c = CHK(open(chk_path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    ts = Tileset(era)
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    px = TILE_PX.get(w, max(1, 256 // w))
    W, H = w * px, h * px
    buf = bytearray(W * H * 3)
    for ty in range(h):
        for tx in range(w):
            t = tiles[ty * w + tx]
            g = t >> 4
            fl = ts.minitile_flags(t)
            walk = sum(1 for f in fl if f & 1) >= 8
            gh = ts.height(t)
            idx = ts.groups[g].index if g < len(ts.groups) else 0
            if g >= 1024:
                col = (150, 110, 60) if walk else (108, 68, 38)
            elif idx == 5:
                col = (26, 44, 86)
            elif not walk:
                col = {0: (74, 60, 44), 2: (92, 76, 54), 4: (112, 94, 68)}.get(gh, (74, 60, 44))
            else:
                col = {0: (58, 92, 58), 2: (116, 150, 94), 4: (182, 200, 150)}.get(gh, (58, 92, 58))
            for sy in range(px):
                row = ((ty * px + sy) * W + tx * px) * 3
                for sx in range(px):
                    buf[row + sx * 3:row + sx * 3 + 3] = bytes(col)
    return W, H, buf


def montage(items, out, cols=2, gap=8, bg=(24, 24, 28)):
    imgs = [tile_image(p) for p, _ in items]
    cw = max(i[0] for i in imgs)
    ch = max(i[1] for i in imgs)
    rows = (len(imgs) + cols - 1) // cols
    W = cols * cw + (cols + 1) * gap
    H = rows * ch + (rows + 1) * gap + rows * 10
    out_buf = bytearray(bytes(bg) * (W * H))
    for k, (w, h, buf) in enumerate(imgs):
        r, cidx = divmod(k, cols)
        ox = gap + cidx * (cw + gap)
        oy = gap + r * (ch + gap + 10)
        for y in range(h):
            src = y * w * 3
            dst = ((oy + y) * W + ox) * 3
            out_buf[dst:dst + w * 3] = buf[src:src + w * 3]
    rowsout = [bytes(out_buf[y * W * 3:(y + 1) * W * 3]) for y in range(H)]
    png.write_rgb(out, W, H, rowsout)
    print("wrote %s (%dx%d): %s" % (out, W, H, ", ".join(n for _, n in items)))


if __name__ == "__main__":
    items = []
    for a in sys.argv[2:]:
        p, _, n = a.partition("=")
        items.append((p, n or os.path.basename(p)))
    montage(items, sys.argv[1])
