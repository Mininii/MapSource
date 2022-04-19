function System()
    local CPlayer = CreateVar(FP)
    local BCPos = CreateVar(FP)
	local CurCunitI2 = CreateVar(FP)
    local TempTarget = CreateVar(FP)
    DoActions(FP,{
        RemoveUnit(7,P12),
        RemoveUnit(MarID[1],P12),
        RemoveUnit(MarID[2],P12),
        RemoveUnit(MarID[3],P12),
        RemoveUnit(MarID[4],P12),
        ModifyUnitEnergy(All,"Men",P12,64,0),
        RemoveUnit(204,FP),RemoveUnit(205,Force2)})

	Cast_UnitCount()
    AddBGM(1,"staredit\\wav\\BYD_OP.ogg",152*1000)--오프닝
    AddBGM(2,"staredit\\wav\\GBGM1.ogg",33*1000)--햇
    AddBGM(3,"staredit\\wav\\GBGM2.ogg",34*1000)--레어
    AddBGM(4,"staredit\\wav\\GBGM3.ogg",55*1000)--하이브
    AddBGM(5,"staredit\\wav\\GBGM4.ogg",69*1000)--특건
    AddBGM(6,"staredit\\wav\\MBoss.ogg",133*1000)--워프
    AddBGM(7,"staredit\\wav\\story.ogg",83*1000)--스토리
    AddBGM(8,"staredit\\wav\\ED2Boss.ogg",165*1000)--엔딩2
    Install_BGMSystem(FP,3,BGMType,12,1)

    BGMArr = {}
    for i = 1, 364 do
        if i <= 9 then
            table.insert(BGMArr,"staredit\\wav\\BGM00"..i..".ogg")
        elseif i >= 10 and i<= 99 then
            table.insert(BGMArr,"staredit\\wav\\BGM0"..i..".ogg")
        else
            table.insert(BGMArr,"staredit\\wav\\BGM"..i..".ogg")
        end
    end

    CIf(FP,{Command(FP,AtLeast,1,190)})
    for i = 0, 3 do
        CIf(FP,{HumanCheck(i,1),Deaths(i,Exactly,0,12),Deaths(i,Exactly,0,14)})
        for j = 0, 363 do
            Trigger { -- 상시브금
                players = {FP},
                conditions = {
                    Deaths(i,Exactly,j,13);
                    Deaths(i,AtMost,0,14);
                },
                actions = {
                    SetCp(i);
                    PlayWAV(BGMArr[j+1]); 
                    SetCp(FP);
                    SetDeathsX(i,Add,2000,14,0xFFFFFF);
                    SetDeathsX(i,Add,1,13,0xFFFFFF);
                    PreserveTrigger();
                    
                    },
                }
        end
        Trigger { -- 상시브금
            players = {FP},
            conditions = {
                Deaths(i,AtLeast,364,13);
                Deaths(i,AtMost,0,14);
            },
            actions = {
                SetCp(i);
                PlayWAV(BGMArr[1]); 
                SetCp(FP);
                SetDeaths(i,Add,2000,14);
                SetDeaths(i,SetTo,1,13);
                PreserveTrigger();
                
                },
            }
            CIfEnd()
    end
    CIf(FP,{Deaths(FP,Exactly,0,12),Deaths(FP,Exactly,0,14)})
    for j = 0, 363 do
        Trigger { -- 상시브금
            players = {FP},
            conditions = {
                Deaths(FP,Exactly,j,13);
                Deaths(FP,AtMost,0,14);
            },
            actions = {
                RotatePlayer({PlayWAVX(BGMArr[j+1])},ObPlayers,FP);
                SetDeaths(FP,Add,2000,14);
                SetDeaths(FP,Add,1,13);
                PreserveTrigger();
                
                },
            }
    end
    Trigger { -- 상시브금
        players = {FP},
        conditions = {
            Deaths(FP,AtLeast,364,13);
            Deaths(FP,AtMost,0,14);
        },
        actions = {
            RotatePlayer({PlayWAVX(BGMArr[1])},ObPlayers,FP);
            SetDeaths(FP,Add,2000,14);
            SetDeaths(FP,SetTo,1,13);
            PreserveTrigger();
            
            },
        }
    CIfEnd()
    CIfEnd()

CurBID = CreateCcode()
HPRegenTable = {64}
--    CMov(FP,0x57f120,0)
    local TempMarHPRead = CreateVar(FP)
    EXCC_Part1(UnivCunit) -- 기타 구조오프셋 단락 시작
    WhiteList = def_sIndex()
    HPRList = def_sIndex()
    for j, i in pairs(MarID) do
        NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
    end
    for j, i in pairs(HPRegenTable) do
        NJumpX(FP,HPRList,DeathsX(CurrentPlayer,Exactly,i,0,0xFF),{SetCD(CurBID,i)})
    end
    SkillUnit = def_sIndex()
    NJumpX(FP,SkillUnit,{TTOR({DeathsX(CurrentPlayer,Exactly,183,0,0xFF),DeathsX(CurrentPlayer,Exactly,214,0,0xFF)})})

    DarkSkill = def_sIndex()
    NJumpX(FP,DarkSkill,{Command(P6,AtLeast,1,BossUID[2]),DeathsX(CurrentPlayer,Exactly,33,0,0xFF)})
    Crystal = def_sIndex()
    NJumpX(FP,Crystal,{DeathsX(CurrentPlayer,Exactly,128,0,0xFF)})


--    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,204,0,0xFF),{
--        SetMemory(0x6509B0,Add,55-25),
--        TSetMemoryX(CurrentPlayer,SetTo,0x104,0x104);
--        SetMemory(0x6509B0,Add,57),
--        TSetMemoryX(CurrentPlayer,SetTo,0,0xFF);
--    })

    
    CIfX(FP,{DeathsX(CurrentPlayer,AtLeast,184,0,0xFF),DeathsX(CurrentPlayer,AtMost,185,0,0xFF)},{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})

