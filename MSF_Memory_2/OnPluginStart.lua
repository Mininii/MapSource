function init() -- �� ����� 1ȸ ���� Ʈ����
	
	PatchArr = {}
	PatchArrPrsv = {}
	CTrigPatchTable = {}
	function SetToUnitDef(UnitID,Value)
	table.insert(PatchArr,SetMemoryB(0x65FEC8 + UnitID,SetTo,Value))
	end

	function UnitSizePatch(UnitID,L,U,R,D)
	table.insert(PatchArr,SetMemory(0x6617C8 + (UnitID*8),SetTo,(L)+(U*65536)))
	table.insert(PatchArr,SetMemory(0x6617CC + (UnitID*8),SetTo,(R)+(D*65536)))
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
	
	function UnitEnable(UnitID,MinCost,GasCost,BuildTime,SuppCost,StartDistance)
		if StartDistance == nil then StartDistance = 5 end
	if StartDistance ~= "X" then
		table.insert(PatchArrPrsv,SetMemoryW(0x660A70 + (UnitID *2),SetTo,StartDistance))
	end
	table.insert(PatchArr,SetMemoryB(0x57F27C + (4 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (5 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
	if MinCost ~= nil then
	table.insert(PatchArr,SetMemoryW(0x663888 + (UnitID *2),SetTo,MinCost)) -- �̳׶�
	else
	table.insert(PatchArr,SetMemoryW(0x663888 + (UnitID *2),SetTo,0)) -- �̳׶�
	end
	if GasCost ~= nil then
	table.insert(PatchArr,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,GasCost)) -- ����
	else
	table.insert(PatchArr,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,0)) -- ����
	end
	if BuildTime ~= nil then
	table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,BuildTime)) -- ����ӵ�
	else
	table.insert(PatchArr,SetMemoryW(0x660428 + (UnitID *2),SetTo,1)) -- ����ӵ�
	end
	if SuppCost ~= nil then
	table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,SuppCost)) -- ����
	else
	table.insert(PatchArr,SetMemoryB(0x663CE8 + UnitID,SetTo,0)) -- ����
	end

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
	table.insert(PatchArr,SetMemoryW(0x663C10+(UnitID*2), SetTo, 466))
	table.insert(PatchArr,SetMemoryW(0x661440+(UnitID*2), SetTo, 469))
	table.insert(PatchArr,SetMemoryW(0x65FFB0+(UnitID*2), SetTo, 462))
	table.insert(PatchArr,SetMemoryW(0x662BF0+(UnitID*2), SetTo, 465))
	table.insert(PatchArr,SetMemoryW(0x663B38+(UnitID*2), SetTo, 457))
	table.insert(PatchArr,SetMemoryW(0x661EE8+(UnitID*2), SetTo, 461))
	table.insert(PatchArr,SetMemoryB(0x6644F8 + UnitID, SetTo, 77))
	table.insert(PatchArr,SetMemoryW(0x662F88+(UnitID*2), SetTo, 12))
	end

	function SetGroupFlags(UnitID,Value)
		table.insert(PatchArr,SetMemoryB(0x6637A0 + (UnitID),SetTo,Value))
	end
	for j, k in pairs(HeroPointArr) do
		if k[2]~=150 and k[2]~=176 and k[2]~=177 and k[2]~=178 then
		SetGroupFlags(k[2],0xA)
		SetUnitAdvFlag(k[2],0x40,0x8000+0x40)
		table.insert(PatchArr,SetMemoryB(0x660178 + (k[2]),SetTo,3))
		if k[4] == 1 then
			SetUnitClass(k[2],162) -- �۵�����
		else
			SetUnitClass(k[2],161) -- �Ϲ�����
		end
	end
	
