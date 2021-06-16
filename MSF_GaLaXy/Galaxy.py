from eudplib import *
from eudx import *
import math


def CreateBullet(UnitId,Height,Angle,X,Y): # Loc = 180

	Nextptrs = EUDVariable()
	Locs = EUDVariable()

	Nextptrs << f_maskread_epd(EPD(0x628438), 0xFFFFFF)

	if EUDIf()((Nextptrs >= 1)):

		DoActions(SetMemoryX(0x66321C, SetTo, Height,0xFF))

		DoActions([SetMemory(0x58DC60 + 0x14*247,SetTo,X),
				SetMemory(0x58DC68 + 0x14*247,SetTo,X),
				SetMemory(0x58DC64 + 0x14*247,SetTo,Y+10),
				SetMemory(0x58DC6C + 0x14*247,SetTo,Y+10),
				CreateUnit(1, 204,"BulletLoc", P6)])

		if EUDIf()((UnitId != 204)):
			DoActions(SetMemory(Nextptrs+0x64,SetTo,UnitId))
		EUDEndIf()

		Locs << f_maskread_epd(EPD(Nextptrs+0x28), 0xFFFFFFFF)

		DoActions([
			SetMemoryX(Nextptrs+0x58,SetTo,Locs,0xFFFFFFFF),
			SetMemoryX(Nextptrs+0x21,SetTo,Angle*256,0xFF00),
			SetMemoryX(Nextptrs+0x4D,SetTo,135*256,0xFF00)])

	EUDEndIf()


def CreateBulletLoc(PlayerId,UnitId,Height,Angle,LocId): # Loc = 0

	Nextptrs = EUDVariable()
	Locs = EUDVariable()

	Nextptrs << f_maskread_epd(EPD(0x628438), 0xFFFFFF)

	if EUDIf()((Nextptrs >= 1)):

		DoActions(SetMemoryX(0x66321C, SetTo, Height,0xFF))

		DoActions([CreateUnit(1, 204, LocId, PlayerId)])

		if EUDIf()((UnitId != 204)):
			DoActions(SetMemory(Nextptrs+0x64,SetTo,UnitId))
		EUDEndIf()

		Locs << f_maskread_epd(EPD(Nextptrs+0x28), 0xFFFFFFFF)

		DoActions([
			SetMemoryX(Nextptrs+0x58,SetTo,Locs,0xFFFFFFFF),
			SetMemoryX(Nextptrs+0x21,SetTo,Angle*256,0xFF00),
			SetMemoryX(Nextptrs+0x4D,SetTo,135*256,0xFF00)])

	EUDEndIf()

def AngleRandom(SwitchId):
	Angle = EUDVariable()
	Angle << 0
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(1)])
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(2)])
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(4)])
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(8)])
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(16)])
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(32)])
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(64)])
	DoActions(SetSwitch(SwitchId,Random))
	Trigger(conditions=[Switch(SwitchId,Set)],actions=[Angle.AddNumber(128)])
	return Angle

def Damage(EPD,Amount,UnitId):
	DPlayerId = EUDVariable()
	if EUDIf()((Deaths(EPD+25,Exactly,UnitId,0))): # Unit id
		if EUDIf()((Deaths(EPD+2,AtLeast,Amount,0))):
			DoActions(SetDeaths(EPD+2,Subtract,Amount,0))
		if EUDElse()():
			DPlayerId << f_maskread_epd(EPD+19,0xF)
			DoActions([SetDeathsX(EPD+19,SetTo,0,0,0xFF00),SetDeaths(DPlayerId,Add,1,UnitId)])
		EUDEndIf()
	EUDEndIf()
