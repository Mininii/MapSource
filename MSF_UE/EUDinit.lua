
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

function SetUnitGrpToMarine(UnitID) -- �÷��̾� �������Ը� �����ϴ°�
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

function SetUnitClassType(UnitID,Type)
	if Type == 1 then 
		Class = 198
	else
		Class = 197
	end
	table.insert(PatchArr,SetMemoryB(0x6637A0 + UnitID,SetTo,0x02+0x08))
	table.insert(PatchArr,SetMemoryB(0x663DD0 + UnitID,SetTo,Class))
end

function onInit_EUD()
	local LimitX, LimitC = CreateCCodes(2)
	local ShTStrPtr = Create_VTable(7)
	CIfOnce(FP,nil,{SetCVar(FP,CurrentSpeed[2],SetTo,4),SeTMemory(0x5124F0,SetTo,SpeedV[4])}) -- OnPluginStart
	f_Read(FP,0x58F500,"X",SelHPEPD) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	f_Read(FP,0x58F504,"X",MarHPEPD) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	f_Read(FP,0x58F508,"X",SelShEPD) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	f_Read(FP,0x58F50C,"X",SelOPEPD) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	f_Read(FP,0x58F510,"X",UnitDataPtr) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	f_Read(FP,0x58F528,"X",B_5_C) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	f_Read(FP,0x58F532,"X",XY_ArrHeader) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	f_Read(FP,0x58F55C,"X",B_Id_C) -- �ø����� ���۹��� �ø� ���� �ּҸ� V�� �Է�
	
	for i = 1, #HeroArr do
		table.insert(CTrigPatchTable,SetVArrayX(VArr(HeroVArr,i-1),"Value",SetTo,HeroArr[i]))
	end
	for i = 1, #ZergGndUArr do
		table.insert(CTrigPatchTable,SetVArrayX(VArr(ZergGndVArr,i-1),"Value",SetTo,ZergGndUArr[i]))
	end

	DoActionsX(FP,CTrigPatchTable,1)
	local VRet = CreateVar(FP)
	local VRet2 = CreateVar(FP)
	local VRet3 = CreateVar(FP)
	local VRet4 = CreateVar(FP)
	local CurrentUID = CreateVar(FP)
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  ��� ������ ���м� �����Ƽ �÷��� ����
	TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,58)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- �� ��Ű�� �� ��������
	TriggerX(FP,{CVar(FP,CurrentUID[2],Exactly,181)},{SetCVar(FP,CurrentUID[2],Add,1)},{Preserved}) -- Cantina = nil
	CMov(FP,VRet,CurrentUID,EPD(0x664080))
	CMov(FP,VRet2,CurrentUID,EPD(0x662860))

	f_Read(FP,_Add(CurrentUID,EPD(0x662350)),VArr(MaxHPBackUp,CurrentUID))


	f_Mod(FP,VRet3,CurrentUID,_Mov(2))
	f_Div(FP,VRet4,CurrentUID,_Mov(2))

	CTrigger(FP,{TDeathsX(VRet,Exactly,0x1,0,0x1)},{TSetDeaths(VRet2,SetTo,65537,0)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1
	CDoActions(FP,{TSetDeathsX(VRet,SetTo,0x200000,0,0x200000),}) -- All Unit SetTo Spellcaster
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,0)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7,0,0x1C7)},1) -- Set All Units StarEdit Av Flags
	CTrigger(FP,{CVar(FP,VRet3[2],Exactly,1)},{TSetDeathsX(_Add(VRet4,EPD(0x661518)),SetTo,0x1C7*0x10000,0,0x1C7*0x10000)},1) -- Set All Units StarEdit Av Flags
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	CMov(FP,CurrentUID,0)

	for i = 0, 227 do
	SetUnitDefUpType(i,60) -- ��� ���� ����
	SetToUnitDef(i,0) -- ���� ���� 0���� ���� 
	DefTypePatch(i,7) -- ���Ÿ�� ���� 7�� ����
	SetUnitAdvFlag(i,0,0x4000) -- ������� ���꽺�� �÷��� �� �κ�ƽ ��������
	end
	UnitEnable2(71)
	UnitEnable2(19)

	for i = 0, 129 do
	WeaponTypePatch(i,0) -- ���� Ÿ�� ���� 0���� ����(�氥�� ����)
	end
	WeaponTypePatch(5,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(21,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(100,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(85,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(68,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(70,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(124,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(89,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(6,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(126,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(127,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(86,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(110,2) -- ���� Ÿ�� �۵�
	WeaponTypePatch(128,2) -- ���� Ÿ�� �۵�
	SetUnitClassType(19,1)
	SetUnitClassType(29,1)
	SetUnitClassType(98,1)
	SetUnitClassType(75,1)
	SetUnitClassType(87,1)
	SetUnitClassType(68,1)
	SetUnitClassType(84,1)
	SetUnitClassType(81,1)
	SetUnitClassType(23,1)
	SetUnitClassType(74,1)
	SetUnitClassType(74,1)
	SetUnitClassType(57,1)

	SetUnitClassType(47)
	SetUnitClassType(77)
	SetUnitClassType(78)
	SetUnitClassType(28)
	SetUnitClassType(17)
	SetUnitClassType(21)
	SetUnitClassType(27)
	SetUnitClassType(86)
	SetUnitClassType(88)
	SetUnitClassType(80)
	SetUnitClassType(25)
	SetUnitClassType(76)
	SetUnitClassType(79)
	SetUnitClassType(220)
	SetUnitClassType(150)
--roka7
function EffUnitPatch(UnitID)
	table.insert(PatchArr,SetMemoryB(0x6616E0 + UnitID,SetTo,130))
	table.insert(PatchArr,SetMemoryB(0x663238 + UnitID,SetTo,11)) -- �þ�
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
EffUnitPatch(94)
UnitSizePatch(84,1)
UnitSizePatch(60,1)

-------
		table.insert(PatchArr,SetMemoryB(0x6564E0 + 21,SetTo,2))
	--0~6 ������??
	--8~14 �����??

		

	for i = 0, 6 do
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (i*2),SetTo,288)) -- ������
	table.insert(PatchArr,SetMemoryW(0x655A40 + (i*2),SetTo,418)) -- �̸�
	table.insert(PatchArr,SetMemoryW(0x655700 + (i*2),SetTo,255)) -- �ƽ�����
	table.insert(PatchArr,SetMemoryW(0x655740 + (i*2),SetTo,0)) -- �̳׶����̽�
	table.insert(PatchArr,SetMemoryW(0x6557C0 + (i*2),SetTo,0)) -- ���������� 
	table.insert(PatchArr,SetMemoryW(0x655840 + (i*2),SetTo,0)) -- �������̽�
	table.insert(PatchArr,SetMemoryW(0x655940 + (i*2),SetTo,0)) -- �ð�������
	table.insert(PatchArr,SetMemoryW(0x655B80 + (i*2),SetTo,0)) -- �ð����̽�
	table.insert(PatchArr,SetMemoryW(0x6559C0 + (i*2),SetTo,AtkFactor)) -- �̳׶� ������ �߿��� 
	table.insert(PatchArr,SetMemoryB(0x655BFC + (i),SetTo,1)) -- ����(1����Ʈ)

	table.insert(PatchArr,SetMemoryW(0x655AC0 + ((8+i)*2),SetTo,377)) -- ������
	table.insert(PatchArr,SetMemoryW(0x655A40 + ((8+i)*2),SetTo,426)) -- �̸�
	table.insert(PatchArr,SetMemoryW(0x655700 + ((8+i)*2),SetTo,255)) -- �ƽ�����
	table.insert(PatchArr,SetMemoryW(0x655740 + ((8+i)*2),SetTo,0)) -- �̳׶����̽�
	table.insert(PatchArr,SetMemoryW(0x6557C0 + ((8+i)*2),SetTo,0)) -- ���������� 
	table.insert(PatchArr,SetMemoryW(0x655840 + ((8+i)*2),SetTo,0)) -- �������̽�
	table.insert(PatchArr,SetMemoryW(0x655940 + ((8+i)*2),SetTo,0)) -- �ð�������
	table.insert(PatchArr,SetMemoryW(0x655B80 + ((8+i)*2),SetTo,0)) -- �ð����̽�
	table.insert(PatchArr,SetMemoryW(0x6559C0 + ((8+i)*2),SetTo,DefFactor)) -- �̳׶� ������ �߿��� 
	table.insert(PatchArr,SetMemoryB(0x655BFC + ((8+i)),SetTo,1)) -- ����(1����Ʈ)
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + (i*2),SetTo,5)) --�䱸����
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + ((8+i)*2),SetTo,5)) --�䱸����


	end

	table.insert(PatchArr,SetMemoryW(0x655AC0 + (17*2),SetTo,289)) -- ������
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (18*2),SetTo,290)) -- ������
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (19*2),SetTo,291)) -- ������
	table.insert(PatchArr,SetMemoryW(0x655AC0 + (20*2),SetTo,293)) -- ������
	table.insert(PatchArr,SetMemoryW(0x655A40 + (17*2),SetTo,419)) -- �̸�
	table.insert(PatchArr,SetMemoryW(0x655A40 + (18*2),SetTo,420)) -- �̸�
	table.insert(PatchArr,SetMemoryW(0x655A40 + (19*2),SetTo,413)) -- �̸�
	table.insert(PatchArr,SetMemoryW(0x655A40 + (20*2),SetTo,412)) -- �̸�
	for i = 17, 20 do
	table.insert(PatchArr,SetMemoryW(0x655700 + (i*2),SetTo,255)) -- �ƽ�����
	table.insert(PatchArr,SetMemoryW(0x655740 + (i*2),SetTo,0)) -- �̳׶����̽�
	table.insert(PatchArr,SetMemoryW(0x6557C0 + (i*2),SetTo,0)) -- ���������� 
	table.insert(PatchArr,SetMemoryW(0x655840 + (i*2),SetTo,0)) -- �������̽�
	table.insert(PatchArr,SetMemoryW(0x655940 + (i*2),SetTo,0)) -- �ð�������
	table.insert(PatchArr,SetMemoryW(0x655B80 + (i*2),SetTo,0)) -- �ð����̽�
	table.insert(PatchArr,SetMemoryW(0x6559C0 + (i*2),SetTo,0)) -- �̳׶� ������ �߿��� 
	table.insert(PatchArr,SetMemoryB(0x655BFC + (i),SetTo,1)) -- ����(1����Ʈ)
	--table.insert(PatchArrPrsv,SetMemoryW(0x6558C0 + (i*2),SetTo,5)) --�䱸����

	for j = 0, 6 do
	table.insert(PatchArr,SetMemoryB(0x58D088 + (j * 46) + i,SetTo,255))
	end
	end

	table.insert(PatchArr,SetMemoryB(0x6647B0 + (17), SetTo, 255))
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (21), SetTo, 255))
	table.insert(PatchArr,SetMemoryB(0x6647B0 + (29), SetTo, 255))

	for i = 0, 6 do
	table.insert(PatchArr,SetMemory(0x5821A4 + (4*i),SetTo,GunLimit*2))
	table.insert(PatchArr,SetMemory(0x582144 + (4*i),SetTo,GunLimit*2))
	table.insert(PatchArr,SetMemory(0x5822C4 + (4*i),SetTo,1000))
	table.insert(PatchArr,SetMemory(0x582264 + (4*i),SetTo,1000))
	table.insert(PatchArr,SetMemoryB(0x6566F8 + (MarWep[i+1]),SetTo,3))
	table.insert(PatchArr,SetMemoryW(0x656888 + (MarWep[i+1]*2),SetTo,5))
	table.insert(PatchArr,SetMemoryW(0x6570C8 + (MarWep[i+1]*2),SetTo,15))
	table.insert(PatchArr,SetMemoryW(0x657780 + (MarWep[i+1]*2),SetTo,30))
	table.insert(PatchArr,SetMemoryB(0x58D088 + (i * 46) + i,SetTo,255))
	table.insert(PatchArr,SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,255))

		DefTypePatch(MarID[i+1],i) -- ������ ���Ÿ���� P1���� P7���� ���ʴ�� ���
		SetUnitClass(MarID[i+1],199) -- ���� ��޼���. ü�º��̰� �ϱ� ����
		SetShield(MarID[i+1]) -- ���� ���� ����. ���� Ȱ��ȭ + ���� 1000 ����
		UnitSizePatch(MarID[i+1],5) -- ���� ũ�� 5*5 ����
		UnitEnable2(MarID[i+1])
		SetUnitGrpToMarine(MarID[i+1]) -- ���� �׷��� ���� �������� ����
		SetUnitAdvFlag(MarID[i+1],0x4000,0x4000) -- �÷��̾� ������ �κ�ƽ �ο�

		SetWepTargetFlags(MarWep[i+1],0x020 + 1 + 2) -- �÷��̾� ���� ���� �� �κ�ƽ ����
		SetWepUpType(MarWep[i+1],0+i) -- �÷��̾� �������⿡ ���� �ٸ� ���� ����
		
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (MarWep[i+1]*2),SetTo,MarDamageAmount)) -- �⺻���ݷ�
		table.insert(PatchArr,SetMemoryW(0x657678 + (MarWep[i+1]*2),SetTo,MarDamageFactor)) -- �߰����ݷ�
		table.insert(PatchArr,SetMemoryB(0x6564E0 + MarWep[i+1],SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x6616E0 + MarID[i+1],SetTo,MarWep[i+1])) -- ���󹫱�
		table.insert(PatchArr,SetMemoryB(0x6636B8 + MarID[i+1],SetTo,MarWep[i+1])) -- ���߹���
		table.insert(PatchArr,SetMemoryB(0x662DB8 + MarID[i+1],SetTo,6)) -- �ΰ���Ÿ�
		table.insert(PatchArr,SetMemoryB(0x663238 + MarID[i+1],SetTo,11)) -- �þ�
		table.insert(PatchArr,SetMemory(0x657470 + (MarWep[i+1]*4) ,SetTo,192))
	end

		table.insert(PatchArr,SetMemoryB(0x6564E0,SetTo,2))
		table.insert(PatchArr,SetMemoryW(0x656EB0,SetTo,NMarDamageAmount)) -- �⺻���ݷ�
		table.insert(PatchArr,SetMemoryW(0x657678,SetTo,NMarDamageFactor)) -- �߰����ݷ�

		UnitEnable2(15)
		UnitEnable2(12)
		UnitEnable2(7)
		UnitEnable2(1)
	for i = 1, 4 do
		UnitEnable3(MedicTrig[i],i)
		SetUnitCost(MedicTrig[i],200+(i*50))
	end
	UnitEnable(72)
	UnitEnable(22)
	UnitEnable(70)
	for i = 0, 6 do
		table.insert(PatchArr,SetMemoryB(0x663CE8 + MarID[i+1],SetTo,2))
	end
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 12,SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 10,SetTo,2))
		table.insert(PatchArr,SetMemoryB(0x663CE8 + 15,SetTo,2))

	for i = 2, 116 do
	SetWepUpType(i,3)
	end

	UnitSizePatch(39,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(45,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(44,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(48,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(49,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(56,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(55,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(53,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(57,10) -- ���� ���� ũ�� 10*10 ����
	UnitSizePatch(11,1)
	UnitSizePatch(63,5)

	for j, k in pairs(HeroArr) do
		if k ~= 86 then
		UnitSizePatch(k,10)
		end
	end

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


	Trigger { -- �ۼ�Ʈ ������ ����
		players = {P8},
		actions = {
			SetMemory(0x515B88,SetTo,256);---------ũ�� 0 �Ϲ���
			SetMemory(0x515B8C,SetTo,256);---------ũ�� 1 �Ϲ���
			SetMemory(0x515B90,SetTo,256);---------ũ�� 2 �Ϲ���
			SetMemory(0x515B94,SetTo,256);---------ũ�� 3 �Ϲ���
			SetMemory(0x515B98,SetTo,256);---------ũ�� 4 �Ϲ���
			SetMemory(0x515B9C,SetTo,256);---------ũ�� 5 �Ϲ���
			SetMemory(0x515BA0,SetTo,256);---------ũ�� 6 �Ϲ���
			SetMemory(0x515BA4,SetTo,256);---------ũ�� 7 �Ϲ���
			SetMemory(0x515BA8,SetTo,256);---------ũ�� 8 �Ϲ���
			SetMemory(0x515BAC,SetTo,0);---------ũ�� 9 �Ϲ��� ���ʽ� �ڿ��� �� ������ 1�� ���� �����Ұ�. 
			SetMemory(0x515BB0,SetTo,256);---------ũ�� 0 ������ P1 �ͽõ� ����
			SetMemory(0x515BB4,SetTo,256);---------ũ�� 1 ������ P2 �ͽõ� ����
			SetMemory(0x515BB8,SetTo,256);---------ũ�� 2 ������ P3 �ͽõ� ����
			SetMemory(0x515BBC,SetTo,256);---------ũ�� 3 ������ P4 �ͽõ� ����
			SetMemory(0x515BC0,SetTo,256);---------ũ�� 4 ������ P5 �ͽõ� ����
			SetMemory(0x515BC4,SetTo,256);---------ũ�� 5 ������ P6 �ͽõ� ����
			SetMemory(0x515BC8,SetTo,256);---------ũ�� 6 ������ P7 �ͽõ� ����
			SetMemory(0x515BCC,SetTo,256*2);---------ũ�� 7 ������ �Ϲݸ���
			SetMemory(0x515BD0,SetTo,256*8);---------ũ�� 8 ������ ��Ŀ �ͷ� ������ ����
			SetMemory(0x515BD4,SetTo,256);---------ũ�� 9 ������	SCV, ������ �۵��������� ���� ����
			SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8�÷�f
			SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 �̴ϸ�
		},
	}
	DoActions2(FP,PatchArr,1) -- ������ ���� ���̺� ������ �ѹ��� ��°�
	local SetPlayers = CreateVar(FP)
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
		Trigger { -- �̼� ������Ʈ, ȯ���� ����
			players = {Force1},
			conditions = {
				Label(0);
				CVar(FP,SetPlayers[2],Exactly,k);
			},
			actions = {
				SetMissionObjectives("\x13\x1F===================================\n\x13\n\x13\x04����Ű��� \x1F�գ�̣���� �ţ������\n\x13"..P[k].." \x07�÷������Դϴ�. \x0Fȯ���� : \x04"..Ex1[k].."%\n\n\x13\x1F===================================");
				SetCVar(FP,ExchangeRate[2],SetTo,Ex1[k]);
				
			},
		}
	end
	
	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode)}) -- Limit����
	if TestStart == 1 then
		DoActions(FP,SetSwitch("Switch 230",Set))
	end

	for i = 0, 6 do -- �����ƴѵ� �÷��̾��� �ش��ϴ� �г��� ������ ��ƨ��
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

	YY = 2021
	MM = 7
	DD = 26
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
			Label(0);
			CDeaths(FP,Exactly,1,LimitX);
			CDeaths(FP,Exactly,0,LimitC);
			
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B�׽�Ʈ ���� ���Դϴ�. ���Ĺ������� �������ּ���. \n\x13\x04���� ���� �ڵ� 0x32223223 �۵�.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
	
	Trigger { -- ��ӹ���
		players = {FP},
		conditions = {
			Memory(0x51CE84,AtLeast,1001);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B�� ���񿡼� ��� �ɼ��� ������ �ֽʽÿ�. \n\x13\x1B�Ǵ� ���� �����ӵ�(�Ϸ���Ʈ)�� �ִ�� �÷��ֽʽÿ�.\n\x13\x04���� ���� �ڵ� 0x32223223 �۵�.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
	Trigger { -- ���ӿ���
		players = {FP},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,0,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B��ǻ�� ���� ������ �����Ǿ����ϴ�. �ٽ� �������ּ���.\n\x13\x04���� ���� �ڵ� 0x32223223 �۵�.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
	Trigger { -- ���ӿ���
		players = {FP},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,2,0xFF);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B��ǻ�� ���� ������ �����Ǿ����ϴ�. �ٽ� �������ּ���.\n\x13\x04���� ���� �ڵ� 0x32223223 �۵�.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
	Trigger { -- ���ӿ���
		players = {FP},
		conditions = {
			MemoryX(0x57EEE0 + (36*7)+8,AtLeast,1*256,0xFF00);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x1B��ǻ�� ���� ������ �����Ǿ����ϴ�. �ٽ� �������ּ���.\n\x13\x04���� ���� �ڵ� 0x32223223 �۵�.",4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDD,SetTo,1);
		}
	}
	--		Trigger { -- �̱��� �Ұ��� ��
	--			players = {FP},
	--			conditions = {
	--				Memory(0x57F0B4, Exactly, 0);
	--		},
	--			actions = {
	--				RotatePlayer({
	--				DisplayTextX("\x13\x04�̱��÷��̷δ� �÷����� �� �����ϴ�. ��Ƽ�÷��̷� �������ּ���.\n\x13\x04���� ���� �ڵ� 0x32223223 �۵�.",4);
	--				Defeat();
	--				},HumanPlayers,FP);
	--				Defeat();
	--				SetMemory(0xCDDDCDDD,SetTo,1);
	--		},
	--		}
	--	
		Trigger { -- Ȥ�� �̱��̽Ű���?
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
	CIf(FP,CDeaths(FP,AtLeast,1,isSingle))
		DoActions(FP,{
			SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8�÷�f
			SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 �̴ϸ�
		})
	CIfEnd()
	DoActionsX(FP,SetCDeaths(FP,SetTo,200,PExitFlag))


	for i = 0, 6 do
	ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
	_0DPatchX(FP,Names[i+1],7)
	end

	f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)
	f_GetStrXptr(FP,f_GunStrPtr,"\x0D\x0D\x0Df_Gun".._0D)
	f_GetStrXptr(FP,G_CA_StrPtr,"\x0D\x0D\x0DG_CA_Err".._0D)
	f_GetStrXptr(FP,G_CA_StrPtr2,"\x0D\x0D\x0DG_CA_Func".._0D)


	
	f_GetStrXptr(FP,f_GunSendStrPtr,"\x0D\x0D\x0Df_GunSend".._0D)
	f_GetStrXptr(FP,HTextStrPtr,HTextStr)
	for i = 0, 6 do
	f_GetStrXptr(FP,ShTStrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."shd".._0D)
	f_GetStrXptr(FP,PScoreSTrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."Score".._0D)
	end
	f_GetStrXptr(FP,DBoss_PrintScore,"\x0D\x0D\x0DDBossSC".._0D)
	f_GetStrXptr(FP,DBoss_PrintScore2,"\x0D\x0D\x0DDBossDMG".._0D)


	Print_All_CTextString(FP)
	f_MemCpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2])
	--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
	f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2])
	--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
	f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2])

	f_MemCpy(FP,f_GunStrPtr,_TMem(Arr(f_GunT[3],0),"X","X",1),f_GunT[2])
	f_MemCpy(FP,G_CA_StrPtr,_TMem(Arr(f_GunErrT[3],0),"X","X",1),f_GunErrT[2])
	f_MemCpy(FP,G_CA_StrPtr2,_TMem(Arr(f_GunFuncT[3],0),"X","X",1),f_GunFuncT[2])
	f_MemCpy(FP,f_GunSendStrPtr,_TMem(Arr(f_GunSendT[3],0),"X","X",1),f_GunSendT[2])

	f_MemCpy(FP,_Add(f_GunStrPtr,f_GunT[2]+20),_TMem(Arr(Str24[3],0),"X","X",1),Str24[2])

	for i = 1, 7 do
	Install_CText1(PScoreSTrPtr[i],Str10,Str18,Names[i])
	Install_CText1(ShTStrPtr[i],Str12,Str13,Names[i])
	end


	DoActions(FP,{GiveUnits(1,133,P8,11,0),GiveUnits(1,133,P8,12,1),GiveUnits(1,133,P8,13,2)})
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
			f_SaveCp()
			-- ���������� ���� 8����Ʈ�� ������ �迭�� ������
			-- 0xYYYYXXXX 0xLLIIPPUU
			-- X = ��ǥ X, Y = ��ǥ Y, L = ���� �ĺ���, I = ���� �÷���, P = �÷��̾�ID, U = ����ID
			CIf(FP,{TTMemory(_Add(BackupCp,6),NotSame,58)}) -- ��Ű�� ������
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
				CTrigger(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x04000000,0x04000000)},{SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0x10000)},1) -- 0x10000 �����÷���

			CIfEnd()
			f_LoadCp()
		CIfEnd()
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	DoActions(FP,{GiveUnits(1,133,0,11,P8),GiveUnits(1,133,1,12,P8),GiveUnits(1,133,2,13,P8)})
	CMov(FP,RepHeroIndex,0)
	CWhile(FP,CVar(FP,RepHeroIndex[2],AtMost,227))
	TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,58)},{SetCVar(FP,RepHeroIndex[2],Add,1)},{Preserved}) -- ��Ű�� ����
	CDoActions(FP,{TModifyUnitEnergy(All,RepHeroIndex,AllPlayers,64,0),TRemoveUnit(RepHeroIndex,AllPlayers),TRemoveUnit(RepHeroIndex,P9),TRemoveUnit(RepHeroIndex,P10),TRemoveUnit(RepHeroIndex,P11),TRemoveUnit(RepHeroIndex,P12)})
	CAdd(FP,RepHeroIndex,1)
	CWhileEnd()
	f_ArrReset()
	CIfEnd(SetMemory(0x6509B0,SetTo,FP)) -- OnPluginStart End
end

function onInit_EUD2()
	CIfOnce(FP)
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
		CallTrigger(FP,f_Replace)-- ������ȭ �� ���� ���ġ�ϴ� �ڵ�
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	CIfEnd()
end