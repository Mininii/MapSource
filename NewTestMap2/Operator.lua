function Operator()
	--3 ��밡��
	--4 �ε�Ϸ�
	--8 ����Ϸ�
	--�׿� ���Ұ�
	DoActionsX(FP,{SetMemory(0x58F504, SetTo, 0),SetCD(SCA.GlobalCheck2,0)})
	CurrentOP = CreateVar(FP)
	Trigger2X(FP, {CV(iv.Time3,60000*5,AtLeast)}, {SetV(iv.Time3, 0),SetMemory(0x58F504, SetTo, 0x20000),}, {preserved})
	Trigger2X(FP, {CV(iv.Time4,60000,AtLeast)}, {SetV(iv.Time4, 0),SetMemory(0x58F504, SetTo, 0x50000),}, {preserved})

	if Limit == 1 then
		TriggerX(FP, {KeyPress("I","Down")}, {SetMemory(0x58F504, SetTo, 0x20000)}, {preserved})
	end
	if Limit == 1 then
		--TriggerX(FP, {KeyPress("T","Down")}, {SetMemory(0x58F504, SetTo, 0x50000)}, {preserved})
	end
	if Limit == 1 then
		--TriggerX(FP, {KeyPress("Y","Down")}, {SetV(SCA.WeekV,0)}, {preserved})
	end
	for i = 0,6 do
		TriggerX(FP, {Deaths(i, AtLeast, 1, 49)}, {SetDeaths(i,SetTo,0,49),SetV(DPErT[i+1],24*10)},{preserved})
	end

	Trigger2X(FP, {CD(SCA.GReload,1),
}, {SetCD(SCA.GReload,0),
	RotatePlayer({DisplayExtText(StrDesignX("\x03SYSTEM \x04: 5�и��� �۷ι� �����͸� �ٽ� �ҷ��ɴϴ�..."), 4)}, Force1, FP),
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
	OPBan=CreateCcodeArr(7)
	OPBanT=CreateCcodeArr(7)

    CIfX(FP,Never()) -- �����÷��̾� �ܶ� ����
	for i = 0, 6 do
		local TimeT = CreateCcode()
		local TimeC = CreateCcode()
		local TimeC2 = CreateCcode()
		local Time = CreateVar(FP)
        CElseIfX({HumanCheck(i,1),CD(OPBan[i+1],0),DeathsX(i, Exactly, 1, 1,1)},{SetCVar(FP,CurrentOP[2],SetTo,i),AddCD(TimeT,1)})--�����÷��̾ ���� ����Ȱ��
		CTrigger(FP, {CD(SCA.GlobalCheck,1,AtLeast),CD(SCA.GlobalCheck,2,AtMost),SCA.NotAvailable(i)}, {AddCD(OPBanT[i+1],1)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,1,AtLeast),CD(SCA.GlobalCheck,2,AtMost),SCA.NotAvailable(i),CD(OPBanT[i+1],60*24,AtLeast)}, {AddCD(OPBan[i+1],1),SetCD(OPBanT[i+1],0)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,3),SCA.Available(i)}, {SetCD(OPBanT[i+1],0)}, {preserved})
		CIfX(FP,{SCA.Available(i)},{})
		if Limit == 1 then
			--TriggerX(FP, {MSQC_KeyInput(i, "F9")}, {SetCD(SCA.GReload,1)}, {preserved})
		end
		
		CTrigger(FP, {CD(SCA.GlobalCheck,0),SCA.Available(i),}, {SetDeaths(i, SetTo, 2, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,1)}, {preserved})
		CTrigger(FP, {CD(SCA.GlobalCheck,1),SCA.Available(i),}, {SetDeaths(i, SetTo, 1, 2),SCA.Reset(i),SetCD(SCA.GlobalCheck,2)}, {preserved})
		--TriggerX(FP, {CD(SCA.GlobalCheck,2),SCA.Available(i)}, {SetCD(SCA.CheckTime,1),SetCD(SCA.GlobalCheck,3)}, {preserved})--��Ʈ�޼��� �ʱ�ȭ ��ȣ
		CIfXEnd()
		TriggerX(FP, {CD(SCA.GlobalCheck,1,AtLeast),CD(SCA.GlobalCheck,2,AtMost),}, {SetV(DPErT[i+1],24*10)}, {preserved})
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
		TriggerX(FP, {Deaths(i, Exactly, 0x100000, 20)}, {SetCD(InternalFlag,1)},{preserved})
		
		table.insert(OPBanActArr, SetCD(OPBan[i+1],0))
		table.insert(OPBanActArr, SetCD(OPBanT[i+1],0))
	end
	SCA.Timer = CreateCcode()
	CElseX()--OP�� ����. OP���� ��� Ǭ��.
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
	if Limit == 1 then
		CMov(FP,SCA.WeekV,5+0x32232232)
		CMov(FP,SCA.DayV,19+0x32232232)
	else
		f_Read(FP, SCA.Day, SCA.DayV)
		f_Read(FP, SCA.Week, SCA.WeekV)
	end
	f_Read(FP, SCA.Min, SCA.MinV)
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
	--Trigger2X(FP, {CVX(SCA.GlobalVarArr[5],1,1)}, {RotatePlayer({DisplayExtText(StrDesignX("\x04���� \x10���� 1ȣ \x07�⼮ �̺�Ʈ \x04���Դϴ�!").."\n"..StrDesignX("���� �⼮ ����(�ִ� 28ȸ) \x04: \x19���� �Ǹű� 100��, \x17ũ���� 10��").."\n"..StrDesignX("���� 7�� �⼮ ����(�ִ� 4ȸ) \x04: \x17ũ���� 100��, \x10��ȭ�� ��� 5��"),4)}, Force1, FP)}, {preserved})
	--Trigger2X(FP, {CVX(SCA.GlobalVarArr[5],2,2)}, {RotatePlayer({DisplayExtText(StrDesignX("\x04���� \x10���� 2ȣ \x07�⼮ �̺�Ʈ \x04���Դϴ�!").."\n"..StrDesignX("���� �⼮ ����(�ִ� 28ȸ) \x04: \x17ũ���� 50��, \x02??? 5��").."\n"..StrDesignX("���� 7�� �⼮ ����(�ִ� 4ȸ) \x04: \x02??? 50��"),4)}, Force1, FP)}, {preserved})
	Trigger2X(FP, {CVX(SCA.GlobalVarArr[5],4,4)}, {RotatePlayer({DisplayExtText(StrDesignX("\x04���� \x10���� 3ȣ \x07�⼮ �̺�Ʈ \x04���Դϴ�!").."\n"..StrDesignX("���� �⼮ ����(�ִ� 28ȸ) \x04: \x02���� ���� 100��").."\n"..StrDesignX("���� 7�� �⼮ ����(�ִ� 4ȸ) \x04: \x1E������ ���� 1��"),4)}, Force1, FP)}, {preserved})
	
	Trigger2X(FP, {CV(SCA.GlobalVarArr[5],0)}, {RotatePlayer({DisplayExtText(StrDesignX("\x04�⼮ �̺�Ʈ�� ����Ǿ����ϴ٤Ф�").."\n"..StrDesignX("\x04������ ����� �ּ���."),4)}, Force1, FP)}, {preserved})
	
	CIfEnd()
	
	TriggerX(FP,{CDX(SCA.GlobalLoadFlag,3,3),CD(SCA.GlobalCheck,2)},{SetCD(SCA.GlobalCheck,3)},{preserved})
	CIf(FP, {TTOR({Memory(SCA.Month, AtMost, 0),Memory(SCA.GlobalData[1],AtMost,0)}),CD(SCA.Timer,24*60,AtLeast)},{SetCD(SCA.Timer,0)})
	DoActions2X(FP, {
		RotatePlayer({PlayWAVX("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x03SYSTEM \x08ERROR \x04: \x06Global Data Load Faliure. Try Again..."), 4)}, Force1, FP),SetV(iv.Time3, 0),
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

	SCA.Loading = CreateCcodeArr(7)
	SCA.LoadJump = def_sIndex()
	CIf(FP,{CD(SCA.GlobalCheck,3)},{SetCD(SCA.Timer,0)})
	if TestStart == 1 then
		CIfX(FP,{VRange(SCA.MinV,0,59),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),VRange(SCA.WeekV, 1, 7)})
	else
		CIfX(FP,{VRange(SCA.DayV,1,31),VRange(SCA.MonthV,1,12),VRange(SCA.YearV,2023,65535),VRange(SCA.WeekV, 1, 7)})
	end
	CElseX()
	DoActions2X(FP, {
		RotatePlayer({PlayWAVX("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x03SYSTEM \x08ERROR \x04: \x06��¥ �����Ͱ� �߸��Ǿ����ϴ�. �ٽ� �ҷ��ɴϴ�."), 4)}, Force1, FP),SetV(iv.Time3, 0),
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


	for i = 0,6 do
		TriggerX(FP, {HumanCheck(i,0)}, {SetCD(SCA.Loading[i+1],0),SetCD(SCA.LoadSlot1[i+1],0)},{preserved})
		TriggerX(FP, {HumanCheck(i,1),SCA.LoadCmp(i),CD(SCA.Loading[i+1],1)}, {SetCD(SCA.LoadCheckArr[i+1],1),SetCD(SCA.Loading[i+1],0),AddCD(iv.PartyBonus,1),SetCD(SCA.GlobalCheck2,1)},{preserved})
		CTrigger(FP, {HumanCheck(i,1),SCA.Available(i)}, {SetCD(SCA.Loading[i+1],0)},{preserved})
		Trigger2X(FP, {Deaths(i, Exactly, 0x20000, 20)}, {SetCD(SCA.GReload,1)}, {preserved})
		if SlotEnable == 1 then
			Trigger2X(FP, {Deaths(i, Exactly, 0x50000, 20)}, {SetCD(SCA.LoadSlot1[i+1],1)}, {preserved}) -- ���� �������� �ʱ�ȭ
		end
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
		for i = 0,6 do
			NJumpX(FP, SCA.LoadJump, {HumanCheck(i,1),SCA.Available(i),CD(SCA.LoadCheckArr[i+1],0)}, {SetDeaths(i, SetTo, 3, 2),SetCD(SCA.Loading[i+1],1),SCA.Reset(i)})
		end
	NElseX()
		local LoadTimer = CreateCcodeArr(7) 
		local Ttable= {}
		for i = 0, 6 do
			table.insert(Ttable, SubCD(LoadTimer[i+1],1))
			CIf(FP, {HumanCheck(i,1),CD(LoadTimer[i+1],0),SCA.Available(i),CD(SCA.LoadCheckArr[i+1],0)},{SetCD(LoadTimer[i+1], 24*3)})
				CallTrigger(FP,Call_Print13[i+1])
				Trigger2X(FP, {LocalPlayerID(i)}, {print_utf8(12,0,StrDesign("\x04�ٸ� �÷��̾ \x03SCArchive \x04���� \x07���� ������\x04�� �ҷ����� �ֽ��ϴ�. ��ø� ��ٷ��ּ���."))}, {preserved})
			CIfEnd()
			
		end
		DoActions2X(FP, Ttable)
	NIfXEnd()
	NJumpXEnd(FP,SCA.LoadJump)
	CIfEnd()


	CIf(FP,{CD(InternalFlag,1)},{SetCD(InternalFlag, 0)})
	for i = 0, 6 do
		TriggerX(FP, {CD(SCA.LoadCheckArr[i+1],2),DeathsX(i, Exactly, 0,3,2)}, {SetDeathsX(i, SetTo, 2, 3,2),SetCp(i),PlayWAV("sound\\Misc\\PError.WAV"),DisplayExtText(StrDesignX("\x03SYSTEM \x08ERROR \x04: ���� �ӵ� ���ϰ� �����Ǿ����ϴ�! ��ȭ \x1C���ΰ�� ���\x04�� \x07ON \x04�Ͽ����ϴ�.").."\n"..StrDesignX("\x04�ٽ� ���� ���ϽŴٸ� ���� ���Ǳ⿡�� ����Ű X�� ���� �������ּ���."), 4),SetCp(FP)})
	end
	
	CIfEnd()
	
end