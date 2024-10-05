
-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\MEME_EUD_Project")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)
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

EXTLUA = "dir \""..Curdir.."\\MapSource\\MEME_EUD_Project\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MEME_EUD_Project\\"..dir))
		InitEXTLua()
     end
end
------------------------------------------------------------------------------------------------------------------------------
--PushErrorMsg(string.byte("	"))
math.randomseed(322,322)

TestSet(2)
FP = P6
SetForces({P1,P2,P3,P4,P5},{P7,P8},{P6},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
StartCtrig(1,FP,nil,1,"C:\\Temp")
Enable_HumanCheck()
STRxIn(AllPlayers)
NormalTurboSet(FP,214)
EUDTurbo(FP)
DP_Start_init(FP)
init_func = def_sIndex()
CJump(AllPlayers,init_func)

Include_CtrigPlib(360,"Switch 100")
Install_BackupCP(FP)
Include_CBPaint()
Vars()
Install_GetCLoc(FP,104,nilunit)
Include_Conv_CPosXY(FP,{128*32,128*32})
Install_BackupCP(FP)
Include_CRandNum(FP)
Include_G_CB_Library(22,0x600,128)



CJumpEnd(AllPlayers,init_func)
P1MCur = CreateVar(FP)
P1MPrev = CreateVar(FP)
P1MValue = CreateVar(FP)
CRead(P1,V(P1MCur[2],FP),0x58A364) 
CSub(P1,V(P1MValue[2],FP),V(P1MCur[2],FP),V(P1MPrev[2],FP)) -- V(8)에 추가된 마린 데스값을 저장함



OnInit()
Interface()
CIf(AllPlayers,NTCond())
for i = 0,7  do
	DoActions(i,{SetMemory(0x6509B0, SetTo, i)}) -- CP 정상화
end
MEME_ClassicTrig()
CIfEnd()
GunTrig()
--G_CB_TSetSpawn({}, {88}, {CSMakePolygon(6, 128, 0, PlotSizeCalc(6, 5), 0)},P8,"CD48",1,{RepeatType=2}) -- 건작엔진 틀



Create_G_CB_Arr()



--PushErrorMsg(G_CB_ShNm)

init_func2 = def_sIndex()
CJump(AllPlayers,init_func2)
G_CBPlot()
CJumpEnd(AllPlayers,init_func2)
init_Setting()
--if Limit == 0 then
--	Enable_HideErrorMessage(FP)
--end




CRead(P8,V(P1MPrev[2],FP),0x58A364)
STRxOut(AllPlayers)

EndCtrig()
LabelUseCheck()
ErrorCheck()
SetCallErrorCheck()
