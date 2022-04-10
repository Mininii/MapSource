
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
X2_Mode = 1
if X2_Mode == 1 then
	VName = "1.7_2X"
else
	VName = "1.7"
end
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{Defeat()})
StartCtrig(1,FP,nil,1)
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Include_CtrigPlib(360,"Switch 100")
	Source()
	DUnitCalc = Install_EXCC(FP,15,1)
	Install_CallTriggers()
	Install_GetCLoc(FP,0,nilunit)
	Include_Conv_CPosXY(FP)
	Include_CRandNum(FP)
	Include_G_CA_Library(4,0x600,32,STRCTRIGASM)
	G3_Install_Shape()
	G_CAPlot2(G_CAPlot_Shape_InputTable)
	Install_Load_CAPlot()
	Install_Call_G_CA()
	G_CA_Lib_ErrorCheck()
	Include_GunData(64,55)
	init()
CJumpEnd(AllPlayers,init_func)
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
	LeaderBoardF()
NIfEnd()

Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()