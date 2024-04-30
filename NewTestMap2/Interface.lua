function Interface()
	--CheckTrig("Interface_Forward")
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
	local ResetStat2 = iv.ResetStat2
	local General_Upgrade = iv.General_Upgrade--CreateVarArr(7,FP)-- 유닛 공격력 증가량 수치
	local PBossLV = iv.PBossLV -- 개인보스레벨
	local PBossDPS = iv.PBossDPS-- 개인보스DPS
	local TotalPBossDPS = iv.TotalPBossDPS --개인보스DPS 목표치
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
	local TempEXPW = iv.TempEXPW--CreateVar(FP)
	

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
	local Stat_BossSTic = iv.Stat_BossSTic--CreateVarArr(7,FP)-- 사냥터 업글 수치
	local Stat_BossLVUP = iv.Stat_BossLVUP--CreateVarArr(7,FP)-- 사냥터 업글 수치
	local Stat_TotalEPer = iv.Stat_TotalEPer--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPerEx = iv.Stat_TotalEPerEx--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPerEx2 = iv.Stat_TotalEPerEx2--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPerEx3 = iv.Stat_TotalEPerEx3--CreateVarArr(7,FP)-- +1강 확업 수치
	local Stat_TotalEPer2 = iv.Stat_TotalEPer2--CreateVarArr(7,FP)-- +2강 확업 수치
	local Stat_TotalEPer3 = iv.Stat_TotalEPer3--CreateVarArr(7,FP)-- +3강 확업 수치
	local Stat_TotalEPer4 = iv.Stat_TotalEPer4--CreateVarArr(7,FP)-- +3강 확업 수치
	local Stat_TotalEPer4X = iv.Stat_TotalEPer4X--CreateVarArr(7,FP)-- +3강 확업 수치
	local Stat_BreakShield = iv.Stat_BreakShield--CreateVarArr(7,FP)-- +3강 확업 수치
	local Stat_BreakShield2 = iv.Stat_BreakShield2--CreateVarArr(7,FP)-- +3강 확업 수치
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
	local LV5Cool = iv.LV5Cool
	local TimeAttackScore = iv.TimeAttackScore
	local TimeAttackScore48 = iv.TimeAttackScore48
	local TimeAttackScore50 = iv.TimeAttackScore50
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
	local Stat_EXPIncome = iv.Stat_EXPIncome--CreateVarArr(7,FP)-- 경험치 획득량 수치. 사용 미정
	local PEXP2 = iv.PEXP2--CreateVarArr(7, FP) -- 1/10로 나눠 경험치에 더할 값 저장용. 사용 미정
	
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
	
	-- 15강 판매 ok
	-- 인게임 3시간 달성 ok
	-- 강화확률 +1 마스터 ok
	-- 판매권 판매하기 ok
	-- 5보스 5회 격파(한번에) ok
	-- 40강 48마리 생성 ok
	-- 백신 구매하기 ok
	-- 백신을 사용하여 10강 달성 ok
	
	-- 확정권을 사용하여 10강 달성 ok
	
	
	
	
	

	for i = 0, 6 do
		local MissionDataArr = { -- {Cond,RewardArr,Text}  RewardArr = {Credit,SellTicket,VaccItem,EXP,PETicket,FfragItem}
		{{CVX(MissionV[i+1],1,1)},{1000,0,0,1000},"B,N,M키를 눌러 설명서 읽기"},
		{{MemX(Arr(AutoEnchArr2,((2-1)*7)+i), AtLeast, 1)},{1000},"2강 유닛 만들기"},
		{{CV(Income[i+1],12,AtLeast)},{2000},"사냥터에 유닛 12기 채우기"},
		{{MemX(Arr(AutoEnchArr2,((11-1)*7)+i), AtLeast, 1)},{1500},"11강 유닛 만들기"},
		{{MemX(Arr(AutoEnchArr2,((15-1)*7)+i), AtLeast, 1)},{2500},"15강 유닛 만들기"},
		{{NWar(Money[i+1], AtLeast, "5000000")},{1000},"500만원 모으기"},
		{{CV(PBossLV[i+1],1,AtLeast)},{1500},"개인보스 LV.1 처치하기"},
		{{CVX(MissionV[i+1],32,32)},{1000,10,0,500},"15강 유닛 판매하기"},
		{{MemX(Arr(AutoEnchArr2,((20-1)*7)+i), AtLeast, 1)},{5000,0,0,8000},"20강 유닛 만들기"},
		{{CV(PLevel[i+1],50,AtLeast)},{10000},"LV. 50 달성"},
		{{CV(PBossLV[i+1],5,AtLeast)},{15000},"개인보스 LV.5 처치하기"},
		{{CVX(MissionV[i+1],8,8)},{1000},"상점 시민 버튼에서 구입 배율 조정하기"},
		{{CVX(MissionV[i+1],4,4)},{5000,10},"상점에서 유닛 판매권 1개 이상 구입하기"},
		{{CVX(MissionV[i+1],64,64)},{5000,10},"상점에서 유닛 판매권 1개 이상 되팔기"},
		{{MemX(Arr(AutoEnchArr2,((26-1)*7)+i), AtLeast, 1)},{10000,50},"26강 유닛 만들기"},
		{{CV(PlayTime[i+1],3600*3,AtLeast)},{10000,100},"총 플레이 시간 3시간 달성하기"},
		{{CV(PLevel[i+1],100,AtLeast)},{50000},"LV. 100 달성"},
		{{CV(Stat_TotalEPer[i+1],10000,AtLeast)},{10000,100},"강화확률 +1 증가 스탯 마스터"},
		{{MemX(Arr(AutoEnchArr2,((36-1)*7)+i), AtLeast, 1)},{50000,100},"36강 유닛 만들기"},
		{{CV(PLevel[i+1],500,AtLeast)},{100000},"LV. 500 달성"},
		{{MemX(Arr(AutoEnchArr2,((40-1)*7)+i), AtLeast, 1)},{100000,500},"40강 유닛 만들기"},
		{{CV(PLevel[i+1],1000,AtLeast)},{100000},"LV. 1000 달성"},
		{{Command(i, AtLeast, 48, LevelUnitArr[40][2])},{300000,2000},"40강 유닛 48기 보유"},
		{{CVX(MissionV[i+1],256,256)},{50000,500,1},"상점에서 강화기 백신 1개 이상 구입하기"},
		{{CVX(MissionV[i+1],2,2)},{30000,100,3},"고유유닛 강화 시도하기"},
		{{CVX(MissionV[i+1],1024,1024)},{100000,500,1},"상점에서 강화기 백신 1개 이상 되팔기"},
		{{CVX(MissionV[i+1],8192,8192)},{300000},"고유유닛 강화 실패 또는 유지하기"},
		{{CV(PUnitLevel[i+1],10,AtLeast)},{250000,0,5,0,1},"고유유닛 10강 달성하기"},
		{{CVX(MissionV[i+1],16,16)},{100000,500},"고유유닛 승급하기"},
		{{CD(VaccSCount[i+1],5,AtLeast)},{250000,2000},"상점에서 강화기 백신 5개 이상 되팔기"},
		{{CVX(MissionV[i+1],128,128)},{250000,0,3},"강화기 백신 또는 확정 강화권 사용으로 고유유닛 10강 달성하기"},
		{{CV(iv.PMission[i+1],3,AtLeast)},{250000,0,3},"고유유닛 강화 3연속 성공하기"},
		{{MemX(Arr(AutoEnchArr2,((44-1)*7)+i), AtLeast, 1)},{1000000,0,0,0,1},"44강 유닛 만들기"},
		{{CV(PUnitClass[i+1],62,AtLeast)},{3000000,0,0,0,2},"고유유닛 62단 만들기"},
		{{CVX(MissionV[i+1],4096,4096)},{0,60000},"45강 유닛 판매하기"},
		--{{CV(PUnitClass[i+1],262,AtLeast)},{0,0,0,0,0,50000},"고유유닛 262단 만들기"},
		--{{Command(i, AtLeast, 48, LevelUnitArr[46][2])},{0,1000000},"46강 유닛 48기 보유"},

		}
		table.insert(MissionPDataArr,MissionDataArr)
		
	end
	local rewardarr = {0,0,0,0,0}
	os.execute("mkdir " .. "MSQC")
	local CSfile = io.open(FileDirectory .. "sul" .. ".txt", "w")
	io.output(CSfile)
	for j,k in pairs(MissionPDataArr[1]) do
		local MText = "\x07M\x04ission \x08No. \x10"..j.." \x04: "..k[3].." \x04|| \x07보상 \x04: "
		local MText3 = "Mission No. "..j.." : "..k[3].." || 보상 : "
		local MText2 = "\x07M\x04ission \x08No. \x10"..j.." \x04: "..k[3].." \x07CLEAR"
		for l,m in pairs(k[2]) do
			if m>= 1 then
				if l == 1 then
					MText = MText.."\x17("..m.." Credit) "
					MText3 = MText3.."("..m.." Credit) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 2 then
					MText = MText.."\x19("..m.." 유닛 판매권) "
					MText3 = MText3.."("..m.." 유닛 판매권) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 3 then
					MText = MText.."\x10("..m.." 강화기 백신) "
					MText3 = MText3.."("..m.." 강화기 백신) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 4 then
					MText = MText.."\x1F("..m.." EXP) "
					MText3 = MText3.."("..m.." EXP) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 5 then
					MText = MText.."\x1F("..m.." 확정 강화권) "
					MText3 = MText3.."("..m.." 확정 강화권) "
					rewardarr[l] = rewardarr[l]+m
				end
				if l == 6 then
					MText = MText.."\x1F("..m.." 무색 조각) "
					MText3 = MText3.."("..m.." 무색 조각) "
					rewardarr[l] = rewardarr[l]+m
				end
			end
		end
		io.write(MText3.."\n")
		table.insert(MissionDataTextArr,{StrDesign(MText),StrDesignX(MText2)})
	end
	io.write(rewardarr[1].." 크레딧    "..rewardarr[2].." 유닛 판매권    "..rewardarr[3].." 강화기 백신    "..rewardarr[4].." EXP    "..rewardarr[5].." 확정 강화권")
	io.close(CSfile)
	

	CMov(FP,PCheckV,0)
	if Limit == 1 then
		CAdd(FP,GeneralPlayTime,1)
	else
		CAdd(FP,GeneralPlayTime,1)
	end
	--if Limit == 0 then
		TriggerX(FP,{CD(iv.HotTimeBonus,1),CV(GeneralPlayTime,24*60*60*12)},{SetCD(iv.HotTimeBonus,0),SetCD(iv.SpHotTimeBonus,0),RotatePlayer({DisplayTextX(StrDesignX("\x07핫 타임 보너스\x04가 \x06종료되었습니다.\x04(보스 처치 보상은 유지됨)"),4)}, Force1, FP)})
	--end
	for i = 0, 6 do
		TriggerX(FP,{HumanCheck(i,1)},{AddV(PCheckV,1)},{preserved})
		TriggerX(FP,{HumanCheck(i,0)},{RemoveUnit("Men", P12),RemoveUnit("Factories", P12)})
	end
	for i = 1, 7 do
		TriggerX(FP,{CV(PCheckV,i)},{SetV(ULimitV,ULimitArr[i]),SetV(ULimitV2,ULimitArr[i]-1)},{preserved})
	end
	if Limit == 1 then
		DoActionsX(FP,{SetV(PCheckV,7),SetCD(PartyBonus,2)})
	end
	local PartyBonus2 = iv.PartyBonus2
	DoActions(FP, SetMemory(0x58F500, SetTo, 0))
	
	Trigger2X(FP, {CD(PartyBonus,2,AtLeast)}, {RotatePlayer({DisplayTextX(StrDesignX("\x04런쳐 로드 인원이 2명 이상 감지되었습니다. \x07이제부터 1인 진행으로 파티 버프가 활성화됩니다."))}, Force1, FP)})
	Trigger2X(FP, {CD(PartyBonus,2,AtLeast)}, {SetCD(PartyBonus2,1)},{preserved})
	
	Trigger2X(FP, {CD(PartyBonus,1,AtMost),CV(PCheckV,2,AtLeast)}, {SetCD(PartyBonus2,1)},{preserved})--런쳐 불러온사람 1명이하인데 멀티일경우 보너스 활성화
	Trigger2X(FP, {CD(PartyBonus,1,AtMost),CV(PCheckV,1,AtMost)}, {SetCD(PartyBonus2,0)},{preserved})-- 런쳐 불러온사람 1명이하인데 솔로일경우 보너스 비활성화
	if TestStart == 1 then
		DoActionsX(FP, {AddV(XEPerT,100)})
		
	end
	DoActionsX(FP, {AddV(XEPerT,1),SetCD(iv.BossInv,0)})
	Trigger2X(FP,{CV(XEPerT,864,AtLeast)},{SubV(XEPerT,864),AddV(XEPerM,1),
	--RotatePlayer({DisplayTextX(StrDesignX("\x1F44강\x04~\x1E46강 \x04유닛의 \x08강화확률이 \x0F0.1%p \x08하락\x04하였습니다.\x07"), 4),DisplayTextX(StrDesignX("\x1F44강\x04~\x1E46강 \x04유닛의 강화확률은 1시간마다 0.1%p씩 하락합니다.\x07"), 4)}, Force1, FP),
},{preserved})

	
TipArr = {
	StrDesignX("\x04TIP : \x04유닛 선택 후 Z키를 누르면 한곳에 뭉칩니다."),	StrDesignX("\x04TIP : \x1F미네랄\x04, \x07가스\x04는 현재 자신의 건물을 공격중인 모든 유닛 DPS를 나타냅니다."),
	StrDesignX("\x04TIP : \x17O키\x04를 누르면 레벨 업을 통해 얻은 스탯을 분배할 수 있습니다."),
	StrDesignX("\x04TIP : \x04강화 성공시 단계가 \x08+1 \x04뿐만 아니라 낮은 확률로 \x1C+2\x04, \x1F+3\x04 도 올라갈 수 있습니다."),}

