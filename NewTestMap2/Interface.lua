function Interface()
	CheckTrig("Interface_Forward")
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
	local ResetStat2 = iv.ResetStat2
	local General_Upgrade = iv.General_Upgrade--CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	local PBossLV = iv.PBossLV -- ���κ�������
	local PBossDPS = iv.PBossDPS-- ���κ���DPS
	local TotalPBossDPS = iv.TotalPBossDPS --���κ���DPS ��ǥġ
	local SellTicket = iv.SellTicket
	local BanFlag = iv.BanFlag
	local BanFlag2 = iv.BanFlag2
	local BanFlag3 = iv.BanFlag3
	local BanFlag4 = iv.BanFlag4
	local BanFlag5 = iv.BanFlag5
	local BanFlag6 = iv.BanFlag6
	local BanFlag7 = iv.BanFlag7
	local BanFlag8 = iv.BanFlag8
	local CS_EXPData = iv.CS_EXPData
	local CS_TEPerData = iv.CS_TEPerData
	local CS_TEPer4Data = iv.CS_TEPer4Data
	local CS_BreakShieldData = iv.CS_BreakShieldData
	local TotalBreakShield = iv.TotalBreakShield
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
	local Stat_BossSTic = iv.Stat_BossSTic--CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_BossLVUP = iv.Stat_BossLVUP--CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_TotalEPer = iv.Stat_TotalEPer--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPerEx = iv.Stat_TotalEPerEx--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPerEx2 = iv.Stat_TotalEPerEx2--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPerEx3 = iv.Stat_TotalEPerEx3--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPer2 = iv.Stat_TotalEPer2--CreateVarArr(7,FP)-- +2�� Ȯ�� ��ġ
	local Stat_TotalEPer3 = iv.Stat_TotalEPer3--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_TotalEPer4 = iv.Stat_TotalEPer4--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_TotalEPer4X = iv.Stat_TotalEPer4X--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_BreakShield = iv.Stat_BreakShield--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_BreakShield2 = iv.Stat_BreakShield2--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
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
	local TimeAttackScore48 = iv.TimeAttackScore48
	local TimeAttackScore2 = iv.TimeAttackScore2
	local PUnitLevel = iv.PUnitLevel
	local PUnitClass = iv.PUnitClass
	local CS_Cooldown = iv.CS_Cooldown
	local CS_Atk = iv.CS_Atk
	local CS_EXP = iv.CS_EXP
	local CS_TotalEPer = iv.CS_TotalEPer
	local CS_TotalEper4 = iv.CS_TotalEper4
	local CS_DPSLV = iv.CS_DPSLV
	local CS_BreakShield = iv.CS_BreakShield
	local Stat_LV3Incm = iv.Stat_LV3Incm
	local SCCool = iv.SCCool
	local AddSC = iv.AddSC
	local PETicket = iv.PETicket
	local DayCheck = iv.DayCheck
	local DayCheck2 = iv.DayCheck2
	local MonthCheck = iv.MonthCheck
	local YearCheck = iv.YearCheck
	local Stat_BossSFrg = iv.Stat_BossSFrg
	local Stat_XEPer44 = iv.Stat_XEPer44
	local Stat_XEPer45 = iv.Stat_XEPer45
	local Stat_XEPer46 = iv.Stat_XEPer46
	local Stat_XEPer47 = iv.Stat_XEPer47
	--Local Data Variable
	local MoneyLoc = iv.MoneyLoc--CreateWar(FP)
	local CredLoc = iv.CredLoc--CreateWar(FP)
	local ExpLoc = iv.ExpLoc--CreateVar(FP)
	local TotalExpLoc = iv.TotalExpLoc--CreateVar(FP)
	local StatEffLoc = iv.StatEffLoc--CreateCcode()
	local BrightLoc = iv.BrightLoc--CreateVar2(FP,nil,nil,31)
	local ResetStatLoc = iv.ResetStatLoc
	local ResetStat2Loc = iv.ResetStat2Loc
	--Temp
	local CTStatP2 = iv.CTStatP2--CreateVar(FP)
	local TempEXPW = iv.TempEXPW--CreateVar(FP)
	local TempEXPW2 = iv.TempEXPW2--CreateVar(FP)

	local CheatDetect = iv.CheatDetect--CreateCcode()
	local StatTest = iv.StatTest--CreateCcode()
	local FStatTest = iv.FStatTest--CreateCcode()
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
	local B_PEXP = iv.B_PEXP--CreateVar(FP)
	local B_PEXP2 = iv.B_PEXP2--CreateVar(FP)
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
	local MissionV = iv.MissionV
	local CurMission = iv.CurMission
	
	local PBossClearFlag = iv.PBossClearFlag
	PLevelBak = CreateVar(FP)
	local BossLV6Private = CreateCcodeArr(7)




	--local GEXP = CreateVar(FP)
	--local STable = {"1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "2048", "4096", "8192", "16384", "32768", "65536", "131072", "262144", "524288", "1048576", "2097152", "4194304", "8388608", "16777216", "33554432", "67108864", "134217728", "268435456", "536870912", "1073741824", "2147483648", "4294967296", "8589934592", "17179869184", "34359738368", "68719476736", "137438953472", "274877906944", "549755813888", "1099511627776", "2199023255552", "4398046511104", "8796093022208", "17592186044416", "35184372088832", "70368744177664", "140737488355328", "281474976710656", "562949953421312", "1125899906842624", "2251799813685248", "4503599627370496", "9007199254740992", "18014398509481984", "36028797018963968", "72057594037927936", "144115188075855872", "288230376151711744", "576460752303423488", "1152921504606846976", "2305843009213693952", "4611686018427387904", "9223372036854775807"}
	local Time = iv.Time
	local Time2 = iv.Time2

	local MissionPDataArr = {}
	local MissionDataTextArr = {}
	local XEPerT = iv.XEPerT
	local XEPerM = iv.XEPerM
	
	-- 15�� �Ǹ� ok
	-- �ΰ��� 3�ð� �޼� ok
	-- ��ȭȮ�� +1 ������ ok
	-- �Ǹű� �Ǹ��ϱ� ok
	-- 5���� 5ȸ ����(�ѹ���) ok
	-- 40�� 48���� ���� ok
	-- ��� �����ϱ� ok
	-- ����� ����Ͽ� 10�� �޼� ok
	
	-- Ȯ������ ����Ͽ� 10�� �޼� ok


	for i = 0, 6 do
		local MissionDataArr = { -- {Cond,RewardArr,Text}  RewardArr = {Credit,SellTicket,VaccItem,EXP,PETicket}
		{{CVX(MissionV[i+1],1,1)},{1000,0,0,1000},"B,N,MŰ�� ���� ���� �б�"},
		{{Command(i, AtLeast, 1, LevelUnitArr[2][2])},{1000},"2�� ���� �����"},
		{{CV(Income[i+1],12,AtLeast)},{2000},"����Ϳ� ���� 12�� ä���"},
		{{Command(i, AtLeast, 1, LevelUnitArr[11][2])},{1500},"11�� ���� �����"},
		{{Command(i, AtLeast, 1, LevelUnitArr[15][2])},{2500},"15�� ���� �����"},
		{{NWar(Money[i+1], AtLeast, "5000000")},{1000},"500���� ������"},
		{{CV(PBossLV[i+1],1,AtLeast)},{1500},"���κ��� LV.1 óġ�ϱ�"},
		{{CVX(MissionV[i+1],32,32)},{1000,10,0,500},"15�� ���� �Ǹ��ϱ�"},
		{{Command(i, AtLeast, 1, LevelUnitArr[20][2])},{5000,0,0,8000},"20�� ���� �����"},
		{{CV(PLevel[i+1],50,AtLeast)},{10000},"LV. 50 �޼�"},
		{{CV(PBossLV[i+1],5,AtLeast)},{15000},"���κ��� LV.5 óġ�ϱ�"},
		{{CVX(MissionV[i+1],8,8)},{1000},"���� �ù� ��ư���� ���� ���� �����ϱ�"},
		{{CVX(MissionV[i+1],4,4)},{5000,10},"�������� ���� �Ǹű� 1�� �̻� �����ϱ�"},
		{{CVX(MissionV[i+1],64,64)},{5000,10},"�������� ���� �Ǹű� 1�� �̻� ���ȱ�"},
		{{Command(i, AtLeast, 1, LevelUnitArr[26][2])},{10000,50},"26�� ���� �����"},
		{{CV(PlayTime[i+1],3600*3,AtLeast)},{10000,100},"�� �÷��� �ð� 3�ð� �޼��ϱ�"},
		{{CV(PLevel[i+1],100,AtLeast)},{50000},"LV. 100 �޼�"},
		{{CV(Stat_TotalEPer[i+1],10000,AtLeast)},{10000,100},"��ȭȮ�� +1 ���� ���� ������"},
		{{Command(i, AtLeast, 1, LevelUnitArr[36][2])},{50000,100},"36�� ���� �����"},
		{{CV(PLevel[i+1],500,AtLeast)},{100000},"LV. 500 �޼�"},
		{{Command(i, AtLeast, 1, LevelUnitArr[40][2])},{100000,500},"40�� ���� �����"},
		{{CV(PLevel[i+1],1000,AtLeast)},{100000},"LV. 1000 �޼�"},
		{{Command(i, AtLeast, 48, LevelUnitArr[40][2])},{300000,2000},"40�� ���� 48�� ����"},
		{{CVX(MissionV[i+1],256,256)},{50000,500,1},"�������� ��ȭ�� ��� 1�� �̻� �����ϱ�"},
		{{CVX(MissionV[i+1],2,2)},{30000,100,3},"�������� ��ȭ �õ��ϱ�"},
		{{CVX(MissionV[i+1],1024,1024)},{100000,500,1},"�������� ��ȭ�� ��� 1�� �̻� ���ȱ�"},
		{{CVX(MissionV[i+1],8192,8192)},{300000},"�������� ��ȭ ���� �Ǵ� �����ϱ�"},
		{{CV(PUnitLevel[i+1],10,AtLeast)},{250000,0,5,0,1},"�������� 10�� �޼��ϱ�"},
		{{CVX(MissionV[i+1],16,16)},{100000,500},"�������� �±��ϱ�"},
		{{CD(VaccSCount[i+1],5,AtLeast)},{250000,2000},"�������� ��ȭ�� ��� 5�� �̻� ���ȱ�"},
		{{CVX(MissionV[i+1],128,128)},{250000,0,3},"��ȭ�� ��� �Ǵ� Ȯ�� ��ȭ�� ������� �������� 10�� �޼��ϱ�"},
		{{CV(iv.PMission[i+1],3,AtLeast)},{250000,0,3},"�������� ��ȭ 3���� �����ϱ�"},
		{{Command(i, AtLeast, 1, LevelUnitArr[44][2])},{1000000,0,0,0,1},"44�� ���� �����"},
		{{CV(PUnitClass[i+1],62,AtLeast)},{3000000,0,0,0,2},"�������� 62�� �����"},
		{{CVX(MissionV[i+1],2048,2048)},{0,10000,0,0,1},"Ȯ�� ��ȭ���� ���� �������� �ٲٱ�"},
		{{CVX(MissionV[i+1],4096,4096)},{0,50000},"45�� ���� �Ǹ��ϱ�"},

		}
		table.insert(MissionPDataArr,MissionDataArr)
		
	end
	local rewardarr = {0,0,0,0,0}
	os.execute("mkdir " .. "MSQC")
	local CSfile = io.open(FileDirectory .. "sul" .. ".txt", "w")
	io.output(CSfile)
	for j,k in pairs(MissionPDataArr[1]) do
		local MText = "\x07M\x04ission \x08No. \x10"..j.." \x04: "..k[3].." \x04|| \x07���� \x04: "
		local MText3 = "Mission No. "..j.." : "..k[3].." || ���� : "
		local MText2 = "\x07M\x04ission \x08No. \x10"..j.." \x04: "..k[3].." \x07CLEAR"
		for l,m in pairs(k[2]) do
			if m>= 1 then
				if l == 1 then
					MText = MText.."\x17("..m.." Credit) "
					MText3 = MText3.."("..m.." Credit) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 2 then
					MText = MText.."\x19("..m.." ���� �Ǹű�) "
					MText3 = MText3.."("..m.." ���� �Ǹű�) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 3 then
					MText = MText.."\x10("..m.." ��ȭ�� ���) "
					MText3 = MText3.."("..m.." ��ȭ�� ���) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 4 then
					MText = MText.."\x1F("..m.." EXP) "
					MText3 = MText3.."("..m.." EXP) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 5 then
					MText = MText.."\x1F("..m.." Ȯ�� ��ȭ��) "
					MText3 = MText3.."("..m.." Ȯ�� ��ȭ��) "
					rewardarr[l] = rewardarr[l]+m
				end
			end
		end
		io.write(MText3.."\n")
		table.insert(MissionDataTextArr,{StrDesign(MText),StrDesignX(MText2)})
	end
	io.write(rewardarr[1].." ũ����    "..rewardarr[2].." ���� �Ǹű�    "..rewardarr[3].." ��ȭ�� ���    "..rewardarr[4].." EXP    "..rewardarr[5].." Ȯ�� ��ȭ��")
	io.close(CSfile)
	

	CMov(FP,PCheckV,0)
	if Limit == 1 then
		CAdd(FP,GeneralPlayTime,1)
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
	
	Trigger2X(FP, {CD(PartyBonus,2,AtLeast)}, {RotatePlayer({DisplayExtText(StrDesignX("\x04���� �ε� �ο��� 2�� �̻� �����Ǿ����ϴ�. \x07�������� 1�� �������� ��Ƽ ������ Ȱ��ȭ�˴ϴ�."))}, Force1, FP)})
	Trigger2X(FP, {CD(PartyBonus,2,AtLeast)}, {SetCD(PartyBonus2,1)},{preserved})
	
	Trigger2X(FP, {CD(PartyBonus,1,AtMost),CV(PCheckV,2,AtLeast)}, {SetCD(PartyBonus2,1)},{preserved})--���� �ҷ��»�� 1�������ε� ��Ƽ�ϰ�� ���ʽ� Ȱ��ȭ
	Trigger2X(FP, {CD(PartyBonus,1,AtMost),CV(PCheckV,1,AtMost)}, {SetCD(PartyBonus2,0)},{preserved})-- ���� �ҷ��»�� 1�������ε� �ַ��ϰ�� ���ʽ� ��Ȱ��ȭ
	if TestStart == 1 then
		DoActionsX(FP, {AddV(XEPerT,100)})
		
	end
	DoActionsX(FP, {AddV(XEPerT,1)})
	Trigger2X(FP,{CV(XEPerT,864,AtLeast)},{SubV(XEPerT,864),AddV(XEPerM,1),
	--RotatePlayer({DisplayExtText(StrDesignX("\x1F44��\x04~\x1E46�� \x04������ \x08��ȭȮ���� \x0F0.1%p \x08�϶�\x04�Ͽ����ϴ�.\x07"), 4),DisplayExtText(StrDesignX("\x1F44��\x04~\x1E46�� \x04������ ��ȭȮ���� 1�ð����� 0.1%p�� �϶��մϴ�.\x07"), 4)}, Force1, FP),
},{preserved})

	
TipArr = {
	StrDesignX("\x04TIP : \x04���� ���� �� ZŰ�� ������ �Ѱ��� ��Ĩ�ϴ�."),	StrDesignX("\x04TIP : \x1F�̳׶�\x04, \x07����\x04�� ���� �ڽ��� �ǹ��� �������� ��� ���� DPS�� ��Ÿ���ϴ�."),
	StrDesignX("\x04TIP : \x17OŰ\x04�� ������ ���� ���� ���� ���� ������ �й��� �� �ֽ��ϴ�."),
	StrDesignX("\x04TIP : \x04��ȭ ������ �ܰ谡 \x08+1 \x04�Ӹ� �ƴ϶� ���� Ȯ���� \x1C+2\x04, \x1F+3\x04 �� �ö� �� �ֽ��ϴ�."),}

for i = 0, 6 do -- ���÷��̾� 
	local XEperArr={iv.XEPer44[i+1],iv.XEPer45[i+1],iv.XEPer46[i+1],iv.XEPer47[i+1]}
	CIf(FP,{HumanCheck(i,1)},{SetCp(i),SetV(GCP,i),SetNWar(GCPW,SetTo,tostring(i))})
	CT_PrevCP(i)

	ConvertVArr(FP,VArrI,VArrI4,GCP,7)
	ConvertWArr(FP, WArrI,WArrI4, GCPW, 7)
	TriggerX(FP,{MSQC_KeyInput(i, "B")},{SetVX(MissionV[i+1],1,1)},{preserved})
	TriggerX(FP,{MSQC_KeyInput(i, "N")},{SetVX(MissionV[i+1],1,1)},{preserved})
	TriggerX(FP,{MSQC_KeyInput(i, "M")},{SetVX(MissionV[i+1],1,1)},{preserved})

	

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+11, AtLeast, 11),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayExtText("g\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--������ġ �����ν�, ����

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+12, AtLeast, 251),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayExtText("s\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--������ġ �����ν�, ����
	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 100),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayExtText("u\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--������ġ �����ν�, ����

	
	DoActionsX(FP, {AddV(ScTimer[i+1],1),AddV(PTimeV[i+1],1),SubV(DPErT[i+1],1)})

	CDoActions(FP,{TSetScore(i,SetTo,PLevel[i+1],Custom)})
	CIf(FP,CV(PTimeV[i+1],24,AtLeast), {SubV(PTimeV[i+1],24),AddV(PlayTime[i+1],1),SubV(TimeAttackScore2[i+1],1),})
	--TriggerX(FP, {CV(LV5Cool[i+1],1,AtLeast),}, {SubV(LV5Cool[i+1],1)},{preserved})
	CIfEnd()

	DoActions(FP, {SetSwitch("Switch 100",Random),SetSwitch("Switch 101",Random)})
	TriggerX(FP,{LocalPlayerID(i),Command(i,AtMost,1,"Men"),Command(i,AtMost,0,"Factories"),CV(Time2,60000,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(Time2,0),SetMemory(0x58F500, SetTo, 1),DisplayExtText(StrDesignX("\x03SYSTEM \x04: ���� ������ ���� ��� \x07�����ð� \x031��\x04���� \x1C�ڵ����� \x04�˴ϴ�. \x07������..."), 4),DisplayExtText(StrDesignX("\x03SYSTEM \x04: ���������� F9�� �����ּ���."),4)},{preserved})
	CIf(FP,{LocalPlayerID(i),CV(Time,300000,AtLeast)},{SubV(Time,300000)})
	TriggerX(FP,{LocalPlayerID(i),CD(SCA.LoadCheckArr[i+1],2),CD(SaveRemind,0)},{DisplayExtText(StrDesignX("\x03SYSTEM \x04: \x07�����ð� \x035��\x04���� \x1C�ڵ����� \x04�˴ϴ�. \x07������..."), 4),DisplayExtText(StrDesignX("\x03SYSTEM \x04: ���������� F9�� �����ּ���."),4)},{preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SaveRemind,0),CD(PartyBonus2,1,AtLeast)},{DisplayExtText(StrDesignX("\x04���� \x1F��Ƽ �÷��� ���ʽ� ���� \x1C�������Դϴ�. - \x08���ݷ� + 150%\x04, \x07+1�� \x17��ȭȮ�� + \x0F1.0%p"),4)},{preserved})-- �ο��� ���� ���ʽ�
	TriggerX(FP,{LocalPlayerID(i),CV(PLevel[i+1],999,AtMost)},{DisplayExtText(StrDesignX("\x04���� \x1F�ʺ��� ���ʽ� ���� \x1C�������Դϴ�. \x041000���� �޼� ������ \x1C�ǸŽ� ����ġ ȹ�淮 2��"),4)},{preserved})-- 1000���� �̸� 5�ۼ�Ʈ ��Ȯ���ʽ�
	TriggerX(FP,{Switch("Switch 100", Cleared),Switch("Switch 101", Cleared)}, {DisplayExtText(StrDesignX("\x04TIP : \x04���� ���� �� ZŰ�� ������ �Ѱ��� ��Ĩ�ϴ�."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Set),Switch("Switch 101", Cleared)}, {DisplayExtText(StrDesignX("\x04TIP : \x1F�̳׶�\x04, \x07����\x04�� ���� �ڽ��� �ǹ��� �������� ��� ���� DPS�� ��Ÿ���ϴ�."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Cleared),Switch("Switch 101", Set)}, {DisplayExtText(StrDesignX("\x04TIP : \x17OŰ\x04�� ������ ���� ���� ���� ���� ������ �й��� �� �ֽ��ϴ�."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Set),Switch("Switch 101", Set)}, {DisplayExtText(StrDesignX("\x04TIP : \x04��ȭ ������ �ܰ谡 \x08+1 \x04�Ӹ� �ƴ϶� ���� Ȯ���� \x1C+2\x04, \x1F+3\x04 �� �ö� �� �ֽ��ϴ�."),4)}, {preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SCA.LoadCheckArr[i+1],2)},{SetMemory(0x58F500, SetTo, 1),},{preserved})
	TriggerX(FP,{LocalPlayerID(i)},{SetCD(SaveRemind,0)},{preserved})

	CIfEnd()--
	if TestStart == 0 then
		for j,k in pairs(BPArr) do
			TriggerX(FP, {Deaths(i, Exactly, 0,14),CV(k[i+1],1,AtLeast)},{SetDeaths(i,SetTo,1,14)})
	
			TriggerX(FP, {CD(SCA.LoadCheckArr[i+1],0),CV(k[i+1],1,AtLeast),LocalPlayerID(i)},{
				SetCp(i),
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayExtText("B\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
				DisplayExtText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵�, ���� �̳׶�, ���� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
				SetMemory(0xCDDDCDDC,SetTo,1);
			})
		end
	end
	CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],1)},{SetCD(CheatDetect,0),SetCD(StatTest, 0),SetCD(FStatTest, 0),SetCD(SCA.LoadCheckArr[i+1],2),SetV(TimeAttackScore2[i+1],TimeScoreInit)})--�ε� �Ϸ�� ù ���� Ʈ����
		CIfX(FP, {TDeaths(_Add(SCA.PLevel,18*i),AtLeast,1,0)})--���������Ͱ� ������� �ε��� ��� �����, ������ ����� �����ϰ� �ε����
		CallTrigger(FP,Call_SCA_DataLoadAll)
		for j,k in pairs(SCA_DataArr) do
			--SCA_DataLoad(i,k[1][i+1],k[2])
		end
		for j,k in pairs(RSArr) do
			CTrigger(FP, {CV(k[i+1],0)}, {SetV(k[i+1],_Rand())}, 1)
		end
		--TriggerX(FP,{CV(LV5Cool[i+1],1,AtLeast)},SetCD(BossLV6Private[i+1],0x32223222))
		--ġ�� �׽�Ʈ ���� �ʱ�ȭ]
		NIfX(FP,{CV(iv.FStatVer[i+1],StatVer2)},{SetNWar(TempFfragTotal,SetTo,0)})--���ȹ����� ����� ���� ���ų� �����ڰ� �ƴҰ�� ��� ġ�� ���� �۵�
		local FStatTestJump = def_sIndex()
		CallTrigger(FP,Call_FCT)
		NJump(FP, FStatTestJump, CD(FStatTest,1,AtLeast))
		NElseX()
		NJumpEnd(FP, FStatTestJump)--���� ���Ἲ �˻� ���н� �ڵ����� �ʱ�ȭ
		DoActionsX(FP, {
			SetV(iv.FXPer44[i+1],0),
			SetV(iv.FXPer45[i+1],0),
			SetV(iv.FXPer46[i+1],0),
			SetV(iv.FXPer47[i+1],0),
			SetV(iv.FIncm[i+1],0),
			SetV(iv.FSEXP[i+1],0),
			SetV(iv.FMEPer[i+1],0),
			SetV(iv.FBrSh[i+1],0),
			SetNWar(iv.FfragItemUsed[i+1],SetTo,"0"),
		})
		CTrigger(FP, {TTNVar(iv.FStatVer[i+1], NotSame, StatVer2)}, {SetCp(i),
		DisplayExtText(StrDesignX("\x04���� ������ \x07�ʱ�ȭ\x04�Ǿ����ϴ�. \x08���� \x04: \x07���� ��"), 4),}, 1)
		for h = 1, 4 do
			local NBit = 2^(h-1)
			CTrigger(FP, {CDX(FStatTest,NBit,NBit)}, {SetCp(i),
			DisplayExtText(StrDesignX("\x04���� ������ \x07�ʱ�ȭ\x04�Ǿ����ϴ�. \x08���� \x04: \x02���� ������ ���Ἲ �˻� ����. \x04�����ڵ� : "..h), 4),}, 1)
		end
		NIfXEnd()
		NIfX(FP,{CV(PStatVer[i+1],StatVer)},{})--���ȹ����� ����� ���� ���ų� �����ڰ� �ƴҰ�� ��� ġ�� ���� �۵�
		f_LMov(FP, CTPEXP, PEXP[i+1])
		CMov(FP,CTStatP2,StatP[i+1])
		f_LMov(FP, CTCurEXP, "0",nil,nil,1)
		f_LMov(FP, CTTotalExp, "0",nil,nil,1)
		CMov(FP,CTStatP,_Mul(iv.PLevel2[i+1],_Mov(5)))
		CMov(FP,CTPLevel,iv.PLevel2[i+1])
		CallTrigger(FP,Call_CT)
		CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCDX(StatTest,1,1)})
		CIfX(FP,{CV(iv.MapMakerFlag[i+1],0)})
			CTrigger(FP, {TTNVar(CTPLevel,NotSame,PLevel[i+1])}, {SetCDX(StatTest,2,2)})
		CElseX()
			CTrigger(FP, {}, {SetV(PLevel[i+1],CTPLevel)})
		CIfXEnd()
		CTrigger(FP, {TTNWar(CTCurEXP,NotSame,CurEXP[i+1])}, {SetCDX(StatTest,4,4)})
		CTrigger(FP, {TTNWar(CTTotalExp,NotSame,TotalExp[i+1])}, {SetCDX(StatTest,8,8)})
		
		local StatTestJump = def_sIndex()
		NJump(FP, StatTestJump, CD(StatTest,1,AtLeast))
		NElseX()--�� ���� ������ ������ ��� ġ�ð��� �۵�X, ������ �ʱ�ȭ��
		NJumpEnd(FP, StatTestJump)--���� ���Ἲ �˻� ���н� �ڵ����� �ʱ�ȭ

		CTrigger(FP, {TTNVar(PStatVer[i+1], NotSame, StatVer)}, {SetCp(i),
		DisplayExtText(StrDesignX("\x04������ \x07�ʱ�ȭ\x04�Ǿ����ϴ�. \x08���� \x04: \x07���� ��"), 4),}, 1)
		for h = 1, 5 do
			local NBit = 2^(h-1)
			CTrigger(FP, {CDX(StatTest,NBit,NBit)}, {SetCp(i),
			DisplayExtText(StrDesignX("\x04������ \x07�ʱ�ȭ\x04�Ǿ����ϴ�. \x08���� \x04: \x10����, ���� ���Ἲ �˻� ����. \x04�����ڵ� : "..h), 4),}, 1)
		end
		CIf(FP,CD(StatTest,1,AtLeast))
		DisplayPrint(i, {"\x13\x07�� \x03SYSTEM Message \x04- \x04CTPLevel : ",CTPLevel,"    PLevel : ",PLevel[i+1]," \x07��"})
		DisplayPrint(i, {"\x13\x07�� \x03SYSTEM Message \x04- \x04CTStatP : ",CTStatP,"    CTStatP2 : ",CTStatP2," \x07��"})
		CIfEnd()

		DoActionsX(FP, {
			SetV(PLevel[i+1],1),
			SetV(StatP[i+1],5),
			SetCWar(FP, CurEXP[i+1][2], SetTo, "0"),
			SetCWar(FP, TotalExp[i+1][2], SetTo, "10"),
			SetV(Stat_BossSTic[i+1],0),
			SetV(Stat_TotalEPer[i+1],0),
			SetV(Stat_TotalEPer2[i+1],0),
			SetV(Stat_TotalEPer3[i+1],0),
			SetV(Stat_TotalEPer4[i+1],0),
			SetV(Stat_TotalEPer4X[i+1],0),
			SetV(Stat_BreakShield[i+1],0),
			SetV(Stat_BreakShield2[i+1],0),
			SetV(Stat_TotalEPerEx[i+1],0),
			SetV(Stat_TotalEPerEx2[i+1],0),
			SetV(Stat_TotalEPerEx3[i+1],0),
			SetV(Stat_LV3Incm[i+1],0),
			SetV(Stat_Upgrade[i+1],0),
			SetV(Stat_BossLVUP[i+1],0),
			SetV(Stat_BossSFrg[i+1],0),
			SetV(Stat_XEPer44[i+1],0),
			SetV(Stat_XEPer45[i+1],0),
			SetV(Stat_XEPer46[i+1],0),
			SetV(Stat_XEPer47[i+1],0),
			SetCp(i),
			SetCp(FP)})
		NIfXEnd()

		
		--CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--������ Īȣ ������ ��ī 6�� �߰�����
		
			CTrigger(FP, {CV(BanFlag4[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			CTrigger(FP, {CV(BanFlag3[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			CTrigger(FP, {CV(BanFlag2[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			CTrigger(FP, {CV(BanFlag[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			CTrigger(FP, {CV(BanFlag8[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			CTrigger(FP, {CV(BanFlag7[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			CTrigger(FP, {CV(BanFlag6[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			CTrigger(FP, {CV(BanFlag5[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
			TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
				SetCp(i),
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayExtText("LB\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
				DisplayExtText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵�, ���� �̳׶�, ���� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
				SetMemory(0xCDDDCDDC,SetTo,1);})
		CElseX()--������ 0�� ��� ��������
		SCA_DataLoad(i,PlayTime2[i+1],SCA.PlayTime2)--�� �̿�ð� �ҷ���
		SCA_DataLoad(i,iv.TesterFlag[i+1],SCA.TesterFlag)--�׽����÷��� �ҷ���
		TriggerX(FP,{CV(iv.TesterFlag[i+1],1,AtLeast)},{SetV(ScTimer[i+1],0),SetV(CreditAddSC[i+1],1),RemoveUnit(88, i),SetCp(i),DisplayExtText(StrDesignX("\x04�׽�Ʈ ���� Ư������ ���� ������ �帳�ϴ�. \x07�ٽ��ѹ� �÷������ּż� �����մϴ�.").."\n"..StrDesignX("\x07�⺻���� 6��\x04 ����. \x08���� \x04: \x07�⺻����\x04�� ���� ���� 1ȸ���� �����ϸ� 3�� �� ������ϴ�."), 4),SetCp(FP)})
		CIf(FP,{CV(PlayTime2[i+1],1,AtLeast)},{SetV(ScTimer[i+1],0),RemoveUnit(88, i),SetCp(i),DisplayExtText(StrDesignX("\x04�׽�Ʈ ���� Ư������ ���� ������ �帳�ϴ�. \x07�ٽ��ѹ� �÷������ּż� �����մϴ�.").."\n"..StrDesignX("\x07�⺻���� 6��\x04 ����. \x08���� \x04: \x07�⺻����\x04�� ���� ���� 1ȸ���� �����ϸ� 3�� �� ������ϴ�."), 4),SetCp(FP)})
			TriggerX(FP,{CV(PlayTime2[i+1],1,AtLeast)},{SetV(CreditAddSC[i+1],1),SetVX(iv.TesterFlag[i+1],1,1)},{preserved})
			CMov(FP,CTimeV,PlayTime2[i+1])
			CallTrigger(FP,Call_ConvertTime)
			DoActions(FP,{SetCp(i)})
			DisplayPrint("CP", {"\x13\x0D\x0D\x0D",PName("LocalPlayerID")," \x04���� \x10��Ÿ �׽�Ʈ�� \x04�ΰ��� �÷��� �ð� : \x04",CTimeDD,"�� ",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��"})
			DisplayPrint("CP", {"\x13\x04�� ",PlayTime2[i+1]," �� �̿����� \x17",PlayTime2[i+1]," ũ����\x04 ���޵�"})
			f_LAdd(FP,Credit[i+1],Credit[i+1],{PlayTime2[i+1],0}) -- 
		CIfEnd()
			
		CIfXEnd()
		--CIfOnce(FP, {CV(PStatVer[i+1],4,AtMost)}) --���� 8�ð� ����� �� ����ؼ� ������
		--CDiv(FP, LV5Cool[i+1], 8)
		--CIfEnd()
		
		TriggerX(FP, {CV(iv.RankTitle[i+1],1,AtLeast)}, {SetCp(i),
		DisplayExtText(StrDesignX("\x1F�Ϳ�! \x04������ �����ñ���! \x03@Īȣ 3 \x04��ɾ�� ��Ŀ ���� Īȣ�� ����� �� �ֽ��ϴ�."),4),
		DisplayExtText(StrDesignX("\x1F�Ϳ�! \x04������ �����ñ���! \x03@Īȣ 3 \x04��ɾ�� ��Ŀ ���� Īȣ�� ����� �� �ֽ��ϴ�."),4),
	}, {preserved})--������ �˸�

		
		TriggerX(FP, {CV(PStatVer[i+1],10,AtMost)}, {SetDeaths(i,SetTo,1,50),SetCp(i),
		DisplayExtText(StrDesignX("\x11Īȣ \x04 ��ɾ ���� �߰��Ǿ����ϴ�. ���� : @Īȣ ����"),4),
		DisplayExtText(StrDesignX("\x11Īȣ \x04 ��ɾ ���� �߰��Ǿ����ϴ�. ���� : @Īȣ ����"),4),
		DisplayExtText(StrDesignX("\x11Īȣ \x04 ��ɾ ���� �߰��Ǿ����ϴ�. ���� : @Īȣ ����"),4),
	}, {preserved})--10 �������� ���� Īȣ������
		CMov(FP,PStatVer[i+1],StatVer)--���� ���ο� ������� �ε�Ϸ�� ���ȹ��� �׸� �ʱ�ȭ
		CMov(FP,iv.FStatVer[i+1],StatVer2)--���� ���ο� ������� �ε�Ϸ�� ���ȹ��� �׸� �ʱ�ȭ
			
		DoActions(FP, {SetLoc("Location "..(80+i),"U",Add,64),SetLoc("Location "..(80+i),"D",Add,64)})
		CreateUnitStacked({},1,PersonalUIDArr[i+1],36+i,80+i, i,nil, 1) --���� �ҷ����� ������ �������� ��������
		DoActions(FP, {SetLoc("Location "..(80+i),"U",Subtract,64),SetLoc("Location "..(80+i),"D",Subtract,64)})
		CMov(FP,PUnitPtr[i+1],Nextptrs)
		if Limit == 1 then --�׽�Ʈ ���� ���� �׽������� Īȣ ����
			TriggerX(FP, {}, {SetCp(i),DisplayExtText(StrDesignX("\x07�׽�Ʈ ��\x04������ SCA �ε尡 \x10����\x04�Ǿ����ϴ�! �׽�Ʈ�� �÷��̿� ������ �ּż� �����մϴ�."), 4)}, {preserved})
			TriggerX(FP, {CVX(iv.TesterFlag[i+1],0,2)}, {SetVX(iv.TesterFlag[i+1],2,2),SetV(iv.CreditAddSC[i+1],1),SetCp(i),DisplayExtText(StrDesignX("\x07�׽��� ����\x04�� ���޵Ǿ����ϴ�!!!").."\n"..StrDesignX("���󳻿� : \x04����2 \x1F�׽��� \x04Īȣ(��������), \x17DPC(���ڵ� ����)"), 4)}, {preserved})
		end
	CIfEnd()
	

	CIf(FP,{CV(B_PEXP2[i+1],1,AtLeast)})
	f_LAdd(FP,PEXP[i+1],PEXP[i+1],{B_PEXP2[i+1],0}) --
	CMov(FP, B_PEXP2[i+1], 0)
	CIfEnd({})
	if TestStart == 1 then
		local EXPAcc = CreateWar(FP)
		--f_LAdd(FP, EXPAcc, EXPAcc, "100000000000")
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], EXPAcc)
	end
	
	local LevelUpJump = def_sIndex()
	local LIndex = CreateVar(FP) 
	local PrevLMulW = CreateWar(FP)
	local NextLMulW = CreateWar(FP)
	CIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],LevelLimit-1,AtMost)},{})
	ConvertLArr(FP, LIndex, _Add(PLevel[i+1], 150), 8)--151 ��Ŀ��
	f_LRead(FP, LArrX({EXPArr},LIndex), PrevLMulW, nil, 1)
	CJumpEnd(FP, LevelUpJump)
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],LevelLimit-1,AtMost)},{AddV(PLevel[i+1],1),AddV(CT_PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	ConvertLArr(FP, LIndex, _Add(PLevel[i+1], 150), 8)--151 ��Ŀ��
	f_LRead(FP, LArrX({EXPArr},LIndex), NextLMulW, nil, 1)
	f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], NextLMulW)
	
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
	CIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})

	
	CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],2)},{})--�ε� �Ϸ�� ù ���� Ʈ����
	
	CMov(FP,AddSC[i+1],_Div(PLevel[i+1],1000))
	CMov(FP,ScoutDmg[i+1],_Div(PLevel[i+1],10))
	CMov(FP,SCCool[i+1],_Div(PLevel[i+1],1000))
	TriggerX(FP,CV(AddSC[i+1],5,AtLeast),{SetV(AddSC[i+1],5)},{preserved})
	TriggerX(FP,CV(ScoutDmg[i+1],250,AtLeast),{SetV(ScoutDmg[i+1],250)},{preserved})
	TriggerX(FP,CV(SCCool[i+1],8,AtLeast),{SetV(SCCool[i+1],8)},{preserved})


	
	DoActionsX(FP, {SetV(ScTimer[i+1],0),RemoveUnit(88, i)})--�ε强���� ��īŸ�̸� �ʱ�ȭ
	for k = 0, 5 do
		CreateUnitStacked({CV(AddSC[i+1],k)},k+1, 88, 36+i,15+i, i, nil, 1)--��ī ��������� �ٽ� ����
	end
	CreateUnitStacked({CV(CreditAddSC[i+1],1,AtLeast)},6, 88, 36+i,15+i, i, nil, 1)--ũ���� ��ī�� �����׸� ������ ��ī����

	
	CIfEnd()

	for j,k in pairs(FirstReward) do
		TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetDeaths(i,SetTo,1,13),AddV(B_PEXP[i+1],k[2]),SetCp(i),DisplayExtText(StrDesignX("\x08"..k[1].."�� \x04���� \x07���� \x11�޼� \x04����! : \x1F"..Convert_Number(k[2]).." \x0F�ţأ�"), 4),SetCp(FP)})
	end
	for j,k in pairs(FirstReward2) do
		TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetDeaths(i,SetTo,1,13),AddV(B_PCredit[i+1],k[2]),SetCp(i),DisplayExtText(StrDesignX("\x11"..k[1].."�� \x04���� \x07���� \x11�޼� \x04����! : \x1F"..Convert_Number(k[2]).." \x17�ã�����"), 4),SetCp(FP)})
	end
	for j,k in pairs(FirstReward3) do -- j == 1~4
		local NMask = 256^(j-1)
		CIfOnce(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])})
			CIfX(FP,{CVX(iv.FirstRewardLim[i+1],NMask*(k[5]-1),NMask*255,AtMost)},{AddVX(iv.FirstRewardLim[i+1],NMask*1,NMask*255),SetDeaths(i,SetTo,1,13),AddV(B_PCredit[i+1],k[2]),AddV(iv.B_PFfragItem[i+1],k[3]),SetCp(i),DisplayExtText(StrDesignX(k[4]..k[1].."�� \x04���� \x07���� \x11�޼� \x04����! : \x1F"..Convert_Number(k[2]).." \x17�ã�����"), 4),DisplayExtText(StrDesignX("\x08"..k[1].."�� \x04���� \x07���� \x11�޼� \x04����! : \x1F"..Convert_Number(k[3]).." \x02 ���� ����"), 4),SetCp(FP)})
			CElseX()
				TriggerX(FP,{},{SetCp(i),DisplayExtText(StrDesignX("\x04������ ���̻� "..k[4]..k[1].."�� \x07���� �޼� ����\x04�� ���� �� �����. ���� �ٽ� �������ּ���!"), 4),SetCp(FP)},{preserved})
			CIfXEnd()
			local TempV = CreateVar(FP)
			CMov(FP,TempV,iv.FirstRewardLim[i+1],nil,NMask*255)
			if j>=2 then
				CrShift(FP,TempV,(j-1)*8)
			end
			DisplayPrint(i, {"\x13\x07�� \x04������ "..k[4]..k[1].."�� \x07���� �޼� ���� \x04���� Ƚ�� : \x07",TempV," / \x0F"..k[5].." ȸ \x07��"})
		CIfEnd()
	end

--\x1C45��
--\x1E46��
--\x0247��
--\x1B48��
	CIf(FP,CD(SCA.LoadCheckArr[i+1],2))--�⼮Ʈ���Ŵ� �ε��ؾ� �۵���
	--if TestStart == 1 then
	--	NIfX(FP,{VRange(SCA.MinV,0,59),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),TTOR({_TTNVar(DayCheck[i+1],NotSame,SCA.MinV),_TTNVar(MonthCheck[i+1],NotSame,SCA.MonthV),_TTNVar(YearCheck[i+1],NotSame,SCA.YearV)})},{SetDeaths(i,SetTo,1,13)})
	--		CMov(FP,DayCheck[i+1],SCA.MinV)--��¥�� ������
	--else
	--	NIfX(FP,{VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),TTOR({_TTNVar(DayCheck[i+1],NotSame,SCA.DayV),_TTNVar(MonthCheck[i+1],NotSame,SCA.MonthV),_TTNVar(YearCheck[i+1],NotSame,SCA.YearV)})},{SetDeaths(i,SetTo,1,13)})
	--		CMov(FP,DayCheck[i+1],SCA.DayV)--��¥�� ������
	--end
		NIfX(FP,{VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),TTOR({_TTNVar(DayCheck[i+1],NotSame,SCA.DayV),_TTNVar(MonthCheck[i+1],NotSame,SCA.MonthV),_TTNVar(YearCheck[i+1],NotSame,SCA.YearV)})},{SetDeaths(i,SetTo,1,13)})
			CMov(FP,DayCheck[i+1],SCA.DayV)--��¥�� ������
	CMov(FP,MonthCheck[i+1],SCA.MonthV)--��¥�� ������
	CMov(FP,YearCheck[i+1],SCA.YearV)--��¥�� ������

	
	--CIfX(FP,{CVX(DayCheck2[i+1],27,0xFF,AtMost),CVX(SCA.GlobalVarArr[5],1,1),CD(SCA.GlobalCheck2,1)})--���� 1ȣ �⼮�̺�Ʈ
	--		DoActionsX(FP,{
	--			AddVX(DayCheck2[i+1],1,0xFF),
	--			AddV(B_PCredit[i+1],100000),
	--			AddV(B_PTicket[i+1],100),SetCp(i),DisplayExtText(StrDesignX("���� �⼮ �������� \x04\x17���� �Ǹű� 100��, ũ���� 10��\x04�� ������ϴ�."), 4)})
	--			local TempV = CreateVar(FP)
	--			local TempV2 = CreateVar(FP)
	--			local TempV3 = CreateVar(FP)
	--			CMov(FP,TempV3,_Mod(DayCheck2[i+1],_Mov(0x100)),nil,nil,1)
	--			CMov(FP,TempV,_Mod(TempV3,7),nil,nil,1)
	--			CMov(FP,TempV2,_Div(TempV3,7),nil,nil,1)
	--		CIf(FP,{CV(TempV2,1,AtLeast),CV(TempV2,4,AtMost),CV(TempV,0)})
	--		DoActionsX(FP, {
	--			AddV(B_PCredit[i+1],1000000),
	--			AddV(iv.VaccItem[i+1],5),
	--			SetCp(i),DisplayExtText(StrDesignX("���� �⼮ �������� \x04\x17ũ���� 100��, \x10��ȭ�� ��� 5��\x04�� ������ϴ�."), 4)})
	--		CIfEnd()
	--		DisplayPrint(i, {"\x13\x07�� \x04������� ���� 1 �⼮ �̺�Ʈ �⼮�ϼ� : \x07",TempV3,"�� \x07��"})
	--		TriggerX(FP, {CVX(DayCheck2[i+1],28,0xFF,AtLeast)}, {SetCp(i),DisplayExtText(StrDesignX("��� �⼮ �̺�Ʈ�� �Ϸ� �ϼ̽��ϴ�. \x1F����ϼ̽��ϴ�!"), 4)})
	--CElseIfX({CD(SCA.GlobalCheck2,1),CVX(DayCheck2[i+1],28,0xFF,AtLeast)},{SetCp(i),DisplayExtText(StrDesignX("�̹� ��� ���� 1ȣ �⼮ �̺�Ʈ�� �Ϸ� �ϼ̽��ϴ�."), 4)})
	--CIfXEnd()
	local DailyJump = def_sIndex()
	NIfX(FP,{CVX(DayCheck2[i+1],27*0x100,0xFF00,AtMost),CVX(SCA.GlobalVarArr[5],2,2),CD(SCA.GlobalCheck2,1)})--���� 2ȣ �⼮�̺�Ʈ
			NJumpEnd(FP, DailyJump)
			DoActionsX(FP,{
				AddVX(DayCheck2[i+1],1*0x100,0xFF00),
				AddV(B_PCredit[i+1],500000),
				AddV(iv.B_PFfragItem[i+1],5),
				SetCp(i),DisplayExtText(StrDesignX("���� �⼮ �������� \x04\x17ũ���� 50��, \x02??? \x04�� 5�� ������ϴ�."), 4)})
				local TempV = CreateVar(FP)
				local TempV2 = CreateVar(FP)
				local TempV3 = CreateVar(FP)
				CMov(FP,TempV3,_Mod(_rShift(DayCheck2[i+1], 8),_Mov(0x100)),nil,nil,1)
				CMov(FP,TempV,_Mod(TempV3,7),nil,nil,1)
				CMov(FP,TempV2,_Div(TempV3,7),nil,nil,1)
			CIf(FP,{CV(TempV2,1,AtLeast),CV(TempV2,4,AtMost),CV(TempV,0)})
			DoActionsX(FP, {
				AddV(iv.B_PFfragItem[i+1],50),
				SetCp(i),DisplayExtText(StrDesignX("���� �⼮ �������� \x02??? \x04�� 50�� ������ϴ�."), 4)})
			CIfEnd()
			CallTrigger(FP,Call_DailyPrint)
			CMov(FP,DV,TempV3)
			TriggerX(FP, {CVX(DayCheck2[i+1],28*0x100,0xFF00,AtLeast)}, {SetCp(i),DisplayExtText(StrDesignX("��� �⼮ �̺�Ʈ�� �Ϸ� �ϼ̽��ϴ�. \x1F����ϼ̽��ϴ�!"), 4)})
	NElseIfX({CD(SCA.GlobalCheck2,1),CVX(DayCheck2[i+1],28*0x100,0xFF00,AtLeast)},{SetCp(i),DisplayExtText(StrDesignX("�̹� ��� ���� 2ȣ �⼮ �̺�Ʈ�� �Ϸ� �ϼ̽��ϴ�."), 4)})
	NIfXEnd()
	
	DoActionsX(FP,{
		SetCp(i),DisplayExtText(StrDesignX("\x1C45��\x04~\x1B48�� \x07���� �޼� ���� \x08Ƚ������\x04�� �ʱ�ȭ �Ǿ����ϴ�."), 4),SetV(iv.FirstRewardLim[i+1],0)})

	NElseIfX({VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),})
		NJump(FP, DailyJump, {CVX(DayCheck2[i+1],0*0x100,0xFF00),CVX(SCA.GlobalVarArr[5],2,2),CD(SCA.GlobalCheck2,1)}) -- ����2 �⼮ 0���� ��� ������ �⼮üũ��Ŵ
	
	NIfXEnd()
	CIfEnd()

	
	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),CV(CurMission[i+1],#MissionDataTextArr-1,AtMost),})
			CallTriggerX(FP, Call_Print13[i+1],{CV(DPErT[i+1],0)})
		for j,k in pairs(MissionPDataArr[i+1]) do
			Trigger2X(FP, {CV(CurMission[i+1],j-1),CV(DPErT[i+1],0),LocalPlayerID(i)},  {print_utf8(12,0,MissionDataTextArr[j][1])}, {preserved})
			Trigger2X(FP, {CV(CurMission[i+1],j-1),CV(DPErT[i+1],0)},  {SetV(DPErT[i+1],15)}, {preserved})
				local RewardAct = {}
				local MText = "���� : "
				for l,m in pairs(k[2]) do
					if m>= 1 then
						if l == 1 then
							MText = MText.."\x17"..m.." Credit "
							table.insert(RewardAct,AddV(B_PCredit[i+1],m))
						end
						if l == 2 then
							MText = MText.."\x19"..m.." ���� �Ǹű� "
							table.insert(RewardAct,AddV(SellTicket[i+1],m))
						end
						if l == 3 then
							MText = MText.."\x10"..m.." ��ȭ�� ��� "
							table.insert(RewardAct,AddV(iv.VaccItem[i+1],m))
						end
						if l == 4 then
							MText = MText.."\x1F"..m.." EXP "
							table.insert(RewardAct,AddV(B_PEXP[i+1],m))
						end
						if l == 5 then
							MText = MText.."\x1F"..m.." Ȯ�� ��ȭ�� "
							table.insert(RewardAct,AddV(PETicket[i+1],m))
						end
					end
				end
				if j>=3 then
					Trigger2X(FP,{CV(CurMission[i+1],j-1),k[1]},{RewardAct,AddV(CurMission[i+1],1),SetCp(i),DisplayExtText(MissionDataTextArr[j][2], 4),DisplayExtText(StrDesignX(MText), 4),SetDeaths(i,SetTo,1,13)})
				else
					Trigger2X(FP,{CV(CurMission[i+1],j-1),k[1]},{RewardAct,AddV(CurMission[i+1],1),SetCp(i),DisplayExtText(MissionDataTextArr[j][2], 4),DisplayExtText(StrDesignX(MText), 4)})
				end
					end
	CIfEnd()

	CMov(FP,MissionV[i+1],0)



	local CTSwitch = CreateCcode()
	


	
--	CIf(FP, {CD(SCA.LoadSlot1[i+1],1,AtLeast)})
--	CIf(FP, {CD(SCA.LoadSlot1[i+1],1),SCA.Available(i)}, {SCA.Reset(i),SetCD(SCA.LoadSlot1[i+1],2),SetDeaths(i,SetTo,11,2)})
--	SCA_DataReset(i)
--	CIfEnd()
--	CIf(FP,{SCA.LoadCmp(i),CD(SCA.LoadSlot1[i+1],2)})
--		SCA_DataLoad(i, SlotPtr[i+1], SCA.PLevel)--

--	CIfEnd()--

--	CIfEnd()


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

	--CAdd(FP,CTStatP2,_Mul(Stat_BossSTic[i+1],_Mov(Cost_Stat_BossSTic)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer4[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer4)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_BreakShield[i+1],_Mov(1000)),_Mov(Cost_Stat_BreakShield)))
	--CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(Cost_Stat_Upgrade)))
	--CAdd(FP,CTStatP2,_Mul(Stat_BossLVUP[i+1],_Mov(Cost_Stat_BossLVUP)))
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
	CTrigger(FP, {CV(BanFlag8[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag7[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag6[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag5[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayExtText("S\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �������� �� �����Ǿ� ����.)\x07 ��",4);
		DisplayExtText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵�, ���� �̳׶�, ���� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})

	
	CIfEnd()


	
	if Limit == 1 then 
		CIf(FP,{CV(iv.MapMakerFlag[i+1]),Deaths(i,AtLeast,1,553)})
		CreateUnitStacked({}, 12, LevelUnitArr[44][2], 36+i, nil, i)
		--f_LAdd(FP,PEXP[i+1],PEXP[i+1],"500000000")
		CIfEnd()
	end

	


	--TriggerX(FP, {MSQC_KeyInput(i, "F12"),Deaths(i,Exactly,0,3)}, {SetDeaths(i,SetTo,0,553),SetDeaths(i,SetTo,1,3),SetCp(i),DisplayExtText(StrDesign("\x04SCA �ý��� ���带 \x071��\x04���� �����Ͽ����ϴ�."),4),PlayWAV("staredit\\wav\\conn.ogg"),PlayWAV("staredit\\wav\\conn.ogg")},{preserved})
	--TriggerX(FP, {MSQC_KeyInput(i, "F12"),Deaths(i,Exactly,1,3)}, {SetDeaths(i,SetTo,0,553),SetDeaths(i,SetTo,0,3),SetCp(i),DisplayExtText(StrDesign("\x04SCA �ý��� ���带 \x07�⺻\x04���� �����Ͽ����ϴ�."),4),PlayWAV("sound\\Misc\\TRescue.wav"),PlayWAV("sound\\Misc\\TRescue.wav")},{preserved})
	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--�⺻��������
	
	
	TriggerX(FP, {Command(i,AtLeast,1,88),CV(ScTimer[i+1],4320)}, {RemoveUnit(88,i)},{preserved}) -- 3�е� ������� �⺻����
	TriggerX(FP, {CV(ScTimer[i+1],86400),CV(ResetStat[i+1],0)}, {AddV(ResetStat[i+1],1)}) -- 1�ð��� �����ʱ�ȭ ��Ȱ��ȭ
	TriggerX(FP, {CV(ScTimer[i+1],86400),CV(ResetStat2[i+1],0)}, {AddV(ResetStat2[i+1],1)}) -- 1�ð��� �����ʱ�ȭ ��Ȱ��ȭ
	TriggerX(FP, {Command(i,AtLeast,1,LevelUnitArr[41][2]),CV(ResetStat[i+1],0)}, {AddV(ResetStat[i+1],1)}) -- 41�������� �����ʱ�ȭ ��Ȱ��ȭ
	TriggerX(FP, {Command(i,AtLeast,1,LevelUnitArr[41][2]),CV(ResetStat2[i+1],0)}, {AddV(ResetStat2[i+1],1)}) -- 41�������� �����ʱ�ȭ ��Ȱ��ȭ
	TriggerX(FP, {CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men"),}, {SetMemX(Arr(AutoEnchArr,((2-1)*7)+i), SetTo, 0),SetCp(i),DisplayExtText(StrDesignX("\x04��� \x08��ȭ�� ����\x04�Ͻ� ����̳׿�... \x0F2�� ���� 1��\x04�� ���� �������� �����մϴ�."), 4),SetCp(FP)}) -- �⺻���� ������� �����Ұ�� ��ȸ��
	CreateUnitStacked({CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men")}, 1, LevelUnitArr[2][2], 50+i,36+i, i, nil,1)

	local NBTemp = CreateVar(FP)
	local TempSCCool = CreateVar(FP)
	NBagLoop(FP,NBagArr[i+1],{NBTemp})
	CMov(FP,0x6509B0,NBTemp,25)

	CIfX(FP,{DeathsX(CurrentPlayer, Exactly, 88, 0, 0xFF)})
		ClShift(FP, TempSCCool, _Sub(_Mov(9),SCCool[i+1]), 8)
	
		CMov(FP,0x6509B0,NBTemp,21)
		DoActions(FP,{
			SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00)})

		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,103*256,0,0xFF00)})
		CDoActions(FP, {
			TSetDeathsX(CurrentPlayer,SetTo,TempSCCool,0,0xFF00),
		})
		CIfEnd()
		CMov(FP,0x6509B0,FP)


	CElseIfX({DeathsX(CurrentPlayer, Exactly, 79, 0, 0xFF)})
	
	CMov(FP,0x6509B0,NBTemp,21)
		DoActions(FP,{
			SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFF),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),})--SetCp(i),DisplayText("�νĴ�", 4)
			

	CIfXEnd()

	
	CMov(FP,0x6509B0,NBTemp,19)
	NIf(FP,{DeathsX(CurrentPlayer, Exactly, 0, 0, 0xFF00)})
	NRemove(FP,NBagArr[i+1])
	NIfEnd()

	NBagLoopEnd()
	--iv.PUnitLevel


	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[15][2])},{SetCp(i),DisplayExtText(StrDesignX("\x0815�� \x04������ ȹ���Ͽ����ϴ�. \x0815�� \x04���ֺ��ʹ� \x17�Ǹ�\x04�� ���� \x1B����ġ\x04�� ȹ���� �� �ֽ��ϴ�.")),SetCp(FP)})
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[26][2])},{SetCp(i),DisplayExtText(StrDesignX("\x0F26�� \x04������ ȹ���Ͽ����ϴ�. \x0F26�� \x04���ֺ��ʹ� \x08����\x04�� ������ �� �ֽ��ϴ�.")),DisplayExtText(StrDesignX("\x08���� \x1C���� \x07���ѽð�\x04�� ������, \x08�ִ� 4�� \x04���� �����մϴ�.")),DisplayExtText(StrDesignX("\x0F26�� \x04���ֺ��ʹ� \x19���� �Ǹű�\x04�� �־�� �ǸŰ� �����մϴ�.")),SetCp(FP)})

	
	CIfChkVar(iv.FXPer44[i+1])
	CMov(FP,iv.CXPer44[i+1],_Mul(iv.FXPer44[i+1],_Mov(100)))
	CIfEnd()
	CIfChkVar(iv.FXPer45[i+1])
	CMov(FP,iv.CXPer45[i+1],_Mul(iv.FXPer45[i+1],_Mov(100)))
	CIfEnd()
	CIfChkVar(iv.FXPer46[i+1])
	CMov(FP,iv.CXPer46[i+1],_Mul(iv.FXPer46[i+1],_Mov(100)))
	CIfEnd()
	CIfChkVar(iv.FXPer47[i+1])
	CMov(FP,iv.CXPer47[i+1],_Mul(iv.FXPer47[i+1],_Mov(100)))
	CIfEnd()
	CIfChkVar(iv.FMEPer[i+1])
	CMov(FP,iv.CMEPer[i+1],_Mul(iv.FMEPer[i+1],_Mov(10)))
	CIfEnd()
	CIfChkVar(iv.FBrSh[i+1])
	CMov(FP,iv.CBrSh[i+1],_Mul(iv.FBrSh[i+1],_Mov(100)))
	CIfEnd()
	
	local CCVar = CreateVar2(FP,nil,nil,0xFFFFFFFF)
	local CCVar2 = CreateVar2(FP,nil,nil,0xFFFFFFFF)
	local CCVar3 = CreateVar2(FP,nil,nil,0xFFFFFFFF)

	
	CIf(FP,{TTOR({TTNVar(iv.FIncm[i+1],NotSame,CCVar),TTNVar(Stat_LV3Incm[i+1],NotSame,CCVar2),TTNVar(iv.CSX_LV3IncmData[i+1],NotSame,CCVar3)})})
	CMov(FP,CCVar,iv.FIncm[i+1])
	CMov(FP,CCVar2,Stat_LV3Incm[i+1])
	CMov(FP,CCVar3,iv.CSX_LV3IncmData[i+1])
	f_LMov(FP,iv.TempIncm[i+1],_LDiv(_LMul({_Mul(_Add(Stat_LV3Incm[i+1],100),_Add(iv.FIncm[i+1],100)),0}, {iv.CSX_LV3IncmData[i+1],0}),"10000"))
	CIfEnd()
	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{TempO[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas,TempG[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV3[i+1],"100000000",iv.TempIncm[i+1],{TempX[i+1]},Money[i+1])
--	CIf(FP,{TTNWar(Money[i+1], AtLeast, "15000000000000000000")})--1500���̻��ϰ��
--	f_LSub(FP, Money[i+1], Money[i+1], "10000000000000000000")
--	CAdd(FP,Money2[i+1],1)
--	CIfEnd()
	
	CIf(FP,{CV(Money2[i+1],1,AtLeast)})--800�������϶� 2��°������ 1�̻��ϰ��
	CIf(FP,{TTNWar(Money[i+1], AtMost, "8000000000000000000")})
	f_LAdd(FP, Money[i+1], Money[i+1], "10000000000000000000")
	CSub(FP,Money2[i+1],1)
	CIfEnd()
	CIfEnd()


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
	

TriggerX(FP, {CV(TempO[i+1],20000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayExtText("O\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	DisplayExtText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

TriggerX(FP, {CV(TempG[i+1],20000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayExtText("G\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	DisplayExtText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

TriggerX(FP, {CV(TempX[i+1],20000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayExtText("X\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	DisplayExtText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})


	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)
	Debug_DPSBuilding(DpsLV3[i+1],173,137+i)
	PBossResetArr = DPSBuilding(i,PBossPtr[i+1],"X",nil,{PBossDPS[i+1]},nil)--

	for j,k in pairs(PBossArr) do
		local LocID = 129+i
		local AddCond = nil
		if j >=6 then LocID = 153+i AddCond = {CV(BossLV,5,AtLeast)} end--CV(LV5Cool[i+1],60*60,AtMost)CD(SCA.LoadCheckArr[i+1],2),CD(BossLV6Private[i+1],0),
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
	local TempICM = CreateVar(FP)
	CSub(FP,TempICM,IncomeMax[i+1],1)
	TriggerX(FP, {Bring(i, Exactly, 1, PersonalUIDArr[i+1], 65+i)}, {SubV(Income[i+1], 1),AddV(TempICM,1)}, {preserved})
	
	CIfX(FP,{TBring(i, AtMost, TempICM, "Men", 65+i),Bring(i,AtLeast,1,"Men",15+i)})
	CTrigger(FP,{},{MoveUnit(1, "Men", i, 15+i, 22+i),MoveUnit(1, "Factories", i, 22+i, 57+i),
	MoveUnit(1, LevelUnitArr[41][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[42][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[43][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[44][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[45][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[46][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[47][2], i, 22+i, 144+i),
	MoveUnit(1, LevelUnitArr[48][2], i, 22+i, 144+i),
},1)--����� ����
	TriggerX(FP,{CV(CS_DPSLV[i+1],1,AtLeast)},{MoveUnit(1,PersonalUIDArr[i+1],i,22+i,57+i)},{preserved})
	CElseX({MoveUnit(1,PersonalUIDArr[i+1],i,15+i,22+i)})
	TriggerX(FP,{CV(CS_DPSLV[i+1],1,AtLeast)},{MoveUnit(1,PersonalUIDArr[i+1],i,22+i,57+i)},{preserved})
	CIfXEnd()


	TriggerX(FP,{CV(ScTimer[i+1],4320,AtMost)},{MoveUnit(1, 88, i, 15+i, 22+i)},{preserved})



	TriggerX(FP, {Bring(i,AtLeast,1,"Men",29+i)}, {MoveUnit(1, "Men", i, 29+i, 80+i)}, {preserved})--����� ����

	TriggerX(FP, {Bring(i, AtMost, 3, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--������ ����
	TriggerX(FP, {}, {MoveUnit(1, "Factories", i, 111, 80+i)}, {preserved})--������ ����

	
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 5, "Men", 119+i)}, {MoveUnit(1, "Men", i, 119+i, 22+i)}, {preserved})--���κ����� ��������
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 1, 88, 119+i)}, {MoveUnit(1, 88, i, 119+i, 22+i)}, {preserved})--���κ����� ��������

	--��ȭ������ ���� �����ϱ�(ĵ����������)
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], k[1]-1), AtLeast, 1)}, 1, k[2], 50+i,80+i, i, {SetCVAar(VArr(GetUnitVArr[i+1], k[1]-1), Subtract, 1)})
	end
	CreateUnitStacked({Memory(0x628438,AtLeast,1),CV(iv.E40[i+1],1,AtLeast)}, 1, LevelUnitArr[40][2], 80+i,nil, i, {SubV(iv.E40[i+1], 1)})
	CreateUnitStacked({Memory(0x628438,AtLeast,1),CV(iv.E41[i+1],1,AtLeast)}, 1, LevelUnitArr[41][2], 80+i,nil, i, {SubV(iv.E41[i+1], 1)})
	CreateUnitStacked({Memory(0x628438,AtLeast,1),CV(iv.E42[i+1],1,AtLeast)}, 1, LevelUnitArr[42][2], 80+i,nil, i, {SubV(iv.E42[i+1], 1)})
	CreateUnitStacked({Memory(0x628438,AtLeast,1),CV(iv.E43[i+1],1,AtLeast)}, 1, LevelUnitArr[43][2], 80+i,nil, i, {SubV(iv.E43[i+1], 1)})
	CreateUnitStacked({Memory(0x628438,AtLeast,1),CV(iv.E44[i+1],1,AtLeast)}, 1, LevelUnitArr[44][2], 80+i,nil, i, {SubV(iv.E44[i+1], 1)})

	CIf(FP,{TTNVar(PUnitCurLevel[i+1],NotSame,PUnitClass[i+1])})
	CMov(FP,PUnitClass[i+1],0)


	TriggerX(FP,{CV(CS_Cooldown[i+1],CS_CooldownLimit,AtLeast)},{SetV(CS_Cooldown[i+1],CS_CooldownLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_Atk[i+1],CS_AtkLimit,AtLeast)},{SetV(CS_Atk[i+1],CS_AtkLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_EXP[i+1],CS_EXPLimit,AtLeast)},{SetV(CS_EXP[i+1],CS_EXPLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_TotalEPer[i+1],CS_TotalEPerLimit,AtLeast)},{SetV(CS_TotalEPer[i+1],CS_TotalEPerLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_TotalEper4[i+1],CS_TotalEper4Limit,AtLeast)},{SetV(CS_TotalEper4[i+1],CS_TotalEper4Limit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_DPSLV[i+1],CS_DPSLVLimit,AtLeast)},{SetV(CS_DPSLV[i+1],CS_DPSLVLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(CS_BreakShield[i+1],CS_BreakShieldLimit,AtLeast)},{SetV(CS_BreakShield[i+1],CS_BreakShieldLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����
	TriggerX(FP,{CV(iv.CSX_LV3Incm[i+1],CSX_LV3IncmLimit,AtLeast)},{SetV(iv.CSX_LV3Incm[i+1],CSX_LV3IncmLimit)},{preserved})--��� �����͸� ����Ʈ��ġ��ŭ���� ����

	CMov(FP,PUnitCurLevel[i+1],PUnitClass[i+1])
	CAdd(FP,PUnitClass[i+1],CS_Cooldown[i+1])
	CAdd(FP,PUnitClass[i+1],CS_Atk[i+1])
	CAdd(FP,PUnitClass[i+1],iv.CSX_LV3Incm[i+1])
	CAdd(FP,PUnitClass[i+1],CS_EXP[i+1])
	CAdd(FP,PUnitClass[i+1],CS_TotalEPer[i+1])
	CAdd(FP,PUnitClass[i+1],CS_TotalEper4[i+1])
	CAdd(FP,PUnitClass[i+1],CS_DPSLV[i+1])
	CAdd(FP,PUnitClass[i+1],CS_BreakShield[i+1])
	TriggerX(FP,{CV(PUnitClass[i+1],CS_CooldownLimit+CS_AtkLimit+CS_EXPLimit+CS_TotalEPerLimit+CS_TotalEper4Limit+CS_DPSLVLimit+CS_BreakShieldLimit,AtLeast)},{SetV(PUnitClass[i+1],CS_CooldownLimit+CS_AtkLimit+CS_EXPLimit+CS_TotalEPerLimit+CS_TotalEper4Limit+CS_DPSLVLimit+CS_BreakShieldLimit)},{preserved})



	local TempV = CreateVar(FP)
	CMov(FP,TempV,CS_Atk[i+1])
	TriggerX(FP,{CV(TempV,10,AtLeast)},{SetV(TempV,10)},{preserved})
	CDoActions(FP,{TSetMemoryW(0x656EB0, PersonalWIDArr[i+1], SetTo, _Add(_Mul(TempV,3250),100))})
	CIf(FP,CV(CS_Atk[i+1],11,AtLeast))
	CDoActions(FP,{TSetMemoryB(0x58F32C, (i*15)+11, SetTo, _Sub(CS_Atk[i+1],10))})
	CIfEnd()
	
	CMov(FP,CurPUnitCool[i+1],_SHRead(ArrX(PUnitCoolArr,CS_Cooldown[i+1])))
	f_Mul(FP,CS_EXPData[i+1],CS_EXP[i+1],2)
	f_Mul(FP,CS_TEPerData[i+1],CS_TotalEPer[i+1],250)
	f_Mul(FP,CS_TEPer4Data[i+1],CS_TotalEper4[i+1],500)
	f_Mul(FP,CS_BreakShieldData[i+1],CS_BreakShield[i+1],100)
	f_Mul(FP,iv.CSX_LV3IncmData[i+1],_Add(iv.CSX_LV3Incm[i+1],1),100)
	
	
	--
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],100)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,2)},1)
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],99,AtMost)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,1)},1)
	CIfEnd()

	--TriggerX(FP,{CV(iv.PSaveChk[i+1],1),SCA.SaveCmp(i),CV(EnchCool[i+1],0)},{SetV(iv.PSaveChk[i+1],0),SetCp(i),DisplayExtText(StrDesignX("\x03SYSTEM \x04: ���� �ٽ� ��ȭ�� ������ �� �ֽ��ϴ�."), 4)},{preserved})
	CallTrigger(FP,Call_BtnInit,{})

	


	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),CV(RSArr[1][i+1],0)})
		for j = 1,9 do--������ ����
			CMov(FP,RSArr[j][i+1],RSArr[j+1][i+1])
		end
		f_Rand(FP,RSArr[10][i+1])--������ �����
		
		for j,k in pairs(RSArr) do -- ���� 0�ΰ� �˻�
			CTrigger(FP, {CV(k[i+1],0)}, {SetV(k[i+1],_Rand())}, 1)
		end
	CIfEnd()
	local AutoEnable = {}
	for j, k in pairs(LevelUnitArr) do
		table.insert(AutoEnable, SetCD(AutoEnchArr2[j][i+1],1))
		Trigger2X(FP, {Command(i,AtLeast,1,k[2])}, AutoEnable)
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
	if SpeedTestMode == 1 then
		local spt ={}
		for j = 1, 39 do
			table.insert(spt,SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 1))
		end
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

	local KeyTog = CreateCcode()
	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1]),SetCD(KeyTog,0)})--Ű�νĺ� ����
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"O"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"U"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],256)},{preserved})
	local ClickCD = CreateCcode()
	local ClickCD2 = CreateCcode()
	CIf(FP,{CV(InterfaceNum[i+1],256,AtLeast),CV(InterfaceNum[i+1],512,AtMost)},{SetCD(failCcode,0),
	SetCD(CntCArr[1],0),
	SetCD(CntCArr[2],0),
	SetCD(CntCArr[3],0),
	SetCD(CntCArr[4],0),
	SetCD(CntCArr[5],0),
	SetCD(CntCArr[6],0),
	SetCD(CntCArr[7],0),
	SetCD(CntCArr[8],0),})
	for j = 1, 4 do
		TriggerX(FP, {Deaths(i,Exactly,0x30000+j,20)}, {SetCD(CntCArr[j],1)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30010+j,20)}, {SetCD(CntCArr[j],10)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30020+j,20)}, {SetCD(CntCArr[j],100)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30100+j,20)}, {SetCD(CntCArr[j+4],1)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30110+j,20)}, {SetCD(CntCArr[j+4],10)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30120+j,20)}, {SetCD(CntCArr[j+4],100)}, {preserved})
	end
	CallTrigger(FP, Call_FfragShop)
	if Limit == 1 then
		CallTriggerX(FP,Call_Print13[i+1],{MSQC_KeyInput(i, "F12")},nil,1)
		TriggerX(FP,{CD(SCA.LoadCheckArr[i+1],2),MSQC_KeyInput(i, "F12")},{SetV(DPErT[i+1],24*10),AddV(iv.B_PFfragItem[i+1],100000),print_utf8(12,0,StrDesign("\x03TESTMODE OP \x04: \x02���� ���� \x0410���� ���� �Ϸ�.\x08(����X)"))})
	end



	CIf(FP,CD(failCcode,1,AtLeast),{SetV(DPErT[i+1],24*10)})
		CallTrigger(FP,Call_Print13[i+1])
		TriggerX(FP, {LocalPlayerID(i),CD(failCcode,1)},{print_utf8(12,0,StrDesign("\x08ERROR \x04: \x1E���� ����\x04�� �����մϴ�.")),SetCD(failCcode,0)} ,{preserved})
		TriggerX(FP, {LocalPlayerID(i),CD(failCcode,2)},{print_utf8(12,0,StrDesign("\x08ERROR \x04: \x04���̻� ��ȭ�� �� �����ϴ�.")),SetCD(failCcode,0)} ,{preserved})
	CIfEnd()

	CIf(FP, Deaths(i, Exactly, 1, 507),{SetV(DPErT[i+1],24*10)})
		CIfX(FP,{CV(ResetStat2[i+1],1,AtLeast)})
		CallTrigger(FP,Call_Print13[i+1])
		TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x19���� �ʱ�ȭ\x04�� ����� �� �����ϴ�.")) ,{preserved})
		CElseIfX({TTNWar(Credit[i+1], AtLeast, "100000")})
			f_LSub(FP, Credit[i+1], Credit[i+1], "100000")
			DoActionsX(FP, {
				SetV(iv.FXPer44[i+1],0),
				SetV(iv.FXPer45[i+1],0),
				SetV(iv.FXPer46[i+1],0),
				SetV(iv.FXPer47[i+1],0),
				SetV(iv.FMEPer[i+1],0),
				SetV(iv.FBrSh[i+1],0),
				SetV(iv.FIncm[i+1],0),
				SetV(iv.FSEXP[i+1],0),
				SetNWar(iv.FfragItemUsed[i+1],SetTo,"0"),
				SetV(ResetStat2[i+1],1),
			})
			TriggerX(FP, {LocalPlayerID(i)}, {SetV(Time,(300000)-5000),SetCD(SaveRemind,1)}, {preserved})
			CallTrigger(FP,Call_Print13[i+1])
			TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x19���� �ʱ�ȭ\x04 �Ϸ�. \x07��� �� �ڵ�����˴ϴ�. \x17U Ű\x04�� ���� \x19����\x04�� �缳�����ּ���.")) ,{preserved})

		CElseX()
			CallTrigger(FP,Call_Print13[i+1])
			TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�.")) ,{preserved})
		CIfXEnd()
	CIfEnd()


	CIfEnd()
	CIf(FP,{CV(InterfaceNum[i+1],1,AtLeast),CV(InterfaceNum[i+1],0xFF,AtMost)},{})
		for j = 0, 5 do
			TriggerX(FP, {Deaths(i,Exactly,0x10100+j+1,20)}, {SetCD(ClickCD, j+1),SetCD(ClickCD2, 1001)}, {preserved})
			TriggerX(FP, {CD(ClickCD, j+1)}, {SetDeaths(i,SetTo,1,496+j)}, {preserved})
		end
		for j = 1, 8 do
			TriggerX(FP, {Deaths(i,Exactly,0x10000+j,20)}, {SetCD(ClickCD, 0),SetDeaths(i,SetTo,1,495+j)}, {preserved})
		end
		TriggerX(FP, {Deaths(i,AtLeast,1,502)}, {SetCD(ClickCD, 0)}, {preserved})
		TriggerX(FP, {Deaths(i,AtLeast,1,503)}, {SetCD(ClickCD, 0)}, {preserved})
		TriggerX(FP, {Deaths(i,AtLeast,1,494)}, {SetCD(ClickCD, 0)}, {preserved})
		CIf(FP, Deaths(i, Exactly, 1, 504),{SetV(DPErT[i+1],24*10)})
			
			CIfX(FP,{CV(ResetStat[i+1],1,AtLeast)})
				CallTrigger(FP,Call_Print13[i+1])
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x1F���� �ʱ�ȭ\x04�� ����� �� �����ϴ�.")) ,{preserved})

			--CElseIfX({TTNWar(Credit[i+1], AtLeast, _LMov({_ReadF(ArrX(SRTable, ResetStat[i+1])),0}))})
				--f_LSub(FP, Credit[i+1], Credit[i+1], _LMov({_ReadF(ArrX(SRTable, ResetStat[i+1])),0}))
			CElseIfX({TTNWar(Credit[i+1], AtLeast, "5000")})
				f_LSub(FP, Credit[i+1], Credit[i+1], "5000")
				DoActionsX(FP, {
					
					SetV(ResetStat[i+1],1),
					SetV(StatP[i+1],0),
					SetV(Stat_BossSTic[i+1],0),
					SetV(Stat_TotalEPer[i+1],0),
					SetV(Stat_TotalEPer2[i+1],0),
					SetV(Stat_TotalEPer3[i+1],0),
					SetV(Stat_Upgrade[i+1],0),
					SetV(Stat_BossLVUP[i+1],0),
					SetV(Stat_TotalEPer4[i+1],0),
					SetV(Stat_TotalEPer4X[i+1],0),
					SetV(Stat_BreakShield[i+1],0),
					SetV(Stat_BreakShield2[i+1],0),
					SetV(Stat_TotalEPerEx[i+1],0),
					SetV(Stat_TotalEPerEx2[i+1],0),
					SetV(Stat_TotalEPerEx3[i+1],0),
					SetV(Stat_LV3Incm[i+1],0),
					SetV(Stat_BossSFrg[i+1],0),
					SetV(Stat_XEPer44[i+1],0),
					SetV(Stat_XEPer45[i+1],0),
					SetV(Stat_XEPer46[i+1],0),
					SetV(Stat_XEPer47[i+1],0),
				})
				TriggerX(FP, {LocalPlayerID(i)}, {SetV(Time,(300000)-5000),SetCD(SaveRemind,1)}, {preserved})
				CMov(FP, StatP[i+1], _Mul(PLevel[i+1], 5))
				CallTrigger(FP,Call_Print13[i+1])
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x1F���� �ʱ�ȭ\x04 �Ϸ�. \x07��� �� �ڵ�����˴ϴ�. \x17O Ű\x04�� ���� \x07�ɷ�ġ\x04�� �������ּ���.")) ,{preserved})

			CElseX()
				CallTrigger(FP,Call_Print13[i+1])
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�.")) ,{preserved})
			CIfXEnd()
		CIfEnd()
		local ClickCDWhile = def_sIndex()
		NJumpEnd(FP, ClickCDWhile)
		CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetV(DPErT[i+1],24)})

			KeyFunc(i,"1",{
				{{CV(StatP[i+1],Cost_Stat_BossSTic,AtLeast),CV(Stat_BossSTic[i+1],9,AtMost)},{SubV(StatP[i+1],Cost_Stat_BossSTic),AddV(Stat_BossSTic[i+1],1)},StrDesign("\x08��Ƽ ���� \x1FLV.5 \x04óġ ���� \x19�Ǹű�\x04�� �����Ͽ����ϴ�.")},
				{{CV(Stat_BossSTic[i+1],10,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x04óġ ���� \x19�Ǹű�\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_BossSTic-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			})
		--	if TestStart == 1 then
		--		KeyFunc(i,"2",{
		--			{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],89,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
		--			{{CV(Stat_Upgrade[i+1],90,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x08������\x04�� �ø� �� �����ϴ�.")},
		--			{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		--		})
		--	else
			KeyFunc(i,"2",{
				{{CV(StatP[i+1],Cost_Stat_BossLVUP,AtLeast),CV(Stat_BossLVUP[i+1],4,AtMost)},{SubV(StatP[i+1],Cost_Stat_BossLVUP),AddV(Stat_BossLVUP[i+1],1)},StrDesign("\x08��Ƽ ���� \x1FLV.5 \x04óġ ���� \x1F����\x04�� �����Ͽ����ϴ�.")},
				{{CV(Stat_BossLVUP[i+1],5,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x04óġ ���� \x1F����\x04�� �ø� �� �����ϴ�.")},
				{{CV(StatP[i+1],Cost_Stat_BossLVUP-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
			})
		--	end
			KeyFunc(i,"3",{
				{{CV(StatP[i+1],Cost_Stat_Upgrade,AtLeast),CV(Stat_Upgrade[i+1],49,AtMost)},{SubV(StatP[i+1],Cost_Stat_Upgrade),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
				{{CV(Stat_Upgrade[i+1],50,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻�  \x07���� \x08������\x04�� �ø� �� �����ϴ�.")},
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
		CElseIfX({CV(InterfaceNum[i+1],2)},{SetV(DPErT[i+1],24)}) -- 2�� ����������
		KeyFunc(i,"1",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4,AtLeast),CV(Stat_TotalEPer4[i+1],9999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer4),AddV(Stat_TotalEPer4[i+1],100)},StrDesign("\x08Ư�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPer4[i+1],10000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x08Ư�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"2",{
			{{CV(StatP[i+1],Cost_Stat_BreakShield,AtLeast),CV(Stat_BreakShield[i+1],29999,AtMost)},{SubV(StatP[i+1],Cost_Stat_BreakShield),AddV(Stat_BreakShield[i+1],100)},StrDesign("\x08Ư�� \x1F�ı� ����Ȯ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_BreakShield[i+1],30000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x1F�Ǳ� \x08����Ȯ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_BreakShield-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"3",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx,AtLeast),CV(Stat_TotalEPerEx[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx),AddV(Stat_TotalEPerEx[i+1],100)},StrDesign("\x07�� \x08��ȭ Ȯ��\x04�� \x0F0.1%p �����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPerEx[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07�� \x08��ȭ Ȯ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"4",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx2,AtLeast),CV(Stat_TotalEPerEx2[i+1],1999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx2),AddV(Stat_TotalEPerEx2[i+1],100)},StrDesign("\x07+2�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPerEx2[i+1],2000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x07+2�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx2-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"5",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx3,AtLeast),CV(Stat_TotalEPerEx3[i+1],999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx3),AddV(Stat_TotalEPerEx3[i+1],100)},StrDesign("\x07+3�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPerEx3[i+1],1000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x10+3�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx3-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"6",{
			{{CV(StatP[i+1],Cost_Stat_LV3Incm,AtLeast),CV(Stat_LV3Incm[i+1],899,AtMost)},{SubV(StatP[i+1],Cost_Stat_LV3Incm),AddV(Stat_LV3Incm[i+1],1)},StrDesign("\x11LV.MAX \x1B����ƺ�\x04 �� ���޷��� \x071%\x04 �����Ͽ����ϴ�.")},
			{{CV(Stat_LV3Incm[i+1],900,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x11LV.MAX \x1B����ƺ�\x04 �� ���޷�\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_LV3Incm-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})

		CElseIfX({CV(InterfaceNum[i+1],3)},{SetV(DPErT[i+1],24)}) -- 3�� ����������
		KeyFunc(i,"1",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4X,AtLeast),CV(Stat_TotalEPer4X[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer4X),AddV(Stat_TotalEPer4X[i+1],100)},StrDesign("\x08Ư�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_TotalEPer4X[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x08Ư�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4X-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"2",{
			{{CV(StatP[i+1],Cost_Stat_BreakShield2,AtLeast),CV(Stat_BreakShield2[i+1],9999,AtMost)},{SubV(StatP[i+1],Cost_Stat_BreakShield2),AddV(Stat_BreakShield2[i+1],100)},StrDesign("\x08Ư�� \x1F�ı� ����Ȯ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_BreakShield2[i+1],10000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x1F�Ǳ� \x08����Ȯ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_BreakShield2-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		
		KeyFunc(i,"3",{
			{{CV(StatP[i+1],Cost_Stat_XEPer44,AtLeast),CV(Stat_XEPer44[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_XEPer44),AddV(Stat_XEPer44[i+1],100)},StrDesign("\x1F44�� \x08��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_XEPer44[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x1F44�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_XEPer44-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		
		KeyFunc(i,"4",{
			{{CV(StatP[i+1],Cost_Stat_XEPer45,AtLeast),CV(Stat_XEPer45[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_XEPer45),AddV(Stat_XEPer45[i+1],100)},StrDesign("\x1C45�� \x08��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_XEPer45[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x1C45�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_XEPer45-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		
		KeyFunc(i,"5",{
			{{CV(StatP[i+1],Cost_Stat_XEPer46,AtLeast),CV(Stat_XEPer46[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_XEPer46),AddV(Stat_XEPer46[i+1],100)},StrDesign("\x1E46�� \x08��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_XEPer46[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x1E46�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_XEPer46-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		KeyFunc(i,"6",{
			{{CV(StatP[i+1],Cost_Stat_XEPer47,AtLeast),CV(Stat_XEPer47[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_XEPer47),AddV(Stat_XEPer47[i+1],100)},StrDesign("\x0247�� \x08��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_XEPer47[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: �� �̻� \x0247�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],Cost_Stat_XEPer47-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
		
	CIfXEnd()

	NJump(FP, ClickCDWhile, {CD(ClickCD,1,AtLeast),CD(ClickCD2,1,AtLeast)},{SubCD(ClickCD2, 1)})

	TriggerX(FP, {CV(InterfaceNum[i+1],2),MSQC_KeyInput(i, "I")},{SubV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],3),MSQC_KeyInput(i, "I")},{SubV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],2),MSQC_KeyInput(i, "P")},{AddV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1),MSQC_KeyInput(i, "P")},{AddV(InterfaceNum[i+1],1)},{preserved})
	CIfEnd()
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),Deaths(i,Exactly,0x10000,20)}, {SetDeaths(i,SetTo,1,495),SetCp(i),DisplayExtText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)}, {preserved})--ESC
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),Deaths(i,Exactly,0x40000,20)}, {SetDeaths(i,SetTo,1,494)}, {preserved})--O
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),Deaths(i,Exactly,0x30000,20)}, {SetDeaths(i,SetTo,1,506)}, {preserved})--U
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),CV(InterfaceNum[i+1],255,AtMost),MSQC_KeyInput(i,"O"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],0),SetCp(i),DisplayExtText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],256),MSQC_KeyInput(i,"U"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],0),SetCp(i),DisplayExtText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),CV(InterfaceNum[i+1],255,AtMost),MSQC_KeyInput(i,"U"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],256)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],256),MSQC_KeyInput(i,"O"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayExtText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})

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
	CMov(FP,TotalEPer[i+1],Stat_TotalEPer[i+1],nil,nil,1)
	CMov(FP,TotalEPer2[i+1],Stat_TotalEPer2[i+1],nil,nil,1)
	CMov(FP,TotalEPer3[i+1],Stat_TotalEPer3[i+1],nil,nil,1)
	CMov(FP,TotalEPer4[i+1],Stat_TotalEPer4[i+1],nil,nil,1)
	CAdd(FP,TotalEPer4[i+1],Stat_TotalEPer4X[i+1])
	CMov(FP,TotalBreakShield[i+1],Stat_BreakShield[i+1],nil,nil,1)
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
	CAdd(FP,Stat_EXPIncome[i+1],iv.FSEXP[i+1])
	CAdd(FP,TotalEPer[i+1],CS_TEPerData[i+1])
	CAdd(FP,TotalEPer4[i+1],CS_TEPer4Data[i+1])
	CAdd(FP,TotalBreakShield[i+1],CS_BreakShieldData[i+1])
	CAdd(FP,TotalBreakShield[i+1],Stat_BreakShield2[i+1])
	
	CMov(FP,iv.XEPer44[i+1],iv.CXPer44[i+1])
	CMov(FP,iv.XEPer45[i+1],iv.CXPer45[i+1])
	CMov(FP,iv.XEPer46[i+1],iv.CXPer46[i+1])
	CMov(FP,iv.XEPer47[i+1],iv.CXPer47[i+1])
	CAdd(FP,iv.XEPer44[i+1],iv.Stat_XEPer44[i+1])
	CAdd(FP,iv.XEPer45[i+1],iv.Stat_XEPer45[i+1])
	CAdd(FP,iv.XEPer46[i+1],iv.Stat_XEPer46[i+1])
	CAdd(FP,iv.XEPer47[i+1],iv.Stat_XEPer47[i+1])
	
	CAdd(FP,TotalEPer[i+1],iv.CMEPer[i+1])
	CAdd(FP,iv.XEPer44[i+1],iv.CMEPer[i+1])
	CAdd(FP,iv.XEPer45[i+1],iv.CMEPer[i+1])
	CAdd(FP,iv.XEPer46[i+1],iv.CMEPer[i+1])
	CAdd(FP,iv.XEPer47[i+1],iv.CMEPer[i+1])
	CAdd(FP,TotalBreakShield[i+1],iv.CBrSh[i+1])
	
	
	
	
	


	--CIfChkVar(iv.FIncm[i+1])
	--CIfChkVar(iv.FSEXP[i+1])


	--CTrigger(FP, {CV(Income[i+1],_Add(IncomeMax[i+1], 1),AtLeast),LocalPlayerID(i)}, {
	--	SetCp(i),
	--	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	--	DisplayExtText("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
	--	DisplayExtText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
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
	AddV(iv.B_PFfragItem[i+1], 3),
	AddV(B_PCredit[i+1], 150000)
})
Trigger2X(FP,{CV(PBossLV[i+1],7,AtLeast)},{
	AddV(PETicket[i+1], 1)
})
Trigger2X(FP,{CV(PBossLV[i+1],8,AtLeast)},{
	AddV(iv.B_PFfragItem[i+1], 25),
	AddV(B_PTicket[i+1],100000)
})
Trigger2X(FP,{CV(PBossLV[i+1],9,AtLeast)},{
	AddV(iv.B_PFfragItem[i+1], 10000),
	
})

for pb= 1, 9 do
	TriggerX(FP,{LocalPlayerID(i),CV(PBossLV[i+1],pb,AtLeast)},{SetV(Time,(300000)-5000),SetCD(SaveRemind,1),SetCp(i),DisplayExtText(StrDesignX("\x08"..pb.."�ܰ� \x07���κ���\x04�� Ŭ�����Ͽ����ϴ�. \x07��� �� �ڵ�����˴ϴ�..."),4),SetCp(FP)})
end

CIfOnce(FP, {Command(i, AtLeast, 1, LevelUnitArr[44][2])},{SetCp(i)})

DisplayPrint("CP", {"\x13\x07�� \x04����� \x1F44�� \x07Ÿ�Ӿ��� \x10����\x04�� \x07",TimeAttackScore2[i+1]," \x04�� �Դϴ�. \x07��"})
CIfX(FP,{CV(TimeAttackScore[i+1],TimeAttackScore2[i+1],AtMost)},{})
DisplayPrint("CP", {"\x13\x07�� \x1F44�� \x07Ÿ�Ӿ��� \x10����\x04�� ���ŵǾ����ϴ�! ���� \x07",TimeAttackScore[i+1]," \x04���� �پ�����̳׿�! ���ϵ帳�ϴ�! \x07��"})
CDoActions(FP, {SetV(TimeAttackScore[i+1],TimeAttackScore2[i+1])})
CElseX()
DisplayPrint("CP", {"\x13\x07�� ���� \x07",TimeAttackScore[i+1]," \x04���� �پ� ������ ���߳׿�... �����ǿ� �� �������ô�. \x07��"})
CIfXEnd()
CIfEnd()

CIfOnce(FP, {Command(i, AtLeast, 1, LevelUnitArr[48][2])},{SetCp(i)})

DisplayPrint("CP", {"\x13\x07�� \x04����� \x1B48�� \x07Ÿ�Ӿ��� \x10����\x04�� \x07",TimeAttackScore2[i+1]," \x04�� �Դϴ�. \x07��"})
CIfX(FP,{CV(TimeAttackScore48[i+1],TimeAttackScore2[i+1],AtMost)},{})
DisplayPrint("CP", {"\x13\x07�� \x1B48�� \x07Ÿ�Ӿ��� \x10����\x04�� ���ŵǾ����ϴ�! ���� \x07",TimeAttackScore48[i+1]," \x04���� �پ�����̳׿�! ���ϵ帳�ϴ�! \x07��"})
CDoActions(FP, {SetV(TimeAttackScore48[i+1],TimeAttackScore2[i+1])})
CElseX()
DisplayPrint("CP", {"\x13\x07�� ���� \x07",TimeAttackScore48[i+1]," \x04���� �پ� ������ ���߳׿�... �����ǿ� �� �������ô�. \x07��"})
CIfXEnd()
CIfEnd()

TriggerX(FP,{CV(PBossLV[i+1],5,AtLeast)},{KillUnitAt(1,13,119+i,FP)})
TriggerX(FP,{CV(PBossLV[i+1],6,AtLeast)},{SetCDX(PBossClearFlag, 1,1)})
TriggerX(FP,{CV(PBossLV[i+1],7,AtLeast)},{SetCDX(PBossClearFlag, 2,2)})
TriggerX(FP,{CV(PBossLV[i+1],8,AtLeast)},{SetCDX(PBossClearFlag, 4,4)})
TriggerX(FP,{CV(PBossLV[i+1],9,AtLeast)},{SetCDX(PBossClearFlag, 8,8)})



	--if TestStart == 1 then
	--	TriggerX(FP,{},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- �ο��� ���� ���ʽ�
	--else
		
		TriggerX(FP,{CD(PartyBonus2,1,AtLeast)},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- �ο��� ���� ���ʽ�
	--end
	TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{AddV(Stat_EXPIncome[i+1],10)},{preserved})-- 1000���� �̸� ��ġ2��

	CIf(FP,{CV(B_Credit,1,AtLeast)})
	f_LAdd(FP,Credit[i+1],Credit[i+1],{B_Credit,0}) -- 
	CIfEnd({})
	CIf(FP,{CV(B_Ticket,1,AtLeast)})
	CAdd(FP,SellTicket[i+1],B_Ticket) --
	CIfEnd({})
	
	CIf(FP,CD(SCA.LoadCheckArr[i+1],2))--�ҷ��ð�� ���� ���� �۵�
	CIf(FP,{CV(B_PCredit[i+1],1,AtLeast)})
	f_LAdd(FP,Credit[i+1],Credit[i+1],{B_PCredit[i+1],0}) --
	CMov(FP, B_PCredit[i+1], 0)
	CIfEnd({})
	CIf(FP,{CV(iv.B_PFfragItem[i+1],1,AtLeast)})
	f_LAdd(FP,iv.FfragItem[i+1],iv.FfragItem[i+1],{iv.B_PFfragItem[i+1],0}) --
	DisplayPrint(i,{"\x13\x07�� \x02���� ����\x04�� \x07",iv.B_PFfragItem[i+1]," �� \x04 ȹ���Ͽ����ϴ�. ���� �� ȹ�淮 : \x07",iv.FfragItem[i+1]," �� \x07��"})
	CMov(FP, iv.B_PFfragItem[i+1], 0)
	CIfEnd({})
	
	CIf(FP,{CV(iv.OldFfrag[i+1],1,AtLeast)})
	local TempVX = CreateVar(FP)
	f_Mul(FP, TempVX, iv.OldFfrag[i+1], 5)
	f_LAdd(FP,iv.FfragItem[i+1],iv.FfragItem[i+1],{TempVX,0}) --
	DisplayPrint(i,{"\x13\x07�� \x02???\x04�� \x07",iv.OldFfrag[i+1]," �� \x07��ȯ�Ͽ�\x04 \x02���� ����\x04�� ",TempVX," �� ȹ���Ͽ����ϴ�. ���� �� ȹ�淮 : \x07",iv.FfragItem[i+1]," �� \x07��"})
	CMov(FP, iv.OldFfrag[i+1], 0)
	CIfEnd({})


	CIf(FP,{CV(B_PEXP[i+1],1,AtLeast)})
	f_LAdd(FP,PEXP[i+1],PEXP[i+1],{B_PEXP[i+1],0}) --
	CMov(FP, B_PEXP[i+1], 0)
	CIfEnd({})
	CIf(FP,{CV(B_PTicket[i+1],1,AtLeast)})
	CAdd(FP,SellTicket[i+1],B_PTicket[i+1]) --
	CMov(FP, B_PTicket[i+1], 0)
	CIfEnd({})
	CIfEnd()


	

	
	DoActionsX(FP,{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 0),SetMemoryB(0x58F32C+(i*15)+12, SetTo, 0),})


	for CBit = 0, 7 do -- 8��Ʈ ������ ���� ���ۼ�ġ ����
		TriggerX(FP,{NVar(ScoutDmg[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+12, Add, 2^CBit)},{preserved})
		TriggerX(FP,{NVar(General_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit)},{preserved})
	end
	--if Limit == 1 then--�������ڿ� ġƮ
	--	CIf(FP,{CV(iv.MapMakerFlag[i+1],1)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)})
	--	CMov(FP,IncomeMax[i+1],48,nil,nil,1)
	--	CIfEnd()
	--end

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 91)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)},{preserved})--���� �����÷ο� ����
	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)},{}) --  ���� ��ȭ�õ��ϱ�. 39�� ��������
	CMov(FP,BreakShield,TotalBreakShield[i+1])
	CMov(FP,GEper,TotalEPer[i+1])
	CMov(FP,GEper2,TotalEPer2[i+1])
	CMov(FP,GEper3,TotalEPer3[i+1])
	CMov(FP,GEper4,TotalEPer[i+1])
	CAdd(FP,GEper4,TotalEPer2[i+1])
	CAdd(FP,GEper4,TotalEPer3[i+1])
	CAdd(FP,GEper4,TotalEPer4[i+1])
	f_LMov(FP,TempEXPW2,"0",nil,nil,1)


	for j = 39, 1, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		local EXP = LevelUnitArr[j][4]
		if j <= 25 then
			EXP = 0
		end
		CallTriggerX(FP, Call_Enchant, {Bring(i,AtLeast,1,UID,8+i)}, {KillUnitAt(1, UID, 8+i, i),SetV(ELevel,LV-1),SetV(UEper,Per),SetV(ECP,i),SetNWar(TempEXPW2,SetTo,tostring(EXP))})


	end
	for j = 43, 40, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		CIf(FP,{Bring(i,AtLeast,1,UID,8+i)})
		CSub(FP,XEper,GEper4,Per)
		CallTriggerX(FP, Call_Enchant2, {CV(XEper,1,AtLeast)}, {KillUnitAt(1, UID, 8+i, i),SetV(ELevel,LV-1),SetV(ECP,i)})
		TriggerX(FP,{CV(XEper,0)},{MoveUnit(All,UID,i,8+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0),DisplayExtText(StrDesignX("\x08ERROR \x04: Ȯ���� �����Ͽ� ��ȭ�� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
		CIfEnd()
	end
	for j = 47, 44, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		CIf(FP,{Bring(i,AtLeast,1,UID,8+i)})
		if j >= 44 and j <= 47 then
			CAdd(FP,XEper,XEperArr[j-43],Per)
			CiSub(FP,XEper,XEPerM)
			TriggerX(FP,CV(XEper,0x80000000,AtLeast),{SetV(XEper,0)},{preserved})--���̳ʽ��ϰ�� 0
		end
		CallTriggerX(FP, Call_Enchant2, {CV(XEper,1,AtLeast)}, {KillUnitAt(1, UID, 8+i, i),SetV(ELevel,LV-1),SetV(ECP,i)})
		TriggerX(FP,{CV(XEper,0)},{MoveUnit(All,UID,i,8+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0),DisplayExtText(StrDesignX("\x08ERROR \x04: Ȯ���� �����Ͽ� ��ȭ�� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
		CIfEnd()
	end

	CIfEnd()

	CIf(FP,{Bring(i,AtLeast,1,"Men",73+i)},{}) --  ���� �ǸŽõ��ϱ�

		f_LMov(FP,TempEXPW,"0",nil,nil,1)
		for j = #LevelUnitArr, 1, -1 do
			local UID = LevelUnitArr[j][2]
			local EXP = LevelUnitArr[j][4]
			if EXP>=1 then
				if j>=26 then
					TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i),CV(PLevel[i+1],LevelLimit,AtLeast)},{MoveUnit(All,UID,i,73+i,36+i),SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: �̹� ������ �޼��Ͽ� �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
					TriggerX(FP,{CV(PLevel[i+1],LevelLimit-1,AtMost),Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],0,AtMost)},{MoveUnit(All,UID,i,73+i,36+i),SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x19���� �Ǹű�\x04�� �����մϴ�... \x07L Ű\x04�� ���������� Ȯ�����ּ���."), 4),SetCp(FP)},{preserved})
					CIf(FP,{CV(PLevel[i+1],LevelLimit-1,AtMost),Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],1,AtLeast)},{KillUnitAt(1, UID, 73+i, i),SubV(SellTicket[i+1],1)})
					f_LAdd(FP, TempEXPW,TempEXPW, tostring(EXP))
					CIfEnd()
					
				else
					TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i),CV(PLevel[i+1],LevelLimit,AtLeast)},{MoveUnit(All,UID,i,73+i,36+i),SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: �̹� ������ �޼��Ͽ� �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
					CIf(FP,{CV(PLevel[i+1],LevelLimit-1,AtMost),Bring(i,AtLeast,1,UID,73+i)},{KillUnitAt(1, UID, 73+i, i)})
					f_LAdd(FP, TempEXPW,TempEXPW, tostring(EXP))
					if j==15 then
						DoActionsX(FP, {SetVX(MissionV[i+1],32,32)})
					end
					CIfEnd()
				end
			elseif j>=45 then
				TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],9999,AtMost)},{MoveUnit(All,UID,i,73+i,36+i),SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x19���� �Ǹű�\x04�� �����մϴ�... \x07L Ű\x04�� ���������� Ȯ�����ּ���."), 4),SetCp(FP)},{preserved})
				CallTriggerX(FP, Call_Gacha, {Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],10000,AtLeast)}, {KillUnitAt(1, UID, 73+i, i),SubV(SellTicket[i+1],10000),SetV(GaLv,j),SetV(ECP,i)})
			else
				
				--CallTriggerX(FP,Call_Print13[i+1],{Bring(i,AtLeast,1,UID,73+i)})
				TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{MoveUnit(1,UID,i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: �ش� ������ �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
			end

			
		end
		TriggerX(FP,{Bring(i,AtLeast,1,88,73+i)},{MoveUnit(1,88,i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: �ش� ������ �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
        CIf(FP,{TTNWar(TempEXPW,AtLeast,"1")})
            f_LAdd(FP, PEXP[i+1], PEXP[i+1],TempEXPW)
            CIf(FP,{CV(Stat_EXPIncome[i+1],1,AtLeast)})
                f_LAdd(FP,PEXP2[i+1],PEXP2[i+1],_LMul(TempEXPW,{Stat_EXPIncome[i+1],0}))
                f_LAdd(FP, PEXP[i+1], PEXP[i+1], _LDiv(PEXP2[i+1],"10"))
                f_LMod(FP, PEXP2[i+1],PEXP2[i+1], "10")
            CIfEnd()
        CIfEnd()
	CIfEnd()
	

	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0),SetV(ResetStatLoc,0)}) -- CAPrint�� ������ ����
	CallTrigger(FP, Call_GetLocalData)
	TriggerX(FP,{CD(iv.StatEff[i+1],1)},{SetCD(iv.StatEffLoc,1)},{preserved})
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
				Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,Simple_CalcLoc(86, -320, -320, 320, 320))
				CDoActions(FP, {AddCD(ZKeyCool[i+1], 24*3),TMoveUnit(All, KSelUID, i, 87, 87)})
				DoActionsX(FP, {SetCp(i),DisplayExtText(StrDesignX("\x03SYSTEM \x04: ���� �������� ���� ������ ������ ���ƽ��ϴ�. ��Ÿ�� : 3��.").."\n"..StrDesignX("\x04�� �޼����� 1ȸ�� ǥ��˴ϴ�."),4)}, 1)
				CIfEnd()
				f_LoadCp()
				CElseIfX({MSQC_KeyInput(i,"Z"),CD(ZKeyCool[i+1],1,AtLeast)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: ���� ���� ��ġ�� ����� ��Ÿ�����Դϴ�."),4)})
				CIfXEnd()
				if TestStart == 1 then
					--CTrigger(FP,{KeyPress("Y", "Down")},{SetMemory(0x6509B0,Subtract,6),TSetDeathsX(CurrentPlayer,SetTo,0,0,0xFF),SetMemory(0x6509B0,Add,6)},1)
					--f_SaveCp()
					--local temp,TKey = ToggleFunc({KeyPress("T","Up"),KeyPress("T","Down")},nil,1)--
					--local temp,YKey = ToggleFunc({KeyPress("Y","Up"),KeyPress("Y","Down")},nil,1)--
					--local FID = CreateVar(FP)
					--CMov(FP,FID,_ReadF(_Sub(BackupCp, 16)),nil,0xFF,1)
					--CTrigger(FP,{CD(TKey,1)},{TSetMemory(_Add(FID,EPD(0x6C9930)),Add,1)},1)
					--CTrigger(FP,{CD(YKey,1)},{TSetMemory(_Add(FID,EPD(0x6C9930)),Subtract,1)},1)
					--CIf(FP,{TTOR({CD(TKey,1),CD(YKey,1)})})
					--local HD = CreateVar(FP)
					--CMov(FP,HD,_ReadF(_Add(FID,EPD(0x6C9930))))
					--DisplayPrint(i, {"HaltDis : ",HD})
					--CIfEnd()
					--f_LoadCp()
				end
		CIfEnd()
		CMov(FP,0x6509B0,FP)
		TriggerX(FP,{Deaths(i, Exactly, 1,13),Deaths(i, Exactly, 0,14)},{SetDeaths(i, SetTo, 1,14)},{preserved})

		
		CIf(FP,{CD(SCA.GlobalCheck,3),CD(SCA.LoadCheckArr[i+1],2),Deaths(i, AtLeast, 1,14),})
	if Limit == 0 then
		NIfX(FP,{CV(CurMission[i+1],3,AtLeast)},{SetV(DPErT[i+1],24*10)}) -- �����ư�� �����ų� �ڵ����� �ý��ۿ� ���� �ش� Ʈ���ſ� �������� ���
	else
		NIfX(FP,{CV(iv.MapMakerFlag[i+1],1),CV(CurMission[i+1],3,AtLeast)},{SetV(DPErT[i+1],24*10)}) -- �����ư�� �����ų� �ڵ����� �ý��ۿ� ���� �ش� Ʈ���ſ� �������� ���
	end
		CallTriggerX(FP,Call_Print13[i+1],{SCA.Available(i),Deaths(i, Exactly, 1, 14)})
		TriggerX(FP, {SCA.Available(i),Deaths(i, Exactly, 1, 14)}, {print_utf8(12,0,StrDesign("\x03SCArchive\x04�� \x07���� ������\x04�� �����ϰ� �ֽ��ϴ�..."))}, {preserved})
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 4, 2),SetDeaths(i, SetTo, 2,14),SCA.Reset(i)},{preserved})--�����ȣ ������
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--����Ʈ���� �ݰ� CT�۵�
		CMov(FP,iv.PLevel2[i+1],PLevel[i+1])
		CIf(FP,CV(iv.MapMakerFlag[i+1],1))--�������ϰ�� ���� 1���� ������ ����.
		CMov(FP,PLevelBak,PLevel[i+1])
		CMov(FP,PLevel[i+1],1)
		CIfEnd()
		SCA_DataReset(i)
		CallTrigger(FP,Call_SCA_DataSaveAll)
		CIf(FP,CV(iv.MapMakerFlag[i+1],1))
		CMov(FP,PLevel[i+1],PLevelBak)
		CIfEnd()
		NElseIfX({CV(CurMission[i+1],2,AtMost)},{SetV(DPErT[i+1],24*10),SetDeaths(i, SetTo, 0,14)}) -- ���ǺҸ��� - �̼�3��Ŭ�������
		CallTriggerX(FP,Call_Print13[i+1],{})
		TriggerX(FP, {LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: ������ �ϱ� ���ؼ��� ���� \x07M\x04ission \x08No. \x103\x04 ���� Ŭ���� �ϼž� �մϴ�."))}, {preserved})
		if Limit == 1 then
		
		NElseIfX({CV(iv.MapMakerFlag[i+1],0)},{SetV(DPErT[i+1],24*10)}) -- ���ǺҸ��� - �׽�Ʈ��
		SCA_DataSave(i,iv.TesterFlag[i+1],SCA.TesterFlag)
		SCA_DataSave(i,iv.CreditAddSC[i+1],SCA.CreditAddSC)
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--����Ʈ���� �ݰ� CT�۵�
		CallTriggerX(FP,Call_Print13[i+1],{SCA.Available(i),Deaths(i, Exactly, 1, 14)})
		TriggerX(FP, {SCA.Available(i),Deaths(i, Exactly, 1, 14),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: �׽�Ʈ�ʿ����� �׽�Ʈ ��� ������ ����˴ϴ�..."))}, {preserved})
		
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 4, 2),SetDeaths(i, SetTo, 2,14),SCA.Reset(i)},{preserved})--�����ȣ ������
		end
		NIfXEnd()
		CIfEnd()
		--TriggerX(FP, {CV(LV5Cool[i+1],0,AtMost);}, {SetCD(BossLV6Private[i+1],0)},{preserved})
	CallTriggerX(FP, Call_BossReward,{CV(BossLV,5,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,0)},1)
	CallTriggerX(FP, Call_BossReward,{CV(BossLV,6,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,1)},1)
	CIfEnd()
	

	CheckTrig("Interface_P"..(i+1))
end



CheckTrig("Interface_End")
end
