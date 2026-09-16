--[[
	SNQC.lua - Sana Natori QueueCommand (CtrigAsm / TEP 판)
	MSQC(Murakami Shiina QueueCommand)를 대신하는 "로컬 입력 → 모든 PC 동기화" 라이브러리.
	설계와 실측 근거: DESIGN.md (같은 폴더). euddraft 플러그인 판은 SNQC.py. 작업 내역: HISTORY.md.
	★ MapSource/Library 가 아니라 MapSource/SNQC 에 있으므로 **자동으로 읽히지 않는다.** 쓰는 맵이 직접 읽는다:
	    dofile(Curdir .. "MapSource/SNQC/SNQC.lua")   (Windows 도 / 로 된다. 또는 Bootstrap.lua 의 MS_LoadDir 로 이 폴더를 읽기 - tests 는 하위라 안 읽힌다)

	■ 무엇이 다른가 (MSQC 와 비교)
	  MSQC 는 숨긴 비행 건물(QC 유닛)에 Move 명령을 보내 **이동 목표 좌표**에 값을 싣는다. 그런데 스타가 150프레임마다
	  그 Move 오더를 다시 시작시켜 그 사이클의 값이 사라진다 (theSeed QUEUE_COMMAND_RESEARCH.md T3).
	  SNQC 는 **가린 커맨드센터(채널 건물)의 랠리 좌표**에 싣는다 (오더 40 Rally to Ground Tile).
	    - 랠리 칸은 엔진이 스스로 바꾸지 않는다 → 주기적 소실이 없다.
	    - 받는 쪽이 매 사이클 칸을 기준값 (0,0) 으로 되돌리므로 같은 값을 두 번 보내도 두 번 받는다.
	    - 채널 건물은 건설크기 (1,0) 이라 아무에게도 안 보이고 드래그로도 안 골라지는데 큐 명령은 받는다.
	  (위 세 가지는 2026-09-17 SC:R 실측으로 확인했다 - DESIGN.md "실측")

	■ 쓰는 법
	    SNQC_Config{ MapTiles = {192, 96}, Humans = {0,1,2,3,4,5,6} }   -- 필수 두 칸. 나머지는 SNQC_DefaultConfig
	    SNQC_Key({SNQC_NotTyping(), SNQC_KeyDown("Y")}, 522, 1)          -- 키 줄: 조건이 참이면 받는 쪽 데스값 +1
	    SNQC_Value({Switch("Switch 199", Set)}, 0x58F600, 510)           -- 값 줄: 주소(또는 CtrigAsm 변수)의 값을 보낸다
	    SNQC_Line('Memory(0x68C144,Exactly,0);Switch("Switch 254",Set);KeyPress(LALT);1 = 518,1')  -- MSQC eds 줄 문법도 된다
	    ...
	    SNQC_Install()   -- 트리거를 만든다. **받은 데스값을 읽는 트리거보다 앞에서** 한 번 부른다 (CtrigAsm 은 선언 순서 = 실행 순서)
	  줄 등록(SNQC_Key 등)은 파일 맨 위에서 해도 된다 - 변수는 SNQC_Install 안에서 만든다.

	■ 한 사이클의 순서 (SNQC_Install 이 만드는 트리거)
	    ① (공유, 처음 한 번) units.dat 패치 + 플레이어별 채널 건물 만들기 (없어진 채널은 다시 만든다)
	    ② (로컬) 선택 저장 → 줄마다 값 계산 → 턴 버퍼에 "Select 채널 + 오더 40(x,y)" 쓰기 → 선택 되돌리기
	    ③ (공유) 플레이어마다 채널 랠리 칸 읽기 → 0 이 아니면 풀어서 데스값에 쓰고 칸을 0 으로
	    ④ (로컬) 키·마우스 눌림 상태 기억 (KeyDown/KeyUp 판정용)
	  ★ ②④ 는 각 PC 의 로컬 상태만 쓴다 (턴 버퍼, 이 파일이 만든 변수, 공유 로직이 안 읽는 값).
	    ①③ 은 모든 PC 가 같은 값을 보는 공유 동작이다. 로컬 조건으로 공유 상태를 바꾸면 동기화가 깨진다.

	■ 받는 쪽 결과 (MSQC 와 같게)
	  키 줄  : 그 플레이어의 Death 에, 이번 사이클에 받은 줄마다 Add 를 더한다. **매 사이클 0 에서 시작**한다.
	  값 줄  : 받은 사이클에 Death = 값. 안 받은 사이클은 0 (Hold = true 면 그대로 둔다).
	           NewDeath 를 주면 받은 사이클에 1, 아니면 0 (MSQC 에 없던 "새 값이 왔는가" 표시).
	  좌표 줄: DeathX / DeathY = 좌표. 마우스 줄은 마우스가 가리키는 맵 좌표를 움직였을 때만 보낸다.

	■ 조건 (줄의 Conds) - 각 PC 에서 평가되는 로컬 조건
	  SNQC_KeyDown(k)  눌린 순간     SNQC_KeyUp(k)  뗀 순간     SNQC_KeyPress(k)  누르고 있는 동안
	  SNQC_MouseDown(b) / SNQC_MouseUp(b) / SNQC_MousePress(b)   b = "L" / "R" / "M"
	  SNQC_NotTyping()  채팅창이 닫혀 있을 때 (0x68C144 == 0)
	  그 밖의 TEP/CtrigAsm 조건은 그대로 넣으면 된다 (예: Switch("Switch 254", Set)). 목록은 평평하게(중첩 없이) 준다.
	  문자열이면 MSQC 문법으로 푼다: "Y"(= KeyDown), "KeyPress(LALT)", "MousePress(L)", "NotTyping",
	  "0x68C144,Exactly,0", 그 밖은 Lua 식으로 평가한다 (예: 'Switch("Switch 254",Set)').

	⚠ 신규 2026-09-17: luac 문법 검사 + 가짜 CtrigAsm 환경 실행(tests/stub_test.lua)만. 실제 TEP 컴파일·인게임 확인 전.
	  (같은 설계의 플러그인 판 SNQC.py 는 theSeed 인게임 통과.) 확인할 것은 DESIGN.md "확인 목록".
]]

