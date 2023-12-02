-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
--dofile(Curdir.."MapSource\\MSF_UE_RE\\main.lua")

--속도측정용
--local x = os.clock()
----------------------------------------------Loader Space ---------------------------------------------------------------------
LD2XOption = 1
if LD2XOption == 1 then
	Mapdir="C:\\euddraft0.9.2.0\\MSF_UE_RE"
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

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_UE_RE\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_UE_RE\\"..dir))
		InitEXTLua()
     end
end
------------------------------------------------------------------------------------------------------------------------------


NormalTurboSet(P8,214)
DoActions(P8,SetResources(Force1,Add,-1,Gas),1)
DoActions(Force1,SetDeaths(CurrentPlayer,SetTo,1,227),1)
DoActions(P8,{RemoveUnit(179,P12),RemoveUnit(71,P8),RemoveUnit(203,AllPlayers),RemoveUnit(204,AllPlayers),RemoveUnit(205,AllPlayers),RemoveUnit(206,AllPlayers),RemoveUnit(207,AllPlayers),RemoveUnit(208,AllPlayers),RemoveUnit(209,AllPlayers),RemoveUnit(211,AllPlayers),RemoveUnit(212,AllPlayers)})
TestSet(0)
TestPMul=2
VerText = "\x04Ver. Beta. 0.94"
if Limit == 1 then
	VerText = VerText.."T"
	BossPhaseTestMode = 0
	
end
StatVer = 1
BossPhaseTestMode = 1
LimitVer = 12
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_HumanCheck()
Trigger2(FP,{HumanCheck(0,0),HumanCheck(1,0),HumanCheck(2,0),HumanCheck(3,0),HumanCheck(4,0),HumanCheck(5,0),HumanCheck(6,0)},{Defeat()})
StartCtrig(1,FP,nil,1,"C:\\Temp")
GiveT = {}
for i = 0, 6 do
	table.insert(GiveT,GiveUnits(1, 107, P12, 64, i))
	table.insert(GiveT,GiveUnits(1, 111, P12, 64, i))
	table.insert(GiveT,GiveUnits(All, 125, P12, 2+i, i))
end
DoActions(FP,GiveT,1)
for i = 0, 6 do
Trigger2(FP,{HumanCheck(i,0)},{RemoveUnit(125,i),RemoveUnit(107,i),RemoveUnit(111,i)})
end
	CIf(AllPlayers,ElapsedTime(AtLeast,3))
		init_func = def_sIndex()
		CJump(AllPlayers,init_func)

			Include_CtrigPlib(360,"Switch 100")
			Include_64BitLibrary("Switch 100")
			Include_CBPaint()
			DUnitCalc = Install_EXCC(FP,25,1)
			LHPCunit = Install_EXCC(FP,25)
			Install_TMemoryBW(FP)
			Objects()
			HPoints()
			Var_init()
			Include_Conv_CPosXY(FP,{96*32,192*32})
			Install_GetCLoc(FP,0,nilunit)
			Install_CBullet()
			BlasterBullet = TStruct_init(FP,32,20,HumanPlayers)
			BoneBullet = TStruct_init(FP,200,20,HumanPlayers)
			Include_G_CB_Library(0x600,256,55,{Var_TempTable[2],Var_TempTable[3]},{TRepeatX,TRepeatY},G_CB_ShapeT,G_CB_LoopMaxT)
			DataInput()
			Install_CallTriggers()
		CJumpEnd(AllPlayers,init_func)
		Start_init()
		
		--CT_Prev()
		
		DoHumanCheck()
		BGMManager()
		onInit_EUD() -- onPluginStart
		OPText() -- Opening Text
		MapPreserves()
		OPTrig()
		SetRecoverCp()
		RecoverCp(AllPlayers)
		CIf(AllPlayers,ElapsedTime(AtLeast,4))
			onInit_EUD2()
			Gun_System()
			Install_RandPlaceHero()
			SetWave()
			GameOver()
			ObDisplay()
			Install_SansBoss()
			LevelUp()
			PlayerInterface()
			LeaderBoardTFunc()
			Install_Roka7Boss()
			Install_IdenBoss()
			Install_DemBoss()
			Install_DLBoss()
			Install_Destr0yer()
		CIfEnd()
		NoAirCollisionX(FP)
	CIfEnd()
	--CT_Next()
	init_Setting()
	Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()


if LD2XOption == 1 then
__PopStringArray()
io.close(__TRIGchkptr)
end
--속도측정용 2
--error(string.format("elapsed time: %.3f\n", os.clock() - x))