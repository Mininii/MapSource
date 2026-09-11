"""Minimal CHK (StarCraft scenario) reader/writer."""
import struct, io, collections

class CHK:
    def __init__(self, data=b""):
        self.sections = []           # list of [name(bytes4), payload(bytes)]
        if data: self.parse(data)
    def parse(self, data):
        off = 0; n = len(data)
        while off + 8 <= n:
            name = data[off:off+4]
            (size,) = struct.unpack_from("<i", data, off+4)
            off += 8
            if size < 0:
                off += size
                if off < 0: break
                continue
            payload = data[off:off+size]
            self.sections.append([name, payload])
            off += size
    @staticmethod
    def _nm(name):
        b = name if isinstance(name, bytes) else name.encode()
        return b[:4].ljust(4, b' ')
    def get(self, name):
        """Last occurrence wins (StarCraft semantics for most sections)."""
        name = self._nm(name)
        r = None
        for nm, p in self.sections:
            if nm == name: r = p
        return r
    def all(self, name):
        name = self._nm(name)
        return [p for nm, p in self.sections if nm == name]
    def set(self, name, payload):
        name = self._nm(name)
        found = False
        out = []
        for nm, p in self.sections:
            if nm == name:
                if found: continue
                out.append([nm, payload]); found = True
            else: out.append([nm, p])
        if not found: out.append([name, payload])
        self.sections = out
    def remove(self, name):
        name = self._nm(name)
        self.sections = [[n,p] for n,p in self.sections if n != name]
    def build(self):
        b = io.BytesIO()
        for nm, p in self.sections:
            b.write(nm[:4].ljust(4, b'\0')); b.write(struct.pack("<i", len(p))); b.write(p)
        return b.getvalue()
    def summary(self):
        c = collections.Counter()
        rows = []
        for nm, p in self.sections:
            c[nm] += 1
            rows.append((nm.decode('latin1'), len(p)))
        return rows, c
