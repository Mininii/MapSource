

-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\MSF_GaLaXy.2_R")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)

EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end
EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_GaLaXy.2\\\" /b"
for dir in io.popen(EXTLUA):lines() do 
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_GaLaXy.2_R\\"..dir))
		InitEXTLua()
     end
end
FP = P8
DoActions(FP,{RemoveUnit(205,FP)})
Trigger2(Force2,{Command(CurrentPlayer,AtLeast,10,42)},{KillUnitAt(1,42,"Anywhere",CurrentPlayer)},{preserved})
Trigger2(Force2,{Command(CurrentPlayer,AtLeast,20,35)},{KillUnit(35,CurrentPlayer)},{preserved})
Trigger2(Force2,{Command(CurrentPlayer,AtLeast,20,37)},{RemoveUnitAt(1,37,64,CurrentPlayer)},{preserved})
DoActions(Force1,{SetDeaths(CurrentPlayer,SetTo,1,217)},1)
HumanPlayers = {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}
MapPlayers = {P1,P2,P3,P4,P5,P6}
SetForces(MapPlayers,{P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
UnitNamePtr = 0x591000 -- i * 0x20
TestStart = 0
Limit = 0
GunSafety = 0
VName = "Ver:HD 1.5"
SetFixedPlayer(FP)
StartCtrig(1,FP,nil,1)
DP_Start_init(FP)
onInit()
DoActions2(FP,PatchArr)
DoActions2(FP,PatchArr2,1)
DoActions2(FP,PatchArr3,1)
DoActions2(FP,DefTypePatch,1)
DoActions2(FP,DefTypePatchforZerg,1)
DoActions2(FP,AtkTypePatch,1)
DoActions2(FP,CreateSpeedPatch,1)
DoActions2(FP,ZergGroupFlagsPatch,1)
DoActions2(FP,UnitDefPatch,1)
DoActions2(FP,DefIgnorePatch,1)
DoActions2(FP,NonBionicPatch,1)
DoActions2(FP,ButtonSetPatch,1)
table.insert(CtrigInitArr[7],SetCtrigX(FP,G_InputH[2],0x15C,0,SetTo,FP,0x500,0x15C,1,0))
DoActions(FP,{
SetInvincibility(Disable,"Mineral Field (Type 1)",11,64),
SetInvincibility(Disable,"Mineral Field (Type 2)",11,64),
SetInvincibility(Disable,"Mineral Field (Type 3)",11,64),
SetInvincibility(Disable,219,11,64),
SetInvincibility(Disable,"Vespene Geyser",11,64),
SetInvincibility(Disable,"Young Chrysalis",Force2,64)
},1)

Enable_HumanCheck()
InitJump = def_sIndex()
CJump(AllPlayers,InitJump) -- 트리거 가둬놓는곳
Objects()
Include_CtrigPlib(360,RandSwitch)
Include_Conv_CPosXY(FP,{128*32,128*32})
nilunit = 181
Install_GetCLoc(FP,253,nilunit)
Include_CRandNum(FP)


Var_InputCVar = {}
Var_Lines = 55
Var_TempTable = CreateVarArr(Var_Lines,FP)
for i = 1, Var_Lines do
	table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
end


GunLocPos_CallIndex = SetCallForward()
SetCall(FP)
CDoActions(FP,{
TSetMemory(0x58DC60 + 0x14*0,SetTo,_Add(Gun_X,Var_TempTable[2])),
TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(Gun_X,Var_TempTable[2])),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Add(Gun_Y,Var_TempTable[3])),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(Gun_Y,Var_TempTable[3]))
})
SetCallEnd()

Call_SaveCP = SetCallForward()
SetCall(FP)
SaveCp(FP,BackupCP)
SetCallEnd()

Call_LoadCP = SetCallForward()
SetCall(FP)
LoadCp(FP,BackupCP)
SetCallEnd()

Call_UnitIDV = SetNextForward()
SetCall(FP)
CDoActions(FP,{TCreateUnit(1, UnitIDV, 1, _Add(_Mod(_Rand(),2),_Mov(6)))})
SetCallEnd()

RepHeroCallIndex = SetCallForward()
SetCall(FP)

NWhile(FP,{TBring(6,AtLeast,1,RepHeroIndex,64)})
CDoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,0),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,0),TMoveLocation(1,RepHeroIndex,6,64),TGiveUnits(1,RepHeroIndex,6,1,8),TRemoveUnit(RepHeroIndex,8)})
CMov(FP,0x6509B0,RepUnitPtr)
NWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
CAdd(FP,0x6509B0,1)
NWhileEnd()
f_SaveCp()
f_Read(FP,0x58DC60,RepX,"X",0xFFF)
f_Read(FP,0x58DC64,RepY,"X",0xFFF)
CDoActions(FP,{TSetMemoryX(BackupCp,SetTo,RepX,0xFFF),TSetMemoryX(BackupCp,SetTo,_Mul(RepY,_Mov(0x1000)),0xFFF000),TSetMemoryX(BackupCp,SetTo,_Mul(RepHeroIndex,_Mov(0x1000000)),0xFF000000)})
NWhileEnd()
SetCallEnd()

Call_ZergSpawnSet_Lair = SetNextForward()
SetCall(FP)
CDoActions(FP,{TCreateUnit(1, VArr(ZUnitLairArr,_Mod(_Rand(),_Mov(4))), 1, _Add(_Mod(_Rand(),_Mov(2)),_Mov(6)))})
SetCallEnd()

Call_ZergSpawnSet_Hive = SetNextForward()
SetCall(FP)
CDoActions(FP,{TCreateUnit(1, VArr(ZUnitHiveArr,_Mod(_Rand(),_Mov(4))), 1, _Add(_Mod(_Rand(),_Mov(2)),_Mov(6)))})
SetCallEnd()


GunTempSave_CallIndex = SetCallForward()
SetCall(FP)
f_SaveCp()
CMov(FP,Gun_Temp,0)
CMov(FP,Gun_TempPos,0)
f_Read(FP,BackupCP,Gun_Temp)
f_Read(FP,_Sub(BackupCP,1),Gun_TempPos)
CMov(FP,Gun_TempPosX,_Mov(Gun_TempPos,0xFFF))
CMov(FP,Gun_TempPosY,_Div(_Mov(Gun_TempPos,0xFFF0000),_Mov(0x10000)))
CMov(FP,Gun_A,_Div(_Mov(Gun_Temp,0xFF00),_Mov(0x100)))
CMov(FP,Gun_R,_Div(_Mov(Gun_Temp,0x7FFF0000),_Mov(0x10000)))
CMov(FP,Gun_Level,_Div(_Mov(Gun_Temp,0xFF0000),_Mov(0x10000)))
CMov(FP,Gun_V,Gun_Temp,"X",0xFF)
SetCallEnd()


Call_CBullet = SetCallForward()
SetCall(FP)
NIf(FP,Memory(0x628438,AtLeast,1))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)

CIf(FP,{TTOR({CVar(FP,CBX[2],AtLeast,1),CVar(FP,CBY[2],AtLeast,1)})})

CDoActions(FP,{
TSetMemory(0x58DC60 + 0x14*0,SetTo,CBX),
TSetMemory(0x58DC68 + 0x14*0,SetTo,CBX),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Add(CBY,10)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CBY,10)),
})
CIfEnd()
CDoActions(FP,{
	TSetMemoryX(0x66321C, SetTo, CBHeight,0xFF);
	CreateUnit(1, 204, 1, FP),
	TSetMemory(_Add(Nextptrs,25),SetTo,CBUnitId)
})
f_Read(FP,_Add(Nextptrs,10),Locs)
CDoActions(FP,{
	TSetMemoryX(_Add(Nextptrs,22),SetTo,Locs,0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,8),SetTo,_Mul(CBAngle,_Mov(256)),0xFF00),
	TSetMemoryX(_Add(Nextptrs,19),SetTo,135*256,0xFF00),
	TSetMemoryX(_Add(Nextptrs,68),SetTo,30,0xFFFF),
})
NIfEnd()
SetCallEnd()

Call_SetBulletXY = SetCallForward()
SetCall(FP)
NIf(FP,Memory(0x628438,AtLeast,1))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
local Cur_CBulletArr = CreateVar(FP)

local CBullet_ArrCheck = def_sIndex()

CMov(FP,Cur_CBulletArr,0)
CJumpEnd(FP,CBullet_ArrCheck)
CAdd(FP,CBullet_ArrTemp,CBullet_InputH,Cur_CBulletArr)

CIf(FP,{TTOR({CVar(FP,CBX[2],AtLeast,1),CVar(FP,CBY[2],AtLeast,1)})})

CDoActions(FP,{
TSetMemory(0x58DC60 + 0x14*0,SetTo,CBX),
TSetMemory(0x58DC68 + 0x14*0,SetTo,CBX),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Add(CBY,10)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CBY,10)),
})
CIfEnd()

NIfX(FP,{TMemory(CBullet_ArrTemp,AtMost,0)})
CDoActions(FP,{
	TSetMemoryX(0x66321C, SetTo, CBHeight,0xFF),
	CreateUnit(1, 204, 1, FP),
	TSetMemoryX(_Add(Nextptrs,25),SetTo,CBUnitId,0xFF),
})
CDoActions(FP,{
	TSetMemoryX(_Add(Nextptrs,22),SetTo,_Add(BPosX,_Mul(BPosY,_Mov(65536))),0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,19),SetTo,135*256,0xFF00),
	TSetMemoryX(_Add(Nextptrs,68),SetTo,30,0xFFFF),
	TSetMemoryX(CBullet_ArrTemp,SetTo,Nextptrs,0xFFFFFFFF),
	TSetMemoryX(_Add(CBullet_ArrTemp,0x20/4),SetTo,1,0xFFFFFFFF),
})

NElseIfX({CVar(FP,Cur_CBulletArr[2],AtMost,((0x970/4)*126))})
CAdd(FP,Cur_CBulletArr,0x970/4)
CJump(FP,CBullet_ArrCheck)
NElseX()

DoActions2(FP,{RotatePlayer({DisplayTextX(CBulletErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()

NIfEnd()
SetCallEnd()


Call_CBulletA = SetCallForward()
SetCall(FP)
CIf(FP,{CVar(FP,TempEPD[2],AtLeast,19025),CVar(FP,TempEPD[2],AtMost,19025+(84*1699))})

--CIf(FP,CVar(FP,AngleA[2],AtLeast,1*256))
--CDoActions(FP,{TSetMemory(_Add(CB_TempH,0x40/4),SetTo,AngleA)})
--CIfEnd()
CIfX(FP,CVar(FP,TempT[2],Exactly,0))
f_Read(FP,_Add(TempEPD,8),AngleA,nil,0xFF00)
f_Read(FP,_Add(TempEPD,10),LocsA)
CDoActions(FP,{
	TSetMemoryX(_Add(TempEPD,4),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,6),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,7),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,22),SetTo,LocsA,0xFFFFFFFF),
	TSetMemoryX(_Add(TempEPD,8),SetTo,_Add(AngleA,32768),0xFF00),
	TSetMemoryX(_Add(TempEPD,19),SetTo,135*256,0xFF00),
	TSetMemoryX(CB_TempH,SetTo,0,0xFFFFFFFF)})
CIfEnd()
CElseX()
CDoActions(FP,{TSetMemory(_Add(CB_TempH,0x20/4),Subtract,1)})
CIfXEnd()

SetCallEnd()


Call_CBullet_PosCalc = SetCallForward()
SetCall(FP)
NIf(FP,Memory(0x628438,AtLeast,1))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
CDoActions(FP,{TSetMemoryX(0x66321C, SetTo, CBHeight,0xFF)})
CDoActions(FP,{
	TSetMemory(0x58DC60 + 0x14*0,Add,CBX),
	TSetMemory(0x58DC68 + 0x14*0,Add,CBX),
	TSetMemory(0x58DC64 + 0x14*0,Add,_Add(CBY,10)),
	TSetMemory(0x58DC6C + 0x14*0,Add,_Add(CBY,10)),
	CreateUnit(1, 204, 1, FP),
	TSetMemoryX(_Add(Nextptrs,25),SetTo,CBUnitId,0xFF),
})
f_Read(FP,_Add(Nextptrs,10),Locs)
CDoActions(FP,{
	TSetMemoryX(_Add(Nextptrs,22),SetTo,Locs,0xFFFFFFFF),
	TSetMemoryX(_Add(Nextptrs,8),SetTo,_Mul(CBAngle,_Mov(256)),0xFF00),
	TSetMemoryX(_Add(Nextptrs,19),SetTo,135*256,0xFF00),
	TSetMemoryX(_Add(Nextptrs,68),SetTo,30,0xFFFF),
})
NIfEnd()
SetCallEnd()


Include_G_CA_Library("Location 2",6,0x600,256)
Install_Shape()

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

if #G_CAPlot_Shape_InputTable >= 256 then
	PushErrorMsg("G_CAPlot_Shape_InputTable_is_Full")
end

G_CAPlot2(G_CAPlot_Shape_InputTable)
Install_Load_CAPlot()
Install_Call_G_CA()
GunData()
G_CA_Lib_ErrorCheck()
CJumpEnd(AllPlayers,InitJump)
NoAirCollisionX(FP)





VArrPatchTable ={}
CIfOnce(FP,Always()) -- onPluginStart
GiveUnitsArr = {}
GiveT = {}
for i = 0, 5 do
	table.insert(GiveT,GiveUnits(1, 107, P12, 64, i))
	table.insert(GiveT,GiveUnits(1, 111, P12, 64, i))
end
table.insert(GiveT,Simple_SetLoc(0,3827,3690,3827+1,3690+1))
table.insert(GiveT,GiveUnits(2, 125, P12, 1, P6))
table.insert(GiveT,Simple_CalcLoc(0,0,32,0,32))
table.insert(GiveT,GiveUnits(2, 125, P12, 1, P3))
table.insert(GiveT,Simple_CalcLoc(0,0,32,0,32))
table.insert(GiveT,GiveUnits(2, 125, P12, 1, P4))
table.insert(GiveT,Simple_CalcLoc(0,0,32,0,32))
table.insert(GiveT,GiveUnits(2, 125, P12, 1, P1))
table.insert(GiveT,Simple_CalcLoc(0,0,32,0,32))
table.insert(GiveT,GiveUnits(2, 125, P12, 1, P5))
table.insert(GiveT,Simple_CalcLoc(0,0,32,0,32))
table.insert(GiveT,GiveUnits(2, 125, P12, 1, P2))

DoActions(FP,GiveT)
for i = 0, 5 do
Trigger2(FP,{HumanCheck(i,0)},{RemoveUnit(125,i),RemoveUnit(107,i),RemoveUnit(111,i)})
end

VoidAreaOffset = 0x590010
VoidAreaAlloc = 0x590010-4
local VoidResetTable = {}
for i = 0, 2000 do
table.insert(VoidResetTable,(SetVoid(i,SetTo,0)))
end
DoActions2(FP,VoidResetTable)
--TMem(FP,GunPtrMemory,GunPtrMemoryVO)
--TMem(FP,RepUnitPtr,RepUnitPtrVO)
CMov(FP,GunPtrMemory,EPDF(0x590010))
CMov(FP,RepUnitPtr,EPDF(0x590010+(4*20)))

for i = 1, #HeroIndexArr do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
	},
	actions = {
		SetCVar(FP,RepHeroIndex[2],SetTo,HeroIndexArr[i]);
		SetNext("X",RepHeroCallIndex,0);
		SetNext(RepHeroCallIndex+1,"X",1);
	}
}
end

DoActions2(FP,SizePatchArr,1)

for i = 0, 5 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		HumanCheck(i,1);
		},
	actions = {
		SetCVar(FP,SetPlayers[2],Add,1);
		
		}
		}
end
for i = 0, 29 do
	local UnitTable3 = {3,8,10,17,19,21,23,25,28,29,52,57,61,63,65,66,67,68,71,75,76,77,78,79,80,81,86,88,98,102}
table.insert(VArrPatchTable,SetVArrayX(VArr(UArr3,i),"Value",SetTo,UnitTable3[i+1]))

end

for i = 0, 3 do
	local ZergUnitLair = {54, 53, 40, 39}
	local ZergUnitHive = {48, 51, 104, 53}
table.insert(VArrPatchTable,SetVArrayX(VArr(ZUnitLairArr,i),"Value",SetTo,ZergUnitLair[i+1]))
table.insert(VArrPatchTable,SetVArrayX(VArr(ZUnitHiveArr,i),"Value",SetTo,ZergUnitHive[i+1]))
end

for i = 0, 15 do
	local UnitTable = {10,17,19,21,25,28,29,3,8,17,21,28,52,57,23,102}
	local UnitTable2 = {63,65,66,67,75,76,77,78,79,88,86,81,80,98,74,75}
table.insert(VArrPatchTable,SetVArrayX(VArr(UArr1,i),"Value",SetTo,UnitTable[i+1]))
table.insert(VArrPatchTable,SetVArrayX(VArr(UArr2,i),"Value",SetTo,UnitTable2[i+1]))
end


table.insert(VArrPatchTable,SetCVar(FP,HPointVar[2],SetTo,HPointFactor))
table.insert(VArrPatchTable,SetCVar(FP,AtkUpMax[2],SetTo,255))

SelHPEPD,MarHPEPD,SelShEPD,SelOPEPD = CreateVars(4)

DoActions2X(FP,VArrPatchTable,1)
f_Read(FP,0x590000,"X",SelHPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
f_Read(FP,0x590004,"X",MarHPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
f_Read(FP,0x590008,"X",SelShEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
f_Read(FP,0x59000C,"X",SelOPEPD) -- 플립에서 전송받은 플립 변수 주소를 V에 입력
for j=1, 6 do
Marine[j] = f_GetStrXptr(FP,V(0x306+j-1),"\x0D\x0D\x0D"..Color[j].."NM".._0D)
HMarine[j] = f_GetStrXptr(FP,V(0x30C+j-1),"\x0D\x0D\x0D"..Color[j].."HM".._0D)
LumMarine[j] = f_GetStrXptr(FP,V(0x312+j-1),"\x0D\x0D\x0D"..Color[j].."LM".._0D)
Lumia[j] = f_GetStrXptr(FP,V(0x318+j-1),"\x0D\x0D\x0D"..Color[j].."RM".._0D)
f_GetStrXptr(FP,SuStrPtr[j],"\x0D\x0D\x0D"..Color[j].."Su".._0D)
f_GetStrXptr(FP,TeStrPtr[j],"\x0D\x0D\x0D"..Color[j].."Te".._0D)
f_GetStrXptr(FP,QuaStrPtr[j],"\x0D\x0D\x0D"..Color[j].."Qua".._0D)
LumiaCT[j] = f_GetStrXptr(FP,V(0x31E+j-1),"\x0D\x0D\x0D"..Player[j].."Lumia".._0D)
ShieldT[j] = f_GetStrXptr(FP,V(0x324+j-1),"\x0D\x0D\x0D"..Player[j].."Shield".._0D)
ATKExitText[j] = f_GetStrXptr(FP,V(0x32A+j-1),"\x0D\x0D\x0D"..Player[j].."Exit".._0D)
ATKUpText1[j] = f_GetStrXptr(FP,V(0x330+j-1),"\x0D\x0D\x0D"..Player[j].."100".._0D)
ATKUpText2[j] = f_GetStrXptr(FP,V(0x336+j-1),"\x0D\x0D\x0D"..Player[j].."200".._0D)
PlayerName[j] = f_GetStrXptr(FP,V(0x33D+j-1),"\x0D\x0D\x0D"..Player[j].."".._0D)
MarineL[j] = GetStrSizeD(1,Marine[j])
HMarineL[j] = GetStrSizeD(1,HMarine[j])
LumMarineL[j] = GetStrSizeD(1,LumMarine[j])
LumiaL[j] = GetStrSizeD(1,Lumia[j])
end
for i = 0, 5 do
ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
_0DPatchforVArr(FP,Names[i+1],6)
end
f_GetStrXptr(FP,HeroTxtStrPtr,"\x0D\x0D\x0DHK".._0D)
f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
f_GetStrXptr(FP,HiddenModeStrPtr,"HD".._0D)
for j = 0, 5 do
	f_GetStrXptr(FP,DefStrPtr[j+1],"\x0D\x0D\x0DDef"..Player[j+1].._0D)
end
for i = 0, 5 do
	Install_CText1(DefStrPtr[i+1],DefStr1,DefStr2,Names[i+1])
	Install_CText1(SuStrPtr[i+1],SuT00,SuText,Names[i+1])
	Install_CText1(QuaStrPtr[i+1],SuT00,QuaText,Names[i+1])
	Install_CText1(TeStrPtr[i+1],SuT00,TeText,Names[i+1])
end

t00 = "\x0d\x0d\x0d\x12\x02◆ \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t01 = "\x0d\x0d\x0d\x04의 \x04Marine\x04이 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \x02◆\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t02 = "\x0d\x0d\x0d\x04의 \x1BH \x04Marine\x04이 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \x02◆\n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x060.5\x04)\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t04 = "\x0d\x0d\x0d\x04의 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ \x04가 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \x02◆\n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x063\x04)\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t10 = "\x0d\x0d\x0d\x13\x03† \x04\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
--플레이어 이름
t11 = "\x0d\x0d\x0d\x04이(가) \x06【 \x08Ｌ\x11ｕ\x03ｍ\x18ｉ\x0EＡ \x10】 \x04를 \x19소환\x04하였습니다.  \x03†\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t12 = "\x0d\x0d\x0d\x12\x07『 \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
--플레이어 이름
t13 = "\x0d\x0d\x0d\x04이(가) \x1C빛의 보호막\x04을 사용했습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t14 = "\x0d\x0d\x0d\\x13\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t15 = "\x0d\x0d\x0d\x04(이)가 게임에서 나갔습니다."
t16 = "\x0d\x0d\x0d\x04(이)가 \x03공격력 \x04업그레이드를 100까지 끝냈습니다.\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t17 = "\x0d\x0d\x0d\x04(이)가 \x03공격력 \x04업그레이드를 200까지 끝냈습니다.\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t18 = "\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x13\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t19 = "\x0d\x0d\x0d\x0d\x0d\x0d\x13\x15▶ ▶ ▶ [\x04 \x0d\x0d\x0d\x0d\x0d\x0d"
t20 = "\x0d\x0d\x0d\x0d\x0d\x0d \x11사살\x10 +\x17 \x0d\x0d\x0d\x0d\x0d\x0d"
t21 = "\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d P t s \x15] \x15◀ ◀ ◀\x0d\x0d\x0d\x0d\x0d\x0d"

t24 = "현재 선택가능 플레이어는...\x0d\x0d\x0d\x0d\x0d"
t25 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST \x04[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST \x04[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x0EEASY \x03[W] \x08HARD \x04[E] \x11BURST \x04[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x03[E] \x11BURST \x04[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d"
}

t26 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x0EEASY \x02[W] \x08HARD \x02[E] \x11BURST \x02[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x0EEASY \x02[W] \x02HARD \x02[E] \x02BURST \x02[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02EASY \x03[W] \x08HARD \x02[E] \x02BURST \x02[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02EASY \x02[W] \x02HARD \x03[E] \x11BURST \x02[Y] \x07선택완료\x0d\x0d\x0d\x0d\x0d"
}
t28 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x02[W] \x02진지한 \x02[E] \x02강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x0E신나는 \x02[W] \x02진지한 \x02[E] \x02강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x03[W] \x08진지한 \x02[E] \x02강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x02[W] \x02진지한 \x03[E] \x11강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x02[W] \x02진지한 \x02[E] \x02강렬한 \x03[R] \x10강렬한2\x0d\x0d\x0d\x0d\x0d"
}

t27 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x04연습모드 \x04[W] \x08노벙커 \x03[E] \x0E선택안함 \x04[Y] \x07선택완료 - \x11BGM\x04(←→키로 선택) \x04: \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d", -- GMode 3
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x04연습모드 \x04[W] \x08노벙커 \x04[E] \x0E선택안함 \x04[Y] \x07선택완료 - \x11BGM\x04(←→키로 선택) \x04: \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x04연습모드 \x03[W] \x08노벙커 \x04[E] \x0E선택안함 \x04[Y] \x07선택완료 - \x11BGM\x04(←→키로 선택) \x04: \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x04연습모드 \x03[W] \x08노벙커 \x04[E] \x0E선택안함 \x04[Y] \x07선택완료 - \x11BGM\x04(←→키로 선택) \x04: \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d",
}
RndBGMT = CreateCText(FP,"\x04랜덤 "..(string.rep("\x0d",GetStrSizeD(0,"칸"))))
BModeArr = {
"\x0E신나는 ",
"\x08진지한 ",
"\x11강렬한 ",
"\x10강렬한2",
"\x17메모리 ",
"\x1F익시드 ",
"\x1C블루아카 "
}
BModeTArr = {}
for j, k in pairs(BModeArr) do
table.insert(BModeTArr,CreateCText(FP,k))
end
Print_String(FP,_TMem(Arr(Str00,0)),t00,0)
Print_String(FP,_TMem(Arr(Str01,0)),t01,0)
Print_String(FP,_TMem(Arr(Str02,0)),t02,0)
Print_String(FP,_TMem(Arr(Str04,0)),t04,0)
Print_String(FP,_TMem(Arr(Str10,0)),t10,0)
Print_String(FP,_TMem(Arr(Str11,0)),t11,0)
Print_String(FP,_TMem(Arr(Str12,0)),t12,0)
Print_String(FP,_TMem(Arr(Str13,0)),t13,0)
Print_String(FP,_TMem(Arr(Str14,0)),t14,0)
Print_String(FP,_TMem(Arr(Str15,0)),t15,0)
Print_String(FP,_TMem(Arr(Str16,0)),t16,0)
Print_String(FP,_TMem(Arr(Str17,0)),t17,0)
Print_String(FP,_TMem(Arr(Str18,0)),t18,0)
Print_String(FP,_TMem(Arr(Str19,0)),t19,0)
Print_String(FP,_TMem(Arr(Str20,0)),t20,0)
Print_String(FP,_TMem(Arr(Str21,0)),t21,0)
Print_String(FP,_TMem(Arr(Str24,0)),t24,0)

Str25L = {}
Str26L = {}
Str27L = {}
Str28L = {}
for i = 0, 3 do
Print_String(FP,_TMem(Arr(Str25[i+1],0)),t25[i+1],0)
table.insert(Str25L,GetStrSizeD(0,t25[i+1]))
Print_String(FP,_TMem(Arr(Str26[i+1],0)),t26[i+1],0)
table.insert(Str26L,GetStrSizeD(0,t26[i+1]))
end

for i = 0, 4 do
Print_String(FP,_TMem(Arr(Str28[i+1],0)),t28[i+1],0)
table.insert(Str28L,GetStrSizeD(0,t28[i+1]))
end
for i = 1, #t27 do
Print_String(FP,_TMem(Arr(Str27[i],0)),t27[i],0)
table.insert(Str27L,GetStrSizeD(0,t27[i]))
end


Str00L = GetStrSizeD(0,t00)
Str01L = GetStrSizeD(0,t01)
Str02L = GetStrSizeD(0,t02)
Str10L = GetStrSizeD(0,t10)
Str11L = GetStrSizeD(0,t11)
Str12L = GetStrSizeD(0,t12)
Str13L = GetStrSizeD(0,t13)
Str14L = GetStrSizeD(0,t14)
Str15L = GetStrSizeD(0,t15)
Str16L = GetStrSizeD(0,t16)
Str17L = GetStrSizeD(0,t17)
Str18L = GetStrSizeD(0,t18)
Str19L = GetStrSizeD(0,t19)
Str20L = GetStrSizeD(0,t20)
Str21L = GetStrSizeD(0,t21)
Str24L = GetStrSizeD(0,t24)
for i = 0, 5 do
t03 = "\x0d\x0d\x0d\x04의 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy "..Color[i+1].."M\x16arine\x04이 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x061\x04)\x02◆\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
Print_String(FP,_TMem(Arr(Str03[i+1],0)),t03,0)
Str03L[i+1] = GetStrSizeD(0,t03)
end
Str04L = GetStrSizeD(0,t04)
for i = 0, 5 do
f_Memcpy(FP,V(0x306+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_Movcpy(FP,_Add(V(0x306+i),Str00L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x306+i),Str00L+(4*6)+3),_TMem(Arr(Str01,0),"X","X",1),Str01L-3)
f_Memcpy(FP,V(0x30C+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_Movcpy(FP,_Add(V(0x30C+i),Str00L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x30C+i),Str00L+(4*6)+3),_TMem(Arr(Str02,0),"X","X",1),Str02L-3)
f_Memcpy(FP,V(0x312+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_Movcpy(FP,_Add(V(0x312+i),Str00L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x312+i),Str00L+(4*6)+3),_TMem(Arr(Str03[i+1],0),"X","X",1),Str03L[i+1]-3)
f_Memcpy(FP,V(0x318+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_Movcpy(FP,_Add(V(0x318+i),Str00L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x318+i),Str00L+(4*6)+3),_TMem(Arr(Str04,0),"X","X",1),Str04L-3)
f_Memcpy(FP,V(0x31E+i),_TMem(Arr(Str10,0),"X","X",1),Str10L-3)
f_Movcpy(FP,_Add(V(0x31E+i),Str10L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x31E+i),Str10L+(4*6)+3),_TMem(Arr(Str11,0),"X","X",1),Str11L-3)
f_Memcpy(FP,V(0x324+i),_TMem(Arr(Str12,0),"X","X",1),Str12L-3)
f_Movcpy(FP,_Add(V(0x324+i),Str12L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x324+i),Str12L+(4*6)+3),_TMem(Arr(Str13,0),"X","X",1),Str13L-3)
f_Memcpy(FP,V(0x32A+i),_TMem(Arr(Str14,0),"X","X",1),Str14L-3)
f_Movcpy(FP,_Add(V(0x32A+i),Str14L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x32A+i),Str14L+(4*6)+3),_TMem(Arr(Str15,0),"X","X",1),Str15L-3)
f_Memcpy(FP,V(0x330+i),_TMem(Arr(Str14,0),"X","X",1),Str14L-3)
f_Movcpy(FP,_Add(V(0x330+i),Str14L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x330+i),Str14L+(4*6)+3),_TMem(Arr(Str16,0),"X","X",1),Str16L-3)
f_Memcpy(FP,V(0x336+i),_TMem(Arr(Str14,0),"X","X",1),Str14L-3)
f_Movcpy(FP,_Add(V(0x336+i),Str14L),VArr(Names[i+1],0),4*6)
f_Memcpy(FP,_Add(V(0x336+i),Str14L+(4*6)+3),_TMem(Arr(Str17,0),"X","X",1),Str17L-3)
f_Memcpy(FP,V(0x33D+i),_TMem(Arr(Str18,0),"X","X",1),Str18L-3)
f_Movcpy(FP,_Add(V(0x33D+i),Str18L),VArr(Names[i+1],0),5*4)
end
f_Memcpy(FP,HeroTxtStrPtr,_TMem(Arr(Str19,0),"X","X",1),Str19L-3)
--f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19L),UnitNamePtr+(i*0x20),0x20)
f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19L-3+0x20),_TMem(Arr(Str20,0),"X","X",1),Str20L-3)
--ItoDec(FP,HPoint,_TMem(Arr(HPointT,0),"X","X",1),2,0x1F,0)
--f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19L+0x20+Str20L),_TMem(Arr(HPointT,0),"X","X",1),16)
f_Memcpy(FP,_Add(HeroTxtStrPtr,Str19L-3+0x20+Str20L-3+16),_TMem(Arr(Str21,0),"X","X",1),Str21L-3)
--f_Read(FP,0x6559A8,InfArmorFactor,"X",0xFFFF)
f_Read(FP,0x6559A8,InfArmorFactor,"X",0xFFFF)
--f_Read(FP,,InfWeaponFactor,"X",0xFFFF0000)
f_Read(FP,0x6559A8,InfWeaponFactor,"X",0xFFFF0000)
f_Div(FP,InfWeaponFactor,65536)

