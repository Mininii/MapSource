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
	    ② (로컬) 줄마다 값 계산 → 턴 버퍼에 "Select 채널 + 오더 40(x,y)" 쓰기 → 선택 되돌리기 (새로 붙였을 때만)
	    ③ (공유) 플레이어마다 채널 랠리 칸 읽기 → 0 이 아니면 풀어서 데스값에 쓰고 칸을 0 으로
	    ④ (로컬) 키·마우스 눌림 상태 기억 (KeyDown/KeyUp 판정용)
	  ★ ②④ 는 각 PC 의 로컬 상태만 쓴다 (턴 버퍼, 이 파일이 만든 변수, 공유 로직이 안 읽는 값).
	    ①③ 은 모든 PC 가 같은 값을 보는 공유 동작이다. 로컬 조건으로 공유 상태를 바꾸면 동기화가 깨진다.
	  ★ 필요한 것: CtrigAsm v5.5 + MapSource/Library/LibraryFor322.lua (SetCall, CallTrigger(X), def_sIndex).
	    Include_CtrigPlib 뒤에서 부를 것 (f_Read 가 요구한다). 반복되는 본체는 SetCall 함수로 두고 펼치는 부분은
	    CTrigger 만 써서 CtrigAsm 인덱스(0xC000~0xEFFF, CIf 하나에 2개)를 거의 안 쓴다 - 16채널 × 7명에서 112개 (MSF_UE_RE 실측).

	■ 받는 쪽 결과 (MSQC 와 같게)
	  키 줄  : 그 플레이어의 Death 에, 이번 사이클에 받은 줄마다 Add 를 더한다. **매 사이클 0 에서 시작**한다.
	  값 줄  : 받은 사이클에 Death = 값. 안 받은 사이클은 0 (Hold = true 면 그대로 둔다).
	           NewDeath 를 주면 받은 사이클에 1, 아니면 0 (MSQC 에 없던 "새 값이 왔는가" 표시).
	  좌표 줄: DeathX / DeathY = 좌표. 마우스 줄은 마우스가 가리키는 맵 좌표를 움직였을 때만 보낸다.

	■ 조건 (줄의 Conds) - 각 PC 에서 평가되는 로컬 조건
	  SNQC_KeyDown(k)  눌린 순간     SNQC_KeyUp(k)  뗀 순간     SNQC_KeyPress(k)  누르고 있는 동안
	  SNQC_MouseDown(b) / SNQC_MouseUp(b) / SNQC_MousePress(b)   b = "L" / "R" / "M"
	  SNQC_NotTyping()  채팅창이 닫혀 있을 때 (0x68C144 == 0)
	  SNQC_MyDeaths(비교, 값, 유닛)  이 PC 플레이어의 데스값 (MSQC 줄의 Deaths(CurrentPlayer, ...) 와 같다)
	  그 밖의 TEP/CtrigAsm 조건은 그대로 넣으면 된다 (예: Switch("Switch 254", Set)). 목록은 평평하게(중첩 없이) 준다.
	  문자열이면 MSQC 문법으로 푼다: "Y"(= KeyDown), "KeyPress(LALT)", "MousePress(L)", "NotTyping",
	  "0x68C144,Exactly,0", "Deaths(CurrentPlayer,AtLeast,1,441)", 그 밖은 Lua 식으로 평가한다 (예: 'Switch("Switch 254",Set)').
	  ★ 보내는 트리거는 FP 소유라 CurrentPlayer 가 이 PC 플레이어가 아니다 - Deaths(CurrentPlayer, ...) 를 표로 직접 넣지 말 것.
	    문자열 "Deaths(CurrentPlayer, ...)" 는 SNQC_MyDeaths 로 바꿔 읽고, 그 밖에 CurrentPlayer 가 든 문자열 조건은 에러로 멈춘다.

	⚠ 버전 기록: CHANGELOG.md (같은 폴더). 1.2 는 MSF_UE_RE 인게임 시험에서 나온 유닛 ID 문제를 고친 판. 인게임 재확인 전.
	  (같은 설계의 플러그인 판 SNQC.py 는 theSeed 인게임 통과.) 확인할 것은 DESIGN.md "확인 목록".
]]

SNQC_Version = "1.2"

