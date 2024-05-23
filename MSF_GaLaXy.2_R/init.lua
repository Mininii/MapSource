function onInit()
	RandSwitch = "Switch 1"
	RandSwitch1 ="Switch 6"
	RandSwitch2 ="Switch 7"
	_0D = string.rep("\x0D",200)
	BanToken = {84,69,70,98,71}
	GiveUnitID = {64,65,66,67,61,63}
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0","\x08#X_MAX"}
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1}
	GiveRate2 = {1000, 5000, 10000, 50000, 100000,500000} 
	Player = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6"}
	PlayerString = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x18P6","\x16P7"} 
	Color = {"\x08","\x0E","\x0F","\x10","\x11","\x15"}
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15}
	Marine = {}
	HMarine = {}
	LumMarine = {}
	Lumia = {}
	MarineL = {}
	HMarineL = {}
	LumMarineL = {}
	LumiaL = {}
	Str03 = {}
	Str03L = {}
	Names = {}
	NamesI = {}
	LumiaCT = {}
	ShieldT = {}
	PatchArr = {}
	PatchArr2 = {}
	PatchArr3 = {}
	ATKExitText = {}
	ATKUpText1 = {}
	ATKUpText2 = {}
	PlayerName={}
	DefTypePatchforZerg={}
	DefTypePatch={}
	AtkTypePatch={}
	CreateSpeedPatch = {}
	ZergGroupFlagsPatch = {}
	UnitDefPatch = {}
	NonBionicPatch = {}
	DefIgnorePatch = {}
	SizePatchArr = {}
	HeroIndexArr = {2,3,8,10,11,12,15,17,19,21,23,25,27,28,29,32,52,61,63,64,65,66,67,68,69,70,71,74,75,76,77,78,79,80,81,82,83,86,87,88,98,102}
	HondonFlingyArr = {88,73,72,176,4,188,187,49,40,45,38,44,43,37,46,47,191,15,8,14,1,5,12,11,7,13,0,2,9,41,190,115,74,81,186}
	ButtonSetArr = {72,3,84,69,70,60,71,64,65,66,67,61,63,83}
	ButtonSetPatch = {}
	ButtonSetPatch2 = {}
	GunBossUIDArr = {80,86,102,98,88}
	
	for i = 1, #ButtonSetArr do
		table.insert(ButtonSetPatch,SetMemoryW(0x65FD00 + (ButtonSetArr[i]*2), SetTo, 10000))
		table.insert(ButtonSetPatch2,SetMemoryW(0x65FD00 + (ButtonSetArr[i]*2), SetTo, 0))
	end
	
	f_GunErrT = "\x07『 \x08ERROR \x04: G_CAPlot Not Found. \x07』"
	f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CAPlot Suspended. \x07』"
	G_SendErrT = "\x07『 \x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	CBulletErrT = "\x07『 \x08ERROR \x04: CreateBullet_EPD 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"

	f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	f_GunSendT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	f_GunSendT2 = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: 성공한 f_GunSend의 EXCunit Number : ")
	SuText = CreateCText(FP,"\x0d\x0d\x0d\x04의 \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ \x04가 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \x02◆\n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x06100\x04)\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	QuaText = CreateCText(FP,"\x0d\x0d\x0d\x04의 \x11Ｑ\x1FＵ\x1BＡ\x16Ｓ\x10Ａ\x1DＲ \x04가 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \x02◆\n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x06500\x04)\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	TeText = CreateCText(FP,"\x0d\x0d\x0d\x04의 \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ \x04가 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \x02◆\n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x065\x04)\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	SuT00 = CreateCText(FP,"\x0d\x0d\x0d\x12\x02◆ \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	
	DefStr1 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x13\x0d\x0d\x0d\x0d\x0d\x0d")
	DefStr2 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04(이)가 \x1C방어력 \x04업그레이드를 완료하였습니다.\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
	


	InFormation = "\n\n\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x14\n\x14\n\x13\x07C\x04ustom \x07P\x04lib \x1FLock \x17Protector \x07v1.0 \x04in Used. \x19(つ>ㅅ<)つ \n\x13\x1FThanks \x04to \x1BNinfia\n\x13\x04이 문구가 뜰 경우 \x07정식버전\x04입니다. \n\x13\x04무단 수정맵을 주의해주세요.\n\x14\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"


	--Balance
	AtkFactor = 15
	DefFactor = 20
	SuFactor = 150
	QuaFactor = 255
	MarCost = 10000
	GMCost = 30000
	NeCost = 30000
	TeCost = 50000
	SuCost = 400000
	QuaCost = 1000000
	HPointFactor = 10
	ExRate = 15
    EasyEx1P = 170
    HDEx1P = 170
    BurEx1P = 170
	ExRate2 = 5
    EasyEx1P2 = 170
    HDEx1P2 = 170
    BurEx1P2 = 170
	GunLimit = 1450
	--Patch
	for j = 0, 5 do
	table.insert(PatchArr2,Simple_CalcLoc("P"..j+1,0,0,32*10,32*10))
	table.insert(PatchArr2,Simple_CalcLoc("S"..j+1,0,0,32*5,32*5))
	table.insert(PatchArr2,Simple_CalcLoc("G"..j+1,0,0,32*5,32*5))
	end
function SetUnitAdvFlag(UnitID,Value,Mask)
	table.insert(PatchArr2,SetMemoryX(0x664080 + (UnitID*4),SetTo,Value,Mask))
end
function SetZergGroupFlags(UnitID)
	table.insert(ZergGroupFlagsPatch,SetMemoryB(0x6637A0 + (UnitID),SetTo,0x01+0x08+0x20))
	end
	for i = 37, 57 do
	SetZergGroupFlags(i)
	end
	SetZergGroupFlags(62)
	SetZergGroupFlags(103)
	SetZergGroupFlags(104)
	function UnitEnable(UnitID)
	table.insert(PatchArr,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
	table.insert(PatchArr2,SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr2,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr2,SetMemoryW(0x65FD00 + (UnitID *2),SetTo,0))
	table.insert(PatchArr2,SetMemoryW(0x663888 + (UnitID *2),SetTo,0))
	table.insert(PatchArr2,SetMemoryW(0x660428 + (UnitID *2),SetTo,1))
	table.insert(PatchArr2,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
	end


	for i=0,5 do
	table.insert(PatchArr3,SetMemoryB(0x57F27C + (i * 228) + GiveUnitID[i+1],SetTo,0))
	end
	for i=0,4 do
	table.insert(PatchArr3,SetMemoryB(0x57F27C + ((i+1) * 228) + BanToken[i+1],SetTo,0))
	end
	function UnitEnable2(UnitID)
	table.insert(PatchArr,SetMemoryW(0x660A70 + (UnitID *2),SetTo,5))
	table.insert(PatchArr2,SetMemoryB(0x57F27C + (6 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr2,SetMemoryB(0x57F27C + (7 * 228) + UnitID,SetTo,0))
	table.insert(PatchArr2,SetMemoryB(0x663CE8 + UnitID,SetTo,0))
	end
	for i=0,55 do
	table.insert(DefTypePatch,SetMemory(0x662180 + 4*i,SetTo,0))
	end
	for i=0,32 do
	table.insert(AtkTypePatch,SetMemory(0x657258 + 4*i,SetTo,0))
	end
	table.insert(AtkTypePatch,SetMemoryB(0x657258 + 129,SetTo,0))
	table.insert(AtkTypePatch,SetMemoryB(0x657258 + 117,SetTo,2))
	function ZergDefTypePatch(UnitID)
	table.insert(DefTypePatchforZerg,SetMemoryB(0x662180 + UnitID,SetTo,2))
	end
	function Force1DefTypePatch(UnitID)
	table.insert(DefTypePatch,SetMemoryB(0x662180 + UnitID,SetTo,1))
	end
	function ZergCreateSpeedPatch(UnitID)
	table.insert(CreateSpeedPatch,SetMemoryW(0x660428 + (UnitID*2),SetTo,30))
	end
	function WeaponDefIgnore(UnitID)
	table.insert(DefIgnorePatch,SetMemoryB(0x657258 + (UnitID),SetTo,4))
	end
	
	function SetTo0UnitDef(Index)
	table.insert(UnitDefPatch,SetMemory(0x65FEC8 + (Index*4),SetTo,0))
	end
	function EnermyNonBionic(Index)
	table.insert(NonBionicPatch,SetMemoryX(0x664080 + (Index*4),SetTo,0,0x10000))
	end
	function UnitSizePatch(Index,Value)
	table.insert(SizePatchArr,SetMemory(0x6617C8 + (Index*8),SetTo,(Value)+(Value*65536)))
	table.insert(SizePatchArr,SetMemory(0x6617CC + (Index*8),SetTo,(Value)+(Value*65536)))
	end
	for i = 34, 99 do
	EnermyNonBionic(i)
	end
	for i =0, 56 do
	SetTo0UnitDef(i)
	end
	
	for i = 37, 47 do
	ZergCreateSpeedPatch(i)
	end
	for i = 131, 149 do
	ZergCreateSpeedPatch(i)
	end
	
	for i = 1, 5 do
	UnitEnable(BanToken[i])
	end
	for i=1,6 do
	UnitEnable(GiveUnitID[i])
	end
	for i = 35,57 do
	ZergDefTypePatch(i)
	end
	for i = 131,152 do
	ZergDefTypePatch(i)
	end
	ZergDefTypePatch(59)
	ZergDefTypePatch(62)
	ZergDefTypePatch(103)
	ZergDefTypePatch(104)
	ZergDefTypePatch(186)
	UnitEnable(72)
	UnitEnable(83)
	UnitEnable(3)
	UnitEnable(8)
	UnitEnable(54)
	UnitEnable(53)
	UnitEnable(48)
	UnitEnable(52)
	UnitEnable(49)
	UnitEnable2(9)
	UnitEnable2(0)
	UnitEnable2(1)
	UnitEnable2(7)
	UnitEnable2(2)
	UnitEnable2(32)
	UnitEnable2(34)
	UnitEnable2(72)
	UnitEnable2(72)
	SetUnitClass(0)
	SetUnitClass(16)
	SetUnitClass(68)
	SetUnitClass(23)
	SetUnitClass(74)
	SetUnitClass(11)
	SetUnitClass(5)
	SetUnitClass(12)
	SetUnitClass(60)
	SetUnitClass(186)
	
	for i = 0, 227 do
		SetUnitAdvFlag(i,0x200000,0x200000)
	end
	
	
	table.insert(PatchArr2,SetMemoryX(0x6638C8, SetTo, MarCost,0xFFFF))
	table.insert(PatchArr2,SetMemoryX(0x66388C, SetTo, MarCost+GMCost,0xFFFF))
	table.insert(PatchArr2,SetMemoryX(0x6559CC, SetTo, AtkFactor*65536,0xFFFF0000))
	table.insert(PatchArr2,SetMemoryX(0x6559C0, SetTo, DefFactor,0xFFFF))
	table.insert(PatchArr2,SetMemoryX(0x6559DC, SetTo, SuFactor,0xFFFF))
	table.insert(PatchArr2,SetMemoryW(0x6559C0+(12*2), SetTo, QuaFactor))
	
	
	HondonPatchArr = {}
	function HondonPatch(FlingyID,TunRad)
		if TunRad ~= nil then
		table.insert(HondonPatchArr, SetMemoryB(0x6C9E20 + FlingyID,SetTo,TunRad))
		else 
			table.insert(HondonPatchArr, SetMemoryB(0x6C9E20 + FlingyID,SetTo,40))
		end
		table.insert(HondonPatchArr, SetMemoryB(0x6C9858 + FlingyID,SetTo,0))
		table.insert(HondonPatchArr, SetMemory(0x6C9930 + (FlingyID*4),SetTo,0))
		table.insert(HondonPatchArr, SetMemoryW(0x6C9C78 + (FlingyID*2),SetTo,4000))
		table.insert(HondonPatchArr, SetMemory(0x6C9EF8 + (FlingyID*4),SetTo,18000))
	end
	
	
	
	HondonPatch(75)
	HondonPatch(82)
	HondonPatch(70) -- 배틀
	HondonPatch(80)
	for j, k in pairs(HondonFlingyArr) do
		HondonPatch(k)
	end
	
	for i = 37,57 do
	UnitSizePatch(i,3)
	end
	for i = 60,81 do
	UnitSizePatch(i,5)
	end
	UnitSizePatch(103,5)
	UnitSizePatch(3,5)
	UnitSizePatch(5,1)
	UnitSizePatch(10,5)
	UnitSizePatch(15,5)
	UnitSizePatch(17,5)
	UnitSizePatch(19,5)
	UnitSizePatch(25,5)
	UnitSizePatch(32,4)
	UnitSizePatch(87,5)
	UnitSizePatch(89,5)
	
	Trigger { -- 퍼센트 데미지 세팅, 버튼셋
		players = {FP},
		actions = {
			SetMemory(0x515B88,SetTo,256);---------크기 0
			SetMemory(0x515B8C,SetTo,256);---------크기 1
			SetMemory(0x515B90,SetTo,256);---------크기 2
			SetMemory(0x515B94,SetTo,256);---------크기 3
			SetMemory(0x515B98,SetTo,256);---------크기 4
			SetMemory(0x515B9C,SetTo,256);---------크기 5
			SetMemory(0x515BA0,SetTo,256);---------크기 6
			SetMemory(0x515BA4,SetTo,256);---------크기 7
			SetMemory(0x515BA8,SetTo,256);---------크기 8
			SetMemory(0x515BAC,SetTo,256);---------크기 9
			SetMemory(0x515BB0,SetTo,256);
			SetMemory(0x515BB4,SetTo,256);
			SetMemory(0x515BB8,SetTo,256+256);
			SetMemory(0x515BBC,SetTo,256);
			SetMemory(0x515BC0,SetTo,256);
			SetMemory(0x515BC4,SetTo,256);
			SetMemory(0x515BC8,SetTo,256);
			SetMemory(0x515BCC,SetTo,256);
			SetMemory(0x515BD0,SetTo,256);
			SetMemory(0x515BD4,SetTo,256);		
			--SetMemory(0x5188AC, SetTo, 5339096);
			--SetMemory(0x518C9C, SetTo, 5339096);		
			--SetMemory(0x5188A8, SetTo, 6);
			--SetMemory(0x518C98, SetTo, 6);
		},
		}

	--Include V
	CurrentArr = CreateVar()
	BackupPosData = CreateVar()
	BackupCP = CreateVar()
	ForArr = CreateVar()
	Dx = CreateVar()
	Dy = CreateVar()
	Dt = CreateVar()
	Dv = CreateVar()
	Du = CreateVar()
	CUnit2 = CreateVar()
	CUnit3 = CreateVar()
	Speed = CreateVar()
	BGMCP = CreateVar()
	ExchangeRate = CreateVar()
	ExrateBackup = CreateVar()
	GunCUnit = CreateVar()
	WhileLaunch = CreateVar()
	MemoryPtrCP = CreateVar()
	SetPlayers = CreateVar()
	SelCP = CreateVar()
	PosSavePtr = CreateVar()
	HeroTxtStrPtr = CreateVar()
	HIndex = CreateVar()
	HPoint = CreateVar()
	HPoint10 = CreateVar()
	HIndex2 = CreateVar()
	InfArmorFactor = CreateVar()
	InfWeaponFactor = CreateVar()
	UPCompStrPtr = CreateVar()
	UpgradeCP = CreateVar()
	UpgradeFactor = CreateVar()
	TempUpgradePtr = CreateVar()
	TempUpgradeMaskRet = CreateVar()
	DisGun = CreateVar()
	BdIndex = CreateVar()
	Nextptrs = CreateVar()
	Gun_HS = CreateVar()
	UnitIDV = CreateVar()
	CryUID= CreateVar()
	CurrentMode = CreateVar()
	CurrentBGM = CreateVar()
	UnitIDV1 = CreateVar()
	UnitIDV2 = CreateVar()
	UnitIDV3 = CreateVar()
	UnitIDV4 = CreateVar()
	MarHP = CreateVar()
	MarUpData = CreateVar()
	InputMarUpData = CreateVar()
	Gun_Y = CreateVar()
	Gun_X = CreateVar()
	Gun_A = CreateVar()
	Gun_R = CreateVar()
	Gun_V = CreateVar()
	Gun_Temp = CreateVar()
	Gun_TempPos =  CreateVar()
	Gun_W = CreateVar()
	Gun_UID = CreateVar()
	Gun_UID2 = CreateVar()
	Gun_UID3 = CreateVar()
	Gun_UID4 = CreateVar()
	CocoonValue = CreateVar()
	CocoonValue2 = CreateVar()
	Gun_TempPosX =  CreateVar()
	Gun_TempPosY =  CreateVar()
	UpgradeMax = CreateVar()
	RepHeroIndex = CreateVar()
	Gun_Level = CreateVar()
	Gun_W2 = CreateVar()
	Gun_SetLocChunkX = CreateVar()
	Gun_SetLocChunkY = CreateVar()
	Gun_LocChunkCheck = CreateVar()
	ChunkChecksum  = CreateVar()
	CCY  = CreateVar()
	CCX = CreateVar()
	CocoonUID = CreateVar()
	CurrentChunk = CreateVar()
	B10_Cond = CreateVar()
	LocChunkPosCheck =CreateVar()
	B11_Level = CreateVar()
	UnitIDVOvr = CreateVar()
	UnitIDVDis = CreateVar()
	Cell_R = CreateVar()
	Cell_A = CreateVar()
	B1_Calc = CreateVar()
	Boss1_H = CreateVar()
	CBY = CreateVar()
	CBX = CreateVar()
	CBAngle = CreateVar()
	CBHeight = CreateVar()
	CBUnitId = CreateVar()
	Locs = CreateVar()
	B1_U = CreateVar()
	B1_D = CreateVar()
	B1_E = CreateVar()
	B1_C = CreateVar()
	B1_X = CreateVar()
	B1_Y = CreateVar()
	B1_A = CreateVar()
	CurrentFactor = CreateVar()
	CurrentUpgrade = CreateVar()
	UpCount = CreateVar()
	B1_F = CreateVar()
	GunBoss_UID = CreateVar()
	ExchangeRateT = CreateVar()
	PaneltyPointT = CreateVar()
	PaneltyPoint = CreateVar()
	count = CreateVar()
	CanC = CreateVar()
	TBossSkill = CreateVar()
	TBossHP = CreateVar()
	TBossHPPtr = CreateVar()
	TBossHPTemp = CreateVar()
	TB_X = CreateVar()
	TB_Y = CreateVar()
	TB_A = CreateVar()
	DBossD = CreateVar()
	DBossU = CreateVar()
	DBossR = CreateVar()
	DBossA = CreateVar()
	DBossX = CreateVar()
	DBossY = CreateVar()
	RepX = CreateVar()
	RepY = CreateVar()
	RepY = CreateVar()
	HondonMode = CreateVar()
	AtkSpeedMode = CreateVar()
	DBossPlaguePatch = CreateVar()
	HiddenHP = CreateVar()
	HiddenATK = CreateVar()
	HiddenPts = CreateVar()
	HiddenHPM = CreateVar()
	HiddenATKM = CreateVar()
	HiddenPtsM = CreateVar()
	HiddenModeStrPtr = CreateVar()
	HPointVar = CreateVar()
	AtkUpMax = CreateVar()
	UpgradeAv = CreateVar()
	CanDefeat = CreateVar()
	f_GunUID = CreateVar()
	G_TempH = CreateVar(FP)
	G_InputH = CreateVar(FP) --{"X",0x500,0x15C,1,0}
	G_CA = CreateVar(FP)
	f_GunStrPtr = CreateVar(FP)
	MarSh = CreateVar(FP)
	DefStrPtr = CreateVarArr(6,FP)
	BPosX,BPosY,AngleA,TempEPD,TempA,TempT,LocsA,CB_TempH = CreateVars(8)
	CBullet_InputH = CreateVar(FP)
	CBullet_ArrTemp = CreateVar(FP)
	B_CA_Angle = CreateVar(FP)
	--Include CCode
	BGMType = CreateCcode()
	LeaderBoardT = CreateCcode()
	GMode = CreateCcode()
	PaneltyP = CreateCcode()
	BonusP = CreateCcode()
	GiveRate = CreateCcodeArr(6)
	Test1 = CreateCcode()
	ModeO = CreateCcode()
	ModeT = CreateCcode()
	LimitC = CreateCcode()
	LimitX = CreateCcode()
	TestMode = CreateCcode()
	B_P = CreateCcode()
	BanCode = CreateCcodeArr(5) -- 18~23
	ModeT2 = CreateCcode()
	ModeSel = CreateCcode()
	BGMMode = CreateCcode()
	BGMSel = CreateCcode()
	SelectorT = CreateCcode()
	HealT = CreateCcode()
	CocoonLaunch = CreateCcode()
	IntroT = CreateCcode()
	LairHiveSpawnId = CreateCcode()
	SymbolCheck = CreateCcode()
	Chry_cond = CreateCcode()
	ScanEffT = CreateCcode()
	FormCon = CreateCcode()
	GunBossAct = CreateCcode()
	GunBossT = CreateCcode()
	GunBossT2 = CreateCcode()
	B_Chry_cond = CreateCcode()
	Py_Cond = CreateCcode()
	Sup_Cond = CreateCcode()
	BossKill = CreateCcode()
	SPGunCond = CreateCcode()
	Win = CreateCcode()
	CanCT = CreateCcode()
	Print13 = CreateCcode()
	GameOver = CreateCcode()
	CUnitFlag = CreateCcode()
	ExchangeRateTMinusFlag = CreateCcode()
	GunBossT3 = CreateCcode()
	DBossGen = CreateCcode()
	HMDeaths = CreateCcodeArr(6)
	DoWhileCon = CreateCcode()
	--LairCCodeId = Ccode(0x1001,--)
	--HiveCCodeId = Ccode(0x1002,--)
	HiddenMode = CreateCcode()
	KeyToggle = CreateCcode()
	Toggle1 = CreateCcode()
	ToggleSound = CreateCcode()
	ToggleA = CreateCcode()
	Toggle2 = CreateCcode()
	ToggleS = CreateCcode()
	Toggle3 = CreateCcode()
	ToggleD = CreateCcode()
	TGiveforCoCoon = CreateCcode()
	CocoonGunCon = CreateCcode()
	ifUpisAtk = CreateCcode()
	WaveT = CreateCcode()
	MarMode = CreateCcode()
	NBMode = CreateCcode()
	LV_10_UnitTableCode = CreateCcode()
	LV_11_UnitTableCode = CreateCcode()
	OverCocooncomp = CreateCcode()
	CanOut = CreateCcode()
	ToggleHondon = CreateCcode()
	ToggleAtkSp = CreateCcode()
	ZombieCheck = CreateCcode()
	Die_SEC = CreateCcode()
	SoundLimitT = CreateCcode()
	SoundLimit = CreateCcode()
	BossStart = CreateCcode()
	HiddenEnable = CreateCcode()
	Sel_G = CreateCcode()
	isSingle = CreateCcode()
	f_GunSendStrPtr = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	f_GunNum = CreateVar(FP)
	BSkillT = CreateCcodeArr(6)
	BSkillT2 = CreateCcodeArr(6)
	BSkillT3 = CreateCcodeArr(6)
	QSkillT = CreateCcodeArr(6)
	QSkillT2 = CreateCcodeArr(6)
	QSkillT3 = CreateCcodeArr(6)
	OneStim = CreateCcodeArr(6)
	SuStrPtr = CreateVarArr(6,FP)
	TeStrPtr = CreateVarArr(6,FP)
	QuaStrPtr = CreateVarArr(6,FP)
	function Objects()
	CVariable(AllPlayers,0x1000)
	CVariable(AllPlayers,0x1001)
	CVariable(AllPlayers,0x1002)
	for i=0x300, 0x350 do
	CVariable(FP,i) -- 
	end

	for i=0x400, 0x400+64 do -- CoCoonChecksumV
	CVariable(FP,i) -- 
	end

	CocoonVarr = GetVArray(V(0x400))
	Str00 = CArray(FP,50)
	Str01 = CArray(FP,50)
	Str02 = CArray(FP,50)
	Str04 = CArray(FP,50)
	Str10 = CArray(FP,50)
	Str11 = CArray(FP,50)
	Str12 = CArray(FP,50)
	Str13 = CArray(FP,50)
	Str14 = CArray(FP,50)
	Str15 = CArray(FP,50)
	Str16 = CArray(FP,50)
	Str17 = CArray(FP,50)
	Str18 = CArray(FP,50)
	Str19 = CArray(FP,50)
	Str20 = CArray(FP,50)
	Str21 = CArray(FP,50)
	Str22 = CArray(FP,50)
	Str23 = CArray(FP,50)
	Str24 = CArray(FP,50)

--	GunPtrMemoryVO = f_GetVoidptr(FP,100*4)
--	RepUnitPtrVO = f_GetVoidptr(FP,1700*4)

	GunPtrMemory = CreateVar(FP)
	RepUnitPtr = CreateVar(FP)
	HiddenModeT = CVArray(FP,20)
	f_GunNumT = CVArray(FP,5)
	CA2ArrX = CVArray(FP,1700)
	CA2ArrY = CVArray(FP,1700)
	CA2ArrZ = CVArray(FP,1700)
	MultiCon = CreateCcode()
	Str25 = {}
	Str26 = {}
	Str27 = {}
	Str28 = {}
	for i = 0, 3 do
	table.insert(Str25,CArray(FP,50))
	table.insert(Str26,CArray(FP,50))
	end
	for i = 0, 4 do
	table.insert(Str28,CArray(FP,50))
	end
	for i = 0, 10 do
	table.insert(Str27,CArray(FP,50))
	end
	UArr3 = CVArray(FP,30)
	ZUnitLairArr = CVArray(FP,4)
	ZUnitHiveArr = CVArray(FP,4)
	UpCompTxt = CVArray(FP,5)
	UpCompRet = CVArray(FP,5)
	HPointT = CVArray(FP,5)
	UArr1 = CVArray(FP,16)
	UArr2 = CVArray(FP,16)
	LocChunkVArr = CVArray(FP,64)
	function Create_VoidEPDHeaderV(Player,Size)
		local Void = f_GetVoidptr(Player,Size)
		local Header =  CreateVar(Player)
		table.insert(CtrigInitArr[Player+1],SetCtrigX(Header[1],Header[2],0x15C,Header[3],SetTo,Void[1],Void[2],Void[3],1,Void[4]))
		return Header
	end
	CreateUnitStackUIDArr = Create_VoidEPDHeaderV(FP,4*10)
	CreateUnitStackXPosArr = Create_VoidEPDHeaderV(FP,4*10)
	CreateUnitStackYPosArr = Create_VoidEPDHeaderV(FP,4*10)
	CreateUnitStackPtr = CreateVar(FP)
	for i = 0, 5 do
	Str03[i+1] = CArray(FP,50)
	Names[i+1] = CVArray(FP,7)
	end
	end
end


function onPluginStart()
	
CIfOnce(AllPlayers,{CDeaths(FP,AtLeast,1,ModeO)},{ModifyUnitEnergy(All,"Any unit",AllPlayers,64,100)}) -- onPluginStart
CIf(FP,CDeaths(FP,Exactly,0,BGMMode))
CMov(FP,_Ccode(FP,BGMMode),_Mod(_Rand(),#BModeTArr),1)
CIfEnd()

NBT = {}
MarModePatch = {}
for i = 0, 5 do
	table.insert(NBT,SetMemoryB(0x57F27C+(228*i)+125,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
	table.insert(MarModePatch,SetMemoryB(0x57F27C+(228*i)+19,SetTo,0)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
	table.insert(MarModePatch,SetMemoryB(0x57F27C+(228*i)+54,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
	table.insert(MarModePatch,SetMemoryB(0x57F27C+(228*i)+8,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
	
	

end
table.insert(MarModePatch,SetCDeaths(FP,SetTo,1,MultiCon)) 
table.insert(MarModePatch,SetSwitch("Switch 211",Set)) 



for i = 0, 5 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],AtMost,0);

		},
	actions = {
		SetMemory(0x582144 + (i*4),SetTo,2000);
		SetMemory(0x5821A4 + (i*4),SetTo,2000);
		}
		}
	end

Trigger { -- 컴퓨터 플레이어 색상 설정
	players = {FP},
	conditions = {
		Always();
	},
	actions = {
SetMemoryX(0x581DA4,SetTo,59*65536,0xFF0000), --P7 컬러
	SetMemoryX(0x581DDC,SetTo,59*1,0xFF); --P7 미니맵 
SetMemoryX(0x581DAC,SetTo,166*65536,0xFF0000), --P8컬러
SetMemoryX(0x581DDC,SetTo,166*256,0xFF00); --P8 미니맵
		--[[
		SetMemoryX(0x581DDC,SetTo,0*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DA4,SetTo,0*65536,0xFF0000), --P7 컬러
		SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8컬러
]]
		
},
}
DoActions(FP,{
	
SetMemoryB(0x57F27C+(228*0)+54,SetTo,0);
SetMemoryB(0x57F27C+(228*1)+54,SetTo,0);
SetMemoryB(0x57F27C+(228*2)+54,SetTo,0);
SetMemoryB(0x57F27C+(228*3)+54,SetTo,0);
SetMemoryB(0x57F27C+(228*4)+54,SetTo,0);
SetMemoryB(0x57F27C+(228*5)+54,SetTo,0);
})

TriggerX(FP,{CDeaths(FP,AtLeast,1,MarMode)},MarModePatch)


CIf(FP,CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode))
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],Exactly,0);
		CVar(FP,HiddenHP[2],Exactly,0);
		CVar(FP,HiddenATK[2],Exactly,0);
		CVar(FP,HiddenPtsM[2],Exactly,0);
		CVar(FP,HiddenHPM[2],Exactly,0);
		CVar(FP,HiddenATKM[2],Exactly,0);
		CVar(FP,HondonMode[2],Exactly,0);
		CVar(FP,AtkSpeedMode[2],Exactly,0);
		
	},
	actions = {
		SetCDeaths(FP,SetTo,0,HiddenMode);
	}
}




for i = 1, 5 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],Exactly,i);
	},
	actions = {
		SetCVar(FP,HPointVar[2],SetTo,HPointFactor+(((HPointFactor*5)/4)*i));
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPtsM[2],Exactly,i);
	},
	actions = {
		SetCVar(FP,HPointVar[2],SetTo,HPointFactor-(i*(HPointFactor/5)));
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenHP[2],Exactly,i);
	},
	actions = {
		SetMemory(0x662350 + (4*0), Add, i*16000*256);
		SetMemoryW(0x660E00 + (2*0), Add, i*8000);

		
		SetMemory(0x662350 + (4*16), Add, i*12000*256);
		SetMemoryW(0x660E00 + (2*16), Add, i*4000);


		SetMemoryW(0x660E00 + (2*12), Add, i*2000);
		SetMemory(0x662350 + (4*12), Add, i*22000*256);
		SetMemory(0x662350 + (4*60), Add, i*134217*256);
	}
}

