function Interface()
	Trigger { -- 조합법 insert키
		players = {Force1},
		conditions = {
			Memory(0x596A44, Exactly, 0x00000100);
		},
		actions = {
			DisplayText("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x12\x04간단 조합법\n\x12\x04Marine + \x1F"..HMCost.."원 \x04= \x1BH \x04Marine\n\x12\x1BH \x04Marine + \x1F"..GMCost.."원 \x04= \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\n\x12\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04 + \x1F"..NeCost.."원 \x04= \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\n\x12\x04히든조합은 없습니다.\n\x12\x04환전 : \x03배럭에서 F를 누르세요.\n\x12\x04닫기 : \x03Delete\n\n\n",4);
			PreserveTrigger();
		},
	}
	Trigger { -- 채팅창 정리 delete키
		players = {Force1},
		conditions = {
			Memory(0x596A44, Exactly, 65536);
	},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			PreserveTrigger();
			},
		}
	Trigger { -- 동맹상태 고정
	players = {Force1},
	actions = {
		SetAllianceStatus(Force1,Ally);
		SetAllianceStatus(P12,Enemy);
		RunAIScript("Turn ON Shared Vision for Player 1");
		RunAIScript("Turn ON Shared Vision for Player 2");
		RunAIScript("Turn ON Shared Vision for Player 3");
		RunAIScript("Turn ON Shared Vision for Player 4");
		RunAIScript("Turn ON Shared Vision for Player 5");
		RunAIScript("Turn ON Shared Vision for Player 6");
		RunAIScript("Turn ON Shared Vision for Player 7");
		PreserveTrigger();
	},
}
	for i = 1, 6 do -- 강퇴기능
		Trigger { -- 강퇴토큰
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
				Trigger { -- 강퇴토큰
					players = {i},
					conditions = {
						Label(0);
						CDeaths(FP,Exactly,j,BanCode[i]);
					},
					actions = {
						RotatePlayer({DisplayTextX("\x07『 "..PlayerString[i+1].."\x04에게 \x08경고가 총 "..j.."회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다. \x07』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
						},
					}
			end
			Trigger { -- 강퇴
			players = {i},
			conditions = {
				Label(0);
				CDeaths(FP,AtLeast,5,BanCode[i]);
			},
			actions = {
				RotatePlayer({DisplayTextX("\x07『 \x04"..PlayerString[i+1].."\x04의 강퇴처리가 완료되었습니다.\x07 』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
				},
			}
			Trigger { -- 강퇴 드랍
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
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					DisplayText("\x07『 \x04당신은 강되당했습니다. 드랍 코드 0x32223223 작동.\x07 』",4);
					SetMemory(0xCDDDCDDC,SetTo,1);
					
					},
				}
			end
	for i = 0, 6 do
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
		
			Trigger2(i,{DeathsX(i,Exactly,0,12,0xFF000000);Command(i,AtLeast,1,3);},{
				GiveUnits(All,3,i,"Anywhere",P12);
				RemoveUnitAt(All,3,"Anywhere",P12);
				DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
				SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
			},{Preserved})

			Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,3);},{
				GiveUnits(All,3,i,"Anywhere",P12);
				RemoveUnitAt(All,3,"Anywhere",P12);
				DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
				SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
			},{Preserved})

			for k = 0, 5 do
				Trigger { -- 기부 금액 변경
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
		TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{Preserved})

		
Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D2B0+(46*i)+0,Exactly,255);
	},
	actions = {
		SetMemoryB(0x58D088+(46*i)+1,SetTo,0);
		SetMemoryB(0x58D088+(46*i)+2,SetTo,0);
	}
}

Trigger { -- 자동환전
players = {i},
conditions = {
	Command(i,AtLeast,1,"Terran Vulture");
},
actions = {
	RemoveUnitAt(1,"Terran Vulture","Anywhere",i);
	SetDeaths(i,SetTo,50,"Terran Barracks");
	DisplayText(StrDesign("\x07자동환전\x04을 사용하셨습니다. - \x1F1000 O r e"),4);
	PreserveTrigger();
},
}
CIf(FP,{HumanCheck(i,1)})


