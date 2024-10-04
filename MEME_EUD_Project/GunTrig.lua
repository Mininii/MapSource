function GunTrig()

	BGMType = CreateVar(FP)
	Dt = IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\_happy.ogg",19*1000},
	})
	
	function CIf_GunTrig(PlayerID,GunID,LocID,TimerMax,BGMTypes)
		local GunCcode = CreateCcode()
		GunTrigGLoc = LocID
		GunTrigGCcode = GunCcode
		TriggerX(FP, Bring(PlayerID, Exactly, 0, GunID, LocID), {SetCD(GunCcode,1),SetV(BGMType,BGMTypes)})--RotatePlayer({DisplayTextX("\x13GunID : "..GunID.."    LocID : "..LocID)}, HumanPlayers, FP)
		CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,TimerMax,AtMost)},{AddCD(GunCcode,1)})
		return GunCcode
	end
--P7Guns
HacCD1 = CIf_GunTrig(P7, "Zerg Hatchery", "CD1",200,1);
CIfEnd()
HacCD3 = CIf_GunTrig(P7, "Zerg Hatchery", "CD3",400,1);
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeLine(2, 32, 90, 5, 0),P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX"})
end
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CSMakeLine(2, 32, 90, 5, 0),P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX",RepeatType="KiilUnit"})
end
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeLine(2, 32, 90, 5, 0),P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX"})
end
CIfEnd()
HacCD4 = CIf_GunTrig(P7, "Zerg Hatchery", "CD4",200,1);
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeCircle(12, 72, 0, 13, 1),P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,70,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeLine(4, 24, 0, 13, 0),P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CSMakeCircle(12, 72, 0, 13, 1),P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CSMakeLine(4, 24, 0, 13, 0),P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeCircle(12, 72, 0, 13, 1),P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,270,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeLine(4, 24, 0, 13, 0),P8,GunTrigGLoc,1)
CIfEnd()
HacCD37 = CIf_GunTrig(P7, "Zerg Hatchery", "CD37",400,1);
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeLine(2, 32, 0, 5, 0),P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX"})
end
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CSMakeLine(2, 32, 0, 5, 0),P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX",RepeatType="KiilUnit"})
end
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)",},CSMakeLine(2, 32, 0, 5, 0),P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX"})
end
CIfEnd()
HacCD38 = CIf_GunTrig(P7, "Zerg Hatchery", "CD38",200,1);
CIfEnd()
HacCD39 = CIf_GunTrig(P7, "Zerg Hatchery", "CD39",200,1);
CIfEnd()
HacCD40 = CIf_GunTrig(P7, "Zerg Hatchery", "CD40",200,1);
CIfEnd()
HacCD41 = CIf_GunTrig(P7, "Zerg Hatchery", "CD41",200,1);
CIfEnd()
HacCD42 = CIf_GunTrig(P7, "Zerg Hatchery", "CD42",200,1);
CIfEnd()


HacCD2 = CIf_GunTrig(P8, "Zerg Hatchery", "CD2");
CIfEnd()
HacCD5 = CIf_GunTrig(P8, "Zerg Hatchery", "CD5");
CIfEnd()
HacCD6 = CIf_GunTrig(P8, "Zerg Hatchery", "CD6");
CIfEnd()
HacCD49 = CIf_GunTrig(P7, "Zerg Hatchery", "CD49");
CIfEnd()
HacCD50 = CIf_GunTrig(P7, "Zerg Hatchery", "CD50");
CIfEnd()
HacCD51 = CIf_GunTrig(P7, "Zerg Hatchery", "CD51");
CIfEnd()
HacCD52 = CIf_GunTrig(P7, "Zerg Hatchery", "CD52");
CIfEnd()
HacCD53 = CIf_GunTrig(P7, "Zerg Hatchery", "CD53");
CIfEnd()







LairCD8 = CIf_GunTrig(P7, "Zerg Lair", "CD8");
CIfEnd()
LairCD12 = CIf_GunTrig(P7, "Zerg Lair", "CD12");
CIfEnd()
LairCD13 = CIf_GunTrig(P7, "Zerg Lair", "CD13");
CIfEnd()
LairCD14 = CIf_GunTrig(P7, "Zerg Lair", "CD14");
CIfEnd()
LairCD15 = CIf_GunTrig(P7, "Zerg Lair", "CD15");
CIfEnd()
LairCD18 = CIf_GunTrig(P7, "Zerg Lair", "CD18");
CIfEnd()
LairCD19 = CIf_GunTrig(P7, "Zerg Lair", "CD19");
CIfEnd()
LairCD7 = CIf_GunTrig(P8, "Zerg Lair", "CD7");
CIfEnd()
LairCD9 = CIf_GunTrig(P8, "Zerg Lair", "CD9");
CIfEnd()
LairCD10 = CIf_GunTrig(P8, "Zerg Lair", "CD10");
CIfEnd()
LairCD11 = CIf_GunTrig(P8, "Zerg Lair", "CD11");
CIfEnd()
LairCD16 = CIf_GunTrig(P8, "Zerg Lair", "CD16");
CIfEnd()
LairCD17 = CIf_GunTrig(P8, "Zerg Lair", "CD17");
CIfEnd()
LairCD54 = CIf_GunTrig(P7, "Zerg Lair", "CD54");
CIfEnd()
LairCD55 = CIf_GunTrig(P7, "Zerg Lair", "CD55");
CIfEnd()


