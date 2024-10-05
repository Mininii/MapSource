function GunTrig()

	BGMType = CreateVar(FP)
	Dt = IBGM_EPD(FP, {P1,P2,P3,P4,P5,P6,P7,P8,P9,P10,P11,P12}, BGMType, {
		{1,"staredit\\wav\\happy.ogg",19*1000},
		{2,"staredit\\wav\\yodelsong.ogg",157*1000},
		{3,"staredit\\wav\\_Hong.ogg",16*1000},
		{4,"staredit\\wav\\Lethal_Icecream.ogg",24*1000},
		{5,"staredit\\wav\\Bombyanggang.ogg",16*1000},
	})
	

	CDoActions(FP, {TSetDeathsX(Force1, Subtract, Dt, 12,0xFFFFFF)})
	if TestStart == 0 then
		DoActionsX(FP,{SetV(BGMType,2)},1)
	end
	function CIf_GunTrig(PlayerID,GunID,LocID,TimerMax,BGMTypes)
		local GunCcode = CreateCcode()
		GunTrigGLoc = LocID
		GunTrigGCcode = GunCcode
		TriggerX(FP, Bring(PlayerID, Exactly, 0, GunID, LocID), {SetCD(GunCcode,1),SetV(BGMType,BGMTypes)})--RotatePlayer({DisplayTextX("\x13GunID : "..GunID.."    LocID : "..LocID)}, HumanPlayers, FP)
		CIf(FP,{CD(GunCcode,1,AtLeast),CD(GunCcode,TimerMax,AtMost)},{AddCD(GunCcode,1)})
		return GunCcode
	end
--P7Guns
HacCD1 = CIf_GunTrig(P7, "Zerg Hatchery", "CD1",400,1);
	CD1Sh = CSMakeStar(4, 180, 64, 45, PlotSizeCalc(4*2, 2), 0)
	G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD1Sh,P8,GunTrigGLoc,1,{FNTable=2})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD1Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD1Sh,P8,GunTrigGLoc,1,{FNTable=2})
CIfEnd()
HacCD3 = CIf_GunTrig(P7, "Zerg Hatchery", "CD3",400,1);
	CD3Sh = CSMakeLine(2, 32, 90, 5, 0)
	for i = 0,4 do
		G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD3Sh,P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD3Sh,P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX",RepeatType="KiilUnit"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD3Sh,P8,GunTrigGLoc,1,{DistanceXY={0,(-32*2)+(32*i)},LMTable="MAX"})
	end
CIfEnd()
HacCD4 = CIf_GunTrig(P7, "Zerg Hatchery", "CD4",400,1);
	CD4Sh_1 = CSMakeCircle(12, 72, 0, 13, 1)
	CD4Sh_2 = CSMakeLine(4, 48, 0, 13, 0)
	G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_1,P8,GunTrigGLoc,1)
	G_CB_TSetSpawn({CD(GunTrigGCcode,70,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_2,P8,GunTrigGLoc,1)
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD4Sh_1,P8,GunTrigGLoc,1,{LMTable = "MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD4Sh_2,P8,GunTrigGLoc,1,{LMTable = "MAX"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_1,P8,GunTrigGLoc,1)
	G_CB_TSetSpawn({CD(GunTrigGCcode,270,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD4Sh_2,P8,GunTrigGLoc,1)
CIfEnd()
HacCD37 = CIf_GunTrig(P7, "Zerg Hatchery", "CD37",400,1);
	CD37Sh = CSMakeLine(2, 32, 0, 5, 0)
	for i = 0,4 do
		G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD37Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD37Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX",RepeatType="KiilUnit"})
		G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD37Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),0},LMTable="MAX"})
	end
CIfEnd()
HacCD38 = CIf_GunTrig(P7, "Zerg Hatchery", "CD38",400,1);
CD38Sh = CSMakeCircle(5, 96, 0, 6, 1)
RandRotV = f_CRandNum(360)
CMov(FP,G_CB_RotateV,RandRotV)
for i = 0,4 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD38Sh,P8,GunTrigGLoc,1,{DistanceXY={(32*2)-(32*i),(-32*2)+(32*i)},LMTable="MAX",RotateTable = "Main"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD38Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),(-32*2)+(32*i)},LMTable="MAX",RotateTable = "Main",RepeatType="KiilUnit"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*20),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD38Sh,P8,GunTrigGLoc,1,{DistanceXY={(-32*2)+(32*i),(-32*2)+(32*i)},LMTable="MAX",RotateTable = "Main"})

