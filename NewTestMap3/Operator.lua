function Operator()
	--3 사용가능
	--4 로드완료
	--8 저장완료
	--그외 사용불가
	
	local Time = iv.Time
	local Time2 = iv.Time2
	local Time3 = iv.Time3
	local Time4 = iv.Time4
	local Dx,Dy,Dv,Du,DtP = CreateVariables(5,FP)
	GDt = DtP
	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CV(DtP,2500,AtMost)},{AddV(Time,DtP),AddV(Time2,DtP),AddV(Time3,DtP),AddV(Time4,DtP)},1)--맨처음 시간값 튐 방지
	TriggerX(FP,{},{AddV(Time,240000),})
	--CallTriggerX(FP,Call_CheckCT,{CD(CTTimer,24,AtLeast)},{SetCD(CTTimer,0)})--유닛 변조 감지


	DoActionsX(FP,{SetMemory(0x58F504, SetTo, 0),SetCD(SCA.GlobalCheck2,0)})
	CurrentOP = CreateVar(FP)
	Trigger2X(FP, {CV(iv.Time3,60000*5,AtLeast)}, {SetV(iv.Time3, 0),SetMemory(0x58F504, SetTo, 0x20000),}, {preserved})
	Trigger2X(FP, {CV(iv.Time4,200000,AtLeast)}, {SetV(iv.Time4, 0),SetMemory(0x58F504, SetTo, 0x50000),}, {preserved})

	if Limit == 1 then
		TriggerX(FP, {KeyPress("I","Down")}, {SetMemory(0x58F504, SetTo, 0x20000)}, {preserved})
	end
	if Limit == 1 then
		TriggerX(FP, {KeyPress("T","Down")}, {SetMemory(0x58F504, SetTo, 0x50000)}, {preserved})
	end
	if Limit == 1 then
		--TriggerX(FP, {KeyPress("Y","Down")}, {SetV(SCA.WeekV,0)}, {preserved})
	end
	for i = 0,7 do
		TriggerX(FP, {Deaths(i, AtLeast, 1, 49)}, {SetDeaths(i,SetTo,0,49)},{preserved})
	end

	Trigger2X(FP, {CD(SCA.GReload,1),
}, {SetCD(SCA.GReload,0),
	RotatePlayer({DisplayTextX(StrDesignX("\x03SYSTEM \x04: 5분마다 글로벌 데이터를 다시 불러옵니다..."), 4)}, Force1, FP),
	SetCD(SCA.GlobalCheck,0),
	SetCD(SCA.GlobalLoadFlag,0),
	SetV(SCA.GlobalVarArr[1],0),
	SetV(SCA.MonthV,0),
	SetV(SCA.YearV,0),
	SetV(SCA.HourV,0),
	SetV(SCA.DayV,0),
	SetV(SCA.WeekV,0),
	SetV(SCA.MinV,0),
	SetMemory(SCA.Month, SetTo,0),
	SetMemory(SCA.GlobalData[1],SetTo,0)}, {preserved})

	OPBanActArr={}
	OPBan=CreateCcodeArr(8)
	OPBanT=CreateCcodeArr(8)

    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 7 do
		local TimeT = CreateCcode()
		local TimeC = CreateCcode()
		local TimeC2 = CreateCcode()
		local Time = CreateVar(FP)
        CElseIfX({HumanCheck(i,1),CD(OPBan[i+1],0),DeathsX(i, Exactly, 1, 1,1)},{SetCVar(FP,CurrentOP[2],SetTo,i),AddCD(TimeT,1)})--상위플레이어가 런쳐 연결된경우
		CTrigger(FP, {CD(SCA.GlobalCheck,1,AtLeast),CD(SCA.GlobalCheck,2,AtMost),SCA.NotAvailable(i)}, {AddCD(OPBanT[i+1],1)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,1,AtLeast),CD(SCA.GlobalCheck,2,AtMost),SCA.NotAvailable(i),CD(OPBanT[i+1],60*24,AtLeast)}, {AddCD(OPBan[i+1],1),SetCD(OPBanT[i+1],0)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,3),SCA.Available(i)}, {SetCD(OPBanT[i+1],0)}, {preserved})
		CIfX(FP,{SCA.Available(i)},{})
		if Limit == 1 then
			--TriggerX(FP, {MSQC_KeyInput(i, "F9")}, {SetCD(SCA.GReload,1)}, {preserved})
		end
		
		CTrigger(FP, {CD(SCA.GlobalCheck,0),SCA.Available(i),}, {SetDeaths(i, SetTo, 2, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,1),RotatePlayer({DisplayTextX("GlobalDataLoad1", 4)}, Force1, FP)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,1),SCA.TimeLoadCmp(i),}, {SetDeaths(i, SetTo, 1, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,2),RotatePlayer({DisplayTextX("GlobalDataLoad2", 4)}, Force1, FP)}, {preserved})
		--TriggerX(FP, {CD(SCA.GlobalCheck,2),SCA.Available(i)}, {SetCD(SCA.CheckTime,1),SetCD(SCA.GlobalCheck,3)}, {preserved})--라스트메세지 초기화 신호
		CIfXEnd()
		TriggerX(FP, {CD(SCA.GlobalCheck,1,AtLeast),CD(SCA.GlobalCheck,2,AtMost),}, {}, {preserved})
		CIf(FP,{LocalPlayerID(i),CV(iv.PCheckV,2,AtLeast)})
		CAdd(FP,Time,GDt)
			CIf(FP,{CD(TimeT,10*24,AtLeast)},{SetCD(TimeT,0),AddCD(TimeC, 1)})
				TriggerX(FP, {CV(Time,3500,AtLeast)}, {AddCD(TimeC2,1)},{preserved})
				--DisplayPrint(AllPlayers,{ "\x13\x0413 : ",Time})
				CMov(FP,Time,0)
			CIfEnd()
			TriggerX(FP, {CD(TimeC2,5,AtLeast),Memory(0x58F504,Exactly,0)}, {SetMemory(0x58F504, SetTo, 0x100000),SetCD(TimeC, 0),SetCD(TimeC2,0)},{preserved})
			TriggerX(FP, {CD(TimeC,7,AtLeast)}, {SetCD(TimeC, 0),SetCD(TimeC2,0)},{preserved})
		CIfEnd()
		--TriggerX(FP, {Deaths(i, Exactly, 0x100000, 20)}, {SetCD(InternalFlag,1)},{preserved})
		
		table.insert(OPBanActArr, SetCD(OPBan[i+1],0))
		table.insert(OPBanActArr, SetCD(OPBanT[i+1],0))
	end
	SCA.Timer = CreateCcode()
	CElseX()--OP가 없음. OP밴을 모두 푼다.
	DoActions2X(FP, OPBanActArr)
    CIfXEnd()--
	CIf(FP,{CD(SCA.GlobalCheck,2)},{AddCD(SCA.Timer,1)})
	--error(SCA.Year)
	CIf(FP, {Memory(SCA.Month, AtLeast, 1),CDX(SCA.GlobalLoadFlag,0,1)},{SetCDX(SCA.GlobalLoadFlag,1,1),
	SetV(SCA.MonthV,0),
	SetV(SCA.YearV,0),
	SetV(SCA.HourV,0),
	SetV(SCA.DayV,0),
	SetV(SCA.WeekV,0),
	SetV(SCA.MinV,0),
	SetCD(SCA.GlobalCheck2,1)
})
	f_Read(FP, SCA.Month, SCA.MonthV)
	f_Read(FP, SCA.Year, SCA.YearV)
	f_Read(FP, SCA.Hour, SCA.HourV)
	f_Read(FP, SCA.Day, SCA.DayV)
	f_Read(FP, SCA.Week, SCA.WeekV)
	f_Read(FP, SCA.Min, SCA.MinV)
	if Limit == 1 then
		CMov(FP,SCA.DayV,28+0x32232232)
		CMov(FP,SCA.MonthV,9+0x32232232)
	else
	end
	DoActionsX(FP, {
		SubV(SCA.MonthV,0x32232232),
		SubV(SCA.YearV,0x32232232),
		SubV(SCA.HourV,0x32232232),
		SubV(SCA.DayV,0x32232232),
		SubV(SCA.WeekV,0x32232232),
		SubV(SCA.MinV,0x32232232),
	})


	CIfEnd()
	CIf(FP, {Memory(SCA.GlobalData[1],AtLeast,1),CDX(SCA.GlobalLoadFlag,0,2)},{SetCDX(SCA.GlobalLoadFlag,2,2)})
	SCA.GVAReset = {}
	for i = 1,20 do
		table.insert(SCA.GVAReset, SetV(SCA.GlobalVarArr[i],0))
	end
	DoActionsX(FP, SCA.GVAReset)
	for i = 1,20 do
		f_Read(FP, SCA.GlobalData[i], SCA.GlobalVarArr[i])
	end

	CIfEnd()
	TriggerX(FP,{CDX(SCA.GlobalLoadFlag,3,3),CD(SCA.GlobalCheck,2)},{SetCD(SCA.GlobalCheck,3)},{preserved})
	CIf(FP, {TTOR({Memory(SCA.Month, AtMost, 0),Memory(SCA.GlobalData[1],AtMost,0)}),CD(SCA.Timer,24*60,AtLeast)},{SetCD(SCA.Timer,0)})
	DoActions2X(FP, {
		RotatePlayer({PlayWAVX("sound\\Misc\\PError.WAV"),DisplayTextX(StrDesignX("\x03SYSTEM \x08ERROR \x04: \x06Global Data Load Faliure. Try Again..."), 4)}, Force1, FP),SetV(iv.Time3, 0),
		SetCD(SCA.GlobalCheck,0),
		SetCD(SCA.GlobalLoadFlag,0),
		SetV(SCA.GlobalVarArr[1],0),
		SetV(SCA.MonthV,0),
		SetV(SCA.YearV,0),
		SetV(SCA.HourV,0),
		SetV(SCA.DayV,0),
		SetV(SCA.WeekV,0),
		SetV(SCA.MinV,0),
		SetMemory(SCA.Month, SetTo,0),
		SetMemory(SCA.GlobalData[1],SetTo,0)
	})
	CIfEnd()

	CIfEnd()

	SCA.Loading = CreateCcodeArr(8)
	SCA.LoadJump = def_sIndex()
	CIf(FP,{CD(SCA.GlobalCheck,3)},{SetCD(SCA.Timer,0)})
	if TestStart == 1 then
	CIfX(FP,{VRange(SCA.MinV,0,59),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),VRange(SCA.WeekV, 1, 7)})
	else
	CIfX(FP,{VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),VRange(SCA.WeekV, 1, 7)})
	end
	CElseX()
	DoActions2X(FP, {
		RotatePlayer({PlayWAVX("sound\\Misc\\PError.WAV"),DisplayTextX(StrDesignX("\x03SYSTEM \x08ERROR \x04: \x06날짜 데이터가 잘못되었습니다. 다시 불러옵니다."), 4)}, Force1, FP),SetV(iv.Time3, 0),
		SetCD(SCA.GlobalCheck,0),
		SetCD(SCA.GlobalLoadFlag,0),
		SetV(SCA.GlobalVarArr[1],0),
		SetV(SCA.MonthV,0),
		SetV(SCA.YearV,0),
		SetV(SCA.HourV,0),
		SetV(SCA.DayV,0),
		SetV(SCA.WeekV,0),
		SetV(SCA.MinV,0),
		SetMemory(SCA.Month, SetTo,0),
		SetMemory(SCA.GlobalData[1],SetTo,0),
		SetCD(SCA.GlobalCheck2,0)
	})
	CIfXEnd()


	for i = 0,7 do
		TriggerX(FP, {HumanCheck(i,0)}, {SetCD(SCA.Loading[i+1],0),SetCD(SCA.LoadSlot1[i+1],0)},{preserved})
		TriggerX(FP, {HumanCheck(i,1),SCA.LoadCmp(i),CD(SCA.Loading[i+1],1)}, {SetCD(SCA.LoadCheckArr[i+1],1),SetCD(SCA.Loading[i+1],0),SetCD(SCA.GlobalCheck2,1)},{preserved})
		CTrigger(FP, {HumanCheck(i,1),SCA.Available(i)}, {SetCD(SCA.Loading[i+1],0)},{preserved})
		Trigger2X(FP, {Deaths(i, Exactly, 0x20000, 20)}, {SetCD(SCA.GReload,1)}, {preserved})
		--if SlotEnable == 1 then
		--	Trigger2X(FP, {Deaths(i, Exactly, 0x50000, 20)}, {SetCD(SCA.LoadSlot1[i+1],1)}, {preserved}) -- 슬롯 프로토콜 초기화
		--end
		if Limit == 0 then
			
		end
	end--

	NIfX(FP, {
		CD(SCA.Loading[1],0),
		CD(SCA.Loading[2],0),
		CD(SCA.Loading[3],0), 
		CD(SCA.Loading[4],0),
		CD(SCA.Loading[5],0),
		CD(SCA.Loading[6],0),
		CD(SCA.Loading[7],0)})
		for i = 0,7 do
			NJumpX(FP, SCA.LoadJump, {HumanCheck(i,1),SCA.Available(i),CD(SCA.LoadCheckArr[i+1],0)}, {SetDeaths(i, SetTo, 3, 2),SetCD(SCA.Loading[i+1],1),SCA.Reset(i)})
		end
	NElseX()
		local LoadTimer = CreateCcodeArr(8) 
		local Ttable= {}
		for i = 0, 7 do
			table.insert(Ttable, SubCD(LoadTimer[i+1],1))
			CIf(FP, {HumanCheck(i,1),CD(LoadTimer[i+1],0),SCA.Available(i),CD(SCA.LoadCheckArr[i+1],0)},{SetCD(LoadTimer[i+1], 24*3)})
			CIf(FP,LocalPlayerID(i))
			FixText(FP, 1)
			DoActions(FP, {DisplayText(StrDesign("\x04다른 플레이어가 \x03SCArchive \x04에서 \x07게임 데이터\x04를 불러오고 있습니다. 잠시만 기다려주세요."), 4)})
			FixText(FP, 2)
			CIfEnd()
			CIfEnd()
			
		end
		DoActions2X(FP, Ttable)
	NIfXEnd()
	NJumpXEnd(FP,SCA.LoadJump)
	CIfEnd()
end