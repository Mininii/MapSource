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
	StrDesign("\x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F500000 Ore \x04로 변경되었습니다."),
	StrDesign("\x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.")}
	CMov(FP,AtkCondTmp,_Add(Level,Level),150)
	CMov(FP,HPCondTmp,_Add(_Add(Level,Level),_Add(Level,Level)),50)
	for i = 0, 3 do
		CIf(FP,PlayerCheck(i,1),{SetV(CurAtk[i+1],0),SetV(CurHP[i+1],0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(1000*256)-255),SetMemory(0x515BB0+(i*4),SetTo,256)})

		for CBit = 0, 7 do
			TriggerX(FP,{MemoryX(AtkUpgradePtrArr[i+1],Exactly,(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit),(256^AtkUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurAtk[i+1],2^CBit)},{Preserved})
			TriggerX(FP,{MemoryX(HPUpgradePtrArr[i+1],Exactly,(256^HPUpgradeMaskRetArr[i+1])*(2^CBit),(256^HPUpgradeMaskRetArr[i+1])*(2^CBit))},{AddV(CurHP[i+1],2^CBit),SetMemory(0x662350+(MarID[i+1]*4),Add,9216*(2^CBit)),SetMemory(0x515BB0+(i*4),Add,9*(2^CBit))},{Preserved})
		end
		CIfX(FP,{CV(CurAtk[i+1],250)},{SetMemoryB(0x58D2B0+(i*24)+8,SetTo,3),SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemory(0x662350+(MarID[i+1]*4),SetTo,(9999*256)+1)})
		CElseIfX({CV(CurAtk[i+1],AtkCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i)+7,SetTo,250),SetMemoryB(0x58D2B0+(i*24)+8,SetTo,3)})
		CElseX({SetMemoryB(0x58D088+(46*i)+7,SetTo,0),SetMemoryB(0x58D2B0+(i*24)+8,SetTo,0)})
		CIfXEnd()
		CIfX(FP,{CV(CurHP[i+1],250)},{SetMemoryB(0x58D2B0+(i*24)+1,SetTo,3),SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemory(0x515BB0+(i*4),SetTo,2560)})
		CElseIfX({CV(CurHP[i+1],HPCondTmp,AtMost)},{SetMemoryB(0x58D088+(46*i),SetTo,250),SetMemoryB(0x58D2B0+(i*24)+1,SetTo,3)})
		CElseX({SetMemoryB(0x58D088+(46*i),SetTo,0),SetMemoryB(0x58D2B0+(i*24)+1,SetTo,0)})
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
	
	--선택인식 피통 보임 비공유
	SelEPD,SelHP,SelSh,SelMaxHP = CreateVars(4,FP)
	SelWepID_Mask = CreateVar(FP)
	SelWepID_Mask2 = CreateVar(FP)
	SelUID_Mask = CreateVar(FP)
	SelUID_Atk = CreateVar(FP)
	SelUID_Atk2 = CreateVar(FP)
	SelWep = CreateVar(FP)
	SelWepID = CreateVar(FP)
	SelUID = CreateVar(FP)
	SelATK = CreateVar(FP)
	SelClass = CreateVar(FP)
	SelClass_Mask = CreateVar(FP)
