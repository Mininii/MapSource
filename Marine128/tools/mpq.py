"""StormLib64.dll (UNICODE build) ctypes wrapper: read/create StarCraft .scx MPQ archives."""
import ctypes, os, sys
from ctypes import (c_void_p, c_char_p, c_wchar_p, c_uint32, c_int, byref,
                    POINTER, Structure, c_char)

DLL = os.environ.get("STORMLIB_DLL", r"C:\euddraft0.9.2.0\StormLib64.dll")
S = ctypes.WinDLL(DLL)
HANDLE = c_void_p

S.SFileOpenArchive.argtypes  = [c_wchar_p, c_uint32, c_uint32, POINTER(HANDLE)]
S.SFileOpenArchive.restype   = c_int
S.SFileCreateArchive.argtypes= [c_wchar_p, c_uint32, c_uint32, POINTER(HANDLE)]
S.SFileCreateArchive.restype = c_int
S.SFileCloseArchive.argtypes = [HANDLE]
S.SFileOpenFileEx.argtypes   = [HANDLE, c_char_p, c_uint32, POINTER(HANDLE)]
S.SFileOpenFileEx.restype    = c_int
S.SFileGetFileSize.argtypes  = [HANDLE, POINTER(c_uint32)]
S.SFileGetFileSize.restype   = c_uint32
S.SFileReadFile.argtypes     = [HANDLE, c_void_p, c_uint32, POINTER(c_uint32), c_void_p]
S.SFileReadFile.restype      = c_int
S.SFileCloseFile.argtypes    = [HANDLE]
S.SFileHasFile.argtypes      = [HANDLE, c_char_p]
S.SFileHasFile.restype       = c_int
S.SFileAddFileEx.argtypes    = [HANDLE, c_wchar_p, c_char_p, c_uint32, c_uint32, c_uint32]
S.SFileAddFileEx.restype     = c_int
S.SFileRemoveFile.argtypes   = [HANDLE, c_char_p, c_uint32]
S.SFileRemoveFile.restype    = c_int
S.SFileCompactArchive.argtypes = [HANDLE, c_wchar_p, c_int]
S.SFileCompactArchive.restype  = c_int
S.SFileSetMaxFileCount.argtypes = [HANDLE, c_uint32]
S.SFileSetMaxFileCount.restype  = c_int
S.SFileFlushArchive.argtypes = [HANDLE]
S.SFileFlushArchive.restype  = c_int

class SFILE_FIND_DATA(Structure):
    _fields_ = [("cFileName", c_char*260), ("szPlainName", c_void_p),
                ("dwHashIndex", c_uint32), ("dwBlockIndex", c_uint32),
                ("dwFileSize", c_uint32), ("dwFileFlags", c_uint32),
                ("dwCompSize", c_uint32), ("dwFileTimeLo", c_uint32),
                ("dwFileTimeHi", c_uint32), ("lcLocale", c_uint32)]
S.SFileFindFirstFile.argtypes = [HANDLE, c_char_p, POINTER(SFILE_FIND_DATA), c_wchar_p]
S.SFileFindFirstFile.restype  = HANDLE
S.SFileFindNextFile.argtypes  = [HANDLE, POINTER(SFILE_FIND_DATA)]
S.SFileFindNextFile.restype   = c_int
S.SFileFindClose.argtypes     = [HANDLE]

MPQ_OPEN_READ_ONLY        = 0x00000100
MPQ_FILE_IMPLODE          = 0x00000100
MPQ_FILE_COMPRESS         = 0x00000200
MPQ_FILE_REPLACEEXISTING  = 0x80000000
MPQ_COMPRESSION_ZLIB      = 0x02
MPQ_COMPRESSION_PKWARE    = 0x08
MPQ_CREATE_ARCHIVE_V1     = 0x00000000
MPQ_CREATE_LISTFILE       = 0x00100000
MPQ_CREATE_ATTRIBUTES     = 0x00200000

