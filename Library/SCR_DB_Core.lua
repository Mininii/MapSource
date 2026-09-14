-- ============================================================================
-- SCR_DB_Core : SCR_DB 오프라인 세이브의 맵 쪽 공통 부품 (표지 블록 레이아웃 6)
--
-- 런처(DPS_Enhance/tools/scr_db_launcher.py)와 약속한 것만 여기 둔다. 맵마다 다른 것 -
-- 저장 값이 어디 사는지, 맵이 언제 불러오기/저장을 원하는지 - 은 각 맵의 어댑터가 정한다.
--     DPS_Enhance/SCR_DB.lua          SCA 전송 버퍼 + 슬롯 블록. 항목번호로 쓴다
--     MSF_UE_RE/SCR_DB_MSF.lua        데스값. 데스 칸 번호(unit*12)로 쓴다
-- 규약 표와 이식 절차는 DPS_Enhance/docs/SCR_DB_PORTING.md.
--
-- 이 파일은 Library 에 있어서 이 폴더를 읽는 모든 맵이 불러간다. 그래서 불러올 때는 함수와
-- 상수만 정의하고 트리거도 void 할당도 만들지 않는다. 쓰는 맵만 SCRDB_Setup 을 부른다.
--
-- 어댑터가 부르는 순서
--   SCRDB_Setup(Cfg)        컴파일 타임. 설정과 저장 항목을 받고 지문을 계산한다
--   SCRDB_WriteManifest()   컴파일 타임. 런처가 읽을 매니페스트(json)를 쓴다
--   -- 여기부터는 매 프레임 도는 구간에서 --
--   SCRDB_Anchor()          표지 블록 (시작 때 한 번 조립, 매 프레임 Seq 와 로컬 플레이어)
--   SCRDB_Receiver(Write)   MSQC 수신기. 값 하나가 다 모이면 Write(i, Key, Val) 를 부른다
--   SCRDB_Notify()          런처 알림음
--   그다음 SCRDB_LauncherReady / SCRDB_SaveDone / SCRDB_Activity 를 맵의 규약으로 옮기는 일,
--   저장 요청이 오면 SCRDB_SaveSignal(i) 를 올리는 일은 어댑터가 한다.
--
-- 지켜야 할 규칙 (DPS 에서 전부 실제로 겪었다)
--   * 런처가 로컬 메모리에 쓴 값으로 여는 트리거는 공유 상태를 건드리면 안 된다 (디싱크).
--     공유 상태를 바꾸는 신호는 전부 MSQC 로 받는다. 표지 블록에 로컬로 쓰이는 칸은 Notify 뿐이고
--     그 트리거는 소리만 낸다. LocalPlayer 칸은 맵이 로컬 조건으로 쓰지만 런처만 읽는다.
--   * 준비·저장은 플레이어별로 판정한다. 하나로 두면 런처 없는 플레이어가 남의 신호를 받는다.
-- ============================================================================

-- 7 : MSQC 워드를 20비트로 줄였다(토글 비트 23/22 -> 18/19). 아래 "MSQC 워드" 설명 참고.
SCRDB_LAYOUT_VERSION = 7

-- 표지 블록 시그니처. 런처가 이 8 dword 를 스캔해 블록을 찾는다. 값이 트리거 액션 속에
-- 흩어져 있어 메모리에 올라온 맵 파일 사본에는 연속으로 나타나지 않는다.
SCRDB_MAGIC = {0x53435244, 0x425F3031, 0x2F6D61CF, 0xC2B2AE3D,
               0x27D4EB2F, 0x165667B1, 0x85EBCA77, 0x9E3779B1}

-- MsqcCount / MsqcEcho 표의 플레이어 칸 수. 맵의 사람 수와 상관없이 8 로 고정해서 런처가
-- [채널*8 + 플레이어] 로 짚는다 (레이아웃 5 까지는 4 였다 - 7인 맵이 들어오면서 늘렸다).
SCRDB_TABLE_PLAYERS = 8

