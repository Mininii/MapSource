
dofile("lua/Loader.lua")
dofile("Map4Source/LibraryFor322.lua")

FP = P8
EUDTurbo(FP) -- 뎡터보
Limit = 1

RepUnitPtr = 0x593000 -- 유닛 데이터 저장 장소
-- 0x58f500 SelHP 0x58f504 MarHP 0x58f508 SelSh

function Call_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function Call_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end



MarID = {0,1,16,20,32,99,100} 
XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0"}
SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4}

HumanPlayers = {0,1,2,3,4,5,6,128,129,130,131}
MedicTrig = {34,9,2,3}
SetForces({P1,P2,P3,P4,P5,P6},{P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
StartCtrig()
SpeedVar = CreateVar(4)
CurrentSpeed = CreateVar()
CreateTableSet({
"MarHP",
})
for i = 0, 6 do
	table.insert(MarHP,CreateVar())
end
CreateVariableSet({"RepHeroIndex","RepX","RepY","BackupCp","CPos","CPosX","CPosY","BacpupPtr","CurrentUID","SelPTR","SelEPD","MarTblPtr","SelHP",
"SelHPEPD","MarHPEPD","SelSh","SelShEPD","SelPl","SelMaxHP","CunitP","SelOPEPD","CurCunitI"
})
ExDeaths1 = DefineDeathTable(0x1000)


CreateCCodeSet(ExDeaths1,{"OPConsole","GiveConsole","F12KeyToggle","IntroT","LimitX","LimitC"})

CJump(AllPlayers,0x700)
Include_CtrigPlib(360,"Switch 100",1)

SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()
LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
SetCallEnd()
CJumpEnd(AllPlayers,0x700)
NoAirCollisionX(FP)
Enable_PlayerCheck()



DoActions(AllPlayers,{PlayWAV("staredit\\wav\\ExceedOP.ogg")},1)
CIfOnce(FP,nil) -- OnPluginStart
dofile("Map4Source/EUDinit.lua") -- 루아파일 불러오기



CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	CIf(FP,{TDeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)})
		Call_SaveCp()
		CIf(FP,{TTMemory(_Add(BackupCp,6),NotSame,58)}) -- 발키리 저리가
			f_Read(FP,_Sub(BackupCp,9),CPos)
			f_Read(FP,BackupCp,CunitP,"X",0xFF)
			f_Read(FP,_Add(BackupCp,6),RepHeroIndex)
			CMov(FP,0x6509B0,EPD(RepUnitPtr))
			NWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
			CAdd(FP,0x6509B0,2)
			NWhileEnd()
			CDoActions(FP,{
			TSetDeaths(CurrentPlayer,SetTo,CPos,0),
			SetMemory(0x6509B0,Add,1),
			TSetDeathsX(CurrentPlayer,SetTo,RepHeroIndex,0,0xFF),
			TSetDeathsX(CurrentPlayer,SetTo,_Mul(CunitP,_Mov(256)),0,0xFF00),
			})
		CIfEnd()
		Call_LoadCp()
	CIfEnd()
	CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
CMov(FP,RepHeroIndex,0)
CWhile(FP,CVar(FP,RepHeroIndex[2],AtMost,227))
TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,58)},{SetCVar(FP,RepHeroIndex[2],Add,1)},{Preserved}) -- 발키리 나가
CDoActions(FP,{TModifyUnitEnergy(All,RepHeroIndex,AllPlayers,64,0),TRemoveUnit(RepHeroIndex,AllPlayers)})
CAdd(FP,RepHeroIndex,1)
CWhileEnd()

CMov(FP,0x6509B0,EPD(RepUnitPtr))-- 데이터화 한 유닛 배치하는 코드
CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
	Call_SaveCp()
	f_Read(FP,BackupCP,CPosX,"X",0xFFFF)
	f_Read(FP,BackupCP,CPosY,"X",0xFFFF0000)
	f_Read(FP,_Add(BackupCP,1),CunitP,"X",0xFF00)
	f_Read(FP,_Add(BackupCP,1),RepHeroIndex,"X",0xFF)
	f_Div(FP,CPosY,CPosY,_Mov(0x10000))
	f_Div(FP,CunitP,_Mov(256))
	CDoActions(FP,{
	SetMemory(0x58DC60 + 0x14*0,SetTo,0),
	SetMemory(0x58DC68 + 0x14*0,SetTo,0),
	SetMemory(0x58DC64 + 0x14*0,SetTo,0),
	SetMemory(0x58DC6C + 0x14*0,SetTo,0),
	TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
	TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
	TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
	TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
	TCreateUnit(1, RepHeroIndex, 1, CunitP)
	})
	
	Call_LoadCp()
	DoActions(FP,{SetDeaths(CurrentPlayer,SetTo,0,0),
		SetMemory(0x6509B0,Add,1),
		SetDeaths(CurrentPlayer,SetTo,0,0),
		SetMemory(0x6509B0,Add,1)
	})
