function Interface()

	--PlayData(NonSCA)
	local Money = CreateWarArr(7,FP) -- �ڽ��� ���� �� ������
	local IncomeMax = CreateVarArr2(7,12,FP) -- �ڽ��� ����� �ִ� ���ּ�
	local Income = CreateVarArr(7,FP) -- �ڽ��� ���� ����Ϳ� �������� ���ּ�
	local BuildMul1 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	local BuildMul2 = CreateVarArr2(7,1,FP)-- �ǹ� �� ȹ�淫 ���
	local TotalEPer = CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	local TotalEPer2 = CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	local TotalEPer3 = CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	local ScoutDmg = CreateVarArr(7,FP) -- �⺻���� ������
	local ScTimer = CreateCcodeArr(7)

	--General
	local BossLV = CreateVar(FP)
	
	--Setting, Effect
	local StatEff = CreateCcodeArr(7) -- ������ ����Ʈ
	local StatEffT2 = CreateCcodeArr(7) -- ������ ����Ʈ
	local InterfaceNum = CreateVarArr(7,FP) -- �����̳� ���� ��� â �����
	local Stat_Upgrade_UI = CreateVarArr(7,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
	local AutoBuyCode = CreateCcodeArr(7)-- �ڵ� ���� ���� ������
	local PCheckV = CreateVar(FP)--�÷��̾� �� üũ
	
	--PlayData(SCA)
	local PLevel = CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	local StatP = CreateVarArr(7,FP)-- ���� �������� ��������Ʈ
	local Stat_ScDmg = CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_TotalEPer = CreateVarArr(7,FP)-- +1�� Ȯ�� ��ġ
	local Stat_TotalEPer2 = CreateVarArr(7,FP)-- +2�� Ȯ�� ��ġ
	local Stat_TotalEPer3 = CreateVarArr(7,FP)-- +3�� Ȯ�� ��ġ
	local Stat_Upgrade = CreateVarArr(7,FP)-- ���� ���ݷ� ������ ��ġ
	local Credit = CreateWarArr(7,FP) -- �������� ũ����
	local PEXP = CreateWarArr(7, FP) -- �ڽ��� ���ݱ��� ���� �� ����ġ
	local TotalExp = CreateWarArr2(7,"10",FP) -- ���ݱ��� �������� ����� ����ġ + ���� �������� �ʿ��� ����ġ
	local CurEXP = CreateWarArr(7,FP) -- ���ݱ��� �������� ����� ����ġ


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
	
	--PlayData(NotSureSCA)
	local Stat_EXPIncome = CreateVarArr(7,FP)-- ����ġ ȹ�淮 ��ġ. ��� ����
	local PEXP2 = CreateVarArr(7, FP) -- 1/10�� ���� ����ġ�� ���� �� �����. ��� ����





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
	local ScoutDmgLoc = CreateVar(FP)


	--Temp
	local TempReadV = CreateVar(FP)
	local TempEXPV = CreateVar(FP)
	local CTPEXP = CreateWar(FP)
	local CTPLevel = CreateVar(FP)
	local CTStatP = CreateVar(FP)
	local CTStatP2 = CreateVar(FP)
	local CTCurEXP = CreateWar(FP)
	local CTTotalExp = CreateWar(FP)
	local CheatDetect = CreateCcode()
	--local GEXP = CreateVar(FP)
	local STable = {"1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "2048", "4096", "8192", "16384", "32768", "65536", "131072", "262144", "524288", "1048576", "2097152", "4194304", "8388608", "16777216", "33554432", "67108864", "134217728", "268435456", "536870912", "1073741824", "2147483648", "4294967296", "8589934592", "17179869184", "34359738368", "68719476736", "137438953472", "274877906944", "549755813888", "1099511627776", "2199023255552", "4398046511104", "8796093022208", "17592186044416", "35184372088832", "70368744177664", "140737488355328", "281474976710656", "562949953421312", "1125899906842624", "2251799813685248", "4503599627370496", "9007199254740992", "18014398509481984", "36028797018963968", "72057594037927936", "144115188075855872", "288230376151711744", "576460752303423488", "1152921504606846976", "2305843009213693952", "4611686018427387904", "9223372036854775807"}

	
	local Dx,Dy,Dv,Du,DtP,Time = CreateVariables(6,FP)
	
	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CV(DtP,2500,AtMost)},{AddV(Time,DtP)},1)--��ó�� �ð��� Ʀ ����

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
	DoActions(FP, SetMemory(0x58F500, SetTo, 0))
	local LoadCheck = CreateCcodeArr(7)