-- dword 인덱스. 런처의 I_* 상수와 반드시 같아야 한다.
SCRDB_I = {
	Version = 8, Build = 9, Self = 10,       -- Self = 블록 자신의 EUD 주소 (런처가 보정치를 구한다)
	XferBase = 11, XferStride = 12,          -- arr 항목 = XferBase + (P*XferStride + index)*4
	SlotBase = 13, SlotStride = 14,          -- var 항목 = SlotBase + (P*SlotStride + slot)*4
	MaxPlayers = 15, SlotCount = 16, FieldCount = 17,
	Seq = 18,                                -- 매 프레임 +1 (살아 있는 게임 판정)
	Ready = 19, Ack = 20, Cmd = 21,          -- Ready/SaveAck 는 폐기 칸, Ack/Cmd 는 진단용
	SaveSeq = 22, SaveAck = 23,              -- SaveSeq = 공용 저장 신호 (진단용)
	MsqcCount = 24,                          -- 24..87  받은 워드 수 [채널*8 + 플레이어]
	MsqcEcho = 88,                           -- 88..151 받은 워드의 꼬리표+페이로드 (무결성 확인)
	Notify = 152,                            -- 런처 -> 맵 알림음 코드 (로컬 쓰기, 소리만)
	SaveSeqP = 153,                          -- 153..160 플레이어별 저장 신호
	FieldHash = 161,                         -- 저장 항목 목록의 지문
	LocalPlayer = 162,                       -- 이 클라이언트의 플레이어 번호 + 1 (클라이언트마다 다르다)
	Humans = 163,                            -- 수신기가 받는 플레이어 수 (P1..P<Humans>)
	MsqcAddr = 164, MsqcChannels = 165,      -- 채널 k 의 로컬 주소 = MsqcAddr + 4k
	LoadOpen = 166,                          -- 1 이면 불러오기를 받는다 (0 이면 런처가 불러오지 않는다)
}
SCRDB_TOTAL = 168

-- MSQC 워드 (20비트)
--     비트 18 = 토글 A, 비트 19 = 토글 B, 비트 16..17 = 꼬리표, 비트 0..15 = 페이로드
-- 20비트로 묶는 이유: MSQC 의 val 은 값을 우클릭 좌표에 실어 보내서 실을 수 있는 크기가 **맵 크기에
-- 달려 있다**. euddraft 가 빌드 때 "Sendable value range for 'val' syntax" 로 알려 준다.
--     256x256(DPS) = 0~16777215 (24비트), 96x192(MSF_UE_RE) = 0~8388607 (23비트), 64x64 = 22비트
-- 레이아웃 6 은 토글을 비트 23/22 에 두어 DPS 에서는 됐지만 MSF 에서는 토글 A 가 아예 실리지 않아
-- 워드가 하나도 도착하지 않았다(2026-09-14 첫 인게임 시험). 64x64 맵까지 들어가게 20비트로 줄였다.
-- 꼬리표 0 = 항목 키 (또는 예약 워드 0xFFFE 준비 / 0xFFFD 저장 완료)
--       1 = 값 하위 16비트
--       2 = 값 상위 16비트 -> 여기서 쓴다
--       3 = 채널 시험 (수신기가 아무것도 하지 않는다)
-- 토글: MSQC 는 로컬 값이 남아 있는 한 매 프레임 다시 보내므로 "같은 워드가 또 온 것" 과
-- "새 워드" 를 토글이 바뀌었는지로 가른다.
-- 꼬리표: 레이아웃 5 까지는 수신기가 "몇 번째 워드인지" 를 단계 변수로 셌다. 그러면 워드 하나가
-- 깨져서 런처가 다시 보낼 때 그 재전송이 다음 단계의 값으로 먹혀, 뒤따르는 항목이 줄줄이 엉뚱한
-- 칸에 들어간다. 꼬리표가 있으면 워드마다 자기 자리를 알고, 같은 워드를 다시 받아도 결과가
-- 같다(멱등). 런처는 Echo 로 꼬리표까지 확인하고, 다 보낸 뒤 값을 되읽어 한 번 더 대조한다.
SCRDB_TOGGLE_A = 0x40000
SCRDB_TOGGLE_B = 0x80000
SCRDB_TAG_MASK = 0x30000
SCRDB_TAG_KEY = 0x00000
SCRDB_TAG_LO = 0x10000
SCRDB_TAG_HI = 0x20000
SCRDB_PAYLOAD = 0xFFFF
SCRDB_ECHO_MASK = 0x3FFFF
SCRDB_WORD_READY = 0xFFFE
SCRDB_WORD_SAVED = 0xFFFD

