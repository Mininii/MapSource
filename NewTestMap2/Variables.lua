function Include_Vars()
	--System
	HumanPlayers={P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}
	LimitVerPtr = 0x58f608
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
	MSQC_KeySet("P",502)
	MSQC_KeySet("F9",14)
	MSQC_KeySet("F12",503)--테스트용
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
	_0D = string.rep("\x0D",200) 
	LimitX, LimitC,TestMode = CreateCcodes(3)
	--Interface
	TestShop = CreateVarArr(7, FP) -- 테스트용이었는데 잘작동해서 유닛 자판기에 사용중
	TBLFlag = CreateCcode() -- TBL 갱신 여부 판별용 데스값. 유닛 생성이 감지되면 동작안함
	SettingUnit1 = CreateVarArr(7, FP)-- 1~25강 유닛 자동강화 설정기
	SettingUnit2 = CreateVarArr(7, FP)-- 26~39강 유닛 자동강화 설정기

	DpsLV1 = CreateVarArr(7, FP) -- 첫번째 DPS건물
	DpsLV2 = CreateVarArr(7, FP) -- 두번째 DPS건물
	
	Names = CreateVArrArr(7, 7, FP) -- 각 플레이어 이름 저장용

	ELevel = CreateVar(FP)--현재 강화중인 레벨
	--EExp = CreateVar(FP)
	ECP = CreateVar(FP) -- 강화 제어용 변수. 현재 강화중인 플레이어를 저장함
	GEper = CreateVar(FP) -- 강화 제어용 변수. 해당플레이어의 +1강 확률을 저장함
	GEper2 = CreateVar(FP) -- 강화 제어용 변수. 해당플레이어의 +2강 확률을 저장함
	GEper3 = CreateVar(FP) -- 강화 제어용 변수. 해당플레이어의 +3강 확률을 저장함
	UEper = CreateVar(FP) -- 강화 제어용 변수. 강화할 유닛의 확률을 저장함

	if Limit == 1 then --테스트용 출력 트리거
		ETestTxt1 = CreateCText(FP,"\x10출력된 난수 : ")
		ETestTxt2 = CreateCText(FP,"\x0F계산된 +1 확률 : ")
		ETestTxt2_2 = CreateCText(FP,"\x1C계산된 +2 확률 : ")
		ETestTxt2_3 = CreateCText(FP,"\x1F계산된 +3 확률 : ")
		ETestTxt3 = CreateCText(FP,"실패, 얻은 경험치 : ")
		ETestTxt4 = CreateCText(FP,"\x0D\x04 ~ \x0D")
		ETestStrPtr1 = CreateVar(FP)
		ETestStrPtr2 = CreateVar(FP)
		ETestStrPtr3 = CreateVar(FP)
		ETestStrPtr4 = CreateVar(FP)
		ETestStrPtr5 = CreateVar(FP)
	end

	ShopSw = CreateCcodeArr(7) -- 
	ShopKey = CreateCcodeArr(7) -- 

	Etbl = CreateVar(FP) -- 방어력측 tblPtr저장용 변수. 세부 강화확률 표기용

	--String
	
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",11)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))
	iStr2 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",8)) 
	Str2, Str2a, Str2s = SaveiStrArr(FP,MakeiStrVoid(54))
	




	--Balance


	EXPArr = {}
	for i = 1, 10000 do
		EXPArr[i] = 10+(10*(i-1)*(i*0.1))
	end
	EXPArr = f_GetFileArrptr(FP,EXPArr,4,1)

	LevelUnitArr = {} -- 모든 강화 유닛 저장 테이블. 각 1~4 인덱스는 Level,UnitID,Percent,Exp
	AutoEnchArr = {} -- 자동강화 설정용 데스값 태아불
	AutoEnchArr2 = {} -- 자동강화 설정 가능 여부 판별용 데스값 태아불
	AutoBuyArr = { -- 자동구입 가격 설정용 테이블
		{1,"100"},
		{7,"1000"},
		{11,"60000"},
		{15,"1500000"},
		{18,"9000000"},
		{20,"60000000"},
		{22,"360000000"},
		{24,"1500000000"},
		{26,"10000000000"},
		{28,"90000000000"},
		{30,"1000000000000"},
		{32,"8000000000000"},
	}
	PatchInit() -- 유닛 패치 테이블 초기화

	--PushLevelUnit(레벨, 강화확률, 판매시_경험치량, 유닛ID, 무기ID, 공격속도, 데미지, 공격력증가 사용여부, 데가리_있는유닛or없는유닛, 무기투사체수)
	--공격속도 : 1,12,24,48,72 (매우빠름 ,빠름, 보통, 느림, 매우느림)
	PushLevelUnit(1,60000,0,0,0,24,1,60)--마린 10원
	PushLevelUnit(2,60000,0,1,2,72,10,59)--고스트
	PushLevelUnit(3,57500,0,2,4,72,20,59)--벌쳐 300원
	PushLevelUnit(4,54300,0,7,13,48,20,59)--에씨비 
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
	PushLevelUnit(22,25000,75,44,46,24,3500,59)--가디언
	PushLevelUnit(23,25000,100,62,104,24,5000,59)--디바우러
	PushLevelUnit(24,25000,125,39,40,24,6500,59)--울트라
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
	PushLevelUnit(25+12,12000,100000,75,85,24,1200,59)--제라툴
	PushLevelUnit(25+13,10000,128000,29,21,48,6000,59)--노라드
	PushLevelUnit(25+14,5000,170000,86,78,12,3000,59)--다니모스
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

	SetUnitAbility(88,114,12,2,1000,58,1,nil,60) -- 기본유닛
	BossArr = {}--{,""},--보스 건물 아이디, DPM 요구수치

	PopLevelUnit() -- 밸런스가 모두 설정된 강화유닛 데이터 처리용 함수


end