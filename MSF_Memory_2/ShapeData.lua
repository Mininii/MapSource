function M2_Install_Shape()
	
function degtorad( d )

	return d * math.pi / 180

end

function lengthdir(Radius, Angle)
	Angle = degtorad(Angle)
	return math.cos(Angle) * Radius,-math.sin(Angle) * Radius
end
function lengthdirT(Radius, Angle)
	Angle = degtorad(Angle)
	return {math.cos(Angle) * Radius,-math.sin(Angle) * Radius}
end


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


	G_CAPlot_Shape_InputTable = {}
	L00_1 = CSMakePath({-160,-160},{160,-160},{160,160},{-160,160})
	H00_1 = CSMakePath({-192,-192},{192,-192},{192,192},{-192,192})
	L00_1_64F = CS_FillPathXY(L00_1,0,64,64)
	
	NexBYDLine = {}
	NexBYDLine2 = {}
	for i=0, 12 do
	   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	for i=0, 46 do
	   table.insert(NexBYDLine2,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
	end
	NBYD = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine)),1,0.5)
	NBYD2 = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine2)),1,0.5)
	
	Circle1 = CSMakeCircle(18,32*7,0,19,1)
	Circle2 = CSMakeCircle(36,32*7,0,37,1)
	Star1 = CSMakeStar(6,165-(12*(6-2)),((32*6)-(32*1))/2,180,PlotSizeCalc(6*2,2),PlotSizeCalc(6*2,1))
	QNest = CSMakePolygon(4,48,0,PlotSizeCalc(4,5),PlotSizeCalc(4,4))
	EChamb = CSMakePolygon(6,32,0,PlotSizeCalc(6,6),PlotSizeCalc(6,5))
	
	--해처리
	Circle3 = CSMakeCircle(6,48,0,PlotSizeCalc(6,3),0) --1
	Polygon6 = CSMakePolygon(6,48,0,PlotSizeCalc(6,3),0) --2
	Polygon6_2 = CSMakePolygon(6,24,0,PlotSizeCalc(6,5),0) --3
	Circle6_2 = CSMakeCircle(6,24,0,PlotSizeCalc(6,5),0) --4
	local Shape1 = CSMakeStar(6,120,48,0,PlotSizeCalc(6*2,4),0)
    Star6_2 = CS_OverlapX(CS_CropRA(Shape1,{0,1200},{30,150}),CS_CropRA(Shape1,{0,1200},{210,330}))

	--레어
	Star2 = CSMakeStar(5,120,80,180,PlotSizeCalc(5*2,2),0)
	Star3 = CSMakePolygon(5,128,0,PlotSizeCalc(5,1),1)
	Pol_6_1 = CS_Intersect(CSMakePolygon(6,32,0,PlotSizeCalc(6,7),0),CS_Merge(CSMakeLine(6,32,0,(8*6)+1,0),CSMakePolygon(6,32,0,PlotSizeCalc(6,7),PlotSizeCalc(6,6)),8,0),8,0)
	Pol_6_2 = CSMakeLine(6,128,30,7,1)
	Pol_4_1 = CS_RatioXY(CSMakeStar(4,180,64,45,9*9,0),1,0.5)
	Pol_4_2 = CS_RatioXY(CSMakeLine(8,192,0,9,1),1,0.5)
	Cir36_1 = CSMakeStar(36,30,192,0,PlotSizeCalc(36*2,1),1)
	Cir36_2 = CSMakeCircle(6,128,0,7,1)
	Spi2 = CSMakeSpiral(6,0.2,0.9,32,0,(12*6)+1,0)
	Spi3 = CSMakeSpiral(6,0.2,0.9,32,0,(12*7)+1,(12*6)+1)
	Tor2 = CSMakeTornado(6,32,12,6,1)
	Tor3 = CSMakeTornado(6,32,12,6,nil,5)
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

