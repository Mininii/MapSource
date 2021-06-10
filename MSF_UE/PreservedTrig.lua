function MapPreserves()
	Print13_Preserve()
    Trigger { -- 동맹상태 고정, 중립마린 제거
	players = {Force1},
	actions = {
		SetAllianceStatus(Force1,Ally);
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
    Trigger { -- 동맹상태 고정, 중립마린 제거
    	players = {FP},
    	actions = {
    		SetAllianceStatus(Force1,Enemy);
    		PreserveTrigger();
    	},
    }
    DoActions(FP,{ModifyUnitEnergy(All,"Men",P12,64,0),KillUnit("Men",P12)})
    CAdd(FP,Time,Dt)
    CMov(FP,EPDToPtr(TimePtr),Time)
    CMov(FP,EPDToPtr(LevelPtr),Level)
    CDoActions(FP,{TSetDeathsX(FP,Subtract,Dt,440,0xFFFFFF)}) -- FP의 브금타이머. 관전자용
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
