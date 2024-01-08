-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\NewTestMap3\\main.lua")

--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------
LD2XOption = 1
if LD2XOption == 1 then
	Mapdir="C:\\euddraft0.9.2.0\\exmap2"
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

EXTLUA = "dir \""..Curdir.."\\MapSource\\NewTestMap3\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		if dir ~= "recover.lua" then
			InitEXTLua = assert(loadfile(Curdir.."MapSource\\NewTestMap3\\"..dir))
			InitEXTLua()
		end
     end
end
------------------------------------------------------------------------------------------------------------------------------


VerText = "\x19ver\x07. \x040\x07.\x0401"

TestSet(1)
if Limit == 1 then
	VerText = VerText.."T"
	TestSpeedNum = 1
else
SpeedTestMode = 0
SlotEnable =1
end
LimitVer = 1
StatVer = 1
StatVer2 = 1
EUDTurbo(AllPlayers) -- 8인용맵
SetForces({P1,P2,P3,P4,P5,P6,P7,P8},{},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})

FP = P1
SetFixedPlayer(FP) -- 메인 트러기 플레이어. 
Enable_HumanCheck() -- 컴퓨터 체크 필요시 PlayerCheck(Player,Status) 사용
StartCtrig(1,FP,nil,1,"C:\\Temp")

init_func = def_sIndex()
CJump(AllPlayers,init_func)
Include_CtrigPlib(360,"Switch 100")
Include_64BitLibrary("Switch 100")
CJumpEnd(AllPlayers,init_func)
DPInitActArr = DP_Start_init(FP,nil,nil,nil,1)



init_func = def_sIndex()
CJump(AllPlayers,init_func)
	Install_BackupCP(FP)
	--Include_Vars()
	Include_Conv_CPosXY(FP,{4096*2,4096*2})
	CT_Cunit = Install_EXCC(FP,4,nil)
	Include_CRandNum(FP)
	--DataArr()
	--Install_CallTriggers()
	
CJumpEnd(AllPlayers,init_func)




MainTrig = def_sIndex()



TriggerX({P2,P3,P4,P5,P6,P7,P8}, {Switch("Switch 1",Cleared)}, {
	SetCtrigX("X","X",0x4,0,SetTo,P1,0x5000,0x0,0,0);
	SetCtrigX(P1,0x5001,0x4,0,SetTo,"X","X",0x0,0,1);
	SetCtrigX(P1,0x5000,0x158,0,SetTo,"X","X",0x4,1,0);
	SetCtrigX(P1,0x5000,0x15C,0,SetTo,"X","X",0x0,0,1);
	SetCtrigX("X","X",0x158,1,SetTo,P1,0x5001,0x4,1,0);
	SetCtrigX("X","X",0x15C,1,SetTo,P1,0x5001,0x0,0,1);
	SetSwitch("Switch 187",Set);}, {preserved})
for i = 1, 7 do
	TriggerX(i, {Switch("Switch 187",Set)}, {
		SetDeaths(0,SetTo,0,0);
		SetSwitch("Switch 187",Clear);-- RotatePlayer({DisplayTextX((i+1).."P가 실행중", 1)}, AllPlayers, i);
		SetMemory(0x6509B0,SetTo,i)}, {preserved})
end
TriggerX(P1, {Switch("Switch 187",Set)}, {
	SetDeaths(0,SetTo,0,0);}, {preserved},0x5000)
CIf(FP,Switch("Switch 1",Cleared),SetSwitch("Switch 1",Set))
--FP 트리거 시작부
--여기에 모든 FP 트리거 입력 (절대 FP 이외의 트리거 입력 금지)

--TriggerX(FP, {}, {RotatePlayer({DisplayTextX("1번트리거", 1)}, AllPlayers, FP)}, {preserved})
--TriggerX(FP, {}, {RotatePlayer({DisplayTextX("2번트리거", 1)}, AllPlayers, FP)}, {preserved})
--TriggerX(FP, {}, {RotatePlayer({DisplayTextX("3번트리거", 1)}, AllPlayers, FP)}, {preserved})
_G[DPInitActArr[1]](DPInitActArr[2],DPInitActArr[3],DPInitActArr[4],DPInitActArr[5])

--onInit_EUD() -- onPluginStart




--FP 트리거 종료부
CIfEnd()
DoActionsX(P1, {}, nil,0x5001)
init_Setting()
EndCtrig()
ErrorCheck()
SetCallErrorCheck()
--os.execute("mkdir " .. "banflag")
--local CSfile = io.open(FileDirectory .. "banflag" .. ".txt", "w")
--io.output(CSfile)
--for j,k in pairs(ctarr) do
--	io.write("BanFlag"..j.." = [")
--	
--	for l,m in pairs(k) do
--		io.write("\""..m.."\", ")
--	end
--	
--	io.write("]\n")
--end--

--for j,k in pairs(ctarr) do
--    io.write("BanFlag"..j.." : ")
--    
--    for l,m in pairs(k) do
--        io.write("\""..l.." : "..m.."\", ")
--    end
--    
--    io.write("\n")
--end
--CheckTrig("EndTrig")--

--TrigBench:write("Total Trig Count : "..CurTrigTotal.."\n")
--io.close(CSfile)
--io.close(TrigBench)

if LD2XOption == 1 then
__PopStringArray()
io.close(__TRIGchkptr)
end

