function Include_Vars()
	--System
	GiveRate2 = {1000,5000, 10000,50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4} 
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,5,6,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4,5,6}
	ObPlayers = {P8,P9,P10,P11,P12}
	MedicTrig = {34,9,88,80,21}
	MedicTick = {1,2,3,4,5}
	ObEff = 84
	nilunit = 181

	--Arr
	
	UnitIDArr = CreateArr(1700, FP)
	UnitPosArr = CreateArr(1700, FP)
	PlayerIDArr = CreateArr(1700, FP)
	--Vars
	ExRate = CreateVar2(FP, nil, nil, 13)
	Nextptrs = CreateVar(FP)
	BGMType = CreateVar(FP)
	TestMode = CreateCcode()
	BossStart = CreateCcode()
	Names = CreateVArrArr(7,7,FP)
	CurCunitI2 = CreateVar(FP)
	SetPlayers = CreateVar(FP)
	BarPos = CreateVarArr(7,FP)
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
	UTAGECcode = CreateCcode()
	--strings
	
	_0D = string.rep("\x0D",200) 
	RandSwitch1 = "Switch 100"
	RandSwitch2 = "Switch 101"
	JYD = "Set Unit Order To: Junk Yard Dog"
	DelayMedicT = {
		StrDesign("\x1D예약메딕\x04을 \x1B2Tick\x04으로 변경합니다. - \x1F200 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B3Tick\x04으로 변경합니다. - \x1F250 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B4Tick\x04으로 변경합니다. - \x1F300 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B5Tick\x04으로 변경합니다. - \x1F350 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B비활성화(1Tick)\x04하였습니다. - \x1F150 Ore\x07")}

	GiveRateT = {"\x07『 \x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다.\x07 』",
	"\x07『 \x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.\x07 』"}
	GiveUnitID = {64,65,66,67,61,63,68}
	BanToken = {84,69,70,60,71,98}

	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6","\x16P7"} 

	Str00 = CreateCText(FP,"\x12\x07『 ")
	Str01 = CreateCText(FP,"\x04의 마린\x04이 산책하다가 \x08발을 삐끗했습니다... \x07』")
	Str02 = CreateCText(FP,"\x04의 마린\x04이 \x08벌에 쏘였습니다... \x07』")
	Str03 = CreateCText(FP,"\x04의 마린\x04이 산들바람을 이기지 못하고 \x08날라갔습니다... \x07』")
	Str04 = CreateCText(FP,"\x04의 마린\x04이 \x08뱀에게 물렸습니다... \x07』")
	Str05 = CreateCText(FP,"\x04의 \x1B영웅마린\x04이 산책하다가 \x08발을 삐끗했습니다... \x07』")
	Str06 = CreateCText(FP,"\x04의 \x1B영웅마린\x04이 \x08벌에 쏘였습니다... \x07』")
	Str07 = CreateCText(FP,"\x04의 \x1B영웅마린\x04이 산들바람을 이기지 못하고 \x08날라갔습니다... \x07』")
	Str08 = CreateCText(FP,"\x04의 \x1B영웅마린\x04이 \x08뱀에게 물렸습니다... \x07』")


	
	--ButtonSet, TBL
	
	
    --function InputButtonSet(bytebuffer,UnitID,ButtonSize)
	--	local FPtrRet = f_GetFileArrptr(FP,bytebuffer,1,1)
	--	table.insert(CtrigInitArr[FP+1], SetCtrig2X(0x5187E8+(UnitID*12)+4, SetTo, FPtrRet[1], FPtrRet[2], FPtrRet[3], 0, FPtrRet[4]))
	--	table.insert(CtrigInitArr[FP+1], SetMemory(0x5187E8+(UnitID*12), SetTo, ButtonSize))
	--end
    --bytebuffer = {1,0,228,0,112,134,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,64,134,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,16,134,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,208,130,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,208,130,66,0,112,51,66,0,0,0,0,0,156,2,0,0,6,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1,7,0,234,0,16,138,66,0,240,154,69,0,0,0,239,0,166,2,0,0,9,0,236,0,16,131,66,0,240,51,66,0,0,0,0,0,188,2,0,0}
    --InputButtonSet(bytebuffer, 7, 8)

    --bytebuffer = {1,0,53,1,96,142,66,0,176,52,66,0,64,0,64,0,68,5,10,6,2,0,53,1,96,142,66,0,176,52,66,0,65,0,65,0,69,5,10,6,3,0,53,1,96,142,66,0,176,52,66,0,66,0,66,0,70,5,10,6,4,0,53,1,96,142,66,0,176,52,66,0,67,0,67,0,71,5,10,6,5,0,53,1,96,142,66,0,176,52,66,0,61,0,61,0,72,5,10,6,6,0,53,1,96,142,66,0,176,52,66,0,63,0,63,0,73,5,10,6,7,0,53,1,96,142,66,0,176,52,66,0,68,0,68,0,74,5,10,6,8,0,121,1,96,142,66,0,176,52,66,0,83,0,83,0,75,5,10,6,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,10,6,9,0,236,0,208,130,66,0,240,154,69,0,0,0,228,0,177,2,10,6}
    --InputButtonSet(bytebuffer, 51, 10)

    --bytebuffer = {1,0,250,0,224,148,66,0,112,63,66,0,4,0,4,0,81,1,0,0,2,0,132,1,96,142,66,0,176,52,66,0,72,0,72,0,217,5,10,6,3,0,130,1,96,142,66,0,176,52,66,0,3,0,3,0,132,5,10,6,7,0,214,0,208,130,66,0,240,154,69,0,0,0,51,0,67,5,10,6}
    --InputButtonSet(bytebuffer, 107, 4)

    --bytebuffer = {1,0,228,0,32,132,66,0,64,68,66,0,0,0,0,0,152,2,0,0,1,0,0,0,96,142,66,0,176,52,66,0,0,0,0,0,74,2,0,0,2,0,229,0,32,132,66,0,240,51,66,0,0,0,0,0,153,2,0,0,2,0,176,0,96,142,66,0,176,52,66,0,32,0,32,0,76,2,190,2,3,0,7,0,96,142,66,0,176,52,66,0,7,0,7,0,80,2,0,0,4,0,34,0,96,142,66,0,176,52,66,0,34,0,34,0,10,5,14,5,4,0,34,0,96,142,66,0,176,52,66,0,9,0,9,0,10,5,14,5,4,0,34,0,96,142,66,0,176,52,66,0,88,0,88,0,10,5,14,5,4,0,34,0,96,142,66,0,176,52,66,0,80,0,80,0,10,5,14,5,6,0,30,1,32,149,66,0,160,68,66,0,0,0,0,0,160,2,0,0,9,0,236,0,48,133,66,0,144,52,66,0,0,0,254,0,181,2,0,0,9,0,236,0,32,137,66,0,208,50,66,0,0,0,0,0,182,2,0,0}
    --InputButtonSet(bytebuffer, 111, 12)

    --bytebuffer = {1,0,56,1,96,142,66,0,176,52,66,0,84,0,84,0,76,5,10,6,2,0,56,1,96,142,66,0,176,52,66,0,69,0,69,0,77,5,10,6,3,0,56,1,96,142,66,0,176,52,66,0,70,0,70,0,78,5,10,6,4,0,56,1,96,142,66,0,176,52,66,0,60,0,60,0,79,5,10,6,5,0,56,1,96,142,66,0,176,52,66,0,71,0,71,0,80,5,10,6,6,0,56,1,96,142,66,0,176,52,66,0,98,0,98,0,81,5,10,6}
    --InputButtonSet(bytebuffer, 115, 6)

    --bytebuffer = {1,0,228,0,32,132,66,0,64,68,66,0,0,0,0,0,152,2,0,0,1,0,32,1,80,148,66,0,16,51,66,0,7,0,7,0,207,1,248,1,2,0,229,0,32,132,66,0,240,51,66,0,0,0,0,0,153,2,0,0,2,0,36,1,80,148,66,0,16,51,66,0,0,0,0,0,200,1,245,1,9,0,236,0,0,137,66,0,240,50,66,0,0,0,0,0,179,2,0,0}
    --InputButtonSet(bytebuffer, 122, 5)

    --bytebuffer = {2,0,109,0,96,142,66,0,176,62,66,0,109,0,109,0,135,2,0,0,6,0,124,0,96,142,66,0,176,62,66,0,124,0,124,0,139,2,205,2,8,0,125,0,96,142,66,0,176,62,66,0,125,0,125,0,141,2,206,2,9,0,236,0,208,130,66,0,240,154,69,0,0,0,228,0,176,2,0,0}
    --InputButtonSet(bytebuffer, 239, 4)
