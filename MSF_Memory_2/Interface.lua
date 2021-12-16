function Interface()
	local CUnitFlag = CreateCcode()
	local DelayMedic = CreateCcodeArr(4)
	local GiveRate = CreateCcodeArr(4)
	local CurAtk = CreateVarArr(#MapPlayers,FP)
	local CurHP = CreateVarArr(#MapPlayers,FP)
	local AtkCondTmp = CreateVar(FP)
	local HPCondTmp = CreateVar(FP)
	AtkUpgradeMaskRetArr, AtkUpgradePtrArr = CreateBPtrRetArr(3,0x58D2B0+7,46)
	HPUpgradeMaskRetArr, HPUpgradePtrArr = CreateBPtrRetArr(3,0x58D2B0,46)

	GiveRateT = {
	StrDesign("\x04��αݾ� ������ \x1F5000 Ore\x04 \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F10000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F50000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F100000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F500000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F1000 Ore \x04�� ����Ǿ����ϴ�.")}
	for i = 0, 3 do
		CIf(FP,PlayerCheck(i,1),{SetV(CurAtk[i+1],0),SetV(CurHP[i+1],0)})

		for CBit = 0, 7 do
			TriggerX(FP,{MemoryX(AtkUpgradePtrArr[i+1],Exactly,(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit),(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurAtk[i+1],2^CBit)},{Preserved})
			TriggerX(FP,{MemoryX(HPUpgradePtrArr[i+1],Exactly,(256^HPUpgradeMaskRetArr[i+1])*(2^CBit),(256^HPUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurHP[i+1],2^CBit)},{Preserved})
		end
		CMov(FP,AtkCondTmp,_Add(Level,Level),150)
		CMov(FP,HPCondTmp,_Add(_Add(Level,Level),_Add(Level,Level)),50)
		CIfX(FP,{CV(CurAtk[i+1],250)},{SetMemoryB(0x58D2B0+(i*24)+8,SetTo,3),SetMemoryB(0x58D088+(46*i)+7,SetTo,0)})
		CElseIfX({CV(CurAtk[i+1],AtkCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i)+7,SetTo,250),SetMemoryB(0x58D2B0+(i*24)+8,SetTo,3)})
		CElseX({SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemoryB(0x58D2B0+(i*24)+8,SetTo,0)})
		CIfXEnd()
		CIfX(FP,{CV(CurHP[i+1],250)},{SetMemoryB(0x58D2B0+(i*24)+1,SetTo,3),SetMemoryB(0x58D088+(46*i),SetTo,0)})
		CElseIfX({CV(CurHP[i+1],HPCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i),SetTo,250),SetMemoryB(0x58D2B0+(i*24)+1,SetTo,3)})
		CElseX({SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemoryB(0x58D2B0+(i*24)+1,SetTo,0)})
		CIfXEnd()
		
		CIfEnd()
	for k = 0, 5 do
	Trigger { -- ��� �ݾ� ����
		players = {i},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,k,GiveRate[i+1]);
			Command(i,AtLeast,1,70);
		},
		actions = {
			GiveUnits(All,70,CurrentPlayer,"Anywhere",11);
			RemoveUnitAt(All,70,"Anywhere",11);
			DisplayText(GiveRateT[k+1],4);
			SetCDeaths(FP,Add,1,GiveRate[i+1]);
			PreserveTrigger();
			},
	}
	end
	TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{Preserved})
	for j=0, 3 do
		if i~=j then
		for l=0, 5 do
		Trigger { -- �� ��� �ý���
			players = {i},
			conditions = {
				Label(0);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				PlayerCheck(j,1);
				CDeaths(FP,Exactly,l,GiveRate[i+1]);
				Accumulate(i,AtMost,GiveRate2[l+1],Ore);
			},
			actions = {
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",i);
				DisplayText("\x07�� \x04�ܾ��� �����մϴ�. \x07��",4);
				PreserveTrigger();
			},
			}
		Trigger { -- �� ��� �ý���
			players = {i},
			conditions = {
				Label(0);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				PlayerCheck(j,1);
				CDeaths(FP,Exactly,l,GiveRate[i+1]);
				Accumulate(i,AtLeast,GiveRate2[l+1],Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetResources(i,Subtract,GiveRate2[l+1],Ore);
				SetResources(j,Add,GiveRate2[l+1],Ore);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",i);
				DisplayText(StrDesign(PlayerString[j+1].."\x04���� \x1F"..GiveRate2[l+1].." Ore\x04�� ����Ͽ����ϴ�."),4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText(StrDesign(PlayerString[i+1].."\x04���� \x1F"..GiveRate2[l+1].." Ore\x04�� ��ι޾ҽ��ϴ�."),4);
				SetMemory(0x6509B0,SetTo,i);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- �� ��� �ý���
			players = {i},
			conditions = {
				--MemoryB(0x58D2B0+(46*i)+GiveUnitID[j+1],AtLeast,1);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				PlayerCheck(j,0);
			},
			actions = {
				DisplayText(StrDesign(PlayerString[j+1].."\x04��(��) �������� �ʽ��ϴ�."),4);
				--SetMemoryB(0x58D2B0+(46*i)+GiveUnitID[j+1],SetTo,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",i);
				PreserveTrigger();
			},
			}
		end 
		
	end

	DoActions(i,{
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[1],SetTo,0),
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[2],SetTo,0),
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[3],SetTo,0),
		SetMemoryB(0x57F27C+(228*i)+MedicTrig[4],SetTo,0),
	})
	for j = 0, 3 do
	TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1])},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{Preserved})
	TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
		DisplayText(DelayMedicT[j+1],4),
		SetCDeaths(FP,Add,1,DelayMedic[i+1]),
		GiveUnits(All,72,i,"Anywhere",P12),
		RemoveUnitAt(1,72,"Anywhere",P12)},{Preserved})
	end
	TriggerX(i,{CDeaths(FP,AtLeast,4,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,4,DelayMedic[i+1])},{Preserved})

	local MedicTrigJump = def_sIndex()
	for j = 1, 4 do
		if Limit == 1 then
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)},{AddV(CurEXP,10^(j-1))})
		else
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)})
		end
	end

		NIf(FP,Never())
			NJumpXEnd(FP,MedicTrigJump)
				DoActionsX(FP,{
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

	Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,22);},{
		GiveUnits(All,22,i,"Anywhere",P12);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText(StrDesign("\x1CBGM\x04�� ���� �ʽ��ϴ�."),4);
		SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
	},{Preserved})

	Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,22);},{
		GiveUnits(All,22,i,"Anywhere",P12);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText(StrDesign("\x1CBGM\x04�� ����ϴ�."),4);
		SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
	},{Preserved})


	UnitLimit(i,7,25,"SCV��",500)
	UnitLimit(i,125,15,"��Ŀ��",8000)
	UnitLimit(i,124,15,"�ͷ���",4000)
	Trigger { -- ������
	players = {i},
	conditions = {
		Label(0);
		Command(i,AtLeast,1,71);
	},
	actions = {
		SetCD(CUnitFlag,1);
		SetDeaths(i,Add,1,71);
		RemoveUnitAt(1,71,"Anywhere",i);
		DisplayText(StrDesign("\x04���� \x1B������\x04����� ����մϴ�. - \x1F1000 Ore"),4);
		PreserveTrigger();
	},
	}
	end

	
	
	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- ���ݽ���
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,AtMost,3,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})
			for i = 0, 3 do
			CTrigger(FP,{TTOR({
				DeathsX(CurrentPlayer,Exactly,MarID[i+1],0,0xFF),
				DeathsX(CurrentPlayer,Exactly,7,0,0xFF),
			}),Deaths(i,AtLeast,1,71)},{
				MoveCp(Add,50*4);
				SetDeathsX(CurrentPlayer,SetTo,30*256,0,0xFF00);
				MoveCp(Subtract,50*4);},{Preserved})
			end
			CIfEnd()
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
	CIfEnd({SetCp(FP),SetDeaths(Force1,SetTo,0,71),SetCDeaths(FP,SetTo,0,CUnitFlag)})
end