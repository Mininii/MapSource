from eudplib import *
import math

def beforeTriggerExec():
	if EUDIf()(ElapsedTime(AtLeast, 10)):

		Player1_S = EUDArray(10)
		Player1_T = EUDArray(10)
		Player1_58 = EUDArray(10)
		Player1_5C = EUDArray(10)
		Player1_4D = EUDArray(10)
		Player1_C = EUDArray(10)
		Player1_18 = EUDArray(10)
		Player1_TEPD = EUDArray(10)
		Player1_SEPD = EUDArray(10)
		cord628 = EUDVariable()
		unitRuq = EUDVariable()
		for gw in range(6): #6답:0~5 까지

			if EUDIf()((Deaths(gw,AtLeast,1,49),Deaths(gw,AtLeast,1,50))):#대기열 56번 영웅기뎐 0x98//4
				DoActions(unitRuq.SetNumber(161741))
				if EUDWhile()(unitRuq >= 19025):
					if EUDIf()((DeathsX(unitRuq+19,Exactly,gw,0,0xFF),EUDOr(DeathsX(unitRuq+25,Exactly,0,0,0xFF),DeathsX(unitRuq+25,Exactly,20,0,0xFF),DeathsX(unitRuq+25,Exactly,100,0,0xFF)))): # Player Id
						DoActions([SetDeathsX(unitRuq+55,SetTo,0xA00000,0,0xA00000)]) # 0x00200000 No Collide + 0x00800000 Is Gathering = 0xA00000
					EUDEndIf()
					DoActions(unitRuq.SubtractNumber(84))
				EUDEndWhile()
				DoActions(SetDeaths(gw,SetTo,0,50))
			EUDEndIf()
			if EUDIf()((Deaths(gw,Exactly,0,49),Deaths(gw,AtLeast,1,50))):#대기열 56번 영웅기뎐 0x98//4
				DoActions(unitRuq.SetNumber(161741))
				if EUDWhile()(unitRuq >= 19025):
					if EUDIf()((DeathsX(unitRuq+19,Exactly,gw,0,0xFF),EUDOr(DeathsX(unitRuq+25,Exactly,0,0,0xFF),DeathsX(unitRuq+25,Exactly,20,0,0xFF),DeathsX(unitRuq+25,Exactly,100,0,0xFF)))): # Player Id
						DoActions([SetDeathsX(unitRuq+55,Subtract,0xA00000,0,0xA00000)]) # 0x00200000 No Collide + 0x00800000 Is Gathering = 0xA00000
					EUDEndIf()
					DoActions(unitRuq.SubtractNumber(84))
				EUDEndWhile()
				DoActions(SetDeaths(gw,SetTo,0,50))
			EUDEndIf()
			if EUDIf()(Deaths(gw,AtLeast,1,"Eff2")):
				cord628 << 0x6284E8+0x30*gw
				Player1_S[gw] = f_maskread_epd(EPD(cord628),0xFFFFFF)

				if EUDIf()((Player1_S[gw] != 0)):
					Player1_SEPD[gw] = EPD(Player1_S[gw])

					Player1_4D[gw] = f_maskread_epd(Player1_SEPD[gw]+0x4D//4,0xFF00)
					Player1_18[gw] = f_maskread_epd(Player1_SEPD[gw]+0x18//4,0xFFFFFFFF)
					Player1_58[gw] = f_maskread_epd(Player1_SEPD[gw]+0x58//4,0xFFFFFFFF)
					Player1_5C[gw] = f_maskread_epd(Player1_SEPD[gw]+0x5C//4,0xFFFFFFFF)

					Player1_C[gw] = 1
					if EUDIf()((Player1_4D[gw] != 0)):
						if EUDWhile()((Player1_C[gw] <= 11)):
							if EUDIf()((Deaths(EPD(cord628)+Player1_C[gw],AtLeast,1,0))):
								Player1_T[gw] = f_maskread_epd(EPD(cord628)+Player1_C[gw],0xFFFFFF)
								Player1_TEPD[gw] = EPD(Player1_T[gw])
								if EUDIf()((Deaths(Player1_TEPD[gw]+0x8//4,AtLeast,256,0),DeathsX(Player1_TEPD[gw]+0x4D//4,AtLeast,1*256,0,0xFF00))):
									DoActions([SetDeathsX(Player1_TEPD[gw]+0x4D//4,SetTo,Player1_4D[gw],0,0xFF00),SetDeaths(Player1_TEPD[gw]+0x18//4,SetTo,Player1_18[gw],0),SetDeaths(Player1_TEPD[gw]+0x58//4,SetTo,Player1_58[gw],0),SetDeaths(Player1_TEPD[gw]+0x5C//4,SetTo,Player1_5C[gw],0)])
								EUDEndIf()
							EUDEndIf()
							Player1_C[gw] = Player1_C[gw] + 1
						EUDEndWhile()
					EUDEndIf()
				EUDEndIf()
			EUDEndIf()
	EUDEndIf()