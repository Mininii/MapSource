"""Assemble the new 128x128 twilight marine-raising map.

Terrain comes from the arena generator, locations are re-placed by bearing and
scaled walking distance from the defence point, preplaced units follow their
location, and every other CHK section is carried over from the source so all
1663 classic triggers keep working.
"""
import sys, os, struct, json, math, collections, io, time
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from chk import CHK
from walk import WalkGrid
from arena import Arena, LOW, HIGH, WATER, MUD
from gen_arena import build as build_arena, distances
from place import (Placer, affine_room, affine_rect, containment, clusters,
                   CONTROL_ROOM, BOSS_ROOM, WHOLE_MAP, FREE, HP1)
from units import parse_units
from decompile import load_unit_names
from strings import substitute
from doodads import DoodadPlacer, dd2_bytes
from sprites import SpritePlacer, thg2_bytes
import pickle, random

W = H = 128
SRC_CHK = "work/src.chk"
ROLES = "work/roles.json"

# Sections carried over from the source untouched.
COPY = ["VER ", "TYPE", "IVE2", "VCOD", "IOWN", "OWNR", "SIDE", "COLR", "SPRP",
        "FORC", "PUNI", "UNIx", "PUPx", "UPGx", "PTEx", "TECx", "UPRP", "UPUS",
        "SWNM", "WAV ", "STR ", "MBRF", "TRIG"]

from mapmeta import text_subs, text_replace

TEXT_SUBS = text_subs()
TEXT_REPLACE = text_replace()


def log(*a):
    print(*a, flush=True)


