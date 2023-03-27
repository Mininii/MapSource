function System()
	local Time = iv.Time
	local Time2 = iv.Time2
	local Time3 = iv.Time3
	local Time4 = iv.Time4
	local Dx,Dy,Dv,Du,DtP = CreateVariables(5,FP)
	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CV(DtP,2500,AtMost)},{AddV(Time,DtP),AddV(Time2,DtP),AddV(Time3,DtP),AddV(Time4,DtP)},1)--맨처음 시간값 튐 방지
	TriggerX(FP,{},{AddV(Time,240000),})
	--CallTriggerX(FP,Call_CheckCT,{CD(CTTimer,24,AtLeast)},{SetCD(CTTimer,0)})--유닛 변조 감지
end