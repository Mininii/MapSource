function PlayerInterface()
	local AtkFactorV = Create_VTable(7,AtkFactor,FP)
	local DefFactorV = Create_VTable(7,DefFactor,FP)
	local AtkFactorV2 = Create_VTable(7,nil,FP)
	local DefFactorV2 = Create_VTable(7,nil,FP)
	local MarHP = Create_VTable(7,nil,FP)
	local MarHP2 = Create_VTable(7,nil,FP)
	local DefUpCompCount = Create_VTable(7,nil,FP)
	local AtkUpCompCount = Create_VTable(7,nil,FP)
	local CurrentHP = Create_VTable(7,nil,FP)
	local MarMaxHP = Create_VTable(7,10000*256,FP)
	local P_Armor = Create_VTable(7,nil,FP)
	
	local AtkUpgradeMaskRetArr,AtkUpgradePtrArr,NormalUpgradeMaskRetArr,
	NormalUpgradePtrArr,DefUpgradeMaskRetArr,DefUpgradePtrArr,AtkFactorMaskRetArr,
	AtkFactorPtrArr,DefFactorMaskRetArr,DefFactorPtrArr,MarShMaskRetArr,MarShPtrArr = CreateTables(12)
	local SelUID = CreateVar(FP)
	local BarRally = CreateVarArr(7,FP)
	local MulCon = CreateVarArr(7,FP)
	local ExchangeP = CreateVar(FP)
	local MarTempSh = CreateVar(FP)
	local DelayMedic = Create_CCTable(7)
	local ShUsed = Create_CCTable(7)
	local OrderCool = CreateCcodeArr(7)
	local AvailableStat = Create_VTable(7,nil,FP)
	local CurrentStat = Create_VTable(7,nil,FP)
	local MaxLevel = Create_VTable(7,nil,FP)
	local MaxScore = Create_VTable(7,nil,FP)
	local SuSpeed = Create_VTable(7,nil,FP)
	local MarAtkC = Create_VTable(7,nil,FP)
	local MarAtkL = Create_VTable(7,nil,FP)
	local MenuPtr = Create_VTable(7,nil,FP)
	local AHP = Create_VTable(7,nil,FP)
	
	local MarCreate = Create_CCTable(7)
	local MarCreate2 = Create_CCTable(7)
	local UpSELemit = Create_CCTable(7)
	local CreateSu = CreateCcodeArr(7)
	local SuSkill = CreateCcodeArr(7)
	local BHSkill = CreateCcodeArr(7)
	local SkillUnit = CreateCcodeArr(7)
	local BSkillT = CreateCcodeArr(7)
	local NukeCool = CreateCcodeArr(7)
	local SuPtr = CreateVarArr(7,FP)
	local BHPtr = CreateVarArr(7,FP)
	local BattleHeal = CreateVarArr(7,FP)
	local AMatter = CreateVarArr(7,FP)
	local TempPtr = CreateVar(FP)
	local TempPtr2 = CreateVar(FP)
	local TempStat = CreateVar(FP)
	local TempStat2 = CreateVar(FP)
	local AmX = CreateVar(FP)
	local AmY = CreateVar(FP)
	local TempGiveV = CreateVar(FP)
	local TempGivePV = CreateVar(FP)
	local AmT = CreateCcodeArr(7)
	local GiveVA = CreateVArray(FP,7)
	local AutoStim = CreateCcodeArr(7)
	local AutoHeal = CreateCcodeArr(7)
	local MarDetector = CreateCcodeArr(7)
	local AutoStimT = CreateCcodeArr(7)
	local AutoHealT = CreateCcodeArr(7)
	local ArmorT3 = CreateCcodeArr(7)
	local SuHeal = CreateCcodeArr(7)
	local TelCool = CreateCcodeArr(7)
	local TelCool2 = CreateCcodeArr(7)
	local ShopSw = CreateCcodeArr(7)

	
	local BEff = CreateCcode()
	local NsW = CreateCcode()
	
	
	if TestStart == 1 then
		DoActionsX(FP,SetCDeaths(FP,SetTo,1,CreateSu[1]))
	end

	--����
	local Nukes = CreateVarArr(7,FP)
	local Supply = {}
	for i = 1, 7 do
		Supply[i] = CreateVar2(FP,nil,nil,24*3)
	end
	local MultiCommand = CreateCcodeArr(7)
	local MultiStimPack = CreateCcodeArr(7)
	local TeamEnchant = CreateCcode()
	MarACMaskRetArr = {}
	MarACPtrArr = {}
	for i = 0, 6 do
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
		table.insert(MarShMaskRetArr,(0x660E00 + (MarID[i+1]*2))%4)
		table.insert(MarShPtrArr,0x660E00 + (MarID[i+1]*2) - (MarShMaskRetArr[i+1]))
		table.insert(MarACMaskRetArr,(0x662DB8 + MarID[i+1])%4)
		table.insert(MarACPtrArr,0x662DB8 + MarID[i+1] - MarACMaskRetArr[i+1])
	end

	local InsertKey = {}
	InsertKey[1] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04�� ���� Ŭ������ ������ ������ \n\x13\x08���� ���� \x04�� \x1F�޼��� �ܰ�\x04�� \x07���ھ�(����)\x04�� ������ ������ ��Ÿ���ϴ�.\n\x13\x04����� �Ѱ踦 ������ ������!\n\x13\x07�̷������� ���� ���� �ܰ�� ���׷��̵�\x04�� �����մϴ�.\n\x13\x04255 ���׷��̵� �Ϸ� �� \x1F0���� ���� �� ���� ���ݷ��� �״�� ���µ˴ϴ�.\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04���ռҴ� �߾� ���� ������ �ִ°����� ���ø� �˴ϴ�.\n\x13\x04PgUp, PgDn Ű�� ���� �������� �ٲ� �� �ֽ��ϴ�.\n\x13\x04�������������������������������������������������� Page 1/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	InsertKey[2] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04\x1CSCArchive \x04���� (���Ǵ� ����ī�� ã���ּ���.)\n\x13\x04���� ���尡�� �����ʹ� \x11�ְ���(Level, Score)\x04�� \x19���� ����Ʈ \x04�Դϴ�. �׿� \x08���� �Ұ����մϴ�.\n\x13\x04���� ����Ʈ�� �پ��� �̷ο� ȿ���� ���� �� �ֽ��ϴ�.\n\x13\x07��, \x0F32Bit ȯ�� \x04��Ÿũ����Ʈ������ �̿��Ͻ� �� ������\n\x13\x07 ������ �ε�� \x1D1 Level \x04�������������� �����մϴ�.\n\x13\x04�����͸� �ҷ����� ���ߴٸ� ���� ������� ����帳�ϴ�.\n\x13\x07������ ����\x04�� �� �������� Ŭ����� \x07�ڵ�����˴ϴ�. \x04�Ǵ� \x18�������� \x04�����մϴ�.\n\n\x13\x04�������������������������������������������������� Page 2/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	InsertKey[3] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04��������Ʈ ������ ������ ���۳��̵��� ���� �޶����ϴ�.\n\x13\x04\x0E�ţ���\x04 = ������X \x0F�Σ�����\x04 = +5\n\x13\x04\x08�ȣ���\x04 = +10 \x10�ɣ�����\x04 = +15\n\x13\x04���� ������ Ŭ������ ���������� ��ġ�� �ջ�Ǿ� �������ϴ�.\n\x13\x04\n\x13\x04Ex) 8�������� Ŭ���� + \x08�ȣ���\x04���̵� = 8 + 10 = +18 ����\n\x13\x04\n\x13\x04��, ���� ���̵����� ������ ���� �� ���� ��������Ʈ�� ���� �� �ֽ��ϴ�.\n\x13\x04�������������������������������������������������� Page 3/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	local InsertPage = CreateCcode()
	local KeyToggle = CreateCcode()
	--

--	PlayerInfoT = "\x12\x10�� \x08Y\x04our \x0FL\x04evel :\x1F 0000000000 \x04�� Score :\x07 0000000000 \x04�� \x07StatPoint \x04: 0000000000 / 0000000000 \x10��"
--	PlayerItemT = "\x12\x10�� \x0FI\x04tems �� \x0E�ۼ�Ʈ \x1E���� : 000 / 255 \x04�� �� ü�� ��ȭ : 000 / 255 \x04�� ���� : F9\x10��"
--	--

