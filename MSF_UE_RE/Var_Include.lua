
function Objects()


	LvLimit = 100
	-- Balance
	MarDamageFactor = 1 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	MarDamageAmount = 30 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	NMarDamageFactor = 1 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	NMarDamageAmount = 20 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	AtkFactor = 5
	DefFactor = 10
	GunLimit = 1500
	Ex1= {20,25,30,35,40,45,50}
	NK= {30,18,13,9,7,6,5}

	--Shop
	P_MultiStopCost = 20
	P_MultiHoldCost = 20
	P_StimCost = 10 -- 원격 스팀팩 사용가능
	P_ExcOldP = 10000
	P_AtkExceed = 15
	P_HPExceed = 15
	
	--System
	MarID = {0,1,16,20,32,99,100}  
	MarWep = {117,118,119,120,121,122,123} 
	GiveRate2 = {10000, 50000,100000,500000,1000000,5000000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4} 
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,5,6,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4,5,6}
	ObPlayers = {P9,P10,P11,P12}
	MedicTrig = {34,9,2,3}
	EXCC_Forward = 0x2FFF
	ObEff = 94
	nilunit = 181

	-- Strings

	_0D = string.rep("\x0D",200) 
	HTextStr = _0D
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0"}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 
	PlayersN = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인","\x156인","\x167인"}
	ResetSwitch = "Switch 250"
	WaveSwitch = "Switch 150"
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_RepeatErr2 = "\x07『 \x08ERROR : \x04Set_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	G_SendErrT = "\x07『 \x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	JYD = "Set Unit Order To: Junk Yard Dog" 
	DelayMedicT = {
		"\x07『 \x1D예약메딕\x04을 \x1B2Tick\x04으로 변경합니다. - \x1F300 Ore\x07 』",
		"\x07『 \x1D예약메딕\x04을 \x1B3Tick\x04으로 변경합니다. - \x1F350 Ore\x07 』",
		"\x07『 \x1D예약메딕\x04을 \x1B4Tick\x04으로 변경합니다. - \x1F400 Ore\x07 』",
		"\x07『 \x1D예약메딕\x04을 \x1B비활성화(1Tick)\x04하였습니다. - \x1F250 Ore\x07 』"}
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
	Switch("Switch 250",Set);N = 220,1
	Switch("Switch 250",Set);Y = 221,1
	]]
	ESC = 199
	RIGHT = 200
	LEFT = 201
	F12 = 202
	F9 = 203
	B = 204
	-- 441 = OPConsole 
	-- 442 = CPConsole 
	-- 443 = BanConsole
	OPConsole = 441
	CPConsole = 442
	BanConsole = 443    
	VResetSw = CreateVar3(FP,1,nil,nil)
	VResetSw2 = CreateVar3(FP,1,nil,nil)
	VResetSw3 = CreateVar3(FP,1,nil,nil)
	VResetSw4 = CreateVar3(FP,1,nil,nil)
	VResetSw5 = CreateVar3(FP,1,nil,nil)
    

	
VoidAreaOffset = 0x594000
VoidAreaAlloc = 0x594000-4

--    roka7TempVoid = EPD(0x594000)

    function VO(Number)
        return VoidAreaOffset+(Number*4)
    end
--    function Void(Number,Type,Value)
--        return Deaths(roka7TempVoid+Number,Type,Value,0)
--    end
--    function SetVoid(Number,Type,Value)
--        return SetDeaths(roka7TempVoid+Number,Type,Value,0)
--    end
--    function VoidX(Number,Type,Value,Mask)
--        return DeathsX(roka7TempVoid+Number,Type,Value,0,Mask)
--    end
--    function SetVoidX(Number,Type,Value,Mask)
--        return SetDeathsX(roka7TempVoid+Number,Type,Value,0,Mask)
--    end
	MoveMarineArr2 = {}
	for i = 0, 6 do
	table.insert(MoveMarineArr2,MoveUnit(All,"Men",i,"Create 1",2+i))
	table.insert(MoveMarineArr2,MoveUnit(All,"Men",i,"Create 2",2+i))
	for j = 0, 4 do
	table.insert(MoveMarineArr2,MoveUnit(All,"Men",i,"Create 1",20+j))
	table.insert(MoveMarineArr2,MoveUnit(All,"Men",i,"Create 2",20+j))
	end
	end
	
	OWTable = {}
	for i = 0, 95 do
		if i <= 20 or i >= 75 then 
	table.insert(OWTable,SetLoc("OW","L",SetTo,i*32))
	table.insert(OWTable,SetLoc("OW","R",SetTo,32+(i*32)))
	table.insert(OWTable,SetLoc("OWDest","L",SetTo,i*32))
	table.insert(OWTable,SetLoc("OWDest","R",SetTo,32+(i*32)))
	table.insert(OWTable,Order("Men",Force1,"OW",Move,"OWDest"))
		end
	end
	