HiveCD20 = CIf_GunTrig(P7, "Zerg Hive", "CD20");
CIfEnd()
HiveCD20 = CIf_GunTrig(P7, "Zerg Hive", "CD20");
CIfEnd()
HiveCD27 = CIf_GunTrig(P7, "Zerg Hive", "CD27");
CIfEnd()
HiveCD27 = CIf_GunTrig(P7, "Zerg Hive", "CD27");
CIfEnd()
HiveCD21 = CIf_GunTrig(P8, "Zerg Hive", "CD21");
CIfEnd()
HiveCD21 = CIf_GunTrig(P8, "Zerg Hive", "CD21");
CIfEnd()
HiveCD26 = CIf_GunTrig(P8, "Zerg Hive", "CD26");
CIfEnd()
HiveCD26 = CIf_GunTrig(P8, "Zerg Hive", "CD26");
CIfEnd()





DoActions(FP,{KillUnit("Zerg Devourer", Force2)})
--[[

Trigger { -- H1
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD1");
},
actions = {
	CreateUnit(25, "Hunter Killer (Hydralisk)", "CD1", P8);
	CreateUnit(24, "Devouring One (Zergling)", "CD1", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD1", P8);
	Order("Kukulza (Mutalisk)", P8, "CD1", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD1", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD1", Patrol, "HZ");
	Comment("H1");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD1");
	Deaths(P6, AtLeast, 70, "Terran Factory");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD1", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD1");
	Deaths(P6, AtLeast, 80, "Terran Factory");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD1", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD1", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD1", P8);
	Order("Kukulza (Mutalisk)", P8, "CD1", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD1", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD1", Patrol, "HZ");
	Comment("H1");
},
}


Trigger { -- H1.2
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD4");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD4", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD4", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD4", P8);
	Order("Kukulza (Mutalisk)", P8, "CD4", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD4", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD4", Patrol, "HZ");
	Comment("H1.2");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD4");
	Deaths(P6, AtLeast, 70, "Terran Flag Beacon");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD4", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1.2
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD4");
	Deaths(P6, AtLeast, 80, "Terran Flag Beacon");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD4", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD4", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD4", P8);
	Order("Kukulza (Mutalisk)", P8, "CD4", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD4", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD4", Patrol, "HZ");
	Comment("H1.2");
},
}


Trigger { -- H1.3
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD37");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD37", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD37", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD37", P8);
	Order("Kukulza (Mutalisk)", P8, "CD37", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD37", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD37", Patrol, "HZ");
	Comment("H1.3");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD37");
	Deaths(P6, AtLeast, 70, "Terran Supply Depot");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD37", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1.3
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD37");
	Deaths(P6, AtLeast, 80, "Terran Supply Depot");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD37", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD37", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD37", P8);
	Order("Kukulza (Mutalisk)", P8, "CD37", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD37", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD37", Patrol, "HZ");
	Comment("H1.3");
},
}


Trigger { -- H1.4
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD38");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD38", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD38", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD38", P8);
	Order("Kukulza (Mutalisk)", P8, "CD38", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD38", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD38", Patrol, "HZ");
	Comment("H1.4");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD38");
	Deaths(P6, AtLeast, 70, "Terran Nuclear Silo");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD38", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1.4
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD38");
	Deaths(P6, AtLeast, 80, "Terran Nuclear Silo");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD38", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD38", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD38", P8);
	Order("Kukulza (Mutalisk)", P8, "CD38", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD38", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD38", Patrol, "HZ");
	Comment("H1.4");
},
}


Trigger { -- H1.5
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD39");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD39", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD39", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD39", P8);
	Order("Kukulza (Mutalisk)", P8, "CD39", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD39", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD39", Patrol, "HZ");
	Comment("H1.5");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD39");
	Deaths(P6, AtLeast, 70, "Terran Control Tower");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD39", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1.5
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD39");
	Deaths(P6, AtLeast, 80, "Terran Control Tower");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD39", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD39", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD39", P8);
	Order("Kukulza (Mutalisk)", P8, "CD39", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD39", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD39", Patrol, "HZ");
	Comment("H1.5");
},
}


Trigger { -- H1.6
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD40");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD40", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD40", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD40", P8);
	Order("Kukulza (Mutalisk)", P8, "CD40", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD40", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD40", Patrol, "HZ");
	Comment("H1.6");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD40");
	Deaths(P6, AtLeast, 70, "Terran Battlecruiser");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD40", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1.6
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD40");
	Deaths(P6, AtLeast, 80, "Terran Battlecruiser");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD40", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD40", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD40", P8);
	Order("Kukulza (Mutalisk)", P8, "CD40", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD40", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD40", Patrol, "HZ");
	Comment("H1.6");
},
}


Trigger { -- H1.7
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD41");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD41", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD41", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD41", P8);
	Order("Kukulza (Mutalisk)", P8, "CD41", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD41", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD41", Patrol, "HZ");
	Comment("H1.7");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD41");
	Deaths(P6, AtLeast, 70, "Terran Science Vessel");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD41", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1.7
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD41");
	Deaths(P6, AtLeast, 80, "Terran Science Vessel");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD41", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD41", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD41", P8);
	Order("Kukulza (Mutalisk)", P8, "CD41", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD41", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD41", Patrol, "HZ");
	Comment("H1.7");
},
}


Trigger { -- H1.8
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD42");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD42", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD42", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD42", P8);
	Order("Kukulza (Mutalisk)", P8, "CD42", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD42", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD42", Patrol, "HZ");
	Comment("H1.8");
},
}