-- ─────────────────────────────────────────────────────────────────────────────
-- 설정
-- ─────────────────────────────────────────────────────────────────────────────
SNQC_DefaultConfig = {
	Unit          = 106,        -- 채널 건물. 랠리를 받는 12종(CC·배럭·팩토리·스타포트·인페스티드CC·해처리·레어·하이브·넥서스·게이트웨이·
	                            -- 스타게이트·로보틱스) 중 **맵에서 안 쓰는 종류**여야 한다 - 아래 units.dat 패치가 종류 전체에 걸린다
	Player        = 10,         -- 채널 건물을 넘겨 둘 플레이어 (0부터, 10 = P11). 사람의 유닛 수에 안 잡히게 (MSQC 의 QCPlayer)
	Loc           = 0,          -- 만들 때 잠깐 옮겨 쓰는 로케이션 (0부터). 쓰고 나면 원래 자리로 되돌린다
	XY            = {128, 128}, -- 첫 채널 건물 자리 (픽셀). PlayerXY 가 없을 때 플레이어마다 y 로 Step[2] 씩 내려간다
	Step          = {32, 32},   -- 채널 사이 간격 (x = 같은 줄, y = 다음 줄 / 다음 플레이어). 32 보다 줄이지 말 것 -
	                            -- 만든 건물을 P11 로 넘길 때 ±16 상자로 고르므로 옆 채널이 상자에 들어오면 엉뚱한 건물을 넘긴다
	PlayerXY      = nil,        -- 1.2: 플레이어별 첫 채널 자리 {[플레이어 번호] = {x, y}, ...}. 주면 XY 대신 쓴다 (예: 각자 배럭 밑)
	Columns       = nil,        -- 1.2: 한 줄에 놓을 채널 수 (기본 = 채널 수, 한 줄). 4 면 4열로 접어 쌓는다
	BuildSize     = {1, 0},     -- 건설크기(픽셀). (1,0)/(0,1)/(0,0) 이 가려진다 (실측)
	Order         = 40,         -- Rally to Ground Tile
	Merge         = true,       -- 아직 안 나간 자기 패킷이 버퍼에 있으면 새로 붙이지 않고 그 좌표를 고친다 (키 = 비트 합치기, 값 = 덮어쓰기)
	BufferLimit   = 400,        -- 턴 버퍼 길이가 이보다 크면 붙이지 않는다 (상한 0x57F0D8 = 496, Sync 7 + 선택 되돌리기 26 여유)
	Check         = true,       -- 채널 건물이 없어졌는지 CheckInterval 사이클마다 보고 없어졌으면 다시 만든다
	CheckInterval = 34,
	DebugAddr     = nil,        -- 시험용: 주면 매 사이클 이 PC 의 채널 상태를 여기 복사한다 (16 + 채널 수 × 12 dword, 로컬 메모리).
	                            -- 외부 리더(MSF_UE_RE/tools/snqc_probe.py)가 읽는다. 맵 로직은 이 칸을 읽으면 안 된다
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
	Merge = true, BufferLimit = true, Check = true, CheckInterval = true, WorkAddr = true, DebugAddr = true,
	PlayerXY = true, Columns = true, MapTiles = true, Humans = true}

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
-- 이 PC 플레이어의 데스값 비교. Type = Exactly/AtLeast/AtMost, Unit = 번호 (228 이상 EUD 데스도 된다)
function SNQC_MyDeaths(Type, Value, Unit) return Desc("MyDeaths", {Type = Type, Value = Value, Unit = Unit}) end

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
-- MSQC mouse 줄의 로케이션: 이름(GetLocationIndex) 또는 번호. 둘 다 **1부터** 센다 (편집기의 "Location 1" = 1).
-- SNQC_Mouse 의 Opt.Loc 는 0부터라 1 을 뺀다.
local function ParseLoc1(s)
	s = Trim(s)
	local n = tonumber(s)
	if n == nil then
		local ok, r = pcall(ParseLocation, s)
		if ok and type(r) == "number" and r >= 1 then n = r end
	end
	if n == nil then PushErrorMsg("SNQC_Line: 로케이션이 아님 - " .. s) return nil end
	return n - 1
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
		return SNQC_Mouse(Conds, nil, nil, {Loc = ParseLoc1(R[1])})
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

	local function VEq(Var, n, Mask) return CVar(FP, Var[2], Exactly, n, Mask) end
	local function VGe(Var, n) return CVar(FP, Var[2], AtLeast, n) end
	local function VLe(Var, n) return CVar(FP, Var[2], AtMost, n) end
	local function Bit(Var, b) return CVar(FP, Var[2], Exactly, b, b) end
	local function Set(Var, Type, n) return SetCVar(FP, Var[2], Type, n) end
	-- 조건이 참일 때만 하는 액션 한 트리거. CIf 와 달리 CtrigAsm 인덱스(0xC000~0xEFFF)를 안 쓴다. T 액션도 된다.
	-- ★ 1.1: 1.0 은 (플레이어 × 채널 × 비트)마다 CIf 를 펼쳐 MSF_UE_RE(16채널 × 7명)에서 인덱스를 6990개 썼다.
	--   반복되는 본체는 아래 SetCall 함수로 한 번만 두고, 펼치는 부분은 이 When / CallTriggerX 만 쓴다.
	local function When(Conds, Acts)
		if #Conds > 15 then PushErrorMsg("SNQC: 한 줄의 조건이 너무 많다 (" .. #Conds .. " > 15)") end
		CTrigger(FP, Conds, Acts, 1)
	end
	local function Concat(A, B)
		local Out = {}
		for _, x in ipairs(A) do table.insert(Out, x) end
		for _, x in ipairs(B) do table.insert(Out, x) end
		return Out
	end

	-- ── 채널 나누기 ───────────────────────────────────────────────────────────
	local Channels = {}
	local KeyGroup = nil
	local KeyDeaths, Seen = {}, {}
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

	-- ── 조건 풀기 ─────────────────────────────────────────────────────────────
	-- 키·마우스 눌림 기억, 내 데스값 사본. 만든 순서대로 트리거를 낸다 (pairs 순서는 실행마다 달라 빌드가 흔들린다)
	local EdgeKey, EdgeMouse, MyDeath = {}, {}, {}
	local EdgeKeyOrder, EdgeMouseOrder, MyDeathOrder = {}, {}, {}
	local function Edge(Map, Order, K)
		if Map[K] == nil then
			Map[K] = CreateVar(FP)
			table.insert(Order, K)
		end
		return Map[K]
	end
	local function ResolveConds(List)
		local Out = {}
		local function Push(c)
			if type(c) == "string" then
				local s = Trim(c)
				local up = string.upper(s)
				local inner = string.match(s, "^%a+%((.-)%)$")
				local fname = string.match(s, "^(%a+)%(")
				local dargs = fname == "Deaths" and SplitTop(inner, ",") or nil
				if dargs ~= nil and #dargs == 4 and Trim(dargs[1]) == "CurrentPlayer" then
					-- MSQC 는 보내는 쪽 조건을 CurrentPlayer = 이 PC 플레이어로 두고 평가한다 (MSQC.py f_setcurpl(f_getuserplayerid()))
					local okT, Type = pcall(LoadStr("return " .. Trim(dargs[2])))
					local okV, Value = pcall(LoadStr("return " .. Trim(dargs[3])))
					if not (okT and okV) or type(Value) ~= "number" then
						PushErrorMsg("SNQC: Deaths 조건을 못 읽음 - " .. s)
						return
					end
					Push(SNQC_MyDeaths(Type, Value, ParseNum(dargs[4])))
				elseif string.find(s, "CurrentPlayer", 1, true) then
					PushErrorMsg("SNQC: 보내는 쪽 조건에 CurrentPlayer 는 Deaths(CurrentPlayer, 비교, 값, 유닛) 만 된다 - " .. s)
				elseif string.lower(s) == "nottyping" then Push(SNQC_NotTyping())
				elseif fname == "KeyDown" then Push(SNQC_KeyDown(Trim(inner)))
				elseif fname == "KeyUp" then Push(SNQC_KeyUp(Trim(inner)))
				elseif fname == "KeyPress" then Push(SNQC_KeyPress(Trim(inner)))
				elseif fname == "MouseDown" then Push(SNQC_MouseDown(Trim(inner)))
				elseif fname == "MouseUp" then Push(SNQC_MouseUp(Trim(inner)))
				elseif fname == "MousePress" then Push(SNQC_MousePress(Trim(inner)))
				elseif string.match(s, "^0[xX]%x+") then
					local p = SplitTop(s, ",")
					if p[3] ~= nil then
						local _, cmp = pcall(LoadStr("return " .. Trim(p[2])))
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
					local E = Edge(EdgeKey, EdgeKeyOrder, A)
					table.insert(Out, KeyPress(A, K == "KeyDown" and "Down" or "Up"))
					table.insert(Out, VEq(E, K == "KeyDown" and 0 or 1))
				elseif K == "MousePress" then
					table.insert(Out, MousePress(A, "Down"))
				elseif K == "MouseDown" or K == "MouseUp" then
					local E = Edge(EdgeMouse, EdgeMouseOrder, A)
					table.insert(Out, MousePress(A, K == "MouseDown" and "Down" or "Up"))
					table.insert(Out, VEq(E, K == "MouseDown" and 0 or 1))
				elseif K == "MyDeaths" then
					local M = Edge(MyDeath, MyDeathOrder, A.Unit)
					table.insert(Out, CVar(FP, M[2], A.Type, A.Value))
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

	-- ── 변수 ─────────────────────────────────────────────────────────────────
	-- 공유: 채널 건물 EPD 와 그 건물로 보내는 패킷 머리 "01 A A 15" (A = 알파 ID). 머리는 만들 때 한 번 계산한다.
	local InitDone, CheckTimer = CreateVars(2, FP)
	local ChEpd, ChHdr2 = {}, {}
	for _, p in ipairs(Cfg.Humans) do
		ChEpd[p], ChHdr2[p] = {}, {}
		for c = 1, #Channels do ChEpd[p][c], ChHdr2[p][c] = CreateVars(2, FP) end
	end
	-- 공유 함수의 인자·결과·임시
	local CrP, CrPX, CrPY, CrL, CrT, CrR, CrB, CrDone, CrEpd, CrHdr2, CrOK = CreateVars(11, FP)
	local NewPtr, NewEpd, NewPtr2, Typ, OwnOrd, Own, ST = CreateVars(7, FP)
	local LocSave = {CreateVars(5, FP)}   -- 로케이션 20바이트 (좌표 4칸 + 이름·고도 플래그 칸)
	local ChkEpd, ChkP, ChkOK = CreateVars(3, FP)
	local RvEpd, R, X, Y, V = CreateVars(5, FP)
	local AEpd, AOut, AGen = CreateVars(3, FP)
	local CpD, CpS, CpN, CpRD, CpRS = CreateVars(5, FP)   -- SNQC_Copy 인자: 대상·원본 주소(끝나면 EPD), 길이, 정렬
	-- 로컬
	local MyValid, MyPlayer = CreateVars(2, FP)
	local MyHdr2, PendOff, PendLen, LastSent = {}, {}, {}, {}
	for c = 1, #Channels do MyHdr2[c], PendOff[c], PendLen[c], LastSent[c] = CreateVars(4, FP) end
	local C, Send, Len, P, D, T, W, Old, SX, SY = CreateVars(10, FP)
	local EmHdr, EmHdr2, EmOff, EmLen, EmKey, Appended, LastHdr = CreateVars(7, FP)
	local EmRes = CreateVar(FP)   -- 이번 Emit 결과: 0 안 함, 1 새로 붙임, 2 고침(합치기)
	local DA = Cfg.DebugAddr
	local DbgMagic = {0x514E5344, 0x55424544, 0x31303047, 0x7F4A7C15, 0x2545F491, 0x9E3779B9, 0x85EBCA6B, 0xC2B2AE35}
	local function DSlot(c, k) return DA + (16 + (c - 1) * 12 + k) * 4 end
	local DbgT = CreateVar(FP)
	local SelN = CreateVar(FP)
	local SelAlpha = {}
	for i = 1, 12 do SelAlpha[i] = CreateVar(FP) end
	local LastMX, LastMY = CreateVars(2, FP)
	-- 패킷 조립 자리 (CtrigAsm 빈 공간)
	--   PB+3 부터 15바이트: 09 01 A A | 15 x x y y | 00 00 E4 00 | OO 00   → PB+8 이 좌표 dword 에 맞는다
	--   RB+2 부터: 09 n id id ... (선택 되돌리기) 또는 0B 01 A A (채널 선택 풀기)
	local PB = Cfg.WorkAddr or CreateVoids(13)
	local RB, TB = PB + 20, PB + 48

	-- ── 함수 (SetCall - MapSource/Library/LibraryFor322.lua). 한 번만 두고 불러 쓴다 ─────────────────────
	local FuncSkip = def_sIndex()
	CJump(FP, FuncSkip)

	-- (로컬) 바이트 복사: CpS 주소에서 CpD 주소로 CpN 바이트. CtrigAsm f_Memcpy 를 고쳐 쓴 것.
	-- ★ 1.2: f_Memcpy 는 "대상 4의 배수 / 원본 4로 나눠 2·3 남음" 경로의 끝자투리 마스크에 오타가 있어
	--   (0x00FFFF000, 0x0000FF000, 0x00FF00000) 15바이트 패킷의 끝 3바이트(오더 0x28)가 깨졌다 → 한 턴의 4·8번째 패킷이 사라짐.
	--   여기서는 같은 방식(4바이트씩 + 자투리)을 정렬 16가지 경우마다 **계산으로** 만든다: 원본 바이트 위치 ps, 대상 위치 pd 에서
	--   k 바이트 = _ReadFX(원본, 마스크(k, ps), 256^(pd-ps)) 를 대상 마스크(k, pd) 로. 손으로 쓴 마스크 표가 없다.
	local Call_Copy = SetCallForward()
	SetCall(FP)
		CMod(FP, CpRD, CpD, 4)
		CDiv(FP, CpD, 4)
		CiSub(FP, CpD, 1452249)                                                -- 주소 → EPD (0x58A364 / 4)
		CMod(FP, CpRS, CpS, 4)
		CDiv(FP, CpS, 4)
		CiSub(FP, CpS, 1452249)
		local function Mask(k, pos) return (Pow2(8 * k) - 1) * Pow2(8 * pos) end
		local function Mul(ps, pd)
			if pd >= ps then return Pow2(8 * (pd - ps)) end
			return 1 / Pow2(8 * (ps - pd))
		end
		-- n 바이트를 옮기는 트리거들 (대상·원본 dword 를 넘을 때마다 EPD +1). 조건 Conds 가 있으면 매 단계에 붙인다.
		local function Steps(rd, rs, n, Conds)
			local pd, ps = rd, rs
			while n > 0 do
				local k = math.min(4 - pd, 4 - ps, n)
				CTrigger(FP, Conds, {TSetMemoryX(CpD, SetTo, _ReadFX(CpS, Mask(k, ps), Mul(ps, pd)), Mask(k, pd))}, 1)
				pd, ps, n = pd + k, ps + k, n - k
				local Adv = {}
				if pd == 4 then pd = 0 table.insert(Adv, Set(CpD, Add, 1)) end
				if ps == 4 then ps = 0 table.insert(Adv, Set(CpS, Add, 1)) end
				if #Adv > 0 then CTrigger(FP, Conds, Adv, 1) end
			end
		end
		for rd = 0, 3 do
			for rs = 0, 3 do
				CIf(FP, {VEq(CpRD, rd), VEq(CpRS, rs)})
					CWhile(FP, {VGe(CpN, 4)}, {Set(CpN, Subtract, 4)})
						Steps(rd, rs, 4, {})
					CWhileEnd()
					for t = 1, 3 do Steps(rd, rs, t, {VEq(CpN, t)}) end
				CIfEnd()
			end
		end
	SetCallEnd()

	local function Copy(Dst, Src, N)
		local Acts = {Set(CpN, SetTo, N)}
		if type(Dst) == "number" then table.insert(Acts, Set(CpD, SetTo, Dst)) else CMov(FP, CpD, Dst) end
		if type(Src) == "number" then table.insert(Acts, Set(CpS, SetTo, Src)) else CMov(FP, CpS, Src) end
		CallTrigger(FP, Call_Copy, Acts)
	end

	-- 유닛 EPD(AEpd) → 턴 버퍼에 쓰는 16비트 유닛 ID(AOut) = 인덱스 + 1 + (세대 mod 32) × 2048.
	-- ★ 1.2: CtrigAsm 의 f_EPDToAlphaID 는 세대 바이트(+0xA5) 전체에 2048 을 곱해서 세대가 32 이상이면 16비트를 넘는다.
	--   게임은 세대를 32 로 나눈 나머지로 비교하고(OpenBW get_unit), 넘친 비트는 패킷 머리 "01 A A 15" 의
	--   0x15(명령 바이트)를 바꿔 그 채널 명령과 같은 턴의 뒤 명령을 깨뜨렸다 (MSF_UE_RE 에서 SCR_DB 불러오기가 멈춤).
	--   플러그인 판·MSQC 는 세대를 0 으로 고정해서 이 일이 없었다. 여기서는 세대를 건드리지 않고 나머지만 쓴다.
	local Call_Alpha = SetCallForward()
	SetCall(FP)
		CSub(FP, AOut, AEpd, 19025)                                           -- EPD(0x59CCA8) = 19025, 유닛 하나 = 84
		CDiv(FP, AOut, 84)
		CAdd(FP, AOut, 1)
		f_Read(FP, _Add(AEpd, 41), AGen, nil, 0x1F00)                         -- +0xA5 세대의 아래 5비트 (<< 8)
		CMul(FP, AGen, 8)
		CAdd(FP, AOut, AGen)
	SetCallEnd()

	-- (공유) 채널 건물 하나 만들기. 인자 CrP, 만들 점 CrPX/CrPY, 넘길 때 상자 CrL/CrT/CrR/CrB.
	-- 결과 CrEpd / CrHdr2 (실패하면 0). 부르는 쪽이 CrDone = 1 로 둔다.
	local Call_Create = SetCallForward()
	SetCall(FP)
		CMov(FP, CrEpd, 0)
		CMov(FP, CrHdr2, 0)
		for i = 1, 5 do CRead(FP, LocSave[i], LocAddr + 4 * (i - 1)) end
		CDoActions(FP, {
			TSetMemory(LocAddr, SetTo, CrPX), TSetMemory(LocAddr + 4, SetTo, CrPY),
			TSetMemory(LocAddr + 8, SetTo, CrPX), TSetMemory(LocAddr + 12, SetTo, CrPY),
			SetMemoryX(LocAddr + 16, SetTo, 0, 0xFFFF0000),                 -- 고도 플래그 끄기 (SNQC.py·MSQC 와 같다)
		})
		f_Read(FP, 0x628438, NewPtr, NewEpd, 0xFFFFFF)
		CDoActions(FP, {TCreateUnit(1, Unit, Loc + 1, CrP)})
		-- 성공 = 빈 유닛 포인터가 움직였고, 그 자리 유닛이 이 종류·이 플레이어 (1.0 은 포인터를 안 봐서 실패해도 옛 유닛을 잡을 수 있었다)
		f_Read(FP, 0x628438, NewPtr2, nil, 0xFFFFFF)
		f_Read(FP, _Add(NewEpd, 25), Typ, nil, 0xFFFF)
		f_Read(FP, _Add(NewEpd, 19), Own, nil, 0xFF)
		CiSub(FP, ST, Own, CrP)
		CMov(FP, CrOK, 0)
		When({VEq(Typ, Unit), VEq(ST, 0)}, {Set(CrOK, SetTo, 1)})
		CiSub(FP, ST, NewPtr2, NewPtr)
		When({VEq(ST, 0)}, {Set(CrOK, SetTo, 0)})
		CIf(FP, {VEq(CrOK, 1)})
			CDoActions(FP, {
				TSetMemory(LocAddr, SetTo, CrL), TSetMemory(LocAddr + 4, SetTo, CrT),
				TSetMemory(LocAddr + 8, SetTo, CrR), TSetMemory(LocAddr + 12, SetTo, CrB),
				TGiveUnits(1, Unit, CrP, Loc + 1, QCPlayer),
			})
			CDoActions(FP, {
				TSetMemoryX(_Add(NewEpd, 19), SetTo, CrP, 0xFF),                -- 소유자 바이트만 사람으로
				TSetMemoryX(_Add(NewEpd, 55), SetTo, 0x04200000, 0x04200000),   -- 무적 + 충돌 없음
				TSetMemory(_Add(NewEpd, 62), SetTo, 0),                         -- 랠리 칸 = 기준값
			})
			CMov(FP, CrEpd, NewEpd)
			CMov(FP, AEpd, NewEpd)
			CallTrigger(FP, Call_Alpha, {Set(AOut, SetTo, 0)})
			CMov(FP, ST, AOut)
			CMul(FP, ST, 256)
			CAdd(FP, CrHdr2, ST, 0x15000001)                                  -- 01 A A 15
		CIfEnd()
		for i = 1, 5 do CDoActions(FP, {TSetMemory(LocAddr + 4 * (i - 1), SetTo, LocSave[i])}) end
	SetCallEnd()

	-- (공유) 채널 건물이 살아 있는가. 인자 ChkEpd(0 이면 볼 것 없음), ChkP. 결과 ChkOK
	local Call_Check = SetCallForward()
	SetCall(FP)
		CMov(FP, ChkOK, 1)
		CIf(FP, {VGe(ChkEpd, 1)})
			f_Read(FP, _Add(ChkEpd, 25), Typ, nil, 0xFFFF)
			f_Read(FP, _Add(ChkEpd, 19), OwnOrd, nil, 0xFFFF)                -- +0x4C 주인, +0x4D 오더 (0 = 죽는 중)
			CAnd(FP, Own, OwnOrd, 0xFF)
			CiSub(FP, ST, Own, ChkP)
			CMov(FP, ChkOK, 0)
			When({VEq(Typ, Unit), VEq(ST, 0), VGe(OwnOrd, 256)}, {Set(ChkOK, SetTo, 1)})
		CIfEnd()
	SetCallEnd()

	-- (공유) 채널 랠리 칸 읽기. 인자 RvEpd. 결과 R (0 = 안 받음), 받았으면 X / Y (좌표 줄), V (값 줄) 도.
	local Call_Recv = SetCallForward()
	SetCall(FP)
		CMov(FP, R, 0)
		CIf(FP, {VGe(RvEpd, 1)})
			f_Read(FP, _Add(RvEpd, 62), R)
			CIf(FP, {VGe(R, 1)})
				CDoActions(FP, {TSetMemory(_Add(RvEpd, 62), SetTo, 0)})
				CAnd(FP, X, R, 0xFFFF)
				CSub(FP, X, 1)
				CMov(FP, Y, 0)
				for b = 0, 15 do When({Bit(R, Pow2(16 + b))}, {Set(Y, Add, Pow2(b))}) end
				CMov(FP, V, Y)
				CMul(FP, V, Pow2(LY.VX))
				CAdd(FP, V, X)
			CIfEnd()
		CIfEnd()
	SetCallEnd()

	-- (로컬) 값 SX(0 ~ 2^(VX+VY)-1) → 좌표 dword C: x = 아래 VX 비트 + 1, y = 위 VY 비트
	local Call_EncV = SetCallForward()
	SetCall(FP)
		CAnd(FP, C, SX, Pow2(LY.VX) - 1)
		CAdd(FP, C, 1)
		for b = 0, LY.VY - 1 do When({Bit(SX, Pow2(LY.VX + b))}, {Set(C, Add, Pow2(16 + b))}) end
	SetCallEnd()

	-- (로컬) 맵 좌표 (SX, SY) → C: x + 1 (맨 오른쪽 줄은 그대로), y
	local Call_EncP = SetCallForward()
	SetCall(FP)
		CMov(FP, C, SX)
		When({VLe(SX, LY.W - 2)}, {Set(C, Add, 1)})
		CMov(FP, T, SY)
		CMul(FP, T, 65536)
		CAdd(FP, C, T)
	SetCallEnd()

	-- (로컬) 좌표 dword C 를 채널로 보낸다. 인자 EmHdr2 (01 A A 15), EmOff / EmLen (그 채널이 지난번 붙인 자리), EmKey.
	-- 버퍼에 남은 자기 패킷이 있으면 좌표만 고치고(키는 비트 합치기), 없으면 새로 붙인다. 결과 EmOff / EmLen, Appended, LastHdr.
	local Call_Emit = SetCallForward()
	SetCall(FP)
		CMov(FP, EmHdr, EmHdr2)
		CMul(FP, EmHdr, 256)
		CAdd(FP, EmHdr, 9)                                                    -- 09 01 A A
		CRead(FP, Len, 0x654AA0)
		CMov(FP, D, 0)
		if Cfg.Merge then
			-- 지난번 붙인 패킷이 아직 버퍼에 있는가: 길이가 그때 이상 + 그 자리에 "09 01 내 채널" 이 그대로
			CiSub(FP, T, Len, EmLen)
			CIf(FP, {VGe(EmLen, 1), VLe(T, 0x7FFFFFFF)})
				CAdd(FP, P, EmOff, 0x654880)
				Copy(TB, P, 4)
				CRead(FP, W, TB)
				CiSub(FP, T, W, EmHdr)
				CIf(FP, {VEq(T, 0)})
					CAdd(FP, P, 5)                                            -- 좌표 자리 (09 01 A A 15 | x x y y)
					CIf(FP, {VEq(EmKey, 1)})
						Copy(TB, P, 4)
						CRead(FP, Old, TB)
						COr(FP, C, Old)                                       -- 키: 그 턴에 눌린 것을 모두 남긴다
					CIfEnd()
					CDoActions(FP, {TSetMemory(TB, SetTo, C)})
					Copy(P, TB, 4)
					CMov(FP, D, 1)
					CMov(FP, EmRes, 2)
				CIfEnd()
			CIfEnd()
		end
		CIf(FP, {VEq(D, 0), VLe(Len, Cfg.BufferLimit)})
			CDoActions(FP, {TSetMemory(PB + 4, SetTo, EmHdr2), TSetMemory(PB + 8, SetTo, C)})
			CAdd(FP, P, Len, 0x654880)
			Copy(P, PB + 3, 15)                                               -- f_Memcpy 대신 (Call_Copy 설명)
			CMov(FP, EmOff, Len)
			CAdd(FP, Len, 15)
			CMov(FP, EmLen, Len)
			CDoActions(FP, {TSetMemory(0x654AA0, SetTo, Len)})
			CMov(FP, Appended, 1)
			CMov(FP, LastHdr, EmHdr)
			CMov(FP, EmRes, 1)
		CIfEnd()
	SetCallEnd()

	CJumpEnd(FP, FuncSkip)

	-- ── ① units.dat 패치 (공유, 처음 한 번) ─────────────────────────────────────
	local function ByteX(Base, Idx, Val)
		local off = Idx % 4
		return SetMemoryX(Base + Idx - off, SetTo, Val * Pow2(8 * off), 0xFF * Pow2(8 * off))
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
		SetCVar(FP, InitDone[2], SetTo, 1),
	})
	CIfEnd()

	-- ── ① 채널 건물 만들기 / 다시 만들기 (공유) ─────────────────────────────────
	local function Snap(v, s)
		local half = math.floor(s / 2)
		return math.floor((v - half) / 32) * 32 + half
	end
	-- 채널 자리: 플레이어 기준점 + (열 × Step[1], 줄 × Step[2]). 같은 자리에 두 건물이 오면 멈춘다.
	local Cols = Cfg.Columns or #Channels
	if Cols < 1 then PushErrorMsg("SNQC_Config: Columns 는 1 이상") end
	if Cfg.Step[1] < 32 or Cfg.Step[2] < 32 then PushErrorMsg("SNQC_Config: Step 은 32 이상 (넘길 때 옆 채널이 같이 잡힌다)") end
	local Rows = math.floor((#Channels - 1) / Cols) + 1
	local Taken = {}
	local function ChannelXY(pi, p, c)
		local col, row = (c - 1) % Cols, math.floor((c - 1) / Cols)
		local bx, by
		if Cfg.PlayerXY then
			local B = Cfg.PlayerXY[p]
			if B == nil then PushErrorMsg("SNQC_Config: PlayerXY 에 플레이어 " .. p .. " 자리가 없다") return 0, 0 end
			bx, by = B[1], B[2]
		else
			bx, by = Cfg.XY[1], Cfg.XY[2] + Cfg.Step[2] * Rows * (pi - 1)
		end
		return bx + Cfg.Step[1] * col, by + Cfg.Step[2] * row
	end
	for pi, p in ipairs(Cfg.Humans) do
		local NotExist = Memory(0x51A280 + p * 12 + 8, Exactly, 0xFFFFFFFF - (0x51A280 + p * 12 + 4))
		CIfX(FP, {NotExist})
		CElseX()
			for c = 1, #Channels do
				local px, py = ChannelXY(pi, p, c)
				if px >= LY.W or py >= LY.H then PushErrorMsg("SNQC: 채널 건물 자리가 맵 밖 (XY/PlayerXY/Step/Columns 를 볼 것)") end
				local sx, sy = Snap(px, Cfg.BuildSize[1]), Snap(py, Cfg.BuildSize[2])
				if sx < 16 or sy < 16 then PushErrorMsg("SNQC: 채널 건물 자리가 맵 가장자리에 너무 붙었다 (16 이상으로)") end
				local Key = sx .. "," .. sy
				if Taken[Key] then
					PushErrorMsg(string.format("SNQC: 채널 자리가 겹친다 (%s) - P%d 채널 %d 와 %s", Key, p + 1, c, Taken[Key]))
				end
				Taken[Key] = string.format("P%d 채널 %d", p + 1, c)
				CallTriggerX(FP, Call_Create, {VEq(InitDone, 1), VEq(ChEpd[p][c], 0), Memory(0x628438, AtLeast, 1)}, {
					Set(CrP, SetTo, p), Set(CrPX, SetTo, px), Set(CrPY, SetTo, py),
					Set(CrL, SetTo, sx - 16), Set(CrT, SetTo, sy - 16), Set(CrR, SetTo, sx + 16), Set(CrB, SetTo, sy + 16),
					Set(CrDone, SetTo, 1),
				})
				When({VEq(CrDone, 1)}, {
					TSetCVar(FP, ChEpd[p][c][2], SetTo, CrEpd),
					TSetCVar(FP, ChHdr2[p][c][2], SetTo, CrHdr2),
					Set(CrDone, SetTo, 0),
				})
			end
		CIfXEnd()
	end

	-- 없어진 채널 찾기 (공유) - 지우면 위에서 다음 사이클에 다시 만든다
	if Cfg.Check then
		CAdd(FP, CheckTimer, 1)
		CIf(FP, {VGe(CheckTimer, Cfg.CheckInterval)}, {Set(CheckTimer, SetTo, 0)})
			for _, p in ipairs(Cfg.Humans) do
				for c = 1, #Channels do
					CMov(FP, ChkEpd, ChEpd[p][c])
					CallTrigger(FP, Call_Check, {Set(ChkP, SetTo, p)})
					When({VEq(ChkOK, 0)}, {Set(ChEpd[p][c], SetTo, 0), Set(ChHdr2[p][c], SetTo, 0)})
				end
			end
		CIfEnd()
	end

	-- ── ② 보내기 (로컬) ───────────────────────────────────────────────────────
	-- 이 PC 플레이어의 채널 머리를 가져오고, 채널이 다 있을 때만 보낸다
	CMov(FP, MyValid, 0)
	for _, p in ipairs(Cfg.Humans) do
		CIf(FP, {LocalPlayerID(p)}, {Set(MyValid, SetTo, 1)})
			for c = 1, #Channels do
				CMov(FP, MyHdr2[c], ChHdr2[p][c])
				When({VEq(ChEpd[p][c], 0)}, {Set(MyValid, SetTo, 0)})
				if DA then
					-- 채널 건물 칸: 종류(+0x64) / 주인·오더(+0x4C) / 상태(+0xDC) / 랠리(+0xF8, 받기 전) / 좌표(+0x28) / 세대(+0xA4)
					CDoActions(FP, {TSetMemory(DSlot(c, 0), SetTo, ChEpd[p][c]), TSetMemory(DSlot(c, 1), SetTo, ChHdr2[p][c])})
					for k, off in ipairs({25, 19, 55, 62, 10, 41}) do
						f_Read(FP, _Add(ChEpd[p][c], off), DbgT)
						CDoActions(FP, {TSetMemory(DSlot(c, 5 + k), SetTo, DbgT)})
					end
				end
			end
		CIfEnd()
	end
	if DA then
		CDoActions(FP, {SetMemory(DA + 36, Add, 1), TSetMemory(DA + 40, SetTo, MyValid), SetMemory(DA + 56, SetTo, #Channels)})
		TriggerX(FP, {}, (function()
			local T = {}
			for i, m in ipairs(DbgMagic) do table.insert(T, SetMemory(DA + (i - 1) * 4, SetTo, m)) end
			table.insert(T, SetMemory(DA + 32, SetTo, 1))
			return T
		end)(), {preserved})
		CRead(FP, DbgT, 0x512684)
		CRead(FP, Len, 0x654AA0)
		CDoActions(FP, {TSetMemory(DA + 44, SetTo, DbgT), TSetMemory(DA + 48, SetTo, Len)})
	end

	local function ReadSrc(Out, Src)
		if type(Src) == "number" then CRead(FP, Out, Src) else CMov(FP, Out, Src) end
	end
	-- 조건 Conds 가 참이면 C 를 채널 c 로 보낸다 (Call_Emit 인자 복사 - 안 불렸으면 같은 값을 되쓴다)
	local function CallEmit(c, Conds, IsKey)
		CMov(FP, EmHdr2, MyHdr2[c])
		CMov(FP, EmOff, PendOff[c])
		CMov(FP, EmLen, PendLen[c])
		CMov(FP, EmRes, 0)
		CallTriggerX(FP, Call_Emit, Conds, {Set(EmKey, SetTo, IsKey and 1 or 0)})
		if DA then
			When({VEq(EmRes, 1)}, {SetMemory(DSlot(c, 2), Add, 1)})
			When({VEq(EmRes, 2)}, {SetMemory(DSlot(c, 3), Add, 1)})
		end
		CMov(FP, PendOff[c], EmOff)
		CMov(FP, PendLen[c], EmLen)
	end

	CIf(FP, {VEq(MyValid, 1)})
		-- 패킷 틀의 고정 바이트. 맵이 작업 공간을 지워도(보이드 초기화 등) 버티도록 매 사이클 다시 쓴다.
		CDoActions(FP, {
			SetMemory(PB, SetTo, 0x09000000),
			SetMemory(PB + 12, SetTo, 0x00E40000),
			SetMemory(PB + 16, SetTo, Cfg.Order),
		})
		-- 내 데스값 사본 (SNQC_MyDeaths). 데스 (유닛 u, 플레이어 p) 의 EPD = u*12 + p
		if #MyDeathOrder > 0 then
			CRead(FP, MyPlayer, 0x512684)
			for _, u in ipairs(MyDeathOrder) do
				f_Read(FP, _Add(MyPlayer, u * 12), MyDeath[u])
			end
		end
		CMov(FP, Appended, 0)

		for c, Ch in ipairs(Channels) do
			CMov(FP, Send, 0)
			if Ch.Kind == "Key" then
				CMov(FP, C, 0)
				for _, Ln in ipairs(Ch.Lines) do
					When(Ln.Resolved, {Set(C, Add, Ln.Bit)})
				end
				CallEmit(c, {VGe(C, 1)}, true)
			elseif Ch.Kind == "Value" then
				local Ln = Ch.Line
				ReadSrc(SX, Ln.Src)
				When(Concat(Ln.Resolved, {VLe(SX, Pow2(LY.VX + LY.VY) - 1)}), {Set(Send, SetTo, 1)}) -- 범위 밖 값은 안 보낸다
				if Ln.Change then
					CiSub(FP, T, SX, LastSent[c])
					When({VEq(T, 0)}, {Set(Send, SetTo, 0)})
					When({VEq(Send, 1)}, {TSetCVar(FP, LastSent[c][2], SetTo, SX)})
				end
				CallTriggerX(FP, Call_EncV, {VEq(Send, 1)}, {Set(C, SetTo, 0)})
				CallEmit(c, {VEq(Send, 1)}, false)
			elseif Ch.Kind == "Point" then
				local Ln = Ch.Line
				ReadSrc(SX, Ln.SrcX)
				ReadSrc(SY, Ln.SrcY)
				When(Concat(Ln.Resolved, {VLe(SX, LY.W - 1), VLe(SY, LY.H - 1)}), {Set(Send, SetTo, 1)})
				CallTriggerX(FP, Call_EncP, {VEq(Send, 1)}, {Set(C, SetTo, 0)})
				CallEmit(c, {VEq(Send, 1)}, false)
			elseif Ch.Kind == "Mouse" then
				local Ln = Ch.Line
				-- 화면 왼쪽 위(0x62848C, 0x6284A8) + 화면 안 마우스(0x6CDDC4, 0x6CDDC8). 바뀐 사이클에만 보낸다
				CRead(FP, SX, 0x62848C)
				CRead(FP, T, 0x6CDDC4)
				CAdd(FP, SX, T)
				CRead(FP, SY, 0x6284A8)
				CRead(FP, T, 0x6CDDC8)
				CAdd(FP, SY, T)
				CiSub(FP, T, SX, LastMX)
				CiSub(FP, W, SY, LastMY)
				When(Concat(Ln.Resolved, {VLe(SX, LY.W - 1), VLe(SY, LY.H - 1)}), {Set(Send, SetTo, 1)})
				When({VEq(T, 0), VEq(W, 0)}, {Set(Send, SetTo, 0)})
				When({VEq(Send, 1)}, {TSetCVar(FP, LastMX[2], SetTo, SX), TSetCVar(FP, LastMY[2], SetTo, SY)})
				CallTriggerX(FP, Call_EncP, {VEq(Send, 1)}, {Set(C, SetTo, 0)})
				CallEmit(c, {VEq(Send, 1)}, false)
			end
		end

		-- 선택 되돌리기: 이번 사이클에 새로 붙인 패킷이 있을 때만 (고치기만 했으면 지난번 되돌리기가 이미 뒤에 있다).
		-- 내 화면의 선택(0x6284B8, 12칸, 0 이 나오면 끝)은 우리 명령이 실행되기 전이라 아직 원래 선택이다.
		CIf(FP, {VEq(Appended, 1)})
			CRead(FP, Len, 0x654AA0)
			CIf(FP, {VLe(Len, 470)})
				CAdd(FP, P, Len, 0x654880)
				CMov(FP, SelN, 0)
				for i = 1, 12 do
					When({VEq(SelN, i - 1), Memory(0x6284B8 + 4 * (i - 1), AtLeast, 1)}, {Set(SelN, SetTo, i)})
				end
				CIfX(FP, {VGe(SelN, 1)})
					for i = 1, 12 do
						CIf(FP, {VGe(SelN, i)})
							f_Read(FP, 0x6284B8 + 4 * (i - 1), nil, AEpd)
							CallTrigger(FP, Call_Alpha, {Set(AOut, SetTo, 0)})
							CMov(FP, SelAlpha[i], AOut)
						CIfEnd()
					end
					CMov(FP, T, SelN)
					CMul(FP, T, 16777216)
					CAdd(FP, T, 0x90000)                      -- xx xx 09 n
					CDoActions(FP, {TSetMemory(RB, SetTo, T)})
					-- 쌍으로 dword 에 싣는다. SelN 보다 뒤 칸은 옛 값이지만 길이(Len)에 안 들어가 무시된다
					for k = 0, 5 do
						CMov(FP, W, SelAlpha[2 * k + 1])
						CMov(FP, T, SelAlpha[2 * k + 2])
						CMul(FP, T, 65536)
						CAdd(FP, W, T)
						CDoActions(FP, {TSetMemory(RB + 4 + 4 * k, SetTo, W)})
					end
					Copy(P, RB + 2, 26)
					CMov(FP, T, SelN)
					CMul(FP, T, 2)
					CAdd(FP, Len, T)
					CAdd(FP, Len, 2)
				CElseX()
					-- 아무것도 안 고른 상태였다 → 마지막에 고른 채널을 선택에서 뺀다 (09 01 A A → 0B 01 A A)
					CAdd(FP, W, LastHdr, 2)
					CDoActions(FP, {TSetMemory(TB, SetTo, W)})
					Copy(P, TB, 4)
					CAdd(FP, Len, 4)
				CIfXEnd()
				CDoActions(FP, {TSetMemory(0x654AA0, SetTo, Len)})
			CIfEnd()
		CIfEnd()
		if DA then
			CRead(FP, DbgT, 0x654AA0)
			CDoActions(FP, {TSetMemory(DA + 52, SetTo, DbgT)})
		end
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
			CMov(FP, RvEpd, ChEpd[p][c])
			CallTrigger(FP, Call_Recv, {Set(R, SetTo, 0)})
			if DA then
				When({LocalPlayerID(p), VGe(R, 1)}, {SetMemory(DSlot(c, 4), Add, 1), TSetMemory(DSlot(c, 5), SetTo, R)})
			end
			if Ch.Kind == "Key" then
				for _, Ln in ipairs(Ch.Lines) do
					When({Bit(R, Ln.Bit)}, {SetDeaths(p, Add, Ln.Add, Ln.Death)})
				end
			else
				local Ln = Ch.Line
				local Acts = {}
				if Ch.Kind == "Value" then
					table.insert(Acts, TSetDeaths(p, SetTo, V, Ln.Death))
				else
					if Ln.DeathX then table.insert(Acts, TSetDeaths(p, SetTo, X, Ln.DeathX)) end
					if Ln.DeathY then table.insert(Acts, TSetDeaths(p, SetTo, Y, Ln.DeathY)) end
					if Ln.Loc then
						local LA = 0x58DC60 + 20 * (Ln.Loc + p)
						table.insert(Acts, TSetMemory(LA, SetTo, X))
						table.insert(Acts, TSetMemory(LA + 4, SetTo, Y))
						table.insert(Acts, TSetMemory(LA + 8, SetTo, X))
						table.insert(Acts, TSetMemory(LA + 12, SetTo, Y))
					end
				end
				if Ln.NewDeath then table.insert(Acts, SetDeaths(p, SetTo, 1, Ln.NewDeath)) end
				if #Acts > 0 then When({VGe(R, 1)}, Acts) end
			end
		end
	end

	-- ── ④ 눌림 상태 기억 (로컬) ─────────────────────────────────────────────────
	for _, K in ipairs(EdgeKeyOrder) do
		When({KeyPress(K, "Down")}, {Set(EdgeKey[K], SetTo, 1)})
		When({KeyPress(K, "Up")}, {Set(EdgeKey[K], SetTo, 0)})
	end
	for _, B in ipairs(EdgeMouseOrder) do
		When({MousePress(B, "Down")}, {Set(EdgeMouse[B], SetTo, 1)})
		When({MousePress(B, "Up")}, {Set(EdgeMouse[B], SetTo, 0)})
	end
end
