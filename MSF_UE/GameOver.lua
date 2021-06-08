function GameOver()
    local GameOver = CreateCCode(ExDeaths1)
    local Win = CreateCCode(ExDeaths1)
    Trigger { -- 게임 오버 트리거
        players = {Force1},
        conditions = {
            Label(0);
            CDeaths(FP,AtLeast,150+(48*4)+3,IntroT);
            Command(Force1,AtMost,0,"Men");
        },
        actions = {
            DisplayText(string.rep("\n", 20),4);
            DisplayText("\x13\x04"..string.rep("―", 56),4);
            DisplayText("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
            DisplayText("\n",4);
            DisplayText("\x13\x15모든 플레이어의 유닛이 전멸하였습니다.\n",4);
            DisplayText("\x13\x05게임을 종료합니다.",4);
            DisplayText("\n",4);
            DisplayText("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
            DisplayText("\x13\x04"..string.rep("―", 56),4);
            PlayWAV("staredit\\wav\\Game_Over.ogg");
            SetCDeaths(FP,SetTo,1,GameOver);
            },
        }
    CIf({FP},CDeaths(FP,AtLeast,1,GameOver)) -- 패배트리거
        Trigger { -- 게임 오버 트리거
        players = {FP},
        actions = {
            RotatePlayer({
                DisplayTextX(string.rep("\n", 20),4),
                DisplayTextX("\x13\x04"..string.rep("―", 56),4),
                DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4),
                DisplayTextX("\n",4),
                DisplayTextX("\x13\x15모든 플레이어의 유닛이 전멸하였습니다.\n",4);
                DisplayTextX("\x13\x05게임을 종료합니다.",4);
                DisplayTextX("\n",4),
                DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4),
                DisplayTextX("\x13\x04"..string.rep("―", 56),4),
                PlayWAVX("staredit\\wav\\Game_Over.ogg")
            },ObPlayers,FP);
    
            },
        }
    
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CDeaths(FP,AtLeast,100,GameOver);
            },
            actions = {
                SetCDeaths(FP,Add,1,ScorePrint);
            },
        }
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CDeaths(FP,AtMost,0,TestMode);
                CDeaths(FP,AtLeast,200,GameOver);
            },
            actions = {
                RotatePlayer({Defeat()},MapPlayers,FP)
            },
        }
        DoActionsX(FP,SetCDeaths(FP,Add,1,GameOver))
    CIfEnd() -- 패배트리거 끝
    
    
    CIf({Force1,FP},CDeaths(FP,AtLeast,1,Win)) -- 승리트리거
    
        for i=0, 56 do
        Trigger {
            players = {Force1},
            conditions = {
                Label(0);
                CDeaths(FP,AtLeast,100+i,Win);
            },
            actions = {
                DisplayText(string.rep("\n", 20),4);
                DisplayText("\n",4);
                DisplayText("\x13\x04"..string.rep("―", i),4);
                DisplayText("\n\n\n\n",4);
                DisplayText("\x13\x04"..string.rep("―", i),4);
                DisplayText("\n\n",4);
            },
        }
        end
        for i=0, 56 do
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CDeaths(FP,AtLeast,100+i,Win);
            },
            actions = {
                RotatePlayer({
                    DisplayTextX(string.rep("\n", 20),4),
                    DisplayTextX("\n",4),
                    DisplayTextX("\x13\x04"..string.rep("―", i),4),
                    DisplayTextX("\n\n\n\n",4),
                    DisplayTextX("\x13\x04"..string.rep("―", i),4),
                    DisplayTextX("\n\n",4)
                },ObPlayers,FP);
            },
        }
        end
    
        Trigger {
            players = {Force1},
            conditions = {
                Label(0);
                CDeaths(FP,AtLeast,200,Win);
                
            },
            actions = {
                DisplayText(string.rep("\n", 20),4);
                DisplayText("\x13\x04"..string.rep("―", 56),4);
                DisplayText("\n\x13\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x04를 \x10클리어\x04 하셨습니다. \x1F==\n",4);
                DisplayText("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04 in Used \x19(つ>ㅅ<)つ\n\n",4);
                DisplayText("\x13\x04"..string.rep("―", 56),4);
                DisplayText("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4);
                PlayWAV("staredit\\wav\\Level_Clear.ogg");
                PlayWAV("staredit\\wav\\Level_Clear.ogg");
            },
        } 
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CDeaths(FP,AtLeast,200,Win);
                
            },
            actions = {
                RotatePlayer({
                DisplayTextX(string.rep("\n", 20),4);
                DisplayTextX("\x13\x04"..string.rep("―", 56),4);
                DisplayTextX("\n\x13\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x04를 \x10클리어\x04 하셨습니다. \x1F==\n",4);
                DisplayTextX("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04 in Used \x19(つ>ㅅ<)つ\n\n",4);
                DisplayTextX("\x13\x04"..string.rep("―", 56),4);
                DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4);
                PlayWAVX("staredit\\wav\\Level_Clear.ogg");
                PlayWAVX("staredit\\wav\\Level_Clear.ogg");
                },ObPlayers,FP);
            },
        } 
    
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CDeaths(FP,AtLeast,350,Win);
            },
            actions = {
                SetCDeaths(FP,Add,1,ScorePrint);
            },
        }
        
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CDeaths(FP,AtMost,0,TestMode);
                CDeaths(FP,AtLeast,450,Win);
            },
            actions = {
                RotatePlayer({Victory()},MapPlayers,FP);
            },
        }
    DoActionsX(FP,SetCDeaths(FP,Add,1,Win))
    
    CIfEnd() -- 승리트리거 끝
end