--	function InterfaceFunc() 
--		CA__SetValue(Str1,PlayerInfoT,nil,0) 
--		--CA__ItoCustom(SVA1(Str1,0),TimeV,nil,nil,{10,6},1,{"\x07��","\x07��","\x0F��","\x0F��","\x1F��","\x1F��"},nil,{0x07,0x07,0x0F,0x0F,0x1F,0x1F},{11,12,14,15,17,18})
--		CA__InputVA(102*0,Str1,Str1s,nil,102*0,102*1-3)
--		CA__SetValue(Str1,MakeiStrVoid(100),0xFFFFFFFF,0) 
--		CA__SetValue(Str1,PlayerItemT,nil,0) 
--		CA__InputVA(102*1,Str1,Str1s,nil,102*1,102*2-3)
--		CA__SetValue(Str1,MakeiStrVoid(100),0xFFFFFFFF,0) 
--	end
--CAPrint(iStr1,{Force1},{1,0,0,0,1,3,0,0},"InterfaceFunc",FP,{LocalPlayerID(6,AtMost)}) --

	for i = 0, 6 do
		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,i)},{preserved})
	end

	Trigger2X(FP,{Deaths(CurrentPlayer,AtLeast,1,CPConsole),MemoryX(0x596A38, Exactly, 0x00000100,0x100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
	PlayWAV("sound\\Misc\\Buzz.wav"),},{preserved})
	Trigger2X(FP,{Deaths(CurrentPlayer,AtLeast,1,CPConsole),MemoryX(0x596A38, Exactly, 0x00010000,0x10000),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
	PlayWAV("sound\\Misc\\Buzz.wav"),},{preserved})
	Trigger2X(FP,{Deaths(CurrentPlayer,AtLeast,1,CPConsole),Memory(0x596A44, Exactly, 0x00000100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,KeyToggle),PlayWAV("sound\\Misc\\Buzz.wav"),
	PlayWAV("sound\\Misc\\Buzz.wav"),},{preserved})
	



	CIfX(FP,{Deaths(CurrentPlayer,Exactly,0,CPConsole)})
	Trigger2X(FP,{Switch("Switch 240",Set);MemoryX(0x596A38, Exactly, 0x00000100,0x100),CDeaths(FP,Exactly,0,KeyToggle),CDeaths(FP,AtMost,1,InsertPage)},{SetCDeaths(FP,Add,1,InsertPage),SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{preserved})
	Trigger2X(FP,{Switch("Switch 240",Set);MemoryX(0x596A38, Exactly, 0x00010000,0x10000),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,Subtract,1,InsertPage),SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{preserved})
	Trigger2X(FP,{Switch("Switch 240",Set);Memory(0x596A44, Exactly, 0x00000100),CDeaths(FP,Exactly,0,KeyToggle)},{SetCDeaths(FP,SetTo,1,DeleteToggle),SetCDeaths(FP,SetTo,1,KeyToggle)},{preserved})
	for i = 0, 2 do
	Trigger2X(FP,{CDeaths(FP,Exactly,i,InsertPage),CDeaths(FP,Exactly,1,DeleteToggle)},{DisplayText(InsertKey[i+1],4)},{preserved})
	end

	

	CElseX({}) -- ���罺�� �� ���
	

	local AvailableStatVA = CreateVArray(FP,4)
	local CurrentStatVA = CreateVArray(FP,4)
	local MaxLevelVA = CreateVArray(FP,4)
	local MaxScoreVA = CreateVArray(FP,4)
	local SupplyVA = CreateVArray(FP,4)
	local NukesVA = CreateVArray(FP,4)
	local SuppMaxVA = CreateVArray(FP,4)
	local ArmorVA = CreateVArray(FP,4)
	local TotalAHPVA = CreateVArray(FP,4)
	local ArmorCostVA = CreateVArray(FP,4)
	local LocalV_ArmorCost = CreateVar(FP)
	local LocalCcode_Stim = CreateCcode()
	local LocalCcode_Stim2 = CreateCcode()
	local LocalCcode_Multi = CreateCcode()
	local LocalCcode_AutoHeal = CreateCcode()
	local LocalCcode_SkillUnit = CreateCcode()
	local LocalCcode_Detector = CreateCcode()
	local AmVA = CreateVArray(FP,7)
	
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,LocalCcode_Stim),SetCDeaths(FP,SetTo,0,LocalCcode_Multi),SetCDeaths(FP,SetTo,0,LocalCcode_SkillUnit)})
		PlayerInfoT = "\x12\x10�� \x08Y\x04our \x0FL\x04evel :\x1F 0000000000 \x04�� Score :\x07 0000000000 \x04�� \x07StatPoint \x04: 0000000000 / 0000000000 \x10��\r\n"
		PlayerItemT = "\x12\x10�� \x0FI\x04tems �� \x0E�ۼ�Ʈ \x1E���� : 000 / 255 \x04�� �� ü�� ��ȭ : 000 / 255 \x04�� ���� : F9\x10��"
	
		TempVT = CreateVarArr(7,FP)
		for i = 0, 6 do
		CIf(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,SetTo,2,CPConsoleToggle)}) -- �������ͽ� ����
		CMov(FP,LocalV_ArmorCost,_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8)),1)
		CMov(FP,TempVT[1],AvailableStat[i+1])
		CMov(FP,TempVT[2],CurrentStat[i+1])
		CMov(FP,TempVT[3],MaxLevel[i+1])
		CMov(FP,TempVT[4],MaxScore[i+1])
		CMov(FP,TempVT[5],Nukes[i+1])
		CMov(FP,TempVT[6],_Div(Supply[i+1],2))
		CMov(FP,TempVT[7],P_Armor[i+1])
		TriggerX(FP,{CVar(FP,P_Armor[i+1][2],AtLeast,255)},{SetCVar(FP,LocalV_ArmorCost[2],SetTo,0)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_Stim)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_Multi)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,SkillUnit[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_SkillUnit)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoStim[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_Stim2)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoHeal[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_AutoHeal)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MarDetector[i+1])},{SetCDeaths(FP,SetTo,1,LocalCcode_Detector)},{preserved})
		CIfEnd({SetMemory(0x6509B0,SetTo,FP)})
		end
		ItoDec(FP,TotalAHP,VArr(TotalAHPVA,0),2,nil,0)
		ItoDec(FP,_Div(SuppMax,2),VArr(SuppMaxVA,0),2,nil,0)
		ItoDec(FP,LocalV_ArmorCost,VArr(ArmorCostVA,0),2,nil,0)
		ItoDec(FP,TempVT[1],VArr(AvailableStatVA,0),2,nil,0)
		ItoDec(FP,TempVT[2],VArr(CurrentStatVA,0),2,nil,0)
		ItoDec(FP,TempVT[3],VArr(MaxLevelVA,0),2,0x1F,0)
		ItoDec(FP,TempVT[4],VArr(MaxScoreVA,0),2,0x07,0)
		ItoDec(FP,TempVT[5],VArr(NukesVA,0),2,nil,0)
		ItoDec(FP,TempVT[6],VArr(SupplyVA,0),2,nil,0)
		ItoDec(FP,TempVT[7],VArr(ArmorVA,0),2,nil,0)
		
		
		f_Movcpy(FP,_Add(StatusStrPtr1,StatPT[2]),VArr(AvailableStatVA,0),4*4)
		f_Movcpy(FP,_Add(StatusStrPtr1,StatPT[2]+DBossT2[2]+(5*4)),VArr(CurrentStatVA,0),4*4)
		f_Movcpy(FP,_Add(HiScoreStrPtr,HiScoreT1[2]),VArr(MaxLevelVA,0),4*4)
		f_Movcpy(FP,_Add(HiScoreStrPtr,HiScoreT1[2]+HiScoreT2[2]+(5*4)),VArr(MaxScoreVA,0),4*4)
		f_Movcpy(FP,_Add(SupplyStrPtr,SupplyT[2]),VArr(SupplyVA,0),4*4)
		f_Movcpy(FP,_Add(SupplyStrPtr,SupplyT[2]+(5*4)+SupplyT2[2]),VArr(SuppMaxVA,0),4*4)
		f_Movcpy(FP,_Add(ArmorStrPtr,ArmorT[2]),VArr(ArmorCostVA,0),4*4)
		f_Movcpy(FP,_Add(ArmorStrPtr,ArmorT[2]+(5*4)+ArmorT2[2]),VArr(ArmorVA,0),4*4)
		f_Movcpy(FP,_Add(AHPStrPtr,EnemyHPT1[2]),VArr(TotalAHPVA,0),4*4)



		for i = 0, 6 do
			TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,i)},{preserved})
		end
		TextRet = CreateVar()
		CMov(FP,TextRet,0)
			for i = 0, 3 do
				local CBit = 2^i
				Trigger {players = {FP},conditions = {Label(),MemoryX(0x640B58,Exactly,CBit,CBit)},actions = {SetNVar(TextRet,Add,CBit)},flag = {preserved}}
			end
		
		DoActions(FP,{--DisplayText(string.rep("\n", 20),4),
		DisplayText("\x0D\x0D\x0DHiSc".._0D,4),
		DisplayText("\x0D\x0D\x0DUStat".._0D,4),
		DisplayText("\x0D\x0D\x0DSupp".._0D,4),
		DisplayText("\x0D\x0D\x0DArmor".._0D,4),
		DisplayText("\x0D\x0D\x0DAHP".._0D,4),
		--DisplayText("\x0D\x0D\x0DNuke".._0D,4),
		
	})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Stim)},{DisplayText("\x07�� \x1B���� ������ \x04(P) \x1F(Cost:"..P_StimCost..") \x07��",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,1,LocalCcode_Stim),CDeaths(FP,Exactly,0,LocalCcode_Stim2)},{DisplayText("\x07�� \x07�ڵ� \x1B������ \x04(P) \x1F(Cost:"..P_AutoStimCost..") \x07��",4)},{preserved})
	--TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Stim)},{DisplayText("\x13\x07�� \x1B���� ������ \x04(R) \x1F(Cost:"..P_StimCost..") \x03���� �Ϸ�! \x07��",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Multi)},{DisplayText("\x07�� \x1D��Ƽ \x1BĿ�ǵ� \x04(O) \x1F(Cost:"..P_MultiCost..") \x07��",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,1,LocalCcode_Multi),CDeaths(FP,Exactly,0,LocalCcode_AutoHeal)},{DisplayText("\x07�� \x07�ڵ� \x1F�� \x04(O) \x1F(Cost:"..P_AutoHealCost..") \x07��",4)},{preserved})
	--TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Multi)},{DisplayText("\x13\x07�� \x1D��Ƽ \x1BĿ�ǵ� \x04(T) \x1F(Cost:"..P_MultiCost..") \x03���� �Ϸ�! \x07��",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,TeamEnchant)},{DisplayText("\x07�� \x04Normal Marine \x1B��ȭ \x04(I) \x1F(Cost:"..P_EnchantCost..") \x07��",4)},{preserved})
	--TriggerX(FP,{CDeaths(FP,AtLeast,1,TeamEnchant)},{DisplayText("\x13\x07�� \x04Normal Marine \x1B��ȭ \x04(Y) \x1F(Cost:"..P_EnchantCost..") \x03���� �Ϸ�! \x07��",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_SkillUnit)},{DisplayText("\x07�� \x08�ٹ�Ʋ \x04���� \x1BȰ��ȭ\x04, ������ �ڵ����� \x1F10,000,000 Ore\x04�� �Ҹ��մϴ�. \x04(U) \x1F(Cost:"..P_SkillUnitCost..") \x07��",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,1,LocalCcode_SkillUnit),CDeaths(FP,Exactly,0,LocalCcode_Detector)},{DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x1C������ \x1BȰ��ȭ \x04(U) \x1F(Cost:"..P_MarDetectorCost..") \x07��",4)},{preserved})

	CMov(FP,0x640B58,TextRet)
	CIfXEnd()



	Trigger2X(FP,{Memory(0x596A38, Exactly, 0),Memory(0x596A44, Exactly, 0),CDeaths(FP,Exactly,1,KeyToggle)},{SetCDeaths(FP,SetTo,0,KeyToggle)},{preserved})
	
	Trigger2X(FP,{Memory(0x596A44, Exactly, 65536)},{SetCDeaths(FP,SetTo,0,DeleteToggle),DisplayText(string.rep("\n", 20),4)},{preserved})

	TriggerX(FP,{Deaths(CurrentPlayer,Exactly,0,CPConsole),CDeaths(FP,AtLeast,1,CPConsoleToggle)},{DisplayText(string.rep("\n", 20),4),SetCDeaths(FP,Subtract,1,CPConsoleToggle)},{preserved})



for i =0, 6 do
	if i == 0 then 
		CMov(FP,TotalAHP,0)
	end
	CIf(FP,HumanCheck(i,1))
		CAdd(FP,TotalAHP,AHP[i+1])
	CIfEnd()
end
	for i = 0, 6 do -- ���÷��̾�
		DoActions(FP,SetMemory(0x6509B0,SetTo,i)) -- CP ���� 
--		Trigger2(i,{Deaths(i,AtLeast,1,��),LocalPlayerID(i)},{
--			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
--			DisplayText("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
--			DisplayText("\x13\x07�� \x04ä�� A10 �� �湮�Ͽ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
--			SetMemory(0xCDDDCDDC,SetTo,1);
--		})
		if i ~= 0 then --����Ʈ���Ŵ� 1�÷��̾� ����
		
		Trigger { -- ����
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanToken[i+1]);
			},
			actions = {
				RotatePlayer({DisplayTextX("\x07�� \x04"..PlayerString[i+1].."\x04�� ����ó���� �Ϸ�Ǿ����ϴ�.\x07 ��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
				},
			}
			Trigger { -- ���� ���
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,AtLeast,5,BanToken[i+1]);Memory(0x512684, Exactly, i)
					
				},
				actions = {
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
					SetMemory(0xCDDDCDDC,SetTo,1);
					
					},
				}
		end
		
		Trigger { -- �̳׶� ���̳ʽ� ����
			players = {i},
			conditions = {
				Memory(0x57f0f0+(i*4),AtLeast,0x7FFFFFFF);
			},
			actions = {
				SetResources(i,SetTo,2100000000,Ore);
				PreserveTrigger();
			},
		}
		
		for k = 64, 67 do
			local X = {}
			local Y = {}
			if k == 64 or k == 66 then
				X = {SetCDeaths(FP,Add,100,OrderCool[i+1])}
			else
				X = nil
			end
			if k == 64 then
				Y = {Order("Men",i,64,Move,74+i)}
			end
			if k == 66 then
				Y = {Order("Men",i,64,Attack,74+i)}
			end
			Trigger { -- ��ư ���
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
					Y;
					PreserveTrigger();
				},
			}
		end
		KeyCP = i

		
		Trigger { -- ������
			players = {i},
			conditions = {
				Label(0);
				Bring(i,AtLeast,1,71,64);
			},
			actions = {
				SetDeaths(i,Add,1,71);
				RemoveUnitAt(1,71,"Anywhere",i);
				DisplayText("\x07�� \x04���� \x1B������\x04����� ����մϴ�.\x07 ��",4);
				SetCDeaths(FP,Add,1,CUnitFlag);
				PreserveTrigger();
			},
		}
		
		CIf(i,Bring(i,AtLeast,1,19,64))
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtLeast,1);
				Memory(0x582294+(4*i),AtMost,1000);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetResources(i,Add,65000,Ore);
				RemoveUnitAt(1,19,"Anywhere",i);
				DisplayText("\x07�� \x04���� \x1C���� ��ȣ��\x04�� ��Ÿ�����Դϴ�. �ڿ� ��ȯ + \x1F65000 Ore\x07��",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtLeast,1001);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetResources(i,Add,65000,Ore);
				RemoveUnitAt(1,19,"Anywhere",i);
				DisplayText("\x07�� \x04�̹� \x1C���� ��ȣ��\x04�� ������Դϴ�. �ڿ� ��ȯ + \x1F65000 Ore\x07��",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtMost,0);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetMemory(0x582294+(4*i),SetTo,2000);
				RemoveUnitAt(1,19,"Anywhere",i);
				RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."shd".._0D,4),PlayWAVX("staredit\\wav\\shield_use.ogg")},HumanPlayers,i);
				SetCDeaths(FP,SetTo,1,ShUsed[i+1]);
				PreserveTrigger();
			},
		}
		CIfEnd()
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,1000);
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04 ����� ����Ǿ����ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				PreserveTrigger();
			},
		}
		Trigger { -- ��ȣ�� ����
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,1,ShUsed[i+1]);
				Memory(0x582294+(4*i),Exactly,0);
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04 ��Ÿ���� ����Ǿ����ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				SetCDeaths(FP,SetTo,0,ShUsed[i+1]);
				PreserveTrigger();
			},
		}
		for j = 1, 5 do
		Trigger { -- ��ȣ�� ���
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j+(1000));
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04�� "..j.."�� ���ҽ��ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		for j = 1, 5 do
		Trigger { -- ��ȣ�� ��Ÿ��
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j);
			},
			actions = {
				DisplayText("\x07�� \x1C���� ��ȣ��\x04 ��Ÿ���� "..j.."�� ���ҽ��ϴ�. \x07��",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		Trigger2(i,{Memory(0x582294+(4*i),AtLeast,1)},{SetMemory(0x582294+(4*i),Subtract,1)},{preserved})
		TriggerX(i,{Deaths(i,Exactly,0,OPConsole),Deaths(i,AtLeast,1,F9),Deaths(i,Exactly,0,B),Deaths(i,Exactly,0,CPConsole)},{SetDeaths(i,SetTo,1,CPConsole),SetDeaths(i,SetTo,0,F9),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
		TriggerX(i,{Deaths(i,Exactly,0,OPConsole),Deaths(i,AtLeast,1,F9),Deaths(i,Exactly,0,B),Deaths(i,Exactly,1,CPConsole)},{SetDeaths(i,SetTo,0,CPConsole),SetDeaths(i,SetTo,0,F9),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
		CIf(FP,{HumanCheck(i,1),Deaths(i,AtLeast,1,CPConsole)},{TSetCDeaths(FP,Add,Dt,FuncT[i+1])}) -- ����â �������̽� Deaths 100~149
			KeyInput(219,{CDeaths(FP,AtMost,0,GivePChange[i+1]),LocalPlayerID(i)},{print_utf8(12,0,"\x07�� \x04����Ű�� ���� \x1F��� �÷��̾�\x04�� �������ּ���. \x07��")},1,1)
			KeyInput(219,{CDeaths(FP,AtMost,0,GivePChange[i+1])},{SetCDeaths(FP,SetTo,1,GivePChange[i+1]),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
			
			for j = 0, 6 do
				if i==j then 
					KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1),LocalPlayerID(i)},{print_utf8(12,0,"\x07�� "..PlayerString[j+1].."\x04��(��) �ڱ� �ڽ��Դϴ�. �ڱ� �ڽſ��Դ� ����� �� �����ϴ�. \x07��")},1,1)
					KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),},1)

				else 
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1),LocalPlayerID(i)},{print_utf8(12,0,"\x07�� \x1F��� �÷��̾�\x04��"..PlayerString[j+1].."\x04���� �����Ǿ����ϴ�. \x07��")},1,1)
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,j+1,151),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
				end

				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,0),LocalPlayerID(i)},{print_utf8(12,0,"\x07�� "..PlayerString[j+1].."\x04��(��) �������� �ʽ��ϴ�. \x07��")},1,1)
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,0)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
				TriggerX(FP,{Deaths(i,Exactly,j+1,151),HumanCheck(j,0)},{SetDeaths(i,SetTo,0,151)},{preserved})
			end
			CIfX(FP,{HumanCheck(i,1),Deaths(i,AtLeast,1,150),Deaths(i,AtMost,220000,150),Deaths(i,AtLeast,1,151)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15);})

				f_Read(FP,0x58A364+(48*150)+(4*i),TempGiveV)
				f_Read(FP,0x58A364+(48*151)+(4*i),TempGivePV)

				f_Mul(FP,TempGiveV,10000)

				CIfX(FP,{TAccumulate(i,AtLeast,TempGiveV,Ore)},{TSetResources(_Sub(TempGivePV,1),Add,TempGiveV,Ore),TSetResources(i,Subtract,TempGiveV,Ore)})
					ItoDec(FP,TempGiveV,VArr(GiveVA,0),2,0x1F,0)
					_0DPatchX(FP,GiveVA,6)

					CIf(FP,{LocalPlayerID(i)})
					
					f_Memcpy(FP,0x640B60 + (12 * 218),_TMem(Arr(GiveTReset[3],0),"X","X",1),GiveTReset[2])
					f_Memcpy(FP,0x640B60 + (12 * 218),_TMem(Arr(GiveSendT[3],0),"X","X",1),GiveSendT[2])
					for j = 1, 7 do
					CIf(FP,CVar(FP,TempGivePV[2],Exactly,j))
					f_Movcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2],VArr(Names[j],0),4*6)
					CIfEnd()
					end
					f_Memcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2]+(4*6),_TMem(Arr(GiveT2[3],0),"X","X",1),GiveT2[2])
					f_Movcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2]+(4*6)+GiveT2[2],VArr(GiveVA,0),4*5)
					f_Memcpy(FP,0x640B60 + (12 * 218)+GiveSendT[2]+(4*6)+GiveT2[2]+(4*5),_TMem(Arr(GiveSendT2[3],0),"X","X",1),GiveSendT2[2])
					CIfEnd()
					CIf(FP,{TMemory(0x512684,Exactly,_Sub(TempGivePV,1))})
					
					f_Memcpy(FP,GiveStrPtr,_TMem(Arr(GiveTReset[3],0),"X","X",1),GiveTReset[2])

					f_Memcpy(FP,GiveStrPtr,_TMem(Arr(GiveReciveT[3],0),"X","X",1),GiveReciveT[2])
					f_Movcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]),VArr(Names[i+1],0),4*6)
					f_Memcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]+(4*6)),_TMem(Arr(GiveT2[3],0),"X","X",1),GiveT2[2])
					f_Movcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]+(4*6)+GiveT2[2]),VArr(GiveVA,0),4*5)
					f_Memcpy(FP,_Add(GiveStrPtr,GiveReciveT[2]+(4*6)+GiveT2[2]+(4*5)),_TMem(Arr(GiveReciveT2[3],0),"X","X",1),GiveReciveT2[2])
					CDoActions(FP,{TSetMemory(0x6509B0,SetTo,_Sub(TempGivePV,1)),DisplayText("\x0D\x0D\x0DGive".._0D,4)})

					f_Memcpy(FP,GiveStrPtr,_TMem(Arr(GiveTReset[3],0),"X","X",1),GiveTReset[2])
					CIfEnd()
				CElseX({SetMemory(0x6509B0,SetTo,i)})
				CallTriggerX(FP,Call_Print13[i+1])
				TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07�� \x04�ܾ��� �����մϴ�. \x07��")},{preserved})

				CIfXEnd()
			DoActions(FP,SetMemory(0x6509B0,SetTo,i))
			CElseIfX({Deaths(i,AtLeast,1,150),Deaths(i,AtMost,220000,150),Deaths(i,AtMost,0,151)},{SetDeaths(i,SetTo,150,15)})
			CallTriggerX(FP,Call_Print13[i+1])
			TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07�� \x1F��� �÷��̾�\x04�� �������� �ʾҽ��ϴ�. \x07��")},{preserved})
			CIfXEnd()
