from eudplib import *
import math
import customText as ct



GunPtrMemory = Db(1700*4) # 0x58f532
P1PU = EUDVariable(100)
P2PU = EUDVariable(100)
P3PU = EUDVariable(100)
P4PU = EUDVariable(100)
P5PU = EUDVariable(100)
P1PA = EUDVariable(100)
P2PA = EUDVariable(100)
P3PA = EUDVariable(100)
P4PA = EUDVariable(100)
P5PA = EUDVariable(100)
def onPluginStart():

	DoActions([
		SetMemory(0x590300, SetTo, GunPtrMemory),
		SetMemory(0x590304, SetTo, P1PU.getValueAddr()),
		SetMemory(0x590308, SetTo, P2PU.getValueAddr()),
		SetMemory(0x59030C, SetTo, P3PU.getValueAddr()),
		SetMemory(0x590310, SetTo, P4PU.getValueAddr()),
		SetMemory(0x590314, SetTo, P5PU.getValueAddr()),
		SetMemory(0x590318, SetTo, P1PA.getValueAddr()),
		SetMemory(0x59031C, SetTo, P2PA.getValueAddr()),
		SetMemory(0x590320, SetTo, P3PA.getValueAddr()),
		SetMemory(0x590324, SetTo, P4PA.getValueAddr()),
		SetMemory(0x590328, SetTo, P5PA.getValueAddr()),

		])
def afterTriggerExec():
	f_chatprintAll(10, "\x08P1 \x04: \x06",P1PU,"% \x1C",P1PA,"% \x0EP2 \x04: \x06",P2PU,"% \x1C",P2PA,"% ")