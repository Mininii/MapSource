function Var_init()
	-- 0x58f500 SelHP 0x58f504 MarHP 0x58f508 SelSh 0x58f0c 0x58f510
	TimePtr = VoidAlloc(1)
	LevelPtr = VoidAlloc(1)
	Str01 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04\x04님의 \x04Normal Marine\x04이 \x1F한계\x04를 극복하지 못하고 \x08사망\x04했습니다. \x06(\x07Score \x08-50\x06) \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str02 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04\x04님의 \x1FExceeD \x1BM\x04arine\x04이 \x1F한계\x04를 극복하지 못하고 \x08사망\x04했습니다. \x06(\x07Score \x08-500\x06) \x07』\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str12 = CreateCText(FP,"\x12\x07『 \x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str22 = CreateCText(FP,"\x04 미네랄을 소비하여 총 \x0d\x0d\x0d\x0d\x0d\x0d")
	Str23 = CreateCText(FP,"\x04 \x04회 업그레이드를 완료하였습니다. \x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	f_GunSendT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	Str13 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04이(가) \x1C수정 보호막\x04을 사용했습니다. \x07』\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
	Str24 = CreateCText(FP,"\x07』\x0d\x0d\x0d\x0d\x0d\x0d")
	Str18 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d")
	HTextStrReset = CreateCText(FP,string.rep("\x0D",200))
	HeroArr = {77,78,28,17,19,21,86,75,88,25,29,76,79,98}
	HeroVArr = CVArray(FP,#HeroArr)
	Str19 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d \x03†")
	Str10 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x13\x03† \x04\x0d\x0d\x0d\x0d\x0d\x0d")
	ExDeaths1 = DefineDeathTable(0x1000)
	BGMTypeV = CreateVar(6)
	Level = CreateVar(1)
	LevelT = CreateVar(1)
	MarNumberLimit = CreateVar(84*2)
	MaxHPBackUp = CVArray(FP,228)
	SpeedVar = CreateVar(4)
	CreateTableSet({
	"MarHP","MarHP2","AtkUpgradePtrArr","AtkUpgradeMaskRetArr","DefUpgradePtrArr","DefUpgradeMaskRetArr","AtkFactorV","DefFactorV","NormalUpgradeMaskRetArr","NormalUpgradePtrArr",
	"BanToken","DefUpCompCount","AtkUpCompCount","DefFactorMaskRetArr","DefFactorPtrArr","AtkFactorMaskRetArr","AtkFactorPtrArr","AtkFactorV2","DefFactorV2","CurrentHP","MarMaxHP",
	"BarrackPtr","EXCunitTemp","EXCunit_Reset","MarCreate","CV1","CV2","BarPos","ExScore","ExScoreP","MarCreate2","TextSwitch","Names","PScoreSTrPtr","ExScoreVA","ShTStrPtr",
	"MarShMaskRetArr","MarShPtrArr","CustomShapeTable","CustomShape"
	})
	CreateVariableSet({"RepHeroIndex","RepX","RepY","BackupCp","CPos","CPosX","CPosY","BacpupPtr","CurrentUID","SelPTR","SelEPD","MarTblPtr","SelHP",
	"SelHPEPD","MarHPEPD","SelSh","SelShEPD","SelPl","SelMaxHP","CunitP","SelOPEPD","CurCunitI","CurrentSpeed","Dx","Dy","Dt","Dv","Du","DtP","CurrentOP",
	"UpgradeCP","UpgradeFactor","TempUpgradePtr","TempUpgradeMaskRet","UpgradeMax","UpResearched","UpCost","UpCompleted","UPCompStrPtr","Nextptrs","CunitIndex","BarRally","G_Send","G_CA","G_TempV","GunID","Gun_X","Gun_Y","Gun_LV","G_TempW","BackupPosData","Gun_TempRand","Gun_TempSpawnSet1","Spawn_TempW",
	"TempT","count","ReserveBGM","Repeat_TempV","TempBarPos","ExchangeRate","SetPlayers","ExchangeP","RandW","HPosX","HPosY","KillScore","Gun_Type","f_GunNum","f_GunStrPtr","ReserveBGM2",
	"Gun_TempSpawnSet2","Gun_TempSpawnSet3","Actived_Gun","HTextStrPtr","UnitDataPtr","CUID","RandSpeed","ScoreVPtr","Time","Cunit2","f_GunSendStrPtr","MarTempSh","PCheckV","PCheckV2","B1_K","B1_K2","B1_H","SelUID",
	"WaveT",})
	
	CreateCCodeSet(ExDeaths1,{"GiveConsole","F12KeyToggle","IntroT","LimitX","LimitC","TestMode","DelayMedic","Print13","ShUsed",
	"GiveRate","FuncT","OPFuncT","PCheck","HealT","RandomHeroPlace","ReplaceDelayT","ScorePrint","GameOver","LeaderBoardT","Win","Continue2","Continue","PExitFlag"})
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
		table.insert(PScoreSTrPtr,CreateVar())
		table.insert(ExScoreP,CreateVar())
		table.insert(MarMaxHP,CreateVar(2000*256))
		table.insert(MarCreate,CreateCCode(ExDeaths1))
		table.insert(MarCreate2,CreateCCode(ExDeaths1))
		table.insert(ShTStrPtr,CreateVar())
		table.insert(ExScoreVA,CVArray(FP,13))
		table.insert(Names,CVArray(FP,7))
	end
	for i = 0, 9 do
		table.insert(EXCunitTemp,CreateVar())
		table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i,0),0,SetTo,0))
	end
	for i = 0, 4 do
		table.insert(TextSwitch,CreateCCode(ExDeaths1))
	end
	for i = 0, 7 do
	table.insert(CustomShape,CustomShapeAlloc())
	end
	UpCompTxt = CVArray(FP,5)
	UpCompRet = CVArray(FP,5)
	f_GunNumT = CVArray(FP,5)
