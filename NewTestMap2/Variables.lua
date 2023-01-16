function Include_Vars()
	if SpeedTestMode == 1 then
		function HumanCheck(Player,Status)
			if Status == 0 then return Never() else return Always() end
		end
	end
	--System
	HumanPlayers={P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}
	LimitVerPtr = 0x58f608
	ULimitArr = {500,350,300,250,200,180,150}
	ULimitV = CreateVar(FP)
	ULimitV2 = CreateVar(FP)
	--MSQC_init(0x590004)
	MSQC_KeyArr = {} 
	MSQC_KeySet("O",494) -- MSQC eds텍스트 입력
	MSQC_KeySet("ESC",495)
	MSQC_KeySet("1",496)
	MSQC_KeySet("2",497)
	MSQC_KeySet("3",498)
	MSQC_KeySet("4",499)
	MSQC_KeySet("5",500)
	MSQC_KeySet("6",501)
	--MSQC_KeySet("P",502)
	MSQC_KeySet("F9",13)
	MSQC_KeySet("F12",503)--테스트용
	--504 사용중
	MSQC_ExportEdsTxt() -- MSQC eds텍스트 출력
	Nextptrs = CreateVar(FP) -- 유닛 EPD 로드용
	P1VOFF = "Turn OFF Shared Vision for Player 1"
	P1VON = "Turn ON Shared Vision for Player 1"
	P2VOFF = "Turn OFF Shared Vision for Player 2"
	P2VON = "Turn ON Shared Vision for Player 2"
	P3VOFF = "Turn OFF Shared Vision for Player 3"
	P3VON = "Turn ON Shared Vision for Player 3"
	P4VOFF = "Turn OFF Shared Vision for Player 4"
	P4VON = "Turn ON Shared Vision for Player 4"
	P5VOFF = "Turn OFF Shared Vision for Player 5"
	P5VON = "Turn ON Shared Vision for Player 5"
	P6VOFF = "Turn OFF Shared Vision for Player 6"
	P6VON = "Turn ON Shared Vision for Player 6"
	P7VOFF = "Turn OFF Shared Vision for Player 7"
	P7VON = "Turn ON Shared Vision for Player 7"
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	ColorT = {"\x08","\x0E","\x0F","\x10","\x11","\x15","\x16"}
	_0D = string.rep("\x0D",200) 
	LimitX, LimitC,TestMode = CreateCcodes(3)
	--Interface
	TestShop = CreateVarArr(7, FP) -- 테스트용이었는데 잘작동해서 유닛 자판기에 사용중
	ShopPtr = CreateVarArr(7, FP) -- 테스트용이었는데 잘작동해서 유닛 자판기에 사용중
	
	TBLFlag = CreateCcode() -- TBL 갱신 여부 판별용 데스값. 유닛 생성이 감지되면 동작안함
	SettingUnit1 = CreateVarArr(7, FP)-- 1~25강 유닛 자동강화 설정기
	SettingUnit2 = CreateVarArr(7, FP)-- 26~39강 유닛 자동강화 설정기

	SettingUnit3 = CreateVarArr(7, FP)-- 15~25강 유닛 자동판매 설정기
	SettingUnit4 = CreateVarArr(7, FP)-- 26~39강 유닛 자동판매 설정기
	ShopUnit = CreateVarArr(7, FP) -- 시민설정기

	DpsLV1 = CreateVarArr(7, FP) -- 첫번째 DPS건물
	DpsLV2 = CreateVarArr(7, FP) -- 두번째 DPS건물
	PBossPtr = CreateVarArr(7, FP) -- 개인보스 DPS유닛 ptr
	Names = CreateVArrArr(7, 7, FP) -- 각 플레이어 이름 저장용

	ELevel = CreateVar(FP)--현재 강화중인 레벨
	--EExp = CreateVar(FP)
	ECP = CreateVar(FP) -- 강화 제어용 변수. 현재 강화중인 플레이어를 저장함
	GEper = CreateVar(FP) -- 강화 제어용 변수. 해당플레이어의 +1강 확률을 저장함
	GEper2 = CreateVar(FP) -- 강화 제어용 변수. 해당플레이어의 +2강 확률을 저장함
	GEper3 = CreateVar(FP) -- 강화 제어용 변수. 해당플레이어의 +3강 확률을 저장함
	UEper = CreateVar(FP) -- 강화 제어용 변수. 강화할 유닛의 확률을 저장함

	ShopSw = CreateCcodeArr(7) -- 
	ShopKey = CreateCcodeArr(7) -- 

	Etbl = CreateVar(FP) -- 방어력측 tblPtr저장용 변수. 세부 강화확률 표기용
	--CheatTest
	
	CurCunitI = CreateVar(FP)
	CT_GNextRandV = CreateVar(FP)
	CT_GPrevRandV = CreateVar(FP)
	CT_GNextRandW = CreateWar(FP)
	CT_GPrevRandW = CreateWar(FP)
	CT_NextRandV = CreateVarArr(7,FP)
	CT_PrevRandV = CreateVarArr(7,FP)
	CT_NextRandW = CreateWarArr(7,FP)
	CT_PrevRandW = CreateWarArr(7,FP)

	--String
	
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",3)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))


	-- Interface Variable

	MCTCondArr = {
		Memory(0x5124F0, Exactly, 13)
	}
	iv={} -- 전역 변수 테이블
	ct={} -- 전역 변수 테이블 치팅감지
	ctg={} -- 전역 변수 테이블 치팅감지

	--PlayData(NonSCA)
	iv.Money = CreateWarArr(7,FP) -- 자신의 현재 돈 보유량
	iv.IncomeMax = CreateVarArr2(7,12,FP) -- 자신의 사냥터 최대 유닛수
	iv.Income = CreateVarArr(7,FP) -- 자신의 현재 사냥터에 보유중인 유닛수
	iv.BuildMul1 = CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	iv.BuildMul2 = CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	iv.TotalEPer = CreateVarArr(7,FP)--총 강화확률(기본 1강)
	iv.TotalEPer2 = CreateVarArr(7,FP)--총 강화확률(+2강)
	iv.TotalEPer3 = CreateVarArr(7,FP)--총 강화확률(+3강)
	iv.ScoutDmg = CreateVarArr(7,FP) -- 기본유닛 데미지
	iv.ScTimer = CreateVarArr(7,FP)
	iv.PTimeV = CreateVarArr(7,FP)
	iv.General_Upgrade = CreateVarArr(7,FP)
	iv.ResetStat = CreateVarArr(7,FP)
	iv.NextOre = CreateVarArr2(7,50,FP) -- 다음 미네랄
	iv.NextGas = CreateVarArr2(7,100,FP) -- 다음 가스
	iv.NextOreMul = CreateVarArr2(7,2,FP) -- 다음 미네랄배수
	iv.NextGasMul = CreateVarArr2(7,2,FP) -- 다음 가스배수
	iv.SellTicket = CreateVarArr(7,FP)
	iv.PBossLV = CreateVarArr(7,FP)
	iv.PBossDPS = CreateWarArr(7,FP)
	iv.TotalPBossDPS = CreateWarArr(7,FP)
	iv.Stat_EXPIncome = CreateVarArr(7,FP)-- 경험치 획득량 수치. 사용 미정
	
	
	
	--General
	iv.Time = CreateVar(FP)
	iv.Time2 = CreateVar(FP)
	--Setting, Effect
	iv.StatEff = CreateCcodeArr(7) -- 레벨업 이펙트
	iv.StatEffT2 = CreateCcodeArr(7) -- 레벨업 이펙트
	iv.InterfaceNum = CreateVarArr(7,FP) -- 상점이나 스탯 찍는 창 제어부
	iv.AutoBuyCode = CreateVarArr(7,FP)-- 자동 구입 제어 데스값
	iv.MulOp = CreateVarArr2(7,1,FP) -- 유닛 공격력에 따른 수치 표기용 변수
	
	--PlayData(SCA)
	iv.PLevel = CreateVarArr2(7,1,FP)-- 자신의 현재 레벨
	iv.StatP = CreateVarArr2(7,5,FP)-- 현재 보유중인 스탯포인트
	iv.Stat_ScDmg = CreateVarArr(7,FP)-- 사냥터 업글 수치
	iv.Stat_AddSc = CreateVarArr(7,FP)-- 사냥터 업글 수치
	iv.Stat_TotalEPer = CreateVarArr(7,FP)-- +1강 확업 수치
	iv.Stat_TotalEPer2 = CreateVarArr(7,FP)-- +2강 확업 수치
	iv.Stat_TotalEPer3 = CreateVarArr(7,FP)-- +3강 확업 수치
	iv.Stat_Upgrade = CreateVarArr(7,FP)-- 유닛 공격력 증가량 수치
	iv.Credit = CreateWarArr(7,FP) -- 보유중인 크레딧
	iv.PEXP = CreateWarArr(7, FP) -- 자신이 지금까지 얻은 총 경험치
	iv.TotalExp = CreateWarArr2(7,"10",FP) -- 지금까지 레벨업에 사용한 경험치 + 현재 레벨업에 필요한 경험치
	iv.CurEXP = CreateWarArr(7,FP) -- 지금까지 레벨업에 사용한 경험치
	iv.PStatVer = CreateVarArr(7,FP) -- 현재 저장된 스탯버전
	iv.PlayTime2 = CreateVarArr(7,FP) -- 총 플레이타임(신 값)
	iv.PlayTime = CreateVarArr(7,FP) -- 총 플레이타임(구 값)
	iv.CreditAddSC = CreateVarArr(7,FP) 
	iv.LV5Cool = CreateVarArr(7,FP)
	iv.B_PCredit = CreateVarArr(7,FP)
	iv.B_PTicket = CreateVarArr(7,FP)

	iv.BanFlag = CreateVarArr(7,FP)
	iv.BanFlag2 = CreateVarArr(7,FP)
	iv.BanFlag3 = CreateVarArr(7,FP)
	iv.BanFlag4 = CreateVarArr(7,FP)


	--Local Data Variable
	iv.IncomeMaxLoc = CreateVar(FP)
	iv.IncomeLoc = CreateVar(FP)
	iv.LevelLoc = CreateVar(FP)
	iv.LevelLoc2 = CreateVar(FP)
	iv.TotalEPerLoc = CreateVar(FP)
	iv.TotalEPer2Loc = CreateVar(FP)
	iv.TotalEPer3Loc = CreateVar(FP)
	iv.S_TotalEPerLoc = CreateVar(FP)
	iv.S_TotalEPer2Loc = CreateVar(FP)
	iv.S_TotalEPer3Loc = CreateVar(FP)
	iv.PlayTimeLoc = CreateVar(FP)
	iv.PlayTimeLoc2 = CreateVar(FP)
	iv.StatPLoc = CreateVar(FP)
	iv.MoneyLoc = CreateWar(FP)
	iv.CredLoc = CreateWar(FP)
	iv.ExpLoc = CreateVar(FP)
	iv.TotalExpLoc = CreateVar(FP)
	iv.InterfaceNumLoc = CreateVar(FP)
	iv.UpgradeLoc = CreateVar(FP)
	iv.EXPIncomeLoc = CreateVar(FP)
	iv.EXPIncomeLoc2 = CreateVar(FP)
	iv.StatEffLoc = CreateCcode()
	iv.ScoutDmgLoc = CreateVar(FP)
	iv.AddScLoc = CreateVar(FP)
	iv.MulOpLoc = CreateVar(FP)
	iv.BrightLoc = CreateVar2(FP,nil,nil,31)
	iv.LCP = CreateVar(FP)
	iv.ResetStatLoc = CreateCcode()
	iv.UpgradeUILoc = CreateVar(FP)
	
	iv.NextOreLoc = CreateVar(FP)
	iv.NextGasLoc = CreateVar(FP)
	iv.NextOreMulLoc = CreateVar(FP)
	iv.NextGasMulLoc = CreateVar(FP)
	iv.SellTicketLoc = CreateVar(FP)
	
	
	--Temp
	iv.CTStatP2 = CreateVar(FP)

	iv.TempReadV = CreateVar(FP)
	iv.TempEXPV = CreateVar(FP)

	iv.CheatDetect = CreateCcode()
	iv.SaveRemind = CreateCcode()

	iv.PEXP2 = CreateVarArr(7, FP) -- 1/10로 나눠 경험치에 더할 값 저장용. 사용 미정


	iv.TempO = CreateVarArr(7,FP)
	iv.TempG = CreateVarArr(7,FP)
	ct.TempO = CreateVarArr(7,FP)
	ct.TempG = CreateVarArr(7,FP)





	iv.PCheckV = CreateVar(FP)--플레이어 수 체크
	iv.B_IncomeMax = CreateVar(FP)
	iv.B_TotalEPer = CreateVar(FP)
	iv.B_TotalEPer2 = CreateVar(FP)
	iv.B_TotalEPer3 = CreateVar(FP)
	iv.B_Stat_EXPIncome = CreateVar(FP)
	iv.B_Stat_Upgrade = CreateVar(FP)
	iv.B_Credit = CreateVar(FP)
	iv.B_Ticket = CreateVar(FP)
	iv.BossLV = CreateVar(FP)

	
	ct.Money = CreateWarArr(7,FP) -- 자신의 현재 돈 보유량
	ct.IncomeMax = CreateVarArr2(7,12,FP) -- 자신의 사냥터 최대 유닛수
	ct.Income = CreateVarArr(7,FP) -- 자신의 현재 사냥터에 보유중인 유닛수
	ct.BuildMul1 = CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	ct.BuildMul2 = CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	ct.TotalEPer = CreateVarArr(7,FP)--총 강화확률(기본 1강)
	ct.TotalEPer2 = CreateVarArr(7,FP)--총 강화확률(+2강)
	ct.TotalEPer3 = CreateVarArr(7,FP)--총 강화확률(+3강)
	ct.ScoutDmg = CreateVarArr(7,FP) -- 기본유닛 데미지
	ct.ScTimer = CreateVarArr(7,FP)
	ct.PTimeV = CreateVarArr(7,FP)
	ct.General_Upgrade = CreateVarArr(7,FP)
	ct.ResetStat = CreateVarArr(7,FP)
	ct.NextOre = CreateVarArr2(7,50,FP) -- 다음 미네랄
	ct.NextGas = CreateVarArr2(7,100,FP) -- 다음 가스
	ct.NextOreMul = CreateVarArr2(7,2,FP) -- 다음 미네랄배수
	ct.NextGasMul = CreateVarArr2(7,2,FP) -- 다음 가스배수
	ct.SellTicket = CreateVarArr(7,FP)
	ct.PBossLV = CreateVarArr(7,FP)
	ct.PBossDPS = CreateWarArr(7,FP)
	ct.TotalPBossDPS = CreateWarArr(7,FP)
	ct.Stat_EXPIncome = CreateVarArr(7,FP)-- 경험치 획득량 수치. 사용 미정
	ct.PLevel = CreateVarArr2(7,1,FP)-- 자신의 현재 레벨
	ct.StatP = CreateVarArr2(7,5,FP)-- 현재 보유중인 스탯포인트
	ct.Stat_ScDmg = CreateVarArr(7,FP)-- 사냥터 업글 수치
	ct.Stat_AddSc = CreateVarArr(7,FP)-- 사냥터 업글 수치
	ct.Stat_TotalEPer = CreateVarArr(7,FP)-- +1강 확업 수치
	ct.Stat_TotalEPer2 = CreateVarArr(7,FP)-- +2강 확업 수치
	ct.Stat_TotalEPer3 = CreateVarArr(7,FP)-- +3강 확업 수치
	ct.Stat_Upgrade = CreateVarArr(7,FP)-- 유닛 공격력 증가량 수치
	ct.Credit = CreateWarArr(7,FP) -- 보유중인 크레딧
	ct.PEXP = CreateWarArr(7, FP) -- 자신이 지금까지 얻은 총 경험치
	ct.TotalExp = CreateWarArr2(7,"10",FP) -- 지금까지 레벨업에 사용한 경험치 + 현재 레벨업에 필요한 경험치
	ct.CurEXP = CreateWarArr(7,FP) -- 지금까지 레벨업에 사용한 경험치
	ct.PStatVer = CreateVarArr(7,FP) -- 현재 저장된 스탯버전
	ct.PlayTime2 = CreateVarArr(7,FP) -- 총 플레이타임(신 값)
	ct.PlayTime = CreateVarArr(7,FP) -- 총 플레이타임(구 값)
	ct.CreditAddSC = CreateVarArr(7,FP) 
	ct.LV5Cool = CreateVarArr(7,FP)
	ct.B_PCredit = CreateVarArr(7,FP)
	ct.B_PTicket = CreateVarArr(7,FP)

	ct.BanFlag = CreateVarArr(7,FP)
	ct.BanFlag2 = CreateVarArr(7,FP)
	ct.BanFlag3 = CreateVarArr(7,FP)
	ct.BanFlag4 = CreateVarArr(7,FP)

	

	ctg.PCheckV = CreateVar(FP)--플레이어 수 체크
	ctg.B_IncomeMax = CreateVar(FP)
	ctg.B_TotalEPer = CreateVar(FP)
	ctg.B_TotalEPer2 = CreateVar(FP)
	ctg.B_TotalEPer3 = CreateVar(FP)
	ctg.B_Stat_EXPIncome = CreateVar(FP)
	ctg.B_Stat_Upgrade = CreateVar(FP)
	ctg.B_Credit = CreateVar(FP)
	ctg.B_Ticket = CreateVar(FP)
	ctg.BossLV = CreateVar(FP)
	iv.GeneralPlayTime = CreateVar(FP)
	iv.CUnitT = CreateVar(FP)
	ctg.CUnitT = CreateVar(FP)


	iv.CT_PLevel = CreateVarArr2(7,1,FP)
	--Balance

	--PUpgrade = CreateVarArr(7,FP)
	UnitWep = CreateVarArr(7,FP)
	DmgFactor = CreateVarArr(7,FP)
	Dmg = CreateVarArr(7,FP)

	EXPArr = {}
	for i = 1, 10000 do
		EXPArr[i] = 10+(10*(i-1)*(i*0.3))
	end
	EXPArr = f_GetFileArrptr(FP,EXPArr,4,1)

	LevelUnitArr = {} -- 모든 강화 유닛 저장 테이블. 각 1~4 인덱스는 Level,UnitID,Percent,Exp
	AutoEnchArr = {} -- 자동강화 설정용 데스값 태아불
	AutoEnchArr2 = {} -- 자동강화 설정 가능 여부 판별용 데스값 태아불
	AutoSellArr = {} -- 자동강화 설정용 데스값 태아불
	AutoBuyArr = { -- 자동구입 가격 설정용 테이블
		{1,"1500"},
		{7,"40000"},
		{11,"700000"},
		{15,"8000000"},
		{18,"100000000"},
		{20,"600000000"},
		{22,"3500000000"},
		{24,"20000000000"},
		{26,"100000000000"},
		{28,"600000000000"},
		{30,"3500000000000"},
		{32,"20000000000000"},
		{34,"120000000000000"},
		{36,"8000000000000000"},
	}
	PatchInit() -- 유닛 패치 테이블 초기화

	--PushLevelUnit(레벨, 강화확률, 판매시_경험치량, 유닛ID, 무기ID, 공격속도, 데미지, 공격력증가 사용여부, 데가리_있는유닛or없는유닛, 무기투사체수)
	--공격속도 : 1,12,24,48,72 (매우빠름 ,빠름, 보통, 느림, 매우느림)
	PushLevelUnit(1,60000,0,0,0,24,1,60)--마린 10원
	PushLevelUnit(2,60000,0,1,2,72,10,59)--고스트
	PushLevelUnit(3,57500,0,2,4,72,20,59)--벌쳐 300원
	PushLevelUnit(4,54300,0,7,13,48,20,59)--에씨비 
	PushLevelUnit(5,50000,0,8,16,48,30,59)--레이스 4000원
	PushLevelUnit(6,50000,0,5,11,48,50,59,1)--탱크
	PushLevelUnit(7,50000,0,3,7,48,80,59,1)--골럇 
	PushLevelUnit(8,50000,0,32,25,72,60,59)--파벳 3타 2만원
	PushLevelUnit(9,47000,0,58,103,48,80,59)--발키리 2타
	PushLevelUnit(10,46500,0,12,19,48,250,59)--배틀



	PushLevelUnit(11,46300,0,65,64,72,250,59)--질럿 2타 6만원
	PushLevelUnit(12,45200,0,66,66,48,400,59)--드라군
	PushLevelUnit(13,45000,0,67,68,48,550,59)--하템
	PushLevelUnit(14,45000,0,61,111,72,1000,59)--닥템
	PushLevelUnit(15,44000,1,83,115,72,1300,59,nil,1)--리버
	PushLevelUnit(16,44000,2,70,73,48,1000,59)--스카웃
	PushLevelUnit(17,44000,5,60,100,48,1300,59)--커세어
	PushLevelUnit(18,43000,10,71,77,48,1800,59)--아비터


	
	PushLevelUnit(19,42000,15,37,35,12,600,59)--저글링
	PushLevelUnit(20,38000,27,38,38,24,2000,59)--히드라
	PushLevelUnit(21,38000,45,43,48,24,2700,59)--뮤탈
	PushLevelUnit(22,36000,80,44,46,24,3500,59)--가디언
	PushLevelUnit(23,36000,160,62,104,24,5000,59)--디바우러
	PushLevelUnit(24,35000,335,39,40,24,6500,59)--울트라
	PushLevelUnit(25,30000,750,46,50,12,5000,59)--디파



	PushLevelUnit(25+1,25000,15000/2,20,1,24,10,59)--짐레
	PushLevelUnit(25+2,25000,21000/2,16,3,48,30,59)--사라
	PushLevelUnit(25+3,25000,37500/2,19,5,24,20,59)--짐레벌쳐
	PushLevelUnit(25+4,25000,60000/2,17,10,24,30,59,1,1)--알랜
	PushLevelUnit(25+5,25000,102000/2,23,12,48,100,59,1)--듀크
	PushLevelUnit(25+6,25000,188000/2,53,39,24,80,59)--헌터
	PushLevelUnit(25+7,20000,300000/2,52,51,24,150,59)--언클린
	PushLevelUnit(25+8,20000,500000/2,69,53,72,700,59)--셔틀
	PushLevelUnit(25+9,20000,1000000/2,41,43,24,350,59)--드론
	PushLevelUnit(25+10,20000,1600000/2,40,42,48,1200,59)--곰



	PushLevelUnit(25+11,16000,4000000/2,10,26,72,1000,59)--파벳영웅 3타
	PushLevelUnit(25+12,12000,8000000/2,75,85,24,2000,59)--제라툴
	PushLevelUnit(25+13,10000,12000000/2,29,21,24,4000,59)--노라드
	PushLevelUnit(25+14,5000,20000000/2,86,78,12,3500,59)--다니모스
	PushLevelUnit(25+15,1000,50000000/2,54,36,5,4000,59,nil,1)--디버링원 공속최대
	SetWeaponsDatX(25,{WepName=1441})--파벳3연타 예외처리
	SetWeaponsDatX(103,{WepName=1439})--발키리2연타 예외처리
	SetWeaponsDatX(64,{WepName=1440})--질럿2연타 예외처리
	SetWeaponsDatX(26,{WepName=1441})--파벳3연타 예외처리


	--이하 밸런스 미정
	--PushLevelUnit(25+16,4000,70,73,48,1000,100,59)--스카웃
	--PushLevelUnit(25+17,4000,60,100,48,1300,130,59)--커세어
	--PushLevelUnit(25+18,3000,71,77,48,1800,180,59)--아비터
	--PushLevelUnit(25+19,3000,37,35,12,600,60,59)--저글링
	--PushLevelUnit(25+20,2000,38,38,24,2000,200,59)--히드라
	--PushLevelUnit(25+21,2000,43,48,24,2700,270,59)--뮤탈
	--PushLevelUnit(25+22,1000,44,46,48,7000,700,59)--가디언
	--PushLevelUnit(25+23,1000,62,104,24*4,20000,2000,59)--디바우러
	--PushLevelUnit(25+24,500,39,40,48,13000,1300,59)--울트라
	--PushLevelUnit(25+25,500,46,50,48,18000,1800,59)--디파

	SetUnitAbility(88,114,5,35,100,58,1,nil,60,0) -- 기본유닛
	PBossArr = {
		{84,"1300"},
		{36,"4800"},
		{59,"12000"},
		{45,"40000"},
		{49,"130000"},
	}--{,""},--보스 건물 아이디, DPS 요구수치
