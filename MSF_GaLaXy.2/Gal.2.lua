
--dofile("C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\MapSource\\MSF_GaLaXy.2\\Gal.2.lua")

-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_GaLaXy.2\\Gal.2.lua")
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end
EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_GaLaXy.2\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Gal.2.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_GaLaXy.2\\"..dir))
		InitEXTLua()
     end
end

FP = P8
DoActions(FP,{RemoveUnit(205,FP)})
Trigger2(Force2,{Command(CurrentPlayer,AtLeast,10,42)},{KillUnitAt(1,42,"Anywhere",CurrentPlayer)},{Preserved})
Trigger2(Force2,{Command(CurrentPlayer,AtLeast,20,35)},{KillUnit(35,CurrentPlayer)},{Preserved})
Trigger2(Force2,{Command(CurrentPlayer,AtLeast,20,37)},{RemoveUnitAt(1,37,64,CurrentPlayer)},{Preserved})
DoActions(Force1,{SetDeaths(CurrentPlayer,SetTo,1,217)},1)
HumanPlayers = {P1,P2,P3,P4,P5,P6,P9,P10,P11,P12}
MapPlayers = {P1,P2,P3,P4,P5,P6}
SetForces(MapPlayers,{P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
UnitNamePtr = 0x591000 -- i * 0x20
TestStart = 0
Limit = 0
GunSafety = 0
VName = "Ver.1.2"
SetFixedPlayer(FP)
StartCtrig()
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

Enable_PlayerCheck()
InitJump = def_sIndex()
CJump(AllPlayers,InitJump) -- 트리거 가둬놓는곳
Objects()
Include_CtrigPlib(360,RandSwitch,1,FP)
Include_Conv_CPosXY(FP)
nilunit = 181
Install_GetCLoc(FP,255,nilunit)
Include_CRandNum(FP)
function f_SaveCp()
	CallTrigger(FP,Call_SaveCP,nil)
end
function f_LoadCp()
	CallTrigger(FP,Call_LoadCP,nil)
end


Var_InputCVar = {}
Var_Lines = 55
Var_TempTable = CreateVarArr(Var_Lines,FP)
for i = 1, Var_Lines do
	table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
end


function Call_Gun_LocPos()
	CallTrigger(FP,GunLocPos_CallIndex)
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
f_SaveCP()
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
function Call_Gun_TempSave()
	DoActionsX(FP,{SetNext("X",GunTempSave_CallIndex,0),SetNext(GunTempSave_CallIndex+1,"X",1)})
end
SetCall(FP)
f_SaveCP()
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

DoActions(FP,{RotatePlayer({DisplayTextX(CBulletErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

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
Install_GetCLoc(FP,253,nilunit)
CJumpEnd(AllPlayers,InitJump)
NoAirCollisionX(FP)




GiveUnitsArr = {}
VArrPatchTable ={}
CIfOnce(FP,Always()) -- onPluginStart

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
Print_All_CTextString(FP)

for i = 0, 5 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Command(i,AtLeast,1,111);
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
Marine[j] = f_GetStrXPtr(FP,V(0x306+j-1),"\x0D\x0D\x0D"..Color[j].."NM".._0D)
HMarine[j] = f_GetStrXPtr(FP,V(0x30C+j-1),"\x0D\x0D\x0D"..Color[j].."HM".._0D)
LumMarine[j] = f_GetStrXPtr(FP,V(0x312+j-1),"\x0D\x0D\x0D"..Color[j].."LM".._0D)
Lumia[j] = f_GetStrXPtr(FP,V(0x318+j-1),"\x0D\x0D\x0D"..Color[j].."RM".._0D)
f_GetStrXPtr(FP,SuStrPtr[j],"\x0D\x0D\x0D"..Color[j].."Su".._0D)
f_GetStrXPtr(FP,TeStrPtr[j],"\x0D\x0D\x0D"..Color[j].."Te".._0D)
LumiaCT[j] = f_GetStrXPtr(FP,V(0x31E+j-1),"\x0D\x0D\x0D"..Player[j].."Lumia".._0D)
ShieldT[j] = f_GetStrXPtr(FP,V(0x324+j-1),"\x0D\x0D\x0D"..Player[j].."Shield".._0D)
ATKExitText[j] = f_GetStrXPtr(FP,V(0x32A+j-1),"\x0D\x0D\x0D"..Player[j].."Exit".._0D)
ATKUpText1[j] = f_GetStrXPtr(FP,V(0x330+j-1),"\x0D\x0D\x0D"..Player[j].."100".._0D)
ATKUpText2[j] = f_GetStrXPtr(FP,V(0x336+j-1),"\x0D\x0D\x0D"..Player[j].."200".._0D)
PlayerName[j] = f_GetStrXPtr(FP,V(0x33D+j-1),"\x0D\x0D\x0D"..Player[j].."".._0D)
MarineL[j] = GetStrSizeD(1,Marine[j])
HMarineL[j] = GetStrSizeD(1,HMarine[j])
LumMarineL[j] = GetStrSizeD(1,LumMarine[j])
LumiaL[j] = GetStrSizeD(1,Lumia[j])
end
for i = 0, 5 do
ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
_0DPatchforVArr(FP,Names[i+1],6)
end
f_GetStrXPtr(FP,HeroTxtStrPtr,"\x0D\x0D\x0DHK".._0D)
f_GetStrXPtr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
f_GetStrXPtr(FP,HiddenModeStrPtr,"HD".._0D)
for j = 0, 5 do
	f_GetStrXptr(FP,DefStrPtr[j+1],"\x0D\x0D\x0DDef"..Player[j+1].._0D)
end
for i = 0, 5 do
	Install_CText1(DefStrPtr[i+1],DefStr1,DefStr2,Names[i+1])
	Install_CText1(SuStrPtr[i+1],SuT00,SuText,Names[i+1])
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
t22 = "\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x04 미네랄을 소비하여 총 \x0d\x0d\x0d\x0d\x0d\x0d"
t23 = "\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x04 \x04회 업그레이드를 완료하였습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d"

t24 = "\x0d\x0d\x0d\x0d\x0d\x04현재 선택가능 플레이어는...\x0d\x0d\x0d\x0d\x0d"
t25 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x0EEASY \x03[W] \x08HARD \x04[E] \x11BURST\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x03[E] \x11BURST\x0d\x0d\x0d\x0d\x0d"
}

t26 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x0EEASY \x02[W] \x08HARD \x02[E] \x11BURST\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x0EEASY \x02[W] \x02HARD \x02[E] \x02BURST\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02EASY \x03[W] \x08HARD \x02[E] \x02BURST\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02EASY \x02[W] \x02HARD \x03[E] \x11BURST\x0d\x0d\x0d\x0d\x0d"
}
t28 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x02[W] \x02진지한 \x02[E] \x02강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x0E신나는 \x02[W] \x02진지한 \x02[E] \x02강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x03[W] \x08진지한 \x02[E] \x02강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x02[W] \x02진지한 \x03[E] \x11강렬한 \x02[R] \x02강렬한2\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x02[Q] \x02신나는 \x02[W] \x02진지한 \x02[E] \x02강렬한 \x03[R] \x10강렬한2\x0d\x0d\x0d\x0d\x0d"
}

t27 = {
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x11Only마린 \x04[W] \x08노벙커 \x03[E] \x0E선택안함\x0d\x0d\x0d\x0d\x0d", -- GMode 3
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x11Only마린 \x04[W] \x08노벙커 \x04[E] \x0E선택안함\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x04[Q] \x11Only마린 \x03[W] \x08노벙커 \x04[E] \x0E선택안함\x0d\x0d\x0d\x0d\x0d",
"\x0d\x0d\x0d\x0d\x0d\x04 : \x03[Q] \x11Only마린 \x03[W] \x08노벙커 \x04[E] \x0E선택안함\x0d\x0d\x0d\x0d\x0d",
}
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
Print_String(FP,_TMem(Arr(Str22,0)),t22,0)
Print_String(FP,_TMem(Arr(Str23,0)),t23,0)
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
Str22L = GetStrSizeD(0,t22)
Str23L = GetStrSizeD(0,t23)
Str24L = GetStrSizeD(0,t24)
for i = 0, 5 do
t03 = "\x0d\x0d\x0d\x04의 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy "..Color[i+1].."M\x16arine\x04이 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x061\x04)\x02◆\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
Print_String(FP,_TMem(Arr(Str03[i+1],0)),t03,0)
Str03L[i+1] = GetStrSizeD(0,t03)
end
Str04L = GetStrSizeD(0,t04)
for i = 0, 5 do
f_MemCpy(FP,V(0x306+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_MovCpy(FP,_Add(V(0x306+i),Str00L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x306+i),Str00L+(4*6)+3),_TMem(Arr(Str01,0),"X","X",1),Str01L-3)
f_MemCpy(FP,V(0x30C+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_MovCpy(FP,_Add(V(0x30C+i),Str00L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x30C+i),Str00L+(4*6)+3),_TMem(Arr(Str02,0),"X","X",1),Str02L-3)
f_MemCpy(FP,V(0x312+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_MovCpy(FP,_Add(V(0x312+i),Str00L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x312+i),Str00L+(4*6)+3),_TMem(Arr(Str03[i+1],0),"X","X",1),Str03L[i+1]-3)
f_MemCpy(FP,V(0x318+i),_TMem(Arr(Str00,0),"X","X",1),Str00L-3)
f_MovCpy(FP,_Add(V(0x318+i),Str00L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x318+i),Str00L+(4*6)+3),_TMem(Arr(Str04,0),"X","X",1),Str04L-3)
f_MemCpy(FP,V(0x31E+i),_TMem(Arr(Str10,0),"X","X",1),Str10L-3)
f_MovCpy(FP,_Add(V(0x31E+i),Str10L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x31E+i),Str10L+(4*6)+3),_TMem(Arr(Str11,0),"X","X",1),Str11L-3)
f_MemCpy(FP,V(0x324+i),_TMem(Arr(Str12,0),"X","X",1),Str12L-3)
f_MovCpy(FP,_Add(V(0x324+i),Str12L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x324+i),Str12L+(4*6)+3),_TMem(Arr(Str13,0),"X","X",1),Str13L-3)
f_MemCpy(FP,V(0x32A+i),_TMem(Arr(Str14,0),"X","X",1),Str14L-3)
f_MovCpy(FP,_Add(V(0x32A+i),Str14L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x32A+i),Str14L+(4*6)+3),_TMem(Arr(Str15,0),"X","X",1),Str15L-3)
f_MemCpy(FP,V(0x330+i),_TMem(Arr(Str14,0),"X","X",1),Str14L-3)
f_MovCpy(FP,_Add(V(0x330+i),Str14L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x330+i),Str14L+(4*6)+3),_TMem(Arr(Str16,0),"X","X",1),Str16L-3)
f_MemCpy(FP,V(0x336+i),_TMem(Arr(Str14,0),"X","X",1),Str14L-3)
f_MovCpy(FP,_Add(V(0x336+i),Str14L),VArr(Names[i+1],0),4*6)
f_MemCpy(FP,_Add(V(0x336+i),Str14L+(4*6)+3),_TMem(Arr(Str17,0),"X","X",1),Str17L-3)
f_MemCpy(FP,V(0x33D+i),_TMem(Arr(Str18,0),"X","X",1),Str18L-3)
f_MovCpy(FP,_Add(V(0x33D+i),Str18L),VArr(Names[i+1],0),5*4)
end
f_MemCpy(FP,HeroTxtStrPtr,_TMem(Arr(Str19,0),"X","X",1),Str19L-3)
--f_MemCpy(FP,_Add(HeroTxtStrPtr,Str19L),UnitNamePtr+(i*0x20),0x20)
f_MemCpy(FP,_Add(HeroTxtStrPtr,Str19L-3+0x20),_TMem(Arr(Str20,0),"X","X",1),Str20L-3)
--ItoDec(FP,HPoint,_TMem(Arr(HPointT,0),"X","X",1),2,0x1F,0)
--f_MemCpy(FP,_Add(HeroTxtStrPtr,Str19L+0x20+Str20L),_TMem(Arr(HPointT,0),"X","X",1),16)
f_MemCpy(FP,_Add(HeroTxtStrPtr,Str19L-3+0x20+Str20L-3+16),_TMem(Arr(Str21,0),"X","X",1),Str21L-3)
f_MemCpy(FP,UPCompStrPtr,_TMem(Arr(Str12,0),"X","X",1),Str12L-3)
--f_MemCpy(FP,_Add(UPCompStrPtr,Str12L-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
f_MemCpy(FP,_Add(UPCompStrPtr,Str12L-3+20),_TMem(Arr(Str22,0),"X","X",1),Str22L-3)
--f_MemCpy(FP,_Add(UPCompStrPtr,Str12L-3+20+Str22L-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
f_MemCpy(FP,_Add(UPCompStrPtr,Str12L-3+20+Str22L-3+20),_TMem(Arr(Str23,0),"X","X",1),Str23L-3)
--f_Read(FP,0x6559A8,InfArmorFactor,"X",0xFFFF)
f_Read(FP,0x6559A8,InfArmorFactor,"X",0xFFFF)
--f_Read(FP,,InfWeaponFactor,"X",0xFFFF0000)
f_Read(FP,0x6559A8,InfWeaponFactor,"X",0xFFFF0000)
f_Div(FP,InfWeaponFactor,65536)

--function print_utf82(offset, string)
--    local ret = {}
--    local dst = offset
--    if type(string) == "string" then
--        local str = string
--        local n = 1
--        if dst % 4 >= 1 then
--            for i = 1, dst % 4 do str = '\0'..str end
--        end
--        local t = cp949_to_utf8(str)
--        while n <= #t do
--            ret[#ret+1] = SetMemory(dst - dst % 4 +n-1, SetTo, _dw(t, n))
--            n = n + 4
--        end
--    elseif type(string) == "number" then
--        ret[#ret+1] = SetMemory(dst - dst % 4, SetTo, string)
--    end
--    return ret
--end
--tab = {}
--for i=0, 227 do
--table.insert(tab,print_utf82(0x591000+(0x20*i),DecodeUnit(i)))
--end
--DoActions2(P8,tab)


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x591000, SetTo, 0x6972614D);
		SetMemory(0x591004, SetTo, 0x0000656E);
		SetMemory(0x591020, SetTo, 0xEC8C85ED);
		SetMemory(0x591024, SetTo, 0x8AEDA48A);
		SetMemory(0x591028, SetTo, 0xA0B3EAB8);
		SetMemory(0x59102C, SetTo, 0xEDA48AEC);
		SetMemory(0x591030, SetTo, 0x0000B88A);
		SetMemory(0x591040, SetTo, 0x72726554);
		SetMemory(0x591044, SetTo, 0x56206E61);
		SetMemory(0x591048, SetTo, 0x75746C75);
		SetMemory(0x59104C, SetTo, 0x00006572);
		SetMemory(0x591060, SetTo, 0x656C6142);
		SetMemory(0x591064, SetTo, 0x00007378);
		SetMemory(0x591080, SetTo, 0x696C6F47);
		SetMemory(0x591084, SetTo, 0x20687461);
		SetMemory(0x591088, SetTo, 0x72727554);
		SetMemory(0x59108C, SetTo, 0x00007465);
		SetMemory(0x5910A0, SetTo, 0xEFA3BCEF);
		SetMemory(0x5910A4, SetTo, 0xBDEF81BD);
		SetMemory(0x5910A8, SetTo, 0x83BDEF8C);
		SetMemory(0x5910AC, SetTo, 0xEF95BDEF);
		SetMemory(0x5910B0, SetTo, 0xBDEF8CBD);
		SetMemory(0x5910B4, SetTo, 0x94BDEF81);
		SetMemory(0x5910B8, SetTo, 0xEF8FBDEF);
		SetMemory(0x5910BC, SetTo, 0x0000B2BC);
		SetMemory(0x5910C0, SetTo, 0x6B6E6154);
		SetMemory(0x5910C4, SetTo, 0x72755420);
		SetMemory(0x5910C8, SetTo, 0x20746572);
		SetMemory(0x5910CC, SetTo, 0x65707974);
		SetMemory(0x5910D0, SetTo, 0x31202020);
		SetMemory(0x5910D4, SetTo, 0x00000000);
		SetMemory(0x5910E0, SetTo, 0x00564353);
		SetMemory(0x591100, SetTo, 0x69617257);
		SetMemory(0x591104, SetTo, 0x00006874);
		SetMemory(0x591120, SetTo, 0x72726554);
		SetMemory(0x591124, SetTo, 0x53206E61);
		SetMemory(0x591128, SetTo, 0x6E656963);
		SetMemory(0x59112C, SetTo, 0x56206563);
		SetMemory(0x591130, SetTo, 0x65737365);
		SetMemory(0x591134, SetTo, 0x0000006C);
		SetMemory(0x591140, SetTo, 0x20697547);
		SetMemory(0x591144, SetTo, 0x746E6F4D);
		SetMemory(0x591148, SetTo, 0x00006761);
		SetMemory(0x591160, SetTo, 0xEFA4BCEF);
		SetMemory(0x591164, SetTo, 0xBDEF92BD);
		SetMemory(0x591168, SetTo, 0x90BDEF8F);
		SetMemory(0x59116C, SetTo, 0xEFA4BCEF);
		SetMemory(0x591170, SetTo, 0xBDEF85BD);
		SetMemory(0x591174, SetTo, 0x84BDEF81);
		SetMemory(0x591178, SetTo, 0x00000000);
		SetMemory(0x591180, SetTo, 0x72726554);
		SetMemory(0x591184, SetTo, 0x42206E61);
		SetMemory(0x591188, SetTo, 0x6C747461);
		SetMemory(0x59118C, SetTo, 0x75726365);
		SetMemory(0x591190, SetTo, 0x72657369);
		SetMemory(0x591194, SetTo, 0x00000000);
		SetMemory(0x5911A0, SetTo, 0x746C7556);
		SetMemory(0x5911A4, SetTo, 0x20657275);
		SetMemory(0x5911A8, SetTo, 0x64697053);
		SetMemory(0x5911AC, SetTo, 0x4D207265);
		SetMemory(0x5911B0, SetTo, 0x00656E69);
		SetMemory(0x5911C0, SetTo, 0x6C63754E);
		SetMemory(0x5911C4, SetTo, 0x20726165);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x5911C8, SetTo, 0x7373694D);
		SetMemory(0x5911CC, SetTo, 0x00656C69);
		SetMemory(0x5911E0, SetTo, 0x69766943);
		SetMemory(0x5911E4, SetTo, 0x6E61696C);
		SetMemory(0x5911E8, SetTo, 0x00000000);
		SetMemory(0x591200, SetTo, 0xEFAEBCEF);
		SetMemory(0x591204, SetTo, 0xBCEFA5BC);
		SetMemory(0x591208, SetTo, 0xB5BCEFA2);
		SetMemory(0x59120C, SetTo, 0xEFACBCEF);
		SetMemory(0x591210, SetTo, 0x0000A1BC);
		SetMemory(0x591220, SetTo, 0x6E616C41);
		SetMemory(0x591224, SetTo, 0x68635320);
		SetMemory(0x591228, SetTo, 0x72617A65);
		SetMemory(0x59122C, SetTo, 0x00000000);
		SetMemory(0x591240, SetTo, 0x6E616C41);
		SetMemory(0x591244, SetTo, 0x72755420);
		SetMemory(0x591248, SetTo, 0x00746572);
		SetMemory(0x591260, SetTo, 0x206D694A);
		SetMemory(0x591264, SetTo, 0x6E796152);
		SetMemory(0x591268, SetTo, 0x5620726F);
		SetMemory(0x59126C, SetTo, 0x75746C75);
		SetMemory(0x591270, SetTo, 0x00006572);
		SetMemory(0x591280, SetTo, 0x614D2048);
		SetMemory(0x591284, SetTo, 0x656E6972);
		SetMemory(0x591288, SetTo, 0x00000000);
		SetMemory(0x5912A0, SetTo, 0x206D6F54);
		SetMemory(0x5912A4, SetTo, 0x617A614B);
		SetMemory(0x5912A8, SetTo, 0x796B736E);
		SetMemory(0x5912AC, SetTo, 0x00000000);
		SetMemory(0x5912C0, SetTo, 0x6567614D);
		SetMemory(0x5912C4, SetTo, 0x6E616C6C);
		SetMemory(0x5912C8, SetTo, 0x63532820);
		SetMemory(0x5912CC, SetTo, 0x636E6569);
		SetMemory(0x5912D0, SetTo, 0x65562065);
		SetMemory(0x5912D4, SetTo, 0x6C657373);
		SetMemory(0x5912D8, SetTo, 0x00000029);
		SetMemory(0x5912E0, SetTo, 0x756D6445);
		SetMemory(0x5912E4, SetTo, 0x4420646E);
		SetMemory(0x5912E8, SetTo, 0x20656B75);
		SetMemory(0x5912EC, SetTo, 0x00000047);
		SetMemory(0x591300, SetTo, 0x656B7544);
		SetMemory(0x591304, SetTo, 0x72755420);
		SetMemory(0x591308, SetTo, 0x20746572);
		SetMemory(0x59130C, SetTo, 0x65707974);
		SetMemory(0x591310, SetTo, 0x31202020);
		SetMemory(0x591314, SetTo, 0x00000000);
		SetMemory(0x591320, SetTo, 0x756D6445);
		SetMemory(0x591324, SetTo, 0x4420646E);
		SetMemory(0x591328, SetTo, 0x20656B75);
		SetMemory(0x59132C, SetTo, 0x00000053);
		SetMemory(0x591340, SetTo, 0x656B7544);
		SetMemory(0x591344, SetTo, 0x72755420);
		SetMemory(0x591348, SetTo, 0x20746572);
		SetMemory(0x59134C, SetTo, 0x65707974);
		SetMemory(0x591350, SetTo, 0x32202020);
		SetMemory(0x591354, SetTo, 0x00000000);
		SetMemory(0x591360, SetTo, 0x74637241);
		SetMemory(0x591364, SetTo, 0x73757275);
		SetMemory(0x591368, SetTo, 0x6E654D20);
		SetMemory(0x59136C, SetTo, 0x006B7367);
		SetMemory(0x591380, SetTo, 0x65707948);
		SetMemory(0x591384, SetTo, 0x6E6F6972);
		SetMemory(0x591388, SetTo, 0x00000000);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x5913A0, SetTo, 0x61726F4E);
		SetMemory(0x5913A4, SetTo, 0x49492064);
		SetMemory(0x5913A8, SetTo, 0x00000000);
		SetMemory(0x5913C0, SetTo, 0x72726554);
		SetMemory(0x5913C4, SetTo, 0x53206E61);
		SetMemory(0x5913C8, SetTo, 0x65676569);
		SetMemory(0x5913CC, SetTo, 0x6E615420);
		SetMemory(0x5913D0, SetTo, 0x5328206B);
		SetMemory(0x5913D4, SetTo, 0x65676569);
		SetMemory(0x5913D8, SetTo, 0x646F4D20);
		SetMemory(0x5913DC, SetTo, 0x00002965);
		SetMemory(0x5913E0, SetTo, 0x6B6E6154);
		SetMemory(0x5913E4, SetTo, 0x72755420);
		SetMemory(0x5913E8, SetTo, 0x20746572);
		SetMemory(0x5913EC, SetTo, 0x65707974);
		SetMemory(0x5913F0, SetTo, 0x32202020);
		SetMemory(0x5913F4, SetTo, 0x00000000);
		SetMemory(0x591400, SetTo, 0x65726946);
		SetMemory(0x591404, SetTo, 0x00746162);
		SetMemory(0x591420, SetTo, 0x6E616353);
		SetMemory(0x591424, SetTo, 0x2072656E);
		SetMemory(0x591428, SetTo, 0x65657753);
		SetMemory(0x59142C, SetTo, 0x00000070);
		SetMemory(0x591440, SetTo, 0x72726554);
		SetMemory(0x591444, SetTo, 0x4D206E61);
		SetMemory(0x591448, SetTo, 0x63696465);
		SetMemory(0x59144C, SetTo, 0x00000000);
		SetMemory(0x591460, SetTo, 0x7672614C);
		SetMemory(0x591464, SetTo, 0x00000061);
		SetMemory(0x591480, SetTo, 0x00676745);
		SetMemory(0x5914A0, SetTo, 0x6772655A);
		SetMemory(0x5914A4, SetTo, 0x676E696C);
		SetMemory(0x5914A8, SetTo, 0x00000000);
		SetMemory(0x5914C0, SetTo, 0x72647948);
		SetMemory(0x5914C4, SetTo, 0x73696C61);
		SetMemory(0x5914C8, SetTo, 0x0000006B);
		SetMemory(0x5914E0, SetTo, 0x72746C55);
		SetMemory(0x5914E4, SetTo, 0x73696C61);
		SetMemory(0x5914E8, SetTo, 0x0000006B);
		SetMemory(0x591500, SetTo, 0x6F6F7242);
		SetMemory(0x591504, SetTo, 0x6E696C64);
		SetMemory(0x591508, SetTo, 0x00000067);
		SetMemory(0x591520, SetTo, 0x6E6F7244);
		SetMemory(0x591524, SetTo, 0x00000065);
		SetMemory(0x591540, SetTo, 0x7265764F);
		SetMemory(0x591544, SetTo, 0x64726F6C);
		SetMemory(0x591548, SetTo, 0x00000000);
		SetMemory(0x591560, SetTo, 0x6174754D);
		SetMemory(0x591564, SetTo, 0x6B73696C);
		SetMemory(0x591568, SetTo, 0x00000000);
		SetMemory(0x591580, SetTo, 0x72617547);
		SetMemory(0x591584, SetTo, 0x6E616964);
		SetMemory(0x591588, SetTo, 0x00000000);
		SetMemory(0x5915A0, SetTo, 0x65657551);
		SetMemory(0x5915A4, SetTo, 0x0000006E);
		SetMemory(0x5915C0, SetTo, 0x69666544);
		SetMemory(0x5915C4, SetTo, 0x0072656C);
		SetMemory(0x5915E0, SetTo, 0x756F6353);
		SetMemory(0x5915E4, SetTo, 0x00656772);
		SetMemory(0x591600, SetTo, 0x72726F54);
		SetMemory(0x591604, SetTo, 0x75717361);
		SetMemory(0x591608, SetTo, 0x00000065);
		SetMemory(0x591620, SetTo, 0x7274614D);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x591624, SetTo, 0x63726169);
		SetMemory(0x591628, SetTo, 0x51282068);
		SetMemory(0x59162C, SetTo, 0x6E656575);
		SetMemory(0x591630, SetTo, 0x00000029);
		SetMemory(0x591640, SetTo, 0x65666E49);
		SetMemory(0x591644, SetTo, 0x64657473);
		SetMemory(0x591648, SetTo, 0x72655420);
		SetMemory(0x59164C, SetTo, 0x006E6172);
		SetMemory(0x591660, SetTo, 0x65666E49);
		SetMemory(0x591664, SetTo, 0x64657473);
		SetMemory(0x591668, SetTo, 0x72654B20);
		SetMemory(0x59166C, SetTo, 0x61676972);
		SetMemory(0x591670, SetTo, 0x0000006E);
		SetMemory(0x591680, SetTo, 0x6C636E55);
		SetMemory(0x591684, SetTo, 0x006E6165);
		SetMemory(0x5916A0, SetTo, 0x746E7548);
		SetMemory(0x5916A4, SetTo, 0x4B207265);
		SetMemory(0x5916A8, SetTo, 0x656C6C69);
		SetMemory(0x5916AC, SetTo, 0x00000072);
		SetMemory(0x5916C0, SetTo, 0x6F766544);
		SetMemory(0x5916C4, SetTo, 0x6E697275);
		SetMemory(0x5916C8, SetTo, 0x6E4F2067);
		SetMemory(0x5916CC, SetTo, 0x00000065);
		SetMemory(0x5916E0, SetTo, 0x756B754B);
		SetMemory(0x5916E4, SetTo, 0x20617A6C);
		SetMemory(0x5916E8, SetTo, 0x6174754D);
		SetMemory(0x5916EC, SetTo, 0x6B73696C);
		SetMemory(0x5916F0, SetTo, 0x00000000);
		SetMemory(0x591700, SetTo, 0x756B754B);
		SetMemory(0x591704, SetTo, 0x20617A6C);
		SetMemory(0x591708, SetTo, 0x72617547);
		SetMemory(0x59170C, SetTo, 0x6E616964);
		SetMemory(0x591710, SetTo, 0x00000000);
		SetMemory(0x591720, SetTo, 0x7274614D);
		SetMemory(0x591724, SetTo, 0x63726169);
		SetMemory(0x591728, SetTo, 0x00000068);
		SetMemory(0x591740, SetTo, 0x72726554);
		SetMemory(0x591744, SetTo, 0x56206E61);
		SetMemory(0x591748, SetTo, 0x796B6C61);
		SetMemory(0x59174C, SetTo, 0x00656972);
		SetMemory(0x591760, SetTo, 0x6F636F43);
		SetMemory(0x591764, SetTo, 0x00006E6F);
		SetMemory(0x591780, SetTo, 0x746F7250);
		SetMemory(0x591784, SetTo, 0x2073736F);
		SetMemory(0x591788, SetTo, 0x73726F43);
		SetMemory(0x59178C, SetTo, 0x00726961);
		SetMemory(0x5917A0, SetTo, 0x746F7250);
		SetMemory(0x5917A4, SetTo, 0x2073736F);
		SetMemory(0x5917A8, SetTo, 0x6B726144);
		SetMemory(0x5917AC, SetTo, 0x6D655420);
		SetMemory(0x5917B0, SetTo, 0x72616C70);
		SetMemory(0x5917B4, SetTo, 0x00000000);
		SetMemory(0x5917C0, SetTo, 0x6F766544);
		SetMemory(0x5917C4, SetTo, 0x72657275);
		SetMemory(0x5917C8, SetTo, 0x00000000);
		SetMemory(0x5917E0, SetTo, 0x72726554);
		SetMemory(0x5917E4, SetTo, 0x726F7469);
		SetMemory(0x5917E8, SetTo, 0x69442079);
		SetMemory(0x5917EC, SetTo, 0x6F736976);
		SetMemory(0x5917F0, SetTo, 0x00000072);
		SetMemory(0x591800, SetTo, 0x746F7250);
		SetMemory(0x591804, SetTo, 0x2073736F);
		SetMemory(0x591808, SetTo, 0x626F7250);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x59180C, SetTo, 0x00000065);
		SetMemory(0x591820, SetTo, 0x6C61655A);
		SetMemory(0x591824, SetTo, 0x0000746F);
		SetMemory(0x591840, SetTo, 0x67617244);
		SetMemory(0x591844, SetTo, 0x006E6F6F);
		SetMemory(0x591860, SetTo, 0x706D6554);
		SetMemory(0x591864, SetTo, 0x20747365);
		SetMemory(0x591868, SetTo, 0x6E697242);
		SetMemory(0x59186C, SetTo, 0x00726567);
		SetMemory(0x591880, SetTo, 0x67756F4E);
		SetMemory(0x591884, SetTo, 0x00007468);
		SetMemory(0x5918A0, SetTo, 0x74756853);
		SetMemory(0x5918A4, SetTo, 0x00656C74);
		SetMemory(0x5918C0, SetTo, 0x756F6353);
		SetMemory(0x5918C4, SetTo, 0x00000074);
		SetMemory(0x5918E0, SetTo, 0x646C6F43);
		SetMemory(0x5918E4, SetTo, 0x726F5320);
		SetMemory(0x5918E8, SetTo, 0x65726563);
		SetMemory(0x5918EC, SetTo, 0x00000072);
		SetMemory(0x591900, SetTo, 0x746F7250);
		SetMemory(0x591904, SetTo, 0x2073736F);
		SetMemory(0x591908, SetTo, 0x72726143);
		SetMemory(0x59190C, SetTo, 0x00726569);
		SetMemory(0x591920, SetTo, 0x746F7250);
		SetMemory(0x591924, SetTo, 0x2073736F);
		SetMemory(0x591928, SetTo, 0x65746E49);
		SetMemory(0x59192C, SetTo, 0x70656372);
		SetMemory(0x591930, SetTo, 0x00726F74);
		SetMemory(0x591940, SetTo, 0x6B726144);
		SetMemory(0x591944, SetTo, 0x6D655420);
		SetMemory(0x591948, SetTo, 0x72616C70);
		SetMemory(0x59194C, SetTo, 0x00004720);
		SetMemory(0x591960, SetTo, 0x6172655A);
		SetMemory(0x591964, SetTo, 0x006C7574);
		SetMemory(0x591980, SetTo, 0x73736154);
		SetMemory(0x591984, SetTo, 0x72616461);
		SetMemory(0x591988, SetTo, 0x72655A2F);
		SetMemory(0x59198C, SetTo, 0x6C757461);
		SetMemory(0x591990, SetTo, 0x00000000);
		SetMemory(0x5919A0, SetTo, 0x696E6546);
		SetMemory(0x5919A4, SetTo, 0x005A2078);
		SetMemory(0x5919C0, SetTo, 0x696E6546);
		SetMemory(0x5919C4, SetTo, 0x00442078);
		SetMemory(0x5919E0, SetTo, 0x73736154);
		SetMemory(0x5919E4, SetTo, 0x72616461);
		SetMemory(0x5919E8, SetTo, 0x00000000);
		SetMemory(0x591A00, SetTo, 0x6F6A6F4D);
		SetMemory(0x591A04, SetTo, 0x00000000);
		SetMemory(0x591A20, SetTo, 0x62726157);
		SetMemory(0x591A24, SetTo, 0x676E6972);
		SetMemory(0x591A28, SetTo, 0x00007265);
		SetMemory(0x591A40, SetTo, 0x746E6147);
		SetMemory(0x591A44, SetTo, 0x68746972);
		SetMemory(0x591A48, SetTo, 0x2820726F);
		SetMemory(0x591A4C, SetTo, 0x72726143);
		SetMemory(0x591A50, SetTo, 0x29726569);
		SetMemory(0x591A54, SetTo, 0x00000000);
		SetMemory(0x591A60, SetTo, 0x746F7250);
		SetMemory(0x591A64, SetTo, 0x2073736F);
		SetMemory(0x591A68, SetTo, 0x76616552);
		SetMemory(0x591A6C, SetTo, 0x00007265);
		SetMemory(0x591A80, SetTo, 0x746F7250);
		SetMemory(0x591A84, SetTo, 0x2073736F);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x591A88, SetTo, 0x6573624F);
		SetMemory(0x591A8C, SetTo, 0x72657672);
		SetMemory(0x591A90, SetTo, 0x00000000);
		SetMemory(0x591AA0, SetTo, 0x746F7250);
		SetMemory(0x591AA4, SetTo, 0x2073736F);
		SetMemory(0x591AA8, SetTo, 0x72616353);
		SetMemory(0x591AAC, SetTo, 0x00006261);
		SetMemory(0x591AC0, SetTo, 0x696E6144);
		SetMemory(0x591AC4, SetTo, 0x68746F6D);
		SetMemory(0x591AC8, SetTo, 0x00000000);
		SetMemory(0x591AE0, SetTo, 0x61646C41);
		SetMemory(0x591AE4, SetTo, 0x00736972);
		SetMemory(0x591B00, SetTo, 0x61747241);
		SetMemory(0x591B04, SetTo, 0x0073696E);
		SetMemory(0x591B20, SetTo, 0x6E796852);
		SetMemory(0x591B24, SetTo, 0x6E6F6461);
		SetMemory(0x591B28, SetTo, 0x00000000);
		SetMemory(0x591B40, SetTo, 0x676E6542);
		SetMemory(0x591B44, SetTo, 0x61616C61);
		SetMemory(0x591B48, SetTo, 0x4A282073);
		SetMemory(0x591B4C, SetTo, 0x6C676E75);
		SetMemory(0x591B50, SetTo, 0x00002965);
		SetMemory(0x591B60, SetTo, 0x73756E55);
		SetMemory(0x591B64, SetTo, 0x74206465);
		SetMemory(0x591B68, SetTo, 0x20657079);
		SetMemory(0x591B6C, SetTo, 0x00312020);
		SetMemory(0x591B80, SetTo, 0x73756E55);
		SetMemory(0x591B84, SetTo, 0x74206465);
		SetMemory(0x591B88, SetTo, 0x20657079);
		SetMemory(0x591B8C, SetTo, 0x00322020);
		SetMemory(0x591BA0, SetTo, 0x6E616353);
		SetMemory(0x591BA4, SetTo, 0x20646974);
		SetMemory(0x591BA8, SetTo, 0x73654428);
		SetMemory(0x591BAC, SetTo, 0x29747265);
		SetMemory(0x591BB0, SetTo, 0x00000000);
		SetMemory(0x591BC0, SetTo, 0x616B614B);
		SetMemory(0x591BC4, SetTo, 0x28207572);
		SetMemory(0x591BC8, SetTo, 0x6C697754);
		SetMemory(0x591BCC, SetTo, 0x74686769);
		SetMemory(0x591BD0, SetTo, 0x00000029);
		SetMemory(0x591BE0, SetTo, 0x6E676152);
		SetMemory(0x591BE4, SetTo, 0x75617361);
		SetMemory(0x591BE8, SetTo, 0x41282072);
		SetMemory(0x591BEC, SetTo, 0x57206873);
		SetMemory(0x591BF0, SetTo, 0x646C726F);
		SetMemory(0x591BF4, SetTo, 0x00000029);
		SetMemory(0x591C00, SetTo, 0x61737255);
		SetMemory(0x591C04, SetTo, 0x206E6F64);
		SetMemory(0x591C08, SetTo, 0x65634928);
		SetMemory(0x591C0C, SetTo, 0x726F5720);
		SetMemory(0x591C10, SetTo, 0x0029646C);
		SetMemory(0x591C20, SetTo, 0x6B72754C);
		SetMemory(0x591C24, SetTo, 0x45207265);
		SetMemory(0x591C28, SetTo, 0x00006767);
		SetMemory(0x591C40, SetTo, 0x73726F43);
		SetMemory(0x591C44, SetTo, 0x00726961);
		SetMemory(0x591C60, SetTo, 0x696D6153);
		SetMemory(0x591C64, SetTo, 0x75442072);
		SetMemory(0x591C68, SetTo, 0x206E6172);
		SetMemory(0x591C6C, SetTo, 0x6F684728);
		SetMemory(0x591C70, SetTo, 0x00297473);
		SetMemory(0x591C80, SetTo, 0x614C6147);
		SetMemory(0x591C84, SetTo, 0x4D207958);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x591C88, SetTo, 0x6E697261);
		SetMemory(0x591C8C, SetTo, 0x00000065);
		SetMemory(0x591CA0, SetTo, 0x2070614D);
		SetMemory(0x591CA4, SetTo, 0x65766552);
		SetMemory(0x591CA8, SetTo, 0x72656C61);
		SetMemory(0x591CAC, SetTo, 0x00000000);
		SetMemory(0x591CC0, SetTo, 0x61726547);
		SetMemory(0x591CC4, SetTo, 0x44206472);
		SetMemory(0x591CC8, SetTo, 0x6C614775);
		SetMemory(0x591CCC, SetTo, 0x0000656C);
		SetMemory(0x591CE0, SetTo, 0x6B72754C);
		SetMemory(0x591CE4, SetTo, 0x00007265);
		SetMemory(0x591D00, SetTo, 0x65666E49);
		SetMemory(0x591D04, SetTo, 0x64657473);
		SetMemory(0x591D08, SetTo, 0x72754420);
		SetMemory(0x591D0C, SetTo, 0x00006E61);
		SetMemory(0x591D20, SetTo, 0x72736944);
		SetMemory(0x591D24, SetTo, 0x69747075);
		SetMemory(0x591D28, SetTo, 0x46206E6F);
		SetMemory(0x591D2C, SetTo, 0x646C6569);
		SetMemory(0x591D30, SetTo, 0x00000000);
		SetMemory(0x591D40, SetTo, 0x72726554);
		SetMemory(0x591D44, SetTo, 0x43206E61);
		SetMemory(0x591D48, SetTo, 0x616D6D6F);
		SetMemory(0x591D4C, SetTo, 0x4320646E);
		SetMemory(0x591D50, SetTo, 0x65746E65);
		SetMemory(0x591D54, SetTo, 0x00000072);
		SetMemory(0x591D60, SetTo, 0x614C6147);
		SetMemory(0x591D64, SetTo, 0x43207958);
		SetMemory(0x591D68, SetTo, 0x61736D6F);
		SetMemory(0x591D6C, SetTo, 0x00000074);
		SetMemory(0x591D80, SetTo, 0x72726554);
		SetMemory(0x591D84, SetTo, 0x4E206E61);
		SetMemory(0x591D88, SetTo, 0x656C6375);
		SetMemory(0x591D8C, SetTo, 0x53207261);
		SetMemory(0x591D90, SetTo, 0x006F6C69);
		SetMemory(0x591DA0, SetTo, 0x70707553);
		SetMemory(0x591DA4, SetTo, 0x0000796C);
		SetMemory(0x591DC0, SetTo, 0x72726554);
		SetMemory(0x591DC4, SetTo, 0x52206E61);
		SetMemory(0x591DC8, SetTo, 0x6E696665);
		SetMemory(0x591DCC, SetTo, 0x00797265);
		SetMemory(0x591DE0, SetTo, 0x614C6147);
		SetMemory(0x591DE4, SetTo, 0x42207958);
		SetMemory(0x591DE8, SetTo, 0x61727261);
		SetMemory(0x591DEC, SetTo, 0x00736B63);
		SetMemory(0x591E00, SetTo, 0x72726554);
		SetMemory(0x591E04, SetTo, 0x41206E61);
		SetMemory(0x591E08, SetTo, 0x65646163);
		SetMemory(0x591E0C, SetTo, 0x0000796D);
		SetMemory(0x591E20, SetTo, 0x72726554);
		SetMemory(0x591E24, SetTo, 0x46206E61);
		SetMemory(0x591E28, SetTo, 0x6F746361);
		SetMemory(0x591E2C, SetTo, 0x00007972);
		SetMemory(0x591E40, SetTo, 0x72726554);
		SetMemory(0x591E44, SetTo, 0x53206E61);
		SetMemory(0x591E48, SetTo, 0x70726174);
		SetMemory(0x591E4C, SetTo, 0x0074726F);
		SetMemory(0x591E60, SetTo, 0x72726554);
		SetMemory(0x591E64, SetTo, 0x43206E61);
		SetMemory(0x591E68, SetTo, 0x72746E6F);
		SetMemory(0x591E6C, SetTo, 0x54206C6F);
		SetMemory(0x591E70, SetTo, 0x7265776F);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x591E74, SetTo, 0x00000000);
		SetMemory(0x591E80, SetTo, 0x72726554);
		SetMemory(0x591E84, SetTo, 0x53206E61);
		SetMemory(0x591E88, SetTo, 0x6E656963);
		SetMemory(0x591E8C, SetTo, 0x46206563);
		SetMemory(0x591E90, SetTo, 0x6C696361);
		SetMemory(0x591E94, SetTo, 0x00797469);
		SetMemory(0x591EA0, SetTo, 0x72726554);
		SetMemory(0x591EA4, SetTo, 0x43206E61);
		SetMemory(0x591EA8, SetTo, 0x7265766F);
		SetMemory(0x591EAC, SetTo, 0x704F2074);
		SetMemory(0x591EB0, SetTo, 0x00000073);
		SetMemory(0x591EC0, SetTo, 0x72726554);
		SetMemory(0x591EC4, SetTo, 0x50206E61);
		SetMemory(0x591EC8, SetTo, 0x69737968);
		SetMemory(0x591ECC, SetTo, 0x4C207363);
		SetMemory(0x591ED0, SetTo, 0x00006261);
		SetMemory(0x591EE0, SetTo, 0x73756E55);
		SetMemory(0x591EE4, SetTo, 0x54206465);
		SetMemory(0x591EE8, SetTo, 0x61727265);
		SetMemory(0x591EEC, SetTo, 0x6C42206E);
		SetMemory(0x591EF0, SetTo, 0x74206764);
		SetMemory(0x591EF4, SetTo, 0x20657079);
		SetMemory(0x591EF8, SetTo, 0x00312020);
		SetMemory(0x591F00, SetTo, 0x72726554);
		SetMemory(0x591F04, SetTo, 0x4D206E61);
		SetMemory(0x591F08, SetTo, 0x69686361);
		SetMemory(0x591F0C, SetTo, 0x5320656E);
		SetMemory(0x591F10, SetTo, 0x00706F68);
		SetMemory(0x591F20, SetTo, 0x73756E55);
		SetMemory(0x591F24, SetTo, 0x54206465);
		SetMemory(0x591F28, SetTo, 0x61727265);
		SetMemory(0x591F2C, SetTo, 0x6C42206E);
		SetMemory(0x591F30, SetTo, 0x74206764);
		SetMemory(0x591F34, SetTo, 0x20657079);
		SetMemory(0x591F38, SetTo, 0x00322020);
		SetMemory(0x591F40, SetTo, 0x72726554);
		SetMemory(0x591F44, SetTo, 0x45206E61);
		SetMemory(0x591F48, SetTo, 0x6E69676E);
		SetMemory(0x591F4C, SetTo, 0x69726565);
		SetMemory(0x591F50, SetTo, 0x4220676E);
		SetMemory(0x591F54, SetTo, 0x00007961);
		SetMemory(0x591F60, SetTo, 0x72726554);
		SetMemory(0x591F64, SetTo, 0x41206E61);
		SetMemory(0x591F68, SetTo, 0x726F6D72);
		SetMemory(0x591F6C, SetTo, 0x00000079);
		SetMemory(0x591F80, SetTo, 0x72726554);
		SetMemory(0x591F84, SetTo, 0x4D206E61);
		SetMemory(0x591F88, SetTo, 0x69737369);
		SetMemory(0x591F8C, SetTo, 0x5420656C);
		SetMemory(0x591F90, SetTo, 0x65727275);
		SetMemory(0x591F94, SetTo, 0x00000074);
		SetMemory(0x591FA0, SetTo, 0x614C6147);
		SetMemory(0x591FA4, SetTo, 0x42207958);
		SetMemory(0x591FA8, SetTo, 0x656B6E75);
		SetMemory(0x591FAC, SetTo, 0x00000072);
		SetMemory(0x591FC0, SetTo, 0x61726F4E);
		SetMemory(0x591FC4, SetTo, 0x49492064);
		SetMemory(0x591FC8, SetTo, 0x72432820);
		SetMemory(0x591FCC, SetTo, 0x65687361);
		SetMemory(0x591FD0, SetTo, 0x61422064);
		SetMemory(0x591FD4, SetTo, 0x656C7474);
		SetMemory(0x591FD8, SetTo, 0x69757263);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x591FDC, SetTo, 0x29726573);
		SetMemory(0x591FE0, SetTo, 0x00000000);
		SetMemory(0x591FE0, SetTo, 0x206E6F49);
		SetMemory(0x591FE4, SetTo, 0x6E6E6143);
		SetMemory(0x591FE8, SetTo, 0x00006E6F);
		SetMemory(0x592000, SetTo, 0x6A617255);
		SetMemory(0x592004, SetTo, 0x79724320);
		SetMemory(0x592008, SetTo, 0x6C617473);
		SetMemory(0x59200C, SetTo, 0x00000000);
		SetMemory(0x592020, SetTo, 0x6C61684B);
		SetMemory(0x592024, SetTo, 0x43207369);
		SetMemory(0x592028, SetTo, 0x74737972);
		SetMemory(0x59202C, SetTo, 0x00006C61);
		SetMemory(0x592040, SetTo, 0x65666E49);
		SetMemory(0x592044, SetTo, 0x64657473);
		SetMemory(0x592048, SetTo, 0x6E654320);
		SetMemory(0x59204C, SetTo, 0x00726574);
		SetMemory(0x592060, SetTo, 0x63746148);
		SetMemory(0x592064, SetTo, 0x79726568);
		SetMemory(0x592068, SetTo, 0x00000000);
		SetMemory(0x592080, SetTo, 0x7269614C);
		SetMemory(0x592084, SetTo, 0x00000000);
		SetMemory(0x5920A0, SetTo, 0x65766948);
		SetMemory(0x5920A4, SetTo, 0x00000000);
		SetMemory(0x5920C0, SetTo, 0x7564794E);
		SetMemory(0x5920C4, SetTo, 0x61432073);
		SetMemory(0x5920C8, SetTo, 0x006C616E);
		SetMemory(0x5920E0, SetTo, 0x72647948);
		SetMemory(0x5920E4, SetTo, 0x73696C61);
		SetMemory(0x5920E8, SetTo, 0x6544206B);
		SetMemory(0x5920EC, SetTo, 0x0000006E);
		SetMemory(0x592100, SetTo, 0x69666544);
		SetMemory(0x592104, SetTo, 0x2072656C);
		SetMemory(0x592108, SetTo, 0x6E756F4D);
		SetMemory(0x59210C, SetTo, 0x00000064);
		SetMemory(0x592120, SetTo, 0x61657247);
		SetMemory(0x592124, SetTo, 0x20726574);
		SetMemory(0x592128, SetTo, 0x72697053);
		SetMemory(0x59212C, SetTo, 0x00000065);
		SetMemory(0x592140, SetTo, 0x65657551);
		SetMemory(0x592144, SetTo, 0x2073276E);
		SetMemory(0x592148, SetTo, 0x7473654E);
		SetMemory(0x59214C, SetTo, 0x00000000);
		SetMemory(0x592160, SetTo, 0x6C6F7645);
		SetMemory(0x592164, SetTo, 0x6F697475);
		SetMemory(0x592168, SetTo, 0x6843206E);
		SetMemory(0x59216C, SetTo, 0x65626D61);
		SetMemory(0x592170, SetTo, 0x00000072);
		SetMemory(0x592180, SetTo, 0x72746C55);
		SetMemory(0x592184, SetTo, 0x73696C61);
		SetMemory(0x592188, SetTo, 0x6143206B);
		SetMemory(0x59218C, SetTo, 0x6E726576);
		SetMemory(0x592190, SetTo, 0x00000000);
		SetMemory(0x5921A0, SetTo, 0x72697053);
		SetMemory(0x5921A4, SetTo, 0x00000065);
		SetMemory(0x5921C0, SetTo, 0x77617053);
		SetMemory(0x5921C4, SetTo, 0x676E696E);
		SetMemory(0x5921C8, SetTo, 0x6F6F5020);
		SetMemory(0x5921CC, SetTo, 0x0000006C);
		SetMemory(0x5921E0, SetTo, 0x65657243);
		SetMemory(0x5921E4, SetTo, 0x6F432070);
		SetMemory(0x5921E8, SetTo, 0x796E6F6C);
		SetMemory(0x5921EC, SetTo, 0x00000000);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x592200, SetTo, 0x726F7053);
		SetMemory(0x592204, SetTo, 0x6F432065);
		SetMemory(0x592208, SetTo, 0x796E6F6C);
		SetMemory(0x59220C, SetTo, 0x00000000);
		SetMemory(0x592220, SetTo, 0x73756E55);
		SetMemory(0x592224, SetTo, 0x5A206465);
		SetMemory(0x592228, SetTo, 0x20677265);
		SetMemory(0x59222C, SetTo, 0x67646C42);
		SetMemory(0x592230, SetTo, 0x00000000);
		SetMemory(0x592240, SetTo, 0x6B6E7553);
		SetMemory(0x592244, SetTo, 0x43206E65);
		SetMemory(0x592248, SetTo, 0x6E6F6C6F);
		SetMemory(0x59224C, SetTo, 0x00000079);
		SetMemory(0x592260, SetTo, 0x736E6F4D);
		SetMemory(0x592264, SetTo, 0x20726574);
		SetMemory(0x592268, SetTo, 0x6B61724B);
		SetMemory(0x59226C, SetTo, 0x00216E65);
		SetMemory(0x592280, SetTo, 0x7265764F);
		SetMemory(0x592284, SetTo, 0x646E694D);
		SetMemory(0x592288, SetTo, 0x00000000);
		SetMemory(0x5922A0, SetTo, 0x72747845);
		SetMemory(0x5922A4, SetTo, 0x6F746361);
		SetMemory(0x5922A8, SetTo, 0x00000072);
		SetMemory(0x5922C0, SetTo, 0x21676942);
		SetMemory(0x5922C4, SetTo, 0x79724320);
		SetMemory(0x5922C8, SetTo, 0x696C6173);
		SetMemory(0x5922CC, SetTo, 0x00000073);
		SetMemory(0x5922E0, SetTo, 0x65726543);
		SetMemory(0x5922E4, SetTo, 0x74617262);
		SetMemory(0x5922E8, SetTo, 0x00000065);
		SetMemory(0x592300, SetTo, 0x67676144);
		SetMemory(0x592304, SetTo, 0x0068546F);
		SetMemory(0x592320, SetTo, 0x73756E55);
		SetMemory(0x592324, SetTo, 0x5A206465);
		SetMemory(0x592328, SetTo, 0x20677265);
		SetMemory(0x59232C, SetTo, 0x67646C42);
		SetMemory(0x592330, SetTo, 0x00003520);
		SetMemory(0x592340, SetTo, 0x746F7250);
		SetMemory(0x592344, SetTo, 0x2073736F);
		SetMemory(0x592348, SetTo, 0x7578654E);
		SetMemory(0x59234C, SetTo, 0x00000073);
		SetMemory(0x592360, SetTo, 0x746F7250);
		SetMemory(0x592364, SetTo, 0x2073736F);
		SetMemory(0x592368, SetTo, 0x6F626F52);
		SetMemory(0x59236C, SetTo, 0x73636974);
		SetMemory(0x592370, SetTo, 0x63614620);
		SetMemory(0x592374, SetTo, 0x74696C69);
		SetMemory(0x592378, SetTo, 0x00000079);
		SetMemory(0x592380, SetTo, 0x6F6C7950);
		SetMemory(0x592384, SetTo, 0x0000006E);
		SetMemory(0x5923A0, SetTo, 0x746F7250);
		SetMemory(0x5923A4, SetTo, 0x2073736F);
		SetMemory(0x5923A8, SetTo, 0x69737341);
		SetMemory(0x5923AC, SetTo, 0x616C696D);
		SetMemory(0x5923B0, SetTo, 0x00726F74);
		SetMemory(0x5923C0, SetTo, 0x746F7250);
		SetMemory(0x5923C4, SetTo, 0x2073736F);
		SetMemory(0x5923C8, SetTo, 0x73756E55);
		SetMemory(0x5923CC, SetTo, 0x74206465);
		SetMemory(0x5923D0, SetTo, 0x20657079);
		SetMemory(0x5923D4, SetTo, 0x00312020);
		SetMemory(0x5923E0, SetTo, 0x746F7250);
		SetMemory(0x5923E4, SetTo, 0x2073736F);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x5923E8, SetTo, 0x6573624F);
		SetMemory(0x5923EC, SetTo, 0x74617672);
		SetMemory(0x5923F0, SetTo, 0x0079726F);
		SetMemory(0x592400, SetTo, 0xED95B0EA);
		SetMemory(0x592404, SetTo, 0xB1EAB487);
		SetMemory(0x592408, SetTo, 0xBCACEBB4);
		SetMemory(0x59240C, SetTo, 0x00000000);
		SetMemory(0x592420, SetTo, 0x746F7250);
		SetMemory(0x592424, SetTo, 0x2073736F);
		SetMemory(0x592428, SetTo, 0x73756E55);
		SetMemory(0x59242C, SetTo, 0x74206465);
		SetMemory(0x592430, SetTo, 0x20657079);
		SetMemory(0x592434, SetTo, 0x00322020);
		SetMemory(0x592440, SetTo, 0x746F6850);
		SetMemory(0x592444, SetTo, 0x43206E6F);
		SetMemory(0x592448, SetTo, 0x6F6E6E61);
		SetMemory(0x59244C, SetTo, 0x0000006E);
		SetMemory(0x592460, SetTo, 0x746F7250);
		SetMemory(0x592464, SetTo, 0x2073736F);
		SetMemory(0x592468, SetTo, 0x61746943);
		SetMemory(0x59246C, SetTo, 0x206C6564);
		SetMemory(0x592470, SetTo, 0x4120666F);
		SetMemory(0x592474, SetTo, 0x006E7564);
		SetMemory(0x592480, SetTo, 0x746F7250);
		SetMemory(0x592484, SetTo, 0x2073736F);
		SetMemory(0x592488, SetTo, 0x65627943);
		SetMemory(0x59248C, SetTo, 0x74656E72);
		SetMemory(0x592490, SetTo, 0x20736369);
		SetMemory(0x592494, SetTo, 0x65726F43);
		SetMemory(0x592498, SetTo, 0x00000000);
		SetMemory(0x5924A0, SetTo, 0x746F7250);
		SetMemory(0x5924A4, SetTo, 0x2073736F);
		SetMemory(0x5924A8, SetTo, 0x706D6554);
		SetMemory(0x5924AC, SetTo, 0x2072616C);
		SetMemory(0x5924B0, SetTo, 0x68637241);
		SetMemory(0x5924B4, SetTo, 0x73657669);
		SetMemory(0x5924B8, SetTo, 0x00000000);
		SetMemory(0x5924C0, SetTo, 0x746F7250);
		SetMemory(0x5924C4, SetTo, 0x2073736F);
		SetMemory(0x5924C8, SetTo, 0x67726F46);
		SetMemory(0x5924CC, SetTo, 0x00000065);
		SetMemory(0x5924E0, SetTo, 0x746F7250);
		SetMemory(0x5924E4, SetTo, 0x2073736F);
		SetMemory(0x5924E8, SetTo, 0x72617453);
		SetMemory(0x5924EC, SetTo, 0x65746167);
		SetMemory(0x5924F0, SetTo, 0x00000000);
		SetMemory(0x592500, SetTo, 0x73617453);
		SetMemory(0x592504, SetTo, 0x43207369);
		SetMemory(0x592508, SetTo, 0x006C6C65);
		SetMemory(0x592520, SetTo, 0x746F7250);
		SetMemory(0x592524, SetTo, 0x2073736F);
		SetMemory(0x592528, SetTo, 0x65656C46);
		SetMemory(0x59252C, SetTo, 0x65422074);
		SetMemory(0x592530, SetTo, 0x6E6F6361);
		SetMemory(0x592534, SetTo, 0x00000000);
		SetMemory(0x592540, SetTo, 0x746F7250);
		SetMemory(0x592544, SetTo, 0x2073736F);
		SetMemory(0x592548, SetTo, 0x69627241);
		SetMemory(0x59254C, SetTo, 0x20726574);
		SetMemory(0x592550, SetTo, 0x62697254);
		SetMemory(0x592554, SetTo, 0x6C616E75);
		SetMemory(0x592558, SetTo, 0x00000000);
		SetMemory(0x592560, SetTo, 0x746F7250);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x592564, SetTo, 0x2073736F);
		SetMemory(0x592568, SetTo, 0x6F626F52);
		SetMemory(0x59256C, SetTo, 0x73636974);
		SetMemory(0x592570, SetTo, 0x70755320);
		SetMemory(0x592574, SetTo, 0x74726F70);
		SetMemory(0x592578, SetTo, 0x79614220);
		SetMemory(0x59257C, SetTo, 0x00000000);
		SetMemory(0x592580, SetTo, 0x746F7250);
		SetMemory(0x592584, SetTo, 0x2073736F);
		SetMemory(0x592588, SetTo, 0x65696853);
		SetMemory(0x59258C, SetTo, 0x4220646C);
		SetMemory(0x592590, SetTo, 0x65747461);
		SetMemory(0x592594, SetTo, 0x00007972);
		SetMemory(0x5925A0, SetTo, 0x6D726F46);
		SetMemory(0x5925A4, SetTo, 0x6F697461);
		SetMemory(0x5925A8, SetTo, 0x0000006E);
		SetMemory(0x5925C0, SetTo, 0x706D6554);
		SetMemory(0x5925C4, SetTo, 0x0000656C);
		SetMemory(0x5925E0, SetTo, 0x276C6558);
		SetMemory(0x5925E4, SetTo, 0x6167614E);
		SetMemory(0x5925E8, SetTo, 0x6D655420);
		SetMemory(0x5925EC, SetTo, 0x00656C70);
		SetMemory(0x592600, SetTo, 0x656E694D);
		SetMemory(0x592604, SetTo, 0x206C6172);
		SetMemory(0x592608, SetTo, 0x6C656946);
		SetMemory(0x59260C, SetTo, 0x54282064);
		SetMemory(0x592610, SetTo, 0x20657079);
		SetMemory(0x592614, SetTo, 0x00002931);
		SetMemory(0x592620, SetTo, 0x656E694D);
		SetMemory(0x592624, SetTo, 0x206C6172);
		SetMemory(0x592628, SetTo, 0x6C656946);
		SetMemory(0x59262C, SetTo, 0x54282064);
		SetMemory(0x592630, SetTo, 0x20657079);
		SetMemory(0x592634, SetTo, 0x00002932);
		SetMemory(0x592640, SetTo, 0x656E694D);
		SetMemory(0x592644, SetTo, 0x206C6172);
		SetMemory(0x592648, SetTo, 0x6C656946);
		SetMemory(0x59264C, SetTo, 0x54282064);
		SetMemory(0x592650, SetTo, 0x20657079);
		SetMemory(0x592654, SetTo, 0x00002933);
		SetMemory(0x592660, SetTo, 0x72616353);
		SetMemory(0x592664, SetTo, 0x00006261);
		SetMemory(0x592680, SetTo, 0x64697053);
		SetMemory(0x592684, SetTo, 0x4D207265);
		SetMemory(0x592688, SetTo, 0x00656E69);
		SetMemory(0x5926A0, SetTo, 0x746E6143);
		SetMemory(0x5926A4, SetTo, 0x00616E69);
		SetMemory(0x5926C0, SetTo, 0x696E694D);
		SetMemory(0x5926C4, SetTo, 0x5020676E);
		SetMemory(0x5926C8, SetTo, 0x6674616C);
		SetMemory(0x5926CC, SetTo, 0x006D726F);
		SetMemory(0x5926E0, SetTo, 0x65646E49);
		SetMemory(0x5926E4, SetTo, 0x646E6570);
		SetMemory(0x5926E8, SetTo, 0x20746E65);
		SetMemory(0x5926EC, SetTo, 0x6D6D6F43);
		SetMemory(0x5926F0, SetTo, 0x20646E61);
		SetMemory(0x5926F4, SetTo, 0x746E6543);
		SetMemory(0x5926F8, SetTo, 0x00007265);
		SetMemory(0x592700, SetTo, 0x65646E49);
		SetMemory(0x592704, SetTo, 0x646E6570);
		SetMemory(0x592708, SetTo, 0x20746E65);
		SetMemory(0x59270C, SetTo, 0x72617453);
		SetMemory(0x592710, SetTo, 0x74726F70);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x592714, SetTo, 0x00000000);
		SetMemory(0x592720, SetTo, 0x706D754A);
		SetMemory(0x592724, SetTo, 0x74614720);
		SetMemory(0x592728, SetTo, 0x00000065);
		SetMemory(0x592740, SetTo, 0x6E697552);
		SetMemory(0x592744, SetTo, 0x00000073);
		SetMemory(0x592760, SetTo, 0x6461794B);
		SetMemory(0x592764, SetTo, 0x6E697261);
		SetMemory(0x592768, SetTo, 0x79724320);
		SetMemory(0x59276C, SetTo, 0x6C617473);
		SetMemory(0x592770, SetTo, 0x726F4620);
		SetMemory(0x592774, SetTo, 0x6974616D);
		SetMemory(0x592778, SetTo, 0x00006E6F);
		SetMemory(0x592780, SetTo, 0x70736556);
		SetMemory(0x592784, SetTo, 0x20656E65);
		SetMemory(0x592788, SetTo, 0x73796547);
		SetMemory(0x59278C, SetTo, 0x00007265);
		SetMemory(0x5927A0, SetTo, 0x70726157);
		SetMemory(0x5927A4, SetTo, 0x74614720);
		SetMemory(0x5927A8, SetTo, 0x00000065);
		SetMemory(0x5927C0, SetTo, 0x65726F43);
		SetMemory(0x5927C4, SetTo, 0x20666F20);
		SetMemory(0x5927C8, SetTo, 0x616C6147);
		SetMemory(0x5927CC, SetTo, 0x00007978);
		SetMemory(0x5927E0, SetTo, 0x6772655A);
		SetMemory(0x5927E4, SetTo, 0x72614D20);
		SetMemory(0x5927E8, SetTo, 0x0072656B);
		SetMemory(0x592800, SetTo, 0xEF9FBCEF);
		SetMemory(0x592804, SetTo, 0xBCEF9FBC);
		SetMemory(0x592808, SetTo, 0x3128209F);
		SetMemory(0x59280C, SetTo, 0x00293239);
		SetMemory(0x592820, SetTo, 0xEF9FBCEF);
		SetMemory(0x592824, SetTo, 0xBCEF9FBC);
		SetMemory(0x592828, SetTo, 0x3128209F);
		SetMemory(0x59282C, SetTo, 0x00293339);
		SetMemory(0x592840, SetTo, 0x6772655A);
		SetMemory(0x592844, SetTo, 0x61654220);
		SetMemory(0x592848, SetTo, 0x006E6F63);
		SetMemory(0x592860, SetTo, 0x72726554);
		SetMemory(0x592864, SetTo, 0x42206E61);
		SetMemory(0x592868, SetTo, 0x6F636165);
		SetMemory(0x59286C, SetTo, 0x0000006E);
		SetMemory(0x592880, SetTo, 0x746F7250);
		SetMemory(0x592884, SetTo, 0x2073736F);
		SetMemory(0x592888, SetTo, 0x63616542);
		SetMemory(0x59288C, SetTo, 0x00006E6F);
		SetMemory(0x5928A0, SetTo, 0x6772655A);
		SetMemory(0x5928A4, SetTo, 0x616C4620);
		SetMemory(0x5928A8, SetTo, 0x65422067);
		SetMemory(0x5928AC, SetTo, 0x6E6F6361);
		SetMemory(0x5928B0, SetTo, 0x00000000);
		SetMemory(0x5928C0, SetTo, 0x72726554);
		SetMemory(0x5928C4, SetTo, 0x46206E61);
		SetMemory(0x5928C8, SetTo, 0x2067616C);
		SetMemory(0x5928CC, SetTo, 0x63616542);
		SetMemory(0x5928D0, SetTo, 0x00006E6F);
		SetMemory(0x5928E0, SetTo, 0x746F7250);
		SetMemory(0x5928E4, SetTo, 0x2073736F);
		SetMemory(0x5928E8, SetTo, 0x67616C46);
		SetMemory(0x5928EC, SetTo, 0x61654220);
		SetMemory(0x5928F0, SetTo, 0x006E6F63);
		SetMemory(0x592900, SetTo, 0x65776F50);
		SetMemory(0x592904, SetTo, 0x65472072);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x592908, SetTo, 0x6172656E);
		SetMemory(0x59290C, SetTo, 0x00726F74);
		SetMemory(0x592920, SetTo, 0x7265764F);
		SetMemory(0x592924, SetTo, 0x646E696D);
		SetMemory(0x592928, SetTo, 0x636F4320);
		SetMemory(0x59292C, SetTo, 0x006E6F6F);
		SetMemory(0x592940, SetTo, 0x6B726144);
		SetMemory(0x592944, SetTo, 0x61775320);
		SetMemory(0x592948, SetTo, 0x00006D72);
		SetMemory(0x592960, SetTo, 0x6863614E);
		SetMemory(0x592964, SetTo, 0x73694D6F);
		SetMemory(0x592968, SetTo, 0x656C6973);
		SetMemory(0x59296C, SetTo, 0x00000000);
		SetMemory(0x592980, SetTo, 0x6F6F6C46);
		SetMemory(0x592984, SetTo, 0x61482072);
		SetMemory(0x592988, SetTo, 0x20686374);
		SetMemory(0x59298C, SetTo, 0x554E5528);
		SetMemory(0x592990, SetTo, 0x29444553);
		SetMemory(0x592994, SetTo, 0x00000000);
		SetMemory(0x5929A0, SetTo, 0x7466654C);
		SetMemory(0x5929A4, SetTo, 0x70705520);
		SetMemory(0x5929A8, SetTo, 0x4C207265);
		SetMemory(0x5929AC, SetTo, 0x6C657665);
		SetMemory(0x5929B0, SetTo, 0x6F6F4420);
		SetMemory(0x5929B4, SetTo, 0x00000072);
		SetMemory(0x5929C0, SetTo, 0x68676952);
		SetMemory(0x5929C4, SetTo, 0x70552074);
		SetMemory(0x5929C8, SetTo, 0x20726570);
		SetMemory(0x5929CC, SetTo, 0x6576654C);
		SetMemory(0x5929D0, SetTo, 0x6F44206C);
		SetMemory(0x5929D4, SetTo, 0x0000726F);
		SetMemory(0x5929E0, SetTo, 0x7466654C);
		SetMemory(0x5929E4, SetTo, 0x74695020);
		SetMemory(0x5929E8, SetTo, 0x6F6F4420);
		SetMemory(0x5929EC, SetTo, 0x00000072);
		SetMemory(0x592A00, SetTo, 0x68676952);
		SetMemory(0x592A04, SetTo, 0x69502074);
		SetMemory(0x592A08, SetTo, 0x6F442074);
		SetMemory(0x592A0C, SetTo, 0x0000726F);
		SetMemory(0x592A20, SetTo, 0x696E694D);
		SetMemory(0x592A24, SetTo, 0x4769696E);
		SetMemory(0x592A28, SetTo, 0x00006E75);
		SetMemory(0x592A40, SetTo, 0x7466654C);
		SetMemory(0x592A44, SetTo, 0x6C615720);
		SetMemory(0x592A48, SetTo, 0x694D206C);
		SetMemory(0x592A4C, SetTo, 0x6C697373);
		SetMemory(0x592A50, SetTo, 0x72542065);
		SetMemory(0x592A54, SetTo, 0x00007061);
		SetMemory(0x592A60, SetTo, 0x7466654C);
		SetMemory(0x592A64, SetTo, 0x6C615720);
		SetMemory(0x592A68, SetTo, 0x6C46206C);
		SetMemory(0x592A6C, SetTo, 0x20656D61);
		SetMemory(0x592A70, SetTo, 0x70617254);
		SetMemory(0x592A74, SetTo, 0x00000000);
		SetMemory(0x592A80, SetTo, 0x68676952);
		SetMemory(0x592A84, SetTo, 0x61572074);
		SetMemory(0x592A88, SetTo, 0x4D206C6C);
		SetMemory(0x592A8C, SetTo, 0x69737369);
		SetMemory(0x592A90, SetTo, 0x5420656C);
		SetMemory(0x592A94, SetTo, 0x00706172);
		SetMemory(0x592AA0, SetTo, 0x68676952);
		SetMemory(0x592AA4, SetTo, 0x61572074);
		SetMemory(0x592AA8, SetTo, 0x46206C6C);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x592AAC, SetTo, 0x656D616C);
		SetMemory(0x592AB0, SetTo, 0x61725420);
		SetMemory(0x592AB4, SetTo, 0x00000070);
		SetMemory(0x592AC0, SetTo, 0x72617453);
		SetMemory(0x592AC4, SetTo, 0x6F4C2074);
		SetMemory(0x592AC8, SetTo, 0x69746163);
		SetMemory(0x592ACC, SetTo, 0x00006E6F);
		SetMemory(0x592AE0, SetTo, 0x67616C46);
		SetMemory(0x592AE4, SetTo, 0x00000000);
		SetMemory(0x592B00, SetTo, 0x6C616D53);
		SetMemory(0x592B04, SetTo, 0x6843206C);
		SetMemory(0x592B08, SetTo, 0x61737972);
		SetMemory(0x592B0C, SetTo, 0x0073696C);
		SetMemory(0x592B20, SetTo, 0x20697350);
		SetMemory(0x592B24, SetTo, 0x74696D45);
		SetMemory(0x592B28, SetTo, 0x00726574);
		SetMemory(0x592B40, SetTo, 0x2E305823);
		SetMemory(0x592B44, SetTo, 0x9EBDEF35);
		SetMemory(0x592B48, SetTo, 0x2E355823);
		SetMemory(0x592B4C, SetTo, 0x00002030);
		SetMemory(0x592B60, SetTo, 0x7961684B);
		SetMemory(0x592B64, SetTo, 0x69726164);
		SetMemory(0x592B68, SetTo, 0x7243206E);
		SetMemory(0x592B6C, SetTo, 0x61747379);
		SetMemory(0x592B70, SetTo, 0x0000006C);
		SetMemory(0x592B80, SetTo, 0x656E694D);
		SetMemory(0x592B84, SetTo, 0x206C6172);
		SetMemory(0x592B88, SetTo, 0x6E756843);
		SetMemory(0x592B8C, SetTo, 0x5428206B);
		SetMemory(0x592B90, SetTo, 0x20657079);
		SetMemory(0x592B94, SetTo, 0x00002931);
		SetMemory(0x592BA0, SetTo, 0x656E694D);
		SetMemory(0x592BA4, SetTo, 0x206C6172);
		SetMemory(0x592BA8, SetTo, 0x6E756843);
		SetMemory(0x592BAC, SetTo, 0x5428206B);
		SetMemory(0x592BB0, SetTo, 0x20657079);
		SetMemory(0x592BB4, SetTo, 0x00002932);
		SetMemory(0x592BC0, SetTo, 0x70736556);
		SetMemory(0x592BC4, SetTo, 0x20656E65);
		SetMemory(0x592BC8, SetTo, 0x2062724F);
		SetMemory(0x592BCC, SetTo, 0x6F725028);
		SetMemory(0x592BD0, SetTo, 0x73736F74);
		SetMemory(0x592BD4, SetTo, 0x70795420);
		SetMemory(0x592BD8, SetTo, 0x29312065);
		SetMemory(0x592BDC, SetTo, 0x00000000);
		SetMemory(0x592BE0, SetTo, 0x70736556);
		SetMemory(0x592BE4, SetTo, 0x20656E65);
		SetMemory(0x592BE8, SetTo, 0x2062724F);
		SetMemory(0x592BEC, SetTo, 0x6F725028);
		SetMemory(0x592BF0, SetTo, 0x73736F74);
		SetMemory(0x592BF4, SetTo, 0x70795420);
		SetMemory(0x592BF8, SetTo, 0x29322065);
		SetMemory(0x592BFC, SetTo, 0x00000000);
		SetMemory(0x592C00, SetTo, 0x70736556);
		SetMemory(0x592C04, SetTo, 0x20656E65);
		SetMemory(0x592C08, SetTo, 0x20636153);
		SetMemory(0x592C0C, SetTo, 0x72655A28);
		SetMemory(0x592C10, SetTo, 0x79542067);
		SetMemory(0x592C14, SetTo, 0x31206570);
		SetMemory(0x592C18, SetTo, 0x00000029);
		SetMemory(0x592C20, SetTo, 0x70736556);
		SetMemory(0x592C24, SetTo, 0x20656E65);
		SetMemory(0x592C28, SetTo, 0x20636153);
		PreserveTrigger();
	},
}