end
CIfEnd()
HacCD39 = CIf_GunTrig(P7, "Zerg Hatchery", "CD39",400,1);
CD39Sh = {28  ,{672, 1632},{704, 1632},{736, 1632},{768, 1632},{800, 1632},{832, 1632},{864, 1632},{896, 1632},{928, 1632},{960, 1632},{960, 1664},{960, 1696},{960, 1728},{960, 1760},{960, 1792},{960, 1824},{960, 1856},{960, 1888},{960, 1920},{960, 1952},{960, 1984},{928, 1792},{896, 1792},{864, 1792},{832, 1792},{800, 1792},{768, 1792},{736, 1792}}

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD39Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD39Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD39Sh,P8,{0,0},1,{LMTable="MAX"})
CIfEnd()
HacCD40 = CIf_GunTrig(P7, "Zerg Hatchery", "CD40",400,1);
CD40Sh = {23  ,{1408, 1728},{1440, 1728},{1472, 1728},{1504, 1728},{1536, 1728},{1568, 1600},{1568, 1632},{1568, 1664},{1568, 1696},{1568, 1728},{1568, 1760},{1568, 1792},{1568, 1824},{1568, 1856},{1376, 1600},{1376, 1632},{1376, 1664},{1376, 1696},{1376, 1728},{1376, 1760},{1376, 1792},{1376, 1824},{1376, 1856}}

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD40Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD40Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD40Sh,P8,{0,0},1,{LMTable="MAX"})
CIfEnd()
HacCD41 = CIf_GunTrig(P7, "Zerg Hatchery", "CD41",400,1);
Shape9081 = {4   ,{768, 2208},{1152, 2016},{1248, 2112},{864, 2304}}
CD41Sh = CS_FillPathXY(Shape9081, 1, 64, 32, 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD41Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD41Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD41Sh,P8,{0,0},1,{LMTable="MAX"})

CIfEnd()
HacCD42 = CIf_GunTrig(P7, "Zerg Hatchery", "CD42",400,1);
CD42Sh = CSMakePolygon(6, 48, 0, PlotSizeCalc(6, 3), 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD42Sh,P8,GunTrigGLoc,1,{FNTable=2})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD42Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD42Sh,P8,GunTrigGLoc,1,{FNTable=2})

CIfEnd()


HacCD2 = CIf_GunTrig(P8, "Zerg Hatchery", "CD2",400,1);
CD2Sh = CSMakePolygon(6, 48, 0, PlotSizeCalc(6, 2), 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD2Sh,P8,GunTrigGLoc,1,{FNTable=2})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD2Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD2Sh,P8,GunTrigGLoc,1,{FNTable=2})
CIfEnd()
HacCD5 = CIf_GunTrig(P8, "Zerg Hatchery", "CD5",400,1);
Shape9081_1 = {4   ,{1472, 3552},{1568, 3648},{1408, 3744},{1312, 3648}}
Shape9081_2 = {4   ,{1760, 3744},{1856, 3808},{1632, 3936},{1472, 3872}}
Shape9081_1 = CS_FillPathXY(Shape9081_1, 1, 64, 32, 0)
Shape9081_2 = CS_FillPathXY(Shape9081_2, 1, 64, 32, 0)
CD5Sh = CS_OverlapX(Shape9081_1,Shape9081_2)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD5Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD5Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD5Sh,P8,{0,0},1,{LMTable="MAX"})



