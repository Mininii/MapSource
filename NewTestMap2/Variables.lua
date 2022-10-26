function Include_Vars()
	--System
	LimitVerPtr = 0x58f608
	--MSQC_init(0x590004)
	MSQC_KeyArr = {}
	MSQC_KeySet("O",494)
	MSQC_KeySet("ESC",495)
	MSQC_KeySet("1",496)
	MSQC_KeySet("2",497)
	MSQC_KeySet("3",498)
	MSQC_KeySet("4",499)
	MSQC_KeySet("5",500)
	MSQC_ExportEdsTxt()
	Nextptrs = CreateVar(FP)
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
	_0D = string.rep("\x0D",200) 
	--Interface
	TestShop = CreateVarArr(7, FP)
	TBLFlag = CreateCcode()
	SettingUnit1 = CreateVarArr(7, FP)
	SettingUnit2 = CreateVarArr(7, FP)

	DpsLV1 = CreateVarArr(7, FP)
	DpsLV2 = CreateVarArr(7, FP)
	PEXP = CreateWarArr(7, FP)
	ELevel = CreateVar(FP)
	EExp = CreateVar(FP)
	ECP = CreateVar(FP)
	GEper = CreateVar(FP)
	GEper2 = CreateVar(FP)
	GEper3 = CreateVar(FP)
	UEper = CreateVar(FP)
	if TestStart == 1 then 
		ETestTxt1 = CreateCText(FP,"출력된 난수 : ")
		ETestTxt2 = CreateCText(FP,"계산된 확률 : ")
		ETestTxt3 = CreateCText(FP,"실패, 얻은 경험치 : ")
		ETestStrPtr1 = CreateVar(FP)
		ETestStrPtr2 = CreateVar(FP)
		ETestStrPtr3 = CreateVar(FP)
	end

	ShopSw = CreateCcodeArr(7)
	ShopKey = CreateCcodeArr(7)

	--String
	
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",11)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))
	




	--Balance


	EXPArr = {}
	for i = 1, 10000 do
		EXPArr[i] = 10+(10*(i-1)*(i*0.1))
	end
	EXPArr = f_GetFileArrptr(FP,EXPArr,4,1)

	LevelUnitArr = {} -- Level,UnitID,Per,Exp
	AutoEnchArr = {}
	AutoEnchArr2 = {}
	AutoBuyArr = {
		{1,"50"},
		{7,"1000"},
		{11,"20000"},
		{15,"700000"},
		{18,"9000000"},
		{20,"50000000"},
		{22,"400000000"},
		{24,"3500000000"},
		{26,"50000000000"},
		{28,"900000000000"},
		{30,"10000000000000"},
		{32,"300000000000000"},
	}
	PatchInit()

	
	--1,12,24,48,72 (매우빠름 ,빠름, 보통, 느림, 매우느림)
	PushLevelUnit(1,75000,0,0,0,24,1,60)--마린 10원
	PushLevelUnit(2,65000,0,1,2,72,10,59)--고스트
	PushLevelUnit(3,60000,0,2,4,72,20,59)--벌쳐 300원
	PushLevelUnit(4,60000,0,7,13,48,20,59)--에씨비 
	PushLevelUnit(5,50000,0,8,16,48,30,59)--레이스 4000원
	PushLevelUnit(6,40000,0,5,11,48,50,59,1)--탱크
	PushLevelUnit(7,43000,0,3,7,48,80,59,1)--골럇 
	PushLevelUnit(8,43000,0,32,25,72,60,59)--파벳 3타 2만원
	PushLevelUnit(9,43000,0,58,103,48,80,59)--발키리 2타
	PushLevelUnit(10,40000,0,12,19,48,250,59)--배틀



	PushLevelUnit(11,35000,0,65,64,72,250,59)--질럿 2타 6만원
	PushLevelUnit(12,35000,0,66,66,48,400,59)--드라군
	PushLevelUnit(13,35000,0,67,68,48,550,59)--하템
	PushLevelUnit(14,35000,0,61,111,72,1000,59)--닥템
	PushLevelUnit(15,35000,1,83,115,72,1300,59,nil,1)--리버
	PushLevelUnit(16,30000,2,70,73,48,1000,59)--스카웃
	PushLevelUnit(17,30000,5,60,100,48,1300,59)--커세어
	PushLevelUnit(18,30000,10,71,77,48,1800,59)--아비터


	
	PushLevelUnit(19,30000,15,37,35,12,600,59)--저글링
	PushLevelUnit(20,25000,25,38,38,24,2000,59)--히드라
	PushLevelUnit(21,25000,40,43,48,24,2700,59)--뮤탈
	PushLevelUnit(22,25000,75,44,46,48,7000,59)--가디언
	PushLevelUnit(23,25000,100,62,104,48,10000,59)--디바우러
	PushLevelUnit(24,25000,125,39,40,48,13000,59)--울트라
	PushLevelUnit(25,10000,250,46,50,12,5000,59)--디파



	PushLevelUnit(25+1,25000,500,20,1,24,10,59)--짐레
	PushLevelUnit(25+2,25000,1000,16,3,48,30,59)--사라
	PushLevelUnit(25+3,25000,1750,19,5,24,20,59)--짐레벌쳐
	PushLevelUnit(25+4,25000,2500,17,10,24,30,59,1,1)--알랜
	PushLevelUnit(25+5,25000,3380,23,12,48,100,59,1)--듀크
	PushLevelUnit(25+6,25000,5800,53,39,24,80,59)--헌터
	PushLevelUnit(25+7,20000,10000,52,51,24,150,59)--언클린
	PushLevelUnit(25+8,20000,13700,69,53,72,700,59)--셔틀
	PushLevelUnit(25+9,20000,30000,41,43,24,350,59)--드론
	PushLevelUnit(25+10,20000,49000,40,42,48,800,59)--곰



	PushLevelUnit(25+11,16000,70000,10,26,72,600,59)--파벳영웅 3타
	PushLevelUnit(25+12,16000,100000,75,85,24,1200,59)--제라툴
	PushLevelUnit(25+13,13000,128000,29,21,48,6000,59)--노라드
	PushLevelUnit(25+14,13000,170000,86,78,48,10000,59)--다니모스
	PushLevelUnit(25+15,5000,500000,54,36,1,5000,59,nil,1)--디버링원 공속최대
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

	SetUnitAbility(88,114,12,2,0,59,1) -- 기본유닛


	PopLevelUnit()


end