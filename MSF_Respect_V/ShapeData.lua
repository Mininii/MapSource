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
	Cir = Create_SortTable({
        CSMakeCircle(8, 48, 0, PlotSizeCalc(8, 1), 0),
        CSMakeCircle(8, 60, 0, PlotSizeCalc(8, 2), 0),
        CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 3), 0),
        CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 4), 0),
        CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 5), 0)	})
    
        
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
    
	Poly = CSMakePolygon(6, 32, 0, PlotSizeCalc(6, 5), 0)
    
    
        G_CAPlot_Shape_InputTable = {"Poly"
            
    
        }
end