--Trigger {
--	players = {FP},
--	conditions = {
--		Label(0);
--		CVar(FP,HiddenHPM[2],Exactly,i);
--	},
--	actions = {
--		SetMemory(0x662350 + (4*12), Subtract, i*8000*256);
--		SetMemory(0x662350 + (4*60), Subtract, i*26843*256);
--		SetMemory(0x662350 + (4*0), Subtract, i*4000*256);
--		SetMemory(0x662350 + (4*16), Subtract, i*2000*256);
--		SetMemoryW(0x660E00 + (2*0), Subtract, i*4000);
--		SetMemoryW(0x660E00 + (2*16), Subtract, i*2000);
--		SetMemoryW(0x660E00 + (2*12), Subtract, i*8000);
--		SetMemoryW(0x660E00 + (2*60), Subtract, i*8000);
--	}
--}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATK[2],Exactly,i);
	},
	actions = {		
		SetMemoryX(0x656F98, Add, i*32*65536,0xFFFF0000);--기본공
		SetMemoryX(0x657760, Add, i*4*65536,0xFFFF0000);--계수
		SetMemoryX(0x656F9C, Add, i*72,0xFFFF);
		SetMemoryX(0x657764, Add, i*7,0xFFFF);
		SetMemoryX(0x656EB0, Add, i*32*65536,0xFFFF0000);--
		SetMemoryX(0x657678, Add, i*3*65536,0xFFFF0000);--
		SetMemoryX(0x656EB0, Add, i*120,0xFFFF);--
		SetMemoryX(0x657678, Add, i*16,0xFFFF);--
		SetMemoryW(0x657678+(2*2),Add,8*i);
		SetMemoryW(0x656EB0+(2*2),Add,204*i);
		SetMemoryW(0x657678+(122*2),Add,16*i);
		SetMemoryW(0x656EB0+(122*2),Add,800*i);
		SetMemoryW(0x656EB0+(92*2),Add,277*i);
		SetMemoryW(0x657678+(92*2),Add,40*i);
		SetMemoryW(0x657678+(93*2),Add,36*i);
		
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATKM[2],Exactly,i);
	},
	actions = {
		SetCVar(FP,AtkUpMax[2],SetTo,50+(200-(40*i)));
		
		SetMemoryB(0x58D088+(0*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(1*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(2*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(3*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(4*46)+7,SetTo,50+(200-(40*i)));
		SetMemoryB(0x58D088+(5*46)+7,SetTo,50+(200-(40*i)));

--		SetMemoryB(0x58D088+(0*46)+14,SetTo,50+(200-(40*i)));
--		SetMemoryB(0x58D088+(1*46)+14,SetTo,50+(200-(40*i)));
--		SetMemoryB(0x58D088+(2*46)+14,SetTo,50+(200-(40*i)));
--		SetMemoryB(0x58D088+(3*46)+14,SetTo,50+(200-(40*i)));
--		SetMemoryB(0x58D088+(4*46)+14,SetTo,50+(200-(40*i)));
--		SetMemoryB(0x58D088+(5*46)+14,SetTo,50+(200-(40*i)));
	}
}

end
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode);
		CVar(FP,HondonMode[2],AtMost,0);
	},
	actions = {
		SetMemoryX(0x581DDC,SetTo,0*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DA4,SetTo,0*65536,0xFF0000), --P7 컬러
		SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8컬러
	}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenPts[2],AtLeast,1);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,HiddenEnable);
	}
}

