function Var_init()
	RandSwitch = "Switch 100"
	RandSwitch2 = "Switch 101"
	if EVFFlag == 1 then
		if Limit == 1 then
			--GTAtk = 5*1.5
			--GTAtkFactor = 2*1.5
			--MarAtk = 15*1.5
			--MarAtkFactor = 3*1.5
			--MarAtk2 = 50*1.5
			--MarAtkFactor2 = 15*1.5
			GTAtk = 50*1.5
			GTAtkFactor = 25*1.5
			MarAtk = 50*1.5
			MarAtkFactor = 10*1.5
			MarAtk2 = 100*1.5
			MarAtkFactor2 = 30*1.5
		else
			GTAtk = 50*1.5
			GTAtkFactor = 25*1.5
			MarAtk = 50*1.5
			MarAtkFactor = 10*1.5
			MarAtk2 = 100*1.5
			MarAtkFactor2 = 30*1.5
		end
		NMAtk = 15*1.5
		NMAtkFactor = 2*1.5
		HMAtk = 50*1.5
		HMAtkFactor = 7*1.5
	else
		if Limit == 1 then
			--GTAtk = 5
			--GTAtkFactor = 2
			--MarAtk = 15
			--MarAtkFactor = 3
			--MarAtk2 = 50
			--MarAtkFactor2 = 15
			GTAtk = 50
			GTAtkFactor = 25
			MarAtk = 50
			MarAtkFactor = 10
			MarAtk2 = 100
			MarAtkFactor2 = 30
		else
			GTAtk = 50
			GTAtkFactor = 25
			MarAtk = 50
			MarAtkFactor = 10
			MarAtk2 = 100
			MarAtkFactor2 = 30
		end
		NMAtk = 15
		NMAtkFactor = 2
		HMAtk = 50
		HMAtkFactor = 7
	end
	AtkUpgradeFactor = 95
	DefUpgradeFactor = 490
	GunLimit = 1450
	ShCost = 50000
	NMCost = 5000
	HMCost = 8500
	LMCost = 45000
	LMCost2 = 45000-8500
	function Create_VoidEPDHeaderV(Player,Size)
		local Void = f_GetVoidptr(Player,Size)
		local Header =  CreateVar(Player)
		table.insert(CtrigInitArr[Player+1],SetCtrigX(Header[1],Header[2],0x15C,Header[3],SetTo,Void[1],Void[2],Void[3],1,Void[4]))
		return Header
	end
	local Angle360to256={}
	for i = 0, 359 do
		Angle360to256[i+1] = (i/360)*256
	end
	local Angle256to360={}
	for i = 0, 255 do
		Angle256to360[i+1] = (i/256)*360
	end
	DCtoSCFArr = f_GetFileArrptr(FP,Angle360to256,4,1)
	SCtoDCFArr = f_GetFileArrptr(FP,Angle256to360,4,1)--
	CreateUnitStackUIDArr = Create_VoidEPDHeaderV(FP,4*50000)
	CreateUnitStackXPosArr = Create_VoidEPDHeaderV(FP,4*50000)
	CreateUnitStackYPosArr = Create_VoidEPDHeaderV(FP,4*50000)
	CreateUnitStackOXPosArr = Create_VoidEPDHeaderV(FP,4*50000)
	CreateUnitStackOYPosArr = Create_VoidEPDHeaderV(FP,4*50000)
	CreateUnitStackPlayerArr = Create_VoidEPDHeaderV(FP,4*50000)
	CreateUnitStackFlagArr = Create_VoidEPDHeaderV(FP,4*50000)
	CreateUnitStackPtr = CreateVar(FP)
	UnitDataPtrVoid = f_GetVoidptr(FP,1700*12)
	UnitDataPtr = CreateVar(FP)
	table.insert(CtrigInitArr[FP+1],SetCtrigX(UnitDataPtr[1],UnitDataPtr[2],0x15C,UnitDataPtr[3],SetTo,UnitDataPtrVoid[1],UnitDataPtrVoid[2],UnitDataPtrVoid[3],1,UnitDataPtrVoid[4]))
	MaxHPBackUp = CreateArr(228,FP)
	BdDimArr = CreateArr(228,FP)
	EXPArr = CreateArr(50,FP)
	EXPArr2 = CreateArr(50,FP)
	for i = 0, 49 do
		table.insert(CtrigInitArr[8],SetMemX(Arr(EXPArr,i),SetTo,50*(i+1)))
		table.insert(CtrigInitArr[8],SetMemX(Arr(EXPArr2,i),SetTo,(50*1.5)*(i+1)))
	end
	N_X,N_Y,L_X,L_Y,C_A = CreateVars(5,FP)
	MarTblPtr = CreateVarArr(4,FP)
	ShieldEnV = CreateVar(FP)
	ShTStrPtr = CreateVarArr(4,FP)
	EEggStrPtr = CreateVarArr(4,FP)
	BPtrArr = CreateVarArr(8,FP)
	PyCCode = CreateCcodeArr(4)
	CereCond= CreateCcodeArr(4)
	HactCcode= CreateCcodeArr(4)
	LairCcode= CreateCcodeArr(4)
	HiveCcode= CreateCcodeArr(4)
	B2H = CreateVar(FP)
	CurCunitI = CreateVar(FP)
	RedNumPanelty = CreateCcode()

	BarRally = CreateVarArr(4,FP)
	BarPos = CreateVarArr(4,FP)

	IonCcode= CreateCcodeArr(4)

	NoradCcode= CreateCcodeArr(4)

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
	Time2 = CreateVar(FP)
	TimeTmp = CreateCcode()
	TimeV = CreateVar(FP)
	TimeV2 = CreateVar(FP)
	CurEXP = CreateVar(FP)
	MaxEXP = CreateVar2(FP,nil,nil,80)
	Level = CreateVar2(FP,nil,nil,1)
	RedNumber = CreateVar2(FP,nil,nil,400)
	RedNumberT = CreateVar(FP)
	LimitX = CreateCcode()
	LimitC = CreateCcode()
	SoundLimit = CreateCcode()
	SoundLimitP = CreateCcodeArr(4)
	TestMode = CreateCcode() 
	OPJump = CreateCcode()
	ButtonSound = CreateCcode()
	ShieldUnlock = CreateCcode()
	BStart = CreateCcode()
	ED2Clear = CreateCcode()
	AtkCondTblPtr = CreateVar(FP)
	HPCondTblPtr = CreateVar(FP)
	SetPlayers = CreateVar(FP)
	ExRateV = CreateVar(FP)
	Dt = CreateVar(FP)
	CA_Create = CreateVar(FP)
	CA_Color = CreateVar(FP)
	EEggCode = CreateCcode()
	NCBullet = CreateCcode()
	T_X,T_Y = CreateVars(2,FP)
	BossCenTrig = CreateCcode()
	CBY = CreateVar()
	CBX = CreateVar()
	CBAngle = CreateVar()
	CBHeight = CreateVar()
	CBUnitId = CreateVar()
	CBPlayer = CreateVar()
	Locs = CreateVar()
	TempEPD = CreateVar(FP)
	TempT = CreateVar(FP)
	TempA = CreateVar(FP)
	CB_TempH = CreateVar(FP)
	CBullet_ArrTemp = CreateVar(FP)
	CBullet_InputH = CreateVar(FP)
	AngleA = CreateVar(FP)
	LocsA = CreateVar(FP)
	BPos = CreateVar(FP)
	BPosX = CreateVar(FP)
	BPosY = CreateVar(FP)
	BossAtkRand = CreateVar(FP)
	
	MarHPRegen = CreateVar2(FP,nil,nil,256)
	LVVA = CreateVArr(4,FP)
	CurrentOP = CreateVar(FP)
	MarHPRead = CreateVarArr(4,FP)
	AtkCondTmp = CreateVar2(FP,nil,nil,50)
	HPCondTmp = CreateVar2(FP,nil,nil,0)
	SelEPD,SelHP,SelSh,SelMaxHP,SelI = CreateVars(5,FP)
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
	OvArrX = CreateVarArr(4,FP)
	OvArrY = CreateVarArr(4,FP)
	NexArrX = CreateVarArr(4,FP)
	NexArrY = CreateVarArr(4,FP)
	
	ThCallT = CreateCcode()
	AFlag = CreateCcode()
	BFlag = CreateCcode()
	ShUsed = CreateCcode()
	ShCool = CreateCcode()
	GeneT = CreateCcode()
	CXEffType = CreateCcode()
	CanCT = CreateCcode()
	Win = CreateCcode()
	Fin = CreateCcode()
	EDNum = CreateCcode()
	CanC = CreateVar(FP)
	DefeatCC = CreateCcode()
	CanWT = CreateCcode()
	TTEndC1 = CreateCcode()
	TTEndC2 = CreateCcode()
	TempleCcode = CreateCcode() -- 4
	NexCcode = CreateCcode()--4
	OvCcode = CreateCcode()--4
	OvGCcode = CreateCcode()--4
	CellCcode = CreateCcode()--4
	XelCcode = CreateCcode()--4
	CenCcode = CreateCcode()--4
	CenCcode2 = CreateCcodeArr(4)--4
	OcCcode = CreateCcode()--2
	DgCcode = CreateCcode()--2
	GeneCcode = CreateCcode()--2
	WarpCheck = CreateCcode()
	CUnitRefrash = CreateCcode()
	Theorist = CreateCcode() -- �̷�ġ��� Ccode
	DCV = CreateVar(FP)--��ī����V
	CUnitFlag = CreateCcode()
	MarDup = CreateCcode()
	MarDup2 = CreateCcode()
	CheatMode = CreateCcode()
	SpecialEEggCcode = CreateCcode()
	LocalPlayerV=CreateVar(FP)
	AxiomCcode = CreateCcodeArr(4)
	AxiomFailCcode = CreateCcodeArr(4)
	AxiomEnable = CreateCcode()
	ResNum = CreateCcode()
	ResNumT = CreateCcodeArr(4)
	tesStart = CreateCcode()
	tesFlag = CreateCcode()
	tesEndt= CreateVar(FP)
	HStr2 = SaveiStrArrX(FP,MakeiStrVoid(54*11)) 
	HStr4 = SaveiStrArrX(FP,MakeiStrVoid(54)) 
	--HStr4 = SaveiStrArrX(FP,MakeiStrVoid(54*11)) 
	HVA3 = CVArray(FP,4*5) 
	EEggV = CreateVar(FP)
	UnivStrPtr = CreateVar(FP)
	_0D_1000B = string.rep("\x0D",1000)

	AxStrArr = {
		"\x041. \x07������ ����\x04���� \x07��\x04�� \x17����\x04�� \x1F��ã�ƶ�.",
		"\x042. \x18����\x04�� \x10����\x04�� \x1F����\x04�϶�.",
		"\x043. \x08����\x04�� \x10����\x04�� \x07�غ��϶�.",
		"\x044. \x10����\x04�� \x07���\x04�� \x1F�ع���Ѷ�."
	}

	HLine, ChatSize, ChatOff, HCheck = CreateVars(4,FP) 
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(38).."\r\n",3)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(38))
	RepHeroIndex,Gun_LV,CunitHP,CunitP,CunitIndex = CreateVars(5,FP)
	Replace_JumpUnitArr = {nilunit,4,6,18,24,26,31,58,35,168,201}
	f_ReplaceErrT = StrDesign("\x08ERROR : \x04ĵ������ ���� f_Replace�� ������ �� �����ϴ�! ��ũ�������� �����ڿ��� �������ּ���!\x07")
	CurPlace = CreateCcode()
	HumanPlayers = {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}
	MapPlayers = {P1,P2,P3,P4}
	ObPlayers = {P5,P6,P7,P8,P9,P10,P11,P12}
	Players = {"\x081��","\x0E2��","\x0F3��","\x104��"}
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
	P = {"\x081��","\x0E2��","\x0F3��","\x104��"}
	DelayMedicT = {
		StrDesign("\x1D����޵�\x04�� \x1B2Tick\x04���� �����մϴ�. - \x1F300 Ore\x07"),
		StrDesign("\x1D����޵�\x04�� \x1B3Tick\x04���� �����մϴ�. - \x1F350 Ore\x07"),
		StrDesign("\x1D����޵�\x04�� \x1B4Tick\x04���� �����մϴ�. - \x1F400 Ore\x07"),
		StrDesign("\x1D����޵�\x04�� \x1B��Ȱ��ȭ(1Tick)\x04�Ͽ����ϴ�. - \x1F250 Ore\x07")}
	ResetSwitch = "Switch 250"
	WaveSwitch = "Switch 150"
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

	
	--ClassInfo2 = CreateCText(FP,"\x04 (")
	--ClassInfo3 = CreateCText(FP,"\x04) - ")
	--ClassInfo4 = CreateCText(FP," �ģ��")
	--ClassInfo6 = CreateCText(FP,"\x1F.")
	--ClassInfo5 = CreateCText(FP," ��")
	
	HTextStrReset = CreateCText(FP,HTextStr)
	Str122 = CreateCText(FP,"\x07��\x11��\x08��\x07�� ")
	Str12 = CreateCText(FP,"\x0D\x0D!H\x07��\x11��\x08��\x07�� ")
	Str03 = {}
	Str02 = {}

	for i = 0, 3 do
		table.insert(Str02,CreateCText(FP,"\x04's "..Color[i+1].."��\x11��\x03��\x18��"..Color[i+1].."�� "..Color[i+1].."\x07��\x08��\x11��\x07��"))
	end
	Str13 = CreateCText(FP,"\x04��(��) \x1C���� ��ȣ��\x04�� ����߽��ϴ�. \x07��\x08��\x11��\x07��")
	EEggStr = CreateCText(FP,"\x04��(��) \x07��\x04�� ���\x04�� �߰��߽��ϴ�. \x07��\x08��\x11��\x07��")

	

	AtkCondT = CreateCText(FP,"���ݷ� ���׷��̵� ���� �Ҹ���\n	Next Level - ")
	HPCondT = CreateCText(FP,"ü�� ���׷��̵� ���� �Ҹ���\n	Next Level - ")

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
	RCV = CreateVarArr(57,FP)
	CXGeneFlag = CreateCcode()
	

	TTemp = CXMakePolyhedron(20,512) -- �Ѻ��� ũ�Ⱑ 512 ��20��ü (Z>0 �Ͼ� / Z=0 �Ķ� / Z<0 ����) 
	TNumber = TTemp[1]/2 + 1
	TShape = {1,{0,0,0}} -- ���� ������ ����
	local Sym = {{1,4},{2,3},{5,8},{6,7},{9,12},{10,11}}
	for i = 1, TTemp[1]/2 do
	table.insert(TShape,{TTemp[Sym[i][1]+1][1],TTemp[Sym[i][1]+1][2], TTemp[Sym[i][1]+1][3]})
	TShape[1] = TShape[1] + 1
	end

	
	CA_Eff_Rat = CreateVar(FP)
	CA_Eff_Rat2 = CreateVar(FP)
	CA_Eff_Rat3 = CreateVar(FP)
	CA_Eff_DRat2 = CreateVar(FP)
	CA_Eff_DRat3 = CreateVar(FP)
	CA_Eff_RRat2 = CreateVar(FP)
	CA_Eff_RRat3 = CreateVar(FP)
	CA_Eff_DRat2Dt = CreateVar2(FP,nil,nil,2500)
	CA_Eff_DRat3Dt = CreateVar2(FP,nil,nil,2500)
	CA_EffSWArr = CreateCcodeArr(8)--����Ʈ �Ѱ������ �����ϴ� CcodeArr. 0�ϰ�쿡�� ����
	CA_EffSWArr2 = CreateVarArr(8,FP)--Ŀ���� JYD Repeat�� ��� ���� �����ϴ� �׸�. 1 �̻��� ��� ���ڸ�ŭ �ش������� ��. �ٸ����� �ߺ����� ����
	--CA_EffSWArr3 = CreateVarArr(8,FP)--Ŀ���� ����Ʈ �Ѱ������ �����ϴ� �׸�. ��
	CA_Eff_XY,CA_Eff_YZ,CA_Eff_ZX = CreateVars(3,FP)
	CA_Eff_XY2,CA_Eff_YZ2,CA_Eff_ZX2 = CreateVars(3,FP)
