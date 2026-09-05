

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
--dofile(Curdir.."MapSource\\NewTestMap1\\main.lua")
----------------------------------------------Loader Space ---------------------------------------------------------------------
LD2XOption = 1
if LD2XOption == 1 then
	MapFolder = "NewTestMap1"
	Mapdir="C:\\euddraft0.9.2.0\\"..MapFolder
	__StringArray = {}
	__TRIGChkptr = io.open(Mapdir.."__TRIG.chk", "wb")
	Loader2XFName = "Loader.lua"
else
	Loader2XFName = "Loader2X.lua"
	MapFolder = "NewTestMap1"
end
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= Loader2XFName then
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

--TestSet(1)
--if Limit == 1 then
--else
--end

--VerText = "\x04Ver. Beta 0.9Z"
--if EVFFlag == 1 then
--	VerText = VerText.."T - EVF"
--end
VText = "ver.1.0"
	TestMode=1
FP = P8
nilunit = 181
EUDTurbo(FP)
SetForces({P1,P2,P3,P4},{P5,P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
if LD2XOption == 1 then
	StartCtrig(1,FP,nil,1,"C:\\Temp")
else
	StartCtrig(1)
end
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	LHPCunit = Install_EXCC(FP,3)
	Var_init()
	Include_64BitLibrary(RandSwitch2)
	Include_CtrigPlib(360,RandSwitch)
	Include_Conv_CPosXY(FP,{4096,4096})
	Include_CRandNum(FP)
	Install_GetCLoc(FP,0,nilunit)
	Install_BackupCP(FP)
	Install_UnitCount(FP)
	Install_CallTriggers()
CJumpEnd(AllPlayers,init_func)
init()
System()
Interface()
NoAirCollisionX(FP)
--Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()


if LD2XOption == 1 then
	__PopStringArray()
	io.close(__TRIGchkptr)
end