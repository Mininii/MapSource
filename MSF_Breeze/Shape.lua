function Shape()
	

	function Create_SortTable(Shape)
		local X = {}
		if type(Shape[1]) == "number" then
			table.insert(X,CS_SortX(Shape,0))
			table.insert(X,CS_SortX(Shape,1))
			table.insert(X,CS_SortY(Shape,0))
			table.insert(X,CS_SortY(Shape,1))
			table.insert(X,CS_SortR(Shape,0))
			table.insert(X,CS_SortR(Shape,1))
			table.insert(X,CS_SortA(Shape,0))
			table.insert(X,CS_SortA(Shape,1))
			table.insert(X,CS_DoubleSortRA(Shape,32,0,0))
			table.insert(X,CS_DoubleSortRA(Shape,32,0,1))
			table.insert(X,CS_DoubleSortRA(Shape,32,1,0))
			table.insert(X,CS_DoubleSortRA(Shape,32,1,1))
		else
			for j, k in pairs(Shape) do
				table.insert(X,CS_SortX(k,0))
				table.insert(X,CS_SortX(k,1))
				table.insert(X,CS_SortY(k,0))
				table.insert(X,CS_SortY(k,1))
				table.insert(X,CS_SortR(k,0))
				table.insert(X,CS_SortR(k,1))
				table.insert(X,CS_SortA(k,0))
				table.insert(X,CS_SortA(k,1))
				table.insert(X,CS_DoubleSortRA(k,32,0,0))
				table.insert(X,CS_DoubleSortRA(k,32,0,1))
				table.insert(X,CS_DoubleSortRA(k,32,1,0))
				table.insert(X,CS_DoubleSortRA(k,32,1,1))
			end

		end
		return X
	end
	

	function MakeLevelShape(Type,Points,LvMin,LvMax)
		local X = {}
		for i = LvMin, LvMax do
			 if Type == "Polygon" then
				  table.insert(X,CSMakePolygon(Points,240/i,0,PlotSizeCalc(Points,i),0))
				  
			 elseif Type == "Star" then
				table.insert(X,CSMakeStar(Points,165-(12*(Points-2)),240/i,180,PlotSizeCalc(Points*2,i),0))
			 end
		end
		return X
	end
	ShapeB084 = {4   ,{1184, 32},{1888, 32},{1888, 448},{1184, 448}}
	Form = CS_FillPathXY(ShapeB084, 1, 24, 24, 0)

	Shape8000 = {3   ,{32, 224},{32, 32},{448, 32}}
	Shape8001 = {3   ,{3040, 224},{3040, 32},{2624, 32}}
	LOverM= CS_MoveXY(CS_FillPathXY(Shape8000, 1, 32, 32, 0),-160,-128)
	ROverM= CS_MoveXY(CS_FillPathXY(Shape8001, 1, 32, 32, 0),-2912,-128)
	
	LOvP = {4  ,{864, 0},{576, 0},{0, 288},{0, 448}}
	ROvP = {4, {2176, 0},{2496, 0},{96*32, 288},{96*32, 448}}
	LOvPF = CS_MoveXY(CS_FillPathXY(LOvP, 1, 32, 32, 0),-160,-128)
	ROvPF = CS_MoveXY(CS_FillPathXY(ROvP, 1, 32, 32, 0),-2912,-128)
	Cir = Create_SortTable({CSMakeCircle(8, 48, 0, PlotSizeCalc(8, 1), 0),
	CSMakeCircle(8, 60, 0, PlotSizeCalc(8, 2), 0),
	CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 3), 0),
	CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 4), 0),
	CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 5), 0)	})
	Shape1032 = {5   ,{2464, 1216},{2336, 1280},{2048, 1280},{1920, 1216},{2176, 1088}}
	Shape1001 = {4   ,{2048, 1280},{1920, 1216},{1664, 1312},{1792, 1440}}
	Shape1003 = {4   ,{1664, 1312},{1792, 1440},{1312, 1440},{1408, 1312}}
	Shape1034 = {4   ,{1312, 1440},{1408, 1312},{1152, 1216},{1024, 1280}}
	Shape1007 = {5   ,{1024, 1280},{800, 1280},{640, 1184},{896, 1088},{1152, 1216}}
	Chry5 = CS_MoveXY(CS_FillPathXY(Shape1032, 1, 24, 24, 0),-2176,-1152)
	Chry4 = CS_MoveXY(CS_FillPathXY(Shape1001, 1, 24, 24, 0),-1824,-1312)
	Chry3 = CS_MoveXY(CS_FillPathXY(Shape1003, 1, 24, 24, 0),-1536,-1536)
	Chry2 = CS_MoveXY(CS_FillPathXY(Shape1034, 1, 24, 24, 0),-1248,-1312)
	Chry1 = CS_MoveXY(CS_FillPathXY(Shape1007, 1, 24, 24, 0),-896,-1152)

	S_3_ShT = Create_SortTable(MakeLevelShape("Star",3,1,4))
	S_4_ShT = Create_SortTable(MakeLevelShape("Star",4,1,4))
	S_5_ShT = Create_SortTable(MakeLevelShape("Star",5,1,4))
	S_6_ShT = Create_SortTable(MakeLevelShape("Star",6,1,4))
	S_7_ShT = Create_SortTable(MakeLevelShape("Star",7,1,4))
	S_8_ShT = Create_SortTable(MakeLevelShape("Star",8,1,4))
	P_3_ShT = Create_SortTable(MakeLevelShape("Polygon",3,1,8))
	P_4_ShT = Create_SortTable(MakeLevelShape("Polygon",4,1,8))
	P_5_ShT = Create_SortTable(MakeLevelShape("Polygon",5,1,8))
	P_6_ShT = Create_SortTable(MakeLevelShape("Polygon",6,1,8))
	P_7_ShT = Create_SortTable(MakeLevelShape("Polygon",7,1,8))
	P_8_ShT = Create_SortTable(MakeLevelShape("Polygon",8,1,8))
	Poly = CSMakePolygon(6, 32, 0, PlotSizeCalc(6, 2), 0)
	G_CAPlot_Shape_InputTable = {
		"LOverM",
		"ROverM","Poly",
		"LOvPF",
		"ROvPF",
		
		"Chry5",
		"Chry4",
		"Chry3",
		"Chry2",
		"Chry1","Form"
		

	}

end