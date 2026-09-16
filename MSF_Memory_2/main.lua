


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
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\MSF_Memory_2")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)


----------------------------------------------Loader Space ---------------------------------------------------------------------
LD2XOption = 1
if LD2XOption == 1 then
	Mapdir="C:\\euddraft0.9.2.0\\MSF_Memory2"
	__StringArray = {}
	__TRIGChkptr = io.open(Mapdir.."__TRIG.chk", "wb")
	Loader2XFName = "Loader.lua"
else
	Loader2XFName = "Loader2X.lua"
end
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= Loader2XFName then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_Memory_2\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_Memory_2\\"..dir))
		InitEXTLua()
     end
end

------------------------------------------------------------------------------------------------------------------------------
--ttt =  "ａ"
--tttt = "a"
--PushErrorMsg(""..string.byte(ttt, 1, 1).." "..string.byte(ttt, 2, 2).." "..string.byte(ttt, 3, 3).." "..string.byte(tttt, 1, 1))
TestSet(0)
	EVFFlag = 0
	AxiomSet = 1
	EternalTestMode = 0
	GBossTestMode = 0
	AtkSpeedMode = 0
if Limit == 1 then
	EVFFlag = 1
	AtkSpeedMode = 1
	CheatEnableFlag = 1
	TheoristTestMode = 0
	GBossTestMode = 1
	EEggTestNum = 0
	AxiomSet = 1
else
	CheatEnableFlag = 0
	EVFFlag = 0
end
RedMode = 1
if RedMode == 1 then
	VerText = "\x04Ver. 0.ZHR"
else
	VerText = "\x04Ver. 0.ZH"
end
if EVFFlag == 1 then
	VerText = VerText.." - EVF"
end
FP = P8
nilunit = 181
EUDTurbo(FP)
SetForces({P1,P2,P3,P4},{P5,P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0)},{RotatePlayer({Defeat()},{P5,P6,P7,P8},FP)})
StartCtrig(1,FP,nil,1,"C:\\Temp")
STRxIn(AllPlayers)

DP_Start_init(FP,nil,0x4000, 0x6000)
-- [e3s 없이 빌드] EUD Editor 3 의 플러그인이 하던 일 (EUDEditorPort.lua 상단 표). init() 보다 앞 = 첫 프레임부터.
EUDEditorInit()                -- 첫 프레임 1회: dat 패치 1182줄 + 정보창 함수 + 요구사항 풀
EUDEditorRequireTables(Force1) -- 매 프레임: 요구사항 오프셋 표 5종. Force1 = init() 의 PatchArrPrsv(Force1)가 같은 목록에서 뒤에 덮는다
WriteStatTxtTbl()              -- 컴파일 때: stat_txt.tbl + 편집분 -> C:\euddraft0.9.2.0\MSF_Memory2_stat_txt.tbl ([dataDumper] 가 싣는다)
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Var_init()
	Include_CtrigPlib(360,RandSwitch,1)
	--Include_64BitLibrary(RandSwitch2,FP)
	Include_Conv_CPosXY(FP,{4096,4096})
	Include_CRandNum(FP)
	Install_GetCLoc(FP,0,nilunit)
	Install_TMemoryBW(FP)
	Install_BackupCP(FP)
	Install_UnitCount(FP)
	Install_NukeLibrary()
	Include_CBulletLib()
	DUnitCalc = Install_EXCC(FP,20,1)
	UnivCunit = Install_EXCC(FP,10,{nil,{1,Subtract},{1,Subtract},{1,Subtract}})
	Install_f_Sqrd(FP)
	G_CA_MAX = 128
	if RedMode == 1 then G_CA_MAX = 256 end
	Include_G_CA_Library(0,0x600,G_CA_MAX)
	M2_Install_Shape()
	G_CAPlot2(G_CAPlot_Shape_InputTable)
	Install_Load_CAPlot()
	Install_Call_G_CA()
	G_CA_Lib_ErrorCheck()
	Install_CallTriggers()
	Include_GunData(128,55)
	
	Include_Wireframe(0)    -- EUDEditorWireframe() 용 (EUD Editor 의 WireFrameDataEditor 대신)
	RegisterButtonSetData() -- 버튼셋 배열을 맵에 싣는다 (f_GetFileArrptr = 선언 전용 구역)
CJumpEnd(AllPlayers,init_func)
ApplyButtonSetData()        -- 첫 프레임 1회: buttonSetTable 에 연결 (EUD Editor 의 onPluginStart 자리)
init()

--DoActions2(FP,PatchArrPrsv)
CIf(AllPlayers,ElapsedTime(AtLeast,3))
	EUDEditorWireframe() -- 와이어프레임 20줄 (Library 포인터가 채워진 뒤여야 해서 3초 대기 안)
	IBGM_EPDX(FP,3,Dt,nil,{12,14})
	init_Start()
	System()
	BossTrig()
	Opening()
	InputStory()
	LeaderBoardF()
	Operator_Trig()
	Interface()
	Sys2()
CIfEnd()

NoAirCollisionX(FP)
--Enable_HideErrorMessage(FP)
init_Setting()
STRxOut(AllPlayers)
EndCtrig()
LabelUseCheck()
ErrorCheck()
SetCallErrorCheck()


if LD2XOption == 1 then
	__PopStringArray()
	io.close(__TRIGchkptr)
	end