def beforeTriggerExec(): # Velocity = V/10sec : V px per 10 second
	Trigger(conditions=[ElapsedTime(AtLeast,10)],actions=[RemoveUnit(204,P6),RemoveUnit(50,P6),RemoveUnit(191,P6)])
	AngleR = EUDVariable()
	Angle1 = EUDVariable()
	Angle2 = EUDVariable()
	Angle3 = EUDVariable()
	Angle4 = EUDVariable()
	Angle5 = EUDVariable()
	Angle6 = EUDVariable()
	Angle7 = EUDVariable()
	Angle8 = EUDVariable()
	Loop = EUDVariable()
	B1H = EUDVariable()
	B2H = EUDVariable()
	B3H = EUDVariable()
	B4H = EUDVariable()
	B5H = EUDVariable()
	Uid = EUDVariable()
	N_A, N_R, N_X, N_Y = EUDCreateVariables(4)
	Speed = EUDVariable()
	Cunit2 = EUDVariable()
	Δx, Δy, Δt, Δv, Δu = EUDCreateVariables(5)
	Player1_S, Player1_T, Player1_58, Player1_5C, Player1_4D, Player1_C, Player1_18, Player1_TEPD, Player1_SEPD = EUDCreateVariables(9)
	Player2_S, Player2_T, Player2_58, Player2_5C, Player2_4D, Player2_C, Player2_18, Player2_TEPD, Player2_SEPD = EUDCreateVariables(9)
	Player3_S, Player3_T, Player3_58, Player3_5C, Player3_4D, Player3_C, Player3_18, Player3_TEPD, Player3_SEPD = EUDCreateVariables(9)
	Player4_S, Player4_T, Player4_58, Player4_5C, Player4_4D, Player4_C, Player4_18, Player4_TEPD, Player4_SEPD = EUDCreateVariables(9)
	Player5_S, Player5_T, Player5_58, Player5_5C, Player5_4D, Player5_C, Player5_18, Player5_TEPD, Player5_SEPD = EUDCreateVariables(9)


	if EUDIf()((ElapsedTime(AtLeast,3))):

		if EUDIf()((Switch("Switch 213",Set))):
			DoActions(Loop.SetNumber(19025))
			if EUDWhile()(Loop <= 19025 + (84*1699)):
				if EUDIf()(DeathsX(Loop+19,AtLeast,5,0,0xFF)): # Player Id
					if EUDIf()(Deaths(Loop+3,AtLeast,1,0)):
						Uid << f_maskread_epd(Loop+25,0xFFFFFF)
						DoActions(SetDeaths(Loop+2,SetTo,f_maskread_epd(221179+Uid,0xFFFFFFFF),0))
					EUDEndIf()
					if EUDIf()((Deaths(Loop+25,Exactly,174,0))):
						B1H << Loop+2
						DoActions([SetMemory(0x58F500, SetTo, B1H),
							SetDeaths(Loop+2,SetTo,8000000*256,0)])
					EUDEndIf()
					if EUDIf()((Deaths(Loop+25,Exactly,5,0))):
						if EUDIf()((Memory(0x58F518,Exactly,1))):
							DoActions([SetDeaths(Loop+13,SetTo,20000,0),SetDeathsX(Loop+18,SetTo,4000,0,0xFFFF),SetDeathsX(Loop+9,SetTo,0,0,0xFF000000),SetDeathsX(Loop+8,SetTo,40*65536,0,0xFF0000)])
						EUDEndIf()
						B2H << Loop+2
						DoActions([SetMemory(0x58F5F4, SetTo, B2H),
							SetDeaths(Loop+2,SetTo,8000000*256,0)])
					EUDEndIf()

					if EUDIf()((Deaths(Loop+25,Exactly,46,0))):
						if EUDIf()((Memory(0x58F518,Exactly,1))):
							DoActions([SetDeaths(Loop+13,SetTo,20000,0),SetDeathsX(Loop+18,SetTo,4000,0,0xFFFF),SetDeathsX(Loop+9,SetTo,0,0,0xFF000000),SetDeathsX(Loop+8,SetTo,40*65536,0,0xFF0000)])
						EUDEndIf()
					EUDEndIf()
					if EUDIf()((Deaths(Loop+25,Exactly,45,0))):
						if EUDIf()((Memory(0x58F518,Exactly,1))):
							DoActions([SetDeaths(Loop+13,SetTo,20000,0),SetDeathsX(Loop+18,SetTo,4000,0,0xFFFF),SetDeathsX(Loop+9,SetTo,0,0,0xFF000000),SetDeathsX(Loop+8,SetTo,40*65536,0,0xFF0000)])
						EUDEndIf()
					EUDEndIf()
					if EUDIf()((Deaths(Loop+25,Exactly,11,0))):

						if EUDIf()((Memory(0x58F518,Exactly,1))):
							DoActions([SetDeaths(Loop+13,SetTo,20000,0),SetDeathsX(Loop+18,SetTo,4000,0,0xFFFF),SetDeathsX(Loop+8,SetTo,127*65536,0,0xFF0000)])
						EUDEndIf()
						B3H << Loop+2
						DoActions([SetMemory(0x58F5F0, SetTo, B3H),
							SetDeaths(Loop+2,SetTo,8000000*256,0)])
					EUDEndIf()
					if EUDIf()((Deaths(Loop+25,Exactly,82,0))):
						B4H << Loop+2
						DoActions([SetMemory(0x58F508, SetTo, B4H),
							SetDeaths(Loop+2,SetTo,8000000*256,0)])
					EUDEndIf()
					if EUDIf()((Deaths(Loop+25,Exactly,186,0))):
						B5H << Loop+2
						DoActions([SetMemory(0x58F510, SetTo, B5H),
							SetDeaths(Loop+2,SetTo,8000000*256,0)])
					EUDEndIf()
					if EUDIf()((Deaths(Loop+25,AtLeast,176,0),Deaths(Loop+25,AtMost,178,0))):
						DoActions([SetDeaths(Loop+2,SetTo,10000*256,0)])
					EUDEndIf()
				EUDEndIf()
				DoActions(Loop.AddNumber(84))
			EUDEndWhile()
			DoActions([SetSwitch("Switch 213",Clear),SetSwitch("Switch 214",Set)])
		EUDEndIf()
		if EUDIf()((f_playerexist(0) == 1)):
			Cunit2 << f_maskread_epd(EPD(0x6284E8),0xFFFFFFFF)
			Trigger(conditions=[Command(0,AtMost,0,215),Command(AllPlayers,AtLeast,1,215)],actions=[GiveUnits(All,215,AllPlayers,"Anywhere",0)],preserved = False)
		EUDEndIf()
		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 1)):
			Cunit2 << f_maskread_epd(EPD(0x628518),0xFFFFFFFF)
			Trigger(conditions=[Command(1,AtMost,0,215),Command(AllPlayers,AtLeast,1,215)],actions=[GiveUnits(All,215,AllPlayers,"Anywhere",1)],preserved = False)
		EUDEndIf()
		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 1)):
			Cunit2 << f_maskread_epd(EPD(0x628548),0xFFFFFFFF)
			Trigger(conditions=[Command(2,AtMost,0,215),Command(AllPlayers,AtLeast,1,215)],actions=[GiveUnits(All,215,AllPlayers,"Anywhere",2)],preserved = False)
		EUDEndIf()
		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 1)):
			Cunit2 << f_maskread_epd(EPD(0x628578),0xFFFFFFFF)
			Trigger(conditions=[Command(3,AtMost,0,215),Command(AllPlayers,AtLeast,1,215)],actions=[GiveUnits(All,215,AllPlayers,"Anywhere",3)],preserved = False)
		EUDEndIf()
		if EUDIf()((f_playerexist(0) == 0,f_playerexist(1) == 0,f_playerexist(2) == 0,f_playerexist(3) == 0,f_playerexist(4) == 1)):
			Cunit2 << f_maskread_epd(EPD(0x6285A8),0xFFFFFFFF)
			Trigger(conditions=[Command(4,AtMost,0,215),Command(AllPlayers,AtLeast,1,215)],actions=[GiveUnits(All,215,AllPlayers,"Anywhere",4)],preserved = False)
		EUDEndIf()
		if EUDIf()((Cunit2 != 0)):
			if EUDIf()(Memory(Cunit2+0x64,Exactly,215)):
				Speed << f_maskread_epd(EPD(0x5124F0),0xFF)
				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,320,0xFFFF),MemoryX(Cunit2+0x28,AtMost,352,0xFFFF),Speed != 0x4)):
					DoActions([SetMemory(0x58F4F0,SetTo,10),SetMemory(0x5124F0,SetTo,0x4)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,288,0xFFFF),MemoryX(Cunit2+0x28,AtMost,320,0xFFFF),Speed != 0x8)):
					DoActions([SetMemory(0x58F4F0,SetTo,9),SetMemory(0x5124F0,SetTo,0x8)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,256,0xFFFF),MemoryX(Cunit2+0x28,AtMost,288,0xFFFF),Speed != 0xC)):
					DoActions([SetMemory(0x58F4F0,SetTo,8),SetMemory(0x5124F0,SetTo,0xC)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,224,0xFFFF),MemoryX(Cunit2+0x28,AtMost,256,0xFFFF),Speed != 0x11)):
					DoActions([SetMemory(0x58F4F0,SetTo,7),SetMemory(0x5124F0,SetTo,0x11)])
				EUDEndIf()
				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,192,0xFFFF),MemoryX(Cunit2+0x28,AtMost,224,0xFFFF),Speed != 0x15)):
					DoActions([SetMemory(0x58F4F0,SetTo,6),SetMemory(0x5124F0,SetTo,0x15)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,160,0xFFFF),MemoryX(Cunit2+0x28,AtMost,192,0xFFFF),Speed != 0x19)):
					DoActions([SetMemory(0x58F4F0,SetTo,5),SetMemory(0x5124F0,SetTo,0x19)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,128,0xFFFF),MemoryX(Cunit2+0x28,AtMost,160,0xFFFF),Speed != 0x1D)):
					DoActions([SetMemory(0x58F4F0,SetTo,4),SetMemory(0x5124F0,SetTo,0x1D)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,96,0xFFFF),MemoryX(Cunit2+0x28,AtMost,128,0xFFFF),Speed != 0x20)):
					DoActions([SetMemory(0x58F4F0,SetTo,3),SetMemory(0x5124F0,SetTo,0x20)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,64,0xFFFF),MemoryX(Cunit2+0x28,AtMost,96,0xFFFF),Speed != 0x24)):
					DoActions([SetMemory(0x58F4F0,SetTo,2),SetMemory(0x5124F0,SetTo,0x24)])
				EUDEndIf()

				if EUDIf()((MemoryX(Cunit2+0x28,AtLeast,32,0xFFFF),MemoryX(Cunit2+0x28,AtMost,64,0xFFFF),Speed != 0x2A)):
					DoActions([SetMemory(0x58F4F0,SetTo,1),SetMemory(0x5124F0,SetTo,0x2A)])
				EUDEndIf()
			EUDEndIf()
		EUDEndIf()
		Δx = f_maskread_epd(EPD(0x51CE8C),0xFFFFFFFF)
		Δy << 0xFFFFFFFF - Δx
		Δt << Δy - Δu
		Δv << Δt
		Δu << Δy
		DoActions([
			SetDeathsX(0,Subtract,Δt,440,0xFFFFFF),
			SetDeathsX(1,Subtract,Δt,440,0xFFFFFF),
			SetDeathsX(2,Subtract,Δt,440,0xFFFFFF),
			SetDeathsX(3,Subtract,Δt,440,0xFFFFFF),
			SetDeathsX(4,Subtract,Δt,440,0xFFFFFF),
			SetMemory(0x58F494,Subtract,Δt),
			])
		#DoActions(Loop.SetNumber(19025))
		#if EUDWhile()(Loop <= 19025 + (84*1699)):
		#	Loop_19 = Loop+19
		#	Loop_25 = Loop+25
		#	EUDEndIf()
		#	if EUDIf()((Memory(0x58F518,Exactly,1))):
		#		if EUDIf()(DeathsX(Loop_19,AtLeast,5,0,0xFF)):
		#			if EUDIf()((DeathsX(Loop_19,AtLeast,1*256,0,0xFF00))):
		#				if EUDIf()((Deaths(Loop+13,AtMost,19999,0),EUDOr(Deaths(Loop_25,Exactly,67,0),Deaths(Loop_25,Exactly,88,0),Deaths(Loop_25,Exactly,80,0),Deaths(Loop_25,Exactly,63,0)))):
		#					DoActions([SetDeaths(Loop+13,SetTo,20000,0),SetDeathsX(Loop+18,SetTo,4000,0,0xFFFF),SetDeathsX(Loop+8,SetTo,40*65536,0,0xFF0000)])
		#				EUDEndIf()
		#			EUDEndIf()
		#		EUDEndIf()

		#	#if EUDIf()((Switch("Switch 211",Set))):
		#	#	if EUDIf()((DeathsX(Loop_19,Exactly,0,0,0xFF00),Deaths(Loop_25,Exactly,186,0))):
		#	#		DoActions([SetDeathsX(Loop_19,SetTo,1*256,0,0xFF00),SetDeaths(Loop+2,SetTo,7000000*256,0)])
		#	#	EUDEndIf()
		#	#EUDEndIf()

		#	
		#	if EUDIf()(DeathsX(Loop_19,AtMost,4,0,0xFF)):

		#		Loop_10 = Loop+10
		#		Loop_55 = Loop+55
		#		Loop_70 = Loop+70
		#		if EUDIf()((DeathsX(Loop_19,AtLeast,1*256,0,0xFF00))):
		#			for i in range (5):
		#				if EUDIf()(Deaths(i,AtLeast,1,71)):
		#					if EUDIf()((DeathsX(Loop_19,Exactly,i,0,0xFF),EUDOr(DeathsX(Loop_25,Exactly,20,0,0xFF),DeathsX(Loop_25,Exactly,100,0,0xFF),DeathsX(Loop_25,Exactly,7,0,0xFF),DeathsX(Loop_25,Exactly,0,0,0xFF)))):
		#						DoActions([SetDeathsX(Loop+69,SetTo,255*256,0,0xFF00)])
		#					EUDEndIf()
		#				EUDEndIf()
		#			if EUDIf()(Deaths(Loop_25,Exactly,100,0)):
		#				if EUDIf()((Switch("Switch 221",Set))): # Player Id
		#					if EUDIf()((DeathsX(Loop_19,Exactly,0,0,0xFF))):
		#						DoActions([SetDeaths(Loop+2,SetTo,f_maskread_epd(221179+f_maskread_epd(Loop_25,0xFFFFFF),0xFFFFFFFF),0)])
		#					EUDEndIf()
		#				EUDEndIf()
		#				if EUDIf()(Switch("Switch 222",Set)): # Player Id
		#					if EUDIf()((DeathsX(Loop_19,Exactly,1,0,0xFF))):
		#						DoActions([SetDeaths(Loop+2,SetTo,f_maskread_epd(221179+f_maskread_epd(Loop_25,0xFFFFFF),0xFFFFFFFF),0)])
		#					EUDEndIf()
		#				EUDEndIf()
		#				if EUDIf()(Switch("Switch 223",Set)): # Player Id
		#					if EUDIf()((DeathsX(Loop_19,Exactly,2,0,0xFF))):
		#						DoActions([SetDeaths(Loop+2,SetTo,f_maskread_epd(221179+f_maskread_epd(Loop_25,0xFFFFFF),0xFFFFFFFF),0)])
		#					EUDEndIf()
		#				EUDEndIf()
		#				if EUDIf()(Switch("Switch 224",Set)): # Player Id
		#					if EUDIf()((DeathsX(Loop_19,Exactly,3,0,0xFF))):
		#						DoActions([SetDeaths(Loop+2,SetTo,f_maskread_epd(221179+f_maskread_epd(Loop_25,0xFFFFFF),0xFFFFFFFF),0)])
		#					EUDEndIf()
		#				EUDEndIf()
		#				if EUDIf()(Switch("Switch 225",Set)): # Player Id
		#					if EUDIf()((DeathsX(Loop_19,Exactly,4,0,0xFF))):
		#						DoActions([SetDeaths(Loop+2,SetTo,f_maskread_epd(221179+f_maskread_epd(Loop_25,0xFFFFFF),0xFFFFFFFF),0)])
		#					EUDEndIf()
		#				EUDEndIf()
		#				if EUDIf()(Switch("Switch 226",Set)): 
		#					if EUDIf()((DeathsX(Loop_10,AtLeast,96,0,0xFFFF),DeathsX(Loop_10,AtLeast,160*65536,0,0xFFFF0000),DeathsX(Loop_10,AtMost,352,0,0xFFFF),DeathsX(Loop_10,AtMost,352*65536,0,0xFFFF0000))): # Player Id
		#						DoActions([SetDeaths(Loop+2,SetTo,f_maskread_epd(221179+f_maskread_epd(Loop_25,0xFFFFFF),0xFFFFFFFF),0)])
		#					EUDEndIf()
		#				EUDEndIf()
		#			EUDEndIf()
		#			
		#			
		#			if EUDIf()((DeathsX(Loop_10,AtMost,352,0,0xFFFF),DeathsX(Loop_10,AtMost,352*65536,0,0xFFFF0000))):
		#				if EUDIf()((Deaths(Loop_25,AtMost,100,0),DeathsX(Loop_10,AtLeast,96,0,0xFFFF),DeathsX(Loop_10,AtLeast,160*65536,0,0xFFFF0000),DeathsX(Loop_55,Exactly,0x000000,0,0xA00000))):
		#					if EUDIf()((Deaths(P1,Exactly,1,"Eff2"))):
		#						if EUDIf()(DeathsX(Loop_19,Exactly,0,0,0xFF)):
		#							DoActions(SetDeathsX(Loop_55,SetTo,0xA00000,0,0xA00000))
		#						EUDEndIf()
		#					EUDEndIf()
		#					if EUDIf()((Deaths(P2,Exactly,1,"Eff2"))):
		#						if EUDIf()(DeathsX(Loop_19,Exactly,1,0,0xFF)):
		#							DoActions(SetDeathsX(Loop_55,SetTo,0xA00000,0,0xA00000))
		#						EUDEndIf()
		#					EUDEndIf()
		#					if EUDIf()((Deaths(P3,Exactly,1,"Eff2"))):
		#						if EUDIf()(DeathsX(Loop_19,Exactly,2,0,0xFF)):
		#							DoActions(SetDeathsX(Loop_55,SetTo,0xA00000,0,0xA00000))
		#						EUDEndIf()
		#					EUDEndIf()
		#					if EUDIf()((Deaths(P4,Exactly,1,"Eff2"))):
		#						if EUDIf()(DeathsX(Loop_19,Exactly,3,0,0xFF)):
		#							DoActions(SetDeathsX(Loop_55,SetTo,0xA00000,0,0xA00000))
		#						EUDEndIf()
		#					EUDEndIf()
		#					if EUDIf()((Deaths(P5,Exactly,1,"Eff2"))):
		#						if EUDIf()(DeathsX(Loop_19,Exactly,4,0,0xFF)):
		#							DoActions(SetDeathsX(Loop_55,SetTo,0xA00000,0,0xA00000))
		#						EUDEndIf()
		#					EUDEndIf()
		#				EUDEndIf()
		#			EUDEndIf()
		#			if EUDIf()(Switch("Switch 227",Cleared)):
		#				if EUDIf()(DeathsX(Loop_55,Exactly,0xA00000,0,0xA00000)):
		#					if EUDIf()(EUDOr(DeathsX(Loop_10,AtMost,95,0,0xFFFF),DeathsX(Loop_10,AtMost,159*65536,0,0xFFFF0000),DeathsX(Loop_10,AtLeast,353,0,0xFFFF),DeathsX(Loop_10,AtLeast,353*65536,0,0xFFFF0000))):
		#						DoActions([SetDeathsX(Loop_55,SetTo,0x000000,0,0xA00000)])
		#						if EUDIf()(EUDNot(DeathsX(Loop_25,Exactly,7,0,0xFF))):
		#							DoActions(SetDeathsX(Loop_19,SetTo,1*256,0,0xFF00))
		#						EUDEndIf()
		#					EUDEndIf()
		#				EUDEndIf()
		#			EUDEndIf()


		#			if EUDIf()(DeathsX(Loop_55,Exactly,0xA00000,0,0xA00000)):

		#				if EUDIf()(Deaths(P1,Exactly,1,"Eff1")): 
		#					if EUDIf()((DeathsX(Loop_19,Exactly,0,0,0xFF))):
		#						DoActions([SetDeathsX(Loop_55,SetTo,0x000000,0,0xA00000)])
		#					EUDEndIf()
		#				EUDEndIf()					
		#				if EUDIf()(Deaths(P2,Exactly,1,"Eff1")): 
		#					if EUDIf()((DeathsX(Loop_19,Exactly,1,0,0xFF))):
		#						DoActions([SetDeathsX(Loop_55,SetTo,0x000000,0,0xA00000)])
		#					EUDEndIf()
		#				EUDEndIf()					
		#				if EUDIf()(Deaths(P3,Exactly,1,"Eff1")): 
		#					if EUDIf()((DeathsX(Loop_19,Exactly,2,0,0xFF))):
		#						DoActions([SetDeathsX(Loop_55,SetTo,0x000000,0,0xA00000)])
		#					EUDEndIf()
		#				EUDEndIf()					
		#				if EUDIf()(Deaths(P4,Exactly,1,"Eff1")): 
		#					if EUDIf()((DeathsX(Loop_19,Exactly,3,0,0xFF))):
		#						DoActions([SetDeathsX(Loop_55,SetTo,0x000000,0,0xA00000)])
		#					EUDEndIf()
		#				EUDEndIf()					
		#				if EUDIf()(Deaths(P5,Exactly,1,"Eff1")): 
		#					if EUDIf()((DeathsX(Loop_19,Exactly,4,0,0xFF))):
		#						DoActions([SetDeathsX(Loop_55,SetTo,0x000000,0,0xA00000)])
		#					EUDEndIf()
		#				EUDEndIf()
		#			EUDEndIf()

		#			
		#			if EUDIf()(DeathsX(Loop_70,AtLeast,10*65536,0,0xFF0000)): # Plague check
		#				DoActions(SetDeathsX(Loop_70,SetTo,5*65536,0,0xFF0000)) # Set Plague Timer
		#			EUDEndIf()
		#			if EUDIf()(DeathsX(Loop_70,AtLeast,1*65536,0,0xFF0000)): # Plague check
		#				DoActions(SetDeathsX(Loop+69,SetTo,0,0,0xFF00)) # SetTo 0 Stim timer
		#				Damage(Loop,5000*256,f_maskread_epd(Loop_25,0xFFFFFFFF))
		#			EUDEndIf()
		#			if EUDIf()((Switch("Switch 13",Set))):
		#				if EUDIf()((EUDOr(Deaths(Loop_25,Exactly,0,0),Deaths(Loop_25,Exactly,20,0),Deaths(Loop_25,Exactly,100,0) ) )): # Player Id

		#					DoActions([SetDeathsX(Loop_55,SetTo,0xA00000,0,0xA00000)])

		#					Trigger(									
		#						conditions=[
		#							DeathsX(Loop+8,Exactly,0x12,0,0xFF),
		#							Deaths(Loop+14,Exactly,0,0),
		#							Deaths(Loop+15,Exactly,0,0),
		#							Deaths(Loop+16,Exactly,0,0),
		#						],
		#						actions=[
		#							SetDeathsX(Loop+8,SetTo,0x0,0,0xFF),
		#						])
		#				EUDEndIf()
		#			EUDEndIf()	
		#		EUDEndIf()
		#		if EUDIf()((DeathsX(Loop_19,Exactly,0,0,0xFF00),DeathsX(Loop_70,AtLeast,1*65536,0,0xFF0000))): # Order check
		#			DoActions(SetDeathsX(Loop_70,SetTo,0*65536,0,0xFF0000)) # Set Plague Timer
		#		EUDEndIf()
		#	EUDEndIf()
		#	DoActions(Loop.AddNumber(84))
		#EUDEndWhile()

		if EUDIf()((Switch("Switch 12",Set))):

			Player1_S << f_maskread_epd(EPD(0x6284E8),0xFFFFFF)

			if EUDIf()((Player1_S != 0)):

				Player1_SEPD << EPD(Player1_S)

				Player1_4D << f_maskread_epd(Player1_SEPD+0x4D//4,0xFF00)
				Player1_18 << f_maskread_epd(Player1_SEPD+0x18//4,0xFFFFFFFF)
				Player1_58 << f_maskread_epd(Player1_SEPD+0x58//4,0xFFFFFFFF)
				Player1_5C << f_maskread_epd(Player1_SEPD+0x5C//4,0xFFFFFFFF)

				Player1_C << 1

				if EUDIf()((Player1_4D != 0)):

					if EUDWhile()((Player1_C <= 11)):

						if EUDIf()((Deaths(EPD(0x6284E8)+Player1_C,AtLeast,1,0))):

							Player1_T << f_maskread_epd(EPD(0x6284E8)+Player1_C,0xFFFFFF)

							Player1_TEPD << EPD(Player1_T)

							if EUDIf()((Deaths(Player1_TEPD+0x8//4,AtLeast,256,0),DeathsX(Player1_TEPD+0x4D//4,AtLeast,1*256,0,0xFF00))):

								DoActions([SetDeathsX(Player1_TEPD+0x4D//4,SetTo,Player1_4D,0,0xFF00),SetDeaths(Player1_TEPD+0x18//4,SetTo,Player1_18,0),SetDeaths(Player1_TEPD+0x58//4,SetTo,Player1_58,0),SetDeaths(Player1_TEPD+0x5C//4,SetTo,Player1_5C,0)])

							EUDEndIf()

						EUDEndIf()

						Player1_C << Player1_C + 1

					EUDEndWhile()

				EUDEndIf()

			EUDEndIf()

			Player2_S << f_maskread_epd(EPD(0x628518),0xFFFFFF)

			if EUDIf()((Player2_S != 0)):

				Player2_SEPD << EPD(Player2_S)

				Player2_4D << f_maskread_epd(Player2_SEPD+0x4D//4,0xFF00)
				Player2_18 << f_maskread_epd(Player2_SEPD+0x18//4,0xFFFFFFFF)
				Player2_58 << f_maskread_epd(Player2_SEPD+0x58//4,0xFFFFFFFF)
				Player2_5C << f_maskread_epd(Player2_SEPD+0x5C//4,0xFFFFFFFF)

				Player2_C << 1

				if EUDIf()((Player2_4D != 0)):

					if EUDWhile()((Player2_C <= 11)):

						if EUDIf()((Deaths(EPD(0x628518)+Player2_C,AtLeast,1,0))):

							Player2_T << f_maskread_epd(EPD(0x628518)+Player2_C,0xFFFFFF)

							Player2_TEPD << EPD(Player2_T)

							if EUDIf()((Deaths(Player2_TEPD+0x8//4,AtLeast,256,0),DeathsX(Player2_TEPD+0x4D//4,AtLeast,1*256,0,0xFF00))):

								DoActions([SetDeathsX(Player2_TEPD+0x4D//4,SetTo,Player2_4D,0,0xFF00),SetDeaths(Player2_TEPD+0x18//4,SetTo,Player2_18,0),SetDeaths(Player2_TEPD+0x58//4,SetTo,Player2_58,0),SetDeaths(Player2_TEPD+0x5C//4,SetTo,Player2_5C,0)])

							EUDEndIf()

						EUDEndIf()

						Player2_C << Player2_C + 1

					EUDEndWhile()

				EUDEndIf()

			EUDEndIf()

			Player3_S << f_maskread_epd(EPD(0x628548),0xFFFFFF)

			if EUDIf()((Player3_S != 0)):

				Player3_SEPD << EPD(Player3_S)

				Player3_4D << f_maskread_epd(Player3_SEPD+0x4D//4,0xFF00)
				Player3_18 << f_maskread_epd(Player3_SEPD+0x18//4,0xFFFFFFFF)
				Player3_58 << f_maskread_epd(Player3_SEPD+0x58//4,0xFFFFFFFF)
				Player3_5C << f_maskread_epd(Player3_SEPD+0x5C//4,0xFFFFFFFF)

				Player3_C << 1

				if EUDIf()((Player3_4D != 0)):

					if EUDWhile()((Player3_C <= 11)):

						if EUDIf()((Deaths(EPD(0x628548)+Player3_C,AtLeast,1,0))):

							Player3_T << f_maskread_epd(EPD(0x628548)+Player3_C,0xFFFFFF)

							Player3_TEPD << EPD(Player3_T)

							if EUDIf()((Deaths(Player3_TEPD+0x8//4,AtLeast,256,0),DeathsX(Player3_TEPD+0x4D//4,AtLeast,1*256,0,0xFF00))):

								DoActions([SetDeathsX(Player3_TEPD+0x4D//4,SetTo,Player3_4D,0,0xFF00),SetDeaths(Player3_TEPD+0x18//4,SetTo,Player3_18,0),SetDeaths(Player3_TEPD+0x58//4,SetTo,Player3_58,0),SetDeaths(Player3_TEPD+0x5C//4,SetTo,Player3_5C,0)])

							EUDEndIf()

						EUDEndIf()

						Player3_C << Player3_C + 1

					EUDEndWhile()

				EUDEndIf()

			EUDEndIf()

			Player4_S << f_maskread_epd(EPD(0x628578),0xFFFFFF)

			if EUDIf()((Player4_S != 0)):

				Player4_SEPD << EPD(Player4_S)

				Player4_4D << f_maskread_epd(Player4_SEPD+0x4D//4,0xFF00)
				Player4_18 << f_maskread_epd(Player4_SEPD+0x18//4,0xFFFFFFFF)
				Player4_58 << f_maskread_epd(Player4_SEPD+0x58//4,0xFFFFFFFF)
				Player4_5C << f_maskread_epd(Player4_SEPD+0x5C//4,0xFFFFFFFF)

				Player4_C << 1

				if EUDIf()((Player4_4D != 0)):

					if EUDWhile()((Player4_C <= 11)):

						if EUDIf()((Deaths(EPD(0x628578)+Player4_C,AtLeast,1,0))):

							Player4_T << f_maskread_epd(EPD(0x628578)+Player4_C,0xFFFFFF)

							Player4_TEPD << EPD(Player4_T)

							if EUDIf()((Deaths(Player4_TEPD+0x8//4,AtLeast,256,0),DeathsX(Player4_TEPD+0x4D//4,AtLeast,1*256,0,0xFF00))):

								DoActions([SetDeathsX(Player4_TEPD+0x4D//4,SetTo,Player4_4D,0,0xFF00),SetDeaths(Player4_TEPD+0x18//4,SetTo,Player4_18,0),SetDeaths(Player4_TEPD+0x58//4,SetTo,Player4_58,0),SetDeaths(Player4_TEPD+0x5C//4,SetTo,Player4_5C,0)])

							EUDEndIf()

						EUDEndIf()

						Player4_C << Player4_C + 1

					EUDEndWhile()

				EUDEndIf()

			EUDEndIf()

			Player5_S << f_maskread_epd(EPD(0x6285A8),0xFFFFFF)

			if EUDIf()((Player5_S != 0)):

				Player5_SEPD << EPD(Player5_S)

				Player5_4D << f_maskread_epd(Player5_SEPD+0x4D//4,0xFF00)
				Player5_18 << f_maskread_epd(Player5_SEPD+0x18//4,0xFFFFFFFF)
				Player5_58 << f_maskread_epd(Player5_SEPD+0x58//4,0xFFFFFFFF)
				Player5_5C << f_maskread_epd(Player5_SEPD+0x5C//4,0xFFFFFFFF)

				Player5_C << 1

				if EUDIf()((Player5_4D != 0)):

					if EUDWhile()((Player5_C <= 11)):

						if EUDIf()((Deaths(EPD(0x6285A8)+Player5_C,AtLeast,1,0))):

							Player5_T << f_maskread_epd(EPD(0x6285A8)+Player5_C,0xFFFFFF)

							Player5_TEPD << EPD(Player5_T)

							if EUDIf()((Deaths(Player5_TEPD+0x8//4,AtLeast,256,0),DeathsX(Player5_TEPD+0x4D//4,AtLeast,1*256,0,0xFF00))):

								DoActions([SetDeathsX(Player5_TEPD+0x4D//4,SetTo,Player5_4D,0,0xFF00),SetDeaths(Player5_TEPD+0x18//4,SetTo,Player5_18,0),SetDeaths(Player5_TEPD+0x58//4,SetTo,Player5_58,0),SetDeaths(Player5_TEPD+0x5C//4,SetTo,Player5_5C,0)])

							EUDEndIf()

						EUDEndIf()

						Player5_C << Player5_C + 1

					EUDEndWhile()

				EUDEndIf()

			EUDEndIf()
			if EUDIf()((Switch("Switch 11",Set))):
				AngleR << AngleRandom("Switch 9")
				DoActions(SetSwitch("Switch 11",Clear))
			EUDEndIf()
			if EUDIf()((Memory(0x58F450,Exactly,0))):

				Angle1 << 0 + AngleR
				Angle2 << 128 + AngleR

			EUDEndIf()
			if EUDIf()((Angle1 >= 256)):
				Angle1 << Angle1 - 256
			EUDEndIf()
			if EUDIf()((Angle2 >= 256)):
				Angle2 << Angle2 - 256
			EUDEndIf()
			if EUDIf()((Switch("Switch 10",Set),Memory(0x58F450,Exactly,0))):
				CreateBullet(204,20,Angle1,2368,1728)
				CreateBullet(204,20,Angle2,2368,1728)

				CreateBullet(204,20,Angle1,2848,1952)
				CreateBullet(204,20,Angle2,2848,1952)

				CreateBullet(204,20,Angle1,2368,2208)
				CreateBullet(204,20,Angle2,2368,2208)

				CreateBullet(204,20,Angle1,1888,1952)
				CreateBullet(204,20,Angle2,1888,1952)
			EUDEndIf()

			if EUDIf()((Memory(0x58F450,Exactly,1))):

				Angle1 << 0 + AngleR
				Angle2 << 64 + AngleR
				Angle3 << 128 + AngleR
				Angle4 << 192 + AngleR

			EUDEndIf()
			if EUDIf()((Angle1 >= 256)):
				Angle1 << Angle1 - 256
			EUDEndIf()
			if EUDIf()((Angle2 >= 256)):
				Angle2 << Angle2 - 256
			EUDEndIf()
			if EUDIf()((Angle3 >= 256)):
				Angle3 << Angle3 - 256
			EUDEndIf()
			if EUDIf()((Angle4 >= 256)):
				Angle4 << Angle4 - 256
			EUDEndIf()
			if EUDIf()((Switch("Switch 10",Set),Memory(0x58F450,Exactly,1))):
				CreateBullet(204,20,Angle1,2368,1728)
				CreateBullet(204,20,Angle2,2368,1728)
				CreateBullet(204,20,Angle3,2368,1728)
				CreateBullet(204,20,Angle4,2368,1728)

				CreateBullet(204,20,Angle1,2848,1952)
				CreateBullet(204,20,Angle2,2848,1952)
				CreateBullet(204,20,Angle3,2848,1952)
				CreateBullet(204,20,Angle4,2848,1952)

				CreateBullet(204,20,Angle1,2368,2208)
				CreateBullet(204,20,Angle2,2368,2208)
				CreateBullet(204,20,Angle3,2368,2208)
				CreateBullet(204,20,Angle4,2368,2208)

				CreateBullet(204,20,Angle1,1888,1952)
				CreateBullet(204,20,Angle2,1888,1952)
				CreateBullet(204,20,Angle3,1888,1952)
				CreateBullet(204,20,Angle4,1888,1952)
			EUDEndIf()

			if EUDIf()((Memory(0x58F450,Exactly,2))):
				Angle1 << 21 + AngleR
				Angle2 << 63 + AngleR
				Angle3 << 105 + AngleR
				Angle4 << 147 + AngleR
				Angle5 << 189 + AngleR
				Angle6 << 231 + AngleR
			EUDEndIf()
			if EUDIf()((Angle1 >= 256)):
				Angle1 << Angle1 - 256
			EUDEndIf()
			if EUDIf()((Angle2 >= 256)):
				Angle2 << Angle2 - 256
			EUDEndIf()
			if EUDIf()((Angle3 >= 256)):
				Angle3 << Angle3 - 256
			EUDEndIf()
			if EUDIf()((Angle4 >= 256)):
				Angle4 << Angle4 - 256
			EUDEndIf()
			if EUDIf()((Angle5 >= 256)):
				Angle5 << Angle5 - 256
			EUDEndIf()
			if EUDIf()((Angle6 >= 256)):
				Angle6 << Angle6 - 256
			EUDEndIf()
			if EUDIf()((Switch("Switch 10",Set),Memory(0x58F450,Exactly,2))):
				CreateBullet(204,20,Angle1,2368,1728)
				CreateBullet(204,20,Angle2,2368,1728)
				CreateBullet(204,20,Angle3,2368,1728)
				CreateBullet(204,20,Angle4,2368,1728)
				CreateBullet(204,20,Angle5,2368,1728)
				CreateBullet(204,20,Angle6,2368,1728)

				CreateBullet(204,20,Angle1,2848,1952)
				CreateBullet(204,20,Angle2,2848,1952)
				CreateBullet(204,20,Angle3,2848,1952)
				CreateBullet(204,20,Angle4,2848,1952)
				CreateBullet(204,20,Angle5,2848,1952)
				CreateBullet(204,20,Angle6,2848,1952)

				CreateBullet(204,20,Angle1,2368,2208)
				CreateBullet(204,20,Angle2,2368,2208)
				CreateBullet(204,20,Angle3,2368,2208)
				CreateBullet(204,20,Angle4,2368,2208)
				CreateBullet(204,20,Angle5,2368,2208)
				CreateBullet(204,20,Angle6,2368,2208)

				CreateBullet(204,20,Angle1,1888,1952)
				CreateBullet(204,20,Angle2,1888,1952)
				CreateBullet(204,20,Angle3,1888,1952)
				CreateBullet(204,20,Angle4,1888,1952)
				CreateBullet(204,20,Angle5,1888,1952)
				CreateBullet(204,20,Angle6,1888,1952)
			EUDEndIf()

			if EUDIf()((Memory(0x58F450,Exactly,3))):
				Angle1 << 0 + AngleR
				Angle2 << 32 + AngleR
				Angle3 << 64 + AngleR
				Angle4 << 96 + AngleR
				Angle5 << 128 + AngleR
				Angle6 << 160 + AngleR
				Angle7 << 192 + AngleR
				Angle8 << 224 + AngleR
			EUDEndIf()
			if EUDIf()((Angle1 >= 256)):
				Angle1 << Angle1 - 256
			EUDEndIf()
			if EUDIf()((Angle2 >= 256)):
				Angle2 << Angle2 - 256
			EUDEndIf()
			if EUDIf()((Angle3 >= 256)):
				Angle3 << Angle3 - 256
			EUDEndIf()
			if EUDIf()((Angle4 >= 256)):
				Angle4 << Angle4 - 256
			EUDEndIf()
			if EUDIf()((Angle5 >= 256)):
				Angle5 << Angle5 - 256
			EUDEndIf()
			if EUDIf()((Angle6 >= 256)):
				Angle6 << Angle6 - 256
			EUDEndIf()
			if EUDIf()((Angle7 >= 256)):
				Angle7 << Angle7 - 256
			EUDEndIf()
			if EUDIf()((Angle8 >= 256)):
				Angle8 << Angle8 - 256
			EUDEndIf()

			if EUDIf()((Switch("Switch 10",Set),Memory(0x58F450,Exactly,3))):
				CreateBullet(204,20,Angle1,2368,1728)
				CreateBullet(204,20,Angle2,2368,1728)
				CreateBullet(204,20,Angle3,2368,1728)
				CreateBullet(204,20,Angle4,2368,1728)
				CreateBullet(204,20,Angle5,2368,1728)
				CreateBullet(204,20,Angle6,2368,1728)
				CreateBullet(204,20,Angle7,2368,1728)
				CreateBullet(204,20,Angle8,2368,1728)

				CreateBullet(204,20,Angle1,2848,1952)
				CreateBullet(204,20,Angle2,2848,1952)
				CreateBullet(204,20,Angle3,2848,1952)
				CreateBullet(204,20,Angle4,2848,1952)
				CreateBullet(204,20,Angle5,2848,1952)
				CreateBullet(204,20,Angle6,2848,1952)
				CreateBullet(204,20,Angle7,2848,1952)
				CreateBullet(204,20,Angle8,2848,1952)

				CreateBullet(204,20,Angle1,2368,2208)
				CreateBullet(204,20,Angle2,2368,2208)
				CreateBullet(204,20,Angle3,2368,2208)
				CreateBullet(204,20,Angle4,2368,2208)
				CreateBullet(204,20,Angle5,2368,2208)
				CreateBullet(204,20,Angle6,2368,2208)
				CreateBullet(204,20,Angle7,2368,2208)
				CreateBullet(204,20,Angle8,2368,2208)

				CreateBullet(204,20,Angle1,1888,1952)
				CreateBullet(204,20,Angle2,1888,1952)
				CreateBullet(204,20,Angle3,1888,1952)
				CreateBullet(204,20,Angle4,1888,1952)
				CreateBullet(204,20,Angle5,1888,1952)
				CreateBullet(204,20,Angle6,1888,1952)
				CreateBullet(204,20,Angle7,1888,1952)
				CreateBullet(204,20,Angle8,1888,1952)

			EUDEndIf()

			if EUDIf()((Switch("Switch 10",Set))):
				DoActions(SetSwitch("Switch 10",Clear))
			EUDEndIf()

		EUDEndIf()

		if EUDIf()((Switch("Switch 14", Set))):

			B_2E, B_2A, B_2X, B_2Y = EUDCreateVariables(4)

			B_2E << 10
			if EUDWhile()((B_2E >= 1)):
				DoActions(MoveLocation(253,11,P6,"Anywhere")) 
				B_2E << B_2E - 1
				B_2X << f_dwrand()%576						
				B_2Y << f_dwrand()%576
				B_2A << f_dwrand()%256

				DoActions([SetMemory(0x58DC60+0x14*252+0,Add,-288 + B_2X),
					SetMemory(0x58DC60+0x14*252+8,Add,-288 + B_2X),
					SetMemory(0x58DC60+0x14*252+4,Add,-288 + B_2Y),
					SetMemory(0x58DC60+0x14*252+12,Add,-288 + B_2Y)])
				CreateBulletLoc(P6,204,5,B_2A,253)
			EUDEndWhile()


			DoActions(SetSwitch("Switch 14", Clear))


		EUDEndIf()




	EUDEndIf()

	if EUDIf()((Switch("Switch 214",Set))):
		if EUDIf()((Command(AllPlayers,AtLeast,1,174))):
			if EUDIf()((Deaths(B1H,AtMost,8000000*256,0))):
				DoActions(SetDeaths(B1H,Add,100000*256,0))
			EUDEndIf()
		EUDEndIf()
		
		if EUDIf()((Command(AllPlayers,AtLeast,1,5))):
			if EUDIf()((Deaths(B2H,AtMost,1000000*256,0),Memory(0x58F5F8,AtLeast,1))):
				DoActions([MoveLocation(254,5,P6,"Anywhere"),
					SetSwitch("Switch 15",Set),
					SetDeaths(B2H,SetTo,8000000*256,0),
					SetMemory(0x58F5F8,Subtract,1)])
			EUDEndIf()
		EUDEndIf()
		if EUDIf()((Command(AllPlayers,AtLeast,1,11))):
			if EUDIf()((Deaths(B3H,AtMost,8000000*256,0))):
				DoActions(SetDeaths(B3H,Add,10000*256,0))
			EUDEndIf()

			if EUDIf()((Deaths(B3H,AtMost,1000000*256,0),Memory(0x58F5FC,AtLeast,1))):
				DoActions([
					SetDeaths(B3H,SetTo,8000000*256,0),
					SetMemory(0x58F5FC,Subtract,1)])
			EUDEndIf()
			if EUDIf()((Deaths(B3H,AtLeast,8000001*256,0),Memory(0x58F5FC,AtMost,5))):
				DoActions([
					SetDeaths(B3H,SetTo,1015000*256,0),
					SetMemory(0x58F5FC,Add,1)])
			EUDEndIf()
		EUDEndIf()

		if EUDIf()((Command(AllPlayers,AtLeast,1,82))):
			if EUDIf()((Deaths(B4H,AtMost,8000000*256,0))):
				DoActions(SetDeaths(B4H,Add,50000*256,0))
			EUDEndIf()
			if EUDIf()((Deaths(B4H,AtMost,1000000*256,0),Memory(0x58F50C,AtLeast,1))):
				DoActions([
					SetDeaths(B4H,SetTo,8000000*256,0),
					SetMemory(0x58F50C,Subtract,1)])
			EUDEndIf()
			if EUDIf()((Deaths(B4H,AtLeast,8000001*256,0),Memory(0x58F50C,AtMost,10))):
				DoActions([
					SetDeaths(B4H,SetTo,1150000*256,0),
					SetMemory(0x58F50C,Add,1)])
			EUDEndIf()
			DoActions(SetDeaths(B4H+11,SetTo,1,0))
		EUDEndIf()

		if EUDIf()((Command(AllPlayers,AtLeast,1,186))):
			if EUDIf()((Deaths(B5H,AtMost,1000000*256,0),Memory(0x58F514,AtLeast,1))):
				DoActions([
					SetDeaths(B5H,SetTo,8000000*256,0),
					SetMemory(0x58F514,Subtract,1)])
			EUDEndIf()
			if EUDIf()((Memory(0x58F514,Exactly,0),Switch("Switch 16",Cleared),Deaths(B5H,AtMost,1000000*256,0))):
				DoActions([SetDeaths(B5H,SetTo,8000000*256,0),SetSwitch("Switch 215",Set)],preserved=False)
			EUDEndIf()

			if EUDIf()((Switch("Switch 211",Set))):
				if EUDIf()((DeathsX(B5H+17,Exactly,0,0,0xFF00))):
					DoActions([SetDeathsX(B5H+17,SetTo,1*256,0,0xFF00),SetDeaths(B5H,SetTo,7000000*256,0)])
				EUDEndIf()
			EUDEndIf()
		EUDEndIf()

	EUDEndIf()


	if EUDIf()((Switch("Switch 210",Set))):

		
		if EUDWhile()((N_A < 360,N_R<=2400)):

			N_X, N_Y = f_lengthdir(N_R,N_A)

			N_A << N_A + 5
			if EUDIf()((N_X+2368>=0,N_X+2368<=4096,N_Y+2368>=0,N_Y+1968<=4096)):
				DoActions([SetMemory(0x58DC60+20*206,SetTo,N_X+2368-32),
					SetMemory(0x58DC64+20*206,SetTo,N_Y+1968-32),
					SetMemory(0x58DC68+20*206,SetTo,N_X+2368+32),
					SetMemory(0x58DC6C+20*206,SetTo,N_Y+1968+32)])
				DoActions([CreateUnit(1,"Eff1",207,P6),KillUnit("Eff1",P6)])
			EUDEndIf()

		EUDEndWhile()
		N_A << 0

		DoActions([KillUnit("Eff1",P6)])
		if EUDIf()((N_R >= 2400)):
			DoActions([SetSwitch("Switch 210",Clear)])
			
			N_A << 0
			N_X << 0
			N_R << 0
			N_Y << 0

		EUDEndIf()

		N_R << N_R + 20
	EUDEndIf()

	P1S, P2S, P3S, P4S, P5S = EUDCreateVariables(5)

	if EUDIf()((Deaths(P6,AtMost,0,82),Command(P6,AtMost,0,82))):

		if EUDIf()((f_playerexist(0) == 1)):
			P1S = f_maskread_epd(EPD(0x58D2B0),0xFF)
			DoActions([SetMemoryX(0x58D2BC, SetTo, P1S*16777216,0xFF000000),ModifyUnitShields(All,230,0,"Anywhere",P1S//2)])
		EUDEndIf()
		if EUDIf()((f_playerexist(1) == 1)):
			P2S = f_maskread_epd(EPD(0x58D2DC),0xFF0000)
			DoActions([SetMemoryX(0x58D2EC, SetTo, P2S//256,0xFF00),ModifyUnitShields(All,230,1,"Anywhere",P2S//131072)])
		EUDEndIf()
		if EUDIf()((f_playerexist(2) == 1)):
			P3S = f_maskread_epd(EPD(0x58D30C),0xFF)
			DoActions([SetMemoryX(0x58D318, SetTo, P3S*16777216,0xFF000000),ModifyUnitShields(All,230,2,"Anywhere",P3S//2)])
		EUDEndIf()
		if EUDIf()((f_playerexist(3) == 1)):
			P4S = f_maskread_epd(EPD(0x58D338),0xFF0000)
			DoActions([SetMemoryX(0x58D348, SetTo, P4S//256,0xFF00),ModifyUnitShields(All,230,3,"Anywhere",P4S//131072)])
		EUDEndIf()
		if EUDIf()((f_playerexist(4) == 1)):
			P5S = f_maskread_epd(EPD(0x58D368),0xFF)
			DoActions([SetMemoryX(0x58D374, SetTo, P5S*16777216,0xFF000000),ModifyUnitShields(All,230,4,"Anywhere",P5S//2)])
		EUDEndIf()
	EUDEndIf()
	
	DoActions(SetDeaths(Force1,SetTo,0,71))