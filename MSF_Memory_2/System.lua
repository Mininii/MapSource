function System()
    local CPlayer = CreateVar(FP)
    local BCPos = CreateVar(FP)
	local CurCunitI = CreateVar(FP)
	local CurCunitI2 = CreateVar(FP)

    local TempTarget = CreateVar(FP)
	Cast_UnitCount()
    AddBGM(1,"staredit\\wav\\BYD_OP.ogg",152*1000)
    AddBGM(2,"staredit\\wav\\story.ogg",81*1000)
    AddBGM(3,"staredit\\wav\\GBGM1.ogg",126*1000)
    AddBGM(4,"staredit\\wav\\GBGM2.ogg",128*1000)
    AddBGM(5,"staredit\\wav\\GBGM3.ogg",164*1000)
    Install_BGMSystem(FP,3,BGMType,12)

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

    for i = 0, 3 do
        CIf(FP,{PlayerCheck(i,1),Deaths(i,Exactly,0,12),Deaths(i,Exactly,0,14)})
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


    
    local TempMarHPRead = CreateVar(FP)
    EXCC_Part1(UnivCunit) -- 기타 구조오프셋 단락 시작
    WhiteList = def_sIndex()
    for j, i in pairs(MarID) do
        NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
    end
    SkillUnit = def_sIndex()
    NJump(FP,SkillUnit,DeathsX(CurrentPlayer,Exactly,183,0,0xFF))



    
    CIfX(FP,{DeathsX(CurrentPlayer,AtLeast,184,0,0xFF),DeathsX(CurrentPlayer,AtMost,185,0,0xFF)},{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})

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
    CElseX({SetMemory(0x6509B0,Subtract,16),SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000)})
    CIfXEnd()
    EXCC_ClearCalc()
    NJumpEnd(FP,SkillUnit)

    DoActions(FP,{SetMemory(0x6509B0,Subtract,23),SetDeaths(CurrentPlayer,Subtract,256,0)})
    CIf(FP,Deaths(CurrentPlayer,Exactly,0,0))
    CAdd(FP,0x6509B0,23)
    DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,84,0,0xFF),
    SetMemory(0x6509B0,Subtract,16),
    SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),
    SetMemory(0x6509B0,Add,16),})
    CSub(FP,0x6509B0,23)
    CIfEnd()

    
    EXCC_ClearCalc()
    NJumpXEnd(FP,WhiteList)

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
        CDoActions(FP,{Set_EXCCX(3,SetTo,35)})
        CElseX()
        CDoActions(FP,{Set_EXCCX(3,SetTo,55)})
        CIfXEnd()

        f_Read(FP,_Sub(BackupCp,9),CPos)
        CMov(FP,CPlayer,_Read(BackupCp),nil,0xFF)
        Convert_CPosXY()
        Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
