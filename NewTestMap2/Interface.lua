function Interface()

	--PlayData(NonSCA)
	local Money = CreateWarArr(7,FP)
	local TotalExp = CreateWarArr2(7,"10",FP)
	local IncomeMax = CreateVarArr2(7,12,FP)
	local Income = CreateVarArr(7,FP)
	local BuildMul1 = CreateVarArr2(7,1,FP)
	local BuildMul2 = CreateVarArr2(7,1,FP)
	local TotalEPer = CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	local TotalEPer2 = CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	local TotalEPer3 = CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	local CurEXP = CreateWarArr(7,FP)
	
	--Setting, Effect
	local StatEff = CreateCcodeArr(7)
	local StatEffT2 = CreateCcodeArr(7)
	local InterfaceNum = CreateVarArr(7,FP)
	local Stat_Upgrade_UI = CreateVarArr(7,FP)
	local AutoBuyCode = CreateCcodeArr(7)

	local PCheckV = CreateVar(FP)
	
	--PlayData(SCA)
	local PLevel = CreateVarArr2(7,1,FP)
	local StatP = CreateVarArr(7,FP)
	local Stat_Income = CreateVarArr(7,FP)
	local Stat_TotalEPer = CreateVarArr(7,FP)
	local Stat_TotalEPer2 = CreateVarArr(7,FP)
	local Stat_TotalEPer3 = CreateVarArr(7,FP)
	local Stat_EXPIncome = CreateVarArr(7,FP)
	local Stat_Upgrade = CreateVarArr(7,FP)
	local Credit = CreateWarArr(7,FP) -- SCA Data
	local PEXP = CreateWarArr(7, FP) -- SCA Data





	--Local Data Variable
	local IncomeMaxLoc = CreateVar(FP)
	local IncomeLoc = CreateVar(FP)
	local LevelLoc = CreateVar(FP)
	local TotalEPerLoc = CreateVar(FP)
	local TotalEPer2Loc = CreateVar(FP)
	local TotalEPer3Loc = CreateVar(FP)
	local StatPLoc = CreateVar(FP)
	local MoneyLoc = CreateWar(FP)
	local CredLoc = CreateWar(FP)
	local ExpLoc = CreateVar(FP)
	local TotalExpLoc = CreateVar(FP)
	local InterfaceNumLoc = CreateVar(FP)
	local UpgradeLoc = CreateVar(FP)
	local EXPIncomeLoc = CreateVar(FP)
	local StatEffLoc = CreateCcode()


	--Temp
	local TempReadV = CreateVar(FP)
	local TempEXPV = CreateVar(FP)
	--local GEXP = CreateVar(FP)
	local STable = {"1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "2048", "4096", "8192", "16384", "32768", "65536", "131072", "262144", "524288", "1048576", "2097152", "4194304", "8388608", "16777216", "33554432", "67108864", "134217728", "268435456", "536870912", "1073741824", "2147483648", "4294967296", "8589934592", "17179869184", "34359738368", "68719476736", "137438953472", "274877906944", "549755813888", "1099511627776", "2199023255552", "4398046511104", "8796093022208", "17592186044416", "35184372088832", "70368744177664", "140737488355328", "281474976710656", "562949953421312", "1125899906842624", "2251799813685248", "4503599627370496", "9007199254740992", "18014398509481984", "36028797018963968", "72057594037927936", "144115188075855872", "288230376151711744", "576460752303423488", "1152921504606846976", "2305843009213693952", "4611686018427387904", "9223372036854775807"}

	function AutoBuy(CP,LvUniit,Cost)--Cost==String
		CIf(FP,{Memory(0x628438,AtLeast,1),CD(AutoBuyCode[CP+1],LvUniit)})
			CIf(FP, {TTNWar(Money[CP+1],AtLeast,Cost)})
				f_LSub(FP, Money[CP+1], Money[CP+1], Cost)
				CreateUnitStacked({}, 1, LevelUnitArr[LvUniit][2], 43+CP,nil, CP)
			CIfEnd()
		CIfEnd()
		
	end
	CMov(FP,PCheckV,0)
	for i = 0, 6 do
		TriggerX(FP,{HumanCheck(i,1)},{AddV(PCheckV,1)},{preserved})
	end
for i = 0, 6 do -- ���÷��̾�
	CIf(FP,{HumanCheck(i,1)})
	UnitReadX(FP, i, "Men", 65+i, Income[i+1])
	if TestStart == 1 then
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], "1")
		--f_LMul(FP, PEXP[i+1], PEXP[i+1], "2")
		--f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], "1")
		--f_LMul(FP, TotalExp[i+1], TotalExp[i+1], "2")
	end

	local LevelUpJump = def_sIndex()
	CJumpEnd(FP, LevelUpJump)
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],9999,AtMost)},{AddV(PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],1)),TempReadV,nil,nil,1)
	f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], {TempReadV,0})
	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],2)),TempReadV,nil,nil,1)
	f_LAdd(FP, CurEXP[i+1], CurEXP[i+1], {TempReadV,0})
	CAdd(FP,StatP[i+1],5)
	CallTrigger(FP,Call_Print13[i+1])
	TriggerX(FP, {LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x1F������ �ö����ϴ�! \x17O Ű\x04�� ���� \x07�ɷ�ġ\x04�� �������ּ���."))}, {preserved})
	CJump(FP, LevelUpJump)
	NIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})


	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--�⺻��������
	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	for NBit = 2,7 do
		TriggerX(FP,{Accumulate(i, AtLeast, 10^NBit, Ore)},{SetV(BuildMul1[i+1],2^(NBit-1)),SetCp(i),DisplayText(StrDesignX("�ǹ��� \x1BDPS\x1F(�̳׶�)\x04�� \x08"..10^NBit.." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..(2^(NBit-1)).."��\x04�� �����Ͽ����ϴ�.")),SetCp(FP)})--1���ǹ�
		TriggerX(FP,{Accumulate(i, AtLeast, 10^NBit, Gas)},{SetV(BuildMul2[i+1],2^(NBit-1)),SetCp(i),DisplayText(StrDesignX("�ǹ��� \x1BDPS\x07(����)\x04�� \x08"..10^NBit.." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..(2^(NBit-1)).."��\x04�� �����Ͽ����ϴ�.")),SetCp(FP)})--2���ǹ�
	end

	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{Ore},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas},Money[i+1])




	CTrigger(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65)},{MoveUnit(1, "Men", i, 15+i, 22+i),},1)
	DoActions(FP,{
		MoveUnit(1, "Men", i, 29+i, 36+i),
		MoveUnit(1, "Factories", i, 22+i, 57+i),
	})



	--��ȭ������ ���� �����ϱ�(ĵ����������)
	for j, k in pairs(LevelUnitArr) do
		CreateUnitStacked({Memory(0x628438,AtLeast,1),CVAar(VArr(GetUnitVArr[i+1], k[1]-1), AtLeast, 1)}, 1, k[2], 50+i,36+i, i, {SetCVAar(VArr(GetUnitVArr[i+1], k[1]-1), Subtract, 1)})
	end


	BtnSetInit(i,TestShop) -- ���� �ڵ����ű�
		for j, k in pairs(AutoBuyArr) do
			CIfBtnFunc(i,j-1,StrDesign("\x06"..k[1].."�� \x04���� \x1B�ڵ����� \x08OFF"),StrDesign("\x06"..k[1].."�� \x04���� \x1B�ڵ����� \x07ON"),CD(AutoBuyCode[i+1],k[1]),SetCD(AutoBuyCode[i+1],0),SetCD(AutoBuyCode[i+1],k[1]))
			CIfEnd()
		end
	
		CIfBtnFunc(i,24,StrDesign("\x04���� \x1B�ڵ����� \x08OFF"),StrDesign("\x04���� \x1B�ڵ����� \x07OFF"),nil,SetCD(AutoBuyCode[i+1],0),SetCD(AutoBuyCode[i+1],0))
		CIfEnd()
	BtnSetEnd()

	BtnSetInit(i,SettingUnit1) -- 1~25������ �ڵ���ȭ ����

	for j = 1, 25 do
		CIfBtnFunc(i,j-1,StrDesign("\x06"..j.."�� \x04���� \x1B�ڵ���ȭ \x07ON"),StrDesign("\x06"..j.."�� \x04���� \x1B�ڵ���ȭ \x08OFF"),CD(AutoEnchArr[j][i+1],0),SetCD(AutoEnchArr[j][i+1],1),SetCD(AutoEnchArr[j][i+1],0))
	
		CIfEnd()
	end
	BtnSetEnd()

	BtnSetInit(i,SettingUnit2) -- 26~39���� �ڵ���ȭ ����

	for j = 26, 40 do
		local ContentStr1 = "\x06"..j.."�� \x04���� \x1B�ڵ���ȭ \x07ON"
		local ContentStr2 = "\x06"..j.."�� \x04���� \x1B�ڵ���ȭ \x08OFF"
		if j == 40 then
			ContentStr1 = "\x06"..j.."�� \x04���� \x07�ڵ��Ǹ� \x07ON"
			ContentStr2 = "\x06"..j.."�� \x04���� \x07�ڵ��Ǹ� \x08OFF"
		end
		CIfBtnFunc(i,j-26,StrDesign(ContentStr1),StrDesign(ContentStr2),CD(AutoEnchArr[j][i+1],0),SetCD(AutoEnchArr[j][i+1],1),SetCD(AutoEnchArr[j][i+1],0))
	
		CIfEnd()
	end
	BtnSetEnd()

	for j, k in pairs(LevelUnitArr) do
		TriggerX(FP, {Command(i,AtLeast,1,k[2])}, {SetCD(AutoEnchArr2[j][i+1],1)})
		CIf(FP,CD(AutoEnchArr[j][i+1],1))
			
		CallTriggerX(FP,Call_Print13[i+1],{CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: �ּ� 1ȸ �̻� �ش� ������ ��ȭ�� �����ؾ��մϴ�."))}, {preserved})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)}, {SetCD(AutoEnchArr[j][i+1],0)}, {preserved})
		if k[1]==40 then
			TriggerX(FP, {CD(AutoEnchArr[j][i+1],1)}, {Order(k[2], i, 36+i, Move, 73+i)}, {preserved})
		else
			TriggerX(FP, {CD(AutoEnchArr[j][i+1],1)}, {Order(k[2], i, 36+i, Move, 8+i)}, {preserved})
		end
		CIfEnd()
	end
	CIfX(FP, {Command(i,AtMost,199,"Men"),CD(AutoBuyCode[i+1],1,AtLeast)}) -- �ڵ����� ����
	for j, k in pairs(AutoBuyArr) do
		AutoBuy(i,k[1],k[2])
	end
	CElseIfX({Command(i,AtLeast,200,"Men")})
	CallTrigger(FP,Call_Print13[i+1])
	TriggerX(FP, {LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: ���� ���ּ��� �ʹ� ���� ���� ������ �� �����ϴ�.\x08 (�ִ� 200��)"))},{preserved})
	
	CIfXEnd()
	
	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--Ű�νĺ� ����
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"O")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetCp(i),CenterView(72),SetCp(FP)})
	KeyFunc(i,"1",{
		{{CV(StatP[i+1],5,AtLeast),CV(Stat_Income[i+1],35,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Income[i+1],1)},StrDesign("\x1B����� �ִ� ���ּ��� �����Ͽ����ϴ�.")},
		{{CV(Stat_Income[i+1],36,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� �ִ� ���ּ��� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
--	if TestStart == 1 then
--		KeyFunc(i,"2",{
--			{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],89,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
--			{{CV(Stat_Upgrade[i+1],90,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x08������\x04�� �ø� �� �����ϴ�.")},
--			{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
--		})
--	else
		KeyFunc(i,"2",{
			{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],19,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_Upgrade[i+1],20,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x08������\x04�� �ø� �� �����ϴ�.")},
			{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
		})
--	end
	KeyFunc(i,"3",{
		{{CV(StatP[i+1],5,AtLeast),CV(Stat_TotalEPer[i+1],9999,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_TotalEPer[i+1],100)},StrDesign("\x07�� \x08��ȭ Ȯ��\x04�� �����Ͽ����ϴ�.")},
		{{CV(Stat_TotalEPer[i+1],10000,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x07�� \x08��ȭ Ȯ��\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
	KeyFunc(i,"4",{
		{{CV(StatP[i+1],20,AtLeast),CV(Stat_TotalEPer2[i+1],9999,AtMost)},{SubV(StatP[i+1],20),AddV(Stat_TotalEPer2[i+1],100)},StrDesign("\x07+2�� ��ȭȮ��\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
		{{CV(Stat_TotalEPer2[i+1],10000,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x07+2�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],19,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
	KeyFunc(i,"5",{
		{{CV(StatP[i+1],100,AtLeast),CV(Stat_TotalEPer3[i+1],9999,AtMost)},{SubV(StatP[i+1],50),AddV(Stat_TotalEPer3[i+1],100)},StrDesign("\x07+3�� ��ȭȮ��\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
		{{CV(Stat_TotalEPer3[i+1],10000,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x10+3�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],99,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
	--KeyFunc(i,"6",{
	--	{{CV(StatP[i+1],5,AtLeast)},{SubV(StatP[i+1],5),AddV(Stat_EXPIncome[i+1],1)},StrDesign("\x07����ġ ȹ�\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
	--	{{CV(StatP[i+1],0,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	--})
	TriggerX(FP, {MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4),CenterView(36+i)},{preserved})
	CIfXEnd()
	DoActions(FP, SetCp(FP))--Ű�νĺ� ����

	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--Ű�νĺ� ����
	TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"P")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetCp(i),CenterView(72),SetCp(FP)})

	CIfXEnd()
	DoActions(FP, SetCp(FP))--Ű�νĺ� ����


	--�� ���� �� �ջ�
	CMov(FP,IncomeMax[i+1],Stat_Income[i+1],12,nil,1)
	CMov(FP,TotalEPer[i+1],Stat_TotalEPer[i+1],nil,nil,1)
	CMov(FP,TotalEPer2[i+1],Stat_TotalEPer2[i+1],nil,nil,1)
	CMov(FP,TotalEPer3[i+1],Stat_TotalEPer3[i+1],nil,nil,1)
	DoActionsX(FP,{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 0),SetV(Stat_Upgrade_UI[i+1],0)})
	for CBit = 0, 7 do
		TriggerX(FP,{NVar(Stat_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit),AddV(Stat_Upgrade_UI[i+1],(2^CBit)*10)},{preserved})
	end

	for j = 2, 7 do -- ����ũ ���� ����, �����κ�
		TriggerX(FP,{NVar(PCheckV,Exactly,j)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 10),AddV(TotalEPer[i+1],500)},{preserved})
	end
	TriggerX(FP,{MemoryB(0x58F32C+(i*15)+13, AtLeast, 91)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)},{preserved})--���� �����÷ο� ����
	
	CIf(FP,{Bring(i,AtLeast,1,"Men",8+i)},{}) --  ���� ��ȭ�õ��ϱ�
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
	CIf(FP,{Bring(i,AtLeast,1,"Men",73+i)},{}) --  ���� �ǸŽõ��ϱ�
	CMov(FP,TempEXPV,0)
	for j = #LevelUnitArr, 1, -1 do
		local UID = LevelUnitArr[j][2]
		local EXP = LevelUnitArr[j][4]
		if EXP>=1 then
			TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{KillUnitAt(1, UID, 73+i, i),AddV(TempEXPV,EXP)},{preserved})
		else
			TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: �ش� ������ �Ǹ��� �� �����ϴ�.."), 4),SetCp(FP)},{preserved})
		end
	end
	CIf(FP,{CV(TempEXPV,1,AtLeast)})
	f_LAdd(FP, PEXP[i+1], PEXP[i+1], {TempEXPV,0})
	CIf(FP,{CV(Stat_EXPIncome[i+1],1,AtLeast)})
		CAdd(FP,PEXP2[i+1],_Mul(TempEXPV,Stat_EXPIncome[i+1]))
		f_LAdd(FP, PEXP[i+1], PEXP[i+1], {_Div(PEXP2[i+1],_Mov(10)),0})
		f_Mod(FP, PEXP2[i+1], 10)
	CIfEnd()
	CIfEnd()

	CIfEnd()
	
	
	
	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0)}) -- CAPrint�� ������ ����
	CMov(FP,TotalEPerLoc,TotalEPer[i+1])
	CMov(FP,TotalEPer2Loc,TotalEPer2[i+1])
	CMov(FP,TotalEPer3Loc,TotalEPer3[i+1])
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
	CMov(FP,UpgradeLoc,Stat_Upgrade_UI[i+1])
	CMov(FP,EXPIncomeLoc,Stat_EXPIncome[i+1])
	CIfEnd()
	



	CIfEnd()
end

local iStrinit = def_sIndex()
CJump(FP, iStrinit)
t01 = "\x07Ȯ�� \x04: \x0D000.000\x08%\x0D\x0D"
t02 = "\x08!!! \x1F�� �� �� �� \x08!!!"
iStrSize1 = GetiStrSize(0,t01)
S1 = MakeiTblString(1495,"None",'None',MakeiStrLetter("\x0D",iStrSize1+5),"Base",1) -- ����Ű����
iTbl1 = GetiTblId(FP,1495,S1) --NMDMG
TStr1, TStr1a, TStr1s = SaveiStrArr(FP,t01)
TStr2, TStr2a, TStr2s = SaveiStrArr(FP,t02)
SelEPD,SelPer,SelUID,SelMaxHP,SelI = CreateVars(5,FP)
CJumpEnd(FP, iStrinit)


CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- Ŭ�������ν�(����)
f_Read(FP,0x6284B8,nil,SelEPD)
CMov(FP,SelUID,_Read(_Add(SelEPD,25)),nil,0xFF,1)

CaseJump = def_sIndex()
for j, k in pairs(LevelUnitArr) do
	NIf(FP,{CV(SelUID,k[2])})
	CMov(FP,SelPer,k[3])
	CJumpX(FP,CaseJump)
	NIfEnd()
end
CJumpXEnd(FP, CaseJump)

CIfX(FP,{CV(SelUID,LevelUnitArr[#LevelUnitArr][2])})--�ְ������ϰ��
CS__InputVA(FP,iTbl1,0,TStr2,TStr2s,nil,0,TStr2s)
CElseX()--�׿�
CS__ItoCustom(FP,SVA1(TStr1,5),SelPer,nil,nil,{10,6},1,nil,"\x080",0x08,{0,1,2,4,5,6})


CIfX(FP,{
	CSVA1(SVA1(TStr1,5+5), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,5+6), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,5+7), Exactly, string.byte("0")*0x1000000, 0xFF000000),
},{
	SetCSVA1(SVA1(TStr1,5+4),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+5),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+6),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+7),SetTo,0x0D*0x1000000,0xFF000000),
})
CElseIfX({
	CSVA1(SVA1(TStr1,5+6), Exactly, string.byte("0")*0x1000000, 0xFF000000),
	CSVA1(SVA1(TStr1,5+7), Exactly, string.byte("0")*0x1000000, 0xFF000000),
},{
	SetCSVA1(SVA1(TStr1,5+6),SetTo,0x0D*0x1000000,0xFF000000),
	SetCSVA1(SVA1(TStr1,5+7),SetTo,0x0D*0x1000000,0xFF000000),
})
CElseIfX({
	CSVA1(SVA1(TStr1,5+7), Exactly, string.byte("0")*0x1000000, 0xFF000000),
},{
	SetCSVA1(SVA1(TStr1,5+7),SetTo,0x0D*0x1000000,0xFF000000),
})
CIfXEnd()



CS__InputVA(FP,iTbl1,0,TStr1,TStr1s,nil,0,TStr1s)
CIfXEnd()

CIfEnd()

function TEST() 
	local PlayerID = CAPrintPlayerID 
	local LVData = {{{0,9},{"��",{0x1000000}}}} 
	local StatEffT = CreateCcode()
	local InterfaceNumLoc2 = CreateCcode()
	DoActionsX(FP,AddCD(StatEffT,1))
	CA__SetValue(Str1,"\x07�����ݾ� \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123 \x04��\x12\x07�����\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
	--43
	--49
	CS__ItoCustom(FP,SVA1(Str1,42),IncomeLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
	CS__ItoCustom(FP,SVA1(Str1,48),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x190",0x19,{0,1})
	CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x04,0x04,0x04}
	,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x07�̣֣�\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04��\x0F�ţأ�\x04��",nil,1)
	
	CS__ItoCustom(FP,SVA1(Str1,4),LevelLoc,nil,nil,{10,5},1,nil,"\x1B0",0x1B,nil, LVData)
	CIfX(FP,{KeyPress("TAB", "Down")})--��ġǥ��
	CA__ItoCustom(SVA1(Str1,16),ExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
	CA__Input(MakeiStrData("\x08��",1),SVA1(Str1,28))
	CA__ItoCustom(SVA1(Str1,30),TotalExpLoc,nil,nil,10,nil,nil,"\x040",{0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
	CElseX()--�ۼ�Ʈǥ��
	local CurExpTmp = CreateVar(FP)
	CIfX(FP,{CV(LevelLoc,9999,AtMost)})
	f_Mul(FP,CurExpTmp,ExpLoc,20)
	f_Div(FP,CurExpTmp,TotalExpLoc)
	CElseX({SetV(CurExpTmp,20)})
	CIfXEnd()
	CA__SetValue(Str1,"\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x17 (TAB - ���ΰ�)",nil,16)
	function CS__InputTA(Player,Condition,SVA1,Value,Mask,Flag)
		if Flag == nil then Flag = {preserved} elseif Flag == 1 then Flag = {} end
		TriggerX(Player,Condition,{SetCSVA1(SVA1,SetTo,Value,Mask)},Flag)
	end
	for i = 0, 19 do
		CS__InputTA(FP,{CV(CurExpTmp,i+1,AtLeast)},SVA1(Str1,16+i),0x07,0xFF)
	end
	CIfXEnd()
	TriggerX(FP,{CD(StatEffLoc,1),CD(StatEffT,2,AtLeast)},{SetCD(StatEffT,0),SetCSVA1(SVA1(Str1,0),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,1),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,2),SetTo,0x04,0xFF)},{preserved})
	CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x12ũ���� \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123",nil,1)
	CA__lItoCustom(SVA1(Str1,8),CredLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x05,0x05,0x05}
	,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 

	CIfX(FP,{CV(InterfaceNumLoc,1)},{SetCD(InterfaceNumLoc2,0)}) -- ���� ������ ����
	
	CA__SetValue(Str1,"\x07�ɷ�ġ \x04����. \x10����Ű\x04�� ���� \x07���׷��̵�. \x08������:ESC\x12\x1C���� ����Ʈ :\x07 ",nil,1)
	CA__ItoCustom(SVA1(Str1,41),StatPLoc,nil,nil,{10,5},nil,nil,"\x040")
	CA__InputVA(56*3,Str1,Str1s,nil,56*3,56*4-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x071. \x07����� \x1F�ִ�����\x04+1 \x08(�ִ� 48) - \x1F5 Point\x12\x04 \x0D\x0D\x0D\x0D\x0D / \x1948",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,34),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
	CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x072. \x1B���� ������ \x08(�ִ� +200%) - \x1F5 Point\x12\x07+ \x0D\x0D\x0D\x0D\x0D %",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,34),UpgradeLoc,nil,nil,{10,3},1,nil,"\x080",0x08)
	CA__InputVA(56*5,Str1,Str1s,nil,56*5,56*6-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x073. \x07�� \x08��ȭȮ�� \x0F0.1%p \x08MAX 100 \x04- \x1F5 Point\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,37),TotalEPerLoc,nil,nil,{10,5},1,nil,"\x0F0",0x0F,{0,1,3,4,5},nil,{})
	CS__InputTA(FP,CV(TotalEPerLoc,999,AtMost),SVA1(Str1,37+1),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,nil,SVA1(Str1,37+2),string.byte(".")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPerLoc,99,AtMost),SVA1(Str1,37+3),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPerLoc,9,AtMost),SVA1(Str1,37+4),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPerLoc,0,AtMost),SVA1(Str1,37+5),string.byte("0")*0x1000000, 0xFF000000)
	CA__InputVA(56*6,Str1,Str1s,nil,56*6,56*7-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x074. \x07+2 \x08��ȭȮ�� \x070.1%p \x04 - \x1F20 Point\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,32),TotalEPer2Loc,nil,nil,{10,5},1,nil,"\x0F0",0x0F,{0,1,3,4,5},nil,{})
	CS__InputTA(FP,CV(TotalEPer2Loc,999,AtMost),SVA1(Str1,32+1),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,nil,SVA1(Str1,32+2),string.byte(".")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPer2Loc,99,AtMost),SVA1(Str1,32+3),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPer2Loc,9,AtMost),SVA1(Str1,32+4),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPer2Loc,0,AtMost),SVA1(Str1,32+5),string.byte("0")*0x1000000, 0xFF000000)
	CA__InputVA(56*7,Str1,Str1s,nil,56*7,56*8-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x075. \x10+3 \x08��ȭȮ�� \x070.1%p \x04 - \x1F100 Point\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,33),TotalEPer3Loc,nil,nil,{10,5},1,nil,"\x0F0",0x0F,{0,1,3,4,5},nil,{})
	CS__InputTA(FP,CV(TotalEPer3Loc,999,AtMost),SVA1(Str1,33+1),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,nil,SVA1(Str1,33+2),string.byte(".")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPer3Loc,99,AtMost),SVA1(Str1,33+3),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPer3Loc,9,AtMost),SVA1(Str1,33+4),string.byte("0")*0x1000000, 0xFF000000)
    CS__InputTA(FP,CV(TotalEPer3Loc,0,AtMost),SVA1(Str1,33+5),string.byte("0")*0x1000000, 0xFF000000)
	CA__InputVA(56*8,Str1,Str1s,nil,56*8,56*9-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	--CA__SetValue(Str1,"\x076. \x1C����ġ ȹ�淮 \x0710% \x04 - \x1F5 Point\x12\x07+ \x1C\x0D\x0D\x0D\x0D\x0D\x0D\x0D0 %",nil,1)
	--CS__ItoCustom(FP,SVA1(Str1,29),EXPIncomeLoc,nil,nil,{10,5},1,nil,"\x0D",0x1C)
	--CA__InputVA(56*9,Str1,Str1s,nil,56*9,56*10-2)

	
	for i = 3, 11 do
		CA__SetMemoryX((56*i)-1,0x0A0D0D0D,0xFFFFFFFF,1)
	end

	CElseX()--ǥ���� ���� �������� ������
	CIf(FP,{CD(InterfaceNumLoc2,0)},{SetCD(InterfaceNumLoc2,1)})
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__InputVA(56*3,Str1,Str1s,nil,56*3,56*4-2)
	CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-2)	
	CA__InputVA(56*5,Str1,Str1s,nil,56*5,56*6-2)	
	CA__InputVA(56*6,Str1,Str1s,nil,56*6,56*7-2)	
	CA__InputVA(56*7,Str1,Str1s,nil,56*7,56*8-2)	
	CA__InputVA(56*8,Str1,Str1s,nil,56*8,56*9-2)	
	CA__InputVA(56*9,Str1,Str1s,nil,56*9,56*10-2)	
	CA__InputVA(56*10,Str1,Str1s,nil,56*10,56*11-2)	
	for i = 3, 11 do
		CA__SetMemoryX((56*i)-1,0x0D0D0D0D,0xFFFFFFFF,1)
	end
	CIfEnd()



	CIfXEnd()




	
	end 
	CAPrint(iStr1,{Force1},{1,0,0,0,1,3,0,0},"TEST",FP,{}) 

	
--	function TEST() 
--		local PlayerID = CAPrintPlayerID 
--		CA__SetValue(Str2,"����� �� ��ȭȮ�� : ",nil,1)
--		
--	end
--	CIf_KeyFunc("P")--P�� ���� ��� ���� �������� ���� �� ǥ��
--	CAPrint(iStr2,{Force1},{1,0,0,0,1,0,0,0},"TEST2",FP,{}) 
--	CIfEnd()

	TriggerX(FP, {CD(TBLFlag,0)}, {CreateUnit(1,94,64,FP),RemoveUnit(94,FP)}, {preserved})--tbl��ð��ſ�. CreateUnitStacked ���� �ߵ�����
	DoActionsX(FP, {SetCD(TBLFlag,0)})
	TriggerX(FP, ElapsedTime(AtLeast,180*1.5), {RemoveUnit(88,AllPlayers)}) -- 3�е� ������� �⺻����

	if TestStart == 1 then -- ������ �ܼ� �ϴܺ����������(�氥��)
		L = CreateVar()
		CIfOnce(FP)
		GetPlayerLength(FP,P1,L)
		CIfEnd()
		N = CreateVar()
		local CU = CreateCcodeArr(40)
		local CUCool = CreateCcodeArr(40)
		SLoopN(FP,11,Always(),{SetNVar(N,Add,218)},{SetNVar(N,SetTo,0x640B63-218),TSetNVar(N,Add,L)})
		for i = 1, 40 do
			f_bytecmp(FP,{CU[i]},N,_byteConvert(GetStrArr(0,"@"..i.."��")),GetStrSize(0,"@"..i.."��"))
		end

		SLoopNEnd()
		CUCoolT = {}
		for i = 1, 40 do
			CreateUnitStacked({CDeaths(FP,AtLeast,1,CU[i]),CDeaths(FP,AtMost,0,CUCool[i])}, 1, LevelUnitArr[i][2], 36, nil, P1, {SetCDeaths(FP,SetTo,0,CU[i]),SetCDeaths(FP,SetTo,24*30,CUCool[i])})
			CUCoolT[i] = SubCD(CUCool[i],1)
		end
		DoActions2X(FP,CUCoolT)

	end
	
end