--k*math.cos(T) + l*math.cos(k*T), k*math.sin(T) - l*math.sin(k*T) >> (k+1)각
function Create_HyperCycloid(k)
	function C_HC(T) return {(k-1)*math.cos(T) + math.cos((k-1)*T), (k-1)*math.sin(T) - math.sin((k-1)*T)} end --하이포사이클로이드 (원외부 원주를 도는 외접원의 자취)
	return CS_RatioXY(CS_RemoveStack(CSMakeGraphT({32,32},"C_HC",0,0,24,24,70),10,0),1.5,1.5) 
end

function HyperCycloidA(T) return {4*math.cos(T) + math.cos(4*T), 4*math.sin(T) - math.sin(4*T)} end --하이포사이클로이드 (원외부 원주를 도는 외접원의 자취)
 HCA0 = CSMakeGraphT({32,32},"HyperCycloidA",0,0,24,24,70)
 HCA = CS_RatioXY(CS_RemoveStack(HCA0,10,0),1.5,1.5) 

--------------------------------------------------------------

function HyperCycloidB(T) return {4*math.cos(T) + 2*math.cos(4*T), 4*math.sin(T) - 2*math.sin(4*T)} end
HCB0 = CSMakeGraphT({32,32},"HyperCycloidB",0,0,12,12,120)
HCB = CS_RatioXY(CS_RemoveStack(HCB0,12,0),1.5,1.5)

--------------------------------------------------------------

function HyperCycloidC(T) return {12*math.sin(T) - 4*math.sin(3*T), 13*math.cos(T) - 5*math.cos(2*T) - 2*math.cos(3*T) - math.cos(4*T)} end
HCCC = CSMakeGraphT({12,12},"HyperCycloidC",0,0,2,2,51) 
HCC0 = CS_Rotate(HCCC,180)
HCC = CS_RemoveStack(HCC0,15,0) -------하트

--------------------------------------------------------------
--k*math.cos(T) - l*math.cos(k*T), k*math.sin(T) - l*math.sin(k*T) >> 에피사이클로이드 (원내부 원주를 도는 내접원의 자취)
--K가 정수일때

function HyperCycloidD(T) return {6*math.cos(T) - 2*math.cos(6*T), 6*math.sin(T) - 2*math.sin(6*T)} end 
HCD0 = CSMakeGraphT({24,24},"HyperCycloidD",0,0,1,1,90)
HCD = CS_RemoveStack(HCD0,20,0)

--------------------------------------------------------------

--K가 유리수일때

function HyperCycloid1(T) return {2.1*math.cos(T) - math.cos(2.1*T), 2.1*math.sin(T) - math.sin(2.1*T)} end 
Hp0 = CSMakeGraphT({192,192},"HyperCycloid1",0,0,10,10,200)
Hp1 = CS_RatioXY(CS_RemoveStack(Hp0,10),0.5,0.5)

--------------------------------------------------------------

function SF_Vector(X,Y) return {0.8*(X+Y),0.8*(X-Y)} end
SF0 = CSMakePolygonX(6,60,30,96,54)
SFM = CS_MoveXY(SF0,380,0)
SFM1 = CS_Merge(SF0,SFM,5,0)
SLineA = CSMakeLineX(1,60,90,25,1)
SLineB = CS_MoveXY(CSMakePolygonX(5,60,18,45,20),860,0)
SFM2 = CS_Merge(CS_Merge(SFM1,SLineA,5,0),SLineB,5,0)
SFM3 =CS_Kaleidoscope(SFM2,6,0,0)

SF1 = CS_Vector2D(CS_RemoveStack(SFM3,12),1,"SF_Vector") -- 눈송이

--------------------------------------------------------------

function S1_Vector(X,Y) return {X+Y,X-Y} end

C1 = CSMakeCircle(8,60,0,441,169)
S1 = CSMakePolygon(4,45,45,13,0)
S2 = CS_MoveXY(S1,700,0)
M1 = CS_Merge(S2,C1,1,0)
SS1 = CS_KaleidoscopeX(M1,20,0,0) --- 큰바퀴

