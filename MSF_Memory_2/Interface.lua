function Interface()
	local CUnitFlag = CreateCcode()
	local DelayMedic = CreateCcodeArr(4)
	local GiveRate = CreateCcodeArr(4)
	local CurAtk = CreateVarArr(#MapPlayers,FP)
	local CurHP = CreateVarArr(#MapPlayers,FP)
	AtkUpgradeMaskRetArr, AtkUpgradePtrArr = CreateBPtrRetArr(3,0x58D2B0+7,46)
	HPUpgradeMaskRetArr, HPUpgradePtrArr = CreateBPtrRetArr(3,0x58D2B0,46)
	if Limit== 1 then
		for i = 0, 3 do
			--TriggerX(FP,{CD(TestMode,1)},{SetMemoryB(0x58D2B0+7+(i*46),SetTo,250),SetMemoryB(0x58D2B0+(i*46),SetTo,250),})--SetV(CurEXP,0x7FFFFFFF)
		end
	end
	DoActions(Force1,{SetAllianceStatus(Force1,Ally),SetAllianceStatus(P12,Enemy),
	RunAIScript("Turn ON Shared Vision for Player 1");
	RunAIScript("Turn ON Shared Vision for Player 2");
	RunAIScript("Turn ON Shared Vision for Player 3");
	RunAIScript("Turn ON Shared Vision for Player 4");
})

	GiveRateT = {
	StrDesign("\x04��αݾ� ������ \x1F5000 Ore\x04 \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F10000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F50000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F100000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F500000 Ore \x04�� ����Ǿ����ϴ�."),
	StrDesign("\x04��αݾ� ������ \x1F1000 Ore \x04�� ����Ǿ����ϴ�.")}
	for i = 0, 3 do
		CIf(FP,HumanCheck(i,1),{SetV(CurAtk[i+1],0),SetV(CurHP[i+1],0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(5000*256)-255),SetMemory(0x515BB0+(i*4),SetTo,256*5),SetV(MarHPRead[i+1],(5000*256)-255)})

			for CBit = 0, 7 do
				TriggerX(FP,{MemoryX(AtkUpgradePtrArr[i+1],Exactly,(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit),(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurAtk[i+1],2^CBit)},{preserved})
				TriggerX(FP,{MemoryX(HPUpgradePtrArr[i+1],Exactly,(256^HPUpgradeMaskRetArr[i+1])*(2^CBit),(256^HPUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurHP[i+1],2^CBit),SetMemory(0x662350+(MarID[i+1]*4),Add,5120*(2^CBit)),AddV(MarHPRead[i+1],5120*(2^CBit)),SetMemory(0x515BB0+(i*4),Add,5*(2^CBit))},{preserved})
			end
			CIfX(FP,{CV(CurAtk[i+1],250)},{SetMemoryB(0x58D2B0+(46*i)+8,SetTo,3),SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemoryB(0x57F27C + (i * 228) + 74,SetTo,1)})
			CElseIfX({CV(CurAtk[i+1],AtkCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i)+7,SetTo,250),SetMemoryB(0x58D2B0+(46*i)+8,SetTo,3)})
			CElseX({SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0)})
			CIfXEnd()
			CIfX(FP,{CV(CurHP[i+1],250)},{SetMemoryB(0x58D2B0+(46*i)+1,SetTo,3),SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(9999*256)+1),SetMemory(0x515BB0+(i*4),SetTo,2560),SetMemoryB(0x57F27C + (i * 228) + 75,SetTo,1)})
			CElseIfX({CV(CurHP[i+1],HPCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i),SetTo,250),SetMemoryB(0x58D2B0+(46*i)+1,SetTo,3)})
			CElseX({SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0)})
			CIfXEnd()
			


			
			CIf(FP,{Deaths(i,AtLeast,1,"Terran Wraith"),Memory(0x628438,AtLeast,1)},SetDeaths(i,Subtract,1,"Terran Wraith"))
				f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
				DoActions(FP,{CreateUnitWithProperties(1,32,2+i,i,{energy = 100})})
				CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
				CIfEnd()
			CIfEnd()
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
			ModifyUnitEnergy(All,70,i,64,0);
			GiveUnits(All,70,i,"Anywhere",11);
			RemoveUnitAt(All,70,"Anywhere",11);
			DisplayText("\x0D\x0D"..GiveRateT[k+1],4);
			SetCDeaths(FP,Add,1,GiveRate[i+1]);
			SetCDeaths(FP,Add,1,CUnitRefrash);
			PreserveTrigger();
			},
	}
	end
	local ExchangeP = CreateVar(FP)
	for i=0, 3 do
		ExJump = def_sIndex()
		NJump(FP,ExJump,{HumanCheck(i,1),Deaths(i,AtMost,0,"Terran Barracks"),Bring(i,AtMost,0,"Men",17),Bring(i,AtMost,0,"Men",18),Bring(i,AtMost,0,"Men",19),Bring(i,AtMost,0,"Men",20)})
		CIf(FP,Score(i,Kills,AtLeast,1000))
		CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