local ExchangeP = CreateVar(FP)
local TempScore=CreateVar(FP)
local TempOre=CreateVar(FP)
	ExJump = def_sIndex()
	NJump(FP,ExJump,{Deaths(i,AtMost,0,"Terran Barracks"),Bring(i,AtMost,0,"Men",2)})
	CIf(FP,Score(i,Kills,AtLeast,1000))
	f_Read(FP,0x581F04+(i*4),TempScore)
	f_Div(FP,ExchangeP,TempScore,1000)
	f_Mod(FP,0x581F04+(i*4),TempScore,1000)
	f_Mul(FP,TempOre,ExchangeP,ExRateV)
	CAdd(FP,0x57F0F0+(i*4),TempOre)
	CMov(FP,0x6509B0,FP)
	CIfEnd({SetV(TempScore,0),
	SetV(ExchangeP,0),
	SetV(TempOre,0)})
	DoActions(FP,SetDeaths(i,Subtract,1,111))
	NJumpEnd(FP,ExJump)

HealT = CreateCcode()

Trigger { -- 힐존트리거
players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,HealT);
	},
	actions = {
		SetCDeaths(FP,Add,50,HealT);
		ModifyUnitHitPoints(All,"Men",Force1,4,100);
		ModifyUnitShields(All,"Men",Force1,4,100);
		PreserveTrigger();
	},
}
DoActionsX(FP,{SubCD(HealT,1)})

	for j = 1, 5 do
TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+7,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+8,SetTo,0),
	SetMemoryB(0x58D088+(46*i)+9,SetTo,0)
})

TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,j),MemoryB(0x58D2B0+(46*i)+14,Exactly,50+(200-(40*j)))},{
	SetMemoryB(0x58D088+(46*i)+13,SetTo,0),
})

	end

TriggerX(FP,{CVar(FP,HiddenATKM[2],Exactly,0),MemoryB(0x58D2B0+(46*i)+7,Exactly,255)},{
	SetMemoryB(0x58D088+(46*i)+8,SetTo,0),
	SetMemoryB(0x58D088+(46*i)+9,SetTo,0)
})

UpButtonSetArr = {}
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+9,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0))
table.insert(UpButtonSetArr,SetMemoryB(0x58D2B0+(46*i)+2,SetTo,0))



local MedicTrigJump = def_sIndex()
for j = 1, 4 do
	NJumpX(FP,MedicTrigJump,{CDeaths(FP,Exactly,j-1,DelayMedic[i+1]),Bring(i,AtLeast,1,MedicTrig[j],64)})
end
NIf(FP,Never())
	NJumpXEnd(FP,MedicTrigJump)
	TriggerX(FP,{CV(HiddenHPM,0)},{
		RemoveUnit(MedicTrig[1],i),
		RemoveUnit(MedicTrig[2],i),
		RemoveUnit(MedicTrig[3],i),
		RemoveUnit(MedicTrig[4],i),
		ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
		ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
		ModifyUnitShields(All,"Men",i,"Anywhere",100),
		ModifyUnitShields(All,"Buildings",i,"Anywhere",100)
	},{Preserved})
	TriggerX(FP,{CV(HiddenHPM,1,AtLeast)},{
		RemoveUnit(MedicTrig[1],i),
		RemoveUnit(MedicTrig[2],i),
		RemoveUnit(MedicTrig[3],i),
		RemoveUnit(MedicTrig[4],i),
		SetDeaths(i,SetTo,1,34);
		SetCD(CUnitFlag,1)
	},{Preserved})

		
--				TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,3),Bring(FP, AtMost, 0, 147, 64)},{
--					ModifyUnitShields(All,"Men",i,"Anywhere",0),
--					ModifyUnitShields(All,"Buildings",i,"Anywhere",0)},{Preserved})
NIfEnd()
DoActionsX(FP,{
SetV(TempUpgradeMaskRet,0),
SetV(TempUpgradePtr,0),
SetV(CurrentUpgrade,0),
SetV(CurrentFactor,0),
SetV(UpCount,0)
})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+8,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(AtkUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk)
})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+9,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(AtkUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,10),
	SetMemoryB(0x58D2B0+(46*i)+9,SetTo,0),
	SetCDeaths(FP,SetTo,1,ifUpisAtk),

})

CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+1,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(DefUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,DefFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,255),
	SetMemoryB(0x58D2B0+(46*i)+1,SetTo,0),
	SetCDeaths(FP,SetTo,0,ifUpisAtk)

})
CallTriggerX(FP,Call_OCU,MemoryB(0x58D2B0+(46*i)+2,AtLeast,1),{
	SetCVar(FP,TempUpgradePtr[2],SetTo,EPDF(DefUpgradePtrArr[i+1])),
	SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^DefUpgradeMaskRetArr[i+1]),
	SetCVar(FP,UpgradeFactor[2],SetTo,DefFactor),
	SetCVar(FP,UpgradeCP[2],SetTo,i),
	SetCVar(FP,UpgradeMax[2],SetTo,10),
	SetMemoryB(0x58D2B0+(46*i)+2,SetTo,0),
	SetCDeaths(FP,SetTo,0,ifUpisAtk)
})
DoActions2(FP,UpButtonSetArr)
CIf(FP,{CD(FormCcode,0)})
	for NB = 0, 6 do -- 중벙 트리거
	Trigger {
		players = {FP},
		conditions = {
			Bring(i,AtLeast,1,"Men",NB+5);
			Bring(P10,AtLeast,1,125,NB+5);
		},
		actions = {
			GiveUnits(All,125,P10,NB+5,i);
			PreserveTrigger();
		},
	}
	Trigger {
		players = {FP},
		conditions = {
			Bring(i,Exactly,0,"Men",NB+5);
			Bring(i,AtLeast,1,125,NB+5);
		},
		actions = {
			GiveUnits(All,125,i,NB+5,P8);
			PreserveTrigger();
		},
	}
	end
	DoActions(FP,{GiveUnits(All,125,P12,64,P10),GiveUnits(All,125,P8,64,P10)})
CIfEnd()
CIfEnd()
	end
	for j=0, 6 do


	Trigger { -- 소환 마린
	players = {j},
	conditions = {
		Command(j,AtLeast,1,"Terran Firebat");
	},
	actions = {
		RemoveUnitAt(1,"Terran Firebat","Anywhere",j);
		CreateUnitWithProperties(1,0,4,j,{energy = 100});
		DisplayText("\x02▶ \x04Marine을 \x19소환\x04하였습니다. - \x1F"..NMCost.." O r e",4);
		SetDeaths(j,SetTo,1,101);
		PreserveTrigger();
	},
}
Trigger { -- 소환 갤마
players = {j},
conditions = {
	Command(j,AtLeast,1,1);
	Deaths(j,AtMost,23,125);
},
actions = {
	SetResources(j,Add,NMCost+GMCost+HMCost,ore);
	RemoveUnitAt(1,1,"Anywhere",j);
	DisplayText("\x02▶ \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine \x0424기 조합) 자원 반환 + \x1F"..(NMCost+GMCost+HMCost).." O r e",4);
	PreserveTrigger();
},
}

Trigger { -- 소환 갤마
players = {j},
conditions = {
	Deaths(j,AtLeast,24,125);
	Command(j,AtLeast,1,1);
},
actions = {
	RemoveUnitAt(1,1,"Anywhere",j);
	DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine을 \x19소환\x04하였습니다. - \x1F"..(GMCost+NMCost+HMCost).." O r e",4);
	CreateUnitWithProperties(1,100,4,j,{energy = 100});
	SetDeaths(j,SetTo,1,101);
	PreserveTrigger();
},
}