C2 = CSMakeCircle(8,45,0,122,50)
S3 = CSMakeLineX(3,70,0,35,15)
SS2 = CS_Merge(S3,C2,1,0) --- 작은바퀴

MM = CS_Merge(SS1,SS2,1,0)
SS3 = CS_RemoveStack(MM,5,0) -------20개 톱니바퀴

WheelA = CS_Vector2D(SS3,1,"S1_Vector") -- 톱니바퀴

--------------------------------------------------------------


CircleA = CSMakeCircle(6,60,0,61,0) ---- 작은 원
EllipseA = CS_Distortion(CircleA,{2,1},{2,1},{2,1},{2,1}) ---- 작은 타원
EllipseRA = CS_Rotate(EllipseA,15) ---- 작은 타원 회전

CircleB = CSMakeCircle(6,40,0,91,0) ---- 큰 원
EllipseB = CS_Distortion(CircleB,{3,1.5},{3,1.5},{3,1.5},{3,1.5}) ---- 큰 타원
EllipseRB = CS_Rotate(EllipseB,40) ---- 큰 타원 회전
EllipseRAD = CS_MoveXY(EllipseRA,0,500) ---- 큰 타원 평행이동
EllipseShape = CS_Merge(EllipseRB,EllipseRAD,64,1) ---- 작은타원 큰타원 합

EllipseMirror = CS_MirrorX(EllipseShape,500,1,1) --나비


local x,y=lengthdir(90, 30)
CirA = CSMakeCircle(8,32,0,9,1)
CirAX = CS_KaleidoscopeX(CS_MoveXY(CirA,x,y),6,0,1)
Tornado = CSMakeTornado(6,40,10,4,1)
Sp1 = CSMakeSpiral(4,1,1,28,0,61,9)
MinHive = CS_RatioXY(CS_OverlapX(NexBYDLine[2],NexBYDLine[4],NexBYDLine[6]),0.5,0.5)
function CSMinimap_Inverse4X(Shape,X,Y,RetType)
	local P5 = CS_MoveXY(Shape,-X,-Y)
	local P6 = CS_MoveXY(CS_InvertXY(Shape,2048,nil),-(4096-X),-Y)
	local P7 = CS_MoveXY(CS_InvertXY(Shape,nil,2048),-X,-(4096-Y))
	local P8 = CS_MoveXY(CS_InvertXY(Shape,2048,2048),-(4096-X),-(4096-Y))
	if RetType == nil then
		return P5,P6,P7,P8
	else
		return {P5,P6,P7,P8}
	end
end
MinHiveTemp = {16  ,{64, 1088},{128, 1120},{192, 1152},{256, 1184},{320, 1216},{384, 1248},{448, 1280},{512, 1312},{576, 1344},{640, 1376},{704, 1408},{640, 1440},{576, 1472},{512, 1504},{448, 1536},{384, 1568}}
MinHiveP5 ,MinHiveP6 ,MinHiveP7 ,MinHiveP8 = CSMinimap_Inverse4X(MinHiveTemp,256,1440)


function CSMakeKaleidoPolygon(PolygonPoint,KaleidoPoint,KaleidoRadius,PolygonRadius,Angle,StartAngle,Numner,Hallow)
	local x,y=lengthdir(KaleidoRadius, (360/(KaleidoPoint*2)))
	local A = CSMakePolygon(PolygonPoint,PolygonRadius,Angle,Numner,Hallow)
	local AX = CS_KaleidoscopeX(CS_MoveXY(A,x,y),KaleidoPoint,StartAngle,1)
	return AX
end

NexP5,NexP6,NexP7,NexP8 = CSMinimap_Inverse4X(CS_ConnectPathX({3,{1856, 800},{1856, 96},{480, 800}},32,1),1344,608)