--    local HPJump = def_sIndex()
--    NJumpX(FP,HPJump,{CV(count,1450,AtLeast)})
--    DoActions(FP,{SetDeaths(CurrentPlayer,Subtract,256,0)})
--    NJumpXEnd(FP,HPJump)



    EXCC_BreakCalc({Deaths(CurrentPlayer,Exactly,0,0)},{SetMemory(0x6509B0,Add,17),SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00)})
        CAdd(FP,0x6509B0,38)--40
        CIf(FP,{DeathsX(CurrentPlayer,AtLeast,150*16777216,0,0xFF000000)})
            CDoActions(FP,{
                SetMemory(0x6509B0,Subtract,17),
                SetDeaths(CurrentPlayer,SetTo,0,0),
                SetMemory(0x6509B0,Subtract,4),
                SetDeathsX(CurrentPlayer,SetTo,6*256,0,0xFF00),
                SetMemory(0x6509B0,Subtract,15),
                TSetDeaths(CurrentPlayer,SetTo,EXCC_TempVarArr[1],0),
                SetMemory(0x6509B0,Add,2),
                TSetDeaths(CurrentPlayer,SetTo,EXCC_TempVarArr[1],0),
                SetMemory(0x6509B0,Add,16),
                TSetDeaths(CurrentPlayer,SetTo,EXCC_TempVarArr[1],0),
            })
        CIfEnd()
    CElseIfX({DeathsX(CurrentPlayer,Exactly,94,0,0xFF)},{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
    EXCC_BreakCalc({Deaths(CurrentPlayer,Exactly,0,0)},{
        MoveCp(Add,53*4); -- 55
        SetDeathsX(CurrentPlayer,SetTo,0x40000000,0,0x40000000);
        SetMemory(0x6509B0,Subtract,55-19),
        SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00)})

   
    
    CElseX({SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000)})
    CIfXEnd()

    
    EXCC_ClearCalc()
    NJumpXEnd(FP,Crystal)

    DoActions(FP,{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
    CIf(FP,{Deaths(CurrentPlayer,Exactly,0,0)},{SetMemory(0x6509B0,Add,17),SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00)})
    CSub(FP,0x6509B0,9)
    f_SaveCp()
    f_Read(FP,BackupCp,CPos)
    Convert_CPosXY()
    Simple_SetLocX(FP,0,_Sub(CPosX,11),_Sub(CPosY,11),_Add(CPosX,11),_Add(CPosY,11),{
        CreateUnit(1,191,1,P6),
        KillUnit(191,P6),KillUnitAt(All, "Men",1,Force1)
    })
    f_LoadCp()
    CAdd(FP,0x6509B0,9)
    CIfEnd()


    EXCC_ClearCalc()
    NJumpXEnd(FP,SkillUnit)

    DoActions(FP,{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
    CIf(FP,Deaths(CurrentPlayer,Exactly,0,0))
    CAdd(FP,0x6509B0,23)
    DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,84,0,0xFF),
    RemoveUnit(84,Force1);
    SetMemory(0x6509B0,Subtract,16),
    SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),
    SetMemory(0x6509B0,Add,16),})
    CSub(FP,0x6509B0,23)
    CIfEnd()

    
    EXCC_ClearCalc()
    NJumpXEnd(FP,DarkSkill)

    DoActions(FP,{SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),SetMemory(0x6509B0,Add,1),})
    f_SaveCp()
    CMov(FP,CPlayer,_ReadF(_Add(BackupCp,9)),nil,0xFF)
    CMov(FP,CPos,_ReadF(BackupCp))
    Convert_CPosXY()
    Simple_SetLocX(FP,0,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,49,1,P6)}) --
    CIf(FP,Memory(0x628438,AtLeast,1))
    f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
    CTrigger(FP,{},{TCreateUnit(1,214,1,CPlayer),TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF0000)},1)
    CIfEnd()
    f_LoadCp()

    EXCC_ClearCalc()
    NJumpXEnd(FP,HPRList)
    CSub(FP,0x6509B0,23)
    CIf(FP,{Deaths(CurrentPlayer,AtMost,4000000*256,0),Cond_EXCC(4,AtLeast,1)})
    CIfX(FP,Cond_EXCC(4,AtLeast,1000000))
    CDoActions(FP,{Set_EXCCX(4,Subtract,1000000),SetDeaths(CurrentPlayer,Add,1000000*256,0),Set_EXCC(4,Subtract,1000000)})
    CElseX()
    CDoActions(FP,{Set_EXCCX(4,SetTo,0),TSetDeaths(CurrentPlayer,Add,_Mul(EXCC_TempVarArr[5],256),0),Set_EXCC(4,SetTo,0)})
    CIfXEnd()
    CIfEnd()
    CTrigger(FP,CD(CurBID,64),{SetV(B2H,EXCC_TempVarArr[5])},1)
    CAdd(FP,0x6509B0,23)



    EXCC_ClearCalc()
    NJumpXEnd(FP,WhiteList)
    EXCC_BreakCalc({CD(Theorist,1)})
    
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
            flag = {preserved}
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
            flag = {preserved}
        }
        end

    CSub(FP,0x6509B0,17)

	CIfX(FP,{TDeaths(CurrentPlayer,AtMost,Vi(TempMarHPRead[2],-256),0)},{TSetDeaths(CurrentPlayer,Add,MarHPRegen,0)})
	CElseX({TSetDeaths(CurrentPlayer,SetTo,TempMarHPRead,0)})
	CIfXEnd()
	CAdd(FP,0x6509B0,17)

    
    NIf(FP,{Cond_EXCC(2,AtLeast,1)})
        CSub(FP,0x6509B0,17)
        CDoActions(FP,{TSetDeaths(CurrentPlayer,SetTo,TempMarHPRead,0)})
        CAdd(FP,0x6509B0,22)
        DoActions(FP,SetDeathsX(CurrentPlayer,SetTo,5000*256,0,0xFFFFFF))
        CSub(FP,0x6509B0,5)

        NIf(FP,{TTOR({
            Cond_EXCC(2,Exactly,50),
            Cond_EXCC(2,Exactly,100),
            Cond_EXCC(2,Exactly,150),
            Cond_EXCC(2,Exactly,200),
        })})
            CSub(FP,0x6509B0,9)
            f_SaveCp()
            f_Read(FP,BackupCp,CPos)
            Convert_CPosXY()
            Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{CreateUnitWithProperties(1,95,1,FP,{hallucinated = true}),KillUnit(95,FP)})
            f_LoadCp()
            CAdd(FP,0x6509B0,9)
        NIfEnd()
    NIfEnd()

    
	CIf(FP,{CV(Level,40,AtLeast),Cond_EXCC(3,AtMost,0)})
        MarSkill = def_sIndex()
        CJump(FP,MarSkill)
        CallMarSkill = SetCallForward()
        SetCall(FP)
        f_SaveCp()

        CIfX(FP,{TMemoryX(_Add(BackupCp,50),AtLeast,1*256,0xFF00)})
        CDoActions(FP,{Set_EXCCX(3,SetTo,15)})
        CElseX()
        CDoActions(FP,{Set_EXCCX(3,SetTo,25)})
        CIfXEnd()

        f_Read(FP,_Sub(BackupCp,9),CPos)
        CMov(FP,CPlayer,_Read(BackupCp),nil,0xFF)
        Convert_CPosXY()
        Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
