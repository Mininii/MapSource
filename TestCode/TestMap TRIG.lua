
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

--�� Tep�� �״�� �ٿ��ֱ� -----------------------------------------------------------------


FP = P1
SetForces({P1},{P2,P3,P4,P5,P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P1)
StartCtrig(1,AllPlayers,nil,1,"C:\\Temp")
CJump(AllPlayers,0x9FF)
Include_CtrigPlib(360,"Switch 1")
Include_64BitLibrary("Switch 1")
Include_CBPaint()
CJumpEnd(AllPlayers,0x9FF)
--�� �̰��� ������ �ٿ��ֱ� (������ Include_CtrigPlib�� �����ϴ°�� ����) ----------------------
CJump(AllPlayers,0) 
iStrSize2 = GetiStrSize(0,"0000000000 \x04/ 0000000000 \x04(\x1C000.0%\x04)")
iStrSize3 = GetiStrSize(0,"0000000000 \x1C/ 0000000000 \x1F(\x1F000.0%\x04)")
S1 = MakeiTblString(1501,"None",'None',MakeiStrLetter("\x0D",iStrSize2+5),"Base",1) -- ����Ű����
S2 = MakeiTblString(831,"None",'None',MakeiStrLetter("\x0D",iStrSize3+5),"Base",1) -- ����Ű����
-- �� TBLString.txt���� == ���̿� ����ִ� �ؽ�Ʈ�� �״�� �����ؼ� 
-- EUDEditor2,3�� 372�� TBL��Ʈ���� �ٿ��ְ� �ش� tbl������ �ʿ� �����ؾ���
iTbl1 = GetiTblId(P1,1501,S1) 
iTbl2 = GetiTblId(P1,831,S2) 
Str3, Str3a, Str3s = SaveiStrArr(P1,"0000000000 \x04/ 0000000000 \x04(\x1C000.0%\x04)")



SelPTR = CreateVar(FP)
SelHP = CreateVar(FP)
SelPl = CreateVar(FP)
SelUID = CreateVar(FP)
SelEPD = CreateVar(FP)
SelSh = CreateVar(FP)
SelPl = CreateVar(FP)
B1_H = CreateVar(FP)
SelMaxHP= CreateVar(FP)
B1_K= CreateVar(FP)
TBLNUM= CreateVar(FP)

TBLLoad = SetCallForward()
SetCall(FP)
function HPBar() 
	local PlayerID = CAPrintPlayerID 
	CA__ItoCustom(SVA1(Str3,12),SelMaxHP,nil,0xFFFF0000,10,1,"\x0D",nil,nil,{0,1,2,3,4,5,6,7,8,9}) 
	CA__ItoCustom(SVA1(Str3,0),SelHP,nil,0xFFFF0000,10,1,"\x0D",nil,nil,{0,1,2,3,4,5,6,7,8,9}) 
	CA__ItoCustom(SVA1(Str3,0),SelSh,nil,0xFFFF0000,{10,4},1,{"\x0D","0","0"},nil,nil,{25,26,27,29}) 
	
	
	--CA__InputSVA1(SVA1(Str2,1),SVA1(Str1,A),12,0xFF,1,12) 
	--CA__InputSVA1(SVA1(Str2,13),SVA1(Str0,C),6,0xFF,13,18) 
	CA__InputVA(0,Str3,Str3s,nil,0,31) 
   end 
   CBPrint({iTbl1,iTbl2},{TBLNUM,0,0,0,1},"HPBar",P1) --
SetCallEnd()


CJumpEnd(AllPlayers,0) 
DoActions(P1,DisplayText(MakeiStrWord("\r\n",11),4)) 
DoActions(P1,{CreateUnit(1,"Kakaru (Twilight)","Anywhere",P1),RemoveUnitAt(1,"Kakaru (Twilight)","Anywhere",P1)}) -- TBL Refresh 
CIf(FP,{Memory(0x6284B8 ,AtLeast,1),Memory(0x6284B8 + 4,AtMost,0)}) -- ü��ǥ��
f_Read(FP,0x6284B8,SelPTR,SelEPD)
f_Read(FP,_Add(SelEPD,2),SelHP)
f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
f_Read(FP,_Add(SelEPD,25),SelUID,"X",0xFF)
f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
CMov(FP,SelMaxHP,_Div(_ReadF(_Add(SelUID,_Mov(EPD(0x662350)))),_Mov(256)))
CTrigger(FP,{CVar(FP,SelPl[2],Exactly,7),CVar(FP,B1_H[2],AtLeast,1)},{TSetCVar(FP,SelHP[2],Add,B1_K)},1)
f_Div(FP,SelHP,_Mov(256))
f_Div(FP,SelSh,_Mov(256))
CallTrigger(FP,TBLLoad,{SetV(TBLNUM,1)})
CallTrigger(FP,TBLLoad,{SetV(TBLNUM,2)})
CIfEnd()



--------------------------------------
--�� �̰��� ������ �ٿ��ֱ� -----------------------------------------------------------------
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
		--SetMemoryX(0x58F448,SetTo,255,255);
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
--�� Tep�� �״�� �ٿ��ֱ� -----------------------------------------------------------------