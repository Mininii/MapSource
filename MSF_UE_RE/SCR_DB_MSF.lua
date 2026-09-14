-- ============================================================================
-- SCR_DB_MSF : MSF_UE_RE (마린키우기 UnLimit ExceeD) 를 SCR_DB 오프라인 세이브로 잇는 어댑터
--
-- SCA 시절 이 맵은 EUD Editor 의 SCArchive 모듈(sca.eps)로 세이브를 주고받았다. 저장 값은
-- 전부 **데스값**이다 - 서버가 불러온 값을 데스 칸에 넣어 주면 Player_interface.lua 의
-- SCA_DeathToV 가 변수로 옮겨 가고, 변수가 바뀌면 거꾸로 데스 칸에 적어 둔다. 그래서 여기서도
-- 데스 칸만 채우고 읽으면 된다. 런처와의 약속은 Library/SCR_DB_Core.lua 가 맡는다.
--
-- 맵과의 약속 (sca.eps 에서 옮겨 온 것)
--   데스 23 = 불러오기 상태   0 런처 없음 / 1 불러오는 중 / 2 불러옴  (3 = 예전 "연결됨", 안 씀)
--             로비 화면(Operator.lua)과 칭호(TE 메인 eps 의 GUEST 표시)가 이 값을 본다
--   데스 14 = 저장 요청 (HOME 저장 버튼, 스테이지 클리어 자동 저장, 점수 추가 때 1)
--   데스 15 = 문구 유지 타이머 (문구를 띄울 때 5000 을 넣던 관례를 따른다)
--
-- 불러오기는 **게임 시작 전**(Switch 240 이 꺼져 있을 때)에만 받는다. 원래 맵 규칙이고
-- ("데이터 로드는 게임 시작 전에만 가능"), 로비에서 고르는 최대 레벨이 불러온 값에 달려 있다.
-- 불러오기를 끝내지 못한 플레이어는 **저장도 막는다.** 안 그러면 새 캐릭터로 시작한 판의 값이
-- 진짜 세이브를 덮어쓴다 (SCA 도 LoadCheck 로 같은 것을 막았다).
-- ============================================================================

-- 저장 항목. e3s 의 SCArchive 저장 목록(_CodeDatas)을 그대로 옮겼다. 이 순서가 매니페스트 순서다.
-- {이름, 데스 유닛}. 런처는 이름으로 저장하므로 순서를 바꿔도 예전 세이브는 그대로 복원된다.
-- 빼 둔 것
--   149 BanFlag       데이터 조작 방지 표시(비정상 값 -> 강퇴). 이번 버전은 조작 방지를 넣지 않는다
--   148/147 CurrentTime  저장 시각. SCA 서버 시각이라 오프라인에서는 뜻이 없고 맵이 읽는 곳도 없다
SCRMSF_Fields = {
	{"StatData", 4},       -- 구버전 스탯 포인트
	{"LevelData", 6},      -- 구버전 최고 레벨
	{"HighScore", 24},     -- 구버전 최고 점수
	{"MapMakerFlag", 11},  -- 제작자 권한 (@칭호 3, 테스트 모드)
	{"NewLevel", 18},      -- 최고 레벨
	{"NewStat", 35},       -- 스탯 포인트
	{"NewScore", 36},      -- 최고 점수
	{"UsedOldP", 37},      -- 환전한 구버전 포인트
	{"TesterFlag", 38},    -- 테스터 권한 (@칭호 4)
	{"NewUsedStat", 39},   -- 쓴 스탯 포인트
	{"MultiStimPack", 40},
	{"MultiHold", 41},
	{"MultiStop", 42},
	{"AtkExceed", 43},
	{"HPExceed", 44},
	{"ShUp", 45},
	{"MCoolDownP", 46},
	{"MSkillP", 47},
	{"PStatVer", 48},
	{"MinUp", 49},
}
SCRMSF_SaveKey = "MSF_UE_RE"
SCRMSF_Humans = 7                -- P1~P7