CIf(FP,CVar(FP,HondonMode[2],AtLeast,1))

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode);
		CVar(FP,HondonMode[2],AtLeast,1);
	},
	actions = {
		SetMemoryX(0x581DDC,SetTo,14*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 미니맵
		SetMemoryX(0x581DA4,SetTo,14*65536,0xFF0000), --P7 컬러
		SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8컬러
	}
}

table.insert( HondonPatchArr,SetMemoryX(0x6566E4, SetTo, 65536*2,0xFF0000))
table.insert( HondonPatchArr,SetMemory(0x656A88, SetTo, 0))
table.insert( HondonPatchArr,SetMemoryX(0x656714, SetTo, 3,0xFF))
table.insert( HondonPatchArr,SetMemoryX(0x656EE8, SetTo, 530,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x656FD4, SetTo, 1,0xFF))
table.insert( HondonPatchArr,SetMemoryX(0x656894, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x6570D4, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x65778C, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x65692C, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x65716C, SetTo, 256,0xFFFF))
table.insert( HondonPatchArr,SetMemoryX(0x657824, SetTo, 256,0xFFFF))

DoActions2(FP,HondonPatchArr)


CIfEnd()

CIfEnd()

TriggerX(FP,{CDeaths(FP,AtLeast,1,isSingle)},{
SetMemoryX(0x581DAC,SetTo,51*65536,0xFF0000), --P8컬러
SetMemoryX(0x581DDC,SetTo,51*256,0xFF00); --P8 미니맵
SetMemoryB(0x57F27C+(228*0)+54,SetTo,1);
SetMemoryB(0x57F27C+(228*1)+54,SetTo,1);
SetMemoryB(0x57F27C+(228*2)+54,SetTo,1);
SetMemoryB(0x57F27C+(228*3)+54,SetTo,1);
SetMemoryB(0x57F27C+(228*4)+54,SetTo,1);
SetMemoryB(0x57F27C+(228*5)+54,SetTo,1);
})
TriggerX(FP,{},{
})


