function OPTrig()
CIf(FP,Switch("Switch 201",Cleared))
DoActions2(FP,{RotatePlayer({CenterView(64)},HumanPlayers,FP)})
if AutoSettingMode == true then
	am={}
	am.GMode = 3
	am.DMode = 1
	am.HiddenATK = 0
	am.HiddenHP = 0
	am.HiddenPts = 1
	am.HondonMode = 1
	am.AtkSpeedMode = 1
	am.Timer = CreateCcode()
	am.ErrorFlag = CreateCcode()
	
	HondonTxt = {"\x04: OFF","\x08: ON"}
	Text1 = {
	"\x13\x07\n\x13\x04[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x05[E] \x11BURST",
	"\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x04[W] \x08HARD\n\x13\x05[E] \x11BURST",
	"\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x04[E] \x11BURST"}
	Text2 = {
	"\x13\x07\n\x13\x04[Q] \x0E쫄보\x04의 \x04일반모드\n\x13\x05[W] \x08상남자\x04의 \x06드랍모드\n\x13\x05[E] \x10돌아이\x04의 \x11응답없음모드",
	"\x13\x07\n\x13\x05[Q] \x0E쫄보\x04의 \x04일반모드\n\x13\x04[W] \x08상남자\x04의 \x06드랍모드\n\x13\x05[E] \x10돌아이\x04의 \x11응답없음모드\n\x13\x08드랍 또는 \x11응답없음모드 \x04선택으로 \x06공격력\x04이 \x072배 \x04증가하였습니다.",
	"\x13\x07\n\x13\x05[Q] \x0E쫄보\x04의 \x04일반모드\n\x13\x05[W] \x08상남자\x04의 \x06드랍모드\n\x13\x04[E] \x10돌아이\x04의 \x11응답없음모드\n\x13\x08드랍 또는 \x11응답없음모드 \x04선택으로 \x06공격력\x04이 \x072배 \x04증가하였습니다."}
	SettingArr = {}
	for j,k in pairs({{am.HiddenATK,HiddenATK,HiddenATKM},{am.HiddenHP,HiddenHP,HiddenHPM},{am.HiddenPts,HiddenPts,HiddenPtsM}}) do
		if math.abs(k[1])>=6 then PushErrorMsg("Hidden Option has Overflowed") end
		if k[1]<0 then
			table.insert(SettingArr, {SetV(k[3],math.abs(k[1]))})
		else
			table.insert(SettingArr, {SetV(k[2],math.abs(k[1]))})
		end

	end
	if am.HiddenATK >= 1 or am.HiddenHP >= 1 or am.HiddenPts >= 1 or am.HondonMode >= 1 then HiddenCommand = {50} DoActionsX(FP,{SetCD(HiddenMode,1)}) else HiddenCommand = {} end
	DoActions2X(FP, {
		AddCD(am.Timer,1),
		SetCD(GMode,am.GMode),
		SetCD(DMode,am.DMode),
		SetV(HondonMode,am.HondonMode),
		SetV(AtkSpeedMode,am.AtkSpeedMode),
		--RemoveUnit(115, AllPlayers);
		SettingArr
})

	TriggerX(FP,{CD(GMode,4,AtLeast)},{SetCD(am.ErrorFlag,1)})
	TriggerX(FP,{CD(DMode,4,AtLeast)},{SetCD(am.ErrorFlag,1)})
	TriggerX(FP,{CV(HondonMode,2,AtLeast)},{SetCD(am.ErrorFlag,1)})
	TriggerX(FP,{CV(AtkSpeedMode,2,AtLeast)},{SetCD(am.ErrorFlag,1)})


	CIfX(FP,{CD(am.ErrorFlag,1)},{{
		RotatePlayer({
			DisplayTextX(StrDesignX("\x1B맵 설정에 문제가 발생했습니다. 맵 설정을 다시한번 확인해주세요.").."\n"..StrDesignX("GMode : "..am.GMode.." || DMode : "..am.DMode.." || HondonMode : "..am.HondonMode),4);
		Defeat();
		},HumanPlayers,FP);
		Defeat();
		SetMemory(0xCDDDCDDC,SetTo,1);}})
		
	CElseX()

	DoActions(FP,{RotatePlayer({PlayWAVX("staredit\\wav\\Select.ogg"),DisplayTextX(StrDesignX("맵 설정에 의해 모든 옵션이 자동으로 설정되었습니다."), 4)}, HumanPlayers, FP)},1)

	CIf(FP,{CD(am.Timer,24*3)})
	
