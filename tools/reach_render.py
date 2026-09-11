"""Render reachability from hp1 over the source map."""
import sys, os, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from walk import from_chk
import png

c = CHK(open(sys.argv[1], "rb").read())
w, h = struct.unpack("<HH", c.get("DIM"))
m = c.get("MRGN")
L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", m, 0)
wg = from_chk(c)
clear = wg.clearance(2)
cx, cy = ((L + R) // 2) // 8, ((T + B) // 2) // 8
starts = [(cx + dx, cy + dy) for dx in range(-8, 9) for dy in range(-8, 9)]
dist = wg.bfs(starts, clear)
MW, MH = wg.MW, wg.MH
maxd = max(d for d in dist if d >= 0)
print("max reachable distance:", maxd, "minitiles")
print("reachable minitiles:", sum(1 for d in dist if d >= 0), "of", MW * MH)

# downscale 2x (minitile -> 2 minitiles per px) so 256-tile map -> 512 px
SC = 2
OW, OH = MW // SC, MH // SC
rows = []
for y in range(OH):
    row = bytearray()
    for x in range(OW):
        best = -1
        walk = 0
        for dy in range(SC):
            for dx in range(SC):
                i = (y * SC + dy) * MW + x * SC + dx
                walk |= wg.walk[i]
                if dist[i] >= 0 and (best < 0 or dist[i] < best):
                    best = dist[i]
        if best >= 0:
            f = min(1.0, best / maxd)
            row += bytes((int(30 + 220 * f), int(230 - 180 * f), 60))
        elif walk:
            row += bytes((110, 110, 130))          # walkable but unreachable
        else:
            row += bytes((18, 26, 45))
    rows.append(bytes(row))
png.write_rgb(sys.argv[2], OW, OH, rows)
print("wrote", sys.argv[2], OW, OH)
