function Interface()
    for i = 0, 4 do
        DoActions(i,{SetCp(i),SetAllianceStatus(Force1,Ally),--팀킬방지
        RunAIScript("Turn ON Shared Vision for Player 1");
        RunAIScript("Turn ON Shared Vision for Player 2");
        RunAIScript("Turn ON Shared Vision for Player 3");
        RunAIScript("Turn ON Shared Vision for Player 4");
        RunAIScript("Turn ON Shared Vision for Player 5");
        })
        if TestStart == 1 then
            
        DoActions(i,{SetCp(i),
            RunAIScript("Turn ON Shared Vision for Player 1");
            RunAIScript("Turn ON Shared Vision for Player 2");
            RunAIScript("Turn ON Shared Vision for Player 3");
            RunAIScript("Turn ON Shared Vision for Player 4");
            RunAIScript("Turn ON Shared Vision for Player 5");
            RunAIScript("Turn ON Shared Vision for Player 6");
            RunAIScript("Turn ON Shared Vision for Player 7");
            RunAIScript("Turn ON Shared Vision for Player 8");
            })
        end
        
    end
    if TestStart == 1 then
        DoActions(P6,{SetCp(P6),
            RunAIScript("Turn ON Shared Vision for Player 1");
            RunAIScript("Turn ON Shared Vision for Player 2");
            RunAIScript("Turn ON Shared Vision for Player 3");
            RunAIScript("Turn ON Shared Vision for Player 4");
            RunAIScript("Turn ON Shared Vision for Player 5");
            RunAIScript("Turn ON Shared Vision for Player 6");
            RunAIScript("Turn ON Shared Vision for Player 7");
            RunAIScript("Turn ON Shared Vision for Player 8");
            })
    DoActions(P7,{SetCp(P7),
        RunAIScript("Turn ON Shared Vision for Player 1");
        RunAIScript("Turn ON Shared Vision for Player 2");
        RunAIScript("Turn ON Shared Vision for Player 3");
        RunAIScript("Turn ON Shared Vision for Player 4");
        RunAIScript("Turn ON Shared Vision for Player 5");
        RunAIScript("Turn ON Shared Vision for Player 6");
        RunAIScript("Turn ON Shared Vision for Player 7");
        RunAIScript("Turn ON Shared Vision for Player 8");
        })
    DoActions(P8,{SetCp(P8),
        RunAIScript("Turn ON Shared Vision for Player 1");
        RunAIScript("Turn ON Shared Vision for Player 2");
        RunAIScript("Turn ON Shared Vision for Player 3");
        RunAIScript("Turn ON Shared Vision for Player 4");
        RunAIScript("Turn ON Shared Vision for Player 5");
        RunAIScript("Turn ON Shared Vision for Player 6");
        RunAIScript("Turn ON Shared Vision for Player 7");
        RunAIScript("Turn ON Shared Vision for Player 8");
        })
    end
end