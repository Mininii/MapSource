
PatchArr = {}
PatchArrPrsv = {}
CTrigPatchTable = {}
function SetToUnitDef(UnitID,Value)
table.insert(PatchArr,SetMemoryB(0x65FEC8 + UnitID,SetTo,Value))
end

function UnitSizePatch(UnitID,Value)
table.insert(PatchArr,SetMemory(0x6617C8 + (UnitID*8),SetTo,(Value)+(Value*65536)))
table.insert(PatchArr,SetMemory(0x6617CC + (UnitID*8),SetTo,(Value)+(Value*65536)))
end

function SetUnitClass(UnitID,Value)
table.insert(PatchArr,SetMemoryB(0x663DD0 + UnitID,SetTo,Value))
end

function DefTypePatch(UnitID,Value)
table.insert(PatchArr,SetMemoryB(0x662180 + UnitID,SetTo,Value))
end

function SetShield(UnitID)
table.insert(PatchArr,SetMemoryW(0x660E00 + (UnitID *2), SetTo, 1000))
table.insert(PatchArr,SetMemoryB(0x6647B0 + (UnitID), SetTo, 255))
end

function UnitEnable(UnitID)
table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,0))
table.insert(PatchArr,SetMemoryW(0x663888 + (UnitID *2),SetTo,0))
table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,1))
table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
end
function UnitEnable2(UnitID)
table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
end

function UnitEnable3(UnitID,Tick)
table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,Tick))
table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
end
function SetUnitDefUpType(UnitID,Value)
table.insert(PatchArr,SetMemoryB(0x6635D0 + UnitID,SetTo,Value))
end

function SetUnitAdvFlag(UnitID,Value,Mask)
table.insert(PatchArr,SetMemoryX(0x664080 + (UnitID*4),SetTo,Value,Mask))
end


function SetWepTargetFlags(WeaponID,Value)
table.insert(PatchArr,SetMemoryW(0x657998 + (WeaponID*2), SetTo, Value))
end

function WeaponTypePatch(WeaponID,Value)
table.insert(PatchArr,SetMemoryB(0x657258 + WeaponID,SetTo,Value))
end


function SetWepUpType(WeaponID,Value)
table.insert(PatchArr,SetMemoryB(0x6571D0 + WeaponID, SetTo, Value))
end

function SetUnitCost(UnitID,Cost)
table.insert(PatchArr,SetMemoryW(0x65FD00+(UnitID*2), SetTo, 0))
table.insert(PatchArr,SetMemoryW(0x663888+(UnitID*2), SetTo, Cost))
end

function SetUnitGrpToMarine(UnitID) -- ???????? ?????????? ??????????
table.insert(PatchArr,SetMemoryW(0x661FC0+(UnitID*2), SetTo, 0))
table.insert(PatchArr,SetMemoryW(0x663C10+(UnitID*2), SetTo, 415))
table.insert(PatchArr,SetMemoryW(0x661440+(UnitID*2), SetTo, 418))
table.insert(PatchArr,SetMemoryW(0x65FFB0+(UnitID*2), SetTo, 411))
table.insert(PatchArr,SetMemoryW(0x662BF0+(UnitID*2), SetTo, 414))
table.insert(PatchArr,SetMemoryW(0x663B38+(UnitID*2), SetTo, 407))
table.insert(PatchArr,SetMemoryW(0x661EE8+(UnitID*2), SetTo, 410))
table.insert(PatchArr,SetMemoryB(0x6644F8 + UnitID, SetTo, 78))
table.insert(PatchArr,SetMemoryW(0x662F88+(UnitID*2), SetTo, 13))
end
for j = 0, 6 do
	table.insert(PatchArr,Simple_CalcLoc("P"..j+1,0,0,32*10,32*10))
	end
function SetUnitClassType(UnitID,Type)
	if Type == 1 then 
		Class = 198
	else
		Class = 197
	end
	table.insert(PatchArr,SetMemoryB(0x6637A0 + UnitID,SetTo,0x02+0x08))
	table.insert(PatchArr,SetMemoryB(0x663DD0 + UnitID,SetTo,199))
end

function onInit_EUD()
	local LimitX, LimitC = CreateCCodes(2)
	local ShTStrPtr = Create_VTable(7)
	CIfOnce(FP,nil,{SetCVar(FP,CurrentSpeed[2],SetTo,4),SeTMemory(0x5124F0,SetTo,SpeedV[4])}) -- OnPluginStart
--	f_Read(FP,0x58F500,"X",SelHPEPD) -- ???????? ???????? ???? ???? ?????? V?? ????
--	f_Read(FP,0x58F504,"X",MarHPEPD) -- ???????? ???????? ???? ???? ?????? V?? ????
--	f_Read(FP,0x58F508,"X",SelShEPD) -- ???????? ???????? ???? ???? ?????? V?? ????
--	f_Read(FP,0x58F50C,"X",SelOPEPD) -- ???????? ???????? ???? ???? ?????? V?? ????
	--f_Read(FP,0x58F510,"X",UnitDataPtr) -- ???????? ???????? ???? ???? ?????? V?? ????
	f_Read(FP,0x58F528,"X",B_5_C) -- ???????? ???????? ???? ???? ?????? V?? ????