--tab = {}
--for i=0, 227 do
--table.insert(tab,print_utf82(0x591000+(0x20*i),DecodeUnit(i)))
--end
--DoActions2(P8,tab)
UnitNameTrig()



CMov(FP,0x6509B0,EPDF(0x591000))
NWhile(FP,Memory(0x6509B0,AtMost,EPDF(0x591000+(0x20*227))))
Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF)},{
SetDeathsX(CurrentPlayer,SetTo,0x0D,0,0xFF)
},{preserved})
Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF00)},{
SetDeathsX(CurrentPlayer,SetTo,0x0D*0x100,0,0xFF00)
},{preserved})
Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF0000)},{
SetDeathsX(CurrentPlayer,SetTo,0x0D*0x10000,0,0xFF0000)
},{preserved})
Trigger2(FP,{DeathsX(CurrentPlayer,Exactly,0,0,0xFF000000)},{
SetDeathsX(CurrentPlayer,SetTo,0x0D*0x1000000,0,0xFF000000)
},{preserved})
CAdd(FP,0x6509B0,1)
NWhileEnd()
SetRecoverCp()
RecoverCp(FP)
CIfEnd()

CJump(FP,0xF01)

Call_OCU = SetCallForward()
SetCall(FP)
f_Read(FP,TempUpgradePtr,CurrentUpgrade)


CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
f_Mod(FP,CurrentUpgrade,_Mul(TempUpgradeMaskRet,_Mov(256)))
CIfEnd()
f_Div(FP,CurrentUpgrade,TempUpgradeMaskRet)

CIfX(FP,CDeaths(FP,AtLeast,1,ifUpisAtk))
CMov(FP,UpgradeAv,AtkUpMax)
CElseX()
CMov(FP,UpgradeAv,255)
CIfXEnd()
DoActionsX(FP,SetCDeaths(FP,SetTo,0,ifUpisAtk))


CMov(FP,0x6509B0,UpgradeCP)
OCU_Jump = def_sIndex()
CJumpEnd(FP,OCU_Jump)
NWhile(FP,{
TCVar(FP,CurrentUpgrade[2],AtMost,_Sub(UpgradeAv,1)),
CVar(FP,UpgradeMax[2],AtLeast,1),
TAccumulate(CurrentPlayer,AtLeast,_Mul(CurrentUpgrade,UpgradeFactor),Ore),
TMemoryX(TempUpgradePtr,AtMost,_Mul(TempUpgradeMaskRet,_Sub(UpgradeAv,1)),_Mul(TempUpgradeMaskRet,_Mov(255)))})
CDoActions(FP,{
TSetCVar(FP,CurrentFactor[2],Add,_Mul(CurrentUpgrade,UpgradeFactor)),
TSetResources(CurrentPlayer,Subtract,_Mul(CurrentUpgrade,UpgradeFactor),Ore),
SetCVar(FP,CurrentUpgrade[2],Add,1),
SetCVar(FP,UpCount[2],Add,1),
SetCVar(FP,UpgradeMax[2],Subtract,1),
--TSetCVar(FP,CurrentFactor[2],Add,_Mul(CurrentUpgrade,UpgradeFactor)),
TSetMemoryX(TempUpgradePtr,Add,_Mul(TempUpgradeMaskRet,1),_Mul(TempUpgradeMaskRet,_Mov(255)))})
CJump(FP,OCU_Jump)
NWhileEnd()
NJump(FP,0x24,CVar(FP,UpCount[2],Exactly,0),{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
		})
ItoDec(FP,CurrentFactor,VArr(UpCompTxt,0),2,0x1F,0)
ItoDec(FP,UpCount,VArr(UpCompRet,0),2,0x19,0)
_0DPatchforVArr(FP,UpCompRet,4)
_0DPatchforVArr(FP,UpCompTxt,4)



--[[
for i = 0, 5 do
CIf(FP,{CVar(FP,UpgradeCP[2],Exactly,i),Command(i,AtLeast,1,"Terran Medic")})
CDoActions(FP,{TSetMemoryX(AtkUpgradePtrArr[i+1],SetTo,_Mul(CurrentUpgrade,(256^AtkUpgradeMaskRetArr[i+1])),255*(256^AtkUpgradeMaskRetArr[i+1]))})
DoActions(FP,{RemoveUnit("Terran Medic",i)})
CIfEnd()
CIf(FP,{CVar(FP,UpgradeCP[2],Exactly,i),Command(i,AtLeast,1,"Terran Firebat")})
CDoActions(FP,{TSetMemoryX(DefUpgradePtrArr[i+1],SetTo,_Mul(CurrentUpgrade,(256^AtkUpgradeMaskRetArr[i+1])),255*(256^DefUpgradeMaskRetArr[i+1]))})
DoActions(FP,{RemoveUnit("Terran Firebat",i)})
CIfEnd()
end
for j = 0,7 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,CurrentUpgrade[2],Exactly,j^2,j^2);
	},
	actions = {
		SetMemoryX(UpgradePtrArr[i+1],SetTo,j^2*(256^UpgradeMaskRetArr[i+1]),j^2*(256^UpgradeMaskRetArr[i+1]));
		SetCVar(FP,CurrentUpgrade[2],SetTo,j^2,j^2);
		PreserveTrigger();
	}
	}
end
--]]
DisplayPrint(UpgradeCP,{"\x12\x07『 \x1F",CurrentFactor," \x04미네랄을 소비하여 총 \x19",UpCount," \x04회 업그레이드를 완료하였습니다."})
NJumpEnd(FP,0x24)
SetCallEnd()




Call_HeroKillPoint = SetCallForward()
SetCall(FP)

f_SaveCp()
f_Read(FP,BackupCP,HIndex,"X",0xFF)
f_Mod(FP,HIndex2,HIndex,2,0xFF)
f_Read(FP,_Add(_Div(HIndex,2),_Mov(EPDF(0x663EB8))),HPoint)
NIfX(FP,{TMemory(_Mem(HIndex2),AtLeast,1)})
f_Div(FP,HPoint,65536)
NElseX()
f_Mod(FP,HPoint,65536)
NIfXEnd()
CMov(FP,HPoint10,_Mul(HPoint,HPointVar))
CDoActions(FP,{TSetScore(Force1,Add,HPoint10,Kills)})
function HeroTextFunc()
	f_Memcpy(FP,_Add(RetV,Dev),_Add(_Mul(HIndex,_Mov(0x20)),UnitNamePtr),0x20)
	Dev = Dev+0x20
	BSize=BSize+0x20
end

DisplayPrint(HumanPlayers,{"\x13\x15▶ ▶ ▶ [\x04 ",HeroTextFunc," \x11사살\x10 +\x17 \x1F",HPoint10," P t s \x15] \x15◀ ◀ ◀"})

Trigger2X(FP,{CDeaths(FP,AtMost,2,SoundLimit)},{CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{preserved})

f_LoadCp()
SetCallEnd()

GunPosSave_CallIndex = SetCallForward()

CVoid_ID = CreateVar()
CVoid_ID2 = CreateVar()
SetCall(FP)
DoActionsX(FP,{SetCVar(FP,CanC[2],Add,1),SetCVar(FP,ExchangeRate[2],Add,1);})
CTrigger(FP,{TCVar(FP,ExchangeRate[2],AtLeast,ExrateBackup)},{TSetCVar(FP,ExchangeRate[2],SetTo,ExrateBackup)},1)
DoActions(FP,MoveCp(Subtract,15*4))
SaveCp(FP,BackupPosData)
DoActions(FP,MoveCp(Subtract,1*4))
f_SaveCp()
f_Read(FP,BackupCP,CVoid_ID)
f_Mod(FP,CVoid_ID,0xFFFFFF)
CMov(FP,CVoid_ID2,_Div(CVoid_ID,_Mov(0x10000)),nil,0xFF)
f_Read(FP,BackupPosData,CPos)
Convert_CPosXY()
f_Read(FP,_Add(BackupCP,16),f_GunUID)
NIf(FP,{TDeathsX(_Add(BackupCP,16),Exactly,216,0,0xFF)})
CMov(FP,0x6509B0,GunPtrMemory)
NWhile(FP,{Deaths(CurrentPlayer,AtLeast,1,0)})
CAdd(FP,0x6509B0,1)
NWhileEnd()
SaveCp(FP,PosSavePtr)
CDoActions(FP,{TSetMemory(PosSavePtr,SetTo,CPos),TSetMemoryX(PosSavePtr,SetTo,_Mul(CVoid_ID2,_Mov(0x1000)),0xF000)})
NIfEnd()

CMov(FP,PosSavePtr,0)
CMov(FP,G_CA,0)
G_SkipJump = def_sIndex()
CJumpEnd(FP,G_SkipJump)
CAdd(FP,PosSavePtr,_Mul(G_CA,_Mov(0x970/4)),G_InputH)
NIf(FP,{TMemory(PosSavePtr,AtLeast,1),CVar(FP,G_CA[2],AtMost,127)},{SetCVar(FP,G_CA[2],Add,1)})
	CJump(FP,G_SkipJump)
NIfEnd()

CIfX(FP,{CVar(FP,G_CA[2],AtMost,127)})
CDoActions(FP,{
	TSetMemory(_Add(PosSavePtr,(0x20/4)*0),SetTo,f_GunUID),
	TSetMemory(_Add(PosSavePtr,(0x20/4)*1),SetTo,CPosX),
	TSetMemory(_Add(PosSavePtr,(0x20/4)*2),SetTo,CPosY),
	TSetMemory(_Add(PosSavePtr,(0x20/4)*3),SetTo,CVoid_ID2),
})
--CMov(FP,_Add(_Mul(CurrentArr,12),0x58D740),_ReadF(BackupPosData))
if Limit == 1 then
	DisplayPrint(HumanPlayers,{"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ",G_CA,". \x07』"})
end
CElseX()
DoActions2(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
CIfXEnd()

f_LoadCp()
DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,0,0,0x00FF0000),MoveCp(Add,16*4)})

SetCallEnd()



Force_PosSave_CallIndex = SetCallForward()
SetCall(FP)
CMov(FP,PosSavePtr,0)
CMov(FP,G_CA,0)
G_SkipJump = def_sIndex()
CJumpEnd(FP,G_SkipJump)
CAdd(FP,PosSavePtr,_Mul(G_CA,_Mov(0x970/4)),G_InputH)
NIf(FP,{TMemory(PosSavePtr,AtLeast,1),CVar(FP,G_CA[2],AtMost,127)},{SetCVar(FP,G_CA[2],Add,1)})
	CJump(FP,G_SkipJump)
NIfEnd()

CIfX(FP,{CVar(FP,G_CA[2],AtMost,127)})
CDoActions(FP,{
	TSetMemory(_Add(PosSavePtr,(0x20/4)*0),SetTo,f_GunUID),
	TSetMemory(_Add(PosSavePtr,(0x20/4)*1),SetTo,CPosX),
	TSetMemory(_Add(PosSavePtr,(0x20/4)*2),SetTo,CPosY),
	TSetMemory(_Add(PosSavePtr,(0x20/4)*3),SetTo,CVoid_ID2),
})
--CMov(FP,_Add(_Mul(CurrentArr,12),0x58D740),_ReadF(BackupPosData))
if Limit == 1 then
	DisplayPrint(HumanPlayers,{"\x07『 \x03TESTMODE OP \x04: 성공한 f_GunSend의 EXCunit Number : ",G_CA,". \x07』"})
end
CElseX()
DoActions2(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
CIfXEnd()
SetCallEnd()



CJumpEnd(FP,0xF01)
CIf(FP,{Memory(0x628438, AtLeast, 0x00000001),CDeaths(FP,Exactly,0,Print13)})
Print_13(FP,{P1,P2,P3,P4,P5,P6},nil)
DoActionsX(FP,SetCDeaths(FP,Add,88,Print13))
CIfEnd()

DoActionsX(FP,SetCDeaths(FP,Subtract,1,Print13))

CIf(FP,Switch("Switch 201",Cleared))
UpButtonSetArr = {}
for i=0, 5 do
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+9,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+2,SetTo,0))
end
DoActions2(FP,UpButtonSetArr)
CIfX(FP,Never())
	for i = 0, 5 do
	CElseIfX(HumanCheck(i,1))
	CMov(FP,SelCP,i)
	end
	CIfXEnd()
LoadCp(FP,SelCP)



HiddenCommand = {51,50,52,50,52,50,50,62,61,61}
for i = 1, #HiddenCommand do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,HiddenCommand[i]);
		CDeaths(FP,Exactly,i-1,HiddenMode);
		CDeaths(FP,AtMost,0,KeyToggle);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,KeyToggle);
		--SetCDeaths(FP,Add,1,HiddenMode);
	}
	}
end

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,50);
		CDeaths(FP,AtMost,0,KeyToggle);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,KeyToggle);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,51);
		CDeaths(FP,AtMost,0,KeyToggle);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,KeyToggle);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,52);
		CDeaths(FP,AtMost,0,KeyToggle);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,KeyToggle);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtMost,0,50);
		Deaths(CurrentPlayer,AtMost,0,51);
		Deaths(CurrentPlayer,AtMost,0,52);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,KeyToggle);
		PreserveTrigger();
	}
	}

	

TriggerX(FP,{Memory(0xA03740,Exactly,0),CDeaths(FP,Exactly,0,ModeO),ElapsedTime(AtLeast,20)},{--코드입력시 히든모드 발동
	SetCDeaths(FP,SetTo,#HiddenCommand,HiddenMode)
})


CIf(FP,{CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode),CDeaths(FP,Exactly,0,ModeO)})

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,66);
		CVar(FP,HondonMode[2],AtMost,0);
		CDeaths(FP,AtMost,0,ToggleHondon);
		
	},
	actions = {
		SetCVar(FP,HondonMode[2],SetTo,1);
		SetCDeaths(FP,SetTo,1,ToggleHondon);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}
	
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,66);
		CVar(FP,HondonMode[2],AtLeast,1);
		CDeaths(FP,AtMost,0,ToggleHondon);
		
	},
	actions = {
		SetCVar(FP,HondonMode[2],SetTo,0);
		SetCDeaths(FP,SetTo,1,ToggleHondon);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,40);
		CVar(FP,AtkSpeedMode[2],AtMost,0);
		CDeaths(FP,AtMost,0,ToggleAtkSp);
		
	},
	actions = {
		SetCVar(FP,AtkSpeedMode[2],SetTo,1);
		SetCDeaths(FP,SetTo,1,ToggleAtkSp);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}
	
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,40);
		CVar(FP,AtkSpeedMode[2],AtLeast,1);
		CDeaths(FP,AtMost,0,ToggleAtkSp);
		
	},
	actions = {
		SetCVar(FP,AtkSpeedMode[2],SetTo,0);
		SetCDeaths(FP,SetTo,1,ToggleAtkSp);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,60);
		CVar(FP,HiddenHP[2],AtMost,4);
		CDeaths(FP,AtMost,0,Toggle1);
		
	},
	actions = {
		SetCVar(FP,HiddenHP[2],Add,1);
		SetCDeaths(FP,SetTo,1,Toggle1);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,63);
		CVar(FP,HiddenHPM[2],AtMost,4);
		CDeaths(FP,AtMost,0,ToggleA);
	},
	actions = {
		SetCVar(FP,HiddenHPM[2],Add,1);
		SetCDeaths(FP,SetTo,1,ToggleA);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}


Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,61);
		CVar(FP,HiddenATK[2],AtMost,4);
		CDeaths(FP,AtMost,0,Toggle2);
		
	},
	actions = {
		SetCVar(FP,HiddenATK[2],Add,1);
		SetCDeaths(FP,SetTo,1,Toggle2);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}


Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,64);
		CVar(FP,HiddenATKM[2],AtMost,4);
		CDeaths(FP,AtMost,0,ToggleS);
	},
	actions = {
		SetCVar(FP,HiddenATKM[2],Add,1);
		SetCDeaths(FP,SetTo,1,ToggleS);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}


Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,62);
		CVar(FP,HiddenPts[2],AtMost,4);
		CDeaths(FP,AtMost,0,Toggle3);
		
	},
	actions = {
		SetCVar(FP,HiddenPts[2],Add,1);
		SetCDeaths(FP,SetTo,1,Toggle3);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,65);
		CVar(FP,HiddenPtsM[2],AtMost,4);
		CDeaths(FP,AtMost,0,ToggleD);
	},
	actions = {
		SetCVar(FP,HiddenPtsM[2],Add,1);
		SetCDeaths(FP,SetTo,1,ToggleD);
		SetCDeaths(FP,SetTo,1,ToggleSound);
		PreserveTrigger();
	}
	}

	

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtMost,0,60);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,Toggle1);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtMost,0,61);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,Toggle2);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtMost,0,62);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,Toggle3);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtMost,0,63);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,ToggleA);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtMost,0,64);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,ToggleS);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtMost,0,65);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,ToggleD);
		PreserveTrigger();
	}
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			Deaths(CurrentPlayer,AtMost,0,66);
		},
		actions = {
			SetCDeaths(FP,SetTo,0,ToggleHondon);
			PreserveTrigger();
		}
		}
	
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			Deaths(CurrentPlayer,AtMost,0,40);
		},
		actions = {
			SetCDeaths(FP,SetTo,0,ToggleAtkSp);
			PreserveTrigger();
		}
		}
	
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHPM[2],AtLeast,1);
		CVar(FP,HiddenHP[2],AtLeast,1);
	},
	actions = {
		SetCVar(FP,HiddenHP[2],Subtract,1);
		SetCVar(FP,HiddenHPM[2],Subtract,1);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATKM[2],AtLeast,1);
		CVar(FP,HiddenATK[2],AtLeast,1);
	},
	actions = {
		SetCVar(FP,HiddenATK[2],Subtract,1);
		SetCVar(FP,HiddenATKM[2],Subtract,1);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPtsM[2],AtLeast,1);
		CVar(FP,HiddenPts[2],AtLeast,1);
	},
	actions = {
		SetCVar(FP,HiddenPts[2],Subtract,1);
		SetCVar(FP,HiddenPtsM[2],Subtract,1);
		PreserveTrigger();
	}
	}
CIfEnd()
CIf(FP,{CDeaths(FP,AtMost,0,BGMSel),CDeaths(FP,AtMost,0,ModeSel)})
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,210);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,GMode);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,211);
	},
	actions = {
		SetCDeaths(FP,SetTo,2,GMode);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,212);
	},
	actions = {
		SetCDeaths(FP,SetTo,3,GMode);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,GMode);
		Deaths(CurrentPlayer,AtLeast,1,213);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,ModeSel);
		SetCDeaths(FP,SetTo,1,SelectorT);
		PreserveTrigger();
	}
	}
CIfEnd()
CIf(FP,CDeaths(FP,Exactly,1,BGMSel))

TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,67)},{SetCDeaths(FP,Subtract,1,BGMMode)},{preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,68)},{SetCDeaths(FP,Add,1,BGMMode)},{preserved})
TriggerX(FP,{CDeaths(FP,AtLeast,#BModeArr+1,BGMMode)},{SetCDeaths(FP,SetTo,#BModeArr,BGMMode)},{preserved})

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,GMode);
		CDeaths(FP,Exactly,0,MarMode);
		Deaths(CurrentPlayer,AtLeast,1,210);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,MarMode);
		SetDeaths(CurrentPlayer,SetTo,0,210);
		SetCDeaths(FP,SetTo,1,Sel_G);
		PreserveTrigger();
	}
	}
	
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,GMode);
		CDeaths(FP,Exactly,1,MarMode);
		Deaths(CurrentPlayer,AtLeast,1,210);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,MarMode);
		SetDeaths(CurrentPlayer,SetTo,0,210);
		SetCDeaths(FP,SetTo,1,Sel_G);
		PreserveTrigger();
	}
	}
	

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,GMode);
		CDeaths(FP,Exactly,0,NBMode);
		Deaths(CurrentPlayer,AtLeast,1,211);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,NBMode);
		SetDeaths(CurrentPlayer,SetTo,0,211);
		SetCDeaths(FP,SetTo,1,Sel_G);
		PreserveTrigger();
	}
	}
	
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,GMode);
		CDeaths(FP,Exactly,1,NBMode);
		Deaths(CurrentPlayer,AtLeast,1,211);
	},
	actions = {
		SetCDeaths(FP,SetTo,0,NBMode);
		SetDeaths(CurrentPlayer,SetTo,0,211);
		SetCDeaths(FP,SetTo,1,Sel_G);
		PreserveTrigger();
	}
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			Deaths(CurrentPlayer,AtLeast,1,212);
		},
		actions = {
			SetCDeaths(FP,SetTo,0,NBMode);
			SetCDeaths(FP,SetTo,0,MarMode);
			SetDeaths(CurrentPlayer,SetTo,0,212);
			SetCDeaths(FP,SetTo,1,Sel_G);
			PreserveTrigger();
		}
		}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,1,213);
	},
	actions = {
		SetCDeaths(FP,SetTo,2,BGMSel);
		SetCDeaths(FP,SetTo,1,SelectorT);
		PreserveTrigger();
	}
	}





CIfEnd()
SetRecoverCp()
RecoverCp(FP)
Trigger { -- 당신 혹시 싱글?!
players = {FP},
conditions = {
	Label(0);
	Memory(0x57F0B4, Exactly, 0);
},
actions = {
	SetCDeaths(FP,SetTo,1,isSingle);
	
},
}
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,isSingle);
		Switch("Switch 201",Cleared);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 1);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 2);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 3);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 4);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 5);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 128);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 129);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 130);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, 131);
		CenterView(64);
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
		
		
	},
	}
CIf(FP,CDeaths(FP,Exactly,0,ModeO))

CIf(FP,CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode))


--HiddenModeStr = "\x0D\x0D\x0D\x0D\x13\x10[ \x04(\x08HP \x04: -0) (\x1BATK \x04: -0) (\x1FPts \x04: -0) (\x10혼돈 옵션 \x04: OFF) \x10]\x0D\x0D\x0D\x0D\x0D"
--HiddenModeStr2 = "\x0D\x0D\x0D\x0D\x13\x10[ \x04(\x08HP \x04: -0) (\x1BATK \x04: -0) (\x1FPts \x04: -0) (\x10혼돈 옵션 \x08: ON) \x10]\x0D\x0D\x0D\x0D\x0D"
--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
--Print_StringX(FP,VArr(HiddenModeT,0),HiddenModeStr,0)
--CElseX()
--Print_StringX(FP,VArr(HiddenModeT,0),HiddenModeStr2,0)
--CIfXEnd()
--HiddenModeL = GetStrSizeD(0,HiddenModeStr)
HiddenFindT = "\x13\x04히든 커맨드 입력성공.\n\x13\x04값 올림 버튼 : \x071,2,3. \x04내림 버튼 : \x07A,S,D\n\x13\x10기타옵션 \x07활성화 \x04: ~, TAB 버튼"
WavFile = "staredit\\wav\\Unlock.ogg"
DoActions2(FP,{RotatePlayer({
	PlayWAVX(WavFile);
	DisplayTextX(HiddenFindT,4);
	SetCDeaths(FP,SetTo,1,ToggleSound);
},HumanPlayers,FP)},1)

--[[
Trigger {
	players = {FP},
	conditions = {
		Label(0);
	},
	actions = {
		
		SetMemory(0x640B60, SetTo, 0x0D0D0D0D);
		SetMemory(0x640B64, SetTo, 0x205B100D);
		SetMemory(0x640B68, SetTo, 0x48082804);
		SetMemory(0x640B6C, SetTo, 0x3A042050);
		SetMemory(0x640B70, SetTo, 0x29302D20); -- 4
		SetMemory(0x640B74, SetTo, 0x411B2820);
		SetMemory(0x640B78, SetTo, 0x04204B54);
		SetMemory(0x640B7C, SetTo, 0x302D203A); -- 7
		SetMemory(0x640B80, SetTo, 0x1F282029);
		SetMemory(0x640B84, SetTo, 0x20737450);
		SetMemory(0x640B88, SetTo, 0x2D203A04); 
		SetMemory(0x640B8C, SetTo, 0x10202930); -- 11
		SetMemory(0x640B90, SetTo, 0x0D0D0D5D);
		SetMemory(0x640B94, SetTo, 0x00000D0D);
		PreserveTrigger();
	},
}
--]]
--f_Movcpy(FP,HiddenModeStrPtr,VArr(HiddenModeT,0),HiddenModeL-3)

CIf(FP,{CDeaths(FP,AtLeast,1,ToggleSound);},{SetCDeaths(FP,SetTo,0,ToggleSound);})

HiddenDisplay = CreateVarArr(3,FP)

HiddenColor = CreateVarArr(3,FP)

CMov(FP,HiddenDisplay[1],0)
CMov(FP,HiddenDisplay[2],0)
CMov(FP,HiddenDisplay[3],0)
CAdd(FP,HiddenDisplay[1],HiddenHP)
CAdd(FP,HiddenDisplay[2],HiddenATK)
CAdd(FP,HiddenDisplay[3],HiddenPts)
CiSub(FP,HiddenDisplay[1],HiddenHPM)
CiSub(FP,HiddenDisplay[2],HiddenATKM)
CiSub(FP,HiddenDisplay[3],HiddenPtsM)

ColorT = {0x1F,0x0F,0x1C,0x1E,0x1D,0x4,0x19,0x3,0x11,0x10,0x08}
for i = 1, 3 do
	for j = 0, 10 do
		TriggerX(FP,{CV(HiddenDisplay[i],j-5)},{SetV(HiddenColor[i],ColorT[11-j])},{preserved})
	end
end

hondondisplay = CreateVarArr(4,FP)
AtkSpeedDisplay = CreateVarArr(4,FP)
TriggerX(FP,{CV(HondonMode,0)},{
	SetV(hondondisplay[1],string.byte("\x04",1,1)),
	SetV(hondondisplay[2],string.byte("O",1,1)),
	SetV(hondondisplay[3],string.byte("F",1,1)),
	SetV(hondondisplay[4],string.byte("F",1,1)),
},{preserved})
TriggerX(FP,{CV(HondonMode,1)},{
	SetV(hondondisplay[1],string.byte("\x08",1,1)),
	SetV(hondondisplay[2],string.byte("O",1,1)),
	SetV(hondondisplay[3],string.byte("N",1,1)),
	SetV(hondondisplay[4],string.byte(" ",1,1)),
},{preserved})
TriggerX(FP,{CV(AtkSpeedMode,0)},{
	SetV(AtkSpeedDisplay[1],string.byte("\x04",1,1)),
	SetV(AtkSpeedDisplay[2],string.byte("O",1,1)),
	SetV(AtkSpeedDisplay[3],string.byte("F",1,1)),
	SetV(AtkSpeedDisplay[4],string.byte("F",1,1)),
},{preserved})
TriggerX(FP,{CV(AtkSpeedMode,1)},{
	SetV(AtkSpeedDisplay[1],string.byte("\x1F",1,1)),
	SetV(AtkSpeedDisplay[2],string.byte("O",1,1)),
	SetV(AtkSpeedDisplay[3],string.byte("N",1,1)),
	SetV(AtkSpeedDisplay[4],string.byte(" ",1,1)),
},{preserved})

WavFile = "staredit\\wav\\sel_g.ogg"

--HondonMode
--AtkSpeedMode
DisplayPrint(HumanPlayers,{"\x13\x10[ \x04(\x08HP \x04: ",HiddenColor[1][2],HiddenDisplay[1],"\x04) (\x1BATK \x04: ",HiddenColor[2][2],HiddenDisplay[2],"\x04) (\x1FPts \x04: ",HiddenColor[3][2],HiddenDisplay[3],"\x04) (\x10혼돈 옵션 \x04: ",hondondisplay,"\x04) (\x1F공속무한모드 \x04: ",AtkSpeedDisplay,"\x04)  \x10]"})
DoActions2(FP,{RotatePlayer({PlayWAVX(WavFile);},HumanPlayers,FP)})
CIfEnd()

CIfEnd()
Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		CreateUnit(1,160,16,FP);
	}
	}
Trigger { -- 텟모드 설치 여부
	players = {FP},
	conditions = {
		Label(0);
		--Switch("Switch 203",Set);
	},
	actions = {
		SetCDeaths(FP,SetTo,TestStart,TestMode);
		SetCDeaths(FP,SetTo,Limit,LimitX);
	},
	}

Trigger { -- 텟모드 설치 여부
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,LimitX);
		Deaths(P1,AtLeast,1,200);
		
	},
	actions = {
		SetCDeaths(FP,SetTo,1,TestMode);
	},
	}

CIf(FP,CDeaths(FP,AtLeast,1,LimitX))

YY = 2021
MM = 11
DD = 11
HH = 00

GlobalTime = os.time{year=YY, month=MM, day=DD, hour=HH }
--PushErrorMsg(GlobalTime)
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Memory(0x6D0F38,AtMost,GlobalTime);

	},
	actions = {
		SetCDeaths(FP,SetTo,1,LimitC);
		
	}
}


Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		SetSwitch("Switch 254",Set);
	}
}

for i = 0, 5 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		isname(i,"GALAXY_BURST");
		CDeaths(FP,AtLeast,1,LimitX);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,LimitC);
		
	}
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			isname(i,"_Mininii");
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
		}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		isname(i,"Natori_sana");
		CDeaths(FP,AtLeast,1,LimitX);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,LimitC);
		
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		isname(i,"Sumi_Serina");
		CDeaths(FP,AtLeast,1,LimitX);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,LimitC);
		
	}
	}


	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			isname(i,"Hybrid)_GOD60");
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
		}
	
end
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,LimitX);
		CDeaths(FP,Exactly,0,LimitC);
		
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,5);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,6);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,7);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		Defeat();
		SetMemory(0x6509B0,SetTo,128);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		SetMemory(0x6509B0,SetTo,129);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		SetMemory(0x6509B0,SetTo,130);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		SetMemory(0x6509B0,SetTo,131);
		DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
		SetMemory(0x6509B0,SetTo,FP);
	}
	}
CIfEnd()




Text2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04현재 선택가능 플레이어는..."
for j = 1, 6 do

CIf(FP,{CDeaths(FP,Exactly,0,SelectorT),CVar(FP,SelCP[2],Exactly,j-1)})
f_Memcpy(FP,0x641598,_TMem(Arr(Str24,0),"X","X",1),Str24L)
f_Movcpy(FP,0x641598+Str24L-3,VArr(Names[j],0),4*6)
CIfEnd()
end
CIf(FP,{CDeaths(FP,Exactly,0,ModeSel),CDeaths(FP,Exactly,0,BGMSel)})




for i = 0, 3 do
CIf(FP,CDeaths(FP,Exactly,i,GMode))
f_Memcpy(FP,0x641598+Str24L+(4*6)-5,_TMem(Arr(Str25[i+1],0),"X","X",1),Str25L[i+1])
CIfEnd()
end
CIfEnd()
_0DPatchforT13 = {}
for i =0, 50 do
table.insert(_0DPatchforT13,SetMemory(0x641598+(i*4),SetTo,0x0D0D0D0D))
end


	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,SelectorT);
	},
	actions = {
		SetCDeaths(FP,Add,1,IntroT);
		PreserveTrigger();
	}
	}

	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,24*30,IntroT);
		CDeaths(FP,Exactly,0,ModeSel);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,GMode);
		SetCDeaths(FP,SetTo,1,ModeSel);
		SetCDeaths(FP,SetTo,1,SelectorT);
		SetCDeaths(FP,SetTo,0,IntroT);
	}
	}

	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,24*30,IntroT);
		CDeaths(FP,AtLeast,1,ModeSel);
		CDeaths(FP,Exactly,1,BGMSel);
	},
	actions = {
		SetCDeaths(FP,SetTo,2,BGMSel);
		SetCDeaths(FP,SetTo,1,SelectorT);
		SetCDeaths(FP,SetTo,0,IntroT);
	}
	}


	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,ModeO);
		CDeaths(FP,Exactly,1,SelectorT);
	},
	actions = {
		SetCDeaths(FP,Add,1,ModeT2);
		PreserveTrigger();
	}
	}

WavFile = "staredit\\wav\\sel_o.ogg"
	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,55,ModeT2);
	},
	actions = {
		
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, FP);
		SetCDeaths(FP,SetTo,0,SelectorT);
		SetCDeaths(FP,Add,1,BGMSel);
	}
	}

		
		
	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,56*2,ModeT2);
	},
	actions = {
		SetCDeaths(FP,Add,1,ModeO);
	}
	}




Text1 = "\x13\x07난이도\x04를 선택해주세요.\n\x13\x04선택 완료 후 Y버튼을 눌러주세요. 30초 후 자동으로 \x0EEASY\x04모드가 선택됩니다."
TriggerX(FP,{},{})
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,GMode);
		CDeaths(FP,Exactly,0,ModeSel);
		CDeaths(FP,Exactly,0,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}

CIf(FP,{TTCDeaths(FP,NotSame,CurrentMode,GMode)})

WavFile = "staredit\\wav\\sel_g.ogg"
	Trigger {
	players = {FP},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
	}
	}
for i = 1,3 do
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,i,GMode);
	},
	actions = {
		SetCVar(FP,CurrentMode[2],SetTo,i);
		PreserveTrigger();
		
	},
	}
end
CIfEnd()
Text2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,ModeO);
		CDeaths(FP,AtLeast,1,ModeSel);
		CDeaths(FP,AtLeast,1,GMode);
		CDeaths(FP,Exactly,0,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, FP);
	}
	}
Text1 = "\x13\x07\n\x13\x04[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x05[E] \x11BURST\n\x13\x04난이도 선택이 완료되었습니다."
WavFile = "staredit\\wav\\Select.ogg"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeSel);
		CDeaths(FP,Exactly,1,GMode);
		CDeaths(FP,Exactly,0,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		ModifyUnitEnergy(All,201,Force2,64,0);
		ModifyUnitEnergy(All,190,Force2,64,0);
		ModifyUnitEnergy(All,63,Force2,64,0);
		ModifyUnitEnergy(All,71,Force2,64,0);
		RemoveUnit(201,Force2);
		RemoveUnit(190,Force2);
		RemoveUnit(63,Force2);
		RemoveUnit(71,Force2);
		RemoveUnitAt(All,"Buildings",17,Force2);
	},
	}
Text1 = "\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x04[W] \x08HARD\n\x13\x05[E] \x11BURST\n\x13\x04난이도 선택이 완료되었습니다."
WavFile = "staredit\\wav\\Select.ogg"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeSel);
		CDeaths(FP,Exactly,2,GMode);
		CDeaths(FP,Exactly,0,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x04[E] \x11BURST\n\x13\x04난이도 선택이 완료되었습니다."
WavFile = "staredit\\wav\\Select.ogg"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeSel);
		CDeaths(FP,Exactly,3,GMode);
		CDeaths(FP,Exactly,0,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		SetSwitch("Switch 255",Set);
		
	},
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeSel);
		CDeaths(FP,Exactly,0,BGMSel);
	},
	actions = {
		_0DPatchforT13
	}
}


CIf(FP,{CDeaths(FP,Exactly,0,ModeO),CDeaths(FP,Exactly,1,BGMSel)})



Text3 = "\x13\x18게임옵션\x04을 선택해주세요. 버튼을 누르면 On,Off 가능하며 30초 후 자동시작 됩니다."

Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,ModeO);
		CDeaths(FP,Exactly,1,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}

Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,ModeO);
		CDeaths(FP,Exactly,1,BGMSel);
	},
	actions = {
		_0DPatchforT13
	},
	}



for i = 1, #t27 do
local j
local k
if i == 1 then j=0 k=0 
elseif i == 2 then j=1 k=0 
elseif i == 3 then j=0 k=1 
elseif i == 4 then j=1 k=1 end
CIf(FP,{CDeaths(FP,Exactly,j,MarMode),CDeaths(FP,Exactly,k,NBMode)})
f_Memcpy(FP,0x641598+Str24L+(4*6)-5,_TMem(Arr(Str27[i],0),"X","X",1),Str27L[i])
CIfEnd()
end
CurrentBGM = CreateVar(FP)
CIf(FP,CDeaths(FP,Exactly,0,BGMMode))
f_Memcpy(FP,0x641598+Str24L+(4*6)+Str27L[1],_TMem(Arr(RndBGMT[3],0),"X","X",1),RndBGMT[2])
CIfEnd()
for j, k in pairs(BModeTArr) do
	CIf(FP,CDeaths(FP,Exactly,j,BGMMode))
	f_Memcpy(FP,0x641598+Str24L+(4*6)+Str27L[1],_TMem(Arr(k[3],0),"X","X",1),k[2])
	CIfEnd()
end

CIf(FP,{TTCDeaths(FP,NotSame,CurrentBGM,BGMMode)},SetCDeaths(FP,SetTo,1,Sel_G))
CMov(FP,CurrentBGM,_Read(_Ccode(FP,BGMMode)))
CIfEnd()

CIfEnd()

WavFile = "staredit\\wav\\sel_g.ogg"
	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,Sel_G);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, FP);
		SetCDeaths(FP,SetTo,0,Sel_G);
		PreserveTrigger();
	}
}


Text2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,ModeO);
		CDeaths(FP,AtLeast,1,ModeSel);
		CDeaths(FP,AtLeast,1,GMode);
		CDeaths(FP,Exactly,2,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text2,4);
		SetMemory(0x6509B0, SetTo, FP);
	}
	}
GOpT = {
	"\x13\x04[Q] \x04연습모드 \x04[W] \x08노벙커 \x03[E] \x0E선택안함",
	"\x13\x03[Q] \x04연습모드 \x04[W] \x08노벙커 \x04[E] \x0E선택안함",
	"\x13\x04[Q] \x04연습모드 \x03[W] \x08노벙커 \x04[E] \x0E선택안함",
	"\x13\x03[Q] \x04연습모드 \x03[W] \x08노벙커 \x04[E] \x0E선택안함",}
Text3 = "\x13\x18게임옵션 \x04선택이 완료되었습니다."

for i = 1, #t27 do
	local j
	local k
	if i == 1 then j=0 k=0 
	elseif i == 2 then j=1 k=0 
	elseif i == 3 then j=0 k=1 
	elseif i == 4 then j=1 k=1 end
	WavFile = "staredit\\wav\\Select.ogg"
	Trigger { -- 인트로1
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,j,MarMode),CDeaths(FP,Exactly,k,NBMode);
			CDeaths(FP,Exactly,0,ModeO);
			CDeaths(FP,Exactly,2,BGMSel);
		},
		actions = {
			SetMemory(0x6509B0, SetTo, 0);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 1);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 2);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 3);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 4);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 5);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 128);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 129);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 130);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, 131);
			PlayWAV(WavFile);
			DisplayText(Text3,4);
			DisplayText(GOpT[i],4);
			SetMemory(0x6509B0, SetTo, FP);
			
		},
		}	
	end
	

Trigger {
	players = {FP},
	conditions = {
		CDeaths(FP,Exactly,0,ModeO);
		CDeaths(FP,Exactly,2,BGMSel);
	},
	actions = {
		_0DPatchforT13
	}
}

CIfEnd()
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x15★ 마 린 키 우 기 GaLaXy.2 : RE ★\n\n\n\n\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,0,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x05★ 마 린 키 우 기 GaLaXy.2 : RE ★\n\n\n\n\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,3,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x10★ 마 린 키 우 기 GaLaXy.2 : RE ★\n\n\n\n\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,6,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x18★ 마 린 키 우 기 GaLaXy.2 : RE ★\n\n\n\n\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,9,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x0E★ 마 린 키 우 기 GaLaXy.2 : RE ★\n\n\n\n\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,12,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x11★ 마 린 키 우 기 GaLaXy.2 : RE ★\n\n\n\n\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,15,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x16★ 마 린 키 우 기 GaLaXy.2 : RE ★\n\n\n\n\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,18,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\n\n"
WavFile = "staredit\\wav\\GameStart.ogg"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21,ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\n\x13\x043\n"
WavFile = "staredit\\wav\\Countdown.ogg"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*2),ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\n\x13\x042\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*3),ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\n\x13\x041\n"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*4),ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text1,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}


WavFile = "sound\\Bullet\\pshield.wav"
Text1 = "\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\n\x13\x04START"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,isSingle);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*5),ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		CenterView(2);
		SetMemory(0x6509B0, SetTo, FP);
		
		
	},
	}
	Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,isSingle);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*5),ModeT);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text1,4);
		PlayWAV(WavFile);
		SetMemory(0x6509B0, SetTo, FP);
		
		
	},
	}

	if Limit == 1 then 

		Trigger { -- 인트로1
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,1,ModeO);
			CDeaths(FP,AtLeast,1,TestMode);
		},
		actions = {
			SetCDeaths(FP,SetTo,20+(24*5),ModeT)
			
		},
		}
	end
	Shape1013 = {6   ,{3696, 3808},{3728, 3808},{3760, 3808},{3664, 3808},{3632, 3808},{3600, 3808}}
    Shape2013 = {6   ,{3696, 3872},{3728, 3872},{3760, 3872},{3664, 3872},{3632, 3872},{3600, 3872}}
    Shape3013 = {6   ,{3696, 3744},{3728, 3744},{3760, 3744},{3664, 3744},{3632, 3744},{3600, 3744}}
    Shape4013 = {6   ,{3696, 3776},{3728, 3776},{3760, 3776},{3664, 3776},{3632, 3776},{3600, 3776}}
    Shape5013 = {6   ,{3696, 3840},{3728, 3840},{3760, 3840},{3664, 3840},{3632, 3840},{3600, 3840}}
    Shape6013 = {6   ,{3696, 3712},{3728, 3712},{3760, 3712},{3664, 3712},{3632, 3712},{3600, 3712}}
	
	MutalCreateS = {16  ,{3968, 3648},{3840, 3648},{3712, 3648},{3584, 3648},{3584, 3712},{3584, 3776},{3584, 3840},{3584, 3904},{3584, 3968},{3712, 3968},{3840, 3968},{3968, 3968},{3968, 3904},{3968, 3840},{3968, 3776},{3968, 3712}}
	ZerglingCreateS = {25  ,{3648, 3648},{3776, 3648},{3904, 3648},{3968, 3680},{3968, 3744},{3968, 3808},{3968, 3872},{3968, 3936},{3904, 3968},{3648, 3968},{3584, 3936},{3584, 3872},{3584, 3808},{3584, 3744},{3584, 3680},{3680, 3968},{3872, 3968},{3872, 3648},{3744, 3648},{3680, 3648},{3808, 3648},{3616, 3648},{3936, 3648},{3712, 3968},{3840, 3968}}
	MarCreateSh = {Shape1013,Shape2013,Shape3013,Shape4013,Shape5013,Shape6013}
CIfOnce(FP,{
	CDeaths(FP,AtLeast,1,ModeO);
	CDeaths(FP,AtLeast,21+(24*5),ModeT);
})
for i = 0, 5 do
	CSPlot(MarCreateSh[i+1],i,20,0,{0,0},1,32,FP,HumanCheck(i,1))
end
CSPlot(MutalCreateS,FP,43,0,{0,0},1,32,FP,nil)
CSPlot(ZerglingCreateS,FP,37,0,{0,0},1,32,FP,nil)


CIfEnd()
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*5),ModeT);
	},
	actions = {
		--CreateUnit(2,0,2,Force1);
		--CreateUnit(5,20,2,Force1);
		--CreateUnit(20,16,2,Force1);
		--CreateUnit(20,100,2,Force1);
		SetResources(Force1,SetTo,20000,Ore);
		SetResources(Force1,Add,1,Gas);
		SetInvincibility(Disable,"Mineral Field (Type 1)",AllPlayers,"Anywhere");
		SetInvincibility(Disable,"Mineral Field (Type 2)",AllPlayers,"Anywhere");
		SetInvincibility(Disable,"Mineral Field (Type 3)",AllPlayers,"Anywhere");
		SetInvincibility(Disable,"Vespene Geyser",AllPlayers,"Anywhere");
		SetMemory(0x5124F0,SetTo,0x1D);
		SetSwitch("Switch 201",Set);
		SetCDeaths(FP,SetTo,1,BGMType);
		SetCJump(0x103,0);
		
	},
	}
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*5),ModeT);
		CDeaths(FP,AtLeast,1,NBMode);


	},
	actions = {
		CopyCpAction({DisplayTextX("\x13\x08노벙커 플레이 보너스 \x04 : \x1F50000 Ore",4);},HumanPlayers,FP),
		SetResources(Force1,Add,50000,Ore);ModifyUnitEnergy(All,71,Force2,64,0),ModifyUnitEnergy(All,67,Force2,64,0),ModifyUnitEnergy(All,63,Force2,64,0)
		
	},
	}
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
	},
	actions = {
		SetCDeaths(FP,Add,1,ModeT);
		PreserveTrigger();
		
	},
	}
	
CIfEnd()
CMov(FP,Dx,_ReadF(0x51CE8C))
CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
CiSub(FP,Dt,Dy,Du)
--[[
TriggerX(FP,{Memory(0xA03740,Exactly,0x37373738)},{RotatePlayer({
	DisplayTextX(StrDesignX("\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.").."\n"..StrDesignX("\x04실행 방지 코드 0x32223223 작동."),4);
Defeat();
},HumanPlayers,FP);
Defeat();
SetMemory(0xCDDDCDDC,SetTo,1);})]]
--CMov(FP,0x58F500,Dt)
CMov(FP,Dv,Dt)
Count2 = CreateVar()
Count3 = CreateVar()
Count4 = CreateVar()
Count5 = CreateVar()
Count6 = CreateVar()
Count7 = CreateVar()
UnitReadX(FP,AllPlayers,229,64,count)
UnitReadX(FP,AllPlayers,5,nil,Count2)
UnitReadX(FP,AllPlayers,23,nil,Count3)
UnitReadX(FP,AllPlayers,25,nil,Count4)
UnitReadX(FP,AllPlayers,30,nil,Count5)
UnitReadX(FP,AllPlayers,3,nil,Count6)
UnitReadX(FP,AllPlayers,17,nil,Count7)

