import os, sys, time, struct
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import lupa_cbpaint_exp as X
for s in (sys.stdout,):
    s.reconfigure(encoding="utf-8", errors="replace")
L = X.make_runtime()
X.load_file(L, os.path.join(X.LIB, "CB Paint v2.5.lua"))
g = L.globals()
fill = g.CS_FillXY(0, 128, 96, 16, 16)
n, pts = X.shape_to_py(fill)
print("CS_FillXY(0,128,96,16,16) n=%d first=%s" % (n, pts[:4]))
circ = g.CSMakeCircle(6, 32, 0, 19, 0)
tri = g.CSMakePolygon(3, 24, 0, 4, 0)
try:
    r = g.CS_ShapeInShape(circ, tri, 1, 0, None)
    n2, p2 = X.shape_to_py(r)
    print("CS_ShapeInShape(rotate=1) n=%d first=%s" % (n2, [(round(a,2),round(b,2)) for a,b in p2[:4]]))
except Exception as e:
    print("CS_ShapeInShape err:", str(e).splitlines()[0][:300])
# without atan2 shim
L2 = X.lua54.LuaRuntime(unpack_returned_tuples=True, register_eval=False, encoding="latin-1")
L2.globals()["bit32"] = L2.execute(X.BIT32_LUA)
X.load_file(L2, os.path.join(X.LIB, "CB Paint v2.5.lua"))
g2 = L2.globals()
try:
    g2.CS_ShapeInShape(g2.CSMakeCircle(6,32,0,19,0), g2.CSMakePolygon(3,24,0,4,0), 1, 0, None)
    print("no-shim ShapeInShape: ok")
except Exception as e:
    print("no-shim ShapeInShape err:", str(e).splitlines()[0][:200])
# big shape timing + pack to int16 pairs (Db 재료)
t=time.time()
big = g.CSMakeCircle(12, 16, 0, 1700, 0)
n3, p3 = X.shape_to_py(big)
blob = b"".join(struct.pack("<hh", int(round(x)), int(round(y))) for x,y in p3)
print("CSMakeCircle 1700 pts: %.3fs, maxabs=%d, packed=%d bytes" % (time.time()-t, max(max(abs(int(round(x))),abs(int(round(y)))) for x,y in p3), len(blob)))
# trunc vs round difference count (TEP 는 0 방향 자름이라는 cmp_A3 기록과 비교)
diff = sum(1 for x,y in p3 if (int(x),int(y)) != (int(round(x)),int(round(y))))
print("trunc!=round points:", diff, "/", n3)
