function G3_Install_Shape()
	NexBYDLine = {}
	NexBYDLine2 = {}
	IonShape =  CS_ConnectPathX({4   ,{2816, 1280},{2272, 1568},{2880, 1888},{3456, 1600}},148)
	IonShape2 = CS_ConnectPathX({4   ,{2880, 1456},{2656, 1568},{2880, 1680},{3120, 1568}},96,1)
	for i=0, 12 do
	   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	for i=0, 46 do
	   table.insert(NexBYDLine2,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	NBYD = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine)),1,0.5)
	NBYD2 = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine2)),1,0.5)
	NBYD = CS_SortR(NBYD,1)
	LeftLine = CSMakeLine(2,64,0,(4096-64)/64,0)
	SouthLine = CSMakeLine(2,64,90,(4096-64)/64,0)

	Cell1 = CS_ConnectPathX({2   ,{896, 3552},{512, 3360}},16,nil)
	Cell2 = CS_ConnectPathX({2   ,{896, 3552},{448, 3776}},16,nil)
	Cell3 = CS_ConnectPathX({2   ,{896, 3552},{1408, 3808}},16,nil)



	G_CAPlot_Shape_InputTable={}
	function G_CA_Shape(t)
		for j, k in pairs(t) do
			table.insert(G_CAPlot_Shape_InputTable,k)
		end
		
	end
	G_CA_Shape({
		"NBYD",
		"IonShape",
		"IonShape2",
		"LeftLine",
		"SouthLine",
		"Cell1",
		"Cell2",
		"Cell3",

	}
	)
	if #G_CAPlot_Shape_InputTable >= 256 then
		PushErrorMsg("G_CAPlot_Shape_InputTable_is_Full")
	end
	
end