-- ─────────────────────────────────────────────────────────────────────────────
-- 설정
-- ─────────────────────────────────────────────────────────────────────────────
SNQC_DefaultConfig = {
	Unit          = 106,        -- 채널 건물. 랠리를 받는 12종(CC·배럭·팩토리·스타포트·인페스티드CC·해처리·레어·하이브·넥서스·게이트웨이·
	                            -- 스타게이트·로보틱스) 중 **맵에서 안 쓰는 종류**여야 한다 - 아래 units.dat 패치가 종류 전체에 걸린다
	Player        = 10,         -- 채널 건물을 넘겨 둘 플레이어 (0부터, 10 = P11). 사람의 유닛 수에 안 잡히게 (MSQC 의 QCPlayer)
	Loc           = 0,          -- 만들 때 잠깐 옮겨 쓰는 로케이션 (0부터). 쓰고 나면 원래 자리로 되돌린다
	XY            = {128, 128}, -- 첫 채널 건물 자리 (픽셀)
	Step          = {32, 32},   -- 채널마다 x 로, 플레이어마다 y 로 이만큼 옮겨 만든다 (넘길 때 서로 안 걸리게)
	BuildSize     = {1, 0},     -- 건설크기(픽셀). (1,0)/(0,1)/(0,0) 이 가려진다 (실측)
	Order         = 40,         -- Rally to Ground Tile
	Merge         = true,       -- 아직 안 나간 자기 패킷이 버퍼에 있으면 새로 붙이지 않고 그 좌표를 고친다 (키 = 비트 합치기, 값 = 덮어쓰기)
	BufferLimit   = 400,        -- 턴 버퍼 길이가 이보다 크면 붙이지 않는다 (상한 0x57F0D8 = 496, Sync 7 + 선택 되돌리기 26 여유)
	Check         = true,       -- 채널 건물이 없어졌는지 CheckInterval 사이클마다 보고 없어졌으면 다시 만든다
	CheckInterval = 34,
	WorkAddr      = nil,        -- 로컬 작업 공간 52바이트의 주소 (패킷 조립용). nil 이면 CreateVoids(13).
	                            -- ⚠ 맵이 0x58F500 부터를 CreateVoid 없이 직접 쓰고 있으면(DPS 의 0x58F500~) 반드시 비어 있는 주소를 준다
	MapTiles      = nil,        -- 필수: 맵 크기(타일) {가로, 세로}
	Humans        = nil,        -- 필수: 채널을 만들 플레이어 번호 목록 (0부터, 사람 슬롯)
}

SNQC_MaxChannels = 64

function SNQC_Reset()
	SNQC_Cfg = {}
	for k, v in pairs(SNQC_DefaultConfig) do SNQC_Cfg[k] = v end
	SNQC_Lines = {}         -- {Kind = "Key"|"Value"|"Point"|"Mouse", Conds = {...}, ...} 등록 순서대로
	SNQC_Installed = false
end
SNQC_Reset()

-- 설정 이름 (기본값이 nil 인 칸도 있어서 따로 적는다)
local SNQC_ConfigKeys = {Unit = true, Player = true, Loc = true, XY = true, Step = true, BuildSize = true, Order = true,
	Merge = true, BufferLimit = true, Check = true, CheckInterval = true, WorkAddr = true, MapTiles = true, Humans = true}

function SNQC_Config(T)
	for k, v in pairs(T or {}) do
		if not SNQC_ConfigKeys[k] then
			PushErrorMsg("SNQC_Config: 모르는 설정 " .. tostring(k))
		end
		SNQC_Cfg[k] = v
	end
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 조건 도우미 - SNQC_Install 때 실제 조건으로 바뀐다 (변수는 그때 만든다)
-- ─────────────────────────────────────────────────────────────────────────────
local function Desc(Kind, Arg) return {SNQC = Kind, Arg = Arg} end
function SNQC_KeyDown(k)    return Desc("KeyDown", string.upper(k)) end
function SNQC_KeyUp(k)      return Desc("KeyUp", string.upper(k)) end
function SNQC_KeyPress(k)   return Desc("KeyPress", string.upper(k)) end
function SNQC_MouseDown(b)  return Desc("MouseDown", string.upper(b)) end
function SNQC_MouseUp(b)    return Desc("MouseUp", string.upper(b)) end
function SNQC_MousePress(b) return Desc("MousePress", string.upper(b)) end
function SNQC_NotTyping()   return Desc("NotTyping") end

-- ─────────────────────────────────────────────────────────────────────────────
-- 줄 등록
-- ─────────────────────────────────────────────────────────────────────────────
local function AddLine(L)
	if SNQC_Installed then PushErrorMsg("SNQC: SNQC_Install 뒤에는 줄을 더할 수 없다") end
	table.insert(SNQC_Lines, L)
	return L
end

-- 키 줄. Death = 받는 쪽 데스 유닛 번호, Add = 받은 사이클에 더할 값
function SNQC_Key(Conds, Death, Add)
	return AddLine({Kind = "Key", Conds = Conds, Death = Death, Add = Add or 1})
end

-- 값 줄. Src = 주소(숫자) 또는 CtrigAsm 변수. 보낼 수 있는 값은 0 ~ SNQC_ValueMax() (맵 크기로 정해진다)
-- Opt: {Hold = true (안 받은 사이클에 값을 그대로 둔다), NewDeath = 번호 (받은 사이클에 1), Change = true (값이 바뀐 사이클에만 보낸다)}
function SNQC_Value(Conds, Src, Death, Opt)
	Opt = Opt or {}
	return AddLine({Kind = "Value", Conds = Conds, Src = Src, Death = Death,
		Hold = Opt.Hold, NewDeath = Opt.NewDeath, Change = Opt.Change})
end