BossUIDP = {87,74,5,2,64,12,82}
	for j, k in pairs(BossUIDP) do
		SetGroupFlags(k,0xA)
		UnitSizePatch(k,4,4,4,4)
		SetUnitAdvFlag(k,0x40,0x8000+0x40)
		table.insert(PatchArr,SetMemoryB(0x660178 + (k),SetTo,3))
		if k == 5 then
			SetUnitClass(k,161) -- �Ϲ�����
		else
			SetUnitClass(k,162) -- �۵�����
		end
	end
	UnitSizePatch(202,4,4,4,4)
	SetUnitClass(94,161) -- �۵�����

	SetUnitClass(11,162) -- �۵�����
	SetUnitClass(69,162) -- �۵�����
	SetGroupFlags(11,0xA)
	SetGroupFlags(69,0xA)
	table.insert(PatchArr,SetMemoryB(0x660178 + (11),SetTo,3))
	table.insert(PatchArr,SetMemoryB(0x660178 + (69),SetTo,3))
	SetUnitAdvFlag(11,0x40,0x8000+0x40)
	SetUnitAdvFlag(69,0x40,0x8000+0x40)
	


		table.insert(PatchArr,SetMemory(0x662350 + (k[2]*4),SetTo,k[5]))
		table.insert(PatchArr,SetMemoryW(0x660E00 + (k[2]*2),SetTo,k[6]))
		
	end
	table.insert(PatchArr,SetMemory(0x662350 + (131*4),SetTo,25000*256))
	table.insert(PatchArr,SetMemory(0x662350 + (132*4),SetTo,50000*256))
	table.insert(PatchArr,SetMemory(0x662350 + (133*4),SetTo,100000*256))
	SetGroupFlags(15,0x9)
	table.insert(PatchArr,SetMemoryB(0x57F27C + (1 * 228) + BanToken[1],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (2 * 228) + BanToken[1],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (2 * 228) + BanToken[2],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (3 * 228) + BanToken[1],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (3 * 228) + BanToken[2],SetTo,0))
	table.insert(PatchArr,SetMemoryB(0x57F27C + (3 * 228) + BanToken[3],SetTo,0))
	table.insert(PatchArr,SetMemoryW(0x6559C0+(7*2),SetTo,AtkUpgradeFactor)) -- ���� �̳׶� ������
	table.insert(PatchArr,SetMemoryW(0x6559C0+(0*2),SetTo,DefUpgradeFactor)) -- ü�� �̳׶� ������
	for i = 0, 227 do
	SetUnitDefUpType(i,60) -- ��� ���� ����
	SetToUnitDef(i,0) -- ���� ���� 0���� ���� 
	DefTypePatch(i,7) -- ���Ÿ�� ���� 7�� ����
	SetUnitAdvFlag(i,0,0x4000) -- ������� ���꽺�� �÷��� �� �κ�ƽ ��������
	end
	for i = 0, 129 do
	WeaponTypePatch(i,0) -- ���� Ÿ�� ���� 0���� ����(�氥�� ����)
	end
	PerWepArr = {8,12,27}
	for j, k in pairs(PerWepArr) do
		WeaponTypePatch(k,2)
	end
	WeaponTypePatch(84,2)--�����۵�
	WeaponTypePatch(6,2)--�����۵�
	for i = 63, 70 do
		UnitEnable(i) -- ���ݽ�����
	end
	SetUnitDefUpType(111,0)
	UnitSizePatch(55,9,9,9,9) 
	UnitSizePatch(56,9,9,9,9) 
	UnitSizePatch(62,9,9,9,9) 
	UnitSizePatch(17,11,11,11,11)
	UnitSizePatch(19,10,10,10,10)
	UnitSizePatch(77,8,4,8,10)
	UnitSizePatch(78,9,9,10,10)
	UnitSizePatch(52,8,8,8,8)
	UnitSizePatch(10,6,8,6,9)
	UnitSizePatch(76,8,8,9,9)
	UnitSizePatch(63,8,8,9,9)
	UnitSizePatch(21,4,4,4,4)
	UnitSizePatch(88,4,4,4,4)
	UnitSizePatch(28,4,4,4,4)
	UnitSizePatch(86,4,4,4,4)
	UnitSizePatch(22,4,4,4,4)
	UnitSizePatch(75,6,6,6,6)
	UnitSizePatch(79,7,7,7,7)
	UnitSizePatch(80,4,4,4,4)
	UnitSizePatch(25,10,10,10,10)
	UnitSizePatch(27,4,4,4,4)
	UnitSizePatch(102,4,4,4,4)
	UnitSizePatch(60,4,4,4,4)
	UnitSizePatch(30,1,1,1,1)
	UnitSizePatch(67,7,7,7,7)
	UnitSizePatch(71,4,4,4,4)
	UnitSizePatch(61,6,6,6,6)
	UnitSizePatch(29,4,4,4,4)
	UnitSizePatch(23,10,10,10,10)
	UnitSizePatch(81,10,10,10,10)
	UnitSizePatch(98,4,4,4,4)
	UnitSizePatch(68,8,8,9,9)
	UnitSizePatch(65,8,4,8,10)
	UnitSizePatch(66,9,9,10,10)
	UnitSizePatch(57,4,4,4,4)
	UnitSizePatch(8,4,4,4,4)
	UnitSizePatch(3,11,11,11,11)
	UnitSizePatch(70,4,4,4,4)
	UnitEnable(131) -- ����Disable
	UnitEnable(132) -- ����Disable
	UnitEnable(133) -- ����Disable

	
	UnitEnable(71,nil,nil,nil,nil,2) -- ���ݽ�����
	UnitEnable(2,nil,nil,nil,nil,2) -- ��ȯ
	UnitEnable(19,ShCost,nil,nil,nil,2) -- ������ȣ��
	UnitEnable(8,NMCost,nil,2,nil,2) -- ����
	UnitEnable(28,NMCost+HMCost+LMCost,nil,5,nil,2) -- ����
	UnitEnable(7,500,nil,nil,nil,2) -- SCV
	
	UnitEnable(125,8000)
	UnitEnable(124,4000)
	UnitEnable(109,1000)
	UnitEnable(22) -- ���
	UnitEnable(72) -- ����޵�
	UnitEnable(74,nil,nil,nil,nil,2) -- ��Ƽ��ž
	UnitEnable(75,nil,nil,nil,nil,2) -- ��ƼȦ��
	UnitEnable(60)
	UnitEnable(62)
	UnitEnable(23) -- �̷�ġ��� ON
	UnitEnable(61)
	UnitEnable(50) -- �÷���Ų
	UnitEnable(54) -- �÷���Ų
	UnitEnable(53) -- �÷���Ų
	

	for i= 0,3 do
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + GiveUnitID[i+1],SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 19,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 71,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 74,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 75,SetTo,0))
		table.insert(PatchArr,SetMemoryB(0x57F27C + (i * 228) + 2,SetTo,0))
			
	end

	for i = 1, 4 do
		
		UnitEnable(MedicTrig[i],200+(i*50),nil,i,nil,2) -- �޵�
		DefTypePatch(MarID[i],i-1) -- ������ ���Ÿ���� P1���� ���ʴ�� ���
		SetShield(MarID[i]) -- ���� ���� ����. ���� Ȱ��ȭ + ���� 1000 ����
		UnitSizePatch(MarID[i],7,10,7,11) -- ���� ũ�� ����
		UnitEnable(MarID[i],0,nil,5,nil,2)
		SetUnitGrpToMarine(MarID[i]) -- ���� �׷��� ���� �������� ����
		SetUnitAdvFlag(MarID[i],0x4000,0x4000) -- �÷��̾� ������ �κ�ƽ �ο�
		SetWepTargetFlags(MarWep[i],0x020 + 1 + 2) -- �÷��̾� ���� ���� �� �κ�ƽ ����
		--SetWepUpType(MarWep[i],i-1) -- �÷��̾� �������⿡ ���� �ٸ� ���� ����
		
		
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (0*2),SetTo,NMAtk)) -- �⺻���ݷ�
		table.insert(PatchArr,SetMemoryW(0x657678 + (0*2),SetTo,NMAtkFactor)) -- �߰����ݷ�
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (1*2),SetTo,HMAtk)) -- �⺻���ݷ�
		table.insert(PatchArr,SetMemoryW(0x657678 + (1*2),SetTo,HMAtkFactor)) -- �߰����ݷ�
		
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (MarWep[i]*2),SetTo,MarAtk)) -- �⺻���ݷ�
		table.insert(PatchArr,SetMemoryW(0x657678 + (MarWep[i]*2),SetTo,MarAtkFactor)) -- �߰����ݷ�
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (123*2),SetTo,MarAtk2)) -- �⺻���ݷ�
		table.insert(PatchArr,SetMemoryW(0x657678 + (123*2),SetTo,MarAtkFactor2)) -- �߰����ݷ�
		table.insert(PatchArr,SetMemoryW(0x656EB0 + (99*2),SetTo,GTAtk)) -- �⺻���ݷ�
		table.insert(PatchArr,SetMemoryW(0x657678 + (99*2),SetTo,GTAtkFactor)) -- �߰����ݷ�
		table.insert(PatchArr,SetMemoryB(0x6616E0 + MarID[i],SetTo,MarWep[i])) -- ���󹫱�
		table.insert(PatchArr,SetMemoryB(0x6636B8 + MarID[i],SetTo,MarWep[i])) -- ���߹���
	end
	DefTypePatch(20,9) -- 
	DefTypePatch(32,8) -- 
	DefTypePatch(124,5) -- 
	DefTypePatch(109,5) -- 
	DefTypePatch(125,4) -- 
