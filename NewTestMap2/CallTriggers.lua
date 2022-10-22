function Install_CallTriggers()
	
	Call_Print13 = {}
	for i = 0, 6 do
	Call_Print13[i+1] = SetCallForward()
	SetCall(FP)
		Print_13_2(FP,{i},nil)
	SetCallEnd()
	end
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
		TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF000000),
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
	})
	CTrigger(FP, {CV(DLocation,1,AtLeast)}, {TOrder(SUnitID, SPlayer, SLocation, Move, DLocation)})
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
	GetEPer = f_CRandNum(100001) -- 랜덤 난수 생성
	
	TotalEper = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	TotalEper2 = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	TotalEper3 = CreateVar(FP) -- 새로운 변수 사용으로 중복적용 방지
	--ELevel = 현재 강화중인 레벨
	CAdd(FP,TotalEper,UEper,GEper) -- +1강 확률
	CDiv(FP,TotalEper2,_Add(UEper,GEper2),10) -- +2강 확률
	CDiv(FP,TotalEper3,_Add(UEper,GEper3),100) -- +3강 확률
	
	
	if TestStart == 1 then -- 테스트용 결과 출력
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText(string.rep("\n", 10), 4)})
		
		TestVA = CreateVArr(4, FP)
		TestVA2 = CreateVArr(4, FP)
		ItoDec(FP,GetEPer,VArr(TestVA,0),2,0x1F,0)
		f_Movcpy(FP,_Add(ETestStrPtr1,ETestTxt1[2]),VArr(TestVA,0),4*4)
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0D\x0D\x0DET1".._0D, 4)})
		ItoDec(FP,TotalEper,VArr(TestVA2,0),2,0x1F,0)
		f_Movcpy(FP,_Add(ETestStrPtr2,ETestTxt2[2]),VArr(TestVA2,0),4*4)
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0D\x0D\x0DET2".._0D, 4)})
		ItoDec(FP,TotalEper2,VArr(TestVA2,0),2,0x1F,0)
		f_Movcpy(FP,_Add(ETestStrPtr2,ETestTxt2[2]),VArr(TestVA2,0),4*4)
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0D\x0D\x0DET2".._0D, 4)})
		ItoDec(FP,TotalEper3,VArr(TestVA2,0),2,0x1F,0)
		f_Movcpy(FP,_Add(ETestStrPtr2,ETestTxt2[2]),VArr(TestVA2,0),4*4)
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("\x0D\x0D\x0DET2".._0D, 4)})
	end
	
	--강화 성공 또는 실패 결정. TotalEper가 랜덤난수보다 더 클경우 성공
	CIfX(FP,{CV(TotalEper3,GetEPer,AtLeast)})--+3강 성공시
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("결과 : +3 성공", 4)})
	CAdd(FP,ELevel,3)
	CElseIfX({CV(TotalEper2,GetEPer,AtLeast)})--+2강 성공시
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("결과 : +2 성공", 4)})
	CAdd(FP,ELevel,2)
	CElseIfX({CV(TotalEper,GetEPer,AtLeast)})--+1강 성공시
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("결과 : +1 성공", 4)})
	CAdd(FP,ELevel,1)
	CElseX()--실패시 경험치 지급
		CDoActions(FP, {TSetMemory(0x6509B0, SetTo, ECP),DisplayText("결과 : 실패", 4)})
		for i = 0, 6 do
			CIf(FP,{CV(ECP,i)})
				f_LAdd(FP, PEXP[i+1], PEXP[i+1], {EExp,0})
			CIfEnd()
		end
	CMov(FP,ELevel,0)
	CIfXEnd()
	CIf(FP,{CV(ELevel,1,AtLeast)})
	TriggerX(FP,{CV(ELevel,#LevelUnitArr-1,AtLeast)},{SetV(ELevel,#LevelUnitArr-1)},{preserved})

		for i = 0, 6 do
			CIf(FP,{CV(ECP,i)})
				CMovX(FP,VArr(GetUnitVArr[i+1], ELevel),1,Add)
			CIfEnd()
		end
	CIfEnd()
	
	SetCallEnd()
end