SqKal1 = CSMakeKaleidoPolygon(4,8,145,24,45,0,5,1)
SqKal2 = CSMakeKaleidoPolygon(4,8,145,24,45,0,1,0)
TempleG = CS_Distortion(CSMakeCircle(32,960,0,33,1),{0,0},{0,0})

OvG = CSMakeStar(4,180,128,90,9*9,0)
OvG1 = CS_SortX(OvG,0)
OvG2 = CS_SortX(OvG,1)
OvG3 = CS_SortY(OvG,0)
OvG4 = CS_SortY(OvG,1)
OvG5 = CS_SortR(OvG,0)
OvG6 = CS_SortR(OvG,1)
OvG7 = CS_SortA(OvG,0)
OvG8 = CS_SortA(OvG,1)
for i = 1, 8 do
	table.insert(G_CAPlot_Shape_InputTable,"OvG"..i)
end

Cere1 = CS_MoveXY(CSMakeStar(4,135,64,45,PlotSizeCalc(4*2,3),0),128)

ion1 = {4   ,{1440, 1056},{1888, 832},{1888, 1568},{1440, 1344}}
ion2 = CS_FillPathHX2(ion1,1,72,48,1,0,26.57,5)
ion3 = CS_SortR(CS_ConnectPathX(ion1,48,1),0)
ion1T = CSMinimap_Inverse4X(ion1,1680,1216,1)
ion2T = CSMinimap_Inverse4X(ion2,1680,1216,1)
ion3T = CSMinimap_Inverse4X(ion3,1680,1216,1)
for i = 1, 4 do
	_G["ion1_P"..i+4] = CS_RatioXY(ion1T[i],0.5,0.5)
	_G["ion2_P"..i+4] = ion2T[i]
	_G["ion3_P"..i+4] = ion3T[i]
	table.insert(G_CAPlot_Shape_InputTable,"ion1_P"..i+4)
	table.insert(G_CAPlot_Shape_InputTable,"ion2_P"..i+4)
	table.insert(G_CAPlot_Shape_InputTable,"ion3_P"..i+4)
end



norad1 = {4   ,{800, 1440},{32, 1056},{352, 896},{832, 1152}}
norad2 = CS_FillPathHX2(norad1,1,72,48,1,0,-26.57,5)
norad3 = CS_SortR(CS_ConnectPathX(norad1,48,1),0)

norad1T = CSMinimap_Inverse4X(norad1,432,1120,1)
norad2T = CSMinimap_Inverse4X(norad2,432,1120,1)
norad3T = CSMinimap_Inverse4X(norad3,432,1120,1)
for i = 1, 4 do
	_G["norad1_P"..i+4] = norad1T[i]
	_G["norad2_P"..i+4] = norad2T[i]
	_G["norad3_P"..i+4] = norad3T[i]
	table.insert(G_CAPlot_Shape_InputTable,"norad1_P"..i+4)
	table.insert(G_CAPlot_Shape_InputTable,"norad2_P"..i+4)
	table.insert(G_CAPlot_Shape_InputTable,"norad3_P"..i+4)
end

--------------------------------------------------------------

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
		"H00_1_64L","L00_1_164F","L00_1_128F","H00_1_96F",
		"HCA",
		"HCB",
		"HCC",
		"HCD",
		"Circle3",
		"Polygon6",
		"Star2",
		"Star3",
		"CirAX",
		"Sp1",
		"Tornado",
		"MinHive",
		"MinHiveP5",
		"MinHiveP6",
		"MinHiveP7",
		"MinHiveP8",
		"SqKal1",
		"SqKal2",
		"Polygon6_2",
		"Circle6_2",
		"Star6_2",
		"Pol_6_1",
		"Pol_6_2",
		"Pol_4_1",
		"Pol_4_2",
		"Cir36_1",
		"Cir36_2",
		"NexP5",
		"NexP6",
		"NexP7",
		"NexP8",
		"Spi2",
		"Spi3",
		"Tor2",
		"Tor3",
		"TempleG",
		"Cere1",
	}
	)


	
	
end