--	f_Read(FP,0x58F532,"X",XY_ArrHeader) -- ???????? ???????? ???? ???? ?????? V?? ????
	f_Read(FP,0x58F55C,"X",B_Id_C) -- ???????? ???????? ???? ???? ?????? V?? ????
	
	for i = 1, #HeroArr do
		table.insert(CTrigPatchTable,SetVArrayX(VArr(HeroVArr,i-1),"Value",SetTo,HeroArr[i]))
	end
	for i = 1, #ZergGndUArr do
		table.insert(CTrigPatchTable,SetVArrayX(VArr(ZergGndVArr,i-1),"Value",SetTo,ZergGndUArr[i]))
	end
	table.insert(CTrigPatchTable,SetCtrigX(FP,G_InputH[2],0x15C,0,SetTo,FP,0x500,0x15C,1,0))
	DoActionsX(FP,CTrigPatchTable,1)
	local VRet = CreateVar(FP)
	local VRet2 = CreateVar(FP)
	local VRet3 = CreateVar(FP)
	local VRet4 = CreateVar(FP)
	
	
	TMem(FP,UnitDataPtr,UnitDataPtrVoid)
	TMem(FP,XY_ArrHeader,XY_ArrHeaderVoid)
	local CurrentUID = CreateVar(FP)
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  ???? ?????? ?????? ???????? ?????? ????
	TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,58)},{SetCVar(FP,CurrentUID[2],Add,1),SetCVar(FP,QCUnits[2],Add,1)},{preserved}) -- ?? ?????? ?? ????????
	TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,181)},{SetCVar(FP,CurrentUID[2],Add,1)},{preserved}) -- Cantina = nil
	CMov(FP,VRet,CurrentUID,EPDF(0x664080)) -- SpecialAdvFlag
	CMov(FP,VRet2,CurrentUID,EPDF(0x662860)) --BdDim
	local TempHPBak = CreateVar(FP)
	f_Read(FP, _Add(CurrentUID,EPDF(0x662350)) , TempHPBak)
	CMovX(FP,VArr(MaxHPBackUp,CurrentUID),TempHPBak)
	f_LMovX(FP, WArr(MaxHPWarr,CurrentUID), {TempHPBak,0})
	
	f_Mod(FP,VRet3,CurrentUID,_Mov(2))
	f_Div(FP,VRet4,CurrentUID,_Mov(2))

	CTrigger(FP,{TDeathsX(VRet,Exactly,0x1,0,0x1)},{TSetDeaths(VRet2,SetTo,65537,0)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1
	CDoActions(FP,{TSetDeathsX(VRet,SetTo,0x200000,0,0x200000),}) -- All Unit SetTo Spellcaster
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,0)},{TSetDeathsX(_Add(VRet4,EPDF(0x661518)),SetTo,0x1C7,0,0x1C7)},1) -- Set All Units StarEdit Av Flags
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,1)},{TSetDeathsX(_Add(VRet4,EPDF(0x661518)),SetTo,0x1C7*0x10000,0,0x1C7*0x10000)},1) -- Set All Units StarEdit Av Flags
	CTrigger(FP,{TMemoryB(0x6647B0, CurrentUID, AtMost,0)},{TSetMemoryW(0x660E00, CurrentUID, SetTo, 0)},1) -- if Has Shield == 0 then Shield Amount = 0
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	CMov(FP,CurrentUID,0)
	table.insert(PatchArr,SetMemoryW(0x660E00+(173*2), SetTo, 10000)) -- ???????? ???? 1?????? ????

	GunList = {131,132,133,130,151,201,148,173,152,142,135,140,141,138,139,137}
	for j,k in pairs(GunList) do
		SetUnitAdvFlag(k,0x8000,0x8000)
	end
	
	
	for i = 0, 227 do
	SetUnitDefUpType(i,60) -- ???? ???? ????
	SetToUnitDef(i,0) -- ?????? ???? 0???? ???? 
	DefTypePatch(i,7) -- ???????? ???? 7?? ????
	SetUnitAdvFlag(i,0,0x4000) -- ???????? ?????????? ?????? ?? ?????? ????????
	end
	UnitEnable2(71)
	UnitEnable2(19)

	for i = 0, 129 do
	WeaponTypePatch(i,0) -- ???? ???? ???? 0???? ????(?????? ????)
	end
	PercentTable = {5,12,21,100,85,68,70,89,6,126,86,110,128,90}
	NormalClassTable = {84,30,47,77,78,28,17,21,27,86,88,80,25,76,79,220,150}
	PercentClassTable = {19,29,98,75,87,68,81,23,74,74,57,69,11}
	for j, k in pairs(PercentTable) do
		WeaponTypePatch(k,2) -- ???? ???? ????
	end
	for j, k in pairs(NormalClassTable) do
		SetUnitClassType(k)
	end
	for j, k in pairs(PercentClassTable) do
		SetUnitClassType(k,1)
	end

	

	

--roka7
function EffUnitPatch(UnitID)
	table.insert(PatchArr,SetMemoryB(0x6616E0 + UnitID,SetTo,130))
	table.insert(PatchArr,SetMemoryB(0x663238 + UnitID,SetTo,11)) -- ????
	UnitSizePatch(UnitID,1)