Trigger {
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD42");
	Deaths(P6, AtLeast, 70, "Torrasque (Ultralisk)");
},
actions = {
	CreateUnit(16, "Zerg Devourer", "CD42", P8);
	KillUnit("Zerg Devourer", P8);
},
}


Trigger { -- H1.8
players = {P7},
conditions = {
	Bring(P7, Exactly, 0, "Zerg Hatchery", "CD42");
	Deaths(P6, AtLeast, 80, "Torrasque (Ultralisk)");
},
actions = {
	CreateUnit(16, "Hunter Killer (Hydralisk)", "CD42", P8);
	CreateUnit(29, "Devouring One (Zergling)", "CD42", P8);
	CreateUnit(20, "Kukulza (Mutalisk)", "CD42", P8);
	Order("Kukulza (Mutalisk)", P8, "CD42", Attack, "HZ");
	Order("Hunter Killer (Hydralisk)", P8, "CD42", Patrol, "HZ");
	Order("Devouring One (Zergling)", P8, "CD42", Patrol, "HZ");
	Comment("H1.8");
},
}




Trigger { -- H2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD2");
	},
	actions = {
		CreateUnit(25, "Hunter Killer (Hydralisk)", "CD2", P8);
		CreateUnit(24, "Devouring One (Zergling)", "CD2", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD2", P8);
		Order("Kukulza (Mutalisk)", P8, "CD2", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD2", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD2", Patrol, "HZ");
		Comment("H2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD2");
		Deaths(P6, AtLeast, 70, "Terran Science Facility");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD2", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD2");
		Deaths(P6, AtLeast, 80, "Terran Science Facility");
	},
	actions = {
		CreateUnit(16, "Hunter Killer (Hydralisk)", "CD2", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD2", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD2", P8);
		Order("Kukulza (Mutalisk)", P8, "CD2", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD2", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD2", Patrol, "HZ");
		Comment("H2");
	},
}


Trigger { -- H2.1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD5");
	},
	actions = {
		CreateUnit(25, "Hunter Killer (Hydralisk)", "CD5", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD5", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD5", P8);
		Order("Kukulza (Mutalisk)", P8, "CD5", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD5", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD5", Patrol, "HZ");
		Comment("H2.1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD5");
		Deaths(P6, AtLeast, 70, "Terran Medic");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD5", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD5");
		Deaths(P6, AtLeast, 80, "Terran Medic");
	},
	actions = {
		CreateUnit(16, "Hunter Killer (Hydralisk)", "CD5", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD5", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD5", P8);
		Order("Kukulza (Mutalisk)", P8, "CD5", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD5", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD5", Patrol, "HZ");
		Comment("H2.1");
	},
}


Trigger { -- H2.2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD6");
	},
	actions = {
		CreateUnit(25, "Hunter Killer (Hydralisk)", "CD6", P8);
		CreateUnit(24, "Devouring One (Zergling)", "CD6", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD6", P8);
		Order("Kukulza (Mutalisk)", P8, "CD6", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD6", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD6", Patrol, "HZ");
		Comment("H2.2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD6");
		Deaths(P6, AtLeast, 70, "Terran SCV");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD6", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD6");
		Deaths(P6, AtLeast, 80, "Terran SCV");
	},
	actions = {
		CreateUnit(16, "Hunter Killer (Hydralisk)", "CD6", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD6", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD6", P8);
		Order("Kukulza (Mutalisk)", P8, "CD6", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD6", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD6", Patrol, "HZ");
		Comment("H2.2");
	},
}


Trigger { -- H2.3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD49");
	},
	actions = {
		CreateUnit(16, "Hunter Killer (Hydralisk)", "CD49", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD49", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD49", P8);
		Order("Kukulza (Mutalisk)", P8, "CD49", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD49", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD49", Patrol, "HZ");
		Comment("H2.3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD49");
		Deaths(P6, AtLeast, 70, "Terran Siege Tank (Tank Mode)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD49", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD49");
		Deaths(P6, AtLeast, 80, "Terran Siege Tank (Tank Mode)");
	},
	actions = {
		CreateUnit(16, "Hunter Killer (Hydralisk)", "CD49", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD49", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD49", P8);
		Order("Kukulza (Mutalisk)", P8, "CD49", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD49", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD49", Patrol, "HZ");
		Comment("H2.3");
	},
}


Trigger { -- H2.4
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD50");
	},
	actions = {
		CreateUnit(18, "Alan Schezar (Goliath)", "CD50", P8);
		CreateUnit(14, "Kukulza (Guardian)", "CD50", P8);
		Order("Alan Schezar (Goliath)", P8, "CD50", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD50", Patrol, "HZ");
		Comment("H2.4");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD50");
		Deaths(P6, AtLeast, 70, "Terran Siege Tank (Siege Mode)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD50", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.4
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD50");
		Deaths(P6, AtLeast, 80, "Terran Siege Tank (Siege Mode)");
	},
	actions = {
		CreateUnit(16, "Gui Montag (Firebat)", "CD50", P8);
		CreateUnit(20, "Tom Kazansky (Wraith)", "CD50", P8);
		Order("Gui Montag (Firebat)", P8, "CD50", Patrol, "HZ");
		Order("Tom Kazansky (Wraith)", P8, "CD50", Patrol, "HZ");
		Comment("H2.4");
	},
}


Trigger { -- H2.5
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD51");
	},
	actions = {
		CreateUnit(8, "Warbringer (Reaver)", "CD51", P8);
		CreateUnit(14, "Tom Kazansky (Wraith)", "CD51", P8);
		Order("Warbringer (Reaver)", P8, "CD51", Patrol, "HZ");
		Order("Tom Kazansky (Wraith)", P8, "CD51", Patrol, "HZ");
		Comment("H2.5");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD51");
		Deaths(P6, AtLeast, 70, "Infested Terran");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD51", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.5
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD51");
		Deaths(P6, AtLeast, 80, "Infested Terran");
	},
	actions = {
		CreateUnit(20, "Edmund Duke (Siege Mode)", "CD51", P8);
		Comment("H2.5");
	},
}


