function Install_Roka7Boss()

    
    -- #X1 : 216 -------------------------------------------------------------------------------------------
        
    
    DoActions(FP,{RemoveUnit(203,FP),RemoveUnit(204,FP)})
    SHIndex = 217
    VARI = (SHIndex-2)*3
    VONM = (SHIndex-1)*5
    SHLX = 2480+4736        
    SHLY = 1256
    local XColor = CreateVar() local XColor = XColor[2]
    local XType = CreateVar() local XType = XType[2]
    local XTemp = CreateVar() local XTemp = XTemp[2]
    B5_XY = CreateVar()
    B5_YZ = CreateVar()
    B5_ZX = CreateVar()


    CIfX(FP,{Bring(FP,AtLeast,1, "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",64)},{SetCVar(FP,VResetSw[2],SetTo,0)})
    CMov(FP,VO(41),LevelT2) -- Diff
    
    
    
    CJump(FP,11)
    
for i = 0x2000, 0x2300 do
	CVariable(AllPlayers,i)
end
    CVariable(AllPlayers,0x1FE9)
    CVariable(AllPlayers,0x1FE8)
    CVariable(AllPlayers,0x1FE7)
    CVariable(AllPlayers,0x1FE6)
    CVariable(AllPlayers,0x1FE5)
    CVariable(AllPlayers,0x1FE4)
    CVariable(AllPlayers,0x1FE3)
    CVariable(AllPlayers,0x1FE2)
    CVariable(AllPlayers,0x1FE1)
    CVariable(AllPlayers,0x1FE0)
    
    
    SHX1a =
    {4,{3.9188697572715e-015,-64},{64,0},{3.9188697572715e-015,64},{-64,7.8377395145431e-015}}
    SHX1a = CS_RatioXY(SHX1a,2,2)
    
    -- #X1 : 216 -------------------------------------------------------------------------------------------
    
    
    
    SHIndex = 216
    VARI = (SHIndex-1)*3
    VONM = (SHIndex-1)*5
    SHLX = 2480        
    SHLY = 1256
    
    
    
    X1func2 = SetCallForward()
    SetCall(FP)
    B5_V1 = CreateVar()
    B5_V2 = CreateVar()
    
    CIf(FP,CVar("X",B5_V1[2],Exactly,0))
        CIfX(FP,CVar("X",XColor,Exactly,0))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 10*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(4,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,1))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 17*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(4,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,2))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 6*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 16*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 18*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,3))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 6*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 13*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 18*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,4))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 16*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,5))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 0*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CIfXEnd()
    CIfEnd()
    
    CIf(FP,CVar("X",B5_V1[2],Exactly,1))
        CIfX(FP,CVar("X",XColor,Exactly,0))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 10*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(4,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,1))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 17*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(4,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,2))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 6*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 16*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 18*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,3))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 6*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 13*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 18*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,4))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 16*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar("X",XColor,Exactly,5))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
    
            CTrigger(FP,{--[[CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741),]]},{
                SetMemoryX(0x66A1F4, SetTo, 0*16777216,0xFF000000); -- 리맵핑
                SetMemoryX(0x66321C, SetTo, 19*1,0xFF); -- 높이
                CreateUnit(1,204, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CIfXEnd()
    CIfEnd()
    
    SetCallEnd()
    
    
    
    
    BCA = SetCallForward()
    SetCall(FP)
    
    function X1func()
                local CA = CAPlotDataArr
                local CB = CAPlotCreateArr
                
                CA_Rotate3D(B5_XY,B5_YZ,B5_ZX)
                
                DoActions(FP,{SetMemoryX(0x666460, SetTo, 975*65536,0xFFFF0000),SetMemory(0x66FB84, SetTo, 131)})
                
                Trigger {
                    players = {FP},
                    conditions = {
                        Label(0);
                        CVar("X",B5_V1[2],Exactly,0);
                    },
                    actions = {
                        SetCVar("X",CB[3],SetTo,FP);
                        PreserveTrigger();
                    }
                }
                Trigger {
                    players = {FP},
                    conditions = {
                        Label(0);
                        CVar("X",B5_V1[2],Exactly,1);
                    },
                    actions = {
                        SetCVar("X",CB[3],SetTo,FP);
                        PreserveTrigger();
                    }
                }
                
                CIfX(FP,CVar("X",B5_V2[2],Exactly,0))
                    CMov(FP,V(0x1FE2),V(CA[8]))
                    CMov(FP,V(0x1FE3),V(CA[9]))
                    CMov(FP,V(0x22F2),_Add(V(CA[8]),V(CA[8])))
                    CMov(FP,V(0x22F3),_Add(V(CA[9]),V(CA[9])))
                    CMov(FP,V(0x22E2),_Add(V(CA[8]),V(0x22F2)))
                    CMov(FP,V(0x22E3),_Add(V(CA[9]),V(0x22F3)))
                CElseIfX(CVar("X",B5_V2[2],Exactly,1))
                    CMov(FP,V(0x1FE4),V(CA[8]))
                    CMov(FP,V(0x1FE5),V(CA[9]))
                    CMov(FP,V(0x22F4),_Add(V(CA[8]),V(CA[8])))
                    CMov(FP,V(0x22F5),_Add(V(CA[9]),V(CA[9])))
                    CMov(FP,V(0x22E4),_Add(V(CA[8]),V(0x22F4)))
                    CMov(FP,V(0x22E5),_Add(V(CA[9]),V(0x22F5)))
                CElseIfX(CVar("X",B5_V2[2],Exactly,2))
                    CMov(FP,V(0x1FE6),V(CA[8]))
                    CMov(FP,V(0x1FE7),V(CA[9]))
                    CMov(FP,V(0x22F6),_Add(V(CA[8]),V(CA[8])))
                    CMov(FP,V(0x22F7),_Add(V(CA[9]),V(CA[9])))
                    CMov(FP,V(0x22E6),_Add(V(CA[8]),V(0x22F6)))
                    CMov(FP,V(0x22E7),_Add(V(CA[9]),V(0x22F7)))
                CElseIfX(CVar("X",B5_V2[2],Exactly,3))
                    CMov(FP,V(0x1FE8),V(CA[8]))
                    CMov(FP,V(0x1FE9),V(CA[9]))
                    CMov(FP,V(0x22F8),_Add(V(CA[8]),V(CA[8])))
                    CMov(FP,V(0x22F9),_Add(V(CA[9]),V(CA[9])))
                    CMov(FP,V(0x22E8),_Add(V(CA[8]),V(0x22F8)))
                    CMov(FP,V(0x22E9),_Add(V(CA[9]),V(0x22F9)))
                CIfXEnd()
                
                Trigger {
                    players = {FP},
                    conditions = {
                        Label(0);
                    },
                    actions = {
                        SetCVar("X",B5_V2[2],Add,1);
                        PreserveTrigger();
                    }
                }
            
                -- XColor : ◎White  / ●Black  / ▶◀ Violet / ▽△ YGreen / ▣ Blue(소환) / ‡ Red(공반) : (안전지대)
    
            end
            CAPlot({SHX1a},FP,nilunit,"Location 1",nil,1,0,{V(0x2003+VARI),0,0,0,4,V(0x2001+VARI),nil,V(0x2002+VARI),nil},"X1func",FP,CVar(FP,LevelT2[2],AtLeast,1),{SetNext("X",X1func2),SetNext(X1func2+1,"X",1)},nil)
    SetCallEnd()
    CJumpEnd(FP,11)
    function FindErrorX()
    CMov(FP,0x57f120,Nextptrs)
    CAdd(FP,0x57f0f0,1)
    end
    SetRecoverCp()
    
        --[[]]
        CIfX(FP,CVar(FP,LevelT2[2],Exactly,1))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 13*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 0*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)

            },{Preserved})
            
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)

            },{Preserved})
            
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)

            },{Preserved})
        CElseIfX(CVar(FP,LevelT2[2],Exactly,2))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 16*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 0*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar(FP,LevelT2[2],Exactly,3))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 16*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 0*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CElseIfX(CVar(FP,LevelT2[2],Exactly,4))
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 16*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 0*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
--            CMov(FP,V(Nextptrs[2]),0)
--            f_Read(FP,0x628438,nil,V(Nextptrs[2]),0xFFFFFF)
            CTrigger(FP,{CVar("X",Nextptrs[2],Atleast,19025),CVar("X",Nextptrs[2],AtMost,161741)},{
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                SetMemoryX(0x66A1C4, SetTo, 6*256,0xFF00); -- 리맵핑
                SetMemoryX(0x663218, SetTo, 1*16777216,0xFF000000); -- 높이
                CreateUnit(1,203, "Location 1",FP);
--                TSetMemoryX(Vi(Nextptrs[2],55),SetTo,0x200104,0x300104);
--                TSetMemory(Vi(Nextptrs[2],57),SetTo,0)
},{Preserved})
        CIfXEnd()
        CMov(FP,0x6509B0,FP)

        
        CTrigger(FP,{Memory(0x58D744,AtLeast,56)},{TSetDeathsX(_Read(0x58D744),SetTo,0,0,0x40000)},{Preserved})
        
        SHX1b1 =
        {16,{1.9594348786358e-014,-320},{122.45869835683,-295.64145040361},{226.2741699797,-226.2741699797},{295.64145040361,-122.45869835683},{320,0},{295.64145040361,122.45869835683},{226.2741699797,226.2741699797},{122.45869835683,295.64145040361},{1.9594348786358e-014,320},{-122.45869835683,295.64145040361},{-226.2741699797,226.2741699797},{-295.64145040361,122.45869835683},{-320,3.9188697572715e-014},{-295.64145040361,-122.45869835683},{-226.2741699797,-226.2741699797},{-122.45869835683,-295.64145040361}}
    
    
        SHX1b2 =
        {16,{160,-277.12812921102},{253.8730688932,-194.80365728279},{309.0962644125,-82.822094432807},{317.26235563962,41.768381510417},{277.12812921102,160},{194.80365728279,253.8730688932},{82.822094432807,309.0962644125},{-41.768381510417,317.26235563962},{-160,277.12812921102},{-253.8730688932,194.80365728279},{-309.0962644125,82.822094432807},{-317.26235563962,-41.768381510416},{-277.12812921102,-160},{-194.80365728279,-253.8730688932},{-82.822094432807,-309.0962644125},{41.768381510416,-317.26235563962}}
    
    
        SHX1b3 =
        {16,{277.12812921102,-160},{317.26235563962,-41.768381510417},{309.0962644125,82.822094432807},{253.8730688932,194.80365728279},{160,277.12812921102},{41.768381510417,317.26235563962},{-82.822094432807,309.0962644125},{-194.80365728279,253.8730688932},{-277.12812921102,160},{-317.26235563962,41.768381510417},{-309.0962644125,-82.822094432807},{-253.8730688932,-194.80365728279},{-160,-277.12812921102},{-41.768381510417,-317.26235563962},{82.822094432806,-309.0962644125},{194.80365728279,-253.8730688932}}
    
    
        SHX1c1 = CS_RatioXY(SHX1b1,1.6,1.6)
        SHX1c2 = CS_RatioXY(SHX1b2,1.6,1.6)
        SHX1c3 = CS_RatioXY(SHX1b3,1.6,1.6)
        
        SHX1a1 = CS_RatioXY(SHX1b1,0.4,0.4)
        SHX1a2 = CS_RatioXY(SHX1b2,0.4,0.4)
        SHX1a3 = CS_RatioXY(SHX1b3,0.4,0.4)
        
        SHX1d1 = CS_RatioXY(SHX1b1,0.8,0.8)
        SHX1d2 = CS_RatioXY(SHX1b2,0.8,0.8)
        SHX1d3 = CS_RatioXY(SHX1b3,0.8,0.8)
        
        SHX1b1 = CS_RatioXY(SHX1b1,1.2,1.2)
        SHX1b2 = CS_RatioXY(SHX1b2,1.2,1.2)
        SHX1b3 = CS_RatioXY(SHX1b3,1.2,1.2)
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    CVar(FP,LevelT2[2],AtLeast,1);
                    CDeaths(FP,Exactly,0,BossStart);
                },
                actions = {SetMemoryX(0x669FE8, SetTo, 3*256,0xFF00);
                    RotatePlayer({DisplayTextX("\n\n\n\x13\x04『☆˚.*·。˚＃7사단을 파괴했습니다. \x05。+.˚。˚·*˙。★』\n\n\n",4)},HumanPlayers,FP);
                    SetCDeaths(FP,SetTo,1,BossStart);
                    Simple_SetLoc(164,4096,352,4160,480);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    KillUnit(125,Force1);
                    PreserveTrigger();
                }
            }
        
        Trigger {
            players = {FP},
            actions = {
                Simple_SetLoc(0,0,0,0,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");
                PreserveTrigger();
            }
        }
        
        
    
        -- ez -------------------------------------------------------------------------------------------
        
        --CSPlot(SHX1a1,FP,37,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1a2,FP,38,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1a3,FP,43,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,1)},nil,nil)
       -- 
        --CSPlot(SHX1a1,FP,39,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1a2,FP,54,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1a3,FP,55,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,2)},nil,nil)
       -- 
        --CSPlot(SHX1a1,FP,48,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1a2,FP,53,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1a3,FP,56,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,3)},nil,nil)
    
        --CSPlot(SHX1a1,FP,104,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1a2,FP,51,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1a3,FP,47,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,4)},nil,nil)
       -- 
        --CSPlot(SHX1a1,FP,52,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1a2,FP,57,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1a3,FP,44,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,5)},nil,nil)
       -- 
        --CSPlot(SHX1a1,FP,40,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1a2,FP,46,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1a3,FP,62,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,6)},nil,nil)
       -- 
        --CSPlot(SHX1a1,FP,25,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1a2,FP,69,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1a3,FP,30,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F518,Exactly,7)},nil,nil)
        ---- NM -------------------------------------------------------------------------------------------
       -- 
        --CSPlot(SHX1d1,FP,77,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1d2,FP,19,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1d3,FP,88,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,1)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,67,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1d2,FP,25,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1d3,FP,58,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,2)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,78,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1d2,FP,81,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1d3,FP,5,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1d1,FP,17,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1d2,FP,10,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1d3,FP,86,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,4)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,100,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1d2,FP,76,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1d3,FP,21,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,5)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,75,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1d2,FP,60,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1d3,FP,69,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,6)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,28,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1d2,FP,8,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1d3,FP,102,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F518,Exactly,7)},nil,nil)
       -- 
        ---- HD -------------------------------------------------------------------------------------------
       -- 
        --CSPlot(SHX1c1,FP,65,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1c2,FP,2,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1c3,FP,80,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,1)},nil,nil)
       -- 
        --CSPlot(SHX1c1,FP,79,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1c2,FP,30,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1c3,FP,11,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,2)},nil,nil)
       -- 
        --CSPlot(SHX1c1,FP,66,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1c2,FP,64,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1c3,FP,23,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,3)},nil,nil)
       -- 
        --CSPlot(SHX1c1,FP,3,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1c2,FP,32,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1c3,FP,71,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,4)},nil,nil)
       -- 
        --CSPlot(SHX1c1,FP,16,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1c2,FP,68,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1c3,FP,1,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,5)},nil,nil)
       -- 
        --CSPlot(SHX1c1,FP,74,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1c2,FP,98,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1c3,FP,13,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,6)},nil,nil)
       -- 
        --CSPlot(SHX1c1,FP,22,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1c2,FP,8,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1c3,FP,27,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F518,Exactly,7)},nil,nil)
        ---- LN -------------------------------------------------------------------------------------------
       -- 
        --CSPlot(SHX1d1,FP,65,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1d2,FP,2,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,1)},nil,nil)
        --CSPlot(SHX1d3,FP,80,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,1)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,79,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1d2,FP,30,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,2)},nil,nil)
        --CSPlot(SHX1d3,FP,11,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,2)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,66,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1d2,FP,64,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1d3,FP,23,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,3)},nil,nil)
        --CSPlot(SHX1d1,FP,3,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1d2,FP,32,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,4)},nil,nil)
        --CSPlot(SHX1d3,FP,71,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,4)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,16,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1d2,FP,68,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,5)},nil,nil)
        --CSPlot(SHX1d3,FP,1,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,5)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,74,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1d2,FP,98,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,6)},nil,nil)
        --CSPlot(SHX1d3,FP,13,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,6)},nil,nil)
       -- 
        --CSPlot(SHX1d1,FP,22,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1d2,FP,8,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,7)},nil,nil)
        --CSPlot(SHX1d3,FP,27,"Location 1",nil,1,32,FP,{CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F518,Exactly,7)},nil,nil)
        
        -- Void / 0x58F524 : Type / Void 1543 : Type Save / 0x58F520 : 공반 Check / Void 1547 : System / Delay : 90 -> 94 & 91->93 / Void 1545 Current Type
    CMov(FP,0x6509B0,FP)
            Trigger {
                players = {FP},
                conditions = {
                    CVar(FP,LevelT2[2],AtLeast,1);
                    Memory(0x58F518,AtLeast,1);
                },
                actions = {
                    SetMemory(0x58F518,SetTo,0);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
        
        
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    Void(1545,Exactly,1);
                },
                actions = {
                    SetCVar("X",XColor,SetTo,0);
                    PreserveTrigger();
                }
            }
    
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    Void(1545,Exactly,2);
                },
                actions = {
                    SetCVar("X",XColor,SetTo,1);
                    PreserveTrigger();
                }
            }
        
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    Void(1545,Exactly,3);
                },
                actions = {
                    SetCVar("X",XColor,SetTo,2);
                    PreserveTrigger();
                }
            }
        
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    Void(1545,Exactly,4);
                },
                actions = {
                    SetCVar("X",XColor,SetTo,3);
                    PreserveTrigger();
                }
            }
        
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    Void(1545,Exactly,5);
                },
                actions = {
                    SetCVar("X",XColor,SetTo,4);
                    PreserveTrigger();
                }
            }
        
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    Memory(0x58F520,AtLeast,1);
                },
                actions = {
                    SetMemory(0x58F520,SetTo,0);
                    SetCVar("X",XColor,SetTo,5);
                    PreserveTrigger();
                }
            }
    
        
        -- NM & HD-------------------		
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
                CVar(FP,LevelT2[2],AtLeast,1),
			},
			actions = {
				SetCVar("X",0x2001+VARI,SetTo,1);
				SetCVar("X",0x2002+VARI,SetTo,nilunit);
				SetCVar("X",0x2003+VARI,SetTo,1);
				PreserveTrigger();
			}
		}

        f_Read(FP,VO(95),B5_XY)
        f_Read(FP,VO(96),B5_YZ)
        f_Read(FP,VO(97),B5_ZX)
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CVar(FP,LevelT2[2],AtLeast,1),
            },
            actions = {
                SetNext("X",BCA);
                SetNext(BCA+1,"X",1);
                SetCVar("X",B5_V1[2],SetTo,1);
                SetCVar("X",B5_V2[2],SetTo,0);
            },
            flag = {Preserved}
        }
        Trigger {
            players = {FP},
            conditions = {
                Label(0);
                CVar(FP,LevelT2[2],AtLeast,1);
            },
            actions = {
                SetVoid(95,Add,360-7);
                SetVoid(96,Add,360-5);
                SetVoid(97,Add,360-4);
                SetVoid(94,Subtract,1);
                PreserveTrigger();
            }
        }
        
        
    ----------------------------------------------------------------------------------
    
        CIfX(FP,{Void(1547,Exactly,0)})
            CMod(FP,V(XType),_Rand(),24)
            
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,0)},
                actions = {
                    SetVoid(1543,SetTo,0x1234);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,1)},
                actions = {
                    SetVoid(1543,SetTo,0x1243);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,2)},
                actions = {
                    SetVoid(1543,SetTo,0x1324);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,3)},
                actions = {
                    SetVoid(1543,SetTo,0x1342);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,4)},
                actions = {
                    SetVoid(1543,SetTo,0x1423);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,5)},
                actions = {
                    SetVoid(1543,SetTo,0x1432);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,6)},
                actions = {
                    SetVoid(1543,SetTo,0x2134);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,7)},
                actions = {
                    SetVoid(1543,SetTo,0x2143);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,8)},
                actions = {
                    SetVoid(1543,SetTo,0x2314);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,9)},
                actions = {
                    SetVoid(1543,SetTo,0x2341);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,10)},
                actions = {
                    SetVoid(1543,SetTo,0x2413);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,11)},
                actions = {
                    SetVoid(1543,SetTo,0x2431);
                    PreserveTrigger();
                }
            }
            
            
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,12)},
                actions = {
                    SetVoid(1543,SetTo,0x3124);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,13)},
                actions = {
                    SetVoid(1543,SetTo,0x3142);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,14)},
                actions = {
                    SetVoid(1543,SetTo,0x3214);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,15)},
                actions = {
                    SetVoid(1543,SetTo,0x3241);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,16)},
                actions = {
                    SetVoid(1543,SetTo,0x3412);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,17)},
                actions = {
                    SetVoid(1543,SetTo,0x3421);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,18)},
                actions = {
                    SetVoid(1543,SetTo,0x4123);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,19)},
                actions = {
                    SetVoid(1543,SetTo,0x4132);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,20)},
                actions = {
                    SetVoid(1543,SetTo,0x4213);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,21)},
                actions = {
                    SetVoid(1543,SetTo,0x4231);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,22)},
                actions = {
                    SetVoid(1543,SetTo,0x4312);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Label(0),CVar("X",XType,Exactly,23)},
                actions = {
                    SetVoid(1543,SetTo,0x4321);
                    PreserveTrigger();
                }
            }
        
            Trigger {
                players = {FP},
                conditions = {Void(1547,Exactly,0)},
                actions = {
                    SetVoid(1547,SetTo,1);
                    PreserveTrigger();
                }
            }
        CElseIfX({Void(1547,Exactly,1)})
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,1*0x1,0xF)},
                actions = {
                    SetVoid(1545,SetTo,1);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,2*0x1,0xF)},
                actions = {
                    SetVoid(1545,SetTo,2);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,3*0x1,0xF)},
                actions = {
                    SetVoid(1545,SetTo,3);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,4*0x1,0xF)},
                actions = {
                    SetVoid(1545,SetTo,4);
                    PreserveTrigger();
                }
            }
            
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*5);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*4);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*3);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*2);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
        
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(1547,SetTo,2);
                    SetVoid(94,SetTo,0);
                    SetVoid(93,SetTo,0);
                    SetMemory(0x58F524,SetTo,0);
                    PreserveTrigger();
                }
            }
        CElseIfX({Void(1547,Exactly,2)})
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,1*0x10,0xF0)},
                actions = {
                    SetVoid(1545,SetTo,1);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,2*0x10,0xF0)},
                actions = {
                    SetVoid(1545,SetTo,2);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,3*0x10,0xF0)},
                actions = {
                    SetVoid(1545,SetTo,3);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,4*0x10,0xF0)},
                actions = {
                    SetVoid(1545,SetTo,4);
                    PreserveTrigger();
                }
            }
            
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*5);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*4);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*3);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*2);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
        
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(1547,SetTo,3);
                    SetVoid(94,SetTo,0);
                    SetVoid(93,SetTo,0);
                    SetMemory(0x58F524,SetTo,0);
                    PreserveTrigger();
                }
            }
        CElseIfX({Void(1547,Exactly,3)})
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,1*0x100,0xF00)},
                actions = {
                    SetVoid(1545,SetTo,1);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,2*0x100,0xF00)},
                actions = {
                    SetVoid(1545,SetTo,2);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,3*0x100,0xF00)},
                actions = {
                    SetVoid(1545,SetTo,3);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,4*0x100,0xF00)},
                actions = {
                    SetVoid(1545,SetTo,4);
                    PreserveTrigger();
                }
            }
            
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*5);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*4);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*3);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*2);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
        
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(1547,SetTo,4);
                    SetVoid(94,SetTo,0);
                    SetVoid(93,SetTo,0);
                    SetMemory(0x58F524,SetTo,0);
                    PreserveTrigger();
                }
            }
        CElseIfX({Void(1547,Exactly,4)})
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,1*0x1000,0xF000)},
                actions = {
                    SetVoid(1545,SetTo,1);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,2*0x1000,0xF000)},
                actions = {
                    SetVoid(1545,SetTo,2);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,3*0x1000,0xF000)},
                actions = {
                    SetVoid(1545,SetTo,3);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {VoidX(1543,Exactly,4*0x1000,0xF000)},
                actions = {
                    SetVoid(1545,SetTo,4);
                    PreserveTrigger();
                }
            }
            
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*5);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*4);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*3);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,24*2);
                    SetMemory(0x58F524,SetTo,5);
                    PreserveTrigger();
                }
            }
        
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(1543,SetTo,0);
                    SetVoid(1545,SetTo,5);
                    SetVoid(1547,SetTo,5);
                    SetVoid(94,SetTo,0);
                    SetVoid(93,SetTo,0);
                    SetMemory(0x58F524,SetTo,0);
                    PreserveTrigger();
                }
            }
        CElseIfX({Void(1547,Exactly,5)})
    
            
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetVoid(94,SetTo,24*4);
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetVoid(94,SetTo,24*3);
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetVoid(94,SetTo,24*2);
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetVoid(94,SetTo,24*1);
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
            
            
            
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,1)},
                actions = {
                    SetVoid(94,SetTo,18);
                    SetMemory(0x58F524,SetTo,2);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,2)},
                actions = {
                    SetVoid(94,SetTo,18);
                    SetMemory(0x58F524,SetTo,3);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,3)},
                actions = {
                    SetVoid(94,SetTo,18);
                    SetMemory(0x58F524,SetTo,4);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
        
        
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],AtMost,3),Void(94,Exactly,0),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,72);
                    SetMemory(0x58F524,SetTo,5);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(94,Exactly,0),Memory(0x58F524,Exactly,4)},
                actions = {
                    SetVoid(94,SetTo,18);
                    SetMemory(0x58F524,SetTo,99);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(94,Exactly,0),Memory(0x58F524,Exactly,99)},
                actions = {
                    SetVoid(94,SetTo,72);
                    SetMemory(0x58F524,SetTo,5);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(94,SetTo,24*5);
                    SetMemory(0x58F524,SetTo,6);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(94,SetTo,24*4);
                    SetMemory(0x58F524,SetTo,6);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(94,SetTo,24*3);
                    SetMemory(0x58F524,SetTo,6);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(94,Exactly,0),Memory(0x58F524,Exactly,5)},
                actions = {
                    SetVoid(94,SetTo,24*2);
                    SetMemory(0x58F524,SetTo,6);
                    SetMemoryX(0x57EF30,SetTo,1,0xFF);
                    RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64);
                    PreserveTrigger();
                }
            }
        
            Trigger {
                players = {FP},
                conditions = {Void(94,Exactly,0),Memory(0x58F524,Exactly,6)},
                actions = {
                    SetVoid(1543,SetTo,0);
                    SetVoid(1545,SetTo,0);
                    SetVoid(1547,SetTo,0);
                    SetVoid(94,SetTo,0);
                    SetVoid(93,SetTo,0);
                    SetMemory(0x58F524,SetTo,0);
                    PreserveTrigger();
                }
            }
        
        CIfXEnd()
        
        
        -- void 91 : 소환 Delay / 0x58F490 : 패턴 System
        CIf(FP,{Void(1545,AtLeast,1),Void(1545,AtMost,4),Void(94,Exactly,0),TMemory(0x58F524,Exactly,0)})
            f_Read(FP,0x58DC60+0*0x14,V(0x1FE0))
            f_Read(FP,0x58DC64+0*0x14,V(0x1FE1))
            CAdd(FP,V(0x1FE0),56)
            CAdd(FP,V(0x1FE1),48)
            CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE2),V(0x1FE0))),
                            TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE3),V(0x1FE1))),
                            TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE2),V(0x1FE0))),
                            TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE3),V(0x1FE1))),
                            CreateUnit(1,84,"CLoc165",FP),
                            TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE4),V(0x1FE0))),
                            TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE5),V(0x1FE1))),
                            TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE4),V(0x1FE0))),
                            TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE5),V(0x1FE1))),
                            CreateUnit(1,84,"CLoc165",FP),
                            TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE6),V(0x1FE0))),
                            TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE7),V(0x1FE1))),
                            TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE6),V(0x1FE0))),
                            TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE7),V(0x1FE1))),
                            CreateUnit(1,84,"CLoc165",FP),
                            TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE8),V(0x1FE0))),
                            TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE9),V(0x1FE1))),
                            TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE8),V(0x1FE0))),
                            TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE9),V(0x1FE1))),
                            CreateUnit(1,84,"CLoc165",FP),
                            SetInvincibility(Enable,84,FP,"Anywhere");
                            
            }) -- #인셉
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,AtLeast,1),Void(1545,AtMost,4)},
                actions = {
                    SetVoid(94,SetTo,12);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,AtLeast,1),Void(1545,AtMost,4)},
                actions = {
                    SetVoid(94,SetTo,7);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,AtLeast,1),Void(1545,AtMost,4)},
                actions = {
                    SetVoid(94,SetTo,5);
                    PreserveTrigger();
                }
            }
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,AtLeast,1),Void(1545,AtMost,4)},
                actions = {
                    SetVoid(94,SetTo,5);
                    PreserveTrigger();
                }
            }
        CIfEnd()
        
        
    
        CIf(FP,{Void(1545,Exactly,5),Void(94,Exactly,1),TTOR({TTAND({Memory(0x58F524,Atleast,1),Memory(0x58F524,Atmost,5)}),Memory(0x58F524,Exactly,99)})},{SetCVar("X",0x2300,SetTo,0)})
            f_Read(FP,0x58DC60+0*0x14,V(0x1FE0))
            f_Read(FP,0x58DC64+0*0x14,V(0x1FE1))
            CAdd(FP,V(0x1FE0),56)
            CAdd(FP,V(0x1FE1),48)
            
            NWhile(FP,{CVar("X",0x2300,AtMost,11)})
                CIfX(FP,CVar("X",0x2300,Exactly,0))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE2),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE3),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE2),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE3),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,1))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE4),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE5),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE4),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE5),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,2))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE6),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE7),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE6),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE7),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,3))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x1FE8),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x1FE9),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x1FE8),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x1FE9),V(0x1FE1)))})
                                
                CElseIfX(CVar("X",0x2300,Exactly,4))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22F2),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22F3),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22F2),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22F3),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,5))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22F4),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22F5),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22F4),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22F5),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,6))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22F6),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22F7),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22F6),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22F7),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,7))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22F8),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22F9),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22F8),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22F9),V(0x1FE1)))})
                                
                CElseIfX(CVar("X",0x2300,Exactly,8))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22E2),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22E3),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22E2),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22E3),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,9))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22E4),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22E5),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22E4),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22E5),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,10))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22E6),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22E7),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22E6),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22E7),V(0x1FE1)))})
                CElseIfX(CVar("X",0x2300,Exactly,11))
                    CDoActions(FP,{TSetLoc("CLoc165",0,SetTo,_Add(V(0x22E8),V(0x1FE0))),
                                    TSetLoc("CLoc165",4,SetTo,_Add(V(0x22E9),V(0x1FE1))),
                                    TSetLoc("CLoc165",8,SetTo,_Add(V(0x22E8),V(0x1FE0))),
                                    TSetLoc("CLoc165",12,SetTo,_Add(V(0x22E9),V(0x1FE1)))})
                CIfXEnd()
                            
            NJump(FP,0x606,{CVar("X",0x2300,AtLeast,4),Memory(0x58F51C,AtMost,0)})
            NJump(FP,0x607,{CVar("X",0x2300,AtLeast,8),Memory(0x58F51C,AtMost,1)})
                
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,5),Memory(0x58F524,Exactly,1)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,47,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,5),Memory(0x58F524,Exactly,2)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,55,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,5),Memory(0x58F524,Exactly,3)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,44,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,5),Memory(0x58F524,Exactly,4)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,57,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,5),Memory(0x58F524,Exactly,5)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,62,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
        
        
        
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,5),Memory(0x58F524,Exactly,1)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,80,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,5),Memory(0x58F524,Exactly,2)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,98,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,5),Memory(0x58F524,Exactly,3)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,71,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,5),Memory(0x58F524,Exactly,4)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,69,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,5),Memory(0x58F524,Exactly,5)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    --CreateUnitWithProperties(1,121,"CLoc165",FP,{
                    --    clocked = false,
                    --    burrowed = false,
                    --    intransit = false,
                    --    hallucinated = false,
                    --    invincible = false,
                    --    hitpoint = 0,
                    --    shield = 100,
                    --    energy = 0,
                    --    resource = 0,
                    --    hanger = 0,
                    --});
                   -- 
                    PreserveTrigger();
                }
            }
    
        
        
        
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,5),Memory(0x58F524,Exactly,1)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    --CreateUnit(1,1,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,5),Memory(0x58F524,Exactly,2)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    --CreateUnit(1,58,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,5),Memory(0x58F524,Exactly,3)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    --CreateUnit(1,11,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,5),Memory(0x58F524,Exactly,4)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    --CreateUnitWithProperties(1,27,"CLoc165",FP,{
                    --    clocked = false,
                    --    burrowed = false,
                    --    intransit = false,
                    --    hallucinated = false,
                    --    invincible = false,
                    --    hitpoint = 0,
                    --    shield = 100,
                    --    energy = 0,
                    --    resource = 0,
                    --    hanger = 0,
                    --});
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,5),Memory(0x58F524,Exactly,5)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    --CreateUnitWithProperties(1,121,"CLoc165",FP,{
                    --    clocked = false,
                    --    burrowed = false,
                    --    intransit = false,
                    --    hallucinated = false,
                    --    invincible = false,
                    --    hitpoint = 100,
                    --    shield = 100,
                    --    energy = 0,
                    --    resource = 0,
                    --    hanger = 0,
                    --});
                    
                    PreserveTrigger();
                }
            }
    
        
        
        
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,5),Memory(0x58F524,Exactly,1)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,28,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,5),Memory(0x58F524,Exactly,2)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,8,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,5),Memory(0x58F524,Exactly,3)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,22,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
    
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,5),Memory(0x58F524,Exactly,4)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,102,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
            
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,5),Memory(0x58F524,Exactly,99)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    CreateUnit(1,27,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
        
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,5),Memory(0x58F524,Exactly,5)},
                actions = {
                    CreateUnit(1,94,"CLoc165",FP),
                    KillUnit(94,FP);
                    --CreateUnit(1,121,"CLoc165",FP),
                    
                    PreserveTrigger();
                }
            }
        
            NWhileEnd(SetCVar("X",0x2300,Add,1))
            
            NJumpEnd(FP,0x606)
            NJumpEnd(FP,0x607)
    
        CIfEnd()
        
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,AtLeast,1),Void(1545,AtMost,4),Command(FP,AtLeast,300,84),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,AtLeast,1),Void(1545,AtMost,4),Command(FP,AtLeast,400,84),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,AtLeast,1),Void(1545,AtMost,4),Command(FP,AtLeast,500,84),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,AtLeast,1),Void(1545,AtMost,4),Command(FP,AtLeast,600,84),Memory(0x58F524,Exactly,0)},
                actions = {
                    SetMemory(0x58F524,SetTo,1);
                    PreserveTrigger();
                }
            }
        
        
        Trigger {
                players = {FP},
                conditions = {Void(1545,AtLeast,1),Void(1545,AtMost,4),Memory(0x58F524,AtLeast,0),Memory(0x58F524,AtMost,1)},
                actions = {
                    Order(84,FP, 64,Move,"Location 1");
                    PreserveTrigger();
                }
            }
    
        Trigger {
                players = {FP},
                conditions = {Void(1545,AtLeast,1),Void(1545,AtMost,4),Memory(0x58F524,Exactly,1)},
                actions = {
                    SetVoid(93,Add,1);
                    PreserveTrigger();
                }
            }
        
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,1),Void(1545,AtLeast,1),Void(1545,AtMost,4),Memory(0x58F524,Exactly,1),Void(93,AtLeast,24*12)},
                actions = {
                    SetMemory(0x58F524,SetTo,2);
                    SetVoid(93,SetTo,0);
                    PreserveTrigger();
                }
            }
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,2),Void(1545,AtLeast,1),Void(1545,AtMost,4),Memory(0x58F524,Exactly,1),Void(93,AtLeast,24*8)},
                actions = {
                    SetMemory(0x58F524,SetTo,2);
                    SetVoid(93,SetTo,0);
                    PreserveTrigger();
                }
            }
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,3),Void(1545,AtLeast,1),Void(1545,AtMost,4),Memory(0x58F524,Exactly,1),Void(93,AtLeast,24*4)},
                actions = {
                    SetMemory(0x58F524,SetTo,2);
                    SetVoid(93,SetTo,0);
                    PreserveTrigger();
                }
            }
        Trigger {
                players = {FP},
                conditions = {
                    Label(0);CVar(FP,LevelT2[2],Exactly,4),Void(1545,AtLeast,1),Void(1545,AtMost,4),Memory(0x58F524,Exactly,1),Void(93,AtLeast,24*0.4)},
                actions = {
                    SetMemory(0x58F524,SetTo,2);
                    SetVoid(93,SetTo,0);
                    PreserveTrigger();
                }
            }
    
    
        
        
    ----------------------------------------------------------------------------------
    
    
        
        
        
        
        
        
        
        
        
        DoActions(FP,{
            SetLoc("Location 1",0x4,SetTo,0);
            SetLoc("Location 1",0x0,SetTo,0);
            SetLoc("Location 1",0xC,SetTo,0);
            SetLoc("Location 1",0x8,SetTo,0);
            MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere")})
    
        local RW1 = {336,352,368,384} -- Black
        local RW2 = {384*2,384*2,384*2,384*2}
        for j = 1, 4 do
            for i = 0, 30 do
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    CVar(FP,LevelT2[2],Exactly,j);
                    Void(1545,Exactly,1);
                    Memory(0x58F524,Exactly,3);
                },
                actions = {
                    SetLoc("Location 1",0x0,Add,RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0x4,Add,RW2[j]);
                    SetLoc("Location 1",0x8,Add,RW2[j]);
                    SetLoc("Location 1",0xC,Add,RW1[j]*math.sin(math.rad(3*i)));
                    KillUnitAt(All,84,"Location 1",FP);
                    SetLoc("Location 1",0x0,Add,-RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0x4,Add,-RW2[j]);
                    SetLoc("Location 1",0x8,Add,-RW2[j]);
                    SetLoc("Location 1",0xC,Add,-RW1[j]*math.sin(math.rad(3*i)));
    
                    SetLoc("Location 1",0x0,Add,-RW2[j]);
                    SetLoc("Location 1",0x4,Add,RW2[j]);
                    SetLoc("Location 1",0x8,Add,-RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0xC,Add,RW1[j]*math.sin(math.rad(3*i)));
                    KillUnitAt(All,84,"Location 1",FP);
                    SetLoc("Location 1",0x0,Add,RW2[j]);
                    SetLoc("Location 1",0x4,Add,-RW2[j]);
                    SetLoc("Location 1",0x8,Add,RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0xC,Add,-RW1[j]*math.sin(math.rad(3*i)));
                    
                    SetLoc("Location 1",0x0,Add,-RW2[j]);
                    SetLoc("Location 1",0x4,Add,-RW1[j]*math.sin(math.rad(3*i)));
                    SetLoc("Location 1",0x8,Add,-RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0xC,Add,-RW2[j]);
                    KillUnitAt(All,84,"Location 1",FP);
                    SetLoc("Location 1",0x0,Add,RW2[j]);
                    SetLoc("Location 1",0x4,Add,RW1[j]*math.sin(math.rad(3*i)));
                    SetLoc("Location 1",0x8,Add,RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0xC,Add,RW2[j]);
                
                    SetLoc("Location 1",0x0,Add,RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0x4,Add,-RW1[j]*math.sin(math.rad(3*i)));
                    SetLoc("Location 1",0x8,Add,RW2[j]);
                    SetLoc("Location 1",0xC,Add,-RW2[j]);
                    KillUnitAt(All,84,"Location 1",FP);
                    SetLoc("Location 1",0x0,Add,-RW1[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0x4,Add,RW1[j]*math.sin(math.rad(3*i)));
                    SetLoc("Location 1",0x8,Add,-RW2[j]);
                    SetLoc("Location 1",0xC,Add,RW2[j]);
                    PreserveTrigger();
                }
            }
            end
        end
        
        
        local RB = {208,192,176,160} -- White
        for j = 1, 4 do
            for i = 0, 30 do
            Trigger {
                players = {FP},
                conditions = {
                    Label(0);
                    CVar(FP,LevelT2[2],Exactly,j);
                    Void(1545,Exactly,2);
                    Memory(0x58F524,Exactly,3);
                },
                actions = {
                    SetLoc("Location 1",0x0,Add,-RB[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0x4,Add,-RB[j]*math.sin(math.rad(3*i)));
                    SetLoc("Location 1",0x8,Add,RB[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0xC,Add,RB[j]*math.sin(math.rad(3*i)));
                    KillUnitAt(All,84,"Location 1",FP);
                    SetLoc("Location 1",0x0,Add,RB[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0x4,Add,RB[j]*math.sin(math.rad(3*i)));
                    SetLoc("Location 1",0x8,Add,-RB[j]*math.cos(math.rad(3*i)));
                    SetLoc("Location 1",0xC,Add,-RB[j]*math.sin(math.rad(3*i)));
                    PreserveTrigger();
                }
            }
            end
        end
        
        local RR = {176,160,144,128}
        CIfX(FP,{CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,3),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384))  -- XTemp << Sec/60 * 384 - 384
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[1]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[1]));
                TSetLoc("Location 1",0xC,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,3),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[2]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[2]));
                TSetLoc("Location 1",0xC,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,3),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[3]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[3]));
                TSetLoc("Location 1",0xC,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,3),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[4]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[4]));
                TSetLoc("Location 1",0xC,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CIfXEnd()
        
        CIfX(FP,{CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,4),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[1]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[1]));
                TSetLoc("Location 1",0x8,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,4),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[2]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[2]));
                TSetLoc("Location 1",0x8,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,4),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[3]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[3]));
                TSetLoc("Location 1",0x8,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,4),Memory(0x58F524,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[4]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[4]));
                TSetLoc("Location 1",0x8,Add,384*2);
                KillUnitAt(All,84,"Location 1",FP);
                })
        CIfXEnd()
        
        --[[
        -- Test
        CIfX(FP,{CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[1]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[1]));
                TSetLoc("Location 1",0xC,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[2]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[2]));
                TSetLoc("Location 1",0xC,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[3]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[3]));
                TSetLoc("Location 1",0xC,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,3)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x0,Add,Vi(XTemp,-RR[4]));
                TSetLoc("Location 1",0x4,Add,-384*2);
                TSetLoc("Location 1",0x8,Add,Vi(XTemp,RR[4]));
                TSetLoc("Location 1",0xC,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CIfXEnd()
        
        
        CIfX(FP,{CVar(FP,LevelT2[2],Exactly,1),Void(1545,Exactly,4)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[1]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[1]));
                TSetLoc("Location 1",0x8,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,2),Void(1545,Exactly,4)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[2]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[2]));
                TSetLoc("Location 1",0x8,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,3),Void(1545,Exactly,4)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[3]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[3]));
                TSetLoc("Location 1",0x8,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CElseIfX({CVar(FP,LevelT2[2],Exactly,4),Void(1545,Exactly,4)})
            CMov(FP,V(XTemp),_iSub(_Div(_Mul(V(0x2000),384*2),360),384)) 
            CDoActions(FP,{
                SetLoc("Location 1",0x4,SetTo,0);
                SetLoc("Location 1",0x0,SetTo,0);
                SetLoc("Location 1",0xC,SetTo,0);
                SetLoc("Location 1",0x8,SetTo,0);
                MoveLocation("Location 1", "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",FP,"Anywhere");	
                TSetLoc("Location 1",0x4,Add,Vi(XTemp,-RR[4]));
                TSetLoc("Location 1",0x0,Add,-384*2);
                TSetLoc("Location 1",0xC,Add,Vi(XTemp,RR[4]));
                TSetLoc("Location 1",0x8,Add,384*2);
                CreateUnit(1,94,"Location 1",FP);
                KillUnitAt(All,94,"Location 1",FP);
                })
        CIfXEnd()
        ]]--
        
    CElseIfX({CVar(FP,VResetSw[2],Exactly,0),Bring(FP,AtMost,0, "。˙+˚roka7。+.˚。˙+˚roka7。+.˚     ",64)},SetCVar(FP,VResetSw[2],SetTo,1))
    DoActionsX(FP,{KillUnit(84,FP),SetCDeaths(FP,Add,1,rokaClear)})
    roka7ResetTable = {}

    
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE9,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE8,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE7,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE6,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE5,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE4,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE3,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE2,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE1,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,0x1FE0,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,B5_V1[2],SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,B5_V2[2],SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,XColor,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,XType,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,XTemp,SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,B5_XY[2],SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,B5_YZ[2],SetTo,0))
    table.insert(roka7ResetTable,SetCVar(FP,B5_ZX[2],SetTo,0))
    for i = 0x2000, 0x2300 do
        table.insert(roka7ResetTable,SetCVar(FP,i,SetTo,0))
    end
    for i = 0, 2000 do
    table.insert(roka7ResetTable,(SetVoid(i,SetTo,0)))
    end
    DoActions2X(FP,roka7ResetTable)

    CIfXEnd()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    for i = 0, 1699 do
        Trigger2(FP,{
            DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
            DeathsX(19025+(84*i)+25,AtLeast,203,0,0xFF),
            DeathsX(19025+(84*i)+25,AtMost,204,0,0xFF),
        },{
            SetDeathsX(19025+(84*i)+55,SetTo,0x200104,0,0x300104),
            SetDeaths(19025+(84*i)+57,SetTo,0,0),
        },{Preserved})
    end
    
    
    
    
    
    Trigger {
        players = {FP},
        conditions = {Command(FP,AtLeast,1,203)},
        actions = {SetInvincibility(Enable,203,FP,"Anywhere");},
        flag = {Preserved}
    }
    Trigger {
        players = {FP},
        conditions = {Command(FP,AtLeast,1,204)},
        actions = {SetInvincibility(Enable,204,FP,"Anywhere");},
        flag = {Preserved}
    }
    Trigger {
        players = {FP},
        conditions = {Command(FP,AtLeast,1,209)},
        actions = {SetInvincibility(Enable,209,FP,"Anywhere");},
        flag = {Preserved}
    }
end
