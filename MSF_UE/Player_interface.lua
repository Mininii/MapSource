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

	--스탯
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
	InsertKey[1] = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04이 맵은 클리어의 개념이 없으며 \n\x13\x08게임 오버 \x04시 \x1F달성한 단계\x04와 \x07스코어(가스)\x04가 게임의 성과를 나타냅니다.\n\x13\x04당신의 한계를 시험해 보세요!\n\x13\x07이론적으로 제한 없는 단계와 업그레이드\x04를 제공합니다.\n\x13\x04255 업그레이드 완료 시 \x1F0으로 리셋 후 마린 공격력이 그대로 전승됩니다.\n\x13\x04Normal Marine + \x1F25000 Ore \x04= \x1FExCeed Marine\n\x13\x04조합소는 중앙 수정 광산이 있는곳으로 가시면 됩니다.\n\x13\x04PgUp, PgDn 키로 설명서 페이지를 바꿀 수 있습니다.\n\x13\x04――――――――――――――――――――――――― Page 1/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	InsertKey[2] = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04\x1CSCArchive \x04설명 (문의는 마공카를 찾아주세요.)\n\x13\x04현재 저장가능 데이터는 \x11최고기록(Level, Score)\x04과 \x19스탯 포인트 \x04입니다. 그외 \x08저장 불가능합니다.\n\x13\x04스탯 포인트로 다양한 이로운 효과를 얻을 수 있습니다.\n\x13\x07단, \x0F32Bit 환경 \x04스타크래프트에서만 이용하실 수 있으며\n\x13\x07 데이터 로드는 \x1D1 Level \x04스테이지에서만 가능합니다.\n\x13\x04데이터를 불러오지 못했다면 게임 재시작을 권장드립니다.\n\x13\x07데이터 저장\x04은 매 스테이지 클리어마다 \x07자동저장됩니다. \x04또는 \x18수동저장 \x04가능합니다.\n\n\x13\x04――――――――――――――――――――――――― Page 2/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	InsertKey[3] = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04스탯포인트 증가량 공식은 시작난이도에 따라 달라집니다.\n\x13\x04\x0EＥａｓｙ\x04 = 증가량X \x0FＮｏｒｍａｌ\x04 = +5\n\x13\x04\x08Ｈａｒｄ\x04 = +10 \x10Ｉｎｓａｎｅ\x04 = +15\n\x13\x04위의 값에서 클리어한 스테이지의 수치가 합산되어 더해집니다.\n\x13\x04\n\x13\x04Ex) 8스테이지 클리어 + \x08Ｈａｒｄ\x04난이도 = 8 + 10 = +18 증가\n\x13\x04\n\x13\x04즉, 높은 난이도에서 시작할 수록 더 많은 스탯포인트를 얻을 수 있습니다.\n\x13\x04――――――――――――――――――――――――― Page 3/3 ―――――――――――――――――――――――――\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ"
	local InsertPage = CreateCcode()
	local KeyToggle = CreateCcode()
	--

--	PlayerInfoT = "\x12\x10【 \x08Y\x04our \x0FL\x04evel :\x1F 0000000000 \x04◈ Score :\x07 0000000000 \x04◈ \x07StatPoint \x04: 0000000000 / 0000000000 \x10】"
--	PlayerItemT = "\x12\x10【 \x0FI\x04tems ＃ \x0E퍼센트 \x1E방어력 : 000 / 255 \x04◈ 적 체력 약화 : 000 / 255 \x04◈ 상정 : F9\x10】"
--	--

