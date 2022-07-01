

-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
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
	TestMode=1
FP = P8
nilunit = 181
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
if LD2XOption == 1 then
	StartCtrig(1,FP,nil,1,"C:\\Temp")
else
	StartCtrig(1)
end
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Var_init()
	Include_64BitLibrary(RandSwitch2)
	Include_CtrigPlib(360,RandSwitch)
	Include_Conv_CPosXY(FP,{4096,4096})
	Include_CRandNum(FP)
	Install_GetCLoc(FP,0,nilunit)
	Install_BackupCP(FP)
	Install_UnitCount(FP)
	--Install_CallTriggers()
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