--        MarSkillCA = CAPlotForward()
--        CMov(FP,V(MarSkillCA[6]),1)
--        CMov(FP,V(MarSkillCA[5]),5)
        for i = 0, 3 do
        --TriggerX(FP,{HumanCheck(i,1)},{SetCVar(FP,MarSkillCA[5],Subtract,1)},{preserved})
        end
        function MarListSkillUnitFunc()
            CIf(FP,Memory(0x628438,AtLeast,1))
            f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
            CDoActions(FP,{
                TCreateUnit(1,183,1,CPlayer),
                TSetDeathsX(_Add(Nextptrs,19),SetTo,152*256,0,0xFF00),
                TSetDeathsX(_Add(Nextptrs,9),SetTo,0*65536,0,0xFF0000),
                TSetDeaths(_Add(Nextptrs,22),SetTo,2048+(2048*65536),0),
            })
            CIfEnd()
        end
        MarListSkillUnitFunc()
            --CAPlot({CSMakePolygon(4,128,45,5,1)},FP,181,0,nil,1,1,{1,0,0,0,6,0},nil,FP,nil,nil,1,"MarListSkillUnitFunc")
        


        f_LoadCp()
        SetCallEnd()
        CJumpEnd(FP,MarSkill)

		CIf(FP,DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00))
			CallTrigger(FP,CallMarSkill)
		CIfEnd()
		CIf(FP,DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00))
			CAdd(FP,0x6509B0,4)
			CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
				CSub(FP,0x6509B0,4)
				CallTrigger(FP,CallMarSkill)
				CAdd(FP,0x6509B0,4)
			CIfEnd()
			CSub(FP,0x6509B0,4)
		CIfEnd()
		CIf(FP,DeathsX(CurrentPlayer,Exactly,5*256,0,0xFF00))
			CAdd(FP,0x6509B0,4)
			CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
				CSub(FP,0x6509B0,4)
				CallTrigger(FP,CallMarSkill)
				CAdd(FP,0x6509B0,4)
			CIfEnd()
			CSub(FP,0x6509B0,4)
		CIfEnd()
        
	CIfEnd()



    EXCC_ClearCalc()
    EXCC_Part2()
    EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
            DeathsX(19025+(84*i)+9,AtMost,0,0,0xFF0000),
            DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,25*4),
        SetCVar(FP,CurCunitI2[2],SetTo,i),--SetResources(P1,Add,1,Gas)
		})
	end
	EXCC_End()




    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF)})
    DoActions(FP,MoveCp(Add,6*4))
    
    WhiteList2 = def_sIndex()
    for j, i in pairs(MarID) do
        NJumpX(FP,WhiteList2,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF),CD(Theorist,0)})
    end

    ReviveSkill = def_sIndex()
    CJump(FP,ReviveSkill)
    NJumpXEnd(FP,WhiteList2)
    DoActions(FP,MoveCp(Subtract,6*4))
    CAdd(FP,0x6509B0,21)
    CIf(FP,{CV(Level,50,AtLeast)})
    f_SaveCp()
    NIfX(FP,{Cond_EXCC2(UnivCunit,CurCunitI2,1,Exactly,0)})
        CMov(FP,CPlayer,_Read(_Sub(BackupCp,21)),nil,0xFF)
        CCMU_Check = def_sIndex()
        NJump(FP,CCMU_Check,{Memory(0x628438,AtMost,0)},{TSetMemory(0x6509B0,SetTo,CPlayer),
            PlayWAV("staredit\\wav\\revive.ogg"),
            DisplayText(StrDesign("\x08ERROR : \x04변수(Nextptrs)를 찾을 수 없습니다. \x07소생 \x04위치를 본진으로 설정합니다."),4),
            SetMemory(0x6509B0,SetTo,FP),
            TSetDeaths(CPlayer,Add,1,178)
        })

        f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CSub(FP,CurCunitI,Nextptrs,19025)
			f_Div(FP,CurCunitI,_Mov(84))
        CDoActions(FP,{
            Set_EXCC2(UnivCunit,CurCunitI2,1,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI2,2,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI,0,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI,1,SetTo,600*24),
            Set_EXCC2(UnivCunit,CurCunitI,2,SetTo,30*24),
            Set_EXCC2(UnivCunit,CurCunitI,3,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI,4,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI,5,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI,6,SetTo,0),
        })
        CSub(FP,BackupCp,30)
        f_Read(FP,BackupCp,CPos)
        CAdd(FP,BackupCp,30)
        Convert_CPosXY()
        --TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPRecover},{preserved})
        Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
            for i = 0, 3 do
                TriggerX(FP,{CV(CPlayer,i)},{
                CreateUnitWithProperties(1,MarID[i+1],1,i,{energy = 100}),
                SetMemory(0x6509B0,SetTo,i),
                PlayWAV("staredit\\wav\\revive.ogg"),
                DisplayText(StrDesign("\x16빛\x04을 잃은 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ이 \x16빛\x04의 \x03축복\x04을 받아 \x07소생하였습니다. \x1B(재사용 대기시간 : 10분)"),4),
                SetMemory(0x6509B0,SetTo,FP),
                --RunAIScriptAt("Recall Here",24)
            },{preserved})
                TriggerX(FP,{CV(CPlayer,i),Command(P6,AtMost,0,BossUID[2])},{
                SetMemoryB(0x665C48+380,SetTo,0);
                SetMemoryX(0x666458, SetTo, 391,0xFFFF),
                CreateUnitWithProperties(1,33,1,FP,{energy = 100}),
                RemoveUnit(33,FP),
                SetMemoryB(0x665C48+380,SetTo,1);
                SetMemoryX(0x666458, SetTo, 546,0xFFFF),
                },{preserved})
            end
            f_Read(FP,_Add(Nextptrs,0x28/4),TempTarget)
        CIf(FP,{TMemoryX(_Add(Nextptrs,19),Exactly,2*256,0xFF00),TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
        CDoActions(FP,{
            TSetMemory(_Add(Nextptrs,0x5C/4),SetTo,0),
            TSetMemory(_Add(Nextptrs,0x18/4),SetTo,TempTarget),
            TSetMemory(_Add(Nextptrs,0x58/4),SetTo,TempTarget),
            TSetMemory(_Add(Nextptrs,0x10/4),SetTo,TempTarget),
            TSetMemoryX(_Add(Nextptrs,19),SetTo,107*256,0xFF00),
        })
        CIfEnd()
        --TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPPatch},{preserved})
        --CMov(FP,BackupCp,Nextptrs,40)
        NJumpEnd(FP,CCMU_Check)
        CDoActions(FP,{
            Set_EXCC2(UnivCunit,CurCunitI2,1,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI2,2,SetTo,0),
        })
        EXCC_ClearCalc()
        NElseX()
        CDoActions(FP,{
            Set_EXCC2(UnivCunit,CurCunitI2,1,SetTo,0),
            Set_EXCC2(UnivCunit,CurCunitI2,2,SetTo,0),
        })

    NIfXEnd()
    f_LoadCp()
    CIfEnd()
    CSub(FP,0x6509B0,21)
    DoActions(FP,MoveCp(Add,6*4))

	
    CJumpEnd(FP,ReviveSkill)

    Install_DeathNotice()



    EXCC_ClearCalc()
    NJumpEnd(FP,Check_Enemy)
    DoActions(FP,MoveCp(Add,6*4))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,35,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,204,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,33,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,84,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,42,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,191,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,128,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,205,0,0xFF))

    CIf(FP,DeathsX(CurrentPlayer,Exactly,156,0,0xFF)) -- 파일런 인식
        f_SaveCp()
        f_Read(FP,_Sub(BackupCp,15),CPos)
        Convert_CPosXY()
        Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,CreateScanEff(981))
        DoActions2(FP,{RotatePlayer({MinimapPing(1),
        PlayWAVX("staredit\\wav\\Eff1.ogg"),
        PlayWAVX("staredit\\wav\\Eff1.ogg"),
        PlayWAVX("sound\\glue\\bnetclick.wav"),
        PlayWAVX("sound\\glue\\bnetclick.wav")},HumanPlayers,FP)})
        CMov(FP,CPlayer,_Read(_Sub(BackupCp,6)),nil,0xFF)
        for i = 4, 7 do
            TriggerX(FP,{CV(CPlayer,i)},{AddCD(PyCCode[i-3],1)},{preserved})
        end
        
        f_LoadCp()
    CIfEnd()



	CallTriggerX(FP,MakeEisEgg,{Command(FP,AtLeast,1,190),Cond_EXCC(13,Exactly,1,1)})
    CIf(FP,{Cond_EXCC(1,Exactly,1),Command(FP,AtLeast,1,190)}) -- 영작유닛인식
    f_SaveCp()
    InstallHeroPoint()
    CIfEnd()
    CIf(FP,{DeathsX(CurrentPlayer,Exactly,185,0,0xFF)}) -- 건작유닛인식
        f_SaveCp()
        f_Read(FP,_Sub(BackupCp,15),BCPos)
        CMov(FP,CPlayer,_Read(_Sub(BackupCp,6)),nil,0xFF)
        Simple_SetLocX(FP,9,EXCC_TempVarArr[6],EXCC_TempVarArr[7],EXCC_TempVarArr[6],EXCC_TempVarArr[7])

        for i = 7, 11 do
        CWhile(FP,{Cond_EXCC(i,AtLeast,1)})
            CIf(FP,Memory(0x628438,AtLeast,1))
                f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
                Convert_CPosXY(BCPos)
                Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
                for j = 0, 3 do
                CTrigger(FP,{CVar(FP,CPlayer[2],Exactly,j+4,0xFF)},{TCreateUnitWithProperties(1,_Mov(EXCC_TempVarArr[i+1],0xFF),22+j,CPlayer,{energy = 100}),TMoveUnit(1,_Mov(EXCC_TempVarArr[i+1],0xFF),_Mov(CPlayer,0xFF),22+j,1)},1)
                end
                CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
                    f_Read(FP,_Add(Nextptrs,10),CPos)
                    Convert_CPosXY()
                    Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
                    DoActions2(FP,{Order("Men",Force2,1,Attack,10),Simple_CalcLoc(0,-64,-64,64,64)})
                    CTrigger(FP,{Cond_EXCC(12,Exactly,1,1)},{TSetMemory(_Add(Nextptrs,13),SetTo,64)},1)
                    --CTrigger(FP,{Cond_EXCC(12,Exactly,4,4)},{TSetMemory(0x6509B0,SetTo,_Mov(CPlayer,0xFF)),RunAIScriptAt(JYD,1)},1)
                CIfEnd()
            CIfEnd()
            CDoActions(FP,{Set_EXCC(i,SetTo,_Div(EXCC_TempVarArr[i+1],256))})
        CWhileEnd()
        end
        for i = 0, 3 do
            DoActions(FP,Order("Men",4+i,22+i,Attack,2+i))
        end

        f_LoadCp()
    CIfEnd()
