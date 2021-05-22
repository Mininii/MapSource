dofile("lua/Loader.lua")
dofile("Map4Source/LibraryFor322.lua")

EUDTurbo(P8) -- 뎡터보
Limit = 1
TestStart = 1
FP = P8

RepUnitPtr = VoidAlloc(1700*2)
CustomShapePtr = VoidAlloc(100)
CustomShapePtr2 = VoidAlloc(135)
CustomShapePtr3 = VoidAlloc(132)
-- 0x58f500 SelHP 0x58f504 MarHP 0x58f508 SelSh

function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end


--------------게임 설정 단락

JYD = "Set Unit Order To: Junk Yard Dog" 
VerText = "\x04Ver. Test"
_0D = string.rep("\x0D",200) 
MarID = {0,1,16,20,32,99,100}  
MarWep = {117,118,119,120,121,122,123} 
GiveRate2 = {1000, 5000, 10000, 50000,100000,500000}  
XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0"}
SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4} 
GiveP = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 
AtkFactor = 4
DefFactor = 2 
MarDamageFactor = 1 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
MarDamageAmount = 30 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
NMarDamageFactor = 1
NMarDamageAmount = 20
HumanPlayers = {0,1,2,3,4,5,6,128,129,130,131}
MapPlayers = {0,1,2,3,4,5,6}
MedicTrig = {34,9,2,3}
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P8)
StartCtrig()
SpeedVar = CreateVar(4)
Ex1= {15,17,19,21,23,25,27}
P = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인","\x156인","\x167인"}
--맵 설정 단락 끝

CreateTableSet({
"MarHP","MarHP2","AtkUpgradePtrArr","AtkUpgradeMaskRetArr","DefUpgradePtrArr","DefUpgradeMaskRetArr","AtkFactorV","DefFactorV","NormalUpgradeMaskRetArr","NormalUpgradePtrArr",
"BanToken","DefUpCompCount","AtkUpCompCount","DefFactorMaskRetArr","DefFactorPtrArr","AtkFactorMaskRetArr","AtkFactorPtrArr","AtkFactorV2","DefFactorV2","CurrentHP","MarMaxHP",
"BarrackPtr","EXCunitTemp","EXCunit_Reset","MarCreate","CV1","CV2","BarPos","ExScore","ExScoreP","MarCreate2","TextSwitch"
})

CreateVariableSet({"RepHeroIndex","RepX","RepY","BackupCp","CPos","CPosX","CPosY","BacpupPtr","CurrentUID","SelPTR","SelEPD","MarTblPtr","SelHP",
"SelHPEPD","MarHPEPD","SelSh","SelShEPD","SelPl","SelMaxHP","CunitP","SelOPEPD","CurCunitI","CurrentSpeed","Dx","Dy","Dt","Dv","Du","DtP","CurrentOP",
"UpgradeCP","UpgradeFactor","TempUpgradePtr","TempUpgradeMaskRet","UpgradeMax","UpResearched","UpCost","UpCompleted","UPCompStrPtr","Nextptrs","CunitIndex",
"CustomShape1Size","CustomShape2Size","CustomShape3Size","BarRally","G_Send","G_CA","G_TempV","GunID","Gun_X","Gun_Y","Gun_LV","G_TempW","BackupPosData","Gun_TempRand","Gun_TempSpawnSet1","Spawn_TempW",
"TempT","count","ReserveBGM","Repeat_TempV","TempBarPos","ExchangeRate","SetPlayers","ExchangeP","RandW","HPosX","HPosY","KillScore","Gun_Type","f_GunNum","f_GunStrPtr","ReserveBGM2",
"Gun_TempSpawnSet2","Gun_TempSpawnSet3"
})


ExDeaths1 = DefineDeathTable(0x1000)
BGMTypeV = CreateVar(1)
for i = 0, 6 do
	table.insert(MarHP,CreateVar()) -- 체력기본값 1000
	table.insert(MarHP2,CreateVar()) -- 동기화용 Temp
	table.insert(AtkFactorV,CreateVar(AtkFactor))
	table.insert(DefFactorV,CreateVar(DefFactor))
	table.insert(AtkFactorV2,CreateVar())
	table.insert(DefFactorV2,CreateVar())
	table.insert(BanToken,CreateCCode(ExDeaths1))
	table.insert(DefUpCompCount,CreateVar())
	table.insert(AtkUpCompCount,CreateVar())
	table.insert(CurrentHP,CreateVar())
	table.insert(BarrackPtr,CreateVar())
	table.insert(BarPos,CreateVar())
	table.insert(ExScore,CreateVar())
	table.insert(ExScoreP,CreateVar())
	table.insert(MarMaxHP,CreateVar(2000*256))
	table.insert(MarCreate,CreateCCode(ExDeaths1))
	table.insert(MarCreate2,CreateCCode(ExDeaths1))
end

for i = 0, 9 do
	table.insert(EXCunitTemp,CreateVar())
	table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,SetTo,0))
end


for i = 0, 4 do
	table.insert(TextSwitch,CreateCCode(ExDeaths1))
end
CreateCCodeSet(ExDeaths1,{"GiveConsole","F12KeyToggle","IntroT","LimitX","LimitC","TestMode","DelayMedic","Print13",
"GiveRate","FuncT","OPFuncT","PCheck","HealT","RandomHeroPlace","ReplaceDelayT",})



Enable_PlayerCheck()
Enable_HideErrorMessage(FP)
DoActionsX(FP,SetCDeaths(FP,SetTo,0,PCheck))
for i = 0, 6 do
TriggerX(FP,{PlayerCheck(i,1)},{SetCDeaths(FP,Add,1,PCheck)},{Preserved})
end
CJump(AllPlayers,0x700) -- SetCall 지정공간
Str12 = CreateCText(FP,"\x12\x07『 \x0d\x0d\x0d\x0d\x0d\x0d\x0d")
Str22 = CreateCText(FP,"\x04 미네랄을 소비하여 총 \x0d\x0d\x0d\x0d\x0d\x0d")
Str23 = CreateCText(FP,"\x04 \x04회 업그레이드를 완료하였습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d")
f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE System Message \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
Str24 = CreateCText(FP,"\x07』\x0d\x0d\x0d\x0d\x0d\x0d")



Include_CtrigPlib(360,"Switch 100",1)
UpCompTxt = CVArray(FP,5)
UpCompRet = CVArray(FP,5)
f_GunNumT = CVArray(FP,5)
SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()
LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
SetCallEnd()