HiddenDisplay = CreateVarArr(3,FP)

HiddenColor = CreateVarArr(3,FP)

CMov(FP,HiddenDisplay[1],0)
CMov(FP,HiddenDisplay[2],0)
CMov(FP,HiddenDisplay[3],0)
CAdd(FP,HiddenDisplay[1],HiddenHP)
CAdd(FP,HiddenDisplay[2],HiddenATK)
CAdd(FP,HiddenDisplay[3],HiddenPts)
CiSub(FP,HiddenDisplay[1],HiddenHPM)
CiSub(FP,HiddenDisplay[2],HiddenATKM)
CiSub(FP,HiddenDisplay[3],HiddenPtsM)

ColorT = {0x1F,0x0F,0x1C,0x1E,0x1D,0x4,0x19,0x3,0x11,0x10,0x08}
for i = 1, 3 do
	for j = 0, 10 do
		TriggerX(FP,{CV(HiddenDisplay[i],j-5)},{SetV(HiddenColor[i],ColorT[11-j])},{preserved})
	end
end

hondondisplay = CreateVarArr(4,FP)
AtkSpeedDisplay = CreateVarArr(4,FP)
TriggerX(FP,{CV(HondonMode,0)},{
	SetV(hondondisplay[1],string.byte("\x04",1,1)),
	SetV(hondondisplay[2],string.byte("O",1,1)),
	SetV(hondondisplay[3],string.byte("F",1,1)),
	SetV(hondondisplay[4],string.byte("F",1,1)),
},{preserved})
TriggerX(FP,{CV(HondonMode,1)},{
	SetV(hondondisplay[1],string.byte("\x08",1,1)),
	SetV(hondondisplay[2],string.byte("O",1,1)),
	SetV(hondondisplay[3],string.byte("N",1,1)),
	SetV(hondondisplay[4],string.byte(" ",1,1)),
},{preserved})
TriggerX(FP,{CV(AtkSpeedMode,0)},{
	SetV(AtkSpeedDisplay[1],string.byte("\x04",1,1)),
	SetV(AtkSpeedDisplay[2],string.byte("O",1,1)),
	SetV(AtkSpeedDisplay[3],string.byte("F",1,1)),
	SetV(AtkSpeedDisplay[4],string.byte("F",1,1)),
},{preserved})
TriggerX(FP,{CV(AtkSpeedMode,1)},{
	SetV(AtkSpeedDisplay[1],string.byte("\x1F",1,1)),
	SetV(AtkSpeedDisplay[2],string.byte("O",1,1)),
	SetV(AtkSpeedDisplay[3],string.byte("N",1,1)),
	SetV(AtkSpeedDisplay[4],string.byte(" ",1,1)),
},{preserved})

WavFile = "staredit\\wav\\Sel2.ogg"

