function Install_CallTriggers()
	
	Call_Print13 = {}
	for i = 0, 6 do
	Call_Print13[i+1] = SetCallForward()
	SetCall(FP)
		Print_13_2(FP,{i},nil)
	SetCallEnd()
	end

	Call_ConvertTime = SetCallForward()
	SetCall(FP)
	CTimeV = CreateVar(FP)
	CTimeSS = CreateVar(FP)
	CTimeMM = CreateVar(FP)
	CTimeHH = CreateVar(FP)
	CTimeDD = CreateVar(FP)
	Byte_NumSet(CTimeV,CTimeDD,86400,1,nil,15)
	Byte_NumSet(CTimeV,CTimeHH,3600,1,nil,6)
	Byte_NumSet(CTimeV,CTimeMM,60,1,nil,6)
	Byte_NumSet(CTimeV,CTimeSS,1,1,nil,6)

	SetCallEnd()


	CreateStackedUnit = SetCallForward()
	SUnitID = CreateVar(FP)
	SLocation = CreateVar(FP)
	DLocation = CreateVar(FP)
	SPlayer = CreateVar(FP)
	SAmount = CreateVar(FP)
	SetCall(FP)
	CWhile(FP,{CV(SAmount,1,AtLeast)},{SubV(SAmount,1)})
	TriggerX(FP, {CV(SUnitID,16)}, {SetMemoryB(0x669E28+237, SetTo, 0)}, {preserved})
	TriggerX(FP, {CV(SUnitID,78)}, {SetMemoryB(0x669E28+237, SetTo, 16)}, {preserved})
	CIf(FP,{Memory(0x628438, AtLeast, 1)},{SetCD(TBLFlag,1)})
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {TCreateUnit(1,SUnitID,SLocation,SPlayer),
		TSetDeaths(_Add(Nextptrs,13),SetTo,2000,0),
		TSetDeathsX(_Add(Nextptrs,18),SetTo,2000,0,0xFFFF),
		TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
		
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
	})
	CIf(FP,{TTOR({CV(SUnitID,88),CV(SUnitID,79),CV(SUnitID,99),CV(SUnitID,100)})})
	local NBTemp = CreateVar(FP)
	NBagLoop(FP,NBagArr,{NBTemp})

	CMov(FP,0x6509B0,NBTemp,19)
	NIf(FP,{DeathsX(CurrentPlayer, Exactly, 0, 0, 0xFF00)})
	NRemove(FP,NBagArr)
	NIfEnd()

	NBagLoopEnd()
	CMov(FP,0x6509B0,FP)
	
	NAppend(FP, NBagArr, Nextptrs)
	CIfEnd()
	--CTrigger(FP,{},{TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),},1)
	CSub(FP,CurCunitI,Nextptrs,19025)
	CDiv(FP,CurCunitI,84)
	local TempV = CreateVar(FP)
	CMov(FP,TempV,_Add(_Mul(CurCunitI,0x970/4),_Add(CT_Cunit[3],((0x20*0)/4))))
	CDoActions(FP, {
		TSetMemory(TempV,SetTo,_Add(CT_GNextRandV,SUnitID)),
		TSetMemory(_Add(TempV,0x20/4),SetTo,CT_GNextRandV),
		TSetMemory(_Add(TempV,0x40/4),SetTo,_Add(CT_GNextRandV,SPlayer)),
	})
	CTSUPtr = CreateVar(FP)
	CTSUID = CreateVar(FP)
		--DisplayPrint(Force1, {"\x13\x04CTSUPtr : ",SUnitID})--
	CIf(FP,{TTOR({
		CV(SUnitID,5),
		CV(SUnitID,23),
		CV(SUnitID,30),
		CV(SUnitID,3),
		CV(SUnitID,17),
	})})
	f_Read(FP, _Add(Nextptrs, 28), nil, CTSUPtr)
			--DisplayPrint(Force1, {"\x13\x04CTSUPtr : ",CTSUPtr})--
	CIf(FP,{CV(CTSUPtr,19025,AtLeast),CV(CTSUPtr,19025+(84*1699),AtMost)})
	f_Read(FP, _Add(CTSUPtr, 25), CTSUID, nil, 0xFF, 1)
		--DisplayPrint(Force1, {"\x13\x04CTSUID : ",CTSUID})--
	CSub(FP,CurCunitI,CTSUPtr,19025)
	CDiv(FP,CurCunitI,84)
	CMov(FP,TempV,_Add(_Mul(CurCunitI,0x970/4),_Add(CT_Cunit[3],((0x20*0)/4))))
	CDoActions(FP, {
		TSetMemory(TempV,SetTo,_Add(CT_GNextRandV,CTSUID)),
		TSetMemory(_Add(TempV,0x20/4),SetTo,CT_GNextRandV),
		TSetMemory(_Add(TempV,0x40/4),SetTo,_Add(CT_GNextRandV,SPlayer)),
	})
	CIfEnd()

	CIfEnd()


	--CallTrigger(FP, Call_CTInputUID)
	CTrigger(FP, {CV(DLocation,1,AtLeast)}, {TOrder(SUnitID, SPlayer, SLocation, Move, DLocation)},1)
	CIfEnd()
	CWhileEnd()

	SetCallEnd()
	function CreateUnitStacked(Condition,Amount,UnitID,Location,DestLocation,Player,AddTrig,Preserved)
		if DestLocation == nil then DestLocation = 0 end
		CallTriggerX(FP, CreateStackedUnit, Condition, {
			SetNVar(SAmount,SetTo,Amount),
			SetNVar(SUnitID,SetTo,UnitID),
			SetNVar(SLocation,SetTo,Location),
			SetNVar(DLocation,SetTo,DestLocation),
			SetNVar(SPlayer,SetTo,Player),AddTrig
		}, Preserved)
		
	end

	

	Call_Enchant = SetCallForward()
	--100000 = 100%
	SetCall(FP)
	
	

	
	local TotalEper = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	local TotalEper2 = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	local TotalEper3 = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	ECW = CreateVar(FP)
	ELevelB = CreateVar(FP)
	UEper2 = CreateVar(FP)
	UEper3 = CreateVar(FP)
	--ELevel = 현재 강화중인 레벨
	CAdd(FP,TotalEper,UEper,GEper) -- +1강 확률
	CAdd(FP,TotalEper2,UEper2,GEper2)
	CAdd(FP,TotalEper3,UEper3,GEper3)

	E3Range = CreateVarArr(2, FP)
	E2Range = CreateVarArr(2, FP)
	E1Range = CreateVarArr(2, FP)
	CMov(FP,E3Range[1],1)
	CMov(FP,E3Range[2],TotalEper3)
	CMov(FP,E2Range[1],E3Range[2],1)
	CMov(FP,E2Range[2],_Add(E3Range[2],TotalEper2))
	CMov(FP,E1Range[1],E2Range[2],1)
	CMov(FP,E1Range[2],_Add(E2Range[2],TotalEper))

	CWhile(FP, {CV(ECW,1,AtLeast)},{SubV(ECW,1)})
	CMov(FP,ELevel,ELevelB)


	
	if TestStart == 1 then
		GetEPer = CreateVar(FP)
		CIfX(FP,{KeyPress("F11", "Down")})
		CMov(FP,GetEPer,1)
		CElseX()
		GetEPer2 = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
		CMov(FP,GetEPer,GetEPer2)
		CIfXEnd()
	else
		GetEPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
	end


	if Limit == 1 then -- 테스트용 결과 출력
		CIf(FP,{KeyPress("F12", "Down")})
			CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText(string.rep("\n", 10), 4)})
			for i = 1, 39 do
				TriggerX(FP, CV(ELevel,i-1), {DisplayExtText("\x08"..i.."강 유닛 강화 시도", 4)},{preserved})
			end
			ColorCodeV = CreateVar2(FP,nil,nil,0x0E)
			ColorCodeV2 = CreateVar2(FP,nil,nil,0x0F)
			ColorCodeV3 = CreateVar2(FP,nil,nil,0x10)
			ColorCodeV4 = CreateVar2(FP,nil,nil,0x1B)

			DisplayPrint(ECP,{"\x04출력된 난수 : ",ColorCodeV[2],GetEPer})
			DisplayPrint(ECP,{"\x1F계산된 +3 확률 : ",ColorCodeV2[2],E3Range[1]," \x04~ ",E3Range[2]})
			DisplayPrint(ECP,{"\x1F계산된 +2 확률 : ",ColorCodeV3[2],E2Range[1]," \x04~ ",E2Range[2]})
			DisplayPrint(ECP,{"\x1F계산된 +1 확률 : ",ColorCodeV4[2],E1Range[1]," \x04~ ",E1Range[2]})
			
		CIfEnd()
	end

	
	
	--강화 성공 또는 실패 결정. TotalEper가 랜덤난수보다 더 클경우 성공
	CIfX(FP,{TNVar(GetEPer, AtLeast, E3Range[1]),TNVar(GetEPer, AtMost, E3Range[2])})--+3강 성공시
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x1F결과 : +3 성공", 4)})
			CIfEnd()
		end
		CIfX(FP, {CV(ELevel,33,AtMost)}) -- 35강부터 +2 적용안됨, 36강부터 +2 적용안됨
		CAdd(FP,ELevel,3)
		CElseIfX({CV(ELevel,34,AtLeast),CV(ELevel,35,AtMost)})
		CMov(FP,ELevel,36)
		CElseX()
		CAdd(FP,ELevel,1)
		CIfXEnd()
	CElseIfX({TNVar(GetEPer, AtLeast, E2Range[1]),TNVar(GetEPer, AtMost, E2Range[2])})--+2강 성공시
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x1C결과 : +2 성공", 4)})
			CIfEnd()
		end
		CIfX(FP, {CV(ELevel,34,AtMost)}) -- 36강부터 +2 +3 적용안됨
		CAdd(FP,ELevel,2)
		CElseIfX({CV(ELevel,35)})
		CMov(FP,ELevel,36)
		CElseX()
		CAdd(FP,ELevel,1)
		CIfXEnd()
	CElseIfX({TNVar(GetEPer, AtLeast, E1Range[1]),TNVar(GetEPer, AtMost, E1Range[2])})--+1강 성공시
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x0F결과 : +1 성공", 4)})
			CIfEnd()
		end
		CAdd(FP,ELevel,1)
	CElseX()--실패시 Never(경험치 지급)
		local TempEXP = CreateVar(FP)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x08결과 : 실패", 4)})
			CIfEnd()
		end
		for i = 0, 6 do
			
			--CIf(FP,{CV(ECP,i)})
			--	CIf(FP,{TTNWar(iv.TempEXPW2,AtLeast,"1")})
			--	f_LAdd(FP, PEXP[i+1], PEXP[i+1], {EExp,0})
			--	f_LAdd(FP, GetCreditData, GetCreditData, {EExp,0})
			--	CIfEnd()
			--CIfEnd()
		end

		--if TestStart == 1 then
		--	CIf(FP,{KeyPress("F12", "Down")})
		--		ItoDec(FP,_Add(EExp,TempEXP),VArr(TestVA2,0),2,0x1F,0)
		--		f_Movcpy(FP,_Add(ETestStrPtr3,ETestTxt3[2]),VArr(TestVA2,0),4*4)
		--		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x0D\x0D\x0DET3".._0D, 4)})
		--	CIfEnd()
		--end
	CMov(FP,ELevel,0)
	CIfXEnd()
	CIf(FP,{CV(ELevel,1,AtLeast)})
	TriggerX(FP,{CV(ELevel,#LevelUnitArr-1,AtLeast)},{SetV(ELevel,#LevelUnitArr-1)},{preserved})--오버플로우 방지

		for i = 0, 6 do
			CIf(FP,{CV(ECP,i)})
				CMovX(FP,VArr(GetUnitVArr[i+1], ELevel),1,Add)
			CIfEnd()
		end
	CIfEnd()

	CWhileEnd()
	SetCallEnd()

	Call_Enchant2 = SetCallForward()
	SetCall(FP)
	--ELevel = 현재 강화중인 레벨
	
	CWhile(FP, {CV(ECW,1,AtLeast)},{SubV(ECW,1)})
	CMov(FP,ELevel,ELevelB)
	CMov(FP,E1Range[1],1)
	CMov(FP,E1Range[2],XEper)


	if TestStart == 1 then
		GetEPer = CreateVar(FP)
		CIfX(FP,{KeyPress("F11", "Down")})
		CMov(FP,GetEPer,1)
		CElseX()
		GetEPer2 = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
		CMov(FP,GetEPer,GetEPer2)
		CIfXEnd()
		
		--GetEPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
	else
		GetEPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
	end

	if Limit == 1 then -- 테스트용 결과 출력
		CIf(FP,{KeyPress("F12", "Down")})
			CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText(string.rep("\n", 10), 4)})
			for i = 40, 49 do
				TriggerX(FP, CV(ELevel,i-1), {DisplayExtText("\x08"..i.."강 유닛 강화 시도", 4)},{preserved})
			end
			ColorCodeV = CreateVar2(FP,nil,nil,0x0E)
			ColorCodeV2 = CreateVar2(FP,nil,nil,0x0F)
			ColorCodeV3 = CreateVar2(FP,nil,nil,0x10)
			ColorCodeV4 = CreateVar2(FP,nil,nil,0x1B)

			DisplayPrint(ECP,{"\x04출력된 난수 : ",ColorCodeV[2],GetEPer})
			DisplayPrint(ECP,{"\x1F계산된 +1 확률 : ",ColorCodeV4[2],E1Range[1]," \x04~ ",E1Range[2]})
			
		CIfEnd()
	end
	CIfX(FP,{TNVar(GetEPer, AtLeast, 1),TNVar(GetEPer, AtMost, XEper)})--성공시
		CAdd(FP,ELevel,1)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x0F결과 : +1 성공", 4)})
			CIfEnd()
		end
	CElseX()
		CIfX(FP,CV(BreakShield,1,AtLeast))
		GetEPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
		CMov(FP,E1Range[1],1)
		CMov(FP,E1Range[2],BreakShield)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
			DisplayPrint(ECP,{"\x04출력된 파괴방지 난수 : ",ColorCodeV[2],GetEPer})
			DisplayPrint(ECP,{"\x1F계산된 파괴방지 확률 : ",ColorCodeV4[2],E1Range[1]," \x04~ ",E1Range[2]})
			CIfEnd()
		end
		
		CIfX(FP,{TNVar(GetEPer, AtLeast, 1),TNVar(GetEPer, AtMost, BreakShield)})--성공시
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x08결과 : 파괴방지 성공", 4)})
			CIfEnd()
		end
		CElseX()
		CMov(FP,ELevel,0)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText("\x08결과 : 실패", 4)})
			CIfEnd()
		end
		CIfXEnd()
		CElseX()
		CMov(FP,ELevel,0)
		CIfXEnd()
	CIfXEnd()
	CIf(FP,{CV(ELevel,1,AtLeast)})
	TriggerX(FP,{CV(ELevel,#LevelUnitArr-1,AtLeast)},{SetV(ELevel,#LevelUnitArr-1)},{preserved})--오버플로우 방지
		for i = 0, 6 do
			CIf(FP,{CV(ECP,i)})
				CMovX(FP,VArr(GetUnitVArr[i+1], ELevel),1,Add)
			CIfEnd()
		end
	CIfEnd()

	CWhileEnd()

	
	SetCallEnd()

	
	Call_SetEPerStr = SetCallForward()
	SetCall(FP)
	EVarArr1 = CreateVarArr(6, FP)
	GEVar = CreateVar(FP)
	EVarArr2 = {EVarArr1[1],EVarArr1[2],EVarArr1[3]}
	EVarArr3 = {EVarArr1[4],EVarArr1[5],EVarArr1[6]}

	for i = 1, 6 do
		Byte_NumSet(GEVar,EVarArr1[i],10^(6-i),1,0x30)
	end
	SetEPerStr(EVarArr1)

	SetCallEnd()
	
	Call_SetEPerStr2 = SetCallForward()
	SetCall(FP)
	EVarArr1_2 = CreateVarArr(6, FP)
	GEVar_2 = CreateVar(FP)
	EVarArr2_2 = {EVarArr1_2[1],EVarArr1_2[2],EVarArr1_2[3]}
	EVarArr3_2 = {EVarArr1_2[4],EVarArr1_2[5],EVarArr1_2[6]}

	for i = 1, 6 do
		Byte_NumSet(GEVar_2,EVarArr1_2[i],10^(6-i),1,0x30)
	end
	SetEPerStr(EVarArr1_2)

	SetCallEnd()

	
	EVarArr1_2 = CreateVarArr(6, FP)

	

	GCP = CreateVar(FP)
	Call_Print13CP = SetCallForward()
	SetCall(FP)
	
	for i = 0, 6 do
		CIf(FP,{CV(GCP,i)})
		Print_13_2(FP,{i},nil)
		CIfEnd()
	end
	SetCallEnd()
	
	Call_CT = SetCallForward()
	SetCall(FP)
	
	CTPEXP = CreateWar(FP)
	CTPLevel = CreateVar(FP)
	CTStatP = CreateVar(FP)
	CTCurEXP = CreateWar(FP)
	CTTotalExp = CreateWar(FP)
	CTLIndex = CreateVar(FP)
	CT_PrevLMulW = CreateWar(FP)
	CT_NextLMulW = CreateWar(FP)
	CTMaxExp = CreateWar(FP)
	

	ConvertLArr(FP, CTLIndex, _Add(CTPLevel, 150), 8)--151 포커스
	f_LRead(FP, LArrX({EXPArr_dp},CTLIndex), CTCurEXP, nil, 1)
	ConvertLArr(FP, CTLIndex, _Add(CTPLevel, 151), 8)--151 포커스
	f_LRead(FP, LArrX({EXPArr_dp},CTLIndex), CTTotalExp, nil, 1)
	f_LRead(FP, LArrX({EXPArr_dp},151+LevelLimit), CTMaxExp, nil, 1)
	DoActionsX(FP,{SetCDX(iv.StatTest,16,16)})
	CTrigger(FP,{TTNWar(CTPEXP, AtLeast, CTCurEXP),TTNWar(CTPEXP, AtMost, CTTotalExp)},{SetCDX(iv.StatTest,0,16)},1)
	CTrigger(FP,{TTNWar(CTPEXP, AtLeast, CTMaxExp)},{SetCDX(iv.StatTest,32,32)},1)
	if Limit == 1 then
	--	DisplayPrint(iv.LCP, {"\x13\x04CTPEXP : ",CTPEXP,"   CTCurEXP : ",CTCurEXP,"   CTTotalExp : ",CTTotalExp})
	end
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPerEx[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPerEx)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPerEx2[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPerEx2)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPerEx3[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPerEx3)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer2[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer2)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer3[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer3)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer4[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer4)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_TotalEPer4X[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_TotalEPer4X)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_BreakShield[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_BreakShield)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_BreakShield2[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_BreakShield2)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer44[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer44)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer45[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer45)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer46[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer46)))
	CAdd(FP,iv.CTStatP2,_Mul(_Div(VArrX(GetVArray(iv.Stat_XEPer47[1], 7), VArrI, VArrI4),_Mov(100)),_Mov(Cost_Stat_XEPer47)))
	CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_BossSTic[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_BossSTic)))
	CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_LV3Incm[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_LV3Incm)))
	CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_Upgrade[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_Upgrade)))
	CAdd(FP,iv.CTStatP2,_Mul(VArrX(GetVArray(iv.Stat_BossLVUP[1], 7), VArrI, VArrI4),_Mov(Cost_Stat_BossLVUP)))


	SetCallEnd()

	MCP = CreateVar(FP)
	Call_SetScrMouse = SetCallForward()
	SetCall(FP)
	mouseX = dwread_epd(0x6CDDC4)
	mouseY = dwread_epd(0x6CDDC8)
	screenGridX = dwread_epd(0x62848C)
	screenGridY = dwread_epd(0x6284A8)
	Simple_SetLocX(FP,117, 256*16, 256*16,256*16, 256*16) --중앙 (맵사이즈*16, 맵사이즈*16)
	CDoActions(FP,{TSetMemory(0x6509B0, SetTo, MCP),CenterView(118)})
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
	CDoActions(FP,{TSetMemory(0x6509B0, SetTo, MCP),CenterView(118)})
	Simple_SetLocX(FP,117, 256*16, 256*16,256*16, 256*16) --중앙 (맵사이즈*16, 맵사이즈*16)
	CMov(FP,screenX,_iSub(_Add(mouseX,320),screenSizeX))

	screenX2 = CreateVar(FP)
	CiSub(FP,screenX2,screenX,screenSizeX)

	SetCallEnd()
	G_Btnptr = CreateVar(FP)
	G_BtnFnm = CreateVar(FP)
	G_PushBtnm = CreateVar(FP)
	Call_BtnFnc = SetCallForward()
	local GetPUnitLevel = CreateVar(FP)
	local GetPUnitCool = CreateVar(FP)
	SetCall(FP)
	PUnitCurLevel = CreateVarArr2(7,0xFFFFFFFF,FP)
	CIf(FP,{CVar(FP,G_Btnptr[2],AtLeast,19025),CVar(FP,G_Btnptr[2],AtMost,19025+(1699*84))})
		CIf(FP,CV(G_BtnFnm,7)) -- 고유유닛 CUnit 제어부
		CMovX(FP,GetPUnitCool,VArrX(GetVArray(iv.CurPUnitCool[1], 7),VArrI,VArrI4))
		CMov(FP,0x6509B0,G_Btnptr,21)
		DoActions(FP,{
			SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF),
			SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00)})

		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,103*256,0,0xFF00)})
		CDoActions(FP, {
			TSetDeathsX(CurrentPlayer,SetTo,GetPUnitCool,0,0xFF00),
		})
		CIfEnd()
		CMov(FP,0x6509B0,FP)
		--iv.PUnitLevel
		

		CIfEnd()
		CIf(FP,{TMemory(_Add(G_Btnptr,0x98/4),AtMost,0 + 227*65536)}) -- 버튼 눌럿을경우
		
			CMovX(FP,VArrX(GetVArray(DPErT[1], 7),VArrI,VArrI4),24*10)
			--Print_13X(FP,GCP)

			f_Read(FP,_Add(G_Btnptr,0x98/4),G_PushBtnm)
			CrShift(FP,G_PushBtnm,16)

			CIfX(FP,{Never()})
			CElseIfX({TTOR({CV(G_BtnFnm,1),CV(G_BtnFnm,8)})})--자동구매
				local AutoBuyVArr = GetVArray(iv.AutoBuyCode[1], 7)
				local AutoBuyVArr2 = GetVArray(iv.AutoBuyCode2[1], 7)
				local GetNum = CreateVar(FP)
				local GetABData = CreateVar(FP)
				local PBJump = def_sIndex()
				local PBJump2 = def_sIndex()
				local PBJump3 = def_sIndex()
				local PBJump4 = def_sIndex()


				NJump(FP, PBJump, CV(G_PushBtnm,24))
				NJump(FP, PBJump4, CV(G_PushBtnm,25))
				CMov(FP, GetNum,_SHRead(Arr(BuyDataArr,G_PushBtnm)))
				CIfX(FP,{CV(G_BtnFnm,8)})
				CMovX(FP,GetABData,VArrX(AutoBuyVArr2,VArrI,VArrI4))
				CElseX()
				CMovX(FP,GetABData,VArrX(AutoBuyVArr,VArrI,VArrI4))
				CIfXEnd()



				CIfX(FP,{TNVar(GetNum, Exactly, GetABData)})
				local CLocL = CreateVar(FP)
				local CLocR = CreateVar(FP)

					CIfX(FP,{CV(G_BtnFnm,8)})
					f_Read(FP,FArr(PLocPos,GCP),CPosX,nil,nil,1)
					CMov(FP,CLocL,CPosX,32+64)
					CMov(FP,CLocR,CPosX,32+64+64)
					Simple_SetLocX(FP, 86, CLocL, 32, CLocR, 96)
					CDoActions(FP, {RemoveUnitAt(All, "Any unit", 87, FP)})
					DisplayPrintEr(GCP, {"\x07『 \x06",GetNum,"강 \x04유닛 \x19추가 \x1B자동구입 \x08OFF \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr2,VArrI,VArrI4),0)
					CElseX()
					
					f_Read(FP,FArr(PLocPos,GCP),CPosX,nil,nil,1)
					CMov(FP,CLocL,CPosX,32)
					CMov(FP,CLocR,CPosX,32+64)
					Simple_SetLocX(FP, 86, CLocL, 32, CLocR, 96)
					CDoActions(FP, {RemoveUnitAt(All, "Any unit", 87, FP)})
					DisplayPrintEr(GCP, {"\x07『 \x06",GetNum,"강 \x04유닛 \x1B자동구입 \x08OFF \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),0)
					CIfXEnd()

				CElseX()

					CIfX(FP,{CV(G_BtnFnm,8)})
					f_Read(FP,FArr(PLocPos,GCP),CPosX,nil,nil,1)
					CMov(FP,CLocL,CPosX,32+64)
					CMov(FP,CLocR,CPosX,32+64+64)
					Simple_SetLocX(FP, 86, CLocL, 32, CLocR, 96)
					local CUID = CreateVar(FP)
					CMovX(FP,CUID,VArr(LevelDataArr,_Sub(GetNum,1)),nil,nil,nil,1)
					CDoActions(FP, {
						RemoveUnitAt(All, "Any unit", 87, FP),
						TSetNVar(SAmount,SetTo,1),
						TSetNVar(SUnitID,SetTo,CUID),
						TSetNVar(SLocation,SetTo,87),
						TSetNVar(DLocation,SetTo,0),
						TSetNVar(SPlayer,SetTo,FP),
					})
					CallTrigger(FP, CreateStackedUnit)
					DisplayPrintEr(GCP, {"\x07『 \x06",GetNum,"강 \x04유닛 \x19추가 \x1B자동구입 \x07ON \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr2,VArrI,VArrI4),GetNum)
					CElseX()
					f_Read(FP,FArr(PLocPos,GCP),CPosX,nil,nil,1)
					CMov(FP,CLocL,CPosX,32)
					CMov(FP,CLocR,CPosX,32+64)
					Simple_SetLocX(FP, 86, CLocL, 32, CLocR, 96)
					
					CMovX(FP,CUID,VArr(LevelDataArr,_Sub(GetNum,1)),nil,nil,nil,1)
					CDoActions(FP, {
						RemoveUnitAt(All, "Any unit", 87, FP),
						TSetNVar(SAmount,SetTo,1),
						TSetNVar(SUnitID,SetTo,CUID),
						TSetNVar(SLocation,SetTo,87),
						TSetNVar(DLocation,SetTo,0),
						TSetNVar(SPlayer,SetTo,FP),
					})
					CallTrigger(FP, CreateStackedUnit)
					DisplayPrintEr(GCP, {"\x07『 \x06",GetNum,"강 \x04유닛 \x1B자동구입 \x07ON \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),GetNum)
					CIfXEnd()

				CIfXEnd()

				CJump(FP, PBJump2)
				NJumpEnd(FP, PBJump)
				
				CIfX(FP,{CV(G_BtnFnm,8)})
					f_Read(FP,FArr(PLocPos,GCP),CPosX,nil,nil,1)
					CMov(FP,CLocL,CPosX,32+64)
					CMov(FP,CLocR,CPosX,32+64+64)
					Simple_SetLocX(FP, 86, CLocL, 32, CLocR, 96)
					CDoActions(FP, {RemoveUnitAt(All, "Any unit", 87, FP)})
					DisplayPrintEr(GCP, {"\x07『 \x04유닛 \x19추가 \x1B자동구입 \x08OFF \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr2,VArrI,VArrI4),0)
				CElseX()
					f_Read(FP,FArr(PLocPos,GCP),CPosX,nil,nil,1)
					CMov(FP,CLocL,CPosX,32)
					CMov(FP,CLocR,CPosX,32+64)
					Simple_SetLocX(FP, 86, CLocL, 32, CLocR, 96)
					CDoActions(FP, {RemoveUnitAt(All, "Any unit", 87, FP)})
					DisplayPrintEr(GCP, {"\x07『 \x04유닛 \x1B자동구입 \x08OFF \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),0)
				CIfXEnd()
				CJumpEnd(FP,PBJump2)

				CJump(FP, PBJump3)
				NJumpEnd(FP, PBJump4)
				
				CIfX(FP,{TDeathsX(GCP,Exactly,0,3,2)},{TSetDeathsX(GCP,SetTo,2,3,2)})
				DisplayPrintEr(GCP, {"\x07『 \x04강화 \x1C내부계산 \x04모드 \x07ON \x07』"})
				CElseX({TSetDeathsX(GCP,SetTo,0,3,2)})
				DisplayPrintEr(GCP, {"\x07『 \x04강화 \x1C내부계산 \x04모드 \x08OFF \x07』"})
				CIfXEnd()

				CJumpEnd(FP,PBJump3)




			CElseIfX({CV(G_BtnFnm,2,AtLeast),CV(G_BtnFnm,5,AtMost)})--자동강화 1~25
				TriggerX(FP, {CV(G_BtnFnm,3)}, AddV(G_PushBtnm,25), {preserved})
				TriggerX(FP, {CV(G_BtnFnm,5)}, AddV(G_PushBtnm,25), {preserved})
				local GetArrNum = CreateVar(FP)
				local TxtColor = CreateVar(FP)
				f_Mul(FP, GetArrNum, G_PushBtnm, 7)
				CAdd(FP,GetArrNum,GCP)

				DoActionsX(FP,{SetV(TxtColor,0x06),AddV(G_PushBtnm,1)})
				TriggerX(FP, {CV(G_PushBtnm,26,AtLeast)}, SetV(TxtColor,0x0F), {preserved})

				CIf(FP,{CV(G_BtnFnm,2,AtLeast),CV(G_BtnFnm,3,AtMost)})
					CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr2,GetArrNum)),Exactly,0)})
					CallTriggerX(FP,Call_Print13CP,{})
					CTrigger(FP, {TMemory(0x512684,Exactly,GCP)}, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})		
					CElseX()
					CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr,GetArrNum)),Exactly,0)})
						CIfX(FP,{TDeathsX(GCP,Exactly,0,3,2)})
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x07ON \04(판매 우선 적용됨) \x07』",})
						CElseX()
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x07ON \04(내부 계산으로 작동. 판매 우선 적용됨) \x07』",})
						CIfXEnd()
						CMovX(FP,ArrX(AutoEnchArr,GetArrNum),1)
					CElseX()
						CIfX(FP,{TDeathsX(GCP,Exactly,0,3,2)})
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x08OFF \04(판매 우선 적용됨) \x07』",})
						CElseX()
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x08OFF \04(내부 계산으로 작동. 판매 우선 적용됨) \x07』",})
						CIfXEnd()
						CMovX(FP,ArrX(AutoEnchArr,GetArrNum),0)
					CIfXEnd()
					CIfXEnd()

				CIfEnd()
				CIf(FP,{CV(G_BtnFnm,4,AtLeast),CV(G_BtnFnm,5,AtMost)})
					CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr2,GetArrNum)),Exactly,0)})
					CallTriggerX(FP,Call_Print13CP,{})
					CTrigger(FP, {TMemory(0x512684,Exactly,GCP)}, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 최소 1회 이상 해당 유닛의 강화를 성공해야합니다."))}, {preserved})		
					CElseX()
					CIfX(FP,{TMemory(_TMem(ArrX(AutoSellArr,GetArrNum)),Exactly,0)})
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x07자동판매 \x07ON \04(판매 우선 적용됨) \x07』",})
						CMovX(FP,ArrX(AutoSellArr,GetArrNum),1)

					CElseX()
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x07자동판매 \x08OFF \04(판매 우선 적용됨) \x07』",})
						CMovX(FP,ArrX(AutoSellArr,GetArrNum),0)
					CIfXEnd()
				CIfXEnd()

				CIfEnd()
				

			local MulOpVArr = GetVArray(iv.MulOp[1], 7)
			local MulOpVArr2 = CreateVArr(7, FP)
			local GetMulData = CreateVar(FP)
			local GetMulData2 = CreateVar(FP)
			local SCheck = CreateCcode()
			local GetVAccData = CreateVar(FP)
			local GetClassData = CreateVar(FP)
			local GetMissionData = CreateVar(FP)

			CElseIfX(CV(G_BtnFnm,6))
			CMovX(FP,GetMissionData,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4))
				CIf(FP,{CV(G_PushBtnm,0)}) -- 배율 올림
					CMovX(FP,GetMulData,VArrX(MulOpVArr,VArrI,VArrI4))
					CMovX(FP,GetMulData2,VArrX(MulOpVArr2,VArrI,VArrI4))

					Print_13X(FP, GCP)
					CIfX(FP,{CV(GetMulData,50000000-1,AtMost)},{},{preserved})	-- 조건이 만족할 경우
						CMov(FP,GetMissionData,8,nil,8)
						CIfX(FP,{CV(GetMulData2,0)})
						f_Mul(FP,GetMulData,5)
						CMov(FP,GetMulData2,1)
						CElseX()
						f_Mul(FP,GetMulData,2)
						CMov(FP,GetMulData2,0)
						CIfXEnd()
						CMovX(FP,VArrX(MulOpVArr,VArrI,VArrI4),GetMulData)
						CMovX(FP,VArrX(MulOpVArr2,VArrI,VArrI4),GetMulData2)
						CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{print_utf8(12,0,StrDesign("\x03System \x04: 배율을 올렸습니다."))},{preserved})
					CElseX()--조건이 만족하지 않을 경우
						CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 더 이상 배율을 올릴 수 없습니다."))},{preserved})
					CIfXEnd()
				CIfEnd()
				
				CIf(FP,{CV(G_PushBtnm,1)}) -- 배율 내림
					CMovX(FP,GetMulData,VArrX(MulOpVArr,VArrI,VArrI4))
					CMovX(FP,GetMulData2,VArrX(MulOpVArr2,VArrI,VArrI4))
					Print_13X(FP, GCP)
					CIfX(FP,{CV(GetMulData,2,AtLeast)},{},{preserved})	-- 조건이 만족할 경우
						CMov(FP,GetMissionData,8,nil,8)
						CIfX(FP,{CV(GetMulData2,1)})
						f_Div(FP,GetMulData,5)
						CMov(FP,GetMulData2,0)
						CElseX()
						f_Div(FP,GetMulData,2)
						CMov(FP,GetMulData2,1)
						CIfXEnd()
						CMovX(FP,VArrX(MulOpVArr,VArrI,VArrI4),GetMulData)
						CMovX(FP,VArrX(MulOpVArr2,VArrI,VArrI4),GetMulData2)
						CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{print_utf8(12,0,StrDesign("\x03System \x04: 배율을 내렸습니다."))},{preserved})
					CElseX()--조건이 만족하지 않을 경우
						CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 더 이상 배율을 내릴 수 없습니다."))},{preserved})
					CIfXEnd()
				CIfEnd()--
				CIf(FP,{CV(G_PushBtnm,2)}) -- 싱글플레이 버튼
					CIfX(FP,{TBring(GCP, AtLeast, 1, 15, 115)},{},{preserved})	-- 조건이 만족할 경우 싱글전환
						CIf(FP,{TMemory(0x512684,Exactly,GCP),CV(iv.PCheckV,2,AtLeast),CD(SCheck,1)})
							f_Read(FP, 0x628438, nil, Nextptrs)
							CTrigger(FP,{},{CreateUnit(1,94,136,FP),RemoveUnit(94,FP),TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText(StrDesignX("\x08싱글 플레이로 전환합니다. 이 설정은 되돌릴 수 없습니다."),4),SetCp(FP),},{preserved})
							CSub(FP,CurCunitI,Nextptrs,19025)
							f_Div(FP,CurCunitI,_Mov(84))
							CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,94))})
							CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV),})
							CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,2,SetTo,_Add(CT_GNextRandV,FP)),})
							
							--CallTrigger(FP, Call_CTInputUID)
						CIfEnd()
						CIf(FP, {CV(iv.PCheckV,2,AtLeast)})
							CTrigger(FP,{TMemory(0x512684,Exactly,GCP),CD(SCheck,0)},{SetCD(SCheck,1),TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText(StrDesignX("\x04정말로 \x08싱글플레이\x04로 \x07전환\x04하시겠습니까? \x08원하시면 한번 더 눌러주세요."),4),SetCp(FP),},{preserved})

						CIfEnd()
					CElseX()--조건이 만족하지 않을 경우
						Print_13X(FP, GCP)
						CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 시민을 싱글 플레이 설정 위치로 이동한 후 사용가능합니다."))},{preserved})
					CIfXEnd()
					CIfX(FP,{CD(iv.PartyBonus,2,AtLeast)})
						CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText("\x07멀티 보너스 버프 \x04활성화 상태 : \x07런쳐 로드 인원이 2명이상 인식되어 영구 활성화 되었습니다.",4)})
					CElseIfX({CV(iv.PCheckV,2,AtLeast)})
						CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText("\x07멀티 보너스 버프 \x04활성화 상태 : \x07활성화 되었지만 런쳐 로드 인원이 1명 이하입니다. 솔로 플레이로 전환할 경우 버프가 \x08비활성화됩니다.",4)})
					CElseX()
						CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText("\x07멀티 보너스 버프 \x04활성화 상태 : \x08활성화 불가능.",4)})
					CIfXEnd()
				CIfEnd()--
			CMovX(FP,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4),GetMissionData)
			
			CElseIfX(CV(G_BtnFnm,7)) -- 고유유닛 버튼셋 제어부
			--1 = 연결됨
			--2 = 연결 끊킴
			--3 = 로드중
			--4 = 로드 완료
			--5 = 세이브중
			--6 = 세이브 완료
			--7 = 런처와 먼저 연결하세요
			--8 = 다른 작업 중입니다.
			--9 = 작업 실패
			--10 = 명령 실행
			CIfX(FP, {TDeathsX(GCP, Exactly, 1, 1,1)},{TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText("\n\n\n\n\n\n\n\n\n", 4),SetCp(FP)})
				GetCreditData = CreateWar(FP)
				GerRandData = CreateVar(FP)
				GetPMissionData = CreateVar(FP)
				GetAwakItemData = CreateVar(FP)
				f_LMov(FP,GetCreditData,"0",nil,nil,1)--크레딧 복사버그 방지용 초기화...?
				CMovX(FP,GetPMissionData,VArrX(GetVArray(iv.PMission[1], 7),VArrI,VArrI4))
				CMovX(FP,GetMissionData,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4))
				CMovX(FP,GetClassData,VArrX(GetVArray(iv.PUnitClass[1], 7),VArrI,VArrI4))
				CMovX(FP,GetPUnitLevel,VArrX(GetVArray(iv.PUnitLevel[1], 7),VArrI,VArrI4))
				CMovX(FP,GetVAccData,VArrX(GetVArray(iv.VaccItem[1], 7),VArrI,VArrI4))
				CMovX(FP,GetAwakItemData,VArrX(GetVArray(iv.AwakItem[1], 7),VArrI,VArrI4))
				f_LMovX(FP, GetCreditData, WArrX(GetWArray(iv.Credit[1], 7), WArrI, WArrI4))
				--SaveChkData = CreateVar(FP)
				GetEnchCoolData = CreateVar(FP)
				
				CIf(FP,{CV(G_PushBtnm,0,AtLeast),CV(G_PushBtnm,1,AtMost)}) -- 
					CIfX(FP,{CV(GetPUnitLevel,10,AtLeast)})--CV(SaveChkData,1,AtLeast)
						CTrigger(FP,{},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 이미 최고단계까지 강화되었습니다. \x07승급\x04을 진행해주세요."), 4),SetCp(FP)},{preserved})
						--CTrigger(FP,{CV(SaveChkData,1,AtLeast)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 강화를 진행하기 위해선 먼저 저장해야 합니다. F9를 눌러주세요."), 4),SetCp(FP)},{preserved})
						CElseX()
						PrevPUnitLevel = CreateVar(FP)
						CIfX(FP,{TTNWar(GetCreditData, AtLeast, _LAdd(_LMul({GetPUnitLevel,0},"1000"),"1000"))})
							VaccJump = def_sIndex()
							CIfX(FP, {CV(G_PushBtnm,1),CV(GetVAccData,0)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x10강화기 백신\x04이 부족합니다."), 4),SetCp(FP)})
							CElseX()
								CMov(FP, GetMissionData, 2, nil, 2)
								CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
								CTrigger(FP,{CV(GetPUnitLevel,8,AtLeast)},{TSetDeaths(GCP, SetTo, 0, 1)},{preserved})--저장필요 SetV(SaveChkData,1),
								f_LSub(FP, GetCreditData, GetCreditData, _LAdd(_LMul({GetPUnitLevel,0},"1000"),"1000"))
								CTrigger(FP,{},{TSetNVar(GerRandData, SetTo, _Rand())},1)
								GPEper = CreateVar(FP)
								GerRandData2 = CreateVar(FP)
								CMov(FP,GerRandData2,GerRandData)
								CMov(FP,GerRandData,0)
								CMov(FP,GPEper,_Mod(GerRandData2,10000),1)
								CrShift(FP, GerRandData2, 16)
								PUnitEPer = CreateVar(FP)
								CMov(FP,PUnitEPer,_Sub(_Mov(10001),_Mul(GetPUnitLevel,1000)))

								if Limit == 1 then -- 테스트용 결과 출력
									ColorCodeV = CreateVar2(FP,nil,nil,0x0E)
									ColorCodeV2 = CreateVar2(FP,nil,nil,0x0F)
									ColorCodeV3 = CreateVar2(FP,nil,nil,0x10)
									ColorCodeV4 = CreateVar2(FP,nil,nil,0x1B)
									CMov(FP,E1Range[1],1)
									CMov(FP,E1Range[2],PUnitEPer)
						
									DisplayPrint(GCP,{"\x04출력된 난수 : ",ColorCodeV[2],GPEper})
									DisplayPrint(GCP,{"\x1F계산된 확률 : ",ColorCodeV4[2],E1Range[1]," \x04~ ",E1Range[2]})
									
								end
								CIfX(FP,{CV(GPEper,1,AtLeast),CV(GPEper,PUnitEPer,AtMost)})--성공시
									--"\x13\x07『 "..Str.." \x07』"
									CIf(FP,Memory(0x628438,AtLeast,1))
									f_Read(FP,_Add(G_Btnptr,10),CPos)
									Convert_CPosXY()
									f_Read(FP, 0x628438, nil, Nextptrs)
									CSub(FP,CurCunitI,Nextptrs,19025)
									f_Div(FP,CurCunitI,_Mov(84))
									CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,94))})
									CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV),})
									CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,2,SetTo,_Add(CT_GNextRandV,FP)),})
									Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,{CreateUnitWithProperties(1,94,87,FP,{hallucinated = true}),KillUnit(94, FP)})
									CIfEnd()
									CMov(FP,PrevPUnitLevel,GetPUnitLevel)
									CAdd(FP,GetPUnitLevel,1)
									CAdd(FP,GetPMissionData,1)
									DisplayPrint(GCP, {"\x13\x07『 \x04강화에 \x07성공하셨습니다! \x07",PrevPUnitLevel,"강 → ",GetPUnitLevel,"강 \x07』"})
									TriggerX(FP,{CV(G_PushBtnm,1),CV(GetPUnitLevel,10)},{SetVX(GetMissionData,128,128)},{preserved})--
								CElseX()--실패시
								CMov(FP,GetPMissionData,1)
								CMov(FP,GetMissionData,8192,nil,8192)

								--TriggerX(FP,{CV(G_PushBtnm,1,AtLeast)},{},{preserved})--백신 사용
									CMov(FP,GPEper,_Mod(GerRandData2,10000),1)
									if Limit == 1 then -- 테스트용 결과 출력
										ColorCodeV = CreateVar2(FP,nil,nil,0x0E)
										ColorCodeV2 = CreateVar2(FP,nil,nil,0x0F)
										ColorCodeV3 = CreateVar2(FP,nil,nil,0x10)
										ColorCodeV4 = CreateVar2(FP,nil,nil,0x1B)
										CMov(FP,E1Range[1],1)
										CMov(FP,E1Range[2],PUnitEPer)
							
										DisplayPrint(GCP,{"\x04출력된 난수 : ",ColorCodeV[2],GPEper})
										DisplayPrint(GCP,{"\x1F계산된 확률 : ",ColorCodeV4[2],E1Range[1]," \x04~ ",E1Range[2]})
										
									end
									CIfX(FP,{CV(GPEper,1,AtLeast),CV(GPEper,PUnitEPer,AtMost)})
										DisplayPrint(GCP, {"\x13\x07『 \x07강화\x04에 \x08실패\x04했지만 단계가 하락하지 않았습니다! ",GetPUnitLevel,"강 유지 \x07』"})
										f_Read(FP,_Add(G_Btnptr,10),CPos)
										Convert_CPosXY()
										Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,{CreateUnitWithProperties(1,22,87,FP,{hallucinated = false}),GiveUnits(All, 22, FP, 64, P9),KillUnit(22, P9)})
									CElseX()
									
										CIfX(FP,{CV(G_PushBtnm,1,AtLeast)},{SubV(GetVAccData,1)})
										f_Read(FP,_Add(G_Btnptr,10),CPos)
										Convert_CPosXY()
										Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,{CreateUnitWithProperties(1,94,87,FP,{hallucinated = false}),GiveUnits(All, 94, FP, 64, P9),KillUnit(94, P9)})
											DisplayPrint(GCP, {"\x13\x07『 \x07강화\x04에 \x08실패\x04했지만 \x10강화기 백신\x04을 사용하여 단계를 유지했습니다! ",GetPUnitLevel,"강 유지 \x07』"})
											DisplayPrint(GCP, {"\x13\x07『 \x04남은 \x10강화기 백신\x04 갯수 : ",GetVAccData," 개 \x07』"})
										CElseX()
										f_Read(FP,_Add(G_Btnptr,10),CPos)
										Convert_CPosXY()
										Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,{CreateUnitWithProperties(1,50,87,FP,{hallucinated = false}),GiveUnits(All, 50, FP, 64, P9),KillUnit(50, P9)})
											CMov(FP,PrevPUnitLevel,GetPUnitLevel)
											CSub(FP,GetPUnitLevel,1)
											DisplayPrint(GCP, {"\x13\x07『 \x04강화에 \x08실패\x04하여 단계가 하락하였습니다... \x08",PrevPUnitLevel,"강 → ",GetPUnitLevel,"강 \x07』"})
										CIfXEnd()
									CIfXEnd()

								CIfXEnd()
								
							CIfXEnd()
						CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})--크레딧이 부족합
						CIfXEnd()
					CIfXEnd()
			--		DisplayPrint(GCP, {"일반강화"})
				CIfEnd()

					GetPETicket = CreateVar(FP)
					CMovX(FP,GetPETicket,VArrX(GetVArray(iv.PETicket2[1], 7),VArrI,VArrI4))
					CIf(FP,{CV(G_PushBtnm,2)}) -- 확정강화
					CIfX(FP,{CV(GetPETicket,1,AtLeast)})
					CIfX(FP,{VRange(GetPUnitLevel, 7, 9)})
					CSub(FP, GetPETicket, 1)
					CMov(FP,PrevPUnitLevel,GetPUnitLevel)
					CAdd(FP,GetPUnitLevel,1)
					f_Read(FP,_Add(G_Btnptr,10),CPos)
					Convert_CPosXY()
					Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,{CreateUnitWithProperties(9,82,136,FP,{hallucinated = false}),MoveUnit(All, 82, FP, 136, 87),GiveUnits(All, 82, FP, 64, P9),KillUnit(82, P9)})
					DisplayPrint(GCP, {"\x13\x07『 \x1F확정 강화권\x04을 사용하여 강화하셨습니다. \x07",PrevPUnitLevel,"강 → ",GetPUnitLevel,"강 \x07』"})
					CMov(FP, GetMissionData, 128, nil, 128)
					CElseIfX({CV(GetPUnitLevel,6,AtMost)})
					CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 이 아이템은 \x087강 \x04이상 에서만 사용가능합니다. \x07강화\x04를 더 진행해주세요."), 4),SetCp(FP)})
					CElseX()
					CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 이미 최고단계까지 강화되었습니다. \x07승급\x04을 진행해주세요."), 4),SetCp(FP)})
					CIfXEnd()
					CElseX()
					CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 확정 강화권이 부족합니다."), 4),SetCp(FP)})
					CIfXEnd()


					CIfEnd()
					CMovX(FP,VArrX(GetVArray(iv.PETicket2[1], 7),VArrI,VArrI4),GetPETicket)


					local failflag = CreateCcode()
					CIf(FP,{CV(G_PushBtnm,3,AtLeast),CV(G_PushBtnm,10,AtMost)},{SetCD(failflag,0)}) -- 승급
						CIfX(FP,{CV(GetPUnitLevel,9,AtMost)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 승급에 필요한 강화 단계가 부족합니다. 필요 단계 : 10강"), 4),SetCp(FP)})
						CElseX()
							GetUID = CreateVar(FP)
							CMov(FP,GetUID,_SHRead(_Add(G_Btnptr,25)),nil,0xFF,1)
							CIfX(FP,{TBring(GCP, AtLeast, 1, GetUID, _Add(GCP,160))})--승급하기
								GetCooldownData,GetAtkData,GetEXPData,GetTotalEPerData,GetTotalEper4Data,GetDPSLVData,GetBrShData,GetLV3IncmData = CreateVars(8,FP)
								CMovX(FP,GetCooldownData,VArrX(GetVArray(iv.CS_Cooldown[1], 7),VArrI,VArrI4))
								CMovX(FP,GetBrShData,VArrX(GetVArray(iv.CS_BreakShield[1], 7),VArrI,VArrI4))
								CMovX(FP,GetAtkData,VArrX(GetVArray(iv.CS_Atk[1], 7),VArrI,VArrI4))
								CMovX(FP,GetEXPData,VArrX(GetVArray(iv.CS_EXP[1], 7),VArrI,VArrI4))
								CMovX(FP,GetTotalEPerData,VArrX(GetVArray(iv.CS_TotalEPer[1], 7),VArrI,VArrI4))
								CMovX(FP,GetTotalEper4Data,VArrX(GetVArray(iv.CS_TotalEper4[1], 7),VArrI,VArrI4))
								CMovX(FP,GetDPSLVData,VArrX(GetVArray(iv.CS_DPSLV[1], 7),VArrI,VArrI4))
								CMovX(FP,GetLV3IncmData,VArrX(GetVArray(iv.CSX_LV3Incm[1], 7),VArrI,VArrI4))
								

								ClassUpErrJump = def_sIndex()
								CMov(FP,0x6509B0,GCP)
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,3),CV(GetCooldownData,CS_CooldownLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 더 이상 공격속도를 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,4),CV(GetAtkData,CS_AtkLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 더 이상 공격력을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,5),CV(GetEXPData,CS_EXPLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 더 이상 판매시 경험치 획득량을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,6),CV(GetTotalEPerData,CS_TotalEPerLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 더 이상 +1 강화확률을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,7),CV(GetTotalEper4Data,CS_TotalEper4Limit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 더 이상 \x08특수 \x04강화확률을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,8),CV(GetDPSLVData,CS_DPSLVLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 해당 옵션은 1회만 사용 가능합니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,9),CV(GetBrShData,CS_BreakShieldLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 더 이상 \x1F파괴 방지 \x04확률을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,10),CV(GetLV3IncmData,CSX_LV3IncmLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 더 이상 \x11LV.MAX \x1B허수아비\x04 돈 수급량 \x04을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,10),CV(GetClassData,261,AtMost)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x07262단 이상\x04에서만 사용 가능한 옵션입니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,10),CV(GetAwakItemData,_Sub(GetClassData,_Mov(262)),AtMost)},{SetCD(failflag,1),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP)})
								CIfX(FP,{TTNWar(GetCreditData,AtLeast,"1000000")})
									CMov(FP, GetMissionData, 16, nil, 16)
									CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
									f_Read(FP,_Add(G_Btnptr,10),CPos)
									Convert_CPosXY()
									Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,{CreateUnitWithProperties(9,82,136,FP,{hallucinated = false}),MoveUnit(All, 82, FP, 136, 87),GiveUnits(All, 82, FP, 64, P9),KillUnit(82, P9)})
									f_LSub(FP, GetCreditData, GetCreditData, "1000000")
									PrevClassLevel = CreateVar(FP)
									local TempV = CreateVar(FP)
									CMov(FP,GetPUnitLevel,0)
									CMov(FP,PrevClassLevel,GetClassData)
									CAdd(FP,GetClassData,1)
									DisplayPrint(GCP, {"\x13\x07『 \x07축하합니다! \x04승급에 성공하셨습니다! \x07",PrevClassLevel,"단 → ",GetClassData,"단 \x07』"})
									CIf(FP,{CV(G_PushBtnm,3)},{AddV(GetCooldownData,1)})
										CMov(FP,TempV,_rShift(_SHRead(ArrX(PUnitCoolArr,GetCooldownData)), 8))
										DisplayPrint(GCP, {"\x13\x07『 \x07고유 유닛\x04의 공격속도가 증가하였습니다. \x04증가 후 Cooldown : \x07",TempV," \x07』"})
									CIfEnd()
									CIf(FP,{CV(G_PushBtnm,4)},{AddV(GetAtkData,1)})
										CMov(FP,TempV,_Mul(GetAtkData,6500),200)
										DisplayPrint(GCP, {"\x13\x07『 \x07고유 유닛\x04의 공격력이 증가하였습니다. \x04증가 후 \x08Damage \x04: \x07",TempV," \x07』"})
									CIfEnd()
									CIf(FP,{CV(G_PushBtnm,5)},{AddV(GetEXPData,1)})
										CMov(FP,TempV,_Mul(GetEXPData,20))
										DisplayPrint(GCP, {"\x13\x07『 \x1C판매시 경험치 증가량\x04이 상승하였습니다. \x04증가 후 \x04: \x1C+ ",TempV,"% \x07』"})
									CIfEnd()
									CIf(FP,{CV(G_PushBtnm,6)},{AddV(GetTotalEPerData,1)})
										CMov(FP,TempV,_Mul(GetTotalEPerData,250))
										CMov(FP,GEVar,TempV)
										CallTrigger(FP, Call_SetEPerStr)
										DisplayPrint(GCP, {"\x13\x07『 \x0F+1 \x07강화확률\x04이 증가하였습니다. \x04증가 후 \x04: \x0F+ ",EVarArr2,".",EVarArr3,"%p \x07』"})
									CIfEnd()
									CIf(FP,{CV(G_PushBtnm,7)},{AddV(GetTotalEper4Data,1)})
										CMov(FP,TempV,_Mul(GetTotalEper4Data,500))
										CMov(FP,GEVar,TempV)
										CallTrigger(FP, Call_SetEPerStr)
										DisplayPrint(GCP, {"\x13\x07『 \x08특수 \x07강화확률\x04이 증가하였습니다. \x04증가 후 \x04: \x07+ \x08",EVarArr2,".",EVarArr3,"%p \x07』"})
									CIfEnd()
									CIf(FP,{CV(G_PushBtnm,8)},{AddV(GetDPSLVData,1),TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText(StrDesignX("\x04이제부터 \x07고유 유닛\x04으로 \x0FLV.2 \x04사냥터에 입장할 수 있습니다."))})
									CIfEnd()
									CIf(FP,{CV(G_PushBtnm,9)},{AddV(GetBrShData,1)})
										CMov(FP,TempV,_Mul(GetBrShData,100))
										CMov(FP,GEVar,TempV)
										CallTrigger(FP, Call_SetEPerStr)
										DisplayPrint(GCP, {"\x13\x07『 \x08특수 \x1F파괴방지 \x04확률이 증가하였습니다. \x04증가 후 \x04: \x07+ \x08",EVarArr2,".",EVarArr3,"%p \x07』"})
									CIfEnd()
									
									CIf(FP,{CV(G_PushBtnm,10)},{AddV(GetLV3IncmData,1),SubV(GetAwakItemData, _Sub(GetClassData,262))})
										CMov(FP,TempV,_Mul(GetLV3IncmData,100))
										CMov(FP,GEVar,TempV,1000)
										CallTrigger(FP, Call_SetEPerStr)
										DisplayPrint(GCP, {"\x13\x07『 \x11LV.MAX \x1B허수아비\x04 돈 수급량이 증가하였습니다. \x04증가 후 \x04: \x07+ \x08",EVarArr2,".",EVarArr3," 배 \x07』"})
									CIfEnd()

									CMovX(FP,VArrX(GetVArray(iv.CS_Cooldown[1], 7),VArrI,VArrI4),GetCooldownData)
									CMovX(FP,VArrX(GetVArray(iv.CS_BreakShield[1], 7),VArrI,VArrI4),GetBrShData)
									CMovX(FP,VArrX(GetVArray(iv.CS_Atk[1], 7),VArrI,VArrI4),GetAtkData)
									CMovX(FP,VArrX(GetVArray(iv.CS_EXP[1], 7),VArrI,VArrI4),GetEXPData)
									CMovX(FP,VArrX(GetVArray(iv.CS_TotalEPer[1], 7),VArrI,VArrI4),GetTotalEPerData)
									CMovX(FP,VArrX(GetVArray(iv.CS_TotalEper4[1], 7),VArrI,VArrI4),GetTotalEper4Data)
									CMovX(FP,VArrX(GetVArray(iv.CS_DPSLV[1], 7),VArrI,VArrI4),GetDPSLVData)
									CMovX(FP,VArrX(GetVArray(iv.CSX_LV3Incm[1], 7),VArrI,VArrI4),GetLV3IncmData)


								CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
								CIfXEnd()
								NJumpXEnd(FP,ClassUpErrJump)
								CIf(FP,{CD(failflag)})
									local Tempea = CreateVar(FP)
									CMov(FP,Tempea,_Sub(GetClassData,_Mov(261)))
									DisplayPrint(GCP, {"\x13\x07『 \x08ERROR \x04: \x1E각성의 보석\x04이 부족합니다. \x1E필요 각성의 보석 : ",Tempea," 개 \x07』"})
								CIfEnd()
							CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 해당 기능은 승급장에서 사용가능합니다."), 4),SetCp(FP)})
							CIfXEnd()
						CIfXEnd()

					CIfEnd()

				CMovX(FP,VArrX(GetVArray(iv.PMission[1], 7),VArrI,VArrI4),GetPMissionData)
				CMovX(FP,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4),GetMissionData)
				CMovX(FP,VArrX(GetVArray(iv.PUnitLevel[1], 7),VArrI,VArrI4),GetPUnitLevel)
				f_LMovX(FP, WArrX(GetWArray(iv.Credit[1], 7), WArrI, WArrI4), GetCreditData)
				CMovX(FP,VArrX(GetVArray(iv.VaccItem[1], 7),VArrI,VArrI4),GetVAccData)
				CMovX(FP,VArrX(GetVArray(iv.PUnitClass[1], 7),VArrI,VArrI4),GetClassData)
				CMovX(FP,VArrX(GetVArray(iv.AwakItem[1], 7),VArrI,VArrI4),GetAwakItemData)


				
			CElseIfX({TTNVar(G_PushBtnm,NotSame,11)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 런쳐에 연결되어있지 않아 기능을 사용할 수 없습니다."), 4),SetCp(FP)})
			CIfXEnd()
			
			CIf(FP,{CV(G_PushBtnm,11)},{TSetMemory(0x6509B0, SetTo, GCP)})
				CMovX(FP,GetCooldownData,VArrX(GetVArray(iv.CS_Cooldown[1], 7),VArrI,VArrI4))
				CMovX(FP,GetAtkData,VArrX(GetVArray(iv.CS_Atk[1], 7),VArrI,VArrI4))
				CMovX(FP,GetBrShData,VArrX(GetVArray(iv.CS_BreakShield[1], 7),VArrI,VArrI4))
				CMovX(FP,GetEXPData,VArrX(GetVArray(iv.CS_EXP[1], 7),VArrI,VArrI4))
				CMovX(FP,GetTotalEPerData,VArrX(GetVArray(iv.CS_TotalEPer[1], 7),VArrI,VArrI4))
				CMovX(FP,GetTotalEper4Data,VArrX(GetVArray(iv.CS_TotalEper4[1], 7),VArrI,VArrI4))
				CMovX(FP,GetDPSLVData,VArrX(GetVArray(iv.CS_DPSLV[1], 7),VArrI,VArrI4))
				CMovX(FP,GetLV3IncmData,VArrX(GetVArray(iv.CSX_LV3Incm[1], 7),VArrI,VArrI4))
				CMov(FP,TempV,_rShift(_SHRead(ArrX(PUnitCoolArr,GetCooldownData)), 8))
				DisplayPrint(GCP, {"\x07『 \x07고유 유닛\x04의 공격속도 - Cooldown : \x07",TempV," \x04(Level : \x07",GetCooldownData,"\x04) \x07』"})
				CMov(FP,TempV,_Mul(GetAtkData,6500),200)
				DisplayPrint(GCP, {"\x07『 \x07고유 유닛\x04의 공격력 - \x08Damage \x04: \x07",TempV," \x04(Level : \x07",GetAtkData,"\x04) \x07』"})
				CMov(FP,TempV,_Mul(GetEXPData,20))
				DisplayPrint(GCP, {"\x07『 \x1C판매시 경험치 증가량\x04 : \x1C+ ",TempV,"% \x04(Level : \x07",GetEXPData,"\x04) \x07』"})
				CMov(FP,TempV,_Mul(GetTotalEPerData,250))
				CMov(FP,GEVar,TempV)
				CallTrigger(FP, Call_SetEPerStr)
				DisplayPrint(GCP, {"\x07『 \x0F+1 \x07강화 확률 \x04증가량 \x04: \x0F+ ",EVarArr2,".",EVarArr3,"%p \x04(Level : \x07",GetTotalEPerData,"\x04) \x07』"})
				CMov(FP,TempV,_Mul(GetTotalEper4Data,500))
				CMov(FP,GEVar,TempV)
				CallTrigger(FP, Call_SetEPerStr)
				DisplayPrint(GCP, {"\x07『 \x08특수 \x07강화 확률\x04 증가량 : \x07+ \x08",EVarArr2,".",EVarArr3,"%p \x04(Level : \x07",GetTotalEper4Data,"\x04) \x07』"})
				CMov(FP,TempV,_Mul(GetBrShData,100))
				CMov(FP,GEVar,TempV)
				CallTrigger(FP, Call_SetEPerStr)
				DisplayPrint(GCP, {"\x07『 \x08특수 \x1F파괴방지 \x04확률 증가량 : \x07+ \x08",EVarArr2,".",EVarArr3,"%p \x04(Level : \x07",GetBrShData,"\x04) \x07』"})
				
				CTrigger(FP,{CV(GetDPSLVData,0)},{TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText(StrDesign("\x0ELV.1 사냥터 \x04입장 효과 적용중"), 4)},1)
				CTrigger(FP,{CV(GetDPSLVData,1)},{TSetMemory(0x6509B0, SetTo, GCP),DisplayExtText(StrDesign("\x0FLV.2 사냥터 \x04입장 효과 적용중"), 4)},1)
				CMov(FP,TempV,_Mul(GetLV3IncmData,100))
				CMov(FP,GEVar,TempV,1000)
				CallTrigger(FP, Call_SetEPerStr)
				DisplayPrint(GCP, {"\x07『 \x11LV.MAX \x1B허수아비\x04 돈 수급 추가 증가량 : \x07+ \x08",EVarArr2,".",EVarArr3," 배 \x04(\x1E각성 Level \x04: \x1F",GetLV3IncmData,"\x04) \x07』"})
				
			CIfEnd()
			
			CIf(FP,{CV(G_PushBtnm,12)},{})
				GetPBossLV = CreateVar(FP)
				CMovX(FP,GetPBossLV,VArrX(GetVArray(iv.PBossLV[1], 7),VArrI,VArrI4))
				local PUID = CreateVar(FP)
				CMov(FP,PUID,_ReadF(_Add(G_Btnptr,25)),nil,0xFF,1)
				CIfX(FP,{CV(GetPBossLV,4,AtMost)},{TSetMemory(0x6509B0, SetTo, GCP),TMoveUnit(1, PUID, GCP, 64, GCP+119),DisplayExtText(StrDesignX("\x04고유 유닛을 \x0ELV.1 \x07보스 존\x04으로 이동합니다."), 4),SetCp(FP)})
				CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 이미 \x07보스\x04를 모두 소탕하였습니다."), 4),SetCp(FP)})
				CIfXEnd()

			CIfEnd()


			CIfXEnd()



		CIfEnd()--ShopEnd
		CDoActions(FP,{
			TSetMemory(_Add(G_Btnptr,0x98/4),SetTo,0 + 228*65536);
			TSetMemory(_Add(G_Btnptr,0x9C/4),SetTo,228 + 228*65536);
			TSetMemoryX(_Add(G_Btnptr,0xA0/4),SetTo,228,0xFFFF)})
	CIfEnd()


		
	SetCallEnd()



	Call_BtnInit = SetCallForward()

	local BtnFncArr = {
		TestShop[1], -- 유닛 자동구매기
		SettingUnit1[1], -- 1~25강유닛 자동강화 설정
		SettingUnit2[1], -- 26~39유닛 자동강화 설정
		SettingUnit3[1], -- 15~25강유닛 자동판매 설정
		SettingUnit4[1], -- 26~39유닛 자동판매 설정
		ShopUnit[1], -- 시민
		PUnitPtr[1], -- 고유유닛
		TestShop2[1], -- 유닛 자동구매기
	}
	SetCall(FP)
	for j,k in pairs(BtnFncArr) do
		local BtnVA = GetVArray(k, 7)
		CMovX(FP,G_Btnptr,VArrX(BtnVA,VArrI,VArrI4),nil,nil,nil,1)
		CallTrigger(FP,Call_BtnFnc,{SetV(G_BtnFnm,j)})
	end
	



		
	SetCallEnd()



	Call_GetLocalData = SetCallForward()
	SetCall(FP)
	
	
	for j,k in pairs(LocalDataArr) do
		if k[1][4]=="V" then
			local LocPVA = GetVArray(k[1], 7)
			CMovX(FP,k[2],VArrX(LocPVA,VArrI,VArrI4),nil,nil,nil,1)
		elseif k[1][4]=="W" then
			local LocPWA = GetWArray(k[1], 7)
			f_LMovX(FP, k[2], WArrX(LocPWA, WArrI,WArrI4), SetTo, nil,nil, 1)
		else
			PushErrorMsg("LocalDataArr_InputError")
		end
	end
	
	
	f_LMov(FP,iv.MoneyLoc,WArrX(GetWArray(iv.Money[1], 7), WArrI,WArrI4),nil,nil,1)
	f_LMov(FP,iv.CredLoc,WArrX(GetWArray(iv.Credit[1], 7), WArrI,WArrI4),nil,nil,1)
	f_LMov(FP,iv.ExpLoc,_LSub(WArrX(GetWArray(iv.PEXP[1], 7),WArrI,WArrI4), WArrX(GetWArray(iv.CurEXP[1], 7),WArrI,WArrI4)),nil,nil,1)
	f_LMov(FP,iv.TotalExpLoc,_LSub(WArrX(GetWArray(iv.TotalExp[1], 7), WArrI,WArrI4), WArrX(GetWArray(iv.CurEXP[1], 7), WArrI,WArrI4)),nil,nil,1)
	CMov(FP,iv.ResetStatLoc,VArrX(GetVArray(iv.ResetStat[1], 7),VArrI,VArrI4))
	CMov(FP,iv.ResetStat2Loc,VArrX(GetVArray(iv.ResetStat2[1], 7),VArrI,VArrI4))


	
	
	CMov(FP,iv.LCP,GCP)




	SetCallEnd()

	local TempWX = CreateWar(FP)
	local LIndex = CreateVar(FP)
	StartLV = CreateVar(FP)
	EndLV = CreateVar(FP)
	local TempW = CreateWar(FP)
	local TempW2 = CreateWar(FP)
	Call_GetLevelEXP = SetCallForward()
	SetCall(FP)
	
	ConvertLArr(FP, LIndex, _Add(StartLV, 150), 8)--151 포커스
	f_LRead(FP, LArrX({EXPArr_dp},LIndex), TempW, nil, 1) -- start

	ConvertLArr(FP, LIndex, _Add(EndLV, 150), 8)--151 포커스
	f_LRead(FP, LArrX({EXPArr_dp},LIndex), TempW2, nil, 1) -- start


	f_LSub(FP, TempWX, TempW2, TempW)

	CAdd(FP,StartLV,1)


	SetCallEnd()

	SCA_cp = CreateVar(FP)
	function SCA_DataReset(cp,cond) -- 슬롯 불러오기 or 저장전 데이터 초기화를 위한 함수
		CallTriggerX(FP, Call_DataReset, cond, {SetV(SCA_cp,cp)})
		
	end
	Call_DataReset = SetCallForward()
	SetCall(FP)
	local Pl = CreateVar(FP)
	CMul(FP,Pl,SCA_cp,18)
	for j,k in pairs(SCA_DataArr) do
		local Destptr = k[2]
		local Player = SCA_cp
		local Source = k[1][1]--1P기준
	if Source[4]=="V" then
		CDoActions(FP, {TSetMemory(_Add(Destptr,Pl), SetTo, 0)})
	elseif Source[4]=="W" then
		if #Destptr~=2 then PushErrorMsg("SCA_Destptr_Inputdata_Error") end
		CDoActions(FP, {
			TSetMemory(_Add(Destptr[1],Pl), SetTo, 0),
			TSetMemory(_Add(Destptr[2],Pl), SetTo, 0)
		})
	else
		PushErrorMsg("SCA_Source_Inputdata_Error")
	end
	
	end
	SetCallEnd()

	Call_SCA_DataSaveAll = SetCallForward()
	PlayerV = CreateVar(FP)
	SetCall(FP)
	CMov(FP,PlayerV,_Mul(GCP,_Mov(18)))
	for j,k in pairs(SCA_DataArr) do
		SCA_DataSaveG(PlayerV,k[1],k[2])
	end
	SetCallEnd()
	Call_SCA_DataLoadAll = SetCallForward()
	SetCall(FP)
	CMov(FP,PlayerV,_Mul(GCP,_Mov(18)))
	for j,k in pairs(SCA_DataArr) do
		SCA_DataLoadG(PlayerV,k[1],k[2],k[3])
	end
	SetCallEnd()
	

	Call_FfragShop = SetCallForward()
	SetCall(FP)
	
	FragBuyFnc(iv.FXPer44,Cost_FXPer44,iv.Cost_FXPer44Loc,CntCArr[1],failCcode)
	FragBuyFnc(iv.FXPer45,Cost_FXPer45,iv.Cost_FXPer45Loc,CntCArr[2],failCcode)
	FragBuyFnc(iv.FXPer46,Cost_FXPer46,iv.Cost_FXPer46Loc,CntCArr[3],failCcode)
	FragBuyFnc(iv.FXPer47,Cost_FXPer47,iv.Cost_FXPer47Loc,CntCArr[4],failCcode)
	FragBuyFnc(iv.FXPer48,Cost_FXPer48,iv.Cost_FXPer48Loc,CntCArr[5],failCcode)
	FragBuyFnc(iv.FIncm,Cost_FIncm,iv.Cost_FIncmLoc,CntCArr[6],failCcode)
	FragBuyFnc(iv.FSEXP,Cost_FSEXP,iv.Cost_FSEXPLoc,CntCArr[7],failCcode)
	FragBuyFnc(iv.FBrSh,Cost_FBrSh,iv.Cost_FBrShLoc,CntCArr[8],failCcode)
	FragBuyFnc(iv.FMEPer,Cost_FMEPer,iv.Cost_FMEPerLoc,CntCArr[9],failCcode)
	FragBuyFnc(iv.FMin,Cost_FMin,iv.Cost_FMinLoc,CntCArr[10],failCcode)
	SetCallEnd()
	Call_StatShop = SetCallForward()
	SetCall(FP)
	
	ClickCD = CreateCcode()
	ClickCD2 = CreateCcode()
	GetINumData = CreateVar(FP)
	GetPStatData = CreateVar(FP)
	CMovX(FP,GetINumData,VArrX(GetVArray(iv.InterfaceNum[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetPStatData,VArrX(GetVArray(iv.StatP[1], 7), VArrI, VArrI4),nil,nil,nil,1)

	function StatBuyFunc(KeyID,StatID,Cost,Multiplier,Max,SendTxt,ErrTxt)
		local TempSID = CreateVar(FP)
		CIf(FP,{MSQC_TKeyInput(GCP, KeyID)})
			CallTrigger(FP, Call_Print13CP)
			CMovX(FP,TempSID,VArrX(GetVArray(StatID[1], 7), VArrI, VArrI4),nil,nil,nil,1)
			CIfX(FP, {CV(GetPStatData,Cost,AtLeast),CV(TempSID,Max-1,AtMost)},{SubV(GetPStatData,Cost),AddV(TempSID,Multiplier)})
			CMovX(FP,VArrX(GetVArray(StatID[1], 7), VArrI, VArrI4),TempSID,nil,nil,nil,1)
			CTrigger(FP, {TMemory(0x512684,Exactly,GCP)},print_utf8(12,0,SendTxt) ,{preserved})
			CElseIfX({CV(TempSID,Max,AtLeast)},{SetCD(ClickCD, 0)})
			CTrigger(FP, {TMemory(0x512684,Exactly,GCP)},print_utf8(12,0,ErrTxt) ,{preserved})
			CElseIfX({CV(GetPStatData,Cost-1,AtMost)},{SetCD(ClickCD, 0)})
			CTrigger(FP, {TMemory(0x512684,Exactly,GCP)},print_utf8(12,0,StrDesign("\x08ERROR \x04: 포인트가 부족합니다.")) ,{preserved})
			CIfXEnd()
		CIfEnd()
	end
	CIfX(FP,{CV(GetINumData,1)},{})
	
	
	StatBuyFunc("1",iv.Stat_BossSTic,Cost_Stat_BossSTic,1,10,StrDesign("\x08파티 보스 \x1FLV.5 \x04처치 보상 \x19판매권\x04이 증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x04처치 보상 \x19판매권\x04을 올릴 수 없습니다."))
	StatBuyFunc("2",iv.Stat_BossLVUP,Cost_Stat_BossLVUP,1,5,StrDesign("\x08파티 보스 \x1FLV.5 \x04처치 보상 \x1F레벨\x04이 증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x04처치 보상 \x1F레벨\x04을 올릴 수 없습니다."))
	StatBuyFunc("3",iv.Stat_Upgrade,Cost_Stat_Upgrade,1,50,StrDesign("\x07유닛 데미지\x04가 \x0810% \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상  \x07유닛 \x08데미지\x04를 올릴 수 없습니다."))
	StatBuyFunc("4",iv.Stat_TotalEPer,Cost_Stat_TotalEPer,100,10000,StrDesign("\x07+1강 \x08강화 확률\x04이 증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x07+1강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("5",iv.Stat_TotalEPer2,Cost_Stat_TotalEPer2,100,5000,StrDesign("\x07+2강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x07+2강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("6",iv.Stat_TotalEPer3,Cost_Stat_TotalEPer3,100,3000,StrDesign("\x07+3강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x10+3강 \x08강화확률\x04을 올릴 수 없습니다."))


	CElseIfX({CV(GetINumData,2)},{}) -- 2번 스탯페이지

	StatBuyFunc("1",iv.Stat_TotalEPer4,Cost_Stat_TotalEPer4,100,10000,StrDesign("\x08특수 강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x08특수 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("2",iv.Stat_BreakShield,Cost_Stat_BreakShield,100,30000,StrDesign("\x08특수 \x1F파괴 방지확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x1F피괴 \x08방지확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("3",iv.Stat_TotalEPerEx,Cost_Stat_TotalEPerEx,100,5000,StrDesign("\x07+1강 \x08강화 확률\x04이 \x0F0.1%p 증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x07+1강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("4",iv.Stat_TotalEPerEx2,Cost_Stat_TotalEPerEx2,100,2000,StrDesign("\x07+2강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x07+2강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("5",iv.Stat_TotalEPerEx3,Cost_Stat_TotalEPerEx3,100,1000,StrDesign("\x07+3강 강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x10+3강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("6",iv.Stat_LV3Incm,Cost_Stat_LV3Incm,1,100,StrDesign("\x11LV.MAX \x1B허수아비\x04 돈 수급량이 \x071%\x04 증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x11LV.MAX \x1B허수아비\x04 돈 수급량\x04을 올릴 수 없습니다."))

	CElseIfX({CV(GetINumData,3)},{}) -- 3번 스탯페이지

	StatBuyFunc("1",iv.Stat_TotalEPer4X,Cost_Stat_TotalEPer4X,100,5000,StrDesign("\x08특수 강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x08특수 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("2",iv.Stat_BreakShield2,Cost_Stat_BreakShield2,100,10000,StrDesign("\x08특수 \x1F파괴 방지확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x1F피괴 \x08방지확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("3",iv.Stat_XEPer44,Cost_Stat_XEPer44,100,5000,StrDesign("\x1F44강 \x08강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x1F44강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("4",iv.Stat_XEPer45,Cost_Stat_XEPer45,100,5000,StrDesign("\x1C45강 \x08강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x1C45강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("5",iv.Stat_XEPer46,Cost_Stat_XEPer46,100,5000,StrDesign("\x1E46강 \x08강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x1E46강 \x08강화확률\x04을 올릴 수 없습니다."))
	StatBuyFunc("6",iv.Stat_XEPer47,Cost_Stat_XEPer47,100,5000,StrDesign("\x0247강 \x08강화확률\x04이 \x0F0.1%p \x04증가하였습니다."),StrDesign("\x08ERROR \x04: 더 이상 \x0247강 \x08강화확률\x04을 올릴 수 없습니다."))
	CIfXEnd()

	CMovX(FP,VArrX(GetVArray(iv.StatP[1], 7), VArrI, VArrI4),GetPStatData,nil,nil,nil,1)


	SetCallEnd()


	Call_FCT = SetCallForward()
	SetCall(FP)
	GetData_FXPer44 = CreateVar(FP)
	GetData_FXPer45 = CreateVar(FP)
	GetData_FXPer46 = CreateVar(FP)
	GetData_FXPer47 = CreateVar(FP)
	GetData_FMEPer = CreateVar(FP)
	GetData_FIncm = CreateVar(FP)
	GetData_FSEXP = CreateVar(FP)
	GetData_FBrSh = CreateVar(FP)
	GetData_FBrSh = CreateVar(FP)
	GetData_FBrSh = CreateVar(FP)
	GetData_FXPer48 = CreateVar(FP)
	GetData_FMin = CreateVar(FP)
	DoActionsX(FP, {
		SetV(GetData_FXPer44,0),
		SetV(GetData_FXPer45,0),
		SetV(GetData_FXPer46,0),
		SetV(GetData_FXPer47,0),
		SetV(GetData_FMEPer,0),
		SetV(GetData_FIncm,0),
		SetV(GetData_FSEXP,0),
		SetV(GetData_FBrSh,0),
		SetV(GetData_FXPer48,0),
		SetV(GetData_FMin,0),
	})
	CMovX(FP,GetData_FXPer44,VArrX(GetVArray(iv.FXPer44[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FXPer45,VArrX(GetVArray(iv.FXPer45[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FXPer46,VArrX(GetVArray(iv.FXPer46[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FXPer47,VArrX(GetVArray(iv.FXPer47[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FMEPer,VArrX(GetVArray(iv.FMEPer[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FIncm,VArrX(GetVArray(iv.FIncm[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FSEXP,VArrX(GetVArray(iv.FSEXP[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FBrSh,VArrX(GetVArray(iv.FBrSh[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FXPer48,VArrX(GetVArray(iv.FXPer48[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetData_FMin,VArrX(GetVArray(iv.FMin[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FXPer44[3],GetData_FXPer44)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FXPer45[3],GetData_FXPer45)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FXPer46[3],GetData_FXPer46)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FXPer47[3],GetData_FXPer47)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FMEPer[3],GetData_FMEPer)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FIncm[3],GetData_FIncm)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FSEXP[3],GetData_FSEXP)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FBrSh[3],GetData_FBrSh)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FXPer48[3],GetData_FXPer48)),0})
	f_LAdd(FP,TempFfragTotal,TempFfragTotal,{_ReadF(FArr(Cost_FMin[3],GetData_FMin)),0})
	
	
	local TempW = CreateWar(FP)
	local TempW2 = CreateWar(FP)
	f_LMovX(FP, TempW, WArrX(GetWArray(iv.FfragItemUsed[1],7), WArrI, WArrI4), SetTo, nil, nil, 1)
	f_LMovX(FP, TempW2, WArrX(GetWArray(iv.FfragItem[1],7), WArrI, WArrI4), SetTo, nil, nil, 1)
	CTrigger(FP, {TTNWar(TempFfragTotal,NotSame,TempW)}, {SetCDX(iv.FStatTest,1,1)},1)
	CTrigger(FP, {TTNWar(TempFfragTotal,">",TempW2)}, {SetCDX(iv.FStatTest,2,2)},1)
	CTrigger(FP, {TTNWar(TempW,">",TempW2)}, {SetCDX(iv.FStatTest,4,4)},1)

	if Limit == 1 then
		CIf(FP,{CDX(iv.FStatTest,1,1)})
			DisplayPrint(GCP, {"\x13\x04TempFfragTotal : ",TempFfragTotal,"  FfragItemUsed : ",TempW})
		CIfEnd()
		CIf(FP,{CDX(iv.FStatTest,2,2)})
		DisplayPrint(GCP, {"\x13\x04TempFfragTotal : ",TempFfragTotal,"  FfragItem : ",TempW2})
		CIfEnd()
		CIf(FP,{CDX(iv.FStatTest,4,4)})
		DisplayPrint(GCP, {"\x13\x04FfragItemUsed : ",TempW,"  FfragItem : ",TempW2})
		CIfEnd()
	end
	TriggerX(FP,{CV(GetData_FXPer44,Cost_FXPer44[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FXPer45,Cost_FXPer45[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FXPer46,Cost_FXPer46[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FXPer47,Cost_FXPer47[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FMEPer,Cost_FMEPer[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FIncm,Cost_FIncm[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FSEXP,Cost_FSEXP[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FBrSh,Cost_FBrSh[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FXPer48,Cost_FXPer48[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	TriggerX(FP,{CV(GetData_FMin,Cost_FMin[2]+1,AtLeast)},{SetCDX(iv.FStatTest,8,8)},{preserved})
	SetCallEnd()

	



	Call_CPSound = SetCallForward()
	SoundOp = CreateVar(FP)
	SetCall(FP)
	local SW = CreateVar(FP)
	CMov(FP,SW,0)
	CWhile(FP, {CV(SW,6,AtMost)}, {})
	CIf(FP,{TDeathsX(SW,Exactly,1,3,1)})
		CMov(FP,0x6509B0,SW)
		TriggerX(FP, {CV(SoundOp,1)}, {PlayWAV("staredit\\wav\\Clear1.ogg")},{preserved})
		TriggerX(FP, {CV(SoundOp,2)}, {PlayWAV("staredit\\wav\\Clear2.ogg"),PlayWAV("staredit\\wav\\Clear2.ogg"),PlayWAV("staredit\\wav\\Clear2.ogg")},{preserved})
		TriggerX(FP, {CV(SoundOp,3)}, {PlayWAV("staredit\\wav\\Clear3.ogg")},{preserved})
	CIfEnd()
	CAdd(FP,SW,1)
	CWhileEnd()

	SetCallEnd()




	--[[
		32개 10회 320 / 10 = 32 >> 250 으로 변경
		322개 7회 2254 / 10 = 225 >> 550 으로 변경
		3222개 4회 12888 / 10 = 1288
		32222개 1회 32222 / 10 = 3222
		250
		550
		1288
		3222
		

		



		1+4
		4+10
		7+80
		10+990
		
		
		
		

	]]
	Ga_45 = {--기대치 2개
		{"\x17크레딧",3222222222,2,iv.B_PCredit},
		{"\x1E각성의 보석",1,10,iv.AwakItem},
		{"\x02무색 조각",10000,40,iv.B_PFfragItem},
		{"\x171000경원 수표",10,1000,iv.Money2},
		{"\x17크레딧",2000000,5000,iv.B_PCredit},
		{"\x1041강 유닛",10,20000,iv.E41},
		{"\x1140강 유닛",10,30000,iv.E40},
	}

	Ga_46 = {--기대치 7개
		{"\x17크레딧",3222222222,2,iv.B_PCredit},
		{"\x1E각성의 보석",1,40,iv.AwakItem},
		{"\x02무색 조각",40000,25,iv.B_PFfragItem},
		{"\x171000경원 수표",40,1000,iv.Money2},
		{"\x17크레딧",3000000,5000,iv.B_PCredit},
		{"\x1D42강 유닛",10,20000,iv.E42},
		{"\x1041강 유닛",10,30000,iv.E41},
	}

	Ga_47 = {--기대치 20개
		{"\x17크레딧",3222222222,2,iv.B_PCredit},
		{"\x1E각성의 보석",1,160,iv.AwakItem},
		{"\x02무색 조각",70000,110,iv.B_PFfragItem},
		{"\x171000경원 수표",70,2000,iv.Money2},
		{"\x17크레딧",4000000,5000,iv.B_PCredit},
		{"\x0643강 유닛",10,20000,iv.E43},
		{"\x1D42강 유닛",10,30000,iv.E42},
	}

	Ga_48 = {--기대치 50개
		{"\x17크레딧",3222222222,2,iv.B_PCredit},
		{"\x1E각성의 보석",1,500,iv.AwakItem},
		{"\x02무색 조각",100000,990,iv.B_PFfragItem},
		{"\x171000경원 수표",100,3000,iv.Money2},
		{"\x17크레딧",5000000,5000,iv.B_PCredit},
		{"\x1F44강 유닛",10,20000,iv.E44},
		{"\x0643강 유닛",10,30000,iv.E43},
	}

	GaArr = {Ga_45,Ga_46,Ga_47,Ga_48}

	pifrag = {1,4,7,10}
	pifrag2 = {
		"\x1C45강",
		"\x1E46강",
		"\x0247강",
		"\x1B48강"}



	Call_Gacha = SetCallForward()
	GaLv = CreateVar(FP)
	SetCall(FP)
	--local GetGPer = CreateVar(FP)
	--CMovX(FP,GetGPer,VArrX(GetVArray(iv.RandomSeed1[1], 7),VArrI,VArrI4))
	--f_Mod(FP,GetGPer,100000)
	--CAdd(FP,GetGPer,1)
	GetGPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
	if Limit == 1 then -- 테스트용 결과 출력
		CIf(FP,{KeyPress("F12", "Down")})
			CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayExtText(string.rep("\n", 10), 4)})
			for i = 45, 48 do
				TriggerX(FP, CV(GaLv,i), {DisplayExtText("\x08"..i.."강 유닛 뽑기 시도", 4)},{preserved})
			end
			DisplayPrint(ECP,{"\x04출력된 난수 : ",GetGPer})
		CIfEnd()
	end
CDoActions(FP,{TSetMemory(0x6509B0, SetTo, ECP)})
for i = 45, 48 do
	local TotalGPer = 1	
	local errt = "\n"
	CIf(FP,{CV(GaLv,i)})
	for j,k in pairs(GaArr[i-44]) do
		errt = errt..TotalGPer.."  "..k[3]-1+TotalGPer.."\n"
		CIf(FP,{VRange(GetGPer,TotalGPer,k[3]-1+TotalGPer)})
		CTrigger(FP, {}, {DisplayExtText(StrDesignX((k[3]/1000).." % \x04확률에 당첨되어 "..k[1].." "..Convert_Number(k[2]).." \x04개를 획득하였습니다."),4)}, 1)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {DisplayExtText(StrDesignX("\x03TESTMODE OP \x04: \x04당첨 난수 조건 범위 : "..TotalGPer.." ~ "..k[3]-1+TotalGPer), 4)})
			CIfEnd()
		end
		
		if j == 1 then
			DisplayPrint(AllPlayers, {"\x13\x04"..string.rep("=",50).."\n\n\x13\x07『 ",PName(ECP)," \x04님께서 "..pifrag2[i-44].." \x04유닛 \x17판매 뽑기\x04에서 \x07"..(k[3]/1000).." % \x04확률에 당첨되어 "..k[1].." "..Convert_Number(k[2]).." \x04개를 획득하였습니다! 축하드립니다! \x07』\n\n\x13\x04"..string.rep("=",50)})
			CallTrigger(FP, Call_CPSound, SetV(SoundOp,2))
		end
		if j == 2 then
			DisplayPrint(AllPlayers, {"\x13\x04"..string.rep("=",50).."\n\n\x13\x07『 ",PName(ECP)," \x04님께서 "..pifrag2[i-44].." \x04유닛 \x17판매 뽑기\x04에서 \x07"..(k[3]/1000).." % \x04확률에 당첨되어 "..k[1].." "..Convert_Number(k[2]).." \x04개를 획득하였습니다! 축하드립니다! \x07』\n\n\x13\x04"..string.rep("=",50)})
			CallTrigger(FP, Call_CPSound, SetV(SoundOp,3))
		end
		if j == 3 then
			DisplayPrint(AllPlayers, {"\x13\x04"..string.rep("=",50).."\n\n\x13\x07『 ",PName(ECP)," \x04님께서 "..pifrag2[i-44].." \x04유닛 \x17판매 뽑기\x04에서 \x07"..(k[3]/1000).." % \x04확률에 당첨되어 "..k[1].." "..Convert_Number(k[2]).." \x04개를 획득하였습니다! 축하드립니다! \x07』\n\n\x13\x04"..string.rep("=",50)})
			CallTrigger(FP, Call_CPSound, SetV(SoundOp,1))
		end
		CMovX(FP,VArrX(GetVArray(k[4][1], 7), VArrI, VArrI4),k[2],Add)
		CIfEnd()
		TotalGPer = TotalGPer+k[3]
		
	end
	CDoActions(FP,{TSetMemory(0x6509B0, SetTo, ECP)})
	CTrigger(FP, {VRange(GetGPer,TotalGPer,100000)}, {DisplayExtText(StrDesignX((((100000+1)-TotalGPer)/1000).." % \x04확률로 \x08꽝\x04에 걸리셨습니다...."),4)}, 1)
	if Limit == 1 then
		CIf(FP,{VRange(GetGPer,TotalGPer,100000),KeyPress("F12", "Down")})
			CDoActions(FP, {DisplayExtText(StrDesignX("\x03TESTMODE OP \x04: \x04당첨 난수 조건 범위 : "..TotalGPer.." ~ 100000"), 4)})
		CIfEnd()
	end
	errt = errt..(TotalGPer).."  100000\n" -- 꽝일경우
	--error(errt)
	DoActionsX(FP,{DisplayExtText(StrDesignX(pifrag2[i-44].." \x04유닛 판매 보상 : \x02무색 조각 \x07"..pifrag[i-44].." 개"), 4)})

	CMovX(FP,VArrX(GetVArray(iv.B_PFfragItem[1], 7), VArrI, VArrI4),pifrag[i-44],Add)
	CIfEnd()

end

--CallTrigger(FP, Call_RSSort)
CDoActions(FP,{TSetMemory(0x6509B0, SetTo, FP)})


	SetCallEnd()
	Call_DailyPrint = SetCallForward()
	SetCall(FP)
	DV = CreateVar(FP)
	DisplayPrint(GCP, {"\x13\x07『 \x04현재까지 시즌 2 출석 이벤트 출석일수 : \x07",DV,"일 \x07』"})
	SetCallEnd()
	Call_DailyPrint2 = SetCallForward()
	SetCall(FP)
	DV2 = CreateVar(FP)
	DisplayPrint(GCP, {"\x13\x07『 \x04현재까지 시즌 3 출석 이벤트 출석일수 : \x07",DV2,"일 \x07』"})
	SetCallEnd()

	CurBossReward = CreateVar(FP)
	Call_BossReward = SetCallForward()
	SetCall(FP)
	local VATmp_Stat_BossLVUP = CreateVar(FP)
	local VATmp_PLevel = CreateVar(FP)
	local VATmp_Stat_BossSTic = CreateVar(FP)
	local TempSTicV = CreateVar(FP)
	CMovX(FP,VATmp_Stat_BossLVUP,VArrX(GetVArray(iv.Stat_BossLVUP[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,VATmp_PLevel,VArrX(GetVArray(iv.PLevel[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,VATmp_Stat_BossSTic,VArrX(GetVArray(iv.Stat_BossSTic[1], 7), VArrI, VArrI4),nil,nil,nil,1)


	CIf(FP,{CV(VATmp_Stat_BossLVUP,1,AtLeast)})
	f_LMov(FP, TempWX, "0", nil, nil, 1)
	CMov(FP,StartLV,VATmp_PLevel)
	CAdd(FP,EndLV,VATmp_PLevel,_Mul(VATmp_Stat_BossLVUP,_Mul(CurBossReward,_Mov(50))))
	

	CallTrigger(FP, Call_GetLevelEXP)

	CIf(FP, {TTNWar(TempWX, AtLeast, _LMul({VATmp_Stat_BossLVUP,0}, _LMul("1000000000",{CurBossReward,0})))})
	f_LMov(FP, TempWX, _LMul({VATmp_Stat_BossLVUP,0}, _LMul("1000000000",{CurBossReward,0})))
	CIfEnd()

	f_LMovX(FP, WArrX(GetWArray(iv.PEXP[1], 7), WArrI, WArrI4), TempWX, Add)
	DisplayPrint(GCP, {"\x13\x07『 \x08보스 \x04처치시 \x1F레벨업 능력치 ",VATmp_Stat_BossLVUP,"업\x04 으로 얻은 경험치 : \x1C",TempWX," \x07』"})
	CIfEnd()

	CIf(FP,{CV(VATmp_Stat_BossSTic,1,AtLeast)})
	


	CMovX(FP, VArrX(GetVArray(iv.B_PTicket[1], 7), VArrI, VArrI4), _Mul(VATmp_Stat_BossSTic,_Mul(CurBossReward,_Mov(100))), Add)

	f_Mul(FP,TempSTicV,VATmp_Stat_BossSTic,_Mul(CurBossReward,_Mov(100)))
	DisplayPrint(GCP, {"\x13\x07『 \x08보스 \x04처치시 \x19유닛 판매권 ",VATmp_Stat_BossSTic,"업\x04 스탯으로 얻은 유닛 판매권 : \x19",TempSTicV," 개 \x07』"})
	CIfEnd()
	
	--if TestStart == 1 then
	--		TriggerX(FP,{},{AddV(LV5Cool[i+1],60)},{preserved})
	--else
	--		TriggerX(FP,{},{AddV(LV5Cool[i+1],60*60*1)},{preserved})
	--end

	SetCallEnd()
	Call_AutoBuy = SetCallForward()
	SetCall(FP)
	BuyError = CreateCcode()
	GetAutoBuyCode = CreateVar(FP)
	GetAutoBuyCode2 = CreateVar(FP)
	GetMoney2 = CreateVar(FP)
	GetMoney = CreateWar(FP)
	GetBuyTicket = CreateVar(FP)
	CMovX(FP,GetBuyTicket,VArrX(GetVArray(iv.BuyTicket[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetAutoBuyCode,VArrX(GetVArray(iv.AutoBuyCode[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetAutoBuyCode2,VArrX(GetVArray(iv.AutoBuyCode2[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetMoney2,VArrX(GetVArray(iv.Money2[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	f_LMovX(FP, GetMoney, WArrX(GetWArray(iv.Money[1], 7), WArrI, WArrI4),nil,nil,nil,1)
	for j, k in pairs(AutoBuyArr) do
		AutoBuyG(GCP,k[1],k[2])
		AutoBuyG2(GCP,k[1],k[2])
	end

	CIf(FP,{CD(BuyError,1)})
	f_Read(FP,FArr(PLocPos,GCP),CPosX,nil,nil,1)
	CMov(FP,CLocL,CPosX,32+64)
	CMov(FP,CLocR,CPosX,32+64+64)
	Simple_SetLocX(FP, 86, CLocL, 32, CLocR, 96)
	CDoActions(FP, {RemoveUnitAt(All, "Any unit", 87, FP)})
	CTrigger(FP,{},{SetCD(BuyError,0),TSetMemory(0x6509B0,SetTo,GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x08구입 티켓\x04이 부족하여 유료 자판기의 작동이 중지되었습니다."), 4)},{preserved})
	
	CIfEnd()


	
	CMovX(FP,VArrX(GetVArray(iv.BuyTicket[1], 7), VArrI, VArrI4),GetBuyTicket,nil,nil,nil,1)
	CMovX(FP,VArrX(GetVArray(iv.AutoBuyCode[1], 7), VArrI, VArrI4),GetAutoBuyCode,nil,nil,nil,1)
	CMovX(FP,VArrX(GetVArray(iv.AutoBuyCode2[1], 7), VArrI, VArrI4),GetAutoBuyCode2,nil,nil,nil,1)
	CMovX(FP,VArrX(GetVArray(iv.Money2[1], 7), VArrI, VArrI4),GetMoney2,nil,nil,nil,1)
	f_LMovX(FP, WArrX(GetWArray(iv.Money[1], 7), WArrI, WArrI4),GetMoney,nil,nil,nil,1)
	SetCallEnd()

	

	GetXEper44 = CreateVar(FP)
	GetXEper45 = CreateVar(FP)
	GetXEper46 = CreateVar(FP)
	GetXEper47 = CreateVar(FP)
	GetXEper48 = CreateVar(FP)
	local UID = CreateVar(FP)
	local Per = CreateVar(FP)
	local VI = CreateVar(FP)
	local VI4 = CreateVar(FP)
	local GetSellTicket = CreateWar(FP)
	local TempEXPW = iv.TempEXPW--CreateVar(FP)
	local GetLevel = CreateVar(FP)
	local EXP = CreateVar(FP)



	Call_EnchFunc = SetCallForward()
	SetCall(FP)
	local CI = CFor(FP,0,#LevelUnitArr,1)
	ConvertVArr(FP, VI, VI4, CI, #LevelUnitArr)
	CMovX(FP,UID,VArrX(LevelDataArr,VI,VI4),nil,nil,nil,1)
	CMovX(FP,UEper,VArrX(PerDataArr,VI,VI4),nil,nil,nil,1)
	CMovX(FP,UEper2,VArrX(PerDataArr2,VI,VI4),nil,nil,nil,1)
	CMovX(FP,UEper3,VArrX(PerDataArr3,VI,VI4),nil,nil,nil,1)


	CMov(FP,ELevelB,CI)
	
	CIf(FP,VRange(CI, 0, 38))
	if Limit == 1 then
		if CreatorCheatMode == 1 then
			CIf(FP,{TBring(GCP,AtLeast,1,UID,_Add(GCP,8))})
			CIfX(FP, {TBring(GCP,AtLeast,10,UID,_Add(GCP,8))},{TKillUnitAt(10, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,10)})
			CElseIfX({TBring(GCP,AtLeast,9,UID,_Add(GCP,8))},{TKillUnitAt(9, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,9)})
			CElseIfX({TBring(GCP,AtLeast,8,UID,_Add(GCP,8))},{TKillUnitAt(8, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,8)})
			CElseIfX({TBring(GCP,AtLeast,7,UID,_Add(GCP,8))},{TKillUnitAt(7, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,7)})
			CElseIfX({TBring(GCP,AtLeast,6,UID,_Add(GCP,8))},{TKillUnitAt(6, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,6)})
			CElseIfX({TBring(GCP,AtLeast,5,UID,_Add(GCP,8))},{TKillUnitAt(5, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,5)})
			CElseIfX({TBring(GCP,AtLeast,4,UID,_Add(GCP,8))},{TKillUnitAt(4, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,4)})
			CElseIfX({TBring(GCP,AtLeast,3,UID,_Add(GCP,8))},{TKillUnitAt(3, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,3)})
			CElseIfX({TBring(GCP,AtLeast,2,UID,_Add(GCP,8))},{TKillUnitAt(2, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,2)})
			CElseX({TKillUnitAt(1, UID, _Add(GCP,8), GCP),})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,1)})
			CIfXEnd()
			CIfEnd()
		else
			CIf(FP,{TBring(GCP,AtLeast,1,UID,_Add(GCP,8))})
			CIfX(FP,{TBring(GCP,AtLeast,2,UID,_Add(GCP,8))},{TKillUnitAt(2, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,2)})
			CElseX({TKillUnitAt(1, UID, _Add(GCP,8), GCP),})
			CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,1)})
			CIfXEnd()
			CIfEnd()
		end
		else
		CIf(FP,{TBring(GCP,AtLeast,1,UID,_Add(GCP,8))})
		CIfX(FP,{TBring(GCP,AtLeast,2,UID,_Add(GCP,8))},{TKillUnitAt(2, UID, _Add(GCP,8), GCP)})
		CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,2)})
		CElseX({TKillUnitAt(1, UID, _Add(GCP,8), GCP),})
		CallTriggerX(FP, Call_Enchant, {}, {SetV(ECW,1)})
		CIfXEnd()
		CIfEnd()
	end
	CIfEnd()
	CIf(FP,VRange(CI, 39, 42))
		CSub(FP,XEper,GEper4,UEper)
		CIf(FP,{TBring(GCP,AtLeast,1,UID,_Add(GCP,8))})
		if Limit== 1 then
			if CreatorCheatMode == 1 then
				CIfX(FP,{CV(XEper,1,AtLeast)})
				CIfX(FP, {TBring(GCP,AtLeast,20,UID,_Add(GCP,8))},{TKillUnitAt(20, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,20)})
				CElseIfX({TBring(GCP,AtLeast,19,UID,_Add(GCP,8))},{TKillUnitAt(19, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,19)})
				CElseIfX({TBring(GCP,AtLeast,18,UID,_Add(GCP,8))},{TKillUnitAt(18, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,18)})
				CElseIfX({TBring(GCP,AtLeast,17,UID,_Add(GCP,8))},{TKillUnitAt(17, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,17)})
				CElseIfX({TBring(GCP,AtLeast,16,UID,_Add(GCP,8))},{TKillUnitAt(16, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,16)})
				CElseIfX({TBring(GCP,AtLeast,15,UID,_Add(GCP,8))},{TKillUnitAt(15, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,15)})
				CElseIfX({TBring(GCP,AtLeast,14,UID,_Add(GCP,8))},{TKillUnitAt(14, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,14)})
				CElseIfX({TBring(GCP,AtLeast,13,UID,_Add(GCP,8))},{TKillUnitAt(13, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,13)})
				CElseIfX({TBring(GCP,AtLeast,12,UID,_Add(GCP,8))},{TKillUnitAt(12, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,12)})
				CElseIfX({TBring(GCP,AtLeast,11,UID,_Add(GCP,8))},{TKillUnitAt(11, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,11)})
				CElseIfX({TBring(GCP,AtLeast,10,UID,_Add(GCP,8))},{TKillUnitAt(10, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,10)})
				CElseIfX({TBring(GCP,AtLeast,9,UID,_Add(GCP,8))},{TKillUnitAt(9, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,9)})
				CElseIfX({TBring(GCP,AtLeast,8,UID,_Add(GCP,8))},{TKillUnitAt(8, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,8)})
				CElseIfX({TBring(GCP,AtLeast,7,UID,_Add(GCP,8))},{TKillUnitAt(7, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,7)})
				CElseIfX({TBring(GCP,AtLeast,6,UID,_Add(GCP,8))},{TKillUnitAt(6, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,6)})
				CElseIfX({TBring(GCP,AtLeast,5,UID,_Add(GCP,8))},{TKillUnitAt(5, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,5)})
				CElseIfX({TBring(GCP,AtLeast,4,UID,_Add(GCP,8))},{TKillUnitAt(4, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,4)})
				CElseIfX({TBring(GCP,AtLeast,3,UID,_Add(GCP,8))},{TKillUnitAt(3, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,3)})
				CElseIfX({TBring(GCP,AtLeast,2,UID,_Add(GCP,8))},{TKillUnitAt(2, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,2)})
				CElseX({TKillUnitAt(1, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,1)})
				CIfXEnd()
				CElseX({TMoveUnit(All,UID,GCP,_Add(GCP,8),_Add(GCP,36)),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 확률이 부족하여 강화할 수 없습니다..."), 4),SetCp(FP)})
				CMov(FP,ArrX(AutoEnchArr, _Add(_Mul(CI,_Mov(7)),GCP)),0,nil,nil,1)
				CIfXEnd()
			else
				CIfX(FP,{CV(XEper,1,AtLeast)})
				CIfX(FP, {TBring(GCP,AtLeast,2,UID,_Add(GCP,8))},{TKillUnitAt(2, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,2)})
				CElseX({TKillUnitAt(1, UID, _Add(GCP,8), GCP)})
				CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,1)})
				CIfXEnd()
				CElseX({TMoveUnit(All,UID,GCP,_Add(GCP,8),_Add(GCP,36)),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 확률이 부족하여 강화할 수 없습니다..."), 4),SetCp(FP)})
				CMov(FP,ArrX(AutoEnchArr, _Add(_Mul(CI,_Mov(7)),GCP)),0,nil,nil,1)
				CIfXEnd()
			end
			
		else
			CIfX(FP,{CV(XEper,1,AtLeast)})
			CIfX(FP, {TBring(GCP,AtLeast,2,UID,_Add(GCP,8))},{TKillUnitAt(2, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,2)})
			CElseX({TKillUnitAt(1, UID, _Add(GCP,8), GCP)})
			CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,1)})
			CIfXEnd()
			CElseX({TMoveUnit(All,UID,GCP,_Add(GCP,8),_Add(GCP,36)),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 확률이 부족하여 강화할 수 없습니다..."), 4),SetCp(FP)})
			CMov(FP,ArrX(AutoEnchArr, _Add(_Mul(CI,_Mov(7)),GCP)),0,nil,nil,1)
			CIfXEnd()
		end
		CIfEnd()

	CIfEnd()


	CIf(FP,VRange(CI, 43, 48))

	CIf(FP,{TBring(GCP,AtLeast,1,UID,_Add(GCP,8))})
	CTrigger(FP, CV(CI,43), {SetV(XEper,_Add(GetXEper44,UEper))},1)
	CTrigger(FP, CV(CI,44), {SetV(XEper,_Add(GetXEper45,UEper))},1)
	CTrigger(FP, CV(CI,45), {SetV(XEper,_Add(GetXEper46,UEper))},1)
	CTrigger(FP, CV(CI,46), {SetV(XEper,_Add(GetXEper47,UEper))},1)
	CTrigger(FP, CV(CI,47), {SetV(XEper,_Add(GetXEper48,UEper))},1)
	CTrigger(FP, CV(CI,48), {SetV(XEper,UEper)},1)
	CIf(FP,{VRange(CI, 43, 47)})
	CiSub(FP,XEper,iv.XEPerM)
	TriggerX(FP,CV(XEper,0x80000000,AtLeast),{SetV(XEper,0)},{preserved})--마이너스일경우 0
	CIfEnd()

	CIfX(FP,{CV(XEper,1,AtLeast)})
		CIfX(FP,{TBring(GCP,AtLeast,2,UID,_Add(GCP,8))},{TKillUnitAt(2, UID, _Add(GCP,8), GCP)})
		CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,2)})
		CElseX({TKillUnitAt(1, UID, _Add(GCP,8), GCP)})
		CallTriggerX(FP, Call_Enchant2, {}, {SetV(ECW,1)})
		CIfXEnd()
	CElseX({TMoveUnit(All,UID,GCP,_Add(GCP,8),_Add(GCP,36)),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 확률이 부족하여 강화할 수 없습니다..."), 4),SetCp(FP)})
	CMov(FP,ArrX(AutoEnchArr, _Add(_Mul(CI,_Mov(7)),GCP)),0,nil,nil,1)
	CIfXEnd()
	CIfEnd()
	CIfEnd()
	CForEnd()

	SetCallEnd()
	Call_SellFunc = SetCallForward()
	SetCall(FP)
	CJ = CreateVar(FP)
	CMov(FP,CJ,GCP)
	f_LMovX(FP, GetSellTicket, WArrX(GetWArray(iv.SellTicket[1], 7), WArrI, WArrI4),nil,nil,nil,1)
	CMovX(FP,GetLevel,VArrX(GetVArray(iv.PLevel[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	f_LMov(FP,TempEXPW,"0",nil,nil,1)
	local CI = CFor(FP,0,#LevelUnitArr,1)
	ConvertVArr(FP, VI, VI4, CI, #LevelUnitArr)
	CMovX(FP,UID,VArrX(LevelDataArr,VI,VI4),nil,nil,nil,1)
	CMov(FP,ELevelB,CI)
	CMovX(FP,EXP,VArrX(ExpDataArr,VI,VI4),nil,nil,nil,1)

	CIf(FP,{TBring(GCP,AtLeast,1,UID,_Add(GCP,73))})
		CIfX(FP,{CV(EXP,1,AtLeast)})
			CIfX(FP,{CV(GetLevel,LevelLimit,AtLeast)},{TMoveUnit(All,UID,GCP,GCP+73,GCP+36),TSetMemory(_TMem(Arr(AutoSellArr,CJ)), SetTo, 0),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 이미 만렙을 달성하여 판매할 수 없습니다..."), 4),SetCp(FP)})
			CElseX()
				CIfX(FP, {VRange(CI,14,24)},{TKillUnitAt(1, UID, GCP+73, GCP)})--판매권이필요없어요
					f_LAdd(FP, TempEXPW,TempEXPW, {EXP,0})
					CTrigger(FP, {CV(CI,14)}, {SetVX(GetMissionData,32,32)},1)
				CElseX()--판매권이필요행
					CIfX(FP, {TTNWar(GetSellTicket,AtMost,"0")}, {TMoveUnit(All,UID,GCP,GCP+73,GCP+36),TSetMemory(_TMem(Arr(AutoSellArr,CJ)), SetTo, 0),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x19유닛 판매권\x04이 부족합니다... \x07L 키\x04로 보유갯수를 확인해주세요."), 4),SetCp(FP)})
					CElseX({TKillUnitAt(1, UID, GCP+73, GCP)})
					f_LSub(FP, GetSellTicket, GetSellTicket, "1")
					f_LAdd(FP, TempEXPW,TempEXPW, {EXP,0})
					CIfXEnd()
				CIfXEnd()
			CIfXEnd()
		CElseIfX(VRange(CI,44, 47))
			CIfX(FP, {TTNWar(GetSellTicket,AtMost,"9999")},{TMoveUnit(All,UID,GCP,GCP+73,GCP+36),TSetMemory(_TMem(Arr(AutoSellArr,CJ)), SetTo, 0),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: \x19유닛 판매권\x04이 부족합니다... \x07L 키\x04로 보유갯수를 확인해주세요."), 4),SetCp(FP)})
			CElseX({TKillUnitAt(1, UID, GCP+73, GCP)})
			f_LSub(FP, GetSellTicket, GetSellTicket, "10000")
			CIf(FP, {CV(CI,44)},{})
			CMovX(FP,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4),4096,SetTo,nil,4096,1)
			CMovX(FP,VArrX(GetVArray(iv.S45[1], 7),VArrI,VArrI4),1,Add)
			CIfEnd()
			CIf(FP, {CV(CI,45)})
			CMovX(FP,VArrX(GetVArray(iv.S46[1], 7),VArrI,VArrI4),1,Add)
			CIfEnd()
			CIf(FP, {CV(CI,46)})
			CMovX(FP,VArrX(GetVArray(iv.S47[1], 7),VArrI,VArrI4),1,Add)
			CIfEnd()
			CIf(FP, {CV(CI,47)})
			CMovX(FP,VArrX(GetVArray(iv.S48[1], 7),VArrI,VArrI4),1,Add)
			CIfEnd()
			CMov(FP,ECP,GCP)
			CMov(FP,GaLv,CI,1)
			CallTrigger(FP, Call_Gacha)
			CIfXEnd()
		CElseX({TMoveUnit(All,UID,GCP,GCP+73,GCP+36),TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x08ERROR \x04: 해당 유닛은 판매할 수 없습니다..."), 4),SetCp(FP)})
		CIfXEnd()
	CIfEnd()
	CAdd(FP,CJ,7)
	CForEnd()

	

	f_LMovX(FP,WArrX(GetWArray(iv.SellTicket[1], 7), WArrI, WArrI4),GetSellTicket,SetTo,nil,nil,1)

	SetCallEnd()




	

	Call_Shop = SetCallForward()
	local GetMulOp = CreateVar(FP)
	local GetOldTicket = CreateVar(FP)
	local LMulOP = CreateWar(FP)
	SetCall(FP)
	f_LMov(FP,GetCreditData,"0",nil,nil,1)--크레딧 복사버그 방지용 초기화...?
	CMovX(FP,GetMissionData,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4),nil,nil,nil,1)
	CMovX(FP,GetVAccData,VArrX(GetVArray(iv.VaccItem[1], 7),VArrI,VArrI4),nil,nil,nil,1)
	CMovX(FP,GetAwakItemData,VArrX(GetVArray(iv.AwakItem[1], 7),VArrI,VArrI4),nil,nil,nil,1)
	CMovX(FP,GetMulOp,VArrX(GetVArray(iv.MulOp[1], 7),VArrI,VArrI4),nil,nil,nil,1)
	f_LMov(FP,LMulOP,{GetMulOp,0})
	f_LMovX(FP, GetCreditData, WArrX(GetWArray(iv.Credit[1], 7), WArrI, WArrI4),nil,nil,nil,1)
	f_LMovX(FP, GetSellTicket, WArrX(GetWArray(iv.SellTicket[1], 7), WArrI, WArrI4),nil,nil,nil,1)
	CMovX(FP,GetBuyTicket,VArrX(GetVArray(iv.BuyTicket[1], 7), VArrI, VArrI4),nil,nil,nil,1)
	CMovX(FP,GetPETicket,VArrX(GetVArray(iv.PETicket2[1], 7),VArrI,VArrI4),nil,nil,nil,1)
	CMovX(FP,GetOldTicket,VArrX(GetVArray(iv.PETicket[1], 7),VArrI,VArrI4),nil,nil,nil,1)


	
CIf(FP,{TBring(GCP,AtLeast,1,15,127)},{TMoveUnit(1, 15, GCP, 127, 116)})

CIfX(FP,{TTNWar(GetCreditData, AtLeast,_LMul({GetMulOp,0}, "100"))},{})
	f_LAdd(FP, GetSellTicket, GetSellTicket, {GetMulOp,0})
	f_LSub(FP, GetCreditData, GetCreditData, _LMul({GetMulOp,0}, "100"))
	CMov(FP,GetMissionData,4,nil,4)
	local TempW = CreateWar(FP)
	f_LMul(FP,TempW,{GetMulOp,0}, "100")
	DisplayPrint(GCP, {"\x13\x07『 \x19유닛 판매권\x04을 ",GetMulOp,"개 구입하였습니다. ",TempW," \x17크레딧 \x08사용 \x07』"})
	DisplayPrint(GCP, {"\x13\x07『 \x04현재 ",GetSellTicket," 개의 \x19유닛 판매권 보유중 \x07』\n"..StrDesignX("\x03참고 \x04: \x19유닛 판매권\x04은 SCA로 저장할 수 있습니다!")})
CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
CIfXEnd()
CIfEnd()

CIf(FP,{TBring(GCP,AtLeast,1,15,126)},{TMoveUnit(1, 15, GCP, 126, 116)})

CIfX(FP,{TTNWar(GetSellTicket,AtLeast,LMulOP)},{})
	
	CMov(FP,GetMissionData,64,nil,64)

	f_LSub(FP, GetSellTicket, GetSellTicket, {GetMulOp,0})
	
	f_LAdd(FP, GetCreditData, GetCreditData, _LMul({GetMulOp,0}, "75"))

	local TempW = CreateWar(FP)
	f_LMul(FP,TempW,{GetMulOp,0}, "75")
	DisplayPrint(GCP, {"\x13\x07『 \x19유닛 판매권\x04을 ",GetMulOp,"개 판매하였습니다. ",TempW," \x17크레딧 \x07반환 \x07』"})
	DisplayPrint(GCP, {"\x13\x07『 \x04현재 ",GetSellTicket," 개의 \x19유닛 판매권 보유중 \x07』"})
	
CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesign("\x08ERROR \x04: \x19유닛 판매권\x04이 부족합니다."), 4),SetCp(FP)})
CIfXEnd()
CIfEnd()

CIf(FP,{TBring(GCP,AtLeast,1,15,114)},{TMoveUnit(1, 15, GCP, 114, 116)})

CIfX(FP,{TTNWar(GetCreditData, AtLeast,_LMul({GetMulOp,0}, "100000"))},{})
	
	CMov(FP,GetMissionData,256,nil,256)
	CAdd(FP,GetVAccData,GetMulOp)
	f_LSub(FP, GetCreditData, GetCreditData, _LMul({GetMulOp,0}, "100000"))
	local TempW = CreateWar(FP)
	f_LMul(FP,TempW,{GetMulOp,0}, "100000")
	DisplayPrint(GCP, {"\x13\x07『 \x10강화기 백신\x04을 ",GetMulOp,"개 구입하였습니다. ",TempW," \x17크레딧 \x08사용 \x07』"})
	DisplayPrint(GCP, {"\x13\x07『 \x04현재 ",GetVAccData," 개의 \x10강화기 백신 보유중 \x07』\n"..StrDesignX("\x03참고 \x04: \x10강화기 백신\x04은 SCA로 저장할 수 있습니다!")})

CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesign("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
CIfXEnd()
CIfEnd()


CIf(FP,{TBring(GCP,AtLeast,1,15,113)},{TMoveUnit(1, 15, GCP, 113, 116)})

CIfX(FP,{CV(GetVAccData,GetMulOp,AtLeast)},{})
	
	CSub(FP,GetVAccData,GetMulOp)
	f_LAdd(FP, GetCreditData, GetCreditData, _LMul({GetMulOp,0}, "100000"))
	CMov(FP,GetMissionData,1024,nil,1024)
	for i = 0, 6 do
		CTrigger(FP, {CV(GCP,i)}, {AddCD(VaccSCount[i+1],GetMulOp)},1)
	end
	local TempV = CreateVar(FP)
	f_Cast(FP,{TempV,0},_LMul({GetMulOp,0}, "100000"),nil,nil,1)
	DisplayPrint(GCP, {"\x13\x07『 \x10강화기 백신\x04을 ",GetMulOp,"개 판매하였습니다. ",TempV," \x17크레딧 \x07반환 \x07』"})
	DisplayPrint(GCP, {"\x13\x07『 \x04현재 ",GetVAccData," 개의 \x10강화기 백신 보유중 \x07』"})
CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesign("\x08ERROR \x04: \x10강화기 백신\x04이 부족합니다."), 4),SetCp(FP)})
CIfXEnd()
CIfEnd()

CIf(FP,{TBring(GCP,AtLeast,1,15,167)},{TMoveUnit(1, 15, GCP, 167, 168)})

CIfX(FP,{CV(GetOldTicket,GetMulOp,AtLeast)},{})
	
	CSub(FP,GetOldTicket,GetMulOp)
	CMovX(FP,VArrX(GetVArray(iv.B_PFfragItem[1], 7), VArrI, VArrI4),_Mul(GetMulOp,_Mov(25)),Add)
	CMov(FP,GetMissionData,2048,nil,2048)
	local TempV = CreateVar(FP)
	CMov(FP,TempV,_Mul(GetMulOp,_Mov(25)))
	DisplayPrint(GCP, {"\x13\x07『 \x02구 확정 강화권\x04을 ",GetMulOp,"개 사용하여 ",TempV," \x02무색 조각\x04으로 \x07변환 \x04하였습니다. \x07』"})
	DisplayPrint(GCP, {"\x13\x07『 \x04현재 ",GetOldTicket," 개의 \x1F확정 강화권 보유중 \x07』"})
CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesign("\x08ERROR \x04: \x02구 확정 강화권\x04이 부족합니다."), 4),SetCp(FP)})
CIfXEnd()
CIfEnd()
CIf(FP,{TBring(GCP,AtLeast,1,15,169)},{TMoveUnit(1, 15, GCP, 169, 168)})

CIfX(FP,{CV(GetOldTicket,GetMulOp,AtLeast)},{})
	CSub(FP,GetOldTicket,GetMulOp)
	CAdd(FP,GetPETicket,GetMulOp)
	local TempV = CreateVar(FP)
	CMov(FP,TempV,GetMulOp)
	DisplayPrint(GCP, {"\x13\x07『 \x02구 확정 강화권\x04을 ",GetMulOp,"개 사용하여 ",TempV," \x1F신 확정 강화권\x04으로 \x07변환 \x04하였습니다. \x07』"})
	DisplayPrint(GCP, {"\x13\x07『 \x04현재 ",GetOldTicket," 개의 \x02구 확정 강화권 \x04보유중 \x07』"})
CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesign("\x08ERROR \x04: \x02구 확정 강화권\x04이 부족합니다."), 4),SetCp(FP)})
CIfXEnd()
CIfEnd()
CIf(FP,{TBring(GCP,AtLeast,1,15,177)},{TMoveUnit(1, 15, GCP, 177, 168)})

CIfX(FP,{CV(GetPETicket,GetMulOp,AtLeast)},{})
	
	CSub(FP,GetPETicket,GetMulOp)
	CAdd(FP,GetBuyTicket,_Mul(GetMulOp,50000))
	local TempV = CreateVar(FP)
	CMov(FP,TempV,GetMulOp)
	DisplayPrint(GCP, {"\x13\x07『 \x1F신 확정 강화권\x04을 ",GetMulOp,"개 사용하여 ",TempV," \x08구입 티켓\x04으로 \x07변환 \x04하였습니다. \x07』"})
	DisplayPrint(GCP, {"\x13\x07『 \x04현재 ",GetBuyTicket," 개의 \x08구입 티켓 \x04보유중 \x07』\n"..StrDesignX("\x08주의 \x04: \x08구입 티켓\x04은 SCA로 저장할 수 없습니다!")})
CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesign("\x08ERROR \x04: \x1F신 확정 강화권\x04이 부족합니다."), 4),SetCp(FP)})
CIfXEnd()
CIfEnd()

CMovX(FP,VArrX(GetVArray(iv.BuyTicket[1], 7), VArrI, VArrI4),GetBuyTicket,SetTo,nil,nil,1)
CMovX(FP,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4),GetMissionData,SetTo,nil,nil,1)
CMovX(FP,VArrX(GetVArray(iv.VaccItem[1], 7),VArrI,VArrI4),GetVAccData,SetTo,nil,nil,1)
CMovX(FP,VArrX(GetVArray(iv.AwakItem[1], 7),VArrI,VArrI4),GetAwakItemData,SetTo,nil,nil,1)
f_LMovX(FP,WArrX(GetWArray(iv.SellTicket[1], 7), WArrI, WArrI4),GetSellTicket,SetTo,nil,nil,1)
CMovX(FP,VArrX(GetVArray(iv.MulOp[1], 7),VArrI,VArrI4),GetMulOp,SetTo,nil,nil,1)
CMovX(FP,VArrX(GetVArray(iv.PETicket2[1], 7),VArrI,VArrI4),GetPETicket,SetTo,nil,nil,1)
CMovX(FP,VArrX(GetVArray(iv.PETicket[1], 7),VArrI,VArrI4),GetOldTicket,SetTo,nil,nil,1)
f_LMovX(FP,WArrX(GetWArray(iv.Credit[1], 7), WArrI, WArrI4),GetCreditData,SetTo,nil,nil,1)



CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
	SetCallEnd()

	GetCreateUnit = CreateVar(FP)
	UIDV = CreateVar(FP)
	CIV = CreateVar(FP)
	Call_GetUnit = SetCallForward()
	SetCall(FP)
	
	NIfX(FP,{TDeathsX(GCP,Exactly,2,3,2),TMemory(_TMem(Arr(AutoSellArr,CJ)), Exactly, 0),TMemory(_TMem(Arr(AutoEnchArr,CJ)), Exactly, 1)})
		CMov(FP,ECP,GCP)
		CMov(FP,ELevelB,CIV)
		CMov(FP,ECW,GetCreateUnit)
		NIfX(FP,{CV(CIV,38,AtMost)})

			CallTrigger(FP, Call_Enchant)
		NElseX()
		AutoEnchJump = def_sIndex()

			CIfX(FP,{VRange(CIV, 39, 42)})
			CSub(FP,XEper,GEper4,UEper)
			CElseX()
			CTrigger(FP, CV(CIV,43), {SetV(XEper,_Add(GetXEper44,UEper))},1)
			CTrigger(FP, CV(CIV,44), {SetV(XEper,_Add(GetXEper45,UEper))},1)
			CTrigger(FP, CV(CIV,45), {SetV(XEper,_Add(GetXEper46,UEper))},1)
			CTrigger(FP, CV(CIV,46), {SetV(XEper,_Add(GetXEper47,UEper))},1)
			CTrigger(FP, CV(CIV,47), {SetV(XEper,_Add(GetXEper48,UEper))},1)
			CTrigger(FP, CV(CIV,48), {SetV(XEper,UEper)},1)
			CIfXEnd()
			CIf(FP,{VRange(CIV, 43, 47)})
			CiSub(FP,XEper,iv.XEPerM)
			TriggerX(FP,CV(XEper,0x80000000,AtLeast),{SetV(XEper,0)},{preserved})--마이너스일경우 0
			CIfEnd()
			NJump(FP, AutoEnchJump, CV(XEper,0))
			CallTrigger(FP, Call_Enchant2)
		NIfXEnd()
	NElseX()
		NJumpEnd(FP, AutoEnchJump)
		CDoActions(FP, {
			TSetNVar(SAmount,SetTo,GetCreateUnit),
			TSetNVar(SUnitID,SetTo,UIDV),
			TSetNVar(SLocation,SetTo,GCP+50),
			TSetNVar(DLocation,SetTo,GCP+80),
			TSetNVar(SPlayer,SetTo,GCP),
		})
		CallTrigger(FP, CreateStackedUnit)
	NIfXEnd()

	SetCallEnd()
end