def build(seed=7, out_chk="out/marine128.chk", era=7):
    src = CHK(open(SRC_CHK, "rb").read())
    roles = json.load(open(ROLES, encoding="utf-8"))
    sw, sh = struct.unpack("<HH", src.get("DIM"))

    # ---------------------------------------------------------------- terrain
    t0 = time.time()
    for attempt in range(6):
        ar, tb, tiles = build_arena(seed + attempt * 1000, log=log, era=era)
        if tiles is None:
            continue
        wg, clear, dist = distances(ar, tiles, era)
        leaks = rooms_leaking(ar, wg, dist)
        if not leaks:
            break
        log("terrain attempt %d: %s not isolated, regenerating" % (attempt + 1, ", ".join(leaks)))
    else:
        raise SystemExit("could not generate terrain with both rooms sealed")
    if tiles is None:
        raise SystemExit("terrain generation failed")
    new_max = max([d for d in dist if d >= 0] or [1])
    src_max = max(v["dist"] for v in roles.values() if v["dist"] is not None)
    log("terrain %.1fs  new max walk distance %d minitiles (source %d, ratio %.2f)"
        % (time.time() - t0, new_max, src_max, new_max / float(src_max)))

    # -------------------------------------------------------------- locations
    pl = Placer(roles, dist, wg, ar, src_max, W, H)
    pl.build_candidates(step=2)
    pl.fit_distances([v["dist"] for v in roles.values() if v["dist"] is not None])
    log("placement candidates: %d (distance range %d..%d minitiles)"
        % (len(pl.cands), pl.new_sorted[0], pl.new_sorted[-1]))

    newrect = {}
    # the defence point sits at the fortress centre
    fx_px, fy_px = pl.fort
    newrect[HP1] = (fx_px - 128, fy_px - 96, fx_px + 128, fy_px + 96)
    pl.placed.append((fx_px // 8, fy_px // 8))

    # isolated rooms: use the room's real walkable floor, not its nominal rectangle,
    # so every beacon inside it is actually reachable by the player's control unit
    ctrl_rect = walkable_bbox(wg, clear, ar.control_room, margin=1)
    boss_rect = walkable_bbox(wg, clear, ar.boss_island, margin=1)
    log("menu room floor  tiles (%d,%d)-(%d,%d)" % tuple(v // 32 for v in ctrl_rect))
    log("boss arena floor tiles (%d,%d)-(%d,%d)" % tuple(v // 32 for v in boss_rect))
    newrect.update(affine_room(roles, CONTROL_ROOM, None, ctrl_rect))
    newrect.update(affine_room(roles, BOSS_ROOM, None, boss_rect))
    for i in WHOLE_MAP:
        newrect[i] = (0, 0, W * 32, H * 32)

    # Locations whose rectangles overlap are placed as one block, so a preplaced
    # unit that sat inside several of them keeps sitting inside all of them.
    skip = set(newrect) | set(FREE)
    groups = clusters(roles, skip, overlap=0.3)
    groups.sort(key=lambda g: -max((roles[str(i)]["dist"] or 0) for i in g))
    nested = 0
    for g in groups:
        rep = max(g, key=lambda i: (roles[str(i)].get("spawn", 0),
                                    -(roles[str(i)]["R"] - roles[str(i)]["L"])))
        L0 = min(roles[str(i)]["L"] for i in g)
        T0 = min(roles[str(i)]["T"] for i in g)
        R0 = max(roles[str(i)]["R"] for i in g)
        B0 = max(roles[str(i)]["B"] for i in g)
        box = dict(L=L0, T=T0, R=R0, B=B0,
                   dist=min([roles[str(i)]["dist"] for i in g
                             if roles[str(i)]["dist"] is not None] or [None]))
        if box["dist"] is None:
            cx0, cy0 = fx_px, fy_px
            newbox = pl.rect_for(box, cx0, cy0)
            mapped = {i: affine_rect((L0, T0, R0, B0), newbox,
                                     (roles[str(i)]["L"], roles[str(i)]["T"],
                                      roles[str(i)]["R"], roles[str(i)]["B"]))
                      for i in g}
        else:
            # Score whole groups by their worst member: a spawn rectangle that
            # lands on a cliff is what actually breaks the game, not the group
            # centre being a few tiles off.
            # Score by the worst member's footing first - a spawn rectangle on a
            # cliff is what breaks the game - then, among candidates that stand up,
            # prefer the one covering floor no other location has claimed. That is
            # what pulls locations out into the empty corners of the map.
            best = None
            for (mx, my) in pl.ranked(box, topk=140):
                nb = pl.rect_for(box, mx * 8 + 4, my * 8 + 4)
                mp = {i: affine_rect((L0, T0, R0, B0), nb,
                                     (roles[str(i)]["L"], roles[str(i)]["T"],
                                      roles[str(i)]["R"], roles[str(i)]["B"]))
                      for i in g}
                worst = min(pl.rect_coverage(mp[i]) for i in g)
                fresh = sum(pl.fresh_fraction(mp[i]) for i in g) / float(len(g))
                score = (1 if worst >= 0.85 else 0, fresh if worst >= 0.85 else worst)
                if best is None or score > best[0]:
                    best = (score, mx, my, nb, mp)
                if worst >= 0.85 and fresh >= 0.95:
                    break
            _, mx, my, newbox, mapped = best
            pl.placed.append((mx, my))
        for i in g:
            newrect[i] = mapped[i]
            pl.mark_covered(mapped[i])
            nested += 1
    log("locations placed in %d overlap groups: %d" % (len(groups), nested))

    # anything the grouping skipped (oversized rectangles) still needs a home
    for i in sorted(int(k) for k in roles):
        if i in newrect or i in FREE:
            continue
        L = roles[str(i)]
        c = pl.place_arena(L) if L["dist"] is not None else None
        newrect[i] = (pl.rect_for(L, c[0] * 8 + 4, c[1] * 8 + 4) if c
                      else (fx_px - 32, fy_px - 32, fx_px + 32, fy_px + 32))

    # 086 is the intro CenterView target and the source map's start locations sit
    # on it, so give it a real spot: just above the fortress, looking at the base.
    intro = (fx_px - 96, fy_px - 224, fx_px + 96, fy_px - 96)
    for i in FREE:
        L = roles.get(str(i))
        if not L:
            continue
        newrect[i] = intro if i == 218 else (fx_px - 48, fy_px - 48, fx_px + 48, fy_px + 48)
    log("placed %d locations" % len(newrect))

    # ------------------------------------------------------------------ MRGN
    src_mrgn = src.get("MRGN")
    nloc = len(src_mrgn) // 20
    mrgn = bytearray()
    for i in range(1, nloc + 1):
        L, T, R, B, sid, fl = struct.unpack_from("<IIIIHH", src_mrgn, (i - 1) * 20)
        if i in newrect:
            nl, nt, nr, nb = newrect[i]
            mrgn += struct.pack("<IIIIHH", int(nl), int(nt), int(nr), int(nb), sid, fl)
        else:
            mrgn += struct.pack("<IIIIHH", 0, 0, 0, 0, sid, fl)
    log("MRGN entries: %d" % nloc)

    # ------------------------------------------------------------------ UNIT
    units = parse_units(src.get("UNIT"))
    src_locs = {int(k): v for k, v in roles.items()}
    # smallest containing location wins
    boxes = sorted(((v["R"] - v["L"]) * (v["B"] - v["T"]), i, v)
                   for i, v in src_locs.items()
                   if 0 < (v["R"] - v["L"]) <= 4000 and 0 < (v["B"] - v["T"]) <= 4000)
    src_hp = pl.src_hp
    kept = []
    by_loc = 0
    for u in units:
        owner = None
        for area, i, v in boxes:
            if v["L"] <= u["x"] < v["R"] and v["T"] <= u["y"] < v["B"] and i in newrect:
                owner = (i, v)
                break
        if owner:
            i, v = owner
            nl, nt, nr, nb = newrect[i]
            fxs = (nr - nl) / float(max(1, v["R"] - v["L"]))
            fys = (nb - nt) / float(max(1, v["B"] - v["T"]))
            nx = nl + (u["x"] - v["L"]) * fxs
            ny = nt + (u["y"] - v["T"]) * fys
            by_loc += 1
        else:
            nx = (u["x"] - src_hp[0]) * 0.5 + fx_px
            ny = (u["y"] - src_hp[1]) * 0.5 + fy_px
        u["x"] = int(max(16, min(W * 32 - 16, nx)))
        u["y"] = int(max(16, min(H * 32 - 16, ny)))
        kept.append(u)
    log("units: %d (%d followed their location)" % (len(kept), by_loc))
    moved = repair_counted_units(kept, roles, newrect, src)
    moved += repair_counted_units(kept, roles, newrect, src, rng_seed=1234)
    log("units nudged to restore trigger-counted placement: %d" % moved)
    snapped = snap_mobile_units(kept, wg, dist, src)
    log("mobile units snapped off cliffs onto open ground: %d" % snapped)
    kept = thin_revealers(kept, min_tiles=11)
    # start locations decide where each player's camera opens; put them on the
    # intro spot, spread one tile apart, as the source map does
    ix0, iy0 = (intro[0] + intro[2]) // 2, (intro[1] + intro[3]) // 2
    k = 0
    for u in kept:
        if u["uid"] == 214:
            u["x"] = max(16, min(W * 32 - 16, ix0 + (k - 4) * 32))
            u["y"] = iy0
            k += 1
    log("start locations placed at tile (%d,%d)" % (ix0 // 32, iy0 // 32))
    log("units after thinning map revealers: %d" % len(kept))
    unit_bytes = pack_units(kept)

    # --------------------------------------------------------------- doodads
    dd2 = b""
    grid = ar.grid()

    def region_of_tile(tx, ty):
        ix, iy = tx // 2, ty
        if 0 <= iy < len(grid) and 0 <= ix < len(grid[0]):
            return grid[iy][ix]
        return -1

    avoid = set()
    for i, (nl, nt, nr, nb) in newrect.items():
        if (nr - nl) > 3000 or (nb - nt) > 3000:
            continue
        for ty in range(max(0, nt // 32 - 1), min(H, nb // 32 + 2)):
            for tx in range(max(0, nl // 32 - 1), min(W, nr // 32 + 2)):
                avoid.add((tx, ty))
    for u in kept:
        avoid.add((u["x"] // 32, u["y"] // 32))
    # the isolated rooms are tight, and a blocking doodad there would cut the
    # control unit off from a beacon, so keep them clear entirely
    for (rx0, ry0, rx1, ry1) in (ar.control_room, ar.boss_island):
        for ty in range(max(0, ry0 - 2), min(H, ry1 + 3)):
            for tx in range(max(0, rx0 * 2 - 4), min(W, (rx1 + 1) * 2 + 4)):
                avoid.add((tx, ty))

    lib_path = "work/doodads_%d.pkl" % era
    if os.path.exists(lib_path):
        lib = pickle.load(open(lib_path, "rb"))
        dp = DoodadPlacer(lib, era=era)
        rng = random.Random(seed * 31 + 7)
        placed = dp.place(tiles, W, H, region_of_tile, avoid, rng, count=320, tries_per=400)
        dd2 = dd2_bytes(placed)
        log("doodads: %d placed (%d tiles reserved)" % (len(placed), len(avoid)))
        for (num, px, py) in placed:
            avoid.add((px // 32, py // 32))

    # --------------------------------------------------------------- sprites
    thg2 = b""
    sp_path = "work/sprites_%d.pkl" % era
    if os.path.exists(sp_path):
        sp = SpritePlacer(pickle.load(open(sp_path, "rb")))
        srng = random.Random(seed * 17 + 3)
        sprites = sp.place(W, H, region_of_tile, avoid, srng, count=220)
        thg2 = thg2_bytes(sprites)
        log("sprites: %d placed" % len(sprites))

    # ------------------------------------------------------------------- CHK
    # Same section order as the source map, so StarCraft sees a familiar layout.
    out = CHK()
    mtxm = struct.pack("<%dH" % len(tiles), *tiles)
    newstr = substitute(src.get("STR "), TEXT_SUBS, TEXT_REPLACE)
    fresh = {
        "ERA ": struct.pack("<H", era),
        "DIM ": struct.pack("<HH", W, H),
        "MTXM": mtxm,
        "TILE": mtxm,
        "ISOM": tb.isom_bytes(),
        "MASK": bytes([0xFF]) * (W * H),      # fog of war set for every player, as in the source
        "UNIT": unit_bytes,
        "THG2": thg2,
        "DD2 ": dd2,
        "MRGN": bytes(mrgn),
        "STR ": newstr,
    }
    for name, payload in src.sections:
        nm = name.decode("latin1")
        out.sections.append([name, fresh.get(nm, payload)])
    data = out.build()
    os.makedirs(os.path.dirname(out_chk), exist_ok=True)
    open(out_chk, "wb").write(data)
    log("wrote %s (%d bytes, %d sections)" % (out_chk, len(data), len(out.sections)))
    return dict(ar=ar, tb=tb, tiles=tiles, wg=wg, dist=dist, newrect=newrect,
                roles=roles, chk=out_chk, new_max=new_max, src_max=src_max)


def rooms_leaking(ar, wg, dist):
    """Which isolated rooms can be walked into from the arena. The boss arena and
    the menu room are reached by MoveUnit teleports only, exactly as in the
    source map, so a breach in their wall changes the game."""
    bad = []
    for name, rect in (("menu room", ar.control_room), ("boss arena", ar.boss_island)):
        x0, y0, x1, y1 = rect
        mx = ((x0 + x1) // 2) * 2 * 4 + 4
        my = ((y0 + y1) // 2) * 4 + 2
        if 0 <= mx < wg.MW and 0 <= my < wg.MH and dist[my * wg.MW + mx] >= 0:
            bad.append(name)
    return bad


def walkable_bbox(wg, clear, cell_rect, margin=1):
    """Largest fully walkable axis-aligned rectangle inside an isolated room,
    in pixels. Using the bounding box instead would include the room's ragged
    corners and drop beacons onto the cliff."""
    x0, y0, x1, y1 = cell_rect
    cx = ((x0 + x1) // 2) * 2 * 4 + 4
    cy = ((y0 + y1) // 2) * 4 + 2
    seeds = [(cx + dx, cy + dy) for dx in range(-4, 5) for dy in range(-4, 5)]
    d = wg.bfs(seeds, clear)
    MW = wg.MW
    xs = [i % MW for i, v in enumerate(d) if v >= 0]
    ys = [i // MW for i, v in enumerate(d) if v >= 0]
    if not xs:
        return (x0 * 2 * 32, y0 * 32, (x1 + 1) * 2 * 32, (y1 + 1) * 32)
    tx0, tx1 = min(xs) // 4, max(xs) // 4
    ty0, ty1 = min(ys) // 4, max(ys) // 4
    W = tx1 - tx0 + 1
    H = ty1 - ty0 + 1
    # A tile counts as usable floor when every one of its minitiles is walkable
    # and at least one of them is reachable from the room's centre. Requiring all
    # sixteen to be *reachable* is too strict: the clearance mask blanks the edge
    # minitiles of every tile that touches a wall.
    walk = wg.walk
    ok = []
    for ty in range(ty0, ty1 + 1):
        row = []
        for tx in range(tx0, tx1 + 1):
            allwalk = True
            anyreach = False
            for my in range(4):
                base = (ty * 4 + my) * MW + tx * 4
                for mx in range(4):
                    if not walk[base + mx]:
                        allwalk = False
                        break
                    if d[base + mx] >= 0:
                        anyreach = True
                if not allwalk:
                    break
            row.append(allwalk and anyreach)
        ok.append(row)
    best = (0, 0, 0, 0, 0)          # area, x, y, w, h
    heights = [0] * W
    for r in range(H):
        for cidx in range(W):
            heights[cidx] = heights[cidx] + 1 if ok[r][cidx] else 0
        stack = []
        for cidx in range(W + 1):
            cur = heights[cidx] if cidx < W else 0
            start = cidx
            while stack and stack[-1][1] >= cur:
                si, sh = stack.pop()
                area = sh * (cidx - si)
                if area > best[0]:
                    best = (area, si, r - sh + 1, cidx - si, sh)
                start = si
            stack.append((start, cur))
    if best[0] == 0:
        return ((tx0 + 2) * 32, (ty0 + 2) * 32, (tx1 - 1) * 32, (ty1 - 1) * 32)
    _, bx, by, bw, bh = best
    l = (tx0 + bx + margin) * 32
    t = (ty0 + by + margin) * 32
    r = (tx0 + bx + bw - margin) * 32
    b = (ty0 + by + bh - margin) * 32
    return (l, t, max(l + 96, r), max(t + 96, b))


def repair_counted_units(units, roles, newrect, src, rng_seed=99):
    """Triggers count specific unit types inside specific locations (Bring,
    CommandTheMostAt, CommandLeastAt). Reproduce the source map's per-location
    counts exactly by nudging units of those types back into place."""
    from trig import parse_triggers
    counted = set()
    for t in parse_triggers(src.get("TRIG")):
        for x in t.active_conds():
            if x.ctype in (3, 7, 17) and x.loc:
                counted.add(x.unit)
    src_units = parse_units(src.get("UNIT"))
    boxes = [(int(k), v) for k, v in roles.items()
             if int(k) in newrect and 0 < (v["R"] - v["L"]) <= 3500
             and 0 < (v["B"] - v["T"]) <= 3500]
    want = collections.defaultdict(collections.Counter)
    for i, v in boxes:
        for su in src_units:
            if (su["uid"] in counted and v["L"] <= su["x"] < v["R"]
                    and v["T"] <= su["y"] < v["B"]):
                want[i][(su["uid"], su["player"])] += 1
    rng = random.Random(rng_seed)
    moved = 0
    used = set()
    for i in sorted(want, key=lambda i: -sum(want[i].values())):
        nl, nt, nr, nb = newrect[i]
        cx, cy = (nl + nr) / 2.0, (nt + nb) / 2.0
        for (uid, pl), need in want[i].most_common():
            inside = [k for k, u in enumerate(units)
                      if u["uid"] == uid and u["player"] == pl
                      and nl <= u["x"] < nr and nt <= u["y"] < nb]
            for k in inside[:need]:
                used.add(k)               # lock it so a later location cannot steal it
            if len(inside) >= need:
                continue
            cands = sorted((abs(u["x"] - cx) + abs(u["y"] - cy), k)
                           for k, u in enumerate(units)
                           if u["uid"] == uid and u["player"] == pl and k not in used
                           and not (nl <= u["x"] < nr and nt <= u["y"] < nb))
            short = need - len(inside)
            for _, k in cands[:short]:
                u = units[k]
                u["x"] = int(rng.uniform(nl + 16, max(nl + 17, nr - 16)))
                u["y"] = int(rng.uniform(nt + 16, max(nt + 17, nb - 16)))
                used.add(k)
                moved += 1
                short -= 1
            # Overlapping source locations can share one unit; once they are
            # separated only one of them can hold it, so clone the marker. These
            # are decorative buildings that triggers only count per location.
            for _ in range(min(short, 4)):
                proto = next((u for u in units if u["uid"] == uid and u["player"] == pl), None)
                if proto is None:
                    break
                clone = dict(proto)
                clone["x"] = int(rng.uniform(nl + 16, max(nl + 17, nr - 16)))
                clone["y"] = int(rng.uniform(nt + 16, max(nt + 17, nb - 16)))
                units.append(clone)
                used.add(len(units) - 1)
                moved += 1
    return moved


MOBILE_MAX_ID = 105          # 0..105 are mobile units; 106+ are buildings/specials


def snap_mobile_units(units, wg, dist, src, radius_tiles=16):
    """A ground unit dropped into a cliff face or onto an unreachable plateau can
    never move. Buildings are fine there, and anything a trigger counts has
    already been placed deliberately, so only shift the rest."""
    from trig import parse_triggers
    counted = set()
    for t in parse_triggers(src.get("TRIG")):
        for x in t.active_conds():
            if x.ctype in (3, 7, 17) and x.loc:
                counted.add(x.unit)
    MW, MH = wg.MW, wg.MH
    n = 0
    for u in units:
        if u["uid"] > MOBILE_MAX_ID or u["uid"] in counted:
            continue
        mx, my = u["x"] // 8, u["y"] // 8
        if not (0 <= mx < MW and 0 <= my < MH):
            continue
        i = my * MW + mx
        if wg.walk[i] and dist[i] >= 0:
            continue
        best = None
        for r in range(2, radius_tiles * 4, 2):
            for dy in range(-r, r + 1, 2):
                yy = my + dy
                if yy < 0 or yy >= MH:
                    continue
                rem = r - abs(dy)
                row = yy * MW
                for dx in (-rem, rem):
                    xx = mx + dx
                    if 0 <= xx < MW and wg.walk[row + xx] and dist[row + xx] >= 0:
                        best = (xx, yy)
                        break
                if best:
                    break
            if best:
                break
        if best:
            u["x"] = best[0] * 8 + 4
            u["y"] = best[1] * 8 + 4
            n += 1
    return n


MAP_REVEALER = 101


def thin_revealers(units, min_tiles=11):
    """The map is a quarter of the source's area, so the source's map revealers
    end up four times denser than they need to be. Keep a spaced-out subset per
    player; every other unit type is left alone because triggers count them."""
    out = []
    keep_by_player = collections.defaultdict(list)
    for u in units:
        if u["uid"] != MAP_REVEALER:
            out.append(u)
            continue
        px, py = u["x"] // 32, u["y"] // 32
        near = any(abs(px - qx) + abs(py - qy) < min_tiles
                   for (qx, qy) in keep_by_player[u["player"]])
        if not near:
            keep_by_player[u["player"]].append((px, py))
            out.append(u)
    return out


def pack_units(units):
    b = bytearray()
    for u in units:
        b += struct.pack("<IHHHHHHBBBBIHHII", u["cls"], u["x"], u["y"], u["uid"], u["rel"],
                         u["sflags"], u["vflags"], u["player"], u["hp"], u["sh"], u["en"],
                         u["res"], u["hangar"], u["uflags"], 0, u["rel2"])
    return bytes(b)


if __name__ == "__main__":
    seed = int(sys.argv[1]) if len(sys.argv) > 1 else 7
    build(seed)