OneClickUpgrade = SetCallForward()
SetCall(FP) 
	f_Read(FP,TempUpgradePtr,UpResearched)
	CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
		CMod(FP,UpResearched,_Mul(TempUpgradeMaskRet,_Mov(256)))
	CIfEnd()
	CDiv(FP,UpResearched,TempUpgradeMaskRet)
	CMov(FP,0x6509B0,UpgradeCP)
	CJumpEnd(FP,UpResearched[2])
	NWhile(FP,{
		CVar(FP,UpResearched[2],AtMost,254),
		CVar(FP,UpgradeMax[2],AtLeast,1),
		TAccumulate(CurrentPlayer,AtLeast,_Mul(UpResearched,UpgradeFactor),Ore),
		TMemoryX(TempUpgradePtr,AtMost,_Mul(TempUpgradeMaskRet,254),_Mul(TempUpgradeMaskRet,255))
	})
		CDoActions(FP,{
			TSetCVar(FP,UpCost[2],Add,_Mul(UpResearched,UpgradeFactor)),
			TSetResources(CurrentPlayer,Subtract,_Mul(UpResearched,UpgradeFactor),Ore),
			SetCVar(FP,UpResearched[2],Add,1),
			SetCVar(FP,UpCompleted[2],Add,1),
			SetCVar(FP,UpgradeMax[2],Subtract,1),
			--TSetCVar(FP,UpCost[2],Add,_Mul(UpResearched,UpgradeFactor)),
			TSetMemoryX(TempUpgradePtr,Add,_Mul(TempUpgradeMaskRet,_Mov(1)),_Mul(TempUpgradeMaskRet,_Mov(255)))
		})
		CJump(FP,UpResearched[2])
	NWhileEnd()
	NJump(FP,0x24,CVar(FP,UpCompleted[2],Exactly,0),{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	ItoDec(FP,UpCost,VArr(UpCompTxt,0),2,0x1F,0)
	ItoDec(FP,UpCompleted,VArr(UpCompRet,0),2,0x19,0)
	_0DPatchforVArr(FP,UpCompRet,4)
	_0DPatchforVArr(FP,UpCompTxt,4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]),VArr(UpCompTxt,0),5*4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3),VArr(UpCompRet,0),5*4)
	CDoActions(FP,{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x0D\x0D\x0DUPC".._0D,4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	NJumpEnd(FP,0x24)
	DoActionsX(FP,{
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,0),
		SetCVar(FP,TempUpgradePtr[2],SetTo,0),
		SetCVar(FP,UpResearched[2],SetTo,0),
		SetCVar(FP,UpCost[2],SetTo,0),
		SetCVar(FP,UpCompleted[2],SetTo,0)
	})
SetCallEnd()

G_TempH = CreateVar()
G_InputH = CreateVar({"X",0x500,0x15C,1,0})
Var_TempTable = {}
Var_InputCVar = {}
Var_Lines = 30
for i = 1, Var_Lines do
	table.insert(Var_TempTable,CreateVar())
	table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
end


Call_Repeat = SetCallForward()
SetCall(FP)
CWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Spawn_TempW[2],AtLeast,1)})
	CJumpXEnd(FP,0x501)
	f_Mod(FP,Gun_TempRand,_Rand(),_Mov(7))
	for i = 0, 6 do
		NIf(FP,{CVar(FP,Gun_TempRand[2],Exactly,i),PlayerCheck(i,0)})
			CJumpX(FP,0x501)
		NIfEnd()
	end
	CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
	for i = 0, 6 do
		CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)})
			CMov(FP,TempBarPos,BarPos[i+1])
		CIfEnd()
	end
	CIfEnd()
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CDoActions(FP,{
		TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,P8,{energy = 100}),
--		TModifyUnitEnergy(All,Gun_TempSpawnSet1,P8,1,100);
	})
	CIf(FP,{TMemory(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
	CDoActions(FP,{
		TSetDeathsX(_Add(Nextptrs,19),SetTo,152*256,0,0xFF00),
		TSetDeaths(_Add(Nextptrs,22),SetTo,TempBarPos,0),
	})
	CIfEnd()
	CSub(FP,Spawn_TempW,1)
CWhileEnd()
SetCallEnd()

function f_Repeat(Line)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{SetCVar(FP,Var_TempTable[Line][2],SetTo,0)},{Preserved})
CIf(FP,CVar(FP,Var_TempTable[Line][2],AtLeast,1))
	CMov(FP,Spawn_TempW,Var_TempTable[Line])
	CallTrigger(FP,Call_Repeat)
	CDoActions(FP,{TSetMemory(_Add(G_TempH,((Line-1)*0x20)/4),SetTo,Spawn_TempW)})
CIfEnd()
end
function f_TempRepeat(UnitID,Number,Condition)
CallTriggerX(FP,Set_Repeat,Condition,{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),SetCVar(FP,Repeat_TempV[2],SetTo,Number)})
end


Set_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{SetCVar(FP,Repeat_TempV[2],SetTo,0)},{Preserved})
CIf(FP,CVar(FP,Repeat_TempV[2],AtLeast,1))
	CMov(FP,Spawn_TempW,Repeat_TempV)
	CMov(FP,Repeat_TempV,0)
	CallTrigger(FP,Call_Repeat)
	CMov(FP,Spawn_TempW,0)
CIfEnd()
SetCallEnd()

Load_CSArr = SetCallForward()
SetCall(FP)
	CWhile(FP,CVar(FP,G_TempW[2],AtLeast,1),SetCVar(FP,G_TempW[2],Subtract,1))
		f_SaveCp()
		f_Read(FP,BackupCp,CPos)
		CMov(FP,CPosX,CPos,0,0XFFFF)
		CMov(FP,CPosY,CPos,0,0XFFFF0000)
		f_Div(FP,CPosY,_Mov(0x10000))
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY) -- 좌상
		CMov(FP,Repeat_TempV,1)
		CMov(FP,Gun_TempSpawnSet1,Gun_TempSpawnSet3)
		CallTriggerX(FP,Set_Repeat)
		CMov(FP,Gun_TempSpawnSet1,Gun_TempSpawnSet2)
		CMov(FP,Repeat_TempV,1)
		CallTriggerX(FP,Set_Repeat)
		f_LoadCp()
		CAdd(FP,0x6509B0,1)
	CWhileEnd()
SetCallEnd()
--[[
Line No.1 : UnitID(Gun)
Line No.2 : Pos.X
Line No.3 : Pos.Y
Line No.4 : Gun_LV
Line No.5 : T
Line No.6 : C
Line No.args : UnitSpawnSet
...
...

Line No.29 : GunType
Line No.30 : SuspendSwitch
]]
function f_CSData(CSPtr,UnitID,UnitID2,CSNumV,Condition)
	if UnitID2 == nil then
		UnitID2 = 0
	end
	CTrigger(FP,{Condition},{
		SetMemory(0x6509B0,SetTo,CSPtr),
		TSetCVar(FP,G_TempW[2],SetTo,CSNumV),
		SetCVar(FP,Gun_TempSpawnSet3[2],SetTo,UnitID),
		SetCVar(FP,Gun_TempSpawnSet2[2],SetTo,UnitID2),
	},1)
end

f_Gun = SetCallForward()
SetCall(FP)

CIf(FP,{CVar(FP,Var_TempTable[29][2],AtMost,255)}) -- 레어나 하이브 등의 건작일 경우

	CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,133))--하이브
		CIf(FP,{CVar(FP,Var_TempTable[6][2],Exactly,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
			CMov(FP,ReserveBGM,4)
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
			CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,1))
				f_CSData(CustomShapePtr,48,55,CustomShape1Size,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_CSData(CustomShapePtr,104,56,CustomShape1Size,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_CSData(CustomShapePtr,51,56,CustomShape1Size,CVar(FP,Var_TempTable[6][2],Exactly,2))
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CallTriggerX(FP,Load_CSArr)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,2))
				f_CSData(CustomShapePtr2,55,nil,CustomShape2Size,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_CSData(CustomShapePtr2,56,nil,CustomShape2Size,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_CSData(CustomShapePtr2,56,nil,CustomShape2Size,CVar(FP,Var_TempTable[6][2],Exactly,2))
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CallTriggerX(FP,Load_CSArr)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,3))
				f_CSData(CustomShapePtr3,54,53,CustomShape3Size,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_CSData(CustomShapePtr3,55,53,CustomShape3Size,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_CSData(CustomShapePtr3,56,48,CustomShape3Size,CVar(FP,Var_TempTable[6][2],Exactly,2))
				CallTriggerX(FP,Load_CSArr)

				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
			CIfEnd()
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
		CIfEnd()
	CIfEnd()

	CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,132))--레어
		CIf(FP,{CVar(FP,Var_TempTable[6][2],Exactly,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
			CMov(FP,ReserveBGM,3)
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
			f_TempRepeat(55,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(56,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(53,15)
			f_TempRepeat(48,10)
			f_TempRepeat(54,20)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
			f_TempRepeat(55,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(56,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(53,15)
			f_TempRepeat(48,10)
			f_TempRepeat(54,20)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
			f_TempRepeat(55,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(56,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(53,15)
			f_TempRepeat(48,10)
			f_TempRepeat(54,20)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
			f_TempRepeat(55,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(56,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(53,15)
			f_TempRepeat(48,10)
			f_TempRepeat(54,20)
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
		CIfEnd()

		CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
	CIfEnd()

	CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,131))--해처리
		CIf(FP,{CVar(FP,Var_TempTable[6][2],Exactly,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
			CMov(FP,ReserveBGM,2)
		CIfEnd()

		CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
			f_TempRepeat(43,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(44,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(38,15)
			f_TempRepeat(39,10)
			f_TempRepeat(37,20)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
			f_TempRepeat(43,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(44,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(38,15)
			f_TempRepeat(39,10)
			f_TempRepeat(37,20)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
			f_TempRepeat(43,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(44,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(38,15)
			f_TempRepeat(39,10)
			f_TempRepeat(37,20)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
			f_TempRepeat(43,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
			f_TempRepeat(44,25,CVar(FP,Var_TempTable[6][2],Exactly,1))
			f_TempRepeat(38,15)
			f_TempRepeat(39,10)
			f_TempRepeat(37,20)
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
		CIfEnd()


		CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
	CIfEnd()
CIfEnd()

CIf(FP,{CVar(FP,Var_TempTable[29][2],AtLeast,256)}) -- 잡건작일 경우
Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*7,-32*7,32*7,32*7)})

	CIf(FP,{CVar(FP,Var_TempTable[6][2],Exactly,0)})
		CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,2500)})
	CIfEnd()
	CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,2500))
		CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
		CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
		CDoActions(FP,{TSetMemory(_Add(G_TempH,(6*0x20)/4),Add,20)})
		CDoActions(FP,{TSetMemory(_Add(G_TempH,(7*0x20)/4),Add,15)})
		CDoActions(FP,{TSetMemory(_Add(G_TempH,(8*0x20)/4),Add,10)})
		CDoActions(FP,{TSetMemory(_Add(G_TempH,(9*0x20)/4),Add,5)})
	CIfEnd()
	
	
	
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,137)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,142)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,135)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,140)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,48)},{Preserved})
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,141)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,55)},{Preserved})
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,51)},{Preserved})
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
	f_Repeat(7)
	
	
	CMov(FP,Gun_TempSpawnSet1,0)
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,104)},{Preserved})
	f_Repeat(8)
	
	CMov(FP,Gun_TempSpawnSet1,0)
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
	f_Repeat(9)
	CMov(FP,Gun_TempSpawnSet1,0)
	TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,45)},{Preserved})
	f_Repeat(10)
	
	
	CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,7)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
