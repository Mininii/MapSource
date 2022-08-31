
LD2XOption = 1
if LD2XOption == 1 then
	Mapdir="C:\\euddraft0.9.2.0\\TestMap"
	__StringArray = {}
	__TRIGChkptr = io.open(Mapdir.."__TRIG.chk", "wb")
	Loader2XFName = "Loader.lua"
else
	Loader2XFName = "Loader2X.lua"
end


EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= Loader2XFName then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

--↓ Tep에 그대로 붙여넣기 -----------------------------------------------------------------


FP = P1
SetForces({P1},{P2,P3,P4,P5,P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P1)
StartCtrig(1,AllPlayers,nil,1,"C:\\Temp")
CJump(AllPlayers,0x9FF)
Include_CtrigPlib(360,"Switch 1")
Include_64BitLibrary("Switch 1")
Include_CBPaint()
CJumpEnd(AllPlayers,0x9FF)
CJump(AllPlayers,0)
Str1 = SaveiStrArrX(P1,"\x04<갤뻥등장>") -- 5x11
Str4 = SaveiStrArrX(P1,"\x04<최고귀염뽀짝 천사 초텐쨩>") -- 5x11
Str2 = SaveiStrArrX(P1,MakeiStrVoid(54*11))
Str3 = SaveiStrArrX(P1,MakeiStrVoid(54))
VA1 = CVArray(P1,100)
VA2 = CVArray(P1,100)
NickCcode = CreateCcode()
CJumpEnd(AllPlayers,0)
Line, ChatSize, ChatOff, Check, DLine = CreateVars(6,P1)
PLength = CreateVarArr(4, P1)
CIfOnce(P1)
GetPlayerLength(P1,P1,PLength[1])
f_byteConvert(P1,VArr(VA1,0),0x6D0FDC,PLength[1])
TriggerX(FP, {isname(0, "GALAXY_BURST")},{SetCD(NickCcode,1)})
TriggerX(FP, {isname(0, "NEEDY_BURST")},{SetCD(NickCcode,2)})

CIfEnd()
SpCodeBase = 0x8080E200
SpCode0 = 0x8880E200 -- 식별자 (텍스트 미출력 라인은 첫 1바이트가 00으로 고정됨)
SpCode1 = 0x8980E200 -- P1 아이디
SpCode2 = 0x8A80E200 -- P1 아이디2
-- 0 : Resize / 1 : 식별자 / 2~6 : 칭호 / 7 ~ 52 : 채팅내용 / 53 : Null
function TEST() -- ScanChat -> 11줄 전체를 utf8 -> iutf8화 (식별자로 중복방지)
CA__SetNext(Str2,8,SetTo,0,54*11-1,0)
CMov(P1,Line,0)
CWhile(P1,NVar(Line,AtMost,10),SetNVar(Check,SetTo,0))
f_ChatOffset(P1,Line,0,ChatOff)

for i = 0, 3 do
	CTrigger(P1,{TTbytecmp(ChatOff,VArr(VA1,0),PLength[i+1]),CD(NickCcode,1)},{SetNVar(Check,SetTo,1)},{Preserved})
	CTrigger(P1,{TTbytecmp(ChatOff,VArr(VA1,0),PLength[i+1]),CD(NickCcode,2)},{SetNVar(Check,SetTo,2)},{Preserved})
end



CIfX(P1,{TTDisplayX(Line,1,"!=",SpCodeBase,0xF0FFFF00)}) -- 0x8080E2 ~ 0x8F80F2 인식
CA__SetValue(Str2,MakeiStrLetter(" ",53),0xFFFFFFFF,_Mul(Line,54*604),1,1)
CIfX(P1,NVar(Check,Exactly,1))
CD__ScanChat(SVA1(Str2,_Mul(_Add(_Mul(Line,54),6),604)),ChatOff,45,ChatSize,0,1)
CA__SetValue(Str2,MakeiStrLetter("\x0D",6),0xFFFFFFFF,_Mul(Line,54*604),1,1)
CA__Input(0x08,SVA1(Str2,_Mul(_Add(_Mul(Line,54),6),604)),0xFF)
CA__SetMemoryX(_GIndex2(Line,1),SpCode1+0x0D,0xFFFFFFFF,1)
CElseIfX(NVar(Check,Exactly,2))
CD__ScanChat(SVA1(Str2,_Mul(_Add(_Mul(Line,54),15),604)),ChatOff,31,ChatSize,0,1)
CA__SetValue(Str2,MakeiStrLetter("\x0D",15),0xFFFFFFFF,_Mul(Line,54*604),1,1)
CA__Input(0x08,SVA1(Str2,_Mul(_Add(_Mul(Line,54),15),604)),0xFF)
CA__SetMemoryX(_GIndex2(Line,1),SpCode2+0x0D,0xFFFFFFFF,1)
CElseX()
CD__ScanChat(SVA1(Str2,_Mul(Line,604*54)),ChatOff,51,ChatSize,0,1)
CA__SetMemoryX(_GIndex2(Line,1),SpCode0+0x0D,0xFFFFFFFF,1)
CIfXEnd()




CD__InputVAX(_GIndex2(Line,2),SVA1(Str2,_Mul(Line,604*54)),51,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)
CA__SetMemoryX(_GIndex2(Line,0),0x0D0D0D0D,0xFFFFFFFF,1) CD__InputMask(Line,0xFFFFFFFF,0,52)
CElseIfX({TTDisplay(Line,"On")})
CIf(P1,{TTDisplayX(Line,1,Exactly,SpCode1,0xFFFFFF00)})
CD__Resize(Line,_Read(0x57F0F0)) 
CD__InputMask(Line,0xFFFFFFFF,0,0)
CD__GetDisplayLine(Line,DLine)
CA__InputSVA1(SVA1(Str2,_Mul(Line,54*604)),SVA1(Str1,0),6,0xFFFFFFFF,0,54*11-1)
CIfEnd()
CIf(P1,{TTDisplayX(Line,1,Exactly,SpCode2,0xFFFFFF00)})
CD__Resize(Line,_Read(0x57F0F0)) 
CD__InputMask(Line,0xFFFFFFFF,0,0)
CD__GetDisplayLine(Line,DLine)
CA__InputSVA1(SVA1(Str2,_Mul(Line,54*604)),SVA1(Str2,0),15,0xFFFFFFFF,0,54*11-1)
CIfEnd()
CD__InputVAX(_GIndex2(Line,2),SVA1(Str2,_Mul(Line,604*54)),51,0xFFFFFFFF,0xFFFFFFFF,8,604*11-1)







CIfXEnd()


CWhileEnd(SetNVar(Line,Add,1))
end
CDPrint(0,11,{" ",0},{P1,P2},{1,0,0,0,1,1,0,0},"TEST",P1)
-----------------------------------------------------------
-------------------------------
------------------------------------------------------------------------------------------
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

if LD2XOption == 1 then
	__PopStringArray()
	io.close(__TRIGchkptr)
	end