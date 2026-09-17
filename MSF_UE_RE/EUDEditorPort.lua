--[[
	EUDEditorPort.lua  -  EUD Editor 3(e3s) 없이 빌드하기 (theSeed 와 같은 방향, 2026-09-15)

	예전 빌드는 EUD Editor 3 가 MSF_UE_RE.e3s 에서 build/ 폴더(DataEditor.py, ExtraDataEditor.py, RequireData,
	custom_txt.tbl, TriggerEditor\main.eps, EUDEditor.eds)를 만들고 euddraft 가 그걸 플러그인으로 넣었다.
	그 내용을 전부 이 폴더로 옮겼다. e3s 는 이제 빌드에 쓰이지 않는다 (EUD Editor 로 열어 보는 참고용).

	  EUD Editor 가 하던 일                     지금 하는 곳
	  [DataEditor.py]  dat 패치 773줄            EUDEditorDat.lua         -> EUDEditorInit()          첫 프레임 1회
	  [ExtraDataEditor.py] 정보창 함수 2줄       EUDEditorDat.lua         -> EUDEditorInit()          첫 프레임 1회
	  [ExtraDataEditor.py] 요구사항 풀           EUDEditorRequireData.lua -> EUDEditorInit()          첫 프레임 1회
	  [ExtraDataEditor.py] 요구사항 오프셋 표 5종 EUDEditorRequireData.lua -> EUDEditorRequireTables() 매 프레임
	  [ExtraDataEditor.py] 버튼셋                EUDEditorButtonSets.lua  -> RegisterButtonSetData()/ApplyButtonSetData()
	  [ExtraDataEditor.py] 와이어프레임 4줄      EUDEditorWireframe() (아래)  Library 의 ChangeWireframe
	  custom_txt.tbl -> [dataDumper]             stat_txt.tbl + EUDEditorStatTxt.lua -> WriteStatTxtTbl() (컴파일 때 파일로)
	  TriggerEditor\main.eps (칭호·기부 채팅)     main_scrdb.eps                         (build_scrdb.py 가 싣는다)
	  EUDEditor.eds (MSQC 키·chatEvent 등)       eds_template.eds + QCInput.lua         (build_scrdb.py 가 채운다)

	■ 시점
	  EUD Editor 의 플러그인은 onPluginStart(첫 프레임, 트리거보다 먼저)와 beforeTriggerExec(매 프레임, 트리거보다 먼저)에서
	  돌았다. 여기서는 main.lua 가 StartCtrig 바로 뒤, "3초 대기" CIf 바깥에서 부른다 = 첫 프레임 P8 트리거의 맨 앞.
	  - CtrigInitArr 에 넣지 않은 이유: EndCtrig 의 InitCtrig() 가 그 목록을 트리거 목록 "맨 끝" 에 놓는다.
	  - 요구사항 오프셋 표는 매 프레임 쓴다. EUDinit.lua 의 PatchArrPrsv(UnitEnableX 의 오프셋 5 = 요구사항 없음)가
	    3초 뒤부터 같은 프레임 안에서 그 위를 덮는다 - EUD Editor 때와 같은 앞뒤 순서다.
	  - 와이어프레임만 3초 뒤(onInit_EUD 다음)다. Library 의 와이어프레임 포인터(FWIRE)는 EndCtrig 가 목록 끝에 둔
	    트리거가 채우므로, 첫 프레임 맨 앞에서 ChangeWireframe 이 돌면 빈 포인터로 엉뚱한 곳에 쓴다.
	    바뀌는 유닛(121 보스, 211/212 이펙트)은 3초 안에 나오지 않는다.

	■ 검산 (2026-09-15, 옮길 때 한 번)
	  dat 773줄 / 정보창 2줄 / 버튼셋 14개 / 요구사항 오프셋 표 5종과 참조 구역 워드 / stat_txt 1547줄 전부
	  EUD Editor 가 만든 파일과 바이트까지 같음을 확인하고 옮겼다.
]]

