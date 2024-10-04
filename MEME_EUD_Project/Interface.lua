function Interface()
	
Cunit2 = CreateVar(FP)
count = CreateVar(FP)
f_Read(FP, 0x6283F0, count)
CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 4 do
		CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),})
		if Limit == 1 then
			
			f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		end

	end
CIfXEnd()


--rigger { -- When the unit's death number reaches 2, the cannot trigger activates.
--	players = {P1, P2, P3, P4, P5},
--	conditions = {
--		Memory(0x628438,Exactly,0);
--	},
--	actions = {
--		PreserveTrigger();
--		Defeat();
--		DisplayText("\x13Cannot activates and you lose.", 0);
--		Comment("When the unit's death number reaches 2, the cannot trigger activates.");
--	},
--

CanC = CreateVar(FP)
CanCT = CreateCcode()
CanCT = CreateCcode()


CIf(FP,{--캔발동
	CV(CanC,0,AtMost);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	SetCDeaths(FP,SetTo,24*30,CanCT);
	AddV(CanC,1);})
Trigger2X(FP,{},{
	RotatePlayer({
		DisplayTextX("\x13\x08캔낫 \x041회 \x07감지\x04. \x08캔낫 2회 \x04이후에는 \x11패널티\x04가 존재합니다.", 0);
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\warn.wav"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
		},HumanPlayers,FP);
},{preserved})
CIfEnd()

CIf(FP,{--캔발동
	CV(CanC,1,Exactly);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	SetCDeaths(FP,SetTo,24*30,CanCT);
	AddV(CanC,1);})
Trigger2X(FP,{},{
	RotatePlayer({
		DisplayTextX("\x13\x08캔낫 \x042회 \x07감지\x04. 보유중인\x07 포인트\x04를 \x08몰수합니다\x04.", 0);
		PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
		PlayWAVX("staredit\\wav\\warn.wav"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
		PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
		},HumanPlayers,FP);
		SetScore(Force1, SetTo, 0, Kills);
},{preserved})
CIfEnd()
CIfOnce(FP, {--캔발동
	CV(CanC,2,AtLeast);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	AddV(CanC,1);
	SetCDeaths(FP,SetTo,24*30,CanCT);})

	Trigger2X(FP,{},{
		RotatePlayer({
			DisplayTextX("\x13\x08캔낫 \x043회 \x07감지\x04. \x11벙커\x04를 \x08몰수합니다\x04.", 0);
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\CanOver.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
			},HumanPlayers,FP);
			KillUnit(125, Force1);
			
	})
CIfEnd()

CIfOnce(FP, {--캔발동
	CV(CanC,3,AtLeast);
	CDeaths(FP,AtMost,0,CanCT);
	Memory(0x628438,AtMost,0);
},{
	KillUnit(37,Force2);
	KillUnit(38,Force2);
	KillUnit(39,Force2);
	KillUnit(41,Force2);
	KillUnit(42,Force2);
	KillUnit(43,Force2);
	KillUnit(44,Force2);
	KillUnit(48,Force2);
	KillUnit(53,Force2);
	KillUnit(54,Force2);
	KillUnit(55,Force2);
	KillUnit(56,Force2);
	AddV(CanC,1);
	SetCDeaths(FP,SetTo,24*30,CanCT);})

	Trigger2X(FP,{},{
		RotatePlayer({
			DisplayTextX("\x13\x08캔낫\x04 \x044회 감지. \x08ㄴrㄱr", 0);
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			PlayWAVX("staredit\\wav\\why.ogg"),
			},HumanPlayers,FP);
			RotatePlayer({Defeat()}, Force1, FP)
			
	})
CIfEnd()
for i = 0, 4 do
	CIf(FP,{HumanCheck(i, 1)})
	CMov(FP,0x5821A4+(i*4),8)
	CMov(FP,0x582144+(i*4),8)
	CMov(FP,0x582174+(i*4),CanC)
	CAdd(FP,0x582174+(i*4),CanC)
	CMov(FP,0x582264,1500*2)
	CMov(FP,0x5822C4,1500*2)
	CMov(FP,0x582294,count)
	CAdd(FP,0x582294,count)
	CIfEnd()
end



DoActions2X(FP,{SubCD(CanCT,1)})


MacroWarn = "\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n"..StrDesignX("\x08매크로 또는 핵이 감지되었습니다.").."\n"..StrDesignX("\x08패널티로 모든 미네랄, 유닛 몰수, 무한 찌릿찌릿이 제공됩니다.").."\n\n\x14\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x0D\x0D\x13\x04"
BanCode2 = CreateCcodeArr(5)
WarnCT = CreateVarArr(5, FP)
for i = 0, 3 do
	CIf(FP,HumanCheck(i,1),SubV(WarnCT[i+1],1))
	--if Limit == 1 then
	--	local APM1,APM2,APM3 = CreateVars(3, FP) 
	--	CIf(FP,Memory(DtoA(i, 135), AtLeast, 1))
	--	f_Read(FP, DtoA(i, 135), APM1, nil, nil, 1)
	--	CIfEnd()
	--	CIf(FP,Memory(DtoA(i, 136), AtLeast, 1))
	--	f_Read(FP, DtoA(i, 136), APM2, nil, nil, 1)
	--	CIfEnd()
	--	CIf(FP,Memory(DtoA(i, 137), AtLeast, 1))
	--	f_Read(FP, DtoA(i, 137), APM3, nil, nil, 1)
	--	CIfEnd()
	--	DisplayPrintEr(i, {"아픔감지기 : 1. ",APM1,"  2. ",APM2,"  3. ",APM3})
	--end
	
	--TriggerX(FP, {Deaths(i,AtLeast,1,140),CV(WarnC[i+1],0)},{SetV(WarnCT[i+1],24*30),SetV(WarnC[i+1],1),SetCp(i),,,DisplayText(MacroWarn, 4)})
	
	--TriggerX(FP, {Deaths(i,AtLeast,1,140),CV(WarnC[i+1],1),CV(WarnCT[i+1],0,AtMost)},{SetCD(BanCode2[i+1],1)})

	TriggerX(FP, {Deaths(i,AtLeast,1,140)},{SetCD(BanCode2[i+1],1)})
	TriggerX(FP, {CD(BanCode2[i+1],1)}, {
		SetMemory(0x59CC78, SetTo, -1048576),
		SetMemory(0x59CC80, SetTo, 2),SetCp(i),PlayWAV("staredit\\wav\\zzirizziri.ogg"),PlayWAV("staredit\\wav\\zzirizziri.ogg"),DisplayText(MacroWarn, 4),SetCp(FP),SetResources(i, SetTo, 0, Ore),ModifyUnitEnergy(All, "Men", i, 64, 0),ModifyUnitEnergy(All, "Buildings", i, 64, 0),RemoveUnit("Men", i),RemoveUnit(203, i),RemoveUnit(125, i)},{preserved})

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			LocalPlayerID(i);
			CD(BanCode2[i+1],1)
		},
		actions = {
			SetCtrigX("X",0xFFFD,0x4,0,SetTo,"X",0xFFFD,0x0,0,1);
		},
		flag = {preserved}
	}
	CIfOnce(FP,{CDeaths(FP,AtLeast,1,BanCode2[i+1])})
	DisplayPrint(HumanPlayers, {"\x13",PName(i),"\x04가 매크로를 사용하여 \x08찌리리릿 500배 \x04당하셨습니다."}, nil, {"staredit\\wav\\zzirizziri.ogg","staredit\\wav\\zzirizziri.ogg","staredit\\wav\\zzirizziri.ogg"})
	CIfEnd()
		--	local WAVT = {}
	--	for k = 0, 9 do
	--		table.insert(WAVT,PlayWAVX("sound\\Protoss\\ARCHON\\PArDth00.WAV"))
	--		table.insert(WAVT,DisplayTextX(StrDesign("\x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동."),4))
	--	end
	--		Trigger2X(FP,{CDeaths(FP,AtLeast,1,BanCode2[i+1]);Memory(0x57F1B0, Exactly, i)},{RotatePlayer(WAVT,i,i),SetMemory(0xCDDDCDDC,SetTo,1);})

	CIfEnd()
	--PlayWAV("sound\\Bullet\\TNsFir00.wav");