for i = 0, 6 do -- ���÷��̾� 
	CIf(FP,{HumanCheck(i,1)},{SetCp(i),AddCD(ScTimer[i+1],1)})
	
	TriggerX(FP,{LocalPlayerID(i),CV(Time,60000,AtLeast),CD(LoadCheck[i+1],1)},{SubV(Time,60000),SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: \x07�����ð� \x031��\x04���� \x1C�ڵ����� \x04�˴ϴ�. \x07������..."), 4)},{preserved})

	CIfOnce(FP,{Deaths(i, Exactly, 2, 23)},{SetCD(LoadCheck[i+1],1),SetCD(CheatDetect,0)})--�ε� �Ϸ�� ù ���� Ʈ����
		CIf(FP, {Deaths(i,AtLeast,1,101)})--���������Ͱ� ������� �ε��� ��� �����, ������ ����� �����ϰ� �ε����
		TriggerX(FP, {Deaths(i,AtLeast,1,98),LocalPlayerID(i)}, { -- ����� ������ ���
			SetCp(i),
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
			DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
			SetMemory(0xCDDDCDDC,SetTo,1);})
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

		f_LMov(FP, CTPEXP, PEXP[i+1])
		CMov(FP, CTPLevel, 1)
		CMov(FP,CTStatP,0)
		CMov(FP,CTStatP2,StatP[i+1])
		f_LMov(FP, CTCurEXP, 0,nil,nil,1)
		f_LMov(FP, CTTotalExp, "10",nil,nil,1)
		local CheatTestJump = def_sIndex()
		CJumpEnd(FP, CheatTestJump)
		NIf(FP,{TTNWar(CTPEXP,AtLeast,CTTotalExp),CV(CTPLevel,9999,AtMost)},{AddV(CTPLevel,1)}) -- ����ġ ġ�� �˻�
	
		f_Read(FP,FArr(EXPArr,_Sub(CTPLevel,1)),TempReadV,nil,nil,1)
		f_LAdd(FP, CTTotalExp, CTTotalExp, {TempReadV,0})
		f_Read(FP,FArr(EXPArr,_Sub(CTPLevel,2)),TempReadV,nil,nil,1)
		f_LAdd(FP, CTCurEXP, CTCurEXP, {TempReadV,0})
		CAdd(FP,CTStatP,5)
		CJump(FP, CheatTestJump)
		NIfEnd()
		CAdd(FP,CTStatP2,Stat_ScDmg[i+1])
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(5)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(20)))
		CAdd(FP,CTStatP2,Stat_TotalEPer3[i+1])
		CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(5)))
		CMov(FP,0x57f0f0+(i*4),CTStatP)--ġ�ð����� �������� ǥ��� �̳׶�
		CMov(FP,0x57f120+(i*4),CTStatP2)--ġ�ð����� �������� ǥ��� ����
		CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNVar(CTPLevel,NotSame,PLevel[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNWar(CTCurEXP,NotSame,CurEXP[i+1])}, {SetCD(CheatDetect,1)})
		CTrigger(FP, {TTNWar(CTTotalExp,NotSame,TotalExp[i+1])}, {SetCD(CheatDetect,1)})
		TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
			SetCp(i),
			PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayText("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �����Ǿ� ����.)\x07 ��",4);
			DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
			SetMemory(0xCDDDCDDC,SetTo,1);})
		
		CMov(FP,0x57f0f0+(i*4),0)--ġ�ð����� �������� ǥ��� �̳׶� �ʱ�ȭ
		CMov(FP,0x57f120+(i*4),0)--ġ�ð����� �������� ǥ��� ���� �ʱ�ȭ
		CIf(FP,CD(Stat_ScDmg[i+1],1,AtLeast))--��ī ���ݷ� ������ ������ ���翩��
		DoActionsX(FP, {SetCD(ScTimer[i+1],0)})--�ε强���� ��īŸ�̸� �ʱ�ȭ
		CreateUnitStacked({Command(i,AtMost,0,88)},1, 88, 36+i,15+i, i, nil, 1)--��ī ��������� �ٽ� ����
		CIfEnd()
		
		CIfEnd()
	CIfEnd()
	NIf(FP,{Deaths(i, Exactly, 1,13),Deaths(i, Exactly, 0,14)}) -- �����ư�� �����ų� �ڵ����� �ý��ۿ� ���� �ش� Ʈ���ſ� �������� ���
		DoActions(FP,SetDeaths(i, SetTo, 1, 14))--����
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
	NIfEnd()

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
	CallTriggerX(FP,Call_Print13[i+1])
	TriggerX(FP, {CV(PLevel[i+1],9,AtMost),LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x1F������ �ö����ϴ�! \x17O Ű\x04�� ���� \x07�ɷ�ġ\x04�� �������ּ���."))}, {preserved})
	CJump(FP, LevelUpJump)
	NIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})


	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--�⺻��������
	if Limit == 1 then 
		CreateUnitStacked({Deaths(i,AtLeast,1,100),Deaths(i,AtLeast,1,503)}, 12, LevelUnitArr[40][2], 36+i, 15+i, i)
	end
	
	TriggerX(FP, {Command(i,AtLeast,1,88),CD(ScTimer[i+1],4320)}, {RemoveUnit(88,AllPlayers)},{preserved}) -- 3�е� ������� �⺻����

	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	for NBit = 2,7 do
		TriggerX(FP,{Accumulate(i, AtLeast, 10^NBit, Ore)},{SetV(BuildMul1[i+1],2^(NBit-1)),SetCp(i),DisplayText(StrDesignX("�ǹ��� \x1BDPS\x1F(�̳׶�)\x04�� \x08"..10^NBit.." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..(2^(NBit-1)).."��\x04�� �����Ͽ����ϴ�.")),SetCp(FP)})--1���ǹ�
		TriggerX(FP,{Accumulate(i, AtLeast, 10^NBit, Gas)},{SetV(BuildMul2[i+1],2^(NBit-1)),SetCp(i),DisplayText(StrDesignX("�ǹ��� \x1BDPS\x07(����)\x04�� \x08"..10^NBit.." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..(2^(NBit-1)).."��\x04�� �����Ͽ����ϴ�.")),SetCp(FP)})--2���ǹ�
	end
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[15][2])},{SetCp(i),DisplayText(StrDesignX("\x0815�� \x04������ ȹ���Ͽ����ϴ�. \x0815�� \x04���ֺ��ʹ� \x17�Ǹ�\x04�� ���� \x1B����ġ\x04�� ȹ���� �� �ֽ��ϴ�.")),SetCp(FP)})
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[26][2])},{SetCp(i),DisplayText(StrDesignX("\x0F26�� \x04������ ȹ���Ͽ����ϴ�. \x0F15�� \x04���ֺ��ʹ� \x08����\x04�� ������ �� �ֽ��ϴ�.")),DisplayText(StrDesignX("\x08���� \x1C���� \x07���ѽð�\x04�� �����ϴ�.")),SetCp(FP)})

	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{Ore},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas},Money[i+1])
	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)




	CTrigger(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65+i)},{MoveUnit(1, "Men", i, 15+i, 22+i),},1)
	DoActions(FP,{
		MoveUnit(1, "Men", i, 29+i, 36+i),
		MoveUnit(1, "Factories", i, 22+i, 57+i),
	})
	TriggerX(FP, {Bring(i, AtMost, 0, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--������ ����
	TriggerX(FP, {}, {MoveUnit(1, "Factories", i, 111, 36+i)}, {preserved})--������ ����



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
		{{CV(StatP[i+1],1,AtLeast),CV(Stat_ScDmg[i+1],49,AtMost)},{SubV(StatP[i+1],1),AddV(Stat_ScDmg[i+1],1)},StrDesign("\x07�⺻����\x1B�� �������� �����Ͽ����ϴ�.")},
		{{CV(Stat_ScDmg[i+1],50,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x07�⺻���� \x08������\x04�� �ø� �� �����ϴ�.")},
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
			{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],49,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
			{{CV(Stat_Upgrade[i+1],50,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x08������\x04�� �ø� �� �����ϴ�.")},
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
	CMov(FP,IncomeMax[i+1],12,nil,nil,1)
	--CMov(FP,IncomeMax[i+1],Stat_ScDmg[i+1],12,nil,1)
	CMov(FP,ScoutDmg[i+1],Stat_ScDmg[i+1],nil,nil,1)
	CMov(FP,TotalEPer[i+1],Stat_TotalEPer[i+1],nil,nil,1)
	CMov(FP,TotalEPer2[i+1],Stat_TotalEPer2[i+1],nil,nil,1)
	CMov(FP,TotalEPer3[i+1],Stat_TotalEPer3[i+1],nil,nil,1)
	CIf(FP,{CV(BossLV,1,AtLeast)}) -- ������ Ŭ�����
		CAdd(FP,IncomeMax[i+1],12) -- ����� ���ּ� +12 ����
		CAdd(FP,TotalEPer[i+1],1500) -- ��ȭȮ�� +1.5%p
	CIfEnd()

	CIf(FP,{CV(BossLV,2,AtLeast)}) -- ������ Ŭ�����
		CAdd(FP,IncomeMax[i+1],8) -- ����� ���ּ� +8 ����
		CAdd(FP,TotalEPer[i+1],2500) -- ��ȭȮ�� +2.5%p
	CIfEnd()

	CIf(FP,{CV(BossLV,3,AtLeast)}) -- ������ Ŭ�����
		CAdd(FP,IncomeMax[i+1],8) -- ����� ���ּ� +8 ����
		CAdd(FP,TotalEPer[i+1],3500) -- ��ȭȮ�� +3.5%p
		CAdd(FP,Stat_EXPIncome[i+1],3) -- �ǸŽ� ����ġ 30% ����
	CIfEnd()

	DoActionsX(FP,{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 0),SetMemoryB(0x58F32C+(i*15)+12, SetTo, 0),SetV(Stat_Upgrade_UI[i+1],0)})
	for CBit = 0, 7 do
		TriggerX(FP,{NVar(Stat_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit),AddV(Stat_Upgrade_UI[i+1],(2^CBit)*10)},{preserved})
	end
	for CBit = 0, 7 do
		TriggerX(FP,{NVar(Stat_ScDmg[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+12, Add, 2^CBit)},{preserved})
	end
	if Limit == 1 then--�������ڿ� ġƮ
		CIf(FP,{Deaths(i,AtLeast,1,100)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)})
		CMov(FP,IncomeMax[i+1],48,nil,nil,1)
		CIfEnd()
	end

	TriggerX(FP,{NVar(PCheckV,AtLeast,2)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 10),AddV(TotalEPer[i+1],500)},{preserved})
	TriggerX(FP,{NVar(PCheckV,AtLeast,4)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 10),AddV(TotalEPer[i+1],500)},{preserved})
	TriggerX(FP,{NVar(PCheckV,AtLeast,7)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 20),AddV(TotalEPer[i+1],1000)},{preserved})
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
				
				--CallTriggerX(FP,Call_Print13[i+1],{Bring(i,AtLeast,1,UID,73+i)})
				TriggerX(FP,{Bring(i,AtLeast,1,UID,73+i)},{MoveUnit(1,UID,i,73+i,80+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: �ش� ������ �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
			end

			
		end
		TriggerX(FP,{Bring(i,AtLeast,1,88,73+i)},{MoveUnit(1,88,i,73+i,80+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: �ش� ������ �Ǹ��� �� �����ϴ�..."), 4),SetCp(FP)},{preserved})
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
	CMov(FP,ScoutDmgLoc,ScoutDmg[i+1])
	
	CIfEnd()
	



	CIfEnd()
end

local BossEPD = CreateVar(FP)
local BossDPM = CreateWar(FP)
local CurBossDPM = CreateWar(FP)

local DPS = CreateVarArr(24, FP)
local DPSArr2 = CreateFArr(1440, FP)
local DPSArr = CreateVArr(96, FP)
local VArrI = CreateVar(FP)
local VArrI4 = CreateVar(FP)
local TotalBossDPS = CreateVar(FP)
local TotalBossDPS2 = CreateVar(FP)
local DPSCheckV = CreateVar(FP)
local DpsDest = CreateVar(FP)
local DPSCheck = CreateCcode()
local DPSCheck2 = CreateVar(FP)
local TotalDPSW = CreateWar(FP)
local TotalDPSW2 = CreateWar(FP)
CIf(FP,CV(BossEPD,19025,AtLeast),AddCD(DPSCheck,1))
TriggerX(FP,{CV(DPSCheck2,1440,AtLeast)},{SetV(DPSCheck2,0)},{preserved})
CIfX(FP,{TMemory(BossEPD,AtMost,8319999*256)})
f_Read(FP, BossEPD, DPSCheckV)
CMov(FP,DpsDest,_Sub(_Mov(8320000*256),DPSCheckV))
CTrigger(FP,{},{TSetMemory(BossEPD,SetTo,8320000*256)},1)
CrShift(FP, DpsDest, 8)
CElseX()
CMov(FP,DpsDest,0)
CIfXEnd()



ConvertVArr(FP,VArrI,VArrI4,DPSCheck2,96)
f_LAdd()
f_LAdd(FP,TotalDPSW,TotalDPSW,{DpsDest,0})
f_LSub(FP,TotalDPSW,TotalDPSW,{_Read(FArr(DPSArr2,DPSCheck2)),0})
CMov(FP,FArr(DPSArr2,DPSCheck2),DpsDest,nil,nil,1)
--CMov(FP,TotalDPS,0)
--for j = 1, 24 do
--	CTrigger(FP, {CD(DPSCheck,j)},{TSetNVar(DPS[j], SetTo, DpsDest)},1)
--	CAdd(FP,TotalDPS,DPS[j])
--end

DoActionsX(FP,{AddV(DPSCheck2,1)})
CTrigger(FP, {TMemoryX(_Add(BossEPD,17), Exactly, 0, 0xFF00)}, {SetV(BossEPD,0)},1)
CIfEnd()



for j,k in pairs(BossArr) do
	CIfOnce(FP,{Memory(0x628438,AtLeast,1),CV(BossEPD,0),CV(BossLV,j-1)})--������ �ǹ� ����
	f_Read(FP, 0x628438, nil, BossEPD)
	DoActionsX(FP, {CreateUnit(1,k[1],110,FP),AddV(BossEPD,2)})
	f_LMov(FP,BossDPM,k[2])
	CIfEnd()
	local ClearJump = def_sIndex()
	NJump(FP,ClearJump,{CV(BossLV,j,AtLeast)})
	CIf(FP,{TTNWar(TotalDPSW, AtLeast, BossDPM)})
	DoActions(FP,{KillUnit(k[1],FP),AddV(BossLV,1)})
	CIfEnd()
	NJumpEnd(FP,ClearJump)
end

local iStrinit = def_sIndex()
CJump(FP, iStrinit)
t00 = "\x07\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
t01 = "\x07����Ȯ�� \x04: \x0D000.000\x08%\x0D\x0D"
t02 = "\x08!!! \x1F�� �� �� �� \x08!!!"
t03 = "\x04��ȭ �Ұ� ����"

iStrSize1 = GetiStrSize(0,t01)
S0 = MakeiTblString(1495,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- ����Ű����
iTbl1 = GetiTblId(FP,1495,S0)
TStr0, TStr0a, TStr0s = SaveiStrArr(FP,t00)
TStr1, TStr1a, TStr1s = SaveiStrArr(FP,t01)
TStr2, TStr2a, TStr2s = SaveiStrArr(FP,t02)
TStr3, TStr3a, TStr3s = SaveiStrArr(FP,t03)

t04 = "\x19�ǸŽ� ����ġ : \x0d0,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t05 = "\x08�Ǹ� �Ұ� ����"
S1 = MakeiTblString(764,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- ����Ű����
iTbl2 = GetiTblId(FP,764,S1)
EStr0, EStr0a, EStr0s = SaveiStrArr(FP,t04)
EStr1, EStr1a, EStr1s = SaveiStrArr(FP,t05)


SelEPD,SelPer,SelUID,SelMaxHP,SelPl,SelI,CurEPD,SelEXP = CreateVars(8,FP)
CJumpEnd(FP, iStrinit)




CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- Ŭ�������ν�(����)
CMov(FP,SelPl,0)
f_Read(FP,0x6284B8,nil,SelEPD)
f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
CMov(FP,SelUID,_Read(_Add(SelEPD,25)),nil,0xFF,1)

CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{}) -- ���ּ��ý� 1ȸ�� ����

CMov(FP,CurEPD,SelEPD)

CIfX(FP,{Never()})
for i = 0, 6 do
	CElseIfX({CV(SelPl,i)})
	CMov(FP,TotalEPerLoc,TotalEPer[i+1])
	CMov(FP,TotalEPer2Loc,TotalEPer2[i+1])
	CMov(FP,TotalEPer3Loc,TotalEPer3[i+1])
	CMov(FP,EXPIncomeLoc,Stat_EXPIncome[i+1])
end
CElseX()
CMov(FP,TotalEPerLoc,0)
CMov(FP,TotalEPer2Loc,0)
CMov(FP,TotalEPer3Loc,0)
CMov(FP,EXPIncomeLoc,0)
CIfXEnd()

NIfX(FP,{Never()})
	for j, k in pairs(LevelUnitArr) do
		NElseIfX({CV(SelUID,k[2])})
		CMov(FP,SelPer,k[3])
		CMov(FP,SelEXP,k[4])
	end
NElseX()
	CMov(FP,SelPer,0)
	CMov(FP,SelEXP,0)
NIfXEnd()

CIfX(FP,{CV(SelEXP,1,AtLeast)})--����ġ�� �������
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__SetValue(FP,EStr0,t04,nil,0)
	f_Mul(FP,SelEXP,_Add(EXPIncomeLoc,10))
	CS__ItoCustom(FP,SVA1(EStr0,10),SelEXP,nil,nil,{10,8},1,nil,"\x080",0x1B,{0,2,3,4,6,7,8,10},nil,{{0},0,0,{0},0,0,{0},0})
	
	TriggerX(FP, {
		CSVA1(SVA1(EStr0,19), Exactly, 0x0D*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,19), SetTo, string.byte("0")*0x1000000,0xFF000000),
	}, {preserved})
	CS__InputVA(FP,iTbl2,0,EStr0,EStr0s,nil,0,EStr0s)
CElseX()--����ġ�� �������
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl2,0,EStr1,EStr1s,nil,0,EStr1s)
CIfXEnd()

CIfX(FP,{CV(SelUID,LevelUnitArr[#LevelUnitArr][2])})--�ְ������ϰ��
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl1,0,TStr2,TStr2s,nil,0,TStr2s)
CElseIfX({CV(SelPer,0)})--��ȭ������ �ƴ� ���
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl1,0,TStr3,TStr3s,nil,0,TStr3s)
CElseX()--�׿�
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




local TotalEPer4Loc = CreateVar(FP)
CAdd(FP,TotalEPerLoc,SelPer) -- +1�� Ȯ��
CAdd(FP,TotalEPer2Loc,_Div(SelPer,10))
CAdd(FP,TotalEPer3Loc,_Div(SelPer,100))
CSub(FP,TotalEPer4Loc,_Mov(100000),_Add(_Add(TotalEPerLoc,TotalEPer3Loc),TotalEPer2Loc))


function Byte_NumSet(Var,DestVar,DivNum,Mask)
	CMov(FP,DestVar,0)
	for i = 3, 0, -1 do
		TriggerX(FP,{NVar(Var,AtLeast,(2^i)*DivNum)},{SetNVar(Var,Subtract,(2^i)*DivNum),SetNVar(DestVar, SetTo, (2^i)*Mask,(2^i)*Mask)},{preserved})
	end
end
local E1VarArr = CreateVarArr(6, FP)
local E2VarArr = CreateVarArr(6, FP)
local E3VarArr = CreateVarArr(6, FP)
local E4VarArr = CreateVarArr(6, FP)
for i = 1, 6 do
	Byte_NumSet(TotalEPerLoc,E3VarArr[i],10^(6-i),1)
	Byte_NumSet(TotalEPer2Loc,E2VarArr[i],10^(6-i),1)
	Byte_NumSet(TotalEPer3Loc,E1VarArr[i],10^(6-i),1)
	Byte_NumSet(TotalEPer4Loc,E4VarArr[i],10^(6-i),1)
end




for i = 0, 2 do
	CDoActions(FP,{TBwrite(_Add(Etbl,18+5+i),SetTo,_Add(E1VarArr[i+1],0x30))})
	CDoActions(FP,{TBwrite(_Add(Etbl,18+5+4+i),SetTo,_Add(E1VarArr[i+4],0x30))})
	CDoActions(FP,{TBwrite(_Add(Etbl,35+5+i),SetTo,_Add(E2VarArr[i+1],0x30))})
	CDoActions(FP,{TBwrite(_Add(Etbl,35+5+4+i),SetTo,_Add(E2VarArr[i+4],0x30))})
	CDoActions(FP,{TBwrite(_Add(Etbl,52+5+i),SetTo,_Add(E3VarArr[i+1],0x30))})
	CDoActions(FP,{TBwrite(_Add(Etbl,52+5+4+i),SetTo,_Add(E3VarArr[i+4],0x30))})
	
	CDoActions(FP,{TBwrite(_Add(Etbl,72+5+i),SetTo,_Add(E4VarArr[i+1],0x30))})
	CDoActions(FP,{TBwrite(_Add(Etbl,72+5+4+i),SetTo,_Add(E4VarArr[i+4],0x30))})
end

CTrigger(FP,{CV(E1VarArr[1],0)},{TBwrite(_Add(Etbl,18+5+0),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E1VarArr[1],0),CV(E1VarArr[2],0)},{TBwrite(_Add(Etbl,18+5+1),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E1VarArr[6],0)},{TBwrite(_Add(Etbl,18+5+4+2),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E1VarArr[6],0),CV(E1VarArr[5],0)},{TBwrite(_Add(Etbl,18+5+4+1),SetTo,0x0D)},{preserved})


CTrigger(FP,{CV(E2VarArr[1],0)},{TBwrite(_Add(Etbl,35+5+0),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E2VarArr[1],0),CV(E2VarArr[2],0)},{TBwrite(_Add(Etbl,35+5+1),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E2VarArr[6],0)},{TBwrite(_Add(Etbl,35+5+4+2),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E2VarArr[6],0),CV(E2VarArr[5],0)},{TBwrite(_Add(Etbl,35+5+4+1),SetTo,0x0D)},{preserved})

CTrigger(FP,{CV(E3VarArr[1],0)},{TBwrite(_Add(Etbl,52+5+0),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E3VarArr[1],0),CV(E3VarArr[2],0)},{TBwrite(_Add(Etbl,52+5+1),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E3VarArr[6],0)},{TBwrite(_Add(Etbl,52+5+4+2),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E3VarArr[6],0),CV(E3VarArr[5],0)},{TBwrite(_Add(Etbl,52+5+4+1),SetTo,0x0D)},{preserved})


CTrigger(FP,{CV(E4VarArr[1],0)},{TBwrite(_Add(Etbl,72+5+0),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E4VarArr[1],0),CV(E4VarArr[2],0)},{TBwrite(_Add(Etbl,72+5+1),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E4VarArr[6],0)},{TBwrite(_Add(Etbl,72+5+4+2),SetTo,0x0D)},{preserved})
CTrigger(FP,{CV(E4VarArr[6],0),CV(E4VarArr[5],0)},{TBwrite(_Add(Etbl,72+5+4+1),SetTo,0x0D)},{preserved})




CIfEnd()
CIfEnd()
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+7))
--CA__ItoCustom(SVA1(Str1,0),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1E,0x1E,0x1E,0x1E,0x04,0x04,0x04,0x04},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0})


function TEST() 
	local PlayerID = CAPrintPlayerID 
	local LVData = {{{0,9},{"��",{0x1000000}}}} 
	local StatEffT = CreateCcode()
	local InterfaceNumLoc2 = CreateCcode()
	DoActionsX(FP,AddCD(StatEffT,1))
	
	CA__SetValue(Str1,"\x07�����ݾ� \x04:  0000\x04��0000\x04��0000\x04��0000\x04��0000 \x04��\x12\x07�����\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
	--43
	--49
	CS__ItoCustom(FP,SVA1(Str1,40),IncomeLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
	CS__ItoCustom(FP,SVA1(Str1,46),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x190",0x19,{0,1})
	CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1C,0x1C,0x1C,0x1C,0x03,0x03,0x03,0x03},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0}})

	--CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x04,0x04,0x04},{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
	CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x07�̣֣�\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04��\x0F�ţأ�\x04��",nil,1)
	
	CS__ItoCustom(FP,SVA1(Str1,4),LevelLoc,nil,nil,{10,5},1,nil,"\x1B0",0x1B,nil, LVData)
	local Tabkey = KeyToggleFunc("TAB")
	CIfX(FP,{CD(Tabkey,1)})--��ġǥ��
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
	CA__SetValue(Str1,"\x071. \x07�⺻���� \x08������ \x04+1000 \x08(�ִ� 5��) - \x1F1 Point\x12\x04 + \x0D\x0D\x0D\x0D\x0D\x0D000",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,40),ScoutDmgLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B)
	TriggerX(FP, {CV(ScoutDmgLoc,0)}, {
		SetCSVA1(SVA1(Str1,46), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
		SetCSVA1(SVA1(Str1,47), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
		SetCSVA1(SVA1(Str1,48), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
		SetCSVA1(SVA1(Str1,49), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
	}, {preserved})
	CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x072. \x1B���� ������ \x08(�ִ� +500%) - \x1F5 Point\x12\x07+ \x0D\x0D\x0D\x0D\x0D %",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,34),UpgradeLoc,nil,nil,{10,3},1,nil,"\x080",0x08)
	CA__InputVA(56*5,Str1,Str1s,nil,56*5,56*6-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	function PercentStrFix(SVA,Var,Distance)
	TriggerX(FP, {
		CSVA1(SVA1(SVA,Distance+0), Exactly, 0x0D*0x1000000, 0xFF000000),
		CSVA1(SVA1(SVA,Distance+1), Exactly, 0x0D*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(SVA,Distance+1), SetTo, string.byte("0")*0x1000000, 0xFF000000),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(SVA,Distance+3), Exactly, 0x0D*0x1000000, 0xFF000000),
		CSVA1(SVA1(SVA,Distance+4), Exactly, 0x0D*0x1000000, 0xFF000000),
		CSVA1(SVA1(SVA,Distance+5), Exactly, 0x0D*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(SVA,Distance+3), SetTo, string.byte("0")*0x1000000, 0xFF000000),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(SVA,Distance+4), Exactly, string.byte("0")*0x1000000, 0xFF000000),
		CSVA1(SVA1(SVA,Distance+5), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(SVA,Distance+4), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(SVA,Distance+5), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(SVA,Distance+5), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(SVA,Distance+5), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	end

	CA__SetValue(Str1,"\x073. \x07�� \x08��ȭȮ�� \x0F0.1%p \x08MAX 100 \x04- \x1F5 Point\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,38),TotalEPerLoc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str1,TotalEPerLoc,38)
	CA__InputVA(56*6,Str1,Str1s,nil,56*6,56*7-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x074. \x07+2 \x08��ȭȮ�� \x070.1%p \x04 - \x1F20 Point\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,33),TotalEPer2Loc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str1,TotalEPer2Loc,33)
	CA__InputVA(56*7,Str1,Str1s,nil,56*7,56*8-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x075. \x10+3 \x08��ȭȮ�� \x070.1%p \x04 - \x1F100 Point\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,34),TotalEPer3Loc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str1,TotalEPer3Loc,34)
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
--		CA__SetValue(Str2,"����� �� ��ȭȮ��",nil,1)
--		
--	end
--	CIf_KeyFunc("P")--P�� ���� ��� ���� �������� ���� �� ǥ��
--	CAPrint(iStr2,{Force1},{1,0,0,0,1,0,0,0},"TEST2",FP,{}) 
--	CIfEnd()

	TriggerX(FP, {CD(TBLFlag,0)}, {CreateUnit(1,94,64,FP),RemoveUnit(94,FP)}, {preserved})--tbl��ð��ſ�. CreateUnitStacked ���� �ߵ�����
	DoActionsX(FP, {SetCD(TBLFlag,0)})

--	if TestStart == 1 then -- ������ �ܼ� �ϴܺ����������(�氥��)
--		L = CreateVar()
--		CIfOnce(FP)
--		GetPlayerLength(FP,P1,L)
--		CIfEnd()
--		N = CreateVar()
--		local CU = CreateCcodeArr(40)
--		local CUCool = CreateCcodeArr(40)
--		SLoopN(FP,11,Always(),{SetNVar(N,Add,218)},{SetNVar(N,SetTo,0x640B63-218),TSetNVar(N,Add,L)})
--		for i = 1, 40 do
--			f_bytecmp(FP,{CU[i]},N,_byteConvert(GetStrArr(0,"@"..i.."��")),GetStrSize(0,"@"..i.."��"))
--		end--

--		SLoopNEnd()
--		CUCoolT = {}
--		for i = 1, 40 do
--			CreateUnitStacked({CDeaths(FP,AtLeast,1,CU[i]),CDeaths(FP,AtMost,0,CUCool[i])}, 1, LevelUnitArr[i][2], 36, nil, P1, {SetCDeaths(FP,SetTo,0,CU[i]),SetCDeaths(FP,SetTo,24*30,CUCool[i])})
--			CUCoolT[i] = SubCD(CUCool[i],1)
--		end
--		DoActions2X(FP,CUCoolT)--

--	end
	
end