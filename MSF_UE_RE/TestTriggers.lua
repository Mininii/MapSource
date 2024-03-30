function Test_LV1()
    if Limit == 1 and TestStart == 0 then
        Trigger2(FP,{ElapsedTime(AtLeast,65)},{RotatePlayer({DisplayTextX("\x13\x04현재 \x07테스트 버전\x04을 이용중입니다.\n\x13\x07테스트에 협조해주셔서 감사합니다. \n\x13\x04테스트맵 이용 가능 기간은 "..T_YY.."년 "..T_MM.."월 "..T_DD.."일 "..T_HH.."시 까지입니다."),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
        Trigger2(FP,{Never(),ElapsedTime(AtLeast,65),ElapsedTime(AtMost,120)},{ModifyUnitShields(All,"Men",P8,64,0),ModifyUnitHitPoints(All,"Men",P8,64,0)},{preserved})
        CIfOnce(FP,{Never(),ElapsedTime(AtLeast,60)},{
            KillUnit("Men",P8);
            KillUnit(143,P8);
            KillUnit(144,P8);
            KillUnit(146,P8);
            KillUnit(193,P8);
        })
            CMov(FP,0x6509B0,19025+19)
            CWhile(FP,{Memory(0x6509B0,AtMost,19025+19 + (84*1699))})
                CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,7,0,0xFF),
                TTOR({
                    DeathsX(CurrentPlayer,Exactly,2*256,0,0xFF00),
                    DeathsX(CurrentPlayer,Exactly,3*256,0,0xFF00),
                    DeathsX(CurrentPlayer,Exactly,156*256,0,0xFF00),
                    DeathsX(CurrentPlayer,Exactly,160*256,0,0xFF00),
                })
            })
                    DoActions(FP,MoveCp(Add,6*4))
                    f_SaveCp()
                    OrderCheck = def_sIndex()
                    CJumpXEnd(FP,OrderCheck)
                        f_Mod(FP,Gun_TempRand,_Rand(),_Mov(7))
                        for i = 0, 6 do
                            NIf(FP,{CVar(FP,Gun_TempRand[2],Exactly,i),HumanCheck(i,0)})
                                CJumpX(FP,OrderCheck)
                            NIfEnd()
                        end
                        CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
                        for i = 0, 6 do
                            CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)})
                                CMov(FP,TempBarPos,BarPos[i+1])
                            CIfEnd()
                        end
                        CIfEnd()
                        CIf(FP,{TMemoryX(_Add(BackupCp,15),AtLeast,150*16777216,0xFF000000)})
                            CDoActions(FP,{
                                TSetDeathsX(_Sub(BackupCp,6),SetTo,6*256,0,0xFF00),
                                TSetDeaths(_Sub(BackupCp,3),SetTo,TempBarPos,0),
                            })
                        CIfEnd()
                    f_LoadCp()

                    DoActions(FP,MoveCp(Subtract,6*4))
                CIfEnd()
                CAdd(FP,0x6509B0,84)
            CWhileEnd()
            CMov(FP,0x6509B0,FP)
        CIfEnd()
    end