DL_Patch = {}
table.insert(DL_Patch,SetMemory(0x6617C8 + (55*8),SetTo,(22)+(22*65536)))
table.insert(DL_Patch,SetMemory(0x6617CC + (55*8),SetTo,(21)+(21*65536)))
table.insert(DL_Patch,SetMemory(0x6617C8 + (56*8),SetTo,(22)+(22*65536)))
table.insert(DL_Patch,SetMemory(0x6617CC + (56*8),SetTo,(21)+(21*65536)))
table.insert(DL_Patch,SetMemory(0x6617C8 + (62*8),SetTo,(22)+(22*65536)))
table.insert(DL_Patch,SetMemory(0x6617CC + (62*8),SetTo,(21)+(21*65536)))
DL_Recover = {}
table.insert(DL_Recover,SetMemory(0x6617C8 + (55*8),SetTo,(1)+(10*65536)))
table.insert(DL_Recover,SetMemory(0x6617CC + (55*8),SetTo,(1)+(10*65536)))
table.insert(DL_Recover,SetMemory(0x6617C8 + (56*8),SetTo,(1)+(10*65536)))
table.insert(DL_Recover,SetMemory(0x6617CC + (56*8),SetTo,(1)+(10*65536)))
table.insert(DL_Recover,SetMemory(0x6617C8 + (62*8),SetTo,(1)+(10*65536)))
table.insert(DL_Recover,SetMemory(0x6617CC + (62*8),SetTo,(1)+(10*65536)))
table.insert(DL_Patch,SetMemoryX(0x664080 + (30*4),SetTo,0x0,0x4))
table.insert(DL_Recover,SetMemoryX(0x664080 + (30*4),SetTo,0x4,0x4))

	Install_ShapeData()
end

