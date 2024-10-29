function GunTrig()

	BGMType = CreateVar(FP)
	Dt = IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\happy.ogg",19*1000},
		{2,"staredit\\wav\\yodelsong.ogg",157*1000},
		{3,"staredit\\wav\\_Hong.ogg",16*1000},
		{4,"staredit\\wav\\Lethal_Icecream.ogg",24*1000},
		{5,"staredit\\wav\\Bombyanggang.ogg",16*1000},
		{6,"staredit\\wav\\__CIPI1.ogg",38*1000},
		{7,"staredit\\wav\\MaraTangFuru.ogg",18*1000},
		{8,"staredit\\wav\\UnwelcomeSchool.ogg",53*1000},
		{9,"staredit\\wav\\Damedane.ogg",35*1000},
		{10,"staredit\\wav\\00.ogg",47*1000},
		{11,"staredit\\wav\\_DDING1.ogg",82*1000},
		{12,"staredit\\wav\\lolikami_cut.ogg",68*1000},
		{13,"staredit\\wav\\Toka.ogg",16*1000},
		{14,"staredit\\wav\\Nyancat.ogg",31*1000},
		{15,"staredit\\wav\\nodap.ogg",55*1000},
		{16,"staredit\\wav\\bling.ogg",55*1000},
		
		
		
	})
	

	CDoActions(FP, {TSetDeathsX(Force1, Subtract, Dt, 12,0xFFFFFF)})
	if TestStart == 0 then
		DoActionsX(FP,{SetV(BGMType,2)},1)
	end
	function CIf_GunTrig(PlayerID,GunID,LocID,TimerMax,BGMTypes)
		local BGMAct
		if BGMTypes~=nil then
			BGMAct = SetV(BGMType,BGMTypes)
		else
			BGMAct = nil
		end
		local GunCcode = CreateCcode()
		GunTrigGLoc = LocID
		GunTrigGCcode = GunCcode
		TriggerX(FP, Bring(PlayerID, Exactly, 0, GunID, LocID), {SetCD(GunCcode,1),BGMAct})--RotatePlayer({DisplayTextX("\x13GunID : "..GunID.."    LocID : "..LocID)}, HumanPlayers, FP)
		CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,TimerMax,AtMost)},{AddCD(GunCcode,1)})
		return GunCcode
	end
--P7Guns
HacCD1 = CIf_GunTrig(P7, "Zerg Hatchery", "CD1",500,1);
	CD1Sh = CSMakeStar(4, 180, 64, 45, PlotSizeCalc(4*2, 2), 0)
	G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD1Sh,P8,GunTrigGLoc,1,{FNTable=2})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD1Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD1Sh,P8,GunTrigGLoc,1,{FNTable=2})
CIfEnd()
HacCD3 = CIf_GunTrig(P7, "Zerg Hatchery", "CD3",500,1);
	CD3Sh = CSMakeLine(2, 32, 90, 5, 0)
	for i = 0,4 do
		G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD3Sh,P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD3Sh,P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX",RepeatType="KiilUnit"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD3Sh,P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX"})
	end
CIfEnd()
HacCD4 = CIf_GunTrig(P7, "Zerg Hatchery", "CD4",500,1);
	CD4Sh_1 = CSMakeCircle(12, 72, 0, 13, 1)
	CD4Sh_2 = CSMakeLine(4, 48, 0, 13, 0)
	G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_1,P8,GunTrigGLoc,1)
	G_CB_TSetSpawn({CD(GunTrigGCcode,70,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_2,P8,GunTrigGLoc,1)
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD4Sh_1,P8,GunTrigGLoc,1,{LMTable = "MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD4Sh_2,P8,GunTrigGLoc,1,{LMTable = "MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_1,P8,GunTrigGLoc,1)
	G_CB_TSetSpawn({CD(GunTrigGCcode,270,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_2,P8,GunTrigGLoc,1)
CIfEnd()
HacCD37 = CIf_GunTrig(P7, "Zerg Hatchery", "CD37",500,1);
	CD37Sh = CSMakeLine(2, 32, 0, 5, 0)
	for i = 0,4 do
		G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD37Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD37Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX",RepeatType="KiilUnit"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD37Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX"})
	end
CIfEnd()
HacCD38 = CIf_GunTrig(P7, "Zerg Hatchery", "CD38",500,1);
CD38Sh = CSMakeCircle(5, 96, 0, 6, 1)
RandRotV = f_CRandNum(360)
CMov(FP,G_CB_RotateV,RandRotV)
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD38Sh,P8,GunTrigGLoc,1,{DistanceXY={(32*2)-(32*i),(-32*2)+(32*i)},LMTable="MAX",RotateTable = "Main"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD38Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),(-32*2)+(32*i)},LMTable="MAX",RotateTable = "Main",RepeatType="KiilUnit"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD38Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),(-32*2)+(32*i)},LMTable="MAX",RotateTable = "Main"})

end
CIfEnd()
HacCD39 = CIf_GunTrig(P7, "Zerg Hatchery", "CD39",500,1);
CD39Sh = {28  ,{672, 1632},{704, 1632},{736, 1632},{768, 1632},{800, 1632},{832, 1632},{864, 1632},{896, 1632},{928, 1632},{960, 1632},{960, 1664},{960, 1696},{960, 1728},{960, 1760},{960, 1792},{960, 1824},{960, 1856},{960, 1888},{960, 1920},{960, 1952},{960, 1984},{928, 1792},{896, 1792},{864, 1792},{832, 1792},{800, 1792},{768, 1792},{736, 1792}}

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD39Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD39Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD39Sh,P8,{0,0},1,{LMTable="MAX"})
CIfEnd()
HacCD40 = CIf_GunTrig(P7, "Zerg Hatchery", "CD40",500,1);
CD40Sh = {23  ,{1408, 1728},{1440, 1728},{1472, 1728},{1504, 1728},{1536, 1728},{1568, 1600},{1568, 1632},{1568, 1664},{1568, 1696},{1568, 1728},{1568, 1760},{1568, 1792},{1568, 1824},{1568, 1856},{1376, 1600},{1376, 1632},{1376, 1664},{1376, 1696},{1376, 1728},{1376, 1760},{1376, 1792},{1376, 1824},{1376, 1856}}

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD40Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD40Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD40Sh,P8,{0,0},1,{LMTable="MAX"})
CIfEnd()
HacCD41 = CIf_GunTrig(P7, "Zerg Hatchery", "CD41",500,1);
Shape9081 = {4   ,{768, 2208},{1152, 2016},{1248, 2112},{864, 2304}}
CD41Sh = CS_FillPathXY(Shape9081, 1, 64, 32, 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD41Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD41Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD41Sh,P8,{0,0},1,{LMTable="MAX"})

CIfEnd()
HacCD42 = CIf_GunTrig(P7, "Zerg Hatchery", "CD42",500,1);
CD42Sh = CSMakePolygon(6, 48, 0, PlotSizeCalc(6, 3), 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD42Sh,P8,GunTrigGLoc,1,{FNTable=2})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD42Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD42Sh,P8,GunTrigGLoc,1,{FNTable=2})

CIfEnd()


HacCD2 = CIf_GunTrig(P8, "Zerg Hatchery", "CD2",500,1);
CD2Sh = CSMakePolygon(6, 48, 0, PlotSizeCalc(6, 2), 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD2Sh,P8,GunTrigGLoc,1,{FNTable=2})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD2Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD2Sh,P8,GunTrigGLoc,1,{FNTable=2})
CIfEnd()
HacCD5 = CIf_GunTrig(P8, "Zerg Hatchery", "CD5",500,1);
Shape9081_1 = {4   ,{1472, 3552},{1568, 3648},{1408, 3744},{1312, 3648}}
Shape9081_2 = {4   ,{1760, 3744},{1856, 3808},{1632, 3936},{1472, 3872}}
Shape9081_1 = CS_FillPathXY(Shape9081_1, 1, 64, 32, 0)
Shape9081_2 = CS_FillPathXY(Shape9081_2, 1, 64, 32, 0)
CD5Sh = CS_OverlapX(Shape9081_1,Shape9081_2)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD5Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD5Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD5Sh,P8,{0,0},1,{LMTable="MAX"})



CIfEnd()
HacCD6 = CIf_GunTrig(P8, "Zerg Hatchery", "CD6",500,1);
CD6Sh = CSMakeLine(1, 64, 0, 5, 1)
for i = 0, 7 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*10),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD6Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RotateTable = (i*360)/8})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD6Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RotateTable = (i*360)/8,RepeatType="KiilUnit"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*10),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD6Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RotateTable = (i*360)/8})
end
CIfEnd()
HacCD49 = CIf_GunTrig(P7, "Zerg Hatchery", "CD49",500,1);
CD49Sh = CSMakeStar(4, 180, 48, 45, PlotSizeCalc(4*2, 3), PlotSizeCalc(4*2, 2))

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD49Sh,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD49Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD49Sh,P8,GunTrigGLoc,1)


CIfEnd()
HacCD50 = CIf_GunTrig(P7, "Zerg Hatchery", "CD50",500,1); -- 1. 알랜 가디언 영웅 2. 구이몬 톰
CD50Sh = {16  ,{1408, 672},{1392, 704},{1376, 736},{1360, 768},{1344, 800},{1328, 832},{1312, 864},{1424, 704},{1440, 736},{1456, 768},{1472, 800},{1488, 832},{1504, 864},{1376, 800},{1408, 800},{1440, 800}}
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Alan Schezar (Goliath)","Kukulza (Guardian)"},CD50Sh,P8,{0,0},1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD50Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Gui Montag (Firebat)","Tom Kazansky (Wraith)"},CD50Sh,P8,{0,0},1)


CIfEnd()
HacCD51 = CIf_GunTrig(P7, "Zerg Hatchery", "CD51",500,1); --1. 워브 톰 2. 시즈탱크
CD51Sh = CS_FillPathXY({3   ,{1920, 704},{2304, 704},{1920, 1088}}, 1, 48, 48, 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Warbringer (Reaver)","Tom Kazansky (Wraith)"},CD51Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD51Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Edmund Duke (Siege Mode)"},CD51Sh,P8,{0,0},1,{LMTable="MAX"})


CIfEnd()
HacCD52 = CIf_GunTrig(P7, "Zerg Hatchery", "CD52",500,1);
CD52Sh = CS_OverlapX(CS_MoveXY(CSMakeLine(2, 32, 45, 16, 0), 0, -182+23),CS_MoveXY(CSMakeLine(2, 32, 45+90, 16, 0), 0, 182-23))

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD52Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD52Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD52Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})

CIfEnd()	
HacCD53 = CIf_GunTrig(P7, "Zerg Hatchery", "CD53",500,1); -- 1. 짐레벌쳐 사라 2. 시즈탱크
CD53Sh_1 = CSMakeCircle(20, 3*32, 0, 21, 1)
CD53Sh_2 = CSMakeCircle(30, 5*32, 0, 31, 1)
CD53Sh_3 = CS_FillPathXY({4   ,{1792, 1280},{2048, 1152},{1952, 1088},{1728, 1184}}, 1, 32, 32, 0)

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Jim Raynor (Vulture)"},CD53Sh_1,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Sarah Kerrigan (Ghost)"},CD53Sh_2,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD53Sh_3,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Edmund Duke (Siege Mode)"},CD53Sh_3,P8,{0,0},1)

CIfEnd()	
LairCD8 = CIf_GunTrig(P7, "Zerg Lair", "CD8",500,3);
Shape9081 = {6   ,{1440, 2848},{1664, 2720},{1664, 2624},{1536, 2560},{1344, 2656},{1376, 2752}}
CD8Sh = CS_FillPathXY(Shape9081, 1, 40, 40, 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD8Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD8Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD8Sh,P8,{0,0},1,{LMTable="MAX"})

CIfEnd()
LairCD12 = CIf_GunTrig(P7, "Zerg Lair", "CD12",500,3);
CD12Sh = CSMakeStar(6,135,64,0,CS_Level("Star",6,4),CS_Level("Star",6,3)) 
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD12Sh,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD12Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD12Sh,P8,GunTrigGLoc,1) 
CIfEnd()
LairCD13 = CIf_GunTrig(P7, "Zerg Lair", "CD13",500,3);
CD13Sh= CS_OverlapX(CS_MoveXY(CSMakePolygon(3, 16, 0, PlotSizeCalc(3, 5), PlotSizeCalc(3, 4)),0,  80),CS_MoveXY(CSMakePolygon(3, 16, 180, PlotSizeCalc(3, 5), PlotSizeCalc(3, 4)), 0, -80))
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD13Sh,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD13Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD13Sh,P8,GunTrigGLoc,1) 

