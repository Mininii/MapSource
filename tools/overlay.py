"""Render terrain + location boxes + unit dots."""
import sys, struct, os
sys.path.insert(0, os.path.dirname(__file__))
from chk import CHK
from tileset import Tileset, WALKABLE, HIGH_GROUND, MID_GROUND, RAMP
import png

def build(chk_path, out_path, px=2, show_locs=True, show_units=True):
    c = CHK(open(chk_path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    ts = Tileset(era)
    tiles = struct.unpack("<%dH" % (w*h), c.get("MTXM")[:w*h*2])
    W, H = w*px, h*px
    buf = bytearray(W*H*3)
    def putpx(x, y, rgb):
        if 0 <= x < W and 0 <= y < H:
            i = (y*W+x)*3; buf[i]=rgb[0]; buf[i+1]=rgb[1]; buf[i+2]=rgb[2]
    for ty in range(h):
        for tx in range(w):
            t = tiles[ty*w+tx]; fl = ts.minitile_flags(t)
            for sy in range(px):
                my = sy*4//px
                for sx in range(px):
                    mx = sx*4//px
                    f = fl[my*4+mx]
                    if f & RAMP: col=(200,150,60)
                    elif not (f & WALKABLE):
                        col=(20,38,70) if not (f & (HIGH_GROUND|MID_GROUND)) else (58,52,38)
                    elif f & HIGH_GROUND: col=(150,180,120)
                    elif f & MID_GROUND: col=(100,140,80)
                    else: col=(60,95,55)
                    putpx(tx*px+sx, ty*px+sy, col)
    if show_units:
        u = c.get("UNIT")
        for i in range(len(u)//36):
            (cls, x, y, uid, rel, sf, vf, pl) = struct.unpack_from("<IHHHHHHB", u, i*36)
            col = {0:(255,80,80),1:(80,120,255),2:(80,255,220),3:(200,80,255),
                   4:(255,140,40),5:(120,90,40),6:(60,255,60),7:(255,255,120),
                   11:(160,160,160)}.get(pl,(255,255,255))
            X, Y = x*px//32, y*px//32
            for dy in range(-1,2):
                for dx in range(-1,2):
                    putpx(X+dx, Y+dy, col)
    if show_locs:
        m = c.get("MRGN")
        for i in range(len(m)//20):
            L,T,R,B,sid,flags = struct.unpack_from("<IIIIHH", m, i*20)
            if (L,T,R,B)==(0,0,0,0): continue
            if (R-L) > 6000 or (B-T) > 6000: continue
            x0,y0,x1,y1 = L*px//32, T*px//32, R*px//32, B*px//32
            col = (255,255,255)
            for x in range(x0, x1+1):
                putpx(x,y0,col); putpx(x,y1,col)
            for y in range(y0, y1+1):
                putpx(x0,y,col); putpx(x1,y,col)
    rows = [bytes(buf[y*W*3:(y+1)*W*3]) for y in range(H)]
    png.write_rgb(out_path, W, H, rows)
    return W,H

if __name__ == "__main__":
    print(build(sys.argv[1], sys.argv[2], int(sys.argv[3]) if len(sys.argv)>3 else 2))
