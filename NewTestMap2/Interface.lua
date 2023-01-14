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

	local BanFlag = iv.BanFlag
	local BanFlag2 = iv.BanFlag2
	local BanFlag3 = iv.BanFlag3
	local BanFlag4 = iv.BanFlag4
	BPArr = {BanFlag,BanFlag2,BanFlag3,BanFlag4}

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
	local TempO = CreateVarArr(7,FP)
	local CT_TempO = CreateVarArr(7,FP)
	local TempG = CreateVarArr(7,FP)
	local CT_TempG = CreateVarArr(7,FP)
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
	local PartyBonus= CreateCcode()
	local SCheck = CreateCcode()
	local GeneralPlayTime= iv.GeneralPlayTime
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
	local SaveRemind = iv.SaveRemind
	iv.Time = Time
	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CV(DtP,2500,AtMost)},{AddV(Time,DtP),AddV(Time2,DtP)},1)--맨처음 시간값 튐 방지
	TriggerX(FP,{},{AddV(Time,240000),})
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
		{iv.B_PTicket,ct.B_PTicket,"B_PTicket"},
		{iv.BanFlag,ct.BanFlag,"BanFlag"},
		{iv.BanFlag2,ct.BanFlag2,"BanFlag2"},
		{iv.BanFlag3,ct.BanFlag3,"BanFlag3"},
		{iv.BanFlag4,ct.BanFlag4,"BanFlag4"},
		{TempO,CT_TempO,"TempO"},
		{TempG,CT_TempG,"TempG"},
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
		{iv.CUnitT,ctg.CUnitT,"CUnitT"}


	}
	for j,k in pairs(VWArr) do
		local VW = k[1]
		local TrapVW = k[2]
		TrapKey = CheatTestX(AllPlayers, VW,TrapVW, j-1,nil,k[3])

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
	Trigger2X(FP, {CV(GeneralPlayTime,(3*24*60*60)-1,AtMost)}, {SetCD(PartyBonus,0)},{preserved})
	Trigger2X(FP, {CV(GeneralPlayTime,24*60*60,AtLeast),CV(PCheckV,2,AtLeast)}, {SetCD(BossRewardEnable,1),RotatePlayer({DisplayTextX(StrDesignX("\x04멀티플레이 시작 후 1시간이 지났습니다. \x07이제부터 1인 진행으로 개인보스 LV.5의 보상 획득 가능합니다."))}, Force1, FP)})
	Trigger2X(FP, {CV(GeneralPlayTime,3*24*60*60,AtLeast),CV(PCheckV,2,AtLeast)}, {SetCD(PartyBonus,1),RotatePlayer({DisplayTextX(StrDesignX("\x04멀티플레이 시작 후 3시간이 지났습니다. \x07이제부터 1인 진행으로 파티 버프가 활성화됩니다."))}, Force1, FP)})
	Trigger2X(FP, {CV(PCheckV,2,AtLeast)}, {SetCD(BossRewardEnable,1),SetCD(PartyBonus,1)},{preserved})