--    CMov(FP,Gun_Type,0)
    for j, k in pairs(f_GunTable) do
    f_GSend(k)
    end
    
    
    --그외 잡건작
    --{잡건작 번호,{유닛테이블},{도형스트링정보},{이펙트번호}}
    OtherGunT = {
        

        {135,{{53},{103}},{"Star1","Circle1"},{982,366}},--히드라덴
        {136,{{46},{54,50}},{"L00_1_128F","L00_1_64F"},{984,365}},--디파마운드
        {137,{{56,62}},{"H00_1_82F"},{366}},--그레이터스파이어
        {138,{{45},{40,51,104}},{"H00_1_128F","QNest"},{984,366}},--퀸네스트
        {139,{{53},{15}},{"EChamb","H00_1_96F"},{366,367}},--에볼루션챔버
        {140,{{48}},{"H00_1_64L"},{365}},--울트라
        {141,{{55}},{"H00_1_82F"},{366}},--스파이어
        {142,{{54}},{"Circle2"},{982}},--스포닝풀

    }
    OtherG = def_sIndex()
    for j, k in pairs(OtherGunT) do
        NJumpX(FP,OtherG,DeathsX(CurrentPlayer,Exactly,k[1],0,0xFF))
    end
    if TestStart == 1 then
        --f_GSend(146)
        --f_GSend(136)
    end

    C_UID = CreateVar(FP)

    EXCC_ClearCalc(AddV(CurEXP,1))
    NJumpXEnd(FP,OtherG)
    f_SaveCp()
    f_Read(FP,_Sub(BackupCp,15),CPos)
    f_Read(FP,BackupCp,C_UID)
    f_Read(FP,_Sub(BackupCp,6),G_CA_Player)
    Convert_CPosXY()
	CMov(FP,G_CA_CenterX,CPosX)
	CMov(FP,G_CA_CenterY,CPosY)
    for j, k in pairs(OtherGunT) do
        for l,m in pairs(k[2]) do
            G_CA_SetSpawn2X(CVar(FP,C_UID[2],Exactly,k[1],0xFF),m,"ACAS",k[3][l],1,k[4][l],nil,"CP")
        end
    end
    f_LoadCp()



    EXCC_ClearCalc()
    EXCC_Part2()
    EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
		DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
		DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
		},
		{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
        SetDeathsX(19025+(84*i)+9,SetTo,0*65536,0,0xFF0000),
		MoveCp(Add,19*4),
        SetCVar(FP,CurCunitI2[2],SetTo,i)
		})
	end
	EXCC_End()
    
    
    
    
    SETimer = CreateCcode()
    TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,100,SETimer)},{preserved})

    function SwarmSet(LVTable,CUTable)
        local LvLeast
        local LVMost
        if type(LVTable)=="table" then
            LvLeast = LVTable[1]
            LVMost = LVTable[2]
        else
            PushErrorMsg("LVTable_TypeError")
        end
        if type(CUTable)=="table" then
            for j, k in pairs(CUTable) do
                --f_TempRepeat({CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost)},k[1],k[2],1,Player)--
                CTrigger(FP,{CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost)},{TCreateUnit(k[2],k[1],1,f_CRandNum(4,4))},1)

            end
        else
            PushErrorMsg("CUTable_TypeError")
        end
        
    end
    CIf(FP,{Bring(AllPlayers,AtLeast,1,"Dark Swarm",64)},{Simple_SetLoc(0,0,0,0,0),MoveLocation(1,"Dark Swarm",AllPlayers,"Anywhere"),RemoveUnitAt(1,"Dark Swarm",1,AllPlayers),CreateUnit(1,84,1,FP),KillUnit(84,FP)}) -- 다크스웜 트리거

    SwarmSet({0,9},{{53,5},{54,5}})
    SwarmSet({10,19},{{48,3},{53,3},{55,4}})
    SwarmSet({20,24},{{55,4},{48,2},{54,2},{53,2},{88,1},{21,1}})
    SwarmSet({25,50},{{56,4},{51,2},{104,2},{48,2},{53,2},{54,2},{88,2},{21,2}})
    
    CIfEnd()
    Install_GunStack()
    CIf(FP,CVar(FP,count[2],AtMost,GunLimit))
        Create_G_CA_Arr()
    CIfEnd()
    WarpXY = {
    {1632,1824},
    {-1632+4096,1824},
    {1632,-1824+4096},
    {-1632+4096,-1824+4096}}
    local WaveT = CreateCcode()
    function WaveSet(LVTable,CUTable)
        local LvLeast
        local LVMost
        if type(LVTable)=="table" then
            LvLeast = LVTable[1]
            LVMost = LVTable[2]
        else
            PushErrorMsg("LVTable_TypeError")
        end
        if type(CUTable)=="table" then
            for j, k in pairs(CUTable) do
                for i = 0, 3 do
                    f_TempRepeat({CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost),HumanCheck(i,1),Command(i+4,AtLeast,1,189)},k[1],k[2],1,i+4,{WarpXY[i+1][1],WarpXY[i+1][2]})--
                end
            end
        else
            PushErrorMsg("CUTable_TypeError")
        end
        
    end
    CIf(FP,{CV(Time1,(60*30)*1000,AtMost),CD(WaveT,1800,AtLeast)},SetCD(WaveT,0))
        WaveSet({0,9},{{53,15},{54,20}})
        WaveSet({10,19},{{48,8},{53,10},{55,10}})
        WaveSet({20,24},{{55,10},{48,8},{54,7},{53,6}})
        WaveSet({25,50},{{56,15},{51,5},{104,5},{48,5},{53,5},{54,5}})
    CIfEnd(AddCD(WaveT,1))