--	CreateHeroPointArr(15,"\x1B��\x04�� "..Conv_HStr("<1B>C<04>ivilian"),30000)


Tier1 = {17,77,78,76,63,21,88,28,86,75,25}
Tier2 = {79,80,52,10,22,19}
Tier3 = {27,66,29,98,57,3,8,11,69,100,70,65}
Tier4 = {102,61,67,23,81,30}
Tier5 = {60,68}
EraUngmeojulT = {}
EraUngmeojulC = CreateCcode()

CreateHeroPointArr(17,nil,9999,0,"\x1B��\x04������ "..Conv_HStr("<1B>A<04>lan <1B>S<04>chezar"),25000,nil,nil,1) --
CreateHeroPointArr(77,nil,6000,5000,"\x1B��\x04���� "..Conv_HStr("<1B>F<4>enix <1B>Z"),30000,nil,nil,1) --
CreateHeroPointArr(78,nil,8000,6000,"\x1B��\x04�⺴ "..Conv_HStr("<1B>F<4>enix <1B>D"),33000,nil,nil,1) --
CreateHeroPointArr(76,nil,9000,6000,"\x1B��\x04�� "..Conv_HStr("<1B>O<4>rb"),45000,nil,nil,1) --
CreateHeroPointArr(21,nil,9999,0,"\x1B��\x04�� "..Conv_HStr("<1B>T<04>om <1B>K<04>azansky"),30000,nil,nil,1) --
CreateHeroPointArr(88,nil,9000,3000,"\x1B��\x04���� "..Conv_HStr("<1B>A<4>rtanis"),32000,nil,nil,1) --
CreateHeroPointArr(28,nil,9999,0,"\x1B��\x04�� "..Conv_HStr("<1B>H<4>yperion"),35000,nil,nil,1) --
CreateHeroPointArr(86,nil,9999,7000,"\x1B��\x04�� "..Conv_HStr("<1B>D<4>animoth"),42000,nil,nil,1) --
CreateHeroPointArr(25,nil,9999,0,"\x1B��\x04�� "..Conv_HStr("<1B>M<4>ortal"),38000) --
CreateHeroPointArr(75,nil,7000,9000,"\x1B��\x04���� "..Conv_HStr("<1B>Z<4>eratul"),40000,nil,nil,1) --
CreateHeroPointArr(63,nil,5000,9000,"\x1F��\x04�� "..Conv_HStr("<1F>D<4>ark <1F>O<4>rb"),50000,nil,1,1) --


