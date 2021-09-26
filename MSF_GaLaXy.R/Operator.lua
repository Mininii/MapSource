function Operator_Trig()
    Cunit2 = CreateVar(FP)
	CurrentOP = CreateVar(FP)
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
        CElseIfX(PlayerCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i)})
        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
    end
    CIfXEnd()
	if TestStart == 1 then
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7fffffff)})
			CMov(FP,0x6509B0,CurrentOP)
		
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)})
				CMov(FP,0x6509B0,Cunit2)
				DoActions(FP,MoveCp(Add,25*4))
				local Not = def_sIndex()
				NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,111,0,0xFF)})
				NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,107,0,0xFF)})
				Trigger {
					players = {FP},
					conditions = {
						DeathsX(CurrentPlayer,AtMost,57,0,0xFF);
					},
					actions = {
						MoveCp(Subtract,6*4);
						SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
						MoveCp(Add,6*4);
						PreserveTrigger();
					}
				}
				Trigger {
					players = {FP},
					conditions = {
						DeathsX(CurrentPlayer,AtLeast,59,0,0xFF);
					},
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
		CIfEnd()
	end
	
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
        CMov(FP,CurrentSpeed,SpeedVar)
        for i = 1, 10 do
            Trigger { -- No comment (E93EF7A9)
                players = {FP},
                conditions = {
                    Label(0);
                    CVar(FP,SpeedVar[2],Exactly,i)
                },
                actions = {PreserveTrigger();
                    RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
                    DisplayTextX("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i].." \x07』", 0)},HumanPlayers,FP);
                    SetMemory(0x5124F0,SetTo,SpeedV[i]);
                },
            }
        end
    CIfEnd()

end