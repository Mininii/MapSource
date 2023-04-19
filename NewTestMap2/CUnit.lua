function CUnit()
    
if TestStart == 1 then
--	CFor(FP, 19025+19, 19025+19+(84*1699), 84)
--	local CI = CForVariable()
--	CMov(FP,0x6509B0,CI)
--	TriggerX(FP, {DeathsX(FP,Exactly,0,0,0xFF)}, {
--		SetMemory(0x6509B0, Add, 2),
--		SetDeaths(CurrentPlayer,SetTo,0,0),
--		SetDeathsX(CurrentPlayer,SetTo,0,1,0xFF00),
--		SetMemory(0x6509B0, Subtract, 2)
--	}, {preserved})
--	CForEnd()
end

DoActionsX(FP, {AddV(iv.CUnitT,1)})
CTEPD = CreateVar(FP)
UIDPtr =  CreateVar(FP)
PIDPtr =  CreateVar(FP)
CurCunitI2 = CreateVar(FP)
CIf(FP,CV(iv.CUnitT,36,AtLeast),{SetV(iv.CUnitT,0)})
CTKillT = {}
for i = 1, 40 do
table.insert(CTKillT,KillUnitAt(All, LevelUnitArr[i][2], 152, Force1))
end
for i = 0, 6  do
	table.insert(CTKillT,KillUnitAt(All, PersonalUIDArr[i+1], 152, Force1))
