function LeaderBoardTFunc()
    local LeaderBoardT = CreateCCode()
    Trigger { -- ų ����Ʈ ��������, ����ó ���� ������Ű��, ���� ȸ��, ���۸� ����� ���ö�
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
    Trigger { -- ���� ���ھ� ��������
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
    Trigger { -- ų ���ھ� ��������
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