--[[
	QCInput.lua - 로컬 입력(키보드·마우스·로컬 메모리) -> 모든 PC 동기화 (2026-09-17)

	QCInput_Plugin 로 방식을 고른다. 셋 다 아래 QCInput_Lines(MSQC 줄 문법)를 그대로 쓴다.
	  "SNQC_LUA" : SNQC CtrigAsm 판 (MapSource/SNQC/SNQC.lua). main.lua 의 QCInput_Install() 이 트리거를 만든다 (3초 뒤부터).
	               eds 에는 입력 단락이 없다.
	  "SNQC_PY"  : SNQC euddraft 플러그인 판. build_scrdb.py 가 eds 에 [SNQC] 단락을 쓴다
	               (MapSource/SNQC/SNQC.py 를 C:\euddraft0.9.2.0\plugins 에 복사해 둔다).
	  "MSQC"     : 예전 방식. build_scrdb.py 가 eds 에 [MSQC] 단락을 쓴다 (QCDebug = false 그대로).
	SNQC 두 판은 150프레임마다 한 사이클 입력이 사라지는 MSQC 문제가 없다 (MapSource/SNQC/DESIGN.md).

	★ 이 파일이 줄의 정본이다. build_scrdb.py 가 QCInput_Plugin, QCInput_Lines, QCInput_ChatTitleDeath,
	  QCInput_ChannelUnit, QCInput_PlayerXY, QCInput_Columns 를 정규식으로 읽는다 - 이름과 모양(한 줄 대입, 긴 문자열 블록)을 바꾸지 말 것.
	  줄 블록 안에는 주석을 쓰지 않는다 (플러그인 판이 그대로 읽는다).
	  {{...}} 자리: MULTICMD_SET / MULTICMD_FLAG_DEATH = EUDEditorButtonSets.lua, CHAT_TITLE_DEATH = 아래 값.
	  SCR_DB 채널 줄(8개)은 SCR_DB_MSF.lua 의 SCRMSF_* 로 따로 만들어 붙인다 (두 곳이 같은 식).

	받는 데스값 (P1~P7 각자의 칸)
	  101 150 152 180 190        값 줄 (0x58f614, 기부 금액, BGM, 멀티 커맨드 쪽 표시)
	  102 197 199~226            키 줄
	  182~189                    SCR_DB 채널 (SCR_DB_MSF.lua)
	  191                        "@칭호 N" 채팅 -> N (main_scrdb.eps 가 읽는다. 예전에는 PluginVariables.py 의 VChatIndex 배열)

	채널 건물 (SNQC 두 판)
	  - 종류 106(커맨드센터)을 채널 전용으로 쓴다. 이 맵은 106 을 미리 놓지도, 만들지도, 버튼으로 짓지도 않는다
	    (2026-09-17 확인: 코드·버튼셋·맵 UNIT/TRIG 에 없음. 요구사항 표와 맵 UNIx 에 원본 값만 남아 있다).
	  - EUDinit.lua 의 전 유닛 루프(건설크기 1x1, 미리 놓인 유닛 재배치, RemoveUnit)가 QCInput_ChannelUnits() 를 건너뛴다.
	    예전 MSQC 의 QC 유닛(58 발키리)을 건너뛰던 것과 같다.
	  - 자리 (SNQC 두 판 공통): 각 플레이어 배럭 밑에 4열 × 4줄 (QCInput_PlayerXY / QCInput_Columns).
	    Lua 판은 PlayerXY / Columns 설정으로, 플러그인 판은 eds 의 SNQC_XY1~7 / SNQCColumns 로 받는다. 시야 0 이어도 게임은 유닛 칸 주변을 밝히고
	    (주인이 P9 이상일 때만 건너뜀), 플레이어끼리 시야가 공유돼 예전 자리(오른쪽 가운데)가 미니맵에 보였다 (2026-09-17 시험).
	    기지 안은 원래 보이는 곳이라 새로 드러나는 것이 없다. 배럭 = P1 (768, 5984) 부터 256 씩 (기지 Location 2~8).
	    한 점에 겹쳐 쌓지 않는 이유: 만든 건물을 P11 로 넘길 때 ±16 상자로 고르므로 옆 채널이 32 보다 가까우면 엉뚱한 건물을 넘긴다.
	  - 작업 공간 0x593C00~0x593C33: SCR_DB 표지(0x593800~)와 채널(0x593F00~) 사이 빈칸. onInit_EUD 가 게임 시작 때
	    0x58F448~0x5967E8 을 한 번 지우지만 SNQC 1.1 은 패킷 틀을 매 사이클 다시 쓴다. Call_VoidReset(0x594000~) 에는 안 걸린다.
	  - 보스 클리어의 KillUnit("Any unit", P11) 은 채널 건물까지 죽일 수 있어 그 보스가 P11 에 넘기는 유닛만 죽이게 바꿨다
	    (QCInput_KillP11BossUnits). 그래도 채널이 없어지면 SNQC 가 34사이클 안에 다시 만든다.
]]

