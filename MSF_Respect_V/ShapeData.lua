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
CenCross = CSMakeLine(4, 128, 0, 256, 0)
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

	Hy1LC_64= CS_SortR(CS_MoveXY(CS_ConnectPathX(Hy1Line,128,nil),-1024,-368),0)
	Hy1FP_64= CS_SortR(CS_MoveXY(CS_FillPathXY(Hy1Fill, 1, 64, 64, 0),-1024,-368),0)--하드 저그유닛 SC 약영웅
	FacHD1=CS_Rotate(CS_FillPathXY(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),0,96*2,96*2), 26.565)--9
	FacSC1=CS_Rotate(CS_FillPathXY(CSMakePath({-256,-256},{256,-256},{256,256},{-256,256}),0,96,96), 26.565)--36
	EnBayHD1= CSMakePolygon(9, 32*7, 0, 10, 1)--9
	EnBaySC1= CSMakePolygon(36, 32*7, 0, 37, 1)--36
	GateHD1 = CSMakeStar(4, 180, 45*4, 0, PlotSizeCalc(8, 1), PlotSizeCalc(8, 0))
	GateSC1 = CSMakeStar(4, 180, 45, 0, PlotSizeCalc(8, 5), PlotSizeCalc(8, 4))
	
	STGateHD1 = CS_RatioXY(EllipseMirror2, 0.5, 0.5)
	STGateSC1 = CS_RatioXY(EllipseMirror1, 0.5, 0.5)
	

	GeneN1 = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 25)
	GeneN2 = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 25)
	GeneN3 = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 25)
	Gene1 = CS_ConnectPath(CSMakePath({2048-32,32},{2048-32,8192-32}), 100)
	Gene2 = CS_ConnectPath(CSMakePath({32,32},{32,8192-32}), 100)
	Gene3 = CS_ConnectPath(CSMakePath({32,8192-32},{2048-32,8192-32}), 100)
	
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
	
	
		G_CAPlot_Shape_InputTable = {"Poly","Hy1LC_64","Hy1FP_64","FacHD1","EnBayHD1","FacSC1","EnBaySC1","Cen1","Cen2","CenNM1","CenNM2","CenCross",
		"Gene1","Gene2","Gene3","GeneN1","GeneN2","GeneN3",	"GateHD1","GateSC1","STGateHD1","STGateSC1"
	
		}
end