CMov(FP,0x6509B0,FP)
for i = 0, 3 do
TriggerX(FP,{CD(PyCCode[i+1],1)},{
    ModifyUnitHitPoints(All,146,i+4,64,70);
    ModifyUnitHitPoints(All,144,i+4,64,70);
    ModifyUnitHitPoints(All,143,i+4,64,70);})
TriggerX(FP,{CD(PyCCode[i+1],2)},{
    ModifyUnitHitPoints(All,146,i+4,64,20);
    ModifyUnitHitPoints(All,144,i+4,64,20);
    ModifyUnitHitPoints(All,143,i+4,64,20);})
TriggerX(FP,{CD(PyCCode[i+1],3)},{
    KillUnit(146,i+4);
    KillUnit(144,i+4);
    KillUnit(143,i+4);})
end

    --
GunSPStr = {
"\x11좌측 9시 ",
"\x18우측 3시 ",
"\x16중앙 9시 ",
"\x17중앙 3시 ",
}
GunPStr = {
"\x11좌측 상단 ",
"\x18우측 상단 ",
"\x16좌측 하단 ",
"\x17우측 하단 ",
}
CellPStr = {
"\x11중앙 좌측 ",
"\x18중앙 하단 ",
"\x16중앙 우측 ",
"\x17중앙 상단 ",
}