--	
    --bytebuffer = {1,0,228,0,160,141,66,0,64,68,66,0,0,0,0,0,152,2,0,0,2,0,229,0,64,141,66,0,240,51,66,0,0,0,0,0,153,2,0,0,3,0,230,0,48,143,66,0,128,67,66,0,0,0,0,0,154,2,0,0,4,0,254,0,160,141,66,0,64,65,66,0,0,0,0,0,155,2,0,0,5,0,255,0,160,141,66,0,112,51,66,0,0,0,0,0,156,2,0,0,7,0,237,0,224,148,66,0,208,52,66,0,0,0,0,0,78,1,90,1}
    --InputButtonSet(bytebuffer, 244, 6)

	--TBLFile = f_GetFileptr(FP,"custom_txt.tbl",1) -- 제작했던 아무 TBL이나 AbsolutePath에 넣고 로드
	--TBLFiles = f_GetFileSize("custom_txt.tbl") -- 예제에 사용된 tbl은 뎡디터2의 Data폴더에서 가져옴
	UnitPointArr = {}
	UnitPointArr2 = {38,37,39,43,44,55,56,48,50,51,53,54}--재배치 등록 위치
	for j, k in pairs(UnitPointArr2) do
			SetUnitsDatX(k, {SizeL=4,SizeU=4,SizeR=4,SizeD=4,GroupFlag=0x29})
	end
	SetUnitsDatX(20, {SizeL=7,SizeU=7,SizeR=8,SizeD=9})

	SetUnitAbility(19,5,5600,false,nil,333,1,nil,nil,38000,"짐 레이너 (V)",5000)
	SetUnitAbility(17,9,3800,false,nil,250,1,nil,nil,25000,"앨런 세자르",3500)
	SetUnitAbility(21,18,2800,false,nil,200,1,nil,nil,22000,"톰 카잔스키",3000)
	SetUnitAbility(28,23,4000,false,nil,600,1,nil,nil,45000,"히페리온",7500)
	SetUnitAbility(23,12,40000,false,nil,2000,1,nil,nil,150000,"에드먼드 듀크 (Tank)",40000)
	SetUnitAbility(25,28,2100,false,nil,740,1,nil,nil,30000,"에드먼드 듀크 (Siege)",3800)
	SetUnitAbility(10,26,7000,false,nil,300,1,nil,nil,60000,"구이 몬타그",5000)
	SetUnitAbility(77,65,2200,1750,nil,350,1,nil,nil,30000,"피닉스 (Z)",3000)
	SetUnitAbility(78,67,1600,2800,nil,1000,1,nil,nil,27000,"피닉스 (D)",3500)
	SetUnitAbility(88,114,1500,1800,nil,220,1,nil,nil,27000,"아르타니스",4000)
	SetUnitAbility(76,71,500,4000,nil,450,1,nil,nil,40000,"테사다르 / 제라툴",6000)
	SetUnitAbility(86,78,2500,1500,nil,600,1,nil,nil,35000,"다니모스",7000)
	SetUnitAbility(79,69,5600,4400,nil,400,1,nil,nil,50000,"태사다르",10000)
	SetUnitAbility(75,85,85000,4500,nil,1050,1,nil,nil,300000,"제라툴",60000)
	SetUnitAbility(98,100,3500,1200,nil,350,1,nil,nil,75000,"라자갈",20000)
	SetUnitAbility(162,80,5000,5000,nil,650,1,nil,nil,65000,"광자포",10000)
	SetUnitAbility(29,21,22000,false,nil,900,1,nil,nil,95000,"노라드 II",7500)
	SetUnitAbility(30,27,322,false,nil,3222,1,nil,nil,1611,"정체성 공성 전차",3222)



	
end