for i = 0, 6 do -- 각플레이어 
	CIf(FP,{HumanCheck(i,1)},{SetCp(i),SetV(GCP,i),SetNWar(GCPW,SetTo,tostring(i)),SetV(VArrI,604*i),SetV(VArrI4,2416*i),SetNWar(WArrI, SetTo, {604*i,604*i}),SetNWar(WArrI4, SetTo, {2416*i,2416*i})})
	--CheckTrig("Interface_Start_P"..(i+1))
	TriggerX(FP,{MSQC_KeyInput(i, "B")},{SetVX(MissionV[i+1],1,1)},{preserved})
	TriggerX(FP,{MSQC_KeyInput(i, "N")},{SetVX(MissionV[i+1],1,1)},{preserved})
	TriggerX(FP,{MSQC_KeyInput(i, "M")},{SetVX(MissionV[i+1],1,1)},{preserved})
	TriggerX(FP,{CD(SCA.LoadCheckArr[i+1],1,AtMost)},{AddCD(iv.BossInv,1)},{preserved})
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
	CDoActions(FP,{TSetScore(i,SetTo,PLevel[i+1],Custom),AddV(ScTimer[i+1],1),AddV(PTimeV[i+1],1),SubV(DPErT[i+1],1),SetSwitch("Switch 100",Random),SetSwitch("Switch 101",Random)})
	TriggerX(FP,CV(PTimeV[i+1],24,AtLeast), {SubV(PTimeV[i+1],24),AddV(PlayTime[i+1],1),SubV(TimeAttackScore2[i+1],1),AddV(iv.CurPlayTime[i+1],1)},{preserved})


	TriggerX(FP,{LocalPlayerID(i),Command(i,AtMost,1,"Men"),Command(i,AtMost,0,"Factories"),CV(Time2,60000,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(Time2,0),SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: 보유 유닛이 없을 경우 \x07실제시간 \x031분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: 수동저장은 F9를 눌러주세요."),4)},{preserved})
	CIf(FP,{LocalPlayerID(i),CV(Time,300000,AtLeast)},{SubV(Time,300000)})
	TriggerX(FP,{LocalPlayerID(i),CD(SCA.LoadCheckArr[i+1],2),CD(SaveRemind,0)},{DisplayText(StrDesignX("\x03SYSTEM \x04: \x07실제시간 \x035분\x04마다 \x1C자동저장 \x04됩니다. \x07저장중..."), 4),DisplayText(StrDesignX("\x03SYSTEM \x04: 수동저장은 F9를 눌러주세요."),4)},{preserved})
	TriggerX(FP,{LocalPlayerID(i),CD(SaveRemind,0),CD(PartyBonus2,1,AtLeast)},{DisplayText(StrDesignX("\x04현재 \x1F멀티 플레이 보너스 버프 \x1C적용중입니다. - \x08공격력 + 150%\x04, \x07+1강 \x17강화확률 + \x0F1.0%p"),4)},{preserved})-- 인원수 버프 보너스
	TriggerX(FP,{LocalPlayerID(i),CV(PLevel[i+1],999,AtMost)},{DisplayText(StrDesignX("\x04현재 \x1F초보자 보너스 버프 \x1C적용중입니다. \x041000레벨 달성 전까지 \x1C판매시 경험치 획득량 2배"),4)},{preserved})-- 1000레벨 미만 5퍼센트 강확보너스
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
	CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],1)},{SetCD(CheatDetect,0),SetCD(StatTest, 0),SetCD(FStatTest, 0),SetCD(SCA.LoadCheckArr[i+1],2),SetV(TimeAttackScore2[i+1],TimeScoreInit)})--로드 완료시 첫 실행 트리거
		CIfX(FP, {TDeaths(_Add(SCA.PLevel,18*i),AtLeast,1,0)})--레벨데이터가 있을경우 로드후 모두 덮어씌움, 없으면 뉴비로 간주하고 로드안함

		CallTrigger(FP,Call_SCA_DataLoadAll)
		for j,k in pairs(SCA_DataArr) do
			--SCA_DataLoad(i,k[1][i+1],k[2])
		end


		--TriggerX(FP,{CV(LV5Cool[i+1],1,AtLeast)},SetCD(BossLV6Private[i+1],0x32223222))
		--치팅 테스트 변수 초기화]
		NIfX(FP,{CV(iv.FStatVer[i+1],StatVer2)},{SetNWar(TempFfragTotal,SetTo,"0")})--스탯버전이 저장된 값과 같거나 제작자가 아닐경우 경우 치팅 감지 작동
		local FStatTestJump = def_sIndex()
		CallTrigger(FP,Call_FCT)
		NJump(FP, FStatTestJump, CD(FStatTest,1,AtLeast))
		NElseX()
		NJumpEnd(FP, FStatTestJump)--스탯 무결성 검사 실패시 자동으로 초기화
		DoActionsX(FP, {
			SetV(iv.FXPer44[i+1],0),
			SetV(iv.FXPer45[i+1],0),
			SetV(iv.FXPer46[i+1],0),
			SetV(iv.FXPer47[i+1],0),
			SetV(iv.FIncm[i+1],0),
			SetV(iv.FSEXP[i+1],0),
			SetV(iv.FMEPer[i+1],0),
			SetV(iv.FBrSh[i+1],0),
			SetV(iv.FXPer48[i+1],0),
			SetV(iv.FMin[i+1],0),
			SetV(iv.FAcc[i+1],0),
			SetV(iv.FAcc2[i+1],0),
			SetV(iv.FBrSh2[i+1],0),
			SetV(iv.FMEPer2[i+1],0),
			SetV(iv.FMinMax[i+1],0),
			SetNWar(iv.FfragItemUsed[i+1],SetTo,"0"),
		})
		CTrigger(FP, {TTNVar(iv.FStatVer[i+1], NotSame, StatVer2)}, {SetCp(i),
		DisplayText(StrDesignX("\x04보석 설정이 \x07초기화\x04되었습니다. \x08사유 \x04: \x07버전 업"), 4),}, 1)
		--TriggerX(FP,{CV(iv.FStatVer[i+1],3,AtMost)},{DisplayText("\x13\x043.10 버전에서 일부 플레이어의 뽑기 난수값이 고정되어 한 결과만 나오는 심각한 버그가 있었습니다. \n\x13\x04이에 따른 조치로 모든 플레이어 정보를 3.11 업데이트 이전으로 롤백, 복구하는 점검이 있었습니다.\n\x13\x04점검 보상으로 \x02무색 조각 10만개\x04와 \x171000만 크레딧\x04이 지급되었습니다. 이용에 불편을 드려 죄송합니다. \x07다시보기 : N 키", 4),AddV(iv.B_PFfragItem[i+1],100000),AddV(iv.B_PCredit[i+1],10000000)},{preserved})
		for h = 1, 4 do
			local NBit = 2^(h-1)
			CTrigger(FP, {CDX(FStatTest,NBit,NBit)}, {SetCp(i),
			DisplayText(StrDesignX("\x04보석 설정이 \x07초기화\x04되었습니다. \x08사유 \x04: \x02보석 데이터 무결성 검사 실패. \x04실패코드 : "..h), 4),}, 1)
		end
		
		NIfXEnd()
		NIfX(FP,{CV(PStatVer[i+1],StatVer)},{})--스탯버전이 저장된 값과 같거나 제작자가 아닐경우 경우 치팅 감지 작동
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
		NElseX()--새 스탯 버전이 감지될 경우 치팅감지 작동X, 스탯을 초기화함
		NJumpEnd(FP, StatTestJump)--스탯 무결성 검사 실패시 자동으로 초기화

		CTrigger(FP, {TTNVar(PStatVer[i+1], NotSame, StatVer)}, {SetCp(i),
		DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. \x08사유 \x04: \x07버전 업"), 4),}, 1)
		for h = 1, 5 do
			local NBit = 2^(h-1)
			CTrigger(FP, {CDX(StatTest,NBit,NBit)}, {SetCp(i),
			DisplayText(StrDesignX("\x04스탯이 \x07초기화\x04되었습니다. \x08사유 \x04: \x10레벨, 스탯 무결성 검사 실패. \x04실패코드 : "..h), 4),}, 1)
		end
		--CIf(FP,{CV(PStatVer[i+1], 14,AtMost)})
		--	CTrigger(FP, {CV(SCA.WeekV,4),CV(iv.WeekCheck[i+1],3)}, {SetV(iv.FirstRewardLim2[i+1],0),SetV(iv.WeekCheck[i+1],SCA.WeekV),SetCp(i),
		--	DisplayText(StrDesignX("\x04주간 첫 달성 보상 남은횟수가 \x07초기화\x04되었습니다. \x08사유 \x04: 주간 글로벌 데이터 버그로 인한 조치"), 4)})

		--CIfEnd()
		CIf(FP,CD(StatTest,1,AtLeast))
		--DisplayPrint(i, {"\x13\x07『 \x03SYSTEM Message \x04- \x04CTPLevel : ",CTPLevel,"    PLevel : ",PLevel[i+1]," \x07』"})
		--DisplayPrint(i, {"\x13\x07『 \x03SYSTEM Message \x04- \x04CTStatP : ",CTStatP,"    CTStatP2 : ",CTStatP2," \x07』"})

		TriggerX(FP,{CDX(StatTest,2^(6-1),2^(6-1)),LocalPlayerID(i)},{
			SetCp(i),
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("LV\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
			DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
			SetMemory(0xCDDDCDDC,SetTo,1);

		})

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

		
		--CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--제작자 칭호 보유자 스카 6개 추가지급
		
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
				DisplayText("LB\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
				DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
				SetMemory(0xCDDDCDDC,SetTo,1);})
		CElseX()--레벨이 0일 경우 이쪽으로
		SCA_DataLoad(i,PlayTime2[i+1],SCA.PlayTime2)--구 이용시간 불러옴
		SCA_DataLoad(i,iv.TesterFlag[i+1],SCA.TesterFlag)--테스터플래그 불러옴
		TriggerX(FP,{CV(iv.TesterFlag[i+1],1,AtLeast)},{SetV(ScTimer[i+1],0),RemoveUnit(88, i),SetCp(i),DisplayText(StrDesignX("\x04테스트 유저 특전으로 다음 보상을 드립니다. \x07다시한번 플레이해주셔서 감사합니다.").."\n"..StrDesignX("\x07기본유닛 6기\x04 지급. \x08주의 \x04: \x07기본유닛\x04은 게임 실행 1회에만 등장하며 3분 뒤 사라집니다."), 4),SetCp(FP)})
		CIf(FP,{CV(PlayTime2[i+1],1,AtLeast)},{SetV(ScTimer[i+1],0),RemoveUnit(88, i),SetCp(i),DisplayText(StrDesignX("\x04테스트 유저 특전으로 다음 보상을 드립니다. \x07다시한번 플레이해주셔서 감사합니다.").."\n"..StrDesignX("\x07기본유닛 6기\x04 지급. \x08주의 \x04: \x07기본유닛\x04은 게임 실행 1회에만 등장하며 3분 뒤 사라집니다."), 4),SetCp(FP)})
			TriggerX(FP,{CV(PlayTime2[i+1],1,AtLeast)},{SetVX(iv.TesterFlag[i+1],1,1)},{preserved})
			CMov(FP,CTimeV,PlayTime2[i+1])
			CallTrigger(FP,Call_ConvertTime)
			DoActions(FP,{SetCp(i)})
			DisplayPrint("CP", {"\x13\x0D\x0D\x0D",PName("LocalPlayerID")," \x04님의 \x10베타 테스트맵 \x04인게임 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
			DisplayPrint("CP", {"\x13\x04총 ",PlayTime2[i+1]," 초 이용으로 \x17",PlayTime2[i+1]," 크레딧\x04 지급됨"})
			f_LAdd(FP,Credit[i+1],Credit[i+1],{PlayTime2[i+1],0}) -- 
		CIfEnd()
			
		CIfXEnd()
		--CIfOnce(FP, {CV(PStatVer[i+1],4,AtMost)}) --기존 8시간 적용된 쿨 비례해서 낮춰줌
		--CDiv(FP, LV5Cool[i+1], 8)
		--CIfEnd()
		
		
		TriggerX(FP, {CV(PStatVer[i+1],10,AtMost)}, {SetDeaths(i,SetTo,1,50),SetCp(i),
		DisplayText(StrDesignX("\x11칭호 \x04 명령어가 새로 추가되었습니다. 사용법 : @칭호 도움말"),4),
		DisplayText(StrDesignX("\x11칭호 \x04 명령어가 새로 추가되었습니다. 사용법 : @칭호 도움말"),4),
		DisplayText(StrDesignX("\x11칭호 \x04 명령어가 새로 추가되었습니다. 사용법 : @칭호 도움말"),4),
	}, {preserved})--10 이전버전 유저 칭호설정값
		CMov(FP,PStatVer[i+1],StatVer)--저장 여부에 관계없이 로드완료시 스탯버전 항목 초기화
		CMov(FP,iv.FStatVer[i+1],StatVer2)--저장 여부에 관계없이 로드완료시 스탯버전 항목 초기화
			
		DoActions(FP, {SetLoc("Location "..(80+i),"U",Add,64),SetLoc("Location "..(80+i),"D",Add,64)})
		CreateUnitStacked({},1,PersonalUIDArr[i+1],36+i,80+i, i,nil, 1) --런쳐 불러오기 성공시 고유유닛 가져오기
		DoActions(FP, {SetLoc("Location "..(80+i),"U",Subtract,64),SetLoc("Location "..(80+i),"D",Subtract,64)})
		CMov(FP,PUnitPtr[i+1],Nextptrs)
		CMov(FP,LV5Cool[i+1],0)
		if Limit == 1 then --테스트 참가 유저 테스터유저 칭호 지급
			TriggerX(FP, {}, {SetCp(i),DisplayText(StrDesignX("\x07테스트 맵\x04에서의 SCA 로드가 \x10감지\x04되었습니다! 테스트맵 플레이에 협조해 주셔서 감사합니다."), 4)}, {preserved})
			TriggerX(FP, {CVX(iv.TesterFlag[i+1],0,2)}, {SetVX(iv.TesterFlag[i+1],2,2),SetCp(i),DisplayText(StrDesignX("\x07테스터 보상\x04이 지급되었습니다!!!").."\n"..StrDesignX("보상내용 : \x04시즌2 \x1F테스터 \x04칭호(영구지급)"), 4)}, {preserved})
		end
		CTrigger(FP, {TTNWar(iv.FfragItem[i+1],AtMost,"99999")}, {SetNWar(iv.FfragItem[i+1], SetTo,"100000")},{preserved})
		CIf(FP,{CV(iv.CSX_LV3Incm[i+1],1,AtLeast)})
		local TempAwak = CreateVar(FP)
		f_Read(FP,FArr(CSXAwakItemArr,iv.CSX_LV3Incm[i+1]),TempAwak,nil,nil,1)
		--if Limit == 1 then 
		--	f_LAdd(FP, iv.BuyTicket[i+1],iv.BuyTicket[i+1],_LMul({TempAwak,0}, "1000000"))
		--else 
		--end
		f_LAdd(FP, iv.BuyTicket[i+1],iv.BuyTicket[i+1],_LMul({TempAwak,0}, "10000"))
		DisplayPrint(i, {"\x13\x07『 \x1E각성 ",iv.CSX_LV3Incm[i+1]," \x04회에 따라 \x08구입 티켓\x04이 지급됩니다. 지급 갯수 : \x07",iv.BuyTicket[i+1]," 개 \x07』"})
		CIfEnd()
	CIfEnd()
	
	TriggerX(FP, {CV(iv.RankTitle[i+1],1,AtLeast)}, {SetCp(i),
	DisplayText(StrDesignX("\x1F와우! \x04순위권 유저시군요! \x03@칭호 3-1 \x04명령어로 랭커 전용 칭호를 사용할 수 있습니다."),4),
	})--순위권 알림
	TriggerX(FP, {CV(iv.RankTitle2[i+1],1,AtLeast)}, {SetCp(i),
	DisplayText(StrDesignX("\x1F와우! \x04순위권 유저시군요! \x03@칭호 3-2 \x04명령어로 랭커 전용 칭호를 사용할 수 있습니다."),4),
	})--순위권 알림
	TriggerX(FP, {CV(iv.RankTitle3[i+1],1,AtLeast)}, {SetCp(i),
	DisplayText(StrDesignX("\x1F와우! \x04순위권 유저시군요! \x03@칭호 3-3 \x04명령어로 랭커 전용 칭호를 사용할 수 있습니다."),4),
	})--순위권 알림


	CIf(FP,{CV(B_PEXP2[i+1],1,AtLeast)})
	CIf(FP,{CV(PLevel[i+1],LevelLimit-1,AtMost)})
	f_LAdd(FP,PEXP[i+1],PEXP[i+1],{B_PEXP2[i+1],0}) --
	CIfEnd()

	CMov(FP, B_PEXP2[i+1], 0)

	CIfEnd({})
	if Limit == 1 then
		local EXPAcc = CreateWar(FP)
		--f_LAdd(FP, EXPAcc, EXPAcc, "100000000000")
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], EXPAcc)
		if SpeedTestMode == 1 then
			if SpeedTestOp == 1 then
				f_LAdd(FP, Money[i+1], Money[i+1], "15000000")
				DoActionsX(FP,{
					SetV(AutoBuyCode[i+1],1),SetDeathsX(i,SetTo,2,3,2)},1)
			elseif SpeedTestOp == 2 then
				f_LAdd(FP, Money[i+1], Money[i+1], "15000000")
				DoActionsX(FP,{
					SetNWar(iv.BuyTicket[i+1],SetTo,"845648648"),
					SetV(AutoBuyCode[i+1],1),
					SetV(iv.AutoBuyCode2[i+1],1),SetDeathsX(i,SetTo,2,3,2)},1)
			end
		end
	end
	
	local LevelUpJump = def_sIndex()
	local LIndex = CreateVar(FP) 
	local PrevLMulW = CreateWar(FP)
	local NextLMulW = CreateWar(FP)
	CIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],LevelLimit-1,AtMost)},{})
	ConvertLArr(FP, LIndex, _Add(PLevel[i+1], 150), 8)--151 포커스
	f_LRead(FP, LArrX({EXPArr},LIndex), PrevLMulW, nil, 1)
	CJumpEnd(FP, LevelUpJump)
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],LevelLimit-1,AtMost)},{AddV(PLevel[i+1],1),AddV(CT_PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	ConvertLArr(FP, LIndex, _Add(PLevel[i+1], 150), 8)--151 포커스
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

	if SlotEnable== 0 then
		CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],2)},{})--로드 완료시 첫 실행 트리거--SetCD(SCA.LoadSlot1[i+1],1)
	else
		CIfOnce(FP,{CD(SCA.LoadCheckArr[i+1],2)},{SetCD(SCA.LoadSlot1[i+1],1)})--로드 완료시 첫 실행 트리거--
	end
	
	CMov(FP,AddSC[i+1],_Div(PLevel[i+1],_Mov(1000)))
	CMov(FP,ScoutDmg[i+1],_Div(PLevel[i+1],_Mov(10)))
	CMov(FP,SCCool[i+1],_Div(PLevel[i+1],_Mov(1000)))
	TriggerX(FP,CV(AddSC[i+1],5,AtLeast),{SetV(AddSC[i+1],5)},{preserved})
	TriggerX(FP,CV(ScoutDmg[i+1],250,AtLeast),{SetV(ScoutDmg[i+1],250)},{preserved})
	TriggerX(FP,CV(SCCool[i+1],8,AtLeast),{SetV(SCCool[i+1],8)},{preserved})
	CDoActions(FP,{TSetDeathsX(i,SetTo,iv.SettingEffSound[i+1],3,3)})

	
	DoActionsX(FP, {SetV(ScTimer[i+1],0),RemoveUnit(88, i)})--로드성공시 스카타이머 초기화
	for k = 0, 5 do
		CreateUnitStacked({CV(AddSC[i+1],k)},k+1, 88, 36+i,15+i, i, nil, 1)--스카 터졌을경우 다시 지급
	end
	CreateUnitStacked({},6, 88, 36+i,15+i, i, nil, 1)--크레딧 스카웃 구입항목 보유자 스카지급 = 이제부터 상시로 돌아감

	
	CIfEnd()

	for j,k in pairs(FirstReward) do
		TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetDeaths(i,SetTo,1,13),AddV(B_PEXP[i+1],k[2]),SetCp(i),DisplayText(StrDesignX("\x08"..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[2]).." \x0FＥＸＰ"), 4),SetCp(FP)})
	end
	for j,k in pairs(FirstReward2) do
		TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])},{SetDeaths(i,SetTo,1,13),AddV(B_PCredit[i+1],k[2]),SetCp(i),DisplayText(StrDesignX("\x11"..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[2]).." \x17Ｃｒｅｄｉｔ"), 4),SetCp(FP)})
	end
	for j,k in pairs(FirstReward3) do -- j == 1~4
		local NMask = 256^(j-1)
		CIfOnce(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])})
			CIfX(FP,{CVX(iv.FirstRewardLim[i+1],NMask*(k[5]-1),NMask*255,AtMost)},{AddVX(iv.FirstRewardLim[i+1],NMask*1,NMask*255),SetDeaths(i,SetTo,1,13),AddV(B_PCredit[i+1],k[2]),SetCp(i),DisplayText(StrDesignX(k[4]..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[2]).." \x17Ｃｒｅｄｉｔ"), 4),DisplayText(StrDesignX("\x08"..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[3]).." \x02 무색 조각"), 4),SetCp(FP)})
			
			f_LAdd(FP, iv.FfragItem[i+1], iv.FfragItem[i+1], tostring(k[3]))
			CElseX()
				TriggerX(FP,{},{SetCp(i),DisplayText(StrDesignX("\x04오늘은 더이상 "..k[4]..k[1].."강 \x07최초 달성 보상\x04을 얻을 수 없어요. 내일 다시 도전해주세요!"), 4),SetCp(FP)},{preserved})
			CIfXEnd()
			local TempV = CreateVar(FP)
			CMov(FP,TempV,iv.FirstRewardLim[i+1],nil,NMask*255)
			if j>=2 then
				CrShift(FP,TempV,(j-1)*8)
			end
			DisplayPrint(i, {"\x13\x07『 \x04오늘의 "..k[4]..k[1].."강 \x07최초 달성 보상 \x04수령 횟수 : \x07",TempV," / \x0F"..k[5].." 회 \x07』"})
		CIfEnd()
	end
	for j,k in pairs(FirstReward4) do -- j == 1~4
		local NMask = 256^(j-1)
		CIfOnce(FP,{Command(i,AtLeast,1,LevelUnitArr[k[1]][2])})
			CIfX(FP,{CVX(iv.FirstRewardLim2[i+1],NMask*(k[5]-1),NMask*255,AtMost)},{AddVX(iv.FirstRewardLim2[i+1],NMask*1,NMask*255),SetDeaths(i,SetTo,1,13),SetCp(i),DisplayText(StrDesignX(k[4]..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[2]).."억 \x17Ｃｒｅｄｉｔ"), 4),DisplayText(StrDesignX("\x08"..k[1].."강 \x04유닛 \x07최초 \x11달성 \x04보상! : \x1F"..Convert_Number(k[3]).." \x02 무색 조각"), 4),SetCp(FP)})
			f_LAdd(FP, Credit[i+1], Credit[i+1], k[2].."00000000")
			f_LAdd(FP, iv.FfragItem[i+1], iv.FfragItem[i+1], tostring(k[3]))
			CElseX()
				TriggerX(FP,{},{SetCp(i),DisplayText(StrDesignX("\x04이번 주는 더이상 "..k[4]..k[1].."강 \x07최초 달성 보상\x04을 얻을 수 없어요. \x07매주 목요일\x04에 다시 도전해주세요!"), 4),SetCp(FP)},{preserved})
			CIfXEnd()
			local TempV = CreateVar(FP)
			CMov(FP,TempV,iv.FirstRewardLim2[i+1],nil,NMask*255)
			if j>=2 then
				CrShift(FP,TempV,(j-1)*8)
			end
			DisplayPrint(i, {"\x13\x07『 \x04이번주 "..k[4]..k[1].."강 \x07최초 달성 보상 \x04수령 횟수 : \x07",TempV," / \x0F"..k[5].." 회 \x07』"})
		CIfEnd()
	end


