function LeaderBoardF()
    
	local LeaderBoardT = CreateCcode()
    CIf(FP,{CD(OPJump,1)})
	TriggerX(FP,ElapsedTime(AtMost,(60*3)-1),{
		SetMemoryW(0x656380+(14*2),SetTo,255),
		SetMemoryW(0x656380+(17*2),SetTo,255)
	},{preserved}) -- 스웜인스 사용제한
	TriggerX(FP,ElapsedTime(AtLeast,(60*3)),{
		SetMemoryW(0x656380+(14*2),SetTo,100),
		SetMemoryW(0x656380+(17*2),SetTo,75)
	},{preserved}) -- 스웜인스 사용제한
	
    for i = 0, 3 do
        TriggerX(FP,{HumanCheck(i,0),CDeaths(FP,AtMost,0,LeaderBoardT);},{
			SetCp(4+i),RunAIScriptAt(JYD,2+i)--32
        },{preserved})
        TriggerX(FP,{HumanCheck(i,1),ElapsedTime(AtLeast,60*3),CDeaths(FP,AtMost,0,LeaderBoardT);},{
			Order("Factories",4+i,64,Attack,2+i)
        },{preserved})
        TriggerX(FP,{HumanCheck(i,0)},{
			RemoveUnit(35,4+i),RemoveUnit(42,4+i)
        },{preserved})
--        TriggerX(FP,{HumanCheck(i,0),CDeaths(FP,AtMost,0,LeaderBoardT);},{
--            Order("Factories",P5+i,11+i,Attack,64),--트리거 인식상 Factories 처리 유닛들만 이동시킴
--        },{preserved})
--        TriggerX(FP,{HumanCheck(i,1),CDeaths(FP,Exactly,300,LeaderBoardT);},{
--            Order("Factories",P5+i,11+i,Attack,64),--트리거 인식상 Factories 처리 유닛들만 이동시킴
--        },{preserved})
    end

	CIf(FP,{Command(FP,AtLeast,1,190),TTOR({CD(TestMode,1),TTAND({ElapsedTime(AtLeast,60*5),CD(TestMode,0)})})
		,CDeaths(FP,Exactly,0,LeaderBoardT)},{})-- 리더보드 타이머가 주기적으로 정확히 0일 경우 저그유닛 어택
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
--		DeathsX(CurrentPlayer,Exactly,187*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,157*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,158*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,159*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,160*256,0,0xFF00),
	})})
			local L_Gun_Order = def_sIndex()
			local TargetRotation = CreateVar(FP)
			local TargetUID = CreateVar(FP)
			local TargerXY = CreateVarArr(2,FP)
			local CurXY = CreateVar(FP)
			DoActions(FP,MoveCp(Add,6*4))
			local Check_Hero = def_sIndex()
			for j, k in pairs(HeroPointArr) do
				NJumpX(FP,Check_Hero,DeathsX(CurrentPlayer,Exactly,k[2],0,0xFF))
			end
			f_SaveCp()
			NJumpXEnd(FP,L_Gun_Order)
			CMov(FP,TargetUID,_Read(BackupCp),nil,0xFF)
			CMov(FP,TargetRotation,_Read(_Sub(BackupCp,6)),nil,0xFF)
			NIf(FP,{TMemoryX(_Add(BackupCp,15),AtLeast,150*16777216,0xFF000000)}) -- 막혀서 유닛 안나올 경우에 명령이 들어가지 않도록 설정함.
	
			for i = 0, 3 do
				CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i+4),HumanCheck(i,0)})
				DoActions(FP,{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
				TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,4)},{preserved})
				TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,5)},{preserved})
				TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetV(TargetRotation,6)},{preserved})
				TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetV(TargetRotation,7)},{preserved})
				CIfEnd()
			end
			for j = 0, 3 do
			NJumpX(FP,L_Gun_Order,{CVar(FP,TargetRotation[2],Exactly,j+4),HumanCheck(j,0)}) -- 타겟 설정 시 플레이어가 없을 경우 다시 연산함
			end
			local TargetArr = { {160,144},{3936,144},{160,3952},{3936,3952} }
			
			
			for i = 0, 3 do
				CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i+4)}) -- 설정된 타겟의 배럭 좌표를 가져옴
					CMov(FP,TargerXY[1],TargetArr[i+1][1],2)
					CMov(FP,TargerXY[2],TargetArr[i+1][2],2)
				CIfEnd()
			end
				f_Read(FP,_Sub(BackupCp,15),CurXY)
				CurX,CurY = Convert_CPosXY(CurXY,1)
				Simple_SetLocX(FP,9,TargerXY[1],TargerXY[2],TargerXY[1],TargerXY[2])
				Simple_SetLocX(FP,0,CurX,CurY,CurX,CurY)
				CDoActions(FP,{TOrder(TargetUID,Force2,1,Attack,10)})
				HeroOrder = def_sIndex()
				CJump(FP,HeroOrder)
				NJumpXEnd(FP,Check_Hero)
				f_SaveCp()
				local TempCPCheck = CreateVar()
				CMov(FP,TempCPCheck,_Sub(BackupCp,(25+19025))) 
				f_Div(FP,TempCPCheck,_Mov(84)) -- 해당유닛의 인덱스가 몇번인지 체크함
				NJumpX(FP,L_Gun_Order,{Cond_EXCC2(DUnitCalc,TempCPCheck,1,AtMost,0)})
				NJumpX(FP,L_Gun_Order,{Cond_EXCC2(DUnitCalc,TempCPCheck,1,AtLeast,2),CD(Theorist,0)})
				CJumpEnd(FP,HeroOrder)
				
			NIfEnd()
			f_LoadCp()
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



TriggerX(FP,{},{SetCDeaths(FP,Subtract,1,LeaderBoardT),SetCDeaths(FP,Subtract,1,SETimer),},{preserved})
end