function M2_Install_Shape()
	G_CAPlot_Shape_InputTable = {}
	
	NexBYDLine = {}
	for i=0, 12 do
	   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	NBYD = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine)),1,0.5)
	table.insert(G_CAPlot_Shape_InputTable,"NBYD")
	
	
end