end
function Test_LV2()
    if Limit == 1 and TestStart == 1 then
        local BRXT = CreateVArray(FP,5)
        local BRYT = CreateVArray(FP,5)
        local BRX2T = CreateVArray(FP,5)
        local BRY2T = CreateVArray(FP,5)
        local BPtr = CreateVar(FP)
        local BPos = CreateVar(FP)
        local BPosX = CreateVar(FP)
        local BPosY = CreateVar(FP)
        local CurCunit = CreateVar(FP)
        local CurBR = CreateVar(FP)
        local TextX = CreateVar(FP)
        local TextY = CreateVar(FP)
        local TextX2 = CreateVar(FP)
        local TextY2 = CreateVar(FP)
        local BR = CreateVar(FP)
        local BRX = CreateVar(FP)
        local BRY = CreateVar(FP)
        local BRX2 = CreateVar(FP)
        local BRY2 = CreateVar(FP)
        local CR = CreateVar(FP)
        DoActions(FP,SetResources(Force1,SetTo,2000000000,Ore),1)
        DoActions(FP,{SetDeaths(Force1,Add,200,126),RotatePlayer({RunAIScript("Turn ON Shared Vision for Player 8")},MapPlayers,FP)})
        CIfOnce(FP)
        
            f_GetStrXptr(FP,TextX,"\x04X 좌표 : ".._0D)
            f_GetStrXptr(FP,TextY,"\x04Y 좌표 : ".._0D)
            f_GetStrXptr(FP,TextX2,"\x04맵상 X 좌표 : ".._0D)
            f_GetStrXptr(FP,TextY2,"\x04맵상 Y 좌표 : ".._0D)
            SkipText = GetStrSize(0,"\x04X 좌표 : \x0d\x0d\x0d\x0d\x0d")
            CMov(FP,BPtr,BarrackPtr[1])
            f_Read(FP,_Add(BPtr,10),BPos)
            CMov(FP,BPosX,BPos,0,0xFFFF)
            CMov(FP,BPosY,_Div(BPos,_Mov(0x10000)),0,0xFFFF)
        CIfEnd()
        CMov(FP,0x6509B0,CurrentOP)
        CIf(FP,{Deaths(CurrentPlayer,Exactly,1,OPConsole),TTCVar(FP,CurCunit[2],NotSame,Cunit2)})
        CMov(FP,0x6509B0,FP)
        CMov(FP,CurCunit,Cunit2)

        CIf(FP,{CVar(FP,CurCunit[2],AtLeast,1),CVar(FP,CurCunit[2],AtMost,0x7FFFFFFF)})
        f_Read(FP,_Add(CurCunit,10),CR)

        CMov(FP,BRX,CR,0,0xFFFF)
        CMov(FP,BRY,_Div(CR,0x10000),0,0xFFFF)
        CiSub(FP,BRX2,BRX,BPosX)
        CiSub(FP,BRY2,BRY,BPosY)

        ItoDec(FP,BRX,VArr(BRXT,0),1,nil,2)
        ItoDec(FP,BRY,VArr(BRYT,0),1,nil,2)
        ItoDec(FP,BRX2,VArr(BRX2T,0),1,nil,2)
        ItoDec(FP,BRY2,VArr(BRY2T,0),1,nil,2)
        f_Movcpy(FP,_Add(TextX2,SkipText),VArr(BRXT,0),5*4)
        f_Movcpy(FP,_Add(TextY2,SkipText),VArr(BRYT,0),5*4)
        f_Movcpy(FP,_Add(TextX,SkipText),VArr(BRX2T,0),5*4)
        f_Movcpy(FP,_Add(TextY,SkipText),VArr(BRY2T,0),5*4)

        DoActions(FP,{RotatePlayer({
            DisplayTextX("\x04==================",4),
            DisplayTextX("\x04X 좌표 : ".._0D,4),
            DisplayTextX("\x04Y 좌표 : ".._0D,4),
            DisplayTextX("\x04맵상 X 좌표 : ".._0D,4),
            DisplayTextX("\x04맵상 Y 좌표 : ".._0D,4),
        },{0,1,2,3,4,5,6,7},FP)})

        CIfEnd()
        CIfEnd()
        CMov(FP,0x6509B0,CurrentOP)
        CIf(FP,{Deaths(CurrentPlayer,AtLeast,1,225),CVar(FP,CurCunit[2],AtLeast,1),CVar(FP,CurCunit[2],AtMost,0x7FFFFFFF)})
        CMov(FP,0x6509B0,FP)

        f_Read(FP,_Add(CurCunit,10),BPos)
        CMov(FP,BPosX,BPos,0,0xFFFF)
        CMov(FP,BPosY,_Div(BPos,_Mov(0x10000)),0,0xFFFF)

        CMov(FP,BRX,BPos,0,0xFFFF)
        CMov(FP,BRY,_Div(BPos,0x10000),0,0xFFFF)
        CiSub(FP,BRX2,BRX,BPosX)
        CiSub(FP,BRY2,BRY,BPosY)

        ItoDec(FP,BRX,VArr(BRXT,0),1,nil,2)
        ItoDec(FP,BRY,VArr(BRYT,0),1,nil,2)
        ItoDec(FP,BRX2,VArr(BRX2T,0),1,nil,2)
        ItoDec(FP,BRY2,VArr(BRY2T,0),1,nil,2)
        f_Movcpy(FP,_Add(TextX2,SkipText),VArr(BRXT,0),5*4)
        f_Movcpy(FP,_Add(TextY2,SkipText),VArr(BRYT,0),5*4)
        f_Movcpy(FP,_Add(TextX,SkipText),VArr(BRX2T,0),5*4)
        f_Movcpy(FP,_Add(TextY,SkipText),VArr(BRY2T,0),5*4)

        DoActions(FP,{RotatePlayer({
            DisplayTextX("\x04점의 중심 좌표가 갱신되었습니다.",4),
        },{0,1,2,3,4,5,6,7},FP)})

        DoActions(FP,{RotatePlayer({
            DisplayTextX("\x04==================",4),
            DisplayTextX("\x04X 좌표 : ".._0D,4),
            DisplayTextX("\x04Y 좌표 : ".._0D,4),
            DisplayTextX("\x04맵상 X 좌표 : ".._0D,4),
            DisplayTextX("\x04맵상 Y 좌표 : ".._0D,4),
        },{0,1,2,3,4,5,6,7},FP)})

        CIfEnd()
        f_Read(FP,_Add(BPtr,62),BR)
        CIf(FP,{Deaths(P1,Exactly,1,OPConsole),TTCVar(FP,CurBR[2],NotSame,BR)})
        CMov(FP,CurBR,BR)

        CMov(FP,BRX,CurBR,0,0xFFFF)
        CMov(FP,BRY,_Div(CurBR,0x10000),0,0xFFFF)
        Simple_SetLocX(FP,0,BRX,BRY,BRX,BRY,{CreateUnit(1,MarID[1],1,P1),CreateUnit(1,11,1,FP)})
        CiSub(FP,BRX2,BRX,BPosX)
        CiSub(FP,BRY2,BRY,BPosY)


        ItoDec(FP,BRX,VArr(BRXT,0),1,nil,2)
        ItoDec(FP,BRY,VArr(BRYT,0),1,nil,2)
        ItoDec(FP,BRX2,VArr(BRX2T,0),1,nil,2)
        ItoDec(FP,BRY2,VArr(BRY2T,0),1,nil,2)
        f_Movcpy(FP,_Add(TextX2,SkipText),VArr(BRXT,0),5*4)
        f_Movcpy(FP,_Add(TextY2,SkipText),VArr(BRYT,0),5*4)
        f_Movcpy(FP,_Add(TextX,SkipText),VArr(BRX2T,0),5*4)
        f_Movcpy(FP,_Add(TextY,SkipText),VArr(BRY2T,0),5*4)

        DoActions(FP,{RotatePlayer({
            DisplayTextX("\x04==================",4),
            DisplayTextX("\x04X 좌표 : ".._0D,4),
            DisplayTextX("\x04Y 좌표 : ".._0D,4),
            DisplayTextX("\x04맵상 X 좌표 : ".._0D,4),
            DisplayTextX("\x04맵상 Y 좌표 : ".._0D,4),
        },{0,1,2,3,4,5,6,7},FP)})

        CIfEnd()
    end
end
