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
	local MulOp = CreateVarArr2(7,1,FP) -- ���� ���ݷ¿� ���� ��ġ ǥ��� ����
	
	--PlayData(SCA)
	local PLevel = CreateVarArr2(7,1,FP)-- �ڽ��� ���� ����
	local StatP = CreateVarArr(7,FP)-- ���� �������� ��������Ʈ
	local Stat_ScDmg = CreateVarArr(7,FP)-- ����� ���� ��ġ
	local Stat_AddSc = CreateVarArr(7,FP)-- ����� ���� ��ġ
	
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
	local LevelLoc2 = CreateVar(FP)
	local TotalEPerLoc = CreateVar(FP)
	local TotalEPer2Loc = CreateVar(FP)
	local TotalEPer3Loc = CreateVar(FP)
	local S_TotalEPerLoc = CreateVar(FP)
	local S_TotalEPer2Loc = CreateVar(FP)
	local S_TotalEPer3Loc = CreateVar(FP)
	local StatPLoc = CreateVar(FP)
	local MoneyLoc = CreateWar(FP)
	local CredLoc = CreateWar(FP)
	local ExpLoc = CreateVar(FP)
	local TotalExpLoc = CreateVar(FP)
	local InterfaceNumLoc = CreateVar(FP)
	local UpgradeLoc = CreateVar(FP)
	local EXPIncomeLoc = CreateVar(FP)
	local EXPIncomeLoc2 = CreateVar(FP)
	local StatEffLoc = CreateCcode()
	local ScoutDmgLoc = CreateVar(FP)
	local AddScLoc = CreateVar(FP)
	local MulOpLoc = CreateVar(FP)

	--Temp
	local CTStatP2 = CreateVar(FP)

	local TempReadV = CreateVar(FP)
	local TempEXPV = CreateVar(FP)

	local CheatDetect = CreateCcode()
	--local GEXP = CreateVar(FP)
	local STable = {"1", "2", "4", "8", "16", "32", "64", "128", "256", "512", "1024", "2048", "4096", "8192", "16384", "32768", "65536", "131072", "262144", "524288", "1048576", "2097152", "4194304", "8388608", "16777216", "33554432", "67108864", "134217728", "268435456", "536870912", "1073741824", "2147483648", "4294967296", "8589934592", "17179869184", "34359738368", "68719476736", "137438953472", "274877906944", "549755813888", "1099511627776", "2199023255552", "4398046511104", "8796093022208", "17592186044416", "35184372088832", "70368744177664", "140737488355328", "281474976710656", "562949953421312", "1125899906842624", "2251799813685248", "4503599627370496", "9007199254740992", "18014398509481984", "36028797018963968", "72057594037927936", "144115188075855872", "288230376151711744", "576460752303423488", "1152921504606846976", "2305843009213693952", "4611686018427387904", "9223372036854775807"}

	
	local Dx,Dy,Dv,Du,DtP,Time2,Time = CreateVariables(7,FP)
	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CV(DtP,2500,AtMost)},{AddV(Time,DtP),AddV(Time2,DtP)},1)--��ó�� �ð��� Ʀ ����
	function AutoBuy(CP,LvUniit,Cost)--Cost==String
		CIf(FP,{Memory(0x628438,AtLeast,1),CD(AutoBuyCode[CP+1],LvUniit)})
			CIf(FP, {TTNWar(Money[CP+1],AtLeast,Cost)})
				f_LSub(FP, Money[CP+1], Money[CP+1], Cost)
				CreateUnitStacked({}, 1, LevelUnitArr[LvUniit][2], 43+CP,nil, CP)
			CIfEnd()
		CIfEnd()
	end
	CMov(FP,PCheckV,0)
	ULimitArr = {500,350,300,250,200,200,200}
	ULimitV = CreateVar(FP)
	ULimitV2 = CreateVar(FP)
	for i = 0, 6 do
		TriggerX(FP,{HumanCheck(i,1)},{AddV(PCheckV,1)},{preserved})
		TriggerX(FP,{HumanCheck(i,0)},{RemoveUnit("Men", P12),RemoveUnit("Factories", P12)})
	end
	for i = 1, 7 do
		TriggerX(FP,{CV(PCheckV,i)},{SetV(ULimitV,ULimitArr[i]),SetV(ULimitV2,ULimitArr[i]-1)},{preserved})
	end
	DoActions(FP, SetMemory(0x58F500, SetTo, 0))
	local LoadCheck = CreateCcodeArr(7)
	


