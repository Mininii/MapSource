function Gun_System()


    --[[
    EXCunit 적용
    1번줄 : 건작의 레벨
    9번줄 : 영작유닛 표식
    10번줄 : 마린 데스값 중복적용 방지용
    ]]
    EXCC_Part1(DUnitCalc)
    --CunitCtrig_Part1(FP) -- 죽은유닛 인식 단락 시작
    DoActions(FP,MoveCp(Subtract,6*4))
    Check_P8 = def_sIndex()
    NJump(FP,Check_P8,DeathsX(CurrentPlayer,Exactly,7,0,0xFF))
    DoActions(FP,MoveCp(Add,6*4))
    Install_DeathNotice()
    EXCC_ClearCalc()
    --ClearCalc()

    NJumpEnd(FP,Check_P8)
    DoActions(FP,MoveCp(Add,6*4))
    CIf(FP,Cond_EXCC(8,AtLeast,1)) -- 영작유닛인식
    f_SaveCp()
    InstallHeroPoint()
    CIfEnd()
    CMov(FP,Gun_Type,0)
    CIf(FP,{CVar(FP,LevelT[2],AtMost,3)})
    for j, k in pairs({142,135,140,141,138,139,137}) do -- 잡건작 목록
        f_GSend(k,{SetCVar(FP,Gun_Type[2],SetTo,256)}) -- GunType = 잡건작 플래그
    end
    CIfEnd()

    f_GSend(131)
    f_GSend(132)
    f_GSend(133)
    f_GSend(130)
    f_GSend(151)
    f_GSend(201)
    f_GSend(148)
    f_GSend(173)
    f_GSend(152)
    CIf(FP,{DeathsX(CurrentPlayer,Exactly,193,0,0xFF)}) -- 다크아칸 폭발이펙트
        f_SaveCp()
        f_Read(FP,_Sub(BackupCp,15),CPos)
        Convert_CPosXY()
        CreateBullet(205,20,0,CPosX,CPosY)
        CreateBullet(206,20,0,CPosX,CPosY)
        CSPlot(CSMakePolygon(8,64,0,PlotSizeCalc(2,6),1),FP,63,0,nil,1,32,FP,nil,nil,1)
        DoActions(FP,{KillUnit(63,FP)})
        f_LoadCp()
    CIfEnd()

    if TestStart == 1 then
        --f_GSend(146)
        --f_GSend(136)
    end



    EXCC_ClearCalc()
    EXCC_Part2()
    --CunitCtrig_Part2()
    --DoActionsXI(FP,EXCC_Forward)
    EXCC_Part3X()
    --CunitCtrig_Part3X()
    for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
    EXCC_Part4X(i,{
    DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
    DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
    },
    {SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
    SetCVar(FP,CurCunitI[2],SetTo,i),
    MoveCp(Add,25*4),
    })--
    end
    EXCC_End()




    
    
    EXCC_Part1(LHPCunit)
    f_SaveCp()
    local ReadHP = CreateVar(FP)
    local TempV1 = CreateVar(FP)
    local TempV2 = CreateVar(FP)
    local TempW = CreateWar(FP)
    local TempW2 = CreateWar(FP)
    local TempW3 = CreateWar(FP)
    local TempW4 = CreateWar(FP)
    local TempW5 = CreateWar(FP)
    local VoidV = CreateVar(FP)

    
    f_Read(FP, BackupCp, ReadHP)

    f_LMov(FP, TempW, {EXCC_TempVarArr[2],EXCC_TempVarArr[3]}, nil, nil, 1)
    f_LMov(FP, TempW2, {ReadHP,VoidV}, nil, nil, 1)


    f_LAdd(FP, TempW3, TempW, TempW2)
    
    CIfX(FP, {TTCWar(FP, TempW3[2], AtLeast, tostring(8320000*256))})
    
        f_LSub(FP, TempW4, _LMov(tostring(8320000*256)), TempW2)
        f_LSub(FP, TempW5, TempW, TempW4)


        f_LMov(FP, {EXCC_TempVarArr[2],EXCC_TempVarArr[3]},TempW5, nil, nil, 1)
    CDoActions(FP, {
        TSetMemory(BackupCp, SetTo, 8320000*256),
        Set_EXCCX(0, SetTo, 1),
        Set_EXCCX(1, SetTo, EXCC_TempVarArr[2]),
        Set_EXCCX(2, SetTo, EXCC_TempVarArr[3]),
    })
    CElseX()
        f_LMov(FP, {TempV1,TempV2}, TempW, nil, nil, 1)
        CDoActions(FP, {
            TSetMemory(BackupCp, Add, TempV1),
            Set_EXCCX(0, SetTo, 0),
            Set_EXCCX(1, SetTo, 0),
            Set_EXCCX(2, SetTo, 0),
        })
    CIfXEnd()
    

    f_LoadCp()
    EXCC_ClearCalc()
    EXCC_Part2()
    EXCC_Part3X()
    
    for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
    EXCC_Part4X(i,{
        
        CVar("X", "X", AtLeast, 1);
        Deaths(19025+(84*i)+2,AtMost,(8320000*256)-256,0),
        DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
        DeathsX(19025+(84*i)+19,AtLeast,7,0,0xFF00),
    },
    {
        SetCVar(FP,CurCunitI[2],SetTo,i),
        SetCVar(FP, BackupCp[2], SetTo, 19025+(84*i)+2);
        MoveCp(Add,2*4),
    })--
    end
    EXCC_End()


    
    DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
    TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{
        SetCDeaths(FP,SetTo,0,SoundLimit[1]),
        SetCDeaths(FP,SetTo,0,SoundLimit[2]),
        SetCDeaths(FP,SetTo,0,SoundLimit[3]),
        SetCDeaths(FP,SetTo,0,SoundLimit[4]),
        SetCDeaths(FP,SetTo,0,SoundLimit[5]),
        SetCDeaths(FP,SetTo,0,SoundLimit[6]),
        SetCDeaths(FP,SetTo,0,SoundLimit[7]),
        SetCDeaths(FP,SetTo,0,SoundLimitT)},{preserved})

    CIfX(FP,{Memory(0x628438,AtLeast,1),CVar(FP,count[2],AtMost,GunLimit),Bring(FP,AtLeast,1,147,64)}) -- 건작함수 제어
        DoActions(FP,{
            SetInvincibility(Disable,"Buildings",FP,64);
        })
        CMov(FP,Actived_Gun,0)
		CTrigger(FP,{CVar(FP,Dt[2],AtMost,2500)},{TSetCDeaths(FP,Subtract,Dt,GCT)},1)
        for i = 0, 127 do
            CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
                Var_InputCVar,
                SetCtrigX("X",G_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
                SetCVar(FP,f_GunNum[2],SetTo,i),
                SetCVar(FP,Actived_Gun[2],Add,1),
                SetNext("X",f_Gun,0),SetNext(f_Gun+1,"X",1), -- Call f_Gun
                SetCtrigX("X",f_Gun+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
                SetCtrigX("X",f_Gun+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
                SetCtrig1X("X",f_Gun+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
            }, 1, 0x500+i)
        end
        CMov(FP,0x6509B0,FP)
        Create_G_CB_Arr()
        CElseX()
        DoActions(FP,{
            SetInvincibility(Enable,"Buildings",FP,64);
        })
    CIfXEnd()
    if Limit == 1 then
        TriggerX(FP,CD(TestMode,1), RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),{preserved})
    end
end