CIfEnd()

CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,Dt)})
CIf(FP,{CVar(FP,Var_TempTable[30][2],AtLeast,1)})
CMov(FP,G_TempW,0)
CWhile(FP,CVar(FP,G_TempW[2],AtMost,(Var_Lines-1)*(0x20/4)))
	CDoActions(FP,{TSetMemory(_Add(G_TempH,G_TempW),SetTo,0)})
	CAdd(FP,G_TempW,0x20/4)
CWhileEnd()
if Limit == 1 then
ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
f_Movcpy(FP,_Add(f_GunStrPtr,f_GunT[2]),VArr(f_GunNumT,0),5*4)
DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
end
CIfEnd()
SetCallEnd()

G_Send = SetCallForward()
SetCall(FP)
	f_SaveCp()
	CMov(FP,BackupPosData,BackupCp,-15)
	f_Read(FP,BackupCp,GunID,"X",0xFF)
	
	CMov(FP,G_CA,0)
	CJumpEnd(FP,0x619)
	CAdd(FP,G_TempV,_Mul(G_CA,_Mov(0x970/4)),G_InputH)
	NIf(FP,{TMemory(G_TempV,AtLeast,1),CVar(FP,G_CA[2],AtMost,63)},{SetCVar(FP,G_CA[2],Add,1)})
		CJump(FP,0x619)
	NIfEnd()

	CIfX(FP,{CVar(FP,G_CA[2],AtMost,63)})
	CDoActions(FP,{
		TSetMemory(G_TempV,SetTo,GunID),
		TSetMemory(_Add(G_TempV,1*(0x20/4)),SetTo,_ReadF(BackupPosData,0xFFFF)),
		TSetMemory(_Add(G_TempV,2*(0x20/4)),SetTo,_Div(_ReadF(BackupPosData,0xFFFF0000),_Mov(65536))),
		TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,EXCunitTemp[1]),
		TSetMemory(_Add(G_TempV,28*(0x20/4)),SetTo,Gun_Type),
	})
	CElseX()
	DoActions(FP,{RotatePlayer({DisplayTextX("\x07『 \x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 제작자에게 알려주세요!\x07 』",4)},HumanPlayers,FP)})
	CIfXEnd()
	f_LoadCp()
SetCallEnd()


CJumpEnd(AllPlayers,0x700)
NoAirCollisionX(FP)

CIf(FP,{CVar(FP,ReserveBGM[2],AtLeast,1),DeathsX(AllPlayers,AtMost,0,440,0xFFFFFF)})
CMov(FP,BGMTypeV,ReserveBGM)
CMov(FP,ReserveBGM,0)
CIfEnd()

AddBGM(1,"staredit\\wav\\ExceedOP.ogg",65300)
AddBGM(2,"staredit\\wav\\BGM1.ogg",32*1000)
AddBGM(3,"staredit\\wav\\BGM2.ogg",49*1000)
AddBGM(4,"staredit\\wav\\BGM3.ogg",60*1000)
Install_BGMSystem(FP,6,BGMTypeV)


function CP(Type,Value)
DoActions(FP,MoveCp(Type,Value*4))
end
--[[
EXCunit 적용
1번줄 : 건작의 레벨
9번줄 : 영작유닛 표식
10번줄 : 마린 데스값 중복적용 방지용
]]
CunitCtrig_Part1(FP) -- 죽은유닛 인식
CIf(FP,CVar(FP,EXCunitTemp[9][2],AtLeast,1)) -- 영작유닛인식
f_SaveCp()
--DoActions(FP,{RotatePlayer({DisplayTextX("저글링죽은거인식됨",4)},HumanPlayers,FP)})
f_LoadCp()
CIfEnd()
CMov(FP,Gun_Type,0)
for j, k in pairs({142,135,140,141,138,139,137}) do
CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,k,0,0xFF)},{SetCVar(FP,Gun_Type[2],SetTo,256)})
end
CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,131,0,0xFF)})
CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,132,0,0xFF)})
CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,133,0,0xFF)})
ClearCalc()
CunitCtrig_Part2()
CC_Header = CreateVar({"X",CCArr[CCptr]+2,0x15C,1,1})
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4_EX(i,{
DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
},
{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
SetCVar(FP,CurCunitI[2],SetTo,i),EXCunit_Reset,
MoveCp(Add,25*4),
},EXCunitTemp)
end
CunitCtrig_End()


for i = 0, 63 do
	CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
	Var_InputCVar,
	SetCtrigX("X",G_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
	SetCVar(FP,f_GunNum[2],SetTo,i),
	SetNext("X",f_Gun,0),SetNext(f_Gun+1,"X",1), -- Call f_Gun
	SetCtrigX("X",f_Gun+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
	SetCtrigX("X",f_Gun+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
	SetCtrig1X("X",f_Gun+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
	}, 1, 0x500+i)
end


CJump(FP,0x703)
f_Replace = SetCallForward()
SetCall(FP)
	f_SaveCp()
	CMov(FP,Gun_LV,0)
	f_Read(FP,BackupCP,CPosX,"X",0xFFFF)
	f_Read(FP,BackupCP,CPosY,"X",0xFFFF0000)
	f_Read(FP,_Add(BackupCP,1),Gun_LV,"X",0xFF000000)
	f_Read(FP,_Add(BackupCP,1),CunitP,"X",0xFF00)
	f_Read(FP,_Add(BackupCP,1),RepHeroIndex,"X",0xFF)
	f_Div(FP,CPosY,_Mov(0x10000)) -- 0
	f_Div(FP,CunitP,_Mov(0x100)) -- 0
	f_Div(FP,Gun_LV,_Mov(0x1000000)) -- 1
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
	CDoActions(FP,{
	TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
	TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
	TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
	TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
	})
	CDoActions(FP,{
		TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1),
		TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV)})
	CIfX(FP,CVar(FP,RepHeroIndex[2],Exactly,111))
	CDoActions(FP,{
	TCreateUnit(1, RepHeroIndex, 1, P8),TSetMemoryX(_Add(Nextptrs,19),SetTo,CunitP,0xFF)})
	for i = 0, 6 do
	CIf(FP,CVar(FP,CunitP[2],Exactly,i))
		CMov(FP,BarrackPtr[i+1],Nextptrs)
		f_Read(FP,_Add(BarrackPtr[i+1],10),BarPos[i+1])
	CIfEnd()
	end
	CElseX()
	CDoActions(FP,{
	TCreateUnit(1, RepHeroIndex, 1, CunitP)})
	CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
	CIfXEnd()
	f_LoadCp()
SetCallEnd()
CJumpEnd(FP,0x703)

CIfOnce(FP,nil,{SetCVar(FP,CurrentSpeed[2],SetTo,4),SeTMemory(0x5124F0,SetTo,SpeedV[4])}) -- OnPluginStart
dofile("Map4Source/EUDinit.lua") -- 루아파일 불러오기

f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
Print_All_CTextString(FP)
f_MemCpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2])
--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2])
--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2])

f_MemCpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])

f_MemCpy(FP,_Add(f_GunStrPtr,f_GunT[2]+20),_TMem(Arr(Str24[3],0),"X","X",1),Str24[2])

DoActions(FP,{GiveUnits(1,133,P8,11,0),GiveUnits(1,133,P8,12,1),GiveUnits(1,133,P8,13,2)})
CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
		f_SaveCp()
		CIf(FP,{TTMemory(_Add(BackupCp,6),NotSame,58)}) -- 발키리 저리가
			f_Read(FP,_Sub(BackupCp,9),CPos)
			f_Read(FP,BackupCp,CunitP,"X",0xFF)
			f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
			CMov(FP,Gun_LV,0)
			CIf(FP,CVar(FP,RepHeroIndex[2],Exactly,133))
			TriggerX(FP,{CVar(FP,CunitP[2],Exactly,0)},{SetCVar(FP,Gun_LV[2],SetTo,1)},{Preserved})
			TriggerX(FP,{CVar(FP,CunitP[2],Exactly,1)},{SetCVar(FP,Gun_LV[2],SetTo,2)},{Preserved})
			TriggerX(FP,{CVar(FP,CunitP[2],Exactly,2)},{SetCVar(FP,Gun_LV[2],SetTo,3)},{Preserved})
			DoActionsX(FP,SetCVar(FP,CunitP[2],SetTo,7))
			CIfEnd()
			CMov(FP,0x6509B0,RepUnitPtr)
			NWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
			CAdd(FP,0x6509B0,2)
			NWhileEnd()
			CDoActions(FP,{
			TSetDeaths(CurrentPlayer,SetTo,CPos,0),
			SetMemory(0x6509B0,Add,1),
			TSetDeathsX(CurrentPlayer,SetTo,RepHeroIndex,0,0xFF),
			TSetDeathsX(CurrentPlayer,SetTo,_Mul(CunitP,_Mov(0x100)),0,0xFF00),
			TSetDeathsX(CurrentPlayer,SetTo,_Mul(Gun_LV,_Mov(0x1000000)),0,0xFF000000),
			})
			CTrigger(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x04000000,0x04000000)},{SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0x10000)},1) -- 0x10000 무적플래그

		CIfEnd()
		f_LoadCp()
	CIfEnd()
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,8,0,0xFF)}) -- 소환 배열 저장 CustomShapePtr
	CAdd(FP,CustomShape1Size,1)
	f_SaveCp()
	f_Read(FP,_Sub(BackupCp,9),CPos)
	CMov(FP,0x6509B0,CustomShapePtr)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
		CAdd(FP,0x6509B0,1)
	CWhileEnd()
	CDoActions(FP,{TSetDeaths(CurrentPlayer,SetTo,CPos,0)})
	f_LoadCp()
	CIfEnd()
	
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,9,0,0xFF)}) -- 소환 배열 저장 CustomShapePtr2
	CAdd(FP,CustomShape2Size,1)
	f_SaveCp()
	f_Read(FP,_Sub(BackupCp,9),CPos)
	CMov(FP,0x6509B0,CustomShapePtr2)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
		CAdd(FP,0x6509B0,1)
	CWhileEnd()
	CDoActions(FP,{TSetDeaths(CurrentPlayer,SetTo,CPos,0)})
	f_LoadCp()
	CIfEnd()
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,10,0,0xFF)}) -- 소환 배열 저장 CustomShapePtr3
	CAdd(FP,CustomShape3Size,1)
	f_SaveCp()
	f_Read(FP,_Sub(BackupCp,9),CPos)
	CMov(FP,0x6509B0,CustomShapePtr3)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
		CAdd(FP,0x6509B0,1)
	CWhileEnd()
	CDoActions(FP,{TSetDeaths(CurrentPlayer,SetTo,CPos,0)})
	f_LoadCp()
	CIfEnd()
	CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
