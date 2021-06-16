function LairHeroSpawnSet(Player,Level,UnitID1,UnitID2,SizeofPolygon,Radius,Angle,Points,Sw1,Sw2)
	local Sw1Status1 = Sw1
	local Sw1Status2 = Sw2
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
	local Sw1Status1 = Sw2
	local Sw1Status2 = Sw1
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
end

function HiveHeroSpawnSet(Player,Level,UnitID1,UnitID2,SizeofPolygon,Radius,Angle,Points,Sw1,Sw2)
	local Sw1Status1 = Sw1
	local Sw1Status2 = Sw2
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
	local Sw1Status1 = Sw2
	local Sw1Status2 = Sw1
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
end

function HeroSpawnSetForBYD(Player,Level,UnitID1,UnitID2,Sw1,Sw2,BYDOutPut)
	local Sw1Status1 = Sw1
	local Sw1Status2 = Sw2
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID1)}, {Preserved})
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID2)}, {Preserved})
	local Sw1Status1 = Sw2
	local Sw1Status2 = Sw1
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID1)}, {Preserved})
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID2)}, {Preserved})
end



function TemRotate()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CAdd(FP,TemX,Dt)
	CDiv(FP,TemAngle,TemX,270)
	CA_Rotate(TemAngle) -- SX 만큼 회전
end
function TemRotate2()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CDiv(FP,TemAngle2,_Mul(B6_RT,10),333)
	CA_Rotate(TemAngle2) -- SX 만큼 회전
end


-- init_Trig


Trigger {
	players = {AllPlayers},
	actions = {
		SetAllianceStatus(AllPlayers,Ally);
	},
}
Trigger { -- StartPCheck
	players = {Force1},
	actions = {
		SetDeaths(CurrentPlayer,SetTo,1,"Psi Emitter");
	},
}
Trigger {
	players = {P7},
	actions = {
		RunAIScript("Turn ON Shared Vision for Player 6");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetResources(CurrentPlayer,SetTo,10000000,OreAndGas);
		RunAIScriptAt("Expansion Zerg Campaign Insane",21);
		RunAIScriptAt("Value This Area Higher",21);
		SetMemory(0x582144 + (4 * 6),SetTo,1600);
		SetMemory(0x5821A4 + (4 * 6),SetTo,1600);
		ModifyUnitEnergy(All,"Any unit",Force2,"Anywhere",100);
		SetSwitch("Switch 1", Random);
		},
	}
Trigger { -- 보스몹 생성
	players = {P8},
	actions = {
		RunAIScript("Turn ON Shared Vision for Player 6");
		RunAIScript("Turn ON Shared Vision for Player 7");
		SetResources(CurrentPlayer,SetTo,10000000,OreAndGas);
		RunAIScriptAt("Expansion Zerg Campaign Insane",20);
		RunAIScriptAt("Value This Area Higher",20);
		SetMemory(0x582144 + (4 * 7),SetTo,1600);
		SetMemory(0x5821A4 + (4 * 7),SetTo,1600);
		SetInvincibility(Disable,"Mineral Field (Type 1)",AllPlayers,"Anywhere");
		SetInvincibility(Disable,"Mineral Field (Type 2)",AllPlayers,"Anywhere");
		SetInvincibility(Disable,"Mineral Field (Type 3)",AllPlayers,"Anywhere");
		GiveUnits(All,"Mineral Field (Type 1)",P12,"Anywhere",P7);
		GiveUnits(All,"Mineral Field (Type 2)",P12,"Anywhere",P7);
		GiveUnits(All,"Mineral Field (Type 3)",P12,"Anywhere",P7);


		CreateUnit(1,30,68,P6);
		SetInvincibility(Enable,30,P6,"Anywhere");
		GiveUnits(1,30,P6,"Anywhere",P12);
		CreateUnit(1,12,184,P6);
		SetInvincibility(Enable,12,P6,"Anywhere");
		GiveUnits(1,12,P6,"Anywhere",P12);    
		SetMemoryX(0x669F14, SetTo, 16*256,0xFF00);
		CreateUnit(1,82,214,P6);
		SetInvincibility(Enable,82,P6,"Anywhere");
		GiveUnits(1,82,P6,"Anywhere",P12);
		SetMemoryX(0x669F14, SetTo, 0*256,0xFF00);
		},
	}
