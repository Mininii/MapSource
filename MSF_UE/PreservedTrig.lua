function MapPreserves()
	Print13_Preserve()
	DoActionsX(FP,{SetCVar(FP,RecallPosX[2],SetTo,32)})
	TriggerX(FP,{CDeaths(FP,AtMost,0,StoryT4)},{RotatePlayer({		
		RunAIScript("Turn ON Shared Vision for Player 1");
		RunAIScript("Turn ON Shared Vision for Player 2");
		RunAIScript("Turn ON Shared Vision for Player 3");
		RunAIScript("Turn ON Shared Vision for Player 4");
		RunAIScript("Turn ON Shared Vision for Player 5");
		RunAIScript("Turn ON Shared Vision for Player 6");
		RunAIScript("Turn ON Shared Vision for Player 7");},MapPlayers,FP),},{Preserved})
    Trigger { -- 동맹상태 고정, 중립마린 제거
	players = {Force1},

	actions = {
		SetAllianceStatus(Force1,Ally);
		PreserveTrigger();
	    },
    }
	RemoveTable = {}
	for i = 0, 6 do
		table.insert(RemoveTable, ModifyUnitEnergy(All,MarID[i+1],P12,64,0))
		table.insert(RemoveTable, KillUnit(MarID[i+1],P12))
	
	end
    DoActions(FP,{RemoveTable,
		ModifyUnitEnergy(All,7,P12,64,0),
		KillUnit(7,P12),
		ModifyUnitEnergy(All,10,P12,64,0),
		KillUnit(10,P12),
		ModifyUnitEnergy(All,124,P12,64,0),
		KillUnit(124,P12),
		ModifyUnitEnergy(All,125,P12,64,0),
		KillUnit(125,P12),
	})
	
CIf(FP,Switch("Switch 240",Set))
	CIf(FP,CVar(FP,Dt[2],AtMost,2500))
		CAdd(FP,WaveT,Dt)
		CAdd(FP,Time,Dt)
		IBGM_EPDX(FP,6,Dt,{Dt_NT2,Dt_NT})
	CIfEnd()
    CMov(FP,TimePtr,Time)
    CMov(FP,LevelPtr,Level)


	CIfEnd()
	for i = 0, 6 do
	Trigger2(FP,{Deaths(i,AtMost,0,15),Memory(0x57F1B0,Exactly,i)},{print_utf8(12, 0, "\x07[ LV.000\x04 - \x1F00h \x1100m \x0F00s \x04- \x07기부, 스탯 창\x04 : F9\x07 ]")},{Preserved})
	end
	TriggerX(FP,{CDeaths(FP,AtLeast,1,countdownSound)},{
		RotatePlayer({
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			},HumanPlayers,FP);
			SetCDeaths(FP,SetTo,0,countdownSound);
	},{Preserved})
	DoActions2(FP,PatchArrPrsv)
end
