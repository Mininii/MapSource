function LeaderBoardF()
    
	local LeaderBoardT = CreateCcode()
	local Gun_TempRand = CreateVar(FP)
    CIf(FP,{CD(OPJump,1)})
		
    for i = 0, 3 do
        TriggerX(FP,{PlayerCheck(i,0),CDeaths(FP,AtMost,0,LeaderBoardT);},{
			SetCp(4+i),RunAIScriptAt(JYD,2+i)
        },{Preserved})
        TriggerX(FP,{PlayerCheck(i,1),CDeaths(FP,AtMost,0,LeaderBoardT);},{
			Order("Factories",4+i,64,Attack,2+i)
        },{Preserved})
        TriggerX(FP,{PlayerCheck(i,0)},{
			RemoveUnit(35,4+i),RemoveUnit(42,4+i)
        },{Preserved})
--        TriggerX(FP,{PlayerCheck(i,0),CDeaths(FP,AtMost,0,LeaderBoardT);},{
--            Order("Factories",P5+i,11+i,Attack,64),--Ʈ���� �νĻ� Factories ó�� ���ֵ鸸 �̵���Ŵ
--        },{Preserved})
--        TriggerX(FP,{PlayerCheck(i,1),CDeaths(FP,Exactly,300,LeaderBoardT);},{
--            Order("Factories",P5+i,11+i,Attack,64),--Ʈ���� �νĻ� Factories ó�� ���ֵ鸸 �̵���Ŵ
--        },{Preserved})
    end

	CIf(FP,{ElapsedTime(AtLeast,60),CDeaths(FP,Exactly,0,LeaderBoardT),},{})-- �������� Ÿ�̸Ӱ� �ֱ������� ��Ȯ�� 0�� ��� �������� ����
	CMov(FP,0x6509B0,19025+19) --CUnit �������� +19 (0x4C)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	
	CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
		DoActions(FP,MoveCp(Subtract,17*4))
		Trigger {
			players = {FP},
			conditions = {
				Deaths(CurrentPlayer,AtMost,0,0);
			},
			actions = {
				SetDeaths(CurrentPlayer,Add,256*1,0); -- Ȥ�ø��� �־�� �������� �˻�Ʈ����. ����ִµ� ü���� 0�ΰ� 1�� �ø�
				PreserveTrigger();
			}
		}
		DoActions(FP,MoveCp(Add,17*4))
		


		CIf(FP,{TTOR({ -- ��ǻ�� ������ ����� ���� ����ϰ� ���� ��� 2, 3, 156, 160 �װ����� ��� Ÿ������ ������. �̸� ���� �����ߵ�
		DeathsX(CurrentPlayer,Exactly,2*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,3*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,156*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,187*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,157*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,158*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,159*256,0,0xFF00),
		DeathsX(CurrentPlayer,Exactly,160*256,0,0xFF00),
	})})
			DoActions(FP,MoveCp(Add,6*4))
			local Check_Hero = def_sIndex()
			for j, k in pairs(HeroPointArr) do
				NJumpX(FP,Check_Hero,DeathsX(CurrentPlayer,Exactly,k[2],0,0xFF))
			end
			f_SaveCp()
			CIf(FP,{TMemoryX(_Add(BackupCp,15),AtLeast,150*16777216,0xFF000000)}) -- ������ ���� �ȳ��� ��쿡 ����� ���� �ʵ��� ������.
	
			local TargetRotation = CreateVar(FP)
			local TargerXY = CreateVarArr(2,FP)
			local CurXY = CreateVar(FP)
			CMov(FP,TargetRotation,_Read(_Sub(BackupCP,6)),-4,0xFF)
			for i = 0, 3 do
				CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i),PlayerCheck(i,0)})
				local L_Gun_Order = def_sIndex()
				NJumpXEnd(FP,L_Gun_Order)
				DoActions(FP,{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
				TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetV(Gun_TempRand,0)},{Preserved})
				TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetV(Gun_TempRand,1)},{Preserved})
				TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetV(Gun_TempRand,2)},{Preserved})
				TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetV(Gun_TempRand,3)},{Preserved})
				for j = 0, 3 do
				NJumpX(FP,L_Gun_Order,{CVar(FP,Gun_TempRand[2],Exactly,j),PlayerCheck(j,0)}) -- Ÿ�� ���� �� �÷��̾ ���� ��� �ٽ� ������
				end
				CMov(FP,TargetRotation,Gun_TempRand)
				CIfEnd()
			end
			local TargetArr = { {160,144},{3936,144},{160,3952},{3936,3952} }
			
			
			for i = 0, 3 do
				CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i)}) -- ������ Ÿ���� �跰 ��ǥ�� ������
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
	Trigger { -- ų ����Ʈ ��������, ����ó ���� ������Ű��, ���� ȸ��, ���۸� ����� ���ö�
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
	Trigger { -- ���� ���ھ� ��������
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
	Trigger { -- ų ���ھ� ��������
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