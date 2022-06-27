function Var_init()
	
	RandSwitch = "Switch 100"
	RandSwitch2 = "Switch 101"
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
	JYD = "Set Unit Order To: Junk Yard Dog"
	Nextptrs = CreateVar(FP)
	Dt = CreateVar(FP)
	HumanPlayers={P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}
	MapPlayers={P1,P2,P3,P4,P5,P6,P7}
	CA_Eff_Rat = CreateVar2(FP,nil,nil,80000)
	CA_Eff_XY = CreateVar(FP)
	CA_Eff_YZ = CreateVar(FP)
	CA_Eff_ZX = CreateVar(FP)
	SHLX = CreateVar2(FP,nil,nil,2048)
	SHLY = CreateVar2(FP,nil,nil,2048)
	CA_Create = CreateVar(FP)
	BCFlag=CreateCcode()
	ZcountT = CreateVarArr(5, FP)
	Zcount = CreateVar(FP)
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",4)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))
	KillW =CreateWar(FP)
	
	EXPArr = CreateArr(2500,FP)
	for i = 1, 2500 do
		table.insert(CtrigInitArr[8],SetMemX(Arr(EXPArr,i-1),SetTo,(i*3)*(6*i)))
	end

	
	Level=CreateVarArr(7, FP)
	Pts=CreateVarArr(7, FP)
	CurExpTmp = CreateVarArr(7, FP)
	CurEXP = CreateVarArr(7, FP)
	MaxEXP = CreateVarArr(7, FP)
	ArrI = CreateVar(FP)
	Minpsec = CreateVarArr(7, FP)
	Gaspsec = CreateVarArr(7, FP)


end