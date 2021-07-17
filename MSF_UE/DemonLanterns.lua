function Install_DLBoss()
Trigger { -- ���� ���� ����
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("Boss", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		SetDeaths(CurrentPlayer, SetTo, 1, "Map Revealer");
		Comment("���� ���� ����");
	},
}

Trigger { -- �ʹ� ���̴°� ������
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 0, "Dark Templar (Hero)");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, SetTo, 1, "Dark Templar (Hero)");
		Comment("�ʹ� ���̴°� ������");
	},
}

Trigger { -- ���� �ھƤ��Ƥ�������
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 0, "Terran Battlecruiser");
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
		SetDeaths(P6, Add, 1, "Terran Battlecruiser");
		Comment("���� �ھƤ��Ƥ�������");
	},
}

Trigger { -- 8���� ���
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, AtLeast, 1, "Terran Battlecruiser");
		Deaths(P6, AtMost, 7, "Terran Battlecruiser");
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
		Comment("8���� ���");
	},
}

Trigger { -- ??
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, AtLeast, 1, "Terran Battlecruiser");
		Deaths(P6, AtMost, 7, "Terran Battlecruiser");
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
		SetDeaths(P6, Add, 1, "Terran Battlecruiser");
		Comment("??");
	},
}

Trigger { -- ���ۼ�
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, AtMost, 3, "Terran Medic");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, SetTo, 0, "Dark Templar (Hero)");
		SetDeaths(P6, SetTo, 0, "Terran Battlecruiser");
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("���ۼ�");
	},
}

Trigger { -- ���̴°� �ѹ� �� ���� Ʈ���� ���� ������ wait ��������� �׳� ���������� �ѱ�
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 4, "Terran Medic");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("Foes", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		SetDeaths(P6, SetTo, 1, "Dark Templar (Hero)");
		SetDeaths(P6, SetTo, 8, "Terran Battlecruiser");
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("���̴°� �ѹ� �� ���� Ʈ���� ���� ������ wait ��������� �׳� ���������� �ѱ�");
	},
}

Trigger { -- ����Ʈ ��ų 11
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 5, "Terran Medic");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų 11");
	},
}

Trigger { -- ����Ʈ ��ų3
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 6, "Terran Medic");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų3");
	},
}

Trigger { -- ����Ʈ ��ų5
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 7, "Terran Medic");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų5");
	},
}

Trigger { -- ����Ʈ ��ų6
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 8, "Terran Medic");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų6");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 9, "Terran Medic");
		Deaths(P6, Exactly, 0, "Zerg Overmind");
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
		SetDeaths(P6, SetTo, 1, "Zerg Overmind");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 9, "Terran Medic");
		Deaths(P6, Exactly, 1, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 10, "Terran Medic");
		Deaths(P6, Exactly, 1, "Zerg Overmind");
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
		SetDeaths(P6, SetTo, 2, "Zerg Overmind");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 10, "Terran Medic");
		Deaths(P6, Exactly, 2, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 11, "Terran Medic");
		Deaths(P6, Exactly, 2, "Zerg Overmind");
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
		SetDeaths(P6, SetTo, 3, "Zerg Overmind");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 11, "Terran Medic");
		Deaths(P6, Exactly, 3, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 12, "Terran Medic");
		Deaths(P6, Exactly, 3, "Zerg Overmind");
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
		SetDeaths(P6, SetTo, 4, "Zerg Overmind");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ����Ʈ ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 12, "Terran Medic");
		Deaths(P6, Exactly, 4, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("����Ʈ ��ų");
	},
}

Trigger { -- ��ų ���
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, AtLeast, 13, "Terran Medic");
		Deaths(P6, AtMost, 30, "Terran Medic");
		Deaths(P6, Exactly, 4, "Zerg Overmind");
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
		Comment("��ų ���");
	},
}

Trigger { -- ���ּ�ȯ
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, AtLeast, 13, "Terran Medic");
		Deaths(P6, AtMost, 30, "Terran Medic");
		Deaths(P6, Exactly, 4, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Terran Medic");
		Comment("���ּ�ȯ");
	},
}

