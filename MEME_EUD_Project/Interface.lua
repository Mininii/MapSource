function Interface()
	
Cunit2 = CreateVar(FP)
CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 4 do
		CElseIfX(HumanCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i),})
		if Limit == 1 then
			
			f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
		end

	end
CIfXEnd()


if Limit == 1 then
	CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
	CIf(FP,CD(TestMode,1)) -- 테스트 트리거


	
--for i = 0, 1699 do
--	TriggerX(FP,{ -- 테스트모드 무한스팀
--		DeathsX(EPDF(0x628298-0x150*i+(25*4)),Exactly,20,0,0xFF); -- EPD 35 Unused 0x8C
--	},
--	{
--		SetDeathsX(EPDF(0x628298-0x150*i+(69*4)),SetTo,255*256,0,0xFF00); -- \
--	},{preserved})
--end

	
	CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
	CIfOnce(FP,Deaths(CurrentPlayer,AtLeast,1,208))
	CMov(FP,0x6509B0,19025+9) --CUnit 시작지점 +19 (0x4C)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+9 + (84*1699)),{SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000),SetMemory(0x6509b0,Add,84)})
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	CIfEnd()

		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Deaths(CurrentPlayer,AtLeast,1,204); -- KillAll
			},
			actions = {
				KillUnit("Men",Force2);
				PreserveTrigger();
			}
			}
		TestUPtr = CreateVar(FP)
		--CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{TCreateUnit(12, 20, _Add(CurrentOP,65), CurrentOP)},{preserved}) -- CreateMarine
		--CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,199)},{SetV(TestUPtr,Cunit2)},{preserved})
		--CIf(FP,{CVar(FP,TestUPtr[2],AtLeast,1),CVar(FP,TestUPtr[2],AtMost,0x7FFFFFFF)})
		--	CDoActions(FP,{TSetMemoryX(_Add(CurrentOP,EPD(0x57f120)),SetTo,_Div(_Read(_Add(TestUPtr,19)),256),0xFF)})
		--CIfEnd()

		CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
		CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7FFFFFFF)})
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,207)})-- 207 KillUnitSelected
				CMov(FP,0x6509B0,Cunit2,25)
				CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
					MoveCp(Add,15*4);
					--SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000);
					MoveCp(Subtract,21*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
				},1)
			CIfEnd()

			CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
			CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,203)}) -- KillUnitOnceSelectedWithSetDeaths
				CMov(FP,0x6509B0,Cunit2,25)
				f_SaveCp()
				TestUID = CreateVar(FP)
				TestP = CreateVar(FP)
				f_Read(FP,BackupCp,TestUID,nil,0xFF,1)
				f_Read(FP,_Sub(BackupCp,6),TestP,nil,0xFF,1)
				CDoActions(FP,{TSetMemory(_Add(_Mul(TestUID,12),TestP),Add,1)})
				f_LoadCp()
				CTrigger(FP,{TTDeathsX(CurrentPlayer,NotSame,58,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,111,0,0xFF),TTDeathsX(CurrentPlayer,NotSame,107,0,0xFF)},{
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
				},1)
			CIfEnd()
			
			CMov(FP,0x6509B0,CurrentOP)--상위플레이어 단락
			CMov(FP,0x6509B0,Cunit2,19)
			f_SaveCp()
			CDoActions(FP,{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(_Read(BackupCp),65536),0xFF000000)})
			f_LoadCp()
		CIfEnd()
	CIfEnd()

	CMov(FP,0x6509B0,FP)--상위플레이어 단락
			end


	






end