CIfEnd()
LairCD14 = CIf_GunTrig(P7, "Zerg Lair", "CD14",500,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CD14Sh_1 = CSMakeLine(3, 48, 0, 16, 0)
CD14Sh_2 = CSMakeLine(3, 48, 180, 16, 0)
CD14Sh_3 = CS_OverlapX(CD14Sh_1,CD14Sh_2)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD14Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD14Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD14Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
G_CB_TSetSpawn({CD(GunTrigGCcode,340,AtLeast)},{"Zerg Devourer"},CD14Sh_3,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,400,AtLeast)},{"Edmund Duke (Siege Mode)","Tom Kazansky (Wraith)"},CD14Sh_3,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
CIfEnd()
LairCD15 = CIf_GunTrig(P7, "Zerg Lair", "CD15",500,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CD15Sh = CSMakeLine(8, 48, 0, (8*5)+1, 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD15Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD15Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD15Sh,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
G_CB_TSetSpawn({CD(GunTrigGCcode,340,AtLeast)},{"Zerg Devourer"},CD15Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,400,AtLeast)},{"Edmund Duke (Siege Mode)","Tom Kazansky (Wraith)"},CD15Sh,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
CIfEnd()
LairCD18 = CIf_GunTrig(P7, "Zerg Lair", "CD18",500,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰

CD18Sh = CS_OverlapX(
	CS_MoveXY(CSMakeCircle(6, 45, 0, 7, 1), -220/2, -50),
	CS_MoveXY(CSMakeCircle(6, 45, 0, 7, 1), 0, -50),
	CS_MoveXY(CSMakeCircle(6, 45, 0, 7, 1), 220/2, -50),
	CS_MoveXY(CSMakeCircle(6, 45, 0, 7, 1), -110/2, 50),
	CS_MoveXY(CSMakeCircle(6, 45, 0, 7, 1), 110/2, 50))
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD18Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD18Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD18Sh,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
G_CB_TSetSpawn({CD(GunTrigGCcode,340,AtLeast)},{"Zerg Devourer"},CD18Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,400,AtLeast)},{"Edmund Duke (Siege Mode)","Tom Kazansky (Wraith)"},CD18Sh,P8,GunTrigGLoc,1,{LMTable="MAX"}) 

CIfEnd()
LairCD19 = CIf_GunTrig(P7, "Zerg Lair", "CD19",500,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CD19Sh = CSMakePolygon(8, 32, 0, PlotSizeCalc(8, 4), PlotSizeCalc(8, 3))
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD19Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD19Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD19Sh,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
G_CB_TSetSpawn({CD(GunTrigGCcode,340,AtLeast)},{"Zerg Devourer"},CD19Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,400,AtLeast)},{"Edmund Duke (Siege Mode)","Tom Kazansky (Wraith)"},CD19Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
CIfEnd()
LairCD7 = CIf_GunTrig(P8, "Zerg Lair", "CD7",500,3);
CD7Sh_1 = CSMakeLine(4, 64, 45, 17, 1)
CD7Sh_2 = CS_ConnectPath(CSMakePath({-182,-182},{182,-182},{182,182},{-182,182}),4,1)
CD7Sh = CS_OverlapX(CD7Sh_1,CD7Sh_2)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD7Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD7Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD7Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
CIfEnd()
LairCD9 = CIf_GunTrig(P8, "Zerg Lair", "CD9",500,3);
CD9Sh = CS_FillPathHX2({4	,{-32*4, -32*4},{32*4, -32*4},{32*4, 32*4},{-32*4, 32*4}},1,48,32,1,0,26.57,5)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD9Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD9Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD9Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
CIfEnd()
LairCD10 = CIf_GunTrig(P8, "Zerg Lair", "CD10",500,3);
CD10ShArr = {CSMakeCircle(9, 64, 0, 10, 1),CSMakeCircle(9+1, 64*2, 0, 10+1, 1),CSMakeCircle(9+2, 64*3, 0, 10+2, 1)}
CD10Sh_1 = CS_OverlapX(CSMakeCircle(9, 64, 0, 10, 1),CSMakeCircle(9+1, 64*2, 0, 10+1, 1),CSMakeCircle(9+2, 64*3, 0, 10+2, 1))
for i = 1,3 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD10ShArr[i],P8,GunTrigGLoc,1,{LMTable="MAX"})
end
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD10Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
for i = 1,3 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD10ShArr[i],P8,GunTrigGLoc,1,{LMTable="MAX"})
end
CIfEnd()
LairCD11 = CIf_GunTrig(P8, "Zerg Lair", "CD11",500,3);
CD11ShArr= {CSMakePolygon(6, 64, 0, PlotSizeCalc(6,1), 1),CSMakePolygon(7, 96, 0, PlotSizeCalc(7,1), 1),CSMakePolygon(8, 128, 0, PlotSizeCalc(8,1), 1)}
CD11Sh_1 = CS_OverlapX(CSMakePolygon(6, 64, 0, PlotSizeCalc(6,1), 1),CSMakePolygon(7, 96, 0, PlotSizeCalc(7,1), 1),CSMakePolygon(8, 128, 0, PlotSizeCalc(8,1), 1))
for i = 1,3 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD11ShArr[i],P8,GunTrigGLoc,1,{LMTable="MAX"})
end
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD11Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
for i = 1,3 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD11ShArr[i],P8,GunTrigGLoc,1,{LMTable="MAX"})
end

