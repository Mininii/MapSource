function OPTrig()
CIf(FP,Switch("Switch 201",Cleared))
DoActions2(FP,{RotatePlayer({CenterView(64)},HumanPlayers,FP)})
CIf(FP,{Memory(0x628438, AtLeast, 0x00000001),CDeaths(FP,Exactly,0,Print13)},SetCDeaths(FP,Add,88,Print13))
Print_13(FP,{P1,P2,P3,P4,P5,P6,P7},nil)
CIfEnd()
DoActionsX(FP,SetCDeaths(FP,Subtract,1,Print13))
CIfX(FP,Never())
	for i = 0, 6 do
	CElseIfX(HumanCheck(i,1))
	CMov(FP,SelCP,i)
	end
	CIfXEnd()
LoadCp(FP,SelCP)


HiddenCommand = {50}
for i = 1, #HiddenCommand do
	TriggerX(FP,{
		CDeaths(FP,Exactly,0,SelectorT),
		Deaths(CurrentPlayer,AtLeast,1,HiddenCommand[i]);
		CDeaths(FP,Exactly,i-1,HiddenMode);},{
			SetCDeaths(FP,Add,1,HiddenMode);})
end

function KeyInput(Key,Condition,Action)
	Trigger2X(FP,{Deaths(CurrentPlayer,AtLeast,1,Key),Condition},{SetDeaths(CurrentPlayer,SetTo,0,Key),Action},{preserved})	
	end
if Limit == 1 then
	KeyInput(200,nil,{SetCDeaths(FP,SetTo,1,TestMode)})
