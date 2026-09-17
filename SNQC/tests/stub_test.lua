-- SNQC.lua 를 가짜 CtrigAsm 환경에서 끝까지 실행해 본다 (Lua 쪽 오류만 잡는다 - 트리거 의미는 못 본다)
-- 실행 (Lua 5.3 이상): lua stub_test.lua [SNQC.lua 경로]   2026-09-17 통과 (1.1: LuaLS 실행 파일의 Lua 5.5 로)
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
IndexUsed = 0   -- CtrigAsm IndexAlloc 사용량 어림 (CIf/CIfOnce 2, CIfX 3)
function CIf(p, c, a) assert(type(c) == "table" or c == nil, "CIf conds") for _, x in ipairs(c or {}) do assert(type(x) == "table", "cond not table: " .. tostring(x)) end depth = depth + 1 IndexUsed = IndexUsed + 2 end
function CIfOnce(p, c, a) depth = depth + 1 IndexUsed = IndexUsed + 2 end
local callOpen, callCount = false, 0
function SetCallForward() return 0x3000 + callCount * 2 end
function SetCall(p) assert(not callOpen, "SetCall already open") callOpen = true callCount = callCount + 1 end
function SetCallEnd() assert(callOpen, "SetCallEnd without SetCall") callOpen = false end
function CallTrigger(p, idx, addon) assert(type(idx) == "number", "CallTrigger index") assert(type(addon) == "table", "CallTrigger addon") end
function CallTriggerX(p, idx, conds, addon) assert(type(idx) == "number", "CallTriggerX index") assert(type(conds) == "table" and type(addon) == "table", "CallTriggerX args") end
function CTrigger(p, conds, acts, flags)
	assert(type(conds) == "table" and #conds <= 15, "CTrigger conds")
	for _, x in ipairs(conds) do assert(type(x) == "table", "CTrigger cond not table") end
	assert(type(acts) == "table" and #acts >= 1, "CTrigger acts")
	for _, x in ipairs(acts) do assert(type(x) == "table", "CTrigger act not table") end
end
local jumps = 0
function def_sIndex() jumps = jumps + 1 return jumps end
function CJump(p, i) end
function CJumpEnd(p, i) end
function CIfEnd() depth = depth - 1 assert(depth >= 0, "CIfEnd underflow") end
local xdepth = 0
function CIfX(p, c, a) for _, x in ipairs(c or {}) do assert(type(x) == "table", "condX not table") end xdepth = xdepth + 1 IndexUsed = IndexUsed + 3 end
function CElseX(a) assert(xdepth > 0, "CElseX outside") end
function CIfXEnd() xdepth = xdepth - 1 assert(xdepth >= 0) end
local function isvar(v) return type(v) == "table" and v[4] == "V" end
local function need(v, what) assert(isvar(v) or type(v) == "number", what .. " bad arg " .. tostring(v)) end
function CMov(p, d, s) assert(isvar(d), "CMov dest") need(s, "CMov src") end
function CAdd(p, d, s, o) assert(isvar(d) or type(d) == "number", "CAdd dest") need(s, "CAdd src") if o then need(o, "CAdd op") end end
function CSub(p, d, s, o) assert(isvar(d), "CSub dest") need(s, "CSub src") end
function CiSub(p, d, s, o) assert(isvar(d), "CiSub dest") need(s, "CiSub s") if o ~= nil then need(o, "CiSub o") end end
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
CurrentPlayer = 13
local LocNames = {Location74 = 74}
function ParseLocation(s) if LocNames[s] == nil then error("no location " .. s) end return LocNames[s] end
function ParseUnit(s) error("no unit " .. s) end
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
-- 1.1: Deaths(CurrentPlayer, ...) 조건, 로케이션 이름, SNQC_MyDeaths
SNQC_Line('Deaths(CurrentPlayer,Exactly,1,441);RIGHT = 200,1')
SNQC_Line('Deaths(CurrentPlayer,AtLeast,1,40);Deaths(CurrentPlayer,AtLeast,1,41);mouse: Location74')
assert(SNQC_Lines[#SNQC_Lines].Loc == 73, "Location74 -> 0부터 73")
assert(SNQC_Lines[#SNQC_Lines - 2].Loc == 4, "mouse : 5 -> 0부터 4")
SNQC_Key({SNQC_MyDeaths(AtLeast, 1, 443), SNQC_KeyDown("`")}, 219, 1)
SNQC_Value({SNQC_MousePress("L")}, 0x58F610, 532, {Hold = true, NewDeath = 533, Change = true})
SNQC_Mouse({}, 534, 535)
for i = 1, 30 do SNQC_Key({SNQC_KeyDown("F" .. ((i % 12) + 1))}, 600 + i, 1) end
SNQC_Install()
assert(not callOpen, "SetCall left open")
print("OK lines", #SNQC_Lines, "index~", IndexUsed, "calls", callCount, "vars", varidx, "void end", string.format("0x%X", void), "depth", depth, xdepth)
assert(not pcall(function() SNQC_Reset() SNQC_Config{MapTiles = {96, 192}, Humans = {0}} SNQC_Line("Bring(CurrentPlayer,AtLeast,1,0,64); A = 5,1") SNQC_Install() end), "CurrentPlayer 오용은 에러")
-- MSF_UE_RE 크기 (16채널 × 7명) 의 인덱스 어림: 키 34줄 + 값 13줄 + 마우스 1줄
SNQC_Reset()
IndexUsed = 0
SNQC_Config{MapTiles = {96, 192}, Humans = {0, 1, 2, 3, 4, 5, 6}, WorkAddr = 0x593C00, DebugAddr = 0x592100, Columns = 4, PlayerXY = (function() local T = {} for i = 0, 6 do T[i] = {720 + 256 * i, 5936} end return T end)()}
for i = 1, 34 do SNQC_Key({SNQC_KeyDown("F" .. ((i % 12) + 1)), SNQC_MyDeaths(AtLeast, 1, 441)}, 200 + i, 1) end
for i = 1, 13 do SNQC_Value({}, 0x58F600 + 4 * i, 150 + i) end
SNQC_Line('Deaths(CurrentPlayer,AtLeast,1,40);mouse: Location74')
SNQC_Install()
assert(IndexUsed < 400, "인덱스를 너무 많이 쓴다: " .. IndexUsed)
print("OK 1.1 checks, MSF_UE_RE size index~", IndexUsed)
-- 1.2: 채널 자리가 겹치면 멈춘다
assert(not pcall(function() SNQC_Reset() SNQC_Config{MapTiles = {96, 192}, Humans = {0, 1}, PlayerXY = {[0] = {720, 5936}, [1] = {720, 5936}}} SNQC_Key({"A"}, 200, 1) SNQC_Install() end), "겹친 자리는 에러")
print("OK 1.2 checks")
