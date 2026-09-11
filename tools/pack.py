"""Package a scenario.chk plus the source map's sound files into a .scx (MPQ)."""
import sys, os, struct, tempfile
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from mpq import MPQ, MPQ_CREATE_ARCHIVE_V1, MPQ_CREATE_LISTFILE, MPQ_CREATE_ATTRIBUTES


def pack(chk_path, out_scx, src_scx=None, extra=None, quiet=False):
    files = [(chk_path, "staredit\\scenario.chk")]
    tmpdir = tempfile.mkdtemp(prefix="scxpack")
    copied = []
    if src_scx:
        with MPQ(src_scx) as m:
            try:
                names = m.read("(listfile)").decode("mbcs", "replace").split()
            except Exception:
                names = []
            for n in names:
                n = n.strip()
                if not n or n.lower() == "staredit\\scenario.chk":
                    continue
                if not m.has(n):
                    continue
                data = m.read(n)
                lp = os.path.join(tmpdir, os.path.basename(n))
                with open(lp, "wb") as f:
                    f.write(data)
                copied.append((lp, n, len(data)))
    for lp, n, sz in copied:
        files.append((lp, n))
    if extra:
        files.extend(extra)
    if os.path.exists(out_scx):
        os.remove(out_scx)
    arc = MPQ.create(out_scx, maxfiles=max(64, 2 * len(files)),
                     flags=MPQ_CREATE_ARCHIVE_V1 | MPQ_CREATE_LISTFILE | MPQ_CREATE_ATTRIBUTES)
    for lp, n in files:
        arc.add(lp, n, compress=True)
    arc.flush()
    arc.close()
    if not quiet:
        print("packed %s: %d files (%d sounds carried over), %d bytes" % (
            out_scx, len(files), len(copied), os.path.getsize(out_scx)))
    return out_scx


if __name__ == "__main__":
    pack(sys.argv[1], sys.argv[2], sys.argv[3] if len(sys.argv) > 3 else None)
