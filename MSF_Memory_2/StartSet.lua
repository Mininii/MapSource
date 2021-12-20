Trigger {
	players = {Force2},
	conditions = {  
		Command(CurrentPlayer,AtLeast,10,42);
		
	},
	actions = {
		ModifyUnitEnergy(All,42,CurrentPlayer,64,0);
		KillUnit(42,CurrentPlayer);
		PreserveTrigger();
		
	},
}
Trigger {
	players = {Force2},
	conditions = {
		Command(CurrentPlayer,AtLeast,25,35);
		
	},
	actions = {
		ModifyUnitEnergy(All,35,CurrentPlayer,64,0);
		KillUnit(35,CurrentPlayer);
		PreserveTrigger();
		
	},
}
Trigger {
	players = {P8},
	actions = {
		KillUnit("Vespene Geyser",AllPlayers);
		ModifyUnitShields(All,174,AllPlayers,"Anywhere",100); --174 Temple
		ModifyUnitShields(All,200,AllPlayers,"Anywhere",100); --200 Generator
		ModifyUnitEnergy(All,8,Force2,"Anywhere",100);
		PreserveTrigger();
	}
}

Trigger { -- 퍼센트 데미지 세팅
	players = {P8},
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
		SetMemory(0x515BB0,SetTo,256);--0
		SetMemory(0x515BB4,SetTo,256);--1
		SetMemory(0x515BB8,SetTo,256);--2
		SetMemory(0x515BBC,SetTo,256);--3
		SetMemory(0x515BC0,SetTo,256);--4
		SetMemory(0x515BC4,SetTo,20480);--5
		SetMemory(0x515BC8,SetTo,10240);--6
		SetMemory(0x515BCC,SetTo,256);--7
		SetMemory(0x515BD0,SetTo,40960);--8
		SetMemory(0x515BD4,SetTo,256);--9
	},
}