end
EffUnitPatch(203)
EffUnitPatch(204)
EffUnitPatch(205)
EffUnitPatch(206)
EffUnitPatch(207)
EffUnitPatch(208)
EffUnitPatch(209)
EffUnitPatch(210)
EffUnitPatch(211)
EffUnitPatch(212)
EffUnitPatch(94)
UnitSizePatch(84,1)
UnitSizePatch(60,1)
UnitSizePatch(121,10)

UnitSizePatch(12,5) -- ???? ???? 5*5 ????
-------
		table.insert(PatchArr,SetMemoryB(0x6564E0 + 21,SetTo,2))
	--0~6 ????????
	--8~14 ????????

		

	for i = 0, 6 do
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (i*2),SetTo,288)) -- ??????
	table.insert(PatchArr,SetMemoryW(0x655A40 + (i*2),SetTo,418)) -- ????
	table.insert(PatchArr,SetMemoryW(0x655700 + (i*2),SetTo,255)) -- ????????
	table.insert(PatchArr,SetMemoryW(0x655740 + (i*2),SetTo,0)) -- ????????????
	table.insert(PatchArr,SetMemoryW(0x6557C0 + (i*2),SetTo,0)) -- ?????????? 
	table.insert(PatchArr,SetMemoryW(0x655840 + (i*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x655940 + (i*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x655B80 + (i*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x6559C0 + (i*2),SetTo,AtkFactor)) -- ?????? ?????? ?????? 
	table.insert(PatchArr,SetMemoryB(0x655BFC + (i),SetTo,1)) -- ????(1??????)

	table.insert(PatchArr,SetMemoryW(0x655AC0 + ((8+i)*2),SetTo,377)) -- ??????
	table.insert(PatchArr,SetMemoryW(0x655A40 + ((8+i)*2),SetTo,426)) -- ????
	table.insert(PatchArr,SetMemoryW(0x655700 + ((8+i)*2),SetTo,255)) -- ????????
	table.insert(PatchArr,SetMemoryW(0x655740 + ((8+i)*2),SetTo,0)) -- ????????????
	table.insert(PatchArr,SetMemoryW(0x6557C0 + ((8+i)*2),SetTo,0)) -- ?????????? 
	table.insert(PatchArr,SetMemoryW(0x655840 + ((8+i)*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x655940 + ((8+i)*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x655B80 + ((8+i)*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x6559C0 + ((8+i)*2),SetTo,DefFactor)) -- ?????? ?????? ?????? 
	table.insert(PatchArr,SetMemoryB(0x655BFC + ((8+i)),SetTo,1)) -- ????(1??????)
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + (i*2),SetTo,5)) --????????
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + ((8+i)*2),SetTo,5)) --????????


	end

	table.insert(PatchArr,SetMemoryW(0x655AC0 + (17*2),SetTo,289)) -- ??????
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (18*2),SetTo,290)) -- ??????
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (19*2),SetTo,291)) -- ??????
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (20*2),SetTo,293)) -- ??????
	table.insert(PatchArr,SetMemoryW(0x655A40 + (17*2),SetTo,419)) -- ????
	table.insert(PatchArr,SetMemoryW(0x655A40 + (18*2),SetTo,420)) -- ????
	table.insert(PatchArr,SetMemoryW(0x655A40 + (19*2),SetTo,413)) -- ????
	table.insert(PatchArr,SetMemoryW(0x655A40 + (20*2),SetTo,412)) -- ????
	for i = 17, 20 do
	table.insert(PatchArr,SetMemoryW(0x655700 + (i*2),SetTo,255)) -- ????????
	table.insert(PatchArr,SetMemoryW(0x655740 + (i*2),SetTo,0)) -- ????????????
	table.insert(PatchArr,SetMemoryW(0x6557C0 + (i*2),SetTo,0)) -- ?????????? 
	table.insert(PatchArr,SetMemoryW(0x655840 + (i*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x655940 + (i*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x655B80 + (i*2),SetTo,0)) -- ??????????
	table.insert(PatchArr,SetMemoryW(0x6559C0 + (i*2),SetTo,0)) -- ?????? ?????? ?????? 
	table.insert(PatchArr,SetMemoryB(0x655BFC + (i),SetTo,1)) -- ????(1??????)
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + (i*2),SetTo,5)) --????????

	for j = 0, 6 do
	table.insert(PatchArr,SetMemoryB(0x58D088 + (j * 46) + i,SetTo,255))
	end
	end
	table.insert(PatchArr,SetMemory(0x58D718, SetTo, -1))
	table.insert(PatchArr,SetMemory(0x58D71C, SetTo, -1))
	
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (17), SetTo, 255))
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (21), SetTo, 255))
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (29), SetTo, 255))

	for i = 0, 6 do
	table.insert(PatchArr,SetMemory(0x5821A4 + (4*i),SetTo,GunLimit*2))
	table.insert(PatchArr,SetMemory(0x582144 + (4*i),SetTo,GunLimit*2))
	table.insert(PatchArr,SetMemory(0x5822C4 + (4*i),SetTo,1000))
	table.insert(PatchArr,SetMemory(0x582264 + (4*i),SetTo,1000))
	table.insert(PatchArr,SetMemoryB(0x6566F8 + (MarWep[i+1]),SetTo,3))
	table.insert(PatchArr,SetMemoryW(0x656888 + (MarWep[i+1]*2),SetTo,2))
	table.insert(PatchArr,SetMemoryW(0x6570C8 + (MarWep[i+1]*2),SetTo,6))
	table.insert(PatchArr,SetMemoryW(0x657780 + (MarWep[i+1]*2),SetTo,10))
	table.insert(PatchArr,SetMemoryB(0x58D088 + (i * 46) + i,SetTo,255))
	table.insert(PatchArr,SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,255))

		DefTypePatch(MarID[i+1],i) -- ?????? ?????????? P1???? P7???? ???????? ????
		SetUnitClass(MarID[i+1],199) -- ???? ????????. ?????????? ???? ????
		SetUnitClass(63,199) -- ???? ????????. ?????????? ???? ????
		SetUnitClass(10,199) -- ???? ????????. ?????????? ???? ????
		
		SetUnitClass(15,199) -- ?????? ??????????????
		SetUnitClass(74,199) -- ?????? ??????????????
		SetUnitClass(68,199) -- ?????? ??????????????
		SetUnitClass(87,199) -- ?????? ??????????????
		SetUnitClass(186,199) -- ?????? ??????????????
		SetUnitClass(12,199) -- ?????? ??????????????

		SetShield(MarID[i+1]) -- ???? ???? ????. ???? ?????? + ???? 1000 ????
		UnitSizePatch(MarID[i+1],5) -- ???? ???? 5*5 ????
		UnitEnable2(MarID[i+1])
		SetUnitGrpToMarine(MarID[i+1]) -- ???? ?????? ???? ???????? ????
		SetUnitAdvFlag(MarID[i+1],0x4000,0x4000) -- ???????? ?????? ?????? ????

		SetWepTargetFlags(MarWep[i+1],0x020 + 1 + 2) -- ???????? ???? ???? ?? ?????? ????
		SetWepUpType(MarWep[i+1],0+i) -- ???????? ?????????? ???? ???? ???? ????
		
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (MarWep[i+1]*2),SetTo,MarDamageAmount)) -- ??????????
		table.insert(PatchArr,SetMemoryW(0x657678 + (MarWep[i+1]*2),SetTo,MarDamageFactor)) -- ??????????
		table.insert(PatchArr,SetMemoryB(0x6564E0 + MarWep[i+1],SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x6616E0 + MarID[i+1],SetTo,MarWep[i+1])) -- ????????
		table.insert(PatchArr,SetMemoryB(0x6636B8 + MarID[i+1],SetTo,MarWep[i+1])) -- ????????
		table.insert(PatchArr,SetMemoryB(0x663238 + MarID[i+1],SetTo,11)) -- ????
		table.insert(PatchArr,SetMemory(0x657470 + (MarWep[i+1]*4) ,SetTo,32*7))
		table.insert(PatchArr,SetMemoryB(0x662DB8 + MarID[i+1],SetTo,7)) -- ??????????
	end
	SetUnitAdvFlag(7,0x4000,0x4000) -- ???????? ?????? ?????? ????
	SetUnitAdvFlag(10,0x4000,0x4000) -- ???????? ?????? ?????? ????
	SetUnitAdvFlag(125,0x4000,0x4000) -- ???????? ?????? ?????? ????
	SetUnitAdvFlag(126,0x4000,0x4000) -- ???????? ?????? ?????? ????
	SetUnitAdvFlag(12,0x4000,0x4000) -- ???????? ?????? ?????? ????
	SetUnitAdvFlag(124,0x4000,0x4000) -- ???????? ?????? ?????? ????
	SetWepTargetFlags(0,0x020 + 1 + 2) -- ???????? ???? ???? ?? ?????? ????
	SetWepTargetFlags(92,0x020 + 1 + 2) -- ???????? ???? ???? ?? ?????? ????
	SetWepTargetFlags(93,0x020 + 1 + 2) -- ???????? ???? ???? ?? ?????? ????

		table.insert(PatchArr,SetMemoryB(0x6564E0,SetTo,2))
		table.insert(PatchArr,SetMemoryW(0x656EB0,SetTo,NMarDamageAmount)) -- ??????????
		table.insert(PatchArr,SetMemoryW(0x657678,SetTo,NMarDamageFactor)) -- ??????????

		UnitEnable2(15)
		UnitEnable2(28)
		UnitEnable2(7)
		UnitEnable2(1)
	for i = 1, 4 do
		UnitEnable3(MedicTrig[i],i)
		SetUnitCost(MedicTrig[i],200+(i*50))
	end
	UnitEnable(72)
	UnitEnable(22)
	UnitEnable(29)
	UnitEnable(70)
	UnitEnable(64)
	UnitEnable(65)
	UnitEnable(66)
	UnitEnable(67)
	UnitEnable(68)
	UnitEnable(48)
	for i = 37, 45 do
		UnitEnable(i)
		
	end

	for i = 0, 6 do
		table.insert(PatchArr,SetMemoryB(0x57F27C+(228*i)+64,SetTo,0)) -- 9, 34 ?????????? ?????????? ???? ??????
		table.insert(PatchArr,SetMemoryB(0x57F27C+(228*i)+68,SetTo,0)) -- 9, 34 ?????????? ?????????? ???? ??????
		table.insert(PatchArr,SetMemoryB(0x57F27C+(228*i)+48,SetTo,0)) -- 9, 34 ?????????? ?????????? ???? ??????
		table.insert(PatchArr,SetMemoryB(0x663CE8 + MarID[i+1],SetTo,2))
	end
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 12,SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 28,SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 10,SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 15,SetTo,2))

	for i = 2, 116 do
	SetWepUpType(i,3)
	end
	SetWepUpType(92,59)
	SetWepUpType(93,59)

	local ZergArr = {37,38,39,45,44,43,48,49,56,55,53,57,51,54,104}
	for j, k in pairs(ZergArr) do
		
	--UnitSizePatch(k,3) -- ???? ???? ???? 10*10 ????