--			Trigger2(FP,{Deaths(i,AtLeast,1,113)},{SetDeaths(i,SetTo,2,14)},{preserved})
			TriggerX(FP,{Deaths(i,AtLeast,1,150)},{SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
			TriggerX(FP,{Deaths(i,AtMost,0,15),Memory(0x512684,Exactly,i)},{SetCDeaths(FP,SetTo,0,DeleteToggle),
				print_utf8(12,0,"\x07[ \x1F�̳׶� \x03��ι�� \x041. �����ư(��)���� �� ���ڹ�ư���� �÷��̾� ���� 2. \x1F1���� ����\x04�� ���ڸ� ä��â�� �Է�. ESC : �ݱ�\x07 ]")
			},{preserved}) -- 13���� ����Ʈ Ʈ���� �÷��̾ FP�� ������ Ʈ���� ������ 1P���� 8P���� ����Ǳ� ����. i�� �ϰԵ� ��� �̰� ������ �����ִ� CText�� ���̰� �ȴ�. 
			--���� ������ ���� PlayWAV("staredit\\wav\\BuySE.ogg");
			--���� ���н� ���� PlayWAV("staredit\\wav\\FailSE.ogg");

			CIf(FP,{Deaths(i,AtLeast,1,102)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);})
				CIfX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_SuppCost),TCVar(FP,Supply[i+1][2],AtMost,_Sub(SuppMax,1))},{SetCVar(FP,AvailableStat[i+1][2],Subtract,P_SuppCost),SetCVar(FP,Supply[i+1][2],Add,P_SuppAmount),SetDeaths(i,SetTo,150,15)})
					TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x07���� ����, \x04�α����� \x07"..(P_SuppAmount/2).." \x04�����Ͽ����ϴ�. \x07]")},{preserved})
					TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCDeaths(FP,SetTo,100,UpSELemit[i+1])},{preserved})
				CElseX({})
					CTrigger(FP,{TCVar(FP,Supply[i+1][2],AtLeast,SuppMax),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08���� ����, \x04�� �ִ� �α����� �� á���ϴ�. \x07]"),},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),TCVar(FP,Supply[i+1][2],AtLeast,SuppMax)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
					TriggerX(FP,{CVar(FP,AvailableStat[i+1][2],AtMost,P_SuppCost-1),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},{preserved})
					TriggerX(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,AvailableStat[i+1][2],AtMost,P_SuppCost-1)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},{preserved})
				CIfXEnd()
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,109)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);})
				CIfX(FP,{TCVar(FP,AvailableStat[i+1][2],AtLeast,_Add(_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8)),1)),CVar(FP,P_Armor[i+1][2],AtMost,254)},{TSetCVar(FP,AvailableStat[i+1][2],Subtract,_Add(_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8)),1)),SetCVar(FP,P_Armor[i+1][2],Add,1),SetDeaths(i,SetTo,150,15)})
					TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCDeaths(FP,SetTo,100,UpSELemit[i+1])},{preserved})
					TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x07���� ����, \x0F�ۼ�Ʈ ����\x04�� �����Ͽ����ϴ�. \x07]")},{preserved})
					CMov(FP,0x515B88+(i*4),_Sub(_Mov(256),P_Armor[i+1]))
					CMov(FP,0x515BB0+(i*4),_Mul(_Div(_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)),_Mov(256)),_Sub(_Mov(256),P_Armor[i+1])))
				CElseX({SetMemory(0x6509B0,SetTo,i)})
					CTrigger(FP,{CVar(FP,P_Armor[i+1][2],AtLeast,255),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08���� ����, \x04���׷��̵� ��ġ�� �̹� �ִ�ġ�Դϴ�. \x07]"),},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,P_Armor[i+1][2],AtLeast,255)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
					CTrigger(FP,{TCVar(FP,AvailableStat[i+1][2],AtMost,_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8))),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),TCVar(FP,AvailableStat[i+1][2],AtMost,_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8)))},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
				CIfXEnd()
			CIfEnd(SetMemory(0x6509B0,SetTo,i))

			CIf(FP,{Deaths(i,AtLeast,1,100)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);})
				CIfX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_AHP),CVar(FP,TotalAHP[2],AtMost,254)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,P_AHP),SetCVar(FP,AHP[i+1][2],Add,1),SetCVar(FP,TotalAHP[2],Add,1),SetDeaths(i,SetTo,150,15)})
					TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCDeaths(FP,SetTo,100,UpSELemit[i+1])})
					TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x07���� ����, \x04���� \x08ü�� \x04�� �϶��Ͽ����ϴ� (���� �������� ����). \x07]")},{preserved})
				CElseX({SetMemory(0x6509B0,SetTo,i)})
					CTrigger(FP,{CVar(FP,TotalAHP[2],AtLeast,255),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08���� ����, \x04���׷��̵� ��ġ�� �̹� �ִ�ġ�Դϴ�. \x07]"),},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,TotalAHP[2],AtLeast,255)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
					CTrigger(FP,{CVar(FP,AvailableStat[i+1][2],AtMost,P_AHP-1),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,AvailableStat[i+1][2],AtMost,P_AHP-1)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
				CIfXEnd()
			CIfEnd(SetMemory(0x6509B0,SetTo,i))

			KeyInput(103,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtLeast,1,AutoStim[i+1])},{print_utf8(12,0,"\x07[ \x08�̹� ���ԵǾ����ϴ�. \x07]")},1,1) --��ƼĿ��
			KeyInput(104,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtLeast,1,AutoHeal[i+1])},{print_utf8(12,0,"\x07[ \x08�̹� ���ԵǾ����ϴ�. \x07]")},1,1) --���ݽ���
			KeyInput(105,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08�̹� ���ԵǾ����ϴ�. \x07]")},1,1) --�ϸ���ȭ
			KeyInput(106,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,MarDetector[i+1]),CDeaths(FP,AtLeast,1,SkillUnit[i+1])},{print_utf8(12,0,"\x07[ \x08�̹� ���ԵǾ����ϴ�. \x07]")},1,1) --�ٹ�Ʋ ����
			KeyInput(105,{CDeaths(FP,AtLeast,1,TeamEnchant)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�ϸ���ȭ
			KeyInput(103,{CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtLeast,1,AutoStim[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --��ƼĿ��
			KeyInput(104,{CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtLeast,1,AutoHeal[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --���ݽ���
			KeyInput(106,{CDeaths(FP,AtLeast,1,MarDetector[i+1]),CDeaths(FP,AtLeast,1,SkillUnit[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�ٹ�Ʋ ����
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_StimCost),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x07���� ����, \x1B���� ������ \x04����� ����� �� �ֽ��ϴ�. \x07]")},1,1) --��ƼĿ��
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_MultiCost),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x07���� ����, \x1D��Ƽ \x1BĿ�ǵ� \x04����� ����� �� �ֽ��ϴ�. \x07]")},1,1) --���ݽ���
			KeyInput(105,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_EnchantCost),CDeaths(FP,AtMost,0,TeamEnchant)},{print_utf8(12,0,"\x07[ \x07���� ����, \x04������\x04Normal Marine\x04�� \x1B��ȭ \x04�Ǿ����ϴ�. \x07]")},1,1) --�ϸ���ȭ
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_EnchantCost),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{print_utf8(12,0,"\x07[ \x07���� ����, \x04�������� \x10�ٹ�Ʋ ����\x04�� \x1B����\x04�մϴ�. \x07]")},1,1) --�ٹ�Ʋ ����
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoStimCost),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{print_utf8(12,0,"\x07[ \x07���� ����, \x07�ڵ� \x1B������ \x04����� Ȱ��ȭ �Ǿ����ϴ�. \x07]")},1,1) --��ƼĿ��
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoHealCost),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{print_utf8(12,0,"\x07[ \x07���� ����, \x07�ڵ� \x1F�� \x04����� Ȱ��ȭ �Ǿ����ϴ�. \x07]")},1,1) --���ݽ���
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_MarDetectorCost),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{print_utf8(12,0,"\x07[ \x07���� ����, \x1FExceeD \x1BM\x04arine \x1C������\x04�� Ȱ��ȭ �Ǿ����ϴ�.. \x07]")},1,1) --�ٹ�Ʋ ����
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_StimCost),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_StimCost),SetCDeaths(FP,SetTo,1,MultiStimPack[i+1]),SetMemoryB(0x57F27C+(228*i)+71,SetTo,1),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --��ƼĿ��
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_MultiCost),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_MultiCost),SetCDeaths(FP,SetTo,1,MultiCommand[i+1]),SetMemoryB(0x57F27C+(228*i)+64,SetTo,1),SetMemoryB(0x57F27C+(228*i)+70,SetTo,1),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --���ݽ���
			KeyInput(105,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_EnchantCost),CDeaths(FP,AtMost,0,TeamEnchant)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_EnchantCost),SetCDeaths(FP,SetTo,1,TeamEnchant),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --�ϸ���ȭ
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_SkillUnitCost),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_SkillUnitCost),SetCDeaths(FP,SetTo,1,SkillUnit[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --�ٹ�Ʋ ����
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoStimCost),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_AutoStimCost),SetCDeaths(FP,SetTo,1,AutoStim[i+1]),SetMemoryB(0x57F27C+(228*i)+71,SetTo,0),SetMemoryB(0x57F27C+(228*i)+68,SetTo,1),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --��ƼĿ��
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoHealCost),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_AutoHealCost),SetCDeaths(FP,SetTo,1,AutoHeal[i+1]),SetDeaths(i,SetTo,150,15),SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),SetMemoryB(0x57F27C+(228*i)+72,SetTo,0),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --���ݽ���
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_MarDetectorCost),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_MarDetectorCost),SetCDeaths(FP,SetTo,1,MarDetector[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --�ٹ�Ʋ ����
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_StimCost-1),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1,1) --��ƼĿ��
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_MultiCost-1),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1,1) --���ݽ���
			KeyInput(105,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_EnchantCost-1),CDeaths(FP,AtMost,0,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1,1) --�ϸ���ȭ
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_SkillUnitCost-1),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1,1) --�ٹ�Ʋ ����
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoStimCost-1),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1,1) --��ƼĿ��
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoHealCost-1),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1,1) --���ݽ���
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_MarDetectorCost-1),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{print_utf8(12,0,"\x07[ \x08����Ʈ�� �����մϴ� \x07]")},1,1) --�ٹ�Ʋ ����
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtMost,P_StimCost-1),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --��ƼĿ��
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtMost,P_MultiCost-1),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --���ݽ���
			KeyInput(105,{CVar(FP,AvailableStat[i+1][2],AtMost,P_EnchantCost-1),CDeaths(FP,AtMost,0,TeamEnchant)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�ϸ���ȭ
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtMost,P_SkillUnitCost-1),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�ٹ�Ʋ ����
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoStimCost-1),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --��ƼĿ��
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoHealCost-1),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --���ݽ���
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtMost,P_MarDetectorCost-1),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --�ٹ�Ʋ ����
		--CPConsole
		TriggerX(FP,{CDeaths(FP,AtLeast,15*1000,FuncT[i+1])},{SetDeaths(i,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,0,151),},{preserved})
		TriggerX(FP,{Deaths(i,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,0,151)},{preserved})
		CIfEnd()
		CIfX(i,{CDeaths(FP,AtMost,0,AutoHeal[i+1])})
			DoActions(i,{
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
				SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
			})
			for j = 0, 3 do
			TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1])},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
				DisplayText(DelayMedicT[j+1],4),
				SetCDeaths(FP,Add,1,DelayMedic[i+1]),
				GiveUnits(All,72,i,"Anywhere",P12),
				RemoveUnitAt(1,72,"Anywhere",P12)},{preserved})
			end
			TriggerX(i,{CDeaths(FP,AtLeast,4,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,4,DelayMedic[i+1])},{preserved})
		CElseX()
		DoActions(i,{
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
			RemoveUnit(72,i)
		})

		CIfXEnd()
		
			Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07�� \x1CBGM\x04�� ���� �ʽ��ϴ�. \x07��",4);
				SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
			},{preserved})

			Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07�� \x1CBGM\x04�� ����ϴ�. \x07��",4);
				SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
			},{preserved})

			Trigger2X(i,{CDeaths(FP,Exactly,0,HeroPointNotice[i+1]);Command(i,AtLeast,1,29);},{
				GiveUnits(All,29,i,"Anywhere",P12);
				RemoveUnitAt(All,29,"Anywhere",P12);
				DisplayText("\x07�� \x1F���� �˸��Ҹ�\x04�� ���� �ʽ��ϴ�. \x07��",4);
				SetCDeaths(FP,SetTo,1,HeroPointNotice[i+1]);
			},{preserved})

			Trigger2X(i,{CDeaths(FP,Exactly,1,HeroPointNotice[i+1]);Command(i,AtLeast,1,29);},{
				GiveUnits(All,29,i,"Anywhere",P12);
				RemoveUnitAt(All,29,"Anywhere",P12);
				DisplayText("\x07�� \x1F���� �˸��Ҹ�\x04�� ����ϴ�. \x07��",4);
				SetCDeaths(FP,SetTo,0,HeroPointNotice[i+1]);
			},{preserved})

			
			TriggerX(i,{Command(i,AtLeast,1,70);},{
				GiveUnits(All,70,i,"Anywhere",P12);
				RemoveUnitAt(All,70,"Anywhere",P12);
				DisplayText("\x07�� \x1C��� ����\x04�� \x1D�������ݸ�� \x04�� �����ϴ�. (\x0FJunk Yard Dog\x04) \x07��",4);
				SetDeaths(i,SetTo,1,70);
				SetCDeaths(FP,Add,1,CUnitFlag);
				SetCDeaths(FP,Add,100,OrderCool[i+1]);
			},{preserved})

			
			TriggerX(i,{Command(i,AtLeast,1,68);CVar(FP,AvailableStat[i+1][2],AtLeast,P_TelCost)},{
				GiveUnits(All,68,i,"Anywhere",P12);
				RemoveUnitAt(All,68,"Anywhere",P12);
				SetCVar(FP,AvailableStat[i+1][2],Subtract,P_TelCost);
				DisplayText("\x07�� \x16���콺 ��ġ\x04�� \x1D��� ����\x04�� \x1B�ڷ���Ʈ\x04�Ͽ����ϴ� \x1F(-100Point) \x07��",4);
				SetDeaths(i,SetTo,1,68);
				PlayWAV("staredit\\wav\\BuySE.ogg");
				PlayWAV("staredit\\wav\\BuySE.ogg");
				SetCDeaths(FP,Add,25,TelCool[i+1]);
			},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,68);CVar(FP,AvailableStat[i+1][2],AtMost,P_TelCost-1)},{
				GiveUnits(All,68,i,"Anywhere",P12);
				RemoveUnitAt(All,68,"Anywhere",P12);
				DisplayText("\x07��\x1F���� ����Ʈ\x04�� �����մϴ�.\x1F(Cost:100) \x07��",4);
				PlayWAV("staredit\\wav\\FailSE.ogg");
			},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,48);CVar(FP,AvailableStat[i+1][2],AtLeast,P_TelCost)},{
				GiveUnits(All,48,i,"Anywhere",P12);
				RemoveUnitAt(All,48,"Anywhere",P12);
				SetCVar(FP,AvailableStat[i+1][2],Subtract,P_TelCost);
				DisplayText("\x07�� \x16����\x04���� \x1D��� ����\x04�� \x1B�ڷ���Ʈ\x04�Ͽ����ϴ� \x1F(-100Point) \x07��",4);
				SetDeaths(i,SetTo,1,48);
				PlayWAV("staredit\\wav\\BuySE.ogg");
				PlayWAV("staredit\\wav\\BuySE.ogg");
				SetCDeaths(FP,Add,25,TelCool2[i+1]);
			},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,48);CVar(FP,AvailableStat[i+1][2],AtMost,P_TelCost-1)},{
				GiveUnits(All,48,i,"Anywhere",P12);
				RemoveUnitAt(All,48,"Anywhere",P12);
				DisplayText("\x07��\x1F���� ����Ʈ\x04�� �����մϴ�.\x1F(Cost:100) \x07��",4);
				PlayWAV("staredit\\wav\\FailSE.ogg");
			},{preserved})


		UnitLimit(i,7,25,"SCV��",500)
		UnitLimit(i,125,15,"��Ŀ��",8000)
		UnitLimit(i,124,15,"�ͷ���",4000)
		


		CIfX(FP,HumanCheck(i,1)) -- FP�� �����ϴ� �ý��� �κ� Ʈ����. ���÷��̾ ������� ����ȴ�.


		TriggerX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetDeaths(i,SetTo,36,126)},{preserved})
			CMov(FP,0x5821D4 + (4*i),Supply[i+1]) -- �α��� ��� ������Ʈ(��밡��)
		--SCA ������ ������ ����

		CIf(FP,{TTDeaths(i,NotSame,CurrentStat[i+1],4)})
			f_Read(FP,0x58A364+(48*4)+(4*i),TempStat)
			CSub(FP,TempStat2,TempStat,CurrentStat[i+1])
			CMov(FP,CurrentStat[i+1],TempStat)
			CAdd(FP,AvailableStat[i+1],TempStat2)
		CIfEnd()
		CIf(FP,{TTDeaths(i,NotSame,MaxLevel[i+1],6)})
			f_Read(FP,0x58A364+(48*6)+(4*i),TempStat)
			CMov(FP,MaxLevel[i+1],TempStat)
			CIfX(FP,{CVar(FP,MaxLevel[i+1][2],AtMost,500)})
			f_Mul(FP,SuSpeed[i+1],_Mul(MaxLevel[i+1],_Mov(2)),20)
			CMov(FP,MarAtkL[i+1],_Mul(MaxLevel[i+1],_Mov(2)),224)
			CElseIfX({CVar(FP,MaxLevel[i+1][2],AtLeast,501)})
			CMov(FP,SuSpeed[i+1],1000*20)
			CMov(FP,MarAtkL[i+1],1000,224)
			CIfXEnd()
			f_Div(FP,MarAtkC[i+1],MarAtkL[i+1],_Mov(32))


			
			--table.insert(PatchArr,SetMemory(0x657470 + (MarWep[i+1]*4) ,SetTo,32*7))
			--table.insert(PatchArr,SetMemoryB(0x662DB8 + MarID[i+1],SetTo,7)) -- �ΰ���Ÿ�
			CDoActions(FP,{
				TSetMemory(0x657470 + (MarWep[i+1]*4),SetTo,MarAtkL[i+1]),
				TSetMemoryX(MarACPtrArr[i+1],SetTo,_Mul(MarAtkC[i+1],_Mov(256^MarACMaskRetArr[i+1])),255*(256^MarACMaskRetArr[i+1])),
			})

		CIfEnd()
		CIf(FP,{TTDeaths(i,NotSame,MaxScore[i+1],24)})
			f_Read(FP,0x58A364+(48*24)+(4*i),TempStat)
			CMov(FP,MaxScore[i+1],TempStat)
		CIfEnd()
		
		CIf(FP,{Bring(i,AtLeast,1,28,64)},{
			RemoveUnitAt(1,28,"Anywhere",i),
		})
		CIfX(FP,{TMemory(_Mem(_ReadF(0x5821D4 + (4*i))),AtLeast,_ReadF(0x582204 + (4*i)))})
			TriggerX(FP,{Accumulate(i,AtLeast,30000*12,Ore),Deaths(i,AtLeast,36,126)},{
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� \x1FExceeD \x1BM\x04arine �� \x0712�� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F360,000 O r e \x07��",4),
				SetMemory(0x6509B0,SetTo,FP),
				SetResources(i,Subtract,30000*12,Ore);
				SetCDeaths(FP,Add,12,MarCreate[i+1]),
			},{preserved})
			Trigger { -- ���� ���� �ȵ�
				players = {FP},
				conditions = {
				Deaths(i,AtMost,35,126);
			},
			  actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x0712�� \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - \x1FExceeD \x1BM\x04arine \x0436�� ����) \x07��",4);
				SetMemory(0x6509B0,SetTo,FP),
				PreserveTrigger();
			},
		}
		    Trigger { -- ���� ���� �ȵ�
		    players = {FP},
		    conditions = {
			Accumulate(i,AtMost,(30000*12)-1,Ore),
			Deaths(i,AtLeast,36,126),
		},
		  actions = {
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x0712�� \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - \x1F360,000 Ore ����) \x07��",4);
			SetMemory(0x6509B0,SetTo,FP),
			PreserveTrigger();
			},
	  	}
		CElseX({
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x0712�� \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - �α��� ����) \x07��",4);
			SetMemory(0x6509B0,SetTo,FP),
		})
		
		CIfXEnd()
		CIfEnd()

		Trigger { -- ���� ��������
			players = {FP},
			conditions = {
				Label(0);
				--Bring(FP,AtLeast,1,173,10);
				Bring(i,AtLeast,1,10,10);
				Accumulate(i,AtLeast,25000,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� \x04Norma Marine�� \x1FExceeD \x1BM\x04arine���� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F25,000 O r e \x07��",4);
				SetMemory(0x6509B0,SetTo,FP),
				SetDeaths(i,Add,1,126),
				ModifyUnitEnergy(1,10,i,10,0);
				SetResources(i,Subtract,25000,Ore);
				RemoveUnitAt(1,10,10,i);
				SetCDeaths(FP,Add,1,MarCreate[i+1]),
				PreserveTrigger();
			},
		}
		Trigger { -- ���� �ٹ�Ʋ
			players = {FP},
			conditions = {
				Label(0);
				--Bring(FP,AtLeast,1,173,10);
				CDeaths(FP,AtLeast,1,SkillUnit[i+1]);
				Bring(i,AtMost,0,12,64);
				Accumulate(i,AtLeast,10000000,Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� \x07��\x1F��\x1C��\x0E��\x0F��\x10��\x17��\x11��\x08�� �� \x19�ڵ� ���� \x04�Ǿ����ϴ�. - \x1F10,000,000 O r e \x07��",4);
				SetMemory(0x6509B0,SetTo,FP),
				SetResources(i,Subtract,10000000,Ore);
				SetCDeaths(FP,Add,1,CreateSu[i+1]),
				PreserveTrigger();
			},
		}
		
		
		TriggerX(FP,{Bring(i,AtLeast,1,15,64)},{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� Normal Marine �� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F5,000 O r e \x07��",4),
			SetMemory(0x6509B0,SetTo,FP),
			RemoveUnitAt(1,15,"Anywhere",i),
			SetCDeaths(FP,Add,1,MarCreate2[i+1]),
			SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
			SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
		},{preserved})
		CIf(FP,{TTMemory(_Add(BarrackPtr[i+1],62),NotSame,BarRally[i+1])}) --�跰���� ����
			f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally[i+1])
			CIf(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Nukes[i+1][2],AtLeast,1),CDeaths(FP,AtMost,0,NukeCool[1+i])},{SetCVar(FP,Nukes[i+1][2],Subtract,1),SetCDeaths(FP,SetTo,10,NukeCool[i+1])}) -- �跰���� ������ ���� �����Ǿ�������� �Ǵ� ĵ���̾ƴҰ��
				Convert_CPosXY(BarRally[i+1])
				DoActionsX(FP,SetCDeaths(FP,Add,10,NsW))
				CWhile(FP,CDeaths(FP,AtLeast,1,NsW),SetCDeaths(FP,Subtract,1,NsW))
				CreateBullet(211,20,0,CPosX,CPosY,i)
				CWhileEnd()
				CreateBullet(205,20,0,CPosX,CPosY,i)
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
				TriggerX(FP,{CDeaths(FP,AtMost,2,SoundLimit[i+1])},{RotatePlayer({PlayWAVX("sound\\Bullet\\TNsHit00.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit[i+1])},{preserved})
				DoActions2(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."Nuke".._0D,4),MinimapPing(1)},HumanPlayers,FP)})
			CIfEnd()
		CIfEnd()
		CIf(FP,{Memory(0x628438,AtLeast,1),CVar(FP,AMatter[i+1][2],AtLeast,1)}) -- �ݹ�������
			AmJump = def_sIndex()
			AmJump2 = def_sIndex()
			for j = 0, 15 do
				local AMWav
				if j <= 14 then AMWav = "staredit\\wav\\H-005.wav" else AMWav = "staredit\\wav\\H-020.wav" end
				NJumpX(FP,AmJump2,{CDeaths(FP,Exactly,150+(j*9),AmT[i+1])},{SetCVar(FP,AmY[2],SetTo,(186*32)-((12*j)*32)),RotatePlayer({PlayWAVX(AMWav)},HumanPlayers,FP)})
			end

			CJump(FP,AmJump)
			NJumpXEnd(FP,AmJump2)
			CMov(FP,AmX,6*32)
			CWhile(FP,CVar(FP,AmX[2],AtMost,96*32))
				CreateBullet(205,20,0,AmX,AmY,i)
				DoActionsX(FP,SetCDeaths(FP,Add,2,NsW))
				CWhile(FP,CDeaths(FP,AtLeast,1,NsW),SetCDeaths(FP,Subtract,1,NsW))
					CreateBullet(211,20,0,AmX,AmY,i)
				CWhileEnd()
				CAdd(FP,AmX,12*32)
			CWhileEnd()
			CJumpEnd(FP,AmJump)
			TriggerX(FP,{CDeaths(FP,AtMost,0,AmT[i+1])},{RotatePlayer({PlayWAVX("staredit\\wav\\WARNING.wav"),PlayWAVX("staredit\\wav\\WARNING.wav"),DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."AMatter".._0D,4)},HumanPlayers,FP)},{preserved})
			DoActionsX(FP,SetCDeaths(FP,Add,1,AmT[i+1]))
			--if Limit == 1 then
			--	TriggerX(FP,{CDeaths(FP,Exactly,180+(15*9),AmT[i+1])},{SetCVar(FP,AMatter[i+1][2],Subtract,1),SetCDeaths(FP,SetTo,0,AmT[i+1]),SetCDeaths(FP,SetTo,0,AmUsed[i+1])},{preserved})
			--else
				TriggerX(FP,{CDeaths(FP,Exactly,180+(15*9),AmT[i+1])},{SetCVar(FP,AMatter[i+1][2],Subtract,1),SetCDeaths(FP,SetTo,0,AmT[i+1])},{preserved})
			--end
		CIfEnd()
		CWhile(FP,{CDeaths(FP,AtLeast,1,MarCreate[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate[i+1]))
		
			CIfX(FP,{TMemory(_Mem(_ReadF(0x5821D4 + (4*i))),AtLeast,_ReadF(0x582204 + (4*i)))})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			DoActions(FP,CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
			CIfEnd()
			CElseX({SetResources(i,Add,30000,Ore)})
			CIfXEnd()
			CMov(FP,0x6509B0,FP)
		CWhileEnd()
		
		CIf(FP,{CDeaths(FP,AtLeast,1,MarCreate2[i+1]),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Subtract,1,MarCreate2[i+1]))
		CIfX(FP,{TMemory(_Mem(_ReadF(0x5821D4 + (4*i))),AtLeast,_ReadF(0x582204 + (4*i)))})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			DoActions(FP,CreateUnitWithProperties(1,10,2+i,i,{energy = 100}))
			CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
			CIfEnd()
			CElseX({SetResources(i,Add,5000,Ore)})
			CIfXEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
		
		local MedicTrigJump = def_sIndex()
		NJumpX(FP,MedicTrigJump,{CDeaths(FP,AtLeast,1,AutoHeal[i+1]),CDeaths(FP,AtLeast,5,AutoHealT[i+1])},{SetCDeaths(FP,SetTo,0,AutoHealT[i+1])})
		for j = 1, 4 do
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)})
		end

			NIf(FP,Never())
				NJumpXEnd(FP,MedicTrigJump)
					DoActionsX(FP,{
						RemoveUnit(MedicTrig[1],i),
						RemoveUnit(MedicTrig[2],i),
						RemoveUnit(MedicTrig[3],i),
						RemoveUnit(MedicTrig[4],i),
						ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
						ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
						ModifyUnitShields(All,"Men",i,"Anywhere",100),
						ModifyUnitShields(All,"Buildings",i,"Anywhere",100),
						SetCDeaths(FP,SetTo,1,SuHeal[i+1])
					})
					TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,3),Bring(FP, AtMost, 0, 147, 64)},{
						ModifyUnitShields(All,"Men",i,"Anywhere",0),
						ModifyUnitShields(All,"Buildings",i,"Anywhere",0)},{preserved})
			NIfEnd()
		
		
		NIf(FP,MemoryB(0x58D2B0+(46*i)+18,AtLeast,1)) -- ���� 255ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+18,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+17,AtLeast,1)) -- ���� 10ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+17,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+19,AtLeast,1)) -- ü�� 255ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+19,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+20,AtLeast,1)) -- ü�� 10ȸ
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+20,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+21,AtLeast,1)) --��Ŭ�� Ǯ��
			
		TriggerX(FP,{Accumulate(i,AtLeast,2000000000,Ore)},{
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),SetTo,65535),
			SetCVar(FP,AtkUpCompCount[i+1][2],SetTo,255),
			SetCVar(FP,MarMaxHP[i+1][2],SetTo,160000*256),
			SetCVar(FP,MarHP[i+1][2],SetTo,160000*256),
			SetCVar(FP,DefUpCompCount[i+1][2],SetTo,75),
			SetCVar(FP,BattleHeal[i+1][2],SetTo,(800*75)*256),
			SetMemoryB(0x58D2B0+(46*i)+21,SetTo,0),
			SetMemoryB(0x58F32C + (59 - 46)+ 15*i,SetTo,255);
			SetMemoryX(AtkUpgradePtrArr[i+1],SetTo,0*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1])),
			SetMemoryX(DefUpgradePtrArr[i+1],SetTo,0*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1])),
			SetResources(i,Subtract,2000000000,Ore),
			SetMemoryB(0x58D088 + (i * 46) + 21,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x0820�� \x1F�̳׶�\x04�� �Ҹ��Ͽ� ��� ���׷��̵带 �Ϸ��Ͽ����ϴ�. \x07��",4);
			SetMemory(0x6509B0,SetTo,FP),
		})
		TriggerX(FP,{Accumulate(i,AtMost,2000000000-1,Ore)},{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x04�ܾ��� �����մϴ�. \x07��",4);
			SetMemory(0x6509B0,SetTo,FP),
			SetMemoryB(0x58D2B0+(46*i)+21,SetTo,0),
		},{preserved})
		NIfEnd()
		
		CIf(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,255*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))},{SetMemoryX(AtkUpgradePtrArr[i+1],SetTo,0*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04��������\x1C���ݷ� ���׷��̵�\x04�� 255�� �Ѿ� �Ѱ踦 �����մϴ�.\x04��������\n\x13\x04��������\x07���׷��̵带 \x040���� �缳���ϰ� \x17���ݷ� ��ġ�� ����\x04�Ǿ����ϴ�.\x04��������",4),
			SetMemory(0x6509B0,SetTo,FP),
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),Add,MarDamageFactor*255),
			SetCVar(FP,AtkUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{preserved})
		TriggerX(FP,{},{SetCVar(FP,AtkFactorV[i+1][2],Add,1)},{preserved})--CVar(FP,AtkUpCompCount[i+1][2],AtLeast,151)
			DoActions(FP,{SetMemoryB(0x58F32C + (59 - 46)+ 15*i,Add,1)})
			TriggerX(FP,{CVar(FP,AtkFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58F32C + (59 - 46)+ 15*i,SetTo,255)},{preserved})
		CIfEnd()
		
		CIf(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,255*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))},{SetMemoryX(DefUpgradePtrArr[i+1],SetTo,0*(256^DefUpgradeMaskRetArr[i+1]),255*(256^DefUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04��������\x08ü�� ���׷��̵�\x04�� 255�� �Ѿ� �Ѱ踦 �����մϴ�.\x04��������\n\x13\x04��������\x07���׷��̵带 \x040���� �缳���ϰ� \x17ü�� ��ġ�� ����\x04�Ǿ����ϴ�.\x04��������",4),
			SetMemory(0x6509B0,SetTo,FP),
			--SetCVar(FP,DefFactorV[i+1][2],Add,1),
			SetCVar(FP,MarMaxHP[i+1][2],Add,2000*256),
			SetCVar(FP,DefUpCompCount[i+1][2],Add,1),
			SetCVar(FP,BattleHeal[i+1][2],Add,800*256),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{preserved})
		TriggerX(FP,{},{SetCVar(FP,DefFactorV[i+1][2],Add,4)},{preserved})--CVar(FP,DefUpCompCount[i+1][2],AtLeast,51)
		CIfEnd()

		DoActionsX(FP,{SetCVar(FP,CurrentHP[i+1][2],SetTo,0)})-- ü�°� �ʱ�ȭ
		for Bit = 0, 7 do
		TriggerX(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
			{SetCVar(FP,CurrentHP[i+1][2],Add,2008*(2^Bit))},{preserved})
		end
		CMov(FP,MarHP[i+1],_Add(CurrentHP[i+1],MarMaxHP[i+1]))
		
		CIfX(FP,CVar(FP,AtkUpCompCount[i+1][2],AtMost,0)) -- ���׷��̵� ���ø�Ʈ ī��Ʈ(255�� ���� Ƚ��)�� 0�� ���.
			DoActions(FP,{SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,0*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1]))})
			for Bit = 0, 7 do
			Trigger2(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
				{SetMemoryX(NormalUpgradePtrArr[i+1],Add,(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]),(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]))},{preserved})
			end
		CElseX() -- ��������ī��Ʈ 1 �̻��̸� �ϸ����� 255�� ������!
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
			DisplayText("\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x14\n\x14\n\x13\x1C���ݷ� ���׷��̵�\x04�� �������� 255�� �Ѿ����ϴ�.\n\x13\x04�������ʹ� \x1C��Ŭ�� ���׷��̵�\x04�� ���� ���׷��̵� ���ּ���.\n\n\x14\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������",4),
			PlayWAV("staredit\\wav\\button3.wav"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		TriggerX(FP,{CVar(FP,DefFactorV[i+1][2],AtLeast,255)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x14\n\x14\n\x13\x08ü�� ���׷��̵�\x04�� �������� 255�� �Ѿ����ϴ�.\n\x13\x04�������ʹ� \x1C��Ŭ�� ���׷��̵�\x04�� ���� ���׷��̵� ���ּ���.\n\n\x14\n\x13\x04��������\x03�Σϣԣɣã�\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������",4),
			PlayWAV("staredit\\wav\\button3.wav"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		
		TriggerX(FP,{CVar(FP,MarHP[i+1][2],AtLeast,160000*256)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 19,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 20,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07[ \x08ü��\x04�� 16�� �Ѿ�� \x1F%�۵�\x04 �ý��� �ڻ쳪�� ���̻� ü�� ���ؿ� �˼��մϴ�............................. \x07]",4),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		TriggerX(FP,{MemoryW(0x656EB0 + (MarWep[i+1]*2),AtLeast,65535-(MarDamageFactor*255))},{
			SetMemoryB(0x58D088 + (i * 46) + i,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 17,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 18,SetTo,0),
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),SetTo,65535),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07[ \x1C���ݷ�\x04�� �ý��ۻ� �Ѱ�� ���̻� ���� ���ؿ� �˼��մϴ�............................. \x07]",4),
			PlayWAV("staredit\\wav\\TT.ogg"),
			PlayWAV("staredit\\wav\\TT.ogg"),
			SetMemory(0x6509B0,SetTo,FP)
		})
		
		CIf(FP,{Deaths(i,AtLeast,1,68)},{SetDeaths(i,SetTo,0,68)})
			CSPlotAct(TelShape,i,nilunit,73+i,nil,1,32,32,{MoveUnit(1,MarID[i+1],i,16,74+i)},FP,nil,nil,1)
		CIfEnd()
		local WBreak = CreateCcode()
		CIf(FP,{Deaths(i,AtLeast,1,48)},{SetDeaths(i,SetTo,0,48),SetCD(WBreak,0)})
			
		for j = 17, 19 do
			CWhile(FP,{Bring(i,AtLeast,1,"Men",j),CV(WBreak,1000,AtMost)},AddCD(WBreak,1))
			f_Rand(FP,RandV)
			CAdd(FP,TempX,_Mod(RandV,2272-800),800)
			CAdd(FP,TempY,_Mod(RandV,6080-5440),5440)
			Simple_SetLocX(FP,0,TempX,TempY,TempX,TempY,{MoveUnit(1,"Men",i,j,1)})
			CWhileEnd()
		end
		CIfEnd()
		if TestStart == 1 then
			CIf(FP,{Memory(0x628438,AtLeast,1),Deaths(i,AtLeast,500,6),Command(i,AtMost,0,63)},{SetMemory(0x66FABC, SetTo, 365),SetMemoryX(0x66A1C4, SetTo, 0*256,0xFF00)})
		else
			CIf(FP,{Memory(0x628438,AtLeast,1),Deaths(i,AtLeast,500,6),Command(i,AtMost,0,63)},{SetMemory(0x66FABC, SetTo, 365),SetMemoryX(0x66A1C4, SetTo, 0*256,0xFF00)})
		end
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CMov(FP,BHPtr[i+1],Nextptrs)
			DoActions(FP,CreateUnitWithProperties(1,63,2+i,i,{energy = 100}))

			CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)},{
				RotatePlayer({PlayWAVX("staredit\\wav\\WARNING.wav"),PlayWAVX("staredit\\wav\\WARNING.wav"),DisplayTextX("\t\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x08���������ã��գԣɣϣΡ�������\n\n\n\x13\x04�������� \x1F�ְ� ����\x04�� \x11��ȯ\x04�Ͽ����ϴ�.\n\x13\x1F�ְ� ����\x04 �ݰ� �� ��κ��� �� ������ \x08�Ҹ�\x04�� ���Դϴ�.\n\n\n\x13\x08���������ã��գԣɣϣΡ�������\n\x13\x04������������������������������������������������������������������������������������������������������������",4)},HumanPlayers,FP)
			})
				CDoActions(FP,{
					TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
					TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
					TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
					TSetMemory(_Add(Nextptrs,13),SetTo,8000),
					TSetMemoryX(_Add(Nextptrs,18),SetTo,8000,0xFFFF),
					TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104);
					TSetMemory(_Add(Nextptrs,57),SetTo,0)
				})
				CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1)})
					CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
					TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
				CIfEnd()
			CIfEnd()
		
		CIfEnd()

		CIf(FP,{Memory(0x628438,AtLeast,1),Bring(i,AtMost,0,128,64)})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CMov(FP,MenuPtr[i+1],Nextptrs)
			DoActions(FP,CreateUnitWithProperties(1,128,2+i,i,{energy = 100}))
			CDoActions(FP,{
				TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
				TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
				TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000);
			})
		CIfEnd()

	