function Var_init()
	-- 0x58f500 SelHP 0x58f504 MarHP 0x58f508 SelSh 0x58f0c 0x58f510
	TimePtr = 0x591FE8
	LevelPtr = 0x591FEC
	LimitVerPtr = 0x58f608
	EvCheckPtr = 0x58f60C
	--0x58f610 MSQC
	--0x590004~0x591FE4 PEUD Area UnitID : 494~664
	


	--iStr1 = GetiStrId(FP,MakeiStrLetter(" ",PlayerInfoSize).."\r\n",..MakeiStrLetter(" ",))
	--Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(38))

	Str01 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04\x04님의 \x04Normal Marine\x04이 \x1F한계\x04를 극복하지 못하고 \x08사망\x04했습니다. \x06(\x07Score \x08-50\x06) \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str02 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04\x04님의 \x1FExceeD \x1BM\x04arine\x04이 \x1F한계\x04를 극복하지 못하고 \x08사망\x04했습니다. \x06(\x07Score \x08-500\x06) \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str12 = CreateCText(FP,"\x12\x07『 \x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str22 = CreateCText(FP,"\x04 미네랄을 소비하여 총 \x0d\x0d\x0d\x0d\x0d\x0d")
	Str23 = CreateCText(FP,"\x04 회 업그레이드를 완료하였습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	f_GunErrT = CreateCText(FP,"\x07『 \x08ERROR \x04: G_CAPlot Not Found. f_Gun 실행자 : ")
	f_GunFuncT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: G_CAPlot Suspended. f_Gun 실행자 : ")
	f_GunSendT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	f_GunSendErrT = CreateCText(FP,"\x07『 \x08ERROR \x04: G_CAPlot Send Failed. f_Gun 실행자 : ")
	Str13 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04님이 \x1C수정 보호막\x04을 사용했습니다. \x07』\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
	Str24 = CreateCText(FP,"\x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	Str18 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d")
	DBossT1 = CreateCText(FP,"\x13\x10【 \x07P\x04layer \x06T\x04otal \x1FS\x04core : \x0d\x0d\x0d\x0d\x0d\x0d")
	DBossT2 = CreateCText(FP," / \x0d\x0d\x0d")
	DBossT3 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d \x10】\x0d\x0d\x0d\x0d\x0d\x0d")
	StPT = CreateCText(FP,"\x13\x10【 \x04이번 \x07Level\x04에서 얻은 \x19스탯 포인트 \x04: \x0d\x0d\x0d\x0d\x0d\x0d")
	KillPT = CreateCText(FP,"\x13\x10【 \x07킬 스코어가 \x19구버전 스탯 포인트\x04로 전환되었습니다. 구 3.5버전에서 이용가능합니다. \x04: \x0d\x0d\x0d\x0d\x0d\x0d")
	HiScoreT1 = CreateCText(FP,"\x10【 \x08M\x04ax \x0FL\x04evel : \x0d\x0d\x0d\x0d\x0d\x0d")
	HiScoreT2 = CreateCText(FP,"\x04 / \x08M\x04ax \x18S\x04core : \x07\x0d\x0d\x0d\x0d\x0d\x0d")
	NukeUseT = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04\x04님이 \x08뉴클리어\x04를 \x1F사용\x04하였습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	
	GiveSendT = CreateCText(FP,"\x07『 \x0d\x0d\x0d\x0d")
	GiveT2 = CreateCText(FP,"\x04에게 \x0d\x0d\x0d\x0d")
	GiveSendT2 = CreateCText(FP," Ore\x04를 기부하였습니다. \x07』")
	GiveReciveT = CreateCText(FP,"\x12\x07『 \x0d\x0d\x0d\x0d")
	GiveReciveT2 = CreateCText(FP," Ore\x04를 기부받았습니다.\x02 \x07』")
	GiveTReset = CreateCText(FP,"\x0D\x0D\x0DGive".._0D)
	SoloNoPointT = CreateCText(FP,"\x13\x10【 \x07솔로 플레이\x04에서는 \x08포인트를 획득할 수 없습니다. \x10】")
	

	StatPT = CreateCText(FP,"\x10【 \x07사용가능 / \x08최대 \07스탯 포인트 \x04: \x0d\x0d\x0d\x0d\x0d\x0d")
	StatPT2 = CreateCText(FP,"\x04 ◈ \x1FE\x04xchange \x07R\x04ate : \x07\x0d\x0d\x0d\x0d\x0d\x0d")
	StatPT3 = CreateCText(FP,"\x07% \x10】\x0d\x0d\x0d\x0d\x0d\x0d")
	



	ShopEndT = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d \x07』\x0d\x0d\x0d\x0d\x0d\x0d")

	DBossTotalDMGT = CreateCText(FP,"\x13\x1FＢ\x04ｏｓｓ \x08Ｂ\x04ａｔｔｌｅ \x07Ｂ\x04ｏｎｕｓ : ")
	HTextStrReset = CreateCText(FP,HTextStr)
	HeroVArr = f_GetVArrptr(FP,#HeroArr)
	ZergGndVArr = f_GetVArrptr(FP,#ZergGndUArr)
	
	Str19 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d \x03†")
	Str10 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x13\x03† \x04\x0d\x0d\x0d\x0d\x0d\x0d")
	if TestStart == 1 then
		BGMTypeV = CreateVar(FP)
		LevelT2 = CreateVar3(FP,1,nil,nil)
	else
		BGMTypeV = CreateVar(FP)
		LevelT2 = CreateVar3(FP,1,nil,nil)
	end
	Level = CreateVar3(FP,1,nil,nil)
	LevelT = CreateVar3(FP,1,nil,nil)


	MarNumberLimit = CreateVar3(FP,(48*2)*7)
	MaxHPBackUp = f_GetVArrptr(FP,228)
	
	MaxHPWArr = f_GetWArrptr(FP, 228)
	--elHPEPD,MarHPEPD,SelShEPD = CreateVariables(3)
	
	RepHeroIndex,CPos,CPosX,CPosY = CreateVariables(4)
	
	CunitP,SelOPEPD,CurCunitI,CurrentSpeed,CurrentOP = CreateVariables(5)
	UpgradeCP,UpgradeFactor,TempUpgradePtr,TempUpgradeMaskRet,UpgradeMax,UpResearched,UpCost,UpCompleted,UPCompStrPtr = CreateVariables(9)
	B1_K,B1_K2,B1_H = CreateVariables(3)
	count = CreateVar()
	UnitDataPtrVoid = f_GetVoidptr(FP,1700*12)
	XY_ArrHeaderVoid = f_GetVoidptr(FP,4000)
	PCheck = CreateCcode()
	TestMode = CreateCcode()
	FuncT = Create_CCTable(7)
	OPFuncT, IntroT, ReplaceDelayT = CreateCcodes(4)
	RandomHeroPlace = CreateCcode()
	Continue, Continue2 = CreateCcodes(2)
	PExitFlag, ScorePrint, countdownSound = CreateCcodes(3)
	BarrackPtr = Create_VTable(7)
	BarPos = Create_VTable(7)
	ExScore = Create_VTable(7)
	PScoreSTrPtr = Create_VTable(7)
	NukeUseStrPtr = Create_VTable(7)
	AMUseStrPtr = Create_VTable(7)
	f_GunNumT = CreateVArr(5,FP)
	Names = Create_VArrTable(7,7)
	BanToken = Create_CCTable(7) -- {"X",EXCC_Forward,0x15C,1,2}
	rokaClear = CreateCcode()
	IdenClear = CreateCcode()
    BossStart = CreateCcode()
	DLClear = CreateCcode()
    StoryT = CreateCcode()
	DemClear = CreateCcode()
	StoryT4 = CreateCcode()
	Win = CreateCcode()
	AutoJYDFlag = CreateCcodeArr(7)
	BiteCalc,InputPoint,OutputPoint,UnitPoint = CreateVariables(4)
	SoundLimitT = CreateCcode()
	SoundLimit = CreateCcodeArr(7)
	WaitT = CreateCcode()
	Destr0yerClear = CreateCcode()
	Destr0yerClear2 = CreateCcode()
	isDBossClear = CreateCcode()
	GCT = CreateCcode()
	isSingle = CreateCcode()
	DeleteToggle = CreateCcode()
	CA2ArrX = f_GetVArrptr(FP,1700)
	CA2ArrY = f_GetVArrptr(FP,1700)
	CA2ArrZ = f_GetVArrptr(FP,1700)
	CUnitFlag = CreateCcode()
	HeroPointNotice = CreateCcodeArr(7)
	CPConsoleToggle = CreateCcode()
	ConCP = CreateCcodeArr(7)
	GivePChange = CreateCcodeArr(7)

	Var_TempTable = {}
	Var_InputCVar = {}
	Var_Lines = 55
	for i = 1, Var_Lines do
		table.insert(Var_TempTable,CreateVar(FP))
		table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
	end

	--CreateVar
    SpeedVar = CreateVar3(FP,4)
	BackupCp = CreateVar(FP)
	RandW = CreateVar(FP)
	TRepeatX,TRepeatY = CreateVars(2,FP)
	Nextptrs = CreateVar(FP)
	CunitIndex = CreateVar(FP)
	Gun_LV = CreateVar(FP)
	G_TempW = CreateVar(FP)
	Gun_TempRand = CreateVar(FP)
	Spawn_TempW = CreateVar(FP)
	Gun_Type = CreateVar(FP)
	f_GunNum = CreateVar(FP)
	f_GunStrPtr = CreateVar(FP)
	count = CreateVar(FP)
	ReserveBGM = CreateVar(FP)
	Repeat_TempV = CreateVar(FP)
	TempBarPos = CreateVar(FP)
	ExchangeRate = CreateVar(FP)
	ExchangeRateT = CreateVarArr(7, FP)
	Actived_Gun = CreateVar(FP)
	HTextStrPtr = CreateVar(FP)
	UnitDataPtr = CreateVar(FP)
	XY_ArrHeader = CreateVar(FP)
	Time = CreateVar(FP)
	f_GunSendStrPtr = CreateVar(FP)
	Dt = CreateVar(FP)
	G_CA_StrPtr = CreateVar(FP)
	G_CA_StrPtr2 = CreateVar(FP)
	G_CA_StrPtr3 = CreateVar(FP)
	B_5_C = CreateVar(FP)
	B_Id_C = CreateVar(FP)
	PCheckV = CreateVar(FP)
	Dt_NT = CreateVar(FP)
	Dt_NT2 = CreateVar(FP)
	CurArr = CreateVar(FP)
	RepeatType = CreateVar(FP)
	CX = CreateVar(FP)
	CY = CreateVar(FP)
	DBoss_PrintScore = CreateVar(FP)
	DBoss_PrintScore2 = CreateVar(FP)
	TotalScore = CreateVar(FP)
	PointStrPtr = CreateVar(FP)
	DHP = CreateVar(FP)
	DPtr = CreateVar(FP)
	DcurHP = CreateVar(FP)
	StatusStrPtr1 = CreateVar(FP)
	CurrentDiff = CreateVar(FP)
	KillScStrPtr = CreateVar(FP)
	Diff = CreateVar(FP)
	WaveT = CreateVar(FP)
	RecallPosX = CreateVar(FP)
	SetPlayers = CreateVar(FP)
	HiScoreStrPtr = CreateVar(FP)
	NukeStrPtr = CreateVar(FP)
	SupplyStrPtr = CreateVar(FP)
	SuppMax = CreateVar(FP)
	MulPoint = CreateVar(FP)
	ArmorStrPtr = CreateVar(FP)
	GiveStrPtr = CreateVar(FP)
	QCUnits = CreateVar(FP)
	SpeedBackup = CreateVar(FP)
	AHPStrPtr = CreateVar(FP)
	NukesUsage = CreateVarArr(7,FP)
	OldStat = Create_VTable(7,nil,FP)
	UsedOldP = Create_VTable(7,nil,FP)
	OldMaxLevel = Create_VTable(7,nil,FP)
	NewMaxLevel = Create_VTable(7,1,FP)
	OldMaxScore = Create_VTable(7,nil,FP)
	AtkLV = Create_VTable(7,nil,FP)
	HPLV = Create_VTable(7,nil,FP)
	NewStat = Create_VTable(7,nil,FP)
	NewAvStat = Create_VTable(7,nil,FP)
    MapMaxLevel = CreateVar(FP)
    CurLevel = CreateVar2(FP,nil,nil,1)
	initStart = CreateCcode()
	RandV = CreateVar(FP)
	TempX = CreateVar(FP)
	TempY = CreateVar(FP)
	LevelFactor = CreateVar(FP)
	end

function HPoints()
	HeroPointArr = {}
	if TestStart == 1 then
		HeroArr = {84,11,69,121}
	else
		HeroArr = {77,78,28,17,19,21,86,75,88,25,29,76,79,98,80,27,23,81}
	end
	ZergGndUArr = {51,53,54,48,104}
	CreateHeroPointArr(77,35000,"\x07『 \x1DF\x04enix \x1DZ \x07』",1)
	CreateHeroPointArr(78,35000,"\x07『 \x1DF\x04enix \x1DD \x07』",1)
	CreateHeroPointArr(28,45000,"\x07『 \x1DH\x04yperion \x07』",1)
	CreateHeroPointArr(17,35000,"\x07『 \x1DA\x04lan \x1DS\x04chezar\x07 』",1)
	CreateHeroPointArr(19,65000,"\x07『 \x1FJ\x04im \x1FR\x04aynor \x1FV \x07』",1)
	CreateHeroPointArr(21,30000,"\x07『 \x1DT\x04om \x1DK\x04azansky \x07』",1)
	CreateHeroPointArr(27,70000,"\x07『 \x1DA\x04rcturus \x1DM\x04engsk \x07』",1)
	CreateHeroPointArr(86,70000,"\x07『 \x1DD\x04animoth \x07』",1)
	CreateHeroPointArr(75,45000,"\x07『 \x1FZ\x04eratul \x07』",1)
	CreateHeroPointArr(88,55000,"\x07『 \x1DA\x04rtanis \x07』",1)
	CreateHeroPointArr(80,88000,"\x07『 \x1DM\x04ojo \x07』",1)
	CreateHeroPointArr(25,50000,"\x07『 \x1DE\x04dmund \x1DD\x04uke \x07』",1)
	CreateHeroPointArr(29,120000,"\x07『 \x1FN\x04orad \x1FII \x07』",1)
	CreateHeroPointArr(81,90000,"\x07『 \x1FW\x04arbringer \x07』",1)
	CreateHeroPointArr(23,150000,"\x07『 \x1FE\x04dmund \x1FD\x04uke \x07』",1)
	CreateHeroPointArr(76,60000,"\x07『 \x1DT\x04assadar\x07/\x1DZ\x04eratul \x07』",1)
	CreateHeroPointArr(79,75000,"\x07『 \x1DT\x04assadar \x07』",1)
	CreateHeroPointArr(98,99000,"\x07『 \x1FC\x04orsair \x07』",1)
	CreateHeroPointArr(220,123456,"\x07『 \x1DP\x04oint \x1DBOX(中) \x07』",2)
	CreateHeroPointArr(150,322322,"\x07『 \x1DP\x04oint \x1DBOX(大) \x07』",2)
--	CreateHeroPointArr(221,4999999,"\x07『 \x1DP\x04oint \x1DBOX \x08EX \x07』",2)
end