--	SetUnitAdvFlag(k,4,4) -- ????????????????
	end

	--UnitSizePatch(11,1)
	UnitSizePatch(ParseUnit("Protoss Arbiter"),1)
	--UnitSizePatch(63,5)
	--UnitSizePatch(52,5)
	--UnitSizePatch(62,1)

	for j, k in pairs(HeroArr) do
		if k ~= 86 then
		--UnitSizePatch(k,5)
		end
	end
	--UnitSizePatch(27,5)
	UnitSizePatch(7,1)

	for i = 220, 227 do
		DefTypePatch(i,9)
	end
	DefTypePatch(15,9)
	DefTypePatch(68,9)
	DefTypePatch(7,9)
	DefTypePatch(87,9)
	DefTypePatch(150,9)
	DefTypePatch(74,9)
	DefTypePatch(186,9)
	DefTypePatch(121,9)
	DefTypePatch(173,9)


	Trigger { -- ?????? ?????? ????
		players = {P8},
		actions = {
			SetMemory(0x515B88,SetTo,256);---------???? 0 ?????? P1 ?????? ????
			SetMemory(0x515B8C,SetTo,256);---------???? 1 ?????? P2 ?????? ????
			SetMemory(0x515B90,SetTo,256);---------???? 2 ?????? P3 ?????? ????
			SetMemory(0x515B94,SetTo,256);---------???? 3 ?????? P4 ?????? ????
			SetMemory(0x515B98,SetTo,256);---------???? 4 ?????? P5 ?????? ????
			SetMemory(0x515B9C,SetTo,256);---------???? 5 ?????? P6 ?????? ????
			SetMemory(0x515BA0,SetTo,256);---------???? 6 ?????? P7 ?????? ????
			SetMemory(0x515BA4,SetTo,256);---------???? 7 ?????? 
			SetMemory(0x515BA8,SetTo,256);---------???? 8 ??????
			SetMemory(0x515BAC,SetTo,0);---------???? 9 ?????? ?????? ?????? ?? ?????? 1?? ???????? ????????. 
			SetMemory(0x515BB0,SetTo,256);---------???? 0 ?????? P1 ?????? ????
			SetMemory(0x515BB4,SetTo,256);---------???? 1 ?????? P2 ?????? ????
			SetMemory(0x515BB8,SetTo,256);---------???? 2 ?????? P3 ?????? ????
			SetMemory(0x515BBC,SetTo,256);---------???? 3 ?????? P4 ?????? ????
			SetMemory(0x515BC0,SetTo,256);---------???? 4 ?????? P5 ?????? ????
			SetMemory(0x515BC4,SetTo,256);---------???? 5 ?????? P6 ?????? ????
			SetMemory(0x515BC8,SetTo,256);---------???? 6 ?????? P7 ?????? ????
			SetMemory(0x515BCC,SetTo,256*10);---------???? 7 ?????? ????????
			SetMemory(0x515BD0,SetTo,256*8);---------???? 8 ?????? ???? ???? ?????? ????
			SetMemory(0x515BD4,SetTo,256);---------???? 9 ??????	SCV, ?????? ???????????? ???? ????
			SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8????f
			SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 ??????
		},
	}
	DoActions2(FP,PatchArr,1) -- ?????? ???? ?????? ?????? ?????? ??????
	
	for i = 0, 6 do
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

	for k = 1, 7 do
		Trigger { -- ???? ????????, ?????? ????
			players = {Force1},
			conditions = {
				Label(0);
				CVar(FP,SetPlayers[2],Exactly,k);
			},
			actions = {
				SetMissionObjectives("\x13\x1F===================================\n\x13\n\x13\x04?????????? \x1F?????????????? ????????????\n\x13"..P[k].." \x07??????????????. \x0F?????? : \x04"..Ex1[k].."%\n\x13\x04?????? Insert?? ???? PgUp, PgDn ???? ???? \n\x13\x1F===================================");
				SetCVar(FP,ExchangeRate[2],SetTo,Ex1[k]);
				
			},
		}
	end
	
	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode),}) -- Limit????
	if TestStart == 1 then
		DoActions(FP,SetSwitch("Switch 230",Set))
	end

	for i = 0, 6 do -- ?????????? ?????????? ???????? ?????? ?????? ??????
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
			isname(i,"RonaRonaChan");
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
			isname(i,"(+=.=+)");
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
	}
	end

	T_YY = 2021
	T_MM = 12
	T_DD = 02
	T_HH = 00
	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end
	GlobalTime = os.time{year=T_YY, month=T_MM, day=T_DD, hour=T_HH }
	--PushErrorMsg(GlobalTime)
	DoActions(FP,{SetMemory(LimitVerPtr,SetTo,LimitVer)})
	if Limit == 1 then
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
	end
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,1,LimitX);
			CDeaths(FP,Exactly,0,LimitC);
			
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B?????? ???? ????????. ???????????? ????????????. \n\x13\x04???? ???? ???? 0x32223223 ????.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	
	Trigger { -- ????????
		players = {FP},
		conditions = {
			Memory(0x51CE84,AtLeast,1001);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B?? ???????? ???? ?????? ?????? ????????. \n\x13\x1B???? ???? ????????(????????)?? ?????? ????????????.\n\x13\x04???? ???? ???? 0x32223223 ????.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	for i = 0, 6 do
		Trigger { -- ????????
			players = {FP},
			conditions = {
				MemoryX(0x57EEE8 + 36*i,Exactly,1,0xFF);
			},
			actions = {
				RotatePlayer({
				DisplayTextX("\x13\x1B???? ???? ?????? ??????????????. ?????? ??????????.\n\x13\x04???? ???? ???? 0x32223223 ????.",4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1); -- ExitDrop
				SetMemory(0xCDDDCDDC,SetTo,1);
			}
		}
	end
	Trigger { -- ????????
		players = {FP},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,0,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B?????? ???? ?????? ??????????????. ???? ????????????.\n\x13\x04???? ???? ???? 0x32223223 ????.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	Trigger { -- ????????
		players = {FP},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,2,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B?????? ???? ?????? ??????????????. ???? ????????????.\n\x13\x04???? ???? ???? 0x32223223 ????.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	Trigger { -- ????????
		players = {FP},
		conditions = {
			MemoryX(0x57EEE0 + (36*7)+8,AtLeast,1*256,0xFF00);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B?????? ???? ?????? ??????????????. ???? ????????????.\n\x13\x04???? ???? ???? 0x32223223 ????.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	--		Trigger { -- ?????? ?????? ??
	--			players = {FP},
	--			conditions = {
	--				Memory(0x57F0B4, Exactly, 0);
	--		},
	--			actions = {
	--				RotatePlayer({
	--				DisplayTextX("\x13\x04?????????????? ???????? ?? ????????. ???????????? ????????????.\n\x13\x04???? ???? ???? 0x32223223 ????.",4);
	--				Defeat();
	--				},HumanPlayers,FP);
	--				Defeat();
	--				SetMemory(0xCDDDCDDC,SetTo,1);
	--		},
	--		}
	--	
		Trigger { -- ???? ?????????????
			players = {FP},
			conditions = {
				Label(0);
				Memory(0x57F0B4, Exactly, 0);
		},
			actions = {
				SetCDeaths(FP,SetTo,1,isSingle);
		},
		}
	--	
	local SinglePatch2 = {}
	local SinglePatch = {}
	for i = 0, 6 do
		table.insert(SinglePatch,SetMemoryB(0x57F27C + (i * 228) + 70,SetTo,0))
		table.insert(SinglePatch2,SetMemoryB(0x57F27C+(228*i)+64,SetTo,1)) -- 9, 34 ?????????? ?????????? ???? ??????
	end
	CIfX(FP,CDeaths(FP,AtLeast,1,isSingle))

		DoActions(FP,{
			SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8????f
			SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 ??????
			SetMemoryX(0x664080 + (MarID[1]*4),SetTo,0x8000,0x8000)
		})
	CElseX()
	DoActions(FP,SinglePatch)
	CIfXEnd()
	G_CB_init()
	DoActionsX(FP,SetCDeaths(FP,SetTo,200,PExitFlag))
	
	for i = 0, 6 do

	ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
	_0DPatchX(FP,Names[i+1],7)
	CS__ItoName(FP, SVA1(MarStr[i+1],3), i, nil, "\x0D", ColorCode[i+1])

	CS__InputVA(FP,PMariTbl[i+1],0,MarStr[i+1],MarStrs[i+1],nil,0,MarStrs[i+1]-3)


	end

	CbyteConvert(FP,VArr(HVA3,0),GetStrArr(0,"\x0D\x0D!H")) 
	f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
	f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
	f_GetStrXptr(FP,G_CA_StrPtr,"\x0D\x0D\x0DG_CA_Err".._0D)
	f_GetStrXptr(FP,G_CA_StrPtr2,"\x0D\x0D\x0DG_CA_Func".._0D)
	f_GetStrXptr(FP,G_CA_StrPtr3,"\x0D\x0D\x0DG_CA_SendError".._0D)


	
	f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
	f_GetStrXptr(FP,HTextStrPtr,HTextStr)
	for i = 0, 6 do
	f_GetStrXptr(FP,ShTStrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."shd".._0D)
	f_GetStrXptr(FP,PScoreSTrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."Score".._0D)
	f_GetStrXptr(FP,NukeUseStrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."Nuke".._0D)
	f_GetStrXptr(FP,AMUseStrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."AMatter".._0D)
	end
	f_GetStrXptr(FP,DBoss_PrintScore,"\x0D\x0D\x0DDBossSC".._0D)
	f_GetStrXptr(FP,DBoss_PrintScore2,"\x0D\x0D\x0DDBossDMG".._0D)
	f_GetStrXptr(FP,PointStrPtr,"\x0D\x0D\x0DGetP".._0D)
	f_GetStrXptr(FP,KillScStrPtr,"\x0D\x0D\x0DKillP".._0D)
	f_GetStrXptr(FP,StatusStrPtr1,"\x0D\x0D\x0DUStat".._0D)
	f_GetStrXptr(FP,HiScoreStrPtr,"\x0D\x0D\x0DHiSc".._0D)
	f_GetStrXptr(FP,NukeStrPtr,"\x0D\x0D\x0DNuke".._0D)
	f_GetStrXptr(FP,SupplyStrPtr,"\x0D\x0D\x0DSupp".._0D)
	f_GetStrXptr(FP,ArmorStrPtr,"\x0D\x0D\x0DArmor".._0D)
	f_GetStrXptr(FP,GiveStrPtr,"\x0D\x0D\x0DGive".._0D)
	f_GetStrXptr(FP,AHPStrPtr,"\x0D\x0D\x0DAHP".._0D)
	
	
	

	f_Memcpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2])
	--f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
	f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2])
	--f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
	f_Memcpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2])

	f_Memcpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])
	f_Memcpy(FP,G_CA_StrPtr,_TMem(Arr(f_GunErrT[3],0),"X","X",1),f_GunErrT[2])
	f_Memcpy(FP,G_CA_StrPtr2,_TMem(Arr(f_GunFuncT[3],0),"X","X",1),f_GunFuncT[2])
	f_Memcpy(FP,f_GunSendStrPtr,_TMem(Arr(f_GunSendT[3],0),"X","X",1),f_GunSendT[2])
	f_Memcpy(FP,G_CA_StrPtr3,_TMem(Arr(f_GunSendErrT[3],0),"X","X",1),f_GunSendErrT[2])

	CIfX(FP,CVar(FP,SetPlayers[2],AtLeast,2))
	f_Memcpy(FP,PointStrPtr,_TMem(Arr(StPT[3],0),"X","X",1),StPT[2])
	f_Memcpy(FP,KillScStrPtr,_TMem(Arr(KillPT[3],0),"X","X",1),KillPT[2])
	CElseX()
	f_Memcpy(FP,PointStrPtr,_TMem(Arr(SoloNoPointT[3],0),"X","X",1),SoloNoPointT[2])
	f_Memcpy(FP,KillScStrPtr,_TMem(Arr(SoloNoPointT[3],0),"X","X",1),SoloNoPointT[2])
	CIfXEnd()
	

	f_Memcpy(FP,StatusStrPtr1,_TMem(Arr(StatPT[3],0),"X","X",1),StatPT[2])
	f_Memcpy(FP,_Add(StatusStrPtr1,StatPT[2]+(5*4)),_TMem(Arr(DBossT2[3],0),"X","X",1),DBossT2[2])
	f_Memcpy(FP,_Add(StatusStrPtr1,StatPT[2]+(5*4)+DBossT2[2]+(5*4)),_TMem(Arr(DBossT3[3],0),"X","X",1),DBossT3[2])


	f_Memcpy(FP,HiScoreStrPtr,_TMem(Arr(HiScoreT1[3],0),"X","X",1),HiScoreT1[2])
	f_Memcpy(FP,_Add(HiScoreStrPtr,HiScoreT1[2]+(5*4)),_TMem(Arr(HiScoreT2[3],0),"X","X",1),HiScoreT2[2])
	f_Memcpy(FP,_Add(HiScoreStrPtr,StatPT[2]+(5*4)+HiScoreT2[2]+(5*4)),_TMem(Arr(DBossT3[3],0),"X","X",1),DBossT3[2])

	
	f_Memcpy(FP,NukeStrPtr,_TMem(Arr(NukeT[3],0),"X","X",1),NukeT[2])
	f_Memcpy(FP,_Add(NukeStrPtr,NukeT[2]+(5*4)),_TMem(Arr(NukeEndT[3],0),"X","X",1),NukeEndT[2])

	f_Memcpy(FP,AHPStrPtr,_TMem(Arr(EnemyHPT1[3],0),"X","X",1),EnemyHPT1[2])
	f_Memcpy(FP,_Add(AHPStrPtr,EnemyHPT1[2]+(5*4)),_TMem(Arr(EnemyHPT2[3],0),"X","X",1),EnemyHPT2[2])

	
	f_Memcpy(FP,SupplyStrPtr,_TMem(Arr(SupplyT[3],0),"X","X",1),SupplyT[2])
	f_Memcpy(FP,_Add(SupplyStrPtr,SupplyT[2]+(5*4)),_TMem(Arr(SupplyT2[3],0),"X","X",1),SupplyT2[2])
	f_Memcpy(FP,_Add(SupplyStrPtr,SupplyT[2]+(5*4)+SupplyT2[2]+(5*4)),_TMem(Arr(ShopEndT[3],0),"X","X",1),ShopEndT[2])


	f_Memcpy(FP,ArmorStrPtr,_TMem(Arr(ArmorT[3],0),"X","X",1),ArmorT[2])
	f_Memcpy(FP,_Add(ArmorStrPtr,ArmorT[2]+(5*4)),_TMem(Arr(ArmorT2[3],0),"X","X",1),ArmorT2[2])
	f_Memcpy(FP,_Add(ArmorStrPtr,ArmorT[2]+(5*4)+ArmorT2[2]+(5*4)),_TMem(Arr(ArmorT3[3],0),"X","X",1),ArmorT3[2])

	
	
	

	f_Memcpy(FP,_Add(f_GunStrPtr,f_GunT[2]+20),_TMem(Arr(Str24[3],0),"X","X",1),Str24[2])

	for i = 1, 7 do
	Install_CText1(PScoreSTrPtr[i],Str10,Str18,Names[i])
	Install_CText1(ShTStrPtr[i],Str12,Str13,Names[i])
	Install_CText1(NukeUseStrPtr[i],Str12,NukeUseT,Names[i])
	Install_CText1(AMUseStrPtr[i],Str12,AMUseT,Names[i])
	end

