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
		local LVData = {{{0,9},{"０",{0x1000000}}}} 
		local StatEffT = CreateCcode()
		local InterfaceNumLoc2 = CreateCcode()
		DoActionsX(FP,AddCD(StatEffT,1))
		
		CA__SetValue(Str1,"\x07보유금액 \x04:  0000\x04경0000\x04조0000\x04억0000\x04만0000\x0D\x04원\x12\x07사냥터\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)

		CA__SetValue(Str2,"\x07보유금액 \x04: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D \x04원\x12\x17천경： 00000000 \x04개 \x07사냥터\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
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
		CIfX(FP,{CD(Tabkey,1)})--수치표기
		CIfX(FP,{CV(LevelLoc,LevelLimit-1,AtMost)})
		CElseX({TSetNWar(ExpLoc, SetTo, "0"),TSetNWar(TotalExpLoc, SetTo, "0")})
		CIfXEnd()
		CA__SetValue(Str1,"\x07ＬＶ．\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04－",nil,1)
		CA__lItoCustom(SVA1(Str1,12),ExpLoc,nil,nil,{10,15},nil,nil,"\x040",{0x1C,0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
		CA__Input(MakeiStrData("\x08／",1),SVA1(Str1,30))
		CA__lItoCustom(SVA1(Str1,31),TotalExpLoc,nil,nil,{10,15},nil,nil,"\x040",{0x1C,0x1C,0x1C,0x1F,0x1F,0x1F,0x1E,0x1E,0x1E,0x07,0x07,0x07,0x10,0x10,0x10})
		CElseX()--퍼센트표기
		CA__SetValue(Str1,"\x07ＬＶ．\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x04－\x0FＥＸＰ\x04：",nil,1)
		local CurExpTmp = CreateVar(FP)
		local CurExpTmp2 = CreateWar(FP)
		CIfX(FP,{CV(LevelLoc,LevelLimit-1,AtMost)})
		f_LMul(FP, CurExpTmp2,ExpLoc, "20")
		f_Cast(FP, {CurExpTmp,0}, _LDiv(CurExpTmp2,TotalExpLoc), nil, nil, 1)
		CElseX({SetV(CurExpTmp,20)})
		CIfXEnd()
		CA__SetValue(Str1,"\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x04l\x17(Ctrl+TAB:세부값)",nil,16)
		for i = 0, 19 do
			CS__InputTA(FP,{CV(CurExpTmp,i+1,AtLeast)},SVA1(Str1,16+i),0x07,0xFF)
		end
		
		
		
		
		CIfXEnd()
		
		CS__ItoCustom(FP,SVA1(Str1,3),LevelLoc,nil,nil,{10,6},1,nil,"\x1B０",0x1B,nil, LVData)
		TriggerX(FP,{CD(StatEffLoc,1),CD(StatEffT,2,AtLeast)},{SetCD(StatEffT,0),SetCSVA1(SVA1(Str1,0),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,1),SetTo,0x04,0xFF),SetCSVA1(SVA1(Str1,2),SetTo,0x04,0xFF)},{preserved})
		CA__InputVA(56*1,Str1,Str1s,nil,56*1,56*2-2)
		CA__SetValue(Str1,MakeiStrVoid(54),0xFFFFFFFF,0)


		f_LSub(FP,TempFf,iv.FfragItemLoc,iv.FfragItemUsedLoc)
		f_Cast(FP, {TempFf2,0}, TempFf,nil,nil,1)


		CIfX(FP,CD(Tabkey,0))
		CA__SetValue(Str1,"\x12포인트 \x04:  000,000,000 \x04| \x17크레딧 \x04:  123\x04,123\x04,123\x04,123\x04,123",nil,1)
		TriggerX(FP,CV(StatPLoc,999999999,AtLeast),{SetV(StatPLoc,999999999)},{preserved})
        CS__ItoCustom(FP,SVA1(Str1,8),StatPLoc,nil,nil,{10,9},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6,8,9,10}, nil,{0,0,{0},0,0,{0},0,0,{0}})
		CElseX()
		CA__SetValue(Str1,"\x12\x02조각\x0D \x04:  000,000,000 \x04| \x17크레딧 \x04:  123\x04,123\x04,123\x04,123\x04,123",nil,1)
		CTrigger(FP,{TTNWar(TempFf, AtLeast, "999999999")},{SetV(TempFf2,999999999)},{preserved})

        CS__ItoCustom(FP,SVA1(Str1,8),TempFf2,nil,nil,{10,9},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6,8,9,10}, nil,{0,0,{0},0,0,{0},0,0,{0}})
		CIfXEnd()
		CIf(FP,{TTNWar(CredLoc, AtLeast, "999999999999999")})
		f_LMov(FP,CredLoc,"999999999999999")
		CIfEnd()

        CA__lItoCustom(SVA1(Str1,29),CredLoc,nil,nil,{10,15},1,nil,"\x040",{0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x02,0x1E,0x1E,0x1E,0x05,0x05,0x05}
        ,{0,1,2,4,5,6,8,9,10,12,13,14,16,17,18},nil,{0,0,{0},0,0,{0},0,0,{0},0,0,{0}})

	
		CA__InputVA(56*2,Str1,Str1s,nil,56*2,56*3-2)
		CIfX(FP,{CD(Tabkey,1)})--수치표기
		CA__SetColor((56*2)+1, 0x02)
		CA__SetColor((56*2)+23, 0x10)
		CElseX()--퍼센트표기
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
		mmX = mouseX -- 상대좌표 좌측정렬
		mmY = mouseY
		mmX2 = screenX -- 중앙정렬
		mmX3 = screenX2 -- 중앙정렬
		if TestStart == 1 then
		--DisplayPrintEr(0, {"상대좌표 X : ", mmX, "  Y : ", mmY, " || 중앙정렬 X : ", mmX2, "  Y : ", mmY," || 우측정렬 X : ",mmX3,"  Y : ",mmY});
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
		--296~310 각 스탯찍기 버튼
		--274~388 상대좌표 나가기버튼
		
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

		DisplayPrint(LCP, {"\x07능력치 \x04설정. ",ESCB[2],"[나가기 클릭 또는 ESC]",SWAPB[2]," [보석 설정 창으로 이동]\x12",PRVB[2],"[이전 페이지(I)] \x07",InterfaceNumLoc," Page ",NEXB[2],"[다음 페이지(P)]"})--
		TriggerX(FP, CV(ResetStatLoc,0), {DisplayExtText("\x1F[스탯초기화 \x175000 크레딧 \x081시간이내 \x1141강미보유 1회만 \x04Ctrl+O\x1F] \x1F사용가능", 4)}, {preserved})
		TriggerX(FP, CV(ResetStatLoc,1), {DisplayExtText("\x1F[스탯초기화 \x175000 크레딧 \x081시간이내 \x1141강미보유 1회만 \x04Ctrl+O\x1F] \x08사용불가", 4)}, {preserved})
		CIfEnd()
		CIf(FP,{CV(InterfaceNumLoc,256,AtLeast),CV(InterfaceNumLoc,512,AtMost)})
		
		for i = 0, 4 do
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX, 0, 320)},{SetV(CColor1_1[i+1],0x07),SetV(CColor3_1[i+1],0x0E),SetCD(MToggle[i+1],1)},{preserved})--좌측
			TriggerX(FP,{MLine(mmY,6+i),VRange(mmX3, 0, 320)},{SetV(CColor1_2[i+1],0x07),SetV(CColor3_2[i+1],0x0E),SetCD(MToggle[i+1],1)},{preserved})--우측

			
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
			TriggerX(FP,{CV(InterfaceNumLoc,256),CD(CDFnc,1),VRange(mmX, 0, 320)},{SetMemory(0x58F504,SetTo,0x100+i+1)},{preserved})--좌측
			TriggerX(FP,{CV(InterfaceNumLoc,256),CD(CDFnc,1),VRange(mmX3, 0, 320)},{SetMemory(0x58F504,SetTo,0x180+i+1)},{preserved})--우측

			
			TriggerX(FP,{CD(MToggle2[i+1],1),CD(MStat,1)},{SetV(BColor2[i+1],0x08)},{preserved})




		end


		DisplayPrint(LCP, {"\x1C보석 \x04설정. ",ESCB[2],"[나가기 클릭 또는 ESC]",SWAPB[2]," [스탯 설정 창으로 이동]\x12"})--
		TriggerX(FP, CV(ResetStat2Loc,0), {DisplayExtText("\x1C[보석초기화 \x1710만 크레딧 \x081시간이내 \x1141강미보유 1회만 \x04Ctrl+U\x1F] \x1F사용가능", 4)}, {preserved})
		TriggerX(FP, CV(ResetStat2Loc,1), {DisplayExtText("\x1C[보석초기화 \x1710만 크레딧 \x081시간이내 \x1141강미보유 1회만 \x04Ctrl+U\x1F] \x08사용불가", 4)}, {preserved})
		CIfEnd()
