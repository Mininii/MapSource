
-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\MSF_Respect_V")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)
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

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_Respect_V\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_Respect_V\\"..dir))
		InitEXTLua()
     end
end
------------------------------------------------------------------------------------------------------------------------------
--PushErrorMsg(string.byte("	"))
math.randomseed(322,322)
VerText = "\x04Ver. 0.1"
EVFPtsMul = 2
EVFMode = 1
TestSet(0)
FP = P8
SetForces({P1,P2,P3,P4,P5},{P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
StartCtrig(1,FP,nil,1,"C:\\Temp")
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0)},{Defeat()})
Trigger2(P7,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0)},{Defeat()})
Trigger2(P6,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0)},{Defeat()})
STRxIn(AllPlayers)
NormalTurboSet(FP,214)
EUDTurbo(FP)
DoActions(Force1,SetDeaths(CurrentPlayer,SetTo,1,227),1)
DP_Start_init(FP)
init_func = def_sIndex()
CJump(AllPlayers,init_func)
	DUnitCalc = Install_EXCC(FP,15,1)
	--PushErrorMsg("0x"..string.format("%X",FuncAlloc))
	UnivCunit = Install_EXCC(FP,15,{nil,{1,Subtract},{1,Subtract},{1,Subtract}})
	Include_CtrigPlib(360,"Switch 100")
	Include_Vars()
	Install_BackupCP(FP)
	Include_CBPaint()
	Include_Conv_CPosXY(FP,{64*32,256*32})
	Install_GetCLoc(FP,0,nilunit)
	Include_CRandNum(FP)
	Install_CallTriggers()
	Shape()
	Include_G_CB_Library(6,0x600,128)
	Include_GunData(128,55)
	G_CBPlot()
CJumpEnd(AllPlayers,init_func)
NoAirCollisionX(FP)






onInit_EUD() -- onPluginStart
Interface()
System()
CreateUnitQueue()
--Waves()

--PushErrorMsg(G_CB_ShNm)


init_Setting()
if Limit == 0 then
	Enable_HideErrorMessage(FP)
end



STRxOut(AllPlayers)

EndCtrig()
LabelUseCheck()
ErrorCheck()
SetCallErrorCheck()