Trigger { -- ���̽� ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 30, "Terran Medic");
		Deaths(P6, Exactly, 4, "Zerg Overmind");
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
		CreateUnit(16, "Protoss Arbiter", "Arbiter", P7);
		SetInvincibility(Enable, "Protoss Arbiter", P7, "Anywhere");
		Comment("���̽� ��ų");
	},
}

Trigger { -- ���ƽ� ���� �׸���
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
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
		KillUnitAt(All, "Men", "C1", Foes);
		KillUnitAt(All, "Men", "C2", Foes);
		KillUnitAt(All, "Men", "C3", Foes);
		KillUnitAt(All, "Men", "C4", Foes);
		KillUnitAt(All, "Men", "C5", Foes);
		KillUnitAt(All, "Men", "C6", Foes);
		KillUnitAt(All, "Men", "C7", Foes);
		KillUnitAt(All, "Men", "C8", Foes);
		SetDeaths(P6, Add, 1, "Terran Wraith");
		Comment("���ƽ� ���� �׸���");
	},
}

Trigger { -- ���� ����Ʈ
	players = {P7},
	conditions = {
		Bring(P1, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere");
	},
	actions = {
		RunAIScriptAt("Recall Here", "C1");
		RunAIScriptAt("Recall Here", "C2");
		RunAIScriptAt("Recall Here", "C3");
		RunAIScriptAt("Recall Here", "C4");
		RunAIScriptAt("Recall Here", "C5");
		RunAIScriptAt("Recall Here", "C6");
		RunAIScriptAt("Recall Here", "C7");
		RunAIScriptAt("Recall Here", "C8");
		PreserveTrigger();
		Comment("���� ����Ʈ");
	},
}

Trigger { -- ���� ��ȯ
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere");
		Bring(AllPlayers, AtLeast, 1, "Terran Wraith", "Anywhere");
		Deaths(P6, Exactly, 7, "Terran Wraith");
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
		CreateUnitWithProperties(8, "Artanis (Scout)", "Create 1", CurrentPlayer, {
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
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C3");
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C4");
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C5");
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C6");
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C7");
		MoveUnit(1, "Artanis (Scout)", CurrentPlayer, "Create", "C8");
		Order("Artanis (Scout)", CurrentPlayer, "C1", Attack, "Boss");
		Order("Artanis (Scout)", CurrentPlayer, "C2", Attack, "Boss");
		Order("Artanis (Scout)", CurrentPlayer, "C3", Attack, "Boss");
		Order("Artanis (Scout)", CurrentPlayer, "C4", Attack, "Boss");
		Order("Artanis (Scout)", CurrentPlayer, "C5", Attack, "Boss");
		Order("Artanis (Scout)", CurrentPlayer, "C6", Attack, "Boss");
		Order("Artanis (Scout)", CurrentPlayer, "C7", Attack, "Boss");
		Order("Artanis (Scout)", CurrentPlayer, "C8", Attack, "Boss");
		SetDeaths(P6, SetTo, 0, "Terran Wraith");
		Comment("���� ��ȯ");
	},
}

Trigger { -- ���̽� ����
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Bring(AllPlayers, AtLeast, 1, "Tom Kazansky (Wraith)", "Anywhere");
		Bring(AllPlayers, AtLeast, 4, "Tom Kazansky (Wraith)", "C1");
		Bring(AllPlayers, AtLeast, 4, "Terran Wraith", "C1");
	},
	actions = {
		PreserveTrigger();
		RemoveUnitAt(All, "Edmund Duke (Siege Mode)", "Create", CurrentPlayer);
		RemoveUnit("Terran Wraith", AllPlayers);
		RemoveUnit("Tom Kazansky (Wraith)", AllPlayers);
		RemoveUnit("Protoss Arbiter", P7);
		Comment("���̽� ����");
	},
}

Trigger { -- ������
	players = {P1},
	conditions = {
		Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
		Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
		Bring(CurrentPlayer, Exactly, 0, "Norad II (Battlecruiser)", "Anywhere");
		Deaths(P6, Exactly, 1, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 4, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		KillUnit("Artanis (Scout)", CurrentPlayer);
		SetDeaths(P6, SetTo, 350, "Edmund Duke (Siege Mode)");
		Comment("������");
	},
}

for i = 1,14 do
Trigger {
	players = {P1},
	conditions = {
		Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
		Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
		Deaths(P6,Exactly,350,"Edmund Duke (Siege Mode)");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Norad II (Battlecruiser)","C1",CurrentPlayer);
		Order("Norad II (Battlecruiser)",CurrentPlayer,"Anywhere",Attack,"Boss");
		SetInvincibility(Enable,"Norad II (Battlecruiser)",CurrentPlayer,"Anywhere");
		Comment("���� ���� Ʈ���� �밡�� ���� �� for�� ����");
	}
}
end
for i = 1,14 do
Trigger {
	players = {P1},
	conditions = {
		Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
		Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
		Deaths(P6,Exactly,200,"Edmund Duke (Siege Mode)");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		MoveLocation("C1","Edmund Duke (Siege Mode)",CurrentPlayer,"Anywhere");
		GiveUnits(1,"Edmund Duke (Siege Mode)",CurrentPlayer,"C1",P9);
		CreateUnit(1,"Protoss Scout","C1",CurrentPlayer);
		Order("Protoss Scout",CurrentPlayer,"Anywhere",Attack,"Boss");
		SetInvincibility(Enable,"Protoss Scout",CurrentPlayer,"Anywhere");
		Comment("��ī ���� Ʈ���� ���� �� for�� ����");
	}
}
end

Trigger { -- ���� ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Bring(CurrentPlayer, AtLeast, 1, "Protoss Scout", "Anywhere");
		Bring(CurrentPlayer, AtLeast, 1, "Edmund Duke (Siege Mode)", "Anywhere");
	},
	actions = {
		PreserveTrigger();
		KillUnit("Edmund Duke (Siege Mode)", CurrentPlayer);
		KillUnit("Zerg Lurker", CurrentPlayer);
		Comment("���� ų");
	},
}

Trigger { -- ������
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Subtract, 1, "Edmund Duke (Siege Mode)");
		Comment("������");
	},
}

