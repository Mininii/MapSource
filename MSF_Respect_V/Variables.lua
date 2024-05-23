function Include_Vars()
	--System
	GiveRate2 = {1000,5000,10000,50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1} 
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4}
	ObPlayers = {P9,P10,P11,P12}
	MedicTrig = {34,9,88,80,21}
	MedicTick = {1,2,3,4,5}
	ObEff = 84
	nilunit = 181

	--Arr
	UnitIDArr = CreateFArr(1700, FP)
	UnitPosArr = CreateFArr(1700, FP)
	PlayerIDArr = CreateFArr(1700, FP)
	--Vars
	SELimit = CreateCcode()
    ExRate = CreateVar2(FP, nil, nil, 20)
	Nextptrs = CreateVar(FP)
	BGMType = CreateVar(FP)
	TestMode = CreateCcode()
	BossStart = CreateCcode()
	Names = CreateVArrArr(7,7,FP)
	CurCunitI2 = CreateVar(FP)
	SetPlayers = CreateVar(FP)
	BarPos = CreateVarArr(7,FP)
	BarRally = CreateVarArr(7,FP)
	CunitIndex = CreateVar(FP)
	RepHeroIndex = CreateVar(FP)
	PlayerV=CreateVar(FP)
	UnitRepIndex = CreateVar(FP)
	GMode = CreateCcode()
	PPosX = CreateVarArr(7, FP)
	PPosY = CreateVarArr(7, FP)
	MBPtr = CreateVarArr(5, FP)
	VTimerB = CreateVarArr(6,FP)
	VFlagB = CreateVarArr(6,FP)
	VFlag256B = CreateVarArr(6,FP)
	EVFCcode = CreateCcode()
	CTMin = CreateVarArr(7, FP)
	--strings
	
	_0D = string.rep("\x0D",200) 
	RandSwitch1 = "Switch 100"
	RandSwitch2 = "Switch 101"
	JYD = "Set Unit Order To: Junk Yard Dog"
	DelayMedicT = {
		StrDesign("\x1D예약메딕\x04을 \x1B2Tick\x04으로 변경합니다. - \x1F225 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B3Tick\x04으로 변경합니다. - \x1F250 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B4Tick\x04으로 변경합니다. - \x1F275 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B5Tick\x04으로 변경합니다. - \x1F300 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B비활성화(1Tick)\x04하였습니다. - \x1F200 Ore\x07")}

	GiveRateT = {"\x07『 \x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.\x07 』"}
	GiveUnitID = {64,65,66,67,61,63,68}
	BanToken = {84,69,70,60,71,98}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 



	
	UnitPointArr = {}
	UnitPointArr2 = {38,37,39,43,44,55,56,48,50,51,53,54}--재배치 등록 위치
	for j, k in pairs(UnitPointArr2) do
			SetUnitsDatX(k, {SizeL=4,SizeU=4,SizeR=4,SizeD=4,GroupFlag=0x29})
	end
	SetUnitsDatX(20, {SizeL=7,SizeU=7,SizeR=8,SizeD=9})

	--SetUnitAbility(19,5,5600,false,nil,333,1,nil,nil,38000,"짐 레이너 (V)",5000)

	
	function Create_VoidEPDHeaderV(Player,Size)
		local Void = f_GetVoidptr(Player,Size)
		local Header =  CreateVar(Player)
		table.insert(CtrigInitArr[Player+1],SetCtrigX(Header[1],Header[2],0x15C,Header[3],SetTo,Void[1],Void[2],Void[3],1,Void[4]))
		return Header
	end
	CreateUnitQueueUIDArr = Create_VoidEPDHeaderV(FP,4*200005)
	CreateUnitQueuePIDArr = Create_VoidEPDHeaderV(FP,4*200005)
	CreateUnitQueueXPosArr = Create_VoidEPDHeaderV(FP,4*200005)
	CreateUnitQueueYPosArr = Create_VoidEPDHeaderV(FP,4*200005)
	CreateUnitQueueTypeArr = Create_VoidEPDHeaderV(FP,4*200005)
	CreateUnitQueuePtr = CreateVar(FP)
	CreateUnitQueueNum = CreateVar(FP)
	CreateUnitQueuePtr2 = CreateVar(FP)

	

end