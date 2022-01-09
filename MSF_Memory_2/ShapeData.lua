function M2_Install_Shape()
	G_CAPlot_Shape_InputTable = {}
	L00_1 = CSMakePath({-160,-160},{160,-160},{160,160},{-160,160})
	H00_1 = CSMakePath({-192,-192},{192,-192},{192,192},{-192,192})
	L00_1_64F = CS_FillPathXY(L00_1,0,64,64)
	
	NexBYDLine = {}
	for i=0, 12 do
	   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	NBYD = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine)),1,0.5)
	table.insert(G_CAPlot_Shape_InputTable,"NBYD")
	table.insert(G_CAPlot_Shape_InputTable,"L00_1_64F")
	
	
end
