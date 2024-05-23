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
		TriggerX(FP,{CD(SELimit,4,AtMost)}, {AddCD(SELimit,1),RotatePlayer({PlayWAVX(SEArr[j]),PlayWAVX(SEArr[j])},HumanPlayers, FP)},{preserved})
		DisplayPrint(HumanPlayers,{"\x07『 ",PName(i),NMArr[j]})
		if EVFMode == 1 then
		CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {SetResources(i, Add, (8000)/2, Ore),AddV(CTMin[i+1],(8000)/2),SetCp(i),DisplayText(StrDesign("\x04보험금 \x1F+ 4000 Ore"), 4)}, {preserved})

		else
		CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {SetResources(i, Add, (4000)/2, Ore),AddV(CTMin[i+1],(4000)/2),SetCp(i),DisplayText(StrDesign("\x04보험금 \x1F+ 2000 Ore"), 4)}, {preserved})

		end
		f_LoadCp()
		CIfEnd()
		CIf(FP,{DeathsX(CurrentPlayer, Exactly, 20, 0, 0xFF),Switch(RandSwitch1,SW1),Switch(RandSwitch2,SW2)},{SetScore(i, Add, 2, Custom)})
		f_SaveCp()
		TriggerX(FP,{CD(SELimit,4,AtMost)}, {AddCD(SELimit,1),RotatePlayer({PlayWAVX(SEArr[j]),PlayWAVX(SEArr[j])},HumanPlayers, FP)},{preserved})
		DisplayPrint(HumanPlayers,{"\x07『 ",PName(i),HMArr[j]})
		
		if EVFMode == 1 then
		CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {SetResources(i, Add, (50000)/2, Ore),AddV(CTMin[i+1],(50000)/2),SetCp(i),DisplayText(StrDesign("\x04보험금 \x1F+ 25000 Ore"), 4)}, {preserved})

		else
		CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {SetResources(i, Add, (9500)/2, Ore),AddV(CTMin[i+1],(9500)/2),SetCp(i),DisplayText(StrDesign("\x04보험금 \x1F+ 4250 Ore"), 4)}, {preserved})

		end
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
	
	if X2_Mode==1 then
		CFor(FP, 0, 4, 1)
		CIf(FP, Memory(0x628438, AtLeast, 1))
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {CreateUnit(1, 91, 1, FP),TSetMemoryX(_Add(Nextptrs,68), SetTo, 400,0xFFFF)})
		CIfEnd()
		CForEnd()
	else
		CIf(FP, Memory(0x628438, AtLeast, 1))
		f_Read(FP, 0x628438, nil, Nextptrs)
		CDoActions(FP, {CreateUnit(1, 91, 1, FP),TSetMemoryX(_Add(Nextptrs,68), SetTo, 400,0xFFFF)})
		CIfEnd()
	end
	
	f_LoadCp()
CIfEnd()
DoActions(FP, {SetMemory(0x6509B0, Subtract, 6)})