Trigger { -- H2.6
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD52");
	},
	actions = {
		CreateUnit(16, "Hunter Killer (Hydralisk)", "CD52", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD52", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD52", P8);
		Order("Kukulza (Mutalisk)", P8, "CD52", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD52", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD52", Patrol, "HZ");
		Comment("H2.6");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD52");
		Deaths(P6, AtLeast, 70, "Unused Terran Bldg type   1");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD52", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.6
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD52");
		Deaths(P6, AtLeast, 80, "Unused Terran Bldg type   1");
	},
	actions = {
		CreateUnit(16, "Hunter Killer (Hydralisk)", "CD52", P8);
		CreateUnit(29, "Devouring One (Zergling)", "CD52", P8);
		CreateUnit(20, "Kukulza (Mutalisk)", "CD52", P8);
		Order("Kukulza (Mutalisk)", P8, "CD52", Attack, "HZ");
		Order("Hunter Killer (Hydralisk)", P8, "CD52", Patrol, "HZ");
		Order("Devouring One (Zergling)", P8, "CD52", Patrol, "HZ");
		Comment("H2.6");
	},
}


Trigger { -- H2.7
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD53");
	},
	actions = {
		CreateUnit(16, "Jim Raynor (Vulture)", "CD53", P8);
		CreateUnit(26, "Sarah Kerrigan (Ghost)", "CD53", P8);
		Order("Jim Raynor (Vulture)", P8, "CD53", Patrol, "HZ");
		Order("Sarah Kerrigan (Ghost)", P8, "CD53", Patrol, "HZ");
		Comment("H2.7");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD53");
		Deaths(P6, AtLeast, 70, "Unused Terran Bldg type   2");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD53", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.7
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD53");
		Deaths(P6, AtLeast, 80, "Unused Terran Bldg type   2");
	},
	actions = {
		CreateUnit(16, "Edmund Duke (Siege Mode)", "CD53", P8);
		Comment("H2.7");
	},
}




Trigger { -- L1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD8");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD8", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD8", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD8", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD8", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD8", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD8", Attack, "HZ");
		Comment("L1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD8");
		Deaths(P6, AtLeast, 90, "Tassadar (Templar)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD8", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD8");
		Deaths(P6, AtLeast, 100, "Tassadar (Templar)");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD8", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD8", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD8", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD8", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD8", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD8", Attack, "HZ");
		Comment("L1");
	},
}


Trigger { -- L1.1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD12");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD12", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD12", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD12", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD12", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD12", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD12", Attack, "HZ");
		Comment("L1.1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD12");
		Deaths(P6, AtLeast, 90, "Protoss Nexus");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD12", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD12");
		Deaths(P6, AtLeast, 100, "Protoss Nexus");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD12", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD12", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD12", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD12", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD12", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD12", Attack, "HZ");
		Comment("L1.1");
	},
}


Trigger { -- L1.2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD13");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD13", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD13", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD13", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD13", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD13", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD13", Attack, "HZ");
		Comment("L1.2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD13");
		Deaths(P6, AtLeast, 90, "Terran Vulture");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD13", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD13");
		Deaths(P6, AtLeast, 100, "Terran Vulture");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD13", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD13", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD13", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD13", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD13", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD13", Attack, "HZ");
		Comment("L1.2");
	},
}


Trigger { -- L1.3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD14");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD14", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD14", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD14", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD14", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD14", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD14", Attack, "HZ");
		Comment("L1.3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD14");
		Deaths(P6, AtLeast, 90, "Terran Ghost");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD14", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD14");
		Deaths(P6, AtLeast, 100, "Terran Ghost");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD14", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD14", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD14", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD14", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD14", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD14", Attack, "HZ");
		Comment("L1.3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD14");
		Deaths(P6, AtLeast, 140, "Terran Ghost");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD14", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.3.1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD14");
		Deaths(P6, AtLeast, 150, "Terran Ghost");
	},
	actions = {
		CreateUnit(20, "Edmund Duke (Siege Mode)", "CD14", P8);
		CreateUnit(12, "Tom Kazansky (Wraith)", "CD14", P8);
		Order("Tom Kazansky (Wraith)", P8, "CD14", Attack, "HZ");
		Comment("L1.3.1");
	},
}


Trigger { -- L1.4
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD15");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD15", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD15", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD15", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD15", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD15", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD15", Attack, "HZ");
		Comment("L1.4");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD15");
		Deaths(P6, AtLeast, 90, "Protoss Scarab");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD15", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.4
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD15");
		Deaths(P6, AtLeast, 100, "Protoss Scarab");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD15", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD15", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD15", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD15", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD15", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD15", Attack, "HZ");
		Comment("L1.4");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD15");
		Deaths(P6, AtLeast, 140, "Protoss Scarab");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD15", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.6.1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD15");
		Deaths(P6, AtLeast, 150, "Protoss Scarab");
	},
	actions = {
		CreateUnit(20, "Edmund Duke (Siege Mode)", "CD15", P8);
		CreateUnit(12, "Tom Kazansky (Wraith)", "CD15", P8);
		Order("Tom Kazansky (Wraith)", P8, "CD15", Attack, "HZ");
		Comment("L1.6.1");
	},
}


