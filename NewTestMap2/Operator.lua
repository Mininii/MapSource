function Operator()
	function SCA.Available(CP)
		return DeathsX(CP, Exactly, 3, 1,3)
	end
	function SCA.Reset(CP)
		return SetDeathsX(CP, SetTo, 0, 1,3)
	end
	function SCA.LoadCmp(CP)
		return DeathsX(CP, Exactly, 3, 1,7)
	end
	--3 사용가능
	--그외 사용불가
	if TestStart == 1 then
		TriggerX(FP, {KeyPress("I","Down")}, {SetCD(SCA.GlobalCheck,0)}, {preserved})
	end
	CurrentOP = CreateVar(FP)
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
        CElseIfX({HumanCheck(i,1),DeathsX(i, Exactly, 1, 1,1)},{SetCVar(FP,CurrentOP[2],SetTo,i)})
		CIfX(FP,{SCA.Available(i)},{})
		CTrigger(FP, {CD(SCA.GlobalCheck,0),SCA.Available(i)}, {SetDeaths(i, SetTo, 2, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,1)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,1),SCA.Available(i)}, {SetDeaths(i, SetTo, 1, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,2)}, {preserved})
		--TriggerX(FP, {CD(SCA.GlobalCheck,2),SCA.Available(i)}, {SetCD(SCA.CheckTime,1),SetCD(SCA.GlobalCheck,3)}, {preserved})--라스트메세지 초기화 신호
		CIfXEnd()
		
	end
	SCA.Timer = CreateCcode()
    CIfXEnd()--
	CIf(FP,{CD(SCA.GlobalCheck,2)},{AddCD(SCA.Timer,1)})
	CIf(FP, {Memory(SCA.Month, AtLeast, 1),CDX(SCA.GlobalLoadFlag,0,1)},{SetCDX(SCA.GlobalLoadFlag,1,1)})
	SetV(SCA.MonthV,0)
	SetV(SCA.YearV,0)
	SetV(SCA.HourV,0)
	SetV(SCA.DayV,0)
	SetV(SCA.WeekV,0)
	f_Read(FP, SCA.Month, SCA.MonthV)
	f_Read(FP, SCA.Year, SCA.YearV)
	f_Read(FP, SCA.Hour, SCA.HourV)
	f_Read(FP, SCA.Day, SCA.DayV)
	f_Read(FP, SCA.Week, SCA.WeekV)
	CIfEnd()
	CIf(FP, {Memory(SCA.GlobalData[1],AtLeast,1),CDX(SCA.GlobalLoadFlag,0,2)},{SetCDX(SCA.GlobalLoadFlag,2,2)})
	SCA.GVAReset = {}
	for i = 1,19 do
		table.insert(SCA.GVAReset, SetV(SCA.GlobalVarArr[i],0))
	end
	DoActionsX(FP, SCA.GVAReset)
	for i = 1,19 do
		f_Read(FP, SCA.GlobalData[i], SCA.GlobalVarArr[i])
	end
	CIfEnd()
	
	TriggerX(FP,{CDX(SCA.GlobalLoadFlag,3,3),CD(SCA.GlobalCheck,2)},{SetCD(SCA.GlobalCheck,3)},{preserved})
	CIf(FP, {TTOR({Memory(SCA.Month, AtMost, 0),Memory(SCA.GlobalData[1],AtMost,0)}),CD(SCA.Timer,24*30,AtLeast)}, {
		
	})
	DoActionsX(FP, {
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
	CIf(FP,{CD(SCA.GlobalCheck,3)})
	for i = 0,6 do
		TriggerX(FP, {HumanCheck(i,0)}, {SetCD(SCA.Loading[i+1],0)},{preserved})
		TriggerX(FP, {HumanCheck(i,1),SCA.LoadCmp(i),CD(SCA.Loading[i+1],1)}, {SetCD(SCA.LoadCheckArr[i+1],1),SetCD(SCA.Loading[i+1],0)},{preserved})
		--CTrigger(FP, {HumanCheck(i,1),SCA.Available(i)}, {SetCD(SCA.Loading[i+1],0)},{preserved})
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