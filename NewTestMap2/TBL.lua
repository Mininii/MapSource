function TBL()
	local Stat_EXPIncome = iv.Stat_EXPIncome--CreateVarArr(7,FP)-- ����ġ ȹ�淮 ��ġ. ��� ����
	local PBossLV = iv.PBossLV -- ���κ�������
	local PBossDPS = iv.PBossDPS-- ���κ���DPS
	local TotalPBossDPS = iv.TotalPBossDPS --���κ���DPS ��ǥġ
	local MulOp = iv.MulOp--CreateVarArr2(7,1,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
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
	local PlayTimeLoc = iv.PlayTimeLoc--CreateVar(FP)
	local PlayTimeLoc2 = iv.PlayTimeLoc2--CreateVar(FP)
	local StatPLoc = iv.StatPLoc--CreateVar(FP)
	local MoneyLoc = iv.MoneyLoc--CreateWar(FP)
	local MoneyLoc2 = iv.MoneyLoc2--CreateWar(FP)
	local CredLoc = iv.CredLoc--CreateWar(FP)
	local ExpLoc = iv.ExpLoc--CreateVar(FP)
	local TotalExpLoc = iv.TotalExpLoc--CreateVar(FP)
	local InterfaceNumLoc = iv.InterfaceNumLoc--CreateVar(FP)DKW
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
	local TotalEPer = iv.TotalEPer-- CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	local TotalEPer2 = iv.TotalEPer2-- CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	local TotalEPer3 = iv.TotalEPer3-- CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)
	local TotalEPer4 = iv.TotalEPer4-- CreateVarArr(7,FP)--�� ��ȭȮ��(Ư��)

	local PUnitLevelLoc = iv.PUnitLevelLoc
	local PUnitClassLoc = iv.PUnitClassLoc

	local iStrinit = def_sIndex()
	CJump(FP, iStrinit)
	t00 = "\x07\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
	t01 = "\x07����Ȯ�� \x04: \x0D\x0D000.000\x08%\x0D\x0D"
	t01_1 = "\x08Ư��Ȯ�� \x04: \x08\x0D\x0D000.000\x08%\x0D\x0D"
	t01_2 = "\x03����Ȯ�� \x04: \x08\x0D\x0D000.000\x08%\x0D\x0D"
	t01_3 = "\x05����Ȯ�� \x04: \x0D\x0D000.000\x08%\x0D\x0D"
	t02 = "\x08!!! \x1F�� �� �� �� \x08!!!"
	t03 = "\x04��ȭ �Ұ� ����"
	t04 = "\x19EXP\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04 : \x0D0,000,000,000,000,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
	t10 = "\x19EXP\x17(�Ǹű� �ʿ�)\x04 : \x0D0,000,000,000,000,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
	t10_1 = "\x07�̱� \x17(�Ǹű� 1���� �ʿ�)\x04 Ȯ��ǥ : \x19Y\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
	t10_2 = "\x07�̱� \x17(�Ǹű� 10���� �ʿ�)\x04 Ȯ��ǥ : \x19Y\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
	t10_3 = "\x07�̱� \x17(�Ǹű� 100���� �ʿ�)\x04 Ȯ��ǥ : \x19Y\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
	t05 = "\x08�Ǹ� �Ұ� ����"
	t06 = "\x11���� DPM : \x0D0000\x04��0000\x04��0000\x04��0000\x04��0000"
	t06_1 = "\x1D���� Ÿ�ݼ� : \x0D0000\x04��0000\x04��0000\x04��0000\x04��0000"
	t06_2 = "\x17���� ũ���� : \x0D0000\x04��0000\x04��0000\x04��0000\x04��0000"
	t09 = "\x08���� DPS : \x0D0000\x04��0000\x04��0000\x04��0000\x04��0000"
	t07 = "\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I"
	t08 = "\x04�����ϱ� \x07������� \x04: \x0D0000\x04��0000\x04��0000�� \x04|| \x1F�ϰ�"
	t08_1 = "\x04�����ϱ� \x07������� \x04: \x0D0000\x04��0000\x04��0000�� \x04|| \x1F�ְ�"
	t11 = "\x04(SCA �ε��� 3�е� �����)"
	t13 = "\x0F��ȭȮ��, \x08����\x04�� \x07����\x0FȮ�� \x04: \x1C\x0D\x0D000 %"
	t14 = "\x08\x0D\x0D\x0D\x0D��. ��ȭ��� \x04: \x0D000,000,000 \x17ũ����"
	iStrSize1 = GetiStrSize(0,t01)
	S0 = MakeiTblString(1495,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- ����Ű����
	iTbl1 = GetiTblId(FP,1495,S0)
	TStr0, TStr0a, TStr0s = SaveiStrArr(FP,t00)
	TStr1, TStr1a, TStr1s = SaveiStrArr(FP,t01)
	TStr2, TStr2a, TStr2s = SaveiStrArr(FP,t02)
	TStr3, TStr3a, TStr3s = SaveiStrArr(FP,t03)
	TStr4, TStr4a, TStr4s = SaveiStrArr(FP,t06)
	TStr5, TStr5a, TStr5s = SaveiStrArr(FP,t08)
	TStr6, TStr6a, TStr6s = SaveiStrArr(FP,t13)
	TStr7, TStr7a, TStr7s = SaveiStrArr(FP,t14)
	
	S1 = MakeiTblString(764,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- ����Ű����
	iTbl2 = GetiTblId(FP,764,S1)
	S2 = MakeiTblString(16,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t08)+5),"Base",1) -- ����Ű����
	iTbl3 = GetiTblId(FP,16,S1)
	EStr0, EStr0a, EStr0s = SaveiStrArr(FP,t04)
	EStr1, EStr1a, EStr1s = SaveiStrArr(FP,t05)
	EStr2, EStr2a, EStr2s = SaveiStrArr(FP,t07)
	EStr3, EStr3a, EStr3s = SaveiStrArr(FP,t11)
	SelEPD,SelPer,SelUID,SelMaxHP,SelPl,SelI,CurEPD = CreateVars(7,FP)
	SelEXP = CreateWar(FP)
	BossFlag = CreateCcode()
	BossFlag2 = CreateCcode()
	SellTicketFlag = CreateCcode()
	XEperFlag = CreateCcode()
	PUnitFlag = CreateCcode()
	
	local TotalBossDPMLoc = CreateWar(FP)
	CJumpEnd(FP, iStrinit)
	
	
	
	
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1)}) -- Ŭ�������ν�(����)
	CMov(FP,SelPl,0)
	f_Read(FP,0x6284B8,nil,SelEPD)
	f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
	CMov(FP,SelUID,_ReadF(_Add(SelEPD,25)),nil,0xFF,1)
	
	CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{SetCD(PUnitFlag,0),SetCD(XEperFlag,0),SetCD(BossFlag,0),SetCD(BossFlag2,0)}) -- ���ּ��ý� 1ȸ�� ����
	
	CMov(FP,CurEPD,SelEPD)
	CMov(FP,0x6509B0,LCP)
	CDoActions(FP,{TSetMemoryB(0x58F32C, (7*15)+13, SetTo, UpgradeUILoc)})
	
	
	NIfX(FP,{Never()})
	for j, k in pairs(LevelUnitArr) do
		NElseIfX({CV(SelUID,k[2])},{
			SetV(SelPer,k[3]);SetCD(SellTicketFlag,0),
		})
		TriggerX(FP, {CV(SelPl,7)}, {DisplayExtText(StrDesignX("\x17P8 \x08��ȭ ����\x04�� ���� ������ \x0F�ڱ��ڽ�\x04�� \x07�ɷ�ġ\x04�� ���� ǥ��˴ϴ�."), 4)},{preserved})
		f_LMov(FP, SelEXP, tostring(k[4])  ,nil,nil, 1)
		if j>=26 then
			TriggerX(FP,{CV(SelUID,k[2])},{SetCD(SellTicketFlag,1)},{preserved})
		end
		if j>=40 and j<=43 then
			TriggerX(FP,{CV(SelUID,k[2])},{SetCD(XEperFlag,1)},{preserved})
		end
		if j>=44 and j<=47 then
			TriggerX(FP,{CV(SelUID,k[2])},{SetCD(XEperFlag,2+(j-44))},{preserved})
		end
		if j==48 then
			TriggerX(FP,{CV(SelUID,k[2])},{SetCD(XEperFlag,6)},{preserved})
		end
		if j==49 then
			TriggerX(FP,{CV(SelUID,k[2])},{SetCD(XEperFlag,7)},{preserved})
		end
		if j==50 then
			TriggerX(FP,{CV(SelUID,k[2])},{SetCD(XEperFlag,8)},{preserved})
		end
		
	end
	for j, k in pairs(BossArr) do
		NElseIfX({CV(SelUID,k[1])},{SetCD(BossFlag,1);SetCD(BossFlag2,0);
		SetV(SelPer,0);})
		
		f_LMov(FP, SelEXP, "0"  ,nil,nil, 1)
	end
	for j, k in pairs(PBossArr) do
		NElseIfX({CV(SelUID,k[1])},{SetCD(BossFlag,1);SetCD(BossFlag2,1);
		SetV(SelPer,0);})
		
		f_LMov(FP, SelEXP, "0"  ,nil,nil, 1)
	end
	
	for j, k in pairs(PersonalUIDArr) do
		NElseIfX({CV(SelUID,k)},{SetCD(PUnitFlag,1);SetV(SelPer,0);})
		f_LMov(FP, SelEXP, "0"  ,nil,nil, 1)
	end
	NElseX({
		SetV(SelPer,0);
	})
	
		f_LMov(FP, SelEXP, "0"  ,nil,nil, 1)
	NIfXEnd()
	
	CIfX(FP,{Never()})
	for i = 0, 6 do
		CElseIfX({CV(SelPl,i)},{})
		CMov(FP,TotalEPerLoc,TotalEPer[i+1])
		CMov(FP,TotalEPer2Loc,TotalEPer2[i+1])
		CMov(FP,TotalEPer3Loc,TotalEPer3[i+1])
		CMov(FP,EXPIncomeLoc,Stat_EXPIncome[i+1])
		CMov(FP,PUnitLevelLoc,iv.PUnitLevel[i+1])
		CMov(FP,PUnitClassLoc,iv.PUnitClass[i+1])
		CMov(FP,TotalEPer4Loc,TotalEPer4[i+1])--Ư��Ȯ�� �ջ�
		CMov(FP,iv.XEPer44Loc,iv.XEPer44[i+1])
		CMov(FP,iv.XEPer45Loc,iv.XEPer45[i+1])
		CMov(FP,iv.XEPer46Loc,iv.XEPer46[i+1])
		CMov(FP,iv.XEPer47Loc,iv.XEPer47[i+1])
		CMov(FP,iv.XEPer48Loc,iv.XEPer48[i+1])


	end
	CElseX()
	CTrigger(FP,{
		CV(SelUID,215),
	},{TSetMemory(0x6509B0, SetTo, LCP),DisplayExtText("\n\n\n\n\n\n\n"..
	StrDesignX("\x17����").."\n"..
	StrDesignX("\x04������ ������ ������, �︪���� ��Ű ���� ���̿� ��ġ�� ������ ������ ������").."\n"..
	StrDesignX("\x04�� 91���� ũ�� ���� ����� �̷���� �ִ� ���ѹα��� ���̴�. ").."\n"..
	StrDesignX("\x04�︪������ ���� 200�� ���� ������ �ִ�.").."\n"..
	StrDesignX("\x07- \x1F��ó \x04: ��Ű��� \x07-"), 4),SetMemory(0x6509B0, SetTo, FP),},{preserved})
	CIfXEnd()
	TriggerX(FP, {CV(SelPl,7),CD(XEperFlag,2,AtLeast),CD(XEperFlag,6,AtMost)}, {DisplayExtText(StrDesignX("\x08���� \x04: \x03����Ȯ�� \x04������ ��ȭ Ȯ���� �ΰ��� 1�ð� : 0.1% ������ ������ �����մϴ�."), 4)},{preserved})
	TriggerX(FP, {CV(SelUID,217)}, {DisplayExtText(StrDesignX("\x08���� \x04: ���� ���Ǳ�� ���� 1�� ��ȯ�ø��� \x08���� Ƽ�� 1��\x04�� \x08�Ҹ�\x04�˴ϴ�."), 4)})
	
	
	
	CIfX(FP,{TTNWar(SelEXP,AtMost,"0")})--����ġ�� ������� Ȥ�� �Ǹ� �Ұ� ������ ���


		CIfX(FP,{CV(SelUID,88)}) -- ��ī��
		CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
		CS__InputVA(FP,iTbl2,0,EStr3,EStr3s,nil,0,EStr3s)

		
		CElseIfX({CD(PUnitFlag,1)})--���������ϰ��
		CElseIfX({CD(XEperFlag,3,AtLeast),CD(XEperFlag,6,AtMost)})--����ġ�� �ƴ� �ٸ��� �ٰ��
		CS__SetValue(FP,EStr0,t10_1,nil,0)
		CS__InputVA(FP,iTbl2,0,EStr0,EStr0s,nil,0,EStr0s)

		CElseIfX({CD(XEperFlag,7)})--����ġ�� �ƴ� �ٸ��� �ٰ��
		CS__SetValue(FP,EStr0,t10_2,nil,0)
		CS__InputVA(FP,iTbl2,0,EStr0,EStr0s,nil,0,EStr0s)
		CElseIfX({CD(XEperFlag,8)})--����ġ�� �ƴ� �ٸ��� �ٰ��
		CS__SetValue(FP,EStr0,t10_3,nil,0)
		CS__InputVA(FP,iTbl2,0,EStr0,EStr0s,nil,0,EStr0s)
		CElseX()
		
		
		CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
		CS__InputVA(FP,iTbl2,0,EStr1,EStr1s,nil,0,EStr1s)
		CIfXEnd()
	CElseX()--����ġ�� �������
		CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
		CIfX(FP,{CD(SellTicketFlag,0)})
		CS__SetValue(FP,EStr0,t04,nil,0)
		CElseX()
		CS__SetValue(FP,EStr0,t10,nil,0)
		CIfXEnd()
		f_LMul(FP, SelEXP, SelEXP, {_Add(EXPIncomeLoc,10),0})
		CS__lItoCustom(FP,SVA1(EStr0,14),SelEXP,nil,nil,{10,20},1,nil,"\x080",0x1B,{0,2,3,4,6,7,8,10,11,12,14,15,16,18,19,20,22,23,24,26},nil,{{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0})
	
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
		CElseIfX({CD(BossFlag,1)})--�����ǹ��ϰ��
		--���� DPS ������ ǥ��� ����
	CIfXEnd()
	
	CIfX(FP,{CV(SelUID,LevelUnitArr[#LevelUnitArr][2])})--�ְ������ϰ��
		CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
		CS__InputVA(FP,iTbl1,0,TStr2,TStr2s,nil,0,TStr2s)

	
	CElseIfX({CD(PUnitFlag,1)})--���������� ���


	CElseIfX({CD(XEperFlag,0),CV(SelPer,0)})--��ȭ������ �ƴ� ���
		CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
		CS__InputVA(FP,iTbl1,0,TStr3,TStr3s,nil,0,TStr3s)
	CElseIfX({CD(BossFlag,1)})--�����ǹ��ϰ��
		--���� DPS �䱸ġ ǥ��� ����
	CElseX()--�׿�
	MFlag = CreateCcode()
		CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
		CIfX(FP, {CD(XEperFlag,1)}) -- Ư��Ȯ���� ���
			CS__SetValue(FP,TStr1,t01_1,nil,0)
			CS__SetValue(FP,TStr1,"-",nil,7)
		CElseIfX({CD(XEperFlag,7)},{SetCD(MFlag,0)})--����Ȯ��
			CS__SetValue(FP,TStr1,t01_3,nil,0)

		CElseIfX({CD(XEperFlag,2,AtLeast),CD(XEperFlag,6,AtMost)},{SetCD(MFlag,0)})--����Ȯ��
			CiSub(FP,SelPer,iv.XEPerM)
			CS__SetValue(FP,TStr1,t01_2,nil,0)
			CIf(FP,CV(SelPer,0x80000000,AtLeast),{SetCD(MFlag,1)})
				CNeg(FP, SelPer)--���̳ʽ� ��ġ ����
				CS__SetValue(FP,TStr1,"-",nil,7)--���̳ʽ� ǥ�� �߰�
			CIfEnd()
		CElseX()
			CS__SetValue(FP,TStr1,t01,nil,0)
		CIfXEnd()

		CS__ItoCustom(FP,SVA1(TStr1,7+1),SelPer,nil,nil,{10,6},1,nil,"\x080",0x08,{0,1,2,4,5,6})
	--8 9 10
	--12 13 14
	CS__InputTA(FP,{CSVA1(SVA1(TStr1,10+1), Exactly, 0x0D*0x1000000, 0xFF000000)},SVA1(Str1,10),string.byte("0")*0x1000000, 0xFF000000)
	local TempV =CreateVar(FP)
	local TempV2 =CreateVar(FP)
	CMod(FP,TempV,SelPer,1000)
	CDiv(FP,TempV2,SelPer,1000)

	TriggerX(FP, {
		CSVA1(SVA1(TStr1,12+1), Exactly, string.byte("0")*0x1000000, 0xFF000000),
		CSVA1(SVA1(TStr1,13+1), Exactly, string.byte("0")*0x1000000, 0xFF000000),
		CSVA1(SVA1(TStr1,14+1), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,11+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr1,12+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr1,13+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr1,14+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(TStr1,13+1), Exactly, string.byte("0")*0x1000000, 0xFF000000),
		CSVA1(SVA1(TStr1,14+1), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,13+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr1,14+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(TStr1,14+1), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,14+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	
	CIf(FP,{CV(TempV2,0)})
	CS__SetValue(FP,TStr1,"\x08\x0D",nil,8)
	CS__SetValue(FP,TStr1,"\x08\x0D",nil,9)
	CS__SetValue(FP,TStr1,"\x08\x0D",nil,10)
	CS__SetValue(FP,TStr1,"\x080",nil,11)
	
	CIfEnd()
	CIf(FP,{CV(TempV,0)})
	CS__SetValue(FP,TStr1,"\x08\x0D",nil,12)
	CS__SetValue(FP,TStr1,"\x08\x0D",nil,13)
	CS__SetValue(FP,TStr1,"\x08\x0D",nil,14)
	CS__SetValue(FP,TStr1,"\x08\x0D",nil,15)
	CIfEnd()

	CIf(FP,{CV(TempV2,0),CV(TempV,1,AtLeast)})
	TriggerX(FP, {
		CSVA1(SVA1(TStr1,13), Exactly, string.byte("\x0D")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,13), SetTo, string.byte("0")*0x1000000,0xFF000000),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(TStr1,14), Exactly, string.byte("\x0D")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,14), SetTo, string.byte("0")*0x1000000,0xFF000000),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(TStr1,15), Exactly, string.byte("\x0D")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,15), SetTo, string.byte("0")*0x1000000,0xFF000000),
	}, {preserved})

	TriggerX(FP, {
		CSVA1(SVA1(TStr1,13+1), Exactly, string.byte("0")*0x1000000, 0xFF000000),
		CSVA1(SVA1(TStr1,14+1), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,13+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr1,14+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(TStr1,14+1), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(TStr1,14+1), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	
	CIfEnd()
	


	
		CS__InputVA(FP,iTbl1,0,TStr1,TStr1s,nil,0,TStr1s)
	CIfXEnd()
	CIf(FP,{CD(BossFlag,0)})
	local TotalEPer5Loc = CreateVar(FP)
	CIfX(FP, CD(XEperFlag,0))
	CAdd(FP,TotalEPer3Loc,_Div(SelPer,_Mov(100)))
	CAdd(FP,TotalEPer2Loc,_Div(SelPer,_Mov(10)))
	CAdd(FP,TotalEPerLoc,SelPer) -- +1�� Ȯ��
	CElseIfX({CD(XEperFlag,1)})
	CAdd(FP,TotalEPer2Loc,TotalEPer3Loc)
	CAdd(FP,TotalEPerLoc,TotalEPer2Loc)
	CAdd(FP,TotalEPerLoc,TotalEPer4Loc)--Ư��Ȯ�� �ջ�
	CSub(FP,TotalEPerLoc,SelPer)
	CMov(FP,TotalEPer3Loc,0)
	CMov(FP,TotalEPer2Loc,0)
	CElseIfX({CD(XEperFlag,2,AtLeast)})
	CTrigger(FP, {CD(XEperFlag,2)},{SetV(TotalEPerLoc,iv.XEPer44Loc)},{preserved})
	CTrigger(FP, {CD(XEperFlag,3)},{SetV(TotalEPerLoc,iv.XEPer45Loc)},{preserved})
	CTrigger(FP, {CD(XEperFlag,4)},{SetV(TotalEPerLoc,iv.XEPer46Loc)},{preserved})
	CTrigger(FP, {CD(XEperFlag,5)},{SetV(TotalEPerLoc,iv.XEPer47Loc)},{preserved})
	CTrigger(FP, {CD(XEperFlag,6)},{SetV(TotalEPerLoc,iv.XEPer48Loc)},{preserved})
	CTrigger(FP, {CD(XEperFlag,7)},{SetV(TotalEPerLoc,0)},{preserved})
	CIfX(FP,CD(MFlag,0))
	CAdd(FP,TotalEPerLoc,SelPer)
	CElseX()
	CSub(FP,TotalEPerLoc,SelPer)
	CIfXEnd()
	CMov(FP,TotalEPer2Loc,0)
	CMov(FP,TotalEPer3Loc,0)
	CIfXEnd()
	
	--35~39 +3 ��ġ�� +2��
	
	for i = 35, 39 do
		CIf(FP,{CV(SelUID,LevelUnitArr[i][2])})
			CAdd(FP,TotalEPer2Loc,TotalEPer3Loc)
			CMov(FP,TotalEPer3Loc,0)
		CIfEnd()
	end
	
	--36~39 +2 ��ġ�� +1��
	
	
	for i = 36, 39 do
		CIf(FP,{CV(SelUID,LevelUnitArr[i][2])})
			CAdd(FP,TotalEPerLoc,TotalEPer2Loc)
			CMov(FP,TotalEPer2Loc,0)
		CIfEnd()
	end
	
	CSub(FP,TotalEPer5Loc,_Mov(100000),_Add(_Add(TotalEPerLoc,TotalEPer3Loc),TotalEPer2Loc))
	CIf(FP,{CV(TotalEPer5Loc,0)})
	CSub(FP,TotalEPerLoc,_Mov(100000),_Add(TotalEPer2Loc,TotalEPer3Loc))
	
	CIfEnd()




	CMov(FP,GEVar,TotalEPer3Loc)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,18+5+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,18+5+4+i),SetTo,EVarArr1[i+4])})
	end
	CMov(FP,GEVar,TotalEPer2Loc)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,35+5+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,35+5+4+i),SetTo,EVarArr1[i+4])})
	end
	CMov(FP,GEVar,TotalEPerLoc)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,52+5+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,52+5+4+i),SetTo,EVarArr1[i+4])})
	end
	CMov(FP,GEVar,TotalEPer5Loc)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,72+5+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,72+5+4+i),SetTo,EVarArr1[i+4])})
	end

	
	CIfEnd()
	CIfEnd()
	
	CIfX(FP, {CD(BossFlag,1)}) -- �����ǹ� ���� ��ð���
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
	CIfX(FP,{CV(SelUID,102)})
	CS__SetValue(FP,TStr4,t06_2,nil,0)
	local TempW = CreateWar(FP)
	f_LMov(FP,TempW,_LSub(TotalBossDPMLoc,TotalDPMLoc))
	f_LMov(FP,TotalDPMLoc,TempW)
	CElseX()
	CS__SetValue(FP,TStr4,t09,nil,0)
	CIfXEnd()


	CElseX()
	f_LMov(FP,TotalDPMLoc,TotalDPM)
	f_LMov(FP,TotalBossDPMLoc,BossDPM)
	CIfX(FP,{TTOR({CV(SelUID,77),CV(SelUID,104)})})
	CS__SetValue(FP,TStr4,t06_1,nil,0)


	CElseX()
	CS__SetValue(FP,TStr4,t06,nil,0)
	CIfXEnd()
	CIfXEnd()
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)--DPS ��ġ
	
	CS__lItoCustom(FP,SVA1(TStr4,9),TotalDPMLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1C,0x1C,0x1C,0x1C,0x03,0x03,0x03,0x03},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0}})
	CS__InputVA(FP,iTbl1,0,TStr4,TStr4s,nil,0,TStr4s)
	
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)--DPS ������
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
	CElseIfX({CD(PUnitFlag,1)})-- �������� ���� ��ð���

	for j, k in pairs(PersonalUIDArr) do
		CIf(FP,{CV(SelUID,k)})
		CMov(FP,PUnitLevelLoc,iv.PUnitLevel[j])
		CMov(FP,PUnitClassLoc,iv.PUnitClass[j])
		CS__lItoCustom(FP,SVA1(MarStr[j],2),PUnitClassLoc,nil,nil,{10,4},1,nil,"\x03��",0x07)
		CS__InputVA(FP,PMariTbl[j],0,MarStr[j],MarStrs[j],nil,0,MarStrs[j])
		CIfEnd()
	end
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
	local TempPer = CreateVar(FP)
	CMov(FP,TempPer,_Sub(_Mov(100),_Mul(PUnitLevelLoc,10)))
	TriggerX(FP,{CV(PUnitLevelLoc,10)},{SetV(TempPer,0)},{preserved})