CWhileEnd()
CMov(FP,0x6509B0,FP)
f_GetTblptr(FP,MarTblPtr,1501)
DoActions(FP,{SetMemory(0x5124F0,SetTo,SpeedV[4])})
for i = 1, 7 do
DoActions(i-1,CreateUnit(15,MarID[i],1+i,i-1),1)
CMov(FP,MarHP[i],999)
CMov(FP,0x58F460+(i*4),1000)
end

f_Read(FP,0x58F500,"X",SelHPEPD) -- 플립에서 전송받은 플립 변수 주소 입력
f_Read(FP,0x58F504,"X",MarHPEPD) -- 플립에서 전송받은 플립 변수 주소 입력
f_Read(FP,0x58F508,"X",SelShEPD) -- 플립에서 전송받은 플립 변수 주소 입력
f_Read(FP,0x58F50C,"X",SelOPEPD) -- 플립에서 전송받은 플립 변수 주소 입력
CIfEnd(SetMemory(0x6509B0,SetTo,FP)) -- OnPluginStart End
DoActions2(FP,PatchArrPrsv)
DoActionsX(FP,SetCDeaths(FP,Add,1,IntroT))
for i = 0, 6 do
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,i*5,IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", i).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n",4);
			},HumanPlayers,FP);
		},
	}
end

for i = 9, 19 do
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,i*5,IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", 6)..""..string.rep("   ", i-1).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n\n\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n",4);
			},HumanPlayers,FP);


		},
	}
end

	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,100,IntroT);
		},
		actions = {
			RotatePlayer({
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX("\n\n"..string.rep("\t", 6)..""..string.rep("   ", 19).."\x1F== \x04마린키우기 \x08ＵｎＬｉｍｉＴ \x1CＥｘｃｅｅＤ \x1F==\n"..string.rep("\t", 6)..""..string.rep("   ", 19).."\x02\x04Ver. 0.0\n"..string.rep("\t", 6)..""..string.rep("   ", 19).."\x1FCtrig \x04Assembler \x07v5.3\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ\n\n",4);
			DisplayTextX("\x13\x04"..string.rep("―", 56),4);
			DisplayTextX(string.rep("\t", 6)..""..string.rep("   ", 19).."\x03Made \x06by \x04GALAXY_BURST\n\n",4);
			},HumanPlayers,FP);
		},
	}
--[[
MSQC KeySensor
ESC : 199
LeftKey : 201
RightKey : 200
F12 : 202
]]

CIfX(FP,Never()) -- 상위플레이어 단락 시작
	for i = 0, 6 do
	CElseIfX(PlayerCheck(i,1),SetMemory(0x6509B0,SetTo,i))
	end
CIfXEnd()
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,202),CDeaths(FP,Exactly,0,OPConsole)},{SetCDeaths(FP,SetTo,1,OPConsole),SetDeaths(CurrentPlayer,SetTo,0,202)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,202),CDeaths(FP,Exactly,1,OPConsole)},{SetCDeaths(FP,SetTo,0,OPConsole),SetDeaths(CurrentPlayer,SetTo,0,202)},{Preserved})
DoActionsX(FP,SetCDeaths(FP,SetTo,0,F12KeyToggle))
CIf(FP,CDeaths(FP,AtLeast,1,OPConsole))
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,200),CVar(FP,SpeedVar[2],AtMost,9)},{SetCVar(FP,SpeedVar[2],Add,1)},{Preserved})
TriggerX(FP,{Deaths(CurrentPlayer,AtLeast,1,201)},{SetCVar(FP,SpeedVar[2],Subtract,1)},{Preserved})

--DoActions(FP,DisplayText("현재 오피콘솔열려잇음테스트",4))

CIfEnd()
CMov(FP,0x6509B0,FP) -- RecoverCP 상위플레이어 단락 끝