--		CAdd(FP,{FP,ExScore[i+1][2],nil,"V"},_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),{FP,ExRateV[2],nil,"V"}))
		CMov(FP,ExchangeP,0)
		CIfEnd()
		DoActions(FP,SetDeaths(i,Subtract,1,111))
		
		NJumpEnd(FP,ExJump)
	end
		

Trigger { -- ��ȯ ����
players = {i},
conditions = {
	Label(0);
	Bring(i,AtLeast,1,"Terran Wraith",64);

},
actions = {
	ModifyUnitEnergy(1,"Terran Wraith",i,64,0);
	RemoveUnitAt(1,"Terran Wraith","Anywhere",i);
	SetDeaths(i,Add,1,"Terran Wraith");
	--CreateUnitWithProperties(1,32,2+i,i,{energy = 100});
	DisplayText(StrDesign("\x04�ͣ������� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F"..NMCost.." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	--SetCDeaths(FP,Add,1,MarCreate);
	PreserveTrigger();
},
}


Trigger { -- ���� ��������
players = {i},
conditions = {
	Bring(i,AtLeast,1,32,26+i); 
	Accumulate(i,AtLeast,HMCost,Ore);
	Accumulate(i,AtMost,0x7FFFFFFF,Ore);
},
actions = {
	ModifyUnitEnergy(1,32,i,26+i,0);
	RemoveUnitAt(1,32,26+i,i);
	SetResources(i,Subtract,HMCost,Ore);
	CreateUnitWithProperties(1,20,2+i,i,{energy = 100});
	DisplayText(StrDesign("\x1F����\x04�� �Ҹ��Ͽ� \x04�ͣ������� \x1B�� \x04�ͣ��������� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F"..HMCost.." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	PreserveTrigger();
},
}
Trigger { -- ���� ��̾Ƹ���
	players = {i},
	conditions = {
		Label(0);
		Bring(i,AtLeast,1,20,26+i); 
		Accumulate(i,AtLeast,LMCost,Ore);
		Accumulate(i,AtMost,0x7FFFFFFF,Ore);

	},
	actions = {
		SetResources(i,Subtract,LMCost,Ore);
		ModifyUnitEnergy(1,20,i,26+i,0);
		RemoveUnitAt(1,20,26+i,i);
		CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100});
		DisplayText(StrDesign("\x1F����\x04�� �Ҹ��Ͽ� \x1B�� \x04�ͣ������� "..Color[i+1].."��\x11��\x03��\x18��"..Color[i+1].."�� "..Color[i+1].."��\x04���������� \x19��ȯ\x04�Ͽ����ϴ�. - \x1F"..LMCost.." O r e"),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
}
	
	Trigger { -- ��ȯ ����
		players = {i},
		conditions = {
			Label(0);
			Memory(0x628438,AtLeast,1);
			Deaths(i,AtLeast,1,178);
	
		},
		actions = {
			SetDeaths(i,Subtract,1,178);
			CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100});
			PreserveTrigger();
		},
	}
	Trigger { -- �ڵ�ȯ��
		players = {i},
		conditions = {
			Command(i,AtLeast,1,"Terran Vulture");
		},
		actions = {
			ModifyUnitEnergy(1,"Terran Vulture",i,64,0);
			RemoveUnitAt(1,"Terran Vulture","Anywhere",i);
			SetDeaths(i,SetTo,1,"Terran Barracks");
			DisplayText(StrDesign("\x07�ڵ�ȯ��\x04�� ����ϼ̽��ϴ�."),4);
			SetCDeaths(FP,Add,1,CUnitRefrash);
			PreserveTrigger();
		},
	}
	Trigger {
		players = {i},
		conditions = {
			Label();
			Command(i,AtLeast,1,23);
		},
		actions = {
			ModifyUnitEnergy(1,23,i,64,0);
			RemoveUnitAt(1,23,"Anywhere",i);
			SetCD(Theorist,1);
			SetMemoryB(0x57F27C + (0 * 228) + 23,SetTo,0);
			SetMemoryB(0x57F27C + (1 * 228) + 23,SetTo,0);
			SetMemoryB(0x57F27C + (2 * 228) + 23,SetTo,0);
			SetMemoryB(0x57F27C + (3 * 228) + 23,SetTo,0);
			PreserveTrigger();
		},
	}
	Trigger { -- ��ȣ�� ����
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),AtLeast,1200);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetResources(i,Add,ShCost,Ore);
		ModifyUnitEnergy(1,19,i,64,0);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText(StrDesign("\x04�̹� \x1C���� ��ȣ��\x04�� ������Դϴ�. �ڿ� ��ȯ + \x1F"..ShCost.." Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}

	Trigger { -- ��ȣ�� ����
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),AtLeast,1);
		Memory(0x582294+(4*i),AtMost,1199);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetResources(i,Add,ShCost,Ore);
		ModifyUnitEnergy(1,19,i,64,0);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText(StrDesign("\x1C���� ��ȣ��\x04�� ���� \x0E��Ÿ�� \x04���Դϴ�. �ڿ� ��ȯ + \x1F"..ShCost.." Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
}
	Trigger { -- ��ȣ�� ����
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),Exactly,0);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetMemory(0x582294+(4*i),SetTo,2000);
		ModifyUnitEnergy(1,19,i,64,0);
		RemoveUnitAt(1,19,"Anywhere",i);
		RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."Shield".._0D,4),PlayWAVX("staredit\\wav\\shield_use.ogg")},HumanPlayers,i);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
}
Trigger { -- ��ȣ�� ����
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),AtLeast,1200);
	},
	actions = {
		SetCDeaths(i,SetTo,1,ShUsed);
		ModifyUnitShields(All,"Men",i,"Anywhere",100);
		ModifyUnitShields(All,"Buildings",i,"Anywhere",100);
		PreserveTrigger();
	},
}
	DoActions(i,{SetMemory(0x582294+(4*i),Subtract,1)})