CIfEnd()
LairCD16 = CIf_GunTrig(P8, "Zerg Lair", "CD16",500,3);
CD16Sh_1 = CS_Rotate(CS_SortY(CSMakeStar(4, 180, 64, 0, PlotSizeCalc(8, 3), 0), 0), 45)
CD16Sh_2 = CS_Rotate(CS_SortY(CSMakeStar(4, 180, 64, 0, PlotSizeCalc(8, 3), 0), 0), -45)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD16Sh_1,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD16Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD16Sh_2,P8,GunTrigGLoc,1)
CIfEnd()
LairCD17 = CIf_GunTrig(P8, "Zerg Lair", "CD17",500,3);
CD17Sh = CSMakeCircle(6, 32, 0, PlotSizeCalc(6, 3), 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD17Sh,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD17Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD17Sh,P8,GunTrigGLoc,1)
CIfEnd()
LairCD54 = CIf_GunTrig(P7, "Zerg Lair", "CD54",500,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CD54Sh_1 = CSMakeLine(4, 64, 0, 21, 1)
CD54Sh_2 = CSMakeCircle(20, 128, 0, 21, 1)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,140,AtLeast)}, {CD54Sh_1}, GunTrigGLoc, 429, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,170,AtLeast)}, {CD54Sh_2}, GunTrigGLoc, 978, 1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"}) 
G_CB_TScanEff({CD(GunTrigGCcode,340,AtLeast)}, {CD54Sh_1}, GunTrigGLoc, 429, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,370,AtLeast)}, {CD54Sh_2}, GunTrigGLoc, 978, 1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,400,AtLeast)},{"Edmund Duke (Siege Mode)","Tom Kazansky (Wraith)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,400,AtLeast)},{"Edmund Duke (Siege Mode)","Tom Kazansky (Wraith)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})
CIfEnd()
LairCD55 = CIf_GunTrig(P7, "Zerg Lair", "CD55",400,4); -- 마인. 리썰 배달 브금으로 변경.
CD55Sh = CSMakeCircle(8,64,0,PlotSizeCalc(8, 3),0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Zerg Devourer"},CD55Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,40,AtLeast)},{"Vulture Spider Mine"},CD55Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
CIfEnd()


HiveCD27 = CIf_GunTrig(P7, "Zerg Hive", "CD27",20000 // 0x1D,7);

	
function HyperCycloidC(T) return {12*math.sin(T) - 4*math.sin(3*T), 13*math.cos(T) - 5*math.cos(2*T) - 2*math.cos(3*T) - math.cos(4*T)} end
HCCC = CSMakeGraphT({12,12},"HyperCycloidC",0,0,4.1,4.1,25) 
HCC0 = CS_Rotate(HCCC,180)
HCC = CS_RemoveStack(HCC0,15,0) -------하트
HSh_1 = CS_OverlapX(CD54Sh_1,CD54Sh_2)
HSh_2 = CSMakeLine(4, 128, 45, 5, 1)
HSh_T1 = {
	CSMakeCircle(5, 64, 0, 6, 1),
	CSMakeCircle(6, 64+(32*1), 0, 7, 1),
	CSMakeCircle(7, 64+(32*2), 0, 8, 1),
	CSMakeCircle(8, 64+(32*3), 0, 9, 1),
	CSMakeCircle(9, 64+(32*4), 0, 10, 1)
}

HSh_T2 = {
	CSMakePolygon(6, 16, 90, PlotSizeCalc(6, 4), PlotSizeCalc(6, 3)),
	CSMakePolygon(6, 24, 90, PlotSizeCalc(6, 4), PlotSizeCalc(6, 3)),
	CSMakePolygon(6, 32, 90, PlotSizeCalc(6, 4), PlotSizeCalc(6, 3)),
	CSMakePolygon(6, 40, 90, PlotSizeCalc(6, 4), PlotSizeCalc(6, 3))
}

--CS_PrintBMPGraph(CSMakePolygon(6, 40, 90, PlotSizeCalc(6, 4), PlotSizeCalc(6, 3)),nil,{{-10},{10}},{{-5},{5}},1,100,25,{0x00FFC0,0x80FFE0,0xC4FFF0},3)


	
G_CB_TScanEff({CD(GunTrigGCcode,0,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,980//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,1960 // 0x1D,AtLeast)},{"Zeratul (Dark Templar)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,2450 // 0x1D,AtLeast)},{"Mojo (Scout)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,2950 // 0x1D,AtLeast)},{"Gui Montag (Firebat)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,3320 // 0x1D,AtLeast)},{"Danimoth (Arbiter)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TScanEff({CD(GunTrigGCcode,3680//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,3930//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,4420//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 426, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,4910 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5040 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5160 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5280 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[4],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5410 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[5],P8,GunTrigGLoc,1,{LMTable="MAX"})



G_CB_TSetSpawn({CD(GunTrigGCcode,5950 // 0x1D,AtLeast)},{"Alan Schezar (Goliath)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,6390 // 0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,6880 // 0x1D,AtLeast)},{"Fenix (Zealot)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,7250 // 0x1D,AtLeast)},{"Kukulza (Mutalisk)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})


G_CB_TSetSpawn({CD(GunTrigGCcode,7860 // 0x1D,AtLeast)},{"Mojo (Scout)"},HSh_T2[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8110 // 0x1D,AtLeast)},{"Tassadar/Zeratul (Archon)"},HSh_T2[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8360 // 0x1D,AtLeast)},{"Mojo (Scout)"},HSh_T2[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8600 // 0x1D,AtLeast)},{"Tassadar/Zeratul (Archon)"},HSh_T2[4],P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,8850 // 0x1D,AtLeast)},{"Fenix (Dragoon)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Norad II (Battlecruiser)"},HSh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})



CIfEnd()

HiveCD26 = CIf_GunTrig(P8, "Zerg Hive", "CD26",20000 // 0x1D,7);



	
G_CB_TScanEff({CD(GunTrigGCcode,0,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,980//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,1960 // 0x1D,AtLeast)},{"Zeratul (Dark Templar)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,2450 // 0x1D,AtLeast)},{"Mojo (Scout)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,2950 // 0x1D,AtLeast)},{"Gui Montag (Firebat)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,3320 // 0x1D,AtLeast)},{"Danimoth (Arbiter)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TScanEff({CD(GunTrigGCcode,3680//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,3930//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,4420//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 426, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,4910 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5040 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5160 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5280 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[4],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5410 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[5],P8,GunTrigGLoc,1,{LMTable="MAX"})



G_CB_TSetSpawn({CD(GunTrigGCcode,5950 // 0x1D,AtLeast)},{"Alan Schezar (Goliath)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,6390 // 0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,6880 // 0x1D,AtLeast)},{"Fenix (Zealot)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,7250 // 0x1D,AtLeast)},{"Kukulza (Mutalisk)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})


G_CB_TSetSpawn({CD(GunTrigGCcode,7860 // 0x1D,AtLeast)},{"Mojo (Scout)"},HSh_T2[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8110 // 0x1D,AtLeast)},{"Tassadar/Zeratul (Archon)"},HSh_T2[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8360 // 0x1D,AtLeast)},{"Mojo (Scout)"},HSh_T2[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8600 // 0x1D,AtLeast)},{"Tassadar/Zeratul (Archon)"},HSh_T2[4],P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,8850 // 0x1D,AtLeast)},{"Fenix (Dragoon)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Norad II (Battlecruiser)"},HSh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})




CIfEnd()



HiveCD20 = CIf_GunTrig(P7, "Zerg Hive", "CD20",20000 // 0x1D,7);



G_CB_TScanEff({CD(GunTrigGCcode,0,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,980//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,1960 // 0x1D,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,2450 // 0x1D,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,2950 // 0x1D,AtLeast)},{"Kukulza (Mutalisk)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,3320 // 0x1D,AtLeast)},{"Kukulza (Guardian)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TScanEff({CD(GunTrigGCcode,3680//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,3930//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,4420//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 426, 1,{LMTable="MAX"})



G_CB_TSetSpawn({CD(GunTrigGCcode,4910 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5040 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5160 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5280 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[4],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5410 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[5],P8,GunTrigGLoc,1,{LMTable="MAX"})



G_CB_TSetSpawn({CD(GunTrigGCcode,5950 // 0x1D,AtLeast)},{"Zeratul (Dark Templar)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,6390 // 0x1D,AtLeast)},{"Mojo (Scout)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,6880 // 0x1D,AtLeast)},{"Gui Montag (Firebat)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,7250 // 0x1D,AtLeast)},{"Danimoth (Arbiter)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})


G_CB_TSetSpawn({CD(GunTrigGCcode,7860 // 0x1D,AtLeast)},{"Fenix (Zealot)"},HSh_T2[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8110 // 0x1D,AtLeast)},{"Fenix (Dragoon)"},HSh_T2[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8360 // 0x1D,AtLeast)},{"Fenix (Zealot)"},HSh_T2[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8600 // 0x1D,AtLeast)},{"Fenix (Dragoon)"},HSh_T2[4],P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,8850 // 0x1D,AtLeast)},{"Tassadar/Zeratul (Archon)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Norad II (Battlecruiser)"},HSh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})



CIfEnd()
HiveCD21 = CIf_GunTrig(P8, "Zerg Hive", "CD21",20000 // 0x1D,7);

G_CB_TScanEff({CD(GunTrigGCcode,0,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,980//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,1960 // 0x1D,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,2450 // 0x1D,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,2950 // 0x1D,AtLeast)},{"Kukulza (Mutalisk)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,3320 // 0x1D,AtLeast)},{"Kukulza (Guardian)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TScanEff({CD(GunTrigGCcode,3680//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 10, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,3930//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 4, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,4420//0x1D,AtLeast)}, {HCC}, GunTrigGLoc, 426, 1,{LMTable="MAX"})



G_CB_TSetSpawn({CD(GunTrigGCcode,4910 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5040 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5160 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5280 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[4],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,5410 // 0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},HSh_T1[5],P8,GunTrigGLoc,1,{LMTable="MAX"})



G_CB_TSetSpawn({CD(GunTrigGCcode,5950 // 0x1D,AtLeast)},{"Zeratul (Dark Templar)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,6390 // 0x1D,AtLeast)},{"Mojo (Scout)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,6880 // 0x1D,AtLeast)},{"Gui Montag (Firebat)"},CD54Sh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,7250 // 0x1D,AtLeast)},{"Danimoth (Arbiter)"},CD54Sh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})


G_CB_TSetSpawn({CD(GunTrigGCcode,7860 // 0x1D,AtLeast)},{"Fenix (Zealot)"},HSh_T2[1],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8110 // 0x1D,AtLeast)},{"Fenix (Dragoon)"},HSh_T2[2],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8360 // 0x1D,AtLeast)},{"Fenix (Zealot)"},HSh_T2[3],P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,8600 // 0x1D,AtLeast)},{"Fenix (Dragoon)"},HSh_T2[4],P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,8850 // 0x1D,AtLeast)},{"Tassadar/Zeratul (Archon)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},HSh_1,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,9340 // 0x1D,AtLeast)},{"Norad II (Battlecruiser)"},HSh_2,P8,GunTrigGLoc,1,{LMTable="MAX"})


CIfEnd()



NDCD200 = CIf_GunTrig(P7, "Norad II (Crashed Battlecruiser)", "CD200",400,5);
-- ms // 0x1D
G_CB_TScanEff({CD(GunTrigGCcode,0,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 213, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,340 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 332, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,670 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 215, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,1000 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 334, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,4030 // 0x1D,AtLeast)}, {50}, {CSMakeCircle(8, 64, 0, PlotSizeCalc(8, 3), 0)}, P8, GunTrigGLoc, 1, {RepeatType="Nothing",LMTable="MAX"})


G_CB_TScanEff({CD(GunTrigGCcode,4030 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 213, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,4380 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 332, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,4610 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 215, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,5040 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 334, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,6080 // 0x1D,AtLeast)}, {"Vulture Spider Mine"}, {CSMakeCircle(25, 256, 0, 26, 1)}, P8, GunTrigGLoc, 1, {RepeatType="RemoveTimer",LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,6080 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 213, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,6400 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 332, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,6750 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 215, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,7080 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 334, 1,{LMTable="MAX"})


CIfEnd()


DGCD61 = CIf_GunTrig(P8, "Zerg Cerebrate Daggoth", "CD61",400);



Trigger2X(FP,{},{
	RotatePlayer({PlayWAVX("staredit\\wav\\fakeqt.ogg");PlayWAVX("staredit\\wav\\fakeqt.ogg");}, HumanPlayers, FP);
})

DoActions(FP, {SetDeathsX(Force1, SetTo, 0, 12,0xFFFFFF)},1)
CD61Sh_1 = CS_RatioXY(CSMakeLine(2, 48, 45, 20, 0), 1, 0.5)
CD61Sh_2 = CSMakeLine(2, 48, 0, 20, 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,2200 // 0x1D,AtLeast)}, {"Edmund Duke (Siege Mode)"}, CD61Sh_1, P6, "CD62", 1, {LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,3400 // 0x1D,AtLeast)}, {"Edmund Duke (Siege Mode)"}, CD61Sh_2, P6, "CD62", 1, {LMTable="MAX",DistanceXY={9*32,0}})
G_CB_TSetSpawn({CD(GunTrigGCcode,3400 // 0x1D,AtLeast)}, {"Edmund Duke (Siege Mode)"}, CD61Sh_2, P6, "CD62", 1, {LMTable="MAX",DistanceXY={-9*32,0}})

CIfOnce(FP, CD(GunTrigGCcode,4300 // 0x1D,AtLeast))
CFor(FP, 0, 100, 1)
CIf(FP,{Bring(P6, AtLeast, 1, "Edmund Duke (Siege Mode)", 64)})
DoActions(FP, {Simple_SetLoc(0, -32, -32, 32, 32),MoveLocation(1, "Edmund Duke (Siege Mode)", P6, 64),GiveUnits(1, "Edmund Duke (Siege Mode)", P6, 1, P9),RemoveUnit("Edmund Duke (Siege Mode)", P9),CreateUnit(1, 30, 1, P8)})
CIfEnd()
CForEnd()
CIfEnd()


CIfEnd()


CRCDANY = CIf_GunTrig(P8, "Mature Crysalis", 64,45000 // 0x1D);

CRCDT = CreateCcode()
CRCDT2 = CreateCcode()
DoActionsX(FP, {AddCD(CRCDT,1),AddCD(CRCDT2,1)})

CRCDMode = CreateCcode()
CIfOnce(FP)
TriggerX(FP, {}, {SetSwitch("Switch 100", Random)})
TriggerX(FP, {Switch("Switch 100", Cleared)}, {SetCD(CRCDMode,0)})
TriggerX(FP, {Switch("Switch 100", Set)}, {SetCD(CRCDMode,1)})


TriggerX(FP,{CD(CRCDMode,0)},{
	RotatePlayer({DisplayTextX(string.rep("\x13\x08불길한 예감\x04이 든다... \x11우리 집\x04으로 도망쳐야 할 것 같다...\n", 6), 4);
	PlayWAVX("staredit\\wav\\Jester.ogg");PlayWAVX("staredit\\wav\\Jester.ogg");}, HumanPlayers, FP);
})
TriggerX(FP,{CD(CRCDMode,1)},{
	RotatePlayer({DisplayTextX(string.rep("\x13\x08불길한 예감\x04이 든다... \x11우리 집\x04에서 도망쳐야 할 것 같다...\n", 6), 4);
	PlayWAVX("staredit\\wav\\Jester.ogg");PlayWAVX("staredit\\wav\\Jester.ogg");}, HumanPlayers, FP);
})
CIfEnd()



JRot = CreateVar(FP)
JRot2 = CreateVar(FP)
CIf(FP,{CD(CRCDANY,40500 // 0x1D,AtMost)})
--G_CB_TScanEff({CD(CRCDT,10,AtLeast)}, {CSMakeLine(1, 32, 90, 9, 0)}, {4032-(9*32),864}, 974, nil,{LMTable="MAX"})



TriggerX(FP,{CD(CRCDANY,1 // 0x1D,AtLeast)},{AddV(JRot,3)},{preserved})
TriggerX(FP,{CD(CRCDANY,5700 // 0x1D,AtLeast)},{AddV(JRot,3)},{preserved})
TriggerX(FP,{CD(CRCDANY,10400 // 0x1D,AtLeast)},{AddV(JRot,4)},{preserved})
TriggerX(FP,{CD(CRCDANY,15400 // 0x1D,AtLeast)},{AddV(JRot,6)},{preserved})
TriggerX(FP,{CD(CRCDANY,20000 // 0x1D,AtLeast)},{AddV(JRot,7)},{preserved})
TriggerX(FP,{CD(CRCDANY,24000 // 0x1D,AtLeast)},{AddV(JRot,9)},{preserved})
TriggerX(FP,{CD(CRCDANY,27000 // 0x1D,AtLeast)},{AddV(JRot,15)},{preserved})
for i = 0, 10 do
	TriggerX(FP,{CD(CRCDANY,(30000+(i*1000)) // 0x1D,AtLeast)},{AddV(JRot,15)},{preserved})
end
CIfX(FP,{CD(CRCDMode,1)})
CNeg(FP,JRot2,JRot)
CElseX()
CMov(FP,JRot2,JRot)
CIfXEnd()
CMov(FP,G_CB_RotateV,_Div(JRot2, 10))
f_Lengthdir(FP, 9*32, G_CB_RotateV, G_CB_X, G_CB_Y)
CAdd(FP,G_CB_X,4032-(9*32))
CAdd(FP,G_CB_Y,864)
G_CB_TScanEff({CD(CRCDT2,5,AtLeast)}, {CSMakeLine(1, 32, 90, 9, 0)}, {4032-(9*32),864}, 998, nil,{LMTable="MAX",RotateTable="Main"})
NegRot = CreateVar(FP)
CNeg(FP,NegRot,G_CB_RotateV)
G_CB_TScanEff({CD(CRCDT2,5,AtLeast)}, {CSMakeLine(1, 64, 90, 4, 0)}, nil, 429, nil,{LMTable="MAX",RotateTable=NegRot})

TriggerX(FP, {CD(CRCDT,10,AtLeast)}, {SetCD(CRCDT,0)},{preserved})
TriggerX(FP, {CD(CRCDT2,5,AtLeast)}, {SetCD(CRCDT2,0)},{preserved})
CIfEnd()

CIf(FP,{CD(CRCDANY,40500 // 0x1D,AtLeast)})


G_CB_TScanEff({CD(CRCDANY,40500 // 0x1D,AtLeast),CD(CRCDMode,0)}, {CSMakeCircle(6, 192, 0, PlotSizeCalc(6, 13), 0)}, {4032-(9*32),864}, 60, 1,{RepeatType=44})
G_CB_TScanEff({CD(CRCDANY,40500 // 0x1D,AtLeast),CD(CRCDMode,1)}, {CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 7), 0)}, {448,3888}, 60, 1,{RepeatType=44})

CMov(FP,0x6509B0,19025+25)
CFor(FP, 19025+19, 19025+(1700*84)+19,84)
CI=CForVariable()
CIf(FP,{{
	TTOR({DeathsX(CurrentPlayer, Exactly, 20, 0, 0xFF),DeathsX(CurrentPlayer, Exactly, 0, 0, 0xFF)}),
	TDeathsX(_Add(CI,55-19), Exactly, 0x04000000, 0, 0x04000000),
	TDeathsX(CI, AtLeast, 1*256, 0, 0xFF00)}})
	f_SaveCp()
	f_Read(FP,_Add(CI,6),RepHeroIndex,nil,0xFF,1)
	f_Read(FP,CI,PlayerV,nil,0xFF,1)
	f_LoadCp()
	TriggerX(FP, {CV(PlayerV,0),CV(RepHeroIndex,0)}, {AddV(P1MValue,1)}, {preserved})
	CDoActions(FP, {
		TSetMemory(_Add(_Mul(RepHeroIndex,12),PlayerV),Add,1),
		TSetDeathsX(_Add(CI,55-19), SetTo, 0, 0, 0x04000000),
		TSetDeathsX(CI, SetTo, 0, 0, 0xFF00),})
		


CIfEnd()
CAdd(FP,0x6509B0,84)
CForEnd()
CMov(FP,0x6509B0,FP)

CIfEnd()

CIfEnd()




ICD1 = CIf_GunTrig(P8, "Infested Command Center", "ICD",(21500//0x1D)+2,8);

ICD1T = CreateCcode()
HCCC = CSMakeGraphT({12,12},"HyperCycloidC",0,0,1.4,1.4,256) 
HCC0 = CS_Rotate(HCCC,180)
HCC = CS_RemoveStack(HCC0,15,0) -------하트
HCCR = CS_RatioXY(HCC, 7, 7)
ICDHeart = CS_FillPathXY(HCCR, 1, 96, 96, 0)
ICDHeartX = CS_OverlapX(HCCR,ICDHeart)
ActT = {}
for i = 2, #HCCR do
	if i~= #HCCR then
		table.insert(ActT,SetMemory(0x58DC60+(20*123),SetTo,2048+HCCR[i][1]-64))
		table.insert(ActT,SetMemory(0x58DC64+(20*123),SetTo,2048+HCCR[i][2]-64))
		table.insert(ActT,SetMemory(0x58DC68+(20*123),SetTo,2048+HCCR[i][1]+64))
		table.insert(ActT,SetMemory(0x58DC6C+(20*123),SetTo,2048+HCCR[i][2]+64))
		
		table.insert(ActT,SetMemory(0x58DC60+(20*125),SetTo,2048+HCCR[i+1][1]-64))
		table.insert(ActT,SetMemory(0x58DC64+(20*125),SetTo,2048+HCCR[i+1][2]-64))
		table.insert(ActT,SetMemory(0x58DC68+(20*125),SetTo,2048+HCCR[i+1][1]+64))
		table.insert(ActT,SetMemory(0x58DC6C+(20*125),SetTo,2048+HCCR[i+1][2]+64))

	else
		table.insert(ActT,SetMemory(0x58DC60+(20*123),SetTo,2048+HCCR[i][1]-64))
		table.insert(ActT,SetMemory(0x58DC64+(20*123),SetTo,2048+HCCR[i][2]-64))
		table.insert(ActT,SetMemory(0x58DC68+(20*123),SetTo,2048+HCCR[i][1]+64))
		table.insert(ActT,SetMemory(0x58DC6C+(20*123),SetTo,2048+HCCR[i][2]+64))
		
		table.insert(ActT,SetMemory(0x58DC60+(20*125),SetTo,2048+HCCR[2][1]-64))
		table.insert(ActT,SetMemory(0x58DC64+(20*125),SetTo,2048+HCCR[2][2]-64))
		table.insert(ActT,SetMemory(0x58DC68+(20*125),SetTo,2048+HCCR[2][1]+64))
		table.insert(ActT,SetMemory(0x58DC6C+(20*125),SetTo,2048+HCCR[2][2]+64))
	end
	
	table.insert(ActT,{Order("Tom Kazansky (Wraith)", P6, 124, Move, 126)})
end


G_CB_TSetSpawn({},{"Tom Kazansky (Wraith)"},ICDHeartX,P6,{2048,2048},1,{LMTable=6,RepeatType = "Nothing"})
DoActionsX(FP, {AddCD(ICD1T,1)})

G_CB_TScanEff({CD(ICD1T,15,AtLeast),CD(ICD1,10800//0x1D,AtLeast),CD(ICD1,21500//0x1D,AtMost)}, {HCCR}, {2048,2048}, 334)
TriggerX(FP, {CD(ICD1T,15,AtLeast)}, {SetCD(ICD1T,0)}, {preserved})
TriggerX(FP, {CD(ICD1,10800//0x1D)}, {SetCp(P6),RunAIScriptAt(JYD, 64)})
Trigger2X(FP, {CD(ICD1,10800//0x1D,AtLeast),CD(ICD1,21500//0x1D,AtMost)}, ActT,{preserved})
TriggerX(FP, {CD(ICD1,(21500//0x1D)+1)}, {GiveUnits(All, "Tom Kazansky (Wraith)", P6, 64, P8),SetCp(P8),RunAIScriptAt(JYD, 64)})

CIfEnd()






CD77 = CIf_GunTrig(P8, "Warp Gate", "CD77",(21500//0x1D)+2,8);

ICD2T = CreateCcode()

ICD2Star = CS_SortA(CSMakeStar(5,135,128,180,CS_Level("Star",5,13),CS_Level("Star",5,12)) , 0)
--CS_PrintBMPGraph(ICD2Star,nil,{{-10},{10}},{{-5},{5}},1,100,25,{0x00FFC0,0x80FFE0,0xC4FFF0},3)

ICD2StarFill = CS_FillPathXY(ICD2Star, 1, 96, 96, 0)
ICD2StarFillX = CS_OverlapX(ICD2Star,ICD2StarFill)
--PushErrorMsg(ICD2StarFillX[1])
ActT = {}
for i = 2, #ICD2Star do
	if i~= #ICD2Star then
		table.insert(ActT,SetMemory(0x58DC60+(20*123),SetTo,2048+ICD2Star[i][1]-48))
		table.insert(ActT,SetMemory(0x58DC64+(20*123),SetTo,2048+ICD2Star[i][2]-48))
		table.insert(ActT,SetMemory(0x58DC68+(20*123),SetTo,2048+ICD2Star[i][1]+48))
		table.insert(ActT,SetMemory(0x58DC6C+(20*123),SetTo,2048+ICD2Star[i][2]+48))
		
		table.insert(ActT,SetMemory(0x58DC60+(20*125),SetTo,2048+ICD2Star[i+1][1]-48))
		table.insert(ActT,SetMemory(0x58DC64+(20*125),SetTo,2048+ICD2Star[i+1][2]-48))
		table.insert(ActT,SetMemory(0x58DC68+(20*125),SetTo,2048+ICD2Star[i+1][1]+48))
		table.insert(ActT,SetMemory(0x58DC6C+(20*125),SetTo,2048+ICD2Star[i+1][2]+48))

	else
		table.insert(ActT,SetMemory(0x58DC60+(20*123),SetTo,2048+ICD2Star[i][1]-48))
		table.insert(ActT,SetMemory(0x58DC64+(20*123),SetTo,2048+ICD2Star[i][2]-48))
		table.insert(ActT,SetMemory(0x58DC68+(20*123),SetTo,2048+ICD2Star[i][1]+48))
		table.insert(ActT,SetMemory(0x58DC6C+(20*123),SetTo,2048+ICD2Star[i][2]+48))
		
		table.insert(ActT,SetMemory(0x58DC60+(20*125),SetTo,2048+ICD2Star[2][1]-48))
		table.insert(ActT,SetMemory(0x58DC64+(20*125),SetTo,2048+ICD2Star[2][2]-48))
		table.insert(ActT,SetMemory(0x58DC68+(20*125),SetTo,2048+ICD2Star[2][1]+48))
		table.insert(ActT,SetMemory(0x58DC6C+(20*125),SetTo,2048+ICD2Star[2][2]+48))
	end
	
	table.insert(ActT,{Order("Artanis (Scout)", P6, 124, Move, 126)})
end


G_CB_TSetSpawn({},{"Artanis (Scout)"},ICD2StarFillX,P6,{2048,2048},1,{LMTable=6,RepeatType = "Nothing"})
DoActionsX(FP, {AddCD(ICD2T,1)})

G_CB_TScanEff({CD(ICD2T,15,AtLeast),CD(CD77,10800//0x1D,AtLeast),CD(CD77,21500//0x1D,AtMost)}, {ICD2Star}, {2048,2048}, 215)
TriggerX(FP, {CD(ICD2T,15,AtLeast)}, {SetCD(ICD2T,0)}, {preserved})
TriggerX(FP, {CD(CD77,10800//0x1D)}, {SetCp(P6),RunAIScriptAt(JYD, 64)})
Trigger2X(FP, {CD(CD77,10800//0x1D,AtLeast),CD(CD77,21500//0x1D,AtMost)}, ActT,{preserved})
TriggerX(FP, {CD(CD77,(21500//0x1D)+1)}, {GiveUnits(All, "Artanis (Scout)", P6, 64, P8),SetCp(P8),RunAIScriptAt(JYD, 64)})

CIfEnd()


CD219 = CIf_GunTrig(P7, "Ion Cannon", "CD219",(6000//0x1D)+2,6);

CD219Sh_1_1 = CSMakeCircle(20, 128, 0, 21, 1)
CD219Sh_1_2 = CSMakeCircle(20, 128+16, 0, 21, 1)
CD219Sh_1_3 = CSMakeCircle(20, 128+32, 0, 21, 1)
CD219Sh_1_4 = CSMakeCircle(20, 128+48, 0, 21, 1)
CD219Sh_2_1 = CSMakeCircle(20, 128+64, 0, 21, 1)
CD219Sh_2_2 = CSMakeCircle(20, 128+72, 0, 21, 1)
CD219Sh_2_3 = CSMakeCircle(20, 128+84, 0, 21, 1)
CD219Sh_2_4 = CSMakeCircle(20, 128+96, 0, 21, 1)
G_CB_TSetSpawn({CD(GunTrigGCcode,0 // 0x1D,AtLeast)},{"Kukulza (Mutalisk)"},CD219Sh_1_1,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,370 // 0x1D,AtLeast)},{"Kukulza (Mutalisk)"},CD219Sh_1_2,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,740 // 0x1D,AtLeast)},{"Kukulza (Guardian)"},CD219Sh_1_3,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,1100 // 0x1D,AtLeast)},{"Kukulza (Guardian)"},CD219Sh_1_4,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,1480 // 0x1D,AtLeast)},{"Artanis (Scout)"},CD219Sh_2_1,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,1850 // 0x1D,AtLeast)},{"Artanis (Scout)"},CD219Sh_2_2,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,2220 // 0x1D,AtLeast)},{"Tom Kazansky (Wraith)"},CD219Sh_2_3,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,2590 // 0x1D,AtLeast)},{"Tom Kazansky (Wraith)"},CD219Sh_2_4,P8,GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
CD219Sh_3 = CSMakePolygon(6, 64, 90, PlotSizeCalc(6, 3), PlotSizeCalc(6, 2))
G_CB_TSetSpawn({CD(GunTrigGCcode,2960 // 0x1D,AtLeast)},{84,"Danimoth (Arbiter)","Tassadar/Zeratul (Archon)"},CD219Sh_3,{P6,P8,P8},"CD50",1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,3330 // 0x1D,AtLeast)},{84,"Danimoth (Arbiter)","Tassadar/Zeratul (Archon)"},CD219Sh_3,{P6,P8,P8},"CD51",1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,3700 // 0x1D,AtLeast)},{84,"Danimoth (Arbiter)","Tassadar/Zeratul (Archon)"},CD219Sh_3,{P6,P8,P8},"CD53",1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,4070 // 0x1D,AtLeast)},{84,"Danimoth (Arbiter)","Tassadar/Zeratul (Archon)"},CD219Sh_3,{P6,P8,P8},"CP1",1,{LMTable="MAX",Order={Patrol,"CD219"}})

CD219Sh_4 = CS_RatioXY(CSMakePolygon(4, 96, 0, PlotSizeCalc(4, 5), PlotSizeCalc(4, 4)), 1, 0.5)
CD219Sh_5 = CS_RatioXY(CSMakePolygon(4, 96, 0, PlotSizeCalc(4, 4), PlotSizeCalc(4, 3)), 1, 0.5)
CD219Sh_6 = CS_RatioXY(CSMakePolygon(4, 96, 0, PlotSizeCalc(4, 3), PlotSizeCalc(4, 2)), 1, 0.5)
CD219Sh_7 = CS_RatioXY(CSMakePolygon(4, 128, 0, PlotSizeCalc(4, 3), PlotSizeCalc(4, 2)), 1, 0.5)
G_CB_TSetSpawn({CD(GunTrigGCcode,4440 // 0x1D,AtLeast)},{84,"Edmund Duke (Siege Mode)"},CD219Sh_4,{P6,P8},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,4810 // 0x1D,AtLeast)},{84,"Warbringer (Reaver)"},CD219Sh_5,{P6,P8},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,5180 // 0x1D,AtLeast)},{84,"Gantrithor (Carrier)"},CD219Sh_6,{P6,P8},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,5550 // 0x1D,AtLeast)},{84,"Norad II (Battlecruiser)"},CD219Sh_7,{P6,P8},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD219"}})






CIfEnd()

CD68 = CIf_GunTrig(P8, "Protoss Stargate", "CD68", 40000//0x1D, 10)
CD68Sh_1_1 = CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 2), PlotSizeCalc(6, 1))
CD68Sh_1_2 = CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 3), PlotSizeCalc(6, 2))
CD68Sh_1_3 = CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 4), PlotSizeCalc(6, 3))
CD68Sh_2 = CS_SortA(CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 5), PlotSizeCalc(6, 4)), 0)
CD68Sh_3 = CS_SortA(CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 5), PlotSizeCalc(6, 4)), 1)

CD68Sh_2_1 = CS_SortA(CSMakeCircle(6, 107, 0, PlotSizeCalc(6, 3), PlotSizeCalc(6, 2)), 0)
CD68Sh_4 = CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 4), 0)
function Z2Eff1(Time)
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+(0//0x1D),AtLeast)}, {CD68Sh_1_1}, GunTrigGLoc, 334,1,{LMTable="MAX"},17)
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+(350//0x1D),AtLeast)}, {CD68Sh_1_2}, GunTrigGLoc, 334,1,{LMTable="MAX"},16)
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+(700//0x1D),AtLeast)}, {CD68Sh_1_3}, GunTrigGLoc, 334,1,{LMTable="MAX"},9)
end
function Z2Eff2(Time)
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+(0//0x1D),AtLeast)}, {CD68Sh_1_1}, GunTrigGLoc, 60,1,{LMTable="MAX"},17)
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+(350//0x1D),AtLeast)}, {CD68Sh_1_2}, GunTrigGLoc, 60,1,{LMTable="MAX"},16)
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+(700//0x1D),AtLeast)}, {CD68Sh_1_3}, GunTrigGLoc, 60,1,{LMTable="MAX"},9)
end
--PushErrorMsg(CD68Sh_3[1])
function Z2Eff3(Time)
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+(0//0x1D),AtLeast)}, {CD68Sh_2}, GunTrigGLoc, 215,1,{LMTable=4})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(Time//0x1D)+(0//0x1D),AtLeast)},{"Hyperion (Battlecruiser)"},CD68Sh_2,{P8},GunTrigGLoc,1,{LMTable=4,RepeatType = "Patrol_Center"})
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+((460*1)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+((460*2)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+((460*3)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+((460*4)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+((460*5)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+((460*6)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
	G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+((460*7)//0x1D),AtLeast)}, {CD68Sh_3}, GunTrigGLoc, 215,1,{LMTable=4})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(Time//0x1D)+((460*7)//0x1D),AtLeast)},{"Hyperion (Battlecruiser)"},CD68Sh_3,{P8},GunTrigGLoc,1,{LMTable=4,RepeatType = "Patrol_Center"})
end
for i = 0, 7 do
	Z2Eff1(930+(930*i))
end
for i = 0, 5 do
	Z2Eff2(8430+(930*i))
end
Z2Eff3(930)
Z2Eff3(4680)
Z2Eff3(8430)

G_CB_TScanEff({CD(GunTrigGCcode,(12180//0x1D)+(0//0x1D),AtLeast)}, {CD68Sh_2}, GunTrigGLoc, 215,1,{LMTable=4})
G_CB_TScanEff({CD(GunTrigGCcode,(12180//0x1D)+((460*1)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,(12180//0x1D)+((460*2)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,(12180//0x1D)+((460*3)//0x1D),AtLeast)}, {CD68Sh_2_1}, GunTrigGLoc, 214,1,{LMTable="MAX"})


G_CB_TSetSpawn({CD(GunTrigGCcode,(14060//0x1D),AtLeast)},{"Mojo (Scout)",84},CD68Sh_1_3,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",RepeatType = "Patrol_Center"})
G_CB_TSetSpawn({CD(GunTrigGCcode,(14530//0x1D),AtLeast)},{"Gantrithor (Carrier)",84},CD68Sh_1_2,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",RepeatType = "Patrol_Center"})
G_CB_TSetSpawn({CD(GunTrigGCcode,(15000//0x1D),AtLeast)},{"Norad II (Battlecruiser)",84},CD68Sh_1_1,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",RepeatType = "Patrol_Center"})
G_CB_TSetSpawn({CD(GunTrigGCcode,(15460//0x1D),AtLeast)},{"Hyperion (Battlecruiser)","Artanis (Scout)","Edmund Duke (Siege Mode)",84},CD68Sh_4,{P8,P8,P8,P6},GunTrigGLoc,1,{LMTable="MAX",RepeatType = "Patrol_Center"})


CIfEnd()



ICD2 = CIf_GunTrig(P7, "Infested Command Center", "ICD2",1001,9);

ICD2Sh_1 = CS_FillPathHX2({12  ,{1792, 1280},{2048, 1152},{1952, 1088},{1728, 1184},{3232, 960},{2624, 672},{2624, 288},{2976, 288},{2976, 512},{3232, 672},{3232, 768},{3456, 896}} ,1,96,64,1,0,45,5)
ICD2Sh_2 = CS_FillPathHX2({6   ,{3296, 672},{3008, 480},{3008, 256},{3168, 320},{3200, 448},{3424, 576}},1,32,48,1,0,45,5)
ICD2Sh_3 = CS_FillPathHX2({10  ,{3264, 256},{3264, 448},{3424, 544},{3840, 544},{3840, 256},{3744, 288},{3648, 192},{3648, 32},{3328, 32},{3328, 224}} ,1,64,48,1,0,45,5)

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Edmund Duke (Siege Mode)"},ICD2Sh_1,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,250,AtLeast)},{"Edmund Duke (Siege Mode)"},ICD2Sh_2,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,500,AtLeast)},{"Edmund Duke (Siege Mode)"},ICD2Sh_3,P8,{0,0},1,{LMTable="MAX"})

TriggerX(FP,{CD(GunTrigGCcode,500,AtLeast),CD(GunTrigGCcode,1000,AtMost)},{CreateUnit(1, "Mojo (Scout)","ICD2",P6),Order("Mojo (Scout)", P6, "ICD2", Move, "ICD2")},{preserved})
TriggerX(FP,{CD(GunTrigGCcode,1001,AtLeast)},{GiveUnits(All, "Mojo (Scout)", P6, "ICD2", P8),SetCp(P8),RunAIScriptAt(JYD, "ICD2")},{preserved})


CIfEnd()


CD218Sh_1 = CS_OverlapX(
	CSMakeLine(1, 64, -30, 3, 0),
	CSMakeLine(1, 64, -15, 3, 0),
	CSMakeLine(1, 64, 0, 3, 0),
	CSMakeLine(1, 64, 15, 3, 0),
	CSMakeLine(1, 64, 30, 3, 0)
)
CD218Sh_2 = CSMakeCircle(6, 240, 0, 7, 1)

function DDINGEff(Loc1,Loc2)
	G_CB_TScanEff({CD(GunTrigGCcode,(460//0x1D),AtLeast)}, {CD218Sh_1}, Loc1, 434,1,{LMTable="MAX",RotateTable = 45})
	G_CB_TScanEff({CD(GunTrigGCcode,(460//0x1D),AtLeast)}, {CD218Sh_1}, Loc2, 434,1,{LMTable="MAX",RotateTable = 45})
	
	G_CB_TScanEff({CD(GunTrigGCcode,(1400//0x1D),AtLeast)}, {CD218Sh_1}, Loc1, 433,1,{LMTable="MAX",RotateTable = 45+90})
	G_CB_TScanEff({CD(GunTrigGCcode,(1400//0x1D),AtLeast)}, {CD218Sh_1}, Loc2, 433,1,{LMTable="MAX",RotateTable = 45+90})
	
	G_CB_TScanEff({CD(GunTrigGCcode,(2340//0x1D),AtLeast)}, {CD218Sh_1}, Loc1, 432,1,{LMTable="MAX",RotateTable = 45+180})
	G_CB_TScanEff({CD(GunTrigGCcode,(2340//0x1D),AtLeast)}, {CD218Sh_1}, Loc2, 432,1,{LMTable="MAX",RotateTable = 45+180})
	
	G_CB_TScanEff({CD(GunTrigGCcode,(3280//0x1D),AtLeast)}, {CD218Sh_1}, Loc1, 431,1,{LMTable="MAX",RotateTable = 45+270})
	G_CB_TScanEff({CD(GunTrigGCcode,(3280//0x1D),AtLeast)}, {CD218Sh_1}, Loc2, 431,1,{LMTable="MAX",RotateTable = 45+270})
	
	G_CB_TScanEff({CD(GunTrigGCcode,(4210//0x1D),AtLeast)}, {CD218Sh_1}, Loc1, 430,1,{LMTable="MAX",RotateTable = 45+180})
	G_CB_TScanEff({CD(GunTrigGCcode,(4210//0x1D),AtLeast)}, {CD218Sh_1}, Loc2, 430,1,{LMTable="MAX",RotateTable = 45+180})
	
	G_CB_TScanEff({CD(GunTrigGCcode,(5150//0x1D),AtLeast)}, {CD218Sh_1}, Loc1, 430,1,{LMTable="MAX",RotateTable = 45+90})
	G_CB_TScanEff({CD(GunTrigGCcode,(5150//0x1D),AtLeast)}, {CD218Sh_1}, Loc2, 430,1,{LMTable="MAX",RotateTable = 45+90})
	
	G_CB_TScanEff({CD(GunTrigGCcode,(6090//0x1D),AtLeast)}, {CD218Sh_1}, Loc1, 430,1,{LMTable="MAX",RotateTable = 45+0})
	G_CB_TScanEff({CD(GunTrigGCcode,(6090//0x1D),AtLeast)}, {CD218Sh_1}, Loc2, 430,1,{LMTable="MAX",RotateTable = 45+0})
	
	end
function DDINGEff2(Time,Loc1,Loc2)
	for i = 0,15 do
		G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+i,AtLeast)}, {CD218Sh_2}, Loc1, 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},10)
		G_CB_TScanEff({CD(GunTrigGCcode,(Time//0x1D)+i,AtLeast)}, {CD218Sh_2}, Loc2, 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},10)
	end
end
CD218Sh_3 = CSMakeStar(5,135,128,180,CS_Level("Star",5,2),0)
function DDINGSpanwnSet(Time,Loc1,Loc2,UnitTable)
	DDINGEff2(Time-940,Loc1,Loc2)
	G_CB_TSetSpawn({CD(GunTrigGCcode,(Time) // 0x1D,AtLeast)},{UnitTable[1]},CD218Sh_3,P8,Loc1,1,{LMTable="MAX",Order={Patrol,Loc2}})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(Time) // 0x1D,AtLeast)},{UnitTable[2]},CD218Sh_3,P8,Loc1,1,{LMTable="MAX",Order={Attack,Loc2}})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(Time) // 0x1D,AtLeast)},{UnitTable[3]},CD218Sh_3,P8,Loc2,1,{LMTable="MAX",Order={Patrol,Loc1}})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(Time) // 0x1D,AtLeast)},{UnitTable[4]},CD218Sh_3,P8,Loc2,1,{LMTable="MAX",Order={Attack,Loc1}})
end

CD218 = CIf_GunTrig(P8, "Power Generator", "CD218",(26250//0x1D)+1,11);

DDINGEff("CD218","CD217")

DDINGSpanwnSet(7500,"CD218","CD217",{"Fenix (Dragoon)","Mojo (Scout)","Tassadar (Templar)","Danimoth (Arbiter)"})
DDINGSpanwnSet(11250,"CD218","CD217",{"Zeratul (Dark Templar)","Gantrithor (Carrier)","Gui Montag (Firebat)","Hyperion (Battlecruiser)"})
DDINGSpanwnSet(15000,"CD218","CD217",{"Jim Raynor (Vulture)","Artanis (Scout)","Aldaris (Templar)","Raszagal (Dark Templar)"})
DDINGSpanwnSet(18750,"CD218","CD217",{"Fenix (Dragoon)","Mojo (Scout)","Tassadar (Templar)","Danimoth (Arbiter)"})
DDINGSpanwnSet(22500,"CD218","CD217",{"Zeratul (Dark Templar)","Gantrithor (Carrier)","Gui Montag (Firebat)","Hyperion (Battlecruiser)"})
DDINGSpanwnSet(26250,"CD218","CD217",{"Jim Raynor (Vulture)","Artanis (Scout)","Aldaris (Templar)","Raszagal (Dark Templar)"})





CIfEnd()
CD216 = CIf_GunTrig(P8, "Power Generator", "CD216",(26250//0x1D)+1,11);

DDINGEff("CD216","CD215")
DDINGSpanwnSet(7500,"CD216","CD215",{"Jim Raynor (Vulture)","Artanis (Scout)","Aldaris (Templar)","Raszagal (Dark Templar)"})
DDINGSpanwnSet(11250,"CD216","CD215",{"Fenix (Dragoon)","Mojo (Scout)","Tassadar (Templar)","Danimoth (Arbiter)"})
DDINGSpanwnSet(15000,"CD216","CD215",{"Zeratul (Dark Templar)","Gantrithor (Carrier)","Gui Montag (Firebat)","Hyperion (Battlecruiser)"})
DDINGSpanwnSet(18750,"CD216","CD215",{"Jim Raynor (Vulture)","Artanis (Scout)","Aldaris (Templar)","Raszagal (Dark Templar)"})
DDINGSpanwnSet(22500,"CD216","CD215",{"Fenix (Dragoon)","Mojo (Scout)","Tassadar (Templar)","Danimoth (Arbiter)"})
DDINGSpanwnSet(26250,"CD216","CD215",{"Zeratul (Dark Templar)","Gantrithor (Carrier)","Gui Montag (Firebat)","Hyperion (Battlecruiser)"})

CIfEnd()

CD205 = CIf_GunTrig(P8, "Psi Disrupter", "CD205",30000//0x1D,12);
Req_Rot = CreateVar(FP)

G_CB_TScanEff({CD(CD205,1,AtLeast),CD(CD205,14540//0x1D,AtMost)}, {CSMakeLine(4, 128, 0, 5, 1)}, "CD205", 391, nil,{LMTable="MAX",RotateTable=Req_Rot})
CAdd(FP,Req_Rot,3)

for i = 0,31 do
	TriggerX(FP,{CD(CD205,(10180//0x1D)+((i*130)//0x1D),AtLeast)},{SetMemory(0x657A9C,Subtract,1)})
	
end

Trigger2X(FP, {CD(CD205,(14360//0x1D),AtLeast)}, {RotatePlayer({CenterView("CD205")}, HumanPlayers, FP)})
TriggerX(FP,{CD(CD205,(14360//0x1D),AtLeast)},{SetMemory(0x657A9C,SetTo,31)})
TriggerX(FP,{CD(CD205,(14720//0x1D),AtLeast)},{SetMemory(0x657A9C,SetTo,15)})
TriggerX(FP,{CD(CD205,(15270//0x1D),AtLeast)},{SetMemory(0x657A9C,SetTo,31)})
Req_Eff = CSMakeCircle(6, 64, 0, PlotSizeCalc(6,5), 0)
G_CB_TScanEff({CD(GunTrigGCcode,(14360//0x1D),AtLeast)}, {Req_Eff}, GunTrigGLoc, 334,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,(14720//0x1D),AtLeast)}, {Req_Eff}, GunTrigGLoc, 215,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,(15270//0x1D),AtLeast)}, {Req_Eff}, GunTrigGLoc, 60,1,{LMTable="MAX"})




I1a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-10,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),10,0))
I1b = CS_MoveXY(CSMakeLine(2,20,90,13,0),0,-220)
I1c = CS_MoveXY(CSMakeLine(2,20,90,13,0),0,200)

I2a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-50,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),50,0))
I2b = CS_MoveXY(CSMakeLine(2,25,90,13,0),0,-220)
I2c = CS_MoveXY(CSMakeLine(2,25,90,13,0),0,200)

I3a = CS_OverlapX(CS_MoveXY(CSMakeLine(2,40,0,10,0),-90,0),CSMakeLine(2,40,0,10,0),CS_MoveXY(CSMakeLine(2,40,0,10,0),90,0))
I3b = CS_MoveXY(CSMakeLine(2,30,90,13,0),0,-220)
I3c = CS_MoveXY(CSMakeLine(2,30,90,13,0),0,200)

I4a = CS_MoveXY(CSMakeLine(2,40,0,10,0),0,0)
I4b = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,-220)
I4c = CS_MoveXY(CSMakeLine(2,20,90,7,0),0,200)
I4 = CS_MoveXY(CS_OverlapX(I4a,I4b,I4c),-220,0)
I4A = CS_MoveXY(CS_OverlapX(CSMakeLine(1,30,15,15,1),CSMakeLine(1,30,-15,15,0)),50,200)




Req_RD = CS_CropXY(CSMakeCircle(6, 64, 0, PlotSizeCalc(6,5), 0), {0,2048}, {0,2048})--오른쪽아래
Req_LU = CS_CropXY(CSMakeCircle(6, 64, 0, PlotSizeCalc(6,5), 0), {-2048,0}, {-2048,0})--왼쪽위
Req_RU = CS_CropXY(CSMakeCircle(6, 64, 0, PlotSizeCalc(6,5), 0), {-2048,0}, {0,2048})--오른쪽위
Req_LD = CS_CropXY(CSMakeCircle(6, 64, 0, PlotSizeCalc(6,5), 0), {0,2048}, {-2048,0})--왼쪽아래
--CD201
--CD202
--CD203
--CD204
--오른쪽위
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*0))//0x1D),AtLeast)},{"Sarah Kerrigan (Ghost)",84},Req_RU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD203"}})
--왼쪽위
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*1))//0x1D),AtLeast)},{"Alan Schezar (Goliath)",84},Req_LU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD204"}})
--아래
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*2))//0x1D),AtLeast)},{"Tom Kazansky (Wraith)",84},Req_RD,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD201"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*2))//0x1D),AtLeast)},{"Tom Kazansky (Wraith)",84},Req_LD,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD202"}})
--위
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*3))//0x1D),AtLeast)},{"Hyperion (Battlecruiser)",84},Req_LU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD204"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*3))//0x1D),AtLeast)},{"Hyperion (Battlecruiser)",84},Req_RU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD203"}})
--오른
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*4))//0x1D),AtLeast)},{"Jim Raynor (Vulture)",84},Req_RU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD203"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*4))//0x1D),AtLeast)},{"Tom Kazansky (Wraith)",84},Req_RD,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD201"}})
--왼
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*5))//0x1D),AtLeast)},{"Alan Schezar (Goliath)",84},Req_LD,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD202"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*5))//0x1D),AtLeast)},{"Hyperion (Battlecruiser)",84},Req_LU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD204"}})
--오른
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*6))//0x1D),AtLeast)},{"Edmund Duke (Siege Tank)",84},Req_RU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD203"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*6))//0x1D),AtLeast)},{"Tom Kazansky (Wraith)",84},Req_RD,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD201"}})
--위
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*7))//0x1D),AtLeast)},{"Sarah Kerrigan (Ghost)",84},Req_RU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD203"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*7))//0x1D),AtLeast)},{"Hyperion (Battlecruiser)",84},Req_LU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD204"}})

--1
CNA1 = CS_OverlapX(I1a,I1b,I1c) -- 1
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*8))//0x1D),AtLeast)},{"Kukulza (Mutalisk)",84},CNA1,{P8,P6},"CD201",1,{LMTable="MAX",Order={Attack,"CD205"}})

--2
CNA2 = CS_OverlapX(I2a,I2b,I2c) -- 2
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*9))//0x1D),AtLeast)},{"Kukulza (Mutalisk)",84},CNA2,{P8,P6},"CD202",1,{LMTable="MAX",Order={Attack,"CD205"}})

--3
CNA3 = CS_OverlapX(I3a,I3b,I3c) -- 3
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*10))//0x1D),AtLeast)},{"Kukulza (Mutalisk)",84},CNA3,{P8,P6},"CD203",1,{LMTable="MAX",Order={Attack,"CD205"}})

--4
CNA4 = CS_MoveXY(CS_OverlapX(I4A,I4),100,0) -- 4
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*11))//0x1D),AtLeast)},{"Kukulza (Mutalisk)",84},CNA4,{P8,P6},"CD204",1,{LMTable="MAX",Order={Attack,"CD205"}})

--ㅈㅅ
w_sh = {23  ,{1920, 3680},{1984, 3680},{2048, 3680},{2112, 3680},{2176, 3680},{2240, 3680},{2304, 3680},{2368, 3680},{2144, 3712},{2112, 3744},{2080, 3776},{2048, 3808},{2016, 3840},{1984, 3872},{1952, 3904},{1920, 3936},{2176, 3744},{2208, 3776},{2240, 3808},{2272, 3840},{2304, 3872},{2336, 3904},{2368, 3936}}
t_sh = {19  ,{2144, 3712},{2112, 3744},{2080, 3776},{2048, 3808},{2016, 3840},{1984, 3872},{1952, 3904},{1920, 3936},{1888, 3968},{1856, 4000},{2176, 3744},{2208, 3776},{2240, 3808},{2272, 3840},{2304, 3872},{2336, 3904},{2368, 3936},{2400, 3968},{2432, 4000}}
w_sh = CS_MoveXY(CS_RatioXY(CS_MoveXY(w_sh,-2160,-3856), 0.5, 1), -32*7, 0)
t_sh = CS_MoveXY(CS_RatioXY(CS_MoveXY(t_sh,-2160,-3856), 0.5, 1), 32*7, 0)
wt_sh = CS_SortX(CS_OverlapX(w_sh,t_sh), 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*12))//0x1D),AtLeast)},{"Kukulza (Guardian)"},w_sh,{P8},GunTrigGLoc,1,{Order={Attack,"CD203"},LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*12))//0x1D),AtLeast)},{84},w_sh,{P6},GunTrigGLoc,1,{Order={Attack,"CD203"},LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*14))//0x1D),AtLeast)},{"Kukulza (Guardian)"},t_sh,{P8},GunTrigGLoc,1,{Order={Attack,"CD203"},LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*14))//0x1D),AtLeast)},{84},t_sh,{P6},GunTrigGLoc,1,{Order={Attack,"CD203"},LMTable="MAX"})

--오른쪽에서 왼쪽으로(2)
RL = CS_SortX(CSMakeStar(4, 180, 64, 0, PlotSizeCalc(4*2, 4),0), 1)
LR = CS_SortX(CSMakeStar(4, 180, 64, 0, PlotSizeCalc(4*2, 4),0), 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*16))//0x1D),AtLeast)},{"Tom Kazansky (Wraith)"},RL,{P8},GunTrigGLoc,1,{Order={Attack,"CD205"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*16))//0x1D),AtLeast)},{84},RL,{P6},GunTrigGLoc,1,{Order={Attack,"CD205"}})
--왼쪽에서 오른쪽으로(2)
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*18))//0x1D),AtLeast)},{"Hyperion (Battlecruiser)"},LR,{P8},GunTrigGLoc,1,{Order={Attack,"CD205"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*18))//0x1D),AtLeast)},{84},LR,{P6},GunTrigGLoc,1,{Order={Attack,"CD205"}})
--오른쪽에서 왼쪽으로(2)
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*20))//0x1D),AtLeast)},{"Artanis (Scout)"},RL,{P8},GunTrigGLoc,1,{Order={Attack,"CD205"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*20))//0x1D),AtLeast)},{84},RL,{P6},GunTrigGLoc,1,{Order={Attack,"CD205"}})
--왼쪽에서 오른쪽으로(2)
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*22))//0x1D),AtLeast)},{"Mojo (Scout)"},LR,{P8},GunTrigGLoc,1,{Order={Attack,"CD205"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*22))//0x1D),AtLeast)},{84},LR,{P6},GunTrigGLoc,1,{Order={Attack,"CD205"}})
--위
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*24))//0x1D),AtLeast)},{"Raszagal (Dark Templar)",84},Req_RU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD203"}})
--G_CB_TSetSpawn({CD(GunTrigGCcode,(14060//0x1D),AtLeast)},{"Raszagal (Dark Templar)",84},Req_LU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Attack,"CD204"}})

--오른아래
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*26))//0x1D),AtLeast)},{"Aldaris (Templar)",84},Req_RD,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD201"}})
--
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*28))//0x1D),AtLeast)},{"Zeratul (Dark Templar)",84},Req_LU,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD204"}})
--
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*30))//0x1D),AtLeast)},{"Edmund Duke (Siege Tank)",84},Req_LD,{P8,P6},GunTrigGLoc,1,{LMTable="MAX",Order={Patrol,"CD202"}})
--하트
HCCC = CSMakeGraphT({12,12},"HyperCycloidC",0,0,4.1,4.1,25) 
HCC0 = CS_Rotate(HCCC,180)
HCC = CS_RemoveStack(HCC0,15,0) -------하트
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*32))//0x1D),AtLeast)},{"Norad II (Battlecruiser)",84},HCC,{P8,P6},GunTrigGLoc,1,{SizeTable = 50,LMTable="MAX",Order={Attack,"CD205"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*33))//0x1D),AtLeast)},{"Norad II (Battlecruiser)",84},HCC,{P8,P6},GunTrigGLoc,1,{SizeTable = 100,LMTable="MAX",Order={Attack,"CD205"}})
G_CB_TSetSpawn({CD(GunTrigGCcode,((16000+(362*34))//0x1D),AtLeast)},{"Norad II (Battlecruiser)",84},HCC,{P8,P6},GunTrigGLoc,1,{SizeTable = 150,LMTable="MAX",Order={Attack,"CD205"}})

CIfEnd()


CD63 = CIf_GunTrig(P8, "Xel'Naga Temple", "CD63",20000//0x1D,13);

CD63ShT = {}
for i = 1, 6 do
	CD63ShT[i] = CSMakeStar(4, 180, 64, 0, PlotSizeCalc(4*2, i),PlotSizeCalc(4*2, i-1))
	G_CB_TScanEff({CD(GunTrigGCcode,((0+(150*(i-1)))//0x1D),AtLeast)}, {CD63ShT[i]}, GunTrigGLoc, 4,1,{LMTable="MAX"})

end
CD63Sh_2 = CSMakeStar(4, 180, 64, 0, PlotSizeCalc(4*2, 6),0)
G_CB_TScanEff({CD(GunTrigGCcode,((0+(150*(7-1)))//0x1D),AtLeast)}, {CD63Sh_2}, GunTrigGLoc, 918,1,{LMTable="MAX"})
CD63Sh_3_1 = CSMakePolygon(4, 48, 0, PlotSizeCalc(4, 6), PlotSizeCalc(4, 5))
CD63Sh_3_2 = CSMakePolygon(5, 48, 0, PlotSizeCalc(5, 6), PlotSizeCalc(5, 5))
CD63Sh_3_3 = CSMakePolygon(6, 48, 0, PlotSizeCalc(6, 6), PlotSizeCalc(6, 5))
CD63Sh_3_4 = CSMakePolygon(7, 48, 0, PlotSizeCalc(7, 6), PlotSizeCalc(7, 5))
CD63Sh_4_1 = CSMakePolygon(4, 48, 0, PlotSizeCalc(4, 6-3), PlotSizeCalc(4, 5-3))
CD63Sh_4_2 = CSMakePolygon(5, 48, 0, PlotSizeCalc(5, 6-3), PlotSizeCalc(5, 5-3))
CD63Sh_4_3 = CSMakePolygon(6, 48, 0, PlotSizeCalc(6, 6-3), PlotSizeCalc(6, 5-3))
CD63Sh_4_4 = CSMakePolygon(7, 48, 0, PlotSizeCalc(7, 6-3), PlotSizeCalc(7, 5-3))
CD63LT = {
	"CD18","CD19","CD17","CD54"
}
for i = 0, 3 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,(1420+(950*i))//0x1D,AtLeast)},{84,"Kukulza (Mutalisk)"},CD63Sh_3_1,{P6,P8},GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(5230+(950*i))//0x1D,AtLeast)},{84,"Kukulza (Guardian)"},CD63Sh_3_2,{P6,P8},GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(9040+(950*i))//0x1D,AtLeast)},{84,"Kukulza (Mutalisk)"},CD63Sh_3_3,{P6,P8},GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(12850+(950*i))//0x1D,AtLeast)},{84,"Kukulza (Guardian)"},CD63Sh_3_4,{P6,P8},GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(1900+(950*i))//0x1D,AtLeast)},{84,"Hyperion (Battlecruiser)"},CD63Sh_4_1,{P6,P8},CD63LT[i+1],1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(5710+(950*i))//0x1D,AtLeast)},{84,"Danimoth (Arbiter)"},CD63Sh_4_2,{P6,P8},CD63LT[i+1],1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(9520+(950*i))//0x1D,AtLeast)},{84,"Gantrithor (Carrier)"},CD63Sh_4_3,{P6,P8},CD63LT[i+1],1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(13330+(950*i))//0x1D,AtLeast)},{84,"Edmund Duke (Siege Mode)"},CD63Sh_4_4,{P6,P8},CD63LT[i+1],1,{LMTable="MAX"})
	
end
CIfEnd()

CD76 = CIf_GunTrig(P8, "Zerg Cerebrate", "CD76",35000//0x1D,14);

function Cos_FuncY(X) return math.sin(X) end
WaveShapeA = CSMakeGraphX({8,8},"Cos_FuncY",0,0,1,nil,15) -- y= math.cos(x)
CD76_Sh = CS_RatioXY(CS_MoveXY(WaveShapeA, -47, 0), 3, 3)
--845
G_CB_TScanEff({CD(GunTrigGCcode,((420+(845*(1-1)))//0x1D),AtLeast)}, {CD76_Sh}, GunTrigGLoc, 58,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,((420+(845*(2-1)))//0x1D),AtLeast)}, {CD76_Sh}, GunTrigGLoc, 60,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,((420+(845*(3-1)))//0x1D),AtLeast)}, {CD76_Sh}, GunTrigGLoc, 332,1,{LMTable="MAX"})
G_CB_TScanEff({CD(GunTrigGCcode,((420+(845*(4-1)))//0x1D),AtLeast)}, {CD76_Sh}, GunTrigGLoc, 318,1,{LMTable="MAX"})

for i = 0, 3 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,(3800+(845*i))//0x1D,AtLeast)},{"Hunter Killer (Hydralisk)","Kukulza (Mutalisk)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(7180+(845*i))//0x1D,AtLeast)},{"Torrasque (Ultralisk)","Kukulza (Guardian)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(10560+(845*i))//0x1D,AtLeast)},{"Hunter Killer (Hydralisk)","Kukulza (Mutalisk)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(13940+(845*i))//0x1D,AtLeast)},{"Torrasque (Ultralisk)","Kukulza (Guardian)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(17320+(845*i))//0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(20700+(845*i))//0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(24080+(845*i))//0x1D,AtLeast)},{"Hyperion (Battlecruiser)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,(27460+(845*i))//0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},CD76_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
end


CIfEnd()

ICDC = CIf_GunTrig(P8, "Ion Cannon", "ICD",(55380+5000)//0x1D,15);
ICDC_Sh1 = CSMakeCircle(99, 1024, 0, 100, 1)
ICDC_Sh2 = CSMakeCircle(49, 1024+512, 0, 50, 1)
G_CB_TScanEff({CD(GunTrigGCcode,0,AtLeast)}, {ICDC_Sh1}, "HZ", 391,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,1840//0x1D,AtLeast)},{"Kukulza (Guardian)"},ICDC_Sh1,P8,"HZ",1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,1840//0x1D,AtLeast)},{"Norad II (Battlecruiser)"},ICDC_Sh2,P8,"HZ",1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,9230//0x1D,AtLeast)},{"Kukulza (Guardian)"},ICDC_Sh1,P8,"HZ",1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,9230//0x1D,AtLeast)},{"Norad II (Battlecruiser)"},ICDC_Sh2,P8,"HZ",1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(GunTrigGCcode,18460//0x1D,AtLeast)},{"Kukulza (Guardian)"},ICDC_Sh1,P8,"HZ",1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,18460//0x1D,AtLeast)},{"Norad II (Battlecruiser)"},ICDC_Sh2,P8,"HZ",1,{LMTable="MAX"})
for i = 0,15 do
	G_CB_TScanEff({CD(GunTrigGCcode,(24000//0x1D)+i,AtLeast)}, {CD218Sh_2}, "HZ", 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},10)
	G_CB_TSetSpawn({CD(GunTrigGCcode,25840//0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},CD218Sh_2,P8,"HZ",1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)})
	G_CB_TScanEff({CD(GunTrigGCcode,(31380//0x1D)+i,AtLeast)}, {CD218Sh_2}, "HZ", 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},15)
	G_CB_TSetSpawn({CD(GunTrigGCcode,33230//0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},CD218Sh_2,P8,"HZ",1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)})
	G_CB_TScanEff({CD(GunTrigGCcode,(38760//0x1D)+i,AtLeast)}, {CD218Sh_2}, "HZ", 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},0)
	G_CB_TSetSpawn({CD(GunTrigGCcode,40610//0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},CD218Sh_2,P8,"HZ",1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)})
	G_CB_TScanEff({CD(GunTrigGCcode,(46150//0x1D)+i,AtLeast)}, {CD218Sh_2}, "HZ", 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},13)
	G_CB_TSetSpawn({CD(GunTrigGCcode,48000//0x1D,AtLeast)},{"Edmund Duke (Siege Mode)"},CD218Sh_2,P8,"HZ",1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)})
	G_CB_TScanEff({CD(GunTrigGCcode,(51690//0x1D)+i,AtLeast)}, {CD218Sh_2}, "HZ", 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},16)
	G_CB_TScanEff({CD(GunTrigGCcode,(52610//0x1D)+i,AtLeast)}, {CD218Sh_2}, "HZ", 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},16)
	G_CB_TScanEff({CD(GunTrigGCcode,(53530//0x1D)+i,AtLeast)}, {CD218Sh_2}, "HZ", 391,1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)},17)
	G_CB_TSetSpawn({CD(GunTrigGCcode,55380//0x1D,AtLeast)},{30},CD218Sh_2,P8,"HZ",1,{LMTable="MAX",RotateTable = i*16,SizeTable=100-(i*6)})
end
TriggerX(FP,{CD(GunTrigGCcode,0,AtLeast)},{RotatePlayer({RunAIScript("Turn ON Shared Vision for Player 8");}, Force1, FP)})
TriggerX(FP,{CD(GunTrigGCcode,25840//0x1D,AtLeast)},{RotatePlayer({RunAIScript("Turn OFF Shared Vision for Player 8");}, Force1, FP)})



CIfEnd()
CD48 = CIf_GunTrig(P8, "Zerg Overmind (With Shell)", "CD48",90000//0x1D,16);

CD48Sh_1 = CS_FillPathXY({4   ,{1056, 928},{608, 1184},{192, 928},{608, 704}}, 1, 64, 32, 0)
CD48Sh_2 = CS_FillPathXY({4   ,{1056, 928},{608, 1184},{192, 928},{608, 704}}, 1, 96, 64, 0)


CIfEnd()
--[[

Trigger { -- ZO(WS)D
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Terran Covert Ops");
		Comment("ZO(WS)D");
	},
}


Trigger { -- ZO(WS)D1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD29");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Terran Physics Lab");
		Comment("ZO(WS)D1");
	},
}


Trigger { -- ZO(WS)D1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Terran Command Center");
		Comment("ZO(WS)D1");
	},
}


Trigger { -- ZO(WS)D1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Terran Missile Turret");
		Comment("ZO(WS)D1");
	},
}


Trigger { -- ZO(WS)D1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Terran Comsat Station");
		Comment("ZO(WS)D1");
	},
}


Trigger { -- ZO(WS)D1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Terran Engineering Bay");
		Comment("ZO(WS)D1");
	},
}


Trigger { -- ZO(WS)D1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Zerg Hydralisk Den");
		Comment("ZO(WS)D1");
	},
}


Trigger { -- ZO(WS)D1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Zerg Queen's Nest");
		Comment("ZO(WS)D1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Stasis Cell/Prison", "CD28");
		Deaths(P6, AtLeast, 90, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(16, "Terran Dropship", "CD28", P8);
		CreateUnit(16, "Terran Dropship", "CD29", P8);
		CreateUnit(16, "Terran Dropship", "CD48", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Stasis Cell/Prison", "CD28");
		Deaths(P6, AtLeast, 240, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(16, "Terran Dropship", "CD28", P8);
		CreateUnit(16, "Terran Dropship", "CD29", P8);
		CreateUnit(16, "Terran Dropship", "CD48", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Stasis Cell/Prison", "CD28");
		Deaths(P6, AtLeast, 390, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(16, "Terran Dropship", "CD28", P8);
		CreateUnit(16, "Terran Dropship", "CD29", P8);
		CreateUnit(16, "Terran Dropship", "CD48", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Stasis Cell/Prison", "CD28");
		Deaths(P6, AtLeast, 590, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(16, "Terran Dropship", "CD28", P8);
		CreateUnit(16, "Terran Dropship", "CD29", P8);
		CreateUnit(16, "Terran Dropship", "CD48", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Stasis Cell/Prison", "CD28");
		Deaths(P6, AtLeast, 790, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(16, "Terran Dropship", "CD28", P8);
		CreateUnit(16, "Terran Dropship", "CD29", P8);
		CreateUnit(16, "Terran Dropship", "CD48", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Stasis Cell/Prison", "CD28");
		Deaths(P6, AtLeast, 940, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(16, "Terran Dropship", "CD28", P8);
		CreateUnit(16, "Terran Dropship", "CD29", P8);
		CreateUnit(16, "Terran Dropship", "CD48", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger { -- ZO(WS)
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 100, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(24, "Fenix (Zealot)", "CD28", P8);
		CreateUnit(24, "Fenix (Dragoon)", "CD28", P8);
		CreateUnit(12, "Mojo (Scout)", "CD28", P8);
		CreateUnit(10, "Gantrithor (Carrier)", "CD28", P8);
		Order("Fenix (Zealot)", P8, "CD28", Patrol, "CD29");
		Order("Fenix (Dragoon)", P8, "CD28", Patrol, "CD29");
		Order("Mojo (Scout)", P8, "CD28", Attack, "CD29");
		Order("Gantrithor (Carrier)", P8, "CD28", Attack, "CD29");
		Comment("ZO(WS)");
	},
}


Trigger { -- ZO(WS)
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 250, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(16, "Edmund Duke (Siege Mode)", "CD28", P8);
		CreateUnit(12, "Alan Schezar (Goliath)", "CD28", P8);
		CreateUnit(14, "Tom Kazansky (Wraith)", "CD28", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD28", P8);
		Order("Alan Schezar (Goliath)", P8, "CD28", Patrol, "CD29");
		Order("Tom Kazansky (Wraith)", P8, "CD28", Attack, "CD29");
		Order("Danimoth (Arbiter)", P8, "CD28", Attack, "CD29");
		Comment("ZO(WS)");
	},
}


Trigger { -- ZO(WS)
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 400, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(20, "Tassadar/Zeratul (Archon)", "CD28", P8);
		CreateUnit(14, "Gui Montag (Firebat)", "CD28", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD28", P8);
		Order("Tassadar/Zeratul (Archon)", P8, "CD28", Patrol, "CD29");
		Order("Gui Montag (Firebat)", P8, "CD28", Patrol, "CD29");
		Order("Hyperion (Battlecruiser)", P8, "CD28", Attack, "CD29");
		Comment("ZO(WS)");
	},
}


Trigger { -- ZO(WS)
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 600, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(20, "Zeratul (Dark Templar)", "CD28", P8);
		CreateUnit(14, "Edmund Duke (Siege Tank)", "CD28", P8);
		CreateUnit(20, "Tom Kazansky (Wraith)", "CD28", P8);
		Order("Zeratul (Dark Templar)", P8, "CD28", Patrol, "CD29");
		Order("Tom Kazansky (Wraith)", P8, "CD28", Attack, "CD29");
		Comment("ZO(WS)");
	},
}


Trigger { -- ZO(WS)
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 800, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(40, "Edmund Duke (Siege Mode)", "CD28", P8);
		Comment("ZO(WS)");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 950, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(15, "Zerg Broodling", "CD28", P8);
		CreateUnit(6, "Danimoth (Arbiter)", "CD28", P8);
		CreateUnit(4, "Norad II (Battlecruiser)", "CD28", P8);
		Order("Zerg Broodling", P8, "CD28", Attack, "CD29");
		Order("Danimoth (Arbiter)", P8, "CD28", Attack, "CD29");
		Order("Norad II (Battlecruiser)", P8, "CD28", Attack, "CD29");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 1100, "Terran Covert Ops");
	},
	actions = {
		CreateUnit(3, "Infested Kerrigan (Infested Terran)", "CD28", P8);
		CreateUnit(3, "Infested Kerrigan (Infested Terran)", "CD28", P8);
		CreateUnit(10, "Gantrithor (Carrier)", "CD28", P8);
		Order("Gantrithor (Carrier)", P8, "CD28", Attack, "CD29");
		Order("Infested Kerrigan (Infested Terran)", P8, "CD28", Attack, "CD29");
		Order("Infested Kerrigan (Infested Terran)", P8, "CD28", Attack, "CD29");
	},
}


Trigger { -- ZO(WS)1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD29");
		Deaths(P6, AtLeast, 100, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(24, "Fenix (Zealot)", "CD29", P8);
		CreateUnit(24, "Fenix (Dragoon)", "CD29", P8);
		CreateUnit(12, "Mojo (Scout)", "CD29", P8);
		CreateUnit(10, "Gantrithor (Carrier)", "CD29", P8);
		CreateUnit(24, "Fenix (Zealot)", "CD48", P8);
		CreateUnit(24, "Fenix (Dragoon)", "CD48", P8);
		CreateUnit(12, "Mojo (Scout)", "CD48", P8);
		CreateUnit(10, "Gantrithor (Carrier)", "CD48", P8);
		Order("Fenix (Zealot)", P8, "CD29", Patrol, "CD28");
		Order("Fenix (Dragoon)", P8, "CD29", Patrol, "CD28");
		Order("Mojo (Scout)", P8, "CD29", Attack, "CD28");
		Order("Gantrithor (Carrier)", P8, "CD29", Attack, "CD28");
		Comment("ZO(WS)1");
	},
}


Trigger { -- ZO(WS)1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD29");
		Deaths(P6, AtLeast, 250, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(16, "Edmund Duke (Siege Mode)", "CD29", P8);
		CreateUnit(12, "Alan Schezar (Goliath)", "CD29", P8);
		CreateUnit(14, "Tom Kazansky (Wraith)", "CD29", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD29", P8);
		CreateUnit(16, "Edmund Duke (Siege Mode)", "CD48", P8);
		CreateUnit(12, "Alan Schezar (Goliath)", "CD48", P8);
		CreateUnit(14, "Tom Kazansky (Wraith)", "CD48", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD48", P8);
		Order("Alan Schezar (Goliath)", P8, "CD29", Patrol, "CD28");
		Order("Tom Kazansky (Wraith)", P8, "CD29", Attack, "CD28");
		Order("Rhynadon (Badlands)", P8, "CD29", Attack, "CD28");
		Comment("ZO(WS)1");
	},
}


Trigger { -- ZO(WS)1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD29");
		Deaths(P6, AtLeast, 400, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(20, "Tassadar/Zeratul (Archon)", "CD29", P8);
		CreateUnit(14, "Gui Montag (Firebat)", "CD29", P8);
		CreateUnit(13, "Hyperion (Battlecruiser)", "CD29", P8);
		CreateUnit(20, "Tassadar/Zeratul (Archon)", "CD48", P8);
		CreateUnit(14, "Gui Montag (Firebat)", "CD48", P8);
		CreateUnit(13, "Hyperion (Battlecruiser)", "CD48", P8);
		Order("Tassadar/Zeratul (Archon)", P8, "CD29", Patrol, "CD28");
		Order("Gui Montag (Firebat)", P8, "CD29", Patrol, "CD28");
		Order("Hyperion (Battlecruiser)", P8, "CD29", Attack, "CD28");
		Comment("ZO(WS)1");
	},
}


Trigger { -- ZO(WS)1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD29");
		Deaths(P6, AtLeast, 600, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(20, "Zeratul (Dark Templar)", "CD29", P8);
		CreateUnit(14, "Edmund Duke (Siege Tank)", "CD29", P8);
		CreateUnit(20, "Tom Kazansky (Wraith)", "CD29", P8);
		CreateUnit(20, "Zeratul (Dark Templar)", "CD48", P8);
		CreateUnit(14, "Edmund Duke (Siege Tank)", "CD48", P8);
		CreateUnit(20, "Tom Kazansky (Wraith)", "CD48", P8);
		Order("Zeratul (Dark Templar)", P8, "CD29", Patrol, "CD28");
		Order("Edmund Duke (Siege Tank)", P8, "CD29", Patrol, "CD28");
		Order("Tom Kazansky (Wraith)", P8, "CD29", Attack, "CD28");
		Comment("ZO(WS)1");
	},
}


Trigger { -- ZO(WS)1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD29");
		Deaths(P6, AtLeast, 800, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(40, "Edmund Duke (Siege Mode)", "CD29", P8);
		CreateUnit(40, "Edmund Duke (Siege Mode)", "CD48", P8);
		Comment("ZO(WS)1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 950, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(15, "Zerg Broodling", "CD29", P8);
		CreateUnit(6, "Danimoth (Arbiter)", "CD29", P8);
		CreateUnit(4, "Norad II (Battlecruiser)", "CD29", P8);
		CreateUnit(15, "Zerg Broodling", "CD48", P8);
		CreateUnit(6, "Danimoth (Arbiter)", "CD48", P8);
		CreateUnit(4, "Norad II (Battlecruiser)", "CD48", P8);
		Order("Zerg Broodling", P8, "CD29", Attack, "CD28");
		Order("Danimoth (Arbiter)", P8, "CD29", Attack, "CD28");
		Order("Norad II (Battlecruiser)", P8, "CD29", Attack, "CD28");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD28");
		Deaths(P6, AtLeast, 1100, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(3, "Infested Kerrigan (Infested Terran)", "CD29", P8);
		CreateUnit(3, "Infested Kerrigan (Infested Terran)", "CD29", P8);
		CreateUnit(10, "Gantrithor (Carrier)", "CD29", P8);
		CreateUnit(3, "Infested Kerrigan (Infested Terran)", "CD48", P8);
		CreateUnit(3, "Infested Kerrigan (Infested Terran)", "CD48", P8);
		CreateUnit(10, "Gantrithor (Carrier)", "CD48", P8);
		Order("Gantrithor (Carrier)", P8, "CD29", Attack, "CD28");
		Order("Infested Kerrigan (Infested Terran)", P8, "CD29", Attack, "CD28");
		Order("Infested Kerrigan (Infested Terran)", P8, "CD29", Attack, "CD28");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 70, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 80, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 90, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 100, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 110, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 120, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 130, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 140, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 150, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 160, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 170, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 180, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 190, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 200, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 210, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 220, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 230, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 240, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 250, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 260, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 270, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 280, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 290, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 300, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 310, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 320, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 330, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 340, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 350, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 360, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 370, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 380, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 390, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 400, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 410, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 420, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 430, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 440, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 450, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 460, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 470, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 480, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 490, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 500, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 510, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 520, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 530, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 540, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 550, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 560, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 570, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 580, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 590, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 600, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 610, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 620, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 630, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 640, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 650, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 660, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 670, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 680, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 690, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 700, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 710, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 720, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 730, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 740, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 750, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 760, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 770, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 780, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 790, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 800, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 810, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 820, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 830, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 840, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 850, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 860, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 870, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 880, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 890, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 900, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 910, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 920, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 930, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 940, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 950, "Terran Physics Lab");
	},
	actions = {
		CreateUnit(1, "Protoss Observer", "CD43", P8);
		CreateUnit(1, "Protoss Observer", "CD44", P8);
		CreateUnit(1, "Protoss Observer", "CD45", P8);
		CreateUnit(1, "Protoss Observer", "CD46", P8);
		CreateUnit(1, "Protoss Observer", "CD47", P8);
		KillUnit("Protoss Observer", P8);
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 85, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 130, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 180, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 230, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 280, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 330, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 380, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 430, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 480, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 530, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 580, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 630, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 680, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 730, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 780, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 830, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 880, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 930, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 980, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1030, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1080, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1130, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1180, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1230, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1280, "Terran Command Center");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD43", P8);
		Order("Mojo (Scout)", P8, "CD43", Patrol, "CD48");
		Comment("ZO(WS)2");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 95, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 140, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 190, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 240, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 290, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 340, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 390, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 440, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 490, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 540, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 590, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 640, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 690, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 740, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 790, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 840, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 890, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 940, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 990, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1040, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1090, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1140, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1190, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1240, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1290, "Terran Missile Turret");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD44", P8);
		Order("Mojo (Scout)", P8, "CD44", Patrol, "CD48");
		Comment("ZO(WS)3");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 105, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 150, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 200, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 250, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 300, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 350, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 400, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 450, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 500, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 550, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 600, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 650, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 700, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 750, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 800, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 850, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 900, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 950, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1000, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1050, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1100, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1150, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1200, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1250, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)4
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1300, "Terran Comsat Station");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD45", P8);
		Order("Mojo (Scout)", P8, "CD45", Patrol, "CD48");
		Comment("ZO(WS)4");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 115, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 160, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 210, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 260, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 310, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 360, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 410, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 460, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 510, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 560, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 610, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 660, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 710, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 760, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 810, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 860, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 910, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 960, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1010, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1060, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1110, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1160, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1210, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)5
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1260, "Terran Engineering Bay");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD46", P8);
		Order("Mojo (Scout)", P8, "CD46", Patrol, "CD48");
		Comment("ZO(WS)5");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 125, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 170, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 220, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 270, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 320, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 370, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 420, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 470, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 520, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 570, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 620, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 670, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 720, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 770, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 820, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 870, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 920, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 970, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1020, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1070, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1120, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1170, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1220, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}


Trigger { -- ZO(WS)6
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Overmind (With Shell)", "CD48");
		Deaths(P6, AtLeast, 1270, "Zerg Hydralisk Den");
	},
	actions = {
		CreateUnit(4, "Mojo (Scout)", "CD47", P8);
		Order("Mojo (Scout)", P8, "CD47", Patrol, "CD48");
		Comment("ZO(WS)6");
	},
}

]]


DoActions(FP,{KillUnit("Zerg Devourer", Force2),KillUnit("Zerg Devourer", P6),KillUnit(84, Force2),KillUnit(84, P6)})









function GunPoint(Player,GunID,Text,Point)
	TriggerX(FP,{Deaths(Player, AtLeast, 1, GunID);},{
		RotatePlayer({DisplayTextX(Text, 4)}, HumanPlayers, FP),SetScore(Force1, Add, Point, Kills),SetDeaths(Player,Subtract,1,GunID)},{preserved})
end

function HPoint(UnitID,Text,Point)
	TriggerX(FP,{Deaths(P7, AtLeast, 1, UnitID);},{
		RotatePlayer({DisplayTextX(Text, 4);PlayWAVX("staredit\\wav\\cut.ogg");PlayWAVX("staredit\\wav\\cut.ogg");}, HumanPlayers, FP);
		SetScore(Force1, Add, Point, Kills);
		SetDeaths(P7, Subtract, 1, UnitID)
	},{preserved})
end



GunPoint(P8,"Zerg Hatchery","\x13\x04 Hatchery \x0720000 \x04Point",20000)
GunPoint(P7, "Zerg Hatchery", "\x13\x04 Hatchery \x0720000 \x04Point", 20000)
GunPoint(P8, "Infested Command Center", "\x13\x04 Infested Command Center \x07100000 \x04Point", 100000)
GunPoint(P8, "Zerg Overmind (With Shell)", "\x13\x04 Zerg Overmind(With Shell) \x0780000 \x04Point", 80000)
GunPoint(P8, "Protoss Temple", "\x13\x04 Protoss Temple \x07200000 \x04Point", 200000)
GunPoint(P8, "Protoss Nexus", "\x13\x04 Protoss Nexus \x07150000 \x04Point", 150000)
GunPoint(P8, "Zerg Lair", "\x13\x04 Zerg Lair \x0730000 \x04Point", 30000)
GunPoint(P7, "Zerg Lair", "\x13\x04 Zerg Lair \x0730000 \x04Point", 30000)
GunPoint(P7, "Power Generator", "\x13\x04 Power Generator \x07100000 \x04Point", 100000)
GunPoint(P7, "Zerg Hive", "\x13\x04 Zerg Hive \x0750000 \x04Point", 50000)
GunPoint(P8, "Zerg Hive", "\x13\x04 Zerg Hive \x0750000 \x04Point", 50000)
GunPoint(P8, "Stasis Cell/Prison", "\x13\x04 Stasis Cell/Prison \x0770000 \x04Point", 70000)
GunPoint(P8, "Zerg Overmind", "\x13\x04 Zerg Overmind \x0760000 \x04Point", 60000)
GunPoint(P8, "Psi Disrupter", "\x13\x04 Psi Disrupter \x0780000 \x04Point", 80000)
GunPoint(P8, "Terran Armory", "\x13\x04 Terran Armory \x0760000 \x04Point", 60000)
GunPoint(P8, "Terran Engineering Bay", "\x13\x04 Terran Engineering Bay \x0750000 \x04Point", 50000)
GunPoint(P8, "Terran Command Center", "\x13\x04 Terran Command Center \x0740000 \x04Point", 40000)
GunPoint(P7, "Norad II (Crashed Battlecruiser)", "\x13\x04 Norad II \x0720000 \x04Point", 20000)
GunPoint(P7, "Ion Cannon", "\x13\x04 Ion Cannon \x0770000 \x04Point", 70000)
GunPoint(P8, "Zerg Cerebrate Daggoth", "\x13\x04 Zerg Cerebrate Daggoth \x0730000 \x04Point", 30000)
GunPoint(P8, "Warp Gate", "\x13\x04 Warp Gate \x07100000 \x04Point", 100000)
GunPoint(P8, "Protoss Stargate", "\x13\x04 Protoss Stargate \x07100000 \x04Point", 100000)
GunPoint(P7, "Terran Supply Depot", "\x13\x04 Terran Supply Depot \x0710000 \x04Point", 10000)
GunPoint(P8, "Norad II (Crashed Battlecruiser)", "\x13\x04 Norad II \x07100000 \x04Point", 100000)
GunPoint(P8, "Xel'Naga Temple", "\x13\x04 Xel'Naga Temple \x07150000 \x04Point", 150000)
GunPoint(P8, "Power Generator", "\x13\x04 Power Generator \x0780000 \x04Point", 80000)
GunPoint(P8, "Ion Cannon", "\x13\x04 Ion Cannon \x0770000 \x04Point", 70000)
GunPoint(P8, "Zerg Cerebrate", "\x13\x04 Zerg Cerebrate \x0740000 \x04Point", 40000)
GunPoint(P8, "Terran Factory", "\x13\x04 Terran Factory \x0740000 \x04Point", 40000)
GunPoint(P8, "Terran Barracks", "\x13\x04 Terran Barracks \x0740000 \x04Point", 40000)
GunPoint(P7, "Infested Command Center", "\x13\x04 Infested Command Center \x0770000 \x04Point", 70000)
HPoint("Gui Montag (Firebat)", "\x13\x1F Gui Montag \x0750000 \x04Point", 50000)
HPoint("Sarah Kerrigan (Ghost)", "\x13\x1F Sarah Kerrigan \x0730000 \x04Point", 30000)
HPoint("Alan Schezar (Goliath)", "\x13\x1F Alan Schezar \x0735000 \x04Point", 35000)
HPoint("Jim Raynor (Vulture)", "\x13\x1F Jim Raynor \x0740000 \x04Point", 40000)
HPoint("Tom Kazansky (Wraith)", "\x13\x1F Tom Kazansky \x0750000 \x04Point", 50000)
HPoint("Edmund Duke (Siege Tank)", "\x13\x1F Edmund Duke \x0740000 \x04Point", 40000)
HPoint("Edmund Duke (Siege Mode)", "\x13\x1F Edmund Duke \x0730000 \x04Point", 30000)
HPoint("Hyperion (Battlecruiser)", "\x13\x1F Hyperion \x0760000 \x04Point", 60000)
HPoint("Norad II (Battlecruiser)", "\x13\x1F Norad II \x07150000 \x04Point", 150000)
HPoint("Zeratul (Dark Templar)", "\x13\x1F Zeratul \x0745000 \x04Point", 45000)
HPoint("Tassadar (Templar)", "\x13\x1F Tassadar \x0750000 \x04Point", 50000)
HPoint("Tassadar/Zeratul (Archon)", "\x13\x1F Tassadar/Zeratul \x0765000 \x04Point", 65000)
HPoint("Fenix (Zealot)", "\x13\x1F Fenix \x0735000 \x04Point", 35000)
HPoint("Fenix (Dragoon)", "\x13\x1F Fenix \x0740000 \x04Point", 40000)
HPoint("Mojo (Scout)", "\x13\x1F Mojo \x0760000 \x04Point", 60000)
HPoint("Warbringer (Reaver)", "\x13\x1F Warbringer \x0750000 \x04Point", 50000)
HPoint("Gantrithor (Carrier)", "\x13\x1F Gantrithor \x0790000 \x04Point", 90000)
HPoint("Danimoth (Arbiter)", "\x13\x1F Danimoth \x0770000 \x04Point", 70000)


end
