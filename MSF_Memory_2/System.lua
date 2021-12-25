function System()
	Cast_UnitCount()
    AddBGM(1,"staredit\\wav\\BYD_OP.ogg",152*1000)
    AddBGM(2,"staredit\\wav\\story.ogg",81*1000)
    Install_BGMSystem(FP,3,BGMType,12)

    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)},{AddV(CurEXP,1)})
    DoActions(FP,MoveCp(Add,6*4))
    Install_DeathNotice()
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
    
    
    local TempMarHPRead = CreateVar(FP)
    EXCC_Part1(MarCUnit) -- 마린 구조오프셋 단락 시작
    PassArr={7,111,107,109,124,125}
    for j, i in pairs(PassArr) do
        EXCC_BreakCalc({DeathsX(CurrentPlayer,Exactly,i,0,0xFF)})
    end
	CSub(FP,0x6509B0,6)
    
    
	for i = 1, 4 do-- 조건부 CMov. 중간연산자 사용불가능
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                DeathsX(CurrentPlayer,Exactly,i-1,0,0xFF)
            },
            actions = {
                SetCtrig1X("X",TempMarHPRead[2],0x15C,"X",SetTo,0);
                SetCtrig1X("X",MarHPRead[i][2],0x148,"X",SetTo,0xFFFFFFFF);
                SetCtrig1X("X",MarHPRead[i][2],0x160,"X",SetTo,Add*16777216,0xFF000000);
                SetCtrigX("X",MarHPRead[i][2],0x158,"X",SetTo,"X",TempMarHPRead[2],0x15C,1,"X");
                CallLabel1("X",MarHPRead[i][2],"X")
            },
            flag = {Preserved}
        }
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                DeathsX(CurrentPlayer,Exactly,i-1,0,0xFF)
            },
            actions = {
                CallLabel2("X",MarHPRead[i][2],"X")
            },
            flag = {Preserved}
        }
        end

    CSub(FP,0x6509B0,17)

	CIfX(FP,{TDeaths(CurrentPlayer,AtMost,Vi(TempMarHPRead[2],-256),0)},{TSetDeaths(CurrentPlayer,Add,MarHPRegen,0)})
	CElseX({TSetDeaths(CurrentPlayer,SetTo,TempMarHPRead,0)})
	CIfXEnd()

	CAdd(FP,0x6509B0,17)
    EXCC_ClearCalc()
    EXCC_Part2()
    EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
            DeathsX(19025+(84*i)+19,AtLeast,0,0,0xFF),
            DeathsX(19025+(84*i)+19,AtMost,3,0,0xFF),
            DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,25*4),
		})
	end
	EXCC_End()
    
    
    SETimer = CreateCcode()
    TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,100,SETimer)},{Preserved})




end