Trigger { -- ���� ���
	players = {P1},
	conditions = {
		Bring(AllPlayers, Exactly, 0, "Tom Kazansky (Wraith)", "Anywhere");
		Bring(CurrentPlayer, Exactly, 0, "Edmund Duke (Siege Mode)", "Anywhere");
		Bring(CurrentPlayer, AtLeast, 1, "Norad II (Battlecruiser)", "Anywhere");
	},
	actions = {
		PreserveTrigger();
		GiveUnits(All, "Edmund Duke (Siege Mode)", P9, "Anywhere", CurrentPlayer);
		Comment("���� ���");
	},
}

Trigger { -- ��ų �ʱ�ȭ
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 1, "Edmund Duke (Siege Mode)");
	},
	actions = {
		PreserveTrigger();
		KillUnit("Protoss Scout", CurrentPlayer);
		KillUnit("Norad II (Battlecruiser)", CurrentPlayer);
		KillUnit("Zeratul (Dark Templar)", CurrentPlayer);
		KillUnit("Artanis (Scout)", CurrentPlayer);
		KillUnit("Edmund Duke (Siege Mode)", CurrentPlayer);
		KillUnit("Zerg Lurker", CurrentPlayer);
		KillUnit("Protoss Arbiter", P8);
		Wait(100);
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("��ų �ʱ�ȭ");
	},
}

Trigger { -- ���� ��ų Ʈ����
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 2, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		CreateUnit(25, "Danimoth (Arbiter)", "Boss", CurrentPlayer);
		MoveUnit(1, "Dark Templar (Hero)", CurrentPlayer, "Anywhere", "Foes");
		MoveLocation("KillUnit", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		KillUnitAt(All, "Men", "KillUnit", Foes);
		KillUnit("Danimoth (Arbiter)", CurrentPlayer);
		Wait(0);
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("���� ��ų Ʈ����");
	},
}

