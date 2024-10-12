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



--CreateUnit(24, "Zeratul (Dark Templar)", "CD27", P8);
--CreateUnit(12, "Gui Montag (Firebat)", "CD27", P8);
--CreateUnit(20, "Mojo (Scout)", "CD27", P8);--

--CreateUnit(18, "Edmund Duke (Siege Mode)", "CD27", P8);
--CreateUnit(10, "Danimoth (Arbiter)", "CD27", P8);
--CreateUnit(12, "Mojo (Scout)", "CD27", P8);--

--CreateUnit(24, "Alan Schezar (Goliath)", "CD27", P8);
--CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD27", P8);
--CreateUnit(12, "Kukulza (Mutalisk)", "CD27", P8);--

--CreateUnit(24, "Edmund Duke (Siege Mode)", "CD27", P8);
--CreateUnit(12, "Fenix (Dragoon)", "CD27", P8);
--CreateUnit(2, "Norad II (Battlecruiser)", "CD27", P8);
--CreateUnit(12, "Hyperion (Battlecruiser)", "CD27", P8);--

--CreateUnit(24, "Zeratul (Dark Templar)", "CD26", P8);
--CreateUnit(12, "Gui Montag (Firebat)", "CD26", P8);
--CreateUnit(20, "Mojo (Scout)", "CD26", P8);--

--CreateUnit(18, "Edmund Duke (Siege Mode)", "CD26", P8);
--CreateUnit(10, "Danimoth (Arbiter)", "CD26", P8);
--CreateUnit(12, "Mojo (Scout)", "CD26", P8);--

--CreateUnit(24, "Alan Schezar (Goliath)", "CD26", P8);
--CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD26", P8);
--CreateUnit(12, "Kukulza (Mutalisk)", "CD26", P8);--

--CreateUnit(24, "Edmund Duke (Siege Mode)", "CD26", P8);
--CreateUnit(12, "Fenix (Dragoon)", "CD26", P8);
--CreateUnit(2, "Norad II (Battlecruiser)", "CD26", P8);
--CreateUnit(12, "Hyperion (Battlecruiser)", "CD26", P8);


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

ICD2Star = CS_SortA(CSMakeStar(5,135,128,0,CS_Level("Star",5,13),CS_Level("Star",5,12)) , 0)
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