if Limit == 1 then

	for i = 0, 516 do
		--table.insert(PatchArr,SetMemoryB(0x665C48+i,SetTo,1))
	end
end
CTable = {23,46,36,161}
for i = 0, 3 do
	table.insert(PatchArr,SetPlayerColor(i+4, SetTo, CTable[i+1]))
	table.insert(PatchArr,SetMinimapColor(i+4, SetTo, CTable[i+1]))
end
	
	table.insert(PatchArr,SetMemory(0x657A9C,SetTo,0)) -- ȭ�鲨Ʈ����
	DoActions2(FP,PatchArr,1)
	DoActions2(Force1,PatchArrPrsv)
	DoActions2X(FP,CTrigPatchTable,1)
	CIfOnce(FP)
	
	PLength = CreateVArrArr(4, 4, FP)
	for i = 0, 3 do
	TriggerX(FP,{HumanCheck(i,1)},{SetCVar(FP,SetPlayers[2],Add,1)})
--	GetPlayerName(FP, i, VArr(Names2[i+1],0))
	GetPlayerLength(FP,i,PLength[i+1]) 
	ItoName(FP,i,VArr(Names[i+1],0),ColorCode[i+1])
	f_GetTblptr(FP,MarTblPtr[i+1],MarID[i+1]+1)
	_0DPatchforVArr(FP,Names[i+1],4)
	Install_CText1(MarTblPtr[i+1],Str122,Str02[i+1],Names[i+1])
	f_GetStrXptr(FP,ShTStrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."Shield".._0D)
	f_GetStrXptr(FP,EEggStrPtr[i+1],"\x0D\x0D\x0D"..PlayerString[i+1].."EEgg".._0D)
	
	Install_CText1(ShTStrPtr[i+1],Str12,Str13,Names[i+1])
	Install_CText1(EEggStrPtr[i+1],Str12,EEggStr,Names[i+1])
	end
	

	f_GetTblptr(FP,AtkCondTblPtr,1413)
	f_GetTblptr(FP,HPCondTblPtr,1414)
	f_GetStrXptr(FP,HTextStrPtr,HTextStr)
	f_Memcpy(FP,AtkCondTblPtr,_TMem(Arr(AtkCondT[3],0),"X","X",1),AtkCondT[2])
	f_Memcpy(FP,HPCondTblPtr,_TMem(Arr(HPCondT[3],0),"X","X",1),HPCondT[2])
	ItoDec(FP,_Add(Level,1),VArr(LVVA,0),2,nil,0)
	f_Movcpy(FP,_Add(AtkCondTblPtr,AtkCondT[2]),VArr(LVVA,0),4*4)
	f_Movcpy(FP,_Add(HPCondTblPtr,HPCondT[2]),VArr(LVVA,0),4*4)
	G_init()
	G_CA_init()

	DoActionsX(FP,{SetCDeaths(FP,SetTo,Limit,LimitX),SetCDeaths(FP,SetTo,TestStart,TestMode)}) -- Limit����
	T_YY = 2022
	T_MM = 05
	T_DD = 11
	T_HH = 12
	if Limit == 1 then
		f_GetStrXptr(FP,CurCPStrPtr,"\x0d\x0d\x0dCurCPStrPtr : ".._0D)
		f_GetStrXptr(FP,ReadCPStrPtr,"\x0d\x0d\x0dReadCPStrPtr : ".._0D)
		DoActions(FP,{SetSwitch("Switch 253",Set)})
		DoActions(FP,{RotatePlayer({DisplayTextX(StrDesignX("\x04���� "..#G_CAPlot_Shape_InputTable.."���� ���� �����Ͱ� �ԷµǾ����ϴ�."),4)},HumanPlayers,FP)})
		Trigger2(FP,{},{RotatePlayer({DisplayTextX("\x13\x04���� \x07�׽�Ʈ ����\x04�� �̿����Դϴ�.\n\x13\x07�׽�Ʈ�� �������ּż� �����մϴ�. \n\x13\x04�׽�Ʈ�� �̿� ���� �Ⱓ�� "..T_YY.."�� "..T_MM.."�� "..T_DD.."�� "..T_HH.."�� �����Դϴ�."),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
        
	end
--	PushErrorMsg("\x04���� "..#G_CAPlot_Shape_InputTable.."���� ���� �����Ͱ� �ԷµǾ����ϴ�.")
function InputTesterID(Player,ID)
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			isname(Player,ID);
			CDeaths(FP,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,LimitC);
			
		}
	}
end
	for i = 0, 3 do -- �����ƴѵ� �÷��̾��� �ش��ϴ� �г��� ������ ��ƨ��
		InputTesterID(i,"GALAXY_BURST")
		InputTesterID(i,"LucasSpia")
		InputTesterID(i,"_Mininii")
		InputTesterID(i,"RonaRonaChan")
		InputTesterID(i,"+=.=+")
		InputTesterID(i,"UnusedTypeQ")
		InputTesterID(i,"DemonLanterns")
		InputTesterID(i,"UnusedTypeW")
		InputTesterID(i,"seeiogion")
		InputTesterID(i,"Hakuyou")
		InputTesterID(i,"cairan")
		InputTesterID(i,"Hybrid)_GOD60")
		InputTesterID(i,"lptime106")
		InputTesterID(i,"IIII(uood)IIIII")
		InputTesterID(i,"Azusawa_Kohane")
		
	end
	
	function PushErrorMsg(Message)
		_G["\n"..Message.."\n"]() 
	end
	GlobalTime = os.time{year=T_YY, month=T_MM, day=T_DD, hour=T_HH }
	--PushErrorMsg(GlobalTime)
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
				DisplayTextX(StrDesignX("\x1B�׽�Ʈ ���� ���Դϴ�. ���Ĺ������� �������ּ���.").."\n"..StrDesignX("\x04���� ���� �ڵ� 0x32223223 �۵�."),4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}
	
	Trigger { -- ��ӹ���
		players = {FP},
		conditions = {
			Memory(0x51CE84,AtLeast,1001);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(StrDesignX("\x1B�� ���񿡼� ��� �ɼ��� ������ �ֽʽÿ�.").."\n"..StrDesignX("\x1B�Ǵ� ���� �����ӵ�(�Ϸ���Ʈ)�� �ִ�� �÷��ֽʽÿ�.").."\n"..StrDesignX("\x04���� ���� �ڵ� 0x32223223 �۵�."),4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
		}
	}


	for i = 4, 7 do
		Trigger { -- ���ӿ���
			players = {FP},
			conditions = {
				MemoryX(0x57EEE8 + 36*i,Exactly,0,0xFF);
			},
			actions = {
				RotatePlayer({
				DisplayTextX(StrDesignX("\x1B��ǻ�� ���� ������ �����Ǿ����ϴ�. �ٽ� �������ּ���.").."\n"..StrDesignX("\x04���� ���� �ڵ� 0x32223223 �۵�."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);
			}
		}
		Trigger { -- ���ӿ���
			players = {FP},
			conditions = {
				MemoryX(0x57EEE8 + 36*i,Exactly,2,0xFF);
			},
			actions = {
				RotatePlayer({
					DisplayTextX(StrDesignX("\x1B��ǻ�� ���� ������ �����Ǿ����ϴ�. �ٽ� �������ּ���.").."\n"..StrDesignX("\x04���� ���� �ڵ� 0x32223223 �۵�."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);
			}
		}
		Trigger { -- ���ӿ���
			players = {FP},
			conditions = {
				MemoryX(0x57EEE0 + (36*i)+8,AtLeast,1*256,0xFF00);
			},
			actions = {
				RotatePlayer({
					DisplayTextX("\x13"..StrDesign("\x1B��ǻ�� ���� ������ �����Ǿ����ϴ�. �ٽ� �������ּ���.\n\x13\x04���� ���� �ڵ� 0x32223223 �۵�."),4);
				Defeat();
				},HumanPlayers,FP);
				Defeat();
				SetMemory(0xCDDDCDDC,SetTo,1);
			}
		}
	end

	Trigger { -- Ȥ�� �̱��̽Ű���?
	players = {FP},
	conditions = {
		Label(0);
		Memory(0x57F0B4, Exactly, 0);
},
	actions = {
		--SetCDeaths(FP,SetTo,1,isSingle);
			RotatePlayer({
			DisplayTextX(StrDesign("\x04�̱��÷��̷δ� �÷����� �� �����ϴ�. ��Ƽ�÷��̷� �������ּ���.\n\x13\x04���� ���� �ڵ� 0x32223223 �۵�."),4);
			Defeat();
			},HumanPlayers,FP);
			Defeat();
			SetMemory(0xCDDDCDDC,SetTo,1);
},
}
--	


	CbyteConvert(FP,VArr(HVA3,0),GetStrArr(0,"\x0D\x0D!H")) 

	local StarEditAvFlag = CreateVar(FP)
	local GroupFlagsPtr = CreateVar(FP)
	local ShieldAvPtr = CreateVar(FP)
	local ShieldAmPtr = CreateVar(FP)
	local WepTypePtr = CreateVar(FP)
	local SeekRangePtr = CreateVar(FP)
	local SeekRange = CreateVar(FP)
	local WepLength = CreateVar(FP)
	local TargetFlagPtr = CreateVar(FP)
	local MaskRet1 = CreateVar(FP)
	local MaskRet3 = CreateVar(FP)
	local MaskRet2 = CreateVar(FP)
	local MaskRet4 = CreateVar(FP)
	local MaskRet5 = CreateVar(FP)
	local MaskRet6 = CreateVar(FP)
	local MaskRet7 = CreateVar(FP)
	local MaskRet8 = CreateVar(FP)
	local DivNum4 = CreateVar(FP)
	local DivNum2 = CreateVar(FP)
	local DivNum2_2 = CreateVar(FP)
	local DivNum4_2 = CreateVar(FP)
	
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227)) --  ��� ���� ��ó��
	local Rep_Jump1 = def_sIndex()
	for j, k in pairs(Replace_JumpUnitArr) do
		NJumpX(FP,Rep_Jump1,{CVar(FP,CurrentUID[2],Exactly,k)})
	end

	f_Mod(FP,MaskRet1,CurrentUID,4)
	CMov(FP,MaskRet2,f_Sqrd(256,MaskRet1))
	f_Mod(FP,MaskRet3,CurrentUID,2)
	CMov(FP,MaskRet4,f_Sqrd(65536,MaskRet3))
	f_Div(FP,DivNum2,CurrentUID,_Mov(2))
	f_Div(FP,DivNum4,CurrentUID,_Mov(4))


	CMov(FP,SpecialAdvFlagPtr,CurrentUID,EPDF(0x664080)) -- SpecialAdvFlag
	CMov(FP,BdDimPtr,CurrentUID,EPDF(0x662860)) --BdDim
	

	CMov(FP,GroupFlagsPtr,DivNum4,EPDF(0x6637A0)) --GroupFlags
	CMov(FP,ShieldAvPtr,DivNum4,EPDF(0x6647B0)) --Has Shield
	CMov(FP,ShieldAmPtr,DivNum2,EPDF(0x660E00)) --Shield Amount
    CMov(FP,StarEditAvFlag,_Mul(CurrentUID,2),0x661518)
	

	local Temp1 = CreateVar(FP)
	local Temp2 = CreateVar(FP)
	f_Mul(FP,Temp1,MaskRet2,0x20)
	f_Mul(FP,Temp2,MaskRet2,0x9)

	ConvertArr(FP,ArrID,CurrentUID)
	CMov(FP,ArrX(BdDimArr,ArrID),_ReadF(BdDimPtr))
	f_Read(FP,_Add(CurrentUID,EPDF(0x662350)),ArrX(MaxHPBackUp,ArrID))
	CTrigger(FP,{TDeathsX(GroupFlagsPtr,Exactly,Temp2,0,Temp2)},{TSetMemoryX(GroupFlagsPtr,SetTo,Temp1,Temp1)},1) -- if Group ==Zerg And Unit then Set Group Factories
	CTrigger(FP,{TDeathsX(SpecialAdvFlagPtr,Exactly,0x1,0,0x1)},{TSetDeaths(BdDimPtr,SetTo,65537,0),TSetMemoryX(GroupFlagsPtr,SetTo,0,Temp1)},1) -- if Advanced Flags = Building then Building Dimensions SetTo 1x1, Remove Factories Flag
	CDoActions(FP,{TSetDeathsX(SpecialAdvFlagPtr,SetTo,0x200000,0,0x200000),}) -- All Unit SetTo Spellcaster
    Act_TSetMemoryW(StarEditAvFlag,SetTo,0x1C7,0x1C7)
--    CTrigger(FP,{CVar(FP,MaskRet3[2],Exactly,0)},{TSetDeathsX(StarEditAvFlag,SetTo,0x1C7,0,0x1C7)},1) -- Set All Units StarEdit Av Flags
--    CTrigger(FP,{CVar(FP,MaskRet3[2],Exactly,1)},{TSetDeathsX(StarEditAvFlag,SetTo,0x1C7*0x10000,0,0x1C7*0x10000)},1) -- Set All Units StarEdit Av Flags
	CTrigger(FP,{TMemoryX(ShieldAvPtr,Exactly,0,_Mul(MaskRet2,255))},{TSetDeathsX(ShieldAmPtr,SetTo,0,0,_Mul(MaskRet4,65535))},1) -- if Has Shield == 0 then Shield Amount = 0

	

	
	DoActionsX(FP,SetCD(BFlag,2))

	
	local SelClass = Act_BRead(_Add(CurrentUID,0x663DD0))

	CTrigger(FP,{CVar(FP,SelClass[2],Exactly,162)},{SetCD(BFlag,1)},1)
	local SelWepID = Act_BRead(_Add(CurrentUID,0x6636B8))



	NJumpX(FP,Rep_Jump1,CV(SelWepID,130))
	f_Mod(FP,MaskRet5,SelWepID,4)
	CMov(FP,MaskRet6,f_Sqrd(256,MaskRet5))
	f_Mod(FP,MaskRet7,SelWepID,2)
	CMov(FP,MaskRet8,f_Sqrd(65536,MaskRet7))
	f_Div(FP,DivNum2_2,SelWepID,_Mov(2))
	f_Div(FP,DivNum4_2,SelWepID,_Mov(4))


	CMov(FP,WepTypePtr,DivNum4_2,EPDF(0x657258))
	CTrigger(FP,{CD(BFlag,1)},{TSetMemoryX(WepTypePtr,SetTo,_Mul(MaskRet6,2),_Mul(MaskRet6,255))},1)
    CMov(FP,TargetFlagPtr,_Mul(SelWepID,2),0x657998)
    Act_TSetMemoryW(TargetFlagPtr,SetTo,3,3)

--	f_Read(FP,_Add(SelWepID,EPDF(0x657470)),WepLength)
--	CMov(FP,SeekRange,_Div(WepLength,32))
--	CMov(FP,0x57f120,SeekRange)--

--	CMov(FP,SeekRangePtr,DivNum4,EPDF(0x662DB8))
--	
--	CTrigger(FP,{},{TSetMemoryX(SeekRangePtr,SetTo,_Mul(MaskRet2,SeekRange),_Mul(MaskRet2,255))},1)
	
	
	NJumpXEnd(FP,Rep_Jump1)
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	CMov(FP,CurrentUID,0)






	
	

	
CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,4,0,0xFF)})
		-- ���������� ���� 8����Ʈ�� ������ �迭�� ������
		-- 0xYYYYXXXX 0xLLIIPPUU
		-- X = ��ǥ X, Y = ��ǥ Y, L = ���� �ĺ���, I = ���� �÷���, P = �÷��̾�ID, U = ����ID
		CAdd(FP,0x6509B0,6)
		
		local Rep_Jump4 = def_sIndex()
		for j, k in pairs(Replace_JumpUnitArr) do
			NJumpX(FP,Rep_Jump4,{DeathsX(CurrentPlayer,Exactly,k,0,0xFF)})
		end

		
		CSub(FP,0x6509B0,6)
		f_SaveCp()
			f_Read(FP,_Sub(BackupCp,9),CPos)
			f_Read(FP,_Sub(BackupCp,17),CunitHP)
			f_Read(FP,BackupCp,CunitP,"X",0xFF)
			f_Div(FP,CunitHP,_Mov(256))
			f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
			CMov(FP,Gun_LV,0)
			CTrigger(FP,{TTOR({
				CVar(FP,RepHeroIndex[2],Exactly,151),
				CVar(FP,RepHeroIndex[2],Exactly,133),
				CVar(FP,RepHeroIndex[2],Exactly,132),
				CVar(FP,RepHeroIndex[2],Exactly,131)})},{TSetCVar(FP,Gun_LV[2],SetTo,CunitHP)},1)
			CMov(FP,CunitIndex,_Div(_Sub(BackupCp,19025+19),_Mov(84)))
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
				CTrigger(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x04000000,0x04000000)},{SetDeathsX(CurrentPlayer,SetTo,0x10000,0,0x10000)},1) -- 0x10000 �����÷���
				CTrigger(FP,{TMemoryX(_Add(BackupCp,36),Exactly,0x40000000,0x40000000)},{SetDeathsX(CurrentPlayer,SetTo,0x20000,0,0x20000)},1) -- 0x20000 �ҷ���÷���
			--CDoActions(FP,{
			--	--TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(DUnitCalc[3],((0x20*8)/4))),SetTo,1),
			--	TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),DUnitCalc[3]),SetTo,Gun_LV)})
		f_LoadCp()
		CAdd(FP,0x6509B0,6)
		NJumpXEnd(FP,Rep_Jump4)
		CSub(FP,0x6509B0,6)
	CIfEnd()
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)})
	CAdd(FP,0x6509B0,6)
	f_SaveCp()
		f_Read(FP,BackupCp,RepHeroIndex)
		CDoActions(FP,{TSetDeaths(_Sub(BackupCp,23),SetTo,_Sub(_Read((_Add(RepHeroIndex,EPDF(0x662350)))),128),0)})
		
		CTrigger(FP,{TTOR({
			CVar(FP,RepHeroIndex[2],Exactly,200);
			CVar(FP,RepHeroIndex[2],Exactly,190);
			CVar(FP,RepHeroIndex[2],Exactly,173);
			CVar(FP,RepHeroIndex[2],Exactly,168);
			CVar(FP,RepHeroIndex[2],Exactly,152);
			CVar(FP,RepHeroIndex[2],Exactly,201);
		})},{
			TSetMemoryX(_Add(BackupCp,55-25),SetTo,0xB00,0xB00),
			TSetMemoryX(_Add(BackupCp,57-25),SetTo,0,0xFFFFFFFF),
			TSetMemoryX(_Add(BackupCp,37-25),SetTo,0,0xFF0000),
		},1)

	f_LoadCp()
	CSub(FP,0x6509B0,6)
	CIfEnd()

	CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)

