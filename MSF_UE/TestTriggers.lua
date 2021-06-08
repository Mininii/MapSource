function Test_LV1()
    if Limit == 1 then

    end
end
function Test_LV2()
    if Limit == 1 and TestStart == 1 then
        DoActions(FP,{SetResources(Force1,SetTo,0x70000000,Ore),RotatePlayer({RunAIScript("Turn ON Shared Vision for Player 8")},MapPlayers,FP)})
    end
end
