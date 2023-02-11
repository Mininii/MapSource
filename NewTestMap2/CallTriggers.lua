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
	CIf(FP,{Memory(0x628438, AtLeast, 1)},{SetCD(TBLFlag,1)})
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {TCreateUnit(1,SUnitID,SLocation,SPlayer),
		TSetDeaths(_Add(Nextptrs,13),SetTo,2000,0),
		TSetDeathsX(_Add(Nextptrs,18),SetTo,2000,0,0xFFFF),
		TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
		
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
	})
	CIf(FP,{CV(SUnitID,88)})
	for i = 0, 6 do
		CIf(FP,{CV(SPlayer,i)})
		NAppend(FP, NBagArr[i+1], Nextptrs)
		CIfEnd()
	end
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
	CWhileEnd()

	CIfEnd()
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
	if TestStart == 1 then
		GetEPer = CreateVar(FP)
		CIfX(FP,{KeyPress("F12", "Down")})
		CMov(FP,GetEPer,1)
		CElseX()
		GetEPer2 = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
		CMov(FP,GetEPer,GetEPer2)
		CIfXEnd()
	else
		GetEPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
	end
	
	local TotalEper = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	local TotalEper2 = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	local TotalEper3 = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	--ELevel = 현재 강화중인 레벨
	CAdd(FP,TotalEper,UEper,GEper) -- +1강 확률
	CAdd(FP,TotalEper2,_Div(UEper,10),GEper2)
	CAdd(FP,TotalEper3,_Div(UEper,100),GEper3)

	E3Range = CreateVarArr(2, FP)
	E2Range = CreateVarArr(2, FP)
	E1Range = CreateVarArr(2, FP)
	CMov(FP,E3Range[1],1)
	CMov(FP,E3Range[2],TotalEper3)
	CMov(FP,E2Range[1],E3Range[2],1)
	CMov(FP,E2Range[2],_Add(E3Range[2],TotalEper2))
	CMov(FP,E1Range[1],E2Range[2],1)
	CMov(FP,E1Range[2],_Add(E2Range[2],TotalEper))
	if Limit == 1 then -- 테스트용 결과 출력
		CIf(FP,{KeyPress("F12", "Down")})
			CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText(string.rep("\n", 10), 4)})
			for i = 1, 39 do
				TriggerX(FP, CV(ELevel,i-1), {DisplayText("\x08"..i.."강 유닛 강화 시도", 4)},{preserved})
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
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x1F결과 : +3 성공", 4)})
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
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x1C결과 : +2 성공", 4)})
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
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0F결과 : +1 성공", 4)})
			CIfEnd()
		end
		CAdd(FP,ELevel,1)
	CElseX()--실패시 Never(경험치 지급)
		local TempEXP = CreateVar(FP)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x08결과 : 실패", 4)})
			CIfEnd()
		end
		for i = 0, 6 do
			
			--CIf(FP,{CV(ECP,i)})
			--	CIf(FP,{TTNWar(iv.TempEXPW2,AtLeast,"1")})
			--	f_LAdd(FP, PEXP[i+1], PEXP[i+1], {EExp,0})
			--	f_LAdd(FP, Credit[i+1], Credit[i+1], {EExp,0})
			--	CIfEnd()
			--CIfEnd()
		end

		--if TestStart == 1 then
		--	CIf(FP,{KeyPress("F12", "Down")})
		--		ItoDec(FP,_Add(EExp,TempEXP),VArr(TestVA2,0),2,0x1F,0)
		--		f_Movcpy(FP,_Add(ETestStrPtr3,ETestTxt3[2]),VArr(TestVA2,0),4*4)
		--		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0D\x0D\x0DET3".._0D, 4)})
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

	SetCallEnd()

	Call_Enchant2 = SetCallForward()
	SetCall(FP)
	if TestStart == 1 then
		GetEPer = CreateVar(FP)
		CIfX(FP,{KeyPress("F12", "Down")})
		CMov(FP,GetEPer,1)
		CElseX()
		GetEPer2 = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
		CMov(FP,GetEPer,GetEPer2)
		CIfXEnd()
		
		--GetEPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
	else
		GetEPer = f_CRandNum(100000,1) -- 랜덤 난수 생성. GetEPer 사용 종료까지 재생성 금지
	end
	--ELevel = 현재 강화중인 레벨
	CMov(FP,E1Range[1],1)
	CMov(FP,E1Range[2],XEper)

	if Limit == 1 then -- 테스트용 결과 출력
		CIf(FP,{KeyPress("F12", "Down")})
			CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText(string.rep("\n", 10), 4)})
			for i = 40, 44 do
				TriggerX(FP, CV(ELevel,i-1), {DisplayText("\x08"..i.."강 유닛 강화 시도", 4)},{preserved})
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
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0F결과 : +1 성공", 4)})
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
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x08결과 : 파괴방지 성공", 4)})
			CIfEnd()
		end
		CElseX()
		CMov(FP,ELevel,0)
		if Limit == 1 then
			CIf(FP,{KeyPress("F12", "Down")})
				CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x08결과 : 실패", 4)})
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

	local CheatTestJump = def_sIndex()
	CIf(FP,{TTNWar(CTPEXP,AtLeast,CTTotalExp),CV(CTPLevel,LevelLimit-1,AtMost)},{}) -- 경험치 치팅 검사
	ConvertLArr(FP, CTLIndex, _Sub(CTPLevel, 1), 8)
	f_LRead(FP, LArrX({EXPArr},CTLIndex), CT_PrevLMulW, nil, 1)
	CJumpEnd(FP, CheatTestJump)
	NIf(FP,{TTNWar(CTPEXP,AtLeast,CTTotalExp),CV(CTPLevel,LevelLimit-1,AtMost)},{AddV(CTPLevel,1)}) -- 경험치 치팅 검사
	ConvertLArr(FP, CTLIndex, _Sub(CTPLevel, 1), 8)
	f_LRead(FP, LArrX({EXPArr},CTLIndex), CT_NextLMulW, nil, 1)
	f_LAdd(FP, CTTotalExp, CTTotalExp, CT_NextLMulW)
	
	--ConvertLArr(FP, CTLIndex, _Sub(CTPLevel, 2), 8)
	--f_LRead(FP, LArrX({EXPArr},CTLIndex), TempReadW, nil, 1)
	f_LAdd(FP, CTCurEXP, CTCurEXP, CT_PrevLMulW)
	f_LMov(FP, CT_PrevLMulW, CT_NextLMulW)


	--f_Read(FP,FArr(EXPArr,_Sub(CTPLevel,1)),TempReadV,nil,nil,1)
	--f_LAdd(FP, CTTotalExp, CTTotalExp, {TempReadV,0})
	--f_Read(FP,FArr(EXPArr,_Sub(CTPLevel,2)),TempReadV,nil,nil,1)
	--f_LAdd(FP, CTCurEXP, CTCurEXP, {TempReadV,0})
	CAdd(FP,CTStatP,5)
	CJump(FP, CheatTestJump)
	NIfEnd()
	CIfEnd()


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
	GCP = CreateVar(FP)
	VArrI,VArrI4 = CreateVars(2,FP)
	WArrI,WArrI4,GCPW = CreateWars(3,FP)
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
			CElseIfX(CV(G_BtnFnm,1))--자동구매
				local AutoBuyVArr = GetVArray(iv.AutoBuyCode[1], 7)
				local GetNum = CreateVar(FP)
				local GetABData = CreateVar(FP)
				local PBJump = def_sIndex()
				local PBJump2 = def_sIndex()
				NJump(FP, PBJump, CV(G_PushBtnm,24))
				CMov(FP, GetNum,_SHRead(Arr(BuyDataArr,G_PushBtnm)))
				CMovX(FP,GetABData,VArrX(AutoBuyVArr,VArrI,VArrI4))

				CIfX(FP,{TNVar(GetNum, Exactly, GetABData)})
					DisplayPrintEr(GCP, {"\x07『 \x06",GetNum,"강 \x04유닛 \x1B자동구입 \x08OFF \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),0)
				CElseX()
					DisplayPrintEr(GCP, {"\x07『 \x06",GetNum,"강 \x04유닛 \x1B자동구입 \x07ON \x07』"})
					CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),GetNum)
				CIfXEnd()

				CJump(FP, PBJump2)
				NJumpEnd(FP, PBJump)
				DisplayPrintEr(GCP, {"\x07『 \x04유닛 \x1B자동구입 \x08OFF \x07』"})
				CMovX(FP,VArrX(AutoBuyVArr,VArrI,VArrI4),0)
				CJumpEnd(FP,PBJump2)




			CElseIfX({CV(G_BtnFnm,2,AtLeast),CV(G_BtnFnm,5,AtMost)})--자동강화 1~25
				TriggerX(FP, {CV(G_BtnFnm,3)}, AddV(G_PushBtnm,25), {preserved})
				TriggerX(FP, {CV(G_BtnFnm,5)}, AddV(G_PushBtnm,25), {preserved})
				local GetArrNum = CreateVar(FP)
				local GetArrNum2 = CreateVar(FP)
				local TxtColor = CreateVar(FP)
				f_Mul(FP, GetArrNum2, G_PushBtnm, 7)
				CAdd(FP,GetArrNum2,GCP)
				ConvertArr(FP,GetArrNum,GetArrNum2)

				DoActionsX(FP,{SetV(TxtColor,0x06),AddV(G_PushBtnm,1)})
				TriggerX(FP, {CV(G_PushBtnm,26,AtLeast)}, SetV(TxtColor,0x0F), {preserved})

				CIf(FP,{CV(G_BtnFnm,2,AtLeast),CV(G_BtnFnm,3,AtMost)})
					CIfX(FP,{TMemory(_TMem(ArrX(AutoEnchArr,GetArrNum)),Exactly,0)})
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x07ON \04(판매 우선 적용됨) \x07』",})
						CMovX(FP,ArrX(AutoEnchArr,GetArrNum),1)
					CElseX()
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x1B자동강화 \x08OFF \04(판매 우선 적용됨) \x07』",})
						CMovX(FP,ArrX(AutoEnchArr,GetArrNum),0)
					CIfXEnd()
				CIfEnd()
				CIf(FP,{CV(G_BtnFnm,4,AtLeast),CV(G_BtnFnm,5,AtMost)})
					CIfX(FP,{TMemory(_TMem(ArrX(AutoSellArr,GetArrNum)),Exactly,0)})
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x07자동판매 \x07ON \04(판매 우선 적용됨) \x07』",})
						CMovX(FP,ArrX(AutoSellArr,GetArrNum),1)

					CElseX()
						DisplayPrintEr(GCP, {"\x07『 ",TxtColor[2],G_PushBtnm,"강 \x04유닛 \x07자동판매 \x08OFF \04(판매 우선 적용됨) \x07』",})
						CMovX(FP,ArrX(AutoSellArr,GetArrNum),0)
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
							CTrigger(FP,{},{CreateUnit(1,94,136,FP),RemoveUnit(94,FP),TSetMemory(0x6509B0, SetTo, GCP),DisplayText(StrDesignX("\x08싱글 플레이로 전환합니다. 이 설정은 되돌릴 수 없습니다."),4),SetCp(FP),},{preserved})
							CSub(FP,CurCunitI,Nextptrs,19025)
							f_Div(FP,CurCunitI,_Mov(84))
							CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,0,SetTo,_Add(CT_GNextRandV,94))})
							CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,1,SetTo,CT_GNextRandV),})
							CDoActions(FP, {Set_EXCC2(CT_Cunit,CurCunitI,2,SetTo,_Add(CT_GNextRandV,FP)),})
							
							--CallTrigger(FP, Call_CTInputUID)
						CIfEnd()
						CIf(FP, {CV(iv.PCheckV,2,AtLeast)})
							CTrigger(FP,{TMemory(0x512684,Exactly,GCP),CD(SCheck,0)},{SetCD(SCheck,1),TSetMemory(0x6509B0, SetTo, GCP),DisplayText(StrDesignX("\x04정말로 \x08싱글플레이\x04로 \x07전환\x04하시겠습니까? \x08원하시면 한번 더 눌러주세요."),4),SetCp(FP),},{preserved})

						CIfEnd()
					CElseX()--조건이 만족하지 않을 경우
						Print_13X(FP, GCP)
						CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),SetCp(FP),print_utf8(12,0,StrDesign("\x08ERROR \x04: 시민을 싱글 플레이 설정 위치로 이동한 후 사용가능합니다."))},{preserved})
					CIfXEnd()
					CIfX(FP,{CD(iv.PartyBonus,2,AtLeast)})
						CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),DisplayText("\x07멀티 보너스 버프 \x04활성화 상태 : \x07런쳐 로드 인원이 2명이상 인식되어 영구 활성화 되었습니다.",4)})
					CElseIfX({CV(iv.PCheckV,2,AtLeast)})
						CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),DisplayText("\x07멀티 보너스 버프 \x04활성화 상태 : \x07활성화 되었지만 런쳐 로드 인원이 1명 이하입니다. 솔로 플레이로 전환할 경우 버프가 \x08비활성화됩니다.",4)})
					CElseX()
						CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),DisplayText("\x07멀티 보너스 버프 \x04활성화 상태 : \x08활성화 불가능.",4)})
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
			CIfX(FP, {TDeathsX(GCP, Exactly, 1, 1,1)},{TSetMemory(0x6509B0, SetTo, GCP),DisplayText("\n\n\n\n\n\n\n\n\n", 4),SetCp(FP)})
			CIfX(FP,{CV(iv.GeneralPlayTime,24*60*60,AtLeast)})
				GetCreditData = CreateWar(FP)
				GerRandData = CreateVar(FP)
				GetPMissionData = CreateVar(FP)
				f_LMov(FP,GetCreditData,"0",nil,nil,1)--크레딧 복사버그 방지용 초기화...?
				CMovX(FP,GetPMissionData,VArrX(GetVArray(iv.PMission[1], 7),VArrI,VArrI4))
				CMovX(FP,GetMissionData,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4))
				CMovX(FP,GetClassData,VArrX(GetVArray(iv.PUnitClass[1], 7),VArrI,VArrI4))
				CMovX(FP,GetPUnitLevel,VArrX(GetVArray(iv.PUnitLevel[1], 7),VArrI,VArrI4))
				CMovX(FP,GetVAccData,VArrX(GetVArray(iv.VaccItem[1], 7),VArrI,VArrI4))
				f_LMovX(FP, GetCreditData, WArrX(GetWArray(iv.Credit[1], 7), WArrI, WArrI4))
				SaveChkData = CreateVar(FP)
				GetEnchCoolData = CreateVar(FP)
				CMovX(FP,GetEnchCoolData,VArrX(GetVArray(EnchCool[1], 7),VArrI,VArrI4))
				CMovX(FP,SaveChkData,VArrX(GetVArray(iv.PSaveChk[1], 7),VArrI,VArrI4))
				
				CIf(FP,{CV(G_PushBtnm,0,AtLeast),CV(G_PushBtnm,1,AtMost)}) -- 
					CIfX(FP,{TTOR({CV(GetPUnitLevel,10,AtLeast),CV(SaveChkData,1,AtLeast)})})
						CTrigger(FP,{CV(GetPUnitLevel,10,AtLeast)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 이미 최고단계까지 강화되었습니다. \x07승급\x04을 진행해주세요."), 4),SetCp(FP)},{preserved})
						CTrigger(FP,{CV(SaveChkData,1,AtLeast)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 강화를 진행하기 위해선 먼저 저장해야 합니다. F9를 눌러주세요."), 4),SetCp(FP)},{preserved})
						CElseX()
						PrevPUnitLevel = CreateVar(FP)
						CIfX(FP,{TTNWar(GetCreditData, AtLeast, _LAdd(_LMul({GetPUnitLevel,0},"1000"),"1000"))})
							VaccJump = def_sIndex()
							CIfX(FP, {CV(G_PushBtnm,1),CV(GetVAccData,0)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: \x10강화기 백신\x04이 부족합니다."), 4),SetCp(FP)})
							CElseX()
								CMov(FP, GetMissionData, 2, nil, 2)
								CTrigger(FP,{TMemory(0x512684,Exactly,GCP)},{SetMemory(0x58F500, SetTo, 1)},{preserved})--자동저장
								CTrigger(FP,{CV(GetPUnitLevel,8,AtLeast)},{SetV(GetEnchCoolData,50),SetV(SaveChkData,1),TSetDeaths(GCP, SetTo, 0, 1)},{preserved})--저장필요
								CMovX(FP,GerRandData,VArrX(GetVArray(iv.RandomSeed1[1], 7),VArrI,VArrI4))
								f_LSub(FP, GetCreditData, GetCreditData, _LAdd(_LMul({GetPUnitLevel,0},"1000"),"1000"))
								CTrigger(FP,{CV(GerRandData,0)},{TSetNVar(GerRandData, SetTo, _Rand())},1)
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
								
								CMovX(FP,VArrX(GetVArray(iv.RandomSeed1[1], 7),VArrI,VArrI4),0,SetTo,nil,nil,1)
							CIfXEnd()
						CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})--크레딧이 부족합
						CIfXEnd()
					CIfXEnd()
			--		DisplayPrint(GCP, {"일반강화"})
				CIfEnd()

					GetPETicket = CreateVar(FP)
					CMovX(FP,GetPETicket,VArrX(GetVArray(iv.PETicket[1], 7),VArrI,VArrI4))
					CIf(FP,{CV(G_PushBtnm,2)}) -- 확정강화
					CIfX(FP,{CV(GetPETicket,1,AtLeast)})
					CIfX(FP,{CV(GetPUnitLevel,9)})
					CSub(FP, GetPETicket, 1)
					CMov(FP,PrevPUnitLevel,GetPUnitLevel)
					CAdd(FP,GetPUnitLevel,1)
					f_Read(FP,_Add(G_Btnptr,10),CPos)
					Convert_CPosXY()
					Simple_SetLocX(FP, 86, CPosX, CPosY, CPosX, CPosY,{CreateUnitWithProperties(9,82,136,FP,{hallucinated = false}),MoveUnit(All, 82, FP, 136, 87),GiveUnits(All, 82, FP, 64, P9),KillUnit(82, P9)})
					DisplayPrint(GCP, {"\x13\x07『 \x1F확정 강화권\x04을 사용하여 강화하셨습니다. \x07",PrevPUnitLevel,"강 → ",GetPUnitLevel,"강 \x07』"})
					CMov(FP, GetMissionData, 128, nil, 128)
					CElseIfX({CV(GetPUnitLevel,8,AtMost)})
					CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 이 아이템은 \x089강 \x04에서만 사용가능합니다. \x07강화\x04를 더 진행해주세요."), 4),SetCp(FP)})
					CElseX()
					CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 이미 최고단계까지 강화되었습니다. \x07승급\x04을 진행해주세요."), 4),SetCp(FP)})
					CIfXEnd()
					CElseX()
					CDoActions(FP, {TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 확정 강화권이 부족합니다."), 4),SetCp(FP)})
					CIfXEnd()


					CIfEnd()
					CMovX(FP,VArrX(GetVArray(iv.PETicket[1], 7),VArrI,VArrI4),GetPETicket)


					CIf(FP,{CV(G_PushBtnm,3,AtLeast),CV(G_PushBtnm,9,AtMost)},{}) -- 승급
						CIfX(FP,{CV(GetPUnitLevel,9,AtMost)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 승급에 필요한 강화 단계가 부족합니다. 필요 단계 : 10강"), 4),SetCp(FP)})
						CElseX()
							GetUID = CreateVar(FP)
							CMov(FP,GetUID,_SHRead(_Add(G_Btnptr,25)),nil,0xFF,1)

							CIfX(FP,{TBring(GCP, AtLeast, 1, GetUID, _Add(GCP,160))})--승급하기
								GetCooldownData,GetAtkData,GetEXPData,GetTotalEPerData,GetTotalEper4Data,GetDPSLVData,GetBrShData = CreateVars(7,FP)
								CMovX(FP,GetCooldownData,VArrX(GetVArray(iv.CS_Cooldown[1], 7),VArrI,VArrI4))
								CMovX(FP,GetBrShData,VArrX(GetVArray(iv.CS_BreakShield[1], 7),VArrI,VArrI4))
								CMovX(FP,GetAtkData,VArrX(GetVArray(iv.CS_Atk[1], 7),VArrI,VArrI4))
								CMovX(FP,GetEXPData,VArrX(GetVArray(iv.CS_EXP[1], 7),VArrI,VArrI4))
								CMovX(FP,GetTotalEPerData,VArrX(GetVArray(iv.CS_TotalEPer[1], 7),VArrI,VArrI4))
								CMovX(FP,GetTotalEper4Data,VArrX(GetVArray(iv.CS_TotalEper4[1], 7),VArrI,VArrI4))
								CMovX(FP,GetDPSLVData,VArrX(GetVArray(iv.CS_DPSLV[1], 7),VArrI,VArrI4))
								

								ClassUpErrJump = def_sIndex()
								CMov(FP,0x6509B0,GCP)
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,3),CV(GetCooldownData,CS_CooldownLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 더 이상 공격속도를 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,4),CV(GetAtkData,CS_AtkLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 더 이상 공격력을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,5),CV(GetEXPData,CS_EXPLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 더 이상 판매시 경험치 획득량을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,6),CV(GetTotalEPerData,CS_TotalEPerLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 더 이상 +1 강화확률을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,7),CV(GetTotalEper4Data,CS_TotalEper4Limit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 더 이상 \x08특수 \x04강화확률을 올릴 수 없습니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,8),CV(GetDPSLVData,CS_DPSLVLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 해당 옵션은 1회만 사용 가능합니다."), 4),SetCp(FP)})
								NJumpX(FP,ClassUpErrJump,{CV(G_PushBtnm,9),CV(GetBrShData,CS_BreakShieldLimit,AtLeast)},{PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 더 이상 \x1F파괴 방지 \x04확률을 올릴 수 없습니다."), 4),SetCp(FP)})
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
									CIf(FP,{CV(G_PushBtnm,8)},{AddV(GetDPSLVData,1),TSetMemory(0x6509B0, SetTo, GCP),DisplayText(StrDesignX("\x04이제부터 \x07고유 유닛\x04으로 \x0FLV.2 \x04사냥터에 입장할 수 있습니다."))})
									CIfEnd()
									CIf(FP,{CV(G_PushBtnm,9)},{AddV(GetBrShData,1)})
										CMov(FP,TempV,_Mul(GetBrShData,100))
										CMov(FP,GEVar,TempV)
										CallTrigger(FP, Call_SetEPerStr)
										DisplayPrint(GCP, {"\x13\x07『 \x08특수 \x1F파괴방지 \x04확률이 증가하였습니다. \x04증가 후 \x04: \x07+ \x08",EVarArr2,".",EVarArr3,"%p \x07』"})
									CIfEnd()

									CMovX(FP,VArrX(GetVArray(iv.CS_Cooldown[1], 7),VArrI,VArrI4),GetCooldownData)
									CMovX(FP,VArrX(GetVArray(iv.CS_BreakShield[1], 7),VArrI,VArrI4),GetBrShData)
									CMovX(FP,VArrX(GetVArray(iv.CS_Atk[1], 7),VArrI,VArrI4),GetAtkData)
									CMovX(FP,VArrX(GetVArray(iv.CS_EXP[1], 7),VArrI,VArrI4),GetEXPData)
									CMovX(FP,VArrX(GetVArray(iv.CS_TotalEPer[1], 7),VArrI,VArrI4),GetTotalEPerData)
									CMovX(FP,VArrX(GetVArray(iv.CS_TotalEper4[1], 7),VArrI,VArrI4),GetTotalEper4Data)
									CMovX(FP,VArrX(GetVArray(iv.CS_DPSLV[1], 7),VArrI,VArrI4),GetDPSLVData)


								CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: \x17크레딧\x04이 부족합니다."), 4),SetCp(FP)})
								CIfXEnd()
								NJumpXEnd(FP,ClassUpErrJump)
							CElseX({TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 해당 기능은 승급장에서 사용가능합니다."), 4),SetCp(FP)})
							CIfXEnd()
						CIfXEnd()

					CIfEnd()

				CMovX(FP,VArrX(GetVArray(iv.PMission[1], 7),VArrI,VArrI4),GetPMissionData)
				CMovX(FP,VArrX(GetVArray(iv.MissionV[1], 7),VArrI,VArrI4),GetMissionData)
				CMovX(FP,VArrX(GetVArray(iv.PUnitLevel[1], 7),VArrI,VArrI4),GetPUnitLevel)
				f_LMovX(FP, WArrX(GetWArray(iv.Credit[1], 7), WArrI, WArrI4), GetCreditData)
				CMovX(FP,VArrX(GetVArray(iv.VaccItem[1], 7),VArrI,VArrI4),GetVAccData)
				CMovX(FP,VArrX(GetVArray(iv.PUnitClass[1], 7),VArrI,VArrI4),GetClassData)
				CMovX(FP, VArrX(GetVArray(iv.PSaveChk[1], 7), VArrI, VArrI4),SaveChkData)
				CMovX(FP,VArrX(GetVArray(EnchCool[1], 7),VArrI,VArrI4),GetEnchCoolData)
			CElseIfX({TTNVar(G_PushBtnm,NotSame,10)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 이 기능은 인게임 1시간이 지난 후 사용할 수 있습니다."), 4),SetCp(FP)})
				CMov(FP,CTimeV,_Div(_Sub(_Mov(24*60*60),iv.GeneralPlayTime), 24))
				CallTrigger(FP, Call_ConvertTime)
				DisplayPrint(GCP, {"\x13\x07『 고유유닛 기능 \x04활성화까지 남은 시간 : \x07",CTimeHH,"시간 ",CTimeMM,"분 ",CTimeSS,"초 \x07』"})
			CIfXEnd()
			CElseIfX({TTNVar(G_PushBtnm,NotSame,10)},{TSetMemory(0x6509B0, SetTo, GCP),PlayWAV("sound\\Misc\\PError.WAV"),DisplayText(StrDesignX("\x08ERROR \x04: 런쳐에 연결되어있지 않아 기능을 사용할 수 없습니다."), 4),SetCp(FP)})
			CIfXEnd()
			
			CIf(FP,{CV(G_PushBtnm,10)},{TSetMemory(0x6509B0, SetTo, GCP),DisplayText(StrDesign("\x04현재 고유유닛 승급 효과는 다음과 같습니다."), 4)})
				CMovX(FP,GetCooldownData,VArrX(GetVArray(iv.CS_Cooldown[1], 7),VArrI,VArrI4))
				CMovX(FP,GetAtkData,VArrX(GetVArray(iv.CS_Atk[1], 7),VArrI,VArrI4))
				CMovX(FP,GetBrShData,VArrX(GetVArray(iv.CS_BreakShield[1], 7),VArrI,VArrI4))
				CMovX(FP,GetEXPData,VArrX(GetVArray(iv.CS_EXP[1], 7),VArrI,VArrI4))
				CMovX(FP,GetTotalEPerData,VArrX(GetVArray(iv.CS_TotalEPer[1], 7),VArrI,VArrI4))
				CMovX(FP,GetTotalEper4Data,VArrX(GetVArray(iv.CS_TotalEper4[1], 7),VArrI,VArrI4))
				CMovX(FP,GetDPSLVData,VArrX(GetVArray(iv.CS_DPSLV[1], 7),VArrI,VArrI4))
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
				CTrigger(FP,{CV(GetDPSLVData,0)},{TSetMemory(0x6509B0, SetTo, GCP),DisplayText(StrDesign("\x0ELV.1 사냥터 \x04입장 효과 적용중"), 4)},1)
				CTrigger(FP,{CV(GetDPSLVData,1)},{TSetMemory(0x6509B0, SetTo, GCP),DisplayText(StrDesign("\x0FLV.2 사냥터 \x04입장 효과 적용중"), 4)},1)
				
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
		PUnitPtr[1] -- 고유유닛
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
		local LocPVA = GetVArray(k[1], 7)
		CMovX(FP,k[2],VArrX(LocPVA,VArrI,VArrI4),nil,nil,nil,1)
	end
	

	CMov(FP,iv.LCP,GCP)




	SetCallEnd()

	TempWX = CreateWar(FP)
	local LIndex = CreateVar(FP)
	StartLV = CreateVar(FP)
	EndLV = CreateVar(FP)
	local TempW = CreateWar(FP)
	Call_GetLevelEXP = SetCallForward()
	SetCall(FP)
	local GEXPJump = def_sIndex()
	NJumpEnd(FP, GEXPJump)
	
	ConvertLArr(FP, LIndex, _Sub(StartLV, 1), 8)
	f_LRead(FP, LArrX({EXPArr},LIndex), TempW, nil, 1)
	f_LAdd(FP, TempWX, TempWX, TempW)

	CAdd(FP,StartLV,1)

	NJump(FP, GEXPJump, {CV(StartLV,EndLV,AtMost)})


	SetCallEnd()


if TestStart == 1 then
	
end
end