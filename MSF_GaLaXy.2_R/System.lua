function System()
 
    


-- 시체 상시검사 단락
CJump(FP,0x103) -- if NonGameStart
CunitCtrig_Part1(FP)
MoveCp("X",25*4)
function Call_GunPosSave(BdID)
CallTriggerX(FP,GunPosSave_CallIndex,DeathsX(CurrentPlayer,Exactly,BdID,0,0xFF))
end
Call_GunPosSave(132)
Call_GunPosSave(133)
Call_GunPosSave(216)
Call_GunPosSave(190)
Call_GunPosSave(147)
Call_GunPosSave(156)
Call_GunPosSave(109)
Call_GunPosSave(173)
Call_GunPosSave(201)
Call_GunPosSave(175)
Call_GunPosSave(152)
Call_GunPosSave(151)
Call_GunPosSave(148)
Call_GunPosSave(150)
Call_GunPosSave(154)
Call_GunPosSave(200)
CIf(FP,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCp()
Trigger2X(FP,{
	DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);},{
	CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."HM".._0D,4)},HumanPlayers,FP);
	SetDeaths(j-1,Subtract,1,20);
	SetCDeaths(FP,Add,1,HMDeaths[j]);
	SetCDeaths(FP,Add,1,Die_SEC);},{preserved})
	f_LoadCp()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()
CIf(FP,DeathsX(CurrentPlayer,Exactly,16,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCp()
Trigger2X(FP,{
	DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);},{
	CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."RM".._0D,4)},HumanPlayers,FP);
	SetDeaths(j-1,Subtract,1,27);
	SetScore(j-1,Add,3,Custom);
	SetCDeaths(FP,Add,1,Die_SEC);},{preserved})
	f_LoadCp()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

CIf(FP,DeathsX(CurrentPlayer,Exactly,12,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCp()
Trigger2X(FP,{
	DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);},{
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."Su".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,27);
		SetScore(j-1,Add,100,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);},{preserved})
	f_LoadCp()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()


CIf(FP,DeathsX(CurrentPlayer,Exactly,0,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCp()
Trigger2X(FP,{
	DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);},{
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."Te".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,27);
		SetScore(j-1,Add,5,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);},{preserved})
	f_LoadCp()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()


CIf(FP,DeathsX(CurrentPlayer,Exactly,100,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCp()
Trigger2X(FP,{
	DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);},{
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."LM".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,100);
		SetScore(j-1,Add,1,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);},{preserved})
	f_LoadCp()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()
CIf(FP,DeathsX(CurrentPlayer,Exactly,60,0,0xFF))
DoActions(FP,MoveCp(Subtract,6*4))
for j = 1, 6 do
f_SaveCp()
Trigger2X(FP,{
	DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF);},{
		CopyCpAction({DisplayTextX("\x0D\x0D\x0D"..Color[j].."Qua".._0D,4)},HumanPlayers,FP);
		SetDeaths(j-1,Subtract,1,60);
		SetScore(j-1,Add,500,Custom);
		SetCDeaths(FP,Add,1,Die_SEC);},{preserved})
	f_LoadCp()
end
DoActions(FP,MoveCp(Add,6*4))
CIfEnd()

DoActions(FP,MoveCp(Subtract,16*4))
NIf(FP,DeathsX(CurrentPlayer,AtLeast,1*65536,0,0xFF0000))
DoActions(FP,MoveCp(Add,16*4))
------------