NWhile(FP,{Bring(FP,AtLeast,1,217,64)})
TriggerX(FP,CDeaths(FP,Exactly,0,NBMode),{MoveLocation(1,217,FP,64),GiveUnits(1,217,FP,1,8),RemoveUnit(217,8),
CreateUnit(2,48,1,6),
CreateUnit(3,51,1,7),
CreateUnit(2,53,1,6),
CreateUnit(1,54,1,7),
CreateUnit(1,55,1,7),
CreateUnit(1,56,1,7),
CreateUnit(1,104,1,6),},{preserved})

TriggerX(FP,CDeaths(FP,Exactly,1,NBMode),{MoveLocation(1,217,FP,64),GiveUnits(1,217,FP,1,8),RemoveUnit(217,8),
CreateUnit(1,48,1,6),
CreateUnit(1,53,1,6),
CreateUnit(1,54,1,7),
CreateUnit(1,55,1,7),
},{preserved})

NWhileEnd()


CMov(FP,0x6509B0,RepUnitPtr)
CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))

f_SaveCp()

f_Read(FP,BackupCP,CPosX,"X",0xFFF)
f_Read(FP,BackupCP,CPosY,"X",0xFFF000)
f_Div(FP,CPosY,0x1000)
f_Read(FP,BackupCP,RepHeroIndex,"X",0xFF000000)
CDoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,0),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,0),
TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
TCreateUnit(1,_Div(RepHeroIndex,_Mov(0x1000000)),1,_Add(_Mod(_Rand(),_Mov(2)),_Mov(6)))
})
f_LoadCp()
CAdd(FP,0x6509B0,1)
CWhileEnd()
CMov(FP,0x6509B0,FP)
TriggerX(FP,{CDeaths(FP,AtLeast,1,NBMode)},{KillUnit(125,AllPlayers),KillUnit(125,P12),NBT,SetMemoryX(0x6636F8, SetTo, 130*16777216,0xFF000000);})

