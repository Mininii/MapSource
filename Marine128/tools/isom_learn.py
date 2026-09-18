"""Learn the ISOM cell -> MTXM tile-group mapping from real maps."""
import sys, struct, os, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK


def load(path):
    c = CHK(open(path, "rb").read())
    w, h = struct.unpack("<HH", c.get("DIM"))
    era = struct.unpack("<H", c.get("ERA"))[0]
    tiles = struct.unpack("<%dH" % (w * h), c.get("MTXM")[:w * h * 2])
    isom = c.get("ISOM")
    iw, ih = w // 2 + 1, h + 1
    cells = [struct.unpack_from("<4H", isom, i * 8) for i in range(iw * ih)]
    return w, h, era, tiles, cells, iw, ih


def probe(path):
    w, h, era, tiles, cells, iw, ih = load(path)
    print("== %s  %dx%d era=%d" % (os.path.basename(path), w, h, era))
    best = None
    for dx in (-2, -1, 0, 1, 2):
        for dy in (-1, 0, 1):
            table = collections.defaultdict(collections.Counter)
            n = 0
            for iy in range(ih):
                for ix in range(iw):
                    cl = cells[iy * iw + ix]
                    if cl == (0, 0, 0, 0):
                        continue
                    tx = ix * 2 + dx
                    ty = iy + dy
                    if not (0 <= tx and tx + 1 < w and 0 <= ty < h):
                        continue
                    g0 = tiles[ty * w + tx] >> 4
                    g1 = tiles[ty * w + tx + 1] >> 4
                    table[cl][(g0, g1)] += 1
                    n += 1
            if not n:
                continue
            # determinism score: fraction of samples in the majority mapping
            good = sum(cnt.most_common(1)[0][1] for cnt in table.values())
            score = good / n
            print("  dx=%2d dy=%2d  keys=%5d samples=%6d determinism=%.4f" % (
                dx, dy, len(table), n, score))
            if best is None or score > best[0]:
                best = (score, dx, dy, table)
    return best


if __name__ == "__main__":
    probe(sys.argv[1])
