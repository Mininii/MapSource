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
	local MultiHold = Create_VTable(7,nil,FP)
	local MultiStop = Create_VTable(7,nil,FP)
	
	local AtkUpgradeMaskRetArr,AtkUpgradePtrArr,NormalUpgradeMaskRetArr,
	NormalUpgradePtrArr,DefUpgradeMaskRetArr,DefUpgradePtrArr,AtkFactorMaskRetArr,
	AtkFactorPtrArr,DefFactorMaskRetArr,DefFactorPtrArr,MarShMaskRetArr,MarShPtrArr = CreateTables(12)
	local SelUID = CreateVar(FP)
	local BarRally = CreateVarArr(7,FP)
	local MulCon = CreateVarArr(7,FP)
	local ExchangeP = CreateVar(FP)
	local DelayMedic = Create_CCTable(7)
	local ShUsed = Create_CCTable(7)
	local OldAvStat = Create_VTable(7,nil,FP)
	local MenuPtr = Create_VTable(7,nil,FP)
	
	local MarCreate = Create_CCTable(7)
	local MarCreate2 = Create_CCTable(7)
	local UpSELemit = Create_CCTable(7)
	local NukeCool = CreateCcodeArr(7)
	local TempStat = CreateVar(FP)
	local TempStat2 = CreateVar(FP)
	local TempGiveV = CreateVar(FP)
	local TempGivePV = CreateVar(FP)
	local GiveVA = CreateVArray(FP,7)
	local ArmorT3 = CreateCcodeArr(7)
	local ShopSw = CreateCcodeArr(7)

	
	local NsW = CreateCcode()
	
	

	--����
	local Nukes = CreateVarArr(7,FP)
	local Supply = {}
	for i = 1, 7 do
		Supply[i] = CreateVar2(FP,nil,nil,24*3)
	end
	local MultiStimPack = CreateVarArr(7,FP)
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
	InsertKey[1] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04�� ���� Ŭ������ ������ ������ \n\x13\x08���� ���� \x04�� \x1F�޼��� �ܰ�\x04�� \x07���ھ�(����)\x04�� ������ ������ ��Ÿ���ϴ�.\n\x13\x04����� �Ѱ踦 ������ ������!\n\x13\x07�̷������� ���� ���� �ܰ�� ���׷��̵�\x04�� �����մϴ�.\n\x13\x04255 ���׷��̵� �Ϸ� �� \x1F0���� ���� �� ���� ���ݷ��� �״�� ���µ˴ϴ�.\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04���ռҴ� �߾� ���� ������ �ִ°����� ���ø� �˴ϴ�.\n\x13\x04PgUp, PgDn Ű�� ������ �������� �ٲ� �� �ֽ��ϴ�.\n\x13\x04�������������������������������������������������� Page 1/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	InsertKey[2] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04\x1CSCArchive \x04���� (���Ǵ� ����ī�� ã���ּ���.)\n\x13\x04���� ���尡�� �����ʹ� \x11�ְ����(Level, Score)\x04�� \x19���� ����Ʈ \x04�Դϴ�. �׿� \x08���� �Ұ����մϴ�.\n\x13\x04���� ����Ʈ�� �پ��� �̷ο� ȿ���� ���� �� �ֽ��ϴ�.\n\x13\x07��, \x0F32Bit ȯ�� \x04��Ÿũ����Ʈ������ �̿��Ͻ� �� ������\n\x13\x07 ������ �ε�� \x1D1 Level \x04�������������� �����մϴ�.\n\x13\x04�����͸� �ҷ����� ���ߴٸ� ���� ������� ����帳�ϴ�.\n\x13\x07������ ����\x04�� �� �������� Ŭ����� \x07�ڵ�����˴ϴ�. \x04�Ǵ� \x18�������� \x04�����մϴ�.\n\n\x13\x04�������������������������������������������������� Page 2/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
	InsertKey[3] = "\x13\x04����������������������������������������������������������������������������������������������������������������\n\x13\x04��������Ʈ ������ ������ ���۳��̵��� ���� �޶����ϴ�.\n\x13\x04\x0E�ţ���\x04 = ������X \x0F�Σ������\x04 = +5\n\x13\x04\x08�ȣ���\x04 = +10 \x10�ɣ�����\x04 = +15\n\x13\x04���� ������ Ŭ������ ���������� ��ġ�� �ջ�Ǿ� �������ϴ�.\n\x13\x04\n\x13\x04Ex) 8�������� Ŭ���� + \x08�ȣ���\x04���̵� = 8 + 10 = +18 ����\n\x13\x04\n\x13\x04��, ���� ���̵����� ������ ���� �� ���� ��������Ʈ�� ���� �� �ֽ��ϴ�.\n\x13\x04�������������������������������������������������� Page 3/3 ��������������������������������������������������\n\x13\x17�ạ̃ϣӣš������ģţ̣ţԣš��ˣţ�"
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
	local LocalCcode_Stim = CreateCcode()
	local LocalCcode_Multi = CreateCcode()
	local LocalCcode_SkillUnit = CreateCcode()
	
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,LocalCcode_Stim),SetCDeaths(FP,SetTo,0,LocalCcode_Multi),SetCDeaths(FP,SetTo,0,LocalCcode_SkillUnit)})
		PlayerInfoT = "\x12\x10�� \x08Y\x04our \x0FL\x04evel :\x1F 0000000000 \x04�� Score :\x07 0000000000 \x04�� \x07StatPoint \x04: 0000000000 / 0000000000 \x10��\r\n"
		PlayerItemT = "\x12\x10�� \x0FI\x04tems �� \x0E�ۼ�Ʈ \x1E���� : 000 / 255 \x04�� �� ü�� ��ȭ : 000 / 255 \x04�� ���� : F9\x10��"
	
		TempVT = CreateVarArr(7,FP)
		for i = 0, 6 do
		CIf(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,SetTo,2,CPConsoleToggle)}) -- �������ͽ� ����=
		CMov(FP,TempVT[3],NewMaxLevel[i+1])
		CMov(FP,TempVT[4],OldMaxScore[i+1])
		CMov(FP,TempVT[5],NewAvStat[i+1])
		TriggerX(FP,{CVar(FP,MultiStimPack[i+1][2],AtLeast,1)},{SetCDeaths(FP,SetTo,1,LocalCcode_Stim)},{preserved})
		CIfEnd({SetMemory(0x6509B0,SetTo,FP)})
		end
		ItoDec(FP,TempVT[1],VArr(AvailableStatVA,0),2,nil,0)
		ItoDec(FP,TempVT[2],VArr(CurrentStatVA,0),2,nil,0)
		ItoDec(FP,TempVT[3],VArr(MaxLevelVA,0),2,0x1F,0)
		ItoDec(FP,TempVT[4],VArr(MaxScoreVA,0),2,0x07,0)
		
		
		f_Movcpy(FP,_Add(StatusStrPtr1,StatPT[2]),VArr(AvailableStatVA,0),4*4)
		f_Movcpy(FP,_Add(StatusStrPtr1,StatPT[2]+DBossT2[2]+(5*4)),VArr(CurrentStatVA,0),4*4)
		f_Movcpy(FP,_Add(HiScoreStrPtr,HiScoreT1[2]),VArr(MaxLevelVA,0),4*4)
		f_Movcpy(FP,_Add(HiScoreStrPtr,HiScoreT1[2]+HiScoreT2[2]+(5*4)),VArr(MaxScoreVA,0),4*4)



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
		--DisplayText("\x0D\x0D\x0DNuke".._0D,4),
		
	})

