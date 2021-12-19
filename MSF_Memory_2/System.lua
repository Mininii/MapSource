function System()
	Cast_UnitCount()
    AddBGM(1,"staredit\\wav\\BYD_OP.ogg",152*1000)
    AddBGM(2,"staredit\\wav\\story.ogg",81*1000)
    Install_BGMSystem(FP,3,BGMType,12)

    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)},{AddV(CurEXP,1)})
    DoActions(FP,MoveCp(Add,6*4))
    --Install_DeathNotice()
    EXCC_ClearCalc()
    NJumpEnd(FP,Check_Enemy)
    DoActions(FP,MoveCp(Add,6*4))
    CIf(FP,{Cond_EXCC(8,AtLeast,1)}) -- 영작유닛인식
    f_SaveCp()
    InstallHeroPoint()
    CIfEnd()
--    CMov(FP,Gun_Type,0)

--    f_GSend(131)
--    f_GSend(132)
--    f_GSend(133)

    if TestStart == 1 then
        --f_GSend(146)
        --f_GSend(136)
    end



    EXCC_ClearCalc()
    EXCC_Part2()
    EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
		DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
		DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
		},
		{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
		MoveCp(Add,19*4),
		})
	end
	EXCC_End()


    
    SETimer = CreateCcode()
    TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,100,SETimer)},{Preserved})




end