Trigger {
	players = {P8},
	actions = {
		SetMemory(0x592C2C, SetTo, 0x72655A28);
		SetMemory(0x592C30, SetTo, 0x79542067);
		SetMemory(0x592C34, SetTo, 0x32206570);
		SetMemory(0x592C38, SetTo, 0x00000029);
		SetMemory(0x592C40, SetTo, 0x70736556);
		SetMemory(0x592C44, SetTo, 0x20656E65);
		SetMemory(0x592C48, SetTo, 0x6B6E6154);
		SetMemory(0x592C4C, SetTo, 0x65542820);
		SetMemory(0x592C50, SetTo, 0x6E617272);
		SetMemory(0x592C54, SetTo, 0x70795420);
		SetMemory(0x592C58, SetTo, 0x29312065);
		SetMemory(0x592C5C, SetTo, 0x00000000);
		SetMemory(0x592C60, SetTo, 0x70736556);
		SetMemory(0x592C64, SetTo, 0x20656E65);
		SetMemory(0x592C68, SetTo, 0x6B6E6154);
		SetMemory(0x592C6C, SetTo, 0x65542820);
		SetMemory(0x592C70, SetTo, 0x6E617272);
		SetMemory(0x592C74, SetTo, 0x70795420);
		SetMemory(0x592C78, SetTo, 0x29322065);
		SetMemory(0x592C7C, SetTo, 0x00000000);
		PreserveTrigger();
	},
}