--\x1C45강
--\x1E46강
--\x0247강
--\x1B48강
	CIf(FP,CD(SCA.LoadCheckArr[i+1],2))--출석트리거는 로드해야 작동됨
--	if TestStart == 1 then
--		NIfX(FP,{VRange(SCA.MinV,0,59),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),TTOR({_TTNVar(DayCheck[i+1],NotSame,SCA.MinV),_TTNVar(MonthCheck[i+1],NotSame,SCA.MonthV),_TTNVar(YearCheck[i+1],NotSame,SCA.YearV)})},{SetDeaths(i,SetTo,1,13)})
--			CMov(FP,DayCheck[i+1],SCA.MinV)--날짜에 맞춰짐
--	else
--		NIfX(FP,{VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),TTOR({_TTNVar(DayCheck[i+1],NotSame,SCA.DayV),_TTNVar(MonthCheck[i+1],NotSame,SCA.MonthV),_TTNVar(YearCheck[i+1],NotSame,SCA.YearV)})},{SetDeaths(i,SetTo,1,13)})
--			CMov(FP,DayCheck[i+1],SCA.DayV)--날짜에 맞춰짐
--	end
		NIfX(FP,{VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),TTOR({_TTNVar(DayCheck[i+1],NotSame,SCA.DayV),_TTNVar(MonthCheck[i+1],NotSame,SCA.MonthV),_TTNVar(YearCheck[i+1],NotSame,SCA.YearV)})},{SetDeaths(i,SetTo,1,13)})
			

	local PrevDate = CreateVar(FP)
	f_Read(FP, FArr(YearData, _Sub(YearCheck[i+1],1)), PrevDate)
	LeafyearFlag = CreateCcode()
	DoActionsX(FP, {SetCD(LeafyearFlag, 0)})
	local TmpV1 =CreateVar(FP)
	local TmpV2 =CreateVar(FP)
	local TmpV3 =CreateVar(FP)
	f_Mod(FP,TmpV1,YearCheck[i+1],4)
	f_Mod(FP,TmpV2,YearCheck[i+1],100)
	f_Mod(FP,TmpV3,YearCheck[i+1],400)
	CIf(FP, {CV(TmpV1,0)})
		CIfX(FP,{CV(TmpV2,0)})
			TriggerX(FP,{CV(TmpV3,0)},{SetCD(LeafyearFlag, 1)},{preserved})
		CElseX({SetCD(LeafyearFlag, 1)})
		CIfXEnd()
	CIfEnd()

	CAdd(FP,PrevDate,_ReadF(FArr(MonthData, _Sub(MonthCheck[i+1],1))))
	TriggerX(FP,{CV(MonthCheck[i+1],3,AtLeast),CD(LeafyearFlag,1)},{AddV(PrevDate,1)},{preserved})
	CAdd(FP,PrevDate,DayCheck[i+1])


	local NextDate = CreateVar(FP)
	f_Read(FP, FArr(YearData, _Sub(SCA.YearV,1)), NextDate)
	
	f_Mod(FP,TmpV1,SCA.YearV,4)
	f_Mod(FP,TmpV2,SCA.YearV,100)
	f_Mod(FP,TmpV3,SCA.YearV,400)
	CIf(FP, {CV(TmpV1,0)})
		CIfX(FP,{CV(TmpV2,0)})
			TriggerX(FP,{CV(TmpV3,0)},{SetCD(LeafyearFlag, 1)},{preserved})
		CElseX({SetCD(LeafyearFlag, 1)})
		CIfXEnd()
	CIfEnd()
	CAdd(FP,NextDate,_ReadF(FArr(MonthData, _Sub(SCA.MonthV,1))))
	TriggerX(FP,{CV(SCA.MonthV,3,AtLeast),CD(LeafyearFlag,1)},{AddV(NextDate,1)},{preserved})
	CAdd(FP,NextDate,SCA.DayV)

	local TotalDate =CreateVar(FP)
	CSub(FP,TotalDate,NextDate,PrevDate)


	local CheckWeek = CreateVar(FP)
	CMov(FP,CheckWeek,iv.WeekCheck[i+1])

	--CheckTrig("Interface_Point_1_P"..(i+1))

CMov(FP,DayCheck[i+1],SCA.DayV)--날짜에 맞춰짐
	CMov(FP,MonthCheck[i+1],SCA.MonthV)--날짜에 맞춰짐
	CMov(FP,YearCheck[i+1],SCA.YearV)--날짜에 맞춰짐
	CMov(FP,iv.WeekCheck[i+1],SCA.WeekV)--날짜에 맞춰짐

	if Limit == 1 then
		DisplayPrint(i, {"\x13\x04TotalDate : ",TotalDate," PrevDate : ",PrevDate,"   NextDate : ",NextDate})
	end
	CIfX(FP,{CV(SCA.WeekV,4)})
	TriggerX(FP,{},{SetCp(i),DisplayText(StrDesignX("\x0649강\x04~\x0750강 \x07최초 달성 보상 \x08횟수제한\x04이 초기화 되었습니다. (오늘은 목요일입니다.)"), 4),SetV(iv.FirstRewardLim2[i+1],0)},{preserved})
	CElseIfX({CV(TotalDate,1,AtLeast)})
	
	local ThursdayJump = def_sIndex()
	NWhile(FP,{CV(TotalDate,1,AtLeast)})

	CAdd(FP,CheckWeek,1)
	CSub(FP,TotalDate,1)
	NJump(FP, ThursdayJump, {CV(CheckWeek,4)},{SetCp(i),DisplayText(StrDesignX("\x0649강\x04~\x0750강 \x07최초 달성 보상 \x08횟수제한\x04이 초기화 되었습니다.").."\n"..StrDesignX(" 오늘이 목요일은 아니지만 매주 목요일을 지날때 초기화됩니다."), 4),SetV(iv.FirstRewardLim2[i+1],0)})

	TriggerX(FP, {CV(CheckWeek,8,AtLeast)}, {SetV(CheckWeek,1)}, {preserved})


	NWhileEnd()
	NJumpEnd(FP, ThursdayJump)
	
	CIfXEnd()


	
	--CIfX(FP,{CVX(DayCheck2[i+1],27,0xFF,AtMost),CVX(SCA.GlobalVarArr[5],1,1),CD(SCA.GlobalCheck2,1)})--시즌 1호 출석이벤트
	--		DoActionsX(FP,{
	--			AddVX(DayCheck2[i+1],1,0xFF),
	--			AddV(B_PCredit[i+1],100000),
	--			AddV(B_PTicket[i+1],100),SetCp(i),DisplayText(StrDesignX("일일 출석 보상으로 \x04\x17유닛 판매권 100개, 크레딧 10만\x04을 얻었습니다."), 4)})
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
	--			SetCp(i),DisplayText(StrDesignX("누적 출석 보상으로 \x04\x17크레딧 100만, \x10강화기 백신 5개\x04를 얻었습니다."), 4)})
	--		CIfEnd()
	--		DisplayPrint(i, {"\x13\x07『 \x04현재까지 시즌 1 출석 이벤트 출석일수 : \x07",TempV3,"일 \x07』"})
	--		TriggerX(FP, {CVX(DayCheck2[i+1],28,0xFF,AtLeast)}, {SetCp(i),DisplayText(StrDesignX("모든 출석 이벤트를 완료 하셨습니다. \x1F고생하셨습니다!"), 4)})
	--CElseIfX({CD(SCA.GlobalCheck2,1),CVX(DayCheck2[i+1],28,0xFF,AtLeast)},{SetCp(i),DisplayText(StrDesignX("이미 모든 시즌 1호 출석 이벤트를 완료 하셨습니다."), 4)})
	--CIfXEnd()

	
	--1 = 월요일
	--2 = 화요일
	--3 = 수요일
	--4 = 목요일
	--5 = 금요일
	--6 = 토요일
	--7 = 일요일
	--if Limit == 0 then
	--else
	--	DoActionsX(FP,{
	--		SetCp(i),SetV(iv.FirstRewardLim[i+1],0)})
	--end
	DoActionsX(FP,{
		SetCp(i),DisplayText(StrDesignX("\x1C45강\x04~\x1B48강 \x07최초 달성 보상 \x08횟수제한\x04이 초기화 되었습니다."), 4),SetV(iv.FirstRewardLim[i+1],0)})