--HondonMode
--AtkSpeedMode
DisplayPrint(HumanPlayers,{"\x13\x10[ \x04(\x08HP \x04: ",HiddenColor[1][2],HiddenDisplay[1],"\x04) (\x1BATK \x04: ",HiddenColor[2][2],HiddenDisplay[2],"\x04) (\x1FPts \x04: ",HiddenColor[3][2],HiddenDisplay[3],"\x04) (\x10혼돈 옵션 \x04: ",hondondisplay,"\x04) (\x1F공속무한모드 \x04: ",AtkSpeedDisplay,"\x04)  \x10]"})
DoActions(FP,{RotatePlayer({PlayWAVX(WavFile);},HumanPlayers,FP)})

	CIfEnd()
	TriggerX(FP,{CD(am.Timer,24*6)},{RotatePlayer({PlayWAVX("staredit\\wav\\Sel2.ogg"),DisplayTextX(Text1[am.GMode], 4)}, HumanPlayers, FP)})
	TriggerX(FP,{CD(am.Timer,24*9)},{RotatePlayer({PlayWAVX("staredit\\wav\\Sel2.ogg"),DisplayTextX(Text2[am.DMode], 4)}, HumanPlayers, FP)})
	TriggerX(FP,{CD(am.Timer,24*12)},{SetCD(ModeO,1)})
	CIfXEnd()

	

	




