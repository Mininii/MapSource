"""Scan a directory tree of .scm/.scx maps and report tileset + ISOM cleanliness."""
import sys, os, struct, collections
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from mpq import MPQ
from chk import CHK

ERA = {0: "badlands", 1: "platform", 2: "install", 3: "ash", 4: "jungle",
       5: "desert", 6: "ice", 7: "twilight"}


def chk_of(path):
    try:
        with MPQ(path) as m:
            return m.read("staredit\\scenario.chk")
    except Exception:
        try:
            return open(path, "rb").read()
        except Exception:
            return None


def info(path):
    d = chk_of(path)
    if not d:
        return None
    try:
        c = CHK(d)
        dim = c.get("DIM")
        era = c.get("ERA")
        isom = c.get("ISOM")
        mtxm = c.get("MTXM")
        if not dim or not era or not mtxm:
            return None
        w, h = struct.unpack("<HH", dim)
        e = struct.unpack("<H", era)[0]
        return dict(path=path, w=w, h=h, era=e, isom=len(isom) if isom else 0,
                    isom_ok=(isom is not None and len(isom) == (w // 2 + 1) * (h + 1) * 8),
                    trig=len(c.get("TRIG") or b"") // 2400)
    except Exception:
        return None


def main(roots, want_era=None):
    rows = []
    for root in roots:
        for dp, dn, fn in os.walk(root):
            for f in fn:
                if f.lower().endswith((".scm", ".scx")):
                    p = os.path.join(dp, f)
                    try:
                        if os.path.getsize(p) > 30 * 1024 * 1024:
                            continue
                    except OSError:
                        continue
                    r = info(p)
                    if r and (want_era is None or r["era"] == want_era):
                        rows.append(r)
    rows.sort(key=lambda r: (-r["isom_ok"], r["trig"]))
    for r in rows:
        print("%-9s %3dx%-3d isom=%-5s trig=%-5d %s" % (
            ERA.get(r["era"], r["era"]), r["w"], r["h"], r["isom_ok"], r["trig"], r["path"]))
    print(len(rows), "maps")


if __name__ == "__main__":
    era = int(sys.argv[1]) if len(sys.argv) > 1 and sys.argv[1] != "-" else None
    main(sys.argv[2:], era)