for i = 4, 7 do
    InvDisable(154,i,{CD(PyCCode[i-3],3,AtLeast)},GunPStr[i-3].."\x04지역 \x10"..Conv_HStr("<19>F<1D>elis").." \x04의 \x02무적상태\x04가 해제되었습니다.")
    InvDisable(147,i,{CD(CereCond[i-3],2,AtLeast)},GunPStr[i-3].."\x04지역 \x10"..Conv_HStr("<1D>the <19>H<1D>eaven").." \x04의 \x02무적상태\x04가 해제되었습니다.")
    --InvDisable(168,i,{CD(HiveCcode[i-3],0,AtMost)},CellPStr[i-3].."\x04지역 \x10"..Conv_HStr("<19>R<1D>esonance").." \x04의 \x02무적상태\x04가 해제되었습니다.")

    
    InvDisable(189,i,{CD(HactCcode[i-3],0,AtMost),CD(LairCcode[i-3],0,AtMost),CD(HiveCcode[i-3],0,AtMost),CD(CenCcode2[i-3],1,AtLeast)},GunPStr[i-3].."\x04지역 \x10"..Conv_HStr("<19>W<1D>arp <19>T<1D>unnel").." \x04의 \x02무적상태\x04가 해제되었습니다.")
end
for i = 4, 5 do
    InvDisable(201,i,{CD(IonCcode[i-3],1,AtLeast),CD(NoradCcode[i-3],1,AtLeast)},GunSPStr[i-3].."\x04지역 \x10"..Conv_HStr("<19>O<1D>blivion").." \x04의 \x02무적상태\x04가 해제되었습니다.")
end
for i = 6, 7 do
    InvDisable(152,i,{CD(IonCcode[i-3],1,AtLeast),CD(NoradCcode[i-3],1,AtLeast)},GunSPStr[i-3].."\x04지역 \x10"..Conv_HStr("<19>N<1D>ightmare").." \x04의 \x02무적상태\x04가 해제되었습니다.")
end
InvDisable(190,FP,{
    Deaths(4,AtLeast,1,BossUID[1]),
    Deaths(5,AtLeast,1,BossUID[2]),
    Deaths(6,AtLeast,1,BossUID[3]),
    Deaths(7,AtLeast,1,BossUID[4]),
    CD(NexCcode,4,AtLeast);
    CD(TempleCcode,4,AtLeast);
    CD(OvCcode,4,AtLeast);
    CD(OvGCcode,4,AtLeast);
    CD(CellCcode,4,AtLeast);
    CD(XelCcode,4,AtLeast);
    CD(CenCcode,4,AtLeast);
    CD(OcCcode,2,AtLeast);
    CD(DgCcode,2,AtLeast); 
    CD(GeneCcode,2,AtLeast);
},"\x17중앙 \x10"..Conv_HStr("<08>C<1D>Ore <1C>of <08>D<1D>epth").." \x04의 \x02무적상태\x04가 해제되었습니다.")

CanText = "\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n"..StrDesignX("\x04맵상의 유닛이 \x08１５００\x04기 이상 있습니다.").."\n"..StrDesignX("\x08캔낫\x04이 \x074회 이상\x04 걸릴 경우 \x10게임\x04에서 \x06패배\x04합니다.\x04").."\n\n\x14\n\x0D\x0D\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x0D\x0D\x13\x04"