Trigger { -- L1.5
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD18");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD18", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD18", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD18", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD18", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD18", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD18", Attack, "HZ");
		Comment("L1.5");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD18");
		Deaths(P6, AtLeast, 90, "Terran Beacon");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD18", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.5
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD18");
		Deaths(P6, AtLeast, 100, "Terran Beacon");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD18", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD18", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD18", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD18", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD18", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD18", Attack, "HZ");
		Comment("L1.5");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD18");
		Deaths(P6, AtLeast, 140, "Terran Beacon");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD18", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.5.1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD18");
		Deaths(P6, AtLeast, 150, "Terran Beacon");
	},
	actions = {
		CreateUnit(20, "Edmund Duke (Siege Mode)", "CD18", P8);
		CreateUnit(12, "Tom Kazansky (Wraith)", "CD18", P8);
		Order("Tom Kazansky (Wraith)", P8, "CD18", Attack, "HZ");
		Comment("L1.5.1");
	},
}


Trigger { -- L1.6
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD19");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD19", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD19", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD19", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD19", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD19", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD19", Attack, "HZ");
		Comment("L1.6");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD19");
		Deaths(P6, AtLeast, 90, "Terran Armory");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD19", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.6
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD19");
		Deaths(P6, AtLeast, 100, "Terran Armory");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD19", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD19", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD19", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD19", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD19", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD19", Attack, "HZ");
		Comment("L1.6");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD19");
		Deaths(P6, AtLeast, 140, "Terran Armory");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD19", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L1.6.1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD19");
		Deaths(P6, AtLeast, 150, "Terran Armory");
	},
	actions = {
		CreateUnit(20, "Edmund Duke (Siege Mode)", "CD19", P8);
		CreateUnit(12, "Tom Kazansky (Wraith)", "CD19", P8);
		Order("Tom Kazansky (Wraith)", P8, "CD19", Attack, "HZ");
		Comment("L1.6.1");
	},
}




Trigger { -- L2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD7");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD7", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD7", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD7", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD7", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD7", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD7", Attack, "HZ");
		Comment("L2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD7");
		Deaths(P6, AtLeast, 90, "Terran Marine");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD7", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD7");
		Deaths(P6, AtLeast, 100, "Terran Marine");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD7", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD7", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD7", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD7", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD7", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD7", Attack, "HZ");
		Comment("L2");
	},
}


Trigger { -- L2.1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD9");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD9", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD9", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD9", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD9", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD9", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD9", Attack, "HZ");
		Comment("L2.1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD9");
		Deaths(P6, AtLeast, 90, "Protoss Scout");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD9", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD9");
		Deaths(P6, AtLeast, 100, "Protoss Scout");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD9", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD9", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD9", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD9", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD9", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD9", Attack, "HZ");
		Comment("L2.1");
	},
}


Trigger { -- L2.2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD10");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD10", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD10", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD10", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD10", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD10", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD10", Attack, "HZ");
		Comment("L2.2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD10");
		Deaths(P6, AtLeast, 90, "Protoss Forge");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD10", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD10");
		Deaths(P6, AtLeast, 100, "Protoss Forge");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD10", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD10", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD10", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD10", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD10", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD10", Attack, "HZ");
		Comment("L2.2");
	},
}


Trigger { -- L2.3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD11");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD11", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD11", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD11", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD11", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD11", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD11", Attack, "HZ");
		Comment("L2.3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD11");
		Deaths(P6, AtLeast, 90, "Protoss Probe");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD11", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD11");
		Deaths(P6, AtLeast, 100, "Protoss Probe");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD11", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD11", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD11", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD11", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD11", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD11", Attack, "HZ");
		Comment("L2.3");
	},
}


Trigger { -- L2.4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD16");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD16", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD16", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD16", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD16", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD16", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD16", Attack, "HZ");
		Comment("L2.4");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD16");
		Deaths(P6, AtLeast, 90, "Psi Disrupter");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD16", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD16");
		Deaths(P6, AtLeast, 100, "Psi Disrupter");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD16", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD16", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD16", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD16", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD16", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD16", Attack, "HZ");
		Comment("L2.4");
	},
}


Trigger { -- L2.5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD17");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD17", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD17", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD17", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD17", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD17", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD17", Attack, "HZ");
		Comment("L2.5");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD17");
		Deaths(P6, AtLeast, 90, "Terran Marker");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD17", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD17");
		Deaths(P6, AtLeast, 100, "Terran Marker");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD17", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD17", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD17", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD17", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD17", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD17", Attack, "HZ");
		Comment("L2.5");
	},
}


