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
--	CenLinePath = {}
--	for i =64, 1984,64 do
--		table.insert(CenLinePath, {i,i})
--	end
--	CenLinePath2 = {}
--	for i =64, 1984,64 do
--		table.insert(CenLinePath2, {2048-i,i})
--	end
--	CenU = CS_SortY(CS_OverlapX(CSMakePath(CenLinePath),CS_InvertXY(CSMakePath(CenLinePath), nil, 2048)), 0)
--	CenD = CS_SortY(CS_InvertXY(CS_OverlapX(CSMakePath(CenLinePath),CS_InvertXY(CSMakePath(CenLinePath), nil, 2048)), nil, 4096), 1)
--	CenU2 = CS_SortY(CS_OverlapX(CSMakePath(CenLinePath2),CS_InvertXY(CSMakePath(CenLinePath2), nil, 2048)), 0)
--	CenD2 = CS_SortY(CS_InvertXY(CS_OverlapX(CSMakePath(CenLinePath2),CS_InvertXY(CSMakePath(CenLinePath2), nil, 2048)), nil, 4096), 1)

	
CenLinePath1 = {}
local n = 0
local c = 0
for i =0, 8192,64 do
	table.insert(CenLinePath1, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenLinePath2 = {}
local n = 2048
local c = 1
for i =0, 8192,64 do
	table.insert(CenLinePath2, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenLinePath3 = {}
local n = 1024
local c = 0
for i =0, 8192,64 do
	table.insert(CenLinePath3, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenLinePath4 = {}
local n = 1024
local c = 1
for i =0, 8192,64 do
	table.insert(CenLinePath4, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenL1= CSMakePath(CenLinePath1)
CenL2= CSMakePath(CenLinePath2)
CenL3= CSMakePath(CenLinePath3)
CenL4= CSMakePath(CenLinePath4)
CenOverlap = CS_OverlapX(CenL1,CenL2,CenL3,CenL4)
Cen1 = CS_SortY(CS_CropXY(CenOverlap, {0,2048}, {0,4096}, {0,0}, {0,1}), 1)
Cen2 = CS_SortY(CS_CropXY(CenOverlap, {0,2048}, {4096,8192}, {0,0}, {0,0}),0)

CenLinePath1 = {}
local n = 0
local c = 0
for i =0, 8192,256 do
	table.insert(CenLinePath1, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenLinePath2 = {}
local n = 2048
local c = 1
for i =0, 8192,256 do
	table.insert(CenLinePath2, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenLinePath3 = {}
local n = 1024
local c = 0
for i =0, 8192,256 do
	table.insert(CenLinePath3, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenLinePath4 = {}
local n = 1024
local c = 1
for i =0, 8192,256 do
	table.insert(CenLinePath4, {n,i})
	
	if c==0 and n<2048 then n=n+64 end
	if c==1 and n>0 then n=n-64 end
	if c==0 and n==2048 then c=1 end
	if c==1 and n==0 then c=0 end
end
CenL1= CSMakePath(CenLinePath1)
CenL2= CSMakePath(CenLinePath2)
CenL3= CSMakePath(CenLinePath3)
CenL4= CSMakePath(CenLinePath4)
CenOverlap = CS_OverlapX(CenL1,CenL2,CenL3,CenL4)
CenNM1 = CS_SortY(CS_CropXY(CenOverlap, {0,2048}, {0,4096}, {0,0}, {0,1}), 1)
CenNM2 = CS_SortY(CS_CropXY(CenOverlap, {0,2048}, {4096,8192}, {0,0}, {0,0}),0)
CenCross = CSMakeLine(4, 64, 0, 1024, 0)
CenCross2 = CSMakeLine(4, 32, 45, 1024, 0)

CenCross3 = CS_OverlapX(CSMakeLine(4, 128, 0, 1024, 0),CSMakeLine(4, 64, 45, 1024, 0))



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
	Shape1008 = {14  ,{2016, 2816},{1024, 3296},{672, 3136},{672, 2752},{1120, 2528},{1184, 2336},{1312, 2176},{1408, 1984},{1504, 1728},{1632, 1632},{1696, 1536},{1760, 1440},{1920, 1344},{2016, 1344}}

	CircleA = CSMakeCircle(6,60,0,PlotSizeCalc(6, 2),PlotSizeCalc(6, 1)) ---- 작은 원
	EllipseA = CS_Distortion(CircleA,{2,1},{2,1},{2,1},{2,1}) ---- 작은 타원
	EllipseRA = CS_Rotate(EllipseA,15) ---- 작은 타원 회전
	CircleB = CSMakeCircle(6,40,0,PlotSizeCalc(6, 2),PlotSizeCalc(6, 1)) ---- 큰 원
	EllipseB = CS_Distortion(CircleB,{3,1.5},{3,1.5},{3,1.5},{3,1.5}) ---- 큰 타원
	EllipseRB = CS_Rotate(EllipseB,40) ---- 큰 타원 회전
	EllipseRAD = CS_MoveXY(EllipseRA,0,350) ---- 큰 타원 평행이동
	EllipseShape = CS_Merge(EllipseRB,EllipseRAD,64,1) ---- 작은타원 큰타원 합
	EllipseMirror = CS_MirrorX(EllipseShape,300,1,1) --나비
	EllipseMirror1 = CS_MoveXY(EllipseMirror,-300,-250)
	CircleA = CSMakeCircle(4,60,0,PlotSizeCalc(4, 1),PlotSizeCalc(4, 0)) ---- 작은 원
	EllipseA = CS_Distortion(CircleA,{2,1},{2,1},{2,1},{2,1}) ---- 작은 타원
	EllipseRA = CS_Rotate(EllipseA,15) ---- 작은 타원 회전
	CircleB = CSMakeCircle(4,40,0,PlotSizeCalc(4, 1),PlotSizeCalc(4, 0)) ---- 큰 원
	EllipseB = CS_Distortion(CircleB,{3,1.5},{3,1.5},{3,1.5},{3,1.5}) ---- 큰 타원
	EllipseRB = CS_Rotate(EllipseB,40) ---- 큰 타원 회전
	EllipseRAD = CS_MoveXY(EllipseRA,0,350) ---- 큰 타원 평행이동
	EllipseShape = CS_Merge(EllipseRB,EllipseRAD,64,1) ---- 작은타원 큰타원 합
	EllipseMirror = CS_MirrorX(EllipseShape,300,1,1) --나비
	EllipseMirror2 = CS_MoveXY(EllipseMirror,-300,-250)

	Hy1LC_64= CS_SortR(CS_MoveXY(CS_ConnectPathX(Hy1Line,128,nil),-1024,-80),0)
	Hy1FP_64= CS_SortR(CS_MoveXY(CS_FillPathXY(Hy1Fill, 1, 64, 64, 0),-1024,-80),0)--하드 저그유닛 SC 약영웅
	FacHD1=CS_Rotate(CS_FillPathXY(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),0,96*2,96*2), 26.565)--9
	FacSC1=CS_Rotate(CS_FillPathXY(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),0,96,96), 26.565)--36
	EnBayHD1= CSMakePolygon(9, 32*7, 0, 10, 1)--9
	EnBaySC1= CSMakePolygon(36, 32*7, 0, 37, 1)--36
	GateHD1 = CSMakeStar(4, 180, 45*4, 0, PlotSizeCalc(8, 1), PlotSizeCalc(8, 0))
	GateSC1 = CSMakeStar(4, 180, 45, 0, PlotSizeCalc(8, 5), PlotSizeCalc(8, 4))
	
	STGateHD1 = CS_RatioXY(EllipseMirror2, 0.5, 0.5)
	STGateSC1 = CS_RatioXY(EllipseMirror1, 0.5, 0.5)
	

	GeneN1 = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 25)
	GeneN1P = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 7)
	GeneN1PS = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 14)
	GeneN1R = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 2)
	GeneN2 = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 25)
	GeneN2P = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 7)
	GeneN2PS = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 14)
	GeneN2R = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 2)
	GeneN3 = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 25)
	GeneN3S = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 50)
	GeneN3P = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 7)
	GeneN3PS = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 14)
	GeneN3R = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 2)
	Gene1 = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 100)
	Gene2 = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 100)
	Gene3 = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 100)
	Gene1S = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 200)
	Gene2S = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 200)
	Gene3S = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 200)

	
	
	function MakeLevelShapeNum(Type,Points,LvMin,LvMax)
		local X = {}
		for i = LvMin, LvMax do
			local ret
			 if Type == "Polygon" then
				ret = CSMakePolygon(Points,240/i,0,PlotSizeCalc(Points,i),0)
				  table.insert(X,ret)
				  
			 elseif Type == "Star" then
				ret = CSMakeStar(Points,165-(12*(Points-2)),240/i,180,PlotSizeCalc(Points*2,i),0)
				table.insert(X,ret)
			 end
			 table.insert(LT,{string.sub(Type,1,1).."_"..Points..", "..(i-1).." : "..(#ret-1).."\n",#ret-1})
			 --table.insert(LT,{Type.." Point."..Points.." LV. "..(i-1).."  "..string.sub(Type,1,1).."_"..Points..", "..(i-1).." : "..(#ret-1).."\n",#ret-1})
		end
		
		
	end
	
	Cir = {
		CSMakeCircle(8, 48, 0, PlotSizeCalc(8, 1), 0),
		CSMakeCircle(8, 60, 0, PlotSizeCalc(8, 2), 0),
		CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 3), 0),
		CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 4), 0),
		CSMakeCircle(8, 54, 0, PlotSizeCalc(8, 5), 0)	}
	S_3 = MakeLevelShape("Star",3,1,4)
	S_4 = MakeLevelShape("Star",4,1,4)
	S_5 = MakeLevelShape("Star",5,1,4)
	S_6 = MakeLevelShape("Star",6,1,4)
	S_7 = MakeLevelShape("Star",7,1,4)
	S_8 = MakeLevelShape("Star",8,1,4)
	P_3 = MakeLevelShape("Polygon",3,1,8)
	P_4 = MakeLevelShape("Polygon",4,1,8)
	P_5 = MakeLevelShape("Polygon",5,1,8)
	P_6 = MakeLevelShape("Polygon",6,1,8)
	P_7 = MakeLevelShape("Polygon",7,1,8)
	P_8 = MakeLevelShape("Polygon",8,1,8)
		
	
	Poly = CSMakePolygon(6, 32, 0, PlotSizeCalc(6, 5), 0)
	
	NS_HD = CSMakeStar(4, 180, 192, 0, PlotSizeCalc(4*2, 3), 0)
	NS_SC = CSMakeStar(4, 180, 128, 0, PlotSizeCalc(4*2, 5), 0)
	
	function Ufunc(X,Data)
		return 64*math.sin(math.rad(X))+Data[2][1] --+Ymax
		end
	function Dfunc(X,Data)
		return 64*math.sin(math.rad(X))+Data[2][2] --+Ymin
		end
	NS_HDW = CS_Warping(NS_HD,"Ufunc","Dfunc","Ufunc","Dfunc")
	NS_SCW = CS_Warping(NS_SC,"Ufunc","Dfunc","Ufunc","Dfunc")
	SpiHD = CSMakeSpiral(6,0.2,0.8,64,0,(8*5)+1,0)
	SpiSC = CSMakeSpiral(6,0.2,0.8,48,0,(12*6)+1,0)
	LauncherShHD = CS_RatioXY(CSMakePolygon(6, 160, 0, PlotSizeCalc(6, 3),0), 1, 0.5)

	LauncherShSC = CS_RatioXY(CSMakePolygon(6, 96, 0, PlotSizeCalc(6, 6),0), 1, 0.5)

	
	TemConnectHD = CS_MoveXY(CS_ConnectPathX(Shape1008, 192, nil),-1744,-2384)
	TemConnectSC = CS_MoveXY(CS_ConnectPathX(Shape1008, 48, nil),-1744,-2384)
	TemConnect = CS_MoveXY(CS_ConnectPathX(Shape1008, 48, 1),-1744,-2384)
	Shape1008_2 = {6   ,{32, 4992},{928, 5440},{928, 5824},{416, 6080},{416, 5856},{32, 5664}}
	TemConnect2HD = CS_MoveXY(CS_ConnectPathX(Shape1008_2, 192, nil),-400,-5488)
	TemConnect2SC = CS_MoveXY(CS_ConnectPathX(Shape1008_2, 48, nil),-400,-5488)
	TemConnect2 = CS_MoveXY(CS_ConnectPathX(Shape1008_2, 48, 1),-400,-5488)




	RCen1 = CS_CropRA(CSMakeCircle(8, 48, 0, PlotSizeCalc(8, 6), 0), {64,4096}, {0,45})
	RCenN1 = CS_CropRA(CSMakeCircle(8, 96, 0, PlotSizeCalc(8, 3), 0), {64,4096}, {0,45})
	RCen2 = CS_MoveXY(CSMakeStar(4, 180, 45, 0, PlotSizeCalc(8, 3), PlotSizeCalc(8, 2)), nil, -150)
	RCenN2 = CS_MoveXY(CSMakeStar(4, 180, 75, 0, PlotSizeCalc(8, 1), PlotSizeCalc(8, 0)), nil, -150)
	RCen3 = CS_Distortion(CSMakeCircle(25,280,0,26,1),{0,0},{0,0})
	RCenN3 = CS_Distortion(CSMakeCircle(8,280,0,9,1),{0,0},{0,0})
	RCen4 = CS_MoveXY(CSMakeStar(4, 180, 90, 45, PlotSizeCalc(8, 2), 0), nil, -180)
	RCenN4 = CS_MoveXY(CSMakeStar(4, 180, 180, 45, PlotSizeCalc(8, 1), 0), nil, -180)
	SCir = CSMakeCircle(4, 32, 0, 5, 1)
	CCir = CSMakeCircle(6, 128, 0, 7, 1)
	RC4Table = {}
	for i = 2, #CCir-1 do
		table.insert(RC4Table,CS_MoveXY(SCir, CCir[i][1], CCir[i][2]))
	end
	
	function CS_OverlapT(Table)
		local RetShape = {0}
		local arg = Table
		for k = 1, #arg do
			RetShape[1] = RetShape[1] + arg[k][1]
			for i = 1, arg[k][1] do
				table.insert(RetShape,{arg[k][i+1][1],arg[k][i+1][2]})
			end
		end
		return RetShape	
	end
	RCen5 = CS_MoveXY(CS_OverlapT(RC4Table),nil,-160)
	RCenN5 = CS_MoveXY(CCir,nil,-160+32)
	RCen6 = CSMakeLine(1, 12, 0, 25, 0)
	RCenN6 = CSMakeLine(1, 36, 0, 8, 0)
	RCen7 = CS_Rotate(CS_OverlapX(CS_Rotate(CSMakeLine(1, 24, 0, 13, 0), 45),CSMakeLine(1, 24, 0, 13, 0)), -45/2)
	RCenN7 = CS_Rotate(CS_OverlapX(CS_Rotate(CSMakeLine(1, 54, 0, 5, 0), 45),CSMakeLine(1, 54, 0, 5, 0)), -45/2)
	
	Shape1217 = {28  ,{48, 3568},{80, 3568},{112, 3536},{144, 3536},{176, 3504},{208, 3504},{240, 3472},{272, 3472},{304, 3440},{336, 3440},{368, 3408},{400, 3408},{432, 3376},{464, 3376},{272, 4144},{304, 4144},{336, 4112},{368, 4112},{400, 4080},{432, 4080},{464, 4048},{496, 4048},{528, 4016},{560, 4016},{592, 3984},{624, 3984},{656, 3952},{688, 3952}}

	Shape1008 = {6   ,{64, 3584},{480, 3360},{480, 3872},{640, 3968},{352, 4096},{64, 3936}}
	CellMShape = CS_FillPathHX2(Shape1008,1,72,48,1,0,-26.57,5)
	CellMShapeSC = CS_FillPathHX2(Shape1008,1,72/2,48/2,1,0,-26.57,5)

	L1084 = CS_FillPathHX2({4   ,{32, 2816},{448, 2656},{448, 3168},{32, 3360}},1,72,48,1,0,-26.57,5)
	L2084 = CS_FillPathHX2({3   ,{2016, 6624},{1440, 6912},{2016, 7200}},1,72,48,1,0,-26.57,5)

	WarpZ = {}
	for i=0, 7 do
	   table.insert(WarpZ,CS_RatioXY(CSMakeCircle(6+(6*i),64+(64*i),0,7+(6*i),1), 1, 0.5))
	end
	WarpZ = CS_CropXY(CS_OverlapX(table.unpack(WarpZ)),{-2048,2048},{-2048,2048})
	
	
	CallStarS = CSMakeStar(4, 135, 72, 45, PlotSizeCalc(4*2, 4), PlotSizeCalc(4*2, 3))
	CallStarSFL = CSMakeStar(4, 135, 72, 45, PlotSizeCalc(4*2, 3),0)
	CallStarL = CSMakeStar(4, 135, 90, 45, PlotSizeCalc(4*2, 6), PlotSizeCalc(4*2, 5))
	CallStarLFL = CSMakeStar(4, 135, 90, 45, PlotSizeCalc(4*2, 5), 0)

	Nex1 = CSMakePolygon(3, 64, 0, PlotSizeCalc(3, 6), 0)
	
	PL1 = CSMakeLine(2, 32, 0, 15, 0)
	PL2 = CSMakeLine(2, 32, 0, 7, 0)
	PSILSC1 = CS_OverlapX(
		CS_MoveXY(PL1, -64, nil),
		CS_MoveXY(PL1, -192, nil),
		CS_MoveXY(PL1, -192-128, nil),
		CS_MoveXY(PL1, 64, nil),
		CS_MoveXY(PL1, 192, nil),
		CS_MoveXY(PL1, 192+128, nil)
	)
	PSILHD1 = CS_OverlapX(
		CS_MoveXY(PL2, -32, nil),
		CS_MoveXY(PL2, -32-64, nil),
		CS_MoveXY(PL2, -32-64-64, nil),
		CS_MoveXY(PL2, 32, nil),
		CS_MoveXY(PL2, 32+64, nil),
		CS_MoveXY(PL2, 32+64+64, nil)
	)
	PSILHD1 = CS_SortY(PSILHD1, 0)
	PSILSC1 = CS_SortY(PSILSC1, 0)
	PSICHD1 = CS_RatioXY(CSMakeCircle(32, 320, 0, 32+1, 1), 1, 0.5)
	PSICSC1 = CS_RatioXY(CSMakeCircle(96, 320, 0, 96+1, 1), 1, 0.5)
	PSISHD1 = CSMakeStar(4, 135, 48, 45, PlotSizeCalc(4*2, 5), PlotSizeCalc(4*2, 4))
	PSISSC1 = CSMakeStar(4, 135, 32, 45, PlotSizeCalc(4*2, 11), PlotSizeCalc(4*2, 10))
	

	EnvShVSC = CS_OverlapX(
		CSMakeLine(1, 48, -30, 9, 0),
		CSMakeLine(1, 48, -15, 9, 0),
		CSMakeLine(1, 48, 0, 9, 0),
		CSMakeLine(1, 48, 15, 9, 0),
		CSMakeLine(1, 48, 30, 9, 0)
	)
	EnvShVHD = CS_OverlapX(
		CSMakeLine(1, 128, -30, 3, 0),
		CSMakeLine(1, 128, -15, 3, 0),
		CSMakeLine(1, 128, 0, 3, 0),
		CSMakeLine(1, 128, 15, 3, 0),
		CSMakeLine(1, 128, 30, 3, 0)
	)
	STCirHD = CS_MoveXY(CS_OverlapX(
		CS_MoveXY(CSMakeCircle(6, 90, 0, 7, 1), -220, -50),
		CS_MoveXY(CSMakeCircle(6, 90, 0, 7, 1), 0, -50),
		CS_MoveXY(CSMakeCircle(6, 90, 0, 7, 1), 220, -50),
		CS_MoveXY(CSMakeCircle(6, 90, 0, 7, 1), -110, 50),
		CS_MoveXY(CSMakeCircle(6, 90, 0, 7, 1), 110, 50)), 0, -240)
	STCirSC = CS_MoveXY(CS_OverlapX(
		CS_MoveXY(CSMakeCircle(14, 90, 0, 15, 1), -220, -50),
		CS_MoveXY(CSMakeCircle(14, 90, 0, 15, 1), 0, -50),
		CS_MoveXY(CSMakeCircle(14, 90, 0, 15, 1), 220, -50),
		CS_MoveXY(CSMakeCircle(14, 90, 0, 15, 1), -110, 50),
		CS_MoveXY(CSMakeCircle(14, 90, 0, 15, 1), 110, 50)),0,-240)
	

		PaciShHD= CS_OverlapX(CS_MoveXY(CSMakePolygon(3, 48, 0, PlotSizeCalc(3, 5), PlotSizeCalc(3, 4)),0,  240),
		CS_MoveXY(CSMakePolygon(3, 48, 180, PlotSizeCalc(3, 5), PlotSizeCalc(3, 4)), 0, -240))
		PaciShSC= CS_OverlapX(CS_MoveXY(CSMakePolygon(3, 16, 0, PlotSizeCalc(3, 15), PlotSizeCalc(3, 14)),0,  240),
		CS_MoveXY(CSMakePolygon(3, 16, 180, PlotSizeCalc(3, 15), PlotSizeCalc(3, 14)), 0, -240))

	LSLine = CSMakeStar(4, 135, 32*2, 45, PlotSizeCalc(4*2, 8), PlotSizeCalc(4*2, 7))
	LSLineHD = CSMakeStar(4, 135, 84*2, 45, PlotSizeCalc(4*2, 3), PlotSizeCalc(4*2, 2))
	LSFill = CSMakeStar(4, 135, 32*3, 45, PlotSizeCalc(4*2, 4), 0)
	LSHD = CSMakeStar(4, 135, 256*2, 45, PlotSizeCalc(4*2, 1), 0)
	LSSC = CSMakeStar(4, 135, 92*2, 45, PlotSizeCalc(4*2, 2), 0)
	LD = CSMakeCircle(6, 64, 0, PlotSizeCalc(6, 10), 0)
	LDH = CSMakeCircle(6, 96, 0, PlotSizeCalc(6, 7), 0)
	RBLine = CSMakeStar(4, 135, 48, 45, PlotSizeCalc(4*2, 8), PlotSizeCalc(4*2, 7))
	RBLineHD = CSMakeStar(4, 135, 64*2, 45, PlotSizeCalc(4*2, 3), PlotSizeCalc(4*2, 2))
	RBFill = CSMakeStar(4, 135, 192, 45, PlotSizeCalc(4*2, 2), 0)
	RBFillHD = CSMakeStar(4, 135, 384, 45, PlotSizeCalc(4*2, 1), 0)
	RBFillX = CSMakeStar(4, 135, 64, 45, PlotSizeCalc(4*2, 6), 0)
	RBC = CSMakeLine(64, 384, 0, 64+1, 0)
	RBCHD = CSMakeLine(24, 384, 0, 24+1, 0)
	



end