EXCC_ClearCalc()
NJumpEnd(FP, EnemyArea)
	CIf(FP,{Cond_EXCC(1,Exactly,1)}) -- 영작유닛인식
	f_SaveCp()
	f_Read(FP, _Add(BackupCp,6), HeroIndex, nil, nil, 1)
	for j,k in pairs(UnitPointArr) do
		TriggerX(FP,{CD(SELimit,4,AtMost),CVX(HeroIndex, k[1], 0xFF)}, {AddCD(SELimit,1),RotatePlayer({
			PlayWAVX("staredit\\wav\\kill_se.wav"),
			PlayWAVX("staredit\\wav\\Computer Beep.wav"),
			PlayWAVX("staredit\\wav\\Computer Beep.wav"),},HumanPlayers, FP)},{preserved})
		Trigger2X(FP, {
			CD(UTAGECcode,0),
			CVX(HeroIndex, k[1], 0xFF)}, {
				SetScore(Force1, Add, k[2], Kills),
				RotatePlayer({
				DisplayTextX(StrDesignX("\x04적 유닛 \x03"..k[3].." \x07처치! \x1F+ "..k[2].." P t s"), 4)}, HumanPlayers, FP)},{preserved})
				
		Trigger2X(FP, {
			CD(UTAGECcode,1),
			CVX(HeroIndex, k[1], 0xFF)}, {
				SetScore(Force1, Add, k[2]*EVFPtsMul, Kills),
				RotatePlayer({
				DisplayTextX(StrDesignX("\x04적 유닛 \x03"..k[3].." \x07처치! \x1F+ "..(k[2]*EVFPtsMul).." P t s"), 4)}, HumanPlayers, FP)},{preserved})
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
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,1)}, {55,56,48,53}, {S_4,P_6,S_6,P_8}, {1,4,1,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,2)}, {51,104,56,50}, {S_5,S_6,P_6,S_8}, {1,1,4,1}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,3)}, {88,78}, {S_6,P_6}, {1,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,4)}, {21,17}, {S_5,P_5}, {1,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,5)}, {28,19}, {S_3,P_4}, {2,5}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,6)}, {98,76}, {P_6,P_7}, {3,4}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,7)}, {162,10}, {P_4,P_5}, {2,3}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,8)}, {86,79}, {S_7,P_8}, {1,4}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,9)}, {29,25}, {P_4,S_8}, {2,1}, "MAX", nil, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,0),CV(TrapNum,10)}, {23,75}, {P_3,S_3}, {1,0}, "MAX", nil, nil, nil, FP)
	
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,1)}, {55,56,48,53}, {S_4,P_6,S_6,P_8}, {1,4,1,3}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,2)}, {51,104,56,50}, {S_5,S_6,P_6,S_8}, {1,1,4,1}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,1)}, {23}, {P_3}, {5}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,2)}, {75}, {S_4}, {2}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,3)}, {88,78}, {S_6,P_6}, {3,6}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,4)}, {21,17}, {S_5,P_5}, {2,5}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,5)}, {28,19}, {S_3,P_4}, {3,6}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,6)}, {98,76}, {P_6,P_7}, {5,6}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,7)}, {162,10}, {P_4,P_5}, {6,5}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,8)}, {86,79}, {S_7,P_8}, {2,5}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,9)}, {29,25}, {P_4,P_8}, {5,6}, "MAX", 1, nil, nil, FP)
	G_CA_SetSpawn({CD(UTAGECcode,1,AtLeast),CV(TrapNum,10)}, {30}, {P_3}, {5}, "MAX", nil, nil, nil, FP)


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
	if X2_Map == 1 then
		f_TempRepeat({CD(UTAGECcode,0)}, 21, 1, 187, FP, {1536*2,1920*2})
		f_TempRepeat({CD(UTAGECcode,0)}, 88, 1, 187, FP, {1536*2,1920*2})
		f_TempRepeat({CD(UTAGECcode,1,AtLeast)}, 21, 2, 188, FP, {1536*2,1920*2})
		f_TempRepeat({CD(UTAGECcode,1,AtLeast)}, 88, 2, 188, FP, {1536*2,1920*2})
	else
		f_TempRepeat({CD(UTAGECcode,0)}, 21, 3, 187, FP, {1536,1920})
		f_TempRepeat({CD(UTAGECcode,0)}, 88, 3, 187, FP, {1536,1920})
		f_TempRepeat({CD(UTAGECcode,1,AtLeast)}, 21, 6, 188, FP, {1536,1920})
		f_TempRepeat({CD(UTAGECcode,1,AtLeast)}, 88, 6, 188, FP, {1536,1920})
	end
	CIf(FP,{CD(UTAGECcode,1,AtLeast)})
	f_Read(FP, _Sub(BackupCp,15), CPos, nil, nil, 1)
	Convert_CPosXY()
	CMov(FP,G_CA_X,CPosX)
	CMov(FP,G_CA_Y,CPosY)
	f_TempRepeat({}, 30, 1, 202, FP, nil)

	CIfEnd()
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

	
SETimer = CreateCcode()
TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SELimit),SetCDeaths(FP,SetTo,100,SETimer)},{preserved})
DoActionsX(FP,{SetCDeaths(FP,Subtract,1,SETimer)})





	CanC = CreateVar(FP)
	CanCT = CreateCcode()
	CanW = CreateVar(FP)
	DefeatCC = CreateCcode()

CIfX(FP,{CD(UTAGECcode,0)})
if X2_Mode == 0 then
	
