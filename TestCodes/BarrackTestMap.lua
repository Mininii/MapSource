
Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
	if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
	end
end

FP = P8
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8}) 
SetFixedPlayer(FP)
StartCtrig()
CJump(AllPlayers,0x600)
Include_CtrigPlib(360,"Switch 1",0)
function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end
BackupCp = CreateVar()
SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()
LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
	SetRecoverCp()
SetCallEnd()

CJumpEnd(AllPlayers,0x600)
NoAirCollisionX(FP)--
CIfOnce(FP)

BRXT = CreateVarray(FP,5)
BRYT = CreateVarray(FP,5)
BRX2T = CreateVarray(FP,5)
BRY2T = CreateVarray(FP,5)
BPtr = CreateVar()
BPos = CreateVar()
BPosX = CreateVar()
BPosY = CreateVar()
Cunit2 = CreateVar()
CurCunit = CreateVar()
CurBR = CreateVar()
TextX = CreateVar()
TextY = CreateVar()
TextX2 = CreateVar()
TextY2 = CreateVar()
BR = CreateVar()
BRX = CreateVar()
BRY = CreateVar()
BRX2 = CreateVar()
BRY2 = CreateVar()
CR = CreateVar()
_0D = string.rep("\x0D",200)
f_GetStrXptr(FP,TextX,"\x04X ÁÂÇ¥ : ".._0D)
f_GetStrXptr(FP,TextY,"\x04Y ÁÂÇ¥ : ".._0D)
f_GetStrXptr(FP,TextX2,"\x04¸Ê»ó X ÁÂÇ¥ : ".._0D)
f_GetStrXptr(FP,TextY2,"\x04¸Ê»ó Y ÁÂÇ¥ : ".._0D)
SkipText = GetStrSize(0,"\x04X ÁÂÇ¥ : \x0d\x0d\x0d\x0d\x0d")
f_Read(FP,0x628438,nil,BPtr)
DoActions(FP,{SetMemory(0x662860 + (111*4),SetTo,65537),CreateUnit(1,111,64,P1)})
f_Read(FP,_Add(BPtr,10),BPos)
CMov(FP,BPosX,BPos,0,0xFFFF)
CMov(FP,BPosY,_Div(BPos,_Mov(0x10000)),0,0xFFFF)
CIfEnd()

f_Read(FP,0x6284E8,"X",Cunit2)
CIf(FP,{TTCVar(FP,CurCunit[2],NotSame,Cunit2)})
CMov(FP,CurCunit,Cunit2)

CIf(FP,{CVar(FP,CurCunit[2],AtLeast,1),CVar(FP,CurCunit[2],AtMost,0x7FFFFFFF)})
f_Read(FP,_Add(CurCunit,10),CR)

CMov(FP,BRX,CR,0,0xFFFF)
CMov(FP,BRY,_Div(CR,0x10000),0,0xFFFF)
CiSub(FP,BRX2,BRX,BPosX)
CiSub(FP,BRY2,BRY,BPosY)

ItoDec(FP,BRX,VArr(BRXT,0),1,nil,2)
ItoDec(FP,BRY,VArr(BRYT,0),1,nil,2)
ItoDec(FP,BRX2,VArr(BRX2T,0),1,nil,2)
ItoDec(FP,BRY2,VArr(BRY2T,0),1,nil,2)
f_Movcpy(FP,_Add(TextX2,SkipText),VArr(BRXT,0),5*4)
f_Movcpy(FP,_Add(TextY2,SkipText),VArr(BRYT,0),5*4)
f_Movcpy(FP,_Add(TextX,SkipText),VArr(BRX2T,0),5*4)
f_Movcpy(FP,_Add(TextY,SkipText),VArr(BRY2T,0),5*4)

DoActions(FP,{RotatePlayer({
	DisplayTextX("\x04==================",4),
	DisplayTextX("\x04X ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04Y ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04¸Ê»ó X ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04¸Ê»ó Y ÁÂÇ¥ : ".._0D,4),
},{0,1,2,3,4,5,6,7},FP)})