DoActions(FP,{GiveUnits(1,133,0,11,P8),GiveUnits(1,133,1,12,P8),GiveUnits(1,133,2,13,P8)})
CMov(FP,RepHeroIndex,0)
CWhile(FP,CVar(FP,RepHeroIndex[2],AtMost,227))
TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,58)},{SetCVar(FP,RepHeroIndex[2],Add,1)},{Preserved}) -- 발키리 나가
CDoActions(FP,{TModifyUnitEnergy(All,RepHeroIndex,AllPlayers,64,0),TRemoveUnit(RepHeroIndex,AllPlayers),TRemoveUnit(RepHeroIndex,P9),TRemoveUnit(RepHeroIndex,P10),TRemoveUnit(RepHeroIndex,P11)})
CAdd(FP,RepHeroIndex,1)
CWhileEnd()

CMov(FP,0x6509B0,RepUnitPtr)
CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))

	CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드


	CAdd(FP,0x6509B0,2)
CWhileEnd()
CMov(FP,0x6509B0,FP)
f_GetTblptr(FP,MarTblPtr,1501)
f_Read(FP,0x58F500,"X",SelHPEPD) -- 플립에서 전송받은 플립 변수 주소 입력
f_Read(FP,0x58F504,"X",MarHPEPD) -- 플립에서 전송받은 플립 변수 주소 입력
f_Read(FP,0x58F508,"X",SelShEPD) -- 플립에서 전송받은 플립 변수 주소 입력
f_Read(FP,0x58F50C,"X",SelOPEPD) -- 플립에서 전송받은 플립 변수 주소 입력
CIfEnd(SetMemory(0x6509B0,SetTo,FP)) -- OnPluginStart End

CIf(FP,CDeaths(FP,AtMost,0,RandomHeroPlace),SetCDeaths(FP,Add,1,RandomHeroPlace))
CMov(FP,RandW,100)
CWhile(FP,CVar(FP,RandW[2],AtLeast,1),SetCVar(FP,RandW[2],Subtract,1))
NJumpXEnd(FP,0x2)
f_Mod(FP,HPosX,_Rand(),_Mov(3072))
f_Mod(FP,HPosY,_Rand(),_Mov(6144))
NJumpX(FP,0x2,{CVar(FP,HPosX[2],AtLeast,320),CVar(FP,HPosX[2],AtMost,2752)})
NJumpX(FP,0x2,{CVar(FP,HPosY[2],AtLeast,5408)})
Simple_SetLocX(FP,0,HPosX,HPosY,HPosX,HPosY)
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)


CWhileEnd()
CIfEnd()
DoActions2(FP,PatchArrPrsv)
DoActionsX(FP,{SetCDeaths(FP,Add,1,IntroT),SetCDeaths(FP,Add,1,HealT)})
CIf(FP,CDeaths(FP,AtLeast,50,HealT),SetCDeaths(FP,SetTo,0,HealT))
for i = 0, 6 do
Trigger2(FP,{Bring(i,AtLeast,1,111,2+i)},{ModifyUnitHitPoints(All,"Men",i,i+2,100),ModifyUnitHitPoints(All,"Buildings",i,i+2,100),ModifyUnitShields(All,"Men",i,i+2,100),ModifyUnitShields(All,"Buildings",i,i+2,100)},{Preserved})
end
CIfEnd()


for i = 0, 6 do
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,i*5,IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", i).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n\n\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n",4);
			},HumanPlayers,FP);
		},
	}
end

for i = 7, 19 do
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,i*5,IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", 6)..""..string.rep("   ", i-6).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n\n\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n",4);
			},HumanPlayers,FP);


		},
	}
end

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,100,IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x02"..VerText.."\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX(string.rep("\t", 6)..""..string.rep("   ", 13).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
			},HumanPlayers,FP);
		},
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*1),IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x02"..VerText.."\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x043초 후 시작합니다.\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX(string.rep("\t", 6)..""..string.rep("   ", 13).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
			},HumanPlayers,FP);
		},
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*1),IntroT);
		},
		actions = {
			RotatePlayer({
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			},HumanPlayers,FP);
		},
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*2),IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x02"..VerText.."\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x042초 후 시작합니다.\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX(string.rep("\t", 6)..""..string.rep("   ", 13).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
			},HumanPlayers,FP);
		},
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*2),IntroT);
		},
		actions = {
			RotatePlayer({
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			},HumanPlayers,FP);
		},
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*3),IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x02"..VerText.."\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ\n"..string.rep("\t", 6)..""..string.rep("   ", 13).."\x041초 후 시작합니다.\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX(string.rep("\t", 6)..""..string.rep("   ", 13).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
			},HumanPlayers,FP);
		},
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*3),IntroT);
		},
		actions = {
			RotatePlayer({
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			},HumanPlayers,FP);
		},
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*4),IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n\n\n\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n",4);
			},HumanPlayers,FP);
		},
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*4),IntroT);
		},
		actions = {
			RotatePlayer({
			PlayWAVX("sound\\glue\\bnetclick.wav");
			PlayWAVX("sound\\glue\\bnetclick.wav");
			PlayWAVX("sound\\glue\\bnetclick.wav");
			PlayWAVX("sound\\glue\\bnetclick.wav");
			},HumanPlayers,FP);
		},
	}

	for i = 0, 6 do
	table.insert(CV1,SetMemory(0x6509B0,SetTo,i))
	table.insert(CV1,CenterView("Anywhere"))
	table.insert(CV2,SetMemory(0x6509B0,SetTo,i))
	table.insert(CV2,CenterView(2+i))
	Trigger {
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*4),IntroT);
		},
		actions = {
			CreateUnitWithProperties(4,15,2+i,i,{energy = 100});
			SetResources(i,Add,15000,Ore);
		},
	}
	end


	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,(150+(48*4))-1,IntroT);
		},
		actions = {
			CV1,
			PreserveTrigger();
		},
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,150+(48*4),IntroT);
		},
		actions = {
			CV2,
		},
	}

for k = 1, 7 do
	Trigger { -- 미션 오브젝트, 환전률 셋팅
		players = {Force1},
		conditions = {
			Label(0);
			CVar(FP,SetPlayers[2],Exactly,k);
		},
		actions = {
			SetMissionObjectives("\x13\x1F===================================\n\x13\n\x13\x04마린키우기 \x1FＵｍＬｉｍｉｔ ＥｘｃｅｅＤ\n\x13"..P[k].." \x07플레이중입니다. \x0F환전률 : \x04"..Ex1[k].."%\n\n\x13\x1F===================================");
			SetCVar(FP,ExchangeRate[2],SetTo,Ex1[k]);
			
		},
	}
