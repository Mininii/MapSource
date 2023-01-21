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
        local LVData = {{{0,9},{"０",{0x1000000}}}} 
        local StatEffT = CreateCcode()
        local InterfaceNumLoc2 = CreateCcode()
        DoActionsX(FP,AddCD(StatEffT,1))
        
        CA__SetValue(Str1,"\x07보유금액 \x04:  0000\x04경0000\x04조0000\x04억0000\x04만0000 \x04원\x12\x07사냥터\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
        --43
        --49
        CS__ItoCustom(FP,SVA1(Str1,40),IncomeLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
        CS__ItoCustom(FP,SVA1(Str1,46),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x190",0x19,{0,1})
        CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1C,0x1C,0x1C,0x1C,0x03,0x03,0x03,0x03},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0}})
    
        --CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x04,0x04,0x04},{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
        CA__InputVA(56*0,Str1,Str1s,nil,56*0,56*1-2)
        CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
        CA__SetValue(Str1,"\x07ＬＶ．\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04－\x0FＥＸＰ\x04：",nil,1)
        
        CS__ItoCustom(FP,SVA1(Str1,4),LevelLoc,nil,nil,{10,5},1,nil,"\x1B0",0x1B,nil, LVData)
        local Tabkey = KeyToggleFunc2("TAB","LCTRL")
        CIfX(FP,{CD(Tabkey,1)})--수치표기
        CIfX(FP,{CV(LevelLoc,49999,AtMost)})
        CElseX({TSetNWar(ExpLoc, SetTo, "0"),TSetNWar(TotalExpLoc, SetTo, "0")})
        CIfXEnd()
        CA__lItoCustom(SVA1(Str1,16),ExpLoc,nil,nil,{10,14},nil,nil,"\x040",{0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
        CA__Input(MakeiStrData("\x08／",1),SVA1(Str1,32))
        CA__lItoCustom(SVA1(Str1,34),TotalExpLoc,nil,nil,{10,14},nil,nil,"\x040",{0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
        CElseX()--퍼센트표기
        local CurExpTmp = CreateVar(FP)
        local CurExpTmp2 = CreateWar(FP)
        CIfX(FP,{CV(LevelLoc,49999,AtMost)})
        f_LMul(FP, CurExpTmp2,ExpLoc, "20")
        f_Cast(FP, {CurExpTmp,0}, _LDiv(CurExpTmp2,TotalExpLoc), nil, nil, 1)
        CElseX({SetV(CurExpTmp,20)})
        CIfXEnd()
        CA__SetValue(Str1,"\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x17(Ctrl+TAB:세부값)",nil,16)
        for i = 0, 19 do
            CS__InputTA(FP,{CV(CurExpTmp,i+1,AtLeast)},SVA1(Str1,16+i),0x07,0xFF)
        end
        CIfXEnd()
        TriggerX(FP,{CD(StatEffLoc,1),CD(StatEffT,2,AtLeast)},{SetCD(StatEffT,0),SetCSVA1(SVA1(Str1,0),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,1),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,2),SetTo,0x04,0xFF)},{preserved})
        CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)
        CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
        CA__SetValue(Str1,"\x12포인트 \x04:  000,000 \x04| \x17크레딧 \x04:  12\x04,123\x04,123\x04,123\x04,123\x04,123\x04,123",nil,1)
        CA__lItoCustom(SVA1(Str1,25),CredLoc,nil,nil,10,1,nil,"\x040",{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x02,0x1E,0x1E,0x1E,0x05,0x05,0x05}
        ,{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
        CS__ItoCustom(FP,SVA1(Str1,8),StatPLoc,nil,nil,{10,6},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6}, nil,{0,0,{0},0,0,{0}})
    
        
    
        CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-2)
        CIfX(FP,{CD(Tabkey,1)})--수치표기
        CA__SetColor((56*2)+1, 0x17)
        CA__SetColor((56*2)+19, 0x10)
        CElseX()--퍼센트표기
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
        mmX = mouseX -- 상대좌표 좌측정렬
        mmY = mouseY
        mmX2 = screenX -- 중앙정렬
        mmX3 = screenX2 -- 중앙정렬
        if TestStart == 1 then
           --DisplayPrintEr(0, {"상대좌표 X : ", mmX, "  Y : ", mmY, " || 중앙정렬 X : ", mmX2, "  Y : ", mmY," || 우측정렬 X : ",mmX3,"  Y : ",mmY});
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
        --296~310 각 스탯찍기 버튼
        --274~388 상대좌표 나가기버튼
        
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
        DisplayPrint(LCP, {"\x07능력치 \x04설정. \x10숫자키 또는 마우스클릭\x04으로 \x07업그레이드. ",ESCB[2],"[나가기 클릭 또는 ESC]\x12",PRVB[2],"[이전 페이지(I)] \x07",InterfaceNumLoc," Page ",NEXB[2],"[다음 페이지(P)]"})--
        TriggerX(FP, CD(ResetStatLoc,0), {DisplayText("\x1F[스탯초기화 \x175000크레딧 \x081시간이내 1회만 \x04Ctrl+O\x1F] \x1F사용가능", 4)}, {preserved})
        TriggerX(FP, CD(ResetStatLoc,1), {DisplayText("\x1F[스탯초기화 \x175000크레딧 \x081시간이내 1회만 \x04Ctrl+O\x1F] \x08사용불가", 4)}, {preserved})



        CIfX(FP,{CV(InterfaceNumLoc,1)},{}) -- 상점 페이지 제어
            DisplayPrint(LCP, {"\x071. \x07기본유닛 \x08데미지 \x04+100 \x08(최대 5000) - ",BColor3[1][2],Cost_Stat_ScDmg.." Pts\x12\x07 + ",BColor[1][2],ScoutDmgLoc," ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
            DisplayPrint(LCP, {"\x072. \x07추가 기본유닛 \x041기 증가 \x04최대 5기 - ",BColor3[2][2],Cost_Stat_AddSc.." Pts\x12\x07+ ",BColor[2][2],AddScLoc," 기 ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
            DisplayPrint(LCP, {"\x073. \x1B보유 유닛 \x08데미지 \x04증가 \x07+10% \x08(최대 +500%) - ",BColor3[3][2],Cost_Stat_Upgrade.." Pts\x12\x07+ ",BColor[3][2],UpgradeLoc," % ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
            DisplayPrint(LCP, {"\x074. \x07+1 \x08강화확률 \x0F0.1%p \x08MAX 100 \x04- ",BColor3[4][2],Cost_Stat_TotalEPer.." Pts\x12\x07+ ",BColor[4][2],E1VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E1VarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
            DisplayPrint(LCP, {"\x075. \x0F+2 \x08강화확률 \x0F0.1%p \x08MAX 50 \x04- ",BColor3[5][2],Cost_Stat_TotalEPer2.." Pts\x12\x07+ ",BColor[5][2],E2VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E2VarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
            DisplayPrint(LCP, {"\x076. \x10+3 \x08강화확률 \x0F0.1%p \x08MAX 30 \x04- ",BColor3[6][2],Cost_Stat_TotalEPer3.." Pts\x12\x07+ ",BColor[6][2],E3VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E3VarArr3," %p ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})
        
        CElseIfX({CV(InterfaceNumLoc,2)})
            CMov(FP,MCP,LCP)
            CallTriggerX(FP,Call_SetScrMouse,{},{})
            
            if TestStart == 1 then
                --DisplayPrintEr(0, {"상대좌표 X : ", mmX, "  Y : ", mmY, " || 중앙정렬 X : ", mmX2, "  Y : ", mmY," || 우측정렬 X : ",mmX3,"  Y : ",mmY});
            end
            DisplayPrint(LCP, {"\x071. \x08특수 \x08강화확률 \x0F0.1%p \x08MAX 100 \x04- ",BColor3[1][2],Cost_Stat_TotalEPer4.." Pts\x12\x07+ ",BColor[1][2],E4VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E4VarArr3," %p ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
            DisplayPrint(LCP, {"\x072. \x08특수 \x1F파괴 방지\x08확률 \x0F0.1%p \x08MAX 500 \x04- ",BColor3[2][2],Cost_Stat_BreakShield.." Pts\x12\x07+ ",BColor[2][2],E5VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E5VarArr3," %p ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
            DisplayPrint(LCP, {"\x073. \x10추가 \x07+1 \x08강화확률 \x0F0.1%p \x08MAX 30 \x04- ",BColor3[3][2],Cost_Stat_TotalEPerEx.." Pts\x12\x07+ ",BColor[3][2],E6VarArr2,"\x0D.\x0D\x0D\x0D\x0D\x0D",E6VarArr3," %p ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
            CDoActions(FP, {TSetMemory(0x6509B0,SetTo,LCP),DisplayText("\n\n\n",4)})


        CIfXEnd()
        DoActions(FP,{SetCp(FP)})
        local StatPrintEr = {
            StrDesign("\x04게임 시작시 처음 지급하는 \x07기본유닛(스카웃) \x08데미지\x04를 증가시킵니다. \x08주의 \x04: \x07기본유닛\x04은 3분 뒤 사라집니다."),
            StrDesign("\x04게임 시작시 처음 지급하는 \x07기본유닛(스카웃) \x0F갯수\x04를 증가시킵니다. \x08주의 \x04: \x07기본유닛\x04은 3분 뒤 사라집니다."),
            StrDesign("\x04자신의 \x07강화 \x04유닛 \x08데미지\x04를 증가시킵니다."),
            StrDesign("\x07+1\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: \x07+2, \x10+3 \x04강화확률에 대한 영향은 \x08없습니다."),
            StrDesign("\x07+2\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0F36강 \x04유닛 이상부터 +1만 적용됩니다."),
            StrDesign("\x10+3\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0F35강\x04:\x08+2, \x0F36강\x04:\x08+1 \x04만 적용됩니다."),
            StrDesign("\x08특수\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0841강 이후 유닛\x04만 적용됩니다."),
            StrDesign("\x08특수\x1F 파괴 방지\x08확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0841강 이후 유닛\x04만 적용됩니다."),
            StrDesign("\x10추가 \x07+1\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 먼저 +1 기존 강화확률 스탯을 \x07마스터 \x04하셔야 합니다."),
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
    CIf(FP,{CV(InterfaceNumLoc,0)})--아무 설정창도 켜져있지 않을 경우 작동함
    local temp,PKey = ToggleFunc({KeyPress("P","Up"),KeyPress("P","Down")},nil,1)--누를 경우 현재 적용중인 버프 상세 표기
    local temp,KKey = ToggleFunc({KeyPress("K","Up"),KeyPress("K","Down")},nil,1)--누를 경우 현재 보유 재화 표시
    local LKey = KeyToggleFunc("L") --지속적으로 표기함
    local temp,BKey = ToggleFunc({KeyPress("B","Up"),KeyPress("B","Down")},nil,1)--누를 경우 설명서 출력
    local temp,NKey = ToggleFunc({KeyPress("N","Up"),KeyPress("N","Down")},nil,1)--누를 경우 설명서 출력
    local temp,MKey = ToggleFunc({KeyPress("M","Up"),KeyPress("M","Down")},nil,1)--누를 경우 설명서 출력
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
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07+1 \x08강화확률 \x04총 증가량 : \x07+ \x0F",E1VarArr2,".",E1VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07+2 \x08강화확률 \x04총 증가량 : \x07+ \x0F",E2VarArr2,".",E2VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x10+3 \x08강화확률 \x04총 증가량 : \x07+ \x0F",E3VarArr2,".",E3VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x08특수 \x08강화확률 \x04총 증가량 : \x07+ \x08",E4VarArr2,".",E4VarArr3,"%p"})
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x08특수 \x1F파괴 방지\x08확률 \x04총 증가량 : \x07+ \x1F",E5VarArr2,".",E5VarArr3,"%p"})
    f_Mul(FP,EXPIncomeLoc2,10)
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x1C경험치 \x07추가 \x04획득량 : \x07+ \x1C",EXPIncomeLoc2,"%"})
    f_Mul(FP,UpgradeUILoc,10)
    DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07총 \x08공격력 \x04증가량 : \x07+ \x08",UpgradeUILoc,"%"})
    
    
    
    
    
    
    
    
    CIfEnd()
    CIf(FP,{CD(KKey,1)},{SetCD(LKey,0)})
    
        CIf(FP,{CV(PlayTimeLoc2,1,AtLeast)})
        CMov(FP,CTimeV,PlayTimeLoc2)
        CallTrigger(FP,Call_ConvertTime)
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07테스트 버전 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
        CIfEnd()
        
        CMov(FP,CTimeV,PlayTimeLoc)
        CallTrigger(FP,Call_ConvertTime)
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07총 인게임 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07타임어택 점수 : \x04",TimeAttackScoreLoc})
        
        CIf(FP,CV(NextOreLoc,1,AtLeast))
            DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 사냥터 \x0ELV.1 \x07돈 증가량 ",NextOreMulLoc," \x08업그레이드\x04에 필요한 \x1BDPS\x1F(미네랄)\x04 : \x1F",NextOreLoc})
        CIfEnd()
    
        CIf(FP,CV(NextGasLoc,1,AtLeast))
            DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 사냥터 \x0FLV.2 \x07돈 증가량 ",NextGasMulLoc," \x08업그레이드\x04에 필요한 \x1BDPS\x07(가스)\x04 : \x07",NextGasLoc,"\n\n\n"})
        CIfEnd()
    
    CIfEnd()
    
    CIfX(FP,{CD(LKey,1)})
        DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x17유닛 판매권 \x04보유 갯수 \x08(저장안됨) \x04: \x07",SellTicketLoc," \x17닫기 \x04: \x10L"})
        for i = 0, 6 do
            CIf(FP,HumanCheck(i, 1))
            CIfX(FP,{CV(LV5Cool[i+1],1,AtLeast)})
            CMov(FP,CTimeV,LV5Cool[i+1])
            CallTrigger(FP,Call_ConvertTime)
            DisplayPrint(LCP, {PName(i)," \x04님의 \x1F보스 LV.5 \x04처치 가능까지 남은 시간 \x04: \x07",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초  \x17닫기 \x04: \x10L"})
            CElseX()
            DisplayPrint(LCP, {PName(i)," \x04님의 \x1F보스 LV.5 \x04처치 가능까지 남은 시간 \x04: \x07처치 가능!  \x17닫기 \x04: \x10L"})
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
        {--1페이지
            "\x13\x04\x1FDPS 강화하기 게임에 오신것을 환영합니다.",
            "\x13\x04이 게임은 \x08사냥터의 건물을 공격\x04하여 돈을 번 후 \x0F자신의 유닛을 강화\x04하며 총 DPS를 강화하는 게임입니다.",
            "\x13\x04맨 처음 게임을 시작하시면 기본유닛이 사냥터 건물을 공격할 것입니다.",
            "\x13\x04\x08해당유닛이 공격한 데미지량\x04에 따라 \x1F돈을 벌 수 있습니다.",
            "\x13\x04벌은 돈을 통해, \x17자기 자신 영역에 위치한 \x10우라즈 크리스탈\x04에서 유닛을 구입할 수 있습니다.(유닛 이름 확인)",
            "\x13\x04마찬가지로 구입한 유닛을 사냥터에 보내 돈을 벌거나, 상단에 위치한 곳으로 이동시켜 강화할 수 있습니다.",
            "\x13\x04만약 모든 유닛과 전재산을 잃을 경우 \x08게임 진행이 불가능\x04할 수 있으니 유의하시기 바랍니다.",
        },
        {--2페이지
            "\x13\x04\x1B- \x03사냥터 \x1B-",
            "\x13\x04\x03사냥터\x04에서 \x08건물을 공격\x04할 경우 \x1F돈이 지급될 것입니다.",
            "\x13\x08LV.1 \x04건물은 1~25강 유닛, \x0FLV.2 \x04건물은 26~40강 유닛, \x11LV.MAX \x04건물은 41~44강 유닛으로 입장 가능하며",
            "\x13\x04각각의 건물에 대한 DPS는 \x1F미네랄\x04, \x07가스\x04로 확인합니다.",
            "\x13\x04(단, 미네랄의 경우 \x11LV.MAX\x04의 건물을 공격하는 순간 \x1F미네랄 \x04표기가 \x11LV.MAX \x04건물로 변경됨)",
            "\x13\x11LV.MAX \x04건물을 제외한 각 레벨의 건물은 일정 DPS를 달성할 경우 돈 지급량이 증가합니다.",
        },
        {
            "\x13\x04\x1B- \x08기준 확률\x1B -",
            "\x13\x04\x08기준확률\x04이란 강화성공시 +1 단계 증가 확률이 기준점이라는 뜻이며",
            "\x13\x04기본적으로 \x0F+2강 증가 확률은 \x08기준확률\x04의 1/10, \x1F+3강 증가 확률 1/100 \x04가 부여됩니다.",
            "\x13\x04예 : \x08기준확률\x04이 50.0%일 경우 \x0F+2강 확률은 5.0% \x1F+3강 확률은 0.5% \x05실패확률은 44.5%",
            "\x13\x04\x1937~40강 유닛\x04의 경우 위의 +2, +3강 확률이 \x08적용되지 않고 \x04+1강 확률로 적용됩니다.",
            "\x13\x04각 유닛에 대한 강화확률은 \x1C유닛 공격무기의 좌측 아이콘\x04에서 확인할 수 있으며",
            "\x13\x04다른 플레이어의 유닛 강화 확률도 같은 방법으로 확인 가능합니다."
        },
        {
            "\x13\x04\x1B- 레벨 시스템, \x19SCA 런쳐 \x1B-",
            "\x13\x04이 게임에는 \x1B레벨 시스템\x04이 존재합니다.",
            "\x13\x04특정 강화단계 이상 유닛은 \x1E판매를 통해 경험치\x04를 획득할 수 있습니다.",
            "\x13\x04획득한 경험치를 통해 레벨업을 할 경우 \x1FO 키를 입력\x04하여 스탯포인트를 분배하면 \x11각종 이로운 효과\x04를 얻을 수 있습니다.",
            "\x13\x04이 항목은 \x19SCA런쳐\x04를 통해 저장 가능하며 다음 게임에서 적용 가능합니다.",
            "\x13\x04현재 적용중인 버프 목록은 \x1FP 키\x04를 통해 확인 가능합니다.",
            "\x13\x04현재 \x07SCA로 저장 가능한 항목\x04은 레벨, 분배한 스탯, 경험치, 크레딧 보유량 등이며 \x08그 외의 항목은 저장할 수 없습니다.",
            "\x13\x04\x07현실시간 1분 경과시마다 자동 저장\x04되며, 수동 저장을 원하실 경우 \x17F9 버튼\x04을 누르면 수동저장됩니다.",
        },
        {
            "\x13\x04\x1B- 레벨 시스템 2 -",
            "\x13\x0426강 이후 유닛부터는 판매시 경험치가 대폭 증가하지만 \x17유닛 판매권\x04이 필요합니다.",
            "\x13\x04유닛 판매권은 100크레딧 당 1개로 구입하거나 5단계 개인보스 공략으로 얻을 수 있습니다.",
            "\x13\x04\x17유닛 판매권\x04이 없으면 \x08유닛을 판매할 수 없습니다.",
            "\x13\x04또한 \x17유닛 판매권\x08은 SCA 저장 불가능 아이템\x04입니다. 종료 전 모두 소모하는것을 권장드립니다.",
        },
    
        {
            "\x13\x04\x1B- 부록. \x0E다인 플레이 보너스, 보스 시스템 \x1B-",
            "\x13\x04이 게임에는 \x0E다인 플레이 보너스 버프\x04가 존재합니다. 처음 하시는 분들은 2인 이상 플레이를 \x08매우 권장합니다.",
            "\x13\x04\x1F2~7인 보너스 버프 \x1C- \x08공격력 + 150%\x04, \x07+1강 \x17강화확률 + \x0F1.0%p",
            "\x13\x04\x08개인 보스 몬스터 \x04지역은 25강 이하 유닛만 개인별로 공략 가능하며 \x0F1초간의 데미지(DPS)\x04으로 클리어 여부를 결정합니다.",
            "\x13\x04\x08보스 몬스터 \x04지역은 26강 유닛부터 입장 가능하며 \x081분간의 데미지(DPM)\x04으로 클리어 여부를 결정합니다.",
        },
    
    --남는거 공 250% 강확은 논외
        {
            "\x13\x04\x1B- 부록. \x08개인 보스 몬스터 보상 목록 \x1B-",
            "\x041단계 \x04: \x0F+1확률\x07+1.0%p \x1B사냥터 \x07+3 \x12\x042단계 \x04: \x0F+1확률\x07+1.0%p \x1B사냥터 \x07+3",
            "\x043단계 \x04: \x0F+1확률\x07+1.0%p \x1B사냥터 \x07+3, \x08공+50% \x12\x044단계 \x04: \x1B사냥터 \x07+6, \x08공격력 + 50%, \x1C추가EXP +10%",
            "\x045단계 \x04: \x1B사냥터 \x07+9, \x08공+50%, \x1CEXP+10%, \x17유닛 판매권 5개\x12\x046단계 : \x1720만 크레딧, \x10타이머\x04 6시간동안\x1CEXP+10%\x08(1회한정)",
            "\x045단계 보스 보상인 \x17유닛 판매권\x04은\x07 \x082인이상 플레이 \x04or \x07멀티 1시간 유지\x04한 후 \x08솔로 플레이 \x04시 획득 가능합니다.",
            "\x046단계 개인보스는 \x08파티 보스 5단계\x04를 \x071회 이상 처치\x04해야 출현합니다."
        },
    
        {
            "\x13\x04\x1B- 부록. \x08파티 보스 몬스터 보상 목록 \x1B-",
            "\x041단계 \x04: \x0F+1확률 \x07+1.0%p, \x1B사냥터 \x07+6,",
            "\x042단계 \x04: \x0F+1확률 \x07+1.0%p, \x1B사냥터 \x07+6,\x08공격력 + 50%, \x17크레딧 +500",
            "\x043단계 \x04: \x17크레딧 +1,000, \x1C추가EXP +30%",
            "\x044단계 \x04: \x17유닛 판매권 + 50, \x08공격력 + 50%, ",
            "\x045단계 \x04: \x04총 5회 처치 가능. 각 \x175만, 4만, 3만, 2만, 1만 크레딧",
            "\x045단계 보스는 처치후 \x088시간의 인게임 쿨타임\x04이 존재합니다."
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
    DisplayPrint(LCP, {"\x13\x04[\x0FPrev \x04: \x17B\x04] [\x07Page \x04: \x10",PageNumLoc," \x08열기/닫기\x04 : \x17N\x04] [\x11Next \x04: \x17M\x04]"})
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