CMov(FP,CurrentUID,0)
CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
local Rep_Jump2 = def_sIndex()
for j, k in pairs(Replace_JumpUnitArr) do
	NJumpX(FP,Rep_Jump2,{CVar(FP,CurrentUID[2],Exactly,k)})
end
CDoActions(FP,{
	TModifyUnitEnergy(All,CurrentUID,P5,64,0),
	SetCDeaths(FP,Add,1,CUnitRefrash);
	TRemoveUnit(CurrentUID,P5)})
NJumpXEnd(FP,Rep_Jump2)
CAdd(FP,CurrentUID,1)
CWhileEnd()
CDoActions(FP,{KillUnit(35,P5)})
TriggerX(FP,{},{RotatePlayer({RunAIScript(P8VON),RunAIScript(P7VON),RunAIScript(P6VON),RunAIScript(P5VON)},MapPlayers,FP)})
CIfEnd({SetMemory(0x6509B0,SetTo,FP)}) -- OnPluginStart End
end
function init_Start() -- ���� ���۽� 1ȸ ���� Ʈ����
	CIfOnce(FP)
	for k = 1, 4 do
	Trigger { -- �̼� ������Ʈ ����n��
		players = {FP},
		conditions = {
			Label(0);
			CVar(FP,SetPlayers[2],Exactly,k);
		},
		actions = {
			RotatePlayer({SetMissionObjectivesX("\x13\x04����Ű��� \x07�ͣ����� ��\n\x13"..Players[k].." \x17ȯ���� : \x1B"..ExRate[k].."%\n\x13\x04Marine + \x1F"..HMCost.." Ore\x04 = \x1BH \x04Marine\n\x13\x1BH \x04Marine + \x1F"..LMCost.." Ore \x04= \x08��\x11��\x03��\x18��\x08�� \x08��\x04������\n\x13\x04������������������������������������������������������������\n\x13\x04Thanks to : +=.=+, A..K, psc.Archive, CheezeNacho, LucasSpia, \n\x13\x04njjds148, lptime106, -Men-, Ninfia, NyanCats\n\x13\x04Spetial Thanks : Balexs")},HumanPlayers,FP);
			SetCVar(FP,ExRateV[2],SetTo,ExRate[k]);
			
		},
	}
	end
	CWhile(FP,CDeaths(FP,AtMost,3,CurPlace))
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0)) -- �迭���� �����Ͱ� �߰ߵ��� ���������� ��ȯ�Ѵ�.
	--	CIf(FP,{TDeathsX(_Add(BackupCp,1),Exactly,TestCheck,0,0xFF)})
		CallTrigger(FP,f_Replace)-- ������ȭ �� ���� ���ġ�ϴ� �ڵ�
	--	CIfEnd()
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	DoActionsX(FP,{SetCDeaths(FP,Add,1,CurPlace)})
	CWhileEnd()
	--CIfEnd()
	
	for i = 0, 3 do
		CMov(FP,0x5821D4+(i*4),EEggV)
		CAdd(FP,0x5821D4+(i*4),EEggV)
	end
	DoActions(P8,SetResources(Force1,SetTo,0,Gas),1)
	CMov(FP,CurrentUID,0)
	CWhile(FP,CVar(FP,CurrentUID[2],AtMost,227))
	local Rep_Jump3 = def_sIndex()
	for j, k in pairs(Replace_JumpUnitArr) do
		NJumpX(FP,Rep_Jump3,{CVar(FP,CurrentUID[2],Exactly,k)})
	end
	CMov(FP,BdDimPtr,CurrentUID,EPDF(0x662860)) --BdDim
	CMov(FP,SpecialAdvFlagPtr,CurrentUID,EPDF(0x664080)) -- SpecialAdvFlag