-- 좌표 줄. SrcX / SrcY = 주소 또는 변수 (맵 픽셀 좌표). 맨 오른쪽 한 줄(x = 맵 폭 - 1)은 x - 1 로 간다 (기준값을 피하느라)
function SNQC_Point(Conds, SrcX, SrcY, DeathX, DeathY, Opt)
	Opt = Opt or {}
	return AddLine({Kind = "Point", Conds = Conds, SrcX = SrcX, SrcY = SrcY, DeathX = DeathX, DeathY = DeathY,
		Hold = Opt.Hold, NewDeath = Opt.NewDeath})
end

-- 마우스 줄. 마우스가 가리키는 맵 좌표(화면 위치 + 화면 안 마우스 위치)를 **바뀐 사이클에만** 보낸다.
-- DeathX/DeathY 에 쓰고(Hold 기본 true), Opt.Loc 를 주면 (Loc + 플레이어 번호) 로케이션을 그 점으로 옮긴다 (MSQC 의 mouse 줄).
function SNQC_Mouse(Conds, DeathX, DeathY, Opt)
	Opt = Opt or {}
	local Hold = Opt.Hold
	if Hold == nil then Hold = true end
	return AddLine({Kind = "Mouse", Conds = Conds, DeathX = DeathX, DeathY = DeathY, Loc = Opt.Loc,
		Hold = Hold, NewDeath = Opt.NewDeath})
end

-- MSQC .eds 줄 문법 한 줄. "조건;조건;... = 결과" 또는 "... : 결과"
--   키 줄     : 결과 = "데스유닛, 더할값"
--   값 줄     : 조건에 "val, 주소" → 결과 = "데스유닛"
--   좌표 줄   : 조건에 "xy, 주소X, 주소Y" → 결과 = "데스X, 데스Y"
--   마우스 줄 : 조건에 "mouse" → 결과 = "데스X, 데스Y" 또는 로케이션 번호 하나
-- TEP 는 정의 안 된 전역을 읽으면 에러를 낸다 → loadstring(5.1) 은 rawget 으로 찾는다
local LoadStr = rawget(_G, "loadstring") or load
local function Trim(s) return (string.gsub(s, "^%s*(.-)%s*$", "%1")) end
local function SplitTop(s, sep)
	local out, depth, cur, q = {}, 0, {}, nil
	for i = 1, #s do
		local ch = string.sub(s, i, i)
		if q then
			if ch == q then q = nil end
			table.insert(cur, ch)
		elseif ch == '"' or ch == "'" then
			q = ch
			table.insert(cur, ch)
		elseif ch == "(" then depth = depth + 1 table.insert(cur, ch)
		elseif ch == ")" then depth = depth - 1 table.insert(cur, ch)
		elseif ch == sep and depth == 0 then
			table.insert(out, table.concat(cur)) cur = {}
		else
			table.insert(cur, ch)
		end
	end
	table.insert(out, table.concat(cur))
	return out
end
local function ParseNum(s)
	s = Trim(s)
	local n = tonumber(s)
	if n == nil then
		local ok, u = pcall(ParseUnit, s)
		if ok and type(u) == "number" then return u end
		PushErrorMsg("SNQC_Line: 숫자(또는 유닛 이름)가 아님 - " .. s)
	end
	return n
end
function SNQC_Line(Str)
	-- 결과와 조건을 가르는 마지막 '=' 또는 ':' (괄호·따옴표 밖)
	local pos, depth, q = nil, 0, nil
	for i = 1, #Str do
		local ch = string.sub(Str, i, i)
		if q then
			if ch == q then q = nil end
		elseif ch == '"' or ch == "'" then q = ch
		elseif ch == "(" then depth = depth + 1
		elseif ch == ")" then depth = depth - 1
		elseif (ch == "=" or ch == ":") and depth == 0 then pos = i
		end
	end
	if pos == nil then PushErrorMsg("SNQC_Line: '=' 또는 ':' 가 없음 - " .. Str) return end
	local Left, Right = string.sub(Str, 1, pos - 1), Trim(string.sub(Str, pos + 1))
	local Conds, Kind, Src = {}, "Key", nil
	for _, c in ipairs(SplitTop(Left, ";")) do
		c = Trim(c)
		local parts = SplitTop(c, ",")
		local head = string.lower(Trim(parts[1]))
		if c == "" then
		elseif head == "val" then
			Kind, Src = "Value", ParseNum(parts[2])
		elseif head == "xy" then
			Kind, Src = "Point", {ParseNum(parts[2]), ParseNum(parts[3])}
		elseif head == "mouse" or c == "마우스" then
			Kind = "Mouse"
		else
			table.insert(Conds, c)
		end
	end
	local R = SplitTop(Right, ",")
	if Kind == "Key" then
		return SNQC_Key(Conds, ParseNum(R[1]), R[2] and ParseNum(R[2]) or 1)
	elseif Kind == "Value" then
		return SNQC_Value(Conds, Src, ParseNum(R[1]))
	elseif Kind == "Point" then
		if Src[2] == nil or R[2] == nil then PushErrorMsg("SNQC_Line: xy 줄은 주소 두 개와 데스 두 개가 필요 - " .. Str) end
		return SNQC_Point(Conds, Src[1], Src[2], ParseNum(R[1]), ParseNum(R[2]))
	else
		if R[2] ~= nil then
			return SNQC_Mouse(Conds, ParseNum(R[1]), ParseNum(R[2]))
		end
		return SNQC_Mouse(Conds, nil, nil, {Loc = ParseNum(R[1])})
	end
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 비트 배치 (맵 크기로 정한다)
-- ─────────────────────────────────────────────────────────────────────────────
-- 정수 거듭제곱 (Lua 5.3 에서 2^n 은 실수가 되어 액션 값으로 넘기면 안 된다)
local function Pow2(n)
	local r = 1
	for _ = 1, n do r = r * 2 end
	return r
end

local function FloorLog2(n)
	local b = 0
	while Pow2(b + 1) <= n do b = b + 1 end
	return b