function CIfShop(CP,ID,Cost,ContentStr,DisContentStr,Conditions,Actions)
	CIf(FP,{TMemory(_Add(MenuPtr[CP+1],0x98/4),Exactly,0 + ID*65536)})
	CurShopCost = Cost
	CurShopCP = CP
	CurShopCond = Conditions
	CallTrigger(FP,Call_Print13[CP+1])
	TriggerX(FP,{CVar(FP,AvailableStat[CP+1][2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	TriggerX(FP,{CVar(FP,AvailableStat[CP+1][2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCVar(FP,AvailableStat[CP+1][2],Subtract,Cost),SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCp(FP),Actions},{preserved})	-- ����Ʈ�� ����� ���

	TriggerX(FP,{CVar(FP,AvailableStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	TriggerX(FP,{CVar(FP,AvailableStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- ����Ʈ�� ������� ���� ���
end
		CIf(FP,CVar(FP,MenuPtr[i+1][2],AtLeast,1))
		for m = 0, 3 do
		CIfShop(i,37+m,P_MinCost*(10^m),"\x07[ \x07���� ����, \x04�̳׶��� \x1F"..(P_MinAmount*(10^m)).." \x04�����Ͽ����ϴ�. \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",Accumulate(i,AtMost,1999999999,Ore),SetResources(i,Add,P_MinAmount*(10^m),Ore))
			TriggerX(FP,{CVar(FP,AvailableStat[CurShopCP+1][2],AtLeast,CurShopCost),CDeaths(FP,AtMost,0,ShopSw[CurShopCP+1]),LocalPlayerID(CurShopCP),Accumulate(CurShopCP,AtLeast,2000000000,Ore)},{print_utf8(12,0,"\x07[ \x1F�̳׶� \x0820�� �̻� \x04�������Դϴ�. \x08������ �� �����ϴ�. \x07]")},{preserved})
			TriggerX(FP,{CVar(FP,AvailableStat[CurShopCP+1][2],AtLeast,CurShopCost),CDeaths(FP,AtMost,0,ShopSw[CurShopCP+1]),Accumulate(CurShopCP,AtLeast,2000000000,Ore)},{SetDeaths(CurShopCP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CurShopCP+1]),SetCp(CurShopCP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- ����Ʈ�� ������� ���� ���
		CIfEnd()
		CIfShop(i,41+m,P_NukeCost*(10^m),"\x07[ \x07���� ����, \x08��Ŭ����\x04�� \x07"..(P_NukeAmount*(10^m)).."�� \x04�����Ǿ����ϴ�. (���� : �跰���� ��Ŭ��) \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",nil,SetCVar(FP,Nukes[i+1][2],Add,P_NukeAmount*(10^m)))
		CIfEnd()
		end
		CIfShop(i,45,P_AMCost,"\x07[ \x07���� ����, �� \x1F���� \x08����\x04�� \x04���ϵ˴ϴ�. \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",CDeaths(FP,AtMost,0,AmUsed[i+1]),{SetCVar(FP,AMatter[i+1][2],Add,1),SetCDeaths(FP,SetTo,1000*30,AmUsed[i+1]),})
			CIf(FP,{CDeaths(FP,AtMost,0,ShopSw[i+1]),CDeaths(FP,AtLeast,1,AmUsed[i+1])},{SetDeaths(i,SetTo,150,15)})
				CIf(FP,LocalPlayerID(i))
					DoActionsX(FP,{SetCp(i),PlayWAV("staredit\\wav\\FailSE.ogg"),print_utf8(12,0,"\x07[ \x1F���� \x08����\x04�� ��Ÿ�����Դϴ�. ���� �ð� : "..string.rep("\x0d\x0d\x0d\x0d",28).."�� \x07]")})
					ItoDec(FP,_Div(_ReadF(_Ccode(FP,AmUsed[i+1])),_Mov(1000)),VArr(AmVA,0),2,nil,0)
					_0DPatchX(FP,AmVA,5)
					f_Movcpy(FP,0x640B60 + (12 * 218)+GetStrSize(0,"\x07[ \x1F���� \x08����\x04�� ��Ÿ�����Դϴ�. ���� �ð� : \x0d\x0d\x0d"),VArr(AmVA,0),5*4)
				CIfEnd()
			CIfEnd(SetMemory(0x6509B0,SetTo,FP))
		CIfEnd()
		CDoActions(FP,{
			TSetMemory(_Add(MenuPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(MenuPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			TSetMemoryX(_Add(MenuPtr[i+1],0xA0/4),SetTo,228,0xFFFF);
			SetCDeaths(FP,SetTo,0,ShopSw[i+1])})
		CIfEnd()

		CIf(FP,CVar(FP,BHPtr[i+1][2],AtLeast,1))
		DoActionsX(FP,{SetCDeaths(FP,Add,3,BEff)})
		CWhile(FP,{CDeaths(FP,AtLeast,1,BEff)},{SetCDeaths(FP,Subtract,1,BEff)})
		CIf(FP,{Memory(0x628438,AtLeast,1)})
			DoActions(FP,{
			Simple_SetLoc(0,0,0,0,0);
			MoveLocation(1, 63,i,"Anywhere");
			SetMemory(0x66FABC, SetTo, 131);
			SetMemoryX(0x66A1C4, SetTo, 16*256,0xFF00); -- ������
			SetMemoryX(0x663218, SetTo, 0*16777216,0xFF000000); -- ����
			})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CDoActions(FP,{
			CreateUnit(1,203, "Location 1",FP);
			SetMemoryX(0x66A1C4, SetTo, 0*256,0xFF00); -- ������
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104);
			TSetMemory(_Add(Nextptrs,57),SetTo,0),
			SetMemory(0x66FABC, SetTo, 365)})
		CIfEnd()
		CWhileEnd()

		CDoActions(FP,{
		TSetMemoryX(_Add(BHPtr[i+1],8),SetTo,127*65536,0xFF0000),
		TSetMemory(_Add(BHPtr[i+1],13),SetTo,8000),
		TSetMemoryX(_Add(BHPtr[i+1],18),SetTo,8000,0xFFFF),})
		
		CTrigger(FP,{TMemory(_Add(BHPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,BHSkill[i+1])},{
			SetMemory(0x6509B0,SetTo,i);
			DisplayText("�� \x08�Ҹ� \x04Skill�� \x06Off \x04�Ͽ����ϴ�.",4),
			SetMemory(0x6509B0,SetTo,FP);
			SetCDeaths(FP,SetTo,1,BHSkill[i+1]),
			TSetMemory(_Add(BHPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(BHPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			},1)
		CTrigger(FP,{TMemory(_Add(BHPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,BHSkill[i+1])},{
			SetMemory(0x6509B0,SetTo,i);
			DisplayText("�� \x08�Ҹ� \x04Skill�� \x1FOn \x04�Ͽ����ϴ�.",4),
			SetMemory(0x6509B0,SetTo,FP);
			SetCDeaths(FP,SetTo,0,BHSkill[i+1]),
			TSetMemory(_Add(BHPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(BHPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			},1)
		CIf(FP,{CDeaths(FP,Exactly,0,BHSkill[i+1])})
		Convert_CPosXY(_ReadF(_Add(BHPtr[i+1],10)))
		CreateBullet(211,20,0,CPosX,CPosY,i)
		CIfEnd()

		CTrigger(FP,{TMemoryX(_Add(BHPtr[i+1],19),Exactly,0,0xFF00)},{SetCVar(FP,BHPtr[i+1][2],SetTo,0)},1)
		CIfEnd()

		
		CIf(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtLeast,1,CreateSu[i+1]),Command(i,AtMost,0,12)},{SetCDeaths(FP,SetTo,0,CreateSu[i+1])}) -- ��ȯ �Ǵ� ���ս�
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CMov(FP,SuPtr[i+1],Nextptrs)
			DoActions(FP,CreateUnitWithProperties(1,12,2+i,i,{energy = 100}))
			CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{
					TSetMemory(_Add(Nextptrs,0x98/4),SetTo,0 + 228*65536);
					TSetMemory(_Add(Nextptrs,0x9C/4),SetTo,228 + 228*65536);
					TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
					TSetMemory(_Add(Nextptrs,13),SetTo,_Add(SuSpeed[i+1],3000)),
					TSetMemoryX(_Add(Nextptrs,18),SetTo,3000,0xFFFF),
				})
				CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1)})
					CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
					TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
				CIfEnd()
			CIfEnd()
		CIfEnd()
		CIf(FP,CVar(FP,SuPtr[i+1][2],AtLeast,1))
		CTrigger(FP,{TMemory(_Add(SuPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,0,SuSkill[i+1])},{
			SetMemory(0x6509B0,SetTo,i);
			DisplayText("�� \x07��\x1F��\x1C��\x0E��\x0F��\x10��\x17��\x11��\x08�� \x04�� Skill�� \x06Off \x04�Ͽ����ϴ�.",4),
			SetMemory(0x6509B0,SetTo,FP);
			SetCDeaths(FP,SetTo,1,SuSkill[i+1]),
			TSetMemory(_Add(SuPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(SuPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			},1)
		CTrigger(FP,{TMemory(_Add(SuPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,SuSkill[i+1])},{
			SetMemory(0x6509B0,SetTo,i);
			DisplayText("�� \x07��\x1F��\x1C��\x0E��\x0F��\x10��\x17��\x11��\x08�� \x04�� Skill�� \x1FOn \x04�Ͽ����ϴ�.",4),
			SetMemory(0x6509B0,SetTo,FP);
			SetCDeaths(FP,SetTo,0,SuSkill[i+1]),
			TSetMemory(_Add(SuPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(SuPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			},1)
		CDoActions(FP,{
		TSetMemoryX(_Add(SuPtr[i+1],8),SetTo,127*65536,0xFF0000),
		TSetMemory(_Add(SuPtr[i+1],13),SetTo,_Add(SuSpeed[i+1],3000)),
		TSetMemoryX(_Add(SuPtr[i+1],18),SetTo,3000,0xFFFF),})
		CMov(FP,TempPtr,SuPtr[i+1],2)
		CIf(FP,{TMemory(TempPtr,AtMost,(1670000*256)-256)})
			CIfX(FP,{TMemory(_Mem(_Add(_ReadF(TempPtr),BattleHeal[i+1])),AtLeast,1670000*256)},{TSetMemory(TempPtr,SetTo,1670000*256)})
			CElseX({TSetMemory(TempPtr,Add,BattleHeal[i+1])})
			CIfXEnd()
		CIfEnd()
		CMov(FP,TempPtr2,SuPtr[i+1],24)
		CIf(FP,{TMemoryX(TempPtr2,AtMost,65534*256,0xFFFFFF)})
			CIfX(FP,{TMemory(_Mem(_Add(_ReadF(TempPtr2),BattleHeal[i+1])),AtLeast,65535*256)},{TSetMemoryX(TempPtr2,SetTo,65535*256,0xFFFFFF)})
			CElseX({TSetMemoryX(TempPtr2,Add,BattleHeal[i+1],0xFFFFFF)})
			CIfXEnd()
		CIfEnd()
		CTrigger(FP,{CDeaths(FP,AtLeast,1,SuHeal[i+1])},{SetCDeaths(FP,SetTo,0,SuHeal[i+1]),TSetMemory(TempPtr,SetTo,1670000*256),TSetMemoryX(TempPtr2,SetTo,65535*256,0xFFFFFF)},1)
		CTrigger(FP,{TMemoryX(_Add(SuPtr[i+1],19),Exactly,0,0xFF00)},{SetCVar(FP,SuPtr[i+1][2],SetTo,0)},1)
		CIfEnd()


		CIfX(FP,{Bring(i,AtLeast,1,12,64),CDeaths(FP,Exactly,0,SuSkill[i+1])})

		DoActionsX(FP,{Simple_SetLoc("P"..i+1,0,0,32*10,32*10),MoveLocation("P"..i+1,12,i,64),SetCDeaths(FP,Subtract,1,BSkillT[i+1])})
		TriggerX(FP,{CDeaths(FP,AtMost,0,BSkillT[i+1])},{RemoveUnit(179,i)},{preserved})

		CIf(FP,{Bring(FP,AtLeast,1,"Any unit","P"..i+1),CDeaths(FP,AtMost,0,BSkillT[i+1])},{SetCDeaths(FP,SetTo,10,BSkillT[i+1]),})
		CSPlot(BattleShape,i,179,"P"..i+1,nil,1,32,FP,nil,nil,1)
		DoActions(FP,Order(179,i,64,Patrol,64))
		CIfEnd()

		CElseX({RemoveUnit(179,i)})
		CIfXEnd()
		
		 -- ���۽� �� ������ ������ ����ȭ. TT������ �̿��� ���� ��ȭ�Ҷ��� ������
		CIf(FP,{TTCVar(FP,MarHP[i+1][2],"!=",MarHP2[i+1])})
			CMov(FP,MarHP2[i+1],MarHP[i+1])
			CMov(FP,0x662350 + (MarID[i+1]*4),MarHP2[i+1])
			CMov(FP,0x515BB0+(i*4),_Mul(_Div(_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)),_Mov(256)),_Sub(_Mov(256),P_Armor[i+1])))
		CIfEnd()
		
		CIf(FP,Score(i,Kills,AtLeast,1000))
			CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,{FP,ExScore[i+1][2],nil,"V"},_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
			CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),{FP,ExchangeRate[2],nil,"V"}))
			CMov(FP,ExchangeP,0)
		CIfEnd()

		CMov(FP,0x582174+(4*i),count)
		CAdd(FP,0x582174+(4*i),count)
		CMov(FP,0x57f120+(4*i),ExScore[i+1])
		if Limit == 1 then 
			--CMov(FP,0x57f120+(4*i),Actived_Gun)
		end
		Trigger2(FP,{Memory(0x57f120+(4*i),AtLeast,0x80000000)},{SetMemory(0x57f120+(4*i),SetTo,0)},{preserved}) -- ���� ���̳ʽ� ����
		
		CIfX(FP,Memory(0x582294+(4*i),AtLeast,1001))
			CIfX(FP,Bring(FP,AtLeast,1,147,64))
			f_Div(FP,MarTempSh,MarHP[i+1],_Mov(512))
			CIfX(FP,CVar(FP,MarTempSh[2],AtMost,65535))
				CDoActions(FP,{TSetMemoryX(MarShPtrArr[i+1],SetTo,_Mul(MarTempSh,_Mov(256^MarShMaskRetArr[i+1])),65535*(256^MarShMaskRetArr[i+1]))})
			CElseX()
				DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,65535)})
			CIfXEnd()
			CElseX()
			DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,1000)})
			CIfXEnd()
			Trigger { -- ��ȣ�� ����
				players = {FP},
				conditions = {
					Label(0);
				},
				actions = {
					ModifyUnitShields(All,"Any unit",i,"Anywhere",100);
					SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0x8000,0x8000);
					PreserveTrigger();
				},
			}
			TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,3),Bring(FP, AtMost, 0, 147, 64)},{
				ModifyUnitShields(All,"Any unit",i,"Anywhere",0);},{preserved})
		CElseX()
			DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,1000)})
			TriggerX(FP,{CDeaths(FP,AtMost,0,isSingle)},{SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0,0x8000);},{preserved})
		CIfXEnd()
		DoActionsX(FP,{SetCDeaths(FP,Subtract,1,UpSELemit[i+1]),SetCDeaths(FP,Subtract,1,OrderCool[i+1]),SetCDeaths(FP,Subtract,1,TelCool[i+1]),SetCDeaths(FP,Subtract,1,TelCool2[i+1]),SetCDeaths(FP,Subtract,1,NukeCool[i+1]),SetDeaths(i,Subtract,1,15),SetCDeaths(FP,Subtract,1,ArmorT3[i+1]),SetCDeaths(FP,Add,1,AutoHealT[i+1]),SetCDeaths(FP,Add,1,AutoStimT[i+1])})

		TriggerX(FP,{CDeaths(FP,AtLeast,1,MarDetector[i+1])},{SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0x8000,0x8000),SetCp(i),RunAIScript(P8VON),SetCp(FP)},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoStim[i+1]),CDeaths(FP,AtLeast,150,AutoStimT[i+1])},{SetDeaths(i,Add,1,71);SetCDeaths(FP,Add,1,CUnitFlag);SetCDeaths(FP,SetTo,0,AutoStimT[i+1])},{preserved})
		
		local OrderCooltime = {}
		local OrderCooltimeRecover = {}
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+64,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+66,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+70,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+64,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+66,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+70,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtLeast,1,OrderCool[i+1])},{OrderCooltime},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,Exactly,0,OrderCool[i+1])},{OrderCooltimeRecover},{preserved})
		local TelCooltime = {}
		local TelCooltimeRecover = {}
		table.insert(TelCooltime,SetMemoryB(0x57F27C+(228*i)+68,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(TelCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+68,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		local TelCooltime2 = {}
		local TelCooltimeRecover2 = {}
		table.insert(TelCooltime2,SetMemoryB(0x57F27C+(228*i)+48,SetTo,0)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		table.insert(TelCooltimeRecover2,SetMemoryB(0x57F27C+(228*i)+48,SetTo,1)) -- 9, 34 Ȱ��ȭ�ϰ� ��Ȱ��ȭ�� ���� �ε���
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoStim[i+1]),CDeaths(FP,AtLeast,1,TelCool[i+1])},{TelCooltime},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoStim[i+1]),CDeaths(FP,Exactly,0,TelCool[i+1])},{TelCooltimeRecover},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoHeal[i+1]),CDeaths(FP,AtLeast,1,TelCool2[i+1])},{TelCooltime2},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoHeal[i+1]),CDeaths(FP,Exactly,0,TelCool2[i+1])},{TelCooltimeRecover2},{preserved})
		Trigger2(FP,{Deaths(i,AtLeast,1,197),Deaths(i,AtMost,0,14),Deaths(i,AtMost,0,16)},{SetDeaths(i,SetTo,1,14)},{preserved})
		CElseX()
			DoActions(FP,{SetDeaths(i,SetTo,0,12)}) -- ���÷��̾ �������� ���� ��� ���÷��̾��� ���Ÿ�̸� 0���� ���� 
			TriggerX(FP,{Deaths(i,AtLeast,1,227)},{SetDeaths(i,SetTo,0,227),SetCDeaths(FP,Add,100,PExitFlag)}) -- ������ ��� 1ȸ�� ���� �α��� ���� �۵�
		CIfXEnd()
	end
	DoActions(FP,{SetDeaths(9,SetTo,0,12),SetDeaths(10,SetTo,0,12),SetDeaths(11,SetTo,0,12),SetDeaths(12,SetTo,0,12)}) -- ���÷��̾ �������� ���� ��� ���÷��̾��� ���Ÿ�̸� 0���� ���� 
	
	local TempPos = CreateVar(FP)

	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- ���ݽ��� �� ��ɵ�
		for i = 0, 6 do
			GetLocCenter(73+i,CPosX,CPosY)
			CMov(FP,MulCon[i+1],_Add(CPosX,_Mul(CPosY,_Mov(0x10000))))
		end
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,AtMost,6,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})
			f_SaveCp()
			for i = 0, 6 do
			CIf(FP,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF)})
			Trigger {
				players = {FP},
				conditions = {
					Deaths(i,AtLeast,1,71);
				},
				actions = {
					MoveCp(Add,50*4);
					SetDeathsX(i,SetTo,255*256,0,0xFF00);
					MoveCp(Subtract,50*4);
					PreserveTrigger();
				}
			}
			f_SaveCp()
			local ValCancle = def_sIndex()
			NJump(FP,ValCancle,{TMemory(_Add(BackupCp,6),Exactly,58)})
			CTrigger(FP,{Deaths(i,AtLeast,1,65)}, -- Stop
			{TSetDeathsX(BackupCp,SetTo,1*256,0,0xFF00)},{preserved})
			CIf(FP,{Deaths(i,AtLeast,1,67)}) -- Hold
				f_Read(FP,_Sub(BackupCp,9),TempPos)
				CDoActions(FP,{TSetDeaths(_Add(BackupCp,4),SetTo,0,0),TSetDeathsX(BackupCp,SetTo,107*256,0,0xFF00),TSetDeaths(_Sub(BackupCp,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCp,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCp,15),SetTo,TempPos,0)})
			CIfEnd()
