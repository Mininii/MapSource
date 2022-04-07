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
	Cell1 = CS_ConnectPathX({2   ,{896*2, 3552*2},{512*2, 3360*2}},16,nil)
	Cell2 = CS_ConnectPathX({2   ,{896*2, 3552*2},{448*2, 3776*2}},16,nil)
	Cell3 = CS_ConnectPathX({2   ,{896*2, 3552*2},{1408*2, 3808*2}},16,nil)
else
	NBYD = CS_SortR(NBYD,1)
	LeftLine = CSMakeLine(2,64,0,(4096-64)/64,0)
	SouthLine = CSMakeLine(2,64,90,(4096-64)/64,0)
	Cell1 = CS_ConnectPathX({2   ,{896, 3552},{512, 3360}},16,nil)
	Cell2 = CS_ConnectPathX({2   ,{896, 3552},{448, 3776}},16,nil)
	Cell3 = CS_ConnectPathX({2   ,{896, 3552},{1408, 3808}},16,nil)
end



	G_CAPlot_Shape_InputTable={}
	function G_CA_Shape(t)
		for j, k in pairs(t) do
			table.insert(G_CAPlot_Shape_InputTable,k)
		end
		
	end
	G_CA_Shape({
		"NBYD",
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