end
DoActions(FP, CTKillT)
	EXCC_Part1(CT_Cunit)
	CIf(FP,{DeathsX(CurrentPlayer, AtMost, 6, 0, 0xFF)})
	CAdd(FP,0x6509B0,6)
	CIf(FP,{DeathsX(CurrentPlayer, NotSame, 47, 0, 0xFF)})
	CAdd(FP,0x6509B0,30)

	local TempV = CreateVar(FP)
	local TempV2 = CreateVar(FP)
	if TestStart ==1 then
		CIf(FP,{DeathsX(CurrentPlayer,Exactly,0x00000004,0 ,0x00000004 )})

		f_SaveCp()
		local TempUID = CreateVar(FP)
		CMov(FP,TempUID,_ReadF(UIDPtr,0xFF),nil,0xFF,1)
		CMov(FP,CPos,_ReadF(_Sub(BackupCp,45)))
		Convert_CPosXY()
		DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
		f_LoadCp()
		CIfEnd()
	else
		TriggerX(FP, {DeathsX(CurrentPlayer,Exactly,0x00000004,0 ,0x00000004 )}, {RotatePlayer({
			PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
			DisplayExtText("a\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);
		})
	end

	CSub(FP,0x6509B0,30)
	CIfEnd()
	CSub(FP,0x6509B0,6)
	CIfEnd()

--	--0x4D 가 107 Or 10일떄 0x5C인식
--	CIfX(FP, {TTOR({DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00)})},{})--홀드or공격중일때.. 23으로 감
--	DoActions(FP, SetMemory(0x6509B0, Add, 4))
--	CIf(FP,{Deaths(CurrentPlayer, AtLeast, 1, 0)},{})-- 대상이있을경우 일단 8로 가서 이동플래그 확인
--	DoActions(FP,{SetMemory(0x6509B0, Subtract, 15)})
--	-- 이동플래그가 0 또는 8일경우에만 작동
--	CIf(FP,{TTOR({DeathsX(CurrentPlayer,Exactly,0,0,0xFF),DeathsX(CurrentPlayer,Exactly,8,0,0xFF)})})--

--		--디펜시브 값이 1이상이고 디펜타이머가 0이면 변조. 단, 이동플래그 1일경우 작동금지
--		DoActions(FP, SetMemory(0x6509B0, Add, 60))--68로이동
--		--디펜시브 값이 0이고 
--		CIf(FP,{DeathsX(CurrentPlayer,AtMost,0,0,0xFFFF0000)},{SetMemory(0x6509B0, Subtract, 47)})
--			--21로이동
--			TriggerX(FP, {DeathsX(CurrentPlayer,AtLeast,2*256,0,0xFF00)},{--공속이 2이상이면?--

--				SetMemory(0x6509B0, Add, 46);
--				SetDeathsX(CurrentPlayer, SetTo, 65536*256, 0, 0xFFFF0000),--디펜 방어력 초기화
--				SetMemory(0x6509B0, Add, 1);
--				SetDeathsX(CurrentPlayer, SetTo, 25, 0, 0xFF),--디펜타이머 초기화
--				SetMemory(0x6509B0, Subtract, 47);
--			},{preserved})--
--			DoActions(FP, {SetMemory(0x6509B0, Add, 47)})
--		CIfEnd()
--		if TestStart ==1 then
--            f_SaveCp()
--            local TempUID = CreateVar(FP)
--            local TempV1 = CreateVar(FP)
--            local TempV2 = CreateVar(FP)
--            local TempV3 = CreateVar(FP)
--            local TempV4 = CreateVar(FP)
--            CMov(FP,TempV2,_ReadF(BackupCp),nil,0xFFFF0000,1)
--            CMov(FP,TempV3,_ReadF(_Add(BackupCp,1)),nil,0xFF,1)
--            CMov(FP,TempUID,_ReadF(UIDPtr,0xFF),nil,0xFF,1)
--            CMov(FP,TempV1,_ReadF(_Sub(UIDPtr,6)),nil,0xFF00,1)
--            CMov(FP,TempV4,_ReadF(_Sub(UIDPtr,17)),nil,0xFF,1)
--            f_Div(FP,TempV1,256)
--            DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  OrderID : ",TempV1,"  ","DefValue : ",TempV2,"   DefTimer : ",TempV3, "   MoveMentFlag : ",TempV4})--
--            f_LoadCp()
--		else
--		end
--		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,65536*256,0,0xFFFF0000)},{SetMemory(0x6509B0, Add, 1)})----디펜방어력 존재하는데 디펜타이머가 기준치 미달일경우
--		if TestStart ==1 then
--			CIf(FP,{DeathsX(CurrentPlayer,AtMost,3,0,0xFF)})
--				
--				f_SaveCp()
--				local TempUID = CreateVar(FP)
--				CMov(FP,TempUID,_ReadF(UIDPtr,0xFF),nil,0xFF,1)
--				CMov(FP,CPos,_ReadF(_Sub(BackupCp,15)))
--				Convert_CPosXY()
--				DisplayPrint(Force1, {"\x13\x04핵감지! CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
--				f_LoadCp()
--			CIfEnd()
--		else
--			TriggerX(FP, {DeathsX(CurrentPlayer,AtMost,0,0,0xFF)}, {RotatePlayer({
--				PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
--				DisplayExtText("\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);
--			})
--		end
--		DoActions(FP, {SetMemory(0x6509B0, Subtract, 1)})
--		CIfEnd()------

--		DoActions(FP, {SetMemory(0x6509B0, Subtract, 60)})
--		--다시 23으로 이동----
--		CIfEnd()
--		DoActions(FP,{SetMemory(0x6509B0, Add, 15)})
--	CIfEnd()
--	DoActions(FP, {SetMemory(0x6509B0, Subtract, 4)})
--	
--	CElseX({})
--		DoActions(FP, {SetMemory(0x6509B0, Add, 49),
--		SetDeathsX(CurrentPlayer, SetTo, 0, 0, 0xFFFF0000),
--		SetMemory(0x6509B0, Add, 1);
--		SetDeathsX(CurrentPlayer, SetTo, 0, 0, 0xFF),
--		SetMemory(0x6509B0, Subtract, 1);
--		SetMemory(0x6509B0, Subtract, 49)})--홀드or공격 명령이 없으면 디펜을 0으로 돌린다
--		
--	CIfXEnd()--










	CSub(FP,TempV,EXCC_TempVarArr[1],EXCC_TempVarArr[2]) -- Line0 = 저장된난수 + 유닛ID Line1 = 저장된 난수
	CSub(FP,TempV2,EXCC_TempVarArr[3],EXCC_TempVarArr[2]) -- Line2 = 저장된난수 + PlayerID Line1 = 저장된 난수
	--TempV=계산된 유닛ID
	CIfX(FP,{TMemoryX(UIDPtr, Exactly, TempV,0xFF)})--UIDPtr == 실제 유닛ID저장된 포인터
	CDoActions(FP, {Set_EXCCX(0,SetTo,_Add(TempV,CT_GNextRandV)),Set_EXCCX(1, SetTo, CT_GNextRandV)})
	CElseX()
	if TestStart == 1 then
		f_SaveCp()
		local TempUID = CreateVar(FP)
		CMov(FP,TempUID,_ReadF(UIDPtr,0xFF),nil,0xFF,1)
		CMov(FP,CPos,_ReadF(_Sub(BackupCp,15)))
		Convert_CPosXY()
		DisplayPrint(Force1, {"\x13\x04CurUID : ",TempUID,"  CT_CUnit : ",TempV,"  ","X : ",CPosX,"   Y : ",CPosY})--
		f_LoadCp()
	else
	TriggerX(FP,{},{RotatePlayer({
		PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayExtText("i\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
	end--

	CIfXEnd()--
		--TempV=계산된 유닛ID
	CIfX(FP,{TMemoryX(PIDPtr, Exactly, TempV2,0xFF)})--UIDPtr == 실제 유닛ID저장된 포인터
	CDoActions(FP, {Set_EXCCX(2,SetTo,_Add(TempV2,CT_GNextRandV)),Set_EXCCX(1, SetTo, CT_GNextRandV)})
	CElseX()
	if TestStart == 1 then
		f_SaveCp()
		local TempPID = CreateVar(FP)
		CMov(FP,TempPID,_ReadF(PIDPtr,0xFF),nil,0xFF,1)
		CMov(FP,CPos,_ReadF(_Sub(BackupCp,15)))
		Convert_CPosXY()
		DisplayPrint(Force1, {"\x13\x04CurPID : ",TempPID,"  CT_CUnit : ",TempV2,"  ","X : ",CPosX,"   Y : ",CPosY})--
		f_LoadCp()
	else
	TriggerX(FP,{},{RotatePlayer({
		PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayExtText("p\x13\x07『 \x04당신은 SCA 시스템에서 핵유저로 의심되어 강퇴당했습니다.\x07 』",4);},Force1,FP),SetMemory(0xCDDDCDDC,SetTo,1);})
	end--

	CIfXEnd()--



	EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
			DeathsX(19025+(84*i)+19,AtMost,7,0,0xFF),
		},
		{MoveCp(Add,19*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i),--SetResources(P1,Add,1,Gas)
		SetCVar(FP,UIDPtr[2],SetTo,19025+(84*i)+25),--SetResources(P1,Add,1,Gas)--
		SetCVar(FP,PIDPtr[2],SetTo,19025+(84*i)+19),--SetResources(P1,Add,1,Gas)--
		})
	end
	EXCC_End()
CIfEnd()


end