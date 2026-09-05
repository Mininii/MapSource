

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
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\MSF_GaLaXy.R")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)
----------------------------------------------Loader Space ---------------------------------------------------------------------

X2_Mode = 1
X2_Map = 0
LD2XOption = 1

MapFolder = "MSF_GaLaXy.R"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\"..MapFolder.."\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\"..MapFolder.."\\"..dir))
		InitEXTLua()
     end
end



------------------------------------------------------------------------------------------------------------------------------


DoActions(P8,SetResources(Force1,Add,-1,Gas),1)
DoActions(Force1,SetDeaths(CurrentPlayer,SetTo,1,227),1)
TestSet(0)
VNum = "4.4"

AutoSettingMode = false

Test=""
if Limit == 1 then Test="T" end
RMode = 1
if Limit == 1 then
	RMode = 1
end
if X2_Map == 1 or X2_Mode == 1 then
	VName = VNum.."_2X"..Test
end
if X2_Map == 1 then
	MapSize = {256*32,256*32}
else
	MapSize = {128*32,128*32}
end
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
StartCtrig(1,FP,nil,1,"C:\\Temp")
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Include_CtrigPlib(360,"Switch 100")
	Source()
	DUnitCalc = Install_EXCC(FP,15,1)
	Include_CRandNum(FP)
	Install_CallTriggers()
	Install_GetCLoc(FP,0,nilunit)
	Include_Conv_CPosXY(FP,MapSize)
	Include_G_CA_Library(4,0x600,32)
	G3_Install_Shape()
	G_CAPlot2(G_CAPlot_Shape_InputTable)
	Install_Load_CAPlot()
	Install_Call_G_CA()
	G_CA_Lib_ErrorCheck()
	Include_GunData(64,55)
	init()
CJumpEnd(AllPlayers,init_func)

DP_Start_init(FP)
onInit_EUD()
DoActions2(AllPlayers,PatchArrPrsv)
--DoActionsX(FP,{SetCtrigX("X",IndexAlloc,0x158,0,SetTo,"X",IndexAlloc,0x4,1,0),SetCtrig1X("X",IndexAlloc,CAddr("CEPD",2),0,SetTo,EPD(0x58D6F8)),SetCtrigX("X",IndexAlloc,0x15C,0,SetTo,"X",IndexAlloc,0x0,0,1)})
CIfOnce(FP)
CIfEnd()
NIf(FP,ElapsedTime(AtLeast,3))
	OPTrig()
	onInit_EUD2()
	Gun_System()
	Operator_Trig()
	Waves()
	Interface()
	CreateUnitQueue()
	LeaderBoardF()
NIfEnd()
init_Setting()
if Limit == 0 then
	Enable_HideErrorMessage(FP)
end

Trigger2X(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFF,0x0,0,0),Defeat()})
--	
--if Limit == 1 then
--	for i = 0, 6 do
--		Trigger2X(FP,{CD(Emer_EscapeC[i+1],1),LocalPlayerID(i),KeyPress("ESC", "Down"),KeyPress("ENTER", "Down")},{SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFF,0x0,0,0),Defeat(),RotatePlayer({Victory()},MapPlayers,FP)})
--	end
--	for i = 128, 131 do
--		Trigger2X(FP,{LocalPlayerID(i),KeyPress("ESC", "Down"),KeyPress("ENTER", "Down")},{SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFF,0x0,0,0),Defeat(),RotatePlayer({Victory()},MapPlayers,FP)})
--	end
--end
if RMode == 1 then
	NoAirCollisionX(FP)
end

EndCtrig()
ErrorCheck()
SetCallErrorCheck()
