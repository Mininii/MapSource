function System()
	Cast_UnitCount()
    IBGM_EPDX(FP,3,Dt)

    CunitCtrig_Part1(FP) -- 죽은유닛 인식 단락 시작
    DoActions(FP,MoveCp(Subtract,6*4))
    Check_P8 = def_sIndex()
    NJump(FP,Check_P8,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})
    DoActions(FP,MoveCp(Add,6*4))
    --Install_DeathNotice()

    ClearCalc()

    NJumpEnd(FP,Check_P8)
    DoActions(FP,MoveCp(Add,6*4))
    CIf(FP,CVar(FP,EXCunitTemp[9][2],AtLeast,1)) -- 영작유닛인식
    f_SaveCp()
    --InstallHeroPoint()
    CIfEnd()
--    CMov(FP,Gun_Type,0)

--    f_GSend(131)
--    f_GSend(132)
--    f_GSend(133)
	

    if TestStart == 1 then
        --f_GSend(146)
        --f_GSend(136)
    end



    ClearCalc()
	Cast_EXCC()


end