Trigger { -- īī�� Ʈ����
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 2, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, AtLeast, 4, "Zerg Overmind");
		Deaths(P6, AtMost, 14, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		CreateUnit(9, "Kakaru (Twilight)", "Create 3", CurrentPlayer);
		MoveUnit(All, "Kakaru (Twilight)", CurrentPlayer, "Create", "Boss");
		KillUnit("Kakaru (Twilight)", CurrentPlayer);
		Wait(1000);
		MoveLocation("C1", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		MoveLocation("C2", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		MoveLocation("C3", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		MoveLocation("C4", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		MoveLocation("C5", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		MoveLocation("C6", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		MoveLocation("C7", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		MoveLocation("C8", "Dark Templar (Hero)", CurrentPlayer, "Anywhere");
		SetDeaths(P6, Add, 1, "Zerg Overmind");
		Comment("īī�� Ʈ����");
	},
}

Trigger { -- ��1 ����
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 2, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, AtLeast, 4, "Zerg Overmind");
		Deaths(P6, AtMost, 14, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		ModifyUnitHitPoints(All, "Men", Foes, "Anywhere", 0);
		Comment("��1 ����");
	},
}

Trigger { -- ��ų / ���� ���� ��ų (�밢��)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 3, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
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
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(6, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(6, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		Comment("��ų / ���� ���� ��ų (�밢��)");
	},
}

Trigger { -- ��ų / ���� ���� ��ų (�밢��)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 3, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
		MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
		MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
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
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("��ų / ���� ���� ��ų (�밢��)");
	},
}

Trigger { -- ������� ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 4, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("������� ��ų");
	},
}

Trigger { -- ��ų �� ���� ���� ��ų (����)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 5, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		CreateUnit(15, "Zerg Devourer", "Create 1", CurrentPlayer);
		CreateUnit(2, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
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
		CreateUnit(3, "Zerg Devourer", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 2", CurrentPlayer);
		CreateUnit(3, "Zerg Devourer", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		Comment("��ų �� ���� ���� ��ų (����)");
	},
}

Trigger { -- ��ų �� ���� ���� ��ų (����)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 5, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 1", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
		MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
		MoveUnit(3, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 1", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
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
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("��ų �� ���� ���� ��ų (����)");
	},
}

Trigger { -- ������� ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 6, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("������� ��ų");
	},
}

Trigger { -- ��ų 11�� �밢�� ���� ���� ��ų (�밢��)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 7, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		CreateUnit(17, "Zerg Devourer", "Create 1", CurrentPlayer);
		CreateUnit(2, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
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
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		Comment("��ų 11�� �밢�� ���� ���� ��ų (�밢��)");
	},
}

Trigger { -- ��ų 11�� �밢�� ���� ���� ��ų (�밢��)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 7, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
		MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
		MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
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
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("��ų 11�� �밢�� ���� ���� ��ų (�밢��)");
	},
}

Trigger { -- ������� ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 8, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("������� ��ų");
	},
}

Trigger { -- ��ų �� ���� ���� ��ų (����)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 9, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		CreateUnit(19, "Zerg Devourer", "Create 1", CurrentPlayer);
		CreateUnit(2, "Danimoth (Arbiter)", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
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
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Mutalisk)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		MoveUnit(2, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Kukulza (Mutalisk)", CurrentPlayer, "Create", "C1");
		MoveUnit(4, "Zerg Devourer", CurrentPlayer, "Create", "C1");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C1", "Kukulza (Mutalisk)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Mutalisk)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C1");
		Comment("��ų �� ���� ���� ��ų (����)");
	},
}

Trigger { -- ��ų �� ���� ���� ��ų (����)
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 9, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
		MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		CreateUnit(6, "Zerg Devourer", "Create 2", CurrentPlayer);
		CreateUnit(1, "Kukulza (Guardian)", "Create 3", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
		MoveUnit(5, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Kukulza (Guardian)", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Zerg Devourer", CurrentPlayer, "Create", "C2");
		RemoveUnit("Zerg Devourer", CurrentPlayer);
		MoveLocation("C2", "Kukulza (Guardian)", CurrentPlayer, "Anywhere");
		RemoveUnit("Kukulza (Guardian)", CurrentPlayer);
		CreateUnit(1, "Danimoth (Arbiter)", "Create 1", CurrentPlayer);
		MoveUnit(1, "Danimoth (Arbiter)", CurrentPlayer, "Create", "C2");
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("��ų �� ���� ���� ��ų (����)");
	},
}

Trigger { -- ������� ��ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 10, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 15, "Zerg Overmind");
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
		SetDeaths(P6, Add, 1, "Dark Templar (Hero)");
		Comment("������� ��ų");
	},
}

