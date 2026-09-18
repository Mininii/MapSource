"""Deterministic value noise (no dependencies)."""
import math


def _hash(ix, iy, seed):
    h = (ix * 374761393 + iy * 668265263 + seed * 2246822519) & 0xFFFFFFFF
    h = (h ^ (h >> 13)) * 1274126177 & 0xFFFFFFFF
    h ^= h >> 16
    return (h & 0xFFFF) / 32767.5 - 1.0        # -1 .. 1


def _smooth(t):
    return t * t * (3 - 2 * t)


def value(x, y, scale, seed=0):
    fx, fy = x / scale, y / scale
    x0, y0 = math.floor(fx), math.floor(fy)
    tx, ty = _smooth(fx - x0), _smooth(fy - y0)
    a = _hash(x0, y0, seed)
    b = _hash(x0 + 1, y0, seed)
    c = _hash(x0, y0 + 1, seed)
    d = _hash(x0 + 1, y0 + 1, seed)
    return (a * (1 - tx) + b * tx) * (1 - ty) + (c * (1 - tx) + d * tx) * ty


def fbm(x, y, scale, seed=0, octaves=3):
    v = 0.0
    amp = 1.0
    tot = 0.0
    for o in range(octaves):
        v += amp * value(x, y, scale / (2 ** o), seed + o * 977)
        tot += amp
        amp *= 0.5
    return v / tot