--	DoActions(FP,{GiveUnits(1,133,P8,11,0),GiveUnits(1,133,P8,12,1),GiveUnits(1,133,P8,13,2)})
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
			f_SaveCp()
			-- ?????????? ???? 8???????? ?????? ?????? ??????
			-- 0xYYYYXXXX 0xLLIIPPUU
			-- X = ???? X, Y = ???? Y, L = ???? ??????, I = ???? ??????, P = ????????ID, U = ????ID
			CunitHP = CreateVar(FP)
			CIf(FP,{TTMemory(_Add(BackupCp,6),NotSame,58)}) -- ?????? ??????
				f_Read(FP,_Sub(BackupCp,9),CPos)
				f_Read(FP,_Sub(BackupCp,17),CunitHP)
				f_Div(FP,CunitHP,_Mov(256))
				f_Read(FP,BackupCp,CunitP,"X",0xFF)
				f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
				CMov(FP,Gun_LV,0)
				CTrigger(FP,{TTOR({
					CVar(FP,RepHeroIndex[2],Exactly,133),
					CVar(FP,RepHeroIndex[2],Exactly,132),
					CVar(FP,RepHeroIndex[2],Exactly,131)
				}),CV(CunitHP,99,AtMost)},{TSetCVar(FP,Gun_LV[2],SetTo,CunitHP)},1)
