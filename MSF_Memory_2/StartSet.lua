-- NonCtrigArea


Trigger {
	players = {AllPlayers},
	conditions = {  
		
	},
	actions = {
		SetMemoryX(0x57EEE8 + 36*4,SetTo,1,0xFF);
		SetMemoryX(0x57EEE8 + 36*5,SetTo,1,0xFF);
		SetMemoryX(0x57EEE8 + 36*6,SetTo,1,0xFF);
		PreserveTrigger();
		
	},
}
Trigger {
	players = {Force2},
	conditions = {  
		Command(CurrentPlayer,AtLeast,10,42);
		
	},
	actions = {
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
		KillUnit(35,CurrentPlayer);
		PreserveTrigger();
		
	},
}
Trigger {
	players = {Force2},
	conditions = {
		Command(CurrentPlayer,AtLeast,25,37);
		
	},
	actions = {
		RemoveUnitAt(1, 37, 64, CurrentPlayer);
		PreserveTrigger();
		
	},
}
Trigger {
	players = {P8},
	actions = {
		KillUnit("Vespene Geyser",AllPlayers);
		ModifyUnitShields(All,174,AllPlayers,"Anywhere",100); --174 Temple
		ModifyUnitShields(All,200,AllPlayers,"Anywhere",100); --200 Generator
		KillUnit(84,Force2);
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
		SetMemory(0x515BB0,SetTo,256);--0 PlayerMarine
		SetMemory(0x515BB4,SetTo,256);--1 PlayerMarine
		SetMemory(0x515BB8,SetTo,256);--2 PlayerMarine
		SetMemory(0x515BBC,SetTo,256);--3 PlayerMarine
		SetMemory(0x515BC0,SetTo,256*120);--4
		SetMemory(0x515BC4,SetTo,256*80);--5
		SetMemory(0x515BC8,SetTo,256);--6
		SetMemory(0x515BCC,SetTo,256);--7 default
		SetMemory(0x515BD0,SetTo,256*2);--8 노멀마린
		SetMemory(0x515BD4,SetTo,256*4);--9 영웅마린
		SetMemory(0x6616B0, SetTo, 2097615);
		SetMemory(0x6643B0, SetTo, 536870916);
		SetMemory(0x666460, SetTo, 32965359);-- 204번유닛 이펙트유닛으로 사용
	},
}