f_MemCpy(FP,f_GunSendStrPtr,_TMem(Arr(f_GunSendT[3],0),"X","X",1),f_GunSendT[2])
f_MemCpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])

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
CMov(FP,UpGradeAv,AtkUpMax)
CElseX()
CMov(FP,UpGradeAv,255)
CIfXEnd()
DoActionsX(FP,SetCDeaths(FP,SetTo,0,ifUpisAtk))


CMov(FP,0x6509B0,UpgradeCP)
OCU_Jump = def_sIndex()
CJumpEnd(FP,OCU_Jump)
NWhile(FP,{
TCVar(FP,CurrentUpgrade[2],AtMost,_Sub(UpGradeAv,1)),
CVar(FP,UpgradeMax[2],AtLeast,1),
TAccumulate(CurrentPlayer,AtLeast,_Mul(CurrentUpgrade,UpgradeFactor),Ore),
TMemoryX(TempUpgradePtr,AtMost,_Mul(TempUpgradeMaskRet,_Sub(UpGradeAv,1)),_Mul(TempUpgradeMaskRet,_Mov(255)))})
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
f_Movcpy(FP,_Add(UPCompStrPtr,Str12L-3),VArr(UpCompTxt,0),5*4)
f_Movcpy(FP,_Add(UPCompStrPtr,Str12L-3+20+Str22L-3),VArr(UpCompRet,0),5*4)
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
CDoActions(FP,{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x0D\x0D\x0DUPC".._0D,4),
		SetMemory(0x6509B0,SetTo,FP)
		})