-- 표지 블록과 MSQC 채널 자리.
-- 0x592014~0x593FFF 는 PEUD 구역(유닛 494~664, ~0x592013) 뒤, 이 맵의 void 할당(0x594000~,
-- Var_Include.lua) 앞의 빈칸이다. 보스전마다 도는 Call_VoidReset(0x594000~) 에 걸리지 않는다.
-- 다만 onInit_EUD 가 게임 시작 때 0x58F448~0x5967E8 를 **한 번 싹 지우므로**, 표지 블록은
-- 그 뒤에 조립되어야 한다 - 그래서 main.lua 에서 SCRMSF_Exec 를 onInit_EUD 뒤에 부른다.
SCRMSF_AnchorBase = 0x593800     -- SCRDB_TOTAL(168) dword = 0x593800~0x593AA0
SCRMSF_MsqcAddr = 0x593F00       -- 채널 k = 0x593F00 + 4k (0x593F00~0x593F1C)
-- 채널 데스 유닛. 23/24 가 이 맵의 저장·상태 칸이라 DPS 의 21~28 을 못 쓴다.
-- 182~189 는 특수 건물(칸티나, 광산 플랫폼 ...) 번호라 P1~P7 이 가질 일이 없고(가진 유닛이 죽어야
-- 데스가 오른다), 맵 전체에서 이 번호의 P1~P7 데스를 읽거나 쓰는 곳이 없다.
SCRMSF_MsqcDeath = 182
SCRMSF_Channels = 8

SCRMSF_LoadState = 23
SCRMSF_SaveReq = 14
SCRMSF_MsgHold = 15
SCRMSF_StartSwitch = "Switch 240"   -- 켜지면 게임 시작 (Operator.lua 의 ComputerReplace 호출)

-- 컴파일 타임. 설정과 매니페스트. main.lua 에서 SCRMSF_Exec 바로 앞에 부른다.
function SCRMSF_Init()
	local Fields = {}
	for _, F in ipairs(SCRMSF_Fields) do
		-- 데스 칸 (유닛 u, 플레이어 p) = 0x58A364 + (u*12 + p)*4. 런처 식으로는
		-- XferBase = 0x58A364, XferStride = 1, index = u*12 인 arr 항목이다.
		table.insert(Fields, {name = F[1], mode = "arr", index = F[2] * 12})
	end
	SCRDB_Setup({
		SaveKey = SCRMSF_SaveKey,
		Fields = Fields,
		AnchorBase = SCRMSF_AnchorBase,
		Humans = SCRMSF_Humans,
		Channels = SCRMSF_Channels,
		MsqcAddr = SCRMSF_MsqcAddr,
		MsqcDeath = SCRMSF_MsqcDeath,
		XferBase = 0x58A364,
		XferStride = 1,
		SlotBase = 0x58A364,        -- var 항목이 없어 쓰이지 않는다 (0 이면 런처가 블록을 거른다)
		SlotStride = 1,
		MaxPlayers = 8,
		-- 키 = 데스 칸 번호(u*12). 맵은 표 없이 "키 + 플레이어" 가 곧 EPD 라 쓰기가 단순하다.
		KeyMode = "index",
		ManifestPath = "C:\\Temp\\SCR_DB_manifest_" .. SCRMSF_SaveKey .. ".json",
		Extra = {map_title = "마린키우기 UnLimit ExceeD RE_Mastered"},
	})
	SCRDB_WriteManifest()
end

