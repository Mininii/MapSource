function Test_LV1()
    local CUnitID = CreateVar()
    if Limit == 1 then
        Trigger2(FP,{ElapsedTime(AtLeast,65)},{ModifyUnitHitPoints(All,"Men",P8,64,0),RotatePlayer({DisplayTextX("\x13\x07테스트 모드 \x04특전! 모든 유닛을 1회 끌어당깁니다."),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP)})
        Trigger2(FP,{ElapsedTime(AtLeast,65),ElapsedTime(AtMost,120)},{ModifyUnitShields(All,"Men",P8,64,0)},{Preserved})
        CIfOnce(FP,ElapsedTime(AtLeast,60))
            CMov(FP,0x6509B0,19025+19)
            CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
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
                            NIf(FP,{CVar(FP,Gun_TempRand[2],Exactly,i),PlayerCheck(i,0)})
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
        DoActions(FP,{SetResources(Force1,SetTo,0x70000000,Ore),SetDeaths(Force1,Add,200,126),RotatePlayer({RunAIScript("Turn ON Shared Vision for Player 8")},MapPlayers,FP)})

    end
end
