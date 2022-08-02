function LevelUp()
	local ShUnitLimitT = {}
	local ShUnitLimitT2 = {}
	local NoCcode = CreateCcode()
	for i = 0, 6 do
		table.insert( ShUnitLimitT,SetMemoryB(0x57F27C+(228*i)+19,SetTo,1))
		table.insert( ShUnitLimitT2,SetMemoryB(0x57F27C+(228*i)+19,SetTo,0))
	end
	local isBossStage = CreateCcode()
	
	local ClearT3 = "\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x14\n\x13\x04최후의 건물 \x03OverMind \x1DShell \x04을 파괴하셨습니다.\n\x13\x07S T A R T\n\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	local TextSwitch = Create_CCTable(5)
	DoActions(FP,{SetInvincibility(Enable,147,P8,"Anywhere"),SetCp(FP)})
	CIf(FP,{
		CommandLeastAt(131,64),
		CommandLeastAt(132,64),
		CommandLeastAt(133,64),
		CommandLeastAt(151,64),
		CommandLeastAt(152,64),
		CommandLeastAt(173,64),
		CommandLeastAt(148,64),
		CommandLeastAt(130,64),
		CommandLeastAt(201,64),
		Bring(FP,AtLeast,1,147,64),
	},{SetCVar(FP,ReserveBGM[2],SetTo,0)})
	
	TriggerX(FP,{CVar(FP,LevelT[2],Exactly,10),CVar(FP,Actived_Gun[2],AtMost,2)},{SetCDeaths(FP,SetTo,0,GCT)},{preserved})
	TriggerX(FP,{CVar(FP,Actived_Gun[2],AtMost,0)},{
		SetInvincibility(Disable,147,P8,"Anywhere"),RotatePlayer({MinimapPing("Location 29")},HumanPlayers,FP)
		},{preserved})
	CIfEnd()
	
	StoryT3 = CreateCcode()
	BClear = CreateCcode()
	CIf(FP,{Bring(FP,AtMost,0,147,64),CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),CDeaths(FP,AtMost,0,Win)})
		
		CIf(FP,{CDeaths(FP,AtMost,0,ReplaceDelayT),Memory(0x628438,AtLeast,1)},SetCDeaths(FP,Add,1,ReplaceDelayT)) -- 레벨 클리어 후 1회 실행 트리거들
			--TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,2)},{ShUnitLimitT2},{preserved})--19
			DoActions(FP,{
			--SetDeathsX(AllPlayers,SetTo,0,12,0xFFFFFF),
			MoveUnit(All, "Men", FP, "Center", 34),
			ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8),
			KillUnitAt(All,125,17,Force1), 
			KillUnitAt(All,125,18,Force1),
			KillUnitAt(All,125,19,Force1),})
			CIfX(FP, {Never()})
			-- 보스소환 테스트
			--if Limit == 1 then
			--	
		    --    CElseIfX({CD(TestMode,1)})
			--	
			--	CIf(FP,Memory(0x628438,AtLeast,1))
			--		f_Read(FP,0x628438,nil,Boss6Ptr,0xFFFFFF)
			--		CMov(FP,CunitIndex,_Div(_Sub(Boss6Ptr,19025),_Mov(84)))
			--		local TempHP1, TempHP2 = CreateVars(2,FP)
			--		
			--		f_LMov(FP,{TempHP1, TempHP2},"82512384594432") --322322322322
			--		CDoActions(FP,{
			--			Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo,1),
			--			Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo,TempHP1),
			--			Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo,TempHP2),
			--			SetMemoryX(0x669FB4, SetTo, 16777216*17,0xFFFFFFFF),
			--			KillUnitAt(All,"Men","Center",Force1),
			--			CreateUnit(1,186,64,FP),
			--			SetCDeaths(FP,Add,1,isBossStage),
			--			TSetMemory(_Add(Boss6Ptr,2),SetTo,8320000*256),
			--		})
			--	CIfEnd()
		--        CIfX(FP,{TTOR({CVar(FP,LevelT[2],Exactly,1),CVar(FP,LevelT[2],Exactly,3),CVar(FP,LevelT[2],Exactly,5),CVar(FP,LevelT[2],Exactly,7),CVar(FP,LevelT[2],Exactly,9)})})
		--        
	
		--        
		--        CIfXEnd()
	
	
	
			--end
			CElseIfX({CVar(FP,LevelT[2],Exactly,2)})
				DoActionsX(FP,{SetCDeaths(FP,Add,1,StoryT),
				SetCDeaths(FP,Add,1,isBossStage),})
			CElseIfX(CVar(FP,LevelT[2],Exactly,4))
				DoActionsX(FP,{SetCDeaths(FP,Add,1,StoryT4),SetCVar(FP,ReserveBGM[2],SetTo,Akasha),
				SetCDeaths(FP,Add,1,isBossStage),})
			CElseIfX(CVar(FP,LevelT[2],Exactly,6))
				CIf(FP,Memory(0x628438,AtLeast,1))
					f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
					CDoActions(FP,{
						KillUnitAt(All,"Men",29,Force1),
						CreateUnit(1,87,29,FP),
						SetV(B_5_C,Nextptrs),
						--TSetMemory(B_5_C,SetTo,Nextptrs),
						TSetMemory(0x58D744,SetTo,Vi(Nextptrs[2],55)),
						TSetMemory(_Add(Nextptrs,2),SetTo,6000*256),
						SetCDeaths(FP,Add,1,isBossStage),
						SetCVar(FP,ReserveBGM[2],SetTo,roka7BGM)})
				CIfEnd()
			CElseIfX(CVar(FP,LevelT[2],Exactly,8))
				CIf(FP,Memory(0x628438,AtLeast,1))
				f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
				CDoActions(FP,{
					KillUnitAt(All,"Men","Center",Force1),
					CreateUnit(1,74,64,FP),
					MoveLocation("Boss", "Dark Templar (Hero)", FP, "Anywhere");
					TSetMemory(_Add(Nextptrs,2),SetTo,_Add(_Mul(PCheckV,_Mov(750*256)),_Mov(1000*256))),
					SetCDeaths(FP,Add,1,isBossStage),
					SetCVar(FP,ReserveBGM[2],SetTo,DLBossBGM),
				})
				TriggerX(FP,{CDeaths(FP,Exactly,0,isSingle)},{RotatePlayer({
					CenterView(64),
				},HumanPlayers,FP)},{preserved})
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
				SetCDeaths(FP,Add,1,isBossStage),
				TSetMemory(_Add(Nextptrs,2),SetTo,8320000*256),
				SetCVar(FP,DcurHP[2],SetTo,8320000*256)
			})
			
			CIfEnd()

			CElseX()
				DoActionsX(FP,SetCDeaths(FP,SetTo,1,BClear))
			CIfXEnd()
		CMov(FP,CunitIndex,0)-- 모든 유닛 영작유닛 플래그 리셋
		CWhile(FP,{CVar(FP,CunitIndex[2],AtMost,1699)})
			CDoActions(FP,{Set_EXCC2(DUnitCalc, CunitIndex, 8, SetTo, 0)})
			CAdd(FP,CunitIndex,1)
		CWhileEnd()
	
	--
		CIfEnd()

	Id_T6 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n \x13\x02코스크 충들의 \x11레갈(Regal) \x04성 \x1F진진짜라 주인 \x10T\x1Earim\x04이 \x07진진짜라\x04를 \x08모두 \x04털렸습니다.\r\n\r\n\x13\x05\"네놈들이 어떻게 내 라면을...\"\r\n "
	Dem_T6 = "\n\n\x13\x04『 \x06\x17D\x04emonic\x08Emperor \x04: \x06난 돌아올 것이다. \x04』\n\n"
	TriggerX(FP,{CDeaths(FP,AtLeast,1,rokaClear)},{SetCDeaths(FP,SetTo,1,BClear)},{preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,DLClear)},{SetCDeaths(FP,SetTo,1,BClear)},{preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,IdenClear)},{SetCDeaths(FP,SetTo,1,BClear)},{preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,DemClear)},{SetCDeaths(FP,SetTo,1,BClear)},{preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,1,Destr0yerClear2)},{SetCDeaths(FP,SetTo,1,BClear),SetCDeaths(FP,SetTo,1,StoryT3)},{preserved})
	CIf(FP,{CDeaths(FP,AtLeast,1,BClear),Switch(ResetSwitch,Cleared)}) -- 보스클리어시 1회실행 트리거

		GetP = CreateVar(FP)
		local GetPVA = CreateVArray(FP,13)
		CIfX(FP,{CVar(FP,PCheckV[2],Exactly,1)})-- 싱글플레이 포인트 없음
		CMov(FP,GetP,0)
		CElseX()
		CMov(FP,GetP,_Div(Level, 10),1) -- 포인트 공식 : P = (Level//10)+1
		CIfXEnd()

		CIf(FP,{CDeaths(FP,AtLeast,1,isBossStage)}) -- 보스 스테이지 클리어시 추가포인트
			f_Mul(FP,GetP,_Mov(2))
		CIfEnd()

		f_Mul(FP,GetP,_Mov(2))
		
		CIf(FP,CVar(FP,LevelT[2],Exactly,0))--10렙 클리어시 추가포인트
			f_Mul(FP,GetP,_Mov(2))
		CIfEnd()

		CIf(FP,CVar(FP,MulPoint[2],AtLeast,1))
			f_Mul(FP,GetP,MulPoint)--추가 포인트 지급
		CIfEnd()
		
		
		CIfX(FP,CVar(FP,PCheckV[2],AtLeast,2))
		ItoDecX(FP,GetP,VArr(GetPVA,0),2,0x7,2)
		_0DPatchX(FP,GetPVA,12)
		f_Memcpy(FP,PointStrPtr,_TMem(Arr(StPT[3],0),"X","X",1),StPT[2])
		f_Movcpy(FP,_Add(PointStrPtr,StPT[2]),VArr(GetPVA,0),12*4)
		f_Memcpy(FP,_Add(PointStrPtr,StPT[2]+(12*4)),_TMem(Arr(DBossT3[3],0),"X","X",1),DBossT3[2])
		CElseX()
		DoActions(FP, {SetV(GetP,0)})
		f_Memcpy(FP,PointStrPtr,_TMem(Arr(SoloNoPointT[3],0),"X","X",1),SoloNoPointT[2])
		CIfXEnd()
		

		Trigger2X(FP,{CDeaths(FP,AtMost,0,StoryT3),CDeaths(FP,AtLeast,1,IdenClear)},
			{RotatePlayer({DisplayTextX(Id_T6,4),DisplayTextX("\x0D\x0D\x0DGetP".._0D,4),PlayWAVX("staredit\\wav\\Satellite.wav"),PlayWAVX("staredit\\wav\\Satellite.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,StoryT3)},{preserved})
		Trigger2X(FP,{CDeaths(FP,AtMost,0,StoryT3),CDeaths(FP,AtLeast,1,DemClear)},
			{RotatePlayer({DisplayTextX(Dem_T6,4),DisplayTextX("\x0D\x0D\x0DGetP".._0D,4),PlayWAVX("staredit\\wav\\Satellite.wav"),PlayWAVX("staredit\\wav\\statyoudieEND.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,StoryT3)},{preserved})
		Trigger2X(FP,{CDeaths(FP,AtMost,0,StoryT3)},{RotatePlayer({
			DisplayTextX("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x13\x04최후의 건물 \x03OverMind \x1DShell \x04을 파괴하셨습니다.",4),
			DisplayTextX("\x0D\x0D\x0DGetP".._0D,4),
			DisplayTextX("\x07\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"),
			PlayWAVX("staredit\\wav\\Level_Clear.ogg"),
			PlayWAVX("staredit\\wav\\Level_Clear.ogg"),
			PlayWAVX("staredit\\wav\\Level_Clear.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,StoryT3)},{preserved})
		local ClearScoreT1 = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04\x07『 \x08Ｄ\x04ｅｓｔｒ\x10０\x04ｙｅｒ\x07 』 \x04에게서 살아남으셨습니다.\n\x13\x1F축하합니다! \x04점수가 충분하여 \x07클리어\x04 하셨습니다."
		local ClearScoreT2 = "\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"

		Trigger2X(FP,{CDeaths(FP,AtLeast,1,Destr0yerClear2)},{
		RotatePlayer({DisplayTextX(ClearScoreT1,4),DisplayTextX("\x0D\x0D\x0DGetP".._0D,4),DisplayTextX(ClearScoreT2,4),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg")},HumanPlayers,FP),
		},{preserved})
		
		

	if Limit == 1 and TestStart == 0 then
		--TriggerX(FP,{CVar(FP,Level[2],AtLeast,11)},{RotatePlayer({DisplayTextX("\x07『 \x04테스트에 협조해주셔서 감사합니다. 빠른 시일 내에 완성된 작품으로 뵙겠습니다. \x07』 ",4)},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Win)},{preserved})
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
	
		CDoActions(FP,{
			TSetDeaths(0,Add,GetP,35),
			TSetDeaths(1,Add,GetP,35),
			TSetDeaths(2,Add,GetP,35),
			TSetDeaths(3,Add,GetP,35),
			TSetDeaths(4,Add,GetP,35),
			TSetDeaths(5,Add,GetP,35),
			TSetDeaths(6,Add,GetP,35),
			SetDeaths(0,SetTo,1,14),
			SetDeaths(1,SetTo,1,14),
			SetDeaths(2,SetTo,1,14),
			SetDeaths(3,SetTo,1,14),
			SetDeaths(4,SetTo,1,14),
			SetDeaths(5,SetTo,1,14),
			SetDeaths(6,SetTo,1,14),
		})
		for i = 0, 6 do
			CTrigger(FP,{TDeaths(i,AtMost,Level,18)},{SetDeaths(i,Add,1,18),SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x1F!!!ＮＥＷ ＲＥＣＯＲＤ \x07～ 레벨이 올랐습니다! ～ \x1FＮＥＷ ＲＥＣＯＲＤ !!!",4),
			PlayWAV("staredit\\wav\\LimitBreak.ogg"),
			SetMemory(0x6509B0,SetTo,FP)},1)
			CTrigger(FP,{TDeaths(i,AtMost,ExScore[i+1],36),CVar(FP,ExScore[i+1][2],AtMost,0x7FFFFFFF)},{TSetDeaths(i,SetTo,ExScore[i+1],36),SetMemory(0x6509B0,SetTo,i),
			DisplayText("\x13\x1F!!!ＮＥＷ ＲＥＣＯＲＤ \x07～ 킬 스코어 기록갱신! ～ \x1FＮＥＷ ＲＥＣＯＲＤ !!!",4),
			PlayWAV("staredit\\wav\\LimitBreak.ogg"),
			SetMemory(0x6509B0,SetTo,FP)},1)
		end
		CAdd(FP,Level,1)
		CMov(FP,0x58f900,Level)

		TriggerX(FP,{},{SetCVar(FP,ReserveBGM[2],SetTo,1)},{preserved})


		CallTrigger(FP, LevelReset,{SetCD(initStart,0)})



		
		DoActions(FP,{SetSwitch(ResetSwitch,Set)})
	CIfEnd()
	
	

	TriggerX(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CVar(FP,LevelT[2],AtLeast,2),CVar(FP,LevelT[2],AtMost,10),CDeaths(FP,Exactly,0,Continue)},{SetCDeaths(FP,SetTo,1,Continue);},{preserved})
	TriggerX(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CVar(FP,LevelT[2],Exactly,1),CDeaths(FP,Exactly,0,Continue)},{SetCDeaths(FP,SetTo,1,Win);},{preserved})
	
	CMov(FP,0x6509B0,FP)
	
	for i = 0, 4 do
		TriggerX(FP,{CDeaths(FP,AtLeast,10000+(i*1000),ReplaceDelayT),CDeaths(FP,AtMost,0,TextSwitch[i+1])},{RotatePlayer({DisplayTextX("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x14\n\x13\x04최후의 건물 \x03OverMind \x1DShell \x04을 파괴하셨습니다.\n\x13\x0F다음 레벨 시작\x04까지 \x07"..5-i.."\x04초 남았습니다.\n\x14\n\x13\x04！！！　\x1FＬＥＶＥＬ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)},HumanPlayers,FP),
		SetCDeaths(FP,SetTo,1,TextSwitch[i+1]),SetCDeaths(FP,SetTo,1,countdownSound)},{preserved})
	end


	
	CTrigger(FP,{CVar(FP,Dt[2],AtMost,2500),CDeaths(FP,AtLeast,1,BClear),CDeaths(FP,AtMost,5000,ReplaceDelayT)},{TSetCDeaths(FP,Add,Dt,ReplaceDelayT)},1)
	CTrigger(FP,{CVar(FP,Dt[2],AtMost,2500),CDeaths(FP,AtLeast,1,BClear),CDeaths(FP,Exactly,1,Continue)},{TSetCDeaths(FP,Add,Dt,ReplaceDelayT)},1)

	CIf(FP,CDeaths(FP,AtLeast,15000,ReplaceDelayT))
	TriggerX(FP,{},{RotatePlayer({DisplayTextX(ClearT3,4)},HumanPlayers,FP)},{preserved})

	DoActions(FP,{RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");},HumanPlayers,FP)})
--	MoveMarineArr = {}
--	for i = 0, 6 do
--	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,19,2+i))
--	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,17,2+i))
--	table.insert(MoveMarineArr,MoveUnit(50,"Men",i,18,2+i))
--	for j = 0, 4 do
--	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,19,20+j))
--	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,17,20+j))
--	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,18,20+j))
--	end
--	for j = 65, 73 do
--	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,19,j))
--	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,17,j))
--	table.insert(MoveMarineArr,MoveUnit(255,"Men",i,18,j))
--	
--	end
--	end
--	DoActions2(FP,MoveMarineArr)
	--65~73
	for i = 17, 19 do
	local WhileC = CreateCcode() 
	CWhile(FP,{Bring(Force1,AtLeast,1,"Men",i),CD(WhileC,1000,AtMost)},{AddCD(WhileC,1)})
	f_Rand(FP,RandV)
	CAdd(FP,TempX,_Mod(RandV,2272-800),800)
	CAdd(FP,TempY,_Mod(RandV,6080-5440),5440)
	Simple_SetLocX(FP,0,TempX,TempY,TempX,TempY,{MoveUnit(1,"Men",Force1,i,1)})
	CWhileEnd()
	DoActionsX(FP,{SetCD(WhileC,0)})
	end

	CallTrigger(FP, ComputerReplace)
--	TriggerX(FP,{CVar(FP,Level[2],AtMost,10)},{SetCVar(FP,RandW[2],Add,30)},{preserved})
--	TriggerX(FP,{CVar(FP,Level[2],AtLeast,11)},{SetCVar(FP,RandW[2],Add,100)},{preserved})
	
	CIf(FP,{CDeaths(FP,AtLeast,1,isBossStage)})
		for i = 0, 6 do
			CIf(FP,{HumanCheck(i, 1)},{SetDeaths(i, SetTo, 150, 15)})
			CAdd(FP,NukesUsage[i+1],_Div(NCCalc,PCheckV))
			CallTriggerX(FP,Call_Print13[i+1],{})
			CIfEnd()
		end
		TriggerX(FP,{},{print_utf8(12,0,"\x07『 \x04추가 \x08뉴클리어\x04가 지급되었습니다. \x07』")},{preserved})
	CIfEnd()

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
	SetCDeaths(FP,SetTo,0,isBossStage),
	SetCDeaths(FP,SetTo,0,NoCcode),
	SetCDeaths(FP,SetTo,0,ConCP[1]);
	SetCDeaths(FP,SetTo,0,ConCP[2]);
	SetCDeaths(FP,SetTo,0,ConCP[3]);
	SetCDeaths(FP,SetTo,0,ConCP[4]);
	SetCDeaths(FP,SetTo,0,ConCP[5]);
	SetCDeaths(FP,SetTo,0,ConCP[6]);
	SetCDeaths(FP,SetTo,0,ConCP[7]);
	

	})
	DoActions(FP,{RotatePlayer({RunAIScript(P8VOFF)},MapPlayers,FP)})
	CIfEnd()
	CIfEnd()
end