

-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_Memory_2\\main.lua")
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

TestSet(1)
	EVFFlag = 0
	CheatEnableFlag = 0
if Limit == 1 then
	EVFFlag = 0
	CheatEnableFlag = 0
	TheoristTestMode = 0
	GBossTestMode = 1
	EEggTestNum = 20
else
	EVFFlag = 0
end
RedMode = 0
if RedMode == 1 then
	VerText = "\x04Ver. Test"
else
	VerText = "\x04Ver. Test"
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
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Var_init()
	Include_CtrigPlib(360,RandSwitch)
	--Include_64BitLibrary(RandSwitch2,FP)
	Include_Conv_CPosXY(FP,{4096,4096})
	Include_CRandNum(FP)
	Install_GetCLoc(FP,0,nilunit)
	Install_TMemoryBW(FP)
	Install_BackupCP(FP)
	Install_UnitCount(FP)
	Install_NukeLibrary()
	Include_CBulletLib()
	DUnitCalc = Install_EXCC(FP,15,1)
	UnivCunit = Install_EXCC(FP,10,{nil,{1,Subtract},{1,Subtract},{1,Subtract}})
	Install_f_Sqrd(FP)
	Include_G_CA_Library(0,0x600,128)
	M2_Install_Shape()
	G_CAPlot2(G_CAPlot_Shape_InputTable)
	Install_Load_CAPlot()
	Install_Call_G_CA()
	G_CA_Lib_ErrorCheck()
	Install_CallTriggers()
	Include_GunData(128,55)
	
CJumpEnd(AllPlayers,init_func)
init()

--DoActions2(FP,PatchArrPrsv)
CIf(AllPlayers,ElapsedTime(AtLeast,3))
	IBGM_EPDX(FP,3,Dt,nil,{12,14})
	init_Start()
	System()
	Opening()
	InputStory()
	LeaderBoardF()
	Operator_Trig()
	Interface()
	BossTrig()
	Sys2()
CIfEnd()

NoAirCollisionX(FP)
--Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()


if LD2XOption == 1 then
	__PopStringArray()
	io.close(__TRIGchkptr)
	end