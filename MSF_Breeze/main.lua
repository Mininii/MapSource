
-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\MSF_Breeze")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)
--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------


--Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$"  then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_Breeze\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_Breeze\\"..dir))
		InitEXTLua()
     end
end
------------------------------------------------------------------------------------------------------------------------------

VerText = "\x04Ver. 1.1"

TestSet(0)
if Limit == 1 then
	VerText = VerText.."T"
	
end
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{Defeat()})
StartCtrig(1,FP,nil,1,"C:\\Temp")
DP_Start_init(FP)
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	DUnitCalc = Install_EXCC(FP,15,1)
	Include_CtrigPlib(360,"Switch 100")
	Install_BackupCP(FP)
	Include_CBPaint()
	Include_Vars()
	Include_Conv_CPosXY(FP,{96*32,64*32})
	Install_GetCLoc(FP,0,nilunit)
	Include_CRandNum(FP)
	Include_G_CA_Library(2,0x600,32)
	Shape()

	S_3 = G_CAPlot(S_3_ShT)
	S_4 = G_CAPlot(S_4_ShT)
	S_5 = G_CAPlot(S_5_ShT)
	S_6 = G_CAPlot(S_6_ShT)
	S_7 = G_CAPlot(S_7_ShT)
	S_8 = G_CAPlot(S_8_ShT)
	P_3 = G_CAPlot(P_3_ShT)
	P_4 = G_CAPlot(P_4_ShT)
	P_5 = G_CAPlot(P_5_ShT)
	P_6 = G_CAPlot(P_6_ShT)
	P_7 = G_CAPlot(P_7_ShT)
	P_8 = G_CAPlot(P_8_ShT)
	Cir = G_CAPlot(Cir)
	if #G_CAPlot_Shape_InputTable >= 256 then
		PushErrorMsg("G_CAPlot_Shape_InputTable_is_Full")
	end
	G_CAPlot2(G_CAPlot_Shape_InputTable)
	
Install_Load_CAPlot()
Install_Call_G_CA()
G_CA_Lib_ErrorCheck()
	

CJumpEnd(AllPlayers,init_func)

onInit_EUD() -- onPluginStart


Interface()
System()
Waves()

init_Setting()
if Limit == 0 then
	Enable_HideErrorMessage(FP)
end

EndCtrig()
LabelUseCheck()
ErrorCheck()
SetCallErrorCheck()
