function Include_Vars()
	if SpeedTestMode == 1 then
		function HumanCheck(Player,Status)
			if Status == 0 then return Never() else return Always() end
		end
	end
	--System
	iv={} -- ���� ���� ���̺�
	ct={} -- ���� ���� ���̺� ġ�ð���
	ctg={} -- ���� ���� ���̺� ġ�ð���
	LevelLimit = 200000
	TimeScoreInit = 1000000
	HumanPlayers={P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}
	LimitVerPtr = 0x58f608
	ULimitArr = {500,300,230,180,140,120,100}
	ULimitV = CreateVar(FP)
	ULimitV2 = CreateVar(FP)
	SCA = {}
	
function SCA.CreateVar(PlayerID)
	CreateVarXAlloc = CreateVarXAlloc + 1
	if CreateVarXAlloc > CreateMaxVAlloc then
		CreateVariable_IndexAllocation_Overflow()
	end
	if PlayerID == nil then
		PlayerID = AllPlayers
	end
	table.insert(CreateVarPArr,{"V",PlayerID})
	local Ret = V(CreateVarXAlloc)
	if type(PlayerID) == "number" then
		Ret[1] = PlayerID
	end
	table.insert(SCA.DataPtrArr, Ret)
	return Ret
end

function SCA.Available(CP)
	return DeathsX(CP, Exactly, 3, 1,3)
end
function SCA.NotAvailable(CP)
	return DeathsX(CP, Exactly, 0, 1,2)
end
function SCA.Reset(CP)
	return SetDeaths(CP, SetTo, 0, 1)
end
function SCA.LoadCmp(CP)--��밡�� + �ε�Ϸ�
	return DeathsX(CP, Exactly, 7, 1,7)
end
function SCA.SaveCmp(CP)--��밡�� + ����Ϸ�
	return DeathsX(CP, Exactly, 11, 1,11)
