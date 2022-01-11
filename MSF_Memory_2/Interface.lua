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
			TriggerX(FP,{CD(TestMode,1)},{SetMemoryB(0x58D2B0+7+(i*46),SetTo,250),SetMemoryB(0x58D2B0+(i*46),SetTo,250),SetV(CurEXP,0x7FFFFFFF)})
		end
	end
	GiveRateT = {
	StrDesign("\x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.")}
	for i = 0, 3 do
		CIf(FP,PlayerCheck(i,1),{SetV(CurAtk[i+1],0),SetV(CurHP[i+1],0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(1000*256)-255),SetMemory(0x515BB0+(i*4),SetTo,256),SetV(MarHPRead[i+1],(1000*256)-255)})

		for CBit = 0, 7 do
			TriggerX(FP,{MemoryX(AtkUpgradePtrArr[i+1],Exactly,(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit),(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurAtk[i+1],2^CBit)},{Preserved})
			TriggerX(FP,{MemoryX(HPUpgradePtrArr[i+1],Exactly,(256^HPUpgradeMaskRetArr[i+1])*(2^CBit),(256^HPUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurHP[i+1],2^CBit),SetMemory(0x662350+(MarID[i+1]*4),Add,9216*(2^CBit)),AddV(MarHPRead[i+1],9216*(2^CBit)),SetMemory(0x515BB0+(i*4),Add,9*(2^CBit))},{Preserved})
		end
		CIfX(FP,{CV(CurAtk[i+1],250)},{SetMemoryB(0x58D2B0+(46*i)+8,SetTo,3),SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(9999*256)+1)})
		CElseIfX({CV(CurAtk[i+1],AtkCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i)+7,SetTo,250),SetMemoryB(0x58D2B0+(46*i)+8,SetTo,3)})
		CElseX({SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0)})
		CIfXEnd()
		CIfX(FP,{CV(CurHP[i+1],250)},{SetMemoryB(0x58D2B0+(46*i)+1,SetTo,3),SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemory(0x515BB0+(i*4),SetTo,2560)})
		CElseIfX({CV(CurHP[i+1],HPCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i),SetTo,250),SetMemoryB(0x58D2B0+(46*i)+1,SetTo,3)})
		CElseX({SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0)})
		CIfXEnd()
		
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
			GiveUnits(All,70,CurrentPlayer,"Anywhere",11);
			RemoveUnitAt(All,70,"Anywhere",11);
			DisplayText(GiveRateT[k+1],4);
			SetCDeaths(FP,Add,1,GiveRate[i+1]);
			PreserveTrigger();
			},
	}
	end
	CSub(FP,ShieldEnV[i+1],Dt)
	local ExchangeP = CreateVar(FP)
	for i=0, 3 do
		ExJump = def_sIndex()
		NJump(FP,ExJump,{PlayerCheck(i,1),Deaths(i,AtMost,0,"Terran Barracks"),Bring(i,AtMost,0,"Men",17),Bring(i,AtMost,0,"Men",18),Bring(i,AtMost,0,"Men",19),Bring(i,AtMost,0,"Men",20)})
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
			Bring(i,AtLeast,1,"Terran Wraith",64);
	
		},
		actions = {
			RemoveUnitAt(1,"Terran Wraith","Anywhere",i);
			CreateUnitWithProperties(1,MarID[i+1],2+i,i,{energy = 100});
			DisplayText(StrDesign("\x1F광물\x04을 소모하여 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ을 \x19소환\x04하였습니다. - \x1F25000 O r e"),4);
			--SetCDeaths(FP,Add,1,MarCreate);
			PreserveTrigger();
		},
	}
	Trigger { -- 자동환전
		players = {i},
		conditions = {
			Command(CurrentPlayer,AtLeast,1,"Terran Vulture");
		},
		actions = {
			RemoveUnitAt(1,"Terran Vulture","Anywhere",CurrentPlayer);
			SetDeaths(CurrentPlayer,SetTo,1,"Terran Barracks");
			DisplayText(StrDesign("\x07자동환전\x04을 사용하셨습니다."),4);
			PreserveTrigger();
		},
	}
	Trigger { -- 공업완료시 수정보호막 활성화
	players = {i},
	conditions = {
		Label(0);
		MemoryB(0x58D2B0+(46*i)+7,AtLeast,250);
	},
	actions = {
		PlayWAV("staredit\\wav\\shield_unlock.ogg");
		PlayWAV("staredit\\wav\\shield_unlock.ogg");
		SetV(ShieldEnV[i+1],3200);
		SetCDeaths(i,SetTo,1,ShieldUnlock);
	},
	}
	Trigger { -- 공업완료시 수정보호막 활성화
		players = {i},
		conditions = {
			Label(0);
			CDeaths(i,AtLeast,1,ShieldUnlock);
			MemoryB(0x58D2B0+(46*i)+7,AtLeast,250);
			CV(ShieldEnV[i+1],0);
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
			DisplayText("\n",4);
			DisplayText(StrDesignX("\x08공격력 \x04업그레이드를 완료하였습니다.\n\x13\x04이제부터 \x1C빛의 보호막\x04을 사용할 수 있습니다."),0);
			DisplayText("\n",4);
			DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			SetMemory(0x5822C4+(i*4),SetTo,1200);
			SetMemory(0x582264+(i*4),SetTo,1200);
			SetMemoryB(0x57F27C+(228*i)+19,SetTo,1);
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
		SetResources(i,Add,30000,Ore);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText(StrDesign("\x04이미 \x1C빛의 보호막\x04을 사용중입니다. 자원 반환 + \x1F25000 Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
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
		SetResources(i,Add,30000,Ore);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText(StrDesign("\x1C빛의 보호막\x04이 현재 \x0E쿨타임 \x04중입니다. 자원 반환 + \x1F25000 Ore"),4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
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
		RemoveUnitAt(1,19,"Anywhere",i);
		RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i+1].."Shield".._0D,4),PlayWAVX("staredit\\wav\\shield_use.ogg")},HumanPlayers,i);
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

	TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{Preserved})
	for j=0, 3 do
		if i~=j then
		for l=0, 5 do
		Trigger { -- 돈 기부 시스템
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
				DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
				PreserveTrigger();
			},
			}
		Trigger { -- 돈 기부 시스템
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
				DisplayText(StrDesign(PlayerString[j+1].."\x04에게 \x1F"..GiveRate2[l+1].." Ore\x04를 기부하였습니다."),4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText(StrDesign(PlayerString[i+1].."\x04에게 \x1F"..GiveRate2[l+1].." Ore\x04를 기부받았습니다."),4);
				SetMemory(0x6509B0,SetTo,i);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- 돈 기부 시스템
			players = {i},
			conditions = {
				--MemoryB(0x58D2B0+(46*i)+GiveUnitID[j+1],AtLeast,1);
				Command(i,AtLeast,1,GiveUnitID[j+1]);
				PlayerCheck(j,0);
			},
			actions = {
				DisplayText(StrDesign(PlayerString[j+1].."\x04이(가) 존재하지 않습니다."),4);
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
		DisplayText(StrDesign("\x1CBGM\x04을 듣지 않습니다."),4);
		SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
	},{Preserved})

	Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,22);},{
		GiveUnits(All,22,i,"Anywhere",P12);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText(StrDesign("\x1CBGM\x04을 듣습니다."),4);
		SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
	},{Preserved})


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
		RemoveUnitAt(1,71,"Anywhere",i);
		DisplayText(StrDesign("\x04원격 \x1B스팀팩\x04기능을 사용합니다. - \x1F1000 Ore"),4);
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
DoActionsX(FP,{SetCDeaths(FP,Add,1,HealT)})
CIf(FP,CDeaths(FP,AtLeast,50,HealT),SetCDeaths(FP,SetTo,0,HealT))
for i = 0, 3 do
	Trigger2(FP,{PlayerCheck(i,1)},{
		ModifyUnitHitPoints(All,"Men",Force1,i+2,100),
		ModifyUnitShields(All,"Men",Force1,i+2,100),
		ModifyUnitHitPoints(All,"Buildings",Force1,i+2,100),
		ModifyUnitShields(All,"Buildings",Force1,i+2,100)},{Preserved})
