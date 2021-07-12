function OPTrig()
    Cunit2 = CreateVar()
    CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
        CElseIfX(PlayerCheck(i,1),{SetCVar(FP,CurrentOP[2],SetTo,i)})
        f_Read(FP,0x6284E8+(0x30*i),"X",Cunit2)
        f_Read(FP,0x58A364+(48*180)+(4*i),Dt) -- MSQC val Recive. 180 
        CTrigger(FP,{TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ LV.000\x04 - \x1F00h \x1100m \x0F00s \x04- \x07기부\x04 : F9, \x1C배속조정 \x04: F12\x07 ]")},1)
	end
    CIfXEnd()
    if TestStart == 1 then
        CIf(FP,{CDeaths(FP,AtLeast,1,TestMode),CVar(FP,Cunit2[2],AtLeast,1),CVar(FP,Cunit2[2],AtMost,0x7fffffff)})
        --local TestTemp = CreateVar()
        --f_Read(FP,_Add(Cunit2,19),TestTemp,nil,0xFF00)
        --CTrigger(FP,{CVar(FP,Cunit2[2],AtLeast,1)},{TSetMemoryX(_Add(Cunit2,35),SetTo,_Mul(TestTemp,_Mov(65536)),0xFF000000)},1)





        local CurLev = CreateVar()
        CMov(FP,0x6509B0,CurrentOP)
            TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,224)},{SetCVar(FP,Level[2],Add,1)},{Preserved})
            TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,223)},{SetCVar(FP,Level[2],Subtract,1)},{Preserved})
            CIf(FP,{TTCVar(FP,CurLev[2],NotSame,Level)})
            f_Mod(FP,LevelT,Level,_Mov(10))
            f_Div(FP,LevelT2,Level,_Mov(10))
            CAdd(FP,LevelT2,1)
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
        
    --상위플레이어 단락이지만 LV과 시간 표기시에 13번줄 조작은 문제없음. 따라서 이곳에 작성함
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
        
        
    Print13_NumSet(LevelPtr,0x64159C,100,0x10000)
    Print13_NumSet(LevelPtr,0x64159C,10,0x1000000)
    Print13_NumSet(LevelPtr,0x6415A0,1,0x1)
    Print13_NumSet(TimePtr,0x6415A4,36000000,0x10000)
    Print13_NumSet(TimePtr,0x6415A4,3600000,0x1000000)
    Print13_NumSet(TimePtr,0x6415A8,60000*10,0x1000000)
    Print13_NumSet(TimePtr,0x6415AC,60000,0x1)
    Print13_NumSet(TimePtr,0x6415B0,10000,0x1)
    Print13_NumSet(TimePtr,0x6415B0,1000,0x100)
        
        
        
    local SpeedVar = CreateVar(4)
    CMov(FP,0x6509B0,CurrentOP)
    KetInput(F12,Deaths(CurrentPlayer,Exactly,1,CPConsole),{
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	DisplayText("\x07『 \x1F기부 ON \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』",4)},1)
    KetInput(F9,Deaths(CurrentPlayer,Exactly,1,OPConsole),{
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	PlayWAV("sound\\Misc\\Buzz.wav"),
    	DisplayText("\x07『 \x1C배속조정 \x04상태에서는 사용할 수 없는 기능입니다. \x03ESC\x04를 눌러 기능을 OFF해주세요. \x07』",4)},1)
    KetInput(F12,Deaths(CurrentPlayer,Exactly,0,OPConsole),SetDeaths(CurrentPlayer,SetTo,1,OPConsole),1)
    KetInput(F12,Deaths(CurrentPlayer,Exactly,1,OPConsole),{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(FP,SetTo,0,BanConsole)},1)

    CIf(FP,Deaths(CurrentPlayer,AtLeast,1,OPConsole),SetCDeaths(FP,Add,1,OPFuncT))
        if Testmode == 0 then
        TriggerX(FP,{CDeaths(FP,AtLeast,30*24,OPFuncT)},{SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetCDeaths(FP,SetTo,0,OPFuncT)},{Preserved})
        end
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,RIGHT),CVar(FP,SpeedVar[2],AtMost,9)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Add,1)},{Preserved})
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,LEFT),CVar(FP,SpeedVar[2],AtLeast,2)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetCVar(FP,SpeedVar[2],Subtract,1)},{Preserved})
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,0,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,1,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{Preserved})
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,B),Deaths(CurrentPlayer,Exactly,0,F9),Deaths(CurrentPlayer,Exactly,1,BanConsole)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,BanConsole),SetDeaths(CurrentPlayer,SetTo,0,B)},{Preserved})
        CIfX(FP,Deaths(CurrentPlayer,AtLeast,1,BanConsole))
            CTrigger(FP,{TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ \x08강퇴모드 ON. \x04숫자키를 5회 눌러 강퇴하세요. ESC : 닫기\x07 ]")},1)
            -- 205 ~ 211
            for i = 1, 6 do
                CTrigger(FP,{Deaths(CurrentPlayer,AtLeast,1,205+i),TTMemory(0x6509B0,NotSame,i),PlayerCheck(i,1)},{
                    RotatePlayer({DisplayTextX("\x07『 "..PlayerString[i+1].."\x04에게 \x08경고 1회 누적\x04 되었습니다. 총 5회 누적시 \x08강퇴 처리 \x04됩니다. \x07』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
                    SetCDeaths(FP,SetTo,0,OPFuncT),SetCDeaths(FP,Add,1,BanToken[i+1])},{Preserved})
            end
            CMov(FP,0x6509B0,CurrentOP)
            CelseX()
            CTrigger(FP,{TMemory(0x57F1B0,Exactly,CurrentOP)},{print_utf8(12, 0, "\x07[ \x04방향키(←→) : \x1F배속 조정, \x04ESC : 닫기, B : \x08강퇴모드 ON\x07 ]")},1)
        CIfXEnd()
        TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,ESC)},{SetCDeaths(FP,SetTo,0,OPFuncT),SetDeaths(CurrentPlayer,SetTo,0,OPConsole),SetDeaths(CurrentPlayer,SetTo,0,BanConsole)},{Preserved})
    CIfEnd()
    CMov(FP,0x6509B0,FP) -- RecoverCP 상위플레이어 단락 끝
    CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)}) -- 배속조정 트리거
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
                    DisplayTextX("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i].." \x07』", 0)},HumanPlayers,FP);
                    SetMemory(0x5124F0,SetTo,SpeedV[i]);
                },
            }
        end
    CIfEnd()
end