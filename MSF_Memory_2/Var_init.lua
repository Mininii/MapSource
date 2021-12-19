function Var_init()
	MarAtk = 15
	MarAtkFactor = 3


	UnitDataPtr = EPDF(0x5967EC-(1700*4))
	MaxHPBackUp = CreateArr(228,FP)
	BdDimArr = CreateArr(228,FP)
	EXPArr = CreateArr(50,FP)
	for i = 0, 49 do
		table.insert(CtrigInitArr[8],SetMemX(Arr(EXPArr,i),SetTo,80*(i+1)))
	end
	

	CurrentUID = CreateVar(FP)
	Nextptrs = CreateVar(FP)
    SpeedVar = CreateVar2(FP,nil,nil,4)
    CurrentSpeed = CreateVar(FP)
	VRet = CreateVar(FP)
	VRet2 = CreateVar(FP)
	VRet3 = CreateVar(FP)
	VRet4 = CreateVar(FP)
	ArrID = CreateVar(FP)
	CunitHP = CreateVar(FP)
	BGMType = CreateVar(FP)
	Time1 = CreateVar(FP)
	CurEXP = CreateVar(FP)
	MaxEXP = CreateVar2(FP,nil,nil,80)
	Level = CreateVar2(FP,nil,nil,1)
	RedNumber = CreateVar(FP)
	LimitX = CreateCcode()
	LimitC = CreateCcode()
	SoundLimit = CreateCcode()
	TestMode = CreateCcode() 
	OPJump = CreateCcode()
	ButtonSound = CreateCcode()
	NMDMGTblPtr = CreateVar(FP)
	PerDMGTblPtr = CreateVar(FP)
	Dt = CreateVar(FP)
	
	SelEPD,SelHP,SelSh,SelMaxHP = CreateVars(4,FP)
	SelWepID_Mask = CreateVar(FP)
	SelWepID_Mask2 = CreateVar(FP)
	SelUID_Mask = CreateVar(FP)
	SelUID_Atk = CreateVar(FP)
	SelUID_Atk2 = CreateVar(FP)
	SelWep = CreateVar(FP)
	SelWepID = CreateVar(FP)
	SelUID = CreateVar(FP)
	SelATK = CreateVar(FP)
	SelClass = CreateVar(FP)
	SelClass_Mask = CreateVar(FP)
	SelHPVA = CreateVArr(4,FP)
	SelShVA = CreateVArr(4,FP)
	SelMaxHPVA = CreateVArr(4,FP)
	SelATKVA = CreateVArr(4,FP)
	SelATKVA2 = CreateVArr(4,FP)
	AFlag = CreateCcode()
	BFlag = CreateCcode()
	RepHeroIndex,Gun_LV,CunitHP,CunitP,CunitIndex = CreateVars(5,FP)
	Replace_JumpUnitArr = {nilunit,4,6,18,24,26,31,58,35,168,201}
	f_ReplaceErrT = StrDesign("\x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07")
	CurPlace = CreateCcode()
	HumanPlayers = {P1,P2,P3,P4,P9,P10,P11,P12}
	MapPlayers = {P1,P2,P3,P4}
	ObPlayers = {P9,P10,P11,P12}
	MarID = {0,1,6,99}
	MarWep = {117,118,119,120} 
	GiveRate2 = {1000, 5000,10000,50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1} 
	ColorCode = {0x08,0x0E,0x0F,0x10}
	MedicTrig = {34,9,5,10}
	BanToken = {63,64,65}
	GiveUnitID = {66,67,68,69}
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

	
	ClassInfo1 = CreateCText(FP,"\x04 / ")
	ClassInfo2 = CreateCText(FP,"\x04(")
	ClassInfo3 = CreateCText(FP,"\x04) - ")
	ClassInfo4 = CreateCText(FP," Ｄｍｇ")
	ClassInfo6 = CreateCText(FP,"．")
	ClassInfo5 = CreateCText(FP," ％")

--	CreateHeroPointArr(15,"\x1B잔\x04해 "..Conv_HStr("<1B>C<04>ivilian"),30000)

