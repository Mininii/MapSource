function Include_Vars()
	--System
	GiveRate2 = {1000,5000,10000,50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1} 
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0","\x06#X_MAX"}
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4}
	MarID = {0,1,16,99,100} 
	ObPlayers = {P9,P10,P11,P12}
	MedicTrig = {34,9,88,80,21}
	MedicTick = {1,2,3,4,5}
	ObEff = 84
	nilunit = 181
	QueueMaxSize = 200000
	MSDiff = {
		 "\x08HD S\x04tyle",
		 "\x16MX S\x04tyle",
		 "\x08SC S\x04tyle",
	}
	if DLC_Project == 1 then
		QueueMaxUnit = 1500
	else
		QueueMaxUnit = 1650

	end
	if DLC_Project == 1 then
		AutoHealDiv = 100 -- 자동힐 나누기 계수
		NMBaseAtk=40 -- 파벳베이스 : 1/2 데미지로 설정할것
		NMFactorAtk=7 -- 파벳베이스 : 1/2 데미지로 설정할것
		HMBaseAtk=100
		HMFactorAtk=20
		SMBaseAtk = 100 -- 파벳베이스 : 1/2 데미지로 설정할것
		SMFactorAtk = 15 -- 파벳베이스 : 1/2 데미지로 설정할것
		RMBaseAtk = 90
		RMFactorAtk = 40
		
		SMSkillBaseAtk = 50
		SMSkillFactorAtk = 20
		SMSkillBaseAtk2 = 100
		SMSkillFactorAtk2 = 25
		SMSkillBaseAtk3 = 150
		SMSkillFactorAtk3 = 35
		RMSkillBaseAtk = 350
		RMSkillFactorAtk = 100
	else
		NMBaseAtk=5 -- 파벳베이스 : 1/2 데미지로 설정할것
		NMFactorAtk=3 -- 파벳베이스 : 1/2 데미지로 설정할것
		HMBaseAtk=50
		HMFactorAtk=10
		SMBaseAtk = 50 -- 파벳베이스 : 1/2 데미지로 설정할것
		SMFactorAtk = 8 -- 파벳베이스 : 1/2 데미지로 설정할것
		RMBaseAtk = 0
		RMFactorAtk = 12
	end
	if DLC_Project == 1 then
		NMCost = 20000
		HMCost = 40000
		SMCost = 50000--유닛죽이기용
		RMCost = 300000--건작용
		RMtoSMCost = 2000
	else
		NMCost = 5000
		HMCost = 20000
		SMCost = 25000
		RMCost = 10000
		RMtoSMCost = 2000
	end

	if X4_Mode == 1 then
		AutoHealDiv = AutoHealDiv / 2
		NMBaseAtk= NMBaseAtk * 2
		NMFactorAtk= NMFactorAtk * 2
		HMBaseAtk= HMBaseAtk * 2
		HMFactorAtk= HMFactorAtk * 2
		SMBaseAtk = SMBaseAtk * 2
		SMFactorAtk = SMFactorAtk * 2
		RMBaseAtk = RMBaseAtk * 2
		RMFactorAtk = RMFactorAtk * 2
		
		SMSkillBaseAtk = SMSkillBaseAtk * 2
		SMSkillFactorAtk = SMSkillFactorAtk * 2
		SMSkillBaseAtk2 = SMSkillBaseAtk2 * 2
		SMSkillFactorAtk2 = SMSkillFactorAtk2 * 2
		SMSkillBaseAtk3 = SMSkillBaseAtk3 * 2
		SMSkillFactorAtk3 = SMSkillFactorAtk3 * 2
		RMSkillBaseAtk = RMSkillBaseAtk * 2
		RMSkillFactorAtk = RMSkillFactorAtk * 2

	end

	--Arr
	UnitIDArr = CreateFArr(1700, FP)
	UnitPosArr = CreateFArr(1700, FP)
	PlayerIDArr = CreateFArr(1700, FP)
	UnitHPArr = CreateFArr(1700, FP)
	if DLC_Project == 1 then 
		ExRateT = {
			{20,22,24,27,30},{11,12,13,15,17},{9,10,11,13,14}
		}
	else
		ExRateT = {
			18,13,12
		}
	end
	--Vars
	HongEnable = CreateCcode()
	CurSpeed = CreateVar(FP)
	SELimit = CreateCcode()
    ExRate = CreateVar2(FP, nil, nil, 20)
	Nextptrs = CreateVar(FP)
	NextptrsP = CreateVar(FP)
	BGMType = CreateVar(FP)
	TestMode = CreateCcode()
	BossStart = CreateCcode()
	Names = CreateVArrArr(7,7,FP)
	CurCunitI = CreateVar(FP)
	CurCunitI2 = CreateVar(FP)
	SetPlayers = CreateVar(FP)
	BarPos = CreateVarArr(7,FP)
	BarRally = CreateVarArr(7,FP)
	CunitIndex = CreateVar(FP)
	RepHeroIndex = CreateVar(FP)
	PlayerV=CreateVar(FP)
	UnitRepIndex = CreateVar(FP)
	GMode = CreateCcode()
	PPosX = CreateVarArr(7, FP)
	PPosY = CreateVarArr(7, FP)
	MBPtr = CreateVarArr(5, FP)
	VTimerB = CreateVarArr(6,FP)
	VFlagB = CreateVarArr(6,FP)
	VFlag256B = CreateVarArr(6,FP)
	EVFCcode = CreateCcode()
	CTMin = CreateVarArr(7, FP)
	if DLC_Project == 1 then
		MarNumberLimit = CreateVar3(FP,1800)
	else
		MarNumberLimit = CreateVar3(FP,1800)
	end
	PCheck = CreateCcode()
	PExitFlag = CreateCcode()
	SuppMax = CreateVar(FP)
	PCheckV = CreateVar(FP)
	GunCcode = CreateCcode()
	ChryCcode = CreateCcode()
	CocoonCcode = CreateCcode()
	NMCr = CreateCcodeArr(5)
	HMCr = CreateCcodeArr(5)
	SMCr = CreateCcodeArr(5)
	RMCr = CreateCcodeArr(5)
	CrCheck1 = CreateCcodeArr(5)
	CrCheck2 = CreateCcodeArr(5)
	CSPtr = CreateVar(FP)
	OverMePosX = CreateArr(20, FP)
	OverMePosY = CreateArr(20, FP)
	GTime = CreateVar(FP)
	LTime = CreateVar(FP)
	WinCcode = CreateCcode()
	WinCcode2 = CreateCcode()
	HStr2 = SaveiStrArrX(FP,MakeiStrVoid(54*11)) 
	HStr4 = SaveiStrArrX(FP,MakeiStrVoid(54)) 
	HVA3 = CVArray(FP,4*5) 
	LCP = CreateVar(FP)
	HLine, ChatSize, ChatOff, HCheck = CreateVars(4,FP) 
	GS = CreateCcode()
	
	SMPtr = CreateVarArr(5, FP)
	RMPtr = CreateVarArr(5, FP)
	SMRebirthT = CreateVarArr(5,FP)
	RMRebirthT = CreateVarArr(5,FP)
	SMRebirthAct = CreateVarArr(5,FP)
	RMRebirthAct = CreateVarArr(5,FP)
	SMRebirthT2 = CreateCcodeArr(5)
	RMRebirthT2 = CreateCcodeArr(5)


	CurHealUpgrade = CreateVarArr(5, FP)
	HealUpgrade = CreateVarArr(5, FP)
	CurRebirthUp = CreateVarArr(5, FP)
	RebirthUp = CreateVarArr(5, FP)
	CurInvUp = CreateVarArr(5, FP)
	InvUp = CreateVarArr(5, FP)

	
	CurSMUp = CreateVarArr(5, FP)
	SMUp = CreateVarArr(5, FP)

	
	CurRMUp = CreateVarArr(5, FP)
	RMUp = CreateVarArr(5, FP)

	HealCost = {}
	HealCostFactor = 100000
	for i = 1, 5 do
		table.insert(HealCost,CreateVar2(FP,nil,nil,100000))
	end

	RebirthCost = {}
	RebirthCostFactor = 500000
	for i = 1, 5 do
		table.insert(RebirthCost,CreateVar2(FP,nil,nil,500000))
	end

	SMSkillCost = {}
	SMSkillCostFactor = 10000
	for i = 1, 5 do
		table.insert(SMSkillCost,CreateVar2(FP,nil,nil,20000))
	end
	RMSkillCost = {}
	RMSkillCostFactor = 25000
	for i = 1, 5 do
		table.insert(RMSkillCost,CreateVar2(FP,nil,nil,50000))
	end


	HealUpMaskRetArr = {}
	HealUpPtrArr = {}
	RebirthUpMaskRetArr = {}
	RebirthUpPtrArr = {}
	InvUpMaskRetArr = {}
	InvUpPtrArr = {}
	
	SMUpMaskRetArr = {}
	SMUpPtrArr = {}

	
	RMUpMaskRetArr = {}
	RMUpPtrArr = {}


	for i = 0, 4 do
	table.insert(HealUpMaskRetArr,(0x58D2B0+(i*46)+22)%4)
	table.insert(HealUpPtrArr,0x58D2B0+(i*46)+22 - HealUpMaskRetArr[i+1])
	table.insert(RebirthUpMaskRetArr,(0x58D2B0+(i*46)+23)%4)
	table.insert(RebirthUpPtrArr,0x58D2B0+(i*46)+23 - RebirthUpMaskRetArr[i+1])
	table.insert(InvUpMaskRetArr,(0x58D2B0+(i*46)+43)%4)
	table.insert(InvUpPtrArr,0x58D2B0+(i*46)+43 - InvUpMaskRetArr[i+1])
	
	table.insert(SMUpMaskRetArr,(0x58D2B0+(i*46)+17)%4)
	table.insert(SMUpPtrArr,0x58D2B0+(i*46)+17 - SMUpMaskRetArr[i+1])
	
	table.insert(RMUpMaskRetArr,(0x58D2B0+(i*46)+21)%4)
	table.insert(RMUpPtrArr,0x58D2B0+(i*46)+21 - RMUpMaskRetArr[i+1])

	end

	--strings
	
	_0D = string.rep("\x0D",200) 
	RandSwitch1 = "Switch 100"
	RandSwitch2 = "Switch 101"
	RandSwitch3 = "Switch 102"
	RandSwitch4 = "Switch 103"
	JYD = "Set Unit Order To: Junk Yard Dog"
	DelayMedicT = {
		StrDesign("\x1D예약메딕\x04을 \x1B2Tick\x04으로 변경합니다. - \x1F225 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B3Tick\x04으로 변경합니다. - \x1F250 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B4Tick\x04으로 변경합니다. - \x1F275 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B5Tick\x04으로 변경합니다. - \x1F300 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B비활성화(1Tick)\x04하였습니다. - \x1F200 Ore\x07")}

	GiveRateT = {
	StrDesign("\x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.")}
	GiveUnitID = {64,65,66,67,61}
	BanToken = {68,84,69,70,60}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 



	
	UnitPointArr = {}
	UnitPointArr2 = {38,37,39,43,44,55,56,48,50,51,53,54,46}--재배치 등록 위치
	for j, k in pairs(UnitPointArr2) do
		--PatchInsert(SetMemoryB(0x57F27C + (5 * 228) + k,SetTo,0))
		--PatchInsert(SetMemoryB(0x57F27C + (6 * 228) + k,SetTo,0))
		--PatchInsert(SetMemoryB(0x57F27C + (7 * 228) + k,SetTo,0))
		SetUnitsDatX(k, {SizeL=4,SizeU=4,SizeR=4,SizeD=4,GroupFlag=0x29})
	end
		SetUnitsDatX(10, {SizeL=7,SizeU=7,SizeR=8,SizeD=9})
		SetUnitsDatX(32, {SizeL=7,SizeU=7,SizeR=8,SizeD=9})
		SetUnitsDatX(20, {SizeL=7,SizeU=7,SizeR=8,SizeD=9})
	for j,k in pairs(MarID) do
		SetUnitsDatX(k, {SizeL=7,SizeU=7,SizeR=8,SizeD=9})
	end


	
	function Create_VoidEPDHeaderV(Player,Size)
		local Void = f_GetVoidptr(Player,Size)
		local Header =  CreateVar(Player)
		table.insert(CtrigInitArr[Player+1],SetCtrigX(Header[1],Header[2],0x15C,Header[3],SetTo,Void[1],Void[2],Void[3],1,Void[4]))
		return Header
	end
	CreateUnitQueueUIDArr = Create_VoidEPDHeaderV(FP,4*(QueueMaxSize+5))
	CreateUnitQueuePIDArr = Create_VoidEPDHeaderV(FP,4*(QueueMaxSize+5))
	CreateUnitQueueXPosArr = Create_VoidEPDHeaderV(FP,4*(QueueMaxSize+5))
	CreateUnitQueueYPosArr = Create_VoidEPDHeaderV(FP,4*(QueueMaxSize+5))
	CreateUnitQueueTypeArr = Create_VoidEPDHeaderV(FP,4*(QueueMaxSize+5))
	CreateUnitQueueBakXPosArr = Create_VoidEPDHeaderV(FP,4*(QueueMaxSize+5))
	CreateUnitQueueBakYPosArr = Create_VoidEPDHeaderV(FP,4*(QueueMaxSize+5))
	CreateUnitQueuePtr = CreateVar(FP)
	CreateUnitQueueNum = CreateVar(FP)
	CreateUnitQueuePtr2 = CreateVar(FP)
	CreateUnitQueuePenaltyT = CreateVar(FP)
	CreateUnitQueuePenaltyAct = CreateVar(FP)
	CreateUnitQueuePenaltyLock = CreateVar(FP)
	ShUsed = CreateCcode()
	ShCool = CreateCcode()
	ShCost = 60000
	
	--tier 1
	SetUnitAbility(21,18,3,17000,false,30,450,false,1,160,5,45000,"Kazansky",2000) --
	SetUnitAbility(17,9,3,15000,false,1,330,false,1,160,5,35000,"Schezar",2500) --
	SetUnitAbility(19,5,2,30000,false,22,550,false,1,160,5,65000,"Raynor V",4000) --
	SetUnitAbility(28,23,3,35000,false,22,680,false,1,192,6,40000,"Hyperion",5000) --
	SetUnitAbility(88,114,3,15000,5000,22,500,false,1,32*4,4,35000,"Artanis",3200) --
	SetUnitAbility(86,78,3,25000,10000,22,800,false,1,32*12,6,54000,"Danimoth",4500) --
	SetUnitAbility(77,65,3,20000,false,15,350,false,2,32*2,3,35000,"Fenix Z",1800) --
	SetUnitAbility(78,67,3,25000,false,15,320,false,1,32*5,5,45000,"Fenix D",2800) --
	SetUnitAbility(25,28,1,20000,false,75,1000,{15,30,45},1,384,12,30000,"Duke Siege",3000) --
	SetUnitAbility(75,85,3,20000,10000,22,900,false,1,32*1,3,35000,"Zeratul",3800) --
	SetUnitAbility(84,79,4,24000,9000,8,150,false,1,32*4,3,65000,"Lin",3000) --인터셉터

	--tier 2
	SetUnitAbility(76,71,4,30000,10000,20,200,{30,30,30},1,32*2,3,55000,"Archon",4800) --
	SetUnitAbility(79,69,3,35000,10000,22,750,false,1,32*4,4,65000,"Tassadar",3400) --
	SetUnitAbility(98,89,4,15000,10000,8,250,{5,50,100},1,32*4,9,70000,"Raszagal",5000) --커세어
	SetUnitAbility(58,93,4,12000,3000,40,200,{3,5,10},1,32*5,6,80000,"Envy",6000) --발키리
	SetUnitAbility(81,29,1,1,40000,15,1350,false,1,32*4,4,70000,"Yuna",5500) -- 리버자매(?)
	SetUnitAbility(83,76,3,35000,10000,23,900,false,1,32*7,5,80000,"Yumi",7500) -- 리버자매(?)
	SetUnitAbility(95,25,2,30000,10000,15,350,{10,20,30},2,96,3,70000,"Darly",5000) --파벳
	--tier 3
	SetUnitAbility(80,75,3,40000,24000,22,1150,false,1,32*5,4,80000,"Lizzet",6000) -- 강스카1
	SetUnitAbility(93,26,4,48000,25000,15,250,{10,20,30},2,32*1,2,90000,"Yona",8000) --스캔티드
	SetUnitAbility(5,11,1,60000,10000,32,950,{10,20,70},1,224,7,120000,"Rophe",12000) --탱크
	SetUnitAbility(2,4,4,40000,20000,15,350,{60,60,60},1,160,6,90000,"Sui",8000) --강벌쳐
	SetUnitAbility(3,8,4,50000,10000,15,700,false,1,224,7,100000,"Shirley House",10000) --강골럇
	SetUnitAbility(8,15,3,45000,15000,22,950,false,1,160,5,80000,"Merry",7000)  --강레이스
	SetUnitAbility(12,20,4,55000,20000,15,1100,false,1,224,7,110000,"Rose",11000) --강배틀1
	SetUnitAbility(34,94,2,60000,10000,15,1050,false,1,160,5,120000,"Jisoo",10000) --메딕
	SetUnitAbility(29,21,4,40000,10000,22,650,false,1,192,6,90000,"Norad II",8000) --노라드
	SetUnitAbility(52,51,2,45000,25000,15,1500,false,1,32*7,4,110000,"Yuri",10000) --디파
	SetUnitAbility(65,64,3,50000,15000,22,500,false,2,32,4,100000,"Freyja",6000) --강질럿
	SetUnitAbility(66,66,4,60000,18000,30,888,false,1,32*5,4,100000,"Kamilia",6000) --강드라

	

	SetUnitAbility(7,13,2,70000,30000,15,1150,false,1,260,8,150000,"Era",15000) --에시비
	SetUnitAbility(60,100,4,50000,30000,8,550,{5,50,100},1,32*5,9,130000,"Nina",19000) --강커세어
	SetUnitAbility(70,74,1,70000,40000,15,2200,false,1,32*7,7,140000,"Sera",22000) --강스카2
	SetUnitAbility(40,42,3,80000,30000,15,1200,false,1,16,3,150000,"Sadol",15000) --부르드링
	SetUnitAbility(57,92,1,85000,25000,15,2300,false,1,32*5,4,100000,"Sorang",10000) --퀸
	SetUnitAbility(62,104,4,90000,45000,100,1500,false,1,32*4,4,150000,"Sena",23000) --디바우러
	SetUnitAbility(64,62,3,70000,25000,22,1111,false,1,32*5,4,100000,"Sen",10000) --프로브
	SetUnitAbility(87,88,4,110000,40000,15,1122,false,1,32*4,3,114000,"Gaya",9500) --강하템
	SetUnitAbility(74,86,4,160000,65535,22,1666,false,1,32*1,4,120000,"Leon",11800) --강다크



	
	SetUnitAbility(102,22,5,222222,false,30,1990,false,1,224,7,500000,"Division",25000)
	SetUnitAbility(23,12,5,444444,false,37,3500,false,1,224,7,400000,"DeathsX",35000)
	SetUnitAbility(27,70,5,500000,false,30,2100,{30,30,30},1,64,5,500000,"Zero",50000)
	SetUnitAbility(68,70,5,777777,65535,30,2100,{30,30,30},1,64,4,777777,"Destroy",60000)
	SetUnitAbility(30,27,5,37,false,75,3737,{15,30,45},1,384,12,96666,"Identity",5000)
	
	
	
	
	
	
	SetUnitAbility(89,90,5,3950000,65535,15,2999,false,1,32*9,9,1500000,"EL FAIL",800000)
	SetUnitAbility(61,111,5,5550000,65535,18,3999,false,1,32*1,1,1900000,"DIEIN",1000000)
	SetUnitAbility(63,19,5,4350000,65535,55,1999,{45,45,45},1,32*4,3,1000000,"PLAY",900000)
	SetUnitAbility(67,68,5,3880000,65535,15,1444,{60,60,60},1,32*4,3,1400000,"EL CLEAR",900000)
	SetUnitAbility(71,77,5,3950000,65535,30,3737,false,1,32*5,5,1100000,"LENA",800000)


	SetUnitAbility(124,91,1,120000,30000,15,1800,false,1,32*5,5,110000,"Turret",15000) --
	SetUnitAbility(11,117,4,77777,65535,15,1111,false,1,32*5,9,nil,"Prom",0) --
	SetUnitAbility(69,118,4,77777,65535,15,1111,false,1,32*5,9,nil,"Aari",0) --

