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
	Circle1 = CSMakeCircle(18,32*7,0,19,1)
	Circle2 = CSMakeCircle(36,32*7,0,37,1)
	Star1 = CSMakeStar(6,165-(12*(6-2)),((32*6)-(32*1))/2,180,PlotSizeCalc(6*2,2),PlotSizeCalc(6*2,1))
	QNest = CSMakePolygon(4,64,0,PlotSizeCalc(4,5),PlotSizeCalc(4,4))
	EChamb = CSMakePolygon(6,64,0,PlotSizeCalc(6,6),PlotSizeCalc(6,5))

	L00_1 = CSMakePath({-160,-160},{160,-160},{160,160},{-160,160})
	H00_1 = CSMakePath({-192,-192},{192,-192},{192,192},{-192,192})
	L00_1_64F = CS_FillPathXY(L00_1,0,64,64)
	L00_1_96F = CS_FillPathXY(L00_1,0,96,96)
	L00_1_128F = CS_FillPathXY(L00_1,0,128,128)
	L00_1_164F = CS_FillPathXY(L00_1,0,164,164)

	L00_1_64L = CS_ConnectPathX(L00_1,64,1)
	L00_1_96L = CS_ConnectPathX(L00_1,96,1)
	L00_1_128L = CS_ConnectPathX(L00_1,128,1)
	L00_1_164L = CS_ConnectPathX(L00_1,164,1)

	H00_1_64F = CS_FillPathXY(H00_1,0,64,64)
	H00_1_82F = CS_FillPathXY(H00_1,0,82,82)
	H00_1_96F = CS_FillPathXY(H00_1,0,96,96)
	H00_1_128F = CS_FillPathXY(H00_1,0,128,128)

	H00_1_64L = CS_ConnectPathX(H00_1,64,1)
	H00_1_82L = CS_ConnectPathX(H00_1,82,1)
	H00_1_96L = CS_ConnectPathX(H00_1,96,1)
	H00_1_128L = CS_ConnectPathX(H00_1,128,1)

	function G_CA_Shape(t)
		for j, k in pairs(t) do
			table.insert(G_CAPlot_Shape_InputTable,k)
		end
	end
	G_CA_Shape({
		"NBYD",
		"L00_1_64F",
		"Circle1",
		"Circle2",
		"Star1",
		"L00_1_64L",
		"L00_1_96F",
		"H00_1_64F",
		"H00_1_128F",
		"QNest",
		"EChamb",
		"H00_1_64L","L00_1_164F"}
	)


	
	
end
