function LevelUp()
    local CSelT = "\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\n\n\n\x13\x04���� �÷��̾�� �������ּ���.\n\x13\x04���� ������ �����Ͻðڽ��ϱ�?\n\x13\x04(\x07Y \x04/ \x11N\x04)\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������"
    local ClearT1 = "\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x14\n\x14\n\x13\x04������ �ǹ� \x03OverMind \x1DShell \x04�� �ı��ϼ̽��ϴ�.\n\x13\x07\n\n\x14\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������"
    local ClearT3 = "\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x14\n\x14\n\x13\x04������ �ǹ� \x03OverMind \x1DShell \x04�� �ı��ϼ̽��ϴ�.\n\x13\x07S T A R T\n\n\x14\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������"
    local ClearT2 = "\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x14\n\x14\n\x13\x04������ �ǹ� \x03OverMind \x1DShell \x04�� �ı��ϼ̽��ϴ�.\n\x13\x0710�� �� ���� ������ �����մϴ�.\n\n\x14\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������"
    local NoText = "\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\n\x14\n\x14\n\n\x13\x04NO�� �Է��ϼ̽��ϴ�. ������ �����մϴ�.\n\n\x14\n\n\x13\x04������������������������������������������������������������������������������������������������������������"
    local TextSwitch = Create_CCTable(5)
    DoActions(FP,{SetInvincibility(Enable,147,P8,"Anywhere"),
    })
    TriggerX(FP,{CVar(FP,Actived_Gun[2],AtMost,0),
    CVar(FP,B1_H[2],AtMost,0),
    CommandLeastAt(131,64),
    CommandLeastAt(132,64),
    CommandLeastAt(133,64),
    CommandLeastAt(151,64),
    CommandLeastAt(152,64),
    CommandLeastAt(148,64),
    CommandLeastAt(130,64),
    CommandLeastAt(201,64),
    },{
    SetInvincibility(Disable,147,P8,"Anywhere")
    },{Preserved})
    
    
    
    CIf(FP,{Bring(FP,AtMost,0,147,64),CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),CDeaths(FP,AtMost,0,Win)})
    
    CIf(FP,{CDeaths(FP,AtMost,0,ReplaceDelayT)},SetCDeaths(FP,Add,1,ReplaceDelayT)) -- ���� Ŭ���� �� 1ȸ ���� Ʈ���ŵ�

    -- ������ȯ �׽�Ʈ
    if TestStart == 1 then
        DoActions(FP,{RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),
        ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8),KillUnit(125,Force1),KillUnit(124,Force1)})
        

        --f_Read(FP,0x628438,nil,Nextptrs,0xFFFFFF)
        --CDoActions(FP,{CreateUnit(1,87,29,FP),TSetMemory(B_5_C,SetTo,Nextptrs),SetCVar(FP,BGMTypeV[2],SetTo,roka7BGM),TSetMemory(0x58D744,SetTo,Vi(Nextptrs[2],55))})
        
        DoActionsX(FP,{SetCDeaths(FP,Add,1,StoryT)})



        CMov(FP,CunitIndex,0)-- ��� ���� �������� �÷��� ����
        CWhile(FP,{CVar(FP,CunitIndex[2],AtMost,1699)})
            CDoActions(FP,{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,0)})
            CAdd(FP,CunitIndex,1)
        CWhileEnd()
    end
    
    --
    CIfEnd()

    StoryT3 = CreateCCode()
    BClear = CreateCCode()
    CIf(FP,{CDeaths(FP,AtLeast,1,BClear),Switch(ResetSwitch,Cleared)}) -- ����Ŭ����� 1ȸ���� Ʈ����
    
    TriggerX(FP,{CVar(FP,Level[2],AtMost,10)},{SetCVar(FP,MarNumberLimit[2],Add,84*2),SetCDeaths(FP,Add,100,PExitFlag)},{Preserved})
    
    CMov(FP,CunitIndex,0)-- ��� ���� �������� �÷��� ����
    CWhile(FP,{CVar(FP,CunitIndex[2],AtMost,1699)})
        CDoActions(FP,{TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,0)})
        CAdd(FP,CunitIndex,1)
    CWhileEnd()
    
    CAdd(FP,Level,1)
    f_Mod(FP,LevelT,Level,_Mov(10))
    CAdd(FP,LevelT,1)
    f_Div(FP,LevelT2,Level,_Mov(10))
    CAdd(FP,LevelT2,1)
    if TestStart == 1 then
        
        CMov(FP,LevelT2,4)
    end

    TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,5)},{SetCVar(FP,LevelT2[2],SetTo,4)},{Preserved})
    --
    TriggerX(FP,{CVar(FP,LevelT[2],AtMost,5)},{SetCVar(FP,ReserveBGM[2],SetTo,6)},{Preserved})
    TriggerX(FP,{CVar(FP,LevelT[2],AtLeast,6)},{SetCVar(FP,ReserveBGM[2],SetTo,1)},{Preserved})


    function SetLevelUpHP(UnitID,Multiplier)
        CallTrigger(FP,f_SetLvHP,{SetCVar(FP,UnitIDV[2],SetTo,UnitID),SetCVar(FP,MultiplierV[2],SetTo,Multiplier)})
    end


    
    for i = 37, 56 do
        SetLevelUpHP(i,1)
    end
    
        SetLevelUpHP(104,1)
    for j, k in pairs(HeroArr) do
        SetLevelUpHP(k,2)
    end
    BdArr = {131,132,133,135,136,137,138,139,140,141,142,143,144,146}
    
    for j, k in pairs(BdArr) do
        SetLevelUpHP(k,2)
    end
    
    
    Trigger2(FP,{MemoryB(0x58D2B0+(46*7)+3,AtMost,49)},{SetMemoryB(0x58D2B0+(46*7)+3,Add,1)},{Preserved})

    
