function Var_init()
	RandSwitch = "Switch 100"
	RandSwitch2 = "Switch 101"
	MarAtk = 50
	MarAtkFactor = 4
	MarAtkFactor2 = 8
	GunLimit = 1450

	UnitDataPtr = EPDF(0x5967EC-(1700*4))
	MaxHPBackUp = CreateArr(228,FP)
	BdDimArr = CreateArr(228,FP)
	EXPArr = CreateArr(50,FP)
	for i = 0, 49 do
		table.insert(CtrigInitArr[8],SetMemX(Arr(EXPArr,i),SetTo,50*(i+1)))
	end
	MarTblPtr = CreateVarArr(4,FP)
	ShieldEnV = CreateVarArr(4,FP)
	ShTStrPtr = CreateVarArr(4,FP)
	EEggStrPtr = CreateVarArr(4,FP)
	PyCCode = CreateCcodeArr(4)
	CereCond= CreateCcodeArr(4)

	CurrentUID = CreateVar(FP)
	Nextptrs = CreateVar(FP)
    SpeedVar = CreateVar2(FP,nil,nil,4)
    CurrentSpeed = CreateVar(FP)
	BdDimPtr = CreateVar(FP)
	SpecialAdvFlagPtr = CreateVar(FP)
	ArrID = CreateVar(FP)
	CunitHP = CreateVar(FP)
	BGMType = CreateVar(FP)
	Time1 = CreateVar(FP)
	CurEXP = CreateVar(FP)
	MaxEXP = CreateVar2(FP,nil,nil,80)
	Level = CreateVar2(FP,nil,nil,1)
	RedNumber = CreateVar2(FP,nil,nil,400)
	RedNumberT = CreateVar(FP)
	LimitX = CreateCcode()
	LimitC = CreateCcode()
	SoundLimit = CreateCcode()
	TestMode = CreateCcode() 
	OPJump = CreateCcode()
	ButtonSound = CreateCcode()
	ShieldUnlock = CreateCcodeArr(4)
	NMDMGTblPtr = CreateVar(FP)
	PerDMGTblPtr = CreateVar(FP)
	AtkCondTblPtr = CreateVar(FP)
	HPCondTblPtr = CreateVar(FP)
	SetPlayers = CreateVar(FP)
	ExRateV = CreateVar(FP)
	Dt = CreateVar(FP)
	HTextStrPtr = CreateVar(FP)
	EEggCode = CreateCcode()

	CA2ArrX = CreateVArr(1700,FP)
	CA2ArrY = CreateVArr(1700,FP)
	CA2ArrZ = CreateVArr(1700,FP)
	MarHPRegen = CreateVar2(FP,nil,nil,256)
	LVVA = CreateVArr(4,FP)
	MarHPRead = CreateVarArr(4,FP)
	AtkCondTmp = CreateVar2(FP,nil,nil,54)
	HPCondTmp = CreateVar2(FP,nil,nil,5)
	SelEPD,SelHP,SelSh,SelMaxHP = CreateVars(4,FP)
	UnitIDV1,UnitIDV2,UnitIDV3,UnitIDV4 = CreateVars(4,FP)
	SelWepID_Mask = CreateVar(FP)
	SelWepID_Mask2 = CreateVar(FP)
	SelUID_Mask = CreateVar(FP)
	SelUID_Atk = CreateVar(FP)
	SelUID_Atk2 = CreateVar(FP)
	SelWep = CreateVar(FP)
	SelUID = CreateVar(FP)
	SelClass_Mask = CreateVar(FP)
	SelHPVA = CreateVArr(4,FP)
	SelShVA = CreateVArr(4,FP)
	SelMaxHPVA = CreateVArr(4,FP)
	SelATKVA = CreateVArr(4,FP)
	SelATKVA2 = CreateVArr(4,FP)
	Names = CreateVArrArr(4,5,FP)
	AFlag = CreateCcode()
	BFlag = CreateCcode()
	ShUsed = CreateCcode()
	ShCool = CreateCcode()
	GeneT = CreateCcode()
	CXEffType = CreateCcode()
	CanCT = CreateCcode()
	CanC = CreateCcode()
	DefeatCC = CreateCcode()
	CanWT = CreateCcode()
	RepHeroIndex,Gun_LV,CunitHP,CunitP,CunitIndex = CreateVars(5,FP)
	Replace_JumpUnitArr = {nilunit,4,6,18,24,26,31,58,35,168,201}
	f_ReplaceErrT = StrDesign("\x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07")
	CurPlace = CreateCcode()
	HumanPlayers = {P1,P2,P3,P4,P9,P10,P11,P12}
	MapPlayers = {P1,P2,P3,P4}
	ObPlayers = {P9,P10,P11,P12}
	Players = {"\x081인","\x0E2인","\x0F3인","\x104인"}
	MarID = {0,1,16,99}
	MarWep = {117,118,119,120} 
	GiveRate2 = {1000, 5000,10000,50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1} 
	Color = {"\x08","\x0E","\x0F","\x10","\x11"}
	ColorCode = {0x08,0x0E,0x0F,0x10}
	MedicTrig = {34,9,5,10}
	BanToken = {63,64,65}
	GiveUnitID = {66,67,68,69}
	ExRate = {17,18,19,20}
	_0D = string.rep("\x0D",200) 
	HTextStr = _0D
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0","\x06#X_MAX"}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4"} 
	P = {"\x081인","\x0E2인","\x0F3인","\x104인"}
	DelayMedicT = {
		StrDesign("\x1D예약메딕\x04을 \x1B2Tick\x04으로 변경합니다. - \x1F300 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B3Tick\x04으로 변경합니다. - \x1F350 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B4Tick\x04으로 변경합니다. - \x1F400 Ore\x07"),
		StrDesign("\x1D예약메딕\x04을 \x1B비활성화(1Tick)\x04하였습니다. - \x1F250 Ore\x07")}
	ResetSwitch = "Switch 250"
	WaveSwitch = "Switch 150"
	P5VOFF = "Turn OFF Shared Vision for Player 5"
	P5VON = "Turn ON Shared Vision for Player 5"
	P6VOFF = "Turn OFF Shared Vision for Player 6"
	P6VON = "Turn ON Shared Vision for Player 6"
	P7VOFF = "Turn OFF Shared Vision for Player 7"
	P7VON = "Turn ON Shared Vision for Player 7"
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	JYD = "Set Unit Order To: Junk Yard Dog"

	
	ClassInfo2 = CreateCText(FP,"\x04 (")
	ClassInfo3 = CreateCText(FP,"\x04) - ")
	ClassInfo4 = CreateCText(FP," Ｄｍｇ")
	ClassInfo6 = CreateCText(FP,"\x1F.")
	ClassInfo5 = CreateCText(FP," ％")
	
	HTextStrReset = CreateCText(FP,HTextStr)
	Str12 = CreateCText(FP,"\x07·\x11·\x08·\x07【 ")
	Str03 = {}
	Str02 = {}
	NMT = CreateCText(FP,"\x04의 Ｍ\x04ａｒｉｎｅ이 \x16빛\x04을 \x04잃었습니다. \x07】\x08·\x11·\x07·")
	HMT = CreateCText(FP,"\x04의 \x1BＨ \x04Ｍ\x04ａｒｉｎｅ이 \x16빛\x04을 \x04잃었습니다. \x07】\x08·\x11·\x07·")
	for i = 0, 3 do
		table.insert(Str03,CreateCText(FP,"\x04의 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ이 \x16빛\x04을 \x04잃었습니다. \x07】\x08·\x11·\x07·"))
		table.insert(Str02,CreateCText(FP,"\x04's "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."\x07】\x08·\x11·\x07·"))
	end
	Str13 = CreateCText(FP,"\x04이(가) \x1C빛의 보호막\x04을 사용했습니다. \x07】\x08·\x11·\x07·")
	EEggStr = CreateCText(FP,"\x04이(가) \x07빛\x04의 기억\x04을 발견했습니다. \x07】\x08·\x11·\x07·")

	AtkCondT = CreateCText(FP,"공격력 업그레이드 조건 불만족\n	Next Level - ")
	HPCondT = CreateCText(FP,"체력 업그레이드 조건 불만족\n	Next Level - ")

	--CXPlot 
	function CreateVarA(Player)
		local R = CreateVar(Player)
		return R[2]
	end
	CXArrX = CreateArr(100,FP)
	CXArrY = CreateArr(100,FP)
	CXArrZ = CreateArr(100,FP)
	TSize = CreateVarA(FP)
	XAngle = CreateVarA(FP)
	YAngle = CreateVarA(FP)
	ZAngle = CreateVarA(FP)
	TCount = CreateVarA(FP)
	THeight = CreateVarA(FP)
	Arrptr = CreateVarA(FP)
	CArrptr = CreateVarA(FP)
	Arrptr1 = CreateVarA(FP)
	Arrptr2 = CreateVarA(FP)
	VArrptr1 = CreateVar(FP)
	VArrptr4 = CreateVar(FP)
	Var1 = CreateVarA(FP)
	Var2 = CreateVarA(FP)
	Move1 = CreateVarA(FP)
	Move2 = CreateVarA(FP)
	SHLX = CreateVar(FP)
	SHLY = CreateVar(FP)

	TTemp = CXMakePolyhedron(20,512) -- 한변의 크기가 512 정20면체 (Z>0 하양 / Z=0 파랑 / Z<0 검정) 
	TNumber = TTemp[1]/2 + 1
	TShape = {1,{0,0,0}} -- 원점 데이터 삽입
	local Sym = {{1,4},{2,3},{5,8},{6,7},{9,12},{10,11}}
	for i = 1, TTemp[1]/2 do
	table.insert(TShape,{TTemp[Sym[i][1]+1][1],TTemp[Sym[i][1]+1][2], TTemp[Sym[i][1]+1][3]})
	TShape[1] = TShape[1] + 1
	end
