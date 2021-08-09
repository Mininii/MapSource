function LevelUp()
	local ShUnitLimitT = {}
	local ShUnitLimitT2 = {}
	for i = 0, 6 do
		table.insert( ShUnitLimitT,SetMemoryB(0x57F27C+(228*i)+19,SetTo,1))
		table.insert( ShUnitLimitT2,SetMemoryB(0x57F27C+(228*i)+19,SetTo,0))
	end
	 -- 9, 34 활성화하고 비활성화할 유닛 인덱스
	local CSelT = "\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\n\n\x13\x04상위 플레이어는 선택해주세요.\n\x13\x04다음 레벨로 진행하시겠습니까?\n\x13\x04(\x07Y \x04/ \x11N\x04)\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	local ClearT1 = "\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04최후의 건물 \x03OverMind \x1DShell \x04을 파괴하셨습니다.\n\x13\x07\n\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	local ClearT3 = "\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04최후의 건물 \x03OverMind \x1DShell \x04을 파괴하셨습니다.\n\x13\x07S T A R T\n\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	local ClearT2 = "\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04최후의 건물 \x03OverMind \x1DShell \x04을 파괴하셨습니다.\n\x13\x0710초 후 다음 레벨로 진입합니다.\n\x13\x08주의!! \x049, 10단계 진입할때마다 해당 스테이지에서는 \x1C수정 보호막 \x04사용이 \x06제한\x04됩니다!\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	local NoText = "\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\x14\n\x14\n\n\x13\x04NO를 입력하셨습니다. 게임을 종료합니다.\n\n\x14\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	local TextSwitch = Create_CCTable(5)
	DoActions(FP,{SetInvincibility(Enable,147,P8,"Anywhere"),
	TriggerX(FP,{
		CommandLeastAt(131,64),
		CommandLeastAt(132,64),
		CommandLeastAt(133,64),
		CommandLeastAt(151,64),
		CommandLeastAt(152,64),
		CommandLeastAt(148,64),
		CommandLeastAt(130,64),
		CommandLeastAt(201,64),
		Bring(FP,AtLeast,1,147,64)},{SetCVar(FP,ReserveBGM[2],SetTo,0)},{Preserved})
	})
	TriggerX(FP,{
	DeathsX(AllPlayers,AtMost,0,440,0xFFFFFF),
	CVar(FP,Actived_Gun[2],AtMost,0),
	CommandLeastAt(131,64),
	CommandLeastAt(132,64),
	CommandLeastAt(133,64),
	CommandLeastAt(151,64),
	CommandLeastAt(152,64),
	CommandLeastAt(148,64),
	CommandLeastAt(130,64),
	CommandLeastAt(201,64),
	Bring(FP,AtLeast,1,147,64)
	},{
	SetInvincibility(Disable,147,P8,"Anywhere"),SetCVar(FP,ReserveBGM[2],SetTo,0),RotatePlayer({MinimapPing("Location 29")},HumanPlayers,FP)
	},{Preserved})
	
	
	
	StoryT3 = CreateCCode()
	BClear = CreateCCode()

	CIf(FP,{Bring(FP,AtMost,0,147,64),CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),CDeaths(FP,AtMost,0,Win)})
		
		CIf(FP,{CDeaths(FP,AtMost,0,ReplaceDelayT),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Add,1,ReplaceDelayT)) -- 레벨 클리어 후 1회 실행 트리거들

			TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,2)},{ShUnitLimitT2},{Preserved})--19
			DoActions(FP,{
			SetDeathsX(AllPlayers,SetTo,0,440,0xFFFFFF),
			ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8),
			KillUnitAt(All,125,17,Force1),
			KillUnitAt(All,125,18,Force1),
			KillUnitAt(All,125,19,Force1),})
			CIfX(FP,CVar(FP,LevelT[2],Exactly,2))
				DoActionsX(FP,{SetCDeaths(FP,Add,1,StoryT)})
			CElseIfX(CVar(FP,LevelT[2],Exactly,4))
				DoActionsX(FP,{SetCDeaths(FP,Add,1,StoryT4),SetCVar(FP,ReserveBGM[2],SetTo,Akasha)})
			CElseIfX(CVar(FP,LevelT[2],Exactly,6))
				CIf(FP,Memory(0x628438,AtLeast,1))
					f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
					CDoActions(FP,{
						KillUnitAt(All,"Men",29,Force1),
						CreateUnit(1,87,29,FP),
						TSetMemory(B_5_C,SetTo,Nextptrs),
						TSetMemory(0x58D744,SetTo,Vi(Nextptrs[2],55)),
						TSetMemory(_Add(Nextptrs,2),SetTo,_Add(_Mul(PCheckV,_Mov(1000*256)),_Mov(5000*256))),
						SetCVar(FP,ReserveBGM[2],SetTo,roka7BGM)})
				CIfEnd()
			CElseIfX(CVar(FP,LevelT[2],Exactly,8))
				CIf(FP,Memory(0x628438,AtLeast,1))
				f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
				CDoActions(FP,{
					KillUnitAt(All,"Men","Center",Force1),
					CreateUnit(1,74,64,FP),
					MoveLocation("Boss", "Dark Templar (Hero)", FP, "Anywhere");
					TSetMemory(_Add(Nextptrs,2),SetTo,_Add(_Mul(PCheckV,_Mov(2000*256)),_Mov(1500*256))),
					SetCVar(FP,ReserveBGM[2],SetTo,DLBossBGM),
				})
				TriggerX(FP,{CDeaths(FP,Exactly,0,isSingle)},{RotatePlayer({
					CenterView(64),
				},HumanPlayers,FP)},{Preserved})
				CIfEnd()
			CElseIfX(CVar(FP,LevelT[2],Exactly,10))
			
			CIf(FP,Memory(0x628438,AtLeast,1))
			f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
			CDoActions(FP,{
				SetMemoryX(0x669FB4, SetTo, 16777216*17,0xFFFFFFFF),
				SetMemory(0x66EFBC, SetTo, 67);
				KillUnitAt(All,"Men","Center",Force1),
				CreateUnit(1,186,64,FP),
				SetMemory(0x66EFBC, SetTo, 78);
				TSetCVar(FP,DPtr[2],SetTo,Nextptrs),
				TSetMemory(_Add(Nextptrs,2),SetTo,8320000*256),
			})
			DoActions(FP,{
				SetCVar(FP,DcurHP[2],SetTo,8320000*256)
			})
			
			TriggerX(FP,{CDeaths(FP,Exactly,0,isSingle)},{RotatePlayer({
				CenterView(64),
			},HumanPlayers,FP)},{Preserved})
			CIfEnd()

			CElseX()
				DoActionsX(FP,SetCDeaths(FP,SetTo,1,BClear))
			CIfXEnd()
		-- 보스소환 테스트
		if TestStart == 1 then
			
	--        
			
	--        CIfX(FP,{TTOR({CVar(FP,LevelT[2],Exactly,1),CVar(FP,LevelT[2],Exactly,3),CVar(FP,LevelT[2],Exactly,5),CVar(FP,LevelT[2],Exactly,7),CVar(FP,LevelT[2],Exactly,9)})})
	--        

	--        
	--        CIfXEnd()



		end
		CMov(FP,CunitIndex,0)-- 모든 유닛 영작유닛 플래그 리셋
		CWhile(FP,{CVar(FP,CunitIndex[2],AtMost,1699)})
			CDoActions(FP,{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,0)})
			CAdd(FP,CunitIndex,1)
		CWhileEnd()
	
	--
		CIfEnd()

	Id_T6 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n \x13\x02코스크 충들의 \x11레갈(Regal) \x04성 \x1F진진짜라 주인 \x10T\x1Earim\x04이 \x07진진짜라\x04를 \x08모두 \x04털렸습니다.\r\n\r\n\x13\x05\"네놈들이 어떻게 내 라면을...\"\r\n "
	Dem_T6 = "\n\n\x13\x04『 \x06\x17D\x04emonic\x08Emperor \x04: \x06난 돌아올 것이다. \x04』\n\n"
	TriggerX(FP,{CDeaths(FP,AtLeast,1,rokaClear)},{SetCDeaths(FP,SetTo,1,BClear)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,DLClear)},{SetCDeaths(FP,SetTo,1,BClear)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,Destr0yerClear2)},{SetCDeaths(FP,SetTo,1,BClear),SetCDeaths(FP,SetTo,1,StoryT3)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,IdenClear),CDeaths(FP,AtMost,0,StoryT3)},
		{RotatePlayer({DisplayTextX(Id_T6,4),PlayWAVX("staredit\\wav\\Satellite.wav"),PlayWAVX("staredit\\wav\\Satellite.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,StoryT3),SetCDeaths(FP,SetTo,1,BClear)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,DemClear),CDeaths(FP,AtMost,0,StoryT3)},
		{RotatePlayer({DisplayTextX(Dem_T6,4),PlayWAVX("staredit\\wav\\Satellite.wav"),PlayWAVX("staredit\\wav\\statyoudieEND.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,StoryT3),SetCDeaths(FP,SetTo,1,BClear)},{Preserved})

	CIf(FP,{CDeaths(FP,AtLeast,1,BClear),Switch(ResetSwitch,Cleared)}) -- 보스클리어시 1회실행 트리거
		TriggerX(FP,{CDeaths(FP,AtMost,0,StoryT3)},{RotatePlayer({DisplayTextX(ClearT1,4),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,StoryT3)},{Preserved})
	if Limit == 1 and TestStart == 0 then
		--TriggerX(FP,{CVar(FP,Level[2],AtLeast,11)},{RotatePlayer({DisplayTextX("\x07『 \x04테스트에 협조해주셔서 감사합니다. 빠른 시일 내에 완성된 작품으로 뵙겠습니다. \x07』 ",4)},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Win)},{Preserved})
	end
		DoActions(FP,{RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),
		ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8),
		KillUnitAt(All,124,17,Force1),
		KillUnitAt(All,124,18,Force1),
		KillUnitAt(All,124,19,Force1),
		KillUnitAt(All,125,17,Force1),
		KillUnitAt(All,125,18,Force1),
		KillUnitAt(All,125,19,Force1),
	})
		CAdd(FP,Level,1)
		f_Mod(FP,LevelT,Level,_Mov(10))
		f_Div(FP,LevelT2,Level,_Mov(10))
		CAdd(FP,LevelT2,1)
		CAdd(FP,LevelT2,Diff)
		TriggerX(FP,{CVar(FP,LevelT[2],Exactly,0)},{SetCVar(FP,LevelT[2],SetTo,10)},{Preserved})
		if TestStart == 1 then
			--CMov(FP,LevelT2,4)
		end
		local ButtonPatch = {}
		for i = 0, 6 do
			table.insert(ButtonPatch,SetMemoryB(0x57F27C+(228*i)+64,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
			table.insert(ButtonPatch,SetMemoryB(0x57F27C+(228*i)+70,SetTo,1)) -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		end
		TriggerX(FP,{CVar(FP,Level[2],AtMost,10)},{SetCVar(FP,MarNumberLimit[2],Add,84*2),SetCDeaths(FP,Add,100,PExitFlag)},{Preserved})
		TriggerX(FP,{CVar(FP,LevelT[2],AtMost,8)},{ShUnitLimitT},{Preserved})--19
		TriggerX(FP,{CVar(FP,LevelT[2],AtLeast,9)},{ShUnitLimitT2},{Preserved})
		if Limit == 0 then
			TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,1)},{ButtonPatch},{Preserved})
		else
			TriggerX(FP,{},{ButtonPatch},{Preserved})
		end
		
		CMov(FP,CunitIndex,0)-- 모든 유닛 영작유닛 플래그 리셋
		CWhile(FP,{CVar(FP,CunitIndex[2],AtMost,1699)})
			CDoActions(FP,{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,0)})
			CAdd(FP,CunitIndex,1)
		CWhileEnd()
		


		TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,5)},{SetCVar(FP,LevelT2[2],SetTo,4)},{Preserved})
		--
		TriggerX(FP,{},{SetCVar(FP,ReserveBGM[2],SetTo,1)},{Preserved})


		function SetLevelUpHP(UnitID,Multiplier)
			CallTrigger(FP,f_SetLvHP,{SetCVar(FP,UnitIDV[2],SetTo,UnitID),SetCVar(FP,MultiplierV[2],SetTo,Multiplier)})
		end

		for i = 2, 10 do
			TriggerX(FP,{CVar(FP,Level[2],Exactly,i)},{SetMemory(0x515BD0,SetTo,256*16*i),SetMemory(0x662350+(4*125),SetTo,16000*256*i),SetMemory(0x662350+(4*124),SetTo,16000*256*i)},{Preserved})
		end
		TriggerX(FP,{CVar(FP,Diff[2],AtLeast,1)},{SetMemory(0x515BD0,SetTo,256*16*10),SetMemory(0x662350+(4*125),SetTo,16000*256*10),SetMemory(0x662350+(4*124),SetTo,16000*256*10)},{Preserved})
		
		for i = 37, 57 do
			SetLevelUpHP(i,1)
		end
		
			SetLevelUpHP(104,1)
		for j, k in pairs(HeroArr) do
			SetLevelUpHP(k,1)
		end
		BdArr = {131,132,133,135,136,137,138,139,140,141,142,143,144,146}
		
		for j, k in pairs(BdArr) do
			SetLevelUpHP(k,2)
		end
		SetLevelUpHP(11,1)
		SetLevelUpHP(13,1)
		SetLevelUpHP(69,1)
		DoActions(FP,SetMemoryB(0x58D2B0+(46*7)+3,SetTo,0))
		local UpVar = CreateVar(FP)
		CMov(FP,UpVar,Level)
		f_Div(FP,UpVar,_Mov(2))
		for i = 0, 7 do
			TriggerX(FP,{CVar(FP,UpVar[2],Exactly,2^i,2^i)},{SetMemoryB(0x58D2B0+(46*7)+3,Add,2^i)},{Preserved})
		end
		for i = 1, 3 do
		TriggerX(FP,{CVar(FP,Diff[2],AtLeast,i)},{SetMemoryB(0x58D2B0+(46*7)+3,Add,5)},{Preserved})
		end
		TriggerX(FP,{CVar(FP,UpVar[2],AtLeast,256)},{SetMemoryB(0x58D2B0+(46*7)+3,SetTo,50)},{Preserved})
		
		
		Trigger2(FP,{MemoryB(0x58D2B0+(46*7)+3,AtLeast,51)},{SetMemoryB(0x58D2B0+(46*7)+3,SetTo,50)},{Preserved})

		
		DoActions(FP,{SetSwitch(ResetSwitch,Set)})
		DoActions(FP,{RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),
		ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8),
		KillUnitAt(All,124,17,Force1),
		KillUnitAt(All,124,18,Force1),
		KillUnitAt(All,124,19,Force1),
		KillUnitAt(All,125,17,Force1),
		KillUnitAt(All,125,18,Force1),
		KillUnitAt(All,125,19,Force1),})
	CIfEnd()
	
	
	CTrigger(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CDeaths(FP,AtMost,0,Continue2),CDeaths(FP,Exactly,0,Continue)},{
		RotatePlayer({DisplayTextX(CSelT,4),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Continue2)
	},1)
	CMov(FP,0x6509B0,CurrentOP)
	NoB = 220
	YesB = 221
	TriggerX(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CDeaths(FP,Exactly,0,Continue),Deaths(CurrentPlayer,AtLeast,1,NoB)},{RotatePlayer({DisplayTextX(NoText,4),PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");},HumanPlayers,FP),SetCDeaths(FP,Add,1,Win)},{Preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CDeaths(FP,Exactly,0,Continue),Deaths(CurrentPlayer,AtLeast,1,YesB)},{RotatePlayer({DisplayTextX(ClearT2,4),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg")},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Continue)},{Preserved})
	CMov(FP,0x6509B0,FP)
	
	for i = 0, 4 do
		TriggerX(FP,{CDeaths(FP,AtLeast,10000+(i*1000),ReplaceDelayT),CDeaths(FP,AtMost,0,TextSwitch[i+1])},{RotatePlayer({DisplayTextX("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04최후의 건물 \x03OverMind \x1DShell \x04을 파괴하셨습니다.\n\x13\x0710초 후 다음 레벨로 진입합니다.\n\x13\x04"..5-i.."초 남았습니다.\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)},HumanPlayers,FP),
		SetCDeaths(FP,SetTo,1,TextSwitch[i+1]),SetCDeaths(FP,SetTo,1,countdownSound)},{Preserved})
	end


	CTrigger(FP,{CDeaths(FP,AtLeast,1,BClear),CDeaths(FP,AtMost,5000,ReplaceDelayT)},{TSetCDeaths(FP,Add,Dt,ReplaceDelayT)},1)
	CTrigger(FP,{CDeaths(FP,AtLeast,1,BClear),CDeaths(FP,Exactly,1,Continue)},{TSetCDeaths(FP,Add,Dt,ReplaceDelayT)},1)

	CIf(FP,CDeaths(FP,AtLeast,15000,ReplaceDelayT))
	TriggerX(FP,{},{RotatePlayer({DisplayTextX(ClearT3,4)},HumanPlayers,FP)},{Preserved})

	DoActions(FP,{RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");},HumanPlayers,FP)})
	MoveMarineArr = {}
	for i = 0, 6 do
	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,19,2+i))
	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,17,2+i))
	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,18,2+i))
	for j = 0, 4 do
	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,19,20+j))
	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,17,20+j))
	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,18,20+j))
	end
	for j = 65, 73 do
	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,19,j))
	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,17,j))
	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,18,j))
	
	end
	end
	--65~73
	DoActions2(FP,MoveMarineArr)
	
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,{Deaths(CurrentPlayer,AtLeast,1,0)})
		CAdd(FP,0x6509B0,1)
		CIf(FP,DeathsX(CurrentPlayer,Exactly,7*256,0,0xFF00))
			local PointJump = def_sIndex()
			NJumpX(FP,PointJump,{DeathsX(CurrentPlayer,Exactly,150,0,0xFF)}) -- 포인트유닛 리젠 삭제
			NJumpX(FP,PointJump,{DeathsX(CurrentPlayer,Exactly,220,0,0xFF)}) -- 포인트유닛 리젠 삭제
			NJumpX(FP,PointJump,{DeathsX(CurrentPlayer,Exactly,221,0,0xFF)}) -- 포인트유닛 리젠 삭제
			NJumpX(FP,PointJump,{CVar(FP,LevelT[2],AtLeast,7),DeathsX(CurrentPlayer,Exactly,131,0,0xFF)}) -- 해처리레어 리젠없음
			NJumpX(FP,PointJump,{CVar(FP,LevelT[2],Exactly,10),DeathsX(CurrentPlayer,Exactly,132,0,0xFF)}) -- 해처리레어 리젠없음
			CSub(FP,0x6509B0,1)
			CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드.
			CAdd(FP,0x6509B0,1)
			NJumpXEnd(FP,PointJump)
		CIfEnd()
		CSub(FP,0x6509B0,1)
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	TriggerX(FP,{CVar(FP,Level[2],AtMost,10)},{SetCVar(FP,RandW[2],Add,30)},{Preserved})
	TriggerX(FP,{CVar(FP,Level[2],AtLeast,11)},{SetCVar(FP,RandW[2],Add,100)},{Preserved})
	

	DoActions2X(FP,{SetDeaths(FP,Subtract,1,147),
	SetCDeaths(FP,SetTo,0,ReplaceDelayT),
	SetCDeaths(FP,SetTo,0,TextSwitch[1]),
	SetCDeaths(FP,SetTo,0,TextSwitch[2]),
	SetCDeaths(FP,SetTo,0,TextSwitch[3]),
	SetCDeaths(FP,SetTo,0,TextSwitch[4]),
	SetCDeaths(FP,SetTo,0,TextSwitch[5]),
	SetCDeaths(FP,SetTo,0,Continue),
	SetCDeaths(FP,SetTo,0,Continue2),
	SetCDeaths(FP,SetTo,0,rokaClear),
	SetCDeaths(FP,SetTo,0,DemClear),
	SetCDeaths(FP,SetTo,0,DLClear),
	SetCDeaths(FP,SetTo,0,IdenClear),
	SetCDeaths(FP,SetTo,0,Destr0yerClear),
	SetCDeaths(FP,SetTo,0,Destr0yerClear2),
	SetCDeaths(FP,SetTo,0,StoryT3),
	SetCDeaths(FP,SetTo,0,BClear),
	SetSwitch(ResetSwitch,Clear),
	SetCDeaths(FP,SetTo,0,BossStart),
	})
	DoActions(FP,{RotatePlayer({RunAIScript(P8VOFF)},MapPlayers,FP)})
	CIfEnd()
	CIfEnd()
end