CIf(FP,{TTCVar(FP,CurrentSpeed[2],NotSame,SpeedVar)})
CMov(FP,CurrentSpeed,SpeedVar)
for i = 1, 10 do
Trigger { -- No comment (E93EF7A9)
	players = {FP},
	conditions = {
		Label(0);
		CVar(FP,SpeedVar[2],Exactly,i)
	},
	actions = {PreserveTrigger();
		RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),
		DisplayTextX("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i].." \x07』", 0)},HumanPlayers,FP);
		SetMemory(0x5124F0,SetTo,SpeedV[i]);
	},
}
end
CIfEnd()
for i = 0, 6 do
CIf(FP,PlayerCheck(i,1))
	CIf(FP,{-- 메딕트리거 귀찮아서 한번에 처리하기;
		TTOR({
			Command(i,AtLeast,1,MedicTrig[1]),
			Command(i,AtLeast,1,MedicTrig[2]),
			Command(i,AtLeast,1,MedicTrig[3]),
			Command(i,AtLeast,1,MedicTrig[4]),
		})
	},{
		RemoveUnit(MedicTrig[1],i),
		RemoveUnit(MedicTrig[2],i),
		RemoveUnit(MedicTrig[3],i),
		RemoveUnit(MedicTrig[4],i),
	})
	for j = 1, 4 do
		DoActions(FP,{
			ModifyUnitHitPoints(All,"Men",i,"Anywhere",100),
			ModifyUnitHitPoints(All,"Buildings",i,"Anywhere",100),
			ModifyUnitShields(All,"Men",i,"Anywhere",100),
			SetMemory(0x582324+(MedicTrig[j]*12)+(i*4),SetTo,0),
			SetMemory(0x584DE4+(MedicTrig[j]*12)+(i*4),SetTo,0)
		})
	end
	CIfEnd()
	CIf(FP,{TTMemory(0x58F464+(i*4),"!=",MarHP[i+1])})
		f_Read(FP,0x58F464+(i*4),MarHP[i+1])
		CMov(FP,0x662350 + (MarID[i+1]*4),_Mul(MarHP[i+1],_Mov(256)))
		CMov(FP,0x515BB0+(i*4),_Div(_Read(0x662350 + (MarID[i+1]*4)),_Mov(1000)))
	CIfEnd()
	CIf(FP,{Memory(0x6284E8+(0x30*i) + 4,AtMost,0)})
	CDoActions(FP,{TSetMemory(SelOPEPD,Add,1)})
	f_Read(FP,0x6284E8+(0x30*i),SelPTR,SelEPD)
		CIf(FP,{CVar(FP,SelPTR[2],AtLeast,1),Memory(0x57F1B0, Exactly, i)})

			f_Read(FP,_Add(SelEPD,2),SelHP)
			f_Read(FP,_Add(SelEPD,19),SelPl,"X",0xFF)
			f_Read(FP,_Add(SelEPD,24),SelSh,"X",0xFFFFFF)
			for j = 0, 6 do
				CIf(FP,CVar(FP,SelPl[2],Exactly,j))
					CMov(FP,SelMaxHP,MarHP[j+1])
				CIfEnd()
			end
			f_Div(FP,SelHP,_Mov(256))
			f_Div(FP,SelSh,_Mov(256))
			CDoActions(FP,{TSetMemory(SelHPEPD,SetTo,SelHP),TSetMemory(MarHPEPD,SetTo,SelMaxHP),TSetMemory(SelShEPD,SetTo,SelSh)})
		CIfEnd()
	CIfEnd()
CIfEnd()
end


CunitCtrig_Part1(FP)
CIf(FP,DeathsX(CurrentPlayer,Exactly,146,0,0xFF))

CSub(FP,0x6509B0,15)
Call_SaveCp()
CMov(FP,CPos,_Read(BackupCp))
CMov(FP,CPosX,_Mov(CPos,0xFFFF))
CMov(FP,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
Simple_SetLocX(FP,0,_Sub(CPosX,32*4),_Sub(CPosY,32*4),_Add(CPosX,32*4),_Add(CPosY,32*4))
Trigger { --
	players = {FP},
	conditions = {
	},
	actions = {CreateUnit(5,40,1,P8);Order("Men",P8,1,Patrol,5);PreserveTrigger();
	},
}
Call_LoadCp()
CAdd(FP,0x6509B0,15)

CIfEnd()
ClearCalc()
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X2(i,{
DeathsX(19025+(84*i)+40,AtLeast,1*16777216,0,0xFF000000),
DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00),
},
{SetDeathsX(19025+(84*i)+40,SetTo,0*16777216,0,0xFF000000),
SetCVar(FP,CurCunitI[2],SetTo,i),
MoveCp(Add,25*4),
})
end
CunitCtrig_End()




CJump(FP,0x0)
InstallCVariable()
CJumpEnd(FP,0x0)
EndCtrig()
ErrorCheck()