for i = 1,3 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,i,GMode);
	},
	actions = {
		SetCVar(FP,B11_Level[2],SetTo,4-i);
	}
}
end
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,GMode);
	},
	actions = {
		SetMemoryX(0x660EC8, SetTo, 9999,0xFFFF);
		SetMemoryX(0x664814, SetTo, 255,0xFF);
		SetCDeaths(FP,Add,2,SPGunCond);
		SetCVar(FP,CanC[2],Add,6);
	}
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,GMode);
	},
	actions = {
		SetMemoryX(0x660EC8, SetTo, 5000,0xFFFF);
		SetMemoryX(0x664814, SetTo, 255,0xFF);
	}
}
CIf(FP,{CD(MarMode,0)})
Ex1 = {}
Ex2 = {}
Ex3 = {}
for i = 0, 5 do
table.insert(Ex1,EasyEx1P+(ExRate*i))
table.insert(Ex2,HDEx1P+(ExRate*i))
table.insert(Ex3,BurEx1P+(ExRate*i))
end

for i=1, 6 do -- 이지난이도
DoActions(FP,{SetSwitch("Switch 2",Random),SetSwitch("Switch 3",Random),SetSwitch("Switch 4",Random),SetSwitch("Switch 5",Random)})
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x0EEASY \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex1[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger2X(FP,{
	CDeaths(FP,Exactly,1,GMode);
	Bring(AllPlayers,Exactly,i,111,"Anywhere");
},{
	RotatePlayer({SetMissionObjectives(MOText);},MapPlayers,FP);
	SetCVar(FP,ExchangeRate[2],SetTo,Ex1[i]);
	SetCVar(FP,ExrateBackup[2],SetTo,Ex1[i]);
})
end
for i=1, 6 do -- 하드 난이도
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x08HARD \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex2[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger2X(FP,{
	CDeaths(FP,Exactly,2,GMode);
	Bring(AllPlayers,Exactly,i,111,"Anywhere");
},{
	RotatePlayer({SetMissionObjectives(MOText);},MapPlayers,FP);
	SetCVar(FP,ExchangeRate[2],SetTo,Ex2[i]);
	SetCVar(FP,ExrateBackup[2],SetTo,Ex2[i]);
})
end
for i=1, 6 do -- 버스트 난이도
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x1FBURST \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex3[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger2X(FP,{
	CDeaths(FP,Exactly,3,GMode);
	Bring(AllPlayers,Exactly,i,111,"Anywhere");
},{
	RotatePlayer({SetMissionObjectives(MOText);},MapPlayers,FP);
	SetCVar(FP,ExchangeRate[2],SetTo,Ex3[i]);
	SetCVar(FP,ExrateBackup[2],SetTo,Ex3[i]);
})
end
CIfEnd()

CIf(FP,{CD(MarMode,1)})
Ex1 = {}
Ex2 = {}
Ex3 = {}
for i = 0, 5 do
table.insert(Ex1,EasyEx1P2+(ExRate2*i))
table.insert(Ex2,HDEx1P2+(ExRate2*i))
table.insert(Ex3,BurEx1P2+(ExRate2*i))
end

for i=1, 6 do -- 이지난이도
DoActions(FP,{SetSwitch("Switch 2",Random),SetSwitch("Switch 3",Random),SetSwitch("Switch 4",Random),SetSwitch("Switch 5",Random)})
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x0EEASY \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex1[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger2X(FP,{
	CDeaths(FP,Exactly,1,GMode);
	Bring(AllPlayers,Exactly,i,111,"Anywhere");
},{
	RotatePlayer({SetMissionObjectives(MOText);},MapPlayers,FP);
	SetCVar(FP,ExchangeRate[2],SetTo,Ex1[i]);
	SetCVar(FP,ExrateBackup[2],SetTo,Ex1[i]);
})
end
for i=1, 6 do -- 하드 난이도
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x08HARD \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex2[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger2X(FP,{
	CDeaths(FP,Exactly,2,GMode);
	Bring(AllPlayers,Exactly,i,111,"Anywhere");
},{
	RotatePlayer({SetMissionObjectives(MOText);},MapPlayers,FP);
	SetCVar(FP,ExchangeRate[2],SetTo,Ex2[i]);
	SetCVar(FP,ExrateBackup[2],SetTo,Ex2[i]);
})
end
for i=1, 6 do -- 버스트 난이도
MOText = "\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04.2 : \x1FRE\n\x13\x1FBURST \x04MODE\n\x13\x04\x08"..i.."인 \x04플레이 중입니다.\n\x13\x0E시작 환전률 : "..(Ex3[i]/10).."%\n\x13\x07==================\n\x13\x04Special Thanks to\n\x13\x04CheezeNacho, Ninfia, Balex, Marine_TOPCLASS\n\x13Hybrid)_GOD60, snrnfkrh"
Trigger2X(FP,{
	CDeaths(FP,Exactly,3,GMode);
	Bring(AllPlayers,Exactly,i,111,"Anywhere");
},{
	RotatePlayer({SetMissionObjectives(MOText);},MapPlayers,FP);
	SetCVar(FP,ExchangeRate[2],SetTo,Ex3[i]);
	SetCVar(FP,ExrateBackup[2],SetTo,Ex3[i]);
})
end
CIfEnd()
Trigger { -- 배속방지
	players = {FP},
	conditions = {
		Memory(0x51CE84,AtLeast,1001);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,0);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,1);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,2);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,3);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,4);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,5);
		DisplayText("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4);
		Victory();
		SetMemory(0x6509B0,SetTo,FP);
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*6,Exactly,0,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*7,Exactly,0,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*6,Exactly,2,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57EEE8 + 36*7,Exactly,2,0xFF);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57efc0,AtLeast,1*256,0xFF00);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}
Trigger { -- 게임오버
	players = {Force1},
	conditions = {
		MemoryX(0x57efe4,AtLeast,1*256,0xFF00);
	},
	actions = {
		PlayWAV("sound\\Misc\\TPwrDown.wav");
		DisplayText("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.",4);
		Defeat();
	}
	}