--	local DailyJump = def_sIndex()
	local DailyJump2 = def_sIndex()
--	NIfX(FP,{CVX(DayCheck2[i+1],27*0x100,0xFF00,AtMost),CVX(SCA.GlobalVarArr[5],2,2),CD(SCA.GlobalCheck2,1)})--시즌 2호 출석이벤트
--			NJumpEnd(FP, DailyJump)
--			DoActionsX(FP,{
--				AddVX(DayCheck2[i+1],1*0x100,0xFF00),
--				AddV(B_PCredit[i+1],500000),
--				AddV(iv.B_PFfragItem[i+1],5),
--				SetCp(i),DisplayText(StrDesignX("일일 출석 보상으로 \x04\x17크레딧 50만, \x02??? \x04를 5개 얻었습니다."), 4)})
--				local TempV = CreateVar(FP)
--				local TempV2 = CreateVar(FP)
--				local TempV3 = CreateVar(FP)
--				CMov(FP,TempV3,_Mod(_rShift(DayCheck2[i+1], 8),_Mov(0x100)),nil,nil,1)
--				CMov(FP,TempV,_Mod(TempV3,7),nil,nil,1)
--				CMov(FP,TempV2,_Div(TempV3,7),nil,nil,1)
--			CIf(FP,{CV(TempV2,1,AtLeast),CV(TempV2,4,AtMost),CV(TempV,0)})
--			DoActionsX(FP, {
--				AddV(iv.B_PFfragItem[i+1],50),
--				SetCp(i),DisplayText(StrDesignX("누적 출석 보상으로 \x02??? \x04를 50개 얻었습니다."), 4)})
--			CIfEnd()
--			CMov(FP,DV,TempV3)
--			CallTrigger(FP,Call_DailyPrint)
--			TriggerX(FP, {CVX(DayCheck2[i+1],28*0x100,0xFF00,AtLeast)}, {SetCp(i),DisplayText(StrDesignX("모든 출석 이벤트를 완료 하셨습니다. \x1F고생하셨습니다!"), 4)})
--	NElseIfX({CD(SCA.GlobalCheck2,1),CVX(DayCheck2[i+1],28*0x100,0xFF00,AtLeast)},{SetCp(i),DisplayText(StrDesignX("이미 모든 시즌 2호 출석 이벤트를 완료 하셨습니다."), 4)})
--	NIfXEnd()
	
NIfX(FP,{CVX(DayCheck2[i+1],27*0x10000,0xFF0000,AtMost),CVX(SCA.GlobalVarArr[5],4,4),CD(SCA.GlobalCheck2,1)})--시즌 3호 출석이벤트
NJumpEnd(FP, DailyJump2)
DoActionsX(FP,{
	AddV(iv.B_PFfragItem[i+1],100),
	AddVX(DayCheck2[i+1],1*0x10000,0xFF0000),
	SetCp(i),DisplayText(StrDesignX("일일 출석 보상으로 \x02무색 조각 \x04을 100개 얻었습니다."), 4)})
	local TempV = CreateVar(FP)
	local TempV2 = CreateVar(FP)
	local TempV3 = CreateVar(FP)
	CMov(FP,TempV3,_Mod(_rShift(DayCheck2[i+1], 16),_Mov(0x100)),nil,nil,1)
	CMov(FP,TempV,_Mod(TempV3,_Mov(7)),nil,nil,1)
	CMov(FP,TempV2,_Div(TempV3,_Mov(7)),nil,nil,1)
CIf(FP,{CV(TempV2,1,AtLeast),CV(TempV2,4,AtMost),CV(TempV,0)})
DoActionsX(FP, {
	AddV(iv.AwakItem[i+1],1),
	SetCp(i),DisplayText(StrDesignX("누적 출석 보상으로 \x1E각성의 보석\x04을 1개 얻었습니다."), 4)})
