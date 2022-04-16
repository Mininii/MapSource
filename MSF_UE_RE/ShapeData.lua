function Install_ShapeData()
	PolMaxIndexT = {}
	StarMaxIndexT = {}
	function MakeLevelShapeX(Type,Points,LvMin,LvMax,ShapeName)
		local X = {}
			 if Type == "Polygon" then
				  table.insert(X,CSMakePolygon(Points,24,0,PlotSizeCalc(Points,8),0))
				  
			 elseif Type == "Star" then
				  table.insert(X,CSMakeStar(Points,165,24,180,PlotSizeCalc(Points*2,4),0))
			 end

		for l, k in pairs(X) do
			local i = 1
			local j = 1
			local TempLoopMaxT = {}
			local MaxP = k[1]
			while MaxP>=j do
				if j==1 then
					table.insert(TempLoopMaxT,1)
					j=j+1
				else
					local Ret
					if Type == "Polygon" then
						Ret = Points*i
					elseif Type == "Star" then
						Ret = (Points*2)*i
					end
					i=i+1
					j=j+Ret
					table.insert(TempLoopMaxT,Ret)
				end
			
			end

			_G[ShapeName] = k
			local curpos = #G_CB_ShapeT+1
			G_CB_LoopMaxT[curpos] = CS_TMakePath(TempLoopMaxT)
			G_CB_ShapeT[curpos] = ShapeName
		end
	end
	
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
	Hive_1 = CS_ConnectPath(CSMakePath({32,960},{1536,3904},{3040,960}),45)
	Ovrm = CS_ConnectPathX(CSMakePath({1536,3296},{1088,1728},{1536,32},{1984,1728}),64,1)
	OvrmF = CS_FillPathXY(CSMakePath({1536,3296},{1088,1728},{1536,32},{1984,1728}),0,96,96)
	CC_L = CS_ConnectPathX(CSMakePath({896,224},{1344,704},{1120,1664}),64,1)
	CC_R = CS_ConnectPathX(CSMakePath({2176,224},{1728,704},{1952,1664}),64,1) 
	CC_LF = CS_FillPathXY(CSMakePath({896,224},{1344,704},{1120,1664}),0,64,64)
	CC_RF = CS_FillPathXY(CSMakePath({2176,224},{1728,704},{1952,1664}),0,64,64)
	Hive_3F = CS_MirrorX(CS_FillPathXY(CSMakePath({1504,4832},{992,5088},{512,3968},{1504,4448}),0,96,64),(32*48)+64,1)
	Hive_3 = CS_MirrorX(CS_ConnectPathX(CSMakePath({1504,4832},{992,5088},{512,3968},{1504,4448}),64,1),(32*48)+64,1)
	Hive_2_1 = CS_MirrorX(CS_OverlapX(
	CS_ConnectPath(CSMakePath({32,2400},{416,1408}),11),
	CS_ConnectPath(CSMakePath({448,1376},{736,1088}),8),
	CS_ConnectPath(CSMakePath({800,1056},{1120,896}),4),
	CS_ConnectPath(CSMakePath({1216,864},{1504,768}),2)),(32*48),1)
	Hive_2_2 = CS_MoveXY(Hive_2_1,0,6*32)
	Hive_2 = CS_Overlap(Hive_2_1,Hive_2_2)
	Cere_L = CS_FillPathXY(CSMakePath({416,6080},{320,6080},{320,5824},{384,5824},{384,5824-32},{448,5792},{448,5792-32},{512,5760},{512,5760-32},{576,5728},{576,5728-32},{640,5696},{640,5696-32},{672,5664},{672,5408},{768,5408},{768,5760},{640,5760},{640,5760+32},{576,5792},{576,5792+32},{512,5824},{512,5824+32},{448,5856},{448,5856+32},{416,5888}),0,32,32)
	Cere_R =CS_Subtract(CS_MirrorX(Cere_L,(32*48),1),Cere_L,32) 
	GC1 = CS_MoveXY(CS_RatioXY(CSMakeCircle(40,3000,0,41,1),0.5,1),48*32,96*32)
	
	C1 = CSMakeCircle(8,60,0,441,169)
	S1 = CSMakePolygon(4,45,45,13,0)
	S2 = CS_MoveXY(S1,700,0)
	M1 = CS_Merge(S2,C1,1,0)
	SS1 = CS_KaleidoscopeX(M1,20,0,0) --- Å«¹ÙÄû--

	C2 = CSMakeCircle(8,45,0,122,50)
	S3 = CSMakeLineX(3,70,0,35,15)
	SS2 = CS_Merge(S3,C2,1,0) --- ÀÛÀº¹ÙÄû--

	MM = CS_Merge(SS1,SS2,1,0)
	SS3 = CS_RemoveStack(MM,5,0) -------20°³ Åé´Ï¹ÙÄû--
	function S1_Vector(X,Y) return {X+Y,X-Y} end--
	WheelA = CS_Vector2D(SS3,1,"S1_Vector")--
	GC2 = CS_MoveXY(CS_RatioXY(WheelA,1.4,2.6),48*32,96*32)
	Form = CS_ConnectPathX(CSMakePath({1536, 4864},{2048, 5088},{2048, 5696},{2272, 5920},{2560, 5920},{2560, 6080},{512, 6080},{512, 5920},{800, 5920},{1024, 5696},{1024, 5088}),128,1)
	Form2 = CS_ConnectPathX(CSMakePath({1536, 4864},{2048, 5088},{2048, 5696},{2272, 5920},{2560, 5920},{2560, 6080},{512, 6080},{512, 5920},{800, 5920},{1024, 5696},{1024, 5088}),64,1)
	FormF1 = CS_FillPathXY(CSMakePath({1536, 4864},{2048, 5088},{2048, 5696},{2272, 5920},{2560, 5920},{2560, 6080},{512, 6080},{512, 5920},{800, 5920},{1024, 5696},{1024, 5088}),0,256,256)
	FormF2 = CS_FillPathXY(CSMakePath({1536, 4864},{2048, 5088},{2048, 5696},{2272, 5920},{2560, 5920},{2560, 6080},{512, 6080},{512, 5920},{800, 5920},{1024, 5696},{1024, 5088}),0,128,128)
	FormF3 = CS_FillPathXY(CSMakePath({1536, 4864},{2048, 5088},{2048, 5696},{2272, 5920},{2560, 5920},{2560, 6080},{512, 6080},{512, 5920},{800, 5920},{1024, 5696},{1024, 5088}),0,64,64)
	BattleShape = CSMakeStar(5,165-(12*(5-2)),((36*6)-(36*2))/2,180,PlotSizeCalc(5*2,2),PlotSizeCalc(5*2,1))
	TelShape = CSMakeStar(8,165-(12*(8-2)),(36*6)-(36*4),180,PlotSizeCalc(8*2,4),0)

	


	G_CB_LoopMaxT = {}
	G_CB_ShapeT = {
		"NBYD",
		"Hive_1",
		"Ovrm",
		"CC_L",
		"CC_R",
		"Hive_2",
		"Hive_3F",
		"Cere_L",
		"Cere_R",
		"CC_LF",
		"CC_RF",
		"OvrmF",
		"Hive_3",
		"GC1",
		"GC2",
		"Form",
		"Form2",
		"FormF1",
		"FormF2",
		"FormF3"
	}
MakeLevelShapeX("Star",3,1,4,"S_3")
MakeLevelShapeX("Star",4,1,4,"S_4")
MakeLevelShapeX("Star",5,1,4,"S_5")
MakeLevelShapeX("Star",6,1,4,"S_6")
MakeLevelShapeX("Star",7,1,4,"S_7")
MakeLevelShapeX("Star",8,1,4,"S_8")
MakeLevelShapeX("Polygon",3,1,8,"P_3")
MakeLevelShapeX("Polygon",4,1,8,"P_4")
MakeLevelShapeX("Polygon",5,1,8,"P_5")
MakeLevelShapeX("Polygon",6,1,8,"P_6")
MakeLevelShapeX("Polygon",7,1,8,"P_7")
MakeLevelShapeX("Polygon",8,1,8,"P_8")
end