CAdd(FP,count,Count2)
CAdd(FP,count,Count3)
CAdd(FP,count,Count4)
CAdd(FP,count,Count5)
CAdd(FP,count,Count6)
CAdd(FP,count,Count7)



CIfX(FP,Never())



for i = 0, 5 do
CElseIfX(HumanCheck(i,1))
f_Read(FP,0x6284E8+(i*0x30),CUnit2,CUnit3)
--CMov(FP,Dt,_ReadF(0x58A364+48*180+4*i))--
Trigger {
	players = {FP},
	conditions = {
		Command(i,AtMost,0,218);
		Command(AllPlayers,AtLeast,1,218);		
	},
	actions = {
		GiveUnits(All,218,AllPlayers,"Anywhere",i);
		GiveUnits(All,160,AllPlayers,"Anywhere",i);
	}
}
end
CIfXEnd()
CIfOnce(FP,{TMemory(_Mem(Dt),AtLeast,10000)})
CMov(FP,Dt,0)
CIfEnd()
for i = 0,5 do
CIfX(FP,HumanCheck(i,1))
CDoActions(FP,{TSetDeathsX(i,Subtract,Dt,440,0xFFFFFF)})
CMov(FP,0x57f120 + (i*4) , CanC)
--CMov(FP,0x582174 + (i*4) , CanCount)
CElseX()
DoActions(FP,{SetDeaths(i,SetTo,0,440)})
CIfXEnd()
end
CDoActions(FP,{TSetDeathsX(FP,Subtract,Dt,440,0xFFFFFF),SetDeaths(6,SetTo,0,440),SetDeaths(8,SetTo,0,440),SetDeaths(9,SetTo,0,440),SetDeaths(10,SetTo,0,440),SetDeaths(11,SetTo,0,440),})


CIf(FP,{CVar(FP,HiddenPts[2],AtLeast,1)
})
CMov(FP,CanDefeat,0)
CMov(FP,ExchangeRate,ExrateBackup)
CIfEnd()


CIfX(FP,{CVar(FP,CUnit3[2],AtLeast,1),CVar(FP,CUnit3[2],AtMost,0x7FFFFFFF)})

CMov(FP,0x6509B0,CUnit3)

CTrigger(FP,{CDeaths(FP,AtLeast,1,TestMode),Deaths(P1,AtLeast,1,204)},{TCreateUnitWithProperties(12,100,74,P1,{energy=100})},{preserved}) -- F12 누르면 마린소환
CIfX(FP,{CDeaths(FP,AtLeast,1,TestMode),Deaths(P1,AtLeast,1,203),Switch("Switch 200",Cleared)})
DoActions(FP,MoveCp(Add,25*4))
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,AtMost,57,0,0xFF);
		
	},
	actions = {
		MoveCp(Subtract,6*4);
		SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
		MoveCp(Add,6*4);
		--MoveCp(Add,21*4);
		--SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000);
		--MoveCp(Subtract,15*4);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,AtLeast,59,0,0xFF);
		
	},
	actions = {
		MoveCp(Subtract,6*4);
		SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
		MoveCp(Add,6*4);
		--MoveCp(Add,21*4);
		--SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000);
		--MoveCp(Subtract,15*4);
		PreserveTrigger();
	}
	}
DoActions(FP,{MoveCp(Subtract,25*4),SetSwitch("Switch 200",Set)})
CElseX()
DoActions(FP,{SetSwitch("Switch 200",Clear)})
CIfXEnd()

DoActions(FP,MoveCp(Add,25*4))
CIfX(FP,{DeathsX(CurrentPlayer,Exactly,218,0,0xFF)})
DoActions(FP,MoveCp(Subtract,0x3C))
for i = 0, 10 do
CIfX(FP,{DeathsX(CurrentPlayer,AtLeast,3744+(32*i),0,0xFFFF),DeathsX(CurrentPlayer,AtMost,3744+(32*(i+1)),0,0xFFFF),TTMemory(0x5124F0,"!=",SpeedV[i+1])})
f_SaveCp()
Trigger { -- No comment (E93EF7A9)
	players = {FP},
	actions = {PreserveTrigger();
		SetMemory(0x6509B0, SetTo, 0x00000000);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 0x00000001);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 0x00000002);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 0x00000003);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 0x00000004);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 0x00000005);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV("staredit\\wav\\sel_m.ogg");DisplayText("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0);
		SetMemory(0x6509B0, SetTo, FP);
		SetMemory(0x5124F0,SetTo,SpeedV[i+1])
	},
	}
f_LoadCp()
CIfXEnd()
end
CIfXEnd()
CIfXEnd()
SetRecoverCp()
RecoverCp(FP)
CMov(FP,Du,Dy)
--]]
local TGiveComplete = CreateCcode()
NWhile(FP,CDeaths(FP,AtLeast,1,TGiveforCoCoon),{SetCDeaths(FP,Subtract,1,TGiveforCoCoon),SetCDeaths(FP,SetTo,1,TGiveComplete)})
Trigger2(FP,{Command(11,AtLeast,1,80)},{GiveUnits(1,80,11,64,7)},{preserved})
Trigger2(FP,{Command(11,AtLeast,1,21)},{GiveUnits(1,21,11,64,7)},{preserved})
Trigger2(FP,{Command(11,AtLeast,1,80)},{GiveUnits(1,80,11,64,6)},{preserved})
Trigger2(FP,{Command(11,AtLeast,1,21)},{GiveUnits(1,21,11,64,6)},{preserved})
NWhileEnd()
TriggerX(FP,{CDeaths(FP,AtLeast,1,TGiveComplete)},{
	GiveUnits(All,80,11,64,7);
	GiveUnits(All,21,11,64,6);
})
local CurCCLI = CreateVar(FP)
NIf(FP,CDeaths(FP,AtLeast,1,CocoonLaunch))
CMov(FP,0x6509B0,GunPtrMemory)
CMov(FP,CurCCLI,0)
CWhile(FP,{CVar(FP,CurCCLI[2],AtMost,14)})

CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
Trigger { -- No comment (00F60EE3)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,0*0x1000,0,0xF000);
	},
	actions = {
		SetCVar(FP,CocoonUID[2],SetTo,80);
		PreserveTrigger();
	},
	}
Trigger { -- No comment (00F60EE3)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,1*0x1000,0,0xF000);
	},
	actions = {
		SetCVar(FP,CocoonUID[2],SetTo,21);
		PreserveTrigger();
	},
	}

f_SaveCp()
CMov(FP,CPosX,_Mov(_ReadF(BackupCP),0xFFF))
CMov(FP,CPosY,_Div(_Mov(_ReadF(BackupCP),0xFFF0000),_Mov(65536)))
CDoActions(FP,{
TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
CreateUnit(1,84,1,FP)
})
f_TempRepeatX(nil,CocoonUID,1)
CMov(FP,CocoonValue2,_Mod(CocoonValue,_Mov(4)))
for i = 0, 3 do
Trigger { -- No comment (00F60EE3)
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,GunBossAct);
		CVar(FP,CocoonValue2[2],Exactly,i);
	},
	actions = {
		SetInvincibility(Enable,80,Force2,1);
		SetInvincibility(Enable,21,Force2,1);
		GiveUnits(All,80,Force2,1,11);
		GiveUnits(All,21,Force2,1,11);
		Order(80,11,1,Move,26+i);	
		Order(21,11,1,Move,26+i);
		PreserveTrigger();
	},
	}

Trigger { -- No comment (00F60EE3)
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,GunBossAct);
		CVar(FP,CocoonValue2[2],Exactly,i);
	},
	actions = {
		Order(80,Force2,1,Attack,26+i);
		Order(21,Force2,1,Attack,26+i);
		PreserveTrigger();
	},
	}

end
f_LoadCp()

CAdd(FP,CocoonValue,1)
CAdd(FP,0x6509B0,1)
CAdd(FP,CurCCLI,1)
CWhileEnd()
CIfEnd()
DoActionsX(FP,SetCDeaths(FP,Subtract,1,CocoonLaunch))
NIfEnd()


System()
onPluginStart()



CIf(AllPlayers,{Switch("Switch 201",Set)}) -- GameStart
DoActions2(FP,ButtonSetPatch2,1)
DoActionsX(FP,{SetCDeaths(FP,Add,1,WaveT)})
DoActionsX(FP,{SetCDeaths(FP,Add,24*75,WaveT)},1)



local WaveC = CreateCcode()

CIf(FP,{CDeaths(FP,AtMost,0,BossStart),CDeaths(FP,AtMost,3,WaveC),CDeaths(FP,AtLeast,24*100,WaveT)},SetCDeaths(FP,Subtract,24*300,WaveT))

GetLocCenter("Location 31",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn({CDeaths(FP,Exactly,0,WaveC)},{55,40, 54},P_4,5,"MAX")
G_CA_SetSpawn({CDeaths(FP,Exactly,1,WaveC)},{55,53, 39},P_7,3,"MAX")
G_CA_SetSpawn({CDeaths(FP,Exactly,2,WaveC)},{56,54, 53},P_6,3,"MAX")
G_CA_SetSpawn({CDeaths(FP,Exactly,3,WaveC)},{56,104, 48, 51},P_8,3,"MAX")
DoActionsX(FP,SetCDeaths(FP,Add,1,WaveC))
--TriggerX(FP,{CDeaths(FP,AtLeast,4,WaveC)},{SetCDeaths(FP,SetTo,0,WaveC)},{preserved})
CIfEnd()

CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",81)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 81",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{53, 54},P_3,4,"MAX")
CIfEnd()
CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",82)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 82",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{53, 54},P_3,4,"MAX")
CIfEnd()
CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",83)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 83",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{48,53,55},P_4,3,"MAX")
CIfEnd()
CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",84)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 84",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{51,48,56},P_4,2,"MAX")
CIfEnd()
CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",85)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 85",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{17,15,21},P_4,2,"MAX")
CIfEnd()
CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",86)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 86",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{77,78,80},S_3,1,"MAX")
CIfEnd()
CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",87)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 87",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{51,48,56},P_4,2,"MAX")
CIfEnd()
CIfOnce(FP,{Bring(Force1,AtLeast,1,"Men",88)},{})
DoActions2(FP,{CopyCpAction({PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP)})
GetLocCenter("Location 88",Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn(nil,{51,48,56},P_4,2,"MAX")
CIfEnd()
CMov(FP,Var_TempTable[2],0)
CMov(FP,Var_TempTable[3],0)


local TempUID = CreateVar(FP)
NWhile(FP,{Memory(0x628438,AtLeast,1),CV(CreateUnitStackPtr,1,AtLeast)},{})
f_SHRead(FP, _Add(CreateUnitStackXPosArr,CreateUnitStackPtr), CPosX)
f_SHRead(FP, _Add(CreateUnitStackYPosArr,CreateUnitStackPtr), CPosY)
f_SHRead(FP, _Add(CreateUnitStackUIDArr,CreateUnitStackPtr), TempUID)
DoActionsX(FP,{SubV(CreateUnitStackPtr,1)})
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
NIf(FP,{CV(TempUID,1,AtLeast)})
Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
CDoActions(FP,{TCreateUnitWithProperties(1,_Mov(TempUID,0xFF),1,FP,{energy = 100})})
NIfEnd()
NWhileEnd()




Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,GMode);
	},
	actions = {
		
		SetMemory(0x662350 + (23*4), SetTo, (23500*256));
		SetMemory(0x662350 + (74*4), SetTo, (23500*256));
		SetMemory(0x662350 + (68*4), SetTo, (23500*256));
		SetMemory(0x662350 + (32*4), SetTo, (30000*256));
		SetMemory(0x662350 + (29*4), SetTo, (30000*256));
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,GMode);
	},
	actions = {
		
		SetMemory(0x662350 + (23*4), SetTo, (75000*256));
		SetMemory(0x662350 + (74*4), SetTo, (75000*256));
		SetMemory(0x662350 + (68*4), SetTo, (100000*256));
		SetMemory(0x662350 + (32*4), SetTo, (40000*256));
		SetMemory(0x662350 + (29*4), SetTo, (40000*256));
		PreserveTrigger();
	}
}
for i = 0, 5 do
Trigger {
	players = {i},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,HMDeaths[i+1]);
	},
	actions = {
		SetCDeaths(FP,Subtract,2,HMDeaths[i+1]);
		SetScore(CurrentPlayer,Add,1,Custom);
		PreserveTrigger();
	}
}
end


CIf(FP,CDeaths(FP,AtLeast,3,GMode))
CMov(FP,ExchangeRateT,ExchangeRate)
CIf(FP,CVar(FP,ExchangeRateT[2],AtLeast,0x80000000))
CNeg(FP,ExchangeRateT)
Trigger {
	players = {FP},
	conditions = {
		Label(0);
	},
	actions = {
		SetCDeaths(FP,Add,1,ExchangeRateTMinusFlag);
	}
}
CIfEnd()
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ExchangeRateTMinusFlag);
	},
	actions = {
		SetMemoryX(0x6415BC,SetTo,0x2D*0x100,0xFF00);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,10,BonusP);
	},
	actions = {
		SetCVar(FP,PaneltyPoint[2],Subtract,1);
		SetCDeaths(FP,Subtract,10,BonusP);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,PaneltyPoint[2],AtLeast,1000);
		CDeaths(FP,Exactly,3,GMode);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		PlayWAV("sound\\Bullet\\TNsFir00.wav");
		SetMemory(0x6509B0,SetTo,FP);
		SetCVar(FP,PaneltyPoint[2],Subtract,1000);
		SetCVar(FP,ExchangeRate[2],Add,-6);
		PreserveTrigger();
	}
}

CMov(FP,PaneltyPointT,PaneltyPoint)
DoActions(FP,{
		SetMemory(0x641598, SetTo, 0x8E80E307);
		SetMemory(0x64159C, SetTo, 0x6E550820);
		SetMemory(0x6415A0, SetTo, 0x20737469);
		SetMemory(0x6415A4, SetTo, 0x0D03203A);
		SetMemory(0x6415A8, SetTo, 0x30303030);
		SetMemory(0x6415AC, SetTo, 0x202D0420);
		SetMemory(0x6415B0, SetTo, 0x63784518);
		SetMemory(0x6415B4, SetTo, 0x676E6168);
		SetMemory(0x6415B8, SetTo, 0x203A2065);
		SetMemory(0x6415BC, SetTo, 0x300D0D03);
		SetMemory(0x6415C0, SetTo, 0x25302E30);
		SetMemory(0x6415C4, SetTo, 0x202D0420);
		SetMemory(0x6415C8, SetTo, 0x30303030);
		SetMemory(0x6415CC, SetTo, 0x3030312F);
		SetMemory(0x6415D0, SetTo, 0xE3072030);
		SetMemory(0x6415D4, SetTo, 0x00008F80);
})
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,PaneltyPointT[2],AtLeast,(2^i)*1000);
		
	},
	actions = {
		SetMemoryX(0x6415C8,SetTo,(2^i)*1,2^i*1);
		SetCVar(FP,PaneltyPointT[2],Subtract,(2^i)*1000);
		PreserveTrigger();
	}
}
end

for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,PaneltyPointT[2],AtLeast,(2^i)*100);
		
	},
	actions = {
		SetMemoryX(0x6415C8,SetTo,(2^i)*256,2^i*256);
		SetCVar(FP,PaneltyPointT[2],Subtract,(2^i)*100);
		PreserveTrigger();
	}
}
end
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,PaneltyPointT[2],AtLeast,(2^i)*10);
		
	},
	actions = {
		SetMemoryX(0x6415C8,SetTo,(2^i)*65536,2^i*65536);
		SetCVar(FP,PaneltyPointT[2],Subtract,(2^i)*10);
		PreserveTrigger();
	}
}
end
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,PaneltyPointT[2],AtLeast,(2^i)*1);
		
	},
	actions = {
		SetMemoryX(0x6415C8,SetTo,(2^i)*16777216,2^i*16777216);
		SetCVar(FP,PaneltyPointT[2],Subtract,(2^i)*1);
		PreserveTrigger();
	}
}
end

for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,ExchangeRateT[2],AtLeast,(2^i)*100);
		
	},
	actions = {
		SetMemoryX(0x6415BC,SetTo,(2^i)*16777216,2^i*16777216);
		SetCVar(FP,ExchangeRateT[2],Subtract,(2^i)*100);
		PreserveTrigger();
	}
}
end
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,ExchangeRateT[2],AtLeast,(2^i)*10);
		
	},
	actions = {
		SetMemoryX(0x6415C0,SetTo,(2^i)*1,2^i*1);
		SetCVar(FP,ExchangeRateT[2],Subtract,(2^i)*10);
		PreserveTrigger();
	}
}
end
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,ExchangeRateT[2],AtLeast,(2^i)*1);
		
	},
	actions = {
		SetMemoryX(0x6415C0,SetTo,(2^i)*65536,2^i*65536);
		SetCVar(FP,ExchangeRateT[2],Subtract,(2^i)*1);
		PreserveTrigger();
	}
}
end




CIfEnd()
CIf(FP,CDeaths(FP,AtMost,2,GMode))
DoActions(FP,{
		SetMemory(0x641598, SetTo, 0x8E80E307);
		SetMemory(0x64159C, SetTo, 0x6E550820);
		SetMemory(0x6415A0, SetTo, 0x20737469);
		SetMemory(0x6415A4, SetTo, 0x0D03203A);
		SetMemory(0x6415A8, SetTo, 0x30303030);
		SetMemory(0x6415AC, SetTo, 0x80E30720);
		SetMemory(0x6415B0, SetTo, 0x0000008F);
})


CIfEnd()


--[[
Trigger { -- 지속캔낫 감지용
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,count[2],AtMost,GunLimit);
	},
	actions = {
		SetCVar(FP,CanDefeat[2],Subtract,1);
		PreserveTrigger();
	}
}]]
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,count[2],AtLeast,(2^i)*1000);
		
	},
	actions = {
		SetMemoryX(0x6415A8,SetTo,(2^i)*1,2^i*1);
		SetCVar(FP,count[2],Subtract,(2^i)*1000);
		PreserveTrigger();
	}
}
end
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,count[2],AtLeast,(2^i)*100);
		
	},
	actions = {
		SetMemoryX(0x6415A8,SetTo,(2^i)*256,2^i*256);
		SetCVar(FP,count[2],Subtract,(2^i)*100);
		PreserveTrigger();
	}
}
end
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,count[2],AtLeast,(2^i)*10);
		
	},
	actions = {
		SetMemoryX(0x6415A8,SetTo,(2^i)*65536,2^i*65536);
		SetCVar(FP,count[2],Subtract,(2^i)*10);
		PreserveTrigger();
	}
}
end
for i = 3, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,count[2],AtLeast,(2^i)*1);
		
	},
	actions = {
		SetMemoryX(0x6415A8,SetTo,(2^i)*16777216,2^i*16777216);
		SetCVar(FP,count[2],Subtract,(2^i)*1);
		PreserveTrigger();
	}
}
end

CIf(FP,CDeaths(FP,AtLeast,1,TestMode))
local TestPatch = {}
	for j = 0, 5 do
	table.insert(TestPatch,SetMemoryB(0x58D088+(46*j)+14,SetTo,255))
	table.insert(TestPatch,SetMemoryB(0x58D088+(46*j)+13,SetTo,255))
	end
Trigger {
	players = {FP},
	conditions = {
		Command(P1,AtLeast,1,32);
	},
	actions = {
		--CreateUnit(20,100,35,P1);
		PreserveTrigger();
	}
}

--DoActions(FP,ModifyUnitHitPoints(All,"Men",force1,64,100))
Trigger {
	players = {FP},
	conditions = {
		Deaths(P1,AtLeast,1,214);
	},
	actions = {
		KillUnit("Men",Force2);
		KillUnit("Sunken Colony",Force2);
		KillUnit("Creep Colony",Force2);
		KillUnit("Spore Colony",Force2);
		KillUnit(179,Force2);
		KillUnit(180,Force2);
		PreserveTrigger();
	}
	}
	DoActions(FP,{CreateUnit(1,12,2,Force1),TestPatch},1)
CIfEnd()
CIfOnce(FP,CDeaths(FP,AtLeast,1,LimitX))
CIfEnd()
CIf(FP,Command(AllPlayers,AtLeast,1,"Dark Swarm"))
DoActions(FP,{MoveLocation(1,"Dark Swarm",AllPlayers,"Anywhere"),CreateUnit(1,84,1,FP),CreateUnit(1,21,1,P7),CreateUnit(1,80,1,P8)})

CreateUnitPolygonSafe2Gun(FP,Always(),19,0,32,64,30,6,1,P8,{1,51})
DoActions(FP,RemoveUnitAt(1,"Dark Swarm",1,AllPlayers))
DoActions(FP,{KillUnit(84,FP),KillUnit(72,FP)})
CIfEnd()

-- 193번 오브젝트(프로토스 마커, 파일런 깨면 나오는거) 존재시 처리
CIf(FP,Command(AllPlayers,AtLeast,1,193))
DoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,32),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,32),
})
CWhile(FP,Bring(FP,AtLeast,1,193,64))
DoActions(FP,{
MoveLocation(1,193,FP,"Anywhere"),
CreateUnit(1,84,1,FP),
GiveUnits(All,193,FP,"Anywhere",6)})

CWhileEnd()
DoActions(FP,{GiveUnits(All,193,6,"Anywhere",FP),Order(193,AllPlayers,"Anywhere",Move,2),SetSwitch("Switch 10",Random),SetSwitch("Switch 11",Random)})
DoActions(FP,{
		SetMemory(0x662350 + (74*4), SetTo, (150000*256)/3);
})

CreateUnitPolygonSafeWithPropertiesGun(FP,Bring(FP,AtLeast,1,193,2),13,1,32,128,30,4,1,P8,{1,74,1,88,1,65,1,66},{hitpoint = 50})
DoActions(FP,{
		SetMemory(0x662350 + (74*4), SetTo, (150000*256));
})
CreateUnitStarSafeGun(FP,Bring(FP,AtLeast,1,193,2),31,1,32,128,126,5,108,1,FP,{1,84})
Trigger {
	players = {FP},
		conditions = {
			Bring(FP,AtLeast,1,193,2);
			},
	actions = {
		SetDeaths(FP,Add,1,156);
		KillUnitAt(1,193,2,AllPlayers);
		PreserveTrigger();
		},
	}
wav = "staredit\\wav\\zealot1.ogg"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,193,2);
	Switch("Switch 10",Cleared);
	Switch("Switch 11",Cleared);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
wav = "staredit\\wav\\zealot2.ogg"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,193,2);
	Switch("Switch 10",Set);
	Switch("Switch 11",Cleared);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
wav = "staredit\\wav\\zealot3.ogg"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,193,2);
	Switch("Switch 10",Cleared);
	Switch("Switch 11",Set);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
wav = "staredit\\wav\\zealot4.ogg"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,193,2);
	Switch("Switch 10",Set);
	Switch("Switch 11",Set);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
CIfEnd()

CIf(FP,Command(AllPlayers,AtLeast,1,192))
DoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,0),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,0),
})
CWhile(FP,Bring(FP,AtLeast,1,192,64))
DoActions(FP,{
MoveLocation(1,192,FP,"Anywhere"),
CreateUnit(1,9,1,FP),
GiveUnits(All,192,FP,"Anywhere",6)})
CWhileEnd()
DoActions(FP,{GiveUnits(All,192,6,"Anywhere",FP),Order(192,AllPlayers,"Anywhere",Move,2),SetSwitch("Switch 10",Random),SetSwitch("Switch 11",Random)})
DoActions(FP,{
		SetMemory(0x662350 + (23*4), SetTo, (50000*256)/3);
		SetMemory(0x662350 + (32*4), SetTo, (30000*256)/2);
})
CreateUnitPolygonSafeWithPropertiesGun(FP,Bring(FP,AtLeast,1,192,2),13,1,32,128,30,4,1,P8,{1,23,1,29,1,3,1,32},{hitpoint = 50})
CreateUnitPolygonSafe2Gun(FP,Bring(FP,AtLeast,1,192,2),13,1,32,128,30,4,1,P8,{1,23,1,29,1,3,1,32})
DoActions(FP,{
		SetMemory(0x662350 + (23*4), SetTo, (150000*256));
		SetMemory(0x662350 + (32*4), SetTo, (60000*256));
})
CreateUnitStarSafeGun(FP,Bring(AllPlayers,AtLeast,1,192,2),31,1,32,128,126,5,108,1,FP,{1,84})
Trigger {
	players = {FP},
		conditions = {
			Bring(FP,AtLeast,1,192,2);
			},
	actions = {
		SetDeaths(FP,Add,1,153);
		KillUnitAt(1,192,2,AllPlayers);
		PreserveTrigger();
		},
	}
wav = "sound\\Zerg\\BUGGUY\\ZBGPss00.wav"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,192,2);
	Switch("Switch 10",Cleared);
	Switch("Switch 11",Cleared);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
wav = "sound\\Zerg\\BUGGUY\\ZBGPss01.wav"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,192,2);
	Switch("Switch 10",Set);
	Switch("Switch 11",Cleared);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
wav = "sound\\Zerg\\BUGGUY\\ZBGPss02.wav"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,192,2);
	Switch("Switch 10",Cleared);
	Switch("Switch 11",Set);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
