

-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\St	ormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_Memory_2\\main.lua")
----------------------------------------------Loader Space ---------------------------------------------------------------------

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


TestSet(0)
VerText = "\x04Ver. Beta 0.5F"
FP = P8
nilunit = 181
EUDTurbo(FP)
SetForces({P1,P2,P3,P4},{P5,P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_PlayerCheck()
Trigger2(FP,{PlayerCheck(0,0),PlayerCheck(1,0),PlayerCheck(2,0),PlayerCheck(3,0)},{RotatePlayer({Defeat()},{P5,P6,P7,P8},FP)})
StartCtrig()
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Var_init()
	Include_CtrigPlib(360,RandSwitch,1,FP)
	--Include_64BitLibrary(RandSwitch2,FP)
	Include_Conv_CPosXY(FP)
	Include_CRandNum(FP)
	Install_GetCLoc(FP,0,nilunit)
	Install_TMemoryBW(FP)
	Install_BackupCP(FP)
	Install_UnitCount(FP)
	DUnitCalc = Install_EXCC(FP,15,1)
	UnivCunit = Install_EXCC(FP,10,{nil,{1,Subtract},{1,Subtract},{1,Subtract}})
	Install_f_Sqrd(FP)
	Include_G_CA_Library(0,0x600,256)
	M2_Install_Shape()
	if #G_CAPlot_Shape_InputTable >= 256 then
		PushErrorMsg("G_CAPlot_Shape_InputTable_is_Full")
	end
	G_CAPlot2(G_CAPlot_Shape_InputTable)
	Install_Load_CAPlot()
	Install_Call_G_CA()
	G_CA_Lib_ErrorCheck()
	Install_CallTriggers()
	Include_GunData(128,55)
	
CJumpEnd(AllPlayers,init_func)
NoAirCollisionX(FP)
init()
IBGM_EPDX(FP,3,Dt,nil,{12,14})
--DoActions2(FP,PatchArrPrsv)
CIf(AllPlayers,ElapsedTime(AtLeast,3))
	init_Start()
	System()
	Opening()
	LeaderBoardF()
	Operator_Trig()
	Interface()
	InputStory()
	BossTrig()
CIfEnd()

--Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()