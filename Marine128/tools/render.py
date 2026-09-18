"""Render a CHK's MTXM into a walkability/height PNG (no external deps)."""
import sys, struct, os
sys.path.insert(0, os.path.dirname(__file__))
from chk import CHK
from tileset import Tileset, WALKABLE, HIGH_GROUND, MID_GROUND, RAMP, BLOCKS_VIEW
import png

def classify_minitiles(ts, tile):
    return ts.minitile_flags(tile)

def render(chk_path, out_path, scale=4, mtxm=None, dims=None, era=None):
    if mtxm is None:
        c = CHK(open(chk_path, "rb").read())
        w, h = struct.unpack("<HH", c.get("DIM"))
        era = struct.unpack("<H", c.get("ERA"))[0]
        mtxm = c.get("MTXM")
    else:
        w, h = dims
    ts = Tileset(era)
    tiles = struct.unpack("<%dH" % (w*h), mtxm[:w*h*2])
    # colors
    def color(fl, tile):
        walk = fl & WALKABLE
        hi   = fl & HIGH_GROUND
        mid  = fl & MID_GROUND
        ramp = fl & RAMP
        if ramp:  return (200,150,60)
        if not walk:
            if tile>>4 in NULLG: return (0,0,0)
            if hi:  return (70,60,40)
            if mid: return (55,50,35)
            return (25,45,80)          # water / unwalkable low
        if hi:  return (150,180,120)
        if mid: return (100,140,80)
        return (60,95,55)
    NULLG = {0,1}
    rows = []
    px_per_tile = scale       # 4 -> minitile resolution
    for ty in range(h):
        line_rows = [bytearray() for _ in range(px_per_tile)]
        for tx in range(w):
            t = tiles[ty*w+tx]
            fl = ts.minitile_flags(t)
            for sy in range(px_per_tile):
                my = sy * 4 // px_per_tile
                for sx in range(px_per_tile):
                    mx = sx * 4 // px_per_tile
                    r,g,b = color(fl[my*4+mx], t)
                    line_rows[sy] += bytes((r,g,b))
        rows.extend(line_rows)
    png.write_rgb(out_path, w*px_per_tile, h*px_per_tile, rows)
    return w, h

if __name__ == "__main__":
    w,h = render(sys.argv[1], sys.argv[2], int(sys.argv[3]) if len(sys.argv)>3 else 4)
    print("rendered", sys.argv[2], w, h)