--	CreateHeroPointArr(15,"\x1B잔\x04해 "..Conv_HStr("<1B>C<04>ivilian"),30000)



CreateHeroPointArr(17,9999,0,"\x1B전\x04투병기 "..Conv_HStr("<1B>A<04>lan <1B>S<04>chezar"),25000) --
CreateHeroPointArr(19,22000,0,"\x1B기\x04습자 "..Conv_HStr("<1B>J<04>im <1B>R<04>aynor <1B>V"),45000) --
CreateHeroPointArr(77,6000,5000,"\x1B검\x04투병 "..Conv_HStr("<1B>F<4>enix <1B>Z"),30000) --
CreateHeroPointArr(78,8000,6000,"\x1B용\x04기병 "..Conv_HStr("<1B>F<4>enix <1B>D"),33000) --
CreateHeroPointArr(52,30000,0,"\x1B부\x04패 "..Conv_HStr("<1B>O<4>rganes"),55000) --
CreateHeroPointArr(10,35000,0,"\x1F화\x04염 "..Conv_HStr("<1F>I<04>nferno"),55000,nil,1) --
CreateHeroPointArr(76,9000,6000,"\x1B보\x04옥 "..Conv_HStr("<1B>O<4>rb"),45000) --
CreateHeroPointArr(63,5000,9000,"\x1F보\x04주 "..Conv_HStr("<1F>D<4>ark <1F>O<4>rb"),50000,nil,1) --
CreateHeroPointArr(21,9999,0,"\x1B망\x04령 "..Conv_HStr("<1B>T<04>om <1B>K<04>azansky"),30000) --
CreateHeroPointArr(88,9000,3000,"\x1B정\x04찰기 "..Conv_HStr("<1B>A<4>rtanis"),32000) --
CreateHeroPointArr(28,9999,0,"\x1B전\x04함 "..Conv_HStr("<1B>H<4>yperion"),35000)--
CreateHeroPointArr(86,9999,7000,"\x1B망\x04토 "..Conv_HStr("<1B>D<4>animoth"),42000)--
CreateHeroPointArr(25,9999,0,"\x1B대\x04포 "..Conv_HStr("<1B>M<4>ortal"),38000)
CreateHeroPointArr(22,35000,0,"\x1F부\x04정자 "..Conv_HStr("<1F>A<4>dverse"),55000,nil,1)--
CreateHeroPointArr(75,7000,9000,"\x1B그\x04림자 "..Conv_HStr("<1B>Z<4>eratul"),40000)--
CreateHeroPointArr(79,25000,6000,"\x1B불\x04사자 "..Conv_HStr("<1B>T<4>assadar"),45000)--
CreateHeroPointArr(80,28000,8900,"\x1F반\x04정립 "..Conv_HStr("<1F>A<04>ntithese"),55000,nil,1)
CreateHeroPointArr(8,53000,0,"\x1F유\x04령 "..Conv_HStr("<1F>P<04>hantom"),67000,nil,1)
CreateHeroPointArr(27,60000,20000,"\x1F승\x04천자 "..Conv_HStr("<1F>A<4>scension"),65000,nil,1)
CreateHeroPointArr(65,45000,20000,"\x1F광\x04전사 "..Conv_HStr("<1F>M<4>adness"),65000,nil,1)
CreateHeroPointArr(66,75000,10000,"\x1F영\x04생자 "..Conv_HStr("<1F>I<4>mmortal"),75000,nil,1)
CreateHeroPointArr(102,150000,0,"\x1F대\x04립자 "..Conv_HStr("<1F>C<4>onflict"),100000,nil,1)
CreateHeroPointArr(61,220000,10000,"\x1F변\x04명자 "..Conv_HStr("<1F>V<4>indication"),80000,nil,1)
CreateHeroPointArr(67,250000,10000,"\x1F창\x04세자 "..Conv_HStr("<1F>G<4>enesis"),115000,nil,1)

