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
	SCA_DataPtr = 0x58f600
	LimitVerPtr = 0x58f454
	SCA_DataPtrV = CreateVar(FP)

	SCADataNumChk = {}
	SCA = {}
	iv = {}
	ct = {}
		

	function SCA.CreateVar(PlayerID,DataNum)
		CreateVarXAlloc = CreateVarXAlloc + 1
		if CreateVarXAlloc > CreateMaxVAlloc then
			CreateVariable_IndexAllocation_Overflow()
		end
		if PlayerID == nil then
			PlayerID = AllPlayers
		end
		table.insert(CreateVarPArr,{"V",PlayerID})
		local Ret = V(CreateVarXAlloc)
		if type(PlayerID) == "number" then
			Ret[1] = PlayerID
		end
		table.insert(SCA.DataPtrArr, Ret)
		return Ret
	end

	function SCA.Available(CP)
		return DeathsX(CP, Exactly, 3, 1,3)
	end
	function SCA.NoSlotLoadAvailable(CP)--슬롯 로드완료 상태가 아닐때만
		return DeathsX(CP, Exactly, 3, 1,3+64)
	end
	function SCA.SlotLoadCmp(CP)--사용가능 + 슬롯로드완료
		return DeathsX(CP, Exactly, 3+64, 1,3+64)
	end
	function SCA.NotAvailable(CP)
		return DeathsX(CP, Exactly, 0, 1,2)
	end
	function SCA.Reset(CP)
		return SetDeaths(CP, SetTo, 0, 1)
	end
	function SCA.LoadCmp(CP)--사용가능 + 로드완료
		return DeathsX(CP, Exactly, 7, 1,7)
	end
	function SCA.SaveCmp(CP)--사용가능 + 저장완료
		return DeathsX(CP, Exactly, 11, 1,11)
	end
	function SCA.TimeLoadCmp(CP)--사용가능 + 시간로드완료
		return DeathsX(CP, Exactly, 19, 1,19)
	end

	VoidAreaOffset = 0x58f60C
	VoidAreaAlloc = 0x58f60C-4
	VoidAreaLimit = 0x5967F0

	SCA.GlobalCheck2 = CreateCcode()
	SCA.GlobalCheck = CreateCcode()
	SCA.GlobalLoadFlag = CreateCcode()
	SCA.CheckTime = CreateCcode()
	SCA.GLoadCmp = CreateCcode()
	SCA.GReload = CreateCcode()
	SCA.LoadSlot1 = CreateCcodeArr(8)

	SCA.LoadCheckArr = CreateCcodeArr(8)
	SCA.GlobalData = CreateVoidArr(20)
	SCA.GlobalVarArr = CreateVarArr(20, FP)
	ct.GlobalVarArr = CreateVarArr(20, FP)
	SCA.Year = CreateVoid()
	SCA.Month = CreateVoid()
	SCA.Hour = CreateVoid()
	SCA.Day = CreateVoid()
	SCA.Week = CreateVoid()
	SCA.Min = CreateVoid()
	SCA.ArrPtr = CreateVoid()

	SCA.YearV = CreateVar(FP)
	SCA.MonthV = CreateVar(FP)
	SCA.HourV = CreateVar(FP)
	SCA.DayV = CreateVar(FP)
	SCA.WeekV = CreateVar(FP)
	SCA.MinV = CreateVar(FP)
	
	--System
	GCP = CreateVar(FP)
	LCP = CreateVar(FP)
	GCPW = CreateWar(FP)
	VArrI = CreateVar(FP)
	VArrI4 = CreateVar(FP)
	WArrI = CreateWar(FP)
	WArrI4 = CreateWar(FP)
	iv.CheatDetect = CreateCcode()
	iv.StatTest = CreateCcode()
	Etbl = CreateVar(FP)
	SettingUnit1 = CreateVarArr(8, FP)-- 1~25강 유닛 자동강화 설정기
	TBLFlag = CreateCcode()
	
	--General
	iv.Time = CreateVar(FP)
	iv.Time2 = CreateVar(FP)
	iv.Time3 = CreateVar(FP)
	iv.Time4 = CreateVar(FP)
	iv.PCheckV = CreateVar(FP)--플레이어 수 체크

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
	--{Level,UnitID,Per,Exp,ECost}
	PushLevelUnit(1,45000,0,0,0,24,1,60,nil,50)--마린
	PushLevelUnit(2,40000,0,1,2,72,10,59,nil,200)--고스트
	PushLevelUnit(3,35000,0,2,4,72,30,59,nil,500)--벌쳐
	PushLevelUnit(4,35000,0,7,13,48,40,59,nil,550)--에씨비 
	PushLevelUnit(5,30000,1,8,16,48,100,59,nil,1000)--레이스
	PushLevelUnit(6,30000,3,5,11,48,250,59,nil,6000)--탱크
	PushLevelUnit(7,28000,7,3,7,48,1000,59,nil,35000)--골럇 
	PushLevelUnit(8,26000,11,32,25,72,1500,59,nil,150000)--파벳 3타 2만원
	PushLevelUnit(9,24000,15,58,103,48,5000,59,nil,600000)--발키리 2타
	PushLevelUnit(10,20000,25,12,19,48,12000,59,nil,2500000)--배틀
	PushLevelUnit(11,18000,40,39,40,24,15000,59,nil,11000000)--울트라
	PushLevelUnit(12,16000,75,38,38,24,32000,59,nil,38000000)--히드라
	PushLevelUnit(13,14000,120,43,48,12,30000,59,nil,94000000)--뮤탈
	PushLevelUnit(14,12000,200,44,46,12,50000,59,nil,500000000)--가디언
	PushLevelUnit(15,10000,320,37,35,5,60000,59,nil,0)--저글링

	




	



	


	PopLevelUnit()

	
	LevelLimit = 300000

	EXPArr = f_GetFileptr(FP, "expdata", 1)
	EXPArr_dp = f_GetFileptr(FP, "expdata_dp", 1)


end