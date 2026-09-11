"""Reverse-engineer the ISOM <-> MTXM relationship from a real map."""
import sys, struct, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from tileset import Tileset

c = CHK(open(sys.argv[1], "rb").read())
w, h = struct.unpack("<HH", c.get("DIM"))
era = struct.unpack("<H", c.get("ERA"))[0]
ts = Tileset(era)
mtxm = c.get("MTXM")
tiles = struct.unpack("<%dH" % (w * h), mtxm[:w * h * 2])
isom = c.get("ISOM")
iw, ih = w // 2 + 1, h + 1
print("map %dx%d era=%d  isom grid %dx%d (%d bytes, expected %d)" % (
    w, h, era, iw, ih, len(isom), iw * ih * 8))

cells = [struct.unpack_from("<4H", isom, i * 8) for i in range(iw * ih)]


def cell(ix, iy):
    return cells[iy * iw + ix]


print("\n-- first isom cells --")
for iy in range(0, 6):
    print(" ".join("%5d,%5d,%5d,%5d" % cell(ix, iy) for ix in range(0, 5)))

print("\n-- sample from populated area (tile 120,240) --")
for iy in range(238, 244):
    print(iy, " ".join("(%d,%d,%d,%d)" % cell(ix, iy) for ix in range(58, 63)))

print("\n-- corresponding cv5 group edges of the tiles there --")
for ty in range(238, 244):
    row = []
    for tx in range(116, 126):
        t = tiles[ty * w + tx]
        g = ts.groups[t >> 4]
        row.append("g%d[%d,%d,%d,%d]" % (t >> 4, g.left, g.top, g.right, g.bottom))
    print(ty, " ".join(row))

# statistical check: do isom values divide by 2 to index cv5 edges?
print("\n-- isom value histogram --")
hist = collections.Counter()
for cl in cells:
    for v in cl:
        hist[v] += 1
print(sorted(hist.items())[:40])
print("distinct isom values:", len(hist))

print("\n-- cv5 edge value histogram (groups 0..1023) --")
eh = collections.Counter()
for g in ts.groups[:1024]:
    for v in (g.left, g.top, g.right, g.bottom):
        eh[v] += 1
print(sorted(eh.items())[:40])
print("distinct edge values:", len(eh))
