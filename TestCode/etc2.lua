
-- to DeskTop : Curdir="C:\\Users\\USER\\Documents\\"
-- to LAPTOP : Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
Curdir="C:\\Users\\whatd\\Desktop\\Stormcoast Fortress\\ScmDraft 2\\"
EXTLUA = "dir \""..Curdir.."\\MapSource\\Library\\\" /b"
for dir in io.popen(EXTLUA):lines() do
     if dir:match "%.[Ll][Uu][Aa]$" and dir ~= "Loader2X.lua" then
		InitEXTLua = assert(loadfile(Curdir.."MapSource\\Library\\"..dir))
		InitEXTLua()
     end
end

function CheckShapeNum(Shape)
	print(Shape[1])
end

L00_1 = CSMakePath({-160,-160},{160,-160},{160,160},{-160,160})
H00_1 = CSMakePath({-192,-192},{192,-192},{192,192},{-192,192})
L00_1_64F = CS_FillPathXY(L00_1,0,64,64)

NexBYDLine = {}
for i=0, 12 do
   table.insert(NexBYDLine,CSMakeLine(1+(6*i),64+(64*i),0,2+(6*i),1))
end
NBYD = CS_RatioXY(CS_OverlapX(table.unpack(NexBYDLine)),1,0.5)
Circle1 = CSMakeCircle(18,32*7,0,19,1)
Circle2 = CSMakeCircle(36,32*7,0,37,1)
Star1 = CSMakeStar(6,165-(12*(6-2)),((32*6)-(32*1))/2,180,PlotSizeCalc(6*2,2),PlotSizeCalc(6*2,1))
QNest = CSMakePolygon(4,48,0,PlotSizeCalc(4,5),PlotSizeCalc(4,4))
EChamb = CSMakePolygon(6,32,0,PlotSizeCalc(6,6),PlotSizeCalc(6,5))

--해처리
Circle3 = CSMakeCircle(6,48,0,PlotSizeCalc(6,3),0) --1
Polygon6 = CSMakePolygon(6,48,0,PlotSizeCalc(6,3),0) --2

--레어
Star2 = CSMakeStar(5,120,80,180,PlotSizeCalc(5*2,2),0)
Star3 = CSMakePolygon(5,128,0,PlotSizeCalc(5,1),1)

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


CircleA = CSMakeCircle(6,60,0,61,19) ---- 작은 원
EllipseA = CS_Distortion(CircleA,{2,1},{2,1},{2,1},{2,1}) ---- 작은 타원
EllipseRA = CS_Rotate(EllipseA,15) ---- 작은 타원 회전

CircleB = CSMakeCircle(6,40,0,91,19+18) ---- 큰 원
EllipseB = CS_Distortion(CircleB,{3,1.5},{3,1.5},{3,1.5},{3,1.5}) ---- 큰 타원
EllipseRB = CS_Rotate(EllipseB,40) ---- 큰 타원 회전
EllipseRAD = CS_MoveXY(EllipseRA,0,500) ---- 큰 타원 평행이동
EllipseShape = CS_Merge(EllipseRB,EllipseRAD,64,1) ---- 작은타원 큰타원 합

EllipseMirror = CS_MirrorX(EllipseShape,500,1,1) --나비


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

local x,y=lengthdir(90, 30)
CirA = CSMakeCircle(8,32,0,9,1)
CirAX = CS_KaleidoscopeX(CS_MoveXY(CirA,x,y),6,0,1)
Tornado = CSMakeTornado(6,40,10,4,1)
Sp1 = CSMakeSpiral(4,1,1,28,0,61,9)
function printShapeXY(Shape)
	for i = 2, #Shape do
		print(math.floor(Shape[i][1])..","..math.floor(Shape[i][2]))
	end	
end

