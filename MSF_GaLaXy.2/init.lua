function onInit()
	RandSwitch = "Switch 1"
	_0D = string.rep("\x0D",200)
	BanToken = {84,69,70,60,71}
	GiveUnitID = {64,65,66,67,61,63}
	XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0","\x08#X_MAX"}
	SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4,0x1}
	GiveRate2 = {1000, 5000, 10000, 50000, 100000,500000} 
	Player = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5","\x15P6"}
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
	

	f_GunT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_Gun Suspend 성공. f_Gun 실행자 : ")
	f_GunErrT = "\x07『 \x08ERROR \x04: G_CAPlot Not Found. \x07』"
	f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CAPlot Suspended. \x07』"
	f_GunSendT = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: f_GunSend 성공. f_Gun 실행자 : ")
	f_GunSendT2 = CreateCText(FP,"\x07『 \x03TESTMODE OP \x04: 성공한 f_GunSend의 EXCunit Number : ")
	G_SendErrT = "\x07『 \x08ERROR : \x04f_Gun의 목록이 가득 차 G_Send를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	CBulletErrT = "\x07『 \x08ERROR \x04: CreateBullet_EPD 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
	SuText = CreateCText(FP,"\x0d\x0d\x0d\x04의 \x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ \x04가 \x1C우주\x04의 \x15먼지\x04로 돌아갔습니다.. \x02◆\n\x12\x04(\x08Death \x10C\x0Fount \x04+ \x06100\x04)\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	SuT00 = CreateCText(FP,"\x0d\x0d\x0d\x12\x02◆ \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
	
	DefStr1 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x13\x0d\x0d\x0d\x0d\x0d\x0d")
	DefStr2 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04(이)가 \x1C방어력 \x04업그레이드를 완료하였습니다.\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
	


	InFormation = "\n\n\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x14\n\x14\n\x13\x07C\x04ustom \x07P\x04lib \x1FLock \x17Protector \x07v1.0 \x04in Used. \x19(つ>ㅅ<)つ \n\x13\x1FThanks \x04to \x1BNinfia\n\x13\x04이 문구가 뜰 경우 \x07정식버전\x04입니다. \n\x13\x04무단 수정맵을 주의해주세요.\n\x14\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"


	--Balance
	AtkFactor = 15
	DefFactor = 20
	SuFactor = 100
	MarCost = 10000
	GMCost = 30000
	NeCost = 30000
	SuCost = 500000
	HPointFactor = 30
	ExRate = 0
	EasyEx1P = 110
	HDEx1P = 120
	BurEx1P = 140
	GunLimit = 1450
	for i = 65, 255 do
	
	table.insert(PatchArr2,SetMemoryX(0x58DC70 + (20*(i)),SetTo,0 ,4128768))
	end
	--Patch
	
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
	UnitEnable2(9)
	UnitEnable2(0)
	UnitEnable2(1)
	UnitEnable2(7)
	UnitEnable2(2)
	UnitEnable2(32)
	UnitEnable2(34)
	UnitEnable2(72)
	UnitEnable2(72)
	SetUnitClass(16)
	SetUnitClass(68)
	SetUnitClass(23)
	SetUnitClass(74)
	SetUnitClass(11)
	SetUnitClass(5)
	SetUnitClass(12)
	SetUnitClass(186)
	
	for i = 0, 227 do
		SetUnitAdvFlag(i,0x200000,0x200000)
	end
	
	
	table.insert(PatchArr2,SetMemoryX(0x6638C8, SetTo, MarCost,0xFFFF))
	table.insert(PatchArr2,SetMemoryX(0x66388C, SetTo, MarCost+GMCost,0xFFFF))
	table.insert(PatchArr2,SetMemoryX(0x6559CC, SetTo, AtkFactor*65536,0xFFFF0000))
	table.insert(PatchArr2,SetMemoryX(0x6559C0, SetTo, DefFactor,0xFFFF))
	table.insert(PatchArr2,SetMemoryX(0x6559DC, SetTo, SuFactor,0xFFFF))
	
	
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
	unitSizePatch(i,3)
	end
	for i = 60,81 do
	unitSizePatch(i,5)
	end
	unitSizePatch(3,5)
	unitSizePatch(5,1)
	unitSizePatch(10,5)
	unitSizePatch(15,5)
	unitSizePatch(17,5)
	unitSizePatch(19,5)
	unitSizePatch(25,5)
	unitSizePatch(32,4)
	unitSizePatch(87,5)
	unitSizePatch(89,5)
	
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
			SetMemory(0x5188AC, SetTo, 5339096);
			SetMemory(0x518C9C, SetTo, 5339096);		
			SetMemory(0x5188A8, SetTo, 6);
			SetMemory(0x518C98, SetTo, 6);
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
	NextPtrs = CreateVar()
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
	BGMType = CreateCCode()
	LeaderBoardT = CreateCCode()
	GMode = CreateCCode()
	PaneltyP = CreateCCode()
	BonusP = CreateCCode()
	GiveRate = CreateCcodeArr(6)
	Test1 = CreateCCode()
	ModeO = CreateCCode()
	ModeT = CreateCCode()
	LimitC = CreateCCode()
	LimitX = CreateCCode()
	TestMode = CreateCCode()
	B_P = CreateCcode()
	BanCode = CreateCCodeArr(5) -- 18~23
	ModeT2 = CreateCCode()
	ModeSel = CreateCCode()
	BGMMode = CreateCCode()
	BGMSel = CreateCCode()
	SelectorT = CreateCCode()
	HealT = CreateCCode()
	CocoonLaunch = CreateCCode()
	IntroT = CreateCCode()
	LairHiveSpawnId = CreateCCode()
	SymbolCheck = CreateCCode()
	Chry_cond = CreateCCode()
	ScanEffT = CreateCCode()
	FormCon = CreateCCode()
	GunBossAct = CreateCCode()
	GunBossT = CreateCCode()
	GunBossT2 = CreateCCode()
	B_Chry_cond = CreateCCode()
	Py_Cond = CreateCCode()
	Sup_Cond = CreateCCode()
	BossKill = CreateCCode()
	SPGunCond = CreateCCode()
	Win = CreateCCode()
	CanCT = CreateCCode()
	Print13 = CreateCCode()
	GameOver = CreateCCode()
	ExchangeRateTMinusFlag = CreateCCode()
	GunBossT3 = CreateCCode()
	DBossGen = CreateCCode()
	HMDeaths = CreateCCodeArr(6)
	DoWhileCon = CreateCCode()
	--LairCCodeId = Ccode(0x1001,--)
	--HiveCCodeId = Ccode(0x1002,--)
	HiddenMode = CreateCCode()
	KeyToggle = CreateCCode()
	Toggle1 = CreateCCode()
	ToggleSound = CreateCCode()
	ToggleA = CreateCCode()
	Toggle2 = CreateCCode()
	ToggleS = CreateCCode()
	Toggle3 = CreateCCode()
	ToggleD = CreateCCode()
	TGiveforCoCoon = CreateCCode()
	CocoonGunCon = CreateCCode()
	ifUpisAtk = CreateCCode()
	LV_10_UnitTableCode = CreateCCode()
	LV_11_UnitTableCode = CreateCCode()
	OverCocooncomp = CreateCCode()
	CanOut = CreateCCode()
	ToggleHondon = CreateCCode()
	ZombieCheck = CreateCCode()
	Die_SEC = CreateCCode()
	SoundLimitT = CreateCCode()
	SoundLimit = CreateCCode()
	BossStart = CreateCCode()
	HiddenEnable = CreateCCode()
	f_GunSendStrPtr = CreateVar(FP)
	Actived_Gun = CreateVar(FP)
	f_GunNum = CreateVar(FP)
	BSkillT = CreateCcodeArr(6)
	SuStrPtr = CreateVarArr(6,FP)
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
	for i = 0, 5 do
	Str03[i+1] = CArray(FP,50)
	Names[i+1] = CVArray(FP,7)
	end
	end

end