function GameDisplay()

	--Local Data Variable
	local IncomeMaxLoc = iv.IncomeMaxLoc--CreateVar(FP)
	local IncomeLoc = iv.IncomeLoc--CreateVar(FP)
	local LevelLoc = iv.LevelLoc--CreateVar(FP)
	local LevelLoc2 = iv.LevelLoc2--CreateVar(FP)
	local TotalEPerLoc = iv.TotalEPerLoc--CreateVar(FP)
	local TotalEPer2Loc = iv.TotalEPer2Loc--CreateVar(FP)
	local TotalEPer4Loc = iv.TotalEPer4Loc--CreateVar(FP)
	local TotalEPer3Loc = iv.TotalEPer3Loc--CreateVar(FP)
	local S_TotalEPerLoc = iv.S_TotalEPerLoc--CreateVar(FP)
	local S_TotalEPerExLoc = iv.S_TotalEPerExLoc--CreateVar(FP)
	local S_TotalEPer2Loc = iv.S_TotalEPer2Loc--CreateVar(FP)
	local S_TotalEPer3Loc = iv.S_TotalEPer3Loc--CreateVar(FP)
	local S_TotalEPer4Loc = iv.S_TotalEPer4Loc--CreateVar(FP)
	local S_BreakShieldLoc = iv.S_BreakShieldLoc--CreateVar(FP)
	local PlayTimeLoc = iv.PlayTimeLoc--CreateVar(FP)
	local PlayTimeLoc2 = iv.PlayTimeLoc2--CreateVar(FP)
	local StatPLoc = iv.StatPLoc--CreateVar(FP)
	local MoneyLoc = iv.MoneyLoc--CreateWar(FP)
	local CredLoc = iv.CredLoc--CreateWar(FP)
	local ExpLoc = iv.ExpLoc--CreateVar(FP)
	local TotalExpLoc = iv.TotalExpLoc--CreateVar(FP)
	local InterfaceNumLoc = iv.InterfaceNumLoc--CreateVaFP)
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
    local TimeAttackScoreLoc = iv.TimeAttackScoreLoc


    
	local LV5Cool = iv.LV5Cool

    

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
        local Tabkey = KeyToggleFunc2("TAB","LCTRL")
        CIfX(FP,{CD(Tabkey,1)})--��ġǥ��
        CIfX(FP,{CV(LevelLoc,49999,AtMost)})
        CElseX({TSetNWar(ExpLoc, SetTo, "0"),TSetNWar(TotalExpLoc, SetTo, "0")})
        CIfXEnd()
        CA__lItoCustom(SVA1(Str1,16),ExpLoc,nil,nil,{10,14},nil,nil,"\x040",{0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
        CA__Input(MakeiStrData("\x08��",1),SVA1(Str1,32))
        CA__lItoCustom(SVA1(Str1,34),TotalExpLoc,nil,nil,{10,14},nil,nil,"\x040",{0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
        CElseX()--�ۼ�Ʈǥ��
        local CurExpTmp = CreateVar(FP)
        local CurExpTmp2 = CreateWar(FP)
        CIfX(FP,{CV(LevelLoc,49999,AtMost)})
        f_LMul(FP, CurExpTmp2,ExpLoc, "20")
        f_Cast(FP, {CurExpTmp,0}, _LDiv(CurExpTmp2,TotalExpLoc), nil, nil, 1)
        CElseX({SetV(CurExpTmp,20)})
        CIfXEnd()
        CA__SetValue(Str1,"\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x17(Ctrl+TAB:���ΰ�)",nil,16)
        for i = 0, 19 do
            CS__InputTA(FP,{CV(CurExpTmp,i+1,AtLeast)},SVA1(Str1,16+i),0x07,0xFF)
        end
        CIfXEnd()
        TriggerX(FP,{CD(StatEffLoc,1),CD(StatEffT,2,AtLeast)},{SetCD(StatEffT,0),SetCSVA1(SVA1(Str1,0),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,1),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,2),SetTo,0x04,0xFF)},{preserved})
        CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)
        CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
        CA__SetValue(Str1,"\x12����Ʈ \x04:  000,000 \x04| \x17ũ���� \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123",nil,1)
        CA__lItoCustom(SVA1(Str1,25),CredLoc,nil,nil,10,1,nil,"\x040",{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x02,0x1E,0x1E,0x1E,0x05,0x05,0x05}
        ,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
        CS__ItoCustom(FP,SVA1(Str1,8),StatPLoc,nil,nil,{10,6},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6}, nil,{0,0,{0},0,0,{0}})
    
        
    
        CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-2)
        CIfX(FP,{CD(Tabkey,1)})--��ġǥ��
        CA__SetColor((56*2)+1, 0x17)
        CA__SetColor((56*2)+19, 0x10)
        CElseX()--�ۼ�Ʈǥ��
        CA__SetColor((56*2)+1, 0x10)
        CA__SetColor((56*2)+19, 0x17)
        CIfXEnd()
        CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
        
    
    
    CA__SetMemoryX((56*3)-1,0x0D0D0D0D,0xFFFFFFFF,1)
        end 
        CAPrint(iStr1,{Force1},{1,0,0,0,1,1,0,0},"TEST",FP,{}) 
    
        DoActions(FP,{SetMemory(0x58F504, SetTo, 0)})
    CIf(FP, CV(InterfaceNumLoc,1,AtLeast))
        
        CMov(FP,MCP,LCP)
        CallTriggerX(FP,Call_SetScrMouse,{},{})
        mmX = mouseX -- �����ǥ ��������
        mmY = mouseY
        mmX2 = screenX -- �߾�����
        mmX3 = screenX2 -- �߾�����
        if TestStart == 1 then
           --DisplayPrintEr(0, {"�����ǥ X : ", mmX, "  Y : ", mmY, " || �߾����� X : ", mmX2, "  Y : ", mmY," || �������� X : ",mmX3,"  Y : ",mmY});
        end
        
        local E1VarArr1 = CreateVarArr(6, FP)
        local E2VarArr1 = CreateVarArr(6, FP)
        local E3VarArr1 = CreateVarArr(6, FP)
        local E4VarArr1 = CreateVarArr(6, FP)
        local E5VarArr1 = CreateVarArr(6, FP)
        local E6VarArr1 = CreateVarArr(6, FP)
        for i = 1, 6 do
            Byte_NumSet(S_TotalEPerLoc,E1VarArr1[i],10^(6-i),1,0x30)
            Byte_NumSet(S_TotalEPer2Loc,E2VarArr1[i],10^(6-i),1,0x30)
            Byte_NumSet(S_TotalEPer3Loc,E3VarArr1[i],10^(6-i),1,0x30)
            Byte_NumSet(S_TotalEPer4Loc,E4VarArr1[i],10^(6-i),1,0x30)
            Byte_NumSet(S_BreakShieldLoc,E5VarArr1[i],10^(6-i),1,0x30)
            Byte_NumSet(S_TotalEPerExLoc,E6VarArr1[i],10^(6-i),1,0x30)
        end
        SetEPerStr(E1VarArr1)
        SetEPerStr(E2VarArr1)
        SetEPerStr(E3VarArr1)
        SetEPerStr(E4VarArr1)
        SetEPerStr(E5VarArr1)
        SetEPerStr(E6VarArr1)
        E1VarArr2 = {E1VarArr1[1],E1VarArr1[2],E1VarArr1[3]}
        E2VarArr2 = {E2VarArr1[1],E2VarArr1[2],E2VarArr1[3]}
        E3VarArr2 = {E3VarArr1[1],E3VarArr1[2],E3VarArr1[3]}
        E4VarArr2 = {E4VarArr1[1],E4VarArr1[2],E4VarArr1[3]}
        E5VarArr2 = {E5VarArr1[1],E5VarArr1[2],E5VarArr1[3]}
        E6VarArr2 = {E6VarArr1[1],E6VarArr1[2],E6VarArr1[3]}
        E1VarArr3 = {E1VarArr1[4],E1VarArr1[5],E1VarArr1[6]}
        E2VarArr3 = {E2VarArr1[4],E2VarArr1[5],E2VarArr1[6]}
        E3VarArr3 = {E3VarArr1[4],E3VarArr1[5],E3VarArr1[6]}
        E4VarArr3 = {E4VarArr1[4],E4VarArr1[5],E4VarArr1[6]}
        E5VarArr3 = {E5VarArr1[4],E5VarArr1[5],E5VarArr1[6]}
        E6VarArr3 = {E6VarArr1[4],E6VarArr1[5],E6VarArr1[6]}
        BColor = CreateVarArr(6,FP)
        BColor2 = CreateVarArr(6,FP)
        BColor3 = CreateVarArr(6,FP)
        BColor4 = CreateVarArr(6,FP)
        MToggle = CreateCcodeArr(6)
        MToggle2 = CreateCcodeArr(6)
        MToggle3 = CreateCcodeArr(6)
        local ESCB = CreateVar(FP)
        local NEXB = CreateVar(FP)
        local PRVB = CreateVar(FP)
        local BAct = {}
        for j,p in pairs({0x04,0x1C,0x08,0x0F,0x0F,0x0F}) do
            table.insert(BAct,SetV(BColor[j],p))
            table.insert(BAct,SetV(BColor2[j],0x04))
            table.insert(BAct,SetV(BColor3[j],0x1F))
            table.insert(BAct,SetV(BColor4[j],0x04))
            table.insert(BAct,SetCD(MToggle[j],0))
            table.insert(BAct,SetCD(MToggle2[j],0))
            table.insert(BAct,SetCD(MToggle3[j],0))
        end
        table.insert(BAct,SetV(ESCB,0x08))
        table.insert(BAct,SetV(NEXB,0x08))
        table.insert(BAct,SetV(PRVB,0x08))
        DoActions2X(FP, BAct)
        local CDFncArr={}
        --296~310 �� ������� ��ư
        --274~388 �����ǥ �������ư
        
        local MStat,CDFnc2 = ToggleFunc({Memory(0x6CDDC0,Exactly,0),Memory(0x6CDDC0,Exactly,2)},1)--
        TriggerX(FP,{MLine(mmY,4),VRange(mmX, 274, 388)},{SetV(ESCB,0x07)},{preserved})
        TriggerX(FP,{MLine(mmY,4),VRange(mmX, 274, 388),CD(MStat,1)},{SetV(ESCB,0x1B)},{preserved})
        
        TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 113, 187)},{SetV(PRVB,0x07)},{preserved})
        TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 113, 187),CD(MStat,1)},{SetV(PRVB,0x1B)},{preserved})

        TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 233, 311)},{SetV(NEXB,0x07)},{preserved})
        TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 233, 311),CD(MStat,1)},{SetV(NEXB,0x1B)},{preserved})

        


        TriggerX(FP,{MLine(mmY,4),VRange(mmX, 274, 388),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000)},{preserved})
        TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 113, 187),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000+8)},{preserved})
        TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 233, 311),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000+7)},{preserved})
        --113~187
        --233~311
        for i = 0, 5 do
            TriggerX(FP,{MLine(mmY,6+i)},{SetV(BColor[i+1],0x07),SetV(BColor3[i+1],0x0E),SetCD(MToggle[i+1],1)},{preserved})
            TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 296, 310)},{SetV(BColor2[i+1],0x07),SetCD(MToggle2[i+1],1)},{preserved})
            TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 275, 293)},{SetV(BColor4[i+1],0x07),SetCD(MToggle3[i+1],1)},{preserved})

            local temp,CDFnc = ToggleFunc({CD(MToggle[i+1],0),CD(MToggle[i+1],1)})--
            TriggerX(FP,{CD(MToggle2[i+1],1),CD(MStat,1)},{SetV(BColor2[i+1],0x08)},{preserved})
            TriggerX(FP,{CD(MToggle3[i+1],1),CD(MStat,1)},{SetV(BColor4[i+1],0x08)},{preserved})
            TriggerX(FP,{KeyPress(tostring(i+1), "Down")},{SetV(BColor2[i+1],0x08)},{preserved})

            TriggerX(FP,{CV(InterfaceNumLoc,1),CD(CDFnc,1)},{SetMemory(0x58F504,SetTo,i+1)},{preserved})
            TriggerX(FP,{CD(MToggle2[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000+i+1)},{preserved})
            TriggerX(FP,{CD(MToggle3[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10100+i+1)},{preserved})

            TriggerX(FP,{CV(InterfaceNumLoc,2),CD(CDFnc,1)},{SetMemory(0x58F504,SetTo,i+7)},{preserved})
            --TriggerX(FP,{CV(InterfaceNumLoc,2),CD(MToggle2[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000+i+7)},{preserved})

        end
        CMul(FP,UpgradeLoc,10)
        CMul(FP,ScoutDmgLoc,100)
        DisplayPrint(LCP, {"\x07�ɷ�ġ \x04����. \x10����Ű �Ǵ� ���콺Ŭ��\x04���� \x07���׷��̵�. ",ESCB[2],"[������ Ŭ�� �Ǵ� ESC]\x12",PRVB[2],"[���� ������(I)] \x07",InterfaceNumLoc," Page ",NEXB[2],"[���� ������(P)]"})--
        TriggerX(FP, CD(ResetStatLoc,0), {DisplayText("\x1F[�����ʱ�ȭ \x175000ũ���� \x081�ð��̳� 1ȸ�� \x04Ctrl+O\x1F] \x1F��밡��", 4)}, {preserved})
        TriggerX(FP, CD(ResetStatLoc,1), {DisplayText("\x1F[�����ʱ�ȭ \x175000ũ���� \x081�ð��̳� 1ȸ�� \x04Ctrl+O\x1F] \x08���Ұ�", 4)}, {preserved})



        CIfX(FP,{CV(InterfaceNumLoc,1)},{}) -- ���� ������ ����
            DisplayPrint(LCP, {"\x071. \x07�⺻���� \x08������ \x04+100 \x08(�ִ� 5000) - ",BColor3[1][2],Cost_Stat_ScDmg.." Pts\x12\x07 + ",BColor[1][2],ScoutDmgLoc," ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
            DisplayPrint(LCP, {"\x072. \x07�߰� �⺻���� \x041�� ���� \x04�ִ� 5�� - ",BColor3[2][2],Cost_Stat_AddSc.." Pts\x12\x07+ ",BColor[2][2],AddScLoc," �� ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
            DisplayPrint(LCP, {"\x073. \x1B���� ���� \x08������ \x04���� \x07+10% \x08(�ִ� +500%) - ",BColor3[3][2],Cost_Stat_Upgrade.." Pts\x12\x07+ ",BColor[3][2],UpgradeLoc," % ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
            DisplayPrint(LCP, {"\x074. \x07+1 \x08��ȭȮ�� \x0F0.1%p \x08MAX 100 \x04- ",BColor3[4][2],Cost_Stat_TotalEPer.." Pts\x12\x07+ ",BColor[4][2],E1VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E1VarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
            DisplayPrint(LCP, {"\x075. \x0F+2 \x08��ȭȮ�� \x0F0.1%p \x08MAX 50 \x04- ",BColor3[5][2],Cost_Stat_TotalEPer2.." Pts\x12\x07+ ",BColor[5][2],E2VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E2VarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
            DisplayPrint(LCP, {"\x076. \x10+3 \x08��ȭȮ�� \x0F0.1%p \x08MAX 30 \x04- ",BColor3[6][2],Cost_Stat_TotalEPer3.." Pts\x12\x07+ ",BColor[6][2],E3VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E3VarArr3," %p ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})
        
        CElseIfX({CV(InterfaceNumLoc,2)})
            CMov(FP,MCP,LCP)
            CallTriggerX(FP,Call_SetScrMouse,{},{})
            
            if TestStart == 1 then
                --DisplayPrintEr(0, {"�����ǥ X : ", mmX, "  Y : ", mmY, " || �߾����� X : ", mmX2, "  Y : ", mmY," || �������� X : ",mmX3,"  Y : ",mmY});
            end
            DisplayPrint(LCP, {"\x071. \x08Ư�� \x08��ȭȮ�� \x0F0.1%p \x08MAX 100 \x04- ",BColor3[1][2],Cost_Stat_TotalEPer4.." Pts\x12\x07+ ",BColor[1][2],E4VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E4VarArr3," %p ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
            DisplayPrint(LCP, {"\x072. \x08Ư�� \x1F�ı� ����\x08Ȯ�� \x0F0.1%p \x08MAX 500 \x04- ",BColor3[2][2],Cost_Stat_BreakShield.." Pts\x12\x07+ ",BColor[2][2],E5VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E5VarArr3," %p ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
            DisplayPrint(LCP, {"\x073. \x10�߰� \x07+1 \x08��ȭȮ�� \x0F0.1%p \x08MAX 30 \x04- ",BColor3[3][2],Cost_Stat_TotalEPerEx.." Pts\x12\x07+ ",BColor[3][2],E6VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E6VarArr3," %p ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
            CDoActions(FP, {TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n",4)})


        CIfXEnd()
        DoActions(FP,{SetCp(FP)})
        local StatPrintEr = {
            StrDesign("\x04���� ���۽� ó�� �����ϴ� \x07�⺻����(��ī��) \x08������\x04�� ������ŵ�ϴ�. \x08���� \x04: \x07�⺻����\x04�� 3�� �� ������ϴ�."),
            StrDesign("\x04���� ���۽� ó�� �����ϴ� \x07�⺻����(��ī��) \x0F����\x04�� ������ŵ�ϴ�. \x08���� \x04: \x07�⺻����\x04�� 3�� �� ������ϴ�."),
            StrDesign("\x04�ڽ��� \x07��ȭ \x04���� \x08������\x04�� ������ŵ�ϴ�."),
            StrDesign("\x07+1\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: \x07+2, \x10+3 \x04��ȭȮ���� ���� ������ \x08�����ϴ�."),
            StrDesign("\x07+2\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0F36�� \x04���� �̻���� +1�� ����˴ϴ�."),
            StrDesign("\x10+3\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0F35��\x04:\x08+2, \x0F36��\x04:\x08+1 \x04�� ����˴ϴ�."),
            StrDesign("\x08Ư��\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0841�� ���� ����\x04�� ����˴ϴ�."),
            StrDesign("\x08Ư��\x1F �ı� ����\x08Ȯ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0841�� ���� ����\x04�� ����˴ϴ�."),
            StrDesign("\x10�߰� \x07+1\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: ���� +1 ���� ��ȭȮ�� ������ \x07������ \x04�ϼž� �մϴ�."),
    }
    
        
    CIfEnd()
    for i = 0,6 do
        CIf(FP,{HumanCheck(i, 1)})
            CallTriggerX(FP,Call_Print13[i+1],{Deaths(i,AtLeast,1,20),Deaths(i,AtMost,#StatPrintEr,20)})
            for j = 1, #StatPrintEr do
                TriggerX(FP, {LocalPlayerID(i),Deaths(i,Exactly,j,20)}, {print_utf8(12,0,StatPrintEr[j])}, {preserved})
            end
        CIfEnd()
    end
    CIf(FP,{CV(InterfaceNumLoc,0)})--�ƹ� ����â�� �������� ���� ��� �۵���
    local temp,PKey = ToggleFunc({KeyPress("P","Up"),KeyPress("P","Down")},nil,1)--���� ��� ���� �������� ���� �� ǥ��
    local temp,KKey = ToggleFunc({KeyPress("K","Up"),KeyPress("K","Down")},nil,1)--���� ��� ���� ���� ��ȭ ǥ��
    local LKey = KeyToggleFunc("L") --���������� ǥ����
    local temp,BKey = ToggleFunc({KeyPress("B","Up"),KeyPress("B","Down")},nil,1)--���� ��� ���� ���
    local temp,NKey = ToggleFunc({KeyPress("N","Up"),KeyPress("N","Down")},nil,1)--���� ��� ���� ���
    local temp,MKey = ToggleFunc({KeyPress("M","Up"),KeyPress("M","Down")},nil,1)--���� ��� ���� ���
    local LToggle = CreateCcode()
    CTrigger(FP,{CD(PKey,1)},{SetCD(LKey,0)},1)
    CTrigger(FP,{CD(KKey,1)},{SetCD(LKey,0)},1)
    TriggerX(FP,{CD(BKey,1)},{SetCD(LKey,0)},{preserved})
    TriggerX(FP,{CD(NKey,1)},{SetCD(LKey,0)},{preserved})
    TriggerX(FP,{CD(MKey,1)},{SetCD(LKey,0)},{preserved})
    CTrigger(FP,{CD(PKey,0),CD(KKey,0),CD(LToggle,0),CD(LKey,0)},{SetCD(LToggle,1),TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n",4)},1)
    CTrigger(FP,{CD(LToggle,0),CD(LKey,0)},{SetCD(LToggle,1)},1)
    --CTrigger(FP,{CD(LToggle,0),CD(LKey,1)},{SetCD(LToggle,1),TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n\n",4)},1)
    CIf(FP,{CD(PKey,1)},{SetCD(LKey,0)})
    
    for i = 1, 6 do
        Byte_NumSet(TotalEPerLoc,E1VarArr1[i],10^(6-i),1,0x30)
        Byte_NumSet(TotalEPer2Loc,E2VarArr1[i],10^(6-i),1,0x30)
        Byte_NumSet(TotalEPer3Loc,E3VarArr1[i],10^(6-i),1,0x30)
        Byte_NumSet(TotalEPer4Loc,E4VarArr1[i],10^(6-i),1,0x30)
        Byte_NumSet(S_BreakShieldLoc,E5VarArr1[i],10^(6-i),1,0x30)
    end
    E1VarArr2 = {E1VarArr1[1],E1VarArr1[2],E1VarArr1[3]}
    E2VarArr2 = {E2VarArr1[1],E2VarArr1[2],E2VarArr1[3]}
    E3VarArr2 = {E3VarArr1[1],E3VarArr1[2],E3VarArr1[3]}
    E4VarArr2 = {E4VarArr1[1],E4VarArr1[2],E4VarArr1[3]}
    E5VarArr2 = {E5VarArr1[1],E5VarArr1[2],E5VarArr1[3]}
    E1VarArr3 = {E1VarArr1[4],E1VarArr1[5],E1VarArr1[6]}
    E2VarArr3 = {E2VarArr1[4],E2VarArr1[5],E2VarArr1[6]}
    E3VarArr3 = {E3VarArr1[4],E3VarArr1[5],E3VarArr1[6]}
    E4VarArr3 = {E4VarArr1[4],E4VarArr1[5],E4VarArr1[6]}
    E5VarArr3 = {E5VarArr1[4],E5VarArr1[5],E5VarArr1[6]}
    SetEPerStr(E1VarArr1)
    SetEPerStr(E2VarArr1)
    SetEPerStr(E3VarArr1)
    SetEPerStr(E4VarArr1)
    SetEPerStr(E5VarArr1)
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07+1 \x08��ȭȮ�� \x04�� ������ : \x07+ \x0F",E1VarArr2,".",E1VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07+2 \x08��ȭȮ�� \x04�� ������ : \x07+ \x0F",E2VarArr2,".",E2VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x10+3 \x08��ȭȮ�� \x04�� ������ : \x07+ \x0F",E3VarArr2,".",E3VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x08Ư�� \x08��ȭȮ�� \x04�� ������ : \x07+ \x08",E4VarArr2,".",E4VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x08Ư�� \x1F�ı� ����\x08Ȯ�� \x04�� ������ : \x07+ \x1F",E5VarArr2,".",E5VarArr3,"%p"})
    f_Mul(FP,EXPIncomeLoc2,10)
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x1C����ġ \x07�߰� \x04ȹ�淮 : \x07+ \x1C",EXPIncomeLoc2,"%"})
    f_Mul(FP,UpgradeUILoc,10)
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07�� \x08���ݷ� \x04������ : \x07+ \x08",UpgradeUILoc,"%"})
    
    
    
    
    
    
    
    
    CIfEnd()
    CIf(FP,{CD(KKey,1)},{SetCD(LKey,0)})
    
        CIf(FP,{CV(PlayTimeLoc2,1,AtLeast)})
        CMov(FP,CTimeV,PlayTimeLoc2)
        CallTrigger(FP,Call_ConvertTime)
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07�׽�Ʈ ���� �÷��� �ð� : \x04",CTimeDD,"�� ",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��"})
        CIfEnd()
        
        CMov(FP,CTimeV,PlayTimeLoc)
        CallTrigger(FP,Call_ConvertTime)
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07�� �ΰ��� �÷��� �ð� : \x04",CTimeDD,"�� ",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��"})
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07Ÿ�Ӿ��� ���� : \x04",TimeAttackScoreLoc})
        
        CIf(FP,CV(NextOreLoc,1,AtLeast))
            DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� ����� \x0ELV.1 \x07�� ������ ",NextOreMulLoc," \x08���׷��̵�\x04�� �ʿ��� \x1BDPS\x1F(�̳׶�)\x04 : \x1F",NextOreLoc})
        CIfEnd()
    
        CIf(FP,CV(NextGasLoc,1,AtLeast))
            DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� ����� \x0FLV.2 \x07�� ������ ",NextGasMulLoc," \x08���׷��̵�\x04�� �ʿ��� \x1BDPS\x07(����)\x04 : \x07",NextGasLoc,"\n\n\n"})
        CIfEnd()
    
    CIfEnd()
    
    CIfX(FP,{CD(LKey,1)})
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x17���� �Ǹű� \x04���� ���� \x08(����ȵ�) \x04: \x07",SellTicketLoc," \x17�ݱ� \x04: \x10L"})
        for i = 0, 6 do
            CIf(FP,HumanCheck(i, 1))
            CIfX(FP,{CV(LV5Cool[i+1],1,AtLeast)})
            CMov(FP,CTimeV,LV5Cool[i+1])
            CallTrigger(FP,Call_ConvertTime)
            DisplayPrint(LCP, {PName(i)," \x04���� \x1F���� LV.5 \x04óġ ���ɱ��� ���� �ð� \x04: \x07",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��  \x17�ݱ� \x04: \x10L"})
            CElseX()
            DisplayPrint(LCP, {PName(i)," \x04���� \x1F���� LV.5 \x04óġ ���ɱ��� ���� �ð� \x04: \x07óġ ����!  \x17�ݱ� \x04: \x10L"})
            CIfXEnd()
    
            CIfEnd()
        end
        CTrigger(FP,{CD(LToggle,1)},{SetCD(LToggle,0),TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n",4)},1)
    CIfXEnd()
    
    
    local PageNumLoc = CreateVar(FP)
    --local NKey = KeyToggleFunc("N")
    local TG = CreateCcode()
    local TG2 = CreateCcode()
    local PageT = {
        {--1������
            "\x13\x04\x1FDPS ��ȭ�ϱ� ���ӿ� ���Ű��� ȯ���մϴ�.",
            "\x13\x04�� ������ \x08������� �ǹ��� ����\x04�Ͽ� ���� �� �� \x0F�ڽ��� ������ ��ȭ\x04�ϸ� �� DPS�� ��ȭ�ϴ� �����Դϴ�.",
            "\x13\x04�� ó�� ������ �����Ͻø� �⺻������ ����� �ǹ��� ������ ���Դϴ�.",
            "\x13\x04\x08�ش������� ������ ��������\x04�� ���� \x1F���� �� �� �ֽ��ϴ�.",
            "\x13\x04���� ���� ����, \x17�ڱ� �ڽ� ������ ��ġ�� \x10����� ũ����Ż\x04���� ������ ������ �� �ֽ��ϴ�.(���� �̸� Ȯ��)",
            "\x13\x04���������� ������ ������ ����Ϳ� ���� ���� ���ų�, ��ܿ� ��ġ�� ������ �̵����� ��ȭ�� �� �ֽ��ϴ�.",
            "\x13\x04���� ��� ���ְ� ������� ���� ��� \x08���� ������ �Ұ���\x04�� �� ������ �����Ͻñ� �ٶ��ϴ�.",
        },
        {--2������
            "\x13\x04\x1B- \x03����� \x1B-",
            "\x13\x04\x03�����\x04���� \x08�ǹ��� ����\x04�� ��� \x1F���� ���޵� ���Դϴ�.",
            "\x13\x08LV.1 \x04�ǹ��� 1~25�� ����, \x0FLV.2 \x04�ǹ��� 26~40�� ����, \x11LV.MAX \x04�ǹ��� 41~44�� �������� ���� �����ϸ�",
            "\x13\x04������ �ǹ��� ���� DPS�� \x1F�̳׶�\x04, \x07����\x04�� Ȯ���մϴ�.",
            "\x13\x04(��, �̳׶��� ��� \x11LV.MAX\x04�� �ǹ��� �����ϴ� ���� \x1F�̳׶� \x04ǥ�Ⱑ \x11LV.MAX \x04�ǹ��� �����)",
            "\x13\x11LV.MAX \x04�ǹ��� ������ �� ������ �ǹ��� ���� DPS�� �޼��� ��� �� ���޷��� �����մϴ�.",
        },
        {
            "\x13\x04\x1B- \x08���� Ȯ��\x1B -",
            "\x13\x04\x08����Ȯ��\x04�̶� ��ȭ������ +1 �ܰ� ���� Ȯ���� �������̶�� ���̸�",
            "\x13\x04�⺻������ \x0F+2�� ���� Ȯ���� \x08����Ȯ��\x04�� 1/10, \x1F+3�� ���� Ȯ�� 1/100 \x04�� �ο��˴ϴ�.",
            "\x13\x04�� : \x08����Ȯ��\x04�� 50.0%�� ��� \x0F+2�� Ȯ���� 5.0% \x1F+3�� Ȯ���� 0.5% \x05����Ȯ���� 44.5%",
            "\x13\x04\x1937~40�� ����\x04�� ��� ���� +2, +3�� Ȯ���� \x08������� �ʰ� \x04+1�� Ȯ���� ����˴ϴ�.",
            "\x13\x04�� ���ֿ� ���� ��ȭȮ���� \x1C���� ���ݹ����� ���� ������\x04���� Ȯ���� �� ������",
            "\x13\x04�ٸ� �÷��̾��� ���� ��ȭ Ȯ���� ���� ������� Ȯ�� �����մϴ�."
        },
        {
            "\x13\x04\x1B- ���� �ý���, \x19SCA ���� \x1B-",
            "\x13\x04�� ���ӿ��� \x1B���� �ý���\x04�� �����մϴ�.",
            "\x13\x04Ư�� ��ȭ�ܰ� �̻� ������ \x1E�ǸŸ� ���� ����ġ\x04�� ȹ���� �� �ֽ��ϴ�.",
            "\x13\x04ȹ���� ����ġ�� ���� �������� �� ��� \x1FO Ű�� �Է�\x04�Ͽ� ��������Ʈ�� �й��ϸ� \x11���� �̷ο� ȿ��\x04�� ���� �� �ֽ��ϴ�.",
            "\x13\x04�� �׸��� \x19SCA����\x04�� ���� ���� �����ϸ� ���� ���ӿ��� ���� �����մϴ�.",
            "\x13\x04���� �������� ���� ����� \x1FP Ű\x04�� ���� Ȯ�� �����մϴ�.",
            "\x13\x04���� \x07SCA�� ���� ������ �׸�\x04�� ����, �й��� ����, ����ġ, ũ���� ������ ���̸� \x08�� ���� �׸��� ������ �� �����ϴ�.",
            "\x13\x04\x07���ǽð� 1�� ����ø��� �ڵ� ����\x04�Ǹ�, ���� ������ ���Ͻ� ��� \x17F9 ��ư\x04�� ������ ��������˴ϴ�.",
        },
        {
            "\x13\x04\x1B- ���� �ý��� 2 -",
            "\x13\x0426�� ���� ���ֺ��ʹ� �ǸŽ� ����ġ�� ���� ���������� \x17���� �Ǹű�\x04�� �ʿ��մϴ�.",
            "\x13\x04���� �Ǹű��� 100ũ���� �� 1���� �����ϰų� 5�ܰ� ���κ��� �������� ���� �� �ֽ��ϴ�.",
            "\x13\x04\x17���� �Ǹű�\x04�� ������ \x08������ �Ǹ��� �� �����ϴ�.",
            "\x13\x04���� \x17���� �Ǹű�\x08�� SCA ���� �Ұ��� ������\x04�Դϴ�. ���� �� ��� �Ҹ��ϴ°��� ����帳�ϴ�.",
        },
    
        {
            "\x13\x04\x1B- �η�. \x0E���� �÷��� ���ʽ�, ���� �ý��� \x1B-",
            "\x13\x04�� ���ӿ��� \x0E���� �÷��� ���ʽ� ����\x04�� �����մϴ�. ó�� �Ͻô� �е��� 2�� �̻� �÷��̸� \x08�ſ� �����մϴ�.",
            "\x13\x04\x1F2~7�� ���ʽ� ���� \x1C- \x08���ݷ� + 150%\x04, \x07+1�� \x17��ȭȮ�� + \x0F1.0%p",
            "\x13\x04\x08���� ���� ���� \x04������ 25�� ���� ���ָ� ���κ��� ���� �����ϸ� \x0F1�ʰ��� ������(DPS)\x04���� Ŭ���� ���θ� �����մϴ�.",
            "\x13\x04\x08���� ���� \x04������ 26�� ���ֺ��� ���� �����ϸ� \x081�а��� ������(DPM)\x04���� Ŭ���� ���θ� �����մϴ�.",
        },
    
    --���°� �� 250% ��Ȯ�� ���
        {
            "\x13\x04\x1B- �η�. \x08���� ���� ���� ���� ��� \x1B-",
            "\x041�ܰ� \x04: \x0F+1Ȯ��\x07+1.0%p \x1B����� \x07+3 \x12\x042�ܰ� \x04: \x0F+1Ȯ��\x07+1.0%p \x1B����� \x07+3",
            "\x043�ܰ� \x04: \x0F+1Ȯ��\x07+1.0%p \x1B����� \x07+3, \x08��+50% \x12\x044�ܰ� \x04: \x1B����� \x07+6, \x08���ݷ� + 50%, \x1C�߰�EXP +10%",
            "\x045�ܰ� \x04: \x1B����� \x07+9, \x08��+50%, \x1CEXP+10%, \x17���� �Ǹű� 5��\x12\x046�ܰ� : \x1720�� ũ����, \x10Ÿ�̸�\x04 6�ð�����\x1CEXP+10%\x08(1ȸ����)",
            "\x045�ܰ� ���� ������ \x17���� �Ǹű�\x04��\x07 \x082���̻� �÷��� \x04or \x07��Ƽ 1�ð� ����\x04�� �� \x08�ַ� �÷��� \x04�� ȹ�� �����մϴ�.",
            "\x046�ܰ� ���κ����� \x08��Ƽ ���� 5�ܰ�\x04�� \x071ȸ �̻� óġ\x04�ؾ� �����մϴ�."
        },
    
        {
            "\x13\x04\x1B- �η�. \x08��Ƽ ���� ���� ���� ��� \x1B-",
            "\x041�ܰ� \x04: \x0F+1Ȯ�� \x07+1.0%p, \x1B����� \x07+6,",
            "\x042�ܰ� \x04: \x0F+1Ȯ�� \x07+1.0%p, \x1B����� \x07+6,\x08���ݷ� + 50%, \x17ũ���� +500",
            "\x043�ܰ� \x04: \x17ũ���� +1,000, \x1C�߰�EXP +30%",
            "\x044�ܰ� \x04: \x17���� �Ǹű� + 50, \x08���ݷ� + 50%, ",
            "\x045�ܰ� \x04: \x04�� 5ȸ óġ ����. �� \x175��, 4��, 3��, 2��, 1�� ũ����",
            "\x045�ܰ� ������ óġ�� \x088�ð��� �ΰ��� ��Ÿ��\x04�� �����մϴ�."
        },
    }
    CIf(FP,TTOR({CD(BKey,1),CD(NKey,1),CD(MKey,1)}))
    TriggerX(FP,{CD(NKey,1)},{SetCD(TG2,1)},{preserved})
    TriggerX(FP,{CD(BKey,1)},{SubV(PageNumLoc,1),SetCD(TG,1)},{preserved})
    TriggerX(FP,{CD(MKey,1)},{AddV(PageNumLoc,1),SetCD(TG,1)},{preserved})
    TriggerX(FP,{CD(TG2,1),CD(TG,0),CD(NKey,1)},{SetCD(TG,1),SetCD(TG2,0)},{preserved})
    TriggerX(FP,{CD(TG2,1),CD(TG,1),CD(NKey,1)},{SetCD(TG,0),SetCD(TG2,0)},{preserved})
    
    
    
    TriggerX(FP,{CV(PageNumLoc,0)},{SetV(PageNumLoc,1)},{preserved})
    TriggerX(FP,{CV(PageNumLoc,#PageT+1,AtLeast)},{SetV(PageNumLoc,#PageT)},{preserved})
    CIf(FP,CD(TG,1))
    DisplayPrint(LCP, {"\x13\x04[\x0FPrev \x04: \x17B\x04] [\x07Page \x04: \x10",PageNumLoc," \x08����/�ݱ�\x04 : \x17N\x04] [\x11Next \x04: \x17M\x04]"})
    for j,k in pairs(PageT) do
        local t = {}
        for i = 1, 7 do
            if k[i]~= nil then
                t[i] = k[i].."\n"
            else
                t[i] = "\n"
            end
        end
        TriggerX(FP, {CV(PageNumLoc,j)}, {DisplayText(table.concat(t), 4)}, {preserved})
    end
    CIfEnd()
    CTrigger(FP,{CD(TG,0)},{TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n\n\n\n\n\n",4)},1)
    
    
    CIfEnd()
    
    
    CIfEnd()
    
    CMov(FP,0x6509B0,FP)
    FixText(FP, 2)    
end