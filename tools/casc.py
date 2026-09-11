"""Minimal CascLib ctypes wrapper to pull tileset graphics out of a StarCraft
install. This build of CascLib takes ANSI (char*) paths."""
import ctypes, os, sys
from ctypes import c_void_p, c_char_p, c_uint32, c_uint64, c_int, byref, POINTER

DLL_CANDIDATES = [
    r"C:\Users\USER\Downloads\Release\CascLib.dll",
    r"C:\Users\USER\Downloads\Release (2)\CascLib.dll",
]
SC_PATH = r"C:\Program Files (x86)\StarCraft"


class Casc:
    def __init__(self, path=SC_PATH):
        last = None
        self.C = None
        for d in DLL_CANDIDATES:
            if not os.path.exists(d):
                continue
            try:
                self.C = ctypes.WinDLL(d)
                self.dllpath = d
                break
            except Exception as e:
                last = e
        if self.C is None:
            raise OSError("no CascLib could be loaded: %s" % last)
        C = self.C
        C.CascOpenStorage.argtypes = [c_char_p, c_uint32, POINTER(c_void_p)]
        C.CascOpenStorage.restype = c_int
        C.CascCloseStorage.argtypes = [c_void_p]
        C.CascOpenFile.argtypes = [c_void_p, c_char_p, c_uint32, c_uint32, POINTER(c_void_p)]
        C.CascOpenFile.restype = c_int
        C.CascGetFileSize.argtypes = [c_void_p, POINTER(c_uint32)]
        C.CascGetFileSize.restype = c_uint32
        C.CascReadFile.argtypes = [c_void_p, c_void_p, c_uint32, POINTER(c_uint32)]
        C.CascReadFile.restype = c_int
        C.CascCloseFile.argtypes = [c_void_p]
        self.h = c_void_p()
        if not C.CascOpenStorage(path.encode("mbcs"), 0, byref(self.h)) or not self.h.value:
            raise OSError("CascOpenStorage failed for %s" % path)

    def read(self, name):
        f = c_void_p()
        if not self.C.CascOpenFile(self.h, name.encode("mbcs"), 0, 0, byref(f)) or not f.value:
            raise KeyError(name)
        hi = c_uint32(0)
        sz = self.C.CascGetFileSize(f, byref(hi))
        if sz in (0, 0xFFFFFFFF):
            self.C.CascCloseFile(f)
            raise KeyError("%s (size %s)" % (name, sz))
        buf = ctypes.create_string_buffer(sz)
        rd = c_uint32(0)
        ok = self.C.CascReadFile(f, buf, sz, byref(rd))
        self.C.CascCloseFile(f)
        if not ok and rd.value != sz:
            raise OSError("CascReadFile failed for %s" % name)
        return buf.raw[:rd.value]

    def close(self):
        if self.h:
            self.C.CascCloseStorage(self.h)
            self.h = None

    def __enter__(self):
        return self

    def __exit__(self, *a):
        self.close()


TILESET_FILES = ["cv5", "vf4", "vx4", "vx4ex", "vr4", "wpe"]


def dump_tileset(name, outdir, path=SC_PATH):
    os.makedirs(outdir, exist_ok=True)
    got = []
    with Casc(path) as c:
        for ext in TILESET_FILES:
            for cand in ("tileset/%s.%s" % (name, ext), "tileset\\%s.%s" % (name, ext)):
                try:
                    d = c.read(cand)
                except Exception:
                    continue
                p = os.path.join(outdir, "%s.%s" % (name, ext))
                open(p, "wb").write(d)
                got.append((cand, len(d)))
                break
    return got


if __name__ == "__main__":
    name = sys.argv[1] if len(sys.argv) > 1 else "twilight"
    outdir = sys.argv[2] if len(sys.argv) > 2 else "work/tileset"
    for cand, n in dump_tileset(name, outdir):
        print("  %-30s %d bytes" % (cand, n))