Trigger { -- 
players = {Force2},
conditions = {
},
actions = {
	RunAIScriptAt("Expansion Zerg Campaign Insane","AIZone");
	SetResources(CurrentPlayer,SetTo,0x10000000,OreAndGas);
	
},
}
Trigger { -- 저그인구수세팅
players = {FP},
conditions = {
},
actions = {
	SetMemory(0x582144+(6*4),SetTo,2000);
	SetMemory(0x5821A4+(6*4),SetTo,2000);
	SetMemory(0x582144+(7*4),SetTo,2000);
	SetMemory(0x5821A4+(7*4),SetTo,2000);
	
	
},
}
Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		GiveUnits(All,132,P8,4,0);
		GiveUnits(All,132,P8,5,0);
		GiveUnits(All,133,P8,4,0);
		GiveUnits(All,133,P8,5,0);
		GiveUnits(All,132,P8,6,1);
		GiveUnits(All,133,P8,6,1);
		GiveUnits(All,132,P8,7,2);
		GiveUnits(All,133,P8,7,2);
		GiveUnits(All,132,P8,8,3);
		GiveUnits(All,133,P8,8,3);
		GiveUnits(All,132,P8,9,4);
		GiveUnits(All,133,P8,9,4);
		GiveUnits(All,132,P8,10,5);
		GiveUnits(All,133,P8,10,5);
		GiveUnits(All,132,P8,11,6);
		GiveUnits(All,133,P8,11,6);
		GiveUnits(All,132,P8,12,7);
		GiveUnits(All,133,P8,12,7);
		GiveUnits(All,132,P8,13,8);
		GiveUnits(All,133,P8,13,8);
		GiveUnits(All,132,P8,14,9);
		GiveUnits(All,133,P8,14,9);
		GiveUnits(All,132,P8,15,10);
		GiveUnits(All,133,P8,15,10);
		GiveUnits(All,132,P7,15,11);
		GiveUnits(All,133,P7,15,11);
		RemoveUnit("Larva",Force2);
	}
	}



