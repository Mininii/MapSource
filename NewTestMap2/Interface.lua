function Interface()
	--PlayData(NonSCA)
	local Money = iv.Money-- CreateWarArr(7,FP) -- 자신의 현재 돈 보유량
	local Money2 = iv.Money2-- CreateWarArr(7,FP) -- 자신의 현재 돈 보유량
	local IncomeMax = iv.IncomeMax-- CreateVarArr2(7,12,FP) -- 자신의 사냥터 최대 유닛수
	local Income = iv.Income-- CreateVarArr(7,FP) -- 자신의 현재 사냥터에 보유중인 유닛수
	local BuildMul1 = iv.BuildMul1-- CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	local BuildMul2 = iv.BuildMul2-- CreateVarArr2(7,1,FP)-- 건물 돈 획득략 배수
	local TotalEPer = iv.TotalEPer-- CreateVarArr(7,FP)--총 강화확률(기본 1강)
	local TotalEPer2 = iv.TotalEPer2-- CreateVarArr(7,FP)--총 강화확률(+2강)
	local TotalEPer3 = iv.TotalEPer3-- CreateVarArr(7,FP)--총 강화확률(+3강)
	local TotalEPer4 = iv.TotalEPer4-- CreateVarArr(7,FP)--총 강화확률(+3강)
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
	local Stat_TotalEPerEx = iv.Stat_TotalEPerEx--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPerEx2 = iv.Stat_TotalEPerEx2--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPerEx3 = iv.Stat_TotalEPerEx3--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPer2 = iv.Stat_TotalEPer2--CreateVarArr(7,FP)-- +2강 확업 수치
	local Stat_TotalEPer3 = iv.Stat_TotalEPer3--CreateVarArr(7,FP)-- +3강 확업 수치
	local Stat_TotalEPer4 = iv.Stat_TotalEPer4--CreateVarArr(7,FP)-- +3강 확업 수치
	local Stat_BreakShield = iv.Stat_BreakShield--CreateVarArr(7,FP)-- +3강 확업 수치
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
	local CS_BreakShield = iv.CS_BreakShield
	local Stat_SCCool = iv.Stat_SCCool
	local SCCool = iv.SCCool
	local AddSC = iv.AddSC
	local PETicket = iv.PETicket
	local DayCheck = iv.DayCheck
	local DayCheck2 = iv.DayCheck2
	local MonthCheck = iv.MonthCheck
	local YearCheck = iv.YearCheck
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
	local B_PEXP = iv.B_PEXP--CreateVar(FP)
	local B_Ticket = iv.B_Ticket--CreateVar(FP)
	local B_PTicket = iv.B_PTicket--CreateVar(FP)
	local CT_PLevel = iv.CT_PLevel

	local BossRewardEnable= CreateCcode()
	local PartyBonus= iv.PartyBonus
	local GeneralPlayTime= iv.GeneralPlayTime
	local GeneralPlayTime2= CreateVar(FP)
	local SaveRemind = iv.SaveRemind
	--PlayData(NotSureSCA)
	local Stat_EXPIncome = iv.Stat_EXPIncome--CreateVarArr(7,FP)-- 경험치 획득량 수치. 사용 미정
	local PEXP2 = iv.PEXP2--CreateVarArr(7, FP) -- 1/10로 나눠 경험치에 더할 값 저장용. 사용 미정
	
	local OreMode = CreateCcodeArr(7)
	local ZKeyCool = CreateCcodeArr(7)
	local MissionV = iv.MissionV
	local CurMission = iv.CurMission
	
	local PBossClearFlag = iv.PBossClearFlag
	PLevelBak = CreateVar(FP)




	--local GEXP = CreateVar(FP)
	--local STable = {"1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "2048", "4096", "8192", "16384", "32768", "65536", "131072", "262144", "524288", "1048576", "2097152", "4194304", "8388608", "16777216", "33554432", "67108864", "134217728", "268435456", "536870912", "1073741824", "2147483648", "4294967296", "8589934592", "17179869184", "34359738368", "68719476736", "137438953472", "274877906944", "549755813888", "1099511627776", "2199023255552", "4398046511104", "8796093022208", "17592186044416", "35184372088832", "70368744177664", "140737488355328", "281474976710656", "562949953421312", "1125899906842624", "2251799813685248", "4503599627370496", "9007199254740992", "18014398509481984", "36028797018963968", "72057594037927936", "144115188075855872", "288230376151711744", "576460752303423488", "1152921504606846976", "2305843009213693952", "4611686018427387904", "9223372036854775807"}

	local Time = iv.Time
	local Time2 = iv.Time2

	local MissionPDataArr = {}
	local MissionDataTextArr = {}

	-- 15강 판매 ok
	-- 인게임 3시간 달성 ok
	-- 강화확률 +1 마스터
	-- 판매권 판매하기
	-- 5보스 5회 격파(한번에)
	-- 40강 48마리 생성
	-- 백신 구매하기
	-- 백신을 사용하여 10강 달성
	
	-- 확정권을 사용하여 10강 달성


	for i = 0, 6 do
		local MissionDataArr = { -- {Cond,RewardArr,Text}  RewardArr = {Credit,SellTicket,VaccItem,EXP}
		{{CVX(MissionV[i+1],1,1)},{1000,0,0,1000},"B,N,M키를 눌러 설명서 읽기"},
		{{Command(i, AtLeast, 1, LevelUnitArr[2][2])},{1000},"2강 유닛 만들기"},
		{{CV(Income[i+1],12,AtLeast)},{1000},"사냥터에 유닛 12기 채우기"},
		{{NWar(Money[i+1], AtLeast, "5000000")},{1000},"500만원 모으기"},
		{{Command(i, AtLeast, 1, LevelUnitArr[15][2])},{1500},"15강 유닛 만들기"},
		{{CV(PBossLV[i+1],1,AtLeast)},{1500},"개인보스 LV.1 처치하기"},
		{{CVX(MissionV[i+1],32,32)},{1000,10,0,500},"15강 유닛 판매하기"},
		{{CV(PLevel[i+1],50,AtLeast)},{1000},"LV. 50 달성"},
		{{Command(i, AtLeast, 1, LevelUnitArr[26][2])},{5000,50},"26강 유닛 만들기"},
		{{CV(PLevel[i+1],100,AtLeast)},{1000},"LV. 100 달성"},
		{{CV(PlayTime[i+1],3600*3,AtLeast)},{5000,100},"인게임 플레이 시간 3시간 달성하기"},
		{{Command(i, AtLeast, 1, LevelUnitArr[36][2])},{10000,100},"36강 유닛 만들기"},
		{{CVX(MissionV[i+1],8,8)},{1000,5},"상점에서 구입 배율 조정하기"},
		{{CVX(MissionV[i+1],4,4)},{1000,10},"상점에서 유닛 판매권 1개 이상 구입하기"},
		{{CV(PLevel[i+1],500,AtLeast)},{5000},"LV. 500 달성"},
		{{CVX(MissionV[i+1],2,2)},{10000,100},"고유유닛 강화 시도하기"},
		{{CV(PLevel[i+1],1000,AtLeast)},{10000},"LV. 1000 달성"},
		{{CV(PUnitLevel[i+1],10,AtLeast)},{500000,0,5},"고유유닛 10강 달성하기"},
		{{CVX(MissionV[i+1],16,16)},{100000},"고유유닛 승급하기"},
		}
		table.insert(MissionPDataArr,MissionDataArr)
		
	end
	for j,k in pairs(MissionPDataArr[1]) do
		local MText = "\x07M\x04ission \x08No. \x10"..j.." \x04: "..k[3].." \x04|| \x07보상 \x04: "
		local MText2 = "\x07M\x04ission \x08No. \x10"..j.." \x04: "..k[3].." \x07CLEAR"
		for l,m in pairs(k[2]) do
			if m>= 1 then
				if l == 1 then
					MText = MText.."\x17"..m.." Credit "
				end
				if l == 2 then
					MText = MText.."\x19"..m.." 유닛 판매권 "
				end
				if l == 3 then
					MText = MText.."\x10"..m.." 강화기 백신 "
				end
				if l == 4 then
					MText = MText.."\x1F"..m.." EXP "
				end
			end
		end
		table.insert(MissionDataTextArr,{StrDesign(MText),StrDesignX(MText2)})
	end
	

	CMov(FP,PCheckV,0)
	if Limit == 1 then
		CAdd(FP,GeneralPlayTime,100)
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
	
	Trigger2X(FP, {CD(PartyBonus,2,AtLeast)}, {RotatePlayer({DisplayTextX(StrDesignX("\x04런쳐 로드 인원이 2명 이상 감지되었습니다. \x07이제부터 1인 진행으로 파티 버프가 활성화됩니다."))}, Force1, FP)})
	Trigger2X(FP, {CD(PartyBonus,2,AtLeast)}, {SetCD(PartyBonus2,1)},{preserved})
	
	Trigger2X(FP, {CD(PartyBonus,1,AtMost),CV(PCheckV,2,AtLeast)}, {SetCD(PartyBonus2,1)},{preserved})--런쳐 불러온사람 1명이하인데 멀티일경우 보너스 활성화
	Trigger2X(FP, {CD(PartyBonus,1,AtMost),CV(PCheckV,1,AtMost)}, {SetCD(PartyBonus2,0)},{preserved})-- 런쳐 불러온사람 1명이하인데 솔로일경우 보너스 비활성화

	
TipArr = {
	StrDesignX("\x04TIP : \x04유닛 선택 후 Z키를 누르면 한곳에 뭉칩니다."),	StrDesignX("\x04TIP : \x1F미네랄\x04, \x07가스\x04는 현재 자신의 건물을 공격중인 모든 유닛 DPS를 나타냅니다."),
	StrDesignX("\x04TIP : \x17O키\x04를 누르면 레벨 업을 통해 얻은 스탯을 분배할 수 있습니다."),
	StrDesignX("\x04TIP : \x04강화 성공시 단계가 \x08+1 \x04뿐만 아니라 낮은 확률로 \x1C+2\x04, \x1F+3\x04 도 올라갈 수 있습니다."),}

for i = 0, 6 do -- 각플레이어 
	CIf(FP,{HumanCheck(i,1)},{SetCp(i),SetV(GCP,i),SetNWar(GCPW,SetTo,tostring(i))})
	CIf(FP, LocalPlayerID(i))
	CT_PrevCP(i)
	CIfEnd()

	ConvertVArr(FP,VArrI,VArrI4,GCP,7)
	ConvertVArr(FP, WArrI,WArrI4, GCPW, 7)
	TriggerX(FP,{MSQC_KeyInput(i, "B")},{SetVX(MissionV[i+1],1,1)},{preserved})
	TriggerX(FP,{MSQC_KeyInput(i, "N")},{SetVX(MissionV[i+1],1,1)},{preserved})
	TriggerX(FP,{MSQC_KeyInput(i, "M")},{SetVX(MissionV[i+1],1,1)},{preserved})

	

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+11, AtLeast, 11),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("g\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--공업수치 변조인식, 강퇴

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+12, AtLeast, 251),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("s\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--공업수치 변조인식, 강퇴
	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 100),LocalPlayerID(i)},{
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("u\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);},{preserved})--공업수치 변조인식, 강퇴

	
	DoActionsX(FP, {AddV(ScTimer[i+1],1),AddV(PTimeV[i+1],1),SubV(DPErT[i+1],1)})

	CDoActions(FP,{TSetScore(i,SetTo,PLevel[i+1],Custom)})
	CIf(FP,CV(PTimeV[i+1],24,AtLeast), {SubV(PTimeV[i+1],24),AddV(PlayTime[i+1],1),SubV(TimeAttackScore2[i+1],1),})
	TriggerX(FP, {CV(LV5Cool[i+1],1,AtLeast),}, {SubV(LV5Cool[i+1],1)},{preserved})
	CIfEnd()

	DoActions(FP, {SetSwitch("Switch 100",Random),SetSwitch("Switch 101",Random)})
	TriggerX(FP,{LocalPlayerID(i),Command(i,AtMost,1,"Men"),Command(i,AtMost,0,"Factories"),CV(Time2,60000,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(Time2,0),SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: 보유 유닛이 없을 경우 \x07실제시간 \x031분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: 수동저장은 F9를 눌러주세요."),4)},{preserved})
	CIf(FP,{LocalPlayerID(i),CV(Time,300000,AtLeast)},{SubV(Time,300000)})
	TriggerX(FP,{LocalPlayerID(i),CD(SCA.LoadCheckArr[i+1],2),CD(SaveRemind,0)},{DisplayText(StrDesignX("\x03SYSTEM \x04: \x07실제시간 \x035분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: 수동저장은 F9를 눌러주세요."),4)},{preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SaveRemind,0),CD(PartyBonus2,1,AtLeast)},{DisplayText(StrDesignX("\x04현재 \x1F멀티 플레이 보너스 버프 \x1C적용중입니다. - \x08공격력 + 150%\x04, \x07+1강 \x17강화확률 + \x0F1.0%p"),4)},{preserved})-- 인원수 버프 보너스
	TriggerX(FP,{LocalPlayerID(i),CV(PLevel[i+1],999,AtMost)},{DisplayText(StrDesignX("\x04현재 \x1F초보자 보너스 버프 \x1C적용중입니다. \x041000레벨 달성 전까지 \x1C경험치 획득량 2배"),4)},{preserved})-- 1000레벨 미만 5퍼센트 강확보너스
	TriggerX(FP,{Switch("Switch 100", Cleared),Switch("Switch 101", Cleared)}, {DisplayText(StrDesignX("\x04TIP : \x04유닛 선택 후 Z키를 누르면 한곳에 뭉칩니다."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Set),Switch("Switch 101", Cleared)}, {DisplayText(StrDesignX("\x04TIP : \x1F미네랄\x04, \x07가스\x04는 현재 자신의 건물을 공격중인 모든 유닛 DPS를 나타냅니다."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Cleared),Switch("Switch 101", Set)}, {DisplayText(StrDesignX("\x04TIP : \x17O키\x04를 누르면 레벨 업을 통해 얻은 스탯을 분배할 수 있습니다."),4)}, {preserved})
	TriggerX(FP,{Switch("Switch 100", Set),Switch("Switch 101", Set)}, {DisplayText(StrDesignX("\x04TIP : \x04강화 성공시 단계가 \x08+1 \x04뿐만 아니라 낮은 확률로 \x1C+2\x04, \x1F+3\x04 도 올라갈 수 있습니다."),4)}, {preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SCA.LoadCheckArr[i+1],2)},{SetMemory(0x58F500, SetTo, 1),},{preserved})
	TriggerX(FP,{LocalPlayerID(i)},{SetCD(SaveRemind,0)},{preserved})

	CIfEnd()--
	if TestStart == 0 then
		for j,k in pairs(BPArr) do
			TriggerX(FP, {Deaths(i, Exactly, 0,14),CV(k[i+1],1,AtLeast)},{SetDeaths(i,SetTo,1,14)})
	
			TriggerX(FP, {CD(SCA.LoadCheckArr[i+1],0),CV(k[i+1],1,AtLeast),LocalPlayerID(i)},{
				SetCp(i),
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayText("B\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
				DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
				SetMemory(0xCDDDCDDC,SetTo,1);
			})
		end
	end
	CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],1)},{SetCD(CheatDetect,0),SetCD(SCA.LoadCheckArr[i+1],2)})--로드 완료시 첫 실행 트리거
		CIfX(FP, {Deaths(i,AtLeast,1,101)})--레벨데이터가 있을경우 로드후 모두 덮어씌움, 없으면 뉴비로 간주하고 로드안함
		for j,k in pairs(SCA_DataArr) do
			SCA_DataLoad(i,k[1][i+1],k[2])
		end
		for j,k in pairs(RSArr) do
			CTrigger(FP, {CV(k[i+1],0)}, {SetV(k[i+1],_Rand())}, 1)
		end
		TriggerX(FP,CD(LimitM[i+1],1),{SetDeaths(i, SetTo, 1, 100)})
		--치팅 테스트 변수 초기화
		CIfX(FP,{CV(PStatVer[i+1],StatVer),Deaths(i,AtMost,0,100)})--스탯버전이 저장된 값과 같거나 제작자가 아닐경우 경우 치팅 감지 작동
		f_LMov(FP, CTPEXP, PEXP[i+1])
		CMov(FP, CTPLevel, 1)
		CMov(FP,CTStatP,5)
		CMov(FP,CTStatP2,StatP[i+1])
		f_LMov(FP, CTCurEXP, 0,nil,nil,1)
		f_LMov(FP, CTTotalExp, "10",nil,nil,1)
		CallTrigger(FP,Call_CT)
		--CAdd(FP,CTStatP2,_Mul(Stat_ScDmg[i+1],_Mov(Cost_Stat_ScDmg)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPerEx[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPerEx)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPerEx2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPerEx2)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPerEx3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPerEx3)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer4[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer4)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_BreakShield[i+1],_Mov(100)),_Mov(Cost_Stat_BreakShield)))
		--CAdd(FP,CTStatP2,_Mul(Stat_SCCool[i+1],_Mov(Cost_Stat_SCCool)))
		CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(Cost_Stat_Upgrade)))
		--CAdd(FP,CTStatP2,_Mul(Stat_AddSc[i+1],_Mov(Cost_Stat_AddSc)))
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
			DisplayText("L\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
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
			SetV(Stat_TotalEPer4[i+1],0),
			SetV(Stat_BreakShield[i+1],0),
			SetV(Stat_TotalEPerEx[i+1],0),
			SetV(Stat_TotalEPerEx2[i+1],0),
			SetV(Stat_TotalEPerEx3[i+1],0),
			SetV(Stat_SCCool[i+1],0),
			SetV(Stat_Upgrade[i+1],0),
			SetV(Stat_AddSc[i+1],0),
			SetCp(i),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. 스탯을 \x1F재 분배 \x04해주세요"), 4),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. 스탯을 \x1F재 분배 \x04해주세요"), 4),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. 스탯을 \x1F재 분배 \x04해주세요"), 4),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. 스탯을 \x1F재 분배 \x04해주세요"), 4),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. 스탯을 \x1F재 분배 \x04해주세요"), 4),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. 스탯을 \x1F재 분배 \x04해주세요"), 4),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. 스탯을 \x1F재 분배 \x04해주세요"), 4),
			SetCp(FP)})
		CIfXEnd()

		
		--CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--제작자 칭호 보유자 스카 6개 추가지급
		
		CElseX()--레벨이 0일 경우 이쪽으로
		SCA_DataLoad(i,PlayTime2[i+1],119)--구 이용시간 불러옴
		CIf(FP,CV(PlayTime2[i+1],1,AtLeast),{SetV(ScTimer[i+1],0),RemoveUnit(88, i),SetCp(i),DisplayText(StrDesignX("\x04테스트 유저 특전으로 다음 보상을 드립니다. \x07다시한번 플레이해주셔서 감사합니다.").."\n"..StrDesignX("\x07기본유닛 6기\x04 지급. \x08주의 \x04: \x07기본유닛\x04은 게임 실행 1회에만 등장하며 3분 뒤 사라집니다."), 4),SetCp(FP)})
			TriggerX(FP,{CV(PlayTime2[i+1],1,AtLeast)},{SetV(CreditAddSC[i+1],1),SetDeaths(i, SetTo, 1, 99)},{preserved})
			CMov(FP,CTimeV,PlayTime2[i+1])
			CallTrigger(FP,Call_ConvertTime)
			DoActions(FP,{SetCp(i)})
			DisplayPrint("CP", {"\x13\x0D\x0D\x0D",PName("LocalPlayerID")," \x04님의 \x10테스트맵 \x04인게임 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
			DisplayPrint("CP", {"\x13\x04총 ",PlayTime2[i+1]," 초 이용으로 \x17",PlayTime2[i+1]," 크레딧\x04 지급됨"})
			f_LAdd(FP,Credit[i+1],Credit[i+1],{PlayTime2[i+1],0}) -- 
			
		CIfEnd()
			
		CIfXEnd()
		TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{SetCp(i),DisplayText(StrDesignX("\x04현재 \x1F초보자 보너스 버프 \x1C적용중입니다. \x041000레벨 달성 전까지 \x1C경험치 획득량 2배"),4)},{preserved})-- 1000레벨 미만 5퍼센트 강확보너스
		CIfOnce(FP, {CV(PStatVer[i+1],4,AtMost)}) --기존 8시간 적용된 쿨 비례해서 낮춰줌
		CDiv(FP, LV5Cool[i+1], 8)
		CIfEnd()
		CMov(FP,PStatVer[i+1],StatVer)--저장 여부에 관계없이 로드완료시 스탯버전 항목 초기화
			
		DoActions(FP, {SetLoc("Location "..(80+i),"U",Add,64),SetLoc("Location "..(80+i),"D",Add,64)})
		CreateUnitStacked({},1,PersonalUIDArr[i+1],36+i,80+i, i,nil, 1) --런쳐 불러오기 성공시 고유유닛 가져오기
		DoActions(FP, {SetLoc("Location "..(80+i),"U",Subtract,64),SetLoc("Location "..(80+i),"D",Subtract,64)})
		CMov(FP,PUnitPtr[i+1],Nextptrs)
	CIfEnd()
	

	if TestStart == 1 then
		local EXPAcc = CreateWar(FP)
		--f_LAdd(FP, EXPAcc, EXPAcc, "10000000000")
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], EXPAcc)
	end
	
	local LevelUpJump = def_sIndex()
	local LIndex = CreateVar(FP) 
	local PrevLMulW = CreateWar(FP)
	local NextLMulW = CreateWar(FP)
	CIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],LevelLimit-1,AtMost)},{})
	ConvertLArr(FP, LIndex, _Sub(PLevel[i+1], 1), 8)
	f_LRead(FP, LArrX({EXPArr},LIndex), PrevLMulW, nil, 1)
	CJumpEnd(FP, LevelUpJump)
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],LevelLimit-1,AtMost)},{AddV(PLevel[i+1],1),AddV(CT_PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	ConvertLArr(FP, LIndex, _Sub(PLevel[i+1], 1), 8)
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
	TriggerX(FP, {CV(PLevel[i+1],9,AtMost),LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x1F레벨이 올랐습니다! \x17O 키\x04를 눌러 \x07능력치\x04를 설정해주세요."))}, {preserved})
	CJump(FP, LevelUpJump)
	NIfEnd()
	CIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})

	
	CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],2)},{})--로드 완료시 첫 실행 트리거
	
	CMov(FP,AddSC[i+1],_Div(PLevel[i+1],1000))
	CMov(FP,ScoutDmg[i+1],_Div(PLevel[i+1],10))
	CMov(FP,SCCool[i+1],_Div(PLevel[i+1],1000))
	TriggerX(FP,CV(AddSC[i+1],5,AtLeast),{SetV(AddSC[i+1],5)},{preserved})
	TriggerX(FP,CV(ScoutDmg[i+1],250,AtLeast),{SetV(ScoutDmg[i+1],250)},{preserved})
	TriggerX(FP,CV(SCCool[i+1],8,AtLeast),{SetV(SCCool[i+1],8)},{preserved})


	
	NReset(FP, NBagArr[i+1])--N가방 리셋
	DoActionsX(FP, {SetV(ScTimer[i+1],0),RemoveUnit(88, i)})--로드성공시 스카타이머 초기화
	for k = 0, 5 do
		CreateUnitStacked({CV(AddSC[i+1],k)},k+1, 88, 36+i,15+i, i, nil, 1)--스카 터졌을경우 다시 지급
	end
	CreateUnitStacked({CV(CreditAddSC[i+1],1,AtLeast)},6, 88, 36+i,15+i, i, nil, 1)--크레딧 스카웃 구입항목 보유자 스카지급

	
	CIfEnd()

	for j,k in pairs(FirstReward) do
		TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetDeaths(i,SetTo,1,13),AddV(B_PEXP[i+1],k[2]),SetCp(i),DisplayText(StrDesignX("\x08"..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[2]).." \x0FＥＸＰ"), 4),SetCp(FP)})
	end
	for j,k in pairs(FirstReward2) do
		TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetDeaths(i,SetTo,1,13),AddV(B_PEXP[i+1],k[2]),SetCp(i),DisplayText(StrDesignX("\x11"..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[2]).." \x17Ｃｒｅｄｉｔ"), 4),SetCp(FP)})
	end

	
	
	CIf(FP,{CV(SCA.GlobalVarArr[4],1),CD(SCA.GlobalCheck2,1),CD(SCA.LoadCheckArr[i+1],2)})--시즌 1호 출석이벤트
		CIf(FP,{TTOR({_TTNVar(DayCheck[i+1],NotSame,SCA.DayV),_TTNVar(MonthCheck[i+1],NotSame,SCA.MonthV),_TTNVar(YearCheck[i+1],NotSame,SCA.YearV)})},{SetDeaths(i,SetTo,1,13)})
			CMov(FP,DayCheck[i+1],SCA.DayV)--날짜에 맞춰짐
			CMov(FP,MonthCheck[i+1],SCA.MonthV)--날짜에 맞춰짐
			CMov(FP,YearCheck[i+1],SCA.YearV)--날짜에 맞춰짐
			DoActionsX(FP,{
				AddV(DayCheck2[i+1],1),
				AddV(B_PCredit[i+1],100000),
				AddV(B_PTicket[i+1],100),SetCp(i),DisplayText(StrDesignX("일일 출석 보상으로 \x04\x17유닛 판매권 500개, 크레딧 5만\x04을 얻었습니다."), 4)})
				local TempV = CreateVar(FP)
				local TempV2 = CreateVar(FP)
				CMov(FP,TempV,_Mod(DayCheck2[i+1],7))
				CMov(FP,TempV2,_Div(DayCheck2[i+1],7))
			CIf(FP,{CV(TempV2,1,AtLeast),CV(TempV2,4,AtMost),CV(TempV,0)})
			DoActionsX(FP, {
				AddV(B_PCredit[i+1],1000000),
				AddV(iv.VaccItem[i+1],10),
				SetCp(i),DisplayText(StrDesignX("누적 출석 보상으로 \x04\x17크레딧 100만, \x10강화기 백신 10개\x04를 얻었습니다."), 4)})
			CIfEnd()
			DisplayPrint(i, {"\x13\x07『 \x04현재까지 총 출석일수 : ",DayCheck2[i+1],"일 \x07』"})
		CIfEnd()
	CIfEnd()


	local CTSwitch = CreateCcode()
	TriggerX(FP,{Deaths(i, Exactly, 1,13),Deaths(i, Exactly, 0,14)},{SetDeaths(i, SetTo, 1,14)},{preserved})
	
	NIf(FP,{CD(SCA.GlobalCheck,3),CD(SCA.LoadCheckArr[i+1],2),Deaths(i, AtLeast, 1,14),},{SetV(DPErT[i+1],24*10)}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 4, 2),SetDeaths(i, SetTo, 2,14),SCA.Reset(i)},{preserved})--저장신호 보내기
	TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--저장트리거 닫고 CT작동
	CIf(FP,Deaths(i,AtLeast,1,100))--제작자일경우 레벨 1으로 저장후 세팅.
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


	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),Deaths(i, Exactly, 0,14),CD(CTSwitch,1)},{SetCD(CTSwitch,0),SetCD(CheatDetect,0)})--세이브 완료후 치팅 검사
	--if TestStart == 1 then
	--	f_LAdd(FP,Credit[i+1],Credit[i+1],"1") -- 진입했냐?
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
	--CMov(FP,0x57f0f0+(i*4),CTStatP)--치팅감지시 스탯정보 표기용 미네랄
	--CMov(FP,0x57f120+(i*4),CTStatP2)--치팅감지시 스탯정보 표기용 가스
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
		DisplayText("S\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 정상저장 후 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})
	CMov(FP,0x57f0f0+(i*4),0)--치팅감지시 스탯정보 표기용 미네랄 초기화
	CMov(FP,0x57f120+(i*4),0)--치팅감지시 스탯정보 표기용 가스 초기화

	
	CIfEnd()


	
	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),CV(CurMission[i+1],#MissionDataTextArr-1,AtMost),})
			CallTriggerX(FP, Call_Print13[i+1],{CV(DPErT[i+1],0)})
		for j,k in pairs(MissionPDataArr[i+1]) do
			Trigger2X(FP, {CV(CurMission[i+1],j-1),CV(DPErT[i+1],0)},  {print_utf8(12,0,MissionDataTextArr[j][1]),SetV(DPErT[i+1],15)}, {preserved})
				local RewardAct = {}
				local MText = "보상 : "
				for l,m in pairs(k[2]) do
					if m>= 1 then
						if l == 1 then
							MText = MText.."\x17"..m.." Credit "
							table.insert(RewardAct,AddV(B_PCredit[i+1],m))
						end
						if l == 2 then
							MText = MText.."\x19"..m.." 유닛 판매권 "
							table.insert(RewardAct,AddV(SellTicket[i+1],m))
						end
						if l == 3 then
							MText = MText.."\x10"..m.." 강화기 백신 "
							table.insert(RewardAct,AddV(iv.VaccItem[i+1],m))
						end
						if l == 4 then
							MText = MText.."\x1F"..m.." EXP "
							table.insert(RewardAct,AddV(B_PEXP[i+1],m))
						end
					end
				end
			Trigger2X(FP,{CV(CurMission[i+1],j-1),k[1]},{{RewardAct,AddV(CurMission[i+1],1),SetCp(i),DisplayText(MissionDataTextArr[j][2], 4),DisplayText(StrDesignX(MText), 4)}})
		end
	CIfEnd()

	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),CV(CurMission[i+1],#MissionDataTextArr,AtLeast),})
	CallTriggerX(FP, Call_Print13[i+1],{CV(DPErT[i+1],0)})
	Trigger2X(FP, {CV(CurMission[i+1],#MissionDataTextArr),CV(DPErT[i+1],0)},  {print_utf8(12,0,"\x07M\x04ission \x1FALL \x07CLEAR"),SetV(DPErT[i+1],15)}, {preserved})
	CIfEnd()
	

	



	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--기본유닛지급
	if Limit == 1 then 
		CIf(FP,{Deaths(i,AtLeast,1,100),Deaths(i,AtLeast,1,553)})
		CreateUnitStacked({}, 12, LevelUnitArr[25][2], 36+i, nil, i)
		--f_LAdd(FP,PEXP[i+1],PEXP[i+1],"500000000")
		CIfEnd()
	end
	
	TriggerX(FP, {Command(i,AtLeast,1,88),CV(ScTimer[i+1],4320)}, {RemoveUnit(88,i)},{preserved}) -- 3분뒤 사라지는 기본유닛
	TriggerX(FP, {CV(ScTimer[i+1],86400)}, {SetV(ResetStat[i+1],1)},{preserved}) -- 1시간뒤 스탯초기화 사용불가
	TriggerX(FP, {CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men"),}, {SetCp(i),DisplayText(StrDesignX("\x04모두 \x08강화에 실패\x04하신 모양이네요... \x0F2강 유닛 1기\x04를 위로 보상으로 지급합니다."), 4),SetCp(FP)}) -- 기본유닛 사라지고 전멸할경우 기회줌
	CreateUnitStacked({CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men")}, 1, LevelUnitArr[2][2], 50+i,36+i, i, nil,1)
	CIf(FP, {CV(ScTimer[i+1],4320,AtMost)})
	local NBTemp = CreateVar(FP)
	local TempSCCool = CreateVar(FP)
	ClShift(FP, TempSCCool, _Sub(_Mov(9),SCCool[i+1]), 8)
	NBagLoop(FP,NBagArr[i+1],{NBTemp})
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
	NBagLoopEnd()
	CIfEnd()
	
	--iv.PUnitLevel

	

	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[15][2])},{SetCp(i),DisplayText(StrDesignX("\x0815강 \x04유닛을 획득하였습니다. \x0815강 \x04유닛부터는 \x17판매\x04를 통해 \x1B경험치\x04를 획득할 수 있습니다.")),SetCp(FP)})
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[26][2])},{SetCp(i),DisplayText(StrDesignX("\x0F26강 \x04유닛을 획득하였습니다. \x0F26강 \x04유닛부터는 \x08보스\x04에 도전할 수 있습니다.")),DisplayText(StrDesignX("\x08보스 \x1C도전 \x07제한시간\x04은 없으며, \x08최대 4기 \x04입장 가능합니다.")),DisplayText(StrDesignX("\x0F26강 \x04유닛부터는 \x19유닛 판매권\x04이 있어야 판매가 가능합니다.")),SetCp(FP)})
	
	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{TempO[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas,TempG[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV3[i+1],"10000000000",nil,{TempX[i+1]},Money[i+1])
--	CIf(FP,{TTNWar(Money[i+1], AtLeast, "15000000000000000000")})--1500경이상일경우
--	f_LSub(FP, Money[i+1], Money[i+1], "10000000000000000000")
--	CAdd(FP,Money2[i+1],1)
--	CIfEnd()
	
	CIf(FP,{CV(Money2[i+1],1,AtLeast)})--800경이하일때 2번째변수가 1이상일경우
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
--		DisplayPrintEr(i, {"\x1F랄네미최소 : ",MinO," \x04|| \x1F랄네미최대 : ",MaxO," \x04|| \x07스가최소 : ",MinG," \x04|| \x07스가최대 : ",MaxG})
--		local temp,PKey = ToggleFunc({KeyPress("V","Up"),KeyPress("V","Down")},nil,1)--누를 경우 초기화
--		CTrigger(FP,{CD(PKey,1)},{SetV(MinO,0xFFFFFFFF)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MinG,0xFFFFFFFF)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MaxO,0)},1)
--		CTrigger(FP,{CD(PKey,1)},{SetV(MaxG,0)},1)
--	end
	

TriggerX(FP, {CV(TempO[i+1],20000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("O\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
	DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

TriggerX(FP, {CV(TempG[i+1],20000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("G\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
	DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

TriggerX(FP, {CV(TempX[i+1],5000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("X\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
	DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})


	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)
	Debug_DPSBuilding(DpsLV3[i+1],173,137+i)
	PBossResetArr = DPSBuilding(i,PBossPtr[i+1],"X",nil,{PBossDPS[i+1]},nil)--

	for j,k in pairs(PBossArr) do
		local LocID = 129+i
		local AddCond = nil
		if j >=6 then LocID = 153+i AddCond = CV(BossLV,5,AtLeast) end
		NIfOnce(FP,{Memory(0x628438,AtLeast,1),CV(PBossPtr[i+1],0),CV(PBossLV[i+1],j-1),AddCond})--보스방 건물 세팅
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
},1)--사냥터 입장
	TriggerX(FP,{CV(CS_DPSLV[i+1],1,AtLeast)},{MoveUnit(1,PersonalUIDArr[i+1],i,22+i,57+i)},{preserved})
	CIfEnd()



	TriggerX(FP, {Bring(i,AtLeast,1,"Men",29+i)}, {MoveUnit(1, "Men", i, 29+i, 36+i)}, {preserved})--사냥터 퇴장

	TriggerX(FP, {Bring(i, AtMost, 3, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--보스방 입장
	TriggerX(FP, {}, {MoveUnit(1, "Factories", i, 111, 36+i)}, {preserved})--보스방 퇴장

	
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 5, "Men", 119+i)}, {MoveUnit(1, "Men", i, 119+i, 22+i)}, {preserved})--개인보스방 입장제한
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 1, 88, 119+i)}, {MoveUnit(1, 88, i, 119+i, 22+i)}, {preserved})--개인보스방 입장제한

	--강화성공한 유닛 생성하기(캔낫씹힘방지)
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], k[1]-1), AtLeast, 1)}, 1, k[2], 50+i,80+i, i, {SetCVAar(VArr(GetUnitVArr[i+1], k[1]-1), Subtract, 1)})
	end
	CIf(FP,{TTNVar(PUnitCurLevel[i+1],NotSame,PUnitClass[i+1])})
	CMov(FP,PUnitClass[i+1],0)


	TriggerX(FP,{CV(CS_Cooldown[i+1],CS_CooldownLimit,AtLeast)},{SetV(CS_Cooldown[i+1],CS_CooldownLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_Atk[i+1],CS_AtkLimit,AtLeast)},{SetV(CS_Atk[i+1],CS_AtkLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_EXP[i+1],CS_EXPLimit,AtLeast)},{SetV(CS_EXP[i+1],CS_EXPLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_TotalEPer[i+1],CS_TotalEPerLimit,AtLeast)},{SetV(CS_TotalEPer[i+1],CS_TotalEPerLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_TotalEper4[i+1],CS_TotalEper4Limit,AtLeast)},{SetV(CS_TotalEper4[i+1],CS_TotalEper4Limit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_DPSLV[i+1],CS_DPSLVLimit,AtLeast)},{SetV(CS_DPSLV[i+1],CS_DPSLVLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_BreakShield[i+1],CS_BreakShieldLimit,AtLeast)},{SetV(CS_BreakShield[i+1],CS_BreakShieldLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정

	CMov(FP,PUnitCurLevel[i+1],PUnitClass[i+1])
	CAdd(FP,PUnitClass[i+1],CS_Cooldown[i+1])
	CAdd(FP,PUnitClass[i+1],CS_Atk[i+1])
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
	
	
	--
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],100)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,2)},1)
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],99,AtMost)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,1)},1)
	CIfEnd()

	TriggerX(FP,{CV(iv.PSaveChk[i+1],1),SCA.SaveCmp(i),CV(EnchCool[i+1],0)},{SetV(iv.PSaveChk[i+1],0),SetCp(i),DisplayText(StrDesignX("\x03SYSTEM \x04: 이제 다시 강화를 진행할 수 있습니다."), 4)},{preserved})
	CallTrigger(FP,Call_BtnInit,{})


	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),CV(RSArr[1][i+1],0)})
		for j = 1,9 do--랜덤값 정렬
			CMov(FP,RSArr[j][i+1],RSArr[j+1][i+1])
		end
		f_Rand(FP,RSArr[10][i+1])--랜덤값 재생성
		
		for j,k in pairs(RSArr) do -- 랜덤 0인거 검사
			CTrigger(FP, {CV(k[i+1],0)}, {SetV(k[i+1],_Rand())}, 1)
		end
	CIfEnd()
	
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
	CElseIfX({TCommand(i,AtLeast,ULimitV2,"Men")})
	CallTrigger(FP,Call_Print13[i+1])
	for j = 1, 7 do
		TriggerX(FP, {LocalPlayerID(i),CV(PCheckV,j)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: 보유 유닛수가 너무 많아 유닛 구입할 수 없습니다.\x08 (최대 "..ULimitArr[j].."기)"))},{preserved})
	end

	
	CIfXEnd()

	
	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--키인식부 시작
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
					SetV(Stat_AddSc[i+1],0),
					SetV(Stat_TotalEPer4[i+1],0),
					SetV(Stat_BreakShield[i+1],0),
					SetV(Stat_TotalEPerEx[i+1],0),
					SetV(Stat_TotalEPerEx2[i+1],0),
					SetV(Stat_TotalEPerEx3[i+1],0),
					SetV(Stat_SCCool[i+1],0),
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
		CIfX(FP,{CV(InterfaceNum[i+1],1)},{})

		--	KeyFunc(i,"1",{
		--		{{CV(StatP[i+1],Cost_Stat_ScDmg,AtLeast),CV(Stat_ScDmg[i+1],249,AtMost)},{SubV(StatP[i+1],Cost_Stat_ScDmg),AddV(Stat_ScDmg[i+1],1)},StrDesign("\x07기본유닛\x1B의 데미지가 증가하였습니다.")},
		--		{{CV(Stat_ScDmg[i+1],250,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x07기본유닛 \x08데미지\x04를 올릴 수 없습니다.")},
		--		{{CV(StatP[i+1],Cost_Stat_ScDmg-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		--	})
		--	if TestStart == 1 then
		--		KeyFunc(i,"2",{
		--			{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],89,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07유닛 데미지\x04가 \x0810% \x04증가하였습니다.")},
		--			{{CV(Stat_Upgrade[i+1],90,AtLeast)},{},StrDesign("\x08ERROR \x04: 더 이상 \x08데미지\x04를 올릴 수 없습니다.")},
		--			{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		--		})
		--	else
		--	KeyFunc(i,"2",{
		--		{{CV(StatP[i+1],Cost_Stat_AddSc,AtLeast),CV(Stat_AddSc[i+1],4,AtMost)},{SubV(StatP[i+1],Cost_Stat_AddSc),AddV(Stat_AddSc[i+1],1)},StrDesign("\x07기본유닛 갯수\x04가 \x0F1기 \x04증가하였습니다.")},
		--		{{CV(Stat_AddSc[i+1],5,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x07기본유닛 갯수\x04를 올릴 수 없습니다.")},
		--		{{CV(StatP[i+1],Cost_Stat_AddSc-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		--	})
		--	end
			KeyFunc(i,"3",{
				{{CV(StatP[i+1],Cost_Stat_Upgrade,AtLeast),CV(Stat_Upgrade[i+1],49,AtMost)},{SubV(StatP[i+1],Cost_Stat_Upgrade),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07유닛 데미지\x04가 \x0810% \x04증가하였습니다.")},
				{{CV(Stat_Upgrade[i+1],50,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상  \x07유닛 \x08데미지\x04를 올릴 수 없습니다.")},
				{{CV(StatP[i+1],Cost_Stat_Upgrade-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
			})
			KeyFunc(i,"4",{
				{{CV(StatP[i+1],Cost_Stat_TotalEPer,AtLeast),CV(Stat_TotalEPer[i+1],9999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer),AddV(Stat_TotalEPer[i+1],100)},StrDesign("\x07총 \x08강화 확률\x04이 증가하였습니다.")},
				{{CV(Stat_TotalEPer[i+1],10000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x07총 \x08강화 확률\x04을 올릴 수 없습니다.")},
				{{CV(StatP[i+1],Cost_Stat_TotalEPer-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
			})
			KeyFunc(i,"5",{
				{{CV(StatP[i+1],Cost_Stat_TotalEPer2,AtLeast),CV(Stat_TotalEPer2[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer2),AddV(Stat_TotalEPer2[i+1],100)},StrDesign("\x07+2강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다.")},
				{{CV(Stat_TotalEPer2[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x07+2강 \x08강화확률\x04을 올릴 수 없습니다.")},
				{{CV(StatP[i+1],Cost_Stat_TotalEPer2-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
			})
			KeyFunc(i,"6",{
				{{CV(StatP[i+1],Cost_Stat_TotalEPer3,AtLeast),CV(Stat_TotalEPer3[i+1],2999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer3),AddV(Stat_TotalEPer3[i+1],100)},StrDesign("\x07+3강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다.")},
				{{CV(Stat_TotalEPer3[i+1],3000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x10+3강 \x08강화확률\x04을 올릴 수 없습니다.")},
				{{CV(StatP[i+1],Cost_Stat_TotalEPer3-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")}, 
			})

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
		CElseIfX({CV(InterfaceNum[i+1],2)},{}) -- 2번 스탯페이지
		KeyFunc(i,"1",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4,AtLeast),CV(Stat_TotalEPer4[i+1],9999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPer4),AddV(Stat_TotalEPer4[i+1],100)},StrDesign("\x08특수 강화확률\x04이 \x0F0.1%p \x04증가하였습니다.")},
			{{CV(Stat_TotalEPer4[i+1],10000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x08특수 \x08강화확률\x04을 올릴 수 없습니다.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPer4-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		})
		KeyFunc(i,"2",{
			{{CV(StatP[i+1],Cost_Stat_BreakShield,AtLeast),CV(Stat_BreakShield[i+1],29999,AtMost)},{SubV(StatP[i+1],Cost_Stat_BreakShield),AddV(Stat_BreakShield[i+1],100)},StrDesign("\x08특수 \x1F파괴 방지확률\x04이 \x0F1.0%p \x04증가하였습니다.")},
			{{CV(Stat_BreakShield[i+1],30000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x1F피괴 \x08방지확률\x04을 올릴 수 없습니다.")},
			{{CV(StatP[i+1],Cost_Stat_BreakShield-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		})
		KeyFunc(i,"3",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx,AtLeast),CV(Stat_TotalEPerEx[i+1],4999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx),AddV(Stat_TotalEPerEx[i+1],100)},StrDesign("\x07총 \x08강화 확률\x04이 증가하였습니다.")},
			{{CV(Stat_TotalEPerEx[i+1],5000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x07총 \x08강화 확률\x04을 올릴 수 없습니다.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		})
		KeyFunc(i,"4",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx2,AtLeast),CV(Stat_TotalEPerEx2[i+1],1999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx2),AddV(Stat_TotalEPerEx2[i+1],100)},StrDesign("\x07+2강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다.")},
			{{CV(Stat_TotalEPerEx2[i+1],2000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x07+2강 \x08강화확률\x04을 올릴 수 없습니다.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx2-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		})
		KeyFunc(i,"5",{
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx3,AtLeast),CV(Stat_TotalEPerEx3[i+1],999,AtMost)},{SubV(StatP[i+1],Cost_Stat_TotalEPerEx3),AddV(Stat_TotalEPerEx3[i+1],100)},StrDesign("\x07+3강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다.")},
			{{CV(Stat_TotalEPerEx3[i+1],1000,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x10+3강 \x08강화확률\x04을 올릴 수 없습니다.")},
			{{CV(StatP[i+1],Cost_Stat_TotalEPerEx3-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
		})
	--	KeyFunc(i,"6",{
	--		{{CV(StatP[i+1],Cost_Stat_SCCool,AtLeast),CV(Stat_SCCool[i+1],7,AtMost)},{SubV(StatP[i+1],Cost_Stat_SCCool),AddV(Stat_SCCool[i+1],1)},StrDesign("\x07기본유닛 \x1B공격속도\x04가 \x04증가하였습니다.")},
	--		{{CV(Stat_SCCool[i+1],8,AtLeast)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 더 이상 \x07기본유닛 \x1B공격속도\x04를 올릴 수 없습니다.")},
	--		{{CV(StatP[i+1],Cost_Stat_SCCool-1,AtMost)},{SetCD(ClickCD, 0)},StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")},
	--	})

		
		CIfXEnd()
	TriggerX(FP, {MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],2,AtLeast),MSQC_KeyInput(i, "I")},{SubV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtMost),MSQC_KeyInput(i, "P")},{AddV(InterfaceNum[i+1],1)},{preserved})
	CIfEnd()
	DoActions(FP, SetCp(FP))--키인식부 종료

	TriggerX(FP,{CV(InterfaceNum[i+1],0),CV(BrightLoc,30,AtMost),LocalPlayerID(i)},{AddV(BrightLoc,1)},{preserved})
	TriggerX(FP,{CV(InterfaceNum[i+1],1,AtLeast),CV(BrightLoc,14,AtLeast),LocalPlayerID(i)},{SubV(BrightLoc,1)},{preserved})
	CDoActions(FP,{TSetMemory(0x657A9C,SetTo,BrightLoc)})

	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--키인식부
	--TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"P")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	--CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetCp(i),CenterView(72),SetCp(FP)})

	--CIfXEnd()






	--총 버프 값 합산
	CMov(FP,Stat_EXPIncome[i+1],0,nil,nil,1)
	CMov(FP,IncomeMax[i+1],12,nil,nil,1)
	CMov(FP,General_Upgrade[i+1],0,nil,nil,1)
	CMov(FP,TotalEPer[i+1],Stat_TotalEPer[i+1],nil,nil,1)
	CMov(FP,TotalEPer2[i+1],Stat_TotalEPer2[i+1],nil,nil,1)
	CMov(FP,TotalEPer3[i+1],Stat_TotalEPer3[i+1],nil,nil,1)
	CMov(FP,TotalEPer4[i+1],Stat_TotalEPer4[i+1],nil,nil,1)
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
	CAdd(FP,TotalEPer[i+1],CS_TEPerData[i+1])
	CAdd(FP,TotalEPer4[i+1],CS_TEPer4Data[i+1])
	CAdd(FP,TotalBreakShield[i+1],CS_BreakShieldData[i+1])
	




	--CTrigger(FP, {CV(Income[i+1],_Add(IncomeMax[i+1], 1),AtLeast),LocalPlayerID(i)}, {
	--	SetCp(i),
	--	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	--	DisplayText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
	--	DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
	--	SetMemory(0xCDDDCDDC,SetTo,1);})
	

--	"\x041단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+3",
--	"\x042단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+3",
--	"\x043단계 \x04: \x0F+1강 확률 \x07+1.0%p, \x1B사냥터 \x07+3, 공격력 + 50%",
--	"\x044단계 \x04: \x0F+1강 확률 \x07+1.5%p, \x1B사냥터 \x07+6, 공격력 + 50%,\x1C추가EXP +10%",
--	"\x045단계 \x04: \x0F+1강 확률 \x07+1.5%p, \x1B사냥터 \x07+9, 공격력 + 100%,\x1C추가EXP +10%",


	--TriggerX(FP,{CountdownTimer(AtLeast, 1)},{AddV(Stat_EXPIncome[i+1],10)},{preserved})--카운트다운 타이머 존재시
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
Trigger2X(FP,{CV(PBossLV[i+1],5,AtLeast)},{
	AddV(B_PTicket[i+1],5), --유닛 판매권 5개
	
})
Trigger2X(FP,{CV(PBossLV[i+1],6,AtLeast)},{
	AddV(B_PCredit[i+1], 150000)
})
Trigger2X(FP,{CV(PBossLV[i+1],7,AtLeast)},{
	AddV(PETicket[i+1], 1)
})

for pb= 1, 7 do
	TriggerX(FP,{LocalPlayerID(i),CV(PBossLV[i+1],pb,AtLeast)},{SetV(Time,(300000)-5000),SetCD(SaveRemind,1),SetCp(i),DisplayText(StrDesignX("\x08"..pb.."단계 \x07개인보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4),SetCp(FP)})
end

CIfOnce(FP, {Command(i, AtLeast, 1, LevelUnitArr[44][2])},{SetCp(i)})

DisplayPrint("CP", {"\x13\x07『 \x04당신의 \x07타임어택 \x10점수\x04는 \x07",TimeAttackScore2[i+1]," \x04점 입니다. \x07』"})
CIfX(FP,{CV(TimeAttackScore[i+1],TimeAttackScore2[i+1],AtMost)},{})
DisplayPrint("CP", {"\x13\x07『 \x07타임어택 \x10점수\x04가 갱신되었습니다! 기존 \x07",TimeAttackScore[i+1]," \x04점을 뛰어넘으셨네요! 축하드립니다! \x07』"})
CDoActions(FP, {SetV(TimeAttackScore[i+1],TimeAttackScore2[i+1])})
CElseX()
DisplayPrint("CP", {"\x13\x07『 기존 \x07",TimeAttackScore[i+1]," \x04점을 뛰어 넘지는 못했네요... 다음판엔 더 힘내봅시다. \x07』"})
CIfXEnd()
CIfEnd()
TriggerX(FP,{CV(PBossLV[i+1],5,AtLeast)},{KillUnitAt(1,13,119+i,FP)})
TriggerX(FP,{CV(PBossLV[i+1],6,AtLeast)},{SetCDX(PBossClearFlag, 1,1)})
TriggerX(FP,{CV(PBossLV[i+1],7,AtLeast)},{SetCDX(PBossClearFlag, 2,2)})



	--if TestStart == 1 then
	--	TriggerX(FP,{},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- 인원수 버프 보너스
	--else
		
		TriggerX(FP,{CD(PartyBonus2,1,AtLeast)},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- 인원수 버프 보너스
	--end
	TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{AddV(Stat_EXPIncome[i+1],10)},{preserved})-- 1000레벨 미만 경치2배

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
	CIf(FP,{CV(B_PEXP[i+1],1,AtLeast)})
	f_LAdd(FP,PEXP[i+1],PEXP[i+1],{B_PEXP[i+1],0}) --
	CMov(FP, B_PEXP[i+1], 0)
	CIfEnd({})
	CIf(FP,{CV(B_PTicket[i+1],1,AtLeast)})
	CAdd(FP,SellTicket[i+1],B_PTicket[i+1]) --
	CMov(FP, B_PTicket[i+1], 0)
	CIfEnd({})

	

	
	DoActionsX(FP,{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 0),SetMemoryB(0x58F32C+(i*15)+12, SetTo, 0),})


	for CBit = 0, 7 do -- 8비트 연산을 통한 업글수치 복사
		TriggerX(FP,{NVar(ScoutDmg[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+12, Add, 2^CBit)},{preserved})
		TriggerX(FP,{NVar(General_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit)},{preserved})
	end
	--if Limit == 1 then--맵제작자용 치트
	--	CIf(FP,{Deaths(i,AtLeast,1,100)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)})
	--	CMov(FP,IncomeMax[i+1],48,nil,nil,1)
	--	CIfEnd()
	--end

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 91)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)},{preserved})--뎀지 오버플로우 방지
	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)},{}) --  유닛 강화시도하기. 39강 이하유닛
	CMov(FP,BreakShield,TotalBreakShield[i+1])
	CMov(FP,GEper,TotalEPer[i+1])
	CMov(FP,GEper2,TotalEPer2[i+1])
	CMov(FP,GEper3,TotalEPer3[i+1])
	CMov(FP,GEper4,TotalEPer[i+1])
	CAdd(FP,GEper4,TotalEPer2[i+1])
	CAdd(FP,GEper4,TotalEPer3[i+1])
	CAdd(FP,GEper4,TotalEPer4[i+1])


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
		TriggerX(FP,{CV(XEper,0)},{MoveUnit(All,UID,i,8+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0),DisplayText(StrDesignX("\x08ERROR \x04: 확률이 부족하여 강화할 수 없습니다..."), 4),SetCp(FP)},{preserved})
		CIfEnd()
	end

	CIfEnd()

	CIf(FP,{Bring(i,AtLeast,1,"Men",73+i)},{}) --  유닛 판매시도하기
		CIfX(FP,{CV(PLevel[i+1],LevelLimit,AtLeast)},{MoveUnit(All,"Men",i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 이미 만렙을 달성하여 판매할 수 없습니다..."), 4),SetCp(FP)})
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
					TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],0,AtMost)},{MoveUnit(All,UID,i,73+i,36+i),SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: \x19유닛 판매권\x04이 부족합니다... \x07L 키\x04로 보유갯수를 확인해주세요."), 4),SetCp(FP)},{preserved})
					CIf(FP,{Bring(i,AtLeast,1,UID,73+i),CV(SellTicket[i+1],1,AtLeast)},{KillUnitAt(1, UID, 73+i, i),SubV(SellTicket[i+1],1)})
					f_LAdd(FP, TempEXPW,TempEXPW, tostring(EXP))
					CIfEnd()
					
				else
					CIf(FP,{Bring(i,AtLeast,1,UID,73+i)},{KillUnitAt(1, UID, 73+i, i)})
					f_LAdd(FP, TempEXPW,TempEXPW, tostring(EXP))
					if j==15 then
						DoActionsX(FP, {SetVX(MissionV[i+1],32,32)})
					end
					CIfEnd()
				end
			else
				
				--CallTriggerX(FP,Call_Print13[i+1],{Bring(i,AtLeast,1,UID,73+i)})
				TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{MoveUnit(1,UID,i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 해당 유닛은 판매할 수 없습니다..."), 4),SetCp(FP)},{preserved})
			end

			
		end
		TriggerX(FP,{Bring(i,AtLeast,1,88,73+i)},{MoveUnit(1,88,i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 해당 유닛은 판매할 수 없습니다..."), 4),SetCp(FP)},{preserved})
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


	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0),SetCD(ResetStatLoc,0)}) -- CAPrint에 전송할 값들
	CallTrigger(FP, Call_GetLocalData)
	f_LMov(FP,MoneyLoc,Money[i+1])
	f_LMov(FP,CredLoc,Credit[i+1])
	f_LMov(FP,ExpLoc,_LSub(PEXP[i+1], CurEXP[i+1]),nil,nil,1)
	f_LMov(FP,TotalExpLoc,_LSub(TotalExp[i+1], CurEXP[i+1]),nil,nil,1)
	TriggerX(FP,{CD(StatEff[i+1],1)},{SetCD(StatEffLoc,1)},{preserved})
	TriggerX(FP,{CV(ResetStat[i+1],1)},{SetCD(ResetStatLoc,1)},{preserved})
	CIfEnd()
	DoActionsX(FP,{SubCD(ZKeyCool[i+1], 1),SubV(EnchCool[i+1], 1)})
		--핫키 QCUnit 등록방지
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
				Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,Simple_CalcLoc(86, -512, -512, 512, 512))
				CDoActions(FP, {AddCD(ZKeyCool[i+1], 24*3),TMoveUnit(All, KSelUID, i, 87, 87)})
				DoActions(FP, {SetCp(i),DisplayText(StrDesignX("\x03SYSTEM \x04: 현재 선택중인 같은 종류의 유닛을 뭉쳤습니다. 쿨타임 : 3초.").."\n"..StrDesignX("\x04이 메세지는 1회만 표기됩니다."),4)}, 1)
				CIfEnd()
				f_LoadCp()
				CElseIfX({MSQC_KeyInput(i,"Z"),CD(ZKeyCool[i+1],1,AtLeast)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 현재 유닛 뭉치기 기능이 쿨타임중입니다."),4)})
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
