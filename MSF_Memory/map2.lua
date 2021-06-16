

--↓ 트리거 코드 작성 영역 ------------------------------------------------------------------------------------------------------------------------------------------

--Library Loader
dofile("lua/Loader.lua")
dofile("Map2Source/LibraryFor322.lua")-- SCMD 폴더 내의 Map2Source 폴더에 넣었음
dofile("Map2Source/MemoryInit.lua")-- SCMD 폴더 내의 Map2Source 폴더에 넣었음
dofile("Map2Source/BGMArr.lua")-- SCMD 폴더 내의 Map2Source 폴더에 넣었음

VerText = "\x04Ver. 2.4"
Limit = 0
FP = P6
TestStartToBYD = 0

--Literally Unused Offset Alloc
MemoryPtr = 0x593000
MemoryPtrSize = 25
GunPtrMemory = 0x590300
GunTempPtr = 0x591000
CenterPtr = 0x592000
CenterPtr2 = 0x592600
--
JYD = "Set Unit Order To: Junk Yard Dog"
--if Limit == 1 then
--    init_TestTable = {}
--    for i = 0, 227 do
--            table.insert(init_TestTable,SetMemoryX(0x664080+(i*4),SetTo,0x4,0x4))
--
--    end
--    DoActions2(FP,init_TestTable,1)
--end




function DoActionsP(Actions,PlayerID,flag)
return DoActions(PlayerID,Actions,flag)
end
function DoActionsPX(Actions,PlayerID,flag)
DoActionsX(PlayerID,Actions,flag)
end




GiveRate2 = {1000, 5000, 10000, 50000, 100000} 
Player = {"\x08P1","\x0EP2","\x0FP3","\x10P4","\x11P5"}
GiveUnitID = {64,65,66,67,61}
--GiveUnitID = {5,6,13,14,15}
BanToken = {80,69,70,60}
XSpeed = {"\x15#X0.5","\x05#X1.0","\x0E#X1.5","\x0F#X2.0","\x18#X2.5","\x10#X3.0","\x11#X3.5","\x08#X4.0","\x1C#X4.5","\x1F#X5.0"}
MarID = {0,1,16,99,100} 
Color = {"\x08","\x0E","\x0F","\x10","\x11"}
ColorCode = {0x08,0x0E,0x0F,0x10,0x11}
DifT = {"\x18Ｔｕｔｏｒｉａｌ \x0EＥａｓｙ","\x0EＥａｓｙ","\x08Ｈａｒｄ","\x10Ｆｕｔｕｒｅ","\x06Ｂｅｙｏｎｄ"}
GModeT = {"\x0E정식모드","\x08클래식모드","\x18EV MODE","\x10PURE MODE"}
P = {"\x081인","\x0E2인","\x0F3인","\x104인","\x115인"}
SpeedV = {0x2A,0x24,0x20,0x1D,0x19,0x15,0x11,0xC,0x8,0x4}
HumanPlayers = {0,1,2,3,4,128,129,130,131}
MapPlayers = {0,1,2,3,4}
ObPlayers = {128,129,130,131}
Ex1= {25,27,29,31,33}
Ex2= {23,26,29,32,35}
Ex3= {27,30,33,36,39}
Ex4= {15,17,19,21,23}
_0D = string.rep("\x0D",200)
_0D_1000B = string.rep("\x0D",1000)
UnivToString = "\x0D\x0D\x0D\x0D\x0D\x0DUniv".._0D_1000B
HTextStr = string.rep("\x0D",150)
EUDTurbo(P6)
SetForces({P1,P2,P3,P4,P5},{P6,P7,P8},{},{},{P1,P2,P3,P4,P5,P6,P7,P8})
SetFixedPlayer(P6)
StartCtrig()

CIf(AllPlayers,{ElapsedTime(AtLeast,3)})
Trigger { -- No comment (6496767D)
	players = {P6},
	actions = {
		SetDeaths(0,SetTo,0,0);
		SetDeaths(1,SetTo,0,0);
		SetDeaths(2,SetTo,0,0);
		SetDeaths(3,SetTo,0,0);
		SetDeaths(4,SetTo,0,0);
	},
}
--
CJump(AllPlayers,0)


ExDeaths1 = DefineDeathTable(0x1005) -- 확장 데스값 정의
CreateTableSet({ -- 테이블 정의
"MarHP","ShieldP","PExitCheck","Player_S","Player_0x18","Player_0x4D","Player_0x58","Player_0x5C","Player_T","Player_C","MarCount","PlayerDeaths","PlayerMarineListArr",
"PlayerMarineListHeader","PlayerMarCreateToken","MarListSkillLv","Marine","HMarine","LumMarine","Lumia","LumiaCT","ShieldT","PlayerScore","ATKExitText","ATKUpText1",
"ATKUpText2","MarStrPtr","HMarStrPtr","LumMarStrPtr","LumiaStrPtr","LumiaCTStrPtr","ATKExtStrPtr","ShTStrPtr","ATKUp1StrPtr","ATKUp2StrPtr","PScoreSTrPtr",
"BanCCode","Names","AtkUpgradePtrArr","AtkUpgradeMaskRetArr","initHDTable","initFTRTable","initBYDTable",
})

for i = 0, 4 do
	table.insert(MarHP,CreateVar())
	table.insert(ShieldP,CreateVar())
	table.insert(PExitCheck,CreateCCode(ExDeaths1))
	table.insert(Player_S,CreateVar())
	table.insert(Player_0x18,CreateVar())
	table.insert(Player_0x4D,CreateVar())
	table.insert(Player_0x58,CreateVar())
	table.insert(Player_0x5C,CreateVar())
	table.insert(Player_T,CreateVar())
	table.insert(Player_C,CreateVar())
	table.insert(MarCount,CreateVar())
	table.insert(PlayerDeaths,CreateVar())
--  table.insert(PlayerMarineListHeader,CreateVar())
	table.insert(PlayerMarineListArr,CArray(FP,602))
	table.insert(MarListSkillLv,CreateVar())
	table.insert(MarStrPtr,CreateVar())
	table.insert(HMarStrPtr,CreateVar())
	table.insert(LumMarStrPtr,CreateVar())
	table.insert(LumiaStrPtr,CreateVar())
	table.insert(LumiaCTStrPtr,CreateVar())
	table.insert(ShTStrPtr,CreateVar())
	table.insert(ATKExtStrPtr,CreateVar())
	table.insert(ATKUp1StrPtr,CreateVar())
	table.insert(ATKUp2StrPtr,CreateVar())
	table.insert(PScoreSTrPtr,CreateVar())
	Names[i+1] = CVArray(P6,7)
table.insert(AtkUpgradeMaskRetArr,(0x58D2B0+(i*46)+7)%4)
table.insert(AtkUpgradePtrArr,0x58D2B0+(i*46)+7 - AtkUpgradeMaskRetArr[i+1])
end
for i = 0, 3 do
	table.insert(BanCCode,CreateCCode(ExDeaths1))
end
CreateCCodeSet(ExDeaths1,{ -- Ccode 데스값 정의
"BGMOnOff","Test1","Test2","GiveRate","MarineHP","BGMType","IntroBGM","GameStart","IntroT","IntroT2","Difficulty","TestMode","TimerPenalty","TimerBonus","GameOver",
"HealT","LeaderBoardT","RandomBGM","ShieldUnlock","Ready","IntroT3","GMode","TimerPenaltySolo","TimerisDEAD","CanCT","CanC","TTCon1","TTCon2","TTAct1","TTAct2","TTAct3","TTAct4","TTFTR",
"XBackup","SkillT","Win","RecallT1","RecallT2","ArbT","GeneT","CoreAccept","CoreInbDis","BossBGM","BegginerT","EZCon","ShUsed","ShCool","Boss1Start","BunkerEnable","CoreCon1","CoreCon2",
"HDStart","LimitX","LimitC","CanWT","Print13","B3_Av","B4_Av","B5_Av","DarkReGen","EVMode","BYDBossStart","BYDDiff","C1","C2","C3","C4","PaneltyP","BonusP","ColorT","ColorC","QueenAv",
 "CJump_0x700","GModeTP","DifID","LastCan","ScorePrint","BYDBossP1","BYDAttackUpgrade","StoryT","ButtonSound","BYDBossStart2","MarineStackSystem","EffT","B7_Ph","WaveT","WaveC"
})
CreateVariableSet({ -- 변수 정의
"B6_C","RedNumber","ShP","RedNumberT","Panelty","TPanelty","Bonus","PaneltyTemp","Dx","Dy","Dt","Dv","Du","Time1","Cunit2","Cunit3","Speed","count","Ov_E","Ov_X","Ov_Y",
"B1_K","B2_K","B3_K","B3_K2","B4_K","B5_K","B2_X","B2_Y","B2_H","B2_P","B2_W","B2_HS","B2_SH","B4_P","B5_P","B5_A","B5_R","B5_X","B5_Y","B5_T","Dif","UIndex","UPtr","UEPD","UHP",
"Dis_1","Dis_2","CunitID","CunitHP","B1_H","B3_H","B4_H","B5_H","BackupCp","CPosX","CPosY","CPos","RandMarRemove","DmgRemain","UnitId","AMount_256","P1MarDeaths",
"Nextptrs","N_A1","N_A2","N_A3","N_A4","N_X","N_Y","L_X","L_Y","Sw1_On","Sw1_Off","B2_Pos","LXYPos","B2_LX","B2_LY","BonusTemp","PaneltyTemp2","B6_X","B6_Y","B6_R","B6_A",
"B6_A2","B6_K","B6_H","B6_T2","B3_HV","B3_HV2","B6_W","B6_Dif","B6_Dif2","B6_Dif3","B6_UC","HDEnd","HDEnd2","B6_T3","B6_RT","B6_T4","Time2","B6_C2","B6_T5","BackupPosData","PosSavePtr",
"WhileLaunch","SetPlayers","MaxHP","MaxHPP","UpgradeCP","UpgradeFactor","TempUpgradePtr","TempUpgradeMaskRet","UpgradeMax","UpResearched","UpCost","UpCompleted","AMount_V",
"BYD_C1","BYD_CTemp","VBdIndex","RandMineW","BYDMineX","BYDMineY","BYDLogic","RednumberSet","NexDif","NexAngle","ClearRate","LairHiveShapeNum","ExchangeRate","ExchangeP",
"P1Score","P2Score","P3Score","P4Score","P5Score","P1ScoreP","P3ScoreP","P2ScoreP","P5ScoreP","P4ScoreP","Ov_BYD_Index","Ov_BYD","ReadPosX","ReadPosY",
"B7_H","IndexCheck","N_A","S_N_R","Locs","B6_D","B6_T","P6BGM","DifScoreBonusV","ModeScoreBonusV","ScoreBonusV","UPCompStrPtr","XY","SY","SZ","SW","ObPlotVar","UnivStrPtr","HTextStrPtr",
"Height_V","Angle_V","CB_X","CB_Y","B6_5_M","B6_5_N","B6_5_A","B6_5_D","B6_5_T","RangeValue","ColorRandom","Nextptrs2","B6_DPase","B6_DPase2"
})

ExScore = {P1Score,P2Score,P3Score,P4Score,P5Score}
ExScoreP = {P1ScoreP,P2ScoreP,P3ScoreP,P4ScoreP,P5ScoreP}
UpCompTxt = CVArray(P6,5)
UpCompRet = CVArray(P6,5)
P1ScoreVA = CVArray(P6,13)
P2ScoreVA = CVArray(P6,13)
P3ScoreVA = CVArray(P6,13)
P4ScoreVA = CVArray(P6,13)
P5ScoreVA = CVArray(P6,13)
ExScoreVA = {P1ScoreVA,P2ScoreVA,P3ScoreVA,P4ScoreVA,P5ScoreVA}
B3_HT = CVArray(P6,4)
B3_HT2 = CVArray(P6,4)
MarIDV = CVArray(P6,5)
PlayerMarCreateToken = CVArray(P6,5)
HD = {Switch("Switch 201",Cleared),Switch("Switch 204",Cleared)}
FTR = {Switch("Switch 201",Set),Switch("Switch 204",Cleared)}
BYD = {Switch("Switch 201",Set),Switch("Switch 204",Set)}
NBYD = {Switch("Switch 204",Cleared)}
FTRBYD = {Switch("Switch 201",Set)}
Include_CtrigPlib(360,"Switch 100",1) -- 주기 : 360 = 360도 / Switch 100을 랜덤스위치로 사용 / f_Memcpy(Readcpy) 포함
HeroPointArr = {}
function CreateHeroPointArr(Index,Point,Name,Name2) --  영작 유닛 설정 함수
	local Text = "\x0D\x0D\x0D\x0D\x13\x1D† \x04기억의 "..Name2.." "..Name.." \x04를 처치하였습니다. \x1F+ "..Point.." \x1CＰｔｓ \x1D†\x0D\x0D\x0D\x0D\x14\x14\x14\x14\x14\x14\x14\x14"
	local Text2 = "\x0D\x0D\x0D\x0D\x13\x1D† ! \x04맵상에 아직 "..Name.." \x04이(가) 남아있습니다. \x1F- "..(Point/20).." \x1CＯｒｅ\x1D ! †\x0D\x0D\x0D\x0D\x14\x14\x14\x14\x14\x14\x14\x14"
	local X = {}
	table.insert(X,CreateCText(FP,Text))
	table.insert(X,CreateCText(FP,Text2))
	table.insert(X,Index)
	table.insert(X,Point) -- HPoint
	table.insert(HeroPointArr,X)
end
function InstallHeroPoint() -- CreateHeroPointArr에서 전송받은 영웅 포인트 정보 설치 함수. CunitCtrig 단락에 포함됨. 4213번 줄
	for i = 1, #HeroPointArr do
		local index = HeroPointArr[i][3]
		local Point = HeroPointArr[i][4]
		CIf(P6,Deaths(CurrentPlayer,Exactly,index,0,0xFF))
			DoActions(P6,MoveCp(Subtract,6*4))
			CIf(FP,DeathsX(CurrentPlayer,Exactly,6,0,0xFF))
				Call_SaveCp()
				f_MemCpy(P6,HTextStrPtr,_TMem(Arr(HeroPointArr[i][1][3],0),"X","X",1),HeroPointArr[i][1][2])
				Trigger {
					players = {P6},
					conditions = {
						Label(0);
					},
					actions = {
						SetScore(Force1,Add,Point,Kills);
						RotatePlayer({DisplayTextX(HTextStr,4),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP);
						SetCVar(FP,P1Score[2],Add,-(Point/1000));
						SetCVar(FP,P2Score[2],Add,-(Point/1000));
						SetCVar(FP,P3Score[2],Add,-(Point/1000));
						SetCVar(FP,P4Score[2],Add,-(Point/1000));
						SetCVar(FP,P5Score[2],Add,-(Point/1000));
						PreserveTrigger();
					},
				}
				f_MemCpy(P6,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
				Call_LoadCp()
			CIfEnd()
			DoActions(P6,MoveCp(Subtract,10*4))
			CIf(FP,{Deaths(P6,AtLeast,1,173),DeathsX(CurrentPlayer, AtLeast,1*65536,0,0xFF0000)})
				Call_SaveCp()
					f_MemCpy(P6,HTextStrPtr,_TMem(Arr(HeroPointArr[i][2][3],0),"X","X",1),HeroPointArr[i][2][2]-3)
				Call_LoadCp()
				Trigger {
					players = {P6},
					conditions = {
					},
					actions = {
						SetDeathsX(CurrentPlayer, SetTo,0*65536,0,0xFF0000);
						SetResources(Force1,Add,Point/20,Gas);
						RotatePlayer({DisplayTextX(HTextStr,4),PlayWAVX("staredit\\wav\\tap.ogg")},HumanPlayers,FP);
						PreserveTrigger();
					},
				}
				f_MemCpy(P6,HTextStrPtr,_TMem(Arr(HTextStrReset[3],0),"X","X",1),HTextStrReset[2])
				Call_LoadCp()
			CIfEnd()
			DoActions(P6,MoveCp(Add,16*4))
		CIfEnd()
		
		
	end
end
function Install_CText1(StrPtr,CText1,CText2,PlayerVArr)

	f_MemCpy(P6,StrPtr,_TMem(Arr(CText1[3],0),"X","X",1),CText1[2]-3)
	f_MovCpy(P6,_Add(StrPtr,CText1[2]),VArr(PlayerVArr,0),4*6)
	f_MemCpy(P6,_Add(StrPtr,CText1[2]+(4*6)+3),_TMem(Arr(CText2[3],0),"X","X",1),CText2[2])

end
HTextStrReset = CreateCText(FP,string.rep("\x0D",150))
StrReset = CreateCText(FP,UnivToString)
Str00 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x12\x02【 \x0d\x0d\x0d\x0d\x0d\x0d")
Str01 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04의 \x04Marine\x04이 \x16빛\x04을 \x04잃어버렸습니다. \x02】\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str02 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04의 \x1BH \x04Marine\x04이 \x16빛\x04을 \x04잃어버렸습니다. \x02】\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str04 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04의 \x06【 \x08Ｌ\x11ｕ\x03ｍ\x18ｉ\x0EＡ \x10】 \x04가 \x16빛\x04을 \x04잃어버렸습니다. \x02】\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str10 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x13\x03† \x04\x0d\x0d\x0d\x0d\x0d\x0d")
Str11 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04이(가) \x06【 \x08Ｌ\x11ｕ\x03ｍ\x18ｉ\x0EＡ \x10】 \x04를 \x19소환\x04하였습니다.  \x03†\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str12 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x12\x07『 \x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d")
Str13 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04이(가) \x1C빛의 보호막\x04을 사용했습니다. \x07』\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str14 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x13\x0d\x0d\x0d\x0d\x0d\x0d")
Str15 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04(이)가 게임에서 나갔습니다.\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str16 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04(이)가 \x03공격력 \x04업그레이드를 100까지 끝냈습니다.\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str17 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x04(이)가 \x03공격력 \x04업그레이드를 200까지 끝냈습니다.\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
Str18 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d")
Str19 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d \x03†")
Str22 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04 미네랄을 소비하여 총 \x0d\x0d\x0d\x0d\x0d\x0d")
Str23 = CreateCText(FP,"\x0d\x0d\x0d\x0d\x0d\x0d\x04 \x04회 업그레이드를 완료하였습니다. \x07』\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")

BStr01 = CreateCText(FP,"\x0D\x0D\x0D\x0D\x0D\x0D\x10【 \x11T\x04enebris\x10 】\x04: \x08\x0D\x0D\x0D\x0d\x0d\x0d")
Str03 = {}
for i = 0, 4 do
	table.insert(Str03,CreateCText(FP,"\x0d\x0d\x0d\x04의 "..Color[i+1].."L\x04uminous "..Color[i+1].."M\x04arine이 \x16빛\x04을 \x04잃어버렸습니다. \x02】\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14"))
end

WDWarpT = CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19좌측 하단 \x04지역 \x10【 W\x04arp \x10T\x04unnel \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
EUWarpT = CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19우측 상단 \x04지역 \x10【 W\x04arp \x10T\x04unnel \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
WUWarpT = CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F좌측 상단 \x04지역 \x10【 W\x04arp \x10T\x04unnel \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
EDWarpT = CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F우측 하단 \x04지역 \x10【 W\x04arp \x10T\x04unnel \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
NexCon1T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F좌측 상단 \x04지역 \x10【 N\x04exus \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
TemCon1T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F좌측 상단 \x04지역 \x10【 L\x04ost \x10C\04ivilization \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
NexCon2T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19우측 상단 \x04지역 \x10【 N\x04exus \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
TemCon2T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19우측 상단 \x04지역 \x10【 L\x04ost \x10C\04ivilization \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
NexCon3T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19좌측 하단 \x04지역 \x10【 N\x04exus \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
TemCon3T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19좌측 하단 \x04지역 \x10【 L\x04ost \x10C\04ivilization \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
NexCon4T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F우측 하단 \x04지역 \x10【 N\x04exus \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
TemCon4T= CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F우측 하단 \x04지역 \x10【 L\x04ost \x10C\04ivilization \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
AttackUnlock = CreateCText(FP,"\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x10【 P\x04ieces of a \x10D\x04ream\x10 】\x04을 모두 되찾았습니다.\n\x13\x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\x04의 \x07공격 \x04스킬이 \x17활성화\x04되었습니다. \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
BClearT1 = CreateCText(FP,"\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x14\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ｄ\x04ｉｖｉｄｅ\x10 】 \x04를 처치하였습니다.\n\x13\x04+ \x1F３００，０００ Ｐｔｓ\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．５\x04％ 〓\n\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
BClearT2 = CreateCText(FP,"\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x14\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ｔ\x04ｅｎｅｂｒｉｓ\x10 】 \x04를 처치하였습니다.\n\x13\x04+ \x1F３００，０００ Ｐｔｓ\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．５\x04％ 〓\n\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
BClearT4 = CreateCText(FP,"\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x14\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ａ\x04ｎｏｍａｌｙ\x10 】 \x04를 처치하였습니다.\n\x13\x04+ \x1F３００，０００ Ｐｔｓ\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．５\x04％ 〓\n\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")
BClearT3 = CreateCText(FP,"\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x14\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ｄ\x04ｅｍｉｓｅ\x10 】 \x04를 처치하였습니다.\n\x13\x04+ \x1F３００，０００ Ｐｔｓ\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．５\x04％ 〓\n\n\x13\x04！！！　\x07ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\x0d\x0d\x0d\x0d\x14\x14\x14\x14\x14\x14\x14\x14")


CreateHeroPointArr(77,55000,"\x1D【 F\x04enix \x1DZ 】","검사")
CreateHeroPointArr(78,55000,"\x1D【 F\x04enix \x1DD 】","용기병")
CreateHeroPointArr(71,110000,"\x10【 I\x04mperial \x10】","절대자")
CreateHeroPointArr(63,85000,"\x10【 N\x04ox \x10】","보주")
CreateHeroPointArr(67,100000,"\x10【 L\x04abyrinth \x10】","마법사")
CreateHeroPointArr(28,65000,"\x1D【 H\x04yperion \x1D】","전함")
CreateHeroPointArr(17,55000,"\x1D【 A\x04lan \x1DS\x04chezar\x1D 】","전투병기")
CreateHeroPointArr(19,75000,"\x10【 J\x04im \x10R\x04aynor \x10V 】","습격자")
CreateHeroPointArr(21,50000,"\x1D【 T\x04om \x1DK\x04azansky \x1D】","망령")
CreateHeroPointArr(86,70000,"\x1D【 P\x04robe \x1D】","은둔자")
CreateHeroPointArr(75,55000,"\x1D【 Z\x04eratul \x1D】","칼날")
CreateHeroPointArr(61,120000,"\x10【 D\x04arkness \x10】","그림자")
CreateHeroPointArr(88,55000,"\x1D【 A\x04rtanis \x1D】","정찰기")
CreateHeroPointArr(10,75000,"\x10【 F\x04lame \x10】","화염")
CreateHeroPointArr(25,50000,"\x1D【 E\x04dmund \x1DD\x04uke \x1D】","대포")
CreateHeroPointArr(29,95000,"\x10【 A\x04byss \x10】","심연")
CreateHeroPointArr(23,120000,"\x10【 D\x04iabolic \x10】","악마")
CreateHeroPointArr(76,60000,"\x1D【 T\x04assadar\x10/\x1DZ\x04eratul \x1D】","보옥")
CreateHeroPointArr(79,75000,"\x1D【 T\x04assadar \x1D】","불사자")
CreateHeroPointArr(81,85000,"\x1D【 W\x04arbringer \x1D】","로봇")
CreateHeroPointArr(162,100000,"\x10【 C\x04annon \x10】","포탑")
CreateHeroPointArr(98,98000,"\x10【 P\x04eace \x10】","학살자")
CreateHeroPointArr(68,200000,"\x10【 N\x04ought \x10】\x03","집행관")
CreateHeroPointArr(65,95000,"\x10【 D\x04esire \x10】","검제")
CreateHeroPointArr(66,98000,"\x10【 E\x04ternity \x10】","정화자")
CreateHeroPointArr(57,100000,"\x10【 L\x04owermost \x10】","노예")
CreateHeroPointArr(52,100000, "\x1D【 B\x04inary \x1D】","벌레")
CreateHeroPointArr(8,85000, "\x10【 P\x04olicy \x10】","유령")
CreateHeroPointArr(3,95000, "\x10【 V\x04icious \x10】","무법자")
CreateHeroPointArr(80,95000, "\x10【 V\x04ector \x10】","전투기")
CreateHeroPointArr(102,150000, "\x10【 C\x04onflict \x10】","대립자")
CreateHeroPointArr(60,570000, "\x1D【 \x06A\x04ntagonism \x1D】","적대자")

CVariable(AllPlayers,0x1000)
CVariable(AllPlayers,0x1001)
CVariable(AllPlayers,0x1002)
CVariable(AllPlayers,0x1003)
CVariable(AllPlayers,0x1004)

	BYDBossMarHPPatch = {}
	BYDBossMarHPRecover = {}
	for i=0,4 do
		table.insert(BYDBossMarHPPatch,SetMemory(0x662350 + (MarID[i+1]*4),SetTo,-130000*256))
		table.insert(BYDBossMarHPRecover,SetMemory(0x662350 + (MarID[i+1]*4),SetTo,130000*256))
	end
for i = 0, 0x4FF do
--  CVariable(AllPlayers,0x200+i)
end
--PlayerMarineListHeader = {GetVArray(V(0x200)),GetVArray(V(0x300)),GetVArray(V(0x400)),GetVArray(V(0x500)),GetVArray(V(0x600))}
MarListHeader = {CreateVar(),CreateVar(),CreateVar(),CreateVar(),CreateVar()}
UArr1 = CVArray(P6,16)
UArr2 = CVArray(P6,16)
UArr3 = CVArray(P6,30)



SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()

LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
SetCallEnd()

function Call_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function Call_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end

EnergyKill_CallIndex = SetCallForward()
SetCall(FP)
	CMov(FP,UnitId,_ReadF(_Add(BackupCp,25),0xFF))
	CIfX(FP,{TDeathsX(_Add(BackupCp,40),AtLeast,_Mul(Amount_V,_Mov(16777126)),0,0xFF000000)})
		CDoActions(FP,{TSetDeathsX(_Add(BackupCp,40),Subtract,_Mul(Amount_V,_Mov(16777126)),0,0xFF000000)})
		CElseX()
		CDoActions(FP,{TSetDeathsX(_Add(BackupCp,19),SetTo,0,0,0xFF00),TSetDeathsX(_Add(BackupCp,40),SetTo,255*16777216,0,0xFF000000)})
	CIfXEnd()
SetCallEnd()

function EnergyKill(Amount)
	CallTrigger(FP,EnergyKill_CallIndex,{SetCVar(FP,Amount_V[2],SetTo,Amount)})
end

PerDamage_CallIndex = SetCallForward()
SetCall(FP)
	f_Mul(FP,AMount_256,Amount_V,_Mov(256))
	CMov(FP,UnitId,_ReadF(_Add(BackupCp,25),0xFF))
	CSub(FP,DmgRemain,AMount_256,_ReadF(_Add(BackupCp,24)))
	CIfX(FP,{TDeaths(_Add(BackupCp,24),AtLeast,AMount_256,0)})
		CDoActions(FP,{TSetDeaths(_Add(BackupCp,24),Subtract,AMount_256,0)})
		CElseIfX({TDeaths(_Add(BackupCp,24),AtMost,AMount_256,0),TDeaths(_Add(BackupCp,2),AtLeast,_Mul(_Div(DmgRemain,_Mov(256)),_Div(_ReadF(_Add(UnitId,221179)),_Mov(1000))),0)})
		CDoActions(FP,{TSetDeaths(_Add(BackupCp,24),SetTo,0,0),TSetDeaths(_Add(BackupCp,2),Subtract,_Mul(_Div(DmgRemain,_Mov(256)),_Div(_ReadF(_Add(UnitId,221179)),_Mov(1000))),0)})
		CElseX()
		CDoActions(FP,{TSetDeathsX(_Add(BackupCp,19),SetTo,0,0,0xFF00)
		})
	CIfXEnd()
SetCallEnd()

function PerDamage(Amount)
	CallTrigger(FP,PerDamage_CallIndex,{SetCVar(FP,Amount_V[2],SetTo,Amount)})
end

GunPosSave_CallIndex = SetCallForward()
SetCall(FP)
	DoActions(FP,MoveCp(Subtract,15*4))
	SaveCp(FP,BackupPosData)
	DoActions(FP,MoveCp(Subtract,1*4))
	Call_SaveCp()
	CMov(FP,0x6509B0,EPD(MemoryPtr))
	NWhile(FP,{Deaths(CurrentPlayer,AtLeast,1,0),Deaths(EPD(0x6509B0),AtMost,EPD(MemoryPtr)+(MemoryPtrSize*50),0)},{SetMemory(0x6509B0,Add,MemoryPtrSize)})
	NWhileEnd()
	SaveCp(FP,PosSavePtr)
	CDoActions(FP,{
		TSetMemory(PosSavePtr,SetTo,_ReadF(BackupPosData,0xFFF0FFF)),
		TSetMemoryX(PosSavePtr,SetTo,_Mul(VBdIndex,_Mov(0x1000)),0xF000),
		TSetMemoryX(_Add(PosSavePtr,1),SetTo,_ReadF(BackupCp,0xFF0000),0xFF0000),
		SetCVar(FP,WhileLaunch[2],Add,1)
	})
	NIf(FP,{BYD})
		CMov(FP,0x6509B0,EPD(GunPtrMemory))
		NWhile(FP,{Deaths(CurrentPlayer,AtLeast,1,0),Deaths(EPD(0x6509B0),AtMost,EPD(GunPtrMemory)+200,0)},SetMemory(0x6509B0,Add,1))
		NWhileEnd()
		SaveCp(FP,PosSavePtr)

		CMov(FP,ReadPosX,_ReadF(BackupPosData,0xFFF))
		CMov(FP,ReadPosY,_Div(_ReadF(BackupPosData,0xFFF0000),_Mov(65536)))
		CDoActions(FP,{TSetMemory(PosSavePtr,SetTo,_ReadF(BackupPosData,0xFFF0FFF))})

		CTrigger(FP,{
			TMemoryX(_Add(BackupCP,16),Exactly,133,0xFF)
		},{
			TSetMemoryX(PosSavePtr,SetTo,0x10000000,0xF0000000)
		},1)
		CTrigger(FP,{
			CVar(FP,ReadPosX[2],AtMost,2048),
			CVar(FP,ReadPosY[2],AtMost,2048),
		},{
			TSetMemoryX(PosSavePtr,SetTo,0x1000,0xF000)
		},1)
		CTrigger(FP,{
			CVar(FP,ReadPosX[2],AtLeast,2048),
			CVar(FP,ReadPosY[2],AtMost,2048),
		},{
			TSetMemoryX(PosSavePtr,SetTo,0x2000,0xF000)
		},1)
		
		CTrigger(FP,{
			CVar(FP,ReadPosX[2],AtMost,2048),
			CVar(FP,ReadPosY[2],AtLeast,2048),
		},{
			TSetMemoryX(PosSavePtr,SetTo,0x3000,0xF000)
		},1)
		CTrigger(FP,{
			CVar(FP,ReadPosX[2],AtLeast,2048),
			CVar(FP,ReadPosY[2],AtLeast,2048),
		},{
			TSetMemoryX(PosSavePtr,SetTo,0x4000,0xF000)
		},1)
		
	NIfEnd()
	--CMov(FP,_Add(_Mul(CurrentArr,12),0x58D740),_Read(BackupPosData))



	Call_LoadCp()
	DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,0,0,0x00FF0000),MoveCp(Add,16*4)})
SetCallEnd()

OneClickUpgrade = SetCallForward()
SetCall(FP)
	f_Read(FP,TempUpgradePtr,UpResearched)
	CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
		f_Mod(FP,UpResearched,_Mul(TempUpgradeMaskRet,256))
	CIfEnd()
	f_Div(FP,UpResearched,TempUpgradeMaskRet)
	CMov(FP,0x6509B0,UpgradeCP)
	CJumpEnd(FP,UpResearched[2])
	NWhile(FP,{
		CVar(FP,UpResearched[2],AtMost,254),
		CVar(FP,UpgradeMax[2],AtLeast,1),
		TAccumulate(CurrentPlayer,AtLeast,_Mul(UpResearched,UpgradeFactor),Ore),
		TMemoryX(TempUpgradePtr,AtMost,_Mul(TempUpgradeMaskRet,254),_Mul(TempUpgradeMaskRet,255))
	})
		CDoActions(FP,{
			TSetCVar(FP,UpCost[2],Add,_Mul(UpResearched,UpgradeFactor)),
			TSetResources(CurrentPlayer,Subtract,_Mul(UpResearched,UpgradeFactor),Ore),
			SetCVar(FP,UpResearched[2],Add,1),
			SetCVar(FP,UpCompleted[2],Add,1),
			SetCVar(FP,UpgradeMax[2],Subtract,1),
			--TSetCVar(FP,UpCost[2],Add,_Mul(UpResearched,UpgradeFactor)),
			TSetMemoryX(TempUpgradePtr,Add,_Mul(TempUpgradeMaskRet,1),_Mul(TempUpgradeMaskRet,255))
		})
		CJump(FP,UpResearched[2])
	NWhileEnd()
	NJump(FP,0x24,CVar(FP,UpCompleted[2],Exactly,0),{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	ItoDec(FP,UpCost,VArr(UpCompTxt,0),2,0x1F,0)
	ItoDec(FP,UpCompleted,VArr(UpCompRet,0),2,0x19,0)
	_0DPatchforVArr(FP,UpCompRet,4)
	_0DPatchforVArr(FP,UpCompTxt,4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]-3),VArr(UpCompTxt,0),5*4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),VArr(UpCompRet,0),5*4)
	CDoActions(FP,{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x0D\x0D\x0DUPC".._0D,4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	NJumpEnd(FP,0x24)
	DoActionsX(FP,{
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,0),
		SetCVar(FP,TempUpgradePtr[2],SetTo,0),
		SetCVar(FP,UpResearched[2],SetTo,0),
		SetCVar(FP,UpCost[2],SetTo,0),
		SetCVar(FP,UpCompleted[2],SetTo,0)
	})
SetCallEnd()

function Call_GunPosSave(BdID,GunIndex)
	NIf(FP,DeathsX(CurrentPlayer,Exactly,BdID,0,0xFF))
		CallTrigger(FP,GunPosSave_CallIndex,{SetCVar(FP,VBdIndex[2],SetTo,GunIndex)})
	NIfEnd()
end


function CreateBullet(Height,Angle,X,Y)
CDoActions(FP,{
	TSetCVar(FP,Height_V[2],SetTo,Height),
	TSetCVar(FP,Angle_V[2],SetTo,Angle),
	TSetCVar(FP,CB_X[2],SetTo,X),
	TSetCVar(FP,CB_Y[2],SetTo,Y),
	SetNext("X",CallCBullet,0),SetNext(CallCBullet+1,"X",1)
})
	

end

CallCBullet = SetCallForward()
SetCall(FP)
CIf(FP,Memory(0x628438,AtLeast,1))
	f_Read(P6,0x628438,"X",Nextptrs2,0xFFFFFF)
	CAdd(FP,CB_Y,10)
	f_Mod(FP,Angle_V,_Mov(256))
	CDoActions(FP,{
		TSetMemoryX(0x66321C, SetTo, Height_V,0xFF),
		TSetMemory(0x58DC60 + 0x14*23,SetTo,CB_X),
		TSetMemory(0x58DC68 + 0x14*23,SetTo,CB_X),
		TSetMemory(0x58DC64 + 0x14*23,SetTo,CB_Y),
		TSetMemory(0x58DC6C + 0x14*23,SetTo,CB_Y),
		CreateUnit(1, 204, 24, P6)})
	CDoActions(FP,{
		TSetMemoryX(_Add(Nextptrs2,0x58/4),SetTo,_ReadF(_Add(Nextptrs2,(0x28/4))),0xFFFFFFFF),
		TSetMemoryX(_Add(Nextptrs2,0x20/4),SetTo,_Mul(Angle_V,256),0xFF00),
		TSetMemoryX(_Add(Nextptrs2,0x4C/4),SetTo,135*256,0xFF00),
		TSetMemoryX(_Add(Nextptrs2,40),SetTo,0,0xFF000000)
	})
CIfEnd()
SetCallEnd()



Call_RangeRandom = SetCallForward()
SetCall(FP)
CMov(FP,RangeValue,16*256)
CMov(FP,ColorRandom,0)
for i = 0, 6 do
	DoActions(FP,SetSwitch("Switch 100",Random))
	TriggerX(FP,{Switch("Switch 100",Set)},{SetCVar(FP,RangeValue[2],Add,((2^i)*256))},{Preserved})
end

for i = 0, 1 do
	DoActions(FP,SetSwitch("Switch 100",Random))
	TriggerX(FP,{Switch("Switch 100",Set)},{SetCVar(FP,ColorRandom[2],Add,(2^i))},{Preserved})
end

CDoActions(FP,{TSetMemoryX(0x6570C0, SetTo, RangeValue,0xFF00)})

ColorTable = {9,10,13,16}
for i = 0, 3 do
	
TriggerX(FP,{CVar(FP,ColorRandom[2],Exactly,i)},{SetMemoryX(0x66A1F8, SetTo, ColorTable[i+1]*256,0xFF00)},{Preserved})
end

SetCallEnd()

CJumpEnd(AllPlayers,0)
Enable_PlayerCheck()
NoAirCollisionX(P6)
DtP = CreateVar()



--CTrigPlibStart : beforeTriggerExec

CMov(P6,Dx,_ReadF(0x51CE8C))
CiSub(P6,Dy,_Mov(0xFFFFFFFF),Dx)
CiSub(P6,DtP,Dy,Du)
CMov(P6,Dv,DtP)
CMov(P6,0x58F500,DtP)


CIfX(P6,PlayerCheck(P1,1))
	CMov(P6,Dt,_ReadF(0x58A364+48*180+4*0))--
	f_Read(P6,0x6284E8,Cunit2)
	Trigger {
		players = {P6},
		conditions = {
			Command(0,AtMost,0,219);
			Command(AllPlayers,AtLeast,1,219);  
		},
		actions = {
			GiveUnits(All,219,AllPlayers,"Anywhere",0);
		}
	}
	
	CElseIfX(PlayerCheck(P2,1))
	CMov(P6,Dt,_ReadF(0x58A364+48*180+4*1))
	f_Read(P6,0x628518,Cunit2)
	Trigger {
		players = {P6},
		conditions = {
			Command(1,AtMost,0,219);
			Command(AllPlayers,AtLeast,1,219);  
		},
		actions = {
			GiveUnits(All,219,AllPlayers,"Anywhere",1);
		}
	}
	
	CElseIfX(PlayerCheck(P3,1))
	CMov(P6,Dt,_ReadF(0x58A364+48*180+4*2))
	f_Read(P6,0x628548,Cunit2)
	Trigger {
		players = {P6},
		conditions = {
			Command(2,AtMost,0,219);
			Command(AllPlayers,AtLeast,1,219);  
		},
		actions = {
			GiveUnits(All,219,AllPlayers,"Anywhere",2);
		}
	}
	
	CElseIfX(PlayerCheck(P4,1))
	CMov(P6,Dt,_ReadF(0x58A364+48*180+4*3))
	f_Read(P6,0x628578,Cunit2)
	Trigger {
		players = {P6},
		conditions = {
			Command(3,AtMost,0,219);
			Command(AllPlayers,AtLeast,1,219);  
		},
		actions = {
			GiveUnits(All,219,AllPlayers,"Anywhere",3);
		}
	}
	
	CElseIfX(PlayerCheck(P5,1))
	CMov(P6,Dt,_ReadF(0x58A364+48*180+4*4))
	f_Read(P6,0x6285A8,Cunit2)
	Trigger {
		players = {P6},
		conditions = {
			Command(4,AtMost,0,219);
			Command(AllPlayers,AtLeast,1,219);  
		},
		actions = {
			GiveUnits(All,219,AllPlayers,"Anywhere",4);
		}
	}
	
CIfXEnd()
CSub(P6,0x58F494,Dt)
CIfOnce(P6,{CVar(FP,Dt[2],AtLeast,10000)})
	CMov(P6,Dt,0)
CIfEnd()
for i = 0,4 do
	CIfX(P6,PlayerCheck(i,1))
		CDoActions(P6,{TSetDeathsX(i,Subtract,Dt,440,0xFFFFFF)})
		CSub(P6,0x58F4B0+(i*4),Dt)
		CElseX()
		DoActions(P6,{SetDeathsX(i,SetTo,0,440,0xFFFFFF)})
	CIfXEnd()
end
RedNumberX = CreateVar()
RedNumberX = {FP,RedNumberX[2],nil,"V"}


CIf(P6,Switch("Switch 203",Set))
	CIf(P6,{CVar(FP,Dt[2],AtMost,2500)})

		CIf(P6,{CVar(FP,HDEnd2[2],AtMost,5180)})
			CAdd(P6,Time1,Dt)
			CSub(P6,0x58F460,Dt)
		CIfEnd()
		CAdd(P6,Time2,Dt)
		CAdd(P6,RedNumberT,Dt)

		CAdd(P6,_CCode("X",WaveT),Dt)

		
		
		UnitReadX(P6,AllPlayers,229,64,count)
		CMov(P6,0x58F554,count)
		CMov(P6,0x58F570,ClearRate)
		ClearRatePtr = 0x58F570
		CIfX(P6,{Memory(0x58F554,AtLeast,1500),CDeaths(P6,AtMost,0,HDStart)})
	   
			CAdd(P6,0x58F558,Dt)
			CElseX()
			CMov(P6,0x58F558,0)
		CIfXEnd()
	CIfEnd()

	CMov(P6,0x582204+(4*5),count)
	CAdd(P6,0x582204+(4*5),count)
	CMov(P6,0x57F0F0+(4*5),0)
	CMov(P6,0x57F120+(4*5),0)
	CMov(P6,0x58F45C,Time1)
	CMov(P6,0x590000,Time1)
	CMov(P6,0x590004,Time1)

	for i = 6, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590004,AtLeast,(2^i)*3600000);
			},
			actions = {
				SetMemory(0x57F0F0+(4*5),Add,(2^i)*10000);
				SetMemory(0x590004,Subtract,(2^i)*3600000);
				PreserveTrigger();
			}
		}
	end
	for i = 6, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590004,AtLeast,(2^i)*60000);
			},
			actions = {
				SetMemory(0x57F0F0+(4*5),Add,(2^i)*100);
				SetMemory(0x590004,Subtract,(2^i)*60000);
				PreserveTrigger();
			}
		}
	end
	for i = 6, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590004,AtLeast,(2^i)*1000);
			},
			actions = {
				SetMemory(0x57F0F0+(4*5),Add,(2^i));
				SetMemory(0x590004,Subtract,(2^i)*1000);
				PreserveTrigger();
			}
		}
	end
	if Limit == 1 then

	CMov(FP,0x58F700,_ReadF(0x57F0F0+(4*5)))
	end
	CMov(P6,RedNumberX,_Sub(RednumberSet,{FP,RedNumber[2],nil,"V"}))
	CMov(P6,0x58F60C,RedNumberX)
	CMov(P6,0x590008,RedNumberX)

	for i = 9, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590008,AtLeast,(2^i));
			},
			actions = {
				SetMemory(0x57F120+(4*5),Add,(2^i)*1);
				SetMemory(0x590008,Subtract,(2^i));
				PreserveTrigger();
			}
		}
	end
	
	CIf(FP,{CVar(FP,Cunit2[2],AtLeast,1)})
		f_EPD(FP,Cunit3,Cunit2)
		SetRecoverCp(Cunit3)
		RecoverCp(FP)
		CIfX(FP,{CDeaths(FP,AtLeast,1,TestMode),Deaths(P1,AtLeast,1,203),Switch("Switch 200",Cleared)})
			DoActions(FP,MoveCp(Add,25*4))
			Trigger {
				players = {FP},
				conditions = {
					DeathsX(CurrentPlayer,AtMost,57,0,0xFF);
				},
				actions = {
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
					PreserveTrigger();
				}
			}
			Trigger {
				players = {FP},
				conditions = {
					DeathsX(CurrentPlayer,AtLeast,59,0,0xFF);
				},
				actions = {
					MoveCp(Subtract,6*4);
					SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
					MoveCp(Add,6*4);
					PreserveTrigger();
				}
			}
			DoActions(FP,{MoveCp(Subtract,25*4),SetSwitch("Switch 200",Set)})
			CElseIfX(Deaths(P1,AtMost,0,203))
			DoActions(FP,{SetSwitch("Switch 200",Clear)})
		CIfXEnd()
		DoActions(FP,MoveCp(Add,0x64))
		CIf(FP,{Deaths(CurrentPlayer,Exactly,219,0)})
			DoActions(FP,MoveCp(Subtract,0x3C))
			Call_SaveCp()
			f_ReadX(FP,0x5124F0,Speed,0x1,0xFF)
			Call_LoadCp()
			for i = 0, 9 do
				CIf(FP,{DeathsX(CurrentPlayer,AtLeast,2848+(32*i),0,0xFFFF),DeathsX(CurrentPlayer,AtMost,2848+(32*(i+1)),0,0xFFFF),TTCVar(FP,Speed[2],"!=",SpeedV[i+1])})
					Call_SaveCp()
					Trigger { -- No comment (E93EF7A9)
						players = {FP},
						actions = {PreserveTrigger();
							RotatePlayer({PlayWAVX("staredit\\wav\\sel_m.ogg"),DisplayTextX("\x13\x07『 \x0F배속 변경 \x10- "..XSpeed[i+1].." \x07』", 0)},HumanPlayers,FP);
							SetMemory(0x5124F0,SetTo,SpeedV[i+1]);
						},
					}
					
					Call_LoadCp()
				CIfEnd()
			end
		CIfEnd()
	CIfEnd()
CIfEnd()
SetRecoverCp()
RecoverCp(FP)
CMov(P6,Du,Dy)

-- 감염된커맨드 건작부분
-- CenterPtr
CIf(P6,MemoryX(0x58F450,AtLeast,1,0xFF))
	CIfX(P6,{CVar(FP,N_A1[2],AtMost,359)})
		CIf(P6,{Memory(0x628438,AtLeast,1)})
			f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
			CIf(FP,BYD)
				CDoActions(FP,{TSetMemory(_Add(N_A1,EPD(CenterPtr)),SetTo,Nextptrs)})
			CIfEnd()
			f_Lengthdir(P6,2000,N_A1,N_X,N_Y)
			f_Lengthdir(P6,2000,_Add(N_A1,180),L_X,L_Y)
			Simple_SetLocX(P6,23,_Add(L_X,2048-32),_Add(L_Y,2048-32),_Add(L_X,2048+32),_Add(L_Y,2048+32))
			Trigger {
				players = {FP},
				conditions = {
					HD;
				},
				actions = {
					CreateUnitWithProperties(1,88,24,P6,{invincible = true});
					PreserveTrigger();
				}
			}
			Trigger {
				players = {FP},
				conditions = {
					FTR;
				},
				actions = {
					CreateUnitWithProperties(1,80,24,P6,{invincible = true});
					PreserveTrigger();
				}
			}
			Trigger {
				players = {FP},
				conditions = {
					BYD;
				},
				actions = {
					CreateUnitWithProperties(1,98,24,P6,{invincible = true});
					PreserveTrigger();
				}
			}
			CDoActions(P6,{
				TSetDeaths(_Add(Nextptrs,13),SetTo,1,0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,1,0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeathsX(_Add(Nextptrs,22),SetTo,_Add(N_X,2048),0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,22),SetTo,_Mul(_Add(N_Y,2048),65536),0,0xFFFF0000)
				})
			CAdd(P6,N_A1,1)
		CIfEnd()
	CIfXEnd()
	CIfX(P6,{CVar(FP,N_A1[2],Exactly,360)})
		DoActions(P6,{SetMemoryX(0x58F454,SetTo,1,0xFF)})
		
		CIf(FP,BYD)
			CMov(FP,BYD_C1,0)
			CMov(FP,0x6509B0,EPD(CenterPtr))
			CWhile(FP,Memory(0x6509B0,AtMost,EPD(CenterPtr)+359))
				CAdd(FP,BYD_C1,6)
				Call_SaveCp()
				f_Read(FP,BackupCp,BYD_CTemp)
				CIf(FP,CVar(FP,BYD_CTemp[2],AtLeast,1))
					CDoActions(P6,{
						TSetDeaths(_Add(BYD_CTemp,13),SetTo,BYD_C1,0),
						TSetDeathsX(_Add(BYD_CTemp,18),SetTo,BYD_C1,0,0xFFFF),
						})
				CIfEnd(SetCVar(FP,BYD_CTemp[2],SetTo,0))
				Call_LoadCp()
				CAdd(FP,0x6509B0,1)
			CWhileEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
	CIfXEnd()
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CVar(FP,N_A1[2],AtLeast,360);
	},
		actions = {
			SetCVar(FP,N_A1[2],Add,1);
			PreserveTrigger();
		}
	}
	
	CIfX(P6,{CVar(FP,N_A1[2],AtLeast,860)})
		DoActions(P6,{Simple_SetLoc(23,2048,2048,2048,2048)})
		CIf(FP,CDeaths(P6,AtLeast,1,HDStart))
			CreateUnitLineSafeGun(P6,{FTR},60,23,32,32,0,4,1,P8,{1,88})
		CIfEnd()
		CreateUnitLineSafeGun(P6,{BYD},30,23,32,64,0,4,1,P8,{1,57}) -- Radius 64로 수정할것
		DoActions(P6,{
			GiveUnits(All,88,P6,"Anywhere",P8),
			GiveUnits(All,80,P6,"Anywhere",P8),
			GiveUnits(All,98,P6,"Anywhere",P8),
			SetInvincibility(Disable,88,P8,"Anywhere"),
			SetInvincibility(Disable,80,P8,"Anywhere"),
			SetInvincibility(Disable,98,P8,"Anywhere"),
			SetMemory(0x6509B0,SetTo,7),
			RunAIScriptAt(JYD,"Anywhere"),
			SetMemory(0x6509B0,SetTo,5)
		})
		DoActions(P6,{SetMemoryX(0x58F450,SetTo,1*256,0xFF00),SetMemoryX(0x58F450,SetTo,0,0xFF)})
		CMov(P6,N_A1,0)
	CIfXEnd()
CIfEnd()

CIf(P6,MemoryX(0x58F450,AtLeast,1*65536,0xFF0000))
	CIfX(P6,{CVar(FP,N_A2[2],AtMost,359)})
		CIf(P6,{TMemory(0x628438,AtLeast,1)})
			f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
			
			CIf(FP,BYD)
				CDoActions(FP,{TSetMemory(_Add(N_A2,EPD(CenterPtr2)),SetTo,Nextptrs)})
			CIfEnd()
			f_Lengthdir(P6,2000,_Add(N_A2,180),N_X,N_Y)
			f_Lengthdir(P6,2000,N_A2,L_X,L_Y)
			Simple_SetLocX(P6,23,_Add(L_X,2048-32),_Add(L_Y,2048-32),_Add(L_X,2048+32),_Add(L_Y,2048+32))
			Trigger {
				players = {FP},
				conditions = {
					HD;
				},
				actions = {
					CreateUnitWithProperties(1,21,24,P6,{invincible = true});
					PreserveTrigger();
				}
			}
			Trigger {
				players = {FP},
				conditions = {
					FTR;
				},
				actions = {
					CreateUnitWithProperties(1,8,24,P6,{invincible = true});
					PreserveTrigger();
				}
			}
			Trigger {
				players = {FP},
				conditions = {
					BYD;
				},
				actions = {
					CreateUnitWithProperties(1,22,24,P6,{invincible = true});
					PreserveTrigger();
				}
			}
			
			CDoActions(P6,{
				TSetDeaths(_Add(Nextptrs,13),SetTo,1,0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,1,0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeathsX(_Add(Nextptrs,22),SetTo,_Add(N_X,2048),0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,22),SetTo,_Mul(_Add(N_Y,2048),65536),0,0xFFFF0000),
			})
			CAdd(P6,N_A2,1)
		CIfEnd()
	CIfXEnd()
	CIf(P6,{CVar(FP,N_A2[2],Exactly,360)})
		DoActions(P6,{SetMemoryX(0x58F454,SetTo,1*65536,0xFF0000)})
		
		CIf(FP,BYD)
			CMov(FP,BYD_C1,0)
			CMov(FP,0x6509B0,EPD(CenterPtr2))
			CWhile(FP,Memory(0x6509B0,AtMost,EPD(CenterPtr2)+359))
				CAdd(FP,BYD_C1,6)
				Call_SaveCp()
				f_Read(FP,BackupCp,BYD_CTemp)
				CIf(FP,CVar(FP,BYD_CTemp[2],AtLeast,1))
					CDoActions(P6,{
						TSetDeaths(_Add(BYD_CTemp,13),SetTo,BYD_C1,0),
						TSetDeathsX(_Add(BYD_CTemp,18),SetTo,BYD_C1,0,0xFFFF),
					})
				CIfEnd(SetCVar(FP,BYD_CTemp[2],SetTo,0))
				Call_LoadCp()
				CAdd(FP,0x6509B0,1)
			CWhileEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
	
	
	CIfEnd()
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			CVar(FP,N_A2[2],AtLeast,360)
	},
		actions = {
			SetCVar(FP,N_A2[2],Add,1);
			PreserveTrigger();
			
	}
	}
	
	CIf(P6,{CVar(FP,N_A2[2],AtLeast,860)})
		DoActions(P6,{Simple_SetLoc(23,2048,2048,2048,2048)})
		CIf(FP,CDeaths(P6,AtLeast,1,HDStart))
			CreateUnitLineSafeGun(P6,{FTR},60,23,32,32,0,4,1,P8,{1,21})
		CIfEnd()
		CreateUnitLineSafeGun(P6,{BYD},30,23,32,64,0,4,1,P8,{1,86}) -- Radius 64로 수정할것
		DoActions(P6,{
			GiveUnits(All,21,P6,"Anywhere",P8),
			GiveUnits(All,8,P6,"Anywhere",P8),
			GiveUnits(All,22,P6,"Anywhere",P8),
			SetInvincibility(Disable,21,P8,"Anywhere"),
			SetInvincibility(Disable,8,P8,"Anywhere"),
			SetInvincibility(Disable,22,P8,"Anywhere"),
			SetMemory(0x6509B0,SetTo,7),
			RunAIScriptAt(JYD,"Anywhere"),
			SetMemory(0x6509B0,SetTo,5)
		})
		
		
		DoActions(P6,{SetMemoryX(0x58F450,SetTo,1*16777216,0xFF000000),SetMemoryX(0x58F450,SetTo,0,0xFF0000)})
		Trigger {
			players = {P6},
			conditions = {
				Bring(P6,AtLeast,1,12,64);
		},
			actions = {
				Order(21,P8,"Anywhere",Attack,64);
				Order(8,P8,"Anywhere",Attack,64);
				PreserveTrigger();
		},
		}
		CMov(P6,N_A2,0)
	CIfEnd()
CIfEnd()

--보스몹, 특수건물 체력부분

DoActionsX(P6,{
	SetCDeaths(P6,SetTo,0,B3_Av),
	SetCDeaths(P6,SetTo,0,B4_Av),
	SetCDeaths(P6,SetTo,0,B5_Av),
	SetCDeaths(P6,SetTo,0,QueenAv),
})

--CUnit인식용 보스 존재 여부 트리거
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Command(P6,AtLeast,1,30);
},
	actions = {
		SetCDeaths(P6,SetTo,1,B4_Av);
		PreserveTrigger();
},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Command(P6,AtLeast,1,2);
},
	actions = {
		SetCDeaths(P6,SetTo,1,B5_Av);
		PreserveTrigger();
},
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,BYDBossP1);
		Bring(Force2,AtLeast,1,128,64);
},
	actions = {
		SetCDeaths(P6,SetTo,1,B5_Av);
		PreserveTrigger();
	}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Command(Force2,AtLeast,1,57);
},
	actions = {
		SetCDeaths(P6,SetTo,1,QueenAv);
		PreserveTrigger();
},
}


CIfX(P6,{CVar(FP,B1_H[2],AtLeast,1)})
	CIf(P6,{TMemory(B1_H,AtMost,4000000*256),CVar(FP,B1_K[2],AtLeast,1)})
		CIfX(P6,{CVar(FP,B1_K[2],AtLeast,4000001)})
			CDoActions(P6,{TSetMemory(B1_H,Add,4000000*256),SetDeaths(P10,Add,1,0x91),SetCVar(FP,B1_K[2],Subtract,4000000)})
			CElseIfX({CVar(FP,B1_K[2],AtMost,4000000)})
			CDoActions(P6,{TSetMemory(B1_H,Add,_Mul(B1_K,256),SetDeaths(P10,Add,2,0x91))})
			CMov(P6,B1_K,0)
		CIfXEnd()
	CIfEnd()
	CIf(P6,{Deaths(8,AtLeast,1,64)})
		CDoActions(P6,{TSetDeaths(_Add(B1_H,11),SetTo,1,0),TSetDeathsX(_Add(B1_H,16),SetTo,1,0,0xFFFF)})
	CIfEnd()
	CTrigger(P6,{TMemoryX(_Add(B1_H,17),Exactly,0,0xFF00)},{SetCVar(P6,B1_H[2],SetTo,0)},1)
CIfXEnd()

CIf(P6,CVar(P6,Dis_1[2],AtLeast,1))
	CTrigger(P6,{TMemory(Dis_1,AtMost,8000000*256)},{TSetMemory(Dis_1,Add,70000*256)},1)
	CTrigger(P6,{TMemory(Dis_1,AtMost,1000000*256)},{SetCVar(FP,Dis_1[2],SetTo,0),RemoveUnit(190,P7)},1)
	CTrigger(P6,{TMemory(_Add(Dis_1,17),Exactly,0*256,0xFF00)},{SetCVar(FP,Dis_1[2],SetTo,0)},1)
CIfEnd()

CIf(P6,CVar(P6,Dis_2[2],AtLeast,1))
	CTrigger(P6,{TMemory(Dis_2,AtMost,8000000*256)},{TSetMemory(Dis_2,Add,70000*256)},1)
	CTrigger(P6,{TMemory(Dis_2,AtMost,1000000*256)},{SetCVar(FP,Dis_2[2],SetTo,0),RemoveUnit(190,P8)},1)
	CTrigger(P6,{TMemory(_Add(Dis_2,17),Exactly,0*256,0xFF00)},{SetCVar(FP,Dis_2[2],SetTo,0)},1)
CIfEnd()

B2_P2 = CreateVar()
Overflow_HP_System(FP,B2_H,B2_K,nil)

CIfX(P6,{CVar(FP,B2_H[2],AtLeast,1)})
	CIf(P6,Command(P6,AtLeast,1,87))
		CMov(P6,B2_Pos,_ReadF(_Add(B2_H,8)))
		CDoActions(P6,{TSetDeaths(_Add(B2_H,11),SetTo,1,0),TSetDeathsX(_Add(B2_H,16),SetTo,1,0,0xFFFF),SetCVar(FP,B2_W[2],SetTo,2)})
		CIf(P6,{CVar(FP,B2_P[2],AtMost,0)})
			CWhile(P6,{CVar(FP,B2_W[2],AtLeast,1)},{SetCVar(FP,B2_W[2],Subtract,1)})
				CIf(P6,{Memory(0x628438,AtLeast,1)})
					f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
					CIfX(FP,NBYD)
						CAdd(P6,B2_HS,_Mod(_Rand(),4000),300)
					CelseIfX(BYD)
						CIfX(FP,CVar(FP,B2_P2[2],Exactly,0))
							CAdd(P6,B2_HS,_Mod(_Rand(),1000),0)
						CelseIfX(CVar(FP,B2_P2[2],Exactly,1))
							CAdd(P6,B2_HS,_Mod(_Rand(),4000),2000)
						CIfXEnd()
					CIfXEnd()
					CMul(P6,B2_SH,_Add(_Mod(_Rand(),200),50),256)
					TriggerX(FP,{BYD,CVar(FP,B2_P2[2],Exactly,1)},{SetMemoryX(0x669E9C,SetTo,16,0xFF)},{Preserved})
					CDoActions(P6,{
						MoveLocation(24,87,P6,"Anywhere"),
						CreateUnit(1,180,24,P6),

						SetMemoryX(0x663204, SetTo, 0,0xFF);
						CreateUnitWithProperties(1,180,24,P8,{hallucinated = true}),
						SetMemoryX(0x663204, SetTo, 20,0xFF);

						SetMemoryX(0x669E9C,SetTo,0,0xFF),
						KillUnit(180,P8),
						TSetDeaths(_Add(Nextptrs,2),SetTo,B2_SH,0),
						TSetDeaths(_Add(Nextptrs,13),SetTo,B2_HS,0),
						TSetDeathsX(_Add(Nextptrs,18),SetTo,B2_HS,0,0xFFFF),
						Order(180,P6,"Anywhere",Move,24)
					})
				CIfEnd()
			CWhileEnd()
		CIfEnd()
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				BYD;
				CVar(FP,B2_P[2],Exactly,0);
		},
			actions = {
				SetInvincibility(Enable,87,P6,64);
		},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				BYD;
				CVar(FP,B2_P[2],AtLeast,1);
		},
			actions = {
				SetInvincibility(Disable,87,P6,64);
				PreserveTrigger();
		},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CVar(FP,B2_P[2],Exactly,0);
				Bring(P6,AtLeast,500,180,"Anywhere");
		},
			actions = {
				SetCVar(FP,B2_P[2],SetTo,1);
				SetCVar(FP,B2_P2[2],Add,1);
				
				PreserveTrigger();
		},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CVar(FP,B2_H[2],AtLeast,1);
				CVar(FP,B2_P[2],Exactly,50);
		},
			actions = {
				RunAIScriptAt(JYD,"Anywhere");
				
				PreserveTrigger();
		},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CVar(FP,B2_P2[2],AtLeast,2);
		},
			actions = {
				SetCVar(FP,B2_P2[2],SetTo,0);
				PreserveTrigger();
		},
		}
		 Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Bring(P6,AtMost,0,180,"Anywhere");
		},
			actions = {
				SetCVar(FP,B2_P[2],SetTo,0);
				PreserveTrigger();
		},
		}
	CIfEnd()
	CElseifX(CDeaths(P6,AtMost,0,HDStart))
	DoActions(P6,KillUnit(180,AllPlayers))
CIfXEnd()

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CVar(FP,B2_P[2],AtLeast,1);
},
	actions = {
		SetCVar(FP,B2_P[2],Add,1);
		PreserveTrigger();
},
}
B3_P = CreateVar()
Overflow_HP_SystemX(FP,B3_H,B3_K,B3_K2,B3_P)
CIfX(P6,Command(P6,AtLeast,1,74))


	DoActions(FP,RotatePlayer({RunAIScript("Turn OFF Shared Vision for Player 6")},MapPlayers,FP))
	Trigger2(P6, {Command(P6,AtMost,49,"【 Darkness 】")}, {SetInvincibility(Disable,74,P6,"Anywhere")}, {Preserved})
	Trigger2(P6, {Command(P6,AtLeast,50,"【 Darkness 】")}, {SetInvincibility(Enable,74,P6,"Anywhere")}, {Preserved})
	CIf(P6,FTRBYD)
		DoActions(P6,{
			Simple_SetLoc(23,0,0,0,0),
			MoveLocation(24,"【 Tenebris 】",P6,"Anywhere"),
			Simple_CalcLoc(23,-8,8,-8,8),
			Order(49,P6,64,Move,24)
		})
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Bring(P6,AtLeast,1,49,24);
				FTR;
			},
			actions = {
				KillUnitAt(1,49,24,P6);
				RotatePlayer({PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")},HumanPlayers,FP);
				SetCVar(P6,B3_K[2],Add,1000000);
				PreserveTrigger();
			}
		}
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Bring(P6,AtLeast,1,49,24);
				BYD;
			},
			actions = {
				KillUnitAt(1,49,24,P6);
				RotatePlayer({PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")},HumanPlayers,FP);
				SetCVar(P6,B3_K[2],Add,30000000);
				SetCDeaths(P6,Subtract,3,DarkReGen);
				PreserveTrigger();
			}
		}
	CIfEnd()

	-- 다크보스스킬 스캔약화
	CMov(FP,0x6509B0,19025+25)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+25 + (84*1699)))
		CIf(FP,DeathsX(CurrentPlayer,Exactly,33,0,0xFF))
			DoActions(P6,{MoveCp(Subtract,6*4)})
			CIf(FP,DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00))
				DoActions(P6,{MoveCp(Add,50*4)})
				CIf(P6,DeathsX(CurrentPlayer,AtMost,0,0,0xFF00))
					DoActions(P6,{SetDeathsX(CurrentPlayer,SetTo,6*256,0,0xFF00)})
					Trigger2(FP,{BYD},{SetDeathsX(CurrentPlayer,SetTo,9*256,0,0xFF00)},{Preserved})
					CIf(P6,FTRBYD)
						DoActions(P6,MoveCp(Subtract,59*4))
						Call_SaveCp()
						CMov(P6,CPos,_ReadF(BackupCp))
						CMov(P6,CPosX,_Mov(CPos,0xFFFF))
						CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
						Simple_SetLocX(P6,23,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,49,24,P6)})
						Points = 6
						SizeofPolygon = 1
						Radius = 256
						Angle = 0
						--CreateUnitPolygonSafe2Gun(FP,{BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P6,{1,49})
						Call_LoadCp()
						DoActions(P6,MoveCp(Add,59*4))
					CIfEnd()
				CIfEnd()
				NIf(P6,DeathsX(CurrentPlayer,Exactly,1*256,0,0xFF00))
					DoActions(P6,{
						MoveCp(Subtract,50*4),
						SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFF00),
						MoveCp(Add,50*4)})
				NIfEnd()
				DoActions(P6,{MoveCp(Subtract,50*4)})
			CIfEnd()
			DoActions(P6,{MoveCp(Add,6*4)})
		CIfEnd()
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
CelseX()
DoActions(FP,RotatePlayer({RunAIScript("Turn ON Shared Vision for Player 6")},MapPlayers,FP))
CIfXEnd()
CIf(FP,CVar(FP,B3_P[2],AtLeast,1),SetCVar(FP,B3_P[2],Subtract,1))
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			Command(P6,AtLeast,1,"【 Tenebris 】");
			CDeaths(P6,AtMost,9,DarkReGen);
			HD;
		},
		actions = {
			Simple_SetLoc(23,2048-16,2048-16,2048+16,2048+16);
			MoveLocation(24,74,P6,64);
			SetMemory(0x662350+(61*4), SetTo, 256000000);
			CreateUnit(8,61,24,P6), -- 체력 약화 후 소환할것
			SetMemory(0x662350+(61*4), SetTo, 1706666496);
			CreateUnit(1,84,24,P6);
			SetCDeaths(P6,Add,1,DarkReGen);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			Command(P6,AtLeast,1,"【 Tenebris 】");
			CDeaths(P6,AtMost,9,DarkReGen);
			FTR;
		},
		actions = {
			Simple_SetLoc(23,2048-16,2048-16,2048+16,2048+16);
			MoveLocation(24,74,P6,64);
			SetMemory(0x662350+(61*4), SetTo, 256000000);
			CreateUnit(8,61,24,P6), -- 체력 약화 후 소환할것
			SetMemory(0x662350+(61*4), SetTo, 1706666496);
			SetCDeaths(P6,Add,1,DarkReGen);
			CreateUnit(1,84,24,P6),
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			Command(P6,AtLeast,1,"【 Tenebris 】");
			CDeaths(P6,AtMost,15,DarkReGen);
			BYD;
		},
		actions = {
			Simple_SetLoc(23,2048-16,2048-16,2048+16,2048+16);
			MoveLocation(24,74,P6,64);
			CreateUnit(4,61,24,P6),
			SetCDeaths(P6,Add,1,DarkReGen);
			CreateUnit(1,84,24,P6),
			PreserveTrigger();
		}
	}
	DoActions(FP,KillUnitAt(All,124,67,Force1)) 
CIfEnd()
Overflow_HP_System(FP,B4_H,B4_K,B4_P)
Trigger { -- 피까일때 효과음
	players = {P6},
	conditions = {
		Label(0);
		CVar(FP,B4_P[2],AtLeast,1);
		Command(P6,AtLeast,1,30);
	},
	actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")},HumanPlayers,FP);
		PreserveTrigger();
	}
}
B5_O = CreateVar()
Overflow_HP_System(FP,B5_H,B5_K,B5_O)

CIf(FP,CVar(FP,B5_O[2],AtLeast,1),SetCVar(FP,B5_O[2],Subtract,1))
	CTrigger(FP,{Bring(P6,AtLeast,1,2,64)},{TSetDeaths(P7,SetTo,_Mod(_Rand(),3),2),SetCVar(FP,B5_T[2],SetTo,0)},1)
CIfEnd()

CIfX(P6,{Command(P6,AtLeast,1,2),CVar(FP,B5_H[2],AtLeast,1)})
	CDoActions(P6,{TSetDeaths(_Add(B5_H,11),SetTo,1,0),TSetDeathsX(_Add(B5_H,16),SetTo,1,0,0xFFFF)})
	CWhile(P6,{CVar(FP,B5_P[2],AtLeast,1)},{SetCVar(FP,B5_P[2],Subtract,1)})
		f_Lengthdir(P6,_Mod(_Rand(),512),_Mod(_Rand(),359),B5_X, B5_Y)
		Simple_SetLocX(P6,23,_Add(B5_X,3552),_Add(B5_Y,3552),_Add(B5_X,3584),_Add(B5_Y,3584),{CreateUnit(1,128,24,P6),CreateUnit(1,84,24,P6)})
	CWhileEnd()
	CIfX(P6,{CVar(FP,B5_T[2],AtMost,0)})
		CIfX(FP,BYD)
			CIfX(P6,{CVar(FP,B5_K[2],AtLeast,50000000)})
				CMov(P6,B5_T,120)
			CElseIfX({CVar(FP,B5_K[2],AtLeast,40000000)})
				CMov(P6,B5_T,75)
			CElseIfX({CVar(FP,B5_K[2],AtLeast,30000000)})
				CMov(P6,B5_T,60)
			CElseIfX({CVar(FP,B5_K[2],AtLeast,20000000)})
				CMov(P6,B5_T,45)
			CElseIfX({CVar(FP,B5_K[2],AtLeast,10000000)})
				CMov(P6,B5_T,30)
			CElseX()
				CMov(P6,B5_T,15)
			CIfXEnd()
		CElseX()
			CIfX(P6,{CVar(FP,B5_K[2],AtLeast,40000001)})
				CMov(P6,B5_T,150)
			CElseIfX({CVar(FP,B5_K[2],AtMost,40000000)})
				CMov(P6,B5_T,115)
			CIfXEnd()
		CIfXEnd()
		CMov(P6,B5_P,_Mod(_Rand(),10),3)
	CIfXEnd()
	CSub(P6,B5_T,1)
	CIf(P6,Deaths(P7,AtLeast,1,"【 Anomaly 】"))
	DoActionsP({MoveLocation(24,"【 Anomaly 】",P6,"Anywhere")},P6)
	Trigger2(FP,NBYD,{SetMemory(0x66239C,SetTo,768000000)},{Preserved})
	Trigger2(FP,BYD,{SetMemory(0x66239C,SetTo,8320000*256)},{Preserved})
	Points = 3
	SizeofPolygon = 1
	Radius = 32*3
	Angle = 0
	CreateUnitPolygonSafe2Gun(P6,{Deaths(P7,Exactly,1,"【 Anomaly 】")},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P6,{1,19,1,84})
	Points = 3
	SizeofPolygon = 1
	Radius = 32*3
	Angle = 30
	CreateUnitPolygonSafe2Gun(P6,{Deaths(P7,Exactly,2,"【 Anomaly 】")},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P6,{1,19,1,84})
	Points = 3
	SizeofPolygon = 1
	Radius = 32*3
	Angle = 60
	CreateUnitPolygonSafe2Gun(P6,{Deaths(P7,Exactly,3,"【 Anomaly 】")},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P6,{1,19,1,84})
	Points = 3
	SizeofPolygon = 1
	Radius = 32*3
	Angle = 90
	CreateUnitPolygonSafe2Gun(P6,{Deaths(P7,Exactly,4,"【 Anomaly 】")},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P6,{1,19,1,84})
	DoActionsP({SetDeaths(P7,SetTo,0,"【 Anomaly 】"),Order(19,P6,"Anywhere",Attack,"Anywhere"),SetMemory(0x66239C,SetTo,179200000)},P6)
	CIfEnd()
CElseifX({CDeaths(P6,AtMost,0,HDStart),CDeaths(P6,AtMost,0,BYDBossStart)})
	DoActions(P6,{KillUnit(128,P6)})
CIfXEnd()






CIf(P6,CVar(FP,B6_H[2],AtLeast,1))
	CDoActions(FP,{TSetMemory(B6_H,SetTo,8000000*256)},1)
	CIf(P6,{TMemory(B6_H,AtMost,3000000*256)})
		CIf(P6,{CVar(FP,B6_K[2],AtMost,53)})
			CDoActions(P6,{TSetMemory(B6_H,Add,5000000*256)})
			CAdd(P6,B6_K,1)
			CAdd(P6,B6_DPase2,1)
		CIfEnd()
	CIfEnd()
	CDoActions(P6,{TSetDeaths(_Add(B6_H,11),SetTo,0,0),TSetDeathsX(_Add(B6_H,16),SetTo,0,0,0xFFFF)},1)
	CTrigger(P6,{TMemoryX(_Add(B6_H,17),Exactly,0,0xFF00)},{SetCVar(FP,B6_H[2],SetTo,0)},1)
CIfEnd()

CIf(P6,CDeaths(P6,AtLeast,1,HDStart)) -- 미구현 Once처리
	DoActions(P6,{KillUnit(109,Force1),KillUnit(125,Force1),KillUnit(124,Force1)})
	CIfOnce(P6,Always())
		for i = 0, 4 do 
			UnitReadX(P6,i,MarID[1+i],64,MarCount[1+i])
			CIfX(P6,CVar(P6,SetPlayers[2],AtLeast,2))
				f_Div(P6,MarCount[1+i],_Mov(2))
				CElseX()
				f_Div(P6,MarCount[1+i],_Mov(5))
			CIfXEnd()
		end
	CIfEnd()
	
	TriggerX(FP,{Deaths(P6,AtLeast,1,12)},{SetCVar(FP,HDEnd[2],Add,1),SetCVar(FP,B2_P[2],SetTo,0)},{Preserved})
	CIf(P6,{CVar(FP,HDEnd[2],AtLeast,200)})
		CAdd(P6,HDEnd2,Dt)
		
		Trigger { -- 
			players = {P6},
			conditions = {
			},
			actions = {
				RotatePlayer({PlayWAVX("staredit\\wav\\HDEnd.ogg"),PlayWAVX("staredit\\wav\\HDEnd.ogg"),PlayWAVX("staredit\\wav\\HDEnd.ogg")},HumanPlayers,FP);
			}
		}
		
		
		HDEndVar = 317
		ExScoreBackup = {}
		CIfOnce(P6,CVar(P6,HDEnd2[2],AtLeast,HDEndVar))
			for i=0, 4 do
				table.insert(ExScoreBackup,CreateVar())
				CMov(P6,PlayerDeaths[i+1],_ReadF(0x5822F4+(4*i)))
				CMov(P6,ExScoreBackup[i+1],ExScore[i+1])
			end
			DoActions(P6,{Simple_SetLoc(23,2048,2048,2048,2048)})
			Points = 6
			SizeofPolygon = 6
			Radius = 32*3
			Angle = 0
			CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),63,32,Radius,Angle,Points,1,P6,{1,128,1,84})
		CIfEnd()
		
		
		
		Points = 1
		Radius = 62
		Angle = 0
		Radius2 = 372
		HDEndVar = 940
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*1,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*10,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1020
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*2,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*9,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1090
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*3,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*8,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1170
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*4,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*7,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1250
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*5,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*6,1,0,Radius,Angle,Points,0)
		
		
		
		Points = 1
		Radius = 62
		Angle = 90
		
		
		HDEndVar = 1410
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*1,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*10,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1490
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*2,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*9,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1570
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*3,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*8,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1640
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*4,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*7,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1720
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*5,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*6,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 1880
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CVar(P6,HDEnd2[2],AtLeast,HDEndVar);
		},
			actions = {
				Order(180,P6,"Anywhere",Attack,64);
			}
		}
		
		HDEndVar = 2820
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CVar(P6,HDEnd2[2],AtLeast,HDEndVar);
		},
			actions = {
				KillUnit(180,P6);
			}
		}
		
		
		
		Points = 1
		Radius = 62
		Angle = 90
		
		
		HDEndVar = 3450
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*1,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*10,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 3530
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*2,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*9,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 3610
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*3,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*8,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 3690
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*4,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*7,32,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 3770
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*5,32,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,Radius2*6,32,1,0,Radius,Angle,Points,0)
		
		
		Points = 1
		Radius = 62
		Angle = 0
		
		HDEndVar = 3920
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*1,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*10,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 4000
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*2,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*9,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 4080
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*3,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*8,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 4160
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*4,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*7,1,0,Radius,Angle,Points,0)
		
		HDEndVar = 4240
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*5,1,0,Radius,Angle,Points,0)
		CreateUnitLine(P6,{Label(0),CVar(P6,HDEnd2[2],AtLeast,HDEndVar)},64,180,23,P6,32,Radius2*6,1,0,Radius,Angle,Points,0)
		
		
		
		HDEndVar = 4390
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CVar(P6,HDEnd2[2],AtLeast,HDEndVar);
		},
			actions = {
				RunAIScriptAt(JYD,64);
			}
		}
		
		HDEndVar = 5180
		CIfOnce(P6,CVar(P6,HDEnd2[2],AtLeast,HDEndVar),{ModifyUnitEnergy(All,"Men",AllPlayers,64,0),RemoveUnit("Any unit",Force2),SetCDeaths(P6,SetTo,1,Win),SetMemory(0x51CE98, SetTo, 1)})
		
			for i=0, 4 do
				CMov(P6,0x5822F4+(4*i),PlayerDeaths[i+1])
				CMov(P6,ExScore[i+1],ExScoreBackup[i+1])
			end
			Trigger {
				players = {P6},
				conditions = {
					Label(0);
					NBYD;
			},
				actions = {
					--SetSwitch("Switch 203",Clear);
					GiveUnits(All,111,Force1,64,P12);
					RemoveUnit("Any unit",Force1);
					SetMemory(0x51CE98, SetTo, 1);
					
				}
			}

			Trigger {
				players = {P6},
				conditions = {
					Label(0);
					BYD;
			},
				actions = {
					CreateUnitWithProperties(1,82,64,FP,{invincible = true});
					RotatePlayer({SetAllianceStatus(AllPlayers,Ally)},{0,1,2,3,4,5,6,7},FP);
					
					
				}
			}
			CMov(P6,Time1,Time2)
		CIfEnd()
	CIfEnd()
MarCreate = CreateCCode(ExDeaths1)
	TriggerX(P6,{
		CDeaths(FP,AtLeast,1,MarCreate)
		},{   
		SetCJump(0x700,0),SetCDeaths(FP,SetTo,0,MarCreate)
		},{Preserved})

	TriggerX(P6,{
		CVar(FP,B6_K[2],AtLeast,7)
		},{   
		RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
		SetCVar(FP,B6_T[2],SetTo,1000),
		CreateUnit(5,84,64,P6),
		SetCJump(0x700,0)
		})
	TriggerX(P6,{
		CVar(FP,B6_K[2],AtLeast,13)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
		SetCVar(FP,B6_T[2],SetTo,250),
		CreateUnit(5,84,64,P6)
		})
	TriggerX(P6,{
		CVar(FP,B6_K[2],AtLeast,19)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
		SetCVar(FP,B6_T[2],SetTo,250),
		CreateUnit(5,84,64,P6)
		})
	TriggerX(P6,{
		CVar(FP,B6_K[2],AtLeast,25)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
		SetCVar(FP,B6_T[2],SetTo,250),
		CreateUnit(5,84,64,P6),
		SetCJump(0x700,0)
		})
	TriggerX(P6,{
		CVar(FP,B6_K[2],AtLeast,31)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
		SetCVar(FP,B6_T[2],SetTo,250),
		CreateUnit(5,84,64,P6),
		SetMemory(0x58F550,SetTo,1)
		})
	TriggerX(P6,{
		CVar(FP,B6_K[2],AtLeast,37)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
		SetCVar(FP,B6_T[2],SetTo,250),
		CreateUnit(5,84,64,P6)
		})
	TriggerX(P6,{
		CVar(FP,B6_K[2],AtLeast,51)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
		SetCVar(FP,B6_T[2],SetTo,250),
		CreateUnit(5,84,64,P6),
		SetMemory(0x58F550,SetTo,1)
		})
	TriggerX(P6,{
		CVar(FP,B6_C[2],AtLeast,40*15)
		},{
		SetCVar(FP,B6_T[2],SetTo,250),
		SetCVar(FP,B6_C[2],SetTo,0),
		CreateUnit(5,84,64,P6)
		},{Preserved})
	
	CIfX(P6,{CVar(FP,B6_R[2],AtLeast,1)})
		CWhile(P6,{CVar(FP,B6_W[2],AtMost,3)},{SetCVar(FP,B6_W[2],Add,1)})
			f_Lengthdir(P6,B6_R,_Add(B6_A,_Mul(B6_W,90)),B6_X,B6_Y)
			Simple_SetLocX(P6,23,_Add(B6_X,2048),_Add(B6_Y,2048),_Add(B6_X,2048),_Add(B6_Y,2048),{CreateUnit(1,84,24,P6)})
			CIf(P6,{Memory(0x628438,AtLeast,1),TMemory(_Mem(_Mod(_Rand(),4)),Exactly,B6_W)})
				f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
				CAdd(P6,B2_HS,_Mod(_Rand(),4000),300)
				CMul(P6,B2_SH,_Add(_Mod(_Rand(),200),50),256)
				CDoActions(P6,{
					CreateUnit(1,180,24,P6),
					CreateUnitWithProperties(1,180,24,P8,{hallucinated = true}),
					KillUnit(180,P8),
					TSetDeaths(_Add(Nextptrs,2),SetTo,B2_SH,0),
					TSetDeaths(_Add(Nextptrs,13),SetTo,B2_HS,0),
					TSetDeathsX(_Add(Nextptrs,18),SetTo,B2_HS,0,0xFFFF),
					Order(180,P6,"Anywhere",Move,64)
				})
			CIfEnd()
		CWhileEnd()
		CDoActions(FP,{
			SetCVar(FP,B2_P[2],SetTo,0),
			SetCVar(FP,B6_W[2],SetTo,0),
			SetCVar(FP,B6_A[2],Add,1),
			TSetCVar(FP,B6_R[2],Subtract,_Add(_Div(B6_R,_Mov(100)),1))
		})
		CElseX()
		DoActionsX(FP,{
			SetCVar(FP,B2_P[2],SetTo,1),
			SetCVar(FP,B6_T[2],SetTo,400)
		},1)
		
		CWhile(P6,{CVar(FP,B6_A2[2],AtMost,359)})
			f_Lengthdir(P6,300,B6_A2,B6_X,B6_Y)
			Simple_SetLocX(P6,23,_Add(B6_X,2048),_Add(B6_Y,2048),_Add(B6_X,2048),_Add(B6_Y,2048),{CreateUnit(1,84,24,P6)})
			CAdd(P6,B6_A2,5)
		CWhileEnd()
		DoActions(P6,{
			GiveUnits(1,12,P12,"Anywhere",P6),
			MoveUnit(All,12,P6,"Anywhere","Anywhere"),
			--SetInvincibility(Disable,12,P6,"Anywhere")
		},1)
		TriggerX(FP,{CVar(FP,B6_K[2],AtMost,24),CVar(FP,B6_K[2],AtLeast,7)},{SetCDeaths(FP,Add,1,MarineStackSystem)},{Preserved})
		NIfX(P6,{CVar(FP,B6_T[2],AtMost,0)})
			CSub(P6,B6_T2,1)
			DoActionsX(P6,SetCDeaths(P6,SetTo,1,B5_Av))
			NWhile(P6,Bring(P6,AtLeast,1,216,64))
				DoActions(P6,{Simple_SetLoc(23,2048+5,2048+5,2048+27,2048+27),
					MoveLocation(24,216,P6,"Anywhere"),
					--SetInvincibility(Enable,"Any unit",Force1,24),
					KillUnitAt(All, "Factories",24,Force1),
					GiveUnits(1,216,P6,"Anywhere",P12),
				})
			NWhileEnd()
			DoActions(P6,{
			GiveUnits(All,216,P12,"Anywhere",P6),
			})
			NIf(P6,{CVar(FP,B6_T2[2],AtMost,0),CVar(FP,B6_K[2],AtLeast,13),CVar(FP,B6_K[2],AtMost,18),CVar(FP,B6_C[2],Exactly,10)})
				Points = 1
				Radius = 32
				Angle = 0
				CreateUnitLine(P6,{Always()},19,216,23,P6,2048-(9*32),2048-(7*32)+16,1,0,Radius,Angle,Points,1)
				CreateUnitLine(P6,{Always()},19,94,23,P8,2048-(9*32),2048-(7*32)+16,1,0,Radius,Angle,Points,1)
				CreateUnitLine(P6,{Always()},19,216,23,P6,2048-(9*32),2048+(7*32)-16,1,0,Radius,Angle,Points,1)
				CreateUnitLine(P6,{Always()},19,94,23,P8,2048-(9*32),2048+(7*32)-16,1,0,Radius,Angle,Points,1)
				Points = 1
				Radius = 32
				Angle = 90
				CreateUnitLine(P6,{Always()},13,216,23,P6,2048-(10*32)+16,2048-(6*32),1,0,Radius,Angle,Points,1)
				CreateUnitLine(P6,{Always()},13,94,23,P8,2048-(10*32)+16,2048-(6*32),1,0,Radius,Angle,Points,1)
				CreateUnitLine(P6,{Always()},13,216,23,P6,2048+(10*32)-16,2048-(6*32),1,0,Radius,Angle,Points,1)
				CreateUnitLine(P6,{Always()},13,94,23,P8,2048+(10*32)-16,2048-(6*32),1,0,Radius,Angle,Points,1)
				DoActions(P6,{
					KillUnit(94,P8);
				})
			NIfEnd()
			TriggerX(P6,{
				CVar(FP,B6_T2[2],AtMost,0),
				CVar(FP,B6_K[2],AtMost,6)},
			{
				SetInvincibility(Disable,12,P6,"Anywhere"),
				ModifyUnitShields(All,12,P6,64,0)
			},{Preserved})

			NJumpX(P6,0x301,{
				CVar(FP,B6_T2[2],AtMost,0),
				CVar(FP,B6_K[2],AtMost,6),
				CountdownTimer(AtMost,7200)},
			{
				SetCVar(FP,B6_T2[2],SetTo,10),
				SetInvincibility(Disable,12,P6,"Anywhere"),
				ModifyUnitShields(All,12,P6,64,0)
			})
			NJumpX(P6,0x301,{NBYD,
				CVar(FP,B6_T2[2],AtMost,0),
				CVar(FP,B6_K[2],AtLeast,7),
				CVar(FP,B6_K[2],AtMost,12)},
			{   
				SetCVar(FP,B6_T2[2],SetTo,111),
				SetInvincibility(Disable,12,P6,"Anywhere"),
				ModifyUnitShields(All,12,P6,64,0)
			})
			NJumpX(P6,0x301,{BYD,
				Bring(FP,AtMost,0,128,64),
				CVar(FP,B6_T2[2],AtMost,0),
				CVar(FP,B6_K[2],AtLeast,7),
				CVar(FP,B6_K[2],AtMost,12)},
			{   

				SetInvincibility(Disable,12,P6,"Anywhere"),
				ModifyUnitShields(All,12,P6,64,0)
			})
	
			NJumpX(P6,0x301,{
				CVar(FP,B6_T2[2],AtMost,0),
				CVar(FP,B6_K[2],AtLeast,13),
				CVar(FP,B6_K[2],AtMost,18)},
			{
				SetCVar(FP,B6_T2[2],SetTo,10),
				SetCVar(FP,B6_C[2],Add,10),
				SetInvincibility(Disable,12,P6,"Anywhere"),
				ModifyUnitShields(All,12,P6,64,0)})
	
			NIf(P6,{CVar(FP,B6_K[2],AtLeast,19),CVar(FP,B6_K[2],AtMost,24)})
				NIfX(P6,{TBring(P8,AtMost,_Mul(B6_Dif,350),49,64)})
					NWhile(P6,{TCVar(FP,B6_W[2],AtMost,_Mul(B6_Dif2,2))})
						f_Lengthdir(P6,_Add(_Mod(_Rand(),700),300),_Mod(_Rand(),359),B6_X,B6_Y)
						Simple_SetLocX(P6,23,_Add(B6_X,2048),_Add(B6_Y,2048),_Add(B6_X,2048),_Add(B6_Y,2048),{
						CreateUnit(1,49,24,P8),
						SetInvincibility(Enable,49,P8,64),
						Order(49,P8,64,Move,64)})
						CAdd(P6,B6_W,1)
					NWhileEnd()
					DoActions(P6,{SetInvincibility(Enable,12,P6,"Anywhere"),ModifyUnitShields(All,12,P6,64,100)})
					Points = 36
					SizeofPolygon = 1
					Radius = 1000
					Angle = 0
					CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),63,32,Radius,Angle,Points,1,P8,{1,94})
					DoActions(P6,{KillUnit(94,P8)})
					CMov(P6,B6_W,0)
					NElseIfX({CVar(FP,B6_T2[2],AtMost,0)})
					DoActions(P6,{SetInvincibility(Disable,12,P6,"Anywhere"),ModifyUnitShields(All,12,P6,64,0)})
					CMov(P6,B6_T2,200)
					Trigger {
						players = {P6},
						conditions = {
					},
						actions = {
							SetMemory(0x6509B0,SetTo,7);
							RunAIScriptAt(JYD,64);
							SetMemory(0x6509B0,SetTo,6);
							PreserveTrigger();
						}
					}
					NElseIfX({CVar(FP,B6_T2[2],AtMost,1)})
					NWhile(P6,{NBYD,Bring(P8,AtLeast,1,49,64)})
						DoActions(P6,{Simple_SetLoc(23,2048+5,2048+5,2048+27,2048+27),
							MoveLocation(24,49,P8,"Anywhere"),
							CreateUnit(1,128,24,P6),
							GiveUnits(1,49,P8,"Anywhere",P12),
							KillUnit(49,P12)
						})
					NWhileEnd()
					NWhile(P6,{BYD,Bring(P8,AtLeast,1,49,64)})
						DoActions(P6,{Simple_SetLoc(23,2048+5,2048+5,2048+27,2048+27),
							MoveLocation(24,49,P8,"Anywhere"),
							SetInvincibility(Enable,"Factories",Force1,24),KillUnitAt(All,20,24,Force1),KillUnitAt(All,32,24,Force1),
							GiveUnits(1,49,P8,"Anywhere",P12),
							KillUnit(49,P12)
						})
					NWhileEnd()
					CMov(P6,B6_T,200)
					NElseX()
					for i = 1, 25 do
						CTrigger(P6,{
							CVar(FP,B6_T2[2],Exactly,16*i)
						},{
							SetMemory(0x6509B0,SetTo,7),
							RunAIScriptAt(JYD,64),
							SetMemory(0x6509B0,SetTo,6)
						},1)
					end
				NIfXEnd()
			NIfEnd()
			
			NIf(P6,{CVar(FP,B6_K[2],AtLeast,25),CVar(FP,B6_K[2],AtMost,30)})
				DoActions(P6,{
					SetMemory(0x58F450,SetTo,65537),
					MoveUnit(All,"Men",Force1,156,208),
					MoveUnit(All,"Men",Force1,154,207),
					MoveUnit(All,"Men",Force1,155,206),
					MoveUnit(All,"Men",Force1,153,205),
					SetMemoryX(0x65676C, SetTo, 256*1,0xFF00)
				},1)
				DoActions(P6,{
					SetInvincibility(Disable,88,P6,"Anywhere"),
					SetInvincibility(Disable,80,P6,"Anywhere"),
					SetInvincibility(Disable,21,P6,"Anywhere"),
					SetInvincibility(Disable,8,P6,"Anywhere"),
					SetInvincibility(Disable,22,P6,"Anywhere"),
					SetInvincibility(Disable,98,P6,"Anywhere"),
				})
				CAdd(P6,B6_T3,1)
				Trigger {
					players = {P6},
					conditions = {
						Label(0);
						CVar(P6,B6_T3[2],AtLeast,1200);
					},
					actions = {
						SetCJump(0x300,0);
					}
				}
				Trigger {
					players = {P6},
					conditions = {
						Label(0);
						CVar(P6,B6_T3[2],AtLeast,1200);
						CDeaths(P6,AtLeast,1,EVMode);
					},
					actions = {
						SetMemoryX(0x65676C, SetTo, 256*3,0xFF00);
					}
				}
				NIf(P6,CVar(P6,B6_T3[2],AtLeast,1500))
					CAdd(P6,B6_T4,1)
					CAdd(P6,B6_T5,B6_T4)
					CMov(P6,B6_W,0)
					CWhile(P6,{CVar(FP,B6_W[2],AtMost,3),CVar(P6,B6_RT[2],AtMost,12000)})
						f_Lengthdir(P6,300,_Add(_Mod(_Div(B6_T5,_Mov(30)),_Mov(360)),_Mul(B6_W,_Mov(90))),B6_X,B6_Y)
						Simple_SetLocX(P6,23,_Add(B6_X,2048),_Add(B6_Y,2048),_Add(B6_X,2048),_Add(B6_Y,2048),{CreateUnit(1,84,24,P6)})
						CAdd(P6,B6_W,1)
					CWhileEnd()
					TemAngle2 = CreateVar()
					CAdd(P6,B6_RT,Dt)
					CAPlot(CSMakeLine(1,32,0,8,0),FP,84,190,nil,1,32,{1,0,0,0,99,0},"TemRotate2",FP,{BYD,CVar(P6,B6_RT[2],AtMost,12000)},nil,1)
					DoActions(P6,{Simple_SetLoc(23,2048,2048,2048,2048)})
					for j = 0, 11 do
						Trigger {
							players = {P6},
							conditions = {
								Label(0);
								CVar(P6,B6_RT[2],AtLeast,1000*j);
								
								},
							actions = {
								RotatePlayer({PlayWAVX("staredit\\wav\\Clock.ogg"),PlayWAVX("staredit\\wav\\Clock.ogg")},HumanPlayers,FP);
							},
						}
						
						Points = 24
						SizeofPolygon = 1
						Radius = 32*8
						Angle = 0
						CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(P6,B6_RT[2],AtLeast,1000*j)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,84})
						Points = 1
						Radius = 32
						Angle = 270+(30*j)
						CreateUnitLineSafeGun(P6,{Label(0),CVar(P6,B6_RT[2],AtLeast,1000*j)},8,23,32,Radius,Angle,Points,0,P6,{1,84})
						CreateUnitLineSafeGun(P6,{Label(0),FTR,CVar(P6,B6_RT[2],AtLeast,1000*j)},8,23,32,Radius,Angle,Points,0,P6,{1,29})
						CreateUnitLineSafeGun(P6,{Label(0),BYD,CVar(P6,B6_RT[2],AtLeast,1000*j)},8,23,32,Radius,Angle,Points,0,P6,{1,22})
					end

						Trigger {
							players = {P6},
							conditions = {
								Label(0);
								CVar(P6,B6_RT[2],AtLeast,12000);
								
								},
							actions = {
								RotatePlayer({PlayWAVX("staredit\\wav\\Clock.ogg"),PlayWAVX("staredit\\wav\\Clock.ogg")},HumanPlayers,FP);
							},
						}
					Trigger {
						players = {P6},
						conditions = {
							Label(0);
							CVar(P6,B6_RT[2],AtLeast,12000);
						},
						actions = {
							SetMemory(0x6624E8, SetTo, 588800000/8);
							SetMemory(0x662450 + (60*4), SetTo, 8320000*256);
					
						}
					}
					
					Points = 8
					SizeofPolygon = 1
					Radius = 85*1
					Angle = 0
					CreateUnitPolygonSafe2Gun(P6,{Label(0),NBYD,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,102,1,84})
					CreateUnitPolygonSafe2Gun(P6,{Label(0),BYD,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,84})
					Points = 16
					SizeofPolygon = 1
					Radius = 85*2
					Angle = 0
					CreateUnitPolygonSafe2Gun(P6,{Label(0),NBYD,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,102,1,84})
					CreateUnitPolygonSafe2Gun(P6,{Label(0),BYD,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,84})
					Points = 24
					SizeofPolygon = 1
					Radius = 85*3
					Angle = 0
					CreateUnitPolygonSafe2Gun(P6,{Label(0),NBYD,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,102,1,84})
					CreateUnitPolygonSafe2Gun(P6,{Label(0),BYD,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,84})
					Points = 32
					SizeofPolygon = 1
					Radius = 85*4
					Angle = 0
					CreateUnitPolygonSafe2Gun(P6,{Label(0),FTR,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,102,1,84})
					CreateUnitPolygonSafe2Gun(P6,{Label(0),BYD,CVar(P6,B6_RT[2],AtLeast,12000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P6,{1,84})

					CreateUnitLineSafeGun(P6,{Label(0),BYD,CVar(P6,B6_RT[2],AtLeast,12000)},2,23,32,256,0,4,0,P6,{1,60,1,84})
					Trigger {
						players = {P6},
						conditions = {
							Label(0);
							CVar(P6,B6_RT[2],AtLeast,12000);
					},
						actions = {
							SetMemory(0x6624E8, SetTo, 588800000);
							SetMemory(0x662450 + (60*4), SetTo, 2880000*256);
							Order(102,P6,64,Patrol,64);
							SetInvincibility(Disable,12,P6,"Anywhere");
							ModifyUnitShields(All,12,P6,64,0);
						}
					}
					
				NIfEnd()
			NIfEnd()
			
			NIf(P6,{CVar(FP,B6_K[2],AtLeast,31),CVar(FP,B6_K[2],AtMost,36)})
				Trigger {
					players = {P6},
					conditions = {
						Label(0);
				},
					actions = {
						SetInvincibility(Disable,12,P6,"Anywhere");
						ModifyUnitShields(All,12,P6,64,0);
						SetCVar(P6,B6_T2[2],SetTo,0);
					}
				}
				CAdd(P6,B6_T2,2)
				NIf(P6,{CVar(FP,B6_T2[2],AtLeast,50)})
					B6_Break = CreateVar()
					CMov(P6,B6_Break,0)
					CMov(P6,B6_W,0)
					CWhile(P6,{TCVar(FP,B6_Break[2],AtMost,B6_Dif3),TCVar(FP,B6_W[2],AtMost,_Mul(_Mul(B6_C2,B6_Dif),5))})
						
						f_Lengthdir(P6,_Mod(_Rand(),400),_Mod(_Rand(),359),B6_X,B6_Y)
						Simple_SetLocX(P6,23,_Add(B6_X,2048),_Add(B6_Y,2048),_Add(B6_X,2048),_Add(B6_Y,2048),{CreateUnit(1,128,24,P6),CreateUnit(1,84,24,P6)})
						
						CAdd(P6,B6_W,1)
						CAdd(P6,B6_Break,1)
					CWhileEnd()
					
					CMov(P6,B6_T2,0)
					CAdd(P6,B6_C2,1)
				NIfEnd()
				
				
			NIfEnd()
			Trigger {
				players = {P6},
				conditions = {
					Label(0);
					CVar(P6,B6_K[2],AtLeast,37);
			},
				actions = {
					SetInvincibility(Disable,12,P6,"Anywhere");
					ModifyUnitShields(All,12,P6,64,0);
				}
			}
			
			NIf(P6,{CVar(FP,B6_K[2],AtLeast,51),CVar(FP,B6_K[2],AtMost,53)})
				Trigger {
					players = {P6},
					actions = {
						SetInvincibility(Disable,12,P6,"Anywhere");
						ModifyUnitShields(All,12,P6,64,0);
					}
				}
				NIf(P6,{CVar(FP,B6_K[2],AtLeast,52),CVar(FP,Time1[2],AtLeast,60000*6)})
					CSub(P6,B6_K,1)
					TriggerX(FP,{NBYD},{SetCVar(FP,Time1[2],Subtract,60000*6)},{Preserved})
					TriggerX(FP,{BYD},{SetCVar(FP,Time1[2],Subtract,20000*6)},{Preserved})
					CMov(P6,B6_X,_Mod(_Rand(),300))
					CMov(P6,B6_Y,_Mod(_Rand(),200))
					Simple_SetLocX(P6,23,_Add(B6_X,2048-300),_Add(B6_Y,2048-200),_Add(B6_X,2048-300),_Add(B6_Y,2048-200))
					CIf(P6,HD)
						CTrigger(P6,{Switch("Switch 1",Cleared)},{TCreateUnit(0,VArr(UArr1,_Mod(_Rand(),_Mov(16))),24,P8)},1)
						CTrigger(P6,{Switch("Switch 1",Set)},{TCreateUnit(0,VArr(UArr2,_Mod(_Rand(),_Mov(16))),24,P8)},1)
					CIfEnd()
					CIf(P6,FTRBYD)
						CTrigger(P6,{Switch("Switch 1",Cleared)},{TCreateUnit(_Mul(_Add(_Div(Time1,_Mov(900000)),1),_Mov(16777216)),VArr(UArr1,_Mod(_Rand(),_Mov(16))),24,P8)},1)
						CTrigger(P6,{Switch("Switch 1",Set)},{TCreateUnit(_Mul(_Add(_Div(Time1,_Mov(900000)),1),_Mov(16777216)),VArr(UArr2,_Mod(_Rand(),_Mov(16))),24,P8)},1)
					CIfEnd()
					Trigger2(FP,{BYD},{CreateUnit(1,49,192,P6),CreateUnit(1,49,193,P6),RunAIScriptAt(JYD,192),RunAIScriptAt(JYD,193)},{Preserved})
					DoActions(P6,{
						CreateUnitWithProperties(1,84,24,P8,{hallucinated = true}),
						KillUnit(84,P8),
					})
				NIfEnd()
				CIf(P6,{CVar(FP,B6_K[2],AtLeast,52),CVar(FP,Time1[2],AtMost,60000*6)})
					CMov(P6,Time1,0)
					Trigger {
						players = {P6},
						conditions = {
						},
						actions = {
							RotatePlayer({
								RunAIScript("Turn ON Shared Vision for Player 6"),
								RunAIScript("Turn ON Shared Vision for Player 7"),
								RunAIScript("Turn ON Shared Vision for Player 8")
							},MapPlayers,FP);
						}
					}
					Trigger {
						players = {P6},
						conditions = {
							Bring(P8,AtMost,4,"Any unit",64);
							HD;
					},
						actions = {
							SetInvincibility(Disable,12,P6,"Anywhere");
							ModifyUnitShields(All,12,P6,64,0);
							PreserveTrigger();
						}
					}
					Trigger {
						players = {P6},
						conditions = {
							FTR;
					},
						actions = {
							CreateUnit(1,64,66,P7);
							CreateUnit(1,64,67,P8);
							CreateUnit(1,64,68,P8);
							CreateUnit(1,64,69,P7);
							CreateUnit(7,69,66,P8);
							CreateUnit(7,69,67,P8);
							CreateUnit(7,69,68,P8);
							CreateUnit(7,69,69,P8);
							CreateUnit(7,11,66,P7);
							CreateUnit(7,11,67,P7);
							CreateUnit(7,11,68,P7);
							CreateUnit(7,11,69,P7);
						}
					}
					Trigger {
						players = {P6},
						conditions = {
							FTR;
					},
						
						actions = {
							ModifyUnitShields(All,64,Force2,64,100);
							PreserveTrigger();
						}
					}
					
					Trigger {
						players = {P6},
						conditions = {
							Bring(P7,AtMost,0,"Any unit",64);
							Bring(P8,AtMost,0,"Any unit",64);
							FTR;
					},
						actions = {
							SetInvincibility(Disable,12,P6,"Anywhere");
							ModifyUnitShields(All,12,P6,64,0);
							PreserveTrigger();
						}
					}
					Trigger {
						players = {P6},
						conditions = {
							Bring(P7,AtLeast,5,"Any unit",64);
							Bring(P8,AtLeast,5,"Any unit",64);
					},
						actions = {
							SetInvincibility(Enable,12,P6,"Anywhere");
							ModifyUnitShields(All,12,P6,64,100);
							PreserveTrigger();
						}
					}
					Trigger {
						players = {P6},
						conditions = {
							Bring(P6,AtMost,0,60,64);
							BYD;
					},
						actions = {
							SetInvincibility(Disable,12,P6,"Anywhere");
							ModifyUnitShields(All,12,P6,64,0);
							PreserveTrigger();
						}
					}
					
					CIfOnce(P6,Always())
						CMov(P6,B6_W,0)
						CWhile(P6,{HD,CVar(FP,B6_W[2],AtMost,15)})
							for i=0, 1 do
								CTrigger(P6,{Switch("Switch 1",Cleared)},{TCreateUnit(0,VArr(UArr1,B6_W),66+i,P8)},1)
								CTrigger(P6,{Switch("Switch 1",Set)},{TCreateUnit(0,VArr(UArr1,B6_W),68+i,P8)},1)
								CTrigger(P6,{Switch("Switch 1",Set)},{TCreateUnit(0,VArr(UArr2,B6_W),66+i,P8)},1)
								CTrigger(P6,{Switch("Switch 1",Cleared)},{TCreateUnit(0,VArr(UArr2,B6_W),68+i,P8)},1)
							end
							CAdd(P6,B6_W,1)
						CWhileEnd()
						Trigger {
							players = {P6},
							actions = {
								SetInvincibility(Enable,12,P6,"Anywhere");
								ModifyUnitShields(All,12,P6,64,100);
								Order("Men",Force2,64,Patrol,64);
							}
						}
					CIfEnd()
					Trigger {
						players = {P6},
						conditions = {
					},
						actions = {
							SetInvincibility(Enable,12,P6,"Anywhere");
							ModifyUnitShields(All,12,P6,64,100);
							
						}
					}
					for i = 0, 3 do
					CSPlotAct(CSMakePolygon(4,128,0,5,0),P8,69,65+i,nil,10,32,32,nil,FP,{BYD},nil,0)
					CSPlotAct(CSMakePolygon(4,192,0,5,0),P7,11,65+i,nil,10,32,32,nil,FP,{BYD},nil,0)
					end
					Trigger {
						players = {P6},
						conditions = {
							BYD;
					},
						actions = {
							CreateUnit(2,60,66,P6);
							CreateUnit(2,60,67,P6);
							CreateUnit(2,60,68,P6);
							CreateUnit(2,60,69,P6);
							Order(60,P6,64,Attack,64);
							Order(49,P6,64,Attack,64);
							SetMemory(0x6509B0,SetTo,6),

							RunAIScriptAt(JYD,66);
							RunAIScriptAt(JYD,67);
							RunAIScriptAt(JYD,68);
							RunAIScriptAt(JYD,69);
							SetMemory(0x6509B0,SetTo,7),

							RunAIScriptAt(JYD,66);
							RunAIScriptAt(JYD,67);
							RunAIScriptAt(JYD,68);
							RunAIScriptAt(JYD,69);
							SetMemory(0x6509B0,SetTo,5),
						}
					}
				CIfEnd()
				
				
			NIfEnd()
			NElseX()
			DoActions(P6,{
			KillUnit(216,AllPlayers),
			KillUnit(49,P8)
			})
			Trigger {
				players = {P6},
				conditions = {
					Label(0);
					Bring(P6,AtLeast,1,128,64);
			},
				actions = {
					SetCDeaths(P6,SetTo,1,B5_Av);
					PreserveTrigger();
				}
			}
		NIfXEnd()
		
		CJump(P6,0x300)
		NJumpXEnd(P6,0x301)
		UnitReadX(P6,Force1,"Men",212,B6_UC)
		
		
		--CMov(P6,B6_X,0)
		--CMov(P6,B6_X,0)
		--CMov(P6,B6_Y,0)
		--CMov(P6,B6_Y,0)
		
		DoActions(FP,Simple_SetLoc(23,2048-(32*10)+16,2048-(32*7)+16,(2048-(32*10))+16,(2048-(32*7))+16))
		NWhile(P6,{Memory(0x58DC64 + 0x14*23,AtMost,2048-(32*7)+16+(13*32))})
			NWhile(P6,{Memory(0x58DC60 + 0x14*23,AtMost,2048-(32*10)+16+(19*32))})
				Trigger {
					players = {P6},
					conditions = {
						Label(0);
						FTR;
						CVar(P6,B6_K[2],AtLeast,25);
						CVar(P6,B6_K[2],AtMost,31);
				},
					actions = {
						SetMemory(0x6623B4, SetTo, 256);
						CreateUnit(1,25,24,P8);
						SetMemory(0x6623B4, SetTo, 89600000);
						PreserveTrigger();
					}
				}
				Trigger {
					players = {P6},
					conditions = {
						Label(0);
						NBYD;
						CVar(P6,B6_K[2],AtLeast,25);
						CVar(P6,B6_K[2],AtMost,31);
				},
					actions = {
						SetMemory(0x6623C0, SetTo, 256);
						CreateUnit(1,28,24,P8);
						SetMemory(0x6623C0, SetTo, 89600000);
						PreserveTrigger();
					}
				}
				Trigger {
					players = {P6},
					conditions = {
						Label(0);
						BYD;
						CVar(P6,B6_K[2],AtLeast,25);
						CVar(P6,B6_K[2],AtMost,31);
				},
					actions = {
						SetMemory(0x662350+(10*4), SetTo, 256);
						SetMemory(0x662350+(22*4), SetTo, 256);
						CreateUnit(1,22,24,P8);
						CreateUnit(1,10,24,P8);
						SetMemory(0x662350+(22*4), SetTo, 450000*256);
						SetMemory(0x662350+(10*4), SetTo, 650000*256);
						PreserveTrigger();
					}
				}
				
				
				NIf(P6,{CVar(P6,B6_K[2],AtMost,24)})
					NIf(P6,{CVar(P6,B6_K[2],AtMost,12),CVar(P6,B6_K[2],AtLeast,7)})
						NIf(P6,{TMemory(_Mem(_Mod(_Rand(),100)),AtLeast,5)})
							
							Trigger {
								players = {P6},
								conditions = {
									NBYD;
									Bring(P6,AtMost,0,128,24);
									Bring(P6,AtMost,0,216,24);
							},
								actions = {
									CreateUnit(1,128,24,P6);
									CreateUnit(1,84,24,P6);
									PreserveTrigger();
								}
							}
							Trigger {
								players = {P6},
								conditions = {
									BYD;
									Bring(P6,AtMost,0,128,24);
									Bring(P6,AtMost,0,216,24);
							},
								actions = {
									CreateUnitWithProperties(1,128,24,P6,{hitpoint = 70});
									CreateUnit(1,84,24,P6);
									PreserveTrigger();
								}
							}
							
						
						NIfEnd()
					NIfEnd()
					CIf(P6,{CVar(P6,B6_K[2],AtMost,6)})

						NIf(FP,BYD)
							NIf(P6,{TMemory(_Mem(_Mod(_Rand(),40000)),AtMost,B6_UC)})
									DoActions(P6,{
											CreateUnit(2,49,192,FP),
											CreateUnit(2,49,193,FP),
											CreateUnit(1,69,192,P8),
											CreateUnit(1,11,192,P7),
											CreateUnit(1,69,193,P8),
											CreateUnit(1,11,193,P7),
											CreateUnit(1,84,192,P6),
											CreateUnit(1,84,193,P6),
											SetMemory(0x6509B0,SetTo,7),
											RunAIScriptAt(JYD,64),
											SetMemory(0x6509B0,SetTo,6),
											RunAIScriptAt(JYD,192),
											RunAIScriptAt(JYD,193),
											SetMemory(0x6509B0,SetTo,5),
											RunAIScriptAt(JYD,64),
											RunAIScriptAt(JYD,192),
											RunAIScriptAt(JYD,193),
									})
							DoActions(P6,{
							CreateUnit(1,84,24,P6),
							SetCountdownTimer(Add,8*60)
							})
							NIfEnd()
						NIfEnd()
						NIf(FP,NBYD)
							NIf(P6,{TMemory(_Mem(_Mod(_Rand(),50000)),AtMost,B6_UC)})
								CIf(P6,FTR)
									CDoActions(P6,{TCreateUnit(_Mul(_Add(_Div(Time1,_Mov(900000)),1),_Mov(16777216)),VArr(UArr1,_Mod(_Rand(),_Mov(16))),24,P8),
									
											CreateUnit(1,69,192,P8),
											CreateUnit(1,11,192,P7),
											CreateUnit(1,69,193,P8),
											CreateUnit(1,11,193,P7),
											CreateUnit(1,84,192,P6),
											CreateUnit(1,84,193,P6),
											SetMemory(0x6509B0,SetTo,7),
											RunAIScriptAt(JYD,64),
											SetMemory(0x6509B0,SetTo,6),
											RunAIScriptAt(JYD,192),
											RunAIScriptAt(JYD,193),
											SetMemory(0x6509B0,SetTo,5)
									})
								CIfEnd()
								CIf(P6,HD)
									CDoActions(P6,{TCreateUnit(0,VArr(UArr2,_Mod(_Rand(),16)),24,P8)})
								CIfEnd()
								DoActions(P6,{
								CreateUnit(1,84,24,P6),
								SetCountdownTimer(Add,3*60)
								})
							NIfEnd()
						NIfEnd()
					CIfEnd()
					NIf(P6,{NBYD,CVar(P6,B6_K[2],AtLeast,13),CVar(P6,B6_K[2],AtMost,18)})
						NIf(P6,{TMemory(_Mem(_Mod(_Rand(),1000)),AtLeast,990),CVar(FP,B6_C[2],AtLeast,1)})
							CIf(P6,{Bring(P6,AtMost,0,180,24),Memory(0x628438,AtLeast,1)})
								f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
								CDoActions(P6,{
									CreateUnit(1,180,24,P6),
									CreateUnitWithProperties(1,180,24,P8,{hallucinated = true}),
									KillUnit(180,P8),
									TSetDeaths(_Add(Nextptrs,13),SetTo,0,0),
									TSetDeathsX(_Add(Nextptrs,18),SetTo,0,0,0xFFFF)
								})
							
							CIfEnd()
						NIfEnd()
						NIf(P6,{TMemory(_Mem(_Mod(_Rand(),1000)),AtLeast,990)})
							Trigger {
								players = {P6},
								conditions = {
									Bring(P6,AtMost,0,128,24);
									Bring(P6,AtMost,0,216,24);
							},
								actions = {
									CreateUnit(1,128,24,P6);
									CreateUnit(1,84,24,P6);
									PreserveTrigger();
								}
							}
						NIfEnd()
					NIfEnd()
					NIf(P6,{BYD,CVar(P6,B6_K[2],AtLeast,13),CVar(P6,B6_K[2],AtMost,18)})
						NIf(P6,{TMemory(_Mem(_Mod(_Rand(),1000)),AtLeast,970),CVar(FP,B6_C[2],AtLeast,1)})
							CIf(P6,{Bring(P6,AtMost,0,180,24),Memory(0x628438,AtLeast,1)})
								f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
								CDoActions(P6,{
									CreateUnit(1,180,24,P6),
									CreateUnitWithProperties(1,180,24,P8,{hallucinated = true}),
									KillUnit(180,P8),
									TSetDeaths(_Add(Nextptrs,13),SetTo,0,0),
									TSetDeathsX(_Add(Nextptrs,18),SetTo,0,0,0xFFFF)
								})
							
							CIfEnd()
						NIfEnd()
						NIf(P6,{TMemory(_Mem(_Mod(_Rand(),1000)),AtLeast,960)})
							Trigger {
								players = {P6},
								conditions = {
									Bring(P6,AtMost,0,128,24);
									Bring(P6,AtMost,0,216,24);
							},
								actions = {
									CreateUnitWithProperties(1,128,24,P6,{hitpoint = 70});
									CreateUnit(1,84,24,P6);
									PreserveTrigger();
								}
							}
						NIfEnd()
					NIfEnd()
				NIfEnd()
				--CAdd(P6,B6_X,1)
				CAdd(P6,0x58DC60 + 0x14*23,32)
				CAdd(P6,0x58DC68 + 0x14*23,32)
			NWhileEnd()
			Trigger {
				players = {P6},
				conditions = {
					Label(0);
					CVar(P6,B6_T3[2],AtLeast,1200);
			},
				actions = {
					SetCJump(0x300,1);
				}
			}
			--CMov(P6,B6_X,0)
			CMov(P6,0x58DC60 + 0x14*23,2048-(32*10)+16)
			CMov(P6,0x58DC68 + 0x14*23,(2048-(32*10))+16)
			CAdd(P6,0x58DC64 + 0x14*23,32)
			CAdd(P6,0x58DC6C + 0x14*23,32)
			--CAdd(P6,B6_Y,1)
		NWhileEnd()
		CJumpEnd(P6,0x300)
	CIfXEnd()
	
	
	
	Trigger {
		players = {P6},
		actions = {
			SetMemoryX(0x581DD8,SetTo,192*16777216,0xFF000000); -- 6P
			SetMemoryX(0x581D9C,SetTo,192*65536,0xFF0000); -- 6P
		}
	}
	Trigger {
		players = {P6},
	
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,10,ColorT);
			CDeaths(P6,Exactly,0,ColorC);
			MemoryX(0x581DD8,AtMost,199*16777216,0xFF000000);
			MemoryX(0x581D9C,AtMost,199*65536,0xFF0000);
	},
		actions = {
			SetCDeaths(P6,SetTo,0,ColorT);
			SetMemoryX(0x581DD8,Add,1*16777216,0xFF000000); -- 6P
			SetMemoryX(0x581D9C,Add,1*65536,0xFF0000); -- 6P
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			MemoryX(0x581DD8,AtLeast,199*16777216,0xFF000000);
			MemoryX(0x581D9C,AtLeast,199*65536,0xFF0000);
	},
		actions = {
			SetCDeaths(P6,SetTo,1,ColorC);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,10,ColorT);
			CDeaths(P6,Exactly,1,ColorC);
			MemoryX(0x581DD8,AtLeast,192*16777216,0xFF000000);
			MemoryX(0x581D9C,AtLeast,192*65536,0xFF0000);
	},
		actions = {
			SetCDeaths(P6,SetTo,0,ColorT);
			SetMemoryX(0x581DD8,Subtract,1*16777216,0xFF000000); -- 6P
			SetMemoryX(0x581D9C,Subtract,1*65536,0xFF0000); -- 6P
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			MemoryX(0x581DD8,AtMost,192*16777216,0xFF000000);
			MemoryX(0x581D9C,AtMost,192*65536,0xFF0000);
	},
		actions = {
			SetCDeaths(P6,SetTo,0,ColorC);
			PreserveTrigger();
		}
	}
	DoActionsX(P6,{SetCDeaths(P6,Add,1,ColorT),SetCVar(FP,B6_T[2],Subtract,1)})
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CVar(FP,B6_T[2],AtLeast,1);
	},
		actions = {
			SetInvincibility(Enable,12,P6,"Anywhere");
			ModifyUnitShields(All,12,P6,64,100);
			PreserveTrigger();
		}
	}


--최종보스 탱크보스 스킬



	TriggerX(FP,{NBYD},{SetCVar(FP,B6_DPase[2],Subtract,1)},{Preserved})
	TriggerX(FP,{BYD,CVar(FP,B6_DPase2[2],AtLeast,1)},{SetCVar(FP,B6_DPase[2],Subtract,10),SetCVar(FP,B6_DPase2[2],SetTo,0)},{Preserved})
	CIf(P6,{CVar(P6,B6_T[2],AtMost,0),CVar(P6,B6_DPase[2],AtMost,0),CVar(P6,B6_K[2],AtLeast,37),CVar(P6,B6_K[2],AtMost,50)},{SetCVar(FP,B6_DPase[2],Add,10)})
	
	
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))

	CIf(FP,{DeathsX(CurrentPlayer,AtMost,4,0,0xFF),DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)})
	DoActions(P6,{MoveCp(Add,6*4)})
	CIf(P6,TTOR({
	DeathsX(CurrentPlayer,Exactly,MarID[1],0,0xFF),
	DeathsX(CurrentPlayer,Exactly,MarID[2],0,0xFF),
	DeathsX(CurrentPlayer,Exactly,MarID[3],0,0xFF),
	DeathsX(CurrentPlayer,Exactly,MarID[4],0,0xFF),
	DeathsX(CurrentPlayer,Exactly,MarID[5],0,0xFF),
	DeathsX(CurrentPlayer,Exactly,32,0,0xFF),
	DeathsX(CurrentPlayer,Exactly,7,0,0xFF),
	DeathsX(CurrentPlayer,Exactly,20,0,0xFF),
	DeathsX(CurrentPlayer,Exactly,27,0,0xFF),
	}))
	CIfX(FP,NBYD)
	CIf(P6,{TMemory(_Mem(_Mod(_Rand(),100)),AtLeast,90)})
	
	DoActions(P6,{MoveCp(Subtract,25*4)})
	Call_SaveCp()
	
	CIfX(P6,FTR)
	EnergyKill(25)
	CelseX()
	EnergyKill(15)
	CIfXEnd()
	
	CIfX(FP,CDeaths(FP,AtMost,0,EVMode))
	PerDamage(998)
	CElseX()
	PerDamage(333)
	CIfXEnd()

	CAdd(FP,BackupCp,10)
	CMov(P6,CPos,_ReadF(BackupCp))
	CMov(P6,CPosX,_Mov(CPos,0xFFFF))
	CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
	Simple_SetLocX(P6,23,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,47,24,P6)})
	Call_LoadCP()
	DoActions(P6,{MoveCp(Add,15*4)})
	CIfEnd()

	CElseX()
	Call_SaveCp()
	CSub(FP,BackupCp,15)
	CMov(P6,CPos,_ReadF(BackupCp))
	CMov(P6,CPosX,_Mov(CPos,0xFFFF))
	CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
	Simple_SetLocX(P6,23,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,47,24,P6),SetSwitch("Switch 100",Random)})
	Trigger2(FP,{Switch("Switch 100",Set)},{CreateUnit(1,22,24,P8)},{Preserved})
	Call_LoadCP()
	DoActions(P6,{MoveCp(Add,15*4)})

	CIfXEnd()

	CIfEnd()
	DoActions(P6,{MoveCp(Subtract,6*4)})
	CIfEnd()
	CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CAdd(FP,0x6509B0,FP)


CIfEnd()
CIfEnd()


-- 본진버콜이펙트
CIf(P6,Switch("Switch 130",Set))
	CWhile(P6,{CVar(FP,N_A[2],AtMost,359),CVar(FP,S_N_R[2],AtMost,2400)})
		f_lengthdir(P6,S_N_R,N_A,N_X,N_Y)
		CAdd(P6,N_X,2048)
		CAdd(P6,N_Y,2048)
		CTrigger(P6,{
			CVar(FP,N_X[2],AtMost,4096),
			CVar(FP,N_Y[2],AtMost,4096)
			},
		{
			TSetMemory(0x58DC60+20*23,SetTo,_Add(N_X,-32)),
			TSetMemory(0x58DC64+20*23,SetTo,_Add(N_Y,-32)),
			TSetMemory(0x58DC68+20*23,SetTo,_Add(N_X,32)),
			TSetMemory(0x58DC6C+20*23,SetTo,_Add(N_Y,32))
			},1)
		DoActionsX(P6,{SetMemory(0x58F528,SetTo,1),CreateUnit(1,84,24,P6),KillUnit(84,P6),SetCVar(FP,N_A[2],Add,5)})
	CWhileEnd()
	DoActionsX(FP,{SetCVar(FP,N_A[2],SetTo,0),SetCVar(FP,S_N_R[2],Add,20)})
	TriggerX(FP,{CVar(FP,S_N_R[2],AtLeast,2400)},{SetSwitch("Switch 130",Clear),SetCVar(FP,S_N_R[2],SetTo,0)},{Preserved})
CIfEnd()

CIfOnce(P6,{Switch("Switch 215",Set)}) -- onPluginStart
	-- initvar
	
	CMov(FP,0x5821D4+(4*5),3200)
	CMov(FP,0x582234+(4*5),3200)
	for k = 1, 5 do
	Trigger { -- 미션 오브젝트 이지n인
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,1,Difficulty);
			CVar(P6,SetPlayers[2],Exactly,k);
		},
		actions = {
			SetMissionObjectives("\x13\x04마린키우기 \x07Ｍｅｍｏｒｙ\n\x13\x0EＥａｓｙ\x04\x08"..P[k].." \x04플레이 중\n\x13\x17환전률 : \x1B"..Ex1[k].."%\n\x13\x04――――――――――――――――――――――――――――――");
			SetCVar(P6,NexDif[2],SetTo,1);
			SetCVar(P6,ExchangeRate[2],SetTo,Ex1[k]);
			
		},
	}
	Trigger { -- 미션 오브젝트 이지n인
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,2,Difficulty);
			CVar(P6,SetPlayers[2],Exactly,k);
		},
		actions = {
			SetMissionObjectives("\x13\x04마린키우기 \x07Ｍｅｍｏｒｙ\n\x13\x08Ｈａｒｄ\x04\x08"..P[k].." \x04플레이 중\n\x13\x17환전률 : \x1B"..Ex2[k].."%\n\x13\x04――――――――――――――――――――――――――――――");
			SetCVar(P6,NexDif[2],SetTo,1);
			SetCVar(P6,ExchangeRate[2],SetTo,Ex2[k]);
		},
	}
	Trigger { -- 미션 오브젝트 이지n인
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,3,Difficulty);
			CDeaths(P6,AtMost,1,GMode);
			CVar(P6,SetPlayers[2],Exactly,k);
		},
		actions = {
			SetMissionObjectives("\x13\x04마린키우기 \x07Ｍｅｍｏｒｙ\n\x13\x10Ｆｕｔｕｒｅ\x04\x08"..P[k].." \x04플레이 중\n\x13\x17환전률 : \x1B"..Ex3[k].."%\n\x13\x04――――――――――――――――――――――――――――――");
			SetCVar(P6,NexDif[2],SetTo,2);
			SetCVar(P6,ExchangeRate[2],SetTo,Ex3[k]);
		},
	}
	
	Trigger { -- 미션 오브젝트 이지n인
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,3,Difficulty);
			CDeaths(P6,AtLeast,2,GMode);
			CVar(P6,SetPlayers[2],Exactly,k);
		},
		actions = {
			SetMissionObjectives("\x13\x04마린키우기 \x07Ｍｅｍｏｒｙ\n\x13\x06Ｂｅｙｏｎｄ\x04\x08"..P[k].." \x04플레이 중\n\x13\x17환전률 : \x1B"..Ex4[k].."%\n\x13\x04――――――――――――――――――――――――――――――");
			SetCVar(P6,NexDif[2],SetTo,3);
			SetCVar(P6,ExchangeRate[2],SetTo,Ex4[k]);
		},
	}
	end
	
	Trigger {
		players = {P6},
		conditions = {
			NBYD;
			},
		actions = {
			RemoveUnit(82,AllPlayers);
			}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,3,Difficulty);
			CDeaths(P6,AtLeast,2,GMode);
			},
		actions = {
			SetCVar(P6,RednumberSet[2],SetTo,400);
			}
	}
	function Init_VarSet(Table,VVTable)
		for i = 1, #VVTable do
			table.insert(Table,SetCVar("X",VVTable[i][1][2],SetTo,VVTable[i][2]))
		end
	end
	Init_VarSet(initHDTable,{{B6_Dif,1},{B6_Dif2,1},{B6_Dif3,30},{ShP,1600},{B2_K,100000000},{B3_K,80000000},{B4_K,80000000},{B5_K,50000000}})
	Init_VarSet(initFTRTable,{{B6_Dif,2},{B6_Dif2,2},{B6_Dif3,60},{ShP,3200},{B2_K,150000000},{B3_K,120000000},{B4_K,120000000},{B5_K,60000000}})
	Init_VarSet(initBYDTable,{{B6_Dif,3},{B6_Dif2,5},{B6_Dif3,120},{B2_K,200000000},{B3_K,150000000},{B4_K,150000000},{B5_K,80000000}})
	TriggerX(FP,HD,initHDTable)
	TriggerX(FP,FTR,initFTRTable)
	TriggerX(FP,BYD,initBYDTable)
	BYDPatchArr={}
	for i = 1, 5 do
		table.insert(BYDPatchArr,SetMemoryW(0x660E00+(MarID[i]*2),SetTo,1000))
		table.insert(BYDPatchArr,SetMemoryB(0x6647B0+MarID[i],SetTo,1))
	end
	Trigger2(FP,{BYD},{
		BYDPatchArr,
		SetMemory(0x6C9FA8, SetTo, 1132);-- 파리 이동속도 너프
		SetMemory(0x6CA018, SetTo, 1401);-- 파리 이동속도 너프

		SetMemoryX(0x664080+(53*4),SetTo,0x4,0x4), -- 저그 지상 영웅유닛 공중유닛으로 변경
		SetMemoryX(0x664080+(54*4),SetTo,0x4,0x4), -- 저그 지상 영웅유닛 공중유닛으로 변경
		SetMemoryX(0x664080+(104*4),SetTo,0x4,0x4), -- 저그 지상 영웅유닛 공중유닛으로 변경
		SetMemoryX(0x664080+(51*4),SetTo,0x4,0x4), -- 저그 지상 영웅유닛 공중유닛으로 변경
		SetMemoryX(0x664080+(48*4),SetTo,0x4,0x4), -- 저그 지상 영웅유닛 공중유닛으로 변경
		SetMemoryX(0x664080+(25*4),SetTo,0x4,0x4), -- 탱크시즈모드 공중유닛으로 변경
	SetMemory(0x66254C, SetTo, 0);
	SetMemory(0x662608, SetTo, 0);
	SetMemory(0x66260C, SetTo, 0);
	SetMemory(0x662350+(190*4), SetTo, 0);
	SetMemory(0x662350+(201*4), SetTo, 0);
	SetMemory(0x662350+(189*4), SetTo, 0);
	SetMemory(0x662350+(147*4), SetTo, 0);
	SetMemory(0x662350+(148*4), SetTo, 0);
	SetMemory(0x515BA8,SetTo,128);---------크기 8 Fate 데미지반감
	SetMemoryX(0x656554, SetTo, 2*16777216,0xFF000000);

	})
	CWhile(FP,{BYD,Command(P7,AtLeast,1,102)}) -- 배틀변경
		DoActions(FP,{
		SetMemory(0x58DC60 + 0x14*23,SetTo,0),
		SetMemory(0x58DC68 + 0x14*23,SetTo,32),
		SetMemory(0x58DC64 + 0x14*23,SetTo,0),
		SetMemory(0x58DC6C + 0x14*23,SetTo,32),MoveLocation(24,102,P7,64),GiveUnits(1,102,P7,24,P12),RemoveUnit(102,P12),CreateUnit(1,60,24,P7)})
	CWhileEnd()
	
	
	--]]
	CTrigPatchTable = {}
	for i = 0, 15 do
		local UnitTable = {10,17,19,21,25,28,29,3,8,17,21,28,52,57,23,102}
		local UnitTable2 = {63,65,66,67,75,76,77,78,79,88,86,81,80,98,61,75}
		table.insert(CTrigPatchTable,SetVArrayX(VArr(UArr1,i),"Value",SetTo,UnitTable[i+1]))
		table.insert(CTrigPatchTable,SetVArrayX(VArr(UArr2,i),"Value",SetTo,UnitTable2[i+1]))
	end
	for i = 0, 29 do
		local UnitTable3 = {3,8,10,17,19,21,23,25,28,29,52,57,61,63,65,66,67,68,71,75,76,77,78,79,80,81,86,88,98,102}
		table.insert(CTrigPatchTable,SetVArrayX(VArr(UArr3,i),"Value",SetTo,UnitTable3[i+1]))
	end
	for i = 0, 4 do
		table.insert(CTrigPatchTable,SetVArrayX(VArr(MarIDV,i),"Value",SetTo,MarID[i+1]))
	end
	table.insert(CTrigPatchTable,SetCVar("X",B1_K[2],SetTo,100000000))
	table.insert(CTrigPatchTable,SetCVar("X",B6_R[2],SetTo,2000))
	table.insert(CTrigPatchTable,SetCVar("X",Dif[2],SetTo,100))
	DoActions2X(FP,CTrigPatchTable,1)
	--
	CIf(P6,{CDeaths(P6,AtMost,1,Difficulty)})
		CMov(P6,Dif,80)
		CWhile(P6,{CVar(FP,UIndex[2],AtMost,29)})
			CMov(P6,UEPD,_Add(_Mov(VArr(UArr3,UIndex)),EPD(0x662350)))
			CDoActions(P6,{TSetMemory(UEPD,SetTo,_Mul(_Div(_ReadF(UEPD),_Mov(100)),Dif))})
			CAdd(P6,UIndex,1)
		CWhileEnd()
	CIfEnd()
	
	
	Trigger {
		players = {P6},
		actions = {
			SetInvincibility(Disable,132,AllPlayers,64);
			SetInvincibility(Disable,133,AllPlayers,64);
			SetInvincibility(Enable,132,AllPlayers,30);
			SetInvincibility(Enable,132,AllPlayers,31);
			SetInvincibility(Enable,132,AllPlayers,32);
			SetInvincibility(Enable,132,AllPlayers,33);
			SetInvincibility(Enable,132,AllPlayers,40);
			SetInvincibility(Enable,132,AllPlayers,41);
			SetInvincibility(Enable,132,AllPlayers,42);
			SetInvincibility(Enable,132,AllPlayers,43);
			SetInvincibility(Enable,132,AllPlayers,44);
			SetInvincibility(Enable,132,AllPlayers,45);
			SetInvincibility(Enable,132,AllPlayers,46);
			SetInvincibility(Enable,132,AllPlayers,47);
			SetInvincibility(Enable,132,AllPlayers,99);
			SetInvincibility(Enable,132,AllPlayers,100);
			SetInvincibility(Enable,132,AllPlayers,101);
			SetInvincibility(Enable,132,AllPlayers,102);
			SetInvincibility(Enable,132,AllPlayers,103);
			SetInvincibility(Enable,132,AllPlayers,104);
			SetInvincibility(Enable,132,AllPlayers,105);
			SetInvincibility(Enable,132,AllPlayers,106);
			GiveUnits(1,132,AllPlayers,79,2);
			GiveUnits(1,132,AllPlayers,80,2);
			GiveUnits(1,132,AllPlayers,81,3);
			GiveUnits(1,132,AllPlayers,82,3);
			GiveUnits(1,132,AllPlayers,83,4);
			GiveUnits(1,132,AllPlayers,84,4);
			GiveUnits(1,132,AllPlayers,85,5);
			GiveUnits(1,132,AllPlayers,86,5);
			GiveUnits(1,132,AllPlayers,87,6);
			GiveUnits(1,132,AllPlayers,88,6);
			GiveUnits(1,132,AllPlayers,89,7);
			GiveUnits(1,132,AllPlayers,90,7);
			GiveUnits(1,132,AllPlayers,91,8);
			GiveUnits(1,132,AllPlayers,92,8);
			GiveUnits(1,132,AllPlayers,93,9);
			GiveUnits(1,132,AllPlayers,94,9);
			GiveUnits(1,132,AllPlayers,25,10);
			GiveUnits(1,132,AllPlayers,26,10);
			GiveUnits(1,132,AllPlayers,27,11);
			GiveUnits(1,132,AllPlayers,28,11);
			GiveUnits(1,132,AllPlayers,30,2);
			GiveUnits(1,132,AllPlayers,31,2);
			GiveUnits(1,132,AllPlayers,32,3);
			GiveUnits(1,132,AllPlayers,33,3);
			GiveUnits(1,132,AllPlayers,40,4);
			GiveUnits(1,132,AllPlayers,41,4);
			GiveUnits(1,132,AllPlayers,42,5);
			GiveUnits(1,132,AllPlayers,43,5);
			GiveUnits(1,132,AllPlayers,44,6);
			GiveUnits(1,132,AllPlayers,45,6);
			GiveUnits(1,132,AllPlayers,46,7);
			GiveUnits(1,132,AllPlayers,47,7);
			GiveUnits(1,132,AllPlayers,99,8);
			GiveUnits(1,132,AllPlayers,100,8);
			GiveUnits(1,132,AllPlayers,101,9);
			GiveUnits(1,132,AllPlayers,102,9);
			GiveUnits(1,132,AllPlayers,103,10);
			GiveUnits(1,132,AllPlayers,104,10);
			GiveUnits(1,132,AllPlayers,105,11);
			GiveUnits(1,132,AllPlayers,106,11);
		}
	}
	
	Trigger {
		players = {P6},
		actions = {
			SetInvincibility(Enable,133,AllPlayers,52);
			SetInvincibility(Enable,133,AllPlayers,53);
			SetInvincibility(Enable,133,AllPlayers,54);
			SetInvincibility(Enable,133,AllPlayers,55);
			SetInvincibility(Enable,133,AllPlayers,107);
			SetInvincibility(Enable,133,AllPlayers,108);
			SetInvincibility(Enable,133,AllPlayers,109);
			SetInvincibility(Enable,133,AllPlayers,110);
			SetInvincibility(Enable,133,AllPlayers,48);
			SetInvincibility(Enable,133,AllPlayers,49);
			SetInvincibility(Enable,133,AllPlayers,50);
			SetInvincibility(Enable,133,AllPlayers,51);
			GiveUnits(1,133,AllPlayers,36,0);
			GiveUnits(1,133,AllPlayers,37,1);
			GiveUnits(1,133,AllPlayers,38,2);
			GiveUnits(1,133,AllPlayers,39,3);
			GiveUnits(1,133,AllPlayers,97,4);
			GiveUnits(1,133,AllPlayers,98,5);
			GiveUnits(1,133,AllPlayers,95,6);
			GiveUnits(1,133,AllPlayers,96,7);
			GiveUnits(1,133,AllPlayers,56,8);
			GiveUnits(1,133,AllPlayers,57,9);
			GiveUnits(1,133,AllPlayers,08,10);
			GiveUnits(1,133,AllPlayers,09,11);
			GiveUnits(1,133,AllPlayers,52,0);
			GiveUnits(1,133,AllPlayers,53,1);
			GiveUnits(1,133,AllPlayers,54,2);
			GiveUnits(1,133,AllPlayers,55,3);
			GiveUnits(1,133,AllPlayers,107,4);
			GiveUnits(1,133,AllPlayers,108,5);
			GiveUnits(1,133,AllPlayers,109,6);
			GiveUnits(1,133,AllPlayers,110,7);
			GiveUnits(1,133,AllPlayers,48,8);
			GiveUnits(1,133,AllPlayers,49,9);
			GiveUnits(1,133,AllPlayers,50,10);
			GiveUnits(1,133,AllPlayers,51,11);
	
		}
	}
	-- CunitCtrig1 Start -- RecoverCPV = BackupCp
	
	
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(P6,DeathsX(CurrentPlayer,AtLeast,5,0,0xFF))
			DoActions(P6,MoveCp(Add,0x64-0x4C))
			CIf(P6,DeathsX(CurrentPlayer,Exactly,190,0,0xFF))
				DoActions(P6,MoveCp(Subtract,0x64-0x4C))
				CIf(P6,DeathsX(CurrentPlayer,Exactly,6,0,0xFF))
					SaveCp(P6,Dis_1) -- --17
					CSub(P6,Dis_1,17)
				CIfEnd()
				CIf(P6,DeathsX(CurrentPlayer,Exactly,7,0,0xFF))
					SaveCp(P6,Dis_2) -- --17
					CSub(P6,Dis_2,17)
				CIfEnd()
				DoActions(P6,MoveCp(Add,0x64-0x4C))
			CIfEnd()
			CIf(P6,DeathsX(CurrentPlayer,Exactly,64,0,0xFF))
				SaveCp(P6,B1_H) -- -23
				CSub(P6,B1_H,23)
			CIfEnd()
			CIf(P6,DeathsX(CurrentPlayer,Exactly,87,0,0xFF))
				SaveCp(P6,B2_H)
				CSub(P6,B2_H,23)
			CIfEnd()
			CIf(P6,DeathsX(CurrentPlayer,Exactly,74,0,0xFF))
				SaveCp(P6,B3_H)
				CSub(P6,B3_H,23)
			CIfEnd()
			CIf(P6,DeathsX(CurrentPlayer,Exactly,30,0,0xFF))
				SaveCp(P6,B4_H)
				CSub(P6,B4_H,23)
			CIfEnd()
			CIf(P6,DeathsX(CurrentPlayer,Exactly,2,0,0xFF))
				SaveCp(P6,B5_H)
				CSub(P6,B5_H,23)
			CIfEnd()
			CIf(P6,DeathsX(CurrentPlayer,Exactly,12,0,0xFF))
				SaveCp(P6,B6_H)
				CSub(P6,B6_H,23)
			CIfEnd()
			CIf(P6,DeathsX(CurrentPlayer,Exactly,82,0,0xFF))
				SaveCp(P6,B7_H)
				CSub(P6,B7_H,23)
				CDoActions(FP,{TSetMemory(B7_H,SetTo,8000000*256)})
			CIfEnd()
			
			
			CIfX(P6,TTOR({
				DeathsX(CurrentPlayer,Exactly,175,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,130,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,200,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,150,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,147,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,148,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,201,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,189,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,151,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,152,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,126,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,127,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,25,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,173,0,0xFF),
				DeathsX(CurrentPlayer,Exactly,190,0,0xFF)
			}))
				DoActions(P6,{
				MoveCp(Add,0xDC-0x64),
				SetDeathsX(CurrentPlayer,SetTo,0xB00,0,0xB00),
				MoveCp(Subtract,0xDC-0x94),
				SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000),
				MoveCp(Add,0xE4-0x94),
				SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFFFFFF),
				MoveCp(Subtract,0xE4-0x64)})
			CIfXEnd()
			
			CIf(P6,DeathsX(CurrentPlayer,Exactly,125,0,0xFF))
				DoActions(P6,{
					MoveCp(Add,0xDC-0x64),
					SetDeathsX(CurrentPlayer,SetTo,0xA00000,0,0xA00000),
					MoveCp(Subtract,0xDC-0x64)
				})
			CIfEnd()
			DoActions(P6,{MoveCp(Subtract,6*4)})
			
		CIfEnd()
		DoActions(P6,{MoveCp(Add,6*4)})
		NIf(P6,DeathsX(CurrentPlayer,Exactly,132,0,0xFF))
			DoActions(P6,{MoveCp(Subtract,6*4)})
			for i = 0, 9 do
				NIf(P6,DeathsX(CurrentPlayer,Exactly,i+2,0,0xFF))
					DoActions(P6,{MoveCp(Add,36*4)})
					Trigger {
						players = {P6},
						conditions = {
							DeathsX(CurrentPlayer,Exactly,0,0,0x04000000);
					},
						actions = {
							MoveCp(Subtract,46*4);
							SetDeathsX(CurrentPlayer,SetTo,i*0x10000,0,0xFF0000);
							MoveCp(Add,46*4);
							PreserveTrigger();
						}
					}
					Trigger {
						players = {P6},
						conditions = {
							DeathsX(CurrentPlayer,Exactly,0x04000000,0,0x04000000);
					},
						actions = {
							MoveCp(Subtract,46*4);
							SetDeathsX(CurrentPlayer,SetTo,(i+10)*0x10000,0,0xFF0000);
							MoveCp(Add,46*4);
							PreserveTrigger();
						}
					}
					DoActions(P6,{MoveCp(Subtract,36*4)})
				NIfEnd()
			end
			DoActions(P6,{MoveCp(Add,6*4)})
		NIfEnd()
		NIf(P6,DeathsX(CurrentPlayer,Exactly,133,0,0xFF))
			DoActions(P6,{MoveCp(Subtract,6*4)})
			for i = 0, 11 do
				NIf(P6,DeathsX(CurrentPlayer,Exactly,i,0,0xFF))
					DoActions(P6,{MoveCp(Add,36*4)})
					Trigger {
						players = {P6},
						conditions = {
							DeathsX(CurrentPlayer,Exactly,0,0,0x04000000);
					},
						actions = {
							MoveCp(Subtract,46*4);
							SetDeathsX(CurrentPlayer,SetTo,i*0x10000,0,0xFF0000);
							MoveCp(Add,46*4);
							PreserveTrigger();
						}
					}
					Trigger {
						players = {P6},
						conditions = {
							DeathsX(CurrentPlayer,Exactly,0x04000000,0,0x04000000);
					},
						actions = {
							MoveCp(Subtract,46*4);
							SetDeathsX(CurrentPlayer,SetTo,(i+12)*0x10000,0,0xFF0000);
							MoveCp(Add,46*4);
							PreserveTrigger();
						}
					}
					DoActions(P6,{MoveCp(Subtract,36*4)})
				NIfEnd()
			end
			DoActions(P6,{MoveCp(Add,6*4)})
		NIfEnd()
		DoActions(P6,{MoveCp(Subtract,6*4)})
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	
	
	
	InitPatchTable = {}

	for i = 0, 11 do
			table.insert(InitPatchTable,GiveUnits(All,132,i,153,6))
			table.insert(InitPatchTable,GiveUnits(All,132,i,154,7))
			table.insert(InitPatchTable,GiveUnits(All,132,i,155,7))
			table.insert(InitPatchTable,GiveUnits(All,132,i,156,6))
			table.insert(InitPatchTable,GiveUnits(All,133,i,153,6))
			table.insert(InitPatchTable,GiveUnits(All,133,i,154,7))
			table.insert(InitPatchTable,GiveUnits(All,133,i,155,7))
			table.insert(InitPatchTable,GiveUnits(All,133,i,156,6))
	end
		SetInvincibility(Disable,132, AllPlayers,"Anywhere");
		table.insert(InitPatchTable,SetInvincibility(Disable,133, AllPlayers,"Anywhere"))
		DoActions2(FP,InitPatchTable)
	DifScoreBonus = {10,10,20,40,50}
	ModeScoreBonus = {5,10,20,30}
	for i = 1, 5 do
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CDeaths(FP,Exactly,i,DifID);
		},
			actions = {
				SetCVar(FP,DifScoreBonusV[2],SetTo,DifScoreBonus[i])
			}
		}
	end
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,0,EVMode);
			CDeaths(FP,Exactly,0,GMode);
	},
		actions = {
			SetCVar(FP,ModeScoreBonusV[2],SetTo,ModeScoreBonus[2])
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(FP,AtLeast,1,EVMode);
	},
		actions = {
			SetCVar(FP,ModeScoreBonusV[2],SetTo,ModeScoreBonus[1])
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,1,GMode);
	},
		actions = {
			SetCVar(FP,ModeScoreBonusV[2],SetTo,ModeScoreBonus[3])
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(FP,Exactly,2,GMode);
	},
		actions = {
			SetCJump(0x510,1);
			SetCVar(FP,ModeScoreBonusV[2],SetTo,ModeScoreBonus[4])
		}
	}
	CMul(FP,ScoreBonusV,DifScoreBonusV,ModeScoreBonusV)
CIfEnd() -- onPluginStart End

--각 마린 연결리스트 코드. BYD 난이도 한정. Main : FP
MarListLength = 5 -- 배열의 길이
MarListSize = 95 -- 배열의 크기
MarListCurrentArr = CreateVar()

MarListTempTarget = CreateVar()
MarListTempHeader = CreateVar()
MarListTempVar = CreateVar()
MarListTempVar2 = CreateVar()
MarListTempVar3 = CreateVar()
MarListTempVar4 = CreateVar()
MarListTempVar5 = CreateVar()
MarListTempVar6 = CreateVar()
MarListTempVar7 = CreateVar()
MarListTempVar8 = CreateVar()
MarListTempVar9 = CreateVar()
MarListTempPos = CreateVar()
MarListTempPosX = CreateVar()
MarListTempPosY = CreateVar()
		TempMarListSkillLv = CreateVar()
		MarListCurrentPlayer = CreateVar()
B7_K = CreateVar()
VariableSetTable = {{},{},{},{},{}}
VariableSetTable2 = {{},{},{},{},{}}





CIf(FP,{BYD})
	--f_MemCpyEPD(P6,EPD(0x58F700), MarListHeader[1],2*4)
	--f_MovCpyEPD(P6,EPD(0x58F700)+(2), _Add(MarListHeader[1],1*(0x970/4)),2*4)
	--f_MovCpyEPD(P6,EPD(0x58F700)+(4), _Add(MarListHeader[1],2*(0x970/4)),2*4)
	--f_MovCpyEPD(P6,EPD(0x58F700)+(6), _Add(MarListHeader[1],3*(0x970/4)),2*4)
	--f_MovCpyEPD(P6,EPD(0x58F700)+(8), _Add(MarListHeader[1],4*(0x970/4)),2*4)
	--f_MovCpyEPD(P6,EPD(0x58F700)+(10),_Add(MarListHeader[1],5*(0x970/4)),2*4)
KeyUpText = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＵＰＧＲＡＤＥ\x04　！！！\n\n\n\x13\x1F\x10【 K\x04ey \x10】\x04가 파괴되어 \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e \x04의 \x16빛\x04이 \x03강화\x03되었습니다.\n\n\n\x13\x04！！！　\x07ＵＰＧＲＡＤＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
ShText = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x08HP 130,000\x04 돌파, \x1C빛의 보호막\x04이 \x03활성화\x04되었습니다.\n \n\n\x13\x04！！！　\x07ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"

	for i = 0, 3 do
		Trigger2(FP,Command(Force2,Exactly,i,150),{
			RotatePlayer({
			DisplayTextX(KeyUpText,4),
			PlayWAVX("staredit\\wav\\start.ogg"),
			PlayWAVX("staredit\\wav\\start.ogg"),
			PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP),
			SetCDeaths(FP,Add,1,BYDAttackUpgrade)
		})
	end

		CJump(FP,0x625)
		CallMarSkill =  SetCallForward()
		SetCall(FP)
			Call_SaveCp()
			for i = 1, 5 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					CVar(FP,MarListCurrentPlayer[2],Exactly,i-1);
				},
				actions = {
					SetCtrig1X("X",TempMarListSkillLv[2],0x15C,"X",SetTo,0);
					SetCtrig1X("X",MarListSkillLv[i][2],0x148,"X",SetTo,0xFFFFFFFF);
					SetCtrig1X("X",MarListSkillLv[i][2],0x160,"X",SetTo,Add*16777216,0xFF000000);
					SetCtrigX("X",MarListSkillLv[i][2],0x158,"X",SetTo,"X",TempMarListSkillLv[2],0x15C,1,"X");
					CallLabel1("X",MarListSkillLv[i][2],"X")
				},
				flag = {Preserved}
			}
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					CVar(FP,MarListCurrentPlayer[2],Exactly,i-1);
				},
				actions = {
					CallLabel2("X",MarListSkillLv[i][2],"X")
				},
				flag = {Preserved}
			}
			end

			CIfX(FP,{TMemoryX(_Add(BackupCp,50),AtLeast,1*256,0xFF00)})
			CDoActions(FP,{TSetMemory(_Add(MarListTempHeader,3*(0x20/4)),SetTo,_Sub(_Mov(270),TempMarListSkillLv))})
			CelseX()
			CDoActions(FP,{TSetMemory(_Add(MarListTempHeader,3*(0x20/4)),SetTo,_Sub(_Mov(280),TempMarListSkillLv))})
			CIfXEnd()
			CSub(FP,BackupCp,9)
			f_Read(FP,BackupCp,MarListTempPos)
			CMov(FP,MarListTempPosX,MarListTempPos,0,0xFFF)
			CMov(FP,MarListTempPosY,_Div(MarListTempPos,_Mov(65536)))
			Simple_SetLocX(FP,23,_Sub(MarListTempPosX,32),_Sub(MarListTempPosY,32),_Add(MarListTempPosX,32),_Add(MarListTempPosY,32))
			
			MarSkillCA = CAPlotForward()
			CMov(FP,V(MarSkillCA[6]),1)
			CMov(FP,V(MarSkillCA[5]),6)
			for i = 0, 4 do
			TriggerX(FP,{PlayerCheck(i,1)},{SetCVar(FP,MarSkillCA[5],Subtract,1)},{Preserved})
			end
			SkillShape = {}
			function MarListSkillUnitFunc()
				CIf(FP,Memory(0x628438,AtLeast,1))
				f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
				CDoActions(FP,{
					TCreateUnit(1,179,24,MarListCurrentPlayer),
					TSetDeathsX(_Add(Nextptrs,19),SetTo,152*256,0,0xFF00),
					TSetDeaths(_Add(Nextptrs,22),SetTo,2048+(2048*65536),0),
				})
				CIfEnd()
			end
				CAPlot({CSMakePolygon(4,128,0,5,0)},FP,181,23,nil,1,1,{1,0,0,0,6,0},nil,FP,nil,nil,1,"MarListSkillUnitFunc")
			--CreateUnitPolygonSafe2Gun(FP,Bring(Force2,Exactly,0+j,150,64),5-j,23,32,128,0,4,1,i-1, {1,179})

			CAdd(FP,BackupCp,9)
			Call_LoadCp()
		SetCallEnd()
		MarListCallTrigger = SetCallForward()
		SetCall(FP)
			CMov(FP,0x6509B0,MarListTempVar,19)
			NIf(FP,DeathsX(CurrentPlayer,Exactly,0,0,0xFF00))
				CJumpEnd(FP,0x646)
				CAdd(FP,0x6509B0,21)
				Call_SaveCp()
				NIfX(FP,{DeathsX(CurrentPlayer,AtLeast,200*16777216,0,0xFF000000),
					CVar(FP,MarListTempVar5[2],AtMost,0)})
					DoActions(FP,SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF000000))
					Call_SaveCp()
					NJump(FP,0x640,{Memory(0x628438,AtMost,0)},{TSetMemory(0x6509B0,SetTo,MarListCurrentPlayer),
						PlayWAV("staredit\\wav\\revive.ogg"),
						DisplayText("\x12\x07『 \x08ERROR : \x04변수(Nextptrs)를 찾을 수 없습니다. \x07소생 \x04위치를 본진으로 설정합니다.\x07』",4),
						SetMemory(0x6509B0,SetTo,FP),
						
						TSetMemory(_TMem(VArr(PlayerMarCreateToken,MarListCurrentPlayer)),Add,1)
					})
					f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
					CDoActions(FP,{
						TSetMemory(MarListTempHeader,SetTo,Nextptrs),
						TSetMemory(_Add(MarListTempHeader,1*(0x20/4)),SetTo,0),
						TSetMemory(_Add(MarListTempHeader,2*(0x20/4)),SetTo,0),
						TSetMemory(_Add(MarListTempHeader,3*(0x20/4)),SetTo,0),
						TSetMemory(_Add(MarListTempHeader,4*(0x20/4)),SetTo,600*24),
						TSetMemory(_Add(MarListTempHeader,5*(0x20/4)),SetTo,30*24),
						TSetMemory(_Add(MarListTempHeader,6*(0x20/4)),SetTo,0),
						TSetMemory(_Add(MarListTempHeader,7*(0x20/4)),SetTo,0),
						TSetMemory(_Add(MarListTempHeader,8*(0x20/4)),SetTo,0),
					})
					CSub(FP,BackupCp,30)
					f_Read(FP,BackupCp,MarListTempPos)
					CAdd(FP,BackupCp,30)
					CMov(FP,MarListTempPosX,MarListTempPos,0,0xFFF)
					CMov(FP,MarListTempPosY,_Div(MarListTempPos,_Mov(65536)))
					TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPRecover},{Preserved})
					Simple_SetLocX(FP,23,_Sub(MarListTempPosX,32),_Sub(MarListTempPosY,32),_Add(MarListTempPosX,32),_Add(MarListTempPosY,32))
						CDoActions(FP,{TCreateUnitWithProperties(1,VArr(MarIDV,MarListCurrentPlayer),24,MarListCurrentPlayer,{energy = 1}),
						TSetMemory(0x6509B0,SetTo,MarListCurrentPlayer),
						PlayWAV("staredit\\wav\\revive.ogg"),
						DisplayText("\x12\x07『 \x16빛\x04을 잃은 \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e \x04이 \x16빛\x04의 \x03축복\x04을 받아 \x07소생하였습니다. \x1B(재사용 대기시간 : 10분) \x07』",4),
						SetMemory(0x6509B0,SetTo,FP),
						SetCDeaths(FP,SetTo,1,MarCreate),
						RunAIScriptAt("Recall Here",24)})
						f_Read(FP,_Add(Nextptrs,0x28/4),MarListTempTarget)
					CIf(FP,{TMemoryX(_Add(Nextptrs,19),Exactly,2*256,0xFF00)})
					CDoActions(FP,{
						TSetMemory(_Add(Nextptrs,0x5C/4),SetTo,0),
						TSetMemory(_Add(Nextptrs,0x18/4),SetTo,MarListTempTarget),
						TSetMemory(_Add(Nextptrs,0x58/4),SetTo,MarListTempTarget),
						TSetMemory(_Add(Nextptrs,0x10/4),SetTo,MarListTempTarget),
						TSetMemoryX(_Add(Nextptrs,19),SetTo,107*256,0xFF00),
					})
					CIfEnd()
					TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPPatch},{Preserved})
					CMov(FP,BackupCp,Nextptrs,40)
					Call_LoadCp()
					NElseX()
					Call_SaveCp()
					NJumpEnd(FP,0x640)
					CDoActions(FP,{
						TSetMemory(MarListTempHeader,SetTo,0),
					})
					Call_LoadCp()
					CJump(FP,0x645)
				NIfXEnd()
				CSub(FP,0x6509B0,21)
			NIfEnd()
			CIf(FP,{Command(Force2,AtMost,0,156),CVar(FP,MarListTempVar4[2],AtMost,0)})
				CIf(FP,DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00))
					CallTrigger(FP,CallMarSkill)
				CIfEnd()
				CIf(FP,DeathsX(CurrentPlayer,Exactly,107*256,0,0xFF00))
					CAdd(FP,0x6509B0,4)
					CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
						CSub(FP,0x6509B0,4)
						CallTrigger(FP,CallMarSkill)
						CAdd(FP,0x6509B0,4)
					CIfEnd()
					CSub(FP,0x6509B0,4)
				CIfEnd()
			CIfEnd()
			NJump(FP,0x631,{Memory(0x58A364,AtMost,129999)})
				CSub(FP,0x6509B0,17)
				NIf(FP,{Deaths(CurrentPlayer,AtMost,80000*256,0)})
					NJump(FP,0x635,{CVar(FP,MarListTempVar3[2],AtLeast,1)})

					NIf(FP,{TDeaths(CurrentPlayer,Exactly,MarListTempVar2,0)})
						CJump(FP,0x630)
					NIfEnd()
					Call_SaveCp()
					CMov(FP,MarListTempVar2,_ReadF(BackupCp))

					CDoActions(FP,{
						TSetMemory(_Add(MarListTempHeader,1*(0x20/4)),SetTo,MarListTempVar2),
					})

					CIf(FP,{TMemory(_Mem(_Mod(_Rand(),80000*256)),AtLeast,_Sub(_Mov(80000*256),MarListTempVar2))})
						CDoActions(FP,{
							TSetMemory(_Add(MarListTempHeader,2*(0x20/4)),SetTo,1400),
						})
						CAdd(FP,BackupCp,8)
						f_Read(FP,BackupCp,MarListTempPos)
						CSub(FP,BackupCp,8)
						CMov(FP,MarListTempPosX,MarListTempPos,0,0xFFF)
						CMov(FP,MarListTempPosY,_Div(MarListTempPos,_Mov(65536)))
						Simple_SetLocX(FP,23,_Sub(MarListTempPosX,32),_Sub(MarListTempPosY,32),_Add(MarListTempPosX,32),_Add(MarListTempPosY,32),
							{CreateUnit(1,94,24,FP),KillUnit(94,FP)})
					CIfEnd()
					Call_LoadCp()
				NIfEnd()
				CJumpEnd(FP,0x630)
				NJumpEnd(FP,0x635)
				CAdd(FP,0x6509B0,17)
			NJumpEnd(FP,0x631)
			NIf(FP,{TDeaths(MarListCurrentPlayer,AtLeast,1,34)})
				CAdd(FP,0x6509B0,5)
				CIfX(FP,DeathsX(CurrentPlayer,AtMost,750*256,0,0xFFFFFF))
					DoActions(FP,SetDeathsX(CurrentPlayer,Add,250*256,0,0xFFFFFF))
					CelseX()
					DoActions(FP,SetDeathsX(CurrentPlayer,SetTo,1000*256,0,0xFFFFFF))
				CIfXEnd()
				CSub(FP,0x6509B0,5)
			NIfEnd()
			NIf(FP,CVar(FP,MarListTempVar3[2],AtLeast,700))
				CAdd(FP,0x6509B0,5)
				DoActions(FP,SetDeathsX(CurrentPlayer,SetTo,1000*256,0,0xFFFFFF))
				CSub(FP,0x6509B0,22)


				CIfX(FP,Deaths(CurrentPlayer,AtMost,124999*256,0))
					DoActions(FP,SetDeaths(CurrentPlayer,Add,5000*256,0))
					CelseX()
					DoActions(FP,SetDeaths(CurrentPlayer,SetTo,130000*256,0))
				CIfXEnd()
				CAdd(FP,0x6509B0,17)
			NIfEnd()
			NIf(FP,CVar(FP,MarListTempVar6[2],AtLeast,1))
				CSub(FP,0x6509B0,17)
				DoActions(FP,SetDeaths(CurrentPlayer,SetTo,130000*256,0))
				CAdd(FP,0x6509B0,22)
				DoActions(FP,SetDeathsX(CurrentPlayer,SetTo,5000*256,0,0xFFFFFF))
				CSub(FP,0x6509B0,5)

				NIf(FP,{TTOR({
					CVar(FP,MarListTempVar6[2],Exactly,50),
					CVar(FP,MarListTempVar6[2],Exactly,100),
					CVar(FP,MarListTempVar6[2],Exactly,150),
					CVar(FP,MarListTempVar6[2],Exactly,200)
				})})
					CSub(FP,0x6509B0,9)
					Call_SaveCp()
					f_Read(FP,BackupCp,MarListTempPos)
					CMov(FP,MarListTempPosX,MarListTempPos,0,0xFFF)
					CMov(FP,MarListTempPosY,_Div(MarListTempPos,_Mov(65536)))
					Simple_SetLocX(FP,23,_Sub(MarListTempPosX,32),_Sub(MarListTempPosY,32),_Add(MarListTempPosX,32),_Add(MarListTempPosY,32),
						{CreateUnitWithProperties(1,95,24,FP,{hallucinated = true}),KillUnit(95,FP)})
					Call_LoadCp()
					CAdd(FP,0x6509B0,9)
				NIfEnd()
			NIfEnd()
			NIf(FP,CDeaths(FP,AtLeast,1,BYDBossStart))
				NIf(FP,{CVar(FP,MarListTempVar6[2],AtMost,0),CVar(FP,MarListTempVar7[2],AtLeast,1)})
					CAdd(FP,0x6509B0,5)
					DoActions(FP,SetDeathsX(CurrentPlayer,SetTo,0*256,0,0xFFFFFF))
					CSub(FP,0x6509B0,5)
				NIfEnd()
				CAdd(FP,0x6509B0,36)
				NIf(FP,{DeathsX(CurrentPlayer,Exactly,0x04000000,0,0x04000000)},SetDeathsX(CurrentPlayer,SetTo,0,0,0x04000000))
					NIfX(FP,{CVar(FP,MarListTempVar7[2],AtMost,0)})

						CDoActions(FP,{TSetMemory(_Add(MarListTempHeader,5*(0x20/4)),SetTo,250),TSetMemory(_Add(MarListTempHeader,6*(0x20/4)),SetTo,1),TSetMemory(_Add(MarListTempHeader,7*(0x20/4)),SetTo,5*60*24)})
						CSub(FP,0x6509B0,45)
						Call_SaveCp()
						f_Read(FP,BackupCp,MarListTempPos)
						CMov(FP,MarListTempPosX,MarListTempPos,0,0xFFF)
						CMov(FP,MarListTempPosY,_Div(MarListTempPos,_Mov(65536)))
						Simple_SetLocX(FP,23,_Sub(MarListTempPosX,32),_Sub(MarListTempPosY,32),_Add(MarListTempPosX,32),_Add(MarListTempPosY,32),
							{CreateUnit(1,95,24,FP),KillUnit(95,FP)})
						Call_LoadCp()
						CAdd(FP,0x6509B0,45)

					NElseIfX(CVar(FP,MarListTempVar6[2],AtMost,0))
					CSub(FP,0x6509B0,36)
					DoActions(FP,SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00))
					CJump(FP,0x646)
					NIfXEnd()
					NIfX(FP,{CVar(FP,MarListTempVar7[2],AtLeast,1),CVar(FP,MarListTempVar8[2],AtMost,0)})
						CDoActions(FP,{TSetMemory(_Add(MarListTempHeader,6*(0x20/4)),SetTo,0)})
					NIfXEnd()

				NIfEnd()
				CSub(FP,0x6509B0,36)
			NIfEnd()

			CJumpEnd(FP,0x645)
			CMov(FP,0x6509B0,FP) --CP Trick End
		SetCallEnd()

		CJumpEnd(FP,0x625)

	for i = 1, 5 do 
	TriggerX(FP,{CDeaths(FP,AtLeast,i,BYDAttackUpgrade)},{SetMemoryX(0x657764,Add,25*65536,0xFFFF0000)})
	
	
	Trigger2(FP,Memory(0x58F464+((i-1)*4),AtLeast,130000),{
		SetMemory(0x6509B0,SetTo,i-1),
		DisplayText(ShText,4),
		PlayWAV("staredit\\wav\\BYD_shieldunlock.ogg"),
		PlayWAV("staredit\\wav\\BYD_shieldunlock.ogg"),
		PlayWAV("staredit\\wav\\BYD_shieldunlock.ogg"),
		PlayWAV("staredit\\wav\\BYD_shieldunlock.ogg"),
		PlayWAV("staredit\\wav\\BYD_shieldunlock.ogg"),
		SetMemory(0x6509B0,SetTo,FP)
	})
	
		CIf(FP,PlayerCheck(i-1,1))
		   CMov(FP,0x5821D4+((i-1)*4),MaxHPP)
		   CMov(FP,0x582234+((i-1)*4),MaxHPP)
			CIfX(FP,MemoryB(0x58D2B0+((i-1)*46)+7,AtMost,254))
			CMov(FP,MarListSkillLv[i],_Div(_ReadF(AtkUpgradePtrArr[i],255*(256^AtkUpgradeMaskRetArr[i])),_Mov(256^AtkUpgradeMaskRetArr[i])))
			CElseX()
			CMov(FP,MarListSkillLv[i],255)
			CIfXEnd()
			CIf(FP,{Memory(0x628438,AtLeast,1),CVAar(VArr(PlayerMarCreateToken,i-1),AtLeast,1),Bring(i-1,AtMost,95,MarID[i],64)}) -- 소환 또는 조합시
				
				CMov(FP,MarListCurrentArr,0)
				CJumpEnd(FP,0x619+i)
				NJump(FP,0x635+i,CVar(FP,MarListCurrentArr[2],AtLeast,MarListSize+1))
				CAdd(FP,MarListTempVar,_Mul(MarListCurrentArr,(0x970/4)),MarListHeader[i])
				NIf(FP,{TMemory(MarListTempVar,AtLeast,1),CVar(FP,MarListCurrentArr[2],AtMost,MarListSize)},{SetCVar(FP,MarListCurrentArr[2],Add,1)})
					CJump(FP,0x619+i)
				NIfEnd()
				f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
				CDoActions(FP,{
					TSetMemory(MarListTempVar,SetTo,Nextptrs),
					TSetMemory(_Add(MarListTempVar,1*(0x20/4)),SetTo,0),
					TSetMemory(_Add(MarListTempVar,2*(0x20/4)),SetTo,0),
					TSetMemory(_Add(MarListTempVar,3*(0x20/4)),SetTo,0),
					TSetMemory(_Add(MarListTempVar,4*(0x20/4)),SetTo,0),
					TSetMemory(_Add(MarListTempVar,5*(0x20/4)),SetTo,0),
					TSetMemory(_Add(MarListTempVar,6*(0x20/4)),SetTo,0),
					TSetMemory(_Add(MarListTempVar,7*(0x20/4)),SetTo,0),
					TSetMemory(_Add(MarListTempVar,8*(0x20/4)),SetTo,0),
				})
				TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPRecover},{Preserved})
				DoActions(FP,{CreateUnitWithProperties(1,MarID[i],203+i,i-1,{energy = 100}),SetCDeaths(FP,SetTo,1,MarCreate)})
				TriggerX(FP,{CDeaths(FP,AtLeast,1,BYDBossStart2)},{BYDBossMarHPPatch},{Preserved})
				DoActionsX(FP,SetCVAar(VArr(PlayerMarCreateToken,i-1),Subtract,1))
				NJumpEnd(FP,0x635+i)
			CIfEnd()
			--CP Trick Start
		
	--
		for j = 0, MarListSize do
			CTrigger(P6, {CVar("X","X",AtLeast,1)}, {
				SetCVar(P6,MarListTempVar[2],SetTo,0), -- 0x15C
				SetCVar(P6,MarListTempVar2[2],SetTo,0), -- 0x17C
				SetCVar(P6,MarListTempVar3[2],SetTo,0), -- 0x19C
				SetCVar(P6,MarListTempVar4[2],SetTo,0), -- 0x1BC
				SetCVar(P6,MarListTempVar5[2],SetTo,0), -- 0x1DC
				SetCVar(P6,MarListTempVar6[2],SetTo,0), -- 0x1FC
				SetCVar(P6,MarListTempVar7[2],SetTo,0), -- 0x21C
				SetCVar(P6,MarListTempVar8[2],SetTo,0), -- 0x23C
				SetCVar(P6,MarListTempVar9[2],SetTo,0), -- 0x25C
				SetCVar(P6,MarListCurrentPlayer[2],SetTo,i-1), -- 0x25C
				SetCtrigX("X",0x631+0xC000,0xC + 0x14*1,0,SetTo,"X",MarHP[i][2],0x15C,1,0),
				SetCtrigX("X",MarListTempHeader[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
				SetNext("X",MarListCallTrigger,0),SetNext(MarListCallTrigger+1,"X",1), -- Go To MarListCallTrigger
				SetCtrigX("X",MarListCallTrigger+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
				SetCtrigX("X",MarListCallTrigger+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
				SetCtrig1X("X",MarListCallTrigger+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
				}, 1, 0x200+j+((i-1)*0x100))
			for k = 2, 5 do
				table.insert(VariableSetTable[i],SetCtrig1X("X",0x200+j+((i-1)*0x100),0x15C+(k*0x20),0,Subtract,1))
			end
				table.insert(VariableSetTable[i],SetCtrig1X("X",0x200+j+((i-1)*0x100),0x15C+(7*0x20),0,Subtract,1))
	
		end
	
			DoActions2X(FP,VariableSetTable[i])
		CIfEnd()
		Trigger2(FP,{Deaths(i-1,AtLeast,1,34)},{SetDeaths(i-1,SetTo,0,34)},{Preserved})
	end
	SkillUnitP = CreateVar()
	--CMov(FP,0x6509B0,19025+19)
	--CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699))) -- 스킬유닛 순환기
	--CIf(FP,{DeathsX(CurrentPlayer,AtMost,4,0,0xFF),DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)})
	--    CAdd(FP,0x6509B0,6)
	--    NIf(FP,DeathsX(CurrentPlayer,Exactly,179,0,0xFF))
	--        CSub(FP,0x6509B0,23)
	--        DoActions(FP,SetDeaths(CurrentPlayer,Subtract,1*256,0))
	--        Trigger {
	--            players = {P6},
	--            conditions = {
	--                Deaths(CurrentPlayer,AtMost,0,0)
	--            },
	--            actions = {
	--                MoveCp(Add,23*4); -- 
	--                SetDeathsX(CurrentPlayer,SetTo,204,0,0xFF);
	--                MoveCp(Subtract,23*4); -- 
	--                PreserveTrigger();
	--        
	--        },
	--        }
	--        CAdd(FP,0x6509B0,23)
	--    NIfEnd()
	--    CSub(FP,0x6509B0,6)
	--CIfEnd()
	--CAdd(FP,0x6509B0,84)
	--CWhileEnd()
	--CMov(FP,0x6509B0,FP)

	CunitCtrig_Part1(P6)
	MoveCp("X",2*4) -- MoveCp값 0x8로 세팅 (Part4X 설정값)
	NIf(FP,Deaths(CurrentPlayer,AtMost,0,0))
		Trigger {
			players = {P6},
			conditions = {
			},
			actions = {
				MoveCp(Add,23*4); -- 
				SetDeathsX(CurrentPlayer,SetTo,84,0,0xFF);
				MoveCp(Subtract,23*4); -- 
				PreserveTrigger();
		
		},
		}
	
	NIfEnd()
	ClearCalc()
	CunitCtrig_Part2()
	CunitCtrig_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
	CunitCtrig_Part4X(i,{
	DeathsX(EPD(0x628298-0x150*i+(19*4)),AtLeast,1*256,0,0xFF00),
	DeathsX(EPD(0x628298-0x150*i+(25*4)),Exactly,179,0,0xFF),
	},
	{SetDeaths(EPD(0x628298-0x150*i+0x08), Subtract,1*256,0),
		SetDeathsX(EPD(0x628298-0x150*i+(40*4)), SetTo,0,0,0xFF000000),
	MoveCp(Add,2*4)})
	end
	CunitCtrig_End()
	CIfEnd()

		
	DoActions(FP,{
	RemoveUnit(84,Force1),
	RemoveUnit(84,P12),
	RemoveUnit(179,P12)})

-- 마린겹치기트리거
CIf(FP,CDeaths(FP,AtLeast,1,MarineStackSystem))
for i=0, 4 do
	Player_0x4DTemp = Player_0x4D[i+1]
	CIf(P6,{PlayerCheck(i,1)})

		f_Read(P6,0x6284E8+(0x30*i),"X",Player_S[i+1],0xFFFFFF)
		CIf(P6,Memory(0x6284E8+(0x30*i),AtLeast,1))
			CMov(P6,Player_0x4D[i+1],_ReadF(_Add(Player_S[i+1],0x4C/4),0xFF00))
			CMov(P6,Player_0x18[i+1],_ReadF(_Add(Player_S[i+1],0x18/4)))
			CMov(P6,Player_0x58[i+1],_ReadF(_Add(Player_S[i+1],0x58/4)))
			CMov(P6,Player_0x5C[i+1],_ReadF(_Add(Player_S[i+1],0x5C/4)))
			CIf(P6,{CVar(FP,Player_0x4DTemp[2],AtLeast,256)})
				CMov(P6,Player_C[i+1],1)
				Player_CTemp = Player_C[i+1]
				CWhile(P6,{CVar(FP,Player_CTemp[2],AtMost,11)})
					CIf(P6,{TDeaths(_Add(Player_C[i+1],EPD(0x6284E8+(0x30*i))),AtLeast,1,0)})
						--CMov(P6,0x6509B0,_EPD(_Read(BackupCp,0xFFFFFF)))
						--CRead(P6,0x6509B0,BackupCp,0,0xFFFFFF,1)
						CMov(P6,Player_T[i+1],_EPD(_ReadF(_Add(Player_C[i+1],EPD(0x6284E8+(0x30*i))))))
						CTrigger(P6,{
							TDeaths(_Add(Player_T[i+1],0x8/4),AtLeast,256,0),
							TDeathsX(_Add(Player_T[i+1],0x4C/4),AtLeast,1*256,0,0xFF00)
							},
						{
							TSetDeathsX(_Add(Player_T[i+1],0x4C/4),SetTo,Player_0x4D[i+1],0,0xFF00),
							TSetDeaths(_Add(Player_T[i+1],0x18/4),SetTo,Player_0x18[i+1],0),
							TSetDeaths(_Add(Player_T[i+1],0x58/4),SetTo,Player_0x58[i+1],0),
							TSetDeaths(_Add(Player_T[i+1],0x5C/4),SetTo,Player_0x5C[i+1],0)
							},1)
					CIfEnd()
					CAdd(P6,Player_C[i+1],1)
				CWhileEnd()
			CIfEnd()
		CIfEnd()
	CIfEnd()
end
CIfEnd()

CTrigger(P6,{TTOR({ -- Universul Cunit Function Operator
	Deaths(Force1,AtLeast,1,71),
	CVar(P6,B4_P[2],AtLeast,1),
	Deaths(P6,AtLeast,1,125),
	Deaths(P6,AtLeast,1,72),
	Memory(0x58F454,AtLeast,1),
})},{SetCJump(0x700,0)},1)

CJump(P6,0x700)
CMov(FP,0x6509B0,19025+19)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699))) -- Universul Cunit Function
MoveCp("X",19*4)

CJump(FP,0x510)
DoActions(P6,{MoveCp(Add,6*4)})
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Deaths(P6,AtLeast,1,125);
		DeathsX(CurrentPlayer,Exactly,125,0,0xFF);
},
	actions = {
		MoveCp(Add,0xDC-0x64);
		SetDeathsX(CurrentPlayer,SetTo,0x000000,0,0xA00000);
		MoveCp(Subtract,0xDC-0x64);
		PreserveTrigger();
	}
}
DoActions(P6,{MoveCp(Subtract,6*4)})
CJumpEnd(FP,0x510)

NJump(P6,0x06,{DeathsX(CurrentPlayer,AtMost,4,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})
NJump(P6,0x07,{DeathsX(CurrentPlayer,Exactly,5,0,0xFF),DeathsX(CurrentPlayer,AtLeast,256,0,0xFF00)})

CJump(FP,0x511)

NJumpEnd(P6,0x06) -- 아군 CUnit 도착지점
MoveCp("X",19*4)

CIf(P6,{Deaths(Force1,AtLeast,1,71)}) -- 오토스팀 메딕데스값 인식
	for i=0, 4 do
		NJump(P6,0x110+i,{DeathsX(CurrentPlayer,Exactly,i,0,0xFF),Deaths(i,Exactly,1,71)})
	end
	CJump(P6,0x115)
	for i=0,4 do
		NJumpEnd(P6,0x110+i)
	end
	DoActions(P6,MoveCp(Add,6*4))
	CIf(P6,TTOR({
		DeathsX(CurrentPlayer,Exactly,MarID[1],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[2],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[3],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[4],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[5],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,32,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,7,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,20,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,27,0,0xFF),
	}))
		DoActions(P6,{
		MoveCp(Add,(69*4)-(25*4)),
		SetDeathsX(CurrentPlayer,SetTo,30*256,0,0xFF00),
		MoveCp(Subtract,(69*4)-(25*4))})
	CIfEnd()
	DoActions(P6,MoveCp(Subtract,6*4))
	CJumpEnd(P6,0x115)
CIfEnd()
-- 맵상에 탱크보스 있을경우 -- 맨 마지막에 있을 것이나 마린타노스와 같이 있을때 위치 상관X
NJump(P6,0x500,{CVar(P6,B4_P[2],AtMost,0)})
Call_SaveCp()
CIf(P6,{TMemory(_Mem(_Mod(_Rand(),100)),AtLeast,50)})
	Call_LoadCp()
	DoActions(P6,{MoveCp(Subtract,9*4)})
	CIf(FP,{
		DeathsX(CurrentPlayer,AtLeast,287,0,0xFFFF),
		DeathsX(CurrentPlayer,AtMost,801,0,0xFFFF),
		DeathsX(CurrentPlayer,AtLeast,3327*65536,0,0xFFFF0000),
		DeathsX(CurrentPlayer,AtMost,3874*65536,0,0xFFFF0000)})
		DoActions(P6,{MoveCp(Add,15*4)})
		CIfX(P6,TTOR({
			DeathsX(CurrentPlayer,Exactly,MarID[1],0,0xFF),
			DeathsX(CurrentPlayer,Exactly,MarID[2],0,0xFF),
			DeathsX(CurrentPlayer,Exactly,MarID[3],0,0xFF),
			DeathsX(CurrentPlayer,Exactly,MarID[4],0,0xFF),
			DeathsX(CurrentPlayer,Exactly,MarID[5],0,0xFF),
			DeathsX(CurrentPlayer,Exactly,32,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,7,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,20,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,27,0,0xFF),
		}))
			DoActions(P6,{MoveCp(Subtract,25*4)})
			Call_SaveCp()
			CIfX(P6,FTR)
				EnergyKill(12) -- 1.2
				CelseX()
				EnergyKill(16) -- 8000
			CIfXEnd()
			CIfX(FP,CDeaths(FP,AtMost,0,EVMode))
				PerDamage(998)
				CElseX()
				PerDamage(333)
			CIfXEnd()
			CAdd(FP,BackupCp,10)
			CMov(P6,CPos,_ReadF(BackupCp))
			CMov(P6,CPosX,_Mov(CPos,0xFFFF))
			CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
			Simple_SetLocX(P6,23,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,47,24,P6)})
			Trigger2(FP,{BYD},{CreateUnit(1,22,24,P8)},{Preserved})
			Call_LoadCp()
			DoActions(P6,{MoveCp(Add,15*4)})
		CIfXEnd()
		DoActions(P6,{MoveCp(Subtract,15*4)})
	CIfEnd()
	DoActions(P6,{MoveCp(Add,9*4)})
CIfEnd()
NJumpEnd(P6,0x500)
CIf(P6,{Deaths(P6,AtLeast,1,72)}) -- 마린타노스 전용 데스값 인식
	DoActions(P6,MoveCp(Add,6*4))
	for i = 0, 4 do
		MarCountTemp = MarCount[i+1]
		NJump(P6,0x601+i,{DeathsX(CurrentPlayer,Exactly,MarID[1+i],0,0xFF),CVar(FP,MarCountTemp[2],AtLeast,1)},{SetCVar(FP,MarCountTemp[2],Subtract,1)})
	end
	CJump(P6,0x600)
	for i = 0, 4 do
		NJumpEnd(P6,0x601+i)
	end
	DoActions(P6,MoveCp(Subtract,0x64 - 0x28))
	Call_SaveCp()
	CMov(P6,CPos,_ReadF(BackupCp))
	CMov(P6,CPosX,_Mov(CPos,0xFFFF))
	CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
	Simple_SetLocX(P6,23,_Add(CPosX,1),_Add(CPosY,1),_Add(CPosX,1),_Add(CPosY,1),{
		ModifyUnitEnergy(1,230,Force1,24,0),
		RemoveUnitAt(1,230,24,Force1),
		CreateUnit(1,84,24,P6)
	})
	Call_LoadCp()
	DoActions(P6,MoveCp(Add,0x64 - 0x28))
	CJumpEnd(P6,0x600)
	DoActions(P6,MoveCp(Subtract,6*4))
CIfEnd()
CIfX(P6,{CDeaths(FP,AtLeast,1,MarineStackSystem)})
	DoActions(P6,{MoveCp(Add,6*4)})
	CIf(P6,TTOR({
		DeathsX(CurrentPlayer,Exactly,MarID[1],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[2],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[3],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[4],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,MarID[5],0,0xFF),
		DeathsX(CurrentPlayer,Exactly,32,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,7,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,20,0,0xFF),
		DeathsX(CurrentPlayer,Exactly,27,0,0xFF),
	}))
		DoActions(P6,MoveCp(Add,0xDC-0x64))
		Trigger {
			players = {P6},
			conditions = {
				DeathsX(CurrentPlayer,Exactly,0x000000,0,0xA00000);
		},
			actions = {
				SetDeathsX(CurrentPlayer,SetTo,0xA00000,0,0xA00000);
				PreserveTrigger();
				
		},
		}
		DoActions(P6,MoveCp(Subtract,0xDC-0x64))
	CIfEnd()
	DoActions(P6,{MoveCp(Subtract,6*4)})
	CElseX()
	DoActions(P6,{MoveCp(Add,36*4)})
	Trigger {
		players = {P6},
		conditions = {
			DeathsX(CurrentPlayer,Exactly,0xA00000,0,0xA00000);
	},
		actions = {

			SetDeathsX(CurrentPlayer,SetTo,0x000000,0,0xA00000);
			MoveCp(Subtract,36*4);
			SetDeathsX(CurrentPlayer,SetTo,1*256,0,0xFF00);
			MoveCp(Add,36*4);
			PreserveTrigger();
			
	},
	}
	DoActions(P6,MoveCp(Subtract,36*4))
CIfXEnd()
CJump(FP,0xF10) -- 계산 단락 종료
NJumpEnd(P6,0x07) -- P6 유닛 도착지점
CIf(P6,{Memory(0x58F454,AtLeast,1),NBYD}) -- 감염된커맨드 건작유닛
	MoveCp("X",19*4)
	DoActions(P6,{MoveCp(Add,6*4)}) -- 25
	Trigger {
		players = {P6},
		conditions = {
			MemoryX(0x58F454,Exactly,1,0xFF);
			DeathsX(CurrentPlayer,Exactly,88,0,0xFF);
		},
		actions = {
			MoveCp(Subtract,12*4);
			SetDeaths(CurrentPlayer,SetTo,1500,0);
			MoveCp(Add,5*4);
			SetDeathsX(CurrentPlayer,SetTo,1500,0,0xFFFF);
			MoveCp(Add,7*4);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			MemoryX(0x58F454,Exactly,1,0xFF);
			DeathsX(CurrentPlayer,Exactly,80,0,0xFF);
		},
		actions = {
			MoveCp(Subtract,12*4);
			SetDeaths(CurrentPlayer,SetTo,1500,0);
			MoveCp(Add,5*4);
			SetDeathsX(CurrentPlayer,SetTo,1500,0,0xFFFF);
			MoveCp(Add,7*4);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			MemoryX(0x58F454,Exactly,1*65536,0xFF0000);
			DeathsX(CurrentPlayer,Exactly,21,0,0xFF);
		},
		actions = {
			MoveCp(Subtract,12*4);
			SetDeaths(CurrentPlayer,SetTo,1500,0);
			MoveCp(Add,5*4);
			SetDeathsX(CurrentPlayer,SetTo,1500,0,0xFFFF);
			MoveCp(Add,7*4);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			MemoryX(0x58F454,Exactly,1*65536,0xFF0000);
			DeathsX(CurrentPlayer,Exactly,8,0,0xFF);
		},
		actions = {
			MoveCp(Subtract,12*4);
			SetDeaths(CurrentPlayer,SetTo,1500,0);
			MoveCp(Add,5*4);
			SetDeathsX(CurrentPlayer,SetTo,1500,0,0xFFFF);
			MoveCp(Add,7*4);
			PreserveTrigger();
		}
	}
	DoActions(P6,MoveCp(Subtract,6*4))
CIfEnd()
CJumpEnd(FP,0xF10)
CJumpEnd(FP,0x511)
CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
CJumpEnd(P6,0x700)
TriggerX(FP,{Deaths(P6,AtLeast,1,125)},{SetCJump(0x510,1)})
DoActionsX(P6,{
	SetCVar(P6,B4_P[2],SetTo,0),
	SetDeaths(Force1,SetTo,0,71),
	SetDeaths(P6,SetTo,0,72),
	SetMemory(0x58F454,SetTo,0),
	SetCJump(0x700,1),
	SetDeaths(P6,SetTo,0,125),
	SetCDeaths(FP,Subtract,1,MarineStackSystem)})

-- 시체 상시검사 단락

CunitCtrig_Part1(P6)
BreakCalc(DeathsX(CurrentPlayer,Exactly,204,0,0xFF),{MoveCp(Subtract,16*4),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000)})
MoveCp("X",25*4) -- MoveCp값 0x8로 세팅 (Part4X 설정값)
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,140,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,131,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,141,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,137,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,135,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,142,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,136,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,139,0,0xFF))
NJumpX(P6,140,DeathsX(CurrentPlayer,Exactly,138,0,0xFF))
NJumpX(P6,140,{DeathsX(CurrentPlayer,Exactly,49,0,0xFF),CDeaths(FP,AtLeast,1,HDStart)})
CIf(P6,DeathsX(CurrentPlayer,Exactly,32,0,0xFF))
	DoActions(P6,MoveCp(Subtract,6*4))
	for j = 1, 5 do
		CIf(P6,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
			Call_SaveCp()
			Install_CText1(UnivStrPtr,Str00,Str01,Names[j])
			Trigger { -- No comment (6496767D)
				players = {P6},
				conditions = {
					Label(0);
				},
				actions = {
					RotatePlayer({DisplayTextX(UnivToString,4),PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP);
					SetDeaths(j-1,Subtract,1,32);
					SetScore(j-1,Add,1,Custom);
					SetCVar(FP,ExScore[j][2],Add,-10);
					PreserveTrigger();
					},
				}
			f_MemCpy(P6,UnivStrPtr,_TMem(Arr(StrReset[3],0),"X","X",1),StrReset[2])
			Call_LoadCp()
		CIfEnd()
	end
	DoActions(P6,MoveCp(Add,6*4))
CIfEnd()

CIf(P6,DeathsX(CurrentPlayer,Exactly,20,0,0xFF))
	DoActions(P6,MoveCp(Subtract,6*4))
	for j = 1, 5 do
		CIf(FP,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
			Call_SaveCp()
			Install_CText1(UnivStrPtr,Str00,Str02,Names[j])
			Trigger { -- No comment (6496767D)
				players = {P6},
				conditions = {
					Label(0);
				},
				actions = {
					RotatePlayer({DisplayTextX(UnivToString,4),PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP);
					SetDeaths(j-1,Subtract,1,20);
					SetScore(j-1,Add,2,Custom);
					SetCVar(FP,ExScore[j][2],Add,-30);
					PreserveTrigger();
					},
				}
			f_MemCpy(P6,UnivStrPtr,_TMem(Arr(StrReset[3],0),"X","X",1),StrReset[2])
			Call_LoadCp()
		CIfEnd()
	end
	DoActions(P6,MoveCp(Add,6*4))
CIfEnd()
CIf(P6,DeathsX(CurrentPlayer,Exactly,27,0,0xFF))
	DoActions(P6,MoveCp(Subtract,6*4))
	
	for j = 1, 5 do
		CIf(FP,DeathsX(CurrentPlayer,Exactly,j-1,0,0xFF))
			Call_SaveCp()
			Install_CText1(UnivStrPtr,Str00,Str04,Names[j])
			Trigger { -- No comment (6496767D)
				players = {P6},
				conditions = {
					Label(0);
				},
				actions = {
					RotatePlayer({DisplayTextX(UnivToString,4),PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP);
					SetDeaths(j-1,Subtract,1,27);
					SetScore(j-1,Add,9,Custom);
					SetCVar(FP,ExScore[j][2],Add,-1000);
					PreserveTrigger();
					},
				}
			f_MemCpy(P6,UnivStrPtr,_TMem(Arr(StrReset[3],0),"X","X",1),StrReset[2])
			Call_LoadCp()
		CIfEnd()
		end
	DoActions(P6,MoveCp(Add,6*4))
CIfEnd()
for j=1, 5 do
	CIf(P6,DeathsX(CurrentPlayer,Exactly,MarID[j],0,0xFF))
		DoActions(P6,MoveCp(Subtract,6*4))
		Call_SaveCp()
		Install_CText1(UnivStrPtr,Str00,Str03[j],Names[j])
		Trigger { -- No comment (6496767D)
			players = {P6},
			conditions = {
				Label(0);
				DeathsX(CurrentPlayer,AtMost,4,0,0xFF);
			},
			actions = {
				RotatePlayer({DisplayTextX(UnivToString,4),PlayWAVX("staredit\\wav\\die_se.ogg")},HumanPlayers,FP);
				SetDeaths(j-1,Subtract,1,MarID[j]);
				SetScore(j-1,Add,3,Custom);
				SetCVar(FP,ExScore[j][2],Add,-100);
				PreserveTrigger();
				},
			}
			f_MemCpy(P6,UnivStrPtr,_TMem(Arr(StrReset[3],0),"X","X",1),StrReset[2])
		Call_LoadCp()
		DoActions(P6,MoveCp(Add,6*4))
	CIfEnd()
end



InstallHeroPoint()


function HeroPanelty(Index,Point,Name)
local HText2 = "\x13\x1D† ! \x04맵상에 아직 "..Name.." \x04이(가) 남아있습니다. \x1F- "..(Point/20).." \x1CＯｒｅ\x1D ! †\n"
CIf(P6,Deaths(CurrentPlayer,Exactly,Index,0,0xFF))
DoActions(P6,MoveCp(Subtract,16*4))
Call_SaveCp()
Trigger {
	players = {P6},
	conditions = {
		Deaths(P6,AtLeast,1,173);
		DeathsX(CurrentPlayer, AtLeast,1*65536,0,0xFF0000);
	},
	actions = {
		SetDeathsX(CurrentPlayer, SetTo,0*65536,0,0xFF0000);
		SetResources(Force1,Add,Point/20,Gas);
		RotatePlayer({DisplayTextX(HText2,4),PlayWAVX("staredit\\wav\\tap.ogg")},HumanPlayers,FP);
		PreserveTrigger();
	},
}
Call_LoadCp()
DoActions(P6,MoveCp(Add,16*4))
CIfEnd()
end
HeroPanelty(69,150000,"\x10【 \x11F\x04racture \x10】")
HeroPanelty(11,150000,"\x10【 \x11F\x04ragment \x10】")

Call_GunPosSave(132,0)
Call_GunPosSave(133,1)

CDoActions(P6,{MoveCp(Subtract,16*4),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000)})

ClearCalc()
CJump(P6,0x101)


NJumpXEnd(P6,140)

DoActions(P6,MoveCp(Subtract,6*4))
BreakCalc({CDeaths(FP,AtLeast,1,HDStart),DeathsX(CurrentPlayer,AtLeast,6,0,0xFF)},{MoveCp(Subtract,10*4),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000)})
DoActions(P6,MoveCp(Subtract,9*4))

Call_SaveCp()
CMov(P6,CPos,_ReadF(BackupCp))
CMov(P6,CPosX,_Mov(CPos,0xFFFF))
CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
Simple_SetLocX(P6,23,_Sub(CPosX,32*4),_Sub(CPosY,32*4),_Add(CPosX,32*4),_Add(CPosY,32*4))
CTrigger(P6,{FTR},{
TCreateUnit(_Mul(_Add(_Div(Time1,_Mov(900000)),1),_Mov(16777216)),VArr(UArr1,_Mod(_Rand(),_Mov(16))),24,P8),
TCreateUnit(_Mul(_Add(_Div(Time1,_Mov(900000)),1),_Mov(16777216)),VArr(UArr2,_Mod(_Rand(),_Mov(16))),24,P8),
},1)

function BYDTechGunFunc()
CTrigger(P6,{BYD},{
TCreateUnit(1,VArr(UArr1,_Mod(_Rand(),16)),24,P8),
TCreateUnit(1,VArr(UArr2,_Mod(_Rand(),16)),24,P8),Order("Men",P8,24,Attack,5)
},1)

end

BYDTechGunCAPlot = CAPlotForward()
CMov(FP,V(BYDTechGunCAPlot[5]),_Add(_Div(Time1,_Mov(300000)),1))
CAPlot(CSMakePolygon(6,96,0,PlotSizeCalc(6,6),0),P8,181,23,nil,1,32,{1,0,0,0,9999,0},nil,FP,
	{BYD},
	{},1,"BYDTechGunFunc")

CMov(FP,V(BYDTechGunCAPlot[6]),1)





Call_LoadCp()
DoActions(P6,MoveCp(Add,15*4))

Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,140,0,0xFF);
	},
	actions = {CreateUnit(25,48,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,131,0,0xFF);
	},
	actions = {CreateUnit(25,40,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,141,0,0xFF);
	},
	actions = {CreateUnit(25,55,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,137,0,0xFF);
	},
	actions = {CreateUnit(25,56,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,135,0,0xFF);
	},
	actions = {CreateUnit(25,53,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,142,0,0xFF);
	},
	actions = {CreateUnit(25,54,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,136,0,0xFF);
	},
	actions = {CreateUnit(10,46,24,P8);CreateUnit(15,50,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,139,0,0xFF);
	},
	actions = {CreateUnit(10,53,24,P8);CreateUnit(15,54,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
Trigger { --
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,138,0,0xFF);
	},
	actions = {CreateUnit(15,104,24,P8);CreateUnit(15,51,24,P8);CreateUnit(10,45,24,P8);Order("Men",P8,24,Attack,5);PreserveTrigger();
	},
}
CJumpEnd(P6,0x101)

---------------------------------------------------------



CDoActions(P6,{MoveCp(Subtract,16*4),SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000)})


ClearCalc()
CunitCtrig_Part2()
CunitCtrig_Part3X()
for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
CunitCtrig_Part4X(i,{
DeathsX(EPD(0x628298-0x150*i+(40*4)),AtLeast,1*16777216,0,0xFF000000),
DeathsX(EPD(0x628298-0x150*i+(19*4)),Exactly,0*256,0,0xFF00),
},
{SetDeathsX(EPD(0x628298-0x150*i+(40*4)),SetTo,0*16777216,0,0xFF000000),
MoveCp(Add,25*4),
})
end
CunitCtrig_End()



--수정광산
CIf(P6,Deaths(P6,AtLeast,1,173)) -- 수정광산 전용 데스값 인식
	DoActions(FP,KillUnit("Factories",Force2))
	
	HText2 = "\x13\x1D† ! \x04맵상에 아직 \x10【 \x11Ｐ\x04ａｓｔ \x10】 \x04이(가) 남아있습니다. \x1F- 50000 \x1CＯｒｅ\x1D ! †\n"
	Trigger {
		players = {P6},
		conditions = {
			
			Bring(P7,AtLeast,1,64,64);
		},
		actions = {
			KillUnitAt(1, 64,64,P7),
			SetResources(Force1,Add,500000,Gas);
			RotatePlayer({DisplayTextX(HText2,4),PlayWAVX("staredit\\wav\\tap.ogg")},HumanPlayers,FP);
			PreserveTrigger();
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			
			Bring(P8,AtLeast,1,64,64);
		},
		actions = {
			KillUnitAt(1, 64,64,P8),
			SetResources(Force1,Add,50000,Gas);
			RotatePlayer({DisplayTextX(HText2,4),PlayWAVX("staredit\\wav\\tap.ogg")},HumanPlayers,FP);
			PreserveTrigger();
		},
	}
	
	
	
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
		CIf(FP,{DeathsX(CurrentPlayer,AtLeast,5,0,0xFF),DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00)})
			DoActions(P6,{MoveCp(Add,6*4)})
			
			NJump(FP,0xF11,{DeathsX(CurrentPlayer,AtMost,104,0,0xFF),TTOR({DeathsX(CurrentPlayer,Exactly,87,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,74,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,30,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,2,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,12,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,64,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,4,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,6,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,18,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,24,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,82,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,26,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,31,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,33,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,58,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,85,0,0xFF),
			DeathsX(CurrentPlayer,Exactly,101,0,0xFF)})})
			
			
			DoActions(P6,MoveCp(Subtract,23*4))
			
			CIfX(FP,{Deaths(CurrentPlayer,AtLeast,10000*256,0)})
				DoActions(FP,{SetDeaths(CurrentPlayer,Subtract,10000*256,0)})
			CElseX()
				DoActions(FP,{
				MoveCp(Add,7*4),
				SetDeathsX(CurrentPlayer,SetTo,1*65536,0,0xFF0000),
				MoveCp(Add,10*4),
				SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00),
				MoveCp(Subtract,17*4)
				})
				
			CIfXEnd()
			DoActions(P6,MoveCp(Add,23*4))
			NJumpEnd(FP,0xF11)
			
			DoActions(P6,{MoveCp(Subtract,6*4)})
		CIfEnd()
		
		CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CAdd(FP,0x6509B0,FP)
	
	
CIfEnd()






-- 벌쳐보스 CTrig




CIf(P6,CDeaths(P6,AtLeast,1,B5_Av)) -- 벌쳐보스의 수정이 존재하면 열리는 스킬 (적유닛 CUnit)
	
	CMov(FP,0x6509B0,19025+19)
	CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
	
	CIf(FP,DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),MoveCp(Add,6*4))
		
		CIf(FP,{DeathsX(CurrentPlayer,Exactly,128,0,0xFF)})
			DoActions(FP,{
					MoveCp(Subtract,23*4);
					SetDeaths(CurrentPlayer, Subtract,1*256,0)
			}) -- 10
			
			CIf(FP,Deaths(CurrentPlayer,AtMost,0*256,0))
				
				DoActions(P6,{
				MoveCp(Add,17*4), -- 19
				SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00),
				MoveCp(Subtract,9*4)
				}) -- 10
				Call_SaveCp()
				CMov(P6,CPos,_ReadF(BackupCp))
				CMov(P6,CPosX,_Mov(CPos,0xFFFF))
				CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
				Simple_SetLocX(P6,23,_Sub(CPosX,11),_Sub(CPosY,11),_Add(CPosX,11),_Add(CPosY,11),{
					CreateUnit(1,62,24,P6),
					KillUnit(62,P6)
				})
				CIfX(FP,{BYD,TTOR({CDeaths(FP,Exactly,1,HDStart),CDeaths(FP,Exactly,2,B7_Ph)})})
					DoActions(FP,{SetInvincibility(Enable,"Factories",Force1,24),KillUnitAt(All,20,24,Force1),KillUnitAt(All,32,24,Force1)})
				CElseX()
					DoActions(FP,{KillUnitAt(All, "Factories",24,Force1)})
				CIfXEnd()
				CSub(FP,BackupCp,8)
				Call_LoadCp()
			CIfEnd()
			CAdd(FP,0x6509B0,23)
		CIfEnd()
		CSub(FP,0x6509B0,6)
	CIfEnd()
	
	CAdd(FP,0x6509B0,84)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
CIfEnd()

-- 퀸공격


	CunitCtrig_Part1(P6)
	MoveCp("X",0*4) -- MoveCp값 0x8로 세팅 (Part4X 설정값)
	CIfX(FP,CDeaths(FP,AtMost,0,EVMode))
	Call_SaveCp()
		PerDamage(150)
	Call_LoadCp()
	CElseX()
	Call_SaveCp()
		PerDamage(50)
	Call_LoadCp()
	CIfXEnd()
	ClearCalc()
	CunitCtrig_Part2()
	CunitCtrig_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
	CunitCtrig_Part4X(i,{
	DeathsX(EPD(0x628298-0x150*i+(72*4)),AtLeast,1*256,0,0xFF00)
	},
	{SetDeaths(EPD(0x628298-0x150*i+(72*4)), SetTo,0,0,0xFF00),SetDeaths(EPD(0x628298-0x150*i+(69*4)), SetTo,255*65536,0)})
	end
	CunitCtrig_End()

-- 슈팅스타 CTrig

CIf(P6,CVar(P6,B2_P[2],AtLeast,1))
	CunitCtrig_Part1(P6)
	MoveCp("X",19*4) -- MoveCp값 0x8로 세팅 (Part4X 설정값)
	
	CIf(P6,{CVar(P6,B2_P[2],AtMost,30)})
		
		BreakCalc({DeathsX(CurrentPlayer,AtLeast,3*256,0,0xFF00)})
		
		Call_SaveCp()
		CIfX(FP,{BYD,CVar(FP,B2_P2[2],Exactly,0)})
			f_Lengthdir(P6,1500,_Mod(_Rand(),359),B2_LX, B2_LY)
		CElseX()
			f_Lengthdir(P6,_Mod(_Rand(),20*32),_Mod(_Rand(),359),B2_LX, B2_LY)
		CIfXEnd()
		CAdd(P6,LXYPos,B2_LX,_Mul(B2_LY,65536))
		Call_LoadCp()
		
		DoActions(P6,{SetDeathsX(CurrentPlayer,SetTo,6*256,0,0xFF00)})
		DoActions(P6,{MoveCp(Add,3*4)}) -- 22
		CIfX(P6,Command(P6,AtLeast,1,87))
			CDoActions(P6,{TSetDeaths(CurrentPlayer,SetTo,_Add(LXYPos,B2_Pos),0)})
			CElseX()
			CDoActions(P6,{TSetDeaths(CurrentPlayer,SetTo,_Add(LXYPos,(2048*65536)+(2048)),0)})
		CIfXEnd()
		DoActions(P6,{MoveCp(Subtract,3*4)}) -- 19
		
	CIfEnd()
	
	
	BreakCalc({CVar(P6,B2_P[2],AtMost,49)})
	
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			NBYD;
			CDeaths(FP,AtLeast,2,GMode);
			DeathsX(CurrentPlayer,Exactly,10*256,0,0xFF00);
		},
		actions = {
			MoveCp(Subtract,17*4);
			SetDeaths(CurrentPlayer, Subtract,5*256,0);
			MoveCp(Add,17*4);
			PreserveTrigger();
	
	}
	}
	
	
	DoActions(P6,{MoveCp(Subtract,17*4)}) -- 2
	
	Trigger {
		players = {P6},
		conditions = {
			Deaths(CurrentPlayer,AtMost,0,0);
		},
		actions = {
			MoveCp(Add,53*4); -- 55
			SetDeathsX(CurrentPlayer,SetTo,0x40000000,0,0x40000000);
			MoveCp(Subtract,36*4); -- 19
			SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF00);
			MoveCp(Subtract,17*4); -- 
			PreserveTrigger();
	
	},
	}
	DoActions(P6,{MoveCp(Add,17*4)}) -- 19
	ClearCalc()
	CunitCtrig_Part2()
	CunitCtrig_Part3X()
	for i = 0, 1699 do -- Part4X 용 Cunit Loop (x1700)
	CunitCtrig_Part4X(i,{
	DeathsX(EPD(0x628298-0x150*i+(25*4)),Exactly,180,0,0xFF),
	DeathsX(EPD(0x628298-0x150*i+(19*4)),AtLeast,1*256,0,0xFF00),
	},
	{SetDeaths(EPD(0x628298-0x150*i+0x08), Subtract,1*256,0),
	MoveCp(Add,19*4)})
	end
	CunitCtrig_End()
CIfEnd()



--

CIf(P6,{CDeaths(P6,AtLeast,1,PaneltyP)})
	
	CMul(P6,PaneltyTemp2,_Add({FP,RedNumber[2],nil,"V"},400),_Ccode("X",PaneltyP))
	CAdd(P6,Panelty,PaneltyTemp2)
	CIf(FP,{BYD})
		CAdd(P6,RedNumberT,PaneltyTemp2)
	CIfEnd()
	f_Div(P6,PaneltyTemp,Panelty,_Mov(400))
	CIfX(P6,HD)
		for i=0, 4 do
			CAdd(P6,0x57F120+i*4,_Mul(PaneltyTemp,20))
		end
		CAdd(P6,TPanelty,PaneltyTemp)
	CElseIfX(FTR)
		for i=0, 4 do
			CAdd(P6,0x57F120+i*4,_Mul(PaneltyTemp,50))
		end
		CAdd(P6,TPanelty,_Mul(PaneltyTemp,2))
	CElseIfX(BYD)
		for i=0, 4 do
			CAdd(P6,0x57F120+i*4,_Mul(PaneltyTemp,150))
		end
		CAdd(P6,TPanelty,_Mul(PaneltyTemp,4))
	CIfXEnd()
	
	CSub(P6,0x58D6F4,_Div(TPanelty,_Mov(3)))
	f_Mod(P6,TPanelty,_Mov(3))
	f_Mod(P6,Panelty,_Mov(400))
	CMov(P6,_Ccode("X",PaneltyP),0)
	Trigger { -- 타이머 패널티 알림
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,Difficulty);
			CDeaths(P6,AtMost,0,TimerPenalty);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x07ＣＡＵＴＩＯＮ",0),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x1B기억의 기둥\x04이 있던 자리에서 \x16기억의 기운\x04이 느껴집니다.\n\x13\x04그 자리를 지키지 않을 시 \x1F자원\x04과 \x1D시간\x04이 \x08소실\x04됩니다. 조심하십시오.",0),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x07ＣＡＵＴＩＯＮ",0),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg"),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")
			},MapPlayers,FP);
			PreserveTrigger();
		},
	}
	Trigger { -- 타이머 패널티 알림
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,Difficulty);
			CDeaths(P6,AtMost,0,TimerPenalty);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x07ＣＡＵＴＩＯＮ",0),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x1B기억의 기둥\x04이 있던 자리에서 \x16기억의 기운\x04이 느껴집니다.\n\x13\x04그 자리를 지키지 않을 시 \x1F자원\x04과 \x1D시간\x04이 \x08소실\x04됩니다. 조심하십시오.",0),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x07ＣＡＵＴＩＯＮ",0),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg"),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")
			},ObPlayers,FP);
			SetCDeaths(P6,SetTo,300,TimerPenalty);
			PreserveTrigger();
		},
	}
	
CIfEnd()

CIfX(P6,{CDeaths(P6,AtMost,1,GMode)})
	CWhile(P6,{CDeaths(P6,AtLeast,1,BonusP)},SetCDeaths(P6,Subtract,1,BonusP))
		CAdd(P6,Bonus,_Add({FP,RedNumber[2],nil,"V"},400))
	CWhileEnd()
	CWhile(P6,{CVar(FP,Bonus[2],AtLeast,5000)},{SetCVar(FP,Bonus[2],Subtract,5000),SetMemory(0x58D6F4,Add,1)})
	CWhileEnd()
CelseIfX({BYD})
	CWhile(P6,{CDeaths(P6,AtLeast,1,BonusP)},SetCDeaths(P6,Subtract,1,BonusP))
		CAdd(P6,Bonus,_Add({FP,RedNumber[2],nil,"V"},400))
	CWhileEnd()
	CWhile(P6,{CVar(FP,Bonus[2],AtLeast,2500)},{SetCVar(FP,Bonus[2],Subtract,2500),SetMemory(0x58D6F4,Add,1)})
	CWhileEnd()
CIfXEnd()

Trigger { -- 빨간숫자
	players = {P6},
	conditions = {
		Label(0);
		CVar(FP,RedNumberT[2],AtLeast,9000);
		CDeaths(P6,AtLeast,2,Difficulty);
		CVar(FP,RedNumber[2],AtMost,399);
		NBYD;
	},
	actions = {
		SetCVar(FP,RedNumberT[2],Subtract,9000);
		SetCVar(FP,RedNumber[2],Add,1);
		PreserveTrigger();
	},
}
Trigger { -- 빨간숫자
	players = {P6},
	conditions = {
		Label(0);
		CVar(FP,RedNumberT[2],AtLeast,9000*2);
		CDeaths(P6,AtLeast,3,Difficulty);
		CVar(FP,RedNumber[2],AtMost,399);
		BYD;
	},
	actions = {
		SetCVar(FP,RedNumberT[2],Subtract,9000*2);
		SetCVar(FP,RedNumber[2],Add,1);
		PreserveTrigger();
	},
}





for i=0,4 do
	CIf(P6,PlayerCheck(i,1))
		
		CIf(P6,{Memory(0x57F120+(i*4),AtLeast,1),Memory(0x57f0f0+(i*4),AtLeast,1)})
			
			CIfX(P6,{TMemory(0x57f0f0+(i*4),AtLeast,_ReadF(0x57F120+(i*4)))})
			
				CSub(P6,0x57f0f0+(i*4),_ReadF(0x57F120+(i*4)))
				CMov(P6,0x57F120+(i*4),0)
				
				CElseX()
				
				CSub(P6,0x57F120+(i*4),_ReadF(0x57f0f0+(i*4)))
				CMov(P6,0x57f0f0+(i*4),0)
			CIfXEnd()
		CIfEnd()
		
		CIfX(P6,{TMemory(0x58F464+(i*4),AtMost,MaxHP),TTMemory(0x58F464+(i*4),"!=",MarHP[i+1])})
			CMov(P6,MarHP[i+1],_ReadF(0x58F464+(i*4)))

			CIfX(FP,{CDeaths(FP,AtMost,0,BYDBossStart2)})
			CMov(P6,0x662350 + (MarID[i+1]*4),_Mul(MarHP[i+1],_Mov(256)))
			CIfXEnd()
			
			CIfX(P6,CDeaths(P6,AtMost,0,EVMode))
				CMov(P6,0x515BB0+(i*4),_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(1000)))
				CElseX()
				CMov(P6,0x515BB0+(i*4),_Div(_ReadF(0x662350 + (MarID[i+1]*4)),_Mov(3000)))
			CIfXEnd()
			
			CMov(P6,0x582204+(i*4),_Div(MarHP[i+1],_Mov(50)))
			
			f_Div(P6,ShieldP[i+1],MarHP[i+1],ShP)
			CElseIfX({TMemory(0x58F464+(i*4),AtLeast,_Add(MaxHP,1))})
			CAdd(P6,0x57f0f0+(i*4),_Mul(_Sub(_ReadF(0x58F464+(i*4)),MaxHP),_Mov(10)))
			CMov(P6,0x58F464+(i*4),_Mov(MaxHP))
			f_Div(P6,ShieldP[i+1],MarHP[i+1],ShP)
		CIfXEnd()
		CTrigger(P6,
			{
				Deaths(i,AtLeast,1,34),
				NBYD
		},
			{
				TModifyUnitShields(All,"Men",i,64,ShieldP[i+1]),
				SetDeaths(i,SetTo,0,34)
		},1)
	CIfEnd()
end
GunListErrorCheck = CreateVar()
NJump(FP,0x701,CVar(FP,WhileLaunch[2],AtMost,0))
CMov(FP,WhileLaunch,0)
CMov(P6,0x6509B0,EPD(MemoryPtr))
DoWhile(FP)
NJump(FP,0x702,Memory(0x6509B0,AtMost,EPD(MemoryPtr)-1),{
			RotatePlayer({
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x08\n\x13\x06ＥＲＲＯＲ\n\n\x13\x06심각한 오류가 발생했습니다. 제작자에게 알려주세요.\n\x13\x08(ERROR CODE:0x702)\n\x13\x06ＥＲＲＯＲ\n.",0),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg"),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")
			},HumanPlayers,FP);
})--SafetyEscape
NIf(FP,Deaths(CurrentPlayer,AtLeast,1,0)) -- 0
	Call_SaveCp()
	CAdd(FP,WhileLaunch,1)
	f_Mod(FP,GunListErrorCheck,_Sub(BackupCp,EPD(MemoryPtr)),_Mov(MemoryPtrSize))
	NJump(FP,0x703,{CVar(FP,GunListErrorCheck[2],AtLeast,1)},{
			RotatePlayer({
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x08\n\x13\x06ＥＲＲＯＲ\n\n\x13\x06심각한 오류가 발생했습니다. 제작자에게 알려주세요.\n\x13\x08(ERROR CODE:0x703)\n\x13\x06ＥＲＲＯＲ\n.",0),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg"),
				PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")
			},HumanPlayers,FP);
})--SafetyEscape
	NIf(FP,DeathsX(CurrentPlayer,AtMost,1*0x1000,0,0xF000)) -- BdIndex LAIR HIVE
		Call_SaveCp()
		CMov(FP,CPosX,_Mov(_ReadF(BackupCp),0xFFF))
		CMov(FP,CPosY,_Div(_Mov(_ReadF(BackupCp),0xFFF0000),_Mov(65536)))
		Simple_SetLocX(FP,23,_Sub(CPosX,32*9),_Sub(CPosY,32*9),_Add(CPosX,32*9),_Add(CPosY,32*9))
		Call_LoadCp()
		
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0);
				CDeaths(P6, AtLeast, 2, Difficulty);
				CVar(P6,SetPlayers[2],Exactly,1);
				Bring(Force2, AtLeast, 6, "Men", 24);
				Bring(Force1, AtMost, 2, "Factories", 24);
			},
			actions = {
				SetCDeaths(P6,Add,1,PaneltyP);
				SetCDeaths(P6,Add,1,PaneltyP);
				PreserveTrigger();
			},
		}
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0);
				CVar(P6,SetPlayers[2],AtLeast,2);
				CDeaths(P6, AtLeast, 2, Difficulty);
				Bring(Force2, AtLeast, 6, "Men", 24);
				Bring(Force1, AtMost, 2, "Factories", 24);
			},
			actions = {
				SetCDeaths(P6,Add,1,PaneltyP);
				PreserveTrigger();
			},
		}
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0);
				Bring(Force2, AtLeast, 6, "Men", 24);
				Bring(Force1, AtLeast, 3, "Factories", 24);
			},
			actions = {
				SetCDeaths(P6,Add,1,BonusP);
				PreserveTrigger();
			},
		}
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0);
				Bring(Force2, AtMost, 5, "Men", 24);
			},
			actions = {
				SetCDeaths(P6,Add,1,BonusP);
				PreserveTrigger();
			},
		}
	
		
		NIf(FP,{DeathsX(CurrentPlayer,AtMost,0*0x1000,0,0xF000)}) -- LAIR
			DoActions(FP,MoveCp(Add,1*4))
			
			
			NIf(FP,{TTOR({DeathsX(CurrentPlayer,AtMost,0,0,0xFFFF),_TDeathsX(CurrentPlayer,AtLeast,RedNumberX,0,0xFFFF)}),DeathsX(CurrentPlayer,AtMost,1*16777216,0,0xFF000000)}) -- Hero SpawnSet
			--Hero SpawnSet
			
				NIfX(FP,NBYD)
					LairHeroSpawnSet(FP,0,79,75,3,96,45,4,Cleared,Set)
					LairHeroSpawnSet(FP,4,76,63,3,96,45,4,Set,Cleared)
					LairHeroSpawnSet(FP,8,77,78,3,128,45,4,Set,Cleared)
					
					NIf(FP,DeathsX(CurrentPlayer,Exactly,0*16777216,0,0xFF000000))
						LairHeroSpawnSet(FP,12,8,57,1,192,0,6,Set,Cleared)
					NIfEnd()
					
					NIf(FP,DeathsX(CurrentPlayer,Exactly,1*16777216,0,0xFF000000))
						LairHeroSpawnSet(FP,12,8,57,2,128,0,5,Set,Cleared)
					NIfEnd()
					
					LairHeroSpawnSet(FP,16,80,98,2,128,0,5,Set,Cleared)
					LairHeroSpawnSet(FP,12,19,17,3,96,45,4,Set,Cleared)
					LairHeroSpawnSet(FP,16,10,52,3,96,45,4,Set,Cleared)
				NIfXEnd()
			NIfEnd()
			
			
			NIf(FP,{DeathsX(CurrentPlayer,AtMost,0*16777216,0,0xFF000000)})
			
			NIf(FP,NBYD)
			-- 1st Wave
			
			--Zerg SpawnSet
			Points = 8
			SizeofPolygon = 2
			Radius = 32*4
			Angle = 45
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7, {1,48})
			--25

			Points = 6
			SizeofPolygon = 3
			Radius = 96
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,11*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,54,1,53})
			--37*2
			Points = 6
			SizeofPolygon = 4
			Radius = 32*2
			CreateUnitPolygonSafe2Gun(FP,{DeathsX(CurrentPlayer,AtLeast,12*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,15*65536,0,0xFF0000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,51,1,104})
			CreateUnitPolygonSafe2Gun(FP,{DeathsX(CurrentPlayer,AtLeast,16*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,17*65536,0,0xFF0000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,54,1,53})
			--61
			Points = 6
			SizeofPolygon = 3
			Radius = 96
			CreateUnitPolygonSafe2Gun(FP,{DeathsX(CurrentPlayer,AtLeast,18*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,19*65536,0,0xFF0000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,54,1,53})
			
			
			NIfX(FP,{DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,7*65536,0,0xFF0000)})
			Points = 6
			SizeofPolygon = 3
			Radius = 72
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,56})
			NElseX()
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,55})
			--37
			NIfXEnd()
			
			NIfEnd()
			
			--CreateUnitPolygonSafe2Gun(FP,{DeathsX(CurrentPlayer,AtLeast,12*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,19*65536,0,0xFF0000)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,56})
			
			Call_SaveCp()
			 -- 레어 파괴시 브금, 텍스트
				GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 기둥 \x1D【 Ｌ\x04ａｉｒ \x1D】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．４\x04％ 〓\n\n\n"
				
			Trigger {
				players = {P6},
					conditions = {
					Label(0);
						},
				actions = {
					Order("Men",P8,24,Attack,5);
					Order("Factories",P7,24,Attack,5);
					RotatePlayer({DisplayTextX(GText, 4)},HumanPlayers,FP);
					SetCDeaths(P6,SetTo,3,BGMType);
					SetCVar(P6,ClearRate[2],Add,4); -- ClearRate + 0.4%
					PreserveTrigger();
					},
				}
			Call_LoadCp()
			DoActions(FP,{SetDeathsX(CurrentPlayer,Add,1*16777216,0,0xFF000000)})
			Call_SaveCp()
			CTrigger(FP,BYD,{
				TSetMemory(_Add(BackupCp,4-1),Add,1),
				TSetMemory(_Add(BackupCp,14-1),Add,1),
				TSetMemory(_Add(BackupCp,15-1),Add,1),
				TSetMemory(_Add(BackupCp,16-1),Add,1),
				TSetMemory(_Add(BackupCp,17-1),Add,1),
			},1)
			Call_LoadCp()
			NIfEnd()
			NIf(FP,{DeathsX(CurrentPlayer,Exactly,1*16777216,0,0xFF000000),TDeathsX(CurrentPlayer,AtLeast,RedNumberX,0,0xFFFF)})
			
			
			-- 2nd Wave
			
			--Zerg SpawnSet
			NIf(FP,NBYD)
			Angle = 45
			
			NIfX(FP,{DeathsX(CurrentPlayer,AtLeast,12*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,15*65536,0,0xFF0000)})
			Points = 8
			SizeofPolygon = 2
			Radius = 128
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7, {1,40,1,104})
			Points = 6
			SizeofPolygon = 3
			Radius = 96
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,48})
			NElseX()
			Points = 8
			SizeofPolygon = 2
			Radius = 128
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7, {1,48,1,104})
			Points = 6
			SizeofPolygon = 3
			Radius = 96
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,53})
			NIfXEnd()
			Points = 6
			SizeofPolygon = 3
			Radius = 72
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,56})
			Points = 6
			SizeofPolygon = 2
			Radius = 128
			CreateUnitPolygonSafe2Gun(FP,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,51})
			NIfEnd()
			Call_SaveCp()
			CTrigger(FP,BYD,{
				TSetMemory(_Add(BackupCp,4-1),Add,1),
				TSetMemory(_Add(BackupCp,14-1),Add,1),
				TSetMemory(_Add(BackupCp,15-1),Add,1),
				TSetMemory(_Add(BackupCp,16-1),Add,1),
				TSetMemory(_Add(BackupCp,17-1),Add,1),
			},1)
			Call_LoadCp()
			
			Trigger {
				players = {FP},
				actions = {
					Order("Men",P8,24,Attack,5);
					Order("Factories",P7,24,Attack,5);
					PreserveTrigger();
			},
			}
			
			
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,i*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,1,CCode(0x1000,00+(i*2)));
					SetCDeaths(P6,Add,1,CCode(0x1000,01+(i*2)));
					PreserveTrigger();
			},
			}
			end
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(4+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,1,CCode(0x1000,20+(i*2)));
					SetCDeaths(P6,Add,1,CCode(0x1000,21+(i*2)));
					PreserveTrigger();
			},
			}
			end
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(8+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,1,CCode(0x1000,12+(i*2)));
					SetCDeaths(P6,Add,1,CCode(0x1000,13+(i*2)));
					PreserveTrigger();
			},
			}
			end
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(12+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,1,CCode(0x1000,36+(i*2)));
					SetCDeaths(P6,Add,1,CCode(0x1000,37+(i*2)));
					PreserveTrigger();
			},
			}
			end
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(16+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,1,CCode(0x1000,48+(i*2)));
					SetCDeaths(P6,Add,1,CCode(0x1000,49+(i*2)));
					PreserveTrigger();
			},
			}
			end
			
			DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFF),SetDeathsX(CurrentPlayer,Add,1*16777216,0,0xFF000000)})
			NIfEnd()
			DoActions(FP,MoveCp(Subtract,1*4))
		NIfEnd() -- LAIR END
		NIf(FP,{DeathsX(CurrentPlayer,Exactly,1*0x1000,0,0xF000)}) -- HIVE
			DoActions(FP,MoveCp(Add,1*4))
			
			NIf(FP,{TTOR({DeathsX(CurrentPlayer,AtMost,0,0,0xFFFF),_TDeathsX(CurrentPlayer,AtLeast,RedNumberX,0,0xFFFF)}),DeathsX(CurrentPlayer,AtMost,1*16777216,0,0xFF000000)}) -- Hero SpawnSet
			
			--Hero SpawnSet
			NIfX(FP,NBYD)
				HiveHeroSpawnSet(FP,0,28,86,2,128,0,5,Set,Cleared)
				HiveHeroSpawnSet(FP,0,76,63,2,96,0,7,Set,Cleared)
				
				
				HiveHeroSpawnSet(FP,4,67,61,1,128,60,6,Cleared,Set)
				HiveHeroSpawnSet(FP,4,88,21,2,128,0,5,Cleared,Set)
				HiveHeroSpawnSet(FP,4,79,75,2,96,0,6,Cleared,Set)
				
				
				
				HiveHeroSpawnSet(FP,8,65,66,1,128,60,6,Set,Cleared)
				HiveHeroSpawnSet(FP,8,77,78,2,64,60,6,Set,Cleared)
				
				
				HiveHeroSpawnSet(FP,12,8,57,3,128,45,4,Cleared,Set)
				HiveHeroSpawnSet(FP,12,19,17,2,96,45,7,Cleared,Set)
				
				
				HiveHeroSpawnSet(FP,16,80,98,3,128,45,4,Set,Cleared)
				HiveHeroSpawnSet(FP,16,10,52,2,96,45,7,Set,Cleared)
				
				
				HiveHeroSpawnSet(FP,20,65,66,3,128,45,4,Cleared,Set)
			NIfXEnd()
			NIfEnd()
			
			
			NIf(FP,{DeathsX(CurrentPlayer,AtMost,0*16777216,0,0xFF000000)})
			
			-- 1st Wave
			NIf(FP,NBYD)
			Points = 8
			SizeofPolygon = 2
			Radius = 128
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,3*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P8, {1,48,1,104})
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7, {1,48,1,104})
			Points = 6
			SizeofPolygon = 3
			Radius = 64
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,3*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P8,{1,53})
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,53})
			Points = 6
			SizeofPolygon = 3
			Radius = 72
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,3*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P8,{1,56})
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,56})
			NIfEnd()
			
			 -- 하이브 파괴시 브금, 텍스트
				GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 기둥 \x1D【 Ｈ\x04ｉｖｅ \x1D】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．７\x04％ 〓\n\n\n"
				
			Call_SaveCp()
			Trigger {
				players = {P6},
					conditions = {
					Label(0);
						},
				actions = {
					Order("Men",P8,24,Attack,5);
					Order("Factories",P7,24,Attack,5);
					RotatePlayer({DisplayTextX(GText, 4)},HumanPlayers,FP);
					SetCDeaths(P6,SetTo,2,BGMType);
					SetCVar(P6,ClearRate[2],Add,7); -- ClearRate + 0.7%
					PreserveTrigger();
					},
				}
			Call_LoadCp()
			DoActions(FP,{SetDeathsX(CurrentPlayer,Add,1*16777216,0,0xFF000000)})
			Call_SaveCp()
			CTrigger(FP,BYD,{
				TSetMemory(_Add(BackupCp,4-1),Add,1),
				TSetMemory(_Add(BackupCp,14-1),Add,1),
				TSetMemory(_Add(BackupCp,15-1),Add,1),
				TSetMemory(_Add(BackupCp,16-1),Add,1),
				TSetMemory(_Add(BackupCp,17-1),Add,1),
			},1)
			Call_LoadCp()
			Trigger {
				players = {FP},
					conditions = {DeathsX(CurrentPlayer,AtLeast,20*65536,0,0xFF0000);
						},
				
				actions = {
					SetMemory(0x6C9FA0, SetTo, 86);
					SetMemory(0x6CA010, SetTo, 86);
					PreserveTrigger();
			},
			}
			for i = 0, 3 do
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),HD},5,195+i,32,64,0,2,1,P6,23,Attack,{1,29})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),FTR},5,195+i,32,64,0,2,1,P6,23,Attack,{1,102})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),BYD},3,195+i,32,256,0,2,1,P8,23,Attack,{1,64}) -- Radius 수정할것
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),HD},4,199+i,32,64,90,2,1,P6,23,Attack,{1,29})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),FTR},4,199+i,32,64,90,2,1,P6,23,Attack,{1,102})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),BYD},2,195+i,32,256,0,2,1,P8,23,Attack,{1,64}) -- Radius 수정할것
			end
			Trigger {
				players = {FP},
					conditions = {DeathsX(CurrentPlayer,AtLeast,20*65536,0,0xFF0000);
						},
				
				actions = {
					SetMemory(0x6C9FA0, SetTo, 1560);
					SetMemory(0x6CA010, SetTo, 640);
					PreserveTrigger();
			},
			}
			NIfEnd()
			
			NIf(FP,{DeathsX(CurrentPlayer,Exactly,1*16777216,0,0xFF000000),TDeathsX(CurrentPlayer,AtLeast,RedNumberX,0,0xFFFF)})
			
			-- 2nd Wave
			
			NIf(FP,NBYD)
			Points = 8
			SizeofPolygon = 2
			Radius = 128
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,3*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P8, {1,51,1,104})
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7, {1,51,1,104})
			Points = 6
			SizeofPolygon = 3
			Radius = 64
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,3*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P8,{1,53})
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,53})
			Points = 6
			SizeofPolygon = 3
			Radius = 72
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,3*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P8,{1,56})
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,56})
			Points = 6
			SizeofPolygon = 2
			Radius = 128
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtMost,3*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P8,{1,48})
			CreateUnitPolygonSafe2Gun(FP,DeathsX(CurrentPlayer,AtLeast,4*65536,0,0xFF0000),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,0,Points,1,P7,{1,48})
			NIfEnd()
			Trigger {
				players = {FP},
				actions = {
					Order("Men",P8,24,Attack,5);
					Order("Factories",P7,24,Attack,5);
					PreserveTrigger();
			},
			}
			
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,i*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,2,CCode(0x1000,32+i));
			},
			}
			end
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(4+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,2,CCode(0x1000,8+i));
			},
			}
			end
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(8+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,2,CCode(0x1000,28+i));
			},
			}
			end
			
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(12+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,2,CCode(0x1000,44+i));
			},
			}
			end
			
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(16+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,2,CCode(0x1000,56+i));
			},
			}
			end
			
			for i=0, 3 do
			Trigger {
				players = {FP},
				conditions = {
					Label(0);
					DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000);
					},
				actions = {
					SetCDeaths(P6,Add,2,CCode(0x1002,00+i));
			},
			}
			end
			Trigger {
				players = {FP},
					conditions = {DeathsX(CurrentPlayer,AtLeast,20*65536,0,0xFF0000);
						},
				
				actions = {
					SetMemory(0x6C9FA0, SetTo, 86);
					SetMemory(0x6CA010, SetTo, 86);
					PreserveTrigger();
			},
			}
			for i = 0, 3 do
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),HD},5,195+i,32,64,0,2,1,P6,23,Attack,{1,29})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),FTR},5,195+i,32,64,0,2,1,P6,23,Attack,{1,102})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),BYD},3,195+i,32,256,0,2,1,P8,23,Attack,{1,64}) -- Radius 수정할것
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),HD},4,199+i,32,64,90,2,1,P6,23,Attack,{1,29})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),FTR},4,199+i,32,64,90,2,1,P6,23,Attack,{1,102})
			CreateUnitLineSafeGunMove(FP,{DeathsX(CurrentPlayer,Exactly,(20+i)*65536,0,0xFF0000),BYD},2,195+i,32,256,0,2,1,P8,23,Attack,{1,64}) -- Radius 수정할것
			end
			Trigger {
				players = {FP},
					conditions = {DeathsX(CurrentPlayer,AtLeast,20*65536,0,0xFF0000);
						},
				
				actions = {
					SetMemory(0x6C9FA0, SetTo, 1560);
					SetMemory(0x6CA010, SetTo, 640);
					PreserveTrigger();
			},
			}
			DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,0,0,0xFFFF),SetDeathsX(CurrentPlayer,Add,1*16777216,0,0xFF000000)})
			Call_SaveCp()
			CTrigger(FP,BYD,{
				TSetMemory(_Add(BackupCp,4-1),Add,1),
				TSetMemory(_Add(BackupCp,14-1),Add,1),
				TSetMemory(_Add(BackupCp,15-1),Add,1),
				TSetMemory(_Add(BackupCp,16-1),Add,1),
				TSetMemory(_Add(BackupCp,17-1),Add,1),
			},1)
			Call_LoadCp()
			NIfEnd()
			DoActions(FP,MoveCp(Subtract,1*4))
		NIfEnd() -- HIVE END
		LairHivePlot = {}
		for i = 0, 5 do
			table.insert(LairHivePlot,CSMakePolygon(4,48,0,PlotSizeCalc(4,1+i),PlotSizeCalc(4,0+i)))
		end
		for i = 0, 5 do
			table.insert(LairHivePlot,CSMakePolygon(6,48,0,PlotSizeCalc(6,1+i),PlotSizeCalc(6,0+i)))
		end

		GunAir = CSMakePolygon(7,64,0,PlotSizeCalc(7,3),PlotSizeCalc(7,1))
		GunGround = CSMakePolygon(6,32,0,PlotSizeCalc(6,3),0)
		GunLong = CSMakePolygon(5,48,0,PlotSizeCalc(5,6),PlotSizeCalc(5,4))
		GunGround2 = CSMakePolygon(8,96,0,PlotSizeCalc(8,2),0)
		ZergGunShape = {GunAir,GunGround,GunLong,GunGround2}

		BYDGunBreak = CreateVar()
		BYDGunX = CreateVar()
		BYDGunTimer = CreateVar()
		BYDPlotNum = CreateVar()
		BYDPlotSize = CreateVar()
		BYDGunPhase = CreateVar()

		BYDZergSpawnSet = {CreateVar(),CreateVar(),CreateVar(),CreateVar()}
		BYDGunPlotSize = {CreateVar(),CreateVar(),CreateVar(),CreateVar()}
		ZergGunTimer = {CreateVar(),CreateVar(),CreateVar(),CreateVar()}
		ZergGunBreak = {CreateVar(),CreateVar(),CreateVar(),CreateVar()}
		ZergGunPhase = {CreateVar(),CreateVar(),CreateVar(),CreateVar()}
		BYDGunLoopLimit = {CreateVar(),CreateVar(),CreateVar(),CreateVar()}

		NIf(FP,{Deaths(CurrentPlayer,AtLeast,1,0),BYD})
			Call_SaveCp()
			BYDGunCA1 = CAPlotForward()
			NIf(FP,{DeathsX(CurrentPlayer,Exactly,0x0000,0,0xF000)})
				DoActions(FP,MoveCp(Add,1*4))
				HeroSpawnSetForBYD(FP,0,79,75,Cleared,Set,BYDGunCA1[8]) -- LairPlot[2],[3]
				HeroSpawnSetForBYD(FP,4,76,63,Set,Cleared,BYDGunCA1[8]) -- LairPlot[3],[4]
				HeroSpawnSetForBYD(FP,8,77,78,Set,Cleared,BYDGunCA1[8]) -- LairPlot[1],[2]
				HeroSpawnSetForBYD(FP,12,19,17,Set,Cleared,BYDGunCA1[8])-- LairPlot[4],[5]
				HeroSpawnSetForBYD(FP,16,10,52,Set,Cleared,BYDGunCA1[8])-- LairPlot[5],[6]
				DoActions(FP,MoveCp(Subtract,1*4)) -- LairHivePlot[1~6]
			NIfEnd()
			NIf(FP,{DeathsX(CurrentPlayer,Exactly,0x1000,0,0xF000)})
				DoActions(FP,MoveCp(Add,1*4))
				HeroSpawnSetForBYD(FP,0,76,63,Set,Cleared,BYDGunCA1[8]) -- HivePlot[3],[4]
				HeroSpawnSetForBYD(FP,4,67,61,Cleared,Set,BYDGunCA1[8]) -- HivePlot[1],[2]
				HeroSpawnSetForBYD(FP,8,65,66,Set,Cleared,BYDGunCA1[8]) -- HivePlot[2],[3]
				HeroSpawnSetForBYD(FP,12,3,81,Set,Cleared,BYDGunCA1[8]) -- HivePlot[4],[5]
				HeroSpawnSetForBYD(FP,16,10,52,Set,Cleared,BYDGunCA1[8])-- HivePlot[5],[6]
				HeroSpawnSetForBYD(FP,20,65,66,Cleared,Set,BYDGunCA1[8])-- HivePlot[3],[4]
				DoActions(FP,MoveCp(Subtract,1*4)) -- LairHivePlot[7~12]
			NIfEnd()

			-- 0 = 0x0FFF0FFF GunPos 0xF000 GunID
			-- 1 = 0xFF000000 SpawnCount 0xFF0000 GunLevel 0xFFFF Timer 

			CDoActions(FP,{
				TSetCVar(FP,BYDGunCA1[6],SetTo,_ReadF(_Add(BackupCp,2),0xFF)), -- 2 = BYDGunCA1[6] DataIndex
				TSetCVar(FP,BYDGunTimer[2],SetTo,_ReadF(_Add(BackupCp,3))), -- 3 = BYDGunTimer
				TSetCVar(FP,BYDGunBreak[2],SetTo,_ReadF(_Add(BackupCp,4),0x3)), -- 4 = SpawnBreak
--              TSetCVar(FP,BYDGunPhase[2],SetTo,_Read(_Add(BackupCp,5))), -- 5 = GunPhase

				--6~9 ZergGun DataInde
				TSetCVar(FP,ZergGunTimer[1][2],SetTo,_ReadF(_Add(BackupCp,10))),
				TSetCVar(FP,ZergGunTimer[2][2],SetTo,_ReadF(_Add(BackupCp,11))),
				TSetCVar(FP,ZergGunTimer[3][2],SetTo,_ReadF(_Add(BackupCp,12))),
				TSetCVar(FP,ZergGunTimer[4][2],SetTo,_ReadF(_Add(BackupCp,13))),
				--10~13 ZergGunTimer
				TSetCVar(FP,ZergGunBreak[1][2],SetTo,_ReadF(_Add(BackupCp,14),0x3)), 
				TSetCVar(FP,ZergGunBreak[2][2],SetTo,_ReadF(_Add(BackupCp,15),0x3)), 
				TSetCVar(FP,ZergGunBreak[3][2],SetTo,_ReadF(_Add(BackupCp,16),0x3)), 
				TSetCVar(FP,ZergGunBreak[4][2],SetTo,_ReadF(_Add(BackupCp,17),0x3)), 
				--14~17 ZergGunBreak
				--18~21 ZergGunPhase
			})
			function SetBYDShape(Level,Shape,ShapeNum)
			TriggerX(FP,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000)},
				{SetCVar(FP,BYDPlotSize[2],SetTo,Shape[ShapeNum][1]),SetCVar(FP,BYDPlotNum[2],SetTo,ShapeNum)},{Preserved})
			end
			CIf(FP,{TMemoryX(BackupCp,Exactly,0x0000,0xF000)}) -- Lair
				CIf(FP,{TMemory(_Add(BackupCp,5),Exactly,0)},{TSetMemory(0x6509B0,SetTo,_Add(BackupCp,1))})
				SetBYDShape(0 ,LairHivePlot,2)
				SetBYDShape(4 ,LairHivePlot,3)
				SetBYDShape(8 ,LairHivePlot,1)
				SetBYDShape(12,LairHivePlot,4)
				SetBYDShape(16,LairHivePlot,5)
				CIfEnd()
				CIf(FP,{TMemory(_Add(BackupCp,5),Exactly,1)},{TSetMemory(0x6509B0,SetTo,_Add(BackupCp,1))})
				SetBYDShape(0 ,LairHivePlot,3)
				SetBYDShape(4 ,LairHivePlot,4)
				SetBYDShape(8 ,LairHivePlot,2)
				SetBYDShape(12,LairHivePlot,5)
				SetBYDShape(16,LairHivePlot,6)
				CIfEnd()
								--18~21 ZergGunPhase
				CTrigger(FP,{TMemory(_Add(BackupCp,18),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[1][2],SetTo,55)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,19),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[2][2],SetTo,54)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,20),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[3][2],SetTo,53)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,21),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[4][2],SetTo,48)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,18),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[1][2],SetTo,56)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,19),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[2][2],SetTo,48)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,20),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[3][2],SetTo,104)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,21),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[4][2],SetTo,51)},1)
			CIfEnd()
			CIf(FP,{TMemoryX(BackupCp,Exactly,0x1000,0xF000)}) -- Hive
				CIf(FP,{TMemory(_Add(BackupCp,5),Exactly,0)},{TSetMemory(0x6509B0,SetTo,_Add(BackupCp,1))})
				SetBYDShape(0 ,LairHivePlot,2+6)
				SetBYDShape(4 ,LairHivePlot,3+6)
				SetBYDShape(8 ,LairHivePlot,1+6)
				SetBYDShape(12,LairHivePlot,4+6)
				SetBYDShape(16,LairHivePlot,5+6)
				SetBYDShape(20,LairHivePlot,3+6)
				CIfEnd()
				CIf(FP,{TMemory(_Add(BackupCp,5),Exactly,1)},{TSetMemory(0x6509B0,SetTo,_Add(BackupCp,1))})
				SetBYDShape(0 ,LairHivePlot,4+6)
				SetBYDShape(4 ,LairHivePlot,2+6)
				SetBYDShape(8 ,LairHivePlot,3+6)
				SetBYDShape(12,LairHivePlot,5+6)
				SetBYDShape(16,LairHivePlot,6+6)
				SetBYDShape(20,LairHivePlot,4+6)
				CIfEnd()





				CTrigger(FP,{TMemory(_Add(BackupCp,18),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[1][2],SetTo,56)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,18),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[1][2],SetTo,56)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,19),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[2][2],SetTo,53)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,20),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[3][2],SetTo,104)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,21),Exactly,0)},{SetCVar(FP,BYDZergSpawnSet[4][2],SetTo,51)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,19),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[2][2],SetTo,51)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,20),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[3][2],SetTo,104)},1)
				CTrigger(FP,{TMemory(_Add(BackupCp,21),Exactly,1)},{SetCVar(FP,BYDZergSpawnSet[4][2],SetTo,51)},1)

				CIf(FP,{TMemory(_Add(BackupCp,18),Exactly,1)},{TSetMemory(0x6509B0,SetTo,_Add(BackupCp,1))})
				HeroSpawnSetForBYD(FP,0,28,86,Set,Cleared,BYDZergSpawnSet[1][2])
				HeroSpawnSetForBYD(FP,12,8,57,Cleared,Set,BYDZergSpawnSet[1][2])
				HeroSpawnSetForBYD(FP,16,80,98,Set,Cleared,BYDZergSpawnSet[1][2])
				CIfEnd()
			CIfEnd()






			NIfX(FP,{TMemory(_Mem(RedNumberX),AtLeast,BYDPlotSize)})
				CMov(FP,V(BYDGunCA1[5]),1)
				CiDiv(FP,BYDGunX,RedNumberX,BYDPlotSize)
				--if shape <= RedNumber then
				--BYDGunCA1[5] << 1
				--RedNumber/shape[1]
				NElseX()
				CMov(FP,V(BYDGunCA1[5]),_iDiv(BYDPlotSize,RedNumberX),1)
				CMov(FP,BYDGunX,1)
				--else
				--BYDGunX << 1
				--shape/RedNumber
			NIfXEnd()
			CAPlot(LairHivePlot,P8,0,23,nil,1,32,{BYDPlotNum,0,0,0,1,0},nil,FP,
				{CVar(FP,BYDGunTimer[2],Exactly,0),CVar(FP,BYDGunBreak[2],AtLeast,1)},
				{Order("Men",P8,24,Attack,5)},{SetCVar(FP,BYDGunBreak[2],Subtract,1),SetCVar(FP,BYDGunPhase[2],Add,1)})

			CTrigger(FP, {CVar(FP,BYDGunTimer[2],Exactly,0)}, {TSetCVar(FP,BYDGunTimer[2],SetTo,BYDGunX)}, 1)
			CSub(FP,BYDGunTimer,1)
			CTrigger(FP,{CVar(FP,BYDGunPhase[2],AtLeast,1)},{TSetMemory(_Add(BackupCp,5),Add,1),SetCVar(FP,BYDGunPhase[2],SetTo,0)},1)
			ZergGunCAPlot = {}

			for i = 1, 4 do
				table.insert(ZergGunCAPlot,CAPlotForward())
				CDoActions(FP,{TSetCVar(FP,ZergGunCAPlot[i][6],SetTo,_ReadF(_Add(BackupCp,6+i-1),0xFF)),SetCVar(FP,ZergGunCAPlot[i][9],SetTo,6)})
				CIf(FP,{TMemoryX(BackupCp,Exactly,0x1000,0xF000)})
					CTrigger(FP,{TMemoryX(_Add(BackupCp,1),Atmost,3*65536,0xFF0000)},{SetCVar(FP,ZergGunCAPlot[i][9],SetTo,7)},1)
					if i == 1 then
						CTrigger(FP,{TMemoryX(_Add(BackupCp,1),AtLeast,12*65536,0xFF0000),TMemoryX(_Add(BackupCp,1),Atmost,19*65536,0xFF0000)},{SetCVar(FP,ZergGunCAPlot[1][9],SetTo,7)},1)
					end
				CIfEnd()
			NIfX(FP,{TMemory(_Mem(RedNumberX),AtLeast,ZergGunShape[i][1])})
				CMov(FP,BYDGunLoopLimit[i],1)
				CiDiv(FP,BYDGunX,RedNumberX,ZergGunShape[i][1])
				NElseX()
				CMov(FP,BYDGunLoopLimit[i],_iDiv(_Mov(ZergGunShape[i][1]),RedNumberX),1)
				CMov(FP,BYDGunX,1)
			NIfXEnd()
			CAPlot({ZergGunShape[i]},P7,0,23,nil,1,32,{1,0,0,0,BYDGunLoopLimit[i],0,1,BYDZergSpawnSet[i]},nil,FP,
				{CVar(FP,ZergGunTimer[i][2],Exactly,0),CVar(FP,ZergGunBreak[i][2],AtLeast,1)},
				{Order("Men",P7,24,Attack,5),Order("Men",P8,24,Attack,5)},{SetCVar(FP,ZergGunBreak[i][2],Subtract,1),SetCVar(FP,ZergGunPhase[i][2],Add,1)})
			CTrigger(FP, {CVar(FP,ZergGunTimer[i][2],Exactly,0)}, {TSetCVar(FP,ZergGunTimer[i][2],SetTo,BYDGunX)}, 1)
			CSub(FP,ZergGunTimer[i],1)
			CTrigger(FP,{CVar(FP,ZergGunPhase[i][2],AtLeast,1)},{TSetMemory(_Add(BackupCp,17+i),Add,1),SetCVar(FP,ZergGunPhase[i][2],SetTo,0)},1)
			end

			CDoActions(FP,{
				TSetMemory(_Add(BackupCp,2),SetTo,V(BYDGunCA1[6])),
				TSetMemory(_Add(BackupCp,3),SetTo,BYDGunTimer),
				TSetMemory(_Add(BackupCp,4),SetTo,BYDGunBreak),
				TSetMemory(_Add(BackupCp,6),SetTo,V(ZergGunCAPlot[1][6])),
				TSetMemory(_Add(BackupCp,7),SetTo,V(ZergGunCAPlot[2][6])),
				TSetMemory(_Add(BackupCp,8),SetTo,V(ZergGunCAPlot[3][6])),
				TSetMemory(_Add(BackupCp,9),SetTo,V(ZergGunCAPlot[4][6])),
				TSetMemory(_Add(BackupCp,10),SetTo,ZergGunTimer[1]),
				TSetMemory(_Add(BackupCp,11),SetTo,ZergGunTimer[2]),
				TSetMemory(_Add(BackupCp,12),SetTo,ZergGunTimer[3]),
				TSetMemory(_Add(BackupCp,13),SetTo,ZergGunTimer[4]),
				TSetMemory(_Add(BackupCp,14),SetTo,ZergGunBreak[1]),
				TSetMemory(_Add(BackupCp,15),SetTo,ZergGunBreak[2]),
				TSetMemory(_Add(BackupCp,16),SetTo,ZergGunBreak[3]),
				TSetMemory(_Add(BackupCp,17),SetTo,ZergGunBreak[4]),
			})
			Call_LoadCp()
		NIfEnd()
		Trigger { -- TIMER
			players = {P6},
			conditions = {Deaths(CurrentPlayer,AtLeast,1,0);},
			actions = {
				MoveCp(Add,1*4);
				SetDeathsX(CurrentPlayer,Add,1,0,0xFFFF);
				MoveCp(Subtract,1*4);
				PreserveTrigger();
		}
		}
		DoActions(FP,MoveCp(Add,1*4))
		function MPtrSuspend()
			local X = {}
			for i = 1, MemoryPtrSize-1 do
				table.insert(X,SetDeaths(CurrentPlayer,SetTo,0,0))
				table.insert(X,MoveCp(Add,1*4))
			end
			table.insert(X,SetDeaths(CurrentPlayer,SetTo,0,0))
			table.insert(X,MoveCp(Subtract,(MemoryPtrSize-2)*4))
			return X
		end
		Trigger { -- Wave Suspend
			players = {P6},
			conditions = {DeathsX(CurrentPlayer,Exactly,2*16777216,0,0xFF000000),DeathsX(CurrentPlayer,AtLeast,500,0,0xFFFF)},
			actions = {
				MoveCp(Subtract,1*4);
				MPtrSuspend();
				PreserveTrigger();
		}
		}
		DoActions(FP,MoveCp(Subtract,1*4))

	NIfEnd() -- LAIR HIVE END
NIfEnd()
DoActions(FP,MoveCp(Add,MemoryPtrSize*4))
DoWhileEnd({Memory(0x6509B0,AtMost,EPD(MemoryPtr)+(MemoryPtrSize*50))})
NJumpEnd(FP,0x702)
NJumpEnd(FP,0x703)
NJumpEnd(FP,0x701)
CMov(FP,0x6509B0,FP)
SetRecoverCp()
RecoverCp(P6)


--CTrigPlibEnd

function StoryPrint(Text,T,AddTrig)
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,T,StoryT)
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX(Text,0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
		},HumanPlayers,FP);
		SetCDeaths(FP,Add,1,ButtonSound);
		AddTrig
	},
}
end

-------------------------
CIf(P6,{Switch("Switch 203",Set),Memory(0x628438, AtLeast, 0x00000001)})
	CIf(P6,CDeaths(P6,Exactly,0,Print13),SetCDeaths(P6,Add,88,Print13))
		Print_13(P6,{P1,P2,P3,P4,P5},"00")
	CIfEnd()
	DoActionsPX(SetCDeaths(P6,Subtract,1,Print13),P6)
CIfEnd()

CIf({Force1,P6},CDeaths(P6,AtLeast,1,Win)) -- 승리트리거
DoActionsPX({SetCDeaths(P6,SetTo,0,ArbT)},P6)

DoActionsX(FP,SetCDeaths(FP,SetTo,0,StoryT),1)
CTrigger(FP,{BYD},{TSetCDeaths(FP,Add,Dt,StoryT)},1)
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,350,Win);
		},
		actions = {
			SetCDeaths(FP,Add,1,ScorePrint);
		},
	}
	
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtMost,0,TestMode);
			CDeaths(P6,AtLeast,450,Win);
		},
		actions = {
			Victory();
		},
	}
DoActions(FP,Order(72,P6,64,Move,64))
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04항상 이 혼돈의 기억속에서... 삶을 포기하고 싶었어.\n\n\n\n",5000*1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04그럴때마다 이곳에 찾아온건 너희들이었지.\n\n\n\n",5000*2)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04나의 잘못된 과거\x10 ( \x11Ｐ\x04ａｓｔ \x10) \x04를 돌이켜주었고,\n\n\n\n",5000*3)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04수 많은 부정의 감정들을 잊게 해주었어.\n\n\n\n",5000*4)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04그럼에도.... 매번 이 운명 앞에서 모든게 끝나버렸지..\n\n\n\n",5000*5)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x06삶을 포기해버리는 운명.\n\n\n\n",5000*6)
StoryPrint("\x12\n\n\n\x13\x02† \x07【 \x04光 \x07】 \x02†\n\x13\x04이렇게 \x10대립\x04되었던 운명은 \x07빛\x04으로 바뀌었어.\n\n\n\n",5000*7,{RemoveUnit(82,P6),CreateUnitWithProperties(1,72,64,P6,{invincible = true}),CreateUnitWithProperties(1,84,64,P6,{hallucinated = true})})
StoryPrint("\x12\n\n\n\x13\x02† \x07【 \x04光 \x07】 \x02†\n\x13\x04이제 모든것은 순탄하게 흘러갈거야. 날 걱정하지 않아도 돼.\n\n\n\n",5000*8)
StoryPrint("\x12\n\n\n\x13\x02† \x07【 \x04光 \x07】 \x02†\n\x13\x04지금까지 고마웠어...\n\n\n\n",5000*9)
StoryPrint("\x12\n\n\n\x13\x02† \x07【 \x04光 \x07】 \x02†\n\x13\x07다음\x04에 이곳에 또 찾아오게 된다면..\n\n\n\n",5000*10)
StoryPrint("\x12\n\n\n\x13\x02† \x07【 \x04光 \x07】 \x02†\n\x13\x04그때는 같이 이 역경을 헤쳐나가자.\n\n\n\n",5000*11)
StoryPrint("\x12\n\n\n\x13\x02† \x07【 \x04光 \x07】 \x02†\n\x13\x04그때까지.. 작별이야. 안녕.\n\n\n\n",5000*12,{RemoveUnit(72,P6),CreateUnitWithProperties(1,84,64,P6,{hallucinated = true})})
Trigger { 
	players = {P6},
	conditions = {
			Label(0);
		BYD;
		DeathsX(0,AtMost,0,440,0xFFFFFF);
		DeathsX(1,AtMost,0,440,0xFFFFFF);
		DeathsX(2,AtMost,0,440,0xFFFFFF);
		DeathsX(3,AtMost,0,440,0xFFFFFF);
		DeathsX(4,AtMost,0,440,0xFFFFFF);
	},
	actions = {
		SetCDeaths(FP,Add,1,Win);
		PreserveTrigger();


	},
}
Trigger { 
	players = {P6},
	conditions = {
			Label(0);
		NBYD;
	},
	actions = {
		SetCDeaths(FP,Add,1,Win);
		PreserveTrigger();


	},
}

Trigger { -- 
	players = {Force1},
	conditions = {
		Label(0);
		BYD;
	},
	actions = {
		PlayWAV("staredit\\wav\\BYDEnding.ogg"); 
		PlayWAV("staredit\\wav\\BYDEnding.ogg"); 
		SetDeathsX(CurrentPlayer,Add,68000,440,0xFFFFFF);
		
		},
	}

Trigger { -- 
	players = {P6},
	conditions = {
		Label(0);
		BYD;
	},
	actions = { 
		RotatePlayer({
			PlayWAVX("staredit\\wav\\BYDEnding.ogg"),
			PlayWAVX("staredit\\wav\\BYDEnding.ogg")
		},ObPlayers,FP);
		SetMemory(0x58F494,Add,68000);
		
		},
	}


	for i=0, 56 do
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,100+i,Win);
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\n",4);
			DisplayText("\x13\x04"..string.rep("―", i),4);
			DisplayText("\n\n\n",4);
			DisplayText("\x13\x04"..string.rep("―", i),4);
			DisplayText("\n\n",4);
		},
	}
	end
	for i=0, 56 do
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,100+i,Win);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x04"..string.rep("―", i),4),
				DisplayTextX("\n\n\n",4),
				DisplayTextX("\x13\x04"..string.rep("―", i),4),
				DisplayTextX("\n\n",4)
			},ObPlayers,FP);
		},
	}
	end
	for k=1, 4 do
	for j=1, 5 do
	for i=2, 3 do
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,i,DifID);
			CDeaths(P6,Exactly,k,GModeTP);
			CDeaths(P6,AtLeast,200,Win);
			
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4);
			DisplayText("\x13"..DifT[i].." "..P[j].." "..GModeT[k],4);
			DisplayText("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4);
			PlayWAV("staredit\\wav\\H_Clear.ogg");
			PlayWAV("staredit\\wav\\H_Clear.ogg");
		},
	} 
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,i,DifID);
			CDeaths(P6,Exactly,k,GModeTP);
			CDeaths(P6,AtLeast,200,Win);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4),
				DisplayTextX("\x13"..DifT[i].." "..P[j].." "..GModeT[k],4),
				DisplayTextX("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4),
				PlayWAVX("staredit\\wav\\H_Clear.ogg"),
				PlayWAVX("staredit\\wav\\H_Clear.ogg")
			},ObPlayers,FP);
		},
	}
	end
	end
	end
	for k=1, 3 do
	for j=1, 5 do
	for i=4, 4 do
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,i,DifID);
			CDeaths(P6,Exactly,k,GModeTP);
			CDeaths(P6,AtLeast,200,Win);
			
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4);
			DisplayText("\x13"..DifT[i].." "..P[j].." "..GModeT[k],4);
			DisplayText("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4);
			PlayWAV("staredit\\wav\\H_Clear.ogg");
			PlayWAV("staredit\\wav\\H_Clear.ogg");
		},
	} 
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,i,DifID);
			CDeaths(P6,Exactly,k,GModeTP);
			CDeaths(P6,AtLeast,200,Win);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4),
				DisplayTextX("\x13"..DifT[i].." "..P[j].." "..GModeT[k],4),
				DisplayTextX("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4),
				PlayWAVX("staredit\\wav\\H_Clear.ogg"),
				PlayWAVX("staredit\\wav\\H_Clear.ogg")
			},ObPlayers,FP);
		},
	}
	end
	end
	end
	
	for j=1, 5 do
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,1,DifID);
			CDeaths(P6,AtLeast,200,Win);
			
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4);
			DisplayText("\x13"..DifT[1].." "..P[j].." "..GModeT[1],4);
			DisplayText("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4);
			PlayWAV("staredit\\wav\\H_Clear.ogg");
			PlayWAV("staredit\\wav\\H_Clear.ogg");
		},
	} 
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,1,DifID);
			CDeaths(P6,AtLeast,200,Win);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4),
				DisplayTextX("\x13"..DifT[1].." "..P[j].." "..GModeT[1],4),
				DisplayTextX("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4),
				PlayWAVX("staredit\\wav\\H_Clear.ogg"),
				PlayWAVX("staredit\\wav\\H_Clear.ogg")
			},ObPlayers,FP);
		},
	}
	end
	for j=1, 5 do
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,5,DifID);
			CDeaths(P6,AtLeast,200,Win);
			
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4);
			DisplayText("\x13"..DifT[5].." "..P[j],4);
			DisplayText("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4);
			PlayWAV("staredit\\wav\\H_Clear.ogg");
			PlayWAV("staredit\\wav\\H_Clear.ogg");
		},
	} 
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,j);
			CDeaths(P6,Exactly,5,DifID);
			CDeaths(P6,AtLeast,200,Win);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x04를 \x10클리어\x04 하셨습니다. \x06==",4),
				DisplayTextX("\x13"..DifT[5].." "..P[j],4),
				DisplayTextX("\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n\x13\x04Ｔｈａｎｋ　ｙｏｕ　ｆｏｒ　Ｐｌａｙｉｎｇ",4),
				PlayWAVX("staredit\\wav\\H_Clear.ogg"),
				PlayWAVX("staredit\\wav\\H_Clear.ogg")
			},ObPlayers,FP);
		},
	}
	end
	--DoActionsP(KillUnit("Men",Force2),P6)
CIfEnd() -- 승리트리거 끝

--print_utf8(12,0,"\x0d\x0d\x0d\x10【 \x04경과시간 - \x07００ : ００ : ００ \x08（\x04００００\x08，\x04０００．０％）\x10】");

HDSubTxt = "\x0d\x0d\x0d\x10【 \x04경과시간 - \x07００ : ００ : ００ \x08（\x04００００\x08，\x04０００．０％，\x08＋０００）\x10】"

--print_utf8(12,0,HDSubTxt);
HDSubTxtSize = GetStrSize(0,HDSubTxt)
--ClearRatePtr

CIf(P6,Switch("Switch 203",Set))
	
	
	CIf(P6,Switch("Switch 245",Set))
		Trigger { -- No comment (55C8D994)
			players = {P6},
			actions = {
				SetMemory(0x641598, SetTo, 0x100D0D0D);
				SetMemory(0x64159C, SetTo, 0x209080E3);
				SetMemory(0x6415A0, SetTo, 0xBDB2EA04);
				SetMemory(0x6415A4, SetTo, 0xECBCB3EA);
				SetMemory(0x6415A8, SetTo, 0xB0EA9C8B);
				SetMemory(0x6415AC, SetTo, 0x202D2084);
				SetMemory(0x6415B0, SetTo, 0x90BCEF07);
				SetMemory(0x6415B4, SetTo, 0x2090BCEF);
				SetMemory(0x6415B8, SetTo, 0xBCEF203A);
				SetMemory(0x6415BC, SetTo, 0x90BCEF90);
				SetMemory(0x6415C0, SetTo, 0xEF203A20);
				SetMemory(0x6415C4, SetTo, 0xBCEF90BC);
				SetMemory(0x6415C8, SetTo, 0xEF082090);
				SetMemory(0x6415CC, SetTo, 0xEF0488BC);
				SetMemory(0x6415D0, SetTo, 0xBCEF90BC);
				SetMemory(0x6415D4, SetTo, 0x90BCEF90);
				SetMemory(0x6415D8, SetTo, 0x0890BCEF);
				SetMemory(0x6415DC, SetTo, 0x048CBCEF);
				SetMemory(0x6415E0, SetTo, 0xEF90BCEF);--
				SetMemory(0x6415E4, SetTo, 0xBCEF90BC);--
				SetMemory(0x6415E8, SetTo, 0x8EBCEF90);--
				SetMemory(0x6415EC, SetTo, 0xEF90BCEF);--
				SetMemory(0x6415F0, SetTo, 0xBCEF85BC);
				SetMemory(0x6415F4, SetTo, 0x80E31089);
				SetMemory(0x6415F8, SetTo, 0x0D0D0D91);
				PreserveTrigger();
			},
		}
	CIfEnd()
	CIf(P6,Switch("Switch 245",Cleared))
	Trigger { -- No comment (EBC53FCF)
		players = {P6},
		actions = {
			SetMemory(0x641598, SetTo, 0x100D0D0D);
			SetMemory(0x64159C, SetTo, 0x209080E3);
			SetMemory(0x6415A0, SetTo, 0xBDB2EA04);
			SetMemory(0x6415A4, SetTo, 0xECBCB3EA);
			SetMemory(0x6415A8, SetTo, 0xB0EA9C8B);
			SetMemory(0x6415AC, SetTo, 0x202D2084);
			SetMemory(0x6415B0, SetTo, 0x90BCEF07);
			SetMemory(0x6415B4, SetTo, 0x2090BCEF);
			SetMemory(0x6415B8, SetTo, 0xBCEF203A);
			SetMemory(0x6415BC, SetTo, 0x90BCEF90);
			SetMemory(0x6415C0, SetTo, 0xEF203A20);
			SetMemory(0x6415C4, SetTo, 0xBCEF90BC);
			SetMemory(0x6415C8, SetTo, 0xEF082090);
			SetMemory(0x6415CC, SetTo, 0xEF0488BC);
			SetMemory(0x6415D0, SetTo, 0xBCEF90BC);
			SetMemory(0x6415D4, SetTo, 0x90BCEF90);
			SetMemory(0x6415D8, SetTo, 0x0890BCEF);
			SetMemory(0x6415DC, SetTo, 0x048CBCEF);
			SetMemory(0x6415E0, SetTo, 0xEF90BCEF);--
			SetMemory(0x6415E4, SetTo, 0xBCEF90BC);--
			SetMemory(0x6415E8, SetTo, 0x8EBCEF90);--
			SetMemory(0x6415EC, SetTo, 0xEF90BCEF);--
			SetMemory(0x6415F0, SetTo, 0xBCEF85BC);
			SetMemory(0x6415F4, SetTo, 0xBCEF088C);
			SetMemory(0x6415F8, SetTo, 0x90BCEF8B);--
			SetMemory(0x6415FC, SetTo, 0xEF90BCEF);--
			SetMemory(0x641600, SetTo, 0xBCEF90BC);--
			SetMemory(0x641604, SetTo, 0x80E31089);
			SetMemory(0x641608, SetTo, 0x0D0D0D91);
			
	
			PreserveTrigger();
		},
	}
	CIfX(P6,Command(P6,AtLeast,1, "【 Tenebris 】"))
		
		f_MemCpy(P6,0x64160C,_TMem(Arr(BStr01[3],0),"X","X",1),BStr01[2])
		CIf(P6,{CVar(FP,B3_H[2],AtLeast,1)})
			CMov(P6,B3_HV,_Add(_Div(_ReadF(B3_H),_Mov(256)),B3_K))
			CMov(P6,B3_HV2,B3_K2)

			TriggerX(FP,{CVar(FP,B3_K[2],AtLeast,1000000000)},{SetCVar(FP,B3_HV2[2],Add,1)},{Preserved})
			

			ItoDec(P6,B3_HV,VArr(B3_HT,0),0,0x08,0,9)
			ItoDec(P6,B3_HV2,VArr(B3_HT2,0),1,0x08,0)
			f_MovCpy(P6,0x64160C+BStr01[2],VArr(B3_HT2,0),4*4)
			f_MovCpy(P6,0x64160C+BStr01[2]+(4*4),VArr(B3_HT,0),4*4)
		CIfEnd()
	CelseX()
		CMov(P6,0x64160C,0)
		
	CIfXEnd()
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x58F60C,AtLeast,(2^i)*100);
			},
			actions = {
				SetMemoryX(0x6415F8,SetTo,(2^i)*16777216,2^i*16777216);
				SetMemory(0x58F60C,Subtract,(2^i)*100);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x58F60C,AtLeast,(2^i)*10);
			},
			actions = {
				SetMemoryX(0x6415FC,SetTo,(2^i)*65536,2^i*65536);
				SetMemory(0x58F60C,Subtract,(2^i)*10);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x58F60C,AtLeast,(2^i));
			},
			actions = {
				SetMemoryX(0x641600,SetTo,(2^i)*256,2^i*256);
				SetMemory(0x58F60C,Subtract,(2^i));
				PreserveTrigger();
			}
		}
	end
	CIfEnd()
	--ClearRateTxt
	
	
	Trigger {
		players = {P6},
		conditions = {
			Memory(ClearRatePtr, AtMost,999*1000);
		},
		actions = {
			SetMemory(0x6415E0, SetTo, 0xEF0D0D0D);--
			PreserveTrigger();
		}
	}
	
	Trigger {
		players = {P6},
		conditions = {
			Memory(ClearRatePtr,AtLeast,1*1000);
		},
		actions = {
			SetMemory(0x6415E0, SetTo, 0xEF91BCEF);--
			SetMemory(ClearRatePtr,Subtract,1000);
			PreserveTrigger();
		}
	}
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(ClearRatePtr,AtLeast,(2^i)*100);
			},
			actions = {
				SetMemoryX(0x6415E4,SetTo,(2^i)*256,2^i*256);
				SetMemory(ClearRatePtr,Subtract,(2^i)*100);
				PreserveTrigger();
			}
		}
	end
	
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(ClearRatePtr,AtLeast,(2^i)*10);
			},
			actions = {
				SetMemoryX(0x6415E8,SetTo,(2^i)*1,2^i*1);
				SetMemory(ClearRatePtr,Subtract,(2^i)*10);
				PreserveTrigger();
			}
		}
	end
	
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(ClearRatePtr,AtLeast,(2^i)*1);
			},
			actions = {
				SetMemoryX(0x6415EC,SetTo,(2^i)*65536,2^i*65536);
				SetMemory(ClearRatePtr,Subtract,(2^i)*1);
				PreserveTrigger();
			}
		}
	end
	ClearTxtColor = {0x18,0x0E,0x08,0x10,0x06}
	for i = 1, 5 do
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				CDeaths(FP,Exactly,i,DifID)
			},
			actions = {
				SetMemoryX(0x6415DC,SetTo,ClearTxtColor[i]*16777216,255*16777216);
				PreserveTrigger();
			}
		}
	end
	--ClearTxtEnd
	
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590000,AtLeast,(2^i)*36000000);
			},
			actions = {
				SetMemoryX(0x6415B0,SetTo,(2^i)*16777216,2^i*16777216);
				SetMemory(0x590000,Subtract,(2^i)*36000000);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590000,AtLeast,(2^i)*3600000);
			},
			actions = {
				SetMemoryX(0x6415B4,SetTo,(2^i)*65536,2^i*65536);
				SetMemory(0x590000,Subtract,(2^i)*3600000);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590000,AtLeast,(2^i)*600000);
			},
			actions = {
				SetMemoryX(0x6415BC,SetTo,(2^i),2^i);
				SetMemory(0x590000,Subtract,(2^i)*600000);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590000,AtLeast,(2^i)*60000);
			},
			actions = {
				SetMemoryX(0x6415BC,SetTo,(2^i)*16777216,2^i*16777216);
				SetMemory(0x590000,Subtract,(2^i)*60000);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590000,AtLeast,(2^i)*10000);
			},
			actions = {
				SetMemoryX(0x6415C4,SetTo,(2^i)*256,2^i*256);
				SetMemory(0x590000,Subtract,(2^i)*10000);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x590000,AtLeast,(2^i)*1000);
			},
			actions = {
				SetMemoryX(0x6415C8,SetTo,(2^i),2^i);
				SetMemory(0x590000,Subtract,(2^i)*1000);
				PreserveTrigger();
			}
		}
	end
	
	Trigger {
		players = {P6},
		conditions = {
			Memory(0x58F554,AtMost,399);
			
		},
		actions = {
			SetMemoryX(0x6415CC,SetTo,14*65536,0xFF0000);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Memory(0x58F554,AtLeast,400);
			Memory(0x58F554,AtMost,799);
			
		},
		actions = {
			SetMemoryX(0x6415CC,SetTo,15*65536,0xFF0000);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Memory(0x58F554,AtLeast,800);
			Memory(0x58F554,AtMost,1199);
			
		},
		actions = {
			SetMemoryX(0x6415CC,SetTo,17*65536,0xFF0000);
			PreserveTrigger();
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Memory(0x58F554,AtLeast,1200);
			
		},
		actions = {
			SetMemoryX(0x6415CC,SetTo,08*65536,0xFF0000);
			PreserveTrigger();
		}
	}
	
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x58F554,AtLeast,(2^i)*1000);
				
			},
			actions = {
				SetMemoryX(0x6415D0,SetTo,(2^i)*256,2^i*256);
				SetMemory(0x58F554,Subtract,(2^i)*1000);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x58F554,AtLeast,(2^i)*100);
			},
			actions = {
				SetMemoryX(0x6415D4,SetTo,(2^i),2^i);
				SetMemory(0x58F554,Subtract,(2^i)*100);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x58F554,AtLeast,(2^i)*10);
			},
			actions = {
				SetMemoryX(0x6415D4,SetTo,(2^i)*16777216,2^i*16777216);
				SetMemory(0x58F554,Subtract,(2^i)*10);
				PreserveTrigger();
			}
		}
	end
	for i = 3, 0, -1 do
		Trigger {
			players = {P6},
			conditions = {
				Memory(0x58F554,AtLeast,(2^i));
			},
			actions = {
				SetMemoryX(0x6415D8,SetTo,(2^i)*65536,2^i*65536);
				SetMemory(0x58F554,Subtract,(2^i));
				PreserveTrigger();
			}
		}
	end
	
	
CIfEnd()
CIf({P6},CDeaths(P6,AtLeast,1,GameOver)) -- 패배트리거
	
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,100,GameOver);
		},
		actions = {
			SetCDeaths(FP,Add,1,ScorePrint);
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtMost,0,TestMode);
			CDeaths(P6,AtLeast,200,GameOver);
		},
		actions = {
			RotatePlayer({Defeat()},MapPlayers,FP)
		},
	}
	DoActionsPX(SetCDeaths(P6,Add,1,GameOver),P6)
CIfEnd() -- 패배트리거 끝
PatchArr1 = {}
for i = 0, 4 do
	table.insert(PatchArr1,SetMemoryW(0x660E00+(MarID[i+1]*2),SetTo,0))
	table.insert(PatchArr1,SetMemoryB(0x6647B0+MarID[i+1],SetTo,0))
	table.insert(PatchArr1,SetMemoryB(0x57F27C + (i * 228) + 7,SetTo,0))
end

if Limit == 1 then
	
	CIf({Force1,P6},CDeaths(P6,Exactly,1,TestMode)) -- 테스트 트리거

Trigger { -- 예약메딕
	players = {0},
	conditions = {
		Label(0);
		Command(0,AtLeast,1,72);
	},
	actions = {
		SetCVar(FP,B7_K[2],Add,10);
		PreserveTrigger();
	},
}

	if TestStartToBYD == 1 then
	Trigger { -- 퓨어모드 선택시
		players = {P6},
		conditions = {
			Label(0);
		},
		actions = {
			RemoveUnit(125,AllPlayers);
			SetMemoryX(0x6559CC, SetTo, 20*65536,0xFFFF0000);
			SetMemoryW(0x656380+44,SetTo,150);
			PatchArr1;
			
			},
		}
	
	Trigger { -- 퓨어모드 선택시 2인이상 공격력조절
		players = {P6},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],AtLeast,2);
		},
		actions = {
			
			SetMemoryX(0x656EB0, SetTo, 200,0xFFFF);
			SetMemoryX(0x657678, SetTo, 14,0xFFFF);
			SetMemoryX(0x656EB0, SetTo, 1000*65536,0xFFFF0000);
			SetMemoryX(0x657678, SetTo, 30*65536,0xFFFF0000);
			SetMemoryX(0x656F98, SetTo, (3000)*65536,0xFFFF0000);
			SetMemoryX(0x657760, SetTo, (130)*65536,0xFFFF0000);
			},
		}
	
	
	Trigger { -- 퓨어모드 선택시 1인 공격력조절
		players = {P6},
		conditions = {
			Label(0);
			CVar(P6,SetPlayers[2],Exactly,1);
		},
		actions = {
			
			SetMemoryX(0x656EB0, SetTo, 300,0xFFFF);
			SetMemoryX(0x657678, SetTo, 21,0xFFFF);
			SetMemoryX(0x656EB0, SetTo, 1500*65536,0xFFFF0000);
			SetMemoryX(0x657678, SetTo, 45*65536,0xFFFF0000);
			SetMemoryX(0x656F98, SetTo, (4500)*65536,0xFFFF0000);
			SetMemoryX(0x657760, SetTo, (65*3)*65536,0xFFFF0000);
			},
		}
		
	Trigger { -- 퓨어모드+퓨쳐 선택시
		players = {P6},
		conditions = {
			Label(0);
		},
		actions = {
			SetCDeaths(FP,SetTo,1,BYDDiff);
			SetCDeaths(FP,SetTo,0,Ready); -- 추가 텍스트 출력을 위해 강제로 Ready변수를 Off함
			SetCVar(P6,MaxHP[2],SetTo,130000);
			SetCVar(P6,MaxHPP[2],SetTo,2600);
			SetCDeaths(P6,SetTo,5,DifID);
			SetCDeaths(P6,SetTo,3,Difficulty);
			SetCDeaths(P6,SetTo,2,GMode);
			SetSwitch("Switch 204",Set);
			SetSwitch("Switch 201",Set);
			SetCVar(FP,ClearRate[2],SetTo,0);
			},
		}
	end

		--f_MemCpy(P6,0x58F700,MemoryPtr+(10*4),4*12)
		Trigger {
			players = {Force1},
			conditions = {
				Label(0);
				Switch("Switch 203",Set);
				Command(P6,AtMost,0,64);
				
			},
			actions = {
				--SetInvincibility(Enable,"Any unit",Force1,"Anywhere");
				RunAIScript("Turn ON Shared Vision for Player 7");
				RunAIScript("Turn ON Shared Vision for Player 8");
				RunAIScript("Turn ON Shared Vision for Player 6");
				--SetInvincibility(Disable,173,Force2,"Anywhere");
				
			},
		}
		
		Trigger {
			players = {Force1},
			conditions = {
				Label(0);
				Switch("Switch 203",Set);
				Command(P6,AtLeast,1,64);
				
			},
			actions = {
				--SetInvincibility(Disable,"Any unit",Force1,"Anywhere");
				RunAIScript("Turn ON Shared Vision for Player 7");
				RunAIScript("Turn ON Shared Vision for Player 8");
				RunAIScript("Turn ON Shared Vision for Player 6");
				
			},
		}
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Deaths(P1,AtLeast,1,204);
			},
			actions = {
				KillUnit("Men",P7);
				KillUnit("Men",P8);
				KillUnit("【 Sunken Colony 】",Force2);
				KillUnit("【 Creep Colony 】",Force2);
				KillUnit("【 Spore Colony 】",Force2);
				PreserveTrigger();
			}
			}
		
		Trigger {
			players = {FP},
			conditions = {
				Label(0);
				Deaths(P1,AtLeast,1,204);
			},
			actions = {
				--SetCDeaths(FP,Add,1,HDStart)
			}
			}
		
		Trigger { 
			players = {P6},
			conditions = {
				Label(0);
				CDeaths(P6,Exactly,3,Difficulty);
				
			},
			actions = {
				SetSwitch("Switch 201",Set);
				SetSwitch("Switch 247",Set);
				
			},
		}
		Trigger { 
			players = {P6},
			conditions = {
				Label(0);
				CDeaths(P6,Exactly,1,Difficulty);
				
			},
			actions = {
				SetCDeaths(P6,SetTo,1,CCode(0x1002,40));
				RemoveUnit(190,Force2);
				RemoveUnit(200,Force2);
				SetSwitch("Switch 245",Set);
				
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				ElapsedTime(AtLeast,4);
				CDeaths(FP,AtMost,0,BYDBossStart);
			},
			actions = {
				ModifyUnitShields(All,"Men",Force1,"Anywhere",100);
				ModifyUnitHitPoints(All,"Men",Force1,"Anywhere",100);
				PreserveTrigger();
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				ElapsedTime(AtLeast,4);
			},
			actions = {
				SetSwitch("Switch 203",Set);
				CreateUnit(10,57,64,P7);
		--  SetInvincibility(Enable,57,P6,64);
			},
		}
		for i = 0, 4 do
		Trigger {
			players = {i},
			conditions = {
				Label(0);
				ElapsedTime(AtLeast,4);
			},
			actions = {
				CenterView("Anywhere");
				DisplayText(string.rep("\n", 20),4);
				DisplayText("\x13\x04"..string.rep("―", 56),4);
				DisplayText("\x13\x04！！！　ＲＥＡＤＹ　！！！\n",4);
				DisplayText("\n\x13\x04S T A R T\n\n",4);
				DisplayText("\n\x13\x04！！！　ＲＥＡＤＹ　！！！",4);
				DisplayText("\x13\x04"..string.rep("―", 56),4);
				PlayWAV("sound\\Bullet\\pshield.wav");
				SetAllianceStatus(Force2,Enemy);
				SetResources(i,Add,0x70000000,Ore);
				--CreateUnit(255,MarID[i+1],5,i);
				SetDeaths(i,SetTo,36,125);
				
			},
		}
		end
		Trigger { -- 0
			players = {P6},
			conditions = {
				Label(0);
				ElapsedTime(AtLeast,5);
			},
			actions = {
				SetMemory(0x5124F0, SetTo, 0x0000001D);
				SetMemory(0x58F4F0, SetTo, 4);
				SetMemory(0x6566F8, Add, 512);
				CreateUnit(1,"Map Revealer",5,P6);
				SetMemory(0x58F458,Add,1);
				SetCountdownTimer(SetTo,138*60);
				SetMemory(0x58F45C,SetTo,0);
				SetMemory(0x58F460,SetTo,600*1000);
				SetDeaths(0,Add,160000,432);
				SetDeaths(1,Add,160000,432);
				SetDeaths(2,Add,160000,432);
				SetDeaths(3,Add,160000,432);
				SetDeaths(4,Add,160000,432);
				SetSwitch("Switch 215",Set);
				--SetCDeaths(P6,SetTo,1,IntroBGM);
				--SetMemoryX(0x656F98, SetTo, 60000*65536,0xFFFF0000);
				--SetMemoryX(0x65676C, SetTo, 3*256,0xFF00);
				--SetMemoryX(0x656970, SetTo, 300*65536,0xFFFF0000);
				--SetMemoryX(0x6571B0, SetTo, 300*65536,0xFFFF0000);
				--SetMemoryX(0x657868, SetTo, 300*65536,0xFFFF0000);
			},
		}
		
		Trigger { -- 0 관전자
			players = {P6},
			conditions = {
				Label(0);
				ElapsedTime(AtLeast,5);
			},
			actions = {
				RotatePlayer({
					CenterView("Anywhere"),
					DisplayTextX(string.rep("\n", 20),4),
					DisplayTextX("\x13\x04"..string.rep("―", 56),4),
					DisplayTextX("\n",4),
					DisplayTextX("\n\x13\x04S T A R T\n\n",4),
					DisplayTextX("\n",4),
					DisplayTextX("\x13\x04"..string.rep("―", 56),4),
					PlayWAVX("sound\\Bullet\\pshield.wav")
				},ObPlayers,FP);
			},
		}
		for i = 0, 4 do
		Trigger {
			players = {FP},
			conditions = {
				NBYD;
				Command(i,AtLeast,1,111)
				
			},
			actions = {
				CreateUnit(80,MarID[i+1],5,i);
				
			},
		}
		end
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				BYD;
				
			},
			actions = {
				SetCVAar(VArr(PlayerMarCreateToken,0),Add,48);
				SetCVAar(VArr(PlayerMarCreateToken,1),Add,48);
				SetCVAar(VArr(PlayerMarCreateToken,2),Add,48);
				SetCVAar(VArr(PlayerMarCreateToken,3),Add,48);
				SetCVAar(VArr(PlayerMarCreateToken,4),Add,48);
				
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,5,32);
				
			},
			actions = {
				SetCDeaths(P6,SetTo,1,CCode(0x1000,0));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,24));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,9));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,58));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,44));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,34));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,16));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,17));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,1));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,25));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,54));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,55));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,40));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,41));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,31));
				SetSwitch("Switch 130",Set);
				--SetDeaths(P6,SetTo,1,173);
		--  KillUnit(152,P7)
				
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,10,32);
				
			},
			actions = {
				SetCDeaths(P6,SetTo,1,CCode(0x1000,2));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,26));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,8));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,59));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,45));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,35));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,18));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,19));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,3));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,27));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,52));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,53));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,42));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,43));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,30));
				SetSwitch("Switch 130",Set);
		--  KillUnit(152,P8)
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,15,32);
				
			},
			actions = {
				SetCDeaths(P6,SetTo,1,CCode(0x1000,4));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,20));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,10));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,56));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,28));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,36));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,37));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,5));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,21));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,48));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,49));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,46));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,32));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,14));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,15));
				SetSwitch("Switch 130",Set);
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,20,32);
				
			},
			actions = {
				SetCDeaths(P6,SetTo,1,CCode(0x1002,0));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,1));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,2));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,3));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,8));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,9));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,10));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,11));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,41));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,42));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,43));
				SetCDeaths(P6,SetTo,1,CCode(0x1002,44));
				SetCDeaths(P6,SetTo,2,EZCon);
				SetCDeaths(P6,SetTo,1,CCode(0x1000,6));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,22));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,11));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,57));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,29));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,38));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,39));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,7));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,23));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,50));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,51));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,47));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,33));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,12));
				SetCDeaths(P6,SetTo,1,CCode(0x1000,13));
		--    SetInvincibility(Disable,173,Force2,64);
				KillUnit(150,Force2);
				KillUnit(156,Force2);
				SetDeaths(P6,SetTo,1, "【 Tenebris 】");
				SetDeaths(P6,SetTo,1, "【 Divide 】");
				SetDeaths(P6,SetTo,1, "【 Demise 】");
				SetDeaths(P6,SetTo,1, "【 Anomaly 】");
				--ModifyUnitEnergy(All,"Buildings",Force2,64,0);
				--KillUnit("Buildings",Force2);
				--SetCDeaths(P6,SetTo,1,HDStart);
				--SetCDeaths(P6,SetTo,1,BYDBossStart);
				--SetCDeaths(P6,SetTo,1,CCode(0x1002,45))
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,25,32);
				
			},
			actions = {
				SetCDeaths(FP,SetTo,1,CCode(0x1002,40));
				SetCVar(FP,XY[2],SetTo,550*10);

			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,30,32);
				
			},
			actions = {
				--SetCDeaths(P6,SetTo,1,HDStart);
				--KillUnit("Any unit",Force2);
				--SetCDeaths(P6,SetTo,1,CCode(0x1002,45));
			},
		}
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,30,32);
				
			},
			actions = {SetCDeaths(FP,SetTo,5000*9,StoryT);
				SetCVar(FP,B7_K[2],SetTo,80);
				SetCJump(0x648,1);
			},
		}
		
		
		TestTable = {}
		for i = 0,39 do
		table.insert(TestTable,SetCDeaths(P6,SetTo,1,CCode(0x1002,i)))
		end
		
		Trigger {
			players = {P6},
			conditions = {
				Label(0);
				Command(P1,AtLeast,20,32);
			},
			actions = {
				--SetCDeaths(P6,SetTo,1,CountEx2+40);
				TestTable;
				SetCDeaths(P6,SetTo,9999,IntroT2);
			},
		}
	CIfEnd() -- 테스트 트리거 끝
	
end

CIf(AllPlayers,Switch("Switch 203",Cleared)) -- 인트로
	
	Trigger { -- 배속방지
		players = {P6},
		conditions = {
			Memory(0x51CE84,AtLeast,1001);
		},
		actions = {
			RotatePlayer({
				DisplayTextX("\x13\x1B방 제목에서 배속 옵션을 제거해 주십시오.",4),
				Victory()
			},HumanPlayers,FP);
		}
	}
	
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57EEE8 + 36*5,Exactly,0,0xFF);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57EEE8 + 36*6,Exactly,0,0xFF);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,0,0xFF);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57EEE8 + 36*5,Exactly,2,0xFF);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57EEE8 + 36*6,Exactly,2,0xFF);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57EEE8 + 36*7,Exactly,2,0xFF);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 슬롯 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57efc0,AtLeast,1*256,0xFF00);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	Trigger { -- 게임오버
		players = {Force1},
		conditions = {
			MemoryX(0x57efe4,AtLeast,1*256,0xFF00);
		},
		actions = {
			PlayWAV("sound\\Misc\\TPwrDown.wav");
			DisplayText("\x13\x1B컴퓨터 종족 변경이 감지되었습니다. 다시 시작해주세요.",4);
			Defeat();
		}
	}
	
	Trigger { -- 싱글플 방지
	players = {AllPlayers},
	conditions = {
	Memory(0x57F0B4, Exactly, 0);
	},
	actions = {
		DisplayText("\x13\x1B멀티플레이 전용 맵입니다. 싱글플레이 버젼으로 시작해주세요.",4);
	Victory();
	},
	}
	Trigger {
		players = {P6},
		actions = {
			MoveUnit(All,"Men",Force2,20,5);
			MoveUnit(All,"Men",P7,3,5);
			MoveUnit(All,"Men",P8,3,5);
			ModifyUnitShields(All,174,Force2,"Anywhere",100);
			ModifyUnitShields(All,69,Force2,"Anywhere",100);
			PreserveTrigger();
			},
		}
	
	Trigger { -- 영작유닛세팅
	players = {P6},
		actions = {
			CreateUnit(1,64,183,P6);
			SetInvincibility(Enable,64,P6,183);
			GiveUnits(1,64,P6,"Anywhere",P12);
			CreateUnit(6,3,112,P7);
			CreateUnit(6,8,113,P7);
			CreateUnit(6,10,114,P7);
			CreateUnit(6,52,115,P7);
			CreateUnit(6,77,116,P7);
			CreateUnit(6,57,117,P7);
			CreateUnit(6,76,118,P7);
			CreateUnit(6,75,119,P7);
			CreateUnit(6,65,120,P7);
			CreateUnit(6,66,121,P7);
			CreateUnit(6,67,122,P7);
			CreateUnit(6,61,123,P7);
			CreateUnit(6,57,132,P7);
			CreateUnit(6,78,133,P7);
			CreateUnit(6,63,134,P7);
			CreateUnit(6,28,135,P7);
			CreateUnit(6,17,136,P7);
			CreateUnit(6,19,137,P7);
			CreateUnit(6,21,138,P7);
			CreateUnit(6,86,139,P7);
			CreateUnit(1,25,124,P7);
			CreateUnit(1,25,125,P7);
			CreateUnit(1,25,126,P7);
			CreateUnit(1,25,127,P7);
			CreateUnit(1,25,128,P7);
			CreateUnit(1,25,129,P7);
			CreateUnit(1,25,130,P7);
			CreateUnit(1,25,131,P7);
			CreateUnit(1,102,167,P7);
			CreateUnit(1,102,168,P7);
			CreateUnit(1,102,169,P7);
			CreateUnit(1,102,170,P7);
			CreateUnit(6,80,171,P7);
			CreateUnit(6,79,172,P7);
			CreateUnit(6,81,173,P7);
			CreateUnit(2,29,174,P7);
			SetLoc(173,0,Add,32);
			SetLoc(173,8,Add,32);
			CreateUnit(2,29,174,P7);
			SetLoc(173,4,Add,32);
			SetLoc(173,12,Add,32);
			CreateUnit(1,29,174,P7);
			SetLoc(173,0,Subtract,32);
			SetLoc(173,8,Subtract,32);
			CreateUnit(1,29,174,P7);
			
		},
	}
	
	Trigger { -- 변속 크리스탈 Create
		players = {P6},
		actions = { 
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,32);
			SetLoc(2,8,Add,32);
			CreateUnit(1,219,3,CurrentPlayer);
			SetLoc(2,0,Add,-32*9);  
		},
	}
	Trigger { -- 공메모리 초기값
		players = {P6},
		actions = {
			SetMemory(0x58F450,SetTo,0);
			SetMemory(0x58F454,SetTo,0);
			SetMemory(0x58F458,SetTo,0);
			SetMemory(0x58F45C,SetTo,0);
			SetMemory(0x58F480,SetTo,0);
			SetMemory(0x58F484,SetTo,0);
			SetMemory(0x58F488,SetTo,0);
			SetMemory(0x58F48C,SetTo,0);
			SetMemory(0x58F490,SetTo,0);
			SetMemory(0x58F494,SetTo,0);
			SetMemory(0x58F4B0,SetTo,0);
			SetMemory(0x58F4B4,SetTo,0);
			SetMemory(0x58F4B8,SetTo,0);
			SetMemory(0x58F4BC,SetTo,0);
			SetMemory(0x58F4C0,SetTo,0);
			SetMemory(0x58F464,SetTo,0);
			SetMemory(0x58F468,SetTo,0);
			SetMemory(0x58F46C,SetTo,0);
			SetMemory(0x58F470,SetTo,0);
			SetMemory(0x58F474,SetTo,0);
			SetMemory(0x58F4C8,SetTo,0);
			SetMemory(0x58F4CC,SetTo,0);
			SetMemory(0x58F4D0,SetTo,0);
			SetMemory(0x58F4D4,SetTo,0);
			SetMemory(0x58F4D8,SetTo,0);
			SetMemory(0x58F4DC,SetTo,0);
			SetMemory(0x58F4F0,SetTo,0);
			SetMemory(0x58F500,SetTo,0);
			SetMemory(0x58F504,SetTo,0);
			SetMemory(0x58F508,SetTo,0);
			SetMemory(0x58F50C,SetTo,0);
			SetMemory(0x58F510,SetTo,0);
			SetMemory(0x58F514,SetTo,0);
			SetMemory(0x58F518,SetTo,0);
			SetMemory(0x58F51C,SetTo,0);
			SetMemory(0x58F520,SetTo,0);
			SetMemory(0x58F524,SetTo,0);
			SetMemory(0x58F528,SetTo,0);
			SetMemory(0X58F530,SetTo,0);
			SetMemory(0x590000,SetTo,0);
			SetMemory(0x590004,SetTo,0);
			SetMemory(0x590008,SetTo,0);
			SetMemory(0x59000C,SetTo,0);
			SetMemory(0x590010,SetTo,0);
			SetMemory(0x590014,SetTo,0);
			SetMemory(0x58F550,SetTo,0);
			
			},
		}
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtMost,100,IntroT);
		},
		actions = {
			CenterView(20);
			PreserveTrigger();
		},
	}
	for i=1, 57 do
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,i+1,IntroT);
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\n",4);
			DisplayText("\x13\x04"..string.rep("―", i),4);
			DisplayText("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x06==\n\x13\x02"..VerText.."\n\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4);
			DisplayText("\x13\x04"..string.rep("―", i),4);
			DisplayText("\x13\x03Made \x06by \x04GALAXY_BURST\n\n",4);
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,i+1,IntroT);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x04"..string.rep("―", i),4),
				DisplayTextX("\x13\x06== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x06==\n\x13\x02"..VerText.."\n\x13\x1FCtrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4),
				DisplayTextX("\x13\x04"..string.rep("―", i),4),
				DisplayTextX("\x13\x03Made \x06by \x04GALAXY_BURST\n\n",4)
			},ObPlayers,FP);
		},
	}
	end
	
	
	
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,3,IntroT);
		},
		actions = {
			SetCDeaths(P6,SetTo,1,BGMType);
		},
	}
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,94,IntroT);
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\n",4);
			DisplayText("\x13\x05"..string.rep("―", 56),4);
			DisplayText("\x13\x05== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x06==\n\x13\x05"..VerText.."\n\x13\x05Ctrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4);
			DisplayText("\x13\x05"..string.rep("―", 56),4);
			DisplayText("\x13\x05Made \x06by \x04GALAXY_BURST\n\n",4);
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,94,IntroT);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x05"..string.rep("―", 56),4),
				DisplayTextX("\x13\x05== \x04마린키우기 \x07Ｍｅｍｏｒｙ \x06==\n\x13\x05"..VerText.."\n\x13\x05Ctrig \x04Assembler \x07v5.3T\x04, \x1FCA \x16Paint \x07v2.1 \x04in Used \x19(つ>ㅅ<)つ",4),
				DisplayTextX("\x13\x05"..string.rep("―", 56),4),
				DisplayTextX("\x13\x05Made \x06by \x04GALAXY_BURST\n\n",4)
			},ObPlayers,FP);
		},
	}
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,97,IntroT);
		},
		actions = {
			DisplayText(string.rep("\n", 20),4);
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,97,IntroT);
		},
		actions = {
			RotatePlayer({DisplayTextX(string.rep("\n", 20),4)},ObPlayers,FP);
		},
	}
	Trigger { -- 모드선택유닛 생성
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,100,IntroT);
		},
		actions = {
			CreateUnit(1,"Bengalaas (Jungle)",21,P6);
			CreateUnit(1,"Map Revealer",21,Force1);
	},
	}
	Trigger { -- 모드선택유닛 생성2
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,50,IntroT3);
		},
		actions = {
			--RemoveUnitAt(1,"Protoss Beacon",19,5);
			--RemoveUnitAt(1,"Protoss Beacon",195,5);
			CreateUnit(1,"Bengalaas (Jungle)",21,P6);
			RotatePlayer({PlayWAVX("staredit\\wav\\GMode.ogg")},HumanPlayers,FP);
	},
	}
	Trigger { -- 모드선택유닛 권한설정P1
		players = {P6},
		conditions = {
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",21);
			Bring(P1,Exactly,1,"Terran Barracks","Anywhere");
		},
		actions = {
			GiveUnits(1,"Bengalaas (Jungle)",AllPlayers,21,P1);
			PreserveTrigger();
	},
	}
	Trigger { -- 모드선택유닛 권한설정P2
		players = {P6},
		conditions = {
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",21);
			Bring(P1,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P2,Exactly,1,"Terran Barracks","Anywhere");
		},
		actions = {
			GiveUnits(1,"Bengalaas (Jungle)",AllPlayers,21,P2);
			PreserveTrigger();
	},
	}
	Trigger { -- 모드선택유닛 권한설정P3
		players = {P6},
		conditions = {
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",21);
			Bring(P1,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P2,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P3,Exactly,1,"Terran Barracks","Anywhere");
		},
		actions = {
			GiveUnits(1,"Bengalaas (Jungle)",AllPlayers,21,P3);
			PreserveTrigger();
	},
	}
	Trigger { -- 모드선택유닛 권한설정P4
		players = {P6},
		conditions = {
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",21);
			Bring(P1,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P2,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P3,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P4,Exactly,1,"Terran Barracks","Anywhere");
		},
		actions = {
			GiveUnits(1,"Bengalaas (Jungle)",AllPlayers,21,P4);
			PreserveTrigger();
	},
	}
	Trigger { -- 모드선택유닛 권한설정P5
		players = {P6},
		conditions = {
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",21);
			Bring(P1,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P2,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P3,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P4,Exactly,0,"Terran Barracks","Anywhere");
			Bring(P5,Exactly,1,"Terran Barracks","Anywhere");
		},
		actions = {
			GiveUnits(1,"Bengalaas (Jungle)",AllPlayers,21,P5);
			PreserveTrigger();
	},
	}
	Trigger { -- 모드선택유닛 이탈금지
		players = {P6},
		conditions = {
			Bring(AllPlayers,AtMost,0,"Bengalaas (Jungle)",21);
			},
		actions = {
		MoveUnit(1,"Bengalaas (Jungle)",AllPlayers,"Anywhere",21);
		PreserveTrigger();
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			Switch("Switch 202",Cleared);
			CDeaths(P6,AtMost,0,Difficulty);
			CDeaths(P6,AtLeast,100,IntroT);
		},
		actions = {
			RotatePlayer({
				CenterView(21),
				DisplayTextX("\n\n\n\n\n\x13\x10Ｆｕｔｕｒｅ\n\n\x13\x0EＥａｓｙ\t\t\t\t\t\t\x08Ｈａｒｄ\n\n\x13\x18Ｔｕｔｏｒｉａｌ \x0EＥａｓｙ\n\n\x13\x04난이도를 선택해 주세요.\n\x13\x0415초 후 자동으로 \x0EＥａｓｙ \x04난이도가 선택됩니다.",4)
			},HumanPlayers,FP);
			PreserveTrigger();
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			Switch("Switch 202",Set);
			CDeaths(P6,AtMost,0,Difficulty);
			CDeaths(P6,AtLeast,100,IntroT);
		},
		actions = {
			RotatePlayer({
				CenterView(21),
				DisplayTextX("\n\n\n\n\n\x13\x10Ｆｕｔｕｒｅ\n\n\x13\x0EＥａｓｙ\t\t\t\t\t\t\x08Ｈａｒｄ\n\n\x13\x18Ｔｕｔｏｒｉａｌ \x0EＥａｓｙ\n\n\x13\x04정말 \x10Ｆｕｔｕｒｅ\x04난이도를 선택하시겠습니까....?\n",4)
			},HumanPlayers,FP);
			PreserveTrigger();
		},
	}
	Trigger {
		players = {Force1},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,1,Difficulty);
			CDeaths(P6,AtMost,49,IntroT2);
		},
		actions = {
			CenterView(21);
			PreserveTrigger();
		},
	}
	
	EVModeT = "\x13\x10PURE MODE\n\n\x13\x0E정식모드\t\t\t\t\t\t\x08클래식 모드\n\n\x13\x18EV MODE\n\n\x13\x04모드를 선택하십시오.\n"
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtMost,2,Difficulty);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Ready);
			CDeaths(P6,AtLeast,50,IntroT3);
		},
		actions = {
			RotatePlayer({
				CenterView(21),
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX(EVModeT,4)
			},HumanPlayers,FP);
			PreserveTrigger();
		},
	}
	EVModeT = "\x13\x06Ｂｅｙｏｎｄ\n\n\x13\x0E정식모드\t\t\t\t\t\t\x08클래식 모드\n\n\x13\x18EV MODE\n\n\x13\x04모드를 선택하십시오.\n"
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,0,BYDDiff);
			CDeaths(P6,Exactly,3,Difficulty);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Ready);
			CDeaths(P6,AtLeast,50,IntroT3);
		},
		actions = {
			RotatePlayer({
				CenterView(21),
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX(EVModeT,4)
			},HumanPlayers,FP);
			PreserveTrigger();
		},
	}
	
	Trigger { -- 비기너 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Difficulty);
			CDeaths(P6,AtLeast,100,IntroT);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",195);
		},
		actions = {
			RotatePlayer({CenterView(20),DisplayTextX("n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x18Ｔｕｔｏｒｉａｌ \x0EＥａｓｙ를 선택하셨습니다.\n\n\x13\x04자세한 설명을 시작합니다.",4),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			RemoveUnit("Protoss Beacon",AllPlayers);
			RemoveUnit("Map Revealer",AllPlayers);
			SetSwitch("Switch 244",Set);
			RemoveUnit(190,Force2);
			RemoveUnit(200,Force2);
			SetCVar(FP,ClearRate[2],SetTo,280);
			RemoveUnit("Factories",Force2);
			SetCDeaths(P6,SetTo,1,DifID);
	},
	}
	for i=0,4 do
	Trigger { -- 아비터 비활성화
		players = {i},
		conditions = {
			Switch("Switch 244",Set);
		},
		actions = {
			SetMemoryB(0x57F27C+(228*i)+86,SetTo,0);
		},
	}
	end
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04조합소와 환전소는 이곳입니다."
	View = 58
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*7,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			CreateUnit(1,"Map Revealer",58,Force1);
			CreateUnit(1,"Map Revealer",59,Force1);
			},
		}
	View = 7
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*9,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View)},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			CreateUnit(1,"Map Revealer",59,Force1);
			},
		}
	View = 6
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*11,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View)},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			CreateUnit(1,"Map Revealer",59,Force1);
			},
		}
	View = 59
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*13,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View)},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			CreateUnit(1,"Map Revealer",59,Force1);
			},
		}
	
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04해당 유닛은 \x07베럭\x04입니다. 유닛 생산, 업그레이드 등을 할 수 있습니다."
	View = 1
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*15,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04해당 유닛은 \x07컴셋 스테이션\x04입니다. 스캔, 기부, 등 다양한 기능을 사용할 수 있습니다."
	View = 2
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*21,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04해당 유닛은 배속 조정 기능입니다. 상위 플레이어가 클릭시 배속을 조정할 수 있습니다."
	View = 3
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*28,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04컴셋 스테이션에는 다양한 기능이 들어있는데, \x08체력 \x04시스템에 대해 설명드리겠습니다."
	View = 2
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*35,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04오른쪽 위 표기중인 \x07테란 인구수\x04는 현재 자신의 \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e \x04최대 체력을 의미합니다."
	View = 2
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*42,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	for i=0, 4 do
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*43,BegginerT);
		},
		actions = {
			SetMemory(0x5821D4+(i*4),SetTo,0);
		},
	}
	end
	for i=0, 4 do
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*44,BegginerT);
		},
		actions = {
			SetMemory(0x5821D4+(i*4),SetTo,3200);
		},
	}
	end
	for i=0, 4 do
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*45,BegginerT);
		},
		actions = {
			SetMemory(0x5821D4+(i*4),SetTo,0);
		},
	}
	end
	for i=0, 4 do
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*46,BegginerT);
		},
		actions = {
			SetMemory(0x5821D4+(i*4),SetTo,3200);
		},
	}
	end
	for i=0, 4 do
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*47,BegginerT);
		},
		actions = {
			SetMemory(0x5821D4+(i*4),SetTo,0);
		},
	}
	end
	for i=0, 4 do
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*48,BegginerT);
		},
		actions = {
			SetMemory(0x5821D4+(i*4),SetTo,3200);
		},
	}
	end
	
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04체력 업그레이드 방법 또한 특별한데, 체력이 필요할 땐 체력 환전 모드를, 미네랄이 필요할 땐 미네랄 환전 모드를 켜야 합니다"
	View = 2
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*49,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04이는 컴셋 스테이션에서 z키를 통해 변경할 수 있습니다. 상황에 맞게 이 기능을 잘 사용하셔야 합니다."
	View = 2
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*56,BegginerT);
		},
		actions = {
			RotatePlayer({CenterView(View),DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("sound\\Bullet\\PhoHit00.wav")},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	TText = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\x13\x04이상으로 설명을 마치도록 하겠습니다. 더 설명이 필요하신 분은 Insert 키를 눌러주시기 바랍니다."
	View = 2
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*67,BegginerT);
		},
		actions = {
			RotatePlayer({
				CenterView(View),
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX(TText,4),
				PlayWAVX("sound\\Bullet\\PhoHit00.wav")
			},HumanPlayers,FP);
			RemoveUnit("Factories",Force2);
			},
		}
	for i=0,4 do
	Trigger { -- 아비터 활성화
		players = {i},
		conditions = {
			Label(0);
			Switch("Switch 244",Set);
			CDeaths(P6,AtLeast,24*67,BegginerT);
		},
		actions = {
			SetMemoryB(0x57F27C+(228*i)+86,SetTo,1);
		},
	}
	end
	TText = "\n\n\n\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x0F！！！　ＢＯＮＵＳ　！！！\n\n\x13\x18Ｔｕｔｏｒｉａｌ \x04시작 보너스 - 시작시 10만 미네랄, 영웅마린 5기 추가 지급\n\n\x13\x0F！！！　ＢＯＮＵＳ　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	View = 2
	Trigger { -- 비기너 설명
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,24*74,BegginerT);
		},
		actions = {
			RotatePlayer({DisplayTextX(string.rep("\n", 20),4),DisplayTextX(TText,4),PlayWAVX("staredit\\wav\\E_Clear.ogg")},HumanPlayers,FP);
			SetCDeaths(P6,Add,1,Ready);
			SetResources(Force1,SetTo,100000,Ore);
			RemoveUnit(71,Force2);
			RemoveUnit("Factories",Force2);
			SetCDeaths(P6,SetTo,1,Difficulty);
			},
		}
	Trigger { -- 이지모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Difficulty);
			CDeaths(P6,AtLeast,100,IntroT);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",17);
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			SetCDeaths(P6,SetTo,1,Difficulty);
			SetCDeaths(P6,SetTo,2,DifID);
			SetCVar(FP,ClearRate[2],SetTo,280);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
	},
	}
	
	Trigger { -- 이지모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Difficulty);
			CDeaths(P6,AtLeast,100 + (24*15),IntroT);
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,1,Difficulty);
			SetSwitch("Switch 245",Set);
			SetCVar(FP,ClearRate[2],SetTo,280);
			SetCDeaths(P6,SetTo,2,DifID);
			RemoveUnit(190,Force2);
			RemoveUnit(12,AllPlayers);
			RemoveUnit(200,Force2);
	},
	}
	
	Trigger { -- 하드모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Difficulty);
			CDeaths(P6,AtLeast,100,IntroT);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",18);
			
			--Never();
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,2,Difficulty);
			SetCDeaths(P6,SetTo,3,DifID);
			SetCVar(FP,ClearRate[2],SetTo,70);
			SetSwitch("Switch 246",Set);
	},
	}
	Trigger { -- 미래모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Difficulty);
			CDeaths(P6,AtLeast,100,IntroT);
			Switch("Switch 202",Cleared);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",19);
			--Never();
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\sel_ln.ogg")},HumanPlayers,FP);
			SetSwitch("Switch 202",Set);
			MoveUnit(1,"Bengalaas (Jungle)",AllPlayers,"Anywhere",21);
	},
	}
	Trigger { -- 미래모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,Exactly,0,Difficulty);
			CDeaths(P6,AtLeast,100,IntroT);
			Switch("Switch 202",Set);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",19);
			--Never();
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\sel_ln2.ogg"),PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,3,Difficulty);
			SetCVar(FP,ClearRate[2],SetTo,70);
			SetSwitch("Switch 201",Set);
			SetSwitch("Switch 247",Set);
			SetCDeaths(P6,SetTo,4,DifID);
	},
	}
	
	Trigger { -- 정식모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,50 + (24*15),IntroT3);
			CDeaths(P6,AtMost,0,Ready);
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,1,Ready);
			SetMemory(0x58F4F0, SetTo, 4);
			SetCDeaths(P6,SetTo,1,GModeTP);
	},
	}
	Trigger { -- 정식모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,50,IntroT3);
			CDeaths(P6,AtMost,0,BYDDiff);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",17);
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,1,Ready);
			SetMemory(0x58F4F0, SetTo, 4);
			SetCDeaths(P6,SetTo,1,GModeTP);
	},
	}
	
	Trigger { -- EV MODE 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,50,IntroT3);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",195);
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,1,Ready);
			SetCDeaths(P6,SetTo,1,EVMode);
			SetCDeaths(P6,SetTo,3,GModeTP);
			SetMemory(0x58F4F0, SetTo, 4);
			SetMemory(0x515B88,SetTo,128);---------크기 0
			SetMemory(0x515B8C,SetTo,128);---------크기 1
			SetMemory(0x515B90,SetTo,128);---------크기 2
			SetMemory(0x515B94,SetTo,128);---------크기 3
			SetMemory(0x515B98,SetTo,128);---------크기 4
			SetMemory(0x515B9C,SetTo,128);---------크기 5
			SetMemory(0x515BA0,SetTo,128);---------크기 6
			SetMemory(0x515BA4,SetTo,128);---------크기 7
			SetMemory(0x515BA8,SetTo,128);---------크기 8
			SetMemory(0x515BC4,SetTo,20480/3);
			SetMemory(0x515BC8,SetTo,10240/3);
			SetMemory(0x515BCC,SetTo,5120/3);
			SetMemory(0x515BD0,SetTo,40960/3);
			SetMemoryX(0x6616F8, SetTo, 16777216*119,0xFF000000);
			SetMemoryX(0x6636D0, SetTo, 16777216*119,0xFF000000);
			SetMemory(0x656E7C, SetTo, 150);
			SetMemoryX(0x660434, SetTo, 65536,0xFFFF0000);
			SetMemoryX(0x65676C, SetTo, 256*3,0xFF00);
			SetMemoryX(0x656970, SetTo, 131072,0xFFFF0000);
			SetMemoryX(0x6571B0, SetTo, 655360,0xFFFF0000);
			SetMemoryX(0x657868, SetTo, 1310720,0xFFFF0000);
			SetMemoryX(0x656F9C, SetTo, 7500*65536,0xFFFF0000);
			SetMemoryX(0x657764, SetTo, 150*65536,0xFFFF0000);
			SetMemoryX(0x656EB0, SetTo, 150,0xFFFF);
			SetMemoryX(0x657678, SetTo, 11,0xFFFF);
			SetMemoryX(0x656EB0, SetTo, 150*65536,0xFFFF0000);
			SetMemoryX(0x657678, SetTo, 20*65536,0xFFFF0000);
			SetMemoryX(0x656F98, SetTo, (750)*65536,0xFFFF0000);
			SetMemoryX(0x657760, SetTo, (98)*65536,0xFFFF0000);
	
	},
	}
	
	Trigger { -- 클래식모드 선택
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,50,IntroT3);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",18);
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,1,GMode);
			SetCDeaths(P6,SetTo,1,Ready);
			SetCDeaths(P6,SetTo,2,GModeTP);
	},
	}
	
	Trigger { -- 퓨어모드 선택
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtMost,2,Difficulty); -- 미구현 선택방지. 구현 완료시 이것만 지우면 됨
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,50,IntroT3);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",19);
		},
		actions = {
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,2,GMode);
			SetCDeaths(P6,SetTo,1,Ready);
			SetCDeaths(P6,SetTo,4,GModeTP);
	},
	}
	
	Trigger { -- BYD 선택가능 테스트모드 ON일 경우에만
		players = {P6},
		conditions = {
			Label(0);
			--CDeaths(P6,AtLeast,1,LimitX); -- 
			CDeaths(P6,AtLeast,3,Difficulty); -- 
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,50,IntroT3);
			Bring(AllPlayers,Exactly,1,"Bengalaas (Jungle)",19);
		},
		actions = {
			RemoveUnit("Bengalaas (Jungle)",AllPlayers);
			SetCDeaths(P6,SetTo,2,GMode);
			SetCDeaths(P6,SetTo,1,Ready);
			SetCDeaths(P6,SetTo,4,GModeTP);
	},
	}
	
	
	
	Trigger { -- 모드선택 모두 완료시 인트로타이머2작동
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Set);
		},
		actions = {
			SetCDeaths(P6,Add,1,BegginerT);
			PreserveTrigger();
			},
		}
	Trigger { -- 모드선택 모두 완료시 모드선택유닛 제거, 배속조정
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,1,Ready);
		},
		actions = {
			RemoveUnit("Protoss Beacon",AllPlayers);
			RemoveUnit("Map Revealer",AllPlayers);
			},
		}
	Trigger { -- 난이도 선택 완료시 인트로타이머3작동
		players = {P6},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,1,Difficulty);
		},
		actions = {
			SetCDeaths(P6,Add,1,IntroT3);
			PreserveTrigger();
			},
		}
	
	Trigger { -- 준비완료, 이지모드 세팅
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,1,Difficulty);
			CDeaths(P6,AtLeast,1,Ready);
		},
		actions = {
			SetSwitch("Switch 245",Set);
			RemoveUnit(190,Force2);
			RemoveUnit(12,AllPlayers);
			RemoveUnit(82,AllPlayers);
			RemoveUnit(200,Force2);
			RemoveUnit("【 Divide 】",AllPlayers);
			RemoveUnit("【 Anomaly 】",AllPlayers);
			RemoveUnit("【 Demise 】",AllPlayers);
			RemoveUnit("【 Tenebris 】",AllPlayers);
			RemoveUnit("【 Daggoth 】",AllPlayers);
			RemoveUnitAt(All,"Buildings",187,Force2);
			RemoveUnitAt(All,"Buildings",188,Force2);
			RemoveUnitAt(All,"Buildings",189,Force2);
			RemoveUnitAt(All,"Buildings",190,Force2);
		}
	}
	
	Trigger { -- 준비완료, 하드모드 세팅
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,Difficulty);
			CDeaths(P6,AtLeast,1,Ready);
			NBYD
		},
		actions = {
			RemoveUnit(64,AllPlayers);
			},
		}
	
	
	CIf(P6,FTRBYD)
	Trigger { -- 준비완료, 루나 세팅
		players = {P6},
		actions = {
			SetMemoryX(0x656EBC, SetTo, 400,0xFFFF);
			SetMemory(0x662384, SetTo, 1024000000);
			SetMemoryX(0x656894, SetTo, 150,0xFFFF);
			SetMemoryX(0x6570D4, SetTo, 150,0xFFFF);
			SetMemoryX(0x65778C, SetTo, 150,0xFFFF);
	
			SetMemoryX(0x656EE4, SetTo, 100,0xFFFF);
			SetMemoryX(0x663DD8, SetTo, 65536*200,0xFF0000);
	
	
		}
	}
	
	Points = 2
	Radius = 64
	Angle = 90
	CreateUnitLineSafeGun(P6,{Always()},2,57,32,Radius,Angle,Points,0,P7,{1,13})
	CreateUnitLineSafeGun(P6,{Always()},2,58,32,Radius,Angle,Points,0,P7,{1,13})
	
	CIfEnd()
	for i = 0, 4 do
	Trigger { -- 클래식모드 선택시 기능제한
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,1,GMode);
			CDeaths(P6,AtLeast,1,Ready);
		},
		actions = {
			SetMemoryB(0x57F27C+(228*i)+2,SetTo,0);
			SetMemoryB(0x57F27C+(228*i)+71,SetTo,0);
			
			},
		}
	end
	Trigger { -- 클래식모드 설치
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,1,GMode);
			CDeaths(P6,AtLeast,1,Ready);
		},
		actions = {
			SetMemoryX(0x6559CC, SetTo, 15*65536,0xFFFF0000);
			
			},
		}
	

	
	Trigger { -- 퓨어모드 선택시
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,GMode);
			CDeaths(P6,AtLeast,1,Ready);
		},
		actions = {
			RemoveUnit(125,AllPlayers);
			SetMemoryX(0x6559CC, SetTo, 20*65536,0xFFFF0000);
			KillUnitAt(4,219,64,AllPlayers);
			SetMemoryW(0x656380+44,SetTo,150);
			PatchArr1;
			
			},
		}
	
	Trigger { -- 퓨어모드 선택시 2인이상 공격력조절
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,GMode);
			CDeaths(P6,AtLeast,1,Ready);
			CVar(P6,SetPlayers[2],AtLeast,2);
		},
		actions = {
			
			SetMemoryX(0x656EB0, SetTo, 200,0xFFFF);
			SetMemoryX(0x657678, SetTo, 14,0xFFFF);
			SetMemoryX(0x656EB0, SetTo, 1000*65536,0xFFFF0000);
			SetMemoryX(0x657678, SetTo, 30*65536,0xFFFF0000);
			SetMemoryX(0x656F98, SetTo, (3000)*65536,0xFFFF0000);
			SetMemoryX(0x657760, SetTo, (130)*65536,0xFFFF0000);
			},
		}
	
	
	Trigger { -- 퓨어모드 선택시 1인 공격력조절
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,GMode);
			CDeaths(P6,AtLeast,1,Ready);
			CVar(P6,SetPlayers[2],Exactly,1);
		},
		actions = {
			
			SetMemoryX(0x656EB0, SetTo, 300,0xFFFF);
			SetMemoryX(0x657678, SetTo, 21,0xFFFF);
			SetMemoryX(0x656EB0, SetTo, 1500*65536,0xFFFF0000);
			SetMemoryX(0x657678, SetTo, 45*65536,0xFFFF0000);
			SetMemoryX(0x656F98, SetTo, (4500)*65536,0xFFFF0000);
			SetMemoryX(0x657760, SetTo, (65*3)*65536,0xFFFF0000);
			},
		}
	
	
		
			
			
	Trigger { -- 퓨어모드+하드이하 선택시
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,GMode);
			CDeaths(P6,AtLeast,1,Ready);
			CDeaths(P6,AtMost,2,Difficulty);
		},
		actions = {
			RotatePlayer({PlayWAVX("staredit\\wav\\start.ogg")},HumanPlayers,FP);
			
			},
		}
			BYDText = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x05Ｗｅｌｃｏｍｅ　ｔｏ　Ｌｏｓｔ　Ｗｏｒｌｄ　：　Ｂｅｙｏｎｄ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13Ｗｅｌｃｏｍｅ　ｔｏ　Ｌｏｓｔ　Ｗｏｒｌｄ　：　Ｂｅｙｏｎｄ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x07Ｗｅｌｃｏｍｅ　\x04ｔｏ　\x10Ｌ\x04ｏｓｔ　\x11Ｗｏｒｌｄ　\x04：　\x06Ｂｅｙｏｎｄ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13Ｗｅｌｃｏｍｅ　ｔｏ　Ｌｏｓｔ　Ｗｏｒｌｄ　：　Ｂｅｙｏｎｄ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x05Ｗｅｌｃｏｍｅ　ｔｏ　Ｌｏｓｔ　Ｗｏｒｌｄ　：　Ｂｅｙｏｎｄ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	
		
	Trigger { -- 퓨어모드+퓨쳐 선택시
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,GMode);
			CDeaths(P6,AtLeast,1,Ready);
			CDeaths(P6,AtLeast,3,Difficulty);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(BYDText,4),
				PlayWAVX("staredit\\wav\\Beyond_Start.ogg"),
				PlayWAVX("staredit\\wav\\Beyond_Start.ogg"),
				PlayWAVX("staredit\\wav\\Beyond_Start.ogg")
			},HumanPlayers,FP);
			SetCDeaths(FP,SetTo,1,BYDDiff);
			SetCDeaths(FP,SetTo,0,Ready); -- 추가 텍스트 출력을 위해 강제로 Ready변수를 Off함
			SetCVar(P6,MaxHP[2],SetTo,130000);
			SetCVar(P6,MaxHPP[2],SetTo,2600);
			SetCDeaths(P6,SetTo,5,DifID);
			SetSwitch("Switch 204",Set);
			SetCVar(FP,ClearRate[2],SetTo,0);
			},
		}
	BYDT = CreateCCode(ExDeaths1)
	Trigger { -- BYDDiff 1이상시 BYDT작동 
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,1,BYDDiff);
		},
		actions = {
			SetCDeaths(P6,Add,1,BYDT);
			PreserveTrigger();
			},
		}
	BYDText = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\n\x13\x08？？？\n\x13\x02이 길\x04은 \x07인류\x04에 대한 \x06최악의 기억\x04으로 \x08불타\x04버렸고,\n\x13\x02이 길\x04의 \x03끝\x04에는 \x11참혹한 전투의 결말\x04과 이후 \x10남겨진 것들\x04이 \x02이 길\x04을 채울 것이다.\n \n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
	
	Trigger { -- BYDDiff 1이상시 BYDT작동 
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,130,BYDT);
		},
		actions = {
			RotatePlayer({
				DisplayTextX(BYDText,4),
				PlayWAVX("staredit\\wav\\BYD_Text.ogg"),
				PlayWAVX("staredit\\wav\\BYD_Text.ogg"),
				PlayWAVX("staredit\\wav\\BYD_Text.ogg")
			},HumanPlayers,FP);
			SetCDeaths(P6,Add,1,Ready);
			},
		}
	
	
	Trigger { -- 모드선택 모두 완료시 인트로타이머2작동
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,1,Ready);
		},
		actions = {
			SetCDeaths(P6,Add,1,IntroT2);
			PreserveTrigger();
			},
		}
	
	
			
	Trigger { -- 3
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,100,IntroT2);
		},
		actions = {
			SetMemory(0x5124F0,SetTo,0x1D);
			CenterView("Anywhere");
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\n",4);
			DisplayText("\n\x13\x04３\n\n",4);
			DisplayText("\n",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			PlayWAV("sound\\glue\\countdown.wav");
			SetSwitch("Switch 215",Set);
		},
	}
	Trigger { -- 3 관전자
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,100,IntroT2);
		},
		actions = {
			RotatePlayer({
				CenterView("Anywhere"),
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\n",4),
				DisplayTextX("\n\x13\x04３\n\n",4),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("sound\\glue\\countdown.wav")
			},ObPlayers,FP);
		},
	}
	Trigger { -- 2
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,130,IntroT2);
		},
		actions = {
			CenterView("Anywhere");
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\n",4);
			DisplayText("\n\x13\x04２\n\n",4);
			DisplayText("\n",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			PlayWAV("sound\\glue\\countdown.wav");
		},
	}
	Trigger { -- 2 관전자
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,130,IntroT2);
		},
		actions = {
			RotatePlayer({
				CenterView("Anywhere"),
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\n",4),
				DisplayTextX("\n\x13\x04２\n\n",4),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("sound\\glue\\countdown.wav")
			},ObPlayers,FP);
		},
	}
	Trigger { -- 1
		players = {Force1},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,160,IntroT2);
		},
		actions = {
			CenterView("Anywhere");
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\n",4);
			DisplayText("\n\x13\x04１\n\n",4);
			DisplayText("\n",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			PlayWAV("sound\\glue\\countdown.wav");
		},
	}
	Trigger { -- 1 관전자
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,160,IntroT2);
		},
		actions = {
			RotatePlayer({
				CenterView("Anywhere"),
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\n",4),
				DisplayTextX("\n\x13\x04１\n\n",4),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("sound\\glue\\countdown.wav")
			},ObPlayers,FP);
		},
	}
	for i=0, 4 do
	Trigger { -- 0
		players = {i},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,190,IntroT2);
		},
		actions = {
			CenterView("Anywhere");
			DisplayText(string.rep("\n", 20),4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			DisplayText("\n",4);
			DisplayText("\n\x13\x04ＳＴＡＲＴ\n\n",4);
			DisplayText("\n",4);
			DisplayText("\x13\x04"..string.rep("―", 56),4);
			PlayWAV("sound\\Bullet\\pshield.wav");
			CreateUnit(2,32,204+i,i);
			CreateUnit(1,"Jim Raynor (Marine)",204+i,i);
			SetResources(i,Add,70000,Ore);
			SetDeaths(i,Add,60000,432);
			SetAllianceStatus(Force2,Enemy);
			RunAIScript("Turn ON Shared Vision for Player 6");
			SetCDeaths(P6,SetTo,1,IntroBGM);
		},
	}
	
	Trigger { -- 0
		players = {i},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,GMode);
			CDeaths(P6,AtLeast,190,IntroT2);
		},
		actions = {
			SetDeaths(i,SetTo,1,432);
		},
	}
	end
	
	Trigger { -- 0
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,GMode);
			CDeaths(P6,AtLeast,190,IntroT2);
		},
		actions = {
			SetMemory(0x5124F0,SetTo,0x19);
		},
	}
	Trigger { -- 0 관전자
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,190,IntroT2);
		},
		actions = {
			RotatePlayer({
				CenterView("Anywhere"),
				DisplayTextX(string.rep("\n", 20),4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				DisplayTextX("\n",4),
				DisplayTextX("\n\x13\x04ＳＴＡＲＴ\n\n",4),
				DisplayTextX("\n",4),
				DisplayTextX("\x13\x04"..string.rep("―", 56),4),
				PlayWAVX("sound\\Bullet\\pshield.wav")
			},ObPlayers,FP);
		},
	}
	Trigger { -- 0
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,192,IntroT2);
		},
		actions = {
			CreateUnit(1,"Map Revealer",5,P6);
			SetMemory(0x58F458,Add,1);
			SetCountdownTimer(SetTo,138*60);
			SetMemory(0x58F45C,SetTo,0);
			SetMemory(0x58F460,SetTo,600*1000);
			SetSwitch("Switch 203",Set);
			
		},
	}
	Trigger { -- 
		players = {Force1},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,1,IntroT2);
			CDeaths(P6,AtMost,99,IntroT2);
		},
		actions = {
			CenterView(21);
			PreserveTrigger();
		},
	}
	Trigger { -- 
		players = {Force1},
		conditions = {
			Label(0);
			Switch("Switch 244",Cleared);
			CDeaths(P6,AtLeast,100,IntroT2);
			CDeaths(P6,AtMost,190,IntroT2);
		},
		actions = {
			CenterView("Anywhere");
			PreserveTrigger();
		},
	}
	DoActionsPX(SetCDeaths(P6,Add,1,IntroT),P6)
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			--Switch("Switch 203",Set);
		},
		actions = {
			SetCDeaths(P6,SetTo,Limit,LimitX);
		},
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,1,LimitX);
			
		},
		actions = {
			SetSwitch("Switch 253",Set);
		},
	}
	
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,1,LimitX);
			Deaths(P1,AtLeast,1,199);
			
		},
		actions = {
			SetCDeaths(P6,SetTo,1,TestMode);
			SetSwitch("Switch 254",Set);
		},
	}
	
	for i = 0, 4 do
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			isname(i,"GALAXY_BURST");
			CDeaths(P6,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(P6,SetTo,1,LimitC);
			
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			isname(i,"_Mininii");
			CDeaths(P6,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(P6,SetTo,1,LimitC);
			
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			isname(i,"UnusedTypeGB");
			CDeaths(P6,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(P6,SetTo,1,LimitC);
			
		}
	}
	Trigger {
		players = {P6},
		conditions = {
			Label(0);
			isname(i,"UnusedTypeDemon");
			CDeaths(P6,AtLeast,1,LimitX);
		},
		actions = {
			SetCDeaths(P6,SetTo,1,LimitC);
			
		}
	}
	
	
	
	end
	Trigger {
		players = {AllPlayers},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,1,LimitX);
			CDeaths(P6,Exactly,0,LimitC);
			
		},
		actions = {
			DisplayText("\x13\x1B테스트 전용 맵입니다. 정식버젼으로 시작해주세요.",4);
			Defeat();
		}
	}
	for i=0, 4 do
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
	players = {P6},
		actions = {
			SetMemory(0x582234+(i*4),SetTo,3200);
			SetMemory(0x5821D4+(i*4),SetTo,3200);
		},
	}
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
	players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,Exactly,1,Difficulty);
		},
		actions = {
			SetMemory(0x582144+(i*4),SetTo,10);
		},
	}
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
	players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,2,Difficulty);
		},
		actions = {
			SetMemory(0x582144+(i*4),SetTo,6);
		},
	}
	
	Trigger { -- 체력표시하는곳, 캔낫기회 표시하는곳
	players = {P6},
		conditions = {
			Label(0);
			CDeaths(P6,AtLeast,3,Difficulty);
			CDeaths(P6,AtLeast,2,GMode);
		},
		actions = {
			SetMemory(0x582144+(i*4),SetTo,4);
		},
	}
	
	end
CIfEnd() -- 인트로 끝


CIf(AllPlayers,Switch("Switch 203",Set)) -- 203 스위치가 켜져있을 경우

CallTable = {61,62,63,65}
Trigger { -- 게임 승리 트리거 이지
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 203",Set);
		CDeaths(P6,Exactly,1,Difficulty);
		Deaths(P6,AtLeast,1,64);
	},
	actions = {
		RotatePlayer({
		DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\n\n\x13\x18Ｆｉｎａｌ　Ｂｏｓｓ \x04－\x10【 \x11Ｐ\x04ａｓｔ \x10】 \x04를 처치하셨습니다.\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x08１０．０\x04％ 〓\n\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
		PlayWAVX("staredit\\wav\\Clear1.ogg"),
		PlayWAVX("staredit\\wav\\Clear1.ogg"),
		PlayWAVX("staredit\\wav\\Clear1.ogg"),
		PlayWAVX("staredit\\wav\\Clear1.ogg"),
		PlayWAVX("staredit\\wav\\Clear1.ogg")
		},MapPlayers,FP);
		RotatePlayer({
		DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\n\n\x13\x18Ｆｉｎａｌ　Ｂｏｓｓ \x04－\x10【 \x11Ｐ\x04ａｓｔ \x10】 \x04를 처치하셨습니다.\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x08１０．０\x04％ 〓\n\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
		PlayWAVX("staredit\\wav\\Clear1.ogg"),
		PlayWAVX("staredit\\wav\\Clear1.ogg"),
		},ObPlayers,FP);
		SetCDeaths(P6,SetTo,1,Win);
		SetSwitch("Switch 130",Set);
		SetCVar(P6,B1_H[2],SetTo,0);
		SetCVar(P6,ClearRate[2],Add,100); -- ClearRate + 10.0%
		},
	}
Trigger { -- 게임 승리 트리거 하드이상
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,2,Difficulty);
		Deaths(P6,AtLeast,1,12);
		
	},
	actions = {
		RotatePlayer({
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\n\n\x13\x18Ｆｉｎａｌ　Ｂｏｓｓ \x04－\x08【 \x11Ｆ\x04ａｔｅ \x08】\x04를 처치하셨습니다.\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x08１０．０\x04％ 〓\n\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
			PlayWAVX("staredit\\wav\\Clear2.ogg"),
			PlayWAVX("staredit\\wav\\Clear2.ogg"),
			PlayWAVX("staredit\\wav\\Clear2.ogg"),
			PlayWAVX("staredit\\wav\\Clear2.ogg"),
			PlayWAVX("staredit\\wav\\Clear2.ogg")
		},MapPlayers,FP);
		RotatePlayer({
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\n\n\x13\x18Ｆｉｎａｌ　Ｂｏｓｓ \x04－\x08【 \x11Ｆ\x04ａｔｅ \x08】\x04를 처치하셨습니다.\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x08１０．０\x04％ 〓\n\n\x13\x04！！！　\x10ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
			PlayWAVX("staredit\\wav\\Clear2.ogg"),
			PlayWAVX("staredit\\wav\\Clear2.ogg"),
		},ObPlayers,FP);
		--SetCDeaths(P6,SetTo,1,Win);
		SetSwitch("Switch 130",Set);
	SetMemory(0x58F550,SetTo,0);
		SetCVar(P6,B6_H[2],SetTo,0);
		SetCVar(P6,ClearRate[2],Add,100); -- ClearRate + 10.0%
		},
	}
Trigger { -- 실시간 30초 경과 콜 FTR
	players = {P6},
	conditions = {
		Switch("Switch 203",Set);
		FTRBYD;
		Memory(0x58F45C,AtLeast,30*1000);
	},
	actions = {
		CreateUnit(1,84,61,P6);
		CreateUnit(1,84,62,P6);
		CreateUnit(1,84,63,P6);
		CreateUnit(1,84,65,P6);
		RunAIScriptAt("Recall Here",61);
		RunAIScriptAt("Recall Here",62);
		RunAIScriptAt("Recall Here",63);
		RunAIScriptAt("Recall Here",65);
		CreateUnitWithProperties(40,53,61,P7,{burrowed = true});
		CreateUnitWithProperties(40,53,62,P7,{burrowed = true});
		CreateUnitWithProperties(40,53,63,P7,{burrowed = true});
		CreateUnitWithProperties(40,53,65,P7,{burrowed = true});
		KillUnit(84,P6);
		Order(53,P7,61,Attack,5);
		Order(53,P7,62,Attack,5);
		Order(53,P7,63,Attack,5);
		Order(53,P7,65,Attack,5);
	},
}
Trigger { -- 실시간 60초 경과 콜 HD
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 203",Set);
		CDeaths(P6,AtLeast,2,Difficulty);
		Memory(0x58F45C,AtLeast,60*1000);
	},
	actions = {
		CreateUnit(1,84,61,P6);
		CreateUnit(1,84,62,P6);
		CreateUnit(1,84,63,P6);
		CreateUnit(1,84,65,P6);
		RunAIScriptAt("Recall Here",61);
		RunAIScriptAt("Recall Here",62);
		RunAIScriptAt("Recall Here",63);
		RunAIScriptAt("Recall Here",65);
		CreateUnitWithProperties(20,53,61,P7,{burrowed = true});
		CreateUnitWithProperties(20,53,62,P7,{burrowed = true});
		CreateUnitWithProperties(20,53,63,P7,{burrowed = true});
		CreateUnitWithProperties(20,53,65,P7,{burrowed = true});
		KillUnit(84,P6);
		Order(53,P7,61,Attack,5);
		Order(53,P7,62,Attack,5);
		Order(53,P7,63,Attack,5);
		Order(53,P7,65,Attack,5);
	},
}



Trigger { -- 실시간 30초간 지속콜
	players = {P6},
	conditions = {
		Label(0);
		NBYD;
		CDeaths(P6,AtLeast,2,Difficulty);
		Switch("Switch 203",Set);
		CDeaths(FP,AtLeast,30*1000,WaveT);
		CDeaths(FP,AtMost,15,WaveC);
	},
	actions = {
		SetSwitch("Switch 5",Set);
		SetResources(Force1,Add,500,Ore);
		SetCDeaths(FP,Subtract,30*1000,WaveT);
		SetCDeaths(FP,Add,1,WaveC);
		PreserveTrigger();
	},
}
Trigger { -- 실시간 15초마다 지속콜 비욘드 20분까지
	players = {P6},
	conditions = {
		Label(0);
		BYD;

		CDeaths(P6,AtMost,0,BYDBossStart);
		CDeaths(P6,AtLeast,2,Difficulty);
		Switch("Switch 203",Set);
		CDeaths(FP,AtLeast,15*1000,WaveT);
		CDeaths(FP,AtMost,71,WaveC);
	},
	actions = {
		SetSwitch("Switch 5",Set);
		SetCDeaths(FP,Subtract,15*1000,WaveT);
		SetCDeaths(FP,Add,1,WaveC);
		PreserveTrigger();
	},
}
Trigger { -- 실시간 5분 경과 콜
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 203",Set);
		Memory(0x58F45C,AtLeast,300*1000);
	},
	actions = {
		CreateUnit(1,84,61,P6);
		CreateUnit(1,84,62,P6);
		CreateUnit(1,84,63,P6);
		CreateUnit(1,84,65,P6);
		RunAIScriptAt("Recall Here",61);
		RunAIScriptAt("Recall Here",62);
		RunAIScriptAt("Recall Here",63);
		RunAIScriptAt("Recall Here",65);
		CreateUnit(20,51,61,P7);
		CreateUnit(20,51,62,P7);
		CreateUnit(20,51,63,P7);
		CreateUnit(20,51,65,P7);
		KillUnit(84,P6);
		Order(51,P7,61,Attack,5);
		Order(51,P7,62,Attack,5);
		Order(51,P7,63,Attack,5);
		Order(51,P7,64,Attack,5);
	},
}
Trigger { -- 실시간 5분 경과 콜 BYD
	players = {P6},
	conditions = {
		Label(0);
		BYD;
		Switch("Switch 203",Set);
		Memory(0x58F45C,AtLeast,300*1000);
	},
	actions = {
		CreateUnit(7,77,61,P8);
		CreateUnit(7,77,62,P8);
		CreateUnit(7,77,63,P8);
		CreateUnit(7,77,65,P8);
		KillUnit(84,P6);
		Order(77,P8,61,Attack,5);
		Order(77,P8,62,Attack,5);
		Order(77,P8,63,Attack,5);
		Order(77,P8,64,Attack,5);
	},
}
Trigger { -- 타이머 2시간 10분 남음 콜
	players = {P6},
	conditions = {
		Switch("Switch 203",Set);
		CountdownTimer(Exactly,7200+600);
	},
	actions = {
		CreateUnit(1,84,61,P6);
		CreateUnit(1,84,62,P6);
		CreateUnit(1,84,63,P6);
		CreateUnit(1,84,65,P6);
		CreateUnit(1,77,61,P7);
		CreateUnit(1,77,62,P7);
		CreateUnit(1,77,63,P7);
		CreateUnit(1,77,65,P7);
		CreateUnit(4,77,61,P8);
		CreateUnit(4,77,62,P8);
		CreateUnit(4,77,63,P8);
		CreateUnit(4,77,65,P8);
		RunAIScriptAt("Recall Here",61);
		RunAIScriptAt("Recall Here",62);
		RunAIScriptAt("Recall Here",63);
		RunAIScriptAt("Recall Here",65);
		KillUnit(84,P6);
		Order(77,P7,61,Attack,5);
		Order(77,P7,62,Attack,5);
		Order(77,P7,63,Attack,5);
		Order(77,P7,65,Attack,5);
		Order(77,P8,61,Attack,5);
		Order(77,P8,62,Attack,5);
		Order(77,P8,63,Attack,5);
		Order(77,P8,65,Attack,5);
	},
}
Trigger { -- 타이머 2시간 남음 콜
	players = {P6},
	conditions = {
		Switch("Switch 203",Set);
		CountdownTimer(Exactly,7200);
	},
	actions = {
		CreateUnit(1,84,61,P6);
		CreateUnit(1,84,62,P6);
		CreateUnit(1,84,63,P6);
		CreateUnit(1,84,65,P6);
		CreateUnit(1,25,61,P7);
		CreateUnit(1,25,62,P7);
		CreateUnit(1,25,63,P7);
		CreateUnit(1,25,65,P7);
		CreateUnit(6,25,61,P8);
		CreateUnit(6,25,62,P8);
		CreateUnit(6,25,63,P8);
		CreateUnit(6,25,65,P8);
		RunAIScriptAt("Recall Here",61);
		RunAIScriptAt("Recall Here",62);
		RunAIScriptAt("Recall Here",63);
		RunAIScriptAt("Recall Here",65);
		KillUnit(84,P6);
	},
}
Trigger { -- 타이머 1시간30분 남음 콜
	players = {P6},
	conditions = {
		Switch("Switch 203",Set);
		CountdownTimer(Exactly,5400);
	},
	actions = {
		CreateUnit(1,84,61,P6);
		CreateUnit(1,84,62,P6);
		CreateUnit(1,84,63,P6);
		CreateUnit(1,84,65,P6);
		CreateUnit(1,78,61,P7);
		CreateUnit(1,78,62,P7);
		CreateUnit(1,78,63,P7);
		CreateUnit(1,78,65,P7);
		CreateUnit(15,78,61,P8);
		CreateUnit(15,78,62,P8);
		CreateUnit(15,78,63,P8);
		CreateUnit(15,78,65,P8);
		Order(78,P7,61,Attack,5);
		Order(78,P7,62,Attack,5);
		Order(78,P7,63,Attack,5);
		Order(78,P7,65,Attack,5);
		Order(78,P8,61,Attack,5);
		Order(78,P8,62,Attack,5);
		Order(78,P8,63,Attack,5);
		Order(78,P8,65,Attack,5);
		RunAIScriptAt("Recall Here",61);
		RunAIScriptAt("Recall Here",62);
		RunAIScriptAt("Recall Here",63);
		RunAIScriptAt("Recall Here",65);
		KillUnit(84,P6);
	},
}



CIfOnce(P6,CountdownTimer(Exactly,6000))
Points = 6
SizeofPolygon = 3
Radius = 32*2
Angle = 0
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,88})
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()

CIfOnce(P6,CountdownTimer(Exactly,4800))
Points = 6
Radius = 32*3
Angle = 45
CreateUnitLineSafeGun(P6,{Always()},11,4,32,Radius,Angle,Points,0,P8,{1,28})
CreateUnitLineSafeGun(P6,{Always()},11,4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()
CIfOnce(P6,CountdownTimer(Exactly,4200))
Points = 8
SizeofPolygon = 3
Radius = 48
Angle = 0
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,76})
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()
CIfOnce(P6,CountdownTimer(Exactly,3600))
Points = 5
Radius = 32*2
Angle = 30
CreateUnitLineSafeGun(P6,{Always()},10,4,32,Radius,Angle,Points,0,P8,{1,63})
CreateUnitLineSafeGun(P6,{Always()},10,4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()
CIfOnce(P6,CountdownTimer(Exactly,2400))
Points = 6
SizeofPolygon = 3
Radius = 64
Angle = 0
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,8})
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()
CIfOnce(P6,CountdownTimer(Exactly,1800))
Points = 8
SizeofPolygon = 2
Radius = 32*2
Angle = 0
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,3})
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()
CIfOnce(P6,CountdownTimer(Exactly,1200))
Points = 3
SizeofPolygon = 4
Radius = 64
Angle = 90
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,52})
CreateUnitPolygonSafe2Gun(P6,{Always()},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()
CIfOnce(P6,CountdownTimer(Exactly,600))
Points = 4
Radius = 256
Angle = 0
CreateUnitLineSafeGun(P6,{Always()},3,4,32,Radius,Angle,Points,0,P8,{1,102})
CreateUnitLineSafeGun(P6,{Always()},3,4,32,Radius,Angle,Points,0,P8,{1,84})
CIfEnd()
CIfOnce(P6,CDeaths(P6,AtLeast,1,TimerisDEAD))


Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,2,GMode)
},
	actions = {

		SetMemoryX(0x656EB0, SetTo, 100,0xFFFF);
		SetMemoryX(0x657678, SetTo, 7,0xFFFF);
		SetMemoryX(0x656EB0, SetTo, 500*65536,0xFFFF0000);
		SetMemoryX(0x657678, SetTo, 15*65536,0xFFFF0000);
		SetMemoryX(0x656F98, SetTo, (1500)*65536,0xFFFF0000);
		SetMemoryX(0x657760, SetTo, (65)*65536,0xFFFF0000);
		}
}

Points = 3
SizeofPolygon = 1
Radius = 32*6
Angle = 0
CreateUnitPolygonSafe2Gun(P6,{FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P7,{1,64})
CreateUnitPolygonSafe2Gun(P6,{FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P7,{1,84})
Points = 8
SizeofPolygon = 1
Radius = 2000
Angle = 0
CreateUnitPolygonSafe2GunMove(P6,{BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,4,Attack,{1,64,1,84})
Points = 6
Radius = 64
Angle = 90
CreateUnitLineSafeGun(P6,{HD},2,65,32,Radius,Angle,Points,0,P8,{1,68,1,84})
CreateUnitLineSafeGun(P6,{HD},2,66,32,Radius,Angle,Points,0,P8,{1,68,1,84})
CreateUnitLineSafeGun(P6,{HD},2,67,32,Radius,Angle,Points,0,P8,{1,68,1,84})
CreateUnitLineSafeGun(P6,{HD},2,68,32,Radius,Angle,Points,0,P8,{1,68,1,84})
Trigger {
	players = {P6},
	conditions = {
		HD;
	},
	actions = {
		Order(68,P8,66,Attack,5);
		Order(68,P8,67,Attack,5);
		Order(68,P8,68,Attack,5);
		Order(68,P8,69,Attack,5);
	}
}

Points = 6
SizeofPolygon = 1
Radius = 32*6
Angle = 0
CreateUnitPolygonSafe2Gun(P6,{HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,32,Radius,Angle,Points,0,P8,{1,23,1,84})
CIfEnd()
CIf(P6,FTR) -- FTR옵션 켜져있을 경우
for j=0, 12 do
for i=0, 1 do -- 0 ~ 3시간동안 15분간격으로 광산콜
Trigger {
	players = {P6},
	conditions = {
		
		Memory(0x58F45C,AtLeast,60*1000*10);
		CountdownTimer(Exactly,(15*60)*j);
	},
	actions = {
		CreateUnit(1,84,192+i,P6);
		CreateUnit(25,69,192+i,P8);
		CreateUnit(25,11,192+i,P7);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,6);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,5);
	}
}
end
end
CIfEnd()
CIf(P6,BYD) -- BYD

for j=0, 12 do
Trigger {
	players = {P6},
	conditions = {
		
		Memory(0x58F45C,AtLeast,60*1000*10);
		CountdownTimer(Exactly,(15*60)*j);
	},
	actions = {
		SetSwitch("Switch 255",Set);
	}
}
end
CIf(FP,Switch("Switch 255",Set))
for i=0, 1 do -- 0 ~ 3시간동안 15분간격으로 광산콜
CDoActions(FP,{
CreateUnit(1,84,192+i,P6),
TCreateUnit(_Div(Time1,_Mov(60000)),69,192+i,P8),
TCreateUnit(_Div(Time1,_Mov(60000)),11,192+i,P7),
SetMemory(0x6509B0,SetTo,7);
RunAIScriptAt(JYD,192+i);
SetMemory(0x6509B0,SetTo,6);
RunAIScriptAt(JYD,192+i);
SetMemory(0x6509B0,SetTo,5);})
end
DoActions(FP,SetSwitch("Switch 255",Clear))
CIfEnd()
CIfEnd()
Trigger { -- FTRBYD 고추 무적
	players = {P6},
	conditions = {
		FTRBYD;
	},
	actions = {
		SetInvincibility(Enable,150,Force2,"Anywhere");
		},
	}
Trigger { -- 실시간 10분마다 웨이브
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 4",Cleared);
		Memory(0x58F460,AtMost,0);
	},
	actions = {
		CreateUnit(1,84,61,P6);
		CreateUnit(1,84,62,P6);
		CreateUnit(1,84,63,P6);
		CreateUnit(1,84,65,P6);
		RunAIScriptAt("Recall Here",61);
		RunAIScriptAt("Recall Here",62);
		RunAIScriptAt("Recall Here",63);
		RunAIScriptAt("Recall Here",65);
		CreateUnitWithProperties(20,53,61,P7,{burrowed = true});
		CreateUnitWithProperties(20,53,62,P7,{burrowed = true});
		CreateUnitWithProperties(20,53,63,P7,{burrowed = true});
		CreateUnitWithProperties(20,53,65,P7,{burrowed = true});
		KillUnit(84,P6);
		Order(53,P7,61,Attack,5);
		Order(53,P7,62,Attack,5);
		Order(53,P7,63,Attack,5);
		Order(53,P7,65,Attack,5);
		SetMemory(0x58F460,SetTo,1*1000);
		SetSwitch("Switch 4",Set);
		SetCDeaths(FP,Add,15*24,CanCT);
		PreserveTrigger();  
	},
}
Trigger { -- 실시간 10분마다 웨이브
	players = {P6},
	conditions = {
		
		Switch("Switch 4",Set);
		Memory(0x58F460,AtMost,0);
	},
	actions = {
		SetMemory(0x58F460,SetTo,599*1000);
		SetSwitch("Switch 2",Set);
		SetSwitch("Switch 4",Clear);
		PreserveTrigger();
	},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,18,ArbT);
		CDeaths(P6,AtLeast,6,ArbT);
	},
	actions = {
		RunAIScriptAt("Recall Here",204);
		RunAIScriptAt("Recall Here",205);
		RunAIScriptAt("Recall Here",206);
		RunAIScriptAt("Recall Here",207);
		RunAIScriptAt("Recall Here",208);
		}
}

Trigger { -- 이펙트용 아비터 소환 반복
players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,0,Win);
		CVar(P6,HDEnd[2],AtMost,0);
		CDeaths(P6,AtMost,0,ArbT);
	},
	actions = {
		RemoveUnit(71,P6);
		SetMemoryX(0x6C9CC0, SetTo, 65536,0xFFFF0000);
		SetMemory(0x6C9F8C, SetTo, 1);
		CreateUnit(9,71,21,P6);
		SetInvincibility(Enable,71,P6,21);
		SetMemoryX(0x6C9CC0, SetTo, 65536*33,0xFFFF0000);
		SetMemory(0x6C9F8C, SetTo, 1280);
		SetCDeaths(P6,SetTo,24,ArbT);

		MoveUnit(All,87,P12,64,66);
		MoveUnit(All,74,P12,64,67);
		MoveUnit(All,2,P12,64,69);

		PreserveTrigger();
	},
}
Trigger { -- 이펙트용 아비터 마나제한
players = {P6},
	actions = {
		ModifyUnitEnergy(All,71,P6,21,0);
		SetInvincibility(Enable,71,P6,21);
		PreserveTrigger();
	},
}




CIf(FP,NBYD)
Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,0,EVMode);
		CDeaths(FP,Exactly,0,GMode);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04테란 인구수는 \x03현재 \x1B자신의 \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e \x06체력\x04을 의미합니다. \x16(1/100비율 표시)\n\x13\x06최대 체력\x04은 \x07최대 인구수 \x04이며 \x06체력 증가량\x04은 \x1F미네랄 환전량\x04의 1/10 에 비례합니다.\n\x13\x04컴셋 스테이션에서 \x1D환전 \x19모드 변경\x04을 사용하여 \x06체력\x04업그레이드를 직접 하셔야 합니다.\n\x13\x04레어, 하이브를 파괴할 시 \x11전투중인 유닛\x04이 2기 이하일 경우 \x10페널티\x04가 적용됩니다.\n\x13\x07조합소\x04와 \x1F환전소\x04는 는 양쪽에 있는 감옥, 풍차모양 구조물입니다.\n\x13\x07조합법 \x04: Marine + \x1F15000 Ｏｒｅ \x04= \x1BH \x04Marine + \x1F25000 Ｏｒｅ \x04= \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\n\x13\x07\x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\x04 * 2 + SCV * 5 = \x06【 \x08Ｌ\x11ｕ\x03ｍ\x18ｉ\x0EＡ \x10】\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4);
		PreserveTrigger();
		},
	}
Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,EVMode);
		CDeaths(FP,Exactly,0,GMode);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04테란 인구수는 \x03현재 \x1B자신의 \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e \x06체력\x04을 의미합니다. \x16(1/100비율 표시)\n\x13\x06최대 체력\x04은 \x07최대 인구수 \x04이며 \x06체력 증가량\x04은 \x1F미네랄 환전량\x04의 1/10 에 비례합니다.\n\x13\x04컴셋 스테이션에서 \x1D환전 \x19모드 변경\x04을 사용하여 \x06체력\x04업그레이드를 직접 하셔야 합니다.\n\x13\x04레어, 하이브를 파괴할 시 \x11전투중인 유닛\x04이 2기 이하일 경우 \x10페널티\x04가 적용됩니다.\n\x13\x07조합소\x04와 \x1F환전소\x04는 는 양쪽에 있는 감옥, 풍차모양 구조물입니다.\n\x13\x07조합법 \x04: Marine + \x1F15000 Ｏｒｅ \x04= \x1BH \x04Marine + \x1F75000 Ｏｒｅ \x04= \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\n\x13\x07\x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\x04 * 2 + SCV * 5 = \x06【 \x08Ｌ\x11ｕ\x03ｍ\x18ｉ\x0EＡ \x10】\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4);
		PreserveTrigger();
		},
	}
Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,GMode);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\n\n\x13\x07조합법 \x04: Marine + \x1F15000 Ｏｒｅ \x04= \x1BH \x04Marine + \x1F25000 Ｏｒｅ \x04= \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\n\x13\x07\x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\x04 * 2 + SCV * 5 = \x06【 \x08Ｌ\x11ｕ\x03ｍ\x18ｉ\x0EＡ \x10】\n\n\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4);
		PreserveTrigger();
		},
	}
Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,2,GMode);
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\n\n\x13\x07조합법 \x04: Marine + \x1F15000 Ｏｒｅ \x04= \x1BH \x04Marine + \x1F25000 Ｏｒｅ \x04= \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\n\x13\x10Ｐｕｒｅ　Ｍｏｄｅ \x04 적용으로 모든 마린의 공격력 증가 효과를 얻었습니다.\n\x13\x04주의! 카운트 다이머 모두 소진시 공격력이 원래대로 돌아옴\n\n\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4);
		PreserveTrigger();
		},
	}
	
CIfEnd()

Trigger { -- 조합법 insert키
	players = {Force1},
	conditions = {
		BYD;
		Memory(0x596A44, Exactly, 0x00000100);
	},
	actions = {
		DisplayText("\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x07조합법 \x04: Marine + \x1F15000 Ｏｒｅ \x04= \x1BH \x04Marine + \x1F25000 Ｏｒｅ \x04= \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\n\x13\x04반드시 \x08체력 업그레이드\x04를 1만 이상 올린 후 조합해주세요.\n\x13\x06Ｂｅｙｏｎｄ\x04 난이도의 \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\x04은 특별한 능력을 가지고 있습니다.\n\x13\x041. \x08사망 \x04시 \x07부활. \x04일정시간 동안 \x02반 무적 \x04적용. \x1B쿨타임 : 10분\n\x13\x042. 맵상의 \x1F파일런\x04을 모두 제거할 경우 \x07특수 공격 스킬 능력 \x04활성화\n\x13\x043. \x08체력 업그레이드 \x04완료시 \x1C개별 수정 보호막 \x04활성화.\n\x13\x044.\x10【 K\x04ey \x10】\x04파괴시 공격 스킬의 \x07공격력 \x04증가\n\x13\x04수정 보호막은 \x08L\x0Eu\x0Fm\x10i\x11n\x10o\x0Fu\x0Es \x08M\x0Ea\x0Fr\x10i\x11n\x15e\x04의 체력이 반 이하로 떨어질 경우 확률적으로 발동됩니다.\n\x13\x17ＣＬＯＳＥ　：　ＤＥＬＥＴＥ　ＫＥＹ\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4);
		PreserveTrigger();
		},
	}


Trigger { -- 채팅창 정리 delete키
	players = {Force1},
	conditions = {
		
		Memory(0x596A44, Exactly, 65536);
},
	actions = {
		DisplayText(string.rep("\n", 20),4);
		PreserveTrigger();
		},
	}
for i = 1, 5 do
CIf(FP,CDeaths(P6,Exactly,i,DifID))
Trigger { -- 킬 포인트 리더보드, 집근처 유닛 오더시키기, 쉴드 회복, 저글링 히드라 어택땅
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(P6,AtMost,0,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Kills, "\x1D【 \x11P\x04oints \x1D】 \x04- "..DifT[i]);
		LeaderBoardComputerPlayers(Disable);
		SetCDeaths(P6,SetTo,600,LeaderBoardT);
		PreserveTrigger();
	},
}
Trigger { -- 데스 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(P6,Exactly,400,LeaderBoardT);
	},
	actions = {
		LeaderBoardScore(Custom, "\x10【 \x08Death \x10C\x04ounts \x10】 \x04- "..DifT[i]);
		LeaderBoardComputerPlayers(Disable);
		Order("Factories",Force2,"Anywhere",Patrol,5);
		Order("Men",P8,140,Patrol,5);
		PreserveTrigger();
},
}

Trigger { -- 데스 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(P6,Exactly,400,LeaderBoardT);
		CDeaths(P6,Exactly,2,GMode);
	},
	actions = {
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,5);
		SetMemory(0x6509B0,SetTo,FP);
		PreserveTrigger();
},
}

Trigger { -- 킬 스코어 리더보드
	players = {FP},
	conditions = {
		Label(0);
		
		CDeaths(P6,Exactly,200,LeaderBoardT);
	},
	actions = {
		LeaderBoardKills("Any unit","\x02【 \x07K\x04ill \x0FC\x04ounts \x02】 \x04- "..DifT[i]);
		LeaderBoardComputerPlayers(Disable);
		ModifyUnitShields(All,"Men",Force2,"Anywhere",100);
		PreserveTrigger();
},
}
CIfEnd()
end

Trigger { -- 솔플 보너스
	players = {P6},
	conditions = {
		Label(0);
		CVar(P6,SetPlayers[2],Exactly,1);
	},
	actions = {
		SetCountdownTimer(Add,10*60);
		SetResources(Force1,Add,50000,Ore);
		CreateUnit(1,20,5,Force1);
		CreateUnit(3,32,5,Force1);
	},
}
Trigger { -- 추가 솔플 보너스 퓨어모드
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,GMode);
		CVar(P6,SetPlayers[2],Exactly,1);
	},
	actions = {
		SetCountdownTimer(Add,30*60);
		CreateUnit(3,20,5,Force1);
	},
}
Trigger { -- 시간 보너스 BYD
	players = {P6},
	conditions = {
		Label(0);
		BYD;
	},
	actions = {
		SetCountdownTimer(Add,30*60);
	},
}
Trigger { -- 이지 시간 보너스
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 244",Cleared);
		CDeaths(P6,Exactly,1,Difficulty);
		
	},
	actions = {
		SetCountdownTimer(Add,20*60);
	},
}
Trigger { -- 비기너 시작 보너스
	players = {P6},
	conditions = {
		Switch("Switch 244",Set);
		
	},
	actions = {
		SetCountdownTimer(Add,30*60);
		CreateUnit(5,20,5,Force1);
	},
}

Trigger { -- 시작 컴퓨터 세팅
	players = {Force2},
		conditions = {
		
	},
	actions = {
		SetAllianceStatus(Force1,Enemy);
		Order("Factories",Force2,"Anywhere",Attack,5);
		GiveUnits(All,68,P7,"Anywhere",P12);
		},
	}
Trigger { -- 시작 컴퓨터 세팅
	players = {Force2},
		conditions = {
			BYD;
		
	},
	actions = {
		SetAllianceStatus(Force1,Enemy);
		PreserveTrigger();
		},
	}
	GameOverT = CreateCCode(ExDeaths1)
Trigger { -- =
	players = {P6},
		conditions = {
			Label(0);
			Command(Force1,AtMost,0,"Men");
		
	},
	actions = {
		SetCDeaths(FP,Add,1,GameOverT);
		PreserveTrigger();
		},
	}

Trigger { -- =
	players = {P6},
		conditions = {
			Label(0);
			Command(Force1,AtLeast,1,"Men");
		
	},
	actions = {
		SetCDeaths(FP,SetTo,0,GameOverT);
		PreserveTrigger();
		},
	}


Trigger { -- 게임 오버 트리거
	players = {Force1},
	conditions = {
		Label(0);
		CVar(P6,HDEnd[2],AtMost,0);
		CDeaths(FP,AtLeast,10,GameOverT);
	},
	actions = {
		DisplayText(string.rep("\n", 20),4);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		DisplayText("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
		DisplayText("\n",4);
		DisplayText("\x13\x15모든 플레이어가 빛을 잃었습니다.\n",4);
		DisplayText("\x13\x05게임에서 패배하였습니다.",4);
		DisplayText("\n",4);
		DisplayText("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		PlayWAV("staredit\\wav\\Game_Over.ogg");
		SetCDeaths(P6,SetTo,1,GameOver);
		},
	}
	
Trigger { -- 게임 오버 트리거
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,1,GameOver);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4),
			DisplayTextX("\n",4),
			DisplayTextX("\x13\x15모든 플레이어가 빛을 잃었습니다.\n",4),
			DisplayTextX("\x13\x05게임에서 패배하였습니다.",4),
			DisplayTextX("\n",4),
			DisplayTextX("\x13\x05ＧＡＭＥ　ＯＶＥＲ",4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("staredit\\wav\\Game_Over.ogg")
		},ObPlayers,FP);

		},
	}
	
	
Trigger { -- 타이머 소진시 벙커펑
	players = {P6},
	conditions = {
		Label(0);
		
		CountdownTimer(AtMost,1);
	},
	actions = {
		KillUnit(125,AllPlayers);
		SetCDeaths(P6,SetTo,1,TimerisDEAD);
	},
}
Trigger { -- 타이머 소진 이후 타이머값 고정
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,HDStart);
		CDeaths(P6,AtLeast,1,TimerisDEAD);
	},
	actions = {
		SetCountdownTimer(SetTo,0);
		SetCDeaths(P6,SetTo,0,TimerBonus);
		PreserveTrigger();
	},
}

Trigger { -- 퓨어모드 자환
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,2,GMode);
	},
	actions = {
		SetDeaths(Force1,SetTo,1,111);
		PreserveTrigger();
	},
}






CIfEnd() -- 스위치 203 단락

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Bring(P7,AtMost,0,172,191);
	},
	actions = {
		CreateUnit(1,71,8,P7);
		CreateUnit(1,71,9,P7);
		CreateUnit(1,71,56,P7);
		CreateUnit(1,71,57,P7);
	}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,1,GMode);
		Bring(P7,AtMost,0,172,191);
	},
	actions = {
		RotatePlayer({
			DisplayTextX("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x14\n\x14\n\x13\x07벙커\x04의 \x02봉인\x04이 풀렸습니다.\n\x13\x04이제부터 벙커를 사용하실 수 있습니다.\n\x14\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
			PlayWAVX("staredit\\wav\\start.ogg"),
			PlayWAVX("staredit\\wav\\start.ogg")
		},ObPlayers,FP);
		SetDeaths(P6,Add,1,125);
		SetCDeaths(P6,Add,1,BunkerEnable);
	}
}

for i=0, 4 do -- 각플레이어 스킬, 초반 벙커 활성화 알림+벙활성화
Trigger {
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,1,GMode);
		CDeaths(P6,AtLeast,1,BunkerEnable);
	},
	actions = {
		GiveUnits(All,125,P12,204+i,i);
		DisplayText("\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x14\n\x14\n\x13\x07벙커\x04의 \x02봉인\x04이 풀렸습니다.\n\x13\x04이제부터 벙커를 사용하실 수 있습니다.\n\x14\n\x13\x04！！！　\x03ＮＯＴＩＣＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4);
		PlayWAV("staredit\\wav\\start.ogg");
		PlayWAV("staredit\\wav\\start.ogg");
		SetMemoryB(0x57F27C+(228*i)+125,SetTo,1); -- 9, 34 활성화하고 비활성화할 유닛 인덱스
	}
}

CIf(i,{Command(i,AtLeast,1,27)})
DoActionsP({
		SetLoc(73+i,0,SetTo,0),
		SetLoc(73+i,8,SetTo,0),
		SetLoc(73+i,4,SetTo,0),
		SetLoc(73+i,12,SetTo,0),
		MoveLocation(74+i,27,i,"Anywhere"),
		SetLoc(73+i,0,Subtract,5*32),
		SetLoc(73+i,8,Add,5*32),
		SetLoc(73+i,4,Subtract,5*32),
		SetLoc(73+i,12,Add,5*32)},i)
Trigger {
	players = {i},
	conditions = { 
		Label(0);
		CDeaths("X",AtMost,0,SkillT);
	},
	actions = {
		RemoveUnit(179,i);
		PreserveTrigger();
		
	}
}
Points = 8
SizeofPolygon = 1
Radius = 48
CreateUnitPolygonSafe2Gun(i,{Label(0),CDeaths("X",AtMost,0,SkillT),Bring(Force2,AtLeast,1,"Men",74+i)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),73+i,32,Radius,0,Points,1,i, {1,179})
Trigger {
	players = {i},
	conditions = { 
		Label(0);
		CDeaths("X",AtMost,0,SkillT);
		Bring(Force2,AtLeast,1,"Men",74+i);
	},
	actions = {
		Order(179,i,"Anywhere",Patrol,"Anywhere");
		SetCDeaths("X",SetTo,8,SkillT);
		PreserveTrigger();
		
	}
}
DoActionsPX(SetCDeaths("X",Subtract,1,SkillT),i)
CIfEnd()
end
Trigger { -- 시민 죽은사람 스킬유닛 제거
	players = {Force1},
	conditions = {
		Command(CurrentPlayer,AtMost,0,27);
		NBYD;
		
	},
	actions = {
		KillUnit(179,CurrentPlayer);
		PreserveTrigger();
		},
	}



Trigger { -- 초반 인스 제한
	players = {P6},
	conditions = { 
		CountdownTimer(AtLeast,7201);
		HD;
	},
	actions = {
		SetMemoryX(0x6563A0, SetTo, 255*65536,0xFFFF0000);
		PreserveTrigger();
	}
}
Trigger { -- 초반 인스 제한
	players = {P6},
	conditions = { 
		CountdownTimer(AtMost,7200);
	},
	actions = {
		SetMemoryX(0x6563A0, SetTo, 0*65536,0xFFFF0000);
		PreserveTrigger();
	}
}


Trigger { -- 힐존트리거
players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,HealT);
		CDeaths(P6,AtMost,0,BYDBossStart2);
	},
	actions = {
		SetCDeaths(P6,Add,50,HealT);
		ModifyUnitHitPoints(All,"Men",Force1,213,100);
		PreserveTrigger();
	},
}

Trigger { -- 힐존트리거
players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,HealT);
		CDeaths(P6,AtLeast,1,BYDBossStart2);
	},
	actions = {
		BYDBossMarHPRecover;
		ModifyUnitHitPoints(All,"Men",Force1,213,100);
		BYDBossMarHPPatch;
		SetCDeaths(P6,Add,50,HealT);
		PreserveTrigger();
	},
}
CIf(FP,NBYD)

CanText = "\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x14\n\x14\n\x13\x04맵상의 유닛이 \x08１５００\x04기 이상 있습니다.\n\x13\x04\x07５초\x04간 \x08１５００\x04마리 이상 \x10지속\x04될 경우 \x08캔낫\x04으로 간주됩니다.\n\x14\n\x13\x04！！！　\x08ＷＡＲＮＩＮＧ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
Trigger { -- 캔낫 경고
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,CanWT);
		Memory(0x58F558,AtLeast,1);
		
		
},
	actions = {
		RotatePlayer({
			DisplayTextX(CanText,4),
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV"),
			PlayWAVX("sound\\Terran\\RAYNORM\\URaPss02.WAV")
		},HumanPlayers,FP);
		SetCDeaths(P6,Add,24*10,CanWT);
		PreserveTrigger();
		
		},
	}

Trigger { -- 캔낫시 모든 저그유닛 삭제, 경고1회부여, 정야독
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,LastCan);
		CDeaths(P6,AtMost,0,CanCT);
		Memory(0x58F558,AtLeast,5000);
	},
	actions = {
		RotatePlayer({
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\warn.wav"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
			},HumanPlayers,7);
		RunAIScriptAt(JYD,"Anywhere");
		SetMemory(0x6509B0,SetTo,5);
		SetMemory(0x582174,add,2);
		SetMemory(0x582178,add,2);
		SetMemory(0x58217C,add,2);
		SetMemory(0x582180,add,2);
		SetMemory(0x582184,add,2);
		SetMemory(0x58F558,SetTo,0);
		SetCDeaths(P6,SetTo,24*30,CanCT);
		SetCDeaths(P6,Add,1,CanC);
		KillUnit("Factories",Force2);
		PreserveTrigger();
	},
}


Trigger { -- 캔낫 3회초과 아웃
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,LastCan);
		CDeaths(P6,AtMost,0,CanCT);
		Memory(0x58F558,AtLeast,5000);
	},
	actions = {
		RotatePlayer({
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\CanOver.ogg"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
		},HumanPlayers,FP);
		SetMemory(0x582174,add,2);
		SetMemory(0x582178,add,2);
		SetMemory(0x58217C,add,2);
		SetMemory(0x582180,add,2);
		SetMemory(0x582184,add,2);
		SetMemory(0x58F558,SetTo,0);
		SetCDeaths(P6,Add,1,GameOver);
		KillUnit("Factories",Force2);
	},
}
Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,Exactly,1,Difficulty);
		CDeaths(FP,Exactly,4,CanC);
},
	actions = {
		SetCDeaths(FP,SetTo,1,LastCan);
}
}

Trigger {
	players = {FP},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,Difficulty);
		CDeaths(FP,Exactly,2,CanC);
},
	actions = {
		SetCDeaths(FP,SetTo,1,LastCan);
}
}

CIfEnd()
Trigger { -- 동맹상태 고정, 중립마린 제거
	players = {Force1},
	actions = {
		SetAllianceStatus(Force1,Ally);
		RunAIScript("Turn ON Shared Vision for Player 1");
		RunAIScript("Turn ON Shared Vision for Player 2");
		RunAIScript("Turn ON Shared Vision for Player 3");
		RunAIScript("Turn ON Shared Vision for Player 4");
		RunAIScript("Turn ON Shared Vision for Player 5");
		PreserveTrigger();
	},
}
DoActions(FP,{
		ModifyUnitEnergy(All,MarID[1],P12,64,0);
		ModifyUnitEnergy(All,MarID[2],P12,64,0);
		ModifyUnitEnergy(All,MarID[3],P12,64,0);
		ModifyUnitEnergy(All,MarID[4],P12,64,0);
		ModifyUnitEnergy(All,MarID[5],P12,64,0);
		KillUnitAt(all,"Factories","Anywhere",P12);
		KillUnit(179,P12);})
CIf(FP,BYD)

Trigger { -- 캔낫시 모든 저그유닛 삭제, 경고1회부여, 정야독
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,BYDBossStart);
		CDeaths(P6,AtMost,0,CanC);
		CDeaths(P6,AtMost,0,CanCT);
		CVar(P6,count[2],AtLeast,1500);
		Memory(0x628438,AtMost,0);
	},
	actions = {
		RotatePlayer({
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\warn.wav"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss01.WAV")
			},HumanPlayers,7);
		RunAIScriptAt(JYD,"Anywhere");
		SetMemory(0x6509B0,SetTo,5);
		SetMemory(0x582174,add,2);
		SetMemory(0x582178,add,2);
		SetMemory(0x58217C,add,2);
		SetMemory(0x582180,add,2);
		SetMemory(0x582184,add,2);
		SetMemory(0x58F558,SetTo,0);
		SetCDeaths(P6,SetTo,24*30,CanCT);
		SetCDeaths(P6,Add,1,CanC);
		KillUnit("Factories",Force2);
		PreserveTrigger();
	},
}
Trigger { -- 캔낫 3회초과 아웃
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,BYDBossStart);
		CDeaths(P6,AtLeast,1,CanC);
		CDeaths(P6,AtMost,0,CanCT);
		CVar(P6,count[2],AtLeast,1500);
		Memory(0x628438,AtMost,0);
	},
	actions = {
		RotatePlayer({
			PlayWAVX("sound\\Bullet\\TNsHit00.wav"),
			PlayWAVX("staredit\\wav\\CanOver.ogg"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV"),
			PlayWAVX("sound\\Terran\\GOLIATH\\TGoPss05.WAV")
		},HumanPlayers,FP);
		SetMemory(0x582174,add,2);
		SetMemory(0x582178,add,2);
		SetMemory(0x58217C,add,2);
		SetMemory(0x582180,add,2);
		SetMemory(0x582184,add,2);
		SetMemory(0x58F558,SetTo,0);
		SetCDeaths(P6,Add,1,GameOver);
		KillUnit("Factories",Force2);
	},
}
CIfEnd()

Trigger { -- 버콜 이펙트 캔낫방지
	players = {P6},
	conditions = {
		Label(0);
		Memory(0x58F528,AtLeast,1);
	},
	actions = {
		SetCDeaths(P6,SetTo,20,CanCT);
		SetMemory(0x58F528,SetTo,0);
		PreserveTrigger();
	},
}


Trigger { -- 캔낫 건물파괴방지
players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,CanCT);
	},
	actions = {
		SetInvincibility(Enable,"【 Lair 】",Force2,"Anywhere");
		SetInvincibility(Enable,"【 Hive 】",Force2,"Anywhere");
		SetInvincibility(Enable,"【 the Present 】",Force2,"Anywhere");
		SetInvincibility(Enable,"【 Deep Abyss 】",Force2,"Anywhere");
		PreserveTrigger();
	},
}

Trigger { -- 캔낫 건물파괴방지
players = {P6},
	conditions = {
		Memory(0x58F558,AtLeast,1);
	},
	actions = {
		SetInvincibility(Enable,"【 Lair 】",Force2,"Anywhere");
		SetInvincibility(Enable,"【 Hive 】",Force2,"Anywhere");
		SetInvincibility(Enable,"【 the Present 】",Force2,"Anywhere");
		SetInvincibility(Enable,"【 Deep Abyss 】",Force2,"Anywhere");
		PreserveTrigger();
	},
}

Trigger { -- 캔낫 건물파괴방지
players = {P6},
	conditions = {
		Label(0);
		Memory(0x58F558,Exactly,0);
		CDeaths(P6,Exactly,0,CanCT);
	},
	actions = {
		SetInvincibility(Disable,"【 Lair 】",Force2,"Anywhere");
		SetInvincibility(Disable,"【 Hive 】",Force2,"Anywhere");
		SetInvincibility(Disable,"【 the Present 】",Force2,"Anywhere");
		SetInvincibility(Disable,"【 Deep Abyss 】",Force2,"Anywhere");
		PreserveTrigger();
	},
}

Trigger { -- SCV 소지 갯수 제한
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,EVMode);
		Command(CurrentPlayer,AtLeast,6,7);
		},
	
	actions = {
		KillUnitAt(1,7,"Anywhere",CurrentPlayer);
		DisplayText("\x07『 \x04SCV는 5기를 넘어서 소지할 수 없습니다. \x1C자원 반환 \x1F+ 500 Ore\x07 』",4);
		SetResources(CurrentPlayer,Add,500,Ore);
		PreserveTrigger();
	},
}




CIf(P6,Switch("Switch 2",Set))
CUTable = {1,51,1,104,1,56,1,48}
CUTable2 = {77,17,78,75}
CUTable3 = {17,77,75,78}
CUTable4 = {65,3,66,81}
CUTable5 = {3,65,81,66}

for i=0, 1 do
Trigger {
	players = {P6},
	conditions = {
		FTRBYD;
		CountdownTimer(AtMost,7200);
	},
	actions = {
		CreateUnit(1,84,192+i,P6);
		CreateUnit(10,69,192+i,P8);
		CreateUnit(10,11,192+i,P7);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,6);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,5);
		PreserveTrigger();
	}
}
Trigger {
	players = {P6},
	conditions = {
		FTRBYD;
		CountdownTimer(AtMost,4800);
	},
	actions = {
		CreateUnit(1,84,192+i,P6);
		CreateUnit(5,69,192+i,P8);
		CreateUnit(5,11,192+i,P7);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,6);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,5);
		PreserveTrigger();
	}
}
Trigger {
	players = {P6},
	conditions = {
		FTRBYD;
		CountdownTimer(AtMost,3600);
	},
	actions = {
		CreateUnit(1,84,192+i,P6);
		CreateUnit(5,69,192+i,P8);
		CreateUnit(5,11,192+i,P7);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,6);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,5);
		PreserveTrigger();
	}
}
Trigger {
	players = {P6},
	conditions = {
		FTRBYD;
		CountdownTimer(AtMost,1800);
	},
	actions = {
		CreateUnit(1,84,192+i,P6);
		CreateUnit(15,69,192+i,P8);
		CreateUnit(15,11,192+i,P7);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,6);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,5);
		PreserveTrigger();
	}
}
Trigger {
	players = {P6},
	conditions = {
		FTRBYD;
		CountdownTimer(AtMost,900);
	},
	actions = {
		CreateUnit(1,84,192+i,P6);
		CreateUnit(15,69,192+i,P8);
		CreateUnit(15,11,192+i,P7);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,6);
		RunAIScriptAt(JYD,192+i);
		SetMemory(0x6509B0,SetTo,5);
		PreserveTrigger();
	}
}
end


for i=0, 3 do

Trigger {
	players = {P6},
	conditions = {
		BYD;
		CountdownTimer(AtMost,3600);
	},
	actions = {
		CreateUnit(1,64,66+i,P8);
		Order(64,P8,"Anywhere",Attack,"Anywhere");
		PreserveTrigger();
	}
}
Trigger {
	players = {P6},
	conditions = {
		BYD;
		CountdownTimer(AtMost,0);
	},
	actions = {
		CreateUnit(1,64,66+i,P8);
		Order(64,P8,"Anywhere",Attack,"Anywhere");
		PreserveTrigger();
	}
}

Points = 5
SizeofPolygon = 2
Radius = 96
CreateUnitPolygonSafe2Gun(P6,Bring(Force2,AtLeast,1,189,70+i),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65+i,32,Radius,0,Points,1,P8, CUTable)
CreateUnitPolygonSafe2Gun(P6,{NBYD,CountdownTimer(AtMost,7200),Switch("Switch 1",Set),Bring(Force2,AtLeast,1,189,70+i)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65+i,32,Radius,0,Points,1,P8, {1,CUTable2[i+1]})
CreateUnitPolygonSafe2Gun(P6,{NBYD,CountdownTimer(AtMost,7200),Switch("Switch 1",Cleared),Bring(Force2,AtLeast,1,189,70+i)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65+i,32,Radius,0,Points,1,P8, {1,CUTable3[i+1]})

Points = 6
SizeofPolygon = 3
Radius = 72
CreateUnitPolygonSafe2Gun(P6,{BYD,CountdownTimer(AtMost,7200),Switch("Switch 1",Set),Bring(Force2,AtLeast,1,189,70+i)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65+i,32,Radius,0,Points,1,P8, {1,CUTable4[i+1]})
CreateUnitPolygonSafe2Gun(P6,{BYD,CountdownTimer(AtMost,7200),Switch("Switch 1",Cleared),Bring(Force2,AtLeast,1,189,70+i)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65+i,32,Radius,0,Points,1,P8, {1,CUTable5[i+1]})
end
for i = 0, 3 do
Trigger {
	players = {P6},
	conditions = {
		Bring(Force2,AtLeast,1,189,70+i)
	},  
	actions = {
		Order("Men",P8,66+i,Attack,5);
		PreserveTrigger();
	},
}
end
DoActionsX(FP,{SetSwitch("Switch 2",Clear),SetCDeaths(FP,Add,1,ScorePrint)})
CIfEnd()


		
CIf(P6,{Switch("Switch 5",Set),Memory(0x58F45C,AtLeast,(60*2*1000)+350)})
Points = 6
SizeofPolygon = 1
Radius = 128
CUTable = {1,54,1,53,1,48,1,56,1,51}
for i=0, 3 do
CreateUnitPolygonSafe2Gun(P6,Bring(Force2,AtLeast,1,189,70+i),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65+i,32,Radius,0,Points,1,P8, CUTable)
end
for i = 0, 3 do
Trigger {
	players = {P6},
	conditions = {
		Bring(Force2,AtLeast,1,189,70+i)
	},  
	actions = {
		Order("Factories",P8,66+i,Attack,5);
		PreserveTrigger();
	},
}
end
DoActionsP(SetSwitch("Switch 5",Clear),P6)
CIfEnd()

 -- 레어 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,0)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 기둥 \x1D【 Ｌ\x04ａｉｒ \x1D】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．４\x04％ 〓\n\n\n"
	
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,3,BGMType);
		PreserveTrigger();
		},
	}
 -- 하이브 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,1)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 기둥 \x1D【 Ｈ\x04ｉｖｅ \x1D】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．７\x04％ 〓\n\n\n"
	
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,2,BGMType);
		PreserveTrigger();
		},
	}

 -- 센터 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,2)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 조각상 \x10【 Ｃ\x04ｅｎｔｅｒ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．２\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 셀브 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,3)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 정신체 \x10【 Ｃ\x04ｅｒｅｂｒａｔｅ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．８\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 센터 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,4)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 연결체 \x10【 Ｎ\x04ｅｘｕｓ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．８\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 센터 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,5)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 초월체 \x10【 Ｏ\x04ｖｅｒｍｉｎ\x10Ｄ 】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．４\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 센터 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,6)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 현재 \x10【 \x04ｔｈｅ \x10Ｐ\x04ｒｅｓｅｎｔ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．２\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 센터 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,7)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 심연 \x10【 Ｄ\x04ｅｅｐ \x10Ａ\x04ｂｙｓｓ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．２\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 젤나가 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,8)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 외곽 \x10【 Ｕ\x04ｎｄｅｆｉｎｅｄ \x10Ｏ\x04ｕｔｓｉｄｅ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．４\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 코쿤 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,9)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 고치 \x10【 Ｏ\x04ｖｅｒＣｏＣｏｏｎ \x10】 \x04을 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０２．０\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 다고스 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,10)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 완전체 \x10【 Ｄ\x04ａｇｇｏｔｈ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．５\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 제네 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,11)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 발전소 \x10【 Ｏ\x04ｖｅｒｗｈｅｌｍｉｎｇ \x10】 \x04을 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03００．５\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 제네 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,12)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 신전 \x10【 Ｌ\x04ｏｓｔ　\x10Ｃ\x04ｉｖｉｌｉｚａｔｉｏｎ \x10】 \x04을 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x03０１．０\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,4,BGMType);
		PreserveTrigger();
		},
	}
 -- 워프 파괴시 브금, 텍스트
	BdIndex = CCode(0x1004,13)
	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 동굴 \x10【 Ｗ\x04ａｒｐ　\x10Ｔ\x04ｕｎｎｅｌ \x10】 \x04을 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x07００．４\x04％ 〓\n\n\n"
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,AtLeast,1,BdIndex);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,FP);
		SetCDeaths(P6,Subtract,1,BdIndex);
		SetCDeaths(P6,SetTo,7,BGMType);
		PreserveTrigger();
		},
	}
CIf(P6,Command(AllPlayers,AtLeast,1,"Dark Swarm"))
DoActionsP({MoveLocation(24,"Dark Swarm",AllPlayers,"Anywhere"),CreateUnit(1,84,24,P6),KillUnit(84,P6),CreateUnit(1,"【 Artanis 】",24,P8)},P6)
CreateUnitPolygonSafe2Gun(P6,Always(),16,23,32,64,30,5,1,P8,{1,51})
DoActionsP(RemoveUnitAt(1,"Dark Swarm",24,AllPlayers),P6)
CIfEnd()

--CIf({Force2},{CDeaths(P6,Exactly,0,HDStart),Deaths(P6,Exactly,0,173),Command(P6,AtMost,0,173)})
--C1
CPlayer = 6
LocationID = 10
BdID = 130
C = CCode(0x1002,41)
BdIndex = CCode(0x1004,2)
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CommandLeastAt(BdID,LocationID+1)})

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 왼쪽알타
		MemoryX(0x58F450,AtMost,0,0xFF);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1,0xFF);
		SetCDeaths(P6,Add,1,C1);
		SetCountdownTimer(Add,180);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 오른쪽알타
		MemoryX(0x58F450,AtMost,0*65536,0xFF0000);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1*65536,0xFF0000);
		SetCDeaths(P6,Add,1,C1);
		SetCountdownTimer(Add,180);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 왼쪽알타
		MemoryX(0x58F450,AtLeast,1*256,0xFF00);
		CDeaths(P6,AtLeast,1,C1);
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*256,0xFF00);
		SetDeaths(P7,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 오른쪽알타
		MemoryX(0x58F450,AtLeast,1*16777216,0xFF000000);
		CDeaths(P6,AtLeast,1,C1);
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*16777216,0xFF000000);
		SetDeaths(P7,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,12); -- ClearRate + 1.2%
		SetCDeaths(P6,Add,1,BdIndex);
},
}

CIfEnd()
--C2
CIndex = 0x67
CPlayer = 7
LocationID = 33
BdID = 130
C = CCode(0x1002,42)
BdIndex = CCode(0x1004,2)
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CommandLeastAt(BdID,LocationID+1)})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 왼쪽알타
		MemoryX(0x58F450,AtMost,0,0xFF);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1,0xFF);
		SetCountdownTimer(Add,180);
		SetCDeaths(P6,Add,1,C2);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 오른쪽알타
		MemoryX(0x58F450,AtMost,0*65536,0xFF0000);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1*65536,0xFF0000);
		SetCountdownTimer(Add,180);
		SetCDeaths(P6,Add,1,C2);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 왼쪽알타
		MemoryX(0x58F450,AtLeast,1*256,0xFF00);
		CDeaths(P6,AtLeast,1,C2);
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*256,0xFF00);
		SetDeaths(P8,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 오른쪽알타
		MemoryX(0x58F450,AtLeast,1*16777216,0xFF000000);
		CDeaths(P6,AtLeast,1,C2);
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*16777216,0xFF000000);
		SetDeaths(P8,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,12); -- ClearRate + 1.2%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
CIfEnd()
--C3
CIndex = 0x68
CPlayer = 7
LocationID = 11
BdID = 130
C = CCode(0x1002,43)
BdIndex = CCode(0x1004,2)
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CommandLeastAt(BdID,LocationID+1)})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 왼쪽알타
		MemoryX(0x58F450,AtMost,0,0xFF);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1,0xFF);
		SetCountdownTimer(Add,180);
		SetCDeaths(P6,Add,1,C3);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 오른쪽알타
		MemoryX(0x58F450,AtMost,0*65536,0xFF0000);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1*65536,0xFF0000);
		SetCountdownTimer(Add,180);
		SetCDeaths(P6,Add,1,C3);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 왼쪽알타
		MemoryX(0x58F450,AtLeast,1*256,0xFF00);
		CDeaths(P6,AtLeast,1,C3);
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*256,0xFF00);
		SetDeaths(P8,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 오른쪽알타
		MemoryX(0x58F450,AtLeast,1*16777216,0xFF000000);
		CDeaths(P6,AtLeast,1,C3);
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*16777216,0xFF000000);
		SetDeaths(P8,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,12); -- ClearRate + 1.2%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
CIfEnd()
--C4
CIndex = 0x69
CPlayer = 6
LocationID = 34
BdID = 130
C = CCode(0x1002,44)
BdIndex = CCode(0x1004,2)
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CommandLeastAt(BdID,LocationID+1)})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 왼쪽알타
		MemoryX(0x58F450,AtMost,0,0xFF);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1,0xFF);
		SetCountdownTimer(Add,180);
		SetCDeaths(P6,Add,1,C4);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 오른쪽알타
		MemoryX(0x58F450,AtMost,0*65536,0xFF0000);
		},
	actions = {
		SetMemoryX(0x58F450,Add,1*65536,0xFF0000);
		SetCountdownTimer(Add,180);
		SetCDeaths(P6,Add,1,C4);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Cleared); -- 왼쪽알타
		MemoryX(0x58F450,AtLeast,1*256,0xFF00);
		CDeaths(P6,AtLeast,1,C4)
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*256,0xFF00);
		SetDeaths(P7,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Switch("Switch 1",Set); -- 오른쪽알타
		MemoryX(0x58F450,AtLeast,1*16777216,0xFF000000);
		CDeaths(P6,AtLeast,1,C4)
	},
	actions = {
		SetMemoryX(0x58F450,Subtract,1*16777216,0xFF000000);
		SetDeaths(P7,Subtract,1,BdID);
		SetCDeaths("X",Add,1,C);
		SetCDeaths(P6,Add,1,C);
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,12); -- ClearRate + 1.2%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
CIfEnd()
CIf(P6,CDeaths(P6,AtMost,0,HDStart))
for i=0, 1 do -- CIf 0x50~0x51 EX2 04~05 L140~L141 SP
--cannon
CIndex = 0x50+i
CPlayer = 5
C = CCode(0x1002,04+i)
T = CCode(0x1003,04+i)
LocationID = 140+i
BdID = 127
BdIndex = CCode(0x1004,6)
Sw1Status1 = Set
Sw1Status2 = Cleared
BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {P7},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})
Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45

Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x662350 + (79*4), SetTo, (900000*256)/2);
		SetMemory(0x662350 + (80*4), SetTo, (720000*256)/2);
		SetMemory(0x662350 + (81*4), SetTo, (735000*256)/2);
		SetMemory(0x662350 + (57*4), SetTo, (700000*256)/2);
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256)/3);
		SetMemory(0x662350 + (19*4), SetTo, (700000*256)/2);
		PreserveTrigger();
		}
}
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,77,1,79})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,78,1,75})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,54,1,55,1,48})
Trigger {
	players = {CPlayer},
	actions = {
		SetLoc(LocationID,0,Subtract,32*14);
		SetLoc(LocationID,4,Subtract,32*14);
		SetLoc(LocationID,8,Add,32*14);
		SetLoc(LocationID,12,Add,32*14);
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}



CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,RedNumberX,T),
		CDeaths("X", AtMost,0, C)
},
	{
		SetCDeaths("X",SetTo,0,T),
		SetDeaths(P10,Add,1,CIndex),
		SetMemory(0x6C9D04, SetTo, 65537);
		SetMemory(0x6CA010, SetTo, 1);
		
})
Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1),Deaths(P10,AtLeast,1,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,77,1,79,1,88})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2),Deaths(P10,AtLeast,1,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,78,1,75,1,21})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,1,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,51})
Points = 2
Radius = 64
Angle = 90
Trigger { -- EUD Editor
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,GMode);
		Deaths(P10,AtLeast,1,CIndex);
	},
	actions = {
		--SetMemory(0x662350 + (29*4), SetTo, (800000*256)/2);
		--SetMemory(0x6624E8, SetTo, 588800000/6);
		
	},
}
CreateUnitLineSafeGun(CPlayer,{Deaths(P10,AtLeast,1,CIndex),HD},11,209+i,32,Radius,Angle,Points,0,P8,{1,29})
CreateUnitLineSafeGun(CPlayer,{Deaths(P10,AtLeast,1,CIndex),FTR},11,209+i,32,Radius,Angle,Points,0,P8,{1,102})
Radius = 256
CreateUnitLineSafeGun(CPlayer,{Deaths(P10,AtLeast,1,CIndex),BYD},3,209+i,32,Radius,Angle,Points,0,P8,{1,60})
Trigger {
	players = {CPlayer},
	conditions = {
		Deaths(P10,AtLeast,1,CIndex);
		},
	actions = {
		--SetMemory(0x662350 + (29*4), SetTo, (800000*256));
		--SetMemory(0x6624E8, SetTo, 588800000);
		SetMemory(0x6C9D04, SetTo, 65563);
		SetMemory(0x6CA010, SetTo, 640);
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}

CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,RedNumberX,T),
		Deaths(P10,AtMost,2,CIndex)
},
	{
		SetCDeaths("X",SetTo,0,T),
		SetDeaths(P10,Add,1,CIndex)
		
},1)
Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1),Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,19,1,76,1,80})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2),Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,17,1,63,1,8})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,2,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,51})
Trigger {
	players = {CPlayer},
	conditions = {
		Deaths(P10,AtLeast,2,CIndex);
		},
	actions = {
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}

Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1),Deaths(P10,AtLeast,3,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,19,1,76,1,28})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2),Deaths(P10,AtLeast,3,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,17,1,63,1,57})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,3,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,51})
Trigger {
	players = {CPlayer},
	conditions = {
		Deaths(P10,AtLeast,3,CIndex);
		},
	actions = {
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Deaths(P10,AtLeast,3,CIndex);
		CDeaths("X",AtLeast,500,T);
		},
	actions = {
		SetCDeaths("X",SetTo,0,T);
		SetCDeaths("X",Add,1,C);
},
}

Trigger { -- No comment (00F60EE3)
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths(P6, AtLeast, 2, Difficulty);
		Bring(Force2, AtLeast, 6, "Men", LocationID+1);
		Bring(Force1, AtMost, 5, "Factories", LocationID+1);
	},
	actions = {
		SetCDeaths(P6,Add,1,PaneltyP);
		PreserveTrigger();
	},
}
Trigger { -- No comment (00F60EE3)
	players = {CPlayer},
	conditions = {
		Label(0);
		Bring(Force2, AtLeast, 6, "Men", LocationID+1);
		Bring(Force1, AtLeast, 6, "Factories", LocationID+1);
	},
	actions = {
		SetCDeaths(P6,Add,1,BonusP);
		PreserveTrigger();
	},
}
Trigger { -- No comment (00F60EE3)
	players = {CPlayer},
	conditions = {
		Label(0);
		Bring(Force2, AtMost, 5, "Men", LocationID+1);
	},
	actions = {
		SetCDeaths(P6,Add,1,BonusP);
		PreserveTrigger();
	},
}

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,12); -- ClearRate + 1.2%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
DoActionsPX(SetCDeaths("X",Add,1,T),CPlayer)

Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x662350 + (79*4), SetTo, (900000*256));
		SetMemory(0x662350 + (80*4), SetTo, (720000*256));
		SetMemory(0x662350 + (81*4), SetTo, (735000*256));
		SetMemory(0x662350 + (57*4), SetTo, (700000*256));
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256));
		SetMemory(0x662350 + (19*4), SetTo, (700000*256));
		PreserveTrigger();
		}
}
CIfEnd()
end
for i=0, 1 do -- CIf 0x52~0x53 EX2 06~07 L142~L143 SP
--norad
CIndex = 0x52+i
CPlayer = 5
C = CCode(0x1002,06+i)
T = CCode(0x1003,06+i)
LocationID = 142+i
BdID = 126
BdIndex = CCode(0x1004,7)
Sw1Status1 = Cleared
Sw1Status2 = Set
BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {P8},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})
Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45
Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x662350 + (79*4), SetTo, (900000*256)/2);
		SetMemory(0x662350 + (80*4), SetTo, (720000*256)/2);
		SetMemory(0x662350 + (81*4), SetTo, (735000*256)/2);
		SetMemory(0x662350 + (57*4), SetTo, (700000*256)/2);
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256)/3);
		SetMemory(0x662350 + (19*4), SetTo, (700000*256)/2);
		PreserveTrigger();
		}
}
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,77,1,79})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,78,1,75})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Always(),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,54,1,55,1,48})
Trigger {
	players = {CPlayer},
	actions = {
		SetLoc(LocationID,0,Subtract,32*14);
		SetLoc(LocationID,4,Subtract,32*14);
		SetLoc(LocationID,8,Add,32*14);
		SetLoc(LocationID,12,Add,32*14);
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}
CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,RedNumberX,T),
		CDeaths("X", AtMost,0, C)
},
	{
		SetCDeaths("X",SetTo,0,T),
		SetDeaths(P10,Add,1,CIndex),
		SetMemory(0x6C9D04, SetTo, 65537);
		SetMemory(0x6CA010, SetTo, 1);
		
})
Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1),Deaths(P10,AtLeast,1,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,77,1,79,1,88})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2),Deaths(P10,AtLeast,1,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,78,1,75,1,21})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,1,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,51})
Points = 2
Radius = 64
Angle = 90
Trigger { -- EUD Editor
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,GMode);
		Deaths(P10,AtLeast,1,CIndex);
	},
	actions = {
		--SetMemory(0x662350 + (29*4), SetTo, (800000*256)/2);
		--SetMemory(0x6624E8, SetTo, 588800000/6);
	},
}
CreateUnitLineSafeGun(CPlayer,{Deaths(P10,AtLeast,1,CIndex),HD},11,210-i,32,Radius,Angle,Points,0,P8,{1,29})
CreateUnitLineSafeGun(CPlayer,{Deaths(P10,AtLeast,1,CIndex),FTR},11,210-i,32,Radius,Angle,Points,0,P8,{1,102})

Radius = 256
CreateUnitLineSafeGun(CPlayer,{Deaths(P10,AtLeast,1,CIndex),BYD},3,210-i,32,Radius,Angle,Points,0,P8,{1,60})
Trigger {
	players = {CPlayer},
	conditions = {
		Deaths(P10,AtLeast,1,CIndex);
		},
	actions = {
		--SetMemory(0x662350 + (29*4), SetTo, (800000*256));
		SetMemory(0x6C9D04, SetTo, 65563);
		SetMemory(0x6CA010, SetTo, 640);
		--SetMemory(0x6624E8, SetTo, 588800000);
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}

CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,RedNumberX,T),
		Deaths(P10,AtMost,2,CIndex)
},
	{
		SetCDeaths("X",SetTo,0,T),
		SetDeaths(P10,Add,1,CIndex)
		
},1)
Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1),Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,19,1,76,1,80})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2),Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,17,1,63,1,8})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,2,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,51})
Trigger {
	players = {CPlayer},
	conditions = {
		Deaths(P10,AtLeast,2,CIndex);
		},
	actions = {
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}


Points = 5
SizeofPolygon = 5
Radius = 96
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status1),Deaths(P10,AtLeast,3,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,19,1,76,1,28})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 1",Sw1Status2),Deaths(P10,AtLeast,3,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,17,1,63,1,57})
Points = 8
SizeofPolygon = 4
Radius = 96
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,3,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,0,Points,0,P7, {1,51})
Trigger {
	players = {CPlayer},
	conditions = {
		Deaths(P10,AtLeast,3,CIndex);
		},
	actions = {
		Order("Factories",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Deaths(P10,AtLeast,3,CIndex);
		CDeaths("X",AtLeast,500,T);
		},
	actions = {
		SetCDeaths("X",SetTo,0,T);
		SetCDeaths("X",Add,1,C);
},
}

Trigger { -- No comment (00F60EE3)
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths(P6, AtLeast, 2, Difficulty);
		Bring(Force2, AtLeast, 6, "Men", LocationID+1);
		Bring(Force1, AtMost, 5, "Factories", LocationID+1);
	},
	actions = {
		SetCDeaths(P6,Add,1,PaneltyP);
		PreserveTrigger();
	},
}
Trigger { -- No comment (00F60EE3)
	players = {CPlayer},
	conditions = {
		Label(0);
		Bring(Force2, AtLeast, 6, "Men", LocationID+1);
		Bring(Force1, AtLeast, 6, "Factories", LocationID+1);
	},
	actions = {
		SetCDeaths(P6,Add,1,BonusP);
		PreserveTrigger();
	},
}
Trigger { -- No comment (00F60EE3)
	players = {CPlayer},
	conditions = {
		Label(0);
		Bring(Force2, AtMost, 5, "Men", LocationID+1);
	},
	actions = {
		SetCDeaths(P6,Add,1,BonusP);
		PreserveTrigger();
	},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,12); -- ClearRate + 1.2%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
DoActionsPX(SetCDeaths("X",Add,1,T),CPlayer)

Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x662350 + (79*4), SetTo, (900000*256));
		SetMemory(0x662350 + (80*4), SetTo, (720000*256));
		SetMemory(0x662350 + (81*4), SetTo, (735000*256));
		SetMemory(0x662350 + (57*4), SetTo, (700000*256));
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256));
		SetMemory(0x662350 + (19*4), SetTo, (700000*256));
		PreserveTrigger();
		}
}
CIfEnd()
end

for i=0, 3 do -- CIf 0x54~0x57 EX2 08~11 L144~L147 CERE
--Cere
CIndex = 0x54+i
CPlayer = 5
C = CCode(0x1002,08+i)
T = CCode(0x1003,08+i)
LocationID = 144+i
BdID = 151
BdIndex = CCode(0x1004,3)

CereGen = {}
table.insert(CereGen,CreateCCode(ExDeaths1))
table.insert(CereGen,CreateCCode(ExDeaths1))
table.insert(CereGen,CreateCCode(ExDeaths1))
if i == 0 then
	BdPlayer = 7
elseif i == 1 then
	BdPlayer = 7
elseif i == 2 then
	BdPlayer = 6
elseif i == 3 then
	BdPlayer = 6
end

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {BdPlayer},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})
for j = 0, 5 do

CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,_Mul(RedNumberX,j),T)
},
	{
		SetDeaths(P9,Add,1,"【 Cerebrate 】"),
		SetCDeaths(FP,Add,1,CereGen[1]),
		SetCDeaths(FP,Add,1,CereGen[2]),
		SetCDeaths(FP,Add,1,CereGen[3])
})

end
Trigger {
	players = {CPlayer},
	conditions = {
		FTRBYD;
		},
	actions = {
		SetMemoryX(0x6640E4, SetTo, 0x400200,0x400200);
		PreserveTrigger();
	},
}
CWhile(CPlayer,{Deaths(P9,AtLeast,1,"【 Cerebrate 】"),NBYD})
Points = 4
SizeofPolygon = 3
Radius = 120
Angle = 270
StarAngle = 135
CreateUnitStarSafeGun(CPlayer,HD,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),135+i,32,Radius,Angle,Points,StarAngle,1,P8,{1,25})
Points = 4
SizeofPolygon = 4
Radius = 90
Angle = 270
StarAngle = 135
CreateUnitStarSafeGun(CPlayer,FTR,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),135+i,32,Radius,Angle,Points,StarAngle,1,P8,{1,25})
Points = 4
SizeofPolygon = 3
Radius = 120
Angle = 270-45
StarAngle = 135
CreateUnitStarSafeGunMove(CPlayer,HD,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),51+i,32,Radius,Angle,Points,StarAngle,1,P8,135+i,Attack,{1,21})
CreateUnitStarSafeGunMove(CPlayer,HD,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,StarAngle,1,P8,135+i,Attack,{1,28})
CreateUnitStarSafeGunMove(CPlayer,BYD,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,StarAngle,1,P8,135+i,Attack,{1,29})
Points = 4
SizeofPolygon = 4
Radius = 90
Angle = 270-45
StarAngle = 135
CreateUnitStarSafeGunMove(CPlayer,FTR,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),51+i,32,Radius,Angle,Points,StarAngle,1,P8,135+i,Attack,{1,21})
CreateUnitStarSafeGunMove(CPlayer,BYD,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),51+i,32,Radius,Angle,Points,StarAngle,1,P8,135+i,Attack,{1,8})
CreateUnitStarSafeGunMove(CPlayer,FTR,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,StarAngle,1,P8,135+i,Attack,{1,28})
DoActionsP(SetDeaths(P9,Subtract,1,"【 Cerebrate 】"),CPlayer)
CWhileEnd()


BYDCere1 = CSMakeStar(4,135,64,270,PlotSizeCalc(4,5),0)
BYDCere2 = CSMakeStar(4,135,120,270-45,PlotSizeCalc(4,3),0)
BYDCere3 = CSMakeStar(4,135,90,270-45,PlotSizeCalc(4,4),0)
BYDCere = {BYDCere1,BYDCere2,BYDCere3}
CIf(FP,BYD)

SpawnLocTable = {135+i,LocationID,51+i}
SpawnSetTable = {22,29,8}
for j = 1, 3 do
CereLoopLimit = CreateVar()
CereBYDTimer = CreateVar()
NIfX(FP,{TMemory(_Mem(RedNumberX),AtLeast,BYDCere[j][1])})
	CMov(FP,CereLoopLimit,1)
	CiDiv(FP,BYDGunX,RedNumberX,BYDCere[j][1])
	NElseX()
	CMov(FP,CereLoopLimit,_iDiv(_Mov(BYDCere[j][1]),RedNumberX),1)
	CMov(FP,BYDGunX,1)
NIfXEnd()
CAPlot({BYDCere[j]},P8,SpawnSetTable[j],SpawnLocTable[j],nil,1,32,{1,0,0,0,CereLoopLimit,0},nil,CPlayer,
	{CVar(FP,CereBYDTimer[2],AtMost,0),CDeaths(FP,AtLeast,1,CereGen[j])},
	{Order("Men",P8,SpawnLocTable[j]+1,Attack,136+i)},{SetCDeaths(FP,Subtract,1,CereGen[j])})
CTrigger(FP, {CVar(FP,CereBYDTimer[2],Exactly,0)}, {TSetCVar(FP,CereBYDTimer[2],SetTo,BYDGunX)}, 1)
CSub(FP,CereBYDTimer,1)
end

CIfEnd()
CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,_Add(_Mul(RedNumberX,5),6),T)
},
	{
		SetCDeaths("X",Add,1,C)
})

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,8); -- ClearRate + 0.8%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
DoActionsP(SetMemoryX(0x6640E4, SetTo, 0,0x400200),CPlayer)
Trigger {
	players = {CPlayer},
	actions = {
		SetCountdownTimer(Add,180);
},
}
DoActionsPX(SetCDeaths("X",Add,1,T),CPlayer)
NIfEnd()
end

Points = 3
SizeofPolygon = 6
Radius = 64
NexHDShape = CSMakePolygon(Points,64,0,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),0)
Radius = 56
SizeofPolygon = 8
NexFTRShape = CSMakePolygon(Points,64,0,1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),0)
NexBYDLine = {}
NexBYDLine2 = {}
NexBYDLine3 = {}
NexBYDLine4 = {}
for i=0, 12 do
   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
end
for i = 1, 6 do
table.insert(NexBYDLine2,CS_Merge(NexBYDLine[i*2],NexBYDLine[(i*2)+1],32,0))
end
table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[1],NexBYDLine2[2],0,0))
table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[3],NexBYDLine2[4],0,0))
table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[5],NexBYDLine2[6],0,0))
table.insert(NexBYDLine4,CS_Merge(NexBYDLine3[1],NexBYDLine3[2],0,0))
table.insert(NexBYDLine4,CS_Merge(NexBYDLine3[3],NexBYDLine[1],0,0))
NexBYDShape = CS_Merge(NexBYDLine4[1],NexBYDLine4[2],32,0)
function NexRotate()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CA_Rotate(NexAngle) -- SX 만큼 회전
	NIf(FP,{BYD,CVar(FP,CB[2],Exactly,80),Memory(0x628438,AtLeast,1)})
	f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
	NIfEnd()
end
function BYDSCoutPatch()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	NIf(FP,{CVar(FP,CB[2],Exactly,80),TTCVar(FP,Nextptrs[2],NotSame,EPD(0)),BYD})
	CDoActions(FP,{
		TSetDeaths(_Add(Nextptrs,13),SetTo,128,0),
		TSetDeathsX(_Add(Nextptrs,18),SetTo,128,0,0xFFFF)})
	NIfEnd()
	Trigger2(FP,{BYD},{CreateUnit(1,84,LocationID+1,5)},{Preserved})
end

for i=0, 1 do -- CIf 0x58~0x59 EX2 12~13 L164~L165 NEX
--Nexus
CIndex = 0x58+i
CPlayer = 5
C = CCode(0x1002,12+i)
T = CCode(0x1003,12+i)
LocationID = 164+i
BdID = 154
BdIndex = CCode(0x1004,4)
Sw1Status1 = Cleared
Sw1Status2 = Set
NexA = CreateVar()
NexLoopLimit = CreateVar()
NexBYDTimer = CreateVar()
NexLocSet={1024,1024*3,1024*3,1024}

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {P8},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})

for j = 1, 4 do
CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,_Mul(RedNumberX,j),T),NBYD
},
	{
		SetDeaths(P10,Add,1,CIndex)
})
end
DoActions(FP,SetDeaths(P10,Add,1,CIndex),1)

NexForward = CAPlotForward()
--NexForward[8] --생성유닛종류
--NexForward[4] --생성카운트


Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status1);
		NBYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,88);
		PreserveTrigger();
		}
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status2);
		NBYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,21);
		PreserveTrigger();
		}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status1);
		BYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,80);
		PreserveTrigger();
		}
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status2);
		BYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,8);
		PreserveTrigger();
		}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		NBYD
		
},
	actions = {
		
		SetCVar(FP,NexLoopLimit[2],SetTo,9999);
		PreserveTrigger();
		}
}

Trigger {
	players = {CPlayer},
	actions = {
		KillUnitAt(1,162,LocationID+1,Force2);
		SetCountdownTimer(Add,240);
},
}

Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x6C9FA4, SetTo, 128);
		SetMemory(0x6CA038, SetTo, 128);
		Simple_SetLoc(LocationID,NexLocSet[(i*2)+1]-128,NexLocSet[(i*2)+2]-128,NexLocSet[(i*2)+1]+128,NexLocSet[(i*2)+2]+128);
		Simple_SetLoc(174+i,NexLocSet[(i*2)+1]-128,NexLocSet[(i*2)+2]-128,NexLocSet[(i*2)+1]+128,NexLocSet[(i*2)+2]+128);
		PreserveTrigger();
		}
}


NIfX(FP,{TMemory(_Mem(RedNumberX),AtLeast,NexBYDShape[1]),BYD})
	CMov(FP,NexLoopLimit,1)
	CiDiv(FP,BYDGunX,RedNumberX,NexBYDShape[1])
	NElseX()
	CMov(FP,NexLoopLimit,_iDiv(_Mov(NexBYDShape[1]),RedNumberX),1)
	CMov(FP,BYDGunX,1)
NIfXEnd()

CJumpEnd(CPlayer,0x700+CIndex)
CMov(FP,NexAngle,_Mul(NexA,30),i*30)
CAPlot({NexHDShape,NexFTRShape,NexBYDShape},P8,0,LocationID,nil,1,32,{NexDif,0,0,0,NexLoopLimit,0},"NexRotate",CPlayer,
	{CVar(FP,NexBYDTimer[2],AtMost,0),Deaths(P10,AtLeast,1,CIndex)},
	{Order("Men",P8,LocationID+1,Attack,175+i)},{SetDeaths(P10,Subtract,1,CIndex),SetCVar("X",NexA[2],Add,1)},"BYDSCoutPatch")
CTrigger(FP, {CVar(FP,NexBYDTimer[2],Exactly,0),BYD}, {TSetCVar(FP,NexBYDTimer[2],SetTo,BYDGunX)}, 1)
CSub(FP,NexBYDTimer,1)
NIf(CPlayer,{Deaths(P10,AtLeast,1,CIndex),NBYD})
CJump(CPlayer,0x700+CIndex)
NIfEnd()
Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x6C9FA4, SetTo, 1280);
		SetMemory(0x6CA038, SetTo, 1707);
		PreserveTrigger();
		}
}
CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,_Add(_Mul(RedNumberX,4),5),T)
},
	{
		SetCDeaths("X",Add,1,C)
})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,8); -- ClearRate + 0.8%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
DoActionsPX(SetCDeaths("X",Add,1,T),CPlayer)
CIfEnd()
end
for i=0, 1 do -- CIf 0x5A~0x5B EX2 14~15 L162~L163 NEX
--Nexus
CIndex = 0x5A+i
CPlayer = 5
C = CCode(0x1002,14+i)
T = CCode(0x1003,14+i)
LocationID = 162+i
BdID = 154
BdIndex = CCode(0x1004,4)
Sw1Status1 = Set
Sw1Status2 = Cleared
NexA = CreateVar()
NexLoopLimit = CreateVar()
NexBYDTimer = CreateVar()
NexLocSet={1024,1024,1024*3,1024*3}

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {P7},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
CIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})
for j = 1, 4 do
CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,_Mul(RedNumberX,j),T),NBYD
},
	{
		SetDeaths(P10,Add,1,CIndex)
})
end
DoActions(FP,SetDeaths(P10,Add,1,CIndex),1)

NexForward = CAPlotForward()
--NexForward[8] --생성유닛종류
--NexForward[4] --생성카운트

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status1);
		NBYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,88);
		PreserveTrigger();
		}
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status2);
		NBYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,21);
		PreserveTrigger();
		}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status1);
		BYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,80);
		PreserveTrigger();
		}
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Switch("Switch 1",Sw1Status2);
		BYD
		
},
	actions = {
		
		SetCVar(FP,NexForward[8],SetTo,8);
		PreserveTrigger();
		}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		NBYD
		
},
	actions = {
		
		SetCVar(FP,NexLoopLimit[2],SetTo,9999);
		PreserveTrigger();
		}
}

Trigger {
	players = {CPlayer},
	actions = {
		KillUnitAt(1,162,LocationID+1,Force2);
		SetCountdownTimer(Add,240);
},
}
Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x6C9FA4, SetTo, 128);
		SetMemory(0x6CA038, SetTo, 128);
		Simple_SetLoc(LocationID,NexLocSet[(i*2)+1]-128,NexLocSet[(i*2)+2]-128,NexLocSet[(i*2)+1]+128,NexLocSet[(i*2)+2]+128);
		Simple_SetLoc(176+i,NexLocSet[(i*2)+1]-128,NexLocSet[(i*2)+2]-128,NexLocSet[(i*2)+1]+128,NexLocSet[(i*2)+2]+128);
		PreserveTrigger();
		}
}




NIfX(FP,{TMemory(_Mem(RedNumberX),AtLeast,NexBYDShape[1]),BYD})
	CMov(FP,NexLoopLimit,1)
	CiDiv(FP,BYDGunX,RedNumberX,NexBYDShape[1])
	NElseX()
	CMov(FP,NexLoopLimit,_iDiv(_Mov(NexBYDShape[1]),RedNumberX),1)
	CMov(FP,BYDGunX,1)
NIfXEnd()
CJumpEnd(CPlayer,0x700+CIndex)
CMov(FP,NexAngle,_Mul(NexA,30),i*30)
CAPlot({NexHDShape,NexFTRShape,NexBYDShape},P8,0,LocationID,nil,1,32,{NexDif,0,0,0,NexLoopLimit,0},"NexRotate",CPlayer,
	{CVar(FP,NexBYDTimer[2],AtMost,0),Deaths(P10,AtLeast,1,CIndex)},
	{Order("Men",P8,LocationID+1,Attack,177+i)},{SetDeaths(P10,Subtract,1,CIndex),SetCVar("X",NexA[2],Add,1)},"BYDSCoutPatch")
CTrigger(FP, {CVar(FP,NexBYDTimer[2],Exactly,0),BYD}, {TSetCVar(FP,NexBYDTimer[2],SetTo,BYDGunX)}, 1)
CSub(FP,NexBYDTimer,1)
NIf(CPlayer,{Deaths(P10,AtLeast,1,CIndex),NBYD})
CJump(CPlayer,0x700+CIndex)
NIfEnd()
Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x6C9FA4, SetTo, 1280);
		SetMemory(0x6CA038, SetTo, 1707);
		PreserveTrigger();
		}
}

CTrigger(CPlayer,
	{
		TCDeaths("X",AtLeast,_Add(_Mul(RedNumberX,4),5),T)
},
	{
		SetCDeaths("X",Add,1,C)
})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,8); -- ClearRate + 0.8%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
DoActionsPX(SetCDeaths("X",Add,1,T),CPlayer)
CIfEnd()
end

for i=0, 3 do -- CIf 0x5C~0x5F EX2 16~19 L148~L151 OvrM
--OvrM
CIndex = 0x5C+i
CPlayer = 5
C = CCode(0x1002,16+i)
T = CCode(0x1003,16+i)
LocationID = 148+i
BdID = 148
BdIndex = CCode(0x1004,5)
Sw1Status1 = Set
Sw1Status2 = Cleared
OX = {1536,2560,1536,2560}
OY = {3744,352,352,3744}
OArea = {3, 2, 1 ,4}
if i == 0 then
	BdPlayer = 7
elseif i == 1 then
	BdPlayer = 7
elseif i == 2 then
	BdPlayer = 6
elseif i == 3 then
	BdPlayer = 6
end

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {BdPlayer},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})
Trigger {
	players = {CPlayer},
	
	actions = {
		SetLoc(LocationID,0,Subtract,32*7);
		SetLoc(LocationID,4,Subtract,32*7);
		SetLoc(LocationID,8,Add,32*7);
		SetLoc(LocationID,12,Add,32*7);
},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths("X", AtMost, 0, T);
		HD;
		
},
	actions = {
		SetCVar(FP,Ov_E[2],Add,10);
		PreserveTrigger();
		}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths("X", AtMost, 0, T);
		FTR;
		
},
	actions = {
		SetCVar(FP,Ov_E[2],Add,17);
		PreserveTrigger();
		}
}

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths("X", AtMost, 0, T);
		CVar(FP,Ov_BYD[2],Exactly,0);
		BYD;
		
},
	actions = {
		SetCVar(FP,Ov_E[2],Add,2);
		SetCVar(FP,Ov_BYD[2],SetTo,OArea[i+1]);
		SetCVar(FP,Ov_BYD_Index[2],SetTo,i);
		PreserveTrigger();
		}
}

CWhile(CPlayer,{CVar(FP,Ov_E[2],AtLeast,1)})
Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x662350 + (102*4), SetTo, (2300000*256)/3);
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256)/6);
		SetMemory(0x662350 + (61*4), SetTo, (6666666*256)/6);
		SetMemory(0x662350 + (67*4), SetTo, (4500000*256)/6);
		
		
		SetMemory(0x662350 + (79*4), SetTo, (900000*256)/2);
		SetMemory(0x662350 + (80*4), SetTo, (720000*256)/2);
		SetMemory(0x662350 + (81*4), SetTo, (735000*256)/2);
		SetMemory(0x662350 + (57*4), SetTo, (700000*256)/2);
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256)/3);
		SetMemory(0x662350 + (19*4), SetTo, (700000*256)/2);
		PreserveTrigger();
		}
}

CMov(CPlayer,IndexCheck,i)
f_Mod(CPlayer,Ov_X,_Rand(),_Mov(576))
f_Mod(CPlayer,Ov_Y,_Rand(),_Mov(576))
CMov(CPlayer,0x58DC60+0x14*23+0,_Add(Ov_X,-288-16+OX[i+1]))
CMov(CPlayer,0x58DC60+0x14*23+8,_Add(Ov_X,-288+16+OX[i+1]))
CMov(CPlayer,0x58DC60+0x14*23+4,_Add(Ov_Y,-288-16+OY[i+1]))
CMov(CPlayer,0x58DC60+0x14*23+12,_Add(Ov_Y,-288+16+OY[i+1]))
CIfX(CPlayer,{Switch("Switch 1",Set)})
CTrigger(CPlayer,{
	CVar(FP,IndexCheck[2],AtLeast,0),
	CVar(FP,IndexCheck[2],AtMost,1),
},{
	TCreateUnit(1,VArr(UArr1,_Mod(_Rand(),16)),24,7)
},1)
CTrigger(CPlayer,{
	CVar(FP,IndexCheck[2],AtLeast,2),
	CVar(FP,IndexCheck[2],AtMost,3),
},{
	TCreateUnit(1,VArr(UArr2,_Mod(_Rand(),16)),24,7)
},1)
CElseX()
CTrigger(CPlayer,{
	CVar(FP,IndexCheck[2],AtLeast,0),
	CVar(FP,IndexCheck[2],AtMost,1),
},{
	TCreateUnit(1,VArr(UArr2,_Mod(_Rand(),16)),24,7)
},1)
CTrigger(CPlayer,{
	CVar(FP,IndexCheck[2],AtLeast,2),
	CVar(FP,IndexCheck[2],AtMost,3),
},{
	TCreateUnit(1,VArr(UArr1,_Mod(_Rand(),16)),24,7)
},1)
CIfXEnd()
CSub(CPlayer,Ov_E,1)
Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x662350 + (102*4), SetTo, (2300000*256));
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256));
		SetMemory(0x662350 + (61*4), SetTo, (6666666*256));
		SetMemory(0x662350 + (67*4), SetTo, (4500000*256));
		
		
		SetMemory(0x662350 + (79*4), SetTo, (900000*256));
		SetMemory(0x662350 + (80*4), SetTo, (720000*256));
		SetMemory(0x662350 + (81*4), SetTo, (735000*256));
		SetMemory(0x662350 + (57*4), SetTo, (700000*256));
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256));
		SetMemory(0x662350 + (19*4), SetTo, (700000*256));
		PreserveTrigger();
		}
}
CWhileEnd()

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtMost, 0, T);
		},
	actions = {
		SetMemory(0x58F510+(4*i),Add,1);
		SetCDeaths("X",SetTo,50,T);
		SetMemory(0x6509B0,SetTo,7);
		RunAIScriptAt(JYD,LocationID+1);
		SetMemory(0x6509B0,SetTo,CPlayer);
		PreserveTrigger();
},
}


Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Memory(0x58F510+(4*i),AtLeast,24);
		},
	actions = {
		SetCDeaths("X",Add,1,C);
},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,14); -- ClearRate + 1.4%
		SetCountdownTimer(Add,180);
		SetCDeaths(P6,Add,1,BdIndex);
},
}
DoActionsPX(SetCDeaths("X",Subtract,1,T),CPlayer)
NIfEnd()
end

	
NIf(FP,{CVar(FP,Ov_BYD[2],AtLeast,1),BYD})
Trigger {
	players = {P6},
	conditions = {
},
	actions = {
		SetMemory(0x662350 + (102*4), SetTo, (2300000*256)/3);
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256)/6);
		SetMemory(0x662350 + (61*4), SetTo, (6666666*256)/6);
		SetMemory(0x662350 + (67*4), SetTo, (4500000*256)/6);
		SetMemory(0x662350 + (79*4), SetTo, (900000*256)/2);
		SetMemory(0x662350 + (80*4), SetTo, (720000*256)/2);
		SetMemory(0x662350 + (81*4), SetTo, (735000*256)/2);
		SetMemory(0x662350 + (57*4), SetTo, (700000*256)/2);
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256)/3);
		SetMemory(0x662350 + (19*4), SetTo, (700000*256)/2);
		PreserveTrigger();
		}
}
Ov_BYD_E = CreateVar()
CMov(FP,0x6509B0,EPD(GunPtrMemory))
CWhile(FP,Memory(0x6509B0,AtMost,EPD(GunPtrMemory)+200))
CIf(FP,Deaths(CurrentPlayer,AtLeast,1,0))
Call_SaveCP()
CIf(FP,{TDeathsX(BackupCp,Exactly,_Mul(Ov_BYD,0x1000),0,0xF000)})
Trigger { -- No comment (00F60EE3)
	players = {FP},
	conditions = {
		Label(0);
		DeathsX(CurrentPlayer,Exactly,1*0x10000000,0,0xF0000000);
	},
	actions = {
		SetCVar(FP,Ov_BYD_E[2],Add,2);
		PreserveTrigger();
	},
	}


DoActionsX(FP,SetCVar(FP,Ov_BYD_E[2],Add,1))

CWhile(FP,CVar(FP,Ov_BYD_E[2],AtLeast,1),SetCVar(FP,Ov_BYD_E[2],Subtract,1))

CMov(FP,CPosX,_ReadF(BackupCP,0xFFF))
CMov(FP,CPosY,_Div(_ReadF(BackupCP,0xFFF0000),_Mov(65536)))

CDoActions(FP,{
TSetMemory(0x58DC60 + 0x14*23,SetTo,_Sub(CPosX,32*3)),
TSetMemory(0x58DC68 + 0x14*23,SetTo,_Add(CPosX,32*3)),
TSetMemory(0x58DC64 + 0x14*23,SetTo,_Sub(CPosY,32*3)),
TSetMemory(0x58DC6C + 0x14*23,SetTo,_Add(CPosY,32*3)),
Createunit(1,84,24,FP)
})

CIfX(CPlayer,{Switch("Switch 1",Set)})
CTrigger(CPlayer,{
	CVar(FP,Ov_BYD_Index[2],AtLeast,0),
	CVar(FP,Ov_BYD_Index[2],AtMost,1),
},{
	TCreateUnit(1,VArr(UArr1,_Mod(_Rand(),16)),24,7)
},1)
CTrigger(CPlayer,{
	CVar(FP,Ov_BYD_Index[2],AtLeast,2),
	CVar(FP,Ov_BYD_Index[2],AtMost,3),
},{
	TCreateUnit(1,VArr(UArr2,_Mod(_Rand(),16)),24,7)
},1)
CElseX()
CTrigger(CPlayer,{
	CVar(FP,Ov_BYD_Index[2],AtLeast,0),
	CVar(FP,Ov_BYD_Index[2],AtMost,1),
},{
	TCreateUnit(1,VArr(UArr2,_Mod(_Rand(),16)),24,7)
},1)
CTrigger(CPlayer,{
	CVar(FP,Ov_BYD_Index[2],AtLeast,2),
	CVar(FP,Ov_BYD_Index[2],AtMost,3),
},{
	TCreateUnit(1,VArr(UArr1,_Mod(_Rand(),16)),24,7)
},1)
CIfXEnd()

Trigger { -- No comment (00F60EE3)
	players = {FP},
	conditions = {
		Label(0);
	},
	actions = {
		Order("Men",7,24,Attack,5);
		PreserveTrigger();
	},
	}


CWhileEnd()

Call_LoadCp()
CIfEnd()
CAdd(FP,0x6509B0,1)
CWhileEnd()
CAdd(FP,0x6509B0,FP)
CIfEnd()

Trigger {
	players = {P6},
	conditions = {
		BYD;
		
},
	actions = {
		SetMemory(0x662350 + (102*4), SetTo, (2300000*256));
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256));
		SetMemory(0x662350 + (61*4), SetTo, (6666666*256));
		SetMemory(0x662350 + (67*4), SetTo, (4500000*256));
		
		
		SetMemory(0x662350 + (79*4), SetTo, (900000*256));
		SetMemory(0x662350 + (80*4), SetTo, (720000*256));
		SetMemory(0x662350 + (81*4), SetTo, (735000*256));
		SetMemory(0x662350 + (57*4), SetTo, (700000*256));
		SetMemory(0x662350 + (66*4), SetTo, (2500000*256));
		SetMemory(0x662350 + (19*4), SetTo, (700000*256));
		PreserveTrigger();
		}
}
DoActionsX(FP,SetCVar(FP,Ov_BYD[2],SetTo,0))
NIfEnd()



for i=0, 3 do -- CIf 0x60~0x63 EX2 20~23 L152~L155 Xelnaga
--XelNaga
CIndex = 0x60+i
CPlayer = 5
C = CCode(0x1002,20+i)
T = CCode(0x1003,20+i)
LocationID = 152+i
BdID = 175
BdIndex = CCode(0x1004,8)
Sw1Status1 = Cleared
Sw1Status2 = Set
if i == 0 then
	BdPlayer = 6
elseif i == 1 then
	BdPlayer = 7
elseif i == 2 then
	BdPlayer = 7
elseif i == 3 then
	BdPlayer = 6
end

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {BdPlayer},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv);
		KillUnit(13,P6);

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 500, T);
		BYD;
		},
	actions = {
		Order("Men",P7,64,Attack,5);
		Order("Men",P8,64,Attack,5);
		Order(29,P6,64,Attack,5);
		Order(102,P6,64,Attack,5);
},
}
CIfOnce(FP,{CDeaths("X", AtLeast, 500, T),BYD})
CSub(FP,0x58D6F4,_Div(_ReadF(0x58D6F4),_Mov(4)))

Trigger {
	players = {CPlayer},
	conditions = {
		},
	actions = {
		Order("Men",P7,64,Attack,5);
		Order("Men",P8,64,Attack,5);
		Order(29,P6,64,Attack,5);
		Order(102,P6,64,Attack,5);
},
}


CIfEnd()
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 500, T);
		},
	actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\Recall.ogg"),PlayWAVX("staredit\\wav\\Recall.ogg")},HumanPlayers,CPlayer);
		Order("Men",P7,LocationID+1,Attack,5);
		Order("Men",P8,LocationID+1,Attack,5);
		Order(29,P6,LocationID+1,Attack,5);
		Order(102,P6,LocationID+1,Attack,5);
		SetCDeaths("X",Add,1,C)
},
}


Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,4); -- ClearRate + 0.4%
		SetCDeaths(P6,Add,1,BdIndex);
		KillUnitAt(All, "【 Key 】",LocationID+1, AllPlayers);
},
}
DoActionsPX(SetCDeaths("X",Add,1,T),CPlayer)
NIfEnd()
end
function DGRatio()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CA_RatioXY(DGInfection,100,DGInfection,100)
end
function DGSpawnSet()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CA_RatioXY(DGInfection,100,DGInfection,100)

	CIf(FP,{CVar(FP,CA[8],AtMost,4096),CVar(FP,CA[9],AtMost,4096)})
		TriggerX(FP,{CDeaths("X", AtMost, 350, T)},{CreateUnit(1,84,24,P6)},{Preserved})
		CIf(FP,CDeaths("X", AtLeast, 351, T))
			DoActions(CPlayer,{CreateUnit(1,86,24,P8),CreateUnit(1,98,24,P8),Order(86,P8,24,Attack,LocationID-1),Order(98,P8,24,Attack,LocationID-1)})
			DoActions(CPlayer,{CreateUnit(1,8,24,P8),CreateUnit(1,102,24,P8),Order(8,P8,24,Attack,LocationID-1),Order(102,P8,24,Attack,LocationID-1)})
		CIfEnd()


	CIfEnd()
end
DGPlot = {}
for i = 0, 4 do
table.insert(DGPlot,CSMakePolygon(4+i,64*6,90,PlotSizeCalc(4+i,6),0))
end

for i=0, 1 do -- CIf 0x66~0x67 EX2 26~27 L184~L185 Daggoth
--DG
DGPos = {384,3712}
CIndex = 0x66+i
CPlayer = 5
C = CCode(0x1002,26+i)
T = CCode(0x1003,26+i)
LocationID = 184+i
BdID = 152
BdIndex = CCode(0x1004,10)
DGInfection = CreateVar()
DGSwitch = CreateVar()

if i == 0 then
	BdPlayer = 6
elseif i == 1 then
	BdPlayer = 7
end

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {BdPlayer},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths(P6, AtLeast, 2, Difficulty),CDeaths("X", AtLeast, 1, BdAv)})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtMost, 240, T);
		},
	actions = {
		CreateUnit(1,84,183+i,P6);
		KillUnit(84,P6);
		PreserveTrigger();
},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		BYD;
		CDeaths("X", AtLeast, 241, T);
		CDeaths("X", AtMost, 340, T);
		},
	actions = {
		SetCDeaths(FP,SetTo,20,CanCT);
		SetCVar(FP,DGInfection[2],Add,1);
		SetCVar(FP,DGSwitch[2],Add,1);
		PreserveTrigger();
},
}


CMov(CPlayer,N_A,0)
CWhile(CPlayer,{CDeaths("X", AtLeast, 240, T),CDeaths("X", AtMost, 340, T),CVar(FP,N_A[2],AtMost,359),NBYD})
f_lengthdir(CPlayer,_Mul(_Sub(_ReadF(_CCode(CPlayer,T)),240),20),N_A,N_X,N_Y)
CAdd(CPlayer,N_X,2048)
CAdd(CPlayer,N_Y,DGPos[i+1])

CIfX(CPlayer,{CVar(FP,N_X[2],AtMost,4096),CVar(FP,N_Y[2],AtMost,4096)})
Simple_SetLocX(CPlayer,23,_Add(N_X,-32),_Add(N_Y,-32),_Add(N_X,32),_Add(N_Y,32),{
	SetMemory(0x58F528,SetTo,1),
	CreateUnit(1,84,24,P6),
	KillUnit(84,P6)
})
CIfXEnd()

CAdd(CPlayer,N_A,5)
CWhileEnd()


CIfOnce(CPlayer,CDeaths("X", AtLeast, 390, T))
	CMov(CPlayer,IndexCheck,i)
	
	Trigger {
		players = {CPlayer},
		conditions = {
			
			},
		actions = {
			SetMemory(0x6624E8, SetTo, 81920000);
			PreserveTrigger();
			
	},
	}
	DoActions(CPlayer,{SetMemory(0x6CA010, SetTo, 1707)})
	CWhile(CPlayer,{CVar(FP,N_A[2],AtMost,359),NBYD})
		f_lengthdir(CPlayer,2000,N_A,N_X,N_Y)
		CAdd(CPlayer,N_X,2048)
		CAdd(CPlayer,N_Y,DGPos[i+1])
		
		CIf(CPlayer,{CVar(FP,N_X[2],AtMost,4096),CVar(FP,N_Y[2],AtMost,4096)})
			Simple_SetLocX(CPlayer,23,_Add(N_X,-32),_Add(N_Y,-32),_Add(N_X,32),_Add(N_Y,32))
			CIf(CPlayer,{CVar(FP,IndexCheck[2],Exactly,0)})
				
				CIf(CPlayer,Switch("Switch 1",Set))
					DoActions(CPlayer,{CreateUnit(1,86,24,P8),CreateUnit(1,98,24,P8),Order(86,P8,24,Attack,183+i),Order(98,P8,24,Attack,183+i)})
				CIfEnd()
				CIf(CPlayer,Switch("Switch 1",Cleared))
					DoActions(CPlayer,{CreateUnit(1,8,24,P8),CreateUnit(1,102,24,P8),Order(8,P8,24,Attack,183+i),Order(102,P8,24,Attack,183+i)})
				CIfEnd()
				
			CIfEnd()
				
			CIf(CPlayer,{CVar(FP,IndexCheck[2],Exactly,1)})
				
				CIf(CPlayer,Switch("Switch 1",Cleared))
					DoActions(CPlayer,{CreateUnit(1,86,24,P8),CreateUnit(1,98,24,P8),Order(86,P8,24,Attack,183+i),Order(98,P8,24,Attack,183+i)})
				CIfEnd()
				CIf(CPlayer,Switch("Switch 1",Set))
					DoActions(CPlayer,{CreateUnit(1,8,24,P8),CreateUnit(1,102,24,P8),Order(8,P8,24,Attack,183+i),Order(102,P8,24,Attack,183+i)})
				CIfEnd()
			
			CIfEnd()
			
		CIfEnd()
		CIfX(CPlayer,FTR)
			CAdd(CPlayer,N_A,2)
		CelseX()
			CAdd(CPlayer,N_A,4)
		CIfXEnd()
	CWhileEnd()
	DoActionsX(CPlayer,SetCDeaths("X",Add,1,C))
	CMov(FP,DGSwitch,1)
CIfEnd()


CAPlot(DGPlot,P6,181,23,{2048,DGPos[i+1]},1,256,{SetPlayers,0,0,0,9999,0},"DGRatio",CPlayer,
	{CVar(FP,DGSwitch[2],AtLeast,1),BYD},
	{},{SetCVar("X",DGSwitch[2],Subtract,1)},"DGSpawnSet")

	CIf(CPlayer,Switch("Switch 245",Cleared))
		DoActions(CPlayer,{SetMemory(0x6624E8, SetTo, 2300000*256),SetMemory(0x6CA010, SetTo, 640)})
	CIfEnd()
	CIf(CPlayer,Switch("Switch 245",Set))
		DoActions(CPlayer,{SetMemory(0x6624E8, SetTo, 1840000*256),SetMemory(0x6CA010, SetTo, 640)})
	CIfEnd()

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,15); -- ClearRate + 1.5%
		SetCDeaths(P6,Add,1,BdIndex);
},
}
DoActionsPX(SetCDeaths("X",Add,1,T),CPlayer)
NIfEnd()



end

for i=0, 3 do -- CIf 0x68~0x6B EX2 28~31 L166~L169 Gene
--Gene
CIndex = 0x68+i
CPlayer = 5
C = CCode(0x1002,28+i)
T = CCode(0x1003,28+i)
LocationID = 166+i
BdID = 200
BdIndex = CCode(0x1004,11)

GSY = CreateVar()
GSZ = CreateVar()
GSW = CreateVar()

if i == 0 then
	BdPlayer = 7
elseif i == 1 then
	BdPlayer = 7
elseif i == 2 then
	BdPlayer = 6
elseif i == 3 then
	BdPlayer = 6
end

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {BdPlayer},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths(P6, AtLeast, 2, Difficulty),CDeaths("X", AtLeast, 1, BdAv)})

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		RotatePlayer({PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOff.wav")},HumanPlayers,CPlayer);
		SetCDeaths(P6,Add,1,BdIndex);
		SetCDeaths(P6,SetTo,1000,GeneT);
		SetCVar(P6,ClearRate[2],Add,5); -- ClearRate + 0.5%
		--SetMemoryX(0x6616F4, SetTo, 120,0xFF);
		--SetMemoryX(0x661700, SetTo, 120,0xFF);
		--SetMemoryX(0x6636CC, SetTo, 120,0xFF);
		--SetMemoryX(0x6636D8, SetTo, 120,0xFF);
		--SetMemoryX(0x656F98, SetTo, 0*65536,0xFFFF0000);
		--SetMemoryX(0x657760, SetTo, 0*65536,0xFFFF0000);
		--SetMemoryX(0x656F9C, SetTo, 0*65536,0xFFFF0000);
		--SetMemoryX(0x657764, SetTo, 0*65536,0xFFFF0000);
		
},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,TestMode);
		CDeaths(P6, AtLeast, 1, GeneT);
		
		},
	actions = { 
		SetInvincibility(Enable,"Men",Force2,"Anywhere");
		PreserveTrigger();
},
}
function GeneRotate3D()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CA_Rotate3D(GSY,GSZ,GSW) -- XY : SY, YZ : SZ, ZX : SW 만큼 회전
end

DoActionsX(FP,{SetCVar("X",GSY[2],Add,-2),SetCVar("X",GSZ[2],Add,3),SetCVar("X",GSW[2],Add,-4)})
CAPlot({CSMakePolygon(3,128,90,4,0)},P6,84,LocationID,nil,1,32,{1,0,0,0,9999,0},"GeneRotate3D",CPlayer,{BYD},{},1)

Points = 3
SizeofPolygon = 1
Radius = 128
Angle = 90
CreateUnitPolygonSafe2Gun(CPlayer,{NBYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,1,P6,{1,84})
DoActionsP(KillUnit(84,P6),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths(P6, AtMost, 0, GeneT);
		
		},
	actions = {  
		RotatePlayer({PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")},HumanPlayers,CPlayer);
		SetCDeaths("X",Add,1,C);    
		SetInvincibility(Disable,"Men",Force2,"Anywhere");
		--SetMemoryX(0x6616F4, SetTo, 1,0xFF);
		--SetMemoryX(0x6636CC, SetTo, 1,0xFF);
		--SetMemoryX(0x661700, SetTo, 0,0xFF);
		--SetMemoryX(0x6636D8, SetTo, 0,0xFF);
		--SetMemoryX(0x656F98, SetTo, 1500*65536,0xFFFF0000);
		--SetMemoryX(0x657760, SetTo, 75*65536,0xFFFF0000);
		--SetMemoryX(0x656F9C, SetTo, 5000*65536,0xFFFF0000);
		--SetMemoryX(0x657764, SetTo, 100*65536,0xFFFF0000);
		
},
}
NIfEnd()
end
for i=0, 3 do -- CIf 0x6C~0x6F EX2 32~35 L186~L189 Temple
--Temple
CIndex = 0x6C+i
CPlayer = 5
C = CCode(0x1002,32+i)
T = CCode(0x1003,32+i)
LocationID = 186+i
BdID = 174
TemAngle = CreateVar()
TemX = CreateVar()
BdIndex = CCode(0x1004,12)
if i == 0 then
	BdPlayer = 7
elseif i == 1 then
	BdPlayer = 7
elseif i == 2 then
	BdPlayer = 6
elseif i == 3 then
	BdPlayer = 6
end

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {BdPlayer},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths(P6, AtLeast, 2, Difficulty),CDeaths("X", AtLeast, 1, BdAv)})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,10); -- ClearRate + 1.0%
		KillUnitAt(1,162,LocationID+1,Force2);
		SetCDeaths(P6,Add,1,BdIndex);
},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		Memory(0x59000C+(i*4),AtMost,0);
		
		},
	actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\Clock.ogg"),PlayWAVX("staredit\\wav\\Clock.ogg")},HumanPlayers,CPlayer);
		SetMemory(0x59000C+(i*4),SetTo,1000);
		SetCDeaths("X",Add,1,T);
		SetDeaths(P10,Add,1,CIndex);
		PreserveTrigger();
},
}
CSub(P6,0x59000C+(i*4),Dt)
Trigger { -- EUD Editor
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,GMode);
		NBYD;
		Deaths(P10,AtLeast,12,CIndex);
	},
	actions = {
		SetMemory(0x6624E8, SetTo, (588800000)/6);
	},
}


CAPlot(CSMakeLine(1,32,30,8,0),FP,84,LocationID,nil,1,32,{1,0,0,0,99,0},"TemRotate",FP,{BYD},nil,1)

for j = 1, 12 do
Points = 24
SizeofPolygon = 1
Radius = 32*8
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,j,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P6,{1,84})
Points = 1
Radius = 32
Angle = 270+(30*j)
CreateUnitLineSafeGun(CPlayer,{Label(0),NBYD,Deaths(P10,AtLeast,j,CIndex),CDeaths("X",Exactly,j,T)},8,LocationID,32,Radius,Angle,Points,0,P6,{1,84})
CreateUnitLineSafeGun(CPlayer,{Label(0),BYD,Deaths(P10,AtLeast,j,CIndex),CDeaths("X",Exactly,j,T)},8,LocationID,32,Radius,Angle,Points,0,P8,{1,8})
end
DoActionsP({KillUnit(84,P6)},CPlayer)
Points = 24
SizeofPolygon = 1
Radius = 85*3
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Deaths(P10,AtLeast,12,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P6,{1,102,1,84})
Points = 48
CreateUnitPolygonSafe2Gun(CPlayer,{BYD,Deaths(P10,AtLeast,12,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,98,1,86,1,84})
Points = 8
SizeofPolygon = 1
Radius = 85*1
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{FTRBYD,Deaths(P10,AtLeast,12,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,102,1,84})
Points = 16
SizeofPolygon = 1
Radius = 85*2
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Deaths(P10,AtLeast,12,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P6,{1,102,1,84})
Points = 24
SizeofPolygon = 1
Radius = 85*3
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Deaths(P10,AtLeast,12,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P6,{1,102,1,84})

DoActionsP({KillUnit(84,P6)},CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X",AtLeast,12,T);
		
		},
	actions = {
		SetLoc(LocationID,0,Subtract,32*6);
		SetLoc(LocationID,4,Subtract,32*6);
		SetLoc(LocationID,8,Add,32*6);
		SetLoc(LocationID,12,Add,32*7);
		SetMemory(0x6624E8, SetTo, 588800000);
		Order(102,P6,LocationID+1,Attack,LocationID+1);
		SetCDeaths("X",Add,1,C);
},
}


NIfEnd()
end
for i=0, 3 do -- CIf 0x70~0x73 EX2 36~39 L069~L072 Warp
--Warp
CIndex = 0x70+i
CPlayer = 5
C = CCode(0x1002,36+i)
T = CCode(0x1003,36+i)
LocationID = 69+i
BdID = 189
BdIndex = CCode(0x1004,13)
WarpMineXPos1 = {768,3328,768,3328}
WarpMineYPos1 = {768,768,3328,3328}
WarpMineXPos2 = {1792,2304,1792,2304}
WarpMineYPos2 = {1856,1856,2230,2230}
WarpBossIndex = {87,74,30,2}
BYDRandMineX = {0,2048,0,2048}
BYDRandMineY = {0,0,2048,2048}

if i == 0 then
	BdPlayer = 6
elseif i == 1 then
	BdPlayer = 7
elseif i == 2 then
	BdPlayer = 7
elseif i == 3 then
	BdPlayer = 6
end

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {BdPlayer},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})


Trigger {
	players = {CPlayer},    
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,4); -- ClearRate + 0.4%
		SetCDeaths(P6,Add,1,BdIndex);
},
}

Trigger {
	players = {CPlayer},
	conditions = {
		FTRBYD;
	},
	actions = {
		SetLoc(23,0,SetTo,WarpMineXPos1[i+1]);
		SetLoc(23,8,SetTo,WarpMineXPos1[i+1]);
		SetLoc(23,4,SetTo,WarpMineYPos1[i+1]);
		SetLoc(23,12,SetTo,WarpMineYPos1[i+1]);
		CreateUnit(4,13,24,P7);
	}
}

WarpUnitTable1 = {25,10,66,52}
WarpUnitTable2 = {21,57,80,29}

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 13400, T);
		
		},
	actions = {
		SetLoc(23,0,SetTo,2048);
		SetLoc(23,4,SetTo,2048);
		SetLoc(23,8,SetTo,2048);
		SetLoc(23,12,SetTo,2048);
		SetDeaths(P10,Add,1,CIndex);
		
},
}
Points = 6
SizeofPolygon = 4
Radius = 128
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,1,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P8,{1,WarpUnitTable1[i+1],1,WarpUnitTable2[i+1]})
Points = 4
SizeofPolygon = 1
Radius = 64
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,Deaths(P10,AtLeast,1,CIndex),1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),LocationID,32,Radius,Angle,Points,0,P8,{1,13})
Trigger {
	players = {CPlayer},
	conditions = {
		FTR;
		Deaths(P10,AtLeast,1,CIndex);
	},
	actions = {
		SetLoc(23,0,SetTo,WarpMineXPos2[i+1]);
		SetLoc(23,8,SetTo,WarpMineXPos2[i+1]);
		SetLoc(23,4,SetTo,WarpMineYPos2[i+1]);
		SetLoc(23,12,SetTo,WarpMineYPos2[i+1]);
		
	}
}

CIfOnce(FP,{BYD,Deaths(P10,AtLeast,1,CIndex)})
CMov(FP,RandMineW,0)
CWhile(FP,CVar(FP,RandMineW[2],AtMost,100),SetCVar(FP,RandMineW[2],Add,1))
CMov(FP,BYDMineX,_Mod(_Rand(),4096))
CMov(FP,BYDMineY,_Mod(_Rand(),4096))

CWhile(FP,{
CVar(FP,BYDMineX[2],AtLeast,BYDRandMineX[i+1]),
CVar(FP,BYDMineX[2],AtMost,BYDRandMineX[i+1]+2048),
CVar(FP,BYDMineY[2],AtLeast,BYDRandMineY[i+1]),
CVar(FP,BYDMineY[2],AtMost,BYDRandMineY[i+1]+2048)})
CMov(FP,BYDMineX,_Mod(_Rand(),4096))
CMov(FP,BYDMineY,_Mod(_Rand(),4096))


CWhileEnd()

Simple_SetLocX(CPlayer,23,BYDMineX,BYDMineY,BYDMineX,BYDMineY,{CreateUnit(1,13,24,P6)})
CWhileEnd()
CIfEnd()
Points = 4
SizeofPolygon = 1
Radius = 64
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{Deaths(P10,AtLeast,1,CIndex),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,0,P8,{1,13})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 13400, T);
		
		},
	actions = {
		SetInvincibility(Disable,"Men",P12,66+i);
		GiveUnits(All,WarpBossIndex[i+1],P12,153+i,P6);
		SetCDeaths("X",Add,1,C);
		
},
}
CDoActions(CPlayer,{TSetCDeaths("X",Add,Dt,T)})
NIfEnd()
end

			  -- CIf 0x64~0x65 EX2 24~25 L178~L179 OverC
				
CIndex = 0x64
CPlayer = 5
C = CCode(0x1002,24)
T = CCode(0x1003,24)
LocationID = 178
BdID = 201
BdIndex = CCode(0x1004,9)
Sw1Status1 = Cleared
Sw1Status2 = Set

BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {P7},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtMost, 500, T);
		},
	actions = {
		KillUnitAt(All,125,179,Force1);
		PreserveTrigger();
},
}
Trigger {
	players = {CPlayer},
	actions = {
		SetLoc(LocationID,0,Subtract,2);
		SetLoc(LocationID,8,Add,2);
		SetLoc(LocationID,12,Add,2);
		PreserveTrigger();
},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths(P6, AtMost, 0, RecallT1);
		},
	actions = {
		RunAIScriptAt("Recall Here",181);
		Order("Men",Force1,LocationID+1,Move,181);
		SetCDeaths(P6,Add,30,RecallT1);
		PreserveTrigger();
},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,GMode);
		
},
	actions = {
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256)/6);
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256)/6);
		
		
		}
}

DoActionsPX(SetCDeaths(P6,Subtract,1,RecallT1),CPlayer)
Points = 4
SizeofPolygon = 1
Radius = 128
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P8,{1,23})
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P8,{1,23})
Points = 4
SizeofPolygon = 2
Radius = 96
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P8,{1,23})
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P8,{1,23})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256));
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256));
		Order(23,P8,160,Attack,181);
		Order(68,P8,160,Attack,181);
		Order(23,P8,161,Attack,181);
		Order(68,P8,161,Attack,181);
		SetCDeaths(P6,Add,1,BdIndex);
		SetCVar(P6,ClearRate[2],Add,20); -- ClearRate + 2.0%
		CreateUnit(1,"Map Revealer",181,Force1);
		SetCountdownTimer(Add,180);
},
}

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 1500, T);
		},
	actions = {
		SetCDeaths("X",Add,1,C);
		KillUnit("Map Revealer",Force1);
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256)/6);
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256)/6);
		SetSwitch("Switch 205",Set);
},
}
Points = 6
SizeofPolygon = 4
Radius = 128
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 205",Set),Switch("Switch 1",Sw1Status1),BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 205",Set),Switch("Switch 1",Sw1Status2),BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,{1,23})

DoActionsPX({SetCDeaths("X",Add,1,T),SetSwitch("Switch 205",Clear),
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256));
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256));
},CPlayer)
NIfEnd()
--OverC
CIndex = 0x65
CPlayer = 5
C = CCode(0x1002,25)
T = CCode(0x1003,25)
LocationID = 179
BdID = 201
BdIndex = CCode(0x1004,9)
Sw1Status1 = Set
Sw1Status2 = Cleared
BdAv = CreateCCode(ExDeaths1)
Trigger {
	players = {P8},
	conditions = {
		Label(0);
		CommandLeastAt(BdID,LocationID+1);

		},
	actions = {
		SetCDeaths(FP,Add,1,BdAv)

},
}
NIf(CPlayer,{CDeaths("X", AtMost, 0, C),CDeaths("X", AtLeast, 1, BdAv)})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtMost, 500, T);
		},
	actions = {
		KillUnitAt(All,125,180,Force1);
		PreserveTrigger();
},
}
Trigger {
	players = {CPlayer},
	actions = {
		SetLoc(LocationID,0,Subtract,2);
		SetLoc(LocationID,4,Subtract,2);
		SetLoc(LocationID,8,Add,2);
		PreserveTrigger();
},
}
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths(P6, AtMost, 0, RecallT2);
		},
	actions = {
		RunAIScriptAt("Recall Here",182);
		Order("Men",Force1,LocationID+1,Move,182);
		SetCDeaths(P6,Add,30,RecallT2);
		PreserveTrigger();
},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,2,GMode);
		
},
	actions = {
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256)/6);
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256)/6);
		
		
		}
}
DoActionsPX(SetCDeaths(P6,Subtract,1,RecallT2),CPlayer)
Points = 4
SizeofPolygon = 1
Radius = 128
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P8,{1,23})
CreateUnitPolygonSafe2Gun(CPlayer,{HD,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P8,{1,23})
Points = 4
SizeofPolygon = 2
Radius = 128
Angle = 45
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P8,{1,23})
CreateUnitPolygonSafe2Gun(CPlayer,{FTR,Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P8,{1,23})
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256));
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256));
		Order(23,P8,158,Attack,182);
		Order(68,P8,158,Attack,182);
		Order(23,P8,159,Attack,182);
		Order(68,P8,159,Attack,182);
		SetCDeaths(P6,Add,1,BdIndex);
		SetCVar(P6,ClearRate[2],Add,20); -- ClearRate + 2.0%
		CreateUnit(1,"Map Revealer",182,Force1);
		SetCountdownTimer(Add,180);
},
}

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 1500, T);
		},
	actions = {
		SetCDeaths("X",Add,1,C);
		KillUnit("Map Revealer",Force1);
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256)/6);
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256)/6);
		SetSwitch("Switch 205",Set);
},
}
Points = 6
SizeofPolygon = 4
Radius = 128
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 205",Set),Switch("Switch 1",Sw1Status1),BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,{1,68})
CreateUnitPolygonSafe2Gun(CPlayer,{Switch("Switch 205",Set),Switch("Switch 1",Sw1Status2),BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,{1,23})

DoActionsPX({SetCDeaths("X",Add,1,T),SetSwitch("Switch 205",Clear),
		SetMemory(0x662350 + (23*4), SetTo, (5672310*256));
		SetMemory(0x662350 + (68*4), SetTo, (8000000*256));
},CPlayer)
NIfEnd()

CIfEnd()--건작함수 끝

--WhiteHole
CIndex = 0x90
CPlayer = 5
C = CCode(0x1002,40)
T = CCode(0x1003,40)
CoreSwitch = CreateCCode(ExDeaths1)
BdID = 190
CIf(CPlayer,{CVar(P6,Dis_1[2],AtMost,0),CVar(P6,Dis_2[2],AtMost,0),CDeaths("X", AtMost, 0, C),CDeaths(P6, AtLeast, 1, CoreAccept),CDeaths(P6, AtLeast, 2, Difficulty)})
Trigger { -- remove pause
 players = {CPlayer},
 conditions = {
	Label(0);
 },
 actions = {
  Comment("remove pause");
  SetMemory(0x58D718, SetTo, 0x00000000);
  SetMemory(0x58D71C, SetTo, 0x00000000);
  SetCDeaths(FP,Add,1,BYDAttackUpgrade);
 },
}

	GText = "\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 심층부 \x10【 Ｃ\x04ｏｒｅ　ｏｆ　\x10Ｄ\x04ｅｐｔｈ \x10】 \x04를 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x06０６．０\x04％ 〓\n\n\n\n"
Trigger {
	players = {CPlayer},
		conditions = {
		Label(0);
			},
	actions = {
		RotatePlayer({DisplayTextX(GText,4)},HumanPlayers,CPlayer);
		},
	}
function SetBrightnessForBYD(Time,Value)
Trigger {
	players = {CPlayer},
		conditions = {
		BYD;
		Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-Time)
			},
	actions = {
		SetMemory(0x657A9C,SetTo,Value)
		},
	}
end
Trigger {
	players = {CPlayer},
		conditions = {
		BYD;
			},
	actions = {
		SetMemory(0x657A9C,SetTo,0)
		},
	}
SetBrightnessForBYD(15780,31)
SetBrightnessForBYD(23360,15)
SetBrightnessForBYD(30940,31)
SetBrightnessForBYD(31570,23)
SetBrightnessForBYD(31650,17)
SetBrightnessForBYD(31730,15)
SetBrightnessForBYD(32520,5)
SetBrightnessForBYD(32840,31)
SetBrightnessForBYD(65050,27)
SetBrightnessForBYD(68840,24)
SetBrightnessForBYD(70730,31)


SetBrightnessForBYD(76420,25)
SetBrightnessForBYD(77360,20)
SetBrightnessForBYD(78310,15)
SetBrightnessForBYD(79260,10)
SetBrightnessForBYD(80210,31)






SetBrightnessForBYD(109570,27)
SetBrightnessForBYD(110210,24)
SetBrightnessForBYD(110420,21)
SetBrightnessForBYD(110630,17)
SetBrightnessForBYD(110840,15)
SetBrightnessForBYD(111360,10)
for i = 0, 31 do
SetBrightnessForBYD(111780 + (i*19),31-i)
end
SetBrightnessForBYD(112420,31)


Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,ClearRate[2],Add,60); -- ClearRate + 6.0%
		SetCDeaths(P6,SetTo,5,BGMType);
		SetMemory(0x58F550,SetTo,1);
		SetInvincibility(Disable,125,AllPlayers,"Anywhere");
		RemoveUnit("Map Revealer",P6);
},
}
DoActionsX(FP,SetCVar(FP,XY[2],Add,1))

Points = 6
SizeofPolygon = 5
Radius = 128
Angle = 0
CreateUnitPolygonSafe2GunMove(CPlayer,{HD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-15780)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,25,1,21})
CreateUnitPolygonSafe2GunMove(CPlayer,{HD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-23360)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,77,1,88})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{FTRBYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-15780)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,25,1,21})
CreateUnitPolygonSafe2GunMove(CPlayer,{FTRBYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-23360)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,77,1,88})
--Points = 6
--SizeofPolygon = 6
--Radius = 96
--Angle = 0
--SizeofPolygon = 0
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141470)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--SizeofPolygon = 2
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-31570)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141550)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--SizeofPolygon = 4
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-31650)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141630)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--SizeofPolygon = 6
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-30940)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-31730)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-112420)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141710)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
--CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-142730)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})

TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141470)},{SetCVar(FP,ObPlotVar[2],SetTo,1)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-31570)},{SetCVar(FP,ObPlotVar[2],SetTo,2)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141550)},{SetCVar(FP,ObPlotVar[2],SetTo,2)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-31650)},{SetCVar(FP,ObPlotVar[2],SetTo,3)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141630)},{SetCVar(FP,ObPlotVar[2],SetTo,3)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-30940)},{SetCVar(FP,ObPlotVar[2],SetTo,4)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-31730)},{SetCVar(FP,ObPlotVar[2],SetTo,4)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-112420)},{SetCVar(FP,ObPlotVar[2],SetTo,4)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-141710)},{SetCVar(FP,ObPlotVar[2],SetTo,4)})
TriggerX(FP,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-142730)},{SetCVar(FP,ObPlotVar[2],SetTo,4)})
TriggerX(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-65050)},{SetCVar(FP,ObPlotVar[2],SetTo,4),CreateUnit(1,193,6,P6),Order(193,P6,6,Move,15)}) -- Alive
TriggerX(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-68840)},{SetCVar(FP,ObPlotVar[2],SetTo,4),CreateUnit(1,192,7,P6),Order(192,P6,7,Move,14)}) -- Death
TriggerX(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-70730)},{SetCVar(FP,ObPlotVar[2],SetTo,4)}) -- 
Trigger2(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-76420)},{CreateUnit(1,191,29,P6),Order(191,P6,29,Move,64)}) -- ＳＩＮ？
Trigger2(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-77360)},{Order(193,P6,64,Move,64),Order(192,P6,64,Move,64)})
CreateUnitLineSafeGun(CPlayer,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-79260)},32,190,32,32,0,2,0,P6,{1,84})
TriggerX(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-76420)},{SetCVar(FP,ObPlotVar[2],SetTo,1)})
TriggerX(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-77360)},{SetCVar(FP,ObPlotVar[2],SetTo,2)})
TriggerX(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-78310)},{SetCVar(FP,ObPlotVar[2],SetTo,3)})
TriggerX(FP,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-80210)},{SetCVar(FP,ObPlotVar[2],SetTo,4),KillUnit(191,P6),KillUnit(192,P6),KillUnit(193,P6)}) -- 




CreateUnitLineSafeGun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-32520)},32,190,32,32,0,2,0,P6,{1,84})

MusicVarTable = {63150,63310,63630,63940,64100,64260,64570,64890,65050}
for i=0, 8 do
Points = 2
SizeofPolygon = 1
Radius = 128+(i*32)
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-MusicVarTable[i+1])},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
end
MusicVarTable2 = {66940,67420,67730,67890,68210,68520,68840}

for i=0, 6 do
Points = 2
SizeofPolygon = 1
Radius = 128+((6-i)*32)
Angle = 0
CreateUnitPolygonSafe2Gun(CPlayer,{BYD,Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-MusicVarTable2[i+1])},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})

end
for i=0, 8 do
Points = 2
SizeofPolygon = 1
Radius = 128+(i*32)
Angle = 0

CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(185*1000)-(141780+(40*i)))},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
end
function S2_CAfunc2()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CA_Rotate3D(SY,SZ,SW) -- XY : SY, YZ : SZ, ZX : SW 만큼 회전
end
ObPlot = {}
for i = 0, 3 do
	table.insert(ObPlot,CSMakePolygon(6,96,0,PlotSizeCalc(6,2*i),1))
end
CAPlot(ObPlot,FP,84,190,nil,1,32,{ObPlotVar,0,0,0,9999,0},"S2_CAfunc2",FP,{CVar(FP,ObPlotVar[2],AtLeast,1)},nil,{SetCVar(FP,ObPlotVar[2],SetTo,0)})
DoActionsP(KillUnit(84,P6),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);

		Memory(0x58F494,AtMost,(185*1000)-32840);
		
		},
	actions = {
		SetCDeaths("X",Add,1,T);
		PreserveTrigger();
		
},
}

Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 2, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,1,CoreSwitch);
		
},
}
Angle = 0
Points = 6
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,78,1,28})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,78,1,28})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,78,1,28})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,78,1,28})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,78,1,28})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,78,1,28})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,2,CoreSwitch);
		
},
}

SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,76,1,57})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,76,1,57})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,76,1,57})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,76,1,57})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,76,1,57})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,76,1,57})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*2, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,3,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,81,1,86})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,81,1,86})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,81,1,86})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,81,1,86})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,81,1,86})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,81,1,86})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*3, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,4,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,29})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,29})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,29})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,29})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,75,1,29})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,75,1,29})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*4, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,5,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,79,1,88})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,79,1,88})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,79,1,88})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,79,1,88})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,79,1,88})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,79,1,88})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*5, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,6,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,17,1,8})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,17,1,8})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,17,1,8})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,17,1,8})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,17,1,8})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,17,1,8})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*6, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,7,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,80})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,80})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,80})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,75,1,80})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,75,1,80})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,75,1,80})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*7, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,8,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,52,1,28})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,52,1,28})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,52,1,28})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,52,1,28})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,52,1,28})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,52,1,28})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*8, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,9,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,10,1,98})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,10,1,98})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,10,1,98})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,10,1,98})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,10,1,98})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,10,1,98})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*9, T);
		
		},
	actions = {
		SetSwitch("Switch 255",Set);SetCDeaths(FP,SetTo,10,CoreSwitch);
		
},
}
SizeofPolygon = 1
Radius = 64
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),65,32,Radius,Angle,Points,0,P6,4,Attack,{1,19,1,29})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),66,32,Radius,Angle,Points,0,P6,4,Attack,{1,19,1,29})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),67,32,Radius,Angle,Points,0,P6,4,Attack,{1,19,1,29})
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),68,32,Radius,Angle,Points,0,P6,4,Attack,{1,19,1,29})
SizeofPolygon = 5
Radius = 128
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,19,1,29})
SizeofPolygon = 6
Radius = 96
CreateUnitPolygonSafe2GunMove(CPlayer,{Switch("Switch 255",Set),FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P8,4,Attack,{1,19,1,29})
DoActionsP(SetSwitch("Switch 255",Clear),CPlayer)
DoActionsP({SetDeaths(P10,Subtract,1,CIndex)},CPlayer)
CreateUnitPolygonSafe2Gun(CPlayer,{Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,500)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
DoActionsP(KillUnit(84,P6),CPlayer)
Trigger {
	players = {CPlayer},
	conditions = {
		Label(0);
		CDeaths("X", AtLeast, 550*10, T);
		Memory(0x58F494,AtMost,0);
		
		},
	actions = {
		SetCDeaths("X",Add,1,C);
		SetMemory(0x58F550,SetTo,0);
		
},
}
CIfEnd()
CIf(FP,Memory(0x58F550,AtLeast,1))
function S2_CAfunc()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CA_RatioXY(XY,7500,XY,7500)
	CA_Rotate3D(SY,SZ,SW) -- XY : SY, YZ : SZ, ZX : SW 만큼 회전
end
function RecallHere()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CIf(FP,Memory(0x628438,AtLeast,1))
	f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
	CDoActions(FP,{
	CreateUnit(1,71,21,P6);
	TSetMemory(_Add(Nextptrs,0x58/4),SetTo,_Add(V(CA[8]),_Mul(V(CA[9]),65536))),
	TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,137*256,0xFF00)})
	CIfEnd()
	CIf(FP,CDeaths(FP,Exactly,2,B7_Ph))
	DoActionsX(FP,{CreateUnitWithProperties(1,128,191,P6,{hitpoint = 50})})
	CIfEnd()

end
BackupXY = CreateVar()
CIfOnce(FP,CDeaths(FP,Exactly,2,B7_Ph))
CMov(FP,BackupXY,XY)
CMov(FP,XY,0)
CIfEnd()
CTrigger(FP,{CDeaths(FP,Exactly,2,B7_Ph),TCVar(FP,XY[2],AtMost,BackupXY)},{SetCVar(FP,XY[2],Add,100)},1)

function CoreSpawnSet()
	local SpawnSet = {78, 76, 81, 75, 79, 17, 75, 52, 10, 19} 
	local SpawnSet2 = {28, 57, 86, 29, 88, 8, 80, 22, 98, 29} 
	for i = 1, 10 do
		TriggerX(FP,{CDeaths(FP,Exactly,i,CoreSwitch)},{CreateUnit(1,SpawnSet[i],191,P8),CreateUnit(1,SpawnSet2[i],191,P8),Order("Men",Force2,191,Attack,5)},{Preserved})
	end
end

S1 = CSMakePolygon(6,350,0,7,1)
S3 = CSMakePolygon(3,350,0,4,1)
DoActionsX(FP,{SetCVar("X",SY[2],Add,2),SetCVar("X",SZ[2],Add,3),SetCVar("X",SW[2],Add,4)})
DoActions(FP,{SetMemoryX(0x666458, SetTo, 391,0xFFFF),RemoveUnit(71,P6),})
RecallSpriteShape = CreateVar()
DoActionsX(FP,SetCVar(FP,RecallSpriteShape[2],SetTo,1),1)
TriggerX(FP,{CDeaths(FP,Exactly,2,B7_Ph)},{SetCVar(FP,RecallSpriteShape[2],SetTo,2)})
CAPlot({S1,S3},FP,181,190,nil,1,1,{RecallSpriteShape,0,0,0,9999,0},"S2_CAfunc",FP,nil,nil,{RemoveUnit(33,FP),SetCDeaths(FP,Subtract,4,EffT)},"RecallHere")
Trigger2(FP,{NBYD},{SetMemoryX(0x666458, SetTo, 546,0xFFFF)},{Preserved})
S2 = CSMakePolygon(6,96,0,PlotSizeCalc(6,6),1)
CAPlot(S2,P8,181,190,nil,1,32,{1,0,0,0,9999,0},"S2_CAfunc2",FP,{CDeaths(FP,AtLeast,1,CoreSwitch),BYD},nil,{SetCDeaths(FP,SetTo,0,CoreSwitch)},"CoreSpawnSet")

DoActionsX(FP,{SetCDeaths(FP,Add,1,EffT)})
TriggerX(FP,{NBYD},{SetCDeaths(FP,SetTo,10,EfFT)},{Preserved})
CIfEnd()

CIndex = 0x91
CIf(P6,{NBYD,Command(P6,AtLeast,1,64)})
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Memory(0x58F494,AtMost,60000-11250);
	},
	actions = {
		SetInvincibility(Disable,64,P6,"Anywhere");
		SetAllianceStatus(Force1,Enemy);
		SetDeaths(8,Add,1,64);
		SetDeaths(P10,Add,1,CIndex);
		SetCDeaths(P6,Add,1,Boss1Start);
		
	}
}
Trigger {
	players = {P6},
	conditions = {
		Bring(P7,AtLeast,1,"Men",5);
	},
	actions = {
		SetInvincibility(Enable,64,P6,"Anywhere");
		PreserveTrigger();
	}
}
Trigger {
	players = {P6},
	conditions = {
		Bring(P8,AtLeast,1,"Men",5);
	},
	actions = {
		SetInvincibility(Enable,64,P6,"Anywhere");
		PreserveTrigger();
	}
}
Trigger {
	players = {P6},
	conditions = {
		Memory(0x58F494,AtMost,60000-11250);
		Bring(P7,AtMost,0,"Men",5);
		Bring(P8,AtMost,0,"Men",5);
	},
	actions = {
		SetInvincibility(Disable,64,P6,"Anywhere");
		PreserveTrigger();
	}
}

Points = 4
SizeofPolygon = 1
Radius = 128
Angle = 45
CreateUnitPolygonSafe2GunMove(P6,{Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),60,32,Radius,Angle,Points,1,P8,4,Attack,{1,25,1,77,1,78,1,88,1,75,1,76,1,84})
CreateUnitPolygonSafe2GunMove(P6,{Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),61,32,Radius,Angle,Points,1,P8,4,Attack,{1,25,1,77,1,78,1,88,1,75,1,76,1,84})
CreateUnitPolygonSafe2GunMove(P6,{Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),62,32,Radius,Angle,Points,1,P8,4,Attack,{1,25,1,77,1,78,1,88,1,75,1,76,1,84})
CreateUnitPolygonSafe2GunMove(P6,{Deaths(P10,AtLeast,2,CIndex)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),64,32,Radius,Angle,Points,1,P8,4,Attack,{1,25,1,77,1,78,1,88,1,75,1,76,1,84})
Points = 6
Radius = 96
Angle = 0
SizeofPolygon = 6
CreateUnitPolygonSafe2Gun(P6,{Bring(P6,AtLeast,1,64,194),Memory(0x58F494,AtLeast,1),Memory(0x58F494,AtMost,(60*1000)-8450)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),190,32,Radius,Angle,Points,0,P6,{1,84})
Trigger {
	players = {P6},
	conditions = {
		Bring(P6,AtLeast,1,64,194);
		Memory(0x58F494,AtLeast,1);
		Memory(0x58F494,AtMost,(60*1000)-8450);
	},
	actions = {
		KillUnit(125,AllPlayers);
	}
}

DoActionsP({KillUnit(84,Force2)},P6)
Trigger {
	players = {P6},
	conditions = {
		Deaths(P10,AtLeast,2,CIndex)
	},
	actions = {
		SetDeaths(P10,SetTo,0,CIndex);
		PreserveTrigger();
	}
}
CIfEnd()


for i = 1, 11 do
Trigger { -- No comment (147F3623)
	players = {Force1},
	conditions = {
		Kills(CurrentPlayer,AtLeast,i,"Mineral Field (Type 1)");
	},
	actions = {
		SetScore(CurrentPlayer,Add,70000,Kills);
	},
}
Trigger { -- No comment (147F3623)
	players = {Force1},
	conditions = {
		Kills(CurrentPlayer,AtLeast,i,"Mineral Field (Type 2)");
	},
	actions = {
		SetScore(CurrentPlayer,Add,70000,Kills);
	},
}
Trigger { -- No comment (147F3623)
	players = {Force1},
	conditions = {
		Kills(CurrentPlayer,AtLeast,i,"Mineral Field (Type 3)");
	},
	actions = {
		SetScore(CurrentPlayer,Add,70000,Kills);
	},
}
end


CIf(P6,CDeaths(P6,AtLeast,1,LimitX)) -- 치트모드


Trigger { -- 컴퓨터 플레이어 색상 설정
	players = {P6},
	conditions = {
		Deaths(P1,AtLeast,1,202);
	},
	actions = {
		--RunAIScriptAt("Recall Here",64);
		
		PreserveTrigger();
},
}



Trigger { -- 치트모드 자환
	players = {P6},
	actions = {
		SetDeaths(Force1,SetTo,1,111);
		PreserveTrigger();
	}
}
ETime = 180
EText = "\x13\x07테스트 모드 \x04특전! 모든 \x1D【 F\x04enix \x1DZ 】\x04를 끌어당깁니다.\n\x13\x0430초 뒤, 다음 영웅을 끌어당깁니다."
Trigger { -- 치트모드 모든영웅끌당
	players = {P6},
	conditions = {
		ElapsedTime(AtLeast,ETime);  
	},
	actions = {
		RotatePlayer({
			DisplayTextX(EText,4),
			PlayWAVX("staredit\\wav\\Recall.ogg"),
			PlayWAVX("staredit\\wav\\Recall.ogg")
		},HumanPlayers,FP);
		Order("【 Fenix Z 】",P7,64,Move,64);
		ModifyUnitHitPoints(All,"Men",P7,"Anywhere",1);
	}
}
EText = "\x13\x07테스트 모드 \x04특전! 모든 \x1D【 F\x04enix \x1DD 】\x04를 끌어당깁니다.\n\x13\x0430초 뒤, 다음 영웅을 끌어당깁니다."
Trigger { -- 치트모드 모든영웅끌당
	players = {P6},
	conditions = {
		ElapsedTime(AtLeast,ETime+30);  
	},
	actions = {
		RotatePlayer({
			DisplayTextX(EText,4),
			PlayWAVX("staredit\\wav\\Recall.ogg"),
			PlayWAVX("staredit\\wav\\Recall.ogg")
		},HumanPlayers,FP);
		Order("【 Fenix D 】",P7,64,Move,64);
	}
}
EText = "\x13\x07테스트 모드 \x04특전! 모든 유닛을 끌어당깁니다.\n\x13\x0430초 뒤, 한번 더 끌어당깁니다."
Trigger { -- 치트모드 모든영웅끌당
	players = {P6},
	conditions = {
		ElapsedTime(AtLeast,ETime+60);  
	},
	actions = {
		RotatePlayer({
			DisplayTextX(EText,4),
			PlayWAVX("staredit\\wav\\Recall.ogg"),
			PlayWAVX("staredit\\wav\\Recall.ogg")
		},HumanPlayers,FP);
		Order("Men",P7,64,Move,64);
	}
}
EText = "\x13\x07테스트 모드 \x04특전! 모든 유닛을 끌어당깁니다.\n\x13\x04모든 유닛 끌어당기기를 종료합니다."
Trigger { -- 치트모드 모든영웅끌당
	players = {P6},
	conditions = {
		ElapsedTime(AtLeast,ETime+90);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(EText,4),
			PlayWAVX("staredit\\wav\\Recall.ogg"),
			PlayWAVX("staredit\\wav\\Recall.ogg")
		},HumanPlayers,FP);
		Order("Men",P7,64,Move,64);
	}
}
CIfEnd() -- 치트모드 끝
HPoint = 100000
HIndex = 172
HText = "\x13\x1D† \x04포인트 상자를 획득했습니다. \x1F+ "..HPoint.." \x1CＰｔｓ \x1D†\n"
for i = 1, 4 do
Trigger { -- 포인트상자
	players = {P6},
	conditions = {
		Deaths(P7, AtLeast,i,HIndex);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(HText,4)
		},HumanPlayers,FP);
		SetScore(Force1,Add,HPoint,Kills);
	},
}
end
-- 공통단락

function DisplayCTextToAll(Player,conditions,Actions,Text,RotateActions,RotatePlayers,Flag)
	local Y = {Actions}
	local Z = {RotateActions}
	local A = {}
	table.insert(A,DisplayTextX(UnivToString,4))
	for j, y in pairs(RotateActions) do
		table.insert(A,y)
	end

	if Flag == 1 then
		CIf(Player,conditions)
	else
		CIfOnce(Player,conditions)
	end

	f_MemCpy(Player,UnivStrPtr,_TMem(Arr(Text[3],0),"X","X",1),Text[2])
	DoActionsX(Player,{
			RotatePlayer(A,RotatePlayers,Player),Y
	})
	f_MemCpy(P6,UnivStrPtr,_TMem(Arr(StrReset[3],0),"X","X",1),StrReset[2])
	CIfEnd()
end
DisplayCTextToAll(FP,{
	CDeaths(P6,AtLeast,2,CCode(0x1000,0));
	CDeaths(P6,AtLeast,2,CCode(0x1000,24));
	CDeaths(P6,AtLeast,2,CCode(0x1000,9));
	CDeaths(P6,AtLeast,2,CCode(0x1000,58));
	CDeaths(P6,AtLeast,2,CCode(0x1000,44));
	CDeaths(P6,AtLeast,2,CCode(0x1000,34));
	CDeaths(P6,AtLeast,2,CCode(0x1000,16));
	CDeaths(P6,AtLeast,2,CCode(0x1000,17));
	CDeaths(P6,AtLeast,2,CCode(0x1000,1));
	CDeaths(P6,AtLeast,2,CCode(0x1000,25));
	CDeaths(P6,AtLeast,2,CCode(0x1000,54));
	CDeaths(P6,AtLeast,2,CCode(0x1000,55));
	CDeaths(P6,AtLeast,2,CCode(0x1000,40));
	CDeaths(P6,AtLeast,2,CCode(0x1000,41));
	CDeaths(P6,AtLeast,2,CCode(0x1000,31));
},{
	SetInvincibility(Disable,189,Force2,72);
},WDWarpT,{
	MinimapPing(72),
	PlayWAVX("staredit\\wav\\start.ogg"),
},HumanPlayers)

DisplayCTextToAll(FP,{
	CDeaths(P6,AtLeast,2,CCode(0x1000,2));
	CDeaths(P6,AtLeast,2,CCode(0x1000,26));
	CDeaths(P6,AtLeast,2,CCode(0x1000,8));
	CDeaths(P6,AtLeast,2,CCode(0x1000,59));
	CDeaths(P6,AtLeast,2,CCode(0x1000,45));
	CDeaths(P6,AtLeast,2,CCode(0x1000,35));
	CDeaths(P6,AtLeast,2,CCode(0x1000,18));
	CDeaths(P6,AtLeast,2,CCode(0x1000,19));
	CDeaths(P6,AtLeast,2,CCode(0x1000,3));
	CDeaths(P6,AtLeast,2,CCode(0x1000,27));
	CDeaths(P6,AtLeast,2,CCode(0x1000,52));
	CDeaths(P6,AtLeast,2,CCode(0x1000,53));
	CDeaths(P6,AtLeast,2,CCode(0x1000,42));
	CDeaths(P6,AtLeast,2,CCode(0x1000,43));
	CDeaths(P6,AtLeast,2,CCode(0x1000,30));
},{
		SetInvincibility(Disable,189,Force2,71);
},EUWarpT,{
	MinimapPing(71),
	PlayWAVX("staredit\\wav\\start.ogg")
},HumanPlayers)

DisplayCTextToAll(FP,{
	CDeaths(P6,AtLeast,2,CCode(0x1000,4));
	CDeaths(P6,AtLeast,2,CCode(0x1000,20));
	CDeaths(P6,AtLeast,2,CCode(0x1000,10));
	CDeaths(P6,AtLeast,2,CCode(0x1000,56));
	CDeaths(P6,AtLeast,2,CCode(0x1000,28));
	CDeaths(P6,AtLeast,2,CCode(0x1000,36));
	CDeaths(P6,AtLeast,2,CCode(0x1000,37));
	CDeaths(P6,AtLeast,2,CCode(0x1000,5));
	CDeaths(P6,AtLeast,2,CCode(0x1000,21));
	CDeaths(P6,AtLeast,2,CCode(0x1000,48));
	CDeaths(P6,AtLeast,2,CCode(0x1000,49));
	CDeaths(P6,AtLeast,2,CCode(0x1000,46));
	CDeaths(P6,AtLeast,2,CCode(0x1000,32));
	CDeaths(P6,AtLeast,2,CCode(0x1000,14));
	CDeaths(P6,AtLeast,2,CCode(0x1000,15));
},{
		SetInvincibility(Disable,189,Force2,70);
},WUWarpT,{
			MinimapPing(70),
			PlayWAVX("staredit\\wav\\start.ogg"),
},HumanPlayers)

DisplayCTextToAll(FP,{
	CDeaths(P6,AtLeast,2,CCode(0x1000,6));
	CDeaths(P6,AtLeast,2,CCode(0x1000,22));
	CDeaths(P6,AtLeast,2,CCode(0x1000,11));
	CDeaths(P6,AtLeast,2,CCode(0x1000,57));
	CDeaths(P6,AtLeast,2,CCode(0x1000,29));
	CDeaths(P6,AtLeast,2,CCode(0x1000,38));
	CDeaths(P6,AtLeast,2,CCode(0x1000,39));
	CDeaths(P6,AtLeast,2,CCode(0x1000,7));
	CDeaths(P6,AtLeast,2,CCode(0x1000,23));
	CDeaths(P6,AtLeast,2,CCode(0x1000,50));
	CDeaths(P6,AtLeast,2,CCode(0x1000,51));
	CDeaths(P6,AtLeast,2,CCode(0x1000,47));
	CDeaths(P6,AtLeast,2,CCode(0x1000,33));
	CDeaths(P6,AtLeast,2,CCode(0x1000,12));
	CDeaths(P6,AtLeast,2,CCode(0x1000,13));
},{
		SetInvincibility(Disable,189,Force2,73);
},EDWarpT,{
			MinimapPing(73),
			PlayWAVX("staredit\\wav\\start.ogg"),
},HumanPlayers)


Trigger { -- 수정산 파괴, 모든 유저 브금 끝날시 모든 건물 파괴, 브금재생
	players = {P6},
	conditions = {
		Label(0);
		DeathsX(0,AtMost,0,440,0xFFFFFF);
		DeathsX(1,AtMost,0,440,0xFFFFFF);
		DeathsX(2,AtMost,0,440,0xFFFFFF);
		DeathsX(3,AtMost,0,440,0xFFFFFF);
		DeathsX(4,AtMost,0,440,0xFFFFFF);
		Memory(0x58F494,AtMost,0);
		Command(Force2,AtMost,1,173);
	},
	actions = {
		SetDeaths(P6,Add,1,173);
		KillUnit("Buildings",Force2);
		RotatePlayer({
			DisplayTextX("\n\n\n\n\n\n\n\x13\x1B\x04† \x1B기억의 보석 \x10【 Ｕ\x04ｎｋｎｏｗｎ \x10Ｃ\x04ｒｙｓｔａｌ \x10】 \x04을 파괴하였습니다. †\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x10００．４\x04％ 〓\n\n\n",4);
		},HumanPlayers,FP);
		SetCDeaths(P6,SetTo,1,CCode(0x1002,45));
		SetCDeaths(P6,SetTo,6,BGMType);
		SetCVar(P6,ClearRate[2],Add,4); -- ClearRate + 0.4%
	},
}
DoActions(FP,{Order(82,FP,64,Move,64)})
BYDBossClear = CreateCCode(ExDeaths1)
CIf({Force1,FP},{BYD,CDeaths(FP,AtMost,0,BYDBossClear),CDeaths(FP,AtLeast,1,CCode(0x1002,40))}) -- 비욘드 보스!
CIfOnce(FP,Always())--BYDBossInit
DoActionsX(FP,{
	SetMemoryX(0x66A1E4, SetTo, 65536*16,0xFF0000); -- 수정
	SetMemoryX(0x669EBC, SetTo, 16,0xFF); -- 옵저버
	SetCJump(0x700,0);
	SetCJump(0x648,0);
	PauseTimer();
})
CIfEnd()
DoActionsX(FP,{RemoveUnit(204,Force2)})
	TriggerX(P6,{
		CDeaths(FP,AtLeast,1,MarCreate)
		},{
		SetCJump(0x700,0),SetCDeaths(FP,SetTo,0,MarCreate)
		},{Preserved})

CAdd(FP,_CCode("X",StoryT),Dt)
DoActionsX(FP,{RemoveUnit(41,Force2),SetCDeaths(P6,SetTo,1,BYDBossStart),Order(82,FP,64,Move,64)})
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04그래. 그것은 운명 \x08( \x11Ｆ\x04ａｔｅ \x08)\x04 이었어.\n\n\n\n",5000*1)
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04아무리 노력해보아도, 쌓아 올려도.. 분열 \x10( \x11D\x04ivide \x10)\x04 되었고\n\n\n\n",5000*2)
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04늘 순탄하기만 할 것 같았지만 변칙 \x10( \x11A\x04nomaly \x10)\x04 아래에선 모든것이 평등했지.\n\n\n\n",5000*3)
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04이제 나에게 남은것은 암흑 \x10( \x11T\x04enebris \x10)\x04 뿐.\n\n\n\n",5000*4)
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04그래. 이젠 무엇을 잃어도 두렵지 않아...\n\n\n\n",5000*5)
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04그런 나를.. 그런 참혹한 결말에서 구원해주려고 했던게 너희들이었구나...\n\n\n\n",5000*6)
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04하지만.. 이젠 소용 없어. 이 기억은 종말 \x10( \x11D\x04emise \x10)\x04 을 맞이할 테니까.\n\n\n\n",5000*7)
StoryPrint("\x12\n\n\n\x13\x08？？？\n\x13\x04폭풍이 지나가면, 이 기억을 다시한번 창조 하는거야.\n\n\n\n",5000*8)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04이 또한 운명 \x08( \x11Ｆ\x04ａｔｅ \x08)\x04이니까.\n\n\n\n",5000*9,SetCDeaths(FP,Add,1,BYDBossP1))

-- 보스전 패턴 코드 작성 단락
TriggerX(FP,{CDeaths(FP,AtLeast,1,TestMode),CVar(FP,B7_K[2],AtLeast,1000)},{SetDeaths(FP,Add,1,82),KillUnit(82,AllPlayers)})
CIf(P6,CVar(FP,B7_H[2],AtLeast,1))
	CJumpEnd(FP,0x598)
	NIf(P6,{TMemory(B7_H,AtMost,6000000*256)})
		NIf(P6,{CVar(FP,B7_K[2],AtMost,450)})
			CDoActions(P6,{TSetMemory(B7_H,Add,2000000*256)})
			CAdd(P6,B7_K,1)
			CJump(FP,0x598)
		NIfEnd()
	NIfEnd()
	CDoActions(P6,{TSetDeaths(_Add(B7_H,11),SetTo,0,0),TSetDeathsX(_Add(B7_H,16),SetTo,0,0,0xFFFF)},1)
	CIf(FP,{TMemoryX(_Add(B7_H,17),Exactly,0,0xFF00)})
		CIfX(FP,{CVar(FP,B7_K[2],AtMost,449)})
			CDoActions(P6,{TSetMemoryX(_Add(B7_H,17),SetTo,1*256,0xFF00)})


		CElseX()
			CDoActions(P6,{SetCVar(FP,B7_H[2],SetTo,0),SetDeaths(P9,SetTo,1,82)})
		CIfXEnd()
	CIfEnd()
CIfEnd()


	TriggerX(P6,{
		CVar(FP,B7_K[2],AtLeast,40)
		},{   
		RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),
		CreateUnit(5,84,64,P6),
		SetCDeaths(P6,SetTo,0,StoryT),
		SetCDeaths(P6,SetTo,1,B7_Ph),
		SetInvincibility(Enable,82,FP,64)
		})
	TriggerX(P6,{
		CVar(FP,B7_K[2],AtLeast,85)
		},{   
		RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),
		CreateUnit(5,84,64,P6),
		SetCDeaths(P6,SetTo,0,StoryT),
		SetCDeaths(P6,SetTo,2,B7_Ph),
		SetInvincibility(Enable,82,FP,64)
		})

	TriggerX(P6,{
		CVar(FP,B7_K[2],AtLeast,130)
		},{   
		RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),
		CreateUnit(5,84,64,P6),
		SetCDeaths(P6,SetTo,0,StoryT),
		SetCDeaths(P6,SetTo,3,B7_Ph),
		SetInvincibility(Enable,82,FP,64),
		SetMemory(0x58F550,SetTo,0)
		})
	TriggerX(P6,{
		CVar(FP,B7_K[2],AtLeast,200)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),
		CreateUnit(5,84,64,P6),
		SetCDeaths(P6,SetTo,0,StoryT),
		SetCDeaths(P6,SetTo,4,B7_Ph),
		SetInvincibility(Enable,82,FP,64),
		})
	TriggerX(P6,{
		CVar(FP,B7_K[2],AtLeast,300)
		},{
		RotatePlayer({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),
		CreateUnit(5,84,64,P6),
		SetCDeaths(P6,SetTo,0,StoryT),
		SetCDeaths(P6,SetTo,5,B7_Ph),
		SetInvincibility(Enable,82,FP,64),
		SetCJump(0x700,0),
		KillUnit(128,FP)
		})


BYDBossPT1 = CreateCCode(ExDeaths1)
BPatternBreak = CreateCCode(ExDeaths1)


TriggerX(FP,{CDeaths(FP,AtMost,4,B7_Ph)},{SetCDeaths(P6,SetTo,1,MarineStackSystem)},{Preserved})
CIf(FP,CDeaths(FP,Exactly,0,B7_Ph)) -- 0페이즈
	CIf(FP,CDeaths(FP,AtLeast,1,BYDBossP1))
	CAdd(FP,_CCode("X",BYDBossPT1),Dt)
	CIfEnd()
	B7_W =CreateVar()
	CIf(FP,{CDeaths(FP,AtLeast,1,BYDBossP1),CDeaths(FP,AtMost,2*1000,BYDBossPT1)})
		CMov(FP,B7_W,15)
		CWhile(FP,{CVar(FP,B7_W[2],AtLeast,1),Bring(FP,AtMost,499,49,64)},SetCVar(FP,B7_W[2],Subtract,1))
		f_lengthdir(FP,150,_Mod(_Rand(),360),N_X,N_Y)
		Simple_SetLocX(FP,23,N_X,N_Y,N_X,N_Y,{Simple_CalcLoc(23,2048,2048,2048,2048),CreateUnitWithProperties(1,49,24,FP,{invincible = true}),Order(49,FP,64,Move,64)})
		CWhileEnd()
	CIfEnd()
	BPatternBreakTable = {}
	BPatternResetTable = {}
	for i = 0, 5 do
		table.insert(BPatternBreakTable,CreateCCode(ExDeaths1))
		table.insert(BPatternResetTable,SetCDeaths(FP,SetTo,0,BPatternBreakTable[i+1]))
		TriggerX(FP,{CDeaths(FP,AtLeast,(2+i)*1000,BYDBossPT1),CDeaths(FP,AtMost,8*1000,BYDBossPT1),CDeaths(FP,AtMost,0,BPatternBreakTable[i+1])},{RunAIScriptAt(JYD,64),SetCDeaths(FP,Add,1,BPatternBreakTable[i+1])},{Preserved})
	end
	CIf(FP,{CDeaths(FP,AtLeast,8*1000,BYDBossPT1),CDeaths(FP,AtMost,0,BPatternBreak)},SetCDeaths(FP,Add,1,BPatternBreak))
		CWhile(FP,Bring(FP,AtLeast,1,49,64))
		DoActions(FP,{Simple_SetLoc(23,0,0,20,20),MoveLocation(24,49,FP,64),KillUnitAt(All,"Men",24,Force1),GiveUnits(1,49,FP,64,P8),KillUnit(49,P8)})
		CWhileEnd()
		DoActionsX(FP,{BYDBossMarHPPatch,SetCDeaths(FP,SetTo,1,BYDBossStart2),SetInvincibility(Disable,82,FP,64)})
	CIfEnd()

	TriggerX(FP,{CDeaths(FP,AtLeast,13*1000,BYDBossPT1)},{
		SetInvincibility(Enable,82,FP,64),
		SetCDeaths(FP,SetTo,0,BPatternBreak),
		SetCDeaths(FP,SetTo,0,BYDBossPT1),
		BPatternResetTable
	},{Preserved})
CIfEnd()

CIf(FP,CDeaths(FP,Exactly,1,B7_Ph),SetCJump(0x648,0)) -- 1페이즈
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04나는.. 이 세상의 더러운 기억들을 보고 말았어.\n\n\n\n",3000*1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04그 뒤로 남겨진건.. 오직 \x10공허\x04뿐이었어.\n\n\n\n",3000*2)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04그러니까 이제 더이상 시간을 낭비하지 마.\n\n\n\n",3000*3)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04그만 포기하고 \x08사라져.\x04\n\n\n\n",3000*4)
	CIf(FP,CDeaths(FP,AtLeast,3000*4,StoryT))
		CMov(FP,B7_W,8)
		CWhile(FP,{CVar(FP,B7_W[2],AtLeast,1),Bring(FP,AtMost,15,128,64)},SetCVar(FP,B7_W[2],Subtract,1))
		f_lengthdir(FP,_Mod(_Rand(),360),_Mod(_Rand(),360),N_X,N_Y)
		Simple_SetLocX(FP,23,N_X,N_Y,N_X,N_Y,{Simple_CalcLoc(23,2048,2048,2048,2048),CreateUnitWithProperties(1,128,24,P6,{hitpoint = 50}),CreateUnit(1,84,24,FP)})
		CWhileEnd()


		DoActionsX(FP,{SetInvincibility(Disable,82,FP,64)})
	CIfEnd()
CIfEnd()


CIf(FP,CDeaths(FP,Exactly,2,B7_Ph),SetCJump(0x648,1)) -- 2페이즈
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04너희들도 잘 알꺼야.\n\n\n\n",3000*1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04이 뒤에 남겨진 결말은.. 결국 한심한 \x08죽음 \x04뿐이라는걸.\n\n\n\n",3000*2)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04희망따위.. 결국 \x10허황된 꿈\x04이라는걸!\n\n\n\n",3000*3)
	CIf(FP,CDeaths(FP,AtLeast,3000*3,StoryT))
	DoActionsX(FP,{SetMemoryX(0x66A1E4, SetTo, 65536*0,0xFF0000),SetInvincibility(Disable,82,FP,64),SetCJump(0x648,1),SetMemory(0x58F550,SetTo,1)},1)
	CIfEnd()
CIfEnd()

CIf(FP,CDeaths(FP,Exactly,3,B7_Ph)) -- 3페이즈
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04질투, 배신, 죽음, 괴로움, 부패...\n\n\n\n",3000*1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04결국 나에게 주어진건 이 \x10고통의 기억들\x04 뿐.\n\n\n\n",3000*2)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04이런 비극은.. \x08더이상 되풀이하고 싶지 않아!\n\n\n\n",3000*3)
	CIf(FP,CDeaths(FP,AtLeast,3000*3,StoryT),{SetCJump(0x648,0),SetMemoryX(0x66A1E4, SetTo, 65536*16,0xFF0000)})
		B7_T = CreateCCode(ExDeaths1)
		DoActionsX(FP,SetCDeaths(FP,Add,1,B7_T))
		DoActionsX(FP,{SetInvincibility(Disable,82,FP,64)},1)
		CIf(FP,{TTOR({CDeaths(FP,Exactly,1,B7_T),CDeaths(FP,Exactly,35,B7_T)})})
			CMov(FP,0x6509B0,19025+19)
			CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
				CIf(FP,CDeaths(FP,Exactly,1,B7_T))
					CIf(FP,{DeathsX(CurrentPlayer,AtMost,4,0,0xFF),DeathsX(CurrentPlayer,AtLeast,1,0,0xFF00)})
						DoActions(P6,{MoveCp(Add,6*4)})
						CIfX(P6,TTOR({
							DeathsX(CurrentPlayer,Exactly,MarID[1],0,0xFF),
							DeathsX(CurrentPlayer,Exactly,MarID[2],0,0xFF),
							DeathsX(CurrentPlayer,Exactly,MarID[3],0,0xFF),
							DeathsX(CurrentPlayer,Exactly,MarID[4],0,0xFF),
							DeathsX(CurrentPlayer,Exactly,MarID[5],0,0xFF),
							DeathsX(CurrentPlayer,Exactly,32,0,0xFF),
							DeathsX(CurrentPlayer,Exactly,7,0,0xFF),
							DeathsX(CurrentPlayer,Exactly,20,0,0xFF),
							DeathsX(CurrentPlayer,Exactly,27,0,0xFF),
						}))
							Call_SaveCp()
							CMov(P6,CPos,_ReadF(_Sub(BackupCp,15)))
							CMov(P6,CPosX,_Mov(CPos,0xFFFF))
							CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
							CIf(FP,{CVar(FP,CPosX[2],AtLeast,1696),CVar(FP,CPosX[2],AtMost,2400),CVar(FP,CPosY[2],AtLeast,1792),CVar(FP,CPosY[2],AtMost,2304)})
								
								Simple_SetLocX(P6,23,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,47,24,P6),KillUnit(47,FP),CreateUnit(1,217,24,P6)})
								
							CIfEnd()
							Call_LoadCp()
						CIfXEnd()
						DoActions(P6,{MoveCp(Subtract,6*4)})
					CIfEnd()
				CIfEnd()
				CIf(FP,CDeaths(FP,Exactly,35,B7_T))
					CIf(FP,{DeathsX(CurrentPlayer,Exactly,5,0,0xFF),DeathsX(CurrentPlayer,AtLeast,1,0,0xFF00)})
						DoActions(P6,{MoveCp(Add,6*4)})
						CIf(FP,DeathsX(CurrentPlayer,Exactly,217,0,0xFF))
							Call_SaveCp()
							CMov(P6,CPos,_ReadF(_Sub(BackupCp,15)))
							CMov(P6,CPosX,_Mov(CPos,0xFFFF))
							CMov(P6,CPosY,_Div(_Mov(CPos,0xFFFF0000),_Mov(65536)))
							Simple_SetLocX(P6,23,_Sub(CPosX,18),_Sub(CPosY,18),_Add(CPosX,18),_Add(CPosY,18),{CreateUnit(1,84,24,P6),CreateUnitWithProperties(1,128,24,P6,{hitpoint = 35})})
							CDoActions(FP,{TSetMemoryX(_Sub(BackupCp,6),SetTo,0,0xFF00)})
							Call_LoadCp()
						CIfEnd()
						DoActions(P6,{MoveCp(Subtract,6*4)})
					CIfEnd()
				CIfEnd()
				CAdd(FP,0x6509B0,84)
			CWhileEnd()
			CMov(FP,0x6509B0,FP)
		CIfEnd()
		TriggerX(FP,{CDeaths(FP,AtLeast,36,B7_T),Bring(FP,AtMost,0,128,64)},{SetCDeaths(FP,SetTo,0,B7_T)},{Preserved})
	CIfEnd()
CIfEnd()
B7_X = CreateVar()
B7_Y = CreateVar()
B7_R = CreateVar()
B7_A = CreateVar()
B7_Point = CreateVar()
B7_A2 = CreateVar()
B7_W2 = CreateVar()
B7_W3 = CreateVar()
B7_T2 = CreateCCode(ExDeaths1)
CIf(FP,CDeaths(FP,Exactly,4,B7_Ph),{SetCJump(0x648,1),SetMemoryX(0x66A1E4, SetTo, 65536*0,0xFF0000),KillUnit(217,FP)}) -- 4페이즈
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04이렇게까지 날 고통스럽게 할 생각이야..?\n\n\n\n",3000*1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04오히려 포기하고싶은건 나인데..!\n\n\n\n",3000*2)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x10운명\x04을 받아들이고 다시 시작하려고 했는데!!\n\n\n\n",3000*3)
	
	CIf(FP,CDeaths(FP,AtLeast,3000*3,StoryT),SetCDeaths(FP,Add,1,B7_T2))
		CIf(FP,CDeaths(FP,Exactly,1,B7_T2))
		CMov(FP,B7_Point,_Mod(_Rand(),9),4)
		f_Div(FP,B7_A2,_Mov(360),B7_Point)
		f_Mod(FP,B7_A,_Rand(),B7_A2)

		CDoActions(FP,{TSetCVar(FP,B7_W3[2],SetTo,B7_Point),SetInvincibility(Enable,82,FP,64)})
		CWhile(FP,CVar(FP,B7_W3[2],AtLeast,1),SetCVar(FP,B7_W3[2],Subtract,1))
		CIf(FP,Memory(0x628438,AtLeast,1))
			f_Read(P6,0x628438,"X",Nextptrs,0xFFFFFF)
			DoActions(FP,{CreateUnitWithProperties(1,49,64,P6,{invincible = true}),CreateUnitWithProperties(1,84,64,P6,{hallucinated = true})})
			f_lengthdir(FP,2000,_Add(B7_A,_Mul(B7_W3,B7_A2)),B7_X,B7_Y)
			CDoActions(P6,{
				TSetDeaths(_Add(Nextptrs,13),SetTo,1500,0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,1500,0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,19),SetTo,6*256,0,0xFF00),
				TSetDeathsX(_Add(Nextptrs,22),SetTo,_Add(B7_X,2048),0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,22),SetTo,_Mul(_Add(B7_Y,2048),65536),0,0xFFFF0000)
				})
			CIfEnd()
		CWhileEnd()

		CIfEnd()
		CIf(FP,CDeaths(FP,AtLeast,35,B7_T2),SetInvincibility(Disable,82,FP,64))
			CIfX(FP,CVar(FP,B7_R[2],AtMost,600))
			DoActionsX(FP,{SetCVar(FP,B7_W[2],SetTo,3)})
				CWhile(FP,{CVar(FP,B7_W[2],AtLeast,1),CVar(FP,B7_R[2],AtMost,600)},SetCVar(FP,B7_W[2],Subtract,1))
					CDoActions(FP,{TSetCVar(FP,B7_W2[2],SetTo,B7_Point)})
					CWhile(FP,{CVar(FP,B7_W2[2],AtLeast,1)},{SetCVar(FP,B7_W2[2],Subtract,1)})
						f_lengthdir(FP,B7_R,_Add(B7_A,_Mul(B7_W2,B7_A2)),B7_X,B7_Y)
						CAdd(FP,B7_X,2048)
						CAdd(FP,B7_Y,2048)
						Simple_SetLocX(FP,23,B7_X,B7_Y,B7_X,B7_Y,{KillUnit(49,P6)})
						TriggerX(FP,{CVar(FP,B7_X[2],AtMost,4096),CVar(FP,B7_Y[2],AtMost,4096)},{Simple_CalcLoc(23,-20,-20,20,20),CreateUnit(1,84,24,P6),SetInvincibility(Enable,"Factories",Force1,24),KillUnitAt(All,20,24,Force1),KillUnitAt(All,32,24,Force1),CreateUnit(1,128,24,P6)},{Preserved})
					CWhileEnd()
					CAdd(FP,B7_R,24)
				CWhileEnd()
			CElseX()
				TriggerX(FP,{Bring(FP,AtMost,0,128,64)},{
				SetCDeaths(FP,SetTo,0,B7_T2),
				SetCVar(FP,B7_R[2],SetTo,0)
			},{Preserved})
			CIfXEnd()
		CIfEnd()
	CIfEnd()

CIfEnd()
CIf(FP,CDeaths(FP,Exactly,5,B7_Ph)) -- 4페이즈
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04아아... 운명\x08( \x11Ｆ\x04ａｔｅ \x08)\x04은 정말로 바뀔 수 있을까..?\n\n\n\n",3000*1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04그렇다면, 한번 시험해보겠어.\n\n\n\n",3000*2)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x08너희들이 정말로 그 운명을 바꿀 수 있는것인지!!!\n\n\n\n",3000*3)




CIf(FP,CDeaths(FP,AtLeast,3000*3,StoryT))
DoActions(FP,SetInvincibility(Disable,82,FP,64),1)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,B6_5_A,2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,85),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,171),2048,2048)
CIf(FP,{CVar(FP,B7_K[2],AtLeast,340),CVar(FP,B7_K[2],AtMost,379)})
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,43),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,128),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,213),2048,2048)
CIfEnd()

CIf(FP,CVar(FP,B7_K[2],AtLeast,380))
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,28),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,57),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,114),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,142),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,199),2048,2048)
CallTrigger(FP,Call_RangeRandom)
CreateBullet(20,_Add(B6_5_A,228),2048,2048)
CIfEnd()

	CTrigger(FP,{CVar(FP,B6_5_M[2],Exactly,0)},
		{TSetCVar(FP,B6_5_A[2],Add,B6_5_D)},1)
	CTrigger(FP,{CVar(FP,B6_5_M[2],Exactly,1)},
		{TSetCVar(FP,B6_5_A[2],Add,_Sub(_Mov(256),B6_5_D))},1)
	TriggerX(FP,{CVar(FP,B6_5_T[2],AtLeast,36),CVar(FP,B6_5_N[2],Exactly,0)},
		{SetCVar(FP,B6_5_D[2],Add,1),SetCVar(FP,B6_5_T[2],SetTo,0)},{Preserved})
	TriggerX(FP,{CVar(FP,B6_5_T[2],AtLeast,36),CVar(FP,B6_5_N[2],Exactly,1)},
		{SetCVar(FP,B6_5_D[2],Subtract,1),SetCVar(FP,B6_5_T[2],SetTo,0)},{Preserved})
	TriggerX(FP,{CVar(FP,B6_5_D[2],Exactly,16),CVar(FP,B6_5_N[2],Exactly,0)},
		{SetCVar(FP,B6_5_N[2],SetTo,1)},{Preserved})
	TriggerX(FP,{CVar(FP,B6_5_D[2],Exactly,0),CVar(FP,B6_5_N[2],Exactly,1),CVar(FP,B6_5_M[2],Exactly,1)},
		{SetCVar(FP,B6_5_N[2],SetTo,0),SetCVar(FP,B6_5_M[2],SetTo,0)},{Preserved})
	TriggerX(FP,{CVar(FP,B6_5_D[2],Exactly,0),CVar(FP,B6_5_N[2],Exactly,1),CVar(FP,B6_5_M[2],Exactly,0)},
		{SetCVar(FP,B6_5_N[2],SetTo,0),SetCVar(FP,B6_5_M[2],SetTo,1)},{Preserved})
	CAdd(FP,B6_5_T,1)



	--310~430
	for i = 0, 11 do
		TriggerX(FP,{CVar(FP,B7_K[2],Exactly,310+(i*10))},{SetCJump(0x306,0)})
	end
	CJump(FP,0x306)
	CMov(FP,B7_W,0)
	CWhile(FP,CVar(FP,B7_W[2],AtMost,3))
	LocXTable = {1696,2400,1696,2400}
	LocYTable = {1792,1792,2304,2304}
	for i = 0, 3 do
	TriggerX(FP,{CVar(FP,B7_W[2],Exactly,i)},{Simple_SetLoc(23,LocXTable[i+1],LocYTable[i+1],LocXTable[i+1],LocYTable[i+1])},{Preserved})
	end
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,310)},19,23,32,128,0,6,1,P6,{1,65,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,320)},PlotSizeCalc(5,3),23,32,128,0,5,1,P6,{1,66,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,330)},16,23,32,96,0,4,1,P6,{1,80,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,340)},10,23,32,256,0,3,1,P6,{1,61,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,350)},43,23,32,64,0,7,1,P6,{1,8,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,360)},19,23,32,128,0,6,1,P6,{1,3,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,370)},31,23,32,96,0,5,1,P6,{1,98,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,380)},19,23,32,128,0,6,1,P6,{1,23,1,84})
	CreateUnitPolygonSafe2Gun(P6,{Label(0),CVar(FP,B7_K[2],Exactly,390)},49,23,32,64,0,8,1,P6,{1,28,1,84})
	CSPlotAct(CS_RatioXY(CSMakeStar(4,180,75,45,9*9,0),1,0.5),FP,22,23,nil,1,32,32,nil,FP,{Label(0),CVar(FP,B7_K[2],Exactly,400)},{CreateUnit(1,84,24,P6)},1)
	CreateUnitLineSafeGun(FP,{Label(0),CVar(FP,B7_K[2],Exactly,410)},4,23,96,96,75,2,1,P6,{1,64,1,84})
	CSPlotAct(CS_RatioXY(CSMakeLine(4,256,45,13,0),1,0.5),FP,60,23,nil,1,32,32,nil,FP,{Label(0),CVar(FP,B7_K[2],Exactly,420)},{CreateUnit(1,84,24,P6)},1)
	DoActionsX(FP,SetCVar(FP,B7_W[2],Add,1))
	CWhileEnd()
	DoActionsX(FP,{SetCJump(0x306,1)})
	TriggerX(FP,{CVar(FP,B7_K[2],Exactly,420)},{SetInvincibility(Enable,82,FP,64)})
	CJumpEnd(FP,0x306)
	TriggerX(FP,{Bring(FP,AtMost,15,"Men",64)},{SetInvincibility(Disable,82,FP,64)},{Preserved})
CIfEnd()


CIfEnd()

CJump(FP,0x648)
CWhile(FP,Bring(FP,AtLeast,1,128,64)) -- 죽음의 수정
DoActions(FP,{Simple_SetLoc(23,0,0,20,20),MoveLocation(24,128,FP,64),GiveUnits(1,128,FP,64,P8)})
Trigger2(FP,{Bring(Force1,AtLeast,1,"Men",24)},{SetInvincibility(Enable,"Factories",Force1,24),KillUnitAt(All,20,24,Force1),KillUnitAt(All,32,24,Force1)},{Preserved})
CWhileEnd()
CJumpEnd(FP,0x648)
DoActions(FP,GiveUnits(All,128,P8,64,FP))

-- 보스전 패턴 코드 작성 단락

--각 페이즈 끝날시 대사

--보스전 끝날시
CMov(FP,0x6509B0,FP)
CIf(FP,Deaths(P9,AtLeast,1,82))
Trigger { 
	players = {P6},
	conditions = {
		Label(0);
	},
	actions = {
		RotatePlayer({
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x06ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\n\n\x13\x06ＥＸＴＲＡ　Ｂｏｓｓ \x04－\x10\x08【 \x10對\x04 立 \x06】\x04를 처치하셨습니다.\n\x13\x04〓 \x1FＣ\x04ｌｅａｒ \x10Ｒ\x04ａｔｅ ＋ \x08０７．０\x04％ 〓\n\n\n\x13\x04！！！　\x06ＢＯＳＳ　ＣＬＥＡＲ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
				PlayWAVX("staredit\\wav\\Beyond_Start.ogg"),
				PlayWAVX("staredit\\wav\\Beyond_Start.ogg"),
				PlayWAVX("staredit\\wav\\Beyond_Start.ogg")
		},HumanPlayers,FP);
		SetCVar(P6,ClearRate[2],Add,70); -- ClearRate + 7.0%
		SetCDeaths(FP,SetTo,6,B7_Ph);
		SetMemoryX(0x66A1F8, SetTo, 9*256,0xFF00);


	},
}


DoActionsX(FP,{SetCDeaths(FP,SetTo,0,StoryT),KillUnit(60,FP),SetSwitch("Switch 130",Set)},1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04...그래. 운명\x08( \x11Ｆ\x04ａｔｅ \x08)\x04은 바뀌었어.\n\n\n\n",4000*1)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04너희들은 \x10혼돈\x04으로 가득한 이 기억을 구원해내었어.\n\n\n\n",4000*2)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04너희들은 \x07빛\x04으로써 또 하나의 \x11생명\x04을 구원해내었어.\n\n\n\n",4000*3)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04아마.. 너희들은.... 응. 기억났어.\n\n\n\n",4000*4)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x1F바로 나 자신이라는것을.\n\n\n\n",4000*5)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04포기하지 않고 끝까지 날 구해줘서 고마워.\n\n\n\n",4000*6)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04운명의 축은 틀어졌어.\n\n\n\n",4000*7)
StoryPrint("\x12\n\n\n\x13\x08【 \x10對\x04 立 \x06】\n\x13\x04다시한번 그 운명\x08( \x11Ｆ\x04ａｔｅ \x08)\x04을 맞선다면, \x08결말\x04은 바뀌어 있을 거야. \n\n\n\n",4000*8)

Trigger { 
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,4000*5,StoryT)
	},
	actions = {
		CreateUnitWithProperties(1,82,64,FP,{invincible = true});
		CreateUnitWithProperties(1,84,64,P8,{hallucinated = true});
		KillUnit(84,P8);
	},
}

Trigger { 
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,4000*9,StoryT)
	},
	actions = {
		RotatePlayer({
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x07ＮＯＴＩＣＥ\x04　！！！\n\n\n\x13\x11BGM\x04이 멈출 때까지 기다려주세요. 잠시 후 \x10【 U\x04nknown \x10C\x04rystal \x10】 \x04의 무적이 해제됩니다.\n \n\n\x13\x04！！！　\x07ＮＯＴＩＣＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4),
			PlayWAVX("staredit\\wav\\reviveunlock.ogg"),
			PlayWAVX("staredit\\wav\\reviveunlock.ogg"),
			PlayWAVX("staredit\\wav\\reviveunlock.ogg")
		},HumanPlayers,FP);
		SetMemory(0x66EC48 + 4*533, SetTo, 246);

	},
}

Trigger { 
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,4000*9,StoryT);
		DeathsX(0,AtMost,0,440,0xFFFFFF);
		DeathsX(1,AtMost,0,440,0xFFFFFF);
		DeathsX(2,AtMost,0,440,0xFFFFFF);
		DeathsX(3,AtMost,0,440,0xFFFFFF);
		DeathsX(4,AtMost,0,440,0xFFFFFF);
	},
	actions = {
		SetCDeaths(FP,SetTo,1,BYDBossClear)


	},
}




-- NOITCE - BGM이 멈출 때까지 기다려주세요. 잠시 후 Unknown Crysatal의 무적이 해제됩니다.  
CIfEnd()
-- 단락 전체 닫힘

Trigger { 
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,5000*9,StoryT)
	},
	actions = {
		GiveUnits(All,82,P12,64,P6);
		MoveUnit(All,82,P6,64,64);
		CreateUnitWithProperties(1,84,64,P8,{hallucinated = true});
		KillUnit(84,P8);
	},
}

-- StartLineVar 53000

Trigger { -- 비욘드 보스브금
	players = {Force1},
	conditions = {
		Deaths(CurrentPlayer,AtMost,0,440);
		Deaths(FP,AtMost,0,82);
	},
	actions = {
		PlayWAV("staredit\\wav\\BYD_Boss.ogg"); 
		PlayWAV("staredit\\wav\\BYD_Boss.ogg"); 
		SetDeathsX(CurrentPlayer,Add,217670,440,0xFFFFFF);
		PreserveTrigger();
		
		},
	}

Trigger { -- 비욘드 보스브금
	players = {P6},
	conditions = {
		Memory(0x58F494,AtMost,0);
		Deaths(FP,AtMost,0,82);
	},
	actions = { 
		RotatePlayer({
			PlayWAVX("staredit\\wav\\BYD_Boss.ogg"),
			PlayWAVX("staredit\\wav\\BYD_Boss.ogg")
		},ObPlayers,FP);
		SetMemory(0x58F494,Add,217670);
		PreserveTrigger();
		
		},
	}


CIfEnd()
Trigger { -- 
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(FP,AtLeast,1,ButtonSound);

	},
	actions = {
		RotatePlayer({
		PlayWAVX("staredit\\wav\\button3.wav"),
		PlayWAVX("staredit\\wav\\button3.wav"),
		PlayWAVX("staredit\\wav\\button3.wav")
		},HumanPlayers,FP);
		SetCDeaths(FP,Subtract,1,ButtonSound);
	},
	flag = {Preserved}
}




PyCon1  = {153,163,189}
PyCon2 = {154,166,188}
PyCon3 = {155,165,187}
PyCon4 = {156,164,190}

PyCCode = {CreateCCode(ExDeaths1),CreateCCode(ExDeaths1),CreateCCode(ExDeaths1),CreateCCode(ExDeaths1)}
for i = 0, 3 do

if i == 0 then
BdPlayer = 6
elseif i == 1 then
BdPlayer = 7
elseif i == 2 then
BdPlayer = 7
elseif i == 3 then
BdPlayer = 6
end
	for j = 0, 1 do
	Trigger {
		players = {BdPlayer},
		conditions = {
			Label(0);
			CommandLeastAt(156,(i*2)+215+j)
		},
		actions = {
			SetCDeaths(FP,Add,1,PyCCode[i+1])
			
			
		},
	}
	end
end
DisplayCTextToAll(FP,{CDeaths(FP,AtLeast,1,PyCCode[1]);
},{
		SetInvincibility(Disable,154,Force2,PyCon1[2]);
},NexCon1T,{
		PlayWAVX("staredit\\wav\\start.ogg"),
		MinimapPing(PyCon1[2])
},HumanPlayers)

DisplayCTextToAll(FP,{CDeaths(FP,AtLeast,1,PyCCode[2]);
},{
		SetInvincibility(Disable,154,Force2,PyCon2[2]);
},NexCon2T,{
		PlayWAVX("staredit\\wav\\start.ogg"),
		MinimapPing(PyCon2[2])
},HumanPlayers)


DisplayCTextToAll(FP,{CDeaths(FP,AtLeast,1,PyCCode[3]);
},{
		SetInvincibility(Disable,154,Force2,PyCon3[2]);
},NexCon3T,{
		PlayWAVX("staredit\\wav\\start.ogg"),
		MinimapPing(PyCon3[2])
},HumanPlayers)


DisplayCTextToAll(FP,{CDeaths(FP,AtLeast,1,PyCCode[4]);
},{
		SetInvincibility(Disable,154,Force2,PyCon4[2]);
},NexCon4T,{
		PlayWAVX("staredit\\wav\\start.ogg"),
		MinimapPing(PyCon4[2])
},HumanPlayers)

for i = 0, 3 do -- 파일런부술시 
Trigger { -- 1
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(FP,AtLeast,1,PyCCode[i+1]);
	},
	actions = {
		RotatePlayer({
			PlayWAVX("staredit\\wav\\Eff1.ogg"),
			PlayWAVX("staredit\\wav\\Eff1.ogg"),
			PlayWAVX("sound\\glue\\bnetclick.wav"),
			PlayWAVX("sound\\glue\\bnetclick.wav")
		},HumanPlayers,FP);
		ModifyUnitHitPoints(All,146,Force2,153+i,1);
		ModifyUnitHitPoints(All,144,Force2,153+i,1);
		ModifyUnitHitPoints(All,143,Force2,153+i,1);
		SetMemoryX(0x657008, Subtract, 3,0xFF);
		
	},
}
Trigger { -- 0
	players = {P6},
	conditions = { 
		Bring(Force2,AtMost,0,156,153+i);
	},
	actions = {
		RotatePlayer({
			PlayWAVX("staredit\\wav\\Eff1.ogg"),
			PlayWAVX("staredit\\wav\\Eff1.ogg"),
			PlayWAVX("sound\\glue\\bnetclick.wav"),
			PlayWAVX("sound\\glue\\bnetclick.wav")
		},HumanPlayers,FP);
		KillUnitAt(All,146,153+i,Force2);
		KillUnitAt(All,144,153+i,Force2);
		KillUnitAt(All,143,153+i,Force2);
		SetMemoryX(0x657008, Subtract, 3,0xFF);
		
	},
}
end

CIf({Force1,P6},CDeaths(P6,AtLeast,2,Difficulty))

DisplayCTextToAll(FP,{
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(FP,AtLeast,2,PyCCode[1]);
},{
		SetInvincibility(Disable,174,Force2,PyCon1[3]);
},TemCon1T,{
			PlayWAVX("staredit\\wav\\start.ogg"),
			MinimapPing(PyCon1[3])
},HumanPlayers)

DisplayCTextToAll(FP,{
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(FP,AtLeast,2,PyCCode[2]);
},{
		SetInvincibility(Disable,174,Force2,PyCon2[3]);
},TemCon2T,{
			PlayWAVX("staredit\\wav\\start.ogg"),
			MinimapPing(PyCon2[3])
},HumanPlayers)

DisplayCTextToAll(FP,{
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(FP,AtLeast,2,PyCCode[3]);
},{
		SetInvincibility(Disable,174,Force2,PyCon3[3]);
},TemCon3T,{
			PlayWAVX("staredit\\wav\\start.ogg"),
			MinimapPing(PyCon3[3])
},HumanPlayers)

DisplayCTextToAll(FP,{
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(FP,AtLeast,2,PyCCode[4]);
},{
		SetInvincibility(Disable,174,Force2,PyCon4[3]);
},TemCon4T,{
			PlayWAVX("staredit\\wav\\start.ogg"),
			MinimapPing(PyCon4[3])
},HumanPlayers)

DisplayCTextToAll(FP,{
		BYD;
		CDeaths(FP,AtLeast,2,PyCCode[1]);
		CDeaths(FP,AtLeast,2,PyCCode[2]);
		CDeaths(FP,AtLeast,2,PyCCode[3]);
		CDeaths(FP,AtLeast,2,PyCCode[4]);
},{
},AttackUnlock,{
			PlayWAVX("staredit\\wav\\reviveunlock.ogg"),
			PlayWAVX("staredit\\wav\\reviveunlock.ogg"),
			PlayWAVX("staredit\\wav\\reviveunlock.ogg"),
},HumanPlayers)

BIndex = 87
BPoint = 300000
DisplayCTextToAll(FP,{
		Deaths(P6, AtLeast,1,BIndex);
},{
		SetScore(Force1,Add,BPoint,Kills);
		SetCVar(P6,B2_H[2],SetTo,0);
		SetCVar(P6,ClearRate[2],Add,15); -- ClearRate + 1.5%
},BClearT1,{
			PlayWAVX("staredit\\wav\\E_Clear.ogg"),
			PlayWAVX("staredit\\wav\\E_Clear.ogg")
},HumanPlayers)


BIndex = 74
BPoint = 300000

DisplayCTextToAll(FP,{
		Deaths(P6, AtLeast,1,BIndex);
},{
		SetScore(Force1,Add,BPoint,Kills);
		SetCVar(P6,B3_H[2],SetTo,0);
		SetCVar(P6,ClearRate[2],Add,15); -- ClearRate + 1.5%
},BClearT2,{
			PlayWAVX("staredit\\wav\\E_Clear.ogg"),
			PlayWAVX("staredit\\wav\\E_Clear.ogg")
},HumanPlayers)

BIndex = 30
BPoint = 300000
DisplayCTextToAll(FP,{
		Deaths(P6, AtLeast,1,BIndex);
},{
		SetScore(Force1,Add,BPoint,Kills);
		SetCVar(P6,B4_H[2],SetTo,0);
		SetCVar(P6,ClearRate[2],Add,15); -- ClearRate + 1.5%
},BClearT3,{
			PlayWAVX("staredit\\wav\\E_Clear.ogg"),
			PlayWAVX("staredit\\wav\\E_Clear.ogg")
},HumanPlayers)

BIndex = 2
BPoint = 300000
DisplayCTextToAll(FP,{
		Deaths(P6, AtLeast,1,BIndex);
},{
		SetScore(Force1,Add,BPoint,Kills);
		SetCVar(P6,B5_H[2],SetTo,0);
		SetCVar(P6,ClearRate[2],Add,15); -- ClearRate + 1.5%
},BClearT4,{
			PlayWAVX("staredit\\wav\\E_Clear.ogg"),
			PlayWAVX("staredit\\wav\\E_Clear.ogg")
},HumanPlayers)

Trigger { -- 상단 다고스 조건만족시 무적해제
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,9));
		CDeaths(P6,AtLeast,1,CCode(0x1002,10));
	},
	actions = {
		RotatePlayer({
			MinimapPing(185),
			PlayWAVX("staredit\\wav\\start.ogg"),
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F상단 \x04지역 \x10【 D\x04aggoth \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
		},HumanPlayers,FP);
		SetInvincibility(Disable,152,Force2,185);
	},
}
Trigger { -- 하단 다고스 조건만족시 무적해제
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,8));
		CDeaths(P6,AtLeast,1,CCode(0x1002,11));
	},
	actions = {
		RotatePlayer({
			MinimapPing(186),
			PlayWAVX("staredit\\wav\\start.ogg"),
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19하단 \x04지역 \x10【 D\x04aggoth \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
		},HumanPlayers,FP);
		SetInvincibility(Disable,152,Force2,186);
	},
}
Trigger { -- 상단 디스럽터 조건만족시 무적해제
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,4));
		CDeaths(P6,AtLeast,1,CCode(0x1002,5));
		CDeaths(P6,AtLeast,1,CCode(0x1002,14));
		CDeaths(P6,AtLeast,1,CCode(0x1002,15));
		CDeaths(P6,AtLeast,1,CCode(0x1002,18));
		CDeaths(P6,AtLeast,1,CCode(0x1002,19));
		CDeaths(P6,AtLeast,1,CoreCon1);
		
	},
	actions = {
		RotatePlayer({
			MinimapPing(29),
			PlayWAVX("staredit\\wav\\start.ogg"),
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x1F상단 \x04지역 \x10【 C\x04ore of \x10D\x04epth \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
		},HumanPlayers,FP);
		SetInvincibility(Disable,190,Force2,29);
		SetCDeaths(P6,Add,1,CoreInbDis);
	},
}
Trigger { -- 하단 디스럽터 조건만족시 무적해제
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,6));
		CDeaths(P6,AtLeast,1,CCode(0x1002,7));
		CDeaths(P6,AtLeast,1,CCode(0x1002,12));
		CDeaths(P6,AtLeast,1,CCode(0x1002,13));
		CDeaths(P6,AtLeast,1,CCode(0x1002,16));
		CDeaths(P6,AtLeast,1,CCode(0x1002,17));
		CDeaths(P6,AtLeast,1,CoreCon2);
	},
	actions = {
		RotatePlayer({
			MinimapPing(10),
			PlayWAVX("staredit\\wav\\start.ogg"),
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x19하단 \x04지역 \x10【 C\x04ore of \x10D\x04epth \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
		},HumanPlayers,FP);
		SetInvincibility(Disable,190,Force2,10);
		SetCDeaths(P6,Add,1,CoreInbDis);
	},
}
Trigger { -- 하드이상 코어 무적해제 조건1
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,41));
		CDeaths(P6,AtLeast,1,CCode(0x1002,44));
		CDeaths(P6,AtLeast,1,CCode(0x1002,20));
		CDeaths(P6,AtLeast,1,CCode(0x1002,23));
		CDeaths(P6,AtLeast,1,CCode(0x1002,26));
		CDeaths(P6,AtLeast,1,CCode(0x1002,30));
		CDeaths(P6,AtLeast,1,CCode(0x1002,31));
		CDeaths(P6,AtLeast,1,CCode(0x1002,34));
		CDeaths(P6,AtLeast,1,CCode(0x1002,35));
		CDeaths(P6,AtLeast,1,CCode(0x1002,24));
	},
	actions = {
		SetCDeaths(P6,Add,1,CoreCon1);
	},
}
Trigger { -- 하드이상 코어 무적해제 조건2
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,42));
		CDeaths(P6,AtLeast,1,CCode(0x1002,43));
		CDeaths(P6,AtLeast,1,CCode(0x1002,21));
		CDeaths(P6,AtLeast,1,CCode(0x1002,22));
		CDeaths(P6,AtLeast,1,CCode(0x1002,27));
		CDeaths(P6,AtLeast,1,CCode(0x1002,28));
		CDeaths(P6,AtLeast,1,CCode(0x1002,29));
		CDeaths(P6,AtLeast,1,CCode(0x1002,32));
		CDeaths(P6,AtLeast,1,CCode(0x1002,33));
		CDeaths(P6,AtLeast,1,CCode(0x1002,25));
	},
	actions = {
		SetCDeaths(P6,Add,1,CoreCon2);
	},
}
Trigger { -- 나머지건물, 함정하이브 파괴시 수정광산 무적해제 하드
	players = {P6},
	conditions = { 
		Label(0);
		NBYD;
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,0));
		CDeaths(P6,AtLeast,1,CCode(0x1002,1));
		CDeaths(P6,AtLeast,1,CCode(0x1002,2));
		CDeaths(P6,AtLeast,1,CCode(0x1002,3));
		CDeaths(P6,AtLeast,1,CCode(0x1002,40));

		Bring(AllPlayers,AtMost,0,"【 Divide 】",64);
		Bring(AllPlayers,AtMost,0,"【 Tenebris 】",64);
		Bring(AllPlayers,AtMost,0,"【 Demise 】",64);
		Bring(AllPlayers,AtMost,0,"【 Anomaly 】",64);
	},
	actions = {
		RotatePlayer({
			MinimapPing(192),
			MinimapPing(193),
			PlayWAVX("staredit\\wav\\start.ogg"),
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x10【 U\x04nknown \x10C\x04rystal \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
		},HumanPlayers,FP);
	SetInvincibility(Disable,173,Force2,"Anywhere");
	},
}

Trigger { -- 나머지건물, 함정하이브 파괴시 수정광산 무적해제 하드
	players = {P6},
	conditions = { 
		Label(0);
		BYD;
		CDeaths(FP,AtLeast,1,BYDBossClear);
		Memory(0x58F494,AtMost,0);
		CDeaths(P6,AtLeast,2,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,0));
		CDeaths(P6,AtLeast,1,CCode(0x1002,1));
		CDeaths(P6,AtLeast,1,CCode(0x1002,2));
		CDeaths(P6,AtLeast,1,CCode(0x1002,3));
		CDeaths(P6,AtLeast,1,CCode(0x1002,40));
		Bring(AllPlayers,AtMost,0,"【 Divide 】",64);
		Bring(AllPlayers,AtMost,0,"【 Tenebris 】",64);
		Bring(AllPlayers,AtMost,0,"【 Demise 】",64);
		Bring(AllPlayers,AtMost,0,"【 Anomaly 】",64);

	},
	actions = {
		RotatePlayer({
			MinimapPing(192),
			MinimapPing(193),
			PlayWAVX("staredit\\wav\\start.ogg"),
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x10【 U\x04nknown \x10C\x04rystal \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
		},HumanPlayers,FP);
	SetInvincibility(Disable,173,Force2,"Anywhere");
	},
}
Trigger { -- 수정산 파괴 후 브금 끝날 시 하드모드 이상 기믹 발동, 임시 승리트리거 추가
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,0,BGMType);
		DeathsX(0,AtMost,0,440,0xFFFFFF);
		DeathsX(1,AtMost,0,440,0xFFFFFF);
		DeathsX(2,AtMost,0,440,0xFFFFFF);
		DeathsX(3,AtMost,0,440,0xFFFFFF);
		DeathsX(4,AtMost,0,440,0xFFFFFF);
		Memory(0x58F494,AtMost,0);
		CDeaths(P6,Exactly,1,CCode(0x1002,45));
		CDeaths(P6,AtLeast,2,Difficulty);
	},
	actions = {
		PauseTimer();
		KillUnit(125,AllPlayers);
		SetDeaths(Force2,SetTo,0,173);
		--SetCDeaths(P6,SetTo,1,BossBGM);
		SetCDeaths(P6,SetTo,1,HDStart);
		--SetCDeaths(P6,SetTo,1,Win);
		
		},
	}
CIf(Force1,{CDeaths(P6,Exactly,1,HDStart),CDeaths(P6,Exactly,1,CCode(0x1002,45)),CVar(P6,HDEnd[2],AtMost,199)})
for i = 0, 155 do
Trigger { -- 하드이상 브금제어
	players = {Force1},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,i,441,0xFFFFFF);
		Deaths(CurrentPlayer,AtMost,0,440);
	},
	actions = {
		PlayWAV(BGMArr[i+1]); 
		PlayWAV(BGMArr[i+1]); 
		SetDeathsX(CurrentPlayer,Add,1000,440,0xFFFFFF);
		SetDeaths(CurrentPlayer,Add,1,441,0xFFFFFF);
		PreserveTrigger();
		
		},
	}
end
Trigger { -- 하드이상 브금제어
	players = {Force1},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,156,441,0xFFFFFF);
		Deaths(CurrentPlayer,AtMost,0,440);
	},
	actions = {
		PlayWAV(BGMArr[157]); 
		PlayWAV(BGMArr[157]); 
		SetDeathsX(CurrentPlayer,Add,500,440,0xFFFFFF);
		SetDeaths(CurrentPlayer,Add,1,441,0xFFFFFF);
		PreserveTrigger();
		
		},
	}
Trigger { -- 하드이상 브금제어
	players = {Force1},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,157,441,0xFFFFFF);
		Deaths(CurrentPlayer,AtMost,0,440);
	},
	actions = {
		PlayWAV(BGMArr[1]); 
		PlayWAV(BGMArr[1]); 
		SetDeathsX(CurrentPlayer,Add,980,440,0xFFFFFF);
		SetDeaths(CurrentPlayer,SetTo,1,441,0xFFFFFF);
		PreserveTrigger();
		
		},
	}
CIfEnd()
CIf(P6,{CDeaths(P6,Exactly,1,HDStart),CDeaths(P6,Exactly,1,CCode(0x1002,45)),CVar(P6,HDEnd[2],AtMost,199)})
for i = 0, 155 do
Trigger { -- 하드이상 브금제어
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,i,441,0xFFFFFF);
		Memory(0x58F494,AtMost,0);
	},
	actions = {
		RotatePlayer({
			PlayWAVX(BGMArr[i+1]),
			PlayWAVX(BGMArr[i+1])
		},ObPlayers,FP);
		SetMemory(0x58F494,Add,980);
		SetDeaths(CurrentPlayer,Add,1,441,0xFFFFFF);
		PreserveTrigger();
		
		},
	}
end
Trigger { -- 하드이상 브금제어
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,156,441,0xFFFFFF);
		Memory(0x58F494,AtMost,0);
	},
	actions = { 
		RotatePlayer({
			PlayWAVX(BGMArr[157]),
			PlayWAVX(BGMArr[157])
		},ObPlayers,FP);
		SetMemory(0x58F494,Add,500);
		SetDeaths(CurrentPlayer,Add,1,441,0xFFFFFF);
		PreserveTrigger();
		
		},
	}
Trigger { -- 하드이상 브금제어
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,157,441,0xFFFFFF);
		Memory(0x58F494,AtMost,0);
	},
	actions = {
		RotatePlayer({
			PlayWAVX(BGMArr[1]),
			PlayWAVX(BGMArr[1])
		},ObPlayers,FP);
		SetMemory(0x58F494,Add,1000);
		SetDeaths(CurrentPlayer,SetTo,1,441,0xFFFFFF);
		PreserveTrigger();
		
		},
	}
CIfEnd()
Trigger { -- 뭘까?
	players = {P6},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,2,441,0xFFFFFF);
		Memory(0x58F494,AtMost,800);
		Memory(0x58F494,AtLeast,1);
	},
	actions = {
		SetDeaths(P6,SetTo,1,72);
		},
	}

Trigger { -- 화홀 발동조건
	players = {P2},
	conditions = {
		Label(0);
		Memory(0x58F484,AtLeast,1);
		Command(P6,AtLeast,1,"Map Revealer");
	},
	actions = {
		SetCDeaths(P6,SetTo,0,CoreAccept);
		PreserveTrigger();
	},
}
Trigger { -- 화홀 발동조건
	players = {P3},
	conditions = {
		Label(0);
		Memory(0x58F488,AtLeast,1);
		Command(P6,AtLeast,1,"Map Revealer");
	},
	actions = {
		SetCDeaths(P6,SetTo,0,CoreAccept);
		PreserveTrigger();
	},
}
Trigger { -- 화홀 발동조건
	players = {P4},
	conditions = {
		Label(0);
		Memory(0x58F48C,AtLeast,1);
		Command(P6,AtLeast,1,"Map Revealer");
	},
	actions = {
		SetCDeaths(P6,SetTo,0,CoreAccept);
		PreserveTrigger();
	},
}
Trigger { -- 화홀 발동조건
	players = {P5},
	conditions = {
		Label(0);
		Memory(0x58F490,AtLeast,1);
		Command(P6,AtLeast,1,"Map Revealer");
	},
	actions = {
		SetCDeaths(P6,SetTo,0,CoreAccept);
		PreserveTrigger();
	},
}
Trigger { -- 화홀 발동조건
	players = {P6},
	conditions = {
		Label(0);
		Memory(0x58F494,AtLeast,1);
		Command(P6,AtLeast,1,"Map Revealer");
	},
	actions = {
		SetCDeaths(P6,SetTo,0,CoreAccept);
		PreserveTrigger();
	},
}
Trigger { -- 화홀 발동조건
	players = {P1},
	conditions = {
		Label(0);
		Memory(0x58F480,AtLeast,1);
		Command(P6,AtLeast,1,"Map Revealer");
	},
	actions = {
		SetCDeaths(P6,SetTo,0,CoreAccept);
		PreserveTrigger();
	},
}

Trigger { -- 화홀 발동조건
	players = {P6},
	conditions = {
		Label(0);
		DeathsX(0,AtMost,0,440,0xFFFFFF);
		DeathsX(1,AtMost,0,440,0xFFFFFF);
		DeathsX(2,AtMost,0,440,0xFFFFFF);
		DeathsX(3,AtMost,0,440,0xFFFFFF);
		DeathsX(4,AtMost,0,440,0xFFFFFF);
		Memory(0x58F494,AtMost,0);
		CDeaths(P6,AtLeast,2,CoreInbDis);
	},
	actions = {
		SetCDeaths(P6,SetTo,1,CoreAccept);
		PreserveTrigger();
	},
}

Trigger { -- No comment (E93EF7A9)
	players = {P6},
	conditions = {
		Switch("Switch 103",Set);
	},
	actions = {
		SetSwitch("Switch 103",Clear);
	},
}
BossT = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x14\n\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ｄ\x04ｉｖｉｄｅ\x10 】 \x04가 봉인에서 해방되었습니다.\n\x14\n\x14\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
Trigger {
	players = {P6},
	conditions = {
		Command(P6,AtLeast,1,87);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(BossT,4),
			PlayWAVX("staredit\\wav\\BossAwak.ogg"),
			PlayWAVX("staredit\\wav\\BossAwak.ogg")
		},HumanPlayers,FP);
	}
}
BossT = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x14\n\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ｔ\x04ｅｎｅｂｒｉｓ\x10 】 \x04가 봉인에서 해방되었습니다.\n\x14\n\x14\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
Trigger {
	players = {P6},
	conditions = {
		Command(P6,AtLeast,1,74);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(BossT,4),
			PlayWAVX("staredit\\wav\\BossAwak.ogg"),
			PlayWAVX("staredit\\wav\\BossAwak.ogg")
		},HumanPlayers,FP);
	}
}
BossT = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x14\n\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ｄ\x04ｅｍｉｓｅ\x10 】 \x04가 봉인에서 해방되었습니다.\n\x14\n\x14\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
Trigger {
	players = {P6},
	conditions = {
		Command(P6,AtLeast,1,30);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(BossT,4),
			PlayWAVX("staredit\\wav\\BossAwak.ogg"),
			PlayWAVX("staredit\\wav\\BossAwak.ogg")
		},HumanPlayers,FP);
	}
}
BossT = "\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x14\n\x14\n\x13\x04\x07기억\x04의 수호자 \x10【 \x11Ａ\x04ｎｏｍａｌｙ\x10 】 \x04가 봉인에서 해방되었습니다.\n\x14\n\x14\n\x13\x04！！！　\x08ＢＯＳＳ　ＢＡＴＴＬＥ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――"
Trigger {
	players = {P6},
	conditions = {
		Command(P6,AtLeast,1,2);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(BossT,4),
			PlayWAVX("staredit\\wav\\BossAwak.ogg"),
			PlayWAVX("staredit\\wav\\BossAwak.ogg")
		},HumanPlayers,FP);
	}
}

CIfEnd() -- 하드이상 단락
CIf(P6,CDeaths(P6,Exactly,1,Difficulty)) -- 이지 단락

Trigger { -- 이지모드 클리어조건1
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,Exactly,1,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,4));
		CDeaths(P6,AtLeast,1,CCode(0x1002,5));
		CDeaths(P6,AtLeast,1,CCode(0x1002,14));
		CDeaths(P6,AtLeast,1,CCode(0x1002,15));
		CDeaths(P6,AtLeast,1,CCode(0x1002,18));
		CDeaths(P6,AtLeast,1,CCode(0x1002,19));
		CDeaths(P6,AtLeast,1,CCode(0x1002,20));
		CDeaths(P6,AtLeast,1,CCode(0x1002,23));
		CDeaths(P6,AtLeast,1,CCode(0x1002,24));
	},
	actions = {
		SetCDeaths(P6,Add,1,EZCon);
	},
}
Trigger { -- 이지모드 클리어조건2
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,Exactly,1,Difficulty);
		CDeaths(P6,AtLeast,1,CCode(0x1002,6));
		CDeaths(P6,AtLeast,1,CCode(0x1002,7));
		CDeaths(P6,AtLeast,1,CCode(0x1002,12));
		CDeaths(P6,AtLeast,1,CCode(0x1002,13));
		CDeaths(P6,AtLeast,1,CCode(0x1002,16));
		CDeaths(P6,AtLeast,1,CCode(0x1002,17));
		CDeaths(P6,AtLeast,1,CCode(0x1002,21));
		CDeaths(P6,AtLeast,1,CCode(0x1002,22));
		CDeaths(P6,AtLeast,1,CCode(0x1002,25));
	},
	actions = {
		SetCDeaths(P6,Add,1,EZCon);
	},
}
Trigger { -- 나머지건물, 함정하이브 파괴시 수정광산 무적해제 이지
	players = {P6},
	conditions = { 
		Label(0);
		CDeaths(P6,Exactly,1,Difficulty);
		CDeaths(P6,Exactly,2,EZCon);
		CDeaths(P6,AtLeast,1,CCode(0x1002,0));
		CDeaths(P6,AtLeast,1,CCode(0x1002,1));
		CDeaths(P6,AtLeast,1,CCode(0x1002,2));
		CDeaths(P6,AtLeast,1,CCode(0x1002,3));
		CDeaths(P6,AtLeast,1,CCode(0x1002,8));
		CDeaths(P6,AtLeast,1,CCode(0x1002,9));
		CDeaths(P6,AtLeast,1,CCode(0x1002,10));
		CDeaths(P6,AtLeast,1,CCode(0x1002,11));
		CDeaths(P6,AtLeast,1,CCode(0x1002,0));
		CDeaths(P6,AtLeast,1,CCode(0x1002,1));
		CDeaths(P6,AtLeast,1,CCode(0x1002,2));
		CDeaths(P6,AtLeast,1,CCode(0x1002,3));
	},
	actions = {
		RotatePlayer({
			MinimapPing(192),
			MinimapPing(193),
			PlayWAVX("staredit\\wav\\start.ogg"),
			DisplayTextX("\n\n\n\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\n\n\x13\x10【 U\x04nknown \x10C\x04rystal \x10】 \x04의 \x02무적상태\x04가 해제되었습니다.\n\n\n\x13\x04！！！　\x02ＵＮＬＯＣＫ\x04　！！！\n\x13\x04――――――――――――――――――――――――――――――――――――――――――――――――――――――",4)
		},HumanPlayers,FP);
		SetInvincibility(Disable,173,Force2,"Anywhere");

	},
}



Trigger { -- 수정산 파괴 후 브금 끝날 시 보스브금재생, 보스출현 이지모드
	players = {P6},
	conditions = {
		Label(0);
		DeathsX(0,AtMost,0,440,0xFFFFFF);
		DeathsX(1,AtMost,0,440,0xFFFFFF);
		DeathsX(2,AtMost,0,440,0xFFFFFF);
		DeathsX(3,AtMost,0,440,0xFFFFFF);
		DeathsX(4,AtMost,0,440,0xFFFFFF);
		Memory(0x58F494,AtMost,0);
		CDeaths(P6,Exactly,1,CCode(0x1002,45));
		CDeaths(P6,Exactly,1,Difficulty);
	},
	actions = {
		PauseTimer();
		SetDeaths(Force2,SetTo,0,173);
		GiveUnits(1,64,P12,"Anywhere",P6);
		SetAllianceStatus(Force1,Ally);
		Order(64,P6,"Anywhere",Move,"Anywhere");
		SetCDeaths(P6,SetTo,8,BGMType);
		},
	}

CIfEnd() -- 이지 단락
--CIf(FP,{Switch("Switch 103",Cleared),Bring(AllPlayers,AtMost,0,175,64),BYD})
--CIfEnd()

Trigger { -- 젤나가 전부 부술시 타이머 삭제 조건
	players = {P6},
	conditions = {
		Label(0);
		CDeaths("X",Exactly,1,CCode(0x1002,20));
		CDeaths("X",Exactly,1,CCode(0x1002,21));
		CDeaths("X",Exactly,1,CCode(0x1002,22));
		CDeaths("X",Exactly,1,CCode(0x1002,23));
	},
	actions = {
		SetSwitch("Switch 103",Set);
	},
}

CIfOnce(P6,Switch("Switch 103",Set))
CIf(FP,NBYD)
CMov(FP,0x58D6F4,_Div(_ReadF(0x58D6F4),_Mov(2)))
CIfEnd()
Points = 4
SizeofPolygon = 7
Radius = 64
Angle = 0
StarAngle = 270
CreateUnitStarSafeGun(P6,{FTRBYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),4,64,Radius,Angle,Points,StarAngle,1,P8,{1,162})
CIfEnd()


CIf(Force1,CDeaths(P6,AtLeast,1,BunkerEnable))
for NB = 0, 3 do -- 중벙 트리거
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,1,GMode);
		Bring(CurrentPlayer,AtLeast,1,"Men",NB+13);
		Bring(P12,AtLeast,1,125,NB+13);
	},
	actions = {
		GiveUnits(All,125,P12,NB+13,CurrentPlayer);
		PreserveTrigger();
	},
}
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,1,GMode);
		Bring(CurrentPlayer,Exactly,0,"Men",NB+13);
		Bring(CurrentPlayer,AtLeast,1,125,NB+13);
	},
	actions = {
		GiveUnits(All,125,CurrentPlayer,NB+13,P12);
		PreserveTrigger();
	},
}
end
for NB = 0, 4 do -- 중벙 트리거
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,1,GMode);
		Command(NB,AtMost,0,111);
		Bring(CurrentPlayer,AtLeast,1,"Men",NB+204);
		Bring(P12,AtLeast,1,125,NB+204);
	},
	actions = {
		GiveUnits(All,125,P12,NB+204,CurrentPlayer);
		PreserveTrigger();
	},
}
Trigger {
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(FP,AtMost,1,GMode);
		Command(NB,AtMost,0,111);
		Bring(CurrentPlayer,Exactly,0,"Men",NB+204);
		Bring(CurrentPlayer,AtLeast,1,125,NB+204);
	},
	actions = {
		GiveUnits(All,125,CurrentPlayer,NB+204,P12);
		PreserveTrigger();
	},
}
end
CIfEnd()
-- 영침트리거

CIf(Force1,{Command(Force2,AtLeast,1,150)})
Trigger {
	players = {P6},
	conditions = { 
		Bring(Force1,AtLeast,1,"Factories",157);
	},
	actions = {
		SetInvincibility(Disable,68,P12,148);
		SetInvincibility(Disable,68,P12,145);
		GiveUnits(All,68,P12,148,P7);
		GiveUnits(All,68,P12,145,P7);
		Order(68,P7,148,Attack,157);
		Order(68,P7,145,Attack,157);
		
	},
}
Trigger {
	players = {P6},
	conditions = { 
		Bring(Force1,AtLeast,1,"Factories",162);
	},
	actions = {
		SetInvincibility(Disable,68,P12,147);
		SetInvincibility(Disable,68,P12,146);
		GiveUnits(All,68,P12,147,P7);
		GiveUnits(All,68,P12,146,P7);
		Order(68,P7,147,Attack,162);
		Order(68,P7,146,Attack,162);
		
	},
}
CIf(P6,HD)
Trigger {
	players = {P6},
	conditions = { 
		Bring(Force2,AtMost,0,150,147);
	},
	actions = {
		RotatePlayer({
			MinimapPing(159),
			PlayWAVX("staredit\\wav\\start.ogg"),
			PlayWAVX("staredit\\wav\\start.ogg")
		},HumanPlayers,FP);
		
	},
}
Trigger {
	players = {P6},
	conditions = { 
		Bring(Force2,AtMost,0,150,146);
	},
	actions = {
		RotatePlayer({
			MinimapPing(158),
			PlayWAVX("staredit\\wav\\start.ogg"),
			PlayWAVX("staredit\\wav\\start.ogg")
		},HumanPlayers,FP);
		
	},
}
Trigger {
	players = {P6},
	conditions = { 
		Bring(Force2,AtMost,0,150,145);
	},
	actions = {
		RotatePlayer({
			MinimapPing(161),
			PlayWAVX("staredit\\wav\\start.ogg"),
			PlayWAVX("staredit\\wav\\start.ogg")
		},HumanPlayers,FP);
		
	},
}
Trigger {
	players = {P6},
	conditions = { 
		Bring(Force2,AtMost,0,150,148);
	},
	actions = {
		RotatePlayer({
			MinimapPing(160),
			PlayWAVX("staredit\\wav\\start.ogg"),
			PlayWAVX("staredit\\wav\\start.ogg")
		},HumanPlayers,FP);
	},
}
CIfEnd()
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",AtMost,0,TTCon1);
		Bring(CurrentPlayer,AtLeast,1,"Factories",157);
	},
	actions = {
		SetCDeaths("X",SetTo,1,TTCon1);
		PreserveTrigger();
	},
}
TT_Invincible1 = CreateCCode(ExDeaths1)
TT_Invincible2 = CreateCCode(ExDeaths1)
BYDTTCondTable = {}
BYDTTCondTable2 = {}
for i = 0, 4 do
table.insert(BYDTTCondTable,Bring(i,AtMost,0,MarID[i+1],157))
table.insert(BYDTTCondTable2,Bring(i,AtMost,0,MarID[i+1],162))
end
for i = 0, 4 do

Trigger {
	players = {i},
	conditions = { 
		Label(0);
		BYD;
		CDeaths(FP,Exactly,0,TT_Invincible1);
		BYDTTCondTable;
	},
	actions = {
		SetInvincibility(Enable,150,Force2,148);
		SetInvincibility(Enable,150,Force2,145);
		SetCDeaths(FP,SetTo,1,TT_Invincible1);
		PreserveTrigger();
	},
}
Trigger {
	players = {i},
	conditions = { 
		Label(0);
		BYD;
		CDeaths(FP,Exactly,0,TT_Invincible2);
		BYDTTCondTable2;
	},
	actions = {
		SetInvincibility(Enable,150,Force2,147);
		SetInvincibility(Enable,150,Force2,146);
		SetCDeaths(FP,SetTo,1,TT_Invincible2);
		PreserveTrigger();
	},
}
Trigger {
	players = {i},
	conditions = { 
		Label(0);
		BYD;
		CDeaths(FP,Exactly,1,TT_Invincible1);
		Bring(i,AtLeast,1,MarID[i+1],157);
	},
	actions = {
		SetInvincibility(Disable,150,Force2,148);
		SetInvincibility(Disable,150,Force2,145);
		SetCDeaths(FP,SetTo,0,TT_Invincible1);
		PreserveTrigger();
	},
}
Trigger {
	players = {i},
	conditions = { 
		Label(0);
		BYD;
		CDeaths(FP,Exactly,1,TT_Invincible2);
		Bring(i,AtLeast,1,MarID[i+1],162);
	},
	actions = {
		SetInvincibility(Disable,150,Force2,147);
		SetInvincibility(Disable,150,Force2,146);
		SetCDeaths(FP,SetTo,0,TT_Invincible2);
		PreserveTrigger();
	},
}

end
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",AtMost,0,TTCon2);
		Bring(CurrentPlayer,AtLeast,1,"Factories",162);
	},
	actions = {
		SetCDeaths("X",SetTo,1,TTCon2);
		PreserveTrigger();
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",Exactly,1,TTCon1);
		CDeaths("X",Exactly,0,TTAct1);
		Bring(CurrentPlayer,AtLeast,1,"Factories",145);
		Bring(CurrentPlayer,AtMost,0,"Factories",157);
		Bring(Force2,AtLeast,1,150,146);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTCon1);
		SetCDeaths("X",SetTo,1,TTAct1);
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		FTRBYD;
		CDeaths("X",Exactly,1,TTAct1);
		CDeaths(P6,AtMost,1,TTFTR);
		Bring(Force2,AtLeast,1,150,146);
	},
	actions = {
		KillUnitAt(1,150,146,Force2);
		SetCDeaths(P6,Add,1,TTFTR);
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",Exactly,1,TTCon1);
		CDeaths("X",Exactly,0,TTAct2);
		Bring(CurrentPlayer,AtLeast,1,"Factories",148);
		Bring(CurrentPlayer,AtMost,0,"Factories",157);
		Bring(Force2,AtLeast,1,150,147);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTCon1);
		SetCDeaths("X",SetTo,1,TTAct2);
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		FTRBYD;
		CDeaths("X",Exactly,1,TTAct2);
		CDeaths(P6,AtMost,1,TTFTR);
		Bring(Force2,AtLeast,1,150,147);
		
	},
	actions = {
		KillUnitAt(1,150,147,Force2);
		SetCDeaths(P6,Add,1,TTFTR);
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",Exactly,1,TTCon2);
		CDeaths("X",Exactly,0,TTAct3);
		Bring(CurrentPlayer,AtLeast,1,"Factories",147);
		Bring(CurrentPlayer,AtMost,0,"Factories",162);
		Bring(Force2,AtLeast,1,150,148);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTCon2);
		SetCDeaths("X",SetTo,1,TTAct3);
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		FTRBYD;
		CDeaths("X",Exactly,1,TTAct3);
		CDeaths(P6,AtMost,1,TTFTR);
		Bring(Force2,AtLeast,1,150,148);
		
	},
	actions = {
		KillUnitAt(1,150,148,Force2);
		SetCDeaths(P6,Add,1,TTFTR);
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",Exactly,1,TTCon2);
		CDeaths("X",Exactly,0,TTAct4);
		Bring(CurrentPlayer,AtLeast,1,"Factories",146);
		Bring(CurrentPlayer,AtMost,0,"Factories",162);
		Bring(Force2,AtLeast,1,150,145);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTCon2);
		SetCDeaths("X",SetTo,1,TTAct4);
	},
}
Trigger {
	players = {Force1},
	conditions = { 
		Label(0);
		FTRBYD;
		CDeaths("X",Exactly,1,TTAct4);
		CDeaths(P6,AtMost,1,TTFTR);
		Bring(Force2,AtLeast,1,150,145);
		
	},
	actions = {
		KillUnitAt(1,150,145,Force2);
		SetCDeaths(P6,Add,1,TTFTR);
	},
}
Points = 4
SizeofPolygon = 4
Radius = 48
Angle = 45
CIfOnce(Force1,CDeaths("X",Exactly,1,TTAct1))
CreateUnitPolygonSafe2Gun(Force1,{HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 5
Radius = 41
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 6
Radius = 32
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P7,{1,51})

Trigger { -- 1
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Cleared);
	},
	actions = {
		CreateUnit(1,65,145,P8);
	},
}
Trigger { -- 1
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Set);
	},
	actions = {
		CreateUnit(1,66,145,P8);
	},
}
Trigger { -- 1
	players = {Force1},
	conditions = { 
		Label(0);
		FTR;
	},
	actions = {
		CreateUnit(1,65,145,P8);
		CreateUnit(1,66,145,P8);
		CreateUnit(1,67,145,P8);
	},
}

Trigger { -- 1
	players = {Force1},
	conditions = { 
		Label(0);
		BYD;
	},
	actions = {
		CreateUnit(1,57,146,P8);
		CreateUnit(1,3,146,P8);
		CreateUnit(1,81,146,P8);
	},
}
Points = 6
SizeofPolygon = 1
Radius = 48
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{NBYD,Switch("Switch 1",Set),Bring(Force2,AtMost,0,150,145),Bring(Force2,AtLeast,1,150,146)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P8,{1,102})
CreateUnitPolygonSafe2Gun(Force1,{BYD,Switch("Switch 1",Set),Bring(Force2,AtMost,0,150,145),Bring(Force2,AtLeast,1,150,146)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P8,{1,64})
CreateUnitPolygonSafe2Gun(Force1,{Switch("Switch 1",Cleared),Bring(Force2,AtMost,0,150,145),Bring(Force2,AtLeast,1,150,146)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),157,32,Radius,Angle,Points,0,P8,{1,23})
Trigger { -- Act1Comp
	players = {Force1},
	conditions = { 
		Label(0);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTAct1);
	},
}

CIfEnd()
CIfOnce(Force1,CDeaths("X",Exactly,1,TTAct2))
Points = 4
SizeofPolygon = 5
Radius = 48
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 5
Radius = 41
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 6
Radius = 32
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P7,{1,51})
Trigger { -- 2
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Set);
	},
	actions = {
		CreateUnit(1,65,148,P8);
	},
}
Trigger { -- 2
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Cleared);
	},
	actions = {
		CreateUnit(1,66,148,P8);
	},
}
Trigger { -- 2
	players = {Force1},
	conditions = { 
		Label(0);
		FTR;
	},
	actions = {
		CreateUnit(1,65,148,P8);
		CreateUnit(1,66,148,P8);
		CreateUnit(1,67,148,P8);
	},
}

Trigger { -- 2
	players = {Force1},
	conditions = { 
		Label(0);
		BYD;
	},
	actions = {
		CreateUnit(1,57,146,P8);
		CreateUnit(1,3,146,P8);
		CreateUnit(1,81,146,P8);
	},
}
Points = 6
SizeofPolygon = 1
Radius = 48
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{Switch("Switch 1",Set),Bring(Force2,AtMost,0,150,148),Bring(Force2,AtLeast,1,150,147)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P8,{1,23})
CreateUnitPolygonSafe2Gun(Force1,{NBYD,Switch("Switch 1",Cleared),Bring(Force2,AtMost,0,150,148),Bring(Force2,AtLeast,1,150,147)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P8,{1,102})
CreateUnitPolygonSafe2Gun(Force1,{BYD,Switch("Switch 1",Cleared),Bring(Force2,AtMost,0,150,148),Bring(Force2,AtLeast,1,150,147)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),158,32,Radius,Angle,Points,0,P8,{1,64})
Trigger { -- Act2Comp
	players = {Force1},
	conditions = { 
		Label(0);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTAct2);
	},
}
CIfEnd()
CIfOnce(Force1,CDeaths("X",Exactly,1,TTAct3))
Points = 4
SizeofPolygon = 5
Radius = 48
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 5
Radius = 41
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 6
Radius = 32
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P7,{1,51})
Trigger { -- 3
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Set);
	},
	actions = {
		CreateUnit(1,65,147,P8);
	},
}
Trigger { -- 3
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Cleared);
	},
	actions = {
		CreateUnit(1,66,147,P8);
	},
}
Trigger { -- 3
	players = {Force1},
	conditions = { 
		Label(0);
		FTR;
	},
	actions = {
		CreateUnit(1,65,147,P8);
		CreateUnit(1,66,147,P8);
		CreateUnit(1,67,147,P8);
	},
}
Trigger { -- 3
	players = {Force1},
	conditions = { 
		Label(0);
		BYD;
	},
	actions = {
		CreateUnit(1,57,146,P8);
		CreateUnit(1,3,146,P8);
		CreateUnit(1,81,146,P8);
	},
}
Points = 6
SizeofPolygon = 1
Radius = 48
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{NBYD,Switch("Switch 1",Set),Bring(Force2,AtMost,0,150,147),Bring(Force2,AtLeast,1,150,148)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P8,{1,102})
CreateUnitPolygonSafe2Gun(Force1,{BYD,Switch("Switch 1",Set),Bring(Force2,AtMost,0,150,147),Bring(Force2,AtLeast,1,150,148)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P8,{1,64})
CreateUnitPolygonSafe2Gun(Force1,{Switch("Switch 1",Cleared),Bring(Force2,AtMost,0,150,147),Bring(Force2,AtLeast,1,150,148)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),159,32,Radius,Angle,Points,0,P8,{1,23})
Trigger { -- Act3Comp
	players = {Force1},
	conditions = { 
		Label(0);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTAct3);
	},
}
CIfEnd()
CIfOnce(Force1,CDeaths("X",Exactly,1,TTAct4))
Points = 4
SizeofPolygon = 5
Radius = 48
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{HD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 5
Radius = 41
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{FTR},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P7,{1,51})
Points = 4
SizeofPolygon = 6
Radius = 32
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{BYD},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P7,{1,51})
Trigger { -- 4
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Cleared);
	},
	actions = {
		CreateUnit(1,65,146,P8);
	},
}
Trigger { -- 4
	players = {Force1},
	conditions = { 
		Label(0);
		HD;
		Switch("Switch 1",Set);
	},
	actions = {
		CreateUnit(1,66,146,P8);
	},
}
Trigger { -- 4
	players = {Force1},
	conditions = { 
		Label(0);
		FTR;
	},
	actions = {
		CreateUnit(1,65,146,P8);
		CreateUnit(1,66,146,P8);
		CreateUnit(1,67,146,P8);
	},
}

Trigger { -- 4
	players = {Force1},
	conditions = { 
		Label(0);
		BYD;
	},
	actions = {
		CreateUnit(1,57,146,P8);
		CreateUnit(1,3,146,P8);
		CreateUnit(1,81,146,P8);
	},
}

Points = 6
SizeofPolygon = 1
Radius = 48
Angle = 45
CreateUnitPolygonSafe2Gun(Force1,{Switch("Switch 1",Set),Bring(Force2,AtMost,0,150,146),Bring(Force2,AtLeast,1,150,145)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P8,{1,23})
CreateUnitPolygonSafe2Gun(Force1,{NBYD,Switch("Switch 1",Cleared),Bring(Force2,AtMost,0,150,146),Bring(Force2,AtLeast,1,150,145)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P8,{1,102})
CreateUnitPolygonSafe2Gun(Force1,{BYD,Switch("Switch 1",Cleared),Bring(Force2,AtMost,0,150,146),Bring(Force2,AtLeast,1,150,145)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),160,32,Radius,Angle,Points,0,P8,{1,64})
Trigger { -- Act4Comp
	players = {Force1},
	conditions = { 
		Label(0);
		
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTAct4);
	},
}
CIfEnd()

Trigger { -- Con1Reset
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",AtLeast,1,TTCon1);
		Bring(CurrentPlayer,AtMost,0,"Factories",157);
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTCon1);
		PreserveTrigger();
	},
}
Trigger { -- Con2Reset
	players = {Force1},
	conditions = { 
		Label(0);
		CDeaths("X",AtLeast,1,TTCon2);
		Bring(CurrentPlayer,AtMost,0,"Factories",162);
	},
	actions = {
		SetCDeaths("X",SetTo,0,TTCon2);
		PreserveTrigger();
	},
}

CIfEnd()

CIfX(Force1,CDeaths(FP,AtMost,0,BYDBossStart2))
Trigger { -- 메딕트리거
	players = {Force1},
	conditions = {
		Command(CurrentPlayer, AtLeast, 1, 34);
	},
	actions = {
		ModifyUnitHitPoints(All, "Men", CurrentPlayer, "Anywhere", 100);
		ModifyUnitHitPoints(All, "Buildings", CurrentPlayer, "Anywhere", 100);
		SetDeaths(CurrentPlayer,Add,1,"Terran Medic");
		RemoveUnitAt(1,34,"Anywhere",CurrentPlayer);
		PlayWAV("staredit\\wav\\heal.ogg");
		PreserveTrigger();
	},
}
Trigger { -- 메딕트리거
	players = {Force1},
	conditions = {
		Command(CurrentPlayer, AtLeast, 1, 9);
	},
	actions = {
		ModifyUnitHitPoints(All, "Men", CurrentPlayer, "Anywhere", 100);
		ModifyUnitHitPoints(All, "Buildings", CurrentPlayer, "Anywhere", 100);
		SetDeaths(CurrentPlayer,Add,1,"Terran Medic");
		RemoveUnitAt(1,9,"Anywhere",CurrentPlayer);
		PlayWAV("staredit\\wav\\heal.ogg");
		PreserveTrigger();
	},
}
CElseX()

Trigger { -- 메딕트리거
	players = {Force1},
	conditions = {
		Command(CurrentPlayer, AtLeast, 1, 34);
	},
	actions = {
		BYDBossMarHPRecover;
		ModifyUnitHitPoints(All, "Men", CurrentPlayer, "Anywhere", 100);
		ModifyUnitHitPoints(All, "Buildings", CurrentPlayer, "Anywhere", 100);
		BYDBossMarHPPatch;
		SetDeaths(CurrentPlayer,Add,1,"Terran Medic");
		RemoveUnitAt(1,34,"Anywhere",CurrentPlayer);
		PlayWAV("staredit\\wav\\heal.ogg");
		PreserveTrigger();
	},
}
Trigger { -- 메딕트리거
	players = {Force1},
	conditions = {
		Command(CurrentPlayer, AtLeast, 1, 9);
	},
	actions = {
		BYDBossMarHPRecover;
		ModifyUnitHitPoints(All, "Men", CurrentPlayer, "Anywhere", 100);
		ModifyUnitHitPoints(All, "Buildings", CurrentPlayer, "Anywhere", 100);
		BYDBossMarHPPatch;
		SetDeaths(CurrentPlayer,Add,1,"Terran Medic");
		RemoveUnitAt(1,9,"Anywhere",CurrentPlayer);
		PlayWAV("staredit\\wav\\heal.ogg");
		PreserveTrigger();
	},
}
CIfXEnd()
for i = 1, 4 do -- 강퇴기능
Trigger { -- 강퇴토큰
	players = {P1},
	conditions = {
		Label(0);
		Command(P1,AtLeast,1,BanToken[i]);
	},
	actions = {
		RemoveUnitAt(1,BanToken[i],"Anywhere",P1);
		SetCDeaths(P6,Add,1,BanCCode[i]);
		PreserveTrigger();
		},
	}
Trigger { -- 강퇴
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,5,BanCCode[i]);
	},
	actions = {
		RotatePlayer({DisplayTextX("\x07『 \x04"..Player[i+1].."\x04의 강퇴처리가 완료되었습니다.\x07 』",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,i);
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		PlayWAV("sound\\Protoss\\ARCHON\\PArDth00.WAV");
		DisplayText("\x07『 \x04당신은 강되당했습니다.\x07 』",4);
		Defeat();
		},
	}
end
CIf(Force1,Command(CurrentPlayer,AtLeast,1,"Protoss Reaver"))

Trigger { -- 기부 금액 변경
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths("X",Exactly,0,GiveRate);
		Command(CurrentPlayer,AtLeast,1,"Protoss Reaver");
	},
	actions = {
		GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",P12);
		RemoveUnitAt(All,"Protoss Reaver","Anywhere",P12);
		DisplayText("\x07『 \x04기부금액 단위가 \x1F5000 Ore\x04 \x04로 변경되었습니다.\x07 』",4);
		SetCDeaths("X",SetTo,1,GiveRate);
		PreserveTrigger();
},
}
Trigger { -- 기부 금액 변경
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths("X",Exactly,1,GiveRate);
		Command(CurrentPlayer,AtLeast,1,"Protoss Reaver");
	},
	actions = {
		GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",P12);
		RemoveUnitAt(All,"Protoss Reaver","Anywhere",P12);
		DisplayText("\x07『 \x04기부금액 단위가 \x1F10000 Ore \x04로 변경되었습니다.\x07 』",4);
		SetCDeaths("X",SetTo,2,GiveRate);
		PreserveTrigger();
},
}
Trigger { -- 기부 금액 변경
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths("X",Exactly,2,GiveRate);
		Command(CurrentPlayer,AtLeast,1,"Protoss Reaver");
	},
	actions = {
		GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",P12);
		RemoveUnitAt(All,"Protoss Reaver","Anywhere",P12);
		DisplayText("\x07『 \x04기부금액 단위가 \x1F50000 Ore \x04로 변경되었습니다.\x07 』",4);
		SetCDeaths("X",SetTo,3,GiveRate);
		PreserveTrigger();
},
}
Trigger { -- 기부 금액 변경
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths("X",Exactly,3,GiveRate);
		Command(CurrentPlayer,AtLeast,1,"Protoss Reaver");
	},
	actions = {
		GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",P12);
		RemoveUnitAt(All,"Protoss Reaver","Anywhere",P12);
		DisplayText("\x07『 \x04기부금액 단위가 \x1F100000 Ore \x04로 변경되었습니다.\x07 』",4);
		SetCDeaths("X",SetTo,4,GiveRate);
		PreserveTrigger();
},
}
Trigger { -- 기부 금액 변경
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths("X",Exactly,4,GiveRate);
		Command(CurrentPlayer,AtLeast,1,"Protoss Reaver");
	},
	actions = {
		GiveUnits(All,"Protoss Reaver",CurrentPlayer,"Anywhere",P12);
		RemoveUnitAt(All,"Protoss Reaver","Anywhere",P12);
		DisplayText("\x07『 \x04기부금액 단위가 \x1F1000 Ore \x04로 변경되었습니다.\x07 』",4);
		SetCDeaths("X",SetTo,0,GiveRate);
		PreserveTrigger();
},
}
CIfEnd()
Trigger { -- BGM On Off
	players = {Force1},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,0,440,0xFF000000);
		Command(CurrentPlayer,AtLeast,1,22);
	},
	actions = {
		GiveUnits(All,22,CurrentPlayer,"Anywhere",P12);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText("\x07『 \x1CBGM\x04을 듣지 않습니다. \x07』",4);
		SetDeathsX(CurrentPlayer,SetTo,1*16777216,440,0xFF000000);
		PreserveTrigger();
		},
	}
Trigger { -- BGM On Off
	players = {Force1},
	conditions = {
		DeathsX(CurrentPlayer,Exactly,1*16777216,440,0xFF000000);
		Command(CurrentPlayer,AtLeast,1,22);
	},
	actions = {
		GiveUnits(All,22,CurrentPlayer,"Anywhere",P12);
		RemoveUnitAt(All,22,"Anywhere",P12);
		DisplayText("\x07『 \x1CBGM\x04을 듣습니다. \x07』",4);
		SetDeathsX(CurrentPlayer,SetTo,0*16777216,440,0xFF000000);
		PreserveTrigger();
	},
}

for i=0, 4 do -- i = 플레이어 아이디

Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,Exactly,0,Test1);
		Command(i,AtLeast,1,72);
	},
	actions = {
		DisplayText("\x07『 \x1D예약메딕\x04 기능을 사용합니다. - \x1F350 Ore\x07 』",4);
		GiveUnits(All,72,i,"Anywhere",P12);
		RemoveUnitAt(1,72,"Anywhere",P12);
		SetMemoryB(0x57F27C+(228*i)+9,SetTo,1); -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		SetMemoryB(0x57F27C+(228*i)+34,SetTo,0);
		SetCDeaths(i,SetTo,1,Test1);
		PreserveTrigger();
	},
}
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,Exactly,1,Test1);
		Command(i,AtLeast,1,72);
	},
	actions = {
		DisplayText("\x07『 \x1D예약메딕\x04 기능을 \x1B사용하지\x04 않습니다. - \x1F250 Ore\x07 』",4);
		GiveUnits(All,72,i,"Anywhere",P12);
		RemoveUnitAt(1,72,"Anywhere",P12);
		SetMemoryB(0x57F27C+(228*i)+9,SetTo,0);
		SetMemoryB(0x57F27C+(228*i)+34,SetTo,1);
		SetCDeaths(i,SetTo,0,Test1);
		PreserveTrigger();
	},
}
CIf(i,Deaths(i,AtMost,159999,432))
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Deaths(i,Exactly,0,"【 Zergling 】");
		Command(i,AtLeast,1,54);
	},
	actions = {
		DisplayText("\x07『 \x04환전 모드를 \x08HP\x04로 설정합니다.\x07 』",4);
		SetDeaths(i,SetTo,1,"【 Zergling 】");
		GiveUnits(All,54,CurrentPlayer,"Anywhere",P12);
		PreserveTrigger();
	},
}
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Deaths(i,Exactly,0,"【 Zergling 】");
		Deaths(i,AtMost,159999,432);
	},
	actions = {
		SetMemoryB(0x57F27C+(228*i)+54,SetTo,1); -- 9, 34 활성화하고 비활성화할 유닛 인덱스
		SetMemoryB(0x57F27C+(228*i)+53,SetTo,0);
		PreserveTrigger();
	},
}
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Deaths(i,Exactly,1,"【 Zergling 】");
		Command(i,AtLeast,1,53);
	},
	actions = {
		DisplayText("\x07『 \x04환전 모드를 \x1FOre\x04로 설정합니다.\x07 』",4);
		SetDeaths(i,SetTo,0,"【 Zergling 】");
		GiveUnits(All,53,CurrentPlayer,"Anywhere",P12);
		PreserveTrigger();
	},
}


Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Deaths(i,Exactly,1,"【 Zergling 】");
		Deaths(i,AtMost,159999,432);
	},
	actions = {

		SetMemoryB(0x57F27C+(228*i)+54,SetTo,0); -- 활성화하고 비활성화할 유닛 인덱스
		SetMemoryB(0x57F27C+(228*i)+53,SetTo,1);
		PreserveTrigger();
	},
}
Trigger {
	players = {i},
	conditions = {
		Accumulate(i,AtLeast,1000000,Ore);
		Deaths(i,AtMost,159999,432);
	},
	actions = {
		DisplayText("\x13\x02!!!!주의 \x07『 \x04미네랄에 비해 체력이 현저히 적어 자동으로 체력 환전 모드를 ON 하였습니다.\x07 』 \x02주의!!!!",4);
		PlayWAV("sound\\Terran\\bldg\\tddwht00.WAV");
		PlayWAV("sound\\Terran\\bldg\\tddwht00.WAV");
		PlayWAV("sound\\Terran\\bldg\\tddwht00.WAV");
		PlayWAV("sound\\Terran\\bldg\\tddwht00.WAV");
		SetDeaths(i,SetTo,1,"【 Zergling 】");
	}
}
DoActionsP({RemoveUnitAt(1,53,"Anywhere",P12),RemoveUnitAt(1,54,"Anywhere",P12)},i)
CIfEnd()
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Deaths(i,AtLeast,160000,432);
		NBYD;
	},
	actions = {
		SetDeaths(i,SetTo,0,"【 Zergling 】");
		SetMemoryB(0x57F27C+(228*i)+54,SetTo,0); -- 활성화하고 비활성화할 유닛 인덱스
		SetMemoryB(0x57F27C+(228*i)+53,SetTo,0);
	},
}
Trigger { -- 예약메딕
	players = {i},
	conditions = {
		Deaths(i,AtLeast,130000,432);
		BYD;
	},
	actions = {
		SetDeaths(i,SetTo,0,"【 Zergling 】");
		SetMemoryB(0x57F27C+(228*i)+54,SetTo,0); -- 활성화하고 비활성화할 유닛 인덱스
		SetMemoryB(0x57F27C+(228*i)+53,SetTo,0);
	},
}

CIf(i,CDeaths(P6,Exactly,0,GMode))
Trigger { -- 공업완료시 수정보호막 활성화
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		MemoryB(0x58D2B0+(46*i)+7,AtLeast,255);
	},
	actions = {
		PlayWAV("staredit\\wav\\shield_unlock.ogg");
		PlayWAV("staredit\\wav\\shield_unlock.ogg");
		SetMemory(0x58F4B0+(4*i),SetTo,3200);
		SetCDeaths(i,SetTo,1,ShieldUnlock);
	},
}
Trigger { -- 공업완료시 수정보호막 활성화
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(i,AtLeast,1,ShieldUnlock);
		CDeaths(P6,AtMost,2,Difficulty);
		MemoryB(0x58D2B0+(46*i)+7,AtLeast,255);
		Memory(0x58F4B0+(4*i),AtMost,0);
	},
	actions = {
		DisplayText(string.rep("\n", 20),4);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
		DisplayText("\n",4);
		DisplayText("\x13\x03공격력 \x04업그레이드를 완료하였습니다.\n\x13\x04이제부터 \x1C빛의 보호막\x04을 사용할 수 있습니다.",0);
		DisplayText("\n",4);
		DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		SetMemory(0x5822C4+(i*4),SetTo,800);
		SetMemory(0x582264+(i*4),SetTo,800);
		SetMemoryB(0x57F27C+(228*i)+19,SetTo,1);
	},
}
Trigger { -- 공업완료시 수정보호막 활성화
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(i,AtLeast,1,ShieldUnlock);
		CDeaths(P6,Exactly,3,Difficulty);
		MemoryB(0x58D2B0+(46*i)+7,AtLeast,255);
		Memory(0x58F4B0+(4*i),AtMost,0);
	},
	actions = {
		DisplayText(string.rep("\n", 20),4);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
		DisplayText("\n",4);
		DisplayText("\x13\x03공격력 \x04업그레이드를 완료하였습니다.\n\x13\x04이제부터 \x1C빛의 보호막\x04을 사용할 수 있습니다.",0);
		DisplayText("\n",4);
		DisplayText("\x13\x0FＳＫＩＬＬ　ＵＮＬＯＣＫＥＤ",0);
		DisplayText("\x13\x04"..string.rep("―", 56),4);
		SetMemory(0x5822C4+(i*4),SetTo,1200);
		SetMemory(0x582264+(i*4),SetTo,1200);
		SetMemoryB(0x57F27C+(228*i)+19,SetTo,1);
	},
}

Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(P6,AtMost,2,Difficulty);
		Memory(0x582294+(4*i),AtLeast,200);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetResources(i,Add,30000,Ore);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText("\x07『 \x04이미 \x1C빛의 보호막\x04을 사용중입니다. 자원 반환 + \x1F30000 Ore\x07』",4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(P6,Exactly,3,Difficulty);
		Memory(0x582294+(4*i),AtLeast,1200);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetResources(i,Add,30000,Ore);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText("\x07『 \x04이미 \x1C빛의 보호막\x04을 사용중입니다. 자원 반환 + \x1F30000 Ore\x07』",4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(P6,Exactly,3,Difficulty);
		Memory(0x582294+(4*i),AtLeast,1);
		Memory(0x582294+(4*i),AtMost,1199);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetResources(i,Add,30000,Ore);
		RemoveUnitAt(1,19,"Anywhere",i);
		DisplayText("\x07『 \x1C빛의 보호막\x04이 현재 \x0E쿨타임 \x04중입니다. 자원 반환 + \x1F30000 Ore\x07』",4);
		PlayWAV("sound\\Misc\\PError.WAV");
		PlayWAV("sound\\Misc\\PError.WAV");
		PreserveTrigger();
	},
}

Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(P6,AtMost,2,Difficulty);
		Memory(0x582294+(4*i),AtMost,199);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetMemory(0x582294+(4*i),SetTo,800);
		RemoveUnitAt(1,19,"Anywhere",i);
		RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..Player[i+1].."Shield".._0D,4),PlayWAVX("staredit\\wav\\shield_use.ogg")},HumanPlayers,i);
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(P6,Exactly,3,Difficulty);
		Memory(0x582294+(4*i),Exactly,0);
		Command(i,AtLeast,1,19);
	},
	actions = {
		SetMemory(0x582294+(4*i),SetTo,2000);
		RemoveUnitAt(1,19,"Anywhere",i);
		RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..Player[i+1].."Shield".._0D,4),PlayWAVX("staredit\\wav\\shield_use.ogg")},HumanPlayers,i);
		PreserveTrigger();
	},
}

Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(P6,AtMost,2,Difficulty);
		Memory(0x582294+(4*i),AtLeast,1);
	},
	actions = {
		SetCDeaths(i,SetTo,1,ShUsed);
		ModifyUnitShields(All,"Men",i,"Anywhere",100);
		PreserveTrigger();
	},
}

Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		CDeaths(P6,Exactly,3,Difficulty);
		Memory(0x582294+(4*i),AtLeast,1200);
	},
	actions = {
		SetCDeaths(i,SetTo,1,ShUsed);
		ModifyUnitShields(All,"Men",i,"Anywhere",100);
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		Memory(0x582294+(4*i),AtLeast,1);
	},
	actions = {
		SetMemory(0x582294+(4*i),Subtract,1);
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShUsed);
		CDeaths(P6,AtMost,2,Difficulty);
		Memory(0x582294+(4*i),AtMost,0);
	},
	actions = {
		DisplayText("\x07『 \x1C빛의 보호막\x04 사용이 종료되었습니다. \x07』",4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShUsed);
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShUsed);
		CDeaths(P6,Exactly,3,Difficulty);
		Memory(0x582294+(4*i),AtMost,1199);
	},
	actions = {
		DisplayText("\x07『 \x1C빛의 보호막\x04 사용이 종료되었습니다. \x07』",4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShUsed);
		SetCDeaths(i,SetTo,1,ShCool);
		PreserveTrigger();
	},
}
Trigger { -- 보호막 가동
	players = {i},
	conditions = {
		Label(0);
		CDeaths(i,AtLeast,1,ShCool);
		CDeaths(P6,Exactly,3,Difficulty);
		Memory(0x582294+(4*i),AtMost,0);
	},
	actions = {
		DisplayText("\x07『 \x1C빛의 보호막\x04 쿨타임이 종료되었습니다. \x07』",4);
		PlayWAV("staredit\\wav\\GMode.ogg");
		PlayWAV("staredit\\wav\\GMode.ogg");
		SetCDeaths(i,SetTo,0,ShCool);
		PreserveTrigger();
	},
}


Trigger { -- 스팀팩
	players = {i},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,GMode);
		Command(i,AtLeast,1,71);
	},
	actions = {
		SetDeaths(i,Add,1,71);
		RemoveUnitAt(1,71,"Anywhere",i);
		DisplayText("\x07『 \x04원격 \x1B스팀팩\x04기능을 사용합니다. - \x1F1000 Ore\x07 』",4);
		PreserveTrigger();
	},
}
CIfEnd()
end


NJump(Force1,0x1,{Deaths(CurrentPlayer,AtMost,0,"Terran Barracks"),Bring(CurrentPlayer,AtMost,0,"Men",6),Bring(CurrentPlayer,AtMost,0,"Men",7)})
for i=0, 4 do
CIf(i,Score(i,Kills,AtLeast,1000))
CMov(i,ExchangeP,_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
CAdd(i,{FP,ExScore[i+1][2],nil,"V"},_Div(_ReadF(0x581F04+(i*4)),_Mov(1000)))
CMov(i,0x581F04+(i*4),_Mod(_ReadF(0x581F04+(i*4)),_Mov(1000)))
CIfX(i,Deaths(CurrentPlayer,Exactly,0,"【 Zergling 】"))
CAdd(i,0x57F0F0+(i*4),_Mul(_Mul(ExchangeP,_Mov(10)),{FP,ExchangeRate[2],nil,"V"}))
CElseX()
CAdd(i,0x58F464+(i*4),_Mul(ExchangeP,{FP,ExchangeRate[2],nil,"V"}))
CIfXEnd()
CMov(FP,ExchangeP,0)
CIfEnd()
DoActions(i,SetDeaths(i,Subtract,1,111))
end
NJumpEnd(Force1,0x01)
NJump(Force1,0x13,{Bring(CurrentPlayer,AtMost,0,"Any unit",58),Bring(CurrentPlayer,AtMost,0,"Any unit",59)})

for j = 0, 4 do
for i = 0,1 do
Trigger { -- 조합 영웅마린
	players = {j},
	conditions = {
		Bring(j,AtLeast,1,32,58+i); 
		Accumulate(j,AtLeast,15000,Ore);
		Accumulate(j,AtMost,0x7FFFFFFF,Ore);
	},
	actions = {
		ModifyUnitEnergy(1,32,j,58+i,0);
		SetResources(j,Subtract,15000,ore);
		RemoveUnitAt(1,32,58+i,j);
		CreateUnitWithProperties(1,20,204+j,j,{energy = 100});
		DisplayText("\x07『 \x1F광물\x04을 소모하여 \x04Marine을 \x1BH \x04Marine으로 \x19변환\x04하였습니다. - \x1F15000 O r e \x07』",4);
		SetCDeaths(FP,Add,1,MarCreate);
		PreserveTrigger();
	},
}
Trigger { -- 조합 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		NBYD;
		CDeaths(P6,AtMost,0,EVMode);
		Deaths(j,AtLeast,10000,432);
		Bring(j,AtLeast,1,20,58+i);
		Accumulate(j,AtLeast,25000,Ore);
	},
	actions = {
		ModifyUnitEnergy(1,20,j,58+i,0);
		SetResources(j,Subtract,25000,ore);
		RemoveUnitAt(1,20,58+i,j);
		CreateUnitWithProperties(1,MarID[j+1],204+j,j,{energy = 100});
		SetDeaths(j,Add,1,125);
		DisplayText("\x07『 \x1F광물\x04을 소모하여 \x1BH \x04Marine을 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine 으로 \x19변환\x04하였습니다. - \x1F25000 O r e \x07』",4);
		SetCDeaths(FP,Add,1,MarCreate);
		PreserveTrigger();
	},
}

Trigger { -- 조합 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		BYD;
		Deaths(j,AtLeast,10000,432);
		Bring(j,AtLeast,1,20,58+i);
		Accumulate(j,AtLeast,25000,Ore);
		Bring(j,AtMost,95,MarID[j+1],64);
	},
	actions = {
		ModifyUnitEnergy(1,20,j,58+i,0);
		SetResources(j,Subtract,25000,ore);
		RemoveUnitAt(1,20,58+i,j);
		SetDeaths(j,Add,1,125);
		DisplayText("\x07『 \x1F광물\x04을 소모하여 \x1BH \x04Marine을 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine 으로 \x19변환\x04하였습니다. \x1B(최대 96기까지 보유 가능) \x04- \x1F25000 O r e \x07』",4);
		SetCVAar(VArr(PlayerMarCreateToken,j,FP),Add,1);
		PreserveTrigger();
	},
}

Trigger { -- 조합 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		Deaths(j,AtMost,9999,432);
		Bring(j,AtLeast,1,20,58+i);
		Accumulate(j,AtLeast,25000,Ore);
		NBYD;
	},
	actions = {
		DisplayText("\x07『 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine 으로 \x19변환\x04하기 위해서는 최소 \x081만 이상의 체력\x04이 필요합니다. \x07』",4);
	},
}


Trigger { -- 조합 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,1,EVMode);
		Bring(j,AtLeast,1,20,58+i);
		Accumulate(j,AtLeast,75000,Ore);
	},
	actions = {
		ModifyUnitEnergy(1,20,j,58+i,0);
		SetResources(j,Subtract,75000,ore);
		RemoveUnitAt(1,20,58+i,j);
		CreateUnitWithProperties(1,MarID[j+1],204+j,j,{energy = 100});
		SetDeaths(j,Add,1,125);
		DisplayText("\x07『 \x1F광물\x04을 소모하여 \x1BH \x04Marine을 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine 으로 \x19변환\x04하였습니다. - \x1F75000 O r e \x07』",4);
		SetCDeaths(FP,Add,1,MarCreate);
		PreserveTrigger();
	},
}


Trigger { -- 조합 루먀
	players = {j},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,1,GMode);
		Command(j,AtMost,0,27);
		Bring(j,AtLeast,2,MarID[j+1],58+i);
		Bring(j,AtLeast,5,7,58+i);
		Accumulate(j,AtMost,0x7FFFFFFF,Ore);
	},
	actions = {
		ModifyUnitEnergy(2,MarID[j+1],j,58+i,0);
		ModifyUnitEnergy(5,7,j,58+i,0);
		RemoveUnitAt(2,MarID[j+1],58+i,j);
		RemoveUnitAt(5,7,58+i,j);
		CreateUnitWithProperties(1,27,204+j,j,{energy = 100});
		RotatePlayer({PlayWAVX("staredit\\wav\\Hidden.ogg"),PlayWAVX("staredit\\wav\\Hidden.ogg"),DisplayTextX("\x0D\x0D\x0D"..Player[j+1].."Lumia".._0D,4)},HumanPlayers,j);
		SetCDeaths(FP,Add,1,MarCreate);
		PreserveTrigger();
	},
}

end
end
NJumpEnd(Force1,0x13)


for i=0, 4 do
Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D2B0+(46*i)+7,Exactly,255);
	},
	actions = {
		SetMemoryB(0x58D088+(46*i)+8,SetTo,0);
		SetMemoryB(0x58D088+(46*i)+9,SetTo,0);
	}
}
end

for i=0, 4 do
Trigger {
	players = {i},
	conditions = {
		MemoryB(0x58D2B0+(46*i)+0,AtLeast,1);
	},
	actions = {
		DisplayText("\x12\x07『 \x1F50000\x04 미네랄을 소비하여 \x08HP\x04를 \x085000 \x04만큼 업그레이드하였습니다.\x07 』",4);
		SetMemoryB(0x58D2B0+(46*i)+0,SetTo,0);
		SetMemory(0x58F464+(i*4),Add,5000);
		PreserveTrigger();
	}
}
Trigger {
	players = {i},
	conditions = {
		Label(0);
		NBYD;
		Memory(0x58F464+(i*4),AtLeast,160000);
	},
	actions = {
		DisplayText("\x12\x07『 \x08HP\x04 업그레이드가 완료되어 \x0F버튼\x04을 \x02비활성화 \x04하였습니다. \x07』",4);
		SetMemoryB(0x58D088+(46*i)+0,SetTo,0);
	}
}
Trigger {
	players = {i},
	conditions = {
		Label(0);
		BYD;
		Memory(0x58F464+(i*4),AtLeast,130000);
	},
	actions = {
		DisplayText("\x12\x07『 \x08HP\x04 업그레이드가 완료되어 \x0F버튼\x04을 \x02비활성화 \x04하였습니다. \x07』",4);
		SetMemoryB(0x58D088+(46*i)+0,SetTo,0);
	}
}
end


AtkFactorArr = {30,15,20}
for i = 0, 4 do
for j = 0, 2 do
NIf(FP,CDeaths(FP,Exactly,j,GMode))
NIf(FP,MemoryB(0x58D2B0+(46*i)+8,AtLeast,1))
CallTrigger(FP,OneClickUpgrade,{
		SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
		SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorArr[j+1]),
		SetCVar(FP,UpgradeCP[2],SetTo,i),
		SetCVar(FP,UpgradeMax[2],SetTo,255),
		SetMemoryB(0x58D2B0+(46*i)+8,SetTo,0)})
NIfEnd()
NIf(FP,MemoryB(0x58D2B0+(46*i)+9,AtLeast,1))
CallTrigger(FP,OneClickUpgrade,{
		SetCVar(FP,TempUpgradePtr[2],SetTo,EPD(AtkUpgradePtrArr[i+1])),
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,256^AtkUpgradeMaskRetArr[i+1]),
		SetCVar(FP,UpgradeFactor[2],SetTo,AtkFactorArr[j+1]),
		SetCVar(FP,UpgradeCP[2],SetTo,i),
		SetCVar(FP,UpgradeMax[2],SetTo,10),
		SetMemoryB(0x58D2B0+(46*i)+9,SetTo,0)})
NIfEnd()
NIfEnd()
end
end

for j = 0, 4 do -- 소환


Trigger { -- 소환 마린
	players = {j},
	conditions = {
		Label(0);
		Command(j,AtLeast,1,"Terran Wraith");

	},
	actions = {
		RemoveUnitAt(1,"Terran Wraith","Anywhere",j);
		CreateUnitWithProperties(1,32,204+j,j,{energy = 100});
		DisplayText("\x07『 \x04Marine을 \x19소환\x04하였습니다. - \x1F5000 O r e \x07』",4);
		SetCDeaths(FP,Add,1,MarCreate);
		PreserveTrigger();
	},
}

  Trigger { -- 소환 루미너스 마린
	players = {j},
	conditions = {
		NBYD;
		Deaths(j,AtMost,35,125);
		Bring(j,AtLeast,1,12,64);
	},
	actions = {
		SetResources(j,Add,45000,ore);
		RemoveUnitAt(1,12,"Anywhere",j);
		DisplayText("\x07『 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine \x0436기 조합) 자원 반환 + \x1F45000 O r e \x07』",4);
		PreserveTrigger();
	},
}
  Trigger { -- 소환 루미너스 마린
	players = {j},
	conditions = {
		BYD;
		Deaths(j,AtMost,11,125);
		Bring(j,AtLeast,1,12,64);
	},
	actions = {
		SetResources(j,Add,45000,ore);
		RemoveUnitAt(1,12,"Anywhere",j);
		DisplayText("\x07『 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine \x0412기 조합) 자원 반환 + \x1F45000 O r e \x07』",4);
		PreserveTrigger();
	},
}

Trigger { -- 소환 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,0,EVMode);
		Deaths(CurrentPlayer,AtLeast,36,125);
		Command(j,AtLeast,1,12);
		NBYD;
	},
	actions = {
		RemoveUnitAt(1,12,"Anywhere",j);
		DisplayText("\x07『 \x1F광물\x04을 소모하여 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine 을 \x19소환\x04하였습니다. - \x1F45000 O r e \x07』",4);
		CreateUnitWithProperties(1,MarID[j+1],204+j,j,{energy = 100});
		SetCDeaths(FP,Add,1,MarCreate);
		PreserveTrigger();
	},
}  

Trigger { -- 소환 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		Deaths(CurrentPlayer,AtLeast,12,125);
		Command(j,AtLeast,1,12);
		Bring(j,AtMost,95,MarID[j+1],64);
		BYD;
	},
	actions = {
		RemoveUnitAt(1,12,"Anywhere",j);
		DisplayText("\x07『 \x1F광물\x04을 소모하여 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine 을 \x19소환\x04하였습니다. \x1B(최대 96기까지 보유 가능) \x04- \x1F45000 O r e \x07』",4);
		SetCDeaths(FP,Add,1,MarCreate);
		SetCVAar(VArr(PlayerMarCreateToken,j,fP),Add,1);
		PreserveTrigger();
	},
}  

Trigger { -- 소환 루미너스 마린
	players = {j},
	conditions = {
		Bring(j,AtLeast,1,12,64);
		Bring(j,AtLeast,96,MarID[j+1],64);
		BYD;
	},
	actions = {
		SetResources(j,Add,45000,ore);
		RemoveUnitAt(1,12,"Anywhere",j);
		DisplayText("\x07『 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine \x19최대 보유 가능수\x04가 초과되었습니다. \x1B(최대 96기까지 보유 가능) \x04자원 반환 + \x1F45000 O r e \x07』",4);
		PreserveTrigger();
	},
}

Trigger { -- 소환 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,1,EVMode);
		Deaths(CurrentPlayer,AtLeast,36,125);
		Command(j,AtLeast,1,12);
		Accumulate(j,AtLeast,50000,Ore);
	},
	actions = {
		RemoveUnitAt(1,12,"Anywhere",j);
		SetResources(j,Subtract,50000,ore);
		DisplayText("\x07『 \x1F광물\x04을 소모하여 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine 을 \x19소환\x04하였습니다. - \x1F95000 O r e \x07』",4);
		CreateUnitWithProperties(1,MarID[j+1],204+j,j,{energy = 100});
		SetCDeaths(FP,Add,1,MarCreate);
		PreserveTrigger();
	},
}

Trigger { -- 소환 루미너스 마린
	players = {j},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,1,EVMode);
		Deaths(CurrentPlayer,AtLeast,36,125);
		Command(j,AtLeast,1,12);
		Accumulate(j,AtMost,49999,Ore);
	},
	actions = {
		SetResources(j,Add,45000,ore);
		RemoveUnitAt(1,12,"Anywhere",j);
		DisplayText("\x07『 "..Color[j+1].."L\x04uminous "..Color[j+1].."M\x04arine \x19빠른 소환\x04 조건이 맞지 않습니다. (조건 - 추가 미네랄 \x1F50000 \x04보유) 자원 반환 + \x1F45000 O r e \x07』",4);
		PreserveTrigger();
	},
}


end


--
Trigger { -- 자동환전
	players = {Force1},
	conditions = {
		Command(CurrentPlayer,AtLeast,1,"Terran Vulture");
	},
	actions = {
		RemoveUnitAt(1,"Terran Vulture","Anywhere",CurrentPlayer);
		SetDeaths(CurrentPlayer,SetTo,50,"Terran Barracks");
		DisplayText("\x02\x07『 \x04자동환전을 사용하셨습니다. - \x1F2000 O r e \x07』",4);
		PreserveTrigger();
	},
}
for k=0, 4 do -- 기부시스템
for j=0, 4 do

if k~=j then

CIf(k,Command(k,AtLeast,1,GiveUnitID[j+1]))

for i=0, 4 do
Trigger { -- 돈 기부 시스템
	players = {k},
	conditions = {
		Label(0);
		--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
		Command(k,AtLeast,1,GiveUnitID[j+1]);
		PlayerCheck(j,1);
		CDeaths(k,Exactly,i,GiveRate);
		Accumulate(k,AtMost,GiveRate2[i+1],Ore);
	},
	actions = {
		--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
		DisplayText("\x07『 \x04잔액이 부족합니다. \x07』",4);
		PreserveTrigger();
	},
}
Trigger { -- 돈 기부 시스템

	players = {k},
	conditions = {
		Label(0);
		--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
		Command(k,AtLeast,1,GiveUnitID[j+1]);
		PlayerCheck(j,1);
		CDeaths(k,Exactly,i,GiveRate);
		Accumulate(k,AtLeast,GiveRate2[i+1],Ore);
		Accumulate(k,AtMost,0x7FFFFFFF,Ore);
	},
	actions = {
		SetResources(k,Subtract,GiveRate2[i+1],Ore);
		SetResources(j,Add,GiveRate2[i+1],Ore);
		--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
		
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
		DisplayText("\x07『 "..Player[j+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부하였습니다. \x07』",4);
		SetMemory(0x6509B0,SetTo,j);
		DisplayText("\x12\x07『"..Player[k+1].."\x04에게 \x1F"..GiveRate2[i+1].." Ore\x04를 기부받았습니다.\x02 \x07』",4);
		SetMemory(0x6509B0,SetTo,k);
		PreserveTrigger();
	},
}
end
Trigger { -- 돈 기부 시스템
	players = {k},
	conditions = {
		--MemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],AtLeast,1);
		Command(k,AtLeast,1,GiveUnitID[j+1]);
		PlayerCheck(j,0);
	},
	actions = {
		DisplayText("\x07『 "..Player[j+1].."\x04이(가) 존재하지 않습니다. \x07』",4);
		--SetMemoryB(0x58D2B0+(46*k)+GiveUnitID[j+1],SetTo,0);
		RemoveUnitAt(1,GiveUnitID[j+1],"Anywhere",k);
		PreserveTrigger();
	},
}
CIfEnd()
end 
end end

MarDmg = {1200,4800}

CIf(P6,Switch("Switch 203",Set))
CIf(P6,CDeaths(P6,Atmost,1,GMode))

for x = 1, 5 do
CIf(P6,CVar(P6,SetPlayers[2],Exactly,x))
for j = 0, 4 do
for i = 1, 2 do


UpText1 = "\x0D\x0D\x0D"..Player[j+1]..(100*i).._0D
UpText2 = "\x13\x04Marine \x03ATK \x04+ \x07"..(MarDmg[1]*2)/(2*x).."\x04, H Marine \x03ATK \x04+ \x07"..MarDmg[2]/(2*x)
Trigger { -- 공업 인식
	players = {P6},
	conditions = {
		Label(0);
		MemoryB(0x58D2B0+(46*j)+7,AtLeast,100*i);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(UpText1,0),
			DisplayTextX(UpText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},MapPlayers,FP);
		SetCDeaths(P6,Add,1,MarineHP);
		SetCDeaths(P6,Add,1,PExitCheck[j+1]);
		},
	}
Trigger { -- 공업 인식
	players = {P6},
	conditions = {
		Label(0);
		MemoryB(0x58D2B0+(46*j)+7,AtLeast,100*i);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(UpText1,0),
			DisplayTextX(UpText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},ObPlayers,FP);
	},
}
end
if x~=1 then 
for l=1, 2 do

ExitText1 = "\x0D\x0D\x0D"..Player[j+1].."Exit".._0D
ExitText2 = "\x13\x04Marine \x03ATK \x04+ \x07"..((MarDmg[1]*2)/(2*x))*(3-l)..", \x04H Marine \x03ATK \x04+ \x07"..(MarDmg[2]/(2*x))*(3-l)
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,l-1,PExitCheck[j+1]);
		PlayerCheck(j,0);
		Deaths(j,Exactly,1,"Psi Emitter");
		},
	
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(ExitText1,0),
			DisplayTextX(ExitText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},MapPlayers,FP);
		SetCDeaths(P6,Add,3-l,MarineHP);
	},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,l-1,PExitCheck[j+1]);
		PlayerCheck(j,0);
		Deaths(j,Exactly,1,"Psi Emitter");
		},
	
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(ExitText1,0),
			DisplayTextX(ExitText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},ObPlayers,FP);
	},
}
end
end
end
for i=1, x*2 do -- 공격력 조절 트리거 5인용
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,i,MarineHP);
	},
	actions = {
		SetMemoryX(0x656EB0, Add, (MarDmg[1])/(2*x),0xFFFF);
		SetMemoryX(0x656EB0, Add, (MarDmg[2]*65536)/(2*x),0xFFFF0000);
		},
	}
end
CIfEnd()
end
CIfEnd()

MarDmg = {2400,9600}
CIf(P6,{CDeaths(P6,Exactly,2,GMode),CVar(P6,SetPlayers[2],AtLeast,2)})
for x = 1, 5 do
CIf(P6,CVar(P6,SetPlayers[2],Exactly,x))
for j = 0, 4 do
for i = 1, 2 do


UpText1 = "\x0D\x0D\x0D"..Player[j+1]..(100*i).._0D
UpText2 = "\x13\x04Marine \x03ATK \x04+ \x07"..(MarDmg[1]*2)/(2*x).."\x04, H Marine \x03ATK \x04+ \x07"..MarDmg[2]/(2*x)
Trigger { -- 공업 인식
	players = {P6},
	conditions = {
		Label(0);
		MemoryB(0x58D2B0+(46*j)+7,AtLeast,100*i);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(UpText1,0),
			DisplayTextX(UpText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},MapPlayers,FP);
		SetCDeaths(P6,Add,1,MarineHP);
		SetCDeaths(P6,Add,1,PExitCheck[j+1]);
		},
	}
Trigger { -- 공업 인식
	players = {P6},
	conditions = {
		Label(0);
		MemoryB(0x58D2B0+(46*j)+7,AtLeast,100*i);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(UpText1,0),
			DisplayTextX(UpText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},ObPlayers,FP);
	},
}
end
if x~=1 then 
for l=1, 2 do

ExitText1 = "\x0D\x0D\x0D"..Player[j+1].."Exit".._0D
ExitText2 = "\x13\x04Marine \x03ATK \x04+ \x07"..((MarDmg[1]*2)/(2*x))*(3-l)..", \x04H Marine \x03ATK \x04+ \x07"..(MarDmg[2]/(2*x))*(3-l)
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,l-1,PExitCheck[j+1]);
		PlayerCheck(j,0);
		Deaths(j,Exactly,1,"Psi Emitter");
		},
	
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(ExitText1,0),
			DisplayTextX(ExitText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},MapPlayers,FP);
		SetCDeaths(P6,Add,3-l,MarineHP);
	},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,l-1,PExitCheck[j+1]);
		PlayerCheck(j,0);
		Deaths(j,Exactly,1,"Psi Emitter");
		},
	
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(ExitText1,0),
			DisplayTextX(ExitText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},ObPlayers,FP);
		SetMemory(0x6509B0,SetTo,5);
	},
}
end
end
end
for i=1, x*2 do -- 공격력 조절 트리거 5인용
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,i,MarineHP);
	},
	actions = {
		SetMemoryX(0x656EB0, Add, (MarDmg[1])/(2*x),0xFFFF);
		SetMemoryX(0x656EB0, Add, (MarDmg[2]*65536)/(2*x),0xFFFF0000);
		},
	}
end
CIfEnd()
end
CIfEnd()

MarDmg = {3600,(4800*3)}
CIf(P6,{CDeaths(P6,Exactly,2,GMode),CVar(P6,SetPlayers[2],Exactly,1)})
for x = 1, 1 do
CIf(P6,CVar(P6,SetPlayers[2],Exactly,x))
for j = 0, 4 do
for i = 1, 2 do


UpText1 = "\x0D\x0D\x0D"..Player[j+1]..(100*i).._0D
UpText2 = "\x13\x04Marine \x03ATK \x04+ \x07"..(MarDmg[1]*2)/(2*x).."\x04, H Marine \x03ATK \x04+ \x07"..MarDmg[2]/(2*x)
Trigger { -- 공업 인식
	players = {P6},
	conditions = {
		Label(0);
		MemoryB(0x58D2B0+(46*j)+7,AtLeast,100*i);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(UpText1,0),
			DisplayTextX(UpText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},MapPlayers,FP);
		SetCDeaths(P6,Add,1,MarineHP);
		SetCDeaths(P6,Add,1,PExitCheck[j+1]);
		},
	}
Trigger { -- 공업 인식
	players = {P6},
	conditions = {
		Label(0);
		MemoryB(0x58D2B0+(46*j)+7,AtLeast,100*i);
	},
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(UpText1,0),
			DisplayTextX(UpText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},ObPlayers,FP);
	},
}
end
if x~=1 then 
for l=1, 2 do

ExitText1 = "\x0D\x0D\x0D"..Player[j+1].."Exit".._0D
ExitText2 = "\x13\x04Marine \x03ATK \x04+ \x07"..((MarDmg[1]*2)/(2*x))*(3-l)..", \x04H Marine \x03ATK \x04+ \x07"..(MarDmg[2]/(2*x))*(3-l)
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,l-1,PExitCheck[j+1]);
		PlayerCheck(j,0);
		Deaths(j,Exactly,1,"Psi Emitter");
		},
	
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(ExitText1,0),
			DisplayTextX(ExitText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},MapPlayers,FP);
		SetCDeaths(P6,Add,3-l,MarineHP);
	},
}
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,l-1,PExitCheck[j+1]);
		PlayerCheck(j,0);
		Deaths(j,Exactly,1,"Psi Emitter");
		},
	
	actions = {
		RotatePlayer({
			DisplayTextX(string.rep("\n", 20),4),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX(ExitText1,0),
			DisplayTextX(ExitText2,0),
			DisplayTextX("\x13\x08ＯＶＥＲＤＲＩＶＥ　ＥＦＦＥＣＴ",0),
			DisplayTextX("\x13\x04"..string.rep("―", 56),4),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav"),
			PlayWAVX("sound\\Terran\\Frigate\\AfterOn.wav")
		},ObPlayers,FP);
	},
}
end
end
end
for i=1, x*2 do -- 공격력 조절 트리거 5인용
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtLeast,i,MarineHP);
	},
	actions = {
		SetMemoryX(0x656EB0, Add, (MarDmg[1])/(2*x),0xFFFF);
		SetMemoryX(0x656EB0, Add, (MarDmg[2]*65536)/(2*x),0xFFFF0000);
		},
	}
end
CIfEnd()
end
CIfEnd()
CIfEnd()




CIf(P6,CDeaths(P6,AtLeast,1,BGMType))
Trigger {
	players = {P6},
		conditions = {
		Label(0);
		CDeaths(P6,Exactly,1,BGMType);
		Switch("Switch 100",Set);
			},
	actions = {
		SetCDeaths(P6,Add,1,BGMType);
		PreserveTrigger();
	},
}

CIfX(P6,{Memory(0x58F494,AtMost,0)})

function BGMOb(Index,Value,BGMFile,ModeFlag)
local X = {}
if ModeFlag == 2 then
	table.insert(X, BYD)
elseif ModeFlag == 1 then
	table.insert(X, NBYD)
end
Trigger { -- 브금재생 j번 - 관전자
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,Index,BGMType);
		X;
	},
		actions = {
		RotatePlayer({PlayWAVX(BGMFile),PlayWAVX(BGMFile)},ObPlayers,FP);
		SetMemoryX(0x58F494,SetTo,Value,0xFFFFFF);
		PreserveTrigger();
	},
}
end
BGMOb(1,14 * 1000 ,"staredit\\wav\\intro1.ogg")
BGMOb(3,36 * 1000 ,"staredit\\wav\\bgm2.ogg",1)
BGMOb(2,45 * 1000 ,"staredit\\wav\\BYD_BGM1.ogg",2)
BGMOb(2,39 * 1000 ,"staredit\\wav\\bgm1.ogg",1)
BGMOb(3,53 * 1000 ,"staredit\\wav\\BYD_BGM2.ogg",2)
BGMOb(4,70 * 1000 ,"staredit\\wav\\bgm1_l.ogg",1)
BGMOb(4,86 * 1000 ,"staredit\\wav\\BYD_BGM1_l.ogg",2)
BGMOb(5,185 * 1000 ,"staredit\\wav\\bgm_sp.ogg")
BGMOb(6,45 * 1000 ,"staredit\\wav\\bgm3.ogg")
BGMOb(7,74 * 1000 ,"staredit\\wav\\MBoss.ogg",1)
BGMOb(7,144 * 1000 ,"staredit\\wav\\MBoss2.ogg",2)
BGMOb(8,60 * 1000 ,"staredit\\wav\\E_Boss.ogg")

CElseX()
Trigger { -- 브금재생시 스킵 관전자
	players = {P6},
	conditions = {
	},
		actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg"),PlayWAVX("staredit\\wav\\BGM_Skip.ogg")},ObPlayers,FP);
		PreserveTrigger();
	},
}

CIfXEnd()

CMov(P6,0x6509B0,0)
CWhile(P6,Memory(0x6509B0,AtMost,5))
CIf(P6,Bring(CurrentPlayer,AtLeast,1,111,64))
CIfX(P6,{Deaths(CurrentPlayer,AtMost,0,440)})

function BGMPlayer(Index,Value,BGMFile,ModeFlag)
local X = {}

if ModeFlag == 2 then
	table.insert(X, BYD)
elseif ModeFlag == 1 then
	table.insert(X, NBYD)
end

Trigger { -- 브금재생 j번
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,Index,BGMType);
		X;
	},
		actions = {
		PlayWAV(BGMFile);
		PlayWAV(BGMFile);
		SetDeaths(CurrentPlayer,SetTo,Value,440,0xFFFFFF);
		PreserveTrigger();
	},
}
end

BGMPlayer(1,14 * 1000 ,"staredit\\wav\\intro1.ogg")
BGMPlayer(2,39 * 1000 ,"staredit\\wav\\bgm1.ogg",1)
BGMPlayer(2,45 * 1000 ,"staredit\\wav\\BYD_BGM1.ogg",2)
BGMPlayer(3,36 * 1000 ,"staredit\\wav\\bgm2.ogg",1)
BGMPlayer(3,53 * 1000 ,"staredit\\wav\\BYD_BGM2.ogg",2)
BGMPlayer(4,70 * 1000 ,"staredit\\wav\\bgm1_l.ogg",1)
BGMPlayer(4,86 * 1000 ,"staredit\\wav\\BYD_BGM1_l.ogg",2)
BGMPlayer(5,185 * 1000 ,"staredit\\wav\\bgm_sp.ogg")
BGMPlayer(6,45 * 1000 ,"staredit\\wav\\bgm3.ogg")
BGMPlayer(7,74 * 1000 ,"staredit\\wav\\MBoss.ogg",1)
BGMPlayer(7,144 * 1000 ,"staredit\\wav\\MBoss2.ogg",2)
BGMPlayer(8,60 * 1000 ,"staredit\\wav\\E_Boss.ogg")


CElseX()
Trigger { -- 브금재생시 스킵
	players = {P6},
		actions = {
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PlayWAV("staredit\\wav\\BGM_Skip.ogg");
		PreserveTrigger();
	},
}
CIfXEnd()
CIfEnd()
CAdd(P6,0x6509B0,1)
CWhileEnd()
DoActionsX(P6,{SetCDeaths(P6,SetTo,0,BGMType),SetMemory(0x6509B0,SetTo,P6)})
CIfEnd()


CIfOnce({Force1},{DeathsX(CurrentPlayer,AtMost,0,440,0xFFFFFF),CDeaths(P6,Exactly,1,IntroBGM)})
Trigger { -- 브금재생 인트로 하드이하
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,2,Difficulty);
	},
		actions = {
		PlayWAV("staredit\\wav\\intro2.ogg");
		SetDeathsX(CurrentPlayer,SetTo,52*1000,440,0xFFFFFF);
	},
}
Trigger { -- 브금재생 인트로 FTR
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,3,Difficulty);
		CDeaths(P6,AtMost,1,GMode);
		
	},
		actions = {
		PlayWAV("staredit\\wav\\FTR_OP.ogg");
		SetDeathsX(CurrentPlayer,SetTo,64*1000,440,0xFFFFFF);
	},
}
Trigger { -- 브금재생 인트로 BYD
	players = {Force1},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,3,Difficulty);
		CDeaths(P6,AtLeast,2,GMode);
		
	},
		actions = {
		PlayWAV("staredit\\wav\\BYD_OP.ogg");
		SetDeathsX(CurrentPlayer,SetTo,59*1000,440,0xFFFFFF);
	},
}
CIfEnd()
CIfOnce(P6,{Memory(0x58F494,AtMost,0),CDeaths(P6,Exactly,1,IntroBGM)})
Trigger { -- 브금재생 인트로 - 관전자
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,AtMost,2,Difficulty);
	},
		actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\intro2.ogg"),PlayWAVX("staredit\\wav\\intro2.ogg")},ObPlayers,FP);
		SetMemory(0x58F494,SetTo,52*1000);
	},
}
Trigger { -- 브금재생 인트로 - 관전자
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,3,Difficulty);
		CDeaths(P6,AtMost,1,GMode);
	},
		actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\FTR_OP.ogg"),PlayWAVX("staredit\\wav\\FTR_OP.ogg")},ObPlayers,FP);
		SetMemory(0x58F494,SetTo,64*1000);
	},
}
Trigger { -- 브금재생 인트로 - 관전자
	players = {P6},
	conditions = {
		Label(0);
		CDeaths(P6,Exactly,3,Difficulty);
		CDeaths(P6,AtLeast,2,GMode);
	},
		actions = {
		RotatePlayer({PlayWAVX("staredit\\wav\\BYD_OP.ogg"),PlayWAVX("staredit\\wav\\BYD_OP.ogg")},ObPlayers,FP);
		SetMemory(0x58F494,SetTo,59*1000);
	},
}
CIfEnd()
--]]
DoActionsP({KillUnit(84,Force2),KillUnit(47,P6)},P6)
DoActionsPX({
SetCDeaths(P6,Subtract,1,HealT),
SetCDeaths(P6,Subtract,1,LeaderBoardT),
SetCDeaths(P6,Subtract,1,CanCT),
SetCDeaths(P6,Subtract,1,CanWT),
SetCDeaths(P6,Subtract,1,ArbT),
SetCDeaths(P6,Subtract,1,GeneT),
SetCDeaths(P6,Subtract,1,TimerPenalty)
},P6)
--]]
CIfEnd()

CIf(FP,CDeaths(FP,AtLeast,1,ScorePrint),SetCDeaths(FP,SetTo,0,ScorePrint))
TxtSkip = Str10[2] + GetStrSize(0,"\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d") + (4*6)
for i = 1, 5 do
CIf(FP,Deaths(i-1,AtLeast,1, "Psi Emitter"))
CMov(FP,ExScoreP[i],ExScore[i])
CiDiv(FP,ExScoreP[i],_Mul(ExScoreP[i],_Div(ScoreBonusV,_Mov(10))),_Mov(10))
CiDiv(FP,ExScoreP[i],_Mul(ExScoreP[i],_Div(ClearRate,_Mov(10))),_Mov(100))
ItoDecX(FP,ExScoreP[i],VArr(ExScoreVA[i],0),2,nil,2)
_0DPatchforVArr(FP,ExScoreVA[i],6)
f_Movcpy(FP,_Add(PScoreSTrPtr[i],TxtSkip),VArr(ExScoreVA[i],0),12*4)
f_Memcpy(FP,_Add(PScoreSTrPtr[i],TxtSkip+(12*4)),_TMem(Arr(Str19[3],0),"X","X",1),Str19[2])
CIfEnd()

end
Trigger {
	players = {P6},
	conditions = {
		},
	
	actions = {
		RotatePlayer({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x10【 \x06Ｔ\x04ｏｔａｌ　\x1FＳｃｏｒｅ \x10】",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
		PreserveTrigger();
	},
}
for i = 1, 5 do
Trigger {
	players = {P6},
	conditions = {
		Deaths(i-1,AtLeast,1, "Psi Emitter");
		},
	
	actions = {
		RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..Player[i].."Score".._0D,4)},HumanPlayers,FP);
		PreserveTrigger();
	},
}
end
CIfEnd()



CIfOnce(P6,Always()) -- onPluginStart
f_GetStrXptr(P6,UnivStrPtr,UnivToString)
f_GetStrXptr(P6,HTextStrPtr,HTextStr)
for j=1, 5 do
LumiaCT[j] = f_GetStrXptr(P6,LumiaCTStrPtr[j],"\x0D\x0D\x0D"..Player[j].."Lumia".._0D)
ShieldT[j] = f_GetStrXptr(P6,ShTStrPtr[j],"\x0D\x0D\x0D"..Player[j].."Shield".._0D)
ATKExitText[j] = f_GetStrXptr(P6,ATKExtStrPtr[j],"\x0D\x0D\x0D"..Player[j].."Exit".._0D)
ATKUpText1[j] = f_GetStrXptr(P6,ATKUp1StrPtr[j],"\x0D\x0D\x0D"..Player[j].."100".._0D)
ATKUpText2[j] = f_GetStrXptr(P6,ATKUp2StrPtr[j],"\x0D\x0D\x0D"..Player[j].."200".._0D)
PlayerScore[j] = f_GetStrXptr(P6,PScoreSTrPtr[j],"\x0D\x0D\x0D"..Player[j].."Score".._0D)
--TMem(FP,PlayerMarineListHeader[j],PlayerMarineListArr[j])
end
f_GetStrXptr(FP,UPCompStrPtr,"\x0D\x0D\x0DUPC".._0D)

CMov(P6,MaxHP,160000)
CMov(P6,MaxHPP,3200)

for i = 0, 4 do
Trigger {
	players = {P6},
	conditions = {
		Label(0);
		Command(i,AtLeast,1,111);
		},
	actions = {
		SetCVar(P6,SetPlayers[2],Add,1);
		}
}
end

Trigger {
	players = {P6},
	conditions = {
		Label(0);
		},
	actions = {
		SetCVar(P6,RednumberSet[2],SetTo,500);
		SetCJump(0x510,0);
		}
}
for i = 0, 4 do
ItoName(P6,i,VArr(Names[i+1],0),ColorCode[i+1])

_0DPatchforVArr(FP,Names[i+1],6)
end
Print_All_CTextString(FP)
for i = 1, 5 do
Install_CText1(LumiaCTStrPtr[i],Str10,Str11,Names[i])

Install_CText1(ShTStrPtr[i],Str12,Str13,Names[i])

Install_CText1(ATKExtStrPtr[i],Str14,Str15,Names[i])

Install_CText1(ATKUp1StrPtr[i],Str14,Str16,Names[i])

Install_CText1(ATKUp2StrPtr[i],Str14,Str17,Names[i])

Install_CText1(PScoreSTrPtr[i],Str10,Str18,Names[i])

end
f_MemCpy(FP,UPCompStrPtr,_TMem(Arr(Str12[3],0),"X","X",1),Str12[2]-3)
--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3),_TMem(Arr(UpCompTxt,0),"X","X",1),5*4)
f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20),_TMem(Arr(Str22[3],0),"X","X",1),Str22[2]-3)
--f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3),_TMem(Arr(UpCompRet,0),"X","X",1),5*4)
f_MemCpy(FP,_Add(UPCompStrPtr,Str12[2]-3+20+Str22[2]-3+20),_TMem(Arr(Str23[3],0),"X","X",1),Str23[2]-3)
DoActionsX(FP,{
SetCtrigX("X",MarListHeader[1][2],0x15C,0,SetTo,"X",0x200+((1-1)*0x100),0x15C,1,0),
SetCtrigX("X",MarListHeader[2][2],0x15C,0,SetTo,"X",0x200+((2-1)*0x100),0x15C,1,0),
SetCtrigX("X",MarListHeader[3][2],0x15C,0,SetTo,"X",0x200+((3-1)*0x100),0x15C,1,0),
SetCtrigX("X",MarListHeader[4][2],0x15C,0,SetTo,"X",0x200+((4-1)*0x100),0x15C,1,0),
SetCtrigX("X",MarListHeader[5][2],0x15C,0,SetTo,"X",0x200+((5-1)*0x100),0x15C,1,0)}) -- OnPluginStart
				DoActionsX(FP,{
					SetCVar(FP,BYDGunPlotSize[1][2],SetTo,ZergGunShape[1][1]),
					SetCVar(FP,BYDGunPlotSize[2][2],SetTo,ZergGunShape[2][1]),
					SetCVar(FP,BYDGunPlotSize[3][2],SetTo,ZergGunShape[3][1]),
					SetCVar(FP,BYDGunPlotSize[4][2],SetTo,ZergGunShape[4][1])
				})
CJump(AllPlayers,0x610)
InstallCVariable()
CJumpEnd(AllPlayers,0x610)
CIfEnd()
EndCtrig()
ErrorCheck()
