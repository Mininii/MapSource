function Install_Shape()
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

	Cere_Z = CSMakeCircle(8,32,0,PlotSizeCalc(8,9),1) -- 유닛 생성 저그유닛
	Cere_N = CSMakeCircle(8,72,0,PlotSizeCalc(8,3),1) -- 유닛 생성 노말
	Cere_H = CSMakeCircle(8,60,0,PlotSizeCalc(8,5),1) -- 유닛 생성 하드
	Cere_B = CSMakeCircle(8,48,0,PlotSizeCalc(8,7),1) -- 유닛 생성 버스트	

	Ovrm = {12  ,{2112, 3574},{1984, 3488},{2112, 3392},{1984, 3264},{2112, 3168},{1792, 2976},{1984, 2880},{2368, 3072},{2560, 2976},{2752, 3072},{2944, 3008},{3136, 3072}}

	Ovrm_X64 = CS_FillPathXY(Ovrm,0,64,32)
	Ovrm_X96 = CS_FillPathXY(Ovrm,0,96,48)
	Ovrm_X128 = CS_FillPathXY(Ovrm,0,128,64)
	Ovrm_X160 = CS_FillPathXY(Ovrm,0,160,160/2)
	Ovrm_X192 = CS_FillPathXY(Ovrm,0,192,192/2)
	Chry_N = CS_RatioXY(CSMakeStar(4,180,75,45,7*7,5*5),1,0.5)
	Chry_H = CS_RatioXY(CSMakeStar(4,180,75,45,7*7,0),1,0.5)
	Chry_B = CS_RatioXY(CSMakeStar(4,180,75,45,13*13,0),1,0.5)
	Chry_1 = {62  ,{192, 2176},{256, 2208},{320, 2240},{384, 2272},{448, 2304},{576, 2368},{640, 2400},{704, 2432},{768, 2464},{896, 2528},{960, 2560},{1024, 2592},{1088, 2624},{1216, 2688},{1280, 2720},{1344, 2752},{1408, 2784},{1472, 2816},{512, 2016},{576, 2048},{640, 2080},{704, 2112},{768, 2144},{832, 2176},{896, 2208},{960, 2240},{1024, 2272},{1088, 2304},{1152, 2336},{1216, 2368},{1280, 2400},{1344, 2432},{1408, 2464},{1472, 2496},{1536, 2528},{1600, 2560},{1664, 2592},{1728, 2624},{448, 2048},{384, 2080},{320, 2112},{256, 2144},{512, 2336},{768, 2208},{704, 2240},{640, 2272},{576, 2304},{832, 2496},{1088, 2368},{1024, 2400},{960, 2432},{896, 2464},{1152, 2656},{1408, 2528},{1344, 2560},{1280, 2592},{1216, 2624},{1536, 2784},{1792, 2656},{1728, 2688},{1664, 2720},{1600, 2752}}
	Chry_2 = {64  ,{512, 2048},{448, 2080},{384, 2112},{320, 2144},{256, 2176},{320, 2208},{384, 2240},{448, 2272},{512, 2304},{576, 2272},{640, 2240},{704, 2208},{768, 2176},{704, 2144},{640, 2112},{576, 2080},{832, 2208},{768, 2240},{704, 2272},{640, 2304},{576, 2336},{640, 2368},{704, 2400},{768, 2432},{832, 2464},{896, 2432},{960, 2400},{1024, 2368},{1088, 2336},{1024, 2304},{960, 2272},{896, 2240},{1152, 2368},{1088, 2400},{1024, 2432},{960, 2464},{896, 2496},{960, 2528},{1024, 2560},{1088, 2592},{1152, 2624},{1216, 2592},{1280, 2560},{1344, 2528},{1408, 2496},{1344, 2464},{1280, 2432},{1216, 2400},{1472, 2528},{1408, 2560},{1344, 2592},{1280, 2624},{1216, 2656},{1280, 2688},{1344, 2720},{1408, 2752},{1472, 2784},{1536, 2752},{1600, 2720},{1664, 2688},{1728, 2656},{1664, 2624},{1600, 2592},{1536, 2560}}
	Chry_3 = {48  ,{704, 2176},{640, 2144},{576, 2112},{512, 2080},{448, 2112},{384, 2144},{320, 2176},{384, 2208},{448, 2240},{512, 2272},{576, 2240},{640, 2208},{1024, 2336},{960, 2304},{896, 2272},{832, 2240},{768, 2272},{704, 2304},{640, 2336},{704, 2368},{768, 2400},{832, 2432},{896, 2400},{960, 2368},{1344, 2496},{1280, 2464},{1216, 2432},{1152, 2400},{1088, 2432},{1024, 2464},{960, 2496},{1024, 2528},{1088, 2560},{1152, 2592},{1216, 2560},{1280, 2528},{1664, 2656},{1600, 2624},{1536, 2592},{1472, 2560},{1408, 2592},{1344, 2624},{1280, 2656},{1344, 2688},{1408, 2720},{1472, 2752},{1536, 2720},{1600, 2688}}
	Chry_4 = {36  ,{640, 2176},{576, 2144},{512, 2112},{448, 2144},{384, 2176},{448, 2208},{512, 2240},{576, 2208},{512, 2176},{960, 2336},{896, 2304},{832, 2272},{768, 2304},{704, 2336},{768, 2368},{832, 2400},{896, 2368},{832, 2336},{1280, 2496},{1216, 2464},{1152, 2432},{1088, 2464},{1024, 2496},{1088, 2528},{1152, 2560},{1216, 2528},{1152, 2496},{1600, 2656},{1536, 2624},{1472, 2592},{1408, 2624},{1344, 2656},{1408, 2688},{1472, 2720},{1536, 2688},{1472, 2656}}
	PySuPos = {{{1024,1760},{1536,1440},{2048,1760},{2560,1440},{3072,1760}},{{1024,1376},{1536,1824},{2048,1376},{2560,1824},{3072,1376}}}
	Boss1 = CS_Intersect(CSMakePolygon(6,24,0,PlotSizeCalc(6,20),0),CS_Merge(CSMakeLine(6,24,0,(21*6)+1,0),CSMakePolygon(6,24,0,PlotSizeCalc(6,20),PlotSizeCalc(6,19)),8,0),8,0)

	

	HLC = CS_CropXY(CSMakeCircle(180,500,0,181,1),{0,4096},{-4096,4096}) -- 동 반원
	HRC = CS_CropXY(CSMakeCircle(180,500,0,181,1),{-4096,0},{-4096,4096}) -- 서 반원
	HUC = CS_CropXY(CSMakeCircle(180,500,0,181,1),{-4096,4096},{0,4096}) -- 남 반원
	HDC = CS_CropXY(CSMakeCircle(180,500,0,181,1),{-4096,4096},{-4096,0}) -- 북 반원
	BSh1 = {2   ,{512, 1856},{1760, 2464}}
	BSh2 = {2   ,{128, 2272},{1536, 3040}}
	Boss2 = CS_ConnectPathX(BSh1,32)
	Boss3 = CS_ConnectPathX(BSh2,32)
	Boss4 = CSMakePolygon(6,24,0,PlotSizeCalc(6,5),0)
	
	TestSh1 = CS_FillPathHX(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),1,48,48,2)
	TestSh2 = CS_FillPathHX(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),1,48,48,3)
	--CS_Distortion()
	BattleShape = CSMakeStar(5,165-(12*(5-2)),((36*6)-(36*2))/2,180,PlotSizeCalc(5*2,2),PlotSizeCalc(5*2,1))

	