CIfEnd()
CMov(FP,DV2,TempV3)
CallTrigger(FP,Call_DailyPrint2)
TriggerX(FP, {CVX(DayCheck2[i+1],28*0x10000,0xFF0000,AtLeast)}, {SetCp(i),DisplayText(StrDesignX("모든 출석 이벤트를 완료 하셨습니다. \x1F고생하셨습니다!"), 4)})
NElseIfX({CD(SCA.GlobalCheck2,1),CVX(DayCheck2[i+1],28*0x10000,0xFF0000,AtLeast)},{SetCp(i),DisplayText(StrDesignX("이미 모든 시즌 3호 출석 이벤트를 완료 하셨습니다."), 4)})
NIfXEnd()
--if Limit == 0 then
--else
--	NIfX(FP,{CVX(DayCheck2[i+1],27*0x10000,0xFF0000,AtMost),CVX(SCA.GlobalVarArr[5],4,4),CD(SCA.GlobalCheck2,1)})--시즌 3호 출석이벤트
--			NJumpEnd(FP, DailyJump2)
--			DoActionsX(FP,{
--				AddV(iv.B_PFfragItem[i+1],100),
--				AddVX(DayCheck2[i+1],1*0x10000,0xFF0000),
--				SetCp(i)})
--				local TempV = CreateVar(FP)
--				local TempV2 = CreateVar(FP)
--				local TempV3 = CreateVar(FP)
--				CMov(FP,TempV3,_Mod(_rShift(DayCheck2[i+1], 16),_Mov(0x100)),nil,nil,1)
--				CMov(FP,TempV,_Mod(TempV3,_Mov(7)),nil,nil,1)
--				CMov(FP,TempV2,_Div(TempV3,_Mov(7)),nil,nil,1)
--			CIf(FP,{CV(TempV2,1,AtLeast),CV(TempV2,4,AtMost),CV(TempV,0)})
--			DoActionsX(FP, {
--				AddV(iv.AwakItem[i+1],1),
--				SetCp(i)})
--			CIfEnd()
--			CMov(FP,DV2,TempV3)
--			CallTrigger(FP,Call_DailyPrint2)
--			TriggerX(FP, {CVX(DayCheck2[i+1],28*0x10000,0xFF0000,AtLeast)}, {SetCp(i),})
--	NElseIfX({CD(SCA.GlobalCheck2,1),CVX(DayCheck2[i+1],28*0x10000,0xFF0000,AtLeast)},{SetCp(i),})
--	NIfXEnd()
--end

	SCA_DataSave(i,iv.DayCheck2[i+1],SCA.DayCheck2)
	

	NElseIfX({VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),})
		--NJump(FP, DailyJump, {CVX(DayCheck2[i+1],0*0x100,0xFF00),CVX(SCA.GlobalVarArr[5],2,2),CD(SCA.GlobalCheck2,1)}) -- 시즌2 출석 0일일 경우 강제로 출석체크시킴
		NJump(FP, DailyJump2, {CVX(DayCheck2[i+1],0*0x10000,0xFF0000),CVX(SCA.GlobalVarArr[5],2,2),CD(SCA.GlobalCheck2,1)}) -- 시즌3 출석 0일일 경우 강제로 출석체크시킴
	
	NIfXEnd()
	CIfEnd()
	
	CDoActions(FP,{
		TSetDeaths(i,SetTo,DayCheck2[i+1],48);
		TSetDeaths(i,SetTo,iv.MapMakerFlag[i+1],100);
		TSetDeaths(i,SetTo,iv.TesterFlag[i+1],101);
		--TSetDeaths(i,SetTo,iv.SettingSubtitle[i+1],102);
	})

	
	CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),CV(CurMission[i+1],#MissionDataTextArr-1,AtMost),})
			CallTriggerX(FP, Call_Print13[i+1],{CV(DPErT[i+1],0)})
		for j,k in pairs(MissionPDataArr[i+1]) do
			Trigger2X(FP, {CV(CurMission[i+1],j-1),CV(DPErT[i+1],0),LocalPlayerID(i)},  {print_utf8(12,0,MissionDataTextArr[j][1])}, {preserved})
			Trigger2X(FP, {CV(CurMission[i+1],j-1),CV(DPErT[i+1],0)},  {SetV(DPErT[i+1],15)}, {preserved})
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
							table.insert(RewardAct,AddV(B_PTicket[i+1],m))
						end
						if l == 3 then
							MText = MText.."\x10"..m.." 강화기 백신 "
							table.insert(RewardAct,AddV(iv.VaccItem[i+1],m))
						end
						if l == 4 then
							MText = MText.."\x1F"..m.." EXP "
							table.insert(RewardAct,AddV(B_PEXP[i+1],m))
						end
						if l == 5 then
							MText = MText.."\x1F"..m.." 확정 강화권 "
							table.insert(RewardAct,AddV(iv.PETicket2[i+1],m))
						end
						if l == 6 then
							MText = MText.."\x02"..m.." 무색 조각 "
							table.insert(RewardAct,AddV(iv.B_PFfragItem[i+1],m))
						end
					end
				end
				if j>=3 then
					Trigger2X(FP,{CV(CurMission[i+1],j-1),k[1]},{RewardAct,AddV(CurMission[i+1],1),SetCp(i),DisplayText(MissionDataTextArr[j][2], 4),DisplayText(StrDesignX(MText), 4),SetDeaths(i,SetTo,1,13)})
				else
					Trigger2X(FP,{CV(CurMission[i+1],j-1),k[1]},{RewardAct,AddV(CurMission[i+1],1),SetCp(i),DisplayText(MissionDataTextArr[j][2], 4),DisplayText(StrDesignX(MText), 4)})
				end
					end
	CIfEnd()

	CMov(FP,MissionV[i+1],0)



	local CTSwitch = CreateCcode()
	local CTSwitch2 = CreateCcode()
	

	if Limit == 1 then 
		CIf(FP, {CD(SCA.LoadSlot1[i+1],1,AtLeast),CD(SCA.LoadCheckArr[i+1],2)})--슬롯로드해야됨 감지. 단, 게임로드해야 쓸수있다
		
			CIf(FP,{CD(SCA.LoadSlot1[i+1],1),SCA.Available(i)},{SetCD(SCA.LoadSlot1[i+1],2),SetDeaths(i,SetTo,9,2),SCA.Reset(i),SetCp(i),DisplayText(StrDesignX("Slot Protocol Step 1"),4)})--슬롯10번 저장신호
				SCA_DataReset(i,{},{})--SCA 데이터 리셋
				CIf(FP,{LocalPlayerID(i)})
					CallTrigger(FP,Call_SaveSlot10)
				CIfEnd()
			CIfEnd()
			SCA_DataReset(i,{CD(SCA.LoadSlot1[i+1],2),SCA.NoSlotLoadAvailable(i)},{SCA.Reset(i),SetDeaths(i,SetTo,11,2),SetCp(i),DisplayText(StrDesignX("Slot Protocol Step 2"),4)})--SCA 슬롯로드 후 데이터 리셋
			LoadJumpFlag = CreateCcode()
			NIf(FP,{SCA.SlotLoadCmp(i),CD(SCA.LoadSlot1[i+1],2)},{SetCD(SCA.LoadSlot1[i+1],3),SetCD(LoadJumpFlag,0),DisplayText(StrDesignX("Slot Protocol Step 3"),4)})
				SCA_DataLoad(i, SlotPtr[i+1], SCA.PLevel)
				SCA_DataLoad(i, SubtitleFlag[i+1], SCA.PLevel2)
				DoActionsX(FP,{SetVX(SlotPtr[i+1],32,32)},1) -- 칭호와 밴플래그 데이터는 무조건 1회 불러옴
				CTrigger(FP, {TTNVar(SubtitleFlag[i+1],NotSame,SubtitleFlag2[i+1])}, {SetV(SubtitleFlag2[i+1],SubtitleFlag[i+1]),SetCD(SubtitleLoad[i+1],1)},{preserved}) -- 서브타이틀 플래그 상태여부
				DisplayPrint(i, {"\x13\x04SlotPtr : ",SlotPtr[i+1],"   SubtitleFlag : ",SubtitleFlag[i+1]})
				local SlotJump = def_sIndex()
				NJump(FP,SlotJump,{CV(SlotPtr[i+1],0),CD(SubtitleLoad[i+1],0)},{SetCD(SCA.LoadSlot1[i+1],4),SetCD(LoadJumpFlag,1)})
			NIfEnd()
			CIf(FP,{CD(SCA.LoadSlot1[i+1],3)})
				for j = 2, 9 do 
					local cond = CVX(SlotPtr[i+1],2^j,2^j)
					local act
					if j == 4 then cond =CD(SubtitleLoad[i+1],1) end -- 4번 조건은 예외
					if j == 4 then act = SetCD(SubtitleLoad[i+1],0) end
					TriggerX(FP, {CD(CurLoadSlot[i+1],j),SCA.SlotLoadCmp(i)}, {SetVX(SlotPtr[i+1],0,2^j),act,SetCD(CurLoadCmpSlot[i+1],j),SetCD(CurLoadSlot[i+1],0),}, {preserved})
					TriggerX(FP, {cond,SCA.Available(i)}, {SetVX(SlotPtr[i+1],0,2^j),SetDeaths(i,SetTo,10+j,2),SetCD(CurLoadSlot[i+1],j),SCA.Reset(i)}, {preserved})
				end
				CallTriggerX(FP,Call_SCA_DataLoadSetTo,{CD(CurLoadCmpSlot[i+1],2)},{SetCD(CurLoadCmpSlot[i+1],0),SetCp(i),DisplayText(StrDesignX("일부 데이터가 실시간 SetTo 실행되었습니다."),4)})
				CallTriggerX(FP,Call_SCA_DataLoadAdd,{CD(CurLoadCmpSlot[i+1],3)},{SetCD(CurLoadCmpSlot[i+1],0),SetCp(i),DisplayText(StrDesignX("일부 데이터가 실시간 Add/Sub 실행되었습니다."),4)})
				CIf(FP,{CD(CurLoadCmpSlot[i+1],5)},{SetCD(CurLoadCmpSlot[i+1],0),SetCD(CTSwitch2,0)})
				SCA_DataLoad(i, BPTest[1], SCA.BanFlag)
				SCA_DataLoad(i, iv.RankTitle[i+1], SCA.RankTitle)
				SCA_DataLoad(i, iv.RankTitle2[i+1], SCA.RankTitle2)
				SCA_DataLoad(i, iv.RankTitle3[i+1], SCA.RankTitle3)
				TriggerX(FP, {CV(BPTest[1],1,AtLeast)},{SetCD(CTSwitch2,1)})
				TriggerX(FP, {CD(CTSwitch2,1),LocalPlayerID(i)},{
					SetCp(i),
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					DisplayText("S\x13\x07『 \x04당신은 SCA 시스템에서 이미 닉네임을 변경한 유저로 감지되어 강퇴당했습니다. (데이터는 정상저장 후 보존되어 있음.)\x07 』",4);
					DisplayText("\x13\x07『 \x04만약 닉네임을 변경하지 않은유저일 경우 제작자에게 문의해주시기 바랍니다.\x07 』",4);
					SetMemory(0xCDDDCDDC,SetTo,1);})
				CIfEnd()
				--Call_SCA_DataLoadSetTo
				--Call_SCA_DataLoadAdd
			CIfEnd()
			CIf(FP,{CD(SCA.LoadSlot1[i+1],3),CV(SlotPtr[i+1],0),CD(SubtitleLoad[i+1],0),SCA.Available(i)},{SetCD(SCA.LoadSlot1[i+1],4),SetDeaths(i,SetTo,10,2),SCA.Reset(i),SetCp(i),DisplayText(StrDesignX("Slot Protocol Step 4"),4)})--슬롯1번 저장신호
				SCA_DataReset(i,{},{})--SCA 데이터 리셋
				SCA_DataSave(i, SlotPtr[i+1], SCA.PLevel)
				SCA_DataSave(i, SubtitleFlag[i+1], SCA.PLevel2)
			CIfEnd()
			
			NJumpEnd(FP, SlotJump)
			TriggerX(FP, {CD(SCA.LoadSlot1[i+1],4),SCA.LoadCmp(i),CD(LoadJumpFlag,1)},{SetCD(SCA.LoadSlot1[i+1],0),SetCD(CurLoadSlot[i+1],0),SetCD(CurLoadCmpSlot[i+1],0),SetCp(i),DisplayText(StrDesignX("Slot Protocol Completed"),4),SetCD(LoadJumpFlag,0)},{preserved})
			TriggerX(FP, {CD(SCA.LoadSlot1[i+1],4),SCA.SaveCmp(i),CD(LoadJumpFlag,0)},{SetCD(SCA.LoadSlot1[i+1],0),SetCD(CurLoadSlot[i+1],0),SetCD(CurLoadCmpSlot[i+1],0),SetCp(i),DisplayText(StrDesignX("Slot Protocol Completed"),4),},{preserved})

				
		CIfEnd()
	else
		

		CIf(FP, {CD(SCA.LoadSlot1[i+1],1,AtLeast),CD(SCA.LoadCheckArr[i+1],2)})--슬롯로드해야됨 감지. 단, 게임로드해야 쓸수있다
		
			CIf(FP,{CD(SCA.LoadSlot1[i+1],1),SCA.Available(i)},{SetCD(SCA.LoadSlot1[i+1],2),SetDeaths(i,SetTo,9,2),SCA.Reset(i)})--슬롯10번 저장신호
				SCA_DataReset(i,{},{})--SCA 데이터 리셋
				CIf(FP,{LocalPlayerID(i)})
					CallTrigger(FP,Call_SaveSlot10)
				CIfEnd()
			CIfEnd()
			SCA_DataReset(i,{CD(SCA.LoadSlot1[i+1],2),SCA.NoSlotLoadAvailable(i)},{SCA.Reset(i),SetDeaths(i,SetTo,11,2)})--SCA 슬롯로드 후 데이터 리셋
			LoadJumpFlag = CreateCcode()
			NIf(FP,{SCA.SlotLoadCmp(i),CD(SCA.LoadSlot1[i+1],2)},{SetCD(SCA.LoadSlot1[i+1],3),SetCD(LoadJumpFlag,0)})
				SCA_DataLoad(i, SlotPtr[i+1], SCA.PLevel)
				SCA_DataLoad(i, SubtitleFlag[i+1], SCA.PLevel2)
				DoActionsX(FP,{SetVX(SlotPtr[i+1],32,32)},1) -- 칭호와 밴플래그 데이터는 무조건 1회 불러옴
				CTrigger(FP, {TTNVar(SubtitleFlag[i+1],NotSame,SubtitleFlag2[i+1])}, {SetV(SubtitleFlag2[i+1],SubtitleFlag[i+1]),SetCD(SubtitleLoad[i+1],1)},{preserved}) -- 서브타이틀 플래그 상태여부
				local SlotJump = def_sIndex()
				NJump(FP,SlotJump,{CV(SlotPtr[i+1],0),CD(SubtitleLoad[i+1],0)},{SetCD(SCA.LoadSlot1[i+1],4),SetCD(LoadJumpFlag,1)})
			NIfEnd()
			NIf(FP,{CD(SCA.LoadSlot1[i+1],3)})
				for j = 2, 9 do 
					local cond = CVX(SlotPtr[i+1],2^j,2^j)
					local act
					if j == 4 then cond =CD(SubtitleLoad[i+1],1) end -- 4번 조건은 예외
					if j == 4 then act = SetCD(SubtitleLoad[i+1],0) end
					TriggerX(FP, {CD(CurLoadSlot[i+1],j),SCA.SlotLoadCmp(i)}, {SetVX(SlotPtr[i+1],0,2^j),act,SetCD(CurLoadCmpSlot[i+1],j),SetCD(CurLoadSlot[i+1],0),}, {preserved})
					TriggerX(FP, {cond,SCA.Available(i)}, {SetVX(SlotPtr[i+1],0,2^j),SetDeaths(i,SetTo,10+j,2),SetCD(CurLoadSlot[i+1],j),SCA.Reset(i)}, {preserved})
				end
				--for j = 6, 9 do
				--	TriggerX(FP,{},{SetVX(SlotPtr[i+1],0,2^j)},{preserved})
				--end
				CallTriggerX(FP,Call_SCA_DataLoadSetTo,{CD(CurLoadCmpSlot[i+1],2)},{SetCD(CurLoadCmpSlot[i+1],0),SetCp(i),DisplayText(StrDesignX("일부 데이터가 실시간 SetTo 실행되었습니다."),4)})
				CallTriggerX(FP,Call_SCA_DataLoadAdd,{CD(CurLoadCmpSlot[i+1],3)},{SetCD(CurLoadCmpSlot[i+1],0),SetCp(i),DisplayText(StrDesignX("일부 데이터가 실시간 Add/Sub 실행되었습니다."),4)})

				CIf(FP,{CD(CurLoadCmpSlot[i+1],5)},{SetCD(CurLoadCmpSlot[i+1],0),SetCD(CTSwitch2,0)})
				SCA_DataLoad(i, BPTest[i+1], SCA.BanFlag)
				SCA_DataLoad(i, iv.RankTitle[i+1], SCA.RankTitle)
				SCA_DataLoad(i, iv.RankTitle2[i+1], SCA.RankTitle2)
				SCA_DataLoad(i, iv.RankTitle3[i+1], SCA.RankTitle3)
				
				
				
				TriggerX(FP, {CV(BPTest[i+1],1,AtLeast)},{SetCD(CTSwitch2,1)})
				TriggerX(FP, {CD(CTSwitch2,1),LocalPlayerID(i)},{
					SetCp(i),
					PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
					DisplayText("S\x13\x07『 \x04당신은 SCA 시스템에서 이미 닉네임을 변경한 유저로 감지되어 강퇴당했습니다. (데이터는 정상저장 후 보존되어 있음.)\x07 』",4);
					DisplayText("\x13\x07『 \x04만약 닉네임을 변경하지 않은유저일 경우 제작자에게 문의해주시기 바랍니다.\x07 』",4);
					SetMemory(0xCDDDCDDC,SetTo,1);})
				CIfEnd()
				--Call_SCA_DataLoadSetTo
				--Call_SCA_DataLoadAdd
			NIfEnd()
			CIf(FP,{CD(SCA.LoadSlot1[i+1],3),CV(SlotPtr[i+1],0),CD(SubtitleLoad[i+1],0),SCA.Available(i)},{SetCD(SCA.LoadSlot1[i+1],4),SetDeaths(i,SetTo,10,2),SCA.Reset(i)})--슬롯1번 저장신호
				SCA_DataReset(i,{},{})--SCA 데이터 리셋
				SCA_DataSave(i, SlotPtr[i+1], SCA.PLevel)
				SCA_DataSave(i, SubtitleFlag[i+1], SCA.PLevel2)
			CIfEnd()
			NJumpEnd(FP, SlotJump)
			TriggerX(FP, {CD(SCA.LoadSlot1[i+1],4),SCA.LoadCmp(i),CD(LoadJumpFlag,1)},{SetCD(SCA.LoadSlot1[i+1],0),SetCD(CurLoadSlot[i+1],0),SetCD(CurLoadCmpSlot[i+1],0),SetCD(LoadJumpFlag,0)},{preserved})
			TriggerX(FP, {CD(SCA.LoadSlot1[i+1],4),SCA.SaveCmp(i),CD(LoadJumpFlag,0)},{SetCD(SCA.LoadSlot1[i+1],0),SetCD(CurLoadSlot[i+1],0),SetCD(CurLoadCmpSlot[i+1],0)},{preserved})
				
		CIfEnd()
	end

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

	--CAdd(FP,CTStatP2,_Mul(Stat_BossSTic[i+1],_Mov(Cost_Stat_BossSTic)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer4[i+1],_Mov(100)),_Mov(Cost_Stat_TotalEPer4)))
	--CAdd(FP,CTStatP2,_Mul(_Div(Stat_BreakShield[i+1],_Mov(1000)),_Mov(Cost_Stat_BreakShield)))
	--CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(Cost_Stat_Upgrade)))
	--CAdd(FP,CTStatP2,_Mul(Stat_BossLVUP[i+1],_Mov(Cost_Stat_BossLVUP)))
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
	CTrigger(FP, {CV(BanFlag8[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag7[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag6[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {CV(BanFlag5[i+1],1,AtLeast)}, {SetCD(CheatDetect,1)})
	TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("S\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 정상저장 후 보존되어 있음.)\x07 』",4);
		DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디, 현재 미네랄, 가스 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})

	
	CIfEnd()


	
	if Limit == 1 then 
		CIf(FP,{CV(iv.MapMakerFlag[i+1]),Deaths(i,AtLeast,1,553)})
		--CreateUnitStacked({}, 12, LevelUnitArr[50][2], 36+i, nil, i)
		--f_LAdd(FP,PEXP[i+1],PEXP[i+1],"500000000")
		CIfEnd()
	end

	

	
	TriggerX(FP, {MSQC_KeyInput(i, "F12"),CVX(iv.SettingEffSound[i+1],0,1)}, {SetDeaths(i,SetTo,0,553),SetDeathsX(i,SetTo,1,3,1),SetVX(iv.SettingEffSound[i+1],1,1),SetCp(i),DisplayText(StrDesign("\x04뽑기 알림 사운드를 \x07ON\x04 으로 변경하였습니다."),4),PlayWAV("staredit\\wav\\conn.ogg"),PlayWAV("staredit\\wav\\conn.ogg")},{preserved})
	TriggerX(FP, {MSQC_KeyInput(i, "F12"),CVX(iv.SettingEffSound[i+1],1,1)}, {SetDeaths(i,SetTo,0,553),SetDeathsX(i,SetTo,0,3,1),SetVX(iv.SettingEffSound[i+1],0,1),SetCp(i),DisplayText(StrDesign("\x04뽑기 알림 사운드를 \x08OFF\x04 으로 변경하였습니다."),4),PlayWAV("sound\\Misc\\TRescue.wav"),PlayWAV("sound\\Misc\\TRescue.wav")},{preserved})
	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--기본유닛지급
	
	
	TriggerX(FP, {Command(i,AtLeast,1,88),CV(ScTimer[i+1],4320)}, {RemoveUnit(88,i)},{preserved}) -- 3분뒤 사라지는 기본유닛
	--if Limit == 1 then
	--	TriggerX(FP, {}, {SetV(ResetStat[i+1],0)},{preserved}) -- 테스트모드 스탯초기화 무한
	--	TriggerX(FP, {}, {SetV(ResetStat2[i+1],0)},{preserved}) -- 테스트모드 스탯초기화 무한
	--else
	--end
	TriggerX(FP, {CV(ScTimer[i+1],86400),CV(ResetStat[i+1],0)}, {AddV(ResetStat[i+1],1)}) -- 1시간뒤 스탯초기화 비활성화
	TriggerX(FP, {CV(ScTimer[i+1],86400),CV(ResetStat2[i+1],0)}, {AddV(ResetStat2[i+1],1)}) -- 1시간뒤 스탯초기화 비활성화
	TriggerX(FP, {Command(i,AtLeast,1,LevelUnitArr[41][2]),CV(ResetStat[i+1],0)}, {AddV(ResetStat[i+1],1)}) -- 41강보유시 스탯초기화 비활성화
	TriggerX(FP, {Command(i,AtLeast,1,LevelUnitArr[41][2]),CV(ResetStat2[i+1],0)}, {AddV(ResetStat2[i+1],1)}) -- 41강보유시 스탯초기화 비활성화

	TriggerX(FP, {CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men"),}, {SetMemX(Arr(AutoEnchArr,((2-1)*7)+i), SetTo, 0),SetCp(i),DisplayText(StrDesignX("\x04모두 \x08강화에 실패\x04하신 모양이네요... \x0F2강 유닛 1기\x04를 위로 보상으로 지급합니다."), 4),SetCp(FP)}) -- 기본유닛 사라지고 전멸할경우 기회줌
	CreateUnitStacked({CV(ScTimer[i+1],4320,AtLeast),CV(ScTimer[i+1],4320*2,AtMost),NWar(Money[i+1], AtMost, "1499"),Command(i,AtMost,0,"Men")}, 1, LevelUnitArr[2][2], 50+i,36+i, i, nil,1)

	--iv.PUnitLevel


	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[15][2])},{SetCp(i),DisplayText(StrDesignX("\x0815강 \x04유닛을 획득하였습니다. \x0815강 \x04유닛부터는 \x17판매\x04를 통해 \x1B경험치\x04를 획득할 수 있습니다.")),SetCp(FP)})
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[26][2])},{SetCp(i),DisplayText(StrDesignX("\x0F26강 \x04유닛을 획득하였습니다. \x0F26강 \x04유닛부터는 \x08보스\x04에 도전할 수 있습니다.")),DisplayText(StrDesignX("\x08보스 \x1C도전 \x07제한시간\x04은 없으며, \x08최대 4기 \x04입장 가능합니다.")),DisplayText(StrDesignX("\x0F26강 \x04유닛부터는 \x19유닛 판매권\x04이 있어야 판매가 가능합니다.")),SetCp(FP)})

	
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
	CIfChkVar(iv.FXPer48[i+1])
	CMov(FP,iv.CXPer48[i+1],_Mul(iv.FXPer48[i+1],_Mov(5)))
	CIfEnd()
	CIfChkVar(iv.FMEPer[i+1])
	CMov(FP,iv.CMEPer[i+1],_Mul(iv.FMEPer[i+1],_Mov(10)))
	CIfEnd()
	CIfChkVar(iv.FBrSh[i+1])
	CMov(FP,iv.CBrSh[i+1],_Mul(iv.FBrSh[i+1],_Mov(100)))
	CIfEnd()
	CIfChkVar(iv.FMEPer2[i+1])
	CMov(FP,iv.CMEPer2[i+1],_Mul(iv.FMEPer2[i+1],_Mov(10)))
	CIfEnd()
	CIfChkVar(iv.FBrSh2[i+1])
	CMov(FP,iv.CBrSh2[i+1],_Mul(iv.FBrSh2[i+1],_Mov(10)))
	CIfEnd()
	
	local CCVar = CreateVar2(FP,nil,nil,0xFFFFFFFF)
	local CCVar2 = CreateVar2(FP,nil,nil,0xFFFFFFFF)
	local CCVar3 = CreateVar2(FP,nil,nil,0xFFFFFFFF)

	
	CIf(FP,{TTOR({TTNVar(iv.FIncm[i+1],NotSame,CCVar),TTNVar(Stat_LV3Incm[i+1],NotSame,CCVar2),TTNVar(iv.CSX_LV3IncmData[i+1],NotSame,CCVar3)})})
	CMov(FP,CCVar,iv.FIncm[i+1])
	CMov(FP,CCVar2,Stat_LV3Incm[i+1])
	CMov(FP,CCVar3,iv.CSX_LV3IncmData[i+1])
	f_LMov(FP,iv.TempIncm[i+1],_LDiv(_LMul({_Mul(_Add(Stat_LV3Incm[i+1],100),_Add(_Mul(iv.FIncm[i+1],_Mov(10)),100)),0}, {iv.CSX_LV3IncmData[i+1],0}),"10000"))
	CIfEnd()
	--CheckTrig("Interface_Point_2.0_P"..(i+1))
	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{TempO[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas,TempG[i+1]},Money[i+1])
	DPSBuilding(i,DpsLV3[i+1],"100000000",iv.TempIncm[i+1],{TempX[i+1]},Money[i+1])