Trigger { -- 조합 영웅마린
players = {j},
conditions = {
	Bring(j,AtLeast,1,0,3);
	Accumulate(j,AtLeast,HMCost,Ore);
},
actions = {
	ModifyUnitEnergy(1,0,j,3,0);
	SetResources(j,Subtract,HMCost,ore);
	RemoveUnitAt(1,0,3,j);
	CreateUnitWithProperties(1,20,4,j,{energy = 100});
	DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x04Marine을 \x1BH \x04Marine으로 \x19변환\x04하였습니다. - \x1F"..HMCost.." O r e",4);
	PreserveTrigger();
},
}
Trigger { -- 조합 갤럭시 마린
players = {j},
conditions = {
	Bring(j,AtLeast,1,20,3);
	Accumulate(j,AtLeast,GMCost,Ore);
},
actions = {
	ModifyUnitEnergy(1,20,j,3,0);
	SetResources(j,Subtract,GMCost,ore);
	RemoveUnitAt(1,20,3,j);
	CreateUnitWithProperties(1,100,4,j,{energy = 100});
	SetDeaths(j,Add,1,125);
	DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x1BH \x04Marine을 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine으로 \x19변환\x04하였습니다. - \x1F"..GMCost.." O r e",4);
	PreserveTrigger();
},
}
Trigger { -- 조합 네뷸라
players = {j},
conditions = {
	Label(0);
--	Command(j,AtMost,0,16);
	Bring(j,AtLeast,1,100,3);
	Accumulate(j,AtLeast,NeCost,Ore);
},
actions = {
	ModifyUnitEnergy(1,100,j,3,0);
	SetResources(j,Subtract,NeCost,ore);
	RemoveUnitAt(1,100,3,j);
	DisplayText("\x02▶ \x1F광물\x04을 소모하여 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine 을 \x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ 으로 \x19변환\x04하였습니다. - \x1F"..NeCost.." O r e\n",4);
	CreateUnitWithProperties(1,16,4,j,{energy = 100});
	PreserveTrigger();
},
}
	end

	for k=0, 6 do -- 기부시스템
		for j=0, 6 do
		if k~=j then
		for i=0, 5 do
		Trigger { -- 돈 기부 시스템
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
				DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
				PreserveTrigger();
			},
			}
		Trigger { -- 돈 기부 시스템
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
				DisplayText("\x07『 "..PlayerString[j+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부하였습니다. \x07』",4);
				SetMemory(0x6509B0,SetTo,j);
				DisplayText("\x12\x07『"..PlayerString[k+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부받았습니다.\x02 \x07』",4);
				SetMemory(0x6509B0,SetTo,k);
				PreserveTrigger();
			},
			}
		end
		Trigger { -- 돈 기부 시스템
			players = {k},
			conditions = {
				--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
				Command(k,AtLeast,1,GiveUnitID[j+1]);
				HumanCheck(j,0);
			},
			actions = {
				DisplayText("\x07『 "..PlayerString[j+1].."\x04이(가) 존재하지 않습니다. \x07』",4);
				--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
				RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
				PreserveTrigger();
			},
			}
	end end end
	CallTxt = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04\n\x13\x04\x04현재 마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \x04를 플레이 중입니다.\n\x13\n\x13\x1FCtrig \x04Assembler \x07v5.4\x04, \x1FCB \x16Paint \x07v2.4 \x04in Used \x19(つ>ㅅ<)つ\n\x13\x0FCreator \x04: GALAXY_BURST\n\x13\x07제작자 오픈카톡 \x04: https://open.kakao.com/o/sejFLxdb\n\x13\x04\n\x13\x04지원금 \x1F2000 Ore\x04를 받았습니다.\n\x13\x04\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	TriggerX(FP,{CD(ButtonSound,1,AtLeast)},{
		RotatePlayer({
		PlayWAVX("staredit\\wav\\button3.wav"),
		PlayWAVX("staredit\\wav\\button3.wav")
		},HumanPlayers,FP);
		SetCD(ButtonSound,0);
	},{Preserved})
	TriggerX(FP,{CD(NoticeCD,1,AtLeast)},{
		RotatePlayer({
		PlayWAVX("staredit\\wav\\notice.wav"),
		PlayWAVX("staredit\\wav\\notice.wav"),
		DisplayTextX(CallTxt,4)
		},HumanPlayers,FP);
		SetCD(NoticeCD,0);SetResources(Force1,Add,2000,Ore)
	},{Preserved})
	if Limit == 1 then
		--TriggerX(FP,{CD(TestMode,1)},{ModifyUnitHitPoints(All,"Men",Force1,64,100)},{Preserved})
	end


	CIf(FP,{CV(HiddenHPM,1,AtLeast),CD(CUnitFlag,1,AtLeast)},{SetCD(CUnitFlag,0)})
	FuncJump = def_sIndex()
	CJump(FP,FuncJump)
	MedicFunc = SetCallForward()
	SetCall(FP)
	CAdd(FP,0x6509B0,6)
	for i = 1, 5 do
		for j, k in pairs(MedicFuncArr) do
			TriggerX(FP,{CV(HiddenHPM,i),DeathsX(CurrentPlayer,Exactly,k,0,0xFF)},{
				SetMemory(0x6509B0,Subtract,23),
				SetDeaths(CurrentPlayer,Add,(MedicFuncArr2[j]-(MedicFuncArr2[j]*(0.16*i)))*256,0);
				SetMemory(0x6509B0,Add,22),
				SetDeathsX(CurrentPlayer,Add,(MedicFuncArr3[j]-(MedicFuncArr3[j]*(0.16*i)))*256,0,0xFFFFFF);
				SetMemory(0x6509B0,Add,1),
			},{Preserved})
		end
	end

	CSub(FP,0x6509B0,6)
	SetCallEnd()
	CJumpEnd(FP,FuncJump)
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	for i = 0, 6 do
		CallTriggerX(FP,MedicFunc,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF),Deaths(i,AtLeast,1,34)})
	end
	

	CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	DoActions(FP,{SetDeaths(Force1,SetTo,0,34)})
	CIfEnd()
	

end 