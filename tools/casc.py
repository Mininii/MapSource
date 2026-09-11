"""Minimal CascLib ctypes wrapper to pull tileset graphics out of a StarCraft install."""
import ctypes, os, sys
from ctypes import c_void_p, c_char_p, c_wchar_p, c_uint32, c_int, byref, POINTER

DLL_CANDIDATES = [
    r"C:\Users\USER\Downloads\Release\CascLib.dll",
    r"C:\Users\USER\Downloads\Release (2)\CascLib.dll",
]
SC_PATH = r"C:\Program Files (x86)\StarCraft"


def load():
    last = None
    for d in DLL_CANDIDATES:
        if not os.path.exists(d):
            continue
        try:
            return ctypes.WinDLL(d), d
        except Exception as e:
            last = e
    raise OSError("no CascLib could be loaded: %s" % last)


class Casc:
    def __init__(self, path=SC_PATH):
        self.C, self.dllpath = load()
        C = self.C
        self.h = c_void_p()
        for argt, name in (((c_wchar_p, POINTER(c_void_p)), "CascOpenStorage"),):
            pass
        C.CascOpenStorage.argtypes = [c_wchar_p, c_uint32, POINTER(c_void_p)]
        C.CascOpenStorage.restype = c_int
        C.CascCloseStorage.argtypes = [c_void_p]
        C.CascOpenFile.argtypes = [c_void_p, c_char_p, c_uint32, c_uint32, POINTER(c_void_p)]
        C.CascOpenFile.restype = c_int
        C.CascGetFileSize.argtypes = [c_void_p, POINTER(c_uint32)]
        C.CascGetFileSize.restype = c_uint32
        C.CascReadFile.argtypes = [c_void_p, c_void_p, c_uint32, POINTER(c_uint32)]
        C.CascReadFile.restype = c_int
        C.CascCloseFile.argtypes = [c_void_p]
        C.GetLastError = ctypes.windll.kernel32.GetLastError
        if not C.CascOpenStorage(path, 0, byref(self.h)):
            raise OSError("CascOpenStorage failed err=%d for %s" % (ctypes.GetLastError(), path))

    def read(self, name):
        f = c_void_p()
        if not self.C.CascOpenFile(self.h, name.encode("mbcs"), 0, 0, byref(f)):
            raise KeyError("%s (err %d)" % (name, ctypes.GetLastError()))
        hi = c_uint32(0)
        sz = self.C.CascGetFileSize(f, byref(hi))
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


if __name__ == "__main__":
    with Casc() as c:
        print("opened storage via", c.dllpath)
        for n in ["tileset/twilight.vr4", "tileset/twilight.vx4ex", "tileset/twilight.vx4",
                  "tileset/twilight.wpe", "tileset/twilight.cv5", "tileset/twilight.vf4",
                  "tileset\\twilight.vr4"]:
            try:
                d = c.read(n)
                print("  %-28s %d bytes" % (n, len(d)))
            except Exception as e:
                print("  %-28s MISS (%s)" % (n, e))