--				CIf(FP,CVar(FP,RepHeroIndex[2],Exactly,133))
--				TriggerX(FP,{CVar(FP,CunitP[2],Exactly,0)},{SetCVar(FP,Gun_LV[2],SetTo,1)},{preserved})
--				TriggerX(FP,{CVar(FP,CunitP[2],Exactly,1)},{SetCVar(FP,Gun_LV[2],SetTo,2)},{preserved})
--				TriggerX(FP,{CVar(FP,CunitP[2],Exactly,2)},{SetCVar(FP,Gun_LV[2],SetTo,3)},{preserved})
--				DoActionsX(FP,SetCVar(FP,CunitP[2],SetTo,7))
--				CIfEnd()

				CMov(FP,0x6509B0,UnitDataPtr)
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
				CTrigger(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x04000000,0x04000000)},{SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0x10000)},1) -- 0x10000 ??????????

			CIfEnd()
			f_LoadCp()
		CIfEnd()
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
--	DoActions(FP,{GiveUnits(1,133,0,11,P8),GiveUnits(1,133,1,12,P8),GiveUnits(1,133,2,13,P8)})
	CMov(FP,RepHeroIndex,0)
	CWhile(FP,CVar(FP,RepHeroIndex[2],AtMost,227))
	--
	TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,58)},{SetCVar(FP,RepHeroIndex[2],Add,1)},{preserved}) -- ?????? ????
	CDoActions(FP,{
		TModifyUnitEnergy(All,RepHeroIndex,AllPlayers,64,0),
		TRemoveUnit(RepHeroIndex,AllPlayers),
		TRemoveUnit(RepHeroIndex,P9),
		TRemoveUnit(RepHeroIndex,P10),
		TRemoveUnit(RepHeroIndex,P11),
		TRemoveUnit(RepHeroIndex,P12)})
	CAdd(FP,RepHeroIndex,1)
	CWhileEnd()
	f_ArrReset()
	
	



	CIfEnd(SetMemory(0x6509B0,SetTo,FP)) -- OnPluginStart End
end

function onInit_EUD2()
	CIfOnce(FP)
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
		CallTrigger(FP,f_Replace)-- ???????? ?? ???? ?????????? ????
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	CIfEnd()
--	DoActions(FP, SetMemoryX(0x664080 + (111*4),SetTo,0,1), 1)
end