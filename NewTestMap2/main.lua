-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--__MapDirSetting(__encode_cp949("C:\\euddraft0.9.2.0")) -- 맵파일 경로(\를 \\로 바꿔야함)
--__SubDirSetting(__encode_cp949(Curdir.."MapSource\\NewTestMap2")) -- Main.lua 폴더경로 (\를 \\로 바꿔야함, 없으면 비우기)
--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------
LD2XOption = 1
if LD2XOption == 1 then
	Mapdir="C:\\euddraft0.9.2.0\\exmap1"
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
		if dir ~= "recover.lua" then
			InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
			InitEXTLua()
		end
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\NewTestMap2\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		if dir ~= "recover.lua" then
			InitEXTLua = assert(loadfile(Curdir.."MapSource\\NewTestMap2\\"..dir))
			InitEXTLua()
		end
     end
end
------------------------------------------------------------------------------------------------------------------------------


CurTrigCnt = 0
VerText = "\x19ver\x07. \x043\x07.\x0458"
Asm55Off = 1
if Asm55Off == 1 then
	function STRxStart() end
	function STRxEnd() end
end
TestSet(1)
if Limit == 1 then
	VerText = VerText.."T"
	TestSpeedNum = 1
	SpeedTestMode = 0
	SpeedTestOp = 2
	X3Mode = 0
	CreatorCheatMode = 0
	CreatorCheatModeMul = 5
	SlotEnable =0
	FragMode = 1
	HotTimeTest = 1
	HotTimeMul = 4
else
	HotTimeTest = 0
	HotTimeMul = 1
FragMode = 0
CreatorCheatMode = 0
SpeedTestMode = 0
SlotEnable =1
end
FP = P8
LimitVer = 63
StatVer = 14
StatVer2 = 5
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{Defeat()})
StartCtrig(1,FP,nil,1,"C:\\Temp")
DP_Start_init()
__SetIndexAlloc(0x4000, 0xA000)
init_func = def_sIndex()
CJump(AllPlayers,init_func)
STRxStart()
	Include_CtrigPlib(360,"Switch 100")
	Include_64BitLibrary("Switch 100")
	Install_BackupCP(FP)
	Include_Vars()
	Include_Conv_CPosXY(FP,{4096*2,4096*2})
	CT_Cunit = Install_EXCC(FP,4,nil)
	Include_CRandNum(FP)
	DataArr()
	Install_CallTriggers()
STRxEnd()
	
CJumpEnd(AllPlayers,init_func)
onInit_EUD() -- onPluginStart
STRxStart()
	CT_Prev()
	CT_PrevCP()
STRxEnd()
LeaderBoard()
System()
Operator()
Interface()
Shop()
GameDisplay()
GlobalBoss()
TBL()
CUnit()	
STRxStart()
CT_Next()
STRxEnd()
TestTrig()
init_Setting()
EndCtrig()
ErrorCheck()
SetCallErrorCheck()
os.execute("mkdir " .. "banflag")
local CSfile = io.open(FileDirectory .. "banflag" .. ".txt", "w")
io.output(CSfile)
for j,k in pairs(ctarr) do
	io.write("BanFlag"..j.." = [")
	
	for l,m in pairs(k) do
		io.write("\""..m.."\", ")
	end
	
	io.write("]\n")
end

for j,k in pairs(ctarr) do
    io.write("BanFlag"..j.." : ")
    
    for l,m in pairs(k) do
        io.write("\""..l.." : "..m.."\", ")
    end
    
    io.write("\n")
end