--			CIf(FP,{Deaths(i,AtLeast,1,64)}) -- Move
--				CDoActions(FP,{TSetDeaths(_Add(BackupCp,4),SetTo,0,0),TSetDeathsX(BackupCp,SetTo,6*256,0,0xFF00),TSetDeaths(_Sub(BackupCp,13),SetTo,MulCon[i+1],0),TSetDeaths(_Add(BackupCp,3),SetTo,MulCon[i+1],0),TSetDeaths(_Sub(BackupCp,15),SetTo,MulCon[i+1],0)})
--			CIfEnd()
--			CIf(FP,{Deaths(i,AtLeast,1,66)}) -- Attack
--				CDoActions(FP,{TSetDeaths(_Add(BackupCp,4),SetTo,0,0),TSetDeathsX(BackupCp,SetTo,14*256,0,0xFF00),TSetDeaths(_Sub(BackupCp,13),SetTo,MulCon[i+1],0),TSetDeaths(_Add(BackupCp,3),SetTo,MulCon[i+1],0),TSetDeaths(_Sub(BackupCp,15),SetTo,MulCon[i+1],0)})
--			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,70)}) -- JYD
				f_Read(FP,_Sub(BackupCp,9),TempPos)
				CDoActions(FP,{TSetDeaths(_Add(BackupCp,4),SetTo,0,0),TSetDeathsX(BackupCp,SetTo,187*256,0,0xFF00),TSetDeaths(_Sub(BackupCp,13),SetTo,TempPos,0),TSetDeaths(_Add(BackupCp,3),SetTo,TempPos,0),TSetDeaths(_Sub(BackupCp,15),SetTo,TempPos,0)})
			CIfEnd()
			NJumpEnd(FP,ValCancle)
			f_LoadCp()
			CIfEnd()
			end
			CIfEnd()
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
		CMov(FP,0x6509B0,FP)
		DoActionsX(FP,{SetDeaths(Force1,SetTo,0,71),SetDeaths(Force1,SetTo,0,64),SetDeaths(Force1,SetTo,0,65),SetDeaths(Force1,SetTo,0,66),SetDeaths(Force1,SetTo,0,67),SetDeaths(Force1,SetTo,0,70),SetCDeaths(FP,SetTo,0,CUnitFlag)})
	CIfEnd()
	local HealT = CreateCcode()
	DoActionsX(FP,{SetCDeaths(FP,Add,1,HealT)})
	CIf(FP,CDeaths(FP,AtLeast,50,HealT),SetCDeaths(FP,SetTo,0,HealT))
	for i = 0, 6 do
		Trigger2(FP,{HumanCheck(i,1)},{
			ModifyUnitHitPoints(All,MarID[1],Force1,i+2,100),
			ModifyUnitShields(All,MarID[1],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[2],Force1,i+2,100),
			ModifyUnitShields(All,MarID[2],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[3],Force1,i+2,100),
			ModifyUnitShields(All,MarID[3],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[4],Force1,i+2,100),
			ModifyUnitShields(All,MarID[4],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[5],Force1,i+2,100),
			ModifyUnitShields(All,MarID[5],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[6],Force1,i+2,100),
			ModifyUnitShields(All,MarID[6],Force1,i+2,100),
			ModifyUnitHitPoints(All,MarID[7],Force1,i+2,100),
			ModifyUnitShields(All,MarID[7],Force1,i+2,100),
			ModifyUnitHitPoints(All,10,Force1,i+2,100),
			ModifyUnitShields(All,10,Force1,i+2,100),
			ModifyUnitHitPoints(All,7,Force1,i+2,100),
			ModifyUnitShields(All,7,Force1,i+2,100),
			ModifyUnitHitPoints(All,"Buildings",Force1,i+2,100),
			ModifyUnitShields(All,"Buildings",Force1,i+2,100)},{preserved})
	end
	CIfEnd()