--	function InterfaceFunc() 
--		CA__SetValue(Str1,PlayerInfoT,nil,0) 
--		--CA__ItoCustom(SVA1(Str1,0),TimeV,nil,nil,{10,6},1,{"\x07０","\x07０","\x0F０","\x0F０","\x1F０","\x1F０"},nil,{0x07,0x07,0x0F,0x0F,0x1F,0x1F},{11,12,14,15,17,18})
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

	

	CElseX({}) -- 현재스탯 등 출력
	

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
		PlayerInfoT = "\x12\x10【 \x08Y\x04our \x0FL\x04evel :\x1F 0000000000 \x04◈ Score :\x07 0000000000 \x04◈ \x07StatPoint \x04: 0000000000 / 0000000000 \x10】\r\n"
		PlayerItemT = "\x12\x10【 \x0FI\x04tems ＃ \x0E퍼센트 \x1E방어력 : 000 / 255 \x04◈ 적 체력 약화 : 000 / 255 \x04◈ 상정 : F9\x10】"
	
		TempVT = CreateVarArr(7,FP)
		for i = 0, 6 do
		CIf(FP,{LocalPlayerID(i)},{SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,SetTo,2,CPConsoleToggle)}) -- 스테이터스 전송
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
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Stim)},{DisplayText("\x07『 \x1B원격 스팀팩 \x04(P) \x1F(Cost:"..P_StimCost..") \x07』",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,1,LocalCcode_Stim),CDeaths(FP,Exactly,0,LocalCcode_Stim2)},{DisplayText("\x07『 \x07자동 \x1B스팀팩 \x04(P) \x1F(Cost:"..P_AutoStimCost..") \x07』",4)},{preserved})
	--TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Stim)},{DisplayText("\x13\x07『 \x1B원격 스팀팩 \x04(R) \x1F(Cost:"..P_StimCost..") \x03구입 완료! \x07』",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_Multi)},{DisplayText("\x07『 \x1D멀티 \x1B커맨드 \x04(O) \x1F(Cost:"..P_MultiCost..") \x07』",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,1,LocalCcode_Multi),CDeaths(FP,Exactly,0,LocalCcode_AutoHeal)},{DisplayText("\x07『 \x07자동 \x1F힐 \x04(O) \x1F(Cost:"..P_AutoHealCost..") \x07』",4)},{preserved})
	--TriggerX(FP,{CDeaths(FP,AtLeast,1,LocalCcode_Multi)},{DisplayText("\x13\x07『 \x1D멀티 \x1B커맨드 \x04(T) \x1F(Cost:"..P_MultiCost..") \x03구입 완료! \x07』",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,TeamEnchant)},{DisplayText("\x07『 \x04Normal Marine \x1B강화 \x04(I) \x1F(Cost:"..P_EnchantCost..") \x07』",4)},{preserved})
	--TriggerX(FP,{CDeaths(FP,AtLeast,1,TeamEnchant)},{DisplayText("\x13\x07『 \x04Normal Marine \x1B강화 \x04(Y) \x1F(Cost:"..P_EnchantCost..") \x03구입 완료! \x07』",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,0,LocalCcode_SkillUnit)},{DisplayText("\x07『 \x08핵배틀 \x04조합 \x1B활성화\x04, 생성시 자동으로 \x1F10,000,000 Ore\x04를 소모합니다. \x04(U) \x1F(Cost:"..P_SkillUnitCost..") \x07』",4)},{preserved})
	TriggerX(FP,{CDeaths(FP,Exactly,1,LocalCcode_SkillUnit),CDeaths(FP,Exactly,0,LocalCcode_Detector)},{DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x1C디텍터 \x1B활성화 \x04(U) \x1F(Cost:"..P_MarDetectorCost..") \x07』",4)},{preserved})

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
	for i = 0, 6 do -- 각플레이어
		DoActions(FP,SetMemory(0x6509B0,SetTo,i)) -- CP 복구 
--		Trigger2(i,{Deaths(i,AtLeast,1,ㅈ),LocalPlayerID(i)},{
--			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
--			DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
--			DisplayText("\x13\x07『 \x04채널 A10 을 방문하여 제작자에게 문의해주시기 바랍니다.\x07 』",4);
--			SetMemory(0xCDDDCDDC,SetTo,1);
--		})
		if i ~= 0 then --강퇴트리거는 1플레이어 제외
		
		Trigger { -- 강퇴
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanToken[i+1]);
			},
			actions = {
				RotatePlayer({DisplayTextX("\x07『 \x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다.\x07 』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
				},
			}
			Trigger { -- 강퇴 드랍
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,AtLeast,5,BanToken[i+1]);Memory(0x512684, Exactly, i)
					
				},
				actions = {
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					SetMemory(0xCDDDCDDC,SetTo,1);
					
					},
				}
		end
		
		Trigger { -- 미네랄 마이너스 방지
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
					Y;
					PreserveTrigger();
				},
			}
		end
		KeyCP = i

		
		Trigger { -- 스팀팩
			players = {i},
			conditions = {
				Label(0);
				Bring(i,AtLeast,1,71,64);
			},
			actions = {
				SetDeaths(i,Add,1,71);
				RemoveUnitAt(1,71,"Anywhere",i);
				DisplayText("\x07『 \x04원격 \x1B스팀팩\x04기능을 사용합니다.\x07 』",4);
				SetCDeaths(FP,Add,1,CUnitFlag);
				PreserveTrigger();
			},
		}
		
		CIf(i,Bring(i,AtLeast,1,19,64))
		Trigger { -- 보호막 가동
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
				DisplayText("\x07『 \x04현재 \x1C수정 보호막\x04이 쿨타임중입니다. 자원 반환 + \x1F65000 Ore\x07』",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		Trigger { -- 보호막 가동
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),AtLeast,1001);
				Bring(i,AtLeast,1,19,64);
			},
			actions = {
				SetResources(i,Add,65000,Ore);
				RemoveUnitAt(1,19,"Anywhere",i);
				DisplayText("\x07『 \x04이미 \x1C수정 보호막\x04을 사용중입니다. 자원 반환 + \x1F65000 Ore\x07』",4);
				PlayWAV("sound\\Misc\\PError.WAV");
				PlayWAV("sound\\Misc\\PError.WAV");
				PreserveTrigger();
			},
		}
		
		Trigger { -- 보호막 가동
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
		Trigger { -- 보호막 가동
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,1000);
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04 사용이 종료되었습니다. \x07』",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				PreserveTrigger();
			},
		}
		Trigger { -- 보호막 가동
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,1,ShUsed[i+1]);
				Memory(0x582294+(4*i),Exactly,0);
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04 쿨타임이 종료되었습니다. \x07』",4);
				PlayWAV("staredit\\wav\\GMode.ogg");
				PlayWAV("staredit\\wav\\GMode.ogg");
				SetCDeaths(FP,SetTo,0,ShUsed[i+1]);
				PreserveTrigger();
			},
		}
		for j = 1, 5 do
		Trigger { -- 보호막 사용
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j+(1000));
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04이 "..j.."초 남았습니다. \x07』",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		for j = 1, 5 do
		Trigger { -- 보호막 쿨타임
			players = {i},
			conditions = {
				Label(0);
				Memory(0x582294+(4*i),Exactly,50*j);
			},
			actions = {
				DisplayText("\x07『 \x1C수정 보호막\x04 쿨타임이 "..j.."초 남았습니다. \x07』",4);
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PlayWAV("staredit\\wav\\sel_m.ogg");
				PreserveTrigger();
			},
		}
		end
		Trigger2(i,{Memory(0x582294+(4*i),AtLeast,1)},{SetMemory(0x582294+(4*i),Subtract,1)},{preserved})
		TriggerX(i,{Deaths(i,Exactly,0,OPConsole),Deaths(i,AtLeast,1,F9),Deaths(i,Exactly,0,B),Deaths(i,Exactly,0,CPConsole)},{SetDeaths(i,SetTo,1,CPConsole),SetDeaths(i,SetTo,0,F9),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
		TriggerX(i,{Deaths(i,Exactly,0,OPConsole),Deaths(i,AtLeast,1,F9),Deaths(i,Exactly,0,B),Deaths(i,Exactly,1,CPConsole)},{SetDeaths(i,SetTo,0,CPConsole),SetDeaths(i,SetTo,0,F9),SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
		CIf(FP,{HumanCheck(i,1),Deaths(i,AtLeast,1,CPConsole)},{TSetCDeaths(FP,Add,Dt,FuncT[i+1])}) -- 스탯창 인터페이스 Deaths 100~149
			KeyInput(219,{CDeaths(FP,AtMost,0,GivePChange[i+1]),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x04숫자키를 눌러 \x1F기부 플레이어\x04를 선택해주세요. \x07』")},1,1)
			KeyInput(219,{CDeaths(FP,AtMost,0,GivePChange[i+1])},{SetCDeaths(FP,SetTo,1,GivePChange[i+1]),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
			
			for j = 0, 6 do
				if i==j then 
					KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 "..PlayerString[j+1].."\x04은(는) 자기 자신입니다. 자기 자신에게는 기부할 수 없습니다. \x07』")},1,1)
					KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),},1)

				else 
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x1F기부 플레이어\x04가"..PlayerString[j+1].."\x04으로 설정되었습니다. \x07』")},1,1)
				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,1)},{SetCDeaths(FP,SetTo,0,GivePChange[i+1]);SetDeaths(i,SetTo,j+1,151),SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15)},1)
				end

				KeyInput(j+212,{CDeaths(FP,AtLeast,1,GivePChange[i+1]),HumanCheck(j,0),LocalPlayerID(i)},{print_utf8(12,0,"\x07『 "..PlayerString[j+1].."\x04이(가) 존재하지 않습니다. \x07』")},1,1)
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
				TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x04잔액이 부족합니다. \x07』")},{preserved})

				CIfXEnd()
			DoActions(FP,SetMemory(0x6509B0,SetTo,i))
			CElseIfX({Deaths(i,AtLeast,1,150),Deaths(i,AtMost,220000,150),Deaths(i,AtMost,0,151)},{SetDeaths(i,SetTo,150,15)})
			CallTriggerX(FP,Call_Print13[i+1])
			TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07『 \x1F기부 플레이어\x04가 설정되지 않았습니다. \x07』")},{preserved})
			CIfXEnd()
--			Trigger2(FP,{Deaths(i,AtLeast,1,113)},{SetDeaths(i,SetTo,2,14)},{preserved})
			TriggerX(FP,{Deaths(i,AtLeast,1,150)},{SetCDeaths(FP,SetTo,0,FuncT[i+1])},{preserved})
			TriggerX(FP,{Deaths(i,AtMost,0,15),Memory(0x512684,Exactly,i)},{SetCDeaths(FP,SetTo,0,DeleteToggle),
				print_utf8(12,0,"\x07[ \x1F미네랄 \x03기부방법 \x041. 물결버튼(～)누른 후 숫자버튼으로 플레이어 선택 2. \x1F1만원 단위\x04의 숫자를 채팅창에 입력. ESC : 닫기\x07 ]")
			},{preserved}) -- 13번줄 프린트 트리거 플레이어가 FP인 이유는 트리거 순서가 1P부터 8P까지 실행되기 때문. i로 하게될 경우 이게 씹히고 위에있는 CText가 보이게 된다. 
			--구입 성공시 사운드 PlayWAV("staredit\\wav\\BuySE.ogg");
			--구입 실패시 사운드 PlayWAV("staredit\\wav\\FailSE.ogg");

			CIf(FP,{Deaths(i,AtLeast,1,102)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);})
				CIfX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_SuppCost),TCVar(FP,Supply[i+1][2],AtMost,_Sub(SuppMax,1))},{SetCVar(FP,AvailableStat[i+1][2],Subtract,P_SuppCost),SetCVar(FP,Supply[i+1][2],Add,P_SuppAmount),SetDeaths(i,SetTo,150,15)})
					TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x07구입 성공, \x04인구수가 \x07"..(P_SuppAmount/2).." \x04증가하였습니다. \x07]")},{preserved})
					TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCDeaths(FP,SetTo,100,UpSELemit[i+1])},{preserved})
				CElseX({})
					CTrigger(FP,{TCVar(FP,Supply[i+1][2],AtLeast,SuppMax),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08구입 실패, \x04맵 최대 인구수가 꽉 찼습니다. \x07]"),},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),TCVar(FP,Supply[i+1][2],AtLeast,SuppMax)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
					TriggerX(FP,{CVar(FP,AvailableStat[i+1][2],AtMost,P_SuppCost-1),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},{preserved})
					TriggerX(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,AvailableStat[i+1][2],AtMost,P_SuppCost-1)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},{preserved})
				CIfXEnd()
			CIfEnd()
			CIf(FP,{Deaths(i,AtLeast,1,109)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);})
				CIfX(FP,{TCVar(FP,AvailableStat[i+1][2],AtLeast,_Add(_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8)),1)),CVar(FP,P_Armor[i+1][2],AtMost,254)},{TSetCVar(FP,AvailableStat[i+1][2],Subtract,_Add(_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8)),1)),SetCVar(FP,P_Armor[i+1][2],Add,1),SetDeaths(i,SetTo,150,15)})
					TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCDeaths(FP,SetTo,100,UpSELemit[i+1])},{preserved})
					TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x07구입 성공, \x0F퍼센트 방어력\x04이 증가하였습니다. \x07]")},{preserved})
					CMov(FP,0x515B88+(i*4),_Sub(_Mov(256),P_Armor[i+1]))
					CMov(FP,0x515BB0+(i*4),_Mul(_Div(_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)),_Mov(256)),_Sub(_Mov(256),P_Armor[i+1])))
				CElseX({SetMemory(0x6509B0,SetTo,i)})
					CTrigger(FP,{CVar(FP,P_Armor[i+1][2],AtLeast,255),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08구입 실패, \x04업그레이드 수치가 이미 최대치입니다. \x07]"),},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,P_Armor[i+1][2],AtLeast,255)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
					CTrigger(FP,{TCVar(FP,AvailableStat[i+1][2],AtMost,_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8))),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),TCVar(FP,AvailableStat[i+1][2],AtMost,_Div(_Mul(P_Armor[i+1],P_Armor[i+1]),_Mov(8)))},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
				CIfXEnd()
			CIfEnd(SetMemory(0x6509B0,SetTo,i))

			CIf(FP,{Deaths(i,AtLeast,1,100)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);})
				CIfX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_AHP),CVar(FP,TotalAHP[2],AtMost,254)},{SetCVar(FP,AvailableStat[i+1][2],Subtract,P_AHP),SetCVar(FP,AHP[i+1][2],Add,1),SetCVar(FP,TotalAHP[2],Add,1),SetDeaths(i,SetTo,150,15)})
					TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCDeaths(FP,SetTo,100,UpSELemit[i+1])})
					TriggerX(FP,{LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x07구입 성공, \x04적의 \x08체력 \x04이 하락하였습니다 (다음 레벨에서 적용). \x07]")},{preserved})
				CElseX({SetMemory(0x6509B0,SetTo,i)})
					CTrigger(FP,{CVar(FP,TotalAHP[2],AtLeast,255),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08구입 실패, \x04업그레이드 수치가 이미 최대치입니다. \x07]"),},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,TotalAHP[2],AtLeast,255)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
					CTrigger(FP,{CVar(FP,AvailableStat[i+1][2],AtMost,P_AHP-1),LocalPlayerID(i)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1)
					CTrigger(FP,{CDeaths(FP,AtMost,0,ArmorT3[i+1]),CVar(FP,AvailableStat[i+1][2],AtMost,P_AHP-1)},{SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");SetCDeaths(FP,SetTo,150,ArmorT3[i+1])},1)
				CIfXEnd()
			CIfEnd(SetMemory(0x6509B0,SetTo,i))

			KeyInput(103,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtLeast,1,AutoStim[i+1])},{print_utf8(12,0,"\x07[ \x08이미 구입되었습니다. \x07]")},1,1) --멀티커맨
			KeyInput(104,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtLeast,1,AutoHeal[i+1])},{print_utf8(12,0,"\x07[ \x08이미 구입되었습니다. \x07]")},1,1) --원격스팀
			KeyInput(105,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08이미 구입되었습니다. \x07]")},1,1) --일마강화
			KeyInput(106,{LocalPlayerID(i),CDeaths(FP,AtLeast,1,MarDetector[i+1]),CDeaths(FP,AtLeast,1,SkillUnit[i+1])},{print_utf8(12,0,"\x07[ \x08이미 구입되었습니다. \x07]")},1,1) --핵배틀 구입
			KeyInput(105,{CDeaths(FP,AtLeast,1,TeamEnchant)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --일마강화
			KeyInput(103,{CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtLeast,1,AutoStim[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --멀티커맨
			KeyInput(104,{CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtLeast,1,AutoHeal[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --원격스팀
			KeyInput(106,{CDeaths(FP,AtLeast,1,MarDetector[i+1]),CDeaths(FP,AtLeast,1,SkillUnit[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --핵배틀 구입
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_StimCost),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x07구입 성공, \x1B원격 스팀팩 \x04기능을 사용할 수 있습니다. \x07]")},1,1) --멀티커맨
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_MultiCost),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x07구입 성공, \x1D멀티 \x1B커맨드 \x04기능을 사용할 수 있습니다. \x07]")},1,1) --원격스팀
			KeyInput(105,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_EnchantCost),CDeaths(FP,AtMost,0,TeamEnchant)},{print_utf8(12,0,"\x07[ \x07구입 성공, \x04팀원의\x04Normal Marine\x04이 \x1B강화 \x04되었습니다. \x07]")},1,1) --일마강화
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_EnchantCost),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{print_utf8(12,0,"\x07[ \x07구입 성공, \x04이제부터 \x10핵배틀 조합\x04이 \x1B가능\x04합니다. \x07]")},1,1) --핵배틀 구입
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoStimCost),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{print_utf8(12,0,"\x07[ \x07구입 성공, \x07자동 \x1B스팀팩 \x04기능이 활성화 되었습니다. \x07]")},1,1) --멀티커맨
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoHealCost),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{print_utf8(12,0,"\x07[ \x07구입 성공, \x07자동 \x1F힐 \x04기능이 활성화 되었습니다. \x07]")},1,1) --원격스팀
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtLeast,P_MarDetectorCost),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{print_utf8(12,0,"\x07[ \x07구입 성공, \x1FExceeD \x1BM\x04arine \x1C디텍터\x04가 활성화 되었습니다.. \x07]")},1,1) --핵배틀 구입
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_StimCost),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_StimCost),SetCDeaths(FP,SetTo,1,MultiStimPack[i+1]),SetMemoryB(0x57F27C+(228*i)+71,SetTo,1),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --멀티커맨
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_MultiCost),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_MultiCost),SetCDeaths(FP,SetTo,1,MultiCommand[i+1]),SetMemoryB(0x57F27C+(228*i)+64,SetTo,1),SetMemoryB(0x57F27C+(228*i)+70,SetTo,1),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --원격스팀
			KeyInput(105,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_EnchantCost),CDeaths(FP,AtMost,0,TeamEnchant)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_EnchantCost),SetCDeaths(FP,SetTo,1,TeamEnchant),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --일마강화
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_SkillUnitCost),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_SkillUnitCost),SetCDeaths(FP,SetTo,1,SkillUnit[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --핵배틀 구입
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoStimCost),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_AutoStimCost),SetCDeaths(FP,SetTo,1,AutoStim[i+1]),SetMemoryB(0x57F27C+(228*i)+71,SetTo,0),SetMemoryB(0x57F27C+(228*i)+68,SetTo,1),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --멀티커맨
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_AutoHealCost),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_AutoHealCost),SetCDeaths(FP,SetTo,1,AutoHeal[i+1]),SetDeaths(i,SetTo,150,15),SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),SetMemoryB(0x57F27C+(228*i)+72,SetTo,0),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --원격스팀
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtLeast,P_MarDetectorCost),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]);SetCVar(FP,AvailableStat[i+1][2],Subtract,P_MarDetectorCost),SetCDeaths(FP,SetTo,1,MarDetector[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg");},1) --핵배틀 구입
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_StimCost-1),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1,1) --멀티커맨
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_MultiCost-1),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1,1) --원격스팀
			KeyInput(105,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_EnchantCost-1),CDeaths(FP,AtMost,0,TeamEnchant)},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1,1) --일마강화
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_SkillUnitCost-1),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1,1) --핵배틀 구입
			KeyInput(103,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoStimCost-1),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1,1) --멀티커맨
			KeyInput(104,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoHealCost-1),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1,1) --원격스팀
			KeyInput(106,{LocalPlayerID(i),CVar(FP,AvailableStat[i+1][2],AtMost,P_MarDetectorCost-1),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{print_utf8(12,0,"\x07[ \x08포인트가 부족합니다 \x07]")},1,1) --핵배틀 구입
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtMost,P_StimCost-1),CDeaths(FP,AtMost,0,MultiStimPack[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --멀티커맨
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtMost,P_MultiCost-1),CDeaths(FP,AtMost,0,MultiCommand[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --원격스팀
			KeyInput(105,{CVar(FP,AvailableStat[i+1][2],AtMost,P_EnchantCost-1),CDeaths(FP,AtMost,0,TeamEnchant)},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --일마강화
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtMost,P_SkillUnitCost-1),CDeaths(FP,AtMost,0,SkillUnit[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --핵배틀 구입
			KeyInput(103,{CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoStimCost-1),CDeaths(FP,AtLeast,1,MultiStimPack[i+1]),CDeaths(FP,AtMost,0,AutoStim[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --멀티커맨
			KeyInput(104,{CVar(FP,AvailableStat[i+1][2],AtMost,P_AutoHealCost-1),CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtMost,0,AutoHeal[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --원격스팀
			KeyInput(106,{CVar(FP,AvailableStat[i+1][2],AtMost,P_MarDetectorCost-1),CDeaths(FP,AtLeast,1,SkillUnit[i+1]),CDeaths(FP,AtMost,0,MarDetector[i+1])},{SetCDeaths(FP,SetTo,0,FuncT[i+1]),SetDeaths(i,SetTo,150,15),PlayWAV("staredit\\wav\\FailSE.ogg");},1) --핵배틀 구입
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
				DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
				SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
			},{preserved})

			Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,22);},{
				GiveUnits(All,22,i,"Anywhere",P12);
				RemoveUnitAt(All,22,"Anywhere",P12);
				DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
				SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
			},{preserved})

			Trigger2X(i,{CDeaths(FP,Exactly,0,HeroPointNotice[i+1]);Command(i,AtLeast,1,29);},{
				GiveUnits(All,29,i,"Anywhere",P12);
				RemoveUnitAt(All,29,"Anywhere",P12);
				DisplayText("\x07『 \x1F영작 알림소리\x04를 듣지 않습니다. \x07』",4);
				SetCDeaths(FP,SetTo,1,HeroPointNotice[i+1]);
			},{preserved})

			Trigger2X(i,{CDeaths(FP,Exactly,1,HeroPointNotice[i+1]);Command(i,AtLeast,1,29);},{
				GiveUnits(All,29,i,"Anywhere",P12);
				RemoveUnitAt(All,29,"Anywhere",P12);
				DisplayText("\x07『 \x1F영작 알림소리\x04를 듣습니다. \x07』",4);
				SetCDeaths(FP,SetTo,0,HeroPointNotice[i+1]);
			},{preserved})

			
			TriggerX(i,{Command(i,AtLeast,1,70);},{
				GiveUnits(All,70,i,"Anywhere",P12);
				RemoveUnitAt(All,70,"Anywhere",P12);
				DisplayText("\x07『 \x1C모든 유닛\x04에 \x1D자율공격명령 \x04을 내립니다. (\x0FJunk Yard Dog\x04) \x07』",4);
				SetDeaths(i,SetTo,1,70);
				SetCDeaths(FP,Add,1,CUnitFlag);
				SetCDeaths(FP,Add,100,OrderCool[i+1]);
			},{preserved})

			
			TriggerX(i,{Command(i,AtLeast,1,68);CVar(FP,AvailableStat[i+1][2],AtLeast,P_TelCost)},{
				GiveUnits(All,68,i,"Anywhere",P12);
				RemoveUnitAt(All,68,"Anywhere",P12);
				SetCVar(FP,AvailableStat[i+1][2],Subtract,P_TelCost);
				DisplayText("\x07『 \x16마우스 위치\x04로 \x1D모든 유닛\x04을 \x1B텔레포트\x04하였습니다 \x1F(-100Point) \x07』",4);
				SetDeaths(i,SetTo,1,68);
				PlayWAV("staredit\\wav\\BuySE.ogg");
				PlayWAV("staredit\\wav\\BuySE.ogg");
				SetCDeaths(FP,Add,25,TelCool[i+1]);
			},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,68);CVar(FP,AvailableStat[i+1][2],AtMost,P_TelCost-1)},{
				GiveUnits(All,68,i,"Anywhere",P12);
				RemoveUnitAt(All,68,"Anywhere",P12);
				DisplayText("\x07『\x1F스탯 포인트\x04가 부족합니다.\x1F(Cost:100) \x07』",4);
				PlayWAV("staredit\\wav\\FailSE.ogg");
			},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,48);CVar(FP,AvailableStat[i+1][2],AtLeast,P_TelCost)},{
				GiveUnits(All,48,i,"Anywhere",P12);
				RemoveUnitAt(All,48,"Anywhere",P12);
				SetCVar(FP,AvailableStat[i+1][2],Subtract,P_TelCost);
				DisplayText("\x07『 \x16본진\x04으로 \x1D모든 유닛\x04을 \x1B텔레포트\x04하였습니다 \x1F(-100Point) \x07』",4);
				SetDeaths(i,SetTo,1,48);
				PlayWAV("staredit\\wav\\BuySE.ogg");
				PlayWAV("staredit\\wav\\BuySE.ogg");
				SetCDeaths(FP,Add,25,TelCool2[i+1]);
			},{preserved})
			TriggerX(i,{Command(i,AtLeast,1,48);CVar(FP,AvailableStat[i+1][2],AtMost,P_TelCost-1)},{
				GiveUnits(All,48,i,"Anywhere",P12);
				RemoveUnitAt(All,48,"Anywhere",P12);
				DisplayText("\x07『\x1F스탯 포인트\x04가 부족합니다.\x1F(Cost:100) \x07』",4);
				PlayWAV("staredit\\wav\\FailSE.ogg");
			},{preserved})


		UnitLimit(i,7,25,"SCV는",500)
		UnitLimit(i,125,15,"벙커는",8000)
		UnitLimit(i,124,15,"터렛은",4000)
		


		CIfX(FP,HumanCheck(i,1)) -- FP가 관리하는 시스템 부분 트리거. 각플레이어가 있을경우 실행된다.


		TriggerX(FP,{CVar(FP,AvailableStat[i+1][2],AtLeast,1)},{SetDeaths(i,SetTo,36,126)},{preserved})
			CMov(FP,0x5821D4 + (4*i),Supply[i+1]) -- 인구수 상시 업데이트(사용가능)
		--SCA 데이터 변동시 갱신

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
			--table.insert(PatchArr,SetMemoryB(0x662DB8 + MarID[i+1],SetTo,7)) -- 부가사거리
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
				DisplayText("\x07『 \x1F광물\x04을 소모하여 \x1FExceeD \x1BM\x04arine 을 \x0712기 \x19소환\x04하였습니다. - \x1F360,000 O r e \x07』",4),
				SetMemory(0x6509B0,SetTo,FP),
				SetResources(i,Subtract,30000*12,Ore);
				SetCDeaths(FP,Add,12,MarCreate[i+1]),
			},{preserved})
			Trigger { -- 조합 조건 안됨
				players = {FP},
				conditions = {
				Deaths(i,AtMost,35,126);
			},
			  actions = {
				SetMemory(0x6509B0,SetTo,i),
				DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x0712기 \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - \x1FExceeD \x1BM\x04arine \x0436기 조합) \x07』",4);
				SetMemory(0x6509B0,SetTo,FP),
				PreserveTrigger();
			},
		}
		    Trigger { -- 조합 조건 안됨
		    players = {FP},
		    conditions = {
			Accumulate(i,AtMost,(30000*12)-1,Ore),
			Deaths(i,AtLeast,36,126),
		},
		  actions = {
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x0712기 \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - \x1F360,000 Ore 보유) \x07』",4);
			SetMemory(0x6509B0,SetTo,FP),
			PreserveTrigger();
			},
	  	}
		CElseX({
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07『 \x1FExceeD \x1BM\x04arine \x0712기 \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - 인구수 만족) \x07』",4);
			SetMemory(0x6509B0,SetTo,FP),
		})
		
		CIfXEnd()
		CIfEnd()

		Trigger { -- 조합 영웅마린
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
				DisplayText("\x07『 \x1F광물\x04을 소모하여 \x04Norma Marine을 \x1FExceeD \x1BM\x04arine으로 \x19변환\x04하였습니다. - \x1F25,000 O r e \x07』",4);
				SetMemory(0x6509B0,SetTo,FP),
				SetDeaths(i,Add,1,126),
				ModifyUnitEnergy(1,10,i,10,0);
				SetResources(i,Subtract,25000,Ore);
				RemoveUnitAt(1,10,10,i);
				SetCDeaths(FP,Add,1,MarCreate[i+1]),
				PreserveTrigger();
			},
		}
		Trigger { -- 조합 핵배틀
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
				DisplayText("\x07『 \x1F광물\x04을 소모하여 \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ 가 \x19자동 생산 \x04되었습니다. - \x1F10,000,000 O r e \x07』",4);
				SetMemory(0x6509B0,SetTo,FP),
				SetResources(i,Subtract,10000000,Ore);
				SetCDeaths(FP,Add,1,CreateSu[i+1]),
				PreserveTrigger();
			},
		}
		
		
		TriggerX(FP,{Bring(i,AtLeast,1,15,64)},{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07『 \x1F광물\x04을 소모하여 Normal Marine 을 \x19소환\x04하였습니다. - \x1F5,000 O r e \x07』",4),
			SetMemory(0x6509B0,SetTo,FP),
			RemoveUnitAt(1,15,"Anywhere",i),
			SetCDeaths(FP,Add,1,MarCreate2[i+1]),
			SetMemory(0x582324+(12*12)+(i*4),SetTo,0),
			SetMemory(0x584DE4+(12*12)+(i*4),SetTo,0),
		},{preserved})
		CIf(FP,{TTMemory(_Add(BarrackPtr[i+1],62),NotSame,BarRally[i+1])}) --배럭랠리 갱신
			f_Read(FP,_Add(BarrackPtr[i+1],62),BarRally[i+1])
			CIf(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Nukes[i+1][2],AtLeast,1),CDeaths(FP,AtMost,0,NukeCool[1+i])},{SetCVar(FP,Nukes[i+1][2],Subtract,1),SetCDeaths(FP,SetTo,10,NukeCool[i+1])}) -- 배럭랠리 갱신중 핵이 장전되어있을경우 또는 캔낫이아닐경우
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
		CIf(FP,{Memory(0x628438,AtLeast,1),CVar(FP,AMatter[i+1][2],AtLeast,1)}) -- 반물폭투하
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
		NIf(FP,MemoryB(0x58D2B0+(46*i)+19,AtLeast,1)) -- 체업 255회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,255),
				SetMemoryB(0x58D2B0+(46*i)+19,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+20,AtLeast,1)) -- 체업 10회
			CDoActions(FP,{
				SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(DefUpgradePtrArr[i+1])),
				SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
				TSetCVar(FP,UpgradeFactor[2],SetTo,DefFactorV[i+1]),
				SetCVar(FP,UpgradeCP[2],SetTo,i),
				SetCVar(FP,UpgradeMax[2],SetTo,10),
				SetMemoryB(0x58D2B0+(46*i)+20,SetTo,0)})
			CallTrigger(FP,OneClickUpgrade)
		NIfEnd()
		NIf(FP,MemoryB(0x58D2B0+(46*i)+21,AtLeast,1)) --원클릭 풀업
			
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
			DisplayText("\x07『 \x0820억 \x1F미네랄\x04을 소모하여 모든 업그레이드를 완료하였습니다. \x07』",4);
			SetMemory(0x6509B0,SetTo,FP),
		})
		TriggerX(FP,{Accumulate(i,AtMost,2000000000-1,Ore)},{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
			SetMemory(0x6509B0,SetTo,FP),
			SetMemoryB(0x58D2B0+(46*i)+21,SetTo,0),
		},{preserved})
		NIfEnd()
		
		CIf(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,255*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))},{SetMemoryX(AtkUpgradePtrArr[i+1],SetTo,0*(256^AtkUpgradeMaskRetArr[i+1]),255*(256^AtkUpgradeMaskRetArr[i+1]))})
		DoActionsX(FP,{
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x04！！！　\x1C공격력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\x04　！！！\n\x13\x04！！！　\x07업그레이드를 \x040으로 재설정하고 \x17공격력 수치가 전승\x04되었습니다.\x04　！！！",4),
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
			DisplayText("\x13\x04！！！　\x08체력 업그레이드\x04가 255를 넘어 한계를 돌파합니다.\x04　！！！\n\x13\x04！！！　\x07업그레이드를 \x040으로 재설정하고 \x17체력 수치가 전승\x04되었습니다.\x04　！！！",4),
			SetMemory(0x6509B0,SetTo,FP),
			--SetCVar(FP,DefFactorV[i+1][2],Add,1),
			SetCVar(FP,MarMaxHP[i+1][2],Add,2000*256),
			SetCVar(FP,DefUpCompCount[i+1][2],Add,1),
			SetCVar(FP,BattleHeal[i+1][2],Add,800*256),
		})
		TriggerX(FP,{CDeaths(FP,AtMost,0,UpSELemit[i+1])},{SetMemory(0x6509B0,SetTo,i),PlayWAV("staredit\\wav\\LimitBreak.ogg"),SetMemory(0x6509B0,SetTo,FP),SetCDeaths(FP,Add,100,UpSELemit[i+1])},{preserved})
		TriggerX(FP,{},{SetCVar(FP,DefFactorV[i+1][2],Add,4)},{preserved})--CVar(FP,DefUpCompCount[i+1][2],AtLeast,51)
		CIfEnd()

		DoActionsX(FP,{SetCVar(FP,CurrentHP[i+1][2],SetTo,0)})-- 체력값 초기화
		for Bit = 0, 7 do
		TriggerX(FP,{MemoryX(DefUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
			{SetCVar(FP,CurrentHP[i+1][2],Add,2008*(2^Bit))},{preserved})
		end
		CMov(FP,MarHP[i+1],_Add(CurrentHP[i+1],MarMaxHP[i+1]))
		
		CIfX(FP,CVar(FP,AtkUpCompCount[i+1][2],AtMost,0)) -- 업그레이드 컴플리트 카운트(255업 찍은 횟수)가 0일 경우.
			DoActions(FP,{SetMemoryX(NormalUpgradePtrArr[i+1],SetTo,0*(256^NormalUpgradeMaskRetArr[i+1]),255*(256^NormalUpgradeMaskRetArr[i+1]))})
			for Bit = 0, 7 do
			Trigger2(FP,{MemoryX(AtkUpgradePtrArr[i+1],AtLeast,(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]),(2^Bit)*(256^AtkUpgradeMaskRetArr[i+1]))},
				{SetMemoryX(NormalUpgradePtrArr[i+1],Add,(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]),(2^Bit)*(256^NormalUpgradeMaskRetArr[i+1]))},{preserved})
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
		
		TriggerX(FP,{CVar(FP,MarHP[i+1][2],AtLeast,160000*256)},{SetMemoryB(0x58D088 + (i * 46) + i+8,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 19,SetTo,0),SetMemoryB(0x58D088 + (i * 46) + 20,SetTo,0),
			SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x07[ \x08체력\x04이 16만 넘어가면 \x1F%퍼뎀\x04 시스템 박살나서 더이상 체업 못해요 죄송합니다............................. \x07]",4),
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
			DisplayText("\x07[ \x1C공격력\x04이 시스템상 한계라서 더이상 공업 못해요 죄송합니다............................. \x07]",4),
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
				RotatePlayer({PlayWAVX("staredit\\wav\\WARNING.wav"),PlayWAVX("staredit\\wav\\WARNING.wav"),DisplayTextX("\t\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x08！！！　ＣＡＵＴＩＯＮ　！！！\n\n\n\x13\x04누군가가 \x1F최강 유닛\x04을 \x11소환\x04하였습니다.\n\x13\x1F최강 유닛\x04 반경 내 대부분의 적 유닛이 \x08소멸\x04할 것입니다.\n\n\n\x13\x08！！！　ＣＡＵＴＩＯＮ　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)},HumanPlayers,FP)
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
	TriggerX(FP,{CVar(FP,AvailableStat[CP+1][2],AtLeast,Cost),CDeaths(FP,AtMost,0,ShopSw[CP+1]),Conditions},{SetCVar(FP,AvailableStat[CP+1][2],Subtract,Cost),SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\BuySE.ogg");PlayWAV("staredit\\wav\\BuySE.ogg"),SetCp(FP),Actions},{preserved})	-- 포인트가 충분할 경우

	TriggerX(FP,{CVar(FP,AvailableStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1]),LocalPlayerID(CP)},{print_utf8(12,0,DisContentStr)},{preserved})
	TriggerX(FP,{CVar(FP,AvailableStat[CP+1][2],AtMost,Cost-1),CDeaths(FP,AtMost,0,ShopSw[CP+1])},{SetDeaths(CP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CP+1]),SetCp(CP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- 포인트가 충분하지 않을 경우
end
		CIf(FP,CVar(FP,MenuPtr[i+1][2],AtLeast,1))
		for m = 0, 3 do
		CIfShop(i,37+m,P_MinCost*(10^m),"\x07[ \x07구입 성공, \x04미네랄이 \x1F"..(P_MinAmount*(10^m)).." \x04증가하였습니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",Accumulate(i,AtMost,1999999999,Ore),SetResources(i,Add,P_MinAmount*(10^m),Ore))
			TriggerX(FP,{CVar(FP,AvailableStat[CurShopCP+1][2],AtLeast,CurShopCost),CDeaths(FP,AtMost,0,ShopSw[CurShopCP+1]),LocalPlayerID(CurShopCP),Accumulate(CurShopCP,AtLeast,2000000000,Ore)},{print_utf8(12,0,"\x07[ \x1F미네랄 \x0820억 이상 \x04보유중입니다. \x08구매할 수 없습니다. \x07]")},{preserved})
			TriggerX(FP,{CVar(FP,AvailableStat[CurShopCP+1][2],AtLeast,CurShopCost),CDeaths(FP,AtMost,0,ShopSw[CurShopCP+1]),Accumulate(CurShopCP,AtLeast,2000000000,Ore)},{SetDeaths(CurShopCP,SetTo,150,15),SetCDeaths(FP,SetTo,1,ShopSw[CurShopCP+1]),SetCp(CurShopCP),PlayWAV("staredit\\wav\\FailSE.ogg"),SetCp(FP)},{preserved})	-- 포인트가 충분하지 않을 경우
		CIfEnd()
		CIfShop(i,41+m,P_NukeCost*(10^m),"\x07[ \x07구입 성공, \x08뉴클리어\x04가 \x07"..(P_NukeAmount*(10^m)).."발 \x04장전되었습니다. (사용법 : 배럭으로 우클릭) \x07]","\x07[ \x08포인트가 부족합니다 \x07]",nil,SetCVar(FP,Nukes[i+1][2],Add,P_NukeAmount*(10^m)))
		CIfEnd()
		end
		CIfShop(i,45,P_AMCost,"\x07[ \x07구입 성공, 곧 \x1F융단 \x08폭격\x04이 \x04투하됩니다. \x07]","\x07[ \x08포인트가 부족합니다 \x07]",CDeaths(FP,AtMost,0,AmUsed[i+1]),{SetCVar(FP,AMatter[i+1][2],Add,1),SetCDeaths(FP,SetTo,1000*30,AmUsed[i+1]),})
			CIf(FP,{CDeaths(FP,AtMost,0,ShopSw[i+1]),CDeaths(FP,AtLeast,1,AmUsed[i+1])},{SetDeaths(i,SetTo,150,15)})
				CIf(FP,LocalPlayerID(i))
					DoActionsX(FP,{SetCp(i),PlayWAV("staredit\\wav\\FailSE.ogg"),print_utf8(12,0,"\x07[ \x1F융단 \x08폭격\x04이 쿨타임중입니다. 남은 시간 : "..string.rep("\x0d\x0d\x0d\x0d",28).."초 \x07]")})
					ItoDec(FP,_Div(_ReadF(_Ccode(FP,AmUsed[i+1])),_Mov(1000)),VArr(AmVA,0),2,nil,0)
					_0DPatchX(FP,AmVA,5)
					f_Movcpy(FP,0x640B60 + (12 * 218)+GetStrSize(0,"\x07[ \x1F융단 \x08폭격\x04이 쿨타임중입니다. 남은 시간 : \x0d\x0d\x0d"),VArr(AmVA,0),5*4)
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
			SetMemoryX(0x66A1C4, SetTo, 16*256,0xFF00); -- 리맵핑
			SetMemoryX(0x663218, SetTo, 0*16777216,0xFF000000); -- 높이
			})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CDoActions(FP,{
			CreateUnit(1,203, "Location 1",FP);
			SetMemoryX(0x66A1C4, SetTo, 0*256,0xFF00); -- 리맵핑
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
			DisplayText("▶ \x08소멸 \x04Skill을 \x06Off \x04하였습니다.",4),
			SetMemory(0x6509B0,SetTo,FP);
			SetCDeaths(FP,SetTo,1,BHSkill[i+1]),
			TSetMemory(_Add(BHPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(BHPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			},1)
		CTrigger(FP,{TMemory(_Add(BHPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,BHSkill[i+1])},{
			SetMemory(0x6509B0,SetTo,i);
			DisplayText("▶ \x08소멸 \x04Skill을 \x1FOn \x04하였습니다.",4),
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

		
		CIf(FP,{Memory(0x628438,AtLeast,1),CDeaths(FP,AtLeast,1,CreateSu[i+1]),Command(i,AtMost,0,12)},{SetCDeaths(FP,SetTo,0,CreateSu[i+1])}) -- 소환 또는 조합시
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
			DisplayText("▶ \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ \x04의 Skill을 \x06Off \x04하였습니다.",4),
			SetMemory(0x6509B0,SetTo,FP);
			SetCDeaths(FP,SetTo,1,SuSkill[i+1]),
			TSetMemory(_Add(SuPtr[i+1],0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(SuPtr[i+1],0x9C/4),SetTo,228 + 228*65536);
			},1)
		CTrigger(FP,{TMemory(_Add(SuPtr[i+1],0x98/4),AtMost,227*65536),CDeaths(FP,Exactly,1,SuSkill[i+1])},{
			SetMemory(0x6509B0,SetTo,i);
			DisplayText("▶ \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ \x04의 Skill을 \x1FOn \x04하였습니다.",4),
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
		
		 -- 업글시 돈 증가량 변수와 동기화. TT조건을 이용해 값이 변화할때만 연산함
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
		Trigger2(FP,{Memory(0x57f120+(4*i),AtLeast,0x80000000)},{SetMemory(0x57f120+(4*i),SetTo,0)},{preserved}) -- 가스 마이너스 방지
		
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
			Trigger { -- 보호막 가동
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
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+64,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+66,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltime,SetMemoryB(0x57F27C+(228*i)+70,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+64,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+66,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(OrderCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+70,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,AtLeast,1,OrderCool[i+1])},{OrderCooltime},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,MultiCommand[i+1]),CDeaths(FP,Exactly,0,OrderCool[i+1])},{OrderCooltimeRecover},{preserved})
		local TelCooltime = {}
		local TelCooltimeRecover = {}
		table.insert(TelCooltime,SetMemoryB(0x57F27C+(228*i)+68,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(TelCooltimeRecover,SetMemoryB(0x57F27C+(228*i)+68,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		local TelCooltime2 = {}
		local TelCooltimeRecover2 = {}
		table.insert(TelCooltime2,SetMemoryB(0x57F27C+(228*i)+48,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		table.insert(TelCooltimeRecover2,SetMemoryB(0x57F27C+(228*i)+48,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoStim[i+1]),CDeaths(FP,AtLeast,1,TelCool[i+1])},{TelCooltime},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoStim[i+1]),CDeaths(FP,Exactly,0,TelCool[i+1])},{TelCooltimeRecover},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoHeal[i+1]),CDeaths(FP,AtLeast,1,TelCool2[i+1])},{TelCooltime2},{preserved})
		TriggerX(FP,{CDeaths(FP,AtLeast,1,AutoHeal[i+1]),CDeaths(FP,Exactly,0,TelCool2[i+1])},{TelCooltimeRecover2},{preserved})
		Trigger2(FP,{Deaths(i,AtLeast,1,197),Deaths(i,AtMost,0,14),Deaths(i,AtMost,0,16)},{SetDeaths(i,SetTo,1,14)},{preserved})
		CElseX()
			DoActions(FP,{SetDeaths(i,SetTo,0,12)}) -- 각플레이어가 존재하지 않을 경우 각플레이어의 브금타이머 0으로 고정 
			TriggerX(FP,{Deaths(i,AtLeast,1,227)},{SetDeaths(i,SetTo,0,227),SetCDeaths(FP,Add,100,PExitFlag)}) -- 나갔을 경우 1회에 한해 인구수 계산기 작동
		CIfXEnd()
	end
	DoActions(FP,{SetDeaths(9,SetTo,0,12),SetDeaths(10,SetTo,0,12),SetDeaths(11,SetTo,0,12),SetDeaths(12,SetTo,0,12)}) -- 각플레이어가 존재하지 않을 경우 각플레이어의 브금타이머 0으로 고정 
	
	local TempPos = CreateVar(FP)

	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- 원격스팀 외 기능들
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
			SetMemory(0x662350 + (4*10),Add,70000*256), -- 체력 증가
			SetMemoryX(0x6647B8, SetTo, 16711680,16711680); -- 쉴드 활성화
			SetMemoryX(0x657678, Add, 29,0xFFFF); -- 공격력 증가량
			SetMemory(0x515BCC,Add,256*70); -- 일마 퍼뎀 조정
			SetMemoryX(0x6566F8, SetTo, 3,0xFF); -- 스플설정
			SetMemoryX(0x656888, SetTo, 2,0xFFFF); -- 안쪽 
			SetMemoryX(0x6570C8, SetTo, 6,0xFFFF); -- 중간 
			SetMemoryX(0x657780, SetTo, 10,0xFFFF); -- 외곽
			SetMemory(0x657470, SetTo, 32*7); -- 사거리
		CopyCpAction({DisplayTextX("\t\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x1F！！！　ＴＥＡＭ　ＥＮＣＨＡＮＴＥＤ　！！！\n\n\n\x13\x04누군가가 \x1F팀 강화 효과\x04를 구입하였습니다.\n\x13\x04Normal Marine의 성능이 대폭 향상되었습니다.\n\n\n\x13\x1F！！！　ＴＥＡＭ　ＥＮＣＨＡＮＴＥＤ　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
		PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),},HumanPlayers,FP)
	})
	CIfEnd()
	
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- 체력표기
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
	DoActions(FP,{CopyCpAction({DisplayTextX("\t\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x1F！！！　ＥＶＥＮＴ　！！！\n\n\n\x13\x1F이벤트\x04가 감지되었습니다.\n\x13\x07스탯 포인트 획득량\x04이 일정배율 \x1F증가\x04하였습니다.\n\n\n\x13\x1F！！！　ＥＶＥＮＴ　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
	PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),},HumanPlayers,FP)})
	CMov(FP,MulPoint,_ReadF(EvCheckPtr))
	CIfEnd()
end