if TestStart == 1 then
	BossArr = {
		{87,"10000"},
		{25,"150000"},
		{80,"1100000"},
		{57,"9300000"},
		{72,"20000000"},
		{72,"20000000"},
		{72,"20000000"},
		{72,"20000000"},
		{72,"20000000"},
	}--{,""},--보스 건물 아이디, DPM 요구수치
else
	BossArr = {
		{87,"10000"},
		{25,"150000"},
		{80,"1100000"},
		{57,"9300000"},
		{72,"34000000"},
		{72,"34000000"},
		{72,"34000000"},
		{72,"34000000"},
		{72,"34000000"},
	}--{,""},--보스 건물 아이디, DPM 요구수치
end
	FirstReward = {
		{20,500},
		{22,7000},
		{24,20000},
		{26,80000},
	}
	OreDPS = {100,1000,10000,100000,500000,1000000,0}
	OreDPSM = {2,4,8,16,32,64}
	GasDPS = {100,1000,10000,100000,1000000,5000000,0}
	GasDPSM = {2,4,8,16,32,64}
	PopLevelUnit() -- 밸런스가 모두 설정된 강화유닛 데이터 처리용 함수
	Cost_Stat_ScDmg = 15
	Cost_Stat_AddSc = 50
	Cost_Stat_Upgrade = 20
	Cost_Stat_TotalEPer = 10
	Cost_Stat_TotalEPer2 = 200
	Cost_Stat_TotalEPer3 = 1000
	

	
end