else
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
KeyInput(67,{CVar(FP,AtkSpeedMode[2],Exactly,0)},{SetCVar(FP,AtkSpeedMode[2],SetTo,1),SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(67,{CVar(FP,AtkSpeedMode[2],Exactly,1)},{SetCVar(FP,AtkSpeedMode[2],SetTo,0),SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(60,{CVar(FP,HiddenHP[2],AtMost,4);},{SetCVar(FP,HiddenHP[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(63,{CVar(FP,HiddenHPM[2],AtMost,4);},{SetCVar(FP,HiddenHPM[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(61,{CVar(FP,HiddenATK[2],AtMost,4);},{SetCVar(FP,HiddenATK[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(64,{CVar(FP,HiddenATKM[2],AtMost,4);},{SetCVar(FP,HiddenATKM[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(62,{CVar(FP,HiddenPts[2],AtMost,4);},{SetCVar(FP,HiddenPts[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
KeyInput(65,{CVar(FP,HiddenPtsM[2],AtMost,4);},{SetCVar(FP,HiddenPtsM[2],Add,1);SetCDeaths(FP,SetTo,1,ToggleSound)})
TriggerX(FP,{CVar(FP,HiddenHPM[2],AtLeast,1);CVar(FP,HiddenHP[2],AtLeast,1);},{SetCVar(FP,HiddenHP[2],Subtract,1);SetCVar(FP,HiddenHPM[2],Subtract,1);},{preserved})
TriggerX(FP,{CVar(FP,HiddenATKM[2],AtLeast,1);CVar(FP,HiddenATK[2],AtLeast,1);},{SetCVar(FP,HiddenATK[2],Subtract,1);SetCVar(FP,HiddenATKM[2],Subtract,1);},{preserved})
TriggerX(FP,{CVar(FP,HiddenPtsM[2],AtLeast,1);CVar(FP,HiddenPts[2],AtLeast,1);},{SetCVar(FP,HiddenPts[2],Subtract,1);SetCVar(FP,HiddenPtsM[2],Subtract,1);},{preserved})

--플러스 옵션 이용불가
--TriggerX(FP,{CVar(FP,HiddenHP[2],AtLeast,1);},{SetCVar(FP,HiddenHP[2],SetTo,0)},{preserved})
--TriggerX(FP,{CVar(FP,HiddenATK[2],AtLeast,1);},{SetCVar(FP,HiddenATK[2],SetTo,0)},{preserved})
--TriggerX(FP,{CVar(FP,HiddenPts[2],AtLeast,1);},{SetCVar(FP,HiddenPts[2],SetTo,0)},{preserved})


HiddenFindT = "\x13\x04히든 커맨드 입력성공.\n\x13\x04값 올림 버튼 : \x071,2,3. \x04내림 버튼 : \x07A,S,D\n\x13\x07기타옵션 \x04활성화 \x04: ~, Tab 버튼"
WavFile = "staredit\\wav\\Unlock.ogg"
DoActions2X(FP,{
	RotatePlayer({
		PlayWAVX(WavFile);
		DisplayTextX(HiddenFindT,4);},HumanPlayers,FP),SetCDeaths(FP,SetTo,1,ToggleSound);
},1)


CIf(FP,{CDeaths(FP,AtLeast,1,ToggleSound);},{SetCDeaths(FP,SetTo,0,ToggleSound);})

HiddenDisplay = CreateVarArr(3,FP)

HiddenColor = CreateVarArr(3,FP)

CMov(FP,HiddenDisplay[1],0)
CMov(FP,HiddenDisplay[2],0)
CMov(FP,HiddenDisplay[3],0)
CAdd(FP,HiddenDisplay[1],HiddenHP)
CAdd(FP,HiddenDisplay[2],HiddenATK)
CAdd(FP,HiddenDisplay[3],HiddenPts)
CiSub(FP,HiddenDisplay[1],HiddenHPM)
CiSub(FP,HiddenDisplay[2],HiddenATKM)
CiSub(FP,HiddenDisplay[3],HiddenPtsM)

ColorT = {0x1F,0x0F,0x1C,0x1E,0x1D,0x4,0x19,0x3,0x11,0x10,0x08}
for i = 1, 3 do
	for j = 0, 10 do
		TriggerX(FP,{CV(HiddenDisplay[i],j-5)},{SetV(HiddenColor[i],ColorT[11-j])},{preserved})
	end
end

hondondisplay = CreateVarArr(4,FP)
AtkSpeedDisplay = CreateVarArr(4,FP)
TriggerX(FP,{CV(HondonMode,0)},{
	SetV(hondondisplay[1],string.byte("\x04",1,1)),
	SetV(hondondisplay[2],string.byte("O",1,1)),
	SetV(hondondisplay[3],string.byte("F",1,1)),
	SetV(hondondisplay[4],string.byte("F",1,1)),
},{preserved})
TriggerX(FP,{CV(HondonMode,1)},{
	SetV(hondondisplay[1],string.byte("\x08",1,1)),
	SetV(hondondisplay[2],string.byte("O",1,1)),
	SetV(hondondisplay[3],string.byte("N",1,1)),
	SetV(hondondisplay[4],string.byte(" ",1,1)),
},{preserved})
TriggerX(FP,{CV(AtkSpeedMode,0)},{
	SetV(AtkSpeedDisplay[1],string.byte("\x04",1,1)),
	SetV(AtkSpeedDisplay[2],string.byte("O",1,1)),
	SetV(AtkSpeedDisplay[3],string.byte("F",1,1)),
	SetV(AtkSpeedDisplay[4],string.byte("F",1,1)),
},{preserved})
TriggerX(FP,{CV(AtkSpeedMode,1)},{
	SetV(AtkSpeedDisplay[1],string.byte("\x1F",1,1)),
	SetV(AtkSpeedDisplay[2],string.byte("O",1,1)),
	SetV(AtkSpeedDisplay[3],string.byte("N",1,1)),
	SetV(AtkSpeedDisplay[4],string.byte(" ",1,1)),
},{preserved})

WavFile = "staredit\\wav\\sel_g.ogg"

--HondonMode
--AtkSpeedMode
DisplayPrint(HumanPlayers,{"\x13\x10[ \x04(\x08HP \x04: ",HiddenColor[1][2],HiddenDisplay[1],"\x04) (\x1BATK \x04: ",HiddenColor[2][2],HiddenDisplay[2],"\x04) (\x1FPts \x04: ",HiddenColor[3][2],HiddenDisplay[3],"\x04) (\x10혼돈 옵션 \x04: ",hondondisplay,"\x04) (\x1F공속무한모드 \x04: ",AtkSpeedDisplay,"\x04)  \x10]"})
DoActions(FP,{RotatePlayer({PlayWAVX(WavFile);},HumanPlayers,FP)})
CIfEnd()


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


	Text1 = "\x13\x07난이도\x04를 선택해주세요.\n\x13\x04선택 완료 후 Y버튼을 눌러주세요. 30초 후 자동으로 \x0EEASY\x04모드가 선택됩니다."
	Trigger2X(FP,{},{RotatePlayer({DisplayTextX(Text1,4);},HumanPlayers,FP)})
	Text2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	
	WavFile = "staredit\\wav\\Select.ogg"
	Text1 = {"\x13\x07\n\x13\x04[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x05[E] \x11BURST\n\x13\x04난이도 선택이 완료되었습니다.",
	"\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x04[W] \x08HARD\n\x13\x05[E] \x11BURST\n\x13\x04난이도 선택이 완료되었습니다.",
	"\x13\x07\n\x13\x05[Q] \x0EEASY\n\x13\x05[W] \x08HARD\n\x13\x04[E] \x11BURST\n\x13\x04난이도 선택이 완료되었습니다."}
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


Text1 = "\x13\x08드랍모드\x04를 선택해주세요.\n\x13\x04선택 완료 후 Y버튼을 눌러주세요. 30초 후 자동으로 \x0E일반\x04모드가 선택됩니다."
WavFile = "staredit\\wav\\Sel2.ogg"
Trigger2X(FP,{CDeaths(FP,Exactly,2,ModeSel)},{RotatePlayer({DisplayTextX(Text1,4);PlayWAVX(WavFile)},HumanPlayers,FP)})
Text2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
Text1 = {"\x13\x07\n\x13\x04[Q] \x0E쫄보\x04의 \x04일반모드\n\x13\x05[W] \x08상남자\x04의 \x06드랍모드\n\x13\x05[E] \x10돌아이\x04의 \x11응답없음모드\n\x13\x07모드 선택\x04이 완료되었습니다.",
"\x13\x07\n\x13\x05[Q] \x0E쫄보\x04의 \x04일반모드\n\x13\x04[W] \x08상남자\x04의 \x06드랍모드\n\x13\x05[E] \x10돌아이\x04의 \x11응답없음모드\n\x13\x07모드 선택\x04이 완료되었습니다.\n\x13\x08드랍 또는 \x11응답없음모드 \x04선택으로 \x06공격력\x04이 \x072배 \x04증가하였습니다.",
"\x13\x07\n\x13\x05[Q] \x0E쫄보\x04의 \x04일반모드\n\x13\x05[W] \x08상남자\x04의 \x06드랍모드\n\x13\x04[E] \x10돌아이\x04의 \x11응답없음모드\n\x13\x07모드 선택\x04이 완료되었습니다.\n\x13\x08드랍 또는 \x11응답없음모드 \x04선택으로 \x06공격력\x04이 \x072배 \x04증가하였습니다."}
WavFile = "staredit\\wav\\Select.ogg"

for i = 1, 3 do
	Trigger2X(FP,{CDeaths(FP,Exactly,3,ModeSel);CDeaths(FP,Exactly,i,DMode);},{
		RotatePlayer({DisplayTextX(Text1[i]),PlayWAVX(WavFile)},HumanPlayers,FP)
	})
	end
	
end

Trigger { -- 인트로1
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
	Trigger { -- 드랍모드일경우 강퇴건물 삭제
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,2,DMode);
		},
		actions = {
			KillUnit(115, AllPlayers);
			PreserveTrigger();
			
		},
		}

	
OPArr = {
{"\n\n\n\n\n\n\n\n\n\n\x13\x15★ 마 린 키 우 기 GaLaXy:ReB∞t ★\n\n\n\n\n",0,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x05★ 마 린 키 우 기 GaLaXy:ReB∞t ★\n\n\n\n\n",5,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x10★ 마 린 키 우 기 GaLaXy:ReB∞t ★\n\n\n\n\n",10,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x18★ 마 린 키 우 기 GaLaXy:ReB∞t ★\n\n\n\n\n",15,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x0E★ 마 린 키 우 기 GaLaXy:ReB∞t ★\n\n\n\n\n",20,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x11★ 마 린 키 우 기 GaLaXy:ReB∞t ★\n\n\n\n\n",25,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x16★ 마 린 키 우 기 GaLaXy:ReB∞t ★\n\n\n\n\n",30,nil},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04설명은 Insert키를 참고해주세요\n\n",35,"staredit\\wav\\GameStart.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04설명은 Insert키를 참고해주세요\n\x13\x043\n",35+(36*2),"staredit\\wav\\Countdown.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04설명은 Insert키를 참고해주세요\n\x13\x042\n",35+(36*3),"staredit\\wav\\Countdown.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04설명은 Insert키를 참고해주세요\n\x13\x041\n",35+(36*4),"staredit\\wav\\Countdown.ogg"},
{"\n\n\n\n\n\n\n\n\n\n\x13\x03★ \x04마 린 키 우 기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \x03★\n\x13\x04Creator - GALAXY_BURST\n\x13\x04"..VName.."\n\x13\x04설명은 Insert키를 참고해주세요\n\x13\x04START",35+(36*5),"staredit\\wav\\GameStart2.ogg"}}
for j, k in pairs(OPArr) do
	if k[3] == nil then
		TriggerX(FP,{CDeaths(FP,AtLeast,1,ModeO);CDeaths(FP,AtLeast,k[2],ModeT);},{RotatePlayer({DisplayTextX(k[1],4)},HumanPlayers,FP)})
	else
		TriggerX(FP,{CDeaths(FP,AtLeast,1,ModeO);CDeaths(FP,AtLeast,k[2],ModeT);},{RotatePlayer({DisplayTextX(k[1],4),PlayWAVX(k[3])},HumanPlayers,FP)})
	end
end
CIfOnce(FP,{CDeaths(FP,AtLeast,35+(36*5),ModeT)},{SetCD(GStart,1)})

TriggerX(FP, {CD(GMode,3)}, {SetMemoryW(0x656EB0+(6*2),SetTo,7777),
SetMemoryW(0x656888+(6*2), SetTo, 96),
SetMemoryW(0x6570C8+(6*2), SetTo, 96),
SetMemoryW(0x657780+(6*2), SetTo, 96),
})

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,HiddenATK[2],Exactly,0);--히든모드 적용없을시
		CDeaths(FP,AtLeast,2,DMode); -- 드랍 or 응없모드시 공2배 적용
	},
	actions = {		
		SetMemoryW(0x656EB0+(0*2),Add,70);
		SetMemoryW(0x657678+(0*2),Add,3);
		SetMemoryW(0x656EB0+(1*2),Add,88);
		SetMemoryW(0x657678+(1*2),Add,4);
		SetMemoryW(0x656EB0+(117*2),Add,70);
		SetMemoryW(0x657678+(117*2),Add,6);
		SetMemoryW(0x656EB0+(118*2),Add,300);
		SetMemoryW(0x657678+(118*2),Add,10);
		SetMemoryW(0x656EB0+(119*2),Add,1000);
		SetMemoryW(0x657678+(119*2),Add,40);
		SetMemoryW(0x656EB0+(120*2),Add,150);
		SetMemoryW(0x657678+(120*2),Add,41);
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
TriggerX(FP,{CDeaths(FP,AtLeast,#HiddenCommand,HiddenMode);},{
	SetMemoryX(0x581DDC,SetTo,128*256,0xFF00); --P8 미니맵
	SetMemoryX(0x581DAC,SetTo,128*65536,0xFF0000), --P8컬러
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
		SetMemory(0x662350 + (4*99), Add, i*20000*256);
		SetMemory(0x662350 + (4*12), Add, i*50000*256);
		SetMemory(0x662350 + (4*60), Add, i*167772*256);
		SetMemoryW(0x660E00 + (2*124), Add, i*10000);
		SetMemoryW(0x660E00 + (2*125), Add, i*10000);
		SetMemoryW(0x660E00 + (2*99), Add, i*8000);
		SetMemoryW(0x660E00 + (2*12), Add, i*2000);
	})
	
	TriggerX(FP,{CVar(FP,HiddenPts[2],Exactly,i);},{SetCVar(FP,HPointVar[2],Add,200*i);})
	TriggerX(FP,{CVar(FP,HiddenPtsM[2],Exactly,i);},{SetCVar(FP,HPointVar[2],SetTo,200-(32*i));})


	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtMost,1,DMode); -- 드랍 or 응없모드 없을경우
			CVar(FP,HiddenATK[2],Exactly,i);
		},
		actions = {		
			SetMemoryW(0x656EB0+(0*2),Add,70*i);
			SetMemoryW(0x657678+(0*2),Add,3*i);
			SetMemoryW(0x656EB0+(1*2),Add,88*i);
			SetMemoryW(0x657678+(1*2),Add,4*i);
			SetMemoryW(0x656EB0+(117*2),Add,70*i);
			SetMemoryW(0x657678+(117*2),Add,6*i);
			SetMemoryW(0x656EB0+(118*2),Add,300*i);
			SetMemoryW(0x657678+(118*2),Add,10*i);
			SetMemoryW(0x656EB0+(119*2),Add,600*i);
			SetMemoryW(0x657678+(119*2),Add,40*i);
			SetMemoryW(0x656EB0+(120*2),Add,150*i);
			SetMemoryW(0x657678+(120*2),Add,41*i);
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
			CDeaths(FP,AtLeast,2,DMode); -- 드랍 or 응없모드시 공2배 적용
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
			SetMemoryW(0x656EB0+(118*2),Add,300*i);
			SetMemoryW(0x657678+(118*2),Add,10*i);
			SetMemoryW(0x656EB0+(119*2),Add,600*i);
			SetMemoryW(0x657678+(119*2),Add,40*i);
			SetMemoryW(0x656EB0+(120*2),Add,150*i);
			SetMemoryW(0x657678+(120*2),Add,41*i);
			SetMemoryB(0x6564E0+118,SetTo,2);--공격력 오버플로우 문제로 인한 투사체수로 대체 패치
			SetMemoryB(0x6564E0+119,SetTo,2);--공격력 오버플로우 문제로 인한 투사체수로 대체 패치
			SetMemoryB(0x6564E0+120,SetTo,2);--공격력 오버플로우 문제로 인한 투사체수로 대체 패치
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
	SetMemoryX(0x581DDC,SetTo,254*256,0xFF00); --P8 미니맵
	SetMemoryX(0x581DAC,SetTo,254*65536,0xFF0000), --P8컬러
})
Trigger2X(FP, {CV(HondonMode,1)}, {HondonPatchArr})
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



TriggerX(FP,{},{SetSwitch("Switch 201",Set),RotatePlayer({CenterView(4)},HumanPlayers,FP),SetV(BGMType,1),SetResources(Force1,Add,350000,Ore)})
TriggerX(FP,{CV(SetPlayers,1)},{SetResources(Force1,Add,300000,Ore)})
TriggerX(FP,{CV(SetPlayers,2)},{SetResources(Force1,Add,250000,Ore)})
TriggerX(FP,{CV(SetPlayers,3)},{SetResources(Force1,Add,175000,Ore)})
TriggerX(FP,{CV(SetPlayers,4)},{SetResources(Force1,Add,100000,Ore)})

for i = 0, 6 do
	CIf(FP,{HumanCheck(i, 1)})
	DoActions(FP, {Simple_SetLoc(0, 3728*(X2_Mode+1), 384+(i*(32+(X2_Mode*32))), 3728*(X2_Mode+1), 384+(i*(32+(X2_Mode*32)))),CreateUnitWithProperties(3,0,1,i,{energy = 100}),CreateUnitWithProperties(3,20,1,i,{energy = 100})})
	TriggerX(FP,{CV(SetPlayers,1)},{CreateUnitWithProperties(4,0,1,i,{energy = 100}),CreateUnitWithProperties(3,20,1,i,{energy = 100})})
	TriggerX(FP,{CV(SetPlayers,2)},{CreateUnitWithProperties(3,0,1,i,{energy = 100}),CreateUnitWithProperties(2,20,1,i,{energy = 100})})
	TriggerX(FP,{CV(SetPlayers,3)},{CreateUnitWithProperties(2,0,1,i,{energy = 100}),CreateUnitWithProperties(1,20,1,i,{energy = 100})})
	TriggerX(FP,{CV(SetPlayers,4)},{CreateUnitWithProperties(1,0,1,i,{energy = 100}),CreateUnitWithProperties(1,20,1,i,{energy = 100})})
	CIfEnd()
end



for i = 1, 3 do
	for j = 1, 7 do
		TriggerX(FP,{CV(SetPlayers,j),CD(GMode,i)},{RotatePlayer({SetMissionObjectivesX("\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \n\x13"..DifLeaderBoard[i].." "..j.."인 \x04플레이 중입니다. -\n\x13\x0E환전률 : "..(ExArr[i][j]/10).."%\n\x13\x04간단 확률표\n\x13\x04Marine\x0E[65.00%]  \x1BH \x04Marine\x0F[20.00%]  \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x10[8.90%]  \n\x13\x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x11[4.10%] \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ\x08[1.70%]\n\x13\x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ\x1D[0.25%]  \x11Ｑ\x1FＵ\x1BＡ\x16Ｓ\x10Ａ\x1DＲ\x1F[0.05%]\n\x13\x04\x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ\x04 까지 하위 유닛 3기로 \x07조합가능\n\x13\x04환전 : \x03배럭에서 F를 누르세요.")},HumanPlayers,FP),SetV(ExRateV,ExArr[i][j])})
	end
end


CIfEnd()

CIfEnd({SetCp(FP)})
CIfOnce(FP,{Switch("Switch 201",Set),CommandLeastAt(189,20)})
for i = 1, 3 do
	for j = 1, 7 do
		TriggerX(FP,{CV(SetPlayers,j),CD(GMode,i)},{RotatePlayer({SetMissionObjectivesX("\x13\x04마린키우기 \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy\x04:\x1FRe\x11B\x01∞\x07t \n\x13"..DifLeaderBoard[i].." "..j.."인 \x04플레이 중입니다. -\n\x13\x0E환전률 : "..((ExArr[i][j]+50)/10).."%\n\x13\x04간단 확률표\n\x13\x04Marine\x0E[65.00%]  \x1BH \x04Marine\x0F[20.00%]  \x03G\x0Fa\x10L\x0Fa\x03X\x0Fy \x18M\x16arine\x10[8.90%]  \n\x13\x11Ｎ\x07Ｅ\x1FＢ\x1CＵ\x17Ｌ\x11Ａ\x11[4.10%] \x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ\x08[1.70%]\n\x13\x07Ｓ\x1FＵ\x1CＰ\x0EＥ\x0FＲ\x10Ｎ\x17Ｏ\x11Ｖ\x08Ａ\x1D[0.25%]  \x11Ｑ\x1FＵ\x1BＡ\x16Ｓ\x10Ａ\x1DＲ\x1F[0.05%]\n\x13\x04\x10Ｔ\x07Ｅ\x0FＲＲ\x1FＡ\x04 까지 하위 유닛 3기로 \x07조합가능\n\x13\x04환전 : \x03배럭에서 F를 누르세요.")},HumanPlayers,FP)})
	end
end
CIfEnd()

end