function Var_init()
	-- 0x58f500 SelHP 0x58f504 MarHP 0x58f508 SelSh 0x58f0c 0x58f510
	TimePtr = 0x590000
	LevelPtr = 0x590004
	Str01 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04\x04님의 \x04Normal Marine\x04이 \x1F한계\x04를 극복하지 못하고 \x08사망\x04했습니다. \x06(\x07Score \x08-50\x06) \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str02 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04\x04님의 \x1FExceeD \x1BM\x04arine\x04이 \x1F한계\x04를 극복하지 못하고 \x08사망\x04했습니다. \x06(\x07Score \x08-500\x06) \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str12 = CreateCText(FP,"\x12\x07『 \x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str22 = CreateCText(FP,"\x04 미네랄을 소비하여 총 \x0d\x0d\x0d\x0d\x0d\x0d")
	Str23 = CreateCText(FP,"\x04 \x04회 업그레이드를 완료하였습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	f_GunErrT = CreateCText(FP,"\x07『 \x08ERROR \x04: G_CAPlot Not Found. f_Gun 실행자 : ")
	f_GunFuncT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: G_CAPlot Suspended. f_Gun 실행자 : ")
	f_GunSendT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	Str13 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04이(가) \x1C수정 보호막\x04을 사용했습니다. \x07』\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
	Str24 = CreateCText(FP,"\x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	Str18 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d")
	DBossT1 = CreateCText(FP,"\x13\x10【 \x07P\x04layer \x06T\x04otal \x1FS\x04core : \x0d\x0d\x0d\x0d\x0d\x0d")
	DBossT2 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d / \x0d\x0d\x0d\x0d\x0d\x0d")
	DBossT3 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d \x10】\x0d\x0d\x0d\x0d\x0d\x0d")

	DBossTotalDMGT = CreateCText(FP,"\x13\x1FＴ\x04ｏｔａｌ \x08Ｄ\x04ａｍａｇｅ : ")
	HTextStrReset = CreateCText(FP,HTextStr)
	HeroVArr = CreateVarray(FP,#HeroArr)
	ZergGndVArr = CreateVarray(FP,#ZergGndUArr)
	
	Str19 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d \x03†")
	Str10 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x13\x03† \x04\x0d\x0d\x0d\x0d\x0d\x0d")
	if TestStart == 1 then
		BGMTypeV = CreateVar(FP)
		LevelT2 = CreateVar2(1,FP,nil,nil)
	else
		BGMTypeV = CreateVar2(1,FP,nil,nil)
		LevelT2 = CreateVar2(1,FP,nil,nil)
	end
	Level = CreateVar2(1,FP,nil,nil)
	LevelT = CreateVar2(1,FP,nil,nil)


	BackupCp = CreateVar(FP)
	MarNumberLimit = CreateVar2(84*2,FP)
	MaxHPBackUp = CreateVarray(FP,228)
	SelHPEPD,MarHPEPD,SelShEPD = CreateVariables(3)
	
	RepHeroIndex,CPos,CPosX,CPosY = CreateVariables(4)
	
	CunitP,SelOPEPD,CurCunitI,CurrentSpeed,CurrentOP = CreateVariables(5)
	UpgradeCP,UpgradeFactor,TempUpgradePtr,TempUpgradeMaskRet,UpgradeMax,UpResearched,UpCost,UpCompleted,UPCompStrPtr = CreateVariables(9)
	B1_K,B1_K2,B1_H = CreateVariables(3)
	RandW = CreateVar(FP)
	Nextptrs = CreateVar(FP)
	count,count1,count2,count3 = CreateVariables(4)
	CunitIndex = CreateVar(FP)
	Gun_LV = CreateVar(FP)
	G_TempW = CreateVar(FP)
	Gun_TempRand = CreateVar(FP)
	Gun_TempSpawnSet1 = CreateVar(FP)
	Spawn_TempW = CreateVar(FP)
	Gun_Type = CreateVar(FP)
	f_GunNum = CreateVar(FP)
	f_GunStrPtr = CreateVar(FP)
	count = CreateVar(FP)
	ReserveBGM = CreateVar(FP)
	Repeat_TempV = CreateVar(FP)
	TempBarPos = CreateVar(FP)
	ExchangeRate = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	HTextStrPtr = CreateVar(FP)
	UnitDataPtr = CreateVar(FP)
	Time = CreateVar(FP)
	f_GunSendStrPtr = CreateVar(FP)
	Dt = CreateVar(FP)
	G_CA_StrPtr = CreateVar(FP)
	G_CA_StrPtr2 = CreateVar(FP)
	B_5_C = CreateVar(FP)
	B_Id_C = CreateVar(FP)
	PCheck = CreateCCode()
	PCheckV = CreateVar(FP)
	TestMode = CreateCCode()
	FuncT = Create_CCTable(7)
	OPFuncT, IntroT, ReplaceDelayT = CreateCCodes(4)
	RandomHeroPlace = CreateCCodes(1)
	Continue, Continue2 = CreateCCodes(2)
	PExitFlag, ScorePrint, countdownSound = CreateCCodes(3)
	BarrackPtr = Create_VTable(7)
	BarPos = Create_VTable(7)
	ExScore = Create_VTable(7)
	PScoreSTrPtr = Create_VTable(7)
	EXCunitTemp = Create_VTable(10)
	Names = Create_VArrTable(7,7)
	BanToken = Create_CCTable(7)
	CC_Header = CreateVar2({"X",EXCC_Forward,0x15C,1,2},FP)
	rokaClear = CreateCCode()
	IdenClear = CreateCCode()
    BossStart = CreateCCode()
	DLClear = CreateCCode()
    StoryT = CreateCCode()
	DemClear = CreateCCode()
	StoryT4 = CreateCCode()
	Dt_NT = CreateVar(FP)
	Dt_NT2 = CreateVar(FP)
	CurArr = CreateVar(FP)
	BiteCalc,InputPoint,OutputPoint,UnitPoint = CreateVariables(4)
	XY_ArrHeader = CreateVar(FP)
	RepeatType = CreateVar(FP)
	CX = CreateVar(FP)
	CY = CreateVar(FP)
	SoundLimitT = CreateCCode()
	SoundLimit = CreateCCode()
	WaitT = CreateCCode()
	Destr0yerClear = CreateCCode()
	Destr0yerClear2 = CreateCCode()
	isDBossClear = CreateCCode()
	DBoss_PrintScore = CreateVar(FP)
	DBoss_PrintScore2 = CreateVar(FP)
	TotalScore = CreateVar(FP)
	DHP = CreateVar(FP)
	DPtr = CreateVar(FP)
	DcurHP = CreateVar(FP)
end

function HPoints()
	HeroPointArr = {}
	HeroArr = {77,78,28,17,19,21,86,75,88,25,29,76,79,98,80,27,23,81}
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
	CreateHeroPointArr(220,77777,"\x07『 \x1DP\x04oint \x1DBOX(中) \x07』",2)
	CreateHeroPointArr(150,111111,"\x07『 \x1DP\x04oint \x1DBOX(大) \x07』",2)
end

function Objects()

	-- Balance
	MarDamageFactor = 1 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	MarDamageAmount = 30 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	NMarDamageFactor = 1 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	NMarDamageAmount = 20 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	AtkFactor = 7
	DefFactor = 2
	GunLimit = 1500
	Ex1= {20,23,26,29,32,35,38}

	--System
	MarID = {0,1,16,20,32,99,100}  
	MarWep = {117,118,119,120,121,122,123} 
	GiveRate2 = {1000, 5000, 10000, 50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4} 
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,5,6,128,129,130,131}
	MapPlayers = {0,1,2,3,4,5,6}
	ObPlayers = {128,129,130,131}
	MedicTrig = {34,9,2,3}
	EXCC_Forward = 0x2FFF
	ObEff = 94

	-- Strings

	_0D = string.rep("\x0D",200) 
	HTextStr = _0D
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0"}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 
	P = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인","\x156인","\x167인"}
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
	nilunit = 181
	-- 441 = OPConsole 
	-- 442 = CPConsole 
	-- 443 = BanConsole
	OPConsole = 441
	CPConsole = 442
	BanConsole = 443    
	VResetSw = CreateVar2(1,FP,nil,nil)
	VResetSw2 = CreateVar2(1,FP,nil,nil)
	VResetSw3 = CreateVar2(1,FP,nil,nil)
	VResetSw4 = CreateVar2(1,FP,nil,nil)
	VResetSw5 = CreateVar2(1,FP,nil,nil)
    

	
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
	Install_ShapeData()
end