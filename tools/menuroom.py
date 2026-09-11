"""Explicit layout for the menu room.

Mapping the source map's control locations by an affine transform squeezes them:
in the source they sit in a small cluster at the top of a room that is mostly
staging area, so rescaling the whole bounding box shrinks the pads to one or two
tiles each while half the new room stays empty. These pads are a user interface -
a probe has to walk onto each one - so they get laid out deliberately instead.

Roles (from the source map's triggers):
    player1    where each player's control probe appears
    m1..m4     difficulty slots, one per player
    m5         walk here to send the probe back to player1
    moneyhigh  walk here to cycle the donation amount (25000 / 100000 / 5000)
    fast       park a unit here to auto-teleport newly bought marines
    01, 02     CenterView targets
    017, 112   Bring checks
    04         civilian defeat check band
    T1, T2     staging area units are teleported in and out of
    Location 101  the whole room
"""

PLAYER1, M1, M2, M3, M4, M5 = 124, 119, 120, 122, 121, 123
MONEYHIGH, FAST, VIEW1, VIEW2 = 14, 125, 127, 132
CHK017, CHK112, BAND04 = 149, 244, 136
T1, T2, WHOLE = 5, 6, 102

# (location, x, y, w, h) in tiles, measured from the room floor's top-left.
# Laid out for a floor of at least 19 x 27 tiles.
LAYOUT = [
    # difficulty slots, one row across the top
    (M1, 0, 1, 4, 3),
    (M2, 5, 1, 4, 3),
    (M3, 9, 1, 4, 3),
    (M4, 13, 1, 4, 3),
    # the probe's home and its return pad
    (PLAYER1, 6, 5, 5, 4),
    (M5, 12, 5, 5, 4),
    # the two toggles, given real room - these are what felt cramped
    (MONEYHIGH, 0, 10, 8, 5),
    (FAST, 9, 10, 8, 5),
    # camera targets and bring checks
    (CHK017, 0, 16, 3, 2),
    (CHK112, 4, 16, 3, 2),
    (VIEW2, 8, 16, 3, 2),
    (VIEW1, 12, 16, 3, 2),
]

BAND_Y = 18
STAGE_Y = 20
MIN_W, MIN_H = 17, 24


def fits(rect):
    L, T, R, B = rect
    return (R - L) // 32 >= MIN_W and (B - T) // 32 >= MIN_H


def build(rect):
    """rect: the room's walkable floor in pixels. Returns {loc: (L,T,R,B)}."""
    L, T, R, B = rect
    w = (R - L) // 32
    h = (B - T) // 32
    sx = max(1.0, w / float(MIN_W))          # stretch if the room is wider
    out = {}
    for (loc, x, y, pw, ph) in LAYOUT:
        x0 = L + int(x * sx) * 32
        y0 = T + y * 32
        x1 = x0 + max(1, int(round(pw * sx))) * 32
        y1 = y0 + ph * 32
        out[loc] = (x0, y0, min(x1, R), min(y1, B))
    # the check band and the staging area take whatever height is left, so a
    # taller room gives the parked units more air rather than stretching the pads
    band_y = T + BAND_Y * 32
    out[BAND04] = (L, band_y, R, band_y + 2 * 32)
    stage_y = T + STAGE_Y * 32
    out[T1] = (L, stage_y, R, B)
    out[T2] = out[T1]
    out[WHOLE] = (L, T, R, B)
    return out