NJumpEnd(FP,0x24)
SetCallEnd()




Call_HeroKillPoint = SetCallForward()
SetCall(FP)

f_SaveCP()
f_Read(FP,BackupCP,HIndex,"X",0xFF)
f_Mod(FP,HIndex2,HIndex,2,0xFF)
f_Read(FP,_Add(_Div(HIndex,2),_Mov(EPDF(0x663EB8))),HPoint)
NIfX(FP,{TMemory(_Mem(HIndex2),AtLeast,1)})
f_Div(FP,HPoint,65536)
NElseX()
f_Mod(FP,HPoint,65536)
NIfXEnd()
CMov(FP,HPoint10,_Mul(HPoint,HPointVar))
ItoDec(FP,HPoint10,VArr(HPointT,0),2,0x1F,0)
for j=0,4 do
TriggerX(FP,{VArrayX(VArr(HPointT,j),"Value",Exactly,0,0xFF)},{
SetVArrayX(VArr(HPointT,j),"Value",SetTo,0x0D,0xFF)
},{preserved})
TriggerX(FP,{VArrayX(VArr(HPointT,j),"Value",Exactly,0,0xFF00)},{
SetVArrayX(VArr(HPointT,j),"Value",SetTo,0x0D*0x100,0xFF00)
},{preserved})
TriggerX(FP,{VArrayX(VArr(HPointT,j),"Value",Exactly,0,0xFF0000)},{
SetVArrayX(VArr(HPointT,j),"Value",SetTo,0x0D*0x10000,0xFF0000)
},{preserved})
TriggerX(FP,{VArrayX(VArr(HPointT,j),"Value",Exactly,0,0xFF000000)},{
SetVArrayX(VArr(HPointT,j),"Value",SetTo,0x0D*0x1000000,0xFF000000)
},{preserved})
end
f_MovCpy(FP,_Add(HeroTxtStrPtr,Str19L+0x20+Str20L),VArr(HPointT,0),16)
f_MemCpy(FP,_Add(HeroTxtStrPtr,Str19L),_Add(_Mul(HIndex,_Mov(0x20)),UnitNamePtr),0x20)
CDoActions(FP,{TSetScore(Force1,Add,HPoint10,Kills)})
HText = "\x0D\x0D\x0DHK".._0D
DoActions(FP,CopyCpAction({DisplayTextX(HText,4)},HumanPlayers,FP))
TriggerX(FP,{CDeaths(FP,AtMost,2,SoundLimit)},{CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{Preserved})

f_LoadCP()
SetCallEnd()

GunPosSave_CallIndex = SetCallForward()

CVoid_ID = CreateVar()
CVoid_ID2 = CreateVar()
SetCall(FP)
DoActions(FP,MoveCp(Subtract,15*4))
SaveCp(FP,BackupPosData)
DoActions(FP,MoveCp(Subtract,1*4))
f_SaveCP()
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
	ItoDec(FP,G_CA,VArr(f_GunNumT,0),2,0x1F,0)
	_0DPatchX(FP,f_GunNumT,5)
	f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),5*4)
	DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