CIfEnd()
CIfEnd()
ESC = 220
CIf(FP,{Deaths(P1,AtLeast,1,ESC),MemoryX(0x596A30,Exactly,16777216,16777216),CVar(FP,CurCunit[2],AtLeast,1),CVar(FP,CurCunit[2],AtMost,0x7FFFFFFF)})

f_Read(FP,_Add(CurCunit,10),BPos)
CMov(FP,BPosX,BPos,0,0xFFFF)
CMov(FP,BPosY,_Div(BPos,_Mov(0x10000)),0,0xFFFF)

CMov(FP,BRX,BPos,0,0xFFFF)
CMov(FP,BRY,_Div(BPos,0x10000),0,0xFFFF)
CiSub(FP,BRX2,BRX,BPosX)
CiSub(FP,BRY2,BRY,BPosY)

ItoDec(FP,BRX,VArr(BRXT,0),1,nil,2)
ItoDec(FP,BRY,VArr(BRYT,0),1,nil,2)
ItoDec(FP,BRX2,VArr(BRX2T,0),1,nil,2)
ItoDec(FP,BRY2,VArr(BRY2T,0),1,nil,2)
f_Movcpy(FP,_Add(TextX2,SkipText),VArr(BRXT,0),5*4)
f_Movcpy(FP,_Add(TextY2,SkipText),VArr(BRYT,0),5*4)
f_Movcpy(FP,_Add(TextX,SkipText),VArr(BRX2T,0),5*4)
f_Movcpy(FP,_Add(TextY,SkipText),VArr(BRY2T,0),5*4)

DoActions(FP,{RotatePlayer({
	DisplayTextX("\x04Á¡ÀÇ Áß½É ÁÂÇ¥°¡ °»½ÅµÇ¾ú½À´Ï´Ù.",4),
},{0,1,2,3,4,5,6,7},FP)})

DoActions(FP,{RotatePlayer({
	DisplayTextX("\x04==================",4),
	DisplayTextX("\x04X ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04Y ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04¸Ê»ó X ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04¸Ê»ó Y ÁÂÇ¥ : ".._0D,4),
},{0,1,2,3,4,5,6,7},FP)})

CIfEnd()
f_Read(FP,_Add(BPtr,62),BR)
CIf(FP,{TTCVar(FP,CurBR[2],NotSame,BR)})
CMov(FP,CurBR,BR)

CMov(FP,BRX,CurBR,0,0xFFFF)
CMov(FP,BRY,_Div(CurBR,0x10000),0,0xFFFF)
Simple_SetLocX(FP,0,BRX,BRY,BRX,BRY,{CreateUnit(1,54,1,P1)})
CiSub(FP,BRX2,BRX,BPosX)
CiSub(FP,BRY2,BRY,BPosY)


ItoDec(FP,BRX,VArr(BRXT,0),1,nil,2)
ItoDec(FP,BRY,VArr(BRYT,0),1,nil,2)
ItoDec(FP,BRX2,VArr(BRX2T,0),1,nil,2)
ItoDec(FP,BRY2,VArr(BRY2T,0),1,nil,2)
f_Movcpy(FP,_Add(TextX2,SkipText),VArr(BRXT,0),5*4)
f_Movcpy(FP,_Add(TextY2,SkipText),VArr(BRYT,0),5*4)
f_Movcpy(FP,_Add(TextX,SkipText),VArr(BRX2T,0),5*4)
f_Movcpy(FP,_Add(TextY,SkipText),VArr(BRY2T,0),5*4)

DoActions(FP,{RotatePlayer({
	DisplayTextX("\x04==================",4),
	DisplayTextX("\x04X ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04Y ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04¸Ê»ó X ÁÂÇ¥ : ".._0D,4),
	DisplayTextX("\x04¸Ê»ó Y ÁÂÇ¥ : ".._0D,4),
},{0,1,2,3,4,5,6,7},FP)})

CIfEnd()
Install_AllObject()
EndCtrig()
ErrorCheck()
EUDTurbo(FP)