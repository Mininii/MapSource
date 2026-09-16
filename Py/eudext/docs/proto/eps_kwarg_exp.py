from eudplib.epscript.epscompile import epsCompile
srcs = {
 "kwcall": "import eudext.numfmt as nf;\nfunction f() { const d = nf.Dec(3, width=5); }",
 "kwcall2": "function f() { const s = StringBuffer(1024); s.printf(\"{}\", 3); }",
 "method": "import eudext.i64 as i64;\nconst hp = i64.Int64(1);\nfunction f() { printAll(\"HP {}\", hp.fmt()); }",
 "modfunc": "import eudext.numfmt as nf;\nfunction f() { const d = nf.dec(3, 5, 0); }",
}
for k, s in srcs.items():
    try:
        out = epsCompile(k + ".eps", s.encode())
        body = out.decode() if isinstance(out, bytes) else str(out)
        lines = [l for l in body.splitlines() if l.strip() and not l.startswith(('from ', 'import ', '#'))]
        print("==", k, "OK"); print("\n".join(lines[-4:]))
    except BaseException as e:
        print("==", k, "ERR", type(e).__name__, str(e)[:200])
