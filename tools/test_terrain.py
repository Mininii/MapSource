"""Smoke test: generate a 128x128 twilight map with a high-ground plateau."""
import sys, os, struct, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from terrain import TerrainBuilder
from render import render
import png

W = H = 128
t0 = time.time()
tb = TerrainBuilder(W, H, "work/isom_twilight.pkl", era=7, seed=7)

CX, CY = tb.iw // 2, tb.ih // 2


def region(ix, iy):
    # isometric diamond plateau in ISOM-cell space
    if abs(ix - CX) + abs(iy - CY) < 18:
        return 2            # high dirt
    if ix < 4 or iy < 4 or ix > tb.iw - 5 or iy > tb.ih - 5:
        return 3            # water border
    return 1                # dirt


tb.set_region(region)
ok = tb.build(pin_radius=2)
print("solved:", ok, "%.1fs" % (time.time() - t0))
if ok:
    tiles, missing = tb.tiles()
    print("missing table entries:", len(missing))
    mtxm = struct.pack("<%dH" % len(tiles), *tiles)
    open("work/test_terrain.mtxm", "wb").write(mtxm)
    render(None, "work/test_terrain.png", 4, mtxm=mtxm, dims=(W, H), era=7)
    print("rendered work/test_terrain.png")
