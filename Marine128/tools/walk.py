"""Minitile walkability grid + BFS, for verifying that spawn points can reach
the defence point."""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from tileset import Tileset


class WalkGrid:
    """4x4 minitiles per tile; walkable[my*MW+mx] is 0/1."""

    def __init__(self, tiles, w, h, era):
        self.w, self.h = w, h
        self.MW, self.MH = w * 4, h * 4
        ts = Tileset(era)
        self.ts = ts
        cache = {}
        g = bytearray(self.MW * self.MH)
        for ty in range(h):
            base = ty * w
            for tx in range(w):
                t = tiles[base + tx]
                fl = cache.get(t)
                if fl is None:
                    mt = ts.megatile(t)
                    if mt is None or mt >= ts.nmega:
                        fl = (0,) * 16
                    else:
                        fl = struct.unpack_from("<16H", ts.vf4, mt * 32)
                    cache[t] = fl
                for my in range(4):
                    row = (ty * 4 + my) * self.MW + tx * 4
                    for mx in range(4):
                        g[row + mx] = 1 if (fl[my * 4 + mx] & 1) else 0
        self.walk = g

    def clearance(self, size=2):
        """Mark minitiles where a size x size minitile block is fully walkable
        (approximates a ground unit's footprint)."""
        MW, MH, g = self.MW, self.MH, self.walk
        out = bytearray(MW * MH)
        for my in range(MH - size + 1):
            for mx in range(MW - size + 1):
                ok = True
                for dy in range(size):
                    row = (my + dy) * MW + mx
                    for dx in range(size):
                        if not g[row + dx]:
                            ok = False
                            break
                    if not ok:
                        break
                if ok:
                    out[my * MW + mx] = 1
        return out

    def bfs(self, starts, grid=None):
        """Returns a distance array (in minitiles), -1 where unreachable."""
        MW, MH = self.MW, self.MH
        g = grid if grid is not None else self.walk
        dist = [-1] * (MW * MH)
        q = collections.deque()
        for (mx, my) in starts:
            if 0 <= mx < MW and 0 <= my < MH and g[my * MW + mx]:
                i = my * MW + mx
                if dist[i] == -1:
                    dist[i] = 0
                    q.append(i)
        while q:
            i = q.popleft()
            d = dist[i] + 1
            y, x = divmod(i, MW)
            if x > 0 and g[i - 1] and dist[i - 1] == -1:
                dist[i - 1] = d; q.append(i - 1)
            if x < MW - 1 and g[i + 1] and dist[i + 1] == -1:
                dist[i + 1] = d; q.append(i + 1)
            if y > 0 and g[i - MW] and dist[i - MW] == -1:
                dist[i - MW] = d; q.append(i - MW)
            if y < MH - 1 and g[i + MW] and dist[i + MW] == -1:
                dist[i + MW] = d; q.append(i + MW)
        return dist

    def region_minitiles(self, L, T, R, B):
        """Minitile coords covered by a pixel rectangle."""
        return (L // 8, T // 8, max(L // 8, R // 8 - 1), max(T // 8, B // 8 - 1))


def from_chk(chk):
    w, h = struct.unpack("<HH", chk.get("DIM"))
    era = struct.unpack("<H", chk.get("ERA"))[0]
    tiles = struct.unpack("<%dH" % (w * h), chk.get("MTXM")[:w * h * 2])
    return WalkGrid(tiles, w, h, era)
