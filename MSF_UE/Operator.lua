function OPTrig()
    Cunit2 = CreateVar(FP)
    CIfX(FP,Never()) -- �����÷��̾� �ܶ� ����
	for i = 0, 6 do
        CElseIfX(PlayerCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i)})
        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
        f_Read(FP,0x58A364+(48*180)+(4*i),Dt) -- MSQC val Recive. 180 
        CTrigger(FP,{Deaths(i,AtMost,0,15),TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ LV.000\x04 - \x1F00h \x1100m \x0F00s \x04- \x07���, ���� â\x04 : F9, \x1F�������� \x04: HOMEŰ, \x1C������� \x04: F12\x07 ]")},1)
	end
    CIfXEnd()
    if TestStart == 1 then
        CIf(FP,{CDeaths(FP,AtLeast,1,TestMode),CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7fffffff)})
        --local TestTemp = CreateVar(FP)
        --f_Read(FP,_Add(Cunit2,19),TestTemp,nil,0xFF00)
        --CTrigger(FP,{CVar(FP,Cunit2[2],AtLeast,1)},{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(TestTemp,_Mov(65536)),0xFF000000)},1)





        local CurLev = CreateVar(FP)
        CMov(FP,0x6509B0,CurrentOP)
            TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,224)},{SetCVar(FP,Level[2],Add,1)},{Preserved})
            TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,223)},{SetCVar(FP,Level[2],Subtract,1)},{Preserved})
            CIf(FP,{TTCVar(FP,CurLev[2],NotSame,Level)})
            f_Mod(FP,LevelT,Level,_Mov(10))
            f_Div(FP,LevelT2,Level,_Mov(10))
            CAdd(FP,LevelT2,1)
            CAdd(FP,LevelT2,Diff)
            TriggerX(FP,{CVar(FP,LevelT[2],Exactly,0)},{SetCVar(FP,LevelT[2],SetTo,10)},{Preserved})
            CMov(FP,CurLev,Level)
            CIfEnd()

            Trigger {
            	players = {FP},
            	conditions = {
            		Label(0);
            		CDeaths(FP,AtLeast,1,TestMode);
            		Deaths(CurrentPlayer,AtLeast,1,222);
            	},
            	actions = {
            		KillUnit("Men",P8);
            		KillUnit(143,P8);
            		KillUnit(144,P8);
            		KillUnit(146,P8);
            		KillUnit(193,P8);
            		PreserveTrigger();
            	}
            	}
            CMov(FP,0x6509B0,CurrentOP)
        
            CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)})
                CMov(FP,0x6509B0,Cunit2)
                DoActions(FP,MoveCp(Add,25*4))
                local Not = def_sIndex()
                NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,111,0,0xFF)})
                NJumpX(FP,Not,{DeathsX(CurrentPlayer,Exactly,107,0,0xFF)})
                Trigger {
                    players = {FP},
                    conditions = {
                        DeathsX(CurrentPlayer,AtMost,57,0,0xFF);
                    },
                    actions = {
                        MoveCp(Subtract,6*4);
                        SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
                        MoveCp(Add,6*4);
                        PreserveTrigger();
                    }
                }
                Trigger {
                    players = {FP},
                    conditions = {
                        DeathsX(CurrentPlayer,AtLeast,59,0,0xFF);
                    },
                    actions = {
                        MoveCp(Subtract,6*4);
                        SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
                        MoveCp(Add,6*4);
                        PreserveTrigger();
                    }
                }
                NJumpXEnd(FP,Not)
                DoActions(FP,{MoveCp(Subtract,25*4)})
            CIfEnd()
        CIfEnd()
    end
    SetRecoverCp()
        
    --�����÷��̾� �ܶ������� LV�� �ð� ǥ��ÿ� 13���� ������ ��������. ���� �̰��� �ۼ���
    --		SetMemory(0x641598, SetTo, 0x4C205B07);
    --		SetMemory(0x64159C, SetTo, 0x30302E56);--FFFF0000
    --		SetMemory(0x6415A0, SetTo, 0x2D200430);--000000FF
    --		SetMemory(0x6415A4, SetTo, 0x30301F20);--FFFF0000
    --		SetMemory(0x6415A8, SetTo, 0x30112068);--FF000000
    --		SetMemory(0x6415AC, SetTo, 0x0F206D30);--000000FF
    --		SetMemory(0x6415B0, SetTo, 0x20733030);--0000FFFF
    --		SetMemory(0x6415B4, SetTo, 0x07202D04);
    --		SetMemory(0x6415B8, SetTo, 0xEBB0B8EA);
    --		SetMemory(0x6415BC, SetTo, 0x200480B6);
    --		SetMemory(0x6415C0, SetTo, 0x3946203A);
    --		SetMemory(0x6415C4, SetTo, 0x005D2007);
    for i = 0, 6 do
    CIf(FP,{Deaths(i,AtMost,0,15),TMemory(0x57F1B0,Exactly,i)})
    Print13_NumSet(LevelPtr,0x64159C,100,0x10000)
    Print13_NumSet(LevelPtr,0x64159C,10,0x1000000)
    Print13_NumSet(LevelPtr,0x6415A0,1,0x1)
    Print13_NumSet(TimePtr,0x6415A4,36000000,0x10000)
    Print13_NumSet(TimePtr,0x6415A4,3600000,0x1000000)
    Print13_NumSet(TimePtr,0x6415A8,60000*10,0x1000000)
    Print13_NumSet(TimePtr,0x6415AC,60000,0x1)
    Print13_NumSet(TimePtr,0x6415B0,10000,0x1)
    Print13_NumSet(TimePtr,0x6415B0,1000,0x100)
    CIfEnd()
    end
        
    CMov(FP,0x6509B0,CurrentOP)
    CIf(FP,{Switch("Switch 240",Cleared),CDeaths(FP,AtMost,0,IntroT)},{SetDeaths(CurrentPlayer,SetTo,1,OPConsole),SetCDeaths(FP,Add,1,OPFuncT)})
    TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,RIGHT),CVar(FP,Diff[2],AtMost,2)},{SetCVar(FP,Diff[2],Add,1)},{Preserved})
    TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,LEFT),CVar(FP,Diff[2],AtLeast,1)},{SetCVar(FP,Diff[2],Subtract,1)},{Preserved})
    for i = 0, 3 do
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,100+i)},{SetCVar(FP,Diff[2],SetTo,i)},{Preserved})
    end    
    TriggerX(FP,{CDeaths(FP,AtLeast,30*24,OPFuncT)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetCDeaths(FP,SetTo,0,OPFuncT)},{Preserved})
    TriggerX(FP,{Deaths(CurrentPlayer,AtMost,0,OPConsole)},{SetSwitch("Switch 240",Set),SetDeaths(Force1,SetTo,1,32),RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},HumanPlayers,FP),SetCVar(FP,ReserveBGM[2],SetTo,1)},{Preserved})
    if TestStart ==1 then
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,221)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},HumanPlayers,FP),SetSwitch("Switch 240",Set),SetDeaths(Force1,SetTo,1,32),SetCDeaths(FP,Add,150+(48*4),IntroT)},{Preserved})
    else
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,221)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),RotatePlayer({PlayWAVX("sound\\glue\\bnetclick.wav"),PlayWAVX("sound\\glue\\bnetclick.wav")},HumanPlayers,FP),SetSwitch("Switch 240",Set),SetDeaths(Force1,SetTo,1,32),SetCVar(FP,ReserveBGM[2],SetTo,1)},{Preserved})
    end
        DoActions(FP,{RotatePlayer({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x1E�� \x04���� �÷��̾�� ���� ���̵��� �������ּ���. ���ڰ� Ŭ���� ��������ϴ�. \x1E��\n\x13\x04���ڹ�ư �Ǵ� ����Ű�� ���� �� Y�� �����ּ���.\n\x13\x03�� \x04�� �� �� Press (Y) to Start",4)},HumanPlayers,FP)},1)
        CIf(FP,{TTCVar(FP,CurrentDiff[2],NotSame,Diff)})
        CMov(FP,CurrentDiff,Diff)
        TriggerX(FP,{CVar(FP,Diff,Exactly,0)},{
            RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
            DisplayTextX("\x13\x03�� \x04�� �� �� Press (Y) to Start", 0)},HumanPlayers,FP);SetMemoryB(0x58D2B0+(46*7)+3,SetTo,0)},{Preserved})
        TriggerX(FP,{CVar(FP,Diff,Exactly,1)},{
            RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
            DisplayTextX("\x13\x04�� \x03�� \x04�� �� Press (Y) to Start", 0)},HumanPlayers,FP);SetMemoryB(0x58D2B0+(46*7)+3,SetTo,5)},{Preserved})
        TriggerX(FP,{CVar(FP,Diff,Exactly,2)},{
            RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
            DisplayTextX("\x13\x04�� �� \x03�� \x04�� Press (Y) to Start", 0)},HumanPlayers,FP);SetMemoryB(0x58D2B0+(46*7)+3,SetTo,10)},{Preserved})
        TriggerX(FP,{CVar(FP,Diff,Exactly,3)},{
            RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
            DisplayTextX("\x13\x04�� �� �� \x03�� \x04Press (Y) to Start", 0)},HumanPlayers,FP);SetMemoryB(0x58D2B0+(46*7)+3,SetTo,15)},{Preserved})
        CIfEnd()
        CMov(FP,0x6509B0,CurrentOP)
    CIfEnd()
    KeyInput(F12,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,CPConsole)},{
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	DisplayText("\x07�� \x1F��� ON \x04���¿����� ����� �� ���� ����Դϴ�. \x03ESC\x04�� ���� ����� OFF���ּ���. \x07��",4)},1)
    KeyInput(F9,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,OPConsole)},{
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	DisplayText("\x07�� \x1C������� \x04���¿����� ����� �� ���� ����Դϴ�. \x03ESC\x04�� ���� ����� OFF���ּ���. \x07��",4)},1)
    KeyInput(F12,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,0,OPConsole)},SetDeaths(CurrentPlayer,SetTo,1,OPConsole),1)
    KeyInput(F12,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,Exactly,1,OPConsole)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(FP,SetTo,0,BanConsole)},1)

    CIf(FP,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),Deaths(CurrentPlayer,AtLeast,1,OPConsole)},SetCDeaths(FP,Add,1,OPFuncT))
        if Testmode == 0 then
        TriggerX(FP,{CDeaths(FP,AtLeast,30*24,OPFuncT)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetCDeaths(FP,SetTo,0,OPFuncT)},{Preserved})
        end
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,RIGHT),CVar(FP,SpeedVar[2],AtMost,9)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Add,1)},{Preserved})
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,LEFT),CVar(FP,SpeedVar[2],AtLeast,2)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Subtract,1)},{Preserved})
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,0,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,1,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{Preserved})
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,1,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{Preserved})
        CIfX(FP,Deaths(CurrentPlayer,AtLeast,1,BanConsole))
            CTrigger(FP,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ \x08������ ON. \x04����Ű�� 5ȸ ���� �����ϼ���. ESC : �ݱ�\x07 ]")},1)
            -- 205 ~ 211
            for i = 1, 6 do
                CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,205+i),TTMemory(0x6509B0,NotSame,i),PlayerCheck(i,1)},{
                    RotatePlayer({DisplayTextX("\x07�� "..PlayerString[i+1].."\x04���� \x08��� 1ȸ ����\x04 �Ǿ����ϴ�. �� 5ȸ ������ \x08���� ó�� \x04�˴ϴ�. \x07��",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
                    SetCDeaths(FP,SetTo,0,OPFuncT),SetCDeaths(FP,Add,1,BanToken[i+1])},{Preserved})
            end
            CMov(FP,0x6509B0,CurrentOP)
            CelseX()
            CTrigger(FP,{CDeaths(FP,AtLeast,150+(48*4)+3,IntroT),TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ \x04����Ű(���) : \x1F��� ����, \x04ESC : �ݱ�, B : \x08������ ON\x07 ]")},1)
        CIfXEnd()
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(CurrentPlayer,SetTo,0,BanConsole)},{Preserved})
    CIfEnd()
    CMov(FP,0x6509B0,FP) -- RecoverCP �����÷��̾� �ܶ� ��
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- ������� Ʈ����
        CMov(FP,CurrentSpeed,SpeedVar)
        for i = 1, 10 do
            Trigger { -- No comment (E93EF7A9)
                players = {FP},
                conditions = {
                    Label(0);
                    CVar(FP,SpeedVar[2],Exactly,i)
                },
                actions = {PreserveTrigger();
                    RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
                    DisplayTextX("\x13\x07�� \x0F��� ���� \x10- "..XSpeed[i].." \x07��", 0)},HumanPlayers,FP);
                    SetMemory(0x5124F0,SetTo,SpeedV[i]);
                },
            }
        end
    CIfEnd()
end