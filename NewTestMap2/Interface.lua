function Interface()
	--PlayData(NonSCA)
	local Money = iv.Money-- CreateWarArr(7,FP) -- �ڽ��� ���� �� ������
	local Money2 = iv.Money2-- CreateWarArr(7,FP) -- �ڽ��� ���� �� ������
	local IncomeMax = iv.IncomeMax-- CreateVarArr2(7,12,FP) -- �ڽ��� ����� �ִ� ���ּ�
	local Income = iv.Income-- CreateVarArr(7,FP) -- �ڽ��� ���� ����Ϳ� �������� ���ּ�
	local BuildMul1 = iv.BuildMul1-- CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	local BuildMul2 = iv.BuildMul2-- CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	local TotalEPer = iv.TotalEPer-- CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	local TotalEPer2 = iv.TotalEPer2-- CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	local TotalEPer3 = iv.TotalEPer3-- CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	local TotalEPer4 = iv.TotalEPer4-- CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	local ScoutDmg = iv.ScoutDmg-- CreateVarArr(7,FP) -- �⺻���� ������
	local ScTimer = iv.ScTimer-- CreateCcodeArr(7)
	local PTimeV = iv.PTimeV
	local ResetStat = iv.ResetStat
	local General_Upgrade = iv.General_Upgrade--CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	local PBossLV = iv.PBossLV -- ���κ�������
	local PBossDPS = iv.PBossDPS-- ���κ���DPS
	local TotalPBossDPS = iv.TotalPBossDPS --���κ���DPS ��ǥġ
	local SellTicket = iv.SellTicket
	local BanFlag = iv.BanFlag
	local BanFlag2 = iv.BanFlag2
	local BanFlag3 = iv.BanFlag3
	local BanFlag4 = iv.BanFlag4
	local CS_EXPData = iv.CS_EXPData
	local CS_TEPerData = iv.CS_TEPerData
	local CS_TEPer4Data = iv.CS_TEPer4Data
	local PUnitEnchCool = iv.PUnitEnchCool
	
	local CurPUnitCool = iv.CurPUnitCool

	local RandomSeed1 = iv.RandomSeed1
	local RandomSeed2 = iv.RandomSeed2
	local RandomSeed3 = iv.RandomSeed3
	local RandomSeed4 = iv.RandomSeed4
	local RandomSeed5 = iv.RandomSeed5
	local RandomSeed6 = iv.RandomSeed6
	local RandomSeed7 = iv.RandomSeed7
	local RandomSeed8 = iv.RandomSeed8
	local RandomSeed9 = iv.RandomSeed9
	local RandomSeed10 = iv.RandomSeed10
	local RSArr = {
		RandomSeed1,
		RandomSeed2,
		RandomSeed3,
		RandomSeed4,
		RandomSeed5,
		RandomSeed6,
		RandomSeed7,
		RandomSeed8,
		RandomSeed9,
		RandomSeed10,
	}

	--General
	local BossLV = iv.BossLV-- CreateVar(FP)
	
	--Setting, Effect
	local StatEff = iv.StatEff--CreateCcodeArr(7) -- ������ ����Ʈ
	local StatEffT2 = iv.StatEffT2--CreateCcodeArr(7) -- ������ ����Ʈ
	local InterfaceNum = iv.InterfaceNum--CreateVarArr(7,FP) -- �����̳� ���� ��� â �����
	local AutoBuyCode = iv.AutoBuyCode--CreateCcodeArr(7)-- �ڵ� ���� ���� ������
	local PCheckV = iv.PCheckV--CreateVar(FP)--�÷��̾� �� üũ
	local MulOp = iv.MulOp--CreateVarArr2(7,1,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
	
	--PlayData(SCA)
	local PLevel = iv.PLevel--CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	local StatP = iv.StatP--CreateVarArr(7,FP)-- ���� �������� ��������Ʈ
	local Stat_ScDmg = iv.Stat_ScDmg--CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_AddSc = iv.Stat_AddSc--CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_TotalEPer = iv.Stat_TotalEPer--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPerEx = iv.Stat_TotalEPerEx--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPerEx2 = iv.Stat_TotalEPerEx2--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPerEx3 = iv.Stat_TotalEPerEx3--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPer2 = iv.Stat_TotalEPer2--CreateVarArr(7,FP)-- +2�� Ȯ�� ��ġ
	local Stat_TotalEPer3 = iv.Stat_TotalEPer3--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_TotalEPer4 = iv.Stat_TotalEPer4--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_BreakShield = iv.Stat_BreakShield--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_Upgrade = iv.Stat_Upgrade--CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	local Credit = iv.Credit--CreateWarArr(7,FP) -- �������� ũ����
	local PEXP = iv.PEXP--CreateWarArr(7, FP) -- �ڽ��� ���ݱ��� ���� �� ����ġ
	local TotalExp = iv.TotalExp--CreateWarArr2(7,"10",FP) -- ���ݱ��� �������� ����� ����ġ + ���� �������� �ʿ��� ����ġ
	local CurEXP = iv.CurEXP--CreateWarArr(7,FP) -- ���ݱ��� �������� ����� ����ġ
	local PStatVer = iv.PStatVer--CreateVarArr(7,FP) -- ���� ����� ���ȹ���
	local PlayTime2 = iv.PlayTime2
	local NextOre = iv.NextOre
	local NextGas = iv.NextGas
	local NextOreMul = iv.NextOreMul
	local NextGasMul = iv.NextGasMul
	local PlayTime = iv.PlayTime
	local CreditAddSC = iv.CreditAddSC
	local LV5Cool = iv.LV5Cool
	local TimeAttackScore = iv.TimeAttackScore
	local TimeAttackScore2 = iv.TimeAttackScore2
	local PUnitLevel = iv.PUnitLevel
	local PUnitClass = iv.PUnitClass
	local CS_Cooldown = iv.CS_Cooldown
	local CS_Atk = iv.CS_Atk
	local CS_EXP = iv.CS_EXP
	local CS_TotalEPer = iv.CS_TotalEPer
	local CS_TotalEper4 = iv.CS_TotalEper4
	local CS_DPSLV = iv.CS_DPSLV

	--Local Data Variable
	local IncomeMaxLoc = iv.IncomeMaxLoc--CreateVar(FP)
	local IncomeLoc = iv.IncomeLoc--CreateVar(FP)
	local LevelLoc = iv.LevelLoc--CreateVar(FP)
	local LevelLoc2 = iv.LevelLoc2--CreateVar(FP)
	local TotalEPerLoc = iv.TotalEPerLoc--CreateVar(FP)
	local TotalEPer2Loc = iv.TotalEPer2Loc--CreateVar(FP)
	local TotalEPer3Loc = iv.TotalEPer3Loc--CreateVar(FP)
	local TotalEPer4Loc = iv.TotalEPer4Loc--CreateVar(FP)
	local S_TotalEPerLoc = iv.S_TotalEPerLoc--CreateVar(FP)
	local S_TotalEPer2Loc = iv.S_TotalEPer2Loc--CreateVar(FP)
	local S_TotalEPer3Loc = iv.S_TotalEPer3Loc--CreateVar(FP)
	local S_TotalEPer4Loc = iv.S_TotalEPer4Loc--CreateVar(FP)
	local PlayTimeLoc = iv.PlayTimeLoc--CreateVar(FP)
	local PlayTimeLoc2 = iv.PlayTimeLoc2--CreateVar(FP)
	local StatPLoc = iv.StatPLoc--CreateVar(FP)
	local MoneyLoc = iv.MoneyLoc--CreateWar(FP)
	local MoneyLoc2 = iv.MoneyLoc2--CreateWar(FP)
	local CredLoc = iv.CredLoc--CreateWar(FP)
	local ExpLoc = iv.ExpLoc--CreateVar(FP)
	local TotalExpLoc = iv.TotalExpLoc--CreateVar(FP)
	local InterfaceNumLoc = iv.InterfaceNumLoc--CreateVar(FP)
	local UpgradeLoc = iv.UpgradeLoc--CreateVar(FP)
	local EXPIncomeLoc = iv.EXPIncomeLoc--CreateVar(FP)
	local EXPIncomeLoc2 = iv.EXPIncomeLoc2--CreateVar(FP)
	local StatEffLoc = iv.StatEffLoc--CreateCcode()
	local ScoutDmgLoc = iv.ScoutDmgLoc--CreateVar(FP)
	local AddScLoc = iv.AddScLoc--CreateVar(FP)
	local MulOpLoc = iv.MulOpLoc--CreateVar(FP)
	local BrightLoc = iv.BrightLoc--CreateVar2(FP,nil,nil,31)
	local LCP = iv.LCP--CreateVar(FP)
	local ResetStatLoc = iv.ResetStatLoc
	local UpgradeUILoc = iv.UpgradeUILoc--CreateVar(FP)
	local NextOreLoc = iv.NextOreLoc
	local NextGasLoc = iv.NextGasLoc
	local NextOreMulLoc = iv.NextOreMulLoc
	local NextGasMulLoc = iv.NextGasMulLoc
	local SellTicketLoc = iv.SellTicketLoc
	--Temp
	local CTStatP2 = iv.CTStatP2--CreateVar(FP)
	local TempReadV = iv.TempReadV--CreateVar(FP)
	local TempReadW = iv.TempReadW--CreateVar(FP)
	local TempEXPW = iv.TempEXPW--CreateVar(FP)

	local CheatDetect = iv.CheatDetect--CreateCcode()
	local TempO = iv.TempO
	local TempG = iv.TempG
	local TempX = iv.TempX



	local B_IncomeMax = iv.B_IncomeMax--CreateVar(FP)
	local B_TotalEPer = iv.B_TotalEPer--CreateVar(FP)
	local B_TotalEPer2 = iv.B_TotalEPer2--CreateVar(FP)
	local B_TotalEPer3 = iv.B_TotalEPer3--CreateVar(FP)
	local B_Stat_EXPIncome = iv.B_Stat_EXPIncome--CreateVar(FP)
	local B_Stat_Upgrade = iv.B_Stat_Upgrade
	local B_Credit = iv.B_Credit--CreateVar(FP)
	local B_PCredit = iv.B_PCredit--CreateVar(FP)
	local B_Ticket = iv.B_Ticket--CreateVar(FP)
	local B_PTicket = iv.B_PTicket--CreateVar(FP)
	local CT_PLevel = iv.CT_PLevel

	local BossRewardEnable= CreateCcode()
	local PartyBonus= iv.PartyBonus
	local GeneralPlayTime= iv.GeneralPlayTime
	local GeneralPlayTime2= CreateVar(FP)
	local SaveRemind = iv.SaveRemind
	--PlayData(NotSureSCA)
	local Stat_EXPIncome = iv.Stat_EXPIncome--CreateVarArr(7,FP)-- ����ġ ȹ�淮 ��ġ. ��� ����
	local PEXP2 = iv.PEXP2--CreateVarArr(7, FP) -- 1/10�� ���� ����ġ�� ���� �� �����. ��� ����
	
	local OreMode = CreateCcodeArr(7)
	local ZKeyCool = CreateCcodeArr(7)

	
	local BossLV6Flag = iv.BossLV6Flag
	PLevelBak = CreateVar(FP)




	--local GEXP = CreateVar(FP)
	--local STable = {"1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "2048", "4096", "8192", "16384", "32768", "65536", "131072", "262144", "524288", "1048576", "2097152", "4194304", "8388608", "16777216", "33554432", "67108864", "134217728", "268435456", "536870912", "1073741824", "2147483648", "4294967296", "8589934592", "17179869184", "34359738368", "68719476736", "137438953472", "274877906944", "549755813888", "1099511627776", "2199023255552", "4398046511104", "8796093022208", "17592186044416", "35184372088832", "70368744177664", "140737488355328", "281474976710656", "562949953421312", "1125899906842624", "2251799813685248", "4503599627370496", "9007199254740992", "18014398509481984", "36028797018963968", "72057594037927936", "144115188075855872", "288230376151711744", "576460752303423488", "1152921504606846976", "2305843009213693952", "4611686018427387904", "9223372036854775807"}

	local Time = iv.Time
	local Time2 = iv.Time2


	CMov(FP,PCheckV,0)
	if TestStart == 1 then
		CAdd(FP,GeneralPlayTime,10000)
	else
		CAdd(FP,GeneralPlayTime,1)
	end

	for i = 0, 6 do
		TriggerX(FP,{HumanCheck(i,1)},{AddV(PCheckV,1)},{preserved})
		TriggerX(FP,{HumanCheck(i,0)},{RemoveUnit("Men", P12),RemoveUnit("Factories", P12)})
	end
	for i = 1, 7 do
		TriggerX(FP,{CV(PCheckV,i)},{SetV(ULimitV,ULimitArr[i]),SetV(ULimitV2,ULimitArr[i]-1)},{preserved})
	end
	if Limit == 1 then
		--DoActionsX(FP,{SetV(PCheckV,7)})
	end
	local PartyBonus2 = iv.PartyBonus2
	DoActions(FP, SetMemory(0x58F500, SetTo, 0))
	
	Trigger2X(FP, {CD(PartyBonus,2,AtLeast)}, {RotatePlayer({DisplayTextX(StrDesignX("\x04���� �ε� �ο��� 2�� �̻� �����Ǿ����ϴ�. \x07�������� 1�� �������� ��Ƽ ������ Ȱ��ȭ�˴ϴ�."))}, Force1, FP)})

	
TipArr = {
	StrDesignX("\x04TIP : \x04���� ���� �� ZŰ�� ������ �Ѱ��� ��Ĩ�ϴ�."),	StrDesignX("\x04TIP : \x1F�̳׶�\x04, \x07����\x04�� ���� �ڽ��� �ǹ��� �������� ��� ���� DPS�� ��Ÿ���ϴ�."),
	StrDesignX("\x04TIP : \x17OŰ\x04�� ������ ���� ���� ���� ���� ������ �й��� �� �ֽ��ϴ�."),
	StrDesignX("\x04TIP : \x04��ȭ ������ �ܰ谡 \x08+1 \x04�Ӹ� �ƴ϶� ���� Ȯ���� \x1C+2\x04, \x1F+3\x04 �� �ö� �� �ֽ��ϴ�."),}

for i = 0, 6 do -- ���÷��̾� 
	CIf(FP,{HumanCheck(i,1)},{SetCp(i),SetV(GCP,i)})
	CT_PrevCP(i)
	CSub(FP,PUnitEnchCool[i+1],1)
	f_LMov(FP, GCPW, tostring(i))
	ConvertVArr(FP,VArrI,VArrI4,GCP,7)

	ConvertVArr(FP, WArrI,WArrI4, GCPW, 7)


	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+11, AtLeast, 11),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("g\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--������ġ �����ν�, ����

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+12, AtLeast, 100),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("s\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--������ġ �����ν�, ����
	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 100),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("u\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--������ġ �����ν�, ����

	
	DoActionsX(FP, {AddV(ScTimer[i+1],1),AddV(PTimeV[i+1],1)})

	CDoActions(FP,{TSetScore(i,SetTo,PLevel[i+1],Custom)})
	CIf(FP,CV(PTimeV[i+1],24,AtLeast), {SubV(PTimeV[i+1],24),AddV(PlayTime[i+1],1),SubV(TimeAttackScore2[i+1],1),})
	TriggerX(FP, {CV(LV5Cool[i+1],1,AtLeast),}, {SubV(LV5Cool[i+1],1)},{preserved})
	CIfEnd()

	DoActions(FP, {SetSwitch("Switch 100",Random),SetSwitch("Switch 101",Random)})
	TriggerX(FP,{LocalPlayerID(i),Command(i,AtMost,1,"Men"),Command(i,AtMost,0,"Factories"),CV(Time2,60000,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(Time2,0),SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: ���� ������ ���� ��� \x07�����ð� \x031��\x04���� \x1C�ڵ����� \x04�˴ϴ�. \x07������..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: ���������� F9�� �����ּ���."),4)},{preserved})
	CIf(FP,{LocalPlayerID(i),CV(Time,300000,AtLeast)},{SubV(Time,300000)})
	TriggerX(FP,{LocalPlayerID(i),CD(SCA.LoadCheckArr[i+1],2),CD(SaveRemind,0)},{DisplayText(StrDesignX("\x03SYSTEM \x04: \x07�����ð� \x035��\x04���� \x1C�ڵ����� \x04�˴ϴ�. \x07������..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: ���������� F9�� �����ּ���."),4)},{preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SaveRemind,0),CD(PartyBonus,2,AtLeast)},{DisplayText(StrDesignX("\x04���� \x1F��Ƽ �÷��� ���ʽ� ���� \x1C�������Դϴ�. - \x08���ݷ� + 150%\x04, \x07+1�� \x17��ȭȮ�� + \x0F1.0%p"),4)},{preserved})-- �ο��� ���� ���ʽ�
	TriggerX(FP,{LocalPlayerID(i),CV(PLevel[i+1],999,AtMost)},{DisplayText(StrDesignX("\x04���� \x1F�ʺ��� ���ʽ� ���� \x1C�������Դϴ�. \x041000���� �޼� ������ \x1C����ġ ȹ�淮 2��"),4)},{preserved})-- 1000���� �̸� 5�ۼ�Ʈ ��Ȯ���ʽ�
	TriggerX(FP,{Switch("Switch 100", Cleared),Switch("Switch 101", Cleared)}, {DisplayText(StrDesignX("\x04TIP : \x04���� ���� �� ZŰ�� ������ �Ѱ��� ��Ĩ�ϴ�."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Set),Switch("Switch 101", Cleared)}, {DisplayText(StrDesignX("\x04TIP : \x1F�̳׶�\x04, \x07����\x04�� ���� �ڽ��� �ǹ��� �������� ��� ���� DPS�� ��Ÿ���ϴ�."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Cleared),Switch("Switch 101", Set)}, {DisplayText(StrDesignX("\x04TIP : \x17OŰ\x04�� ������ ���� ���� ���� ���� ������ �й��� �� �ֽ��ϴ�."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Set),Switch("Switch 101", Set)}, {DisplayText(StrDesignX("\x04TIP : \x04��ȭ ������ �ܰ谡 \x08+1 \x04�Ӹ� �ƴ϶� ���� Ȯ���� \x1C+2\x04, \x1F+3\x04 �� �ö� �� �ֽ��ϴ�."),4)}, {preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SCA.LoadCheckArr[i+1],2)},{SetMemory(0x58F500, SetTo, 1),},{preserved})
	TriggerX(FP,{LocalPlayerID(i)},{SetCD(SaveRemind,0)},{preserved})

	CIfEnd()--
	for j,k in pairs(BPArr) do
		TriggerX(FP, {Deaths(i, Exactly, 0,14),CV(k[i+1],1,AtLeast)},{SetDeaths(i,SetTo,1,14)})
		TriggerX(FP, {CD(SCA.LoadCheckArr[i+1],0),CV(k[i+1],1,AtLeast),LocalPlayerID(i)},{
			SetCp(i),
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("B\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
			DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵�, ���� �̳׶�, ���� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
			SetMemory(0xCDDDCDDC,SetTo,1);
		})
		
	end
	CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],1)},{SetCD(CheatDetect,0),SetCD(SCA.LoadCheckArr[i+1],2)})--�ε� �Ϸ�� ù ���� Ʈ����
		CIfX(FP, {Deaths(i,AtLeast,1,101)})--���������Ͱ� ������� �ε��� ��� �����, ������ ����� �����ϰ� �ε����
		for j,k in pairs(SCA_DataArr) do
			SCA_DataLoad(i,k[1][i+1],k[2])
		end
		for j,k in pairs(RSArr) do
			CIf(FP,{CV(k[i+1],0)})
				f_Rand(FP,k[i+1])
			CIfEnd()
		end
		TriggerX(FP,CD(LimitM[i+1],1),{SetDeaths(i, SetTo, 1, 100)})
		--ġ�� �׽�Ʈ ���� �ʱ�ȭ
		CIfX(FP,{CV(PStatVer[i+1],StatVer),Deaths(i,AtMost,0,100)})--���ȹ����� ����� ���� ���ų� �����ڰ� �ƴҰ�� ��� ġ�� ���� �۵�
		f_LMov(FP, CTPEXP, PEXP[i+1])
		CMov(FP, CTPLevel, 1)
		CMov(FP,CTStatP,5)
		CMov(FP,CTStatP2,StatP[i+1])
		f_LMov(FP, CTCurEXP, 0,nil,nil,1)
		f_LMov(FP, CTTotalExp, "10",nil,nil,1)
		CallTrigger(FP,Call_CT)
		CAdd(FP,CTStatP2,_Mul(Stat_ScDmg[i+1],_Mov(Cost_Stat_ScDmg)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPerEx[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPerEx)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPerEx2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPerEx2)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPerEx3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPerEx3)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer4[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer4)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_BreakShield[i+1],_Mov(100)),_Mov(Cost_Stat_BreakShield)))
		CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(Cost_Stat_Upgrade)))
		CAdd(FP,CTStatP2,_Mul(Stat_AddSc[i+1],_Mov(Cost_Stat_AddSc)))
		CMov(FP,0x57f0f0+(i*4),CTStatP)--ġ�ð����� �������� ǥ��� �̳׶�
		CMov(FP,0x57f120+(i*4),CTStatP2)--ġ�ð����� �������� ǥ��� ����
		CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNVar(CTPLevel,NotSame,PLevel[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNWar(CTCurEXP,NotSame,CurEXP[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNWar(CTTotalExp,NotSame,TotalExp[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {CV(BanFlag4[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {CV(BanFlag3[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {CV(BanFlag2[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {CV(BanFlag[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
		TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
			SetCp(i),
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("L\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
			DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵�, ���� �̳׶�, ���� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
			SetMemory(0xCDDDCDDC,SetTo,1);})
		
		CMov(FP,0x57f0f0+(i*4),0)--ġ�ð����� �������� ǥ��� �̳׶� �ʱ�ȭ
		CMov(FP,0x57f120+(i*4),0)--ġ�ð����� �������� ǥ��� ���� �ʱ�ȭ
		CElseX()--�� ���� ������ ������ ��� ġ�ð��� �۵�X, ������ �ʱ�ȭ��
		DoActionsX(FP, {
			SetV(PLevel[i+1],1),
			SetV(StatP[i+1],5),
			SetCWar(FP, CurEXP[i+1][2], SetTo, "0"),
			SetCWar(FP, TotalExp[i+1][2], SetTo, "10"),
			SetV(Stat_ScDmg[i+1],0),
			SetV(Stat_TotalEPer[i+1],0),
			SetV(Stat_TotalEPer2[i+1],0),
			SetV(Stat_TotalEPer3[i+1],0),
			SetV(Stat_TotalEPer4[i+1],0),
			SetV(Stat_BreakShield[i+1],0),
			SetV(Stat_TotalEPerEx[i+1],0),
			SetV(Stat_Upgrade[i+1],0),
			SetV(Stat_AddSc[i+1],0)})
		CIfXEnd()
		
		CIf(FP,{TTOR({CV(Stat_ScDmg[i+1],1,AtLeast),CV(Stat_AddSc[i+1],1,AtLeast),Deaths(i, AtLeast, 1, 100),CV(CreditAddSC[i+1],1,AtLeast)})})--��ī ���ݷ� ������ ������ ���翩��
		DoActionsX(FP, {SetV(ScTimer[i+1],0),RemoveUnit(88, i)})--�ε强���� ��īŸ�̸� �ʱ�ȭ
			for k = 0, 5 do
				CreateUnitStacked({CV(Stat_AddSc[i+1],k)},k+1, 88, 36+i,15+i, i, nil, 1)--��ī ��������� �ٽ� ����
			end
			CreateUnitStacked({CV(CreditAddSC[i+1],1,AtLeast)},6, 88, 36+i,15+i, i, nil, 1)--ũ���� ��ī�� �����׸� ������ ��ī����
			--CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--������ Īȣ ������ ��ī 6�� �߰�����
			
		CIfEnd()
		
		CElseX()--������ 0�� ��� ��������
		SCA_DataLoad(i,PlayTime2[i+1],119)--�� �̿�ð� �ҷ���
		CIf(FP,CV(PlayTime2[i+1],1,AtLeast),{SetV(ScTimer[i+1],0),RemoveUnit(88, i),SetCp(i),DisplayText(StrDesignX("\x04�׽�Ʈ ���� Ư������ ���� ������ �帳�ϴ�. \x07�ٽ��ѹ� �÷������ּż� �����մϴ�.").."\n"..StrDesignX("\x07�⺻���� 6��\x04 ����. \x08���� \x04: \x07�⺻����\x04�� ���� ���� 1ȸ���� �����ϸ� 3�� �� ������ϴ�."), 4),SetCp(FP)})
			TriggerX(FP,{CV(PlayTime2[i+1],1,AtLeast)},{SetV(CreditAddSC[i+1],1),SetDeaths(i, SetTo, 1, 99)},{preserved})
			CreateUnitStacked({CV(PlayTime2[i+1],1,AtLeast)},6, 88, 36+i,15+i, i, nil, 1)--�׽������� ���� Īȣ ������ ��ī 6�� �߰�����
			CMov(FP,CTimeV,PlayTime2[i+1])
			CallTrigger(FP,Call_ConvertTime)
			DoActions(FP,{SetCp(i)})
			DisplayPrint("CP", {"\x13\x0D\x0D\x0D",PName("LocalPlayerID")," \x04���� \x10�׽�Ʈ�� \x04�ΰ��� �÷��� �ð� : \x04",CTimeDD,"�� ",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��"})
			DisplayPrint("CP", {"\x13\x04�� ",PlayTime2[i+1]," �� �̿����� \x17",PlayTime2[i+1]," ũ����\x04 ���޵�"})
			f_LAdd(FP,Credit[i+1],Credit[i+1],{PlayTime2[i+1],0}) -- 
			
		CIfEnd()
			
		CIfXEnd()
		TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{SetCp(i),DisplayText(StrDesignX("\x04���� \x1F�ʺ��� ���ʽ� ���� \x1C�������Դϴ�. \x041000���� �޼� ������ \x1C����ġ ȹ�淮 2��"),4)},{preserved})-- 1000���� �̸� 5�ۼ�Ʈ ��Ȯ���ʽ�
		CIfOnce(FP, {CV(PStatVer[i+1],4,AtMost)}) --���� 8�ð� ����� �� ����ؼ� ������
		CDiv(FP, LV5Cool[i+1], 8)
		CIfEnd()
		CMov(FP,PStatVer[i+1],StatVer)--���� ���ο� ������� �ε�Ϸ�� ���ȹ��� �׸� �ʱ�ȭ

		CreateUnitStacked({},1,PersonalUIDArr[i+1],36+i,80+i, i,nil, 1) --���� �ҷ����� ������ �������� ��������
		CMov(FP,PUnitPtr[i+1],Nextptrs)
	CIfEnd()
	

	if TestStart == 1 then
		local EXPAcc = CreateWar(FP)
		--f_LAdd(FP, EXPAcc, EXPAcc, "10000000000")
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], EXPAcc)
	end
	
	local LevelUpJump = def_sIndex()
	local LIndex = CreateVar(FP) 
	local PrevLMulW = CreateWar2(FP,nil,nil,"10")
	local NextLMulW = CreateWar(FP)
	CJumpEnd(FP, LevelUpJump)
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],LevelLimit-1,AtMost)},{AddV(PLevel[i+1],1),AddV(CT_PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	ConvertLArr(FP, LIndex, _Sub(PLevel[i+1], 1), 8)
	f_LRead(FP, LArrX({EXPArr},LIndex), NextLMulW, nil, 1)
	f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], NextLMulW)
	
	--ConvertLArr(FP, LIndex, _Sub(PLevel[i+1], 2), 8)
	--f_LRead(FP, LArrX({EXPArr},LIndex), TempReadW, nil, 1)
	f_LAdd(FP, CurEXP[i+1], CurEXP[i+1], PrevLMulW)
	f_LMov(FP, PrevLMulW, NextLMulW)

	
	
	


	--f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],1)),TempReadV,nil,nil,1)
	--f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], {TempReadV,0})
	--f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],2)),TempReadV,nil,nil,1)
	--f_LAdd(FP, CurEXP[i+1], CurEXP[i+1], {TempReadV,0})


	CAdd(FP,StatP[i+1],5)
	CallTriggerX(FP,Call_Print13[i+1],{CV(PLevel[i+1],9,AtMost)})
	TriggerX(FP, {CV(PLevel[i+1],9,AtMost),LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x1F������ �ö����ϴ�! \x17O Ű\x04�� ���� \x07�ɷ�ġ\x04�� �������ּ���."))}, {preserved})
	CJump(FP, LevelUpJump)
	NIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})

	
	local CTSwitch = CreateCcode()
	TriggerX(FP,{Deaths(i, Exactly, 1,13),Deaths(i, Exactly, 0,14)},{SetDeaths(i, SetTo, 1,14)},{preserved})
	
	NIf(FP,{CD(SCA.GlobalCheck,3),CD(SCA.LoadCheckArr[i+1],2),Deaths(i, AtLeast, 1,14),},{}) -- �����ư�� �����ų� �ڵ����� �ý��ۿ� ���� �ش� Ʈ���ſ� �������� ���
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 4, 2),SetDeaths(i, SetTo, 2,14),SCA.Reset(i)},{preserved})--�����ȣ ������
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--����Ʈ���� �ݰ� CT�۵�
	CIf(FP,Deaths(i,AtLeast,1,100))--�������ϰ�� ���� 1���� ������ ����.
	CMov(FP,PLevelBak,PLevel[i+1])
	CMov(FP,PLevel[i+1],1)
	CIfEnd()
	for j,k in pairs(SCA_DataArr) do
		SCA_DataSave(i,k[1][i+1],k[2])
	end
	CIf(FP,Deaths(i,AtLeast,1,100))
	CMov(FP,PLevel[i+1],PLevelBak)
	CIfEnd()
	NIfEnd()


	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),Deaths(i, Exactly, 0,14),CD(CTSwitch,1)},{SetCD(CTSwitch,0),SetCD(CheatDetect,0)})--���̺� �Ϸ��� ġ�� �˻�
	--if TestStart == 1 then
	--	f_LAdd(FP,Credit[i+1],Credit[i+1],"1") -- �����߳�?
	--end
	--f_LMov(FP, CTPEXP, PEXP[i+1])
	--CMov(FP, CTPLevel, 1)
	--CMov(FP,CTStatP,5)
	--CMov(FP,CTStatP2,StatP[i+1])
	--f_LMov(FP, CTCurEXP, 0,nil,nil,1)
	--f_LMov(FP, CTTotalExp, "10",nil,nil,1)
	--CallTrigger(FP,Call_CT)

	--CAdd(FP,CTStatP2,_Mul(Stat_ScDmg[i+1],_Mov(Cost_Stat_ScDmg)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer4[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer4)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_BreakShield[i+1],_Mov(1000)),_Mov(Cost_Stat_BreakShield)))
	--CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(Cost_Stat_Upgrade)))
	--CAdd(FP,CTStatP2,_Mul(Stat_AddSc[i+1],_Mov(Cost_Stat_AddSc)))
	--CMov(FP,0x57f0f0+(i*4),CTStatP)--ġ�ð����� �������� ǥ��� �̳׶�
	--CMov(FP,0x57f120+(i*4),CTStatP2)--ġ�ð����� �������� ǥ��� ����
	--CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCD(CheatDetect,1)})
	--CTrigger(FP, {TTNVar(CTPLevel,NotSame,PLevel[i+1])}, {SetCD(CheatDetect,1)})
	--CTrigger(FP, {TTNWar(CTCurEXP,NotSame,CurEXP[i+1])}, {SetCD(CheatDetect,1)})
	--CTrigger(FP, {TTNWar(CTTotalExp,NotSame,TotalExp[i+1])}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag4[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag3[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag2[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("S\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �������� �� �����Ǿ� ����.)\x07 ��",4);
		DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵�, ���� �̳׶�, ���� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})
	CMov(FP,0x57f0f0+(i*4),0)--ġ�ð����� �������� ǥ��� �̳׶� �ʱ�ȭ
	CMov(FP,0x57f120+(i*4),0)--ġ�ð����� �������� ǥ��� ���� �ʱ�ȭ

	
	CIfEnd()

	



	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--�⺻��������
	if Limit == 1 then 
		CIf(FP,{Deaths(i,AtLeast,1,100),Deaths(i,AtLeast,1,553)})
		CreateUnitStacked({}, 12, LevelUnitArr[25][2], 36+i, nil, i)
		--f_LAdd(FP,PEXP[i+1],PEXP[i+1],"500000000")
		CIfEnd()
	end
	
	TriggerX(FP, {Command(i,AtLeast,1,88),CV(ScTimer[i+1],4320)}, {RemoveUnit(88,i)},{preserved}) -- 3�е� ������� �⺻����
	TriggerX(FP, {CV(ScTimer[i+1],86400)}, {SetV(ResetStat[i+1],1)},{preserved}) -- 1�ð��� �����ʱ�ȭ ���Ұ�
	TriggerX(FP, {CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men"),}, {SetCp(i),DisplayText(StrDesignX("\x04��� \x08��ȭ�� ����\x04�Ͻ� ����̳׿�... \x0F2�� ���� 1��\x04�� ���� �������� �����մϴ�."), 4),SetCp(FP)}) -- �⺻���� ������� �����Ұ�� ��ȸ��
	CreateUnitStacked({CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men")}, 1, LevelUnitArr[2][2], 50+i,36+i, i, nil,1)


	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	for p = 1,7 do
		local NextT = ""
		local NextT2 = ""
		if p<=6 then
			NextT = "\n"..StrDesignX("���� \x07�� ������ \x08���׷��̵�\x04�� �ʿ��� \x1BDPS\x1F(�̳׶�)\x04�� \x08"..OreDPS[p+1].." \x04�Դϴ�.")
		end
		if p ~= 7 then
			NextT2 = "\n"..StrDesignX("���� \x07�� ������ \x08���׷��̵�\x04�� �ʿ��� \x1BDPS\x07(����)\x04�� \x08"..GasDPS[p+1].." \x04�Դϴ�.")
		end
	if p<=6 then
		TriggerX(FP,{CV(TempO[i+1], OreDPS[p],AtLeast)},{
			SetV(BuildMul1[i+1],OreDPSM[p]),
			SetV(NextOre[i+1],OreDPS[p+1]),
			SetV(NextOreMul[i+1],OreDPSM[p+1]),SetCp(i),
			DisplayText(StrDesignX("�ǹ��� \x1BDPS\x1F(�̳׶�)\x04�� \x08"..OreDPS[p].." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..OreDPSM[p].."��\x04�� �����Ͽ����ϴ�.")..NextT),SetCp(FP)})--1���ǹ�
	end
	TriggerX(FP,{CV(TempG[i+1], GasDPS[p],AtLeast)},{
		SetV(BuildMul2[i+1],GasDPSM[p]),
		SetV(NextGas[i+1],GasDPS[p+1]),
		SetV(NextGasMul[i+1],GasDPSM[p+1]),SetCp(i),
		DisplayText(StrDesignX("�ǹ��� \x1BDPS\x07(����)\x04�� \x08"..GasDPS[p].." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..GasDPSM[p].."��\x04�� �����Ͽ����ϴ�.")..NextT2),SetCp(FP)})--2���ǹ�
	end
	
	for j,k in pairs(FirstReward) do
		CIfOnce(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetCp(i),DisplayText(StrDesignX("\x08"..k[1].."�� \x04���� \x07���� \x11�޼� \x04����! : \x1F"..Convert_Number(k[2]).." \x0F�ţأ�"), 4),SetCp(FP)})
		
		f_LAdd(FP, PEXP[i+1], PEXP[i+1], tostring(k[2]))

		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- �ڵ�����
		CIfEnd()
	end
	for j,k in pairs(FirstReward2) do
		CIfOnce(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetCp(i),DisplayText(StrDesignX("\x11"..k[1].."�� \x04���� \x07���� \x11�޼� \x04����! : \x1F"..Convert_Number(k[2]).." \x17�ã�����"), 4),SetCp(FP)})
		
		f_LAdd(FP, Credit[i+1], Credit[i+1], tostring(k[2]))

		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- �ڵ�����
		CIfEnd()
	end

	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[15][2])},{SetCp(i),DisplayText(StrDesignX("\x0815�� \x04������ ȹ���Ͽ����ϴ�. \x0815�� \x04���ֺ��ʹ� \x17�Ǹ�\x04�� ���� \x1B����ġ\x04�� ȹ���� �� �ֽ��ϴ�.")),SetCp(FP)})
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[26][2])},{SetCp(i),DisplayText(StrDesignX("\x0F26�� \x04������ ȹ���Ͽ����ϴ�. \x0F26�� \x04���ֺ��ʹ� \x08����\x04�� ������ �� �ֽ��ϴ�.")),DisplayText(StrDesignX("\x08���� \x1C���� \x07���ѽð�\x04�� ������, \x08�ִ� 4�� \x04���� �����մϴ�.")),DisplayText(StrDesignX("\x0F26�� \x04���ֺ��ʹ� \x17���� �Ǹű�\x04�� �־�� �ǸŰ� �����մϴ�.")),SetCp(FP)})
	
	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{TempO[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas,TempG[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV3[i+1],"10000000000",nil,{TempX[i+1]},Money[i+1])
	TriggerX(FP, {CV(TempX[i+1],1,AtLeast)},{SetCD(OreMode[i+1], 1)})
	CIfX(FP, {CD(OreMode[i+1],0)},{TSetResources(i, SetTo, TempO[i+1], Ore)})
	CElseX({TSetResources(i, SetTo, TempX[i+1], Ore)})
	CIfXEnd()
--	if TestStart == 1 then
--		MinO,MaxO = CreateVars(2, FP)
--		MinG,MaxG = CreateVars(2, FP)
--		CTrigger(FP,{CV(MinO,TempO,AtLeast)},{SetV(MinO,TempO)},1)
--		CTrigger(FP,{CV(MinG,TempG,AtLeast)},{SetV(MinG,TempG)},1)
--		CTrigger(FP,{CV(MaxO,TempO,AtMost)},{SetV(MaxO,TempO)},1)
--		CTrigger(FP,{CV(MaxG,TempG,AtMost)},{SetV(MaxG,TempG)},1)
--		DisplayPrintEr(i, {"\x1F���׹��ּ� : ",MinO," \x04|| \x1F���׹��ִ� : ",MaxO," \x04|| \x07�����ּ� : ",MinG," \x04|| \x07�����ִ� : ",MaxG})
--		local temp,PKey = ToggleFunc({KeyPress("V","Up"),KeyPress("V","Down")},nil,1)--���� ��� �ʱ�ȭ
--		CTrigger(FP,{CD(PKey,1)},{SetV(MinO,0xFFFFFFFF)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MinG,0xFFFFFFFF)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MaxO,0)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MaxG,0)},1)
--	end
	

TriggerX(FP, {CV(TempO[i+1],10000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("O\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

TriggerX(FP, {CV(TempG[i+1],20000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("G\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

TriggerX(FP, {CV(TempX[i+1],5000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("X\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})


	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)
	Debug_DPSBuilding(DpsLV3[i+1],173,137+i)
	PBossResetArr = DPSBuilding(i,PBossPtr[i+1],"X",nil,{PBossDPS[i+1]},nil)--

	for j,k in pairs(PBossArr) do
		local LocID = 129+i
		local AddCond = nil
		if j >=6 then LocID = 153+i AddCond = CV(BossLV,5,AtLeast) end
		NIfOnce(FP,{Memory(0x628438,AtLeast,1),CV(PBossPtr[i+1],0),CV(PBossLV[i+1],j-1),AddCond})--������ �ǹ� ����
		DoActions2X(FP, PBossResetArr)
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {CreateUnit(1,k[1],LocID,FP),SetV(PBossPtr[i+1],_Add(Nextptrs,2))})
		CSub(FP,CurCunitI,Nextptrs,19025)
		f_Div(FP,CurCunitI,_Mov(84))
		CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,k[1]))})
		CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
		CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,2,SetTo,_Add(CT_GNextRandV,FP))})
		--CallTrigger(FP, Call_CTInputUID)
		f_LMov(FP,TotalPBossDPS[i+1],k[2])
		--CallTrigger(FP, ResetBDPMArr)
		NIfEnd()
		local ClearJump = def_sIndex()
		NJump(FP,ClearJump,{CV(PBossLV[i+1],j,AtLeast)})
		CIf(FP,{TTNWar(PBossDPS[i+1], AtLeast, TotalPBossDPS[i+1])})
		DoActionsX(FP,{KillUnitAt(All,k[1],LocID,FP),AddV(PBossLV[i+1],1),SetV(PBossPtr[i+1],0),SetNWar(PBossDPS[i+1],SetTo,"0")})

		CIfEnd()
		NJumpEnd(FP,ClearJump)
	end

	
	UnitReadX(FP, i, "Men", 65+i, Income[i+1])
	TriggerX(FP,{CV(ScTimer[i+1],4320,AtMost)},{MoveUnit(1, 88, i, 15+i, 22+i)},{preserved})

	CIf(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65+i),Bring(i,AtLeast,1,"Men",15+i)})
	CTrigger(FP,{},{MoveUnit(1, "Men", i, 15+i, 22+i),MoveUnit(1, "Factories", i, 22+i, 57+i),
	MoveUnit(1, LevelUnitArr[41][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[42][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[43][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[44][2], i, 22+i, 144+i),
},1)--����� ����
	TriggerX(FP,{CV(CS_DPSLV[i+1],1,AtLeast)},{MoveUnit(1,PersonalUIDArr[i+1],i,22+i,57+i)},{preserved})
	CIfEnd()



	TriggerX(FP, {Bring(i,AtLeast,1,"Men",29+i)}, {MoveUnit(1, "Men", i, 29+i, 36+i)}, {preserved})--����� ����

	TriggerX(FP, {Bring(i, AtMost, 3, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--������ ����
	TriggerX(FP, {}, {MoveUnit(1, "Factories", i, 111, 36+i)}, {preserved})--������ ����

	
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 5, "Men", 119+i)}, {MoveUnit(1, "Men", i, 119+i, 22+i)}, {preserved})--���κ����� ��������
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 1, 88, 119+i)}, {MoveUnit(1, 88, i, 119+i, 22+i)}, {preserved})--���κ����� ��������

	--��ȭ������ ���� �����ϱ�(ĵ����������)
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], k[1]-1), AtLeast, 1)}, 1, k[2], 50+i,36+i, i, {SetCVAar(VArr(GetUnitVArr[i+1], k[1]-1), Subtract, 1)})
	end
	CIf(FP,{TTNVar(PUnitCurLevel[i+1],NotSame,PUnitClass[i+1])})
	TriggerX(FP,{CV(PUnitClass[i+1],CS_CooldownLimit+CS_AtkLimit+CS_EXPLimit+CS_TotalEPerLimit+CS_TotalEper4Limit+CS_DPSLVLimit,AtLeast)},{SetV(PUnitClass[i+1],CS_CooldownLimit+CS_AtkLimit+CS_EXPLimit+CS_TotalEPerLimit+CS_TotalEper4Limit+CS_DPSLVLimit)},{preserved})
	CMov(FP,PUnitCurLevel[i+1],PUnitClass[i+1])

	TriggerX(FP,{CV(CS_Cooldown[i+1],CS_CooldownLimit,AtLeast)},{SetV(CS_Cooldown[i+1],CS_CooldownLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_Atk[i+1],CS_AtkLimit,AtLeast)},{SetV(CS_Atk[i+1],CS_AtkLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_EXP[i+1],CS_EXPLimit,AtLeast)},{SetV(CS_EXP[i+1],CS_EXPLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_TotalEPer[i+1],CS_TotalEPerLimit,AtLeast)},{SetV(CS_TotalEPer[i+1],CS_TotalEPerLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_TotalEper4[i+1],CS_TotalEper4Limit,AtLeast)},{SetV(CS_TotalEper4[i+1],CS_TotalEper4Limit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_DPSLV[i+1],CS_DPSLVLimit,AtLeast)},{SetV(CS_DPSLV[i+1],CS_DPSLVLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����

	local TempV = CreateVar(FP)
	CMov(FP,TempV,CS_Atk[i+1])
	TriggerX(FP,{CV(TempV,10,AtLeast)},{SetV(TempV,10)},{preserved})
	CDoActions(FP,{TSetMemoryW(0x656EB0, PersonalWIDArr[i+1], SetTo, _Mul(TempV,3250))})
	CIf(FP,CV(CS_Atk[i+1],11,AtLeast))
	CDoActions(FP,{TSetMemoryB(0x58F32C, (i*15)+11, SetTo, _Sub(CS_Atk[i+1],10))})
	CIfEnd()
	
	CMov(FP,CurPUnitCool[i+1],_SHRead(ArrX(PUnitCoolArr,CS_Cooldown[i+1])))
	f_Mul(FP,CS_EXPData[i+1],CS_EXP[i+1],2)
	f_Mul(FP,CS_TEPerData[i+1],CS_TotalEPer[i+1],250)
	f_Mul(FP,CS_TEPer4Data[i+1],CS_TotalEper4[i+1],500)
	
	--
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],100)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,2)},1)
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],99,AtMost)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,1)},1)
	CIfEnd()
	CallTrigger(FP,Call_BtnInit,{})


	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),CV(RSArr[1][i+1],0)})
		for j = 1,9 do--������ ����
			CMov(FP,RSArr[j][i+1],RSArr[j+1][i+1])
		end
		f_Rand(FP,RSArr[10][i+1])--������ �����
		
		for j,k in pairs(RSArr) do -- ���� 0�ΰ� �˻�
			CIf(FP,{CV(k[i+1],0)})
				f_Rand(FP,k[i+1])
			CIfEnd()
		end
	CIfEnd()
	
	for j, k in pairs(LevelUnitArr) do
		TriggerX(FP, {Command(i,AtLeast,1,k[2])}, {SetCD(AutoEnchArr2[j][i+1],1)})
			
		CIf(FP,MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1))
		CallTriggerX(FP,Call_Print13[i+1],{MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)})
		if SpeedTestMode == 0 then
			TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: �ּ� 1ȸ �̻� �ش� ������ ��ȭ�� �����ؾ��մϴ�."))}, {preserved})
			TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)}, {SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0)}, {preserved}) 
		end
		TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1)}, {Order(k[2], i, 36+i, Move, 8+i)}, {preserved})
		CIfEnd()

		CIf(FP,MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1))
		CallTriggerX(FP,Call_Print13[i+1],{MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: �ּ� 1ȸ �̻� �ش� ������ ��ȭ�� �����ؾ��մϴ�."))}, {preserved})
		TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)}, {SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0)}, {preserved})
		TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1)}, {Order(k[2], i, 36+i, Move, 73+i)}, {preserved})
		CIfEnd()
	end
	local spt ={}
	for j = 1, 39 do
		table.insert(spt,SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 1))
	end
	if SpeedTestMode == 1 then
		f_LAdd(FP, Money[i+1], Money[i+1], "1500")
		DoActions2X(FP, {
			SetV(AutoBuyCode[i+1],1),spt
		})
	end


	CIfX(FP, {TCommand(i,AtMost,ULimitV2,"Men"),CV(AutoBuyCode[i+1],1,AtLeast)}) -- �ڵ����� ����
	for j, k in pairs(AutoBuyArr) do
		AutoBuy(i,k[1],k[2])
	end
	CElseIfX({TCommand(i,AtLeast,ULimitV2,"Men")})
	CallTrigger(FP,Call_Print13[i+1])
	for j = 1, 7 do
		TriggerX(FP, {LocalPlayerID(i),CV(PCheckV,j)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: ���� ���ּ��� �ʹ� ���� ���� ������ �� �����ϴ�.\x08 (�ִ� "..ULimitArr[j].."��)"))},{preserved})
	end

	
	CIfXEnd()

	
	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--Ű�νĺ� ����
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"O")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	ClickCD = CreateCcode()
	CIf(FP,{CV(InterfaceNum[i+1],1,AtLeast)},{})
		for j = 0, 5 do
			TriggerX(FP, {Deaths(i,Exactly,0x10100+j+1,20)}, {SetCD(ClickCD, j+1)}, {preserved})
			TriggerX(FP, {CD(ClickCD, j+1)}, {SetDeaths(i,SetTo,1,496+j)}, {preserved})
		end
		for j = 0, 8 do
			TriggerX(FP, {Deaths(i,Exactly,0x10000+j,20)}, {SetCD(ClickCD, 0),SetDeaths(i,SetTo,1,495+j)}, {preserved})
		end
		TriggerX(FP, {Deaths(i,AtLeast,1,502)}, {SetCD(ClickCD, 0)}, {preserved})
		TriggerX(FP, {Deaths(i,AtLeast,1,503)}, {SetCD(ClickCD, 0)}, {preserved})
		TriggerX(FP, {Deaths(i,AtLeast,1,494)}, {SetCD(ClickCD, 0)}, {preserved})
		CIf(FP, Deaths(i, Exactly, 1, 504))
			CIfX(FP,{CV(ResetStat[i+1],1)})
				CallTrigger(FP,Call_Print13[i+1])
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x1F���� �ʱ�ȭ\x04�� ����� �� �����ϴ�.")) ,{preserved})

			CElseIfX({TNWar(Credit[i+1], AtLeast, "5000")})
				f_LSub(FP, Credit[i+1], Credit[i+1], "5000")
				DoActionsX(FP, {
					
					SetV(ResetStat[i+1],1),
					SetV(StatP[i+1],0),
					SetV(Stat_ScDmg[i+1],0),
					SetV(Stat_TotalEPer[i+1],0),
					SetV(Stat_TotalEPer2[i+1],0),
					SetV(Stat_TotalEPer3[i+1],0),
					SetV(Stat_Upgrade[i+1],0),
					SetV(Stat_AddSc[i+1],0),
					SetV(Stat_TotalEPer4[i+1],0),
					SetV(Stat_BreakShield[i+1],0),
					SetV(Stat_TotalEPerEx[i+1],0),
				})
				TriggerX(FP, {LocalPlayerID(i)}, {SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1)}, {preserved})
				CMov(FP, StatP[i+1], _Mul(PLevel[i+1], 5))
				CallTrigger(FP,Call_Print13[i+1])
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x1F���� �ʱ�ȭ\x04 �Ϸ�. \x07��� �� �ڵ�����˴ϴ�. \x17O Ű\x04�� ���� \x07�ɷ�ġ\x04�� �������ּ���.")) ,{preserved})

			CElseX()
				CallTrigger(FP,Call_Print13[i+1])
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�.")) ,{preserved})
			CIfXEnd()
		CIfEnd()
		CIfX(FP,{CV(InterfaceNum[i+1],1)},{})

			KeyFunc(i,"1",{
				{{CV(StatP[i+1],Cost_Stat_ScDmg,AtLeast),CV(Stat_ScDmg[i+1],49,AtMost)},{SubV(StatP[i+1],Cost_Stat_ScDmg),AddV(Stat_ScDmg[i+1],1)},StrDesign("\x07�⺻����\x1B�� �������� �����Ͽ����ϴ�.")},
				{{CV(Stat_ScDmg[i+1],50,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07�⺻���� \x08������\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_ScDmg-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			})
		--	if TestStart == 1 then
		--		KeyFunc(i,"2",{
		--			{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],89,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
		--			{{CV(Stat_Upgrade[i+1],90,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x08������\x04�� �ø� �� �����ϴ�.")},
		--			{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		--		})
		--	else
			KeyFunc(i,"2",{
				{{CV(StatP[i+1],Cost_Stat_AddSc,AtLeast),CV(Stat_AddSc[i+1],4,AtMost)},{SubV(StatP[i+1],Cost_Stat_AddSc),AddV(Stat_AddSc[i+1],1)},StrDesign("\x07�⺻���� ����\x04�� \x0F1�� \x04�����Ͽ����ϴ�.")},
				{{CV(Stat_AddSc[i+1],5,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07�⺻���� ����\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_AddSc-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			})
		--	end
			KeyFunc(i,"3",{
				{{CV(StatP[i+1],Cost_Stat_Upgrade,AtLeast),CV(Stat_Upgrade[i+1],49,AtMost)},{SubV(StatP[i+1],Cost_Stat_Upgrade),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
				{{CV(Stat_Upgrade[i+1],50,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x08������\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_Upgrade-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			})
			KeyFunc(i,"4",{
				{{CV(StatP[i+1],Cost_Stat_TotalEPer,AtLeast),CV(Stat_TotalEPer[i+1],9999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer),AddV(Stat_TotalEPer[i+1],100)},StrDesign("\x07�� \x08��ȭ Ȯ��\x04�� �����Ͽ����ϴ�.")},
				{{CV(Stat_TotalEPer[i+1],10000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07�� \x08��ȭ Ȯ��\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_TotalEPer-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			})
			KeyFunc(i,"5",{
				{{CV(StatP[i+1],Cost_Stat_TotalEPer2,AtLeast),CV(Stat_TotalEPer2[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer2),AddV(Stat_TotalEPer2[i+1],100)},StrDesign("\x07+2�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
				{{CV(Stat_TotalEPer2[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07+2�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_TotalEPer2-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			})
			KeyFunc(i,"6",{
				{{CV(StatP[i+1],Cost_Stat_TotalEPer3,AtLeast),CV(Stat_TotalEPer3[i+1],2999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer3),AddV(Stat_TotalEPer3[i+1],100)},StrDesign("\x07+3�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
				{{CV(Stat_TotalEPer3[i+1],3000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x10+3�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_TotalEPer3-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")}, 
			})

			-- 1, 4000
			-- 2, 4000
			-- 3, 1000
			-- 4, 1000
			-- 5, 10000
			-- 6, 30000

			--KeyFunc(i,"6",{
			--	{{CV(StatP[i+1],5,AtLeast)},{SubV(StatP[i+1],5),AddV(Stat_EXPIncome[i+1],1)},StrDesign("\x07����ġ ȹ�\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
			--	{{CV(StatP[i+1],0,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			--})
		CElseIfX({CV(InterfaceNum[i+1],2)},{}) -- 2�� ����������
		KeyFunc(i,"1",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4,AtLeast),CV(Stat_TotalEPer4[i+1],9999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer4),AddV(Stat_TotalEPer4[i+1],100)},StrDesign("\x08Ư�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPer4[i+1],10000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x08Ư�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"2",{
			{{CV(StatP[i+1],Cost_Stat_BreakShield,AtLeast),CV(Stat_BreakShield[i+1],29999,AtMost)},{SubV(StatP[i+1],Cost_Stat_BreakShield),AddV(Stat_BreakShield[i+1],100)},StrDesign("\x08Ư�� \x1F�ı� ����Ȯ��\x04�� \x0F1.0%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_BreakShield[i+1],30000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x1F�Ǳ� \x08����Ȯ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_BreakShield-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"3",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx,AtLeast),CV(Stat_TotalEPerEx[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx),AddV(Stat_TotalEPerEx[i+1],100)},StrDesign("\x07�� \x08��ȭ Ȯ��\x04�� �����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPerEx[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07�� \x08��ȭ Ȯ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"4",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx2,AtLeast),CV(Stat_TotalEPerEx2[i+1],1999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx2),AddV(Stat_TotalEPerEx2[i+1],100)},StrDesign("\x07+2�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPerEx[i+1],2000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07+2�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx2-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"5",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx3,AtLeast),CV(Stat_TotalEPerEx3[i+1],999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx3),AddV(Stat_TotalEPerEx3[i+1],100)},StrDesign("\x07+3�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPerEx[i+1],1000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x10+3�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx3-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		CIfXEnd()
	TriggerX(FP, {MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],2,AtLeast),MSQC_KeyInput(i, "I")},{SubV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtMost),MSQC_KeyInput(i, "P")},{AddV(InterfaceNum[i+1],1)},{preserved})
	CIfEnd()
	DoActions(FP, SetCp(FP))--Ű�νĺ� ����

	TriggerX(FP,{CV(InterfaceNum[i+1],0),CV(BrightLoc,30,AtMost),LocalPlayerID(i)},{AddV(BrightLoc,1)},{preserved})
	TriggerX(FP,{CV(InterfaceNum[i+1],1,AtLeast),CV(BrightLoc,14,AtLeast),LocalPlayerID(i)},{SubV(BrightLoc,1)},{preserved})
	CDoActions(FP,{TSetMemory(0x657A9C,SetTo,BrightLoc)})

	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--Ű�νĺ�
	--TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"P")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	--CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetCp(i),CenterView(72),SetCp(FP)})

	--CIfXEnd()






	--�� ���� �� �ջ�
	CMov(FP,Stat_EXPIncome[i+1],0,nil,nil,1)
	CMov(FP,IncomeMax[i+1],12,nil,nil,1)
	CMov(FP,General_Upgrade[i+1],0,nil,nil,1)
	CMov(FP,ScoutDmg[i+1],Stat_ScDmg[i+1],nil,nil,1)
	CMov(FP,TotalEPer[i+1],Stat_TotalEPer[i+1],nil,nil,1)
	CMov(FP,TotalEPer2[i+1],Stat_TotalEPer2[i+1],nil,nil,1)
	CMov(FP,TotalEPer3[i+1],Stat_TotalEPer3[i+1],nil,nil,1)
	CMov(FP,TotalEPer4[i+1],Stat_TotalEPer4[i+1],nil,nil,1)
	CAdd(FP,IncomeMax[i+1],B_IncomeMax)
	CAdd(FP,TotalEPer[i+1],Stat_TotalEPerEx[i+1])
	CAdd(FP,TotalEPer2[i+1],Stat_TotalEPerEx2[i+1])
	CAdd(FP,TotalEPer3[i+1],Stat_TotalEPerEx3[i+1])
	CAdd(FP,TotalEPer[i+1],B_TotalEPer)
	CAdd(FP,TotalEPer2[i+1],B_TotalEPer2)
	CAdd(FP,TotalEPer3[i+1],B_TotalEPer3)
	CAdd(FP,Stat_EXPIncome[i+1],B_Stat_EXPIncome)
	CAdd(FP,General_Upgrade[i+1],Stat_Upgrade[i+1])
	CAdd(FP,General_Upgrade[i+1],B_Stat_Upgrade)--


	CAdd(FP,Stat_EXPIncome[i+1],CS_EXPData[i+1])
	CAdd(FP,TotalEPer[i+1],CS_TEPerData[i+1])
	CAdd(FP,TotalEPer4[i+1],CS_TEPer4Data[i+1])
	




	--CTrigger(FP, {CV(Income[i+1],_Add(IncomeMax[i+1], 1),AtLeast),LocalPlayerID(i)}, {
	--	SetCp(i),
	--	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	--	DisplayText("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	--	DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
	--	SetMemory(0xCDDDCDDC,SetTo,1);})
	

--	"\x041�ܰ� \x04: \x0F+1�� Ȯ�� \x07+1.0%p, \x1B����� \x07+3",
--	"\x042�ܰ� \x04: \x0F+1�� Ȯ�� \x07+1.0%p, \x1B����� \x07+3",
--	"\x043�ܰ� \x04: \x0F+1�� Ȯ�� \x07+1.0%p, \x1B����� \x07+3, ���ݷ� + 50%",
--	"\x044�ܰ� \x04: \x0F+1�� Ȯ�� \x07+1.5%p, \x1B����� \x07+6, ���ݷ� + 50%,\x1C�߰�EXP +10%",
--	"\x045�ܰ� \x04: \x0F+1�� Ȯ�� \x07+1.5%p, \x1B����� \x07+9, ���ݷ� + 100%,\x1C�߰�EXP +10%",


	--TriggerX(FP,{CountdownTimer(AtLeast, 1)},{AddV(Stat_EXPIncome[i+1],10)},{preserved})--ī��Ʈ�ٿ� Ÿ�̸� �����
Trigger2X(FP,{CV(PBossLV[i+1],1,AtLeast)},{
	AddV(IncomeMax[i+1],3),--����� ���ּ� 3 ����
	AddV(TotalEPer[i+1],1000),--��ȭȮ�� +1.0%p
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],2,AtLeast)},{
	AddV(IncomeMax[i+1],3),--����� ���ּ� 3 ����
	AddV(TotalEPer[i+1],1000),--��ȭȮ�� +1.0%p
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],3,AtLeast)},{
	AddV(IncomeMax[i+1],3),--����� ���ּ� 3 ����
	AddV(TotalEPer[i+1],1000),--��ȭȮ�� +1.0%p
	AddV(General_Upgrade[i+1],5),--���ݷ� 50%
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],4,AtLeast)},{
	AddV(IncomeMax[i+1],6),--����� ���ּ� 6 ����
	AddV(General_Upgrade[i+1],5),--���ݷ� 50%
	AddV(Stat_EXPIncome[i+1],1), --�߰�EXP +10%
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],5,AtLeast)},{
	AddV(IncomeMax[i+1],9),--����� ���ּ� 9 ����
	AddV(General_Upgrade[i+1],5),--���ݷ� 50%
	AddV(Stat_EXPIncome[i+1],1), --�߰�EXP +10%
	
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],5,AtLeast)},{
	AddV(B_PTicket[i+1],5), --���� �Ǹű� 5��
	
})
Trigger2X(FP,{CV(PBossLV[i+1],6,AtLeast)},{
	AddV(B_PCredit[i+1], 150000)
})
for pb= 1, 6 do
	TriggerX(FP,{LocalPlayerID(i),CV(PBossLV[i+1],pb,AtLeast)},{SetV(Time,(300000)-5000),SetCD(SaveRemind,1),SetCp(i),DisplayText(StrDesignX("\x08"..pb.."�ܰ� \x07���κ���\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4),SetCp(FP)})
end

CIfOnce(FP, {Command(i, AtLeast, 1, LevelUnitArr[44][2])},{SetCp(i)})

DisplayPrint("CP", {"\x13\x07�� \x04����� \x07Ÿ�Ӿ��� \x10����\x04�� \x07",TimeAttackScore2[i+1]," \x04�� �Դϴ�. \x07��"})
CIfX(FP,{CV(TimeAttackScore[i+1],TimeAttackScore2[i+1],AtMost)},{})
DisplayPrint("CP", {"\x13\x07�� \x07Ÿ�Ӿ��� \x10����\x04�� ���ŵǾ����ϴ�! ���� \x07",TimeAttackScore[i+1]," \x04���� �پ�����̳׿�! ���ϵ帳�ϴ�! \x07��"})
CDoActions(FP, {SetV(TimeAttackScore[i+1],TimeAttackScore2[i+1])})
CElseX()
DisplayPrint("CP", {"\x13\x07�� ���� \x07",TimeAttackScore[i+1]," \x04���� �پ� ������ ���߳׿�... �����ǿ� �� �������ô�. \x07��"})
CIfXEnd()
CIfEnd()
TriggerX(FP,{CV(PBossLV[i+1],5,AtLeast)},{KillUnitAt(1,13,119+i,FP)})
TriggerX(FP,{CV(PBossLV[i+1],6,AtLeast)},{SetCD(BossLV6Flag, 1)})



	--if TestStart == 1 then
	--	TriggerX(FP,{},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- �ο��� ���� ���ʽ�
	--else
		
		TriggerX(FP,{CD(PartyBonus,2,AtLeast)},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- �ο��� ���� ���ʽ�
	--end
	TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{AddV(Stat_EXPIncome[i+1],10)},{preserved})-- 1000���� �̸� ��ġ2��

	CIf(FP,{CV(B_Credit,1,AtLeast)})
	f_LAdd(FP,Credit[i+1],Credit[i+1],{B_Credit,0}) -- 
	CIfEnd({})
	CIf(FP,{CV(B_Ticket,1,AtLeast)})
	CAdd(FP,SellTicket[i+1],B_Ticket) --
	CIfEnd({})
	CIf(FP,{CV(B_PCredit[i+1],1,AtLeast)})
	f_LAdd(FP,Credit[i+1],Credit[i+1],{B_PCredit[i+1],0}) --
	CMov(FP, B_PCredit[i+1], 0)
	CIfEnd({})
	CIf(FP,{CV(B_PTicket[i+1],1,AtLeast)})
	CAdd(FP,SellTicket[i+1],B_PTicket[i+1]) --
	CMov(FP, B_PTicket[i+1], 0)
	CIfEnd({})

	
	DoActionsX(FP,{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 0),SetMemoryB(0x58F32C+(i*15)+12, SetTo, 0),})


	for CBit = 0, 7 do -- 8��Ʈ ������ ���� ���ۼ�ġ ����
		TriggerX(FP,{NVar(Stat_ScDmg[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+12, Add, 2^CBit)},{preserved})
		TriggerX(FP,{NVar(General_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit)},{preserved})
	end
	--if Limit == 1 then--�������ڿ� ġƮ
	--	CIf(FP,{Deaths(i,AtLeast,1,100)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)})
	--	CMov(FP,IncomeMax[i+1],48,nil,nil,1)
	--	CIfEnd()
	--end

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 91)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)},{preserved})--���� �����÷ο� ����
	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)},{}) --  ���� ��ȭ�õ��ϱ�. 39�� ��������
	CMov(FP,GEper,TotalEPer[i+1])
	CMov(FP,GEper2,TotalEPer2[i+1])
	CMov(FP,GEper3,TotalEPer3[i+1])
	CMov(FP,GEper4,TotalEPer[i+1])
	CAdd(FP,GEper4,TotalEPer2[i+1])
	CAdd(FP,GEper4,TotalEPer3[i+1])
	CAdd(FP,GEper4,TotalEPer4[i+1])

	CMov(FP,BreakShield,Stat_BreakShield[i+1])

	for j = 39, 1, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		CallTriggerX(FP, Call_Enchant, {Bring(i,AtLeast,1,UID,8+i)}, {KillUnitAt(1, UID, 8+i, i),SetV(ELevel,LV-1),SetV(UEper,Per),SetV(ECP,i)})
	end
	for j = 43, 40, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		CIf(FP,{Bring(i,AtLeast,1,UID,8+i)})
		CSub(FP,XEper,GEper4,Per)
		CallTriggerX(FP, Call_Enchant2, {CV(XEper,1,AtLeast)}, {KillUnitAt(1, UID, 8+i, i),SetV(ELevel,LV-1),SetV(ECP,i)})
		TriggerX(FP,{CV(XEper,0)},{MoveUnit(All,UID,i,8+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0),DisplayText(StrDesignX("\x08ERROR \x04: Ȯ���� �����Ͽ� ��ȭ�� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
		CIfEnd()
	end

	CIfEnd()

	CIf(FP,{Bring(i,AtLeast,1,"Men",73+i)},{}) --  ���� �ǸŽõ��ϱ�
		CIfX(FP,{CV(PLevel[i+1],LevelLimit,AtLeast)},{MoveUnit(All,"Men",i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: �̹� ������ �޼��Ͽ� �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)})
		local ASArr = {}
		for j = #LevelUnitArr, 1, -1 do
			table.insert(ASArr,SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0))
		end
		DoActions2X(FP,ASArr)

		CElseX()
		f_LMov(FP,TempEXPW,"0",nil,nil,1)
		for j = #LevelUnitArr, 1, -1 do
			local UID = LevelUnitArr[j][2]
			local EXP = LevelUnitArr[j][4]
			if EXP>=1 then
				if j>=26 then
					TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],0,AtMost)},{MoveUnit(All,UID,i,73+i,36+i),SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: \x17���� �Ǹű�\x04�� �����մϴ�... \x07L Ű\x04�� ���������� Ȯ�����ּ���."), 4),SetCp(FP)},{preserved})
					TriggerX(FP,{},{},{preserved})
					CIf(FP,{Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],1,AtLeast)},{KillUnitAt(1, UID, 73+i, i),SubV(SellTicket[i+1],1)})
					f_LAdd(FP, TempEXPW,TempEXPW, tostring(EXP))
					CIfEnd()
					
				else
					CIf(FP,{Bring(i,AtLeast,1,UID,73+i)},{KillUnitAt(1, UID, 73+i, i)})
					f_LAdd(FP, TempEXPW,TempEXPW, tostring(EXP))
					CIfEnd()
				end
			else
				
				--CallTriggerX(FP,Call_Print13[i+1],{Bring(i,AtLeast,1,UID,73+i)})
				TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{MoveUnit(1,UID,i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: �ش� ������ �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
			end

			
		end
		TriggerX(FP,{Bring(i,AtLeast,1,88,73+i)},{MoveUnit(1,88,i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: �ش� ������ �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
        CIf(FP,{TTNWar(TempEXPW,AtLeast,"1")})
            f_LAdd(FP, PEXP[i+1], PEXP[i+1],TempEXPW)
            CIf(FP,{CV(Stat_EXPIncome[i+1],1,AtLeast)})
                f_LAdd(FP,PEXP2[i+1],PEXP2[i+1],_LMul(TempEXPW,{Stat_EXPIncome[i+1],0}))
                f_LAdd(FP, PEXP[i+1], PEXP[i+1], _LDiv(PEXP2[i+1],"10"))
                f_LMod(FP, PEXP2[i+1],PEXP2[i+1], "10")
            CIfEnd()
        CIfEnd()
		CIfXEnd()
	CIfEnd()


	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0),SetCD(ResetStatLoc,0)}) -- CAPrint�� ������ ����
	CallTrigger(FP, Call_GetLocalData)
	f_LMov(FP,MoneyLoc,Money[i+1])
	f_LMov(FP,MoneyLoc2,Money2[i+1])
	f_LMov(FP,CredLoc,Credit[i+1])
	f_LMov(FP,ExpLoc,_LSub(PEXP[i+1], CurEXP[i+1]),nil,nil,1)
	f_LMov(FP,TotalExpLoc,_LSub(TotalExp[i+1], CurEXP[i+1]),nil,nil,1)
	TriggerX(FP,{CD(StatEff[i+1],1)},{SetCD(StatEffLoc,1)},{preserved})
	TriggerX(FP,{CV(ResetStat[i+1],1)},{SetCD(ResetStatLoc,1)},{preserved})
	CIfEnd()
	DoActionsX(FP,{SubCD(ZKeyCool[i+1], 1)})
		--��Ű QCUnit ��Ϲ���
		local Cunit2 = CreateVar(FP)
		local KSelUID = CreateVar(FP)
		local KSelPID = CreateVar(FP)
		f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,19025),CVar(FP,Cunit2[2],AtMost,19025+(1700*84))})
		CMov(FP,0x6509B0,Cunit2,25)


				CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,ParseUnit("Zerg Scourge"),0,0xFF)},{TSetMemory(0x6284E8+(0x30*i),SetTo,ShopPtr[i+1]),TSetMemory(0x6509B0, SetTo, _Add(TestShop[i+1],25))},1)
				CIfX(FP,{CD(ZKeyCool[i+1],0),MSQC_KeyInput(i,"Z")},{})
				f_SaveCp()
				
				CMov(FP, KSelUID, _SHRead(BackupCp), nil, 0xFF, 1)
				CMov(FP, KSelPID, _SHRead(_Sub(BackupCp,6)), nil, 0xFF, 1)
				CIf(FP,{CV(KSelPID,i),TTNVar(KSelUID,NotSame,15),TTNVar(KSelUID,NotSame,15),TTNVar(KSelUID,NotSame,128),TTNVar(KSelUID,NotSame,129),TTNVar(KSelUID,NotSame,219),TTNVar(KSelUID,NotSame,91),TTNVar(KSelUID,NotSame,92),TTNVar(KSelUID,NotSame,PersonalUIDArr[i+1])})
				f_Read(FP, _Sub(BackupCp,15), CPos, nil,nil,1)
				Convert_CPosXY()
				Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,Simple_CalcLoc(86, -256, -256, 256, 256))
				CDoActions(FP, {AddCD(ZKeyCool[i+1], 24*3),TMoveUnit(All, KSelUID, i, 87, 87);SetCp(i),DisplayText(StrDesignX("\x03SYSTEM \x04: ���� �������� ���� ������ ������ ���ƽ��ϴ�. ��Ÿ�� : 3��"),4)})
				CIfEnd()
				f_LoadCp()
				CElseIfX({MSQC_KeyInput(i,"Z"),CD(ZKeyCool[i+1],1,AtLeast)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: ���� ���� ��ġ�� ����� ��Ÿ�����Դϴ�."),4)})
				CIfXEnd()
				if TestStart == 1 then
					--CTrigger(FP,{KeyPress("Y", "Down")},{SetMemory(0x6509B0,Subtract,6),TSetDeathsX(CurrentPlayer,SetTo,0,0,0xFF),SetMemory(0x6509B0,Add,6)},1)
					--f_SaveCp()
					--local temp,TKey = ToggleFunc({KeyPress("T","Up"),KeyPress("T","Down")},nil,1)--
					--local temp,YKey = ToggleFunc({KeyPress("Y","Up"),KeyPress("Y","Down")},nil,1)--
					--local FID = CreateVar(FP)
					--CMov(FP,FID,_Read(_Sub(BackupCp, 16)),nil,0xFF,1)
					--CTrigger(FP,{CD(TKey,1)},{TSetMemory(_Add(FID,EPD(0x6C9930)),Add,1)},1)
					--CTrigger(FP,{CD(YKey,1)},{TSetMemory(_Add(FID,EPD(0x6C9930)),Subtract,1)},1)
					--CIf(FP,{TTOR({CD(TKey,1),CD(YKey,1)})})
					--local HD = CreateVar(FP)
					--CMov(FP,HD,_Read(_Add(FID,EPD(0x6C9930))))
					--DisplayPrint(i, {"HaltDis : ",HD})
					--CIfEnd()
					--f_LoadCp()
				end
		CIfEnd()
		CMov(FP,0x6509B0,FP)
	CIfEnd()
end




end
