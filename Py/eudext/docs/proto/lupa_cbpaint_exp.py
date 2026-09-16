"""실험: lupa(Lua 5.4) 로 CB Paint v2.5.lua 를 불러 도형 좌표를 파이썬으로 받는다.

원본 파일은 읽기만 한다. 쓰기(CSSave 등)는 스크래치패드 안 FileDirectory 로 돌린다.
"""
import math
import os
import sys
import time

LIB = r"C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2\MapSource\Library"
DPS_EUD = r"C:\Users\whatd\Desktop\Stormcoast Fortress\ScmDraft 2\DPS_eud\eud"
SCRATCH = os.path.dirname(os.path.abspath(__file__))
OUTDIR = os.path.join(SCRATCH, "cbpaint_out")
os.makedirs(OUTDIR, exist_ok=True)

sys.path.insert(0, DPS_EUD)
from ctrig.luart import BIT32_LUA  # noqa: E402  (DPS 이식 계층의 bit32 흉내를 그대로 빌려 쓴다)

import lupa.lua54 as lua54  # noqa: E402

for s in (sys.stdout, sys.stderr):
    try:
        s.reconfigure(encoding="utf-8", errors="replace")
    except AttributeError:
        pass


def make_runtime(shims=True):
    L = lua54.LuaRuntime(unpack_returned_tuples=True, register_eval=False, encoding="latin-1")
    g = L.globals()
    if shims:
        g["bit32"] = L.execute(BIT32_LUA)
        L.execute(r"""
            math.atan2 = math.atan2 or function(y, x) return math.atan(y, x) end
            math.pow   = math.pow   or function(a, b) return a ^ b end
            math.log10 = math.log10 or function(x) return math.log(x, 10) end
            math.ldexp = math.ldexp or function(m, e) return m * 2.0 ^ e end
            unpack     = unpack     or table.unpack
            -- names normally provided by TEP/CtrigAsm
            PushErrorMsg = PushErrorMsg or function(msg) error(msg, 2) end
        """)
        g["FileDirectory"] = OUTDIR.replace("\\", "/") + "/"
    return L


def load_file(L, path):
    with open(path, "rb") as f:
        src = f.read()
    if src.startswith(b"\xef\xbb\xbf"):
        src = src[3:]
    loader = L.eval("function(src, name) return assert(load(src, name)) end")
    return loader(src.decode("latin-1"), "@" + os.path.basename(path))()


def shape_to_py(t):
    """CX Paint Shape {n, {x,y}, ...} → (n, [(x,y), ...]). 인덱스 1 = 개수, 2..n+1 = 점."""
    n = t[1]
    pts = []
    for i in range(2, n + 2):
        p = t[i]
        pts.append((p[1], p[2]))
    return n, pts


