function Source()
	--Balance
	AtkFactor = 15
	DefFactor = 20
	SuFactor = 200
	NMCost = 30000
	NMCost10X = 300000
	HMCost = 10000
	GMCost = 25000
	NeCost = 20000
	ExRate = 15
	EasyEx1P = 160
	HDEx1P = 175
	BurEx1P = 190
	GunLimit = 1500

	ExArr = {--ȯ����
		{},--����
		{},--�ϵ�
		{},--��
	}
	for i = 1, 7 do
		table.insert(ExArr[1],EasyEx1P+(ExRate*(i-1)))
		table.insert(ExArr[2],HDEx1P+(ExRate*(i-1)))
		table.insert(ExArr[3],BurEx1P+(ExRate*(i-1)))
	end

	--System
	GiveRate2 = {1000, 5000, 10000, 50000,100000,500000}  
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1}
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x18,0x16}
	HumanPlayers = {0,1,2,3,4,5,6,P9,P10,P11,P12}
	MapPlayers = {0,1,2,3,4,5,6}
	ObPlayers = {P9,P10,P11,P12}
	MedicTrig = {34,9,5,11}
	EXCC_Forward = 0x2FFF
	
	CC_Header = CreateVar(FP)
	ObEff = 84
	nilunit = 181
	MedicFuncArr = {0,16,7,100,124,125,20,60,99,12}
	MedicFuncArr2 = {3500,9000,2000,10000,10000,10000,6500,167772,30000,50000}
	MedicFuncArr3 = {0,0,0,0,10000,10000,0,65535,30000,50000}
	ZergGndUArr = {51,53,54,48,104}
	HondonFlingyArr = {88,73,72,4,188,187,49,40,45,38,44,43,37,46,47,191,15,8,14,1,5,12,11,7,13,0,2,9,41,190,186,74}

	F12 =202
	ESC =199
	Tab =214
	Str00 = CreateCText(FP,"\x12\x02��")
	Str01 = CreateCText(FP,"\x04�� \x04Marine\x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	Str02 = CreateCText(FP,"\x04�� \x1BH \x04Marine\x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	Str03 = CreateCText(FP,"\x04�� \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	Str04 = CreateCText(FP,"\x04�� \x11��\x07��\x1F��\x1C��\x17��\x11�� \x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	TeText = CreateCText(FP,"\x04�� \x10��\x07��\x0F�ң�\x1F�� \x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	SuText = CreateCText(FP,"\x04�� \x07��\x1F��\x1C��\x0E��\x0F��\x10��\x17��\x11��\x08�� \x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	QuaText = CreateCText(FP,"\x04�� \x11��\x1F��\x1B��\x16��\x10��\x1D�� \x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	Str05 = CreateCText(FP,"\x04�� \x04SCV\x04�� \x1C����\x04�� \x15����\x04�� ���ư����ϴ�.. \x02��")
	Str12 = CreateCText(FP,"\x12\x07�� \x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	Str19 = CreateCText(FP,"\x13\x15�� �� �� [\x04 ")
	Str20 = CreateCText(FP," \x11���\x10 +\x17 ")
	Str21 = CreateCText(FP," P t s \x15] \x15�� �� ��")
	Str22 = CreateCText(FP,"\x04 �̳׶��� �Һ��Ͽ� �� \x0d\x0d\x0d\x0d\x0d\x0d")
	Str23 = CreateCText(FP,"\x04 \x04ȸ ���׷��̵带 �Ϸ��Ͽ����ϴ�. \x07��\x0d\x0d\x0d\x0d\x0d\x0d")
	Str24 = CreateCText(FP,"\x07��\x0d\x0d\x0d\x0d\x0d\x0d")
	Str26 = CreateCText(FP,"\x04���� ���ð��� �÷��̾��...")
	MGPStr1 = CreateCText(FP,"\x13\x07�� \x1F�̳׶� �ڽ�\x04�� �����Ͽ� ")
	MGPStr2 = CreateCText(FP," �̳׶��� \x07������ϴ�. \x04���ϵ帳�ϴ�! \x07��")
	MGPStr3 = CreateCText(FP," �̳׶��� \x08�Ҿ����ϴ�. \x04����... \x07��")

	

	


	
	

	_0D = string.rep("\x0D",200) 
	HTextStr = _0D
	GiveUnitID = {64,65,66,67,61,63,68}
	BanToken = {84,69,70,88,71,98}
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0","\x08#X_MAX"}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x18P6","\x16P7"} 
	P = {"\x081��","\x0E2��","\x0F3��","\x104��","\x115��","\x186��","\x167��"}
	P8VOFF = "Turn OFF Shared Vision for Player 8"
	P8VON = "Turn ON Shared Vision for Player 8"
	JYD = "Set Unit Order To: Junk Yard Dog" 
	DelayMedicT = {
		"\x1E�� \x1D����޵�\x04�� \x1B2Tick\x04���� �����մϴ�. - \x1F300 Ore\x1E ��",
		"\x1E�� \x1D����޵�\x04�� \x1B3Tick\x04���� �����մϴ�. - \x1F350 Ore\x1E ��",
		"\x1E�� \x1D����޵�\x04�� \x1B4Tick\x04���� �����մϴ�. - \x1F400 Ore\x1E ��",
		"\x1E�� \x1D����޵�\x04�� \x1B��Ȱ��ȭ(1Tick)\x04�Ͽ����ϴ�. - \x1F250 Ore\x1E ��"}

	GiveRateT = {"\x07�� \x04��αݾ� ������ \x1F5000 Ore\x04 \x04�� ����Ǿ����ϴ�.\x07 ��",
	"\x07�� \x04��αݾ� ������ \x1F10000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
	"\x07�� \x04��αݾ� ������ \x1F50000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
	"\x07�� \x04��αݾ� ������ \x1F100000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
	"\x07�� \x04��αݾ� ������ \x1F500000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��",
	"\x07�� \x04��αݾ� ������ \x1F1000 Ore \x04�� ����Ǿ����ϴ�.\x07 ��"}

	
--Str25 = {
--CreateCText(FP,"\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST\x04 \x04[R] \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x04[Y] \x07���ÿϷ�"),
--CreateCText(FP,"\x04 : \x03[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST\x04 \x04[R] \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x04[Y] \x07���ÿϷ�"),
--CreateCText(FP,"\x04 : \x04[Q] \x0EEASY \x03[W] \x08HARD \x04[E] \x11BURST\x04 \x04[R] \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x04[Y] \x07���ÿϷ�"),
--CreateCText(FP,"\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x03[E] \x11BURST\x04 \x04[R] \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x04[Y] \x07���ÿϷ�"),
--CreateCText(FP,"\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST\x04 \x03[R] \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x04[Y] \x07���ÿϷ�"),
--}
Str25 = {
CreateCText(FP,"\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST \x04[Y] \x07���ÿϷ�"),
CreateCText(FP,"\x04 : \x03[Q] \x0EEASY \x04[W] \x08HARD \x04[E] \x11BURST \x04[Y] \x07���ÿϷ�"),
CreateCText(FP,"\x04 : \x04[Q] \x0EEASY \x03[W] \x08HARD \x04[E] \x11BURST \x04[Y] \x07���ÿϷ�"),
CreateCText(FP,"\x04 : \x04[Q] \x0EEASY \x04[W] \x08HARD \x03[E] \x11BURST \x04[Y] \x07���ÿϷ�"),
}
Str27 = {
CreateCText(FP,"\x04 : \x04[Q] \x0E�̺�\x04�� \x04�Ϲݸ�� \x04[W] \x08����\x04�� \x06������ \x04[E] \x10������\x04�� \x11���������� \x04[Y] \x07���ÿϷ�"),
CreateCText(FP,"\x04 : \x03[Q] \x0E�̺�\x04�� \x04�Ϲݸ�� \x04[W] \x08����\x04�� \x06������ \x04[E] \x10������\x04�� \x11���������� \x04[Y] \x07���ÿϷ�"),
CreateCText(FP,"\x04 : \x04[Q] \x0E�̺�\x04�� \x04�Ϲݸ�� \x03[W] \x08����\x04�� \x06������ \x04[E] \x10������\x04�� \x11���������� \x04[Y] \x07���ÿϷ�"),
CreateCText(FP,"\x04 : \x04[Q] \x0E�̺�\x04�� \x04�Ϲݸ�� \x04[W] \x08����\x04�� \x06������ \x03[E] \x10������\x04�� \x11���������� \x04[Y] \x07���ÿϷ�"),
}

DifLeaderBoard = {
	"\x04 - \x0EEASY \x04Mode",
	"\x04 - \x08HARD \x04Mode",
	"\x04 - \x11BURST \x04Mode"}
	RandSwitch1 = "Switch 100"
	RandSwitch2 = "Switch 101"
	--Gun_SVA = CreateSVArr(16,64,FP)
	--G_CA_SVA = CreateSVArr(16,64,FP)
	RandMarCcode = CreateCcodeArr(7)
	AutoCombiCcode = CreateCcodeArr(7)
	BGMType=CreateVar(FP)
	ExRateV = CreateVar(FP)
	SelCP=CreateVar(FP)
	HiddenModeT = CreateVArr(20,FP)
	HondonMode = CreateVar(FP)
	HiddenMode = CreateCcode()
	KeyToggle = CreateCcode()
	ToggleSound = CreateCcode()
	ToggleSound2 = CreateCcode()
	ModeSel = CreateCcode()
	GMode = CreateCcode()
	SelectorT = CreateCcode()
	IntroT = CreateCcode()
	IntroT2 = CreateCcode()
	DMode = CreateCcode()
	GStart = CreateCcode()
	ModeT = CreateCcode()
	ModeT2 = CreateCcode()
	ModeO = CreateCcode()
	Print13 = CreateCcode()
	MaxHPBackUp = CreateArr(228,FP)
	NMStrPtr = CreateVarArr(7,FP)
	HMStrPtr = CreateVarArr(7,FP)
	GMStrPtr = CreateVarArr(7,FP)
	NBStrPtr = CreateVarArr(7,FP)
	SVStrPtr = CreateVarArr(7,FP)
	TRStrPtr = CreateVarArr(7,FP)
	SNStrPtr = CreateVarArr(7,FP)
	QSStrPtr = CreateVarArr(7,FP)
	Names = CreateVArrArr(7,7,FP)
	BdDimArr = CreateArr(228,FP)
	f_GunNum = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	SoundLimitT = CreateCcode()
	SoundLimit = CreateCcode()
	TestMode = CreateCcode()
	LimitX = CreateCcode()
	LimitC = CreateCcode()
	NosBGM = CreateCcode()
	NextNosBGM = CreateCcode()
	BackupCp = CreateVar(FP)
	AtkUpMax = CreateVar2(FP,nil,nil,255)
	
	CUnitFlag = CreateCcode()
	UpgradeAv = CreateVar(FP)
	HiddenHP = CreateVar(FP)
	HiddenATK = CreateVar(FP)
	HiddenPts = CreateVar(FP)
	HiddenHPM = CreateVar(FP)
	HiddenATKM = CreateVar(FP)
	HiddenPtsM = CreateVar(FP)
	SetPlayers = CreateVar(FP)
	HiddenModeStrPtr = CreateVar(FP)
	HPointVar = CreateVar2(FP,nil,nil,100)
	ifUpisAtk = CreateCcode()
	ButtonSound = CreateCcode()
	NoticeCD = CreateCcode()
	InfArmorFactor = CreateVar2(FP,nil,nil,DefFactor)
	InfWeaponFactor = CreateVar2(FP,nil,nil,AtkFactor)
	UPCompStrPtr = CreateVar(FP)
	UpgradeCP = CreateVar(FP)
	UpgradeFactor = CreateVar(FP)
	TempUpgradePtr = CreateVar(FP)
	TempUpgradeMaskRet = CreateVar(FP)
	CurrentFactor = CreateVar(FP)
	CurrentUpgrade = CreateVar(FP)
	UpCount = CreateVar(FP)
	UpgradeMax = CreateVar(FP)
	UpCompTxt = CreateVArr(4,FP)
	UpCompRet = CreateVArr(4,FP)
	CPosX,CPosY,CPos = CreateVars(3,FP)
	count,count1,count2,count3 = CreateVars(4,FP)
	Gun_Type = CreateVar(FP)
	CurCunitI = CreateVar(FP)
	G_TempH = CreateVar(FP)
	G_TempW = CreateVar(FP)
	CunitP = CreateVar(FP)
	NextPtrs = CreateVar(FP)
	G_InputH = CreateVar(FP)
	HeroTxtStrPtr = CreateVar(FP)
	BanCode = CreateCcodeArr(6)
	DelayMedic = CreateCcodeArr(7)
	GiveRate = CreateCcodeArr(7)
	HactCcode = CreateCcode() -- 0�ϰ��
	LairCcode = CreateCcode() -- 0�ϰ��
	HiveCcode = CreateCcode() -- 0�ϰ��
	PyCCode = CreateCcode() -- 9�ϰ��
	XelCcode = CreateCcode() -- 4�ϰ��
	IonCcode = CreateCcode() -- 1�ϰ��
	FaciCcode = CreateCcode() -- 4�ϰ��
	ChryCcode = CreateCcode() -- 4�ϰ��
	CereCcode = CreateCcode() -- 4�ϰ��
	CenCcode = CreateCcode() -- 4�ϰ��
	NexCcode = CreateCcode() -- 2�ϰ��
	CocoonCcode = CreateCcode() -- 1�ϰ��
	GeneCcode = CreateCcode() -- 1�ϰ��
	OverGCcode = CreateCcode() -- 1�ϰ��
	OvrmCcode = CreateCcode() -- 2�ϰ��
	PsiCcode = CreateCcode() -- 1�ϰ��
	FormCcode = CreateCcode() -- 1�ϰ��
	CellCcode = CreateCcode() -- 3�ϰ��
	BossCcode = CreateCcode()
	Emer_EscapeC = CreateCcodeArr(7)
	Drop = CreateCcode()
	TempUnitReadV = CreateVar(FP)
	function Create_VoidEPDHeaderV(Player,Size)
		local Void = f_GetVoidptr(Player,Size)
		local Header =  CreateVar(Player)
		table.insert(CtrigInitArr[Player+1],SetCtrigX(Header[1],Header[2],0x15C,Header[3],SetTo,Void[1],Void[2],Void[3],1,Void[4]))
		return Header
	end
	CreateUnitQueueUIDArr = Create_VoidEPDHeaderV(FP,4*50005)
	CreateUnitQueuePIDArr = Create_VoidEPDHeaderV(FP,4*50005)
	CreateUnitQueueXPosArr = Create_VoidEPDHeaderV(FP,4*50005)
	CreateUnitQueueYPosArr = Create_VoidEPDHeaderV(FP,4*50005)
	CreateUnitQueueTypeArr = Create_VoidEPDHeaderV(FP,4*50005)
	CreateUnitQueuePtr = CreateVar(FP)
	CreateUnitQueueNum = CreateVar(FP)
	CreateUnitQueuePtr2 = CreateVar(FP)
	if STRCTRIGASM == 1 then
		
		--UnitDataPtr = EPDF(0x5967EC-(1700*4)) --0x594D5C~0x5967EC
		--UnitNamePtr = 0x590000 --0x590000~0x5938C0
		UnitDataVoid = {f_GetVoidptr(FP,1700*4),f_GetVoidptr(FP,1700*4)}
		UnitDataPtr = CreateVar(FP)
		UnitNamePtrVoid = f_GetVoidptr(FP,230*(0x40))
		UnitNamePtr = CreateVar(FP)
		table.insert(CtrigInitArr[FP+1],SetCtrigX(UnitNamePtr[1],UnitNamePtr[2],0x15C,UnitNamePtr[3],SetTo,UnitNamePtrVoid[1],UnitNamePtrVoid[2],UnitNamePtrVoid[3],0,UnitNamePtrVoid[4]))
	else
		UnitDataPtr = EPDF(0x5967EC-(1700*4)) --0x594D5C~0x5967EC
		UnitNamePtr = 0x590000 --0x590000~0x5938C0
	end
    SpeedVar = CreateVar2(FP,nil,nil,4)
    CurrentSpeed = CreateVar(FP)
	ZergGndVArr = CreateVArray(FP,#ZergGndUArr)
	HactLinkArr = CreateArrArr(15,5,FP)
	LairLinkArr = CreateArrArr(15,5,FP)
	TempEPD =CreateVar(FP)
	TempRandRet,InputMaxRand,Oprnd = CreateVars(3,FP)
	Gun_TempSpawnSet1,Repeat_TempV,RepeatType = CreateVars(3,FP)
	f_GunSendStrPtr,f_GunSendStrPtr2,G_CA_StrPtr,G_CA_StrPtr2,G_CA_StrPtr3,f_GunStrPtr,UPCompStrPtr = CreateVars(7,FP)
	RepHeroIndex,Gun_LV,CunitHP,CunitIndex = CreateVars(4,FP)
	MinGachaPStrPtr = CreateVar(FP)
	MinGachaMStrPtr = CreateVar(FP)
	AtkUpgradePtrArr = {}
	AtkUpgradeMaskRetArr = {}
	DefUpgradePtrArr = {}
	DefUpgradeMaskRetArr = {}
	for i = 0, 6 do
	table.insert(AtkUpgradeMaskRetArr,(0x58D2B0+(i*46)+7)%4)
	table.insert(AtkUpgradePtrArr,0x58D2B0+(i*46)+7 - AtkUpgradeMaskRetArr[i+1])
	table.insert(DefUpgradeMaskRetArr,(0x58D2B0+(i*46))%4)
	table.insert(DefUpgradePtrArr,0x58D2B0+(i*46) - DefUpgradeMaskRetArr[i+1])
	end

	MarCreateVArr = CreateVArrArr(7, 7, FP)

	

end