--	CTrigger(FP,{TDeathsX(SpecialAdvFlagPtr,Exactly,0x1,0,0x1)},{TSetMemoryX(SpecialAdvFlagPtr,SetTo,0,1)},1) -- if Advanced Flags = Building then Building = 0
	ConvertArr(FP,ArrID,CurrentUID)
	CDoActions(FP,{TSetMemory(BdDimPtr,SetTo,_ReadF(ArrX(BdDimArr,ArrID)))})
	NJumpEnd(FP,Rep_Jump3)
	CAdd(FP,CurrentUID,1)
	CWhileEnd()
	
	for i = 0, 3 do
		DoActions(i+4,{
			SetInvincibility(Disable,"Mineral Field (Type 1)",AllPlayers,"Anywhere");
			SetInvincibility(Disable,"Mineral Field (Type 2)",AllPlayers,"Anywhere");
			SetInvincibility(Disable,"Mineral Field (Type 3)",AllPlayers,"Anywhere");
			GiveUnits(All,"Mineral Field (Type 1)",P12,6+i,i);
			GiveUnits(All,"Mineral Field (Type 2)",P12,6+i,i);
			GiveUnits(All,"Mineral Field (Type 3)",P12,6+i,i);
			RunAIScript("Turn ON Shared Vision for Player 5");
			RunAIScript("Turn ON Shared Vision for Player 6");
			RunAIScript("Turn ON Shared Vision for Player 7");
			RunAIScript("Turn ON Shared Vision for Player 8");
			SetResources(CurrentPlayer,SetTo,10000000,OreAndGas);
			--SetMemory(0x582144 + (4 * (i+4)),SetTo,1600);
			--SetMemory(0x5821A4 + (4 * (i+4)),SetTo,1600);
			RunAIScriptAt("Expansion Zerg Campaign Insane",6+i);
			ModifyUnitEnergy(All,"Any unit",i,"Anywhere",100);
			SetCDeaths(FP,Add,1,CUnitRefrash);
			RunAIScriptAt("Value This Area Higher",2+i),ModifyUnitResourceAmount(All,P12,64,65535)},1)
	end

	
	CIfEnd({SetMemoryX(0x664080 + (162*4),SetTo,0,1)})
	DoActions(FP,GiveUnits(All,68,Force2,"Anywhere",P12),1)
end