--	Trigger2(FP,{Bring(FP,AtMost,0,147,64)},{ModifyUnitShields(All,"Men",Force1,64,0)},{preserved})
	CIf(FP,{CDeaths(FP,Exactly,0,isSingle),CVar(FP,InputPoint[2],AtLeast,1000)})
	CAdd(FP,OutputPoint,_Div(InputPoint,_Mov(1000)))
	f_Mod(FP,InputPoint,_Mov(1000))
	CIfEnd()
    CallTriggerX(FP,Call_ScorePrint,{CDeaths(FP,AtLeast,1,ScorePrint)},{SetCDeaths(FP,SetTo,0,ScorePrint),SetCDeaths(FP,SetTo,0,isDBossClear)})
	CIfOnce(FP,CDeaths(FP,AtLeast,1,TeamEnchant))
		DoActions2(FP,{
			SetMemory(0x662350 + (4*10),Add,70000*256), -- ü�� ����
			SetMemoryX(0x6647B8, SetTo, 16711680,16711680); -- ���� Ȱ��ȭ
			SetMemoryX(0x657678, Add, 29,0xFFFF); -- ���ݷ� ������
			SetMemory(0x515BCC,Add,256*70); -- �ϸ� �۵� ����
			SetMemoryX(0x6566F8, SetTo, 3,0xFF); -- ���ü���
			SetMemoryX(0x656888, SetTo, 2,0xFFFF); -- ���� 
			SetMemoryX(0x6570C8, SetTo, 6,0xFFFF); -- �߰� 
			SetMemoryX(0x657780, SetTo, 10,0xFFFF); -- �ܰ�
			SetMemory(0x657470, SetTo, 32*7); -- ��Ÿ�
		CopyCpAction({DisplayTextX("\t\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x1F���������ԣţ��͡��ţΣãȣ��Σԣţġ�������\n\n\n\x13\x04�������� \x1F�� ��ȭ ȿ��\x04�� �����Ͽ����ϴ�.\n\x13\x04Normal Marine�� ������ ���� ���Ǿ����ϴ�.\n\n\n\x13\x1F���������ԣţ��͡��ţΣãȣ��Σԣţġ�������\n\x13\x04������������������������������������������������������������������������������������������������������������",4),
		PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),},HumanPlayers,FP)
	})
	CIfEnd()
	
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- ü��ǥ��
	SelPTR,SelEPD,SelHP,SelSh,SelPl,SelMaxHP,PercentCalc = CreateVariables(7)
	f_Read(FP,0x6284B8,SelPTR,SelEPD)
	f_Read(FP,_Add(SelEPD,2),SelHP)
	f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
	f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
	f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
	CMov(FP,SelMaxHP,_ReadF(_Add(SelUID,_Mov(EPD(0x662350)))))
	CTrigger(FP,{CVar(FP,SelPl[2],Exactly,7),CVar(FP,B1_H[2],AtLeast,1)},{TSetCVar(FP,SelHP[2],Add,B1_K)},1)
	f_Div(FP,SelHP,_Mov(256))
	f_Div(FP,SelSh,_Mov(256))
	f_Div(FP,SelMaxHP,_Mov(256))
	CMov(FP,PercentCalc,_Div(_Mul(SelHP,3),SelMaxHP))
	CIf(FP,{CV(SelUID,128)})
	PointTamp = CreateVar(FP)
		for i = 0, 6 do
			CIf(FP,{CV(SelPl,i)})
			CTrigger(FP, CV(SelPl,i), {TSetCVar(FP,PointTamp[2],SetTo,AvailableStat[i+1])}, 1)
			CIfEnd()
		end
		CS__ItoCustom(FP,SVA1(Str5,12),PointTamp,nil,nil,10,1,nil,"\x070",0x07,{0,1,2,3,4,5,6,7,8,9})
		
	CS__InputVA(FP,iTbl4,0,Str5,Str5s,nil,0,Str5s)


	CIfEnd()
	CIf(FP,{CV(SelUID,111)})
	NukesTmp = CreateVar(FP)
		for i = 0, 6 do
			CTrigger(FP, CV(SelPl,i), {TSetCVar(FP,NukesTmp[2],SetTo,Nukes[i+1])}, 1)
		end
		CS__ItoCustom(FP,SVA1(Str4,11),NukesTmp,nil,nil,10,1,nil,"\x080",0x08,{0,1,2,3,4,5,6,7,8,9})
		--DoActionsX(FP,SetCSVA1(SVA1(Str4,Str4s-1),SetTo,0,0xFFFFFFFF))
		CS__InputVA(FP,iTbl3,0,Str4,Str4s,nil,0,Str4s)
	CIfEnd()
	CS__ItoCustom(FP,SVA1(Str3,13),SelMaxHP,nil,0xFFFF0000,10,1,nil,"0",nil,{0,1,2,3,4,5,6,7,8,9})
	CS__ItoCustom(FP,SVA1(Str3,0),SelHP,nil,0xFFFF0000,10,1,nil,"0",nil,{0,1,2,3,4,5,6,7,8,9})
	CS__ItoCustom(FP,SVA1(Str3,0),SelSh,nil,0xFFFF0000,{10,5},1,{"\x0D","\x0D","\x0D","0","0"},nil,nil,{25,26,27,28,30})
	TBLN1T = {}
	TBLN2T = {}
	TBLN1T1 = {}
	TBLN1T2 = {}
	TBLN1T3 = {}
	for i = 0, 9 do