function SCRDB_Slot(Base, k, i)
	return Base + k*SCRDB_TABLE_PLAYERS + i
end

-- 표지 블록 칸 하나의 EUD 주소. SCRDB_Setup 전에 부르면 미정의 전역 읽기로 컴파일이 멈춘다.
function SCRDB_Addr(Index)
	return SCRDB_Cfg.AnchorBase + Index*4
end

-- 이름이 겹치는 항목에만 저장 위치를 붙여 id 를 만든다. 런처는 name 이 아니라 id 로 저장한다.
-- DPS 에 같은 이름을 쓰는 항목이 10개 있었다(128비트 확장 8 + 이름표 오타 2). 한쪽에만 붙이면
-- 두 항목의 순서가 바뀔 때 예전 세이브가 엉뚱한 자리로 복원되므로 겹치는 쪽은 양쪽 다 붙인다.
function SCRDB_AssignIds(Fields)
	local Count, Dups = {}, {}
	for _, F in ipairs(Fields) do
		Count[F.name] = (Count[F.name] or 0) + 1
	end
	for _, F in ipairs(Fields) do
		if Count[F.name] > 1 then
			F.id = string.format("%s#%s%d", F.name, F.mode, F.index or F.slot)
			Dups[F.name] = true
		else
			F.id = F.name
		end
	end
	local DupNames = {}
	for Name in pairs(Dups) do
		table.insert(DupNames, Name)
	end
	table.sort(DupNames)
	return DupNames
end

-- 항목 목록의 지문 (djb2, 32비트). 순번까지 들어간다 - 순번이 곧 MSQC 항목번호일 수 있다.
-- 표지 블록 FieldHash 칸에 박아 두면 런처는 빌드 ID 가 달라도 목록이 같은 매니페스트를 알아본다.
-- scr_db_launcher.py 의 field_hash() 가 같은 계산이다(검산용).
function SCRDB_FieldHash(Fields)
	local Hash = 5381
	for _, F in ipairs(Fields) do
		local Line = string.format("%s|%s|%d\n", F.id, F.mode, F.index or F.slot)
		for n = 1, #Line do
			Hash = (Hash * 33 + Line:byte(n)) % 4294967296
		end
	end
	return Hash
end