-- 매 프레임. main.lua 에서 onInit_EUD() 뒤, OPTrig()(로비) 앞에 부른다.
function SCRMSF_Exec()
	SCRDB_Anchor()

	-- 받은 값 쓰기. 데스 칸 EPD = 키(u*12) + 플레이어. 키가 저장 항목의 범위와 12 의 배수인지,
	-- 게임이 시작 전인지 확인한 뒤에만 쓴다. 게임 중에 값이 바뀌면 진행 중인 판이 흔들린다.
	local KeyMin, KeyMax = 227 * 12, 0
	for _, F in ipairs(SCRMSF_Fields) do
		KeyMin = math.min(KeyMin, F[2] * 12)
		KeyMax = math.max(KeyMax, F[2] * 12)
	end
	local Addr, Rem = CreateVars(2, FP)
	SCRDB_Receiver(function(i, Key, Val)
		CMov(FP, Rem, _Mod(Key, 12))
		-- (VRange 는 DPS 에만 있는 함수라 CtrigAsm 기본 조건 CV 두 개로 쓴다)
		CIf(FP, {CV(Key, KeyMin, AtLeast), CV(Key, KeyMax, AtMost), CV(Rem, 0),
			Switch(SCRMSF_StartSwitch, Cleared)})
			CAdd(FP, Addr, Key, i)
			CDoActions(FP, {TSetMemory(Addr, SetTo, Val)})
		CIfEnd()
	end)
	SCRDB_Notify()
	-- 게임이 시작되면 런처에 불러오기 창이 닫혔다고 알린다(런처가 괜히 보내고 어긋났다고 하지 않게).
	SCRDB_CloseLoad({Switch(SCRMSF_StartSwitch, Set)})

	for i = 0, SCRMSF_Humans - 1 do
		-- --- 불러오기 상태 (데스 23) ------------------------------------------
		-- 워드가 오기 시작하면 "불러오는 중", 준비 신호가 오면 "불러옴".
		TriggerX(FP, {CD(SCRDB_Activity[i+1], 1), Deaths(i, Exactly, 0, SCRMSF_LoadState),
			Switch(SCRMSF_StartSwitch, Cleared)}, {SetDeaths(i, SetTo, 1, SCRMSF_LoadState)}, {preserved})
		DoActionsX(FP, {SetCD(SCRDB_Activity[i+1], 0)})
		TriggerX(FP, {CD(SCRDB_LauncherReady[i+1], 1), Switch(SCRMSF_StartSwitch, Cleared)},
			{SetCD(SCRDB_LauncherReady[i+1], 0), SetDeaths(i, SetTo, 2, SCRMSF_LoadState)}, {preserved})
		-- 게임이 시작된 뒤에 온 준비 신호: 불러오기는 받지 않았으므로 알리기만 한다.
		-- 이미 불러온 플레이어(런처를 다시 켠 경우)는 그대로 저장이 되므로 알리지 않는다.
		CIf(FP, {CD(SCRDB_LauncherReady[i+1], 1), Switch(SCRMSF_StartSwitch, Set)}, {SetCD(SCRDB_LauncherReady[i+1], 0)})
			CIf(FP, {Deaths(i, AtMost, 1, SCRMSF_LoadState)},
				{SetDeaths(i, SetTo, 5000, SCRMSF_MsgHold), SetCp(i), PlayWAV("sound\\Misc\\PError.WAV"), SetCp(FP)})
				DisplayPrintEr(i, {"\x07『 \x03SCR_DB \x04: \x08게임이 시작된 뒤\x04에는 \x07불러올 수 없습니다\x04. 이번 판은 \x08저장되지 않습니다\x04. \x07』"})
			CIfEnd()
		CIfEnd()

		-- --- 저장 요청 (데스 14) ----------------------------------------------
		-- 불러오기를 끝낸 플레이어만 저장 신호를 올린다. 런처가 데스 칸을 읽어 파일로 쓰고
		-- 저장 완료(0xFFFD)를 보내면 아래에서 문구와 소리를 낸다.
		CIf(FP, {Deaths(i, Exactly, 1, SCRMSF_SaveReq), Switch(SCRMSF_StartSwitch, Set)},
			{SetDeaths(i, SetTo, 0, SCRMSF_SaveReq)})
			CIfX(FP, {Deaths(i, Exactly, 2, SCRMSF_LoadState)}, {SCRDB_SaveSignal(i)})
			CElseX({SetDeaths(i, SetTo, 5000, SCRMSF_MsgHold), SetCp(i), PlayWAV("sound\\Bullet\\tscFir00.wav"), SetCp(FP)})
				DisplayPrintEr(i, {"\x07『 \x03SCR_DB \x07런처\x04와 \x07연결\x04되지 않아 \x08저장\x04할 수 없습니다. \x07』"})
			CIfXEnd()
		CIfEnd()

		-- --- 저장 완료 -----------------------------------------------------------
		-- 런처가 파일까지 쓴 뒤에 온다. MSQC 로 받은 신호라 모든 클라이언트에서 똑같이 돈다
		-- (DisplayPrintEr 가 공용 변수를 바꿔도 디싱크가 없다). 문구와 소리는 그 플레이어에게만.
		CIf(FP, {CD(SCRDB_SaveDone[i+1], 1)},
			{SetCD(SCRDB_SaveDone[i+1], 0), SetDeaths(i, SetTo, 5000, SCRMSF_MsgHold),
			 SetCp(i), PlayWAV("sound\\Misc\\TDrTra01.wav"), SetCp(FP)})
			DisplayPrintEr(i, {"\x07『 \x03SCR_DB \x04: \x07게임 데이터\x04가 \x07정상적으로 저장\x04되었습니다. \x07』"})
		CIfEnd()
	end
end
