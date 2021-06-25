from eudplib import *
import math
Boss = EUDVariable()
def onPluginStart():
	DoActions(SetMemory(0x58F55C,SetTo,Boss.getValueAddr()))


def beforeTriggerExec(): 
	VResetSw2 = EUDVariable()
	
	if EUDIf()((Bring(P8, AtLeast, 1, 68, "Anywhere"))):
		if EUDIf()((Deaths(P8,Exactly,1,214))):
			
			if EUDIf()((Boss>=1,Bring(P8, AtLeast, 1, 68, "Anywhere"))):
				Trigger(conditions=[Deaths(Boss+2, AtMost, 100*256, 0),Memory(0x58F558,AtLeast,1)],
						actions=[SetMemory(0x58F558,Subtract,1),SetDeaths(Boss+2,Add,770*256,0)])
						
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 1),],
						actions=[SetDeaths(Boss+13,SetTo,427,0)])
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 2),],
						actions=[SetDeaths(Boss+13,SetTo,640,0)])
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 3),],
						actions=[SetDeaths(Boss+13,SetTo,853,0)])
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 4),],
						actions=[SetDeaths(Boss+13,SetTo,1280,0)])
			EUDEndIf()

			Type = EUDVariable()
			Seed = EUDVariable()
			Check = EUDVariable()

			if EUDIf()((Memory(0x58F570,Exactly,0),Memory(0x58F564,Exactly,0),Switch("Switch 34",Cleared))):
				Check << 0
			EUDEndIf()

			if EUDIf()((Memory(0x58F564,Exactly,1),Check == 0)):
				Seed << 0
				Check << 1
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(1)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(2)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(4)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(8)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(16)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(32)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(64)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(128)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(256)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(512)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(1024)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(2048)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(4096)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(8192)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(16384)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(32784)])

				Trigger(conditions=[Seed>=0,Seed<=2730*1],actions=[SetMemory(0x58F56C,SetTo,0x00051234)])
				Trigger(conditions=[Seed>=2730*1+1,Seed<=2730*2],actions=[SetMemory(0x58F56C,SetTo,0x00051243)])
				Trigger(conditions=[Seed>=2730*2+1,Seed<=2730*3],actions=[SetMemory(0x58F56C,SetTo,0x00051324)])
				Trigger(conditions=[Seed>=2730*3+1,Seed<=2730*4],actions=[SetMemory(0x58F56C,SetTo,0x00051342)])
				Trigger(conditions=[Seed>=2730*4+1,Seed<=2730*5],actions=[SetMemory(0x58F56C,SetTo,0x00051423)])
				Trigger(conditions=[Seed>=2730*5+1,Seed<=2730*6],actions=[SetMemory(0x58F56C,SetTo,0x00051432)])

				Trigger(conditions=[Seed>=2730*6+1,Seed<=2730*7],actions=[SetMemory(0x58F56C,SetTo,0x00052134)])
				Trigger(conditions=[Seed>=2730*7+1,Seed<=2730*8],actions=[SetMemory(0x58F56C,SetTo,0x00052143)])
				Trigger(conditions=[Seed>=2730*8+1,Seed<=2730*9],actions=[SetMemory(0x58F56C,SetTo,0x00052314)])
				Trigger(conditions=[Seed>=2730*9+1,Seed<=2730*10],actions=[SetMemory(0x58F56C,SetTo,0x00052341)])
				Trigger(conditions=[Seed>=2730*10+1,Seed<=2730*11],actions=[SetMemory(0x58F56C,SetTo,0x00052413)])
				Trigger(conditions=[Seed>=2730*11+1,Seed<=2730*12],actions=[SetMemory(0x58F56C,SetTo,0x00052431)])

				Trigger(conditions=[Seed>=2730*12+1,Seed<=2730*13],actions=[SetMemory(0x58F56C,SetTo,0x00053124)])
				Trigger(conditions=[Seed>=2730*13+1,Seed<=2730*14],actions=[SetMemory(0x58F56C,SetTo,0x00053142)])
				Trigger(conditions=[Seed>=2730*14+1,Seed<=2730*15],actions=[SetMemory(0x58F56C,SetTo,0x00053214)])
				Trigger(conditions=[Seed>=2730*15+1,Seed<=2730*16],actions=[SetMemory(0x58F56C,SetTo,0x00053241)])
				Trigger(conditions=[Seed>=2730*16+1,Seed<=2730*17],actions=[SetMemory(0x58F56C,SetTo,0x00053124)])
				Trigger(conditions=[Seed>=2730*17+1,Seed<=2730*18],actions=[SetMemory(0x58F56C,SetTo,0x00053142)])

				Trigger(conditions=[Seed>=2730*18+1,Seed<=2730*19],actions=[SetMemory(0x58F56C,SetTo,0x00054123)])
				Trigger(conditions=[Seed>=2730*19+1,Seed<=2730*20],actions=[SetMemory(0x58F56C,SetTo,0x00054132)])
				Trigger(conditions=[Seed>=2730*20+1,Seed<=2730*21],actions=[SetMemory(0x58F56C,SetTo,0x00054213)])
				Trigger(conditions=[Seed>=2730*21+1,Seed<=2730*22],actions=[SetMemory(0x58F56C,SetTo,0x00054231)])
				Trigger(conditions=[Seed>=2730*22+1,Seed<=2730*23],actions=[SetMemory(0x58F56C,SetTo,0x00054312)])
				Trigger(conditions=[Seed>=2730*23+1,Seed<=65535],actions=[SetMemory(0x58F56C,SetTo,0x00054321)])

			EUDEndIf()

			if EUDIf()((Bring(P8, AtLeast, 1, "Tarim, Lord Of Regal Castle", "Anywhere"))):
				Trigger(conditions=[Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,1*1,0xF)],actions=[Type.SetNumber(1)])
				Trigger(conditions=[Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,1*16,0xF0)],actions=[Type.SetNumber(1)])
				Trigger(conditions=[Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,1*256,0xF00)],actions=[Type.SetNumber(1)])
				Trigger(conditions=[Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,1*4096,0xF000)],actions=[Type.SetNumber(1)])
				Trigger(conditions=[Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,1*65536,0xF0000)],actions=[Type.SetNumber(1)])
				Trigger(conditions=[Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,2*1,0xF)],actions=[Type.SetNumber(2)])
				Trigger(conditions=[Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,2*16,0xF0)],actions=[Type.SetNumber(2)])
				Trigger(conditions=[Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,2*256,0xF00)],actions=[Type.SetNumber(2)])
				Trigger(conditions=[Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,2*4096,0xF000)],actions=[Type.SetNumber(2)])
				Trigger(conditions=[Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,2*65536,0xF0000)],actions=[Type.SetNumber(2)])
				Trigger(conditions=[Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,3*1,0xF)],actions=[Type.SetNumber(3)])
				Trigger(conditions=[Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,3*16,0xF0)],actions=[Type.SetNumber(3)])
				Trigger(conditions=[Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,3*256,0xF00)],actions=[Type.SetNumber(3)])
				Trigger(conditions=[Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,3*4096,0xF000)],actions=[Type.SetNumber(3)])
				Trigger(conditions=[Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,3*65536,0xF0000)],actions=[Type.SetNumber(3)])
				Trigger(conditions=[Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,4*1,0xF)],actions=[Type.SetNumber(4)])
				Trigger(conditions=[Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,4*16,0xF0)],actions=[Type.SetNumber(4)])
				Trigger(conditions=[Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,4*256,0xF00)],actions=[Type.SetNumber(4)])
				Trigger(conditions=[Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,4*4096,0xF000)],actions=[Type.SetNumber(4)])
				Trigger(conditions=[Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,4*65536,0xF0000)],actions=[Type.SetNumber(4)])
				Trigger(conditions=[Memory(0x58F570,Exactly,0),MemoryX(0x58F56C,Exactly,5*1,0xF)],actions=[Type.SetNumber(5)])
				Trigger(conditions=[Memory(0x58F570,Exactly,1),MemoryX(0x58F56C,Exactly,5*16,0xF0)],actions=[Type.SetNumber(5)])
				Trigger(conditions=[Memory(0x58F570,Exactly,2),MemoryX(0x58F56C,Exactly,5*256,0xF00)],actions=[Type.SetNumber(5)])
				Trigger(conditions=[Memory(0x58F570,Exactly,3),MemoryX(0x58F56C,Exactly,5*4096,0xF000)],actions=[Type.SetNumber(5)])
				Trigger(conditions=[Memory(0x58F570,Exactly,4),MemoryX(0x58F56C,Exactly,5*65536,0xF0000)],actions=[Type.SetNumber(5)])
			EUDEndIf()

			if EUDIf()((Memory(0x58F564,Exactly,1))):
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 1),],
						actions=[Seed.SetNumber(400)])
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 2),],
						actions=[Seed.SetNumber(500)])
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 3),],
						actions=[Seed.SetNumber(600)])
				Trigger(conditions=[Memory(0x594000+4*41, Exactly, 4),],
						actions=[Seed.SetNumber(800)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(1)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(2)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(4)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(8)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(16)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(32)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(64)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(128)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(256)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(512)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(1024)])
				DoActions(SetSwitch("Switch 255",Random))
				Trigger(conditions=[Switch("Switch 255",Set)],actions=[Seed.AddNumber(2048)])
				DoActions([SetMemory(0x6CA1F4, SetTo, Seed),SetMemoryX(0x6C9DF4, SetTo, (Seed//10)*65536,0xFFFF0000)])
			EUDEndIf()

			Trigger(conditions=[Type==1],actions=[SetMemoryX(0x669FAC, SetTo, 13*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)])
			Trigger(conditions=[Type==2],actions=[SetMemoryX(0x669FAC, SetTo, 16*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)])
			Trigger(conditions=[Type==3],actions=[SetMemoryX(0x669FAC, SetTo, 17*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)])
			Trigger(conditions=[Type==4],actions=[SetMemoryX(0x669FAC, SetTo, 10*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)])
			Trigger(conditions=[Type==5],actions=[SetMemoryX(0x669FAC, SetTo, 12*16777216,0xFF000000),SetMemoryX(0x666458, SetTo, 391, 0xFFFF)])
			DX = EUDVariable()
			DY = EUDVariable()
			DZ = EUDVariable()
			if EUDIf()((Memory(0x594000+4*41, Exactly, 1))):
				DX << 2
				DY << 1
				DZ << 0
			EUDEndIf()
			if EUDIf()((Memory(0x594000+4*41, Exactly, 2))):
				DX << 4
				DY << 1
				DZ << 1
			EUDEndIf()
			if EUDIf()((Memory(0x594000+4*41, Exactly, 3))):
				DX << 6
				DY << 1
				DZ << 2
			EUDEndIf()
			if EUDIf()((Memory(0x594000+4*41, Exactly, 4))):
				DX << 8
				DY << 2
				DZ << 2
			EUDEndIf()

			Del = EUDVariable()
			Loc = EUDVariable()
			Num = EUDVariable()

			if EUDIf()((Memory(0x58F564,Exactly,61),Type==1)):
				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*30,SetTo,0),
					SetMemory(0x58DC6C+0x14*30,SetTo,6144),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DX)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<3096,Num == 0)):
						DoActions([
							SetMemory(0x58DC60+0x14*30,SetTo,Loc),
							SetMemory(0x58DC68+0x14*30,SetTo,Loc+32),
							RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))
			EUDEndIf()

			if EUDIf()((Memory(0x58F564,Exactly,61),Type==2)):
				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*30,SetTo,0),
					SetMemory(0x58DC6C+0x14*30,SetTo,6144),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DX)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<3096,Num == 0)):
						DoActions([
							SetMemory(0x58DC60+0x14*30,SetTo,3072-Loc),
							SetMemory(0x58DC68+0x14*30,SetTo,3096-Loc),
							RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))
			EUDEndIf()

			if EUDIf()((Memory(0x58F564,Exactly,61),Type==3)):
				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC60+0x14*30,SetTo,0),
					SetMemory(0x58DC68+0x14*30,SetTo,3072),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DX)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<6144,Num == 0)):
						DoActions([
							SetMemory(0x58DC64+0x14*30,SetTo,Loc),
							SetMemory(0x58DC6C+0x14*30,SetTo,Loc+32),
							RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))
			EUDEndIf()

			if EUDIf()((Memory(0x58F564,Exactly,61),Type==4)):
				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC60+0x14*30,SetTo,0),
					SetMemory(0x58DC68+0x14*30,SetTo,3072),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DX)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<6144,Num == 0)):
						DoActions([
							SetMemory(0x58DC64+0x14*30,SetTo,6112-Loc),
							SetMemory(0x58DC6C+0x14*30,SetTo,6144-Loc),
							RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))
			EUDEndIf()

			if EUDIf()((Memory(0x58F564,Exactly,61),Type==5)):
				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*30,SetTo,0),
					SetMemory(0x58DC6C+0x14*30,SetTo,6144),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DY)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<3072,Num == 0)):
						DoActions([
							SetMemory(0x58DC60+0x14*30,SetTo,Loc),
							SetMemory(0x58DC68+0x14*30,SetTo,Loc+32),
								RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))

				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*30,SetTo,0),
					SetMemory(0x58DC6C+0x14*30,SetTo,6144),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DY)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<3072,Num == 0)):
						DoActions([
							SetMemory(0x58DC60+0x14*30,SetTo,3072-Loc),
							SetMemory(0x58DC68+0x14*30,SetTo,3096-Loc),
							RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))

				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC60+0x14*30,SetTo,0),
					SetMemory(0x58DC68+0x14*30,SetTo,3072),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DZ)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<6144,Num == 0)):
						DoActions([
							SetMemory(0x58DC64+0x14*30,SetTo,Loc),
							SetMemory(0x58DC6C+0x14*30,SetTo,Loc+32),
								RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))

				Del << 0
				DoActions([
					SetMemory(0x58DC60+0x14*31,SetTo,0),
					SetMemory(0x58DC68+0x14*31,SetTo,0),
					SetMemory(0x58DC64+0x14*31,SetTo,0),
					SetMemory(0x58DC6C+0x14*31,SetTo,0),
					SetMemory(0x58DC60+0x14*30,SetTo,0),
					SetMemory(0x58DC68+0x14*30,SetTo,3072),
					SetMemoryX(0x669E28, SetTo, 16,0xFF),
				])
				if EUDWhile()((Del<DZ)):
					Loc << 0
					Num << 0
					if EUDWhile()((Loc<6144,Num == 0)):
						DoActions([
							SetMemory(0x58DC64+0x14*30,SetTo,6112-Loc),
							SetMemory(0x58DC6C+0x14*30,SetTo,6144-Loc),
								RemoveUnitAt(1,47,"CLoc109",P8),
						])
						Trigger(conditions=[Bring(P8, AtLeast, 1, 60, "CLoc109")],
							actions=[Num.SetNumber(1),
								MoveLocation("Shot", 60, P8, "CLoc109"),MoveLocation("CLoc115", 60, P8, "CLoc109"),
								GiveUnits(1,60,P8,"CLoc115",P12),
								RemoveUnit(60,P12),
								CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),
								MoveUnit(All, 47, P8, "Start", "Shot"),
								KillUnit(47, P8),
								])
						Loc << Loc + 32
					EUDEndWhile()
					Del << Del + 1
				EUDEndWhile()
				DoActions(SetMemoryX(0x669E28, SetTo, 0,0xFF))
			EUDEndIf()
		EUDEndIf()
		VResetSw2 << 0
	if EUDElseIf()((VResetSw2 == 0)):
		VResetSw2 << 1
		Type << 0
		Seed << 0
		Check << 0
		DX << 0
		DY << 0
		DZ << 0
		Del << 0
		Loc << 0
		Num << 0
	EUDEndIf()