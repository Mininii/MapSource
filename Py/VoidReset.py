from eudplib import *
import math
import customText as ct

def onPluginStart():
	VoidResetPtr = EUDVariable(EPD(0x58F44A))
	if EUDWhile()(VoidResetPtr <= EPD(0x5967E8)):
		DoActions([SetDeaths(VoidResetPtr,SetTo,0,0),VoidResetPtr.AddNumber(1)])
	EUDEndWhile()