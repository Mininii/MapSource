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
end