-- Cfg (필수)
--   SaveKey      세이브 이름표. 맵마다 다르게, 한 번 정하면 바꾸지 않는다
--   Fields       {{name=, mode="arr", index=} 또는 {name=, mode="var", slot=}, ...}
--   AnchorBase   표지 블록 자리 (SCRDB_TOTAL dword). 맵의 다른 쓰임과 겹치면 안 된다
--   Humans       수신기가 받을 플레이어 수 (1..8)
--   MsqcAddr     채널 0 의 로컬 주소. 채널 k = MsqcAddr + 4k (eds 의 [MSQC] val 줄과 같아야 한다)
--   MsqcDeath    채널 0 의 데스 유닛. 채널 k = MsqcDeath + k (맵에서 안 쓰는 번호여야 한다)
--   XferBase, XferStride, SlotBase, SlotStride   런처가 값을 읽을 자리 (위 SCRDB_I 설명)
--   ManifestPath 매니페스트를 쓸 경로
-- Cfg (선택)
--   Channels(8)  KeyMode("ordinal" | "index")  MaxPlayers(8)  SlotCount(0)  Extra(매니페스트에 덧붙일 표)
--   KeyMode 는 런처가 항목 키로 무엇을 보낼지다. ordinal = 매니페스트 순번, index = 항목의 index 값.
function SCRDB_Setup(Cfg)
	if rawget(_G, "scrdb_cfg") ~= nil then PushErrorMsg("SCRDB_Setup 이 두 번 불렸다") end
	for _, K in ipairs({"SaveKey", "Fields", "AnchorBase", "Humans", "MsqcAddr", "MsqcDeath",
	                    "XferBase", "XferStride", "SlotBase", "SlotStride", "ManifestPath"}) do
		if Cfg[K] == nil then PushErrorMsg("SCRDB_Setup: Cfg." .. K .. " 가 없다") end
	end
	Cfg.Channels = Cfg.Channels or 8
	Cfg.KeyMode = Cfg.KeyMode or "ordinal"
	Cfg.MaxPlayers = Cfg.MaxPlayers or 8
	Cfg.SlotCount = Cfg.SlotCount or 0
	if Cfg.Humans < 1 or Cfg.Humans > SCRDB_TABLE_PLAYERS then
		PushErrorMsg(string.format("SCRDB_Setup: Humans=%d (1..%d)", Cfg.Humans, SCRDB_TABLE_PLAYERS))
	end
	if Cfg.Channels < 1 or Cfg.Channels > 8 then
		PushErrorMsg(string.format("SCRDB_Setup: Channels=%d (1..8)", Cfg.Channels))
	end
	if Cfg.KeyMode ~= "ordinal" and Cfg.KeyMode ~= "index" then
		PushErrorMsg("SCRDB_Setup: KeyMode 는 ordinal 또는 index")
	end
	-- 예약 워드(0xFFFD/0xFFFE)와 겹치지 않고 16비트에 들어가는 키만 쓸 수 있다
	for n, F in ipairs(Cfg.Fields) do
		local Key = (Cfg.KeyMode == "index") and F.index or (n - 1)
		if Key == nil or Key < 0 or Key >= SCRDB_WORD_SAVED then
			PushErrorMsg(string.format("SCRDB_Setup: 항목 %s 의 키 %s 를 보낼 수 없다", tostring(F.name), tostring(Key)))
		end
	end
	local AEnd = Cfg.AnchorBase + SCRDB_TOTAL*4
	local MEnd = Cfg.MsqcAddr + Cfg.Channels*4
	if Cfg.MsqcAddr < AEnd and Cfg.AnchorBase < MEnd then
		PushErrorMsg("SCRDB_Setup: 표지 블록과 MSQC 채널 자리가 겹친다")
	end
	Cfg.BuildId = os.time() % 0x7FFFFFFF
	Cfg.DupNames = SCRDB_AssignIds(Cfg.Fields)
	Cfg.FieldHash = SCRDB_FieldHash(Cfg.Fields)
	SCRDB_Cfg = Cfg
	-- 수신기가 세우고 어댑터가 읽어서 내리는 플레이어별 표시 (MSQC 로 왔으니 모든 클라이언트가 같이 본다)
	SCRDB_LauncherReady = CreateCcodeArr(8)  -- 런처가 불러오기를 끝냈다 (예약 워드 0xFFFE)
	SCRDB_SaveDone = CreateCcodeArr(8)       -- 런처가 세이브 파일까지 썼다 (0xFFFD)
	SCRDB_Activity = CreateCcodeArr(8)       -- 이번 프레임에 워드가 하나라도 왔다 (불러오는 중 표시용)
end

