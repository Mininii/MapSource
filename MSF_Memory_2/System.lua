function System()
	Cast_UnitCount()

    CunitCtrig_Part1(FP) -- �������� �ν� �ܶ� ����
    DoActions(FP,MoveCp(Subtract,6*4))
    Check_P8 = def_sIndex()
    NJump(FP,Check_P8,DeathsX(CurrentPlayer,Exactly,7,0,0xFF))
    DoActions(FP,MoveCp(Add,6*4))
    --Install_DeathNotice()

    ClearCalc()

    NJumpEnd(FP,Check_P8)
    DoActions(FP,MoveCp(Add,6*4))
    CIf(FP,CVar(FP,EXCunitTemp[9][2],AtLeast,1)) -- ���������ν�
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