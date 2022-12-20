function Operator_Trig()
    Cunit2 = CreateVar(FP)
	CurrentOP = CreateVar(FP)
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
        CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i)})
        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		Trigger {
			players = {FP},
			conditions = {
				Command(i,AtMost,0,219);
				Command(AllPlayers,AtLeast,1,219);		
			},
			actions = {
				GiveUnits(All,219,AllPlayers,"Anywhere",i);
				GiveUnits(All,115,AllPlayers,"Anywhere",i);
			}
		}
    end
    CIfXEnd()
	
	CIf(FP,{CDeaths(FP,AtLeast,1,TestMode),CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7fffffff)})
		CMov(FP,0x6509B0,CurrentOP)
	
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Deaths(CurrentPlayer,AtLeast,1,214);
			},
			actions = {
				KillUnit("Men",Force2);
				KillUnit(143,Force2);
				KillUnit(144,Force2);
				KillUnit(146,Force2);
				PreserveTrigger();
			}
			}
		CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)})
			CMov(FP,0x6509B0,Cunit2)
			DoActions(FP,MoveCp(Add,25*4))
			local Not = def_sIndex()
			NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,111,0,0xFF)})
			NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,107,0,0xFF)})
			NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,58,0,0xFF)})
			Trigger {
				players = {FP},
				actions = {
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
					PreserveTrigger();
				}
			}
			NJumpXEnd(FP,Not)
			DoActions(FP,{MoveCp(Subtract,25*4)})
		CIfEnd()
		CMov(FP,0x6509B0,FP)
	CIfEnd()
	CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7fffffff)})
		CMov(FP,0x6509B0,Cunit2,25)
		CIf(FP,{DeathsX(CurrentPlayer,Exactly,219,0,0xFF)},{MoveCp(Subtract,0x3C)})

			for i = 1, 11 do
				if X2_Mode == 1 then
					TriggerX(FP,{
						DeathsX(CurrentPlayer,AtLeast,(3744*2)+(64*(i-1)),0,0xFFFF),
						DeathsX(CurrentPlayer,AtMost,(3744*2)+(64*((i-1)+1)),0,0xFFFF)},{SetCVar(FP,SpeedVar[2],SetTo,i)},{preserved})
				else
					TriggerX(FP,{
						DeathsX(CurrentPlayer,AtLeast,3744+(32*(i-1)),0,0xFFFF),
						DeathsX(CurrentPlayer,AtMost,3744+(32*((i-1)+1)),0,0xFFFF)},{SetCVar(FP,SpeedVar[2],SetTo,i)},{preserved})
				end
			end
		CIfEnd()
	CIfEnd()
	CMov(FP,0x6509B0,FP)
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
        CMov(FP,CurrentSpeed,SpeedVar)
        for i = 1, 11 do
            Trigger { -- No comment (E93EF7A9)
                players = {FP},
                conditions = {
                    Label(0);
                    CVar(FP,SpeedVar[2],Exactly,i);
                },
                actions = {PreserveTrigger();
                    RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
                    DisplayTextX("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i].." \x07』", 4)},HumanPlayers,FP);
                    SetMemory(0x5124F0,SetTo,SpeedV[i]);
                },
            }
        end
    CIfEnd()

end