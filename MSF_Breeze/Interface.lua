function Interface()
	local DelayMedic = CreateCcodeArr(7)
	local GiveRate = CreateCcodeArr(7)
	local BanCode = CreateCcodeArr(6)
	local CurrentOP = CreateVar(FP)
	AddBGM(1,"staredit\\wav\\BrOP.ogg",152*1000)--오프닝
	IBGM_EPDX(FP,6,Dt,nil,{12})
	Install_BGMSystem(FP,6,BGMType,12,1,1,ObPlayers)
	DoActionsX(FP, {SetV(BGMType,1)},1)


	
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
        CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),GiveUnits(All, 115,AllPlayers, 64, i)})

	end
    CIfXEnd()




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
					RotatePlayer({DisplayTextX("\x07『 "..PlayerString[i+1].."\x04에게 \x08경고가 총 "..j.."회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다. \x07』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
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

	local ExchangeP = CreateVar(FP)
	for i = 0, 6 do
		CIf(FP,HumanCheck(i,1))
		ExJump = def_sIndex()
		NJump(FP,ExJump,{Deaths(i,AtMost,0,111),Bring(i,AtMost,0,"Men",3),Bring(i,AtMost,0,"Men",4)})
		CIf(FP,Score(i,Kills,AtLeast,1000))
		CMov(FP,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CMov(FP,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
		CAdd(FP,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),_Mov(10)))--고정 10%
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
			DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
			SetDeathsX(i,SetTo,1*16777216,12,0xFF000000);
		},{preserved})

		Trigger2(i,{DeathsX(i,Exactly,1*16777216,12,0xFF000000);Command(i,AtLeast,1,3);},{
			GiveUnits(All,3,i,"Anywhere",P12);
			RemoveUnitAt(All,3,"Anywhere",P12);
			DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
			SetDeathsX(i,SetTo,0*16777216,12,0xFF000000);
		},{preserved})

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
	TriggerX(i,{CDeaths(FP,AtLeast,6,GiveRate[i+1])},{SetCDeaths(FP,Subtract,6,GiveRate[i+1])},{preserved})

		
	Trigger { -- 자동환전
	players = {i},
	conditions = {
		Command(i,AtLeast,1,"Terran Firebat");
	},
	actions = {
		ModifyUnitEnergy(1,"Terran Firebat",i,64,0);
		RemoveUnitAt(1,"Terran Firebat","Anywhere",i);
		SetDeaths(i,SetTo,1,"Terran Barracks");
		DisplayText(StrDesign("\x07자동환전\x04을 사용하셨습니다."),4);
		--SetCDeaths(FP,Add,1,CUnitRefrash);
		PreserveTrigger();
	},
}


Trigger { -- 조합 영웅마린
players = {i},
conditions = {
	Label(0);
	Bring(i,AtLeast,1,0,5); 
	Accumulate(i,AtLeast,8500,Ore);
	Accumulate(i,AtMost,0x7FFFFFFF,Ore);
},
actions = {
	ModifyUnitEnergy(1,0,i,5,0);
	RemoveUnitAt(1,0,5,i);
	SetResources(i,Subtract,8500,Ore);
	CreateUnitWithProperties(1,20,2,i,{energy = 100});
	DisplayText(StrDesign("\x1F광물\x04을 소모하여 Marine 을 Jim Raynor로 \x19변환\x04하였습니다. - \x1F8500 O r e"),4);
	--SetCDeaths(FP,Add,1,CUnitRefrash);
	--SetCD(CUnitFlag,1);
	PreserveTrigger();
},
}
	
DoActions(i,{SetAllianceStatus(Force1,Ally),--팀킬방지
RunAIScript("Turn ON Shared Vision for Player 1");
RunAIScript("Turn ON Shared Vision for Player 2");
RunAIScript("Turn ON Shared Vision for Player 3");
RunAIScript("Turn ON Shared Vision for Player 4");
RunAIScript("Turn ON Shared Vision for Player 5");
RunAIScript("Turn ON Shared Vision for Player 6");
RunAIScript("Turn ON Shared Vision for Player 7");
})
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

	--LeaderBoard
	local LeaderBoardT = CreateCcode()
	Trigger { -- 킬 포인트 리더보드,
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			Order(37, FP, 64, Attack, 2),
			Order(38, FP, 64, Attack, 2),
			LeaderBoardScore(Kills, "\x07[ \x1DP\x04oints\x07 ]");
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
			LeaderBoardScore(Custom, "\x07[ \x08D\x04eaths\x07 ]");
			LeaderBoardComputerPlayers(Disable);
			ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
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