function Install_Shape()
	L00_1 = CSMakePath({-160,-160},{160,-160},{160,160},{-160,160})
	H00_1 = CSMakePath({-192,-192},{192,-192},{192,192},{-192,192})
	L00_1_64F = CS_FillPathXY(L00_1,0,64,64)
	L00_1_96F = CS_FillPathXY(L00_1,0,96,96)
	L00_1_128F = CS_FillPathXY(L00_1,0,128,128)
	L00_1_96L = CS_ConnectPathX(L00_1,96,1)
	H00_1_64F = CS_FillPathXY(H00_1,0,64,64)
	H00_1_82F = CS_FillPathXY(H00_1,0,82,82)
	H00_1_96F = CS_FillPathXY(H00_1,0,96,96)
	H00_1_82L = CS_ConnectPathX(H00_1,82,1)

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
	Chry_B = CS_RatioXY(CSMakeStar(4,180,75,45,9*9,0),1,0.5)
	--Chry_1 = {62  ,{192, 2176},{256, 2208},{320, 2240},{384, 2272},{448, 2304},{576, 2368},{640, 2400},{704, 2432},{768, 2464},{896, 2528},{960, 2560},{1024, 2592},{1088, 2624},{1216, 2688},{1280, 2720},{1344, 2752},{1408, 2784},{1472, 2816},{512, 2016},{576, 2048},{640, 2080},{704, 2112},{768, 2144},{832, 2176},{896, 2208},{960, 2240},{1024, 2272},{1088, 2304},{1152, 2336},{1216, 2368},{1280, 2400},{1344, 2432},{1408, 2464},{1472, 2496},{1536, 2528},{1600, 2560},{1664, 2592},{1728, 2624},{448, 2048},{384, 2080},{320, 2112},{256, 2144},{512, 2336},{768, 2208},{704, 2240},{640, 2272},{576, 2304},{832, 2496},{1088, 2368},{1024, 2400},{960, 2432},{896, 2464},{1152, 2656},{1408, 2528},{1344, 2560},{1280, 2592},{1216, 2624},{1536, 2784},{1792, 2656},{1728, 2688},{1664, 2720},{1600, 2752}}
	--Chry_2 = {64  ,{512, 2048},{448, 2080},{384, 2112},{320, 2144},{256, 2176},{320, 2208},{384, 2240},{448, 2272},{512, 2304},{576, 2272},{640, 2240},{704, 2208},{768, 2176},{704, 2144},{640, 2112},{576, 2080},{832, 2208},{768, 2240},{704, 2272},{640, 2304},{576, 2336},{640, 2368},{704, 2400},{768, 2432},{832, 2464},{896, 2432},{960, 2400},{1024, 2368},{1088, 2336},{1024, 2304},{960, 2272},{896, 2240},{1152, 2368},{1088, 2400},{1024, 2432},{960, 2464},{896, 2496},{960, 2528},{1024, 2560},{1088, 2592},{1152, 2624},{1216, 2592},{1280, 2560},{1344, 2528},{1408, 2496},{1344, 2464},{1280, 2432},{1216, 2400},{1472, 2528},{1408, 2560},{1344, 2592},{1280, 2624},{1216, 2656},{1280, 2688},{1344, 2720},{1408, 2752},{1472, 2784},{1536, 2752},{1600, 2720},{1664, 2688},{1728, 2656},{1664, 2624},{1600, 2592},{1536, 2560}}
	--Chry_3 = {48  ,{704, 2176},{640, 2144},{576, 2112},{512, 2080},{448, 2112},{384, 2144},{320, 2176},{384, 2208},{448, 2240},{512, 2272},{576, 2240},{640, 2208},{1024, 2336},{960, 2304},{896, 2272},{832, 2240},{768, 2272},{704, 2304},{640, 2336},{704, 2368},{768, 2400},{832, 2432},{896, 2400},{960, 2368},{1344, 2496},{1280, 2464},{1216, 2432},{1152, 2400},{1088, 2432},{1024, 2464},{960, 2496},{1024, 2528},{1088, 2560},{1152, 2592},{1216, 2560},{1280, 2528},{1664, 2656},{1600, 2624},{1536, 2592},{1472, 2560},{1408, 2592},{1344, 2624},{1280, 2656},{1344, 2688},{1408, 2720},{1472, 2752},{1536, 2720},{1600, 2688}}
	--Chry_4 = {36  ,{640, 2176},{576, 2144},{512, 2112},{448, 2144},{384, 2176},{448, 2208},{512, 2240},{576, 2208},{512, 2176},{960, 2336},{896, 2304},{832, 2272},{768, 2304},{704, 2336},{768, 2368},{832, 2400},{896, 2368},{832, 2336},{1280, 2496},{1216, 2464},{1152, 2432},{1088, 2464},{1024, 2496},{1088, 2528},{1152, 2560},{1216, 2528},{1152, 2496},{1600, 2656},{1536, 2624},{1472, 2592},{1408, 2624},{1344, 2656},{1408, 2688},{1472, 2720},{1536, 2688},{1472, 2656}}
	G_CAPlot_Shape_InputTable = {
		"L00_1_64F","L00_1_96F","L00_1_128F","L00_1_96L",
		"H00_1_64F","H00_1_82F","H00_1_96F","H00_1_82L",
		"Cere_Z","Cere_N","Cere_H","Cere_B",
		"Ovrm_X64","Ovrm_X96","Ovrm_X128","Ovrm_X160","Ovrm_X192",
		"Chry_N","Chry_H","Chry_B",
	}

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
	NexBYDLine2 = {}
	NexBYDLine3 = {}
	NexBYDLine4 = {}
	for i=0, 12 do
	   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	for i = 1, 6 do
	table.insert(NexBYDLine2,CS_Merge(NexBYDLine[i*2],NexBYDLine[(i*2)+1],32,0))
	end
	table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[1],NexBYDLine2[2],0,0))
	table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[3],NexBYDLine2[4],0,0))
	table.insert(NexBYDLine3,CS_Merge(NexBYDLine2[5],NexBYDLine2[6],0,0))
	table.insert(NexBYDLine4,CS_Merge(NexBYDLine3[1],NexBYDLine3[2],0,0))
	table.insert(NexBYDLine4,CS_Merge(NexBYDLine3[3],NexBYDLine[1],0,0))

	NBYD = CS_Merge(NexBYDLine4[1],NexBYDLine4[2],32,0)


	Call_OvrMShape = SetCallForward()
	SetCall(FP)
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0x00000220),
			SetMemory(0x58DC68, Add, 0x00000260),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFDE0),
			SetMemory(0x58DC68, Add, 0xFFFFFDA0),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000130),
			SetMemory(0x58DC6C, Add, 0x00000170),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFED0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE90),
			SetMemory(0x58DC60, Add, 0x00000280),
			SetMemory(0x58DC68, Add, 0x000002C0),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD80),
			SetMemory(0x58DC68, Add, 0xFFFFFD40),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000220),
			SetMemory(0x58DC68, Add, 0x00000260),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFDE0),
			SetMemory(0x58DC68, Add, 0xFFFFFDA0),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000130),
			SetMemory(0x58DC6C, Add, 0x00000170),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFED0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE90),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000160),
			SetMemory(0x58DC6C, Add, 0x000001A0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFEA0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE60),
			SetMemory(0x58DC60, Add, 0x000002E0),
			SetMemory(0x58DC68, Add, 0x00000320),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD20),
			SetMemory(0x58DC68, Add, 0xFFFFFCE0),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000280),
			SetMemory(0x58DC68, Add, 0x000002C0),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD80),
			SetMemory(0x58DC68, Add, 0xFFFFFD40),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x00000220),
			SetMemory(0x58DC68, Add, 0x00000260),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFDE0),
			SetMemory(0x58DC68, Add, 0xFFFFFDA0),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x00000130),
			SetMemory(0x58DC6C, Add, 0x00000170),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFED0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE90),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000160),
			SetMemory(0x58DC6C, Add, 0x000001A0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFEA0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE60),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000190),
			SetMemory(0x58DC6C, Add, 0x000001D0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFE70),
			SetMemory(0x58DC6C, Add, 0xFFFFFE30),
			SetMemory(0x58DC60, Add, 0x00000340),
			SetMemory(0x58DC68, Add, 0x00000380),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFCC0),
			SetMemory(0x58DC68, Add, 0xFFFFFC80),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x000002E0),
			SetMemory(0x58DC68, Add, 0x00000320),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD20),
			SetMemory(0x58DC68, Add, 0xFFFFFCE0),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x00000280),
			SetMemory(0x58DC68, Add, 0x000002C0),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD80),
			SetMemory(0x58DC68, Add, 0xFFFFFD40),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x00000220),
			SetMemory(0x58DC68, Add, 0x00000260),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFDE0),
			SetMemory(0x58DC68, Add, 0xFFFFFDA0),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x00000130),
			SetMemory(0x58DC6C, Add, 0x00000170),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFED0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE90),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x00000160),
			SetMemory(0x58DC6C, Add, 0x000001A0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFEA0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE60),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000190),
			SetMemory(0x58DC6C, Add, 0x000001D0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFE70),
			SetMemory(0x58DC6C, Add, 0xFFFFFE30),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x000001C0),
			SetMemory(0x58DC6C, Add, 0x00000200),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFE40),
			SetMemory(0x58DC6C, Add, 0xFFFFFE00),
			SetMemory(0x58DC60, Add, 0x000003A0),
			SetMemory(0x58DC68, Add, 0x000003E0),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFC60),
			SetMemory(0x58DC68, Add, 0xFFFFFC20),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000340),
			SetMemory(0x58DC68, Add, 0x00000380),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFCC0),
			SetMemory(0x58DC68, Add, 0xFFFFFC80),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x000002E0),
			SetMemory(0x58DC68, Add, 0x00000320),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD20),
			SetMemory(0x58DC68, Add, 0xFFFFFCE0),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x00000280),
			SetMemory(0x58DC68, Add, 0x000002C0),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD80),
			SetMemory(0x58DC68, Add, 0xFFFFFD40),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x00000220),
			SetMemory(0x58DC68, Add, 0x00000260),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFDE0),
			SetMemory(0x58DC68, Add, 0xFFFFFDA0),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x00000130),
			SetMemory(0x58DC6C, Add, 0x00000170),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFED0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE90),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x00000160),
			SetMemory(0x58DC6C, Add, 0x000001A0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFEA0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE60),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x00000190),
			SetMemory(0x58DC6C, Add, 0x000001D0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFE70),
			SetMemory(0x58DC6C, Add, 0xFFFFFE30),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x000001C0),
			SetMemory(0x58DC6C, Add, 0x00000200),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFE40),
			SetMemory(0x58DC6C, Add, 0xFFFFFE00),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x000001F0),
			SetMemory(0x58DC6C, Add, 0x00000230),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFE10),
			SetMemory(0x58DC6C, Add, 0xFFFFFDD0),
			SetMemory(0x58DC60, Add, 0x00000400),
			SetMemory(0x58DC68, Add, 0x00000440),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFC00),
			SetMemory(0x58DC68, Add, 0xFFFFFBC0),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x000003A0),
			SetMemory(0x58DC68, Add, 0x000003E0),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFC60),
			SetMemory(0x58DC68, Add, 0xFFFFFC20),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x00000340),
			SetMemory(0x58DC68, Add, 0x00000380),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFCC0),
			SetMemory(0x58DC68, Add, 0xFFFFFC80),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x000002E0),
			SetMemory(0x58DC68, Add, 0x00000320),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD20),
			SetMemory(0x58DC68, Add, 0xFFFFFCE0),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x00000280),
			SetMemory(0x58DC68, Add, 0x000002C0),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD80),
			SetMemory(0x58DC68, Add, 0xFFFFFD40),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x00000220),
			SetMemory(0x58DC68, Add, 0x00000260),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFDE0),
			SetMemory(0x58DC68, Add, 0xFFFFFDA0),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x00000130),
			SetMemory(0x58DC6C, Add, 0x00000170),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFED0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE90),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x00000160),
			SetMemory(0x58DC6C, Add, 0x000001A0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFEA0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE60),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x00000190),
			SetMemory(0x58DC6C, Add, 0x000001D0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFE70),
			SetMemory(0x58DC6C, Add, 0xFFFFFE30),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x000001C0),
			SetMemory(0x58DC6C, Add, 0x00000200),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFE40),
			SetMemory(0x58DC6C, Add, 0xFFFFFE00),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x000001F0),
			SetMemory(0x58DC6C, Add, 0x00000230),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFE10),
			SetMemory(0x58DC6C, Add, 0xFFFFFDD0),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000220),
			SetMemory(0x58DC6C, Add, 0x00000260),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFDE0),
			SetMemory(0x58DC6C, Add, 0xFFFFFDA0),
			SetMemory(0x58DC60, Add, 0x00000460),
			SetMemory(0x58DC68, Add, 0x000004A0),
			SetMemory(0x58DC64, Add, 0x00000010),
			SetMemory(0x58DC6C, Add, 0x00000050),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFBA0),
			SetMemory(0x58DC68, Add, 0xFFFFFB60),
			SetMemory(0x58DC64, Add, 0xFFFFFFF0),
			SetMemory(0x58DC6C, Add, 0xFFFFFFB0),
			SetMemory(0x58DC60, Add, 0x00000400),
			SetMemory(0x58DC68, Add, 0x00000440),
			SetMemory(0x58DC64, Add, 0x00000040),
			SetMemory(0x58DC6C, Add, 0x00000080),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFC00),
			SetMemory(0x58DC68, Add, 0xFFFFFBC0),
			SetMemory(0x58DC64, Add, 0xFFFFFFC0),
			SetMemory(0x58DC6C, Add, 0xFFFFFF80),
			SetMemory(0x58DC60, Add, 0x000003A0),
			SetMemory(0x58DC68, Add, 0x000003E0),
			SetMemory(0x58DC64, Add, 0x00000070),
			SetMemory(0x58DC6C, Add, 0x000000B0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFC60),
			SetMemory(0x58DC68, Add, 0xFFFFFC20),
			SetMemory(0x58DC64, Add, 0xFFFFFF90),
			SetMemory(0x58DC6C, Add, 0xFFFFFF50),
			SetMemory(0x58DC60, Add, 0x00000340),
			SetMemory(0x58DC68, Add, 0x00000380),
			SetMemory(0x58DC64, Add, 0x000000A0),
			SetMemory(0x58DC6C, Add, 0x000000E0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFCC0),
			SetMemory(0x58DC68, Add, 0xFFFFFC80),
			SetMemory(0x58DC64, Add, 0xFFFFFF60),
			SetMemory(0x58DC6C, Add, 0xFFFFFF20),
			SetMemory(0x58DC60, Add, 0x000002E0),
			SetMemory(0x58DC68, Add, 0x00000320),
			SetMemory(0x58DC64, Add, 0x000000D0),
			SetMemory(0x58DC6C, Add, 0x00000110),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD20),
			SetMemory(0x58DC68, Add, 0xFFFFFCE0),
			SetMemory(0x58DC64, Add, 0xFFFFFF30),
			SetMemory(0x58DC6C, Add, 0xFFFFFEF0),
			SetMemory(0x58DC60, Add, 0x00000280),
			SetMemory(0x58DC68, Add, 0x000002C0),
			SetMemory(0x58DC64, Add, 0x00000100),
			SetMemory(0x58DC6C, Add, 0x00000140),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFD80),
			SetMemory(0x58DC68, Add, 0xFFFFFD40),
			SetMemory(0x58DC64, Add, 0xFFFFFF00),
			SetMemory(0x58DC6C, Add, 0xFFFFFEC0),
			SetMemory(0x58DC60, Add, 0x00000220),
			SetMemory(0x58DC68, Add, 0x00000260),
			SetMemory(0x58DC64, Add, 0x00000130),
			SetMemory(0x58DC6C, Add, 0x00000170),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFDE0),
			SetMemory(0x58DC68, Add, 0xFFFFFDA0),
			SetMemory(0x58DC64, Add, 0xFFFFFED0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE90),
			SetMemory(0x58DC60, Add, 0x000001C0),
			SetMemory(0x58DC68, Add, 0x00000200),
			SetMemory(0x58DC64, Add, 0x00000160),
			SetMemory(0x58DC6C, Add, 0x000001A0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFE40),
			SetMemory(0x58DC68, Add, 0xFFFFFE00),
			SetMemory(0x58DC64, Add, 0xFFFFFEA0),
			SetMemory(0x58DC6C, Add, 0xFFFFFE60),
			SetMemory(0x58DC60, Add, 0x00000160),
			SetMemory(0x58DC68, Add, 0x000001A0),
			SetMemory(0x58DC64, Add, 0x00000190),
			SetMemory(0x58DC6C, Add, 0x000001D0),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFEA0),
			SetMemory(0x58DC68, Add, 0xFFFFFE60),
			SetMemory(0x58DC64, Add, 0xFFFFFE70),
			SetMemory(0x58DC6C, Add, 0xFFFFFE30),
			SetMemory(0x58DC60, Add, 0x00000100),
			SetMemory(0x58DC68, Add, 0x00000140),
			SetMemory(0x58DC64, Add, 0x000001C0),
			SetMemory(0x58DC6C, Add, 0x00000200),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF00),
			SetMemory(0x58DC68, Add, 0xFFFFFEC0),
			SetMemory(0x58DC64, Add, 0xFFFFFE40),
			SetMemory(0x58DC6C, Add, 0xFFFFFE00),
			SetMemory(0x58DC60, Add, 0x000000A0),
			SetMemory(0x58DC68, Add, 0x000000E0),
			SetMemory(0x58DC64, Add, 0x000001F0),
			SetMemory(0x58DC6C, Add, 0x00000230),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFF60),
			SetMemory(0x58DC68, Add, 0xFFFFFF20),
			SetMemory(0x58DC64, Add, 0xFFFFFE10),
			SetMemory(0x58DC6C, Add, 0xFFFFFDD0),
			SetMemory(0x58DC60, Add, 0x00000040),
			SetMemory(0x58DC68, Add, 0x00000080),
			SetMemory(0x58DC64, Add, 0x00000220),
			SetMemory(0x58DC6C, Add, 0x00000260),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFC0),
			SetMemory(0x58DC68, Add, 0xFFFFFF80),
			SetMemory(0x58DC64, Add, 0xFFFFFDE0),
			SetMemory(0x58DC6C, Add, 0xFFFFFDA0),
			SetMemory(0x58DC60, Add, 0xFFFFFFE1),
			SetMemory(0x58DC68, Add, 0x00000020),
			SetMemory(0x58DC64, Add, 0x00000250),
			SetMemory(0x58DC6C, Add, 0x00000290),
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000001F),
			SetMemory(0x58DC68, Add, 0xFFFFFFE0),
			SetMemory(0x58DC64, Add, 0xFFFFFDB0),
			SetMemory(0x58DC6C, Add, 0xFFFFFD70),
		})
	SetCallEnd()
	
	CereZergShape = SetNextForward()
	SetCall(FP)
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFBF);
			SetMemory(0x58DC68, Add, 0xFFFFFFFF);
			SetMemory(0x58DC64, Add, 0x00000001);
			SetMemory(0x58DC6C, Add, 0x00000041);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000041);
			SetMemory(0x58DC68, Add, 0x00000001);
			SetMemory(0x58DC64, Add, 0xFFFFFFFF);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBF);
			SetMemory(0x58DC60, Add, 0xFFFFFFB0);
			SetMemory(0x58DC68, Add, 0xFFFFFFF0);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000050);
			SetMemory(0x58DC68, Add, 0x00000010);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFFBF);
			SetMemory(0x58DC68, Add, 0xFFFFFFFF);
			SetMemory(0x58DC64, Add, 0xFFFFFFBF);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFF);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000041);
			SetMemory(0x58DC68, Add, 0x00000001);
			SetMemory(0x58DC64, Add, 0x00000041);
			SetMemory(0x58DC6C, Add, 0x00000001);
			SetMemory(0x58DC60, Add, 0xFFFFFFBC);
			SetMemory(0x58DC68, Add, 0xFFFFFFFC);
			SetMemory(0x58DC64, Add, 0x00000038);
			SetMemory(0x58DC6C, Add, 0x00000078);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000044);
			SetMemory(0x58DC68, Add, 0x00000004);
			SetMemory(0x58DC64, Add, 0xFFFFFFC8);
			SetMemory(0x58DC6C, Add, 0xFFFFFF88);
			SetMemory(0x58DC60, Add, 0xFFFFFF9D);
			SetMemory(0x58DC68, Add, 0xFFFFFFDD);
			SetMemory(0x58DC64, Add, 0x00000023);
			SetMemory(0x58DC6C, Add, 0x00000063);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000063);
			SetMemory(0x58DC68, Add, 0x00000023);
			SetMemory(0x58DC64, Add, 0xFFFFFFDD);
			SetMemory(0x58DC6C, Add, 0xFFFFFF9D);
			SetMemory(0x58DC60, Add, 0xFFFFFF88);
			SetMemory(0x58DC68, Add, 0xFFFFFFC8);
			SetMemory(0x58DC64, Add, 0x00000004);
			SetMemory(0x58DC6C, Add, 0x00000044);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000078);
			SetMemory(0x58DC68, Add, 0x00000038);
			SetMemory(0x58DC64, Add, 0xFFFFFFFC);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBC);
			SetMemory(0x58DC60, Add, 0xFFFFFF80);
			SetMemory(0x58DC68, Add, 0xFFFFFFC0);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000080);
			SetMemory(0x58DC68, Add, 0x00000040);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF88);
			SetMemory(0x58DC68, Add, 0xFFFFFFC8);
			SetMemory(0x58DC64, Add, 0xFFFFFFBC);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFC);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000078);
			SetMemory(0x58DC68, Add, 0x00000038);
			SetMemory(0x58DC64, Add, 0x00000044);
			SetMemory(0x58DC6C, Add, 0x00000004);
			SetMemory(0x58DC60, Add, 0xFFFFFF9D);
			SetMemory(0x58DC68, Add, 0xFFFFFFDD);
			SetMemory(0x58DC64, Add, 0xFFFFFF9D);
			SetMemory(0x58DC6C, Add, 0xFFFFFFDD);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000063);
			SetMemory(0x58DC68, Add, 0x00000023);
			SetMemory(0x58DC64, Add, 0x00000063);
			SetMemory(0x58DC6C, Add, 0x00000023);
			SetMemory(0x58DC60, Add, 0xFFFFFFBC);
			SetMemory(0x58DC68, Add, 0xFFFFFFFC);
			SetMemory(0x58DC64, Add, 0xFFFFFF88);
			SetMemory(0x58DC6C, Add, 0xFFFFFFC8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000044);
			SetMemory(0x58DC68, Add, 0x00000004);
			SetMemory(0x58DC64, Add, 0x00000078);
			SetMemory(0x58DC6C, Add, 0x00000038);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0x0000006B);
			SetMemory(0x58DC6C, Add, 0x000000AB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0xFFFFFF95);
			SetMemory(0x58DC6C, Add, 0xFFFFFF55);
			SetMemory(0x58DC60, Add, 0xFFFFFF99);
			SetMemory(0x58DC68, Add, 0xFFFFFFD9);
			SetMemory(0x58DC64, Add, 0x0000005C);
			SetMemory(0x58DC6C, Add, 0x0000009C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000067);
			SetMemory(0x58DC68, Add, 0x00000027);
			SetMemory(0x58DC64, Add, 0xFFFFFFA4);
			SetMemory(0x58DC6C, Add, 0xFFFFFF64);
			SetMemory(0x58DC60, Add, 0xFFFFFF7B);
			SetMemory(0x58DC68, Add, 0xFFFFFFBB);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000085);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000085);
			SetMemory(0x58DC68, Add, 0x00000045);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFF7B);
			SetMemory(0x58DC60, Add, 0xFFFFFF64);
			SetMemory(0x58DC68, Add, 0xFFFFFFA4);
			SetMemory(0x58DC64, Add, 0x00000027);
			SetMemory(0x58DC6C, Add, 0x00000067);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000009C);
			SetMemory(0x58DC68, Add, 0x0000005C);
			SetMemory(0x58DC64, Add, 0xFFFFFFD9);
			SetMemory(0x58DC6C, Add, 0xFFFFFF99);
			SetMemory(0x58DC60, Add, 0xFFFFFF55);
			SetMemory(0x58DC68, Add, 0xFFFFFF95);
			SetMemory(0x58DC64, Add, 0x00000005);
			SetMemory(0x58DC6C, Add, 0x00000045);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000AB);
			SetMemory(0x58DC68, Add, 0x0000006B);
			SetMemory(0x58DC64, Add, 0xFFFFFFFB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			SetMemory(0x58DC60, Add, 0xFFFFFF50);
			SetMemory(0x58DC68, Add, 0xFFFFFF90);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B0);
			SetMemory(0x58DC68, Add, 0x00000070);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF55);
			SetMemory(0x58DC68, Add, 0xFFFFFF95);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000AB);
			SetMemory(0x58DC68, Add, 0x0000006B);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000005);
			SetMemory(0x58DC60, Add, 0xFFFFFF64);
			SetMemory(0x58DC68, Add, 0xFFFFFFA4);
			SetMemory(0x58DC64, Add, 0xFFFFFF98);
			SetMemory(0x58DC6C, Add, 0xFFFFFFD8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000009C);
			SetMemory(0x58DC68, Add, 0x0000005C);
			SetMemory(0x58DC64, Add, 0x00000068);
			SetMemory(0x58DC6C, Add, 0x00000028);
			SetMemory(0x58DC60, Add, 0xFFFFFF7B);
			SetMemory(0x58DC68, Add, 0xFFFFFFBB);
			SetMemory(0x58DC64, Add, 0xFFFFFF7B);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000085);
			SetMemory(0x58DC68, Add, 0x00000045);
			SetMemory(0x58DC64, Add, 0x00000085);
			SetMemory(0x58DC6C, Add, 0x00000045);
			SetMemory(0x58DC60, Add, 0xFFFFFF98);
			SetMemory(0x58DC68, Add, 0xFFFFFFD8);
			SetMemory(0x58DC64, Add, 0xFFFFFF64);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA4);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000068);
			SetMemory(0x58DC68, Add, 0x00000028);
			SetMemory(0x58DC64, Add, 0x0000009C);
			SetMemory(0x58DC6C, Add, 0x0000005C);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0xFFFFFF55);
			SetMemory(0x58DC6C, Add, 0xFFFFFF95);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0x000000AB);
			SetMemory(0x58DC6C, Add, 0x0000006B);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0x0000009C);
			SetMemory(0x58DC6C, Add, 0x000000DC);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0xFFFFFF64);
			SetMemory(0x58DC6C, Add, 0xFFFFFF24);
			SetMemory(0x58DC60, Add, 0xFFFFFF97);
			SetMemory(0x58DC68, Add, 0xFFFFFFD7);
			SetMemory(0x58DC64, Add, 0x00000091);
			SetMemory(0x58DC6C, Add, 0x000000D1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000069);
			SetMemory(0x58DC68, Add, 0x00000029);
			SetMemory(0x58DC64, Add, 0xFFFFFF6F);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2F);
			SetMemory(0x58DC60, Add, 0xFFFFFF76);
			SetMemory(0x58DC68, Add, 0xFFFFFFB6);
			SetMemory(0x58DC64, Add, 0x0000007F);
			SetMemory(0x58DC6C, Add, 0x000000BF);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008A);
			SetMemory(0x58DC68, Add, 0x0000004A);
			SetMemory(0x58DC64, Add, 0xFFFFFF81);
			SetMemory(0x58DC6C, Add, 0xFFFFFF41);
			SetMemory(0x58DC60, Add, 0xFFFFFF59);
			SetMemory(0x58DC68, Add, 0xFFFFFF99);
			SetMemory(0x58DC64, Add, 0x00000067);
			SetMemory(0x58DC6C, Add, 0x000000A7);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A7);
			SetMemory(0x58DC68, Add, 0x00000067);
			SetMemory(0x58DC64, Add, 0xFFFFFF99);
			SetMemory(0x58DC6C, Add, 0xFFFFFF59);
			SetMemory(0x58DC60, Add, 0xFFFFFF41);
			SetMemory(0x58DC68, Add, 0xFFFFFF81);
			SetMemory(0x58DC64, Add, 0x0000004A);
			SetMemory(0x58DC6C, Add, 0x0000008A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000BF);
			SetMemory(0x58DC68, Add, 0x0000007F);
			SetMemory(0x58DC64, Add, 0xFFFFFFB6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF76);
			SetMemory(0x58DC60, Add, 0xFFFFFF2F);
			SetMemory(0x58DC68, Add, 0xFFFFFF6F);
			SetMemory(0x58DC64, Add, 0x00000029);
			SetMemory(0x58DC6C, Add, 0x00000069);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D1);
			SetMemory(0x58DC68, Add, 0x00000091);
			SetMemory(0x58DC64, Add, 0xFFFFFFD7);
			SetMemory(0x58DC6C, Add, 0xFFFFFF97);
			SetMemory(0x58DC60, Add, 0xFFFFFF24);
			SetMemory(0x58DC68, Add, 0xFFFFFF64);
			SetMemory(0x58DC64, Add, 0x00000005);
			SetMemory(0x58DC6C, Add, 0x00000045);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000DC);
			SetMemory(0x58DC68, Add, 0x0000009C);
			SetMemory(0x58DC64, Add, 0xFFFFFFFB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			SetMemory(0x58DC60, Add, 0xFFFFFF20);
			SetMemory(0x58DC68, Add, 0xFFFFFF60);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000E0);
			SetMemory(0x58DC68, Add, 0x000000A0);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF24);
			SetMemory(0x58DC68, Add, 0xFFFFFF64);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000DC);
			SetMemory(0x58DC68, Add, 0x0000009C);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000005);
			SetMemory(0x58DC60, Add, 0xFFFFFF2F);
			SetMemory(0x58DC68, Add, 0xFFFFFF6F);
			SetMemory(0x58DC64, Add, 0xFFFFFF97);
			SetMemory(0x58DC6C, Add, 0xFFFFFFD7);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D1);
			SetMemory(0x58DC68, Add, 0x00000091);
			SetMemory(0x58DC64, Add, 0x00000069);
			SetMemory(0x58DC6C, Add, 0x00000029);
			SetMemory(0x58DC60, Add, 0xFFFFFF41);
			SetMemory(0x58DC68, Add, 0xFFFFFF81);
			SetMemory(0x58DC64, Add, 0xFFFFFF76);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000BF);
			SetMemory(0x58DC68, Add, 0x0000007F);
			SetMemory(0x58DC64, Add, 0x0000008A);
			SetMemory(0x58DC6C, Add, 0x0000004A);
			SetMemory(0x58DC60, Add, 0xFFFFFF59);
			SetMemory(0x58DC68, Add, 0xFFFFFF99);
			SetMemory(0x58DC64, Add, 0xFFFFFF59);
			SetMemory(0x58DC6C, Add, 0xFFFFFF99);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A7);
			SetMemory(0x58DC68, Add, 0x00000067);
			SetMemory(0x58DC64, Add, 0x000000A7);
			SetMemory(0x58DC6C, Add, 0x00000067);
			SetMemory(0x58DC60, Add, 0xFFFFFF76);
			SetMemory(0x58DC68, Add, 0xFFFFFFB6);
			SetMemory(0x58DC64, Add, 0xFFFFFF41);
			SetMemory(0x58DC6C, Add, 0xFFFFFF81);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008A);
			SetMemory(0x58DC68, Add, 0x0000004A);
			SetMemory(0x58DC64, Add, 0x000000BF);
			SetMemory(0x58DC6C, Add, 0x0000007F);
			SetMemory(0x58DC60, Add, 0xFFFFFF97);
			SetMemory(0x58DC68, Add, 0xFFFFFFD7);
			SetMemory(0x58DC64, Add, 0xFFFFFF2F);
			SetMemory(0x58DC6C, Add, 0xFFFFFF6F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000069);
			SetMemory(0x58DC68, Add, 0x00000029);
			SetMemory(0x58DC64, Add, 0x000000D1);
			SetMemory(0x58DC6C, Add, 0x00000091);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0xFFFFFF24);
			SetMemory(0x58DC6C, Add, 0xFFFFFF64);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0x000000DC);
			SetMemory(0x58DC6C, Add, 0x0000009C);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0x000000CD);
			SetMemory(0x58DC6C, Add, 0x0000010D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0xFFFFFF33);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF3);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0x000000C4);
			SetMemory(0x58DC6C, Add, 0x00000104);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0xFFFFFF3C);
			SetMemory(0x58DC6C, Add, 0xFFFFFEFC);
			SetMemory(0x58DC60, Add, 0xFFFFFF74);
			SetMemory(0x58DC68, Add, 0xFFFFFFB4);
			SetMemory(0x58DC64, Add, 0x000000B5);
			SetMemory(0x58DC6C, Add, 0x000000F5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008C);
			SetMemory(0x58DC68, Add, 0x0000004C);
			SetMemory(0x58DC64, Add, 0xFFFFFF4B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF0B);
			SetMemory(0x58DC60, Add, 0xFFFFFF53);
			SetMemory(0x58DC68, Add, 0xFFFFFF93);
			SetMemory(0x58DC64, Add, 0x000000A2);
			SetMemory(0x58DC6C, Add, 0x000000E2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000AD);
			SetMemory(0x58DC68, Add, 0x0000006D);
			SetMemory(0x58DC64, Add, 0xFFFFFF5E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF1E);
			SetMemory(0x58DC60, Add, 0xFFFFFF37);
			SetMemory(0x58DC68, Add, 0xFFFFFF77);
			SetMemory(0x58DC64, Add, 0x00000089);
			SetMemory(0x58DC6C, Add, 0x000000C9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C9);
			SetMemory(0x58DC68, Add, 0x00000089);
			SetMemory(0x58DC64, Add, 0xFFFFFF77);
			SetMemory(0x58DC6C, Add, 0xFFFFFF37);
			SetMemory(0x58DC60, Add, 0xFFFFFF1E);
			SetMemory(0x58DC68, Add, 0xFFFFFF5E);
			SetMemory(0x58DC64, Add, 0x0000006D);
			SetMemory(0x58DC6C, Add, 0x000000AD);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000E2);
			SetMemory(0x58DC68, Add, 0x000000A2);
			SetMemory(0x58DC64, Add, 0xFFFFFF93);
			SetMemory(0x58DC6C, Add, 0xFFFFFF53);
			SetMemory(0x58DC60, Add, 0xFFFFFF0B);
			SetMemory(0x58DC68, Add, 0xFFFFFF4B);
			SetMemory(0x58DC64, Add, 0x0000004C);
			SetMemory(0x58DC6C, Add, 0x0000008C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F5);
			SetMemory(0x58DC68, Add, 0x000000B5);
			SetMemory(0x58DC64, Add, 0xFFFFFFB4);
			SetMemory(0x58DC6C, Add, 0xFFFFFF74);
			SetMemory(0x58DC60, Add, 0xFFFFFEFC);
			SetMemory(0x58DC68, Add, 0xFFFFFF3C);
			SetMemory(0x58DC64, Add, 0x0000002A);
			SetMemory(0x58DC6C, Add, 0x0000006A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000104);
			SetMemory(0x58DC68, Add, 0x000000C4);
			SetMemory(0x58DC64, Add, 0xFFFFFFD6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF96);
			SetMemory(0x58DC60, Add, 0xFFFFFEF3);
			SetMemory(0x58DC68, Add, 0xFFFFFF33);
			SetMemory(0x58DC64, Add, 0x00000005);
			SetMemory(0x58DC6C, Add, 0x00000045);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010D);
			SetMemory(0x58DC68, Add, 0x000000CD);
			SetMemory(0x58DC64, Add, 0xFFFFFFFB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			SetMemory(0x58DC60, Add, 0xFFFFFEF0);
			SetMemory(0x58DC68, Add, 0xFFFFFF30);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000110);
			SetMemory(0x58DC68, Add, 0x000000D0);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFEF3);
			SetMemory(0x58DC68, Add, 0xFFFFFF33);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010D);
			SetMemory(0x58DC68, Add, 0x000000CD);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000005);
			SetMemory(0x58DC60, Add, 0xFFFFFEFC);
			SetMemory(0x58DC68, Add, 0xFFFFFF3C);
			SetMemory(0x58DC64, Add, 0xFFFFFF96);
			SetMemory(0x58DC6C, Add, 0xFFFFFFD6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000104);
			SetMemory(0x58DC68, Add, 0x000000C4);
			SetMemory(0x58DC64, Add, 0x0000006A);
			SetMemory(0x58DC6C, Add, 0x0000002A);
			SetMemory(0x58DC60, Add, 0xFFFFFF0B);
			SetMemory(0x58DC68, Add, 0xFFFFFF4B);
			SetMemory(0x58DC64, Add, 0xFFFFFF74);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB4);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F5);
			SetMemory(0x58DC68, Add, 0x000000B5);
			SetMemory(0x58DC64, Add, 0x0000008C);
			SetMemory(0x58DC6C, Add, 0x0000004C);
			SetMemory(0x58DC60, Add, 0xFFFFFF1E);
			SetMemory(0x58DC68, Add, 0xFFFFFF5E);
			SetMemory(0x58DC64, Add, 0xFFFFFF53);
			SetMemory(0x58DC6C, Add, 0xFFFFFF93);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000E2);
			SetMemory(0x58DC68, Add, 0x000000A2);
			SetMemory(0x58DC64, Add, 0x000000AD);
			SetMemory(0x58DC6C, Add, 0x0000006D);
			SetMemory(0x58DC60, Add, 0xFFFFFF37);
			SetMemory(0x58DC68, Add, 0xFFFFFF77);
			SetMemory(0x58DC64, Add, 0xFFFFFF37);
			SetMemory(0x58DC6C, Add, 0xFFFFFF77);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C9);
			SetMemory(0x58DC68, Add, 0x00000089);
			SetMemory(0x58DC64, Add, 0x000000C9);
			SetMemory(0x58DC6C, Add, 0x00000089);
			SetMemory(0x58DC60, Add, 0xFFFFFF53);
			SetMemory(0x58DC68, Add, 0xFFFFFF93);
			SetMemory(0x58DC64, Add, 0xFFFFFF1E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF5E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000AD);
			SetMemory(0x58DC68, Add, 0x0000006D);
			SetMemory(0x58DC64, Add, 0x000000E2);
			SetMemory(0x58DC6C, Add, 0x000000A2);
			SetMemory(0x58DC60, Add, 0xFFFFFF74);
			SetMemory(0x58DC68, Add, 0xFFFFFFB4);
			SetMemory(0x58DC64, Add, 0xFFFFFF0B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF4B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008C);
			SetMemory(0x58DC68, Add, 0x0000004C);
			SetMemory(0x58DC64, Add, 0x000000F5);
			SetMemory(0x58DC6C, Add, 0x000000B5);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0xFFFFFEFC);
			SetMemory(0x58DC6C, Add, 0xFFFFFF3C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0x00000104);
			SetMemory(0x58DC6C, Add, 0x000000C4);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0xFFFFFEF3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF33);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0x0000010D);
			SetMemory(0x58DC6C, Add, 0x000000CD);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0x000000FD);
			SetMemory(0x58DC6C, Add, 0x0000013D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0xFFFFFF03);
			SetMemory(0x58DC6C, Add, 0xFFFFFEC3);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0x000000F6);
			SetMemory(0x58DC6C, Add, 0x00000136);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0xFFFFFF0A);
			SetMemory(0x58DC6C, Add, 0xFFFFFECA);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0x000000EA);
			SetMemory(0x58DC6C, Add, 0x0000012A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0xFFFFFF16);
			SetMemory(0x58DC6C, Add, 0xFFFFFED6);
			SetMemory(0x58DC60, Add, 0xFFFFFF51);
			SetMemory(0x58DC68, Add, 0xFFFFFF91);
			SetMemory(0x58DC64, Add, 0x000000D9);
			SetMemory(0x58DC6C, Add, 0x00000119);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000AF);
			SetMemory(0x58DC68, Add, 0x0000006F);
			SetMemory(0x58DC64, Add, 0xFFFFFF27);
			SetMemory(0x58DC6C, Add, 0xFFFFFEE7);
			SetMemory(0x58DC60, Add, 0xFFFFFF31);
			SetMemory(0x58DC68, Add, 0xFFFFFF71);
			SetMemory(0x58DC64, Add, 0x000000C4);
			SetMemory(0x58DC6C, Add, 0x00000104);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000CF);
			SetMemory(0x58DC68, Add, 0x0000008F);
			SetMemory(0x58DC64, Add, 0xFFFFFF3C);
			SetMemory(0x58DC6C, Add, 0xFFFFFEFC);
			SetMemory(0x58DC60, Add, 0xFFFFFF15);
			SetMemory(0x58DC68, Add, 0xFFFFFF55);
			SetMemory(0x58DC64, Add, 0x000000AB);
			SetMemory(0x58DC6C, Add, 0x000000EB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000EB);
			SetMemory(0x58DC68, Add, 0x000000AB);
			SetMemory(0x58DC64, Add, 0xFFFFFF55);
			SetMemory(0x58DC6C, Add, 0xFFFFFF15);
			SetMemory(0x58DC60, Add, 0xFFFFFEFC);
			SetMemory(0x58DC68, Add, 0xFFFFFF3C);
			SetMemory(0x58DC64, Add, 0x0000008F);
			SetMemory(0x58DC6C, Add, 0x000000CF);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000104);
			SetMemory(0x58DC68, Add, 0x000000C4);
			SetMemory(0x58DC64, Add, 0xFFFFFF71);
			SetMemory(0x58DC6C, Add, 0xFFFFFF31);
			SetMemory(0x58DC60, Add, 0xFFFFFEE7);
			SetMemory(0x58DC68, Add, 0xFFFFFF27);
			SetMemory(0x58DC64, Add, 0x0000006F);
			SetMemory(0x58DC6C, Add, 0x000000AF);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000119);
			SetMemory(0x58DC68, Add, 0x000000D9);
			SetMemory(0x58DC64, Add, 0xFFFFFF91);
			SetMemory(0x58DC6C, Add, 0xFFFFFF51);
			SetMemory(0x58DC60, Add, 0xFFFFFED6);
			SetMemory(0x58DC68, Add, 0xFFFFFF16);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000008E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012A);
			SetMemory(0x58DC68, Add, 0x000000EA);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFF72);
			SetMemory(0x58DC60, Add, 0xFFFFFECA);
			SetMemory(0x58DC68, Add, 0xFFFFFF0A);
			SetMemory(0x58DC64, Add, 0x0000002A);
			SetMemory(0x58DC6C, Add, 0x0000006A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000136);
			SetMemory(0x58DC68, Add, 0x000000F6);
			SetMemory(0x58DC64, Add, 0xFFFFFFD6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF96);
			SetMemory(0x58DC60, Add, 0xFFFFFEC3);
			SetMemory(0x58DC68, Add, 0xFFFFFF03);
			SetMemory(0x58DC64, Add, 0x00000005);
			SetMemory(0x58DC6C, Add, 0x00000045);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013D);
			SetMemory(0x58DC68, Add, 0x000000FD);
			SetMemory(0x58DC64, Add, 0xFFFFFFFB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			SetMemory(0x58DC60, Add, 0xFFFFFEC0);
			SetMemory(0x58DC68, Add, 0xFFFFFF00);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000140);
			SetMemory(0x58DC68, Add, 0x00000100);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFEC3);
			SetMemory(0x58DC68, Add, 0xFFFFFF03);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013D);
			SetMemory(0x58DC68, Add, 0x000000FD);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000005);
			SetMemory(0x58DC60, Add, 0xFFFFFECA);
			SetMemory(0x58DC68, Add, 0xFFFFFF0A);
			SetMemory(0x58DC64, Add, 0xFFFFFF96);
			SetMemory(0x58DC6C, Add, 0xFFFFFFD6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000136);
			SetMemory(0x58DC68, Add, 0x000000F6);
			SetMemory(0x58DC64, Add, 0x0000006A);
			SetMemory(0x58DC6C, Add, 0x0000002A);
			SetMemory(0x58DC60, Add, 0xFFFFFED6);
			SetMemory(0x58DC68, Add, 0xFFFFFF16);
			SetMemory(0x58DC64, Add, 0xFFFFFF72);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012A);
			SetMemory(0x58DC68, Add, 0x000000EA);
			SetMemory(0x58DC64, Add, 0x0000008E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			SetMemory(0x58DC60, Add, 0xFFFFFEE7);
			SetMemory(0x58DC68, Add, 0xFFFFFF27);
			SetMemory(0x58DC64, Add, 0xFFFFFF50);
			SetMemory(0x58DC6C, Add, 0xFFFFFF90);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000119);
			SetMemory(0x58DC68, Add, 0x000000D9);
			SetMemory(0x58DC64, Add, 0x000000B0);
			SetMemory(0x58DC6C, Add, 0x00000070);
			SetMemory(0x58DC60, Add, 0xFFFFFEFC);
			SetMemory(0x58DC68, Add, 0xFFFFFF3C);
			SetMemory(0x58DC64, Add, 0xFFFFFF31);
			SetMemory(0x58DC6C, Add, 0xFFFFFF71);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000104);
			SetMemory(0x58DC68, Add, 0x000000C4);
			SetMemory(0x58DC64, Add, 0x000000CF);
			SetMemory(0x58DC6C, Add, 0x0000008F);
			SetMemory(0x58DC60, Add, 0xFFFFFF15);
			SetMemory(0x58DC68, Add, 0xFFFFFF55);
			SetMemory(0x58DC64, Add, 0xFFFFFF15);
			SetMemory(0x58DC6C, Add, 0xFFFFFF55);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000EB);
			SetMemory(0x58DC68, Add, 0x000000AB);
			SetMemory(0x58DC64, Add, 0x000000EB);
			SetMemory(0x58DC6C, Add, 0x000000AB);
			SetMemory(0x58DC60, Add, 0xFFFFFF31);
			SetMemory(0x58DC68, Add, 0xFFFFFF71);
			SetMemory(0x58DC64, Add, 0xFFFFFEFC);
			SetMemory(0x58DC6C, Add, 0xFFFFFF3C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000CF);
			SetMemory(0x58DC68, Add, 0x0000008F);
			SetMemory(0x58DC64, Add, 0x00000104);
			SetMemory(0x58DC6C, Add, 0x000000C4);
			SetMemory(0x58DC60, Add, 0xFFFFFF50);
			SetMemory(0x58DC68, Add, 0xFFFFFF90);
			SetMemory(0x58DC64, Add, 0xFFFFFEE7);
			SetMemory(0x58DC6C, Add, 0xFFFFFF27);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B0);
			SetMemory(0x58DC68, Add, 0x00000070);
			SetMemory(0x58DC64, Add, 0x00000119);
			SetMemory(0x58DC6C, Add, 0x000000D9);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0xFFFFFED6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF16);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0x0000012A);
			SetMemory(0x58DC6C, Add, 0x000000EA);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0xFFFFFECA);
			SetMemory(0x58DC6C, Add, 0xFFFFFF0A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0x00000136);
			SetMemory(0x58DC6C, Add, 0x000000F6);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0xFFFFFEC3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF03);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0x0000013D);
			SetMemory(0x58DC6C, Add, 0x000000FD);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0x0000012D);
			SetMemory(0x58DC6C, Add, 0x0000016D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0xFFFFFED3);
			SetMemory(0x58DC6C, Add, 0xFFFFFE93);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0x00000127);
			SetMemory(0x58DC6C, Add, 0x00000167);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0xFFFFFED9);
			SetMemory(0x58DC6C, Add, 0xFFFFFE99);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0x0000011D);
			SetMemory(0x58DC6C, Add, 0x0000015D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0xFFFFFEE3);
			SetMemory(0x58DC6C, Add, 0xFFFFFEA3);
			SetMemory(0x58DC60, Add, 0xFFFFFF4F);
			SetMemory(0x58DC68, Add, 0xFFFFFF8F);
			SetMemory(0x58DC64, Add, 0x0000010E);
			SetMemory(0x58DC6C, Add, 0x0000014E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B1);
			SetMemory(0x58DC68, Add, 0x00000071);
			SetMemory(0x58DC64, Add, 0xFFFFFEF2);
			SetMemory(0x58DC6C, Add, 0xFFFFFEB2);
			SetMemory(0x58DC60, Add, 0xFFFFFF2E);
			SetMemory(0x58DC68, Add, 0xFFFFFF6E);
			SetMemory(0x58DC64, Add, 0x000000FC);
			SetMemory(0x58DC6C, Add, 0x0000013C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D2);
			SetMemory(0x58DC68, Add, 0x00000092);
			SetMemory(0x58DC64, Add, 0xFFFFFF04);
			SetMemory(0x58DC6C, Add, 0xFFFFFEC4);
			SetMemory(0x58DC60, Add, 0xFFFFFF0F);
			SetMemory(0x58DC68, Add, 0xFFFFFF4F);
			SetMemory(0x58DC64, Add, 0x000000E6);
			SetMemory(0x58DC6C, Add, 0x00000126);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F1);
			SetMemory(0x58DC68, Add, 0x000000B1);
			SetMemory(0x58DC64, Add, 0xFFFFFF1A);
			SetMemory(0x58DC6C, Add, 0xFFFFFEDA);
			SetMemory(0x58DC60, Add, 0xFFFFFEF3);
			SetMemory(0x58DC68, Add, 0xFFFFFF33);
			SetMemory(0x58DC64, Add, 0x000000CD);
			SetMemory(0x58DC6C, Add, 0x0000010D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010D);
			SetMemory(0x58DC68, Add, 0x000000CD);
			SetMemory(0x58DC64, Add, 0xFFFFFF33);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF3);
			SetMemory(0x58DC60, Add, 0xFFFFFEDA);
			SetMemory(0x58DC68, Add, 0xFFFFFF1A);
			SetMemory(0x58DC64, Add, 0x000000B1);
			SetMemory(0x58DC6C, Add, 0x000000F1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000126);
			SetMemory(0x58DC68, Add, 0x000000E6);
			SetMemory(0x58DC64, Add, 0xFFFFFF4F);
			SetMemory(0x58DC6C, Add, 0xFFFFFF0F);
			SetMemory(0x58DC60, Add, 0xFFFFFEC4);
			SetMemory(0x58DC68, Add, 0xFFFFFF04);
			SetMemory(0x58DC64, Add, 0x00000092);
			SetMemory(0x58DC6C, Add, 0x000000D2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013C);
			SetMemory(0x58DC68, Add, 0x000000FC);
			SetMemory(0x58DC64, Add, 0xFFFFFF6E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2E);
			SetMemory(0x58DC60, Add, 0xFFFFFEB2);
			SetMemory(0x58DC68, Add, 0xFFFFFEF2);
			SetMemory(0x58DC64, Add, 0x00000071);
			SetMemory(0x58DC6C, Add, 0x000000B1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000014E);
			SetMemory(0x58DC68, Add, 0x0000010E);
			SetMemory(0x58DC64, Add, 0xFFFFFF8F);
			SetMemory(0x58DC6C, Add, 0xFFFFFF4F);
			SetMemory(0x58DC60, Add, 0xFFFFFEA3);
			SetMemory(0x58DC68, Add, 0xFFFFFEE3);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000008E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000015D);
			SetMemory(0x58DC68, Add, 0x0000011D);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFF72);
			SetMemory(0x58DC60, Add, 0xFFFFFE99);
			SetMemory(0x58DC68, Add, 0xFFFFFED9);
			SetMemory(0x58DC64, Add, 0x0000002A);
			SetMemory(0x58DC6C, Add, 0x0000006A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000167);
			SetMemory(0x58DC68, Add, 0x00000127);
			SetMemory(0x58DC64, Add, 0xFFFFFFD6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF96);
			SetMemory(0x58DC60, Add, 0xFFFFFE93);
			SetMemory(0x58DC68, Add, 0xFFFFFED3);
			SetMemory(0x58DC64, Add, 0x00000005);
			SetMemory(0x58DC6C, Add, 0x00000045);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000016D);
			SetMemory(0x58DC68, Add, 0x0000012D);
			SetMemory(0x58DC64, Add, 0xFFFFFFFB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			SetMemory(0x58DC60, Add, 0xFFFFFE90);
			SetMemory(0x58DC68, Add, 0xFFFFFED0);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000170);
			SetMemory(0x58DC68, Add, 0x00000130);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFE93);
			SetMemory(0x58DC68, Add, 0xFFFFFED3);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000016D);
			SetMemory(0x58DC68, Add, 0x0000012D);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000005);
			SetMemory(0x58DC60, Add, 0xFFFFFE99);
			SetMemory(0x58DC68, Add, 0xFFFFFED9);
			SetMemory(0x58DC64, Add, 0xFFFFFF96);
			SetMemory(0x58DC6C, Add, 0xFFFFFFD6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000167);
			SetMemory(0x58DC68, Add, 0x00000127);
			SetMemory(0x58DC64, Add, 0x0000006A);
			SetMemory(0x58DC6C, Add, 0x0000002A);
			SetMemory(0x58DC60, Add, 0xFFFFFEA3);
			SetMemory(0x58DC68, Add, 0xFFFFFEE3);
			SetMemory(0x58DC64, Add, 0xFFFFFF72);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000015D);
			SetMemory(0x58DC68, Add, 0x0000011D);
			SetMemory(0x58DC64, Add, 0x0000008E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			SetMemory(0x58DC60, Add, 0xFFFFFEB2);
			SetMemory(0x58DC68, Add, 0xFFFFFEF2);
			SetMemory(0x58DC64, Add, 0xFFFFFF4F);
			SetMemory(0x58DC6C, Add, 0xFFFFFF8F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000014E);
			SetMemory(0x58DC68, Add, 0x0000010E);
			SetMemory(0x58DC64, Add, 0x000000B1);
			SetMemory(0x58DC6C, Add, 0x00000071);
			SetMemory(0x58DC60, Add, 0xFFFFFEC4);
			SetMemory(0x58DC68, Add, 0xFFFFFF04);
			SetMemory(0x58DC64, Add, 0xFFFFFF2E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF6E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013C);
			SetMemory(0x58DC68, Add, 0x000000FC);
			SetMemory(0x58DC64, Add, 0x000000D2);
			SetMemory(0x58DC6C, Add, 0x00000092);
			SetMemory(0x58DC60, Add, 0xFFFFFEDA);
			SetMemory(0x58DC68, Add, 0xFFFFFF1A);
			SetMemory(0x58DC64, Add, 0xFFFFFF0F);
			SetMemory(0x58DC6C, Add, 0xFFFFFF4F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000126);
			SetMemory(0x58DC68, Add, 0x000000E6);
			SetMemory(0x58DC64, Add, 0x000000F1);
			SetMemory(0x58DC6C, Add, 0x000000B1);
			SetMemory(0x58DC60, Add, 0xFFFFFEF3);
			SetMemory(0x58DC68, Add, 0xFFFFFF33);
			SetMemory(0x58DC64, Add, 0xFFFFFEF3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF33);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010D);
			SetMemory(0x58DC68, Add, 0x000000CD);
			SetMemory(0x58DC64, Add, 0x0000010D);
			SetMemory(0x58DC6C, Add, 0x000000CD);
			SetMemory(0x58DC60, Add, 0xFFFFFF0F);
			SetMemory(0x58DC68, Add, 0xFFFFFF4F);
			SetMemory(0x58DC64, Add, 0xFFFFFEDA);
			SetMemory(0x58DC6C, Add, 0xFFFFFF1A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F1);
			SetMemory(0x58DC68, Add, 0x000000B1);
			SetMemory(0x58DC64, Add, 0x00000126);
			SetMemory(0x58DC6C, Add, 0x000000E6);
			SetMemory(0x58DC60, Add, 0xFFFFFF2E);
			SetMemory(0x58DC68, Add, 0xFFFFFF6E);
			SetMemory(0x58DC64, Add, 0xFFFFFEC4);
			SetMemory(0x58DC6C, Add, 0xFFFFFF04);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D2);
			SetMemory(0x58DC68, Add, 0x00000092);
			SetMemory(0x58DC64, Add, 0x0000013C);
			SetMemory(0x58DC6C, Add, 0x000000FC);
			SetMemory(0x58DC60, Add, 0xFFFFFF4F);
			SetMemory(0x58DC68, Add, 0xFFFFFF8F);
			SetMemory(0x58DC64, Add, 0xFFFFFEB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B1);
			SetMemory(0x58DC68, Add, 0x00000071);
			SetMemory(0x58DC64, Add, 0x0000014E);
			SetMemory(0x58DC6C, Add, 0x0000010E);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0xFFFFFEA3);
			SetMemory(0x58DC6C, Add, 0xFFFFFEE3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0x0000015D);
			SetMemory(0x58DC6C, Add, 0x0000011D);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0xFFFFFE99);
			SetMemory(0x58DC6C, Add, 0xFFFFFED9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0x00000167);
			SetMemory(0x58DC6C, Add, 0x00000127);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0xFFFFFE93);
			SetMemory(0x58DC6C, Add, 0xFFFFFED3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0x0000016D);
			SetMemory(0x58DC6C, Add, 0x0000012D);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0x0000015E);
			SetMemory(0x58DC6C, Add, 0x0000019E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0xFFFFFEA2);
			SetMemory(0x58DC6C, Add, 0xFFFFFE62);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0x00000158);
			SetMemory(0x58DC6C, Add, 0x00000198);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0xFFFFFEA8);
			SetMemory(0x58DC6C, Add, 0xFFFFFE68);
			SetMemory(0x58DC60, Add, 0xFFFFFF71);
			SetMemory(0x58DC68, Add, 0xFFFFFFB1);
			SetMemory(0x58DC64, Add, 0x0000014F);
			SetMemory(0x58DC6C, Add, 0x0000018F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008F);
			SetMemory(0x58DC68, Add, 0x0000004F);
			SetMemory(0x58DC64, Add, 0xFFFFFEB1);
			SetMemory(0x58DC6C, Add, 0xFFFFFE71);
			SetMemory(0x58DC60, Add, 0xFFFFFF4E);
			SetMemory(0x58DC68, Add, 0xFFFFFF8E);
			SetMemory(0x58DC64, Add, 0x00000142);
			SetMemory(0x58DC6C, Add, 0x00000182);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B2);
			SetMemory(0x58DC68, Add, 0x00000072);
			SetMemory(0x58DC64, Add, 0xFFFFFEBE);
			SetMemory(0x58DC6C, Add, 0xFFFFFE7E);
			SetMemory(0x58DC60, Add, 0xFFFFFF2B);
			SetMemory(0x58DC68, Add, 0xFFFFFF6B);
			SetMemory(0x58DC64, Add, 0x00000132);
			SetMemory(0x58DC6C, Add, 0x00000172);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D5);
			SetMemory(0x58DC68, Add, 0x00000095);
			SetMemory(0x58DC64, Add, 0xFFFFFECE);
			SetMemory(0x58DC6C, Add, 0xFFFFFE8E);
			SetMemory(0x58DC60, Add, 0xFFFFFF0B);
			SetMemory(0x58DC68, Add, 0xFFFFFF4B);
			SetMemory(0x58DC64, Add, 0x0000011F);
			SetMemory(0x58DC6C, Add, 0x0000015F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F5);
			SetMemory(0x58DC68, Add, 0x000000B5);
			SetMemory(0x58DC64, Add, 0xFFFFFEE1);
			SetMemory(0x58DC6C, Add, 0xFFFFFEA1);
			SetMemory(0x58DC60, Add, 0xFFFFFEED);
			SetMemory(0x58DC68, Add, 0xFFFFFF2D);
			SetMemory(0x58DC64, Add, 0x00000108);
			SetMemory(0x58DC6C, Add, 0x00000148);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000113);
			SetMemory(0x58DC68, Add, 0x000000D3);
			SetMemory(0x58DC64, Add, 0xFFFFFEF8);
			SetMemory(0x58DC6C, Add, 0xFFFFFEB8);
			SetMemory(0x58DC60, Add, 0xFFFFFED1);
			SetMemory(0x58DC68, Add, 0xFFFFFF11);
			SetMemory(0x58DC64, Add, 0x000000EF);
			SetMemory(0x58DC6C, Add, 0x0000012F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012F);
			SetMemory(0x58DC68, Add, 0x000000EF);
			SetMemory(0x58DC64, Add, 0xFFFFFF11);
			SetMemory(0x58DC6C, Add, 0xFFFFFED1);
			SetMemory(0x58DC60, Add, 0xFFFFFEB8);
			SetMemory(0x58DC68, Add, 0xFFFFFEF8);
			SetMemory(0x58DC64, Add, 0x000000D3);
			SetMemory(0x58DC6C, Add, 0x00000113);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000148);
			SetMemory(0x58DC68, Add, 0x00000108);
			SetMemory(0x58DC64, Add, 0xFFFFFF2D);
			SetMemory(0x58DC6C, Add, 0xFFFFFEED);
			SetMemory(0x58DC60, Add, 0xFFFFFEA1);
			SetMemory(0x58DC68, Add, 0xFFFFFEE1);
			SetMemory(0x58DC64, Add, 0x000000B5);
			SetMemory(0x58DC6C, Add, 0x000000F5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000015F);
			SetMemory(0x58DC68, Add, 0x0000011F);
			SetMemory(0x58DC64, Add, 0xFFFFFF4B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF0B);
			SetMemory(0x58DC60, Add, 0xFFFFFE8E);
			SetMemory(0x58DC68, Add, 0xFFFFFECE);
			SetMemory(0x58DC64, Add, 0x00000095);
			SetMemory(0x58DC6C, Add, 0x000000D5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000172);
			SetMemory(0x58DC68, Add, 0x00000132);
			SetMemory(0x58DC64, Add, 0xFFFFFF6B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2B);
			SetMemory(0x58DC60, Add, 0xFFFFFE7E);
			SetMemory(0x58DC68, Add, 0xFFFFFEBE);
			SetMemory(0x58DC64, Add, 0x00000072);
			SetMemory(0x58DC6C, Add, 0x000000B2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000182);
			SetMemory(0x58DC68, Add, 0x00000142);
			SetMemory(0x58DC64, Add, 0xFFFFFF8E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF4E);
			SetMemory(0x58DC60, Add, 0xFFFFFE71);
			SetMemory(0x58DC68, Add, 0xFFFFFEB1);
			SetMemory(0x58DC64, Add, 0x0000004F);
			SetMemory(0x58DC6C, Add, 0x0000008F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000018F);
			SetMemory(0x58DC68, Add, 0x0000014F);
			SetMemory(0x58DC64, Add, 0xFFFFFFB1);
			SetMemory(0x58DC6C, Add, 0xFFFFFF71);
			SetMemory(0x58DC60, Add, 0xFFFFFE68);
			SetMemory(0x58DC68, Add, 0xFFFFFEA8);
			SetMemory(0x58DC64, Add, 0x0000002A);
			SetMemory(0x58DC6C, Add, 0x0000006A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000198);
			SetMemory(0x58DC68, Add, 0x00000158);
			SetMemory(0x58DC64, Add, 0xFFFFFFD6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF96);
			SetMemory(0x58DC60, Add, 0xFFFFFE62);
			SetMemory(0x58DC68, Add, 0xFFFFFEA2);
			SetMemory(0x58DC64, Add, 0x00000005);
			SetMemory(0x58DC6C, Add, 0x00000045);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000019E);
			SetMemory(0x58DC68, Add, 0x0000015E);
			SetMemory(0x58DC64, Add, 0xFFFFFFFB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			SetMemory(0x58DC60, Add, 0xFFFFFE60);
			SetMemory(0x58DC68, Add, 0xFFFFFEA0);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001A0);
			SetMemory(0x58DC68, Add, 0x00000160);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFE62);
			SetMemory(0x58DC68, Add, 0xFFFFFEA2);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFFFB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000019E);
			SetMemory(0x58DC68, Add, 0x0000015E);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000005);
			SetMemory(0x58DC60, Add, 0xFFFFFE68);
			SetMemory(0x58DC68, Add, 0xFFFFFEA8);
			SetMemory(0x58DC64, Add, 0xFFFFFF96);
			SetMemory(0x58DC6C, Add, 0xFFFFFFD6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000198);
			SetMemory(0x58DC68, Add, 0x00000158);
			SetMemory(0x58DC64, Add, 0x0000006A);
			SetMemory(0x58DC6C, Add, 0x0000002A);
			SetMemory(0x58DC60, Add, 0xFFFFFE71);
			SetMemory(0x58DC68, Add, 0xFFFFFEB1);
			SetMemory(0x58DC64, Add, 0xFFFFFF71);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000018F);
			SetMemory(0x58DC68, Add, 0x0000014F);
			SetMemory(0x58DC64, Add, 0x0000008F);
			SetMemory(0x58DC6C, Add, 0x0000004F);
			SetMemory(0x58DC60, Add, 0xFFFFFE7E);
			SetMemory(0x58DC68, Add, 0xFFFFFEBE);
			SetMemory(0x58DC64, Add, 0xFFFFFF4E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF8E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000182);
			SetMemory(0x58DC68, Add, 0x00000142);
			SetMemory(0x58DC64, Add, 0x000000B2);
			SetMemory(0x58DC6C, Add, 0x00000072);
			SetMemory(0x58DC60, Add, 0xFFFFFE8E);
			SetMemory(0x58DC68, Add, 0xFFFFFECE);
			SetMemory(0x58DC64, Add, 0xFFFFFF2B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF6B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000172);
			SetMemory(0x58DC68, Add, 0x00000132);
			SetMemory(0x58DC64, Add, 0x000000D5);
			SetMemory(0x58DC6C, Add, 0x00000095);
			SetMemory(0x58DC60, Add, 0xFFFFFEA1);
			SetMemory(0x58DC68, Add, 0xFFFFFEE1);
			SetMemory(0x58DC64, Add, 0xFFFFFF0B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF4B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000015F);
			SetMemory(0x58DC68, Add, 0x0000011F);
			SetMemory(0x58DC64, Add, 0x000000F5);
			SetMemory(0x58DC6C, Add, 0x000000B5);
			SetMemory(0x58DC60, Add, 0xFFFFFEB8);
			SetMemory(0x58DC68, Add, 0xFFFFFEF8);
			SetMemory(0x58DC64, Add, 0xFFFFFEED);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000148);
			SetMemory(0x58DC68, Add, 0x00000108);
			SetMemory(0x58DC64, Add, 0x00000113);
			SetMemory(0x58DC6C, Add, 0x000000D3);
			SetMemory(0x58DC60, Add, 0xFFFFFED1);
			SetMemory(0x58DC68, Add, 0xFFFFFF11);
			SetMemory(0x58DC64, Add, 0xFFFFFED1);
			SetMemory(0x58DC6C, Add, 0xFFFFFF11);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012F);
			SetMemory(0x58DC68, Add, 0x000000EF);
			SetMemory(0x58DC64, Add, 0x0000012F);
			SetMemory(0x58DC6C, Add, 0x000000EF);
			SetMemory(0x58DC60, Add, 0xFFFFFEED);
			SetMemory(0x58DC68, Add, 0xFFFFFF2D);
			SetMemory(0x58DC64, Add, 0xFFFFFEB8);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000113);
			SetMemory(0x58DC68, Add, 0x000000D3);
			SetMemory(0x58DC64, Add, 0x00000148);
			SetMemory(0x58DC6C, Add, 0x00000108);
			SetMemory(0x58DC60, Add, 0xFFFFFF0B);
			SetMemory(0x58DC68, Add, 0xFFFFFF4B);
			SetMemory(0x58DC64, Add, 0xFFFFFEA1);
			SetMemory(0x58DC6C, Add, 0xFFFFFEE1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F5);
			SetMemory(0x58DC68, Add, 0x000000B5);
			SetMemory(0x58DC64, Add, 0x0000015F);
			SetMemory(0x58DC6C, Add, 0x0000011F);
			SetMemory(0x58DC60, Add, 0xFFFFFF2B);
			SetMemory(0x58DC68, Add, 0xFFFFFF6B);
			SetMemory(0x58DC64, Add, 0xFFFFFE8E);
			SetMemory(0x58DC6C, Add, 0xFFFFFECE);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D5);
			SetMemory(0x58DC68, Add, 0x00000095);
			SetMemory(0x58DC64, Add, 0x00000172);
			SetMemory(0x58DC6C, Add, 0x00000132);
			SetMemory(0x58DC60, Add, 0xFFFFFF4E);
			SetMemory(0x58DC68, Add, 0xFFFFFF8E);
			SetMemory(0x58DC64, Add, 0xFFFFFE7E);
			SetMemory(0x58DC6C, Add, 0xFFFFFEBE);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B2);
			SetMemory(0x58DC68, Add, 0x00000072);
			SetMemory(0x58DC64, Add, 0x00000182);
			SetMemory(0x58DC6C, Add, 0x00000142);
			SetMemory(0x58DC60, Add, 0xFFFFFF71);
			SetMemory(0x58DC68, Add, 0xFFFFFFB1);
			SetMemory(0x58DC64, Add, 0xFFFFFE71);
			SetMemory(0x58DC6C, Add, 0xFFFFFEB1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008F);
			SetMemory(0x58DC68, Add, 0x0000004F);
			SetMemory(0x58DC64, Add, 0x0000018F);
			SetMemory(0x58DC6C, Add, 0x0000014F);
			SetMemory(0x58DC60, Add, 0xFFFFFF96);
			SetMemory(0x58DC68, Add, 0xFFFFFFD6);
			SetMemory(0x58DC64, Add, 0xFFFFFE68);
			SetMemory(0x58DC6C, Add, 0xFFFFFEA8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000006A);
			SetMemory(0x58DC68, Add, 0x0000002A);
			SetMemory(0x58DC64, Add, 0x00000198);
			SetMemory(0x58DC6C, Add, 0x00000158);
			SetMemory(0x58DC60, Add, 0xFFFFFFBB);
			SetMemory(0x58DC68, Add, 0xFFFFFFFB);
			SetMemory(0x58DC64, Add, 0xFFFFFE62);
			SetMemory(0x58DC6C, Add, 0xFFFFFEA2);
			Call_UnitIDVOvr
		})
	DoActions(FP,{
			SetMemory(0x58DC60, Add, 0x00000045);
			SetMemory(0x58DC68, Add, 0x00000005);
			SetMemory(0x58DC64, Add, 0x0000019E);
			SetMemory(0x58DC6C, Add, 0x0000015E);
		})
	
	SetCallEnd()
	CereEasyShape = SetNextForward()
	SetCall(FP)
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFA5);
			SetMemory(0x58DC68, Add, 0xFFFFFFE5);
			SetMemory(0x58DC64, Add, 0x0000001B);
			SetMemory(0x58DC6C, Add, 0x0000005B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000005B);
			SetMemory(0x58DC68, Add, 0x0000001B);
			SetMemory(0x58DC64, Add, 0xFFFFFFE5);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA5);
			SetMemory(0x58DC60, Add, 0xFFFFFF8C);
			SetMemory(0x58DC68, Add, 0xFFFFFFCC);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000074);
			SetMemory(0x58DC68, Add, 0x00000034);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFFA5);
			SetMemory(0x58DC68, Add, 0xFFFFFFE5);
			SetMemory(0x58DC64, Add, 0xFFFFFFA5);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000005B);
			SetMemory(0x58DC68, Add, 0x0000001B);
			SetMemory(0x58DC64, Add, 0x0000005B);
			SetMemory(0x58DC6C, Add, 0x0000001B);
			SetMemory(0x58DC60, Add, 0xFFFFFFA0);
			SetMemory(0x58DC68, Add, 0xFFFFFFE0);
			SetMemory(0x58DC64, Add, 0x0000007B);
			SetMemory(0x58DC6C, Add, 0x000000BB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000060);
			SetMemory(0x58DC68, Add, 0x00000020);
			SetMemory(0x58DC64, Add, 0xFFFFFF85);
			SetMemory(0x58DC6C, Add, 0xFFFFFF45);
			SetMemory(0x58DC60, Add, 0xFFFFFF6A);
			SetMemory(0x58DC68, Add, 0xFFFFFFAA);
			SetMemory(0x58DC64, Add, 0x00000056);
			SetMemory(0x58DC6C, Add, 0x00000096);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000096);
			SetMemory(0x58DC68, Add, 0x00000056);
			SetMemory(0x58DC64, Add, 0xFFFFFFAA);
			SetMemory(0x58DC6C, Add, 0xFFFFFF6A);
			SetMemory(0x58DC60, Add, 0xFFFFFF45);
			SetMemory(0x58DC68, Add, 0xFFFFFF85);
			SetMemory(0x58DC64, Add, 0x00000020);
			SetMemory(0x58DC6C, Add, 0x00000060);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000BB);
			SetMemory(0x58DC68, Add, 0x0000007B);
			SetMemory(0x58DC64, Add, 0xFFFFFFE0);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA0);
			SetMemory(0x58DC60, Add, 0xFFFFFF38);
			SetMemory(0x58DC68, Add, 0xFFFFFF78);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C8);
			SetMemory(0x58DC68, Add, 0x00000088);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF45);
			SetMemory(0x58DC68, Add, 0xFFFFFF85);
			SetMemory(0x58DC64, Add, 0xFFFFFFA0);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000BB);
			SetMemory(0x58DC68, Add, 0x0000007B);
			SetMemory(0x58DC64, Add, 0x00000060);
			SetMemory(0x58DC6C, Add, 0x00000020);
			SetMemory(0x58DC60, Add, 0xFFFFFF6A);
			SetMemory(0x58DC68, Add, 0xFFFFFFAA);
			SetMemory(0x58DC64, Add, 0xFFFFFF6A);
			SetMemory(0x58DC6C, Add, 0xFFFFFFAA);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000096);
			SetMemory(0x58DC68, Add, 0x00000056);
			SetMemory(0x58DC64, Add, 0x00000096);
			SetMemory(0x58DC6C, Add, 0x00000056);
			SetMemory(0x58DC60, Add, 0xFFFFFFA0);
			SetMemory(0x58DC68, Add, 0xFFFFFFE0);
			SetMemory(0x58DC64, Add, 0xFFFFFF45);
			SetMemory(0x58DC6C, Add, 0xFFFFFF85);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000060);
			SetMemory(0x58DC68, Add, 0x00000020);
			SetMemory(0x58DC64, Add, 0x000000BB);
			SetMemory(0x58DC6C, Add, 0x0000007B);
			SetMemory(0x58DC60, Add, 0xFFFFFF9F);
			SetMemory(0x58DC68, Add, 0xFFFFFFDF);
			SetMemory(0x58DC64, Add, 0x000000D3);
			SetMemory(0x58DC6C, Add, 0x00000113);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000061);
			SetMemory(0x58DC68, Add, 0x00000021);
			SetMemory(0x58DC64, Add, 0xFFFFFF2D);
			SetMemory(0x58DC6C, Add, 0xFFFFFEED);
			SetMemory(0x58DC60, Add, 0xFFFFFF63);
			SetMemory(0x58DC68, Add, 0xFFFFFFA3);
			SetMemory(0x58DC64, Add, 0x000000BA);
			SetMemory(0x58DC6C, Add, 0x000000FA);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000009D);
			SetMemory(0x58DC68, Add, 0x0000005D);
			SetMemory(0x58DC64, Add, 0xFFFFFF46);
			SetMemory(0x58DC6C, Add, 0xFFFFFF06);
			SetMemory(0x58DC60, Add, 0xFFFFFF2E);
			SetMemory(0x58DC68, Add, 0xFFFFFF6E);
			SetMemory(0x58DC64, Add, 0x00000092);
			SetMemory(0x58DC6C, Add, 0x000000D2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D2);
			SetMemory(0x58DC68, Add, 0x00000092);
			SetMemory(0x58DC64, Add, 0xFFFFFF6E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2E);
			SetMemory(0x58DC60, Add, 0xFFFFFF06);
			SetMemory(0x58DC68, Add, 0xFFFFFF46);
			SetMemory(0x58DC64, Add, 0x0000005D);
			SetMemory(0x58DC6C, Add, 0x0000009E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FA);
			SetMemory(0x58DC68, Add, 0x000000BA);
			SetMemory(0x58DC64, Add, 0xFFFFFFA3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF62);
			SetMemory(0x58DC60, Add, 0xFFFFFEED);
			SetMemory(0x58DC68, Add, 0xFFFFFF2D);
			SetMemory(0x58DC64, Add, 0x00000021);
			SetMemory(0x58DC6C, Add, 0x00000061);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000113);
			SetMemory(0x58DC68, Add, 0x000000D3);
			SetMemory(0x58DC64, Add, 0xFFFFFFDF);
			SetMemory(0x58DC6C, Add, 0xFFFFFF9F);
			SetMemory(0x58DC60, Add, 0xFFFFFEE4);
			SetMemory(0x58DC68, Add, 0xFFFFFF24);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000011C);
			SetMemory(0x58DC68, Add, 0x000000DC);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFEED);
			SetMemory(0x58DC68, Add, 0xFFFFFF2D);
			SetMemory(0x58DC64, Add, 0xFFFFFF9F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFDF);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000113);
			SetMemory(0x58DC68, Add, 0x000000D3);
			SetMemory(0x58DC64, Add, 0x00000061);
			SetMemory(0x58DC6C, Add, 0x00000021);
			SetMemory(0x58DC60, Add, 0xFFFFFF06);
			SetMemory(0x58DC68, Add, 0xFFFFFF46);
			SetMemory(0x58DC64, Add, 0xFFFFFF62);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FA);
			SetMemory(0x58DC68, Add, 0x000000BA);
			SetMemory(0x58DC64, Add, 0x0000009E);
			SetMemory(0x58DC6C, Add, 0x0000005E);
			SetMemory(0x58DC60, Add, 0xFFFFFF2E);
			SetMemory(0x58DC68, Add, 0xFFFFFF6E);
			SetMemory(0x58DC64, Add, 0xFFFFFF2E);
			SetMemory(0x58DC6C, Add, 0xFFFFFF6E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D2);
			SetMemory(0x58DC68, Add, 0x00000092);
			SetMemory(0x58DC64, Add, 0x000000D2);
			SetMemory(0x58DC6C, Add, 0x00000092);
			SetMemory(0x58DC60, Add, 0xFFFFFF62);
			SetMemory(0x58DC68, Add, 0xFFFFFFA2);
			SetMemory(0x58DC64, Add, 0xFFFFFF06);
			SetMemory(0x58DC6C, Add, 0xFFFFFF46);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000009E);
			SetMemory(0x58DC68, Add, 0x0000005E);
			SetMemory(0x58DC64, Add, 0x000000FA);
			SetMemory(0x58DC6C, Add, 0x000000BA);
			SetMemory(0x58DC60, Add, 0xFFFFFF9F);
			SetMemory(0x58DC68, Add, 0xFFFFFFDF);
			SetMemory(0x58DC64, Add, 0xFFFFFEED);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000061);
			SetMemory(0x58DC68, Add, 0x00000021);
			SetMemory(0x58DC64, Add, 0x00000113);
			SetMemory(0x58DC6C, Add, 0x000000D3);
			SetMemory(0x58DC60, Add, 0xFFFFFF9F);
			SetMemory(0x58DC68, Add, 0xFFFFFFDF);
			SetMemory(0x58DC64, Add, 0x00000129);
			SetMemory(0x58DC6C, Add, 0x00000169);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000061);
			SetMemory(0x58DC68, Add, 0x00000021);
			SetMemory(0x58DC64, Add, 0xFFFFFED7);
			SetMemory(0x58DC6C, Add, 0xFFFFFE97);
			SetMemory(0x58DC60, Add, 0xFFFFFF60);
			SetMemory(0x58DC68, Add, 0xFFFFFFA0);
			SetMemory(0x58DC64, Add, 0x00000116);
			SetMemory(0x58DC6C, Add, 0x00000156);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A0);
			SetMemory(0x58DC68, Add, 0x00000060);
			SetMemory(0x58DC64, Add, 0xFFFFFEEA);
			SetMemory(0x58DC6C, Add, 0xFFFFFEAA);
			SetMemory(0x58DC60, Add, 0xFFFFFF26);
			SetMemory(0x58DC68, Add, 0xFFFFFF66);
			SetMemory(0x58DC64, Add, 0x000000F7);
			SetMemory(0x58DC6C, Add, 0x00000137);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000DA);
			SetMemory(0x58DC68, Add, 0x0000009A);
			SetMemory(0x58DC64, Add, 0xFFFFFF09);
			SetMemory(0x58DC6C, Add, 0xFFFFFEC9);
			SetMemory(0x58DC60, Add, 0xFFFFFEF3);
			SetMemory(0x58DC68, Add, 0xFFFFFF33);
			SetMemory(0x58DC64, Add, 0x000000CD);
			SetMemory(0x58DC6C, Add, 0x0000010D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010D);
			SetMemory(0x58DC68, Add, 0x000000CD);
			SetMemory(0x58DC64, Add, 0xFFFFFF33);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF3);
			SetMemory(0x58DC60, Add, 0xFFFFFEC9);
			SetMemory(0x58DC68, Add, 0xFFFFFF09);
			SetMemory(0x58DC64, Add, 0x0000009A);
			SetMemory(0x58DC6C, Add, 0x000000DA);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000137);
			SetMemory(0x58DC68, Add, 0x000000F7);
			SetMemory(0x58DC64, Add, 0xFFFFFF66);
			SetMemory(0x58DC6C, Add, 0xFFFFFF26);
			SetMemory(0x58DC60, Add, 0xFFFFFEAA);
			SetMemory(0x58DC68, Add, 0xFFFFFEEA);
			SetMemory(0x58DC64, Add, 0x00000060);
			SetMemory(0x58DC6C, Add, 0x000000A0);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000156);
			SetMemory(0x58DC68, Add, 0x00000116);
			SetMemory(0x58DC64, Add, 0xFFFFFFA0);
			SetMemory(0x58DC6C, Add, 0xFFFFFF60);
			SetMemory(0x58DC60, Add, 0xFFFFFE97);
			SetMemory(0x58DC68, Add, 0xFFFFFED7);
			SetMemory(0x58DC64, Add, 0x00000021);
			SetMemory(0x58DC6C, Add, 0x00000061);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000169);
			SetMemory(0x58DC68, Add, 0x00000129);
			SetMemory(0x58DC64, Add, 0xFFFFFFDF);
			SetMemory(0x58DC6C, Add, 0xFFFFFF9F);
			SetMemory(0x58DC60, Add, 0xFFFFFE90);
			SetMemory(0x58DC68, Add, 0xFFFFFED0);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000170);
			SetMemory(0x58DC68, Add, 0x00000130);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFE97);
			SetMemory(0x58DC68, Add, 0xFFFFFED7);
			SetMemory(0x58DC64, Add, 0xFFFFFF9F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFDF);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000169);
			SetMemory(0x58DC68, Add, 0x00000129);
			SetMemory(0x58DC64, Add, 0x00000061);
			SetMemory(0x58DC6C, Add, 0x00000021);
			SetMemory(0x58DC60, Add, 0xFFFFFEAA);
			SetMemory(0x58DC68, Add, 0xFFFFFEEA);
			SetMemory(0x58DC64, Add, 0xFFFFFF60);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA0);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000156);
			SetMemory(0x58DC68, Add, 0x00000116);
			SetMemory(0x58DC64, Add, 0x000000A0);
			SetMemory(0x58DC6C, Add, 0x00000060);
			SetMemory(0x58DC60, Add, 0xFFFFFEC9);
			SetMemory(0x58DC68, Add, 0xFFFFFF09);
			SetMemory(0x58DC64, Add, 0xFFFFFF26);
			SetMemory(0x58DC6C, Add, 0xFFFFFF66);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000137);
			SetMemory(0x58DC68, Add, 0x000000F7);
			SetMemory(0x58DC64, Add, 0x000000DA);
			SetMemory(0x58DC6C, Add, 0x0000009A);
			SetMemory(0x58DC60, Add, 0xFFFFFEF3);
			SetMemory(0x58DC68, Add, 0xFFFFFF33);
			SetMemory(0x58DC64, Add, 0xFFFFFEF3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF33);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010D);
			SetMemory(0x58DC68, Add, 0x000000CD);
			SetMemory(0x58DC64, Add, 0x0000010D);
			SetMemory(0x58DC6C, Add, 0x000000CD);
			SetMemory(0x58DC60, Add, 0xFFFFFF26);
			SetMemory(0x58DC68, Add, 0xFFFFFF66);
			SetMemory(0x58DC64, Add, 0xFFFFFEC9);
			SetMemory(0x58DC6C, Add, 0xFFFFFF09);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000DA);
			SetMemory(0x58DC68, Add, 0x0000009A);
			SetMemory(0x58DC64, Add, 0x00000137);
			SetMemory(0x58DC6C, Add, 0x000000F7);
			SetMemory(0x58DC60, Add, 0xFFFFFF60);
			SetMemory(0x58DC68, Add, 0xFFFFFFA0);
			SetMemory(0x58DC64, Add, 0xFFFFFEAA);
			SetMemory(0x58DC6C, Add, 0xFFFFFEEA);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A0);
			SetMemory(0x58DC68, Add, 0x00000060);
			SetMemory(0x58DC64, Add, 0x00000156);
			SetMemory(0x58DC6C, Add, 0x00000116);
			SetMemory(0x58DC60, Add, 0xFFFFFF9F);
			SetMemory(0x58DC68, Add, 0xFFFFFFDF);
			SetMemory(0x58DC64, Add, 0xFFFFFE97);
			SetMemory(0x58DC6C, Add, 0xFFFFFED7);
			Call_UnitIDVOvr
		})
	DoActions(FP,{
			SetMemory(0x58DC60, Add, 0x00000061);
			SetMemory(0x58DC68, Add, 0x00000021);
			SetMemory(0x58DC64, Add, 0x00000169);
			SetMemory(0x58DC6C, Add, 0x00000129);
		})
	SetCallEnd()
	CereHardShape = SetNextForward()
	SetCall(FP)
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFAE);
			SetMemory(0x58DC68, Add, 0xFFFFFFEE);
			SetMemory(0x58DC64, Add, 0x00000012);
			SetMemory(0x58DC6C, Add, 0x00000052);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000052);
			SetMemory(0x58DC68, Add, 0x00000012);
			SetMemory(0x58DC64, Add, 0xFFFFFFEE);
			SetMemory(0x58DC6C, Add, 0xFFFFFFAE);
			SetMemory(0x58DC60, Add, 0xFFFFFF98);
			SetMemory(0x58DC68, Add, 0xFFFFFFD8);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000068);
			SetMemory(0x58DC68, Add, 0x00000028);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFFAE);
			SetMemory(0x58DC68, Add, 0xFFFFFFEE);
			SetMemory(0x58DC64, Add, 0xFFFFFFAE);
			SetMemory(0x58DC6C, Add, 0xFFFFFFEE);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000052);
			SetMemory(0x58DC68, Add, 0x00000012);
			SetMemory(0x58DC64, Add, 0x00000052);
			SetMemory(0x58DC6C, Add, 0x00000012);
			SetMemory(0x58DC60, Add, 0xFFFFFFA9);
			SetMemory(0x58DC68, Add, 0xFFFFFFE9);
			SetMemory(0x58DC64, Add, 0x00000065);
			SetMemory(0x58DC6C, Add, 0x000000A5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000057);
			SetMemory(0x58DC68, Add, 0x00000017);
			SetMemory(0x58DC64, Add, 0xFFFFFF9B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF5B);
			SetMemory(0x58DC60, Add, 0xFFFFFF7B);
			SetMemory(0x58DC68, Add, 0xFFFFFFBB);
			SetMemory(0x58DC64, Add, 0x00000045);
			SetMemory(0x58DC6C, Add, 0x00000085);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000085);
			SetMemory(0x58DC68, Add, 0x00000045);
			SetMemory(0x58DC64, Add, 0xFFFFFFBB);
			SetMemory(0x58DC6C, Add, 0xFFFFFF7B);
			SetMemory(0x58DC60, Add, 0xFFFFFF5B);
			SetMemory(0x58DC68, Add, 0xFFFFFF9B);
			SetMemory(0x58DC64, Add, 0x00000017);
			SetMemory(0x58DC6C, Add, 0x00000057);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A5);
			SetMemory(0x58DC68, Add, 0x00000065);
			SetMemory(0x58DC64, Add, 0xFFFFFFE9);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA9);
			SetMemory(0x58DC60, Add, 0xFFFFFF50);
			SetMemory(0x58DC68, Add, 0xFFFFFF90);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B0);
			SetMemory(0x58DC68, Add, 0x00000070);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF5B);
			SetMemory(0x58DC68, Add, 0xFFFFFF9B);
			SetMemory(0x58DC64, Add, 0xFFFFFFA9);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A5);
			SetMemory(0x58DC68, Add, 0x00000065);
			SetMemory(0x58DC64, Add, 0x00000057);
			SetMemory(0x58DC6C, Add, 0x00000017);
			SetMemory(0x58DC60, Add, 0xFFFFFF7B);
			SetMemory(0x58DC68, Add, 0xFFFFFFBB);
			SetMemory(0x58DC64, Add, 0xFFFFFF7B);
			SetMemory(0x58DC6C, Add, 0xFFFFFFBB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000085);
			SetMemory(0x58DC68, Add, 0x00000045);
			SetMemory(0x58DC64, Add, 0x00000085);
			SetMemory(0x58DC6C, Add, 0x00000045);
			SetMemory(0x58DC60, Add, 0xFFFFFFA9);
			SetMemory(0x58DC68, Add, 0xFFFFFFE9);
			SetMemory(0x58DC64, Add, 0xFFFFFF5B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF9B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000057);
			SetMemory(0x58DC68, Add, 0x00000017);
			SetMemory(0x58DC64, Add, 0x000000A5);
			SetMemory(0x58DC6C, Add, 0x00000065);
			SetMemory(0x58DC60, Add, 0xFFFFFFA9);
			SetMemory(0x58DC68, Add, 0xFFFFFFE9);
			SetMemory(0x58DC64, Add, 0x000000B0);
			SetMemory(0x58DC6C, Add, 0x000000F0);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000057);
			SetMemory(0x58DC68, Add, 0x00000017);
			SetMemory(0x58DC64, Add, 0xFFFFFF50);
			SetMemory(0x58DC6C, Add, 0xFFFFFF10);
			SetMemory(0x58DC60, Add, 0xFFFFFF75);
			SetMemory(0x58DC68, Add, 0xFFFFFFB5);
			SetMemory(0x58DC64, Add, 0x0000009B);
			SetMemory(0x58DC6C, Add, 0x000000DB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008B);
			SetMemory(0x58DC68, Add, 0x0000004B);
			SetMemory(0x58DC64, Add, 0xFFFFFF65);
			SetMemory(0x58DC6C, Add, 0xFFFFFF25);
			SetMemory(0x58DC60, Add, 0xFFFFFF48);
			SetMemory(0x58DC68, Add, 0xFFFFFF88);
			SetMemory(0x58DC64, Add, 0x00000078);
			SetMemory(0x58DC6C, Add, 0x000000B8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B8);
			SetMemory(0x58DC68, Add, 0x00000078);
			SetMemory(0x58DC64, Add, 0xFFFFFF88);
			SetMemory(0x58DC6C, Add, 0xFFFFFF48);
			SetMemory(0x58DC60, Add, 0xFFFFFF25);
			SetMemory(0x58DC68, Add, 0xFFFFFF65);
			SetMemory(0x58DC64, Add, 0x0000004B);
			SetMemory(0x58DC6C, Add, 0x0000008C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000DB);
			SetMemory(0x58DC68, Add, 0x0000009B);
			SetMemory(0x58DC64, Add, 0xFFFFFFB5);
			SetMemory(0x58DC6C, Add, 0xFFFFFF74);
			SetMemory(0x58DC60, Add, 0xFFFFFF10);
			SetMemory(0x58DC68, Add, 0xFFFFFF50);
			SetMemory(0x58DC64, Add, 0x00000017);
			SetMemory(0x58DC6C, Add, 0x00000057);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F0);
			SetMemory(0x58DC68, Add, 0x000000B0);
			SetMemory(0x58DC64, Add, 0xFFFFFFE9);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA9);
			SetMemory(0x58DC60, Add, 0xFFFFFF08);
			SetMemory(0x58DC68, Add, 0xFFFFFF48);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F8);
			SetMemory(0x58DC68, Add, 0x000000B8);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF10);
			SetMemory(0x58DC68, Add, 0xFFFFFF50);
			SetMemory(0x58DC64, Add, 0xFFFFFFA9);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F0);
			SetMemory(0x58DC68, Add, 0x000000B0);
			SetMemory(0x58DC64, Add, 0x00000057);
			SetMemory(0x58DC6C, Add, 0x00000017);
			SetMemory(0x58DC60, Add, 0xFFFFFF25);
			SetMemory(0x58DC68, Add, 0xFFFFFF65);
			SetMemory(0x58DC64, Add, 0xFFFFFF74);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB4);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000DB);
			SetMemory(0x58DC68, Add, 0x0000009B);
			SetMemory(0x58DC64, Add, 0x0000008C);
			SetMemory(0x58DC6C, Add, 0x0000004C);
			SetMemory(0x58DC60, Add, 0xFFFFFF48);
			SetMemory(0x58DC68, Add, 0xFFFFFF88);
			SetMemory(0x58DC64, Add, 0xFFFFFF48);
			SetMemory(0x58DC6C, Add, 0xFFFFFF88);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000B8);
			SetMemory(0x58DC68, Add, 0x00000078);
			SetMemory(0x58DC64, Add, 0x000000B8);
			SetMemory(0x58DC6C, Add, 0x00000078);
			SetMemory(0x58DC60, Add, 0xFFFFFF74);
			SetMemory(0x58DC68, Add, 0xFFFFFFB4);
			SetMemory(0x58DC64, Add, 0xFFFFFF25);
			SetMemory(0x58DC6C, Add, 0xFFFFFF65);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008C);
			SetMemory(0x58DC68, Add, 0x0000004C);
			SetMemory(0x58DC64, Add, 0x000000DB);
			SetMemory(0x58DC6C, Add, 0x0000009B);
			SetMemory(0x58DC60, Add, 0xFFFFFFA9);
			SetMemory(0x58DC68, Add, 0xFFFFFFE9);
			SetMemory(0x58DC64, Add, 0xFFFFFF10);
			SetMemory(0x58DC6C, Add, 0xFFFFFF50);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000057);
			SetMemory(0x58DC68, Add, 0x00000017);
			SetMemory(0x58DC64, Add, 0x000000F0);
			SetMemory(0x58DC6C, Add, 0x000000B0);
			SetMemory(0x58DC60, Add, 0xFFFFFFA8);
			SetMemory(0x58DC68, Add, 0xFFFFFFE8);
			SetMemory(0x58DC64, Add, 0x000000FA);
			SetMemory(0x58DC6C, Add, 0x0000013A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000058);
			SetMemory(0x58DC68, Add, 0x00000018);
			SetMemory(0x58DC64, Add, 0xFFFFFF06);
			SetMemory(0x58DC6C, Add, 0xFFFFFEC6);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0x000000EA);
			SetMemory(0x58DC6C, Add, 0x0000012A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0xFFFFFF16);
			SetMemory(0x58DC6C, Add, 0xFFFFFED6);
			SetMemory(0x58DC60, Add, 0xFFFFFF40);
			SetMemory(0x58DC68, Add, 0xFFFFFF80);
			SetMemory(0x58DC64, Add, 0x000000CF);
			SetMemory(0x58DC6C, Add, 0x0000010F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C0);
			SetMemory(0x58DC68, Add, 0x00000080);
			SetMemory(0x58DC64, Add, 0xFFFFFF31);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF1);
			SetMemory(0x58DC60, Add, 0xFFFFFF15);
			SetMemory(0x58DC68, Add, 0xFFFFFF55);
			SetMemory(0x58DC64, Add, 0x000000AB);
			SetMemory(0x58DC6C, Add, 0x000000EB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000EB);
			SetMemory(0x58DC68, Add, 0x000000AB);
			SetMemory(0x58DC64, Add, 0xFFFFFF55);
			SetMemory(0x58DC6C, Add, 0xFFFFFF15);
			SetMemory(0x58DC60, Add, 0xFFFFFEF1);
			SetMemory(0x58DC68, Add, 0xFFFFFF31);
			SetMemory(0x58DC64, Add, 0x00000080);
			SetMemory(0x58DC6C, Add, 0x000000C0);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010F);
			SetMemory(0x58DC68, Add, 0x000000CF);
			SetMemory(0x58DC64, Add, 0xFFFFFF80);
			SetMemory(0x58DC6C, Add, 0xFFFFFF40);
			SetMemory(0x58DC60, Add, 0xFFFFFED6);
			SetMemory(0x58DC68, Add, 0xFFFFFF16);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000008E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012A);
			SetMemory(0x58DC68, Add, 0x000000EA);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFF72);
			SetMemory(0x58DC60, Add, 0xFFFFFEC6);
			SetMemory(0x58DC68, Add, 0xFFFFFF06);
			SetMemory(0x58DC64, Add, 0x00000018);
			SetMemory(0x58DC6C, Add, 0x00000058);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013A);
			SetMemory(0x58DC68, Add, 0x000000FA);
			SetMemory(0x58DC64, Add, 0xFFFFFFE8);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA8);
			SetMemory(0x58DC60, Add, 0xFFFFFEC0);
			SetMemory(0x58DC68, Add, 0xFFFFFF00);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000140);
			SetMemory(0x58DC68, Add, 0x00000100);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFEC6);
			SetMemory(0x58DC68, Add, 0xFFFFFF06);
			SetMemory(0x58DC64, Add, 0xFFFFFFA8);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013A);
			SetMemory(0x58DC68, Add, 0x000000FA);
			SetMemory(0x58DC64, Add, 0x00000058);
			SetMemory(0x58DC6C, Add, 0x00000018);
			SetMemory(0x58DC60, Add, 0xFFFFFED6);
			SetMemory(0x58DC68, Add, 0xFFFFFF16);
			SetMemory(0x58DC64, Add, 0xFFFFFF72);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012A);
			SetMemory(0x58DC68, Add, 0x000000EA);
			SetMemory(0x58DC64, Add, 0x0000008E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			SetMemory(0x58DC60, Add, 0xFFFFFEF1);
			SetMemory(0x58DC68, Add, 0xFFFFFF31);
			SetMemory(0x58DC64, Add, 0xFFFFFF40);
			SetMemory(0x58DC6C, Add, 0xFFFFFF80);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010F);
			SetMemory(0x58DC68, Add, 0x000000CF);
			SetMemory(0x58DC64, Add, 0x000000C0);
			SetMemory(0x58DC6C, Add, 0x00000080);
			SetMemory(0x58DC60, Add, 0xFFFFFF15);
			SetMemory(0x58DC68, Add, 0xFFFFFF55);
			SetMemory(0x58DC64, Add, 0xFFFFFF15);
			SetMemory(0x58DC6C, Add, 0xFFFFFF55);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000EB);
			SetMemory(0x58DC68, Add, 0x000000AB);
			SetMemory(0x58DC64, Add, 0x000000EB);
			SetMemory(0x58DC6C, Add, 0x000000AB);
			SetMemory(0x58DC60, Add, 0xFFFFFF40);
			SetMemory(0x58DC68, Add, 0xFFFFFF80);
			SetMemory(0x58DC64, Add, 0xFFFFFEF1);
			SetMemory(0x58DC6C, Add, 0xFFFFFF31);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C0);
			SetMemory(0x58DC68, Add, 0x00000080);
			SetMemory(0x58DC64, Add, 0x0000010F);
			SetMemory(0x58DC6C, Add, 0x000000CF);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0xFFFFFED6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF16);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0x0000012A);
			SetMemory(0x58DC6C, Add, 0x000000EA);
			SetMemory(0x58DC60, Add, 0xFFFFFFA8);
			SetMemory(0x58DC68, Add, 0xFFFFFFE8);
			SetMemory(0x58DC64, Add, 0xFFFFFEC6);
			SetMemory(0x58DC6C, Add, 0xFFFFFF06);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000058);
			SetMemory(0x58DC68, Add, 0x00000018);
			SetMemory(0x58DC64, Add, 0x0000013A);
			SetMemory(0x58DC6C, Add, 0x000000FA);
			SetMemory(0x58DC60, Add, 0xFFFFFFA8);
			SetMemory(0x58DC68, Add, 0xFFFFFFE8);
			SetMemory(0x58DC64, Add, 0x00000143);
			SetMemory(0x58DC6C, Add, 0x00000183);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000058);
			SetMemory(0x58DC68, Add, 0x00000018);
			SetMemory(0x58DC64, Add, 0xFFFFFEBD);
			SetMemory(0x58DC6C, Add, 0xFFFFFE7D);
			SetMemory(0x58DC60, Add, 0xFFFFFF71);
			SetMemory(0x58DC68, Add, 0xFFFFFFB1);
			SetMemory(0x58DC64, Add, 0x00000136);
			SetMemory(0x58DC6C, Add, 0x00000176);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008F);
			SetMemory(0x58DC68, Add, 0x0000004F);
			SetMemory(0x58DC64, Add, 0xFFFFFECA);
			SetMemory(0x58DC6C, Add, 0xFFFFFE8A);
			SetMemory(0x58DC60, Add, 0xFFFFFF3D);
			SetMemory(0x58DC68, Add, 0xFFFFFF7D);
			SetMemory(0x58DC64, Add, 0x00000120);
			SetMemory(0x58DC6C, Add, 0x00000160);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C3);
			SetMemory(0x58DC68, Add, 0x00000083);
			SetMemory(0x58DC64, Add, 0xFFFFFEE0);
			SetMemory(0x58DC6C, Add, 0xFFFFFEA0);
			SetMemory(0x58DC60, Add, 0xFFFFFF0D);
			SetMemory(0x58DC68, Add, 0xFFFFFF4D);
			SetMemory(0x58DC64, Add, 0x00000103);
			SetMemory(0x58DC6C, Add, 0x00000143);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F3);
			SetMemory(0x58DC68, Add, 0x000000B3);
			SetMemory(0x58DC64, Add, 0xFFFFFEFD);
			SetMemory(0x58DC6C, Add, 0xFFFFFEBD);
			SetMemory(0x58DC60, Add, 0xFFFFFEE2);
			SetMemory(0x58DC68, Add, 0xFFFFFF22);
			SetMemory(0x58DC64, Add, 0x000000DE);
			SetMemory(0x58DC6C, Add, 0x0000011E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000011E);
			SetMemory(0x58DC68, Add, 0x000000DE);
			SetMemory(0x58DC64, Add, 0xFFFFFF22);
			SetMemory(0x58DC6C, Add, 0xFFFFFEE2);
			SetMemory(0x58DC60, Add, 0xFFFFFEBD);
			SetMemory(0x58DC68, Add, 0xFFFFFEFD);
			SetMemory(0x58DC64, Add, 0x000000B3);
			SetMemory(0x58DC6C, Add, 0x000000F3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000143);
			SetMemory(0x58DC68, Add, 0x00000103);
			SetMemory(0x58DC64, Add, 0xFFFFFF4D);
			SetMemory(0x58DC6C, Add, 0xFFFFFF0D);
			SetMemory(0x58DC60, Add, 0xFFFFFEA0);
			SetMemory(0x58DC68, Add, 0xFFFFFEE0);
			SetMemory(0x58DC64, Add, 0x00000083);
			SetMemory(0x58DC6C, Add, 0x000000C3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000160);
			SetMemory(0x58DC68, Add, 0x00000120);
			SetMemory(0x58DC64, Add, 0xFFFFFF7D);
			SetMemory(0x58DC6C, Add, 0xFFFFFF3D);
			SetMemory(0x58DC60, Add, 0xFFFFFE8A);
			SetMemory(0x58DC68, Add, 0xFFFFFECA);
			SetMemory(0x58DC64, Add, 0x0000004F);
			SetMemory(0x58DC6C, Add, 0x0000008F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000176);
			SetMemory(0x58DC68, Add, 0x00000136);
			SetMemory(0x58DC64, Add, 0xFFFFFFB1);
			SetMemory(0x58DC6C, Add, 0xFFFFFF71);
			SetMemory(0x58DC60, Add, 0xFFFFFE7D);
			SetMemory(0x58DC68, Add, 0xFFFFFEBD);
			SetMemory(0x58DC64, Add, 0x00000018);
			SetMemory(0x58DC6C, Add, 0x00000058);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000183);
			SetMemory(0x58DC68, Add, 0x00000143);
			SetMemory(0x58DC64, Add, 0xFFFFFFE8);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA8);
			SetMemory(0x58DC60, Add, 0xFFFFFE78);
			SetMemory(0x58DC68, Add, 0xFFFFFEB8);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000188);
			SetMemory(0x58DC68, Add, 0x00000148);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFE7D);
			SetMemory(0x58DC68, Add, 0xFFFFFEBD);
			SetMemory(0x58DC64, Add, 0xFFFFFFA8);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000183);
			SetMemory(0x58DC68, Add, 0x00000143);
			SetMemory(0x58DC64, Add, 0x00000058);
			SetMemory(0x58DC6C, Add, 0x00000018);
			SetMemory(0x58DC60, Add, 0xFFFFFE8A);
			SetMemory(0x58DC68, Add, 0xFFFFFECA);
			SetMemory(0x58DC64, Add, 0xFFFFFF71);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000176);
			SetMemory(0x58DC68, Add, 0x00000136);
			SetMemory(0x58DC64, Add, 0x0000008F);
			SetMemory(0x58DC6C, Add, 0x0000004F);
			SetMemory(0x58DC60, Add, 0xFFFFFEA0);
			SetMemory(0x58DC68, Add, 0xFFFFFEE0);
			SetMemory(0x58DC64, Add, 0xFFFFFF3D);
			SetMemory(0x58DC6C, Add, 0xFFFFFF7D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000160);
			SetMemory(0x58DC68, Add, 0x00000120);
			SetMemory(0x58DC64, Add, 0x000000C3);
			SetMemory(0x58DC6C, Add, 0x00000083);
			SetMemory(0x58DC60, Add, 0xFFFFFEBD);
			SetMemory(0x58DC68, Add, 0xFFFFFEFD);
			SetMemory(0x58DC64, Add, 0xFFFFFF0D);
			SetMemory(0x58DC6C, Add, 0xFFFFFF4D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000143);
			SetMemory(0x58DC68, Add, 0x00000103);
			SetMemory(0x58DC64, Add, 0x000000F3);
			SetMemory(0x58DC6C, Add, 0x000000B3);
			SetMemory(0x58DC60, Add, 0xFFFFFEE2);
			SetMemory(0x58DC68, Add, 0xFFFFFF22);
			SetMemory(0x58DC64, Add, 0xFFFFFEE2);
			SetMemory(0x58DC6C, Add, 0xFFFFFF22);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000011E);
			SetMemory(0x58DC68, Add, 0x000000DE);
			SetMemory(0x58DC64, Add, 0x0000011E);
			SetMemory(0x58DC6C, Add, 0x000000DE);
			SetMemory(0x58DC60, Add, 0xFFFFFF0D);
			SetMemory(0x58DC68, Add, 0xFFFFFF4D);
			SetMemory(0x58DC64, Add, 0xFFFFFEBD);
			SetMemory(0x58DC6C, Add, 0xFFFFFEFD);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F3);
			SetMemory(0x58DC68, Add, 0x000000B3);
			SetMemory(0x58DC64, Add, 0x00000143);
			SetMemory(0x58DC6C, Add, 0x00000103);
			SetMemory(0x58DC60, Add, 0xFFFFFF3D);
			SetMemory(0x58DC68, Add, 0xFFFFFF7D);
			SetMemory(0x58DC64, Add, 0xFFFFFEA0);
			SetMemory(0x58DC6C, Add, 0xFFFFFEE0);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C3);
			SetMemory(0x58DC68, Add, 0x00000083);
			SetMemory(0x58DC64, Add, 0x00000160);
			SetMemory(0x58DC6C, Add, 0x00000120);
			SetMemory(0x58DC60, Add, 0xFFFFFF71);
			SetMemory(0x58DC68, Add, 0xFFFFFFB1);
			SetMemory(0x58DC64, Add, 0xFFFFFE8A);
			SetMemory(0x58DC6C, Add, 0xFFFFFECA);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008F);
			SetMemory(0x58DC68, Add, 0x0000004F);
			SetMemory(0x58DC64, Add, 0x00000176);
			SetMemory(0x58DC6C, Add, 0x00000136);
			SetMemory(0x58DC60, Add, 0xFFFFFFA8);
			SetMemory(0x58DC68, Add, 0xFFFFFFE8);
			SetMemory(0x58DC64, Add, 0xFFFFFE7D);
			SetMemory(0x58DC6C, Add, 0xFFFFFEBD);
			Call_UnitIDVOvr
		})
	DoActions(FP,{
			SetMemory(0x58DC60, Add, 0x00000058);
			SetMemory(0x58DC68, Add, 0x00000018);
			SetMemory(0x58DC64, Add, 0x00000183);
			SetMemory(0x58DC6C, Add, 0x00000143);
		})
	SetCallEnd()
	
	CereBurstShape = SetNextForward()
	SetCall(FP)
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0xFFFFFFB6);
			SetMemory(0x58DC68, Add, 0xFFFFFFF6);
			SetMemory(0x58DC64, Add, 0x0000000A);
			SetMemory(0x58DC6C, Add, 0x0000004A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004A);
			SetMemory(0x58DC68, Add, 0x0000000A);
			SetMemory(0x58DC64, Add, 0xFFFFFFF6);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB6);
			SetMemory(0x58DC60, Add, 0xFFFFFFA4);
			SetMemory(0x58DC68, Add, 0xFFFFFFE4);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000005C);
			SetMemory(0x58DC68, Add, 0x0000001C);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFFB6);
			SetMemory(0x58DC68, Add, 0xFFFFFFF6);
			SetMemory(0x58DC64, Add, 0xFFFFFFB6);
			SetMemory(0x58DC6C, Add, 0xFFFFFFF6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004A);
			SetMemory(0x58DC68, Add, 0x0000000A);
			SetMemory(0x58DC64, Add, 0x0000004A);
			SetMemory(0x58DC6C, Add, 0x0000000A);
			SetMemory(0x58DC60, Add, 0xFFFFFFB3);
			SetMemory(0x58DC68, Add, 0xFFFFFFF3);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000008E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004D);
			SetMemory(0x58DC68, Add, 0x0000000D);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFF72);
			SetMemory(0x58DC60, Add, 0xFFFFFF8C);
			SetMemory(0x58DC68, Add, 0xFFFFFFCC);
			SetMemory(0x58DC64, Add, 0x00000034);
			SetMemory(0x58DC6C, Add, 0x00000074);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000074);
			SetMemory(0x58DC68, Add, 0x00000034);
			SetMemory(0x58DC64, Add, 0xFFFFFFCC);
			SetMemory(0x58DC6C, Add, 0xFFFFFF8C);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0x0000000D);
			SetMemory(0x58DC6C, Add, 0x0000004D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0xFFFFFFF3);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB3);
			SetMemory(0x58DC60, Add, 0xFFFFFF68);
			SetMemory(0x58DC68, Add, 0xFFFFFFA8);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000098);
			SetMemory(0x58DC68, Add, 0x00000058);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF72);
			SetMemory(0x58DC68, Add, 0xFFFFFFB2);
			SetMemory(0x58DC64, Add, 0xFFFFFFB3);
			SetMemory(0x58DC6C, Add, 0xFFFFFFF3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000008E);
			SetMemory(0x58DC68, Add, 0x0000004E);
			SetMemory(0x58DC64, Add, 0x0000004D);
			SetMemory(0x58DC6C, Add, 0x0000000D);
			SetMemory(0x58DC60, Add, 0xFFFFFF8C);
			SetMemory(0x58DC68, Add, 0xFFFFFFCC);
			SetMemory(0x58DC64, Add, 0xFFFFFF8C);
			SetMemory(0x58DC6C, Add, 0xFFFFFFCC);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000074);
			SetMemory(0x58DC68, Add, 0x00000034);
			SetMemory(0x58DC64, Add, 0x00000074);
			SetMemory(0x58DC6C, Add, 0x00000034);
			SetMemory(0x58DC60, Add, 0xFFFFFFB3);
			SetMemory(0x58DC68, Add, 0xFFFFFFF3);
			SetMemory(0x58DC64, Add, 0xFFFFFF72);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004D);
			SetMemory(0x58DC68, Add, 0x0000000D);
			SetMemory(0x58DC64, Add, 0x0000008E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0x0000008D);
			SetMemory(0x58DC6C, Add, 0x000000CD);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0xFFFFFF73);
			SetMemory(0x58DC6C, Add, 0xFFFFFF33);
			SetMemory(0x58DC60, Add, 0xFFFFFF87);
			SetMemory(0x58DC68, Add, 0xFFFFFFC7);
			SetMemory(0x58DC64, Add, 0x0000007B);
			SetMemory(0x58DC6C, Add, 0x000000BB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000079);
			SetMemory(0x58DC68, Add, 0x00000039);
			SetMemory(0x58DC64, Add, 0xFFFFFF85);
			SetMemory(0x58DC6C, Add, 0xFFFFFF45);
			SetMemory(0x58DC60, Add, 0xFFFFFF61);
			SetMemory(0x58DC68, Add, 0xFFFFFFA1);
			SetMemory(0x58DC64, Add, 0x0000005F);
			SetMemory(0x58DC6C, Add, 0x0000009F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000009F);
			SetMemory(0x58DC68, Add, 0x0000005F);
			SetMemory(0x58DC64, Add, 0xFFFFFFA1);
			SetMemory(0x58DC6C, Add, 0xFFFFFF61);
			SetMemory(0x58DC60, Add, 0xFFFFFF45);
			SetMemory(0x58DC68, Add, 0xFFFFFF85);
			SetMemory(0x58DC64, Add, 0x00000039);
			SetMemory(0x58DC6C, Add, 0x00000079);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000BB);
			SetMemory(0x58DC68, Add, 0x0000007B);
			SetMemory(0x58DC64, Add, 0xFFFFFFC7);
			SetMemory(0x58DC6C, Add, 0xFFFFFF87);
			SetMemory(0x58DC60, Add, 0xFFFFFF33);
			SetMemory(0x58DC68, Add, 0xFFFFFF73);
			SetMemory(0x58DC64, Add, 0x0000000E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000CD);
			SetMemory(0x58DC68, Add, 0x0000008D);
			SetMemory(0x58DC64, Add, 0xFFFFFFF2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			SetMemory(0x58DC60, Add, 0xFFFFFF2C);
			SetMemory(0x58DC68, Add, 0xFFFFFF6C);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D4);
			SetMemory(0x58DC68, Add, 0x00000094);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFF33);
			SetMemory(0x58DC68, Add, 0xFFFFFF73);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFF2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000CD);
			SetMemory(0x58DC68, Add, 0x0000008D);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000000E);
			SetMemory(0x58DC60, Add, 0xFFFFFF45);
			SetMemory(0x58DC68, Add, 0xFFFFFF85);
			SetMemory(0x58DC64, Add, 0xFFFFFF86);
			SetMemory(0x58DC6C, Add, 0xFFFFFFC6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000BB);
			SetMemory(0x58DC68, Add, 0x0000007B);
			SetMemory(0x58DC64, Add, 0x0000007A);
			SetMemory(0x58DC6C, Add, 0x0000003A);
			SetMemory(0x58DC60, Add, 0xFFFFFF61);
			SetMemory(0x58DC68, Add, 0xFFFFFFA1);
			SetMemory(0x58DC64, Add, 0xFFFFFF61);
			SetMemory(0x58DC6C, Add, 0xFFFFFFA1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000009F);
			SetMemory(0x58DC68, Add, 0x0000005F);
			SetMemory(0x58DC64, Add, 0x0000009F);
			SetMemory(0x58DC6C, Add, 0x0000005F);
			SetMemory(0x58DC60, Add, 0xFFFFFF86);
			SetMemory(0x58DC68, Add, 0xFFFFFFC6);
			SetMemory(0x58DC64, Add, 0xFFFFFF45);
			SetMemory(0x58DC6C, Add, 0xFFFFFF85);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007A);
			SetMemory(0x58DC68, Add, 0x0000003A);
			SetMemory(0x58DC64, Add, 0x000000BB);
			SetMemory(0x58DC6C, Add, 0x0000007B);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0xFFFFFF33);
			SetMemory(0x58DC6C, Add, 0xFFFFFF73);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0x000000CD);
			SetMemory(0x58DC6C, Add, 0x0000008D);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0x000000CB);
			SetMemory(0x58DC6C, Add, 0x0000010B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0xFFFFFF35);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF5);
			SetMemory(0x58DC60, Add, 0xFFFFFF85);
			SetMemory(0x58DC68, Add, 0xFFFFFFC5);
			SetMemory(0x58DC64, Add, 0x000000BD);
			SetMemory(0x58DC6C, Add, 0x000000FD);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007B);
			SetMemory(0x58DC68, Add, 0x0000003B);
			SetMemory(0x58DC64, Add, 0xFFFFFF43);
			SetMemory(0x58DC6C, Add, 0xFFFFFF03);
			SetMemory(0x58DC60, Add, 0xFFFFFF5B);
			SetMemory(0x58DC68, Add, 0xFFFFFF9B);
			SetMemory(0x58DC64, Add, 0x000000A7);
			SetMemory(0x58DC6C, Add, 0x000000E7);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A5);
			SetMemory(0x58DC68, Add, 0x00000065);
			SetMemory(0x58DC64, Add, 0xFFFFFF59);
			SetMemory(0x58DC6C, Add, 0xFFFFFF19);
			SetMemory(0x58DC60, Add, 0xFFFFFF37);
			SetMemory(0x58DC68, Add, 0xFFFFFF77);
			SetMemory(0x58DC64, Add, 0x00000089);
			SetMemory(0x58DC6C, Add, 0x000000C9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C9);
			SetMemory(0x58DC68, Add, 0x00000089);
			SetMemory(0x58DC64, Add, 0xFFFFFF77);
			SetMemory(0x58DC6C, Add, 0xFFFFFF37);
			SetMemory(0x58DC60, Add, 0xFFFFFF19);
			SetMemory(0x58DC68, Add, 0xFFFFFF59);
			SetMemory(0x58DC64, Add, 0x00000065);
			SetMemory(0x58DC6C, Add, 0x000000A5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000E7);
			SetMemory(0x58DC68, Add, 0x000000A7);
			SetMemory(0x58DC64, Add, 0xFFFFFF9B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF5B);
			SetMemory(0x58DC60, Add, 0xFFFFFF03);
			SetMemory(0x58DC68, Add, 0xFFFFFF43);
			SetMemory(0x58DC64, Add, 0x0000003B);
			SetMemory(0x58DC6C, Add, 0x0000007B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FD);
			SetMemory(0x58DC68, Add, 0x000000BD);
			SetMemory(0x58DC64, Add, 0xFFFFFFC5);
			SetMemory(0x58DC6C, Add, 0xFFFFFF85);
			SetMemory(0x58DC60, Add, 0xFFFFFEF5);
			SetMemory(0x58DC68, Add, 0xFFFFFF35);
			SetMemory(0x58DC64, Add, 0x0000000E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010B);
			SetMemory(0x58DC68, Add, 0x000000CB);
			SetMemory(0x58DC64, Add, 0xFFFFFFF2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			SetMemory(0x58DC60, Add, 0xFFFFFEF0);
			SetMemory(0x58DC68, Add, 0xFFFFFF30);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000110);
			SetMemory(0x58DC68, Add, 0x000000D0);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFEF5);
			SetMemory(0x58DC68, Add, 0xFFFFFF35);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFF2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000010B);
			SetMemory(0x58DC68, Add, 0x000000CB);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000000E);
			SetMemory(0x58DC60, Add, 0xFFFFFF03);
			SetMemory(0x58DC68, Add, 0xFFFFFF43);
			SetMemory(0x58DC64, Add, 0xFFFFFF85);
			SetMemory(0x58DC6C, Add, 0xFFFFFFC5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FD);
			SetMemory(0x58DC68, Add, 0x000000BD);
			SetMemory(0x58DC64, Add, 0x0000007B);
			SetMemory(0x58DC6C, Add, 0x0000003B);
			SetMemory(0x58DC60, Add, 0xFFFFFF19);
			SetMemory(0x58DC68, Add, 0xFFFFFF59);
			SetMemory(0x58DC64, Add, 0xFFFFFF5B);
			SetMemory(0x58DC6C, Add, 0xFFFFFF9B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000E7);
			SetMemory(0x58DC68, Add, 0x000000A7);
			SetMemory(0x58DC64, Add, 0x000000A5);
			SetMemory(0x58DC6C, Add, 0x00000065);
			SetMemory(0x58DC60, Add, 0xFFFFFF37);
			SetMemory(0x58DC68, Add, 0xFFFFFF77);
			SetMemory(0x58DC64, Add, 0xFFFFFF37);
			SetMemory(0x58DC6C, Add, 0xFFFFFF77);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000C9);
			SetMemory(0x58DC68, Add, 0x00000089);
			SetMemory(0x58DC64, Add, 0x000000C9);
			SetMemory(0x58DC6C, Add, 0x00000089);
			SetMemory(0x58DC60, Add, 0xFFFFFF5B);
			SetMemory(0x58DC68, Add, 0xFFFFFF9B);
			SetMemory(0x58DC64, Add, 0xFFFFFF19);
			SetMemory(0x58DC6C, Add, 0xFFFFFF59);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A5);
			SetMemory(0x58DC68, Add, 0x00000065);
			SetMemory(0x58DC64, Add, 0x000000E7);
			SetMemory(0x58DC6C, Add, 0x000000A7);
			SetMemory(0x58DC60, Add, 0xFFFFFF85);
			SetMemory(0x58DC68, Add, 0xFFFFFFC5);
			SetMemory(0x58DC64, Add, 0xFFFFFF03);
			SetMemory(0x58DC6C, Add, 0xFFFFFF43);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007B);
			SetMemory(0x58DC68, Add, 0x0000003B);
			SetMemory(0x58DC64, Add, 0x000000FD);
			SetMemory(0x58DC6C, Add, 0x000000BD);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0xFFFFFEF5);
			SetMemory(0x58DC6C, Add, 0xFFFFFF35);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0x0000010B);
			SetMemory(0x58DC6C, Add, 0x000000CB);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0x00000108);
			SetMemory(0x58DC6C, Add, 0x00000148);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0xFFFFFEF8);
			SetMemory(0x58DC6C, Add, 0xFFFFFEB8);
			SetMemory(0x58DC60, Add, 0xFFFFFF84);
			SetMemory(0x58DC68, Add, 0xFFFFFFC4);
			SetMemory(0x58DC64, Add, 0x000000FD);
			SetMemory(0x58DC6C, Add, 0x0000013D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007C);
			SetMemory(0x58DC68, Add, 0x0000003C);
			SetMemory(0x58DC64, Add, 0xFFFFFF03);
			SetMemory(0x58DC6C, Add, 0xFFFFFEC3);
			SetMemory(0x58DC60, Add, 0xFFFFFF58);
			SetMemory(0x58DC68, Add, 0xFFFFFF98);
			SetMemory(0x58DC64, Add, 0x000000EB);
			SetMemory(0x58DC6C, Add, 0x0000012B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A8);
			SetMemory(0x58DC68, Add, 0x00000068);
			SetMemory(0x58DC64, Add, 0xFFFFFF15);
			SetMemory(0x58DC6C, Add, 0xFFFFFED5);
			SetMemory(0x58DC60, Add, 0xFFFFFF30);
			SetMemory(0x58DC68, Add, 0xFFFFFF70);
			SetMemory(0x58DC64, Add, 0x000000D2);
			SetMemory(0x58DC6C, Add, 0x00000112);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D0);
			SetMemory(0x58DC68, Add, 0x00000090);
			SetMemory(0x58DC64, Add, 0xFFFFFF2E);
			SetMemory(0x58DC6C, Add, 0xFFFFFEEE);
			SetMemory(0x58DC60, Add, 0xFFFFFF0C);
			SetMemory(0x58DC68, Add, 0xFFFFFF4C);
			SetMemory(0x58DC64, Add, 0x000000B4);
			SetMemory(0x58DC6C, Add, 0x000000F4);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F4);
			SetMemory(0x58DC68, Add, 0x000000B4);
			SetMemory(0x58DC64, Add, 0xFFFFFF4C);
			SetMemory(0x58DC6C, Add, 0xFFFFFF0C);
			SetMemory(0x58DC60, Add, 0xFFFFFEEE);
			SetMemory(0x58DC68, Add, 0xFFFFFF2E);
			SetMemory(0x58DC64, Add, 0x00000090);
			SetMemory(0x58DC6C, Add, 0x000000D0);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000112);
			SetMemory(0x58DC68, Add, 0x000000D2);
			SetMemory(0x58DC64, Add, 0xFFFFFF70);
			SetMemory(0x58DC6C, Add, 0xFFFFFF30);
			SetMemory(0x58DC60, Add, 0xFFFFFED5);
			SetMemory(0x58DC68, Add, 0xFFFFFF15);
			SetMemory(0x58DC64, Add, 0x00000068);
			SetMemory(0x58DC6C, Add, 0x000000A8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012B);
			SetMemory(0x58DC68, Add, 0x000000EB);
			SetMemory(0x58DC64, Add, 0xFFFFFF98);
			SetMemory(0x58DC6C, Add, 0xFFFFFF58);
			SetMemory(0x58DC60, Add, 0xFFFFFEC3);
			SetMemory(0x58DC68, Add, 0xFFFFFF03);
			SetMemory(0x58DC64, Add, 0x0000003C);
			SetMemory(0x58DC6C, Add, 0x0000007C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013D);
			SetMemory(0x58DC68, Add, 0x000000FD);
			SetMemory(0x58DC64, Add, 0xFFFFFFC4);
			SetMemory(0x58DC6C, Add, 0xFFFFFF84);
			SetMemory(0x58DC60, Add, 0xFFFFFEB8);
			SetMemory(0x58DC68, Add, 0xFFFFFEF8);
			SetMemory(0x58DC64, Add, 0x0000000E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000148);
			SetMemory(0x58DC68, Add, 0x00000108);
			SetMemory(0x58DC64, Add, 0xFFFFFFF2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			SetMemory(0x58DC60, Add, 0xFFFFFEB4);
			SetMemory(0x58DC68, Add, 0xFFFFFEF4);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000014C);
			SetMemory(0x58DC68, Add, 0x0000010C);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFEB8);
			SetMemory(0x58DC68, Add, 0xFFFFFEF8);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFF2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000148);
			SetMemory(0x58DC68, Add, 0x00000108);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000000E);
			SetMemory(0x58DC60, Add, 0xFFFFFEC3);
			SetMemory(0x58DC68, Add, 0xFFFFFF03);
			SetMemory(0x58DC64, Add, 0xFFFFFF84);
			SetMemory(0x58DC6C, Add, 0xFFFFFFC4);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013D);
			SetMemory(0x58DC68, Add, 0x000000FD);
			SetMemory(0x58DC64, Add, 0x0000007C);
			SetMemory(0x58DC6C, Add, 0x0000003C);
			SetMemory(0x58DC60, Add, 0xFFFFFED5);
			SetMemory(0x58DC68, Add, 0xFFFFFF15);
			SetMemory(0x58DC64, Add, 0xFFFFFF58);
			SetMemory(0x58DC6C, Add, 0xFFFFFF98);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000012B);
			SetMemory(0x58DC68, Add, 0x000000EB);
			SetMemory(0x58DC64, Add, 0x000000A8);
			SetMemory(0x58DC6C, Add, 0x00000068);
			SetMemory(0x58DC60, Add, 0xFFFFFEEE);
			SetMemory(0x58DC68, Add, 0xFFFFFF2E);
			SetMemory(0x58DC64, Add, 0xFFFFFF30);
			SetMemory(0x58DC6C, Add, 0xFFFFFF70);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000112);
			SetMemory(0x58DC68, Add, 0x000000D2);
			SetMemory(0x58DC64, Add, 0x000000D0);
			SetMemory(0x58DC6C, Add, 0x00000090);
			SetMemory(0x58DC60, Add, 0xFFFFFF0C);
			SetMemory(0x58DC68, Add, 0xFFFFFF4C);
			SetMemory(0x58DC64, Add, 0xFFFFFF0C);
			SetMemory(0x58DC6C, Add, 0xFFFFFF4C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000F4);
			SetMemory(0x58DC68, Add, 0x000000B4);
			SetMemory(0x58DC64, Add, 0x000000F4);
			SetMemory(0x58DC6C, Add, 0x000000B4);
			SetMemory(0x58DC60, Add, 0xFFFFFF30);
			SetMemory(0x58DC68, Add, 0xFFFFFF70);
			SetMemory(0x58DC64, Add, 0xFFFFFEEE);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D0);
			SetMemory(0x58DC68, Add, 0x00000090);
			SetMemory(0x58DC64, Add, 0x00000112);
			SetMemory(0x58DC6C, Add, 0x000000D2);
			SetMemory(0x58DC60, Add, 0xFFFFFF58);
			SetMemory(0x58DC68, Add, 0xFFFFFF98);
			SetMemory(0x58DC64, Add, 0xFFFFFED5);
			SetMemory(0x58DC6C, Add, 0xFFFFFF15);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A8);
			SetMemory(0x58DC68, Add, 0x00000068);
			SetMemory(0x58DC64, Add, 0x0000012B);
			SetMemory(0x58DC6C, Add, 0x000000EB);
			SetMemory(0x58DC60, Add, 0xFFFFFF84);
			SetMemory(0x58DC68, Add, 0xFFFFFFC4);
			SetMemory(0x58DC64, Add, 0xFFFFFEC3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF03);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007C);
			SetMemory(0x58DC68, Add, 0x0000003C);
			SetMemory(0x58DC64, Add, 0x0000013D);
			SetMemory(0x58DC6C, Add, 0x000000FD);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0xFFFFFEB8);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0x00000148);
			SetMemory(0x58DC6C, Add, 0x00000108);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0x00000144);
			SetMemory(0x58DC6C, Add, 0x00000184);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0xFFFFFEBC);
			SetMemory(0x58DC6C, Add, 0xFFFFFE7C);
			SetMemory(0x58DC60, Add, 0xFFFFFF83);
			SetMemory(0x58DC68, Add, 0xFFFFFFC3);
			SetMemory(0x58DC64, Add, 0x0000013B);
			SetMemory(0x58DC6C, Add, 0x0000017B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007D);
			SetMemory(0x58DC68, Add, 0x0000003D);
			SetMemory(0x58DC64, Add, 0xFFFFFEC5);
			SetMemory(0x58DC6C, Add, 0xFFFFFE85);
			SetMemory(0x58DC60, Add, 0xFFFFFF57);
			SetMemory(0x58DC68, Add, 0xFFFFFF97);
			SetMemory(0x58DC64, Add, 0x0000012C);
			SetMemory(0x58DC6C, Add, 0x0000016C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A9);
			SetMemory(0x58DC68, Add, 0x00000069);
			SetMemory(0x58DC64, Add, 0xFFFFFED4);
			SetMemory(0x58DC6C, Add, 0xFFFFFE94);
			SetMemory(0x58DC60, Add, 0xFFFFFF2D);
			SetMemory(0x58DC68, Add, 0xFFFFFF6D);
			SetMemory(0x58DC64, Add, 0x00000117);
			SetMemory(0x58DC6C, Add, 0x00000157);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D3);
			SetMemory(0x58DC68, Add, 0x00000093);
			SetMemory(0x58DC64, Add, 0xFFFFFEE9);
			SetMemory(0x58DC6C, Add, 0xFFFFFEA9);
			SetMemory(0x58DC60, Add, 0xFFFFFF05);
			SetMemory(0x58DC68, Add, 0xFFFFFF45);
			SetMemory(0x58DC64, Add, 0x000000FD);
			SetMemory(0x58DC6C, Add, 0x0000013D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FB);
			SetMemory(0x58DC68, Add, 0x000000BB);
			SetMemory(0x58DC64, Add, 0xFFFFFF03);
			SetMemory(0x58DC6C, Add, 0xFFFFFEC3);
			SetMemory(0x58DC60, Add, 0xFFFFFEE2);
			SetMemory(0x58DC68, Add, 0xFFFFFF22);
			SetMemory(0x58DC64, Add, 0x000000DE);
			SetMemory(0x58DC6C, Add, 0x0000011E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000011E);
			SetMemory(0x58DC68, Add, 0x000000DE);
			SetMemory(0x58DC64, Add, 0xFFFFFF22);
			SetMemory(0x58DC6C, Add, 0xFFFFFEE2);
			SetMemory(0x58DC60, Add, 0xFFFFFEC3);
			SetMemory(0x58DC68, Add, 0xFFFFFF03);
			SetMemory(0x58DC64, Add, 0x000000BB);
			SetMemory(0x58DC6C, Add, 0x000000FB);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013D);
			SetMemory(0x58DC68, Add, 0x000000FD);
			SetMemory(0x58DC64, Add, 0xFFFFFF45);
			SetMemory(0x58DC6C, Add, 0xFFFFFF05);
			SetMemory(0x58DC60, Add, 0xFFFFFEA9);
			SetMemory(0x58DC68, Add, 0xFFFFFEE9);
			SetMemory(0x58DC64, Add, 0x00000093);
			SetMemory(0x58DC6C, Add, 0x000000D3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000157);
			SetMemory(0x58DC68, Add, 0x00000117);
			SetMemory(0x58DC64, Add, 0xFFFFFF6D);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2D);
			SetMemory(0x58DC60, Add, 0xFFFFFE94);
			SetMemory(0x58DC68, Add, 0xFFFFFED4);
			SetMemory(0x58DC64, Add, 0x00000069);
			SetMemory(0x58DC6C, Add, 0x000000A9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000016C);
			SetMemory(0x58DC68, Add, 0x0000012C);
			SetMemory(0x58DC64, Add, 0xFFFFFF97);
			SetMemory(0x58DC6C, Add, 0xFFFFFF57);
			SetMemory(0x58DC60, Add, 0xFFFFFE85);
			SetMemory(0x58DC68, Add, 0xFFFFFEC5);
			SetMemory(0x58DC64, Add, 0x0000003D);
			SetMemory(0x58DC6C, Add, 0x0000007D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000017B);
			SetMemory(0x58DC68, Add, 0x0000013B);
			SetMemory(0x58DC64, Add, 0xFFFFFFC3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF83);
			SetMemory(0x58DC60, Add, 0xFFFFFE7C);
			SetMemory(0x58DC68, Add, 0xFFFFFEBC);
			SetMemory(0x58DC64, Add, 0x0000000E);
			SetMemory(0x58DC6C, Add, 0x0000004E);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000184);
			SetMemory(0x58DC68, Add, 0x00000144);
			SetMemory(0x58DC64, Add, 0xFFFFFFF2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
			SetMemory(0x58DC60, Add, 0xFFFFFE78);
			SetMemory(0x58DC68, Add, 0xFFFFFEB8);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000188);
			SetMemory(0x58DC68, Add, 0x00000148);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFE7C);
			SetMemory(0x58DC68, Add, 0xFFFFFEBC);
			SetMemory(0x58DC64, Add, 0xFFFFFFB2);
			SetMemory(0x58DC6C, Add, 0xFFFFFFF2);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000184);
			SetMemory(0x58DC68, Add, 0x00000144);
			SetMemory(0x58DC64, Add, 0x0000004E);
			SetMemory(0x58DC6C, Add, 0x0000000E);
			SetMemory(0x58DC60, Add, 0xFFFFFE85);
			SetMemory(0x58DC68, Add, 0xFFFFFEC5);
			SetMemory(0x58DC64, Add, 0xFFFFFF83);
			SetMemory(0x58DC6C, Add, 0xFFFFFFC3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000017B);
			SetMemory(0x58DC68, Add, 0x0000013B);
			SetMemory(0x58DC64, Add, 0x0000007D);
			SetMemory(0x58DC6C, Add, 0x0000003D);
			SetMemory(0x58DC60, Add, 0xFFFFFE94);
			SetMemory(0x58DC68, Add, 0xFFFFFED4);
			SetMemory(0x58DC64, Add, 0xFFFFFF57);
			SetMemory(0x58DC6C, Add, 0xFFFFFF97);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000016C);
			SetMemory(0x58DC68, Add, 0x0000012C);
			SetMemory(0x58DC64, Add, 0x000000A9);
			SetMemory(0x58DC6C, Add, 0x00000069);
			SetMemory(0x58DC60, Add, 0xFFFFFEA9);
			SetMemory(0x58DC68, Add, 0xFFFFFEE9);
			SetMemory(0x58DC64, Add, 0xFFFFFF2C);
			SetMemory(0x58DC6C, Add, 0xFFFFFF6C);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000157);
			SetMemory(0x58DC68, Add, 0x00000117);
			SetMemory(0x58DC64, Add, 0x000000D4);
			SetMemory(0x58DC6C, Add, 0x00000094);
			SetMemory(0x58DC60, Add, 0xFFFFFEC3);
			SetMemory(0x58DC68, Add, 0xFFFFFF03);
			SetMemory(0x58DC64, Add, 0xFFFFFF05);
			SetMemory(0x58DC6C, Add, 0xFFFFFF45);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000013D);
			SetMemory(0x58DC68, Add, 0x000000FD);
			SetMemory(0x58DC64, Add, 0x000000FB);
			SetMemory(0x58DC6C, Add, 0x000000BB);
			SetMemory(0x58DC60, Add, 0xFFFFFEE2);
			SetMemory(0x58DC68, Add, 0xFFFFFF22);
			SetMemory(0x58DC64, Add, 0xFFFFFEE2);
			SetMemory(0x58DC6C, Add, 0xFFFFFF22);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000011E);
			SetMemory(0x58DC68, Add, 0x000000DE);
			SetMemory(0x58DC64, Add, 0x0000011E);
			SetMemory(0x58DC6C, Add, 0x000000DE);
			SetMemory(0x58DC60, Add, 0xFFFFFF05);
			SetMemory(0x58DC68, Add, 0xFFFFFF45);
			SetMemory(0x58DC64, Add, 0xFFFFFEC3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF03);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FB);
			SetMemory(0x58DC68, Add, 0x000000BB);
			SetMemory(0x58DC64, Add, 0x0000013D);
			SetMemory(0x58DC6C, Add, 0x000000FD);
			SetMemory(0x58DC60, Add, 0xFFFFFF2C);
			SetMemory(0x58DC68, Add, 0xFFFFFF6C);
			SetMemory(0x58DC64, Add, 0xFFFFFEA9);
			SetMemory(0x58DC6C, Add, 0xFFFFFEE9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D4);
			SetMemory(0x58DC68, Add, 0x00000094);
			SetMemory(0x58DC64, Add, 0x00000157);
			SetMemory(0x58DC6C, Add, 0x00000117);
			SetMemory(0x58DC60, Add, 0xFFFFFF57);
			SetMemory(0x58DC68, Add, 0xFFFFFF97);
			SetMemory(0x58DC64, Add, 0xFFFFFE94);
			SetMemory(0x58DC6C, Add, 0xFFFFFED4);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000A9);
			SetMemory(0x58DC68, Add, 0x00000069);
			SetMemory(0x58DC64, Add, 0x0000016C);
			SetMemory(0x58DC6C, Add, 0x0000012C);
			SetMemory(0x58DC60, Add, 0xFFFFFF83);
			SetMemory(0x58DC68, Add, 0xFFFFFFC3);
			SetMemory(0x58DC64, Add, 0xFFFFFE85);
			SetMemory(0x58DC6C, Add, 0xFFFFFEC5);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007D);
			SetMemory(0x58DC68, Add, 0x0000003D);
			SetMemory(0x58DC64, Add, 0x0000017B);
			SetMemory(0x58DC6C, Add, 0x0000013B);
			SetMemory(0x58DC60, Add, 0xFFFFFFB2);
			SetMemory(0x58DC68, Add, 0xFFFFFFF2);
			SetMemory(0x58DC64, Add, 0xFFFFFE7C);
			SetMemory(0x58DC6C, Add, 0xFFFFFEBC);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004E);
			SetMemory(0x58DC68, Add, 0x0000000E);
			SetMemory(0x58DC64, Add, 0x00000184);
			SetMemory(0x58DC6C, Add, 0x00000144);
			SetMemory(0x58DC60, Add, 0xFFFFFFB1);
			SetMemory(0x58DC68, Add, 0xFFFFFFF1);
			SetMemory(0x58DC64, Add, 0x00000181);
			SetMemory(0x58DC6C, Add, 0x000001C1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000004F);
			SetMemory(0x58DC68, Add, 0x0000000F);
			SetMemory(0x58DC64, Add, 0xFFFFFE7F);
			SetMemory(0x58DC6C, Add, 0xFFFFFE3F);
			SetMemory(0x58DC60, Add, 0xFFFFFF83);
			SetMemory(0x58DC68, Add, 0xFFFFFFC3);
			SetMemory(0x58DC64, Add, 0x00000179);
			SetMemory(0x58DC6C, Add, 0x000001B9);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007D);
			SetMemory(0x58DC68, Add, 0x0000003D);
			SetMemory(0x58DC64, Add, 0xFFFFFE87);
			SetMemory(0x58DC6C, Add, 0xFFFFFE47);
			SetMemory(0x58DC60, Add, 0xFFFFFF56);
			SetMemory(0x58DC68, Add, 0xFFFFFF96);
			SetMemory(0x58DC64, Add, 0x0000016C);
			SetMemory(0x58DC6C, Add, 0x000001AC);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000AA);
			SetMemory(0x58DC68, Add, 0x0000006A);
			SetMemory(0x58DC64, Add, 0xFFFFFE94);
			SetMemory(0x58DC6C, Add, 0xFFFFFE54);
			SetMemory(0x58DC60, Add, 0xFFFFFF2A);
			SetMemory(0x58DC68, Add, 0xFFFFFF6A);
			SetMemory(0x58DC64, Add, 0x0000015A);
			SetMemory(0x58DC6C, Add, 0x0000019A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D6);
			SetMemory(0x58DC68, Add, 0x00000096);
			SetMemory(0x58DC64, Add, 0xFFFFFEA6);
			SetMemory(0x58DC6C, Add, 0xFFFFFE66);
			SetMemory(0x58DC60, Add, 0xFFFFFF01);
			SetMemory(0x58DC68, Add, 0xFFFFFF41);
			SetMemory(0x58DC64, Add, 0x00000143);
			SetMemory(0x58DC6C, Add, 0x00000183);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FF);
			SetMemory(0x58DC68, Add, 0x000000BF);
			SetMemory(0x58DC64, Add, 0xFFFFFEBD);
			SetMemory(0x58DC6C, Add, 0xFFFFFE7D);
			SetMemory(0x58DC60, Add, 0xFFFFFEDB);
			SetMemory(0x58DC68, Add, 0xFFFFFF1B);
			SetMemory(0x58DC64, Add, 0x00000128);
			SetMemory(0x58DC6C, Add, 0x00000168);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000125);
			SetMemory(0x58DC68, Add, 0x000000E5);
			SetMemory(0x58DC64, Add, 0xFFFFFED8);
			SetMemory(0x58DC6C, Add, 0xFFFFFE98);
			SetMemory(0x58DC60, Add, 0xFFFFFEB8);
			SetMemory(0x58DC68, Add, 0xFFFFFEF8);
			SetMemory(0x58DC64, Add, 0x00000108);
			SetMemory(0x58DC6C, Add, 0x00000148);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000148);
			SetMemory(0x58DC68, Add, 0x00000108);
			SetMemory(0x58DC64, Add, 0xFFFFFEF8);
			SetMemory(0x58DC6C, Add, 0xFFFFFEB8);
			SetMemory(0x58DC60, Add, 0xFFFFFE98);
			SetMemory(0x58DC68, Add, 0xFFFFFED8);
			SetMemory(0x58DC64, Add, 0x000000E5);
			SetMemory(0x58DC6C, Add, 0x00000125);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000168);
			SetMemory(0x58DC68, Add, 0x00000128);
			SetMemory(0x58DC64, Add, 0xFFFFFF1B);
			SetMemory(0x58DC6C, Add, 0xFFFFFEDB);
			SetMemory(0x58DC60, Add, 0xFFFFFE7D);
			SetMemory(0x58DC68, Add, 0xFFFFFEBD);
			SetMemory(0x58DC64, Add, 0x000000BF);
			SetMemory(0x58DC6C, Add, 0x000000FF);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000183);
			SetMemory(0x58DC68, Add, 0x00000143);
			SetMemory(0x58DC64, Add, 0xFFFFFF41);
			SetMemory(0x58DC6C, Add, 0xFFFFFF01);
			SetMemory(0x58DC60, Add, 0xFFFFFE66);
			SetMemory(0x58DC68, Add, 0xFFFFFEA6);
			SetMemory(0x58DC64, Add, 0x00000096);
			SetMemory(0x58DC6C, Add, 0x000000D6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000019A);
			SetMemory(0x58DC68, Add, 0x0000015A);
			SetMemory(0x58DC64, Add, 0xFFFFFF6A);
			SetMemory(0x58DC6C, Add, 0xFFFFFF2A);
			SetMemory(0x58DC60, Add, 0xFFFFFE54);
			SetMemory(0x58DC68, Add, 0xFFFFFE94);
			SetMemory(0x58DC64, Add, 0x0000006A);
			SetMemory(0x58DC6C, Add, 0x000000AA);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001AC);
			SetMemory(0x58DC68, Add, 0x0000016C);
			SetMemory(0x58DC64, Add, 0xFFFFFF96);
			SetMemory(0x58DC6C, Add, 0xFFFFFF56);
			SetMemory(0x58DC60, Add, 0xFFFFFE47);
			SetMemory(0x58DC68, Add, 0xFFFFFE87);
			SetMemory(0x58DC64, Add, 0x0000003D);
			SetMemory(0x58DC6C, Add, 0x0000007D);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001B9);
			SetMemory(0x58DC68, Add, 0x00000179);
			SetMemory(0x58DC64, Add, 0xFFFFFFC3);
			SetMemory(0x58DC6C, Add, 0xFFFFFF83);
			SetMemory(0x58DC60, Add, 0xFFFFFE3F);
			SetMemory(0x58DC68, Add, 0xFFFFFE7F);
			SetMemory(0x58DC64, Add, 0x0000000F);
			SetMemory(0x58DC6C, Add, 0x0000004F);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001C1);
			SetMemory(0x58DC68, Add, 0x00000181);
			SetMemory(0x58DC64, Add, 0xFFFFFFF1);
			SetMemory(0x58DC6C, Add, 0xFFFFFFB1);
			SetMemory(0x58DC60, Add, 0xFFFFFE3C);
			SetMemory(0x58DC68, Add, 0xFFFFFE7C);
			SetMemory(0x58DC64, Add, 0xFFFFFFE1);
			SetMemory(0x58DC6C, Add, 0x00000020);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001C4);
			SetMemory(0x58DC68, Add, 0x00000184);
			SetMemory(0x58DC64, Add, 0x0000001F);
			SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
			SetMemory(0x58DC60, Add, 0xFFFFFE3F);
			SetMemory(0x58DC68, Add, 0xFFFFFE7F);
			SetMemory(0x58DC64, Add, 0xFFFFFFB1);
			SetMemory(0x58DC6C, Add, 0xFFFFFFF1);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001C1);
			SetMemory(0x58DC68, Add, 0x00000181);
			SetMemory(0x58DC64, Add, 0x0000004F);
			SetMemory(0x58DC6C, Add, 0x0000000F);
			SetMemory(0x58DC60, Add, 0xFFFFFE47);
			SetMemory(0x58DC68, Add, 0xFFFFFE87);
			SetMemory(0x58DC64, Add, 0xFFFFFF83);
			SetMemory(0x58DC6C, Add, 0xFFFFFFC3);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001B9);
			SetMemory(0x58DC68, Add, 0x00000179);
			SetMemory(0x58DC64, Add, 0x0000007D);
			SetMemory(0x58DC6C, Add, 0x0000003D);
			SetMemory(0x58DC60, Add, 0xFFFFFE54);
			SetMemory(0x58DC68, Add, 0xFFFFFE94);
			SetMemory(0x58DC64, Add, 0xFFFFFF56);
			SetMemory(0x58DC6C, Add, 0xFFFFFF96);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000001AC);
			SetMemory(0x58DC68, Add, 0x0000016C);
			SetMemory(0x58DC64, Add, 0x000000AA);
			SetMemory(0x58DC6C, Add, 0x0000006A);
			SetMemory(0x58DC60, Add, 0xFFFFFE66);
			SetMemory(0x58DC68, Add, 0xFFFFFEA6);
			SetMemory(0x58DC64, Add, 0xFFFFFF2A);
			SetMemory(0x58DC6C, Add, 0xFFFFFF6A);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000019A);
			SetMemory(0x58DC68, Add, 0x0000015A);
			SetMemory(0x58DC64, Add, 0x000000D6);
			SetMemory(0x58DC6C, Add, 0x00000096);
			SetMemory(0x58DC60, Add, 0xFFFFFE7D);
			SetMemory(0x58DC68, Add, 0xFFFFFEBD);
			SetMemory(0x58DC64, Add, 0xFFFFFF01);
			SetMemory(0x58DC6C, Add, 0xFFFFFF41);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000183);
			SetMemory(0x58DC68, Add, 0x00000143);
			SetMemory(0x58DC64, Add, 0x000000FF);
			SetMemory(0x58DC6C, Add, 0x000000BF);
			SetMemory(0x58DC60, Add, 0xFFFFFE98);
			SetMemory(0x58DC68, Add, 0xFFFFFED8);
			SetMemory(0x58DC64, Add, 0xFFFFFEDB);
			SetMemory(0x58DC6C, Add, 0xFFFFFF1B);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000168);
			SetMemory(0x58DC68, Add, 0x00000128);
			SetMemory(0x58DC64, Add, 0x00000125);
			SetMemory(0x58DC6C, Add, 0x000000E5);
			SetMemory(0x58DC60, Add, 0xFFFFFEB8);
			SetMemory(0x58DC68, Add, 0xFFFFFEF8);
			SetMemory(0x58DC64, Add, 0xFFFFFEB8);
			SetMemory(0x58DC6C, Add, 0xFFFFFEF8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000148);
			SetMemory(0x58DC68, Add, 0x00000108);
			SetMemory(0x58DC64, Add, 0x00000148);
			SetMemory(0x58DC6C, Add, 0x00000108);
			SetMemory(0x58DC60, Add, 0xFFFFFEDB);
			SetMemory(0x58DC68, Add, 0xFFFFFF1B);
			SetMemory(0x58DC64, Add, 0xFFFFFE98);
			SetMemory(0x58DC6C, Add, 0xFFFFFED8);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x00000125);
			SetMemory(0x58DC68, Add, 0x000000E5);
			SetMemory(0x58DC64, Add, 0x00000168);
			SetMemory(0x58DC6C, Add, 0x00000128);
			SetMemory(0x58DC60, Add, 0xFFFFFF01);
			SetMemory(0x58DC68, Add, 0xFFFFFF41);
			SetMemory(0x58DC64, Add, 0xFFFFFE7D);
			SetMemory(0x58DC6C, Add, 0xFFFFFEBD);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000FF);
			SetMemory(0x58DC68, Add, 0x000000BF);
			SetMemory(0x58DC64, Add, 0x00000183);
			SetMemory(0x58DC6C, Add, 0x00000143);
			SetMemory(0x58DC60, Add, 0xFFFFFF2A);
			SetMemory(0x58DC68, Add, 0xFFFFFF6A);
			SetMemory(0x58DC64, Add, 0xFFFFFE66);
			SetMemory(0x58DC6C, Add, 0xFFFFFEA6);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000D6);
			SetMemory(0x58DC68, Add, 0x00000096);
			SetMemory(0x58DC64, Add, 0x0000019A);
			SetMemory(0x58DC6C, Add, 0x0000015A);
			SetMemory(0x58DC60, Add, 0xFFFFFF56);
			SetMemory(0x58DC68, Add, 0xFFFFFF96);
			SetMemory(0x58DC64, Add, 0xFFFFFE54);
			SetMemory(0x58DC6C, Add, 0xFFFFFE94);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x000000AA);
			SetMemory(0x58DC68, Add, 0x0000006A);
			SetMemory(0x58DC64, Add, 0x000001AC);
			SetMemory(0x58DC6C, Add, 0x0000016C);
			SetMemory(0x58DC60, Add, 0xFFFFFF83);
			SetMemory(0x58DC68, Add, 0xFFFFFFC3);
			SetMemory(0x58DC64, Add, 0xFFFFFE47);
			SetMemory(0x58DC6C, Add, 0xFFFFFE87);
			Call_UnitIDVOvr
		})
	DoActionsX(FP,{
			SetMemory(0x58DC60, Add, 0x0000007D);
			SetMemory(0x58DC68, Add, 0x0000003D);
			SetMemory(0x58DC64, Add, 0x000001B9);
			SetMemory(0x58DC6C, Add, 0x00000179);
			SetMemory(0x58DC60, Add, 0xFFFFFFB1);
			SetMemory(0x58DC68, Add, 0xFFFFFFF1);
			SetMemory(0x58DC64, Add, 0xFFFFFE3F);
			SetMemory(0x58DC6C, Add, 0xFFFFFE7F);
			Call_UnitIDVOvr
		})
	DoActions(FP,{
			SetMemory(0x58DC60, Add, 0x0000004F);
			SetMemory(0x58DC68, Add, 0x0000000F);
			SetMemory(0x58DC64, Add, 0x000001C1);
			SetMemory(0x58DC6C, Add, 0x00000181);
		})
	SetCallEnd()
	end
	function Install_LairShape()
		
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFE0),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000020),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFFBD),
		SetMemory(0x58DC68, Add, 0xFFFFFFFD),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000043),
		SetMemory(0x58DC68, Add, 0x00000003),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFF98),
		SetMemory(0x58DC68, Add, 0xFFFFFFD8),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000068),
		SetMemory(0x58DC68, Add, 0x00000028),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFFBC),
		SetMemory(0x58DC68, Add, 0xFFFFFFFC),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000044),
		SetMemory(0x58DC68, Add, 0x00000004),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFFD9),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x00000027),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB5),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004B),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFF50),
		SetMemory(0x58DC68, Add, 0xFFFFFF90),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000B0),
		SetMemory(0x58DC68, Add, 0x00000070),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB4),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004C),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFF98),
		SetMemory(0x58DC68, Add, 0xFFFFFFD8),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000068),
		SetMemory(0x58DC68, Add, 0x00000028),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFFE0),
		SetMemory(0x58DC68, Add, 0x0000001F),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000020),
		SetMemory(0x58DC68, Add, 0xFFFFFFE1),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFFBD),
		SetMemory(0x58DC68, Add, 0xFFFFFFFD),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000043),
		SetMemory(0x58DC68, Add, 0x00000003),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFF75),
		SetMemory(0x58DC68, Add, 0xFFFFFFB5),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008B),
		SetMemory(0x58DC68, Add, 0x0000004B),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFF51),
		SetMemory(0x58DC68, Add, 0xFFFFFF91),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000AF),
		SetMemory(0x58DC68, Add, 0x0000006F),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFF08),
		SetMemory(0x58DC68, Add, 0xFFFFFF48),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8),
		SetMemory(0x58DC68, Add, 0x000000B8),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFF50),
		SetMemory(0x58DC68, Add, 0xFFFFFF90),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000B0),
		SetMemory(0x58DC68, Add, 0x00000070),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB4),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004C),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0xFFFFFFBC),
		SetMemory(0x58DC68, Add, 0xFFFFFFFC),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000044),
		SetMemory(0x58DC68, Add, 0x00000004),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x00000003),
		SetMemory(0x58DC68, Add, 0x00000043),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFD),
		SetMemory(0x58DC68, Add, 0xFFFFFFBD),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000100),
		SetMemory(0x58DC68, Add, 0x00000140),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF00),
		SetMemory(0x58DC68, Add, 0xFFFFFEC0),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFFD9),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x00000027),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFF51),
		SetMemory(0x58DC68, Add, 0xFFFFFF91),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000AF),
		SetMemory(0x58DC68, Add, 0x0000006F),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFF2D),
		SetMemory(0x58DC68, Add, 0xFFFFFF6D),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D3),
		SetMemory(0x58DC68, Add, 0x00000093),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFF09),
		SetMemory(0x58DC68, Add, 0xFFFFFF49),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F7),
		SetMemory(0x58DC68, Add, 0x000000B7),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFEE4),
		SetMemory(0x58DC68, Add, 0xFFFFFF24),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011C),
		SetMemory(0x58DC68, Add, 0x000000DC),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFEC0),
		SetMemory(0x58DC68, Add, 0xFFFFFF00),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000140),
		SetMemory(0x58DC68, Add, 0x00000100),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFEE4),
		SetMemory(0x58DC68, Add, 0xFFFFFF24),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011C),
		SetMemory(0x58DC68, Add, 0x000000DC),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFF08),
		SetMemory(0x58DC68, Add, 0xFFFFFF48),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8),
		SetMemory(0x58DC68, Add, 0x000000B8),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0xFFFFFF50),
		SetMemory(0x58DC68, Add, 0xFFFFFF90),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000B0),
		SetMemory(0x58DC68, Add, 0x00000070),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0xFFFFFF98),
		SetMemory(0x58DC68, Add, 0xFFFFFFD8),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000068),
		SetMemory(0x58DC68, Add, 0x00000028),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0xFFFFFFE0),
		SetMemory(0x58DC68, Add, 0x0000001F),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000020),
		SetMemory(0x58DC68, Add, 0xFFFFFFE1),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000148),
		SetMemory(0x58DC68, Add, 0x00000188),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFEB8),
		SetMemory(0x58DC68, Add, 0xFFFFFE78),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000124),
		SetMemory(0x58DC68, Add, 0x00000164),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFEDC),
		SetMemory(0x58DC68, Add, 0xFFFFFE9C),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x00000100),
		SetMemory(0x58DC68, Add, 0x00000140),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF00),
		SetMemory(0x58DC68, Add, 0xFFFFFEC0),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFFBD),
		SetMemory(0x58DC68, Add, 0xFFFFFFFD),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000043),
		SetMemory(0x58DC68, Add, 0x00000003),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFF75),
		SetMemory(0x58DC68, Add, 0xFFFFFFB5),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008B),
		SetMemory(0x58DC68, Add, 0x0000004B),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFF2D),
		SetMemory(0x58DC68, Add, 0xFFFFFF6D),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D3),
		SetMemory(0x58DC68, Add, 0x00000093),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFF09),
		SetMemory(0x58DC68, Add, 0xFFFFFF49),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F7),
		SetMemory(0x58DC68, Add, 0x000000B7),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFEE5),
		SetMemory(0x58DC68, Add, 0xFFFFFF25),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011B),
		SetMemory(0x58DC68, Add, 0x000000DB),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFEC1),
		SetMemory(0x58DC68, Add, 0xFFFFFF01),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000013F),
		SetMemory(0x58DC68, Add, 0x000000FF),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFE9C),
		SetMemory(0x58DC68, Add, 0xFFFFFEDC),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000164),
		SetMemory(0x58DC68, Add, 0x00000124),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFE78),
		SetMemory(0x58DC68, Add, 0xFFFFFEB8),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000188),
		SetMemory(0x58DC68, Add, 0x00000148),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFE9C),
		SetMemory(0x58DC68, Add, 0xFFFFFEDC),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000164),
		SetMemory(0x58DC68, Add, 0x00000124),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFEC0),
		SetMemory(0x58DC68, Add, 0xFFFFFF00),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000140),
		SetMemory(0x58DC68, Add, 0x00000100),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFEE4),
		SetMemory(0x58DC68, Add, 0xFFFFFF24),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011C),
		SetMemory(0x58DC68, Add, 0x000000DC),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0xFFFFFF08),
		SetMemory(0x58DC68, Add, 0xFFFFFF48),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8),
		SetMemory(0x58DC68, Add, 0x000000B8),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB4),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004C),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0xFFFFFFBC),
		SetMemory(0x58DC68, Add, 0xFFFFFFFC),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000044),
		SetMemory(0x58DC68, Add, 0x00000004),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x00000003),
		SetMemory(0x58DC68, Add, 0x00000043),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFD),
		SetMemory(0x58DC68, Add, 0xFFFFFFBD),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x00000100),
		SetMemory(0x58DC68, Add, 0x00000140),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF00),
		SetMemory(0x58DC68, Add, 0xFFFFFEC0),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x00000124),
		SetMemory(0x58DC68, Add, 0x00000164),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFEDC),
		SetMemory(0x58DC68, Add, 0xFFFFFE9C),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
	})
	
	end
	
	function Install_HiveShape()
		
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFE0),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000020),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFFBD),
		SetMemory(0x58DC68, Add, 0xFFFFFFFD),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000043),
		SetMemory(0x58DC68, Add, 0x00000003),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFF98),
		SetMemory(0x58DC68, Add, 0xFFFFFFD8),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000068),
		SetMemory(0x58DC68, Add, 0x00000028),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFFBC),
		SetMemory(0x58DC68, Add, 0xFFFFFFFC),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000044),
		SetMemory(0x58DC68, Add, 0x00000004),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFFD9),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x00000027),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB5),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004B),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFF50),
		SetMemory(0x58DC68, Add, 0xFFFFFF90),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000B0),
		SetMemory(0x58DC68, Add, 0x00000070),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB4),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004C),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFF98),
		SetMemory(0x58DC68, Add, 0xFFFFFFD8),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000068),
		SetMemory(0x58DC68, Add, 0x00000028),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFFE0),
		SetMemory(0x58DC68, Add, 0x0000001F),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000020),
		SetMemory(0x58DC68, Add, 0xFFFFFFE1),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFFBD),
		SetMemory(0x58DC68, Add, 0xFFFFFFFD),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000043),
		SetMemory(0x58DC68, Add, 0x00000003),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFF75),
		SetMemory(0x58DC68, Add, 0xFFFFFFB5),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008B),
		SetMemory(0x58DC68, Add, 0x0000004B),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFF51),
		SetMemory(0x58DC68, Add, 0xFFFFFF91),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000AF),
		SetMemory(0x58DC68, Add, 0x0000006F),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFF08),
		SetMemory(0x58DC68, Add, 0xFFFFFF48),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8),
		SetMemory(0x58DC68, Add, 0x000000B8),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFF50),
		SetMemory(0x58DC68, Add, 0xFFFFFF90),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000B0),
		SetMemory(0x58DC68, Add, 0x00000070),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB4),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004C),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0xFFFFFFBC),
		SetMemory(0x58DC68, Add, 0xFFFFFFFC),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000044),
		SetMemory(0x58DC68, Add, 0x00000004),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x00000003),
		SetMemory(0x58DC68, Add, 0x00000043),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFD),
		SetMemory(0x58DC68, Add, 0xFFFFFFBD),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000100),
		SetMemory(0x58DC68, Add, 0x00000140),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF00),
		SetMemory(0x58DC68, Add, 0xFFFFFEC0),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFFD9),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x00000027),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFF51),
		SetMemory(0x58DC68, Add, 0xFFFFFF91),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000AF),
		SetMemory(0x58DC68, Add, 0x0000006F),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFF2D),
		SetMemory(0x58DC68, Add, 0xFFFFFF6D),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D3),
		SetMemory(0x58DC68, Add, 0x00000093),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFF09),
		SetMemory(0x58DC68, Add, 0xFFFFFF49),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F7),
		SetMemory(0x58DC68, Add, 0x000000B7),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFEE4),
		SetMemory(0x58DC68, Add, 0xFFFFFF24),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011C),
		SetMemory(0x58DC68, Add, 0x000000DC),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFEC0),
		SetMemory(0x58DC68, Add, 0xFFFFFF00),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000140),
		SetMemory(0x58DC68, Add, 0x00000100),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFEE4),
		SetMemory(0x58DC68, Add, 0xFFFFFF24),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011C),
		SetMemory(0x58DC68, Add, 0x000000DC),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFF08),
		SetMemory(0x58DC68, Add, 0xFFFFFF48),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8),
		SetMemory(0x58DC68, Add, 0x000000B8),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0xFFFFFF50),
		SetMemory(0x58DC68, Add, 0xFFFFFF90),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000B0),
		SetMemory(0x58DC68, Add, 0x00000070),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0xFFFFFF98),
		SetMemory(0x58DC68, Add, 0xFFFFFFD8),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000068),
		SetMemory(0x58DC68, Add, 0x00000028),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0xFFFFFFE0),
		SetMemory(0x58DC68, Add, 0x0000001F),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000020),
		SetMemory(0x58DC68, Add, 0xFFFFFFE1),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x00000028),
		SetMemory(0x58DC68, Add, 0x00000068),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8),
		SetMemory(0x58DC68, Add, 0xFFFFFF98),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x00000070),
		SetMemory(0x58DC68, Add, 0x000000B0),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90),
		SetMemory(0x58DC68, Add, 0xFFFFFF50),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0x00000148),
		SetMemory(0x58DC68, Add, 0x00000188),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFEB8),
		SetMemory(0x58DC68, Add, 0xFFFFFE78),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000124),
		SetMemory(0x58DC68, Add, 0x00000164),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFEDC),
		SetMemory(0x58DC68, Add, 0xFFFFFE9C),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0x00000100),
		SetMemory(0x58DC68, Add, 0x00000140),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF00),
		SetMemory(0x58DC68, Add, 0xFFFFFEC0),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0x00000004),
		SetMemory(0x58DC68, Add, 0x00000044),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFC),
		SetMemory(0x58DC68, Add, 0xFFFFFFBC),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFFBD),
		SetMemory(0x58DC68, Add, 0xFFFFFFFD),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000043),
		SetMemory(0x58DC68, Add, 0x00000003),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFF75),
		SetMemory(0x58DC68, Add, 0xFFFFFFB5),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008B),
		SetMemory(0x58DC68, Add, 0x0000004B),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFF2D),
		SetMemory(0x58DC68, Add, 0xFFFFFF6D),
		SetMemory(0x58DC64, Add, 0x00000117),
		SetMemory(0x58DC6C, Add, 0x00000157),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D3),
		SetMemory(0x58DC68, Add, 0x00000093),
		SetMemory(0x58DC64, Add, 0xFFFFFEE9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEA9),
		SetMemory(0x58DC60, Add, 0xFFFFFF09),
		SetMemory(0x58DC68, Add, 0xFFFFFF49),
		SetMemory(0x58DC64, Add, 0x000000D9),
		SetMemory(0x58DC6C, Add, 0x00000119),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F7),
		SetMemory(0x58DC68, Add, 0x000000B7),
		SetMemory(0x58DC64, Add, 0xFFFFFF27),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE7),
		SetMemory(0x58DC60, Add, 0xFFFFFEE5),
		SetMemory(0x58DC68, Add, 0xFFFFFF25),
		SetMemory(0x58DC64, Add, 0x0000009B),
		SetMemory(0x58DC6C, Add, 0x000000DB),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011B),
		SetMemory(0x58DC68, Add, 0x000000DB),
		SetMemory(0x58DC64, Add, 0xFFFFFF65),
		SetMemory(0x58DC6C, Add, 0xFFFFFF25),
		SetMemory(0x58DC60, Add, 0xFFFFFEC1),
		SetMemory(0x58DC68, Add, 0xFFFFFF01),
		SetMemory(0x58DC64, Add, 0x0000005C),
		SetMemory(0x58DC6C, Add, 0x0000009C),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000013F),
		SetMemory(0x58DC68, Add, 0x000000FF),
		SetMemory(0x58DC64, Add, 0xFFFFFFA4),
		SetMemory(0x58DC6C, Add, 0xFFFFFF64),
		SetMemory(0x58DC60, Add, 0xFFFFFE9C),
		SetMemory(0x58DC68, Add, 0xFFFFFEDC),
		SetMemory(0x58DC64, Add, 0x0000001E),
		SetMemory(0x58DC6C, Add, 0x0000005E),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000164),
		SetMemory(0x58DC68, Add, 0x00000124),
		SetMemory(0x58DC64, Add, 0xFFFFFFE2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA2),
		SetMemory(0x58DC60, Add, 0xFFFFFE78),
		SetMemory(0x58DC68, Add, 0xFFFFFEB8),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000188),
		SetMemory(0x58DC68, Add, 0x00000148),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFE9C),
		SetMemory(0x58DC68, Add, 0xFFFFFEDC),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000164),
		SetMemory(0x58DC68, Add, 0x00000124),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
		SetMemory(0x58DC60, Add, 0xFFFFFEC0),
		SetMemory(0x58DC68, Add, 0xFFFFFF00),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000140),
		SetMemory(0x58DC68, Add, 0x00000100),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0xFFFFFEE4),
		SetMemory(0x58DC68, Add, 0xFFFFFF24),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000011C),
		SetMemory(0x58DC68, Add, 0x000000DC),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0xFFFFFF08),
		SetMemory(0x58DC68, Add, 0xFFFFFF48),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8),
		SetMemory(0x58DC68, Add, 0x000000B8),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0xFFFFFF2C),
		SetMemory(0x58DC68, Add, 0xFFFFFF6C),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D4),
		SetMemory(0x58DC68, Add, 0x00000094),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0xFFFFFF74),
		SetMemory(0x58DC68, Add, 0xFFFFFFB4),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000008C),
		SetMemory(0x58DC68, Add, 0x0000004C),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0xFFFFFFBC),
		SetMemory(0x58DC68, Add, 0xFFFFFFFC),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000044),
		SetMemory(0x58DC68, Add, 0x00000004),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x00000003),
		SetMemory(0x58DC68, Add, 0x00000043),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFFD),
		SetMemory(0x58DC68, Add, 0xFFFFFFBD),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x0000004C),
		SetMemory(0x58DC68, Add, 0x0000008C),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFB4),
		SetMemory(0x58DC68, Add, 0xFFFFFF74),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x00000094),
		SetMemory(0x58DC68, Add, 0x000000D4),
		SetMemory(0x58DC64, Add, 0xFFFFFEA9),
		SetMemory(0x58DC6C, Add, 0xFFFFFEE9),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6C),
		SetMemory(0x58DC68, Add, 0xFFFFFF2C),
		SetMemory(0x58DC64, Add, 0x00000157),
		SetMemory(0x58DC6C, Add, 0x00000117),
		SetMemory(0x58DC60, Add, 0x000000B8),
		SetMemory(0x58DC68, Add, 0x000000F8),
		SetMemory(0x58DC64, Add, 0xFFFFFEE7),
		SetMemory(0x58DC6C, Add, 0xFFFFFF27),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48),
		SetMemory(0x58DC68, Add, 0xFFFFFF08),
		SetMemory(0x58DC64, Add, 0x00000119),
		SetMemory(0x58DC6C, Add, 0x000000D9),
		SetMemory(0x58DC60, Add, 0x000000DC),
		SetMemory(0x58DC68, Add, 0x0000011C),
		SetMemory(0x58DC64, Add, 0xFFFFFF25),
		SetMemory(0x58DC6C, Add, 0xFFFFFF65),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF24),
		SetMemory(0x58DC68, Add, 0xFFFFFEE4),
		SetMemory(0x58DC64, Add, 0x000000DB),
		SetMemory(0x58DC6C, Add, 0x0000009B),
		SetMemory(0x58DC60, Add, 0x00000100),
		SetMemory(0x58DC68, Add, 0x00000140),
		SetMemory(0x58DC64, Add, 0xFFFFFF64),
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF00),
		SetMemory(0x58DC68, Add, 0xFFFFFEC0),
		SetMemory(0x58DC64, Add, 0x0000009C),
		SetMemory(0x58DC6C, Add, 0x0000005C),
		SetMemory(0x58DC60, Add, 0x00000124),
		SetMemory(0x58DC68, Add, 0x00000164),
		SetMemory(0x58DC64, Add, 0xFFFFFFA2),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE2),
		Call_ZergSpawnSet_Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFEDC),
		SetMemory(0x58DC68, Add, 0xFFFFFE9C),
		SetMemory(0x58DC64, Add, 0x0000005E),
		SetMemory(0x58DC6C, Add, 0x0000001E),
	})
	end
	function Install_LairHive_Shape()
		
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFE0),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000020),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0xFFFFFFE0),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0x00000020),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0x000000EF),
		SetMemory(0x58DC68, Add, 0x0000012F),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF11),
		SetMemory(0x58DC68, Add, 0xFFFFFED1),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0x000000AB),
		SetMemory(0x58DC68, Add, 0x000000EB),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF55),
		SetMemory(0x58DC68, Add, 0xFFFFFF15),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0x00000067),
		SetMemory(0x58DC68, Add, 0x000000A7),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99),
		SetMemory(0x58DC68, Add, 0xFFFFFF59),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0x00000023),
		SetMemory(0x58DC68, Add, 0x00000063),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFDD),
		SetMemory(0x58DC68, Add, 0xFFFFFF9D),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0xFFFFFFE1),
		SetMemory(0x58DC68, Add, 0x00000020),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000001F),
		SetMemory(0x58DC68, Add, 0xFFFFFFE0),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0x000000EF),
		SetMemory(0x58DC6C, Add, 0x0000012F),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0xFFFFFF11),
		SetMemory(0x58DC6C, Add, 0xFFFFFED1),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0x000000AB),
		SetMemory(0x58DC6C, Add, 0x000000EB),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0xFFFFFF55),
		SetMemory(0x58DC6C, Add, 0xFFFFFF15),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0x00000067),
		SetMemory(0x58DC6C, Add, 0x000000A7),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0xFFFFFF99),
		SetMemory(0x58DC6C, Add, 0xFFFFFF59),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0x00000023),
		SetMemory(0x58DC6C, Add, 0x00000063),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0xFFFFFFDD),
		SetMemory(0x58DC6C, Add, 0xFFFFFF9D),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0xFFFFFFE1),
		SetMemory(0x58DC6C, Add, 0x00000020),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0x0000001F),
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0xFFFFFF9D),
		SetMemory(0x58DC6C, Add, 0xFFFFFFDD),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0x00000063),
		SetMemory(0x58DC6C, Add, 0x00000023),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0xFFFFFF59),
		SetMemory(0x58DC6C, Add, 0xFFFFFF99),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0x000000A7),
		SetMemory(0x58DC6C, Add, 0x00000067),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0xFFFFFF15),
		SetMemory(0x58DC6C, Add, 0xFFFFFF55),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0x000000EB),
		SetMemory(0x58DC6C, Add, 0x000000AB),
		SetMemory(0x58DC60, Add, 0xFFFFFED1),
		SetMemory(0x58DC68, Add, 0xFFFFFF11),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000012F),
		SetMemory(0x58DC68, Add, 0x000000EF),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0xFFFFFF15),
		SetMemory(0x58DC68, Add, 0xFFFFFF55),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000EB),
		SetMemory(0x58DC68, Add, 0x000000AB),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0xFFFFFF59),
		SetMemory(0x58DC68, Add, 0xFFFFFF99),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7),
		SetMemory(0x58DC68, Add, 0x00000067),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
		SetMemory(0x58DC60, Add, 0xFFFFFF9D),
		SetMemory(0x58DC68, Add, 0xFFFFFFDD),
		SetMemory(0x58DC64, Add, 0xFFFFFED1),
		SetMemory(0x58DC6C, Add, 0xFFFFFF11),
		Call_UnitIDV
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000063),
		SetMemory(0x58DC68, Add, 0x00000023),
		SetMemory(0x58DC64, Add, 0x0000012F),
		SetMemory(0x58DC6C, Add, 0x000000EF),
	})
	
	end
	function Install_LairHeroShape()
		
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000000D);
		SetMemory(0x58DC68, Add, 0x0000004D);
		SetMemory(0x58DC64, Add, 0xFFFFFFB3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF3);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF3);
		SetMemory(0x58DC68, Add, 0xFFFFFFB3);
		SetMemory(0x58DC64, Add, 0x0000004D);
		SetMemory(0x58DC6C, Add, 0x0000000D);
		SetMemory(0x58DC60, Add, 0x0000000D);
		SetMemory(0x58DC68, Add, 0x0000004D);
		SetMemory(0x58DC64, Add, 0x0000000D);
		SetMemory(0x58DC6C, Add, 0x0000004D);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF3);
		SetMemory(0x58DC68, Add, 0xFFFFFFB3);
		SetMemory(0x58DC64, Add, 0xFFFFFFF3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB3);
		SetMemory(0x58DC60, Add, 0xFFFFFFB3);
		SetMemory(0x58DC68, Add, 0xFFFFFFF3);
		SetMemory(0x58DC64, Add, 0x0000000D);
		SetMemory(0x58DC6C, Add, 0x0000004D);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000004D);
		SetMemory(0x58DC68, Add, 0x0000000D);
		SetMemory(0x58DC64, Add, 0xFFFFFFF3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB3);
		SetMemory(0x58DC60, Add, 0xFFFFFFB3);
		SetMemory(0x58DC68, Add, 0xFFFFFFF3);
		SetMemory(0x58DC64, Add, 0xFFFFFFB3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF3);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000004D);
		SetMemory(0x58DC68, Add, 0x0000000D);
		SetMemory(0x58DC64, Add, 0x0000004D);
		SetMemory(0x58DC6C, Add, 0x0000000D);
		SetMemory(0x58DC60, Add, 0x0000003A);
		SetMemory(0x58DC68, Add, 0x0000007A);
		SetMemory(0x58DC64, Add, 0xFFFFFF86);
		SetMemory(0x58DC6C, Add, 0xFFFFFFC6);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC6);
		SetMemory(0x58DC68, Add, 0xFFFFFF86);
		SetMemory(0x58DC64, Add, 0x0000007A);
		SetMemory(0x58DC6C, Add, 0x0000003A);
		SetMemory(0x58DC60, Add, 0x0000003A);
		SetMemory(0x58DC68, Add, 0x0000007A);
		SetMemory(0x58DC64, Add, 0x0000003A);
		SetMemory(0x58DC6C, Add, 0x0000007A);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC6);
		SetMemory(0x58DC68, Add, 0xFFFFFF86);
		SetMemory(0x58DC64, Add, 0xFFFFFFC6);
		SetMemory(0x58DC6C, Add, 0xFFFFFF86);
		SetMemory(0x58DC60, Add, 0xFFFFFF86);
		SetMemory(0x58DC68, Add, 0xFFFFFFC6);
		SetMemory(0x58DC64, Add, 0x0000003A);
		SetMemory(0x58DC6C, Add, 0x0000007A);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007A);
		SetMemory(0x58DC68, Add, 0x0000003A);
		SetMemory(0x58DC64, Add, 0xFFFFFFC6);
		SetMemory(0x58DC6C, Add, 0xFFFFFF86);
		SetMemory(0x58DC60, Add, 0xFFFFFF86);
		SetMemory(0x58DC68, Add, 0xFFFFFFC6);
		SetMemory(0x58DC64, Add, 0xFFFFFF86);
		SetMemory(0x58DC6C, Add, 0xFFFFFFC6);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007A);
		SetMemory(0x58DC68, Add, 0x0000003A);
		SetMemory(0x58DC64, Add, 0x0000007A);
		SetMemory(0x58DC6C, Add, 0x0000003A);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
		SetMemory(0x58DC60, Add, 0x00000095);
		SetMemory(0x58DC68, Add, 0x000000D5);
		SetMemory(0x58DC64, Add, 0xFFFFFF2B);
		SetMemory(0x58DC6C, Add, 0xFFFFFF6B);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6B);
		SetMemory(0x58DC68, Add, 0xFFFFFF2B);
		SetMemory(0x58DC64, Add, 0x000000D5);
		SetMemory(0x58DC6C, Add, 0x00000095);
		SetMemory(0x58DC60, Add, 0x00000095);
		SetMemory(0x58DC68, Add, 0x000000D5);
		SetMemory(0x58DC64, Add, 0x00000095);
		SetMemory(0x58DC6C, Add, 0x000000D5);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF6B);
		SetMemory(0x58DC68, Add, 0xFFFFFF2B);
		SetMemory(0x58DC64, Add, 0xFFFFFF6B);
		SetMemory(0x58DC6C, Add, 0xFFFFFF2B);
		SetMemory(0x58DC60, Add, 0xFFFFFF2B);
		SetMemory(0x58DC68, Add, 0xFFFFFF6B);
		SetMemory(0x58DC64, Add, 0x00000095);
		SetMemory(0x58DC6C, Add, 0x000000D5);
		Call_UnitIDVLair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000D5);
		SetMemory(0x58DC68, Add, 0x00000095);
		SetMemory(0x58DC64, Add, 0xFFFFFF6B);
		SetMemory(0x58DC6C, Add, 0xFFFFFF2B);
		SetMemory(0x58DC60, Add, 0xFFFFFF2B);
		SetMemory(0x58DC68, Add, 0xFFFFFF6B);
		SetMemory(0x58DC64, Add, 0xFFFFFF2B);
		SetMemory(0x58DC6C, Add, 0xFFFFFF6B);
		Call_UnitIDVLair
	})
	DoActions(FP,{
		SetMemory(0x58DC60, Add, 0x000000D5);
		SetMemory(0x58DC68, Add, 0x00000095);
		SetMemory(0x58DC64, Add, 0x000000D5);
		SetMemory(0x58DC6C, Add, 0x00000095);
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000000);
		SetMemory(0x58DC68, Add, 0x00000040);
		SetMemory(0x58DC64, Add, 0xFFFFFFA9);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE9);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000000);
		SetMemory(0x58DC68, Add, 0xFFFFFFC0);
		SetMemory(0x58DC64, Add, 0x00000057);
		SetMemory(0x58DC6C, Add, 0x00000017);
		SetMemory(0x58DC60, Add, 0x00000020);
		SetMemory(0x58DC68, Add, 0x00000060);
		SetMemory(0x58DC64, Add, 0xFFFFFFE0);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFE0);
		SetMemory(0x58DC68, Add, 0xFFFFFFA0);
		SetMemory(0x58DC64, Add, 0x00000020);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0x00000000);
		SetMemory(0x58DC68, Add, 0x00000040);
		SetMemory(0x58DC64, Add, 0x00000017);
		SetMemory(0x58DC6C, Add, 0x00000057);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000000);
		SetMemory(0x58DC68, Add, 0xFFFFFFC0);
		SetMemory(0x58DC64, Add, 0xFFFFFFE9);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA9);
		SetMemory(0x58DC60, Add, 0xFFFFFFC1);
		SetMemory(0x58DC68, Add, 0x00000000);
		SetMemory(0x58DC64, Add, 0x00000017);
		SetMemory(0x58DC6C, Add, 0x00000057);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000003F);
		SetMemory(0x58DC68, Add, 0x00000000);
		SetMemory(0x58DC64, Add, 0xFFFFFFE9);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA9);
		SetMemory(0x58DC60, Add, 0xFFFFFFA0);
		SetMemory(0x58DC68, Add, 0xFFFFFFE0);
		SetMemory(0x58DC64, Add, 0xFFFFFFE1);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000060);
		SetMemory(0x58DC68, Add, 0x00000020);
		SetMemory(0x58DC64, Add, 0x0000001F);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0xFFFFFFC0);
		SetMemory(0x58DC68, Add, 0x00000000);
		SetMemory(0x58DC64, Add, 0xFFFFFFA9);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE9);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000040);
		SetMemory(0x58DC68, Add, 0x00000000);
		SetMemory(0x58DC64, Add, 0x00000057);
		SetMemory(0x58DC6C, Add, 0x00000017);
		SetMemory(0x58DC60, Add, 0x00000020);
		SetMemory(0x58DC68, Add, 0x00000060);
		SetMemory(0x58DC64, Add, 0xFFFFFF72);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFE0);
		SetMemory(0x58DC68, Add, 0xFFFFFFA0);
		SetMemory(0x58DC64, Add, 0x0000008E);
		SetMemory(0x58DC6C, Add, 0x0000004E);
		SetMemory(0x58DC60, Add, 0x00000060);
		SetMemory(0x58DC68, Add, 0x000000A0);
		SetMemory(0x58DC64, Add, 0xFFFFFFE0);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFA0);
		SetMemory(0x58DC68, Add, 0xFFFFFF60);
		SetMemory(0x58DC64, Add, 0x00000020);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0x00000020);
		SetMemory(0x58DC68, Add, 0x00000060);
		SetMemory(0x58DC64, Add, 0x0000004E);
		SetMemory(0x58DC6C, Add, 0x0000008E);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFE0);
		SetMemory(0x58DC68, Add, 0xFFFFFFA0);
		SetMemory(0x58DC64, Add, 0xFFFFFFB2);
		SetMemory(0x58DC6C, Add, 0xFFFFFF72);
		SetMemory(0x58DC60, Add, 0xFFFFFFA1);
		SetMemory(0x58DC68, Add, 0xFFFFFFE1);
		SetMemory(0x58DC64, Add, 0x0000004E);
		SetMemory(0x58DC6C, Add, 0x0000008E);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000005F);
		SetMemory(0x58DC68, Add, 0x0000001F);
		SetMemory(0x58DC64, Add, 0xFFFFFFB2);
		SetMemory(0x58DC6C, Add, 0xFFFFFF72);
		SetMemory(0x58DC60, Add, 0xFFFFFF60);
		SetMemory(0x58DC68, Add, 0xFFFFFFA0);
		SetMemory(0x58DC64, Add, 0xFFFFFFE1);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A0);
		SetMemory(0x58DC68, Add, 0x00000060);
		SetMemory(0x58DC64, Add, 0x0000001F);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0xFFFFFFA0);
		SetMemory(0x58DC68, Add, 0xFFFFFFE0);
		SetMemory(0x58DC64, Add, 0xFFFFFF72);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB2);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000060);
		SetMemory(0x58DC68, Add, 0x00000020);
		SetMemory(0x58DC64, Add, 0x0000008E);
		SetMemory(0x58DC6C, Add, 0x0000004E);
		SetMemory(0x58DC60, Add, 0x00000040);
		SetMemory(0x58DC68, Add, 0x00000080);
		SetMemory(0x58DC64, Add, 0xFFFFFF3A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF7A);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC0);
		SetMemory(0x58DC68, Add, 0xFFFFFF80);
		SetMemory(0x58DC64, Add, 0x000000C6);
		SetMemory(0x58DC6C, Add, 0x00000086);
		SetMemory(0x58DC60, Add, 0x000000A0);
		SetMemory(0x58DC68, Add, 0x000000E0);
		SetMemory(0x58DC64, Add, 0xFFFFFFE0);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF60);
		SetMemory(0x58DC68, Add, 0xFFFFFF20);
		SetMemory(0x58DC64, Add, 0x00000020);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0x00000040);
		SetMemory(0x58DC68, Add, 0x00000080);
		SetMemory(0x58DC64, Add, 0x00000086);
		SetMemory(0x58DC6C, Add, 0x000000C6);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC0);
		SetMemory(0x58DC68, Add, 0xFFFFFF80);
		SetMemory(0x58DC64, Add, 0xFFFFFF7A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF3A);
		SetMemory(0x58DC60, Add, 0xFFFFFF81);
		SetMemory(0x58DC68, Add, 0xFFFFFFC1);
		SetMemory(0x58DC64, Add, 0x00000086);
		SetMemory(0x58DC6C, Add, 0x000000C6);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007F);
		SetMemory(0x58DC68, Add, 0x0000003F);
		SetMemory(0x58DC64, Add, 0xFFFFFF7A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF3A);
		SetMemory(0x58DC60, Add, 0xFFFFFF20);
		SetMemory(0x58DC68, Add, 0xFFFFFF60);
		SetMemory(0x58DC64, Add, 0xFFFFFFE1);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000E0);
		SetMemory(0x58DC68, Add, 0x000000A0);
		SetMemory(0x58DC64, Add, 0x0000001F);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0xFFFFFF80);
		SetMemory(0x58DC68, Add, 0xFFFFFFC0);
		SetMemory(0x58DC64, Add, 0xFFFFFF3A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF7A);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000080);
		SetMemory(0x58DC68, Add, 0x00000040);
		SetMemory(0x58DC64, Add, 0x000000C6);
		SetMemory(0x58DC6C, Add, 0x00000086);
		SetMemory(0x58DC60, Add, 0x00000060);
		SetMemory(0x58DC68, Add, 0x000000A0);
		SetMemory(0x58DC64, Add, 0xFFFFFF03);
		SetMemory(0x58DC6C, Add, 0xFFFFFF43);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFA0);
		SetMemory(0x58DC68, Add, 0xFFFFFF60);
		SetMemory(0x58DC64, Add, 0x000000FD);
		SetMemory(0x58DC6C, Add, 0x000000BD);
		SetMemory(0x58DC60, Add, 0x000000E0);
		SetMemory(0x58DC68, Add, 0x00000120);
		SetMemory(0x58DC64, Add, 0xFFFFFFE0);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF20);
		SetMemory(0x58DC68, Add, 0xFFFFFEE0);
		SetMemory(0x58DC64, Add, 0x00000020);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0x00000060);
		SetMemory(0x58DC68, Add, 0x000000A0);
		SetMemory(0x58DC64, Add, 0x000000BD);
		SetMemory(0x58DC6C, Add, 0x000000FD);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFA0);
		SetMemory(0x58DC68, Add, 0xFFFFFF60);
		SetMemory(0x58DC64, Add, 0xFFFFFF43);
		SetMemory(0x58DC6C, Add, 0xFFFFFF03);
		SetMemory(0x58DC60, Add, 0xFFFFFF61);
		SetMemory(0x58DC68, Add, 0xFFFFFFA1);
		SetMemory(0x58DC64, Add, 0x000000BD);
		SetMemory(0x58DC6C, Add, 0x000000FD);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000009F);
		SetMemory(0x58DC68, Add, 0x0000005F);
		SetMemory(0x58DC64, Add, 0xFFFFFF43);
		SetMemory(0x58DC6C, Add, 0xFFFFFF03);
		SetMemory(0x58DC60, Add, 0xFFFFFEE0);
		SetMemory(0x58DC68, Add, 0xFFFFFF20);
		SetMemory(0x58DC64, Add, 0xFFFFFFE1);
		SetMemory(0x58DC6C, Add, 0x00000020);
		Call_UnitIDV2Lair
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000120);
		SetMemory(0x58DC68, Add, 0x000000E0);
		SetMemory(0x58DC64, Add, 0x0000001F);
		SetMemory(0x58DC6C, Add, 0xFFFFFFE0);
		SetMemory(0x58DC60, Add, 0xFFFFFF60);
		SetMemory(0x58DC68, Add, 0xFFFFFFA0);
		SetMemory(0x58DC64, Add, 0xFFFFFF03);
		SetMemory(0x58DC6C, Add, 0xFFFFFF43);
		Call_UnitIDV2Lair
	})
	DoActions(FP,{
		SetMemory(0x58DC60, Add, 0x000000A0);
		SetMemory(0x58DC68, Add, 0x00000060);
		SetMemory(0x58DC64, Add, 0x000000FD);
		SetMemory(0x58DC6C, Add, 0x000000BD);
	})
	end
	function Install_HiveHeroShape()
		
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000000D);
		SetMemory(0x58DC68, Add, 0x0000004D);
		SetMemory(0x58DC64, Add, 0xFFFFFF86);
		SetMemory(0x58DC6C, Add, 0xFFFFFFC6);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF3);
		SetMemory(0x58DC68, Add, 0xFFFFFFB3);
		SetMemory(0x58DC64, Add, 0x0000007A);
		SetMemory(0x58DC6C, Add, 0x0000003A);
		SetMemory(0x58DC60, Add, 0x0000003A);
		SetMemory(0x58DC68, Add, 0x0000007A);
		SetMemory(0x58DC64, Add, 0xFFFFFFB3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF3);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC6);
		SetMemory(0x58DC68, Add, 0xFFFFFF86);
		SetMemory(0x58DC64, Add, 0x0000004D);
		SetMemory(0x58DC6C, Add, 0x0000000D);
		SetMemory(0x58DC60, Add, 0x0000003A);
		SetMemory(0x58DC68, Add, 0x0000007A);
		SetMemory(0x58DC64, Add, 0x0000000D);
		SetMemory(0x58DC6C, Add, 0x0000004D);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC6);
		SetMemory(0x58DC68, Add, 0xFFFFFF86);
		SetMemory(0x58DC64, Add, 0xFFFFFFF3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB3);
		SetMemory(0x58DC60, Add, 0x0000000D);
		SetMemory(0x58DC68, Add, 0x0000004D);
		SetMemory(0x58DC64, Add, 0x0000003A);
		SetMemory(0x58DC6C, Add, 0x0000007A);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF3);
		SetMemory(0x58DC68, Add, 0xFFFFFFB3);
		SetMemory(0x58DC64, Add, 0xFFFFFFC6);
		SetMemory(0x58DC6C, Add, 0xFFFFFF86);
		SetMemory(0x58DC60, Add, 0xFFFFFFB3);
		SetMemory(0x58DC68, Add, 0xFFFFFFF3);
		SetMemory(0x58DC64, Add, 0x0000003A);
		SetMemory(0x58DC6C, Add, 0x0000007A);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000004D);
		SetMemory(0x58DC68, Add, 0x0000000D);
		SetMemory(0x58DC64, Add, 0xFFFFFFC6);
		SetMemory(0x58DC6C, Add, 0xFFFFFF86);
		SetMemory(0x58DC60, Add, 0xFFFFFF86);
		SetMemory(0x58DC68, Add, 0xFFFFFFC6);
		SetMemory(0x58DC64, Add, 0x0000000D);
		SetMemory(0x58DC6C, Add, 0x0000004D);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007A);
		SetMemory(0x58DC68, Add, 0x0000003A);
		SetMemory(0x58DC64, Add, 0xFFFFFFF3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB3);
		SetMemory(0x58DC60, Add, 0xFFFFFF86);
		SetMemory(0x58DC68, Add, 0xFFFFFFC6);
		SetMemory(0x58DC64, Add, 0xFFFFFFB3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF3);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007A);
		SetMemory(0x58DC68, Add, 0x0000003A);
		SetMemory(0x58DC64, Add, 0x0000004D);
		SetMemory(0x58DC6C, Add, 0x0000000D);
		SetMemory(0x58DC60, Add, 0xFFFFFFB3);
		SetMemory(0x58DC68, Add, 0xFFFFFFF3);
		SetMemory(0x58DC64, Add, 0xFFFFFF86);
		SetMemory(0x58DC6C, Add, 0xFFFFFFC6);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000004D);
		SetMemory(0x58DC68, Add, 0x0000000D);
		SetMemory(0x58DC64, Add, 0x0000007A);
		SetMemory(0x58DC6C, Add, 0x0000003A);
		SetMemory(0x58DC60, Add, 0x0000000D);
		SetMemory(0x58DC68, Add, 0x0000004D);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF3);
		SetMemory(0x58DC68, Add, 0xFFFFFFB3);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
		SetMemory(0x58DC60, Add, 0x0000003A);
		SetMemory(0x58DC68, Add, 0x0000007A);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC6);
		SetMemory(0x58DC68, Add, 0xFFFFFF86);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0xFFFFFF86);
		SetMemory(0x58DC6C, Add, 0xFFFFFFC6);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0x0000007A);
		SetMemory(0x58DC6C, Add, 0x0000003A);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0xFFFFFFB3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF3);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0x0000004D);
		SetMemory(0x58DC6C, Add, 0x0000000D);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0x0000000D);
		SetMemory(0x58DC6C, Add, 0x0000004D);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0xFFFFFFF3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB3);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0x0000003A);
		SetMemory(0x58DC6C, Add, 0x0000007A);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0xFFFFFFC6);
		SetMemory(0x58DC6C, Add, 0xFFFFFF86);
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x000000A7);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFF59);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0x0000003A);
		SetMemory(0x58DC68, Add, 0x0000007A);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC6);
		SetMemory(0x58DC68, Add, 0xFFFFFF86);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0x0000000D);
		SetMemory(0x58DC68, Add, 0x0000004D);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF3);
		SetMemory(0x58DC68, Add, 0xFFFFFFB3);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0xFFFFFFB3);
		SetMemory(0x58DC68, Add, 0xFFFFFFF3);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000004D);
		SetMemory(0x58DC68, Add, 0x0000000D);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0xFFFFFF86);
		SetMemory(0x58DC68, Add, 0xFFFFFFC6);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007A);
		SetMemory(0x58DC68, Add, 0x0000003A);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0x00000067);
		SetMemory(0x58DC6C, Add, 0x000000A7);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0xFFFFFF99);
		SetMemory(0x58DC6C, Add, 0xFFFFFF59);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0x0000003A);
		SetMemory(0x58DC6C, Add, 0x0000007A);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0xFFFFFFC6);
		SetMemory(0x58DC6C, Add, 0xFFFFFF86);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0x0000000D);
		SetMemory(0x58DC6C, Add, 0x0000004D);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0xFFFFFFF3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB3);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0xFFFFFFB3);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF3);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0x0000004D);
		SetMemory(0x58DC6C, Add, 0x0000000D);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0xFFFFFF86);
		SetMemory(0x58DC6C, Add, 0xFFFFFFC6);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0x0000007A);
		SetMemory(0x58DC6C, Add, 0x0000003A);
		SetMemory(0x58DC60, Add, 0xFFFFFF59);
		SetMemory(0x58DC68, Add, 0xFFFFFF99);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000A7);
		SetMemory(0x58DC68, Add, 0x00000067);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
		SetMemory(0x58DC60, Add, 0xFFFFFF86);
		SetMemory(0x58DC68, Add, 0xFFFFFFC6);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVHive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007A);
		SetMemory(0x58DC68, Add, 0x0000003A);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
		SetMemory(0x58DC60, Add, 0xFFFFFFB3);
		SetMemory(0x58DC68, Add, 0xFFFFFFF3);
		SetMemory(0x58DC64, Add, 0xFFFFFF59);
		SetMemory(0x58DC6C, Add, 0xFFFFFF99);
		Call_UnitIDVHive
	})
	DoActions(FP,{
		SetMemory(0x58DC60, Add, 0x0000004D);
		SetMemory(0x58DC68, Add, 0x0000000D);
		SetMemory(0x58DC64, Add, 0x000000A7);
		SetMemory(0x58DC6C, Add, 0x00000067);
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000058);
		SetMemory(0x58DC68, Add, 0x00000098);
		SetMemory(0x58DC64, Add, 0x00000009);
		SetMemory(0x58DC6C, Add, 0x00000049);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFA8);
		SetMemory(0x58DC68, Add, 0xFFFFFF68);
		SetMemory(0x58DC64, Add, 0xFFFFFFF7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB7);
		SetMemory(0x58DC60, Add, 0x00000040);
		SetMemory(0x58DC68, Add, 0x00000080);
		SetMemory(0x58DC64, Add, 0x00000033);
		SetMemory(0x58DC6C, Add, 0x00000073);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC0);
		SetMemory(0x58DC68, Add, 0xFFFFFF80);
		SetMemory(0x58DC64, Add, 0xFFFFFFCD);
		SetMemory(0x58DC6C, Add, 0xFFFFFF8D);
		SetMemory(0x58DC60, Add, 0xFFFFFFF9);
		SetMemory(0x58DC68, Add, 0x00000038);
		SetMemory(0x58DC64, Add, 0x0000005C);
		SetMemory(0x58DC6C, Add, 0x0000009C);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000007);
		SetMemory(0x58DC68, Add, 0xFFFFFFC8);
		SetMemory(0x58DC64, Add, 0xFFFFFFA4);
		SetMemory(0x58DC6C, Add, 0xFFFFFF64);
		SetMemory(0x58DC60, Add, 0xFFFFFFC9);
		SetMemory(0x58DC68, Add, 0x00000008);
		SetMemory(0x58DC64, Add, 0x0000005C);
		SetMemory(0x58DC6C, Add, 0x0000009C);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000037);
		SetMemory(0x58DC68, Add, 0xFFFFFFF8);
		SetMemory(0x58DC64, Add, 0xFFFFFFA4);
		SetMemory(0x58DC6C, Add, 0xFFFFFF64);
		SetMemory(0x58DC60, Add, 0xFFFFFF81);
		SetMemory(0x58DC68, Add, 0xFFFFFFC1);
		SetMemory(0x58DC64, Add, 0x00000033);
		SetMemory(0x58DC6C, Add, 0x00000073);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000007F);
		SetMemory(0x58DC68, Add, 0x0000003F);
		SetMemory(0x58DC64, Add, 0xFFFFFFCD);
		SetMemory(0x58DC6C, Add, 0xFFFFFF8D);
		SetMemory(0x58DC60, Add, 0xFFFFFF68);
		SetMemory(0x58DC68, Add, 0xFFFFFFA8);
		SetMemory(0x58DC64, Add, 0x00000009);
		SetMemory(0x58DC6C, Add, 0x00000049);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000098);
		SetMemory(0x58DC68, Add, 0x00000058);
		SetMemory(0x58DC64, Add, 0xFFFFFFF7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB7);
		SetMemory(0x58DC60, Add, 0xFFFFFF68);
		SetMemory(0x58DC68, Add, 0xFFFFFFA8);
		SetMemory(0x58DC64, Add, 0xFFFFFFB7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF7);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000098);
		SetMemory(0x58DC68, Add, 0x00000058);
		SetMemory(0x58DC64, Add, 0x00000049);
		SetMemory(0x58DC6C, Add, 0x00000009);
		SetMemory(0x58DC60, Add, 0xFFFFFF80);
		SetMemory(0x58DC68, Add, 0xFFFFFFC0);
		SetMemory(0x58DC64, Add, 0xFFFFFF8D);
		SetMemory(0x58DC6C, Add, 0xFFFFFFCD);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000080);
		SetMemory(0x58DC68, Add, 0x00000040);
		SetMemory(0x58DC64, Add, 0x00000073);
		SetMemory(0x58DC6C, Add, 0x00000033);
		SetMemory(0x58DC60, Add, 0xFFFFFFC8);
		SetMemory(0x58DC68, Add, 0x00000007);
		SetMemory(0x58DC64, Add, 0xFFFFFF64);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000038);
		SetMemory(0x58DC68, Add, 0xFFFFFFF9);
		SetMemory(0x58DC64, Add, 0x0000009C);
		SetMemory(0x58DC6C, Add, 0x0000005C);
		SetMemory(0x58DC60, Add, 0xFFFFFFF8);
		SetMemory(0x58DC68, Add, 0x00000037);
		SetMemory(0x58DC64, Add, 0xFFFFFF64);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000008);
		SetMemory(0x58DC68, Add, 0xFFFFFFC9);
		SetMemory(0x58DC64, Add, 0x0000009C);
		SetMemory(0x58DC6C, Add, 0x0000005C);
		SetMemory(0x58DC60, Add, 0x00000040);
		SetMemory(0x58DC68, Add, 0x00000080);
		SetMemory(0x58DC64, Add, 0xFFFFFF8D);
		SetMemory(0x58DC6C, Add, 0xFFFFFFCD);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFC0);
		SetMemory(0x58DC68, Add, 0xFFFFFF80);
		SetMemory(0x58DC64, Add, 0x00000073);
		SetMemory(0x58DC6C, Add, 0x00000033);
		SetMemory(0x58DC60, Add, 0x00000058);
		SetMemory(0x58DC68, Add, 0x00000098);
		SetMemory(0x58DC64, Add, 0xFFFFFFB7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF7);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFA8);
		SetMemory(0x58DC68, Add, 0xFFFFFF68);
		SetMemory(0x58DC64, Add, 0x00000049);
		SetMemory(0x58DC6C, Add, 0x00000009);
		SetMemory(0x58DC60, Add, 0x00000088);
		SetMemory(0x58DC68, Add, 0x000000C8);
		SetMemory(0x58DC64, Add, 0x00000009);
		SetMemory(0x58DC6C, Add, 0x00000049);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF78);
		SetMemory(0x58DC68, Add, 0xFFFFFF38);
		SetMemory(0x58DC64, Add, 0xFFFFFFF7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB7);
		SetMemory(0x58DC60, Add, 0x00000058);
		SetMemory(0x58DC68, Add, 0x00000098);
		SetMemory(0x58DC64, Add, 0x0000005C);
		SetMemory(0x58DC6C, Add, 0x0000009C);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFA8);
		SetMemory(0x58DC68, Add, 0xFFFFFF68);
		SetMemory(0x58DC64, Add, 0xFFFFFFA4);
		SetMemory(0x58DC6C, Add, 0xFFFFFF64);
		SetMemory(0x58DC60, Add, 0x00000010);
		SetMemory(0x58DC68, Add, 0x00000050);
		SetMemory(0x58DC64, Add, 0x00000086);
		SetMemory(0x58DC6C, Add, 0x000000C6);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF0);
		SetMemory(0x58DC68, Add, 0xFFFFFFB0);
		SetMemory(0x58DC64, Add, 0xFFFFFF7A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF3A);
		SetMemory(0x58DC60, Add, 0xFFFFFFB1);
		SetMemory(0x58DC68, Add, 0xFFFFFFF1);
		SetMemory(0x58DC64, Add, 0x00000086);
		SetMemory(0x58DC6C, Add, 0x000000C6);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x0000004F);
		SetMemory(0x58DC68, Add, 0x0000000F);
		SetMemory(0x58DC64, Add, 0xFFFFFF7A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF3A);
		SetMemory(0x58DC60, Add, 0xFFFFFF69);
		SetMemory(0x58DC68, Add, 0xFFFFFFA9);
		SetMemory(0x58DC64, Add, 0x0000005C);
		SetMemory(0x58DC6C, Add, 0x0000009C);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000097);
		SetMemory(0x58DC68, Add, 0x00000057);
		SetMemory(0x58DC64, Add, 0xFFFFFFA4);
		SetMemory(0x58DC6C, Add, 0xFFFFFF64);
		SetMemory(0x58DC60, Add, 0xFFFFFF38);
		SetMemory(0x58DC68, Add, 0xFFFFFF78);
		SetMemory(0x58DC64, Add, 0x00000009);
		SetMemory(0x58DC6C, Add, 0x00000049);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000C8);
		SetMemory(0x58DC68, Add, 0x00000088);
		SetMemory(0x58DC64, Add, 0xFFFFFFF7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB7);
		SetMemory(0x58DC60, Add, 0xFFFFFF38);
		SetMemory(0x58DC68, Add, 0xFFFFFF78);
		SetMemory(0x58DC64, Add, 0xFFFFFFB7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF7);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000C8);
		SetMemory(0x58DC68, Add, 0x00000088);
		SetMemory(0x58DC64, Add, 0x00000049);
		SetMemory(0x58DC6C, Add, 0x00000009);
		SetMemory(0x58DC60, Add, 0xFFFFFF68);
		SetMemory(0x58DC68, Add, 0xFFFFFFA8);
		SetMemory(0x58DC64, Add, 0xFFFFFF64);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000098);
		SetMemory(0x58DC68, Add, 0x00000058);
		SetMemory(0x58DC64, Add, 0x0000009C);
		SetMemory(0x58DC6C, Add, 0x0000005C);
		SetMemory(0x58DC60, Add, 0xFFFFFFB0);
		SetMemory(0x58DC68, Add, 0xFFFFFFF0);
		SetMemory(0x58DC64, Add, 0xFFFFFF3A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF7A);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000050);
		SetMemory(0x58DC68, Add, 0x00000010);
		SetMemory(0x58DC64, Add, 0x000000C6);
		SetMemory(0x58DC6C, Add, 0x00000086);
		SetMemory(0x58DC60, Add, 0x00000010);
		SetMemory(0x58DC68, Add, 0x00000050);
		SetMemory(0x58DC64, Add, 0xFFFFFF3A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF7A);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFF0);
		SetMemory(0x58DC68, Add, 0xFFFFFFB0);
		SetMemory(0x58DC64, Add, 0x000000C6);
		SetMemory(0x58DC6C, Add, 0x00000086);
		SetMemory(0x58DC60, Add, 0x00000058);
		SetMemory(0x58DC68, Add, 0x00000098);
		SetMemory(0x58DC64, Add, 0xFFFFFF64);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFA8);
		SetMemory(0x58DC68, Add, 0xFFFFFF68);
		SetMemory(0x58DC64, Add, 0x0000009C);
		SetMemory(0x58DC6C, Add, 0x0000005C);
		SetMemory(0x58DC60, Add, 0x00000088);
		SetMemory(0x58DC68, Add, 0x000000C8);
		SetMemory(0x58DC64, Add, 0xFFFFFFB7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF7);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF78);
		SetMemory(0x58DC68, Add, 0xFFFFFF38);
		SetMemory(0x58DC64, Add, 0x00000049);
		SetMemory(0x58DC6C, Add, 0x00000009);
		SetMemory(0x58DC60, Add, 0x000000B8);
		SetMemory(0x58DC68, Add, 0x000000F8);
		SetMemory(0x58DC64, Add, 0x00000009);
		SetMemory(0x58DC6C, Add, 0x00000049);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48);
		SetMemory(0x58DC68, Add, 0xFFFFFF08);
		SetMemory(0x58DC64, Add, 0xFFFFFFF7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB7);
		SetMemory(0x58DC60, Add, 0x000000A0);
		SetMemory(0x58DC68, Add, 0x000000E0);
		SetMemory(0x58DC64, Add, 0x00000033);
		SetMemory(0x58DC6C, Add, 0x00000073);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF60);
		SetMemory(0x58DC68, Add, 0xFFFFFF20);
		SetMemory(0x58DC64, Add, 0xFFFFFFCD);
		SetMemory(0x58DC6C, Add, 0xFFFFFF8D);
		SetMemory(0x58DC60, Add, 0x00000088);
		SetMemory(0x58DC68, Add, 0x000000C8);
		SetMemory(0x58DC64, Add, 0x0000005C);
		SetMemory(0x58DC6C, Add, 0x0000009C);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF78);
		SetMemory(0x58DC68, Add, 0xFFFFFF38);
		SetMemory(0x58DC64, Add, 0xFFFFFFA4);
		SetMemory(0x58DC6C, Add, 0xFFFFFF64);
		SetMemory(0x58DC60, Add, 0x00000070);
		SetMemory(0x58DC68, Add, 0x000000B0);
		SetMemory(0x58DC64, Add, 0x00000086);
		SetMemory(0x58DC6C, Add, 0x000000C6);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90);
		SetMemory(0x58DC68, Add, 0xFFFFFF50);
		SetMemory(0x58DC64, Add, 0xFFFFFF7A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF3A);
		SetMemory(0x58DC60, Add, 0x00000028);
		SetMemory(0x58DC68, Add, 0x00000068);
		SetMemory(0x58DC64, Add, 0x000000AF);
		SetMemory(0x58DC6C, Add, 0x000000EF);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8);
		SetMemory(0x58DC68, Add, 0xFFFFFF98);
		SetMemory(0x58DC64, Add, 0xFFFFFF51);
		SetMemory(0x58DC6C, Add, 0xFFFFFF11);
		SetMemory(0x58DC60, Add, 0xFFFFFFF9);
		SetMemory(0x58DC68, Add, 0x00000038);
		SetMemory(0x58DC64, Add, 0x000000AF);
		SetMemory(0x58DC6C, Add, 0x000000EF);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000007);
		SetMemory(0x58DC68, Add, 0xFFFFFFC8);
		SetMemory(0x58DC64, Add, 0xFFFFFF51);
		SetMemory(0x58DC6C, Add, 0xFFFFFF11);
		SetMemory(0x58DC60, Add, 0xFFFFFFC9);
		SetMemory(0x58DC68, Add, 0x00000008);
		SetMemory(0x58DC64, Add, 0x000000AF);
		SetMemory(0x58DC6C, Add, 0x000000EF);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000037);
		SetMemory(0x58DC68, Add, 0xFFFFFFF8);
		SetMemory(0x58DC64, Add, 0xFFFFFF51);
		SetMemory(0x58DC6C, Add, 0xFFFFFF11);
		SetMemory(0x58DC60, Add, 0xFFFFFF99);
		SetMemory(0x58DC68, Add, 0xFFFFFFD9);
		SetMemory(0x58DC64, Add, 0x000000AF);
		SetMemory(0x58DC6C, Add, 0x000000EF);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000067);
		SetMemory(0x58DC68, Add, 0x00000027);
		SetMemory(0x58DC64, Add, 0xFFFFFF51);
		SetMemory(0x58DC6C, Add, 0xFFFFFF11);
		SetMemory(0x58DC60, Add, 0xFFFFFF51);
		SetMemory(0x58DC68, Add, 0xFFFFFF91);
		SetMemory(0x58DC64, Add, 0x00000086);
		SetMemory(0x58DC6C, Add, 0x000000C6);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000AF);
		SetMemory(0x58DC68, Add, 0x0000006F);
		SetMemory(0x58DC64, Add, 0xFFFFFF7A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF3A);
		SetMemory(0x58DC60, Add, 0xFFFFFF39);
		SetMemory(0x58DC68, Add, 0xFFFFFF79);
		SetMemory(0x58DC64, Add, 0x0000005C);
		SetMemory(0x58DC6C, Add, 0x0000009C);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000C7);
		SetMemory(0x58DC68, Add, 0x00000087);
		SetMemory(0x58DC64, Add, 0xFFFFFFA4);
		SetMemory(0x58DC6C, Add, 0xFFFFFF64);
		SetMemory(0x58DC60, Add, 0xFFFFFF21);
		SetMemory(0x58DC68, Add, 0xFFFFFF61);
		SetMemory(0x58DC64, Add, 0x00000033);
		SetMemory(0x58DC6C, Add, 0x00000073);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000DF);
		SetMemory(0x58DC68, Add, 0x0000009F);
		SetMemory(0x58DC64, Add, 0xFFFFFFCD);
		SetMemory(0x58DC6C, Add, 0xFFFFFF8D);
		SetMemory(0x58DC60, Add, 0xFFFFFF08);
		SetMemory(0x58DC68, Add, 0xFFFFFF48);
		SetMemory(0x58DC64, Add, 0x00000009);
		SetMemory(0x58DC6C, Add, 0x00000049);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8);
		SetMemory(0x58DC68, Add, 0x000000B8);
		SetMemory(0x58DC64, Add, 0xFFFFFFF7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFB7);
		SetMemory(0x58DC60, Add, 0xFFFFFF08);
		SetMemory(0x58DC68, Add, 0xFFFFFF48);
		SetMemory(0x58DC64, Add, 0xFFFFFFB7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF7);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000F8);
		SetMemory(0x58DC68, Add, 0x000000B8);
		SetMemory(0x58DC64, Add, 0x00000049);
		SetMemory(0x58DC6C, Add, 0x00000009);
		SetMemory(0x58DC60, Add, 0xFFFFFF20);
		SetMemory(0x58DC68, Add, 0xFFFFFF60);
		SetMemory(0x58DC64, Add, 0xFFFFFF8D);
		SetMemory(0x58DC6C, Add, 0xFFFFFFCD);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000E0);
		SetMemory(0x58DC68, Add, 0x000000A0);
		SetMemory(0x58DC64, Add, 0x00000073);
		SetMemory(0x58DC6C, Add, 0x00000033);
		SetMemory(0x58DC60, Add, 0xFFFFFF38);
		SetMemory(0x58DC68, Add, 0xFFFFFF78);
		SetMemory(0x58DC64, Add, 0xFFFFFF64);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000C8);
		SetMemory(0x58DC68, Add, 0x00000088);
		SetMemory(0x58DC64, Add, 0x0000009C);
		SetMemory(0x58DC6C, Add, 0x0000005C);
		SetMemory(0x58DC60, Add, 0xFFFFFF50);
		SetMemory(0x58DC68, Add, 0xFFFFFF90);
		SetMemory(0x58DC64, Add, 0xFFFFFF3A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF7A);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x000000B0);
		SetMemory(0x58DC68, Add, 0x00000070);
		SetMemory(0x58DC64, Add, 0x000000C6);
		SetMemory(0x58DC6C, Add, 0x00000086);
		SetMemory(0x58DC60, Add, 0xFFFFFF98);
		SetMemory(0x58DC68, Add, 0xFFFFFFD8);
		SetMemory(0x58DC64, Add, 0xFFFFFF11);
		SetMemory(0x58DC6C, Add, 0xFFFFFF51);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000068);
		SetMemory(0x58DC68, Add, 0x00000028);
		SetMemory(0x58DC64, Add, 0x000000EF);
		SetMemory(0x58DC6C, Add, 0x000000AF);
		SetMemory(0x58DC60, Add, 0xFFFFFFC8);
		SetMemory(0x58DC68, Add, 0x00000007);
		SetMemory(0x58DC64, Add, 0xFFFFFF11);
		SetMemory(0x58DC6C, Add, 0xFFFFFF51);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000038);
		SetMemory(0x58DC68, Add, 0xFFFFFFF9);
		SetMemory(0x58DC64, Add, 0x000000EF);
		SetMemory(0x58DC6C, Add, 0x000000AF);
		SetMemory(0x58DC60, Add, 0xFFFFFFF8);
		SetMemory(0x58DC68, Add, 0x00000037);
		SetMemory(0x58DC64, Add, 0xFFFFFF11);
		SetMemory(0x58DC6C, Add, 0xFFFFFF51);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0x00000008);
		SetMemory(0x58DC68, Add, 0xFFFFFFC9);
		SetMemory(0x58DC64, Add, 0x000000EF);
		SetMemory(0x58DC6C, Add, 0x000000AF);
		SetMemory(0x58DC60, Add, 0x00000028);
		SetMemory(0x58DC68, Add, 0x00000068);
		SetMemory(0x58DC64, Add, 0xFFFFFF11);
		SetMemory(0x58DC6C, Add, 0xFFFFFF51);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFFD8);
		SetMemory(0x58DC68, Add, 0xFFFFFF98);
		SetMemory(0x58DC64, Add, 0x000000EF);
		SetMemory(0x58DC6C, Add, 0x000000AF);
		SetMemory(0x58DC60, Add, 0x00000070);
		SetMemory(0x58DC68, Add, 0x000000B0);
		SetMemory(0x58DC64, Add, 0xFFFFFF3A);
		SetMemory(0x58DC6C, Add, 0xFFFFFF7A);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF90);
		SetMemory(0x58DC68, Add, 0xFFFFFF50);
		SetMemory(0x58DC64, Add, 0x000000C6);
		SetMemory(0x58DC6C, Add, 0x00000086);
		SetMemory(0x58DC60, Add, 0x00000088);
		SetMemory(0x58DC68, Add, 0x000000C8);
		SetMemory(0x58DC64, Add, 0xFFFFFF64);
		SetMemory(0x58DC6C, Add, 0xFFFFFFA4);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF78);
		SetMemory(0x58DC68, Add, 0xFFFFFF38);
		SetMemory(0x58DC64, Add, 0x0000009C);
		SetMemory(0x58DC6C, Add, 0x0000005C);
		SetMemory(0x58DC60, Add, 0x000000A0);
		SetMemory(0x58DC68, Add, 0x000000E0);
		SetMemory(0x58DC64, Add, 0xFFFFFF8D);
		SetMemory(0x58DC6C, Add, 0xFFFFFFCD);
		Call_UnitIDV2Hive
	})
	DoActionsX(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF60);
		SetMemory(0x58DC68, Add, 0xFFFFFF20);
		SetMemory(0x58DC64, Add, 0x00000073);
		SetMemory(0x58DC6C, Add, 0x00000033);
		SetMemory(0x58DC60, Add, 0x000000B8);
		SetMemory(0x58DC68, Add, 0x000000F8);
		SetMemory(0x58DC64, Add, 0xFFFFFFB7);
		SetMemory(0x58DC6C, Add, 0xFFFFFFF7);
		Call_UnitIDV2Hive
	})
	DoActions(FP,{
		SetMemory(0x58DC60, Add, 0xFFFFFF48);
		SetMemory(0x58DC68, Add, 0xFFFFFF08);
		SetMemory(0x58DC64, Add, 0x00000049);
		SetMemory(0x58DC6C, Add, 0x00000009);
	})
	

end