end

function Init_Resources()
	HeroPointArr = {}
	CreateHeroPointArr(77,35000,"\x07『 \x1DF\x04enix \x1DZ \x07』",1)
	CreateHeroPointArr(78,35000,"\x07『 \x1DF\x04enix \x1DD \x07』",1)
	CreateHeroPointArr(28,45000,"\x07『 \x1DH\x04yperion \x07』",1)
	CreateHeroPointArr(17,35000,"\x07『 \x1DA\x04lan \x1DS\x04chezar\x07 』",1)
	CreateHeroPointArr(19,65000,"\x07『 \x1FJ\x04im \x1FR\x04aynor \x1FV \x07』",1)
	CreateHeroPointArr(21,30000,"\x07『 \x1DT\x04om \x1DK\x04azansky \x07』",1)
	CreateHeroPointArr(86,70000,"\x07『 \x1DD\x04animoth \x07』",1)
	CreateHeroPointArr(75,45000,"\x07『 \x1FZ\x04eratul \x07』",1)
	CreateHeroPointArr(88,55000,"\x07『 \x1DA\x04rtanis \x07』",1)
	CreateHeroPointArr(25,50000,"\x07『 \x1DE\x04dmund \x1DD\x04uke \x07』",1)
	CreateHeroPointArr(29,120000,"\x07『 \x1FN\x04orad \x1FII \x07』",1)
	CreateHeroPointArr(76,60000,"\x07『 \x1DT\x04assadar\x07/\x1DZ\x04eratul \x07』",1)
	CreateHeroPointArr(79,75000,"\x07『 \x1DT\x04assadar \x07』",1)
	CreateHeroPointArr(98,99000,"\x07『 \x1FC\x04orsair \x07』",1)
	CreateHeroPointArr(220,77777,"\x07『 \x1DP\x04oint \x1DBOX(中) \x07』",2)
	CreateHeroPointArr(150,111111,"\x07『 \x1DP\x04oint \x1DBOX(大) \x07』",2)
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다!\x07 』"
	G_SendErrT = "\x07『 \x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 제작자에게 알려주세요!\x07 』"
	f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 제작자에게 알려주세요!\x07 』"
	JYD = "Set Unit Order To: Junk Yard Dog" 
	_0D = string.rep("\x0D",200) 
	MarID = {0,1,16,20,32,99,100}  
	MarWep = {117,118,119,120,121,122,123} 
	GiveRate2 = {1000, 5000, 10000, 50000,100000,500000}  
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0"}
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4} 
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	AtkFactor = 10
	DefFactor = 25
	MarDamageFactor = 1 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	MarDamageAmount = 30 -- 투사체수 2로 지정해서 절반의 값으로 써야됨
	NMarDamageFactor = 1
	NMarDamageAmount = 20
	HumanPlayers = {0,1,2,3,4,5,6,128,129,130,131}
	MapPlayers = {0,1,2,3,4,5,6}
	ObPlayers = {128,129,130,131}
	MedicTrig = {34,9,2,3}
	GunLimit = 1500
	Ex1= {20,23,26,29,32,35,38}
	P = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인","\x156인","\x167인"}
	HTextStr = string.rep("\x0D",200)
	ResetSwitch = "Switch 250"
	WaveSwitch = "Switch 150"
	EXCC_Forward = 0x3000
	CC_Header = CreateVar({"X",EXCC_Forward,0x15C,1,2})
end