def main():
    log = []

    def out(*a):
        s = " ".join(str(x) for x in a)
        print(s)
        log.append(s)

    # 0) shim 없이 실제로 없는 것 확인
    L0 = make_runtime(shims=False)
    missing = L0.execute("""
        local r = {}
        for _, k in ipairs({"atan2","pow","log10","ldexp","cosh"}) do if math[k] == nil then r[#r+1] = "math."..k end end
        if bit32 == nil then r[#r+1] = "bit32" end
        if unpack == nil then r[#r+1] = "unpack" end
        if loadstring == nil then r[#r+1] = "loadstring" end
        if setfenv == nil then r[#r+1] = "setfenv" end
        r[#r+1] = "_VERSION=" .. _VERSION
        return table.concat(r, ", ")
    """)
    out("[0] lupa 기본 환경에 없는 것:", missing)

    # 1) CB Paint 불러오기
    L = make_runtime()
    t0 = time.time()
    load_file(L, os.path.join(LIB, "CB Paint v2.5.lua"))
    out("[1] CB Paint v2.5.lua 로드 %.2fs" % (time.time() - t0))
    g = L.globals()
    nfunc = L.execute("""
        local n, cs = 0, 0
        for k, v in pairs(_G) do
            if type(v) == "function" then n = n + 1
                if type(k) == "string" and (k:sub(1,2) == "CS" or k:sub(1,2) == "CA" or k:sub(1,2) == "CB") then cs = cs + 1 end
            end
        end
        return n .. " functions, CS*/CA*/CB* " .. cs
    """)
    out("    전역 함수 수:", nfunc)

    # 2) CSMakeCircle
    circ = g.CSMakeCircle(6, 32, 0, 37, 0)
    n, pts = shape_to_py(circ)
    out("[2] CSMakeCircle(6,32,0,37,0): n=%d, 첫 8점:" % n, [(round(x, 3), round(y, 3)) for x, y in pts[:8]])
    # 좌표 규약 확인: 두 번째 점 = 1번째 껍질의 0번 = 12시 방향이어야 함
    out("    2번째 점(1껍질 첫 점) =", pts[1], "→ (0,-32) 이면 0도=12시, y 아래 방향")
    out("    최대 반지름 = %.3f" % max(math.hypot(x, y) for x, y in pts))

    # 3) 다른 진입 함수들
    tests = [
        ("CSMakePolygon(4,40,0,25,0)", lambda: g.CSMakePolygon(4, 40, 0, 25, 0)),
        ("CSMakeStar(5,72,50,0,CS_Level(\"Polygon\",5,3),0)", None),
        ("CSMakeLine(4,30,0,13,1)", lambda: g.CSMakeLine(4, 30, 0, 13, 1)),
        ("CS_Rotate(circle,45)", lambda: g.CS_Rotate(circ, 45)),
        ("CS_MoveXY(circle,100,-50)", lambda: g.CS_MoveXY(circ, 100, -50)),
        ("CS_RatioXY(circle,2,0.5)", lambda: g.CS_RatioXY(circ, 2, 0.5)),
        ("CS_FillXY(0,{128,128},16,16)", lambda: g.CS_FillXY(0, L.table(128, 128), 16, 16)),
    ]
    for name, fn in tests:
        if fn is None:
            continue
        try:
            r = fn()
            n2, p2 = shape_to_py(r)
            out("[3] %s → n=%d, 첫 3점 %s" % (name, n2, [(round(x, 2), round(y, 2)) for x, y in p2[:3]]))
        except Exception as e:  # noqa: BLE001
            out("[3] %s → 오류: %s" % (name, str(e).splitlines()[0][:200]))

    # 4) 문자열 콜백 (_G[FuncName]) 경로: CSMakeGraphT
    try:
        L.execute("function __expT(t) return {60*math.cos(t/10), 60*math.sin(t/10)} end")
        r = L.execute("return CSMakeGraphT({1,1},'__expT',0,0,8,nil,40)")
        n3, p3 = shape_to_py(r)
        out("[4] CSMakeGraphT(문자열 콜백) → n=%d, 첫 3점 %s" % (n3, [(round(x, 2), round(y, 2)) for x, y in p3[:3]]))
    except Exception as e:  # noqa: BLE001
        out("[4] CSMakeGraphT → 오류: %s" % str(e).splitlines()[0][:300])

    # 5) atan2 를 쓰는 CS_ShapeInShape (shim 확인)
    try:
        src = L.execute("return debug.getinfo(CS_ShapeInShape, 'S').linedefined")
        out("[5] CS_ShapeInShape 정의 줄:", src)
    except Exception as e:  # noqa: BLE001
        out("[5] CS_ShapeInShape 조회 오류:", e)

    # 6) 파이썬 → Lua 테이블 넘기기 (직접 만든 Path)
    path = L.table_from([L.table_from([0, 0]), L.table_from([64, 0]), L.table_from([64, 64])])
    try:
        r = g.CSMakePath(path)
        n4, p4 = shape_to_py(r)
        out("[6] CSMakePath(파이썬 표) → n=%d %s" % (n4, p4))
        r2 = g.CS_ConnectPath(r, 16)
        n5, p5 = shape_to_py(r2)
        out("    CS_ConnectPath(.,16) → n=%d 첫 5점 %s" % (n5, [(round(x, 2), round(y, 2)) for x, y in p5[:5]]))
    except Exception as e:  # noqa: BLE001
        out("[6] 오류:", str(e).splitlines()[0][:300])

    # 7) CSMakeSpiral.lua / CS_Addon.lua 덧불러오기
    for fn in ("CSMakeSpiral.lua", "CS_Addon.lua"):
        try:
            t1 = time.time()
            load_file(L, os.path.join(LIB, fn))
            out("[7] %s 로드 %.2fs" % (fn, time.time() - t1))
        except Exception as e:  # noqa: BLE001
            out("[7] %s 로드 오류: %s" % (fn, str(e).splitlines()[0][:300]))
    try:
        info = L.execute("local i = debug.getinfo(CSMakeSpiral, 'S') return i.short_src .. ':' .. i.linedefined")
        out("    CSMakeSpiral 은 이제", info, "의 정의")
    except Exception as e:  # noqa: BLE001
        out("    CSMakeSpiral 조회 오류", e)

    # 8) 난수: CB Paint 는 로드 때 math.randomseed(os.time()) → 빌드마다 결과가 달라지는 함수 확인
    try:
        L.execute("math.randomseed(1234)")
        a = shape_to_py(g.CS_Shuffle(circ))[1][:3]
        L.execute("math.randomseed(1234)")
        b = shape_to_py(g.CS_Shuffle(circ))[1][:3]
        out("[8] CS_Shuffle 고정 시드 재현:", a == b, a)
    except Exception as e:  # noqa: BLE001
        out("[8] CS_Shuffle 오류:", str(e).splitlines()[0][:300])

    # 9) CSSave (파일 쓰기) — FileDirectory 를 스크래치로 돌려 둠
    try:
        L.execute("function isdir(p) local f = io.open(p, 'r') if f then f:close() return true end return nil end")
        g.CSSaveWithName("exp_circle", 0, circ, "ExpCircle")
        out("[9] CSSaveWithName → 파일:", os.listdir(os.path.join(OUTDIR, "CS")) if os.path.isdir(os.path.join(OUTDIR, "CS")) else os.listdir(OUTDIR))
    except Exception as e:  # noqa: BLE001
        out("[9] CSSaveWithName 오류:", str(e).splitlines()[0][:300])

    # 10) CSPlot (트리거 방출) 은 TEP/CtrigAsm 없이 도는가
    try:
        g.CSPlot(circ, 0, "Terran Marine", "Anywhere", None, 1, 32, None, None, 0, None)
        out("[10] CSPlot → 뜻밖에 성공")
    except Exception as e:  # noqa: BLE001
        out("[10] CSPlot → 예상대로 실패:", str(e).splitlines()[0][:200])

    with open(os.path.join(SCRATCH, "lupa_cbpaint_exp.log"), "w", encoding="utf-8") as f:
        f.write("\n".join(log))


if __name__ == "__main__":
    main()
