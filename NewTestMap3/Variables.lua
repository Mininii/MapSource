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


	--EPD
	DpsLV1 = CreateVarArr(8, FP) -- 첫번째 DPS건물



	CT_GPrevRandV = CreateVar(FP)
	CT_GNextRandV = CreateVar(FP)
	CT_GPrevRandW = CreateWar(FP)
	CT_GNextRandW = CreateWar(FP)
	
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
end