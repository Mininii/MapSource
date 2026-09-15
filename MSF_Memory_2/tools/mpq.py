"""StormLib(C:\\euddraft0.9.2.0\\StormLib64.dll) 를 ctypes 로 부르는 얇은 포장.

맵의 MPQ 를 열어 파일 이름을 읽고, 파일을 꺼내고, 새 MPQ 를 만든다.
- mpyq 는 이 맵의 암호화된 (listfile)·scenario.chk 를 못 연다("Encryption is not supported yet").
- SFileFindFirstFile/NextFile 로 훑으면 해시 테이블의 중복 항목 때문에 같은 파일이 수천 번
  나온다(MSF_UE_RE.scx 에서 336개짜리가 끝나지 않았다). 그래서 이름은 (listfile) 에서만 얻는다.
- 이 DLL 은 유니코드 빌드다: 맵 경로(TCHAR)는 wchar, 보관 이름(char*)은 cp949 바이트.
"""
import ctypes
from ctypes import wintypes as wt

STORMLIB = r"C:\euddraft0.9.2.0\StormLib64.dll"
MPQ_OPEN_READ_ONLY = 0x00000100
MPQ_CREATE_LISTFILE = 0x00100000
MPQ_FILE_COMPRESS = 0x00000200
MPQ_FILE_REPLACEEXISTING = 0x80000000
# 1.16 시절 Storm 도 읽는 압축. zlib(0x02)은 워크래프트3 부터라 SCMDraft 로 다시 열 때를 생각해 피한다.
MPQ_COMPRESSION_PKWARE = 0x08
ENC = "cp949"

_H = ctypes.c_void_p
_dll = None


def dll():
    global _dll
    if _dll is None:
        d = ctypes.WinDLL(STORMLIB, use_last_error=True)
        for name, args in (
                ("SFileOpenArchive", (ctypes.c_wchar_p, wt.DWORD, wt.DWORD, ctypes.POINTER(_H))),
                ("SFileCreateArchive", (ctypes.c_wchar_p, wt.DWORD, wt.DWORD, ctypes.POINTER(_H))),
                ("SFileCloseArchive", (_H,)),
                ("SFileOpenFileEx", (_H, ctypes.c_char_p, wt.DWORD, ctypes.POINTER(_H))),
                ("SFileReadFile", (_H, ctypes.c_void_p, wt.DWORD, ctypes.POINTER(wt.DWORD), ctypes.c_void_p)),
                ("SFileCloseFile", (_H,)),
                ("SFileHasFile", (_H, ctypes.c_char_p)),
                ("SFileCreateFile", (_H, ctypes.c_char_p, ctypes.c_ulonglong, wt.DWORD, wt.DWORD, wt.DWORD,
                                     ctypes.POINTER(_H))),
                ("SFileWriteFile", (_H, ctypes.c_void_p, wt.DWORD, wt.DWORD)),
                ("SFileFinishFile", (_H,))):
            fn = getattr(d, name)
            fn.argtypes = args
            fn.restype = wt.BOOL
        d.SFileGetFileSize.argtypes = (_H, ctypes.POINTER(wt.DWORD))
        d.SFileGetFileSize.restype = wt.DWORD
        _dll = d
    return _dll


def _fail(what, target):
    return OSError("StormLib %s 실패 (오류 %d): %s" % (what, ctypes.get_last_error(), target))


def _bname(name):
    return name.encode(ENC) if isinstance(name, str) else name


class Archive:
    """with Archive(경로) as a: ...  /  with Archive(경로, create=True) as a: a.write(이름, 바이트)"""

    def __init__(self, path, create=False, max_files=16):
        self.path = path
        self.h = _H()
        if create:
            ok = dll().SFileCreateArchive(path, MPQ_CREATE_LISTFILE, max_files, ctypes.byref(self.h))
        else:
            ok = dll().SFileOpenArchive(path, 0, MPQ_OPEN_READ_ONLY, ctypes.byref(self.h))
        if not ok:
            raise _fail("SFileCreateArchive" if create else "SFileOpenArchive", path)

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        self.close()

    def close(self):
        if self.h:
            if not dll().SFileCloseArchive(self.h):
                raise _fail("SFileCloseArchive", self.path)
            self.h = _H()

    def has(self, name):
        return bool(dll().SFileHasFile(self.h, _bname(name)))

    def read(self, name):
        """파일 내용(bytes). 없으면 None."""
        f = _H()
        if not dll().SFileOpenFileEx(self.h, _bname(name), 0, ctypes.byref(f)):
            return None
        try:
            n = dll().SFileGetFileSize(f, None)
            buf = ctypes.create_string_buffer(max(n, 1))
            got = wt.DWORD()
            if n and not dll().SFileReadFile(f, buf, n, ctypes.byref(got), None):
                raise _fail("SFileReadFile", name)
            if got.value != n:
                raise OSError("%s: %d 바이트 중 %d 만 읽힘" % (name, n, got.value))
            return buf.raw[:n]
        finally:
            dll().SFileCloseFile(f)

    def names(self):
        """(listfile) 에 적힌 이름들 (중복 제거, 적힌 순서). listfile 이 없으면 빈 목록."""
        raw = self.read("(listfile)")
        if raw is None:
            return []
        seen, out = set(), []
        for ln in raw.replace(b"\r", b"\n").split(b"\n"):
            ln = ln.strip()
            if ln and ln.lower() not in seen:
                seen.add(ln.lower())
                out.append(ln.decode(ENC))
        return out

    def write(self, name, data, compression=MPQ_COMPRESSION_PKWARE):
        f = _H()
        flags = MPQ_FILE_COMPRESS | MPQ_FILE_REPLACEEXISTING
        if not dll().SFileCreateFile(self.h, _bname(name), 0, len(data), 0, flags, ctypes.byref(f)):
            raise _fail("SFileCreateFile", name)
        buf = ctypes.create_string_buffer(data, len(data))
        if not dll().SFileWriteFile(f, buf, len(data), compression):
            raise _fail("SFileWriteFile", name)
        if not dll().SFileFinishFile(f):
            raise _fail("SFileFinishFile", name)