CIf(FP,{--캔발동
Command(FP,AtLeast,1,147);
CV(CanC,1,AtMost);
CDeaths(FP,AtMost,0,CanCT);
Memory(0x628438,AtMost,0);
},{
KillUnit("Factories",Force2);
SetCDeaths(FP,SetTo,24*30,CanCT);
AddV(CanC,1);})

Trigger2X(FP,{},{
RotatePlayer({
	PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
	PlayWAVX("staredit\\wav\\canwarn.wav"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
	},HumanPlayers,FP);
},{preserved})
CIfEnd()
CIf(FP, {--캔발동
Command(FP,AtLeast,1,147);
CV(CanC,2,AtLeast);
CDeaths(FP,AtMost,0,CanCT);
Memory(0x628438,AtMost,0);
},{
AddV(CanC,1);
KillUnit("Factories",Force2);
SetCDeaths(FP,Add,1,DefeatCC);
SetCDeaths(FP,SetTo,24*30,CanCT);})

Trigger2X(FP,{},{
	RotatePlayer({
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\CanOver.ogg"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
		},HumanPlayers,FP);
},{preserved})
CIfEnd()

DoActions2X(FP,{SubCD(CanCT,1)})

CIf(FP,CD(DefeatCC,1,AtLeast))
DoActionsX(FP,{AddCD(DefeatCC,1)})
DoActions2X(FP,{RotatePlayer({
DisplayTextX(string.rep("\n", 20),4);
DisplayTextX("\x13\x04"..string.rep("―", 56),4);
DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
DisplayTextX("\n",4);
DisplayTextX("\x13\x08캔낫이 3회 이상 발동되어\n",4);
DisplayTextX("\x13\x08게임에서 패배하였습니다.",4);
DisplayTextX("\n",4);
DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
DisplayTextX("\x13\x04"..string.rep("―", 56),4);
},HumanPlayers,FP)},1)

TriggerX(FP,{CD(TestMode,0),CD(DefeatCC,100,AtLeast)},{RotatePlayer({Defeat()},MapPlayers,FP)})
CIfEnd()
end


CElseX()
if X2_Mode == 1 then
	
CIf(FP,{--캔발동
Command(FP,AtLeast,1,147);
CDeaths(FP,AtMost,0,CanCT);
Memory(0x628438,AtMost,0);
CV(CreateUnitQueueNum,5000,AtLeast)
},{
KillUnit("Factories",Force2);
SetCDeaths(FP,SetTo,24*30,CanCT);
AddV(CanW,10);
SetCp(FP);
RunAIScriptAt("Send All Units on Random Suicide Missions", 64)
})

Trigger2X(FP,{},{
RotatePlayer({
	PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
	PlayWAVX("staredit\\wav\\canwarn.wav"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
	},HumanPlayers,FP);
},{preserved})
CIfEnd()
DoActions2X(FP,{SubCD(CanCT,1)})

else
	
CIf(FP,{--캔발동
Command(FP,AtLeast,1,147);
CDeaths(FP,AtMost,0,CanCT);
Memory(0x628438,AtMost,0);
},{
KillUnit("Factories",Force2);
SetCDeaths(FP,SetTo,24*30,CanCT);
AddV(CanW,10);})

Trigger2X(FP,{},{
RotatePlayer({
	PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
	PlayWAVX("staredit\\wav\\canwarn.wav"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
	PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
	},HumanPlayers,FP);
},{preserved})
CIfEnd()
DoActions2X(FP,{SubCD(CanCT,1)})

end

CWhile(FP, {Memory(0x628438,AtLeast,1);CV(CanW,1,AtLeast)}, SubV(CanW, 1))
	--191
	if X2_Map == 1 then
		f_TempRepeat({}, 8, 1, 191, FP, {1536*2,1920*2})
	else
		if X2_Mode == 1 then
			f_TempRepeat({}, 8, 1, 191, FP, {1536,1920})
		else
			f_TempRepeat({}, 8, 3, 191, FP, {1536,1920})
		end
	end
CWhileEnd()


CIfXEnd()







if X2_Mode== 0 then
	
for i = 0, 6 do
CIf(FP,{HumanCheck(i, 1),CD(UTAGECcode,0)})
CMov(FP,0x582294+(i*4),CanC)
CAdd(FP,0x582294+(i*4),CanC)
CIfEnd()
end
end


function CreateUnitQueue()
	
	local G_CA_Nextptrs = CreateVar(FP)
	local TempUID = CreateVar(FP)
	local TempPID = CreateVar(FP)
	local TempType = CreateVar(FP)
	if Limit == 1 then
--		CIf(FP,{CD(TestMode,1)})
--		--DisplayPrintEr(0,{"\x07『 \x03TESTMODE OP \x04: CreateUnitQueuePtr : ",CreateUnitQueuePtr," || CreateUnitQueuePtr2 : ",CreateUnitQueuePtr2," \x07』"})
--		local TestV = CreateVar()
--		CMov(FP,TestV,0)
--		CFor(FP, 19025+19, 19025+19 + (84*1700), 84)
--			local CI = CForVariable()
--			CTrigger(FP, {TMemoryX(CI,AtLeast,1*256,0xFF00)}, {AddV(TestV,1)},1)
--		CForEnd()
		--DisplayPrintEr(0,{"\x07『 \x03TESTMODE OP \x04: CUnit Count : ",TestV," \x07』"})--

--		CIfEnd()
	end
	TriggerX(FP, {CV(count,1500,AtMost),CV(CreateUnitQueueNum,0)}, {
		SetInvincibility(Disable, 131, FP, 64),
		SetInvincibility(Disable, 132, FP, 64),
		SetInvincibility(Disable, 133, FP, 64),
		SetInvincibility(Disable, 150, FP, 64),
		SetInvincibility(Disable, 148, FP, 64),
	},{preserved})
	TriggerX(FP, {CV(count,1501,AtLeast)}, {
		SetInvincibility(Enable, 131, FP, 64),
		SetInvincibility(Enable, 132, FP, 64),
		SetInvincibility(Enable, 133, FP, 64),
		SetInvincibility(Enable, 150, FP, 64),
		SetInvincibility(Enable, 148, FP, 64),
	},{preserved})
	TriggerX(FP, {CV(CreateUnitQueueNum,1,AtLeast)}, {
		SetInvincibility(Enable, 131, FP, 64),
		SetInvincibility(Enable, 132, FP, 64),
		SetInvincibility(Enable, 133, FP, 64),
		SetInvincibility(Enable, 150, FP, 64),
		SetInvincibility(Enable, 148, FP, 64),
	},{preserved})
	NWhile(FP,{CV(count,1500,AtMost),Memory(0x628438,AtLeast,1),CV(CreateUnitQueueNum,1,AtLeast)},{})
	f_Read(FP,0x628438,"X",G_CA_Nextptrs,0xFFFFFF)
	f_SHRead(FP, _Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), CPosX)
	f_SHRead(FP, _Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), CPosY)
	f_SHRead(FP, _Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), TempUID)
	f_SHRead(FP, _Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), TempPID)
	f_SHRead(FP, _Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), TempType)
	CDoActions(FP, {
		TSetMemory(_Add(CreateUnitQueueXPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueYPosArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueUIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueuePIDArr,CreateUnitQueuePtr2), SetTo, 0),
		TSetMemory(_Add(CreateUnitQueueTypeArr,CreateUnitQueuePtr2), SetTo, 0)
	})
	DoActionsX(FP,{AddV(CreateUnitQueuePtr2,1),SubV(CreateUnitQueueNum,1)})
	TriggerX(FP, {CV(CreateUnitQueuePtr2,200000,AtLeast)},{SetV(CreateUnitQueuePtr2,0)},{preserved})





	NIf(FP,{CV(TempUID,1,AtLeast),CV(TempUID,226,AtMost)})
	local CRLID = CreateVar(FP)

	
	DoActions(FP,{SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random)})
	
	local LocIndex = FuncAlloc
		for i = 0, 3 do
            if i == 0 then RS1 = Cleared RS2=Cleared end
            if i == 1 then RS1 = Set RS2=Cleared end
            if i == 2 then RS1 = Cleared RS2=Set end
            if i == 3 then RS1 = Set RS2=Set end
            TriggerX(FP,{Switch(RandSwitch1,RS1),Switch(RandSwitch2,RS2)},{SetCtrig1X("X",FuncAlloc,CAddr("Mask",1),nil,SetTo,14+i),SetCtrig1X("X",FuncAlloc+1,CAddr("Mask",1),nil,SetTo,14+i)},{preserved})
        end
		TriggerX(FP,{CVar(FP,TempPID[2],Exactly,0xFFFFFFFF)},{SetCVar(FP,TempPID[2],SetTo,7)},{preserved})
		CTrigger(FP,{TTCVar(FP,TempType[2],NotSame,2)},{TCreateUnitWithProperties(1,TempUID,1,TempPID,{energy = 100})},1,LocIndex)
        CTrigger(FP,{CVar(FP,TempType[2],Exactly,2)},{TCreateUnitWithProperties(1,TempUID,1,TempPID,{energy = 100, burrowed = true})},1,LocIndex+1)
		FuncAlloc=FuncAlloc+2

		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)

		CIf(FP,{TMemoryX(_Add(G_CA_Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
		
		--CIf(FP,{TTOR({CV(TempUID,25),CV(TempUID,30)})})
		--CDoActions(FP,{
		--	TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),TSetMemoryX(_Add(G_CA_Nextptrs,68), SetTo, 600,0xFFFF)})
		--CIfEnd()

		f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,71,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(71,-4,-4,4,4)})

        CTrigger(FP,{},{TMoveUnit(1,TempUID,Force2,72,1)},{preserved})
			CIfX(FP,CVar(FP,TempType[2],Exactly,0))
				f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CTrigger(FP, {CD(UTAGECcode,0)}, {TOrder(TempUID, Force2, 1, Patrol, DefaultAttackLocV);}, {preserved})
				CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})

			CElseIfX(CVar(FP,TempType[2],Exactly,1))
			
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {CD(UTAGECcode,0)}, {TOrder(TempUID, Force2, 1, Patrol, DefaultAttackLocV);}, {preserved})
			CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})
			CDoActions(FP,{
				TSetMemory(_Add(G_CA_Nextptrs,2), SetTo, _Div(_ReadF(_Add(TempUID,EPD(0x662350))),2)),
			})

			CElseIfX(CVar(FP,TempType[2],Exactly,187))
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				})

			CElseIfX(CVar(FP,TempType[2],Exactly,189))
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TCreateUnitWithProperties(1,84,1,TempPID,{energy = 100}),TRemoveUnit(84,TempPID)
			})
			CElseIfX(CVar(FP,TempType[2],Exactly,190))
				f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CDoActions(FP,{TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,1920)})
				CDoActions(FP,{
					TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);
					TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
					TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
					
				})
			CElseIfX(CVar(FP,TempType[2],Exactly,32))
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0x04000000),
				TSetMemoryX(_Add(G_CA_Nextptrs,8), SetTo, 127*65536,0xFF0000),
				TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,20000,0),
				TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})

			CElseIfX(CVar(FP,TempType[2],Exactly,188))
				--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
				TempSpeedVar = f_CRandNum(8000)
				CDoActions(FP,{
					TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
					TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,_Add(TempSpeedVar,500),0),
					TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,_Add(TempSpeedVar,500),0,0xFFFF)})
				--CElseX()
				--CDoActions(FP,{
				--	TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,12000,0),
				--	TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})
				--CIfXEnd()
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
					TSetMemory(_Add(G_CA_Nextptrs,2), SetTo, _Div(_ReadF(_Add(TempUID,EPD(0x662350))),2)),
				})

				CElseIfX(CVar(FP,TempType[2],Exactly,191))

				--CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
				CDoActions(FP,{
					TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,4000,0),
					TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})
				--CElseX()
				--CDoActions(FP,{
				--	TSetDeaths(_Add(G_CA_Nextptrs,13),SetTo,12000,0),
				--	TSetDeathsX(_Add(G_CA_Nextptrs,18),SetTo,4000,0,0xFFFF)})
				--CIfXEnd()
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				})
			CElseIfX(CVar(FP,TempType[2],Exactly,18))
			
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
				CTrigger(FP, {CD(UTAGECcode,0)}, {TOrder(TempUID, Force2, 1, Patrol, DefaultAttackLocV);}, {preserved})
				CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})
			local RandVar = CreateVar(FP)
			CMov(FP,RandVar,0)
			for i = 0, 6 do
				DoActions(FP, {SetSwitch(RandSwitch1, Random)})
				TriggerX(FP, {HumanCheck(i, 1),Switch(RandSwitch1, Set)}, {SetVX(RandVar,2^i,2^i)}, {preserved})
			end
			CTrigger(FP,{CD(GMode,1),},{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x100,0x100); -- 클로킹
				TSetMemoryX(_Add(G_CA_Nextptrs,57),SetTo,RandVar,0xFF); -- 현재건작 유저 인식
				TSetMemoryX(_Add(G_CA_Nextptrs,73),SetTo,_Mul(RandVar,256),0xFF00); -- 현재건작 유저 인식
				TSetMemoryX(_Add(G_CA_Nextptrs,72),SetTo,255*256,0xFF00); -- 어그로풀림 방지 ( 페러사이트 )
				TSetMemoryX(_Add(G_CA_Nextptrs,72),SetTo,255*16777216,0xFF000000); -- Blind ( 개별건작유닛 계급설정 )
				TSetMemoryX(_Add(G_CA_Nextptrs,35),SetTo,1,0xFF); -- 개별건작 표식
				TSetMemoryX(_Add(G_CA_Nextptrs,35),SetTo,1*256,0xFF00);
				TSetMemoryX(_Add(G_CA_Nextptrs,70),SetTo,48*16777216,0xFF000000); -- 개별건작 타이머

			},{preserved})


			CElseIfX(CVar(FP,TempType[2],Exactly,147))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TOrder(TempUID, Force2, 1, Attack, 23);
				TSetMemory(_Add(G_CA_Nextptrs,13),SetTo,128),
				TSetMemoryX(_Add(G_CA_Nextptrs,18),SetTo,128,0xFFFF),
				TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),
				CreateUnit(1,84,1,FP),KillUnit(84,FP)
			})

			CElseIfX(CVar(FP,TempType[2],Exactly,3))
				CDoActions(FP,{
					TSetDeathsX(_Add(G_CA_Nextptrs,72),SetTo,0xFF*256,0,0xFF00)})
			CElseIfX(CVar(FP,TempType[2],Exactly,84))
			CDoActions(FP,{
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0xA00000,0xA00000),KillUnit(84,FP)
			})

			CElseIfX(CVar(FP,TempType[2],Exactly,201))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CDoActions(FP,{
				TSetDeathsX(_Add(G_CA_Nextptrs,19),SetTo,187*256,0,0xFF00),
				TSetMemoryX(_Add(G_CA_Nextptrs,55),SetTo,0x04000000,0x04000000),
				TOrder(TempUID, Force2, 1, Move, 36);
			})
			CElseIfX(CVar(FP,TempType[2],Exactly,202))
			f_Read(FP,_Add(G_CA_Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-4,-4,4,4)})
			CTrigger(FP, {CD(UTAGECcode,0)}, {TOrder(TempUID, Force2, 1, Patrol, DefaultAttackLocV);}, {preserved})
			CTrigger(FP, {CD(UTAGECcode,1,AtLeast)}, {TOrder(TempUID, Force2, 1, Attack, DefaultAttackLocV);}, {preserved})
			
			CMov(FP,CunitIndex,_Div(_Sub(G_CA_Nextptrs,19025),_Mov(84)))
			CDoActions(FP, {Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)})

			CElseIfX(CVar(FP,TempType[2],Exactly,2))
			CElseX()
				DoActions(FP,RotatePlayer({DisplayTextX("\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』",4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
			CIfXEnd()
			--Simple_SetLocX(FP,0,G_CA_BackupX,G_CA_BackupY,G_CA_BackupX,G_CA_BackupY,{Simple_CalcLoc(0,-4,-4,4,4)})
			--CDoActions(FP,{TOrder(TempUID,Force2,72,Attack,1)})
			
		CIfEnd()



	Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)




	



	NIfEnd()

	NWhileEnd()
	
FixText(FP, 1)
DisplayPrint(HumanPlayers,{"\x07『 \x04CreateUnit\x07Queue \x04: ",CreateUnitQueueNum," / \x08200,000 \x07』"})
FixText(FP, 2)
end




end