
--dofile("C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\MapSource\\MSF_GaLaXy.2\\Gal.2.lua")

-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_GaLaXy.R\\main.lua")
----------------------------------------------Loader Space ---------------------------------------------------------------------

EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_GaLaXy.R\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_GaLaXy.R\\"..dir))
		InitEXTLua()
     end
end

------------------------------------------------------------------------------------------------------------------------------


DoActions(P8,SetResources(Force1,Add,-1,Gas),1)
DoActions(Force1,SetDeaths(CurrentPlayer,SetTo,1,227),1)
TestSet(1)
VerText = "\x04Ver. Test"
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_PlayerCheck()
Trigger2(FP,{PlayerCheck(0,0),PlayerCheck(1,0),PlayerCheck(2,0),PlayerCheck(3,0),PlayerCheck(4,0),PlayerCheck(5,0),PlayerCheck(6,0)},{Defeat()})
StartCtrig()

init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Include_CtrigPlib(360,"Switch 100",1,FP)
	Source()
	DUnitCalc = Install_EXCC(FP,15,1)
	Install_CallTriggers()
	Install_GetCLoc(FP,0,nilunit)
	Include_Conv_CPosXY(FP)
	Include_CRandNum(FP)
	Include_GunData(64,55)
	Include_G_CA_Library(4,0x600,128)
	G3_Install_Shape()
	G_CAPlot2(G_CAPlot_Shape_InputTable)
	Install_Load_CAPlot()
	Install_Call_G_CA()
	G_CA_Lib_ErrorCheck()
	init()
CJumpEnd(AllPlayers,init_func)
onInit_EUD()
DoActions2(AllPlayers,PatchArrPrsv)
CIf(AllPlayers,ElapsedTime(AtLeast,2))
	onInit_EUD2()
	Gun_System()
	Operator_Trig()
	Waves()
	Interface()
	LeaderBoardF()
	OPTrig()
CIfEnd()

Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()