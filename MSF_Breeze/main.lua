-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_Breeze\\main.lua")

--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------
LD2XOption = 1
if LD2XOption == 1 then
	Mapdir="C:\\euddraft0.9.2.0\\MSF_Breeze"
	__StringArray = {}
	__TRIGChkptr = io.open(Mapdir.."__TRIG.chk", "wb")
	__TRIGChkptrT = {}
	__TTI = 1
	Loader2XFName = "Loader.lua"
else
	Loader2XFName = "Loader2X.lua"
end

--Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= Loader2XFName then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_Breeze\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_Breeze\\"..dir))
		InitEXTLua()
     end
end
------------------------------------------------------------------------------------------------------------------------------

VerText = "\x04Ver. Beta. 0.7"

TestSet(0)
if Limit == 1 then
	VerText = VerText.."T"
	
end
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{Defeat()})
StartCtrig(1,FP,nil,1,"C:\\Temp")

init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Include_CtrigPlib(360,"Switch 100")
	Include_CBPaint()
	Include_Vars()
	Include_Conv_CPosXY(FP,{96*32,64*32})
	Install_GetCLoc(FP,0,nilunit)
	Include_CRandNum(FP)
	Include_G_CA_Library(2,0x600,32)
CJumpEnd(AllPlayers,init_func)

onInit_EUD() -- onPluginStart


Interface()
Waves()

-- 마지막 플레이어가 P8일 경우 (아닐경우 P8을 다른 플레이어로 바꿔야함)
-- 바로 아래에 EndCtrig() 있어야함 --
EndCtrig()
ErrorCheck()
SetCallErrorCheck()


if LD2XOption == 1 then
__PopStringArray()
io.close(__TRIGchkptr)
end

