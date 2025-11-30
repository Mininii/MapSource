function G3_Install_Shape()
	NexBYDLine = {}
	NexBYDLine2 = {}
	for i=0, 12 do
	   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	for i=0, 20 do
	   table.insert(NexBYDLine2,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	NBYD = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine)),1,0.5)
	NBYD2 = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine2)),1,0.5)
if X2_Mode==1 then
	NBYD = CS_SortR(NBYD2,1)
	LeftLine = CSMakeLine(2,64,0,(8192-64)/64,0)
	SouthLine = CSMakeLine(2,64,90,(8192-64)/64,0)
	if X2_Map==0 then
		NBYD = CS_RatioXY(NBYD,0.5)
		LeftLine = CS_RatioXY(LeftLine,0.5)
		SouthLine = CS_RatioXY(SouthLine,0.5)
	end
else
	NBYD = CS_SortR(NBYD,1)
	LeftLine = CSMakeLine(2,64,0,(4096-64)/64,0)
	SouthLine = CSMakeLine(2,64,90,(4096-64)/64,0)
end

if X2_Map==1 then
	Cell1 = CS_ConnectPathX({2   ,{896, 3552},{512, 3360}},16,nil)
	Cell2 = CS_ConnectPathX({2   ,{896, 3552},{448, 3776}},16,nil)
	Cell3 = CS_ConnectPathX({2   ,{896, 3552},{1408, 3808}},16,nil)
else
	Cell1 = CS_ConnectPathX({2   ,{896*2, 3552*2},{512*2, 3360*2}},16,nil)
	Cell2 = CS_ConnectPathX({2   ,{896*2, 3552*2},{448*2, 3776*2}},16,nil)
	Cell3 = CS_ConnectPathX({2   ,{896*2, 3552*2},{1408*2, 3808*2}},16,nil)
end

ChryShape1 = CSMakePolygon(4,192,0,PlotSizeCalc(4,2),0)
ChryShape2 = CSMakePolygon(4,164,0,PlotSizeCalc(4,3),0)
ChryShape3 = CSMakePolygon(4,96,0,PlotSizeCalc(4,5),0)
G_CAPlot_Shape_InputTable={}
function G_CA_Shape(t)
	for j, k in pairs(t) do
		table.insert(G_CAPlot_Shape_InputTable,k)
	end
	
end
if X2_Mode == 1 then
	if X2_Map == 1 then
	X2_XYArr2 = {
		{-256,-256},{256,-256},{-256,256},{256,256},
	}
	else
	X2_XYArr2 = {
		{-128,-128},{128,-128},{-128,128},{128,128},
	}
	end
	for i = 1, 4 do
	_G["ChryShape1_"..i] = CS_MoveXY(ChryShape1,X2_XYArr2[i][1],X2_XYArr2[i][2])
	_G["ChryShape2_"..i] = CS_MoveXY(ChryShape2,X2_XYArr2[i][1],X2_XYArr2[i][2])
	_G["ChryShape3_"..i] = CS_MoveXY(ChryShape3,X2_XYArr2[i][1],X2_XYArr2[i][2])
	table.insert(G_CAPlot_Shape_InputTable,"ChryShape1_"..i)
	table.insert(G_CAPlot_Shape_InputTable,"ChryShape2_"..i)
	table.insert(G_CAPlot_Shape_InputTable,"ChryShape3_"..i)



	end
else
	table.insert(G_CAPlot_Shape_InputTable,"ChryShape1")
	table.insert(G_CAPlot_Shape_InputTable,"ChryShape2")
	table.insert(G_CAPlot_Shape_InputTable,"ChryShape3")
end
ObEffShape = CSMakeStar(5,108,128,126,PlotSizeCalc(5*2,2),0)
if X2_Mode==1 then
	IonShape =  CS_ConnectPathX({4   ,{2816*2, 1280*2},{2272*2, 1568*2},{2880*2, 1888*2},{3456*2, 1600*2}},148/2)
	IonShape2 = CS_ConnectPathX({4   ,{2880*2, 1456*2},{2656*2, 1568*2},{2880*2, 1680*2},{3120*2, 1568*2}},48,1)
	if X2_Map==0 then
		IonShape = CS_RatioXY(IonShape,0.5)
		IonShape2 = CS_RatioXY(IonShape2,0.5)
	end
else
	IonShape =  CS_ConnectPathX({4   ,{2816, 1280},{2272, 1568},{2880, 1888},{3456, 1600}},148)
	IonShape2 = CS_ConnectPathX({4   ,{2880, 1456},{2656, 1568},{2880, 1680},{3120, 1568}},96,1)
end

	G_CA_Shape({
		"NBYD",
		"LeftLine",
		"SouthLine",
		"Cell1",
		"Cell2",
		"Cell3",
		"IonShape",
		"IonShape2",
		"ObEffShape"

	}
	)
	if #G_CAPlot_Shape_InputTable >= 256 then
		PushErrorMsg("G_CAPlot_Shape_InputTable_is_Full")
	end
	
end