-- SNQC.lua 를 가짜 CtrigAsm 환경에서 끝까지 실행해 본다 (Lua 쪽 오류만 잡는다 - 트리거 의미는 못 본다)
-- 실행 (Lua 5.3): lua stub_test.lua [SNQC.lua 경로]   2026-09-17 통과
local calls = {}
local varidx = 0
local function V() varidx = varidx + 1 return {"X", varidx, 0, "V"} end
function CreateVar(p) return V() end
function CreateVars(n, p) local t = {} for i = 1, n do t[i] = V() end return table.unpack(t) end
local void = 0x58F500 - 4
function CreateVoid() void = void + 4 return void end
function CreateVoids(n) local t = {} for i = 1, n do void = void + 4 t[i] = void end return table.unpack(t) end
function PushErrorMsg(m) error("PushErrorMsg: " .. tostring(m)) end
local depth = 0
function CIf(p, c, a) assert(type(c) == "table" or c == nil, "CIf conds") for _, x in ipairs(c or {}) do assert(type(x) == "table", "cond not table: " .. tostring(x)) end depth = depth + 1 end
function CIfOnce(p, c, a) depth = depth + 1 end
function CIfEnd() depth = depth - 1 assert(depth >= 0, "CIfEnd underflow") end
local xdepth = 0
function CIfX(p, c, a) for _, x in ipairs(c or {}) do assert(type(x) == "table", "condX not table") end xdepth = xdepth + 1 end
function CElseX(a) assert(xdepth > 0, "CElseX outside") end
function CIfXEnd() xdepth = xdepth - 1 assert(xdepth >= 0) end
local function isvar(v) return type(v) == "table" and v[4] == "V" end
local function need(v, what) assert(isvar(v) or type(v) == "number", what .. " bad arg " .. tostring(v)) end
function CMov(p, d, s) assert(isvar(d), "CMov dest") need(s, "CMov src") end
function CAdd(p, d, s, o) assert(isvar(d) or type(d) == "number", "CAdd dest") need(s, "CAdd src") if o then need(o, "CAdd op") end end
function CSub(p, d, s, o) assert(isvar(d), "CSub dest") need(s, "CSub src") end
function CiSub(p, d, s, o) assert(isvar(d), "CiSub dest") need(s, "CiSub s") need(o, "CiSub o") end
function CMul(p, d, s, o) assert(isvar(d), "CMul dest") need(s, "CMul s") end
function CAnd(p, d, s, o) assert(isvar(d), "CAnd dest") need(s, "CAnd s") need(o, "CAnd o") end
function COr(p, d, s, o) assert(isvar(d), "COr dest") need(s, "COr s") end
function CRead(p, d, a) assert(isvar(d), "CRead dest") assert(type(a) == "number", "CRead addr") end
function f_Read(p, i, o, e, m) assert(o == nil or isvar(o), "f_Read out") assert(e == nil or isvar(e), "f_Read epd") end
function f_Memcpy(p, d, s, n) need(d, "memcpy d") need(s, "memcpy s") assert(type(n) == "number") end
function f_EPDToAlphaID(p, i, o) assert(isvar(i) and isvar(o), "EPDToAlpha") end
function CDoActions(p, a) assert(type(a) == "table") for _, x in ipairs(a) do assert(type(x) == "table", "action not table") end end
function _Add(v, n) assert(isvar(v)) return {"X", v[2], n, "V"} end
local mt = {__index = function(t, k) return function(...) return {k, ...} end end}
setmetatable(_G, mt)
Exactly, AtLeast, AtMost, SetTo, Add, Set, Cleared = 0, 1, 2, 7, 8, 1, 0
FP = 7
dofile((arg and arg[1]) or "../SNQC.lua")  -- MapSource/SNQC/tests 에서 실행
SNQC_Config{MapTiles = {192, 96}, Humans = {0, 1, 2, 3, 4, 5, 6}, WorkAddr = 0x58F7C0}
SNQC_Key({SNQC_NotTyping(), SNQC_KeyDown("Y")}, 522, 1)
SNQC_Key({SNQC_KeyPress("LALT"), SNQC_KeyDown("1")}, 518, 1)
SNQC_Line('Memory(0x68C144,Exactly,0);Switch("Switch 254",Set);KeyPress(LALT);2 = 519,1')
SNQC_Line('Memory(0x68C144,Exactly,0);F9 = 13,1')
SNQC_Line('0x58F500, Exactly, 1: 13,1')
SNQC_Line('Switch("Switch 199", Set); val, 0x58F600 : 510')
SNQC_Line('Memory(0x58F504,AtLeast,1);val, 0x58F504: 20')
SNQC_Line('xy, 0x58F608, 0x58F60C : 530, 531')
SNQC_Line('mouse : 5')
SNQC_Value({SNQC_MousePress("L")}, 0x58F610, 532, {Hold = true, NewDeath = 533, Change = true})
SNQC_Mouse({}, 534, 535)
for i = 1, 30 do SNQC_Key({SNQC_KeyDown("F" .. ((i % 12) + 1))}, 600 + i, 1) end
SNQC_Install()
print("OK lines", #SNQC_Lines, "vars", varidx, "void end", string.format("0x%X", void), "depth", depth, xdepth)
