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
	CenLinePath = {}
	for i =64, 1984,64 do
		table.insert(CenLinePath, {i,i})
	end
	CenLinePath2 = {}
	for i =64, 1984,64 do
		table.insert(CenLinePath2, {2048-i,i})
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
	
	Hy1Line = {7   ,{512, 736},{640, 672},{640, 288},{1024, 480},{1408, 288},{1408, 672},{1536, 736}} -- 선으로 긋기
	Hy1Fill = {10  ,{512, 736},{640, 672},{640, 288},{1024, 480},{1408, 288},{1408, 672},{1536, 736},{1536, 128},{1024, 384},{512, 128}} -- 채우기

	Hy1LC_64= CS_SortR(CS_MoveXY(CS_ConnectPathX(Hy1Line,128,nil),-1024,-368),0)
	Hy1FP_64= CS_SortR(CS_MoveXY(CS_FillPathXY(Hy1Fill, 1, 64, 64, 0),-1024,-368),0)--하드 저그유닛 SC 약영웅
	Fac1=CS_Rotate(CS_FillPathXY(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),0,96*2,96*2), 26.565)--9
	EnBay1= CSMakePolygon(9, 32*7, 0, 10, 1)--9
	Fac2=CS_Rotate(CS_FillPathXY(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),0,96,96), 26.565)--36
	EnBay2= CSMakePolygon(36, 32*7, 0, 37, 1)--36
    CenU = CS_SortY(CS_OverlapX(CSMakePath(CenLinePath),CS_InvertXY(CSMakePath(CenLinePath), nil, 2048)), 0)
	CenD = CS_SortY(CS_InvertXY(CS_OverlapX(CSMakePath(CenLinePath),CS_InvertXY(CSMakePath(CenLinePath), nil, 2048)), nil, 4096), 1)
	
    CenU2 = CS_SortY(CS_OverlapX(CSMakePath(CenLinePath2),CS_InvertXY(CSMakePath(CenLinePath2), nil, 2048)), 0)
	CenD2 = CS_SortY(CS_InvertXY(CS_OverlapX(CSMakePath(CenLinePath2),CS_InvertXY(CSMakePath(CenLinePath2), nil, 2048)), nil, 4096), 1)

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
    
    
        G_CAPlot_Shape_InputTable = {"Poly","Hy1LC_64","Hy1FP_64","Fac1","EnBay1","Fac2","EnBay2","CenU","CenD","CenU2","CenD2"
            
    
        }
end