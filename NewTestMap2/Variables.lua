function Include_Vars()
	--System
	HumanPlayers={P1,P2,P3,P4,P5,P6,P7,P9,P10,P11,P12}
	LimitVerPtr = 0x58f608
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
	--MSQC_KeySet("P",502)
	MSQC_KeySet("F9",13)
	MSQC_KeySet("F12",503)--�׽�Ʈ��
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
	--Interface
	TestShop = CreateVarArr(7, FP) -- �׽�Ʈ���̾��µ� ���۵��ؼ� ���� ���Ǳ⿡ �����
	TBLFlag = CreateCcode() -- TBL ���� ���� �Ǻ��� ������. ���� ������ �����Ǹ� ���۾���
	SettingUnit1 = CreateVarArr(7, FP)-- 1~25�� ���� �ڵ���ȭ ������
	SettingUnit2 = CreateVarArr(7, FP)-- 26~39�� ���� �ڵ���ȭ ������

	SettingUnit3 = CreateVarArr(7, FP)-- 15~25�� ���� �ڵ��Ǹ� ������
	SettingUnit4 = CreateVarArr(7, FP)-- 26~39�� ���� �ڵ��Ǹ� ������
	ShopUnit = CreateVarArr(7, FP) -- �ùμ�����

	DpsLV1 = CreateVarArr(7, FP) -- ù��° DPS�ǹ�
	DpsLV2 = CreateVarArr(7, FP) -- �ι�° DPS�ǹ�
	
	Names = CreateVArrArr(7, 7, FP) -- �� �÷��̾� �̸� �����

	ELevel = CreateVar(FP)--���� ��ȭ���� ����
	--EExp = CreateVar(FP)
	ECP = CreateVar(FP) -- ��ȭ ����� ����. ���� ��ȭ���� �÷��̾ ������
	GEper = CreateVar(FP) -- ��ȭ ����� ����. �ش��÷��̾��� +1�� Ȯ���� ������
	GEper2 = CreateVar(FP) -- ��ȭ ����� ����. �ش��÷��̾��� +2�� Ȯ���� ������
	GEper3 = CreateVar(FP) -- ��ȭ ����� ����. �ش��÷��̾��� +3�� Ȯ���� ������
	UEper = CreateVar(FP) -- ��ȭ ����� ����. ��ȭ�� ������ Ȯ���� ������

	ShopSw = CreateCcodeArr(7) -- 
	ShopKey = CreateCcodeArr(7) -- 

	Etbl = CreateVar(FP) -- ������ tblPtr����� ����. ���� ��ȭȮ�� ǥ���

	--String
	
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",3)) 
	Str1, Str1a, Str1s = SaveiStrArr(FP,MakeiStrVoid(54))


	-- Interface Variable

	iv={} -- ���� ���� ���̺�

	--PlayData(NonSCA)
	iv.Money = CreateWarArr(7,FP) -- �ڽ��� ���� �� ������
	iv.IncomeMax = CreateVarArr2(7,12,FP) -- �ڽ��� ����� �ִ� ���ּ�
	iv.Income = CreateVarArr(7,FP) -- �ڽ��� ���� ����Ϳ� �������� ���ּ�
	iv.BuildMul1 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	iv.BuildMul2 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	iv.TotalEPer = CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	iv.TotalEPer2 = CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	iv.TotalEPer3 = CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	iv.ScoutDmg = CreateVarArr(7,FP) -- �⺻���� ������
	iv.ScTimer = CreateCcodeArr(7)

	--General
	iv.BossLV = CreateVar(FP)
	
	--Setting, Effect
	iv.StatEff = CreateCcodeArr(7) -- ������ ����Ʈ
	iv.StatEffT2 = CreateCcodeArr(7) -- ������ ����Ʈ
	iv.InterfaceNum = CreateVarArr(7,FP) -- �����̳� ���� ��� â �����
	iv.Stat_Upgrade_UI = CreateVarArr(7,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
	iv.AutoBuyCode = CreateVarArr(7,FP)-- �ڵ� ���� ���� ������
	iv.PCheckV = CreateVar(FP)--�÷��̾� �� üũ
	iv.MulOp = CreateVarArr2(7,1,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
	
	--PlayData(SCA)
	iv.PLevel = CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	iv.StatP = CreateVarArr(7,FP)-- ���� �������� ��������Ʈ
	iv.Stat_ScDmg = CreateVarArr(7,FP)-- ����� ���� ��ġ
	iv.Stat_AddSc = CreateVarArr(7,FP)-- ����� ���� ��ġ
	
	iv.Stat_TotalEPer = CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	iv.Stat_TotalEPer2 = CreateVarArr(7,FP)-- +2�� Ȯ�� ��ġ
	iv.Stat_TotalEPer3 = CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	iv.Stat_Upgrade = CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	iv.Credit = CreateWarArr(7,FP) -- �������� ũ����
	iv.PEXP = CreateWarArr(7, FP) -- �ڽ��� ���ݱ��� ���� �� ����ġ
	iv.TotalExp = CreateWarArr2(7,"10",FP) -- ���ݱ��� �������� ����� ����ġ + ���� �������� �ʿ��� ����ġ
	iv.CurEXP = CreateWarArr(7,FP) -- ���ݱ��� �������� ����� ����ġ
	--Local Data Variable
	iv.IncomeMaxLoc = CreateVar(FP)
	iv.IncomeLoc = CreateVar(FP)
	iv.LevelLoc = CreateVar(FP)
	iv.LevelLoc2 = CreateVar(FP)
	iv.TotalEPerLoc = CreateVar(FP)
	iv.TotalEPer2Loc = CreateVar(FP)
	iv.TotalEPer3Loc = CreateVar(FP)
	iv.S_TotalEPerLoc = CreateVar(FP)
	iv.S_TotalEPer2Loc = CreateVar(FP)
	iv.S_TotalEPer3Loc = CreateVar(FP)
	iv.StatPLoc = CreateVar(FP)
	iv.MoneyLoc = CreateWar(FP)
	iv.CredLoc = CreateWar(FP)
	iv.ExpLoc = CreateVar(FP)
	iv.TotalExpLoc = CreateVar(FP)
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

	--Temp
	iv.CTStatP2 = CreateVar(FP)

	iv.TempReadV = CreateVar(FP)
	iv.TempEXPV = CreateVar(FP)

	iv.CheatDetect = CreateCcode()

	iv.Stat_EXPIncome = CreateVarArr(7,FP)-- ����ġ ȹ�淮 ��ġ. ��� ����
	iv.PEXP2 = CreateVarArr(7, FP) -- 1/10�� ���� ����ġ�� ���� �� �����. ��� ����



	iv.B_IncomeMax = CreateVar(FP)
	iv.B_TotalEPer = CreateVar(FP)
	iv.B_TotalEPer2 = CreateVar(FP)
	iv.B_TotalEPer3 = CreateVar(FP)
	iv.B_Stat_EXPIncome = CreateVar(FP)
	iv.B_Credit = CreateVar(FP)

	--Balance


	EXPArr = {}
	for i = 1, 10000 do
		EXPArr[i] = 10+(10*(i-1)*(i*0.1))
	end
	EXPArr = f_GetFileArrptr(FP,EXPArr,4,1)

	LevelUnitArr = {} -- ��� ��ȭ ���� ���� ���̺�. �� 1~4 �ε����� Level,UnitID,Percent,Exp
	AutoEnchArr = {} -- �ڵ���ȭ ������ ������ �¾ƺ�
	AutoEnchArr2 = {} -- �ڵ���ȭ ���� ���� ���� �Ǻ��� ������ �¾ƺ�
	AutoSellArr = {} -- �ڵ���ȭ ������ ������ �¾ƺ�
	AutoBuyArr = { -- �ڵ����� ���� ������ ���̺�
		{1,"100"},
		{7,"4000"},
		{11,"200000"},
		{15,"5000000"},
		{18,"100000000"},
		{20,"600000000"},
		{22,"3500000000"},
		{24,"20000000000"},
		{26,"100000000000"},
		{28,"600000000000"},
		{30,"3500000000000"},
		{32,"20000000000000"},
	}
	PatchInit() -- ���� ��ġ ���̺� �ʱ�ȭ

	--PushLevelUnit(����, ��ȭȮ��, �ǸŽ�_����ġ��, ����ID, ����ID, ���ݼӵ�, ������, ���ݷ����� ��뿩��, ������_�ִ�����or��������, ��������ü��)
	--���ݼӵ� : 1,12,24,48,72 (�ſ���� ,����, ����, ����, �ſ����)
	PushLevelUnit(1,60000,0,0,0,24,1,60)--���� 10��
	PushLevelUnit(2,60000,0,1,2,72,10,59)--��Ʈ
	PushLevelUnit(3,57500,0,2,4,72,20,59)--���� 300��
	PushLevelUnit(4,54300,0,7,13,48,20,59)--������ 
	PushLevelUnit(5,50000,0,8,16,48,30,59)--���̽� 4000��
	PushLevelUnit(6,45000,0,5,11,48,50,59,1)--��ũ
	PushLevelUnit(7,45000,0,3,7,48,80,59,1)--�� 
	PushLevelUnit(8,43000,0,32,25,72,60,59)--�ĺ� 3Ÿ 2����
	PushLevelUnit(9,43000,0,58,103,48,80,59)--��Ű�� 2Ÿ
	PushLevelUnit(10,40000,0,12,19,48,250,59)--��Ʋ



	PushLevelUnit(11,40000,0,65,64,72,250,59)--���� 2Ÿ 6����
	PushLevelUnit(12,40000,0,66,66,48,400,59)--���
	PushLevelUnit(13,40000,0,67,68,48,550,59)--����
	PushLevelUnit(14,40000,0,61,111,72,1000,59)--����
	PushLevelUnit(15,38000,1,83,115,72,1300,59,nil,1)--����
	PushLevelUnit(16,38000,2,70,73,48,1000,59)--��ī��
	PushLevelUnit(17,38000,5,60,100,48,1300,59)--Ŀ����
	PushLevelUnit(18,38000,10,71,77,48,1800,59)--�ƺ���


	
	PushLevelUnit(19,35000,15,37,35,12,600,59)--���۸�
	PushLevelUnit(20,35000,27,38,38,24,2000,59)--�����
	PushLevelUnit(21,35000,45,43,48,24,2700,59)--��Ż
	PushLevelUnit(22,35000,80,44,46,24,3500,59)--�����
	PushLevelUnit(23,30000,160,62,104,24,5000,59)--��ٿ췯
	PushLevelUnit(24,30000,335,39,40,24,6500,59)--��Ʈ��
	PushLevelUnit(25,20000,750,46,50,12,5000,59)--����



	PushLevelUnit(25+1,25000,1500,20,1,24,10,59)--����
	PushLevelUnit(25+2,25000,2100,16,3,48,30,59)--���
	PushLevelUnit(25+3,25000,3750,19,5,24,20,59)--��������
	PushLevelUnit(25+4,25000,6000,17,10,24,30,59,1,1)--�˷�
	PushLevelUnit(25+5,25000,10200,23,12,48,100,59,1)--��ũ
	PushLevelUnit(25+6,25000,18800,53,39,24,80,59)--����
	PushLevelUnit(25+7,20000,30000,52,51,24,150,59)--��Ŭ��
	PushLevelUnit(25+8,20000,50000,69,53,72,700,59)--��Ʋ
	PushLevelUnit(25+9,20000,100000,41,43,24,350,59)--���
	PushLevelUnit(25+10,20000,160000,40,42,48,800,59)--��



	PushLevelUnit(25+11,16000,300000,10,26,72,600,59)--�ĺ����� 3Ÿ
	PushLevelUnit(25+12,12000,800000,75,85,24,1200,59)--������
	PushLevelUnit(25+13,10000,1200000,29,21,24,4000,59)--����
	PushLevelUnit(25+14,5000,2000000,86,78,12,3500,59)--�ٴϸ�
	PushLevelUnit(25+15,1000,5000000,54,36,1,4200,59,nil,1)--������� �����ִ�
	SetWeaponsDatX(25,{WepName=1441})--�ĺ�3��Ÿ ����ó��
	SetWeaponsDatX(103,{WepName=1439})--��Ű��2��Ÿ ����ó��
	SetWeaponsDatX(64,{WepName=1440})--����2��Ÿ ����ó��
	SetWeaponsDatX(26,{WepName=1441})--�ĺ�3��Ÿ ����ó��


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

	SetUnitAbility(88,114,5,2,1000,58,1,nil,60) -- �⺻����
	BossArr = {
		{87,"10000"},
		{25,"150000"},
		{80,"900000"},
		{57,"6300000"},
		{72,"20000000"},
	}--{,""},--���� �ǹ� ���̵�, DPM �䱸��ġ

	PopLevelUnit() -- �뷱���� ��� ������ ��ȭ���� ������ ó���� �Լ�


end