function System()
	local Time = iv.Time
	local Time2 = iv.Time2
	local Time3 = iv.Time3
	local Dx,Dy,Dv,Du,DtP = CreateVariables(5,FP)
	f_Read(FP,0x51CE8C,Dx)
	CiSub(FP,Dy,_Mov(0xFFFFFFFF),Dx)
	CiSub(FP,DtP,Dy,Du)
	CMov(FP,Dv,DtP) 
	CMov(FP,Du,Dy)
	CTrigger(FP,{CV(DtP,2500,AtMost)},{AddV(Time,DtP),AddV(Time2,DtP),AddV(Time3,DtP)},1)--��ó�� �ð��� Ʀ ����
	TriggerX(FP,{},{AddV(Time,240000),})
	Trigger2X(FP, {CV(Time3,60000*5)}, {RotatePlayer({DisplayTextX(StrDesignX("\x03SYSTEM \x04: 5�и��� �۷ι� �����͸� �ٽ� �ҷ��ɴϴ�..."), 4)}, Force1, FP),SetV(Time3, 0),SetCD(SCA.GlobalCheck,0),SetV(SCA.GlobalData[1],0),SetCD(SCA.GLoadCmp,0)}, {preserved})
	--CallTriggerX(FP,Call_CheckCT,{CD(CTTimer,24,AtLeast)},{SetCD(CTTimer,0)})--���� ���� ����
end