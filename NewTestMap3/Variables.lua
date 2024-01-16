function Include_Vars()

	Nextptrs = CreateVar(FP) -- 유닛 EPD 로드용
	CurCunitI = CreateVar(FP)-- 유닛 index 체크용
	NBagArr = NBag(FP, 1, 1700) -- CUnit NBag
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
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16,0x17}
	ColorT = {"\x08","\x0E","\x0F","\x10","\x11","\x15","\x16,\x17"}
	HumanPlayers={P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}
	_0D = string.rep("\x0D",200) 
	LimitX, LimitC,TestMode = CreateCcodes(3)
	LimitM = CreateCcodeArr(8)
	LimitSaveEnable = CreateCcode()

	--System
	GCP = CreateVar(FP)
	GCPW = CreateWar(FP)
	VArrI = CreateVar(FP)
	VArrI4 = CreateVar(FP)
	WArrI = CreateWar(FP)
	WArrI4 = CreateWar(FP)


	--EPD
	DpsLV1 = CreateVarArr(8, FP) -- 첫번째 DPS건물



	CT_GPrevRandV = CreateVar(FP)
	CT_GNextRandV = CreateVar(FP)
	CT_GPrevRandW = CreateWar(FP)
	CT_GNextRandW = CreateWar(FP)
	MCTCondArr2 = {0x5124F0}
	MCTCondArr3 = {"-"}
	if Limit==1 then
	MCTCondArr = {
		Memory(0x5124F0, Exactly, TestSpeedNum)
	}
	else
	MCTCondArr = {
		Memory(0x5124F0, Exactly, 0x1D)
	}
	end
	
	ctarr = {{},{},{},{},{},{},{},{}}


	
	PatchInit() -- 유닛 패치 테이블 초기화

	PUT={}
	PWT={}
	LevelUnitArr = {}

	PushLevelUnit(1,{45000,55000,0,0},0,0,0,24,1,60,nil,50)--마린 10원
	PushLevelUnit(2,{40000,45000,15000,0},0,1,2,72,10,59,nil,120)--고스트
	PushLevelUnit(3,{38000,40000,22000,0},0,2,4,72,20,59,nil,300)--벌쳐 300원
	PushLevelUnit(4,{35000,35000,30000,0},0,7,13,48,20,59,nil,550)--에씨비 
	PushLevelUnit(5,{30000,35000,30000,5000},1,8,16,48,30,59,nil,1000)--레이스 4000원
	PushLevelUnit(6,{30000,34000,30000,6000},3,5,11,48,50,59,nil,2500)--탱크
	PushLevelUnit(7,{28000,35000,30000,7000},7,3,7,48,80,59,nil,6000)--골럇 
	PushLevelUnit(8,{26000,36000,30000,8000},11,32,25,72,60,59,nil,15000)--파벳 3타 2만원
	PushLevelUnit(9,{24000,37000,30000,9000},15,58,103,48,80,59,nil,50000)--발키리 2타
	PushLevelUnit(10,{20000,40000,30000,10000},25,12,19,48,250,59,nil,100000)--배틀
	PopLevelUnit()
end