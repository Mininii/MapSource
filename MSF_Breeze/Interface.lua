function Interface()
	local DelayMedic = CreateCcodeArr(7)
	local GiveRate = CreateCcodeArr(7)
	local BanCode = CreateCcodeArr(6)
	local CurrentOP = CreateVar(FP)
	function Install_UnitCount(Player)
		count,count1,count2,count3,count4,count5 = CreateVars(6,FP)
			UnitReadX(Player,AllPlayers,229,64,count)
			UnitReadX(Player,AllPlayers,17,nil,count1)
			UnitReadX(Player,AllPlayers,23,nil,count2)
			UnitReadX(Player,AllPlayers,25,nil,count3)
			UnitReadX(Player,AllPlayers,73,nil,count4)
			UnitReadX(Player,AllPlayers,65,nil,count5)
			CAdd(FP,count,count1)
			CAdd(FP,count,count2)
			CAdd(FP,count,count3)
			CAdd(FP,count,count4)
			CAdd(FP,count,count5)
	end
	Install_UnitCount(FP)

	IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\BrOP.ogg",215*1000},
		{2,"staredit\\wav\\BGM1.ogg",81*1000},
		{3,"staredit\\wav\\BGM2.ogg",76*1000},
		{4,"staredit\\wav\\BGM3.ogg",66*1000},
		{5,"staredit\\wav\\BGM4.ogg",98*1000},
	})
	
	DoActionsX(FP, {SetV(BGMType,1)},1)
	OPCcode = CreateCcode()
	DoActionsX(FP, {AddCD(OPCcode,1)})
	Trigger2X(FP,{CD(OPCcode,1,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX(StrDesignX("\x04�ɽ��� �������� �α��� �������� ��å������� �ߴ�."))}, HumanPlayers, FP)})
	Trigger2X(FP,{CD(OPCcode,150,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX(StrDesignX("\x08�ƴϱٵ� ���ǿ� ���׵��� ���̷��� ����???"))}, HumanPlayers, FP)})
	Trigger2X(FP,{CD(OPCcode,300,AtLeast)},{RotatePlayer({PlayWAVX("staredit\\wav\\Computer Beep.wav"),DisplayTextX(StrDesignX("\x04�������� ����ߴ�. �� �� \x08���׳���� �Ӹ����� ���������� ������ ���ư��ڰ�!"))}, HumanPlayers, FP)})
	Trigger2X(FP,{CD(OPCcode,450,AtLeast)},{RotatePlayer({PlayWAVX("sound\\Misc\\TRescue.wav"),DisplayTextX(StrDesignX("\x04�¸� ���� : ��� ���׸� óġ�ϰ� 6���� �ʿ�ü�� �ı��ϼ���."))}, HumanPlayers, FP)})
	
    CIfX(FP,Never()) -- �����÷��̾� �ܶ� ����
	for i = 0, 6 do
        CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),GiveUnits(All, 115,AllPlayers, 64, i)})

	end
    CIfXEnd()




