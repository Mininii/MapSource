function Interface()

	--PlayData(NonSCA)
	local Money = iv.Money-- CreateWarArr(7,FP) -- 자신의 현재 돈 보유량
	local IncomeMax = iv.IncomeMax-- CreateVarArr2(7,12,FP) -- 자신의 사냥터 최대 유닛수
	local Income = iv.Income-- CreateVarArr(7,FP) -- 자신의 현재 사냥터에 보유중인 유닛수
	local BuildMul1 = iv.BuildMul1-- CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	local BuildMul2 = iv.BuildMul2-- CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	local TotalEPer = iv.TotalEPer-- CreateVarArr(7,FP)--총 강화확률(기본 1강)
	local TotalEPer2 = iv.TotalEPer2-- CreateVarArr(7,FP)--총 강화확률(+2강)
	local TotalEPer3 = iv.TotalEPer3-- CreateVarArr(7,FP)--총 강화확률(+3강)
	local ScoutDmg = iv.ScoutDmg-- CreateVarArr(7,FP) -- 기본유닛 데미지
	local ScTimer = iv.ScTimer-- CreateCcodeArr(7)
	local PTimeV = iv.PTimeV
	local ResetStat = iv.ResetStat
	local General_Upgrade = iv.General_Upgrade--CreateVarArr(7,FP)-- 유닛 공격력 증가량 수치
	local PBossLV = iv.PBossLV -- 개인보스레벨
	local PBossDPS = iv.PBossDPS-- 개인보스DPS
	local TotalPBossDPS = iv.TotalPBossDPS --개인보스DPS 목표치
	local SellTicket = iv.SellTicket
	local SCUnits = iv.SCUnits




	--General
	local BossLV = iv.BossLV-- CreateVar(FP)
	
	--Setting, Effect
	local StatEff = iv.StatEff--CreateCcodeArr(7) -- 레벨업 이펙트
	local StatEffT2 = iv.StatEffT2--CreateCcodeArr(7) -- 레벨업 이펙트
	local InterfaceNum = iv.InterfaceNum--CreateVarArr(7,FP) -- 상점이나 스탯 찍는 창 제어부
	local AutoBuyCode = iv.AutoBuyCode--CreateCcodeArr(7)-- 자동 구입 제어 데스값
	local PCheckV = iv.PCheckV--CreateVar(FP)--플레이어 수 체크
	local MulOp = iv.MulOp--CreateVarArr2(7,1,FP) -- 유닛 공격력에 따른 수치 표기용 변수
	
	--PlayData(SCA)
	local PLevel = iv.PLevel--CreateVarArr2(7,1,FP)-- 자신의 현재 레벨
	local StatP = iv.StatP--CreateVarArr(7,FP)-- 현재 보유중인 스탯포인트
	local Stat_ScDmg = iv.Stat_ScDmg--CreateVarArr(7,FP)-- 사냥터 업글 수치
	local Stat_AddSc = iv.Stat_AddSc--CreateVarArr(7,FP)-- 사냥터 업글 수치
	local Stat_TotalEPer = iv.Stat_TotalEPer--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPer2 = iv.Stat_TotalEPer2--CreateVarArr(7,FP)-- +2강 확업 수치
	local Stat_TotalEPer3 = iv.Stat_TotalEPer3--CreateVarArr(7,FP)-- +3강 확업 수치
	local Stat_Upgrade = iv.Stat_Upgrade--CreateVarArr(7,FP)-- 유닛 공격력 증가량 수치
	local Credit = iv.Credit--CreateWarArr(7,FP) -- 보유중인 크레딧
	local PEXP = iv.PEXP--CreateWarArr(7, FP) -- 자신이 지금까지 얻은 총 경험치
	local TotalExp = iv.TotalExp--CreateWarArr2(7,"10",FP) -- 지금까지 레벨업에 사용한 경험치 + 현재 레벨업에 필요한 경험치
	local CurEXP = iv.CurEXP--CreateWarArr(7,FP) -- 지금까지 레벨업에 사용한 경험치
	local PStatVer = iv.PStatVer--CreateVarArr(7,FP) -- 현재 저장된 스탯버전
	local PlayTime2 = iv.PlayTime2
	local NextOre = iv.NextOre
	local NextGas = iv.NextGas
	local NextOreMul = iv.NextOreMul
	local NextGasMul = iv.NextGasMul
	local PlayTime = iv.PlayTime
	local CreditAddSC = iv.CreditAddSC
	local LV5Cool = iv.LV5Cool

	--Local Data Variable
	local IncomeMaxLoc = iv.IncomeMaxLoc--CreateVar(FP)
	local IncomeLoc = iv.IncomeLoc--CreateVar(FP)
	local LevelLoc = iv.LevelLoc--CreateVar(FP)
	local LevelLoc2 = iv.LevelLoc2--CreateVar(FP)
	local TotalEPerLoc = iv.TotalEPerLoc--CreateVar(FP)
	local TotalEPer2Loc = iv.TotalEPer2Loc--CreateVar(FP)
	local TotalEPer3Loc = iv.TotalEPer3Loc--CreateVar(FP)
	local S_TotalEPerLoc = iv.S_TotalEPerLoc--CreateVar(FP)
	local S_TotalEPer2Loc = iv.S_TotalEPer2Loc--CreateVar(FP)
	local S_TotalEPer3Loc = iv.S_TotalEPer3Loc--CreateVar(FP)
	local PlayTimeLoc = iv.PlayTimeLoc--CreateVar(FP)
	local PlayTimeLoc2 = iv.PlayTimeLoc2--CreateVar(FP)
	local StatPLoc = iv.StatPLoc--CreateVar(FP)
	local MoneyLoc = iv.MoneyLoc--CreateWar(FP)
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
	local TempEXPV = iv.TempEXPV--CreateVar(FP)

	local CheatDetect = iv.CheatDetect--CreateCcode()



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
	local SCheck = CreateCcode()
	local GeneralPlayTime= CreateVar(FP)
	local GeneralPlayTime2= CreateVar(FP)
	
	function SCA_DataLoad(Player,Dest,SourceUnit) --Dest == W then Use SourceUnit, SourceUnit+1
		if Dest[4]=="V" then
			f_Read(FP,0x58A364+(48*SourceUnit)+(4*Player),Dest)
		elseif Dest[4]=="W" then
			f_LRead(FP, {0x58A364+(48*SourceUnit)+(4*Player),0x58A364+(48*(SourceUnit+1))+(4*Player)}, Dest, nil, 1)
		else
			PushErrorMsg("SCA_Dest_Inputdata_Error")
		end
	end
	function SCA_DataSave(Player,Source,DestUnit) --Source == W then Use DestUnit, DestUnit+1
		if Source[4]=="V" then
			CMov(FP,0x58A364+(48*DestUnit)+(4*Player),Source,nil,nil,1)
		elseif Source[4]=="W" then
			f_LMov(FP, {0x58A364+(48*DestUnit)+(4*Player),0x58A364+(48*(DestUnit+1))+(4*Player)}, Source, nil, nil, 1)
		else
			PushErrorMsg("SCA_Source_Inputdata_Error")
		end
		
	end
	
	local LeaderBoardT = CreateCcode()
Trigger { -- DPS 리더보드
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,LeaderBoardT);
	},
	actions = {
		
		LeaderBoardGreed(10000000);
		LeaderBoardComputerPlayers(Disable);
		SetCDeaths(FP,SetTo,1000,LeaderBoardT);
		PreserveTrigger();
},
}
Trigger { -- 레벨
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,500,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Custom, StrDesign("\17Level").." "..VerText);
		LeaderBoardComputerPlayers(Disable);
		PreserveTrigger();
},
}
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,LeaderBoardT)})


	
	--PlayData(NotSureSCA)
	local Stat_EXPIncome = iv.Stat_EXPIncome--CreateVarArr(7,FP)-- 경험치 획득량 수치. 사용 미정
	local PEXP2 = iv.PEXP2--CreateVarArr(7, FP) -- 1/10로 나눠 경험치에 더할 값 저장용. 사용 미정





	--local GEXP = CreateVar(FP)
	local STable = {"1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "2048", "4096", "8192", "16384", "32768", "65536", "131072", "262144", "524288", "1048576", "2097152", "4194304", "8388608", "16777216", "33554432", "67108864", "134217728", "268435456", "536870912", "1073741824", "2147483648", "4294967296", "8589934592", "17179869184", "34359738368", "68719476736", "137438953472", "274877906944", "549755813888", "1099511627776", "2199023255552", "4398046511104", "8796093022208", "17592186044416", "35184372088832", "70368744177664", "140737488355328", "281474976710656", "562949953421312", "1125899906842624", "2251799813685248", "4503599627370496", "9007199254740992", "18014398509481984", "36028797018963968", "72057594037927936", "144115188075855872", "288230376151711744", "576460752303423488", "1152921504606846976", "2305843009213693952", "4611686018427387904", "9223372036854775807"}
	local FirstReward = {
		{20,500},
		{22,7000},
		{24,20000},
		{26,80000},
	}
	local OreDPS = {100,1000,10000,100000,500000,1000000,0}
	local OreDPSM = {2,4,8,16,32,64}
	local GasDPS = {100,1000,10000,100000,1000000,5000000,0}
	local GasDPSM = {2,4,8,16,32,64}
	local Dx,Dy,Dv,Du,DtP,Time2,Time = CreateVariables(7,FP)
	local SaveRemind = CreateCcode()
	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CV(DtP,2500,AtMost)},{AddV(Time,DtP),AddV(Time2,DtP)},1)--맨처음 시간값 튐 방지
	--CallTriggerX(FP,Call_CheckCT,{CD(CTTimer,24,AtLeast)},{SetCD(CTTimer,0)})--유닛 변조 감지

	CMov(FP,CT_GNextRandV,_Mod(_Rand(),12858519))
	f_LMov(FP,CT_GNextRandW,_LMod(_LRand(), {12532858,12532858}))



	PVWArr = {
		{iv.Money,ct.Money,"Money"},
		{iv.IncomeMax,ct.IncomeMax,"IncomeMax"},
		{iv.Income,ct.Income,"Income"},
		{iv.BuildMul1,ct.BuildMul1,"BuildMul1"},
		{iv.BuildMul2,ct.BuildMul2,"BuildMul2"},
		{iv.TotalEPer,ct.TotalEPer,"TotalEPer"},
		{iv.TotalEPer2,ct.TotalEPer2,"TotalEPer2"},
		{iv.TotalEPer3,ct.TotalEPer3,"TotalEPer3"},
		{iv.ScoutDmg,ct.ScoutDmg,"ScoutDmg"},
		{iv.ScTimer,ct.ScTimer,"ScTimer"},
		{iv.PTimeV,ct.PTimeV,"PTimeV"},
		{iv.General_Upgrade,ct.General_Upgrade,"General_Upgrade"},
		{iv.ResetStat,ct.ResetStat,"ResetStat"},
		{iv.NextOre,ct.NextOre,"NextOre"},
		{iv.NextGas,ct.NextGas,"NextGas"},
		{iv.NextOreMul,ct.NextOreMul,"NextOreMul"},
		{iv.NextGasMul,ct.NextGasMul,"NextGasMul"},
		{iv.SellTicket,ct.SellTicket,"SellTicket"},
		{iv.SCUnits,ct.SCUnits,"SCUnits"},
		{iv.PBossLV,ct.PBossLV,"PBossLV"},
		{iv.PBossDPS,ct.PBossDPS,"PBossDPS"},
		{iv.TotalPBossDPS,ct.TotalPBossDPS,"TotalPBossDPS"},
		{iv.Stat_EXPIncome,ct.Stat_EXPIncome,"Stat_EXPIncome"},
		{iv.PLevel,ct.PLevel,"PLevel"},
		{iv.StatP,ct.StatP,"StatP"},
		{iv.Stat_ScDmg,ct.Stat_ScDmg,"Stat_ScDmg"},
		{iv.Stat_AddSc,ct.Stat_AddSc,"Stat_AddSc"},
		{iv.Stat_TotalEPer,ct.Stat_TotalEPer,"Stat_TotalEPer"},
		{iv.Stat_TotalEPer2,ct.Stat_TotalEPer2,"Stat_TotalEPer2"},
		{iv.Stat_TotalEPer3,ct.Stat_TotalEPer3,"Stat_TotalEPer3"},
		{iv.Stat_Upgrade,ct.Stat_Upgrade,"Stat_Upgrade"},
		{iv.Credit,ct.Credit,"Credit"},
		{iv.PEXP,ct.PEXP,"PEXP"},
		{iv.TotalExp,ct.TotalExp,"TotalExp"},
		{iv.CurEXP,ct.CurEXP,"CurEXP"},
		{iv.PStatVer,ct.PStatVer,"PStatVer"},
		{iv.PlayTime2,ct.PlayTime2,"PlayTime2"},
		{iv.PlayTime,ct.PlayTime,"PlayTime"},
		{iv.CreditAddSC,ct.CreditAddSC,"CreditAddSC"},
		{iv.LV5Cool,ct.LV5Cool,"LV5Cool"},
		{iv.B_PCredit,ct.B_PCredit,"B_PCredit"},
		{iv.B_PTicket,ct.B_PTicket,"B_PTicket"}
	}
	VWArr = {
		{iv.PCheckV,ctg.PCheckV,"PCheckV"},
		{iv.B_IncomeMax,ctg.B_IncomeMax,"B_IncomeMax"},
		{iv.B_TotalEPer,ctg.B_TotalEPer,"B_TotalEPer"},
		{iv.B_TotalEPer2,ctg.B_TotalEPer2,"B_TotalEPer2"},
		{iv.B_TotalEPer3,ctg.B_TotalEPer3,"B_TotalEPer3"},
		{iv.B_Stat_EXPIncome,ctg.B_Stat_EXPIncome,"B_Stat_EXPIncome"},
		{iv.B_Stat_Upgrade,ctg.B_Stat_Upgrade,"B_Stat_Upgrade"},
		{iv.B_Credit,ctg.B_Credit,"B_Credit"},
		{iv.B_Ticket,ctg.B_Ticket,"B_Ticket"},
		{iv.BossLV,ctg.BossLV,"BossLV"},
	}
	for j,k in pairs(VWArr) do
		local VW = k[1]
		local TrapVW = k[2]
		TrapKey = CheatTestX(AllPlayers, VW,TrapVW, j-1,nil,k[3])
		if TrapVW[4] == "V" then
			CXor(FP, TrapVW, CT_GNextRandV)
		else
			f_LXor(FP, TrapVW,TrapVW, CT_GNextRandW)
		end

	end
	CMov(FP,PCheckV,0)
	CAdd(FP,GeneralPlayTime,1)
	ULimitArr = {500,350,300,250,200,180,150}
	ULimitV = CreateVar(FP)
	ULimitV2 = CreateVar(FP)
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
	DoActions(FP, SetMemory(0x58F500, SetTo, 0))
	local LoadCheck = CreateCcodeArr(7)
	Trigger2X(FP, {CV(GeneralPlayTime,(24*60*60)-1,AtMost)}, {SetCD(BossRewardEnable,0)},{preserved})
	Trigger2X(FP, {CV(GeneralPlayTime,24*60*60,AtLeast),CV(PCheckV,2,AtLeast)}, {SetCD(BossRewardEnable,1),RotatePlayer({DisplayTextX(StrDesignX("\x04멀티플레이 시작 후 1시간이 지났습니다. \x07이제부터 1인 진행으로 개인보스 LV.5의 보상 획득 가능합니다. "))}, Force1, FP)})
	Trigger2X(FP, {CV(PCheckV,2,AtLeast)}, {SetCD(BossRewardEnable,1)},{preserved})