--	CIf(FP,{TTNWar(Money[i+1], AtLeast, "15000000000000000000")})--1500경이상일경우
--	f_LSub(FP, Money[i+1], Money[i+1], "10000000000000000000")
--	CAdd(FP,Money2[i+1],1)
--	CIfEnd()



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

TriggerX(FP, {CV(TempX[i+1],200000000,AtLeast),LocalPlayerID(i)}, {
	SetCp(i),
	PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
	DisplayText("X\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다. (데이터는 보존되어 있음.)\x07 』",4);
	DisplayText("\x13\x07『 \x04SCA 아이디, 스타 아이디 정보와 함께 제작자에게 문의해주시기 바랍니다.\x07 』",4);
	SetMemory(0xCDDDCDDC,SetTo,1);})

	--CheckTrig("Interface_Point_2.1_P"..(i+1))

	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)
	Debug_DPSBuilding(DpsLV3[i+1],173,137+i)
	PBossResetArr = DPSBuilding(i,PBossPtr[i+1],"X",nil,{PBossDPS[i+1]},nil,1)--

	--CheckTrig("Interface_Point_2.2_P"..(i+1))
	local DoReset = CreateCcode()

	for j,k in pairs(PBossArr) do
		local LocID = 129+i
		local PBossID = k[1]
		local PBossSetDPS = k[2]
		local AddCond = nil
		local AddCond2 = nil
		if j >=6 then LocID = 153+i AddCond = {CV(BossLV,5,AtLeast)} end--CV(LV5Cool[i+1],60*60,AtMost)CD(SCA.LoadCheckArr[i+1],2),CD(BossLV6Private[i+1],0),
		if j== 11 then AddCond2 = {CV(BossLV,7,AtLeast)} end
		TriggerX(FP,{Memory(0x628438,AtLeast,1),CV(PBossPtr[i+1],0),CV(PBossLV[i+1],j-1),AddCond,AddCond2},{SetCD(DoReset,1),SetV(LocIDB,LocID),SetV(PBossIDB,PBossID),SetNWar(PBossSetDPSB,SetTo,PBossSetDPS)})--보스방 건물 세팅

	end
		CIf(FP,{CD(DoReset,1)},{SetCD(DoReset,0)})
		DoActions2X(FP, PBossResetArr)
		CallTrigger(FP, Call_SetBoss)
		CIfEnd()
	for j,k in pairs(PBossArr) do
		local LocID = 129+i
		local PBossID = k[1]
		if j >=6 then LocID = 153+i end--CV(LV5Cool[i+1],60*60,AtMost)CD(SCA.LoadCheckArr[i+1],2),CD(BossLV6Private[i+1],0),
		local ClearJump = def_sIndex()
		NJump(FP,ClearJump,{CV(PBossLV[i+1],j,AtLeast)})
		CIf(FP,{CV(PBossLV[i+1],j-1),TTNWar(PBossDPS[i+1], AtLeast, TotalPBossDPS[i+1])})
		DoActionsX(FP,{KillUnitAt(All,PBossID,LocID,FP),AddV(PBossLV[i+1],1),SetV(PBossPtr[i+1],0),SetNWar(PBossDPS[i+1],SetTo,"0")})
		CIfEnd()
		NJumpEnd(FP,ClearJump)
	end

	

	
	UnitReadX(FP, i, "Men", 65+i, Income[i+1])
	local TempICM = CreateVar(FP)
	CSub(FP,TempICM,IncomeMax[i+1],1)
	TriggerX(FP, {Bring(i, Exactly, 1, PersonalUIDArr[i+1], 65+i)}, {SubV(Income[i+1], 1),AddV(TempICM,1)}, {preserved})
	
	CIfX(FP,{TBring(i, AtMost, TempICM, "Men", 65+i),Bring(i,AtLeast,1,"Men",15+i)})
	CTrigger(FP,{},{MoveUnit(1, "Men", i, 15+i, 22+i),MoveUnit(1, "Factories", i, 22+i, 57+i),
	MoveUnit(1, LevelUnitArr[41][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[42][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[43][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[44][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[45][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[46][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[47][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[48][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[49][2], i, 57+i, 144+i),
	MoveUnit(1, LevelUnitArr[50][2], i, 57+i, 144+i),
},1)--사냥터 입장
	TriggerX(FP,{CV(CS_DPSLV[i+1],1,AtLeast)},{MoveUnit(1,PersonalUIDArr[i+1],i,22+i,57+i)},{preserved})
	CElseX({MoveUnit(1,PersonalUIDArr[i+1],i,15+i,22+i)})
	TriggerX(FP,{CV(CS_DPSLV[i+1],1,AtLeast)},{MoveUnit(1,PersonalUIDArr[i+1],i,22+i,57+i)},{preserved})
	CIfXEnd()


	TriggerX(FP,{CV(ScTimer[i+1],4320,AtMost)},{MoveUnit(1, 88, i, 15+i, 22+i)},{preserved})

	

	TriggerX(FP, {Bring(i,AtLeast,1,"Men",29+i)}, {MoveUnit(1, "Men", i, 29+i, 80+i)}, {preserved})--사냥터 퇴장

	--TriggerX(FP, {Bring(i, AtMost, 3, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--보스방 입장


	--TriggerX(FP, {}, {MoveUnit(1, "Factories", i, 111, 80+i)}, {preserved})--보스방 퇴장

	
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 5, "Men", 119+i)}, {MoveUnit(1, "Men", i, 119+i, 22+i)}, {preserved})--개인보스방 입장제한
	TriggerX(FP, {CV(PBossLV[i+1],4,AtMost),Bring(i, AtLeast, 1, 88, 119+i)}, {MoveUnit(1, 88, i, 119+i, 22+i)}, {preserved})--개인보스방 입장제한
	TriggerX(FP, {CV(PBossLV[i+1],5,AtLeast),CV(CS_DPSLV[i+1],1,AtLeast)}, {MoveUnit(1,PersonalUIDArr[i+1],i,119+i,57+i)}, {preserved})--고유유닛 개인보스에서 사냥터로 이동




	

	if Limit == 1 then
		CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),TTNVar(PUnitCurLevel[i+1],NotSame,PUnitClass[i+1])},{SetCp(i),DisplayText(StrDesignX("\x03SYSTEM \x04: 고유유닛스텟바뀜인식."), 4)})
	else
		CIf(FP,{CD(SCA.LoadCheckArr[i+1],2),TTNVar(PUnitCurLevel[i+1],NotSame,PUnitClass[i+1])})
	end
	CMov(FP,PUnitClass[i+1],0)


	TriggerX(FP,{CV(CS_Cooldown[i+1],CS_CooldownLimit,AtLeast)},{SetV(CS_Cooldown[i+1],CS_CooldownLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_Atk[i+1],CS_AtkLimit,AtLeast)},{SetV(CS_Atk[i+1],CS_AtkLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_EXP[i+1],CS_EXPLimit,AtLeast)},{SetV(CS_EXP[i+1],CS_EXPLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_TotalEPer[i+1],CS_TotalEPerLimit,AtLeast)},{SetV(CS_TotalEPer[i+1],CS_TotalEPerLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_TotalEper4[i+1],CS_TotalEper4Limit,AtLeast)},{SetV(CS_TotalEper4[i+1],CS_TotalEper4Limit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_DPSLV[i+1],CS_DPSLVLimit,AtLeast)},{SetV(CS_DPSLV[i+1],CS_DPSLVLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(CS_BreakShield[i+1],CS_BreakShieldLimit,AtLeast)},{SetV(CS_BreakShield[i+1],CS_BreakShieldLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정
	TriggerX(FP,{CV(iv.CSX_LV3Incm[i+1],CSX_LV3IncmLimit,AtLeast)},{SetV(iv.CSX_LV3Incm[i+1],CSX_LV3IncmLimit)},{preserved})--모든 데이터를 리미트수치만큼으로 고정

	CAdd(FP,PUnitClass[i+1],CS_Cooldown[i+1])
	CAdd(FP,PUnitClass[i+1],CS_Atk[i+1])
	CAdd(FP,PUnitClass[i+1],iv.CSX_LV3Incm[i+1])
	CAdd(FP,PUnitClass[i+1],CS_EXP[i+1])
	CAdd(FP,PUnitClass[i+1],CS_TotalEPer[i+1])
	CAdd(FP,PUnitClass[i+1],CS_TotalEper4[i+1])
	CAdd(FP,PUnitClass[i+1],CS_DPSLV[i+1])
	CAdd(FP,PUnitClass[i+1],CS_BreakShield[i+1])
	TriggerX(FP,{CV(PUnitClass[i+1],CS_CooldownLimit+CS_AtkLimit+CS_EXPLimit+CS_TotalEPerLimit+CS_TotalEper4Limit+CS_DPSLVLimit+CS_BreakShieldLimit+CSX_LV3IncmLimit,AtLeast)},{SetV(PUnitClass[i+1],CS_CooldownLimit+CS_AtkLimit+CS_EXPLimit+CS_TotalEPerLimit+CS_TotalEper4Limit+CS_DPSLVLimit+CS_BreakShieldLimit+CSX_LV3IncmLimit)},{preserved})



	--CheckTrig("Interface_Point_3_P"..(i+1))
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
	CMov(FP, iv.CSX_LV3IncmData[i+1], _Mul(iv.CSX_LV3Incm[i+1],_Mov(10)), 100)
	CMov(FP,PUnitCurLevel[i+1],PUnitClass[i+1])
	if Limit == 1 then
		DisplayPrint(i, {"PUnitClass : ",PUnitClass[i+1],"    PUnitCurLevel : ",PUnitCurLevel[i+1]})
	end
	--
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],100)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,2)},1)
	--CTrigger(FP,{CV(PUnitCurLevel[i+1],99,AtMost)},{SetMemoryB(0x6564E0+PersonalWIDArr[i+1],SetTo,1)},1)
	CIfEnd()

	--TriggerX(FP,{CV(iv.PSaveChk[i+1],1),SCA.SaveCmp(i),CV(EnchCool[i+1],0)},{SetV(iv.PSaveChk[i+1],0),SetCp(i),DisplayText(StrDesignX("\x03SYSTEM \x04: 이제 다시 강화를 진행할 수 있습니다."), 4)},{preserved})
	CallTrigger(FP,Call_BtnInit,{})

	


	local KeyTog = CreateCcode()
	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1]),SetCD(KeyTog,0)})--키인식부 시작
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"O"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"U"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],256)},{preserved})
	CIf(FP,{CV(InterfaceNum[i+1],256,AtLeast),CV(InterfaceNum[i+1],512,AtMost)},{SetCD(failCcode,0),
	SetCD(CntCArr[1],0),
	SetCD(CntCArr[2],0),
	SetCD(CntCArr[3],0),
	SetCD(CntCArr[4],0),
	SetCD(CntCArr[5],0),
	SetCD(CntCArr[6],0),
	SetCD(CntCArr[7],0),
	SetCD(CntCArr[8],0),
	SetCD(CntCArr[9],0),
	SetCD(CntCArr[10],0),})
	for j = 7, 8 do
		TriggerX(FP, {Deaths(i,Exactly,0x10000+j,20)}, {SetCD(ClickCD, 0),SetDeaths(i,SetTo,1,495+j)}, {preserved})
	end
	for j = 1, 5 do
		TriggerX(FP, {Deaths(i,Exactly,0x30000+j,20)}, {SetCD(CntCArr[j],1)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30010+j,20)}, {SetCD(CntCArr[j],10)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30020+j,20)}, {SetCD(CntCArr[j],100)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30100+j,20)}, {SetCD(CntCArr[j+5],1)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30110+j,20)}, {SetCD(CntCArr[j+5],10)}, {preserved})
		TriggerX(FP, {Deaths(i,Exactly,0x30120+j,20)}, {SetCD(CntCArr[j+5],100)}, {preserved})
	end
	CallTrigger(FP, Call_FfragShop)
	if Limit == 1 then
		CallTriggerX(FP,Call_Print13[i+1],{MSQC_KeyInput(i, "F12")},nil,1)
		TriggerX(FP,{CD(SCA.LoadCheckArr[i+1],2),MSQC_KeyInput(i, "F12")},{SetV(DPErT[i+1],24*10),AddV(iv.B_PFfragItem[i+1],100000),print_utf8(12,0,StrDesign("\x03TESTMODE OP \x04: \x02무색 조각 \x0410만개 지급 완료.\x08(저장X)"))})
	end



	CIf(FP,CD(failCcode,1,AtLeast),{SetV(DPErT[i+1],24*10)})
		CallTrigger(FP,Call_Print13[i+1])
		TriggerX(FP, {LocalPlayerID(i),CD(failCcode,1)},{print_utf8(12,0,StrDesign("\x08ERROR \x04: \x1E무색 조각\x04이 부족합니다.")),SetCD(failCcode,0)} ,{preserved})
		TriggerX(FP, {LocalPlayerID(i),CD(failCcode,2)},{print_utf8(12,0,StrDesign("\x08ERROR \x04: \x04더이상 강화할 수 없습니다.")),SetCD(failCcode,0)} ,{preserved})
	CIfEnd()

	CIf(FP, Deaths(i, Exactly, 1, 507),{SetV(DPErT[i+1],24*10)})
		CIfX(FP,{CV(ResetStat2[i+1],1,AtLeast)})
		CallTrigger(FP,Call_Print13[i+1])
		TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x19보석 초기화\x04를 사용할 수 없습니다.")) ,{preserved})
		CElseIfX({TTNWar(Credit[i+1], AtLeast, "100000"),TTNWar(Credit[i+1], AtMost, "0x7FFFFFFFFFFFFFFF")})
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
				SetV(iv.FXPer48[i+1],0),
				SetV(iv.FMin[i+1],0),
				SetV(iv.FAcc[i+1],0),
				SetV(iv.FAcc2[i+1],0),
				SetV(iv.FBrSh2[i+1],0),
				SetV(iv.FMEPer2[i+1],0),
				SetV(iv.FMinMax[i+1],0),
				SetNWar(iv.FfragItemUsed[i+1],SetTo,"0"),
				SetV(ResetStat2[i+1],1),
			})
			TriggerX(FP, {LocalPlayerID(i)}, {SetV(Time,(300000)-5000),SetCD(SaveRemind,1)}, {preserved})
			CallTrigger(FP,Call_Print13[i+1])
			TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x19보석 초기화\x04 완료. \x07잠시 후 자동저장됩니다. \x17U 키\x04를 눌러 \x19보석\x04을 재설정해주세요.")) ,{preserved})

		CElseX()
			CallTrigger(FP,Call_Print13[i+1])
			TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다.")) ,{preserved})
		CIfXEnd()
	CIfEnd()
	TriggerX(FP, {CV(InterfaceNum[i+1],256),MSQC_KeyInput(i, "P")},{AddV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],257),MSQC_KeyInput(i, "I")},{SubV(InterfaceNum[i+1],1)},{preserved})


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
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x1F스탯 초기화\x04를 사용할 수 없습니다.")) ,{preserved})

			--CElseIfX({TTNWar(Credit[i+1], AtLeast, _LMov({_ReadF(ArrX(SRTable, ResetStat[i+1])),0}))})
				--f_LSub(FP, Credit[i+1], Credit[i+1], _LMov({_ReadF(ArrX(SRTable, ResetStat[i+1])),0}))
			CElseIfX({TTNWar(Credit[i+1], AtLeast, "5000"),TTNWar(Credit[i+1], AtMost, "0x7FFFFFFFFFFFFFFF")})
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
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x1F스탯 초기화\x04 완료. \x07잠시 후 자동저장됩니다. \x17O 키\x04를 눌러 \x07능력치\x04를 설정해주세요.")) ,{preserved})

			CElseX()
				CallTrigger(FP,Call_Print13[i+1])
				TriggerX(FP, {LocalPlayerID(i)},print_utf8(12,0,StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다.")) ,{preserved})
			CIfXEnd()
		CIfEnd()
		local ClickCDWhile = def_sIndex()
		NJumpEnd(FP, ClickCDWhile)
		CIf(FP,{VRange(InterfaceNum[i+1],1,255)},{SetV(DPErT[i+1],24)})
			CallTrigger(FP,Call_StatShop)
		CIfEnd()
	

	NJump(FP, ClickCDWhile, {CD(ClickCD,1,AtLeast),CD(ClickCD2,1,AtLeast)},{SubCD(ClickCD2, 1)})
	

	TriggerX(FP, {CV(InterfaceNum[i+1],2),MSQC_KeyInput(i, "I")},{SubV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],3),MSQC_KeyInput(i, "I")},{SubV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],2),MSQC_KeyInput(i, "P")},{AddV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1),MSQC_KeyInput(i, "P")},{AddV(InterfaceNum[i+1],1)},{preserved})

	CIfEnd()
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),Deaths(i,Exactly,0x10000,20)}, {SetDeaths(i,SetTo,1,495),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)}, {preserved})--ESC
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),Deaths(i,Exactly,0x40000,20)}, {SetDeaths(i,SetTo,1,494)}, {preserved})--O
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),Deaths(i,Exactly,0x30000,20)}, {SetDeaths(i,SetTo,1,506)}, {preserved})--U
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),CV(InterfaceNum[i+1],255,AtMost),MSQC_KeyInput(i,"O"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})
	TriggerX(FP, {VRange(InterfaceNum[i+1],256,511),MSQC_KeyInput(i,"U"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),CV(InterfaceNum[i+1],255,AtMost),MSQC_KeyInput(i,"U"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],256)},{preserved})
	TriggerX(FP, {VRange(InterfaceNum[i+1],256,511),MSQC_KeyInput(i,"O"),CD(KeyTog,0)}, {SetCD(KeyTog,1),SetV(InterfaceNum[i+1],1)},{preserved})
	TriggerX(FP, {CV(InterfaceNum[i+1],1,AtLeast),MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4)},{preserved})

	DoActions(FP, SetCp(FP))--키인식부 종료
	TriggerX(FP,{CV(InterfaceNum[i+1],0),CV(BrightLoc,30,AtMost),LocalPlayerID(i)},{AddV(BrightLoc,1)},{preserved})
	TriggerX(FP,{CV(InterfaceNum[i+1],1,AtLeast),CV(BrightLoc,14,AtLeast),LocalPlayerID(i)},{SubV(BrightLoc,1)},{preserved})
	CDoActions(FP,{TSetMemory(0x657A9C,SetTo,BrightLoc)})

	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--키인식부
	--TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"P")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	--CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetCp(i),CenterView(72),SetCp(FP)})

	--CIfXEnd()






	--총 버프 값 합산
	--CallTrigger(FP,Call_SetValue)
	
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
    CMov(FP,iv.XEPer48[i+1],iv.CXPer48[i+1])
    CAdd(FP,iv.XEPer44[i+1],iv.Stat_XEPer44[i+1])
    CAdd(FP,iv.XEPer45[i+1],iv.Stat_XEPer45[i+1])
    CAdd(FP,iv.XEPer46[i+1],iv.Stat_XEPer46[i+1])
    CAdd(FP,iv.XEPer47[i+1],iv.Stat_XEPer47[i+1])
    
    CAdd(FP,TotalEPer[i+1],iv.CMEPer[i+1])
    CAdd(FP,iv.XEPer44[i+1],iv.CMEPer[i+1])
    CAdd(FP,iv.XEPer45[i+1],iv.CMEPer[i+1])
    CAdd(FP,iv.XEPer46[i+1],iv.CMEPer[i+1])
    CAdd(FP,iv.XEPer47[i+1],iv.CMEPer[i+1])
    CAdd(FP,TotalEPer[i+1],iv.CMEPer2[i+1])
    CAdd(FP,iv.XEPer44[i+1],iv.CMEPer2[i+1])
    CAdd(FP,iv.XEPer45[i+1],iv.CMEPer2[i+1])
    CAdd(FP,iv.XEPer46[i+1],iv.CMEPer2[i+1])
    CAdd(FP,iv.XEPer47[i+1],iv.CMEPer2[i+1])
    CAdd(FP,iv.XEPer48[i+1],iv.CMEPer2[i+1])

    


	


	--CIfChkVar(iv.FIncm[i+1])
	--CIfChkVar(iv.FSEXP[i+1])


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
	AddV(iv.B_PFfragItem[i+1], 3),
	AddV(B_PCredit[i+1], 150000)
})
Trigger2X(FP,{CV(PBossLV[i+1],7,AtLeast)},{
	AddV(B_PCredit[i+1], 1000000),
	AddV(iv.B_PFfragItem[i+1], 5),

})
Trigger2X(FP,{CV(PBossLV[i+1],8,AtLeast)},{
	AddV(iv.B_PFfragItem[i+1], 250),
	AddV(B_PTicket[i+1],100000)
})
Trigger2X(FP,{CV(PBossLV[i+1],9,AtLeast)},{
	AddV(iv.B_PFfragItem[i+1], 10000),
})
Trigger2X(FP,{CV(PBossLV[i+1],10,AtLeast)},{
	AddV(B_PTicket[i+1],1000000)
})
CIf(FP,{CD(iv.HotTimeBonus2,1)})

