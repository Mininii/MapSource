function Operator()
	function SCA.Available(CP)
		return DeathsX(CP, Exactly, 3, 1,3)
	end
	function SCA.Reset(CP)
		return SetDeaths(CP, SetTo, 0, 1)
	end
	function SCA.LoadCmp(CP)--사용가능 + 로드완료
		return DeathsX(CP, Exactly, 7, 1,7)
	end
	function SCA.SaveCmp(CP)--사용가능 + 저장완료
		return DeathsX(CP, Exactly, 11, 1,11)
	end
	--3 사용가능
	--4 로드완료
	--8 저장완료
	--그외 사용불가
	DoActions(FP,{SetMemory(0x58F504, SetTo, 0)})
	CurrentOP = CreateVar(FP)
	Trigger2X(FP, {CV(iv.Time3,60000*5,AtLeast)}, {SetV(iv.Time3, 0),SetMemory(0x58F504, SetTo, 0x20000),}, {preserved})

	if Limit == 1 then
		TriggerX(FP, {KeyPress("I","Down")}, {SetMemory(0x58F504, SetTo, 0x20000)}, {preserved})
	end

	Trigger2X(FP, {CD(SCA.GReload,1)}, {SetCD(SCA.GReload,0),
	RotatePlayer({DisplayTextX(StrDesignX("\x03SYSTEM \x04: 5분마다 글로벌 데이터를 다시 불러옵니다..."), 4)}, Force1, FP),
	SetCD(SCA.GlobalCheck,0),
	SetCD(SCA.GlobalLoadFlag,0),
	SetV(SCA.GlobalVarArr[1],0),
	SetV(SCA.MonthV,0),
	SetMemory(SCA.Month, SetTo,0),
	SetMemory(SCA.GlobalData[1],SetTo,0)}, {preserved})



    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
        CElseIfX({HumanCheck(i,1),DeathsX(i, Exactly, 1, 1,1)},{SetCVar(FP,CurrentOP[2],SetTo,i)})--상위플레이어가 런쳐 연결된경우
		CIfX(FP,{SCA.Available(i)},{})
		if Limit == 1 then
			--TriggerX(FP, {MSQC_KeyInput(i, "F9")}, {SetCD(SCA.GReload,1)}, {preserved})
		end
		CTrigger(FP, {CD(SCA.GlobalCheck,0),SCA.Available(i)}, {SetDeaths(i, SetTo, 2, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,1)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,1),SCA.Available(i)}, {SetDeaths(i, SetTo, 1, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,2)}, {preserved})
		--TriggerX(FP, {CD(SCA.GlobalCheck,2),SCA.Available(i)}, {SetCD(SCA.CheckTime,1),SetCD(SCA.GlobalCheck,3)}, {preserved})--라스트메세지 초기화 신호
		CIfXEnd()
		
	end
	SCA.Timer = CreateCcode()
    CIfXEnd()--
	CIf(FP,{CD(SCA.GlobalCheck,2)},{AddCD(SCA.Timer,1)})
	--error(SCA.Year)
	CIf(FP, {Memory(SCA.Month, AtLeast, 1),CDX(SCA.GlobalLoadFlag,0,1)},{SetCDX(SCA.GlobalLoadFlag,1,1),
	SetV(SCA.MonthV,0),
	SetV(SCA.YearV,0),
	SetV(SCA.HourV,0),
	SetV(SCA.DayV,0),
	SetV(SCA.WeekV,0)})
	f_Read(FP, SCA.Month, SCA.MonthV)
	f_Read(FP, SCA.Year, SCA.YearV)
	f_Read(FP, SCA.Hour, SCA.HourV)
	f_Read(FP, SCA.Day, SCA.DayV)
	f_Read(FP, SCA.Week, SCA.WeekV)
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
		SetMemory(SCA.Month, SetTo,0),
		SetMemory(SCA.GlobalData[1],SetTo,0)
	})
	CIfEnd()

	CIfEnd()

	SCA.Loading = CreateCcodeArr(7)
	SCA.LoadJump = def_sIndex()
	CIf(FP,{CD(SCA.GlobalCheck,3)},{SetCD(SCA.Timer,0)})
	for i = 0,6 do
		TriggerX(FP, {HumanCheck(i,0)}, {SetCD(SCA.Loading[i+1],0)},{preserved})
		TriggerX(FP, {HumanCheck(i,1),SCA.LoadCmp(i),CD(SCA.Loading[i+1],1)}, {SetCD(SCA.LoadCheckArr[i+1],1),SetCD(SCA.Loading[i+1],0),AddCD(iv.PartyBonus,1)},{preserved})
		CTrigger(FP, {HumanCheck(i,1),SCA.Available(i)}, {SetCD(SCA.Loading[i+1],0)},{preserved})
		Trigger2X(FP, {Deaths(i, Exactly, 0x20000, 20)}, {SetCD(SCA.GReload,1)}, {preserved})
	end--

	NIf(FP, {TTOR({
		CD(SCA.Loading[1],0),
		CD(SCA.Loading[2],0),
		CD(SCA.Loading[3],0),
		CD(SCA.Loading[4],0),
		CD(SCA.Loading[5],0),
		CD(SCA.Loading[6],0),
		CD(SCA.Loading[7],0)})})
		for i = 0,6 do
			NJumpX(FP, SCA.LoadJump, {HumanCheck(i,1),SCA.Available(i),CD(SCA.LoadCheckArr[i+1],0)}, {SetDeaths(i, SetTo, 3, 2),SetCD(SCA.Loading[i+1],1),SCA.Reset(i)})
		end
	NIfEnd()
	NJumpXEnd(FP,SCA.LoadJump)
	CIfEnd()
	
end