def _n(name):
    return name.encode('mbcs') if isinstance(name, str) else name

class MPQ:
    def __init__(self, path, readonly=True):
        self.h = HANDLE()
        flags = MPQ_OPEN_READ_ONLY if readonly else 0
        if not S.SFileOpenArchive(os.path.abspath(path), 0, flags, byref(self.h)):
            raise OSError("SFileOpenArchive err=%d %s" % (ctypes.GetLastError(), path))
    @classmethod
    def create(cls, path, maxfiles=1024, flags=MPQ_CREATE_ARCHIVE_V1):
        m = cls.__new__(cls); m.h = HANDLE()
        path = os.path.abspath(path)
        if os.path.exists(path): os.remove(path)
        if not S.SFileCreateArchive(path, flags, maxfiles, byref(m.h)):
            raise OSError("SFileCreateArchive err=%d" % ctypes.GetLastError())
        return m
    def has(self, name): return bool(S.SFileHasFile(self.h, _n(name)))
    def read(self, name):
        f = HANDLE()
        if not S.SFileOpenFileEx(self.h, _n(name), 0, byref(f)):
            raise OSError("SFileOpenFileEx err=%d %s" % (ctypes.GetLastError(), name))
        hi = c_uint32(0); sz = S.SFileGetFileSize(f, byref(hi))
        buf = ctypes.create_string_buffer(sz); rd = c_uint32(0)
        ok = S.SFileReadFile(f, buf, sz, byref(rd), None)
        S.SFileCloseFile(f)
        if not ok and rd.value != sz:
            raise OSError("SFileReadFile err=%d %s" % (ctypes.GetLastError(), name))
        return buf.raw[:rd.value]
    def list(self, listfile=None):
        fd = SFILE_FIND_DATA(); out = []
        hf = S.SFileFindFirstFile(self.h, b"*", byref(fd), listfile)
        if not hf: return out
        while True:
            out.append(dict(name=fd.cFileName.decode('mbcs','replace'), size=fd.dwFileSize,
                            csize=fd.dwCompSize, flags=fd.dwFileFlags, locale=fd.lcLocale))
            if not S.SFileFindNextFile(hf, byref(fd)): break
        S.SFileFindClose(hf)
        return out
    def add(self, localpath, name, compress=True):
        fl = MPQ_FILE_REPLACEEXISTING | (MPQ_FILE_COMPRESS if compress else 0)
        if not S.SFileAddFileEx(self.h, os.path.abspath(localpath), _n(name), fl,
                                MPQ_COMPRESSION_ZLIB, MPQ_COMPRESSION_ZLIB):
            raise OSError("SFileAddFileEx err=%d %s" % (ctypes.GetLastError(), name))
    def add_bytes(self, data, name, compress=True, tmpdir=None):
        import tempfile
        d = tmpdir or tempfile.gettempdir()
        tp = os.path.join(d, "_mpqadd_%d.bin" % os.getpid())
        with open(tp, "wb") as fp: fp.write(data)
        try: self.add(tp, name, compress)
        finally:
            try: os.remove(tp)
            except OSError: pass
    def remove(self, name): return bool(S.SFileRemoveFile(self.h, _n(name), 0))
    def flush(self): S.SFileFlushArchive(self.h)
    def close(self):
        if self.h: S.SFileCloseArchive(self.h); self.h = None
    def __enter__(self): return self
    def __exit__(self, *a): self.close()

if __name__ == "__main__":
    with MPQ(sys.argv[1]) as m:
        for e in m.list():
            print("%-40s %10d %10d %08X" % (e['name'], e['size'], e['csize'], e['flags']))
        if len(sys.argv) > 2:
            d = m.read("staredit\scenario.chk")
            open(sys.argv[2], "wb").write(d)
            print("scenario.chk ->", sys.argv[2], len(d), "bytes")