Trigger2X(FP,{CV(PBossLV[i+1],5,AtLeast)},{
	AddV(B_PTicket[i+1],5), --유닛 판매권 5개
})
Trigger2X(FP,{CV(PBossLV[i+1],6,AtLeast)},{
	AddV(iv.B_PFfragItem[i+1], 3),
	AddV(B_PCredit[i+1], 150000)
})
Trigger2X(FP,{CV(PBossLV[i+1],7,AtLeast)},{
	AddV(B_PCredit[i+1], 1000000),
	AddV(iv.B_PFfragItem[i+1], 5),

})
Trigger2X(FP,{CV(PBossLV[i+1],8,AtLeast)},{
	AddV(iv.B_PFfragItem[i+1], 250),
	AddV(B_PTicket[i+1],100000)
})
Trigger2X(FP,{CV(PBossLV[i+1],9,AtLeast)},{
	AddV(iv.B_PFfragItem[i+1], 10000),
})
Trigger2X(FP,{CV(PBossLV[i+1],10,AtLeast)},{
	AddV(B_PTicket[i+1],1000000)
})
CIfEnd()

for pb= 1, 10 do
	TriggerX(FP,{LocalPlayerID(i),CV(PBossLV[i+1],pb,AtLeast)},{SetV(Time,(300000)-5000),SetCD(SaveRemind,1),SetCp(i),DisplayText(StrDesignX("\x08"..pb.."단계 \x07개인보스\x04를 클리어하였습니다. \x07잠시 후 자동저장됩니다..."),4),SetCp(FP)})
end

CallTriggerX(FP, Call_TimeAttack44, {Command(i, AtLeast, 1, LevelUnitArr[44][2])}, {SetCp(i)}, 1)
CallTriggerX(FP, Call_TimeAttack48, {Command(i, AtLeast, 1, LevelUnitArr[48][2])}, {SetCp(i)}, 1)
CallTriggerX(FP, Call_TimeAttack50, {Command(i, AtLeast, 1, LevelUnitArr[50][2])}, {SetCp(i)}, 1)



TriggerX(FP,{CV(PBossLV[i+1],5,AtLeast)},{KillUnitAt(1,13,119+i,FP)})
TriggerX(FP,{CV(PBossLV[i+1],6,AtLeast)},{SetCDX(PBossClearFlag, 1,1)})
TriggerX(FP,{CV(PBossLV[i+1],7,AtLeast)},{SetCDX(PBossClearFlag, 2,2)})
TriggerX(FP,{CV(PBossLV[i+1],8,AtLeast)},{SetCDX(PBossClearFlag, 4,4)})
TriggerX(FP,{CV(PBossLV[i+1],9,AtLeast)},{SetCDX(PBossClearFlag, 8,8)})



	--if TestStart == 1 then
	--	TriggerX(FP,{},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- 인원수 버프 보너스
	--else
		
		TriggerX(FP,{CD(PartyBonus2,1,AtLeast)},{AddV(TotalEPer[i+1],1000),AddV(General_Upgrade[i+1],15)},{preserved})-- 인원수 버프 보너스
	--end
	
    CAdd(FP,TotalBreakShield[i+1],iv.CBrSh[i+1])
    CAdd(FP,TotalBreakShield[i+1],iv.CBrSh2[i+1])

	CMov(FP,BreakShield,TotalBreakShield[i+1])
	

    CMov(FP,GEper,TotalEPer[i+1])
    CMov(FP,GEper2,TotalEPer2[i+1])
    CMov(FP,GEper3,TotalEPer3[i+1])
    CMov(FP,GEper4,TotalEPer[i+1])
    CAdd(FP,GEper4,TotalEPer2[i+1])
    CAdd(FP,GEper4,TotalEPer3[i+1])
    CAdd(FP,GEper4,TotalEPer4[i+1])
    CMov(FP,GetXEper44,iv.XEPer44[i+1])
    CMov(FP,GetXEper45,iv.XEPer45[i+1])
    CMov(FP,GetXEper46,iv.XEPer46[i+1])
    CMov(FP,GetXEper47,iv.XEPer47[i+1])
    CMov(FP,GetXEper48,iv.XEPer48[i+1])


	CIfChkVars({iv.TotalBreakShield[i+1],GEper4})--총 특확, 파방 비교
	CMov(FP,iv.TotalBreakShield2[i+1],_Div(iv.TotalBreakShield[i+1],_Mov(10)))
	CallTrigger(FP,Call_SetBrSh)

	CIfEnd()

	CIfChkVars({iv.TotalBreakShield[i+1],XEPerM})--개별확률 마이너스값, 파방 비교
	
	CallTrigger(FP,Call_SetBrSh2)

	CIfEnd()


	TriggerX(FP,{CV(PLevel[i+1],999,AtMost)},{AddV(Stat_EXPIncome[i+1],10)},{preserved})-- 1000레벨 미만 경치2배

	CIf(FP,{CV(B_Credit,1,AtLeast)})
	f_LAdd(FP,Credit[i+1],Credit[i+1],{B_Credit,0}) -- 
	CIfEnd({})
	CIf(FP,{CV(B_Ticket,1,AtLeast)})
	f_LAdd(FP, SellTicket[i+1], SellTicket[i+1], {B_Ticket,0})
	CIfEnd({})
	
	CIf(FP,CD(SCA.LoadCheckArr[i+1],2))--불러올경우 보상 대입 작동
	CIf(FP,{CV(B_PCredit[i+1],1,AtLeast)})
	f_LAdd(FP,Credit[i+1],Credit[i+1],{B_PCredit[i+1],0}) --
	CMov(FP, B_PCredit[i+1], 0)
	CIfEnd({})
	
	CIf(FP,{CV(iv.OldFfrag[i+1],1,AtLeast)})
	local TempVX = CreateVar(FP)
	f_Mul(FP, TempVX, iv.OldFfrag[i+1], 5)
	f_LAdd(FP,iv.FfragItem[i+1],iv.FfragItem[i+1],{TempVX,0}) --
	DisplayPrint(i,{"\x13\x07『 \x02???\x04을 \x07",iv.OldFfrag[i+1]," 개 \x07변환하여\x04 \x02무색 조각\x04을 ",TempVX," 개 획득하였습니다. 현재 총 획득량 : \x07",iv.FfragItem[i+1]," 개 \x07』"})
	CMov(FP, iv.OldFfrag[i+1], 0)
	CIfEnd({})


	CIf(FP,{CV(B_PEXP[i+1],1,AtLeast)})
	
	CIf(FP,{CV(PLevel[i+1],LevelLimit-1,AtMost)})
	f_LAdd(FP,PEXP[i+1],PEXP[i+1],{B_PEXP[i+1],0}) --
	CIfEnd()
	CMov(FP, B_PEXP[i+1], 0)
	CIfEnd({})
	CIf(FP,{CV(B_PTicket[i+1],1,AtLeast)})
	f_LAdd(FP, SellTicket[i+1], SellTicket[i+1], {B_PTicket[i+1],0})
	CMov(FP, B_PTicket[i+1], 0)
	CIfEnd({})
	CIfEnd()


	

	
	DoActionsX(FP,{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 0),SetMemoryB(0x58F32C+(i*15)+12, SetTo, 0),})


	for CBit = 0, 7 do -- 8비트 연산을 통한 업글수치 복사
		TriggerX(FP,{NVar(ScoutDmg[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+12, Add, 2^CBit)},{preserved})
		TriggerX(FP,{NVar(General_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit)},{preserved})
	end
	--if Limit == 1 then--맵제작자용 치트
	--	CIf(FP,{CV(iv.MapMakerFlag[i+1],1)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)})
	--	CMov(FP,IncomeMax[i+1],48,nil,nil,1)
	--	CIfEnd()
	--end

	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 91)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)},{preserved})--뎀지 오버플로우 방지

	

	
	local AutoEnable = {}
	local AutoEnable2 = {}
	local AutoEnable3 = {}
	for j, k in pairs(LevelUnitArr) do
		table.insert(AutoEnable, SetMemX(Arr(AutoEnchArr2,((j-1)*7)+i), SetTo, 1))
		if j~= 15 then
			table.insert(AutoEnable2, SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 1))
		end

		table.insert(AutoEnable3, SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0))
		if SpeedTestMode == 1 then
			Trigger2X(FP, {}, AutoEnable)
			Trigger2X(FP, {}, AutoEnable2)
			Trigger2X(FP, {}, AutoEnable3)
		else
			Trigger2X(FP, {Command(i,AtLeast,1,k[2])}, AutoEnable)
		end
		--CIf(FP,MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1))
		--CallTriggerX(FP,Call_Print13[i+1],{MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)})
		--if SpeedTestMode == 0 then
		--	TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})
		--	TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)}, {SetMemX(Arr(AutoEnchArr,((j-1)*7)+i), SetTo, 0)}, {preserved}) 
		--end
		--TriggerX(FP, {MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1)}, {Order(k[2], i, 36+i, Move, 8+i)}, {preserved})
		--CIfEnd()