CreateHeroPointArr(23,350000,0,"\x1F우\x04상 "..Conv_HStr("<1F>I<4>conoclasm"),66600,nil,1)
CreateHeroPointArr(81,200000,25000,"\x1F공\x04작 "..Conv_HStr("<1F>D<4>antalion"),85000,nil,1)

CreateHeroPointArr(29,75000,0,"\x1F기\x04함 "..Conv_HStr("<1F>N<4>orad <1F>II"),45000,nil,1)
CreateHeroPointArr(98,85000,10000,"\x1F위\x04반자 "..Conv_HStr("<1F>B<4>reach"),75000,nil,1)
CreateHeroPointArr(70,55000,12000,"\x1F나\x04락 "..Conv_HStr("<1F>F<04>allen"),75000,nil,1)
CreateHeroPointArr(57,75000,0,"\x1F마\x04녀 "..Conv_HStr("<1F>W<4>itch"),56000,nil,1)
CreateHeroPointArr(100,55000,0,"\x1F소\x04멸자 "..Conv_HStr("<1F>E<04>clipse"),55000,nil,1)
CreateHeroPointArr(30,322,0,"\x1F정\x04체성 "..Conv_HStr("<1F>I<4>dentity"),70000,nil,1)
CreateHeroPointArr(3,68920,0,"\x1F무\x04법자 "..Conv_HStr("<1F>B<04>rutal"),76000,nil,1)



CreateHeroPointArr(71,1,60000,"\x1F고\x04통 "..Conv_HStr("<1F>P<4>ain"),55000,nil,1)



CreateHeroPointArr(60,90000,60000,"\x08적\x04대자 "..Conv_HStr("<08>A<4>ntagonism"),322000)
CreateHeroPointArr(68,500000,64000,"\x1F집\x04행관 "..Conv_HStr("<1F>J<4>udgement"),110000,nil,1)

	
CreateHeroPointArr(162,40000,60000,"\x1F증\x04오자 "..Conv_HStr("<1F>H<4>ate"),65000,nil,1)
CreateHeroPointArr(150,80000,0,"\x19선\x04물 "..Conv_HStr("<19>B<04>onus"),85000,2,1)
CreateHeroPointArr(176,10000,0,"\x19자\x04원 "..Conv_HStr("<1D>F<4>it"),15500,2,1)
CreateHeroPointArr(177,10000,0,"\x19자\x04원 "..Conv_HStr("<1D>F<4>it"),15500,2,1)
CreateHeroPointArr(178,10000,0,"\x19자\x04원 "..Conv_HStr("<1D>F<4>it"),15500,2,1)
end