
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

--↓ Tep에 그대로 붙여넣기 -----------------------------------------------------------------

PatchStack = {}
UnitSizePatch(0,1,PatchStack)

DoActions2(P1,PatchStack,1)--유닛크기변경
FP = P8
SetForces({P1},{P2,P3,P4,P5,P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P1)
StartCtrig(1,AllPlayers,nil,1,"C:\\Users\\whatd\\Desktop\\Ctrig Assembler v5.4\\TestMap\\CtrigAsm\\CGRP Image")
CJump(AllPlayers,0x9FF)
Include_CtrigPlib(360,"Switch 1")
Include_64BitLibrary("Switch 1")
Include_CBPaint()
TempPtrVoid = f_GetVoidptr(FP,1700*16)
TempPtr = CreateVar(FP)
CJumpEnd(AllPlayers,0x9FF)
--↓ 이곳에 예제를 붙여넣기 (예제에 Include_CtrigPlib가 존재하는경우 삭제) ----------------------

DoActions(P1,SetMemory(0x58F448,SetTo,0x25)) -- Debug.py 세팅
S1 = CS_FillXY({1,1},256,256,32,32) 
DoActions(P1,{RemoveUnit(0,P1)}) 
X, Y, Z = CreateVars(3,P1) 
DoActionsX(P1,{SetNVar(X,Add,2),SetNVar(Y,Add,-1),SetNVar(Z,Add,1)}) 
TriggerX(P1,Memory(0x58F45C,Exactly,1) 
,{SetNVar(X,SetTo,0),SetNVar(Y,SetTo,0),SetNVar(Z,SetTo,0)},{PReserved})
function func1() 
 CIfX(P1,Memory(0x58F454,Exactly,0)) 
 CB_Move(X,Y,1,2) 
 CElseX()
 CB_MoveCenter(_Read(0x57F0F0),_Read(0x57F120),1,2) 
 CIfXEnd()
end 
CBPlot({S1,CS_InputVoid(S1[1])},nil,P1,0,81,nil,1,32 
,{2,0,0,0,S1[1],0},nil,"func1",P1,Memory(0x58F450,Exactly,0),nil,1) 
function func2() 
 CIfX(P1,Memory(0x58F458,Exactly,0)) 
 CB_Move(Z,0,1,2) -- R+=1 
 CElseX()
 CB_Move(0,Z,1,2) -- A+=1 
 CIfXEnd()
 CB_ConvertXY(2,3) -- XY모드로 복구
end 
CBPlot({CS_ConvertRA(S1),CS_InputVoid(S1[1]),CS_InputVoid(S1[1])},nil,P1,0,81,nil,1,32 
,{3,0,0,0,S1[1],0},nil,"func2",P1,Memory(0x58F450,Exactly,1),nil,1) 
function func3() 
 CB_MoveCenter(X,Y,1,2) -- 중심을 0,0에서 떨어트림
 CB_ConvertRA(2,3) -- RA모드 전환
 CB_Move(0,Z,3,2) -- 회전
 CB_ConvertXY(2,3) -- XY모드로 복구
end 
CBPlot({S1,CS_InputVoid(S1[1]),CS_InputVoid(S1[1])},nil,P1,0,81,nil,1,32 
,{3,0,0,0,S1[1],0},nil,"func3",P1,Memory(0x58F450,Exactly,2),nil,1)

--↑ 이곳에 예제를 붙여넣기 -----------------------------------------------------------------
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 22");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 22","Location 28");
		SetResources(P1,SetTo,0,Ore);
		PreserveTrigger();
	}
}
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 23");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 23","Location 28");
		SetResources(P1,Add,1,Ore);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 24"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 24","Location 28"))
	CMov(P1,0x57f0f0,_Mul(_Read(0x57f0f0),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 25"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 25","Location 28"))
	CMov(P1,0x57f0f0,_Neg(_Read(0x57f0f0)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 26"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 26","Location 28"))
	CMov(P1,0x57f0f0,_Div(_Read(0x57f0f0),2))
CIfEnd()
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 27");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 27","Location 28");
		SetResources(P1,Add,-1,Ore);
		PreserveTrigger();
	}
}




Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 29");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 29","Location 35");
		SetResources(P1,SetTo,0,Gas);
		PreserveTrigger();
	}
}
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 30");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 30","Location 35");
		SetResources(P1,Add,1,Gas);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 31"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 31","Location 35"))
	CMov(P1,0x57f120,_Mul(_Read(0x57f120),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 32"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 32","Location 35"))
	CMov(P1,0x57f120,_Neg(_Read(0x57f120)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 33"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 33","Location 35"))
	CMov(P1,0x57f120,_Div(_Read(0x57f120),2))
CIfEnd()
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 34");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 34","Location 35");
		SetResources(P1,Add,-1,Gas);
		PreserveTrigger();
	}
}

Trigger {
	players = {P1},
	conditions = {
		Label(0);
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 39");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 39","Location 45");
		SetMemory(0x58F480,SetTo,0);
		SetMemory(0x58F484,SetTo,0);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 40"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 40","Location 45"))
	f_LMov(P1,0x58F480,_LAdd(_LRead(0x58F480),1))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 41"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 41","Location 45"))
	f_LMov(P1,0x58F480,_LMul(_LRead(0x58F480),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 42"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 42","Location 45"))
	f_LMov(P1,0x58F480,_LNeg(_LRead(0x58F480)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 43"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 43","Location 45"))
	f_LMov(P1,0x58F480,_LDiv(_LRead(0x58F480),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 44"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 44","Location 45"))
	f_LMov(P1,0x58F480,_LAdd(_LRead(0x58F480),"0xFFFFFFFFFFFFFFFF"))