end
CElseX()
DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
CIfXEnd()

f_LoadCP()
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
	ItoDec(FP,G_CA,VArr(f_GunNumT,0),2,0x1F,0)
	_0DPatchX(FP,f_GunNumT,5)
	f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),5*4)
	DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
end
CElseX()
DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
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
	CElseIfX(PlayerCheck(i,1))
	CMov(FP,SelCP,i)
	end
	CIfXEnd()
LoadCp(FP,SelCP)

HiddenCommand = {51,50,52,50,52,50,50}
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
		SetCDeaths(FP,Add,1,HiddenMode);
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


CIf(FP,{CDeaths(FP,AtLeast,7,HiddenMode),CDeaths(FP,Exactly,0,ModeO)})

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
		SetCDeaths(FP,SetTo,1,Gmode);
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
		SetCDeaths(FP,SetTo,2,Gmode);
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
		SetCDeaths(FP,SetTo,3,Gmode);
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

Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
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

CIf(FP,CDeaths(FP,AtLeast,7,HiddenMode))
HiddenModeStr = "\x0D\x0D\x0D\x0D\x13\x10[ \x04(\x08HP \x04: -0) (\x1BATK \x04: -0) (\x1FPts \x04: -0) (\x10혼돈 옵션 \x04: OFF) \x10]\x0D\x0D\x0D\x0D\x0D"
HiddenModeStr2 = "\x0D\x0D\x0D\x0D\x13\x10[ \x04(\x08HP \x04: -0) (\x1BATK \x04: -0) (\x1FPts \x04: -0) (\x10혼돈 옵션 \x08: ON) \x10]\x0D\x0D\x0D\x0D\x0D"
CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
Print_StringX(FP,VArr(HiddenModeT,0),HiddenModeStr,0)
CelseX()
Print_StringX(FP,VArr(HiddenModeT,0),HiddenModeStr2,0)
CIfXEnd()
HiddenModeL = GetStrSizeD(0,HiddenModeStr)
HiddenFindT = "\x13\x04히든 커맨드 입력성공.\n\x13\x04값 올림 버튼 : \x071,2,3. \x04내림 버튼 : \x07A,S,D\n\x13\x10혼돈 옵션 \x07활성화 \x04: ~버튼"
WavFile = "staredit\\wav\\Unlock.ogg"
	Trigger {
	players = {FP},
	conditions = {
		Label(0);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(HiddenFindT,4);
		DisplayText("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10혼돈 옵션 \x04: OFF) \x10]",4);
		SetMemory(0x6509B0, SetTo, FP);
	}
	}


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
for i = 2, 0, -1 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHP[2],AtLeast,(2^i),(2^i));
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,4),SetTo,(2^i)*65536,(2^i)*65536);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHPM[2],AtLeast,(2^i),(2^i));
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,4),SetTo,(2^i)*65536,(2^i)*65536);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATK[2],AtLeast,(2^i),(2^i));
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,7),SetTo,(2^i)*16777216,(2^i)*16777216);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATKM[2],AtLeast,(2^i),(2^i));
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,7),SetTo,(2^i)*16777216,(2^i)*16777216);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],AtLeast,(2^i),(2^i));
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,11),SetTo,(2^i)*1,(2^i)*1);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPtsM[2],AtLeast,(2^i),(2^i));
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,11),SetTo,(2^i)*1,(2^i)*1);
		PreserveTrigger();
	}
}
end


Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHPM[2],AtLeast,1);
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,4),SetTo,0x2D*256,0xFF00);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHPM[2],AtMost,0);
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,4),SetTo,0x0D*256,0xFF00);
		PreserveTrigger();
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATKM[2],AtLeast,1);
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,7),SetTo,0x2D*65536,0xFF0000);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATKM[2],AtMost,0);
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,7),SetTo,0x0D*65536,0xFF0000);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPtsM[2],AtLeast,1);
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,10),SetTo,0x2D*16777216,0xFF000000);
		PreserveTrigger();
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPtsM[2],AtMost,0);
		
	},
	actions = {
		SetCVAar(VArr(HiddenModeT,10),SetTo,0x0D*16777216,0xFF000000);
		PreserveTrigger();
	}
}

f_Movcpy(FP,HiddenModeStrPtr,VArr(HiddenModeT,0),HiddenModeL-3)





WavFile = "staredit\\wav\\sel_g.ogg"
	Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ToggleSound);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText("HD".._0D,4);
		SetMemory(0x6509B0, SetTo, FP);
		SetCDeaths(FP,SetTo,0,ToggleSound);
		PreserveTrigger();
	}
	}

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
MM = 09
DD = 12
HH = 00
function PushErrorMsg(Message)
	_G["\n"..Message.."\n"]() 
end

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
			isname(i,"UnusedTypeGB");
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
f_MemCpy(FP,0x641598,_TMem(Arr(Str24,0),"X","X",1),Str24L)
f_MovCpy(FP,0x641598+Str24L-3,VArr(Names[j],0),4*6)
CIfEnd()
--[[
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(FP,Exactly,0,SelectorT);
		CVar(FP,SelCP[2],Exactly,j-1);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(Text2,4);
		DisplayText("\x0D\x0D\x0D"..Player[j].."".._0D,4);
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
	}
	}
]]
end
CIf(FP,{CDeaths(FP,Exactly,0,ModeSel),CDeaths(FP,Exactly,0,BGMSel)})




for i = 0, 3 do
CIf(FP,CDeaths(FP,Exactly,i,Gmode))
f_MemCpy(FP,0x641598+Str24L+(4*6)-5,_TMem(Arr(Str25[i+1],0),"X","X",1),Str25L[i+1])
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
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,Gmode);
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

--[[
Text1 = "\x13\x07난이도\x04를 선택해주세요.\n\x13\x03[Q] \x0EEASY\n\x13\x04[W] \x08HARD\n\x13\x04[E] \x11BURST\n\x13\x04선택 완료 후 Y버튼을 눌러주세요. 15초 후 자동으로 \x0EEASY\x04모드가 선택됩니다."
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,Gmode);
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
		PreserveTrigger();
		
	},
	}
Text1 = "\x13\x07난이도\x04를 선택해주세요.\n\x13\x04[Q] \x0EEASY\n\x13\x03[W] \x08HARD\n\x13\x04[E] \x11BURST\n\x13\x04선택 완료 후 Y버튼을 눌러주세요. 15초 후 자동으로 \x0EEASY\x04모드가 선택됩니다."
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,Gmode);
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
		PreserveTrigger();
		
	},
	}
Text1 = "\x13\x07난이도\x04를 선택해주세요.\n\x13\x04[Q] \x0EEASY\n\x13\x04[W] \x08HARD\n\x13\x03[E] \x11BURST\n\x13\x04선택 완료 후 Y버튼을 눌러주세요. 15초 후 자동으로 \x0EEASY\x04모드가 선택됩니다."
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,3,Gmode);
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
		PreserveTrigger();
		
	},
	}
--]]
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
		CDeaths(FP,Exactly,i,Gmode);
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
		CDeaths(FP,AtLeast,1,Gmode);
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
		CDeaths(FP,Exactly,1,Gmode);
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
		CDeaths(FP,Exactly,2,Gmode);
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
		CDeaths(FP,Exactly,3,Gmode);
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
f_MemCpy(FP,0x641598+Str24L+(4*6)-5,_TMem(Arr(Str27[i],0),"X","X",1),Str27L[i])
CIfEnd()
end


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
		CDeaths(FP,AtLeast,1,Gmode);
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

Text3 = "\x13\x18게임옵션 \x04선택이 완료되었습니다."
WavFile = "staredit\\wav\\Select.ogg"
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,ModeO);
		CDeaths(FP,Exactly,2,BGMSel);
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(WavFile);
		DisplayText(Text3,4);
		SetMemory(0x6509B0, SetTo, FP);
		
	},
	}

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
		CDeaths(FP,AtLeast,0,modeT);
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
		CDeaths(FP,AtLeast,3,modeT);
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
		CDeaths(FP,AtLeast,6,modeT);
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
		CDeaths(FP,AtLeast,9,modeT);
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
		CDeaths(FP,AtLeast,12,modeT);
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
		CDeaths(FP,AtLeast,15,modeT);
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
		CDeaths(FP,AtLeast,18,modeT);
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
		CDeaths(FP,AtLeast,21,modeT);
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
		CDeaths(FP,AtLeast,21+(24*2),modeT);
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
		CDeaths(FP,AtLeast,21+(24*3),modeT);
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
		CDeaths(FP,AtLeast,21+(24*4),modeT);
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
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*5),modeT);
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
	if Limit == 1 then 

		Trigger { -- 인트로1
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,1,ModeO);
			CDeaths(FP,AtLeast,1,Testmode);
		},
		actions = {
			SetCDeaths(FP,SetTo,20+(24*5),modeT)
			
		},
		}
	end
	Shape1013 = {6   ,{3696, 3808},{3728, 3808},{3760, 3808},{3664, 3808},{3632, 3808},{3600, 3808}}
	Shape2013 = {6   ,{3696, 3872},{3728, 3872},{3760, 3872},{3664, 3872},{3632, 3872},{3600, 3872}}
	Shape3013 = {6   ,{3696, 3744},{3728, 3744},{3760, 3744},{3664, 3744},{3632, 3744},{3600, 3744}}
	Shape4013 = {6   ,{3696, 3776},{3728, 3776},{3760, 3776},{3664, 3776},{3632, 3776},{3600, 3776}}
	Shape5013 = {6   ,{3696, 3840},{3728, 3840},{3760, 3840},{3664, 3840},{3632, 3840},{3600, 3840}}
	Shape6013 = {6   ,{3696, 3712},{3728, 3712},{3760, 3712},{3664, 3712},{3632, 3712},{3600, 3712}}


	MarCreateSh = {Shape1013,Shape2013,Shape3013,Shape4013,Shape5013,Shape6013}