end

-- 키 이름 (MSQC.py / CtrigAsm ParseKeyName 과 같은 표). 문자열 조건이 "키 이름 하나" 인지 가릴 때 쓴다.
local SNQC_KeyNameSet = {}
for name in string.gmatch([[
LBUTTON RBUTTON CANCEL MBUTTON XBUTTON1 XBUTTON2 BACK TAB CLEAR ENTER NX5 SHIFT LCTRL LALT PAUSE CAPSLOCK RALT JUNJA
FINAL RCTRL ESC CONVERT NONCONVERT ACCEPT MODECHANGE SPACE PGUP PGDN END HOME LEFT UP RIGHT DOWN SELECT PRINTSCREEN
EXECUTE SNAPSHOT INSERT DELETE HELP 0 1 2 3 4 5 6 7 8 9 A B C D E F G H I J K L M N O P Q R S T U V W X Y Z LWIN RWIN
APPS SLEEP NUMPAD0 NUMPAD1 NUMPAD2 NUMPAD3 NUMPAD4 NUMPAD5 NUMPAD6 NUMPAD7 NUMPAD8 NUMPAD9 NUMPAD* NUMPAD+ SEPARATOR
NUMPAD- NUMPAD. NUMPAD/ F1 F2 F3 F4 F5 F6 F7 F8 F9 F10 F11 F12 F13 F14 F15 F16 F17 F18 F19 F20 F21 F22 F23 F24
NUMLOCK SCROLL LSHIFT RSHIFT LCONTROL RCONTROL LMENU RMENU SEMICOLON = , - . / ` [ | ] '
]], "%S+") do SNQC_KeyNameSet[name] = true end

-- 키 줄: x 에 KX 비트(값 0 ~ 2^KX-1 ≤ 맵폭-1), y 에 KY 비트. 비트가 하나라도 서면 (0,0) 이 아니므로 기준값과 안 겹친다.
-- 값 줄: x = (값의 아래 VX 비트) + 1 ≤ 2^VX ≤ 맵폭-1, y = 위 VY 비트 ≤ 맵높이-1.
local function Layout()
	local W, H = SNQC_Cfg.MapTiles[1] * 32, SNQC_Cfg.MapTiles[2] * 32
	local L = {W = W, H = H, KX = FloorLog2(W), KY = FloorLog2(H), VX = FloorLog2(W - 1), VY = FloorLog2(H)}
	if L.KY > 15 or L.VY > 15 then PushErrorMsg("SNQC: 맵이 너무 크다") end
	L.KeyBits = {}
	for b = 0, L.KX - 1 do table.insert(L.KeyBits, Pow2(b)) end
	for b = 0, L.KY - 1 do table.insert(L.KeyBits, Pow2(16 + b)) end
	return L
end

function SNQC_ValueMax()
	if SNQC_Cfg.MapTiles == nil then return nil end
	local L = Layout()
	return Pow2(L.VX + L.VY) - 1
end

-- ─────────────────────────────────────────────────────────────────────────────
-- 설치
-- ─────────────────────────────────────────────────────────────────────────────
function SNQC_Install()
	local Cfg = SNQC_Cfg
	if SNQC_Installed then PushErrorMsg("SNQC_Install 은 한 번만 부른다") return end
	SNQC_Installed = true
	if type(Cfg.MapTiles) ~= "table" or type(Cfg.Humans) ~= "table" or #Cfg.Humans == 0 then
		PushErrorMsg("SNQC_Config: MapTiles = {가로, 세로} 와 Humans = {플레이어 번호...} 가 필요하다")
		return
	end
	if #SNQC_Lines == 0 then PushErrorMsg("SNQC: 줄이 하나도 없다") return end
	local LY = Layout()
	local Unit, QCPlayer, Loc = Cfg.Unit, Cfg.Player, Cfg.Loc
	local LocAddr = 0x58DC60 + 20 * Loc

	local function V(n) return n[2] end -- CtrigAsm 변수의 번호 칸
	local function VEq(Var, n, Mask) return CVar(FP, Var[2], Exactly, n, Mask) end
	local function VGe(Var, n) return CVar(FP, Var[2], AtLeast, n) end
	local function VLe(Var, n) return CVar(FP, Var[2], AtMost, n) end

	-- ── 채널 나누기 ───────────────────────────────────────────────────────────
	local Channels = {}
	local KeyGroup = nil
	local KeyDeaths, ValueDeaths, Seen = {}, {}, {}
	for _, Ln in ipairs(SNQC_Lines) do
		if Ln.Kind == "Key" then
			if KeyGroup == nil or #KeyGroup.Lines >= #LY.KeyBits then
				KeyGroup = {Kind = "Key", Lines = {}}
				table.insert(Channels, KeyGroup)
			end
			Ln.Bit = LY.KeyBits[#KeyGroup.Lines + 1]
			table.insert(KeyGroup.Lines, Ln)
			if not Seen[Ln.Death] then Seen[Ln.Death] = true table.insert(KeyDeaths, Ln.Death) end
		else
			table.insert(Channels, {Kind = Ln.Kind, Line = Ln})
		end
	end
	if #Channels > SNQC_MaxChannels then PushErrorMsg("SNQC: 채널이 너무 많다 (" .. #Channels .. ")") end

	-- ── 변수 ─────────────────────────────────────────────────────────────────
	local EdgeKey, EdgeMouse = {}, {}
	local function ResolveConds(List)
		local Out = {}
		local function Push(c)
			if type(c) == "string" then
				local s = Trim(c)
				local up = string.upper(s)
				local inner = string.match(s, "^%a+%((.-)%)$")
				local fname = string.match(s, "^(%a+)%(")
				if string.lower(s) == "nottyping" then Push(SNQC_NotTyping())
				elseif fname == "KeyDown" then Push(SNQC_KeyDown(Trim(inner)))
				elseif fname == "KeyUp" then Push(SNQC_KeyUp(Trim(inner)))
				elseif fname == "KeyPress" then Push(SNQC_KeyPress(Trim(inner)))
				elseif fname == "MouseDown" then Push(SNQC_MouseDown(Trim(inner)))
				elseif fname == "MouseUp" then Push(SNQC_MouseUp(Trim(inner)))
				elseif fname == "MousePress" then Push(SNQC_MousePress(Trim(inner)))
				elseif string.match(s, "^0[xX]%x+") then
					local p = SplitTop(s, ",")
					if p[3] ~= nil then
						local ok, cmp = pcall(LoadStr("return " .. Trim(p[2])))
						table.insert(Out, Memory(tonumber(Trim(p[1])), cmp, tonumber(Trim(p[3]))))
					else
						local val = tonumber(Trim(p[2]))
						table.insert(Out, MemoryX(tonumber(Trim(p[1])), Exactly, val, val))
					end
				elseif SNQC_KeyNameSet[up] then
					Push(SNQC_KeyDown(up))
				else
					local f, err = LoadStr("return " .. s)
					if f == nil then PushErrorMsg("SNQC: 조건을 못 읽음 - " .. s .. " (" .. tostring(err) .. ")") return end
					table.insert(Out, f())
				end
			elseif type(c) == "table" and c.SNQC ~= nil then
				local K, A = c.SNQC, c.Arg
				if K == "NotTyping" then
					table.insert(Out, Memory(0x68C144, Exactly, 0))
				elseif K == "KeyPress" then
					table.insert(Out, KeyPress(A, "Down"))
				elseif K == "KeyDown" or K == "KeyUp" then
					EdgeKey[A] = EdgeKey[A] or CreateVar(FP)
					table.insert(Out, KeyPress(A, K == "KeyDown" and "Down" or "Up"))
					table.insert(Out, VEq(EdgeKey[A], K == "KeyDown" and 0 or 1))
				elseif K == "MousePress" then
					table.insert(Out, MousePress(A, "Down"))
				elseif K == "MouseDown" or K == "MouseUp" then
					EdgeMouse[A] = EdgeMouse[A] or CreateVar(FP)
					table.insert(Out, MousePress(A, K == "MouseDown" and "Down" or "Up"))
					table.insert(Out, VEq(EdgeMouse[A], K == "MouseDown" and 0 or 1))
				end
			else
				table.insert(Out, c)
			end
		end
		for _, c in ipairs(List or {}) do Push(c) end
		return Out
	end
	for _, Ch in ipairs(Channels) do
		if Ch.Kind == "Key" then
			for _, Ln in ipairs(Ch.Lines) do Ln.Resolved = ResolveConds(Ln.Conds) end
		else
			Ch.Line.Resolved = ResolveConds(Ch.Line.Conds)
		end
	end

	-- 공유
	local InitDone = CreateVar(FP)
	local CheckTimer = CreateVar(FP)
	local ChEpd, ChAlpha = {}, {}
	for _, p in ipairs(Cfg.Humans) do
		ChEpd[p], ChAlpha[p] = {}, {}
		for c = 1, #Channels do ChEpd[p][c], ChAlpha[p][c] = CreateVars(2, FP) end
	end
	local NewPtr, NewEpd, Typ, Own, R, X, Y = CreateVars(7, FP)
	local LocSave = {CreateVars(4, FP)}
	-- 로컬
	local MyValid = CreateVar(FP)
	local MyAlpha, MyHdr, MyHdr2, PendOff, PendLen, LastSent = {}, {}, {}, {}, {}, {}
	for c = 1, #Channels do MyAlpha[c], MyHdr[c], MyHdr2[c], PendOff[c], PendLen[c], LastSent[c] = CreateVars(6, FP) end
	local LastAlpha = CreateVar(FP)
	local C, Send, Len, P, D, T, W, Appended, Old, SX, SY = CreateVars(11, FP)
	local SelN = CreateVar(FP)
	local SelEpd, SelAlpha = {}, {}
	for i = 1, 12 do SelEpd[i], SelAlpha[i] = CreateVars(2, FP) end
	local LastMX, LastMY = CreateVars(2, FP)
	-- 패킷 조립 자리 (CtrigAsm 빈 공간)
	--   PB+3 부터 15바이트: 09 01 A A | 15 x x y y | 00 00 E4 00 | OO 00   → PB+8 이 좌표 dword 에 맞는다
	--   RB+2 부터: 09 n id id ... (선택 되돌리기) 또는 0B 01 A A (채널 선택 풀기)
	local PB = Cfg.WorkAddr or CreateVoids(13)
	local RB, TB = PB + 20, PB + 48

	-- ── ① units.dat 패치 (공유, 처음 한 번) ─────────────────────────────────────
	local function ByteX(Base, Idx, Val)
		local off = Idx % 4
		return SetMemoryX(Base + Idx - off, SetTo, Val * 256 ^ off, 0xFF * 256 ^ off)
	end
	CIfOnce(FP, nil, {
		SetMemory(0x662860 + Unit * 4, SetTo, Cfg.BuildSize[1] + Cfg.BuildSize[2] * 65536), -- 건설크기 → 가려짐
		SetMemory(0x6617C8 + Unit * 8, SetTo, 0x10001),                                    -- 유닛 크기 1,1,1,1
		SetMemory(0x6617CC + Unit * 8, SetTo, 0x10001),
		ByteX(0x663238, Unit, 0),                                                           -- 시야 0
		ByteX(0x662DB8, Unit, 0),                                                           -- 탐색 범위 0
		ByteX(0x6637A0, Unit, 0),                                                           -- 그룹 플래그 0 (트리거의 Buildings/Men 에 안 잡히게)
		ByteX(0x6646C8, Unit, 0),                                                           -- 서플라이 공급 0
		SetMemoryX(0x664080 + Unit * 4, SetTo, 0, 0x1000),                                  -- 자원 반환 건물 끄기 (일꾼이 여기로 안 오게)
		SetMemory(PB, SetTo, 0x09000000),
		SetMemory(PB + 12, SetTo, 0x00E40000),
		SetMemory(PB + 16, SetTo, Cfg.Order),
		SetMemory(RB, SetTo, 0),
		SetCVar(FP, InitDone[2], SetTo, 1),
	})
	CIfEnd()

	-- ── ① 채널 건물 만들기 / 다시 만들기 (공유) ─────────────────────────────────
	local function Snap(v, s)
		local half = math.floor(s / 2)
		return math.floor((v - half) / 32) * 32 + half
	end
	for pi, p in ipairs(Cfg.Humans) do
		local NotExist = Memory(0x51A280 + p * 12 + 8, Exactly, 0xFFFFFFFF - (0x51A280 + p * 12 + 4))
		for c = 1, #Channels do
			local px = Cfg.XY[1] + Cfg.Step[1] * (c - 1)
			local py = Cfg.XY[2] + Cfg.Step[2] * (pi - 1)
			if px >= LY.W or py >= LY.H then PushErrorMsg("SNQC: 채널 건물 자리가 맵 밖 (XY/Step 을 줄일 것)") end
			local sx, sy = Snap(px, Cfg.BuildSize[1]), Snap(py, Cfg.BuildSize[2])
			CIf(FP, {VEq(InitDone, 1), VEq(ChEpd[p][c], 0), Memory(0x628438, AtLeast, 1)})
			CIfX(FP, {NotExist})
			CElseX()
				for i = 1, 4 do CRead(FP, LocSave[i], LocAddr + 4 * (i - 1)) end
				CDoActions(FP, {
					SetMemory(LocAddr, SetTo, px), SetMemory(LocAddr + 4, SetTo, py),
					SetMemory(LocAddr + 8, SetTo, px), SetMemory(LocAddr + 12, SetTo, py),
				})
				f_Read(FP, 0x628438, NewPtr, NewEpd, 0xFFFFFF)
				CDoActions(FP, {CreateUnit(1, Unit, Loc + 1, p)})
				f_Read(FP, _Add(NewEpd, 25), Typ, nil, 0xFFFF)
				f_Read(FP, _Add(NewEpd, 19), Own, nil, 0xFF)
				CIf(FP, {VEq(Typ, Unit), VEq(Own, p)})
					CDoActions(FP, {
						SetMemory(LocAddr, SetTo, sx - 16), SetMemory(LocAddr + 4, SetTo, sy - 16),
						SetMemory(LocAddr + 8, SetTo, sx + 16), SetMemory(LocAddr + 12, SetTo, sy + 16),
						GiveUnits(1, Unit, p, Loc + 1, QCPlayer),
					})
					CDoActions(FP, {
						TSetMemoryX(_Add(NewEpd, 19), SetTo, p, 0xFF),                  -- 소유자 바이트만 사람으로
						TSetMemoryX(_Add(NewEpd, 55), SetTo, 0x04200000, 0x04200000),   -- 무적 + 충돌 없음
						TSetMemory(_Add(NewEpd, 62), SetTo, 0),                         -- 랠리 칸 = 기준값
					})
					CMov(FP, ChEpd[p][c], NewEpd)
					f_EPDToAlphaID(FP, NewEpd, ChAlpha[p][c])
					CIf(FP, {LocalPlayerID(p)})
						CMov(FP, MyAlpha[c], ChAlpha[p][c])
						CMov(FP, T, ChAlpha[p][c])
						CMul(FP, T, 65536)
						CAdd(FP, MyHdr[c], T, 0x0109)          -- 09 01 A A
						CMov(FP, T, ChAlpha[p][c])
						CMul(FP, T, 256)
						CAdd(FP, MyHdr2[c], T, 0x15000001)     -- 01 A A 15
						CMov(FP, PendLen[c], 0)
						CMov(FP, MyValid, 1)
					CIfEnd()
				CIfEnd()
				for i = 1, 4 do CDoActions(FP, {TSetMemory(LocAddr + 4 * (i - 1), SetTo, LocSave[i])}) end
			CIfXEnd()
			CIfEnd()
		end
	end

	-- 없어진 채널 찾기 (공유)
	if Cfg.Check then
		CAdd(FP, CheckTimer, 1)
		CIf(FP, {VGe(CheckTimer, Cfg.CheckInterval)})
			CMov(FP, CheckTimer, 0)
			for _, p in ipairs(Cfg.Humans) do
				for c = 1, #Channels do
					CIf(FP, {VGe(ChEpd[p][c], 1)})
						f_Read(FP, _Add(ChEpd[p][c], 25), Typ, nil, 0xFFFF)
						f_Read(FP, _Add(ChEpd[p][c], 19), Own, nil, 0xFF)
						CIfX(FP, {VEq(Typ, Unit), VEq(Own, p)})
						CElseX()
							CMov(FP, ChEpd[p][c], 0)
							CIf(FP, {LocalPlayerID(p)})
								CMov(FP, MyValid, 0)
							CIfEnd()
						CIfXEnd()
					CIfEnd()
				end
			end
		CIfEnd()
	end

	-- ── ② 보내기 (로컬) ───────────────────────────────────────────────────────
	-- 좌표 dword(C)를 PB+8 에 두고 패킷을 붙이거나, 버퍼에 남은 자기 패킷의 좌표를 고친다.
	local function Emit(c, IsKey)
		CRead(FP, Len, 0x654AA0)
		local Done = D
		CMov(FP, Done, 0)
		if Cfg.Merge then
			-- 지난 사이클에 붙인 패킷이 아직 버퍼에 있는가: 길이가 그때 이상 + 그 자리에 "09 01 내 채널" 이 그대로
			CiSub(FP, T, Len, PendLen[c])
			CIf(FP, {VGe(PendLen[c], 1), VLe(T, 0x7FFFFFFF)})
				CAdd(FP, P, PendOff[c], 0x654880)
				f_Memcpy(FP, TB, P, 4)
				CRead(FP, W, TB)
				CiSub(FP, T, W, MyHdr[c])
				CIf(FP, {VEq(T, 0)})
					CAdd(FP, P, 5)                      -- 좌표 자리 (09 01 A A 15 | x x y y)
					if IsKey then
						f_Memcpy(FP, TB, P, 4)
						CRead(FP, Old, TB)
						COr(FP, C, Old)                  -- 키: 그 턴에 눌린 것을 모두 남긴다
					end
					CDoActions(FP, {TSetMemory(TB, SetTo, C)})
					f_Memcpy(FP, P, TB, 4)
					CMov(FP, Done, 1)
				CIfEnd()
			CIfEnd()
		end
		CIf(FP, {VEq(Done, 0), VLe(Len, Cfg.BufferLimit)})
			CDoActions(FP, {TSetMemory(PB + 4, SetTo, MyHdr2[c]), TSetMemory(PB + 8, SetTo, C)})
			CAdd(FP, P, Len, 0x654880)
			f_Memcpy(FP, P, PB + 3, 15)
			CMov(FP, PendOff[c], Len)
			CAdd(FP, Len, 15)
			CMov(FP, PendLen[c], Len)
			CDoActions(FP, {TSetMemory(0x654AA0, SetTo, Len)})
			CMov(FP, Appended, 1)
			CMov(FP, LastAlpha, MyAlpha[c])
		CIfEnd()
	end

	-- 값(0 ~ 2^(VX+VY)-1) → 좌표 dword: x = 아래 VX 비트 + 1, y = 위 VY 비트
	local function EncodeValue(Src)
		CAnd(FP, C, Src, Pow2(LY.VX) - 1)
		CAdd(FP, C, 1)
		for b = 0, LY.VY - 1 do
			CIf(FP, {CVar(FP, Src[2], Exactly, Pow2(LY.VX + b), Pow2(LY.VX + b))})
				CAdd(FP, C, Pow2(16 + b))
			CIfEnd()
		end
	end
	-- 맵 좌표 (SX, SY) → 좌표 dword: x + 1 (맨 오른쪽 줄은 그대로), y
	local function EncodePoint()
		CMov(FP, C, SX)
		CIf(FP, {VLe(SX, LY.W - 2)})
			CAdd(FP, C, 1)
		CIfEnd()
		CMov(FP, T, SY)
		CMul(FP, T, 65536)
		CAdd(FP, C, T)
	end
	local function ReadSrc(Out, Src)
		if type(Src) == "number" then CRead(FP, Out, Src) else CMov(FP, Out, Src) end
	end

	CIf(FP, {VEq(MyValid, 1)})
		-- 선택 저장 (0x6284B8 = 내 화면의 선택 유닛 포인터 12칸, 0 이 나오면 끝)
		CMov(FP, SelN, 0)
		for i = 1, 12 do
			CIf(FP, {VEq(SelN, i - 1), Memory(0x6284B8 + 4 * (i - 1), AtLeast, 1)})
				f_Read(FP, 0x6284B8 + 4 * (i - 1), nil, SelEpd[i])
				CMov(FP, SelN, i)
			CIfEnd()
		end
		CMov(FP, Appended, 0)

		for c, Ch in ipairs(Channels) do
			CMov(FP, C, 0)
			CMov(FP, Send, 0)
			if Ch.Kind == "Key" then
				for _, Ln in ipairs(Ch.Lines) do
					CIf(FP, Ln.Resolved)
						CAdd(FP, C, Ln.Bit)
						CMov(FP, Send, 1)
					CIfEnd()
				end
				CIf(FP, {VEq(Send, 1)})
					Emit(c, true)
				CIfEnd()
			elseif Ch.Kind == "Value" then
				local Ln = Ch.Line
				CIf(FP, Ln.Resolved)
					ReadSrc(X, Ln.Src)
					CIf(FP, {VLe(X, Pow2(LY.VX + LY.VY) - 1)}) -- 범위 밖 값은 안 보낸다
						if Ln.Change then
							CiSub(FP, T, X, LastSent[c])
							CIfX(FP, {VEq(T, 0)})
							CElseX()
								CMov(FP, LastSent[c], X)
								EncodeValue(X)
								Emit(c, false)
							CIfXEnd()
						else
							EncodeValue(X)
							Emit(c, false)
						end
					CIfEnd()
				CIfEnd()
			elseif Ch.Kind == "Point" then
				local Ln = Ch.Line
				CIf(FP, Ln.Resolved)
					ReadSrc(SX, Ln.SrcX)
					ReadSrc(SY, Ln.SrcY)
					CIf(FP, {VLe(SX, LY.W - 1), VLe(SY, LY.H - 1)})
						EncodePoint()
						Emit(c, false)
					CIfEnd()
				CIfEnd()
			elseif Ch.Kind == "Mouse" then
				local Ln = Ch.Line
				CIf(FP, Ln.Resolved)
					-- 화면 왼쪽 위(0x62848C, 0x6284A8) + 화면 안 마우스(0x6CDDC4, 0x6CDDC8)
					CRead(FP, SX, 0x62848C)
					CRead(FP, T, 0x6CDDC4)
					CAdd(FP, SX, T)
					CRead(FP, SY, 0x6284A8)
					CRead(FP, T, 0x6CDDC8)
					CAdd(FP, SY, T)
					CiSub(FP, T, SX, LastMX)
					CiSub(FP, W, SY, LastMY)
					CIfX(FP, {VEq(T, 0), VEq(W, 0)})
					CElseX()
						CIf(FP, {VLe(SX, LY.W - 1), VLe(SY, LY.H - 1)})
							CMov(FP, LastMX, SX)
							CMov(FP, LastMY, SY)
							EncodePoint()
							Emit(c, false)
						CIfEnd()
					CIfXEnd()
				CIfEnd()
			end
		end

		-- 선택 되돌리기: 이번 사이클에 새로 붙인 패킷이 있을 때만 (고치기만 했으면 지난번 되돌리기가 이미 뒤에 있다)
		CIf(FP, {VEq(Appended, 1)})
			CRead(FP, Len, 0x654AA0)
			CIf(FP, {VLe(Len, 470)})
				CAdd(FP, P, Len, 0x654880)
				CIfX(FP, {VGe(SelN, 1)})
					CMov(FP, T, SelN)
					CMul(FP, T, 16777216)
					CAdd(FP, T, 0x90000)                      -- xx xx 09 n
					CDoActions(FP, {TSetMemory(RB, SetTo, T)})
					for i = 1, 12 do
						CIf(FP, {VGe(SelN, i)})
							f_EPDToAlphaID(FP, SelEpd[i], SelAlpha[i])
						CIfEnd()
					end
					for k = 0, 5 do
						local i1, i2 = 2 * k + 1, 2 * k + 2
						CIf(FP, {VGe(SelN, i1)})
							CMov(FP, W, SelAlpha[i1])
							CIf(FP, {VGe(SelN, i2)})
								CMov(FP, T, SelAlpha[i2])
								CMul(FP, T, 65536)
								CAdd(FP, W, T)
							CIfEnd()
							CDoActions(FP, {TSetMemory(RB + 4 + 4 * k, SetTo, W)})
						CIfEnd()
					end
					f_Memcpy(FP, P, RB + 2, 26)
					CMov(FP, T, SelN)
					CMul(FP, T, 2)
					CAdd(FP, Len, T)
					CAdd(FP, Len, 2)
				CElseX()
					-- 아무것도 안 고른 상태였다 → 마지막에 고른 채널을 선택에서 뺀다 (0B 01 A A)
					CDoActions(FP, {SetMemory(RB, SetTo, 0x010B0000), TSetMemory(RB + 4, SetTo, LastAlpha)})
					f_Memcpy(FP, P, RB + 2, 4)
					CAdd(FP, Len, 4)
				CIfXEnd()
				CDoActions(FP, {TSetMemory(0x654AA0, SetTo, Len)})
			CIfEnd()
		CIfEnd()
	CIfEnd()

	-- ── ③ 받기 (공유) ──────────────────────────────────────────────────────────
	for _, p in ipairs(Cfg.Humans) do
		-- 키 데스값은 매 사이클 0 에서 시작 (MSQC 와 같다). 값 줄은 Hold 가 아니면 0.
		local Resets = {}
		for _, u in ipairs(KeyDeaths) do table.insert(Resets, SetDeaths(p, SetTo, 0, u)) end
		for _, Ch in ipairs(Channels) do
			local Ln = Ch.Line
			if Ln ~= nil then
				if not Ln.Hold then
					if Ln.Death then table.insert(Resets, SetDeaths(p, SetTo, 0, Ln.Death)) end
					if Ln.DeathX then table.insert(Resets, SetDeaths(p, SetTo, 0, Ln.DeathX)) end
					if Ln.DeathY then table.insert(Resets, SetDeaths(p, SetTo, 0, Ln.DeathY)) end
				end
				if Ln.NewDeath then table.insert(Resets, SetDeaths(p, SetTo, 0, Ln.NewDeath)) end
			end
		end
		if #Resets > 0 then CDoActions(FP, Resets) end

		for c, Ch in ipairs(Channels) do
			local E = ChEpd[p][c]
			CIf(FP, {VGe(E, 1)})
				f_Read(FP, _Add(E, 62), R)
				CIfX(FP, {VEq(R, 0)})
				CElseX()
					if Ch.Kind == "Key" then
						for _, Ln in ipairs(Ch.Lines) do
							CIf(FP, {CVar(FP, R[2], Exactly, Ln.Bit, Ln.Bit)}, {SetDeaths(p, Add, Ln.Add, Ln.Death)})
							CIfEnd()
						end
					else
						local Ln = Ch.Line
						CAnd(FP, X, R, 0xFFFF)
						CSub(FP, X, 1)
						if Ch.Kind == "Value" then
							for b = 0, LY.VY - 1 do
								CIf(FP, {CVar(FP, R[2], Exactly, Pow2(16 + b), Pow2(16 + b))})
									CAdd(FP, X, Pow2(LY.VX + b))
								CIfEnd()
							end
							CDoActions(FP, {TSetDeaths(p, SetTo, X, Ln.Death)})
						else
							CMov(FP, Y, 0)
							for b = 0, 15 do
								CIf(FP, {CVar(FP, R[2], Exactly, Pow2(16 + b), Pow2(16 + b))})
									CAdd(FP, Y, Pow2(b))
								CIfEnd()
							end
							if Ln.DeathX then CDoActions(FP, {TSetDeaths(p, SetTo, X, Ln.DeathX)}) end
							if Ln.DeathY then CDoActions(FP, {TSetDeaths(p, SetTo, Y, Ln.DeathY)}) end
							if Ln.Loc then
								local LA = 0x58DC60 + 20 * (Ln.Loc + p)
								CDoActions(FP, {
									TSetMemory(LA, SetTo, X), TSetMemory(LA + 4, SetTo, Y),
									TSetMemory(LA + 8, SetTo, X), TSetMemory(LA + 12, SetTo, Y),
								})
							end
						end
						if Ln.NewDeath then CDoActions(FP, {SetDeaths(p, SetTo, 1, Ln.NewDeath)}) end
					end
					CDoActions(FP, {TSetMemory(_Add(E, 62), SetTo, 0)})
				CIfXEnd()
			CIfEnd()
		end
	end

	-- ── ④ 눌림 상태 기억 (로컬) ─────────────────────────────────────────────────
	for K, Var in pairs(EdgeKey) do
		CIfX(FP, {KeyPress(K, "Down")}, {SetCVar(FP, Var[2], SetTo, 1)})
		CElseX({SetCVar(FP, Var[2], SetTo, 0)})
		CIfXEnd()
	end
	for B, Var in pairs(EdgeMouse) do
		CIfX(FP, {MousePress(B, "Down")}, {SetCVar(FP, Var[2], SetTo, 1)})
		CElseX({SetCVar(FP, Var[2], SetTo, 0)})
		CIfXEnd()
	end
end
