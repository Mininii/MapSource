from eudplib import *
import math
import customText as ct

F2B = EUDVariable()
def onPluginStart():
	DoActions(SetMemory(0x58F528,SetTo,F2B.getValueAddr()))

def beforeTriggerExec():
	VResetSw = EUDVariable()


	Del = EUDVariable()
	Loc = EUDVariable()
	Num = EUDVariable()
	F1Del = EUDVariable()
	Seed = EUDVariable()
	CunitX = EUDVariable()
	CunitX19 = EUDVariable()
	CunitX25 = EUDVariable()
	F1LocX = EUDVariable()
	F1LocY = EUDVariable()
	LocX = EUDVariable()
	LocY = EUDVariable()


	F2BHP = EUDVariable()
	F2BSH = EUDVariable()
	F2BDX = EUDVariable()
	F2BDT = EUDVariable()
	F2BDY = EUDVariable()
	F2BDH = EUDVariable()
	F2BRT = EUDVariable()
	F2BRU = EUDVariable()
	F2BRS = EUDVariable()
	F2BRV = EUDVariable()
	F2BSD = EUDVariable()

	F2XT1 = EUDVariable()
	F2XT2 = EUDVariable()
	F2XT3 = EUDVariable()

	if EUDIf()((F2B>=1,Bring(P8, AtLeast, 1, 87, "Anywhere"))):

		Trigger(conditions=[Deaths(F2B+2, AtMost, 3333*256, 0),F2BHP == 0,F2BSH == 0],actions=[F2BSH.SetNumber(1),SetMemory(0x58F518,SetTo,1)])
		Trigger(conditions=[Deaths(F2B+2, AtMost, 2000*256, 0),F2BHP == 0,F2BSH == 1],actions=[F2BSH.SetNumber(2),SetMemory(0x58F518,SetTo,2)])
		Trigger(conditions=[Deaths(F2B+2, AtMost, 5000*256, 0),F2BHP == 1,F2BSH == 2],actions=[F2BSH.SetNumber(3),SetMemory(0x58F518,SetTo,3)])
		Trigger(conditions=[Deaths(F2B+2, AtMost, 4000*256, 0),F2BHP == 1,F2BSH == 3],actions=[F2BSH.SetNumber(4),SetMemory(0x58F518,SetTo,4)])
		Trigger(conditions=[Deaths(F2B+2, AtMost, 2600*256, 0),F2BHP == 1,F2BSH == 4],actions=[F2BSH.SetNumber(5),SetMemory(0x58F518,SetTo,5)])
		Trigger(conditions=[Deaths(F2B+2, AtMost, 1300*256, 0),F2BHP == 1,F2BSH == 5],actions=[F2BSH.SetNumber(6),SetMemory(0x58F518,SetTo,6)])
		Trigger(conditions=[Deaths(F2B+2, AtMost, 1300*256, 0),F2BHP == 2,F2BSH == 6],actions=[F2BSH.SetNumber(7),SetMemory(0x58F518,SetTo,7)])

		Trigger(conditions=[Deaths(F2B+2, AtMost, 650*256, 0),F2BHP == 0],
				actions=[F2BHP.SetNumber(1),SetDeaths(F2B+2,SetTo,5555*256,0),SetMemory(0x58F51C,SetTo,1)])
		Trigger(conditions=[Deaths(F2B+2, AtMost, 650*256, 0),F2BHP == 1],
				actions=[F2BHP.SetNumber(2),SetDeaths(F2B+2,SetTo,2000*256,0),SetMemory(0x58F51C,SetTo,2)])

		Trigger(conditions=[Memory(0x594000+4*41,Exactly,1)],actions=[F2BRU.SetNumber(36*1),SetDeaths(F2B+13,SetTo,640,0),SetDeathsX(F2B+18,SetTo,27,0,0xFFFF)])
		Trigger(conditions=[Memory(0x594000+4*41,Exactly,2)],actions=[F2BRU.SetNumber(36*4),SetDeaths(F2B+13,SetTo,853,0),SetDeathsX(F2B+18,SetTo,27,0,0xFFFF)])
		Trigger(conditions=[Memory(0x594000+4*41,Exactly,3)],actions=[F2BRU.SetNumber(36*7),SetDeaths(F2B+13,SetTo,1024,0),SetDeathsX(F2B+18,SetTo,67,0,0xFFFF)])
		Trigger(conditions=[Memory(0x594000+4*41,Exactly,4)],actions=[F2BRU.SetNumber(36*10),SetDeaths(F2B+13,SetTo,1280,0),SetDeathsX(F2B+18,SetTo,160,0,0xFFFF)])

		Trigger(conditions=[Memory(0x594000+4*41,Exactly,1)],actions=[F2XT2.SetNumber(18*1),F2XT3.SetNumber(36*61)])
		Trigger(conditions=[Memory(0x594000+4*41,Exactly,2)],actions=[F2XT2.SetNumber(18*2),F2XT3.SetNumber(36*53)])
		Trigger(conditions=[Memory(0x594000+4*41,Exactly,3)],actions=[F2XT2.SetNumber(18*3),F2XT3.SetNumber(36*45)])
		Trigger(conditions=[Memory(0x594000+4*41,Exactly,4)],actions=[F2XT2.SetNumber(18*4),F2XT3.SetNumber(36*37)])
		Trigger(conditions=[DeathsX(F2B+19, AtMost, 0*256, 0,0xFF00)],actions=[F2B.SetNumber(0)])

		if EUDIf()((F2BRS == 0)): # Random
			F2BSD << 72
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(1)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(2)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(4)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(8)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(16)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(32)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(64)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(128)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(256)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(512)])
			DoActions(SetSwitch("Switch 200",Random))
			Trigger(conditions=[Switch("Switch 200",Set)],actions=[F2BSD.AddNumber(1024)])
			DoActions([F2BRS.SetNumber(1)])
			F2BRT << F2BSD
		EUDEndIf()

		if EUDIf()((EUDOr(F2BRT<=F2BRU,F2XT1<=F2XT2))):
			DoActions(SetMemory(0x58F520,SetTo,1))
		EUDEndIf()
		if EUDIf()((F2BRV == 0)):
			F2BDX << f_maskread_epd(F2B+2,0xFFFFFFFF)
			F2BDT << F2BDY - F2BDX	
			if EUDIf()((EUDOr(F2BRT<=F2BRU,F2XT1<=F2XT2))):
				if EUDIf()((F2BDT>=1*256,F2BDT<=0x7FFFFFFF)):
					Trigger(conditions=[F2BDT>=640000*256],actions=[F2BDT.SubtractNumber(640000*256),KillUnitAt(64,"Men",64,Force1)])
					Trigger(conditions=[F2BDT>=320000*256],actions=[F2BDT.SubtractNumber(320000*256),KillUnitAt(32,"Men",64,Force1)])
					Trigger(conditions=[F2BDT>=160000*256],actions=[F2BDT.SubtractNumber(160000*256),KillUnitAt(16,"Men",64,Force1)])
					Trigger(conditions=[F2BDT>=80000*256],actions=[F2BDT.SubtractNumber(80000*256),KillUnitAt(8,"Men",64,Force1)])
					Trigger(conditions=[F2BDT>=40000*256],actions=[F2BDT.SubtractNumber(40000*256),KillUnitAt(4,"Men",64,Force1)])
					Trigger(conditions=[F2BDT>=20000*256],actions=[F2BDT.SubtractNumber(20000*256),KillUnitAt(2,"Men",64,Force1)])
					Trigger(conditions=[F2BDT>=10000*256],actions=[F2BDT.SubtractNumber(10000*256),KillUnitAt(1,"Men",64,Force1)])
					DoActions(SetDeaths(F2B+2,SetTo,F2BDY,0))
				EUDEndIf()
			EUDEndIf()
			F2BDY << F2BDX
			F2BRV << 12
		EUDEndIf()
		Trigger(conditions=[F2BRV>=1],actions=[F2BRV.SubtractNumber(1)])
		Trigger(conditions=[F2BRT>=61*36],actions=[F2BRT.SetNumber(0)])
		Trigger(conditions=[F2XT1>=F2XT3],actions=[F2XT1.SetNumber(0)])
		F2BRT << F2BRT + 1
		F2XT1 << F2XT1 + 1
	EUDEndIf()

	Del2 = EUDVariable()
	Loc2 = EUDVariable()
	Num2 = EUDVariable()
	F1Del2 = EUDVariable()
	Seed2 = EUDVariable()
	CunitX2 = EUDVariable()
	CunitX219 = EUDVariable()
	CunitX225 = EUDVariable()

	if EUDIf()((Memory(0x594000+4*1545,Exactly,1),Memory(0x58F524,Exactly,2),F1Del2 == 0)):

		DoActions([CunitX2.SetNumber(161741),CunitX219.SetNumber(161741+19),CunitX225.SetNumber(161741+25)]) 

		if EUDWhile()(CunitX2 >= 19025):

			if EUDIf()((Deaths(CunitX225,Exactly,84,0),DeathsX(CunitX219,Exactly,7,0,0xFF))): # Random
				Seed2 << -128
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(1)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(2)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(4)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(8)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(16)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(32)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(64)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(128)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(256)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,1)],actions=[Seed2.AddNumber(128)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,2)],actions=[Seed2.AddNumber(256)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,3)],actions=[Seed2.AddNumber(384)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,4)],actions=[Seed2.AddNumber(512)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,1)],actions=[Seed2.AddNumber(256)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,2)],actions=[Seed2.AddNumber(512)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,3)],actions=[Seed2.AddNumber(768)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,4)],actions=[Seed2.AddNumber(1024)])
				DoActions([SetDeaths(CunitX2+13,SetTo,Seed2,0)])
			EUDEndIf()

			DoActions([CunitX2.SubtractNumber(84),CunitX219.SubtractNumber(84),CunitX225.SubtractNumber(84)])

		EUDEndWhile()

	EUDEndIf()

	if EUDIf()((Memory(0x594000+4*1545,Exactly,2),Memory(0x58F524,Exactly,2),F1Del2 == 0)):

		DoActions([CunitX2.SetNumber(161741),CunitX219.SetNumber(161741+19),CunitX225.SetNumber(161741+25)]) 

		if EUDWhile()(CunitX2 >= 19025):

			if EUDIf()((Deaths(CunitX225,Exactly,84,0),DeathsX(CunitX219,Exactly,7,0,0xFF))): # Random
				Trigger(conditions=[Memory(0x594000+4*41,Exactly,1)],actions=[Seed2.SetNumber(1536)])
				Trigger(conditions=[Memory(0x594000+4*41,Exactly,2)],actions=[Seed2.SetNumber(1280)])
				Trigger(conditions=[Memory(0x594000+4*41,Exactly,3)],actions=[Seed2.SetNumber(1024)])
				Trigger(conditions=[Memory(0x594000+4*41,Exactly,4)],actions=[Seed2.SetNumber(768)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(1)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(2)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(4)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(8)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(16)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(32)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(64)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(128)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(256)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(512)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(1024)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(2048)])
				DoActions([SetDeaths(CunitX2+13,SetTo,Seed2,0)])
			EUDEndIf()

			DoActions([CunitX2.SubtractNumber(84),CunitX219.SubtractNumber(84),CunitX225.SubtractNumber(84)])

		EUDEndWhile()

	EUDEndIf()

	if EUDIf()((Memory(0x594000+4*1545,AtLeast,3),Memory(0x594000+4*1545,AtMost,4),Memory(0x58F524,Exactly,2),F1Del2 == 0)):

		DoActions([CunitX2.SetNumber(161741),CunitX219.SetNumber(161741+19),CunitX225.SetNumber(161741+25)]) 

		if EUDWhile()(CunitX2 >= 19025):

			if EUDIf()((Deaths(CunitX225,Exactly,84,0),DeathsX(CunitX219,Exactly,7,0,0xFF))): # Random
				Seed2 << 0
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(1)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(2)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(4)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(8)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(16)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(32)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(64)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(128)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(256)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(512)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set)],actions=[Seed2.AddNumber(1024)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,1)],actions=[Seed2.AddNumber(256+1024)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,2)],actions=[Seed2.AddNumber(512+1024)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,3)],actions=[Seed2.AddNumber(768+1021)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,4)],actions=[Seed2.AddNumber(1024+1024)])
				DoActions(SetSwitch("Switch 200",Random))
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,1)],actions=[Seed2.AddNumber(256)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,2)],actions=[Seed2.AddNumber(512)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,3)],actions=[Seed2.AddNumber(768)])
				Trigger(conditions=[Switch("Switch 200",Set),Memory(0x594000+4*41,Exactly,4)],actions=[Seed2.AddNumber(1024)])
				DoActions([SetDeaths(CunitX2+13,SetTo,Seed2,0)])
			EUDEndIf()

			DoActions([CunitX2.SubtractNumber(84),CunitX219.SubtractNumber(84),CunitX225.SubtractNumber(84)])

		EUDEndWhile()

	EUDEndIf()

	if EUDIf()((Memory(0x594000+4*1545,AtLeast,1),Memory(0x594000+4*1545,AtMost,4))):
		Trigger(conditions=[Memory(0x58F524,Exactly,2),F1Del2 == 0],actions=[SetCurrentPlayer(7),RunAIScriptAt("Set Unit Order To: Junk Yard Dog", 64),SetMemoryX(0x66370C, SetTo, 130*1,0xFF)])
		
		Trigger(conditions=[Memory(0x58F524,Exactly,2)],actions=[F1Del2.AddNumber(1)])
		Trigger(conditions=[Memory(0x58F524,Exactly,2),F1Del2>=24*3],actions=[F1Del2.SetNumber(0),SetMemory(0x58F524,SetTo,3),SetMemoryX(0x66370C, SetTo, 124*1,0xFF)])
		Trigger(conditions=[Memory(0x58F524,Exactly,3),Command(P8,Exactly,0,84)],actions=[SetMemory(0x58F524,SetTo,4),KillUnit(84,P8)])
	EUDEndIf()
	
	if EUDIf()((Memory(0x594000+4*1545,AtLeast,1),Memory(0x594000+4*1545,AtMost,4),Memory(0x58F524,Exactly,3))):
		Trigger(conditions=[Memory(0x594000+4*1545,Exactly,2)],actions=[SetMemoryX(0x66A054, SetTo, 17*0x01010100,0xFFFFFF00)])
		Trigger(conditions=[Memory(0x594000+4*1545,Exactly,1)],actions=[SetMemoryX(0x66A054, SetTo, 10*0x01010100,0xFFFFFF00)])
		Trigger(conditions=[Memory(0x594000+4*1545,Exactly,3)],actions=[SetMemoryX(0x66A054, SetTo, 6*0x01010100,0xFFFFFF00)])
		Trigger(conditions=[Memory(0x594000+4*1545,Exactly,4)],actions=[SetMemoryX(0x66A054, SetTo, 13*0x01010100,0xFFFFFF00)])

		if EUDIf()((Memory(0x594000+4*1545,Exactly,2))):
			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,0),
				MoveLocation("CLoc166", 87, P8, 64),
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			F1LocX << f_maskread_epd(EPD(0x58DC60+0x14*26),0xFFFF)
			F1LocY << f_maskread_epd(EPD(0x58DC64+0x14*26),0xFFFF0000)//65536
			if EUDWhile()((Del<2)):
				LocX << F1LocX - 32
				LocY << F1LocY - 64
				Num << 0
				if EUDWhile()((EUDOr(LocX<=0x7FFFFFFF,LocY<=0x7FFFFFFF),Num == 0)):
					Trigger(conditions=[LocX>=0x80000000],actions=[LocX.SetNumber(0)])
					Trigger(conditions=[LocY>=0x80000000],actions=[LocY.SetNumber(0)])
					DoActions([
						SetMemory(0x58DC60+0x14*26,SetTo,LocX),
						SetMemory(0x58DC64+0x14*26,SetTo,LocY),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),

							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					LocX << LocX - 32
					LocY << LocY - 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()

			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,0),
				MoveLocation("CLoc166", 87, P8, 64),
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			F1LocX << f_maskread_epd(EPD(0x58DC60+0x14*26),0xFFFF)
			F1LocY << f_maskread_epd(EPD(0x58DC64+0x14*26),0xFFFF0000)//65536
			if EUDWhile()((Del<2)):
				LocX << F1LocX + 32
				LocY << F1LocY - 64
				Num << 0
				if EUDWhile()((EUDOr(LocX<=3072,LocY<=0x7FFFFFFF),Num == 0)):
					Trigger(conditions=[LocX>=3072],actions=[LocX.SetNumber(3072)])
					Trigger(conditions=[LocY>=0x80000000],actions=[LocY.SetNumber(0)])
					DoActions([
						SetMemory(0x58DC68+0x14*26,SetTo,LocX),
						SetMemory(0x58DC64+0x14*26,SetTo,LocY),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					LocX << LocX + 32
					LocY << LocY - 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()

			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,0),
				MoveLocation("CLoc166", 87, P8, 64),
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			F1LocX << f_maskread_epd(EPD(0x58DC60+0x14*26),0xFFFF)
			F1LocY << f_maskread_epd(EPD(0x58DC64+0x14*26),0xFFFF0000)//65536
			if EUDWhile()((Del<2)):
				LocX << F1LocX - 32
				LocY << F1LocY + 64
				Num << 0
				if EUDWhile()((EUDOr(LocX<=0x7FFFFFFF,LocY<=6144),Num == 0)):
					Trigger(conditions=[LocX>=0x80000000],actions=[LocX.SetNumber(0)])
					Trigger(conditions=[LocY>=6144],actions=[LocY.SetNumber(6144)])
					DoActions([
						SetMemory(0x58DC60+0x14*26,SetTo,LocX),
						SetMemory(0x58DC6C+0x14*26,SetTo,LocY),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					LocX << LocX - 32
					LocY << LocY + 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()


			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,0),
				MoveLocation("CLoc166", 87, P8, 64),
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			F1LocX << f_maskread_epd(EPD(0x58DC60+0x14*26),0xFFFF)
			F1LocY << f_maskread_epd(EPD(0x58DC64+0x14*26),0xFFFF0000)//65536
			if EUDWhile()((Del<2)):
				LocX << F1LocX + 32
				LocY << F1LocY + 64
				Num << 0
				if EUDWhile()((EUDOr(LocX<=3072,LocY<=6144),Num == 0)):
					Trigger(conditions=[LocX>=3072],actions=[LocX.SetNumber(3072)])
					Trigger(conditions=[LocY>=6144],actions=[LocY.SetNumber(6144)])
					DoActions([
						SetMemory(0x58DC68+0x14*26,SetTo,LocX),
						SetMemory(0x58DC6C+0x14*26,SetTo,LocY),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					LocX << LocX + 32
					LocY << LocY + 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()
		EUDEndIf()


		if EUDIf()((Memory(0x594000+4*1545,Exactly,1))):
			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,6144),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<1)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<3072,Num == 0)):
					DoActions([
						SetMemory(0x58DC60+0x14*26,SetTo,Loc),
						SetMemory(0x58DC68+0x14*26,SetTo,Loc+32),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 32
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()

			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,6144),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<1)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<3072,Num == 0)):
					DoActions([
						SetMemory(0x58DC60+0x14*26,SetTo,3040-Loc),
						SetMemory(0x58DC68+0x14*26,SetTo,3072-Loc),
						RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 32
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()

			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,3072),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<1)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<6144,Num == 0)):
					DoActions([
						SetMemory(0x58DC64+0x14*26,SetTo,Loc),
						SetMemory(0x58DC6C+0x14*26,SetTo,Loc+64),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()

			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,3072),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<1)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<6144,Num == 0)):
					DoActions([
						SetMemory(0x58DC64+0x14*26,SetTo,6112-Loc),
						SetMemory(0x58DC6C+0x14*26,SetTo,6144-Loc),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()
		EUDEndIf()

		if EUDIf()((Memory(0x594000+4*1545,Exactly,3))):
			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,6144),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<2)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<3072,Num == 0)):
					DoActions([
						SetMemory(0x58DC60+0x14*26,SetTo,Loc),
						SetMemory(0x58DC68+0x14*26,SetTo,Loc+32),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 32
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()

			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*26,SetTo,0),
				SetMemory(0x58DC6C+0x14*26,SetTo,6144),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<2)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<3072,Num == 0)):
					DoActions([
						SetMemory(0x58DC60+0x14*26,SetTo,3040-Loc),
						SetMemory(0x58DC68+0x14*26,SetTo,3072-Loc),
						RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 32
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()
		EUDEndIf()

		if EUDIf()((Memory(0x594000+4*1545,Exactly,4))):
			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,3072),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<2)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<6144,Num == 0)):
					DoActions([
						SetMemory(0x58DC64+0x14*26,SetTo,Loc),
						SetMemory(0x58DC6C+0x14*26,SetTo,Loc+64),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()

			Del << 0
			DoActions([
				SetMemory(0x58DC60+0x14*25,SetTo,0),
				SetMemory(0x58DC68+0x14*25,SetTo,0),
				SetMemory(0x58DC64+0x14*25,SetTo,0),
				SetMemory(0x58DC6C+0x14*25,SetTo,0),
				SetMemory(0x58DC60+0x14*26,SetTo,0),
				SetMemory(0x58DC68+0x14*26,SetTo,3072),
				SetMemory(0x58DC60+0x14*27,SetTo,0),
				SetMemory(0x58DC68+0x14*27,SetTo,64),
				SetMemory(0x58DC64+0x14*27,SetTo,0),
				SetMemory(0x58DC6C+0x14*27,SetTo,64),
			])
			if EUDWhile()((Del<2)):
				Loc << 0
				Num << 0
				if EUDWhile()((Loc<6144,Num == 0)):
					DoActions([
						SetMemory(0x58DC64+0x14*26,SetTo,6112-Loc),
						SetMemory(0x58DC6C+0x14*26,SetTo,6144-Loc),
							RemoveUnitAt(1,47,"CLoc166",P8),
					])
					Trigger(conditions=[Bring(P8, AtLeast, 1, 84, "CLoc166")],
						actions=[Num.SetNumber(1),
							MoveLocation("CLoc169", 84, P8, "CLoc166"),MoveLocation("CLoc165", 84, P8, "CLoc166"),
							GiveUnits(1,84,P8,"CLoc165",P12),
							RemoveUnit(84,P12),
							SetMemoryX(0x669E28, SetTo, 3,0xFF),CreateUnitWithProperties(1, 47, "Start", P8, UnitProperty(hallucinated=True,invincible = True)),SetMemoryX(0x669E28, SetTo, 0,0xFF),
							MoveUnit(All, 47, P8, "Start", "CLoc169"),
							KillUnit(47, P8),
							])
					Loc << Loc + 64
				EUDEndWhile()
				Del << Del + 1
			EUDEndWhile()
		EUDEndIf()
		VResetSw << 0

	if EUDElseIf()(VResetSw == 0):

		F2BSH << 0
		Del2 << 0
		Loc2 << 0
		Num2 << 0
		F1Del2 << 0
		Seed2 << 0
		CunitX2 << 0
		CunitX219 << 0
		CunitX225 << 0
		Del << 0
		Loc << 0
		Num << 0
		F1Del << 0
		Seed << 0
		CunitX << 0
		CunitX19 << 0
		CunitX25 << 0
		F1LocX << 0
		F1LocY << 0
		LocX << 0
		LocY << 0
		F2BHP << 0
		F2BSH << 0
		F2BDX << 0
		F2BDT << 0
		F2BDY << 0
		F2BDH << 0
		F2BRT << 0
		F2BRU << 0
		F2BRS << 0
		F2BRV << 0
		F2BSD << 0
		F2XT1 << 0
		F2XT2 << 0
		F2XT3 << 0
		
		F2B << 0
		DoActions([SetMemory(0x58F518,SetTo,0),
			SetMemory(0x58F51c,SetTo,0),
			SetMemory(0x58F520,SetTo,0),
			SetMemory(0x58F524,SetTo,0)])

		VResetSw << 1
		
	EUDEndIf()