Trigger { -- L2.6
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD54");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD54", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD54", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD54", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD54", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD54", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD54", Attack, "HZ");
		Comment("L2.6");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD54");
		Deaths(P6, AtLeast, 90, "Vespene Tank (Terran Type 1)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD54", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.6
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD54");
		Deaths(P6, AtLeast, 100, "Vespene Tank (Terran Type 1)");
	},
	actions = {
		CreateUnit(20, "Hunter Killer (Hydralisk)", "CD54", P8);
		CreateUnit(20, "Torrasque (Ultralisk)", "CD54", P8);
		CreateUnit(16, "Kukulza (Guardian)", "CD54", P8);
		Order("Hunter Killer (Hydralisk)", P8, "CD54", Patrol, "HZ");
		Order("Torrasque (Ultralisk)", P8, "CD54", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD54", Attack, "HZ");
		Comment("L2.6");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD54");
		Deaths(P6, AtLeast, 140, "Vespene Tank (Terran Type 1)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD54", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.6.1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD54");
		Deaths(P6, AtLeast, 150, "Vespene Tank (Terran Type 1)");
	},
	actions = {
		CreateUnit(20, "Edmund Duke (Siege Mode)", "CD54", P8);
		CreateUnit(12, "Tom Kazansky (Wraith)", "CD54", P8);
		Order("Tom Kazansky (Wraith)", P8, "CD54", Attack, "HZ");
		Comment("L2.6.1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Lair", "CD55");
		Deaths(P6, AtLeast, 90, "Vespene Tank (Terran Type 2)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD55", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- L2.7
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Lair", "CD55");
		Deaths(P6, AtLeast, 100, "Vespene Tank (Terran Type 2)");
	},
	actions = {
		CreateUnit(40, "Vulture Spider Mine", "CD55", P8);
		Comment("L2.7");
	},
}




Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 40, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 50, "Terran Academy");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD20", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD20", P8);
		CreateUnit(20, "Mojo (Scout)", "CD20", P8);
		Order("Zeratul (Dark Templar)", P8, "CD20", Patrol, "CD21");
		Order("Gui Montag (Firebat)", P8, "CD20", Patrol, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 140, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 150, "Terran Academy");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD20", P8);
		CreateUnit(12, "Mojo (Scout)", "CD20", P8);
		Order("Danimoth (Arbiter)", P8, "CD20", Attack, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 290, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 300, "Terran Academy");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD20", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD20", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD20", P8);
		Order("Alan Schezar (Goliath)", P8, "CD20", Patrol, "CD21");
		Order("Tassadar/Zeratul (Archon)", P8, "CD20", Patrol, "CD21");
		Order("Kukulza (Mutalisk)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 440, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 450, "Terran Academy");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD20", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD20", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD20", P8);
		Order("Norad II (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Order("Fenix (Dragoon)", P8, "CD20", Patrol, "CD21");
		Order("Hyperion (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 40, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 50, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(24, "Fenix (Zealot)", "CD21", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD21", P8);
		CreateUnit(20, "Mojo (Scout)", "CD21", P8);
		Order("Fenix (Zealot)", P8, "CD21", Patrol, "CD20");
		Order("Gui Montag (Firebat)", P8, "CD21", Patrol, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 140, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 150, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD21", P8);
		CreateUnit(12, "Mojo (Scout)", "CD21", P8);
		Order("Danimoth (Arbiter)", P8, "CD21", Attack, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 290, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 300, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD21", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD21", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD21", P8);
		Order("Alan Schezar (Goliath)", P8, "CD21", Patrol, "CD20");
		Order("Tassadar/Zeratul (Archon)", P8, "CD21", Patrol, "CD20");
		Order("Kukulza (Mutalisk)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 440, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 450, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD21", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD21", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD21", P8);
		Order("Norad II (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Order("Fenix (Dragoon)", P8, "CD21", Patrol, "CD20");
		Order("Hyperion (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 40, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 50, "Terran Civilian");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD27", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD27", P8);
		CreateUnit(20, "Mojo (Scout)", "CD27", P8);
		Order("Zeratul (Dark Templar)", P8, "CD27", Patrol, "CD26");
		Order("Gui Montag (Firebat)", P8, "CD27", Patrol, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 140, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 150, "Terran Civilian");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD27", P8);
		CreateUnit(12, "Mojo (Scout)", "CD27", P8);
		Order("Danimoth (Arbiter)", P8, "CD27", Attack, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 290, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 300, "Terran Civilian");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD27", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD27", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD27", P8);
		Order("Alan Schezar (Goliath)", P8, "CD27", Patrol, "CD26");
		Order("Tassadar/Zeratul (Archon)", P8, "CD27", Patrol, "CD26");
		Order("Kukulza (Mutalisk)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 440, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 450, "Terran Civilian");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD27", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD27", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD27", P8);
		Order("Norad II (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Order("Fenix (Dragoon)", P8, "CD27", Patrol, "CD26");
		Order("Hyperion (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 40, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 50, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(24, "Fenix (Zealot)", "CD26", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD26", P8);
		CreateUnit(20, "Mojo (Scout)", "CD26", P8);
		Order("Fenix (Zealot)", P8, "CD26", Patrol, "CD27");
		Order("Gui Montag (Firebat)", P8, "CD26", Patrol, "CD27");
		Order("Mojo (Scout)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 140, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 150, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD26", P8);
		CreateUnit(12, "Mojo (Scout)", "CD26", P8);
		Order("Danimoth (Arbiter)", P8, "CD26", Attack, "CD27");
		Order("Mojo (Scout)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 290, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 300, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD26", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD26", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD26", P8);
		Order("Alan Schezar (Goliath)", P8, "CD26", Patrol, "CD27");
		Order("Tassadar/Zeratul (Archon)", P8, "CD26", Patrol, "CD27");
		Order("Kukulza (Mutalisk)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 440, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 450, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD26", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD26", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD26", P8);
		Order("Norad II (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Order("Fenix (Dragoon)", P8, "CD26", Patrol, "CD27");
		Order("Hyperion (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}



Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 40, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 50, "Terran Barracks");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD20", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD20", P8);
		CreateUnit(20, "Mojo (Scout)", "CD20", P8);
		Order("Zeratul (Dark Templar)", P8, "CD20", Patrol, "CD21");
		Order("Gui Montag (Firebat)", P8, "CD20", Patrol, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 140, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 150, "Terran Barracks");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD20", P8);
		CreateUnit(12, "Mojo (Scout)", "CD20", P8);
		Order("Danimoth (Arbiter)", P8, "CD20", Attack, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 290, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 300, "Terran Barracks");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD20", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD20", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD20", P8);
		Order("Alan Schezar (Goliath)", P8, "CD20", Patrol, "CD21");
		Order("Tassadar/Zeratul (Archon)", P8, "CD20", Patrol, "CD21");
		Order("Kukulza (Mutalisk)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 440, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 450, "Terran Barracks");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD20", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD20", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD20", P8);
		Order("Norad II (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Order("Fenix (Dragoon)", P8, "CD20", Patrol, "CD21");
		Order("Hyperion (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 40, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 50, "Terran Starport");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD21", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD21", P8);
		CreateUnit(20, "Mojo (Scout)", "CD21", P8);
		Order("Zeratul (Dark Templar)", P8, "CD21", Patrol, "CD20");
		Order("Gui Montag (Firebat)", P8, "CD21", Patrol, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("8HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 140, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 150, "Terran Starport");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD21", P8);
		CreateUnit(12, "Mojo (Scout)", "CD21", P8);
		Order("Danimoth (Arbiter)", P8, "CD21", Attack, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 290, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 300, "Terran Starport");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD21", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD21", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD21", P8);
		Order("Alan Schezar (Goliath)", P8, "CD21", Patrol, "CD20");
		Order("Tassadar/Zeratul (Archon)", P8, "CD21", Patrol, "CD20");
		Order("Kukulza (Mutalisk)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 440, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 450, "Terran Starport");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD21", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD21", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD21", P8);
		Order("Norad II (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Order("Fenix (Dragoon)", P8, "CD21", Patrol, "CD20");
		Order("Hyperion (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 40, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 50, "Terran Refinery");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD27", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD27", P8);
		CreateUnit(20, "Mojo (Scout)", "CD27", P8);
		Order("Zeratul (Dark Templar)", P8, "CD27", Patrol, "CD26");
		Order("Gui Montag (Firebat)", P8, "CD27", Patrol, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 140, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 150, "Terran Refinery");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD27", P8);
		CreateUnit(12, "Mojo (Scout)", "CD27", P8);
		Order("Danimoth (Arbiter)", P8, "CD27", Attack, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("8HH2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 290, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 300, "Terran Refinery");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD27", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD27", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD27", P8);
		Order("Alan Schezar (Goliath)", P8, "CD27", Patrol, "CD26");
		Order("Tassadar/Zeratul (Archon)", P8, "CD27", Patrol, "CD26");
		Order("Kukulza (Mutalisk)", P8, "CD27", Attack, "CD26");
		Comment("8HH2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 440, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 450, "Terran Refinery");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD27", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD27", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD27", P8);
		Order("Norad II (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Order("Fenix (Dragoon)", P8, "CD27", Patrol, "CD26");
		Order("Hyperion (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Comment("8HH2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 40, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 50, "Terran Dropship");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD26", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD26", P8);
		CreateUnit(20, "Mojo (Scout)", "CD26", P8);
		Order("Zeratul (Dark Templar)", P8, "CD26", Patrol, "CD27");
		Order("Gui Montag (Firebat)", P8, "CD26", Patrol, "CD27");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("8HH3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 140, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 150, "Terran Dropship");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD26", P8);
		CreateUnit(12, "Mojo (Scout)", "CD26", P8);
		Order("Danimoth (Arbiter)", P8, "CD26", Attack, "CD27");
		Order("Mojo (Scout)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 290, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 300, "Terran Dropship");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD26", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD26", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD26", P8);
		Order("Alan Schezar (Goliath)", P8, "CD26", Patrol, "CD27");
		Order("Tassadar/Zeratul (Archon)", P8, "CD26", Patrol, "CD27");
		Order("Kukulza (Mutalisk)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 440, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 450, "Terran Dropship");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD26", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD26", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD26", P8);
		Order("Norad II (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Order("Fenix (Dragoon)", P8, "CD26", Patrol, "CD27");
		Order("Hyperion (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}




]]










function GunPoint(Player,GunID,Text,Point)
	TriggerX(FP,{Deaths(Player, AtLeast, 1, GunID);},{RotatePlayer({DisplayTextX(Text, 4)}, HumanPlayers, FP),SetScore(Force1, Add, Point, Kills),SetDeaths(Player,Subtract,1,GunID)},{preserved})
end

function HPoint(UnitID,Text,Point)
	TriggerX(FP,{Deaths(P7, AtLeast, 1, UnitID);},{DisplayText(Text, 4);SetScore(CurrentPlayer, Add, Point, Kills);PlayWAV("staredit\\wav\\cut.ogg");PlayWAV("staredit\\wav\\cut.ogg");},{preserved})
end



GunPoint(P8,"Zerg Hatchery","\x13\x04 Hatchery \x0720000 \x04Point",20000)
GunPoint(P7, "Zerg Hatchery", "\x13\x04 Hatchery \x0720000 \x04Point", 20000)
GunPoint(P8, "Infested Command Center", "\x13\x04 Infested Command Center \x07100000 \x04Point", 100000)
GunPoint(P8, "Zerg Overmind (With Shell)", "\x13\x04 Zerg Overmind(With Shell) \x0780000 \x04Point", 80000)
GunPoint(P8, "Protoss Temple", "\x13\x04 Protoss Temple \x07200000 \x04Point", 200000)
GunPoint(P8, "Protoss Nexus", "\x13\x04 Protoss Nexus \x07150000 \x04Point", 150000)
GunPoint(P8, "Zerg Lair", "\x13\x04 Zerg Lair \x0730000 \x04Point", 30000)
GunPoint(P7, "Zerg Lair", "\x13\x04 Zerg Lair \x0730000 \x04Point", 30000)
GunPoint(P7, "Power Generator", "\x13\x04 Power Generator \x07100000 \x04Point", 100000)
GunPoint(P7, "Zerg Hive", "\x13\x04 Zerg Hive \x0750000 \x04Point", 50000)
GunPoint(P8, "Zerg Hive", "\x13\x04 Zerg Hive \x0750000 \x04Point", 50000)
GunPoint(P8, "Stasis Cell/Prison", "\x13\x04 Stasis Cell/Prison \x0770000 \x04Point", 70000)
GunPoint(P8, "Zerg Overmind", "\x13\x04 Zerg Overmind \x0760000 \x04Point", 60000)
GunPoint(P8, "Psi Disrupter", "\x13\x04 Psi Disrupter \x0780000 \x04Point", 80000)
GunPoint(P8, "Terran Armory", "\x13\x04 Terran Armory \x0760000 \x04Point", 60000)
GunPoint(P8, "Terran Engineering Bay", "\x13\x04 Terran Engineering Bay \x0750000 \x04Point", 50000)
GunPoint(P8, "Terran Command Center", "\x13\x04 Terran Command Center \x0740000 \x04Point", 40000)
GunPoint(P7, "Norad II (Crashed Battlecruiser)", "\x13\x04 Norad II \x0720000 \x04Point", 20000)
GunPoint(P7, "Ion Cannon", "\x13\x04 Ion Cannon \x0770000 \x04Point", 70000)
GunPoint(P8, "Zerg Cerebrate Daggoth", "\x13\x04 Zerg Cerebrate Daggoth \x0730000 \x04Point", 30000)
GunPoint(P8, "Warp Gate", "\x13\x04 Warp Gate \x07100000 \x04Point", 100000)
GunPoint(P8, "Protoss Stargate", "\x13\x04 Protoss Stargate \x07100000 \x04Point", 100000)
GunPoint(P7, "Terran Supply Depot", "\x13\x04 Terran Supply Depot \x0710000 \x04Point", 10000)
GunPoint(P8, "Norad II (Crashed Battlecruiser)", "\x13\x04 Norad II \x07100000 \x04Point", 100000)
GunPoint(P8, "Xel'Naga Temple", "\x13\x04 Xel'Naga Temple \x07150000 \x04Point", 150000)
GunPoint(P8, "Power Generator", "\x13\x04 Power Generator \x0780000 \x04Point", 80000)
GunPoint(P8, "Ion Cannon", "\x13\x04 Ion Cannon \x0770000 \x04Point", 70000)
GunPoint(P8, "Zerg Cerebrate", "\x13\x04 Zerg Cerebrate \x0740000 \x04Point", 40000)
GunPoint(P8, "Terran Factory", "\x13\x04 Terran Factory \x0740000 \x04Point", 40000)
GunPoint(P8, "Terran Barracks", "\x13\x04 Terran Barracks \x0740000 \x04Point", 40000)
GunPoint(P7, "Infested Command Center", "\x13\x04 Infested Command Center \x0770000 \x04Point", 70000)
HPoint("Gui Montag (Firebat)", "\x13\x1F Gui Montag \x0750000 \x04Point", 50000)
HPoint("Sarah Kerrigan (Ghost)", "\x13\x1F Sarah Kerrigan \x0730000 \x04Point", 30000)
HPoint("Alan Schezar (Goliath)", "\x13\x1F Alan Schezar \x0735000 \x04Point", 35000)
HPoint("Jim Raynor (Vulture)", "\x13\x1F Jim Raynor \x0740000 \x04Point", 40000)
HPoint("Tom Kazansky (Wraith)", "\x13\x1F Tom Kazansky \x0750000 \x04Point", 50000)
HPoint("Edmund Duke (Siege Tank)", "\x13\x1F Edmund Duke \x0740000 \x04Point", 40000)
HPoint("Edmund Duke (Siege Mode)", "\x13\x1F Edmund Duke \x0730000 \x04Point", 30000)
HPoint("Hyperion (Battlecruiser)", "\x13\x1F Hyperion \x0760000 \x04Point", 60000)
HPoint("Norad II (Battlecruiser)", "\x13\x1F Norad II \x07150000 \x04Point", 150000)
HPoint("Zeratul (Dark Templar)", "\x13\x1F Zeratul \x0745000 \x04Point", 45000)
HPoint("Tassadar (Templar)", "\x13\x1F Tassadar \x0750000 \x04Point", 50000)
HPoint("Tassadar/Zeratul (Archon)", "\x13\x1F Tassadar/Zeratul \x0765000 \x04Point", 65000)
HPoint("Fenix (Zealot)", "\x13\x1F Fenix \x0735000 \x04Point", 35000)
HPoint("Fenix (Dragoon)", "\x13\x1F Fenix \x0740000 \x04Point", 40000)
HPoint("Mojo (Scout)", "\x13\x1F Mojo \x0760000 \x04Point", 60000)
HPoint("Warbringer (Reaver)", "\x13\x1F Warbringer \x0750000 \x04Point", 50000)
HPoint("Gantrithor (Carrier)", "\x13\x1F Gantrithor \x0790000 \x04Point", 90000)
HPoint("Danimoth (Arbiter)", "\x13\x1F Danimoth \x0770000 \x04Point", 70000)


end
