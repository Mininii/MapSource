function Print_TotalScore()
    CIf(FP,CDeaths(FP,AtLeast,1,ScorePrint),SetCDeaths(FP,SetTo,0,ScorePrint))
    TxtSkip = Str10[2] + GetStrSize(0,"\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d") + (4*6)
    for i = 1, 7 do
    CIf(FP,CVar(FP,BarPos[i][2],AtLeast,1))
    CMov(FP,ExScoreP[i],ExScore[i])
    ItoDecX(FP,ExScoreP[i],VArr(ExScoreVA[i],0),2,nil,2)
    _0DPatchforVArr(FP,ExScoreVA[i],6)
    f_Movcpy(FP,_Add(PScoreSTrPtr[i],TxtSkip),VArr(ExScoreVA[i],0),12*4)
    f_Memcpy(FP,_Add(PScoreSTrPtr[i],TxtSkip+(12*4)),_TMem(Arr(Str19[3],0),"X","X",1),Str19[2])
    CIfEnd()
    
    end
    Trigger {
        players = {FP},
        conditions = {
            },
        
        actions = {
            RotatePlayer({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x10【 \x06Ｔ\x04ｏｔａｌ　\x1FＳｃｏｒｅ \x10】",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
            PreserveTrigger();
        },
    }
    for i = 1, 7 do
    Trigger {
        players = {FP},
        conditions = {
            Label(0);
            CVar(FP,BarPos[i][2],AtLeast,1);
            },
        
        actions = {
            RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i].."Score".._0D,4)},HumanPlayers,FP);
            PreserveTrigger();
        },
    }
    end
    CIfEnd()
end