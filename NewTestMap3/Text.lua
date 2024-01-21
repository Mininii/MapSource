function Text()

	--TBL
	
	SelEPD,SelPer,SelUID,SelMaxHP,SelPl,SelI,CurEPD = CreateVars(7,FP)
	SelEXP = CreateWar(FP)
	BossFlag = CreateCcode()
	BossFlag2 = CreateCcode()
	SellTicketFlag = CreateCcode()
	XEperFlag = CreateCcode()
	PUnitFlag = CreateCcode()
	TotalEPerLoc1 = CreateVar(FP)
	TotalEPerLoc2 = CreateVar(FP)
	TotalEPerLoc3 = CreateVar(FP)
	TotalEPerLoc4 = CreateVar(FP)
	CostLoc = CreateVar(FP)
	CostLocVA =CreateVArr(4,FP)
	
	
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1)}) -- 클릭유닛인식(로컬)
	CMov(FP,SelPl,0)
	f_Read(FP,0x6284B8,nil,SelEPD)
	f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
	CMov(FP,SelUID,_ReadF(_Add(SelEPD,25)),nil,0xFF,1)
	
	CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{SetCD(PUnitFlag,0),SetCD(XEperFlag,0),SetCD(BossFlag,0),SetCD(BossFlag2,0)}) -- 유닛선택시 1회만 실행

	
	CMov(FP,CurEPD,SelEPD)
	CMov(FP,0x6509B0,LCP)

	
	for i = 1, 10 do
		CIf(FP,{CV(SelUID,LevelUnitArr[i][2])})
		CMov(FP,TotalEPerLoc1,LevelUnitArr[i][3][1])
		CMov(FP,TotalEPerLoc2,LevelUnitArr[i][3][2])
		CMov(FP,TotalEPerLoc3,LevelUnitArr[i][3][3])
		CMov(FP,TotalEPerLoc4,LevelUnitArr[i][3][4])
		CMov(FP,CostLoc,LevelUnitArr[i][5])
		CIfEnd()
	end
	ItoDec(FP,CostLoc,VArr(CostLocVA,0),2,nil,0)
	f_Movcpy(FP, _Add(Etbl,25), VArr(CostLocVA,0), 4*4)

	CMov(FP,GEVar,TotalEPerLoc1)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,26+28+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,26+28+4+i),SetTo,EVarArr1[i+4])})
	end
	CMov(FP,GEVar,TotalEPerLoc2)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,45+28+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,45+28+4+i),SetTo,EVarArr1[i+4])})
	end
	CMov(FP,GEVar,TotalEPerLoc3)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,64+28+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,64+28+4+i),SetTo,EVarArr1[i+4])})
	end
	CMov(FP,GEVar,TotalEPerLoc4)
	CallTrigger(FP, Call_SetEPerStr)
	for i = 0, 2 do
		CDoActions(FP,{TBwrite(_Add(Etbl,85+28+i),SetTo,EVarArr1[i+1])})
		CDoActions(FP,{TBwrite(_Add(Etbl,85+28+4+i),SetTo,EVarArr1[i+4])})
	end


	CIfEnd()






	CIfEnd()

	iStrSector = def_sIndex()
	CJump(FP, iStrSector)
	
	iStr1 = GetiStrId(FP,MakeiStrWord(MakeiStrVoid(54).."\r\n",3)) 

	Str1, Str1a, Str1s = SaveiStrArrX(FP,MakeiStrVoid(54))
	Str2, Str2a, Str2s = SaveiStrArrX(FP,MakeiStrVoid(54))

	iStrL = GetiStrId(FP,MakeiStrVoid(54)) 
	StrL, StrLa, StrLs = SaveiStrArrX(FP,MakeiStrVoid(54))
	local MoneyLoc = iv.MoneyLoc
	LevelLoc = iv.LevelLoc
	TotalExpLoc = iv.TotalExpLoc
	ExpLoc = iv.ExpLoc


	local TempFf = CreateWar(FP)
	local TempFf2 = CreateVar(FP)
	local StatEffLoc = iv.StatEffLoc--CreateCcode()
	local StatPLoc = iv.StatPLoc
	local CredLoc = iv.CredLoc
	CJumpEnd(FP, iStrSector)

	FixText(FP, 1)
	
	function TEST() 
		local PlayerID = CAPrintPlayerID 
		local LVData = {{{0,9},{"０",{0x1000000}}}} 
		local StatEffT = CreateCcode()
		local InterfaceNumLoc2 = CreateCcode()
		DoActionsX(FP,AddCD(StatEffT,1))
		CA__SetValue(Str1,"\x07보유금액 \x04:  0000\x04경0000\x04조0000\x04억0000\x04만0000\x0D\x04원\x12\x07사냥터\x04 \x0D\x0D\x0D / \x0D\x0D\x0D\x0D\x0D",nil,1)
		CA__SetValue(Str2,"\x07보유금액 \x04: \x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D \x04원",nil,1)
		--43
		--49
		--CS__ItoCustom(FP,SVA1(Str2,23),MoneyLoc2,nil,nil,{10,8},1,nil,"\x170",0x17)
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
		
		--CIf(FP,{CV(MoneyLoc2,0)})
		--	CA__SetValue(Str2, "\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x0D\x12", nil, 20)
		--CIfEnd()
	
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


		--f_LSub(FP,TempFf,iv.FfragItemLoc,iv.FfragItemUsedLoc)
		--f_Cast(FP, {TempFf2,0}, TempFf,nil,nil,1)
		TempCrStLoc = CreateWar(FP)

		
		CA__SetValue(Str1,"\x12포인트 \x04:  000,000,000 \x04| \x17크레딧 \x04:  123\x04,123\x04,123\x04,123\x04,123",nil,1)
		TriggerX(FP,CV(StatPLoc,999999999,AtLeast),{SetV(StatPLoc,999999999)},{preserved})
        CS__ItoCustom(FP,SVA1(Str1,8),StatPLoc,nil,nil,{10,9},1,nil,"\x1C0",0x1C,{0,1,2,4,5,6,8,9,10}, nil,{0,0,{0},0,0,{0},0,0,{0}})
		f_LMov(FP, TempCrStLoc, CredLoc)
		CIfX(FP,{TTNWar(TempCrStLoc, AtLeast, "999999999999999"),TTNWar(TempCrStLoc, AtMost, "0x7FFFFFFFFFFFFFFF")})
		f_LMov(FP,TempCrStLoc,"999999999999999")
		CElseIfX({TTNWar(TempCrStLoc, AtLeast, "0x8000000000000000"),TTNWar(TempCrStLoc, AtMost, "0xFFFC72815B398000")})
		f_LMov(FP,TempCrStLoc,"0xFFFC72815B398001")
		CIfXEnd()
        CA__lItoCustom(SVA1(Str1,29),TempCrStLoc,nil,nil,{10,15},1,nil,{"\x07\x0D","\x08-", "\x1B0"},{0x19,0x19,0x19,0x1D,0x1D,0x1D,0x02,0x02,0x02,0x1E,0x1E,0x1E,0x05,0x05,0x05}
        ,{0,1,2,4,5,6,8,9,10,12,13,14,16,17,18},nil,{0,0,{0},0,0,{0},0,0,{0},0,0,{0}})

		

		--CIfX(FP,CD(Tabkey,0))
		--CElseX()
		--CA__SetValue(Str1,"\x12\x02조각\x0D \x04:  000,000,000 \x04| \x19판매권 \x04:  123\x04,123\x04,123\x04,123\x04,123",nil,1)
		--f_LMov(FP, TempCrStLoc, SellTicketLoc)
		--CTrigger(FP,{TTNWar(TempFf, AtLeast, "999999999"),TTNWar(TempFf, AtMost, "0x7FFFFFFFFFFFFFFF")},{SetV(TempFf2,999999999)},{preserved})

		--CIfX(FP,{TTNWar(TempFf, AtLeast, "999999999"),TTNWar(TempFf, AtMost, "0x7FFFFFFFFFFFFFFF")})
		--CMov(FP,TempFf2,999999999)
		--CElseIfX({TTNWar(TempFf, AtLeast, "0x8000000000000000"),TTNWar(TempFf, AtMost, "0xFFFFFFFFC46535FF")})
		--CMov(FP,TempFf2,-999999999)
		--CIfXEnd()

        --CS__ItoCustom(FP,SVA1(Str1,8),TempFf2,nil,nil,{10,9},1,nil,{"\x07\x0D","\x08-", "\x1B0"},0x1C,{0,1,2,4,5,6,8,9,10}, nil,{0,0,{0},0,0,{0},0,0,{0}})
		--CIfXEnd()


	
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

	FixText(FP, 2)

	CMov(FP,0x6509B0,FP)



end