function Gun_System()
	UnitReadX(FP,AllPlayers,229,64,count)
	UnitReadX(FP,AllPlayers,17,64,count1)
	UnitReadX(FP,AllPlayers,23,64,count2)
	UnitReadX(FP,AllPlayers,25,64,count3)
	CAdd(FP,count,count1)
	CAdd(FP,count,count2)
	CAdd(FP,count,count3)
    local EXCunit_Reset = {}
    for i = 1, #EXCunitTemp do
        table.insert(EXCunit_Reset,SetCtrig1X("X","X",CAddr("Value",i-1,0),0,SetTo,0))
    end
    --[[
    EXCunit 적용
    1번줄 : 건작의 레벨
    9번줄 : 영작유닛 표식
    10번줄 : 마린 데스값 중복적용 방지용
    ]]
    CunitCtrig_Part1(FP) -- 죽은유닛 인식 단락 시작
    DoActions(FP,MoveCp(Subtract,6*4))
    Check_P8 = def_sIndex()
    NJump(FP,Check_P8,DeathsX(CurrentPlayer,Exactly,7,0,0xFF))
    DoActions(FP,MoveCp(Add,6*4))
    Install_DeathNotice()

    ClearCalc()

    NJumpEnd(FP,Check_P8)
    DoActions(FP,MoveCp(Add,6*4))
    CIf(FP,CVar(FP,EXCunitTemp[9][2],AtLeast,1)) -- 영작유닛인식
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
        f_GSend(146)
        --f_GSend(136)
    end



    ClearCalc()
    CunitCtrig_Part2()
    DoActionsXI(FP,EXCC_Forward)
    CunitCtrig_Part3X()
    for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
    CunitCtrig_Part4_EX(i,{
    DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
    DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
    },
    {SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
    SetCVar(FP,CurCunitI[2],SetTo,i),EXCunit_Reset,
    MoveCp(Add,25*4),
    },EXCunitTemp)
    end
    CunitCtrig_End()
    DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
    TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,0,SoundLimitT)},{Preserved})

    CIfX(FP,{CVar(FP,count[2],AtMost,GunLimit),Bring(FP,AtLeast,1,147,64)}) -- 건작함수 제어
        DoActions(FP,{
            SetInvincibility(Disable,"Buildings",FP,64);
        })
        CMov(FP,Actived_Gun,0)
        CSub(FP,_Ccode(FP,GCT),Dt)
        for i = 0, 63 do
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
        CElseX()
        DoActions(FP,{
            SetInvincibility(Enable,"Buildings",FP,64);
        })
    CIfXEnd()
end