CIfOnce(FP,{
	CDeaths(FP,AtLeast,1,ModeO);
	CDeaths(FP,AtLeast,21+(24*5),modeT);
})
for i = 0, 5 do
CSPlot(MarCreateSh[i+1],i,20,0,{0,0},1,32,FP,PlayerCheck(i,1))
end
CIfEnd()
Trigger { -- 인트로1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
		CDeaths(FP,AtLeast,21+(24*5),modeT);
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
		CDeaths(FP,AtLeast,21+(24*5),modeT);
		CDeaths(FP,AtLeast,1,NBMode);


	},
	actions = {
		SetResources(Force1,Add,150000,Ore);ModifyUnitEnergy(All,71,Force2,64,0),ModifyUnitEnergy(All,67,Force2,64,0),ModifyUnitEnergy(All,63,Force2,64,0)
		
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
	CElseIfX(PlayerCheck(i,1))
	f_Read(FP,0x6284E8+(i*0x30),Cunit2,Cunit3)
--	CMov(FP,Dt,_ReadF(0x58A364+48*180+4*i))--
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
CIfX(FP,PlayerCheck(i,1))
CDoActions(FP,{TSetDeathsX(i,Subtract,Dt,440,0xFFFFFF)})
CMov(FP,0x57f120 + (i*4) , CanC)
CMov(FP,0x582174 + (i*4) , CanDefeat)
CElseX()
DoActions(FP,{SetDeaths(i,SetTo,0,440)})
CIfXEnd()
end
CDoActions(FP,{TSetDeathsX(FP,Subtract,Dt,440,0xFFFFFF)})


CIf(FP,{CVar(FP,HiddenPts[2],AtLeast,1)
})
CMov(FP,CanDefeat,0)
CMov(FP,ExchangeRate,ExrateBackup)
CIfEnd()


CIfX(FP,{CVar(FP,Cunit3[2],AtLeast,1),CVar(FP,Cunit3[2],AtMost,0x7FFFFFFF)})
CMov(FP,0x6509B0,Cunit3)

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
f_SaveCP()
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
f_LoadCP()
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
Trigger2(FP,{Command(11,AtLeast,1,80)},{GiveUnits(1,80,11,64,7)},{Preserved})
Trigger2(FP,{Command(11,AtLeast,1,21)},{GiveUnits(1,21,11,64,7)},{Preserved})
Trigger2(FP,{Command(11,AtLeast,1,80)},{GiveUnits(1,80,11,64,6)},{Preserved})
Trigger2(FP,{Command(11,AtLeast,1,21)},{GiveUnits(1,21,11,64,6)},{Preserved})
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

f_SaveCP()
CMov(FP,CPosX,_Mov(_ReadF(BackupCP),0xFFF))
CMov(FP,CPosY,_Div(_Mov(_ReadF(BackupCP),0xFFF0000),_Mov(65536)))
CDoActions(FP,{
TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
Createunit(1,84,1,FP)
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
f_LoadCP()

CAdd(FP,CocoonValue,1)
CAdd(FP,0x6509B0,1)
CAdd(FP,CurCCLI,1)
CWhileEnd()
CIfEnd()
DoActionsX(FP,SetCDeaths(FP,Subtract,1,CocoonLaunch))
NIfEnd()



-- 시체 상시검사 단락
CJump(FP,0x103) -- if NonGameStart
CunitCtrig_Part1(FP)
MoveCp("X",25*4)
function Call_GunPosSave(BdID)
CallTriggerX(FP,GunPosSave_CallIndex,DeathsX(CurrentPlayer,Exactly,BdID,0,0xFF))
end









Call_GunPosSave(132,0)
Call_GunPosSave(133,1)
Call_GunPosSave(216,2)
Call_GunPosSave(190,3)
Call_GunPosSave(147,4)
Call_GunPosSave(156,5)
Call_GunPosSave(109,6)
Call_GunPosSave(173,7)
Call_GunPosSave(201,8)
Call_GunPosSave(175,9)
Call_GunPosSave(152,10)
Call_GunPosSave(151,11)
Call_GunPosSave(148,12)
Call_GunPosSave(150,13)
Call_GunPosSave(154,13)
Call_GunPosSave(200,13)
CIf(FP,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCP()
Trigger { -- No comment (6496767D)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);
	},
	actions = {
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."HM".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,20);
		SetCDeaths(FP,Add,1,HMDeaths[j]);
		SetCDeaths(FP,Add,1,Die_SEC);
		PreserveTrigger();
		},
	}
	f_LoadCP()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()
CIf(FP,DeathsX(CurrentPlayer,Exactly,16,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCP()
Trigger { -- No comment (6496767D)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);
	},
	actions = {
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."RM".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,27);
		SetScore(j-1,Add,3,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);
		PreserveTrigger();
		},
	}
	f_LoadCP()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

CIf(FP,DeathsX(CurrentPlayer,Exactly,12,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCP()
Trigger { -- No comment (6496767D)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);
	},
	actions = {
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."Su".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,27);
		SetScore(j-1,Add,100,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);
		PreserveTrigger();
		},
	}
	f_LoadCP()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()


CIf(FP,DeathsX(CurrentPlayer,Exactly,0,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCP()
Trigger { -- No comment (6496767D)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);
	},
	actions = {
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."Te".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,27);
		SetScore(j-1,Add,100,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);
		PreserveTrigger();
		},
	}
	f_LoadCP()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()


CIf(FP,DeathsX(CurrentPlayer,Exactly,100,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCP()
Trigger { -- No comment (6496767D)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);
	},
	actions = {
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."LM".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,100);
		SetScore(j-1,Add,1,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);
		PreserveTrigger();
		},
	}
	f_LoadCP()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()
DoActions(FP,MoveCp(Subtract,16*4))
NIf(FP,DeathsX(CurrentPlayer,AtLeast,1*65536,0,0xFF0000))
DoActions(FP,MoveCp(Add,16*4))
------------

for i = 1, #HeroIndexArr do
NIf(FP,DeathsX(CurrentPlayer,Exactly,HeroIndexArr[i],0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
end
NIf(FP,DeathsX(CurrentPlayer,Exactly,162,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
NIf(FP,DeathsX(CurrentPlayer,Exactly,176,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
NIf(FP,DeathsX(CurrentPlayer,Exactly,177,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
NIf(FP,DeathsX(CurrentPlayer,Exactly,178,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()

DoActions(FP,MoveCp(Subtract,16*4))
NIfEnd()
DoActions(FP,MoveCp(Add,16*4))

DoActions(FP,{MoveCp(Add,15*4),SetDeathsX(CurrentPlayer,SetTo,0*16777216,0,0xFF000000),MoveCp(Subtract,31*4),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000)})
ClearCalc()
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
DeathsX(EPDF(0x628298-0x150*i+(40*4)),AtLeast,1*16777216,0,0xFF000000),
DeathsX(EPDF(0x628298-0x150*i+(19*4)),Exactly,0*256,0,0xFF00),
},
{MoveCp(Add,25*4)})
end
CunitCtrig_End()
CWhile(FP,CDeaths(FP,AtLeast,1,Die_SEC),SetCDeaths(FP,Subtract,1,Die_SEC))
TriggerX(FP,{CDeaths(FP,AtMost,4,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{Preserved})
CWhileEnd()
DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,0,SoundLimitT)},{Preserved})

Install_boss()

Create_G_CA_Arr()
CIfX(FP,{CVar(FP,count[2],AtMost,GunLimit)}) -- 건작함수 제어
DoActions(FP,{
	SetInvincibility(Disable,132,Force2,64);
	SetInvincibility(Disable,133,Force2,64);
})
CElseX()
DoActions(FP,{
	SetInvincibility(Enable,132,Force2,64);
	SetInvincibility(Enable,133,Force2,64);
})
CIfXEnd()



CMov(FP,Actived_Gun,0)
for i = 0, 127 do
	CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
		Var_InputCVar,
		SetCtrigX("X",G_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
		SetCVar(FP,f_GunNum[2],SetTo,i),
		SetCVar(FP,Actived_Gun[2],Add,1),
		SetNext("X",f_Gun,0),SetNext(f_Gun+1,"X",1), -- Call f_Gun
		SetCtrigX("X",f_Gun+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
		SetCtrigX("X",f_Gun+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
		SetCtrig1X("X",f_Gun+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
	}, 1, 0x500+i)
end



CIf(FP,CVar(FP,HondonMode[2],AtLeast,1))
local HondonT = CreateCcode()
CIf(FP,CDeaths(FP,AtMost,0,HondonT),SetCDeaths(FP,SetTo,10,HondonT))
CunitCtrig_Part1(FP)
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
for i = 37,57 do
	NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
end
for i = 60,81 do
	NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
end
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,12,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,80,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,21,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,88,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,86,0,0xFF))

ClearCalc()
NJumpXEnd(FP,0x100)

DoActions(FP,MoveCp(Subtract,12*4))
Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		SetDeaths(CurrentPlayer,SetTo,20000,0);
		MoveCp(Add,5*4);
		SetDeathsX(CurrentPlayer,SetTo,4000,0,0xFFFF);
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,127*65536,0,0xFF0000);
		MoveCp(Add,5*4);
		PreserveTrigger();
	}
}

ClearCalc()

CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtLeast,1*256,0,0xFF00),
	
},
{
	MoveCp(Add,25*4)})
end
CunitCtrig_End()
CIfEnd()
CIfEnd()


if Limit == 1 then
CIf(FP,CDeaths(FP,AtLeast,1,TestMode))

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(P1,AtLeast,1,201);
		
	},
	actions = {
		--SetDeaths(FP,SetTo,1,200);
		ModifyUnitEnergy(All,"Any unit",Force2,"Anywhere",0);
		RemoveUnit("Zerg Lair",Force2);
		RemoveUnit("Hive",Force2);
		RemoveUnit("Mature Crysalis",Force2);
		RemoveUnit("Stasis Cell",Force2);
		RemoveUnit("Xel'Naga Temple",Force2);
		RemoveUnit("Small Chrysalis",Force2);
		SetCDeaths(FP,SetTo,6001,GunBossAct);
		SetCDeaths(FP,SetTo,2,FormCon);
	}
	}
Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 1);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 2);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 3);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 4);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 5);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
		
	}
	}
--	local TestV = CreateVar(FP)
--	local TestV2 = CreateVar(FP)
--DoActionsX(FP,SetCtrigX("X",TestV[2],0x15C,0,SetTo,"X",0x580,CAddr("CMask",2),1,0))
--f_Read(FP,TestV,TestV2)
--CMov(FP,0x57F120,TestV2)
CIfEnd()
end
--[[
for i = 0, 1699 do -- 오토스팀
Trigger {
	players = {FP},
	conditions = {
		DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtMost,4,0,0xFF),
		DeathsX(EPDF(0x628298-0x150*i+(69*4)),AtMost,0,0,0xFF00),
	},
	actions = {
		SetDeathsX(EPDF(0x628298-0x150*i+(69*4)),SetTo,255*256,0,0xFF00);
		PreserveTrigger();
	}
}
end
]]


CJumpEnd(FP,0x103) -- if NonGameStart End
SetRecoverCp()
RecoverCp(FP)
CIfOnce(AllPlayers,{CDeaths(FP,AtLeast,1,ModeO)},{SetCDeaths(FP,SetTo,1,BGMMode),ModifyUnitEnergy(All,"Any unit",AllPlayers,64,100)}) -- onPluginStart
NBT = {}
for i = 0, 5 do
	table.insert(NBT,SetMemoryB(0x57F27C+(228*i)+125,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스

end

for i = 0, 5 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],AtMost,0);

		},
	actions = {
		SetMemory(0x582144 + (i*4),SetTo,2000);
		SetMemory(0x5821A4 + (i*4),SetTo,2000);
		}
		}
	end

Trigger { -- 컴퓨터 플레이어 색상 설정
	players = {FP},
	conditions = {
		Always();
	},
	actions = {
SetMemoryX(0x581DA4,SetTo,59*65536,0xFF0000), --P7 컬러
	SetMemoryX(0x581DDC,SetTo,59*1,0xFF); --P7 미니맵 
SetMemoryX(0x581DAC,SetTo,166*65536,0xFF0000), --P8컬러
SetMemoryX(0x581DDC,SetTo,166*256,0xFF00); --P8 미니맵
		--[[
		SetMemoryX(0x581DDC,SetTo,0*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DA4,SetTo,0*65536,0xFF0000), --P7 컬러
		SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8컬러
]]
		
},
}
CIf(FP,CDeaths(FP,AtLeast,7,HiddenMode))
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],Exactly,0);
		CVar(FP,HiddenHP[2],Exactly,0);
		CVar(FP,HiddenAtk[2],Exactly,0);
		CVar(FP,HiddenPtsM[2],Exactly,0);
		CVar(FP,HiddenHPM[2],Exactly,0);
		CVar(FP,HiddenAtkM[2],Exactly,0);
		CVar(FP,HondonMode[2],Exactly,0);
		
	},
	actions = {
		SetCDeaths(FP,SetTo,0,HiddenMode);
	}
}




for i = 1, 5 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],Exactly,i);
	},
	actions = {
		SetCVar(FP,HPointVar[2],SetTo,HPointFactor+(((HPointFactor*5)/4)*i));
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPtsM[2],Exactly,i);
	},
	actions = {
		SetCVar(FP,HPointVar[2],SetTo,HPointFactor-(i*(HPointFactor/5)));
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHP[2],Exactly,i);
	},
	actions = {
		SetMemory(0x662390, Add, i*16000*256);
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHPM[2],Exactly,i);
	},
	actions = {
		SetMemory(0x662350 + (4*12), Subtract, i*20000*256);
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenAtk[2],Exactly,i);
	},
	actions = {		
		SetMemoryX(0x656F98, Add, i*32*65536,0xFFFF0000);--기본공
		SetMemoryX(0x657760, Add, i*4*65536,0xFFFF0000);--계수
		SetMemoryX(0x656F9C, Add, i*72,0xFFFF);
		SetMemoryX(0x657764, Add, i*7,0xFFFF);
		SetMemoryX(0x656EB0, Add, i*32*65536,0xFFFF0000);--
		SetMemoryX(0x657678, Add, i*3*65536,0xFFFF0000);--
		SetMemoryW(0x657678+(2*2),Add,10*i);
		SetMemoryW(0x656EB0+(2*2),Add,256*i);
		SetMemoryW(0x657678+(122*2),Add,20*i);
		SetMemoryW(0x656EB0+(122*2),Add,1500*i);
		
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenAtkM[2],Exactly,i);
	},
	actions = {
		SetCVar(FP,AtkUpMax[2],SetTo,50+(200-(40*i)));
		
		SetMemoryB(0x58D088+(0*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(1*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(2*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(3*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(4*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(5*46)+7,SetTo,50+(200-(40*i)));

		SetMemoryB(0x58D088+(0*46)+14,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(1*46)+14,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(2*46)+14,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(3*46)+14,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(4*46)+14,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(5*46)+14,SetTo,50+(200-(40*i)));
	}
}

end
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,7,HiddenMode);
		CVar(FP,HondonMode[2],AtMost,0);
	},
	actions = {
		SetMemoryX(0x581DDC,SetTo,0*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DA4,SetTo,0*65536,0xFF0000), --P7 컬러
		SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8컬러
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],AtLeast,1);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,HiddenEnable);
	}
}

CIf(FP,CVar(FP,HondonMode[2],AtLeast,1))

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,7,HiddenMode);
		CVar(FP,HondonMode[2],AtLeast,1);
	},
	actions = {
		SetMemoryX(0x581DDC,SetTo,14*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DA4,SetTo,14*65536,0xFF0000), --P7 컬러
		SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8컬러
	}
}

table.insert( HondonPatchArr,SetMemoryX(0x6566E4, SetTo, 65536*2,0xFF0000))
table.insert( HondonPatchArr,SetMemory(0x656A88, SetTo, 0))
table.insert( HondonPatchArr,SetMemoryX(0x656714, SetTo, 3,0xFF))
table.insert( HondonPatchArr,SetMemoryX(0x656EE8, SetTo, 530,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x656FD4, SetTo, 1,0xFF))
table.insert( HondonPatchArr,SetMemoryX(0x656894, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x6570D4, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x65778C, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x65692C, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x65716C, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x657824, SetTo, 256,0xFFFF))

DoActions2(FP,HondonPatchArr)


CIfEnd()

CIfEnd()

NWhile(FP,{Bring(FP,AtLeast,1,217,64)})
TriggerX(FP,CDeaths(FP,Exactly,0,NBMode),{MoveLocation(1,217,FP,64),GiveUnits(1,217,FP,1,8),RemoveUnit(217,8),
CreateUnit(2,48,1,6),
CreateUnit(3,51,1,7),
CreateUnit(2,53,1,6),
CreateUnit(1,54,1,7),
CreateUnit(1,55,1,7),
CreateUnit(1,56,1,7),
CreateUnit(1,104,1,6),},{Preserved})

TriggerX(FP,CDeaths(FP,Exactly,1,NBMode),{MoveLocation(1,217,FP,64),GiveUnits(1,217,FP,1,8),RemoveUnit(217,8),
CreateUnit(1,48,1,6),
CreateUnit(1,53,1,6),
CreateUnit(1,54,1,7),
CreateUnit(1,55,1,7),
},{Preserved})

NWhileEnd()


CMov(FP,0x6509B0,RepUnitPtr)
CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))

f_SaveCP()

f_Read(FP,BackupCP,CPosX,"X",0xFFF)
f_Read(FP,BackupCP,CPosY,"X",0xFFF000)
f_Div(FP,CPosY,0x1000)
f_Read(FP,BackupCP,RepHeroIndex,"X",0xFF000000)
CDoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,0),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,0),
TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
TCreateunit(1,_Div(RepHeroIndex,_Mov(0x1000000)),1,_Add(_Mod(_Rand(),_Mov(2)),_Mov(6)))
})
f_LoadCP()
CAdd(FP,0x6509B0,1)
CWhileEnd()
CMov(FP,0x6509B0,FP)
TriggerX(FP,{CDeaths(FP,AtLeast,1,NBMode)},{KillUnit(125,AllPlayers),KillUnit(125,P12),NBT,SetMemoryX(0x6636F8, SetTo, 130*16777216,0xFF000000);})