wav = "sound\\Zerg\\BUGGUY\\ZBGPss03.wav"
Trigger2X(FP,{
	Bring(AllPlayers,AtLeast,1,192,2);
	Switch("Switch 10",Set);
	Switch("Switch 11",Set);
},{RotatePlayer({
	PlayWAVX(wav);
	PlayWAVX(wav);
	PlayWAVX(wav);},HumanPlayers,FP);},{preserved})
CIfEnd()



for i=0, 2 do
Trigger {
	players = {P7},
	conditions = {
		--Deaths(FP,AtMost,0,200);
		CommandLeastAt(168,34+i);
	},
	actions = {
		SetDeathsX(FP,Add,1,168,0xFF);
		SetDeathsX(FP,SetTo,(2^i)*0x10000,168,(2^i)*(0x10000));
	}
}
end
	GName = "수호자의 감옥 \x18Stasis Cell \x04을"
	GPoint = 300000
	Mode = 0
	GunText = "\n\n\n\n\n\n\n\n\n\x13\x08！ ！ ！ \x04적 "..GName.." 파괴하였다!\x17 + "..GPoint.." P t s\x08 ！ ！ ！\n\n"
	Trigger {
	players = {FP},
		conditions = {
		Label(0);
		DeathsX(FP,AtLeast,1,168,0xFF);
		CVar(FP,Cell_R[2],Exactly,0);
			},
		
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(GunText,4);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0, SetTo, FP);
		SetScore(Force1,Add,GPoint,Kills);
		SetCVar(FP,Cell_R[2],SetTo,3172);
		SetDeathsX(FP,Subtract,1,168,0xFF);
		SetDeathsX(8,Add,1,168,0xFF);
		SetCDeaths(FP,SetTo,300,DBossGen);
		PreserveTrigger();
		},
	}
NIf(FP,CVar(FP,Cell_R[2],Exactly,0))
TriggerX(FP,{CGMode(1),DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^0)*(0x10000))},{SetCDeaths(FP,Add,1,BossKill)},{preserved})
TriggerX(FP,{CGMode(1),DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^1)*(0x10000))},{SetCDeaths(FP,Add,1,BossKill)},{preserved})
TriggerX(FP,{CGMode(1),DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^2)*(0x10000))},{SetCDeaths(FP,Add,1,BossKill)},{preserved})
CIfOnce(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtMost,5999,GunBossAct),CDeaths(FP,AtLeast,2,GMode),DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^0)*(0x10000))})
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
CMov(FP,TBossHPPtr,Nextptrs,2)
DoActions(FP,{CreateUnit(1,5,34,FP),SetMemoryX(0x664080+(25*4),SetTo,4,4)})


CDoActions(FP,{TSetMemory(_Add(Nextptrs,2),SetTo,3000000*256),TSetMemory(_Mem(TBossHP),SetTo,3000000*256)})

BText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※\n\n\n\x13\x04적의 \x08수호자 \x11Ｃ\x04ａｌｃｕｌａｔｏ\x08Ｒ \x04가 깨어났습니다.\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※"
	Trigger {
	players = {FP},
		conditions = {
		Label(0);
			},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
		},
	}

CIfEnd()
CIfOnce(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtMost,5999,GunBossAct),CDeaths(FP,AtLeast,2,GMode),DeathsX(FP,Exactly,(2^1)*0x10000,168,(2^1)*(0x10000))})
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
CMov(FP,DBossPlaguePatch,Nextptrs,70)
DoActions(FP,CreateUnit(1,11,35,FP))
CDoActions(FP,{TSetMemory(_Add(Nextptrs,2),SetTo,5000000*256)})
BText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※\n\n\n\x13\x04적의 \x08수호자 \x11Ｄ\x0Eｒｏｐ\x08Ｄ\x04ｅａｄ \x04가 깨어났습니다.\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※"
	Trigger {
	players = {FP},
		conditions = {
		Label(0);
			},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
		},
	}

CIfEnd()
CIfOnce(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtLeast,2,GMode),CDeaths(FP,AtLeast,6000,GunBossAct),CDeaths(FP,AtLeast,2,FormCon)})
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
DoActions(FP,CreateUnit(1,82,36,FP))
CMov(FP,Boss1_H,Nextptrs,2)
CDoActions(FP,{TSetMemory(_Add(Nextptrs,2),SetTo,6000000*256),TSetDeaths(_Add(Nextptrs,13),SetTo,0,0),TSetDeathsX(_Add(Nextptrs,18),SetTo,0,0,0xFFFF)})
BText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※\n\n\n\x13\x04적의 \x08수호자 \x08Ｇ\x11ａｒ\x18Ｇ\x10ａｎ\x1FＴ\x17ｕ\x0FＡ \x04가 깨어났습니다.\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※"
	Trigger {
	players = {FP},
		conditions = {
		Label(0);
			},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(BText,4);
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		PlayWAV("sound\\Terran\\MARINE\\TMaPss06.WAV");
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
		},
	}

CIfEnd()

BKillPoint({DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^0)*(0x10000))},5,1000000,"\x11Ｃ\x04ａｌｃｕｌａｔｏ\x08Ｒ")
BKillPoint({DeathsX(FP,Exactly,(2^1)*0x10000,168,(2^1)*(0x10000)),CDeaths(FP,AtMost,0,DBossGen)},11,1000000,"\x11Ｄ\x0Eｒｏｐ\x08Ｄ\x04ｅａｄ")
NIfEnd()


BKillPoint({CDeaths(FP,AtLeast,6000,GunBossAct),CDeaths(FP,AtLeast,2,FormCon)},82,2000000,"\x08Ｇ\x11ａｒ\x18Ｇ\x10ａｎ\x1FＴ\x17ｕ\x0FＡ")
NIf(FP,Bring(FP,AtLeast,1,5,64))
local TBossT = CreateCcode()

--
--
local TBossTxt1 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n   \x07 :: \x11Ｃ\x04ａｌｃｕｌａｔｏ\x08Ｒ \x07::\r\n\x08적 \x17전투력 \x1F계산 \x04중...\r\n\r\n  "
local TBossTxt2 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n   \x07 :: \x11Ｃ\x04ａｌｃｕｌａｔｏ\x08Ｒ \x07::\r\n\x06적 \x17전투력 \x1F계산 \x07완료. \x08공격력이 재설정 되었습니다.\r\n\r\n  "

--
DoActionsX(FP,SetCDeaths(FP,Add,1,TBossT))
DoActionsX(FP,SetCDeaths(FP,Add,250,TBossT),1)
Trigger2X(FP,{CDeaths(FP,Exactly,50,TBossT)},{CopyCpAction({
	TalkingPortrait(5, 6100),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV");
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV");
	DisplayTextX(TBossTxt1,4)
},HumanPlayers,FP)},{preserved})
Trigger2X(FP,{CDeaths(FP,Exactly,250,TBossT)},{CopyCpAction({
	TalkingPortrait(5, 6100),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV");
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV");
	DisplayTextX(TBossTxt2,4)
},HumanPlayers,FP)},{preserved})
Simple_SetLocX(FP,"TBossLoc",0,0,480,480,{MoveLocation("TBossLoc",5,FP,64)})
CIf(FP,CDeaths(FP,AtLeast,250,TBossT),{SetCDeaths(FP,SetTo,0,TBossT)})
UnitReadX(FP,Force1,"Men","TBossLoc",B1_Calc)

CAdd(FP,B1_Calc,2)
CIf(FP,CDeaths(FP,Exactly,2,GMode))
f_Mul(FP,B1_Calc,100)
CIfEnd()
CIf(FP,CDeaths(FP,Exactly,3,GMode))
f_Mul(FP,B1_Calc,300)
CIfEnd()

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,B1_Calc[2],AtLeast,65535);
	},
	actions = {
		SetCVar(FP,B1_Calc[2],SetTo,65535);
	}
}
CDoActions(FP,{TSetMemoryX(0x656EC4, SetTo, _Mul(B1_Calc,65536),_Mov(0xFFFF0000))})
CIfEnd()
NIf(FP,{TTMemory(TBossHPPtr,NotSame,TBossHP)})
f_Read(FP,TBossHPPtr,TBossHPTemp)
CAdd(FP,TBossSkill,_Sub(TBossHP,TBossHPTemp))
CDoActions(FP,{TSetMemory(_Mem(TBossHP),SetTo,TBossHPTemp)})
NIfEnd()

NWhile(FP,{CVar(FP,TBossSkill[2],AtLeast,10000*256)},{SetCVar(FP,TBossSkill[2],Subtract,10000*256),SetCVar(FP,TB_A[2],Add,10)})
f_Lengthdir(FP,250,TB_A,TB_X,TB_Y)

CDoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,32),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,32),
MoveLocation(1,5,FP,64),
TSetMemory(0x58DC60 + 0x14*0,Add,TB_X),
TSetMemory(0x58DC68 + 0x14*0,Add,TB_X),
TSetMemory(0x58DC64 + 0x14*0,Add,TB_Y),
TSetMemory(0x58DC6C + 0x14*0,Add,TB_Y),CreateUnit(1,69,1,FP),CreateUnit(1,84,1,FP),
})

NIf(FP,CDeaths(FP,AtLeast,3,GMode))
f_Lengthdir(FP,250+64,TB_A,TB_X,TB_Y)

CDoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,32),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,32),
MoveLocation(1,5,FP,64),
TSetMemory(0x58DC60 + 0x14*0,Add,TB_X),
TSetMemory(0x58DC68 + 0x14*0,Add,TB_X),
TSetMemory(0x58DC64 + 0x14*0,Add,TB_Y),
TSetMemory(0x58DC6C + 0x14*0,Add,TB_Y),CreateUnit(1,69,1,FP),CreateUnit(1,84,1,FP),
})
f_Lengthdir(FP,250+128,TB_A,TB_X,TB_Y)

CDoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,32),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,32),
MoveLocation(1,5,FP,64),
TSetMemory(0x58DC60 + 0x14*0,Add,TB_X),
TSetMemory(0x58DC68 + 0x14*0,Add,TB_X),
TSetMemory(0x58DC64 + 0x14*0,Add,TB_Y),
TSetMemory(0x58DC6C + 0x14*0,Add,TB_Y),CreateUnit(1,69,1,FP),CreateUnit(1,84,1,FP),
})
NIfEnd()

NWhileEnd()
NIfEnd()

NIf(FP,Bring(FP,AtLeast,1,11,64))
CTrigger(FP,CVar(FP,DBossPlaguePatch[2],AtLeast,1),{TSetMemoryX(DBossPlaguePatch,SetTo,0,0xFF0000)},1)
DoActions(FP,SetSwitch("Switch 1",Random))
Trigger {
	players = {FP},
	conditions = {
		Switch("Switch 1",Set);
	},
	actions = {
		SetMemoryB(0x6636B8+204, SetTo, 60); -- 무기변경
		PreserveTrigger();
		
	}
}
Trigger {
	players = {FP},
	conditions = {
		Switch("Switch 1",Cleared);
	},
	actions = {
		SetMemoryB(0x6636B8+204, SetTo, 84); -- 무기변경
		PreserveTrigger();
		
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,GMode);
	},
	actions = {
		SetMemoryX(0x656F58,SetTo,2222,0xFFFF);
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,3,GMode);
	},
	actions = {
		SetMemoryX(0x656F58,SetTo,3333,0xFFFF);
	}
}

f_Lengthdir(FP,DBossR,DBossA,DBossX,DBossY)
DoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,32),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,32),
MoveLocation(1,11,FP,64),
})
CreateBulletPosCalc(204,20,DBossA,DBossX,DBossY)

f_Lengthdir(FP,DBossR,_Add(DBossA,180),DBossX,DBossY)
DoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,32),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,32),
MoveLocation(1,11,FP,64),
})
CreateBulletPosCalc(204,20,DBossA,DBossX,DBossY)
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,DBossR[2],AtMost,0);
	},
	actions = {
		SetCVar(FP,DBossD[2],SetTo,0);
		SetCVar(FP,DBossU[2],SetTo,1);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,DBossR[2],AtLeast,500);
	},
	actions = {
		SetCVar(FP,DBossD[2],SetTo,1);
		SetCVar(FP,DBossU[2],SetTo,0);
		PreserveTrigger();
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,DBossU[2],AtLeast,1);
	},
	actions = {
		SetCVar(FP,DBossR[2],Add,15);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,DBossD[2],AtLeast,1);
	},
	actions = {
		SetCVar(FP,DBossR[2],Subtract,15);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,DBossA[2],AtLeast,180);
		
	},
	actions = {
		SetCVar(FP,DBossA[2],Subtract,180);
		PreserveTrigger();
	}
}

CAdd(FP,DBossA,6)
NIfEnd()
NIf(FP,Command(FP,AtLeast,1,82))
CTrigger(FP,{
CDeaths(FP,Exactly,2,GMode),
TMemory(Boss1_H,AtMost,6000000*256)},
{TSetMemory(Boss1_H, Add, _Sub(_Mov(1500*256),_Mul(HiddenATKM,_Mov(300*256))))},1)
CTrigger(FP,{
CDeaths(FP,Exactly,3,GMode),
TMemory(Boss1_H,AtMost,8000000*256)},
{TSetMemory(Boss1_H, Add, _Sub(_Mov(3500*256),_Mul(HiddenATKM,_Mov(700*256))))},1)


Trigger {
	players = {FP},
		conditions = {
		Label(0);
		Bring(Force1, AtLeast, 1, "Men", 36)
			},
	actions = {
		SetCVar(FP,B1_U[2],Add,1);
		SetCVar(FP,B1_D[2],SetTo,0);
		PreserveTrigger();
		},
	}
Trigger {
	players = {FP},
		conditions = {
		Label(0);
		Bring(Force1, Exactly, 0, "Men", 36)
			},
	actions = {
		SetCVar(FP,B1_D[2],Add,1);
		SetCVar(FP,B1_U[2],SetTo,0);
		PreserveTrigger();
		},
	}
CMov(FP,B1_E,B1_C)

NIf(FP,CVar(FP,B1_F[2],Exactly,30),SetCVar(FP,B1_F[2],SetTo,0))
-- 이하 모두 수정 요망
DoActions(FP,{
--SetMemoryW(0x656EB0 + (124*2), SetTo, 7), -- 공격력
SetMemoryB(0x6636B8+204, SetTo, 124), -- 무기변경
--SetMemoryB(0x6566F8+124, SetTo, 3), -- 스플설정
--SetMemoryW(0x656888 + (2*124), SetTo, 384), -- 스플
--SetMemoryW(0x6570C8 + (2*124), SetTo, 384), -- 스플
--SetMemoryW(0x657780 + (2*124), SetTo, 384), -- 스플
})
NWhile(FP,CVar(FP,B1_E[2],AtLeast,1),SetCVar(FP,B1_E[2],Subtract,1))
RandRet2 = CreateVar(FP)
CPosX2 = CreateVar(FP)
CPosY2 = CreateVar(FP)

local Randnum = f_CRandNum(360)
CMov(FP,RandRet2,Randnum)
f_Mod(FP,InputMaxRand,_Rand(),_Mov(10*32))
CallTriggerX(FP,CRandNum,nil,{SetCVar(FP,Oprnd[2],SetTo,0)})
f_Lengthdir(FP,TempRandRet,RandRet2,CPosX2,CPosY2)
GetLocCenter("36",B1_X,B1_Y)
CAdd(FP,B1_X,CPosX2)
CAdd(FP,B1_Y,CPosY2)
local Randnum = f_CRandNum(256)

CreateBullet(204,20,Randnum,{B1_X,B1_Y})


NWhileEnd()

NIfEnd()

CAdd(FP,B1_F,1)


NIf(FP,{CVar(FP,B1_U[2],Exactly,30),CDeaths(FP,Exactly,2,GMode)},SetCVar(FP,B1_U[2],SetTo,0))

Trigger {
	players = {FP},
		conditions = {
		Label(0);
		CVar(FP,B1_C[2],AtMost,128);
			},
	actions = {
		SetMemoryB(0x669E28 + 557,SetTo,17);
		SetMemoryB(0x669E28 + 558,SetTo,17);
		SetMemoryB(0x669E28 + 559,SetTo,17);
		SetCVar(FP,B1_C[2],Add,1);
		CreateUnitWithProperties(1, 84, 36, FP, { hallucinated = true });
		KillUnit(84,FP);
		PreserveTrigger();
		},
	}
NIfEnd()
NIf(FP,{CVar(FP,B1_U[2],Exactly,21),CDeaths(FP,Exactly,3,GMode)},SetCVar(FP,B1_U[2],SetTo,0))
Trigger {
	players = {FP},
		conditions = {
		Label(0);
		CVar(FP,B1_C[2],AtMost,128);
			},
	actions = {
		SetMemoryB(0x669E28 + 557,SetTo,17);
		SetMemoryB(0x669E28 + 558,SetTo,17);
		SetMemoryB(0x669E28 + 559,SetTo,17);
		SetCVar(FP,B1_C[2],Add,1);
		CreateUnitWithProperties(1, 84, 36, FP, {hallucinated=true});
		KillUnit(84,FP);
		PreserveTrigger();
		},
	}
NIfEnd()

NIf(FP,{CVar(FP,B1_D[2],Exactly,24*2)},SetCVar(FP,B1_D[2],SetTo,0))

Trigger {
	players = {FP},
		conditions = {
		Label(0);
		CVar(FP,B1_C[2],AtLeast,1);
			},
	actions = {
		SetMemoryB(0x669E28 + 557,SetTo,10);
		SetMemoryB(0x669E28 + 558,SetTo,10);
		SetMemoryB(0x669E28 + 559,SetTo,10);
		SetCVar(FP,B1_C[2],Subtract,1);
		CreateUnitWithProperties(1, 84, 36, FP, {hallucinated=true});
		KillUnit(84,FP);
		PreserveTrigger();
		},
	}
NIfEnd()
NIfEnd()



NIf(FP,CVar(FP,Cell_R[2],AtLeast,1))
CMov(FP,Gun_W,0)
NWhile(FP,{CVar(FP,Gun_W[2],AtMost,4)},SetCVar(FP,Gun_W[2],Add,1))
f_Lengthdir(FP,_Sub(Cell_R,100),_Add(_Mul(Gun_W,_Mov(72)),Cell_A),Gun_X,Gun_Y)
CAdd(FP,Gun_X,1024)
CAdd(FP,Gun_Y,2400)
Simple_SetLocX(FP,0,Gun_X,Gun_Y,Gun_X,Gun_Y)
DoActions(FP,{
		SetMemoryX(0x666458, SetTo, 391,0xFFFF);
		SetMemoryX(0x669FAC, SetTo, 13*16777216,0xFF000000);
CreateUnit(1,33,1,FP)
})
NIf(FP,{CDeaths(FP,AtLeast,2,GMode),CDeaths(FP,AtLeast,1,GunBossAct),CDeaths(FP,AtMost,5999,GunBossAct),CDeaths(FP,Exactly,0,GunBossT),CVar(FP,Cell_R[2],AtLeast,100)})


Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,1);
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,2);
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,3);
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,4);
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,5);
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,FP);
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,Cell_R[2],AtMost,0);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		RunAIScript("Turn OFF Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,1);
		RunAIScript("Turn OFF Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,2);
		RunAIScript("Turn OFF Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,3);
		RunAIScript("Turn OFF Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,4);
		RunAIScript("Turn OFF Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,5);
		RunAIScript("Turn OFF Shared Vision for Player 8");
		SetMemory(0x6509B0,SetTo,FP);
	}
}



for i = 1, #GunBossUIDArr do
Trigger {
	players = {FP},
		conditions = {
		Label(0);
		CVar(FP,Gun_W[2],Exactly,i);
			},
	actions = {
		SetCVar(FP,GunBoss_UID[2],SetTo,GunBossUIDArr[i]);
		PreserveTrigger();
		},
	}
end

NIf(FP,{
Memory(0x58DC60 + 0x14*0,AtMost,4096),
Memory(0x58DC68 + 0x14*0,AtMost,4096),
Memory(0x58DC64 + 0x14*0,AtMost,4096),
Memory(0x58DC6C + 0x14*0,AtMost,4096)})
CIf(FP,Memory(0x628438,AtLeast,1))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
CDoActions(FP,{
TCreateUnit(1,GunBoss_UID,1,FP),
TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
TGiveUnits(All,GunBoss_UID,FP,"Anywhere",11),
TSetInvincibility(Enable,GunBoss_UID,11,64)
})
CIfEnd()

NIfEnd()
NIfEnd()
NWhileEnd()
CAdd(FP,Cell_A,10)
CSub(FP,Cell_R,15)
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,Cell_A[2],AtLeast,72);
	},
	actions = {
		SetCVar(FP,Cell_A[2],Subtract,72);
		PreserveTrigger();
	}
}





NIfEnd()


NIf(FP,{CDeaths(FP,AtLeast,2,GMode),Deaths(8,Exactly,3,168),CDeaths(FP,AtMost,6000,GunBossAct)})

CIfOnce(FP)
f_ForcePosSave(nil,1000,1024,2400,0)
CIfEnd()



GunBossPatchArr = {}
GunBossPatchArr2 = {}
for i = 1, #GunBossUIDArr do
Trigger {
	players = {FP},
		conditions = {
		Label(0);
		CDeaths(FP,AtLeast,i*1000,GunBossAct);
			},
	actions = {
		GiveUnits(All,GunBossUIDArr[i],11,"Anywhere",FP);
		SetInvincibility(Disable,GunBossUIDArr[i],FP,64);
		RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
		
		},
	}
end
for i = 1, #GunBossUIDArr2 do
table.insert(GunBossPatchArr,SetMemoryX(0x664080+(GunBossUIDArr2[i]*4),SetTo,4,4))
table.insert(GunBossPatchArr2,SetMemoryX(0x664080+(GunBossUIDArr2[i]*4),SetTo,0,4))
end

Trigger {
	players = {FP},
		conditions = {
		Label(0);
		CVar(FP,Cell_R[2],AtMost,0);
			},
	actions = {
		SetCDeaths(FP,Add,1,GunBossAct);
		SetCDeaths(FP,Add,1,GunBossT2);
		SetCDeaths(FP,Add,1,GunBossT3);
		PreserveTrigger();
		},
	}

Trigger {
	players = {FP},
		conditions = {
		Label(0);
		
		CDeaths(FP,Exactly,2,GMode);
		CDeaths(FP,AtLeast,250,GunBossT2);
			},
	actions = {
		SetCDeaths(FP,SetTo,0,GunBossT2);
		SetCDeaths(FP,SetTo,1,CocoonLaunch);
		PreserveTrigger();
		},
	}


Trigger {
	players = {FP},
		conditions = {
		Label(0);
		
		CDeaths(FP,Exactly,3,GMode);
		CDeaths(FP,AtLeast,75,GunBossT2);
			},
	actions = {
		SetCDeaths(FP,SetTo,0,GunBossT2);
		SetCDeaths(FP,SetTo,1,CocoonLaunch);
		PreserveTrigger();
		},
	}
Trigger {
	players = {FP},
		conditions = {
		Label(0);
			},
	actions = {
		SetCDeaths(FP,SetTo,7,BGMType);
		SetCDeaths(FP,Add,1,GunBossAct);
		GunBossPatchArr;
		},
	}
Trigger {
	players = {FP},
	conditions = {Label(0);
		CDeaths(FP,Exactly,6000,GunBossAct)
	},
	actions = {GunBossPatchArr2
	}
}

NIfEnd()
AtkUpgradePtrArr = {}
AtkUpgradeMaskRetArr = {}
for i = 0, 5 do
table.insert(AtkUpgradeMaskRetArr,(0x58D2B0+(i*46)+7)%4)
table.insert(AtkUpgradePtrArr,0x58D2B0+(i*46)+7 - AtkUpgradeMaskRetArr[i+1])
end
DefUpgradePtrArr = {}
DefUpgradeMaskRetArr = {}
for i = 0, 5 do
table.insert(DefUpgradeMaskRetArr,(0x58D2B0+(i*46))%4)
table.insert(DefUpgradePtrArr,0x58D2B0+(i*46) - DefUpgradeMaskRetArr[i+1])
end

SuUpgradePtrArr = {}
SuUpgradeMaskRetArr = {}
for i = 0, 5 do
table.insert(SuUpgradeMaskRetArr,(0x58D2B0+(i*46)+14)%4)
table.insert(SuUpgradePtrArr,0x58D2B0+(i*46)+14 - SuUpgradeMaskRetArr[i+1])
end
QuaUpgradePtrArr = {}
QuaUpgradeMaskRetArr = {}
for i = 0, 5 do
table.insert(QuaUpgradeMaskRetArr,(0x58D2B0+(i*46)+12)%4)
table.insert(QuaUpgradePtrArr,0x58D2B0+(i*46)+12 - QuaUpgradeMaskRetArr[i+1])
end

for i=0, 5 do
	for j = 1, 5 do
TriggerX(i,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+7,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+8,SetTo,0),
	SetMemoryB(0x58D088+(46*i)+9,SetTo,0)
})

TriggerX(i,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+14,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+13,SetTo,0),
})
TriggerX(i,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+12,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+11,SetTo,0),
})

end

TriggerX(i,{CVar(FP,HiddenATKM[2],Exactly,0),MemoryB(0x58D2B0+(46*i)+7,Exactly,255)},{
	SetMemoryB(0x58D088+(46*i)+8,SetTo,0),
	SetMemoryB(0x58D088+(46*i)+9,SetTo,0)
})
Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D2B0+(46*i)+0,Exactly,255);
	},
	actions = {
		SetMemoryB(0x58D088+(46*i)+1,SetTo,0);
		SetMemoryB(0x58D088+(46*i)+2,SetTo,0);
	}
}

Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D2B0+(46*i)+14,Exactly,255);
	},
	actions = {
		SetMemoryB(0x58D088+(46*i)+13,SetTo,0);
		PreserveTrigger()
	}
}
Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D2B0+(46*i)+12,Exactly,255);
	},
	actions = {
		SetMemoryB(0x58D088+(46*i)+11,SetTo,0);
		PreserveTrigger()
	}
}


