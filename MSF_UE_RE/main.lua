-- ── MapSource 부트스트랩 ─────────────────────────────────────────────────
-- PC 마다 다른 경로는 MapSource/Bootstrap.lua 한 곳에서 관리한다.  이 블록은
-- 모든 맵에서 똑같고 어느 PC 에서도 고칠 필요가 없다.  자동 탐지가 빗나가는
-- PC 에서는 그 PC 의 환경변수 MAPSOURCE_CURDIR 만 잡아 주면 된다.
do
	local sep  = package.config:sub(1, 1)
	local home = os.getenv("USERPROFILE") or os.getenv("HOME") or ""
	local function try(c)
		if type(c) ~= "string" or c == "" then return false end
		local root = c:gsub("[/\\]+$", "") .. sep
		local boot = root .. "MapSource" .. sep .. "Bootstrap.lua"
		local f = io.open(boot, "r")
		if not f then return false end
		f:close()
		Curdir = root
		dofile(boot)
		return true
	end
	-- rawget 을 쓰는 이유: basescript 가 _G 에 __index 를 걸어 정의되지 않은
	-- 전역을 "읽는 것" 자체를 에러로 만든다.  __newindex 가 키를 소문자로 눕히므로
	-- 소문자로 찾아야 한다 (Curdir -> _G["curdir"]).
	local ok = try(os.getenv("MAPSOURCE_CURDIR")) or try(rawget(_G, "curdir"))
		or try(home .. sep .. "Documents") or try(home .. sep .. "Desktop")
		or try(home .. sep .. "OneDrive" .. sep .. "Documents") or try(home)
	if not ok then
		local p = io.popen(sep == "/" and "pwd" or "cd")
		local cwd = p and p:read("*l")
		if p then p:close() end
		while not ok and cwd and cwd ~= "" do
			ok  = try(cwd)
			cwd = cwd:match("^(.*)[/\\][^/\\]+$")
		end
	end
	assert(ok, "MapSource/Bootstrap.lua 를 못 찾았다.  이 PC 의 환경변수 "
	        .. "MAPSOURCE_CURDIR 에 MapSource 의 부모 디렉터리를 넣을 것.")
end
--dofile(Curdir.."MapSource\\MSF_UE_RE\\main.lua")

--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------


EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$"  then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_UE_RE\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_UE_RE\\"..dir))
		InitEXTLua()
     end
end
------------------------------------------------------------------------------------------------------------------------------


TestSet(0)
TestPMul=2
VerText = "\x04Ver. Beta. 0.98"
if Limit == 1 then
	VerText = VerText.."T"
	BossPhaseTestMode = 0
	
end
StatVer = 1
BossPhaseTestMode = 0
LimitVer = 14
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
StartCtrig(1,FP,nil,1,"C:\\Temp")
DP_Start_init(FP,{15,5000},0x4000, 0x6000)
-- [e3s 없이 빌드] EUD Editor 3 의 플러그인이 하던 일 (EUDEditorPort.lua 상단 표). 3초 대기 CIf 바깥 = 첫 프레임부터.
EUDEditorInit()          -- 첫 프레임 1회: dat 패치 773줄 + 정보창 함수 + 요구사항 풀
EUDEditorRequireTables() -- 매 프레임: 요구사항 오프셋 표 5종 (EUDinit.lua 의 PatchArrPrsv 가 3초 뒤부터 그 위를 덮는다)
EUDEditorButtonJump = def_sIndex()
CJump(AllPlayers,EUDEditorButtonJump)
	RegisterButtonSetData() -- 버튼셋 배열을 맵에 싣는다 (선언 전용 구역)