-- 표지 블록. DebugBridge 와 같은 순서다: 게임 시작 때 한 번 블록 전체 0 -> 헤더 -> 시그니처를
-- **맨 마지막**에. 시그니처를 가장 늦게 써야 런처가 반쯤 채워진 블록을 집어가지 않는다.
-- 액션 목록은 반드시 CIfOnce **안에서** 만든다. 바깥에서 미리 만들어 넣었더니 블록이 컴파일 오류
-- 없이 조용히 실행되지 않았다(DPS). CIfOnce 의 액션 인자는 상한이 16개라 DoActions2 로 쪼갠다.
function SCRDB_Anchor()
	local C = SCRDB_Cfg
	CIfOnce(FP, nil, {})
		local Zero = {}
		for n = 0, SCRDB_TOTAL - 1 do
			table.insert(Zero, SetMemory(SCRDB_Addr(n), SetTo, 0))
		end
		DoActions2(FP, Zero)
		DoActions2(FP, {
			SetMemory(SCRDB_Addr(SCRDB_I.Version),      SetTo, SCRDB_LAYOUT_VERSION),
			SetMemory(SCRDB_Addr(SCRDB_I.Build),        SetTo, C.BuildId),
			SetMemory(SCRDB_Addr(SCRDB_I.Self),         SetTo, C.AnchorBase),
			SetMemory(SCRDB_Addr(SCRDB_I.XferBase),     SetTo, C.XferBase),
			SetMemory(SCRDB_Addr(SCRDB_I.XferStride),   SetTo, C.XferStride),
			SetMemory(SCRDB_Addr(SCRDB_I.SlotBase),     SetTo, C.SlotBase),
			SetMemory(SCRDB_Addr(SCRDB_I.SlotStride),   SetTo, C.SlotStride),
			SetMemory(SCRDB_Addr(SCRDB_I.MaxPlayers),   SetTo, C.MaxPlayers),
			SetMemory(SCRDB_Addr(SCRDB_I.SlotCount),    SetTo, C.SlotCount),
			SetMemory(SCRDB_Addr(SCRDB_I.FieldCount),   SetTo, #C.Fields),
			SetMemory(SCRDB_Addr(SCRDB_I.FieldHash),    SetTo, C.FieldHash),
			SetMemory(SCRDB_Addr(SCRDB_I.Humans),       SetTo, C.Humans),
			SetMemory(SCRDB_Addr(SCRDB_I.MsqcAddr),     SetTo, C.MsqcAddr),
			SetMemory(SCRDB_Addr(SCRDB_I.MsqcChannels), SetTo, C.Channels),
			SetMemory(SCRDB_Addr(SCRDB_I.LoadOpen),     SetTo, 1),
		})
		local Sig = {}
		for n, Magic in ipairs(SCRDB_MAGIC) do
			table.insert(Sig, SetMemory(SCRDB_Addr(n - 1), SetTo, Magic))
		end
		DoActions2(FP, Sig)
	CIfEnd()

	-- 이 클라이언트의 플레이어 번호. 런처가 로컬 플레이어(0x512684)를 직접 읽으면 미러 구역 밖이라
	-- 엉터리 값이 나와서, P2 의 런처가 자기를 P1 로 알고 P1 의 저장에 깨어났다(DPS 2인 시험).
	-- 조건이 클라이언트마다 달라 이 칸의 값도 갈리므로 **맵의 어떤 트리거도 이 칸을 읽으면 안 된다.**
	-- preserved 라 트리거 실행 표시도 갈리지 않는다. 매 프레임 다시 쓴다(시작 프레임의 0 초기화 뒤).
	for i = 0, 7 do
		TriggerX(FP, {LocalPlayerID(i)}, {SetMemory(SCRDB_Addr(SCRDB_I.LocalPlayer), SetTo, i + 1)}, {preserved})
	end

	DoActions(FP, SetMemory(SCRDB_Addr(SCRDB_I.Seq), Add, 1))
end

-- 불러오기를 더 받지 않는다고 런처에 알린다 (조건이 참이 되는 순간부터 0). 공유 상태(스위치 등)로
-- 판정하는 조건만 넣을 것 - 모든 클라이언트에서 같은 값이 되어야 한다.
function SCRDB_CloseLoad(Conds)
	TriggerX(FP, Conds, {SetMemory(SCRDB_Addr(SCRDB_I.LoadOpen), SetTo, 0)}, {preserved})
end

-- 저장 신호 액션 (플레이어 i 의 칸만 +1). 런처는 자기 칸만 본다.
function SCRDB_SaveSignal(i)
	return SetMemory(SCRDB_Addr(SCRDB_I.SaveSeqP + i), Add, 1)
end

-- MSQC 수신기. 채널 x 플레이어마다 토글과 "하위 16비트를 받았는가" 를 따로 둔다.
-- Write(i, Key, Val) 는 값이 다 모인 순간 부른다. 키가 맞는 범위인지는 Write 가 확인한다
-- (범위 밖 키로 아무 데나 쓰면 게임이 죽거나 멀쩡한 데이터를 망친다).
function SCRDB_Receiver(Write)
	local C = SCRDB_Cfg
	-- 한 프레임 안에서 받자마자 쓰고 버리는 값은 채널끼리 같이 쓴다(변수 수 절약).
	local Got = CreateCcode()
	local Pay, Echo, Val = CreateVars(3, FP)
	for k = 0, C.Channels - 1 do
		local Death = C.MsqcDeath + k
		for i = 0, C.Humans - 1 do
			local CntSlot = SCRDB_Slot(SCRDB_I.MsqcCount, k, i)
			local EchoSlot = SCRDB_Slot(SCRDB_I.MsqcEcho, k, i)
			-- Tog: 0 = 마지막이 B(또는 아직 없음), 1 = 마지막이 A. Ccode 가 0 에서 시작하므로
			-- 초기화 블록 없이도 첫 워드(토글 A)가 받아들여진다. 초기화 블록을 뒀다가 조용히 안 돌아
			-- 수신기가 통째로 죽은 적이 있다(DPS) - 없는 부품은 고장나지 않는다.
			local Tog = CreateCcode()
			local HaveLo = CreateCcode()
			local Key, Lo = CreateVars(2, FP)

			DoActionsX(FP, {SetCD(Got, 0)})
			CIf(FP, {DeathsX(i, Exactly, SCRDB_TOGGLE_A, Death, SCRDB_TOGGLE_A), CD(Tog, 0)},
				{SetCD(Tog, 1), SetCD(Got, 1), SetMemory(SCRDB_Addr(CntSlot), Add, 1)})
			CIfEnd()
			CIf(FP, {DeathsX(i, Exactly, SCRDB_TOGGLE_B, Death, SCRDB_TOGGLE_B), CD(Tog, 1)},
				{SetCD(Tog, 0), SetCD(Got, 1), SetMemory(SCRDB_Addr(CntSlot), Add, 1)})
			CIfEnd()

			CIf(FP, {CD(Got, 1)}, {SetCD(SCRDB_Activity[i+1], 1)})
				-- 꼬리표+페이로드를 되돌려 준다. 비트 0 부터 이어진 마스크라 자리 이동 걱정이 없다.
				f_Read(FP, DtoA(i, Death), Echo, nil, SCRDB_ECHO_MASK, 1)
				CMov(FP, SCRDB_Addr(EchoSlot), Echo)
				f_Read(FP, DtoA(i, Death), Pay, nil, SCRDB_PAYLOAD, 1)

				CIf(FP, {DeathsX(i, Exactly, SCRDB_TAG_KEY, Death, SCRDB_TAG_MASK)}, {SetCD(HaveLo, 0)})
					CMov(FP, Key, Pay)
					TriggerX(FP, {CV(Pay, SCRDB_WORD_READY)}, {SetCD(SCRDB_LauncherReady[i+1], 1)}, {preserved})
					TriggerX(FP, {CV(Pay, SCRDB_WORD_SAVED)}, {SetCD(SCRDB_SaveDone[i+1], 1)}, {preserved})
				CIfEnd()
				CIf(FP, {DeathsX(i, Exactly, SCRDB_TAG_LO, Death, SCRDB_TAG_MASK)}, {SetCD(HaveLo, 1)})
					CMov(FP, Lo, Pay)
				CIfEnd()
				-- 쓴 뒤에도 HaveLo 를 내리지 않는다. 상위 워드가 깨져 런처가 다시 보내면 같은 칸에
				-- 맞는 값으로 한 번 더 쓰게 된다. HaveLo 는 다음 항목 키가 올 때 내린다.
				CIf(FP, {DeathsX(i, Exactly, SCRDB_TAG_HI, Death, SCRDB_TAG_MASK), CD(HaveLo, 1)})
					CAdd(FP, Val, Lo, _Mul(Pay, 65536))
					Write(i, Key, Val)
				CIfEnd()
			CIfEnd()
		end
	end
end

-- 런처 알림음. 사건(연결/끊김/불러오기/오류)은 런처에서 나는데 WAV 는 스타가 재생하므로 맵을
-- 거친다. Notify 칸은 런처가 자기 PC 메모리에 쓰는 로컬 신호라 소리도 그 클라이언트에서만 난다.
-- 소리는 게임 상태가 아니라서 클라이언트마다 달라도 디싱크가 없다.
-- (배치는 SCA 시절 SCATool.eps 와 같다. 저장 완료음은 어댑터가 SCRDB_SaveDone 에서 낸다)
function SCRDB_Notify()
	local Sounds = {
		{1, "sound\\Misc\\ZRescue.wav"},    -- 연결됨
		{2, "sound\\Bullet\\tscFir00.wav"}, -- 연결 끊김
		{3, "sound\\Misc\\TDrTra01.wav"},   -- 불러오기 완료
		{4, "sound\\Misc\\PError.WAV"},     -- 오류
	}
	for _, S in ipairs(Sounds) do
		CIf(FP, {Memory(SCRDB_Addr(SCRDB_I.Notify), Exactly, S[1])},
			{SetMemory(SCRDB_Addr(SCRDB_I.Notify), SetTo, 0)})
			for i = 0, 7 do
				TriggerX(FP, {LocalPlayerID(i)}, {SetCp(i), PlayWAV(S[2]), SetCp(FP)}, {preserved})
			end
		CIfEnd()
	end
end

function SCRDB_Json(Value)
	local T = type(Value)
	if T == "number" then
		return string.format("%d", Value)
	elseif T == "boolean" then
		return tostring(Value)
	elseif T == "string" then
		local S = Value:gsub("\\", "\\\\"):gsub("\"", "\\\""):gsub("%c", function(Ch)
			return string.format("\\u%04x", Ch:byte())
		end)
		return "\"" .. S .. "\""
	elseif T == "table" then
		local Parts = {}
		if #Value > 0 or next(Value) == nil then
			for _, X in ipairs(Value) do
				table.insert(Parts, SCRDB_Json(X))
			end
			return "[" .. table.concat(Parts, ",") .. "]"
		end
		local Keys = {}
		for K in pairs(Value) do
			table.insert(Keys, tostring(K))
		end
		table.sort(Keys)
		for _, K in ipairs(Keys) do
			table.insert(Parts, SCRDB_Json(K) .. ":" .. SCRDB_Json(Value[K]))
		end
		return "{" .. table.concat(Parts, ",") .. "}"
	end
	return "null"
end

-- 런처가 "무엇을 어디에 저장할지" 를 읽는 파일. 빌드할 때마다 다시 쓰이므로 맵과 어긋나지 않는다.
function SCRDB_WriteManifest()
	local C = SCRDB_Cfg
	local Doc = {
		format = "scr-db-manifest",
		layout_version = SCRDB_LAYOUT_VERSION,
		build_id = C.BuildId,
		generated = os.date("%Y-%m-%d %H:%M:%S"),
		signature = SCRDB_MAGIC,
		header = SCRDB_I,
		total_dwords = SCRDB_TOTAL,
		anchor_eud = C.AnchorBase,
		xfer_base = C.XferBase,
		xfer_stride = C.XferStride,
		slot_base = C.SlotBase,
		slot_stride = C.SlotStride,
		slot_count = C.SlotCount,
		max_players = C.MaxPlayers,
		humans = C.Humans,
		msqc_addr = C.MsqcAddr,
		msqc_death = C.MsqcDeath,
		msqc_channels = C.Channels,
		msqc_key = C.KeyMode,
		field_hash = C.FieldHash,
		save_key = C.SaveKey,
		-- 이름이 겹쳐 id 에 저장 위치를 붙인 것들. 맵의 실수인지 확인해 볼 만한 목록이다.
		duplicate_names = C.DupNames,
		fields = C.Fields,
	}
	for K, V in pairs(C.Extra or {}) do
		Doc[K] = V
	end
	local F = io.open(C.ManifestPath, "w")
	if F == nil then
		PushErrorMsg("SCRDB_WriteManifest: " .. C.ManifestPath .. " 를 열 수 없다")
		return
	end
	F:write(SCRDB_Json(Doc))
	F:close()
end