for i = 1,3 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,i,GMode);
	},
	actions = {
		SetCVar(FP,B11_Level[2],SetTo,4-i);
	}
}
end
DoActionsX(FP,{SetCVar(FP,CanC[2],SetTo,2)})
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,GMode);
	},
	actions = {
		SetMemoryX(0x660EC8, SetTo, 9999,0xFFFF);
		SetMemoryX(0x664814, SetTo, 255,0xFF);
		SetCDeaths(FP,Add,2,SPGunCond);
		SetCVar(FP,CanC[2],Add,2);
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,GMode);
	},
	actions = {
		SetMemoryX(0x660EC8, SetTo, 9999,0xFFFF);
		SetMemoryX(0x664814, SetTo, 255,0xFF);
	}
}
Ex1 = {}
Ex2 = {}
Ex3 = {}
for i = 0, 5 do
table.insert(Ex1,EasyEx1P+(ExRate*i))
table.insert(Ex2,HDEx1P+(ExRate*i))
table.insert(Ex3,BurEx1P+(ExRate*i))
end

for i=1, 6 do -- 이지난이도
DoActions(FP,{SetSwitch("Switch 2",Random),SetSwitch("Switch 3",Random),SetSwitch("Switch 4",Random),SetSwitch("Switch 5",Random)})
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x0EEASY \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex1[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger { -- 미션 오브젝트 이지n인
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,GMode);
		Bring(AllPlayers,Exactly,i,111,"Anywhere");
	},
	actions = {
		SetMissionObjectives(MOText);
		SetCVar(FP,ExchangeRate[2],SetTo,Ex1[i]);
		SetCVar(FP,ExrateBackup[2],SetTo,Ex1[i]);
	},
	}
end
for i=1, 6 do -- 하드 난이도
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x08HARD \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex2[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger { -- 미션 오브젝트 이지n인
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,GMode);
		Bring(AllPlayers,Exactly,i,111,"Anywhere");
	},
	actions = {
		SetMissionObjectives(MOText);
		SetCVar(FP,ExchangeRate[2],SetTo,Ex2[i]);
		SetCVar(FP,ExrateBackup[2],SetTo,Ex2[i]);
	},
	}
end
for i=1, 6 do -- 버스트 난이도
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x1FBURST \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex3[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger { -- 미션 오브젝트 이지n인
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,3,GMode);
		Bring(AllPlayers,Exactly,i,111,"Anywhere");
	},
	actions = {
		SetMissionObjectives(MOText);
		SetCVar(FP,ExchangeRate[2],SetTo,Ex3[i]);
		SetCVar(FP,ExrateBackup[2],SetTo,Ex3[i]);
	},
	}
end

Trigger { -- 배속방지
	players = {FP},
	conditions = {
		Memory(0x51CE84,AtLeast,1001);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,5);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,FP);
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*6,Exactly,0,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*7,Exactly,0,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*6,Exactly,2,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*7,Exactly,2,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57efc0,AtLeast,1*256,0xFF00);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57efe4,AtLeast,1*256,0xFF00);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 싱글플 방지
players = {AllPlayers},
conditions = {
Memory(0x57F0B4, Exactly, 0);
},
actions = {
	DisplayText("\x13\x1B멀티플레이 전용 맵입니다. 배틀넷 멀티플레이로 시작해주세요.",4);
	Victory();
},
}
Trigger { -- 
players = {Force2},
conditions = {
},
actions = {
	RunAIScriptAt("Expansion Zerg Campaign Insane","AIZone");
	SetResources(CurrentPlayer,SetTo,0x10000000,OreAndGas);
	
},
}
Trigger { -- 저그인구수세팅
players = {FP},
conditions = {
},
actions = {
	SetMemory(0x582144+(6*4),SetTo,2000);
	SetMemory(0x5821A4+(6*4),SetTo,2000);
	SetMemory(0x582144+(7*4),SetTo,2000);
	SetMemory(0x5821A4+(7*4),SetTo,2000);
	
	
},
}
Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		GiveUnits(All,132,P8,4,0);
		GiveUnits(All,132,P8,5,0);
		GiveUnits(All,133,P8,4,0);
		GiveUnits(All,133,P8,5,0);
		GiveUnits(All,132,P8,6,1);
		GiveUnits(All,133,P8,6,1);
		GiveUnits(All,132,P8,7,2);
		GiveUnits(All,133,P8,7,2);
		GiveUnits(All,132,P8,8,3);
		GiveUnits(All,133,P8,8,3);
		GiveUnits(All,132,P8,9,4);
		GiveUnits(All,133,P8,9,4);
		GiveUnits(All,132,P8,10,5);
		GiveUnits(All,133,P8,10,5);
		GiveUnits(All,132,P8,11,6);
		GiveUnits(All,133,P8,11,6);
		GiveUnits(All,132,P8,12,7);
		GiveUnits(All,133,P8,12,7);
		GiveUnits(All,132,P8,13,8);
		GiveUnits(All,133,P8,13,8);
		GiveUnits(All,132,P8,14,9);
		GiveUnits(All,133,P8,14,9);
		GiveUnits(All,132,P8,15,10);
		GiveUnits(All,133,P8,15,10);
		GiveUnits(All,132,P7,15,11);
		GiveUnits(All,133,P7,15,11);
		RemoveUnit("Larva",Force2);
	}
	}



CMov(FP,0x6509B0,19025+25)
CWhile(FP,Memory(0x6509B0,AtMost,19025 + (84*1699)+25))

MoveCp("X",25*4)
function CUnit_PlacedUnitHP(Index,Amount)
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,Index,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,23*4);
		SetDeaths(CurrentPlayer,SetTo,Amount*256,0);
		MoveCp(Add,23*4);
		PreserveTrigger();
	}
}
end

CUnit_PlacedUnitHP(3,400000)
CUnit_PlacedUnitHP(23,500000)
CUnit_PlacedUnitHP(74,666666)
CUnit_PlacedUnitHP(29,200000)
CUnit_PlacedUnitHP(15,20211)
CUnit_PlacedUnitHP(77,20211)
CUnit_PlacedUnitHP(78,20211)
CUnit_PlacedUnitHP(21,20211)
CUnit_PlacedUnitHP(80,20211)
CUnit_PlacedUnitHP(52,50000)
CUnit_PlacedUnitHP(25,20211)
CUnit_PlacedUnitHP(27,100000)
CUnit_PlacedUnitHP(17,20211)
CUnit_PlacedUnitHP(76,20211)
CUnit_PlacedUnitHP(86,20211)
CUnit_PlacedUnitHP(98,100000)
CUnit_PlacedUnitHP(10,100000)
CUnit_PlacedUnitHP(32,300000)
CUnit_PlacedUnitHP(19,100000)
CUnit_PlacedUnitHP(65,100000)
CUnit_PlacedUnitHP(66,100000)
CUnit_PlacedUnitHP(28,20211)
CUnit_PlacedUnitHP(75,20211)
CUnit_PlacedUnitHP(68,999999)
CUnit_PlacedUnitHP(88,120000)
CUnit_PlacedUnitHP(219,666666)


CIfX(FP,TTOR({
DeathsX(CurrentPlayer,Exactly,216,0,0xFF),
DeathsX(CurrentPlayer,Exactly,190,0,0xFF),
DeathsX(CurrentPlayer,Exactly,147,0,0xFF),
DeathsX(CurrentPlayer,Exactly,156,0,0xFF),
DeathsX(CurrentPlayer,Exactly,109,0,0xFF),
DeathsX(CurrentPlayer,Exactly,148,0,0xFF),
DeathsX(CurrentPlayer,Exactly,173,0,0xFF),
DeathsX(CurrentPlayer,Exactly,201,0,0xFF),
DeathsX(CurrentPlayer,Exactly,175,0,0xFF),
DeathsX(CurrentPlayer,Exactly,152,0,0xFF),
DeathsX(CurrentPlayer,Exactly,151,0,0xFF),
}))
DoActions(FP,{
MoveCp(Add,0xDC-0x64),
SetDeathsX(CurrentPlayer,SetTo,0xB00,0,0xB00),
MoveCp(Subtract,0xDC-0x94),
SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000),
MoveCp(Add,0xE4-0x94),
SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFFFFFF),
MoveCp(Subtract,0xE4-0x64)})
CIfXEnd()



CIf(FP,{DeathsX(CurrentPlayer,Exactly,132,0,0xFF)})
DoActions(FP,MoveCp(Subtract,6*4))
for i=0, 11 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,i,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,i*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		SetCDeaths(FP,Add,1,CCode(0x1001,i));
		PreserveTrigger();
	}
	}
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

CIf(FP,{DeathsX(CurrentPlayer,Exactly,133,0,0xFF)})
DoActions(FP,MoveCp(Subtract,6*4))
for i=0, 11 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,i,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,i*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		SetCDeaths(FP,Add,1,CCode(0x1002,i));
		PreserveTrigger();
	}
	}
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()


CIf(FP,DeathsX(CurrentPlayer,Exactly,216,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,7,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,1*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		PreserveTrigger();
	}
	}
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

CIf(FP,DeathsX(CurrentPlayer,Exactly,152,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,7,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,1*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		PreserveTrigger();
	}
	}
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

DoActions(FP,MoveCp(Subtract,6*4))
DeathUnitJump = def_sIndex()
NJump(FP,DeathUnitJump,DeathsX(CurrentPlayer,AtMost,0,0,0xFF00))
DoActions(FP,MoveCp(Add,6*4))
OrCondForHeroArr = {}
for i = 1, #HeroIndexArr do
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,HeroIndexArr[i],0,0xFF))
end
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,162,0,0xFF))
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,176,0,0xFF))
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,177,0,0xFF))
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,178,0,0xFF))
CIf(FP,TTOR(OrCondForHeroArr))
DoActions(FP,{MoveCp(Subtract,16*4),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xff0000),MoveCp(Add,16*4)})
CIfEnd()
DoActions(FP,MoveCp(Subtract,6*4))
NJumpEnd(FP,DeathUnitJump)
DoActions(FP,MoveCp(Add,6*4))

CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)









DoActions(FP,{GiveUnits(All,132,AllPlayers,"Anywhere",6),GiveUnits(All,133,AllPlayers,"Anywhere",7)})
GiveTable ={}
for i = 0, 11 do
table.insert(GiveTable,GiveUnits(All,132,i,"Anywhere",6))
table.insert(GiveTable,GiveUnits(All,133,i,"Anywhere",7))
end
DoActions2(FP,GiveTable,1)
SetRecoverCp()
RecoverCp(FP)
CIfEnd() -- OnpluginStartEnd
CIf(AllPlayers,{Switch("Switch 201",Set)}) -- GameStart
DoActions2(FP,ButtonSetPatch2,1)
DoActionsX(FP,{SetCDeaths(FP,Add,1,WaveT)})
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
		SetCVar(FP,ExchangeRate[2],Add,-2);
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
}
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
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,193,2);
		Switch("Switch 10",Cleared);
		Switch("Switch 11",Cleared);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}

wav = "staredit\\wav\\zealot2.ogg"
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,193,2);
		Switch("Switch 10",Set);
		Switch("Switch 11",Cleared);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}

wav = "staredit\\wav\\zealot3.ogg"
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,193,2);
		Switch("Switch 10",Cleared);
		Switch("Switch 11",Set);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}

wav = "staredit\\wav\\zealot4.ogg"
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,193,2);
		Switch("Switch 10",Set);
		Switch("Switch 11",Set);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}
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
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,192,2);
		Switch("Switch 10",Cleared);
		Switch("Switch 11",Cleared);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}

wav = "sound\\Zerg\\BUGGUY\\ZBGPss01.wav"
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,192,2);
		Switch("Switch 10",Set);
		Switch("Switch 11",Cleared);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}

wav = "sound\\Zerg\\BUGGUY\\ZBGPss02.wav"
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,192,2);
		Switch("Switch 10",Cleared);
		Switch("Switch 11",Set);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}

wav = "sound\\Zerg\\BUGGUY\\ZBGPss03.wav"
Trigger {
	players = {FP},
	conditions = {
		Bring(AllPlayers,AtLeast,1,192,2);
		Switch("Switch 10",Set);
		Switch("Switch 11",Set);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,1);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,2);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,3);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,4);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,5);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV(wav);
		PlayWAV(wav);
		PlayWAV(wav);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
		},
	}
CIfEnd()

function BKillPoint(BossCon,BIndex,BPoint,BName)
local BClear = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※\n\n\n\x13\x04적의 \x08수호자 "..BName.." \x04가 쓰러졌습니다.\n\x13\x10+\x17 "..BPoint.." P t s \n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※"
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,Cell_R[2],Exactly,0);
		CDeaths(FP,AtLeast,2,GMode);
		BossCon;
		CommandLeastAt(BIndex,64);
	},
	actions = {
		SetScore(Force1,Add,BPoint,Kills);
		SetMemory(0x6509B0, SetTo, 0);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 1);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 2);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 3);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 4);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 5);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, FP);
		SetCDeaths(FP,Add,1,BossKill);

	},
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,Cell_R[2],Exactly,0);
		CDeaths(FP,AtLeast,2,GMode);
		CommandLeastAt(BIndex,64);
		BossCon
	},
	actions = {		
		SetMemory(0x6509B0, SetTo, 128);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 129);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 130);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, 131);
		DisplayText(BClear,4);
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		PlayWAV("staredit\\wav\\BossKill.ogg");
		SetMemory(0x6509B0, SetTo, FP);
	},
}
end


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
TriggerX(FP,{CGMode(1),DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^0)*(0x10000))},{SetCDeaths(FP,Add,1,BossKill)},{Preserved})
TriggerX(FP,{CGMode(1),DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^1)*(0x10000))},{SetCDeaths(FP,Add,1,BossKill)},{Preserved})
TriggerX(FP,{CGMode(1),DeathsX(FP,Exactly,(2^0)*0x10000,168,(2^2)*(0x10000))},{SetCDeaths(FP,Add,1,BossKill)},{Preserved})
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
NIf(FP,Command(FP,AtLeast,1,5))
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
},HumanPlayers,FP)},{Preserved})
Trigger2X(FP,{CDeaths(FP,Exactly,250,TBossT)},{CopyCpAction({
	TalkingPortrait(5, 6100),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV");
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV");
	DisplayTextX(TBossTxt2,4)
},HumanPlayers,FP)},{Preserved})
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

NIf(FP,Command(FP,AtLeast,1,11))
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
{TSetMemory(Boss1_H, Add, _Sub(_Mov(1500*256),_Mul(HiddenAtkM,_Mov(300*256))))},1)
CTrigger(FP,{
CDeaths(FP,Exactly,3,GMode),
TMemory(Boss1_H,AtMost,8000000*256)},
{TSetMemory(Boss1_H, Add, _Sub(_Mov(3500*256),_Mul(HiddenAtkM,_Mov(700*256))))},1)


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

f_Mod(FP,B1_X,_Rand(),640)
f_Mod(FP,B1_Y,_Rand(),576)
f_Mod(FP,B1_A,_Rand(),256)
CAdd(FP,B1_X,384)
CAdd(FP,B1_Y,224)
CreateBullet(204,20,B1_A,{B1_X,B1_Y})


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

for i=0, 5 do
	for j = 1, 5 do
TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+7,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+8,SetTo,0),
	SetMemoryB(0x58D088+(46*i)+9,SetTo,0)
})

TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+14,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+13,SetTo,0),
})

	end

TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,0),MemoryB(0x58D2B0+(46*i)+7,Exactly,255)},{
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


end




CMov(FP,TempUpgradeMaskRet,0)
CMov(FP,TempUpgradePtr,0)
CMov(FP,CurrentUpgrade,0)
CMov(FP,CurrentFactor,0)
CMov(FP,UpCount,0)
for i = 0, 5 do
CIf(FP,PlayerCheck(i,1))
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


--선택인식 피통 보임
SelEPD,SelHP,SelSh,SelMaxHP = CreateVars(4,FP)
SelUID = CreateVar(FP)
CIf(FP,{Memory(0x6284E8+(0x30*i) ,AtLeast,1),Memory(0x6284E8+(0x30*i) + 4,AtMost,0),Memory(0x57F1B0, Exactly, i)})
f_Read(FP,0x6284E8+(0x30*i),nil,SelEPD)
CDoActions(FP,{TSetMemory(SelOPEPD,Add,1)})
f_Read(FP,_Add(SelEPD,2),SelHP)
f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
CMov(FP,SelMaxHP,_Div(_ReadF(_Add(SelUID,_Mov(EPDF(0x662350)))),_Mov(256)))
f_Div(FP,SelHP,_Mov(256))
f_Div(FP,SelSh,_Mov(256))
CDoActions(FP,{TSetMemory(SelHPEPD,SetTo,SelHP),TSetMemory(MarHPEPD,SetTo,SelMaxHP),TSetMemory(SelShEPD,SetTo,SelSh)})
CIfEnd()
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
Trigger { -- 힐존트리거
players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,HealT);
	},
	actions = {
		SetCDeaths(FP,Add,50,HealT);
		ModifyUnitHitPoints(All,"Men",Force1,2,100);
		ModifyUnitShields(All,"Men",Force1,2,100);
		PreserveTrigger();
	},
}

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
Trigger { -- 공업완료시 스팀 활성화
	players = {i},
	conditions = {
		Label(0);
		CVar(FP,HiddenATK[2],AtLeast,1);
		MemoryB(0x58D2B0+(46*i)+7,AtLeast,255);
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
		CVar(FP,HiddenATK[2],AtLeast,1);
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
		CDeaths(FP,Exactly,1,MarMode);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x12\x04간단 조합법\n\x12\x1BH \x04Marine + \x1F"..GMCost.."원 \x04= \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\n\x12\x04방업할 시 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x08HP\x04와 \x1CShields \x0F증가\n\x12\x04환전 : \x03F12키\n\x12\x04닫기 : \x03Delete",4);
		PreserveTrigger();
	},
}
Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,MarMode);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x12\x04일반모드 조합법\n\x12\x1BH \x04Marine + \x1F"..GMCost.."원 \x04= \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\n\x12\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04*3 + \x1F"..NeCost.."원 \x04= \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04 \n\x12\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04*2 + \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04 +  SCV*3 + \x1F"..TeCost.."원 \x04= \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ\n\x12\x04???*255 + ???*255 + ???*12 + ???*10 + ??? + ??? + \x1F"..SUCost.."원 = \x04？？？？？？？？？\n\x12\x04\x11\x12\x04방업할 시 \x08HP\x04와 \x1CShields \x0F증가\n\x12\x04환전 : \x03F12키\n\x12\x04닫기 : \x03Delete",4);
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

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,TestMode);
		CDeaths(FP,AtLeast,1,GameOver);
	},
	actions = {
		CopyCpAction({Defeat()},Force1,FP)
	},
}
DoActionsX(FP,SetCDeaths(FP,Add,1,GameOver))
CIfEnd() -- 패배트리거 끝
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
		SetResources(j,Add,GMCost+MarCost,ore);
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
		SetResources(j,Subtract,10000,ore);
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
		SetResources(j,Subtract,GMCost,ore);
		RemoveUnitAt(1,20,3,j);
		CreateUnitWithProperties(1,"GaLaXy Marine",2,j,{energy = 100});
		SetDeaths(j,Add,1,125);
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x1BH \x04Marine을 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine으로 \x19변환\x04하였습니다. - \x1F"..GMCost.." O r e",4);
		SetDeaths(j,SetTo,1,101);
		PreserveTrigger();
	},
}

