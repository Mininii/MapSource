function TestTrig()
	
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
	local PLevel = iv.PLevel--CreateVarArr2(7,1,FP)-- 자신의 현재 레벨
	local StatP = iv.StatP--CreateVarArr(7,FP)-- 현재 보유중인 스탯포인트
	local Stat_BossSTic = iv.Stat_BossSTic--CreateVarArr(7,FP)-- 사냥터 업글 수치
	local Stat_BossLVUP = iv.Stat_BossLVUP--CreateVarArr(7,FP)-- 사냥터 업글 수치
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
	local LV5Cool = iv.LV5Cool
	local Stat_EXPIncome = iv.Stat_EXPIncome--CreateVarArr(7,FP)-- 경험치 획득량 수치. 사용 미정
	local PEXP2 = iv.PEXP2--CreateVarArr(7, FP) -- 1/10로 나눠 경험치에 더할 값 저장용. 사용 미정
if TestStart == 1 then
	for i = 0, 0 do
		--[[
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
		CIfEnd()]]
	end
	end

end