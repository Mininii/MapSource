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


# StarCraft text colour / alignment codes are single control bytes that sit in
# front of the character they apply to. The source map's intro types its credits
# out with a different colour on almost every letter, so plain substring
# replacement never matches - the text has to be separated from the codes first.
CTRL = set(range(0x01, 0x20)) - {0x0A, 0x0D}
NEWLINE = chr(13) + chr(10)


def apply_once(s, pairs):
    """Longest-match-first substitution in a single left-to-right pass, so a
    replacement is never re-substituted by a later rule. Works on str or bytes."""
    order = sorted(pairs, key=lambda kv: -len(kv[0]))
    parts = []
    i = 0
    n = len(s)
    while i < n:
        for old, new in order:
            if old and s.startswith(old, i):
                parts.append(new)
                i += len(old)
                break
        else:
            parts.append(s[i:i + 1])
            i += 1
    return ("" if isinstance(s, str) else b"").join(parts)


def _split_colored(line):
    """(text without control codes, code prefix per visible character, trailing)."""
    plain = []
    codes = []
    pending = ""
    for ch in line:
        if ord(ch) in CTRL:
            pending += ch
        else:
            plain.append(ch)
            codes.append(pending)
            pending = ""
    return "".join(plain), codes, pending


def apply_colored(data, pairs):
    """Substitute in colour-coded text, keeping each character's colour by
    position so the typing animation still looks the same."""
    text = data.decode("utf-8", "surrogateescape")
    out = []
    for line in text.split(NEWLINE):
        plain, codes, tail = _split_colored(line)
        new = apply_once(plain, pairs)
        if new == plain:
            out.append(line)
            continue
        buf = []
        for i, ch in enumerate(new):
            if i < len(codes):
                buf.append(codes[i])
            buf.append(ch)
        buf.append(tail)
        out.append("".join(buf))
    return NEWLINE.join(out).encode("utf-8", "surrogateescape")


def substitute(data, pairs, replace=None):
    """pairs: [(old str, new str)] applied to every string in one pass;
    replace: {1-based index: utf-8 bytes} for whole-string replacement."""
    strings = parse_str(data)
    for i, s in enumerate(strings):
        strings[i] = apply_colored(s, pairs)
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