end
--IBGM EPD
InsertKey = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04이 맵은 클리어의 개념이 없으며 \n\x13\x08게임 오버 \x04시 \x1F달성한 단계\x04와 \x07스코어\x04가 게임의 성과를 나타냅니다.\n\x13\x04당신의 한계를 시험해 보세요!\n\x13\x07이론적으로 제한 없는 단계와 업그레이드\x04를 제공합니다.\n\x13\x04단, 마린 수는 \x17120기로 제한\x04됩니다.\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04조합소는 중앙 수정 광산이 있는곳으로 가시면 됩니다.\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"

Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		Label(0);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText(InsertKey,4);
		PreserveTrigger();
		},
	}

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
ClearT1 = "\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04최후의 건물 \x03OverMind G \x04를 파괴하셨습니다.\n\x13\x0710초 후 다음 레벨로 진입합니다.\n\x13\x04\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
DoActions(FP,SetInvincibility(Enable,147,P8,"Anywhere"))
Trigger2(FP,{
CommandLeastAt(131,64),
CommandLeastAt(132,64),
CommandLeastAt(133,64),
CommandLeastAt(151,64),
CommandLeastAt(152,64),
CommandLeastAt(148,64),
CommandLeastAt(130,64),
CommandLeastAt(201,64)},{
SetInvincibility(Disable,147,P8,"Anywhere")
},{Preserved})
CIf(FP,Deaths(FP,AtLeast,1,147))
DoActions(FP,{
	ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8)
})
TriggerX(FP,{CDeaths(FP,AtMost,0,ReplaceDelayT)},{RotatePlayer({DisplayTextX(ClearT1,4),},HumanPlayers,FP),SetCVar(FP,BGMTypeV[2],SetTo,1)},{Preserved})
--PlayWAVX()
for i = 0, 4 do
TriggerX(FP,{CDeaths(FP,AtLeast,5000+(i*1000),ReplaceDelayT),CDeaths(FP,AtMost,0,TextSwitch[i+1])},{RotatePlayer({DisplayTextX("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04최후의 건물 \x03OverMind G \x04를 파괴하셨습니다.\n\x13\x0710초 후 다음 레벨로 진입합니다.\n\x13\x04"..5-i.."초 남았습니다.\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),PlayWAVX("sound\\glue\\countdown.wav"),PlayWAVX("sound\\glue\\countdown.wav"),PlayWAVX("sound\\glue\\countdown.wav")},HumanPlayers,FP),
SetCDeaths(FP,SetTo,1,TextSwitch[i+1])},{Preserved})
end

CDoActions(FP,{TSetCDeaths(FP,Add,Dt,ReplaceDelayT)})

CIf(FP,CDeaths(FP,AtLeast,10000,ReplaceDelayT))
MoveMarineArr = {}
for i = 0, 6 do
table.insert(MoveMarineArr,MoveUnit(All,"Men",i,16,2+i))
table.insert(MoveMarineArr,MoveUnit(All,"Men",i,17,2+i))
table.insert(MoveMarineArr,MoveUnit(All,"Men",i,18,2+i))
for j = 0, 2 do
table.insert(MoveMarineArr,MoveUnit(All,"Men",i,16,19+j))
table.insert(MoveMarineArr,MoveUnit(All,"Men",i,17,19+j))
table.insert(MoveMarineArr,MoveUnit(All,"Men",i,18,19+j))
end
end
DoActions2(FP,MoveMarineArr)

CMov(FP,0x6509B0,RepUnitPtr)
CWhile(FP,{Deaths(CurrentPlayer,AtLeast,1,0)})
	CAdd(FP,0x6509B0,1)
	CIf(FP,DeathsX(CurrentPlayer,Exactly,7*256,0,0xFF00))
		CSub(FP,0x6509B0,1)
		CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드.
		CAdd(FP,0x6509B0,1)
	CIfEnd()
	CSub(FP,0x6509B0,1)
	CAdd(FP,0x6509B0,2)
CWhileEnd()
CMov(FP,0x6509B0,FP)
DoActionsX(FP,{SetDeaths(FP,Subtract,1,147),
SetCDeaths(FP,SetTo,0,ReplaceDelayT),
SetCDeaths(FP,SetTo,0,TextSwitch[1]),
SetCDeaths(FP,SetTo,0,TextSwitch[2]),
SetCDeaths(FP,SetTo,0,TextSwitch[3]),
SetCDeaths(FP,SetTo,0,TextSwitch[4]),
SetCDeaths(FP,SetTo,0,TextSwitch[5]),
})
CIfEnd()
CIfEnd()

f_Read(FP,0x51CE8C,Dx)
CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
CiSub(FP,DtP,Dy,Du)
CMov(FP,Dv,DtP)
CMov(FP,0x58F500,DtP) -- MSQC val Send. 180
CMov(FP,Du,Dy)


CIf(FP,{Memory(0x628438, AtLeast, 1)})
	CIf(FP,CDeaths(FP,Exactly,0,Print13),SetCDeaths(FP,Add,88,Print13))
		Print_13(FP,{P1,P2,P3,P4,P5,P6,P7},nil)
	CIfEnd()
	DoActionsX(FP,SetCDeaths(FP,Subtract,1,Print13))
CIfEnd()
UnitReadX(FP,AllPlayers,229,64,count)

for i = 0, 7 do
CMov(FP,0x57F120+(4*i),count)
end
CMov(FP,TempT,0)
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				CVar(FP,TempT[2],AtLeast,(2^i)*3600000)
			},
			actions = {
				SetMemory(0x57F0F0+(4*5),Add,(2^i)*10000);
				SetCVar(FP,TempT[2],Subtract,(2^i)*3600000);
				PreserveTrigger();
			}
		}
	end
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				CVar(FP,TempT[2],AtLeast,(2^i)*60000)
			},
			actions = {
				SetMemory(0x57F0F0+(4*5),Add,(2^i)*100);
				SetCVar(FP,TempT[2],Subtract,(2^i)*60000);
				PreserveTrigger();
			}
		}
	end
	for i = 6, 0, -1 do
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				CVar(FP,TempT[2],AtLeast,(2^i)*1000)
			},
			actions = {
				SetMemory(0x57F0F0+(4*5),Add,(2^i));
				SetCVar(FP,TempT[2],Subtract,(2^i)*1000);
				PreserveTrigger();
			}
		}
	end

