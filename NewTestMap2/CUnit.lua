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
			DisplayTextX("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);
		})
	end

	CSub(FP,0x6509B0,30)
	--0x4D 가 107 Or 10일떄 0x5C인식
	CIfX(FP, {TTOR({DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00)})},{})--홀드or공격중일때.. 23으로 감
	DoActions(FP, SetMemory(0x6509B0, Add, 4))
	CIf(FP,{Deaths(CurrentPlayer, AtLeast, 1, 0)},{})-- 대상이있을경우 일단 8로 가서 이동플래그 확인
	DoActions(FP,{SetMemory(0x6509B0, Subtract, 15)})
	-- 이동플래그가 0 또는 8일경우에만 작동
	CIf(FP,{TTOR({DeathsX(CurrentPlayer,Exactly,0,0,0xFF),DeathsX(CurrentPlayer,Exactly,8,0,0xFF)})})

		--디펜시브 값이 1이상이고 디펜타이머가 0이면 변조. 단, 이동플래그 1일경우 작동금지
		DoActions(FP, SetMemory(0x6509B0, Add, 60))--68로이동
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
				DisplayTextX("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);
			})
		end
		DoActions(FP, {SetMemory(0x6509B0, Subtract, 1)})
		CIfEnd()----
		--디펜싀브값이 0일때 디펜시브 타이머와 함께 디펜시브 방어력양을 준다.
		
		TriggerX(FP, {DeathsX(CurrentPlayer,AtMost,0,0,0xFFFF0000)},{SetDeathsX(CurrentPlayer, SetTo, 65536*256, 0, 0xFFFF0000),
		SetMemory(0x6509B0, Add, 1);
		SetDeathsX(CurrentPlayer, SetTo, 6, 0, 0xFF),
		SetMemory(0x6509B0, Subtract, 1);},{preserved})
		--디펜시브 값이 1 이상이고 공속 인식되면 디펜시브 타이머는 상시로 초기화한다.
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,65536*256,0,0xFFFF0000)},{SetMemory(0x6509B0, Subtract, 47)})
			--21로이동
			TriggerX(FP, {DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)},{--공속이 있다없다?
				--다시 디펜시브타이머인 69로 이동
				SetMemory(0x6509B0, Add, 48);
				SetDeathsX(CurrentPlayer, SetTo, 6, 0, 0xFF),--디펜타이머 초기화
				SetMemory(0x6509B0, Subtract, 48);
			},{preserved})--
			DoActions(FP, {SetMemory(0x6509B0, Add, 47)})
		CIfEnd()
		DoActions(FP, {SetMemory(0x6509B0, Subtract, 60)})
		--다시 23으로 이동----
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
		SetMemory(0x6509B0, Subtract, 49)})--홀드or공격 명령이 없으면 디펜을 0으로 돌린다
		
	CIfXEnd()--










	CSub(FP,TempV,EXCC_TempVarArr[1],EXCC_TempVarArr[2]) -- Line0 = 저장된난수 + 유닛ID Line1 = 저장된 난수
	--TempV=계산된 유닛ID
	CIfX(FP,{TMemory(UIDPtr, Exactly, TempV)})--UIDPtr == 실제 유닛ID저장된 포인터
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
		DisplayTextX("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
	end--

	CIfXEnd()--



	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
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