Trigger { -- ��ȣ�� ����
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShUsed);
		Memory(0x582294+(4*i),AtMost,1199);
	},
	actions = {
		DisplayText(StrDesign("\x1C���� ��ȣ��\x04 ����� ����Ǿ����ϴ�."),4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShUsed);
		SetCDeaths(i,SetTo,1,ShCool);
		PreserveTrigger();
	},
}
Trigger { -- ��ȣ�� ����
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShCool);
		Memory(0x582294+(4*i),AtMost,0);
	},
	actions = {
		DisplayText(StrDesign("\x1C���� ��ȣ��\x04 ��Ÿ���� ����Ǿ����ϴ�."),4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShCool);
		PreserveTrigger();
	},
}


Trigger2(i,{Kills(i,AtLeast,1,150)},{SetKills(i,Subtract,1,150),SetScore(i,Add,50000,Kills),DisplayText("!H"..StrDesignX2(Conv_HStr("<19>B<04>onus").."\x04 ���� �ı� \x07���ʽ� \x1F��"..N_to_EmN(50000).." \x1F�У���"),4)},{preserved})
Trigger2(i,{Kills(i,AtLeast,1,176)},{SetKills(i,Subtract,1,176),SetScore(i,Add,30000,Kills),DisplayText("!H"..StrDesignX2(Conv_HStr("<1D>F<4>it").."\x04 ���� �ı� \x07���ʽ� \x1F��"..N_to_EmN(30000).." \x1F�У���"),4)},{preserved})
Trigger2(i,{Kills(i,AtLeast,1,177)},{SetKills(i,Subtract,1,177),SetScore(i,Add,30000,Kills),DisplayText("!H"..StrDesignX2(Conv_HStr("<1D>F<4>it").."\x04 ���� �ı� \x07���ʽ� \x1F��"..N_to_EmN(30000).." \x1F�У���"),4)},{preserved})
Trigger2(i,{Kills(i,AtLeast,1,178)},{SetKills(i,Subtract,1,178),SetScore(i,Add,30000,Kills),DisplayText("!H"..StrDesignX2(Conv_HStr("<1D>F<4>it").."\x04 ���� �ı� \x07���ʽ� \x1F��"..N_to_EmN(30000).." \x1F�У���"),4)},{preserved})

	TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{preserved})
	for j=0, 3 do
		if i~=j then
		for l=0, 5 do
		Trigger { -- �� ��� �ý���
			players = {i},
			conditions = {
				Label(0);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,l,GiveRate[i+1]);
				Accumulate(i,AtMost,GiveRate2[l+1],Ore);
			},
			actions = {
				ModifyUnitEnergy(All,GiveUnitID[j+1],i,64,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",i);
				DisplayText(StrDesign("\x04�ܾ��� �����մϴ�."),4);
				SetCDeaths(FP,Add,1,CUnitRefrash);
				PreserveTrigger();
			},
			}
		Trigger { -- �� ��� �ý���
			players = {i},
			conditions = {
				Label(0);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,1);
				CDeaths(FP,Exactly,l,GiveRate[i+1]);
				Accumulate(i,AtLeast,GiveRate2[l+1],Ore);
				Accumulate(i,AtMost,0x7FFFFFFF,Ore);
			},
			actions = {
				SetResources(i,Subtract,GiveRate2[l+1],Ore);
				SetResources(j,Add,GiveRate2[l+1],Ore);
				ModifyUnitEnergy(All,GiveUnitID[j+1],i,64,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",i);
				DisplayText(StrDesign(PlayerString[j+1].."\x04���� \x1F"..GiveRate2[l+1].." Ore\x04�� ����Ͽ����ϴ�."),4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText(StrDesign(PlayerString[i+1].."\x04���� \x1F"..GiveRate2[l+1].." Ore\x04�� ��ι޾ҽ��ϴ�."),4);
				SetMemory(0x6509B0,SetTo,i);
				SetCDeaths(FP,Add,1,CUnitRefrash);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- �� ��� �ý���
			players = {i},
			conditions = {
				--MemoryB(0x58D2B0+(46*i)+GiveUnitID[j+1],AtLeast,1);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,0);
			},
			actions = {
				DisplayText(StrDesign(PlayerString[j+1].."\x04��(��) �������� �ʽ��ϴ�."),4);
				--SetMemoryB(0x58D2B0+(46*i)+GiveUnitID[j+1],SetTo,0);
				ModifyUnitEnergy(All,GiveUnitID[j+1],i,64,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",i);
				SetCDeaths(FP,Add,1,CUnitRefrash);
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
	TriggerX(i,{CDeaths(FP,Exactly,j,DelayMedic[i+1])},{SetMemoryB(0x57F27C+(228*i)+MedicTrig[j+1],SetTo,1)},{preserved})
	TriggerX(i,{Command(i,AtLeast,1,72),CDeaths(FP,Exactly,j,DelayMedic[i+1])},{
		DisplayText(DelayMedicT[j+1],4),
		SetCDeaths(FP,Add,1,DelayMedic[i+1]),
		GiveUnits(All,72,i,"Anywhere",P12),
		ModifyUnitEnergy(1,72,P12,64,0);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		RemoveUnitAt(1,72,"Anywhere",P12)},{preserved})
	end
	TriggerX(i,{CDeaths(FP,AtLeast,4,DelayMedic[i+1])},{SetCDeaths(FP,Subtract,4,DelayMedic[i+1])},{preserved})

	local MedicTrigJump = def_sIndex()
	for j = 1, 4 do
		if TestStart == 1 then
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)},{AddV(CurEXP,10^(j-1))})
		elseif Limit == 1 then
			NJumpX(FP,MedicTrigJump,{CD(TestMode,1),CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)},{AddV(CurEXP,10^(j-1))})
			NJumpX(FP,MedicTrigJump,{CD(TestMode,0),CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)},{})
		else
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)})
		end
	end
	
		NIf(FP,Never())
			NJumpXEnd(FP,MedicTrigJump)
				DoActionsX(FP,{
					ModifyUnitEnergy(All,MedicTrig[1],i,64,0);
					ModifyUnitEnergy(All,MedicTrig[2],i,64,0);
					ModifyUnitEnergy(All,MedicTrig[3],i,64,0);
					ModifyUnitEnergy(All,MedicTrig[4],i,64,0);
					SetCDeaths(FP,Add,1,CUnitRefrash);
					RemoveUnit(MedicTrig[1],i),
					RemoveUnit(MedicTrig[2],i),
					RemoveUnit(MedicTrig[3],i),
					RemoveUnit(MedicTrig[4],i),
					ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
					ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
					ModifyUnitShields(All,"Men",i,"Anywhere",100),
					ModifyUnitShields(All,"Buildings",i,"Anywhere",100),
					SetCp(i);
					PlayWAV("staredit\\wav\\heal.ogg");
					SetCp(FP);
				})
		NIfEnd()

	Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,22);},{
		GiveUnits(All,22,i,"Anywhere",P12);
		ModifyUnitEnergy(All,22,P12,64,0);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText(StrDesign("\x1CBGM\x04�� ���� �ʽ��ϴ�."),4);
		SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
		SetCDeaths(FP,Add,1,CUnitRefrash);
	},{preserved})

	Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,22);},{
		GiveUnits(All,22,i,"Anywhere",P12);
		ModifyUnitEnergy(All,22,P12,64,0);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText(StrDesign("\x1CBGM\x04�� ����ϴ�."),4);
		SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
		SetCDeaths(FP,Add,1,CUnitRefrash);
	},{preserved})


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
		ModifyUnitEnergy(1,71,i,64,0);
		RemoveUnitAt(1,71,"Anywhere",i);
		DisplayText(StrDesign("\x04���� \x1B������\x04����� ����մϴ�."),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}
	Trigger { -- ������
	players = {i},
	conditions = {
		Label(0);
		Command(i,AtLeast,1,74);
	},
	actions = {
		SetCD(CUnitFlag,1);
		SetDeaths(i,Add,1,74);
		ModifyUnitEnergy(1,74,i,64,0);
		RemoveUnitAt(1,74,"Anywhere",i);
		DisplayText(StrDesign("\x04��Ƽ \x07��ž\x04����� ����մϴ�."),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}
	Trigger { -- ������
	players = {i},
	conditions = {
		Label(0);
		Command(i,AtLeast,1,75);
	},
	actions = {
		SetCD(CUnitFlag,1);
		SetDeaths(i,Add,1,75);
		ModifyUnitEnergy(1,75,i,64,0);
		RemoveUnitAt(1,75,"Anywhere",i);
		DisplayText(StrDesign("\x04��Ƽ \x11Ȧ��\x04����� ����մϴ�."),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}
	end
	
	if Limit == 1 then
		TriggerX(FP,{CD(TestMode,1)},{SetResources(Force1,SetTo,0x66666666,Ore)})
	end
	--�����ν� ���� ���� �����
--DoActionsX(FP,SetMemory(0x58F448,SetTo,0xFFFFFFFF))

local HealT = CreateCcode()
CIf(FP,CDeaths(FP,AtLeast,50,HealT),SetCDeaths(FP,SetTo,0,HealT))
for i = 0, 3 do
	Trigger2(FP,{HumanCheck(i,1)},{
		ModifyUnitHitPoints(All,"Men",Force1,i+2,100),
		ModifyUnitShields(All,"Men",Force1,i+2,100),
		ModifyUnitHitPoints(All,"Buildings",Force1,i+2,100),
		ModifyUnitShields(All,"Buildings",Force1,i+2,100)},{preserved})
end
CIfEnd({SetCDeaths(FP,Add,1,HealT)})
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)},{SetCD(AFlag,0),SetCD(BFlag,2)})
	f_Read(FP,0x6284B8,nil,SelEPD)
	f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
	SelClass = Act_BRead(_Add(SelUID,0x663DD0))
	CTrigger(FP,{CVar(FP,SelClass[2],Exactly,162)},{SetCD(BFlag,1)},1)
	CTrigger(FP,{CVar(FP,SelClass[2],Exactly,161)},{SetCD(BFlag,0)},1)
	CIf(FP,{TMemoryX(_Add(SelEPD,19),AtLeast,4,0xFF),CD(BFlag,1,AtMost)})
	f_Read(FP,_Add(SelEPD,2),SelHP)
	f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)

	
	TriggerX(FP,CV(SelUID,5),SetV(SelUID,6),{preserved})
	TriggerX(FP,CV(SelUID,23),SetV(SelUID,24),{preserved})
	TriggerX(FP,CV(SelUID,25),SetV(SelUID,26),{preserved})
	TriggerX(FP,CV(SelUID,30),SetV(SelUID,31),{preserved})
	TriggerX(FP,CV(SelUID,3),SetV(SelUID,4),{preserved})
	TriggerX(FP,CV(SelUID,17),SetV(SelUID,18),{preserved})
	TriggerX(FP,CV(SelUID,77),SetCD(AFlag,1),{preserved})
	TriggerX(FP,CV(SelUID,65),SetCD(AFlag,1),{preserved})
	TriggerX(FP,CV(SelUID,10),SetCD(AFlag,1),{preserved})
	local SelWepID = CreateVar(FP)
	CMov(FP,SelWepID,Act_BRead(_Add(SelUID,0x6636B8)))
	local SelATK = CreateVar(FP)
	local R = Act_WRead(_Add(_Mul(SelWepID,2),0x656EB0))
	CMov(FP,SelATK,R)
	local R = Act_BRead(_Add(SelWepID,0x6564E0))
	CTrigger(FP,{CVar(FP,R[2],Exactly,2)},{SetCD(AFlag,1)},1)
	CIf(FP,{CD(AFlag,1)})
		CAdd(FP,SelATK,SelATK)
	CIfEnd()
	f_Div(FP,SelHP,_Mov(256))
	f_Div(FP,SelSh,_Mov(256))
	CIf(FP,{CV(SelUID,64)})
	CAdd(FP,SelHP,B2H)
	CIfEnd()
	ItoDec(FP,SelHP,VArr(SelHPVA,0),2,0x08,0)--ü
	ItoDec(FP,SelSh,VArr(SelShVA,0),2,0x1C,0)--��

	CIfX(FP,CD(BFlag,0))
	ItoDec(FP,SelATK,VArr(SelATKVA,0),2,0x1B,0)--�Ϲݵ�
	f_Movcpy(FP,NMDMGTblPtr,VArr(SelHPVA,0),4*4)
	f_Movcpy(FP,_Add(NMDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]),VArr(SelShVA,0),4*4)
	f_Movcpy(FP,_Add(NMDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]),VArr(SelATKVA,0),4*4)
	CElseX()
	CIfX(FP,{TTOR({CV(SelUID,12),CV(SelUID,82)})})
	ItoDec(FP,_Div(SelATK,10),VArr(SelATKVA,0),2,0x06,0)--�۵�1
	ItoDec(FP,_Mod(SelATK,10),VArr(SelATKVA2,0),2,0x06,0)--�۵�2
	CElseX()
	ItoDec(FP,_Div(SelATK,10),VArr(SelATKVA,0),2,0x1F,0)--�۵�1
	ItoDec(FP,_Mod(SelATK,10),VArr(SelATKVA2,0),2,0x1F,0)--�۵�2
	CIfXEnd()
	f_Movcpy(FP,PerDMGTblPtr,VArr(SelHPVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]),VArr(SelShVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]),VArr(SelATKVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]+(4*4)+ClassInfo6[2]),VArr(SelATKVA2,0),4*4)
	CIfXEnd()



	CIfEnd()
	CIfEnd()


		
	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- ���ݽ���
		CMov(FP,0x6509B0,19025+19)
		CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
			CIf(FP,{DeathsX(CurrentPlayer,AtMost,3,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})
			DoActions(FP,MoveCp(Add,6*4))

			CIf(FP,{TTOR({
				DeathsX(CurrentPlayer,Exactly,MarID[1],0,0xFF),
				DeathsX(CurrentPlayer,Exactly,MarID[2],0,0xFF),
				DeathsX(CurrentPlayer,Exactly,MarID[3],0,0xFF),
				DeathsX(CurrentPlayer,Exactly,MarID[4],0,0xFF),
				DeathsX(CurrentPlayer,Exactly,32,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,111,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,20,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,7,0,0xFF)})})
				DoActions(FP,MoveCp(Subtract,6*4))

			for i = 0, 3 do
			CTrigger(FP,{Deaths(i,AtLeast,1,71),DeathsX(CurrentPlayer,Exactly,i,0,0xFF)},{
				MoveCp(Add,50*4);
				SetDeathsX(CurrentPlayer,SetTo,30*256,0,0xFF00);
				MoveCp(Subtract,50*4);},{preserved})

			CTrigger(FP,{Deaths(i,AtLeast,1,74),DeathsX(CurrentPlayer,Exactly,i,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,5*256,0,0xFF00)},{ -- Stop
				SetDeathsX(CurrentPlayer,SetTo,1*256,0,0xFF00),},{preserved})
				
			CIf(FP,{Deaths(i,AtLeast,1,75),DeathsX(CurrentPlayer,Exactly,i,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,5*256,0,0xFF00)}) -- Hold
				f_SaveCp()
				f_Read(FP,_Sub(BackupCp,9),TempPos)
				CDoActions(FP,{
					TSetDeaths(_Add(BackupCp,4),SetTo,0,0),
					TSetDeathsX(BackupCp,SetTo,107*256,0,0xFF00),
					TSetDeaths(_Sub(BackupCp,13),SetTo,TempPos,0),
					TSetDeaths(_Add(BackupCp,3),SetTo,TempPos,0),
					TSetDeaths(_Sub(BackupCp,15),SetTo,TempPos,0)})
				f_LoadCp()
			CIfEnd()
			end
			DoActions(FP,MoveCp(Add,6*4))
			CIfEnd()
			DoActions(FP,MoveCp(Subtract,6*4))
			CIfEnd()
			CAdd(FP,0x6509B0,84)
		CWhileEnd()
	CIfEnd({SetCp(FP),SetDeaths(Force1,SetTo,0,71),SetDeaths(Force1,SetTo,0,74),SetDeaths(Force1,SetTo,0,75),SetCDeaths(FP,SetTo,0,CUnitFlag)})
end