-- CS__ItoCustom(FP,SVA1(Str1,8),StatPLoc,nil,nil,{10,6},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6}, nil,{0,0,{0},0,0,{0}})
	CS__ItoCustom(FP,SVA1(TStr6,17),TempPer,nil,nil,{10,3},1,nil,"\x0F0",0x0F)--��ȭȮ��
	CS__InputVA(FP,iTbl2,0,TStr6,TStr6s,nil,0,TStr6s)



	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	local TempCred = CreateVar(FP)
	CMov(FP,TempCred,_Add(_Mul(PUnitLevelLoc,1000),1000))
	TriggerX(FP,{CV(PUnitLevelLoc,10)},{SetV(TempCred,0)},{preserved})
	CS__ItoCustom(FP,SVA1(TStr7,0),PUnitLevelLoc,nil,nil,{10,2},1,nil,"\x080",0x08)--��ȭ�ܰ�
	CS__ItoCustom(FP,SVA1(TStr7,14),TempCred,nil,nil,{10,9},1,nil,"\x170",0x17,{0,1,2,4,5,6,8,9,10}, nil,{0,0,{0},0,0,{0},0,0,{0}})
	CS__InputVA(FP,iTbl1,0,TStr7,TStr7s,nil,0,TStr7s)--����

	CIfXEnd()
	
	CIf(FP,{CV(SelUID,15)}) -- �ù� ���� ��ð���
	CIfX(FP,{Never()})
	for i = 0, 6 do
		CElseIfX({CV(SelPl,i)},{})
		f_LMov(FP,MulOpLoc,MulOp[i+1])
		CMov(FP,iv.FROpLoc,VArr(FirstRewardOpVArr, i))
	end
	CElseX()
	f_LMov(FP,MulOpLoc,0)
	CIfXEnd()
	CIfX(FP,{CV(iv.FROpLoc,0)})
	CS__SetValue(FP,TStr5,t08,nil,0)
	CElseX()
	CS__SetValue(FP,TStr5,t08_1,nil,0)
	CIfXEnd()

	
	CS__lItoCustom(FP,SVA1(TStr5,12),MulOpLoc,nil,nil,{10,12},nil,nil,"\x040",nil,{0,1,2,3,5,6,7,8,10,11,12,13},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0}})
	CTrigger(FP, {TTNWar(MulOpLoc,AtLeast,"10000")
	}, {
		SetCSVA1(SVA1(TStr5,18+5), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr5,19+5), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr5,20+5), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr5,21+5), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	CTrigger(FP, {TTNWar(MulOpLoc,AtLeast,"100000000")
	}, {
		SetCSVA1(SVA1(TStr5,18), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr5,19), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr5,20), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr5,21), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
		SetCSVA1(SVA1(TStr5,22), SetTo, 0x0D0D0D0D,0xFFFFFFFF),
	}, {preserved})
	CS__InputVA(FP,iTbl3,0,TStr5,TStr5s,nil,0,TStr5s)
	
	CIfEnd()
	
	
	
	CIfEnd()

	local temp,YKey = ToggleFunc({KeyPress("Y","Up"),KeyPress("Y","Down")},nil,1)--���� ��� ���� �������� ���� �� ǥ��

	CIf(FP,{CD(YKey,1)})
	CMov(FP,0x6509B0,LCP)
	function GaTxt(Ga_Arr)
		local Txt = ""
		for j,k in pairs(Ga_Arr) do
			if type(k[2]) == "string" then 
				Txt = Txt..StrDesignX(k[1].." "..Convert_Number(k[2]).."\x07�� \x04�� - \x07"..(k[3]/1000).." %").."\n"
			else
				Txt = Txt..StrDesignX(k[1].." "..Convert_Number(k[2]).." \x04�� - \x07"..(k[3]/1000).." %").."\n"
			end
		end
		return Txt
	end
	
	CIf(FP,{CD(XEperFlag,3)},{DisplayExtText(StrDesignX("\x1C45�� \x04���� \x17�̱� \x07Ȯ��ǥ \x04(\x02���� ���� \x04"..pifrag[1].."�� �⺻����)").."\n"..GaTxt(Ga_45), 4)})
	CIfEnd()
	CIf(FP,{CD(XEperFlag,4)},{DisplayExtText(StrDesignX("\x1E46�� \x04���� \x17�̱� \x07Ȯ��ǥ \x04(\x02���� ���� \x04"..pifrag[2].."�� �⺻����)").."\n"..GaTxt(Ga_46), 4)})
	CIfEnd()
	CIf(FP,{CD(XEperFlag,5)},{DisplayExtText(StrDesignX("\x0247�� \x04���� \x17�̱� \x07Ȯ��ǥ \x04(\x02���� ���� \x04"..pifrag[3].."�� �⺻����)").."\n"..GaTxt(Ga_47), 4)})
	CIfEnd()
	CIf(FP,{CD(XEperFlag,6)},{DisplayExtText(StrDesignX("\x1B48�� \x04���� \x17�̱� \x07Ȯ��ǥ \x04(\x02���� ���� \x04"..pifrag[4].."�� �⺻����)").."\n"..GaTxt(Ga_48), 4)})
	CIfEnd()
	CIf(FP,{CD(XEperFlag,7)},{DisplayExtText(StrDesignX("\x0649�� \x04���� \x17�̱� \x07Ȯ��ǥ \x04(\x02���� ���� \x04"..pifrag[5].."�� �⺻����)").."\n"..GaTxt(Ga_49), 4)})
	CIfEnd()
	CIf(FP,{CD(XEperFlag,8)},{DisplayExtText(StrDesignX("\x0750�� \x04���� \x17�̱� \x07Ȯ��ǥ \x04(\x02���� ���� \x04"..pifrag[6].."�� �⺻����)").."\n"..GaTxt(Ga_50), 4)})
	CIfEnd()

	--[[
		
	]]

	
	CMov(FP,0x6509B0,FP)
	CIfEnd()
	--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
	--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
	--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
	--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+7))
	--CA__ItoCustom(SVA1(Str1,0),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1E,0x1E,0x1E,0x1E,0x04,0x04,0x04,0x04},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0})
	
	
		CIf(FP,{CD(TBLFlag,0)})--tbl��ð��ſ�. CreateUnitStacked ���� �ߵ�����
			f_Read(FP, 0x628438, nil, Nextptrs)
			DoActions(FP, CreateUnit(1,94,136,FP))
			CSub(FP,CurCunitI,Nextptrs,19025)
			f_Div(FP,CurCunitI,_Mov(84))
			CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Xor(CT_GNextRandV,94))})
			CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
			CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,2,SetTo,_Xor(CT_GNextRandV,FP))})
			--CallTrigger(FP, Call_CTInputUID)
			DoActions(FP, RemoveUnit(94,FP))
		CIfEnd()
		DoActionsX(FP,{SetCD(TBLFlag,0)})
		TriggerX(FP,{ElapsedTime(AtLeast, 90)},{RotatePlayer({DisplayExtText(StrDesignX("\x18Notice \x04: \x04���� �ڽ��� \x1F�̳׶�\x04, \x07����\x04�� �ǹ����� ���ϴ� \x08������\x17(DPS) \x04�Դϴ�."))},Force1,FP)})
		TriggerX(FP,{ElapsedTime(AtLeast, 150)},{RotatePlayer({DisplayExtText(StrDesignX("\x18Notice \x04: \x07�ڽ�\x04�� \x11����\x04�� �ִ� \x1Cũ����Ż\x04���� \x07������ ����\x04�ϰ� \x0F����� ��ī���� \x04������ ������ ������ \x08��ȭ\x04�� �˴ϴ�."))},Force1,FP)})
		TriggerX(FP,{ElapsedTime(AtLeast, 180*(1.2))},{RotatePlayer({DisplayExtText(StrDesignX("\x18Notice \x04: �� �� ó�� �־��� ��ī���� \x08����� ��\x04�Դϴ�. \x07������ ����, \x08��ȭ\x04�Ͽ� \x17�����\x04�� �����ô�!"))},Force1,FP)})
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
		
	--if TestStart == 0 and Limit == 1 then
	--	Trigger2X(FP, {Memory(0x6D0F38,AtLeast,GlobalTime);},  {
	--		RotatePlayer({
	--			DisplayExtText(StrDesignX("\x1B�׽�Ʈ �Ⱓ�� ����Ǿ����ϴ�. �̿����ּż� ����� �����մϴ�.").."\n"..StrDesignX("\x1B").."\n"..StrDesignX("\x1B���� ���Ĺ��� ������Ʈ���� �˰ڽ��ϴ�."),4);
	--		Defeat();
	--		},Force1,FP);
	--		Defeat();
	--		SetMemory(0xCDDDCDDC,SetTo,1)
	--		
	--	})
	--end
	
end