for i = 0, 6 do -- 각플레이어 
	CIf(FP,{HumanCheck(i,1)},{SetCp(i)})
	CMov(FP,CT_NextRandV[i+1],_Mod(_Rand(),12858519))
	f_LMov(FP,CT_NextRandW[i+1],_LMod(_LRand(), {12532858,12532858}))
	
	for j,k in pairs(PVWArr) do
		local VW = k[1][i+1]
		local TrapVW = k[2][i+1]
		TrapKey = CheatTestX(i, VW,TrapVW, j+(#VWArr)-1,1,k[3])
		if TrapVW[4] == "V" then
			CXor(FP, TrapVW, CT_NextRandV[i+1])
		else
			f_LXor(FP, TrapVW,TrapVW, CT_NextRandW[i+1])
		end

	end
	DoActionsX(FP, {AddV(ScTimer[i+1],1),AddV(PTimeV[i+1],1)})

	CDoActions(FP,{TSetScore(i,SetTo,PLevel[i+1],Custom)})
	CIf(FP,CV(PTimeV[i+1],24,AtLeast), {SubV(PTimeV[i+1],24),AddV(PlayTime[i+1],1)})
	TriggerX(FP, {CV(LV5Cool[i+1],1,AtLeast),}, {SubV(LV5Cool[i+1],1)},{preserved})
	CIfEnd()


	TriggerX(FP,{LocalPlayerID(i),Command(i,AtMost,0,"Men"),Command(i,AtMost,0,"Factories"),CV(Time2,60000,AtLeast),CD(LoadCheck[i+1],1)},{SetV(Time2,0),SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: 보유 유닛이 없을 경우 \x07실제시간 \x031분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4)},{preserved})
	CIf(FP,{LocalPlayerID(i),CV(Time,30000*5,AtLeast)},{SubV(Time,30000*5)})
	TriggerX(FP,{LocalPlayerID(i),CD(LoadCheck[i+1],1),CD(SaveRemind,0)},{DisplayText(StrDesignX("\x03SYSTEM \x04: \x07실제시간 \x035분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4)},{preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SaveRemind,0),NVar(PCheckV,AtLeast,2)},{DisplayText(StrDesignX("\x04현재 \x1F멀티 플레이 보너스 버프 \x1C적용중입니다. - \x08공격력 + 150%\x04, \x07+1강 \x17강화확률 + \x0F1.0%p"),4)},{preserved})-- 인원수 버프 보너스
	TriggerX(FP,{LocalPlayerID(i),CD(LoadCheck[i+1],1)},{SetMemory(0x58F500, SetTo, 1),},{preserved})
	TriggerX(FP,{LocalPlayerID(i)},{SetCD(SaveRemind,0)},{preserved})

	CIfEnd()--
	CIfOnce(FP,{Deaths(i, Exactly, 2, 23)},{SetCD(LoadCheck[i+1],1),SetCD(CheatDetect,0)})--로드 완료시 첫 실행 트리거
		CIfX(FP, {Deaths(i,AtLeast,1,101)})--레벨데이터가 있을경우 로드후 모두 덮어씌움, 없으면 뉴비로 간주하고 로드안함
		SCA_DataLoad(i,PLevel[i+1],101)
		SCA_DataLoad(i,StatP[i+1],102)
		SCA_DataLoad(i,Stat_ScDmg[i+1],103)
		SCA_DataLoad(i,Stat_TotalEPer[i+1],104)
		SCA_DataLoad(i,Stat_TotalEPer2[i+1],105)
		SCA_DataLoad(i,Stat_TotalEPer3[i+1],106)
		SCA_DataLoad(i,Stat_Upgrade[i+1],107)
		SCA_DataLoad(i,Credit[i+1],108)
		SCA_DataLoad(i,PEXP[i+1],110)
		SCA_DataLoad(i,TotalExp[i+1],112)
		SCA_DataLoad(i,CurEXP[i+1],114)
		SCA_DataLoad(i,Stat_AddSc[i+1],116)
		SCA_DataLoad(i,PStatVer[i+1],117)
		SCA_DataLoad(i,PlayTime[i+1],118)
		SCA_DataLoad(i,PlayTime2[i+1],119)
		SCA_DataLoad(i,CreditAddSC[i+1],120)
		SCA_DataLoad(i,LV5Cool[i+1],121)
		
		
		--치팅 테스트 변수 초기화
		CIfX(FP,CV(PStatVer[i+1],StatVer))--스탯버전이 저장된 값과 같을경우 치팅 감지 작동
		f_LMov(FP, CTPEXP, PEXP[i+1])
		CMov(FP, CTPLevel, 1)
		CMov(FP,CTStatP,5)
		CMov(FP,CTStatP2,StatP[i+1])
		f_LMov(FP, CTCurEXP, 0,nil,nil,1)
		f_LMov(FP, CTTotalExp, "10",nil,nil,1)
		CallTrigger(FP,Call_CT)
		CAdd(FP,CTStatP2,_Mul(Stat_ScDmg[i+1],_Mov(Cost_Stat_ScDmg)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
		CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(Cost_Stat_Upgrade)))
		CAdd(FP,CTStatP2,_Mul(Stat_AddSc[i+1],_Mov(Cost_Stat_AddSc)))
		CMov(FP,0x57f0f0+(i*4),CTStatP)--치팅감지시 스탯정보 표기용 미네랄
		CMov(FP,0x57f120+(i*4),CTStatP2)--치팅감지시 스탯정보 표기용 가스
		CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNVar(CTPLevel,NotSame,PLevel[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNWar(CTCurEXP,NotSame,CurEXP[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNWar(CTTotalExp,NotSame,TotalExp[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {Deaths(i,AtLeast,1,98)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {Deaths(i,AtLeast,1,97)}, {SetCD(CheatDetect,1)})
		TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
			SetCp(i),
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
			DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
			SetMemory(0xCDDDCDDC,SetTo,1);})
		
		CMov(FP,0x57f0f0+(i*4),0)--치팅감지시 스탯정보 표기용 미네랄 초기화
		CMov(FP,0x57f120+(i*4),0)--치팅감지시 스탯정보 표기용 가스 초기화
		CElseX()--새 스탯 버전이 감지될 경우 치팅감지 작동X, 스탯을 초기화함
		DoActionsX(FP, {
			SetV(PLevel[i+1],1),
			SetV(StatP[i+1],5),
			SetCWar(FP, CurEXP[i+1][2], SetTo, "0"),
			SetCWar(FP, TotalExp[i+1][2], SetTo, "10"),
			SetV(Stat_ScDmg[i+1],0),
			SetV(Stat_TotalEPer[i+1],0),
			SetV(Stat_TotalEPer2[i+1],0),
			SetV(Stat_TotalEPer3[i+1],0),
			SetV(Stat_Upgrade[i+1],0),
			SetV(Stat_AddSc[i+1],0)})
		CIfXEnd()
		
		CIf(FP,{TTOR({CV(Stat_ScDmg[i+1],1,AtLeast),CV(Stat_AddSc[i+1],1,AtLeast),Deaths(i, AtLeast, 1, 100),CV(CreditAddSC[i+1],1,AtLeast)})})--스카 공격력 증가량 데이터 존재여부
		DoActionsX(FP, {SetV(ScTimer[i+1],0),RemoveUnit(88, i)})--로드성공시 스카타이머 초기화
			for k = 0, 5 do
				CreateUnitStacked({CV(Stat_AddSc[i+1],k)},k+1, 88, 36+i,15+i, i, nil, 1)--스카 터졌을경우 다시 지급
			end
			CreateUnitStacked({CV(CreditAddSC[i+1],1,AtLeast)},6, 88, 36+i,15+i, i, nil, 1)--크레딧 스카웃 구입항목 보유자 스카지급
			CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--제작자 칭호 보유자 스카 6개 추가지급
			
		CIfEnd()
		
		CElseX()--레벨이 0일 경우 이쪽으로
		SCA_DataLoad(i,PlayTime2[i+1],119)--구 이용시간 불러옴
		CIf(FP,CV(PlayTime2[i+1],1,AtLeast),{SetV(ScTimer[i+1],0),RemoveUnit(88, i),SetCp(i),DisplayText(StrDesignX("\x04테스트 유저 특전으로 다음 보상을 드립니다. \x07다시한번 플레이해주셔서 감사합니다.").."\n"..StrDesignX("\x07기본유닛 6기\x04 지급. \x08주의 \x04: \x07기본유닛\x04은 게임 실행 1회에만 등장하며 3분 뒤 사라집니다."), 4),SetCp(FP)})
			TriggerX(FP,{CV(PlayTime2[i+1],1,AtLeast)},{SetV(CreditAddSC[i+1],1),SetDeaths(i, SetTo, 1, 99)},{preserved})
			CreateUnitStacked({CV(PlayTime2[i+1],1,AtLeast)},6, 88, 36+i,15+i, i, nil, 1)--테스터유저 감사 칭호 보유자 스카 6개 추가지급
			CMov(FP,CTimeV,PlayTime2[i+1])
			CallTrigger(FP,Call_ConvertTime)
			DoActions(FP,{SetCp(i)})
			DisplayPrint("CP", {"\x13\x0D\x0D\x0D",PName("LocalPlayerID")," \x04님의 \x10테스트맵 \x04인게임 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
			DisplayPrint("CP", {"\x13\x04총 ",PlayTime2[i+1]," 초 이용으로 \x17",PlayTime2[i+1]," 크레딧\x04 지급됨"})
			f_LAdd(FP,Credit[i+1],Credit[i+1],{PlayTime2[i+1],0}) -- 
			
		CIfEnd()
			
		CIfXEnd()
		
		CMov(FP,PStatVer[i+1],StatVer)--저장 여부에 관계없이 로드완료시 스탯버전 항목 초기화
	CIfEnd()
	

	
	local LevelUpJump = def_sIndex()
	CJumpEnd(FP, LevelUpJump)
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],9999,AtMost)},{AddV(PLevel[i+1],1),AddV(CT_PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],1)),TempReadV,nil,nil,1)
	f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], {TempReadV,0})
	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],2)),TempReadV,nil,nil,1)
	f_LAdd(FP, CurEXP[i+1], CurEXP[i+1], {TempReadV,0})
	CAdd(FP,StatP[i+1],5)
	CallTriggerX(FP,Call_Print13[i+1],{CV(PLevel[i+1],9,AtMost)})
	TriggerX(FP, {CV(PLevel[i+1],9,AtMost),LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x1F레벨이 올랐습니다! \x17O 키\x04를 눌러 \x07능력치\x04를 설정해주세요."))}, {preserved})
	CJump(FP, LevelUpJump)
	NIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})

	
	local CTSwitch = CreateCcode()
	NIf(FP,{Deaths(i, Exactly, 1,13),Deaths(i, Exactly, 0,14)},{SetCD(CTSwitch,1)}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
		DoActions(FP,SetDeaths(i, SetTo, 1, 14))--저장
		SCA_DataSave(i,PLevel[i+1],101)
		SCA_DataSave(i,StatP[i+1],102)
		SCA_DataSave(i,Stat_ScDmg[i+1],103)
		SCA_DataSave(i,Stat_TotalEPer[i+1],104)
		SCA_DataSave(i,Stat_TotalEPer2[i+1],105)
		SCA_DataSave(i,Stat_TotalEPer3[i+1],106)
		SCA_DataSave(i,Stat_Upgrade[i+1],107)
		SCA_DataSave(i,Credit[i+1],108)
		SCA_DataSave(i,PEXP[i+1],110)
		SCA_DataSave(i,TotalExp[i+1],112)
		SCA_DataSave(i,CurEXP[i+1],114)
		SCA_DataSave(i,Stat_AddSc[i+1],116)
		SCA_DataSave(i,PStatVer[i+1],117)
		SCA_DataSave(i,PlayTime[i+1],118)
		SCA_DataSave(i,PlayTime2[i+1],119)
		SCA_DataSave(i,CreditAddSC[i+1],120)
		SCA_DataSave(i,LV5Cool[i+1],121)
	NIfEnd()

	CIf(FP,{Deaths(i, Exactly, 0,14),CD(CTSwitch,1)},{SetCD(CTSwitch,0),SetCD(CheatDetect,0)})--세이브 완료후 치팅 검사
	--if TestStart == 1 then
	--	f_LAdd(FP,Credit[i+1],Credit[i+1],"1") -- 진입했냐?
	--end
	f_LMov(FP, CTPEXP, PEXP[i+1])
	CMov(FP, CTPLevel, 1)
	CMov(FP,CTStatP,5)
	CMov(FP,CTStatP2,StatP[i+1])
	f_LMov(FP, CTCurEXP, 0,nil,nil,1)
	f_LMov(FP, CTTotalExp, "10",nil,nil,1)
	CallTrigger(FP,Call_CT)

	CAdd(FP,CTStatP2,_Mul(Stat_ScDmg[i+1],_Mov(Cost_Stat_ScDmg)))
	CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
	CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
	CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
	CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(Cost_Stat_Upgrade)))
	CAdd(FP,CTStatP2,_Mul(Stat_AddSc[i+1],_Mov(Cost_Stat_AddSc)))
	CMov(FP,0x57f0f0+(i*4),CTStatP)--치팅감지시 스탯정보 표기용 미네랄
	CMov(FP,0x57f120+(i*4),CTStatP2)--치팅감지시 스탯정보 표기용 가스
	CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {TTNVar(CTPLevel,NotSame,PLevel[i+1])}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {TTNWar(CTCurEXP,NotSame,CurEXP[i+1])}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {TTNWar(CTTotalExp,NotSame,TotalExp[i+1])}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {Deaths(i,AtLeast,1,98)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {Deaths(i,AtLeast,1,97)}, {SetCD(CheatDetect,1)})
	TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 정상저장 후 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})
	CMov(FP,0x57f0f0+(i*4),0)--치팅감지시 스탯정보 표기용 미네랄 초기화
	CMov(FP,0x57f120+(i*4),0)--치팅감지시 스탯정보 표기용 가스 초기화

	
	CIfEnd()

	
	if TestStart == 1 then
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], "1")
		--f_LMul(FP, PEXP[i+1], PEXP[i+1], "2")
		--f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], "1")
		--f_LMul(FP, TotalExp[i+1], TotalExp[i+1], "2")
	end



	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--기본유닛지급
	if Limit == 1 then 
		CIf(FP,{Deaths(i,AtLeast,1,100),Deaths(i,AtLeast,1,503)})
		CreateUnitStacked({}, 12, LevelUnitArr[40][2], 36+i, 15+i, i)
		--f_LAdd(FP,PEXP[i+1],PEXP[i+1],"500000000")
		CIfEnd()
	end
	
	TriggerX(FP, {Command(i,AtLeast,1,88),CV(ScTimer[i+1],4320)}, {RemoveUnit(88,i)},{preserved}) -- 3분뒤 사라지는 기본유닛
	TriggerX(FP, {CV(ScTimer[i+1],86400)}, {SetV(ResetStat[i+1],1)},{preserved}) -- 1시간뒤 스탯초기화 사용불가
	TriggerX(FP, {CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men"),}, {SetCp(i),DisplayText(StrDesignX("\x04모두 \x08강화에 실패\x04하신 모양이네요... \x0F2강 유닛 1기\x04를 위로 보상으로 지급합니다."), 4),SetCp(FP)}) -- 기본유닛 사라지고 전멸할경우 기회줌
	CreateUnitStacked({CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men")}, 1, LevelUnitArr[2][2], 50+i,36+i, i, nil,1)


	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	for p = 1,6 do
		local NextT = ""
		if p ~= 6 then
			NextT = "\n"..StrDesignX("다음 \x07돈 증가량 \x08업그레이드\x04에 필요한 \x1BDPS\x1F(미네랄)\x04는 \x08"..OreDPS[p+1].." \x04입니다.")
			NextT2 = "\n"..StrDesignX("다음 \x07돈 증가량 \x08업그레이드\x04에 필요한 \x1BDPS\x07(가스)\x04는 \x08"..GasDPS[p+1].." \x04입니다.")
		end
	TriggerX(FP,{Accumulate(i, AtLeast, OreDPS[p], Ore)},{
		SetV(BuildMul1[i+1],OreDPSM[p]),
		SetV(NextOre[i+1],OreDPS[p+1]),
		SetV(NextOreMul[i+1],OreDPSM[p+1]),SetCp(i),
		DisplayText(StrDesignX("건물의 \x1BDPS\x1F(미네랄)\x04가 \x08"..OreDPS[p].." \x04를 돌파하였습니다. \x07돈 증가량\x04이 \x08"..OreDPSM[p].."배\x04로 증가하였습니다.")..NextT),SetCp(FP)})--1번건물
	TriggerX(FP,{Accumulate(i, AtLeast, GasDPS[p], Gas)},{
		SetV(BuildMul2[i+1],GasDPSM[p]),
		SetV(NextGas[i+1],GasDPS[p+1]),
		SetV(NextGasMul[i+1],GasDPSM[p+1]),SetCp(i),
		DisplayText(StrDesignX("건물의 \x1BDPS\x07(가스)\x04가 \x08"..GasDPS[p].." \x04를 돌파하였습니다. \x07돈 증가량\x04이 \x08"..GasDPSM[p].."배\x04로 증가하였습니다.")..NextT2),SetCp(FP)})--2번건물
	end
	
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[15][2])},{SetCp(i),DisplayText(StrDesignX("\x0815강 \x04유닛을 획득하였습니다. \x0815강 \x04유닛부터는 \x17판매\x04를 통해 \x1B경험치\x04를 획득할 수 있습니다.")),SetCp(FP)})
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[26][2])},{SetCp(i),DisplayText(StrDesignX("\x0F26강 \x04유닛을 획득하였습니다. \x0F26강 \x04유닛부터는 \x08보스\x04에 도전할 수 있습니다.")),DisplayText(StrDesignX("\x08보스 \x1C도전 \x07제한시간\x04은 없으며, \x08최대 4기 \x04입장 가능합니다.")),DisplayText(StrDesignX("\x0F26강 \x04유닛부터는 \x17유닛 판매권\x04이 있어야 판매가 가능합니다.")),SetCp(FP)})
	for j,k in pairs(FirstReward) do
		CIfOnce(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetCp(i),DisplayText("\x13\x04！！！　\x07ＲＥＷＡＲＤ\x04　！！！\n\n\n"..StrDesignX("\x08"..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[2]).." \x0FＥＸＰ").."\n\n\n\x13\x04！！！　\x07ＲＥＷＡＲＤ\x04　！！！", 4),SetCp(FP)})
		
		f_LAdd(FP, PEXP[i+1], PEXP[i+1], tostring(k[2]))

		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- 자동저장
		CIfEnd()
	end

	
	local TempO,TempG = CreateVars(2,FP)
	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{Ore,TempO},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas,TempG},Money[i+1])
