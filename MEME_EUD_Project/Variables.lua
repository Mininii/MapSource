function Vars()
    nilunit = 181
    CurrentOP = CreateVar(FP)
	Nextptrs = CreateVar(FP)

	TestMode = CreateCcode()
	RandSwitch1 = "Switch 100"
	RandSwitch2 = "Switch 101"

    JYD = "Set Unit Order To: Junk Yard Dog"
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	HumanPlayers = {0,1,2,3,4,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4}
	ObPlayers = {P9,P10,P11,P12}
	UnitIDArr = CreateFArr(1700, FP)
	UnitPosArr = CreateFArr(1700, FP)
	PlayerIDArr = CreateFArr(1700, FP)
end