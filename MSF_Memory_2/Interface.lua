function Interface()
	local DelayMedic = CreateCcodeArr(4)
	local GiveRate = CreateCcodeArr(4)
	local FastMarine = CreateCcodeArr(4)
	local CurAtk = CreateVarArr(#MapPlayers,FP)
	local CurHP = CreateVarArr(#MapPlayers,FP)
	AtkUpgradeMaskRetArr, AtkUpgradePtrArr = CreateBPtrRetArr(3,0x58D2B0+7,46)
	HPUpgradeMaskRetArr, HPUpgradePtrArr = CreateBPtrRetArr(3,0x58D2B0,46)
	local P1 = { 0x581d74, 0x581d7C, 0x581d84, 0x581d8C}
	local P2 = { 0x581DD4, 0x581DD4, 0x581DD8, 0x581DD8}
	local P3 = { 65536, 16777216, 1, 256}
	local P4 = { 111, 165, 159, 164}
	local P5 = { 0xFF0000, 0xFF000000, 0xFF, 0xFF00 }
	local P6 = {
	StrDesign("\x04컬러 스킨 단위가 \x1F+10\x04 \x04로 변경되었습니다."),
	StrDesign("\x04컬러 스킨 단위가 \x02초기화 \x04로 변경되었습니다."),
	StrDesign("\x04컬러 스킨 단위가 \x1C+1 \x04로 변경되었습니다."),}
	local PCMode = CreateCcodeArr(4)
	local PC1=CreateVar2(FP,nil,nil,P4[1])
	local PC2=CreateVar2(FP,nil,nil,P4[2])
	local PC3=CreateVar2(FP,nil,nil,P4[3])
	local PC4=CreateVar2(FP,nil,nil,P4[4])
	local PCVar = {PC1,PC2,PC3,PC4}
	local CurPC = CreateVarArr(4,FP)

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
	StrDesign("\x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.")}
	for i = 0, 3 do
		local PCMode2 = {1,10,P4[i+1]}
		CIf(FP,HumanCheck(i,1),{SetV(CurAtk[i+1],0),SetV(CurHP[i+1],0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(5000*256)-255),SetMemory(0x515BB0+(i*4),SetTo,256*5),SetV(MarHPRead[i+1],(5000*256)-255)})

			for CBit = 0, 7 do
				TriggerX(FP,{MemoryX(AtkUpgradePtrArr[i+1],Exactly,(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit),(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurAtk[i+1],2^CBit)},{preserved})
				TriggerX(FP,{MemoryX(HPUpgradePtrArr[i+1],Exactly,(256^HPUpgradeMaskRetArr[i+1])*(2^CBit),(256^HPUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurHP[i+1],2^CBit),SetMemory(0x662350+(MarID[i+1]*4),Add,(5120*5)*(2^CBit)),AddV(MarHPRead[i+1],(5120*5)*(2^CBit)),SetMemory(0x515BB0+(i*4),Add,25*(2^CBit))},{preserved})
			end
			CIfX(FP,{CV(CurAtk[i+1],100)},{SetMemoryB(0x58D2B0+(46*i)+8,SetTo,3),SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemoryB(0x57F27C + (i * 228) + 74,SetTo,1)})
			CElseIfX({CV(CurAtk[i+1],AtkCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i)+7,SetTo,100),SetMemoryB(0x58D2B0+(46*i)+8,SetTo,3)})
			CElseX({SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0)})
			CIfXEnd()
			CIfX(FP,{CV(CurHP[i+1],50)},{SetMemoryB(0x58D2B0+(46*i)+1,SetTo,3),SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(9999*256)+1),SetMemory(0x515BB0+(i*4),SetTo,2560),SetMemoryB(0x57F27C + (i * 228) + 75,SetTo,1)})
			CElseIfX({CV(CurHP[i+1],HPCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i),SetTo,50),SetMemoryB(0x58D2B0+(46*i)+1,SetTo,3)})
			CElseX({SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0)})
			CIfXEnd()
			


			
			CIf(FP,{Deaths(i,AtLeast,1,"Terran Wraith"),Memory(0x628438,AtLeast,1)},SetDeaths(i,Subtract,1,"Terran Wraith"))
				f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
				DoActionsX(FP,{CreateUnitWithProperties(1,32,2+i,i,{energy = 100}),
				SetCD(CUnitFlag,1);})
				CIf(FP,{TTCVar(FP,BarPos[i+1][2],NotSame,BarRally[i+1]),CVar(FP,BarRally[i+1][2],AtLeast,1),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
				CDoActions(FP,{TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,BarRally[i+1],0)})
				CIfEnd()
			CIfEnd()
			CIf(FP,{TTCVar(FP,PCVar[i+1][2],NotSame,CurPC[i+1])})
			CMov(FP,CurPC[i+1],PCVar[i+1])
			CMov(FP,0x57f120+(4*i),PCVar[i+1])
			CDoActions(FP, {
				TSetMemoryX(P2[i+1], SetTo, _Mul(PCVar[i+1],P3[i+1]), P5[i+1]),
				TSetMemoryX(P1[i+1], SetTo, _Mul(PCVar[i+1],65536), 0xFF0000)
			})
			CIfEnd()
		CIfEnd()

		
	for k = 0, 5 do
	Trigger { -- 기부 금액 변경
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
	for k = 0, 2 do
	UnitButton(i, 54, {CDeaths(FP,Exactly,k,PCMode[i+1])}, {
		DisplayText("\x0D\x0D"..P6[k+1],4);
		SetCDeaths(FP,Add,1,PCMode[i+1]);})
	if k == 2 then
	UnitButton(i, 50, {CDeaths(FP,Exactly,k,PCMode[i+1])}, {
		SetV(PCVar[i+1],PCMode2[k+1])})
	UnitButton(i, 53, {CDeaths(FP,Exactly,k,PCMode[i+1])}, {
		SetV(PCVar[i+1],PCMode2[k+1])})
	else
	UnitButton(i, 50, {CDeaths(FP,Exactly,k,PCMode[i+1])}, {
		SubV(PCVar[i+1],PCMode2[k+1])})
	UnitButton(i, 53, {CDeaths(FP,Exactly,k,PCMode[i+1])}, {
		AddV(PCVar[i+1],PCMode2[k+1])})
	end
	end
	TriggerX(i, {CV(PCVar[i+1],256,AtLeast)}, {SubV(PCVar[i+1],256)}, {preserved})
	
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
		

Trigger { -- 소환 마린
players = {i},
conditions = {
	Label(0);
	Command(i,AtLeast,1,"Terran Wraith");

},
actions = {
	ModifyUnitEnergy(1,"Terran Wraith",i,64,0);
	RemoveUnitAt(1,"Terran Wraith","Anywhere",i);
	SetDeaths(i,Add,1,"Terran Wraith");
	--CreateUnitWithProperties(1,32,2+i,i,{energy = 100});
	DisplayText(StrDesign("\x04Ｍａｒｉｎｅ을 \x19소환\x04하였습니다. - \x1F"..NMCost.." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	--SetCDeaths(FP,Add,1,MarCreate);
	PreserveTrigger();
},
}


Trigger { -- 조합 영웅마린
players = {i},
conditions = {
	Label(0);
	Bring(i,AtLeast,1,32,26+i); 
	Accumulate(i,AtLeast,HMCost,Ore);
	Accumulate(i,AtMost,0x7FFFFFFF,Ore);
},
actions = {
	ModifyUnitEnergy(1,32,i,26+i,0);
	RemoveUnitAt(1,32,26+i,i);
	SetResources(i,Subtract,HMCost,Ore);
	CreateUnitWithProperties(1,20,2+i,i,{energy = 100});
	DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x04Ｍａｒｉｎｅ을 \x1BＨ \x04Ｍａｒｉｎｅ으로 \x19변환\x04하였습니다. - \x1F"..HMCost.." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
Trigger { -- 조합 루미아마린
	players = {i},
	conditions = {
		Label(0);
		CD(Theorist,0);
		Bring(i,AtLeast,1,20,26+i); 
		Accumulate(i,AtLeast,LMCost,Ore);
		Accumulate(i,AtMost,0x7FFFFFFF,Ore);

	},
	actions = {
		SetResources(i,Subtract,LMCost,Ore);
		ModifyUnitEnergy(1,20,i,26+i,0);
		RemoveUnitAt(1,20,26+i,i);
		CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100});
		DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x1BＨ \x04Ｍａｒｉｎｅ을 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ으로 \x19변환\x04하였습니다. - \x1F"..LMCost.." O r e"),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		SetCDeaths(FP,Add,1,FastMarine[i+1]);
		SetCD(CUnitFlag,1);
		PreserveTrigger();
	},
}

Trigger { -- 조합 루미아마린
	players = {i},
	conditions = {
		Label(0);
		CD(Theorist,1);
		Bring(i,AtLeast,1,20,26+i); 
		Accumulate(i,AtLeast,LMCost2,Ore);
		Accumulate(i,AtMost,0x7FFFFFFF,Ore);

	},
	actions = {
		SetResources(i,Subtract,LMCost2,Ore);
		ModifyUnitEnergy(1,20,i,26+i,0);
		RemoveUnitAt(1,20,26+i,i);
		CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100});
		DisplayText(StrDesign("\x1F광물\x04을 소모하여 \x1BＨ \x04Ｍａｒｉｎｅ을 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ으로 \x19변환\x04하였습니다. - \x1F"..LMCost2.." O r e"),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		SetCDeaths(FP,Add,1,FastMarine[i+1]);
		SetCD(CUnitFlag,1);
		PreserveTrigger();
	},
}

Trigger { -- 소환 루미아마린
players = {i},
conditions = {
	Label(0);
	CD(Theorist,0);
	CDeaths(FP,AtMost,11,FastMarine[i+1]);
	Command(i,AtLeast,1,28);

},
actions = {
	ModifyUnitEnergy(1,28,i,64,0);
	RemoveUnitAt(1,28,64,i);
	SetResources(i,Add,NMCost+HMCost+LMCost,Ore);
	DisplayText(StrDesign(Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ12기 조합) \x1F자원 \x04반환 + \x1F"..(LMCost+HMCost+NMCost).." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
Trigger { -- 소환 루미아마린
players = {i},
conditions = {
	Label(0);
	CD(Theorist,1);
	CDeaths(FP,AtMost,11,FastMarine[i+1]);
	Command(i,AtLeast,1,28);

},
actions = {
	ModifyUnitEnergy(1,28,i,64,0);
	RemoveUnitAt(1,28,64,i);
	SetResources(i,Add,NMCost+HMCost+LMCost2,Ore);
	DisplayText(StrDesign(Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ12기 조합) \x1F자원 \x04반환 + \x1F"..(LMCost2+HMCost+NMCost).." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
Trigger { -- 소환 루미아마린
players = {i},
conditions = {
	Label(0);
	CD(Theorist,0);
	CDeaths(FP,AtLeast,12,FastMarine[i+1]);
	Command(i,AtLeast,1,28);

},
actions = {
	ModifyUnitEnergy(1,28,i,64,0);
	RemoveUnitAt(1,28,64,i);
	CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100});
	DisplayText(StrDesign("\x1F광물\x04을 소모하여 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ을 \x19소환\x04하였습니다. - \x1F"..(LMCost+HMCost+NMCost).." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
Trigger { -- 소환 루미아마린
players = {i},
conditions = {
	Label(0);
	CD(Theorist,1);
	CDeaths(FP,AtLeast,12,FastMarine[i+1]);
	Command(i,AtLeast,1,28);

},
actions = {
	ModifyUnitEnergy(1,28,i,64,0);
	RemoveUnitAt(1,28,64,i);
	CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100});
	DisplayText(StrDesign("\x1F광물\x04을 소모하여 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ을 \x19소환\x04하였습니다. - \x1F"..(LMCost2+HMCost+NMCost).." O r e"),4);
	SetCDeaths(FP,Add,1,CUnitRefrash);
	SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
	
	Trigger { --
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
	Trigger { -- 자동환전
		players = {i},
		conditions = {
			Command(i,AtLeast,1,"Terran Vulture");
		},
		actions = {
			ModifyUnitEnergy(1,"Terran Vulture",i,64,0);
			RemoveUnitAt(1,"Terran Vulture","Anywhere",i);
			SetDeaths(i,SetTo,1,"Terran Barracks");
			DisplayText(StrDesign("\x07자동환전\x04을 사용하셨습니다."),4);
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
			SetMemoryB(0x57F27C + (0 * 228) + 7,SetTo,0);
			SetMemoryB(0x57F27C + (1 * 228) + 7,SetTo,0);
			SetMemoryB(0x57F27C + (2 * 228) + 7,SetTo,0);
			SetMemoryB(0x57F27C + (3 * 228) + 7,SetTo,0);
			PreserveTrigger();
		},
	}
	Trigger { -- 보호막 가동
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
		DisplayText(StrDesign("\x04이미 \x1C빛의 보호막\x04을 사용중입니다. 자원 반환 + \x1F"..ShCost.." Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}

	Trigger { -- 보호막 가동
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
		DisplayText(StrDesign("\x1C빛의 보호막\x04이 현재 \x0E쿨타임 \x04중입니다. 자원 반환 + \x1F"..ShCost.." Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
}
	Trigger { -- 보호막 가동
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
Trigger { -- 보호막 가동
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

Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShUsed);
		Memory(0x582294+(4*i),AtMost,1199);
	},
	actions = {
		DisplayText(StrDesign("\x1C빛의 보호막\x04 사용이 종료되었습니다."),4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShUsed);
		SetCDeaths(i,SetTo,1,ShCool);
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShCool);
		Memory(0x582294+(4*i),AtMost,0);
	},
	actions = {
		DisplayText(StrDesign("\x1C빛의 보호막\x04 쿨타임이 종료되었습니다."),4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShCool);
		PreserveTrigger();
	},
}


Trigger2(i,{Kills(i,AtLeast,1,150)},{SetKills(i,Subtract,1,150),SetScore(i,Add,50000,Kills),DisplayText("\x0D\x0D!H"..StrDesignX2(Conv_HStr("<19>B<04>onus").."\x04 직접 파괴 \x07보너스 \x1F＋"..N_to_EmN(50000).." \x1FＰｔｓ"),4)},{preserved})
Trigger2(i,{Kills(i,AtLeast,1,176)},{SetKills(i,Subtract,1,176),SetScore(i,Add,30000,Kills),DisplayText("\x0D\x0D!H"..StrDesignX2(Conv_HStr("<1D>F<4>it").."\x04 직접 파괴 \x07보너스 \x1F＋"..N_to_EmN(30000).." \x1FＰｔｓ"),4)},{preserved})
Trigger2(i,{Kills(i,AtLeast,1,177)},{SetKills(i,Subtract,1,177),SetScore(i,Add,30000,Kills),DisplayText("\x0D\x0D!H"..StrDesignX2(Conv_HStr("<1D>F<4>it").."\x04 직접 파괴 \x07보너스 \x1F＋"..N_to_EmN(30000).." \x1FＰｔｓ"),4)},{preserved})
Trigger2(i,{Kills(i,AtLeast,1,178)},{SetKills(i,Subtract,1,178),SetScore(i,Add,30000,Kills),DisplayText("\x0D\x0D!H"..StrDesignX2(Conv_HStr("<1D>F<4>it").."\x04 직접 파괴 \x07보너스 \x1F＋"..N_to_EmN(30000).." \x1FＰｔｓ"),4)},{preserved})

TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{preserved})
TriggerX(i,{CDeaths(FP,AtLeast,3,PCMode[i+1])},{SetCDeaths(FP,Subtract,3,PCMode[i+1])},{preserved})
	for j=0, 3 do
		if i~=j then
		for l=0, 5 do
		Trigger { -- 돈 기부 시스템
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
				DisplayText(StrDesign("\x04잔액이 부족합니다."),4);
				SetCDeaths(FP,Add,1,CUnitRefrash);
				PreserveTrigger();
			},
			}
		Trigger { -- 돈 기부 시스템
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
				DisplayText(StrDesign(PlayerString[j+1].."\x04에게 \x1F"..GiveRate2[l+1].." Ore\x04를 기부하였습니다."),4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText(StrDesign(PlayerString[i+1].."\x04에게 \x1F"..GiveRate2[l+1].." Ore\x04를 기부받았습니다."),4);
				SetMemory(0x6509B0,SetTo,i);
				SetCDeaths(FP,Add,1,CUnitRefrash);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- 돈 기부 시스템
			players = {i},
			conditions = {
				--MemoryB(0x58D2B0+(46*i)+GiveUnitID[j+1],AtLeast,1);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,0);
			},
			actions = {
				DisplayText(StrDesign(PlayerString[j+1].."\x04이(가) 존재하지 않습니다."),4);
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
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{AddV(CurEXP,10^(j-1))})
		elseif Limit == 1 then
			
			local TestT = CreateCcode()
			TriggerX(FP,{CD(TestMode,1)},{AddCD(TestT,1)},{preserved})
			--NJumpX(FP,MedicTrigJump,{CD(TestMode,1),CD(TestT,5,AtLeast)},{SetCD(TestT,0)})
			--NJumpX(FP,MedicTrigJump,{CD(TestMode,1),CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{AddV(CurEXP,10^(j-1))})
			--NJumpX(FP,MedicTrigJump,{CD(TestMode,0),CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{})
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{
				SetCp(i);
				PlayWAV("staredit\\wav\\heal.ogg");
				SetCp(FP);})
		else
			NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Command(i,AtLeast,1,MedicTrig[j])},{
				SetCp(i);
				PlayWAV("staredit\\wav\\heal.ogg");
				SetCp(FP);})
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
				})
		NIfEnd()

	Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,22);},{
		GiveUnits(All,22,i,"Anywhere",P12);
		ModifyUnitEnergy(All,22,P12,64,0);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText(StrDesign("\x1CBGM\x04을 듣지 않습니다."),4);
		SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
		SetCDeaths(FP,Add,1,CUnitRefrash);
	},{preserved})

	Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,22);},{
		GiveUnits(All,22,i,"Anywhere",P12);
		ModifyUnitEnergy(All,22,P12,64,0);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText(StrDesign("\x1CBGM\x04을 듣습니다."),4);
		SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
		SetCDeaths(FP,Add,1,CUnitRefrash);
	},{preserved})


	UnitLimit(i,7,25,"SCV는",500)
	UnitLimit(i,125,15,"벙커는",8000)
	UnitLimit(i,124,15,"터렛은",4000)
	Trigger { -- 스팀팩
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
		DisplayText(StrDesign("\x04원격 \x1B스팀팩\x04기능을 사용합니다."),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}
	Trigger { -- 스팀팩
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
		DisplayText(StrDesign("\x04멀티 \x07스탑\x04기능을 사용합니다."),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}
	Trigger { -- 스팀팩
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
		DisplayText(StrDesign("\x04멀티 \x11홀드\x04기능을 사용합니다."),4);
		SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
	}
	end
	
	if Limit == 1 then
		TriggerX(FP,{CD(TestMode,1)},{SetResources(Force1,SetTo,0x66666666,Ore)})
	end
	--선택인식 피통 보임 비공유
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


local iStrinit = def_sIndex()
CJump(FP, iStrinit)
t01 = " 0000000000 \x04(00000\x0D\x04) - 00000  \x1BＤｍｇ"
t02 = " 0000000000 \x04(00000\x0D\x04) - 00\x1F.0 ％"
iStrSize1 = GetiStrSize(0,t01)
iStrSize2 = GetiStrSize(0,t02)
S1 = MakeiTblString(1463,"None",'None',MakeiStrLetter("\x0D",iStrSize1+5),"Base",1) -- 단축키없음
S2 = MakeiTblString(1464,"None",'None',MakeiStrLetter("\x0D",iStrSize2+5),"Base",1) -- 단축키없음
iTbl1 = GetiTblId(FP,1463,S1) --NMDMG
iTbl2 = GetiTblId(FP,1464,S2) --PerDMG
Str1, Str1a, Str1s = SaveiStrArr(FP,t01)
Str2, Str2a, Str2s = SaveiStrArr(FP,t02)
CJumpEnd(FP, iStrinit)
local CurEPD = CreateVar(FP)
local SelWepID = CreateVar(FP)
local AFlag = CreateCcode()
local BFlag = CreateCcode()
local SelATK = CreateVar(FP)


	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)})
		f_Read(FP,0x6284B8,nil,SelEPD)
		f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
		f_Read(FP,_Add(SelEPD,2),SelHP)
		f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
		f_Div(FP,SelHP,_Mov(256))
		f_Div(FP,SelSh,_Mov(256))

		CTrigger(FP,{CV(SelUID,64),CD(EDNum,3)},{AddV(SelHP,B2H)},1)

		CIf(FP,{CV(SelUID,12)})
			CAdd(FP,SelHP,BPHRetTest)
			CMov(FP,SelATK,BossAtkRand)
		CIfEnd()

		CIf(FP,{TTCVar(FP,SelEPD[2],NotSame,CurEPD)},{SetCD(AFlag,0)})
			CMov(FP,CurEPD,SelEPD)
			SelClass = Act_BRead(_Add(SelUID,0x663DD0))
			CTrigger(FP,{CVar(FP,SelClass[2],Exactly,162)},{SetCD(BFlag,1)},1)
			CTrigger(FP,{CVar(FP,SelClass[2],Exactly,161)},{SetCD(BFlag,0)},1)
			CIf(FP,{TMemoryX(_Add(SelEPD,19),AtLeast,4,0xFF),CD(BFlag,1,AtMost)})
				TriggerX(FP,CV(SelUID,5),SetV(SelUID,6),{preserved})
				TriggerX(FP,CV(SelUID,23),SetV(SelUID,24),{preserved})
				TriggerX(FP,CV(SelUID,25),SetV(SelUID,26),{preserved})
				TriggerX(FP,CV(SelUID,30),SetV(SelUID,31),{preserved})
				TriggerX(FP,CV(SelUID,3),SetV(SelUID,4),{preserved})
				TriggerX(FP,CV(SelUID,17),SetV(SelUID,18),{preserved})
				TriggerX(FP,CV(SelUID,77),SetCD(AFlag,1),{preserved})
				TriggerX(FP,CV(SelUID,65),SetCD(AFlag,1),{preserved})
				TriggerX(FP,CV(SelUID,10),SetCD(AFlag,1),{preserved})
				CMov(FP,SelWepID,Act_BRead(_Add(SelUID,0x6636B8)))
				local R = Act_WRead(_Add(_Mul(SelWepID,2),0x656EB0))
				CMov(FP,SelATK,R)
				local R = Act_BRead(_Add(SelWepID,0x6564E0))
				CTrigger(FP,{CVar(FP,R[2],Exactly,2)},{SetCD(AFlag,1)},1)
				CIf(FP,{CD(AFlag,1)})
					CAdd(FP,SelATK,SelATK)
				CIfEnd()
			CIfEnd()
		CIfEnd()
		
		CIfX(FP,CD(BFlag,0))
			CS__ItoCustom(FP,SVA1(Str1,0),SelHP,nil,nil,{10,10},1,nil,"\x080",0x08,{0,1,2,3,4,5,6,7,8,9})
			CS__ItoCustom(FP,SVA1(Str1,13),SelSh,nil,nil,{10,5},1,nil,"\x1C0",0x1C,{0,1,2,3,4})
			CS__ItoCustom(FP,SVA1(Str1,23),SelATK,nil,nil,{10,5},1,nil,"\x1B0",0x1B,{0,1,2,3,4})
			CS__InputVA(FP,iTbl1,0,Str1,Str1s,nil,0,Str1s)
		CElseX()
		
			CS__ItoCustom(FP,SVA1(Str2,0),SelHP,nil,nil,{10,10},1,nil,"\x080",0x08,{0,1,2,3,4,5,6,7,8,9})
			CS__ItoCustom(FP,SVA1(Str2,13),SelSh,nil,nil,{10,5},1,nil,"\x1C0",0x1C,{0,1,2,3,4})
			CS__ItoCustom(FP,SVA1(Str2,23),SelATK,nil,nil,{10,3},1,{"\x0D","\x1F0","\x1F0"},nil,0x1F,{0,1,3})
			CIfX(FP,{TTOR({CV(SelUID,12),CV(SelUID,82)})},{
				SetCSVA1(SVA1(Str2,23),SetTo,0x08,0xFF),
				SetCSVA1(SVA1(Str2,24),SetTo,0x08,0xFF),
				SetCSVA1(SVA1(Str2,26),SetTo,0x08,0xFF),})
			CElseX({
				SetCSVA1(SVA1(Str2,23),SetTo,0x1F,0xFF),
				SetCSVA1(SVA1(Str2,24),SetTo,0x1F,0xFF),
				SetCSVA1(SVA1(Str2,26),SetTo,0x1F,0xFF),})
			CIfXEnd()
			CS__InputVA(FP,iTbl2,0,Str2,Str2s,nil,0,Str2s)
		CIfXEnd()
	CIfEnd()


		
	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- 원격
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
			CIf(FP,CD(MarDup,1))--겹치기실행
				f_SaveCp()
				CIf(FP,{TTMemoryX(_Add(BackupCp,6), NotSame, 111,0xFF),TMemoryX(_Add(BackupCp,36),Exactly,0,0xA00000)})
					CDoActions(FP,{
						TSetDeathsX(_Add(BackupCp,36),SetTo,0xA00000,0,0xA00000),
					})
				CIfEnd()
				f_LoadCp()
			CIfEnd()
			CIf(FP,CD(MarDup,2))--겹치기해제
				f_SaveCp()
				CIf(FP,{TTMemoryX(_Add(BackupCp,6), NotSame, 111,0xFF),TMemoryX(_Add(BackupCp,36),Exactly,0xA00000,0xA00000)})
					CDoActions(FP,{
						TSetDeathsX(_Add(BackupCp,36),SetTo,0,0,0xA00000),
					})
				CIfEnd()
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

	CIf(FP,CD(MarDup2,1)) -- 뭉치기 실행
	
	Player_0x4D = CreateVarArr(4,FP)
	Player_0x18 = CreateVarArr(4,FP)
	Player_0x58 = CreateVarArr(4,FP)
	Player_0x5C = CreateVarArr(4,FP)
	Player_S = CreateVarArr(4,FP)
	Player_T = CreateVarArr(4,FP)
	Player_C = CreateVarArr(4,FP)
for i=0, 3 do
	CIf(FP,{HumanCheck(i,1)})

		f_Read(FP,0x6284E8+(0x30*i),"X",Player_S[i+1],0xFFFFFF)
		CIf(FP,Memory(0x6284E8+(0x30*i),AtLeast,1))
			CMov(FP,Player_0x4D[i+1],_ReadF(_Add(Player_S[i+1],0x4C/4),0xFF00),nil,0xFF00)
			CMov(FP,Player_0x18[i+1],_ReadF(_Add(Player_S[i+1],0x18/4)))
			CMov(FP,Player_0x58[i+1],_ReadF(_Add(Player_S[i+1],0x58/4)))
			CMov(FP,Player_0x5C[i+1],_ReadF(_Add(Player_S[i+1],0x5C/4)))
			CIf(FP,{CVar(FP,Player_0x4D[i+1][2],AtLeast,256)})
				CMov(FP,Player_C[i+1],1)
				CWhile(FP,{CVar(FP,Player_C[i+1][2],AtMost,11)})
					CIf(FP,{TDeaths(_Add(Player_C[i+1],EPDF(0x6284E8+(0x30*i))),AtLeast,1,0)})
						--CMov(FP,0x6509B0,_EPD(_Read(BackupCp,0xFFFFFF)))
						--CRead(FP,0x6509B0,BackupCp,0,0xFFFFFF,1)
						CMov(FP,Player_T[i+1],_EPD(_ReadF(_Add(Player_C[i+1],EPDF(0x6284E8+(0x30*i))))))
						CTrigger(FP,{
							TDeaths(_Add(Player_T[i+1],0x8/4),AtLeast,256,0),
							TDeathsX(_Add(Player_T[i+1],0x4C/4),AtLeast,1*256,0,0xFF00)
							},
						{
							TSetDeathsX(_Add(Player_T[i+1],0x4C/4),SetTo,Player_0x4D[i+1],0,0xFF00),
							TSetDeaths(_Add(Player_T[i+1],0x18/4),SetTo,Player_0x18[i+1],0),
							TSetDeaths(_Add(Player_T[i+1],0x58/4),SetTo,Player_0x58[i+1],0),
							TSetDeaths(_Add(Player_T[i+1],0x5C/4),SetTo,Player_0x5C[i+1],0)
							},1)
					CIfEnd()
					CAdd(FP,Player_C[i+1],1)
				CWhileEnd()
			CIfEnd()
		CIfEnd()
	CIfEnd()
	end
	
	CIfEnd()

	for i = 128,131 do
		ObserverChatToOb(FP,0x58D740+(20*59),i,"END",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x1C채팅→관전자\x04에게 메세지를 보냅니다.").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
		ObserverChatToAll(FP,0x58D740+(20*59),i,"HOME",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x07채팅→전체\x04에게 메세지를 보냅니다.").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
		ObserverChatToNone(FP,0x58D740+(20*59),i,"INSERT",10,nil,{SetMemory(0x6509B0,SetTo,i),DisplayText("\x0D\x0D!H"..StrDesign("\x02채팅→대상없음\x04에게 메세지를 보냅니다.(귓말 명령어 등 전용)").."\x0D\x0D",4),PlayWAV("staredit\\wav\\button3.wav"),SetMemory(0x6509B0,SetTo,FP)})
	end
end