CIfEnd()

Trigger {
	players = {P1},
	conditions = {
		Label(0);
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 46");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 46","Location 52");
		SetMemory(0x58F488,SetTo,0);
		SetMemory(0x58F48C,SetTo,0);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 47"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 47","Location 52"))
	f_LMov(P1,0x58F488,_LAdd(_LRead(0x58F488),1))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 48"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 48","Location 52"))
	f_LMov(P1,0x58F488,_LMul(_LRead(0x58F488),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 49"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 49","Location 52"))
	f_LMov(P1,0x58F488,_LNeg(_LRead(0x58F488)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 50"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 50","Location 52"))
	f_LMov(P1,0x58F488,_LDiv(_LRead(0x58F488),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 51"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 51","Location 52"))
	f_LMov(P1,0x58F488,_LAdd(_LRead(0x58F488),"0xFFFFFFFFFFFFFFFF"))
CIfEnd()

Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 53");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 53","Location 59");
		SetMemory(0x58F4C0,SetTo,0);
		PreserveTrigger();
	}
}
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 54");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 54","Location 59");
		SetMemory(0x58F4C0,Add,1);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 55"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 55","Location 59"))
	CMov(P1,0x58F4C0,_Mul(_Read(0x58F4C0),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 56"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 56","Location 59"))
	CMov(P1,0x58F4C0,_Neg(_Read(0x58F4C0)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 57"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 57","Location 59"))
	CMov(P1,0x58F4C0,_Div(_Read(0x58F4C0),2))
CIfEnd()
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 58");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 58","Location 59");
		SetMemory(0x58F4C0,Add,-1);
		PreserveTrigger();
	}
}

Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 60");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 60","Location 67");
		SetMemory(0x58F4C4,SetTo,0);
		PreserveTrigger();
	}
}
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 61");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 61","Location 67");
		SetMemory(0x58F4C4,Add,1);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 62"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 62","Location 67"))
	CMov(P1,0x58F4C4,_Mul(_Read(0x58F4C4),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 63"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 63","Location 67"))
	CMov(P1,0x58F4C4,_Neg(_Read(0x58F4C4)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 65"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 65","Location 67"))
	CMov(P1,0x58F4C4,_Div(_Read(0x58F4C4),2))
CIfEnd()
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 66");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 66","Location 67");
		SetMemory(0x58F4C4,Add,-1);
		PreserveTrigger();
	}
}

Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 68");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 68","Location 74");
		SetMemory(0x58F4C8,SetTo,0);
		PreserveTrigger();
	}
}
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 69");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 69","Location 74");
		SetMemory(0x58F4C8,Add,1);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 70"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 70","Location 74"))
	CMov(P1,0x58F4C8,_Mul(_Read(0x58F4C8),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 71"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 71","Location 74"))
	CMov(P1,0x58F4C8,_Neg(_Read(0x58F4C8)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 72"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 72","Location 74"))
	CMov(P1,0x58F4C8,_Div(_Read(0x58F4C8),2))
CIfEnd()
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 73");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 73","Location 74");
		SetMemory(0x58F4C8,Add,-1);
		PreserveTrigger();
	}
}

Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 75");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 75","Location 81");
		SetMemory(0x58F4CC,SetTo,0);
		PreserveTrigger();
	}
}
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 76");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 76","Location 81");
		SetMemory(0x58F4CC,Add,1);
		PreserveTrigger();
	}
}
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 77"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 77","Location 81"))
	CMov(P1,0x58F4CC,_Mul(_Read(0x58F4CC),2))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 78"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 78","Location 81"))
	CMov(P1,0x58F4CC,_Neg(_Read(0x58F4CC)))
CIfEnd()
CIf(P1,Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 79"),MoveUnit(1,"Devouring One (Zergling)",P1,"Location 79","Location 81"))
	CMov(P1,0x58F4CC,_Div(_Read(0x58F4CC),2))
CIfEnd()
Trigger {
	players = {P1},
	conditions = {
		Bring(P1,Exactly,1,"Devouring One (Zergling)","Location 80");
	},
	actions = {
		MoveUnit(1,"Devouring One (Zergling)",P1,"Location 80","Location 81");
		SetMemory(0x58F4CC,Add,-1);
		PreserveTrigger();
	}
}

Trigger { -- No comment (B3442EB7)
	players = {P1},
	conditions = {
		Always();
	},
	actions = {
		CreateUnit(1, "Zerg Broodling", "broodling", P1);
		SetMemoryX(0x58F448,SetTo,255,255);
	},
}
Trigger { -- No comment (EC7DF1DE)
	players = {P2},
	conditions = {
		Never();
	},
	actions = {
		RunAIScriptAt("Expansion Terran Campaign Difficult", "town");
	},
}
Trigger { -- No comment (3775A93C)
	players = {P1},
	conditions = {
		Always();
	},
	actions = {
		RunAIScriptAt("Enter Closest Bunker", "Banker0");
		RunAIScriptAt("Enter Closest Bunker", "Banker1");
	},
}
Trigger { -- No comment (43CD0280)
	players = {P1},
	conditions = {
		Bring(P1, AtLeast, 1, "Men", "HEAL");
	},
	actions = {
		ModifyUnitEnergy(All, "Men", P1, "HEAL", 100);
		ModifyUnitHitPoints(All, "Men", P1, "HEAL", 100);
		ModifyUnitShields(All, "Men", P1, "HEAL", 100);
		PreserveTrigger();
	},
}



EUDTurbo(P1)
EndCtrig()
ErrorCheck()
--↑ Tep에 그대로 붙여넣기 -----------------------------------------------------------------