TriggerX(FP,{CDeaths(FP,AtMost,0,StoryT3)},{RotatePlayer({DisplayTextX(ClearT1,4),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg"),PlayWAVX("staredit\\wav\\Level_Clear.ogg")},HumanPlayers,FP)},{Preserved})
    DoActions(FP,{SetSwitch(ResetSwitch,Set)})
    DoActions(FP,{RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),
    ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8),KillUnit(125,Force1),KillUnit(124,Force1)})
    CIfEnd()
    
    
    CTrigger(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CDeaths(FP,AtMost,0,Continue2),CDeaths(FP,Exactly,0,Continue)},{
        RotatePlayer({DisplayTextX(CSelT,4),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Continue2)
    },1)
    CMov(FP,0x6509B0,CurrentOP)
    NoB = 220
    YesB = 221
    TriggerX(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CDeaths(FP,Exactly,0,Continue),Deaths(CurrentPlayer,AtLeast,1,NoB)},{RotatePlayer({DisplayTextX(NoText,4),PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");},HumanPlayers,FP),SetCDeaths(FP,Add,1,Win)},{Preserved})
    TriggerX(FP,{CDeaths(FP,AtLeast,5001,ReplaceDelayT),CDeaths(FP,Exactly,0,Continue),Deaths(CurrentPlayer,AtLeast,1,YesB)},{RotatePlayer({DisplayTextX(ClearT2,4),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg"),PlayWAVX("staredit\\wav\\LimitBreak.ogg")},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,Continue)},{Preserved})
    CMov(FP,0x6509B0,FP)
    
    for i = 0, 4 do
        TriggerX(FP,{CDeaths(FP,AtLeast,10000+(i*1000),ReplaceDelayT),CDeaths(FP,AtMost,0,TextSwitch[i+1])},{RotatePlayer({DisplayTextX("\n\n\n\x13\x04������������������������������������������������������������������������������������������������������������\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x14\n\x14\n\x13\x04������ �ǹ� \x03OverMind \x1DShell \x04�� �ı��ϼ̽��ϴ�.\n\x13\x0710�� �� ���� ������ �����մϴ�.\n\x13\x04"..5-i.."�� ���ҽ��ϴ�.\n\x14\n\x13\x04��������\x1F�̣ţ֣ţ̡��ạ̃ţ���\x04��������\n\x13\x04������������������������������������������������������������������������������������������������������������",4)},HumanPlayers,FP),
        SetCDeaths(FP,SetTo,1,TextSwitch[i+1]),SetCDeaths(FP,SetTo,1,countdownSound)},{Preserved})
    end

    Id_T6 = "\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n \x13\x02�ڽ�ũ ����� \x11����(Regal) \x04�� \x1F����¥�� ���� \x10T\x1Earim\x04�� \x07����¥��\x04�� \x08��� \x04�зȽ��ϴ�.\r\n\r\n\x13\x05\"�׳���� ��� �� �����...\"\r\n "
    TriggerX(FP,{CDeaths(FP,AtLeast,1,rokaClear)},{SetCDeaths(FP,SetTo,1,BClear)},{Preserved})
    TriggerX(FP,{CDeaths(FP,AtLeast,1,IdenClear),CDeaths(FP,AtMost,0,StoryT3)},{RotatePlayer({DisplayTextX(Id_T6,4),PlayWAVX("staredit\\wav\\Satellite.wav"),PlayWAVX("staredit\\wav\\Satellite.wav")},HumanPlayers,FP),SetCDeaths(FP,Add,1,StoryT3),SetCDeaths(FP,SetTo,1,BClear)},{Preserved})



    CTrigger(FP,{CDeaths(FP,AtLeast,1,BClear),CDeaths(FP,AtMost,5000,ReplaceDelayT)},{TSetCDeaths(FP,Add,Dt,ReplaceDelayT)},1)
    CTrigger(FP,{CDeaths(FP,AtLeast,1,BClear),CDeaths(FP,Exactly,1,Continue)},{TSetCDeaths(FP,Add,Dt,ReplaceDelayT)},1)

    CIf(FP,CDeaths(FP,AtLeast,15000,ReplaceDelayT))
    TriggerX(FP,{},{RotatePlayer({DisplayTextX(ClearT3,4)},HumanPlayers,FP)},{Preserved})
    
    DoActions(FP,{RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");PlayWAVX("sound\\glue\\bnetclick.wav");},HumanPlayers,FP)})
    MoveMarineArr = {}
    for i = 0, 6 do
    table.insert(MoveMarineArr,MoveUnit(All,"Men",i,19,2+i))
    table.insert(MoveMarineArr,MoveUnit(All,"Men",i,17,2+i))
    table.insert(MoveMarineArr,MoveUnit(All,"Men",i,18,2+i))
    for j = 0, 4 do
    table.insert(MoveMarineArr,MoveUnit(All,"Men",i,19,20+j))
    table.insert(MoveMarineArr,MoveUnit(All,"Men",i,17,20+j))
    table.insert(MoveMarineArr,MoveUnit(All,"Men",i,18,20+j))
    end
    end
    DoActions2(FP,MoveMarineArr)
    
    CMov(FP,0x6509B0,UnitDataPtr)
    CWhile(FP,{Deaths(CurrentPlayer,AtLeast,1,0)})
        CAdd(FP,0x6509B0,1)
        CIf(FP,DeathsX(CurrentPlayer,Exactly,7*256,0,0xFF00))
            CSub(FP,0x6509B0,1)
            CallTrigger(FP,f_Replace)-- ������ȭ �� ���� ���ġ�ϴ� �ڵ�.
            CAdd(FP,0x6509B0,1)
        CIfEnd()
        CSub(FP,0x6509B0,1)
        CAdd(FP,0x6509B0,2)
    CWhileEnd()
    CMov(FP,0x6509B0,FP)
    TriggerX(FP,{CVar(FP,Level[2],AtMost,10)},{SetCVar(FP,RandW[2],Add,10)},{Preserved})
    TriggerX(FP,{CVar(FP,Level[2],AtLeast,11)},{SetCVar(FP,RandW[2],Add,80)},{Preserved})
    

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
    SetCDeaths(FP,SetTo,0,IdenClear),
    SetCDeaths(FP,SetTo,0,StoryT3),
    SetCDeaths(FP,SetTo,0,BClear),
    SetSwitch(ResetSwitch,Clear),
    SetCDeaths(FP,SetTo,0,BossStart),
    })
    DoActions(FP,{RotatePlayer({RunAIScript(P8VOFF)},MapPlayers,FP)})
    CIfEnd()
    CIfEnd()
end