Trigger { -- 캔낫 경고
	players = {FP},
	conditions = {
		Label(0);
        Command(FP,AtLeast,1,173);
        CDeaths(FP,AtMost,0,CanCT);
		CDeaths(FP,Exactly,0,CanWT);
        CVar(FP,count[2],AtLeast,1500);
},
	actions = {
		RotatePlayer({
			DisplayTextX(CanText,4),
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV"),
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV")
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,24*10,CanWT);
		PreserveTrigger();
		
		},
	}



Trigger2X(FP,{--캔발동
Command(FP,AtLeast,1,173);
    CV(CanC,2,AtMost);
    CDeaths(FP,AtMost,0,CanCT);
    CVar(FP,count[2],AtLeast,1500);
    Memory(0x628438,AtMost,0);
},{
    RotatePlayer({
        PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
        PlayWAVX("staredit\\wav\\warn.wav"),
        PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
        PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
        },HumanPlayers,FP);
		SetCDeaths(FP,SetTo,24*30,CanCT);
		AddV(CanC,1);
		KillUnit("Factories",Force2);
},{preserved})

Trigger2X(FP,{--캔발동
Command(FP,AtLeast,1,173);
    CV(CanC,3,AtLeast);
    CDeaths(FP,AtMost,0,CanCT);
    CVar(FP,count[2],AtLeast,1500);
    Memory(0x628438,AtMost,0);
},{
    RotatePlayer({
        PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
        PlayWAVX("staredit\\wav\\CanOver.ogg"),
        PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
        PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
        },HumanPlayers,FP);
		SetCDeaths(FP,SetTo,24*30,CanCT);
		AddV(CanC,1);
		KillUnit("Factories",Force2);
		SetCDeaths(FP,Add,1,DefeatCC);
},{preserved})

DoActions2X(FP,{SubCD(CanWT,1),SubCD(CanCT,1)})
CIf(FP,CD(DefeatCC,1,AtLeast))
DoActionsX(FP,{AddCD(DefeatCC,1)})
DoActions2(FP,{RotatePlayer({
    DisplayTextX(string.rep("\n", 20),4);
    DisplayTextX("\x13\x04"..string.rep("―", 56),4);
    DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x15모든 플레이어가 빛을 잃었습니다.\n",4);
    DisplayTextX("\x13\x05게임에서 패배하였습니다.",4);
    DisplayTextX("\n",4);
    DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
    DisplayTextX("\x13\x04"..string.rep("―", 56),4);
    PlayWAVX("staredit\\wav\\Game_Over.ogg");
    PlayWAVX("staredit\\wav\\Game_Over.ogg");
    PlayWAVX("staredit\\wav\\Game_Over.ogg");},HumanPlayers,FP)},1)

	

TriggerX(FP,{CD(TestMode,0),CD(DefeatCC,100,AtLeast)},{RotatePlayer({Defeat()},MapPlayers,FP)})
CIfEnd()
TTShape1 = {{416, 1984},{352, 1952},{288, 1920},{224, 1888},{160, 1856},{96, 1824},{32, 1792}}
TTShape3 = {{416, 2144},{352, 2176},{288, 2208},{224, 2240},{160, 2272},{96, 2304},{32, 2336}}
TTShape2 = {{4064, 1792},{4000, 1824},{3936, 1856},{3872, 1888},{3808, 1920},{3744, 1952},{3680, 1984}}
TTShape4 = {{4064, 2336},{4000, 2304},{3936, 2272},{3872, 2240},{3808, 2208},{3744, 2176},{3680, 2144}}
TTCond1 = CreateCcode()
TTAct1 = CreateCcode()
TTCond2 = CreateCcode()
TTAct2 = CreateCcode()
CIf(FP,{CD(TTEndC1,3,AtMost)})
for j, k in pairs(TTShape1) do
    DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond1,1)})
    TriggerX(FP,{
        CD(TTAct1,0),
        Loc(9,0,Exactly,k[1]),
        Loc(9,4,Exactly,k[2]),
    },{SetCD(TTCond1,0)
    },{preserved})
    TriggerX(FP,{CD(TTCond1,1),CD(TTAct1,0)},{SetCD(TTAct1,1),GiveUnits(All,68,P12,11,P5),GiveUnits(All,68,P12,13,P7),SetInvincibility(Disable,68,P5,64),SetInvincibility(Disable,68,P7,64),Order(68,P5,64,Attack,30),Order(68,P7,64,Attack,30)})
    TriggerX(FP,{CD(TTAct1,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32+64,k[1]+32,k[2]+32+64),Order("Men",Force1,1,Move,10)},{preserved})
end
for j, k in pairs(TTShape3) do
    DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond1,1)})
    TriggerX(FP,{
        CD(TTAct1,0),
        Loc(9,0,Exactly,k[1]),
        Loc(9,4,Exactly,k[2]),
    },{SetCD(TTCond1,0)
    },{preserved})
    TriggerX(FP,{CD(TTCond1,1),CD(TTAct1,0)},{SetCD(TTAct1,1),GiveUnits(All,68,P12,11,P5),GiveUnits(All,68,P12,13,P7),SetInvincibility(Disable,68,P5,64),SetInvincibility(Disable,68,P7,64),Order(68,P5,64,Attack,30),Order(68,P7,64,Attack,30)})
    TriggerX(FP,{CD(TTAct1,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32-64,k[1]+32,k[2]+32-64),Order("Men",Force1,1,Move,10)},{preserved})
end
CIfEnd()


CIf(FP,{CD(TTEndC2,3,AtMost)})
for j, k in pairs(TTShape2) do
    DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond2,1)})
    TriggerX(FP,{
        CD(TTAct2,0),
        Loc(9,0,Exactly,k[1]),
        Loc(9,4,Exactly,k[2]),
    },{SetCD(TTCond2,0)
    },{preserved})
    TriggerX(FP,{CD(TTCond2,1),CD(TTAct2,0)},{SetCD(TTAct2,1),GiveUnits(All,68,P12,12,P6),GiveUnits(All,68,P12,14,P8),SetInvincibility(Disable,68,P6,64),SetInvincibility(Disable,68,P8,64),Order(68,P6,64,Attack,31),Order(68,P8,64,Attack,31)})
    TriggerX(FP,{CD(TTAct2,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32+64,k[1]+32,k[2]+32+64),Order("Men",Force1,1,Move,10)},{preserved})
end
for j, k in pairs(TTShape4) do
    DoActions2X(FP,{Simple_SetLoc(0,k[1]-32,k[2]-32,k[1]+32,k[2]+32),Simple_SetLoc(9,0,0,0,0),MoveLocation(10,"Men",Force1,1),SetCD(TTCond2,1)})
    TriggerX(FP,{
        CD(TTAct2,0),
        Loc(9,0,Exactly,k[1]),
        Loc(9,4,Exactly,k[2]),
    },{SetCD(TTCond2,0)
    },{preserved})
    TriggerX(FP,{CD(TTCond2,1),CD(TTAct2,0)},{SetCD(TTAct2,1),GiveUnits(All,68,P12,12,P6),GiveUnits(All,68,P12,14,P8),SetInvincibility(Disable,68,P6,64),SetInvincibility(Disable,68,P8,64),Order(68,P6,64,Attack,31),Order(68,P8,64,Attack,31)})
    TriggerX(FP,{CD(TTAct2,1)},{Simple_SetLoc(9,k[1]-32,k[2]-32-64,k[1]+32,k[2]+32-64),Order("Men",Force1,1,Move,10)},{preserved})