Trigger { -- 8���� ����Ʈ ����
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 11, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, AtLeast, 15, "Zerg Overmind");
		Deaths(P6, AtMost, 39, "Zerg Overmind");
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
		Comment("8���� ����Ʈ ����");
	},
}

Trigger { -- ������ �̴ϴ�? ��ϴ� ���� ��ȯ �� �������
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 11, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, AtLeast, 15, "Zerg Overmind");
		Deaths(P6, AtMost, 39, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		CreateUnit(8, "Hyperion (Battlecruiser)", "Create 1", CurrentPlayer);
		CreateUnit(8, "Edmund Duke (Siege Mode)", "Create 2", CurrentPlayer);
		CreateUnit(8, "Alan Schezar (Goliath)", "Create 3", CurrentPlayer);
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
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C1");
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C2");
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C3");
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C4");
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C5");
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C6");
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C7");
		MoveUnit(1, "Alan Schezar (Goliath)", CurrentPlayer, "Create", "C8");
		KillUnitAt(All, "Men", "C1", Foes);
		KillUnitAt(All, "Men", "C2", Foes);
		KillUnitAt(All, "Men", "C3", Foes);
		KillUnitAt(All, "Men", "C4", Foes);
		KillUnitAt(All, "Men", "C5", Foes);
		KillUnitAt(All, "Men", "C6", Foes);
		KillUnitAt(All, "Men", "C7", Foes);
		KillUnitAt(All, "Men", "C8", Foes);
		Order("Men", CurrentPlayer, "Anywhere", Attack, "Boss");
		SetDeaths(P6, Add, 1, "Zerg Overmind");
		Comment("������ �̴ϴ�? ��ϴ� ���� ��ȯ �� �������");
	},
}

Trigger { -- ���� ų
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Deaths(P6, Exactly, 11, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 40, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		Wait(5000);
		SetDeaths(P6, Add, 1, "Zerg Overmind");
		KillUnit("Edmund Duke (Siege Mode)", CurrentPlayer);
		KillUnit("Alan Schezar (Goliath)", CurrentPlayer);
		Comment("���� ų");
	},
}

Trigger { -- �׹� ��ų �ۼ� ����
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Bring(AllPlayers, Exactly, 0, "Gantrithor (Carrier)", "Anywhere");
		Deaths(P6, Exactly, 11, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 40, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
	},
}

Trigger { -- ��ų �ʱ�ȭ
	players = {P1},
	conditions = {
		Bring(CurrentPlayer, AtLeast, 1, "Dark Templar (Hero)", "Anywhere");
		Bring(AllPlayers, Exactly, 0, "Gantrithor (Carrier)", "Anywhere");
		Deaths(P6, Exactly, 11, "Dark Templar (Hero)");
		Deaths(P6, Exactly, 8, "Terran Battlecruiser");
		Deaths(P6, Exactly, 31, "Terran Medic");
		Deaths(P6, Exactly, 41, "Zerg Overmind");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, SetTo, 0, "Dark Templar (Hero)");
		SetDeaths(P6, SetTo, 0, "Terran Battlecruiser");
		SetDeaths(P6, SetTo, 0, "Terran Medic");
		SetDeaths(P6, SetTo, 0, "Terran Wraith");
		SetDeaths(P6, SetTo, 0, "Zerg Overmind");
		SetDeaths(P6, SetTo, 0, "Edmund Duke (Siege Mode)");
		Comment("��ų �ʱ�ȭ");
	},
}
end