for i = 1, #HeroIndexArr do
NIf(FP,DeathsX(CurrentPlayer,Exactly,HeroIndexArr[i],0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
end
NIf(FP,DeathsX(CurrentPlayer,Exactly,162,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
NIf(FP,DeathsX(CurrentPlayer,Exactly,176,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
NIf(FP,DeathsX(CurrentPlayer,Exactly,177,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()
NIf(FP,DeathsX(CurrentPlayer,Exactly,178,0,0xFF))
CallTrigger(FP,Call_HeroKillPoint)
NIfEnd()

DoActions(FP,MoveCp(Subtract,16*4))
NIfEnd()
DoActions(FP,MoveCp(Add,16*4))

DoActions(FP,{MoveCp(Add,15*4),SetDeathsX(CurrentPlayer,SetTo,0*16777216,0,0xFF000000),MoveCp(Subtract,31*4),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000)})
ClearCalc()
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
DeathsX(EPDF(0x628298-0x150*i+(40*4)),AtLeast,1*16777216,0,0xFF000000),
DeathsX(EPDF(0x628298-0x150*i+(19*4)),Exactly,0*256,0,0xFF00),
},
{MoveCp(Add,25*4)})
end
CunitCtrig_End()
CWhile(FP,CDeaths(FP,AtLeast,1,Die_SEC),SetCDeaths(FP,Subtract,1,Die_SEC))
Trigger2X(FP,{CDeaths(FP,AtMost,4,SoundLimit)},{RotatePlayer({PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP),SetCDeaths(FP,Add,1,SoundLimit)},{preserved})
CWhileEnd()
DoActionsX(FP,SetCDeaths(FP,Add,1,SoundLimitT))
TriggerX(FP,{CDeaths(FP,AtLeast,100,SoundLimitT)},{SetCDeaths(FP,SetTo,0,SoundLimit),SetCDeaths(FP,SetTo,0,SoundLimitT)},{preserved})

	CIf(FP,{CV(AtkSpeedMode,1,AtLeast)})
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)'
		Trigger2(FP, {
			DeathsX(19025+(84*i)+19,AtMost,5,0,0xFF),
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00),
			--DeathsX(19025+(84*i)+21,AtLeast,(1*256),0,0xFFFF00),
		},{
			SetDeaths(19025+(84*i)+21,SetTo,0,0),
			SetDeathsX(19025+(84*i)+21,SetTo,0,1,0xFF00),
			},{preserved})
	end

	CIfEnd()

Install_boss()
CIf(FP,CVar(FP,count[2],AtMost,GunLimit))
Create_G_CA_Arr()
CIfEnd()
CIfX(FP,{CVar(FP,count[2],AtMost,GunLimit)}) -- 건작함수 제어
DoActions(FP,{
	SetInvincibility(Disable,132,Force2,64);
	SetInvincibility(Disable,133,Force2,64);
})
CElseX()
DoActions(FP,{
	SetInvincibility(Enable,132,Force2,64);
	SetInvincibility(Enable,133,Force2,64);
})
CIfXEnd()



CMov(FP,Actived_Gun,0)
for i = 0, 127 do
	CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
		Var_InputCVar,
		SetCtrigX("X",G_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
		SetCVar(FP,f_GunNum[2],SetTo,i),
		SetCVar(FP,Actived_Gun[2],Add,1),
		SetNext("X",f_Gun,0),SetNext(f_Gun+1,"X",1), -- Call f_Gun
		SetCtrigX("X",f_Gun+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
		SetCtrigX("X",f_Gun+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
		SetCtrig1X("X",f_Gun+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
	}, 1, 0x500+i)
end



CIf(FP,CVar(FP,HondonMode[2],AtLeast,1))
HondonT = CreateCcode()
CIf(FP,CDeaths(FP,AtMost,0,HondonT),SetCDeaths(FP,SetTo,10,HondonT))
CunitCtrig_Part1(FP)
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
for i = 37,57 do
	NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
end
for i = 60,81 do
	NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
end
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,12,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,80,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,21,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,88,0,0xFF))
NJumpX(FP,0x100,DeathsX(CurrentPlayer,Exactly,86,0,0xFF))

ClearCalc()
NJumpXEnd(FP,0x100)

DoActions(FP,MoveCp(Subtract,12*4))
Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		SetDeaths(CurrentPlayer,SetTo,20000,0);
		MoveCp(Add,5*4);
		SetDeathsX(CurrentPlayer,SetTo,4000,0,0xFFFF);
		MoveCp(Subtract,10*4);
		SetDeathsX(CurrentPlayer,SetTo,127*65536,0,0xFF0000);
		MoveCp(Add,5*4);
		PreserveTrigger();
	}
}

ClearCalc()

CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
	DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtLeast,1*256,0,0xFF00),
	
},
{
	MoveCp(Add,25*4)})
end
CunitCtrig_End()
CIfEnd()
CIfEnd()


if Limit == 1 then
CIf(FP,CDeaths(FP,AtLeast,1,TestMode),{SetSwitch("Switch 211",Set)})

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		Deaths(P1,AtLeast,1,201);
		
	},
	actions = {
		--SetDeaths(FP,SetTo,1,200);
		ModifyUnitEnergy(All,"Any unit",Force2,"Anywhere",0);
		RemoveUnit("Zerg Lair",Force2);
		RemoveUnit("Hive",Force2);
		RemoveUnit("Mature Crysalis",Force2);
		RemoveUnit("Stasis Cell",Force2);
		RemoveUnit("Xel'Naga Temple",Force2);
		RemoveUnit("Small Chrysalis",Force2);
		SetCDeaths(FP,SetTo,6001,GunBossAct);
		SetCDeaths(FP,SetTo,2,FormCon);
	}
	}
Trigger {
	players = {FP},
	conditions = {
	},
	actions = {
		SetMemory(0x6509B0, SetTo, 0);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 1);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 2);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 3);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 4);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, 5);
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemory(0x6509B0, SetTo, FP);
		PreserveTrigger();
		
	}
	}
--	local TestV = CreateVar(FP)
--	local TestV2 = CreateVar(FP)
--DoActionsX(FP,SetCtrigX("X",TestV[2],0x15C,0,SetTo,"X",0x580,CAddr("CMask",2),1,0))
--f_Read(FP,TestV,TestV2)
--CMov(FP,0x57F120,TestV2)
CIfEnd()
end
--[[
for i = 0, 1699 do -- 오토스팀
Trigger {
	players = {FP},
	conditions = {
		DeathsX(EPDF(0x628298-0x150*i+(19*4)),AtMost,4,0,0xFF),
		DeathsX(EPDF(0x628298-0x150*i+(69*4)),AtMost,0,0,0xFF00),
	},
	actions = {
		SetDeathsX(EPDF(0x628298-0x150*i+(69*4)),SetTo,255*256,0,0xFF00);
		PreserveTrigger();
	}
}
end
]]


CJumpEnd(FP,0x103) -- if NonGameStart End
SetRecoverCp()
RecoverCp(FP)
end