--[[
MSQC KeySensor
[MSQC]
Always() ; val, 0x58F500 : 180
ESC = 199,1
Deaths(CurrentPlayer,Exactly,1,441);RIGHT = 200,1
Deaths(CurrentPlayer,Exactly,1,441);LEFT = 201,1
F12 = 202,1
F9 = 203,1
Deaths(CurrentPlayer,Exactly,1,441);B = 204,1
Deaths(CurrentPlayer,AtLeast,1,443);1 = 205,1
Deaths(CurrentPlayer,AtLeast,1,443);2 = 206,1
Deaths(CurrentPlayer,AtLeast,1,443);3 = 207,1
Deaths(CurrentPlayer,AtLeast,1,443);4 = 208,1
Deaths(CurrentPlayer,AtLeast,1,443);5 = 209,1
Deaths(CurrentPlayer,AtLeast,1,443);6 = 210,1
Deaths(CurrentPlayer,AtLeast,1,443);7 = 211,1
Deaths(CurrentPlayer,AtLeast,1,442);1 = 212,1
Deaths(CurrentPlayer,AtLeast,1,442);2 = 213,1
Deaths(CurrentPlayer,AtLeast,1,442);3 = 214,1
Deaths(CurrentPlayer,AtLeast,1,442);4 = 215,1
Deaths(CurrentPlayer,AtLeast,1,442);5 = 216,1
Deaths(CurrentPlayer,AtLeast,1,442);6 = 217,1
Deaths(CurrentPlayer,AtLeast,1,442);7 = 218,1
Deaths(CurrentPlayer,AtLeast,1,442);` = 219,1
]]
ESC = 199
RIGHT = 200
LEFT = 201
F12 = 202
F9 = 203
B = 204
B1 = 205
B2 = 206
B3 = 207
B4 = 208
B5 = 209
B6 = 210
B7 = 211

-- 441 = OPConsole 
-- 442 = CPConsole 
-- 443 = BanConsole
OPConsole = 441
CPConsole = 442
BanConsole = 443

CIf(FP,ElapsedTime(AtLeast,1))
DoActions(FP,{print_utf8(12, 0, "\x07[ LV.000\x04 - \x1F00h \x1100m \x0F00s \x04- \x07기부\x04 : F9\x07 ]")})
CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
	CElseIfX(PlayerCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i)})
	f_Read(FP,0x58A364+(48*180)+(4*i),Dt) -- MSQC val Recive. 180 
	CMov(FP,0x6509B0,i)
	CTrigger(FP,{TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ LV.000\x04 - \x1F00h \x1100m \x0F00s \x04- \x07기부\x04 : F9, \x1C배속조정 \x04: F12 (방장만 가능)\x07 ]")},1)
	end
CIfXEnd()
CIfEnd()
--상위플레이어 단락이지만 LV과 시간 표기시에 13번줄 조작은 문제없음. 따라서 이곳에 작성함

--
TriggerX(FP,{Deaths(CurrentPlayer,Exactly,1,CPConsole),Deaths(CurrentPlayer,AtLeast,1,F12)},{PlayWAV("sound\\Misc\\Buzz.wav"),PlayWAV("sound\\Misc\\Buzz.wav"),DisplayText("\x07『 \x1F기부 ON \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』",4),SetDeaths(CurrentPlayer,SetTo,0,F12)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,Exactly,1,OPConsole),Deaths(CurrentPlayer,AtLeast,1,F9)},{PlayWAV("sound\\Misc\\Buzz.wav"),PlayWAV("sound\\Misc\\Buzz.wav"),DisplayText("\x07『 \x1C배속조정 \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』",4),SetDeaths(CurrentPlayer,SetTo,0,F9)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,F12),Deaths(CurrentPlayer,Exactly,0,OPConsole)},{SetDeaths(CurrentPlayer,SetTo,1,OPConsole),SetDeaths(CurrentPlayer,SetTo,0,F12)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,F12),Deaths(CurrentPlayer,Exactly,1,OPConsole)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(FP,SetTo,0,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,F12)},{Preserved})
CIf(FP,Deaths(CurrentPlayer,AtLeast,1,OPConsole),SetCDeaths(FP,Add,1,OPFuncT))
TriggerX(FP,{CDeaths(FP,AtLeast,30*24,OPFuncT)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetCDeaths(FP,SetTo,0,OPFuncT)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,RIGHT),CVar(FP,SpeedVar[2],AtMost,9)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Add,1)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,LEFT),CVar(FP,SpeedVar[2],AtLeast,2)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Subtract,1)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,0,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,1,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,1,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{Preserved})
CIfX(FP,Deaths(CurrentPlayer,AtLeast,1,BanConsole))
CTrigger(FP,{TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ \x08강퇴모드 ON. \x04숫자키를 5회 눌러 강퇴하세요. ESC : 닫기\x07 ]")},1)
-- 205 ~ 211
for i = 1, 6 do
CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,205+i),TTMemory(0x6509B0,NotSame,i),PlayerCheck(i,1)},{
	RotatePlayer({DisplayTextX("\x07『 "..GiveP[i+1].."\x04에게 \x08경고 1회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다. \x07』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
	SetCDeaths(FP,SetTo,0,OPFuncT),SetCDeaths(FP,Add,1,BanToken[i+1])},{Preserved})
end
CMov(FP,0x6509B0,CurrentOP)
CelseX()
CTrigger(FP,{TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ \x04방향키(←→) : \x1F배속 조정, \x04ESC : 닫기, B : \x08강퇴모드 ON\x07 ]")},1)
CIfXEnd()
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(CurrentPlayer,SetTo,0,BanConsole)},{Preserved})
CIfEnd()
CMov(FP,0x6509B0,FP) -- RecoverCP 상위플레이어 단락 끝

CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
CMov(FP,CurrentSpeed,SpeedVar)
for i = 1, 10 do
Trigger { -- No comment (E93EF7A9)
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,SpeedVar[2],Exactly,i)
	},
	actions = {PreserveTrigger();
		RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
		DisplayTextX("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i].." \x07』", 0)},HumanPlayers,FP);
		SetMemory(0x5124F0,SetTo,SpeedV[i]);
	},
}
end
CIfEnd()





DelayMedicT = {
"\x07『 \x1D예약메딕\x04을 \x1B2Tick\x04으로 변경합니다. - \x1F300 Ore\x07 』",
"\x07『 \x1D예약메딕\x04을 \x1B3Tick\x04으로 변경합니다. - \x1F350 Ore\x07 』",
"\x07『 \x1D예약메딕\x04을 \x1B4Tick\x04으로 변경합니다. - \x1F400 Ore\x07 』",
"\x07『 \x1D예약메딕\x04을 \x1B비활성화(1Tick)\x04하였습니다. - \x1F250 Ore\x07 』"}

if Limit == 1 then
	DoActions(FP,SetResources(Force1,Add,0x70000000,Ore),1)
end


for i = 0, 6 do -- 각플레이어

if i ~= 0 then --강퇴트리거는 1플레이어 제외
Trigger { -- 강퇴
	players = {i},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,5,BanToken[i+1]);
	},
	actions = {
		RotatePlayer({DisplayTextX("\x07『 \x04"..GiveP[i+1].."\x04의 강퇴처리가 완료되었습니다.\x07 』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x07『 \x04당신은 강되당했습니다.\x07 』",4);
		Defeat();
		},
	}
end




TriggerX(FP,{Deaths(i,AtLeast,1,CPConsole),Memory(0x57F1B0,Exactly,i)},{
	print_utf8(12,0,"\x07[ \x1F기부모드 ON. \x04숫자키를 눌러 기부하세요. 기부단위변경 : ~키, ESC : 닫기\x07 ]")
},{Preserved}) -- 13번줄 프린트 트리거 플레이어가 FP인 이유는 트리거 순서가 1P부터 8P까지 실행되기 때문. i로 하게될 경우 이게 씹히고 위에있는 CText가 보이게 된다. 

TriggerX(i,{Deaths(CurrentPlayer,Exactly,0,OPConsole),Deaths(CurrentPlayer,AtLeast,1,F9),Deaths(CurrentPlayer,Exactly,0,B),Deaths(CurrentPlayer,Exactly,0,CPConsole)},{SetDeaths(CurrentPlayer,SetTo,1,CPConsole),SetDeaths(CurrentPlayer,SetTo,0,F9)},{Preserved})
TriggerX(i,{Deaths(CurrentPlayer,Exactly,0,OPConsole),Deaths(CurrentPlayer,AtLeast,1,F9),Deaths(CurrentPlayer,Exactly,0,B),Deaths(CurrentPlayer,Exactly,1,CPConsole)},{SetDeaths(CurrentPlayer,SetTo,0,CPConsole),SetDeaths(CurrentPlayer,SetTo,0,F9)},{Preserved})
--CPConsole
CIfX(i,{Deaths(CurrentPlayer,AtLeast,1,CPConsole)},SetCDeaths(i,Add,1,FuncT))
TriggerX(i,{CDeaths(i,AtLeast,30*24,FuncT)},{SetDeaths(CurrentPlayer,SetTo,0,CPConsole),SetCDeaths(i,SetTo,0,FuncT)},{Preserved})

GiveRateT = {"\x07『 \x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다.\x07 』",
"\x07『 \x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.\x07 』"}
for k = 0, 5 do
Trigger { -- 기부 금액 변경
	players = {i},
	conditions = {
		Label(0);
		CDeaths("X",Exactly,k,GiveRate);
		Deaths(CurrentPlayer,AtLeast,1,219)
	},
	actions = {
		SetDeaths(CurrentPlayer,SetTo,0,219);
		DisplayText(GiveRateT[k+1],4);
		SetCDeaths("X",Add,1,GiveRate);
		SetCDeaths(i,SetTo,0,FuncT);
		PreserveTrigger();
		},
}
end
TriggerX(i,{CDeaths("X",AtLeast,6,GiveRate)},{SetCDeaths("X",Subtract,6,GiveRate)},{Preserved})

for j=0, 6 do
	if i==j then
		Trigger { -- 돈 기부 시스템
			players = {i},
			conditions = {
				Deaths(i,AtLeast,1,j+212);
			},
			actions = {
				SetDeaths(i,SetTo,0,j+212);
				DisplayText("\x07『 "..GiveP[j+1].."\x04은(는) 자기 자신입니다. 자기 자신에게는 기부할 수 없습니다. \x07』",4);
				SetCDeaths(i,SetTo,0,FuncT);
				PreserveTrigger();
			},
		}
	else
		for k=0, 5 do
			Trigger { -- 돈 기부 시스템
				players = {i},
				conditions = {
					Label(0);
					Deaths(i,AtLeast,1,j+212);
					PlayerCheck(i,1);
					CDeaths(i,Exactly,k,GiveRate);
					Accumulate(i,AtMost,GiveRate2[k+1],Ore);
				},
				actions = {
					SetDeaths(i,SetTo,0,j+212);
					DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
					SetCDeaths(i,SetTo,0,FuncT);
					PreserveTrigger();
				},
			}
			Trigger { -- 돈 기부 시스템
				players = {i},
				conditions = {
					Label(0);
					Deaths(i,AtLeast,1,j+212);
					PlayerCheck(j,1);
					CDeaths(i,Exactly,k,GiveRate);
					Accumulate(i,AtLeast,GiveRate2[k+1],Ore);
					Accumulate(i,AtMost,0x7FFFFFFF,Ore);
				},
				actions = {
					SetDeaths(i,SetTo,0,j+212);
					SetResources(i,Subtract,GiveRate2[k+1],Ore);
					SetResources(j,Add,GiveRate2[k+1],Ore);
					DisplayText("\x07『 "..GiveP[j+1].."\x04에게 \x1F"..GiveRate2[k+1].." Ore\x04를 기부하였습니다. \x07』",4);
					SetMemory(0x6509B0,SetTo,j);
					DisplayText("\x12\x07『"..GiveP[k+1].."\x04에게 \x1F"..GiveRate2[k+1].." Ore\x04를 기부받았습니다.\x02 \x07』",4);
					SetMemory(0x6509B0,SetTo,i);
					SetCDeaths(i,SetTo,0,FuncT);
					PreserveTrigger();
				},
			}
		end
		Trigger { -- 돈 기부 시스템
			players = {i},
			conditions = {
				Label(0);
				Deaths(i,AtLeast,1,j+212);
				PlayerCheck(j,0);
			},
			actions = {
				SetDeaths(i,SetTo,0,j+212);
				DisplayText("\x07『 "..GiveP[j+1].."\x04이(가) 존재하지 않습니다. \x07』",4);
				SetCDeaths(i,SetTo,0,FuncT);
				PreserveTrigger();
			},
		}
	end 
end 

TriggerX(i,{Deaths(CurrentPlayer,AtLeast,1,ESC)},{SetCDeaths(i,SetTo,0,FuncT),SetDeaths(CurrentPlayer,SetTo,0,CPConsole)},{Preserved})
CelseX()
CIfXEnd()

	DoActions(i,{
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
	})
	for j = 0, 3 do
	TriggerX(i,{CDeaths("X",Exactly,j,DelayMedic)},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{Preserved})
	TriggerX(i,{Command(i,AtLeast,1,72),CDeaths("X",Exactly,j,DelayMedic)},{
		DisplayText(DelayMedicT[j+1],4),
		SetCDeaths("X",Add,1,DelayMedic),
		GiveUnits(All,72,i,"Anywhere",P12),
		RemoveUnitAt(1,72,"Anywhere",P12)},{Preserved})
	end
	TriggerX(i,{CDeaths("X",AtLeast,4,DelayMedic)},{SetCDeaths("X",Subtract,4,DelayMedic)},{Preserved})

Trigger { -- BGM On Off
	players = {i},
	conditions = {
		DeathsX(i,Exactly,0,440,0xFF000000);
		Command(i,AtLeast,1,22);
	},
	actions = {
		GiveUnits(All,22,i,"Anywhere",P12);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
		SetDeathsX(i,SetTo,1*16777216,440,0xFF000000);
		PreserveTrigger();
		},
	}
Trigger { -- BGM On Off
	players = {i},
	conditions = {
		DeathsX(i,Exactly,1*16777216,440,0xFF000000);
		Command(i,AtLeast,1,22);
	},
	actions = {
		GiveUnits(All,22,i,"Anywhere",P12);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
		SetDeathsX(i,SetTo,0*16777216,440,0xFF000000);
		PreserveTrigger();
	},
}

table.insert(AtkUpgradeMaskRetArr,(0x58D2B0+(i*46)+0+i)%4)
table.insert(AtkUpgradePtrArr,0x58D2B0+(i*46)+0+i - AtkUpgradeMaskRetArr[i+1])
table.insert(NormalUpgradeMaskRetArr,(0x58D2B0+(i*46)+7)%4)
table.insert(NormalUpgradePtrArr,0x58D2B0+(i*46)+7 - NormalUpgradeMaskRetArr[i+1])
table.insert(DefUpgradeMaskRetArr,(0x58D2B0+(i*46)+8+i)%4)
table.insert(DefUpgradePtrArr,0x58D2B0+(i*46)+8+i - DefUpgradeMaskRetArr[i+1])
table.insert(AtkFactorMaskRetArr,(0x6559C0+((i)*2))%4)
table.insert(AtkFactorPtrArr,0x6559C0+((i)*2) - AtkFactorMaskRetArr[i+1])
table.insert(DefFactorMaskRetArr,(0x6559C0+((i+8)*2))%4)
table.insert(DefFactorPtrArr,0x6559C0+((i+8)*2) - DefFactorMaskRetArr[i+1])



CIfX(FP,PlayerCheck(i,1)) -- FP가 관리하는 시스템 부분 트리거. 각플레이어가 있을경우 실행된다.

CDoActions(FP,{TSetDeathsX(i,Subtract,Dt,440,0xFFFFFF)}) -- 브금타이머


TriggerX(FP,{Command(i,AtLeast,1,12),Bring(i,AtMost,120-1,MarID[i+1],64)},{
	SetMemory(0x6509B0,SetTo,i),
	DisplayText("\x07『 \x1F광물\x04을 소모하여 \x1FExceeD \x1BM\x04arine 을 \x19소환\x04하였습니다. - \x1F30,000 O r e \x07』",4),
	SetMemory(0x6509B0,SetTo,FP),
	RemoveUnitAt(1,12,"Anywhere",i),
	SetCDeaths(FP,Add,1,MarCreate[i+1]),
	SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
	SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
},{Preserved})

TriggerX(FP,{Command(i,AtLeast,1,15)},{
	SetMemory(0x6509B0,SetTo,i),
	DisplayText("\x07『 \x1F광물\x04을 소모하여 Normal Marine 을 \x19소환\x04하였습니다. - \x1F5,000 O r e \x07』",4),
	SetMemory(0x6509B0,SetTo,FP),
	RemoveUnitAt(1,15,"Anywhere",i),
	SetCDeaths(FP,Add,1,MarCreate2[i+1]),
	SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
	SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
},{Preserved})

CIf(FP,{CDeaths(FP,AtLeast,1,MarCreate[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate[i+1]))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally)
DoActions(FP,CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100}))
CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally),CVar(FP,BarRally[2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0,0xFF000000)})
	CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
	TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally,0)})
CIfEnd()
CMov(FP,0x6509B0,FP)
CIfEnd()

CIf(FP,{CDeaths(FP,AtLeast,1,MarCreate2[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate2[i+1]))
f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally)
DoActions(FP,CreateUnitWithProperties(1,10,2+i,i,{energy = 100}))
CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally),CVar(FP,BarRally[2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0,0xFF000000)})
	CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
	TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally,0)})
CIfEnd()
CMov(FP,0x6509B0,FP)
CIfEnd()

TriggerX(FP,{Command(i,AtLeast,1,12),Bring(i,AtLeast,120,MarID[i+1],64)},{
	SetMemory(0x6509B0,SetTo,i),
	SetResources(i,Add,30000,Ore),
	DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x19최대 보유 가능수\x04가 초과되었습니다. \x1B(최대 120기까지 보유 가능) \x04자원 반환 + \x1F30000 O r e \x07』",4),
	SetMemory(0x6509B0,SetTo,FP),
	RemoveUnitAt(1,12,"Anywhere",i),
	SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
	SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
},{Preserved})
	CIf(FP,{-- 메딕트리거 귀찮아서 한번에 처리하기;
		TTOR({
			Command(i,AtLeast,1,MedicTrig[1]),
			Command(i,AtLeast,1,MedicTrig[2]),
			Command(i,AtLeast,1,MedicTrig[3]),
			Command(i,AtLeast,1,MedicTrig[4]),
		})
	},{
		RemoveUnit(MedicTrig[1],i),
		RemoveUnit(MedicTrig[2],i),
		RemoveUnit(MedicTrig[3],i),
		RemoveUnit(MedicTrig[4],i),
	})
	for j = 1, 4 do
		DoActions(FP,{
			ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
			ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
			ModifyUnitShields(All,"Men",i,"Anywhere",100),
			ModifyUnitShields(All,"Buildings",i,"Anywhere",100),
			SetMemory(0x582324+(MedicTrig[j]*12)+(i*4),SetTo,0),
			SetMemory(0x584DE4+(MedicTrig[j]*12)+(i*4),SetTo,0)
		})
	end
	CIfEnd()



NIf(FP,MemoryB(0x58D2B0+(46*i)+18,AtLeast,1)) -- 공업 255회
CDoActions(FP,{
		SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
		TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
		SetCVar(FP,UpgradeCP[2],SetTo,i),
		SetCVar(FP,UpgradeMax[2],SetTo,255),
		SetMemoryB(0x58D2B0+(46*i)+18,SetTo,0)})
CallTrigger(FP,OneClickUpgrade)
NIfEnd()
NIf(FP,MemoryB(0x58D2B0+(46*i)+17,AtLeast,1)) -- 공업 10회
CDoActions(FP,{
		SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
		TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
		SetCVar(FP,UpgradeCP[2],SetTo,i),
		SetCVar(FP,UpgradeMax[2],SetTo,10),
		SetMemoryB(0x58D2B0+(46*i)+17,SetTo,0)})
CallTrigger(FP,OneClickUpgrade)
NIfEnd()
NIf(FP,MemoryB(0x58D2B0+(46*i)+19,Exactly,1)) -- 체업 255회
CDoActions(FP,{
		SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
		TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
		SetCVar(FP,UpgradeCP[2],SetTo,i),
		SetCVar(FP,UpgradeMax[2],SetTo,255),
		SetMemoryB(0x58D2B0+(46*i)+19,SetTo,0)})
CallTrigger(FP,OneClickUpgrade)
NIfEnd()
NIf(FP,MemoryB(0x58D2B0+(46*i)+20,Exactly,1)) -- 체업 10회
CDoActions(FP,{
		SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
		TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
		SetCVar(FP,UpgradeCP[2],SetTo,i),
		SetCVar(FP,UpgradeMax[2],SetTo,10),
		SetMemoryB(0x58D2B0+(46*i)+20,SetTo,0)})
CallTrigger(FP,OneClickUpgrade)
NIfEnd()

CIf(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,255*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))},{SetMemoryX(AtkUpgradePtrArr[i+1],SetTo,0*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))})
DoActionsX(FP,{
	SetMemory(0x6509B0,SetTo,i),
	DisplayText("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＩＭＩＴ　ＢＲＥＡＫＥＤ\x04　！！！\n\x14\n\x14\n\x13\x1C공격력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\n\x13\x07업그레이드를 \x040으로 재설정하고 \x17업그레이드 비용 증가량\x04이 올라갑니다.\n\n\x14\n\x13\x04！！！　\x1FＬＩＭＩＴ　ＢＲＥＡＫＥＤ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
	PlayWAV("staredit\\wav\\LimitBreak.ogg"),
	SetMemory(0x6509B0,SetTo,FP),
	SetMemoryW(0x656EB0 + (MarWep[i+1]*2),Add,MarDamageFactor*255),
	SetCVar(FP,AtkFactorV[i+1][2],Add,AtkFactor),
	SetCVar(FP,AtkUpCompCount[i+1][2],Add,1),
})
CIfEnd()



CIf(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,255*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))},{SetMemoryX(DefUpgradePtrArr[i+1],SetTo,0*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))})
DoActionsX(FP,{
	SetMemory(0x6509B0,SetTo,i),
	DisplayText("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＩＭＩＴ　ＢＲＥＡＫＥＤ\x04　！！！\n\x14\n\x14\n\x13\x08체력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\n\x13\x07업그레이드를 \x040으로 재설정하고 \x17업그레이드 비용 증가량\x04이 올라갑니다.\n\n\x14\n\x13\x04！！！　\x1FＬＩＭＩＴ　ＢＲＥＡＫＥＤ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
	PlayWAV("staredit\\wav\\LimitBreak.ogg"),
	SetMemory(0x6509B0,SetTo,FP),
	SetCVar(FP,DefFactorV[i+1][2],Add,DefFactor),
	SetCVar(FP,MarMaxHP[i+1][2],Add,2000*256),
	SetCVar(FP,DefUpCompCount[i+1][2],Add,1),
})
CIfEnd()



DoActionsX(FP,{SetCVar(FP,CurrentHP[i+1][2],SetTo,0)})-- 체력값 초기화
for Bit = 0, 7 do
TriggerX(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
	{SetCVar(FP,CurrentHP[i+1][2],Add,2008*(2^Bit))},{Preserved})
end
CMov(FP,MarHP[i+1],_Add(CurrentHP[i+1],MarMaxHP[i+1]))


CIfX(FP,CVar(FP,AtkUpCompCount[i+1][2],AtMost,0)) -- 업그레이드 컴플리트 카운트(255업 찍은 횟수)가 0일 경우.
DoActions(FP,{SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,0*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1]))})
for Bit = 0, 7 do
Trigger2(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
	{SetMemoryX(NormalUpgradePtrArr[i+1],Add,(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]),(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]))},{Preserved})
end
CElseX() -- 업글컴플카운트 1 이상이면 일마공업 255로 고정됨!
DoActions(FP,SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,255*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1])),1)
CIfXEnd()

CIf(FP,{TTCVar(FP,DefFactorV2[i+1][2],NotSame,DefFactorV[i+1])})
CDoActions(FP,{TSetMemoryX(DefFactorPtrArr[i+1],SetTo,_Mul(DefFactorV[i+1],_Mov(256^DefFactorMaskRetArr[i+1])),255*(256^DefFactorMaskRetArr[i+1]))})
CMov(FP,DefFactorV2[i+1],DefFactorV[i+1])
CIfEnd()

CIf(FP,{TTCVar(FP,AtkFactorV2[i+1][2],NotSame,AtkFactorV[i+1])})
CDoActions(FP,{TSetMemoryX(AtkFactorPtrArr[i+1],SetTo,_Mul(AtkFactorV[i+1],_Mov(256^AtkFactorMaskRetArr[i+1])),255*(256^AtkFactorMaskRetArr[i+1]))})
CMov(FP,AtkFactorV2[i+1],AtkFactorV[i+1])
CIfEnd()

TriggerX(FP,{CVar(FP,AtkFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58D088 + (i * 46) + i,SetTo,0),
	SetMemory(0x6509B0,SetTo,i),
	DisplayText("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x14\n\x14\n\x13\x1C공격력 업그레이드\x04의 증가량이 255를 넘었습니다.\n\x13\x04이제부터는 \x1C원클릭 업그레이드\x04를 통해 업그레이드 해주세요.\n\n\x14\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
	PlayWAV("staredit\\wav\\button3.wav"),
	SetMemory(0x6509B0,SetTo,FP)
})
TriggerX(FP,{CVar(FP,DefFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),
	SetMemory(0x6509B0,SetTo,i),
	DisplayText("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x14\n\x14\n\x13\x08체력 업그레이드\x04의 증가량이 255를 넘었습니다.\n\x13\x04이제부터는 \x1C원클릭 업그레이드\x04를 통해 업그레이드 해주세요.\n\n\x14\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
	PlayWAV("staredit\\wav\\button3.wav"),
	SetMemory(0x6509B0,SetTo,FP)

})

 -- 업글시 돈 증가량 변수와 동기화. TT조건을 이용해 값이 변화할때만 연산함



CIf(FP,{TTCVar(FP,MarHP[i+1][2],"!=",MarHP2[i+1])})
	CMov(FP,MarHP2[i+1],MarHP[i+1])
	CMov(FP,0x662350 + (MarID[i+1]*4),MarHP2[i+1])
	CMov(FP,0x515BB0+(i*4),_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)))
CIfEnd()
CIf(FP,{Memory(0x6284E8+(0x30*i) + 4,AtMost,0)})
CDoActions(FP,{TSetMemory(SelOPEPD,Add,1)})
f_Read(FP,0x6284E8+(0x30*i),SelPTR,SelEPD)
	CIf(FP,{CVar(FP,SelPTR[2],AtLeast,1),Memory(0x57F1B0, Exactly, i)})

		f_Read(FP,_Add(SelEPD,2),SelHP)
		f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
		f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
		for j = 0, 6 do
			CIf(FP,CVar(FP,SelPl[2],Exactly,j))
				CMov(FP,SelMaxHP,_Div(MarHP2[j+1],_Mov(256)))
			CIfEnd()
		end
		f_Div(FP,SelHP,_Mov(256))
		f_Div(FP,SelSh,_Mov(256))
		CDoActions(FP,{TSetMemory(SelHPEPD,SetTo,SelHP),TSetMemory(MarHPEPD,SetTo,SelMaxHP),TSetMemory(SelShEPD,SetTo,SelSh)})
	CIfEnd()
CIfEnd()


CElseX()
DoActions(FP,{SetDeathsX(i,SetTo,0,440,0xFFFFFF)}) -- 각플레이어가 존재하지 않을 경우 각플레이어의 브금타이머 0으로 고정 
CIfXEnd()
end
CDoActions(FP,{TSetDeathsX(FP,Subtract,Dt,440,0xFFFFFF)}) -- FP의 브금타이머. 관전자용



NJump(Force1,0x1,{Bring(CurrentPlayer,AtMost,0,"Men",9)})
for i = 0, 6 do
--CIf(i,Score(i,Kills,AtLeast,1000))
--CRead(i,KillScore,0x581F04+(i*4))
--CDiv(i,ExchangeP,KillScore,1000)
--CAdd(i,{FP,ExScore[i+1][2],nil,"V"},ExchangeP)
--CMov(i,0x581F04+(i*4),ExchangeP)
--CAdd(i,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,10),{FP,ExchangeRate[2],nil,"V"}))
--CMov(i,ExchangeP,0)
--CIfEnd()
--DoActions(i,SetDeaths(i,Subtract,1,111))
--CIf(i,Score(i,Kills,AtLeast,1000))



--
--CMov(i,ExchangeP,_Div(_Read(0x581F04+(i*4)),1000))
--CMov(i,ExchangeP,_Div(KillScore,1000))
--CAdd(i,{FP,ExScore[i+1][2],nil,"V"},_Div(KillScore,1000))
--CMov(i,0x581F04+(i*4),_Mod(KillScore,1000))
--CAdd(i,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,10),{FP,ExchangeRate[2],nil,"V"}))
--CMov(FP,ExchangeP,0)
--CIfEnd()
--DoActions(i,SetDeaths(i,Subtract,1,111))



CIf(i,Score(i,Kills,AtLeast,1000))
CMov(i,ExchangeP,_Div(_Read(0x581F04+(i*4)),1000))
CAdd(i,{FP,ExScore[i+1][2],nil,"V"},_Div(_Read(0x581F04+(i*4)),1000))
CMov(i,0x581F04+(i*4),_Mod(_Read(0x581F04+(i*4)),1000))
CAdd(i,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,10),{FP,ExchangeRate[2],nil,"V"}))
CMov(i,ExchangeP,0)
CIfEnd()
DoActions(i,SetDeaths(i,Subtract,1,111))
end
NJumpEnd(Force1,0x1)








CJump(FP,0x0) -- 기타 init 지정공간
InstallCVariable()
CJumpEnd(FP,0x0)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()