end
	SCA.GlobalCheck2 = CreateCcode()
	SCA.GlobalCheck = CreateCcode()
	SCA.GlobalLoadFlag = CreateCcode()
	SCA.LoadCheckArr = CreateCcodeArr(7)
	VoidAreaOffset = 0x58f60C
	VoidAreaAlloc = 0x58f60C-4
	VoidAreaLimit = 0x5967F0
	SCA.GlobalVarArr = CreateVarArr(20, FP)
	ct.GlobalVarArr = CreateVarArr(20, FP)
	SCA.GlobalData = CreateVoidArr(20)
	SCA.Year = CreateVoid()
	SCA.Month = CreateVoid()
	SCA.Hour = CreateVoid()
	SCA.Day = CreateVoid()
	SCA.Week = CreateVoid()
	SCA.Min = CreateVoid()
	SCA.ArrPtr = CreateVoid()
	
	os.execute("mkdir " .. "SCA")
	local CSfile = io.open(FileDirectory .. "SCA_Offset" .. ".txt", "w")
	io.output(CSfile)
	io.write("ArrPtr MemOffset : "..SCA.ArrPtr)
	io.close(CSfile)
	SCA.DataPtrArr = {}

	SCA.DataOffsetArr = CreateArr(500*4, FP)
	SCA.CheckTime = CreateCcode()
	SCA.GLoadCmp = CreateCcode()
	SCA.YearV = CreateVar(FP)
	SCA.MonthV = CreateVar(FP)
	SCA.HourV = CreateVar(FP)
	SCA.DayV = CreateVar(FP)
	SCA.WeekV = CreateVar(FP)
	SCA.MinV = CreateVar(FP)
	
	ct.YearV = CreateVar(FP)
	ct.MonthV = CreateVar(FP)
	ct.HourV = CreateVar(FP)
	ct.DayV = CreateVar(FP)
	ct.WeekV = CreateVar(FP)
	ct.MinV = CreateVar(FP)

	SCA.MapMakerFlag = SCA.CreateVar(FP)
	SCA.PLevel = SCA.CreateVar(FP)
	SCA.StatP = SCA.CreateVar(FP)
	SCA.StatIncome = SCA.CreateVar(FP)
	SCA.StatTotalEPer = SCA.CreateVar(FP)
	SCA.StatTotalEPer2 = SCA.CreateVar(FP)
	SCA.StatTotalEPer3 = SCA.CreateVar(FP)
	SCA.StatUpgrade = SCA.CreateVar(FP)
	SCA.Credit32 = SCA.CreateVar(FP)
	SCA.Credit64 = SCA.CreateVar(FP)
	SCA.PEXP32 = SCA.CreateVar(FP)
	SCA.PEXP64 = SCA.CreateVar(FP)
	SCA.TotalExp32 = SCA.CreateVar(FP)
	SCA.TotalExp64 = SCA.CreateVar(FP)
	SCA.CurEXP32 = SCA.CreateVar(FP)
	SCA.CurEXP64 = SCA.CreateVar(FP)
	SCA.TesterFlag = SCA.CreateVar(FP)
	SCA.BanFlag = SCA.CreateVar(FP)
	SCA.AddSc = SCA.CreateVar(FP)
	SCA.PStatVer = SCA.CreateVar(FP)
	SCA.PlayTime = SCA.CreateVar(FP)
	SCA.PlayTime2 = SCA.CreateVar(FP)
	SCA.CreditAddSC = SCA.CreateVar(FP)
	SCA.LV5Cool = SCA.CreateVar(FP)
	SCA.BanFlag2 = SCA.CreateVar(FP)
	SCA.BanFlag3 = SCA.CreateVar(FP)
	SCA.BanFlag4 = SCA.CreateVar(FP)
	SCA.StatTotalEPer4 = SCA.CreateVar(FP)
	SCA.StatBreakShield = SCA.CreateVar(FP)
	SCA.StatTotalEPerEx = SCA.CreateVar(FP)
	SCA.TimeAttackScore = SCA.CreateVar(FP)
	SCA.PUnitLevel = SCA.CreateVar(FP)
	SCA.PUnitClass = SCA.CreateVar(FP)
	SCA.VaccItem = SCA.CreateVar(FP)
	SCA.CSCooldown = SCA.CreateVar(FP)
	SCA.CSAtk = SCA.CreateVar(FP)
	SCA.CSEXP = SCA.CreateVar(FP)
	SCA.CSTotalEPer = SCA.CreateVar(FP)
	SCA.CSTotalEper4 = SCA.CreateVar(FP)
	SCA.CSDPSLV = SCA.CreateVar(FP)
	SCA.RandomSeed1 = SCA.CreateVar(FP)
	SCA.RandomSeed2 = SCA.CreateVar(FP)
	SCA.RandomSeed3 = SCA.CreateVar(FP)
	SCA.RandomSeed4 = SCA.CreateVar(FP)
	SCA.RandomSeed5 = SCA.CreateVar(FP)
	SCA.RandomSeed6 = SCA.CreateVar(FP)
	SCA.RandomSeed7 = SCA.CreateVar(FP)
	SCA.RandomSeed8 = SCA.CreateVar(FP)
	SCA.RandomSeed9 = SCA.CreateVar(FP)
	SCA.RandomSeed10 = SCA.CreateVar(FP)
	SCA.StatTotalEPerEx2 = SCA.CreateVar(FP)
	SCA.StatTotalEPerEx3 = SCA.CreateVar(FP)
	SCA.StatSCCool = SCA.CreateVar(FP)
	SCA.PETicket = SCA.CreateVar(FP)
	SCA.CSBreakShield = SCA.CreateVar(FP)
	SCA.SellTicket = SCA.CreateVar(FP)
	SCA.CurMission = SCA.CreateVar(FP)
	SCA.DayCheck = SCA.CreateVar(FP)
	SCA.DayCheck2 = SCA.CreateVar(FP)
	SCA.YearCheck = SCA.CreateVar(FP)
	SCA.MonthCheck = SCA.CreateVar(FP)
	SCA.BanFlag5 = SCA.CreateVar(FP)
	SCA.BanFlag6 = SCA.CreateVar(FP)
	SCA.BanFlag7 = SCA.CreateVar(FP)
	SCA.BanFlag8 = SCA.CreateVar(FP)
	SCA.RankTitle = SCA.CreateVar(FP)
	SCA.StatTotalEPer4X = SCA.CreateVar(FP)
	SCA.StatBreakShield2 = SCA.CreateVar(FP)
	SCA.FfragItem = SCA.CreateVar(FP)
	SCA.FfragItem32 = SCA.CreateVar(FP)

	--3.00 �߰� ������
	SCA.FfragItemUsed = SCA.CreateVar(FP)
	SCA.TimeAttackScore48 = SCA.CreateVar(FP)
	SCA.FirstRewardLim = SCA.CreateVar(FP)
	SCA.FXPer44 = SCA.CreateVar(FP)
	SCA.FXPer45 = SCA.CreateVar(FP)
	SCA.FXPer46 = SCA.CreateVar(FP)
	SCA.FIncm = SCA.CreateVar(FP)
	SCA.FSEXP = SCA.CreateVar(FP)
	SCA.FXEPer = SCA.CreateVar(FP)
	SCA.FMEPer = SCA.CreateVar(FP)
	SCA.FBrSh = SCA.CreateVar(FP)
	SCA.StatBossSFrg = SCA.CreateVar(FP)
	SCA.StatXEPer44 = SCA.CreateVar(FP)
	SCA.StatXEPer45 = SCA.CreateVar(FP)
	SCA.StatXEPer46 = SCA.CreateVar(FP)
	SCA.StatXEPer47 = SCA.CreateVar(FP)
	SCA.FfragItem64 = SCA.CreateVar(FP)
	SCA.FfragItemUsed64 = SCA.CreateVar(FP)
	SCA.FStatVer = SCA.CreateVar(FP)
	SCA.PLevel2 = SCA.CreateVar(FP)
	SCA.AwakItem = SCA.CreateVar(FP)
	SCA.CSX_LV3Incm = SCA.CreateVar(FP)
	SCA.PETicket2 = SCA.CreateVar(FP)
	

	SCA.GReload = CreateCcode()
	SCA.LoadSlot1 = CreateCcodeArr(7)
	--MSQC_init(0x590004)
	MSQC_KeyArr = {} 
	MSQC_KeySet("O",494) -- MSQC eds�ؽ�Ʈ �Է�
	MSQC_KeySet("ESC",495)
	MSQC_KeySet("1",496)
	MSQC_KeySet("2",497)
	MSQC_KeySet("3",498)
	MSQC_KeySet("4",499)
	MSQC_KeySet("5",500)
	MSQC_KeySet("6",501)
	MSQC_KeySet("P",502)
	MSQC_KeySet("I",503)
	MSQC_KeySet("F9",13)
	MSQC_KeySet("F12",553)--�׽�Ʈ��
	MSQC_KeySet("B",554)
	MSQC_KeySet("N",555)
	MSQC_KeySet("M",556)
	MSQC_KeySet("Z",505)
	MSQC_KeySet("U",506)
	--504 �����
	MSQC_ExportEdsTxt() -- MSQC eds�ؽ�Ʈ ���
	Nextptrs = CreateVar(FP) -- ���� EPD �ε��
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
	ColorCode = {0x08,0x0E,0x0F,0x10,0x11,0x15,0x16}
	ColorT = {"\x08","\x0E","\x0F","\x10","\x11","\x15","\x16"}
	_0D = string.rep("\x0D",200) 
	LimitX, LimitC,TestMode = CreateCcodes(3)
	LimitM = CreateCcodeArr(7)
	LimitSaveEnable = CreateCcode()
	--Interface
	
	VArrI,VArrI4 = CreateVars(2,FP)
	WArrI,WArrI4,GCPW = CreateWars(3,FP)
	DPErT = CreateVarArr(7,FP)
	TestShop = CreateVarArr(7, FP) -- �׽�Ʈ���̾��µ� ���۵��ؼ� ���� ���Ǳ⿡ �����
	ShopPtr = CreateVarArr(7, FP) -- �׽�Ʈ���̾��µ� ���۵��ؼ� ���� ���Ǳ⿡ �����
	
	TBLFlag = CreateCcode() -- TBL ���� ���� �Ǻ��� ������. ���� ������ �����Ǹ� ���۾���
	SettingUnit1 = CreateVarArr(7, FP)-- 1~25�� ���� �ڵ���ȭ ������
	SettingUnit2 = CreateVarArr(7, FP)-- 26~39�� ���� �ڵ���ȭ ������

	SettingUnit3 = CreateVarArr(7, FP)-- 15~25�� ���� �ڵ��Ǹ� ������
	SettingUnit4 = CreateVarArr(7, FP)-- 26~39�� ���� �ڵ��Ǹ� ������
	ShopUnit = CreateVarArr(7, FP) -- �ùμ�����
	PUnitPtr = CreateVarArr(7, FP) -- ��������
	SlotPtr = CreateVarArr(7, FP) -- ����������

	DpsLV1 = CreateVarArr(7, FP) -- ù��° DPS�ǹ�
	DpsLV2 = CreateVarArr(7, FP) -- �ι�° DPS�ǹ�
	DpsLV3 = CreateVarArr(7, FP) -- ����° DPS�ǹ�
	PBossPtr = CreateVarArr(7, FP) -- ���κ��� DPS���� ptr
	Names = CreateVArrArr(7, 7, FP) -- �� �÷��̾� �̸� �����

	ELevel = CreateVar(FP)--���� ��ȭ���� ����

	
	CntCArr = CreateCcodeArr(8)
	failCcode = CreateCcode()

	TempFfragTotal = CreateWar(FP)

	--EExp = CreateVar(FP)
	ECP = CreateVar(FP) -- ��ȭ ����� ����. ���� ��ȭ���� �÷��̾ ������
	GEper = CreateVar(FP) -- ��ȭ ����� ����. �ش��÷��̾��� +1�� Ȯ���� ������
	GEper2 = CreateVar(FP) -- ��ȭ ����� ����. �ش��÷��̾��� +2�� Ȯ���� ������
	GEper3 = CreateVar(FP) -- ��ȭ ����� ����. �ش��÷��̾��� +3�� Ȯ���� ������
	GEper4 = CreateVar(FP)
	XEper = CreateVar(FP)
	BreakShield = CreateVar(FP)
	UEper = CreateVar(FP) -- ��ȭ ����� ����. ��ȭ�� ������ Ȯ���� ������

	ShopSw = CreateCcodeArr(7) -- 
	ShopKey = CreateCcodeArr(7) -- 

	Etbl = CreateVar(FP) -- ������ tblPtr����� ����. ���� ��ȭȮ�� ǥ���
	--CheatTest
	
	CurCunitI = CreateVar(FP)
	CT_GNextRandV = CreateVar(FP)
	CT_GPrevRandV = CreateVar(FP)
	CT_GNextRandW = CreateWar(FP)
	CT_GPrevRandW = CreateWar(FP)
	CT_NextRandV = CreateVarArr(7,FP)
	CT_PrevRandV = CreateVarArr(7,FP)
	CT_NextRandW = CreateWarArr(7,FP)
	CT_PrevRandW = CreateWarArr(7,FP)

	--String
	VaccSCount = CreateCcodeArr(7)
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",3)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))
	--FfragS,FfragSa,FfragSs = DwSaveiStrptrX(FP,"���� ���� \x04:")
	--PtsS,PtsSa,PtsSs = DwSaveiStrptrX(FP,"\x04| ����Ʈ \x04:")
	--CredS,CredSa,CredSs = DwSaveiStrptrX(FP,"\x04| \x17ũ���� \x04:")


	-- Interface Variable

	MCTCondArr = {
		Memory(0x5124F0, Exactly, 13)
	}

	--PlayData(NonSCA)
	iv.Money = CreateWarArr(7,FP) -- �ڽ��� ���� �� ������
	iv.Money2 = CreateVarArr(7,FP) -- �ڽ��� ���� �� ������
	iv.IncomeMax = CreateVarArr2(7,12,FP) -- �ڽ��� ����� �ִ� ���ּ�
	iv.Income = CreateVarArr(7,FP) -- �ڽ��� ���� ����Ϳ� �������� ���ּ�
	iv.BuildMul1 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	iv.BuildMul2 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	iv.TotalEPer = CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	iv.TotalEPer2 = CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	iv.TotalEPer3 = CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	iv.TotalEPer4 = CreateVarArr(7,FP)--�� ��ȭȮ��(Ư��)
	iv.ScoutDmg = CreateVarArr(7,FP) -- �⺻���� ������
	iv.ScTimer = CreateVarArr(7,FP)
	iv.PTimeV = CreateVarArr(7,FP)
	iv.General_Upgrade = CreateVarArr(7,FP)
	iv.ResetStat = CreateVarArr(7,FP)
	iv.NextOre = CreateVarArr2(7,100,FP) -- ���� �̳׶�
	iv.NextGas = CreateVarArr2(7,100,FP) -- ���� ����
	iv.NextOreMul = CreateVarArr2(7,2,FP) -- ���� �̳׶����
	iv.NextGasMul = CreateVarArr2(7,2,FP) -- ���� �������
	iv.SellTicket = CreateVarArr(7,FP)
	iv.PBossLV = CreateVarArr(7,FP)
	iv.PBossDPS = CreateWarArr(7,FP)
	iv.TotalPBossDPS = CreateWarArr(7,FP)
	iv.Stat_EXPIncome = CreateVarArr(7,FP)-- ����ġ ȹ�淮 ��ġ. ��� ����
	iv.TimeAttackScore2 = CreateVarArr2(7,TimeScoreInit,FP)
	
	iv.CurPUnitCool = CreateVarArr(7,FP)
	
	ctarr = {{},{},{},{},{},{},{},{}}
	--General
	iv.Time = CreateVar(FP)
	iv.Time2 = CreateVar(FP)
	iv.Time3 = CreateVar(FP)
	iv.Time4 = CreateVar(FP)
	--Setting, Effect
	iv.StatEff = CreateCcodeArr(7) -- ������ ����Ʈ
	iv.StatEffT2 = CreateCcodeArr(7) -- ������ ����Ʈ
	iv.InterfaceNum = CreateVarArr(7,FP) -- �����̳� ���� ��� â �����
	iv.AutoBuyCode = CreateVarArr(7,FP)-- �ڵ� ���� ���� ������
	iv.MulOp = CreateVarArr2(7,1,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
	
	--PlayData(SCA)
	iv.PLevel = CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	iv.StatP = CreateVarArr2(7,5,FP)-- ���� �������� ��������Ʈ
	iv.Stat_BossSTic = CreateVarArr(7,FP)-- ����� ���� ��ġ
	iv.Stat_BossLVUP = CreateVarArr(7,FP)-- ����� ���� ��ġ
	iv.Stat_TotalEPer = CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	iv.Stat_TotalEPerEx = CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	iv.Stat_TotalEPer2 = CreateVarArr(7,FP)-- +2�� Ȯ�� ��ġ
	iv.Stat_TotalEPer3 = CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	iv.Stat_TotalEPer4 = CreateVarArr(7,FP)-- Ư�� Ȯ�� ��ġ
	iv.Stat_BreakShield = CreateVarArr(7,FP)-- �ı� ���� ��ġ


	iv.Stat_Upgrade = CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	iv.Credit = CreateWarArr(7,FP) -- �������� ũ����
	iv.PEXP = CreateWarArr(7, FP) -- �ڽ��� ���ݱ��� ���� �� ����ġ
	iv.TotalExp = CreateWarArr2(7,"10",FP) -- ���ݱ��� �������� ����� ����ġ + ���� �������� �ʿ��� ����ġ
	iv.CurEXP = CreateWarArr(7,FP) -- ���ݱ��� �������� ����� ����ġ
	iv.PStatVer = CreateVarArr(7,FP) -- ���� ����� ���ȹ���
	iv.PlayTime2 = CreateVarArr(7,FP) -- �� �÷���Ÿ��(�� ��)
	iv.PlayTime = CreateVarArr(7,FP) -- �� �÷���Ÿ��(�� ��)
	iv.CreditAddSC = CreateVarArr(7,FP) 
	iv.LV5Cool = CreateVarArr(7,FP)
	iv.B_PCredit = CreateVarArr(7,FP)
	iv.B_PTicket = CreateVarArr(7,FP)
	iv.B_PEXP = CreateVarArr(7,FP)

	iv.BanFlag = CreateVarArr(7,FP)
	iv.BanFlag2 = CreateVarArr(7,FP)
	iv.BanFlag3 = CreateVarArr(7,FP)
	iv.BanFlag4 = CreateVarArr(7,FP)
	iv.TimeAttackScore = CreateVarArr(7,FP)
	--Local Data Variable
	iv.IncomeMaxLoc = CreateVar(FP)
	iv.IncomeLoc = CreateVar(FP)
	iv.LevelLoc = CreateVar(FP)
	iv.LevelLoc2 = CreateVar(FP)
	iv.TotalEPerLoc = CreateVar(FP)
	iv.TotalEPer2Loc = CreateVar(FP)
	iv.TotalEPer3Loc = CreateVar(FP)
	iv.TotalEPer4Loc = CreateVar(FP)
	iv.S_TotalEPerLoc = CreateVar(FP)
	iv.S_TotalEPerExLoc = CreateVar(FP)
	iv.S_TotalEPerEx2Loc = CreateVar(FP)
	iv.S_TotalEPerEx3Loc = CreateVar(FP)
	iv.S_TotalEPer2Loc = CreateVar(FP)
	iv.S_TotalEPer3Loc = CreateVar(FP)
	iv.S_TotalEPer4Loc = CreateVar(FP)
	iv.S_BreakShieldLoc = CreateVar(FP)
	iv.BreakShieldLoc = CreateVar(FP)
	iv.S_TotalEPer4XLoc = CreateVar(FP)
	iv.S_BreakShield2Loc = CreateVar(FP)
	iv.S_BossSTicLoc = CreateVar(FP)
	iv.S_BossLVUPLoc = CreateVar(FP)
	iv.PlayTimeLoc = CreateVar(FP)
	iv.PlayTimeLoc2 = CreateVar(FP)
	iv.StatPLoc = CreateVar(FP)
	iv.MoneyLoc = CreateWar(FP)
	iv.MoneyLoc2 = CreateVar(FP)
	iv.CredLoc = CreateWar(FP)
	iv.ExpLoc = CreateWar(FP)
	iv.TotalExpLoc = CreateWar(FP)
	iv.InterfaceNumLoc = CreateVar(FP)
	iv.UpgradeLoc = CreateVar(FP)
	iv.EXPIncomeLoc = CreateVar(FP)
	iv.EXPIncomeLoc2 = CreateVar(FP)
	iv.StatEffLoc = CreateCcode()
	iv.ScoutDmgLoc = CreateVar(FP)
	iv.AddScLoc = CreateVar(FP)
	iv.MulOpLoc = CreateVar(FP)
	iv.BrightLoc = CreateVar2(FP,nil,nil,31)
	iv.LCP = CreateVar(FP)
	iv.ResetStatLoc = CreateVar(FP)
	iv.ResetStat2Loc = CreateVar(FP)
	iv.UpgradeUILoc = CreateVar(FP)
	iv.PMission = CreateVarArr(7, FP)
	iv.NextOreLoc = CreateVar(FP)
	iv.NextGasLoc = CreateVar(FP)
	iv.NextOreMulLoc = CreateVar(FP)
	iv.NextGasMulLoc = CreateVar(FP)
	iv.SellTicketLoc = CreateVar(FP)
	iv.TimeAttackScoreLoc = CreateVar(FP)
	iv.TimeAttackScore48Loc = CreateVar(FP)
	iv.Stat_BossSFrgLoc = CreateVar(FP)
	iv.Stat_XEPer44Loc = CreateVar(FP)
	iv.Stat_XEPer45Loc = CreateVar(FP)
	iv.Stat_XEPer46Loc = CreateVar(FP)
	iv.Stat_XEPer47Loc = CreateVar(FP)

	iv.CS_CooldownLoc = CreateVar(FP)
	iv.CS_AtkLoc = CreateVar(FP)
	iv.CS_EXPLoc = CreateVar(FP)
	iv.CS_TotalEPerLoc = CreateVar(FP)
	iv.CS_TotalEper4Loc = CreateVar(FP)
	iv.CS_DPSLVLoc = CreateVar(FP)
	iv.PUnitLevelLoc = CreateVar(FP)
	iv.PUnitClassLoc = CreateVar(FP)
	iv.VaccItemLoc = CreateVar(FP)
	iv.SCCoolLoc = CreateVar(FP)
	iv.PETicketLoc = CreateVar(FP)
	iv.CreditAddSCLoc = CreateVar(FP)
	iv.S_LV3IncmLoc = CreateVar(FP)
	iv.DayCheck2Loc = CreateVar(FP)
	iv.FfragItemLoc = CreateWar(FP)
	iv.FfragItemUsedLoc = CreateWar(FP)
	iv.TempIncmLoc = CreateWar(FP)
	
	iv.FXPer44Loc = CreateVar(FP)
	iv.FXPer45Loc = CreateVar(FP)
	iv.FXPer46Loc = CreateVar(FP)
	iv.FXPer47Loc = CreateVar(FP)
	iv.FIncmLoc = CreateVar(FP)
	iv.FSEXPLoc = CreateVar(FP)
	iv.FMEPerLoc = CreateVar(FP)
	iv.FBrShLoc = CreateVar(FP)
	iv.XEPer44Loc = CreateVar(FP)
	iv.XEPer45Loc = CreateVar(FP)
	iv.XEPer46Loc = CreateVar(FP)
	iv.XEPer47Loc = CreateVar(FP)
	iv.CXEPerLoc = CreateVar(FP)
	iv.CMEPerLoc = CreateVar(FP)
	iv.CBrShLoc = CreateVar(FP)
	iv.Cost_FXPer44Loc = CreateVar(FP)
	iv.Cost_FIncmLoc = CreateVar(FP)
	iv.Cost_FXPer45Loc = CreateVar(FP)
	iv.Cost_FSEXPLoc = CreateVar(FP)
	iv.Cost_FXPer46Loc = CreateVar(FP)
	iv.Cost_FBrShLoc = CreateVar(FP)
	iv.Cost_FXPer47Loc = CreateVar(FP)
	iv.Cost_FMEPerLoc = CreateVar(FP)
	iv.AwakItemLoc = CreateVar(FP)
	iv.FirstRewardLimLoc = CreateVar(FP)
	iv.RandomSeed1 = CreateVarArr(7,FP)
	iv.RandomSeed2 = CreateVarArr(7,FP)
	iv.RandomSeed3 = CreateVarArr(7,FP)
	iv.RandomSeed4 = CreateVarArr(7,FP)
	iv.RandomSeed5 = CreateVarArr(7,FP)
	iv.RandomSeed6 = CreateVarArr(7,FP)
	iv.RandomSeed7 = CreateVarArr(7,FP)
	iv.RandomSeed8 = CreateVarArr(7,FP)
	iv.RandomSeed9 = CreateVarArr(7,FP)
	iv.RandomSeed10 = CreateVarArr(7,FP)
	
	--Temp
	iv.CTStatP2 = CreateVar(FP)

	iv.TempReadV = CreateVar(FP)
	iv.TempReadW = CreateWar(FP)
	iv.TempEXPW = CreateWar(FP)
	iv.TempEXPW2 = CreateWar(FP)

	iv.CheatDetect = CreateCcode()
	iv.StatTest = CreateCcode()
	iv.FStatTest = CreateCcode()
	iv.SaveRemind = CreateCcode()
	iv.PartyBonus = CreateCcode()
	iv.PartyBonus2 = CreateCcode()
	iv.PBossClearFlag = CreateCcode()

	iv.PEXP2 = CreateWarArr(7, FP) -- 1/10�� ���� ����ġ�� ���� �� �����. ��� ����


	iv.TempO = CreateVarArr(7,FP)
	iv.TempG = CreateVarArr(7,FP)
	iv.TempX = CreateVarArr(7,FP)
	ct.TempO = CreateVarArr(7,FP)
	ct.TempG = CreateVarArr(7,FP)
	ct.TempX = CreateVarArr(7,FP)





	iv.PCheckV = CreateVar(FP)--�÷��̾� �� üũ
	iv.B_IncomeMax = CreateVar(FP)
	iv.B_TotalEPer = CreateVar(FP)
	iv.B_TotalEPer2 = CreateVar(FP)
	iv.B_TotalEPer3 = CreateVar(FP)
	iv.B_Stat_EXPIncome = CreateVar(FP)
	iv.B_Stat_Upgrade = CreateVar(FP)
	iv.B_Credit = CreateVar(FP)
	iv.B_Ticket = CreateVar(FP)
	iv.BossLV = CreateVar(FP)

	
	ct.Money = CreateWarArr(7,FP) -- �ڽ��� ���� �� ������
	ct.Money2 = CreateVarArr(7,FP) -- �ڽ��� ���� �� ������
	ct.IncomeMax = CreateVarArr2(7,12,FP) -- �ڽ��� ����� �ִ� ���ּ�
	ct.Income = CreateVarArr(7,FP) -- �ڽ��� ���� ����Ϳ� �������� ���ּ�
	ct.BuildMul1 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	ct.BuildMul2 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	ct.TotalEPer = CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	ct.TotalEPer2 = CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	ct.TotalEPer3 = CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	ct.TotalEPer4 = CreateVarArr(7,FP)--�� ��ȭȮ��(Ư��)
	ct.ScoutDmg = CreateVarArr(7,FP) -- �⺻���� ������
	ct.ScTimer = CreateVarArr(7,FP)
	ct.PTimeV = CreateVarArr(7,FP)
	ct.General_Upgrade = CreateVarArr(7,FP)
	ct.ResetStat = CreateVarArr(7,FP)
	ct.NextOre = CreateVarArr2(7,100,FP) -- ���� �̳׶�
	ct.NextGas = CreateVarArr2(7,100,FP) -- ���� ����
	ct.NextOreMul = CreateVarArr2(7,2,FP) -- ���� �̳׶����
	ct.NextGasMul = CreateVarArr2(7,2,FP) -- ���� �������
	ct.SellTicket = CreateVarArr(7,FP)
	ct.PBossLV = CreateVarArr(7,FP)
	ct.PBossDPS = CreateWarArr(7,FP)
	ct.TotalPBossDPS = CreateWarArr(7,FP)
	ct.Stat_EXPIncome = CreateVarArr(7,FP)-- ����ġ ȹ�淮 ��ġ. ��� ����
	ct.PLevel = CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	ct.StatP = CreateVarArr2(7,5,FP)-- ���� �������� ��������Ʈ
	ct.Stat_BossSTic = CreateVarArr(7,FP)-- ����� ���� ��ġ
	ct.Stat_BossLVUP = CreateVarArr(7,FP)-- ����� ���� ��ġ
	ct.Stat_TotalEPer = CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	ct.Stat_TotalEPerEx = CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	ct.Stat_TotalEPer2 = CreateVarArr(7,FP)-- +2�� Ȯ�� ��ġ
	ct.Stat_TotalEPer3 = CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	ct.Stat_TotalEPer4 = CreateVarArr(7,FP)-- Ư�� Ȯ�� ��ġ
	ct.Stat_BreakShield = CreateVarArr(7,FP)-- �ı� ���� ��ġ
	ct.Stat_Upgrade = CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	ct.Credit = CreateWarArr(7,FP) -- �������� ũ����
	ct.PEXP = CreateWarArr(7, FP) -- �ڽ��� ���ݱ��� ���� �� ����ġ
	ct.TotalExp = CreateWarArr2(7,"10",FP) -- ���ݱ��� �������� ����� ����ġ + ���� �������� �ʿ��� ����ġ
	ct.CurEXP = CreateWarArr(7,FP) -- ���ݱ��� �������� ����� ����ġ
	ct.PStatVer = CreateVarArr(7,FP) -- ���� ����� ���ȹ���
	ct.PlayTime2 = CreateVarArr(7,FP) -- �� �÷���Ÿ��(�� ��)
	ct.PlayTime = CreateVarArr(7,FP) -- �� �÷���Ÿ��(�� ��)
	ct.CreditAddSC = CreateVarArr(7,FP) 
	ct.LV5Cool = CreateVarArr(7,FP)
	ct.B_PCredit = CreateVarArr(7,FP)
	ct.B_PTicket = CreateVarArr(7,FP)
	ct.B_PEXP = CreateVarArr(7,FP)
	ct.TimeAttackScore = CreateVarArr(7,FP)
	ct.TimeAttackScore2 = CreateVarArr2(7,TimeScoreInit,FP)

	ct.RandomSeed1 = CreateVarArr(7,FP)
	ct.RandomSeed2 = CreateVarArr(7,FP)
	ct.RandomSeed3 = CreateVarArr(7,FP)
	ct.RandomSeed4 = CreateVarArr(7,FP)
	ct.RandomSeed5 = CreateVarArr(7,FP)
	ct.RandomSeed6 = CreateVarArr(7,FP)
	ct.RandomSeed7 = CreateVarArr(7,FP)
	ct.RandomSeed8 = CreateVarArr(7,FP)
	ct.RandomSeed9 = CreateVarArr(7,FP)
	ct.RandomSeed10 = CreateVarArr(7,FP)
	ct.BanFlag = CreateVarArr(7,FP)
	ct.BanFlag2 = CreateVarArr(7,FP)
	ct.BanFlag3 = CreateVarArr(7,FP)
	ct.BanFlag4 = CreateVarArr(7,FP)

	ct.VaccItem = CreateVarArr(7, FP)
	
	ct.PUnitLevel = CreateVarArr(7,FP)
	ct.PUnitClass = CreateVarArr(7,FP)

	ct.CurPUnitCool = CreateVarArr(7,FP)

	ctg.PCheckV = CreateVar(FP)--�÷��̾� �� üũ
	ctg.B_IncomeMax = CreateVar(FP)
	ctg.B_TotalEPer = CreateVar(FP)
	ctg.B_TotalEPer2 = CreateVar(FP)
	ctg.B_TotalEPer3 = CreateVar(FP)
	ctg.B_Stat_EXPIncome = CreateVar(FP)
	ctg.B_Stat_Upgrade = CreateVar(FP)
	ctg.B_Credit = CreateVar(FP)
	ctg.B_Ticket = CreateVar(FP)
	ctg.BossLV = CreateVar(FP)
	iv.GeneralPlayTime = CreateVar(FP)
	iv.CUnitT = CreateVar(FP)
	ctg.CUnitT = CreateVar(FP)
	iv.XEPerT,ct.XEPerT = CreateVars(2,FP)
	iv.XEPerM,ct.XEPerM = CreateVars(2,FP)


	iv.CT_PLevel = CreateVarArr2(7,1,FP)
	--Balance

	--PUpgrade = CreateVarArr(7,FP)
	UnitWep = CreateVarArr(7,FP)
	DmgFactor = CreateVarArr(7,FP)
	Dmg = CreateVarArr(7,FP)

	--EXPArr = {}
	--for i = 1, 10000 do
	--	EXPArr[i] = 10+((i-1)*(i*3))
	--end
	--SRTable = {5000,50000,100000,200000,500000}
	--EXPArr = CreateLArr(LevelLimit+1, FP)
	--EXPArr = f_GetFileArrptr(FP,EXPArr,4,1)
	
	EXPArr = f_GetFileptr(FP, "expdata", 1)
	EXPArr_dp = f_GetFileptr(FP, "expdata_dp", 1)
	--SRTable = f_GetFileArrptr(FP,SRTable,4,1)

	LevelUnitArr = {} -- ��� ��ȭ ���� ���� ���̺�. �� 1~4 �ε����� Level,UnitID,Percent,Exp
	AutoEnchArr = {} -- �ڵ���ȭ ������ ������ �¾ƺ�
	AutoEnchArr2 = {} -- �ڵ���ȭ ���� ���� ���� �Ǻ��� ������ �¾ƺ�
	AutoSellArr = {} -- �ڵ���ȭ ������ ������ �¾ƺ�
	AutoBuyArr = { -- �ڵ����� ���� ������ ���̺�
		{1,"1500"},
		{7,"40000"},
		{11,"700000"},
		{15,"8000000"},
		{18,"100000000"},
		{20,"600000000"},
		{22,"3500000000"},
		{24,"20000000000"},
		{26,"100000000000"},
		{28,"600000000000"},
		{30,"3500000000000"},
		{32,"20000000000000"},
		{34,"120000000000000"},
		{36,"800000000000000"},
		{37,"6000000000000000"},
		{38,"50000000000000000"},
		{39,"800000000000000000"},
		{40,"10000000000000000000"},
	}
	PatchInit() -- ���� ��ġ ���̺� �ʱ�ȭ
	if Limit == 1 then
		PUT={}
		PWT={}
	end
	--PushLevelUnit(����, ��ȭȮ��, �ǸŽ�_����ġ��, ����ID, ����ID, ���ݼӵ�, ������, ���ݷ����� ��뿩��, ������_�ִ�����or��������, ��������ü��)
	--���ݼӵ� : 1,12,24,48,72 (�ſ���� ,����, ����, ����, �ſ����)
	PushLevelUnit(1,60000,0,0,0,24,1,60)--���� 10��
	PushLevelUnit(2,60000,0,1,2,72,10,59)--��Ʈ
	PushLevelUnit(3,57500,0,2,4,72,20,59)--���� 300��
	PushLevelUnit(4,54300,0,7,13,48,20,59)--������ 
	PushLevelUnit(5,50000,0,8,16,48,30,59)--���̽� 4000��
	PushLevelUnit(6,50000,0,5,11,48,50,59,1)--��ũ
	PushLevelUnit(7,50000,0,3,7,48,80,59,1)--�� 
	PushLevelUnit(8,50000,0,32,25,72,60,59)--�ĺ� 3Ÿ 2����
	PushLevelUnit(9,47000,0,58,103,48,80,59)--��Ű�� 2Ÿ
	PushLevelUnit(10,46500,0,12,19,48,250,59)--��Ʋ



	PushLevelUnit(11,46300,0,65,64,72,250,59)--���� 2Ÿ 6����
	PushLevelUnit(12,45200,0,66,66,48,400,59)--���
	PushLevelUnit(13,45000,0,67,68,48,550,59)--����
	PushLevelUnit(14,45000,0,61,111,72,1000,59)--����
	PushLevelUnit(15,44000,1,83,115,72,1300,59,nil,1)--����
	PushLevelUnit(16,44000,2,70,73,48,1000,59)--��ī��
	PushLevelUnit(17,44000,5,60,100,48,1300,59)--Ŀ����
	PushLevelUnit(18,43000,10,71,77,48,1800,59)--�ƺ���


	
	PushLevelUnit(19,42000,15,37,35,12,600,59)--���۸�
	PushLevelUnit(20,38000,27,38,38,24,2000,59)--�����
	PushLevelUnit(21,38000,45,43,48,24,2700,59)--��Ż
	PushLevelUnit(22,36000,80,44,46,24,3500,59)--�����
	PushLevelUnit(23,36000,160,62,104,24,5000,59)--��ٿ췯
	PushLevelUnit(24,35000,335,39,40,24,6500,59)--��Ʈ��
	PushLevelUnit(25,30000,750,46,50,12,5000,59)--����



	PushLevelUnit(25+1,25000,15000/2,20,1,24,10,59)--����
	PushLevelUnit(25+2,25000,21000/2,16,3,48,30,59)--���
	PushLevelUnit(25+3,25000,37500/2,19,5,24,20,59)--��������
	PushLevelUnit(25+4,25000,60000/2,17,10,24,30,59,1,1)--�˷�
	PushLevelUnit(25+5,25000,102000/2,23,12,48,100,59,1)--��ũ
	PushLevelUnit(25+6,25000,188000/2,53,39,24,80,59)--����
--	PushLevelUnit(25+7,20000,350000/2,52,51,24,150,59)--��Ŭ��
--	PushLevelUnit(25+8,20000,750000/2,69,53,72,700,59)--��Ʋ
--	PushLevelUnit(25+9,20000,1500000/2,41,43,24,350,59)--���
--	PushLevelUnit(25+10,20000,3000000/2,40,42,48,1200,59)--��
	PushLevelUnit(25+7,20000,300000/2,52,51,24,150,59)--��Ŭ��
	PushLevelUnit(25+8,20000,500000/2,69,53,72,700,59)--��Ʋ
	PushLevelUnit(25+9,20000,1000000/2,41,43,24,350,59)--���
	PushLevelUnit(25+10,20000,1600000/2,40,42,48,1200,59)--��


	PushLevelUnit(25+11,16000,5000000/2,10,26,72,1000,59)--�ĺ����� 3Ÿ
	PushLevelUnit(25+12,12000,8000000/2,75,85,24,2000,59)--������
	PushLevelUnit(25+13,10000,12000000/2,29,21,24,4000,59)--����
	PushLevelUnit(25+14,5000,20000000/2,86,78,12,3500,59)--�ٴϸ�
	SetWeaponsDatX(25,{WepName=1441})--�ĺ�3��Ÿ ����ó��
	SetWeaponsDatX(103,{WepName=1439})--��Ű��2��Ÿ ����ó��
	SetWeaponsDatX(64,{WepName=1440})--����2��Ÿ ����ó��
	SetWeaponsDatX(26,{WepName=1441})--�ĺ�3��Ÿ ����ó��
	PushLevelUnit(25+15,9000,50000000/2,54,36,5,4000,59,nil,1)--������� �����ִ� -- �������� 16.4
	PushLevelUnit(25+16,12000,60000000,11,15,72,40,59)--����� -- �������� 13.4
	PushLevelUnit(25+17,20000,150000000,9,22,48,70,59)--���� -- �������� 5.4
	PushLevelUnit(25+18,25000,800000000,76,71,24,120,59)--��ĭ -- �������� 0.4
	PushLevelUnit(25+19,10000,4000000000,63,70,12,400,59)--����Ȯ�� -- ��ũ��ĭ
	PushLevelUnit(25+20,7000,0,74,62,48,2500,59)--����Ȯ�� -- ���κ�
	PushLevelUnit(25+21,4000,0,81,76,24,2800,59)--����Ȯ�� -- 
	PushLevelUnit(25+22,1000,0,78,67,12,3400,59)--����Ȯ��
	PushLevelUnit(25+23,0,0,79,69,4,6550,59)-- �ְ�����

	--���� �뷱�� ����
	--PushLevelUnit(25+16,4000,70,73,48,1000,100,59)--��ī��
	--PushLevelUnit(25+17,4000,60,100,48,1300,130,59)--Ŀ����
	--PushLevelUnit(25+18,3000,71,77,48,1800,180,59)--�ƺ���
	--PushLevelUnit(25+19,3000,37,35,12,600,60,59)--���۸� 
	--PushLevelUnit(25+20,2000,38,38,24,2000,200,59)--�����
	--PushLevelUnit(25+21,2000,43,48,24,2700,270,59)--��Ż
	--PushLevelUnit(25+22,1000,44,46,48,7000,700,59)--�����
	--PushLevelUnit(25+23,1000,62,104,24*4,20000,2000,59)--��ٿ췯
	--PushLevelUnit(25+24,500,39,40,48,13000,1300,59)--��Ʈ��
	--PushLevelUnit(25+25,500,46,50,48,18000,1800,59)--����

	SetUnitAbility(88,114,255,37,100,58,1,nil,60,0,3*32) -- �⺻����
	
	table.insert(MCTCondArr,MemoryB(0x6616E0+88,Exactly,130))
	table.insert(MCTCondArr,MemoryB(0x6636B8+88,Exactly,114))
	table.insert(MCTCondArr,MemoryB(0x6637A0 + (88),Exactly,0)) 
	table.insert(MCTCondArr,MemoryW(0x656EB0+(114 *2),Exactly,37)) 
	table.insert(MCTCondArr,MemoryW(0x657678+(114 *2),Exactly,100)) 
	table.insert(MCTCondArr,MemoryB(0x656FB8+114,Exactly,255)) 
	table.insert(MCTCondArr,MemoryB(0x6571D0+114,Exactly, 58)) 
	table.insert(MCTCondArr,MemoryB(0x663150 + (88),Exactly,4)) 
	table.insert(MCTCondArr,MemoryX(0x664080 + (88*4),Exactly,0+0x20000000,4+8+0x20000000)) 
	table.insert(MCTCondArr,Memory(0x657470+(114 *4),Exactly,3*32)) 
	table.insert(MCTCondArr,MemoryB(0x6566F8+114,Exactly,1)) 
	table.insert(MCTCondArr,MemoryB(0x6564E0+114,Exactly,1)) 




	PBossArr = {
		{84,"1300"},
		{36,"4800"},
		{59,"12000"},
		{45,"40000"},
		{49,"130000"},
		{68,"3222"},
		{34,"32222"},
		{51,"1322222"},
		{42,"3222222"},
	}--{,""},--���� �ǹ� ���̵�, DPS �䱸��ġ
if TestStart == 1 then
	BossArr = {
		{87,"10000"},
		{25,"150000"},
		{80,"1100000"},
		{57,"9300000"},
		{72,"20000000"},
		{77,"63222"},
	}--{,""},--���� �ǹ� ���̵�, DPM �䱸��ġ
else
	BossArr = {
		{87,"10000"},
		{25,"150000"},
		{80,"1100000"},
		{57,"9300000"},
		{72,"34000000"},
		{77,"63222"},
	}--{,""},--���� �ǹ� ���̵�, DPM �䱸��ġ
end
FirstReward = {
	{20,500},
	{22,7000},
	{24,20000},
	{26,80000},
}
for i = 34,40 do
	table.insert(FirstReward, {LevelUnitArr[i][1],LevelUnitArr[i][4]*10})
end
FirstReward2 = {
	{40,10000},
	{41,30000},
	{42,80000},
	{43,150000},
	{44,1000000},
}

FirstReward3 = {
	{45,5000000,32,"\x1C",10},
	{46,20000000,322,"\x1E",7},
	{47,50000000,3222,"\x02",4},
	{48,322222222,32222,"\x1B",1},
}
	NBagArr = {}
	for i = 0,6 do
		table.insert(NBagArr,NBag(FP, 1, 521))
	end

	OreDPS = {100,1000,10000,100000,500000,1000000,5000000,0}
	OreDPSM = {2,4,8,16,32,64,128}
	GasDPS = {100,1000,10000,100000,1000000,5000000,10000000,0}
	GasDPSM = {2,4,8,16,32,64,128}
	PopLevelUnit() -- �뷱���� ��� ������ ��ȭ���� ������ ó���� �Լ�
	Cost_Stat_BossSTic = 250
	Cost_Stat_BossLVUP = 250
	Cost_Stat_Upgrade = 20
	Cost_Stat_TotalEPer = 10
	Cost_Stat_TotalEPerEx = 1000
	Cost_Stat_TotalEPerEx2 = 2500
	Cost_Stat_TotalEPerEx3 = 5000
	Cost_Stat_TotalEPer2 = 200
	Cost_Stat_TotalEPer3 = 1000
	Cost_Stat_TotalEPer4 = 500
	Cost_Stat_TotalEPer4X = 1000
	Cost_Stat_BreakShield = 250
	Cost_Stat_BreakShield2 = 1000
	Cost_Stat_LV3Incm = 100
	Cost_Stat_BossSFrg = 1000
	Cost_Stat_XEPer44 = 1000
	Cost_Stat_XEPer45 = 4000
	Cost_Stat_XEPer46 = 7000
	Cost_Stat_XEPer47 = 10000
	PersonalUIDArr = {21,27,28,48,55,56,64}
	PersonalWIDArr = {118,119,120,121,122,123,124}
	PlayerPosArr = {
		{512+640,256},
		{512+1568,256},
		{512+2528,256},
		{512+3488,256},
		{512+4416,256},
		{512+5344,256},
		{512+6272,256},
	}
	
	--100+(n*100)
	--���� ���ϰ� 10000 C
	--for n = 0, 100 do
	--	PUnitAtkArr[n+1] = 10+(n*n*6.5524)
	--	PUnitCoolArr[n+1] = (100-n)*256
	--end
	--PUnitAtkArr = f_GetFileArrptr(FP,PUnitAtkArr,4,1)
	--�±޺�� 100��C
	--�±޽� ��ȭ�ܰ� �ʱ�ȭ�ϰ� �Ʒ� �׸��� ��1�Ͽ� ���� �̷ο� ȿ���� ����.

	--1�׸� ���ݼӵ� �⺻ 72 48 24 12 6 3 1 �� 6�ܰ� ��ȭ
	--2�׸� ���ݷ� �� 10�ܰ� ��ȭ. 13000�� ����(6500), ó���� ������ 0
	--3�׸� ����ġ ȹ�淮 20%�� �� 5ȸ
	--4�׸� +1 ��ȭȮ�� 1.0%p�� �� 5ȸ
	--5�׸� Ư��Ȯ�� 0.5%p�� �� 10ȸ 
	--6�׸� ����� ���� 1ȸ��. LV.MAX����ʹ� �ʹ������
	iv.CS_Cooldown = CreateVarArr(7,FP)
	iv.CS_Atk = CreateVarArr(7,FP)
	iv.CS_EXP = CreateVarArr(7,FP)
	iv.CS_TotalEPer = CreateVarArr(7,FP)
	iv.CS_TotalEper4 = CreateVarArr(7,FP)
	iv.CS_DPSLV = CreateVarArr(7,FP)
	iv.PUnitLevel = CreateVarArr(7,FP)
	iv.PUnitClass = CreateVarArr(7,FP)
	iv.VaccItem = CreateVarArr(7, FP)

	ct.CS_Cooldown = CreateVarArr(7,FP)
	ct.CS_Atk = CreateVarArr(7,FP)
	ct.CS_EXP = CreateVarArr(7,FP)
	ct.CS_TotalEPer = CreateVarArr(7,FP)
	ct.CS_TotalEper4 = CreateVarArr(7,FP)
	ct.CS_DPSLV = CreateVarArr(7,FP)

	iv.CS_EXPData = CreateVarArr(7,FP)
	iv.CS_TEPerData = CreateVarArr(7,FP)
	iv.CS_TEPer4Data = CreateVarArr(7,FP)
	ct.CS_EXPData = CreateVarArr(7,FP)
	ct.CS_TEPerData = CreateVarArr(7,FP)
	ct.CS_TEPer4Data = CreateVarArr(7,FP)
	
	--PUnitAtkArr = {}
	PUnitCoolArr = {72*256,48*256,24*256,12*256,6*256,3*256,1*256}
	PUnitCoolArr = f_GetFileArrptr(FP,PUnitCoolArr,4,1)

	CS_CooldownLimit = 6
	CS_AtkLimit = 20
	CS_EXPLimit = 5
	CS_TotalEPerLimit = 20
	CS_TotalEper4Limit = 10
	CS_DPSLVLimit = 1
	CSX_LV3IncmLimit = 60
	CS_BreakShieldLimit = 200



----	--{Max,FileArr}
--	Cost_FXPer44 = CreateCostData(100,function(n) return 1+((n-1)*(n*1)) end)
--	--������ 10.0% = 30��, 
--	Cost_FXPer45 = CreateCostData(100,function(n) return 1+((n-1)*(n*4)) end)
--	--������ 10.0% = 130��,
--	Cost_FXPer46 = CreateCostData(100,function(n) return 1+((n-1)*(n*7)) end)
--	--������ 10.0% = 230��, 
--	Cost_FXPer47 = CreateCostData(100,function(n) return 1+((n-1)*(n*10)) end)
--	--������ 10.0% = 330��, 
--	Cost_FMEPer = CreateCostData(300,function(n) return 1000+((n-1)*(n*1)*n) end)
--	--������ 1.0% = 2500��, ���ø�Ʈ 3.0% 20��
--	Cost_FIncm = CreateCostData(900,function(n) return n*50 end)
--	--���ø�Ʈ 10000% = 2000��
--	Cost_FSEXP = CreateCostData(1000,function(n) return 100+(2*n) end)
--	--���ø�Ʈ 10000% = 110��
--	Cost_FBrSh = CreateCostData(150,function(n) return 1000+((n-1)*(n*20)*n) end)
--	--���ø�Ʈ 15.0% = 25��


	
	--	--{Max,FileArr}
	Cost_FXPer44 = CreateCostData(100,function(n) return 1+((n-1)*(n*1)) end)
	--������ 10.0% = 30��, 
	Cost_FXPer45 = CreateCostData(100,function(n) return 1+((n-1)*(n*4)) end)
	--������ 10.0% = 130��,
	Cost_FXPer46 = CreateCostData(100,function(n) return 1+((n-1)*(n*7)) end)
	--������ 10.0% = 230��, 
	Cost_FXPer47 = CreateCostData(100,function(n) return 1+((n-1)*(n*10)) end)
	--������ 10.0% = 330��, 
	Cost_FMEPer = CreateCostData(300,function(n) return 1000+((n-1)*(n*11)) end)
	--������ 1.0% = 376��, ���ø�Ʈ 3.0% 1��
	Cost_FIncm = CreateCostData(500,function(n) return 1+((n-1)*(n*0.5)) end)
	--���ø�Ʈ 10000% = 2000��
	Cost_FSEXP = CreateCostData(1000,function(n) return 100+(2*n) end)
	--���ø�Ʈ 10000% = 110��
	Cost_FBrSh = CreateCostData(150,function(n) return 1000+((n-1)*(n*1)*n) end)
	--���ø�Ʈ 15.0% = 1.2��

--	Cost_FXPer44 = 10
--	Cost_FXPer45 = 40
--	Cost_FXPer46 = 70
--	Cost_FXPer47 = 100
--	Cost_FIncm = 100
--	Cost_FSEXP = 150
--	Cost_FMEPer = 500
--	Cost_FBrSh = 1000

--	CreateCostData(Max,SFunc)



	--�׿� ���� Ȯ������ �� - �⺻ ���� ����(�� 1,2,5,10��)
end