SelHPVA = CreateVArr(4,FP)
SelShVA = CreateVArr(4,FP)
SelMaxHPVA = CreateVArr(4,FP)
SelATKVA = CreateVArr(4,FP)
SelATKVA2 = CreateVArr(4,FP)
AFlag = CreateCcode()
BFlag = CreateCcode()
--DoActionsX(FP,SetMemory(0x58F448,SetTo,0xFFFFFFFF))

	CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)},{SetCD(AFlag,0),SetCD(BFlag,2)})
	f_Read(FP,0x6284B8,nil,SelEPD)
	f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
	f_Mod(FP,SelClass_Mask,SelUID,4)
	f_Read(FP,_Add(_Div(SelUID,4),EPDF(0x663DD0)),SelClass)
	CTrigger(FP,{CV(SelClass_Mask,0),CVar(FP,SelClass[2],Exactly,162,0xFF)},{SetCD(BFlag,1)},1)
	CTrigger(FP,{CV(SelClass_Mask,1),CVar(FP,SelClass[2],Exactly,162*256,0xFF00)},{SetCD(BFlag,1)},1)
	CTrigger(FP,{CV(SelClass_Mask,2),CVar(FP,SelClass[2],Exactly,162*65536,0xFF0000)},{SetCD(BFlag,1)},1)
	CTrigger(FP,{CV(SelClass_Mask,3),CVar(FP,SelClass[2],Exactly,162*16777216,0xFF000000)},{SetCD(BFlag,1)},1)
	CTrigger(FP,{CV(SelClass_Mask,0),CVar(FP,SelClass[2],Exactly,161,0xFF)},{SetCD(BFlag,0)},1)
	CTrigger(FP,{CV(SelClass_Mask,1),CVar(FP,SelClass[2],Exactly,161*256,0xFF00)},{SetCD(BFlag,0)},1)
	CTrigger(FP,{CV(SelClass_Mask,2),CVar(FP,SelClass[2],Exactly,161*65536,0xFF0000)},{SetCD(BFlag,0)},1)
	CTrigger(FP,{CV(SelClass_Mask,3),CVar(FP,SelClass[2],Exactly,161*16777216,0xFF000000)},{SetCD(BFlag,0)},1)
	CIf(FP,{TMemoryX(_Add(SelEPD,19),AtLeast,4,0xFF),CD(BFlag,1,AtMost)})
	f_Read(FP,_Add(SelEPD,2),SelHP)
	f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
	CMov(FP,SelMaxHP,_Div(_ReadF(_Add(SelUID,_Mov(EPDF(0x662350)))),_Mov(256)))

	
	TriggerX(FP,CV(SelUID,5),SetV(SelUID,6),{Preserved})
	TriggerX(FP,CV(SelUID,23),SetV(SelUID,24),{Preserved})
	TriggerX(FP,CV(SelUID,25),SetV(SelUID,26),{Preserved})
	TriggerX(FP,CV(SelUID,30),SetV(SelUID,31),{Preserved})
	TriggerX(FP,CV(SelUID,3),SetV(SelUID,4),{Preserved})
	TriggerX(FP,CV(SelUID,17),SetV(SelUID,18),{Preserved})
	TriggerX(FP,CV(SelUID,77),SetCD(AFlag,1),{Preserved})
	TriggerX(FP,CV(SelUID,65),SetCD(AFlag,1),{Preserved})
	TriggerX(FP,CV(SelUID,10),SetCD(AFlag,1),{Preserved})

	f_Mod(FP,SelUID_Mask,SelUID,4)
	f_Read(FP,_Add(_Div(SelUID,4),EPDF(0x6636B8)),SelWep)
	CTrigger(FP,{CV(SelUID_Mask,0)},{TSetCVar(FP,SelWepID[2],SetTo,SelWep,0xFF)},1)
	CTrigger(FP,{CV(SelUID_Mask,1)},{TSetCVar(FP,SelWepID[2],SetTo,_Div(SelWep,0x100),0xFF)},1)
	CTrigger(FP,{CV(SelUID_Mask,2)},{TSetCVar(FP,SelWepID[2],SetTo,_Div(SelWep,0x10000),0xFF)},1)
	CTrigger(FP,{CV(SelUID_Mask,3)},{TSetCVar(FP,SelWepID[2],SetTo,_Div(SelWep,0x1000000),0xFF)},1)
	f_Mod(FP,SelWepID_Mask,SelWepID,2)
	f_Mod(FP,SelWepID_Mask2,SelWepID,4)
	f_Read(FP,_Add(_Div(SelWepID,2),EPDF(0x656EB0)),SelUID_Atk)
	f_Read(FP,_Add(_Div(SelWepID,4),EPDF(0x6564E0)),SelUID_Atk2)
	CTrigger(FP,{CV(SelWepID_Mask,0)},{TSetCVar(FP,SelATK[2],SetTo,SelUID_Atk,0xFFFF)},1)
	CTrigger(FP,{CV(SelWepID_Mask,1)},{TSetCVar(FP,SelATK[2],SetTo,_Div(SelUID_Atk,0x10000),0xFFFF)},1)
	CTrigger(FP,{CV(SelWepID_Mask2,0),CVar(FP,SelUID_Atk2[2],Exactly,2,0xFF)},{SetCD(AFlag,1)},1)
	CTrigger(FP,{CV(SelWepID_Mask2,1),CVar(FP,SelUID_Atk2[2],Exactly,2*256,0xFF00)},{SetCD(AFlag,1)},1)
	CTrigger(FP,{CV(SelWepID_Mask2,2),CVar(FP,SelUID_Atk2[2],Exactly,2*65536,0xFF0000)},{SetCD(AFlag,1)},1)
	CTrigger(FP,{CV(SelWepID_Mask2,3),CVar(FP,SelUID_Atk2[2],Exactly,2*16777216,0xFF000000)},{SetCD(AFlag,1)},1)
	CIf(FP,{CD(AFlag,1)})
		CAdd(FP,SelATK,SelATK)
	CIfEnd()
	f_Div(FP,SelHP,_Mov(256))
	f_Div(FP,SelSh,_Mov(256))
	ItoDec(FP,SelHP,VArr(SelHPVA,0),2,0x08,0)--체
	ItoDec(FP,SelMaxHP,VArr(SelMaxHPVA,0),2,0x19,0)--체
	ItoDec(FP,SelSh,VArr(SelShVA,0),2,0x1C,0)--쉴

	CIfX(FP,CD(BFlag,0))
	ItoDec(FP,SelATK,VArr(SelATKVA,0),2,0x1B,0)--일반딜
	f_Movcpy(FP,NMDMGTblPtr,VArr(SelHPVA,0),4*4)
	f_Movcpy(FP,_Add(NMDMGTblPtr,(4*4)+ClassInfo1[2]),VArr(SelMaxHPVA,0),4*4)
	f_Movcpy(FP,_Add(NMDMGTblPtr,(4*4)+ClassInfo1[2]+(4*4)+ClassInfo2[2]),VArr(SelShVA,0),4*4)
	f_Movcpy(FP,_Add(NMDMGTblPtr,(4*4)+ClassInfo1[2]+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]),VArr(SelATKVA,0),4*4)
	CElseX()
	ItoDec(FP,_Div(SelATK,10),VArr(SelATKVA,0),2,0x1F,0)--퍼딜1
	ItoDec(FP,_Mod(SelATK,10),VArr(SelATKVA2,0),2,0x1F,0)--퍼딜2
	f_Movcpy(FP,PerDMGTblPtr,VArr(SelHPVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+ClassInfo1[2]),VArr(SelMaxHPVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+ClassInfo1[2]+(4*4)+ClassInfo2[2]),VArr(SelShVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+ClassInfo1[2]+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]),VArr(SelATKVA,0),4*4)
	f_Movcpy(FP,_Add(PerDMGTblPtr,(4*4)+ClassInfo1[2]+(4*4)+ClassInfo2[2]+(4*4)+ClassInfo3[2]+(4*4)+ClassInfo6[2]),VArr(SelATKVA2,0),4*4)
	CIfXEnd()


	--SelHP 
	--SelSh 
	--SelMaxHP 
	--SelATK 


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