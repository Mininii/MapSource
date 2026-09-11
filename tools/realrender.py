"""Pixel-accurate map rendering from the real tileset graphics.

Needs the tileset's wpe (palette), vx4/vx4ex (megatile -> minitile refs) and vr4
(8x8 minitile pixels), which tools/casc.py pulls out of the StarCraft install.

    python tools/casc.py twilight work/tileset
    python tools/realrender.py out/marine128.chk work/real.png 4
"""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from tileset import Tileset, TILESET_NAMES
import png

DEFAULT_DIR = "work/tileset"


class Graphics:
    def __init__(self, name, dirpath=DEFAULT_DIR):
        base = os.path.join(dirpath, name)
        wpe = open(base + ".wpe", "rb").read()
        self.pal = [(wpe[i * 4], wpe[i * 4 + 1], wpe[i * 4 + 2]) for i in range(256)]
        if os.path.exists(base + ".vx4ex"):
            raw = open(base + ".vx4ex", "rb").read()
            n = len(raw) // 64
            self.vx4 = struct.unpack("<%dI" % (n * 16), raw[:n * 64])
            self.ex = True
        else:
            raw = open(base + ".vx4", "rb").read()
            n = len(raw) // 32
            self.vx4 = struct.unpack("<%dH" % (n * 16), raw[:n * 32])
            self.ex = False
        self.nmega_gfx = n
        self.vr4 = open(base + ".vr4", "rb").read()
        self.nmini = len(self.vr4) // 64

    def minitile_pixels(self, ref):
        """8x8 palette indices for one minitile reference (flip flag in bit 0)."""
        flip = ref & 1
        idx = ref >> 1
        if idx >= self.nmini:
            return None, False
        return self.vr4[idx * 64:(idx + 1) * 64], bool(flip)

    def tile_rgb(self, mega):
        """32x32 RGB bytes for one megatile index."""
        out = bytearray(32 * 32 * 3)
        if mega >= self.nmega_gfx:
            return bytes(out)
        base = mega * 16
        for sy in range(4):
            for sx in range(4):
                ref = self.vx4[base + sy * 4 + sx]
                px, flip = self.minitile_pixels(ref)
                if px is None:
                    continue
                for y in range(8):
                    row = ((sy * 8 + y) * 32 + sx * 8) * 3
                    for x in range(8):
                        c = self.pal[px[y * 8 + (7 - x if flip else x)]]
                        o = row + x * 3
                        out[o] = c[0]; out[o + 1] = c[1]; out[o + 2] = c[2]
        return bytes(out)

    def tile_avg(self, mega, scale):
        """scale x scale RGB bytes for one megatile, box-averaged."""
        full = self.tile_rgb(mega)
        if scale == 32:
            return full
        step = 32 // scale
        out = bytearray(scale * scale * 3)
        for y in range(scale):
            for x in range(scale):
                r = g = b = 0
                for dy in range(step):
                    row = ((y * step + dy) * 32 + x * step) * 3
                    for dx in range(step):
                        r += full[row + dx * 3]
                        g += full[row + dx * 3 + 1]
                        b += full[row + dx * 3 + 2]
                n = step * step
                o = (y * scale + x) * 3
                out[o] = r // n; out[o + 1] = g // n; out[o + 2] = b // n
        return bytes(out)


def render(chk_path, out_path, scale=4, dirpath=DEFAULT_DIR, rect=None):
    c = CHK(open(chk_path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    ts = Tileset(era)
    gfx = Graphics(TILESET_NAMES[era], dirpath)
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    x0, y0, x1, y1 = rect or (0, 0, w, h)
    W, H = (x1 - x0) * scale, (y1 - y0) * scale
    cache = {}
    rows = [bytearray(W * 3) for _ in range(H)]
    for ty in range(y0, y1):
        for tx in range(x0, x1):
            t = tiles[ty * w + tx]
            img = cache.get(t)
            if img is None:
                mega = ts.megatile(t)
                img = gfx.tile_avg(mega if mega is not None else 0, scale)
                cache[t] = img
            ox = (tx - x0) * scale * 3
            for sy in range(scale):
                rows[(ty - y0) * scale + sy][ox:ox + scale * 3] = img[sy * scale * 3:(sy + 1) * scale * 3]
    png.write_rgb(out_path, W, H, [bytes(r) for r in rows])
    print("wrote %s (%dx%d, %d distinct tiles)" % (out_path, W, H, len(cache)))


if __name__ == "__main__":
    rect = None
    if len(sys.argv) > 7:
        rect = tuple(int(v) for v in sys.argv[4:8])
    render(sys.argv[1], sys.argv[2],
           int(sys.argv[3]) if len(sys.argv) > 3 else 4, rect=rect)
