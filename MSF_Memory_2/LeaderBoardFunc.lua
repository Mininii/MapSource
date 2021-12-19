function LeaderBoardF()
    
	local LeaderBoardT = CreateCcode()
    local CurAttackP = CreateCcode()

    CIf(FP,{CD(OPJump,1)})
		
    for i = 0, 3 do
        TriggerX(FP,{PlayerCheck(i,0),CDeaths(FP,AtMost,0,LeaderBoardT);},{
            Order("Factories",P5+i,11+i,Attack,64),--트리거 인식상 Factories 처리 유닛들만 이동시킴
        },{Preserved})
        TriggerX(FP,{PlayerCheck(i,1),CDeaths(FP,Exactly,300,LeaderBoardT);},{
            Order("Factories",P5+i,11+i,Attack,64),--트리거 인식상 Factories 처리 유닛들만 이동시킴
        },{Preserved})
    end

	Trigger { -- 킬 포인트 리더보드, 집근처 유닛 오더시키기, 쉴드 회복, 저글링 히드라 어택땅
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,0,LeaderBoardT);
		},
		actions = {
			LeaderBoardScore(Kills, StrDesign("\x1DP\x04oints\x07"));
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
			LeaderBoardScore(Custom,StrDesign("\x08D\x04eath \x10C\x04ounts"));
			LeaderBoardComputerPlayers(Disable);
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
			LeaderBoardKills("Any unit",StrDesign("\x11K\x04ills\x07"));
			LeaderBoardComputerPlayers(Disable);
			PreserveTrigger();
	},
	}
	CIfEnd()



TriggerX(FP,{},{SetCDeaths(FP,Subtract,1,LeaderBoardT)},{Preserved})
end