end
CIfEnd()
	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)},{SetCD(AFlag,0),SetCD(BFlag,2)})
	f_Read(FP,0x6284B8,nil,SelEPD)
	f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
	SelClass = Act_BRead(_Add(SelUID,0x663DD0))
	CTrigger(FP,{CVar(FP,SelClass[2],Exactly,162)},{SetCD(BFlag,1)},1)
	CTrigger(FP,{CVar(FP,SelClass[2],Exactly,161)},{SetCD(BFlag,0)},1)
	CIf(FP,{TMemoryX(_Add(SelEPD,19),AtLeast,4,0xFF),CD(BFlag,1,AtMost)})
	f_Read(FP,_Add(SelEPD,2),SelHP)
	f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)

	
	TriggerX(FP,CV(SelUID,5),SetV(SelUID,6),{Preserved})
	TriggerX(FP,CV(SelUID,23),SetV(SelUID,24),{Preserved})
	TriggerX(FP,CV(SelUID,25),SetV(SelUID,26),{Preserved})
	TriggerX(FP,CV(SelUID,30),SetV(SelUID,31),{Preserved})
	TriggerX(FP,CV(SelUID,3),SetV(SelUID,4),{Preserved})
	TriggerX(FP,CV(SelUID,17),SetV(SelUID,18),{Preserved})
	TriggerX(FP,CV(SelUID,77),SetCD(AFlag,1),{Preserved})
	TriggerX(FP,CV(SelUID,65),SetCD(AFlag,1),{Preserved})
	TriggerX(FP,CV(SelUID,10),SetCD(AFlag,1),{Preserved})
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
	ItoDec(FP,SelHP,VArr(SelHPVA,0),2,0x08,0)--체
	ItoDec(FP,SelSh,VArr(SelShVA,0),2,0x1C,0)--쉴

	CIfX(FP,CD(BFlag,0))
	ItoDec(FP,SelATK,VArr(SelATKVA,0),2,0x1B,0)--일반딜
	f_Movcpy(FP,NMDMGTblPtr,VArr(SelHPVA,0),4*4)
	f_Movcpy(FP,_Add(NMDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]),VArr(SelShVA,0),4*4)
	f_Movcpy(FP,_Add(NMDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]),VArr(SelATKVA,0),4*4)
	CElseX()
	ItoDec(FP,_Div(SelATK,10),VArr(SelATKVA,0),2,0x1F,0)--퍼딜1
	ItoDec(FP,_Mod(SelATK,10),VArr(SelATKVA2,0),2,0x1F,0)--퍼딜2
	f_Movcpy(FP,PerDMGTblPtr,VArr(SelHPVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]),VArr(SelShVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]),VArr(SelATKVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]+(4*4)+ClassInfo6[2]),VArr(SelATKVA2,0),4*4)
	CIfXEnd()



	CIfEnd()
	CIfEnd()


		
	CIf(FP,CDeaths(FP,AtLeast,1,CUnitFlag)) -- 원격스팀
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