--			table.insert(TBLN1T, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
--			table.insert(TBLN2T, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
		table.insert(TBLN1T, SetCSVA1(SVA1(Str3,13+i),SetTo,0x04,0xFF))
		table.insert(TBLN2T, SetCSVA1(SVA1(Str3,13+i),SetTo,0x1C,0xFF))
		table.insert(TBLN1T1, SetCSVA1(SVA1(Str3,i),SetTo,0x07,0xFF))
		table.insert(TBLN1T2, SetCSVA1(SVA1(Str3,i),SetTo,0x17,0xFF))
		table.insert(TBLN1T3, SetCSVA1(SVA1(Str3,i),SetTo,0x08,0xFF))
	end
	for i = 0, 3 do
		table.insert(TBLN1T, SetCSVA1(SVA1(Str3,25+i),SetTo,0x1C,0xFF))
		table.insert(TBLN2T, SetCSVA1(SVA1(Str3,25+i),SetTo,0x1F,0xFF))
	end
	table.insert(TBLN1T, SetCSVA1(SVA1(Str3,30),SetTo,0x1C,0xFF))
	table.insert(TBLN2T, SetCSVA1(SVA1(Str3,30),SetTo,0x1F,0xFF))

	TriggerX(FP,{CV(PercentCalc,2,AtLeast)},TBLN1T1,{preserved})
	TriggerX(FP,{CV(PercentCalc,1)},TBLN1T2,{preserved})
	TriggerX(FP,{CV(PercentCalc,0)},TBLN1T3,{preserved})

	DoActionsX(FP,TBLN1T)
	CS__InputVA(FP,iTbl1,0,Str3,Str3s,nil,0,Str3s)
	DoActionsX(FP,TBLN2T)
	CS__InputVA(FP,iTbl2,0,Str3,Str3s,nil,0,Str3s)

	CIfEnd()


	CIfOnce(FP,{Memory(EvCheckPtr,AtLeast,2)})
	DoActions(FP,{CopyCpAction({DisplayTextX("\t\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x1F���������ţ֣ţΣԡ�������\n\n\n\x13\x1F�̺�Ʈ\x04�� �����Ǿ����ϴ�.\n\x13\x07���� ����Ʈ ȹ�淮\x04�� �������� \x1F����\x04�Ͽ����ϴ�.\n\n\n\x13\x1F���������ţ֣ţΣԡ�������\n\x13\x04������������������������������������������������������������������������������������������������������������",4),
	PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),},HumanPlayers,FP)})
	CMov(FP,MulPoint,_ReadF(EvCheckPtr))
	CIfEnd()
end