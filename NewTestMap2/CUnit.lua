function CUnit()
    
CTEPD = CreateVar(FP)
UIDPtr =  CreateVar(FP)
CurCunitI2 = CreateVar(FP)


	EXCC_Part1(CT_Cunit)
	CAdd(FP,0x6509B0,30)

	local TempV = CreateVar(FP)
	if TestStart ==1 then
		CIf(FP,{DeathsX(CurrentPlayer,Exactly,0x00000004,0 ,0x00000004 )})

		f_SaveCp()
		local TempUID = CreateVar(FP)
		CMov(FP,TempUID,_Read(UIDPtr,0xFF),nil,0xFF,1)
		CMov(FP,CPos,_Read(_Sub(BackupCp,45)))
		Convert_CPosXY()
		DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
		f_LoadCp()
		CIfEnd()
	else
		TriggerX(FP, {DeathsX(CurrentPlayer,Exactly,0x00000004,0 ,0x00000004 )}, {RotatePlayer({
			PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayTextX("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);
		})
	end

	CSub(FP,0x6509B0,30)
	--0x4D �� 107 Or 10�ϋ� 0x5C�ν�
	CIfX(FP, {TTOR({DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00)})},{})--Ȧ��or�������϶�.. 23���� ��
	DoActions(FP, SetMemory(0x6509B0, Add, 4))
	CIf(FP,{Deaths(CurrentPlayer, AtLeast, 1, 0)},{})-- ������������ �ϴ� 8�� ���� �̵��÷��� Ȯ��
	DoActions(FP,{SetMemory(0x6509B0, Subtract, 15)})
	-- �̵��÷��װ� 0 �Ǵ� 8�ϰ�쿡�� �۵�
	CIf(FP,{TTOR({DeathsX(CurrentPlayer,Exactly,0,0,0xFF),DeathsX(CurrentPlayer,Exactly,8,0,0xFF)})})

		--����ú� ���� 1�̻��̰� ����Ÿ�̸Ӱ� 0�̸� ����. ��, �̵��÷��� 1�ϰ�� �۵�����
		DoActions(FP, SetMemory(0x6509B0, Add, 60))--68���̵�
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,65536*256,0,0xFFFF0000)},{SetMemory(0x6509B0, Add, 1)})----
		if TestStart ==1 then
			CIf(FP,{DeathsX(CurrentPlayer,AtMost,0,0,0xFF)})
				
				f_SaveCp()
				local TempUID = CreateVar(FP)
				CMov(FP,TempUID,_Read(UIDPtr,0xFF),nil,0xFF,1)
				CMov(FP,CPos,_Read(_Sub(BackupCp,15)))
				Convert_CPosXY()
				DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
				f_LoadCp()
			CIfEnd()
		else
			TriggerX(FP, {DeathsX(CurrentPlayer,AtMost,0,0,0xFF)}, {RotatePlayer({
				PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayTextX("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);
			})
		end
		DoActions(FP, {SetMemory(0x6509B0, Subtract, 1)})
		CIfEnd()----
		--����ú갪�� 0�϶� ����ú� Ÿ�̸ӿ� �Բ� ����ú� ���¾��� �ش�.
		
		TriggerX(FP, {DeathsX(CurrentPlayer,AtMost,0,0,0xFFFF0000)},{SetDeathsX(CurrentPlayer, SetTo, 65536*256, 0, 0xFFFF0000),
		SetMemory(0x6509B0, Add, 1);
		SetDeathsX(CurrentPlayer, SetTo, 6, 0, 0xFF),
		SetMemory(0x6509B0, Subtract, 1);},{preserved})
		--����ú� ���� 1 �̻��̰� ���� �νĵǸ� ����ú� Ÿ�̸Ӵ� ��÷� �ʱ�ȭ�Ѵ�.
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,65536*256,0,0xFFFF0000)},{SetMemory(0x6509B0, Subtract, 47)})
			--21���̵�
			TriggerX(FP, {DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)},{--������ �ִپ���?
				--�ٽ� ����ú�Ÿ�̸��� 69�� �̵�
				SetMemory(0x6509B0, Add, 48);
				SetDeathsX(CurrentPlayer, SetTo, 6, 0, 0xFF),--����Ÿ�̸� �ʱ�ȭ
				SetMemory(0x6509B0, Subtract, 48);
			},{preserved})--
			DoActions(FP, {SetMemory(0x6509B0, Add, 47)})
		CIfEnd()
		DoActions(FP, {SetMemory(0x6509B0, Subtract, 60)})
		--�ٽ� 23���� �̵�----
		CIfEnd()
		DoActions(FP,{SetMemory(0x6509B0, Add, 15)})
	CIfEnd()
	DoActions(FP, {SetMemory(0x6509B0, Subtract, 4)})
	
	CElseX({})
		DoActions(FP, {SetMemory(0x6509B0, Add, 49),
		SetDeathsX(CurrentPlayer, SetTo, 0, 0, 0xFFFF0000),
		SetMemory(0x6509B0, Add, 1);
		SetDeathsX(CurrentPlayer, SetTo, 0, 0, 0xFF),
		SetMemory(0x6509B0, Subtract, 1);
		SetMemory(0x6509B0, Subtract, 49)})--Ȧ��or���� ������ ������ ������ 0���� ������
		
	CIfXEnd()--










	CSub(FP,TempV,EXCC_TempVarArr[1],EXCC_TempVarArr[2]) -- Line0 = ����ȳ��� + ����ID Line1 = ����� ����
	--TempV=���� ����ID
	CIfX(FP,{TMemory(UIDPtr, Exactly, TempV)})--UIDPtr == ���� ����ID����� ������
	CDoActions(FP, {Set_EXCCX(0,SetTo,_Add(TempV,CT_GNextRandV)),Set_EXCCX(1, SetTo, CT_GNextRandV)})
	CElseX()
	if TestStart == 1 then
		f_SaveCp()
		local TempUID = CreateVar(FP)
		CMov(FP,TempUID,_Read(UIDPtr,0xFF),nil,0xFF,1)
		CMov(FP,CPos,_Read(_Sub(BackupCp,15)))
		Convert_CPosXY()
		DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
		f_LoadCp()
	else
	TriggerX(FP,{},{RotatePlayer({
		PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayTextX("\x13\x07�� \x04����� SCA �ý��ۿ��� �������� �ǽɵǾ� ������߽��ϴ�.\x07 ��",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
	end--

	CIfXEnd()--



	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X �� Cunit Loop (x1700)
		EXCC_Part4X(i,{
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,19*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i),--SetResources(P1,Add,1,Gas)
		SetCVar(FP,UIDPtr[2],SetTo,19025+(84*i)+25),--SetResources(P1,Add,1,Gas)--
		})
	end
	EXCC_End()

end