CIfEnd()
HacCD6 = CIf_GunTrig(P8, "Zerg Hatchery", "CD6",400,1);
CD6Sh = CSMakeLine(1, 64, 0, 5, 1)
for i = 0, 7 do
	G_CB_TSetSpawn({CD(GunTrigGCcode,0+(i*10),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD6Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RotateTable = (i*360)/8})
	G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD6Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RotateTable = (i*360)/8,RepeatType="KiilUnit"})
	G_CB_TSetSpawn({CD(GunTrigGCcode,200+(i*10),AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD6Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RotateTable = (i*360)/8})
end
CIfEnd()
HacCD49 = CIf_GunTrig(P7, "Zerg Hatchery", "CD49",400,1);
CD49Sh = CSMakeStar(4, 180, 48, 45, PlotSizeCalc(4*2, 3), PlotSizeCalc(4*2, 2))

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD49Sh,P8,GunTrigGLoc,1)
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD49Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD49Sh,P8,GunTrigGLoc,1)


CIfEnd()
HacCD50 = CIf_GunTrig(P7, "Zerg Hatchery", "CD50",400,1); -- 알랜 가디언 영웅
CIfEnd()
HacCD51 = CIf_GunTrig(P7, "Zerg Hatchery", "CD51",400,1); --워브 톰
CIfEnd()
HacCD52 = CIf_GunTrig(P7, "Zerg Hatchery", "CD52",400,1);
CD52_Sh = CS_OverlapX(CS_MoveXY(CSMakeLine(2, 32, 45, 16, 0), 0, -182+23),CS_MoveXY(CSMakeLine(2, 32, 45+90, 16, 0), 0, 182-23))

G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD52_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD52_Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Devouring One (Zergling)","Kukulza (Mutalisk)"},CD52_Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})

CIfEnd()
HacCD53 = CIf_GunTrig(P7, "Zerg Hatchery", "CD53",400,1);
CIfEnd()	
LairCD8 = CIf_GunTrig(P7, "Zerg Lair", "CD8",400,3);
Shape9081 = {6   ,{1440, 2848},{1664, 2720},{1664, 2624},{1536, 2560},{1344, 2656},{1376, 2752}}
CD8Sh = CS_FillPathXY(Shape9081, 1, 40, 40, 0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD8Sh,P8,{0,0},1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD8Sh,P8,{0,0},1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD8Sh,P8,{0,0},1,{LMTable="MAX"})