--	if TestStart == 1 then
--		MinO,MaxO = CreateVars(2, FP)
--		MinG,MaxG = CreateVars(2, FP)
--		CTrigger(FP,{CV(MinO,TempO,AtLeast)},{SetV(MinO,TempO)},1)
--		CTrigger(FP,{CV(MinG,TempG,AtLeast)},{SetV(MinG,TempG)},1)
--		CTrigger(FP,{CV(MaxO,TempO,AtMost)},{SetV(MaxO,TempO)},1)
--		CTrigger(FP,{CV(MaxG,TempG,AtMost)},{SetV(MaxG,TempG)},1)
--		DisplayPrintEr(i, {"\x1F랄네미최소 : ",MinO," \x04|| \x1F랄네미최대 : ",MaxO," \x04|| \x07스가최소 : ",MinG," \x04|| \x07스가최대 : ",MaxG})
--		local temp,PKey = ToggleFunc({KeyPress("V","Up"),KeyPress("V","Down")},nil,1)--누를 경우 초기화
--		CTrigger(FP,{CD(PKey,1)},{SetV(MinO,0xFFFFFFFF)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MinG,0xFFFFFFFF)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MaxO,0)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MaxG,0)},1)
--	end
	
	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)
	DPSBuilding(i,PBossPtr[i+1],"X",nil,{PBossDPS[i+1]},nil)--
	TriggerX(FP, {Accumulate(i, AtLeast, 50000000, Ore),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})

	TriggerX(FP, {Accumulate(i, AtLeast, 100000000, Gas),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})
	TriggerX(FP, {CV(TempO,50000000,AtLeast),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})

	TriggerX(FP, {CV(TempG,100000000,AtLeast),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})



	for j,k in pairs(PBossArr) do
		NIfOnce(FP,{Memory(0x628438,AtLeast,1),CV(PBossPtr[i+1],0),CV(PBossLV[i+1],j-1)})--보스방 건물 세팅
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {CreateUnit(1,k[1],129+i,FP),SetV(PBossPtr[i+1],_Add(Nextptrs,2))})
		CSub(FP,CurCunitI,Nextptrs,19025)
		f_Div(FP,CurCunitI,_Mov(84))
		CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,k[1]))})
		CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
		--CallTrigger(FP, Call_CTInputUID)
		f_LMov(FP,TotalPBossDPS[i+1],k[2])
		--CallTrigger(FP, ResetBDPMArr)
		NIfEnd()
		local ClearJump = def_sIndex()
		NJump(FP,ClearJump,{CV(PBossLV[i+1],j,AtLeast)})
		CIf(FP,{TTNWar(PBossDPS[i+1], AtLeast, TotalPBossDPS[i+1])})
		DoActionsX(FP,{KillUnitAt(All,k[1],119+i,FP),AddV(PBossLV[i+1],1),SetV(PBossPtr[i+1],0),SetNWar(PBossDPS[i+1],SetTo,"0")})

		CIfEnd()
		NJumpEnd(FP,ClearJump)
	end

	
	UnitReadX(FP, i, "Men", 65+i, Income[i+1])
	CIfX(FP,{CV(ScTimer[i+1],4320,AtMost)})
	UnitReadX(FP, i, 88, nil, SCUnits[i+1])
	CSub(FP,Income[i+1],SCUnits[i+1])
	CAdd(FP,IncomeMax[i+1],SCUnits[i+1])
	CElseX()
	CMov(FP,SCUnits[i+1],0)
	CIfXEnd()


	CTrigger(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65+i),Bring(i,AtLeast,1,"Men",15+i)},{MoveUnit(1, "Men", i, 15+i, 22+i),MoveUnit(1, "Factories", i, 22+i, 57+i)},1)--사냥터 입장

	TriggerX(FP, {Bring(i,AtLeast,1,"Men",29+i)}, {MoveUnit(1, "Men", i, 29+i, 36+i)}, {preserved})--사냥터 퇴장

	TriggerX(FP, {CV(BossLV,4,AtMost),Bring(i, AtMost, 3, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--보스방 입장
	TriggerX(FP, {}, {MoveUnit(1, "Factories", i, 111, 36+i)}, {preserved})--보스방 퇴장

	
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 5, "Men", 119+i)}, {MoveUnit(1, "Men", i, 119+i, 22+i)}, {preserved})--개인보스방 입장제한
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 1, 88, 119+i)}, {MoveUnit(1, 88, i, 119+i, 22+i)}, {preserved})--개인보스방 입장제한



	--강화성공한 유닛 생성하기(캔낫씹힘방지)
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], k[1]-1), AtLeast, 1)}, 1, k[2], 50+i,36+i, i, {SetCVAar(VArr(GetUnitVArr[i+1], k[1]-1), Subtract, 1)})
	end

	CallTrigger(FP,Call_BtnInit,{SetV(G_BtnCP,i)})

	
	BtnSetInit(i,ShopUnit) -- 
	CIf(FP,{TMemory(_Add(MenuPtrData[i+1],0x98/4),Exactly,0 + 0*65536)}) -- 배율 올림
	CallTrigger(FP,Call_Print13[i+1])
	CIfX(FP,{CV(MulOp[i+1],10000000-1,AtMost)},{},{preserved})	-- 조건이 만족할 경우
	f_Mul(FP,MulOp[i+1],10)
	CTrigger(FP,{LocalPlayerID(i)},{print_utf8(12,0,StrDesign("\x03System \x04: 배율을 올렸습니다."))},{preserved})
	CElseX()--조건이 만족하지 않을 경우
	CTrigger(FP,{LocalPlayerID(i)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 더 이상 배율을 올릴 수 없습니다."))},{preserved})
	CIfXEnd()
	CIfEnd()
	
	CIf(FP,{TMemory(_Add(MenuPtrData[i+1],0x98/4),Exactly,0 + 1*65536)}) -- 배율 내림
	CallTrigger(FP,Call_Print13[i+1])
	CIfX(FP,{CV(MulOp[i+1],2,AtLeast)},{},{preserved})	-- 조건이 만족할 경우
	f_Div(FP,MulOp[i+1],10)
	CTrigger(FP,{LocalPlayerID(i)},{print_utf8(12,0,StrDesign("\x03System \x04: 배율을 내렸습니다."))},{preserved})
	CElseX()--조건이 만족하지 않을 경우
	CTrigger(FP,{LocalPlayerID(i)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 더 이상 배율을 내릴 수 없습니다."))},{preserved})
	CIfXEnd()
	CIfEnd()--
	CIf(FP,{TMemory(_Add(MenuPtrData[i+1],0x98/4),Exactly,0 + 2*65536)}) -- 싱글플레이 버튼
	CIfX(FP,{Bring(i, AtLeast, 1, 15, 115)},{},{preserved})	-- 조건이 만족할 경우 싱글전환
	CIf(FP,{LocalPlayerID(i),CV(PCheckV,2,AtLeast),CD(SCheck,1)})
	f_Read(FP, 0x628438, nil, Nextptrs)
	TriggerX(FP,{},{CreateUnit(1,94,64,FP),RemoveUnit(94,FP),SetCp(i),DisplayText(StrDesignX("\x08싱글 플레이로 전환합니다. 이 설정은 되돌릴 수 없습니다."),4),SetCp(FP),},{preserved})
	CSub(FP,CurCunitI,Nextptrs,19025)
	f_Div(FP,CurCunitI,_Mov(84))
	CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,94))})
	CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
	--CallTrigger(FP, Call_CTInputUID)
	CIfEnd()
	TriggerX(FP,{LocalPlayerID(i),CV(PCheckV,2,AtLeast),CD(SCheck,0)},{SetCD(SCheck,1),SetCp(i),DisplayText(StrDesignX("\x04정말로 \x08싱글플레이\x04로 \x07전환\x04하시겠습니까? \x08원하시면 한번 더 눌러주세요."),4),SetCp(FP),},{preserved})
	CElseX()--조건이 만족하지 않을 경우
	CallTrigger(FP,Call_Print13[i+1])
	CTrigger(FP,{LocalPlayerID(i)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 시민을 싱글 플레이 설정 위치로 이동한 후 사용가능합니다."))},{preserved})
	CIfXEnd()
	CIfEnd()--

	BtnSetEnd()

	for j, k in pairs(LevelUnitArr) do
		TriggerX(FP, {Command(i,AtLeast,1,k[2])}, {SetCD(AutoEnchArr2[j][i+1],1)})
			
		CIf(FP,MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1))
		CallTriggerX(FP,Call_Print13[i+1],{MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})
		TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)}, {SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0)}, {preserved}) 
		TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1)}, {Order(k[2], i, 36+i, Move, 8+i)}, {preserved})
		CIfEnd()

		CIf(FP,MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1))
		CallTriggerX(FP,Call_Print13[i+1],{MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})
		TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)}, {SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0)}, {preserved})
		TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1)}, {Order(k[2], i, 36+i, Move, 73+i)}, {preserved})
		CIfEnd()
	end
	CIfX(FP, {TCommand(i,AtMost,ULimitV2,"Men"),CV(AutoBuyCode[i+1],1,AtLeast)}) -- 자동구매 관리
	for j, k in pairs(AutoBuyArr) do
		AutoBuy(i,k[1],k[2])
	end
	CElseIfX({TCommand(i,AtLeast,ULimitV,"Men")})
	CallTrigger(FP,Call_Print13[i+1])
	for j = 1, 7 do
		TriggerX(FP, {LocalPlayerID(i),CV(PCheckV,j)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: 보유 유닛수가 너무 많아 유닛 구입할 수 없습니다.\x08 (최대 "..ULimitArr[j].."기)"))},{preserved})
	end

	
	CIfXEnd()
	
	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--키인식부 시작
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"O")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	CIfX(FP,{CV(InterfaceNum[i+1],1)},{})
	for j = 0, 6 do
		TriggerX(FP, {Deaths(i,Exactly,0x10000+j,20)}, {SetDeaths(i,SetTo,1,495+j)}, {preserved})
	end
	KeyFunc(i,"1",{
		{{CV(StatP[i+1],Cost_Stat_ScDmg,AtLeast),CV(Stat_ScDmg[i+1],49,AtMost)},{SubV(StatP[i+1],Cost_Stat_ScDmg),AddV(Stat_ScDmg[i+1],1)},StrDesign("\x07기본유닛\x1B의 데미지가 증가하였습니다.")},
		{{CV(Stat_ScDmg[i+1],50,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x07기본유닛 \x08데미지\x04를 올릴 수 없습니다.")},
		{{CV(StatP[i+1],Cost_Stat_ScDmg-1,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	})
--	if TestStart == 1 then
--		KeyFunc(i,"2",{
--			{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],89,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07유닛 데미지\x04가 \x0810% \x04증가하였습니다.")},
--			{{CV(Stat_Upgrade[i+1],90,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x08데미지\x04를 올릴 수 없습니다.")},
--			{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
--		})
--	else
	KeyFunc(i,"2",{
		{{CV(StatP[i+1],Cost_Stat_AddSc,AtLeast),CV(Stat_AddSc[i+1],4,AtMost)},{SubV(StatP[i+1],Cost_Stat_AddSc),AddV(Stat_AddSc[i+1],1)},StrDesign("\x07기본유닛 갯수\x04가 \x0F1기 \x04증가하였습니다.")},
		{{CV(Stat_AddSc[i+1],5,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x07기본유닛 갯수\x04를 올릴 수 없습니다.")},
		{{CV(StatP[i+1],Cost_Stat_AddSc-1,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	})
--	end
	KeyFunc(i,"3",{
		{{CV(StatP[i+1],Cost_Stat_Upgrade,AtLeast),CV(Stat_Upgrade[i+1],49,AtMost)},{SubV(StatP[i+1],Cost_Stat_Upgrade),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07유닛 데미지\x04가 \x0810% \x04증가하였습니다.")},
		{{CV(Stat_Upgrade[i+1],50,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x08데미지\x04를 올릴 수 없습니다.")},
		{{CV(StatP[i+1],Cost_Stat_Upgrade-1,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	})
	KeyFunc(i,"4",{
		{{CV(StatP[i+1],Cost_Stat_TotalEPer,AtLeast),CV(Stat_TotalEPer[i+1],9999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer),AddV(Stat_TotalEPer[i+1],100)},StrDesign("\x07총 \x08강화 확률\x04이 증가하였습니다.")},
		{{CV(Stat_TotalEPer[i+1],10000,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x07총 \x08강화 확률\x04을 올릴 수 없습니다.")},
		{{CV(StatP[i+1],Cost_Stat_TotalEPer-1,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	})
	KeyFunc(i,"5",{
		{{CV(StatP[i+1],Cost_Stat_TotalEPer2,AtLeast),CV(Stat_TotalEPer2[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer2),AddV(Stat_TotalEPer2[i+1],100)},StrDesign("\x07+2강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다.")},
		{{CV(Stat_TotalEPer2[i+1],5000,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x07+2강 \x08강화확률\x04을 올릴 수 없습니다.")},
		{{CV(StatP[i+1],Cost_Stat_TotalEPer2-1,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	})
	KeyFunc(i,"6",{
		{{CV(StatP[i+1],Cost_Stat_TotalEPer3,AtLeast),CV(Stat_TotalEPer3[i+1],2999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer3),AddV(Stat_TotalEPer3[i+1],100)},StrDesign("\x07+3강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다.")},
		{{CV(Stat_TotalEPer3[i+1],3000,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x10+3강 \x08강화확률\x04을 올릴 수 없습니다.")},
		{{CV(StatP[i+1],Cost_Stat_TotalEPer3-1,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")}, 
	})

	CIf(FP,{Deaths(i, Exactly, 1, 504)})
	CIfX(FP,{CV(ResetStat[i+1],1)})
	CallTrigger(FP,Call_Print13[i+1])
	TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x1F스탯 초기화\x04를 사용할 수 없습니다.")) ,{preserved})

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
		SetV(Stat_AddSc[i+1],0)
	})
	TriggerX(FP, {LocalPlayerID(i)}, {SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1)}, {preserved})
	CMov(FP, StatP[i+1], _Mul(PLevel[i+1], 5))
	
	CallTrigger(FP,Call_Print13[i+1])
	TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x1F스탯 초기화\x04 완료. \x07잠시 후 자동저장됩니다. \x17O 키\x04를 눌러 \x07능력치\x04를 설정해주세요.")) ,{preserved})

	CElseX()
	CallTrigger(FP,Call_Print13[i+1])
	TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다.")) ,{preserved})
	CIfXEnd()
	CIfEnd()

	-- 1, 4000
	-- 2, 4000
	-- 3, 1000
	-- 4, 1000
	-- 5, 10000
	-- 6, 30000

	--KeyFunc(i,"6",{
	--	{{CV(StatP[i+1],5,AtLeast)},{SubV(StatP[i+1],5),AddV(Stat_EXPIncome[i+1],1)},StrDesign("\x07경험치 획등량\x04이 \x0810% \x04증가하였습니다.")},
	--	{{CV(StatP[i+1],0,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	--})
	TriggerX(FP, {MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})
	CIfXEnd()
	DoActions(FP, SetCp(FP))--키인식부 종료

	TriggerX(FP,{CV(InterfaceNum[i+1],0),CV(BrightLoc,30,AtMost),LocalPlayerID(i)},{AddV(BrightLoc,1)},{preserved})
	TriggerX(FP,{CV(InterfaceNum[i+1],1,AtLeast),CV(BrightLoc,14,AtLeast),LocalPlayerID(i)},{SubV(BrightLoc,1)},{preserved})
	CDoActions(FP,{TSetMemory(0x657A9C,SetTo,BrightLoc)})

	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--키인식부
	--TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"P")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	--CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetCp(i),CenterView(72),SetCp(FP)})

	--CIfXEnd()
	DoActions(FP, SetCp(FP))--키인식부 종료






	--총 버프 값 합산
	CMov(FP,Stat_EXPIncome[i+1],0,nil,nil,1)
	CMov(FP,IncomeMax[i+1],12,nil,nil,1)
	CMov(FP,General_Upgrade[i+1],0,nil,nil,1)
	--CMov(FP,IncomeMax[i+1],Stat_ScDmg[i+1],12,nil,1)
	CMov(FP,ScoutDmg[i+1],Stat_ScDmg[i+1],nil,nil,1)
	CMov(FP,TotalEPer[i+1],Stat_TotalEPer[i+1],nil,nil,1)
	CMov(FP,TotalEPer2[i+1],Stat_TotalEPer2[i+1],nil,nil,1)
	CMov(FP,TotalEPer3[i+1],Stat_TotalEPer3[i+1],nil,nil,1)



	CAdd(FP,IncomeMax[i+1],B_IncomeMax)
	CAdd(FP,IncomeMax[i+1],SCUnits[i+1])
	CAdd(FP,TotalEPer[i+1],B_TotalEPer)
	CAdd(FP,TotalEPer2[i+1],B_TotalEPer2)
	CAdd(FP,TotalEPer3[i+1],B_TotalEPer3)
	CAdd(FP,Stat_EXPIncome[i+1],B_Stat_EXPIncome)
	CAdd(FP,General_Upgrade[i+1],Stat_Upgrade[i+1])
	CAdd(FP,General_Upgrade[i+1],B_Stat_Upgrade)--

--	"\x041단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+3",
--	"\x042단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+3",
--	"\x043단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+3, 공격력 + 50%",
--	"\x044단계 \x04: \x0F+1강 확률 \x07+1.5%p, \x1B사냥터 \x07+6, 공격력 + 50%,\x1C추가EXP +10%",
--	"\x045단계 \x04: \x0F+1강 확률 \x07+1.5%p, \x1B사냥터 \x07+9, 공격력 + 100%,\x1C추가EXP +10%",


	--TriggerX(FP,{CountdownTimer(AtLeast, 1)},{AddV(Stat_EXPIncome[i+1],20)},{preserved})--카운트다운 타이머 존재시
Trigger2X(FP,{CV(PBossLV[i+1],1,AtLeast)},{
	AddV(IncomeMax[i+1],3),--사냥터 유닛수 3 증가
	AddV(TotalEPer[i+1],1000),--강화확률 +1.0%p
	
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],2,AtLeast)},{
	AddV(IncomeMax[i+1],3),--사냥터 유닛수 3 증가
	AddV(TotalEPer[i+1],1000),--강화확률 +1.0%p
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],3,AtLeast)},{
	AddV(IncomeMax[i+1],3),--사냥터 유닛수 3 증가
	AddV(TotalEPer[i+1],1000),--강화확률 +1.0%p
	AddV(General_Upgrade[i+1],5),--공격력 50%
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],4,AtLeast)},{
	AddV(IncomeMax[i+1],6),--사냥터 유닛수 6 증가
	AddV(General_Upgrade[i+1],5),--공격력 50%
	AddV(Stat_EXPIncome[i+1],1), --추가EXP +10%
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],5,AtLeast)},{
	AddV(IncomeMax[i+1],9),--사냥터 유닛수 9 증가
	AddV(General_Upgrade[i+1],5),--공격력 50%
	AddV(Stat_EXPIncome[i+1],1), --추가EXP +10%
	
},{preserved})
Trigger2X(FP,{CV(PBossLV[i+1],5,AtLeast),CD(BossRewardEnable,1)},{
	AddV(B_PTicket[i+1],5), --유닛 판매권 5개
	
})

for pb= 1, 5 do
	TriggerX(FP,{LocalPlayerID(i),CV(PBossLV[i+1],pb,AtLeast)},{SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1),SetCp(i),DisplayText(StrDesignX("\x08"..pb.."단계 \x07개인보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4),SetCp(FP)})
end
TriggerX(FP,{CV(PBossLV[i+1],5,AtLeast)},{KillUnitAt(1,13,119+i,FP)})



	if TestStart == 1 then
		TriggerX(FP,{},{SetMemoryB(0x58F32C+(i*15)+13, Add, 15),AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- 인원수 버프 보너스
	else
		
		TriggerX(FP,{NVar(PCheckV,AtLeast,2)},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- 인원수 버프 보너스
	end

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


	for CBit = 0, 7 do -- 8비트 연산을 통한 업글수치 복사
		TriggerX(FP,{NVar(Stat_ScDmg[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+12, Add, 2^CBit)},{preserved})
		TriggerX(FP,{NVar(General_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit)},{preserved})
	end
	--if Limit == 1 then--맵제작자용 치트
	--	CIf(FP,{Deaths(i,AtLeast,1,100)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)})
	--	CMov(FP,IncomeMax[i+1],48,nil,nil,1)
	--	CIfEnd()
	--end

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 91)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)},{preserved})--뎀지 오버플로우 방지
	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)},{}) --  유닛 강화시도하기
	CMov(FP,GEper,TotalEPer[i+1])
	CMov(FP,GEper2,TotalEPer2[i+1])
	CMov(FP,GEper3,TotalEPer3[i+1])
	for j = #LevelUnitArr-1, 1, -1 do
		local LV = LevelUnitArr[j][1]
		local UID = LevelUnitArr[j][2]
		local Per = LevelUnitArr[j][3]
		CallTriggerX(FP, Call_Enchant, {Bring(i,AtLeast,1,UID,8+i)}, {KillUnitAt(1, UID, 8+i, i),SetV(ELevel,LV-1),SetV(UEper,Per),SetV(ECP,i)})
	end
	CIfEnd()

	CIf(FP,{Bring(i,AtLeast,1,"Men",73+i)},{}) --  유닛 판매시도하기
		CIfX(FP,{CV(PLevel[i+1],10000,AtLeast)},{MoveUnit(All,88,i,73+i,80+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 이미 만렙을 달성하여 판매할 수 없습니다..."), 4),SetCp(FP)})
		CElseX()
		CMov(FP,TempEXPV,0)
		for j = #LevelUnitArr, 1, -1 do
			local UID = LevelUnitArr[j][2]
			local EXP = LevelUnitArr[j][4]
			if EXP>=1 then
				if j>=26 then
					TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],0,AtMost)},{MoveUnit(All,UID,i,73+i,43+i),SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: \x17유닛 판매권\x04이 부족합니다... \x07L 키\x04로 보유갯수를 확인해주세요."), 4),SetCp(FP)},{preserved})
					TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],1,AtLeast)},{KillUnitAt(1, UID, 73+i, i),AddV(TempEXPV,EXP),SubV(SellTicket[i+1],1)},{preserved})
					
				else
					TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{KillUnitAt(1, UID, 73+i, i),AddV(TempEXPV,EXP)},{preserved})
				end
			else
				
				--CallTriggerX(FP,Call_Print13[i+1],{Bring(i,AtLeast,1,UID,73+i)})
				TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{MoveUnit(1,UID,i,73+i,80+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 해당 유닛은 판매할 수 없습니다..."), 4),SetCp(FP)},{preserved})
			end

			
		end
		TriggerX(FP,{Bring(i,AtLeast,1,88,73+i)},{MoveUnit(1,88,i,73+i,80+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 해당 유닛은 판매할 수 없습니다..."), 4),SetCp(FP)},{preserved})
        CIf(FP,{CV(TempEXPV,1,AtLeast)})
            f_LAdd(FP, PEXP[i+1], PEXP[i+1], {TempEXPV,0})
            CIf(FP,{CV(Stat_EXPIncome[i+1],1,AtLeast)})
                CAdd(FP,PEXP2[i+1],_Mul(TempEXPV,Stat_EXPIncome[i+1]))
                f_LAdd(FP, PEXP[i+1], PEXP[i+1], {_Div(PEXP2[i+1],_Mov(10)),0})
                f_Mod(FP, PEXP2[i+1], 10)
            CIfEnd()
        CIfEnd()
		CIfXEnd()
	CIfEnd()
	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0),SetCD(ResetStatLoc,0)}) -- CAPrint에 전송할 값들
	CMov(FP,TotalEPerLoc,TotalEPer[i+1])
	CMov(FP,TotalEPer2Loc,TotalEPer2[i+1])
	CMov(FP,TotalEPer3Loc,TotalEPer3[i+1])
	CMov(FP,S_TotalEPerLoc,Stat_TotalEPer[i+1])
	CMov(FP,S_TotalEPer2Loc,Stat_TotalEPer2[i+1])
	CMov(FP,S_TotalEPer3Loc,Stat_TotalEPer3[i+1])
	f_LMov(FP,MoneyLoc,Money[i+1])
	f_LMov(FP,CredLoc,Credit[i+1])
	CMov(FP,IncomeLoc,Income[i+1])
	CSub(FP,IncomeMaxLoc,IncomeMax[i+1],SCUnits[i+1])
	f_Cast(FP,{ExpLoc,0},_LSub(PEXP[i+1], CurEXP[i+1]))
	f_Cast(FP,{TotalExpLoc,0},_LSub(TotalExp[i+1], CurEXP[i+1]))
	CMov(FP,LevelLoc,PLevel[i+1])
	CMov(FP,StatPLoc,StatP[i+1])
	CMov(FP,InterfaceNumLoc,InterfaceNum[i+1])
	TriggerX(FP,{CD(StatEff[i+1],1)},{SetCD(StatEffLoc,1)},{preserved})
	CMov(FP,UpgradeLoc,Stat_Upgrade[i+1])
	CMov(FP,AddScLoc,Stat_AddSc[i+1])
	CMov(FP,LCP,i)
	CMov(FP,ScoutDmgLoc,ScoutDmg[i+1])
	CMov(FP,EXPIncomeLoc,Stat_EXPIncome[i+1])
	CMov(FP,EXPIncomeLoc2,Stat_EXPIncome[i+1])
	
	CMov(FP,PlayTimeLoc,PlayTime[i+1])
	CMov(FP,PlayTimeLoc2,PlayTime2[i+1])
	TriggerX(FP,{CV(ResetStat[i+1],1)},{SetCD(ResetStatLoc,1)},{preserved})
	CMov(FP, UpgradeUILoc, General_Upgrade[i+1])
	CMov(FP,NextOreLoc,NextOre[i+1])
	CMov(FP,NextGasLoc,NextGas[i+1])
	CMov(FP,NextOreMulLoc,NextOreMul[i+1])
	CMov(FP,NextGasMulLoc,NextGasMul[i+1])
	

	CMov(FP,SellTicketLoc,SellTicket[i+1])


	CIfEnd()
	



	CIfEnd()
end
SpeedV = CreateVar(FP)
CIf(FP,{Bring(AllPlayers, AtLeast, 1, 15, 112)})
	for i= 0, 6 do
		--CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,113)},{MoveUnit(1, 15, i, 113, 116)})
		--	CIfX(FP,{CV(SpeedV,0),TTNWar(Credit[i+1], AtLeast, "500")},{SetMemory(0x5124F0,SetTo,13),KillUnit(166, FP),SetV(SpeedV,1),RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04이(가) \x084배속 \x04아이템을 구입하였습니다. 이제부터 \x084배속\x04이 적용됩니다."),4)}, Force1, FP)})
		--		f_LSub(FP, Credit[i+1], Credit[i+1], "500")
		--		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- 자동저장
		--	CElseIfX({CV(SpeedV,1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 이미 구입되었습니다."), 4),SetCp(FP)})
		--	CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
		--	CIfXEnd()
		--CIfEnd()
		--CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,114)},{MoveUnit(1, 15, i, 114, 116)})
		--local NeedSp = def_sIndex()
		--	NJump(FP, NeedSp, {CV(SpeedV,0)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x085배속 \x04아이템을 먼저 구입해주세요."), 4),SetCp(FP)})
		--	CIfX(FP,{CountdownTimer(AtMost, 60*60*48),CV(SpeedV,1),TTNWar(Credit[i+1], AtLeast, "10000")},{SetCountdownTimer(Add, 60*60*12),KillUnit(169, FP)})
		--	TriggerX(FP,{CountdownTimer(AtMost, 0)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04이(가) \x1F5배속 \x04아이템을 구입하였습니다. 이제부터 \x1F카운트다운 타이머 12시간\x04동안 \x1F5배속\x04이 적용됩니다."),4)}, Force1, FP)},{preserved})
		--	TriggerX(FP,{CountdownTimer(AtLeast, 1)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04이(가) \x1F5배속 \x04아이템을 구입하였습니다. \x1F카운트다운 타이머\x04가 \x1F12시간\x04 추가되었습니다."),4)}, Force1, FP)},{preserved})
		--		f_LSub(FP, Credit[i+1], Credit[i+1], "10000")
		--		TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- 자동저장
		--		CElseIfX({CountdownTimer(AtLeast, (60*60*48)+1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 카운트다운 타이머가 너무 많습니다. 지속시간을 소모하고 다시 시도해주세요."), 4),SetCp(FP)})
		--		CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
		--	CIfXEnd()
		--	NJumpEnd(FP, NeedSp)
		--CIfEnd()
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,128)},{MoveUnit(1, 15, i, 128, 116)})

			CIfX(FP,{CV(CreditAddSC[i+1],0),TTNWar(Credit[i+1], AtLeast, "10000")},{SetV(CreditAddSC[i+1],1),SetCp(i),DisplayText(StrDesignX("\x07기본유닛 6기\x04를 구입하셨습니다. \x08주의 \x04: \x07기본유닛\x04은 게임 실행 1회에만 등장하며 3분 뒤 사라집니다."), 4)})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
				f_LSub(FP, Credit[i+1], Credit[i+1], "10000")
			CElseIfX({CV(CreditAddSC[i+1],1,AtLeast),Deaths(i,AtMost,0,99)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 이미 구입되었습니다."), 4),SetCp(FP)})
			CElseIfX({CV(CreditAddSC[i+1],1,AtLeast),Deaths(i,AtLeast,1,99)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 이미 테스트 플레이 특전으로 지급받았습니다."), 4),SetCp(FP)})
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,127)},{MoveUnit(1, 15, i, 127, 116)})
		
			CIfX(FP,{TTNWar(Credit[i+1], AtLeast,_LMul({MulOp[i+1],0}, "100"))},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
				CAdd(FP,SellTicket[i+1],MulOp[i+1])
				f_LSub(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "100"))
				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "100"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07『 \x17유닛 판매권\x04을 ",MulOp[i+1],"개 구입하였습니다. ",TempV," \x17크레딧 \x08사용 \x07』"})
				DisplayPrint(LCP, {"\x13\x07『 \x04현재 ",SellTicket[i+1]," 개의 \x17유닛 판매권 보유중 \x07』"})
				DoActions(FP, {SetCp(i),DisplayText(StrDesignX("\x08주의 \x04: \x17유닛 판매권\x04은 SCA로 저장할 수 없는 항목입니다."))})
				CIfEnd()
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
		
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,126)},{MoveUnit(1, 15, i, 126, 116)})
		
			CIfX(FP,{CV(GeneralPlayTime,4*24*60*60,AtLeast),CV(SellTicket[i+1],MulOp[i+1],AtLeast)},{})
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장


				CSub(FP,SellTicket[i+1],MulOp[i+1])
				
				f_LAdd(FP, Credit[i+1], Credit[i+1], _LMul({MulOp[i+1],0}, "75"))

				CIf(FP,{LocalPlayerID(i)})
				local TempV = CreateVar(FP)
				f_Cast(FP,{TempV,0},_LMul({MulOp[i+1],0}, "75"),nil,nil,1)
				DisplayPrint(LCP, {"\x13\x07『 \x17유닛 판매권\x04을 ",MulOp[i+1],"개 판매하였습니다. ",TempV," \x17크레딧 \x07반환 \x07』"})
				DisplayPrint(LCP, {"\x13\x07『 \x04현재 ",SellTicket[i+1]," 개의 \x17유닛 판매권 보유중 \x07』"})
				CIfEnd()
				
			CElseIfX({CV(GeneralPlayTime,4*24*60*60,AtMost)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: 해당 항목은 \x1F인게임 \x0F4시간 이상 \x04플레이 후 사용가능합니다.."), 4),SetCp(FP)})
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17유닛 판매권\x04이 부족합니다."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()
	end
CIfEnd()

--Trigger2X(FP,{CV(BossLV,5,AtLeast)},{SetCountdownTimer(Add, 60*60*24),RotatePlayer({DisplayTextX(StrDesignX("\x1F보스 LV.5\x04를 클리어하였습니다. 이제부터 \x1F카운트다운 타이머 24시간\x04동안 \x1F5배속\x04이 적용됩니다."),4)}, Force1, FP)})
--if TestStart == 0 then
--	TriggerX(FP,{CountdownTimer(AtLeast, 1)},{SetMemory(0x5124F0,SetTo,0x4)},{preserved})--카운트다운 타이머 존재시
--	TriggerX(FP,{CV(SpeedV,0),CountdownTimer(AtMost, 0)},{SetMemory(0x5124F0,SetTo,0x15)},{preserved})--4배속템 안삿을경우
--	TriggerX(FP,{CV(SpeedV,1),CountdownTimer(AtMost, 0)},{SetMemory(0x5124F0,SetTo,13)},{preserved})--4배속템 삿을경우
--end

CMov(FP,B_Credit,0)
CMov(FP,B_Ticket,0)

--"\x13\x04\x1B- 부록. \x08파티 보스 몬스터 보상 목록 \x1B-",
--"\x041단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+6,",
--"\x042단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+6,\x08공격력 + 50%, \x17크레딧 +500",
--"\x043단계 \x04: \x17크레딧 +1,000, \x1C추가EXP +30%",
--"\x044단계 \x04: \x17유닛 판매권 + 50, \x08공격력 + 50%, ",
--"\x045단계 \x04: \x17크레딧 + \x07자신의 레벨 \x1F*\x17 100\x08(\x17최대 5만 크레딧\x08, 멀티 플레이 시에만 지급)",
--"\x045단계 보스는 \x072인 이상 플레이\x04가 아니면 \x08공략 불가능합니다."

Trigger2X(FP,{CV(BossLV,1,AtLeast)},{
	AddV(B_IncomeMax,6),--사냥터 유닛수 6 증가
	AddV(B_TotalEPer,1000),--강화확률 +1.0%p
	SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayTextX(StrDesignX("\x081단계 파티보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,2,AtLeast)},{
	AddV(B_IncomeMax,6),--사냥터 유닛수 6 증가
	AddV(B_TotalEPer,1000),--강화확률 +1.0%p
	AddV(B_Credit,500),--크레딧 200
	AddV(B_Stat_Upgrade,5),
	SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayTextX(StrDesignX("\x082단계 파티보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,3,AtLeast)},{
	AddV(B_Credit,1000),--크레딧 1000
	AddV(B_Stat_EXPIncome,3), -- 판매시 경험치 30% 증가
	SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayTextX(StrDesignX("\x083단계 파티보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,4,AtLeast)},{
	AddV(B_Stat_Upgrade,5),
	AddV(B_Ticket,50);
	SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayTextX(StrDesignX("\x084단계 파티보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4)}, Force1, FP)
})
Trigger2X(FP,{CV(BossLV,5,AtLeast)},{
	SetV(Time,(30000*5)-5000),SetCD(SaveRemind,1),RotatePlayer({DisplayTextX(StrDesignX("\x085단계 파티보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4)}, Force1, FP)
})

CIfOnce(FP,{CV(BossLV,5,AtLeast)})

	for i = 0, 6 do
		CIf(FP,{HumanCheck(i, 1)},{AddV(LV5Cool[i+1],60*60*6)})
		CMov(FP,B_PCredit[i+1],_Mul(PLevel[i+1],_Mov(100)))
		TriggerX(FP,{CV(B_PCredit[i+1],50000,AtLeast)},{SetV(B_PCredit[i+1],50000)},{preserved})
		CIfEnd()
	end
CIfEnd()




function TEST() 
	local PlayerID = CAPrintPlayerID 
	local LVData = {{{0,9},{"０",{0x1000000}}}} 
	local StatEffT = CreateCcode()
	local InterfaceNumLoc2 = CreateCcode()
	DoActionsX(FP,AddCD(StatEffT,1))
	
	CA__SetValue(Str1,"\x07보유금액 \x04:  0000\x04경0000\x04조0000\x04억0000\x04만0000 \x04원\x12\x07사냥터\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
	--43
	--49
	CS__ItoCustom(FP,SVA1(Str1,40),IncomeLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
	CS__ItoCustom(FP,SVA1(Str1,46),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x190",0x19,{0,1})
	CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1C,0x1C,0x1C,0x1C,0x03,0x03,0x03,0x03},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0}})

	--CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x04,0x04,0x04},{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x07ＬＶ．\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04－\x0FＥＸＰ\x04：",nil,1)
	
	CS__ItoCustom(FP,SVA1(Str1,4),LevelLoc,nil,nil,{10,5},1,nil,"\x1B0",0x1B,nil, LVData)
	local Tabkey = KeyToggleFunc2("TAB","LCTRL")
	CIfX(FP,{CD(Tabkey,1)})--수치표기
	CIfX(FP,{CV(LevelLoc,9999,AtMost)})
	CElseX({SetV(ExpLoc,0)})
	CIfXEnd()
	CA__ItoCustom(SVA1(Str1,16),ExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
	CA__Input(MakeiStrData("\x08／",1),SVA1(Str1,28))
	CA__ItoCustom(SVA1(Str1,30),TotalExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
	CElseX()--퍼센트표기
	local CurExpTmp = CreateVar(FP)
	CIfX(FP,{CV(LevelLoc,9999,AtMost)})
	f_Mul(FP,CurExpTmp,ExpLoc,20)
	f_Div(FP,CurExpTmp,TotalExpLoc)
	CElseX({SetV(CurExpTmp,20)})
	CIfXEnd()
	CA__SetValue(Str1,"\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x17(Ctrl+TAB:세부값)",nil,16)
	for i = 0, 19 do
		CS__InputTA(FP,{CV(CurExpTmp,i+1,AtLeast)},SVA1(Str1,16+i),0x07,0xFF)
	end
	CIfXEnd()
	TriggerX(FP,{CD(StatEffLoc,1),CD(StatEffT,2,AtLeast)},{SetCD(StatEffT,0),SetCSVA1(SVA1(Str1,0),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,1),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,2),SetTo,0x04,0xFF)},{preserved})
	CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x12포인트 :  000,000 | 크레딧 \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123",nil,1)
	CA__lItoCustom(SVA1(Str1,25),CredLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x05,0x05,0x05}
	,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CS__ItoCustom(FP,SVA1(Str1,8),StatPLoc,nil,nil,{10,6},1,nil,"\x1B0",0x1B,{0,1,2,4,5,6}, nil,{0,0,{0},0,0,{0}})

	

	CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-2)
	CIfX(FP,{CD(Tabkey,1)})--수치표기
	CA__SetColor((56*2)+1, 0x17)
	CElseX()--퍼센트표기
	CA__SetColor((56*2)+1, 0x10)
	CIfXEnd()
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	


CA__SetMemoryX((56*3)-1,0x0D0D0D0D,0xFFFFFFFF,1)
	end 
	CAPrint(iStr1,{Force1},{1,0,0,0,1,1,0,0},"TEST",FP,{}) 

	DoActions(FP,{SetMemory(0x58F504, SetTo, 0)})
	CIfX(FP,{CV(InterfaceNumLoc,1)},{}) -- 상점 페이지 제어
	CMov(FP,MCP,LCP)
	CallTriggerX(FP,Call_SetScrMouse,{},{})
	mmX = mouseX -- 상대좌표 좌측정렬
	mmY = mouseY
	mmX2 = screenX -- 중앙정렬
	mmX3 = screenX2 -- 중앙정렬
	if TestStart == 1 then
		--DisplayPrintEr(0, {"상대좌표 X : ", mmX, "  Y : ", mmY, " || 중앙정렬 X : ", mmX2, "  Y : ", mmY," || 우측정렬 X : ",mmX3,"  Y : ",mmY});
	end
	
local E1VarArr1 = CreateVarArr(6, FP)
local E2VarArr1 = CreateVarArr(6, FP)
local E3VarArr1 = CreateVarArr(6, FP)
for i = 1, 6 do
	Byte_NumSet(S_TotalEPerLoc,E1VarArr1[i],10^(6-i),1,0x30)
	Byte_NumSet(S_TotalEPer2Loc,E2VarArr1[i],10^(6-i),1,0x30)
	Byte_NumSet(S_TotalEPer3Loc,E3VarArr1[i],10^(6-i),1,0x30)
end
SetEPerStr(E1VarArr1)
SetEPerStr(E2VarArr1)
SetEPerStr(E3VarArr1)
E1VarArr2 = {E1VarArr1[1],E1VarArr1[2],E1VarArr1[3]}
E2VarArr2 = {E2VarArr1[1],E2VarArr1[2],E2VarArr1[3]}
E3VarArr2 = {E3VarArr1[1],E3VarArr1[2],E3VarArr1[3]}
E1VarArr3 = {E1VarArr1[4],E1VarArr1[5],E1VarArr1[6]}
E2VarArr3 = {E2VarArr1[4],E2VarArr1[5],E2VarArr1[6]}
E3VarArr3 = {E3VarArr1[4],E3VarArr1[5],E3VarArr1[6]}
BColor = CreateVarArr(6,FP)
BColor2 = CreateVarArr(6,FP)
BColor3 = CreateVarArr(6,FP)
MToggle = CreateCcodeArr(6)
MToggle2 = CreateCcodeArr(6)
local ESCB = CreateVar(FP)
local BAct = {}
for j,p in pairs({0x04,0x1C,0x08,0x0F,0x0F,0x0F}) do
	table.insert(BAct,SetV(BColor[j],p))
	table.insert(BAct,SetV(BColor2[j],0x04))
	table.insert(BAct,SetV(BColor3[j],0x1F))
	table.insert(BAct,SetCD(MToggle[j],0))
	table.insert(BAct,SetCD(MToggle2[j],0))
end
table.insert(BAct,SetV(ESCB,0x08))
DoActions2X(FP, BAct)
local CDFncArr={}
--296~310 각 스탯찍기 버튼
--274~388 상대좌표 나가기버튼

local MStat,CDFnc2 = ToggleFunc({Memory(0x6CDDC0,Exactly,0),Memory(0x6CDDC0,Exactly,2)},1)--
TriggerX(FP,{MLine(mmY,4),VRange(mmX, 274, 388)},{SetV(ESCB,0x07)},{preserved})
TriggerX(FP,{MLine(mmY,4),VRange(mmX, 274, 388),CD(MStat,1)},{SetV(ESCB,0x1B)},{preserved})
TriggerX(FP,{MLine(mmY,4),VRange(mmX, 274, 388),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000)},{preserved})

	for i = 0, 5 do
		TriggerX(FP,{MLine(mmY,6+i)},{SetV(BColor[i+1],0x07),SetV(BColor3[i+1],0x0E),SetCD(MToggle[i+1],1)},{preserved})
		TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 296, 310)},{SetV(BColor2[i+1],0x07),SetCD(MToggle2[i+1],1)},{preserved})

		local temp,CDFnc = ToggleFunc({CD(MToggle[i+1],0),CD(MToggle[i+1],1)})--
		TriggerX(FP,{CD(MToggle2[i+1],1),CD(MStat,1)},{SetV(BColor2[i+1],0x08)},{preserved})
		TriggerX(FP,{KeyPress(tostring(i+1), "Down")},{SetV(BColor2[i+1],0x08)},{preserved})
		TriggerX(FP,{CD(CDFnc,1)},{SetMemory(0x58F504,SetTo,i+1)},{preserved})
		TriggerX(FP,{CD(MToggle2[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000+i+1)},{preserved})
	end
	CMul(FP,UpgradeLoc,10)
	CMul(FP,ScoutDmgLoc,100)
	DisplayPrint(LCP, {"\x07능력치 \x04설정. \x10숫자키 또는 마우스클릭\x04으로 \x07업그레이드. ",ESCB[2],"[나가기 클릭 또는 ESC]\x12\x1C보유 포인트 :\x07 ",StatPLoc})
	TriggerX(FP, CD(ResetStatLoc,0), {DisplayText("\x1F[스탯초기화 \x175000크레딧 \x081시간이내 1회만 \x04Ctrl+O\x1F] \x1F사용가능", 4)}, {preserved})
	TriggerX(FP, CD(ResetStatLoc,1), {DisplayText("\x1F[스탯초기화 \x175000크레딧 \x081시간이내 1회만 \x04Ctrl+O\x1F] \x08사용불가", 4)}, {preserved})
	DisplayPrint(LCP, {"\x071. \x07기본유닛 \x08데미지 \x04+100 \x08(최대 5000) - ",BColor3[1][2],Cost_Stat_ScDmg.." Pts\x12\x07 + ",BColor[1][2],ScoutDmgLoc," \x0D\x0D\x0D",BColor2[1][2],"[+]"})
	DisplayPrint(LCP, {"\x072. \x07추가 기본유닛 \x041기 증가 \x04최대 5기 - ",BColor3[2][2],Cost_Stat_AddSc.." Pts\x12\x07+ ",BColor[2][2],AddScLoc," 기 ",BColor2[2][2],"[+]"})
	DisplayPrint(LCP, {"\x073. \x1B보유 유닛 \x08데미지 \x04증가 \x07+10% \x08(최대 +500%) - ",BColor3[3][2],Cost_Stat_Upgrade.." Pts\x12\x07+ ",BColor[3][2],UpgradeLoc," % ",BColor2[3][2],"[+]"})
	DisplayPrint(LCP, {"\x074. \x07+1 \x08강화확률 \x0F0.1%p \x08MAX 100 \x04- ",BColor3[4][2],Cost_Stat_TotalEPer.." Pts\x12\x07+ ",BColor[4][2],E1VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E1VarArr3," %p ",BColor2[4][2],"[+]"})
	DisplayPrint(LCP, {"\x075. \x0F+2 \x08강화확률 \x0F0.1%p \x08MAX 50 \x04- ",BColor3[5][2],Cost_Stat_TotalEPer2.." Pts\x12\x07+ ",BColor[5][2],E2VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E2VarArr3," %p ",BColor2[5][2],"[+]"})
	DisplayPrint(LCP, {"\x076. \x10+3 \x08강화확률 \x0F0.1%p \x08MAX 30 \x04- ",BColor3[6][2],Cost_Stat_TotalEPer3.." Pts\x12\x07+ ",BColor[6][2],E3VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E3VarArr3," %p ",BColor2[6][2],"[+]"})


	CIfXEnd()
	DoActions(FP,{SetCp(FP)})
	local StatPrintEr = {
		StrDesign("\x04게임 시작시 처음 지급하는 \x07기본유닛(스카웃) \x08데미지\x04를 증가시킵니다. \x08주의 \x04: \x07기본유닛\x04은 3분 뒤 사라집니다."),
		StrDesign("\x04게임 시작시 처음 지급하는 \x07기본유닛(스카웃) \x0F갯수\x04를 증가시킵니다. \x08주의 \x04: \x07기본유닛\x04은 3분 뒤 사라집니다."),
		StrDesign("\x04자신의 \x07강화 \x04유닛 \x08데미지\x04를 증가시킵니다."),
		StrDesign("\x07+1\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: \x07+2, \x10+3 \x04강화확률에 대한 영향은 \x08없습니다."),
		StrDesign("\x07+2\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0F35강 \x04유닛 이상부터 +1만 적용됩니다."),
		StrDesign("\x10+3\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0F36강 \x04유닛 이상부터 +1만 적용됩니다."),
}

	for i = 0,6 do
		CIf(FP,{HumanCheck(i, 1)})
			CallTriggerX(FP,Call_Print13[i+1],{Deaths(i,AtLeast,1,20),Deaths(i,AtMost,0x10000-1,20)})
			for j = 1, 6 do
				TriggerX(FP, {LocalPlayerID(i),Deaths(i,Exactly,j,20)}, {print_utf8(12,0,StatPrintEr[j])}, {preserved})
			end
		CIfEnd()
	end
	
	
CIf(FP,{CV(InterfaceNumLoc,0)})--아무 설정창도 켜져있지 않을 경우 작동함
local temp,PKey = ToggleFunc({KeyPress("P","Up"),KeyPress("P","Down")},nil,1)--누를 경우 현재 적용중인 버프 상세 표기
local temp,KKey = ToggleFunc({KeyPress("K","Up"),KeyPress("K","Down")},nil,1)--누를 경우 현재 보유 재화 표시
local LKey = KeyToggleFunc("L") --지속적으로 표기함
local temp,BKey = ToggleFunc({KeyPress("B","Up"),KeyPress("B","Down")},nil,1)--누를 경우 설명서 출력
local temp,NKey = ToggleFunc({KeyPress("N","Up"),KeyPress("N","Down")},nil,1)--누를 경우 설명서 출력
local temp,MKey = ToggleFunc({KeyPress("M","Up"),KeyPress("M","Down")},nil,1)--누를 경우 설명서 출력
local LToggle = CreateCcode()
CTrigger(FP,{CD(PKey,1)},{SetCD(LKey,0)},1)
CTrigger(FP,{CD(KKey,1)},{SetCD(LKey,0)},1)
TriggerX(FP,{CD(BKey,1)},{SetCD(LKey,0)},{preserved})
TriggerX(FP,{CD(NKey,1)},{SetCD(LKey,0)},{preserved})
TriggerX(FP,{CD(MKey,1)},{SetCD(LKey,0)},{preserved})
CTrigger(FP,{CD(PKey,0),CD(KKey,0),CD(LToggle,0),CD(LKey,0)},{SetCD(LToggle,1),TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n",4)},1)
CTrigger(FP,{CD(LToggle,0),CD(LKey,0)},{SetCD(LToggle,1)},1)
--CTrigger(FP,{CD(LToggle,0),CD(LKey,1)},{SetCD(LToggle,1),TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n\n",4)},1)
CIf(FP,{CD(PKey,1)},{SetCD(LKey,0)})

for i = 1, 6 do
	Byte_NumSet(TotalEPerLoc,E1VarArr1[i],10^(6-i),1,0x30)
	Byte_NumSet(TotalEPer2Loc,E2VarArr1[i],10^(6-i),1,0x30)
	Byte_NumSet(TotalEPer3Loc,E3VarArr1[i],10^(6-i),1,0x30)
end
SetEPerStr(E1VarArr1)
SetEPerStr(E2VarArr1)
SetEPerStr(E3VarArr1)
E1VarArr2 = {E1VarArr1[1],E1VarArr1[2],E1VarArr1[3]}
E2VarArr2 = {E2VarArr1[1],E2VarArr1[2],E2VarArr1[3]}
E3VarArr2 = {E3VarArr1[1],E3VarArr1[2],E3VarArr1[3]}
E1VarArr3 = {E1VarArr1[4],E1VarArr1[5],E1VarArr1[6]}
E2VarArr3 = {E2VarArr1[4],E2VarArr1[5],E2VarArr1[6]}
E3VarArr3 = {E3VarArr1[4],E3VarArr1[5],E3VarArr1[6]}
DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07+1 \x08강화확률 \x04총 증가량 : \x07+ \x0F",E1VarArr2,".",E1VarArr3,"%p"})
DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07+2 \x08강화확률 \x04총 증가량 : \x07+ \x0F",E2VarArr2,".",E2VarArr3,"%p"})
DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x10+3 \x08강화확률 \x04총 증가량 : \x07+ \x0F",E3VarArr2,".",E3VarArr3,"%p"})
f_Mul(FP,EXPIncomeLoc2,10)
DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x1C경험치 \x07추가 \x04획득량 : \x07+ \x1C",EXPIncomeLoc2,"%"})
f_Mul(FP,UpgradeUILoc,10)
DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07총 \x08공격력 \x04증가량 : \x07+ \x08",UpgradeUILoc,"%"})




CIf(FP,{CV(PlayTimeLoc2,1,AtLeast)})
CMov(FP,CTimeV,PlayTimeLoc2)
CallTrigger(FP,Call_ConvertTime)
DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07테스트 버전 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
CIfEnd()

CMov(FP,CTimeV,PlayTimeLoc)
CallTrigger(FP,Call_ConvertTime)
DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07총 인게임 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초\n"})





CIfEnd()
CIf(FP,{CD(KKey,1)},{SetCD(LKey,0)})

	CIf(FP,CV(NextOreLoc,1,AtLeast))
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 사냥터 \x0ELV.1 \x07돈 증가량 ",NextOreMulLoc," \x08업그레이드\x04에 필요한 \x1BDPS\x1F(미네랄)\x04 : \x1F",NextOreLoc})
	CIfEnd()

	CIf(FP,CV(NextGasLoc,1,AtLeast))
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 사냥터 \x0FLV.2 \x07돈 증가량 ",NextGasMulLoc," \x08업그레이드\x04에 필요한 \x1BDPS\x07(가스)\x04 : \x07",NextGasLoc,"\n\n\n\n\n\n\n"})
	CIfEnd()

CIfEnd()

CIfX(FP,{CD(LKey,1)})
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x17유닛 판매권 \x04보유 갯수 \x08(저장안됨) \x04: \x07",SellTicketLoc," \x17닫기 \x04: \x10L"})
	for i = 0, 6 do
		CIf(FP,HumanCheck(i, 1))
		CIf(FP,{CV(LV5Cool[i+1],(60*60*6)+1,AtLeast)})
		f_Mod(FP,LV5Cool[i+1],60*60*6)
		CIfEnd()

		CIfX(FP,{CV(LV5Cool[i+1],1,AtLeast)})
		CMov(FP,CTimeV,LV5Cool[i+1])
		CallTrigger(FP,Call_ConvertTime)
		DisplayPrint(LCP, {PName(i)," \x04님의 \x1F보스 LV.5 \x04처치 가능까지 남은 시간 \x04: \x07",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초  \x17닫기 \x04: \x10L"})
		CElseX()
		DisplayPrint(LCP, {PName(i)," \x04님의 \x1F보스 LV.5 \x04처치 가능까지 남은 시간 \x04: \x07처치 가능!  \x17닫기 \x04: \x10L"})
		CIfXEnd()

		CIfEnd()
	end
	CTrigger(FP,{CD(LToggle,1)},{SetCD(LToggle,0),TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n",4)},1)
CIfXEnd()


local PageNumLoc = CreateVar(FP)
--local NKey = KeyToggleFunc("N")
local TG = CreateCcode()
local TG2 = CreateCcode()
local PageT = {
	{--1페이지
		"\x13\x04\x1FDPS 강화하기 게임에 오신것을 환영합니다.",
		"\x13\x04이 게임은 \x08사냥터의 건물을 공격\x04하여 돈을 번 후 \x0F자신의 유닛을 강화\x04하며 총 DPS를 강화하는 게임입니다.",
		"\x13\x04맨 처음 게임을 시작하시면 기본유닛이 사냥터 건물을 공격할 것입니다.",
		"\x13\x04\x08해당유닛이 공격한 데미지량\x04에 따라 \x1F돈을 벌 수 있습니다.",
		"\x13\x04벌은 돈을 통해, \x17자기 자신 영역에 위치한 \x10우라즈 크리스탈\x04에서 유닛을 구입할 수 있습니다.(유닛 이름 확인)",
		"\x13\x04마찬가지로 구입한 유닛을 사냥터에 보내 돈을 벌거나, 상단에 위치한 곳으로 이동시켜 강화할 수 있습니다.",
		"\x13\x04만약 모든 유닛과 전재산을 잃을 경우 \x08게임 진행이 불가능\x04할 수 있으니 유의하시기 바랍니다.",
	},
	{--2페이지
		"\x13\x04\x1B- \x03사냥터 \x1B-",
		"\x13\x04\x03사냥터\x04에서 \x08건물을 공격\x04할 경우 \x1F돈이 지급될 것입니다.",
		"\x13\x04LV.1 건물은 1~25강 유닛, LV.2 건물은 26~40강 유닛으로 입장 가능하며",
		"\x13\x04각각의 건물에 대한 DPS는 \x1F미네랄\x04, \x07가스\x04로 확인합니다.",
		"\x13\x04각 레벨의 건물은 일정 DPS를 달성할 경우 돈 지급량이 증가합니다.",
	},
	{
		"\x13\x04\x1B- \x08기준 확률\x1B -",
		"\x13\x04\x08기준확률\x04이란 강화성공시 +1 단계 증가 확률이 기준점이라는 뜻이며",
		"\x13\x04기본적으로 \x0F+2강 증가 확률은 \x08기준확률\x04의 1/10, \x1F+3강 증가 확률 1/100 \x04가 부여됩니다.",
		"\x13\x04예 : \x08기준확률\x04이 50.0%일 경우 \x0F+2강 확률은 5.0% \x1F+3강 확률은 0.5% \x05실패확률은 44.5%",
		"\x13\x04\x1937~40강 유닛\x04의 경우 위의 +2, +3강 확률이 \x08적용되지 않고 \x04+1강 확률로 적용됩니다.",
		"\x13\x04각 유닛에 대한 강화확률은 \x1C유닛 공격무기의 좌측 아이콘\x04에서 확인할 수 있으며",
		"\x13\x04다른 플레이어의 유닛 강화 확률도 같은 방법으로 확인 가능합니다."
	},
	{
		"\x13\x04\x1B- 레벨 시스템, \x19SCA 런쳐 \x1B-",
		"\x13\x04이 게임에는 \x1B레벨 시스템\x04이 존재합니다.",
		"\x13\x04특정 강화단계 이상 유닛은 \x1E판매를 통해 경험치\x04를 획득할 수 있습니다.",
		"\x13\x04획득한 경험치를 통해 레벨업을 할 경우 \x1FO 키를 입력\x04하여 스탯포인트를 분배하면 \x11각종 이로운 효과\x04를 얻을 수 있습니다.",
		"\x13\x04이 항목은 \x19SCA런쳐\x04를 통해 저장 가능하며 다음 게임에서 적용 가능합니다.",
		"\x13\x04현재 적용중인 버프 목록은 \x1FP 키\x04를 통해 확인 가능합니다.",
		"\x13\x04현재 \x07SCA로 저장 가능한 항목\x04은 레벨, 분배한 스탯, 경험치, 크레딧 보유량 등이며 \x08그 외의 항목은 저장할 수 없습니다.",
		"\x13\x04\x07현실시간 1분 경과시마다 자동 저장\x04되며, 수동 저장을 원하실 경우 \x17F9 버튼\x04을 누르면 수동저장됩니다.",
	},
	{
		"\x13\x04\x1B- 레벨 시스템 2 -",
		"\x13\x0426강 이후 유닛부터는 판매시 경험치가 대폭 증가하지만 \x17유닛 판매권\x04이 필요합니다.",
		"\x13\x04유닛 판매권은 100크레딧 당 1개로 구입하거나 5단계 개인보스 공략으로 얻을 수 있습니다.",
		"\x13\x04\x17유닛 판매권\x04이 없으면 \x08유닛을 판매할 수 없습니다.",
		"\x13\x04또한 \x17유닛 판매권\x08은 SCA 저장 불가능 아이템\x04입니다. 종료 전 모두 소모하는것을 권장드립니다.",
	},

	{
		"\x13\x04\x1B- 부록. \x0E다인 플레이 보너스, 보스 시스템 \x1B-",
		"\x13\x04이 게임에는 \x0E다인 플레이 보너스 버프\x04가 존재합니다. 처음 하시는 분들은 2인 이상 플레이를 \x08매우 권장합니다.",
		"\x13\x04\x1F2~7인 보너스 버프 \x1C- \x08공격력 + 100%\x04, \x07+1강 \x17강화확률 + \x0F1.0%p",
		"\x13\x04\x08개인 보스 몬스터 \x04지역은 25강 이하 유닛만 개인별로 공략 가능하며 \x0F1초간의 데미지(DPS)\x04으로 클리어 여부를 결정합니다.",
		"\x13\x04\x08보스 몬스터 \x04지역은 26강 유닛부터 입장 가능하며 \x081분간의 데미지(DPM)\x04으로 클리어 여부를 결정합니다.",
	},

--남는거 공 250% 강확은 논외
	{
		"\x13\x04\x1B- 부록. \x08개인 보스 몬스터 보상 목록 \x1B-",
		"\x041단계 \x04: \x0F+1강 확률 \x07+1.0%p \x1B사냥터 \x07+3",
		"\x042단계 \x04: \x0F+1강 확률 \x07+1.0%p \x1B사냥터 \x07+3",
		"\x043단계 \x04: \x0F+1강 확률 \x07+1.0%p \x1B사냥터 \x07+3, \x08공격력 + 50%",
		"\x044단계 \x04: \x1B사냥터 \x07+6, \x08공격력 + 50%, \x1C추가EXP +10%",
		"\x045단계 \x04: \x1B사냥터 \x07+9, \x08공격력 + 50%, \x1C추가EXP +10%, \x17유닛 판매권 5개",
		"\x045단계 보스 보상인 \x17유닛 판매권\x04은\x07 2인 이상 플레이 \x04혹은 \x082인이상 플레이를 1시간 유지한 후 솔로 플레이 \x04시 획득 가능합니다."
	},

	{
		"\x13\x04\x1B- 부록. \x08파티 보스 몬스터 보상 목록 \x1B-",
		"\x041단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+6,",
		"\x042단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+6,\x08공격력 + 50%, \x17크레딧 +500",
		"\x043단계 \x04: \x17크레딧 +1,000, \x1C추가EXP +30%",
		"\x044단계 \x04: \x17유닛 판매권 + 50, \x08공격력 + 50%, ",
		"\x045단계 \x04: \x17크레딧 + \x07자신의 레벨 \x1F*\x17 100\x08(\x17최대 5만 크레딧)",
		"\x045단계 보스는 공략후 \x088시간의 인게임 쿨타임\x04이 존재합니다."
	},
}
CIf(FP,TTOR({CD(BKey,1),CD(NKey,1),CD(MKey,1)}))
TriggerX(FP,{CD(NKey,1)},{SetCD(TG2,1)},{preserved})
TriggerX(FP,{CD(BKey,1)},{SubV(PageNumLoc,1),SetCD(TG,1)},{preserved})
TriggerX(FP,{CD(MKey,1)},{AddV(PageNumLoc,1),SetCD(TG,1)},{preserved})
TriggerX(FP,{CD(TG2,1),CD(TG,0),CD(NKey,1)},{SetCD(TG,1),SetCD(TG2,0)},{preserved})
TriggerX(FP,{CD(TG2,1),CD(TG,1),CD(NKey,1)},{SetCD(TG,0),SetCD(TG2,0)},{preserved})



TriggerX(FP,{CV(PageNumLoc,0)},{SetV(PageNumLoc,1)},{preserved})
TriggerX(FP,{CV(PageNumLoc,#PageT+1,AtLeast)},{SetV(PageNumLoc,#PageT)},{preserved})
CIf(FP,CD(TG,1))
DisplayPrint(LCP, {"\x13\x04[\x0FPrev \x04: \x17B\x04] [\x07Page \x04: \x10",PageNumLoc," \x08열기/닫기\x04 : \x17N\x04] [\x11Next \x04: \x17M\x04]"})
for j,k in pairs(PageT) do
	local t = {}
	for i = 1, 7 do
		if k[i]~= nil then
			t[i] = k[i].."\n"
		else
			t[i] = "\n"
		end
	end
	TriggerX(FP, {CV(PageNumLoc,j)}, {DisplayText(table.concat(t), 4)}, {preserved})
end
CIfEnd()
CTrigger(FP,{CD(TG,0)},{TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n\n",4)},1)


CIfEnd()


CIfEnd()

CMov(FP,0x6509B0,FP)
FixText(FP, 2)







local BossEPD = CreateVar(FP)
local BossDPM = CreateWar(FP)
local DPSArr2 = CreateArr(1441, FP)
local DPSCheckV = CreateVar(FP)
local DpsDest = CreateVar(FP)
local DPSCheck = CreateCcode()
local DPSCheck2 = CreateVar(FP)
local TotalDPM = CreateWar(FP)
CIf(FP,CV(BossEPD,19025,AtLeast),AddCD(DPSCheck,1))
local BossClearCheck = def_sIndex()
NJump(FP, BossClearCheck, {TMemoryX(_Add(BossEPD,17), Exactly, 0, 0xFF00)}, {SetV(BossEPD,0)})

TriggerX(FP,{CV(DPSCheck2,1440,AtLeast)},{SetV(DPSCheck2,0)},{preserved})



CIfX(FP,{TMemory(BossEPD,AtMost,8319999*256)})
f_Read(FP, BossEPD, DPSCheckV)
CMov(FP,DpsDest,_Sub(_Mov(8320000*256),DPSCheckV))
CTrigger(FP,{},{TSetMemory(BossEPD,SetTo,8320000*256)},1)
CrShift(FP, DpsDest, 8)
CElseX()
CMov(FP,DpsDest,0)
CIfXEnd()

if TestStart == 1 then
	--CMov(FP,0x57f0f0,DpsDest)
	--CMov(FP,0x57f120,_Read(ArrX(DPSArr2,DPSCheck2)))
end
f_LMov(FP,TotalDPM,_LAdd(TotalDPM,{DpsDest,0}))
f_LMov(FP,TotalDPM,_LSub(TotalDPM,{_Read(ArrX(DPSArr2,DPSCheck2)),0}))
CMovX(FP,ArrX(DPSArr2,DPSCheck2),DpsDest,nil,nil,nil,1)
DoActionsX(FP,{AddV(DPSCheck2,1)})
NJumpEnd(FP, BossClearCheck)
CIfEnd()

BossFuncJump = def_sIndex()
CJump(FP, BossFuncJump)
ResetBDPMArr=SetCallForward()
SetCall(FP)

f_LMov(FP,TotalDPM,"0")
CFor(FP, 0, 1441, 1)
local CI = CForVariable()
CMovX(FP,ArrX(DPSArr2,DPSCheck2),DpsDest,nil,nil,nil,1)
CMov(FP,ArrX(DPSArr2,CI),0,nil,nil,1)
CForEnd()



SetCallEnd()
CJumpEnd(FP, BossFuncJump)
for j,k in pairs(BossArr) do
	NIfOnce(FP,{Memory(0x628438,AtLeast,1),CV(BossEPD,0),CV(BossLV,j-1)})--보스방 건물 세팅
	f_Read(FP, 0x628438, nil, Nextptrs)
	CDoActions(FP, {CreateUnit(1,k[1],110,FP),SetV(BossEPD,_Add(Nextptrs,2))})
	CSub(FP,CurCunitI,Nextptrs,19025)
	f_Div(FP,CurCunitI,_Mov(84))
	CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,k[1]))})
	CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
	f_LMov(FP,BossDPM,k[2])
	CallTrigger(FP, ResetBDPMArr)
	NIfEnd()
	local ClearJump = def_sIndex()
	NJump(FP,ClearJump,{CV(BossLV,j,AtLeast)})
	CIf(FP,{TTNWar(TotalDPM, AtLeast, BossDPM)})
	DoActionsX(FP,{KillUnit(k[1],FP),AddV(BossLV,1),SetV(BossEPD,0)})
	CIfEnd()
	NJumpEnd(FP,ClearJump)
end
DoActions(FP, SetInvincibility(Disable, BossArr[5][1], FP, 64))
for i = 0,6 do
	
	TriggerX(FP, {HumanCheck(i,1),CV(LV5Cool[i+1],1,AtLeast);}, {SetInvincibility(Enable, BossArr[5][1], FP, 64)},{preserved})
end

local iStrinit = def_sIndex()
CJump(FP, iStrinit)
t00 = "\x07\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
t01 = "\x07기준확률 \x04: \x0D000.000\x08%\x0D\x0D"
t02 = "\x08!!! \x1F최 강 유 닛 \x08!!!"
t03 = "\x04강화 불가 유닛"
t04 = "\x19EXP\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04 : \x0D0,000,000,000,000,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t10 = "\x19EXP\x17(판매권 필요)\x04 : \x0D0,000,000,000,000,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t05 = "\x08판매 불가 유닛"
t06 = "\x11현재 DPM : \x0D0000\x04경0000\x04조0000\x04억0000\x04만0000"
t09 = "\x08현재 DPS : \x0D0000\x04경0000\x04조0000\x04억0000\x04만0000"
t07 = "\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I"
t08 = "\x04구입하기 \x07현재배율 \x04: \x0D0000\x04만0000배"
iStrSize1 = GetiStrSize(0,t01)
S0 = MakeiTblString(1495,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- 단축키없음
iTbl1 = GetiTblId(FP,1495,S0)
TStr0, TStr0a, TStr0s = SaveiStrArr(FP,t00)
TStr1, TStr1a, TStr1s = SaveiStrArr(FP,t01)
TStr2, TStr2a, TStr2s = SaveiStrArr(FP,t02)
TStr3, TStr3a, TStr3s = SaveiStrArr(FP,t03)
TStr4, TStr4a, TStr4s = SaveiStrArr(FP,t06)
TStr5, TStr5a, TStr5s = SaveiStrArr(FP,t08)

S1 = MakeiTblString(764,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- 단축키없음
iTbl2 = GetiTblId(FP,764,S1)
S2 = MakeiTblString(16,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t08)+5),"Base",1) -- 단축키없음
iTbl3 = GetiTblId(FP,16,S1)
EStr0, EStr0a, EStr0s = SaveiStrArr(FP,t04)
EStr1, EStr1a, EStr1s = SaveiStrArr(FP,t05)
EStr2, EStr2a, EStr2s = SaveiStrArr(FP,t07)
SelEPD,SelPer,SelUID,SelMaxHP,SelPl,SelI,CurEPD,SelEXP = CreateVars(8,FP)
BossFlag = CreateCcode()
BossFlag2 = CreateCcode()
SellTicketFlag = CreateCcode()
local TotalBossDPMLoc = CreateWar(FP)
CJumpEnd(FP, iStrinit)




CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- 클릭유닛인식(로컬)
CMov(FP,SelPl,0)
f_Read(FP,0x6284B8,nil,SelEPD)
f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
CMov(FP,SelUID,_Read(_Add(SelEPD,25)),nil,0xFF,1)

CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{SetCD(BossFlag,0),SetCD(BossFlag2,0)}) -- 유닛선택시 1회만 실행

CMov(FP,CurEPD,SelEPD)


NIfX(FP,{Never()})
for j, k in pairs(LevelUnitArr) do
	NElseIfX({CV(SelUID,k[2])},{
		SetV(SelPer,k[3]);
		SetV(SelEXP,k[4]);SetCD(SellTicketFlag,0)
	})
	if j>=26 then
		TriggerX(FP,{CV(SelUID,k[2])},{SetCD(SellTicketFlag,1)},{preserved})
	end
end
for j, k in pairs(BossArr) do
	NElseIfX({CV(SelUID,k[1])},{SetCD(BossFlag,1);SetCD(BossFlag2,0);
	SetV(SelPer,0);
	SetV(SelEXP,0);})
end
for j, k in pairs(PBossArr) do
	NElseIfX({CV(SelUID,k[1])},{SetCD(BossFlag,1);SetCD(BossFlag2,1);
	SetV(SelPer,0);
	SetV(SelEXP,0);})
end
NElseX({
	SetV(SelPer,0);
	SetV(SelEXP,0);
})
NIfXEnd()

CIf(FP,{CD(BossFlag,0)})
CIfX(FP,{Never()})
for i = 0, 6 do
	CElseIfX({CV(SelPl,i)},{})
	CMov(FP,TotalEPerLoc,TotalEPer[i+1])
	CMov(FP,TotalEPer2Loc,TotalEPer2[i+1])
	CMov(FP,TotalEPer3Loc,TotalEPer3[i+1])
	CMov(FP,EXPIncomeLoc,Stat_EXPIncome[i+1])

	
end
CElseX()
CTrigger(FP,{
	CV(SelPer,1,AtLeast),
},{TSetMemory(0x6509B0, SetTo, LCP),DisplayText(StrDesignX("\x17P8 \x08강화 유닛\x04의 세부 정보는 \x0F자기자신\x04의 \x07능력치\x04에 따라 표기됩니다."), 4),SetMemory(0x6509B0, SetTo, FP),},{preserved})
 CDoActions(FP,{TSetMemoryB(0x58F32C, (7*15)+13, SetTo, UpgradeUILoc)})
CIfXEnd()
CIfEnd()



CIfX(FP,{CV(SelEXP,0,AtMost)})--경험치가 없을경우 혹은 판매 불가 상태일 경우
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl2,0,EStr1,EStr1s,nil,0,EStr1s)
CElseX()--경험치가 있을경우
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
	CIfX(FP,{CD(SellTicketFlag,0)})
	CS__SetValue(FP,EStr0,t04,nil,0)
	CElseX()
	CS__SetValue(FP,EStr0,t10,nil,0)
	CIfXEnd()
local SelEXPL = CreateWar(FP)
	f_Mul(FP,SelEXP,_Add(EXPIncomeLoc,10))
	f_LMov(FP, SelEXPL, {SelEXP,0}, nil,nil,1)
	CS__lItoCustom(FP,SVA1(EStr0,14),SelEXPL,nil,nil,{10,20},1,nil,"\x080",0x1B,{0,2,3,4,6,7,8,10,11,12,14,15,16,18,19,20,22,23,24,26},nil,{{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0})

	TriggerX(FP, {
		CSVA1(SVA1(EStr0,15+24), Exactly, 0x0D*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(EStr0,15+24), SetTo, string.byte("0")*0x1000000,0xFF000000),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(EStr0,15+26), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(EStr0,15+26), SetTo, 0x0D*0x1000000,0xFF000000),
		SetCSVA1(SVA1(EStr0,15+25), SetTo, 0x0D*0x1000000,0xFF000000),
	}, {preserved})
	CS__InputVA(FP,iTbl2,0,EStr0,EStr0s,nil,0,EStr0s)
	CElseIfX({CD(BossFlag,1)})--보스건물일경우
	--현재 DPS 게이지 표기는 별도
CIfXEnd()

CIfX(FP,{CV(SelUID,LevelUnitArr[#LevelUnitArr][2])})--최강유닛일경우
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl1,0,TStr2,TStr2s,nil,0,TStr2s)
CElseIfX({CV(SelPer,0)})--강화유닛이 아닐 경우
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl1,0,TStr3,TStr3s,nil,0,TStr3s)
	CElseIfX({CD(BossFlag,1)})--보스건물일경우
	--현재 DPS 요구치 표기는 별도
CElseX()--그외
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__SetValue(FP,TStr1,t01,nil,0)
	CS__ItoCustom(FP,SVA1(TStr1,7),SelPer,nil,nil,{10,6},1,nil,"\x080",0x08,{0,1,2,4,5,6})
--8 9 10
--12 13 14
CS__InputTA(FP,{CSVA1(SVA1(TStr1,10), Exactly, 0x0D*0x1000000, 0xFF000000)},SVA1(Str1,10),string.byte("0")*0x1000000, 0xFF000000)

TriggerX(FP, {
	CSVA1(SVA1(TStr1,12), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,13), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,14), Exactly, string.byte("0")*0x1000000, 0xFF000000)
}, {
	SetCSVA1(SVA1(TStr1,11), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(TStr1,12), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(TStr1,13), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(TStr1,14), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
}, {preserved})
TriggerX(FP, {
	CSVA1(SVA1(TStr1,13), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,14), Exactly, string.byte("0")*0x1000000, 0xFF000000)
}, {
	SetCSVA1(SVA1(TStr1,13), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(TStr1,14), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
}, {preserved})
TriggerX(FP, {
	CSVA1(SVA1(TStr1,14), Exactly, string.byte("0")*0x1000000, 0xFF000000)
}, {
	SetCSVA1(SVA1(TStr1,14), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
}, {preserved})


	CS__InputVA(FP,iTbl1,0,TStr1,TStr1s,nil,0,TStr1s)
CIfXEnd()
CIf(FP,{CD(BossFlag,0)})
local TotalEPer4Loc = CreateVar(FP)
CAdd(FP,TotalEPer3Loc,_Div(SelPer,_Mov(100)))
CAdd(FP,TotalEPer2Loc,_Div(SelPer,_Mov(10)))
CAdd(FP,TotalEPerLoc,SelPer) -- +1강 확률


--35~39 +3 수치가 +2로

for i = 35, 39 do
	CIf(FP,{CV(SelUID,LevelUnitArr[i][2])})
		CAdd(FP,TotalEPer2Loc,TotalEPer3Loc)
		CMov(FP,TotalEPer3Loc,0)
	CIfEnd()
end

--36~39 +2 수치가 +1로


for i = 36, 39 do
	CIf(FP,{CV(SelUID,LevelUnitArr[i][2])})
		CAdd(FP,TotalEPerLoc,TotalEPer2Loc)
		CMov(FP,TotalEPer2Loc,0)
	CIfEnd()
end

CSub(FP,TotalEPer4Loc,_Mov(100000),_Add(_Add(TotalEPerLoc,TotalEPer3Loc),TotalEPer2Loc))
CIf(FP,{CV(TotalEPer4Loc,0)})
CSub(FP,TotalEPerLoc,_Mov(100000),_Add(TotalEPer2Loc,TotalEPer3Loc))

CIfEnd()


local E1VarArr = CreateVarArr(6, FP)
local E2VarArr = CreateVarArr(6, FP)
local E3VarArr = CreateVarArr(6, FP)
local E4VarArr = CreateVarArr(6, FP)
for i = 1, 6 do
	Byte_NumSet(TotalEPerLoc,E3VarArr[i],10^(6-i),1,0x30)
	Byte_NumSet(TotalEPer2Loc,E2VarArr[i],10^(6-i),1,0x30)
	Byte_NumSet(TotalEPer3Loc,E1VarArr[i],10^(6-i),1,0x30)
	Byte_NumSet(TotalEPer4Loc,E4VarArr[i],10^(6-i),1,0x30)
end
SetEPerStr(E1VarArr)
SetEPerStr(E2VarArr)
SetEPerStr(E3VarArr)
SetEPerStr(E4VarArr)


for i = 0, 2 do
	CDoActions(FP,{TBwrite(_Add(Etbl,18+5+i),SetTo,E1VarArr[i+1])})
	CDoActions(FP,{TBwrite(_Add(Etbl,18+5+4+i),SetTo,E1VarArr[i+4])})
	CDoActions(FP,{TBwrite(_Add(Etbl,35+5+i),SetTo,E2VarArr[i+1])})
	CDoActions(FP,{TBwrite(_Add(Etbl,35+5+4+i),SetTo,E2VarArr[i+4])})
	CDoActions(FP,{TBwrite(_Add(Etbl,52+5+i),SetTo,E3VarArr[i+1])})
	CDoActions(FP,{TBwrite(_Add(Etbl,52+5+4+i),SetTo,E3VarArr[i+4])})
	CDoActions(FP,{TBwrite(_Add(Etbl,72+5+i),SetTo,E4VarArr[i+1])})
	CDoActions(FP,{TBwrite(_Add(Etbl,72+5+4+i),SetTo,E4VarArr[i+4])})
end

CIfEnd()
CIfEnd()

CIf(FP, {CD(BossFlag,1)}) -- 보스건물 정보 상시갱신
TotalDPMLoc = CreateWar(FP)
CIfX(FP,{CD(BossFlag2,1)})
SelEPD2= CreateVar(FP)
CMov(FP,SelEPD2,SelEPD,2)
--DisplayPrintEr(LCP, {"SelEPD : ",SelEPD2,"  PBossPtr1P : ",PBossPtr[1]})
for i = 0, 6 do
	CIf(FP,{TNVar(SelEPD2,Exactly,PBossPtr[i+1])})
	f_LMov(FP,TotalDPMLoc,PBossDPS[i+1])
	f_LMov(FP,TotalBossDPMLoc,TotalPBossDPS[i+1])
	CIfEnd()
end
CS__SetValue(FP,TStr4,t09,nil,0)
CElseX()
f_LMov(FP,TotalDPMLoc,TotalDPM)
f_LMov(FP,TotalBossDPMLoc,BossDPM)
CS__SetValue(FP,TStr4,t06,nil,0)
CIfXEnd()
CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)--DPS 수치

CS__lItoCustom(FP,SVA1(TStr4,9),TotalDPMLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1C,0x1C,0x1C,0x1C,0x03,0x03,0x03,0x03},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0}})
CS__InputVA(FP,iTbl1,0,TStr4,TStr4s,nil,0,TStr4s)

CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)--DPS 게이지
local TotalDPMTemp = CreateWar(FP)
local TempGauge = CreateVar(FP)
local TempGaugeT = CreateVar(FP)
f_LMul(FP, TotalDPMTemp, TotalDPMLoc, "25")
f_LDiv(FP, {TempGauge,TempGaugeT}, TotalDPMTemp, TotalBossDPMLoc)


CS__SetValue(FP,EStr2,t07,nil,0)
for i = 0, 24 do
	CS__InputTA(FP,{CV(TempGauge,i+1,AtLeast)},SVA1(EStr2,0+i),0x07,0xFF)
end
CS__InputVA(FP,iTbl2,0,EStr2,EStr2s,nil,0,EStr2s)
CIfEnd()

CIf(FP,{CV(SelUID,15)}) -- 시민 정보 상시갱신
CIfX(FP,{Never()})
for i = 0, 6 do
	CElseIfX({CV(SelPl,i)},{})
	CMov(FP,MulOpLoc,MulOp[i+1])
end
CElseX()
CMov(FP,MulOpLoc,0)
CIfXEnd()
CS__SetValue(FP,TStr5,t08,nil,0)

CS__ItoCustom(FP,SVA1(TStr5,12),MulOpLoc,nil,nil,{10,8},nil,nil,"\x040",nil,{0,1,2,3,5,6,7,8},nil,{0,0,0,{0},0,0,0,{0}})
TriggerX(FP, {CV(MulOpLoc,10000,AtLeast)
}, {
	SetCSVA1(SVA1(TStr5,18), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(TStr5,19), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(TStr5,20), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	SetCSVA1(SVA1(TStr5,21), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
}, {preserved})
CS__InputVA(FP,iTbl3,0,TStr5,TStr5s,nil,0,TStr5s)

CIfEnd()



CIfEnd()
--CA__Input(MakeiStrData("\x04경",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04조",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04억",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04만",1),SVA1(Str1,3+7))
--CA__ItoCustom(SVA1(Str1,0),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1E,0x1E,0x1E,0x1E,0x04,0x04,0x04,0x04},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0})


	CIf(FP,{CD(TBLFlag,0)})--tbl상시갱신용. CreateUnitStacked 사용시 발동안함
		f_Read(FP, 0x628438, nil, Nextptrs)
		DoActions(FP, CreateUnit(1,94,64,FP))
		CSub(FP,CurCunitI,Nextptrs,19025)
		f_Div(FP,CurCunitI,_Mov(84))
		CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,94))})
		CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
		--CallTrigger(FP, Call_CTInputUID)
		DoActions(FP, RemoveUnit(94,FP))
	CIfEnd()
	DoActionsX(FP,{SetCD(TBLFlag,0)})
	TriggerX(FP,{ElapsedTime(AtLeast, 90)},{RotatePlayer({DisplayTextX(StrDesignX("\x18Notice \x04: \x04현재 자신의 \x1F미네랄\x04, \x07가스\x04가 건물에게 가하는 \x08데미지\x17(DPS) \x04입니다."))},Force1,FP)})
	TriggerX(FP,{ElapsedTime(AtLeast, 150)},{RotatePlayer({DisplayTextX(StrDesignX("\x18Notice \x04: \x07자신\x04의 \x11지역\x04에 있는 \x1C크리스탈\x04에서 \x07유닛을 구입\x04하고 \x0F상단의 아카데미 \x04지역에 유닛을 넣으면 \x08강화\x04가 됩니다."))},Force1,FP)})
	TriggerX(FP,{ElapsedTime(AtLeast, 180*(1.2))},{RotatePlayer({DisplayTextX(StrDesignX("\x18Notice \x04: 곧 맨 처음 주어진 스카웃이 \x08사라질 것\x04입니다. \x07유닛을 구입, \x08강화\x04하여 \x17사냥터\x04에 보냅시다!"))},Force1,FP)})
	--	if TestStart == 1 then -- 관리자 콘솔 일단비공유데이터(방갈됨)
--		L = CreateVar()
--		CIfOnce(FP)
--		GetPlayerLength(FP,P1,L)
--		CIfEnd()
--		N = CreateVar()
--		local CU = CreateCcodeArr(40)
--		local CUCool = CreateCcodeArr(40)
--		SLoopN(FP,11,Always(),{SetNVar(N,Add,218)},{SetNVar(N,SetTo,0x640B63-218),TSetNVar(N,Add,L)})
--		for i = 1, 40 do
--			f_bytecmp(FP,{CU[i]},N,_byteConvert(GetStrArr(0,"@"..i.."강")),GetStrSize(0,"@"..i.."강"))
--		end--

--		SLoopNEnd()
--		CUCoolT = {}
--		for i = 1, 40 do
--			CreateUnitStacked({CDeaths(FP,AtLeast,1,CU[i]),CDeaths(FP,AtMost,0,CUCool[i])}, 1, LevelUnitArr[i][2], 36, nil, P1, {SetCDeaths(FP,SetTo,0,CU[i]),SetCDeaths(FP,SetTo,24*30,CUCool[i])})
--			CUCoolT[i] = SubCD(CUCool[i],1)
--		end
--		DoActions2X(FP,CUCoolT)--

--	end
	
--if TestStart == 0 and Limit == 1 then
--	Trigger2X(FP, {Memory(0x6D0F38,AtLeast,GlobalTime);},  {
--		RotatePlayer({
--			DisplayTextX(StrDesignX("\x1B테스트 기간이 종료되었습니다. 이용해주셔서 대단히 감사합니다.").."\n"..StrDesignX("\x1B").."\n"..StrDesignX("\x1B추후 정식버전 업데이트에서 뵙겠습니다."),4);
--		Defeat();
--		},Force1,FP);
--		Defeat();
--		SetMemory(0xCDDDCDDC,SetTo,1)
--		
--	})
--end

	
CTEPD = CreateVar(FP)
UIDPtr =  CreateVar(FP)
CurCunitI2 = CreateVar(FP)


	EXCC_Part1(CT_Cunit)
	local TempV = CreateVar(FP)
	--0x4D 가 107 Or 10일떄 0x5C인식
	CIfX(FP, {TTOR({DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00)})},{})--홀드or공격중일때.. 23으로 감
	DoActions(FP, SetMemory(0x6509B0, Add, 4))
	CIf(FP,{Deaths(CurrentPlayer, AtLeast, 1, 0)},{})-- 대상이있을경우 일단 8로 가서 이동플래그 확인
	DoActions(FP,{SetMemory(0x6509B0, Subtract, 15)})
	-- 이동플래그가 0 또는 8일경우에만 작동
	CIf(FP,{TTOR({DeathsX(CurrentPlayer,Exactly,0,0,0xFF),DeathsX(CurrentPlayer,Exactly,8,0,0xFF)})})

		--디펜시브 값이 1이상이고 디펜타이머가 0이면 변조. 단, 이동플래그 1일경우 작동금지
		DoActions(FP, SetMemory(0x6509B0, Add, 60))--68로이동
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,65536*256,0,0xFFFF0000)},{SetMemory(0x6509B0, Add, 1)})----
		if TestStart ==1 then
			CIf(FP,{DeathsX(CurrentPlayer,AtMost,0,0,0xFF)})
				
				f_SaveCp()
				local TempUID = CreateVar(FP)
				CMov(FP,TempUID,_Read(UIDPtr,0xFF),nil,0xFF,1)
				CMov(FP,CPos,_Read(_Sub(BackupCp,15)))
				Convert_CPosXY()
				DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
				f_LoadCp()
			CIfEnd()
		else
			TriggerX(FP, {DeathsX(CurrentPlayer,AtMost,0,0,0xFF)}, {RotatePlayer({
				PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayTextX("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);
			})
		end
		DoActions(FP, {SetMemory(0x6509B0, Subtract, 1)})
		CIfEnd()----
		--디펜싀브값이 0일때 디펜시브 타이머와 함께 디펜시브 방어력양을 준다.
		
		TriggerX(FP, {DeathsX(CurrentPlayer,AtMost,0,0,0xFFFF0000)},{SetDeathsX(CurrentPlayer, SetTo, 65536*256, 0, 0xFFFF0000),
		SetMemory(0x6509B0, Add, 1);
		SetDeathsX(CurrentPlayer, SetTo, 6, 0, 0xFF),
		SetMemory(0x6509B0, Subtract, 1);},{preserved})
		--디펜시브 값이 1 이상이고 공속 인식되면 디펜시브 타이머는 상시로 초기화한다.
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,65536*256,0,0xFFFF0000)},{SetMemory(0x6509B0, Subtract, 47)})
			--21로이동
			TriggerX(FP, {DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)},{--공속이 있다없다?
				--다시 디펜시브타이머인 69로 이동
				SetMemory(0x6509B0, Add, 48);
				SetDeathsX(CurrentPlayer, SetTo, 6, 0, 0xFF),--디펜타이머 초기화
				SetMemory(0x6509B0, Subtract, 48);
			},{preserved})--
			DoActions(FP, {SetMemory(0x6509B0, Add, 47)})
		CIfEnd()
		if TestStart ==1 then
			f_SaveCp()
			local TempUID = CreateVar(FP)
			local TempV1 = CreateVar(FP)
			local TempV2 = CreateVar(FP)
			local TempV3 = CreateVar(FP)
			local TempV4 = CreateVar(FP)
			CMov(FP,TempV2,_Read(BackupCp),nil,0xFFFF0000,1)
			CMov(FP,TempV3,_Read(_Add(BackupCp,1)),nil,0xFF,1)
			CMov(FP,TempUID,_Read(UIDPtr,0xFF),nil,0xFF,1)
			CMov(FP,TempV1,_Read(_Sub(UIDPtr,6)),nil,0xFF00,1)
			CMov(FP,TempV4,_Read(_Sub(UIDPtr,17)),nil,0xFF,1)
			f_Div(FP,TempV1,256)
			DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  OrderID : ",TempV1,"  ","DefValue : ",TempV2,"   DefTimer : ",TempV3, "   MoveMentFlag : ",TempV4})--
			f_LoadCp()
		end----
		DoActions(FP, {SetMemory(0x6509B0, Subtract, 60)})
		--다시 23으로 이동----
		CIfEnd()
		DoActions(FP,{SetMemory(0x6509B0, Add, 15)})
	CIfEnd()
	DoActions(FP, {SetMemory(0x6509B0, Subtract, 4)})
	
	CElseX({})
		DoActions(FP, {SetMemory(0x6509B0, Add, 49),
		SetDeathsX(CurrentPlayer, SetTo, 0, 0, 0xFFFF0000),
		SetMemory(0x6509B0, Add, 1);
		SetDeathsX(CurrentPlayer, SetTo, 0, 0, 0xFF),
		SetMemory(0x6509B0, Subtract, 1);
		SetMemory(0x6509B0, Subtract, 49)})--홀드or공격 명령이 없으면 디펜을 0으로 돌린다
		
	CIfXEnd()--










	CSub(FP,TempV,EXCC_TempVarArr[1],EXCC_TempVarArr[2]) -- Line0 = 저장된난수 + 유닛ID Line1 = 저장된 난수
	--TempV=계산된 유닛ID
	CIfX(FP,{TMemory(UIDPtr, Exactly, TempV)})--UIDPtr == 실제 유닛ID저장된 포인터
	CDoActions(FP, {Set_EXCCX(0,SetTo,_Add(TempV,CT_GNextRandV)),Set_EXCCX(1, SetTo, CT_GNextRandV)})
	CElseX()
	if TestStart == 1 then
		f_SaveCp()
		local TempUID = CreateVar(FP)
		CMov(FP,TempUID,_Read(UIDPtr,0xFF),nil,0xFF,1)
		CMov(FP,CPos,_Read(_Sub(BackupCp,15)))
		Convert_CPosXY()
		DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
		f_LoadCp()
	else
	TriggerX(FP,{},{RotatePlayer({
		PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayTextX("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
	end--

	CIfXEnd()--


	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,19*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i),--SetResources(P1,Add,1,Gas)
		SetCVar(FP,UIDPtr[2],SetTo,19025+(84*i)+25),--SetResources(P1,Add,1,Gas)--
		})
	end
	EXCC_End()

--	
--MemoryCT = CreateCcode()
--DoActionsX(FP,SetCD(MemoryCT,0))
--if Limit == 1 or TestStart==1 then
--	MCTCondArr[1] = Memory(0x5124F0, Exactly, 1)
--end--

--condarr = {}
--condnum = 0
--condptr = 0
--for j,k in pairs(MCTCondArr) do
--	if condnum == 0 then table.insert(condarr,{}) condptr = condptr + 1 end
--	table.insert(condarr[condptr],k)
--	condnum = condnum + 1
--	if condnum == 15 then condnum = 0 end
--end--
--for j,k in pairs(condarr) do
--	TriggerX(FP, k, {AddCD(MemoryCT,1)}, {preserved})
--end
----error(#condarr)--

--if Limit ~= 0 then
--	CTrigger(FP,{
--		CD(MemoryCT,#MCTCondArr-1,AtMost)
--	},{RotatePlayer({
--		DisplayTextX("MemoryCT", 4);},Force1,FP)},{preserved})
--	else----

--		TriggerX(FP,{CD(MemoryCT,#MCTCondArr-1,AtMost)},{RotatePlayer({
--			PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
--			DisplayTextX("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
--	end
--	--





for j,k in pairs(VWArr) do
	local VW = k[1]
	local TrapVW = k[2]
	if TrapVW[4] == "V" then
		CMov(FP, TrapVW, VW)
	else
		f_LMov(FP, TrapVW,VW)
	end
	if TrapVW[4] == "V" then
		CXor(FP, TrapVW, CT_GNextRandV)
	else
		f_LXor(FP, TrapVW,TrapVW, CT_GNextRandW)
	end

end
	CMov(FP,CT_GPrevRandV,CT_GNextRandV)
	f_LMov(FP,CT_GPrevRandW,CT_GNextRandW)
	for i = 0, 6 do
		CIf(FP, HumanCheck(i,1))
		for j,k in pairs(PVWArr) do
			local VW = k[1][i+1]
			local TrapVW = k[2][i+1]
			if TrapVW[4] == "V" then
				CMov(FP, TrapVW, VW)
			else
				f_LMov(FP, TrapVW,VW)
			end
			if TrapVW[4] == "V" then
				CXor(FP, TrapVW, CT_NextRandV[i+1])
			else
				f_LXor(FP, TrapVW,TrapVW, CT_NextRandW[i+1])
			end
	
		end
		CMov(FP,CT_PrevRandV[i+1],CT_NextRandV[i+1])
		f_LMov(FP,CT_PrevRandW[i+1],CT_NextRandW[i+1])
		CIfEnd()
	end
	
if Limit == 1 then
for i = 0, 0 do
	CIf(FP, HumanCheck(i,1))
	if TestStart == 1 then -- 관리자 콘솔 일단비공유데이터(방갈됨)

		L = CreateVar()
		CIfOnce(FP)
		GetPlayerLength(FP,P1,L)
		CIfEnd()
		N = CreateVar()
		local CU = CreateCcodeArr(40)
		local CUCool = CreateCcodeArr(40)
		SLoopN(FP,11,Always(),{SetNVar(N,Add,218)},{SetNVar(N,SetTo,0x640B63-218),TSetNVar(N,Add,L)})

		for j,k in pairs({PLevel[i+1],SellTicket[i+1],IncomeMax[i+1],TotalEPer[i+1],TotalEPer2[i+1],TotalEPer3[i+1],General_Upgrade[i+1],Stat_EXPIncome[i+1]}) do
			f_bytecmp(FP,{CU[j]},N,_byteConvert(GetStrArr(0,"@"..j.."번")),GetStrSize(0,"@"..j.."번"))
		
		end
		for j,k in pairs({Credit[i+1],Money[i+1]}) do
			f_bytecmp(FP,{CU[j+8]},N,_byteConvert(GetStrArr(0,"@"..(j+8).."번")),GetStrSize(0,"@"..(j+8).."번"))
			
		end
		SLoopNEnd()
		CUCoolT = {}
		for j,k in pairs({PLevel[i+1],SellTicket[i+1],IncomeMax[i+1],TotalEPer[i+1],TotalEPer2[i+1],TotalEPer3[i+1],General_Upgrade[i+1],Stat_EXPIncome[i+1]}) do
			CIf(FP, {CD(CUCool[j],0),CD(CU[j],1,AtLeast)},{SetCDeaths(FP,SetTo,0,CU[j]),SetCDeaths(FP,SetTo,24*30,CUCool[j])})
			CAdd(FP,k,1)
			CIfEnd()
			table.insert(CUCoolT, SubCD(CU[j],1))
		end
		for j,k in pairs({Credit[i+1],Money[i+1]}) do
			CIf(FP, {CD(CUCool[j+8],0),CD(CU[j+8],1,AtLeast)},{SetCDeaths(FP,SetTo,0,CU[j+8]),SetCDeaths(FP,SetTo,24*30,CUCool[j+8])})
			f_LAdd(FP,k,k,"1")
			CIfEnd()
			table.insert(CUCoolT, SubCD(CU[j+8],1))
		end
		DoActions2X(FP,CUCoolT)--
	end
	CIfEnd()
end
end



end
