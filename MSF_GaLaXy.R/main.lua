
--dofile("C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\MapSource\\MSF_GaLaXy.2\\Gal.2.lua")

--X2_Mode = 0
-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_GaLaXy.R\\main.lua")
----------------------------------------------Loader Space ---------------------------------------------------------------------
LD2XOption = 1
if LD2XOption == 1 then
	if X2_Mode == 1 then
		Mapdir="C:\\euddraft0.9.2.0\\MSF_GaLaXy_R_2X"
	else
		Mapdir="C:\\euddraft0.9.2.0\\MSF_GaLaXy.R"
	end 
	MapFolder = "MSF_GaLaXy.R"
	__StringArray = {}
	__TRIGChkptr = io.open(Mapdir.."__TRIG.chk", "wb")
	Loader2XFName = "Loader.lua"
else
	Loader2XFName = "Loader2X.lua"
	MapFolder = "MSF_GaLaXy.R"
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


DoActions(P8,SetResources(Force1,Add,-1,Gas),1)
DoActions(Force1,SetDeaths(CurrentPlayer,SetTo,1,227),1)
TestSet(0)
Test=""
if Limit == 1 then Test="T" end
if X2_Mode == 1 then
	VName = "3.0_2X"..Test
	MapSize = {256*32,256*32}
else
	VName = "2.4"..Test
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

Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()

Trigger2X(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFF,0x0,0,0),Defeat()})


if LD2XOption == 1 then
	__PopStringArray()
	io.close(__TRIGchkptr)
end