--        MarSkillCA = CAPlotForward()
--        CMov(FP,V(MarSkillCA[6]),1)
--        CMov(FP,V(MarSkillCA[5]),5)
        for i = 0, 3 do
        --TriggerX(FP,{PlayerCheck(i,1)},{SetCVar(FP,MarSkillCA[5],Subtract,1)},{Preserved})
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
        SetCVar(FP,CurCunitI2[2],SetTo,i)
		})
	end
	EXCC_End()




    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF)})
    DoActions(FP,MoveCp(Add,6*4))
    
    WhiteList2 = def_sIndex()
    for j, i in pairs(MarID) do
        NJumpX(FP,WhiteList2,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
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
        --TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPRecover},{Preserved})
        Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
            for i = 0, 3 do
                TriggerX(FP,{CV(CPlayer,i)},{
                CreateUnitWithProperties(1,MarID[i+1],1,i,{energy = 1}),
                SetMemory(0x6509B0,SetTo,i),
                PlayWAV("staredit\\wav\\revive.ogg"),
                DisplayText(StrDesign("\x16빛\x04을 잃은 "..Color[i+1].."Ｌ\x11ｕ\x03ｍ\x18ｉ"..Color[i+1].."Ａ "..Color[i+1].."Ｍ\x04ａｒｉｎｅ이 \x16빛\x04의 \x03축복\x04을 받아 \x07소생하였습니다. \x1B(재사용 대기시간 : 10분)"),4),
                SetMemory(0x6509B0,SetTo,FP),
                SetmemoryB(0x665C48+380,SetTo,0);
                SetMemoryX(0x666458, SetTo, 391,0xFFFF),
                CreateUnitWithProperties(1,33,1,i,{energy = 1}),
                SetmemoryB(0x665C48+380,SetTo,1);
                SetMemoryX(0x666458, SetTo, 546,0xFFFF),
                --RunAIScriptAt("Recall Here",24)
            },{Preserved})
            end
            f_Read(FP,_Add(Nextptrs,0x28/4),TempTarget)
        CIf(FP,{TMemoryX(_Add(Nextptrs,19),Exactly,2*256,0xFF00)})
        CDoActions(FP,{
            TSetMemory(_Add(Nextptrs,0x5C/4),SetTo,0),
            TSetMemory(_Add(Nextptrs,0x18/4),SetTo,TempTarget),
            TSetMemory(_Add(Nextptrs,0x58/4),SetTo,TempTarget),
            TSetMemory(_Add(Nextptrs,0x10/4),SetTo,TempTarget),
            TSetMemoryX(_Add(Nextptrs,19),SetTo,107*256,0xFF00),
        })
        CIfEnd()
        --TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPPatch},{Preserved})
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
            TriggerX(FP,{CV(CPlayer,i)},{AddCD(PyCCode[i-3],1)},{Preserved})
        end
        
        f_LoadCp()
    CIfEnd()



	CallTriggerX(FP,MakeEisEgg,{Cond_EXCC(13,Exactly,1,1)})
    CIf(FP,{Cond_EXCC(1,AtLeast,1)}) -- 영작유닛인식
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
                    DoActions(FP,{Order("Men",Force2,1,Attack,10)})
                    CTrigger(FP,{Cond_EXCC(12,AtLeast,1)},{TSetMemory(_Add(Nextptrs,13),SetTo,EXCC_TempVarArr[13])},1)
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
        

        {135,{{53,53},{103}},{"Star1","Circle1"},{982,366}},--히드라덴
        {136,{{46},{54,54,50}},{"L00_1_128F","L00_1_64F"},{984,365}},--디파마운드
        {137,{{56,62}},{"H00_1_64F"},{366}},--그레이터스파이어
        {138,{{45},{40,40,51,104,51,104}},{"H00_1_128F","QNest"},{984,366}},--퀸네스트
        {139,{{53,54},{15}},{"EChamb","H00_1_96F"},{366,367}},--에볼루션챔버
        {140,{{48,48}},{"H00_1_64L"},{365}},--울트라
        {141,{{55,55}},{"H00_1_64F"},{366}},--스파이어
        {142,{{54,54}},{"Circle2"},{982}},--스포닝풀

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
    TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,100,SETimer)},{Preserved})


    CIf(FP,Command(AllPlayers,AtLeast,1,"Dark Swarm"),{MoveLocation(1,"Dark Swarm",AllPlayers,"Anywhere"),RemoveUnitAt(1,"Dark Swarm",1,AllPlayers),CreateUnit(1,84,1,FP),KillUnit(84,FP)}) -- 다크스웜 트리거
    --DoActionsP(FP,{,,CreateUnit(1,"【 Artanis 】",1,P8)})
    --CreateUnitPolygonSafe2Gun(FP,Always(),16,23,32,64,30,5,1,P8,{1,51})
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
                    f_TempRepeat({CV(Level,LvLeast,AtLeast),CV(Level,LVMost,AtMost),PlayerCheck(i,1),Command(i+4,AtLeast,1,189)},k[1],k[2],1,i+4,{WarpXY[i+1][1],WarpXY[i+1][2]})--
                end
            end
        else
            PushErrorMsg("CUTable_TypeError")
        end
        
    end
    CIf(FP,{CV(Time1,(60*30)*1000,AtMost),CD(WaveT,1800,AtLeast)},SetCD(WaveT,0))
        WaveSet({0,9},{{53,25},{54,30}})
        WaveSet({10,19},{{48,15},{53,20},{55,15}})
        WaveSet({20,24},{{55,25},{48,10},{54,15},{53,10}})
        WaveSet({25,50},{{56,25},{51,10},{104,10},{48,10},{53,10},{54,10}})
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
function InvDisable(UnitID,Owner,Condition,Str)
    Trigger2X(FP,Condition,{
        Simple_SetLoc(0,0,0,32,32);
        MoveLocation(1,UnitID,Owner,64);
        RotatePlayer({
            MinimapPing(1),
            PlayWAVX("staredit\\wav\\start.ogg"),
            PlayWAVX("staredit\\wav\\start.ogg"),
            DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n"..StrDesignX(Str).."\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
        },HumanPlayers,FP);
        SetInvincibility(Disable,UnitID,Owner,1);
    })
