
dofile("lua/Loader.lua")
FP = P8
EUDTurbo(FP) -- 뎡터보


RepUnitPtr = 0x593000 -- 유닛 데이터 저장 장소

function Call_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function Call_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end



SetForces({P1,P2,P3,P4,P5,P6},{P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
StartCtrig()

RepHeroIndex = CreateVar()
RepX = CreateVar()
RepY = CreateVar()
BackupCp = CreateVar()
CPos = CreateVar()
CPosX = CreateVar()
CPosY = CreateVar()
BacpupPtr = CreateVar()
CJump(AllPlayers,0x700)
Include_CtrigPlib(360,"Switch 100",1)
SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()

LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
SetCallEnd()

HeroToData = SetCallForward()
SetCall(FP)


CMov(FP,0x6509B0,19025+25)
CWhile(FP,Memory(0x6509B0,AtMost,19025+25 + (84*1699)))
CIf(FP,{TDeathsX(CurrentPlayer,Exactly,RepHeroIndex,0,0xFF)})
Call_SaveCp()
f_Read(FP,_Sub(BackupCp,15),CPos)
CMov(FP,0x6509B0,EPD(RepUnitPtr))
NWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))
CAdd(FP,0x6509B0,2)
NWhileEnd()
CDoActions(FP,{
TSetDeaths(CurrentPlayer,SetTo,CPos,0),
SetMemory(0x6509B0,Add,1),
TSetDeaths(CurrentPlayer,SetTo,RepHeroIndex,0)
})
Call_LoadCp()
CIfEnd()
CAdd(FP,0x6509B0,84)
CWhileEnd()
CAdd(FP,0x6509B0,FP)
CDoActions(FP,{TRemoveUnit(RepHeroIndex,AllPlayers)})
SetCallEnd()
CJumpEnd(AllPlayers,0x700)
NoAirCollisionX(FP)




CIfOnce(FP,nil) -- OnPluginStart


HeroIndexArr = {101} -- 재배치할 유닛 ID 하나하나 쓰면 됨.


for i = 1, #HeroIndexArr do -- 유닛 데이터화
Trigger {
	players = {FP},
	conditions = {
		Label(0);
	},
	actions = {
		SetCVar(FP,RepHeroIndex[2],SetTo,HeroIndexArr[i]);
		SetNext("X",HeroToData,0);
		SetNext(HeroToData+1,"X",1);
	}
}
end



CMov(FP,0x6509B0,EPD(RepUnitPtr))-- 데이터화 한 유닛 배치하는 코드
CWhile(FP,Deaths(CurrentPlayer,AtLeast,1,0))

Call_SaveCp()

f_Read(FP,BackupCP,CPosX,"X",0xFFFF)
f_Read(FP,BackupCP,CPosY,"X",0xFFFF0000)
CDiv(FP,CPosY,0x10000)
f_Read(FP,_Add(BackupCP,1),RepHeroIndex)
CDoActions(FP,{
SetMemory(0x58DC60 + 0x14*0,SetTo,0),
SetMemory(0x58DC68 + 0x14*0,SetTo,0),
SetMemory(0x58DC64 + 0x14*0,SetTo,0),
SetMemory(0x58DC6C + 0x14*0,SetTo,0),
TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
TCreateUnit(1, RepHeroIndex, 1, P7)
})
Call_LoadCp()
CAdd(FP,0x6509B0,2)
CWhileEnd()
CMov(FP,0x6509B0,FP)


CIfEnd()





CJump(FP,0x0)
InstallCVariable()
CJumpEnd(FP,0x0)

EndCtrig()
ErrorCheck()