CMov(FP,0x6509B0,19025+25)
CWhile(FP,Memory(0x6509B0,AtMost,19025 + (84*1699)+25))

MoveCp("X",25*4)
function CUnit_PlacedUnitHP(Index,Amount)
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,Index,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,23*4);
		SetDeaths(CurrentPlayer,SetTo,Amount*256,0);
		MoveCp(Add,23*4);
		PreserveTrigger();
	}
}
end

CUnit_PlacedUnitHP(3,400000)
CUnit_PlacedUnitHP(23,500000)
CUnit_PlacedUnitHP(74,666666)
CUnit_PlacedUnitHP(29,200000)
CUnit_PlacedUnitHP(15,46322)
CUnit_PlacedUnitHP(77,46322)
CUnit_PlacedUnitHP(78,46322)
CUnit_PlacedUnitHP(21,46322)
CUnit_PlacedUnitHP(80,46322)
CUnit_PlacedUnitHP(25,46322)
CUnit_PlacedUnitHP(17,46322)
CUnit_PlacedUnitHP(76,46322)
CUnit_PlacedUnitHP(86,46322)
CUnit_PlacedUnitHP(28,46322)
CUnit_PlacedUnitHP(75,46322)
CUnit_PlacedUnitHP(52,50000)
CUnit_PlacedUnitHP(27,100000)
CUnit_PlacedUnitHP(98,100000)
CUnit_PlacedUnitHP(10,100000)
CUnit_PlacedUnitHP(32,300000)
CUnit_PlacedUnitHP(19,100000)
CUnit_PlacedUnitHP(65,100000)
CUnit_PlacedUnitHP(66,100000)
CUnit_PlacedUnitHP(68,999999)
CUnit_PlacedUnitHP(88,120000)
CUnit_PlacedUnitHP(219,666666)


