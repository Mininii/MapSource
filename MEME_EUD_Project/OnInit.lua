function OnInit()
    if TestStart == 1 then
            
        if TestStart == 1 then
            DoActionsX(FP,{SetSwitch("Switch 254", Set)}) -- Limit설정
            DoActionsX(FP, {SetCD(TestMode,1),--SetResources(Force1, Add, 66666666, Ore),
            })
        end
        if Limit == 1 then
            DoActionsX(FP,{SetSwitch("Switch 253", Set)}) -- Limit설정
        end
        DoActionsX(FP, {SetMemory(0x5124F0,SetTo,0x1D)}, 1)
    end
end