end




CMov(FP,TempUpgradeMaskRet,0)
CMov(FP,TempUpgradePtr,0)
CMov(FP,CurrentUpgrade,0)
CMov(FP,CurrentFactor,0)
CMov(FP,UpCount,0)
for i = 0, 5 do
CIf(FP,HumanCheck(i,1))
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+8,Exactly,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(AtkUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk)

})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+9,Exactly,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(AtkUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,10),
	SetMemoryB(0x58D2B0+(46*i)+9,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk),

})

CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+1,Exactly,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(DefUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,DefFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0)

})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+2,Exactly,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(DefUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,DefFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,10),
	SetMemoryB(0x58D2B0+(46*i)+2,SetTo,0),

})

CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+13,Exactly,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(SuUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^SuUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,SuFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+13,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk),
})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+11,Exactly,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(QuaUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^QuaUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,QuaFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+11,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk),
})


CIfEnd()
end

CIf(FP,Deaths(Force1,AtLeast,1,8))
CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025 + (84*1699)+19))
for i = 0, 5 do
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,i,0,0xFF);
		Deaths(i,AtLeast,1,8);
	},
	actions = {
		MoveCp(Add,50*4);
		SetDeathsX(CurrentPlayer,SetTo,255*256,0,0xFF00);
		MoveCp(Subtract,50*4);
		PreserveTrigger();
	}
}
end
CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
DoActions(FP,SetDeaths(Force1,SetTo,0,8))
CIfEnd()

CIf(FP,CDeaths(FP,AtLeast,1,MultiCon))
local OrderCool = CreateCcodeArr(6)
local CUnitFlag = CreateCcode()
local MulCon = CreateVarArr(6,FP)
local TempPos = CreateVar(FP)
MCButtonUID = {53,52,54,48,49,55}

for i = 0, 5 do
for j, k in pairs(MCButtonUID) do
	local X = {}
	if k == 54 or k == 48 or k == 49 or k==55 then
		X = {SetCDeaths(FP,Add,100,OrderCool[i+1])}
	else
		X = nil
	end
	Trigger { -- 버튼 기능
		players = {i},
		conditions = {
			Label(0);
			Bring(i,AtLeast,1,k,64);
		},
		actions = {
			SetDeaths(i,SetTo,1,k);
			RemoveUnitAt(1,k,"Anywhere",i);
			SetCDeaths(FP,Add,1,CUnitFlag);
			X;
			PreserveTrigger();
		},
	}
end
end

CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag))
for i = 0, 5 do
	GetLocCenter(73+i,CPosX,CPosY)
	CMov(FP,MulCon[i+1],_Add(CPosX,_Mul(CPosY,_Mov(0x10000))))
end
CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	CIf(FP,{DeathsX(CurrentPlayer,AtMost,6,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})
	f_SaveCp()
	for i = 0, 5 do
	CIf(FP,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF)})
	f_SaveCp()
	local ValCancle = def_sIndex()
	NJump(FP,ValCancle,{TMemory(_Add(BackupCP,6),Exactly,58)})
	CTrigger(FP,{Deaths(i,AtLeast,1,53),TTDeathsX(BackupCP,NotSame,5*256,0,0xFF00)}, -- Stop
	{TSetDeathsX(BackupCP,SetTo,1*256,0,0xFF00)},{preserved})
	CIf(FP,{Deaths(i,AtLeast,1,52),TTDeathsX(BackupCP,NotSame,5*256,0,0xFF00)}) -- Hold
		f_Read(FP,_Sub(BackupCP,9),TempPos)
		CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,107*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCP,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCP,15),SetTo,TempPos,0)})
	CIfEnd()
	CIf(FP,{Deaths(i,AtLeast,1,54),TTDeathsX(BackupCP,NotSame,5*256,0,0xFF00)}) -- Move
		CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,6*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,MulCon[i+1],0),TSetDeaths(_Add(BackupCP,3),SetTo,MulCon[i+1],0),TSetDeaths(_Sub(BackupCP,15),SetTo,MulCon[i+1],0)})
	CIfEnd()
	CIf(FP,{Deaths(i,AtLeast,1,48),TTDeathsX(BackupCP,NotSame,5*256,0,0xFF00)}) -- Attack
		CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,14*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,MulCon[i+1],0),TSetDeaths(_Add(BackupCP,3),SetTo,MulCon[i+1],0),TSetDeaths(_Sub(BackupCP,15),SetTo,MulCon[i+1],0)})
	CIfEnd()
	CIf(FP,{Deaths(i,AtLeast,1,49),TTDeathsX(BackupCP,NotSame,5*256,0,0xFF00)}) -- JYD
		f_Read(FP,_Sub(BackupCP,9),TempPos)
		CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,187*256,0,0xFF00),TSetDeaths(_Sub(BackupCP,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCP,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCP,15),SetTo,TempPos,0)})
	CIfEnd()
	CIf(FP,{Deaths(i,AtLeast,1,55),TTDeathsX(BackupCP,NotSame,5*256,0,0xFF00)}) -- MoveControl(Stop)
		f_Read(FP,_Sub(BackupCP,9),TempPos)
		CDoActions(FP,{TSetDeaths(_Add(BackupCP,4),SetTo,0,0),TSetDeathsX(BackupCP,SetTo,23*256,0,0xFF00)})
	CIfEnd()
	NJumpEnd(FP,ValCancle)
	f_LoadCp()
	CIfEnd()
	end
	CIfEnd()
	CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
DoActionsX(FP,{SetDeaths(Force1,SetTo,0,49),SetDeaths(Force1,SetTo,0,48),SetDeaths(Force1,SetTo,0,54),SetDeaths(Force1,SetTo,0,52),SetDeaths(Force1,SetTo,0,53),SetCDeaths(FP,SetTo,0,CUnitFlag)})
CIfEnd()
local OrderCooltime2 = {}
for i = 0, 5 do
local OrderCooltime = {}
local OrderCooltimeRecover = {}
table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+54,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+48,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+49,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+54,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+48,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+49,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
table.insert(OrderCooltime2,SetCDeaths(FP,Subtract,1,OrderCool[i+1]))

TriggerX(FP,{CDeaths(FP,AtLeast,1,OrderCool[i+1])},{OrderCooltime},{preserved})
TriggerX(FP,{CDeaths(FP,Exactly,0,OrderCool[i+1])},{OrderCooltimeRecover},{preserved})
end
DoActionsX(FP,OrderCooltime2)

CIfEnd()--MultiCon

CIf(FP,CDeaths(FP,AtLeast,100,ZombieCheck),SetCDeaths(FP,Subtract,100,ZombieCheck))
CMov(FP,0x6509B0,19025)
CWhile(FP,Memory(0x6509B0,AtMost,19025 + (84*1699)))
DoActions(FP,MoveCp(Add,2*4))

CIf(FP,Deaths(CurrentPlayer,AtMost,0,0))
DoActions(FP,MoveCp(Add,17*4))
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00);
	},
	actions = {
		MoveCp(Subtract,17*4);
		SetDeaths(CurrentPlayer,Add,256*1,0);
		MoveCp(Add,17*4);
		PreserveTrigger();
	}
}

DoActions(FP,MoveCp(Subtract,17*4))
CIfEnd()
DoActions(FP,MoveCp(Subtract,2*4))
CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
CIfEnd()

Trigger { -- 스캔이펙트 조절트리거
players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,ScanEffT);
	},
	actions = {
		SetCDeaths(FP,Add,4,ScanEffT);
		PreserveTrigger();
	},
}


Trigger { -- 스캔이펙트 조절트리거
players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,GMode);
		CDeaths(FP,AtMost,0,GunBossT);
	},
	actions = {
		SetCDeaths(FP,Add,5,GunBossT);
		PreserveTrigger();
	},
}


Trigger { -- 스캔이펙트 조절트리거
players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,3,GMode);
		CDeaths(FP,AtMost,0,GunBossT);
	},
	actions = {
		SetCDeaths(FP,Add,3,GunBossT);
		PreserveTrigger();
	},
}
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,HealT),SetCDeaths(FP,Subtract,1,HondonT),SetCDeaths(FP,Subtract,1,CanCT),SetCDeaths(FP,Add,1,ZombieCheck),SetCDeaths(FP,Subtract,1,ScanEffT),SetCDeaths(FP,Subtract,1,GunBossT),SetCDeaths(FP,Subtract,1,DBossGen)})
Trigger { -- 동맹상태 고정, 중립마린 제거
	players = {Force1},
	actions = {
		SetAllianceStatus(Force1,Ally);
		SetAllianceStatus(P12,Enemy);
		RunAIScript("Turn ON Shared Vision for Player 1");
		RunAIScript("Turn ON Shared Vision for Player 2");
		RunAIScript("Turn ON Shared Vision for Player 3");
		RunAIScript("Turn ON Shared Vision for Player 4");
		RunAIScript("Turn ON Shared Vision for Player 5");
		KillUnitAt(All,125,47,P12);
		PreserveTrigger();
	},
}
CIf(FP,{CDeaths(FP,AtMost,0,HealT);})
Trigger { -- 힐존트리거
players = {FP},
	conditions = {
		Label(0);
	},
	actions = {
		SetCDeaths(FP,Add,50,HealT);
		ModifyUnitHitPoints(All,"Men",Force1,2,100);
		ModifyUnitShields(All,"Men",Force1,2,100);
		PreserveTrigger();
	},
}
QuaToken = CreateCcodeArr(6)
for i = 0, 5 do
	TriggerX(FP,{HumanCheck(i,1),Bring(i,AtLeast,1,60,2)},{SetCD(QuaToken[i+1],1)},{preserved})
end
CIfEnd()

DifLeaderBoard = {
"\x04 - \x0EEASY \x04Mode",
"\x04 - \x08HARD \x04Mode",
"\x04 - \x11BURST \x04Mode"}
for i = 1, 3 do
CIf(FP,CDeaths(FP,Exactly,i,GMode))
Trigger { -- 킬 포인트 리더보드, 집근처 유닛 오더시키기, 쉴드 회복, 저글링 히드라 어택땅
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(FP,AtMost,0,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Kills, "\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x11Points"..DifLeaderBoard[i]);
		LeaderBoardComputerPlayers(Disable);
		PreserveTrigger();
	},
	}

Trigger { -- 데스 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(FP,Exactly,400,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Custom, "\x08Deaths..."..DifLeaderBoard[i]);
		LeaderBoardComputerPlayers(Disable);
		--Order("Factories",Force2,"Anywhere",Patrol,5);
		--Order("Men",P8,140,Patrol,5);
		
		Order("Men",Force2,25,Patrol,2);
		Order("Devouring One", Force2, "Anywhere", Attack, 2);
		Order("Devourer", Force2, "Anywhere", Attack, 2);
		Order("Scourge", Force2, "Anywhere", Attack, 2);
		Order("Torrasque", Force2, "Anywhere", Attack, 2);
		Order("Infested Kerrigan", Force2, "Anywhere", Attack, 2);
		Order("Infested Duran", Force2, "Anywhere", Attack, 2);
		Order("Protoss Arbiter", Force2, "Anywhere", Attack, 2);
		Order("Zergling", Force2, "Anywhere", Attack, 2);
		Order("Hydralisk", Force2, "Anywhere", Attack, 2);
		Order("Ultralisk", Force2, "Anywhere", Attack, 2);
		Order("Hunter Killer", Force2, "Anywhere", Attack, 2);
		Order("Kukulza Mutalisk", Force2, "Anywhere", Attack, 2);
		Order("Kukulza Guardian", Force2, "Anywhere", Attack, 2);
		Order("Mutalisk", Force2, "Anywhere", Attack, 2);
		Order("Guardian", Force2, "Anywhere", Attack, 2);
		Order("Any unit",Force2,45,Attack,2);
		Order("Any unit",Force2,46,Attack,2);
		Order(121, Force2, "Anywhere", Attack, 2);
		PreserveTrigger();
		},
}
Trigger { -- 킬 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(FP,Exactly,200,LeaderBoardT);
	},
	actions = {
		LeaderBoardKills("Any unit","\x06Kill \x0FCounts"..DifLeaderBoard[i]);
		LeaderBoardComputerPlayers(Disable);
		ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
		PreserveTrigger();
		},
}
Trigger { -- 리더보드 총괄
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,LeaderBoardT);
	},
	actions = {
		SetCDeaths(FP,SetTo,600,LeaderBoardT);
		PreserveTrigger();
	},
	}
CIfEnd()
end
DoActionsX(FP,{
SetCDeaths(FP,Subtract,1,LeaderBoardT)
})

ShToken = CreateCcodeArr(6)
for i = 0, 5 do
Trigger { -- 메딕트리거
	players = {i},
	conditions = {
		Label(0);
		Command(i, AtLeast, 1, 34);
	},
	actions = {
		ModifyUnitHitPoints(All, "Men", i, "Anywhere", 100);
		ModifyUnitHitPoints(All, "Buildings", i, "Anywhere", 100);
		RemoveUnitAt(1,34,"Anywhere",i);
		SetCDeaths(FP,Add,1,ShToken[i+1]);
		SetCDeaths(FP,Add,1,QuaToken[i+1]);
		PreserveTrigger();
	},
	}
Trigger { -- 메딕트리거
	players = {i},
	conditions = {
		Label(0);
		Command(i, AtLeast, 1, 9);
	},
	actions = {
		ModifyUnitHitPoints(All, "Men", i, "Anywhere", 100);
		ModifyUnitHitPoints(All, "Buildings", i, "Anywhere", 100);
		RemoveUnitAt(1,9,"Anywhere",i);
		SetCDeaths(FP,Add,1,ShToken[i+1]);
		SetCDeaths(FP,Add,1,QuaToken[i+1]);
		PreserveTrigger();
	},
	}
end
CIfX(FP,CGMode(2,AtLeast))
for i = 0, 5 do
CTrigger(FP,{CDeaths(FP,AtLeast,1,ShToken[i+1])},{TModifyUnitShields(All, "Men", i, "Anywhere", MarSh),SetCDeaths(FP,Subtract,1,ShToken[i+1])},1)
end
CElseX()
for i = 0, 5 do
CTrigger(FP,{CDeaths(FP,AtLeast,1,ShToken[i+1])},{ModifyUnitShields(All, "Men", i, "Anywhere", 100),SetCDeaths(FP,Subtract,1,ShToken[i+1])},1)
end

CIfXEnd()

for i = 1, 5 do -- 강퇴기능

Trigger { -- 강퇴토큰
	players = {FP},
	conditions = {
		Label(0);
		Command(Force1,AtLeast,1,BanToken[i]);
	},
	actions = {
		RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);
		SetCDeaths(FP,Add,1,BanCode[i]);
		PreserveTrigger();
		},
	}
Trigger { -- 강퇴
	players = {i},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,5,BanCode[i]);
	},
	actions = {
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x07『 \x04당신은 강되당했습니다.\x07 』",4);
		Defeat();
		},
	}
	end
	
for i = 0,5 do
TriggerX(i,{
	CVar(FP,HiddenATK[2],AtLeast,1);
	MemoryB(0x58D2B0+(46*i)+7,AtLeast,255);},{SetCDeaths(FP,SetTo,1,OneStim[i+1])})

TriggerX(i,{
	CDeaths(FP,AtLeast,1,isSingle);
	MemoryB(0x58D2B0+(46*i)+7,AtLeast,255);},{SetCDeaths(FP,SetTo,1,OneStim[i+1])})
Trigger { -- 공업완료시 스팀 활성화
	players = {i},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,OneStim[i+1]);
	},
	actions = {
		DisplayText(string.rep("\n", 20),4);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
		DisplayText("\n",4);
		DisplayText("\x13\x03공격력 \x04업그레이드를 완료하였습니다.\n\x13\x04이제부터 \x1B원격 스팀팩\x04을 사용할 수 있습니다.",0);
		DisplayText("\n",4);
		DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		SetMemoryB(0x57F27C+(228*i)+8,SetTo,1);
		PlayWAV("staredit\\wav\\Unlock.ogg");
		PlayWAV("staredit\\wav\\Unlock.ogg");
		PlayWAV("staredit\\wav\\Unlock.ogg");
	},
}
Trigger { -- 스팀팩
	players = {i},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,OneStim[i+1]);
		Command(i,AtLeast,1,8);
	},
	actions = {
		SetDeaths(i,Add,1,8);
		RemoveUnitAt(1,8,"Anywhere",i);
		DisplayText("\x07『 \x04원격 \x1B스팀팩\x04기능을 사용합니다.\x07 』",4);
		PreserveTrigger();
	},
}
end
Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		Label(0);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x12\x04일반모드 조합법\n\x12\x1BH \x04Marine + \x1F30000원 \x04= \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\n\x12\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04*3 + \x1F30000원 + \x076 Gas \x04= \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04 \n\x12\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04*2 + \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04 +  SCV*3 + \x1F50000원 + \x0712 Gas \x04= \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ\n\x12\x04방업할 시 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x08HP\x04와 \x1CShields \x0F증가\x12\x04환전 : \x03F12키\n\x12\x04닫기 : \x03Delete",4);
		PreserveTrigger();
	},
}
	if Limit == 1 then
	Trigger2(FP,{ElapsedTime(AtLeast,75)},{RotatePlayer({DisplayTextX("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 "..YY.."년 "..MM.."월 "..DD.."일 "..HH.."시 까지입니다."),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
	end
	Trigger2(FP,{ElapsedTime(AtLeast,60)},{RotatePlayer({DisplayTextX(InFormation,4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
	
Trigger { -- 채팅창 정리 delete키
	players = {Force1},
	conditions = {
		
		Memory(0x596A44, Exactly, 65536);
},
	actions = {
		DisplayText(string.rep("\n", 20),4);
		PreserveTrigger();
		},
	}
for j = 0, 5 do
UpText1 = "\x0D\x0D\x0DDef"..Player[j+1].._0D
UpText2 = "\x13\x04\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04의 \x08체력\x04이 일정량 증가하였습니다."
Trigger2X(FP,{CGMode(1),MemoryB(0x58D2B0+(46*j),AtLeast,255);},{
	RotatePlayer({
		DisplayTextX(string.rep("\n", 20),4),
		DisplayTextX("\x13\x04"..string.rep("―", 56),4),
		DisplayTextX("\x13\x1FＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ\n\n\n",0),
		DisplayTextX(UpText1,0),
		DisplayTextX(UpText2,0),
		DisplayTextX("\n\n\x13\x1FＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
		DisplayTextX("\x13\x04"..string.rep("―", 56),4),
		PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
		PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
		PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
	},HumanPlayers,FP);})
UpText2 = "\x13\x04\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04의 \x08체력\x04과 모든 마린의 \x1C쉴드 \07회복 상한\x04이 일정량 증가하였습니다."
Trigger2X(FP,{CGMode(2,AtLeast),MemoryB(0x58D2B0+(46*j),AtLeast,255);},{
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x1FＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ\n\n\n",0),
			DisplayTextX(UpText1,0),
			DisplayTextX(UpText2,0),
			DisplayTextX("\n\n\x13\x1FＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
	},HumanPlayers,FP);})
end

BanCode2 = CreateCcodeArr(6)
WarnCT = CreateVarArr(6)
MacroWarn = "\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n"..StrDesignX("\x08매크로 또는 핵이 감지되었습니다.").."\n"..StrDesignX("\x08패널티로 모든 미네랄, 유닛 몰수, 무한 찌릿찌릿이 제공됩니다.").."\n\n\x14\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x0D\x0D\x13\x04"
for i = 0, 5 do
	CIf(FP,HumanCheck(i,1),SubV(WarnCT[i+1],1))
	TriggerX(FP, {Deaths(i,AtLeast,1,140)},{SetCD(BanCode2[i+1],1)})
	TriggerX(FP, {CD(BanCode2[i+1],1)}, {
		SetMemory(0x59CC78, SetTo, -1048576),
		SetMemory(0x59CC80, SetTo, 2),SetCp(i),PlayWAV("staredit\\wav\\zzirizziri.ogg"),PlayWAV("staredit\\wav\\zzirizziri.ogg"),DisplayText(MacroWarn, 4),SetCp(FP),SetResources(i, SetTo, 0, Ore),ModifyUnitEnergy(All, "Men", i, 64, 0),ModifyUnitEnergy(All, "Buildings", i, 64, 0),RemoveUnit("Men", i),RemoveUnit(203, i),RemoveUnit(125, i)},{preserved})

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			LocalPlayerID(i);
			CD(BanCode2[i+1],1)
		},
		actions = {
			SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1);
		},
		flag = {preserved}
	}
	Trigger2X(FP,{CDeaths(FP,AtLeast,1,BanCode2[i+1]);},{RotatePlayer({DisplayTextX(StrDesign("\x04"..PlayerString[i+1].."\x04가 매크로를 사용하여 \x08찌리리릿 500배 \x04당하셨습니다."),4),PlayWAVX("staredit\\wav\\zzirizziri.ogg"),PlayWAVX("staredit\\wav\\zzirizziri.ogg")},HumanPlayers,FP);})


	CIfEnd()
end





CIfX(FP,{CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode),TTOR({--히든모드가 켜져있고  4옵션 셋중 하나라도 켜져있으면 캔낫시 정야독과 유닛파괴만
	CV(HiddenPts,1,AtLeast),
	CV(HiddenATK,1,AtLeast),
	CV(HiddenPts,1,AtLeast),
	CV(AtkSpeedMode,1,AtLeast),
	
})})
--히든모드 캔
CIf(FP,{--캔발동
	CV(CanCount,0,AtMost);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	SetCp(P7),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCp(P8),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCDeaths(FP,SetTo,24*7,CanCT);
<<<<<<< HEAD
})
Trigger2X(FP,{},{
	RotatePlayer({
		DisplayTextX("\x13\x08! ! ! WARNING - C C M U   D E T E C T E D  - WARNING ! ! !",4),
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\warn.wav"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
		},HumanPlayers,FP);
},{preserved})
CIfEnd()
CElseX()
CIf(FP,{--캔발동
	CV(CanCount,0,AtMost);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	SetCp(P7),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCp(P8),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCDeaths(FP,SetTo,24*7,CanCT);
=======
>>>>>>> 30371757d54ebff2ac33ddc280996f0e51b9e22a
	AddV(CanCount,1);

	SetMemory(0x582174 + (0*4),Add,2),
	SetMemory(0x582174 + (1*4),Add,2),
	SetMemory(0x582174 + (2*4),Add,2),
	SetMemory(0x582174 + (3*4),Add,2),
	SetMemory(0x582174 + (4*4),Add,2),
	SetMemory(0x582174 + (5*4),Add,2),
})
Trigger2X(FP,{},{
	RotatePlayer({
		DisplayTextX("\x13\x08! ! ! WARNING - C C M U   D E T E C T E D  - WARNING ! ! !\n\x13\x08COUNT 3 LEFT",4),
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\warn.wav"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
		},HumanPlayers,FP);
},{preserved})
CIfEnd()

CIf(FP,{--캔발동
	CV(CanCount,1,Exactly);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	SetCp(P7),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCp(P8),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCDeaths(FP,SetTo,24*7,CanCT);
	AddV(CanCount,1);
	SetMemory(0x582174 + (0*4),Add,2),
	SetMemory(0x582174 + (1*4),Add,2),
	SetMemory(0x582174 + (2*4),Add,2),
	SetMemory(0x582174 + (3*4),Add,2),
	SetMemory(0x582174 + (4*4),Add,2),
	SetMemory(0x582174 + (5*4),Add,2),})
Trigger2X(FP,{},{
	RotatePlayer({
		DisplayTextX("\x13\x08! ! ! WARNING - C C M U   D E T E C T E D  - WARNING ! ! !\n\x13\x08COUNT 2 LEFT",4),
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\warn.wav"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
		},HumanPlayers,FP);
},{preserved})
CIfEnd()
CIfOnce(FP, {--캔발동
	CV(CanCount,2,AtLeast);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	SetCp(P7),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCp(P8),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	AddV(CanCount,1);
	SetMemory(0x582174 + (0*4),Add,2),
	SetMemory(0x582174 + (1*4),Add,2),
	SetMemory(0x582174 + (2*4),Add,2),
	SetMemory(0x582174 + (3*4),Add,2),
	SetMemory(0x582174 + (4*4),Add,2),
	SetMemory(0x582174 + (5*4),Add,2),
	SetCDeaths(FP,SetTo,24*7,CanCT);})

	Trigger2X(FP,{},{
		RotatePlayer({
		DisplayTextX("\x13\x08! ! ! WARNING - C C M U   D E T E C T E D  - WARNING ! ! !\n\x13\x08COUNT 1 LEFT",4),
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\warn.wav"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
			},HumanPlayers,FP);
			
	})
CIfEnd()

CIfOnce(FP, {--캔발동
	CV(CanCount,3,AtLeast);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	SetCp(P7),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	SetCp(P8),RunAIScriptAt("Set Unit Order To: Junk Yard Dog","Anywhere");
	AddV(CanCount,1);
	SetMemory(0x582174 + (0*4),Add,2),
	SetMemory(0x582174 + (1*4),Add,2),
	SetMemory(0x582174 + (2*4),Add,2),
	SetMemory(0x582174 + (3*4),Add,2),
	SetMemory(0x582174 + (4*4),Add,2),
	SetMemory(0x582174 + (5*4),Add,2),
	SetCDeaths(FP,SetTo,24*7,CanCT);})



	Trigger2X(FP,{},{
		RotatePlayer({
			DisplayTextX("\x13\x08! ! ! WARNING - C C M U   D E T E C T E D  - WARNING ! ! !\n\x13\x08COUNT 0 DEFEAT",4),
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\CanOver.ogg"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
			},HumanPlayers,FP);
			RotatePlayer({Defeat()}, Force1, FP)
			
	})
CIfEnd()
CIfXEnd()


--[[
Trigger { -- 지속캔낫 감지용
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,BossStart);
		Memory(0x628438,AtMost,0);
	},
	actions = {
		SetCVar(FP,CanDefeat[2],Add,5);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,CanDefeat[2],AtLeast,2000);
	},
	actions = {
		SetCDeaths(FP,Add,1,GameOver);
	}
}
CanWarn = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n\x13\x04캔낫을 의도적으로 걸 경우 게임에서 \x08패배\x04합니다.\n\x13\x04\x07저그 인구수\x04가 \x08１０００\x04이상 \x10증가\x04하지 않도록 \x08주의\x04해 주시기 바랍니다.\n\x14\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CVar(FP,CanDefeat[2],AtLeast,1);
	},
	actions = {
		DisplayText(CanWarn,4);
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		
	}
}
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CVar(FP,CanDefeat[2],AtLeast,400);
	},
	actions = {
		DisplayText(CanWarn,4);
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		
	}
}
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CVar(FP,CanDefeat[2],AtLeast,800);
	},
	actions = {
		DisplayText(CanWarn,4);
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		
	}
}
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CVar(FP,CanDefeat[2],AtLeast,1200);
	},
	actions = {
		DisplayText(CanWarn,4);
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		
	}
}
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CVar(FP,CanDefeat[2],AtLeast,1600);
	},
	actions = {
		DisplayText(CanWarn,4);
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		PlayWAV("sound\\Terran\\RAYNORM\\URaPss02.WAV");
		
	}
}