--	function TEST() --

--	local PlayerID = CAPrintPlayerID 
--	local Data = {{{0,9},{"��",{0x1000000}}}} 
--	CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 
--	CA__SetValue(Str1,"\x10�� \x07LV\x04. 000 \x04�� Stat : 0000000000 \x10��",nil,0) 
--	CA__SetValue(Str1,"\x10�� UnitCount : 0000 \x04�� Cannot 0\x04/\x104 \x10��",nil,0) 
--	CA__ItoCustom(SVA1(Str1,0),RedNumber,nil,nil,{10,3},1,"\x06��",nil,0x06,{5,6,7},Data) 
--	CA__ItoCustom(SVA1(Str1,0),count,nil,nil,{10,4},1,"��",nil,nil,{11,12,13,14},Data) 
--	CA__ItoCustom(SVA1(Str1,0),CanC,nil,nil,{10,1},1,"\x04��",nil,0x04,{18},Data) 
--	
--	function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
--		if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
--		TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
--	end
--	function SetStr1Data(Index,ConActTable,Flags) --{{{"CD"or "V",CDVIndex,CType,CValue},...},Value,Mask}
--		for j, k in pairs(ConActTable) do
--			local X = {}
--			for l, m in pairs(k[1]) do
--				if m[1] == "CD" then
--					table.insert(X,CD(m[2],m[4],m[3]))
--				elseif m[1] == "V" then
--					table.insert(X,CV(m[2],m[4],m[3]))
--				else PushErrorMsg("SetStr1Data_InputData_Error") end
--			end
--	
--			CS__InputTA(FP,{X},SVA1(Str1,Index),k[2],k[3],Flags)
--		end
--	end
--	
--	TriggerX(FP,{Command(FP,AtMost,0,190)},{
--		SetCSVA1(SVA1(Str1,18),SetTo,0x0D0D0D0D,0xFFFFFFFF),
--		SetCSVA1(SVA1(Str1,19),SetTo,0x0D0D0D0D,0xFFFFFFFF),
--		SetCSVA1(SVA1(Str1,20),SetTo,0x0D0D0D0D,0xFFFFFFFF),
--		SetCSVA1(SVA1(Str1,21),SetTo,0x0D0D0D0D,0xFFFFFFFF),
--	},{preserved})
--	
--	
--	CanCTC = CreateCcode()
--	SetStr1Data(10,
--	{
--		{
--			{
--				{"V",count,AtMost,399}
--			},14,0xFF
--		},
--		{
--			{
--				{"V",count,AtLeast,400},
--				{"V",count,AtMost,799}
--			},15,0xFF
--		},
--		{
--			{
--				{"V",count,AtLeast,800},
--				{"V",count,AtMost,1199}
--			},0x11,0xFF
--		},
--		{
--			{
--				{"V",count,AtLeast,1200},
--				{"V",count,AtMost,1499}
--			},08,0xFF
--		},
--		{
--			{
--				{"V",count,AtLeast,1500},
--				{"CD",CanCTC,Exactly,1}
--			},0x11,0xFF
--		}
--	})
--	
--	CanColorT = {0x0E,0x0F,0x11,0x08,0x1F}
--	for j, k in pairs(CanColorT) do
--		CS__InputTA(PlayerID,{CV(CanC,j-1)},SVA1(Str1,18),k,0xFF)
--	end
--	CS__InputTA(PlayerID,{CD(CanCT,1,AtLeast),CD(CanCTC,1)},SVA1(Str1,18),0x04,0xFF)
--	TriggerX(FP,{CD(CanCTC,2)},{SetCD(CanCTC,0)},{preserved})
--	
--	 CA__InputVA(40*1,Str1,Str1s,nil,40*1,40*2-3)
--	 CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 
--	
--	CIfX(FP,{CDeaths(FP,AtMost,0,Theorist)})
--	
--	 CA__SetValue(Str1,"\x07��\x11��\x08��\x07�� \x07��\x07��\x04��������\x04��\x1C��\x1C�� \x04�� \x07��\x07��\x07��\x04��������\x04����\x04�� \x07��\x08��\x11��\x07��",nil,0) 
--	 CA__ItoCustom(SVA1(Str1,0),Level,nil,nil,{10,2},1,"��",nil,nil,{8,9},Data) 
--	 CA__ItoCustom(SVA1(Str1,0),CurExpTmp,nil,nil,{10,4},1,"\x04��",nil,{0x04,0x04,0x04,0x04},{20,21,22,24},Data) 
--	
--	 TriggerX(FP,{CV(Level,50)},{SetCSVA1(SVA1(Str1,23),SetTo,0x0D0D0D0D,0xFFFFFFFF),SetCSVA1(SVA1(Str1,24),SetTo,0x0D0D0D0D,0xFFFFFFFF)},{preserved})
--	 function LevelIStrColor(Color,ValueArr)
--		TriggerX(FP,{CVar(FP,Level[2],AtLeast,ValueArr[1]),CVar(FP,Level[2],AtMost,ValueArr[2])},{
--			SetCSVA1(SVA1(Str1,8),SetTo,Color,0xFF),
--			SetCSVA1(SVA1(Str1,9),SetTo,Color,0xFF),
--		},{preserved})
--	 end
--	
--	 LevelIStrColor(0x0E,{0,9})
--	 LevelIStrColor(0x0F,{10,19})
--	 LevelIStrColor(0x18,{20,29})
--	 LevelIStrColor(0x11,{30,39})
--	 LevelIStrColor(0x08,{40,49})
--	 LevelIStrColor(0x1F,{50,50})
--	
--	CElseX()
--	CIfOnce(FP)
--	CA__SetMemoryX((40*2)-1,0x0D0D0D0D,0xFFFFFFFF,1)
--	CA__SetMemoryX((40*2)-2,0x0D0D0D0D,0xFFFFFFFF,1)
--	CA__SetMemoryX((40*3)-1,0x0D0D0D0D,0xFFFFFFFF,1)
--	CA__SetMemoryX((40*3)-2,0x0D0D0D0D,0xFFFFFFFF,1)
--	CIfEnd()
--	CIfXEnd()
--	CIf(FP,CV(LevelUpEff,1,AtLeast))
--	local LevelUpEffTmp2 = CreateVar(FP)
--	local LevelUpEffTmp = CreateVarArr(8,FP)
--	LVEFT = {}
--	for i = 1, 8 do
--		CMov(FP,LevelUpEffTmp[i],LevelUpEffTmp2)
--		table.insert(LVEFT,{SubV(LevelUpEffTmp[i],604*i)})
--	end
--	DoActionsX(FP,LVEFT)
--	
--	LVUpEffArr = {0x08,0x0E,0x0F,0x10,0x11,0x18,0x16,0x17}
--	for j,k in pairs(LVUpEffArr) do
--		CA__Input(k,SVA1(Str1,LevelUpEffTmp[j]),0xFF) 
--	end
--	TriggerX(FP,{CD(CanCTC,1)},{
--		SetCSVA1(SVA1(Str1,8),SetTo,0x04,0xFF),
--		SetCSVA1(SVA1(Str1,9),SetTo,0x04,0xFF),
--		SetCSVA1(SVA1(Str1,20),SetTo,0x04,0xFF),
--		SetCSVA1(SVA1(Str1,21),SetTo,0x04,0xFF),
--		SetCSVA1(SVA1(Str1,22),SetTo,0x04,0xFF),
--		SetCSVA1(SVA1(Str1,23),SetTo,0x04,0xFF),
--		SetCSVA1(SVA1(Str1,24),SetTo,0x04,0xFF),
--		SetCSVA1(SVA1(Str1,25),SetTo,0x04,0xFF),
--	},{preserved})
--	LVUPEffT= CreateCcode()
--	CAdd(FP,_Ccode(FP,LVUPEffT),1)
--	
--	TriggerX(FP,{CD(LVUPEffT,3,AtLeast)},{AddV(LevelUpEffTmp2,604),SetCD(LVUPEffT,0)},{preserved})
--	TriggerX(FP,{CV(LevelUpEffTmp2,40*604,AtLeast)},{SetV(LevelUpEff,0),SetV(LevelUpEffTmp2,0)},{preserved})
--	CIfEnd()
--	DoActionsX(FP,{AddCD(CanCTC,1)})
--	 CA__InputVA(40*2,Str1,Str1s,nil,40*2,40*3)
--	 CA__SetValue(Str1,MakeiStrVoid(38),0xFFFFFFFF,0) 
--	end 
--	CAPrint(iStr1,{Force1,Force5},{1,0,0,0,1,0,0,0},"TEST",FP,{CD(OPJump,1,AtLeast)}) --
--
--

	CMov(FP,0x640B58,TextRet)
	CIfXEnd()



	Trigger2X(FP,{Memory(0x596A38, Exactly, 0),Memory(0x596A44, Exactly, 0),CDeaths(FP,Exactly,1,KeyToggle)},{SetCDeaths(FP,SetTo,0,KeyToggle)},{preserved})
	
	Trigger2X(FP,{Memory(0x596A44, Exactly, 65536)},{SetCDeaths(FP,SetTo,0,DeleteToggle),DisplayText(string.rep("\n", 20),4)},{preserved})

	TriggerX(FP,{Deaths(CurrentPlayer,Exactly,0,CPConsole),CDeaths(FP,AtLeast,1,CPConsoleToggle)},{DisplayText(string.rep("\n", 20),4),SetCDeaths(FP,Subtract,1,CPConsoleToggle)},{preserved})



	for i = 0, 6 do -- ���÷��̾�
		DoActions(FP,SetMemory(0x6509B0,SetTo,i)) -- CP ���� 
		Trigger2(i,{Deaths(i,AtLeast,1,149),LocalPlayerID(i)},{
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
			DisplayText("\x13\x07�� \x04ä�� A10 �� �湮�Ͽ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
			SetMemory(0xCDDDCDDC,SetTo,1);
		})
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
				SetResources(i,SetTo,0x7FFFFFFF-1,Ore);
				PreserveTrigger();
			},
		}
		MC = {65,67}
		for j, k in pairs(MC) do
			local X = {}
			local Y = {}
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
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1),LocalPlayerID(i)},{print_utf8(12,0,"\x07�� \x1F��� �÷��̾�\x04��"..PlayerString[j+1].."\x04���� �����Ǿ����ϴ�. �ݾ��� �Է����ּ���. (�ִ� 830��)\x07��")},1,1)
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,j+1,151),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
				end

				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,0),LocalPlayerID(i)},{print_utf8(12,0,"\x07�� "..PlayerString[j+1].."\x04��(��) �������� �ʽ��ϴ�. \x07��")},1,1)
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,0)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
				TriggerX(FP,{Deaths(i,Exactly,j+1,151),HumanCheck(j,0)},{SetDeaths(i,SetTo,0,151)},{preserved})
			end
			CIfX(FP,{HumanCheck(i,1),Deaths(i,AtLeast,1,150),Deaths(i,AtMost,220000,150),Deaths(i,AtLeast,1,151)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15);})

				f_Read(FP,0x58A364+(48*150)+(4*i),TempGiveV)
				f_Read(FP,0x58A364+(48*151)+(4*i),TempGivePV)


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
				print_utf8(12,0,"\x07[ \x1F�̳׶� \x03��ι�� \x041. �����ư(��)���� �� ���ڹ�ư���� �÷��̾� ���� 2. ���ڸ� ä��â�� �Է�.(�ִ� 830��) ESC : �ݱ�\x07 ]")
			},{preserved}) -- 13���� ����Ʈ Ʈ���� �÷��̾ FP�� ������ Ʈ���� ������ 1P���� 8P���� ����Ǳ� ����. i�� �ϰԵ� ��� �̰� ������ �����ִ� CText�� ���̰� �ȴ�. 


		--CPConsole
		TriggerX(FP,{CDeaths(FP,AtLeast,15*1000,FuncT[i+1])},{SetDeaths(i,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,0,151),},{preserved})
		TriggerX(FP,{Deaths(i,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,0,CPConsole),SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,0,151)},{preserved})
		CIfEnd(SetMemory(0x6509B0,SetTo,i))
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

			

		UnitLimit(i,7,25,"SCV��",500)
		UnitLimit(i,125,15,"��Ŀ��",8000)
		UnitLimit(i,124,15,"�ͷ���",4000)
		


		CIfX(FP,HumanCheck(i,1)) -- FP�� �����ϴ� �ý��� �κ� Ʈ����. ���÷��̾ ������� ����ȴ�.


		--SCA ������ ������ ����
		CIfX(FP,{TTDeaths(i,">",OldStat[i+1],4)})
			f_Read(FP,0x58A364+(48*4)+(4*i),TempStat)
			CSub(FP,TempStat2,TempStat,OldStat[i+1])
			CMov(FP,OldStat[i+1],TempStat)
			CAdd(FP,OldAvStat[i+1],TempStat2)
		CElseIfX(TTDeaths(i,"<",OldStat[i+1],4))
			CDoActions(FP,{TSetDeaths(i,SetTo,OldStat[i+1],4)})
		CIfXEnd()
		CIfX(FP,{TTDeaths(i,">",NewStat[i+1],4)})
			f_Read(FP,0x58A364+(48*4)+(4*i),TempStat)
			CSub(FP,TempStat2,TempStat,NewStat[i+1])
			CMov(FP,NewStat[i+1],TempStat)
			CAdd(FP,NewAvStat[i+1],TempStat2)
		CElseIfX(TTDeaths(i,"<",NewStat[i+1],4))
			CDoActions(FP,{TSetDeaths(i,SetTo,NewStat[i+1],4)})
		CIfXEnd()

		CIfX(FP,{TTDeaths(i,">",OldMaxLevel[i+1],6)})
			f_Read(FP,0x58A364+(48*6)+(4*i),TempStat)
			CMov(FP,OldMaxLevel[i+1],TempStat)
		CElseIfX(TTDeaths(i,"<",OldMaxLevel[i+1],6))
			CDoActions(FP,{TSetDeaths(i,SetTo,OldMaxLevel[i+1],6)})
		CIfXEnd()
		CIfX(FP,{TTDeaths(i,">",NewMaxLevel[i+1],18)})
			f_Read(FP,0x58A364+(48*18)+(4*i),TempStat)
			CMov(FP,NewMaxLevel[i+1],TempStat)
		CElseIfX(TTDeaths(i,"<",NewMaxLevel[i+1],18))
			CDoActions(FP,{TSetDeaths(i,SetTo,NewMaxLevel[i+1],18)})
		CIfXEnd()
		CIfX(FP,{TTDeaths(i,">",OldMaxScore[i+1],24)})
			f_Read(FP,0x58A364+(48*24)+(4*i),TempStat)
			CMov(FP,OldMaxScore[i+1],TempStat)
		CElseIfX(TTDeaths(i,"<",OldMaxScore[i+1],24))
			CDoActions(FP,{TSetDeaths(i,SetTo,OldMaxScore[i+1],24)})
		CIfXEnd()
		CIfX(FP,{TTDeaths(i,">",ExScore[i+1],36)})
			f_Read(FP,0x58A364+(48*36)+(4*i),TempStat)
			CMov(FP,ExScore[i+1],TempStat)
		CElseIfX(TTDeaths(i,"<",ExScore[i+1],36))
			CDoActions(FP,{TSetDeaths(i,SetTo,ExScore[i+1],36)})
		CIfXEnd()
		CIfX(FP,{TTDeaths(i,">",UsedOldP[i+1],37)})
			f_Read(FP,0x58A364+(48*37)+(4*i),TempStat)
			CMov(FP,UsedOldP[i+1],TempStat)
		CElseIfX(TTDeaths(i,"<",UsedOldP[i+1],37))
			CDoActions(FP,{TSetDeaths(i,SetTo,UsedOldP[i+1],37)})
		CIfXEnd()
		
		CIf(FP,{Bring(i,AtLeast,1,28,64)},{
			RemoveUnitAt(1,28,"Anywhere",i),
		})
		CIfX(FP,{TMemory(_Mem(_ReadF(0x5821D4 + (4*i))),AtLeast,_ReadF(0x582204 + (4*i)))})
			TriggerX(FP,{Accumulate(i,AtLeast,30000*3,Ore),Deaths(i,AtLeast,36,126)},{
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1F����\x04�� �Ҹ��Ͽ� \x1FExceeD \x1BM\x04arine �� \x073�� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F90,000 O r e \x07��",4),
				SetMemory(0x6509B0,SetTo,FP),
				SetResources(i,Subtract,30000*3,Ore);
				SetCDeaths(FP,Add,3,MarCreate[i+1]),
			},{preserved})
			Trigger { -- ���� ���� �ȵ�
				players = {FP},
				conditions = {
				Deaths(i,AtMost,35,126);
			},
			  actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x073�� \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - \x1FExceeD \x1BM\x04arine \x0436�� ����) \x07��",4);
				SetMemory(0x6509B0,SetTo,FP),
				PreserveTrigger();
			},
		}
		    Trigger { -- ���� ���� �ȵ�
		    players = {FP},
		    conditions = {
			Accumulate(i,AtMost,(30000*3)-1,Ore),
			Deaths(i,AtLeast,36,126),
		},
		  actions = {
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x073�� \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - \x1F90,000 Ore ����) \x07��",4);
			SetMemory(0x6509B0,SetTo,FP),
			PreserveTrigger();
			},
	  	}
		CElseX({
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07�� \x1FExceeD \x1BM\x04arine \x073�� \x19���� ��ȯ\x04 ������ ���� �ʽ��ϴ�. (���� - �α��� ����) \x07��",4);
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
		
		CIf(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,255*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))},{SetMemoryX(AtkUpgradePtrArr[i+1],SetTo,0*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04��������\x1C���ݷ� ���׷��̵�\x04�� 255�� �Ѿ� �Ѱ踦 �����մϴ�.\x04��������\n\x13\x04��������\x07���׷��̵带 \x040���� �缳���ϰ� \x17���ݷ� ��ġ�� ����\x04�Ǿ����ϴ�.\x04��������",4),
			SetMemory(0x6509B0,SetTo,FP),
			SetMemoryW(0x656EB0 + (MarWep[i+1]*2),Add,MarDamageFactor*255),
			SetCVar(FP,AtkUpCompCount[i+1][2],Add,1),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{preserved})
		TriggerX(FP,{CVar(FP,AtkUpCompCount[i+1][2],AtLeast,20)},{SetCVar(FP,AtkFactorV[i+1][2],Add,1)},{preserved})--CVar(FP,AtkUpCompCount[i+1][2],AtLeast,151)
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
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{preserved})
		TriggerX(FP,{CVar(FP,DefUpCompCount[i+1][2],AtLeast,20)},{SetCVar(FP,DefFactorV[i+1][2],Add,4)},{preserved})--CVar(FP,DefUpCompCount[i+1][2],AtLeast,51)
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
		
		TriggerX(FP,{CVar(FP,MarHP[i+1][2],AtLeast,160000*256)},{
			SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 19,SetTo,0),
			SetMemoryB(0x58D088 + (i * 46) + 20,SetTo,0),
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
	TriggerX(FP,{CVar(FP,NewStat[CP+1][2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	TriggerX(FP,{CVar(FP,NewStat[CP+1][2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCVar(FP,NewStat[CP+1][2],Subtract,Cost),SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCp(FP),Actions},{preserved})	-- ����Ʈ�� ����� ���

	TriggerX(FP,{CVar(FP,NewStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	TriggerX(FP,{CVar(FP,NewStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- ����Ʈ�� ������� ���� ���
end
function CIfShopOld(CP,ID,Cost,ContentStr,DisContentStr,Conditions,Actions)
	CIf(FP,{TMemory(_Add(MenuPtr[CP+1],0x98/4),Exactly,0 + ID*65536)})
	CurShopCost = Cost
	CurShopCP = CP
	CurShopCond = Conditions
	CallTrigger(FP,Call_Print13[CP+1])
	CTrigger(FP,{TCVar(FP,OldAvStat[CP+1][2],AtLeast,_Add(_Mov(Cost),_Sub(OldAvStat[CP+1],UsedOldP[CP+1]))),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP),Conditions},{print_utf8(12,0,ContentStr)},{preserved})
	CTrigger(FP,{TCVar(FP,OldAvStat[CP+1][2],AtLeast,_Add(_Mov(Cost),_Sub(OldAvStat[CP+1],UsedOldP[CP+1]))),CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCVar(FP,UsedOldP[CP+1][2],Add,Cost),SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCp(FP),Actions},{preserved})	-- ����Ʈ�� ����� ���

	CTrigger(FP,{TCVar(FP,OldAvStat[CP+1][2],AtMost,_Add(_Mov(Cost-1),_Sub(OldAvStat[CP+1],UsedOldP[CP+1]))),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	CTrigger(FP,{TCVar(FP,OldAvStat[CP+1][2],AtMost,_Add(_Mov(Cost-1),_Sub(OldAvStat[CP+1],UsedOldP[CP+1]))),CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- ����Ʈ�� ������� ���� ���
end
		CIf(FP,CVar(FP,MenuPtr[i+1][2],AtLeast,1))
		for m = 0, 0 do
		CIfShop(i,41+m,0,"\x07[ \x08��Ŭ����\x04�� \x07����\x04�Ǿ����ϴ�. (���� : �跰���� ��Ŭ��) \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",{CVar(FP,NukesUsage[i+1][2],AtLeast,1),CVar(FP,Nukes[i+1][2],AtMost,0)},{SetCVar(FP,NukesUsage[i+1][2],Subtract,1),SetCVar(FP,Nukes[i+1][2],Add,1),SetCp(i),PlayWAV("sound\\Terran\\Advisor\\TAdUpd07.WAV"),SetCp(FP)})
		
		TriggerX(FP,{CVar(FP,NukesUsage[i+1][2],AtMost,0),CDeaths(FP,AtMost,0,ShopSw[i+1]),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x04�� �̻� \x08��Ŭ����\x04�� ����� �� �����ϴ�. \x07]")},{preserved})
		TriggerX(FP,{CVar(FP,NukesUsage[i+1][2],AtMost,0),CDeaths(FP,AtMost,0,ShopSw[i+1]),},{SetDeaths(i,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[i+1]),SetCp(i),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	
		CIfEnd()
		end
		CIfShop(i,42,P_StimCost,"\x07[ \x07���� ����, \x1B���� ������ \x04����� ����� �� �ֽ��ϴ�. \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",{CVar(FP,MultiStimPack[i+1][2],AtMost,0)},{SetCVar(FP,MultiStimPack[i+1][2],SetTo,1)})
		CIfEnd()
		CIfShop(i,43,P_MultiStopCost,"\x07[ \x07���� ����, \x07��Ƽ ��ž \x04����� ����� �� �ֽ��ϴ�. \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",{CVar(FP,MultiHold[i+1][2],AtMost,0)},{SetCVar(FP,MultiHold[i+1][2],SetTo,1)})
		CIfEnd()
		CIfShop(i,44,P_MultiHoldCost,"\x07[ \x07���� ����, \x07��Ƽ Ȧ�� \x04����� ����� �� �ֽ��ϴ�. \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",{CVar(FP,MultiStop[i+1][2],AtMost,0)},{SetCVar(FP,MultiStop[i+1][2],SetTo,1)})
		CIfEnd()
		CIfShopOld(i,45,10000,"\x07[ \x07���� ����, \x1B������ ����Ʈ\x04�� ��ȯ�Ǿ����ϴ�. \x07]","\x07[ \x08����Ʈ�� �����մϴ� \x07]",nil,{SetCVar(FP,NewStat[i+1][2],Add,1)})
		CIfEnd()
		CDoActions(FP,{
			TSetMemory(_Add(MenuPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(MenuPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			TSetMemoryX(_Add(MenuPtr[i+1],0xA0/4),SetTo,228,0xFFFF);
			SetCDeaths(FP,SetTo,0,ShopSw[i+1])})
		CIfEnd()
		ItemT = {
			{Nukes[i+1],{41},1},
			{MultiStimPack[i+1],{42},1},
			{MultiHold[i+1],{43},1},
			{MultiStop[i+1],{44},1},
			{MultiStimPack[i+1],{71}},
			{MultiHold[i+1],{65}},
			{MultiStop[i+1],{67}},
		}
		for j, k in pairs(ItemT) do
			local X = {}
			local Y = {}
			for l, m in pairs(k[2]) do
				if k[3] == nil then
					table.insert(X,SetMemoryB(0x57F27C+(228*i)+m,SetTo,1))
					table.insert(Y,SetMemoryB(0x57F27C+(228*i)+m,SetTo,0))
				else
					table.insert(X,SetMemoryB(0x57F27C+(228*i)+m,SetTo,0))
					table.insert(Y,SetMemoryB(0x57F27C+(228*i)+m,SetTo,1))
				end
			end
			TriggerX(FP,{CVar(FP,k[1][2],AtLeast,1)},X,{preserved})
			TriggerX(FP,{CVar(FP,k[1][2],AtMost,0)},Y,{preserved})
		end

		 -- ���۽� �� ������ ������ ����ȭ. TT������ �̿��� ���� ��ȭ�Ҷ��� ������
		CIf(FP,{TTCVar(FP,MarHP[i+1][2],"!=",MarHP2[i+1])})
			CMov(FP,MarHP2[i+1],MarHP[i+1])
			CMov(FP,0x662350 + (MarID[i+1]*4),MarHP2[i+1])
			CMov(FP,0x515BB0+(i*4),_Div(_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)),_Mov(256)))
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
		
			Trigger { -- ��ȣ�� ����
				players = {FP},
				conditions = {
					Label(0);
				},
				actions = {
					ModifyUnitShields(All,"Any unit",i,"Anywhere",100);
					--SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0x8000,0x8000);
					PreserveTrigger();
				},
			}
			TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,3),Bring(FP, AtMost, 0, 147, 64)},{
				ModifyUnitShields(All,"Any unit",i,"Anywhere",0);},{preserved})
		CElseX()
			DoActions(FP,{SetMemoryW(0x660E00 + (MarID[i+1]*2),SetTo,1000)})
			TriggerX(FP,{CDeaths(FP,AtMost,0,isSingle)},{SetMemoryX(0x664080 + (MarID[i+1]*4),SetTo,0,0x8000);},{preserved})
		CIfXEnd()
		DoActionsX(FP,{SetCDeaths(FP,Subtract,1,UpSELemit[i+1]),SetCDeaths(FP,Subtract,1,NukeCool[i+1]),SetDeaths(i,Subtract,1,15),SetCDeaths(FP,Subtract,1,ArmorT3[i+1])})
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
					SetDeathsX(i,SetTo,30*256,0,0xFF00);
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
			CTrigger(FP, CV(SelPl,i), {TSetCVar(FP,PointTamp[2],SetTo,_Sub(OldAvStat[i+1],UsedOldP[i+1]))}, 1)
			CIfEnd()
		end
		CS__ItoCustom(FP,SVA1(Str5,16),PointTamp,nil,nil,10,1,nil,"\x070",0x07,{0,1,2,3,4,5,6,7,8,9})
		
	CS__InputVA(FP,iTbl4,0,Str5,Str5s,nil,0,Str5s)


	CIfEnd()
	CIf(FP,{CV(SelUID,111)})
	NukesTmp = CreateVar(FP)
		for i = 0, 6 do
			CTrigger(FP, CV(SelPl,i), {TSetCVar(FP,NukesTmp[2],SetTo,NukesUsage[i+1])}, 1)
		end
		CS__ItoCustom(FP,SVA1(Str4,16),NukesTmp,nil,nil,10,1,nil,"\x080",0x08,{0,1,2,3,4,5,6,7,8,9})
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


--	CIfOnce(FP,{Memory(EvCheckPtr,AtLeast,2)})
--	DoActions(FP,{CopyCpAction({DisplayTextX("\t\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x1F���������ţ֣ţΣԡ�������\n\n\n\x13\x1F�̺�Ʈ\x04�� �����Ǿ����ϴ�.\n\x13\x07���� ����Ʈ ȹ�淮\x04�� �������� \x1F����\x04�Ͽ����ϴ�.\n\n\n\x13\x1F���������ţ֣ţΣԡ�������\n\x13\x04������������������������������������������������������������������������������������������������������������",4),
--	PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),},HumanPlayers,FP)})
--	CMov(FP,MulPoint,_ReadF(EvCheckPtr))
--	CIfEnd()
end