function CS_OverlapShape(Shape,...)
	local RetShape = Shape

	local arg = table.pack(...)
	for k = 1, arg.n do
		RetShape[1] = RetShape[1] + arg[k][1]
		for i = 1, arg[k][1] do
			table.insert(RetShape,{arg[k][i+1][1],arg[k][i+1][2]})
		end
	end
	return RetShape	
end
function CSMakeTornado(Point,Radius,Angle,Numner,Outside,StartNumber)
	local Shape = {0}
	if StartNumber == nil then StartNumber = 1 end
	for i = StartNumber, Numner do
		CS_OverlapShape(Shape,CSMakePolygon(Point,i*Radius,i*Angle,Point+1,0))
	end
	if Outside~=nil then
		return CS_Rotate((CS_OverlapShape(Shape,CSMakePolygon(Point,Radius,Numner*Angle,PlotSizeCalc(Point,Numner),PlotSizeCalc(Point,Numner-1)))),-Numner*Angle)
	else
		return Shape
	end
end

	QuaShape = CSMakeTornado(4, 24, 15, 8)

	NeShape = CSMakePolygon(4,(((16*9)-(16*1))+24)/2,0,PlotSizeCalc(4,1),1)

	TeShape = CSMakePolygon(3,(((16*9)-(16*1))+24)/2,0,PlotSizeCalc(3,1),1)

	G_CAPlot_Shape_InputTable = {
		"L00_1_64F","L00_1_96F","L00_1_128F","L00_1_164F","L00_1_64L","L00_1_96L","L00_1_128L","L00_1_164L",	
		"H00_1_64F","H00_1_82F","H00_1_96F","H00_1_128F","H00_1_64L","H00_1_82L","H00_1_96L","H00_1_128L",
		"Cere_Z","Cere_N","Cere_H","Cere_B",
		"Ovrm_X64","Ovrm_X96","Ovrm_X128","Ovrm_X160","Ovrm_X192",
		"Chry_1","Chry_2","Chry_3","Chry_4",
		"Chry_N","Chry_H","Chry_B",
		"HLC","HRC","HUC","HDC",
		"Boss1","Boss2","Boss3","Boss4",
		"TestSh1","TestSh2","BattleShape",
		"NeShape","TeShape"

	}

	for p, s in pairs(PySuPos) do
		local PSType
		if p == 1 then PSType = "Py" end
		if p == 2 then PSType = "Su" end
		for j = 1, 5 do
			_G[PSType..j] = CS_MoveCenter(CS_RatioXY(CSMakeStar(4,180,75,45,9*9,7*7),1,0.5),s[j][1],s[j][2])
			table.insert(G_CAPlot_Shape_InputTable,PSType..j)
			for i = 1, 3 do
				local Dif
				local ShN
				if i == 1 then Dif = "N" ShN = 5*5 end
				if i == 2 then Dif = "H" ShN = 7*7 end
				if i == 3 then Dif = "B" ShN = 9*9 end
				_G[PSType..j.."F"..Dif] = CS_MoveCenter(CS_SortR(CS_RatioXY(CSMakeStar(4,180,75,45,ShN,0),1,0.5),1),s[j][1],s[j][2])
				table.insert(G_CAPlot_Shape_InputTable,PSType..j.."F"..Dif)
			end
		end
	end

	Shape_Hard = CS_RatioXY(CSMakeStar(4,180,75,45,9*9,7*7),1,0.5)
	Shape_Hard2 = CS_RatioXY(CSMakeStar(4,180,75,45,3*3,0),1,0.5)
	Shape_Burst = CS_RatioXY(CSMakeStar(4,180,75,45,9*9,0),1,0.5)
	Shape_Burst2 = CS_RatioXY(CSMakeStar(4,180,75,45,5*5,3*3),1,0.5)

	local ChryPos = {{512, 2176},{832, 2336},{1152, 2496},{1472, 2656}}
	for j, k in pairs(ChryPos) do
	_G["GB_H1_"..j] = CS_MoveCenter(Shape_Hard,k[1],k[2])
	_G["GB_H2_"..j] = CS_MoveCenter(Shape_Hard2,k[1],k[2])
	_G["GB_B1_"..j] = CS_MoveCenter(Shape_Burst,k[1],k[2])
	_G["GB_B2_"..j] = CS_MoveCenter(Shape_Burst2,k[1],k[2])
	table.insert(G_CAPlot_Shape_InputTable,"GB_H1_"..j)
	table.insert(G_CAPlot_Shape_InputTable,"GB_H2_"..j)
	table.insert(G_CAPlot_Shape_InputTable,"GB_B1_"..j)
	table.insert(G_CAPlot_Shape_InputTable,"GB_B2_"..j)
	end
	

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
	

	function MakeLevelShapeA(Type,Points,Level)
		local X = {}
		if Type == "Polygon" then
			table.insert(X,CSMakePolygon(Points,((16*9)-(16*Level))+24,0,PlotSizeCalc(Points,Level),0))
		  
		elseif Type == "Star" then
			table.insert(X,CSMakeStar(Points,165-(12*(Points-2)),(36*6)-(36*Level),180,PlotSizeCalc(Points*2,Level),0))
		else
			PushErrorMsg("Type_InputError")
		end
		return X
	end

	function MakeLevelShape(Type,Points,LvMin,LvMax)
		local X = {}
		for i = LvMin, LvMax do
			 if Type == "Polygon" then
				  table.insert(X,CSMakePolygon(Points,((16*9)-(16*i))+24,0,PlotSizeCalc(Points,i),0))
				  
			 elseif Type == "Star" then
				  table.insert(X,CSMakeStar(Points,165-(12*(Points-2)),(36*6)-(36*i),180,PlotSizeCalc(Points*2,i),0))
			 end
		end
		return X
	end
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
	
	
	NexBYDLine = {}
	for i=0, 12 do
	   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	NBYD = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine)),1,0.5)
	table.insert(G_CAPlot_Shape_InputTable,"NBYD")
	
	
end