CD219 = CIf_GunTrig(P7, "Ion Cannon", "CD219",(21500//0x1D)+2,6);



CIfEnd()

--
--Trigger {
--	players = {P8},
--	conditions = {
--		Command(P8, Excatly, 0, "Mature Crysalis");
--	},
--	actions = {
--		--SetInvincibility(Disable, "Protoss Temple", P8, "Anywhere");
--		--Order("Any unit", P8, "Anywhere", Patrol, "CD231");
--	},
--}




DoActions(FP,{KillUnit("Zerg Devourer", Force2)})
--[[



Trigger { -- H2.4
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD50");
	},
	actions = {
		CreateUnit(18, "Alan Schezar (Goliath)", "CD50", P8);
		CreateUnit(14, "Kukulza (Guardian)", "CD50", P8);
		Order("Alan Schezar (Goliath)", P8, "CD50", Patrol, "HZ");
		Order("Kukulza (Guardian)", P8, "CD50", Patrol, "HZ");
		Comment("H2.4");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD50");
		Deaths(P6, AtLeast, 70, "Terran Siege Tank (Siege Mode)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD50", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.4
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD50");
		Deaths(P6, AtLeast, 80, "Terran Siege Tank (Siege Mode)");
	},
	actions = {
		CreateUnit(16, "Gui Montag (Firebat)", "CD50", P8);
		CreateUnit(20, "Tom Kazansky (Wraith)", "CD50", P8);
		Order("Gui Montag (Firebat)", P8, "CD50", Patrol, "HZ");
		Order("Tom Kazansky (Wraith)", P8, "CD50", Patrol, "HZ");
		Comment("H2.4");
	},
}


Trigger { -- H2.5
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD51");
	},
	actions = {
		CreateUnit(8, "Warbringer (Reaver)", "CD51", P8);
		CreateUnit(14, "Tom Kazansky (Wraith)", "CD51", P8);
		Order("Warbringer (Reaver)", P8, "CD51", Patrol, "HZ");
		Order("Tom Kazansky (Wraith)", P8, "CD51", Patrol, "HZ");
		Comment("H2.5");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD51");
		Deaths(P6, AtLeast, 70, "Infested Terran");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD51", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.5
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD51");
		Deaths(P6, AtLeast, 80, "Infested Terran");
	},
	actions = {
		CreateUnit(20, "Edmund Duke (Siege Mode)", "CD51", P8);
		Comment("H2.5");
	},
}




Trigger { -- H2.7
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD53");
	},
	actions = {
		CreateUnit(16, "Jim Raynor (Vulture)", "CD53", P8);
		CreateUnit(26, "Sarah Kerrigan (Ghost)", "CD53", P8);
		Order("Jim Raynor (Vulture)", P8, "CD53", Patrol, "HZ");
		Order("Sarah Kerrigan (Ghost)", P8, "CD53", Patrol, "HZ");
		Comment("H2.7");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hatchery", "CD53");
		Deaths(P6, AtLeast, 70, "Unused Terran Bldg type   2");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD53", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- H2.7
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hatchery", "CD53");
		Deaths(P6, AtLeast, 80, "Unused Terran Bldg type   2");
	},
	actions = {
		CreateUnit(16, "Edmund Duke (Siege Mode)", "CD53", P8);
		Comment("H2.7");
	},
}




Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 40, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 50, "Terran Academy");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD20", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD20", P8);
		CreateUnit(20, "Mojo (Scout)", "CD20", P8);
		Order("Zeratul (Dark Templar)", P8, "CD20", Patrol, "CD21");
		Order("Gui Montag (Firebat)", P8, "CD20", Patrol, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 140, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 150, "Terran Academy");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD20", P8);
		CreateUnit(12, "Mojo (Scout)", "CD20", P8);
		Order("Danimoth (Arbiter)", P8, "CD20", Attack, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 290, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 300, "Terran Academy");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD20", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD20", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD20", P8);
		Order("Alan Schezar (Goliath)", P8, "CD20", Patrol, "CD21");
		Order("Tassadar/Zeratul (Archon)", P8, "CD20", Patrol, "CD21");
		Order("Kukulza (Mutalisk)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 440, "Terran Academy");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 450, "Terran Academy");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD20", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD20", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD20", P8);
		Order("Norad II (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Order("Fenix (Dragoon)", P8, "CD20", Patrol, "CD21");
		Order("Hyperion (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Comment("HH");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 40, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 50, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(24, "Fenix (Zealot)", "CD21", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD21", P8);
		CreateUnit(20, "Mojo (Scout)", "CD21", P8);
		Order("Fenix (Zealot)", P8, "CD21", Patrol, "CD20");
		Order("Gui Montag (Firebat)", P8, "CD21", Patrol, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 140, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 150, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD21", P8);
		CreateUnit(12, "Mojo (Scout)", "CD21", P8);
		Order("Danimoth (Arbiter)", P8, "CD21", Attack, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 290, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 300, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD21", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD21", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD21", P8);
		Order("Alan Schezar (Goliath)", P8, "CD21", Patrol, "CD20");
		Order("Tassadar/Zeratul (Archon)", P8, "CD21", Patrol, "CD20");
		Order("Kukulza (Mutalisk)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 440, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 450, "Hunter Killer (Hydralisk)");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD21", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD21", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD21", P8);
		Order("Norad II (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Order("Fenix (Dragoon)", P8, "CD21", Patrol, "CD20");
		Order("Hyperion (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 40, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 50, "Terran Civilian");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD27", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD27", P8);
		CreateUnit(20, "Mojo (Scout)", "CD27", P8);
		Order("Zeratul (Dark Templar)", P8, "CD27", Patrol, "CD26");
		Order("Gui Montag (Firebat)", P8, "CD27", Patrol, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 140, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 150, "Terran Civilian");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD27", P8);
		CreateUnit(12, "Mojo (Scout)", "CD27", P8);
		Order("Danimoth (Arbiter)", P8, "CD27", Attack, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 290, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 300, "Terran Civilian");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD27", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD27", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD27", P8);
		Order("Alan Schezar (Goliath)", P8, "CD27", Patrol, "CD26");
		Order("Tassadar/Zeratul (Archon)", P8, "CD27", Patrol, "CD26");
		Order("Kukulza (Mutalisk)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 440, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH2
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 450, "Terran Civilian");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD27", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD27", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD27", P8);
		Order("Norad II (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Order("Fenix (Dragoon)", P8, "CD27", Patrol, "CD26");
		Order("Hyperion (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Comment("HH2");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 40, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 50, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(24, "Fenix (Zealot)", "CD26", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD26", P8);
		CreateUnit(20, "Mojo (Scout)", "CD26", P8);
		Order("Fenix (Zealot)", P8, "CD26", Patrol, "CD27");
		Order("Gui Montag (Firebat)", P8, "CD26", Patrol, "CD27");
		Order("Mojo (Scout)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 140, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 150, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD26", P8);
		CreateUnit(12, "Mojo (Scout)", "CD26", P8);
		Order("Danimoth (Arbiter)", P8, "CD26", Attack, "CD27");
		Order("Mojo (Scout)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 290, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 300, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD26", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD26", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD26", P8);
		Order("Alan Schezar (Goliath)", P8, "CD26", Patrol, "CD27");
		Order("Tassadar/Zeratul (Archon)", P8, "CD26", Patrol, "CD27");
		Order("Kukulza (Mutalisk)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 440, "Terran Civilian");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P7},
	conditions = {
		Bring(P7, Exactly, 0, "Zerg Hive", "CD27");
		Deaths(P6, AtLeast, 450, "Terran Valkyrie");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD26", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD26", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD26", P8);
		Order("Norad II (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Order("Fenix (Dragoon)", P8, "CD26", Patrol, "CD27");
		Order("Hyperion (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}



Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 40, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 50, "Terran Barracks");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD20", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD20", P8);
		CreateUnit(20, "Mojo (Scout)", "CD20", P8);
		Order("Zeratul (Dark Templar)", P8, "CD20", Patrol, "CD21");
		Order("Gui Montag (Firebat)", P8, "CD20", Patrol, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 140, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 150, "Terran Barracks");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD20", P8);
		CreateUnit(12, "Mojo (Scout)", "CD20", P8);
		Order("Danimoth (Arbiter)", P8, "CD20", Attack, "CD21");
		Order("Mojo (Scout)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 290, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 300, "Terran Barracks");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD20", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD20", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD20", P8);
		Order("Alan Schezar (Goliath)", P8, "CD20", Patrol, "CD21");
		Order("Tassadar/Zeratul (Archon)", P8, "CD20", Patrol, "CD21");
		Order("Kukulza (Mutalisk)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 440, "Terran Barracks");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD20");
		Deaths(P6, AtLeast, 450, "Terran Barracks");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD20", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD20", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD20", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD20", P8);
		Order("Norad II (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Order("Fenix (Dragoon)", P8, "CD20", Patrol, "CD21");
		Order("Hyperion (Battlecruiser)", P8, "CD20", Attack, "CD21");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 40, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 50, "Terran Starport");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD21", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD21", P8);
		CreateUnit(20, "Mojo (Scout)", "CD21", P8);
		Order("Zeratul (Dark Templar)", P8, "CD21", Patrol, "CD20");
		Order("Gui Montag (Firebat)", P8, "CD21", Patrol, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("8HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 140, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 150, "Terran Starport");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD21", P8);
		CreateUnit(12, "Mojo (Scout)", "CD21", P8);
		Order("Danimoth (Arbiter)", P8, "CD21", Attack, "CD20");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 290, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 300, "Terran Starport");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD21", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD21", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD21", P8);
		Order("Alan Schezar (Goliath)", P8, "CD21", Patrol, "CD20");
		Order("Tassadar/Zeratul (Archon)", P8, "CD21", Patrol, "CD20");
		Order("Kukulza (Mutalisk)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 440, "Terran Starport");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD20", P8);
		CreateUnit(16, "Zerg Devourer", "CD21", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH1
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD21");
		Deaths(P6, AtLeast, 450, "Terran Starport");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD21", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD21", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD21", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD21", P8);
		Order("Norad II (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Order("Fenix (Dragoon)", P8, "CD21", Patrol, "CD20");
		Order("Hyperion (Battlecruiser)", P8, "CD21", Attack, "CD20");
		Comment("HH1");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 40, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 50, "Terran Refinery");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD27", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD27", P8);
		CreateUnit(20, "Mojo (Scout)", "CD27", P8);
		Order("Zeratul (Dark Templar)", P8, "CD27", Patrol, "CD26");
		Order("Gui Montag (Firebat)", P8, "CD27", Patrol, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("8HH");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 140, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 150, "Terran Refinery");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD27", P8);
		CreateUnit(12, "Mojo (Scout)", "CD27", P8);
		Order("Danimoth (Arbiter)", P8, "CD27", Attack, "CD26");
		Order("Mojo (Scout)", P8, "CD27", Attack, "CD26");
		Comment("8HH2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 290, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 300, "Terran Refinery");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD27", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD27", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD27", P8);
		Order("Alan Schezar (Goliath)", P8, "CD27", Patrol, "CD26");
		Order("Tassadar/Zeratul (Archon)", P8, "CD27", Patrol, "CD26");
		Order("Kukulza (Mutalisk)", P8, "CD27", Attack, "CD26");
		Comment("8HH2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 440, "Terran Refinery");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH2
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 450, "Terran Refinery");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD27", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD27", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD27", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD27", P8);
		Order("Norad II (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Order("Fenix (Dragoon)", P8, "CD27", Patrol, "CD26");
		Order("Hyperion (Battlecruiser)", P8, "CD27", Attack, "CD26");
		Comment("8HH2");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 40, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- 8HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 50, "Terran Dropship");
	},
	actions = {
		CreateUnit(24, "Zeratul (Dark Templar)", "CD26", P8);
		CreateUnit(12, "Gui Montag (Firebat)", "CD26", P8);
		CreateUnit(20, "Mojo (Scout)", "CD26", P8);
		Order("Zeratul (Dark Templar)", P8, "CD26", Patrol, "CD27");
		Order("Gui Montag (Firebat)", P8, "CD26", Patrol, "CD27");
		Order("Mojo (Scout)", P8, "CD21", Attack, "CD20");
		Comment("8HH3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 140, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 150, "Terran Dropship");
	},
	actions = {
		CreateUnit(18, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(10, "Danimoth (Arbiter)", "CD26", P8);
		CreateUnit(12, "Mojo (Scout)", "CD26", P8);
		Order("Danimoth (Arbiter)", P8, "CD26", Attack, "CD27");
		Order("Mojo (Scout)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 290, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 300, "Terran Dropship");
	},
	actions = {
		CreateUnit(24, "Alan Schezar (Goliath)", "CD26", P8);
		CreateUnit(12, "Tassadar/Zeratul (Archon)", "CD26", P8);
		CreateUnit(12, "Kukulza (Mutalisk)", "CD26", P8);
		Order("Alan Schezar (Goliath)", P8, "CD26", Patrol, "CD27");
		Order("Tassadar/Zeratul (Archon)", P8, "CD26", Patrol, "CD27");
		Order("Kukulza (Mutalisk)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 440, "Terran Dropship");
	},
	actions = {
		CreateUnit(16, "Zerg Devourer", "CD26", P8);
		CreateUnit(16, "Zerg Devourer", "CD27", P8);
		KillUnit("Zerg Devourer", P8);
	},
}


Trigger { -- HH3
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Zerg Hive", "CD26");
		Deaths(P6, AtLeast, 450, "Terran Dropship");
	},
	actions = {
		CreateUnit(24, "Edmund Duke (Siege Mode)", "CD26", P8);
		CreateUnit(12, "Fenix (Dragoon)", "CD26", P8);
		CreateUnit(2, "Norad II (Battlecruiser)", "CD26", P8);
		CreateUnit(12, "Hyperion (Battlecruiser)", "CD26", P8);
		Order("Norad II (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Order("Fenix (Dragoon)", P8, "CD26", Patrol, "CD27");
		Order("Hyperion (Battlecruiser)", P8, "CD26", Attack, "CD27");
		Comment("HH3");
	},
}






Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		SetDeaths(P6, Add, 1, "Protoss Citadel of Adun");
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 10, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 20, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 30, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 40, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 50, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 60, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 70, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 80, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 90, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 100, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 110, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 120, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 130, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 140, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 150, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 160, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 170, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 180, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 190, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 200, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 210, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 220, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 230, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 240, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 250, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 260, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 270, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 280, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 290, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 300, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 310, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 320, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 330, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 340, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 350, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 360, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 370, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 380, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 390, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 400, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 410, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 420, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 430, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 440, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 450, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 460, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 470, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 480, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 490, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 500, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 510, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 520, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 530, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 540, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 550, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 560, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 570, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 580, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 590, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 600, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 610, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 620, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 630, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 640, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 650, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 660, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 670, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 680, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 690, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 700, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 710, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 720, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 730, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 740, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger {
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 750, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(1, "Terran Dropship", "CD84", P8);
		CreateUnit(1, "Terran Dropship", "CD142", P8);
		KillUnit("Terran Dropship", P8);
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 50, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 60, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 70, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 80, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 90, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 100, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 110, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 120, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 130, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 140, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 150, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 160, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 170, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 180, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 190, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 200, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 210, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 220, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 230, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 240, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 250, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 260, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 270, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 280, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 290, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 300, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 310, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 320, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 330, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 340, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 350, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 360, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 370, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 380, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 390, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 400, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 410, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 420, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 430, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 440, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 450, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 460, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 470, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 480, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 490, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 500, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 510, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 520, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 530, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 540, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 550, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 560, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 570, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 580, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 590, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 600, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 610, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 620, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 620, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 630, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 640, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 650, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 660, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 670, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 680, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 690, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 700, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 710, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 720, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 730, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 740, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 750, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 760, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD84", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 50, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 60, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 70, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 80, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 90, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 100, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 110, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 120, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 130, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 140, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 150, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 160, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 170, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 180, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 190, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 200, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 210, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 220, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 230, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 240, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 250, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 260, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 270, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 280, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 290, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 300, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 310, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 320, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 330, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 340, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 350, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 360, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 370, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 380, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 390, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 400, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 410, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 420, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 430, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 440, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 450, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 460, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 470, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 480, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 490, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 500, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 510, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 520, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 530, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 540, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 550, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 560, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 570, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 580, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 590, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 600, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 610, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 620, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 630, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 640, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 650, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 660, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 670, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 680, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(12, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 690, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 700, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 710, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 720, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 730, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 740, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 750, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- ICD
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
		Deaths(P6, AtLeast, 760, "Protoss Citadel of Adun");
	},
	actions = {
		CreateUnit(2, "Terran Wraith", "CD142", P8);
		Comment("ICD");
	},
}


Trigger { -- CD77
	players = {P8},
	conditions = {
		Deaths(P6, AtLeast, 1, "Protoss Citadel of Adun");
		Deaths(P6, AtMost, 850, "Protoss Citadel of Adun");
	},
	actions = {
		PreserveTrigger();
		SetInvincibility(Enable, "Terran Wraith", P8, "Anywhere");
		Comment("CD77");
	},
}


Trigger { -- CD77
	players = {P8},
	conditions = {
		Deaths(P6, AtLeast, 851, "Protoss Citadel of Adun");
	},
	actions = {
		PreserveTrigger();
		SetInvincibility(Disable, "Terran Wraith", P8, "Anywhere");
		Comment("CD77");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD84", Attack, "CD86");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD86", Attack, "CD88");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD88", Attack, "CD90");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD90", Attack, "CD92");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD92", Attack, "CD94");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD94", Attack, "CD96");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD96", Attack, "CD97");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD97", Attack, "CD99");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD99", Attack, "CD101");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD101", Attack, "CD103");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD103", Attack, "CD105");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD105", Attack, "CD106");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD106", Attack, "CD108");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD108", Attack, "CD110");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD110", Attack, "CD112");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD112", Attack, "CD114");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD114", Attack, "CD116");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD116", Attack, "CD118");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD118", Attack, "CD120");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD120", Attack, "CD122");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD122", Attack, "CD124");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD124", Attack, "CD125");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD125", Attack, "CD126");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD126", Attack, "CD127");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD127", Attack, "CD128");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD128", Attack, "CD129");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD129", Attack, "CD130");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD130", Attack, "CD131");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD131", Attack, "CD132");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD132", Attack, "CD133");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD133", Attack, "CD134");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD134", Attack, "CD135");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD135", Attack, "CD136");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD136", Attack, "CD137");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD137", Attack, "CD138");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD138", Attack, "CD139");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD139", Attack, "CD140");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD140", Attack, "CD142");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD142", Attack, "CD144");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD144", Attack, "CD145");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD145", Attack, "CD146");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD146", Attack, "CD147");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD147", Attack, "CD148");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD148", Attack, "CD149");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD149", Attack, "CD150");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD150", Attack, "CD151");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD151", Attack, "CD152");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD152", Attack, "CD153");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD153", Attack, "CD154");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD154", Attack, "CD155");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD155", Attack, "CD156");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD156", Attack, "CD157");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD157", Attack, "CD158");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD158", Attack, "CD159");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD159", Attack, "CD160");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD160", Attack, "CD161");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD161", Attack, "CD162");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD162", Attack, "CD163");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD163", Attack, "CD164");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD164", Attack, "CD165");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD165", Attack, "CD166");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD166", Attack, "CD169");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD169", Attack, "CD171");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD171", Attack, "CD173");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD173", Attack, "CD175");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD175", Attack, "CD177");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD177", Attack, "CD179");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD179", Attack, "CD181");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD181", Attack, "CD183");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD183", Attack, "CD185");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD185", Attack, "CD187");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD187", Attack, "CD188");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD188", Attack, "CD190");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD190", Attack, "CD192");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD192", Attack, "CD194");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD194", Attack, "CD196");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD196", Attack, "CD198");
		Comment("ICDMM");
	},
}


Trigger { -- ICDMM
	players = {P8},
	conditions = {
		Bring(P8, Exactly, 0, "Infested Command Center", "ICD");
	},
	actions = {
		PreserveTrigger();
		Order("Terran Wraith", P8, "CD198", Attack, "CD84");
		Comment("ICDMM");
	},
}



]]










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