CIfEnd()
LairCD12 = CIf_GunTrig(P7, "Zerg Lair", "CD12",400,3);
CIfEnd()
LairCD13 = CIf_GunTrig(P7, "Zerg Lair", "CD13",400,3);
CIfEnd()
LairCD14 = CIf_GunTrig(P7, "Zerg Lair", "CD14",400,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CIfEnd()
LairCD15 = CIf_GunTrig(P7, "Zerg Lair", "CD15",400,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CIfEnd()
LairCD18 = CIf_GunTrig(P7, "Zerg Lair", "CD18",400,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CIfEnd()
LairCD19 = CIf_GunTrig(P7, "Zerg Lair", "CD19",400,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CIfEnd()
LairCD7 = CIf_GunTrig(P8, "Zerg Lair", "CD7",400,3);
CD7Sh_1 = CSMakeLine(4, 64, 45, 17, 1)
CD7Sh_2 = CS_ConnectPath(CSMakePath({-182,-182},{182,-182},{182,182},{-182,182}),4,1)
CD7Sh = CS_OverlapX(CD7Sh_1,CD7Sh_2)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD7Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
G_CB_TSetSpawn({CD(GunTrigGCcode,140,AtLeast)},{"Zerg Devourer"},CD7Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,200,AtLeast)},{"Hunter Killer (Hydralisk)","Torrasque (Ultralisk)","Kukulza (Guardian)"},CD7Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
CIfEnd()
LairCD9 = CIf_GunTrig(P8, "Zerg Lair", "CD9",400,3);
CIfEnd()
LairCD10 = CIf_GunTrig(P8, "Zerg Lair", "CD10",400,3);
CIfEnd()
LairCD11 = CIf_GunTrig(P8, "Zerg Lair", "CD11",400,3);
CIfEnd()
LairCD16 = CIf_GunTrig(P8, "Zerg Lair", "CD16",400,3);
CIfEnd()
LairCD17 = CIf_GunTrig(P8, "Zerg Lair", "CD17",400,3);
CIfEnd()
LairCD54 = CIf_GunTrig(P7, "Zerg Lair", "CD54",400,3); -- 첫, 둘째젠 동일, 3젠 존재. 시즈탱크 톰
CIfEnd()
LairCD55 = CIf_GunTrig(P7, "Zerg Lair", "CD55",400,4); -- 마인. 리썰 배달 브금으로 변경.

CD55Sh = CSMakeCircle(8,64,0,PlotSizeCalc(8, 3),0)
G_CB_TSetSpawn({CD(GunTrigGCcode,0,AtLeast)},{"Zerg Devourer"},CD55Sh,P8,GunTrigGLoc,1,{LMTable="MAX",RepeatType="KiilUnit"})
G_CB_TSetSpawn({CD(GunTrigGCcode,40,AtLeast)},{"Vulture Spider Mine"},CD55Sh,P8,GunTrigGLoc,1,{LMTable="MAX"})
CIfEnd()


HiveCD20 = CIf_GunTrig(P7, "Zerg Hive", "CD20",400,1);
CIfEnd()
HiveCD27 = CIf_GunTrig(P7, "Zerg Hive", "CD27",400,1);
CIfEnd()
HiveCD21 = CIf_GunTrig(P8, "Zerg Hive", "CD21",400,1);
CIfEnd()
HiveCD26 = CIf_GunTrig(P8, "Zerg Hive", "CD26",400,1);
CIfEnd()



NDCD200 = CIf_GunTrig(P7, "Norad II (Crashed Battlecruiser)", "CD200",400,5);
-- ms // 0x1D
G_CB_TScanEff({CD(NDCD200,0,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 213, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,340 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 332, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,670 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 215, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,1000 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 334, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(NDCD200,4030 // 0x1D,AtLeast)}, {50}, {CSMakeCircle(8, 64, 0, PlotSizeCalc(8, 3), 0)}, P8, GunTrigGLoc, 1, {RepeatType=2,LMTable="MAX"})


G_CB_TScanEff({CD(NDCD200,4030 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 213, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,4380 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 332, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,4610 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 215, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,5040 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 334, 1,{LMTable="MAX"})

G_CB_TSetSpawn({CD(NDCD200,6080 // 0x1D,AtLeast)}, {"Vulture Spider Mine"}, {CSMakeCircle(25, 256, 0, 26, 1)}, P8, GunTrigGLoc, 1, {RepeatType="RemoveTimer",LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,6080 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 213, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,6400 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 332, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,6750 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 215, 1,{LMTable="MAX"})
G_CB_TScanEff({CD(NDCD200,7080 // 0x1D,AtLeast)}, {CSMakeCircle(25, 256, 0, 26, 1)}, GunTrigGLoc, 334, 1,{LMTable="MAX"})


CIfEnd()






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




]]










function GunPoint(Player,GunID,Text,Point)
	TriggerX(FP,{Deaths(Player, AtLeast, 1, GunID);},{RotatePlayer({DisplayTextX(Text, 4)}, HumanPlayers, FP),SetScore(Force1, Add, Point, Kills),SetDeaths(Player,Subtract,1,GunID)},{preserved})
end

function HPoint(UnitID,Text,Point)
	TriggerX(FP,{Deaths(P7, AtLeast, 1, UnitID);},{DisplayText(Text, 4);SetScore(CurrentPlayer, Add, Point, Kills);PlayWAV("staredit\\wav\\cut.ogg");PlayWAV("staredit\\wav\\cut.ogg");},{preserved})
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