-- ================================================================================================
-- 1. 첫 프레임 1회: dat 패치 + 정보창 함수 + 요구사항 풀
-- ================================================================================================

-- 요구사항 opcode (theSeed Engine/func.lua 의 ReqOpcode 와 같은 값).
EUDEditorReqOpcode = {
	Or=0xFF01, CurrentUnitIs=0xFF02, HasUnit=0xFF03, HasAddonAttached=0xFF04,
	IsNotLifted=0xFF05, IsLifted=0xFF06, IsNotBusyBuilding=0xFF07, IsNotConstructingAddon=0xFF08,
	IsNotTeching=0xFF09, IsNotUpgrading=0xFF0A, IsNotConstructingBuilding=0xFF0B, HasNoAddon=0xFF0C,
	HasNoNydusExit=0xFF0D, HasHangarSpace=0xFF0E, TechIsResearched=0xFF0F, OnlyIfHasNoNuke=0xFF10,
	OnlyIfNotBurrowedOrAI=0xFF11, OnlyIfNotLandedBuilding=0xFF12, OnlyIfLandedBuilding=0xFF13,
	OnlyIfCanMove=0xFF14, OnlyIfCanAttack=0xFF15, OnlyIfWorker=0xFF16, OnlyIfCanLiftoff=0xFF17,
	IsTransport=0xFF18, OnlyIfPowerup=0xFF19, OnlyIfSubunit=0xFF1A, OnlyIfHasSpiderMines=0xFF1B,
	IsHero=0xFF1C, OnlyIfCanRallyOrRclick=0xFF1D, AllowOnHallucinations=0xFF1E,
	UpgradeLevelBasedJump=0xFF1F, UpgradeLevel2Requires=0xFF20, UpgradeLevel3Requires=0xFF21,
	RequirementBlank=0xFF23, OnlyIfBW=0xFF24, OnlyIfTechResearched=0xFF25, OnlyIfBurrowed=0xFF26,
}
-- 뒤 워드를 값으로 먹는 opcode. MSF 의 UpgradeLevel2Requires/3Requires 는 값 없는 표지다(EUDEditorRequireData.lua 상단).
local ReqParamOps = {CurrentUnitIs = true, HasUnit = true, HasAddonAttached = true, OnlyIfTechResearched = true}

local function ReqScriptWords(Conds, Out, Where)
	for _, C in ipairs(Conds) do
		if type(C) == "number" then
			table.insert(Out, C) -- opcode 없는 맨 워드 = 그 유닛 보유 요구
		else
			local Name, Param = C, nil
			if type(C) == "table" then Name, Param = C[1], C[2] end
			local Op = EUDEditorReqOpcode[Name]
			if Op == nil then error("EUDEditorRequireData " .. Where .. ": 모르는 조건 " .. tostring(Name)) end
			table.insert(Out, Op)
			if ReqParamOps[Name] then
				if Param == nil then error("EUDEditorRequireData " .. Where .. ": " .. Name .. " 에 값이 없다") end
				table.insert(Out, Param)
			elseif Param ~= nil then
				error("EUDEditorRequireData " .. Where .. ": " .. Name .. " 은 값을 받지 않는다")
			end
		end
	end
	table.insert(Out, 0xFFFF)
end

local ReqCategories = {"unit", "upgrade", "tech_research", "tech_use", "order"}
local ReqPool, ReqTables -- BuildRequireData() 결과를 한 번만 만든다

--[[ 풀(워드 배열, 1부터)과 오프셋 표 5종을 만든다. 규칙은 옮길 때 원본과 대조한 그대로다:
	카테고리마다 RequireContentStart 부터 번호순으로 스크립트를 이어 붙이고, 끝에 0xFFFF 를 하나 더 둔다. ]]
