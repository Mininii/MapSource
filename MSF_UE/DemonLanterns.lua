function Install_DLBoss()
	--Boss : DemonLanterns Made By LucasSpia, Arrenged By Mininii
	--Thanks to LucasSpia
	local SpeedBackupCcode = CreateCcode()
	CIf(FP,NTCond())
	CIfX(FP,Bring(FP, AtLeast, 1, "Dark Templar (Hero)", "Anywhere"),{SetCVar(FP,VResetSw4[2],SetTo,0),SetMemory(0x6509B0,SetTo,FP)})
	CMov(FP,VO(41),LevelT2) -- Diff
	DoActions2(FP,MoveMarineArr2)
	DoActions2(FP,OWTable)
	CIf(FP,{CDeaths(FP,AtMost,0,SpeedBackupCcode)},{SetCDeaths(FP,SetTo,1,SpeedBackupCcode)})
	CMov(FP,SpeedBackup,SpeedVar)
	CIfEnd()

	CMov(FP,SpeedVar,4)
	CMov(FP,0x6509B0,FP)
	Trigger { -- 左什 巷崎 稽追
		players = {P8},
		conditions = {
			
		},
		actions = {
			PreserveTrigger();
			DL_Patch;
			MoveLocation("Boss", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			ModifyUnitShields(All,74,FP,64,100);
			Comment("左什 巷崎 稽追");
		},
	}
	
	Trigger { -- 段鋼 何戚澗暗 号走遂
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 0);
		},
		actions = {
			PreserveTrigger();
			SetVoid(0, SetTo, 1);
			Comment("段鋼 何戚澗暗 号走遂");
		},
	}
	
	Trigger { -- 巷崎 酵焼た焼たたたた
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 0);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C1", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C2", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C3", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C4", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C5", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C6", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C7", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C8", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			SetVoid(1, Add, 1);
			Comment("巷崎 酵焼た焼たたたた");
		},
	}
	
	Trigger { -- 8唖莫 仙戟
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, AtLeast, 1);
			Void(1, AtMost, 7);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(1, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(4, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(5, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(7, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(8, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			Comment("8唖莫 仙戟");
		},
	}
	
	Trigger { -- ??
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, AtLeast, 1);
			Void(1, AtMost, 7);
		},
		actions = {
			PreserveTrigger();
			CreateUnitWithProperties(8, "Protoss Dark Templar", "Create 1", CurrentPlayer, {
				clocked = false,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Protoss Dark Templar", CurrentPlayer, "Create", "C8");
			RemoveUnitAt(All, "Men", "Create", CurrentPlayer);
			KillUnit("Protoss Dark Templar", CurrentPlayer);
			SetVoid(1, Add, 1);
			Comment("??");
		},
	}
	
	Trigger { -- 歯拙失
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, AtMost, 3);
		},
		actions = {
			PreserveTrigger();
			SetVoid(0, SetTo, 0);
			SetVoid(1, SetTo, 0);
			SetVoid(2, Add, 1);
			Comment("歯拙失");
		},
	}
	
	Trigger { -- 何戚澗暗 廃腰 希 号走 闘軒暗 据掘 旭生檎 wait 潤醤馬走幻 益撹 汽什葵生稽 角沿
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 4);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("Foes", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			SetVoid(0, SetTo, 1);
			SetVoid(1, SetTo, 8);
			SetVoid(2, Add, 1);
			Comment("何戚澗暗 廃腰 希 号走 闘軒暗 据掘 旭生檎 wait 潤醤馬走幻 益撹 汽什葵生稽 角沿");
		},
	}
	
	Trigger { -- 戚薙闘 什迭 11
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 5);
		},
		actions = {
			PreserveTrigger();
			Wait(100);
			MoveLocation("C1", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(6, "Zerg Devourer", "C1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C1", CurrentPlayer);
			CreateUnit(13, "Zerg Devourer", "C1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C1", CurrentPlayer);
			KillUnitAt(All, "Men", "C1", Foes);
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(4, "Zerg Devourer", "C1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C1", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C1", Foes);
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(4, "Zerg Devourer", "C1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C1", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C1", Foes);
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(4, "Zerg Devourer", "C1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C1", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C1", Foes);
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(4, "Zerg Devourer", "C1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C1", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C1", Foes);
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(4, "Zerg Devourer", "C1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C1", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C1", Foes);
			CreateUnit(7, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			Wait(10);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭 11");
		},
	}
	
	Trigger { -- 戚薙闘 什迭3
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 6);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C2", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(7, "Zerg Devourer", "C2", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C2", CurrentPlayer);
			CreateUnit(14, "Zerg Devourer", "C2", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C2", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C2", Foes);
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(5, "Zerg Devourer", "C2", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C2", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C2", Foes);
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(5, "Zerg Devourer", "C2", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C2", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C2", Foes);
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(5, "Zerg Devourer", "C2", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C2", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C2", Foes);
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(5, "Zerg Devourer", "C2", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C2", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C2", Foes);
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(5, "Zerg Devourer", "C2", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C2", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C2", Foes);
			CreateUnit(7, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C2", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C2", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C2", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C2", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C2", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C2", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C2", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			Wait(10);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭3");
		},
	}
	
	Trigger { -- 戚薙闘 什迭5
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 7);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C3", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(8, "Zerg Devourer", "C3", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C3", CurrentPlayer);
			CreateUnit(15, "Zerg Devourer", "C3", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C3", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C3", Foes);
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(6, "Zerg Devourer", "C3", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C3", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C3", Foes);
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(6, "Zerg Devourer", "C3", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C3", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C3", Foes);
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(6, "Zerg Devourer", "C3", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C3", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C3", Foes);
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(6, "Zerg Devourer", "C3", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C3", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C3", Foes);
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			CreateUnit(6, "Zerg Devourer", "C3", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C3", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C3", Foes);
			CreateUnit(6, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C3", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C3", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C3", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C3", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C3", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C3", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C3", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			Wait(10);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭5");
		},
	}
	
	Trigger { -- 戚薙闘 什迭6
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 8);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C4", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(1, "Zerg Devourer", "C4", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C4", CurrentPlayer);
			CreateUnit(8, "Zerg Devourer", "C4", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C4", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C4", Foes);
			MoveLocation("C4", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C4", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C4", CurrentPlayer);
			KillUnitAt(All, "Men", "C4", Foes);
			MoveLocation("C4", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C4", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C4", CurrentPlayer);
			KillUnitAt(All, "Men", "C4", Foes);
			MoveLocation("C4", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C4", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C4", CurrentPlayer);
			KillUnitAt(All, "Men", "C4", Foes);
			MoveLocation("C4", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C4", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C4", CurrentPlayer);
			KillUnitAt(All, "Men", "C4", Foes);
			MoveLocation("C4", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C4", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C4", CurrentPlayer);
			KillUnitAt(All, "Men", "C4", Foes);
			MoveLocation("C4", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C4", CurrentPlayer);
			KillUnitAt(All, "Men", "C4", Foes);
			CreateUnit(7, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C4", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C4", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C4", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C4", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C4", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C4", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C4", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			Wait(10);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭6");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 9);
			Void(3, Exactly, 0);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C5", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(2, "Zerg Devourer", "C5", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C5", CurrentPlayer);
			CreateUnit(9, "Zerg Devourer", "C5", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C5", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C5", Foes);
			MoveLocation("C5", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C5", CurrentPlayer);
			CreateUnit(1, "Zerg Devourer", "C5", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C5", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C5", Foes);
			MoveLocation("C5", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C5", CurrentPlayer);
			CreateUnit(1, "Zerg Devourer", "C5", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C5", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C5", Foes);
			MoveLocation("C5", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C5", CurrentPlayer);
			CreateUnit(1, "Zerg Devourer", "C5", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C5", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C5", Foes);
			MoveLocation("C5", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C5", CurrentPlayer);
			CreateUnit(1, "Zerg Devourer", "C5", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C5", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C5", Foes);
			MoveLocation("C5", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C5", CurrentPlayer);
			CreateUnit(1, "Zerg Devourer", "C5", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C5", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C5", Foes);
			MoveLocation("C5", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C5", CurrentPlayer);
			KillUnitAt(All, "Men", "C5", Foes);
			SetVoid(3, SetTo, 1);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 9);
			Void(3, Exactly, 1);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(7, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C5", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C5", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C5", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C5", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C5", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C5", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C5", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			Wait(10);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 10);
			Void(3, Exactly, 1);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C6", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(3, "Zerg Devourer", "C6", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C6", CurrentPlayer);
			CreateUnit(10, "Zerg Devourer", "C6", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C6", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C6", Foes);
			MoveLocation("C6", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C6", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "C6", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C6", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C6", Foes);
			MoveLocation("C6", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C6", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "C6", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C6", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C6", Foes);
			MoveLocation("C6", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C6", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "C6", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C6", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C6", Foes);
			MoveLocation("C6", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C6", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "C6", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C6", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C6", Foes);
			MoveLocation("C6", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C6", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "C6", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C6", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C6", Foes);
			MoveLocation("C6", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C6", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C6", Foes);
			SetVoid(3, SetTo, 2);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 10);
			Void(3, Exactly, 2);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(7, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C6", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C6", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C6", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C6", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C6", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C6", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C6", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			Wait(10);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 11);
			Void(3, Exactly, 2);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C7", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(4, "Zerg Devourer", "C7", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C7", CurrentPlayer);
			CreateUnit(11, "Zerg Devourer", "C7", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C7", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C7", Foes);
			MoveLocation("C7", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C7", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C7", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C7", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C7", Foes);
			MoveLocation("C7", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C7", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C7", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C7", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C7", Foes);
			MoveLocation("C7", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C7", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C7", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C7", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C7", Foes);
			MoveLocation("C7", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C7", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C7", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C7", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C7", Foes);
			MoveLocation("C7", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C7", CurrentPlayer);
			KillUnitAt(All, "Men", "C7", Foes);
			SetVoid(3, SetTo, 3);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 11);
			Void(3, Exactly, 3);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(7, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C7", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C7", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C7", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C7", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C7", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C7", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C7", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			Wait(10);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 12);
			Void(3, Exactly, 3);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C8", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(5, "Zerg Devourer", "C8", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C8", CurrentPlayer);
			CreateUnit(12, "Zerg Devourer", "C8", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C8", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C8", Foes);
			MoveLocation("C8", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C8", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C8", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C8", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C8", Foes);
			MoveLocation("C8", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C8", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C8", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C8", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C8", Foes);
			MoveLocation("C8", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C8", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C8", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C8", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C8", Foes);
			MoveLocation("C8", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C8", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C8", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C8", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C8", Foes);
			MoveLocation("C8", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C8", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "C8", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "C8", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			KillUnitAt(All, "Men", "C8", Foes);
			MoveLocation("C8", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "C8", CurrentPlayer);
			KillUnitAt(All, "Men", "C8", Foes);
			SetVoid(3, SetTo, 4);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 戚薙闘 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 12);
			Void(3, Exactly, 4);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(7, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C8", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C8", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C8", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C8", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C8", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C8", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C8", P9);
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			KillUnit("Danimoth (Arbiter)", AllPlayers);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			MoveLocation("C1", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C2", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C3", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C4", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C5", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C6", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C7", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C8", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			Wait(100);
			SetVoid(2, Add, 1);
			Comment("戚薙闘 什迭");
		},
	}
	
	Trigger { -- 什迭 仙戟
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, AtLeast, 13);
			Void(2, AtMost, 30);
			Void(3, Exactly, 4);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(1, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(4, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(5, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(7, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(8, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			Comment("什迭 仙戟");
		},
	}
	
	Trigger { -- 政間社発
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, AtLeast, 13);
			Void(2, AtMost, 30);
			Void(3, Exactly, 4);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(8, "Protoss Dark Archon", "Create 1", CurrentPlayer);
			CreateUnit(8, "Protoss Observer", "Create 1", CurrentPlayer);
			CreateUnitWithProperties(8, "Zerg Lurker", "Create 1", CurrentPlayer, {
				clocked = false,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			CreateUnitWithProperties(8, "Zeratul (Dark Templar)", "Create 1", CurrentPlayer, {
				clocked = false,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = false,
				hitpoint = 66,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Protoss Observer", CurrentPlayer, "Create", "C8");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Protoss Dark Archon", CurrentPlayer, "Create", "C8");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C8");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C8");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Zeratul (Dark Templar)", CurrentPlayer, "Create", "C1");
			RemoveUnitAt(All, "Men", "Create", CurrentPlayer);
			KillUnit("Protoss Dark Archon", CurrentPlayer);
			KillUnit("Protoss Observer", CurrentPlayer);
			KillUnit("Zerg Lurker", CurrentPlayer);
			Order("Men", CurrentPlayer, "Anywhere", Attack, "Boss");
			SetVoid(2, Add, 1);
			Comment("政間社発");
		},
	}
	
	Trigger { -- 傾戚什 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 30);
			Void(3, Exactly, 4);
		},
		actions = {
			PreserveTrigger();
			CreateUnitWithProperties(1, "Terran Wraith", "C1", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Terran Wraith", CurrentPlayer, "C1", P9);
			CreateUnitWithProperties(1, "Terran Wraith", "C2", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Terran Wraith", CurrentPlayer, "C2", P10);
			CreateUnitWithProperties(1, "Terran Wraith", "C3", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Terran Wraith", CurrentPlayer, "C3", P11);
			CreateUnitWithProperties(1, "Terran Wraith", "C4", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Terran Wraith", CurrentPlayer, "C4", P12);
			CreateUnitWithProperties(1, "Tom Kazansky (Wraith)", "C5", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Tom Kazansky (Wraith)", CurrentPlayer, "C5", P9);
			CreateUnitWithProperties(1, "Tom Kazansky (Wraith)", "C6", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Tom Kazansky (Wraith)", CurrentPlayer, "C6", P10);
			CreateUnitWithProperties(1, "Tom Kazansky (Wraith)", "C7", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Tom Kazansky (Wraith)", CurrentPlayer, "C7", P11);
			CreateUnitWithProperties(1, "Tom Kazansky (Wraith)", "C8", CurrentPlayer, {
				clocked = true,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			GiveUnits(1, "Tom Kazansky (Wraith)", CurrentPlayer, "C8", P12);
			Comment("傾戚什 什迭");
		},
	}
	
	Trigger { -- 傾焼什 据莫 益軒奄
		players = {P8},
		conditions = {
			
			Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere");
			Void(41,AtLeast,3)
		},
		actions = {
			PreserveTrigger();
			KillUnitAt(All, "Men", "C1", Foes);
			KillUnitAt(All, "Men", "C2", Foes);
			KillUnitAt(All, "Men", "C3", Foes);
			KillUnitAt(All, "Men", "C4", Foes);
			KillUnitAt(All, "Men", "C5", Foes);
			KillUnitAt(All, "Men", "C6", Foes);
			KillUnitAt(All, "Men", "C7", Foes);
			KillUnitAt(All, "Men", "C8", Foes);
			Comment("傾焼什 据莫 益軒奄");
		},
	}
	Trigger { -- 傾焼什 据莫 益軒奄
		players = {P8},
		conditions = {
			
			Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere");
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C1", "Terran Wraith", P9, "Anywhere");
			MoveLocation("C2", "Terran Wraith", P10, "Anywhere");
			MoveLocation("C3", "Terran Wraith", P11, "Anywhere");
			MoveLocation("C4", "Terran Wraith", P12, "Anywhere");
			MoveLocation("C5", "Tom Kazansky (Wraith)", P9, "Anywhere");
			MoveLocation("C6", "Tom Kazansky (Wraith)", P10, "Anywhere");
			MoveLocation("C7", "Tom Kazansky (Wraith)", P11, "Anywhere");
			MoveLocation("C8", "Tom Kazansky (Wraith)", P12, "Anywhere");
			Order("Terran Wraith", P9, "Anywhere", Move, "C2");
			Order("Terran Wraith", P10, "Anywhere", Move, "C3");
			Order("Terran Wraith", P11, "Anywhere", Move, "C4");
			Order("Terran Wraith", P12, "Anywhere", Move, "C5");
			Order("Tom Kazansky (Wraith)", P9, "Anywhere", Move, "C6");
			Order("Tom Kazansky (Wraith)", P10, "Anywhere", Move, "C7");
			Order("Tom Kazansky (Wraith)", P11, "Anywhere", Move, "C8");
			Order("Tom Kazansky (Wraith)", P12, "Anywhere", Move, "C1");
			SetVoid(4, Add, 1);
			Comment("傾焼什 据莫 益軒奄");
		},
	}
	
	CIf(FP,Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere"))
		GetLocCenter("C1",CX,CY)
		f_Recall(nil,CX,CY)
		GetLocCenter("C2",CX,CY)
		f_Recall(nil,CX,CY)
		GetLocCenter("C3",CX,CY)
		f_Recall(nil,CX,CY)
		GetLocCenter("C4",CX,CY)
		f_Recall(nil,CX,CY)
		GetLocCenter("C5",CX,CY)
		f_Recall(nil,CX,CY)
		GetLocCenter("C6",CX,CY)
		f_Recall(nil,CX,CY)
		GetLocCenter("C7",CX,CY)
		f_Recall(nil,CX,CY)
		GetLocCenter("C8",CX,CY)
		f_Recall(nil,CX,CY)
	CIfEnd()
	CMov(FP,0x6509B0,FP)
	CIf(FP,Void(4, Exactly, 7),SetVoid(4, SetTo, 0))
	Trigger { -- 政間 社発
		players = {P8},
		conditions = {
			
			Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere");
			Bring(AllPlayers, AtLeast, 1, "Terran Wraith", "Anywhere");
			
		},
		actions = {
			PreserveTrigger();
			CreateUnitWithProperties(8, "Zerg Lurker", "Create 1", CurrentPlayer, {
				clocked = false,
				burrowed = true,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			CreateUnitWithProperties(8, "Edmund Duke (Siege Mode)", "Create 1", CurrentPlayer, {
				clocked = false,
				burrowed = false,
				intransit = false,
				hallucinated = false,
				invincible = true,
				hitpoint = 100,
				shield = 100,
				energy = 100,
				resource = 0,
				hanger = 0,
			});
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Zerg Lurker", CurrentPlayer, "Create", "C8");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C8");
			Comment("政間 社発");
		},
	}
	GetLocCenter("C1",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	GetLocCenter("C2",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	GetLocCenter("C3",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	GetLocCenter("C4",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	GetLocCenter("C5",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	GetLocCenter("C6",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	GetLocCenter("C7",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	GetLocCenter("C8",CX,CY)
	f_TempRepeat(88,1,nil,5)
	CallTriggerX(FP,WrPosSave)
	CIfEnd()
	SetRecoverCp()
	RecoverCp(FP)
	Trigger { -- 傾戚什 肢薦
		players = {P8},
		conditions = {
			
			Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere");
			Bring(AllPlayers, AtLeast, 4, "Tom Kazansky (Wraith)", "C1");
			Bring(AllPlayers, AtLeast, 4, "Terran Wraith", "C1");
		},
		actions = {
			PreserveTrigger();
			RemoveUnitAt(All, "Edmund Duke (Siege Mode)", "Create", CurrentPlayer);
			RemoveUnit("Terran Wraith", AllPlayers);
			RemoveUnit("Tom Kazansky (Wraith)", AllPlayers);
			Comment("傾戚什 肢薦");
		},
	}
	
	Trigger { -- 汽什葵
		players = {P8},
		conditions = {
			Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
			Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
			Bring(CurrentPlayer, Exactly, 0, 27, "Anywhere");
			Void(0, Exactly, 1);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 4);
		},
		actions = {
			PreserveTrigger();
			KillUnit("Artanis (Scout)", CurrentPlayer);
			SetVoid(5, SetTo, 350);
			SetVoid(6, SetTo, 1);
			Comment("汽什葵");
		},
	}


--	for i = 1,14 do
--	Trigger {
--		players = {P8},
--		conditions = {
--			Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
--			Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
--			Void(5,Exactly,350);
--		},
--		actions = {
--			PreserveTrigger();
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,27,"C1",CurrentPlayer);
--			Order(27,CurrentPlayer,"Anywhere",Attack,"Boss");
--			SetInvincibility(Enable,27,CurrentPlayer,"Anywhere");
--			Comment("葛虞球 持失 闘軒暗 葛亜陥 左陥 袷 for庚 床誌");
--		}
--	}
--	end
--	for i = 1,14 do
--	Trigger {
--		players = {P8},
--		conditions = {
--			Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
--			Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
--			Void(5,Exactly,200);
--		},
--		actions = {
--			PreserveTrigger();
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
--			GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
--			CreateUnit(1,80,"C1",CurrentPlayer);
--			Order(80,CurrentPlayer,"Anywhere",Attack,"Boss");
--			SetInvincibility(Enable,80,CurrentPlayer,"Anywhere");
--			Comment("什朝 持失 闘軒暗 左陥 袷 for庚 床誌");
--		}
--	}
--	end
	

	
		TriggerX(FP,{			
			Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
			Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
			Void(5,Exactly,350);},{SetCVar(FP,CurArr[2],SetTo,0)},{preserved})

		TriggerX(FP,{			
			Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
			Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
			Void(5,Exactly,200);
		},{SetCVar(FP,CurArr[2],SetTo,0)},{preserved})


		local WrPos = CreateVar(FP)
		local WhileLim = CreateCcode()
		local Wr_Sum = def_sIndex()
		CIf(FP,{
			Void(6,AtLeast,1)
		})	
			CJumpEnd(FP,Wr_Sum)
			NIf(FP,{TMemory(_Add(XY_ArrHeader,CurArr),AtLeast,1),CDeaths(FP,AtMost,7,WhileLim)},SetCDeaths(FP,Add,1,WhileLim))
				f_Read(FP,_Add(XY_ArrHeader,CurArr),CPos)
				Convert_CPosXY()
				Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-32*1,-32*1,32*1,32*1)})
				DoActions(FP,{
					CreateUnit(1,"Kakaru (Twilight)",1,FP),
					KillUnit("Kakaru (Twilight)",FP)})
				CIf(FP,Memory(0x628438,AtLeast,1))
				NIfX(FP,Void(5,AtLeast,201))
					f_TempRepeat(27,1,nil,5)
				NElseIfX(Void(5,AtMost,200))
					f_TempRepeat(80,1,nil,5)
				NIfXEnd()
				CifEnd()


				CAdd(FP,CurArr,1)
				CJump(FP,Wr_Sum)
			NIfEnd()
			DoActionsX(FP,SetCDeaths(FP,SetTo,0,WhileLim))
		CIfEnd()
		SetRecoverCp()
		RecoverCp(FP)
	
	Trigger { -- 政間 迭
		players = {P8},
		conditions = {
			
			Bring(CurrentPlayer, AtLeast, 1, 80, "Anywhere");
			Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
		},
		actions = {
			PreserveTrigger();
			KillUnit("Zerg Lurker", CurrentPlayer);
			Comment("政間 迭");
		},
	}
	
	Trigger { -- 汽什葵
		players = {P8},
		conditions = {
			
		},
		actions = {
			PreserveTrigger();
			SetVoid(5, Subtract, 1);
			Comment("汽什葵");
		},
	}
	
	Trigger { -- 政間 奄採
		players = {P8},
		conditions = {
			Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
			Bring(CurrentPlayer, Exactly, 0, "Edmund Duke (Siege Mode)", "Anywhere");
			Bring(CurrentPlayer, AtLeast, 1, 27, "Anywhere");
		},
		actions = {
			PreserveTrigger();
			GiveUnits(All, "Edmund Duke (Siege Mode)", P9, "Anywhere", CurrentPlayer);
			Comment("政間 奄採");
		},
	}
	
	Trigger { -- 什迭 段奄鉢
		players = {P8},
		conditions = {
			
			Void(5, Exactly, 1);
		},
		actions = {
			PreserveTrigger();
			SetVoid(6,SetTo,0);
			KillUnit(80, CurrentPlayer);
			KillUnit(27, CurrentPlayer);
			KillUnit("Zeratul (Dark Templar)", CurrentPlayer);
			KillUnit("Artanis (Scout)", CurrentPlayer);
			KillUnit("Edmund Duke (Siege Mode)", CurrentPlayer);
			KillUnit("Zerg Lurker", CurrentPlayer);
			Wait(100);
			SetVoid(0, Add, 1);
			Comment("什迭 段奄鉢");
		},
	}
	
	Trigger { -- 趨覗 什迭 闘軒暗
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 2);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(25, "Danimoth (Arbiter)", "Boss", CurrentPlayer);
			MoveUnit(1, "Dark Templar (Hero)", CurrentPlayer, "Anywhere", "Foes");
			MoveLocation("KillUnit", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			KillUnitAt(All, "Men", "KillUnit", Foes);
			KillUnit("Danimoth (Arbiter)", CurrentPlayer);
			Wait(0);
			SetVoid(0, Add, 1);
			Comment("趨覗 什迭 闘軒暗");
		},
	}
	
	Trigger { -- 朝朝欠 闘軒暗
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 2);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, AtLeast, 4);
			Void(3, AtMost, 14);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(9, 91, "Create 2", CurrentPlayer);
			MoveUnit(All, 91, CurrentPlayer, "Create", "Boss");
			KillUnit(91, CurrentPlayer);
			ModifyUnitHitPoints(All, "Men", Foes, "Anywhere", 0);
			Wait(1000);
			MoveLocation("C1", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C2", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C3", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C4", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C5", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C6", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C7", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C8", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			SetVoid(3, Add, 1);
			Comment("朝朝欠 闘軒暗");
		},
	}
	
	Trigger { -- 杷1 鳶渡
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 2);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, AtLeast, 4);
			Void(3, AtMost, 14);
			Void(41, AtLeast, 4);
		},
		actions = {
			PreserveTrigger();
			ModifyUnitHitPoints(All, "Men", Foes, "Anywhere", 0);
			Comment("杷1 鳶渡");
		},
	}
	
	Trigger { -- 什迭 / 戚楕 号狽 什迭 (企唖識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 3);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C1", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C2", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C3", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C4", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C5", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C6", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C7", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C8", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			CreateUnit(21, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(2, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 1", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 1", CurrentPlayer);
			MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(7, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "Boss");
			MoveUnit(7, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "Boss");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(6, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(6, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			Comment("什迭 / 戚楕 号狽 什迭 (企唖識)");
		},
	}
	
	Trigger { -- 什迭 / 戚楕 号狽 什迭 (企唖識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 3);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			Order("Danimoth (Arbiter)", CurrentPlayer, "Anywhere", Attack, "Boss");
			SetInvincibility(Enable, "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			SetVoid(0, Add, 1);
			Comment("什迭 / 戚楕 号狽 什迭 (企唖識)");
		},
	}
	
	Trigger { -- 巷崎稽追 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 4);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(8, "Edmund Duke (Siege Mode)", "Create 1", CurrentPlayer);
			SetInvincibility(Enable, "Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			GiveUnits(All, "Danimoth (Arbiter)", P12, "Anywhere", CurrentPlayer);
			Order("Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere", Attack, "Anywhere");
			KillUnit("Danimoth (Arbiter)", CurrentPlayer);
			Wait(10);
			SetVoid(0, Add, 1);
			Comment("巷崎稽追 什迭");
		},
	}
	
	Trigger { -- 什迭 び 戚楕 号狽 什迭 (送識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 5);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(15, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(2, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "Boss");
			MoveUnit(7, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "Boss");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			Comment("什迭 び 戚楕 号狽 什迭 (送識)");
		},
	}
	
	Trigger { -- 什迭 び 戚楕 号狽 什迭 (送識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 5);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			SetInvincibility(Enable, "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			Order("Danimoth (Arbiter)", CurrentPlayer, "Anywhere", Attack, "Anywhere");
			SetVoid(0, Add, 1);
			Comment("什迭 び 戚楕 号狽 什迭 (送識)");
		},
	}
	
	Trigger { -- 巷崎稽追 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 6);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(8, "Edmund Duke (Siege Mode)", "Create 1", CurrentPlayer);
			SetInvincibility(Enable, "Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			GiveUnits(All, "Danimoth (Arbiter)", P12, "Anywhere", CurrentPlayer);
			Order("Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere", Attack, "Anywhere");
			KillUnit("Danimoth (Arbiter)", CurrentPlayer);
			Wait(10);
			SetVoid(0, Add, 1);
			Comment("巷崎稽追 什迭");
		},
	}
	
	Trigger { -- 什迭 11獣 企唖識 戚楕 号狽 什迭 (企唖識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 7);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(17, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(2, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "Boss");
			MoveUnit(7, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "Boss");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			Comment("什迭 11獣 企唖識 戚楕 号狽 什迭 (企唖識)");
		},
	}
	
	Trigger { -- 什迭 11獣 企唖識 戚楕 号狽 什迭 (企唖識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 7);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			SetInvincibility(Enable, "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			SetVoid(0, Add, 1);
			Comment("什迭 11獣 企唖識 戚楕 号狽 什迭 (企唖識)");
		},
	}
	
	Trigger { -- 巷崎稽追 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 8);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(8, "Edmund Duke (Siege Mode)", "Create 1", CurrentPlayer);
			SetInvincibility(Enable, "Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			GiveUnits(All, "Danimoth (Arbiter)", P12, "Anywhere", CurrentPlayer);
			KillUnit("Danimoth (Arbiter)", CurrentPlayer);
			Order("Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere", Attack, "Anywhere");
			Wait(10);
			SetVoid(0, Add, 1);
			Comment("巷崎稽追 什迭");
		},
	}
	
	Trigger { -- 什迭 ぱ 戚楕 号狽 什迭 (送識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 9);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(19, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(2, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "Boss");
			MoveUnit(6, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "Boss");
			MoveUnit(7, "Zerg Devourer", CurrentPlayer, "Create", "Boss");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "Boss");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
			MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C1");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
			Comment("什迭 ぱ 戚楕 号狽 什迭 (送識)");
		},
	}
	
	Trigger { -- 什迭 ぱ 戚楕 号狽 什迭 (送識)
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 9);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
			CreateUnit(1, "Kukulza (Guardian)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C2");
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
			RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
			MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
			SetVoid(0, Add, 1);
			Comment("什迭 ぱ 戚楕 号狽 什迭 (送識)");
		},
	}
	
	Trigger { -- 巷崎稽追 什迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 10);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 15);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(8, "Edmund Duke (Siege Mode)", "Create 1", CurrentPlayer);
			SetInvincibility(Enable, "Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			GiveUnits(1, "Danimoth (Arbiter)", CurrentPlayer, "C1", P12);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			GiveUnits(All, "Danimoth (Arbiter)", P12, "Anywhere", CurrentPlayer);
			KillUnit("Danimoth (Arbiter)", CurrentPlayer);
			Order("Edmund Duke (Siege Mode)", CurrentPlayer, "Anywhere", Attack, "Anywhere");
			Wait(3500);
			KillUnit("Edmund Duke (Siege Mode)", CurrentPlayer);
			Wait(0);
			MoveLocation("C1", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C2", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C3", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C4", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C5", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C6", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C7", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			MoveLocation("C8", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
			SetVoid(0, Add, 1);
			Comment("巷崎稽追 什迭");
		},
	}
	
	Trigger { -- 8唖莫 戚薙闘 鎧奄
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 11);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, AtLeast, 15);
			Void(3, AtMost, 39);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(1, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C1");
			MoveLocation("C1", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(2, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C2");
			MoveLocation("C2", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(3, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C3");
			MoveLocation("C3", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(4, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C4");
			MoveLocation("C4", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(5, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C5");
			MoveLocation("C5", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(6, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C6");
			MoveLocation("C6", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(7, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C7");
			MoveLocation("C7", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			CreateUnit(8, "Zerg Devourer", "Create 1", CurrentPlayer);
			CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
			MoveUnit(All, "Men", CurrentPlayer, "Create", "C8");
			MoveLocation("C8", "Danimoth (Arbiter)", CurrentPlayer, "Anywhere");
			RemoveUnit("Danimoth (Arbiter)", CurrentPlayer);
			RemoveUnit("Zerg Devourer", CurrentPlayer);
			Comment("8唖莫 戚薙闘 鎧奄");
		},
	}
	
	CIf(FP,{
		Void(0, Exactly, 11);
		Void(1, Exactly, 8);
		Void(2, Exactly, 31);
		Void(3, AtLeast, 15);
		Void(3, AtMost, 39);})
		SetLocCenter2("C1")
		f_TempRepeat(17,1,nil,2)
		SetLocCenter2("C2")
		f_TempRepeat(17,1,nil,2)
		SetLocCenter2("C3")
		f_TempRepeat(17,1,nil,2)
		SetLocCenter2("C4")
		f_TempRepeat(17,1,nil,2)
		SetLocCenter2("C5")
		f_TempRepeat(17,1,nil,2)
		SetLocCenter2("C6")
		f_TempRepeat(17,1,nil,2)
		SetLocCenter2("C7")
		f_TempRepeat(17,1,nil,2)
		SetLocCenter2("C8")
		f_TempRepeat(17,1,nil,2)
		CMov(FP,0x6509B0,FP)
	CIfEnd()
	Trigger { -- 伯生誓 耕艦艦? 誌艦艦 政間 社発 購 巷崎稽追
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 11);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, AtLeast, 15);
			Void(3, AtMost, 39);
			Void(41, AtLeast, 2);
		},
		actions = {
			PreserveTrigger();
			KillUnitAt(All, "Men", "C1", Foes);
			KillUnitAt(All, "Men", "C2", Foes);
			KillUnitAt(All, "Men", "C3", Foes);
			KillUnitAt(All, "Men", "C4", Foes);
			KillUnitAt(All, "Men", "C5", Foes);
			KillUnitAt(All, "Men", "C6", Foes);
			KillUnitAt(All, "Men", "C7", Foes);
			KillUnitAt(All, "Men", "C8", Foes);
			Comment("伯生誓 耕艦艦? 誌艦艦 政間 社発 購 巷崎稽追");
		},
	}
	Trigger { -- 伯生誓 耕艦艦? 誌艦艦 政間 社発 購 巷崎稽追
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 11);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, AtLeast, 15);
			Void(3, AtMost, 39);
			Void(41, AtMost, 3);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(8, "Hyperion (Battlecruiser)", "Create 1", CurrentPlayer);
			CreateUnit(8, "Edmund Duke (Siege Mode)", "Create 2", CurrentPlayer);
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C8");
			KillUnit("Hyperion (Battlecruiser)", CurrentPlayer);
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C8");
			MoveUnit(1, "Edmund Duke (Siege Mode)", CurrentPlayer, "Create", "C1");
			SetVoid(3, Add, 1);
			Comment("伯生誓 耕艦艦? 誌艦艦 政間 社発 購 巷崎稽追");
		},
	}
	Trigger { -- 伯生誓 耕艦艦? 誌艦艦 政間 社発 購 巷崎稽追
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 11);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, AtLeast, 15);
			Void(3, AtMost, 39);
			Void(41, AtLeast, 4);
		},
		actions = {
			PreserveTrigger();
			CreateUnit(8, "Hyperion (Battlecruiser)", "Create 1", CurrentPlayer);
			CreateUnit(8, 30, "Create 2", CurrentPlayer);
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C1");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C2");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C3");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C4");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C5");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C6");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C7");
			MoveUnit(1, "Hyperion (Battlecruiser)", CurrentPlayer, "Create", "C8");
			KillUnit("Hyperion (Battlecruiser)", CurrentPlayer);
			MoveUnit(1, 30, CurrentPlayer, "Create", "C1");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C2");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C3");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C4");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C5");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C6");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C7");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C8");
			MoveUnit(1, 30, CurrentPlayer, "Create", "C1");
			SetVoid(3, Add, 1);
			Comment("伯生誓 耕艦艦? 誌艦艦 政間 社発 購 巷崎稽追");
		},
	}
	
	Trigger { -- 政間 迭
		players = {P8},
		conditions = {
			
			Void(0, Exactly, 11);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 40);
		},
		actions = {
			PreserveTrigger();
			Wait(5000);
			SetVoid(3, Add, 1);
			KillUnit("Edmund Duke (Siege Mode)", CurrentPlayer);
			KillUnit(30, CurrentPlayer);
			KillUnit("Alan Schezar (Goliath)", CurrentPlayer);
			Comment("政間 迭");
		},
	}
	
	Trigger { -- 革鋼 什迭 拙失 姥娃
		players = {P8},
		conditions = {
			
			Bring(AllPlayers, Exactly, 0, "Gantrithor (Carrier)", "Anywhere");
			Void(0, Exactly, 11);
			Void(1, Exactly, 8);
			Void(2, Exactly, 31);
			Void(3, Exactly, 40);
		},
		actions = {
			PreserveTrigger();
		},
	}
	
	f_ArrReset({
		Bring(AllPlayers, Exactly, 0, "Gantrithor (Carrier)", "Anywhere");
		Void(0, Exactly, 11);
		Void(1, Exactly, 8);
		Void(2, Exactly, 31);
		Void(3, Exactly, 41);})
		
	CallTriggerX(FP,Call_VoidReset,{
	Bring(AllPlayers, Exactly, 0, "Gantrithor (Carrier)", "Anywhere");
	Void(0, Exactly, 11);
	Void(1, Exactly, 8);
	Void(2, Exactly, 31);
	Void(3, Exactly, 41);})
	CElseIfX(CVar(FP,VResetSw4[2],Exactly,0),SetCVar(FP,VResetSw4[2],SetTo,1))
	CMov(FP,SpeedVar,SpeedBackup)
	CallTrigger(FP,Call_VoidReset)
	DoActionsX(FP,{KillUnit("Any unit",FP),KillUnit("Any unit",P9),KillUnit("Any unit",P10),KillUnit("Any unit",P11),KillUnit("Any unit",P12),
	SetCDeaths(FP,SetTo,1,DLClear);
	SetCDeaths(FP,SetTo,0,SpeedBackupCcode);
		DL_Recover;
	})
	
	f_ArrReset()
	CIfXEnd()
	CIfEnd()
	end