end






TriggerX(FP,{Command(P7,AtLeast,50,42)},{RemoveUnitAt(1, 42, 64, P7)},{preserved})
TriggerX(FP,{Command(P8,AtLeast,50,42)},{RemoveUnitAt(1, 42, 64, P8)},{preserved})

if Limit == 1 then
	CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
	CIf(FP,CD(TestMode,1)) -- 테스트 트리거


	
--for i = 0, 1699 do
--	TriggerX(FP,{ -- 테스트모드 무한스팀
--		DeathsX(EPDF(0x628298-0x150*i+(25*4)),Exactly,20,0,0xFF); -- EPD 35 Unused 0x8C
--	},
--	{
--		SetDeathsX(EPDF(0x628298-0x150*i+(69*4)),SetTo,255*256,0,0xFF00); -- \
--	},{preserved})
--end

	
	CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
	CIfOnce(FP,Deaths(CurrentPlayer,AtLeast,1,208))
	CMov(FP,0x6509B0,19025+9) --CUnit 시작지점 +19 (0x4C)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+9 + (84*1699)),{SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000),SetMemory(0x6509b0,Add,84)})
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	CIfEnd()

		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Deaths(CurrentPlayer,AtLeast,1,204); -- KillAll
			},
			actions = {
				KillUnit("Men",Force2);
				PreserveTrigger();
			}
			}
		TestUPtr = CreateVar(FP)
		--CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{TCreateUnit(12, 20, _Add(CurrentOP,65), CurrentOP)},{preserved}) -- CreateMarine
		--CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{SetV(TestUPtr,Cunit2)},{preserved})
		--CIf(FP,{CVar(FP,TestUPtr[2],AtLeast,1),CVar(FP,TestUPtr[2],AtMost,0x7FFFFFFF)})
		--	CDoActions(FP,{TSetMemoryX(_Add(CurrentOP,EPD(0x57f120)),SetTo,_Div(_Read(_Add(TestUPtr,19)),256),0xFF)})
		--CIfEnd()

		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7FFFFFFF)})
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,207)})-- 207 KillUnitSelected
				CMov(FP,0x6509B0,Cunit2,25)
				CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
					MoveCp(Add,15*4);
					--SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000);
					MoveCp(Subtract,21*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
				},1)
			CIfEnd()

			CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,203)}) -- KillUnitOnceSelectedWithSetDeaths
				CMov(FP,0x6509B0,Cunit2,25)
				f_SaveCp()
				TestUID = CreateVar(FP)
				TestP = CreateVar(FP)
				f_Read(FP,BackupCp,TestUID,nil,0xFF,1)
				f_Read(FP,_Sub(BackupCp,6),TestP,nil,0xFF,1)
				CDoActions(FP,{TSetMemory(_Add(_Mul(TestUID,12),TestP),Add,1)})
				f_LoadCp()
				CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
				},1)
			CIfEnd()
			
			CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
			CMov(FP,0x6509B0,Cunit2,19)
			f_SaveCp()
			CDoActions(FP,{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(_Read(BackupCp),65536),0xFF000000)})
			f_LoadCp()
		CIfEnd()
	CIfEnd()

	CMov(FP,0x6509B0,FP)--상위플레이어 단락
			end


	






end