--		--CIf(FP,MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1))
		--CallTriggerX(FP,Call_Print13[i+1],{MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)})
		--TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})
		--TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1),CD(AutoEnchArr2[j][i+1],0)}, {SetMemX(Arr(AutoSellArr,((j-1)*7)+i), SetTo, 0)}, {preserved})
		--TriggerX(FP, {MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1)}, {Order(k[2], i, 36+i, Move, 73+i)}, {preserved})
		--CIfEnd()
	--table.insert(LevelUnitArr,{Level,UnitID,Per,Exp})


	end

	CIf(FP,{VRange(BossLV,0,4)})
	for j = 26, 40 do
		Trigger2X(FP, {MemX(Arr(AutoEnchArr2,((j-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((j+1-1)*7)+i), Exactly, 0)}, {RemoveUnitAt(All, "Factories", 109, i)})
		CreateUnitStacked({Bring(i,AtMost,3,LevelUnitArr[j][2],109),MemX(Arr(AutoEnchArr2,((j-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((j+1-1)*7)+i), Exactly, 0)}, 1, LevelUnitArr[j][2], 109,nil, i, nil)
	end
	for j = 48, 50 do
		Trigger2X(FP, {MemX(Arr(AutoEnchArr2,((j-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((j+1-1)*7)+i), Exactly, 0)}, {RemoveUnitAt(All, "Factories", 109, i)})
		CreateUnitStacked({Bring(i,AtMost,3,LevelUnitArr[j][2],109),MemX(Arr(AutoEnchArr2,((j-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((j+1-1)*7)+i), Exactly, 0)}, 1, LevelUnitArr[j][2], 109,nil, i, nil)
	end

	CIfEnd()
	CIf(FP,{VRange(BossLV,5,6)})
	function BossRange(left,right)
		Trigger2X(FP, {MemX(Arr(AutoEnchArr2,((left-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((right+1-1)*7)+i), Exactly, 0)}, {RemoveUnitAt(All, "Factories", 109, i)})
		CreateUnitStacked({Bring(i,AtMost,3,LevelUnitArr[left][2],109),MemX(Arr(AutoEnchArr2,((left-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((right+1-1)*7)+i), Exactly, 0)}, 1, LevelUnitArr[left][2], 109,nil, i, nil)
	end
	for x,y in pairs({26,36,40,48,49,50}) do
		Trigger2X(FP, {MemX(Arr(AutoEnchArr2,((y-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((y+1-1)*7)+i), Exactly, 0)}, {RemoveUnitAt(All, "Factories", 109, i)})
		CreateUnitStacked({Bring(i,AtMost,3,LevelUnitArr[y][2],109),MemX(Arr(AutoEnchArr2,((y-1)*7)+i), Exactly, 1),MemX(Arr(AutoEnchArr2,((y+1-1)*7)+i), Exactly, 0)}, 1, LevelUnitArr[y][2], 109,nil, i, nil)
	end
	CIfEnd()
	
	CIfX(FP, {Memory(0x628438,AtLeast,1),TCommand(i,AtMost,ULimitV2,"Men")}) -- 자동구매 관리

	CIf(FP,{TTOR({CV(AutoBuyCode[i+1],1,AtLeast),CV(iv.AutoBuyCode2[i+1],1,AtLeast)})})
	CallTrigger(FP, Call_AutoBuy,{})
	CIfEnd()
	
	--CheckTrig("Interface_Point_4_P"..(i+1))
	for j, k in pairs(LevelUnitArr) do
		local UID = k[2]
		local Per = k[3]
		local Exp = k[4]
		
		CIf(FP,{Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], j-1), AtLeast, 1)},{SetV(UVA1,604*(j-1)),SetV(UVA4,2416*(j-1)),SetV(EXPV,Exp),SetV(UIDV,UID),SetV(CJ,((j-1)*7)+i),SetV(UIDV,UID),SetV(CIV,j-1),SetV(UEper,Per),SetV(UEper2,math.floor(Per/10)),SetV(UEper3,math.floor(Per/100))})
		CMov(FP,GetCreateUnit,VArr(GetUnitVArr[i+1], j-1),nil,nil,1)
		CallTrigger(FP, Call_GetUnit)

		CSub(FP,VArr(GetUnitVArr[i+1], j-1),GetCreateUnit)

		CIfEnd()
	end


	CElseIfX({TTOR({Memory(0x628438,AtMost,0),_TCommand(i,AtLeast,ULimitV2,"Men")})})
	CallTrigger(FP,Call_Print13[i+1])
	for j = 1, 7 do
		TriggerX(FP, {LocalPlayerID(i),CV(PCheckV,j)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: 보유 유닛수가 너무 많아 유닛 구입할 수 없습니다.\x08 (최대 "..ULimitArr[j].."기)"))},{preserved})
	end
	CIfXEnd()

	
	CIf(FP,{CV(iv.Money3[i+1],1,AtLeast)})--800경이하일때 3번째변수가 1이상일경우
	CIf(FP,{TTNWar(Money[i+1], AtMost, "8000000000000000000")})
	local TempV = CreateVar(FP)
	CMov(FP,TempV,iv.Money3[i+1])
	TriggerX(FP, {CV(TempV,10,AtLeast)},{SetV(TempV,10)},{preserved})
	f_LAdd(FP, Money[i+1], Money[i+1], _LMul({TempV,0}, "800000000000000000"))
	CSub(FP,iv.Money3[i+1],TempV)
	CIfEnd()
	CIfEnd()
	
	CIf(FP,{CV(Money2[i+1],1,AtLeast)})--800경이하일때 2번째변수가 1이상일경우
	CIf(FP,{TTNWar(Money[i+1], AtMost, "8000000000000000000")})
	f_LAdd(FP, Money[i+1], Money[i+1], "10000000000000000000")
	CSub(FP,Money2[i+1],1)
	CIfEnd()
	CIfEnd()
	

	
	
	for j, k in pairs(LevelUnitArr) do
	
		local UID = k[2]
		local Per = k[3]
		local Exp = k[4]
	TriggerX(FP,{Command(i,AtLeast,1,k[2]),MemX(Arr(AutoEnchArr,((j-1)*7)+i), Exactly, 1)},{Order(UID, i, 36+i, Move, i+8)},{preserved})
	TriggerX(FP,{Command(i,AtLeast,1,k[2]),MemX(Arr(AutoSellArr,((j-1)*7)+i), Exactly, 1)},{Order(UID, i, 36+i, Move, i+73)},{preserved})
	end
	


	
	CallTriggerX(FP, Call_EnchFunc,{Bring(i,AtLeast,1,"Men",8+i)},{SetV(ECP,i)})
	CallTriggerX(FP, Call_SellFunc,{Bring(i,AtLeast,1,"Men",73+i)},{SetV(ECP,i)})
	TriggerX(FP,{Bring(i,AtLeast,1,88,73+i)},{MoveUnit(1,88,i,73+i,36+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 해당 유닛은 판매할 수 없습니다..."), 4),SetCp(FP)},{preserved})
	

	CIf(FP,{TTNWar(TempEXPW,AtLeast,"1")})
		f_LAdd(FP, PEXP[i+1], PEXP[i+1],TempEXPW)
		CIf(FP,{CV(Stat_EXPIncome[i+1],1,AtLeast)})
			f_LAdd(FP,PEXP2[i+1],PEXP2[i+1],_LMul(TempEXPW,{Stat_EXPIncome[i+1],0}))
			f_LAdd(FP, PEXP[i+1], PEXP[i+1], _LDiv(PEXP2[i+1],"10"))
			f_LMod(FP, PEXP2[i+1],PEXP2[i+1], "10")
		CIfEnd()
		f_LMov(FP, TempEXPW, "0")
	CIfEnd()
	


	CallTriggerX(FP, Call_Shop,{Bring(i, AtLeast, 1, 15, 112)})

	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0),SetV(ResetStatLoc,0)}) -- CAPrint에 전송할 값들
	CallTrigger(FP, Call_GetLocalData)
	TriggerX(FP,{CD(iv.StatEff[i+1],1)},{SetCD(iv.StatEffLoc,1)},{preserved})
	CIfEnd()
	DoActionsX(FP,{SubCD(ZKeyCool[i+1], 1)})
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
				CIf(FP,{CV(KSelPID,i),TTNVar(KSelUID,NotSame,15),TTNVar(KSelUID,NotSame,217),TTNVar(KSelUID,NotSame,15),TTNVar(KSelUID,NotSame,128),TTNVar(KSelUID,NotSame,129),TTNVar(KSelUID,NotSame,219),TTNVar(KSelUID,NotSame,91),TTNVar(KSelUID,NotSame,92),TTNVar(KSelUID,NotSame,PersonalUIDArr[i+1])})
				f_Read(FP, _Sub(BackupCp,15), CPos, nil,nil,1)
				Convert_CPosXY()
				Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,Simple_CalcLoc(86, -320, -320, 320, 320))
				CDoActions(FP, {AddCD(ZKeyCool[i+1], 24*3),TMoveUnit(All, KSelUID, i, 87, 87)})
				DoActionsX(FP, {SetCp(i),DisplayText(StrDesignX("\x03SYSTEM \x04: 현재 선택중인 같은 종류의 유닛을 뭉쳤습니다. 쿨타임 : 3초.").."\n"..StrDesignX("\x04이 메세지는 1회만 표기됩니다."),4)}, 1)
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

		
		CIf(FP,{CD(SCA.LoadSlot1[i+1],0),CD(SCA.GlobalCheck,3),CD(SCA.LoadCheckArr[i+1],2),Deaths(i, AtLeast, 1,14),})--로드슬롯 프로토콜이 완료되어야됨
	if Limit == 0 then
		NIfX(FP,{CV(CurMission[i+1],3,AtLeast)},{SetV(DPErT[i+1],24*10)}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
	else
		NIfX(FP,{CV(iv.MapMakerFlag[i+1],1,AtLeast),CV(CurMission[i+1],3,AtLeast)},{SetV(DPErT[i+1],24*10)}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
	end
	
	--NIfX(FP,{CV(CurMission[i+1],3,AtLeast)},{SetV(DPErT[i+1],24*10)}) -- 저장버튼을 누르거나 자동저장 시스템에 의해 해당 트리거에 진입했을 경우
		CallTriggerX(FP,Call_Print13[i+1],{SCA.Available(i),Deaths(i, Exactly, 1, 14)})
		TriggerX(FP, {SCA.Available(i),Deaths(i, Exactly, 1, 14),LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x03SCArchive\x04에 \x07게임 데이터\x04를 저장하고 있습니다..."))}, {preserved})
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 4, 2),SetDeaths(i, SetTo, 2,14),SCA.Reset(i)},{preserved})--저장신호 보내기
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--저장트리거 닫고 CT작동
		CMov(FP,iv.PLevel2[i+1],PLevel[i+1])
		CIfX(FP,{TTNWar(iv.FfragItem[i+1],AtLeast,"42949672950000")},{SetV(iv.FfragItemRank[i+1],-1)})
		CElseX()
		f_Cast(FP, {iv.FfragItemRank[i+1],0}, _LDiv(iv.FfragItem[i+1], "10000"), nil, nil, 1)
		CIfXEnd()
		CIf(FP,CV(iv.MapMakerFlag[i+1],1))--제작자일경우 레벨 1으로 저장후 세팅.
		CMov(FP,PLevelBak,PLevel[i+1])
		CMov(FP,PLevel[i+1],1)
		CMov(FP,iv.FfragItemRank[i+1],0)
		CIfEnd()
		SCA_DataReset(i)
		CallTrigger(FP,Call_SCA_DataSaveAll)
		CIf(FP,CV(iv.MapMakerFlag[i+1],1))
		CMov(FP,PLevel[i+1],PLevelBak)
		CIfEnd()
		NElseIfX({CV(CurMission[i+1],2,AtMost)},{SetV(DPErT[i+1],24*10),SetDeaths(i, SetTo, 0,14)}) -- 조건불만족 - 미션3번클리어못함
		CallTriggerX(FP,Call_Print13[i+1],{})
		TriggerX(FP, {LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 저장을 하기 위해서는 먼저 \x07M\x04ission \x08No. \x103\x04 까지 클리어 하셔야 합니다."))}, {preserved})
		if Limit == 1 then
		
		NElseIfX({CV(iv.MapMakerFlag[i+1],0)},{SetV(DPErT[i+1],24*10)}) -- 조건불만족 - 테스트맵
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 2, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--저장트리거 닫고 CT작동
		CallTriggerX(FP,Call_Print13[i+1],{SCA.Available(i),Deaths(i, Exactly, 1, 14)})
		TriggerX(FP, {SCA.Available(i),Deaths(i, Exactly, 1, 14),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 테스트맵에서는 게임 데이터를 저장할 수 없습니다..."))}, {preserved})
		
		TriggerX(FP,{SCA.Available(i),Deaths(i, Exactly, 1, 14)},{SetDeaths(i, SetTo, 0,14),SetCD(CTSwitch,1),SCA.Reset(i)},{preserved})--저장신호 보내기
		end
		NIfXEnd()
		CIfEnd()
		--TriggerX(FP, {CV(LV5Cool[i+1],0,AtMost);}, {SetCD(BossLV6Private[i+1],0)},{preserved})
	CallTriggerX(FP, Call_BossReward,{CV(BossLV,5,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,1)},1)
	CallTriggerX(FP, Call_BossReward,{CV(PBossLV[i+1],6,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,2)},1)
	CallTriggerX(FP, Call_BossReward,{CV(BossLV,6,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,3)},1)
	CallTriggerX(FP, Call_BossReward,{CD(iv.HotTimeBonus2,1),CV(BossLV,5,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,1)},1)
	CallTriggerX(FP, Call_BossReward,{CD(iv.HotTimeBonus2,1),CV(PBossLV[i+1],6,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,2)},1)
	CallTriggerX(FP, Call_BossReward,{CD(iv.HotTimeBonus2,1),CV(BossLV,6,AtLeast),CD(SCA.LoadCheckArr[i+1],2)},{SetV(CurBossReward,3)},1)
	CIfEnd()
	

	--CheckTrig("Interface_End_P"..(i+1))
end



--CheckTrig("Interface_End")
end
