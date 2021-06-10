function LeaderBoardTFunc()
    local LeaderBoardT = CreateCCode()
    Trigger { -- 킬 포인트 리더보드, 집근처 유닛 오더시키기, 쉴드 회복, 저글링 히드라 어택땅
        players = {FP},
        conditions = {
            Label(0);
            
            CDeaths(FP,AtMost,0,LeaderBoardT);
        },
        actions = {
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

    DoActionsX(FP,SetCDeaths(FP,Subtract,1,LeaderBoardT))
end