for i = 0, 6 do -- ���÷��̾� 
	CIf(FP,{HumanCheck(i,1)},{SetCp(i),AddCD(ScTimer[i+1],1)})
	TriggerX(FP,{LocalPlayerID(i),Command(i,AtMost,0,"Men"),Command(i,AtMost,0,"Factories"),CV(Time2,60000,AtLeast),CD(LoadCheck[i+1],1)},{SetV(Time2,0),SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: ���� ������ ���� ��� \x07�����ð� \x031��\x04���� \x1C�ڵ����� \x04�˴ϴ�. \x07������..."), 4)},{preserved})
	CIf(FP,{CV(Time,60000,AtLeast)},{SubV(Time,60000)})
	TriggerX(FP,{LocalPlayerID(i),CD(LoadCheck[i+1],1)},{SetMemory(0x58F500, SetTo, 1),DisplayText(StrDesignX("\x03SYSTEM \x04: \x07�����ð� \x031��\x04���� \x1C�ڵ����� \x04�˴ϴ�. \x07������..."), 4)},{preserved})
if Limit == 1 then 
	TriggerX(FP,{LocalPlayerID(i)},{DisplayText(StrDesignX("\x04���� \x1F6~7�� ���ʽ� ���� \x1C�������Դϴ�. - \x08���ݷ� + 400%\x04, \x07+1�� \x17��ȭȮ�� + \x0F2.0%p"),4)},{preserved})-- �ο��� ���� ���ʽ�

else
	TriggerX(FP,{LocalPlayerID(i),NVar(PCheckV,AtLeast,2),NVar(PCheckV,AtMost,3)},{DisplayText(StrDesignX("\x04���� \x1F2~3�� ���ʽ� ���� \x1C�������Դϴ�. - \x08���ݷ� + 100%\x04, \x07+1�� \x17��ȭȮ�� + \x0F0.5%p"),4)},{preserved})-- �ο��� ���� ���ʽ�
	TriggerX(FP,{LocalPlayerID(i),NVar(PCheckV,AtLeast,4),NVar(PCheckV,AtMost,5)},{DisplayText(StrDesignX("\x04���� \x1F4~5�� ���ʽ� ���� \x1C�������Դϴ�. - \x08���ݷ� + 200%\x04, \x07+1�� \x17��ȭȮ�� + \x0F1.0%p"),4)},{preserved})-- �ο��� ���� ���ʽ�
	TriggerX(FP,{LocalPlayerID(i),NVar(PCheckV,AtLeast,6)},{DisplayText(StrDesignX("\x04���� \x1F6~7�� ���ʽ� ���� \x1C�������Դϴ�. - \x08���ݷ� + 400%\x04, \x07+1�� \x17��ȭȮ�� + \x0F2.0%p"),4)},{preserved})-- �ο��� ���� ���ʽ�

end
	CIfEnd()--
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
		SCA_DataLoad(i,Stat_AddSc[i+1],116)
		--ġ�� �׽�Ʈ ���� �ʱ�ȭ
		f_LMov(FP, CTPEXP, PEXP[i+1])
		CMov(FP, CTPLevel, 1)
		CMov(FP,CTStatP,0)
		CMov(FP,CTStatP2,StatP[i+1])
		f_LMov(FP, CTCurEXP, 0,nil,nil,1)
		f_LMov(FP, CTTotalExp, "10",nil,nil,1)

		CallTrigger(FP,Call_CT)

		CAdd(FP,CTStatP2,Stat_ScDmg[i+1])
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(5)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(200)))
		CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(1000)))
		CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(5)))
		CAdd(FP,CTStatP2,_Mul(Stat_AddSc[i+1],_Mov(10)))
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
		CIf(FP,CV(Stat_ScDmg[i+1],1,AtLeast))--��ī ���ݷ� ������ ������ ���翩��
		DoActionsX(FP, {SetCD(ScTimer[i+1],0),RemoveUnit(88, i)})--�ε强���� ��īŸ�̸� �ʱ�ȭ
		for k = 0, 5 do
			CreateUnitStacked({CV(Stat_AddSc[i+1],k)},k+1, 88, 36+i,15+i, i, nil, 1)--��ī ��������� �ٽ� ����
		end
		CreateUnitStacked({Deaths(i, AtLeast, 1, 99)},6, 88, 36+i,15+i, i, nil, 1)--�׽������� ���� Īȣ ������ ��ī 6�� �߰�����
		CreateUnitStacked({Deaths(i, AtLeast, 1, 100)},6, 88, 36+i,15+i, i, nil, 1)--������ Īȣ ������ ��ī 6�� �߰�����
		CIfEnd()
		
		CIfEnd()
	CIfEnd()
	
	if TestStart == 1 then
        mouseX = dwread_epd(0x6CDDC4)
        mouseY = dwread_epd(0x6CDDC8)
        screenGridX = dwread_epd(0x62848C)
        screenGridY = dwread_epd(0x6284A8)
        Simple_SetLocX(FP,117, 256*16, 256*16,256*16, 256*16) --�߾� (�ʻ�����*16, �ʻ�����*16)
        DoActions(FP,{SetCp(i),CenterView(118)})
        ScreenX2 = dwread_epd(0x62848C);
        ScreenY2 = dwread_epd(0x6284A8);
		screenSizeX = CreateVar(FP)
		screenSizeY = CreateVar(FP)
        CMov(FP,screenSizeX,_iSub(_Mov(256*16),ScreenX2))
        CMov(FP,screenSizeY,_iSub(_Mov(256*16),ScreenY2))
		screenX = CreateVar(FP)
		screenY = CreateVar(FP)
        CAdd(FP,screenX,screenGridX,screenSizeX)
        CAdd(FP,screenY,screenGridY,screenSizeY)
        Simple_SetLocX(FP,117, screenX, screenY,screenX, screenY)
        DoActions(FP,{SetCp(i),CenterView(118)})
        Simple_SetLocX(FP,117, 256*16, 256*16,256*16, 256*16) --�߾� (�ʻ�����*16, �ʻ�����*16)
		CMov(FP,screenX,_iSub(_Add(mouseX,320),screenSizeX))


		DisplayPrintEr(i, {"mouseX : ", mouseX, "  mouseY : ", mouseY, "  screenSizeX : ", screenSizeX, "  screenX : ", screenX, "  screenY : ", mouseY});
	end

	
	local LevelUpJump = def_sIndex()
	CJumpEnd(FP, LevelUpJump)
	NIf(FP,{TTNWar(PEXP[i+1],AtLeast,TotalExp[i+1]),CV(PLevel[i+1],9999,AtMost)},{AddV(PLevel[i+1],1),SetCD(StatEffT2[i+1],0),SetCD(StatEff[i+1],1)})

	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],1)),TempReadV,nil,nil,1)
	f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], {TempReadV,0})
	f_Read(FP,FArr(EXPArr,_Sub(PLevel[i+1],2)),TempReadV,nil,nil,1)
	f_LAdd(FP, CurEXP[i+1], CurEXP[i+1], {TempReadV,0})
	CAdd(FP,StatP[i+1],5)
	CallTriggerX(FP,Call_Print13[i+1],{CV(PLevel[i+1],9,AtMost)})
	TriggerX(FP, {CV(PLevel[i+1],9,AtMost),LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x1F������ �ö����ϴ�! \x17O Ű\x04�� ���� \x07�ɷ�ġ\x04�� �������ּ���."))}, {preserved})
	CJump(FP, LevelUpJump)
	NIfEnd()
	DoActionsX(FP, {AddCD(StatEffT2[i+1],1)})
	TriggerX(FP,{CD(StatEffT2[i+1],500,AtLeast)},{SetCD(StatEff[i+1],0)},{preserved})

	
	local CTSwitch = CreateCcode()
	NIf(FP,{Deaths(i, Exactly, 1,13),Deaths(i, Exactly, 0,14)},{SetCD(CTSwitch,1)}) -- �����ư�� �����ų� �ڵ����� �ý��ۿ� ���� �ش� Ʈ���ſ� �������� ���
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
		SCA_DataSave(i,Stat_AddSc[i+1],116)
	NIfEnd()

	CIf(FP,{Deaths(i, Exactly, 0,14),CD(CTSwitch,1)},{SetCD(CTSwitch,0),SetCD(CheatDetect,0)})--���̺� �Ϸ��� ġ�� �˻�
	--if TestStart == 1 then
	--	f_LAdd(FP,Credit[i+1],Credit[i+1],"1") -- �����߳�?
	--end
	f_LMov(FP, CTPEXP, PEXP[i+1])
	CMov(FP, CTPLevel, 1)
	CMov(FP,CTStatP,0)
	CMov(FP,CTStatP2,StatP[i+1])
	f_LMov(FP, CTCurEXP, 0,nil,nil,1)
	f_LMov(FP, CTTotalExp, "10",nil,nil,1)
	CallTrigger(FP,Call_CT)

	CAdd(FP,CTStatP2,Stat_ScDmg[i+1])
	CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer[i+1],_Mov(100)),_Mov(5)))
	CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer2[i+1],_Mov(100)),_Mov(200)))
	CAdd(FP,CTStatP2,_Mul(_Div(Stat_TotalEPer3[i+1],_Mov(100)),_Mov(1000)))
	CAdd(FP,CTStatP2,_Mul(Stat_Upgrade[i+1],_Mov(5)))
	CAdd(FP,CTStatP2,_Mul(Stat_AddSc[i+1],_Mov(10)))
	CMov(FP,0x57f0f0+(i*4),CTStatP)--ġ�ð����� �������� ǥ��� �̳׶�
	CMov(FP,0x57f120+(i*4),CTStatP2)--ġ�ð����� �������� ǥ��� ����
	CTrigger(FP, {TTNVar(CTStatP,NotSame,CTStatP2)}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {TTNVar(CTPLevel,NotSame,PLevel[i+1])}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {TTNWar(CTCurEXP,NotSame,CurEXP[i+1])}, {SetCD(CheatDetect,1)})
	CTrigger(FP, {TTNWar(CTTotalExp,NotSame,TotalExp[i+1])}, {SetCD(CheatDetect,1)})
	TriggerX(FP, {CD(CheatDetect,1),LocalPlayerID(i)}, {
		SetCp(i),
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�. (�����ʹ� �������� �� �����Ǿ� ����.)\x07 ��",4);
		DisplayText("\x13\x07�� \x04SCA ���̵�, ��Ÿ ���̵�, ���� �̳׶�, ���� ������ �Բ� �����ڿ��� �������ֽñ� �ٶ��ϴ�.\x07 ��",4);
		SetMemory(0xCDDDCDDC,SetTo,1);})
	
	CMov(FP,0x57f0f0+(i*4),0)--ġ�ð����� �������� ǥ��� �̳׶� �ʱ�ȭ
	CMov(FP,0x57f120+(i*4),0)--ġ�ð����� �������� ǥ��� ���� �ʱ�ȭ

	
	CIfEnd()

	
	if TestStart == 1 then
		--f_LAdd(FP, PEXP[i+1], PEXP[i+1], "1")
		--f_LMul(FP, PEXP[i+1], PEXP[i+1], "2")
		--f_LAdd(FP, TotalExp[i+1], TotalExp[i+1], "1")
		--f_LMul(FP, TotalExp[i+1], TotalExp[i+1], "2")
	end



	CreateUnitStacked(nil,1, 88, 36+i,15+i, i, nil, 1)--�⺻��������
	--if Limit == 1 then 
	--	CIf(FP,{Deaths(i,AtLeast,1,100),Deaths(i,AtLeast,1,503)})
	--	CreateUnitStacked({}, 12, LevelUnitArr[40][2], 36+i, 15+i, i)
	--	--f_LAdd(FP,PEXP[i+1],PEXP[i+1],"500000000")
	--	CIfEnd()
	--end
	
	TriggerX(FP, {Command(i,AtLeast,1,88),CD(ScTimer[i+1],4320)}, {RemoveUnit(88,i)},{preserved}) -- 3�е� ������� �⺻����

	if TestStart == 1 then 
		--CMov(FP,StatP[i+1],500)
	end
	for NBit = 2,7 do
		local NB = 10^NBit
		if NBit == 7 then NB = (10^NBit)/2 end
		TriggerX(FP,{Accumulate(i, AtLeast, NB, Ore)},{SetV(BuildMul1[i+1],2^(NBit-1)),SetCp(i),DisplayText(StrDesignX("�ǹ��� \x1BDPS\x1F(�̳׶�)\x04�� \x08"..NB.." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..(2^(NBit-1)).."��\x04�� �����Ͽ����ϴ�.")),SetCp(FP)})--1���ǹ�
		TriggerX(FP,{Accumulate(i, AtLeast, NB, Gas)},{SetV(BuildMul2[i+1],2^(NBit-1)),SetCp(i),DisplayText(StrDesignX("�ǹ��� \x1BDPS\x07(����)\x04�� \x08"..NB.." \x04�� �����Ͽ����ϴ�. \x07�� ������\x04�� \x08"..(2^(NBit-1)).."��\x04�� �����Ͽ����ϴ�.")),SetCp(FP)})--2���ǹ�
	end
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[15][2])},{SetCp(i),DisplayText(StrDesignX("\x0815�� \x04������ ȹ���Ͽ����ϴ�. \x0815�� \x04���ֺ��ʹ� \x17�Ǹ�\x04�� ���� \x1B����ġ\x04�� ȹ���� �� �ֽ��ϴ�.")),SetCp(FP)})
	TriggerX(FP,{Command(i,AtLeast,1,LevelUnitArr[26][2])},{SetCp(i),DisplayText(StrDesignX("\x0F26�� \x04������ ȹ���Ͽ����ϴ�. \x0F15�� \x04���ֺ��ʹ� \x08����\x04�� ������ �� �ֽ��ϴ�.")),DisplayText(StrDesignX("\x08���� \x1C���� \x07���ѽð�\x04�� ������, \x08�ִ� 4�� \x04���� �����մϴ�.")),SetCp(FP)})

	DPSBuilding(i,DpsLV1[i+1],nil,BuildMul1[i+1],{Ore},Money[i+1])
	DPSBuilding(i,DpsLV2[i+1],"100000",BuildMul2[i+1],{Gas},Money[i+1])
	Debug_DPSBuilding(DpsLV1[i+1],127,95+i)
	Debug_DPSBuilding(DpsLV2[i+1],190,88+i)

	
	--UnitReadX(FP, i, "Men", 65+i, Income[i+1])


	CTrigger(FP,{TBring(i, AtMost, _Sub(IncomeMax[i+1],1), "Men", 65+i)},{MoveUnit(1, "Men", i, 15+i, 22+i),AddV(Income[i+1],1),MoveUnit(1, "Factories", i, 22+i, 57+i)},1)--����� ����

	TriggerX(FP, {Bring(i,AtLeast,1,"Men",29+i)}, {MoveUnit(1, "Men", i, 29+i, 36+i),SubV(Income[i+1],1)}, {preserved})--����� ����

	TriggerX(FP, {CV(BossLV,4,AtMost),Bring(i, AtMost, 3, "Factories", 109)}, {MoveUnit(1, "Factories", i, 102+i, 109)}, {preserved})--������ ����
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
		local ContentStr1 = "\x06"..j.."�� \x04���� \x1B�ڵ���ȭ \x07ON \04(�Ǹ� �켱 �����)"
		local ContentStr2 = "\x06"..j.."�� \x04���� \x1B�ڵ���ȭ \x08OFF \04(�Ǹ� �켱 �����)"
		CIfBtnFunc(i,j-1,StrDesign(ContentStr1),StrDesign(ContentStr2),CD(AutoEnchArr[j][i+1],0),{SetCD(AutoEnchArr[j][i+1],1)},SetCD(AutoEnchArr[j][i+1],0))--SetCD(AutoSellArr[j][i+1],0)
	
		CIfEnd()
	end
	BtnSetEnd()

	BtnSetInit(i,SettingUnit2) -- 26~39���� �ڵ���ȭ ����

	for j = 26, 39 do
		local ContentStr1 = "\x0F"..j.."�� \x04���� \x1B�ڵ���ȭ \x07ON \04(�Ǹ� �켱 �����)"
		local ContentStr2 = "\x0F"..j.."�� \x04���� \x1B�ڵ���ȭ \x08OFF \04(�Ǹ� �켱 �����)"
		CIfBtnFunc(i,j-26,StrDesign(ContentStr1),StrDesign(ContentStr2),CD(AutoEnchArr[j][i+1],0),{SetCD(AutoEnchArr[j][i+1],1)},SetCD(AutoEnchArr[j][i+1],0))--SetCD(AutoSellArr[j][i+1],0)
	
		CIfEnd()
	end
	BtnSetEnd()

	
	BtnSetInit(i,SettingUnit3) -- 15~25������ �ڵ��Ǹ� ����
	for j = 15, 25 do
		local ContentStr1 = "\x06"..j.."�� \x04���� \x07�ڵ��Ǹ� \x07ON \04(�Ǹ� �켱 �����)"
		local ContentStr2 = "\x06"..j.."�� \x04���� \x07�ڵ��Ǹ� \x08OFF \04(�Ǹ� �켱 �����)"
		CIfBtnFunc(i,j-1,StrDesign(ContentStr1),StrDesign(ContentStr2),CD(AutoSellArr[j][i+1],0),{SetCD(AutoSellArr[j][i+1],1)},SetCD(AutoSellArr[j][i+1],0))--SetCD(AutoEnchArr[j][i+1],0)
	
		CIfEnd()
	end
	BtnSetEnd()
	
	BtnSetInit(i,SettingUnit4) -- 26~39���� �ڵ��Ǹ� ����
	for j = 26, 40 do
		local ContentStr1 = "\x0F"..j.."�� \x04���� \x07�ڵ��Ǹ� \x07ON \04(�Ǹ� �켱 �����)"
		local ContentStr2 = "\x0F"..j.."�� \x04���� \x07�ڵ��Ǹ� \x08OFF \04(�Ǹ� �켱 �����)"
		CIfBtnFunc(i,j-26,StrDesign(ContentStr1),StrDesign(ContentStr2),CD(AutoSellArr[j][i+1],0),{SetCD(AutoSellArr[j][i+1],1)},SetCD(AutoSellArr[j][i+1],0))--SetCD(AutoEnchArr[j][i+1],0)
	
		CIfEnd()
	end
	BtnSetEnd()
	
	BtnSetInit(i,ShopUnit) -- 1~25������ �ڵ���ȭ ����

	CIf(FP,{TMemory(_Add(MenuPtrData[i+1],0x98/4),Exactly,0 + 0*65536)}) -- ���� �ø�
	CallTrigger(FP,Call_Print13[i+1])
	CIfX(FP,{CV(MulOp[i+1],10000000-1,AtMost)},{},{preserved})	-- ������ ������ ���
	f_Mul(FP,MulOp[i+1],10)
	CTrigger(FP,{LocalPlayerID(i)},{print_utf8(12,0,StrDesign("\x03System \x04: ������ �÷Ƚ��ϴ�."))},{preserved})
	CElseX()--������ �������� ���� ���
	CTrigger(FP,{LocalPlayerID(i)},{print_utf8(12,0,StrDesign("\x08ERROR \x04: �� �̻� ������ �ø� �� �����ϴ�."))},{preserved})
	CIfXEnd()
	CIfEnd()
	
	CIf(FP,{TMemory(_Add(MenuPtrData[i+1],0x98/4),Exactly,0 + 1*65536)}) -- ���� ����
	CallTrigger(FP,Call_Print13[i+1])
	CIfX(FP,{CV(MulOp[i+1],2,AtLeast)},{},{preserved})	-- ������ ������ ���
	f_Div(FP,MulOp[i+1],10)
	CTrigger(FP,{LocalPlayerID(i)},{print_utf8(12,0,StrDesign("\x03System \x04: ������ ���Ƚ��ϴ�."))},{preserved})
	CElseX()--������ �������� ���� ���
	CTrigger(FP,{LocalPlayerID(i)},{print_utf8(12,0,StrDesign("\x08ERROR \x04: �� �̻� ������ ���� �� �����ϴ�."))},{preserved})
	CIfXEnd()
	CIfEnd()



	BtnSetEnd()

	for j, k in pairs(LevelUnitArr) do
		TriggerX(FP, {Command(i,AtLeast,1,k[2])}, {SetCD(AutoEnchArr2[j][i+1],1)})
			
		CIf(FP,CD(AutoEnchArr[j][i+1],1))
		CallTriggerX(FP,Call_Print13[i+1],{CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: �ּ� 1ȸ �̻� �ش� ������ ��ȭ�� �����ؾ��մϴ�."))}, {preserved})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)}, {SetCD(AutoEnchArr[j][i+1],0)}, {preserved})
		TriggerX(FP, {CD(AutoEnchArr[j][i+1],1)}, {Order(k[2], i, 36+i, Move, 8+i)}, {preserved})
		CIfEnd()

		CIf(FP,CD(AutoSellArr[j][i+1],1))
		CallTriggerX(FP,Call_Print13[i+1],{CD(AutoSellArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)})
		TriggerX(FP, {CD(AutoSellArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0),LocalPlayerID(i)}, {SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: �ּ� 1ȸ �̻� �ش� ������ ��ȭ�� �����ؾ��մϴ�."))}, {preserved})
		TriggerX(FP, {CD(AutoSellArr[j][i+1],1),CD(AutoEnchArr2[j][i+1],0)}, {SetCD(AutoSellArr[j][i+1],0)}, {preserved})
		TriggerX(FP, {CD(AutoSellArr[j][i+1],1)}, {Order(k[2], i, 36+i, Move, 73+i)}, {preserved})
		CIfEnd()
	end
	CIfX(FP, {TCommand(i,AtMost,ULimitV2,"Men"),CD(AutoBuyCode[i+1],1,AtLeast)}) -- �ڵ����� ����
	for j, k in pairs(AutoBuyArr) do
		AutoBuy(i,k[1],k[2])
	end
	CElseIfX({TCommand(i,AtLeast,ULimitV,"Men")})
	CallTrigger(FP,Call_Print13[i+1])
	for j = 1, 7 do
		TriggerX(FP, {LocalPlayerID(i),CV(PCheckV,j)}, {print_utf8(12,0,StrDesign("\x08ERROR \x04: ���� ���ּ��� �ʹ� ���� ���� ������ �� �����ϴ�.\x08 (�ִ� "..ULimitArr[j].."��)"))},{preserved})
	end

	
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
		{{CV(StatP[i+1],10,AtLeast),CV(Stat_AddSc[i+1],4,AtMost)},{SubV(StatP[i+1],10),AddV(Stat_AddSc[i+1],1)},StrDesign("\x07�⺻���� ����\x04�� \x0F1�� \x04�����Ͽ����ϴ�.")},
		{{CV(Stat_AddSc[i+1],5,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x07�⺻���� ����\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],9,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
--	end
	KeyFunc(i,"3",{
		{{CV(StatP[i+1],5,AtLeast),CV(Stat_TotalEPer[i+1],9999,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_TotalEPer[i+1],100)},StrDesign("\x07�� \x08��ȭ Ȯ��\x04�� �����Ͽ����ϴ�.")},
		{{CV(Stat_TotalEPer[i+1],10000,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x07�� \x08��ȭ Ȯ��\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
	KeyFunc(i,"4",{
		{{CV(StatP[i+1],200,AtLeast),CV(Stat_TotalEPer2[i+1],4999,AtMost)},{SubV(StatP[i+1],200),AddV(Stat_TotalEPer2[i+1],100)},StrDesign("\x07+2�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
		{{CV(Stat_TotalEPer2[i+1],5000,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x07+2�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],199,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
	KeyFunc(i,"5",{
		{{CV(StatP[i+1],1000,AtLeast),CV(Stat_TotalEPer3[i+1],2999,AtMost)},{SubV(StatP[i+1],1000),AddV(Stat_TotalEPer3[i+1],100)},StrDesign("\x07+3�� ��ȭȮ��\x04�� \x0F0.1%p \x04�����Ͽ����ϴ�.")},
		{{CV(Stat_TotalEPer3[i+1],3000,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x10+3�� \x08��ȭȮ��\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],999,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
	KeyFunc(i,"6",{
		{{CV(StatP[i+1],5,AtLeast),CV(Stat_Upgrade[i+1],49,AtMost)},{SubV(StatP[i+1],5),AddV(Stat_Upgrade[i+1],1)},StrDesign("\x07���� ������\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
		{{CV(Stat_Upgrade[i+1],50,AtLeast)},{},StrDesign("\x08ERROR \x04: �� �̻� \x08������\x04�� �ø� �� �����ϴ�.")},
		{{CV(StatP[i+1],4,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	})
	--KeyFunc(i,"6",{
	--	{{CV(StatP[i+1],5,AtLeast)},{SubV(StatP[i+1],5),AddV(Stat_EXPIncome[i+1],1)},StrDesign("\x07����ġ ȹ�\x04�� \x0810% \x04�����Ͽ����ϴ�.")},
	--	{{CV(StatP[i+1],0,AtMost)},{},StrDesign("\x08ERROR \x04: ����Ʈ�� �����մϴ�.")},
	--})
	TriggerX(FP, {MSQC_KeyInput(i,"ESC")}, {SetV(InterfaceNum[i+1],0),SetCp(i),DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n", 4),CenterView(36+i)},{preserved})
	CIfXEnd()
	DoActions(FP, SetCp(FP))--Ű�νĺ� ����

	DoActionsX(FP, {SetCp(i),SetCDeaths(FP,SetTo,0,ShopKey[i+1])})--Ű�νĺ� ����
	--TriggerX(FP, {CV(InterfaceNum[i+1],0),MSQC_KeyInput(i,"P")}, {SetV(InterfaceNum[i+1],1)},{preserved})
	--CIfX(FP,{CV(InterfaceNum[i+1],1)},{SetCp(i),CenterView(72),SetCp(FP)})

	--CIfXEnd()
	DoActions(FP, SetCp(FP))--Ű�νĺ� ����


	--�� ���� �� �ջ�
	CMov(FP,Stat_EXPIncome[i+1],0,nil,nil,1)
	CMov(FP,IncomeMax[i+1],12,nil,nil,1)
	--CMov(FP,IncomeMax[i+1],Stat_ScDmg[i+1],12,nil,1)
	CMov(FP,ScoutDmg[i+1],Stat_ScDmg[i+1],nil,nil,1)
	CMov(FP,TotalEPer[i+1],Stat_TotalEPer[i+1],nil,nil,1)
	CMov(FP,TotalEPer2[i+1],Stat_TotalEPer2[i+1],nil,nil,1)
	CMov(FP,TotalEPer3[i+1],Stat_TotalEPer3[i+1],nil,nil,1)
	CIf(FP,{CV(BossLV,1,AtLeast)}) -- ������ Ŭ�����
		CIfOnce(FP,{},{SetV(Time,55000),SetCp(i),DisplayText(StrDesignX("������ Ŭ�����Ͽ����ϴ�. ��� �� �ڵ�����˴ϴ�..."),4),SetCp(FP)})
		CIfEnd()
		CAdd(FP,IncomeMax[i+1],12) -- ����� ���ּ� +12 ����
		CAdd(FP,TotalEPer[i+1],1500) -- ��ȭȮ�� +1.5%p
	CIfEnd()

	CIf(FP,{CV(BossLV,2,AtLeast)}) -- ������ Ŭ�����
		CIfOnce(FP,{},{SetV(Time,55000),SetCp(i),DisplayText(StrDesignX("������ Ŭ�����Ͽ����ϴ�. ��� �� �ڵ�����˴ϴ�..."),4),SetCp(FP)})
		f_LAdd(FP,Credit[i+1],Credit[i+1],"200") -- ũ���� ����
		CIfEnd()
		CAdd(FP,IncomeMax[i+1],9) -- ����� ���ּ� +8 ����
		CAdd(FP,TotalEPer[i+1],2500) -- ��ȭȮ�� +2.5%p
	CIfEnd()

	CIf(FP,{CV(BossLV,3,AtLeast)}) -- ������ Ŭ�����
		CIfOnce(FP,{},{SetV(Time,55000),SetCp(i),DisplayText(StrDesignX("������ Ŭ�����Ͽ����ϴ�. ��� �� �ڵ�����˴ϴ�..."),4),SetCp(FP)})
		f_LAdd(FP,Credit[i+1],Credit[i+1],"500") -- ũ���� ����
		CIfEnd()
		CAdd(FP,IncomeMax[i+1],6) -- ����� ���ּ� +8 ����
		CAdd(FP,TotalEPer[i+1],3500) -- ��ȭȮ�� +3.5%p
		CAdd(FP,Stat_EXPIncome[i+1],3) -- �ǸŽ� ����ġ 30% ����
	CIfEnd()
	CIf(FP,{CV(BossLV,4,AtLeast)}) -- ������ Ŭ�����
		CIfOnce(FP,{},{SetV(Time,55000),SetCp(i),DisplayText(StrDesignX("������ Ŭ�����Ͽ����ϴ�. ��� �� �ڵ�����˴ϴ�..."),4),SetCp(FP)})
		f_LAdd(FP,Credit[i+1],Credit[i+1],"2000") -- ũ���� ����
		CIfEnd()
		CAdd(FP,IncomeMax[i+1],9) -- ����� ���ּ� +8 ����
		CAdd(FP,TotalEPer[i+1],3000) -- ��ȭȮ�� +3.0%p
		CAdd(FP,TotalEPer2[i+1],1000) -- +2 ��ȭȮ�� +1.0%p
		CAdd(FP,Stat_EXPIncome[i+1],2) -- �ǸŽ� ����ġ 20% ����
	CIfEnd()

	CIf(FP,{CV(BossLV,5,AtLeast)}) -- ������ Ŭ�����
		CIfOnce(FP,{},{SetV(Time,55000),SetCp(i),DisplayText(StrDesignX("������ Ŭ�����Ͽ����ϴ�. ��� �� �ڵ�����˴ϴ�..."),4),SetCp(FP)})
		f_LAdd(FP,Credit[i+1],Credit[i+1],"10000") -- ũ���� ����
		CIfEnd()
		CAdd(FP,TotalEPer[i+1],3000) -- ��ȭȮ�� +3.0%p
		CAdd(FP,TotalEPer3[i+1],500) -- +3 ��ȭȮ�� +0.5%p
		CAdd(FP,Stat_EXPIncome[i+1],2) -- �ǸŽ� ����ġ 20% ����
	CIfEnd()

	DoActionsX(FP,{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 0),SetMemoryB(0x58F32C+(i*15)+12, SetTo, 0),SetV(Stat_Upgrade_UI[i+1],0)})
	for CBit = 0, 7 do -- 8��Ʈ ������ ���� ���ۼ�ġ ����
		TriggerX(FP,{NVar(Stat_Upgrade[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 2^CBit),AddV(Stat_Upgrade_UI[i+1],(2^CBit)*10)},{preserved})
	end
	for CBit = 0, 7 do -- 8��Ʈ ������ ���� ���ۼ�ġ ����
		TriggerX(FP,{NVar(Stat_ScDmg[i+1],Exactly,2^CBit,2^CBit)},{SetMemoryB(0x58F32C+(i*15)+12, Add, 2^CBit)},{preserved})
	end

	--if Limit == 1 then--�������ڿ� ġƮ
	--	CIf(FP,{Deaths(i,AtLeast,1,100)},{SetMemoryB(0x58F32C+(i*15)+13, SetTo, 90)})
	--	CMov(FP,IncomeMax[i+1],48,nil,nil,1)
	--	CIfEnd()
	--end

	if Limit == 1 then
		TriggerX(FP,{},{SetMemoryB(0x58F32C+(i*15)+13, Add, 40),AddV(TotalEPer[i+1],2000)},{preserved})-- �ο��� ���� ���ʽ�
	else
		
		TriggerX(FP,{NVar(PCheckV,AtLeast,2)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 10),AddV(TotalEPer[i+1],500)},{preserved})-- �ο��� ���� ���ʽ�
		TriggerX(FP,{NVar(PCheckV,AtLeast,4)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 10),AddV(TotalEPer[i+1],500)},{preserved})-- �ο��� ���� ���ʽ�
		TriggerX(FP,{NVar(PCheckV,AtLeast,6)},{SetMemoryB(0x58F32C+(i*15)+13, Add, 20),AddV(TotalEPer[i+1],1000)},{preserved})-- �ο��� ���� ���ʽ�
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
		CIfX(FP,{CV(PLevel[i+1],10000,AtLeast)},{MoveUnit(All,88,i,73+i,80+i),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: �̹� ������ �޼��Ͽ� �� �� �����ϴ�..."), 4),SetCp(FP)})
		CElseX()
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
		CIfXEnd()

	CIfEnd()

	
	
	
	CIf(FP,LocalPlayerID(i),{SetCD(StatEffLoc,0)}) -- CAPrint�� ������ ����
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
	CMov(FP,UpgradeLoc,Stat_Upgrade_UI[i+1])
	CMov(FP,AddScLoc,Stat_AddSc[i+1])
	
	CMov(FP,ScoutDmgLoc,ScoutDmg[i+1])
	CMov(FP,EXPIncomeLoc2,Stat_EXPIncome[i+1])
	CIfEnd()
	



	CIfEnd()
end
SpeedV = CreateVar(FP)
CIf(FP,{Bring(AllPlayers, AtLeast, 1, 15, 112)})
	for i= 0, 6 do
		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,113)},{MoveUnit(1, 15, i, 113, 116)})
			CIfX(FP,{CV(SpeedV,0),TTNWar(Credit[i+1], AtLeast, "500")},{SetMemory(0x5124F0,SetTo,13),KillUnit(166, FP),SetV(SpeedV,1),RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04��(��) \x084��� \x04�������� �����Ͽ����ϴ�. �������� \x084���\x04�� ����˴ϴ�."),4)}, Force1, FP)})
				f_LSub(FP, Credit[i+1], Credit[i+1], "500")
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- �ڵ�����
			CElseIfX({CV(SpeedV,1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: �̹� ���ԵǾ����ϴ�."), 4),SetCp(FP)})
			CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�."), 4),SetCp(FP)})
			CIfXEnd()
		CIfEnd()

		CIf(FP,{HumanCheck(i, 1),Bring(i,AtLeast,1,15,114)},{MoveUnit(1, 15, i, 114, 116)})
		local NeedSp = def_sIndex()
			NJump(FP, NeedSp, {CV(SpeedV,0)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x085��� \x04�������� ���� �������ּ���."), 4),SetCp(FP)})
			CIfX(FP,{CountdownTimer(AtMost, 60*60*48),CV(SpeedV,1),TTNWar(Credit[i+1], AtLeast, "10000")},{SetCountdownTimer(Add, 60*60*12),KillUnit(169, FP)})
			TriggerX(FP,{CountdownTimer(AtMost, 0)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04��(��) \x1F�ִ��� \x04�������� �����Ͽ����ϴ�. �������� \x1Fī��Ʈ�ٿ� Ÿ�̸� 12�ð�\x04���� \x1F�ִ���\x04�� ����˴ϴ�."),4)}, Force1, FP)},{preserved})
			TriggerX(FP,{CountdownTimer(AtLeast, 1)},{RotatePlayer({DisplayTextX(StrDesignX(ColorT[i+1].."P"..(i+1).." \x04��(��) \x1F�ִ��� \x04�������� �����Ͽ����ϴ�. \x1Fī��Ʈ�ٿ� Ÿ�̸�\x04�� \x1F12�ð�\x04 �߰��Ǿ����ϴ�."),4)}, Force1, FP)},{preserved})
				f_LSub(FP, Credit[i+1], Credit[i+1], "10000")
				TriggerX(FP,{LocalPlayerID(i)},{SetMemory(0x58F500, SetTo, 1)}) -- �ڵ�����
				CElseIfX({CountdownTimer(AtLeast, (60*60*48)+1)},{SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: ī��Ʈ�ٿ� Ÿ�̸Ӱ� �ʹ� �����ϴ�. ���ӽð��� �Ҹ��ϰ� �ٽ� �õ����ּ���."), 4),SetCp(FP)})
				CElseX({SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesign("\x08ERROR \x04: \x17ũ����\x04�� �����մϴ�."), 4),SetCp(FP)})
			CIfXEnd()
			NJumpEnd(FP, NeedSp)
		CIfEnd()

	end
CIfEnd()
Trigger2X(FP,{CV(BossLV,5,AtLeast)},{SetCountdownTimer(Add, 60*60*24),RotatePlayer({DisplayTextX(StrDesignX("\x1F���� LV.5\x04�� Ŭ�����Ͽ����ϴ�. �������� \x1Fī��Ʈ�ٿ� Ÿ�̸� 24�ð�\x04���� \x1F�ִ���\x04�� ����˴ϴ�."),4)}, Force1, FP)})
TriggerX(FP,{CountdownTimer(AtLeast, 1)},{SetMemory(0x5124F0,SetTo,1)},{preserved})--ī��Ʈ�ٿ� Ÿ�̸� �����
TriggerX(FP,{CV(SpeedV,0),CountdownTimer(AtMost, 0)},{SetMemory(0x5124F0,SetTo,0x15)},{preserved})--5����� �Ȼ������
TriggerX(FP,{CV(SpeedV,1),CountdownTimer(AtMost, 0)},{SetMemory(0x5124F0,SetTo,13)},{preserved})--5����� �������





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
	CIfX(FP,{CV(LevelLoc,9999,AtMost)})
	CElseX({SetV(ExpLoc,0)})
	CIfXEnd()
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
	CA__SetValue(Str1,"\x071. \x07�⺻���� \x08������ \x04+1000 \x08(�ִ� 5��) - \x1F1 Pts\x12\x04 + \x0D\x0D\x0D\x0D\x0D\x0D000",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,38),ScoutDmgLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B)
	TriggerX(FP, {CV(ScoutDmgLoc,0)}, {
		SetCSVA1(SVA1(Str1,46-2), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
		SetCSVA1(SVA1(Str1,47-2), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
		SetCSVA1(SVA1(Str1,48-2), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
		SetCSVA1(SVA1(Str1,49-2), SetTo, 0x0D0D0D0D, 0xFFFFFFFF),
	}, {preserved})
	CA__InputVA(56*4,Str1,Str1s,nil,56*4,56*5-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x072. \x07�߰� �⺻���� \x041�� ���� \x04�ִ� 5�� - \x1F10 Pts\x12\x07+ \x1C\x0D\x0D\x0D\x0D\x0D\x0D\x0D��",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,38),AddScLoc,nil,nil,{10,1},1,nil,"\x070",0x07)
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

	CA__SetValue(Str1,"\x073. \x07+1 \x08��ȭȮ�� \x0F0.1%p \x08MAX 100 \x04- \x1F5 Pts\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,37),S_TotalEPerLoc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str1,S_TotalEPerLoc,37)
	CA__InputVA(56*6,Str1,Str1s,nil,56*6,56*7-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x074. \x07+2 \x08��ȭȮ�� \x070.1%p \x08MAX 50 \x04- \x1F200 Pts\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,38),S_TotalEPer2Loc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str1,S_TotalEPer2Loc,38)
	CA__InputVA(56*7,Str1,Str1s,nil,56*7,56*8-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x075. \x10+3 \x08��ȭȮ�� \x070.1%p \x08MAX 30 \x04- \x1F1000 Pts\x12\x07+ \x0F\x0D00.000 %p",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,39),S_TotalEPer3Loc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str1,S_TotalEPer3Loc,39)
	CA__InputVA(56*8,Str1,Str1s,nil,56*8,56*9-2)
	CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
	CA__SetValue(Str1,"\x076. \x1B���� ������ \x08(�ִ� +500%) - \x1F5 Pts\x12\x07+ \x0D\x0D\x0D\x0D\x0D %",nil,1)
	CS__ItoCustom(FP,SVA1(Str1,34),UpgradeLoc,nil,nil,{10,3},1,nil,"\x080",0x08)
	CA__InputVA(56*9,Str1,Str1s,nil,56*9,56*10-2)

	
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
	CAPrint(iStr1,{Force1},{1,0,0,0,1,1,0,0},"TEST",FP,{}) 

	
function TEST2() 
	local PlayerID = CAPrintPlayerID 
	CA__SetValue(Str2,"\x04����� \x07+1 \x08��ȭȮ�� \x04�� ������ : \x07+ \x0F\x0D00.000%p",nil,1)
	CA__ItoCustom(SVA1(Str2,24),TotalEPerLoc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str2,TotalEPerLoc,24)
	CA__InputVA(56*0,Str2,Str2s,nil,56*0,56*1-2)
	CA__SetValue(Str2,MakeiStrVoid(54),0xFFFFFFFF,0) 
	
	CA__SetValue(Str2,"\x04����� \x07+2 \x08��ȭȮ�� \x04�� ������ : \x07+ \x0F\x0D00.000%p",nil,1)
	CA__ItoCustom(SVA1(Str2,24),TotalEPer2Loc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str2,TotalEPer2Loc,24)
	CA__InputVA(56*1,Str2,Str2s,nil,56*1,56*2-2)
	CA__SetValue(Str2,MakeiStrVoid(54),0xFFFFFFFF,0) 
	
	CA__SetValue(Str2,"\x04����� \x10+3 \x08��ȭȮ�� \x04�� ������ : \x07+ \x0F\x0D00.000%p",nil,1)
	CA__ItoCustom(SVA1(Str2,24),TotalEPer3Loc,nil,nil,{10,5},1,nil,nil,0x0F,{0,1,3,4,5},nil,{})
	PercentStrFix(Str2,TotalEPer3Loc,24)
	CA__InputVA(56*2,Str2,Str2s,nil,56*2,56*3-2)
	CA__SetValue(Str2,MakeiStrVoid(54),0xFFFFFFFF,0) 

	CA__SetValue(Str2,"\x04����� \x1C����ġ \x07�߰� \x04ȹ�淮 : \x07+ \x1C\x0D\x0D\x0D\x0D\x0D\x0D\x0D0%",nil,1)

	CIf(FP,{CV(EXPIncomeLoc2,1,AtLeast)})
	CA__ItoCustom(SVA1(Str2,21),EXPIncomeLoc2,nil,nil,{10,2},1,nil,"\x0D",0x1C)
	CIfEnd()
	
	CA__InputVA(56*3,Str2,Str2s,nil,56*3,56*4-2)
	CA__SetValue(Str2,MakeiStrVoid(54),0xFFFFFFFF,0) 
	
	
end
local temp,PKey = KeyToggleFunc("P")--O�� ���� ��� ���� �������� ���� �� ǥ��
CAPrint(iStr2,{Force1},{1,0,0,0,1,0,0,0},"TEST2",FP,{CD(PKey,1),CV(InterfaceNumLoc,0)}) 
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
	NIfOnce(FP,{Memory(0x628438,AtLeast,1),CV(BossEPD,0),CV(BossLV,j-1)})--������ �ǹ� ����
	f_Read(FP, 0x628438, nil, BossEPD)
	DoActionsX(FP, {CreateUnit(1,k[1],110,FP),AddV(BossEPD,2)})
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

local iStrinit = def_sIndex()
CJump(FP, iStrinit)
t00 = "\x07\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
t01 = "\x07����Ȯ�� \x04: \x0D000.000\x08%\x0D\x0D"
t02 = "\x08!!! \x1F�� �� �� �� \x08!!!"
t03 = "\x04��ȭ �Ұ� ����"
t04 = "\x19�ǸŽ� ����ġ : \x0d0,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
t05 = "\x08�Ǹ� �Ұ� ����"
t06 = "\x11���� DPM : \x0D0000\x04��0000\x04��0000\x04��0000\x04��0000"
t07 = "\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I"
t08 = "\x04�����ϱ� \x07������� \x04: \x0D0000\x04��0000��"
iStrSize1 = GetiStrSize(0,t01)
S0 = MakeiTblString(1495,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- ����Ű����
iTbl1 = GetiTblId(FP,1495,S0)
TStr0, TStr0a, TStr0s = SaveiStrArr(FP,t00)
TStr1, TStr1a, TStr1s = SaveiStrArr(FP,t01)
TStr2, TStr2a, TStr2s = SaveiStrArr(FP,t02)
TStr3, TStr3a, TStr3s = SaveiStrArr(FP,t03)
TStr4, TStr4a, TStr4s = SaveiStrArr(FP,t06)
TStr5, TStr5a, TStr5s = SaveiStrArr(FP,t08)

S1 = MakeiTblString(764,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t00)+5),"Base",1) -- ����Ű����
iTbl2 = GetiTblId(FP,764,S1)
S2 = MakeiTblString(16,"None",'None',MakeiStrLetter("\x0D",GetiStrSize(0,t08)+5),"Base",1) -- ����Ű����
iTbl3 = GetiTblId(FP,16,S1)
EStr0, EStr0a, EStr0s = SaveiStrArr(FP,t04)
EStr1, EStr1a, EStr1s = SaveiStrArr(FP,t05)
EStr2, EStr2a, EStr2s = SaveiStrArr(FP,t07)


SelEPD,SelPer,SelUID,SelMaxHP,SelPl,SelI,CurEPD,SelEXP = CreateVars(8,FP)
BossFlag = CreateCcode()
CJumpEnd(FP, iStrinit)




CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- Ŭ�������ν�(����)
CMov(FP,SelPl,0)
f_Read(FP,0x6284B8,nil,SelEPD)
f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
CMov(FP,SelUID,_Read(_Add(SelEPD,25)),nil,0xFF,1)

CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{SetCD(BossFlag,0)}) -- ���ּ��ý� 1ȸ�� ����

CMov(FP,CurEPD,SelEPD)


NIfX(FP,{Never()})
for j, k in pairs(LevelUnitArr) do
	NElseIfX({CV(SelUID,k[2])},{
		SetV(SelPer,k[3]);
		SetV(SelEXP,k[4]);
	})
end
for j, k in pairs(BossArr) do
	NElseIfX({CV(SelUID,k[1])},{SetCD(BossFlag,1);
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
	CMov(FP,LevelLoc2,PLevel[i+1])
end
CElseX()
CMov(FP,TotalEPerLoc,0)
CMov(FP,TotalEPer2Loc,0)
CMov(FP,TotalEPer3Loc,0)
CMov(FP,EXPIncomeLoc,0)
CMov(FP,LevelLoc2,1)
CIfXEnd()
CIfEnd()




CIfX(FP,{CV(SelEXP,0,AtMost)})--����ġ�� ������� Ȥ�� �Ǹ� �Ұ� ������ ���
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl2,0,EStr1,EStr1s,nil,0,EStr1s)
CElseX()--����ġ�� �������
	CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__SetValue(FP,EStr0,t04,nil,0)
	f_Mul(FP,SelEXP,_Add(EXPIncomeLoc,10))
	CS__ItoCustom(FP,SVA1(EStr0,10),SelEXP,nil,nil,{10,8},1,nil,"\x080",0x1B,{0,2,3,4,6,7,8,10},nil,{{0},0,0,{0},0,0,{0},0})

	TriggerX(FP, {
		CSVA1(SVA1(EStr0,19), Exactly, 0x0D*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(EStr0,19), SetTo, string.byte("0")*0x1000000,0xFF000000),
	}, {preserved})
	TriggerX(FP, {
		CSVA1(SVA1(EStr0,21), Exactly, string.byte("0")*0x1000000, 0xFF000000)
	}, {
		SetCSVA1(SVA1(EStr0,21), SetTo, 0x0D*0x1000000,0xFF000000),
		SetCSVA1(SVA1(EStr0,20), SetTo, 0x0D*0x1000000,0xFF000000),
	}, {preserved})
	CS__InputVA(FP,iTbl2,0,EStr0,EStr0s,nil,0,EStr0s)
	CElseIfX({CD(BossFlag,1)})--�����ǹ��ϰ��
	--���� DPS ������ ǥ��� ����
CIfXEnd()

CIfX(FP,{CV(SelUID,LevelUnitArr[#LevelUnitArr][2])})--�ְ������ϰ��
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl1,0,TStr2,TStr2s,nil,0,TStr2s)
CElseIfX({CV(SelPer,0)})--��ȭ������ �ƴ� ���
	CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)
	CS__InputVA(FP,iTbl1,0,TStr3,TStr3s,nil,0,TStr3s)
	CElseIfX({CD(BossFlag,1)})--�����ǹ��ϰ��
	--���� DPS �䱸ġ ǥ��� ����
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

CIf(FP,{CD(BossFlag,0)})
local TotalEPer4Loc = CreateVar(FP)
CAdd(FP,TotalEPer3Loc,_Div(SelPer,100))
CAdd(FP,TotalEPer2Loc,_Div(SelPer,10))
CAdd(FP,TotalEPerLoc,SelPer) -- +1�� Ȯ��

CSub(FP,TotalEPer4Loc,_Mov(100000),_Add(_Add(TotalEPerLoc,TotalEPer3Loc),TotalEPer2Loc))
CIf(FP,{CV(TotalEPer4Loc,0)})
CSub(FP,TotalEPerLoc,_Mov(100000),_Add(TotalEPer2Loc,TotalEPer3Loc))

CIfEnd()


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


CIf(FP, {CD(BossFlag,1)}) -- �����ǹ� ���� ��ð���
TotalDPMLoc = CreateWar(FP)
f_LMov(FP,TotalDPMLoc,TotalDPM)
CS__InputVA(FP,iTbl1,0,TStr0,TStr0s,nil,0,TStr0s)--DPS ��ġ

CS__SetValue(FP,TStr4,t06,nil,0)
CS__lItoCustom(FP,SVA1(TStr4,9),TotalDPMLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1C,0x1C,0x1C,0x1C,0x03,0x03,0x03,0x03},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0}})
CS__InputVA(FP,iTbl1,0,TStr4,TStr4s,nil,0,TStr4s)

CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)--DPS ������
local TotalDPMTemp = CreateWar(FP)
local TempGauge = CreateVar(FP)
local TempGaugeT = CreateVar(FP)
f_LMul(FP, TotalDPMTemp, TotalDPMLoc, "25")
f_LDiv(FP, {TempGauge,TempGaugeT}, TotalDPMTemp, BossDPM)


CS__SetValue(FP,EStr2,t07,nil,0)
for i = 0, 24 do
	CS__InputTA(FP,{CV(TempGauge,i+1,AtLeast)},SVA1(EStr2,0+i),0x07,0xFF)
end
CS__InputVA(FP,iTbl2,0,EStr2,EStr2s,nil,0,EStr2s)


CIfEnd()

CIf(FP,{CV(SelUID,15)}) -- �ù� ���� ��ð���
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
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+2))
--CA__Input(MakeiStrData("\x04��",1),SVA1(Str1,3+7))
--CA__ItoCustom(SVA1(Str1,0),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1E,0x1E,0x1E,0x1E,0x04,0x04,0x04,0x04},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0})



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