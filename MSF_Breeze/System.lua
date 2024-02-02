function System()

	
	NMArr = {
	"\x04의 마린\x04이 산책하다가 \x08발을 삐끗했습니다... \x07』",
	"\x04의 마린\x04이 \x08벌에 쏘였습니다... \x07』",
	"\x04의 마린\x04이 산들바람을 이기지 못하고 \x08날라갔습니다... \x07』",
	"\x04의 마린\x04이 \x08뱀에게 물렸습니다... \x07』"}
	HMArr = {
	"\x04의 \x1B영웅마린\x04이 산책하다가 \x08발을 삐끗했습니다... \x07』",
	"\x04의 \x1B영웅마린\x04이 \x08벌에 쏘였습니다... \x07』",
	"\x04의 \x1B영웅마린\x04이 산들바람을 이기지 못하고 \x08날라갔습니다... \x07』",
	"\x04의 \x1B영웅마린\x04이 \x08뱀에게 물렸습니다... \x07』"}
	SEArr = {
	"staredit\\wav\\die_se1.wav",
	"staredit\\wav\\die_se2.wav",
	"staredit\\wav\\die_se3.wav",
	"staredit\\wav\\die_se4.wav"}


	HeroIndex = CreateVar(FP)
	PlayerArea = def_sIndex()
	EnemyArea = def_sIndex()
	EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
NJump(FP, PlayerArea, {DeathsX(CurrentPlayer, AtMost, 6, 0, 0xFF)})
NJump(FP, EnemyArea, {DeathsX(CurrentPlayer, AtLeast, 7, 0, 0xFF)})


	
EXCC_ClearCalc()
NJumpEnd(FP, PlayerArea)


for i = 0, 6 do
	CIf(FP,{DeathsX(CurrentPlayer, Exactly, i, 0, 0xFF)},{SetMemory(0x6509B0, Add, 6),SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random)})

	for j = 1, 4 do
		local SW1 = Cleared
		local SW2 = Cleared
		if j == 2 then SW1 = Set end if j == 3 then SW2 = Set end if j==4 then SW1 = Set SW2 = Set end
		CIf(FP,{DeathsX(CurrentPlayer, Exactly, 0, 0, 0xFF),Switch(RandSwitch1,SW1),Switch(RandSwitch2,SW2)},{SetScore(i, Add, 1, Custom)})
		f_SaveCp()
		DoActions2(FP, {RotatePlayer({PlayWAVX(SEArr[j]),PlayWAVX(SEArr[j])},HumanPlayers, FP)})
		DisplayPrint(HumanPlayers,{"\x07『 ",PName(i),NMArr[j]})
		f_LoadCp()
		CIfEnd()
		CIf(FP,{DeathsX(CurrentPlayer, Exactly, 20, 0, 0xFF),Switch(RandSwitch1,SW1),Switch(RandSwitch2,SW2)},{SetScore(i, Add, 2, Custom)})
		f_SaveCp()
		DoActions2(FP, {RotatePlayer({PlayWAVX(SEArr[j]),PlayWAVX(SEArr[j])},HumanPlayers, FP)})
		DisplayPrint(HumanPlayers,{"\x07『 ",PName(i),HMArr[j]})
		f_LoadCp()
		CIfEnd()
		
	end

	DoActions(FP, {SetMemory(0x6509B0, Subtract, 6)})
	CIfEnd()
	
end

DoActions(FP, {SetMemory(0x6509B0, Add, 6)})
CIf(FP,{CD(GMode,1),Command(FP,AtLeast,1,90),TTOR({
	DeathsX(CurrentPlayer, Exactly, 0, 0, 0xFF),DeathsX(CurrentPlayer, Exactly, 20, 0, 0xFF)
})})
	f_SaveCp()
	f_Read(FP, _Sub(BackupCp,15), CPos, nil, nil, 1)
	Convert_CPosXY()
	Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
	DoActions(FP, {CreateUnit(1, 91, 1, FP)})
	f_LoadCp()
CIfEnd()
DoActions(FP, {SetMemory(0x6509B0, Subtract, 6)})

EXCC_ClearCalc()
NJumpEnd(FP, EnemyArea)
	CIf(FP,{Cond_EXCC(1,Exactly,1)}) -- 영작유닛인식
	f_SaveCp()
	f_Read(FP, _Add(BackupCp,6), HeroIndex, nil, nil, 1)
	for j,k in pairs(UnitPointArr) do
		Trigger2X(FP, {CVX(HeroIndex, k[1], 0xFF)}, {SetScore(Force1, Add, k[2], Kills),RotatePlayer({PlayWAVX("staredit\\wav\\kill_se.wav"),PlayWAVX("staredit\\wav\\Computer Beep.wav"),PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX(StrDesignX("\x04적 유닛 \x03"..k[3].." \x07처치! \x1F+ "..k[2].." P t s"), 4)}, HumanPlayers, FP)},{preserved})
	end
	f_LoadCp()
	CIfEnd()
	EXCC_BreakCalc({CD(GMode,0)})
	CIf(FP,{Cond_EXCC(2,AtLeast,1)}) -- 함정건물인식
	TrapNum = EXCC_TempVarArr[3] -- V
	f_SaveCp()
	f_Read(FP, _Sub(BackupCp,9), CPos, nil, nil, 1)
	Convert_CPosXY()
	CMov(FP,G_CA_X,CPosX)
	CMov(FP,G_CA_Y,CPosY)
	G_CA_SetSpawn({CV(TrapNum,1)}, {55,56,48,53}, {S_4,P_6,S_6,P_8}, {1,4,1,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,2)}, {51,104,56,50}, {S_5,S_6,P_6,S_8}, {1,1,4,1}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,3)}, {88,78}, {S_6,P_6}, {1,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,4)}, {21,17}, {S_5,P_5}, {1,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,5)}, {28,19}, {S_3,P_4}, {2,5}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,6)}, {98,76}, {P_6,P_7}, {3,4}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,7)}, {162,10}, {P_4,P_5}, {2,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,8)}, {86,79}, {S_7,P_8}, {1,4}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,9)}, {29,25}, {P_4,S_8}, {2,1}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CV(TrapNum,10)}, {23,75}, {P_3,S_3}, {1,0}, "MAX", nil, nil, nil, FP)
	DoActions2(FP, {RotatePlayer({PlayWAVX("staredit\\wav\\warn.ogg"),PlayWAVX("staredit\\wav\\warn.ogg"),PlayWAVX("staredit\\wav\\warn.ogg")}, HumanPlayers, FP)})


	f_LoadCp()
	CIfEnd()
	CAdd(FP,0x6509B0,6)
	
	CIf(FP,{TTOR({
		DeathsX(CurrentPlayer,Exactly,134,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,135,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,136,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,137,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,138,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,139,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,140,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,141,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,142,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,149,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,176,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,177,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,178,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,143,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,144,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,146,0,0xFF),
	})})
	f_SaveCp()
	f_TempRepeat({}, 21, 2, 187, FP, {1536,1920})
	f_TempRepeat({}, 88, 2, 187, FP, {1536,1920})
	f_LoadCp()
	
	CIfEnd()
EXCC_ClearCalc()
	EXCC_Part2()
	EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
		DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
		DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
		},
		{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
		--SetDeathsX(19025+(84*i)+9,SetTo,0*65536,0,0xFF0000),
		SetDeathsX(19025+(84*i)+35,SetTo,0,0,0xFF); -- 
		MoveCp(Add,19*4),
		SetCVar(FP,CurCunitI2[2],SetTo,i)
		})
	end
	EXCC_End()


end