local function BuildRequireData()
	if ReqPool then return ReqPool, ReqTables end
	local Src = {
		unit = RequireUnitScripts, upgrade = RequireUpgradeScripts, tech_research = RequireTechResearchScripts,
		tech_use = RequireTechUseScripts, order = RequireOrderScripts,
	}
	local Pool, Tables = {}, {}
	for I = 1, RequireDataPoolWords do Pool[I] = 0 end
	for _, Name in ipairs(ReqCategories) do
		local Base, Budget, Count = RequireContentBase[Name], RequireContentBudget[Name], RequireTableCount[Name]
		for Id in pairs(Src[Name]) do
			if type(Id) ~= "number" or Id < 0 or Id >= Count then
				error("EUDEditorRequireData: " .. Name .. " 의 번호 " .. tostring(Id) .. " 은 0~" .. (Count - 1) .. " 밖이다")
			end
		end
		local Cur, Tbl = RequireContentStart[Name], {}
		for Id = 0, Count - 1 do
			local E = Src[Name][Id]
			if E == nil then
				Tbl[Id] = 0 -- 오프셋 0 = 항상 실패(비활성)
			else
				Tbl[Id] = Cur
				local Words = {}
				for _, Sc in ipairs(E.scripts or {E}) do ReqScriptWords(Sc, Words, Name .. "[" .. Id .. "]") end
				for _, W in ipairs(Words) do
					if Cur >= Budget then
						error("EUDEditorRequireData: " .. Name .. " 스크립트가 영역(" .. Budget .. "워드)을 넘는다")
					end
					Pool[Base + Cur + 1] = W
					Cur = Cur + 1
				end
			end
		end
		if Cur < Budget then Pool[Base + Cur + 1] = 0xFFFF end
		Tables[Name] = Tbl
	end
	-- EUDinit.lua 의 UnitEnableX 가 유닛 요구사항 오프셋을 5 로 써서 "요구사항 없음"(빈 스크립트)을 만든다.
	-- 5번 워드가 0xFFFF 가 아니면 그 유닛들의 버튼이 엉뚱한 조건을 보게 된다.
	if Pool[RequireContentBase.unit + 5 + 1] ~= 0xFFFF then
		error("EUDEditorRequireData: 유닛 풀 5번 워드가 0xFFFF 가 아니다 - UnitEnableX(오프셋 5 = 요구사항 없음)가 깨진다."
			.. " 유닛 0 의 스크립트 길이를 원래대로(워드 1~5) 둘 것")
	end
	ReqPool, ReqTables = Pool, Tables
	return Pool, Tables
end

