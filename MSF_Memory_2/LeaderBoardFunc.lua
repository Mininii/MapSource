function LeaderBoardF()
    
	local LeaderBoardT = CreateCcode()
    local CurAttackP = CreateCcode()

    CIf(FP,{CD(OPJump,1)})
		
    for i = 0, 3 do
--        TriggerX(FP,{PlayerCheck(i,0),CDeaths(FP,AtMost,0,LeaderBoardT);},{
--            Order("Factories",P5+i,11+i,Attack,64),--트리거 인식상 Factories 처리 유닛들만 이동시킴
--        },{Preserved})
--        TriggerX(FP,{PlayerCheck(i,1),CDeaths(FP,Exactly,300,LeaderBoardT);},{
--            Order("Factories",P5+i,11+i,Attack,64),--트리거 인식상 Factories 처리 유닛들만 이동시킴
--        },{Preserved})
    end

	CIf(FP,{ElapsedTime(AtLeast,60*10),CDeaths(FP,Exactly,150,LeaderBoardT),})-- 리더보드 타이머가 주기적으로 정확히 200일 경우 내린 명령이 없어 멈춰있는 유닛에 명령을 내리는 코드. 오버마인드 존재해야함
	CMov(FP,0x6509B0,19025+19) --CUnit 시작지점 +19 (0x4C)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
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
			for j, k in pairs(HeroPointArr) do
				NJumpX(FP,Check_Hero,DeathsX(CurrentPlayer,Exactly,k[2],0,0xFF))
			end
			f_SaveCp()
			CIf(FP,{TMemoryX(_Add(BackupCp,15),AtLeast,150*16777216,0xFF000000)}) -- 막혀서 유닛 안나올 경우에 명령이 들어가지 않도록 설정함.
	
			local L_Gun_Order = def_sIndex()
			local TargetRotation = CreateVar(FP)
			local TargerXY = CreateVarArr(2,FP)
			local CurXY = CreateVar(FP)
			local TargetArr = { {160,144},{3936,144},{160,3952},{3936,3952} }
			
			NJumpXEnd(FP,L_Gun_Order)
			for i = 0, 3 do
				TriggerX(FP,{CVar(FP,TargetRotation[2],Exactly,i),PlayerCheck(i,0)},{AddV(TargetRotation,1)},{Preserved}) -- 타겟 설정 시 플레이어가 없을 경우 타겟번호+1
			end
			TriggerX(FP,{CV(TargetRotation,4,AtLeast)},{SetV(TargetRotation,0)},{Preserved}) -- 타겟번호가 4 이상일 경우 0으로 재설정
			for i = 0, 3 do
				CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i)}) -- 설정된 타겟의 배럭 좌표를 가져옴
					CMov(FP,TargerXY[1],TargetArr[i+1][1],2)
					CMov(FP,TargerXY[2],TargetArr[i+1][2],2)
				CIfEnd()
			end
				f_Read(FP,_Sub(BackupCP,15),CurXY)
				CurX,CurY = Convert_CPosXY(CurXY,2)
				Simple_SetLocX(FP,9,TargerXY[1],TargerXY[2],TargerXY[1],TargerXY[2])
				Simple_SetLocX(FP,0,CurX,CurY,CurX,CurY)
				DoActions(FP,Order("Factories",Force2,1,Attack,10))
			CIfEnd()
			f_LoadCp()
			NJumpXEnd(FP,Check_Hero)
			DoActions(FP,MoveCp(Subtract,6*4))
		CIfEnd()
	CIfEnd()


	CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	CIfEnd()
	Trigger { -- 킬 포인트 리더보드, 집근처 유닛 오더시키기, 쉴드 회복, 저글링 히드라 어택땅
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Kills, StrDesign("\x1DP\x04oints\x07"));
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
			LeaderBoardScore(Custom,StrDesign("\x08D\x04eath \x10C\x04ounts"));
			LeaderBoardComputerPlayers(Disable);
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
			LeaderBoardKills("Any unit",StrDesign("\x11K\x04ills\x07"));
			LeaderBoardComputerPlayers(Disable);
			PreserveTrigger();
	},
	}
	CIfEnd()



TriggerX(FP,{},{SetCDeaths(FP,Subtract,1,LeaderBoardT),SetCDeaths(FP,Subtract,1,SETimer),},{Preserved})
end