--		local TempLoc = CreateVar(FP)
--		CIfX(FP, {CV(ResetStatLoc,4,AtMost)})
--		CMov(FP,TempLoc,_ReadF(ArrX(SRTable, ResetStatLoc)))
--		DisplayPrint(LCP, {"\x1F[스탯초기화 \x17",TempLoc,"크레딧 \x04사용 안했을 경우 \x081시간후 가격 상승 \x04Ctrl+O\x1F]"})
--		
--		CElseX()
--		DoActions(FP, {DisplayExtText("\x1F[스탯초기화 \x08사용불가\x1F] ", 4)})
--		CIfXEnd()


		CIfX(FP,{CV(InterfaceNumLoc,1)},{}) -- 상점 페이지 제어
			--DisplayPrint(LCP, {"\x071. \x08강화 실패\x04시 경험치 획득량 증가 \x07+0.1% \x08MAX 50 - ",BColor3[1][2],Cost_Stat_BossSTic.." Pts\x12\x07 + ",BColor[1][2],EVarArr2,".",EVarArr3," % ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			
			--5보스 처치시 판매권 +10개 증가 최대 20회 1스탯당 50포인트
			--DisplayPrint(LCP, {"\x071. \x08강화 실패\x04시 경험치 획득량 증가 \x07+0.1% \x08MAX 100 ",BColor3[1][2],"빈 항목입니다.\x12\x07 ",BColor[1][2]," - ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			--DisplayPrint(LCP, {"\x071. ",BColor3[1][2],"빈 항목입니다.\x12\x07 ",BColor[1][2]," - ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			--DisplayPrint(LCP, {"\x072. ",BColor3[2][2],"빈 항목입니다.\x12\x07 ",BColor[2][2]," - ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
			CMul(FP,S_BossSTicLoc,100)
			DisplayPrint(LCP, {"\x071. \x08파티 보스 \x1FLV.5, \x1F개인 \x1CLV.6\x04(x2) \x1DExtra\x04(x3) \x04처치시 \x19유닛 판매권 + 100개 \x08MAX 10 - ",BColor3[1][2],Cost_Stat_BossSTic.." Pts\x12\x07+ ",BColor[1][2],S_BossSTicLoc," 개 ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			CMul(FP,S_BossLVUPLoc,50)
			DisplayPrint(LCP, {"\x072. \x08파티 보스 \x1FLV.5, \x1F개인 \x1CLV.6\x04(x2) \x1DExtra\x04(x3) \x04처치시 \x1F레벨 +50업 \x08MAX 5 - ",BColor3[2][2],Cost_Stat_BossLVUP.." Pts\x12\x07+ ",BColor[2][2],S_BossLVUPLoc," LV ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
			CMul(FP,UpgradeLoc,10)
			DisplayPrint(LCP, {"\x073. \x1B보유 유닛 \x08데미지 \x07+10% \x08MAX 50 - ",BColor3[3][2],Cost_Stat_Upgrade.." Pts\x12\x07+ ",BColor[3][2],UpgradeLoc," % ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerLoc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x074. \x07+1 \x08강화확률 \x0F+0.1%p \x08MAX 100 \x04- ",BColor3[4][2],Cost_Stat_TotalEPer.." Pts\x12\x07+ ",BColor[4][2],EVarArr2,".",EVarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPer2Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x075. \x0F+2 \x08강화확률 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[5][2],Cost_Stat_TotalEPer2.." Pts\x12\x07+ ",BColor[5][2],EVarArr2,".",EVarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPer3Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x076. \x10+3 \x08강화확률 \x0F+0.1%p \x08MAX 30 \x04- ",BColor3[6][2],Cost_Stat_TotalEPer3.." Pts\x12\x07+ ",BColor[6][2],EVarArr2,".",EVarArr3," %p ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})
			
		
		CElseIfX({CV(InterfaceNumLoc,2)})
			CMov(FP,MCP,LCP)
			CallTriggerX(FP,Call_SetScrMouse,{},{})
			
			if TestStart == 1 then
				--DisplayPrintEr(0, {"상대좌표 X : ", mmX, "  Y : ", mmY, " || 중앙정렬 X : ", mmX2, "  Y : ", mmY," || 우측정렬 X : ",mmX3,"  Y : ",mmY});
			end
			
			
			CMov(FP,GEVar,S_TotalEPer4Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x071. \x08특수 \x08강화확률 \x0F+0.1%p \x08MAX 100 \x04- ",BColor3[1][2],Cost_Stat_TotalEPer4.." Pts\x12\x07+ ",BColor[1][2],EVarArr2,".",EVarArr3," %p ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			CMov(FP,GEVar,S_BreakShieldLoc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x072. \x08특수 \x1F파괴 방지\x08확률 \x0F+0.1%p \x08MAX 300 \x04- ",BColor3[2][2],Cost_Stat_BreakShield.." Pts\x12\x07+ ",BColor[2][2],EVarArr2,".",EVarArr3," %p ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerExLoc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x073. \x07+1 \x08강화확률 2 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[3][2],Cost_Stat_TotalEPerEx.." Pts\x12\x07+ ",BColor[3][2],EVarArr2,".",EVarArr3," %p ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerEx2Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x074. \x0F+2 \x08강화확률 2 \x0F+0.1%p \x08MAX 20 \x04- ",BColor3[4][2],Cost_Stat_TotalEPerEx2.." Pts\x12\x07+ ",BColor[4][2],EVarArr2,".",EVarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
			CMov(FP,GEVar,S_TotalEPerEx3Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x075. \x0F+3 \x08강화확률 2 \x0F+0.1%p \x08MAX 10 \x04- ",BColor3[5][2],Cost_Stat_TotalEPerEx3.." Pts\x12\x07+ ",BColor[5][2],EVarArr2,".",EVarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
			--DisplayPrint(LCP, {"\x076. \x07기본유닛 \x1B공격 쿨타임 \x04-1 \x08MAX 8 \x04- ",BColor3[6][2],Cost_Stat_LV3Incm.." Pts\x12\x07",BColor[6][2],"9 - ",SCCoolLoc," ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})

			DisplayPrint(LCP, {"\x076. \x11LV.MAX \x1B허수아비\x04 돈 수급량 \x111.0% \x08MAX 100 \x04- ",BColor3[6][2],Cost_Stat_LV3Incm.." Pts\x12\x07+ ",BColor[6][2],S_LV3IncmLoc," % ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})

			CElseIfX({CV(InterfaceNumLoc,3)})
			CMov(FP,GEVar,S_TotalEPer4XLoc)
			CallTrigger(FP, Call_SetEPerStr)
				--DisplayPrintEr(0, {"상대좌표 X : ", mmX, "  Y : ", mmY, " || 중앙정렬 X : ", mmX2, "  Y : ", mmY," || 우측정렬 X : ",mmX3,"  Y : ",mmY});
			DisplayPrint(LCP, {"\x071. \x08특수 \x08강화확률 \x1F2\x04 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[1][2],Cost_Stat_TotalEPer4X.." Pts\x12\x07+ ",BColor[1][2],EVarArr2,".",EVarArr3," %p ",BColor4[1][2],"[M] ",BColor2[1][2],"[+]"})
			CMov(FP,GEVar,S_BreakShield2Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x072. \x08특수 \x1F파괴 방지\x08확률 \x1F2\x04 \x0F+0.1%p \x08MAX 100 \x04- ",BColor3[2][2],Cost_Stat_BreakShield2.." Pts\x12\x07+ ",BColor[2][2],EVarArr2,".",EVarArr3," %p ",BColor4[2][2],"[M] ",BColor2[2][2],"[+]"})


			
			CMov(FP,GEVar,Stat_XEPer44Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x073. \x1F44강 \x08강화확률 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[3][2],Cost_Stat_XEPer44.." Pts\x12\x07+ ",BColor[3][2],EVarArr2,".",EVarArr3," %p ",BColor4[3][2],"[M] ",BColor2[3][2],"[+]"})
			CMov(FP,GEVar,Stat_XEPer45Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x074. \x1C45강 \x08강화확률 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[4][2],Cost_Stat_XEPer45.." Pts\x12\x07+ ",BColor[4][2],EVarArr2,".",EVarArr3," %p ",BColor4[4][2],"[M] ",BColor2[4][2],"[+]"})
			CMov(FP,GEVar,Stat_XEPer46Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x075. \x1E46강 \x08강화확률 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[5][2],Cost_Stat_XEPer46.." Pts\x12\x07+ ",BColor[5][2],EVarArr2,".",EVarArr3," %p ",BColor4[5][2],"[M] ",BColor2[5][2],"[+]"})
			CMov(FP,GEVar,Stat_XEPer47Loc)
			CallTrigger(FP, Call_SetEPerStr)
			DisplayPrint(LCP, {"\x076. \x0247강 \x08강화확률 \x0F+0.1%p \x08MAX 50 \x04- ",BColor3[6][2],Cost_Stat_XEPer47.." Pts\x12\x07+ ",BColor[6][2],EVarArr2,".",EVarArr3," %p ",BColor4[6][2],"[M] ",BColor2[6][2],"[+]"})

			CElseIfX({CV(InterfaceNumLoc,256)})
			
			DisplayPrint(LCP, {CColor4_1[1][2],"[+1] ",CColor5_1[1][2],"[+10] ",CColor6_1[1][2],"[+100] ",CColor1_1[1][2],"하급 보석 ",FXPer44Loc,"개 ",CColor3_1[1][2],"|| Cost : ",Cost_FXPer44Loc,"\x12",CColor3_2[1][2]," Cost : ",Cost_FIncmLoc," || ",CColor1_2[1][2],FIncmLoc," 개 재물의 보석 ",CColor6_2[1][2],"[+100] ",CColor5_2[1][2],"[+10] ",CColor4_2[1][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[2][2],"[+1] ",CColor5_1[2][2],"[+10] ",CColor6_1[2][2],"[+100] ",CColor1_1[2][2],"중급 보석 ",FXPer45Loc,"개 ",CColor3_1[2][2],"|| Cost : ",Cost_FXPer45Loc,"\x12",CColor3_2[2][2]," Cost : ",Cost_FSEXPLoc," || ",CColor1_2[2][2],FSEXPLoc," 개 경험의 보석 ",CColor6_2[2][2],"[+100] ",CColor5_2[2][2],"[+10] ",CColor4_2[2][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[3][2],"[+1] ",CColor5_1[3][2],"[+10] ",CColor6_1[3][2],"[+100] ",CColor1_1[3][2],"상급 보석 ",FXPer46Loc,"개 ",CColor3_1[3][2],"|| Cost : ",Cost_FXPer46Loc,"\x12",CColor3_2[3][2]," Cost : ",Cost_FBrShLoc," || ",CColor1_2[3][2],FBrShLoc," 개 보호의 보석 ",CColor6_2[3][2],"[+100] ",CColor5_2[3][2],"[+10] ",CColor4_2[3][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[4][2],"[+1] ",CColor5_1[4][2],"[+10] ",CColor6_1[4][2],"[+100] ",CColor1_1[4][2],"특급 보석 ",FXPer47Loc,"개 ",CColor3_1[4][2],"|| Cost : ",Cost_FXPer47Loc,"\x12",CColor3_2[4][2]," Cost : ",Cost_FMEPerLoc," || ",CColor1_2[4][2],FMEPerLoc," 개 궁극의 보석 ",CColor6_2[4][2],"[+100] ",CColor5_2[4][2],"[+10] ",CColor4_2[4][2],"[+1]"})
			DisplayPrint(LCP, {CColor4_1[5][2],"[+1] ",CColor5_1[5][2],"[+10] ",CColor6_1[5][2],"[+100] ",CColor1_1[5][2],"고급 보석 ",FXPer48Loc,"개 ",CColor3_1[5][2],"|| Cost : ",Cost_FXPer48Loc,"\x12",CColor3_2[5][2]," Cost : ",Cost_FMinLoc," || ",CColor1_2[5][2],FMinLoc," 개 채광의 보석 ",CColor6_2[5][2],"[+100] ",CColor5_2[5][2],"[+10] ",CColor4_2[5][2],"[+1]"})

			if Limit == 0 then
				--CDoActions(FP, {TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\x13무색조각 \x08사용중 \x04/ \x04누적 획득량 (\x07사용가능\x04) 갯수", 4)})
			else
				--CDoActions(FP, {TSetMemory(0x6509B0,SetTo,LCP),DisplayExtText("\x13무색조각 \x08사용중 \x04/ \x04누적 획득량 (\x07사용가능\x04) 갯수 - \x03TESTMODE 조각 지급받기 \x04F12버튼\x08(1회만)", 4)})
			end
			DisplayPrint(LCP, {"무색조각 \x08사용중 \x04/ \x04누적 획득량 (\x07사용가능\x04) 갯수\x12\x08",iv.FfragItemUsedLoc," \x04/ ",iv.FfragItemLoc," (\x07",TempFf,"\x04)"})
		CIfXEnd()
		DoActions(FP,{SetCp(FP)})
		local StatPrintEr = {
			--StrDesign("\x04게임 시작시 처음 지급하는 \x07기본유닛(스카웃) \x08데미지\x04를 증가시킵니다. \x08주의 \x04: \x07기본유닛\x04은 3분 뒤 사라집니다."),
			--StrDesign("\x04게임 시작시 처음 지급하는 \x07기본유닛(스카웃) \x0F갯수\x04를 증가시킵니다. \x08주의 \x04: \x07기본유닛\x04은 3분 뒤 사라집니다."),
			StrDesign("\x08파티 보스 \x1FLV.5 \x04처치시 \x19유닛 판매권\x04을 얻습니다. \x1F개인 \x1CLV.6\x04(x2) \x1DExtra\x04(x3)."),
			StrDesign("\x08파티 보스 \x1FLV.5 \x04처치시 \x1C레벨\x04이 증가합니다. \x08주의 \x04: \x1C최대 경험치\x04는 \x08최대 50억, \x1F개인 \x1CLV.6\x04(x2) \x1DExtra\x04(x3)"),
			StrDesign("\x04자신의 \x07강화 \x04유닛 \x08데미지\x04를 증가시킵니다."),
			StrDesign("\x07+1\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: \x07+2, \x10+3 \x04강화확률에 대한 영향은 \x08없습니다."),
			StrDesign("\x07+2\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0F36강 \x04유닛 이상부터 +1로 합산, 적용됩니다."),
			StrDesign("\x10+3\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0F35강\x04:\x08+2로, \x0F36강\x04:\x08+1로\x04 합산 적용됩니다."),
			StrDesign("\x08특수\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0840강 이후 유닛\x04만 적용됩니다."),
			StrDesign("\x08특수\x1F 파괴 방지\x08확률\x04을 증가시킵니다. \x08주의 \x04: 이 항목은 \x0840강 이후 유닛\x04만 적용됩니다."),
			StrDesign("\x10추가 \x07+1\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 먼저 1페이지 강화확률 스탯을 \x07마스터 \x04하시길 권장합니다."),
			StrDesign("\x10추가 \x0F+2\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 먼저 1페이지 강화확률 스탯을 \x07마스터 \x04하시길 권장합니다."),
			StrDesign("\x10추가 \x0F+3\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 먼저 1페이지 강화확률 스탯을 \x07마스터 \x04하시길 권장합니다."),
			StrDesign("\x11LV.MAX \x1B허수아비\x04 돈 수급량을 1% 증가시킵니다. \x07기본값 : 100%. \x08주의 \x04: 이 항목은 \x1041강 \x07이상 \x04유닛에게 유효합니다."),
			StrDesign("\x08특수\x08 강화확률\x04을 증가시킵니다. \x08주의 \x04: 먼저 2페이지 특수확률 스탯을 \x07마스터 \x04하시길 권장합니다."),
			StrDesign("\x08특수\x1F 파괴 방지\x08확률\x04을 증가시킵니다. \x08주의 \x04: 먼저 2페이지 파괴방지 스탯을 \x07마스터 \x04하시길 권장합니다."),
			StrDesign("\x1F44강 \x08강화 \x04시도시 \x08강화확률\x04을 증가시킵니다."),
			StrDesign("\x1C45강 \x08강화 \x04시도시 \x08강화확률\x04을 증가시킵니다."),
			StrDesign("\x1E46강 \x08강화 \x04시도시 \x08강화확률\x04을 증가시킵니다."),
			StrDesign("\x0247강 \x08강화 \x04시도시 \x08강화확률\x04을 증가시킵니다."),
	}
	
	local StatPrintEr2 = {
		StrDesign("\x04개당 \x0F0.1%p\x04의 \x1F44강 \x08강화확률 \x04증가. \x08MAX "..Cost_FXPer44[2].." 개"),
		StrDesign("\x04개당 \x0F0.1%p\x04의 \x1C45강 \x08강화확률 \x04증가. \x08MAX "..Cost_FXPer45[2].." 개"),
		StrDesign("\x04개당 \x0F0.1%p\x04의 \x1E46강 \x08강화확률 \x04증가. \x08MAX "..Cost_FXPer46[2].." 개"),
		StrDesign("\x04개당 \x0F0.1%p\x04의 \x0247강 \x08강화확률 \x04증가. \x08MAX "..Cost_FXPer47[2].." 개"),
		StrDesign("\x04개당 \x0F0.005%p\x04의 \x1B48강 \x08강화확률 \x04증가. \x08MAX "..Cost_FXPer48[2].." 개"),
}
	local StatPrintEr3 = {
		StrDesign("\x04개당 \x110.1배\x04의 \x11LV.MAX \x1B허수아비\x04 돈 수급량 증가. \x08MAX "..Cost_FIncm[2].." 개"),
		StrDesign("\x04개당 \x1C10%\x04의 \x1C판매시 경험치량 \x04증가. \x08MAX "..Cost_FSEXP[2].." 개"),
		StrDesign("\x04개당 \x0F0.1%p\x04의 \x1F파괴 방지 확률 \x04증가. \x08MAX "..Cost_FBrSh[2].." 개"),
		StrDesign("\x0649강\x04,\x0750강 \x11제외\x04. \x04개당 \x0F0.01%p\x04의 \x1F모\x1C든\x1E유\x07닛 \x08강화확률 \x04증가. \x08MAX "..Cost_FMEPer[2].." 개"),
		StrDesign("\x04개당 \x0F0.1배\x04의 \x17크레딧 채광속도 \x04증가. \x08MAX "..Cost_FMin[2].." 개"),
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
	CIf(FP,{CV(InterfaceNumLoc,0)})--아무 설정창도 켜져있지 않을 경우 작동함
	local temp,PKey = ToggleFunc({KeyPress("P","Up"),KeyPress("P","Down")},nil,1)--누를 경우 현재 적용중인 버프 상세 표기
	local temp,KKey = ToggleFunc({KeyPress("K","Up"),KeyPress("K","Down")},nil,1)--누를 경우 현재 보유 재화 표시
	local LKey = KeyToggleFunc("L") --지속적으로 표기함
	local temp,BKey = ToggleFunc({KeyPress("B","Up"),KeyPress("B","Down")},nil,1)--누를 경우 설명서 출력
	local temp,NKey = ToggleFunc({KeyPress("N","Up"),KeyPress("N","Down")},nil,1)--누를 경우 설명서 출력
	local temp,MKey = ToggleFunc({KeyPress("M","Up"),KeyPress("M","Down")},nil,1)--누를 경우 설명서 출력
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
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07+1 \x08강화확률 : \x07+ \x0F",EVarArr2,".",EVarArr3,"%p \x04|| \x1F44강 \x08강화확률 : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p",})
	CMov(FP,GEVar,TotalEPer2Loc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer45Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07+2 \x08강화확률 : \x07+ \x0F",EVarArr2,".",EVarArr3,"%p \x04|| \x1C45강 \x08강화확률 : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p",})
	CMov(FP,GEVar,TotalEPer3Loc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer46Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x10+3 \x08강화확률 : \x07+ \x0F",EVarArr2,".",EVarArr3,"%p \x04|| \x1E46강 \x08강화확률 : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p",})
	CMov(FP,GEVar,TotalEPer4Loc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer47Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x08특수 \x08강화확률 \x04총 증가량 : \x07+ \x08",EVarArr2,".",EVarArr3,"%p \x04|| \x0247강 \x08강화확률 : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p"})
	CMov(FP,GEVar,BreakShieldLoc)
	CallTrigger(FP, Call_SetEPerStr)
	CMov(FP,GEVar_2,XEPer48Loc)
	CallTrigger(FP, Call_SetEPerStr2)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x08특수 \x1F파괴 방지\x08확률 \x04총 증가량 : \x07+ \x1F",EVarArr2,".",EVarArr3,"%p \x04|| \x1B48강 \x08강화확률 : \x07+ \x0F",EVarArr2_2,".",EVarArr3_2,"%p"})
	f_Mul(FP,EXPIncomeLoc2,10)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x1C판매시 경험치 \x07추가 \x04획득량 : \x07+ \x1C",EXPIncomeLoc2,"%"})
	f_Mul(FP,UpgradeUILoc,10)
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07총 \x08공격력 \x04증가량 : \x07+ \x08",UpgradeUILoc,"%"})
	local TempV = CreateVar(FP)
	CMov(FP,TempV,_Div(_Mul(_Add(iv.CSX_LV3IncmLoc,10),_Add(iv.FMinLoc,10)),_Mov(10)))
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x11LV.MAX \x1B허수아비\x04 돈 수급 총 증가량 : \x07+ \x0F",TempIncmLoc,"% \x04|| \x17채광력 : ",TempV})
	
	
	
	
	
	
	
	
	CIfEnd()
	CIf(FP,{CD(KKey,1)},{SetCD(LKey,0),AddV(AddScLoc,7)})
		CMul(FP,ScoutDmgLoc,100)
		--CIf(FP,{CV(PlayTimeLoc2,1,AtLeast)})
		--CMov(FP,CTimeV,PlayTimeLoc2)
		--CallTrigger(FP,Call_ConvertTime)
		--DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07베타 테스트 버전 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
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
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07총 인게임 플레이 시간 : \x04",CTimeDD,"일 ",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x1F44강 \x07타임어택 점수 : \x04",TimeAttackScoreLoc," || \x1B48강 \x07타임어택 점수 : \x04",TimeAttackScore48Loc})
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x0750강 \x07타임어택 점수 : \x04",iv.TimeAttackScore50Loc})
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07각 시즌별(1,2,3시즌) 출석일수 \x04: ",TempV,"일, ",TempV2,"일, ",TempV3,"일."})
		
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

		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07남은 일일 첫 달성 보상 \x04횟수 - "..FirstReward3[1][4].."45강 : \x04",TempV,"회, "..FirstReward3[2][4].."46강 : \x04",TempV2,"회, "..FirstReward3[3][4].."47강 : \x04",TempV3,"회, "..FirstReward3[4][4].."48강 : \x04",TempV4,"회"})
		
		CMov(FP,TempV,_Sub(_Mov(FirstReward4[1][5]*1),_Mov(iv.FirstRewardLim2Loc,1*255)),nil,1*255)
		CMov(FP,TempV2,_Sub(_Mov(FirstReward4[2][5]*256),_Mov(iv.FirstRewardLim2Loc,256*255)),nil,256*255)
		CrShift(FP,TempV2,(2-1)*8)
		DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x07남은 주간 첫 달성 보상 \x04횟수 - "..FirstReward4[1][4].."49강 : \x04",TempV,"회, "..FirstReward4[2][4].."50강 : \x04",TempV2,"회 (매주 목요일마다 초기화)"})
		
		

	
	CIfEnd()
	
	CIfX(FP,{CD(LKey,1)})
	
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x19유닛 판매권 \x04: \x07",SellTicketLoc," \x04|| \x08구입 티켓\x04(\x08저장X\x04) : \x08",iv.BuyTicketLoc," \x04\x12[\x17닫기 \x04: \x10L]"})
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x10강화기 백신 \x04: \x07",VaccItemLoc," \x04|| \x1F확정 강화권 \x1F(\x02구\x04,\x1F신버전) \x04: \x02",PETicketLoc,", \x1F",iv.PETicket2Loc})
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 \x1E각성의 보석 \x04: \x07",iv.AwakItemLoc})
	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 "..FirstReward3[1][4].."45강 \x04~ "..FirstReward3[4][4].."48강 \x07판매 \x04횟수 - "..FirstReward3[1][4].."45강 : \x04",iv.S45Loc,"회, "..FirstReward3[2][4].."46강 : \x04",iv.S46Loc,"회, "..FirstReward3[3][4].."47강 : \x04",iv.S47Loc,"회, "..FirstReward3[4][4].."48강 : \x04",iv.S48Loc,"회"})
	--CIf(FP,CV(NextOreLoc,1,AtLeast))
	--	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 사냥터 \x0ELV.1 \x07돈 증가량 ",NextOreMulLoc," \x08업그레이드\x04에 필요한 \x1BDPS\x1F(미네랄)\x04 : \x1F",NextOreLoc})
	--CIfEnd()

--	--CIf(FP,CV(NextGasLoc,1,AtLeast))
	--	DisplayPrint(LCP, {PName("LocalPlayerID")," \x04님의 사냥터 \x0FLV.2 \x07돈 증가량 ",NextGasMulLoc," \x08업그레이드\x04에 필요한 \x1BDPS\x07(가스)\x04 : \x07",NextGasLoc})
	--CIfEnd()
--		for i = 0, 6 do
--			CIf(FP,HumanCheck(i, 1))
--			CIfX(FP,{CV(LV5Cool[i+1],1,AtLeast)})
--			CMov(FP,CTimeV,LV5Cool[i+1])
--			CallTrigger(FP,Call_ConvertTime)
--			DisplayPrint(LCP, {PName(i)," \x04님의 \x1F보스 LV.5 \x04처치 가능까지 남은 시간 \x04: \x07",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초"})
--			CElseX()
--			DisplayPrint(LCP, {PName(i)," \x04님의 \x1F보스 LV.5 \x04처치 가능까지 남은 시간 \x04: \x07처치 가능! "})
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
			"\x13\x08LV.1 \x04건물은 1~25강 유닛, \x0FLV.2 \x04건물은 26~40강 유닛, \x11LV.MAX \x04건물은 41강 이후 유닛으로 입장 가능하며",
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
			"\x13\x0426강 이후 유닛부터는 판매시 경험치가 대폭 증가하지만 \x19유닛 판매권\x04이 필요합니다.",
			"\x13\x19유닛 판매권\x04은 100크레딧 당 1개로 구입하거나 보스 공략으로 얻을 수 있습니다.",
			"\x13\x04\x19유닛 판매권\x04이 없으면 \x08유닛을 판매할 수 없습니다.",
			"\x13\x04또한 \x19유닛 판매권\x07은 SCA 저장 가능 아이템\x04입니다. 다른 게임에서 다시 사용할 수 있습니다.",
		},
		{
			"\x13\x04\x1B- 고유 유닛 시스템\x08(약 8000레벨 이상 컨텐츠 이용 권장)\x1B -",
			"\x13\x04SCA 로드가 성공되면 자신만의 \x07고유 유닛\x04이 생성됩니다.",
			"\x13\x04이 고유유닛은 \x08최대 10강\x04까지 할 수 있지만 강화를 한다고 어떤 효과가 바로 주어지는건 아닙니다.",
			"\x13\x0410강을 달성하고 \x17100만 크레딧\x04을 사용하여 원하는 옵션 획득과 함께 \x1F승급\x04할 수 있습니다.",
			"\x13\x04승급 옵션 선택 이후로는 \x08되돌리기가 불가능\x04합니다. 원하는 옵션을 신중하게 선택해주세요.",
		},
	
		{
			"\x13\x04\x1B- 부록. 레벨별 기본유닛 스펙업 \x1B-",
			"\x13\x04런쳐 로드가 완료되면 인게임 3분간 사용가능한 기본유닛이 지급됩니다.",
			"\x13\x04기본유닛은 자신의 레벨에 따라 스펙이 달라집니다.",
			"\x13\x04\x08데미지 \x04: 10레벨당 100증가, 최대 25000 ",
			"\x13\x04\x04기본유닛 \x10갯수 \x04: 기본 7개, 1000레벨당 1기 추가, 최대 12개",
			"\x13\x04\x07공격속도 \x04: 기본 쿨타임 9, 1000레벨당 1 감소, 최소 쿨타임 1",
		},
		{
			"\x13\x04\x1B- 부록. \x0E다인 플레이 보너스, 보스 시스템 \x1B-",
			"\x13\x04이 게임에는 \x0E다인 플레이 보너스 버프\x04가 존재합니다. 처음 하시는 분들은 2인 이상 플레이를 \x08매우 권장합니다.",
			"\x13\x04\x1F2~7인 보너스 버프 \x1C- \x08공격력 + 150%\x04, \x07+1강 \x17강화확률 + \x0F1.0%p",
			"\x13\x08단, SCA 로드가 \x072명 이상 \x08완료되어야 영구 유지 됩니다. (런쳐 로드 \x071인이하 \x04멀티플레이일 경우 \x08영구 유지 불가\x04)",
			"\x13\x04\x08개인 보스 몬스터 \x04지역은 25강 이하 유닛만 개인별로 공략 가능하며 \x0F1초간의 데미지(DPS)\x04으로 클리어 여부를 결정합니다.",
			"\x13\x04개인보스 \x07LV.6 \x04이상부터는 \x1041강 이상 유닛부터 공략 가능\x04하며 \x071회 한정 전체 보상이 있습니다.",
			"\x13\x04\x08파티 보스 몬스터 \x04지역은 26강~40강 유닛으로 입장 가능하며 \x081분간의 데미지(DPM)\x04으로 클리어 여부를 결정합니다.",
		},
	
	--남는거 공 250% 강확은 논외
		{
			"\x13\x04\x1B- 부록. \x08개인 보스 몬스터 보상 목록 \x1B-",
			"\x041단계 \x04: \x0F+1확률\x07+1.0%p \x1B사냥터 \x07+3 \x12\x046단계 : \x1715만 크레딧, \x02무색 조각\x04 3개, \x07스탯 효과",
			"\x042단계 \x04: \x0F+1확률\x07+1.0%p \x1B사냥터 \x07+3 \x12\x047단계 \x04: \x17100만 크레딧, \x02무색 조각\x04 5개",
			"\x043단계 \x04: \x0F+1확률\x07+1.0%p \x1B사냥터 \x07+3, \x08공+50% \x12\x048단계 \x04: \x02무색 조각\x04 250개, \x19유닛 판매권 10만개",
			"\x044단계 \x04: \x1B사냥터 \x07+6, \x08공격력 + 50%, \x1C추가EXP +10% \x12\x049단계 \x04: \x02무색 조각\x04 1만개",
			"\x045단계 \x04: \x1B사냥터 \x07+9, \x08공+50%, \x1CEXP+10%, \x19유닛 판매권 5개 \x12\x0410단계 \x04: \x19유닛 판매권 100만개 ",
			"\x046단계 개인보스 이후부터는 \x08파티 보스 5단계\x04를 \x071회 이상 처치\x04해야 출현합니다."
		},
		
		{
			"\x13\x04\x1B- 부록. \x08파티 보스 몬스터 보상 목록 \x1B-",
			"\x041단계 \x04: \x0F+1확률 \x07+1.0%p, \x1B사냥터 \x07+6",
			"\x042단계 \x04: \x0F+1확률 \x07+1.0%p, \x1B사냥터 \x07+6, \x08공격력 + 50%, \x17크레딧 +500",
			"\x043단계 \x04: \x17크레딧 +1,000, \x1C추가EXP +30%",
			"\x044단계 \x04: \x19유닛 판매권 + 50, \x08공격력 + 50%\x12\x1BExtra \x04LV. \x1DVI \x04: \x1F확정 강화권\x04 1개, \x08구입 티켓 10만개, \x07스탯 효과",
			"\x045단계 \x04: \x175만 크레딧, \x07스탯 효과\x12\x1CExtra \x04LV. \x1FXI \x04: \x1F확정 강화권\x04 3개, \x17크레딧 +200만",
			"\x12\x08Extra Boss는 SCA런쳐 2인이상 로드시에만 출현함",
			--"\x04X단계 \x04: ",
			--"\x045단계 보스는 처치후 \x081시간의 인게임 쿨타임\x04이 존재합니다."
		},
		
		{
			"\x13\x04\x1B- 부록. \x1C45강 \x04이후 첫 달성 보상 \x1B-",
			FirstReward3[1][4].."45강 \x04: \x17크레딧 "..Convert_Number(FirstReward3[1][2])..", \x02무색 조각 "..Convert_Number(FirstReward3[1][3]).."개. \x04일일 제한"..FirstReward3[1][5].."회",
			FirstReward3[2][4].."46강 \x04: \x17크레딧 "..Convert_Number(FirstReward3[2][2])..", \x02무색 조각 "..Convert_Number(FirstReward3[2][3]).."개. \x04일일 제한"..FirstReward3[2][5].."회",
			FirstReward3[3][4].."47강 \x04: \x17크레딧 "..Convert_Number(FirstReward3[3][2])..", \x02무색 조각 "..Convert_Number(FirstReward3[3][3]).."개. \x04일일 제한"..FirstReward3[3][5].."회",
			FirstReward3[4][4].."48강 \x04: \x17크레딧 "..Convert_Number(FirstReward3[4][2])..", \x02무색 조각 "..Convert_Number(FirstReward3[4][3]).."개. \x04일일 제한"..FirstReward3[4][5].."회",
			FirstReward4[1][4].."49강 \x04: \x17크레딧 "..Convert_Number(FirstReward4[1][2]).."억, \x02무색 조각 "..Convert_Number(FirstReward4[1][3]).."개. \x04주간 제한"..FirstReward4[1][5].."회\x07 (매주 목요일 초기화)",
			FirstReward4[2][4].."50강 \x04: \x17크레딧 "..Convert_Number(FirstReward4[2][2]).."억, \x02무색 조각 "..Convert_Number(FirstReward4[2][3]).."개. \x04주간 제한"..FirstReward4[2][5].."회\x07 (매주 목요일 초기화)",
			--"\x04X단계 \x04: ",
			--"\x045단계 보스는 처치후 \x081시간의 인게임 쿨타임\x04이 존재합니다."
		},
		{
			"\x13\x04\x1B- 부록. \x17크레딧 \x1F광산 \x1B-",
			"\x13\x04맵상의 모든 보스 몬스터의 공략이 완료된 이후 \x17크레딧 \x1F광산\x04이 개인 보스존에 생성됩니다",
			"\x13\x04이 광산에 1회 공격을 할 때마다 \x17채광력 \x04만큼의 크레딧이 주어집니다. (\x17채광력\x04은 P키로 확인 가능)",
			"\x13\x04채광력 : 채광의 보석, 각성 횟수에 따라 1.1배씩 곱연산으로 증가",
			"\x13\x041회 최대 채광 가능 크레딧 : 기본 1억 + 15만레벨 이후 1레벨당 20만씩 증가",
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
				DisplayPrint(i,{"\x13\x07『 \x02무색 조각\x04을 \x07",TempFV," 개 \x04 획득하였습니다. 현재 총 획득량 : \x07",iv.FfragItem[i+1]," 개 \x07』"})
			CIfEnd()
			TriggerX(FP, {CD(FVT,0)}, {SetV(TempFV,0)},{preserved})
		for p = 1,7 do
			local NextT = ""
			local NextT2 = ""
			if p ~= 7 then
				NextT = "다음 \x08배수\x04 증가 \x1BDPS\x1F(미네랄) : \x08"..OreDPS[p+1]
				NextT2 = "다음 \x08배수\x04 증가 \x1BDPS\x07(가스) : \x08"..GasDPS[p+1]
			end
		TriggerX(FP,{CV(iv.TempO[i+1], OreDPS[p],AtLeast)},{
			SetV(iv.BuildMul1[i+1],OreDPSM[p]),
			SetV(iv.NextOre[i+1],OreDPS[p+1]),
			SetV(iv.NextOreMul[i+1],OreDPSM[p+1]),SetCp(i),
			DisplayExtText(StrDesignX("\x1BDPS\x1F(미네랄) \x08"..OreDPS[p].." \x04돌파. 현재 돈 배수 : \x08"..OreDPSM[p].."배. "..NextT)),SetCp(FP)})--1번건물
		TriggerX(FP,{CV(iv.TempG[i+1], GasDPS[p],AtLeast)},{
			SetV(iv.BuildMul2[i+1],GasDPSM[p]),
			SetV(iv.NextGas[i+1],GasDPS[p+1]),
			SetV(iv.NextGasMul[i+1],GasDPSM[p+1]),SetCp(i),
			DisplayExtText(StrDesignX("\x1BDPS\x07(가스) \x08"..GasDPS[p].." \x04돌파. 현재 돈 배수 : \x08"..GasDPSM[p].."배. "..NextT2)),SetCp(FP)})--2번건물
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