CIf(FP,CDeaths(FP,AtLeast,1,GameOver)) -- 패배트리거
Trigger2X(FP,{
	CDeaths(FP,AtMost,0,TestMode);
	CDeaths(FP,AtLeast,1,GameOver);},{
	CopyCpAction({Defeat()},Force1,FP)})
DoActionsX(FP,SetCDeaths(FP,Add,1,GameOver))
CIfEnd() -- 패배트리거 끝

]]


for j = 0, 5 do -- 소환


Trigger { -- 소환 마린
	players = {j},
	conditions = {
		Command(j,AtLeast,1,"Terran Firebat");
	},
	actions = {
		RemoveUnitAt(1,"Terran Firebat","Anywhere",j);
		CreateUnitWithProperties(1,20,2,j,{energy = 100});
		DisplayText("\x02▶ \x1BH \x04Marine을 \x19소환\x04하였습니다. - \x1F"..MarCost.." O r e",4);
		SetDeaths(j,SetTo,1,101);
		PreserveTrigger();
	},
}
Trigger { -- 소환 갤마
	players = {j},
	conditions = {
		Command(j,AtLeast,1,2);
		Deaths(j,AtMost,23,125);
	},
	actions = {
		SetResources(j,Add,GMCost+MarCost,Ore);
		RemoveUnitAt(1,2,"Anywhere",j);
		DisplayText("\x02▶ \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x0424기 조합) 자원 반환 + \x1F"..(GMCost+MarCost).." O r e",4);
		PreserveTrigger();
	},
}

Trigger { -- 소환 갤마
	players = {j},
	conditions = {
		Deaths(j,AtLeast,24,125);
		Command(j,AtLeast,1,2);
	},
	actions = {
		RemoveUnitAt(1,2,"Anywhere",j);
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine을 \x19소환\x04하였습니다. - \x1F"..(GMCost+MarCost).." O r e",4);
		CreateUnitWithProperties(1,100,2,j,{energy = 100});
		SetDeaths(j,SetTo,1,101);
		PreserveTrigger();
	},
}

--[[
Trigger { -- 조합 영웅마린
	players = {j},
	conditions = {
		Bring(j,AtLeast,1,0,3);
		Accumulate(j,AtLeast,10000,Ore);
	},
	actions = {
		ModifyUnitEnergy(1,0,j,3,0);
		SetResources(j,Subtract,10000,Ore);
		RemoveUnitAt(1,0,3,j);
		CreateUnit(1,"H Marine",2,j);
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x04Marine을 \x1BH \x04Marine으로 \x19변환\x04하였습니다. - \x1F10000 O r e",4);
		PreserveTrigger();
	},
}
]]
Trigger { -- 조합 갤럭시 마린
	players = {j},
	conditions = {
		Bring(j,AtLeast,1,20,3);
		Accumulate(j,AtLeast,GMCost,Ore);
	},
	actions = {
		ModifyUnitEnergy(1,20,j,3,0);
		SetResources(j,Subtract,GMCost,Ore);
		RemoveUnitAt(1,20,3,j);
		CreateUnitWithProperties(1,"GaLaXy Marine",2,j,{energy = 100});
		SetDeaths(j,Add,1,125);
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x1BH \x04Marine을 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine으로 \x19변환\x04하였습니다. - \x1F"..GMCost.." O r e",4);
		SetDeaths(j,SetTo,1,101);
		PreserveTrigger();
	},
}
local CreateNe = CreateCcodeArr(6)
local CreateTe = CreateCcodeArr(6)
local CreateSu = CreateCcodeArr(6)
local CreateQua = CreateCcodeArr(6)
local BUpEnable = CreateCcodeArr(6)
local QUpEnable = CreateCcodeArr(6)
Trigger { -- 조합 네뷸라
	players = {j},
	conditions = {
		Label(0);
		CVar(FP,CanC[2],AtLeast,6);
		Command(j,AtMost,0,16);
		Bring(j,AtLeast,3,100,3);
		Accumulate(j,AtLeast,NeCost,Ore);
	},
	actions = {
		ModifyUnitEnergy(3,100,j,3,0);
		SetResources(j,Subtract,NeCost,Ore);
		RemoveUnitAt(3,100,3,j);
		--
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine 을 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ 으로 \x19변환\x04하였습니다. - \x1F"..NeCost.." O r e\n",4);
		SetDeaths(j,SetTo,1,101);
		SetCDeaths(FP,Add,1,CreateNe[j+1]);
		PreserveTrigger();
	},
}
Trigger { -- 조합 테라
	players = {j},
	conditions = {
		Label(0);
		CVar(FP,CanC[2],AtLeast,12);
		Command(j,AtMost,0,0);
		Bring(j,AtLeast,1,16,3);
		Bring(j,Exactly,2,100,3);
		Bring(j,Exactly,3,"Terran SCV",3);
		Accumulate(j,AtLeast,TeCost,Ore);
	},
	actions = {
		ModifyUnitEnergy(2,100,j,3,0);
		ModifyUnitEnergy(1,16,j,3,0);
		SetResources(j,Subtract,TeCost,Ore);
		RemoveUnitAt(1,16,3,j);
		RemoveUnitAt(2,100,3,j);
		RemoveUnitAt(3,"Terran SCV",3,j);
		--
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04, \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04, SCV 를 \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ 으로 \x19변환\x04하였습니다. - \x1F"..TeCost.." O r e\n",4);
		SetDeaths(j,SetTo,1,101);
		SetCDeaths(FP,Add,1,CreateTe[j+1]);
		PreserveTrigger();
	},
}
--Trigger { -- 조합 핵배틀
--	players = {j},
--	conditions = {
--		Label(0);
--		CDeaths(FP,AtMost,0,MarMode);
--		MemoryB(0x58D2B0+(j*46)+7,AtLeast,255);
--		MemoryB(0x58D2B0+(j*46),AtLeast,255);
--		Command(j,AtMost,0,12);
--		Command(j,AtMost,0,60);
--		Bring(j,Exactly,10,100,3);
--		Bring(j,Exactly,0,"Terran SCV",3);
--		Bring(j,Exactly,0,124,3);
--		Bring(j,Exactly,0,125,3);
--		Bring(j,Exactly,1,16,3);
--		Bring(j,Exactly,1,0,3);
--		Deaths(j,AtLeast,36,125);
--		Accumulate(j,AtLeast,SuCost,Ore);
--	},
--	actions = {
--		ModifyUnitEnergy(10,100,j,3,0);
--		ModifyUnitEnergy(1,16,j,3,0);
--		ModifyUnitEnergy(1,0,j,3,0);
--		SetResources(j,Subtract,SuCost,Ore);
--		RemoveUnitAt(10,100,3,j);
--		RemoveUnitAt(1,16,3,j);
--		RemoveUnitAt(1,0,3,j);
--		--
--		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04, SCV를 \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ 로 \x19변환\x04하였습니다. - \x1F"..SuCost.." O r e\n",4); -- \x02▶ \x04모든 옵션 적용으로 \x11얼마든지 \x04보유 가능"
--		--SetMemoryB(0x58D088+(46*j)+14,SetTo,255);
--		SetCDeaths(FP,Add,1,CreateSu[j+1]);
--		SetCDeaths(FP,Add,1,BUpEnable[j+1]);
--		SetMemoryB(0x58D088+(46*j)+13,SetTo,255);
--		PreserveTrigger();
--	},
--}
--Trigger { -- 조합 퀘이사
--	players = {j},
--	conditions = {
--		Label(0);
--		CDeaths(FP,AtMost,0,MarMode);
--		MemoryB(0x58D2B0+(j*46)+14,AtLeast,255);
--		Command(j,AtMost,0,60);
--		Bring(j,Exactly,1,12,3);
--		Bring(j,Exactly,0,100,3);
--		Bring(j,Exactly,0,"Terran SCV",3);
--		Bring(j,Exactly,0,124,3);
--		Bring(j,Exactly,0,125,3);
--		Bring(j,Exactly,0,16,3);
--		Bring(j,Exactly,0,0,3);
--		Accumulate(j,AtLeast,QuaCost,Ore);
--	},
--	actions = {
--		ModifyUnitEnergy(1,12,j,3,0);
--		SetResources(j,Subtract,QuaCost,Ore);
--		RemoveUnitAt(1,12,3,j);
--		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ \x04를 \x11Ｑ\x1FＵ\x1BＡ\x16Ｓ\x10Ａ\x1DＲ \x04로 \x19변환\x04하였습니다. - \x1F".. QuaCost.." O r e\n",4); -- \x02▶ \x04모든 옵션 적용으로 \x11얼마든지 \x04보유 가능"
--		--SetMemoryB(0x58D088+(46*j)+14,SetTo,255);
--		SetCDeaths(FP,Add,1,CreateQua[j+1]);
--		SetCDeaths(FP,Add,1,QUpEnable[j+1]);
--		SetMemoryB(0x58D088+(46*j)+11,SetTo,255);
--		PreserveTrigger();
--	},
--}
for i = 1, 5 do

Trigger {
	players = {j},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,BUpEnable[j+1]);
		CVar(FP,HiddenATKM[2],Exactly,i);
	},
	actions = {
		SetMemoryB(0x58D088+(j*46)+14,SetTo,50+(200-(40*i)));
	}
}

Trigger {
	players = {j},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,QUpEnable[j+1]);
		CVar(FP,HiddenATKM[2],Exactly,i);
	},
	actions = {
		SetMemoryB(0x58D088+(j*46)+12,SetTo,50+(200-(40*i)));
	}
}
end

Trigger {
	players = {j},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,BUpEnable[j+1]);
		CVar(FP,HiddenATKM[2],Exactly,0);
	},
	actions = {
		SetMemoryB(0x58D088+(j*46)+14,SetTo,255);
	}
}
Trigger {
	players = {j},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,QUpEnable[j+1]);
		CVar(FP,HiddenATKM[2],Exactly,0);
	},
	actions = {
		SetMemoryB(0x58D088+(j*46)+12,SetTo,255);
	}
}
local NePtr = CreateVarArr(6,FP)
local TePtr = CreateVarArr(6,FP)
local SuPtr = CreateVarArr(6,FP)
local QuaPtr = CreateVarArr(6,FP)
local NeSkill = CreateCcodeArr(6)
local TeSkill = CreateCcodeArr(6)
local SuSkill = CreateCcodeArr(6)
local QuaSkill = CreateCcodeArr(6)
CIf(FP,{HumanCheck(j,1)})

CIf(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtLeast,1,CreateNe[j+1]),Command(j,AtMost,0,16)},{SetCDeaths(FP,SetTo,0,CreateNe[j+1])}) -- 소환 또는 조합시
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
CMov(FP,NePtr[j+1],Nextptrs)
DoActions(FP,CreateUnitWithProperties(1,16,2,j,{energy = 100}))
CDoActions(FP,{
	TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
})
CIfEnd()

CIf(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtLeast,1,CreateTe[j+1]),Command(j,AtMost,0,0)},{SetCDeaths(FP,SetTo,0,CreateTe[j+1])}) -- 소환 또는 조합시
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
CMov(FP,TePtr[j+1],Nextptrs)
DoActions(FP,CreateUnitWithProperties(1,0,2,j,{energy = 100}))
CDoActions(FP,{
	TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
})
CIfEnd()

CIf(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtLeast,1,CreateSu[j+1]),Command(j,AtMost,0,12)},{SetCDeaths(FP,SetTo,0,CreateSu[j+1])}) -- 소환 또는 조합시
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
CMov(FP,SuPtr[j+1],Nextptrs)
DoActions(FP,CreateUnitWithProperties(1,12,2,j,{energy = 100}))
CDoActions(FP,{
	TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
})
CIfEnd()
CIf(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtLeast,1,CreateQua[j+1]),Command(j,AtMost,0,12),Command(j,AtMost,0,60)},{SetCDeaths(FP,SetTo,0,CreateQua[j+1])}) -- 소환 또는 조합시
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
CMov(FP,QuaPtr[j+1],Nextptrs)
DoActions(FP,CreateUnitWithProperties(1,60,2,j,{energy = 100}))
CDoActions(FP,{
	TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
})
CIfEnd()