CIfX(FP,TTOR({
DeathsX(CurrentPlayer,Exactly,216,0,0xFF),
DeathsX(CurrentPlayer,Exactly,190,0,0xFF),
DeathsX(CurrentPlayer,Exactly,147,0,0xFF),
DeathsX(CurrentPlayer,Exactly,156,0,0xFF),
DeathsX(CurrentPlayer,Exactly,109,0,0xFF),
DeathsX(CurrentPlayer,Exactly,148,0,0xFF),
DeathsX(CurrentPlayer,Exactly,173,0,0xFF),
DeathsX(CurrentPlayer,Exactly,201,0,0xFF),
DeathsX(CurrentPlayer,Exactly,175,0,0xFF),
DeathsX(CurrentPlayer,Exactly,152,0,0xFF),
DeathsX(CurrentPlayer,Exactly,151,0,0xFF),
}))
DoActions(FP,{
MoveCp(Add,0xDC-0x64),
SetDeathsX(CurrentPlayer,SetTo,0xB00,0,0xB00),
MoveCp(Subtract,0xDC-0x94),
SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000),
MoveCp(Add,0xE4-0x94),
SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFFFFFF),
MoveCp(Subtract,0xE4-0x64)})
CIfXEnd()



CIf(FP,{DeathsX(CurrentPlayer,Exactly,132,0,0xFF)})
DoActions(FP,MoveCp(Subtract,6*4))
for i=0, 11 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,i,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,i*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		SetCDeaths(FP,Add,1,Ccode(0x1001,i));
		PreserveTrigger();
	}
	}
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

CIf(FP,{DeathsX(CurrentPlayer,Exactly,133,0,0xFF)})
DoActions(FP,MoveCp(Subtract,6*4))
for i=0, 11 do
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,i,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,i*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		SetCDeaths(FP,Add,1,Ccode(0x1002,i));
		PreserveTrigger();
	}
	}
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()


CIf(FP,DeathsX(CurrentPlayer,Exactly,216,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,7,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,1*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		PreserveTrigger();
	}
	}
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

CIf(FP,DeathsX(CurrentPlayer,Exactly,152,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
Trigger {
	players = {FP},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,7,0,0xFF);
	},
	actions = {
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,1*0x10000,0,0xFF0000);
		MoveCp(Add,10*4);
		PreserveTrigger();
	}
	}
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

DoActions(FP,MoveCp(Subtract,6*4))
DeathUnitJump = def_sIndex()
NJump(FP,DeathUnitJump,DeathsX(CurrentPlayer,AtMost,0,0,0xFF00))
DoActions(FP,MoveCp(Add,6*4))
OrCondForHeroArr = {}
for i = 1, #HeroIndexArr do
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,HeroIndexArr[i],0,0xFF))
end
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,162,0,0xFF))
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,176,0,0xFF))
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,177,0,0xFF))
table.insert(OrCondForHeroArr,DeathsX(CurrentPlayer,Exactly,178,0,0xFF))
CIf(FP,TTOR(OrCondForHeroArr))
DoActions(FP,{MoveCp(Subtract,16*4),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xff0000),MoveCp(Add,16*4)})
CIfEnd()
DoActions(FP,MoveCp(Subtract,6*4))
NJumpEnd(FP,DeathUnitJump)
DoActions(FP,MoveCp(Add,6*4))

CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)









DoActions(FP,{GiveUnits(All,132,AllPlayers,"Anywhere",6),GiveUnits(All,133,AllPlayers,"Anywhere",7)})
GiveTable ={}
for i = 0, 11 do
table.insert(GiveTable,GiveUnits(All,132,i,"Anywhere",6))
table.insert(GiveTable,GiveUnits(All,133,i,"Anywhere",7))
end
DoActions2(FP,GiveTable,1)
SetRecoverCp()
RecoverCp(FP)
CIfEnd() -- OnpluginStartEnd
end
