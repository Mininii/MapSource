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
	local TotalEPer = iv.TotalEPer-- CreateVarArr(7,FP)--�� ��ȭȮ��(�⺻ 1��)
	local TotalEPer2 = iv.TotalEPer2-- CreateVarArr(7,FP)--�� ��ȭȮ��(+2��)
	local TotalEPer3 = iv.TotalEPer3-- CreateVarArr(7,FP)--�� ��ȭȮ��(+3��)

    local iStrinit = def_sIndex()
    CJump(FP, iStrinit)
    t00 = "\x07\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D"
    t01 = "\x07����Ȯ�� \x04: \x0D000.000\x08%\x0D\x0D"
    t02 = "\x08!!! \x1F�� �� �� �� \x08!!!"
    t03 = "\x04��ȭ �Ұ� ����"
    t04 = "\x19EXP\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04 : \x0D0,000,000,000,000,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
    t10 = "\x19EXP\x17(�Ǹű� �ʿ�)\x04 : \x0D0,000,000,000,000,000,000.0\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d"
    t05 = "\x08�Ǹ� �Ұ� ����"
    t06 = "\x11���� DPM : \x0D0000\x04��0000\x04��0000\x04��0000\x04��0000"
    t09 = "\x08���� DPS : \x0D0000\x04��0000\x04��0000\x04��0000\x04��0000"
    t07 = "\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I\x04I"
    t08 = "\x04�����ϱ� \x07������� \x04: \x0D0000\x04��0000��"
    t11 = "\x04(SCA �ε��� 3�е� �����)"
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
    EStr3, EStr3a, EStr3s = SaveiStrArr(FP,t11)
    SelEPD,SelPer,SelUID,SelMaxHP,SelPl,SelI,CurEPD,SelEXP = CreateVars(8,FP)
    BossFlag = CreateCcode()
    BossFlag2 = CreateCcode()
    SellTicketFlag = CreateCcode()
    local TotalBossDPMLoc = CreateWar(FP)
    CJumpEnd(FP, iStrinit)
    
    
    
    
    CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- Ŭ�������ν�(����)
    CMov(FP,SelPl,0)
    f_Read(FP,0x6284B8,nil,SelEPD)
    f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
    CMov(FP,SelUID,_Read(_Add(SelEPD,25)),nil,0xFF,1)
    
    CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{SetCD(BossFlag,0),SetCD(BossFlag2,0)}) -- ���ּ��ý� 1ȸ�� ����
    
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
    },{TSetMemory(0x6509B0, SetTo, LCP),DisplayText(StrDesignX("\x17P8 \x08��ȭ ����\x04�� ���� ������ \x0F�ڱ��ڽ�\x04�� \x07�ɷ�ġ\x04�� ���� ǥ��˴ϴ�."), 4),SetMemory(0x6509B0, SetTo, FP),},{preserved})
     CDoActions(FP,{TSetMemoryB(0x58F32C, (7*15)+13, SetTo, UpgradeUILoc)})
    CIfXEnd()
    CIfEnd()
    
    
    
    CIfX(FP,{CV(SelEXP,0,AtMost)})--����ġ�� ������� Ȥ�� �Ǹ� �Ұ� ������ ���
        CIfX(FP,{CV(SelUID,88)}) -- ��ī��
        CS__InputVA(FP,iTbl2,0,TStr0,TStr0s,nil,0,TStr0s)
        CS__InputVA(FP,iTbl2,0,EStr3,EStr3s,nil,0,EStr3s)
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
    CAdd(FP,TotalEPer3Loc,_Div(SelPer,_Mov(100)))
    CAdd(FP,TotalEPer2Loc,_Div(SelPer,_Mov(10)))
    CAdd(FP,TotalEPerLoc,SelPer) -- +1�� Ȯ��
    
    
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
    
    CIf(FP, {CD(BossFlag,1)}) -- �����ǹ� ���� ��ð���
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
    
    
        CIf(FP,{CD(TBLFlag,0)})--tbl��ð��ſ�. CreateUnitStacked ���� �ߵ�����
            f_Read(FP, 0x628438, nil, Nextptrs)
            DoActions(FP, CreateUnit(1,94,136,FP))
            CSub(FP,CurCunitI,Nextptrs,19025)
            f_Div(FP,CurCunitI,_Mov(84))
            CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,94))})
            CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV)})
            --CallTrigger(FP, Call_CTInputUID)
            DoActions(FP, RemoveUnit(94,FP))
        CIfEnd()
        DoActionsX(FP,{SetCD(TBLFlag,0)})
        TriggerX(FP,{ElapsedTime(AtLeast, 90)},{RotatePlayer({DisplayTextX(StrDesignX("\x18Notice \x04: \x04���� �ڽ��� \x1F�̳׶�\x04, \x07����\x04�� �ǹ����� ���ϴ� \x08������\x17(DPS) \x04�Դϴ�."))},Force1,FP)})
        TriggerX(FP,{ElapsedTime(AtLeast, 150)},{RotatePlayer({DisplayTextX(StrDesignX("\x18Notice \x04: \x07�ڽ�\x04�� \x11����\x04�� �ִ� \x1Cũ����Ż\x04���� \x07������ ����\x04�ϰ� \x0F����� ��ī���� \x04������ ������ ������ \x08��ȭ\x04�� �˴ϴ�."))},Force1,FP)})
        TriggerX(FP,{ElapsedTime(AtLeast, 180*(1.2))},{RotatePlayer({DisplayTextX(StrDesignX("\x18Notice \x04: �� �� ó�� �־��� ��ī���� \x08����� ��\x04�Դϴ�. \x07������ ����, \x08��ȭ\x04�Ͽ� \x17�����\x04�� �����ô�!"))},Force1,FP)})
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
    --			DisplayTextX(StrDesignX("\x1B�׽�Ʈ �Ⱓ�� ����Ǿ����ϴ�. �̿����ּż� ����� �����մϴ�.").."\n"..StrDesignX("\x1B").."\n"..StrDesignX("\x1B���� ���Ĺ��� ������Ʈ���� �˰ڽ��ϴ�."),4);
    --		Defeat();
    --		},Force1,FP);
    --		Defeat();
    --		SetMemory(0xCDDDCDDC,SetTo,1)
    --		
    --	})
    --end
    
end