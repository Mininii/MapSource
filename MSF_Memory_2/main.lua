

-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_Memory_2\\main.lua")
----------------------------------------------Loader Space ---------------------------------------------------------------------

Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
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


TestSet(2)
VerText = "\x04Ver. Test"
FP = P8
nilunit = 181
EUDTurbo(FP)
SetForces({P1,P2,P3,P4},{P5,P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_PlayerCheck()
Trigger2(FP,{PlayerCheck(0,0),PlayerCheck(1,0),PlayerCheck(2,0),PlayerCheck(3,0),PlayerCheck(4,0)},{RotatePlayer({Defeat()},{Force2},FP)})
StartCtrig()

init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Var_init()
	Include_CtrigPlib(360,"Switch 100",1,FP)
	--Include_64BitLibrary("Switch 101",FP)
	Include_Conv_CPosXY(FP)
	Include_CRandNum(FP)
	Install_GetCLoc(FP,0,nilunit)
	Install_BackupCP(FP)
	install_UnitCount(FP)
	Install_EXCC(FP,0x2FFF,10)
	Install_CallTriggers()
CJumpEnd(AllPlayers,init_func)
init()
System()
--DoActions2(FP,PatchArrPrsv)
CIf(AllPlayers,ElapsedTime(AtLeast,2))
	init_Start()
--	Gun_System()
--	Operator_Trig()
--	Interface()
CIfEnd()

--Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()