CreateHeroPointArr(17,"\x1B전\x04투병기 "..Conv_HStr("<1B>A<04>lan <1B>S<04>chezar"),30000)
CreateHeroPointArr(77,"\x1B검\x04투병 "..Conv_HStr("<1B>F<4>enix <1B>Z"),30000)
CreateHeroPointArr(78,"\x1B용\x04기병 "..Conv_HStr("<1B>F<4>enix <1B>D"),30000)
CreateHeroPointArr(76,"\x1B보\x04옥 "..Conv_HStr("<1B>O<4>rb"),30000)
CreateHeroPointArr(28,"\x1B전\x04함 "..Conv_HStr("<1B>H<4>yperion"),30000)
CreateHeroPointArr(19,"\x1B기\x04습자 "..Conv_HStr("<1B>J<04>im <1B>R<04>aynor <1B>V"),30000)
CreateHeroPointArr(21,"\x1B망\x04령 "..Conv_HStr("<1B>T<04>om <1B>K<04>azansky"),30000)
CreateHeroPointArr(86,"\x1B망\x04토 "..Conv_HStr("<1B>D<4>animoth"),30000)
CreateHeroPointArr(75,"\x1B그\x04림자 "..Conv_HStr("<1B>Z<4>eratul"),30000)
CreateHeroPointArr(88,"\x1B정\x04찰기 "..Conv_HStr("<1B>A<4>rtanis"),30000)
CreateHeroPointArr(25,"\x1B대\x04포 "..Conv_HStr("<1B>M<4>ortal"),30000)
CreateHeroPointArr(79,"\x1B불\x04사자 "..Conv_HStr("<1B>T<4>assadar"),30000)
CreateHeroPointArr(52,"\x1B부\x04패 "..Conv_HStr("<1B>O<4>rganes"),30000)
CreateHeroPointArr(60,"\x08적\x04대자 "..Conv_HStr("<08>A<4>ntagonism"),30000)
CreateHeroPointArr(30,"\x1F정\x04체성 "..Conv_HStr("<1F>I<4>dentity"),30000,nil,1)
CreateHeroPointArr(67,"\x1F창\x04세자 "..Conv_HStr("<1F>G<4>enesis"),30000,nil,1)
CreateHeroPointArr(10,"\x1F화\x04염 "..Conv_HStr("<1F>I<04>nferno"),30000,nil,1)
CreateHeroPointArr(71,"\x1F고\x04통 "..Conv_HStr("<1F>P<4>ain"),30000,nil,1)
CreateHeroPointArr(63,"\x1F보\x04주 "..Conv_HStr("<1F>D<4>ark <1F>O<4>rb"),30000,nil,1)
CreateHeroPointArr(61,"\x1F변\x04명자 "..Conv_HStr("<1F>V<4>indication"),30000,nil,1)
CreateHeroPointArr(27,"\x1F승\x04천자 "..Conv_HStr("<1F>A<4>scension"),30000,nil,1)
CreateHeroPointArr(29,"\x1F기\x04함 "..Conv_HStr("<1F>N<4>orad <1F>II"),30000,nil,1)
CreateHeroPointArr(23,"\x1F우\x04상 "..Conv_HStr("<1F>I<4>conoclasm"),30000,nil,1)
CreateHeroPointArr(81,"\x1F공\x04작 "..Conv_HStr("<1F>D<4>antalion"),30000,nil,1)
CreateHeroPointArr(162,"\x1F증\x04오자 "..Conv_HStr("<1F>H<4>ate"),30000,nil,1)
CreateHeroPointArr(98,"\x1F위\x04반자 "..Conv_HStr("<1F>B<4>reach"),30000,nil,1)
CreateHeroPointArr(68,"\x1F집\x04행관 "..Conv_HStr("<1F>J<4>udgment"),30000,nil,1)
CreateHeroPointArr(65,"\x1F광\x04전사 "..Conv_HStr("<1F>M<4>adness"),30000,nil,1)
CreateHeroPointArr(66,"\x1F영\x04생자 "..Conv_HStr("<1F>I<4>mmortal"),30000,nil,1)
CreateHeroPointArr(57,"\x1F마\x04녀 "..Conv_HStr("<1F>W<4>itch"),30000,nil,1)
CreateHeroPointArr(8,"\x1F유\x04령 "..Conv_HStr("<1F>P<04>hantom"),30000,nil,1)
CreateHeroPointArr(3,"\x1F무\x04법자 "..Conv_HStr("<1F>B<04>rutal"),30000,nil,1)
CreateHeroPointArr(80,"\x1F균\x04형 "..Conv_HStr("<1F>E<4>quilibrium"),30000,nil,1)
CreateHeroPointArr(102,"\x1F대\x04립자 "..Conv_HStr("<1F>C<4>onflict"),30000,nil,1)

	
end