end
TriggerX(FP,{CD(TestMode,1)},{SetDeaths(Force1,SetTo,55,125),RotatePlayer({RunAIScript(P8VON)},MapPlayers,FP),SetCDeaths(FP,SetTo,30+(36*5),ModeT),SetResources(Force1,Add,666666666,Ore)})
CIf(FP,{CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode),CDeaths(FP,Exactly,0,SelectorT),})
KeyInput(66,{CVar(FP,HondonMode[2],Exactly,0)},{SetCVar(FP,HondonMode[2],SetTo,1),SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(66,{CVar(FP,HondonMode[2],Exactly,1)},{SetCVar(FP,HondonMode[2],SetTo,0),SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(60,{CVar(FP,HiddenHP[2],AtMost,4);},{SetCVar(FP,HiddenHP[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(63,{CVar(FP,HiddenHPM[2],AtMost,4);},{SetCVar(FP,HiddenHPM[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(61,{CVar(FP,HiddenATK[2],AtMost,4);},{SetCVar(FP,HiddenATK[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(64,{CVar(FP,HiddenATKM[2],AtMost,4);},{SetCVar(FP,HiddenATKM[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(62,{CVar(FP,HiddenPts[2],AtMost,4);},{SetCVar(FP,HiddenPts[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(65,{CVar(FP,HiddenPtsM[2],AtMost,4);},{SetCVar(FP,HiddenPtsM[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
TriggerX(FP,{CVar(FP,HiddenHPM[2],AtLeast,1);CVar(FP,HiddenHP[2],AtLeast,1);},{SetCVar(FP,HiddenHP[2],Subtract,1);SetCVar(FP,HiddenHPM[2],Subtract,1);},{preserved})
TriggerX(FP,{CVar(FP,HiddenATKM[2],AtLeast,1);CVar(FP,HiddenATK[2],AtLeast,1);},{SetCVar(FP,HiddenATK[2],Subtract,1);SetCVar(FP,HiddenATKM[2],Subtract,1);},{preserved})
TriggerX(FP,{CVar(FP,HiddenPtsM[2],AtLeast,1);CVar(FP,HiddenPts[2],AtLeast,1);},{SetCVar(FP,HiddenPts[2],Subtract,1);SetCVar(FP,HiddenPtsM[2],Subtract,1);},{preserved})

--?????? ???? ????????
TriggerX(FP,{CVar(FP,HiddenHP[2],AtLeast,1);},{SetCVar(FP,HiddenHP[2],SetTo,0)},{preserved})
TriggerX(FP,{CVar(FP,HiddenATK[2],AtLeast,1);},{SetCVar(FP,HiddenATK[2],SetTo,0)},{preserved})
TriggerX(FP,{CVar(FP,HiddenPts[2],AtLeast,1);},{SetCVar(FP,HiddenPts[2],SetTo,0)},{preserved})


HiddenModeStr = "\x0D\x0D\x0D\x0D\x13\x10[ \x04(\x08HP \x04: -0) (\x1BATK \x04: -0) (\x1FPts \x04: -0) (\x10???? ???? \x04: OFF) \x10]\x0D\x0D\x0D\x0D\x0D"
HiddenModeStr2 = "\x0D\x0D\x0D\x0D\x13\x10[ \x04(\x08HP \x04: -0) (\x1BATK \x04: -0) (\x1FPts \x04: -0) (\x10???? ???? \x08: ON) \x10]\x0D\x0D\x0D\x0D\x0D"
CIfX(FP,CVar(FP,HondonMode[2],AtMost,0))
Print_StringX(FP,VArr(HiddenModeT,0),HiddenModeStr,0)
CElseX()
Print_StringX(FP,VArr(HiddenModeT,0),HiddenModeStr2,0)
CIfXEnd()
HiddenModeL = GetStrSize(0,HiddenModeStr)--
HiddenFindT = "\x13\x04???? ?????? ????????.\n\x13\x04?? ???? ???? : \x071,2,3. \x04???? ???? : \x07A,S,D\n\x13\x10???? ???? \x07?????? \x04: ~ ????\n\x13\x04???? ?????? ???? ????????. ???????? ???? ????????"
WavFile = "staredit\\wav\\Unlock.ogg"
DoActions2X(FP,{
	RotatePlayer({
		PlayWAVX(WavFile);
		DisplayTextX(HiddenFindT,4);
		DisplayTextX("\x13\x10[ \x04(\x08HP \x04: 0) (\x1BATK \x04: 0) (\x1FPts \x04: 0) (\x10???? ???? \x04: OFF) \x10]",4);},HumanPlayers,FP)
},1)
for i = 2, 0, -1 do
	TriggerX(FP,{CVar(FP,HiddenHP[2],AtLeast,(2^i),(2^i));},{SetCVAar(VArr(HiddenModeT,4),SetTo,(2^i)*65536,(2^i)*65536);},{preserved})
	TriggerX(FP,{CVar(FP,HiddenHPM[2],AtLeast,(2^i),(2^i));},{SetCVAar(VArr(HiddenModeT,4),SetTo,(2^i)*65536,(2^i)*65536);},{preserved})
	TriggerX(FP,{CVar(FP,HiddenATK[2],AtLeast,(2^i),(2^i));},{SetCVAar(VArr(HiddenModeT,7),SetTo,(2^i)*16777216,(2^i)*16777216);},{preserved})
	TriggerX(FP,{CVar(FP,HiddenATKM[2],AtLeast,(2^i),(2^i));},{SetCVAar(VArr(HiddenModeT,7),SetTo,(2^i)*16777216,(2^i)*16777216);},{preserved})
	TriggerX(FP,{CVar(FP,HiddenPts[2],AtLeast,(2^i),(2^i));},{SetCVAar(VArr(HiddenModeT,11),SetTo,(2^i)*1,(2^i)*1);},{preserved})
	TriggerX(FP,{CVar(FP,HiddenPtsM[2],AtLeast,(2^i),(2^i));},{SetCVAar(VArr(HiddenModeT,11),SetTo,(2^i)*1,(2^i)*1);},{preserved})
end
TriggerX(FP,{CVar(FP,HiddenHPM[2],AtLeast,1);},{SetCVAar(VArr(HiddenModeT,4),SetTo,0x2D*256,0xFF00);},{preserved})
TriggerX(FP,{CVar(FP,HiddenHPM[2],AtMost,0);},{SetCVAar(VArr(HiddenModeT,4),SetTo,0x0D*256,0xFF00);},{preserved})
TriggerX(FP,{CVar(FP,HiddenATKM[2],AtLeast,1);},{SetCVAar(VArr(HiddenModeT,7),SetTo,0x2D*65536,0xFF0000);},{preserved})
TriggerX(FP,{CVar(FP,HiddenATKM[2],AtMost,0);},{SetCVAar(VArr(HiddenModeT,7),SetTo,0x0D*65536,0xFF0000);},{preserved})
TriggerX(FP,{CVar(FP,HiddenPtsM[2],AtLeast,1);},{SetCVAar(VArr(HiddenModeT,10),SetTo,0x2D*16777216,0xFF000000);},{preserved})
TriggerX(FP,{CVar(FP,HiddenPtsM[2],AtMost,0);},{SetCVAar(VArr(HiddenModeT,10),SetTo,0x0D*16777216,0xFF000000);},{preserved})

f_Movcpy(FP,HiddenModeStrPtr,VArr(HiddenModeT,0),HiddenModeL)
WavFile = "staredit\\wav\\sel_g.ogg"
Trigger2X(FP,{CDeaths(FP,AtLeast,1,ToggleSound);},{RotatePlayer({PlayWAVX(WavFile);DisplayTextX("HD".._0D,4);},HumanPlayers,FP),SetCDeaths(FP,SetTo,0,ToggleSound);},{preserved})
CIfEnd()

CIf(FP,{CDeaths(FP,Exactly,0,ModeSel)})
KeyInput(210,nil,{SetCDeaths(FP,SetTo,1,GMode);SetCDeaths(FP,SetTo,1,ToggleSound2)})
KeyInput(211,nil,{SetCDeaths(FP,SetTo,2,GMode);SetCDeaths(FP,SetTo,1,ToggleSound2)})
KeyInput(212,nil,{SetCDeaths(FP,SetTo,3,GMode);SetCDeaths(FP,SetTo,1,ToggleSound2)})
KeyInput(213,{CDeaths(FP,AtLeast,1,GMode);},{SetCDeaths(FP,SetTo,1,ModeSel);SetCDeaths(FP,SetTo,1,SelectorT);})
CIfEnd()	
CIf(FP,{CDeaths(FP,Exactly,2,ModeSel)})
KeyInput(210,nil,{SetCDeaths(FP,SetTo,1,DMode);SetCDeaths(FP,SetTo,1,ToggleSound2)})
KeyInput(211,nil,{SetCDeaths(FP,SetTo,2,DMode);SetCDeaths(FP,SetTo,1,ToggleSound2)})
KeyInput(212,nil,{SetCDeaths(FP,SetTo,3,DMode);SetCDeaths(FP,SetTo,1,ToggleSound2)})
KeyInput(213,{CDeaths(FP,AtLeast,1,DMode);},{SetCDeaths(FP,SetTo,3,ModeSel);SetCDeaths(FP,SetTo,3,SelectorT);})
CIfEnd()	
CMov(FP,0x6509B0,FP)

Trigger2X(FP,{CDeaths(FP,AtLeast,1,ToggleSound2);},{RotatePlayer({PlayWAVX(WavFile)},HumanPlayers,FP),SetCDeaths(FP,SetTo,0,ToggleSound2);},{preserved})
		
for j = 1, 7 do
CIf(FP,{TTOR({CDeaths(FP,Exactly,0,SelectorT),CDeaths(FP,Exactly,2,SelectorT)}),CVar(FP,SelCP[2],Exactly,j-1)})
f_Memcpy(FP,0x641598,_TMem(Arr(Str26[3],0),"X","X",1),Str26[2])
f_Movcpy(FP,0x641598+Str26[2],VArr(Names[j],0),4*6)
CIfEnd()
end
CIf(FP,{CDeaths(FP,Exactly,0,ModeSel)})
for i = 0, 3 do
CIf(FP,CDeaths(FP,Exactly,i,GMode))
f_Memcpy(FP,0x641598+Str26[2]+(4*6)-5,_TMem(Arr(Str25[i+1][3],0),"X","X",1),Str25[i+1][2])
CIfEnd()
end
CIfEnd()
CIf(FP,{CDeaths(FP,Exactly,2,ModeSel)})
for i = 0, 3 do
CIf(FP,CDeaths(FP,Exactly,i,DMode))
f_Memcpy(FP,0x641598+Str26[2]+(4*6)-5,_TMem(Arr(Str27[i+1][3],0),"X","X",1),Str27[i+1][2])
CIfEnd()
end
CIfEnd()

_0DPatchforT13 = {}
for i =0, 50 do
table.insert(_0DPatchforT13,SetMemory(0x641598+(i*4),SetTo,0x0D0D0D0D))
end


Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,SelectorT);
	},
	actions = {
		SetCDeaths(FP,Add,1,IntroT);
		PreserveTrigger();
	}
	}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,SelectorT);
	},
	actions = {
		SetCDeaths(FP,Add,1,IntroT2);
		PreserveTrigger();
	}
	}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,24*30,IntroT);
		CDeaths(FP,Exactly,0,ModeSel);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,GMode);
		SetCDeaths(FP,SetTo,1,ModeSel);
		SetCDeaths(FP,SetTo,1,SelectorT);
		SetCDeaths(FP,SetTo,0,IntroT);
	}
	}

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,24*30,IntroT2);
			CDeaths(FP,Exactly,2,ModeSel);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,DMode);
			SetCDeaths(FP,SetTo,3,ModeSel);
			SetCDeaths(FP,SetTo,3,SelectorT);
			SetCDeaths(FP,SetTo,0,IntroT);
		}
		}


	Text1 = "\x13\x07??????\x04?? ????????????.\n\x13\x04???? ???? ?? Y?????? ??????????. 30?? ?? ???????? \x0EEASY\x04?????? ??????????."
	Trigger2X(FP,{},{RotatePlayer({DisplayTextX(Text1,4);},HumanPlayers,FP)})
	Text2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	
	WavFile = "staredit\\wav\\Select.ogg"
	Text1 = {"\x13\x07\n\x13\x04[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x05[E] \x11BURST\n\x13\x04?????? ?????? ??????????????.",
	"\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x04[W] \x08HARD\n\x13\x05[E] \x11BURST\n\x13\x04?????? ?????? ??????????????.",
	"\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x04[E] \x11BURST\n\x13\x04?????? ?????? ??????????????."}
Trigger {
players = {FP},
conditions = {
	Label(0);
	CDeaths(FP,Exactly,56*2,ModeT2);
},
actions = {
	--SetCDeaths(FP,Add,1,ModeO);
	SetCDeaths(FP,SetTo,2,SelectorT);
	SetCDeaths(FP,SetTo,2,ModeSel);
}
}
Trigger {
players = {FP},
conditions = {
	Label(0);
	CDeaths(FP,Exactly,56*4,ModeT2);
},
actions = {
	SetCDeaths(FP,Add,1,ModeO);
}
}
Trigger {
players = {FP},
conditions = {
	Label(0);
	CDeaths(FP,Exactly,0,ModeO);
	CDeaths(FP,Exactly,1,SelectorT);
},
actions = {
	SetCDeaths(FP,Add,1,ModeT2);
	_0DPatchforT13;
	PreserveTrigger();
}
}
Trigger {
players = {FP},
conditions = {
	Label(0);
	CDeaths(FP,Exactly,0,ModeO);
	CDeaths(FP,Exactly,3,SelectorT);
},
actions = {
	SetCDeaths(FP,Add,1,ModeT2);
	_0DPatchforT13;
	PreserveTrigger();
}
}
for i = 1, 3 do
Trigger2X(FP,{CDeaths(FP,Exactly,1,ModeSel);CDeaths(FP,Exactly,i,GMode);},{
	RotatePlayer({DisplayTextX(Text1[i]),PlayWAVX(WavFile)},HumanPlayers,FP)
})
end


Text1 = "\x13\x08????????\x04?? ????????????.\n\x13\x04???? ???? ?? Y?????? ??????????. 30?? ?? ???????? \x0E????\x04?????? ??????????."
WavFile = "staredit\\wav\\Sel2.ogg"
Trigger2X(FP,{CDeaths(FP,Exactly,2,ModeSel)},{RotatePlayer({DisplayTextX(Text1,4);PlayWAVX(WavFile)},HumanPlayers,FP)})
Text2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
Text1 = {"\x13\x07\n\x13\x04[Q] \x0E????\x04?? \x04????????\n\x13\x05[W] \x08??????\x04?? \x06????????\n\x13\x05[E] \x10??????\x04?? \x11????????????\n\x13\x07???? ????\x04?? ??????????????.",
"\x13\x07\n\x13\x05[Q] \x0E????\x04?? \x04????????\n\x13\x04[W] \x08??????\x04?? \x06????????\n\x13\x05[E] \x10??????\x04?? \x11????????????\n\x13\x07???? ????\x04?? ??????????????.\n\x13\x08???? ???? \x11???????????? \x04???????? \x06??????\x04?? \x072?? \x04??????????????.",
"\x13\x07\n\x13\x05[Q] \x0E????\x04?? \x04????????\n\x13\x05[W] \x08??????\x04?? \x06????????\n\x13\x04[E] \x10??????\x04?? \x11????????????\n\x13\x07???? ????\x04?? ??????????????.\n\x13\x08???? ???? \x11???????????? \x04???????? \x06??????\x04?? \x072?? \x04??????????????."}
WavFile = "staredit\\wav\\Select.ogg"

for i = 1, 3 do
	Trigger2X(FP,{CDeaths(FP,Exactly,3,ModeSel);CDeaths(FP,Exactly,i,DMode);},{
		RotatePlayer({DisplayTextX(Text1[i]),PlayWAVX(WavFile)},HumanPlayers,FP)
	})
	end
	

Trigger { -- ??????1
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ModeO);
	},
	actions = {
		SetCDeaths(FP,Add,1,ModeT);
		PreserveTrigger();
		
	},
	}
OPArr = {
{"\n\n\n\n\n\n\n\n\n\n\x13\x15?? ?? ?? ?? ?? ?? GaLaXy:ReB??t ??\n\n\n\n\n",0,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x05?? ?? ?? ?? ?? ?? GaLaXy:ReB??t ??\n\n\n\n\n",5,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x10?? ?? ?? ?? ?? ?? GaLaXy:ReB??t ??\n\n\n\n\n",10,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x18?? ?? ?? ?? ?? ?? GaLaXy:ReB??t ??\n\n\n\n\n",15,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x0E?? ?? ?? ?? ?? ?? GaLaXy:ReB??t ??\n\n\n\n\n",20,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x11?? ?? ?? ?? ?? ?? GaLaXy:ReB??t ??\n\n\n\n\n",25,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x16?? ?? ?? ?? ?? ?? GaLaXy:ReB??t ??\n\n\n\n\n",30,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03?? \x04?? ?? ?? ?? ?? \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01??\x07t \x03??\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04?????? Insert???? ????????????\n\n",35,"staredit\\wav\\GameStart.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03?? \x04?? ?? ?? ?? ?? \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01??\x07t \x03??\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04?????? Insert???? ????????????\n\x13\x043\n",35+(36*2),"staredit\\wav\\Countdown.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03?? \x04?? ?? ?? ?? ?? \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01??\x07t \x03??\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04?????? Insert???? ????????????\n\x13\x042\n",35+(36*3),"staredit\\wav\\Countdown.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03?? \x04?? ?? ?? ?? ?? \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01??\x07t \x03??\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04?????? Insert???? ????????????\n\x13\x041\n",35+(36*4),"staredit\\wav\\Countdown.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03?? \x04?? ?? ?? ?? ?? \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01??\x07t \x03??\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04?????? Insert???? ????????????\n\x13\x04START",35+(36*5),"staredit\\wav\\GameStart2.ogg"}}
for j, k in pairs(OPArr) do
	if k[3] == nil then
		TriggerX(FP,{CDeaths(FP,AtLeast,1,ModeO);CDeaths(FP,AtLeast,k[2],ModeT);},{RotatePlayer({DisplayTextX(k[1],4)},HumanPlayers,FP)})
	else
		TriggerX(FP,{CDeaths(FP,AtLeast,1,ModeO);CDeaths(FP,AtLeast,k[2],ModeT);},{RotatePlayer({DisplayTextX(k[1],4),PlayWAVX(k[3])},HumanPlayers,FP)})
	end
end
CIfOnce(FP,{CDeaths(FP,AtLeast,35+(36*5),ModeT)},{SetCD(GStart,1)})

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATK[2],Exactly,0);--???????? ??????????
		CDeaths(FP,AtLeast,2,DMode); -- ???? or ?????????? ??2?? ????
	},
	actions = {		
		SetMemoryW(0x656EB0+(0*2),Add,70);
		SetMemoryW(0x657678+(0*2),Add,3);
		SetMemoryW(0x656EB0+(1*2),Add,88);
		SetMemoryW(0x657678+(1*2),Add,4);
		SetMemoryW(0x656EB0+(117*2),Add,70);
		SetMemoryW(0x657678+(117*2),Add,6);
		SetMemoryW(0x656EB0+(3*2),Add,150);
		SetMemoryW(0x657678+(3*2),Add,5);
		SetMemoryW(0x656EB0+(13*2),Add,5);
		SetMemoryW(0x657678+(13*2),Add,2);
	}
}

NIf(FP,CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode),{
})
HiddenCancel = def_sIndex()
NJump(FP,HiddenCancel,{
	CVar(FP,HiddenPts[2],Exactly,0);
	CVar(FP,HiddenHP[2],Exactly,0);
	CVar(FP,HiddenATK[2],Exactly,0);
	CVar(FP,HiddenPtsM[2],Exactly,0);
	CVar(FP,HiddenHPM[2],Exactly,0);
	CVar(FP,HiddenATKM[2],Exactly,0);
	CVar(FP,HondonMode[2],Exactly,0);
},{SetCDeaths(FP,SetTo,0,HiddenMode);})
TriggerX(FP,{SetCDeaths(FP,AtLeast,#HiddenCommand,HiddenMode);},{
	SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 ??????
	SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8????
})
Trigger2X(FP,{CV(HiddenHPM,1,AtLeast)},HiddenHPMPatchArr)
for i = 1, 5 do
	TriggerX(FP,{
		CVar(FP,HiddenHP[2],Exactly,i);
	},{
		SetMemory(0x662350 + (4*0), Add, i*3500*256);
		SetMemory(0x662350 + (4*16), Add, i*9000*256);
		SetMemory(0x662350 + (4*7), Add, (i*2000*256)-1);
		SetMemory(0x662350 + (4*100), Add, (i*10000*256)-1);
		SetMemory(0x662350 + (4*124), Add, (i*10000*256)-1);
		SetMemory(0x662350 + (4*125), Add, (i*10000*256)-1);
		SetMemory(0x662350 + (4*20), Add, i*6500*256);
		SetMemoryW(0x660E00 + (2*124), Add, i*10000);
		SetMemoryW(0x660E00 + (2*125), Add, i*10000);
	})
	
	TriggerX(FP,{CVar(FP,HiddenPts[2],Exactly,i);},{SetCVar(FP,HPointVar[2],Add,100*i);})
	TriggerX(FP,{CVar(FP,HiddenPtsM[2],Exactly,i);},{SetCVar(FP,HPointVar[2],SetTo,100-(16*i));})


	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,1,DMode); -- ???? or ???????? ????????
			CVar(FP,HiddenATK[2],Exactly,i);
		},
		actions = {		
			SetMemoryW(0x656EB0+(0*2),Add,70*i);
			SetMemoryW(0x657678+(0*2),Add,3*i);
			SetMemoryW(0x656EB0+(1*2),Add,88*i);
			SetMemoryW(0x657678+(1*2),Add,4*i);
			SetMemoryW(0x656EB0+(117*2),Add,70*i);
			SetMemoryW(0x657678+(117*2),Add,6*i);
			SetMemoryW(0x656EB0+(3*2),Add,150*i);
			SetMemoryW(0x657678+(3*2),Add,5*i);
			SetMemoryW(0x656EB0+(13*2),Add,5*i);
			SetMemoryW(0x657678+(13*2),Add,2*i);
		}
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,2,DMode); -- ???? or ?????????? ??2?? ????
			CVar(FP,HiddenATK[2],Exactly,i);
		},
		actions = {		
			SetMemoryW(0x656EB0+(0*2),Add,(70*i)+(70*i));
			SetMemoryW(0x657678+(0*2),Add,(3*i)+(3*i));
			SetMemoryW(0x656EB0+(1*2),Add,(88*i)+(88*i));
			SetMemoryW(0x657678+(1*2),Add,(4*i)+(4*i));
			SetMemoryW(0x656EB0+(117*2),Add,(70*i)+(70*i));
			SetMemoryW(0x657678+(117*2),Add,(6*i)+(6*i));
			SetMemoryW(0x656EB0+(3*2),Add,(150*i)+(150*i));
			SetMemoryW(0x657678+(3*2),Add,(5*i)+(5*i));
			SetMemoryW(0x656EB0+(13*2),Add,(5*i)+(5*i));
			SetMemoryW(0x657678+(13*2),Add,(2*i)+(2*i));
		}
	}
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CVar(FP,HiddenATKM[2],Exactly,i);
		},
		actions = {
			SetCVar(FP,AtkUpMax[2],SetTo,100+(150-(30*i)));
			SetMemoryB(0x58D088+(0*46)+7,SetTo,100+(150-(30*i)));
			SetMemoryB(0x58D088+(1*46)+7,SetTo,100+(150-(30*i)));
			SetMemoryB(0x58D088+(2*46)+7,SetTo,100+(150-(30*i)));
			SetMemoryB(0x58D088+(3*46)+7,SetTo,100+(150-(30*i)));
			SetMemoryB(0x58D088+(4*46)+7,SetTo,100+(150-(30*i)));
			SetMemoryB(0x58D088+(5*46)+7,SetTo,100+(150-(30*i)));
			SetMemoryB(0x58D088+(6*46)+7,SetTo,100+(150-(30*i)));
		}
	}
	
end

DoActions(FP,{ModifyUnitHitPoints(All,125,AllPlayers,64,100),ModifyUnitHitPoints(All,125,P10,64,100)})
CIf(FP,CV(HondonMode,1),{
	SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 ??????
	SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8????
})
DoActions2X(FP,HondonPatchArr)
PtrV = CreateVar(FP)

CMov(FP,PtrV,19025)
CWhile(FP,CV(PtrV,19025 + (84*1699),AtMost))

CTrigger(FP,{TTMemoryX(_Add(PtrV,19),NotSame,58,0xFF)},{
	TSetMemoryX(_Add(PtrV,8),SetTo,127*65536,0xFF0000),
	TSetMemoryX(_Add(PtrV,9),SetTo,0*16777216,0xFF000000),
	TSetMemory(_Add(PtrV,13),SetTo,20000),
	TSetMemoryX(_Add(PtrV,18),SetTo,4000,0xFFFF),
	},1)
CAdd(FP,PtrV,84)
CWhileEnd()

CIfEnd()
NIfEnd()
NJumpEnd(FP,HiddenCancel)

TriggerX(FP,{},{SetSwitch("Switch 201",Set),RotatePlayer({CenterView(4)},HumanPlayers,FP),SetV(BGMType,1),SetResources(Force1,Add,5000,Ore),CreateUnitWithProperties(2,0,4,Force1,{energy = 100}),CreateUnitWithProperties(1,20,4,Force1,{energy = 100})})
TriggerX(FP,{CV(SetPlayers,1)},{CreateUnitWithProperties(4,0,4,Force1,{energy = 100}),CreateUnitWithProperties(3,20,4,Force1,{energy = 100}),SetResources(Force1,Add,75000,Ore)})
TriggerX(FP,{CV(SetPlayers,2)},{CreateUnitWithProperties(3,0,4,Force1,{energy = 100}),CreateUnitWithProperties(2,20,4,Force1,{energy = 100}),SetResources(Force1,Add,55000,Ore)})
TriggerX(FP,{CV(SetPlayers,3)},{CreateUnitWithProperties(2,0,4,Force1,{energy = 100}),CreateUnitWithProperties(1,20,4,Force1,{energy = 100}),SetResources(Force1,Add,35000,Ore)})
TriggerX(FP,{CV(SetPlayers,4)},{CreateUnitWithProperties(1,0,4,Force1,{energy = 100}),CreateUnitWithProperties(1,20,4,Force1,{energy = 100}),SetResources(Force1,Add,15000,Ore)})
for i = 1, 3 do
	for j = 1, 7 do
		TriggerX(FP,{CV(SetPlayers,j),CD(GMode,i)},{RotatePlayer({SetMissionObjectivesX("\x13\x04?????????? \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01??\x07t \n\x13"..DifLeaderBoard[i].." "..j.."?? \x04?????? ????????. -\n\x13\x0E?????? : "..(ExArr[i][j]/10).."%\n\x13\x07==================\n\x13\x04???? ??????\n\x13\x04Marine + \x1F"..HMCost.."?? \x04= \x1BH \x04Marine\n\x13\x1BH \x04Marine + \x1F"..GMCost.."?? \x04= \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\n\x13\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04 + \x1F"..NeCost.."?? \x04= \x11??\x07??\x1F??\x1C??\x17??\x11??")},HumanPlayers,FP),SetV(ExRateV,ExArr[i][j])})
	end
end


CIfEnd()

CIfEnd({SetCp(FP)})
CIfOnce(FP,{Switch("Switch 201",Set),CommandLeastAt(189,20)})
for i = 1, 3 do
	for j = 1, 7 do
		TriggerX(FP,{CV(SetPlayers,j),CD(GMode,i)},{RotatePlayer({SetMissionObjectivesX("\x13\x04?????????? \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01??\x07t \n\x13"..DifLeaderBoard[i].." "..j.."?? \x04?????? ????????. -\n\x13\x0E?????? : "..((ExArr[i][j]+50)/10).."%\n\x13\x07==================\n\x13\x04???? ??????\n\x13\x04Marine + \x1F"..HMCost.."?? \x04= \x1BH \x04Marine\n\x13\x1BH \x04Marine + \x1F"..GMCost.."?? \x04= \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\n\x13\x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x04 + \x1F"..NeCost.."?? \x04= \x11??\x07??\x1F??\x1C??\x17??\x11??")},HumanPlayers,FP)})
	end
end
CIfEnd()

end