function CSMakeKaleidoPolygon(PolygonPoint,KaleidoPoint,KaleidoRadius,PolygonRadius,Angle,StartAngle,Numner,Hallow)
	local x,y=lengthdir(KaleidoRadius, (360/(KaleidoPoint*2)))
	local A = CSMakePolygon(PolygonPoint,PolygonRadius,Angle,Numner,Hallow)
	local AX = CS_KaleidoscopeX(CS_MoveXY(A,x,y),KaleidoPoint,StartAngle,1)
	return AX
end
for i = 0, 30 do

end
function CSMakeLendir(Radius,Angle,Number,T1,T2)
	if T1 == nil then T1 = 0 end
	if T2 == nil then T2 = 0 end
	local t = {Number+1}

	for i = 0, Number do
		local x,y = lengthdir(Radius+(T1*i),Angle+(T2*i))
		table.insert(t,{x,y})
	end
	return t
end
NexBYDLine2 = {}

for i=0, 34 do
   table.insert(NexBYDLine2,CSMakeCircle(1+(3*i),64*i,0,1+(4*i),1))
end
   

NBYD2 = CS_CropXY(CS_OverlapX(table.unpack(NexBYDLine2)),{-2048,2048},{-2048,2048})

function SaveShapeXY(FileName,...)
	os.execute("mkdir " .. "CS")
	local CSfile = io.open("CS/" .. FileName .. ".txt", "w")
	io.output(CSfile)
	local arg = table.pack(...)
	for k = 1, arg.n do
		for i = 1, arg[k][1] do
			if i == 1000 then
				io.write("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")

			 end
			io.write(math.floor(arg[k][i+1][1])..","..math.floor(arg[k][i+1][2]).."\n")
		end
		
	end
	io.close(CSfile)
end

Warp1 = {}
for i=0, 15 do
   table.insert(Warp1,CSMakeCircle(6+(6*i),32+(32*i),0,7+(6*i),1))
end
Warp1 = CS_CropXY(CS_OverlapX(table.unpack(Warp1)),{-2048,2048},{-2048,2048})
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

function CSMakeFillPathXY(Range,Radius)
	local a = CSMakePath({-Range,-Range},{Range,-Range},{Range,Range},{-Range,Range})
	return CS_FillPathXY(a,0,Radius,Radius)
end
Warp2 = CSMakeFillPathXY(256,72)
Warp3 = CSMakeFillPathXY(256,96)
Warp4 = CSMakeFillPathXY(256,128)

GB_P1 = CS_MoveXY(CSMakeCircle(360,2008,90,92,1),-2008,-2008)
GB_P2 = CS_MoveXY(CSMakeCircle(360,2008,180,92,1),2008,-2008)
GB_P3 = CS_MoveXY(CSMakeCircle(360,2008,0,92,1),-2008,2008)
GB_P4 = CS_MoveXY(CSMakeCircle(360,2008,270,92,1),2008,2008)
--CS_SortR(,0)
--GB1CT = CSMinimap_Inverse4X(GB1C,1680,1216,1)
EllipseMirror1 = CS_MoveXY(EllipseMirror,-500,-250)
Hp2 = CS_RatioXY(Hp1,6,3)
GBAir = CSMakePolygon(4,64,45,PlotSizeCalc(4,20),PlotSizeCalc(4,19))
local Shape1 = CSMakeStar(6,120,72,0,PlotSizeCalc(6*2,3),0)
Star6_2 = CSMakeCircle(6,48,0,PlotSizeCalc(6,3),0)

Spi2 = CSMakeSpiral(6,0.2,0.9,32,0,(12*4)+1,0)
Tor2 = CSMakeTornado(6,48,12,4,1)
CirA = CSMakeCircle(5,32,0,6,1)
CirAX = CS_KaleidoscopeX(CS_MoveXY(CirA,x,y),6,0,1)
CenLineY = CSMakeLine(2,48,0,86*2,0)
CenLineX = CSMakeLine(2,48,90,86*2,0)

--print(Sp1[1])
SaveShapeXY("Test",CenLineX)

print(lengthdir(500, 90))