QCInput_Plugin = "SNQC_PY"

QCInput_ChatTitleDeath = 191
QCInput_ChannelUnit = 106
-- 플레이어 i(0부터) 의 첫 채널 = 배럭 왼쪽 위 칸 (배럭은 P1 (768, 5984) 부터 256 씩). 채널은 32 간격 4열로 접힌다.
-- build_scrdb.py 가 이 줄을 그대로 읽으므로 [번호] = {x, y} 모양을 한 줄로 둘 것.
QCInput_PlayerXY = {[0] = {720, 5936}, [1] = {976, 5936}, [2] = {1232, 5936}, [3] = {1488, 5936}, [4] = {1744, 5936}, [5] = {2000, 5936}, [6] = {2256, 5936}}
QCInput_Columns = 4
QCInput_WorkAddr = 0x593C00
-- 시험판: 채널 상태를 이 주소에 매 사이클 복사한다 (tools/snqc_probe.py 가 게임 중에 읽는다). 배포판에서는 nil.
-- 0x592100~0x592440 (16 + 16채널 × 12 dword). SCR_DB 표지(0x593800~) 앞의 빈칸이다.
QCInput_DebugAddr = 0x592100

QCInput_Lines = [[
0x58D900, Exactly, 2 : {{CHAT_TITLE_DEATH}}, 1
0x58D900, Exactly, 3 : {{CHAT_TITLE_DEATH}}, 2
0x58D900, Exactly, 4 : {{CHAT_TITLE_DEATH}}, 3
0x58D900, Exactly, 5 : {{CHAT_TITLE_DEATH}}, 4
Switch("Switch 240",Set); val, 0x58F500 : 180
Switch("Switch 240",Set);ESC = 199,1
Switch("Switch 240",Set);F12 = 202,1
Switch("Switch 240",Set);F9 = 203,1
Switch("Switch 240",Set);HOME = 197,1
Deaths(CurrentPlayer,Exactly,1,441);RIGHT = 200,1
Deaths(CurrentPlayer,Exactly,1,441);LEFT = 201,1
Deaths(CurrentPlayer,Exactly,1,441);Switch("Switch 240",Cleared);Y = 221,1
Deaths(CurrentPlayer,Exactly,1,441);B = 204,1
Deaths(CurrentPlayer,AtLeast,1,443);1 = 205,1
Deaths(CurrentPlayer,AtLeast,1,443);2 = 206,1
Deaths(CurrentPlayer,AtLeast,1,443);3 = 207,1
Deaths(CurrentPlayer,AtLeast,1,443);4 = 208,1
Deaths(CurrentPlayer,AtLeast,1,443);5 = 209,1
Deaths(CurrentPlayer,AtLeast,1,443);6 = 210,1
Deaths(CurrentPlayer,AtLeast,1,443);7 = 211,1
Deaths(CurrentPlayer,AtLeast,1,442);1 = 212,1
Deaths(CurrentPlayer,AtLeast,1,442);2 = 213,1
Deaths(CurrentPlayer,AtLeast,1,442);3 = 214,1
Deaths(CurrentPlayer,AtLeast,1,442);4 = 215,1
Deaths(CurrentPlayer,AtLeast,1,442);5 = 216,1
Deaths(CurrentPlayer,AtLeast,1,442);6 = 217,1
Deaths(CurrentPlayer,AtLeast,1,442);7 = 218,1
Deaths(CurrentPlayer,AtLeast,1,442);` = 219,1
Deaths(CurrentPlayer,AtLeast,1,442);Q = 102,1
Deaths(CurrentPlayer,AtLeast,1,442);KeyPress(E) = 102,1
Switch("Switch 230",Set);TAB = 222,1
Switch("Switch 230",Set);Z = 225,1
Switch("Switch 230",Set);KeyPress(LSHIFT);LEFT = 223,1
Switch("Switch 230",Set);KeyPress(LSHIFT);RIGHT = 224,1
Switch("Switch 231",Set);F12 = 226,1
Deaths(CurrentPlayer,AtLeast,1,442);val, 0x58f610 : 150
Always();val, 0x58f614 : 101
Deaths(CurrentPlayer,AtLeast,1,442);val, 0x58f618 : 152
Deaths(CurrentPlayer,AtLeast,1,40);Deaths(CurrentPlayer,AtLeast,1,41);Deaths(CurrentPlayer,AtLeast,1,42);mouse: Location74
Memory(0x68C14C,Exactly,{{MULTICMD_SET}});val, 0x68C14C : {{MULTICMD_FLAG_DEATH}}
]]

-- SCR_DB 런처 워드(0~0xFFFFF)가 값 줄에 들어가야 한다 (build_scrdb.py 의 SCRDB_WORD_MAX 와 같다)
QCInput_ValueNeed = 0xFFFFF

-- 채널 건물 종류 목록 (EUDinit.lua 의 전 유닛 루프가 건너뛴다). MSQC 판은 따로 없다 (58 은 EUDinit 이 늘 건너뛴다).
function QCInput_ChannelUnits()
	if QCInput_Plugin == "MSQC" then return {} end
	return {QCInput_ChannelUnit}
end

-- 보스 클리어 때 P11 에서 치울 유닛. 예전의 KillUnit("Any unit", P11) 대신 (채널 건물을 살리려고).
-- 2026-09-17 코드 전체에서 P11 로 넘기는 것을 모은 것 - 새로 P11 에 넘기는 유닛을 만들면 여기에 더할 것.
--   Terran Wraith, Tom Kazansky (Wraith) : DemonLanterns.lua, DemonicEmperor.lua
--   60 (= "Identity JinjinZZara Noodles"), Gantrithor (Carrier) : DemonicEmperor.lua
--   94, 193 : Destr0yer.lua (스스로 치우지만 남았을 때를 위해)
-- 미리 놓인 P11 유닛은 없다. Identity.lua 는 P11 에 넘기는 것이 없다 (P9·P12 만).
QCInput_P11BossUnits = {"Terran Wraith", "Tom Kazansky (Wraith)", 60, "Gantrithor (Carrier)", 94, 193}
function QCInput_KillP11BossUnits()
	local T = {}
	for _, U in ipairs(QCInput_P11BossUnits) do table.insert(T, KillUnit(U, P11)) end
	return T
end

function QCInput_Install()
	if QCInput_Plugin == "MSQC" or QCInput_Plugin == "SNQC_PY" then return end
	if QCInput_Plugin ~= "SNQC_LUA" then
		PushErrorMsg("QCInput_Plugin 은 SNQC_LUA / SNQC_PY / MSQC 중 하나: " .. tostring(QCInput_Plugin))
		return
	end
	dofile(Curdir .. "MapSource/SNQC/SNQC.lua")
	SNQC_Config{
		MapTiles = {96, 192},
		Humans = {0, 1, 2, 3, 4, 5, 6},
		Unit = QCInput_ChannelUnit,
		PlayerXY = QCInput_PlayerXY,
		Columns = QCInput_Columns,
		WorkAddr = QCInput_WorkAddr,
		DebugAddr = QCInput_DebugAddr,
	}
	local Fill = {
		CHAT_TITLE_DEATH = QCInput_ChatTitleDeath,
		MULTICMD_SET = MultiCmdButtonSetID,
		MULTICMD_FLAG_DEATH = MultiCmdFlagDeath,
	}
	local Text = string.gsub(QCInput_Lines, "{{([%w_]+)}}", function(k) return Fill[k] and tostring(Fill[k]) end)
	if string.find(Text, "{{", 1, true) then PushErrorMsg("QCInput_Lines: 못 채운 {{...}} 자리가 있다") end
	for Line in string.gmatch(Text, "[^\r\n]+") do
		if string.match(Line, "%S") then SNQC_Line(Line) end
	end
	for k = 0, SCRMSF_Channels - 1 do
		local Addr = SCRMSF_MsqcAddr + 4 * k
		SNQC_Line(string.format("Memory(0x%X,AtLeast,1);val, 0x%X: %d", Addr, Addr, SCRMSF_MsqcDeath + k))
	end
	if SNQC_ValueMax() < QCInput_ValueNeed then
		PushErrorMsg(string.format("SNQC 값 범위 0~%d 가 SCR_DB 워드 0~0x%X 보다 작다", SNQC_ValueMax(), QCInput_ValueNeed))
	end
	SNQC_Install()
end