CreateHeroPointArr(19,nil,22000,0,"\x1B��\x04���� "..Conv_HStr("<1B>J<04>im <1B>R<04>aynor <1B>V"),45000,nil,nil,1) --
CreateHeroPointArr(52,nil,25000,0,"\x1B��\x04�� "..Conv_HStr("<1B>O<4>rganes"),55000,nil,nil,1) --
CreateHeroPointArr(10,nil,15000,0,"\x1Fȭ\x04�� "..Conv_HStr("<1F>I<04>nferno"),55000,nil,1,1) --
CreateHeroPointArr(22,nil,25000,0,"\x1F��\x04���� "..Conv_HStr("<1F>A<4>dverse"),55000,nil,1,1)--
CreateHeroPointArr(79,nil,17000,6000,"\x1B��\x04���� "..Conv_HStr("<1B>T<4>assadar"),45000,nil,nil,1)--
CreateHeroPointArr(80,nil,20000,8900,"\x1F��\x04���� "..Conv_HStr("<1F>A<04>ntithese"),55000,nil,1,1)

CreateHeroPointArr(8,nil,25000,0,"\x1F��\x04�� "..Conv_HStr("<1F>P<04>hantom"),67000,nil,1,1)
CreateHeroPointArr(3,nil,31920,0,"\x1F��\x04���� "..Conv_HStr("<1F>B<04>rutal"),76000,nil,1,1)
CreateHeroPointArr(57,nil,27000,0,"\x1F��\x04�� "..Conv_HStr("<1F>W<4>itch"),56000,nil,1,1)
CreateHeroPointArr(98,nil,20000,10000,"\x1F��\x04���� "..Conv_HStr("<1F>B<4>reach"),75000,nil,1,1)
CreateHeroPointArr(27,nil,10000,20000,"\x1F��\x04õ�� "..Conv_HStr("<1F>A<4>scension"),65000,nil,1,1)
CreateHeroPointArr(29,nil,35000,0,"\x1F��\x04�� "..Conv_HStr("<1F>N<4>orad <1F>II"),45000,nil,1,1)
CreateHeroPointArr(66,nil,30000,10000,"\x1F��\x04���� "..Conv_HStr("<1F>I<4>mmortal"),75000,nil,1,1)
CreateHeroPointArr(100,nil,35000,0,"\x1F��\x04���� "..Conv_HStr("<1F>E<04>clipse"),55000,nil,1,1)
CreateHeroPointArr(70,nil,26000,12000,"\x1F��\x04�� "..Conv_HStr("<1F>F<04>allen"),75000,nil,1,1)
CreateHeroPointArr(65,nil,25000,5000,"\x1F��\x04���� "..Conv_HStr("<1F>M<4>adness"),65000,nil,1,1)

