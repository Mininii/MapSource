function LeaderBoardTFunc()
	local LeaderBoardT = CreateCCode()
	local DifTextArr = {"\x0E�ţ���","\x0F�Σ�����","\x08�ȣ���","\x10�ɣ�����"}
	for i = 1, 4 do
		CIf(FP,{Switch("Switch 240",Set),CVar(FP,Diff,Exactly,i-1)})
		
	Trigger { -- ų ����Ʈ ��������, ����ó ���� ������Ű��, ���� ȸ��, ���۸� ����� ���ö�
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
	Trigger { -- ���� ���ھ� ��������
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
	Trigger { -- ���� ���ھ� ��������
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
	Trigger { -- ų ���ھ� ��������
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

CIf(FP,{CDeaths(FP,Exactly,200,LeaderBoardT),Bring(FP,AtLeast,1,147,64)})-- �������� Ÿ�̸Ӱ� �ֱ������� ��Ȯ�� 200�� ��� ���� ����� ���� �����ִ� ���ֿ� ����� ������ �ڵ�. �������ε� �����ؾ���
CMov(FP,0x6509B0,19025+19) --CUnit �������� +19 (0x4C)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))

CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,7,0,0xFF)})
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
		NJumpX(FP,L_Gun_Order,{CVar(FP,Gun_TempRand[2],Exactly,i),PlayerCheck(i,0)}) -- Ÿ�� ���� �� �÷��̾ ���� ��� �ٽ� ������
	end
	CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
	for i = 0, 6 do
		CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)}) -- ������ Ÿ���� �跰 ��ǥ�� ������
			CMov(FP,TempBarPos,BarPos[i+1])
		CIfEnd()
	end
	CIfEnd()
		CIf(FP,{TMemoryX(_Add(BackupCp,15),AtLeast,150*16777216,0xFF000000)}) -- ������ ���� �ȳ��� ��쿡 ����� ���� �ʵ��� ������. �̰ž��ϸ� ĵ�� ���� �پ��鼭 ���� ������
		CDoActions(FP,{
			TSetDeathsX(_Sub(BackupCp,6),SetTo,14*256,0,0xFF00), -- ��� �߽�
			TSetDeaths(_Sub(BackupCp,3),SetTo,TempBarPos,0),
		})
		CIfEnd()
		local HeroPointCheck = def_sIndex() 
		CJump(FP,HeroPointCheck)
		NJumpXEnd(FP,Check_Hero) -- �������ֵ� ���� ����. ������������ �ƴ��� üũ�� �� ���������� �ƴϸ� ����� ����
		f_SaveCp()
		local TempCPCheck = CreateVar()
		CMov(FP,TempCPCheck,_Sub(BackupCp,(25+19025))) 
		f_Div(FP,TempCPCheck,_Mov(84)) -- �ش������� �ε����� ������� üũ��
		NJumpX(FP,L_Gun_Order,{TMemory(_Add(_Mul(TempCPCheck,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),AtMost,0)}) -- ���������� �ƴ� ��� ������ ����ִ� Ʈ���ŷ� ������.
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
