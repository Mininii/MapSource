function TestTrig()
	
	local Money = iv.Money-- CreateWarArr(7,FP) -- �ڽ��� ���� �� ������
	local IncomeMax = iv.IncomeMax-- CreateVarArr2(7,12,FP) -- �ڽ��� ����� �ִ� ���ּ�
	local Income = iv.Income-- CreateVarArr(7,FP) -- �ڽ��� ���� ����Ϳ� �������� ���ּ�
	local BuildMul1 = iv.BuildMul1-- CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	local BuildMul2 = iv.BuildMul2-- CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	local TotalEPer = iv.TotalEPer-- CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	local TotalEPer2 = iv.TotalEPer2-- CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	local TotalEPer3 = iv.TotalEPer3-- CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	local ScoutDmg = iv.ScoutDmg-- CreateVarArr(7,FP) -- �⺻���� ������
	local ScTimer = iv.ScTimer-- CreateCcodeArr(7)
	local PTimeV = iv.PTimeV
	local ResetStat = iv.ResetStat
	local General_Upgrade = iv.General_Upgrade--CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	local PBossLV = iv.PBossLV -- ���κ�������
	local PBossDPS = iv.PBossDPS-- ���κ���DPS
	local TotalPBossDPS = iv.TotalPBossDPS --���κ���DPS ��ǥġ
	local SellTicket = iv.SellTicket
	local PLevel = iv.PLevel--CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	local StatP = iv.StatP--CreateVarArr(7,FP)-- ���� �������� ��������Ʈ
	local Stat_BossSTic = iv.Stat_BossSTic--CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_BossLVUP = iv.Stat_BossLVUP--CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_TotalEPer = iv.Stat_TotalEPer--CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPer2 = iv.Stat_TotalEPer2--CreateVarArr(7,FP)-- +2�� Ȯ�� ��ġ
	local Stat_TotalEPer3 = iv.Stat_TotalEPer3--CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
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
	local LV5Cool = iv.LV5Cool
	local Stat_EXPIncome = iv.Stat_EXPIncome--CreateVarArr(7,FP)-- ����ġ ȹ�淮 ��ġ. ��� ����
	local PEXP2 = iv.PEXP2--CreateVarArr(7, FP) -- 1/10�� ���� ����ġ�� ���� �� �����. ��� ����
if TestStart == 1 then
	for i = 0, 0 do
		--[[
		CIf(FP, HumanCheck(i,1))
		if TestStart == 1 then -- ������ �ܼ� �ϴܺ����������(�氥��)
	
			L = CreateVar()
			CIfOnce(FP)
			GetPlayerLength(FP,P1,L)
			CIfEnd()
			N = CreateVar()
			local CU = CreateCcodeArr(40)
			local CUCool = CreateCcodeArr(40)
			SLoopN(FP,11,Always(),{SetNVar(N,Add,218)},{SetNVar(N,SetTo,0x640B63-218),TSetNVar(N,Add,L)})
	
			for j,k in pairs({PLevel[i+1],SellTicket[i+1],IncomeMax[i+1],TotalEPer[i+1],TotalEPer2[i+1],TotalEPer3[i+1],General_Upgrade[i+1],Stat_EXPIncome[i+1]}) do
				f_bytecmp(FP,{CU[j]},N,_byteConvert(GetStrArr(0,"@"..j.."��")),GetStrSize(0,"@"..j.."��"))
			
			end
			for j,k in pairs({Credit[i+1],Money[i+1]}) do
				f_bytecmp(FP,{CU[j+8]},N,_byteConvert(GetStrArr(0,"@"..(j+8).."��")),GetStrSize(0,"@"..(j+8).."��"))
				
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