CreateHeroPointArr(102,nil,60000,0,"\x1F��\x04���� "..Conv_HStr("<1F>C<4>onflict"),100000,nil,1,1)
CreateHeroPointArr(61,nil,70000,10000,"\x1F��\x04���� "..Conv_HStr("<1F>V<4>indication"),80000,nil,1,1)
CreateHeroPointArr(67,nil,120000,10000,"\x1Fâ\x04���� "..Conv_HStr("<1F>G<4>enesis"),115000,nil,1,1)
CreateHeroPointArr(23,nil,250000,0,"\x1F��\x04�� "..Conv_HStr("<1F>I<4>conoclasm"),66600,nil,1,1)
CreateHeroPointArr(81,nil,100000,50000,"\x1F��\x04�� "..Conv_HStr("<1F>D<4>antalion"),85000,nil,1,1)
CreateHeroPointArr(30,nil,322,0,"\x1F��\x04ü�� "..Conv_HStr("<1F>I<4>dentity"),70000,nil,1)



CreateHeroPointArr(60,nil,110000,60000,"\x08��\x04���� "..Conv_HStr("<08>A<4>ntagonism"),322000,nil,nil,1)
CreateHeroPointArr(68,nil,250000,64000,"\x1F��\x04��� "..Conv_HStr("<1F>J<4>udgement"),110000,nil,1)


CreateHeroPointArr(71,nil,1,60000,"\x1F��\x04�� "..Conv_HStr("<1F>P<4>ain"),55000,nil,1,1)

CreateHeroPointArr(118,nil,20000,30000,"\x1F��\x04���� "..Conv_HStr("<1F>H<4>ate"),65000,nil,1)


CreateHeroPointArr(150,nil,80000,0,"\x19��\x04�� "..Conv_HStr("<19>B<04>onus"),55000,2,1)
CreateHeroPointArr(176,nil,50000,0,"\x19��\x04�� "..Conv_HStr("<1D>F<4>it"),15500,2,1)
CreateHeroPointArr(177,nil,50000,0,"\x19��\x04�� "..Conv_HStr("<1D>F<4>it"),15500,2,1)
CreateHeroPointArr(178,nil,50000,0,"\x19��\x04�� "..Conv_HStr("<1D>F<4>it"),15500,2,1)


end