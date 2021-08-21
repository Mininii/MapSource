----------------------------------------------Loader Space ---------------------------------------------------------------------

Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

EXTLUA = "dir \""..Curdir.."\\MapSource\\MSF_UE\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "main.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\MSF_UE\\"..dir))
		InitEXTLua()
     end
end

------------------------------------------------------------------------------------------------------------------------------


NormalTurboSet(P8,214)
DoActions(P8,SetResources(Force1,Add,-1,Gas),1)
DoActions(Force1,SetDeaths(CurrentPlayer,SetTo,1,227),1)
DoActions(P8,{RemoveUnit(71,P8),RemoveUnit(203,P8),RemoveUnit(204,P8),RemoveUnit(205,P8),RemoveUnit(206,P8),RemoveUnit(207,P8),RemoveUnit(208,P8),RemoveUnit(209,P8),RemoveUnit(210,P8)})
TestSet(0)
VerText = "\x04Ver. 1.9FP"
FP = P8
EUDTurbo(FP)
SetForces({P1,P2,P3,P4,P5,P6,P7},{P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(FP)
Enable_PlayerCheck()
Trigger2(FP,{PlayerCheck(0,0),PlayerCheck(1,0),PlayerCheck(2,0),PlayerCheck(3,0),PlayerCheck(4,0),PlayerCheck(5,0),PlayerCheck(6,0)},{Defeat()})
StartCtrig()
	CIf(AllPlayers,ElapsedTime(AtLeast,3))
		init_func = def_sIndex()
		CJump(AllPlayers,init_func)
			Include_CtrigPlib(360,"Switch 100",1,FP)
			Objects()
			HPoints()
			Var_init()
			Install_GetCLoc(FP,0,nilunit)
			Install_CallTriggers()
		CJumpEnd(AllPlayers,init_func)
		DoPlayerCheck()
		NoAirCollisionX(FP)
		BGMManager()
		onInit_EUD() -- onPluginStart
		OPText() -- Opening Text
		MapPreserves()
		SetRecoverCp()
		RecoverCp(AllPlayers)
		CIf(AllPlayers,ElapsedTime(AtLeast,4))
			onInit_EUD2()
			Gun_System()
			Install_RandPlaceHero()
			SetWave()
			GameOver()
			Overflow_HP_System(FP,B1_H,B1_K)
			IBGM_EPDX(FP,6,Dt,{Dt_NT2,Dt_NT})
			ObDisplay()
			LevelUp()
			OPTrig()
			PlayerInterface()
			LeaderBoardTFunc()
			Install_Roka7Boss()
			Install_IdenBoss()
			Install_DemBoss()
			Install_DLBoss()
			Install_Destr0yer()
			Test_LV1()
			Test_LV2()
		CIfEnd()
	CIfEnd()
	Enable_HideErrorMessage(FP)
EndCtrig()
ErrorCheck()
SetCallErrorCheck()