for i = 0, 6 do -- 각플레이어 
	CIf(FP,{HumanCheck(i,1)},{SetCp(i)})
	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+12, AtLeast, 100),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--공업수치 변조인식, 강퇴
	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 100),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--공업수치 변조인식, 강퇴

	
	CMov(FP,CT_NextRandV[i+1],_Mod(_Rand(),12858519))
	f_LMov(FP,CT_NextRandW[i+1],_LMod(_LRand(), {12532858,12532858}))
	
	for j,k in pairs(PVWArr) do
		local VW = k[1][i+1]
		local TrapVW = k[2][i+1]
		TrapKey = CheatTestX(i, VW,TrapVW, j+(#VWArr)-1,1,k[3])

	end
	DoActionsX(FP, {AddV(ScTimer[i+1],1),AddV(PTimeV[i+1],1)})

	CDoActions(FP,{TSetScore(i,SetTo,PLevel[i+1],Custom)})
	CIf(FP,CV(PTimeV[i+1],24,AtLeast), {SubV(PTimeV[i+1],24),AddV(PlayTime[i+1],1)})
	TriggerX(FP, {CV(LV5Cool[i+1],1,AtLeast),}, {SubV(LV5Cool[i+1],1)},{preserved})
	CIfEnd()


	TriggerX(FP,{LocalPlayerID(i),Command(i,AtMost,0,"Men"),Command(i,AtMost,0,"Factories"),CV(Time2,60000,AtLeast),CD(LoadCheck[i+1],1)},{SetV(Time2,0),SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: 보유 유닛이 없을 경우 \x07실제시간 \x031분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: 수동저장은 F9를 눌러주세요."),4)},{preserved})
	CIf(FP,{LocalPlayerID(i),CV(Time,300000,AtLeast)},{SubV(Time,300000)})
	TriggerX(FP,{LocalPlayerID(i),CD(LoadCheck[i+1],1),CD(SaveRemind,0)},{DisplayText(StrDesignX("\x03SYSTEM \x04: \x07실제시간 \x035분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: 수동저장은 F9를 눌러주세요."),4)},{preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SaveRemind,0),CD(PartyBonus,1)},{DisplayText(StrDesignX("\x04현재 \x1F멀티 플레이 보너스 버프 \x1C적용중입니다. - \x08공격력 + 150%\x04, \x07+1강 \x17강화확률 + \x0F1.0%p"),4)},{preserved})-- 인원수 버프 보너스
	TriggerX(FP,{LocalPlayerID(i),CV(PLevel[i+1],999,AtMost)},{DisplayText(StrDesignX("\x04현재 \x1F초보자 보너스 버프 \x1C적용중입니다. \x041000레벨 달성 전까지 \x07+1강 \x17강화확률 + \x0F5.0%p"),4)},{preserved})-- 1000레벨 미만 5퍼센트 강확보너스
	TriggerX(FP,{LocalPlayerID(i),CD(LoadCheck[i+1],1)},{SetMemory(0x58F500, SetTo, 1),},{preserved})
	TriggerX(FP,{LocalPlayerID(i)},{SetCD(SaveRemind,0)},{preserved})

	CIfEnd()--
	for j,k in pairs(BPArr) do
		TriggerX(FP, {Deaths(i, Exactly, 0,14),CV(k[i+1],1,AtLeast)},{SetDeaths(i,SetTo,1,14)})
	end
	CIfOnce(FP,{Deaths(i, Exactly, 2, 23)},{SetCD(LoadCheck[i+1],1),SetCD(CheatDetect,0)})--로드 완료시 첫 실행 트리거
		CIfX(FP, {Deaths(i,AtLeast,1,101)})--레벨데이터가 있을경우 로드후 모두 덮어씌움, 없으면 뉴비로 간주하고 로드안함
		SCA_DataLoad(i,BanFlag2[i+1],95)
		SCA_DataLoad(i,BanFlag2[i+1],96)
		SCA_DataLoad(i,BanFlag2[i+1],97)
		SCA_DataLoad(i,BanFlag[i+1],98)
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
		CTrigger(FP, {CV(BanFlag4[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {CV(BanFlag3[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {CV(BanFlag2[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {CV(BanFlag[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
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
			--CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--제작자 칭호 보유자 스카 6개 추가지급
			
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
		TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{SetCp(i),DisplayText(StrDesignX("\x04현재 \x1F초보자 보너스 버프 \x1C적용중입니다. \x041000레벨 달성 전까지 \x07+1강 \x17강화확률 + \x0F5.0%p"),4)},{preserved})-- 1000레벨 미만 5퍼센트 강확보너스
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
		SCA_DataSave(i,BanFlag2[i+1],95)
		SCA_DataSave(i,BanFlag2[i+1],96)
		SCA_DataSave(i,BanFlag2[i+1],97)
		SCA_DataSave(i,BanFlag[i+1],98)
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
	CTrigger(FP, {CV(BanFlag4[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag3[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag2[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
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
	TriggerX(FP,{CV(TempO[i+1], OreDPS[p],AtLeast)},{
		SetV(BuildMul1[i+1],OreDPSM[p]),
		SetV(NextOre[i+1],OreDPS[p+1]),
		SetV(NextOreMul[i+1],OreDPSM[p+1]),SetCp(i),
		DisplayText(StrDesignX("건물의 \x1BDPS\x1F(미네랄)\x04가 \x08"..OreDPS[p].." \x04를 돌파하였습니다. \x07돈 증가량\x04이 \x08"..OreDPSM[p].."배\x04로 증가하였습니다.")..NextT),SetCp(FP)})--1번건물
	TriggerX(FP,{CV(TempG[i+1], GasDPS[p],AtLeast)},{
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

	
	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{Ore,TempO[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas,TempG[i+1]},Money[i+1])
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
	

TriggerX(FP, {CV(TempO[i+1],10000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
	DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

TriggerX(FP, {CV(TempG[i+1],20000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
	DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})


	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)
	DPSBuilding(i,PBossPtr[i+1],"X",nil,{PBossDPS[i+1]},nil)--

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
	TriggerX(FP,{CV(ScTimer[i+1],4320,AtMost)},{MoveUnit(1, 88, i, 15+i, 22+i)},{preserved})


	CTrigger(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65+i),Bring(i,AtLeast,1,"Men",15+i)},{MoveUnit(1, "Men", i, 15+i, 22+i),MoveUnit(1, "Factories", i, 22+i, 57+i)},1)--사냥터 입장

	TriggerX(FP, {Bring(i,AtLeast,1,"Men",29+i)}, {MoveUnit(1, "Men", i, 29+i, 36+i)}, {preserved})--사냥터 퇴장

	TriggerX(FP, {Bring(i, AtMost, 3, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--보스방 입장
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
		if SpeedTestMode == 0 then
			TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})
			TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)}, {SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0)}, {preserved}) 
		end
		TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1)}, {Order(k[2], i, 36+i, Move, 8+i)}, {preserved})
		CIfEnd()

		CIf(FP,MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1))
		CallTriggerX(FP,Call_Print13[i+1],{MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})
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
		
		TriggerX(FP,{CD(PartyBonus,1)},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- 인원수 버프 보너스
	end
	TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{AddV(TotalEPer[i+1],5000)},{preserved})-- 1000레벨 미만 5퍼센트 강확보너스

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
	CMov(FP,IncomeMaxLoc,IncomeMax[i+1])
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
		--핫키 QCUnit 등록방지
		local Cunit2 = CreateVar(FP)
		f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,19025),CVar(FP,Cunit2[2],AtMost,19025+(1700*84))})
		CMov(FP,0x6509B0,Cunit2,25)
				CTrigger(FP,{DeathsX(CurrentPlayer,Exactly,ParseUnit("Zerg Scourge"),0,0xFF)},{TSetMemory(0x6284E8+(0x30*i),SetTo,ShopPtr[i+1])},1)
				if Limit == 1 then
					CTrigger(FP,{KeyPress("Y", "Down")},{TSetDeathsX(CurrentPlayer,SetTo,54,0,0xFF)},1)
				end
		CIfEnd()
		CMov(FP,0x6509B0,FP)
	CIfEnd()
end

Shop()
GameDisplay()
GlobalBoss()
TBL()
CUnit()	

	
MemoryCT = CreateCcode()
--error(#MCTCondArr)
DoActionsX(FP,{SetCD(MemoryCT,0),})
if TestStart==1 then
	MCTCondArr[1] = Memory(0x5124F0, Exactly, TestSpeedNum)
end--
condnum = 0
condptr = 0
condarr = {}
for j,k in pairs(MCTCondArr) do
	if condnum == 0 then table.insert(condarr,{}) condptr = condptr + 1 end
	table.insert(condarr[condptr],k)
	condnum = condnum + 1
	if condnum == 15 then condnum = 0 end
end--
for j,k in pairs(condarr) do
	TriggerX(FP, k, {AddCD(MemoryCT,1),SetCp(0)}, {preserved})
end
--error(#condarr)--
if TestStart == 1 then
	CTrigger(FP,{
		CD(MemoryCT,#condarr-1,AtMost)
	},{RotatePlayer({
		DisplayTextX("MemoryCT", 4);},Force1,FP)},{preserved})
	else----
		TriggerX(FP,{CD(MemoryCT,#condarr-1,AtMost)},{RotatePlayer({
			PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayTextX("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
	end
	--




for j,k in pairs(VWArr) do
	local VW = k[1]
	local TrapVW = k[2]
	if TrapVW[4] == "V" then
		CXor(FP, TrapVW,VW, CT_GNextRandV)
	else
		f_LXor(FP, TrapVW,VW, CT_GNextRandW)
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
				CXor(FP, TrapVW,VW, CT_NextRandV[i+1])
			else
				f_LXor(FP, TrapVW,VW, CT_NextRandW[i+1])
			end
	
		end
		CMov(FP,CT_PrevRandV[i+1],CT_NextRandV[i+1])
		f_LMov(FP,CT_PrevRandW[i+1],CT_NextRandW[i+1])
		CIfEnd()
	end
	
if TestStart == 1 then
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