for i = 1, 6 do -- ������
	Trigger { -- ������ū
		players = {FP},
		conditions = {
			Label(0);
			Command(Force1,AtLeast,1,BanToken[i]);
		},
		actions = {
			RemoveUnitAt(1,BanToken[i],"Anywhere",Force1);
			SetCDeaths(FP,Add,1,BanCode[i]);
			PreserveTrigger();
			},
		}
		for j = 1, 4 do
			Trigger { -- ������ū
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,Exactly,j,BanCode[i]);
				},
				actions = {
					RotatePlayer({DisplayTextX("\x07�� "..PlayerString[i+1].."\x04���� \x08����� �� "..j.."ȸ ����\x04 �Ǿ����ϴ�. �� 5ȸ ������ \x08���� ó�� \x04�˴ϴ�. \x07��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
					},
				}
		end
		Trigger { -- ����
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,5,BanCode[i]);
		},
		actions = {
			RotatePlayer({DisplayTextX("\x07�� \x04"..PlayerString[i+1].."\x04�� ����ó���� �Ϸ�Ǿ����ϴ�.\x07 ��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
			},
		}
		Trigger { -- ���� ���
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanCode[i]);Memory(0x57F1B0, Exactly, i)
				
			},
			actions = {
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				DisplayText("\x07�� \x04����� ���Ǵ��߽��ϴ�. ��� �ڵ� 0x32223223 �۵�.\x07 ��",4);
				SetMemory(0xCDDDCDDC,SetTo,1);
				
				},
			}
			
		
		end

	local ExchangeP = CreateVar(FP)
	for i = 0, 6 do
		DoActions(i, {SetSwitch(RandSwitch1,Random),SetSwitch(RandSwitch2,Random),SetCp(i)})
		local DeathCond
		local DeathAct
		if i == 0 then
			DeathCond = NVar(MarValue,AtLeast,1);
			DeathAct = SetNVar(MarValue,Subtract,1);
		else
			DeathCond = Deaths(i, AtLeast, 1, 0)
			DeathAct = SetDeaths(i, Subtract, 1, 0)
		end
		DeathCond2 = Deaths(i, AtLeast, 1, 20)
		DeathAct2 = SetDeaths(i, Subtract, 1, 20)
		
		for j = 1, 4 do
			local SW1 = Cleared
			local SW2 = Cleared
			if j == 2 then SW1 = Set end if j == 3 then SW2 = Set end if j==4 then SW1 = Set SW2 = Set end

			Trigger2X(i,{DeathCond,Switch(RandSwitch1,SW1),Switch(RandSwitch2,SW2)},{RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..ColorCode[i+1].."NM"..(j).._0D,4)}, HumanPlayers, FP),DeathAct,SetScore(i, Add, 1, Custom)},{preserved})
			Trigger2X(i,{DeathCond2,Switch(RandSwitch1,SW1),Switch(RandSwitch2,SW2)},{RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..ColorCode[i+1].."HM"..(j).._0D,4)}, HumanPlayers, FP),DeathAct2,SetScore(i, Add, 2, Custom)},{preserved})
			
		end

		CIf(FP,HumanCheck(i,1))
		
			CMov(FP,0x582174+(4*i),count)
			CAdd(FP,0x582174+(4*i),count)
		ExJump = def_sIndex()
		NJump(FP,ExJump,{Deaths(i,AtMost,0,111),Bring(i,AtMost,0,"Men",3),Bring(i,AtMost,0,"Men",4)})
		CIf(FP,Score(i,Kills,AtLeast,1000))
		CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),_Mov(10)))--���� 10%
		CMov(FP,ExchangeP,0)
		CIfEnd()
		DoActions(FP,SetDeaths(i,Subtract,1,111))
		
		NJumpEnd(FP,ExJump)

		DoActions(i,{
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
			SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
		})





		for j = 0, 3 do
		TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1])},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{preserved})
		TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
			DisplayText(DelayMedicT[j+1],4),
			SetCDeaths(FP,Add,1,DelayMedic[i+1]),
			GiveUnits(All,72,i,"Anywhere",P12),
			ModifyUnitEnergy(1,72,P12,64,0);
			--SetCDeaths(FP,Add,1,CUnitRefrash);
			RemoveUnitAt(1,72,"Anywhere",P12)},{preserved})
		end
		TriggerX(i,{CDeaths(FP,AtLeast,4,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,4,DelayMedic[i+1])},{preserved})
	
		local MedicTrigJump = def_sIndex()
		for j = 1, 4 do
				NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{})
		end
		
			NIf(FP,Never())
				NJumpXEnd(FP,MedicTrigJump)
					DoActionsX(FP,{
						ModifyUnitEnergy(All,MedicTrig[1],i,64,0);
						ModifyUnitEnergy(All,MedicTrig[2],i,64,0);
						ModifyUnitEnergy(All,MedicTrig[3],i,64,0);
						ModifyUnitEnergy(All,MedicTrig[4],i,64,0);
						--SetCDeaths(FP,Add,1,CUnitRefrash);
						RemoveUnit(MedicTrig[1],i),
						RemoveUnit(MedicTrig[2],i),
						RemoveUnit(MedicTrig[3],i),
						RemoveUnit(MedicTrig[4],i),
						ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
						ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
						ModifyUnitShields(All,"Men",i,"Anywhere",100),
						ModifyUnitShields(All,"Buildings",i,"Anywhere",100),
					})
			NIfEnd()
	
		CIfEnd()
		
		Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,3);},{
			GiveUnits(All,3,i,"Anywhere",P12);
			RemoveUnitAt(All,3,"Anywhere",P12);
			DisplayText("\x07�� \x1CBGM\x04�� ���� �ʽ��ϴ�. \x07��",4);
			SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
		},{preserved})

		Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,3);},{
			GiveUnits(All,3,i,"Anywhere",P12);
			RemoveUnitAt(All,3,"Anywhere",P12);
			DisplayText("\x07�� \x1CBGM\x04�� ����ϴ�. \x07��",4);
			SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
		},{preserved})

		for k = 0, 5 do
			Trigger { -- ��� �ݾ� ����
				players = {i},
				conditions = {
					Label(0);
					CDeaths(FP,Exactly,k,GiveRate[i+1]);
					Command(i,AtLeast,1,"Protoss Reaver");
				},
				actions = {
					GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",11);
					RemoveUnitAt(All,"Protoss Reaver","Anywhere",11);
					DisplayText(GiveRateT[k+1],4);
					SetCDeaths(FP,Add,1,GiveRate[i+1]);
					PreserveTrigger();
					},
			}
		end
	TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{preserved})

		
	Trigger { -- �ڵ�ȯ��
	players = {i},
	conditions = {
		Command(i,AtLeast,1,"Terran Firebat");
	},
	actions = {
		ModifyUnitEnergy(1,"Terran Firebat",i,64,0);
		RemoveUnitAt(1,"Terran Firebat","Anywhere",i);
		SetDeaths(i,SetTo,1,"Terran Barracks");
		DisplayText(StrDesign("\x07�ڵ�ȯ��\x04�� ����ϼ̽��ϴ�."),4);
		--SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
}


Trigger { -- ���� ��������
players = {i},
conditions = {
	Label(0);
	Bring(i,AtLeast,1,0,5); 
	Accumulate(i,AtLeast,4500,Ore);
	Accumulate(i,AtMost,0x7FFFFFFF,Ore);
},
actions = {
	ModifyUnitEnergy(1,0,i,5,0);
	RemoveUnitAt(1,0,5,i);
	SetResources(i,Subtract,4500,Ore);
	CreateUnitWithProperties(1,20,2,i,{energy = 100});
	DisplayText(StrDesign("\x1F����\x04�� �Ҹ��Ͽ� Marine �� Jim Raynor�� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F4500 O r e"),4);
	--SetCDeaths(FP,Add,1,CUnitRefrash);
	--SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
	
DoActions(i,{SetCp(i),SetAllianceStatus(Force1,Ally),--��ų����
RunAIScript("Turn ON Shared Vision for Player 1");
RunAIScript("Turn ON Shared Vision for Player 2");
RunAIScript("Turn ON Shared Vision for Player 3");
RunAIScript("Turn ON Shared Vision for Player 4");
RunAIScript("Turn ON Shared Vision for Player 5");
RunAIScript("Turn ON Shared Vision for Player 6");
RunAIScript("Turn ON Shared Vision for Player 7");
})
	end

	for k=0, 6 do -- ��νý���
		for j=0, 6 do
		if k~=j then
		for i=0, 5 do
		Trigger { -- �� ��� �ý���
			players = {k},
			conditions = {
				Label(0);
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,i,GiveRate[k+1]);
				Accumulate(k,AtMost,GiveRate2[i+1],Ore);
			},
			actions = {
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);`
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				DisplayText("\x07�� \x04�ܾ��� �����մϴ�. \x07��",4);
				PreserveTrigger();
			},
			}
		Trigger { -- �� ��� �ý���
			players = {k},
			conditions = {
				Label(0);
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,i,GiveRate[k+1]);
				Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
				Accumulate(k,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetResources(k,Subtract,GiveRate2[i+1],Ore);
				SetResources(j,Add,GiveRate2[i+1],Ore);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				DisplayText("\x07�� "..PlayerString[j+1].."\x04���� \x1F"..GiveRate2[i+1].." Ore\x04�� ����Ͽ����ϴ�. \x07��",4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText("\x12\x07��"..PlayerString[k+1].."\x04���� \x1F"..GiveRate2[i+1].." Ore\x04�� ��ι޾ҽ��ϴ�.\x02 \x07��",4);
				SetMemory(0x6509B0,SetTo,k);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- �� ��� �ý���
			players = {k},
			conditions = {
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,0);
			},
			actions = {
				DisplayText("\x07�� "..PlayerString[j+1].."\x04��(��) �������� �ʽ��ϴ�. \x07��",4);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				PreserveTrigger();
			},
			}
	end end end

	--LeaderBoard
	local LeaderBoardT = CreateCcode()
	Trigger { -- ų ����Ʈ ��������,
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Kills, "\x07[ \x1DP\x04oints\x07 ]");
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
			LeaderBoardScore(Custom, "\x07[ \x08D\x04eaths\x07 ]");
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
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
			LeaderBoardKills("Any unit","\x07[ \x11K\x04ills\x07 ]");
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
			PreserveTrigger();
	},
	}
	DoActionsX(FP,{SetCDeaths(FP,Subtract,1,LeaderBoardT)})


	--HealZone
	
	local HealT = CreateCcode()
	TriggerX(FP,CDeaths(FP,AtLeast,50,HealT),{SetCDeaths(FP,SetTo,0,HealT),
	ModifyUnitHitPoints(All,"Men",Force1,2,100),
	ModifyUnitShields(All,"Men",Force1,2,100)},{preserved})
	DoActionsX(FP,SetCDeaths(FP,Add,1,HealT))
end