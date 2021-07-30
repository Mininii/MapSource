function LeaderBoardTFunc()
	local LeaderBoardT = CreateCCode()
	local DifTextArr = {"\x0EＥａｓｙ","\x0FＮｏｒｍａｌ","\x08Ｈａｒｄ","\x10Ｉｎｓａｎｅ"}
	for i = 1, 4 do
		CIf(FP,{Switch("Switch 240",Set),CVar(FP,Diff,Exactly,i-1)})
		
	Trigger { -- 킬 포인트 리더보드, 집근처 유닛 오더시키기, 쉴드 회복, 저글링 히드라 어택땅
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Kills, "\x07[ \x1DP\x04oints\x07 ] \x04- "..DifTextArr[i]);
			LeaderBoardComputerPlayers(Disable);
			SetCDeaths(FP,SetTo,600,LeaderBoardT);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
		},
	}
	Trigger { -- 데스 스코어 리더보드
		players = {FP},
		conditions = {
			Label(0);
			
			CDeaths(FP,Exactly,400,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Custom, "\x07[ \x08D\x04eaths\x07 ] \x04- "..DifTextArr[i]);
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
	},
	}
	Trigger { -- 데스 스코어 리더보드
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,400,LeaderBoardT);
			CVar(FP,count[2],AtLeast,1500);
		},
		actions = {
			SetInvincibility(Disable,"Any unit",P9,64);
			PreserveTrigger();
	},
	}
	Trigger { -- 킬 스코어 리더보드
		players = {FP},
		conditions = {
			Label(0);
			
			CDeaths(FP,Exactly,200,LeaderBoardT);
		},
		actions = {
			LeaderBoardKills("Any unit","\x07[ \x11K\x04ills\x07 ] \x04- "..DifTextArr[i]);
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
	},
	}
	CIfEnd()
end

CIf(FP,{CDeaths(FP,Exactly,200,LeaderBoardT),Bring(FP,AtLeast,1,147,64)})-- 리더보드 타이머가 주기적으로 정확히 200일 경우 내린 명령이 없어 멈춰있는 유닛에 명령을 내리는 코드. 오버마인드 존재해야함
CMov(FP,0x6509B0,19025+19) --CUnit 시작지점 +19 (0x4C)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))

CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,7,0,0xFF)})
	DoActions(FP,MoveCp(Subtract,17*4))
	Trigger {
		players = {FP},
		conditions = {
			Deaths(CurrentPlayer,AtMost,0,0);
		},
		actions = {
			SetDeaths(CurrentPlayer,Add,256*1,0); -- 혹시몰라서 넣어둔 좀비유닛 검사트리거. 살아있는데 체력이 0인거 1로 올림
			PreserveTrigger();
		}
	}
	DoActions(FP,MoveCp(Add,17*4))
	CIf(FP,{TTOR({ -- 컴퓨터 유닛은 명령이 없어 대기하고 있을 경우 2, 3, 156, 160 네가지의 명령 타입으로 설정됨. 이를 전부 잡아줘야됨
		DeathsX(CurrentPlayer,Exactly,2*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,3*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,156*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,160*256,0,0xFF00),
	})})
		DoActions(FP,MoveCp(Add,6*4))
		local Check_Hero = def_sIndex()
		for j, k in pairs(HeroArr) do
			NJumpX(FP,Check_Hero,DeathsX(CurrentPlayer,Exactly,k,0,0xFF))
		end
		f_SaveCp()


		
	local L_Gun_Order = def_sIndex()
	NJumpXEnd(FP,L_Gun_Order)
	f_Mod(FP,Gun_TempRand,_Rand(),_Mov(7))
	for i = 0, 6 do
		NJumpX(FP,L_Gun_Order,{CVar(FP,Gun_TempRand[2],Exactly,i),PlayerCheck(i,0)}) -- 타겟 설정 시 플레이어가 없을 경우 다시 연산함
	end
	CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
	for i = 0, 6 do
		CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)}) -- 설정된 타겟의 배럭 좌표를 가져옴
			CMov(FP,TempBarPos,BarPos[i+1])
		CIfEnd()
	end
	CIfEnd()
		CIf(FP,{TMemoryX(_Add(BackupCp,15),AtLeast,150*16777216,0xFF000000)}) -- 막혀서 유닛 안나올 경우에 명령이 들어가지 않도록 설정함. 이거안하면 캔낫 제한 줄어들면서 맵이 망가짐
		CDoActions(FP,{
			TSetDeathsX(_Sub(BackupCp,6),SetTo,14*256,0,0xFF00), -- 명령 발싸
			TSetDeaths(_Sub(BackupCp,3),SetTo,TempBarPos,0),
		})
		CIfEnd()
		local HeroPointCheck = def_sIndex() 
		CJump(FP,HeroPointCheck)
		NJumpXEnd(FP,Check_Hero) -- 영웅유닛들 도착 지점. 영작유닛인지 아닌지 체크한 후 영작유닛이 아니면 명령을 내림
		f_SaveCp()
		local TempCPCheck = CreateVar()
		CMov(FP,TempCPCheck,_Sub(BackupCp,(25+19025))) 
		f_Div(FP,TempCPCheck,_Mov(84)) -- 해당유닛의 인덱스가 몇번인지 체크함
		NJumpX(FP,L_Gun_Order,{TMemory(_Add(_Mul(TempCPCheck,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),AtMost,0)}) -- 영작유닛이 아닐 경우 위쪽의 명령주는 트리거로 점프함.
		CJumpEnd(FP,HeroPointCheck)
		f_LoadCp()
		DoActions(FP,MoveCp(Subtract,6*4))
	CIfEnd()
CIfEnd()
CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
CIfEnd()
TriggerX(FP,{Switch("Switch 240",Set)},{SetCDeaths(FP,Add,1,IntroT),SetCDeaths(FP,Subtract,1,LeaderBoardT)},{Preserved})
end
