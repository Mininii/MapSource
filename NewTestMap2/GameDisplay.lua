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
	local S_TotalEPerEx2Loc = iv.S_TotalEPerEx2Loc--CreateVar(FP)
	local S_TotalEPerEx3Loc = iv.S_TotalEPerEx3Loc--CreateVar(FP)
	local S_TotalEPer2Loc = iv.S_TotalEPer2Loc--CreateVar(FP)
	local S_TotalEPer3Loc = iv.S_TotalEPer3Loc--CreateVar(FP)
	local S_TotalEPer4Loc = iv.S_TotalEPer4Loc--CreateVar(FP)
	local S_BreakShieldLoc = iv.S_BreakShieldLoc--CreateVar(FP)
	local BreakShieldLoc = iv.BreakShieldLoc--CreateVar(FP)
	local S_LV3IncmLoc = iv.S_LV3IncmLoc
	local S_BossSTicLoc = iv.S_BossSTicLoc
	local S_BossLVUPLoc = iv.S_BossLVUPLoc
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
	local S_TotalEPer4XLoc = iv.S_TotalEPer4XLoc
	local S_BreakShield2Loc = iv.S_BreakShield2Loc
	local ResetStatLoc = iv.ResetStatLoc
	local ResetStat2Loc = iv.ResetStat2Loc
	local UpgradeUILoc = iv.UpgradeUILoc--CreateVar(FP)
	local NextOreLoc = iv.NextOreLoc
	local NextGasLoc = iv.NextGasLoc
	local NextOreMulLoc = iv.NextOreMulLoc
	local NextGasMulLoc = iv.NextGasMulLoc
	local SellTicketLoc = iv.SellTicketLoc
	local TimeAttackScoreLoc = iv.TimeAttackScoreLoc
	local TimeAttackScore48Loc = iv.TimeAttackScore48Loc
	local CS_CooldownLoc = iv.CS_CooldownLoc
	local CS_AtkLoc = iv.CS_AtkLoc
	local CS_EXPLoc = iv.CS_EXPLoc
	local CS_TotalEPerLoc = iv.CS_TotalEPerLoc
	local CS_TotalEper4Loc = iv.CS_TotalEper4Loc
	local CS_DPSLVLoc = iv.CS_DPSLVLoc
	local VaccItemLoc = iv.VaccItemLoc
	local SCCoolLoc = iv.SCCoolLoc

	local PETicketLoc = iv.PETicketLoc
	local LV5Cool = iv.LV5Cool
	local MoneyLoc2 = iv.MoneyLoc2

	local FXPer44Loc = iv.FXPer44Loc
	local FXPer45Loc = iv.FXPer45Loc
	local FXPer46Loc = iv.FXPer46Loc
	local FXPer47Loc = iv.FXPer47Loc
	local FXPer48Loc = iv.FXPer48Loc
	local FIncmLoc = iv.FIncmLoc
	local FSEXPLoc = iv.FSEXPLoc
	local FMEPerLoc = iv.FMEPerLoc
	local FBrShLoc = iv.FBrShLoc
	local FMinLoc = iv.FMinLoc
	local XEPer44Loc = iv.XEPer44Loc
	local XEPer45Loc = iv.XEPer45Loc
	local XEPer46Loc = iv.XEPer46Loc
	local XEPer47Loc = iv.XEPer47Loc
	local XEPer48Loc = iv.XEPer48Loc
	local CXEPerLoc = iv.CXEPerLoc
	local CMEPerLoc = iv.CMEPerLoc
	local CBrShLoc = iv.CBrShLoc
	local Stat_BossSFrgLoc = iv.Stat_BossSFrgLoc
	local Stat_XEPer44Loc = iv.Stat_XEPer44Loc
	local Stat_XEPer45Loc = iv.Stat_XEPer45Loc
	local Stat_XEPer46Loc = iv.Stat_XEPer46Loc
	local Stat_XEPer47Loc = iv.Stat_XEPer47Loc
	local TempIncmLoc = iv.TempIncmLoc
	local Cost_FXPer44Loc = iv.Cost_FXPer44Loc
	local Cost_FIncmLoc = iv.Cost_FIncmLoc
	local Cost_FXPer45Loc = iv.Cost_FXPer45Loc
	local Cost_FSEXPLoc = iv.Cost_FSEXPLoc
	local Cost_FXPer46Loc = iv.Cost_FXPer46Loc
	local Cost_FBrShLoc = iv.Cost_FBrShLoc
	local Cost_FXPer47Loc = iv.Cost_FXPer47Loc
	local Cost_FMEPerLoc = iv.Cost_FMEPerLoc
	local Cost_FXPer48Loc = iv.Cost_FXPer48Loc
	local Cost_FMinLoc = iv.Cost_FMinLoc
	
	local TempFf = CreateWar(FP)
	local TempFf2 = CreateVar(FP)

	function TEST() 
		local PlayerID = CAPrintPlayerID 
		local LVData = {{{0,9},{"��",{0x1000000}}}} 
		local StatEffT = CreateCcode()
		local InterfaceNumLoc2 = CreateCcode()
		DoActionsX(FP,AddCD(StatEffT,1))
		
		CA__SetValue(Str1,"\x07�����ݾ� \x04:  0000\x04��0000\x04��0000\x04��0000\x04��0000\x0D\x04��\x12\x07�����\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)

		CA__SetValue(Str2,"\x07�����ݾ� \x04: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D \x04��\x12\x17õ�棺 00000000 \x04�� \x07�����\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
		--43
		--49
		CS__ItoCustom(FP,SVA1(Str2,40),IncomeLoc,nil,nil,{10,2},1,nil,"\x1B0",0x1B,{0,1})
		CS__ItoCustom(FP,SVA1(Str2,46),IncomeMaxLoc,nil,nil,{10,2},1,nil,"\x190",0x19,{0,1})
		CS__ItoCustom(FP,SVA1(Str2,23),MoneyLoc2,nil,nil,{10,8},1,nil,"\x170",0x17)
		CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,nil,nil,"\x040",{0x1B,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x1D,0x1C,0x1C,0x1C,0x1C,0x03,0x03,0x03,0x03},{0,1,2,3,5,6,7,8,10,11,12,13,15,16,17,18,20,21,22,23},nil,{0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0},0,0,0,{0}})
		
		CIfX(FP, {TTNWar(MoneyLoc, AtLeast, "10000000000000000")})
			CA__InputSVA1(SVA1(Str2,8),SVA1(Str1,9),10,0xFFFFFFFF,1,Str1s)
		CElseIfX({TTNWar(MoneyLoc, AtLeast, "1000000000000")})
			CA__InputSVA1(SVA1(Str2,8),SVA1(Str1,14),10,0xFFFFFFFF,1,Str1s)
		CElseIfX({TTNWar(MoneyLoc, AtLeast, "100000000")})
			CA__InputSVA1(SVA1(Str2,8),SVA1(Str1,19),10,0xFFFFFFFF,1,Str1s)
		CElseIfX({TTNWar(MoneyLoc, AtLeast, "10000")})
			CA__InputSVA1(SVA1(Str2,8),SVA1(Str1,24),10,0xFFFFFFFF,1,Str1s)
		CElseX()
			CA__InputSVA1(SVA1(Str2,8),SVA1(Str1,29),5,0xFFFFFFFF,1,Str1s)
		CIfXEnd()
		
		CIf(FP,{CV(MoneyLoc2,0)})
			CA__SetValue(Str2, "\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x12", nil, 20)
		CIfEnd()
	
		--CA__lItoCustom(SVA1(Str1,8),MoneyLoc,nil,nil,10,1,nil,{"\x1F\x0D","\x08\x0D","\x040"},{0x04,0x04,0x1B,0x1B,0x1B,0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x2,0x1E,0x1E,0x1E,0x04,0x04,0x04},{0,1,3,4,5,7,8,9,11,12,13,15,16,17,19,20,21,23,24,25},nil,{0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0},0,0,{0}})
		CA__InputVA(56*0,Str2,Str2s,nil,56*0,56*1-2)
		CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 


		
		local Tabkey = KeyToggleFunc2("TAB","LCTRL")
		CIfX(FP,{CD(Tabkey,1)})--��ġǥ��
		CIfX(FP,{CV(LevelLoc,LevelLimit-1,AtMost)})
		CElseX({TSetNWar(ExpLoc, SetTo, "0"),TSetNWar(TotalExpLoc, SetTo, "0")})
		CIfXEnd()
		CA__SetValue(Str1,"\x07�̣֣�\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04��",nil,1)
		CA__lItoCustom(SVA1(Str1,12),ExpLoc,nil,nil,{10,15},nil,nil,"\x040",{0x1C,0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
		CA__Input(MakeiStrData("\x08��",1),SVA1(Str1,30))
		CA__lItoCustom(SVA1(Str1,31),TotalExpLoc,nil,nil,{10,15},nil,nil,"\x040",{0x1C,0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
		CElseX()--�ۼ�Ʈǥ��
		CA__SetValue(Str1,"\x07�̣֣�\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04��\x0F�ţأ�\x04��",nil,1)
		local CurExpTmp = CreateVar(FP)
		local CurExpTmp2 = CreateWar(FP)
		CIfX(FP,{CV(LevelLoc,LevelLimit-1,AtMost)})
		f_LMul(FP, CurExpTmp2,ExpLoc, "20")
		f_Cast(FP, {CurExpTmp,0}, _LDiv(CurExpTmp2,TotalExpLoc), nil, nil, 1)
		CElseX({SetV(CurExpTmp,20)})
		CIfXEnd()
		CA__SetValue(Str1,"\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x17(Ctrl+TAB:���ΰ�)",nil,16)
		for i = 0, 19 do
			CS__InputTA(FP,{CV(CurExpTmp,i+1,AtLeast)},SVA1(Str1,16+i),0x07,0xFF)
		end
		
		
		
		
		CIfXEnd()
		
		CS__ItoCustom(FP,SVA1(Str1,3),LevelLoc,nil,nil,{10,6},1,nil,"\x1B��",0x1B,nil, LVData)
		TriggerX(FP,{CD(StatEffLoc,1),CD(StatEffT,2,AtLeast)},{SetCD(StatEffT,0),SetCSVA1(SVA1(Str1,0),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,1),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,2),SetTo,0x04,0xFF)},{preserved})
		CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)
		CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0)


		f_LSub(FP,TempFf,iv.FfragItemLoc,iv.FfragItemUsedLoc)
		f_Cast(FP, {TempFf2,0}, TempFf,nil,nil,1)


		CIfX(FP,CD(Tabkey,0))
		CA__SetValue(Str1,"\x12����Ʈ \x04:  000,000,000 \x04| \x17ũ���� \x04:  123\x04,123\x04,123\x04,123\x04,123",nil,1)
		TriggerX(FP,CV(StatPLoc,999999999,AtLeast),{SetV(StatPLoc,999999999)},{preserved})
        CS__ItoCustom(FP,SVA1(Str1,8),StatPLoc,nil,nil,{10,9},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6,8,9,10}, nil,{0,0,{0},0,0,{0},0,0,{0}})
		CElseX()
		CA__SetValue(Str1,"\x12\x02����\x0D \x04:  000,000,000 \x04| \x17ũ���� \x04:  123\x04,123\x04,123\x04,123\x04,123",nil,1)
		CTrigger(FP,{TTNWar(TempFf, AtLeast, "999999999")},{SetV(TempFf2,999999999)},{preserved})

        CS__ItoCustom(FP,SVA1(Str1,8),TempFf2,nil,nil,{10,9},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6,8,9,10}, nil,{0,0,{0},0,0,{0},0,0,{0}})
		CIfXEnd()
		CIf(FP,{TTNWar(CredLoc, AtLeast, "999999999999999")})
		f_LMov(FP,CredLoc,"999999999999999")
		CIfEnd()

        CA__lItoCustom(SVA1(Str1,29),CredLoc,nil,nil,{10,15},1,nil,"\x040",{0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x02,0x1E,0x1E,0x1E,0x05,0x05,0x05}
        ,{0,1,2,4,5,6,8,9,10,12,13,14,16,17,18},nil,{0,0,{0},0,0,{0},0,0,{0},0,0,{0}})

	
		CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-2)
		CIfX(FP,{CD(Tabkey,1)})--��ġǥ��
		CA__SetColor((56*2)+1, 0x02)
		CA__SetColor((56*2)+23, 0x10)
		CElseX()--�ۼ�Ʈǥ��
		CA__SetColor((56*2)+1, 0x10)
		CA__SetColor((56*2)+23, 0x17)
		CIfXEnd()
		CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0) 
		
	
	
	CA__SetMemoryX((56*3)-1,0x0D0D0D0D,0xFFFFFFFF,1)
		end 
		CAPrint(iStr1,{Force1},{1,0,0,0,1,1,0,0},"TEST",FP,{}) 

	
	CIf(FP, {CV(InterfaceNumLoc,1,AtLeast),CV(InterfaceNumLoc,512,AtMost)})
		
		CMov(FP,MCP,LCP)
		CallTriggerX(FP,Call_SetScrMouse,{},{})
		mmX = mouseX -- �����ǥ ��������
		mmY = mouseY
		mmX2 = screenX -- �߾�����
		mmX3 = screenX2 -- �߾�����
		if TestStart == 1 then
		--DisplayPrintEr(0, {"�����ǥ X : ", mmX, "  Y : ", mmY, " || �߾����� X : ", mmX2, "  Y : ", mmY," || �������� X : ",mmX3,"  Y : ",mmY});
		end
		BColor = CreateVarArr(6,FP)
		BColor2 = CreateVarArr(6,FP)
		BColor3 = CreateVarArr(6,FP)
		BColor4 = CreateVarArr(6,FP)

		
		CColor1_1 = CreateVarArr(5,FP)
		CColor2_1 = CreateVarArr(5,FP)
		CColor3_1 = CreateVarArr(5,FP)
		CColor4_1 = CreateVarArr(5,FP)
		CColor5_1 = CreateVarArr(5,FP)
		CColor6_1 = CreateVarArr(5,FP)
		CColor1_2 = CreateVarArr(5,FP)
		CColor2_2 = CreateVarArr(5,FP)
		CColor3_2 = CreateVarArr(5,FP)
		CColor4_2 = CreateVarArr(5,FP)
		CColor5_2 = CreateVarArr(5,FP)
		CColor6_2 = CreateVarArr(5,FP)

		MToggle = CreateCcodeArr(6)
		MToggle2 = CreateCcodeArr(6)
		MToggle3 = CreateCcodeArr(6)
		
		MToggle1_1 = CreateCcodeArr(5)
		MToggle2_1 = CreateCcodeArr(5)
		MToggle3_1 = CreateCcodeArr(5)
		MToggle1_2 = CreateCcodeArr(5)
		MToggle2_2 = CreateCcodeArr(5)
		MToggle3_2 = CreateCcodeArr(5)

		local SWAPB = CreateVar(FP)
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
		for j,p in pairs({0x1F,0x1C,0x1E,0x1D,0x1B}) do
			table.insert(BAct,SetV(CColor1_1[j],p))
			table.insert(BAct,SetV(CColor2_1[j],0x04))
			table.insert(BAct,SetV(CColor3_1[j],0x1F))
			table.insert(BAct,SetV(CColor4_1[j],0x04))
			table.insert(BAct,SetV(CColor5_1[j],0x04))
			table.insert(BAct,SetV(CColor6_1[j],0x04))
			table.insert(BAct,SetCD(MToggle1_1[j],0))
			table.insert(BAct,SetCD(MToggle2_1[j],0))
			table.insert(BAct,SetCD(MToggle3_1[j],0))

		end
		
		for j,p in pairs({0x11,0x1C,0x1F,0x02,0x17}) do
			table.insert(BAct,SetV(CColor1_2[j],p))
			table.insert(BAct,SetV(CColor2_2[j],0x04))
			table.insert(BAct,SetV(CColor3_2[j],0x1F))
			table.insert(BAct,SetV(CColor4_2[j],0x04))
			table.insert(BAct,SetV(CColor5_2[j],0x04))
			table.insert(BAct,SetV(CColor6_2[j],0x04))
			table.insert(BAct,SetCD(MToggle1_2[j],0))
			table.insert(BAct,SetCD(MToggle2_2[j],0))
			table.insert(BAct,SetCD(MToggle3_2[j],0))

		end
		table.insert(BAct,SetV(ESCB,0x08))
		table.insert(BAct,SetV(SWAPB,0x08))
		table.insert(BAct,SetV(NEXB,0x08))
		table.insert(BAct,SetV(PRVB,0x08))
		DoActions2X(FP, BAct)
		local CDFncArr={}
		--296~310 �� ������� ��ư
		--274~388 �����ǥ �������ư
		
		local MStat,CDFnc2 = ToggleFunc({Memory(0x6CDDC0,Exactly,0),Memory(0x6CDDC0,Exactly,2)},1)--
		TriggerX(FP,{VRange(InterfaceNumLoc, 1, 255),MLine(mmY,4),VRange(mmX, 74, 188)},{SetV(ESCB,0x07)},{preserved})
		TriggerX(FP,{VRange(InterfaceNumLoc, 1, 255),MLine(mmY,4),VRange(mmX, 74, 188),CD(MStat,1)},{SetV(ESCB,0x1B)},{preserved})
		
		TriggerX(FP,{VRange(InterfaceNumLoc, 256, 512),MLine(mmY,4),VRange(mmX, 64, 178)},{SetV(ESCB,0x07)},{preserved})
		TriggerX(FP,{VRange(InterfaceNumLoc, 256, 512),MLine(mmY,4),VRange(mmX, 64, 178),CD(MStat,1)},{SetV(ESCB,0x1B)},{preserved})

		
		TriggerX(FP,{VRange(InterfaceNumLoc, 1, 255),MLine(mmY,4),VRange(mmX, 193,308)},{SetV(SWAPB,0x07)},{preserved})
		TriggerX(FP,{VRange(InterfaceNumLoc, 1, 255),MLine(mmY,4),VRange(mmX, 193,308),CD(MStat,1)},{SetV(SWAPB,0x1B)},{preserved})
		
		TriggerX(FP,{VRange(InterfaceNumLoc, 256, 512),MLine(mmY,4),VRange(mmX, 193+10,308+10)},{SetV(SWAPB,0x07)},{preserved})
		TriggerX(FP,{VRange(InterfaceNumLoc, 256, 512),MLine(mmY,4),VRange(mmX, 193+10,308+10),CD(MStat,1)},{SetV(SWAPB,0x1B)},{preserved})

		
		TriggerX(FP,{VRange(InterfaceNumLoc, 1, 255),MLine(mmY,4),VRange(mmX, 74, 188),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000)},{preserved})
		TriggerX(FP,{VRange(InterfaceNumLoc, 256, 512),MLine(mmY,4),VRange(mmX, 64, 178),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000)},{preserved})
		


		
		TriggerX(FP,{VRange(InterfaceNumLoc, 1, 255),MLine(mmY,4),VRange(mmX, 193,308),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x30000)},{preserved})
		TriggerX(FP,{VRange(InterfaceNumLoc, 256, 512),MLine(mmY,4),VRange(mmX, 193+10,308+10),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x40000)},{preserved})


		CIf(FP,{CV(InterfaceNumLoc,1,AtLeast),CV(InterfaceNumLoc,255,AtMost)})
		
		TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 113, 187)},{SetV(PRVB,0x07)},{preserved})
		TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 113, 187),CD(MStat,1)},{SetV(PRVB,0x1B)},{preserved})

		TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 233, 311)},{SetV(NEXB,0x07)},{preserved})
		TriggerX(FP,{MLine(mmY,4),VRange(mmX3, 233, 311),CD(MStat,1)},{SetV(NEXB,0x1B)},{preserved})

		


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
			TriggerX(FP,{CV(InterfaceNumLoc,3),CD(CDFnc,1)},{SetMemory(0x58F504,SetTo,i+13)},{preserved})
			--TriggerX(FP,{CV(InterfaceNumLoc,2),CD(MToggle2[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x10000+i+7)},{preserved})

		end

		DisplayPrint(LCP, {"\x07�ɷ�ġ \x04����. ",ESCB[2],"[������ Ŭ�� �Ǵ� ESC]",SWAPB[2]," [���� ���� â���� �̵�]\x12",PRVB[2],"[���� ������(I)] \x07",InterfaceNumLoc," Page ",NEXB[2],"[���� ������(P)]"})--
		TriggerX(FP, CV(ResetStatLoc,0), {DisplayExtText("\x1F[�����ʱ�ȭ \x175000 ũ���� \x081�ð��̳� \x1141���̺��� 1ȸ�� \x04Ctrl+O\x1F] \x1F��밡��", 4)}, {preserved})
		TriggerX(FP, CV(ResetStatLoc,1), {DisplayExtText("\x1F[�����ʱ�ȭ \x175000 ũ���� \x081�ð��̳� \x1141���̺��� 1ȸ�� \x04Ctrl+O\x1F] \x08���Ұ�", 4)}, {preserved})
		CIfEnd()
		CIf(FP,{CV(InterfaceNumLoc,256,AtLeast),CV(InterfaceNumLoc,512,AtMost)})
		
		for i = 0, 4 do
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX, 0, 320)},{SetV(CColor1_1[i+1],0x07),SetV(CColor3_1[i+1],0x0E),SetCD(MToggle[i+1],1)},{preserved})--����
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 0, 320)},{SetV(CColor1_2[i+1],0x07),SetV(CColor3_2[i+1],0x0E),SetCD(MToggle[i+1],1)},{preserved})--����

			
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX, 10, 32)},{SetV(CColor4_1[i+1],0x07),SetCD(MToggle1_1[i+1],1)},{preserved})
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX, 36, 66)},{SetV(CColor5_1[i+1],0x07),SetCD(MToggle2_1[i+1],1)},{preserved})
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX, 70, 107)},{SetV(CColor6_1[i+1],0x07),SetCD(MToggle3_1[i+1],1)},{preserved})
			TriggerX(FP,{CD(MToggle1_1[i+1],1),CD(MStat,1)},{SetV(CColor4_1[i+1],0x08)},{preserved})
			TriggerX(FP,{CD(MToggle2_1[i+1],1),CD(MStat,1)},{SetV(CColor5_1[i+1],0x08)},{preserved})
			TriggerX(FP,{CD(MToggle3_1[i+1],1),CD(MStat,1)},{SetV(CColor6_1[i+1],0x08)},{preserved})

			
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 289, 311)},{SetV(CColor4_2[i+1],0x07),SetCD(MToggle1_2[i+1],1)},{preserved})
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 255, 285)},{SetV(CColor5_2[i+1],0x07),SetCD(MToggle2_2[i+1],1)},{preserved})
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 214, 251)},{SetV(CColor6_2[i+1],0x07),SetCD(MToggle3_2[i+1],1)},{preserved})
			TriggerX(FP,{CD(MToggle1_2[i+1],1),CD(MStat,1)},{SetV(CColor4_2[i+1],0x08)},{preserved})
			TriggerX(FP,{CD(MToggle2_2[i+1],1),CD(MStat,1)},{SetV(CColor5_2[i+1],0x08)},{preserved})
			TriggerX(FP,{CD(MToggle3_2[i+1],1),CD(MStat,1)},{SetV(CColor6_2[i+1],0x08)},{preserved})

			
			TriggerX(FP,{CD(MToggle1_1[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x30000+i+1)},{preserved})--1
			TriggerX(FP,{CD(MToggle2_1[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x30010+i+1)},{preserved})--10
			TriggerX(FP,{CD(MToggle3_1[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x30020+i+1)},{preserved})--100
			TriggerX(FP,{CD(MToggle1_2[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x30100+i+1)},{preserved})--1
			TriggerX(FP,{CD(MToggle2_2[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x30110+i+1)},{preserved})--10
			TriggerX(FP,{CD(MToggle3_2[i+1],1),CD(CDFnc2,1)},{SetMemory(0x58F504,SetTo,0x30120+i+1)},{preserved})--100



			local temp,CDFnc = ToggleFunc({CD(MToggle[i+1],0),CD(MToggle[i+1],1)})--
			TriggerX(FP,{CV(InterfaceNumLoc,256),CD(CDFnc,1),VRange(mmX, 0, 320)},{SetMemory(0x58F504,SetTo,0x100+i+1)},{preserved})--����
			TriggerX(FP,{CV(InterfaceNumLoc,256),CD(CDFnc,1),VRange(mmX3, 0, 320)},{SetMemory(0x58F504,SetTo,0x180+i+1)},{preserved})--����

			
			TriggerX(FP,{CD(MToggle2[i+1],1),CD(MStat,1)},{SetV(BColor2[i+1],0x08)},{preserved})




		end


		DisplayPrint(LCP, {"\x1C���� \x04����. ",ESCB[2],"[������ Ŭ�� �Ǵ� ESC]",SWAPB[2]," [���� ���� â���� �̵�]\x12"})--
		TriggerX(FP, CV(ResetStat2Loc,0), {DisplayExtText("\x1C[�����ʱ�ȭ \x1710�� ũ���� \x081�ð��̳� \x1141���̺��� 1ȸ�� \x04Ctrl+U\x1F] \x1F��밡��", 4)}, {preserved})
		TriggerX(FP, CV(ResetStat2Loc,1), {DisplayExtText("\x1C[�����ʱ�ȭ \x1710�� ũ���� \x081�ð��̳� \x1141���̺��� 1ȸ�� \x04Ctrl+U\x1F] \x08���Ұ�", 4)}, {preserved})
		CIfEnd()
--		local TempLoc = CreateVar(FP)
--		CIfX(FP, {CV(ResetStatLoc,4,AtMost)})
--		CMov(FP,TempLoc,_ReadF(ArrX(SRTable, ResetStatLoc)))
--		DisplayPrint(LCP, {"\x1F[�����ʱ�ȭ \x17",TempLoc,"ũ���� \x04��� ������ ��� \x081�ð��� ���� ��� \x04Ctrl+O\x1F]"})
--		
--		CElseX()
--		DoActions(FP, {DisplayExtText("\x1F[�����ʱ�ȭ \x08���Ұ�\x1F] ", 4)})
--		CIfXEnd()


		CIfX(FP,{CV(InterfaceNumLoc,1)},{}) -- ���� ������ ����
			--DisplayPrint(LCP, {"\x071. \x08��ȭ ����\x04�� ����ġ ȹ�淮 ���� \x07+0.1% \x08MAX 50 - ",BColor3[1][2],Cost_Stat_BossSTic.." Pts\x12\x07 + ",BColor[1][2],EVarArr2,".",EVarArr3," % ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			
			--5���� óġ�� �Ǹű� +10�� ���� �ִ� 20ȸ 1���ȴ� 50����Ʈ
			--DisplayPrint(LCP, {"\x071. \x08��ȭ ����\x04�� ����ġ ȹ�淮 ���� \x07+0.1% \x08MAX 100 ",BColor3[1][2],"�� �׸��Դϴ�.\x12\x07 ",BColor[1][2]," - ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			--DisplayPrint(LCP, {"\x071. ",BColor3[1][2],"�� �׸��Դϴ�.\x12\x07 ",BColor[1][2]," - ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			--DisplayPrint(LCP, {"\x072. ",BColor3[2][2],"�� �׸��Դϴ�.\x12\x07 ",BColor[2][2]," - ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
			CMul(FP,S_BossSTicLoc,100)
			DisplayPrint(LCP, {"\x071. \x08��Ƽ ���� \x1FLV.5, \x1F���� \x1CLV.6\x04(x2) \x1DExtra\x04(x3) \x04óġ�� \x19���� �Ǹű� + 100�� \x08MAX 10 - ",BColor3[1][2],Cost_Stat_BossSTic.." Pts\x12\x07+ ",BColor[1][2],S_BossSTicLoc," �� ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			CMul(FP,S_BossLVUPLoc,50)
			DisplayPrint(LCP, {"\x072. \x08��Ƽ ���� \x1FLV.5, \x1F���� \x1CLV.6\x04(x2) \x1DExtra\x04(x3) \x04óġ�� \x1F���� +50�� \x08MAX 5 - ",BColor3[2][2],Cost_Stat_BossLVUP.." Pts\x12\x07+ ",BColor[2][2],S_BossLVUPLoc," LV ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
			CMul(FP,UpgradeLoc,10)
			DisplayPrint(LCP, {"\x073. \x1B���� ���� \x08������ \x07+10% \x08MAX 50 - ",BColor3[3][2],Cost_Stat_Upgrade.." Pts\x12\x07+ ",BColor[3][2],UpgradeLoc," % ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerLoc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x074. \x07+1 \x08��ȭȮ�� \x0F+0.1%p \x08MAX 100 \x04- ",BColor3[4][2],Cost_Stat_TotalEPer.." Pts\x12\x07+ ",BColor[4][2],EVarArr2,".",EVarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPer2Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x075. \x0F+2 \x08��ȭȮ�� \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[5][2],Cost_Stat_TotalEPer2.." Pts\x12\x07+ ",BColor[5][2],EVarArr2,".",EVarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPer3Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x076. \x10+3 \x08��ȭȮ�� \x0F+0.1%p \x08MAX 30 \x04- ",BColor3[6][2],Cost_Stat_TotalEPer3.." Pts\x12\x07+ ",BColor[6][2],EVarArr2,".",EVarArr3," %p ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})
			
		
		CElseIfX({CV(InterfaceNumLoc,2)})
			CMov(FP,MCP,LCP)
			CallTriggerX(FP,Call_SetScrMouse,{},{})
			
			if TestStart == 1 then
				--DisplayPrintEr(0, {"�����ǥ X : ", mmX, "  Y : ", mmY, " || �߾����� X : ", mmX2, "  Y : ", mmY," || �������� X : ",mmX3,"  Y : ",mmY});
			end
			
			
			CMov(FP,GEVar,S_TotalEPer4Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x071. \x08Ư�� \x08��ȭȮ�� \x0F+0.1%p \x08MAX 100 \x04- ",BColor3[1][2],Cost_Stat_TotalEPer4.." Pts\x12\x07+ ",BColor[1][2],EVarArr2,".",EVarArr3," %p ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			CMov(FP,GEVar,S_BreakShieldLoc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x072. \x08Ư�� \x1F�ı� ����\x08Ȯ�� \x0F+0.1%p \x08MAX 300 \x04- ",BColor3[2][2],Cost_Stat_BreakShield.." Pts\x12\x07+ ",BColor[2][2],EVarArr2,".",EVarArr3," %p ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerExLoc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x073. \x07+1 \x08��ȭȮ�� 2 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[3][2],Cost_Stat_TotalEPerEx.." Pts\x12\x07+ ",BColor[3][2],EVarArr2,".",EVarArr3," %p ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerEx2Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x074. \x0F+2 \x08��ȭȮ�� 2 \x0F+0.1%p \x08MAX 20 \x04- ",BColor3[4][2],Cost_Stat_TotalEPerEx2.." Pts\x12\x07+ ",BColor[4][2],EVarArr2,".",EVarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerEx3Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x075. \x0F+3 \x08��ȭȮ�� 2 \x0F+0.1%p \x08MAX 10 \x04- ",BColor3[5][2],Cost_Stat_TotalEPerEx3.." Pts\x12\x07+ ",BColor[5][2],EVarArr2,".",EVarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
			--DisplayPrint(LCP, {"\x076. \x07�⺻���� \x1B���� ��Ÿ�� \x04-1 \x08MAX 8 \x04- ",BColor3[6][2],Cost_Stat_LV3Incm.." Pts\x12\x07",BColor[6][2],"9 - ",SCCoolLoc," ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})

			DisplayPrint(LCP, {"\x076. \x11LV.MAX \x1B����ƺ�\x04 �� ���޷� \x111.0% \x08MAX 100 \x04- ",BColor3[6][2],Cost_Stat_LV3Incm.." Pts\x12\x07+ ",BColor[6][2],S_LV3IncmLoc," % ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})

			CElseIfX({CV(InterfaceNumLoc,3)})
			CMov(FP,GEVar,S_TotalEPer4XLoc)
			CallTrigger(FP, Call_SetEPerStr)
				--DisplayPrintEr(0, {"�����ǥ X : ", mmX, "  Y : ", mmY, " || �߾����� X : ", mmX2, "  Y : ", mmY," || �������� X : ",mmX3,"  Y : ",mmY});
			DisplayPrint(LCP, {"\x071. \x08Ư�� \x08��ȭȮ�� \x1F2\x04 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[1][2],Cost_Stat_TotalEPer4X.." Pts\x12\x07+ ",BColor[1][2],EVarArr2,".",EVarArr3," %p ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			CMov(FP,GEVar,S_BreakShield2Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x072. \x08Ư�� \x1F�ı� ����\x08Ȯ�� \x1F2\x04 \x0F+0.1%p \x08MAX 100 \x04- ",BColor3[2][2],Cost_Stat_BreakShield2.." Pts\x12\x07+ ",BColor[2][2],EVarArr2,".",EVarArr3," %p ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})


			
			CMov(FP,GEVar,Stat_XEPer44Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x073. \x1F44�� \x08��ȭȮ�� \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[3][2],Cost_Stat_XEPer44.." Pts\x12\x07+ ",BColor[3][2],EVarArr2,".",EVarArr3," %p ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
			CMov(FP,GEVar,Stat_XEPer45Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x074. \x1C45�� \x08��ȭȮ�� \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[4][2],Cost_Stat_XEPer45.." Pts\x12\x07+ ",BColor[4][2],EVarArr2,".",EVarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
			CMov(FP,GEVar,Stat_XEPer46Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x075. \x1E46�� \x08��ȭȮ�� \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[5][2],Cost_Stat_XEPer46.." Pts\x12\x07+ ",BColor[5][2],EVarArr2,".",EVarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
			CMov(FP,GEVar,Stat_XEPer47Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x076. \x0247�� \x08��ȭȮ�� \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[6][2],Cost_Stat_XEPer47.." Pts\x12\x07+ ",BColor[6][2],EVarArr2,".",EVarArr3," %p ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})

			CElseIfX({CV(InterfaceNumLoc,256)})
			
			DisplayPrint(LCP, {CColor4_1[1][2],"[+1] ",CColor5_1[1][2],"[+10] ",CColor6_1[1][2],"[+100] ",CColor1_1[1][2],"�ϱ� ���� ",FXPer44Loc,"�� ",CColor3_1[1][2],"|| Cost : ",Cost_FXPer44Loc,"\x12",CColor3_2[1][2]," Cost : ",Cost_FIncmLoc," || ",CColor1_2[1][2],FIncmLoc," �� �繰�� ���� ",CColor6_2[1][2],"[+100] ",CColor5_2[1][2],"[+10] ",CColor4_2[1][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[2][2],"[+1] ",CColor5_1[2][2],"[+10] ",CColor6_1[2][2],"[+100] ",CColor1_1[2][2],"�߱� ���� ",FXPer45Loc,"�� ",CColor3_1[2][2],"|| Cost : ",Cost_FXPer45Loc,"\x12",CColor3_2[2][2]," Cost : ",Cost_FSEXPLoc," || ",CColor1_2[2][2],FSEXPLoc," �� ������ ���� ",CColor6_2[2][2],"[+100] ",CColor5_2[2][2],"[+10] ",CColor4_2[2][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[3][2],"[+1] ",CColor5_1[3][2],"[+10] ",CColor6_1[3][2],"[+100] ",CColor1_1[3][2],"��� ���� ",FXPer46Loc,"�� ",CColor3_1[3][2],"|| Cost : ",Cost_FXPer46Loc,"\x12",CColor3_2[3][2]," Cost : ",Cost_FBrShLoc," || ",CColor1_2[3][2],FBrShLoc," �� ��ȣ�� ���� ",CColor6_2[3][2],"[+100] ",CColor5_2[3][2],"[+10] ",CColor4_2[3][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[4][2],"[+1] ",CColor5_1[4][2],"[+10] ",CColor6_1[4][2],"[+100] ",CColor1_1[4][2],"Ư�� ���� ",FXPer47Loc,"�� ",CColor3_1[4][2],"|| Cost : ",Cost_FXPer47Loc,"\x12",CColor3_2[4][2]," Cost : ",Cost_FMEPerLoc," || ",CColor1_2[4][2],FMEPerLoc," �� �ñ��� ���� ",CColor6_2[4][2],"[+100] ",CColor5_2[4][2],"[+10] ",CColor4_2[4][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[5][2],"[+1] ",CColor5_1[5][2],"[+10] ",CColor6_1[5][2],"[+100] ",CColor1_1[5][2],"��� ���� ",FXPer48Loc,"�� ",CColor3_1[5][2],"|| Cost : ",Cost_FXPer48Loc,"\x12",CColor3_2[5][2]," Cost : ",Cost_FMinLoc," || ",CColor1_2[5][2],FMinLoc," �� ä���� ���� ",CColor6_2[5][2],"[+100] ",CColor5_2[5][2],"[+10] ",CColor4_2[5][2],"[+1]"})

			if Limit == 0 then
				--CDoActions(FP, {TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\x13�������� \x08����� \x04/ \x04���� ȹ�淮 (\x07��밡��\x04) ����", 4)})
			else
				--CDoActions(FP, {TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\x13�������� \x08����� \x04/ \x04���� ȹ�淮 (\x07��밡��\x04) ���� - \x03TESTMODE ���� ���޹ޱ� \x04F12��ư\x08(1ȸ��)", 4)})
			end
			DisplayPrint(LCP, {"�������� \x08����� \x04/ \x04���� ȹ�淮 (\x07��밡��\x04) ����\x12\x08",iv.FfragItemUsedLoc," \x04/ ",iv.FfragItemLoc," (\x07",TempFf,"\x04)"})
		CIfXEnd()
		DoActions(FP,{SetCp(FP)})
		local StatPrintEr = {
			--StrDesign("\x04���� ���۽� ó�� �����ϴ� \x07�⺻����(��ī��) \x08������\x04�� ������ŵ�ϴ�. \x08���� \x04: \x07�⺻����\x04�� 3�� �� ������ϴ�."),
			--StrDesign("\x04���� ���۽� ó�� �����ϴ� \x07�⺻����(��ī��) \x0F����\x04�� ������ŵ�ϴ�. \x08���� \x04: \x07�⺻����\x04�� 3�� �� ������ϴ�."),
			StrDesign("\x08��Ƽ ���� \x1FLV.5 \x04óġ�� \x19���� �Ǹű�\x04�� ����ϴ�. \x1F���� \x1CLV.6\x04(x2) \x1DExtra\x04(x3)."),
			StrDesign("\x08��Ƽ ���� \x1FLV.5 \x04óġ�� \x1C����\x04�� �����մϴ�. \x08���� \x04: \x1C�ִ� ����ġ\x04�� \x08�ִ� 50��, \x1F���� \x1CLV.6\x04(x2) \x1DExtra\x04(x3)"),
			StrDesign("\x04�ڽ��� \x07��ȭ \x04���� \x08������\x04�� ������ŵ�ϴ�."),
			StrDesign("\x07+1\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: \x07+2, \x10+3 \x04��ȭȮ���� ���� ������ \x08�����ϴ�."),
			StrDesign("\x07+2\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0F36�� \x04���� �̻���� +1�� �ջ�, ����˴ϴ�."),
			StrDesign("\x10+3\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0F35��\x04:\x08+2��, \x0F36��\x04:\x08+1��\x04 �ջ� ����˴ϴ�."),
			StrDesign("\x08Ư��\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0840�� ���� ����\x04�� ����˴ϴ�."),
			StrDesign("\x08Ư��\x1F �ı� ����\x08Ȯ��\x04�� ������ŵ�ϴ�. \x08���� \x04: �� �׸��� \x0840�� ���� ����\x04�� ����˴ϴ�."),
			StrDesign("\x10�߰� \x07+1\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: ���� 1������ ��ȭȮ�� ������ \x07������ \x04�Ͻñ� �����մϴ�."),
			StrDesign("\x10�߰� \x0F+2\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: ���� 1������ ��ȭȮ�� ������ \x07������ \x04�Ͻñ� �����մϴ�."),
			StrDesign("\x10�߰� \x0F+3\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: ���� 1������ ��ȭȮ�� ������ \x07������ \x04�Ͻñ� �����մϴ�."),
			StrDesign("\x11LV.MAX \x1B����ƺ�\x04 �� ���޷��� 1% ������ŵ�ϴ�. \x07�⺻�� : 100%. \x08���� \x04: �� �׸��� \x1041�� \x07�̻� \x04���ֿ��� ��ȿ�մϴ�."),
			StrDesign("\x08Ư��\x08 ��ȭȮ��\x04�� ������ŵ�ϴ�. \x08���� \x04: ���� 2������ Ư��Ȯ�� ������ \x07������ \x04�Ͻñ� �����մϴ�."),
			StrDesign("\x08Ư��\x1F �ı� ����\x08Ȯ��\x04�� ������ŵ�ϴ�. \x08���� \x04: ���� 2������ �ı����� ������ \x07������ \x04�Ͻñ� �����մϴ�."),
			StrDesign("\x1F44�� \x08��ȭ \x04�õ��� \x08��ȭȮ��\x04�� ������ŵ�ϴ�."),
			StrDesign("\x1C45�� \x08��ȭ \x04�õ��� \x08��ȭȮ��\x04�� ������ŵ�ϴ�."),
			StrDesign("\x1E46�� \x08��ȭ \x04�õ��� \x08��ȭȮ��\x04�� ������ŵ�ϴ�."),
			StrDesign("\x0247�� \x08��ȭ \x04�õ��� \x08��ȭȮ��\x04�� ������ŵ�ϴ�."),
	}
	
	local StatPrintEr2 = {
		StrDesign("\x04���� \x0F0.1%p\x04�� \x1F44�� \x08��ȭȮ�� \x04����. \x08MAX "..Cost_FXPer44[2].." ��"),
		StrDesign("\x04���� \x0F0.1%p\x04�� \x1C45�� \x08��ȭȮ�� \x04����. \x08MAX "..Cost_FXPer45[2].." ��"),
		StrDesign("\x04���� \x0F0.1%p\x04�� \x1E46�� \x08��ȭȮ�� \x04����. \x08MAX "..Cost_FXPer46[2].." ��"),
		StrDesign("\x04���� \x0F0.1%p\x04�� \x0247�� \x08��ȭȮ�� \x04����. \x08MAX "..Cost_FXPer47[2].." ��"),
		StrDesign("\x04���� \x0F0.005%p\x04�� \x1B48�� \x08��ȭȮ�� \x04����. \x08MAX "..Cost_FXPer48[2].." ��"),
}
	local StatPrintEr3 = {
		StrDesign("\x04���� \x110.1��\x04�� \x11LV.MAX \x1B����ƺ�\x04 �� ���޷� ����. \x08MAX "..Cost_FIncm[2].." ��"),
		StrDesign("\x04���� \x1C10%\x04�� \x1C�ǸŽ� ����ġ�� \x04����. \x08MAX "..Cost_FSEXP[2].." ��"),
		StrDesign("\x04���� \x0F0.1%p\x04�� \x1F�ı� ���� Ȯ�� \x04����. \x08MAX "..Cost_FBrSh[2].." ��"),
		StrDesign("\x0649��\x04,\x0750�� \x11����\x04. \x04���� \x0F0.01%p\x04�� \x1F��\x1C��\x1E��\x07�� \x08��ȭȮ�� \x04����. \x08MAX "..Cost_FMEPer[2].." ��"),
		StrDesign("\x04���� \x0F0.1��\x04�� \x17ũ���� ä���ӵ� \x04����. \x08MAX "..Cost_FMin[2].." ��"),
	}

		
	CIfEnd()
	for i = 0,6 do
		CIf(FP,{HumanCheck(i, 1)})
			CallTriggerX(FP,Call_Print13[i+1],{Deaths(i,AtLeast,1,20),Deaths(i,AtMost,#StatPrintEr,20)},{SetV(DPErT[i+1],24*10)})
			CallTriggerX(FP,Call_Print13[i+1],{Deaths(i,AtLeast,1,20),Deaths(i,AtLeast,0x100,20),Deaths(i,AtMost,0x100+#StatPrintEr2,20)},{SetV(DPErT[i+1],24*10)})
			CallTriggerX(FP,Call_Print13[i+1],{Deaths(i,AtLeast,1,20),Deaths(i,AtLeast,0x180,20),Deaths(i,AtMost,0x180+#StatPrintEr2,20)},{SetV(DPErT[i+1],24*10)})
			for j = 1, #StatPrintEr do
				TriggerX(FP, {LocalPlayerID(i),Deaths(i,Exactly,j,20)}, {print_utf8(12,0,StatPrintEr[j])}, {preserved})
			end
			for j = 1, #StatPrintEr2 do
				TriggerX(FP, {LocalPlayerID(i),Deaths(i,Exactly,j+0x100,20)}, {print_utf8(12,0,StatPrintEr2[j])}, {preserved})
			end
			for j = 1, #StatPrintEr3 do
				TriggerX(FP, {LocalPlayerID(i),Deaths(i,Exactly,j+0x180,20)}, {print_utf8(12,0,StatPrintEr3[j])}, {preserved})
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
	DoActionsX(FP, {SetCD(LToggle,1)}, 1)
	CTrigger(FP,{CD(PKey,1)},{SetCD(LKey,0)},1)
	CTrigger(FP,{CD(KKey,1)},{SetCD(LKey,0)},1)
	TriggerX(FP,{CD(BKey,1)},{SetCD(LKey,0)},{preserved})
	TriggerX(FP,{CD(NKey,1)},{SetCD(LKey,0)},{preserved})
	TriggerX(FP,{CD(MKey,1)},{SetCD(LKey,0)},{preserved})
	CTrigger(FP,{CD(PKey,0),CD(KKey,0),CD(LToggle,0),CD(LKey,0)},{SetCD(LToggle,1),TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\n\n\n\n\n\n\n",4)},1)
	CTrigger(FP,{CD(LToggle,0),CD(LKey,0)},{SetCD(LToggle,1)},1)
	--CTrigger(FP,{CD(LToggle,0),CD(LKey,1)},{SetCD(LToggle,1),TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\n\n\n\n\n\n\n\n",4)},1)
	CIf(FP,{CD(PKey,1)},{SetCD(LKey,0)})
	


	CMov(FP,GEVar,TotalEPerLoc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer44Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07+1 \x08��ȭȮ�� : \x07+ \x0F",EVarArr2,".",EVarArr3,"%p \x04|| \x1F44�� \x08��ȭȮ�� : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p",})
	CMov(FP,GEVar,TotalEPer2Loc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer45Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07+2 \x08��ȭȮ�� : \x07+ \x0F",EVarArr2,".",EVarArr3,"%p \x04|| \x1C45�� \x08��ȭȮ�� : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p",})
	CMov(FP,GEVar,TotalEPer3Loc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer46Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x10+3 \x08��ȭȮ�� : \x07+ \x0F",EVarArr2,".",EVarArr3,"%p \x04|| \x1E46�� \x08��ȭȮ�� : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p",})
	CMov(FP,GEVar,TotalEPer4Loc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer47Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x08Ư�� \x08��ȭȮ�� \x04�� ������ : \x07+ \x08",EVarArr2,".",EVarArr3,"%p \x04|| \x0247�� \x08��ȭȮ�� : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p"})
	CMov(FP,GEVar,BreakShieldLoc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer48Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x08Ư�� \x1F�ı� ����\x08Ȯ�� \x04�� ������ : \x07+ \x1F",EVarArr2,".",EVarArr3,"%p \x04|| \x1B48�� \x08��ȭȮ�� : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p"})
	f_Mul(FP,EXPIncomeLoc2,10)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x1C�ǸŽ� ����ġ \x07�߰� \x04ȹ�淮 : \x07+ \x1C",EXPIncomeLoc2,"%"})
	f_Mul(FP,UpgradeUILoc,10)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07�� \x08���ݷ� \x04������ : \x07+ \x08",UpgradeUILoc,"%"})
	local TempV = CreateVar(FP)
	CMov(FP,TempV,_Div(_Mul(_Add(iv.CSX_LV3IncmLoc,10),_Add(iv.FMinLoc,10)),_Mov(10)))
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x11LV.MAX \x1B����ƺ�\x04 �� ���� �� ������ : \x07+ \x0F",TempIncmLoc,"% \x04|| \x17ä���� : ",TempV})
	
	
	
	
	
	
	
	
	CIfEnd()
	CIf(FP,{CD(KKey,1)},{SetCD(LKey,0),AddV(AddScLoc,7)})
		CMul(FP,ScoutDmgLoc,100)
		--CIf(FP,{CV(PlayTimeLoc2,1,AtLeast)})
		--CMov(FP,CTimeV,PlayTimeLoc2)
		--CallTrigger(FP,Call_ConvertTime)
		--DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07��Ÿ �׽�Ʈ ���� �÷��� �ð� : \x04",CTimeDD,"�� ",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��"})
		--CIfEnd()
		
		CMov(FP,CTimeV,PlayTimeLoc)
		CallTrigger(FP,Call_ConvertTime)
		local TempV = CreateVar(FP)
		local TempV2 = CreateVar(FP)
		local TempV3 = CreateVar(FP)
		CMov(FP,TempV,iv.DayCheck2Loc,nil,0xFF,1)
		CMov(FP,TempV2,iv.DayCheck2Loc,nil,0xFF00,1)
		CMov(FP,TempV3,iv.DayCheck2Loc,nil,0xFF0000,1)
		CrShift(FP, TempV2, 8)
		CrShift(FP, TempV3, 16)
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07�� �ΰ��� �÷��� �ð� : \x04",CTimeDD,"�� ",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��"})
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x1F44�� \x07Ÿ�Ӿ��� ���� : \x04",TimeAttackScoreLoc," || \x1B48�� \x07Ÿ�Ӿ��� ���� : \x04",TimeAttackScore48Loc})
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x0750�� \x07Ÿ�Ӿ��� ���� : \x04",iv.TimeAttackScore50Loc})
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07�� ����(1,2,3����) �⼮�ϼ� \x04: ",TempV,"��, ",TempV2,"��, ",TempV3,"��."})
		
		local TempV = CreateVar(FP)
		local TempV2 = CreateVar(FP)
		local TempV3 = CreateVar(FP)
		local TempV4 = CreateVar(FP)
		CMov(FP,TempV,_Sub(_Mov(FirstReward3[1][5]*1),_Mov(iv.FirstRewardLimLoc,1*255)),nil,1*255)
		CMov(FP,TempV2,_Sub(_Mov(FirstReward3[2][5]*256),_Mov(iv.FirstRewardLimLoc,256*255)),nil,256*255)
		CMov(FP,TempV3,_Sub(_Mov(FirstReward3[3][5]*65536),_Mov(iv.FirstRewardLimLoc,65536*255)),nil,65536*255)
		CMov(FP,TempV4,_Sub(_Mov(FirstReward3[4][5]*16777216),_Mov(iv.FirstRewardLimLoc,16777216*255)),nil,16777216*255)
		CrShift(FP,TempV2,(2-1)*8)
		CrShift(FP,TempV3,(3-1)*8)
		CrShift(FP,TempV4,(4-1)*8)

		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07���� ���� ù �޼� ���� \x04Ƚ�� - "..FirstReward3[1][4].."45�� : \x04",TempV,"ȸ, "..FirstReward3[2][4].."46�� : \x04",TempV2,"ȸ, "..FirstReward3[3][4].."47�� : \x04",TempV3,"ȸ, "..FirstReward3[4][4].."48�� : \x04",TempV4,"ȸ"})
		
		CMov(FP,TempV,_Sub(_Mov(FirstReward4[1][5]*1),_Mov(iv.FirstRewardLim2Loc,1*255)),nil,1*255)
		CMov(FP,TempV2,_Sub(_Mov(FirstReward4[2][5]*256),_Mov(iv.FirstRewardLim2Loc,256*255)),nil,256*255)
		CrShift(FP,TempV2,(2-1)*8)
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x07���� �ְ� ù �޼� ���� \x04Ƚ�� - "..FirstReward4[1][4].."49�� : \x04",TempV,"ȸ, "..FirstReward4[2][4].."50�� : \x04",TempV2,"ȸ (���� ����ϸ��� �ʱ�ȭ)"})
		
		

	
	CIfEnd()
	
	CIfX(FP,{CD(LKey,1)})
	
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x19���� �Ǹű� \x04: \x07",SellTicketLoc," \x04|| \x08���� Ƽ��\x04(\x08����X\x04) : \x08",iv.BuyTicketLoc," \x04\x12[\x17�ݱ� \x04: \x10L]"})
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x10��ȭ�� ��� \x04: \x07",VaccItemLoc," \x04|| \x1FȮ�� ��ȭ�� \x1F(\x02��\x04,\x1F�Ź���) \x04: \x02",PETicketLoc,", \x1F",iv.PETicket2Loc})
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� \x1E������ ���� \x04: \x07",iv.AwakItemLoc})
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� "..FirstReward3[1][4].."45�� \x04~ "..FirstReward3[4][4].."48�� \x07�Ǹ� \x04Ƚ�� - "..FirstReward3[1][4].."45�� : \x04",iv.S45Loc,"ȸ, "..FirstReward3[2][4].."46�� : \x04",iv.S46Loc,"ȸ, "..FirstReward3[3][4].."47�� : \x04",iv.S47Loc,"ȸ, "..FirstReward3[4][4].."48�� : \x04",iv.S48Loc,"ȸ"})
	--CIf(FP,CV(NextOreLoc,1,AtLeast))
	--	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� ����� \x0ELV.1 \x07�� ������ ",NextOreMulLoc," \x08���׷��̵�\x04�� �ʿ��� \x1BDPS\x1F(�̳׶�)\x04 : \x1F",NextOreLoc})
	--CIfEnd()

--	--CIf(FP,CV(NextGasLoc,1,AtLeast))
	--	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04���� ����� \x0FLV.2 \x07�� ������ ",NextGasMulLoc," \x08���׷��̵�\x04�� �ʿ��� \x1BDPS\x07(����)\x04 : \x07",NextGasLoc})
	--CIfEnd()
--		for i = 0, 6 do
--			CIf(FP,HumanCheck(i, 1))
--			CIfX(FP,{CV(LV5Cool[i+1],1,AtLeast)})
--			CMov(FP,CTimeV,LV5Cool[i+1])
--			CallTrigger(FP,Call_ConvertTime)
--			DisplayPrint(LCP, {PName(i)," \x04���� \x1F���� LV.5 \x04óġ ���ɱ��� ���� �ð� \x04: \x07",CTimeHH,"�ð� ",CTimeMM,"�� ",CTimeSS,"��"})
--			CElseX()
--			DisplayPrint(LCP, {PName(i)," \x04���� \x1F���� LV.5 \x04óġ ���ɱ��� ���� �ð� \x04: \x07óġ ����! "})
--			CIfXEnd()
--	
--			CIfEnd()
--		end
		CTrigger(FP,{CD(LToggle,1)},{SetCD(LToggle,0),TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\n\n\n\n\n\n\n",4)},1)
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
			"\x13\x08LV.1 \x04�ǹ��� 1~25�� ����, \x0FLV.2 \x04�ǹ��� 26~40�� ����, \x11LV.MAX \x04�ǹ��� 41�� ���� �������� ���� �����ϸ�",
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
			"\x13\x0426�� ���� ���ֺ��ʹ� �ǸŽ� ����ġ�� ���� ���������� \x19���� �Ǹű�\x04�� �ʿ��մϴ�.",
			"\x13\x19���� �Ǹű�\x04�� 100ũ���� �� 1���� �����ϰų� ���� �������� ���� �� �ֽ��ϴ�.",
			"\x13\x04\x19���� �Ǹű�\x04�� ������ \x08������ �Ǹ��� �� �����ϴ�.",
			"\x13\x04���� \x19���� �Ǹű�\x07�� SCA ���� ���� ������\x04�Դϴ�. �ٸ� ���ӿ��� �ٽ� ����� �� �ֽ��ϴ�.",
		},
		{
			"\x13\x04\x1B- ���� ���� �ý���\x08(�� 8000���� �̻� ������ �̿� ����)\x1B -",
			"\x13\x04SCA �ε尡 �����Ǹ� �ڽŸ��� \x07���� ����\x04�� �����˴ϴ�.",
			"\x13\x04�� ���������� \x08�ִ� 10��\x04���� �� �� ������ ��ȭ�� �Ѵٰ� � ȿ���� �ٷ� �־����°� �ƴմϴ�.",
			"\x13\x0410���� �޼��ϰ� \x17100�� ũ����\x04�� ����Ͽ� ���ϴ� �ɼ� ȹ��� �Բ� \x1F�±�\x04�� �� �ֽ��ϴ�.",
			"\x13\x04�±� �ɼ� ���� ���ķδ� \x08�ǵ����Ⱑ �Ұ���\x04�մϴ�. ���ϴ� �ɼ��� �����ϰ� �������ּ���.",
		},
	
		{
			"\x13\x04\x1B- �η�. ������ �⺻���� ����� \x1B-",
			"\x13\x04���� �ε尡 �Ϸ�Ǹ� �ΰ��� 3�а� ��밡���� �⺻������ ���޵˴ϴ�.",
			"\x13\x04�⺻������ �ڽ��� ������ ���� ������ �޶����ϴ�.",
			"\x13\x04\x08������ \x04: 10������ 100����, �ִ� 25000 ",
			"\x13\x04\x04�⺻���� \x10���� \x04: �⺻ 7��, 1000������ 1�� �߰�, �ִ� 12��",
			"\x13\x04\x07���ݼӵ� \x04: �⺻ ��Ÿ�� 9, 1000������ 1 ����, �ּ� ��Ÿ�� 1",
		},
		{
			"\x13\x04\x1B- �η�. \x0E���� �÷��� ���ʽ�, ���� �ý��� \x1B-",
			"\x13\x04�� ���ӿ��� \x0E���� �÷��� ���ʽ� ����\x04�� �����մϴ�. ó�� �Ͻô� �е��� 2�� �̻� �÷��̸� \x08�ſ� �����մϴ�.",
			"\x13\x04\x1F2~7�� ���ʽ� ���� \x1C- \x08���ݷ� + 150%\x04, \x07+1�� \x17��ȭȮ�� + \x0F1.0%p",
			"\x13\x08��, SCA �ε尡 \x072�� �̻� \x08�Ϸ�Ǿ�� ���� ���� �˴ϴ�. (���� �ε� \x071������ \x04��Ƽ�÷����� ��� \x08���� ���� �Ұ�\x04)",
			"\x13\x04\x08���� ���� ���� \x04������ 25�� ���� ���ָ� ���κ��� ���� �����ϸ� \x0F1�ʰ��� ������(DPS)\x04���� Ŭ���� ���θ� �����մϴ�.",
			"\x13\x04���κ��� \x07LV.6 \x04�̻���ʹ� \x1041�� �̻� ���ֺ��� ���� ����\x04�ϸ� \x071ȸ ���� ��ü ������ �ֽ��ϴ�.",
			"\x13\x04\x08��Ƽ ���� ���� \x04������ 26��~40�� �������� ���� �����ϸ� \x081�а��� ������(DPM)\x04���� Ŭ���� ���θ� �����մϴ�.",
		},
	
	--���°� �� 250% ��Ȯ�� ���
		{
			"\x13\x04\x1B- �η�. \x08���� ���� ���� ���� ��� \x1B-",
			"\x041�ܰ� \x04: \x0F+1Ȯ��\x07+1.0%p \x1B����� \x07+3 \x12\x046�ܰ� : \x1715�� ũ����, \x02���� ����\x04 3��, \x07���� ȿ��",
			"\x042�ܰ� \x04: \x0F+1Ȯ��\x07+1.0%p \x1B����� \x07+3 \x12\x047�ܰ� \x04: \x17100�� ũ����, \x02���� ����\x04 5��",
			"\x043�ܰ� \x04: \x0F+1Ȯ��\x07+1.0%p \x1B����� \x07+3, \x08��+50% \x12\x048�ܰ� \x04: \x02���� ����\x04 250��, \x19���� �Ǹű� 10����",
			"\x044�ܰ� \x04: \x1B����� \x07+6, \x08���ݷ� + 50%, \x1C�߰�EXP +10% \x12\x049�ܰ� \x04: \x02���� ����\x04 1����",
			"\x045�ܰ� \x04: \x1B����� \x07+9, \x08��+50%, \x1CEXP+10%, \x19���� �Ǹű� 5�� \x12\x0410�ܰ� \x04: \x19���� �Ǹű� 100���� ",
			"\x046�ܰ� ���κ��� ���ĺ��ʹ� \x08��Ƽ ���� 5�ܰ�\x04�� \x071ȸ �̻� óġ\x04�ؾ� �����մϴ�."
		},
		
		{
			"\x13\x04\x1B- �η�. \x08��Ƽ ���� ���� ���� ��� \x1B-",
			"\x041�ܰ� \x04: \x0F+1Ȯ�� \x07+1.0%p, \x1B����� \x07+6",
			"\x042�ܰ� \x04: \x0F+1Ȯ�� \x07+1.0%p, \x1B����� \x07+6, \x08���ݷ� + 50%, \x17ũ���� +500",
			"\x043�ܰ� \x04: \x17ũ���� +1,000, \x1C�߰�EXP +30%",
			"\x044�ܰ� \x04: \x19���� �Ǹű� + 50, \x08���ݷ� + 50%\x12\x1BExtra \x04LV. \x1DVI \x04: \x1FȮ�� ��ȭ��\x04 1��, \x08���� Ƽ�� 10����, \x07���� ȿ��",
			"\x045�ܰ� \x04: \x175�� ũ����, \x07���� ȿ��\x12\x1CExtra \x04LV. \x1FXI \x04: \x1FȮ�� ��ȭ��\x04 3��, \x17ũ���� +200��",
			"\x12\x08Extra Boss�� SCA���� 2���̻� �ε�ÿ��� ������",
			--"\x04X�ܰ� \x04: ",
			--"\x045�ܰ� ������ óġ�� \x081�ð��� �ΰ��� ��Ÿ��\x04�� �����մϴ�."
		},
		
		{
			"\x13\x04\x1B- �η�. \x1C45�� \x04���� ù �޼� ���� \x1B-",
			FirstReward3[1][4].."45�� \x04: \x17ũ���� "..Convert_Number(FirstReward3[1][2])..", \x02���� ���� "..Convert_Number(FirstReward3[1][3]).."��. \x04���� ����"..FirstReward3[1][5].."ȸ",
			FirstReward3[2][4].."46�� \x04: \x17ũ���� "..Convert_Number(FirstReward3[2][2])..", \x02���� ���� "..Convert_Number(FirstReward3[2][3]).."��. \x04���� ����"..FirstReward3[2][5].."ȸ",
			FirstReward3[3][4].."47�� \x04: \x17ũ���� "..Convert_Number(FirstReward3[3][2])..", \x02���� ���� "..Convert_Number(FirstReward3[3][3]).."��. \x04���� ����"..FirstReward3[3][5].."ȸ",
			FirstReward3[4][4].."48�� \x04: \x17ũ���� "..Convert_Number(FirstReward3[4][2])..", \x02���� ���� "..Convert_Number(FirstReward3[4][3]).."��. \x04���� ����"..FirstReward3[4][5].."ȸ",
			FirstReward4[1][4].."49�� \x04: \x17ũ���� "..Convert_Number(FirstReward4[1][2]).."��, \x02���� ���� "..Convert_Number(FirstReward4[1][3]).."��. \x04�ְ� ����"..FirstReward4[1][5].."ȸ\x07 (���� ����� �ʱ�ȭ)",
			FirstReward4[2][4].."50�� \x04: \x17ũ���� "..Convert_Number(FirstReward4[2][2]).."��, \x02���� ���� "..Convert_Number(FirstReward4[2][3]).."��. \x04�ְ� ����"..FirstReward4[2][5].."ȸ\x07 (���� ����� �ʱ�ȭ)",
			--"\x04X�ܰ� \x04: ",
			--"\x045�ܰ� ������ óġ�� \x081�ð��� �ΰ��� ��Ÿ��\x04�� �����մϴ�."
		},
		{
			"\x13\x04\x1B- �η�. \x17ũ���� \x1F���� \x1B-",
			"\x13\x04�ʻ��� ��� ���� ������ ������ �Ϸ�� ���� \x17ũ���� \x1F����\x04�� ���� �������� �����˴ϴ�",
			"\x13\x04�� ���꿡 1ȸ ������ �� ������ \x17ä���� \x04��ŭ�� ũ������ �־����ϴ�. (\x17ä����\x04�� PŰ�� Ȯ�� ����)",
			"\x13\x04ä���� : ä���� ����, ���� Ƚ���� ���� 1.1�辿 ���������� ����",
			"\x13\x041ȸ �ִ� ä�� ���� ũ���� : �⺻ 1�� + 15������ ���� 1������ 20���� ����",
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
		TriggerX(FP, {CV(PageNumLoc,j)}, {DisplayExtText(table.concat(t), 4)}, {preserved})
	end
	CIfEnd()
	CTrigger(FP,{CD(TG,0)},{TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\n\n\n\n\n\n\n\n",4)},1)
	
	
	CIfEnd()
	
	
	CIfEnd()
	
	CMov(FP,0x6509B0,FP)
	
	for i = 0,6 do
		CIf(FP,{HumanCheck(i, 1)})
			local TempFV = CreateVar(FP)
			local FVT = CreateCcode()
			CIf(FP,{CV(iv.B_PFfragItem[i+1],1,AtLeast)},SetCD(FVT,480))
			f_LAdd(FP,iv.FfragItem[i+1],iv.FfragItem[i+1],{iv.B_PFfragItem[i+1],0}) --
			CAdd(FP,TempFV,iv.B_PFfragItem[i+1])
			CMov(FP, iv.B_PFfragItem[i+1], 0)
			CIfEnd({})
			CIf(FP,{CD(FVT,1,AtLeast)},{SubCD(FVT,1)})
				DisplayPrint(i,{"\x13\x07�� \x02���� ����\x04�� \x07",TempFV," �� \x04 ȹ���Ͽ����ϴ�. ���� �� ȹ�淮 : \x07",iv.FfragItem[i+1]," �� \x07��"})
			CIfEnd()
			TriggerX(FP, {CD(FVT,0)}, {SetV(TempFV,0)},{preserved})
		for p = 1,7 do
			local NextT = ""
			local NextT2 = ""
			if p ~= 7 then
				NextT = "���� \x08���\x04 ���� \x1BDPS\x1F(�̳׶�) : \x08"..OreDPS[p+1]
				NextT2 = "���� \x08���\x04 ���� \x1BDPS\x07(����) : \x08"..GasDPS[p+1]
			end
		TriggerX(FP,{CV(iv.TempO[i+1], OreDPS[p],AtLeast)},{
			SetV(iv.BuildMul1[i+1],OreDPSM[p]),
			SetV(iv.NextOre[i+1],OreDPS[p+1]),
			SetV(iv.NextOreMul[i+1],OreDPSM[p+1]),SetCp(i),
			DisplayExtText(StrDesignX("\x1BDPS\x1F(�̳׶�) \x08"..OreDPS[p].." \x04����. ���� �� ��� : \x08"..OreDPSM[p].."��. "..NextT)),SetCp(FP)})--1���ǹ�
		TriggerX(FP,{CV(iv.TempG[i+1], GasDPS[p],AtLeast)},{
			SetV(iv.BuildMul2[i+1],GasDPSM[p]),
			SetV(iv.NextGas[i+1],GasDPS[p+1]),
			SetV(iv.NextGasMul[i+1],GasDPSM[p+1]),SetCp(i),
			DisplayExtText(StrDesignX("\x1BDPS\x07(����) \x08"..GasDPS[p].." \x04����. ���� �� ��� : \x08"..GasDPSM[p].."��. "..NextT2)),SetCp(FP)})--2���ǹ�
		end
		CIfEnd()

	end
--if Limit == 1 then
--	local TempV = CreateVar(FP)
--	local TempV2 = CreateVar(FP)
--	CMov(FP,TempV2,CurrentOP,1)
--	for i = 0, 6 do
--		f_Read(FP, 0x58A364+(48*1)+(4*i), TempV)
--		
--		DisplayPrint(i, {"CurrentOP : ",TempV2,"P    SCA_LastMessage = ",TempV,"   ",})
--		DisplayPrint(i, {SCA.YearV,".",SCA.MonthV,".",SCA.DayV,". ",SCA.HourV," : ",SCA.MinV,"   Week : ",SCA.WeekV})--

--	end
--end


	Trigger2X(FP, {CV(iv.Time3,60000*5,AtLeast)}, {SetV(iv.Time3, 0),SetMemory(0x58F504, SetTo, 0x20000),}, {preserved})
	FixText(FP, 2)    
end