--


--[[너프전 버전

	--tier 1
	SetUnitAbility(21,18,3,17000,false,30,450,false,1,160,5,45000,"Kazansky",2000) --
	SetUnitAbility(17,9,3,15000,false,1,330,false,1,160,5,35000,"Schezar",2500) --
	SetUnitAbility(19,5,3,30000,false,22,550,false,1,160,5,65000,"Raynor V",4000) --
	SetUnitAbility(28,23,3,35000,false,22,680,false,1,192,6,40000,"Hyperion",5000) --
	SetUnitAbility(88,114,3,15000,5000,22,500,false,1,32*4,4,35000,"Artanis",3200) --
	SetUnitAbility(86,78,3,25000,10000,22,800,false,1,32*12,6,54000,"Danimoth",4500) --
	SetUnitAbility(77,65,3,20000,false,15,350,false,2,32*2,3,35000,"Fenix Z",1800) --
	SetUnitAbility(78,67,3,25000,false,15,320,false,1,32*5,5,45000,"Fenix D",2800) --
	SetUnitAbility(25,28,1,20000,false,75,1000,false,1,384,12,30000,"Duke Siege",3000) --
	SetUnitAbility(75,85,3,20000,10000,22,900,false,1,32*1,3,35000,"Zeratul",3800) --
	SetUnitAbility(84,79,4,24000,9000,8,150,false,1,32*4,3,65000,"Lin",3000) --인터셉터



	--tier 2
	SetUnitAbility(76,71,4,30000,10000,20,200,{30,30,30},1,32*2,3,55000,"Archon",4800) --
	SetUnitAbility(79,69,3,35000,10000,22,750,false,1,32*4,4,65000,"Tassadar",3400) --
	SetUnitAbility(98,89,4,15000,10000,8,250,{5,50,100},1,32*4,9,70000,"Raszagal",5000) --커세어
	SetUnitAbility(58,93,4,15000,8000,40,250,{3,10,20},1,32*5,6,80000,"Envy",6000) --발키리
	SetUnitAbility(81,29,1,1,60000,15,1350,false,1,32*4,4,70000,"Yuna",5500) -- 리버자매(?)
	SetUnitAbility(83,76,3,70000,10000,23,900,false,1,32*7,5,80000,"Yumi",7500) -- 리버자매(?)
	SetUnitAbility(95,25,3,30000,30000,15,400,{10,20,30},1,96,3,70000,"Darly",5000) --파벳

	
	--tier 3
	SetUnitAbility(80,75,3,60000,24000,22,1150,false,1,32*5,4,80000,"Lizzet",6000) -- 강스카1
	SetUnitAbility(93,26,4,78000,25000,15,170,{10,20,30},2,32*1,2,90000,"Yona",8000) --스캔티드
	SetUnitAbility(5,11,1,70000,30000,32,950,{10,20,70},1,224,7,120000,"Rophe",12000) --탱크
	SetUnitAbility(2,4,4,60000,20000,15,350,{60,60,60},1,160,6,90000,"Sui",8000) --강벌쳐
	SetUnitAbility(3,8,4,50000,30000,15,700,false,1,224,7,100000,"Shirley House",10000) --강골럇
	SetUnitAbility(8,15,3,65000,15000,22,950,false,1,160,5,80000,"Merry",7000)  --강레이스
	SetUnitAbility(12,20,4,85000,30000,15,1100,false,1,224,7,110000,"Rose",11000) --강배틀1
	SetUnitAbility(34,94,4,80000,30000,15,850,false,1,160,5,120000,"Jisoo",10000) --메딕
	SetUnitAbility(29,21,4,50000,10000,22,650,false,1,192,6,90000,"Norad II",8000) --노라드
	SetUnitAbility(52,51,3,75000,25000,15,1500,false,1,32*7,4,110000,"Yuri",10000) --디파
	SetUnitAbility(65,64,3,80000,15000,22,500,false,2,32,4,100000,"Freyja",6000) --강질럿
	SetUnitAbility(66,66,4,90000,28000,30,888,false,1,32*5,4,100000,"Kamilia",6000) --강드라





	SetUnitAbility(7,13,3,120000,50000,15,950,false,1,260,8,150000,"Era",15000) --에시비
	SetUnitAbility(60,100,4,100000,50000,8,550,{5,50,100},1,32*5,9,130000,"Nina",19000) --강커세어
	SetUnitAbility(70,74,1,150000,60000,15,3000,false,1,32*7,7,140000,"Sera",22000) --강스카2
	SetUnitAbility(40,42,3,120000,30000,15,1200,false,1,16,3,150000,"Sadol",15000) --부르드링
	SetUnitAbility(57,92,1,150000,35000,15,2300,false,1,32*5,4,200000,"Sorang",20000) --퀸
	SetUnitAbility(62,104,4,150000,50000,100,1500,false,1,32*4,4,150000,"Sena",23000) --디바우러
	SetUnitAbility(64,62,3,150000,25000,22,1111,false,1,32*5,4,100000,"Sen",10000) --프로브
	SetUnitAbility(87,88,4,110000,40000,15,1122,false,1,32*4,3,114000,"Gaya",9500) --강하템
	SetUnitAbility(74,86,4,210000,40000,22,1666,false,1,32*1,4,120000,"Leon",3800) --강다크




	
	SetUnitAbility(102,22,5,222222,false,30,2550,false,1,224,7,500000,"Division",25000)
	SetUnitAbility(23,12,5,444444,false,37,3500,false,1,224,7,400000,"DeathsX",35000)
	SetUnitAbility(27,70,5,500000,false,30,4200,{30,30,30},1,64,5,500000,"Zero",50000)
	SetUnitAbility(68,70,5,777777,65535,30,4200,{30,30,30},1,64,4,777777,"Destroy",60000)
	SetUnitAbility(30,27,5,322,false,75,3222,false,1,384,12,96666,"Identity",5000)


	
	SetUnitAbility(89,90,5,3950000,65535,15,2999,false,1,32*9,9,1500000,"EL FAIL",800000)
	SetUnitAbility(61,111,5,5550000,65535,18,3999,false,1,32*1,1,1900000,"DIEIN",1000000)
	SetUnitAbility(63,19,5,4350000,65535,55,1999,{45,45,45},1,32*4,3,1000000,"PLAY",900000)
	SetUnitAbility(67,68,5,3880000,65535,15,1444,{60,60,60},1,32*4,3,1400000,"EL CLEAR",900000)
	SetUnitAbility(71,77,5,3950000,65535,30,3777,false,1,32*5,5,1100000,"LENA",800000)


	SetUnitAbility(124,91,1,120000,30000,15,1800,false,1,32*5,5,110000,"Turret",15000) --

]]
end