end
GunPStr = {
"\x11좌측 상단 ",
"\x18우측 상단 ",
"\x16좌측 하단 ",
"\x17우측 하단 ",
}
for i = 4, 7 do
    InvDisable(154,i,{CD(PyCCode[i-3],3,AtLeast)},GunPStr[i-3].."\x04지역 \x10"..Conv_HStr("<19>F<1D>elis").." \x04의 \x02무적상태\x04가 해제되었습니다.")
    InvDisable(147,i,{CD(CereCond[i-3],2,AtLeast)},GunPStr[i-3].."\x04지역 \x10"..Conv_HStr("<1D>the <19>H<1D>eaven").." \x04의 \x02무적상태\x04가 해제되었습니다.")
    
end

if Limit == 1 then
    TestCondT = {}
    for j, k in pairs(f_GunTable) do
        table.insert(TestCondT,Bring(Force2,AtMost,0,k,64))
    end
TriggerX(FP,{
    CD(TestMode,0);
    CV(Actived_Gun,0);
    TestCondT;
},{RotatePlayer({Victory()},MapPlayers,FP),RotatePlayer({Defeat()},{P5,P6,P7,P8},FP)})
end
CanText = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n"..StrDesignX("\x04맵상의 유닛이 \x08１５００\x04기 이상 있습니다.").."\n"..StrDesignX("\x08캔낫\x04이 \x073회 이상\x04 걸릴 경우 \x10게임\x04에서 \x06패배\x04합니다.\x04").."\n\x14\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"

Trigger { -- 캔낫 경고
	players = {FP},
	conditions = {
		Label(0);
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
    CDeaths(FP,AtMost,2,CanC);
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
    RotatePlayer({
        RunAIScriptAt(JYD,"Anywhere");
        },{P5,P6,P7,P8},FP);
		SetMemory(0x582174,Add,2);
		SetMemory(0x582178,Add,2);
		SetMemory(0x58217C,Add,2);
		SetMemory(0x582180,Add,2);
		SetMemory(0x582184,Add,2);
		SetCDeaths(FP,SetTo,24*30,CanCT);
		SetCDeaths(FP,Add,1,CanC);
		KillUnit("Factories",Force2);
},{Preserved})

Trigger2X(FP,{--캔발동
    CDeaths(FP,AtLeast,3,CanC);
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
    RotatePlayer({
        RunAIScriptAt(JYD,"Anywhere");
        },{P5,P6,P7,P8},FP);
		SetMemory(0x582174,Add,2);
		SetMemory(0x582178,Add,2);
		SetMemory(0x58217C,Add,2);
		SetMemory(0x582180,Add,2);
		SetMemory(0x582184,Add,2);
		SetCDeaths(FP,SetTo,24*30,CanCT);
		SetCDeaths(FP,Add,1,CanC);
		KillUnit("Factories",Force2);
		SetCDeaths(FP,Add,1,DefeatCC);
},{Preserved})

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
end