CIfX(FP,CVar(FP,NePtr[j+1][2],AtLeast,1))
CTrigger(FP,{TMemory(_Add(NePtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,NeSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ \x04의 Skill을 \x06Off \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,1,NeSkill[j+1]),
	TSetMemory(_Add(NePtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(NePtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
CTrigger(FP,{TMemory(_Add(NePtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,NeSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ \x04의 Skill을 \x1FOn \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,0,NeSkill[j+1]),
	TSetMemory(_Add(NePtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(NePtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
	
CIfX(FP,{Bring(j,AtLeast,1,16,64),CDeaths(FP,Exactly,0,NeSkill[j+1])})
	DoActions(FP,{Simple_SetLoc("S"..j+1,0,0,32*5,32*5),MoveLocation("S"..j+1,16,j,64)})
	TriggerX(FP,{CDeaths(FP,AtMost,0,BSkillT2[j+1])},{RemoveUnit(182,j)},{preserved})
	CIf(FP,{
		_TP(_TOR(
			_TAND(
				_TMemoryX(_Add(NePtr[j+1],19),Exactly,107*256,0xFF00),
				_TMemory(_Add(NePtr[j+1],23),AtLeast,1)
			),
			_TAND(
				_TMemoryX(_Add(NePtr[j+1],19),Exactly,5*256,0xFF00),
				_TMemory(_Add(NePtr[j+1],23),AtLeast,1)
			),
			_TMemoryX(_Add(NePtr[j+1],19),Exactly,10*256,0xFF00),
			_TC(Bring(Force2,AtLeast,1,"Any unit","S"..j+1))

		)),
		CDeaths(FP,AtMost,0,BSkillT2[j+1])},SetCDeaths(FP,SetTo,18,BSkillT2[j+1]))
	CSPlotAct(NeShape,j,182,"S"..j+1,nil,1,32,32,nil,FP,HumanCheck(j,1),{Order(182,j,64,Patrol,64)},1)
	CIfEnd()
	DoActionsX(FP,{SetCDeaths(FP,Subtract,1,BSkillT2[j+1])})
CElseX({RemoveUnit(182,j)})
CIfXEnd()
CTrigger(FP,{TMemoryX(_Add(NePtr[j+1],19),Exactly,0,0xFF00)},{SetCVar(FP,NePtr[j+1][2],SetTo,0)},1)
CElseX({RemoveUnit(182,j)})
CIfXEnd()

CIfX(FP,CVar(FP,TePtr[j+1][2],AtLeast,1))
CTrigger(FP,{TMemory(_Add(TePtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,TeSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ \x04의 Skill을 \x06Off \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,1,TeSkill[j+1]),
	TSetMemory(_Add(TePtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(TePtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
CTrigger(FP,{TMemory(_Add(TePtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,TeSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ \x04의 Skill을 \x1FOn \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,0,TeSkill[j+1]),
	TSetMemory(_Add(TePtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(TePtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
CIfX(FP,{Bring(j,AtLeast,1,0,64),CDeaths(FP,Exactly,0,TeSkill[j+1])})
	DoActions(FP,{Simple_SetLoc("G"..j+1,0,0,32*5,32*5),MoveLocation("G"..j+1,0,j,64)})
	TriggerX(FP,{CDeaths(FP,AtMost,0,BSkillT3[j+1])},{RemoveUnit(183,j)},{preserved})
	CIf(FP,{
		_TP(_TOR(
			_TAND(
				_TMemoryX(_Add(TePtr[j+1],19),Exactly,107*256,0xFF00),
				_TMemory(_Add(TePtr[j+1],23),AtLeast,1)
			),
			_TAND(
				_TMemoryX(_Add(NePtr[j+1],19),Exactly,5*256,0xFF00),
				_TMemory(_Add(NePtr[j+1],23),AtLeast,1)
			),
			_TMemoryX(_Add(TePtr[j+1],19),Exactly,10*256,0xFF00),
			_TC(Bring(Force2,AtLeast,1,"Any unit","G"..j+1))

		)),
		CDeaths(FP,AtMost,0,BSkillT3[j+1])},SetCDeaths(FP,SetTo,18,BSkillT3[j+1]))
	CSPlotAct(TeShape,j,183,"G"..j+1,nil,1,32,32,nil,FP,HumanCheck(j,1),{Order(183,j,64,Patrol,64)},1)
	CIfEnd()
	DoActionsX(FP,{SetCDeaths(FP,Subtract,1,BSkillT3[j+1])})
CElseX({RemoveUnit(183,j)})
CIfXEnd()
CTrigger(FP,{TMemoryX(_Add(TePtr[j+1],19),Exactly,0,0xFF00)},{SetCVar(FP,TePtr[j+1][2],SetTo,0)},1)
CElseX({RemoveUnit(183,j)})
CIfXEnd()

CIfX(FP,CVar(FP,SuPtr[j+1][2],AtLeast,1))
CTrigger(FP,{TMemory(_Add(SuPtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,SuSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ \x04의 Skill을 \x06Off \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,1,SuSkill[j+1]),
	TSetMemory(_Add(SuPtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(SuPtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
CTrigger(FP,{TMemory(_Add(SuPtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,SuSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ \x04의 Skill을 \x1FOn \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,0,SuSkill[j+1]),
	TSetMemory(_Add(SuPtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(SuPtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
	
CIfX(FP,{Bring(j,AtLeast,1,12,64),CDeaths(FP,Exactly,0,SuSkill[j+1])})
DoActions(FP,{Simple_SetLoc("P"..j+1,0,0,32*10,32*10),MoveLocation("P"..j+1,12,j,64),KillUnitAt(All,nilunit,"P"..j+1,FP)})
TriggerX(FP,{CDeaths(FP,AtMost,0,BSkillT[j+1])},{RemoveUnit(1,j)},{preserved})
CIf(FP,{
	_TP(_TOR(
		_TAND(
			_TMemoryX(_Add(SuPtr[j+1],19),Exactly,107*256,0xFF00),
			_TMemory(_Add(SuPtr[j+1],23),AtLeast,1)
		),
		_TMemoryX(_Add(SuPtr[j+1],19),Exactly,10*256,0xFF00),
		_TC(Bring(Force2,AtLeast,1,"Any unit","P"..j+1))
	)),
	CDeaths(FP,AtMost,0,BSkillT[j+1])},SetCDeaths(FP,SetTo,13,BSkillT[j+1]))
CSPlotAct(BattleShape,j,1,"P"..j+1,nil,1,32,32,nil,FP,HumanCheck(j,1),{Order(1,j,64,Patrol,64)},1)
CIfEnd()
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,BSkillT[j+1])})
CElseX({RemoveUnit(1,j)})
CIfXEnd()
CTrigger(FP,{TMemoryX(_Add(SuPtr[j+1],19),Exactly,0,0xFF00)},{SetCVar(FP,SuPtr[j+1][2],SetTo,0)},1)
CElseX({RemoveUnit(1,j)})
CIfXEnd()



CIfX(FP,CVar(FP,QuaPtr[j+1][2],AtLeast,1))
CTrigger(FP,{TMemory(_Add(QuaPtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,QuaSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x11Ｑ\x1FＵ\x1BＡ\x16Ｓ\x10Ａ\x1DＲ \x04의 Skill을 \x06Off \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,1,QuaSkill[j+1]),
	TSetMemory(_Add(QuaPtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(QuaPtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
CTrigger(FP,{TMemory(_Add(QuaPtr[j+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,QuaSkill[j+1])},{
	SetMemory(0x6509B0,SetTo,j);
	DisplayText("▶ \x11Ｑ\x1FＵ\x1BＡ\x16Ｓ\x10Ａ\x1DＲ \x04의 Skill을 \x1FOn \x04하였습니다.",4),
	SetMemory(0x6509B0,SetTo,FP);
	SetCDeaths(FP,SetTo,0,QuaSkill[j+1]),
	TSetMemory(_Add(QuaPtr[j+1],0x98/4),SetTo,0 + 228*65536);
	TSetMemory(_Add(QuaPtr[j+1],0x9C/4),SetTo,228 + 228*65536);
	},1)
	CIf(FP,{CD(QuaToken[j+1],1,AtLeast)},{SetCD(QuaToken[j+1],0)})
	CTrigger(FP,{},{TSetMemory(_Add(QuaPtr[j+1],2),SetTo,_Read(0x662350+(60*4)))},1)
	CIfEnd()
	
CIfX(FP,{Bring(j,AtLeast,1,60,64),CDeaths(FP,Exactly,0,QuaSkill[j+1])})
DoActions(FP,{Simple_SetLoc("P"..j+1,0,0,32*10,32*10),MoveLocation("P"..j+1,60,j,64),KillUnitAt(All,nilunit,"P"..j+1,FP)})
TriggerX(FP,{CDeaths(FP,AtMost,0,QSkillT[j+1])},{RemoveUnit(184,j)},{preserved})
CIf(FP,{
	_TP(_TOR(
		_TAND(
			_TMemoryX(_Add(QuaPtr[j+1],19),Exactly,107*256,0xFF00),
			_TMemory(_Add(QuaPtr[j+1],23),AtLeast,1)
		),
		_TMemoryX(_Add(QuaPtr[j+1],19),Exactly,10*256,0xFF00),
		_TC(Bring(Force2,AtLeast,1,"Any unit","P"..j+1))
	)),
	CDeaths(FP,AtMost,0,QSkillT[j+1])},SetCDeaths(FP,SetTo,13,QSkillT[j+1]))
CSPlotAct(QuaShape,j,184,"P"..j+1,nil,1,32,32,nil,FP,HumanCheck(j,1),{Order(184,j,64,Patrol,64)},1)
CIfEnd()
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,QSkillT[j+1])})
CElseX({
	RemoveUnit(184,j)
})
CIfXEnd()
CTrigger(FP,{TMemoryX(_Add(QuaPtr[j+1],19),Exactly,0,0xFF00)},{SetCVar(FP,QuaPtr[j+1][2],SetTo,0)},1)
CElseX({
	RemoveUnit(184,j)
})
CIfXEnd()





CIfEnd()
end
DoActions(FP,{
	RemoveUnit(1,P12),
	RemoveUnit(182,P12),
	RemoveUnit(183,P12),
})

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CGMode(1);
		Bring(FP,AtMost,0,174,64),
	},
	actions = {
		SetCDeaths(FP,Add,1,Win);
	}
}
InvDisable({CDeaths(FP,AtLeast,2,GMode),CDeaths(FP,AtLeast,15,Chry_cond)},201,Force2,64,"Ｏｖｅｒｍｉｎｄ　Ｃｏｃｏｏｎ")
InvDisable({CDeaths(FP,AtMost,0,Ccode(0x1001,0)),CDeaths(FP,AtMost,0,Ccode(0x1001,1)),CDeaths(FP,AtMost,0,Ccode(0x1002,0)),CDeaths(FP,AtMost,0,Ccode(0x1002,1))},148,Force2,6,"ＯｖｅｒＭｉｎｄ")
InvDisable({CDeaths(FP,AtLeast,4,B_Chry_cond)},147,Force2,31,"Ｍｏｎｓｔｅｒ　Ｋｒａｋｅｎ")
InvDisable({CDeaths(FP,AtMost,0,Ccode(0x1001,2)),CDeaths(FP,AtMost,0,Ccode(0x1002,2))},175,Force2,37,"Ｘｅｌ＇Ｎａｇａ　Ｔｅｍｐｌｅ")
InvDisable({CDeaths(FP,AtMost,0,Ccode(0x1001,3)),CDeaths(FP,AtMost,0,Ccode(0x1002,3))},175,Force2,38,"Ｘｅｌ＇Ｎａｇａ　Ｔｅｍｐｌｅ")
InvDisable({CDeaths(FP,AtMost,0,Ccode(0x1001,4)),CDeaths(FP,AtMost,0,Ccode(0x1002,4))},175,Force2,39,"Ｘｅｌ＇Ｎａｇａ　Ｔｅｍｐｌｅ")
InvDisable({CDeaths(FP,AtLeast,2,GMode),CDeaths(FP,AtMost,0,Ccode(0x1001,5)),CDeaths(FP,AtMost,0,Ccode(0x1002,5))},190,Force2,40,"Ｃｏｒｅ　ｏｆ　ＧａＬａＸｙ")
InvDisable({CDeaths(FP,AtLeast,5,Sup_Cond)},173,Force2,41,"Ｆｏｒｍａｔｉｏｎ")
InvDisable({CDeaths(FP,AtLeast,5,Py_Cond)},173,Force2,42,"Ｆｏｒｍａｔｉｏｎ")
InvDisable({CDeaths(FP,AtLeast,1,OverCocooncomp),CDeaths(FP,AtLeast,2,BossKill)},168,Force2,36,"Ｓｔａｓｉｓ　Ｃｅｌｌ")
InvDisable({
CDeaths(FP,AtMost,0,Ccode(0x1001,6)),
CDeaths(FP,AtMost,0,Ccode(0x1001,7)),
CDeaths(FP,AtMost,0,Ccode(0x1001,8)),
CDeaths(FP,AtMost,0,Ccode(0x1001,9)),
CDeaths(FP,AtMost,0,Ccode(0x1002,6)),
CDeaths(FP,AtMost,0,Ccode(0x1002,7)),
CDeaths(FP,AtMost,0,Ccode(0x1002,8)),
CDeaths(FP,AtMost,0,Ccode(0x1002,9))},152,Force2,43,"Ｄａｇｇｏｔｈ")
InvDisable({
CDeaths(FP,AtMost,0,Ccode(0x1001,10)),
CDeaths(FP,AtMost,0,Ccode(0x1001,11)),
CDeaths(FP,AtMost,0,Ccode(0x1002,10)),
CDeaths(FP,AtMost,0,Ccode(0x1002,11))},152,Force2,44,"Ｄａｇｇｏｔｈ")
InvDisable({
CDeaths(FP,AtLeast,15,Chry_cond),
CDeaths(FP,AtLeast,12,SPGunCond),
CDeaths(FP,AtLeast,2,FormCon),
CDeaths(FP,AtLeast,3,BossKill)},174,Force2,64,"최후의　\x04Ｔｅｍｐｌｅ")
Trigger { -- 솔플 보너스
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,SetPlayers[2],Exactly,1);
	},
	actions = {
		CopyCpAction({DisplayTextX("\x13\x07솔로 플레이 보너스 \x04 : \x1F40000 Ore",4);},HumanPlayers,FP),
		SetResources(Force1,Add,40000,Ore);
	},
}
--수정트리거
Trigger2X(FP,{Bring(P12,AtMost,0,219,64)},{
	CopyCpAction({
		PlayWAVX("staredit\\wav\\seeya.ogg"),
		PlayWAVX("staredit\\wav\\seeya.ogg"),
		PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP),
		Order("Men",Force2,64,Attack,2);})
Trigger2(FP,{Bring(Force2,AtMost,0,"Protoss Temple",64)},{CopyCpAction({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※\n\n\n\x13\x08최후의 건물 \x04Temple이 \x08파괴\x04되었습니다.\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※",4);
PlayWAVX("staredit\\wav\\E_Clear.ogg");
PlayWAVX("staredit\\wav\\E_Clear.ogg");
PlayWAVX("staredit\\wav\\E_Clear.ogg");},HumanPlayers,FP),
SetMemory(0x5124F0,SetTo,SpeedV[5]),
RemoveUnitAt(4,218,64,AllPlayers)})
CIf(FP,CDeaths(FP,AtLeast,1,Win))
DoActionsX(FP,SetCDeaths(FP,Add,1,Win))
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04-\n\n\n\n\x13\x04-\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,150,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,150,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- -\n\n\n\n\x13\x04- -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,160,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,160,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - -\n\n\n\n\x13\x04- - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,170,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,170,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - -\n\n\n\n\x13\x04- - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,180,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,180,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - -\n\n\n\n\x13\x04- - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,190,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,190,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - -\n\n\n\n\x13\x04- - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,200,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,200,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - -\n\n\n\n\x13\x04- - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,210,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,210,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - -\n\n\n\n\x13\x04- - - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,220,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,220,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,230,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,230,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,240,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,240,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}

ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,250,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,250,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,260,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
	
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,260,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,270,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,270,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
ClearText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x04- - - - - - - - - - - - - -\n\n\n\n\x13\x04- - - - - - - - - - - - - -\n\n\n"
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,270,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,280,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText,4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}


PlayersT = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인","\x156인"}
GModeT = {"\x0EEASY","\x08HARD","\x11BURST"}
local MText = {
	"\x13\x04게임 모드 없음",
	"\x13\x11Only마린",
	"\x13\x08노벙커",
	"\x13\x11Only마린, \x08노벙커",
	}


CIf(FP,CDeaths(FP,AtMost,#HiddenCommand-1,HiddenMode))
for i = 1, 3 do
for k = 1, 6 do
for n = 1, 4 do

local j
local l
	if n == 1 then j=0 l=0 
	elseif n == 2 then j=1 l=0 
	elseif n == 3 then j=0 l=1 
	elseif n == 4 then j=1 l=1 end

ClearText1 = "\n\n\n\n\n\n\n\n\n\x13\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x04 축하드립니다 \x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\n\x13\x04- - - - - - - - - - - - - -\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE \x03★"
ClearText2 = "\x13"..PlayersT[k]..", "..GModeT[i].." Mode"
ClearText3 = "\x13\x04클리어 하셨습니다.\n\x13\x04Creator - GALAXY_BURST\n\x13\x04- - - - - - - - - - - - - -\n\x13\x04Thanks For Playing\n\x13\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x04 축하드립니다 \x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆"


Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,i,GMode);
		CVar(FP,SetPlayers[2],Exactly,k);
		CDeaths(FP,Exactly,j,MarMode);
		CDeaths(FP,Exactly,l,NBMode);
		CDeaths(FP,AtLeast,280,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,i,GMode);
		CDeaths(FP,Exactly,j,MarMode);
		CDeaths(FP,Exactly,l,NBMode);
		CVar(FP,SetPlayers[2],Exactly,k);
		CDeaths(FP,AtLeast,280,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
end
end
end
CIfEnd()




CIf(FP,CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode))
for i = 1, 3 do
for k = 1, 6 do
for n = 1, 4 do

local j
local l
	if n == 1 then j=0 l=0 
	elseif n == 2 then j=1 l=0 
	elseif n == 3 then j=0 l=1 
	elseif n == 4 then j=1 l=1 end

ClearText1 = "\n\n\n\n\n\n\n\n\n\x13\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x04 축하드립니다 \x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\n\x13\x04- - - - - - - - - - - - - -\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE \x03★"
ClearText2 = "\x13"..PlayersT[k]..", "..GModeT[i].." Mode"
ClearText3 = "\x13\x04클리어 하셨습니다.\n\x13\x04Creator - GALAXY_BURST\n\x13\x04- - - - - - - - - - - - - -\n\x13\x04Thanks For Playing\n\x13\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x04 축하드립니다 \x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆\x0E★\x10☆"

ClearText4 = "\x13\x18Hidden Mode \x04적용됨"
ClearText5 = "HD".._0D
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,i,GMode);
		CDeaths(FP,Exactly,j,MarMode);
		CDeaths(FP,Exactly,l,NBMode);
		CVar(FP,SetPlayers[2],Exactly,k);
		CDeaths(FP,AtLeast,280,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,i,GMode);
		CDeaths(FP,Exactly,j,MarMode);
		CDeaths(FP,Exactly,l,NBMode);
		CVar(FP,SetPlayers[2],Exactly,k);
		CDeaths(FP,AtLeast,280,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(ClearText1,4);
		DisplayText(ClearText2,4);
		DisplayText(MText[n],4);
		DisplayText(ClearText4,4);
		DisplayText(ClearText5,4);
		DisplayText(ClearText3,4);
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		PlayWAV("staredit\\wav\\clear2.ogg");
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
end
end
end
CIfEnd()

Trigger { -- 게임승리 빅토리 트리거
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,#HiddenCommand-1,HiddenMode);
		CDeaths(FP,AtLeast,499,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii322",4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii322",4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii322",4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii322",4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii322",4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii322",4);
		SetMemory(0x6509B0, SetTo, FP);
		},
	}
Trigger { -- 게임승리 빅토리 트리거
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,TestMode);
		CDeaths(FP,AtLeast,500,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		Victory();
		SetMemory(0x6509B0, SetTo, 1);
		Victory();
		SetMemory(0x6509B0, SetTo, 2);
		Victory();
		SetMemory(0x6509B0, SetTo, 3);
		Victory();
		SetMemory(0x6509B0, SetTo, 4);
		Victory();
		SetMemory(0x6509B0, SetTo, 5);
		Victory();
		SetMemory(0x6509B0, SetTo, FP);
		},
	}

CIfEnd()


CMov(FP,MarUpData,0)
local TempUpDataV = CreateVar(FP)
local TempUpDataV2 = CreateVar(FP)
for i=0, 5 do
	CIf(FP,Deaths(i,Exactly,1,217))
		CIfX(FP,HumanCheck(i,1))
			f_Read(FP,DefUpgradePtrArr[i+1],TempUpDataV)
			CMov(FP,TempUpDataV2,TempUpDataV,nil,255*(256^DefUpgradeMaskRetArr[i+1]))
			CDiv(FP,TempUpDataV2,256^DefUpgradeMaskRetArr[i+1])
			CAdd(FP,MarUpData,TempUpDataV2)
		CElseX()
			CAdd(FP,MarUpData,255)
		CIfXEnd()
	CIfEnd()
end
CIf(FP,{TTCVar(FP,InputMarUpData[2],NotSame,MarUpData)})
	local SetPUpCalc = CreateVar(FP)
	CMov(FP,SetPUpCalc,_Mul(SetPlayers,_Mov(255)))

	CIfX(FP,{CVar(FP,HiddenHP[2],Exactly,0),CVar(FP,HiddenHPM[2],Exactly,0)})
		CMov(FP,MarHP,_Div(_Mov(5000*256),SetPUpCalc))
		CIfX(FP,{TMemory(_Mem(MarUpData),Exactly,SetPUpCalc)})
			CMov(FP,0x6624E0,(9999*256)+1)
		CElseX()
			CMov(FP,0x6624E0,_Mul(MarHP,MarUpData),(4999*256)+5)
		CIfXEnd()
	CElseIfX(CVar(FP,HiddenHP[2],AtLeast,1))
		CMov(FP,MarHP,_Div(_Add(_Mul(HiddenHP,_Mov(4000*256)),5000*256),SetPUpCalc))
		CMov(FP,0x6624E0,_Mul(MarHP,MarUpData),(4999*256)+5)
	CElseIfX(CVar(FP,HiddenHPM[2],AtLeast,1))
		CIf(FP,CVar(FP,HiddenHPM[2],AtMost,4))
			CMov(FP,MarHP,_Div(_Sub(_Mov(5000*256),_Mul(HiddenHPM,_Mov(1000*256))),SetPUpCalc))
			CIfX(FP,{TMemory(_Mem(MarUpData),Exactly,SetPUpCalc)})
				CMov(FP,0x6624E0,_Add(_Sub(_Mov(5000*256),_Mul(HiddenHPM,_Mov(1000*256))),5000*256))
			CElseX()
				CMov(FP,0x6624E0,_Mul(MarHP,MarUpData),(4999*256)+5)
			CIfXEnd()
		CIfEnd()

	--local MarSh1 = CreateVar(FP)
	CIfXEnd()
	--CMov(FP,MarSh1,_Div(_Mov(100*16777216),SetPUpCalc))

	CIfX(FP,{CVar(FP,HiddenHPM[2],Exactly,0)})

	CIfX(FP,{TMemory(_Mem(MarUpData),Exactly,SetPUpCalc)})
		CMov(FP,MarSh,100)
	CElseX()
		f_Div(FP,MarSh,_Mul(MarHP,MarUpData),_Mov(50*256))
	CIfXEnd()

	CElseIfX(CVar(FP,HiddenHPM[2],AtLeast,1))
		CIf(FP,CVar(FP,HiddenHPM[2],AtMost,4))

		CIfX(FP,{TMemory(_Mem(MarUpData),Exactly,SetPUpCalc)})
			CMov(FP,MarSh,_Sub(_Mov(100),_Mul(HiddenHPM,_Mov(20))))
		CElseX()
			f_Div(FP,MarSh,_Mul(MarHP,MarUpData),_Mul(_Add(_Mul(HiddenHPM,50),50),_Mov(256)))
		CIfXEnd()

		CIfEnd()
	CIfXEnd()

CIfEnd()


GiveRateT = {"\x07『 \x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.\x07 』"}
for i = 0, 5 do
for k = 0, 5 do
Trigger { -- 기부 금액 변경
	players = {i},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,k,GiveRate[i+1]);
		Command(i,AtLeast,1,"Protoss Reaver");
	},
	actions = {
		GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",11);
		RemoveUnitAt(All,"Protoss Reaver","Anywhere",11);
		DisplayText(GiveRateT[k+1],4);
		SetCDeaths(FP,Add,1,GiveRate[i+1]);
		PreserveTrigger();
		},
}
end
TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{preserved})
end


Trigger { -- BGM On Off
	players = {Force1},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,0,440,0xFF000000);
		Command(CurrentPlayer,AtLeast,1,3);
	},
	actions = {
		GiveUnits(All,3,CurrentPlayer,"Anywhere",11);
		RemoveUnitAt(All,3,"Anywhere",11);
		DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
		SetDeathsX(CurrentPlayer,SetTo,1*16777216,440,0xFF000000);
		PreserveTrigger();
		},
	}
	Trigger { -- BGM On Off
	players = {Force1},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,1*16777216,440,0xFF000000);
		Command(CurrentPlayer,AtLeast,1,3);
	},
	actions = {
		GiveUnits(All,3,CurrentPlayer,"Anywhere",11);
		RemoveUnitAt(All,3,"Anywhere",11);
		DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
		SetDeathsX(CurrentPlayer,SetTo,0*16777216,440,0xFF000000);
		PreserveTrigger();
	},
	}
for i=0, 5 do
Trigger { -- 예약메딕
	players = {i},
	conditions = {
	},
	actions = {
		SetMemoryB(0x57F27C+(228*i)+9,SetTo,0); -- 9, 34 활성화하고 비활성화할 유닛 인덱스
	},
	}
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,Exactly,0,Test1);
		Command(i,AtLeast,1,72);
	},
	actions = {
		DisplayText("\x07『 \x1D예약메딕\x04 기능을 사용합니다. - \x1F350 Ore\x07 』",4);
		GiveUnits(All,72,i,"Anywhere",11);
		RemoveUnitAt(1,72,"Anywhere",11);
		SetMemoryB(0x57F27C+(228*i)+9,SetTo,1); -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		SetMemoryB(0x57F27C+(228*i)+34,SetTo,0);
		SetCDeaths(i,SetTo,1,Test1);
		PreserveTrigger();
	},
	}
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,Exactly,1,Test1);
		Command(i,AtLeast,1,72);
	},
	actions = {
		DisplayText("\x07『 \x1D예약메딕\x04 기능을 \x1B사용하지\x04 않습니다. - \x1F250 Ore\x07 』",4);
		GiveUnits(All,72,i,"Anywhere",11);
		RemoveUnitAt(1,72,"Anywhere",11);
		SetMemoryB(0x57F27C+(228*i)+9,SetTo,0);
		SetMemoryB(0x57F27C+(228*i)+34,SetTo,1);
		SetCDeaths(i,SetTo,0,Test1);
		PreserveTrigger();
	},
	}
end
for k=0, 5 do -- 기부시스템
for j=0, 5 do
if k~=j then
for i=0, 5 do
Trigger { -- 돈 기부 시스템
	players = {k},
	conditions = {
		Label(0);
		--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
		Command(k,AtLeast,1,GiveUnitID[j+1]);
		HumanCheck(j,1);
		CDeaths(FP,Exactly,i,GiveRate[k+1]);
		Accumulate(k,AtMost,GiveRate2[i+1],Ore);
	},
	actions = {
		--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);`
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
		DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
		PreserveTrigger();
	},
	}
Trigger { -- 돈 기부 시스템
	players = {k},
	conditions = {
		Label(0);
		--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
		Command(k,AtLeast,1,GiveUnitID[j+1]);
		HumanCheck(j,1);
		CDeaths(FP,Exactly,i,GiveRate[k+1]);
		Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
		Accumulate(k,AtMost,0x7FFFFFFF,Ore);
	},
	actions = {
		SetResources(k,Subtract,GiveRate2[i+1],Ore);
		SetResources(j,Add,GiveRate2[i+1]//2,Ore);
		--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
		
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
		DisplayText("\x07『 "..Player[j+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부하였습니다. (세금 50%)\x07』",4);
		SetMemory(0x6509B0,SetTo,j);
		DisplayText("\x12\x07『"..Player[k+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부받았습니다.\x02 (세금 50%)\x07』",4);
		SetMemory(0x6509B0,SetTo,k);
		PreserveTrigger();
	},
	}
end
Trigger { -- 돈 기부 시스템
	players = {k},
	conditions = {
		--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
		Command(k,AtLeast,1,GiveUnitID[j+1]);
		HumanCheck(j,0);
	},
	actions = {
		DisplayText("\x07『 "..Player[j+1].."\x04이(가) 존재하지 않습니다. \x07』",4);
		--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
		PreserveTrigger();
	},
	}
end end end
CIf(FP,CDeaths(FP,AtMost,0,NBMode))
for i = 0, 5 do
for NB = 0, 4 do -- 중벙 트리거
CIf(FP,{HumanCheck(i,1)})
Trigger {
	players = {FP},
	conditions = {
		Bring(i,AtLeast,1,"Men",NB+19);
		Bring(P12,AtLeast,1,125,NB+19);
	},
	actions = {
		GiveUnits(All,125,P12,NB+19,i);
		PreserveTrigger();
	},
}
Trigger {
	players = {FP},
	conditions = {
		Bring(i,Exactly,0,"Men",NB+19);
		Bring(i,AtLeast,1,125,NB+19);
	},
	actions = {
		GiveUnits(All,125,i,NB+19,P12);
		PreserveTrigger();
	},
}
CIfEnd()
end
end
CIfEnd()
for i=0, 5 do
NJump(FP,0x500+i,Deaths(i,Exactly,0,111))
CIf(FP,Score(i,Kills,AtLeast,1000))
CAdd(FP,0x57F0F0+(i*4),_Mul(_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)),{FP,ExchangeRate[2],nil,"V"}))
CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
CIfEnd()
DoActions(FP,SetDeaths(i,Subtract,1,111))
NJumpEnd(FP,0x500+i)
end
for i = 0, 5 do
Trigger {
	players = {i},
	conditions = {
		Bring(i,AtLeast,1,"Men",18);
	},
	actions = {
		SetDeaths(i,Add,1,111);
		PreserveTrigger();
	}
}
Trigger {
	players = {i},
	conditions = {
		Deaths(i,AtLeast,1,204+i);
		Deaths(i,AtMost,0,111);
	},
	actions = {
		SetDeaths(i,Add,50,111);
		SetDeaths(i,SetTo,0,204+i);
		DisplayText("\x07『 \x1F자동환전\x04을 사용하셨습니다. \x07』",4);
		PreserveTrigger();
	}
}
end

TriggerX(FP,{CDeaths(FP,AtLeast,#LV_10_UnitTable,LV_10_UnitTableCode)},{SetCDeaths(FP,SetTo,0,LV_10_UnitTableCode)},{preserved})
TriggerX(FP,{CDeaths(FP,AtLeast,#LV_11_UnitTable,LV_11_UnitTableCode)},{SetCDeaths(FP,SetTo,0,LV_11_UnitTableCode)},{preserved})


--선택인식 피통 보임
SelEPD,SelHP,SelSh,SelMaxHP = CreateVars(4,FP)
SelUID = CreateVar(FP)
CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)})
f_Read(FP,0x6284B8,nil,SelEPD)
CDoActions(FP,{TSetMemory(SelOPEPD,Add,1)})
f_Read(FP,_Add(SelEPD,2),SelHP)
f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
CMov(FP,SelMaxHP,_Div(_ReadF(_Add(SelUID,_Mov(EPDF(0x662350)))),_Mov(256)))
f_Div(FP,SelHP,_Mov(256))
f_Div(FP,SelSh,_Mov(256))
CDoActions(FP,{TSetMemory(SelHPEPD,SetTo,SelHP),TSetMemory(MarHPEPD,SetTo,SelMaxHP),TSetMemory(SelShEPD,SetTo,SelSh)})
CIfEnd()

CIfEnd()-- GameStart End
--]]
BGMArr = 
{
--1
{{".ogg",32 * 1000 },
{".ogg",32 * 1000},
{".ogg",47 * 1000},
{".ogg",61 * 1000 },
{".ogg",61 * 1000},
{".ogg",83640},
{".ogg",182 * 1000},
{".ogg",57 * 1000},
{".ogg",138 * 1000}},

--2
{{".ogg",49 * 1000 },
{".ogg",57 * 1000},
{".ogg",51 * 1000},
{".ogg",76 * 1000 },
{".ogg",61 * 1000},
{".ogg",93 * 1000},
{".ogg",185 * 1000},
{".ogg",90 * 1000},
{".ogg",241 * 1000}},

--3
{{".ogg",54 * 1000 },
{".ogg",48 * 1000},
{".ogg",34 * 1000},
{".ogg",61 * 1000 },
{".ogg",55 * 1000},
{".ogg",87 * 1000},
{".ogg",184 * 1000},
{".ogg",133 * 1000},
{".ogg",120 * 1000}},

--4
{{".ogg",60 * 1000 },
{".ogg",56 * 1000},
{".ogg",59 * 1000},
{".ogg",82 * 1000 },
{".ogg",51 * 1000},
{".ogg",120 * 1000},
{".ogg",194 * 1000},
{".ogg",133 * 1000},
{".ogg",150 * 1000}},

--5
{{".ogg",53 * 1000 },
{".ogg",55 * 1000},
{".ogg",46 * 1000},
{".ogg",63 * 1000 },
{".ogg",72 * 1000},
{".ogg",102 * 1000},
{".ogg",185 * 1000},
{".ogg",87 * 1000},
{".ogg",164 * 1000}},

--6
{{".ogg",65 * 1000 },
{".ogg",42 * 1000},
{".ogg",35 * 1000},
{".ogg",52 * 1000 },
{".ogg",61 * 1000},
{".ogg",80 * 1000},
{".ogg",180 * 1000},
{".ogg",60 * 1000},
{".ogg",145 * 1000}},
--7
{{".ogg",137 * 1000 },
{".ogg",52 * 1000},
{".ogg",66 * 1000},
{".ogg",50 * 1000 },
{".ogg",55 * 1000},
{".ogg",93 * 1000},
{".ogg",210 * 1000},
{".ogg",101 * 1000},
{".ogg",290 * 1000}},


}



CIf(FP,CDeaths(FP,AtLeast,1,BGMType))
CIfX(FP,{Deaths(FP,AtMost,0,440)})
function BGMOb(Index,BGMFile,Value,BMode)
	Trigger2X(FP,{
		CDeaths(FP,Exactly,Index,BGMType);
		CDeaths(FP,Exactly,BMode,BGMMode);
	},{
RotatePlayer({
	PlayWAVX(BGMFile);
	PlayWAVX(BGMFile);},{P9,P10,P11,P12})
	},{preserved})
Trigger { -- 브금재생 j번 - 관전자
	players = {FP},
	conditions = {
		Label(0);
	},
		actions = {
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(BGMFile);
		PlayWAV(BGMFile);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(BGMFile);
		PlayWAV(BGMFile);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(BGMFile);
		PlayWAV(BGMFile);
		SetMemory(0x6509B0,SetTo,131);
		SetMemory(0x6509B0,SetTo,FP);
		SetDeathsX(FP,SetTo,Value,440,0xFFFFFF);
		PreserveTrigger();
	},
	}
end
for l, m in pairs(BGMArr) do
	for j, k in pairs(m) do
		
	BGMOb(j,"staredit\\wav\\BGM"..l.."_"..j..k[1],k[2],l)
	end
end

CElseX()
Trigger2X(FP,{CDeaths(FP,AtMost,0,BossStart)},{RotatePlayer({PlayWAVX("staredit\\wav\\BGM_Skip.ogg");PlayWAVX("staredit\\wav\\BGM_Skip.ogg")},{P9,P10,P11,P12},FP)},{preserved})
CIfXEnd()
CMov(FP,0x6509B0,0)
CWhile(FP,Memory(0x6509B0,AtMost,5))
CIf(FP,Bring(CurrentPlayer,AtLeast,1,111,64))
CIfX(FP,{Deaths(CurrentPlayer,AtMost,0,440)})
function BGMPlayer(Index,BGMFile,Value,BMode)
Trigger { -- 브금재생 j번
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,Index,BGMType);
		CDeaths(FP,Exactly,BMode,BGMMode);
	},
		actions = {
		PlayWAV(BGMFile);
		PlayWAV(BGMFile);
		SetDeathsX(CurrentPlayer,SetTo,Value,440,0xFFFFFF);
		PreserveTrigger();
	},
	}
end
for l, m in pairs(BGMArr) do
	for j, k in pairs(m) do
	BGMPlayer(j,"staredit\\wav\\BGM"..l.."_"..j..k[1],k[2],l)
	end
end
CElseX()
TriggerX(FP,{CDeaths(FP,AtMost,0,BossStart)},{PlayWAV("staredit\\wav\\BGM_Skip.ogg");PlayWAV("staredit\\wav\\BGM_Skip.ogg");},{preserved})
CIfXEnd()
CIfEnd()
CAdd(FP,0x6509B0,1)
CWhileEnd()
DoActionsX(FP,{SetCDeaths(FP,SetTo,0,BGMType),SetMemory(0x6509B0,SetTo,FP)})
CIfEnd()
--]]

init_Setting()
DoActions(FP,{KillUnit(84,Force2),KillUnit(72,Force2),KillUnit(22,Force2),KillUnit(9,Force2),SetMemoryX(0x666458, SetTo, 546,0xFFFF),RemoveUnit(33,Force2)})
EndCtrig()
ErrorCheck()
EUDTurbo(FP)
SetCallErrorCheck()
Enable_HideErrorMessage(FP)