CJumpEnd(AllPlayers,EUDEditorButtonJump)
ApplyButtonSetData()     -- 첫 프레임 1회: buttonSetTable 에 연결
WriteStatTxtTbl()        -- 컴파일 때: stat_txt.tbl + 편집분 -> C:\euddraft0.9.2.0\MSF_UE_RE_stat_txt.tbl ([dataDumper] 가 싣는다)
NormalTurboSet(P8,214)
DoActions(P8,SetResources(Force1,Add,-1,Gas),1)
DoActions(Force1,SetDeaths(CurrentPlayer,SetTo,1,227),1)
DoActions(P8,{RemoveUnit(179,P12),RemoveUnit(71,P8),RemoveUnit(203,AllPlayers),RemoveUnit(204,AllPlayers),RemoveUnit(205,AllPlayers),RemoveUnit(206,AllPlayers),RemoveUnit(207,AllPlayers),RemoveUnit(208,AllPlayers),RemoveUnit(209,AllPlayers),RemoveUnit(211,AllPlayers),RemoveUnit(212,AllPlayers)})
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{Defeat()})
GiveT = {}
for i = 0, 6 do
	table.insert(GiveT,GiveUnits(1, 107, P12, 64, i))
	table.insert(GiveT,GiveUnits(1, 111, P12, 64, i))
	table.insert(GiveT,GiveUnits(All, 125, P12, 2+i, i))
end
DoActions(FP,GiveT,1)
for i = 0, 6 do
Trigger2(FP,{HumanCheck(i,0)},{RemoveUnit(125,i),RemoveUnit(107,i),RemoveUnit(111,i)})
end
	CIf(AllPlayers,ElapsedTime(AtLeast,3))
		init_func = def_sIndex()
		CJump(AllPlayers,init_func)
			Include_CtrigPlib(360,"Switch 100")
			Include_64BitLibrary("Switch 100")
			Include_CBPaint()
			Include_Wireframe(0) -- EUDEditorWireframe() 용 (EUD Editor 의 WireFrameDataEditor 대신)
			DUnitCalc = Install_EXCC(FP,25,1)
			LHPCunit = Install_EXCC(FP,25)
			Install_TMemoryBW(FP)
			Objects()
			HPoints()
			Var_init()
			Include_Conv_CPosXY(FP,{96*32,192*32})
			Install_GetCLoc(FP,0,nilunit)
			Install_CBullet()
			BlasterBullet = TStruct_init(FP,32,20,HumanPlayers)
			BoneBullet = TStruct_init(FP,200,20,HumanPlayers)
			Include_G_CB_Library(0x600,256,55,{Var_TempTable[2],Var_TempTable[3]},{TRepeatX,TRepeatY},G_CB_ShapeT,G_CB_LoopMaxT)
			DataInput()
			Install_CallTriggers()
		CJumpEnd(AllPlayers,init_func)
		-- 입력 동기화 (QCInput.lua). SNQC_LUA 판이면 여기서 트리거를 만든다. f_Read 등이 위 Include_CtrigPlib 를 요구해서
		-- 이 자리다. 받은 데스값을 읽는 아래 트리거들(BGMManager, OPTrig, SCRMSF_Exec ...)보다 앞이어야 한다.
		QCInput_Install()
		
		--CT_Prev()
		
		DoHumanCheck()
		BGMManager()
		onInit_EUD() -- onPluginStart
		EUDEditorWireframe() -- 유닛 121/211/212 와이어프레임 (Library 포인터가 채워진 뒤여야 해서 3초 대기 안)
		-- SCR_DB 오프라인 세이브 (SCA 대체, SCR_DB_MSF.lua). onInit_EUD 가 게임 시작 때 void 를 한 번
		-- 싹 지운 **뒤**여야 표지 블록이 살아남고, OPTrig(로비) 보다 앞이어야 불러오기 상태(데스 23)가
		-- 같은 프레임에 로비 화면에 보인다.
		SCRMSF_Init()
		SCRMSF_Exec()
		OPText() -- Opening Text
		MapPreserves()
		OPTrig()
		SetRecoverCp()
		RecoverCp(AllPlayers)
		CIf(AllPlayers,ElapsedTime(AtLeast,4))
			onInit_EUD2()
			Gun_System()
			Install_RandPlaceHero()
			SetWave()
			GameOver()
			ObDisplay()
			Install_SansBoss()
			LevelUp()
			PlayerInterface()
			LeaderBoardTFunc()
			Install_Roka7Boss()
			Install_IdenBoss()
			Install_DemBoss()
			Install_DLBoss()
			Install_Destr0yer()
		CIfEnd()
		NoAirCollisionX(FP)
	CIfEnd()
	--CT_Next()
	init_Setting()
	Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()


--속도측정용 2
--error(string.format("elapsed time: %.3f\n", os.clock() - x))