end
CIfEnd()

for j = 4, 7 do
Trigger2X(FP,{Deaths(j,AtLeast,1,BossUID[j-3])},{SetScore(Force1,Add,500000,Kills),RotatePlayer({PlayWAVX("staredit\\wav\\E_Clear.ogg"),PlayWAVX("staredit\\wav\\E_Clear.ogg"),PlayWAVX("staredit\\wav\\E_Clear.ogg"),PlayWAVX("staredit\\wav\\E_Clear.ogg"),DisplayTextX("\n\n\n\x0D\x0D\x13\x04\n\x0D\x0D\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x14\x14\n\x0D\x0D!H\x13\x04\x07기억\x04의 수호자 \x10【 "..HName[j-3].."\x10 】 \x04를 처치하였습니다.\n\x0D\x0D!H\x13\x04+ \x1F５００，０００ Ｐｔｓ\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x0D\x0D\x13\x04\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14",4)},HumanPlayers,FP)})
end
T_X,T_Y = CreateVars(2,FP)
TargetRotation = CreateVar(FP)
WBreak=CreateCcode()
for i = 0, 3 do
    DoActionsX(FP,{SetCD(WBreak,100)})
    CWhile(FP,{HumanCheck(i,0),Bring(i+4,AtLeast,1,"Men",36+i),CD(WBreak,1,AtLeast)},SubCD(WBreak,1))
    f_Lengthdir(FP,f_CRandNum(384,320),_Mod(_Rand(),360),T_X,T_Y)
    f_Div(FP,T_Y,2)
    Simple_SetLocX(FP,9,T_X,T_Y,T_X,T_Y,{Simple_CalcLoc(9,2048,2048,2048,2048)})
    DoActions(FP,{MoveUnit(1,"Men",i+4,36+i,10)})
--    NJumpXEnd(FP,L_Gun_Move)
--    CMov(FP,TargetRotation,f_CRandNum(4))
--    
--	for i = 0, 3 do
--		CIf(FP,{CVar(FP,TargetRotation[2],Exactly,i),HumanCheck(i,0)})
--		DoActions(FP,{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
--		TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,0)},{preserved})
--		TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetV(TargetRotation,1)},{preserved})
--		TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetV(TargetRotation,2)},{preserved})
--		TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetV(TargetRotation,3)},{preserved})
--		CIfEnd()
--	end
--    for j = 0, 3 do
--    NJumpX(FP,L_Gun_Move,{CVar(FP,TargetRotation[2],Exactly,j),HumanCheck(j,0)}) -- 타겟 설정 시 플레이어가 없을 경우 다시 연산함
--    end
--	for i = 0, 3 do
--        TriggerX(FP,{CV(TargetRotation,i)},{Order("Men")},{preserved})
--    end


    CWhileEnd()
end

CIfOnce(FP,CD(Theorist,1))
TheoristPatchArr = {}
for i = 1, 4 do
		table.insert(TheoristPatchArr,SetMemoryW(0x656EB0 + (0*2),SetTo,NMAtk*2)) -- 기본공격력
		table.insert(TheoristPatchArr,SetMemoryW(0x657678 + (0*2),SetTo,NMAtkFactor*2)) -- 추가공격력
		table.insert(TheoristPatchArr,SetMemoryW(0x656EB0 + (1*2),SetTo,HMAtk*2)) -- 기본공격력
		table.insert(TheoristPatchArr,SetMemoryW(0x657678 + (1*2),SetTo,HMAtkFactor*2)) -- 추가공격력
        table.insert(TheoristPatchArr,SetMemoryW(0x656EB0 + (MarWep[i]*2),SetTo,MarAtk*2)) -- 기본공격력
        table.insert(TheoristPatchArr,SetMemoryW(0x657678 + (MarWep[i]*2),SetTo,MarAtkFactor*2)) -- 추가공격력
end

DoActions2X(FP,{
RemoveUnit(203,AllPlayers),
SetMemoryW(0x656EB0+(0*2),Add,15);
SetMemoryW(0x657678+(0*2),Add,1);
SetMemoryW(0x656EB0+(1*2),Add,50);
SetMemoryW(0x657678+(1*2),Add,3);TheoristPatchArr,
SetV(Level,50),
SetV(AtkCondTmp,250),
SetV(HPCondTmp,250),
})
TheoristTxt = "\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04\n\x0D\x0D\x13\x04！！！　\x08ＭＯＤＥ　ＥＮＡＢＬＥ\x04　！！！\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x10理論値 \x04MODE\x04 가 \x03활성화\x04되었습니다.\n\x0D\x0D\x13\x07Level\x04과 \x17미사일 트랩\x04이 삭제되고 \x1B일부 기능\x04이 다수 \x10제한\x04되며, \x08공격력 2배\x04가 적용됩니다.\n\x0D\x0D\n\x0D\x0D\n\x0D\x0D\x13\x04！！！　\x08ＭＯＤＥ　ＥＮＡＢＬＥ\x04　！！！\n\x0D\x0D\x13\x04"
DoActions2(FP,{RotatePlayer({DisplayTextX(TheoristTxt,4),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg"),PlayWAVX("staredit\\wav\\SkillUnlock.ogg")},HumanPlayers,FP)})
	


CIfEnd()


CallTriggerX(FP,Call_CunitRefrash,{CD(CUnitRefrash,1,AtLeast)},{SetCD(CUnitRefrash,0)})

end