Trigger { -- 조합 네뷸라
	players = {j},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,MarMode);
		Command(j,AtMost,0,16);
		Bring(j,AtLeast,3,100,3);
		Accumulate(j,AtLeast,NeCost,Ore);
	},
	actions = {
		ModifyUnitEnergy(3,100,j,3,0);
		SetResources(j,Subtract,NeCost,ore);
		RemoveUnitAt(3,100,3,j);
		CreateUnitWithProperties(1,16,2,j,{energy = 100});
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine 을 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ 으로 \x19변환\x04하였습니다. - \x1F"..NeCost.." O r e\n",4);
		SetDeaths(j,SetTo,1,101);
		PreserveTrigger();
	},
}


Trigger { -- 조합 테라
	players = {j},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,MarMode);
		Command(j,AtMost,0,0);
		Bring(j,AtLeast,1,16,3);
		Bring(j,Exactly,2,100,3);
		Bring(j,Exactly,3,"Terran SCV",3);
		Accumulate(j,AtLeast,TeCost,Ore);
	},
	actions = {
		ModifyUnitEnergy(2,100,j,3,0);
		ModifyUnitEnergy(1,16,j,3,0);
		SetResources(j,Subtract,TeCost,ore);
		RemoveUnitAt(1,16,3,j);
		RemoveUnitAt(2,100,3,j);
		RemoveUnitAt(3,"Terran SCV",3,j);
		CreateUnitWithProperties(1,0,2,j,{energy = 100});
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04, \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04, SCV 를 \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ 으로 \x19변환\x04하였습니다. - \x1F"..TeCost.." O r e\n",4);
		SetDeaths(j,SetTo,1,101);
		PreserveTrigger();
	},
}

Trigger { -- 조합 핵배틀
	players = {j},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,MarMode);
		MemoryB(0x58D2B0+(j*46)+7,AtLeast,255);
		MemoryB(0x58D2B0+(j*46),AtLeast,255);
		Bring(j,Exactly,12,100,3);
		Bring(j,Exactly,10,"Terran SCV",3);
		Bring(j,Exactly,1,16,3);
		Bring(j,Exactly,1,0,3);
		Bring(j,AtMost,0,12,64);
		Accumulate(j,AtLeast,SuCost,Ore);
	},
	actions = {
		ModifyUnitEnergy(12,100,j,3,0);
		ModifyUnitEnergy(1,16,j,3,0);
		ModifyUnitEnergy(1,0,j,3,0);
		SetResources(j,Subtract,SuCost,ore);
		RemoveUnitAt(12,100,3,j);
		RemoveUnitAt(1,16,3,j);
		RemoveUnitAt(1,0,3,j);
		RemoveUnitAt(10,"Terran SCV",3,j);
		CreateUnitWithProperties(1,12,2,j,{energy = 100});
		DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x04, SCV를 \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ 로 \x19변환\x04하였습니다. - \x1F"..SuCost.." O r e\n",4); -- \x02▶ \x04모든 옵션 적용으로 \x11얼마든지 \x04보유 가능"
		SetMemoryB(0x58D088+(46*j)+14,SetTo,255);
		SetMemoryB(0x58D088+(46*j)+13,SetTo,255);
		PreserveTrigger();
	},
}

CIfX(FP,Bring(j,AtLeast,1,12,64))
DoActions(FP,{MoveLocation("P"..j+1,12,j,64)})
CIf(FP,{Bring(Force2,AtLeast,1,"Any unit","P"..j+1),CDeaths(FP,AtMost,0,BSkillT[j+1])})
GetLocCenter("P"..j+1,Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn({},{1},"ACAS","BattleShape","MAX",4,nil,nil,j)
CIfEnd()
TriggerX(FP,{CDeaths(FP,AtMost,0,BSkillT[j+1])},{SetCDeaths(FP,SetTo,10,BSkillT[j+1]),RemoveUnit(1,j)},{Preserved})
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,BSkillT[j+1]),SetCVar(FP,Var_TempTable[2][2],SetTo,0),SetCVar(FP,Var_TempTable[3][2],SetTo,0)})
CElseX({RemoveUnit(1,j)})
CIfXEnd()


CIfX(FP,Bring(j,AtLeast,1,16,64))
DoActions(FP,{MoveLocation("S"..j+1,16,j,64)})
CIf(FP,{Bring(Force2,AtLeast,1,"Any unit","S"..j+1),CDeaths(FP,AtMost,0,BSkillT2[j+1])})
GetLocCenter("S"..j+1,Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn({},{182},P_6,0,"MAX",5,nil,nil,j)
CIfEnd()
TriggerX(FP,{CDeaths(FP,AtMost,0,BSkillT2[j+1])},{SetCDeaths(FP,SetTo,10,BSkillT2[j+1]),RemoveUnit(182,j)},{Preserved})
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,BSkillT2[j+1]),SetCVar(FP,Var_TempTable[2][2],SetTo,0),SetCVar(FP,Var_TempTable[3][2],SetTo,0)})
CElseX({RemoveUnit(182,j)})
CIfXEnd()

CIfX(FP,Bring(j,AtLeast,1,0,64))
DoActions(FP,{MoveLocation("G"..j+1,0,j,64)})
CIf(FP,{Bring(Force2,AtLeast,1,"Any unit","G"..j+1),CDeaths(FP,AtMost,0,BSkillT3[j+1])})
GetLocCenter("G"..j+1,Var_TempTable[2],Var_TempTable[3])
G_CA_SetSpawn({},{183},S_4,0,"MAX",6,nil,nil,j)
CIfEnd()
TriggerX(FP,{CDeaths(FP,AtMost,0,BSkillT3[j+1])},{SetCDeaths(FP,SetTo,10,BSkillT3[j+1]),RemoveUnit(183,j)},{Preserved})
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,BSkillT3[j+1]),SetCVar(FP,Var_TempTable[2][2],SetTo,0),SetCVar(FP,Var_TempTable[3][2],SetTo,0)})
CElseX({RemoveUnit(183,j)})
CIfXEnd()

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
		CommandLeastAt(174,64);
	},
	actions = {
		SetCDeaths(FP,Add,1,Win);
	}
}
function InvDisable(Cond,UnitID,Player,Loc,Name)
txt = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※\n\n\n\x13\x03"..Name.."\x04의 \x08무적상태\x04가 해제되었습니다.\n\n\n\x13\x07※※※※※※※※※※※※\x1F ＮＯＴＩＣＥ\x07 ※※※※※※※※※※※※"
Wav = "staredit\\wav\\Unlock.ogg"
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Cond;
	},
	actions = {
		MoveLocation(1,UnitID,Player,Loc);
		SetInvincibility(Disable,UnitID,Player,Loc);
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 128);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 129);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 130);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, 131);
		PlayWAV(Wav);
		PlayWAV(Wav);
		MinimapPing(1);
		DisplayText(txt,4);
		SetMemory(0x6509B0, SetTo, FP);
	}
}
end
InvDisable({CDeaths(FP,AtLeast,2,GMode),CDeaths(FP,AtLeast,15,Chry_cond)},201,Force2,64,"Ｏｖｅｒｍｉｎｄ　Ｃｏｃｏｏｎ")
InvDisable({CDeaths(FP,AtMost,0,CCode(0x1001,0)),CDeaths(FP,AtMost,0,CCode(0x1001,1)),CDeaths(FP,AtMost,0,CCode(0x1002,0)),CDeaths(FP,AtMost,0,CCode(0x1002,1))},148,Force2,6,"ＯｖｅｒＭｉｎｄ")
InvDisable({CDeaths(FP,AtLeast,4,B_Chry_cond)},147,Force2,31,"Ｍｏｎｓｔｅｒ　Ｋｒａｋｅｎ")
InvDisable({CDeaths(FP,AtMost,0,CCode(0x1001,2)),CDeaths(FP,AtMost,0,CCode(0x1002,2))},175,Force2,37,"Ｘｅｌ＇Ｎａｇａ　Ｔｅｍｐｌｅ")
InvDisable({CDeaths(FP,AtMost,0,CCode(0x1001,3)),CDeaths(FP,AtMost,0,CCode(0x1002,3))},175,Force2,38,"Ｘｅｌ＇Ｎａｇａ　Ｔｅｍｐｌｅ")
InvDisable({CDeaths(FP,AtMost,0,CCode(0x1001,4)),CDeaths(FP,AtMost,0,CCode(0x1002,4))},175,Force2,39,"Ｘｅｌ＇Ｎａｇａ　Ｔｅｍｐｌｅ")
InvDisable({CDeaths(FP,AtLeast,2,GMode),CDeaths(FP,AtMost,0,CCode(0x1001,5)),CDeaths(FP,AtMost,0,CCode(0x1002,5))},190,Force2,40,"Ｃｏｒｅ　ｏｆ　ＧａＬａＸｙ")
InvDisable({CDeaths(FP,AtLeast,5,Sup_Cond)},173,Force2,41,"Ｆｏｒｍａｔｉｏｎ")
InvDisable({CDeaths(FP,AtLeast,5,Py_Cond)},173,Force2,42,"Ｆｏｒｍａｔｉｏｎ")
InvDisable({CDeaths(FP,AtLeast,1,OverCocooncomp),CDeaths(FP,AtLeast,2,BossKill)},168,Force2,36,"Ｓｔａｓｉｓ　Ｃｅｌｌ")
InvDisable({
CDeaths(FP,AtMost,0,CCode(0x1001,6)),
CDeaths(FP,AtMost,0,CCode(0x1001,7)),
CDeaths(FP,AtMost,0,CCode(0x1001,8)),
CDeaths(FP,AtMost,0,CCode(0x1001,9)),
CDeaths(FP,AtMost,0,CCode(0x1002,6)),
CDeaths(FP,AtMost,0,CCode(0x1002,7)),
CDeaths(FP,AtMost,0,CCode(0x1002,8)),
CDeaths(FP,AtMost,0,CCode(0x1002,9))},152,Force2,43,"Ｄａｇｇｏｔｈ")
InvDisable({
CDeaths(FP,AtMost,0,CCode(0x1001,10)),
CDeaths(FP,AtMost,0,CCode(0x1001,11)),
CDeaths(FP,AtMost,0,CCode(0x1002,10)),
CDeaths(FP,AtMost,0,CCode(0x1002,11))},152,Force2,44,"Ｄａｇｇｏｔｈ")
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
		SetResources(Force1,Add,80000,Ore);
		CreateUnit(6,20,2,Force1);
	},
}
--수정트리거
TriggerX(FP,{Bring(P12,AtMost,0,219,64)},{
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


CIf(FP,CDeaths(FP,AtMost,6,HiddenMode))
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




CIf(FP,CDeaths(FP,AtLeast,7,HiddenMode))
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
		CDeaths(FP,AtMost,6,HiddenMode);
		CDeaths(FP,AtLeast,499,Win);
		},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii",4);
		SetMemory(0x6509B0, SetTo, 1);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii",4);
		SetMemory(0x6509B0, SetTo, 2);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii",4);
		SetMemory(0x6509B0, SetTo, 3);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii",4);
		SetMemory(0x6509B0, SetTo, 4);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii",4);
		SetMemory(0x6509B0, SetTo, 5);
		PlayWAV("staredit\\wav\\button3.wav");
		DisplayText("\x13\x18히든 \x04커맨드는? : \x17Mininii",4);
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

Trigger { -- 가스통깨면 가스추가
	players = {FP},
	conditions = {
		Label(0);
		Deaths(P12,AtLeast,1,188);
	},
	actions = {
		SetCVar(FP,CanC[2],Add,1);
		SetDeaths(P12,Subtract,1,188);
		PreserveTrigger();
		},
	}


CMov(FP,MarUpData,0)

for i=0, 5 do
	CIf(FP,Deaths(i,Exactly,1,217))
		CIfX(FP,PlayerCheck(i,1))
			CAdd(FP,MarUpData,_Div(_ReadF(DefUpgradePtrArr[i+1],_Mov(255*(256^DefUpgradeMaskRetArr[i+1]))),256^DefUpgradeMaskRetArr[i+1]))
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
TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{Preserved})
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
		PlayerCheck(j,1);
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
		PlayerCheck(j,1);
		CDeaths(FP,Exactly,i,GiveRate[k+1]);
		Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
		Accumulate(k,AtMost,0x7FFFFFFF,Ore);
	},
	actions = {
		SetResources(k,Subtract,GiveRate2[i+1],Ore);
		SetResources(j,Add,GiveRate2[i+1],Ore);
		--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
		
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
		DisplayText("\x07『 "..Player[j+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부하였습니다. \x07』",4);
		SetMemory(0x6509B0,SetTo,j);
		DisplayText("\x12\x07『"..Player[k+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부받았습니다.\x02 \x07』",4);
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
		PlayerCheck(j,0);
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
CIf(FP,{PlayerCheck(i,1)})
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
CifEnd()
for i=0, 5 do
NJump(FP,0x500+i,Deaths(i,Exactly,0,111))
CIf(FP,Score(i,Kills,AtLeast,1000))
CAdd(FP,0x57F0F0+(i*4),_Mul(_DIv(_ReadF(0x581F04+(i*4)),_Mov(1000)),{FP,ExchangeRate[2],nil,"V"}))
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

TriggerX(FP,{CDeaths(FP,AtLeast,#LV_10_UnitTable,LV_10_UnitTableCode)},{SetCDeaths(FP,SetTo,0,LV_10_UnitTableCode)},{Preserved})
TriggerX(FP,{CDeaths(FP,AtLeast,#LV_11_UnitTable,LV_11_UnitTableCode)},{SetCDeaths(FP,SetTo,0,LV_11_UnitTableCode)},{Preserved})


CIfEnd()-- GameStart End
--]]
BGMArr = 
{{"staredit\\wav\\Opening1.ogg",32 * 1000 },
{"staredit\\wav\\bgm1short.ogg",32 * 1000},
{"staredit\\wav\\bgm2short.ogg",47 * 1000},
{"staredit\\wav\\bgm1long.ogg",61 * 1000 },
{"staredit\\wav\\bgm2long.ogg",61 * 1000},
{"staredit\\wav\\bgm1_3.ogg",83640},
{"staredit\\wav\\bgm_sp1.ogg",182 * 1000},
{"staredit\\wav\\bgm_sp2.ogg",57 * 1000},}



CIf(FP,CDeaths(FP,AtLeast,1,BGMType))
CIfX(FP,{Deaths(FP,AtMost,0,440)})
function BGMOb(Index,BGMFile,Value)
Trigger { -- 브금재생 j번 - 관전자
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,Index,BGMType);
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
		PlayWAV(BGMFile);
		PlayWAV(BGMFile);
		SetMemory(0x6509B0,SetTo,FP);
		SetDeathsX(FP,SetTo,Value,440,0xFFFFFF);
		PreserveTrigger();
	},
	}
end
for j, k in pairs(BGMArr) do
BGMOb(j,k[1],k[2])
end

CElseX()
Trigger { -- 브금재생시 스킵 관전자
	players = {FP},
	conditions = {
	},
		actions = {
		SetMemory(0x6509B0,SetTo,128);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0,SetTo,129);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0,SetTo,130);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0,SetTo,131);
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
	},
	}
CIfXEnd()
CMov(FP,0x6509B0,0)
CWhile(FP,Memory(0x6509B0,AtMost,5))
CIf(FP,Bring(CurrentPlayer,AtLeast,1,111,64))
CIfX(FP,{Deaths(CurrentPlayer,AtMost,0,440)})
function BGMPlayer(Index,BGMFile,Value)
Trigger { -- 브금재생 j번
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,Index,BGMType);
	},
		actions = {
		PlayWAV(BGMFile);
		PlayWAV(BGMFile);
		SetDeathsX(CurrentPlayer,SetTo,Value,440,0xFFFFFF);
		PreserveTrigger();
	},
	}
end

for j, k in pairs(BGMArr) do
	BGMPlayer(j,k[1],k[2])
end
CElseX()
Trigger { -- 브금재생시 스킵
	players = {FP},
		actions = {
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PreserveTrigger();
	},
	}
CIfXEnd()
CIfEnd()
CAdd(FP,0x6509B0,1)
CWhileEnd()
DoActionsX(FP,{SetCDeaths(FP,SetTo,0,BGMType),SetMemory(0x6509B0,SetTo,FP)})
CIfEnd()
--]]
DoActions(FP,{KillUnit(84,Force2),KillUnit(72,Force2),KillUnit(22,Force2),KillUnit(9,Force2),SetMemoryX(0x666458, SetTo, 546,0xFFFF),RemoveUnit(33,Force2)})
EndCtrig()
ErrorCheck()
EUDTurbo(FP)
SetCallErrorCheck()
Enable_HideErrorMessage(FP)