Trigger {
	players = {Force2},
	conditions = {  
		Command(CurrentPlayer,AtLeast,10,42);
		
	},
	actions = {
		KillUnitAt(1,42,"Anywhere",CurrentPlayer);
		PreserveTrigger();
		
	},
}
Trigger {
	players = {Force2},
	conditions = {
		Command(CurrentPlayer,AtLeast,50,35);
		
	},
	actions = {
		KillUnit(35,CurrentPlayer);
		PreserveTrigger();
		
	},
}
Trigger { -- 컴퓨터 플레이어 색상 설정
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		RunAIScript("Turn ON Shared Vision for Player 7");
		RunAIScript("Turn ON Shared Vision for Player 8");
		SetMemoryX(0x581DDC,SetTo,128*1,0xFF); --P7 미니맵 
		SetMemoryX(0x581DA4,SetTo,128*65536,0xFF0000), --P7 컬러
		GiveUnits(All,125,P6,"Anywhere",P12);
		
},
}

Trigger { -- EUD Editor Preserve
	players = {P6},
	conditions = {
		Always();
	},
	actions = {
		SetMemory(0x660B10, SetTo, 5);
		SetMemory(0x660A74, SetTo, 327682);
		SetMemory(0x660A7C, SetTo, 131072);
		SetMemory(0x660A80, SetTo, 131074);
		SetMemory(0x660A84, SetTo, 131072);
		SetMemory(0x660A88, SetTo, 2);
		SetMemory(0x660A94, SetTo, 131072);
		SetMemory(0x660AB4, SetTo, 2);
		SetMemory(0x660AD8, SetTo, 327680);
		SetMemory(0x660A9C, SetTo, 5);
		SetMemory(0x660ADC, SetTo, 5);
		SetMemory(0x660AE8, SetTo, 327685);
		SetMemory(0x660AF0, SetTo, 327685);
		SetMemory(0x660AF4, SetTo, 327685);
		SetMemory(0x660AF8, SetTo, 327680);
		SetMemory(0x660AFC, SetTo, 131077);
		SetMemory(0x660B00, SetTo, 14090245);
		SetMemory(0x660B14, SetTo, 327680);
		SetMemory(0x660B18, SetTo, 14942213);
		SetMemory(0x660B1C, SetTo, 5);
		SetMemory(0x660B68, SetTo, 17760527);
		PreserveTrigger();
		Comment("EUD Editor Preserve");
	},
}
Trigger { -- 퍼센트 데미지 세팅
	players = {P6},
	actions = {
		SetMemory(0x515B88,SetTo,256);---------크기 0
		SetMemory(0x515B8C,SetTo,256);---------크기 1
		SetMemory(0x515B90,SetTo,256);---------크기 2
		SetMemory(0x515B94,SetTo,256);---------크기 3
		SetMemory(0x515B98,SetTo,256);---------크기 4
		SetMemory(0x515B9C,SetTo,256);---------크기 5
		SetMemory(0x515BA0,SetTo,256);---------크기 6
		SetMemory(0x515BA4,SetTo,256);---------크기 7
		SetMemory(0x515BA8,SetTo,256);---------크기 8
		SetMemory(0x515BAC,SetTo,256);---------크기 9
		SetMemory(0x515BC4,SetTo,20480);
		SetMemory(0x515BC8,SetTo,10240);
		SetMemory(0x515BCC,SetTo,5120);
		SetMemory(0x515BD0,SetTo,40960);
		SetMemory(0x515BD4,SetTo,256);
	},
}


Trigger {
	players = {P6},
	actions = {
		KillUnit("Vespene Geyser",AllPlayers);
		ModifyUnitShields(All,174,AllPlayers,"Anywhere",100); --174 Temple
		ModifyUnitShields(All,200,AllPlayers,"Anywhere",100); --200 Generator
		ModifyUnitEnergy(All,8,Force2,"Anywhere",100);
		PreserveTrigger();
	}
}
