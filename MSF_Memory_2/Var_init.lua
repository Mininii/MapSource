function Var_init()
	UnitDataPtr = EPDF(0x5967EC-(1700*4))
	MaxHPBackUp = CreateArr(228,FP)
	BdDimArr = CreateArr(228,FP)
	CurrentUID = CreateVar(FP)
	Nextptrs = CreateVar(FP)
	VRet = CreateVar(FP)
	VRet2 = CreateVar(FP)
	VRet3 = CreateVar(FP)
	VRet4 = CreateVar(FP)
	ArrID = CreateVar(FP)
	CunitHP = CreateVar(FP)
	RepHeroIndex,Gun_LV,CunitHP,CunitP,CunitIndex = CreateVars(5,FP)
	Replace_JumpUnitArr = {nilunit,4,6,18,24,26,31,58,35,168,201}
	f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	
	CurPlace = CreateCcode()
	HumanPlayers = {P1,P2,P3,P4,P9,P10,P11,P12}
	MapPlayers = {P1,P2,P3,P4}
	ObPlayers = {P9,P10,P11,P12}
end