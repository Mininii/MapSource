"""Rebuild a CHK STR section with text substitutions."""
import sys, os, struct, io
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


def parse_str(data):
    n = struct.unpack_from("<H", data, 0)[0]
    offs = struct.unpack_from("<%dH" % n, data, 2)
    out = []
    for o in offs:
        if o >= len(data):
            out.append(b"")
            continue
        e = data.find(b"\0", o)
        out.append(data[o:e if e >= 0 else len(data)])
    return out


def build_str(strings):
    n = len(strings)
    header = 2 + 2 * n
    blob = io.BytesIO()
    offs = []
    seen = {}
    for s in strings:
        if s in seen:
            offs.append(seen[s])
            continue
        o = header + blob.tell()
        seen[s] = o
        offs.append(o)
        blob.write(s + b"\0")
    body = blob.getvalue()
    if header + len(body) > 65535:
        raise ValueError("STR section too large: %d bytes" % (header + len(body)))
    return struct.pack("<H", n) + struct.pack("<%dH" % n, *offs) + body


def substitute(data, pairs, replace=None):
    """pairs: [(utf-8 old, utf-8 new)] applied to every string;
    replace: {1-based index: utf-8 bytes} for whole-string replacement."""
    strings = parse_str(data)
    for i, s in enumerate(strings):
        for old, new in pairs:
            if old in s:
                s = s.replace(old, new)
        strings[i] = s
    for idx, val in (replace or {}).items():
        if 1 <= idx <= len(strings):
            strings[idx - 1] = val
    return build_str(strings)


if __name__ == "__main__":
    from chk import CHK
    c = CHK(open(sys.argv[1], "rb").read())
    for i, s in enumerate(parse_str(c.get("STR")), 1):
        if s:
            print(i, s.decode("utf-8", "replace")[:100])
