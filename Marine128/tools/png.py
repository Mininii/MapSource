"""Dependency-free PNG writer (RGB8 / palette)."""
import zlib, struct

def _chunk(t, d):
    c = t + d
    return struct.pack(">I", len(d)) + c + struct.pack(">I", zlib.crc32(c) & 0xffffffff)

def write_rgb(path, w, h, rows):
    """rows: iterable of bytes-like, each 3*w bytes."""
    raw = bytearray()
    for r in rows:
        raw.append(0); raw += r
    data = zlib.compress(bytes(raw), 6)
    out = b"\x89PNG\r\n\x1a\n"
    out += _chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
    out += _chunk(b"IDAT", data)
    out += _chunk(b"IEND", b"")
    open(path, "wb").write(out)

def write_indexed(path, w, h, idx_rows, palette):
    """idx_rows: iterable of bytes (w bytes); palette: list of (r,g,b) up to 256."""
    raw = bytearray()
    for r in idx_rows:
        raw.append(0); raw += r
    pal = b"".join(bytes(p[:3]) for p in palette)
    out = b"\x89PNG\r\n\x1a\n"
    out += _chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 3, 0, 0, 0))
    out += _chunk(b"PLTE", pal)
    out += _chunk(b"IDAT", zlib.compress(bytes(raw), 6))
    out += _chunk(b"IEND", b"")
    open(path, "wb").write(out)
