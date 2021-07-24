function MapPreserves()
	Print13_Preserve()

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
    Trigger { -- 동맹상태 고정, 중립마린 제거
    	players = {FP},
    	actions = {
    		SetAllianceStatus(Force1,Enemy);
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
    CAdd(FP,Time,Dt)
    CMov(FP,TimePtr,Time)
    CMov(FP,LevelPtr,Level)
    DoActions(FP,{print_utf8(12, 0, "\x07[ LV.000\x04 - \x1F00h \x1100m \x0F00s \x04- \x07기부\x04 : F9\x07 ]")})
	DoActions2(FP,PatchArrPrsv)
	TriggerX(FP,{CDeaths(FP,AtLeast,1,countdownSound)},{
		RotatePlayer({
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			PlayWAVX("sound\\glue\\countdown.wav");
			},HumanPlayers,FP);
			SetCDeaths(FP,SetTo,0,countdownSound);
	},{Preserved})
end