function EUDEditorInit()
	local Acts = {}
	for _, A in ipairs(EUDEditorDatActs) do Acts[#Acts + 1] = SetMemory(A[1], Add, A[2]) end
	for _, A in ipairs(EUDEditorStatusFnActs) do Acts[#Acts + 1] = SetMemory(A[1], SetTo, A[2]) end
	local Pool = BuildRequireData()
	for I = 0, RequireDataPoolWords - 1, 2 do -- 워드 둘씩 dword 로 (EUD Editor 의 f_repmovsd 와 같은 4260바이트)
		Acts[#Acts + 1] = SetMemory(RequireDataPoolBase + I * 2, SetTo, Pool[I + 1] + Pool[I + 2] * 0x10000)
	end
	DoActions2(FP, Acts, 1) -- 1 = 한 번만
end

-- ================================================================================================
-- 2. 매 프레임: 요구사항 오프셋 표 5종 (EUD Editor 의 beforeTriggerExec)
-- ================================================================================================
function EUDEditorRequireTables()
	local _, Tables = BuildRequireData()
	local Acts = {}
	for _, Name in ipairs(ReqCategories) do
		local Addr, Count, Tbl = RequireOffsetTableAddr[Name], RequireTableCount[Name], Tables[Name]
		for Id = 0, Count - 2, 2 do
			Acts[#Acts + 1] = SetMemory(Addr + Id * 2, SetTo, Tbl[Id] + Tbl[Id + 1] * 0x10000)
		end
		-- 개수가 홀수면(업글 61, 오더 189) EUD Editor 는 마지막 번호를 쓰지 않았다(원래 값 그대로). 같게 두되,
		-- 거기에 스크립트를 새로 두면 그 번호만 워드로 쓴다.
		if Count % 2 == 1 and Tbl[Count - 1] ~= 0 then
			Acts[#Acts + 1] = SetMemoryW(Addr + (Count - 1) * 2, SetTo, Tbl[Count - 1])
		end
	end
	DoActions2(FP, Acts) -- 매 프레임
end

-- ================================================================================================
-- 3. 버튼셋 (EUDEditorButtonSets.lua)
-- ================================================================================================
BUTTONSET_TABLE = 0x005187E8 -- BUTTON_SET[250], stride 12
ButtonSetPtr = {}            -- [세트 번호] = f_GetFileArrptr 결과

-- 한 세트의 행들 -> BUTTON 배열 바이트열(리틀엔디언). theSeed MapLogic/ButtonSetPatch.lua 와 같다.
function EncodeButtonSet(Rows)
	local B = {}
	local function W16(V)
		V = V % 0x10000
		B[#B + 1] = V % 0x100
		B[#B + 1] = math.floor(V / 0x100) % 0x100
	end
	local function W32(V)
		V = V % 0x100000000
		B[#B + 1] = V % 0x100
		B[#B + 1] = math.floor(V / 0x100) % 0x100
		B[#B + 1] = math.floor(V / 0x10000) % 0x100
		B[#B + 1] = math.floor(V / 0x1000000) % 0x100
	end
	for _, R in ipairs(Rows) do
		for K = 1, 8 do
			if type(R[K]) ~= "number" then
				error("EUDEditorButtonSets: 행의 " .. K .. "번째 칸이 숫자가 아니다 (함수 이름 오타?)")
			end
		end
		W16(R[1]) W16(R[2]) W32(R[3]) W32(R[4]) W16(R[5]) W16(R[6]) W16(R[7]) W16(R[8])
	end
	return B
end

-- 컴파일마다 싣는 순서가 흔들리지 않도록 번호순
local function SortedSetIds()
	local Ids = {}
	for Id in pairs(ButtonSetDefs) do Ids[#Ids + 1] = Id end
	table.sort(Ids)
	return Ids
end

-- main.lua 의 선언 전용 CJump 블록 안에서 부른다 (f_GetFileArrptr = STRCtrig 필수, Jump 구역 안에서만).
function RegisterButtonSetData()
	for _, Id in ipairs(SortedSetIds()) do
		if Id < 0 or Id > 249 then error("EUDEditorButtonSets: 세트 번호 " .. Id .. " 은 0~249 밖이다") end
		ButtonSetPtr[Id] = f_GetFileArrptr(FP, EncodeButtonSet(ButtonSetDefs[Id]), 1, 1)
	end
end

--[[ 첫 프레임 1회. EUD Editor 처럼 +4(배열 주소)와 +0(버튼 수)만 쓴다 - +8(connectedUnit, 영웅<->일반 연결)은
	건드리지 않았다. T 액션은 블록 안에서 만들고(피드백 #8), 세트마다 따로 내보낸다(한 트리거 액션 수 상한). ]]
function ApplyButtonSetData()
	CIfOnce(FP, nil, {})
	for _, Id in ipairs(SortedSetIds()) do
		local Base = BUTTONSET_TABLE + 12 * Id
		CDoActions(FP, {
			TSetMemory(Base + 4, SetTo, ButtonSetPtr[Id]),
			SetMemory(Base + 0, SetTo, #ButtonSetDefs[Id]),
		})
	end
	CIfEnd()
end

-- ================================================================================================
-- 4. 와이어프레임 (ExtraDataEditor.py 의 init_wireframe)
-- ================================================================================================
-- Include_Wireframe(0) 이 main.lua 의 init_func 안에 있어야 한다. Library 의 표는 EUD Editor 의
-- WireFrameDataEditor.eps 표와 32/64비트 모두 같다(옮길 때 대조). 매 프레임 같은 값을 다시 쓴다(Library 방식).
function EUDEditorWireframe()
	ChangeWireframe(FP, 121, 12)  -- 유닛 121 의 와이어프레임 = 12 의 것
	ChangeGrpwire(FP, 121, 12)    -- (EUD Editor 의 ChangeGrpframe)
	ChangeWireframe(FP, 211, 210)
	ChangeWireframe(FP, 212, 210)
end

-- ================================================================================================
-- 5. stat_txt.tbl (컴파일 때 파일로 쓴다)
-- ================================================================================================
StatTxtOutFile = "C:\\euddraft0.9.2.0\\MSF_UE_RE_stat_txt.tbl" -- build_scrdb.py 의 STAT_TXT_OUT 과 같아야 한다

local function U16(S, P) return S:byte(P) + S:byte(P + 1) * 256 end

-- UTF-8 로 적은 줄 -> CP949 바이트. 널 문자로 나뉜 조각마다 바꾸고 널은 그대로 둔다(버튼 툴팁의 \0, iTbl 자리의 \0\0\0).
local function Cp949Record(S)
	if TEP30Flag ~= 1 then return S end -- 소스가 이미 CP949 인 옛 TEP 라면 바꾸지 않는다
	local Out, Start = {}, 1
	while true do
		local Z = string.find(S, "\0", Start, true)
		local Seg = Z and string.sub(S, Start, Z - 1) or string.sub(S, Start)
		if string.find(Seg, "[\128-\255]") then Seg = __encode_cp949(Seg) end
		Out[#Out + 1] = Seg
		if not Z then break end
		Start = Z + 1
	end
	return table.concat(Out, "\0")
end

function WriteStatTxtTbl()
	local Path = Curdir .. "MapSource\\MSF_UE_RE\\" .. StatTxtBaseFile
	local F = io.open(Path, "rb")
	if F == nil then error("WriteStatTxtTbl: 베이스 tbl 을 열 수 없다: " .. Path) end
	local D = F:read("*a")
	F:close()

	-- 클래식 tbl: u16 개수, u16 오프셋[개수], 레코드들 (레코드 i = 오프셋[i] ~ 오프셋[i+1])
	local N = U16(D, 1)
	local Offs, Rec = {}, {}
	for I = 1, N do Offs[I] = U16(D, 2 * I + 1) end
	for I = 1, N do Rec[I] = D:sub(Offs[I] + 1, (I < N) and Offs[I + 1] or #D) end

	for Id, V in pairs(StatTxtEdits) do
		if type(Id) ~= "number" or Id < 1 or Id > N then
			error("EUDEditorStatTxt: 줄 번호 " .. tostring(Id) .. " 은 1~" .. N .. " 밖이다")
		end
		if type(V) == "table" then Rec[Id] = V.raw else Rec[Id] = Cp949Record(V) end
		if type(Rec[Id]) ~= "string" or #Rec[Id] == 0 then error("EUDEditorStatTxt: [" .. Id .. "] 이 비었다") end
	end

	local Head = 2 + 2 * N
	local Out, Cur = {}, Head
	local function W16(V) Out[#Out + 1] = string.char(V % 256, math.floor(V / 256) % 256) end
	W16(N)
	for I = 1, N do
		W16(Cur)
		Cur = Cur + #Rec[I]
	end
	if Cur > 0xFFFF then error("WriteStatTxtTbl: tbl 이 64KB 를 넘는다 (" .. Cur .. "바이트)") end
	if Cur > StatTxtMaxBytes then
		error("WriteStatTxtTbl: tbl 이 " .. Cur .. "바이트로 지금까지 돌던 " .. StatTxtMaxBytes .. "바이트보다 크다 -"
			.. " [dataDumper] copy 가 게임의 tbl 버퍼 위에 쓰므로 넘치면 뒤의 메모리를 덮는다. 다른 줄을 줄일 것 (EUDEditorStatTxt.lua)")
	end
	for I = 1, N do Out[#Out + 1] = Rec[I] end

	local O = io.open(StatTxtOutFile, "wb")
	if O == nil then error("WriteStatTxtTbl: 쓸 수 없다: " .. StatTxtOutFile) end
	O:write(table.concat(Out))
	O:close()
end
