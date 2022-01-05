function System()
	Cast_UnitCount()
    AddBGM(1,"staredit\\wav\\BYD_OP.ogg",152*1000)
    AddBGM(2,"staredit\\wav\\story.ogg",81*1000)
    Install_BGMSystem(FP,3,BGMType,12)

    EXCC_Part1(DUnitCalc) -- 죽은유닛 인식 단락 시작
    Check_Enemy = def_sIndex()
    NJump(FP,Check_Enemy,{DeathsX(CurrentPlayer,AtLeast,4,0,0xFF),DeathsX(CurrentPlayer,AtMost,7,0,0xFF)})

    DoActions(FP,MoveCp(Add,6*4))
    Install_DeathNotice()
    EXCC_ClearCalc()
    NJumpEnd(FP,Check_Enemy)
    DoActions(FP,MoveCp(Add,6*4))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,35,0,0xFF))
    EXCC_BreakCalc(DeathsX(CurrentPlayer,Exactly,42,0,0xFF))
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



    EXCC_ClearCalc(AddV(CurEXP,1))
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
    WhiteList = def_sIndex()
    for j, i in pairs(MarID) do
        NJumpX(FP,WhiteList,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
    end
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
    EXCC_ClearCalc()
    EXCC_Part2()
    EXCC_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
		EXCC_Part4X(i,{
            DeathsX(19025+(84*i)+19,AtMost,3,0,0xFF),
            DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
		},
		{MoveCp(Add,25*4),
		})
	end
	EXCC_End()
    
    
    SETimer = CreateCcode()
    TriggerX(FP,{CDeaths(FP,Exactly,0,SETimer)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,100,SETimer)},{Preserved})


    CIf(FP,Command(AllPlayers,AtLeast,1,"Dark Swarm"),{MoveLocation(1,"Dark Swarm",AllPlayers,"Anywhere"),RemoveUnitAt(1,"Dark Swarm",1,AllPlayers),CreateUnit(1,84,1,FP),KillUnit(84,FP)}) -- 다크스웜 트리거
    --DoActionsP(FP,{,,CreateUnit(1,"【 Artanis 】",1,P8)})
    --CreateUnitPolygonSafe2Gun(FP,Always(),16,23,32,64,30,5,1,P8,{1,51})
    CIfEnd()

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
    CIf(FP,{CV(Time1,(60*20)*1000,AtMost),CD(WaveT,1800,AtLeast)},SetCD(WaveT,0))
        WaveSet({0,9},{{53,25},{54,30}})
        WaveSet({10,19},{{48,15},{53,20},{55,15}})
        WaveSet({20,24},{{55,25},{48,10},{54,15},{53,10}})
        WaveSet({25,50},{{56,25},{51,10},{104,10},{48,10},{53,10},{54,10}})
    CIfEnd(AddCD(WaveT,1))

end