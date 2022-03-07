function Gun_System()
	UnitReadX(FP,AllPlayers,229,64,count)
	UnitReadX(FP,AllPlayers,17,64,count1)
	UnitReadX(FP,AllPlayers,23,64,count2)
	UnitReadX(FP,AllPlayers,25,64,count3)
	CAdd(FP,count,count1)
	CAdd(FP,count,count2)
	CAdd(FP,count,count3)
	
--    CunitCtrig_Part1(FP) -- 죽은유닛 인식 단락 시작
--    DoActions(FP,MoveCp(Subtract,6*4))
--    Check_Force2 = def_sIndex()
--    NJump(FP,Check_Force2,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
--    DoActions(FP,MoveCp(Add,6*4))
--    --Install_DeathNotice()--

--    ClearCalc()--

--    NJumpEnd(FP,Check_Force2)
--    DoActions(FP,MoveCp(Add,6*4))
--    CIf(FP,CVar(FP,EXCunitTemp[9][2],AtLeast,1)) -- 영작유닛인식
--    f_SaveCp()
--    --InstallHeroPoint()
--    CIfEnd()
--    CMov(FP,Gun_Type,0)--

--    f_GSend(131)
--    f_GSend(132)
--    f_GSend(133)
--	--

--    if TestStart == 1 then
--        --f_GSend(146)
--        --f_GSend(136)
--    end--
--
--

--    ClearCalc()
--    CunitCtrig_Part2()
--    DoActionsXI(FP,EXCC_Forward)
--    CunitCtrig_Part3X()
--    for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
--    CunitCtrig_Part4_EX(i,{
--    DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
--    DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
--    },
--    {SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
--    SetCVar(FP,CurCunitI[2],SetTo,i),EXCunit_Reset,
--    MoveCp(Add,25*4),
--    },EXCunitTemp)
--    end
--    CunitCtrig_End()
    DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
    TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,0,SoundLimitT)},{Preserved})

    CIfX(FP,{CVar(FP,count[2],AtMost,GunLimit)}) -- 건작함수 제어
        CMov(FP,Actived_Gun,0)
        CMov(FP,0x6509B0,FP)
    CIfXEnd()
	for i = 0, 6 do
	CMov(FP,0x582174+(4*i),count)
	CAdd(FP,0x582174+(4*i),count)
	end
end