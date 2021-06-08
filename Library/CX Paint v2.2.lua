-- CreateUnitShape.lua v2.2  for Tep ----------------------------------------------------------------
-- Made by Ninfia for CtrigAsm v5.1
-- CSMake -> Cs_ -> CSPlot -> CreateUnitTRIG + Save(.txt)
-- CSMake : Polygon(X) / Star(X) / Line(X) / Circle(X) / Path(X) / GraphX,Y,R,A,T /
-- CS_ : MirrorX,Y,R,A / Kaleidoscope(X) / Rotate(3D) / Overlap / Merge / Intersect / Subtract / CropXY,RA,Path / InvertXY,RA / RemoveStack / MoveXY,RA / RatioXY,RA / Reverse, Shuffle, Convert(Order), Add / CheckXY,RA,Path,Stack,Collide / FillXY,RA,HX,RD,PathXY,PathRA,PathHX,PathRD / Vector2D
-- CSPlot : Plot / PlotOrder / Plotwithproperties / PlotOrderwithproperties / PlotAct / PlotActwithproperties
-- CSSave : Save / SaveWithName / SaveInit(초기화) / Load
-- Shape Packet : < Total Number, <X1,Y1> , <X2,Y2> , ... > 
-- 0 degree = 12'o Clock Direction -> Clockwise (+) 

-- CSMake Functions : Input -> Shape ---------------------------------------------------------------
-- Path : 점 집합 (Path)
-- Polygon : 정다각형 / Circle : 원형
-- Star : 정다각별 (SA) / Line : 다방향 직선
-- GrpahX,Y,R,A,T : y=f(x), x=f(y), a=f(r), r=f(a), (x(t),y(t)) 등간격 그래프 (Path) 

function CSMakePath(PathData,...)
	if type(PathData[2]) == "number" then
		PathData = {PathData}
	end
	local arg = table.pack(...)
	for k = 1, arg.n do
		table.insert(PathData,arg[k])
	end
	local Shape = {}
	for k, v in pairs(PathData) do
		Shape[k+1] = v
	end
	Shape[1] = #PathData
	return Shape
end

function CSMakePathX(Ratio,PathData,...)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end

	if type(PathData[2]) == "number" then
		PathData = {PathData}
	end
	local arg = table.pack(...)
	for k = 1, arg.n do
		table.insert(PathData,arg[k])
	end
	local Shape = {}
	for k, v in pairs(PathData) do
		v[1] = v[1] * XRatio
		v[2] = v[2] * YRatio
		Shape[k+1] = v
	end
	Shape[1] = #PathData
	return Shape
end

function CSMakePolygon(Point,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0
	local Pts = 0

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp2
	local Temp3

	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local LX = nil
	local LY = nil

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				table.insert(Shape,{0,0})
				Remain = Remain - 1
			end
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 1
		   		Temp = (Level*(Level-1)*Point)/2 + 1
		   		TempA = ((Level*Level-3*Level+2)*Point)/2 + 1
		   	end
		   	Case = 1
		   	TempB = Level-1
		   	while true do
			   	if Main <= TempA+TempB then break end
			   	Case = Case + 1
			   	TempB = Case*(Level-1)
			end

			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				Pts = (TempA + TempB) - Main

			   	Temp1 = ((Level-1) * Radius)
			   	Temp2 = math.rad(Angle+(360*(Case-1))/Point)
			   	Temp3 = math.rad(Angle+(360*Case)/Point)
			   	x1 = Temp1 * math.cos(Temp2)
			   	x2 = Temp1 * math.cos(Temp3)
			   	y1 = Temp1 * math.sin(Temp2)
			   	y2 = Temp1 * math.sin(Temp3)

			   	LX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
			   	LY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
			   		
			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end
			Main = Main + 1
		end
	end 

	return Shape	
end

function CSMakePolygonX(Point,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0
	local Pts = 0
	local HalfRad = Radius/2

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp2
	local Temp3
	local InitRadius = Radius / 2 --(2*math.sin(math.rad(180/Point)))

	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local LX = nil
	local LY = nil

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 2
		   		Temp = (Level*(Level-1)*Point)/2 + 1
		   		TempA = ((Level*Level-3*Level+2)*Point)/2 + 1
		   		Main = Main + (Level-2)*Point
		   	end
		   	Case = 1
		   	TempB = Level-1
		   	while true do
			   	if Main <= TempA+TempB then break end
			   	Case = Case + 1
			   	TempB = Case*(Level-1)
			end

			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				Pts = (TempA + TempB) - Main

			   	Temp1 = ((Level-2) * HalfRad) + InitRadius
			   	Temp2 = math.rad(Angle+(360*(Case-1))/Point)
			   	Temp3 = math.rad(Angle+(360*Case)/Point)
			   	x1 = Temp1 * math.cos(Temp2)
			   	x2 = Temp1 * math.cos(Temp3)
			   	y1 = Temp1 * math.sin(Temp2)
			   	y2 = Temp1 * math.sin(Temp3)

			   	LX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
			   	LY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
			   		
			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end

			Main = Main + 1
		end
	end 

	return Shape	
end

function CSMakeCircle(Point,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp2
	local Temp3

	local LX = nil
	local LY = nil

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				table.insert(Shape,{0,0})
				Remain = Remain - 1
			end
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 1
		   		Temp = (Level*(Level-1)*Point)/2 + 1
		   		Case = 0
		   	end
		  
			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
			   	Temp1 = ((Level-1) * Radius)
			   	Temp2 = Angle+(360*Case)/(Point*(Level-1))
			   	Temp3 = math.rad(Temp2)
			   	LX = Temp1 * math.cos(Temp3)
			   	LY = Temp1 * math.sin(Temp3)

			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end
			Case = Case + 1
			Main = Main + 1
		end
	end 

	return Shape	
end

function CSMakeCircleX(Point,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0
	local HalfRad = Radius/2

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp2
	local Temp3
	local InitRadius = Radius / 2 --(2*math.sin(math.rad(180/Point)))

	local LX = nil
	local LY = nil

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 2
		   		Temp = (Level*(Level-1)*Point)/2 + 1
		   		Main = Main + (Level-2)*Point
		   		Case = 0
		   	end
		  
			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
			   	Temp1 = ((Level-2) * HalfRad) + InitRadius
			   	Temp2 = Angle+(360*Case)/(Point*(Level-1))
			   	Temp3 = math.rad(Temp2)
			   	LX = Temp1 * math.cos(Temp3)
			   	LY = Temp1 * math.sin(Temp3)

			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end
			Case = Case + 1
			Main = Main + 1
		end
	end 

	return Shape	
end

function CSMakeStar(Point,StarAngle,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90

	local SA
	if type(StarAngle) == "number" then
		SA = StarAngle
	else
		SA = math.deg(2*math.atan(math.sin(math.rad(180/Point))/((StarAngle[1]/Radius)-1+(math.cos(math.rad(180/Point)))))) 
	end

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0
	local Pts = 0
	local StarRadius = Radius * (math.cos(math.rad(180/Point))-math.sin(math.rad(180/Point))/math.tan(math.rad(SA/2)))

	Point = Point*2

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp1s
	local Temp2
	local Temp3

	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local LX = nil
	local LY = nil

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				table.insert(Shape,{0,0})
				Remain = Remain - 1
			end
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 1
		   		Temp = (Level*(Level-1)*Point)/2 + 1
		   		TempA = ((Level*Level-3*Level+2)*Point)/2 + 1
		   	end
		   	Case = 1
		   	TempB = Level-1
		   	while true do
			   	if Main <= TempA+TempB then break end
			   	Case = Case + 1
			   	TempB = Case*(Level-1)
			end

			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				Pts = (TempA + TempB) - Main

				if Case%2 == 0 then
				   	Temp1 = ((Level-1) * Radius)
				   	Temp1s = ((Level-1) * StarRadius)
				   	Temp2 = math.rad(Angle+(360*(Case-1))/Point)
				   	Temp3 = math.rad(Angle+(360*Case)/Point)
				   	x1 = Temp1 * math.cos(Temp2)
				   	x2 = Temp1s * math.cos(Temp3)
				   	y1 = Temp1 * math.sin(Temp2)
				   	y2 = Temp1s * math.sin(Temp3)
				else
					Temp1 = ((Level-1) * Radius)
					Temp1s = ((Level-1) * StarRadius)
				   	Temp2 = math.rad(Angle+(360*(Case-1))/Point)
				   	Temp3 = math.rad(Angle+(360*Case)/Point)
				   	x1 = Temp1s * math.cos(Temp2)
				   	x2 = Temp1 * math.cos(Temp3)
				   	y1 = Temp1s * math.sin(Temp2)
				   	y2 = Temp1 * math.sin(Temp3)
				end

				LX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
				LY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)

			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end

			Main = Main + 1
		end
	end 

	return Shape	
end

function CSMakeStarX(Point,StarAngle,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90
	
	local SA
	if type(StarAngle) == "number" then
		SA = StarAngle
	else
		SA = math.deg(2*math.atan(math.sin(math.rad(180/Point))/((StarAngle[1]/Radius)-1+(math.cos(math.rad(180/Point)))))) 
	end

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0
	local Pts = 0
	local StarRadius = Radius * (math.cos(math.rad(180/Point))-math.sin(math.rad(180/Point))/math.tan(math.rad(SA/2)))
	local HalfRad = Radius/2
	local HalfStarRad = StarRadius/2

	Point = Point*2

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp1s
	local Temp2
	local Temp3
	local InitRadius = Radius / 2 --(2*math.sin(math.rad(180/Point)))
	local InitStarRadius = StarRadius / 2 --(2*math.sin(math.rad(180/Point)))

	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local LX = nil
	local LY = nil

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 2
		   		Temp = (Level*(Level-1)*Point)/2 + 1
		   		TempA = ((Level*Level-3*Level+2)*Point)/2 + 1
		   		Main = Main + (Level-2)*Point
		   	end
		   	Case = 1
		   	TempB = Level-1
		   	while true do
			   	if Main <= TempA+TempB then break end
			   	Case = Case + 1
			   	TempB = Case*(Level-1)
			end

			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				Pts = (TempA + TempB) - Main

				if Case%2 == 0 then
				   	Temp1 = ((Level-2) * HalfRad) + InitRadius
				   	Temp1s = ((Level-2) * HalfStarRad) + InitStarRadius
				   	Temp2 = math.rad(Angle+(360*(Case-1))/Point)
				   	Temp3 = math.rad(Angle+(360*Case)/Point)
				   	x1 = Temp1 * math.cos(Temp2)
				   	x2 = Temp1s * math.cos(Temp3)
				   	y1 = Temp1 * math.sin(Temp2)
				   	y2 = Temp1s * math.sin(Temp3)
				else
					Temp1 = ((Level-2) * HalfRad) + InitRadius
					Temp1s = ((Level-2) * HalfStarRad) + InitStarRadius
				   	Temp2 = math.rad(Angle+(360*(Case-1))/Point)
				   	Temp3 = math.rad(Angle+(360*Case)/Point)
				   	x1 = Temp1s * math.cos(Temp2)
				   	x2 = Temp1 * math.cos(Temp3)
				   	y1 = Temp1s * math.sin(Temp2)
				   	y2 = Temp1 * math.sin(Temp3)
				end

				LX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
				LY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)

			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end

			Main = Main + 1
		end
	end 

	return Shape	
end

function CSMakeLine(Point,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0
	local Pts = 0

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp2
	local Temp3

	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local LX = nil
	local LY = nil

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
				table.insert(Shape,{0,0})
				Remain = Remain - 1
			end
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 1
		   		Temp = ((Level-1)*Point) + 1
		   		Case = 0
		   	end

			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
			   	Temp1 = ((Level-1) * Radius)
			   	Temp2 = math.rad(Angle+(360*Case)/Point)

			   	LX = Temp1 * math.cos(Temp2)
			   	LY = Temp1 * math.sin(Temp2)
			   		
			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end

			Main = Main + 1
			Case = Case + 1
		end
	end 

	return Shape	
end

function CSMakeLineX(Point,Radius,Angle,Number,Hollow)
	local Shape = {Number-Hollow}
	if Number < Hollow then
		CS_InputError()
	end
	Angle = Angle - 90

	local Main = 1
	local Level = 1
	local Remain = Number
	local Case = 0
	local Pts = 0

	local Temp
	local TempA
	local TempB
	local Temp1
	local Temp2
	local Temp3
	local HalfRad = Radius/2

	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local LX = nil
	local LY = nil
	local InitRadius = Radius / 2 --(2*math.sin(math.rad(180/Point)))

	while true do
		if Remain == 0 then break end
		if Main == 1 then
			Main = 2
			Level = 2
			Temp = Point + 1
			TempA = 1
		else
			while true do
		   		if Main <= Temp then break end
		   		Level = Level + 1
		   		Temp = ((Level-1)*Point) + 1
		   		Case = 0
		   	end

			if Hollow >= 1 then
				Hollow = Hollow - 1
			else
			   	Temp1 = ((Level-2) * HalfRad) + InitRadius
			   	Temp2 = math.rad(Angle+(360*Case)/Point)

			   	LX = Temp1 * math.cos(Temp2)
			   	LY = Temp1 * math.sin(Temp2)
			   		
			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end

			Main = Main + 1
			Case = Case + 1
		end
	end 

	return Shape	
end
 
 -- function SnowFlake_funcY(X) return -X end 
function CSMakeGraphX(Ratio,funcY,Start,Direction,StepSize,StepRange,Number)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if StepRange == nil then
		StepRange = StepSize
	end
	local Shape = {Number}
	local NX, NY
	if Direction == nil then
		Direction = 0
	end
	if StepSize <= 0 then
		CS_InputError()
	end
	StepSize = StepSize^2
	local ER = StepSize*0.05 -- 오차 한계 < 5%
	NX = Start
	NY = _G[funcY](NX)
	table.insert(Shape,{NX*XRatio,NY*YRatio})
	for i = 1, Number-1 do
		local dx, sx, CX, CY, Count
		dx = StepRange
		sx = StepRange
		Count = 0
		while true do
			if Direction == 0 then
				CX = NX + dx
			else
				CX = NX - dx
			end
			CY = _G[funcY](CX)
			local Length = (CX-NX)^2+(CY-NY)^2
			if math.abs(Length-StepSize) < ER or Count > 12 then break end

			if Length>=StepSize then 
				sx = sx/2
				dx = dx - sx
			else
				sx = sx/2
				dx = dx + sx
			end
			Count = Count + 1
		end
		NX = CX
		NY = CY
		table.insert(Shape,{NX*XRatio,NY*YRatio})
	end
	return Shape
end

 -- function SnowFlake_funcX(Y) return -Y end 
function CSMakeGraphY(Ratio,funcX,Start,Direction,StepSize,StepRange,Number)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if StepRange == nil then
		StepRange = StepSize
	end
	local Shape = {Number}
	local NX, NY
	if Direction == nil then
		Direction = 0
	end
	if StepSize <= 0 then
		CS_InputError()
	end
	StepSize = StepSize^2
	local ER = StepSize*0.05 -- 오차 한계 < 5%
	NY = Start
	NX = _G[funcX](NY)
	table.insert(Shape,{NX*XRatio,NY*YRatio})
	for i = 1, Number-1 do
		local dy, sy, CX, CY, Count
		dy = StepRange
		sy = StepRange
		Count = 0
		while true do
			if Direction == 0 then
				CY = NY + dy
			else
				CY = NY - dy
			end
			CX = _G[funcX](CY)
			local Length = (CX-NX)^2+(CY-NY)^2
			if math.abs(Length-StepSize) < ER or Count > 12 then break end

			if Length>=StepSize then 
				sy = sy/2
				dy = dy - sy
			else
				sy = sy/2
				dy = dy + sy
			end
			Count = Count + 1
		end
		NX = CX
		NY = CY
		table.insert(Shape,{NX*XRatio,NY*YRatio})
	end
	return Shape
end

 -- function SnowFlake_funcR(A) return -A end 
function CSMakeGraphA(Ratio,funcR,Start,Direction,StepSize,StepRange,Number)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if StepRange == nil then
		StepRange = 2*math.pi
	end
	local Shape = {Number}
	local NR, NA
	if Direction == nil then
		Direction = 0
	end
	if StepSize <= 0 then
		CS_InputError()
	end
	StepSize = StepSize^2
	local ER = StepSize*0.05 -- 오차 한계 < 5%
	NA = Start
	NR = _G[funcR](NA)
	NX = NR*math.cos(NA)
	NY = NR*math.sin(NA)
	table.insert(Shape,{NX*XRatio,NY*YRatio})
	for i = 1, Number-1 do
		local da, sa, CR, CA, Count
		da = StepRange
		sa = StepRange
		Count = 0
		while true do
			if Direction == 0 then
				CA = NA + da
			else
				CA = NA - da
			end
			CR = _G[funcR](CA)
			local Length = CR^2+NR^2-2*CR*NR*math.cos(math.abs(CA-NA))
			if math.abs(Length-StepSize) < ER or Count > 12 then break end

			if Length>=StepSize then 
				sa = sa/2
				da = da - sa
			else
				sa = sa/2
				da = da + sa
			end
			Count = Count + 1
		end
		NA = CA
		NR = CR
		NX = NR*math.cos(NA)
		NY = NR*math.sin(NA)
		table.insert(Shape,{NX*XRatio,NY*YRatio})
	end
	return Shape
end

 -- function SnowFlake_funcA(R) return -R end 
function CSMakeGraphR(Ratio,funcA,Start,Direction,StepSize,StepRange,Number)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if StepRange == nil then
		StepRange = StepSize
	end
	local Shape = {Number}
	local NR, NA
	if Direction == nil then
		Direction = 0
	end
	if StepSize <= 0 then
		CS_InputError()
	end
	StepSize = StepSize^2
	local ER = StepSize*0.05 -- 오차 한계 < 5%
	NR = Start
	NA = _G[funcA](NR)
	NX = NR*math.cos(NA)
	NY = NR*math.sin(NA)
	table.insert(Shape,{NX*XRatio,NY*YRatio})
	for i = 1, Number-1 do
		local dr, sr, CR, CA, Count
		dr = StepRange
		sr = StepRange
		Count = 0
		while true do
			if Direction == 0 then
				CR = NR + dr
			else
				CR = NR - dr
			end
			CA = _G[funcA](CR)
			local Length = CR^2+NR^2-2*CR*NR*math.cos(math.abs(CA-NA))
			if math.abs(Length-StepSize) < ER or Count > 12 then break end

			if Length>=StepSize then 
				sr = sr/2
				dr = dr - sr
			else
				sr = sr/2
				dr = dr + sr
			end
			Count = Count + 1
		end
		NA = CA
		NR = CR
		NX = NR*math.cos(NA)
		NY = NR*math.sin(NA)
		table.insert(Shape,{NX*XRatio,NY*YRatio})
	end
	return Shape
end

 -- function SnowFlake_Parafunc(T) return {-T,T} end 
function CSMakeGraphT(Ratio,Parafunc,Start,Direction,StepSize,StepRange,Number)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if StepRange == nil then
		StepRange = StepSize
	end
	local Shape = {Number}
	local NX, NY, NT
	if Direction == nil then
		Direction = 0
	end
	if StepSize <= 0 then
		CS_InputError()
	end
	StepSize = StepSize^2
	local ER = StepSize*0.05 -- 오차 한계 < 5%
	NT = Start
	local Ret = _G[Parafunc](NT)
	NX = Ret[1]
	NY = Ret[2]
	table.insert(Shape,{NX*XRatio,NY*YRatio})
	for i = 1, Number-1 do
		local dt, st, CT, CX, CY, Count
		dt = StepRange
		st = StepRange
		Count = 0
		while true do
			if Direction == 0 then
				CT = NT + dt
			else
				CT = NT - dt
			end
			Ret = _G[Parafunc](CT)
			CX = Ret[1]
			CY = Ret[2]
			local Length = (CX-NX)^2+(CY-NY)^2
			if math.abs(Length-StepSize) < ER or Count > 12 then break end

			if Length>=StepSize then 
				st = st/2
				dt = dt - st
			else
				st = st/2
				dt = dt + st
			end
			Count = Count + 1
		end
		NT = CT
		Ret = _G[Parafunc](NT)
		NX = Ret[1]
		NY = Ret[2]
		table.insert(Shape,{NX*XRatio,NY*YRatio})
	end
	return Shape
end

-- CS_ Function : Shape -> Shape (Invert는 Subtract로 사용) -------------------------------------------------------------------------------------------------------------------------------------------------------
-- MoveXY,RA : 직교좌표,극좌표 평행이동 / Rotate(3D) : 회전(삼차원) / InvertXY, InvertRA : 직교좌표,극좌표 반전 / Shuffle : 순서 셔플(OrderShape전용) / CheckXY,RA,Path,Stack,Collide : 직교좌표,극좌표,임의경로,겹친부분,타 도형과의 충돌체크 / Reverse : 역순으로 재배열
-- RatioXY, RatioRA : 직교좌표, 극좌표 크기조정 / CropXY, CropRA, CropPath : 직교좌표, 극좌표, 임의도형 외부자르기 / FillXY,RA,HX,RD,PathXY,RA,HX,RD : 직교좌표, 극좌표, 임의도형 내부 채우기 / Convert : Number가 다른 Shape를 수에 맞게 랜덤으로 변환 / Add : 도형에 점 데이터 추가
-- RemoveStack : 겹친 영역 지우기 / Merge : 합치기 A∪B / Overlap : 겹치기 A+B / Intersect : 공통영역 A∩B / Subtract : 빼기 A-B / Xor : AΔB / MirrorX,Y,R,A : 좌우,상하,원,각도 대칭 / Kaleidoscope(X) : 만화경 대칭 (좌우(비)대칭) / Vector2D(Polar) : 2D벡터(극좌표)함수 이미지 변환

function CS_MoveXY(Shape,X,Y)
	if Shape == nil then
		CS_InputError()
	end
	if X == nil then
		X = 0
	end
	if Y == nil then
		Y = 0
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1] + X
		NY = Shape[i+1][2] + Y
		table.insert(RetShape,{NX,NY})
	end
	return RetShape	
end

function CS_MoveRA(Shape,Radius,Angle)
	if Shape == nil then
		CS_InputError()
	end
	if Radius == nil then
		Radius = 0
	end
	if Angle == nil then
		Angle = 0
	end
	Angle = math.rad(Angle)
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA
		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end
		PR = PR + Radius
		PA = PA + Angle
		NX = PR*math.cos(PA)
		NY = PR*math.sin(PA)
		table.insert(RetShape,{NX,NY})
	end
	return RetShape	
end

function CS_Rotate(Shape,Angle)
	if Shape == nil then
		CS_InputError()
	end
	if Angle == nil then
		Angle = 0
	end
	Angle = math.rad(Angle)
	local XYCos = math.cos(Angle)
	local XYSin = math.sin(Angle)
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PX, PY
		PX = NX*XYCos - NY*XYSin
		PY = NX*XYSin + NY*XYCos
		table.insert(RetShape,{PX,PY})
	end
	return RetShape	
end

function CS_Rotate3D(Shape,XYAngle,YZAngle,ZXAngle)
	if Shape == nil then
		CS_InputError()
	end
	if XYAngle == nil then
		XYAngle = 0
	end
	if YZAngle == nil then
		YZAngle = 0
	end
	if ZXAngle == nil then
		ZXAngle = 0
	end
	XYAngle = math.rad(XYAngle)
	YZAngle = math.rad(YZAngle)
	ZXAngle = math.rad(ZXAngle)
	local XYCos = math.cos(XYAngle)
	local XYSin = math.sin(XYAngle)
	local YZCos = math.cos(YZAngle)
	local YZSin = math.sin(YZAngle)
	local ZXCos = math.cos(ZXAngle)
	local ZXSin = math.sin(ZXAngle)
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PX, PY, PZ
		PX = NX
		PY = NY
		PZ = 0
		if XYAngle ~= 0 then
			PX = NX*XYCos - NY*XYSin
			PY = NX*XYSin + NY*XYCos
		end
		NY = PY
		if YZAngle ~= 0 then
			PY = NY*YZCos
			PZ = NY*YZSin
		end
		NX = PX
		NY = PY
		NZ = PZ
		if ZXAngle ~= 0 then
			PX = NX*ZXCos - NZ*ZXSin
		end
		table.insert(RetShape,{PX,PY})
	end
	return RetShape	
end

function CS_InvertXY(Shape,X,Y)
	if Shape == nil then
		CS_InputError()
	end
	if X ~= nil then
		X = X*2
	end
	if Y ~= nil then
		Y = Y*2
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		if X == nil then
			NX = Shape[i+1][1]
		else
			NX = X - Shape[i+1][1]
		end
		if Y == nil then
			NY = Shape[i+1][2]
		else
			NY = Y - Shape[i+1][2]
		end
		table.insert(RetShape,{NX,NY})
	end
	return RetShape	
end

function CS_InvertRA(Shape,Radius,Angle)
	if Shape == nil then
		CS_InputError()
	end
	if Radius ~= nil then
		Radius = Radius*2
	end
	if Angle ~= nil then
		Angle = math.rad(Angle*2)
	end
	local RetShape = {Shape[1]}

	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if Radius == nil then
			PR = PR
		else
			PR = Radius - PR
		end
		if Angle == nil then
			PA = PA
		else
			PA = Angle - PA
		end

		NX = PR*math.cos(PA)
		NY = PR*math.sin(PA)
		
		table.insert(RetShape,{NX,NY})
	end
	return RetShape	
end

function CS_RatioXY(Shape,mulX,mulY)
	if Shape == nil then
		CS_InputError()
	end

	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		if mulX == nil then
			NX = Shape[i+1][1]
		else
			NX = mulX * Shape[i+1][1]
		end
		if mulY == nil then
			NY = Shape[i+1][2]
		else
			NY = mulY * Shape[i+1][2]
		end
		table.insert(RetShape,{NX,NY})
	end
	return RetShape	
end

function CS_RatioRA(Shape,mulRadius,mulAngle)
	if Shape == nil then
		CS_InputError()
	end
	local RetShape = {Shape[1]}

	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if mulRadius == nil then
			PR = PR
		else
			PR = mulRadius * PR
		end
		if mulAngle == nil then
			PA = PA
		else
			PA = mulAngle * PA
		end

		NX = PR*math.cos(PA)
		NY = PR*math.sin(PA)
		
		table.insert(RetShape,{NX,NY})
	end
	return RetShape	
end

function CS_Reverse(Shape)
	local RetShape = {}
	if Shape == nil then
		CS_InputError()
	end
	RetShape = {Shape[1]}	
	for i = Shape[1]+1, 2, -1 do
		table.insert(RetShape,Shape[i])
	end

	return RetShape	
end

function CS_Add(Shape,Ratio,PathData,...)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	local Count = 0
	if type(PathData[2]) == "number" then
		PathData = {PathData}
	end
	local arg = table.pack(...)
	for k = 1, arg.n do
		table.insert(PathData,arg[k])
	end

	local RetShape = {0}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end
	for k, v in pairs(PathData) do
		v[1] = v[1] * XRatio
		v[2] = v[2] * YRatio
		table.insert(RetShape,v)
		Count = Count + 1
	end
	RetShape[1] = Shape[1] + Count
	return RetShape
end

math.randomseed(os.time())
function CS_Shuffle(Shape)
	local RetShape = {}
	if Shape == nil then
		CS_InputError()
	end
	for k, v in pairs(Shape) do
		table.insert(RetShape,v)
	end
	local Temp, Index
	for j = 0, 2 do
		for i = 1, RetShape[1] do
			Index = math.random(2,RetShape[1]+1)
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Index]
			RetShape[Index] = Temp
		end
	end

	return RetShape	
end

function CS_Convert(Shape,Number)
	local NShape = {}
	if Shape == nil then
		CS_InputError()
	end
	for k, v in pairs(Shape) do
		table.insert(NShape,v)
	end
	local RetShape = {Number}
	if Number <= Shape[1] then
		local Temp, Index
		for j = 0, 2 do
			for i = 1, NShape[1] do
				Index = math.random(2,NShape[1]+1)
				Temp = NShape[i+1]
				NShape[i+1] = NShape[Index]
				NShape[Index] = Temp
			end
		end
		for i = 1, Number do
			table.insert(RetShape,NShape[i+1])
		end
	else
		local Count = 0
		while true do
			if Count >= Number then break end
			local Temp, Index
			for j = 0, 2 do
				for i = 1, NShape[1] do
					Index = math.random(2,NShape[1]+1)
					Temp = NShape[i+1]
					NShape[i+1] = NShape[Index]
					NShape[Index] = Temp
				end
			end
			for i = 1, NShape[1] do
				if Count >= Number then break end
				table.insert(RetShape,NShape[i+1])
				Count = Count + 1
			end
		end
		local Temp, Index
		for j = 0, 2 do
			for i = 1, Number do
				Index = math.random(2,RetShape[1]+1)
				Temp = RetShape[i+1]
				RetShape[i+1] = RetShape[Index]
				RetShape[Index] = Temp
			end
		end
	end
	return RetShape	
end

function CS_FillRD(Edge,areaX,areaY,sizeX,sizeY,StackSizeX,StackSizeY)
	if sizeX == nil or sizeY == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 1
	end
	if StackSizeX == nil then
		StackSizeX = 0
	end
	StackSizeX = StackSizeX/2
	if StackSizeY == nil then
		StackSizeY = 0
	end
	StackSizeY = StackSizeY/2
	
	local X1,X2,Y1,Y2,SX,SY,DX,DY,NX,NY,PX,PY
	if areaX == nil then
		CS_InputError()
	elseif type(areaX) == "number" then
		DX = areaX
		X2 = DX/2
		X1 = 0-X2	
	else
		DX = math.abs(areaX[2] - areaX[1])
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if Edge == 0 then
		if DX%sizeX == 0 then
			SX = DX/sizeX
			PX = (sizeX)/2
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	else
		if DX%sizeX == 0 then
			SX = DX/sizeX+1
			PX = 0
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	end
	if areaY == nil then
		CS_InputError()
	elseif type(areaY) == "number" then
		DY = areaY
		Y2 = DY/2
		Y1 = 0-Y2	
	else
		DY = math.abs(areaY[2] - areaY[1])
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	if Edge == 0 then
		if DY%sizeY == 0 then
			SY = DY/sizeY
			PY = (sizeY)/2
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	else
		if DY%sizeY == 0 then
			SY = DY/sizeY+1
			PY = 0
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	end
	local RetShape = {0}
	local Count3 = 0
	local Temp = SX*SY
	local Count = 1
	local Check
	for j = 1, Temp do
		Check = 0
		for l = 1, 100 do
			NX = math.random(PX+X1,X2-PX)
			NY = math.random(PY+Y1,Y2-PY)
			for i = 2, Count do
				if (NX>RetShape[i][1]-StackSizeX and NX<RetShape[i][1]+StackSizeX) and (NY>RetShape[i][2]-StackSizeY and NY<RetShape[i][2]+StackSizeY) then
					Check = 1
				end
			end
			if Check == 0 then
				break
			end
		end
		table.insert(RetShape,{NX,NY})
		Count = Count + 1
		Count3 = Count3 + 1
	end
	RetShape[1] = Count3
	return RetShape
end

function CS_CropXY(Shape,areaX,areaY,edgeX,edgeY)
	if Shape == nil then
		CS_InputError()
	end
	local Count = 0
	local Check = 0
	local RetShape = {0}
	local X1,X2,Y1,Y2
	local EX1=0
	local EX2=0
	local EY1=0
	local EY2=0
	if areaX ~= nil then
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if areaY ~= nil then
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	if edgeX ~= nil then
		if edgeX[1] == nil then
			EX1 = 0
		else
			EX1 = 1
		end
		if edgeX[2] == nil then
			EX2 = 0
		else
			EX2 = 1
		end
	end
	if edgeY ~= nil then
		if edgeY[1] == nil then
			EY1 = 0
		else
			EY1 = 1
		end
		if edgeY[2] == nil then
			EY2 = 0
		else
			EY2 = 1
		end
	end

	for i = 1, Shape[1] do
		Check = 0
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]

		if X1 ~= nil then
			if EX1 == 0 and NX < X1 then
				Check = 1
			end
			if EX1 == 1 and NX <= X1 then
				Check = 1
			end
		end
		if X2 ~= nil then
			if EX2 == 0 and NX > X2 then
				Check = 1
			end
			if EX2 == 1 and NX >= X2 then
				Check = 1
			end
		end
		if Y1 ~= nil then
			if EY1 == 0 and NY < Y1 then
				Check = 1
			end
			if EY1 == 1 and NY <= Y1 then
				Check = 1
			end
		end
		if Y2 ~= nil then
			if EY2 == 0 and NY > Y2 then
				Check = 1
			end
			if EY2 == 1 and NY >= Y2 then
				Check = 1
			end
		end

		if Check == 0 then
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	RetShape[1] = Count
	return RetShape	
end

function CS_CropRA(Shape,areaR,areaA,edgeR,edgeA)
	if Shape == nil then
		CS_InputError()
	end
	local Count = 0
	local Check = 0
	local RetShape = {0}
	local R1,R2,A1,A2
	local ER1=0
	local ER2=0
	local EA1=0
	local EA2=0
	if areaR ~= nil then
		R1 = areaR[1]
		R2 = areaR[2]
	end
	if areaA ~= nil then
		A1 = areaA[1]
		A2 = areaA[2]
		if A1 ~= nil then
			A1 = math.rad(A1)
		end
		if A2 ~= nil then
			A2 = math.rad(A2)
		end
	end
	if edgeR ~= nil then
		if edgeR[1] == nil then
			ER1 = 0
		else
			ER1 = 1
		end
		if edgeR[2] == nil then
			ER2 = 0
		else
			ER2 = 1
		end
	end
	if edgeA ~= nil then
		if edgeA[1] == nil then
			EA1 = 0
		else
			EA1 = 1
		end
		if edgeA[2] == nil then
			EA2 = 0
		else
			EA2 = 1
		end
	end

	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end
		Check = 0

		if R1 ~= nil then
			if ER1 == 0 and PR < R1 then
				Check = 1
			end
			if ER1 == 1 and PR <= R1 then
				Check = 1
			end
		end
		if R2 ~= nil then
			if ER2 == 0 and PR > R2 then
				Check = 1
			end
			if ER2 == 1 and PR >= R2 then
				Check = 1
			end
		end
		if A1 ~= nil then
			if EA1 == 0 and PA < A1 then
				Check = 1
			end
			if EA1 == 1 and PA <= A1 then
				Check = 1
			end
		end
		if A2 ~= nil then
			if EA2 == 0 and PA > A2 then
				Check = 1
			end
			if EA2 == 1 and PA >= A2 then
				Check = 1
			end
		end

		if Check == 0 then
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	RetShape[1] = Count
	return RetShape	
end

function CS_CheckXY(Shape,areaX,areaY,edgeX,edgeY)
	if Shape == nil then
		CS_InputError()
	end
	local X1,X2,Y1,Y2
	local EX1=0
	local EX2=0
	local EY1=0
	local EY2=0
	if areaX ~= nil then
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if areaY ~= nil then
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	if edgeX ~= nil then
		if edgeX[1] == nil then
			EX1 = 0
		else
			EX1 = 1
		end
		if edgeX[2] == nil then
			EX2 = 0
		else
			EX2 = 1
		end
	end
	if edgeY ~= nil then
		if edgeY[1] == nil then
			EY1 = 0
		else
			EY1 = 1
		end
		if edgeY[2] == nil then
			EY2 = 0
		else
			EY2 = 1
		end
	end

	for i = 1, Shape[1] do
		Check = 0
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]

		if X1 ~= nil then
			if EX1 == 0 and NX < X1 then
				CS_UnderX1_Detected()
			end
			if EX1 == 1 and NX <= X1 then
				CS_UnderX1_Detected()
			end
		end
		if X2 ~= nil then
			if EX2 == 0 and NX > X2 then
				CS_OverX2_Detected()
			end
			if EX2 == 1 and NX >= X2 then
				CS_OverX2_Detected()
			end
		end
		if Y1 ~= nil then
			if EY1 == 0 and NY < Y1 then
				CS_UnderY1_Detected()
			end
			if EY1 == 1 and NY <= Y1 then
				CS_UnderY1_Detected()
			end
		end
		if Y2 ~= nil then
			if EY2 == 0 and NY > Y2 then
				CS_OverY2_Detected()
			end
			if EY2 == 1 and NY >= Y2 then
				CS_OverY2_Detected()
			end
		end
	end
end

function CS_CheckRA(Shape,areaR,areaA,edgeR,edgeA)
	if Shape == nil then
		CS_InputError()
	end
	local R1,R2,A1,A2
	local ER1=0
	local ER2=0
	local EA1=0
	local EA2=0
	if areaR ~= nil then
		R1 = areaR[1]
		R2 = areaR[2]
	end
	if areaA ~= nil then
		A1 = areaA[1]
		A2 = areaA[2]
		if A1 ~= nil then
			A1 = math.rad(A1)
		end
		if A2 ~= nil then
			A2 = math.rad(A2)
		end
	end
	if edgeR ~= nil then
		if edgeR[1] == nil then
			ER1 = 0
		else
			ER1 = 1
		end
		if edgeR[2] == nil then
			ER2 = 0
		else
			ER2 = 1
		end
	end
	if edgeA ~= nil then
		if edgeA[1] == nil then
			EA1 = 0
		else
			EA1 = 1
		end
		if edgeA[2] == nil then
			EA2 = 0
		else
			EA2 = 1
		end
	end

	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end
		Check = 0

		if R1 ~= nil then
			if ER1 == 0 and PR < R1 then
				CS_UnderR1_Detected()
			end
			if ER1 == 1 and PR <= R1 then
				CS_UnderR1_Detected()
			end
		end
		if R2 ~= nil then
			if ER2 == 0 and PR > R2 then
				CS_OverR2_Detected()
			end
			if ER2 == 1 and PR >= R2 then
				CS_OverR2_Detected()
			end
		end
		if A1 ~= nil then
			if EA1 == 0 and PA < A1 then
				CS_UnderA1_Detected()
			end
			if EA1 == 1 and PA <= A1 then
				CS_UnderA1_Detected()
			end
		end
		if A2 ~= nil then
			if EA2 == 0 and PA > A2 then
				CS_OverA2_Detected()
			end
			if EA2 == 1 and PA >= A2 then
				CS_OverA2_Detected()
			end
		end
	end
end

function CS_MirrorX(Shape,X,Side,Size)
	if Shape == nil then
		CS_InputError()
	end
	local XX
	if X == nil then
		X = 0
		XX = 0
	else
		XX = X*2
	end
	if Side == nil then
		Side = 0
	elseif Side ~= 0 then
		Side = 1
	end
	if Size == nil then
		Size = 0
	end
	local Count1 = 0
	local Count2 = 0
	local RetShape = {0}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		if Side == 0 then
			if NX >= (X-Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if NX >= (X+Size) then
					table.insert(RetShape,{XX-NX,NY})
					Count2 = Count2 + 1
				end
			end
		else
			if NX <= (X+Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if NX <= (X-Size) then
					table.insert(RetShape,{XX-NX,NY})
					Count2 = Count2 + 1
				end
			end
		end
	end
	RetShape[1] = Count1+Count2
	return RetShape	
end

function CS_MirrorY(Shape,Y,Side,Size)
	if Shape == nil then
		CS_InputError()
	end
	local YY
	if Y == nil then
		Y = 0
		YY = 0
	else
		YY = Y*2
	end
	if Side == nil then
		Side = 0
	elseif Side ~= 0 then
		Side = 1
	end
	if Size == nil then
		Size = 0
	end
	local Count1 = 0
	local Count2 = 0
	local RetShape = {0}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		if Side == 0 then
			if NY >= (Y-Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if NY >= (Y+Size) then
					table.insert(RetShape,{NX,YY-NY})
					Count2 = Count2 + 1
				end
			end
		else
			if NY <= (Y+Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if NY <= (Y-Size) then
					table.insert(RetShape,{NX,YY-NY})
					Count2 = Count2 + 1
				end
			end
		end
	end
	RetShape[1] = Count1+Count2
	return RetShape	
end

function CS_MirrorR(Shape,Radius,Side,Size)
	if Shape == nil then
		CS_InputError()
	end
	local RR
	if Radius == nil then
		Radius = 0
		RR = 0
	else
		RR = Radius*2
	end
	if Side == nil then
		Side = 0
	elseif Side ~= 0 then
		Side = 1
	end
	if Size == nil then
		Size = 0
	end
	local Count1 = 0
	local Count2 = 0
	local RetShape = {0}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if Side == 0 then
			if PR >= (Radius-Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if PR >= (Radius+Size) then
					PR = RR - PR
					NX = PR*math.cos(PA)
					NY = PR*math.sin(PA)
					table.insert(RetShape,{NX,NY})
					Count2 = Count2 + 1
				end
			end
		else
			if PR <= (Radius+Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if PR <= (Radius-Size) then
					PR = RR - PR
					NX = PR*math.cos(PA)
					NY = PR*math.sin(PA)
					table.insert(RetShape,{NX,NY})
					Count2 = Count2 + 1
				end
			end
		end
	end
	RetShape[1] = Count1+Count2
	return RetShape	
end

function CS_MirrorA(Shape,Angle,Side,Size)
	if Shape == nil then
		CS_InputError()
	end
	local AA
	if Angle == nil then
		Angle = 0
		AA = 0
	else
		AA = math.rad(Angle*2)
	end
	if Side == nil then
		Side = 0
	elseif Side ~= 0 then
		Side = 1
	end
	if Size == nil then
		Size = 0
	end
	local Count1 = 0
	local Count2 = 0
	local RetShape = {0}
	Angle = math.rad(Angle)
	Size = math.rad(Size)
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if Side == 0 then
			if PA >= (Angle-Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if PA >= (Angle+Size) then
					PA = AA - PA
					NX = PR*math.cos(PA)
					NY = PR*math.sin(PA)
					table.insert(RetShape,{NX,NY})
					Count2 = Count2 + 1
				end
			end
		else
			if PA <= (Angle+Size) then
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if PA <= (Angle-Size) then
					PA = AA - PA
					NX = PR*math.cos(PA)
					NY = PR*math.sin(PA)
					table.insert(RetShape,{NX,NY})
					Count2 = Count2 + 1
				end
			end
		end
	end
	RetShape[1] = Count1+Count2
	return RetShape	
end

function CS_Kaleidoscope(Shape,Point,StartAngle,Side,Size)
	if Shape == nil then
		CS_InputError()
	end
	if Point == nil then
		CS_InputError()
	end
	local PP = Point*2
	if StartAngle == nil then
		StartAngle = 0
	end

	if Side == nil then
		Side = 0
	elseif Side ~= 0 then
		Side = 1
	end
	if Size == nil then
		Size = 0
	end

	local Section = math.rad(360/Point)
	local HalfSec = math.rad(360/PP)
	local Size = math.rad(Size)

	local Count1 = 0
	local Count2 = 0
	local RetShape = {0}

	local NShape = {}
	NShape = CS_Rotate(Shape,0-StartAngle)

	for i = 1, NShape[1] do
		local NX, NY
		NX = NShape[i+1][1]
		NY = NShape[i+1][2]
		local PR, PA, NA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if Side == 0 then
			 if PA >= 0 and PA <= HalfSec then 
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if PA <= (HalfSec-Size) then
					local Check = 0
					local CLock = 0
					local CType = Section
					local CCount = 1
					while true do
						if CCount >= PP then break end
						if Check == 0 then
							NA = CType-PA
						else
							NA = CType+PA
						end
						NX = PR*math.cos(NA)
						NY = PR*math.sin(NA)
						table.insert(RetShape,{NX,NY})
						Count2 = Count2 + 1
						CCount = CCount + 1
						CLock = 0
						if Check == 0 and CLock == 0 then 
							Check = 1 
							CLock = 1
						end
						if Check == 1 and CLock == 0 then
						 	Check = 0 
						 	CLock = 1
						 	CType = CType + Section
						end
					end
				else
					local Check = 0
					local CLock = 0
					local CType = Section
					local CCount = 1
					while true do
						if CCount >= PP then break end
						if Check == 0 then
							NA = CType-PA
						else
							NA = CType+PA
						end
						CCount = CCount + 1
						CLock = 0
						if Check == 0 and CLock == 0 then 
							Check = 1 
							CLock = 1
							NX = PR*math.cos(NA)
							NY = PR*math.sin(NA)
							table.insert(RetShape,{NX,NY})
							Count2 = Count2 + 1
						end
						if Check == 1 and CLock == 0 then
						 	Check = 0 
						 	CLock = 1
						 	CType = CType + Section
						end
					end
				end
			end
		else
			if PA >= 2*math.pi-HalfSec and PA <= 2*math.pi then 
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				if PA >= (2*math.pi-HalfSec+Size) then
					local Check = 0
					local CLock = 0
					local CType = Section
					local CCount = 1
					while true do
						if CCount >= PP then break end
						if Check == 0 then
							NA = 4*math.pi - PA - CType
						else
							NA = PA - CType
						end
						NX = PR*math.cos(NA)
						NY = PR*math.sin(NA)
						table.insert(RetShape,{NX,NY})
						Count2 = Count2 + 1
						CCount = CCount + 1
						CLock = 0
						if Check == 0 and CLock == 0 then 
							Check = 1 
							CLock = 1
						end
						if Check == 1 and CLock == 0 then
						 	Check = 0 
						 	CLock = 1
						 	CType = CType + Section
						end
					end
				else
					local Check = 0
					local CLock = 0
					local CType = Section
					local CCount = 1
					while true do
						if CCount >= PP then break end
						if Check == 0 then
							NA = CType-PA
						else
							NA = CType+PA
						end
						CCount = CCount + 1
						CLock = 0
						if Check == 0 and CLock == 0 then 
							Check = 1 
							CLock = 1
							NX = PR*math.cos(NA)
							NY = PR*math.sin(NA)
							table.insert(RetShape,{NX,NY})
							Count2 = Count2 + 1
						end
						if Check == 1 and CLock == 0 then
						 	Check = 0 
						 	CLock = 1
						 	CType = CType + Section
						end
					end
				end
			end
		end
	end
	RetShape[1] = Count1+Count2
	RetShape = CS_Rotate(RetShape,StartAngle)
	return RetShape	
end

function CS_KaleidoscopeX(Shape,Point,StartAngle,Side)
	if Shape == nil then
		CS_InputError()
	end
	if Point == nil then
		CS_InputError()
	end
	local PP = Point*2
	if StartAngle == nil then
		StartAngle = 0
	end

	if Side == nil then
		Side = 0
	elseif Side ~= 0 then
		Side = 1
	end

	local Section = math.rad(360/Point)
	local HalfSec = math.rad(360/PP)

	local Count1 = 0
	local Count2 = 0
	local RetShape = {0}

	local NShape = {}
	NShape = CS_Rotate(Shape,0-StartAngle)

	for i = 1, NShape[1] do
		local NX, NY
		NX = NShape[i+1][1]
		NY = NShape[i+1][2]
		local PR, PA, NA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if Side == 0 then
			 if PA >= 0 and PA <= Section then 
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				local CType = Section
				local CCount = 1
				while true do
					if CCount >= Point then break end
					NA = PA + CType
					NX = PR*math.cos(NA)
					NY = PR*math.sin(NA)
					table.insert(RetShape,{NX,NY})
					Count2 = Count2 + 1
					CCount = CCount + 1
					CType = CType + Section
				end
			end
		else
			if PA >= 2*math.pi-Section and PA <= 2*math.pi then 
				table.insert(RetShape,{NX,NY})
				Count1 = Count1 + 1
				local CType = Section
				local CCount = 1
				while true do
					if CCount >= Point then break end
					NA = PA - CType
					NX = PR*math.cos(NA)
					NY = PR*math.sin(NA)
					table.insert(RetShape,{NX,NY})
					Count2 = Count2 + 1
					CCount = CCount + 1
					CType = CType + Section
				end
			end
		end
	end
	RetShape[1] = Count1+Count2
	RetShape = CS_Rotate(RetShape,StartAngle)
	return RetShape	
end

function CS_Overlap(ShapeA,ShapeB)
	if ShapeA == nil then
		CS_InputError()
	end
	if ShapeB == nil then
		CS_InputError()
	end
	local RetShape = {ShapeA[1]+ShapeB[1]}

	for i = 1, ShapeA[1] do
		local NX, NY
		NX = ShapeA[i+1][1]
		NY = ShapeA[i+1][2]
		table.insert(RetShape,{NX,NY})
	end
	for i = 1, ShapeB[1] do
		local NX, NY
		NX = ShapeB[i+1][1]
		NY = ShapeB[i+1][2]
		table.insert(RetShape,{NX,NY})
	end
	return RetShape	
end

function CS_Merge(ShapeA,ShapeB,Size,Priority)
	if ShapeA == nil then
		CS_InputError()
	end
	if ShapeB == nil then
		CS_InputError()
	end
	if Size == nil then
		Size = 0
	end
	local SS = Size^2
	if Priority == nil then
		Priority = 0
	elseif Priority ~= 0 then
		Priority = 1
	end
	local RetShape = {0}
	local Count1 = 0
	local Count2 = 0

	if Priority == 0 then
		Count1 = ShapeA[1]
		for i = 1, ShapeA[1] do
			local NX, NY
			NX = ShapeA[i+1][1]
			NY = ShapeA[i+1][2]
			table.insert(RetShape,{NX,NY})
		end
		for j = 1, ShapeB[1] do
			local Check = 0
			for i = 1, ShapeA[1] do
				local NX, NY
				local DX, DY
				DX = math.abs(ShapeA[i+1][1]-ShapeB[j+1][1])
				DY = math.abs(ShapeA[i+1][2]-ShapeB[j+1][2])
				if DX < Size and DY < Size then
					if DX^2 + DY^2 < SS then
						Check = 1
						break
					end
				end
			end
			if Check == 0 then
				NX = ShapeB[j+1][1]
				NY = ShapeB[j+1][2]
				table.insert(RetShape,{NX,NY})
				Count2 = Count2 + 1
			end
		end
	else
		Count1 = ShapeB[1]
		for i = 1, ShapeB[1] do
			local NX, NY
			NX = ShapeB[i+1][1]
			NY = ShapeB[i+1][2]
			table.insert(RetShape,{NX,NY})
		end
		for j = 1, ShapeA[1] do
			local Check = 0
			for i = 1, ShapeB[1] do
				local NX, NY
				local DX, DY
				DX = math.abs(ShapeB[i+1][1]-ShapeA[j+1][1])
				DY = math.abs(ShapeB[i+1][2]-ShapeA[j+1][2])
				if DX < Size and DY < Size then
					if DX^2 + DY^2 < SS then
						Check = 1
						break
					end
				end
			end
			if Check == 0 then
				NX = ShapeA[j+1][1]
				NY = ShapeA[j+1][2]
				table.insert(RetShape,{NX,NY})
				Count2 = Count2 + 1
			end
		end
	end
	RetShape[1] = Count1 + Count2	
	return RetShape	
end

function CS_Intersect(ShapeA,ShapeB,Size,Priority)
	if ShapeA == nil then
		CS_InputError()
	end
	if ShapeB == nil then
		CS_InputError()
	end
	if Size == nil then
		Size = 0
	end
	local SS = Size^2
	if Priority == nil then
		Priority = 0
	elseif Priority ~= 0 then
		Priority = 1
	end
	local RetShape = {0}
	local Count2 = 0

	if Priority == 1 then
		for j = 1, ShapeB[1] do
			for i = 1, ShapeA[1] do
				local NX, NY
				local DX, DY
				DX = math.abs(ShapeA[i+1][1]-ShapeB[j+1][1])
				DY = math.abs(ShapeA[i+1][2]-ShapeB[j+1][2])
				if DX <= Size and DY <= Size then
					if DX^2 + DY^2 <= SS then
						NX = ShapeB[j+1][1]
						NY = ShapeB[j+1][2]
						table.insert(RetShape,{NX,NY})
						Count2 = Count2 + 1
						break
					end
				end
			end
		end
	else
		for j = 1, ShapeA[1] do
			for i = 1, ShapeB[1] do
				local NX, NY
				local DX, DY
				DX = math.abs(ShapeB[i+1][1]-ShapeA[j+1][1])
				DY = math.abs(ShapeB[i+1][2]-ShapeA[j+1][2])
				if DX <= Size and DY <= Size then
					if DX^2 + DY^2 <= SS then
						NX = ShapeA[j+1][1]
						NY = ShapeA[j+1][2]
						table.insert(RetShape,{NX,NY})
						Count2 = Count2 + 1
						break
					end
				end
			end
		end
	end
	RetShape[1] = Count2	
	return RetShape	
end

function CS_Subtract(ShapeA,ShapeB,Size)
	if ShapeA == nil then
		CS_InputError()
	end
	if ShapeB == nil then
		CS_InputError()
	end
	if Size == nil then
		Size = 0
	end
	local SS = Size^2
	local RetShape = {0}
	local Count2 = 0

	for j = 1, ShapeA[1] do
		local Check = 0
		for i = 1, ShapeB[1] do
			local NX, NY
			local DX, DY
			DX = math.abs(ShapeB[i+1][1]-ShapeA[j+1][1])
			DY = math.abs(ShapeB[i+1][2]-ShapeA[j+1][2])
			if DX < Size and DY < Size then
				if DX^2 + DY^2 < SS then
					Check = 1
					break
				end
			end
		end
		if Check == 0 then
			NX = ShapeA[j+1][1]
			NY = ShapeA[j+1][2]
			table.insert(RetShape,{NX,NY})
			Count2 = Count2 + 1
		end
	end
	RetShape[1] = Count2	
	return RetShape	
end


function CS_RemoveStack(Shape,Size,Priority)
	if Shape == nil then
		CS_InputError()
	end
	if Size == nil then
		Size = 0
	end
	local SS = Size^2
	if Priority == nil then
		Priority = 0
	elseif Priority ~= 0 then
		Priority = 1
	end
	local RetShape = {0}
	local Count2 = 0
	local ShapeFlag = {0}
	for i = 1, Shape[1] do
		table.insert(ShapeFlag,0)
	end
	if Priority == 0 then
		for j = 1, Shape[1] do
			local Check = 0
			for i = 1, Shape[1] do
				if i ~= j and ShapeFlag[i+1] == 0 then
					local NX, NY
					local DX, DY
					DX = math.abs(Shape[i+1][1]-Shape[j+1][1])
					DY = math.abs(Shape[i+1][2]-Shape[j+1][2])
					if DX < Size and DY < Size then
						if DX^2 + DY^2 < SS then
							Check = 1
							ShapeFlag[j+1] = 1
							break
						end
					end
				end
			end
			if Check == 0 then
				NX = Shape[j+1][1]
				NY = Shape[j+1][2]
				table.insert(RetShape,{NX,NY})
				Count2 = Count2 + 1
			end
		end
	else
		for j = Shape[1], 1, -1 do
			local Check = 0
			for i = Shape[1], 1, -1 do
				if i ~= j and ShapeFlag[i+1] == 0 then
					local NX, NY
					local DX, DY
					DX = math.abs(Shape[i+1][1]-Shape[j+1][1])
					DY = math.abs(Shape[i+1][2]-Shape[j+1][2])
					if DX < Size and DY < Size then
						if DX^2 + DY^2 < SS then
							Check = 1
							ShapeFlag[j+1] = 1
							break
						end
					end
				end
			end
			if Check == 0 then
				NX = Shape[j+1][1]
				NY = Shape[j+1][2]
				table.insert(RetShape,{NX,NY})
				Count2 = Count2 + 1
			end
		end
	end
	RetShape[1] = Count2	
	return RetShape	
end

function CS_Xor(ShapeA,ShapeB,Size)
	if ShapeA == nil then
		CS_InputError()
	end
	if ShapeB == nil then
		CS_InputError()
	end
	if Size == nil then
		Size = 0
	end
	local SS = Size^2
	local RetShape = {0}
	local Count2 = 0

	local ShapeFlagA = {0}
	for i = 1, ShapeA[1] do
		table.insert(ShapeFlagA,0)
	end
	local ShapeFlagB = {0}
	for i = 1, ShapeB[1] do
		table.insert(ShapeFlagB,0)
	end

	for j = 1, ShapeB[1] do
		for i = 1, ShapeA[1] do
			local NX, NY
			local DX, DY
			DX = math.abs(ShapeA[i+1][1]-ShapeB[j+1][1])
			DY = math.abs(ShapeA[i+1][2]-ShapeB[j+1][2])
			if DX <= Size and DY <= Size then
				if DX^2 + DY^2 <= SS then
					ShapeFlagB[j+1] = 1
					ShapeFlagA[i+1] = 1
					break
				end
			end
		end
	end

	for i = 1, ShapeA[1] do
		if ShapeFlagA[i+1] == 0 then
			NX = ShapeA[i+1][1]
			NY = ShapeA[i+1][2]
			table.insert(RetShape,{NX,NY})
			Count2 = Count2 + 1
		end
	end
	for i = 1, ShapeB[1] do
		if ShapeFlagB[i+1] == 0 then
			NX = ShapeB[i+1][1]
			NY = ShapeB[i+1][2]
			table.insert(RetShape,{NX,NY})
			Count2 = Count2 + 1
		end
	end

	RetShape[1] = Count2	
	return RetShape	
end

function CS_CheckStack(Shape,Size,Priority)
	if Shape == nil then
		CS_InputError()
	end
	if Size == nil then
		Size = 0
	end
	local SS = Size^2
	if Priority == nil then
		Priority = 0
	elseif Priority ~= 0 then
		Priority = 1
	end
	local ShapeFlag = {0}
	for i = 1, Shape[1] do
		table.insert(ShapeFlag,0)
	end
	if Priority == 0 then
		for j = 1, Shape[1] do
			local Check = 0
			for i = 1, Shape[1] do
				if i ~= j and ShapeFlag[i+1] == 0 then
					local NX, NY
					local DX, DY
					DX = math.abs(Shape[i+1][1]-Shape[j+1][1])
					DY = math.abs(Shape[i+1][2]-Shape[j+1][2])
					if DX < Size and DY < Size then
						if DX^2 + DY^2 < SS then
							CS_Stack_Detected()
							break
						end
					end
				end
			end
		end
	else
		for j = Shape[1], 1, -1 do
			local Check = 0
			for i = Shape[1], 1, -1 do
				if i ~= j and ShapeFlag[i+1] == 0 then
					local NX, NY
					local DX, DY
					DX = math.abs(Shape[i+1][1]-Shape[j+1][1])
					DY = math.abs(Shape[i+1][2]-Shape[j+1][2])
					if DX < Size and DY < Size then
						if DX^2 + DY^2 < SS then
							CS_Stack_Detected()
							break
						end
					end
				end
			end
		end
	end
end

function CS_CheckCollide(ShapeA,ShapeB,Size,Priority)
	if ShapeA == nil then
		CS_InputError()
	end
	if ShapeB == nil then
		CS_InputError()
	end
	if Size == nil then
		Size = 0
	end
	local SS = Size^2
	if Priority == nil then
		Priority = 0
	elseif Priority ~= 0 then
		Priority = 1
	end

	if Priority == 1 then
		for j = 1, ShapeB[1] do
			for i = 1, ShapeA[1] do
				local NX, NY
				local DX, DY
				DX = math.abs(ShapeA[i+1][1]-ShapeB[j+1][1])
				DY = math.abs(ShapeA[i+1][2]-ShapeB[j+1][2])
				if DX <= Size and DY <= Size then
					if DX^2 + DY^2 <= SS then
						CS_CollideBwithA_Detected()
						break
					end
				end
			end
		end
	else
		for j = 1, ShapeA[1] do
			for i = 1, ShapeB[1] do
				local NX, NY
				local DX, DY
				DX = math.abs(ShapeB[i+1][1]-ShapeA[j+1][1])
				DY = math.abs(ShapeB[i+1][2]-ShapeA[j+1][2])
				if DX <= Size and DY <= Size then
					if DX^2 + DY^2 <= SS then
						CS_CollideAwithB_Detected()
						break
					end
				end
			end
		end
	end
end

function CS_FillXY(Edge,areaX,areaY,sizeX,sizeY)
	if sizeX == nil or sizeY == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 1
	end
	local X1,X2,Y1,Y2,SX,SY,DX,DY,NX,NY,PX,PY
	if areaX == nil then
		CS_InputError()
	elseif type(areaX) == "number" then
		DX = areaX
		X2 = DX/2
		X1 = 0-X2	
	else
		DX = math.abs(areaX[2] - areaX[1])
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if Edge == 0 then
		if DX%sizeX == 0 then
			SX = DX/sizeX
			PX = (sizeX)/2
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	else
		if DX%sizeX == 0 then
			SX = DX/sizeX+1
			PX = 0
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	end
	if areaY == nil then
		CS_InputError()
	elseif type(areaY) == "number" then
		DY = areaY
		Y2 = DY/2
		Y1 = 0-Y2	
	else
		DY = math.abs(areaY[2] - areaY[1])
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	if Edge == 0 then
		if DY%sizeY == 0 then
			SY = DY/sizeY
			PY = (sizeY)/2
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	else
		if DY%sizeY == 0 then
			SY = DY/sizeY+1
			PY = 0
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	end
	local RetShape = {0}
	local Count3 = 0
	NX = PX + X1
	NY = PY + Y1
	for j = 1, SY do
		for i = 1, SX do
			table.insert(RetShape,{NX,NY})
			NX = NX + sizeX
			Count3 = Count3 + 1
		end
		NX = PX + X1
		NY = NY + sizeY
	end
	RetShape[1] = Count3
	return RetShape
end


function CS_FillGradXD(Edge,areaX,areaY,sizeX,funcGX,EdgeY)
	if sizeX == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 1
	end
	if EdgeY == nil then
		EdgeY = 0
	end
	local X1,X2,Y1,Y2,SX,SY,DX,DY,NX,NY,PX,PY
	if areaX == nil then
		CS_InputError()
	elseif type(areaX) == "number" then
		DX = areaX
		X2 = DX/2
		X1 = 0-X2	
	else
		DX = math.abs(areaX[2] - areaX[1])
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if Edge == 0 then
		if DX%sizeX == 0 then
			SX = DX/sizeX
			PX = (sizeX)/2
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	else
		if DX%sizeX == 0 then
			SX = DX/sizeX+1
			PX = 0
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	end
	if areaY == nil then
		CS_InputError()
	elseif type(areaY) == "number" then
		DY = areaY
		Y2 = DY/2
		Y1 = 0-Y2	
	else
		DY = math.abs(areaY[2] - areaY[1])
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	local RetShape = {0}
	local Count3 = 0
	NX = PX + X1
	NY = Y1
	for j = 1, SX do
		if EdgeY == 1 then
			table.insert(RetShape,{math.random(NX,NX+sizeX),Y1})
			Count3 = Count3 + 1
		end
		if EdgeY == 2 then
			table.insert(RetShape,{math.random(NX,NX+sizeX),Y2})
			Count3 = Count3 + 1
		end
		if EdgeY == 3 then
			table.insert(RetShape,{math.random(NX,NX+sizeX),Y1})
			table.insert(RetShape,{math.random(NX,NX+sizeX),Y2})
			Count3 = Count3 + 2
		end
		local CountY = math.floor(_G[funcGX](j))
		local sizeY = DY/(CountY+1)
		if CountY < 0 then CountY = 0 end
		for i = 1, CountY do
			table.insert(RetShape,{math.random(NX,NX+sizeX),math.random(Y1,Y2)})
			Count3 = Count3 + 1
		end
		NX = NX + sizeX
		NY = Y1
	end
	RetShape[1] = Count3
	return RetShape
end

function CS_FillGradX(Edge,areaX,areaY,sizeX,funcGX,EdgeY)
	if sizeX == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 1
	end
	if EdgeY == nil then
		EdgeY = 0
	end
	local X1,X2,Y1,Y2,SX,SY,DX,DY,NX,NY,PX,PY
	if areaX == nil then
		CS_InputError()
	elseif type(areaX) == "number" then
		DX = areaX
		X2 = DX/2
		X1 = 0-X2	
	else
		DX = math.abs(areaX[2] - areaX[1])
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if Edge == 0 then
		if DX%sizeX == 0 then
			SX = DX/sizeX
			PX = (sizeX)/2
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	else
		if DX%sizeX == 0 then
			SX = DX/sizeX+1
			PX = 0
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	end
	if areaY == nil then
		CS_InputError()
	elseif type(areaY) == "number" then
		DY = areaY
		Y2 = DY/2
		Y1 = 0-Y2	
	else
		DY = math.abs(areaY[2] - areaY[1])
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	local RetShape = {0}
	local Count3 = 0
	NX = PX + X1
	NY = Y1
	for j = 1, SX do
		if EdgeY == 1 then
			table.insert(RetShape,{NX,Y1})
			Count3 = Count3 + 1
		end
		if EdgeY == 2 then
			table.insert(RetShape,{NX,Y2})
			Count3 = Count3 + 1
		end
		if EdgeY == 3 then
			table.insert(RetShape,{NX,Y1})
			table.insert(RetShape,{NX,Y2})
			Count3 = Count3 + 2
		end
		local CountY = math.floor(_G[funcGX](j))
		local sizeY = DY/(CountY+1)
		if CountY < 0 then CountY = 0 end
		for i = 1, CountY do
			NY = NY + sizeY
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		NX = NX + sizeX
		NY = Y1
	end
	RetShape[1] = Count3
	return RetShape
end

function CS_FillGradY(Edge,areaX,areaY,sizeY,funcGY,EdgeX)
	if sizeY == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 1
	end
	if EdgeX == nil then
		EdgeX = 0
	end
	local Y1,Y2,X1,X2,SY,SX,DY,DX,NY,NX,PY,PX
	if areaY == nil then
		CS_InputError()
	elseif type(areaY) == "number" then
		DY = areaY
		Y2 = DY/2
		Y1 = 0-Y2	
	else
		DY = math.abs(areaY[2] - areaY[1])
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	if Edge == 0 then
		if DY%sizeY == 0 then
			SY = DY/sizeY
			PY = (sizeY)/2
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	else
		if DY%sizeY == 0 then
			SY = DY/sizeY+1
			PY = 0
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	end
	if areaX == nil then
		CS_InputError()
	elseif type(areaX) == "number" then
		DX = areaX
		X2 = DX/2
		X1 = 0-X2	
	else
		DX = math.abs(areaX[2] - areaX[1])
		X1 = areaX[1]
		X2 = areaX[2]
	end
	local RetShape = {0}
	local Count3 = 0
	NY = PY + Y1
	NX = X1
	for j = 1, SY do
		if EdgeX == 1 then
			table.insert(RetShape,{X1,NY})
			Count3 = Count3 + 1
		end
		if EdgeX == 2 then
			table.insert(RetShape,{X2,NY})
			Count3 = Count3 + 1
		end
		if EdgeX == 3 then
			table.insert(RetShape,{X1,NY})
			table.insert(RetShape,{X2,NY})
			Count3 = Count3 + 2
		end
		local CountX = math.floor(_G[funcGY](j))
		local sizeX = DX/(CountX+1)
		if CountX < 0 then CountX = 0 end
		for i = 1, CountX do
			NX = NX + sizeX
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		NY = NY + sizeY
		NX = X1
	end
	RetShape[1] = Count3
	return RetShape
end

function CS_FillGradR(Edge,areaR,areaA,sizeR,funcGR,EdgeA)
	if sizeR == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 1
	end
	if EdgeA == nil then
		EdgeA = 0
	end
	local R1,R2,A1,A2,SR,SA,DR,DA,NR,NA,PR,PA
	if areaR == nil then
		CS_InputError()
	elseif type(areaR) == "number" then
		DR = areaR
		R2 = DR/2
		R1 = 0-R2	
	else
		DR = math.abs(areaR[2] - areaR[1])
		R1 = areaR[1]
		R2 = areaR[2]
	end
	if Edge == 0 then
		if DR%sizeR == 0 then
			SR = DR/sizeR
			PR = (sizeR)/2
		else
			SR = DR/sizeR+1
			PR = (DR%sizeR)/2
		end
	else
		if DR%sizeR == 0 then
			SR = DR/sizeR+1
			PR = 0
		else
			SR = DR/sizeR+1
			PR = (DR%sizeR)/2
		end
	end
	if areaA == nil then
		CS_InputError()
	elseif type(areaA) == "number" then
		DA = math.rad(areaA)
		A2 = DA
		A1 = 0	
	else
		DA = math.rad(math.abs(areaA[2] - areaA[1]))
		A1 = math.rad(areaA[1])
		A2 = math.rad(areaA[2])
	end
	local RetShape = {0}
	local Count3 = 0
	NR = PR + R1
	NA = A1
	for j = 1, SR do
		if EdgeA == 1 then
			NX = NR*math.cos(A1)
			NY = NR*math.sin(A1)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		if EdgeA == 2 then
			NX = NR*math.cos(A2)
			NY = NR*math.sin(A2)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		if EdgeA == 3 then
			NX = NR*math.cos(A1)
			NY = NR*math.sin(A1)
			table.insert(RetShape,{NX,NY})
			NX = NR*math.cos(A2)
			NY = NR*math.sin(A2)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 2
		end
		local CountA = math.floor(_G[funcGR](j))
		local sizeA = DA/(CountA+1)
		if CountA < 0 then CountA = 0 end
		for i = 1, CountA do
			NA = NA + sizeA
			NX = NR*math.cos(NA)
			NY = NR*math.sin(NA)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		NR = NR + sizeR
		NA = A1
	end
	RetShape[1] = Count3
	return RetShape
end

function CS_FillGradA(Edge,areaR,areaA,sizeA,funcGA,EdgeR)
	if sizeA == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 1
	end
	if EdgeR == nil then
		EdgeR = 0
	end
	local A1,A2,R1,R2,SA,SR,DA,DR,NA,NR,PA,PR
	if areaA == nil then
		CS_InputError()
	elseif type(areaA) == "number" then
		DA = math.rad(areaA)
		A2 = DA
		A1 = 0	
	else
		DA = math.rad(math.abs(areaA[2] - areaA[1]))
		A1 = math.rad(areaA[1])
		A2 = math.rad(areaA[2])
	end
	sizeA = math.rad(sizeA)
	if Edge == 0 then
		if DA%sizeA == 0 then
			SA = DA/sizeA
			PA = (sizeA)/2
		else
			SA = DA/sizeA+1
			PA = (DA%sizeA)/2
		end
	else
		if DA%sizeA == 0 then
			SA = DA/sizeA+1
			PA = 0
		else
			SA = DA/sizeA+1
			PA = (DA%sizeA)/2
		end
	end
	if areaR == nil then
		CS_InputError()
	elseif type(areaR) == "number" then
		DR = areaR
		R2 = DR/2
		R1 = 0-R2	
	else
		DR = math.abs(areaR[2] - areaR[1])
		R1 = areaR[1]
		R2 = areaR[2]
	end
	local RetShape = {0}
	local Count3 = 0
	NA = PA + A1
	NR = R1
	for j = 1, SA do
		if EdgeR == 1 then
			NX = R1*math.cos(NA)
			NY = R1*math.sin(NA)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		if EdgeR == 2 then
			NX = R2*math.cos(NA)
			NY = R2*math.sin(NA)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		if EdgeR == 3 then
			NX = R1*math.cos(NA)
			NY = R1*math.sin(NA)
			table.insert(RetShape,{NX,NY})
			NX = R2*math.cos(NA)
			NY = R2*math.sin(NA)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 2
		end
		local CountR = math.floor(_G[funcGA](j))
		local sizeR = DR/(CountR+1)
		if CountR < 0 then CountR = 0 end
		for i = 1, CountR do
			NR = NR + sizeR
			NX = NR*math.cos(NA)
			NY = NR*math.sin(NA)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
		end
		NA = NA + sizeA
		NR = R1
	end
	RetShape[1] = Count3
	return RetShape
end


function CS_FillRA(Edge,areaR,areaA,sizeR,sizeA)
	if Edge == nil then
		Edge = 1
	end
	if sizeR == nil or sizeA == nil then
		CS_InputError()
	end
	local R1,R2,A1,A2,SR,SA,DR,DA,NR,NA,PR,PA,NX,NY
	if areaR == nil then
		CS_InputError()
	elseif type(areaR) == "number" then
		DR = areaR
		R2 = DR
		R1 = 0	
	else
		DR = math.abs(areaR[2] - areaR[1])
		R1 = areaR[1]
		R2 = areaR[2]
	end
	if Edge == 0 then
		if DR%sizeR == 0 then
			SR = DR/sizeR
			PR = (sizeR)/2
		else
			SR = DR/sizeR+1
			PR = (DR%sizeR)/2
		end
	else
		if DR%sizeR == 0 then
			SR = DR/sizeR+1
			PR = 0
		else
			SR = DR/sizeR+1
			PR = (DR%sizeR)/2
		end
	end
	if areaA == nil then
		CS_InputError()
	elseif type(areaA) == "number" then
		DA = math.rad(areaA)
		A2 = DA
		A1 = 0	
	else
		DA = math.rad(math.abs(areaA[2] - areaA[1]))
		A1 = math.rad(areaA[1])
		A2 = math.rad(areaA[2])
	end
	sizeA = math.rad(sizeA)
	if Edge == 0 then
		if DA%sizeA == 0 then
			SA = DA/sizeA
			PA = (sizeA)/2
		else
			SA = DA/sizeA+1
			PA = (DA%sizeA)/2
		end
	else
		if DA%sizeA == 0 then
			SA = DA/sizeA+1
			PA = 0
		else
			SA = DA/sizeA+1
			PA = (DA%sizeA)/2
		end
	end

	local RetShape = {0}
	local Count3 = 0
	NR = PR + R1
	NA = PA + A1
	for j = 1, SA do
		for i = 1, SR do
			NX = NR*math.cos(NA)
			NY = NR*math.sin(NA)
			table.insert(RetShape,{NX,NY})
			Count3 = Count3 + 1
			NR = NR + sizeR
		end
		NR = PR + R1
		NA = NA + sizeA
	end
	RetShape[1] = Count3
	return RetShape
end

function CS_FillHX(Edge,areaX,areaY,sizeX,sizeY,Direction)
	if Edge == nil then
		Edge = 1
	end
	if Direction == nil then
		Direction = 0
	elseif Direction < 0 or Direction > 3 then
		CS_InputError()
	end
	if sizeX == nil or sizeY == nil then
		CS_InputError()
	end
	local X1,X2,Y1,Y2,SX,SY,DX,DY,NX,NY,PX,PY
	if areaX == nil then
		CS_InputError()
	elseif type(areaX) == "number" then
		DX = areaX
		X2 = DX/2
		X1 = 0-X2	
	else
		DX = math.abs(areaX[2] - areaX[1])
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if Edge == 0 then
		if DX%sizeX == 0 then
			SX = DX/sizeX
			PX = (sizeX)/2
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	else
		if DX%sizeX == 0 then
			SX = DX/sizeX+1
			PX = 0
		else
			SX = DX/sizeX+1
			PX = (DX%sizeX)/2
		end
	end
	if areaY == nil then
		CS_InputError()
	elseif type(areaY) == "number" then
		DY = areaY
		Y2 = DY/2
		Y1 = 0-Y2	
	else
		DY = math.abs(areaY[2] - areaY[1])
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	if Edge == 0 then
		if DY%sizeY == 0 then
			SY = DY/sizeY
			PY = (sizeY)/2
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	else
		if DY%sizeY == 0 then
			SY = DY/sizeY+1
			PY = 0
		else
			SY = DY/sizeY+1
			PY = (DY%sizeY)/2
		end
	end

	local RetShape = {0}
	local Count = 0
	local Check = 0
	if Direction == 0 then
		NX = PX + X1
		NY = PY + Y1
		for j = 1, SY do
			if Check == 0 then
				for i = 1, SX do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NX = NX + sizeX
				end
				NX = PX + X1 - sizeX/2
				Check = 1
			else
				for i = 1, SX+1 do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NX = NX + sizeX
				end
				NX = PX + X1 
				Check = 0
			end
			NY = NY + sizeY
		end
	elseif Direction == 1 then
		NX = PX + X1 - sizeX/2
		NY = PY + Y1
		for j = 1, SY do
			if Check == 0 then
				for i = 1, SX+1 do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NX = NX + sizeX
				end
				NX = PX + X1 
				Check = 1
			else
				for i = 1, SX do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NX = NX + sizeX
				end
				NX = PX + X1 - sizeX/2
				Check = 0
			end
			NY = NY + sizeY
		end
	elseif Direction == 2 then
		NX = PX + X1
		NY = PY + Y1 
		for j = 1, SX do
			if Check == 0 then
				for i = 1, SY do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NY = NY + sizeY
				end
				NY = PY + Y1 - sizeY/2
				Check = 1
			else
				for i = 1, SY+1 do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NY = NY + sizeY
				end
				NY = PY + Y1
				Check = 0
			end
			NX = NX + sizeX
		end
	elseif Direction == 3 then
		NX = PX + X1
		NY = PY + Y1 - sizeY/2
		for j = 1, SX do
			if Check == 0 then
				for i = 1, SY+1 do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NY = NY + sizeY
				end
				NY = PY + Y1
				Check = 1
			else
				for i = 1, SY do
					table.insert(RetShape,{NX,NY})
					Count = Count + 1
					NY = NY + sizeY
				end
				NY = PY + Y1 - sizeY/2
				Check = 0
			end
			NX = NX + sizeX
		end
	end
	RetShape[1] = Count
	return RetShape
end

function CS_CheckPath(Shape,Path,Outside)
	if Shape == nil then
		CS_InputError()
	end
	if Path == nil then
		CS_InputError()
	end
	if Outside == nil then
		Outside = 0
	end

	local Domain = {}
	for i = 1, Path[1] do
		table.insert(Domain,{0,0,0,0}) 
		if i < Path[1] then
			if Path[i+1][1] <= Path[i+2][1] then
				Domain[i][1] = Path[i+1][1]
				Domain[i][2] = Path[i+2][1]
			else
				Domain[i][2] = Path[i+1][1]
				Domain[i][1] = Path[i+2][1]
			end
			if Path[i+1][2] <= Path[i+2][2] then
				Domain[i][3] = Path[i+1][2]
				Domain[i][4] = Path[i+2][2]
			else
				Domain[i][4] = Path[i+1][2]
				Domain[i][3] = Path[i+2][2]
			end
		else
			if Path[i+1][1] <= Path[2][1] then
				Domain[i][1] = Path[i+1][1]
				Domain[i][2] = Path[2][1]
			else
				Domain[i][2] = Path[i+1][1]
				Domain[i][1] = Path[2][1]
			end
			if Path[i+1][2] <= Path[2][2] then
				Domain[i][3] = Path[i+1][2]
				Domain[i][4] = Path[2][2]
			else
				Domain[i][4] = Path[i+1][2]
				Domain[i][3] = Path[2][2]
			end
		end
	end

	local GA = {}
	local GB = {}
	for i = 1, Path[1]  do
		if Domain[i][1] == Domain[i][2] then
			GA[i] = "X"
			GB[i] = Domain[i][1]
		else
			if i < Path[1] then
				GA[i] = (Path[i+2][2] - Path[i+1][2])/(Path[i+2][1] - Path[i+1][1])
				GB[i] = Path[i+1][2] - GA[i]*Path[i+1][1]
			else
				GA[i] = (Path[2][2] - Path[i+1][2])/(Path[2][1] - Path[i+1][1])
				GB[i] = Path[i+1][2] - GA[i]*Path[i+1][1]
			end
		end
	end

	local Ret = {} -- in = 2 / edge = 1 / out = 0
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		for j = 1, Path[1] do
			if GA[j] == "X" then
				if NX == GB[j] and NY>=Domain[j][3] and NY<=Domain[j][4] then
					table.insert(Ret,1)
					goto CS_CheckPathNext 
				end
			else
				if NY == NX*GA[j]+GB[j] and NX>=Domain[j][1] and NX<=Domain[j][2] then
					table.insert(Ret,1)
					goto CS_CheckPathNext 
				end
			end
		end
		local k = 0.00001
		local l = NY-k*NX 
		local Count = 0
		local Check = 0
		for j = 1, Path[1] do
			::CS_CheckPathReset1::
			if Check == 1 then
				k = math.random(1,99999)+math.random(1,99999)/100000
				l = NY-k*NX 
			end
			if GA[j] == k then
				if GB[j] == l then -- 일치
					Check = 1
					goto CS_CheckPathReset1
				end
			else -- 교점 1개
				if GA[j] == "X" then
					local RY = k*GB[j]+l
					if GB[j] >= NX and RY >= Domain[j][3] and RY <= Domain[j][4] then
						Count = Count + 1
					end
				else
					local RX = (GB[j]-l)/(k-GA[j])
					if RX >= NX and RX >= Domain[j][1] and RX <= Domain[j][2] then
						Count = Count + 1
					end
				end
			end
		end
		if Count%2 == 0 then
			table.insert(Ret,0)
		else
			table.insert(Ret,2)
		end
		::CS_CheckPathNext::
	end

	for i = 1, Shape[1] do
		if Outside == 0 then
			if Ret[i] > 0  then
				CS_InsideArea_Detected()
			end
		else
			if Ret[i] == 0  then
				CS_OutsideArea_Detected()
			end
		end
	end
end

function CS_CropPath(Shape,Path,Outside)
	if Shape == nil then
		CS_InputError()
	end
	if Path == nil then
		CS_InputError()
	end
	if Outside == nil then
		Outside = 0
	end

	local Domain = {}
	for i = 1, Path[1] do
		table.insert(Domain,{0,0,0,0}) 
		if i < Path[1] then
			if Path[i+1][1] <= Path[i+2][1] then
				Domain[i][1] = Path[i+1][1]
				Domain[i][2] = Path[i+2][1]
			else
				Domain[i][2] = Path[i+1][1]
				Domain[i][1] = Path[i+2][1]
			end
			if Path[i+1][2] <= Path[i+2][2] then
				Domain[i][3] = Path[i+1][2]
				Domain[i][4] = Path[i+2][2]
			else
				Domain[i][4] = Path[i+1][2]
				Domain[i][3] = Path[i+2][2]
			end
		else
			if Path[i+1][1] <= Path[2][1] then
				Domain[i][1] = Path[i+1][1]
				Domain[i][2] = Path[2][1]
			else
				Domain[i][2] = Path[i+1][1]
				Domain[i][1] = Path[2][1]
			end
			if Path[i+1][2] <= Path[2][2] then
				Domain[i][3] = Path[i+1][2]
				Domain[i][4] = Path[2][2]
			else
				Domain[i][4] = Path[i+1][2]
				Domain[i][3] = Path[2][2]
			end
		end
	end

	local GA = {}
	local GB = {}
	for i = 1, Path[1]  do
		if Domain[i][1] == Domain[i][2] then
			GA[i] = "X"
			GB[i] = Domain[i][1]
		else
			if i < Path[1] then
				GA[i] = (Path[i+2][2] - Path[i+1][2])/(Path[i+2][1] - Path[i+1][1])
				GB[i] = Path[i+1][2] - GA[i]*Path[i+1][1]
			else
				GA[i] = (Path[2][2] - Path[i+1][2])/(Path[2][1] - Path[i+1][1])
				GB[i] = Path[i+1][2] - GA[i]*Path[i+1][1]
			end
		end
	end

	local Ret = {} -- in = 2 / edge = 1 / out = 0
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		for j = 1, Path[1] do
			if GA[j] == "X" then
				if NX == GB[j] and NY>=Domain[j][3] and NY<=Domain[j][4] then
					table.insert(Ret,1)
					goto CS_CheckPathNext 
				end
			else
				if NY == NX*GA[j]+GB[j] and NX>=Domain[j][1] and NX<=Domain[j][2] then
					table.insert(Ret,1)
					goto CS_CheckPathNext 
				end
			end
		end
		local k = 0.00001
		local l = NY-k*NX 
		local Count = 0
		local Check = 0
		for j = 1, Path[1] do
			::CS_CheckPathReset1::
			if Check == 1 then
				k = math.random(1,99999)+math.random(1,99999)/100000
				l = NY-k*NX 
			end
			if GA[j] == k then
				if GB[j] == l then -- 일치
					Check = 1
					goto CS_CheckPathReset1
				end
			else -- 교점 1개
				if GA[j] == "X" then
					local RY = k*GB[j]+l
					if GB[j] >= NX and RY >= Domain[j][3] and RY <= Domain[j][4] then
						Count = Count + 1
					end
				else
					local RX = (GB[j]-l)/(k-GA[j])
					if RX >= NX and RX >= Domain[j][1] and RX <= Domain[j][2] then
						Count = Count + 1
					end
				end
			end
		end
		if Count%2 == 0 then
			table.insert(Ret,0)
		else
			table.insert(Ret,2)
		end
		::CS_CheckPathNext::
	end
	local RetShape = {0}
	local Count2 = 0
	for i = 1, Shape[1] do
		if Outside == 0 then
			if Ret[i] > 0  then
				table.insert(RetShape,{Shape[i+1][1],Shape[i+1][2]})
				Count2 = Count2 + 1
			end
		else
			if Ret[i] == 0  then
				table.insert(RetShape,{Shape[i+1][1],Shape[i+1][2]})
				Count2 = Count2 + 1
			end
		end
	end
	RetShape[1] = Count2
	return RetShape
end

-- function SnowFlake_Vector(X,Y) return {-Y,X} end 
function CS_Vector2D(Shape,Ratio,VectorFunc)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, PX, PY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local Ret = _G[VectorFunc](NX/XRatio,NY/YRatio)
		PX = Ret[1]
		PY = Ret[2]
		table.insert(RetShape,{PX*XRatio,PY*YRatio})
	end
	return RetShape
end

-- function SnowFlake_VectorPolar(R,A) return {-A,R} end 
function CS_Vector2DPolar(Shape,Ratio,VectorFunc)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, PX, PY, NR, NA
		NX = Shape[i+1][1]/XRatio
		NY = Shape[i+1][2]/YRatio
		
		NR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			NA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			NA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			NA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			NA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		local Ret = _G[VectorFunc](NR,NA)
		PR = Ret[1]
		PA = Ret[2]

		NX = PR*math.cos(PA)
		NY = PR*math.sin(PA)	
		table.insert(RetShape,{NX*XRatio,NY*YRatio})
	end
	return RetShape
end

function CS_FillPathXY(Path,Edge,sizeX,sizeY,Outside)
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end
	return CS_CropPath(CS_FillXY(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeX,sizeY),Path,Outside)
end

function CS_FillPathXY2(Path,Edge,sizeX,sizeY,Outside,Angle,Digit)
	local dA
	if Angle ~= nil then
		if Digit == nil then
			Digit = 3
		end
		Path = CS_Round(CS_Rotate(Path,-Angle),Digit)
		dA = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end
	local Ret = CS_CropPath(CS_FillXY(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeX,sizeY),Path,Outside)
	if dA ~= nil then
		Ret = CS_Rotate(Ret,Angle)
	end
	return Ret
end

function CS_FillPathGradXD(Path,Edge,sizeX,funcGX,EdgeY,Outside,Angle,Digit)
	local dA
	if Angle ~= nil then
		if Digit == nil then
			Digit = 3
		end
		Path = CS_Round(CS_Rotate(Path,-Angle),Digit)
		dA = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end

	local Ret = CS_CropPath(CS_FillGradXD(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeX,funcGX,EdgeY),Path,Outside)
	if dA ~= nil then
		Ret = CS_Rotate(Ret,Angle)
	end
	return Ret
end


function CS_FillPathGradX(Path,Edge,sizeX,funcGX,EdgeY,Outside,Angle,Digit)
	local dA
	if Angle ~= nil then
		if Digit == nil then
			Digit = 3
		end
		Path = CS_Round(CS_Rotate(Path,-Angle),Digit)
		dA = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end
	
	local Ret = CS_CropPath(CS_FillGradX(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeX,funcGX,EdgeY),Path,Outside)
	if dA ~= nil then
		Ret = CS_Rotate(Ret,Angle)
	end
	return Ret
end

function CS_FillPathGradY(Path,Edge,sizeY,funcGY,EdgeX,Outside,Angle,Digit)
	local dA
	if Angle ~= nil then
		if Digit == nil then
			Digit = 3
		end
		Path = CS_Round(CS_Rotate(Path,-Angle),Digit)
		dA = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end
	
	local Ret = CS_CropPath(CS_FillGradY(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeY,funcGY,EdgeX),Path,Outside)
	if dA ~= nil then
		Ret = CS_Rotate(Ret,Angle)
	end
	return Ret
end

function CS_FillPathGradR(Path,Edge,sizeR,funcGR,EdgeA,Rmin,Outside,dX,dY)
	local dXY
	if dX ~= nil or dY ~= nil then
		if dX == nil then
			dX = 0
		end
		if dY == nil then
			dY = 0
		end
		Path = CS_MoveXY(Path,-dX,-dY)
		dXY = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local PathRA = {Path[1]}
	for i = 1, Path[1] do
		local MX, MY
		MX = Path[i+1][1]
		MY = Path[i+1][2]
		local PR

		PR = math.sqrt(MX^2+MY^2)
		table.insert(PathRA,{PR})
	end
	local Rmax,RminX
	RminX = PathRA[2][1]
	Rmax = PathRA[2][1]
	for i = 1, PathRA[1] do
		if PathRA[i+1][1] > Rmax then
			Rmax = PathRA[i+1][1]
		end
	end
	if Rmin == nil then
		for i = 1, PathRA[1] do
			if PathRA[i+1][1] < RminX then
				RminX = PathRA[i+1][1]
			end
		end
		Rmin = RminX
	end
	local Ret = CS_CropPath(CS_FillGradR(Edge,{Rmin,Rmax},{0,360},sizeR,funcGR,EdgeA),Path,Outside)
	if dXY ~= nil then
		Ret = CS_MoveXY(Ret,dX,dY)
	end
	return Ret 
end

function CS_FillPathGradA(Path,Edge,sizeA,funcGA,EdgeR,Rmin,Outside,dX,dY)
	local dXY
	if dX ~= nil or dY ~= nil then
		if dX == nil then
			dX = 0
		end
		if dY == nil then
			dY = 0
		end
		Path = CS_MoveXY(Path,-dX,-dY)
		dXY = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local PathRA = {Path[1]}
	for i = 1, Path[1] do
		local MX, MY
		MX = Path[i+1][1]
		MY = Path[i+1][2]
		local PR

		PR = math.sqrt(MX^2+MY^2)
		table.insert(PathRA,{PR})
	end
	local Rmax,RminX
	RminX = PathRA[2][1]
	Rmax = PathRA[2][1]
	for i = 1, PathRA[1] do
		if PathRA[i+1][1] > Rmax then
			Rmax = PathRA[i+1][1]
		end
	end
	if Rmin == nil then
		for i = 1, PathRA[1] do
			if PathRA[i+1][1] < RminX then
				RminX = PathRA[i+1][1]
			end
		end
		Rmin = RminX
	end
	local Ret = CS_CropPath(CS_FillGradA(Edge,{Rmin,Rmax},{0,360},sizeA,funcGA,EdgeR),Path,Outside)
	if dXY ~= nil then
		Ret = CS_MoveXY(Ret,dX,dY)
	end
	return Ret 
end

function CS_FillPathRA(Path,Edge,sizeR,sizeA,Outside)
	if Path == nil then
		CS_InputError()
	end
	local PathRA = {Path[1]}
	for i = 1, Path[1] do
		local MX, MY
		MX = Path[i+1][1]
		MY = Path[i+1][2]
		local PR

		PR = math.sqrt(MX^2+MY^2)
		table.insert(PathRA,{PR})
	end
	local Rmax,Rmin
	Rmin = PathRA[2][1]
	Rmax = PathRA[2][1]
	for i = 1, PathRA[1] do
		if PathRA[i+1][1] > Rmax then
			Rmax = PathRA[i+1][1]
		end
		if PathRA[i+1][1] < Rmin then
			Rmin = PathRA[i+1][1]
		end
	end
	return CS_CropPath(CS_FillRA(Edge,{Rmin,Rmax},{0,360},sizeR,sizeA),Path,Outside)
end

function CS_FillPathRA2(Path,Edge,sizeR,sizeA,Rmin,Outside,dX,dY)
	local dXY
	if dX ~= nil or dY ~= nil then
		if dX == nil then
			dX = 0
		end
		if dY == nil then
			dY = 0
		end
		Path = CS_MoveXY(Path,-dX,-dY)
		dXY = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local PathRA = {Path[1]}
	for i = 1, Path[1] do
		local MX, MY
		MX = Path[i+1][1]
		MY = Path[i+1][2]
		local PR

		PR = math.sqrt(MX^2+MY^2)
		table.insert(PathRA,{PR})
	end
	local Rmax,RminX
	RminX = PathRA[2][1]
	Rmax = PathRA[2][1]
	for i = 1, PathRA[1] do
		if PathRA[i+1][1] > Rmax then
			Rmax = PathRA[i+1][1]
		end
	end
	if Rmin == nil then
		for i = 1, PathRA[1] do
			if PathRA[i+1][1] < RminX then
				RminX = PathRA[i+1][1]
			end
		end
		Rmin = RminX
	end
	local Ret = CS_CropPath(CS_FillRA(Edge,{Rmin,Rmax},{0,360},sizeR,sizeA),Path,Outside)
	if dXY ~= nil then
		Ret = CS_MoveXY(Ret,dX,dY)
	end
	return Ret 
end

function CS_FillPathHX(Path,Edge,sizeX,sizeY,Direction,Outside)
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end
	return CS_CropPath(CS_FillHX(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeX,sizeY,Direction),Path,Outside)
end

function CS_FillPathHX2(Path,Edge,sizeX,sizeY,Direction,Outside,Angle,Digit)
	local dA
	if Angle ~= nil then
		if Digit == nil then
			Digit = 3
		end
		Path = CS_Round(CS_Rotate(Path,-Angle),Digit)
		dA = 0
	end
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end
	local Ret = CS_CropPath(CS_FillHX(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeX,sizeY,Direction),Path,Outside)
	if dA ~= nil then
		Ret = CS_Rotate(Ret,Angle)
	end
	return Ret
end

function CS_FillPathRD(Path,Edge,sizeX,sizeY,StackSizeX,StackSizeY,Outside)
	if Path == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin
	Xmin = Path[2][1]
	Xmax = Path[2][1]
	Ymin = Path[2][2]
	Ymax = Path[2][2]
	for i = 1, Path[1] do
		if Path[i+1][1] > Xmax then
			Xmax = Path[i+1][1]
		end
		if Path[i+1][1] < Xmin then
			Xmin = Path[i+1][1]
		end
		if Path[i+1][2] > Ymax then
			Ymax = Path[i+1][2]
		end
		if Path[i+1][2] < Ymin then
			Ymin = Path[i+1][2]
		end
	end
	return CS_CropPath(CS_FillRD(Edge,{Xmin,Xmax},{Ymin,Ymax},sizeX,sizeY,StackSizeX,StackSizeY),Path,Outside)
end

function CS_CropGraphXY(Shape,Ratio,funcXY,Sign,Edge)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if Shape == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 0 -- = 포함
	end
	if Sign == nil then
		Sign = 0 -- 0 : > / 1: <
	end
	local RetShape = {0}
	local Count = 0
	for i = 1, Shape[1] do
		local NX, NY, Temp
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		Temp = _G[funcXY](NX/XRatio,NY/YRatio)
		local Check = 0
		if Edge == 0 then
			if Temp>=0 and Sign==0 then
				Check = 1
			end
			if Temp<=0 and Sign==1 then
				Check = 1
			end
		else
			if Temp>0 and Sign==0 then 
				Check = 1
			end
			if Temp<0 and Sign==1 then
				Check = 1
			end
		end
		if Check == 1 then
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	RetShape[1] = Count
	return RetShape	
end

function CS_CropGraphRA(Shape,Ratio,funcRA,Sign,Edge)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = 1
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if Shape == nil then
		CS_InputError()
	end
	if Edge == nil then
		Edge = 0 -- = 포함
	end
	if Sign == nil then
		Sign = 0 -- 0 : > / 1: <
	end
	local RetShape = {0}
	local Count = 0
	for i = 1, Shape[1] do
		local NX, NY, Temp, NR, NA
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		NR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			NA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			NA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			NA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			NA = 2*math.pi - math.abs(math.atan(NY/NX))
		end
		Temp = _G[funcRA](NR/XRatio,NA/YRatio)
		local Check = 0
		if Edge == 0 then
			if Temp>=0 and Sign==0 then
				Check = 1
			end
			if Temp<=0 and Sign==1 then
				Check = 1
			end
		else
			if Temp>0 and Sign==0 then 
				Check = 1
			end
			if Temp<0 and Sign==1 then
				Check = 1
			end
		end
		if Check == 1 then
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	RetShape[1] = Count
	return RetShape	
end

function CS_Round(Shape,Digit)
	if Shape == nil then
		CS_InputError()
	end
	local N = 10^Digit
	for i = 1, Shape[1] do
		Shape[i+1][1] = math.floor(Shape[i+1][1]*N+0.5)/N
		Shape[i+1][2] = math.floor(Shape[i+1][2]*N+0.5)/N
	end
	return Shape
end

function CS_GetXmax(Shape)
	if Shape == nil then
		CS_InputError()
	end
	local Xmax = Shape[2][1]
	for i = 1, Shape[1] do
		if Shape[i+1][1] > Xmax then
			Xmax = Shape[i+1][1]
		end
	end
	return Xmax
end

function CS_GetXmin(Shape)
	if Shape == nil then
		CS_InputError()
	end
	local Xmin = Shape[2][1]
	for i = 1, Shape[1] do
		if Shape[i+1][1] < Xmin then
			Xmin = Shape[i+1][1]
		end
	end
	return Xmin
end

function CS_GetYmax(Shape)
	if Shape == nil then
		CS_InputError()
	end
	local Ymax = Shape[2][2]
	for i = 1, Shape[1] do
		if Shape[i+1][2] > Ymax then
			Ymax = Shape[i+1][2]
		end
	end
	return Ymax
end

function CS_GetYmin(Shape)
	if Shape == nil then
		CS_InputError()
	end
	local Ymin = Shape[2][2]
	for i = 1, Shape[1] do
		if Shape[i+1][2] < Ymin then
			Ymin = Shape[i+1][2]
		end
	end
	return Ymin
end

function CS_GetXCntr(Shape)
	return (CS_GetXmax(Shape)+CS_GetXmin(Shape))/2
end

function CS_GetYCntr(Shape)
	return (CS_GetYmax(Shape)+CS_GetYmin(Shape))/2
end

function CS_GetRCntr(Shape,Zero)
	local Ret
	if Zero == nil or Zero == 0 then
		Ret = (CS_GetRmax(Shape)+CS_GetRmin(Shape))/2
	else
		Ret = CS_GetRmax(Shape)/2
	end
	return Ret
end

function CS_MoveCenter(Shape,X,Y)
	if Shape == nil then
		CS_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin,XCntr,YCntr,dx,dy
	Xmin = Shape[2][1]
	Xmax = Shape[2][1]
	Ymin = Shape[2][2]
	Ymax = Shape[2][2]
	for i = 1, Shape[1] do
		if Shape[i+1][1] > Xmax then
			Xmax = Shape[i+1][1]
		end
		if Shape[i+1][1] < Xmin then
			Xmin = Shape[i+1][1]
		end
		if Shape[i+1][2] > Ymax then
			Ymax = Shape[i+1][2]
		end
		if Shape[i+1][2] < Ymin then
			Ymin = Shape[i+1][2]
		end
	end
	XCntr = (Xmax+Xmin)/2
	YCntr = (Ymax+Ymin)/2
	dx = X - XCntr
	dy = Y - YCntr
	local RetShape = CS_MoveXY(Shape,dx,dy)
	return RetShape
end

function CS_Distortion(Shape,mulLU,mulLD,mulRU,mulRD,CenterXY)
	local Xmax,Xmin,Ymax,Ymin,XCntr,YCntr
	Xmin = Shape[2][1]
	Xmax = Shape[2][1]
	Ymin = Shape[2][2]
	Ymax = Shape[2][2]
	for i = 1, Shape[1] do
		if Shape[i+1][1] > Xmax then
			Xmax = Shape[i+1][1]
		end
		if Shape[i+1][1] < Xmin then
			Xmin = Shape[i+1][1]
		end
		if Shape[i+1][2] > Ymax then
			Ymax = Shape[i+1][2]
		end
		if Shape[i+1][2] < Ymin then
			Ymin = Shape[i+1][2]
		end
	end
	XCntr = (Xmax+Xmin)/2
	YCntr = (Ymax+Ymin)/2
	local CX, CY, dx, dy
	if CenterXY ~= nil then
		if type(CenterXY) == "number" then
			CS_InputError()
		end
		CX = CenterXY[1]
		CY = CenterXY[2]
		dx = CX-XCntr
		dy = CY-YCntr
		Xmin = Xmin + dx
		Xmax = Xmax + dx
		Ymin = Ymin + dy
		Ymax = Ymax + dy
		XCntr = CX
		YCntr = CY		
	end

	local XLU,YLU,XRU,YRU,XRD,YRD,XLD,RLD
	if type(mulLU) == "number" then
		CS_InputError()
	elseif mulLU == nil then
		XLU = 1
		YLU = 1
	else
		if mulLU[1] == nil then
			XLU = 1
		else
			XLU = mulLU[1]
		end
		if mulLU[2] == nil then
			YLU = 1
		else
			YLU = mulLU[2]
		end
	end
	if type(mulLD) == "number" then
		CS_InputError()
	elseif mulLD == nil then
		XLD = 1
		YLD = 1
	else
		if mulLD[1] == nil then
			XLD = 1
		else
			XLD = mulLD[1]
		end
		if mulLD[2] == nil then
			YLD = 1
		else
			YLD = mulLD[2]
		end
	end
	if type(mulRU) == "number" then
		CS_InputError()
	elseif mulRU == nil then
		XRU = 1
		YRU = 1
	else
		if mulRU[1] == nil then
			XRU = 1
		else
			XRU = mulRU[1]
		end
		if mulRU[2] == nil then
			YRU = 1
		else
			YRU = mulRU[2]
		end
	end
	if type(mulRD) == "number" then
		CS_InputError()
	elseif mulRD == nil then
		XRD = 1
		YRD = 1
	else
		if mulRD[1] == nil then
			XRD = 1
		else
			XRD = mulRD[1]
		end
		if mulRD[2] == nil then
			YRD = 1
		else
			YRD = mulRD[2]
		end
	end
	local RetShape = {Shape[1]}
	local X1,X2,Y1,Y2
	
	for i = 1, Shape[1] do
		local NX, NY, R1X, R1Y, R2X, R2Y, R3X, R3Y, R4X, R4Y, TX, TY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		if CenterXY ~= nil then
			NX = NX + dx
			NY = NY + dy
		end
		Y1 = (Ymax-YCntr) * YLU + YCntr
		Y2 = (Ymax-YCntr) * YRU + YCntr
		R1Y = ((NY-Ymin)/(Ymax))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin)) + Ymin

		Y1 = (Ymin-YCntr) * YLD + YCntr
		Y2 = (Ymin-YCntr) * YRD + YCntr
		R2Y = ((Ymax-NY)/(-Ymin))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin)) + Ymax

		X1 = (Xmax-XCntr) * XRD + XCntr
		X2 = (Xmax-XCntr) * XRU + XCntr
		R3X = ((NX-Xmin)/(Xmax))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin)) + Xmin

		X1 = (Xmin-XCntr) * XLD + XCntr
		X2 = (Xmin-XCntr) * XLU + XCntr
		R4X = ((Xmax-NX)/(-Xmin))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin)) + Xmax

		TX = (R3X+R4X)/2
		TY = (R1Y+R2Y)/2

		if CenterXY ~= nil then
			table.insert(RetShape,{TX-dx,TY-dy})
		else
			table.insert(RetShape,{TX,TY})
		end
	end
	return RetShape
end

--function S1_Ufunc(X) return X^2/4+8 end
--function S1_Dfunc(X) return -X^2/4-8 end
--function S1_Rfunc(Y) return Y^2/4+8 end
--function S1_Lfunc(Y) return -Y^2/4-8 end
function CS_DistortionX(Shape,mulLU,mulLD,mulRU,mulRD,CenterXY,Ufunc,Dfunc,Rfunc,Lfunc)
	local Xmax,Xmin,Ymax,Ymin,XCntr,YCntr
	Xmin = Shape[2][1]
	Xmax = Shape[2][1]
	Ymin = Shape[2][2]
	Ymax = Shape[2][2]
	for i = 1, Shape[1] do
		if Shape[i+1][1] > Xmax then
			Xmax = Shape[i+1][1]
		end
		if Shape[i+1][1] < Xmin then
			Xmin = Shape[i+1][1]
		end
		if Shape[i+1][2] > Ymax then
			Ymax = Shape[i+1][2]
		end
		if Shape[i+1][2] < Ymin then
			Ymin = Shape[i+1][2]
		end
	end
	XCntr = (Xmax+Xmin)/2
	YCntr = (Ymax+Ymin)/2
	local CX, CY, dx, dy
	if CenterXY ~= nil then
		if type(CenterXY) == "number" then
			CS_InputError()
		end
		CX = CenterXY[1]
		CY = CenterXY[2]
		dx = CX-XCntr
		dy = CY-YCntr
		Xmin = Xmin + dx
		Xmax = Xmax + dx
		Ymin = Ymin + dy
		Ymax = Ymax + dy
		XCntr = CX
		YCntr = CY		
	end

	local XLU,YLU,XRU,YRU,XRD,YRD,XLD,RLD
	local UXRatio
	local UYRatio
	if Ufunc ~= nil then
		if type(Ufunc[2]) == "number" then
			UXRatio = Ufunc[2]
			UYRatio = Ufunc[2]
		elseif Ufunc[2] == nil then
			UXRatio = 1
			UYRatio = 1
		else
			if Ufunc[2][1] == nil then
				UXRatio = 1
			else
				UXRatio = Ufunc[2][1]
			end
			if Ufunc[2][2] == nil then
				UYRatio = 1
			else
				UYRatio = Ufunc[2][2]
			end
		end
	end
	local DXRatio
	local DYRatio
	if Dfunc ~= nil then
		if type(Dfunc[2]) == "number" then
			DXRatio = Dfunc[2]
			DYRatio = Dfunc[2]
		elseif Dfunc[2] == nil then
			DXRatio = 1
			DYRatio = 1
		else
			if Dfunc[2][1] == nil then
				DXRatio = 1
			else
				DXRatio = Dfunc[2][1]
			end
			if Dfunc[2][2] == nil then
				DYRatio = 1
			else
				DYRatio = Dfunc[2][2]
			end
		end
	end
	local LXRatio
	local LYRatio
	if Lfunc ~= nil then
		if type(Lfunc[2]) == "number" then
			LXRatio = Lfunc[2]
			LYRatio = Lfunc[2]
		elseif Lfunc[2] == nil then
			LXRatio = 1
			LYRatio = 1
		else
			if Lfunc[2][1] == nil then
				LXRatio = 1
			else
				LXRatio = Lfunc[2][1]
			end
			if Lfunc[2][2] == nil then
				LYRatio = 1
			else
				LYRatio = Lfunc[2][2]
			end
		end
	end
	local RXRatio
	local RYRatio
	if Rfunc ~= nil then
		if type(Rfunc[2]) == "number" then
			RXRatio = Rfunc[2]
			RYRatio = Rfunc[2]
		elseif Rfunc[2] == nil then
			RXRatio = 1
			RYRatio = 1
		else
			if Rfunc[2][1] == nil then
				RXRatio = 1
			else
				RXRatio = Rfunc[2][1]
			end
			if Rfunc[2][2] == nil then
				RYRatio = 1
			else
				RYRatio = Rfunc[2][2]
			end
		end
	end

	if type(mulLU) == "number" then
		CS_InputError()
	elseif mulLU == nil then
		XLU = 1
		YLU = 1
	else
		if mulLU[1] == nil then
			XLU = 1
		else
			XLU = mulLU[1]
		end
		if mulLU[2] == nil then
			YLU = 1
		else
			YLU = mulLU[2]
		end
	end
	if type(mulLD) == "number" then
		CS_InputError()
	elseif mulLD == nil then
		XLD = 1
		YLD = 1
	else
		if mulLD[1] == nil then
			XLD = 1
		else
			XLD = mulLD[1]
		end
		if mulLD[2] == nil then
			YLD = 1
		else
			YLD = mulLD[2]
		end
	end
	if type(mulRU) == "number" then
		CS_InputError()
	elseif mulRU == nil then
		XRU = 1
		YRU = 1
	else
		if mulRU[1] == nil then
			XRU = 1
		else
			XRU = mulRU[1]
		end
		if mulRU[2] == nil then
			YRU = 1
		else
			YRU = mulRU[2]
		end
	end
	if type(mulRD) == "number" then
		CS_InputError()
	elseif mulRD == nil then
		XRD = 1
		YRD = 1
	else
		if mulRD[1] == nil then
			XRD = 1
		else
			XRD = mulRD[1]
		end
		if mulRD[2] == nil then
			YRD = 1
		else
			YRD = mulRD[2]
		end
	end
	local RetShape = {Shape[1]}
	local X1,X2,Y1,Y2
	
	for i = 1, Shape[1] do
		local NX, NY, R1X, R1Y, R2X, R2Y, R3X, R3Y, R4X, R4Y, TX, TY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		if CenterXY ~= nil then
			NX = NX + dx
			NY = NY + dy
		end
		Y1 = (Ymax-YCntr) * YLU + YCntr
		Y2 = (Ymax-YCntr) * YRU + YCntr
		R1Y = ((NY-Ymin)/(Ymax))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin)) + Ymin

		Y1 = (Ymin-YCntr) * YLD + YCntr
		Y2 = (Ymin-YCntr) * YRD + YCntr
		R2Y = ((Ymax-NY)/(-Ymin))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin)) + Ymax

		X1 = (Xmax-XCntr) * XRD + XCntr
		X2 = (Xmax-XCntr) * XRU + XCntr
		R3X = ((NX-Xmin)/(Xmax))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin)) + Xmin

		X1 = (Xmin-XCntr) * XLD + XCntr
		X2 = (Xmin-XCntr) * XLU + XCntr
		R4X = ((Xmax-NX)/(-Xmin))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin)) + Xmax

		TX = (R3X+R4X)/2
		TY = (R1Y+R2Y)/2

		if Ufunc ~= nil then
			R1Y = ((NY-Ymin)/(Ymax))*(_G[Ufunc[1]](TX/UXRatio)*UYRatio) + Ymin
		end
		if Dfunc ~= nil then
			R2Y = ((Ymax-NY)/(-Ymin))*(_G[Dfunc[1]](TX/DXRatio)*DYRatio) + Ymax
		end
		if Rfunc ~= nil then
			R3X = ((NX-Xmin)/(Xmax))*(_G[Rfunc[1]](TY/RYRatio)*RXRatio) + Xmin
		end
		if Lfunc ~= nil then		
			R4X = ((Xmax-NX)/(-Xmin))*(_G[Lfunc[1]](TY/LYRatio)*LXRatio) + Xmax
		end

		TX = (R3X+R4X)/2
		TY = (R1Y+R2Y)/2

		if CenterXY ~= nil then
			table.insert(RetShape,{TX-dx,TY-dy})
		else
			table.insert(RetShape,{TX,TY})
		end
	end
	return RetShape
end

-- CSPlot Function : Shape -> TRIG ---------------------------------------------------------------------------------------------------
-- Plot : 단순 Plot / Plotwithproperties : Plot에 Properties 추가
-- PlotAct : PerAction 추가 / PlotActwithproperties : PlotAct에 Properties 추가
-- PlotOrder : OrderShape 추가, DestLocation 지정 또는 DestXY 입력 / PlotOrderwithproperties : PlotOrder에 Properties 추가

function CSPlot(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,PlayerID,Condition,Action,Preserve)
	if Shape == nil then
		CS_InputError()
	end
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location-1
	if type(Location) == "string" then
		LocId =  ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location,Owner))
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-PlotSize))
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location,Owner))
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end

function CSPlotWithProperties(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,PlayerID,Condition,Action,Preserve,Properties)
	if Shape == nil then
		CS_InputError()
	end
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId,Location,Owner,Properties))
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-PlotSize))
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId,Location,Owner,Properties))
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end

function CSPlotX(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,PlayerID,Condition,Action,Preserve)
	if Shape == nil then
		CS_InputError()
	end
	local UnitIndex = 1
	local UnitMax = #UnitId
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId =  ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId[UnitIndex],Location,Owner))
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-PlotSize))
				UnitIndex = UnitIndex + 1
				if UnitIndex > UnitMax then
					UnitIndex = 1
				end
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId[UnitIndex],Location,Owner))
				UnitIndex = UnitIndex + 1
				if UnitIndex > UnitMax then
					UnitIndex = 1
				end
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end

function CSPlotXWithProperties(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,PlayerID,Condition,Action,Preserve,Properties)
	if Shape == nil then
		CS_InputError()
	end
	local UnitIndex = 1
	local UnitMax = #UnitId
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId[UnitIndex],Location,Owner,Properties))
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-PlotSize))
				UnitIndex = UnitIndex + 1
				if UnitIndex > UnitMax then
					UnitIndex = 1
				end
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId[UnitIndex],Location,Owner,Properties))
				UnitIndex = UnitIndex + 1
				if UnitIndex > UnitMax then
					UnitIndex = 1
				end
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end

function CSPlotAct(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,SizeofLoc,PerAction,PlayerID,Condition,Action,Preserve)
	if Shape == nil then
		CS_InputError()
	end
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location+1,Owner))
				table.insert(Plot,SetMemory(LocL,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-PlotSize+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-PlotSize+SizeofLoc))
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-SizeofLoc))
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location+1,Owner))
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+SizeofLoc))
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end

function CSPlotActWithProperties(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,SizeofLoc,PerAction,PlayerID,Condition,Action,Preserve,Properties)
	if Shape == nil then
		CS_InputError()
	end
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId,Location,Owner,Properties))
				table.insert(Plot,SetMemory(LocL,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-PlotSize+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-PlotSize+SizeofLoc))
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-SizeofLoc))
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId,Location,Owner,Properties))
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+SizeofLoc))
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end

function CSPlotOrder(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,OrderShape,Direction,OrderType,OrderLocation,DestXY,SizeofLoc,PerAction,PlayerID,Condition,Action,Preserve)
	if Shape[1] ~= OrderShape[1] then
		CS_Number_Difference()
	end
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end
	if Direction == 0 then
		Direction = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	if OrderShape == nil then
		CS_InputError()
	end

	local OLocId = OrderLocation
	if type(OrderLocation) == "string" then
		OLocId = ParseLocation(OLocId)-1
	end
	local OLocL = 0x58DC60+0x14*OLocId
	local OLocU = 0x58DC64+0x14*OLocId
	local OLocR = 0x58DC68+0x14*OLocId
	local OLocD = 0x58DC6C+0x14*OLocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location+1,Owner))
				table.insert(Plot,SetMemory(LocL,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-PlotSize+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-PlotSize+SizeofLoc))
				if DestXY == nil then
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[i+1][2]))
					else
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[Shape[1]+2-i][2]))
					end
				else
					local OLocX = DestXY[1]
					local OLocY = DestXY[2]
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
					else
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
					end
				end
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-SizeofLoc))
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location+1,Owner))
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+SizeofLoc))
				if DestXY == nil then
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[i+1][2]))
					else
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[Shape[1]+2-i][2]))
					end
				else
					local OLocX = DestXY[1]
					local OLocY = DestXY[2]
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
					else
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location+1,OrderType,OrderLocation+1))
					end
				end
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end

function CSPlotOrderWithProperties(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,OrderShape,Direction,OrderType,OrderLocation,DestXY,SizeofLoc,PerAction,PlayerID,Condition,Action,Preserve,Properties)
	if Shape[1] ~= OrderShape[1] then
		CS_Number_Difference()
	end
	if Shape[1] > 1700 then
		CS_UnitNumber_Over1700()
	end

	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end
	if Direction == 0 then
		Direction = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	if OrderShape == nil then
		CS_InputError()
	end

	local OLocId = OrderLocation
	if type(OrderLocation) == "string" then
		OLocId = ParseLocation(OLocId)-1
	end
	local OLocL = 0x58DC60+0x14*OLocId
	local OLocU = 0x58DC64+0x14*OLocId
	local OLocR = 0x58DC68+0x14*OLocId
	local OLocD = 0x58DC6C+0x14*OLocId

	local Plot = {}
	if CenterXY == nil then
		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,Add,Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,Add,Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,Add,Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,Add,Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId,Location,Owner,Properties))
				table.insert(Plot,SetMemory(LocL,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-PlotSize+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,PlotSize-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-PlotSize+SizeofLoc))
				if DestXY == nil then
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[i+1][2]))
					else
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[Shape[1]+2-i][2]))
					end
				else
					local OLocX = DestXY[1]
					local OLocY = DestXY[2]
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
					else
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
					end
				end
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
				table.insert(Plot,SetMemory(LocL,Add,0-Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocR,Add,0-Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocU,Add,0-Shape[i+1][2]+SizeofLoc))
				table.insert(Plot,SetMemory(LocD,Add,0-Shape[i+1][2]-SizeofLoc))
			end
		end
	else
		local LocX = CenterXY[1]
		local LocY = CenterXY[2]

		for i = 1, Shape[1] do
			if Shape[i+1] ~= nil then
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-PlotSize))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+PlotSize))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-PlotSize))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+PlotSize))
				table.insert(Plot,CreateUnitWithProperties(PerUnit,UnitId,Location,Owner,Properties))
				table.insert(Plot,SetMemory(LocL,SetTo,LocX+Shape[i+1][1]-SizeofLoc))
				table.insert(Plot,SetMemory(LocR,SetTo,LocX+Shape[i+1][1]+SizeofLoc))
				table.insert(Plot,SetMemory(LocU,SetTo,LocY+Shape[i+1][2]-SizeofLoc))
				table.insert(Plot,SetMemory(LocD,SetTo,LocY+Shape[i+1][2]+SizeofLoc))
				if DestXY == nil then
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[i+1][2]))
					else
						table.insert(Plot,SetMemory(OLocL,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
						table.insert(Plot,SetMemory(OLocL,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,Add,0-OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,Add,0-OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,Add,0-OrderShape[Shape[1]+2-i][2]))
					end
				else
					local OLocX = DestXY[1]
					local OLocY = DestXY[2]
					if Direction == nil then
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[i+1][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[i+1][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
					else
						table.insert(Plot,SetMemory(OLocL,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocR,SetTo,OLocX+OrderShape[Shape[1]+2-i][1]))
						table.insert(Plot,SetMemory(OLocU,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,SetMemory(OLocD,SetTo,OLocY+OrderShape[Shape[1]+2-i][2]))
						table.insert(Plot,Order(UnitId,Owner,Location,OrderType,OrderLocation))
					end
				end
				if PerAction ~= nil then
					for k, v in pairs(PerAction) do
						table.insert(Plot,v)
					end
				end
			end
		end
	end

	if Action ~= nil then
		for k, v in pairs(Action) do
			table.insert(Plot,v)
		end
	end

	local k = 1
	local Size = #Plot

	local Y = {}
	if Preserve ~= nil then
		table.insert(Y,PreserveTrigger())
	end

	while k <= Size do
		if Size - k + 1 >= 63 then
			local X = {}
			for i = 0, 62 do
				table.insert(X, Plot[k])
				k = k + 1
			end
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		else
			local X = {}
			repeat
				table.insert(X, Plot[k])
				k = k + 1
			until k == Size + 1
			Trigger {
				players = {ParsePlayer(PlayerID)},
				conditions = {
					Condition,
				},
				actions = {
					X,
					Y,
				},
			}
		end
	end
end
-- CSSave Functions : Shape -> .txt File ---------------------------------------------------------------
-- Save : 도형 데이터를 FileName.txt로 저장함 / SavewithName : 이름과 같이 저장
CSSaveInitCheck = 0
function CSSaveInit()
	if CSSaveInitCheck == 0 then
		os.execute("mkdir " .. "CS")
		CSSaveInitCheck = 1
	end
end

function CSSave(FileName,Local,...)
	CSSaveInit()
	local CSfile = io.open("CS/" .. FileName .. ".txt", "w")
	io.output(CSfile)
	local arg = table.pack(...)
	for k = 1, arg.n do
		if Local == nil or Local == 0 then
			io.write("Shape"..k.." =\n")
		else
			io.write("local Shape"..k.." =\n")
		end
		local CSSTR = "{".. arg[k][1]
		for i = 1, arg[k][1] do
			CSSTR = CSSTR .. ",{" .. arg[k][i+1][1] .. "," .. arg[k][i+1][2] .. "}" 
		end
		CSSTR = CSSTR .. "}\n\n\n"
		io.write(CSSTR)
	end
	io.write("---------------------------------------------------------------------------------------------------------------------")
	io.close(CSfile)
end

function CSSaveWithName(FileName,Local,...)
	CSSaveInit()
	local CSfile = io.open("CS/" .. FileName .. ".txt", "w")
	io.output(CSfile)
	local arg = table.pack(...)
	for k = 1, (arg.n-1), 2 do
		if Local == nil or Local == 0 then
			io.write(arg[k+1] .." =\n")
		else
			io.write("local "..arg[k+1].." =\n")
		end
		local CSSTR = "{".. arg[k][1]
		for i = 1, arg[k][1] do
			CSSTR = CSSTR .. ",{" .. arg[k][i+1][1] .. "," .. arg[k][i+1][2] .. "}" 
		end
		CSSTR = CSSTR .. "}\n\n\n"
		io.write(CSSTR)
	end
	io.write("---------------------------------------------------------------------------------------------------------------------")
	io.close(CSfile)
end

CSLoadInitCheck = 0
function CSLoad(...)
	local CSfile
	if CSLoadInitCheck == 0 then
		CSfile = io.open("lua/CSLoad.lua", "w")
		CSLoadInitCheck = 1
	else
		CSfile = io.open("lua/CSLoad.lua", "a")
	end
	io.output(CSfile)
	local arg = table.pack(...)
	for k = 1, arg.n do
		local CSTemp = io.open("CS/" .. arg[k] .. ".txt", "r")
		io.input(CSTemp)
		local Temp = io.read("*all")
		io.write(Temp)
		io.write("\n\n\n")
		io.close(CSTemp)
	end
	io.close(CSfile)
end

--[[
function CS_Test(...)
	local CSfile = io.open("CS/" .. "_CSTest" .. ".txt", "w")
	io.output(CSfile)
	local arg = table.pack(...)
	local k = 1
	if k == 1 then
		io.write("Local "..arg[k+1].." =\n")
		local CSSTR = "{"
		for i = 1, #arg[k] do
			CSSTR = CSSTR .. "{" .. arg[k][i][1] .. "," .. arg[k][i][2] .."," .. arg[k][i][3].."," .. arg[k][i][4].. "}," 
		end
		CSSTR = CSSTR .. "}\n\n\n"
		io.write(CSSTR)
		k = 3
	end
	for k = 3, 7, 2 do
		io.write("Local "..arg[k+1].." =\n")
		local CSSTR = "{"
		for i = 1, #arg[k] do
			CSSTR = CSSTR .. "{" .. arg[k][i] .. "}," 
		end
		CSSTR = CSSTR .. "}\n\n\n"
		io.write(CSSTR)
	end
	io.write("---------------------------------------------------------------------------------------------------------------------")
	io.close(CSfile)
end
]]--

----------- Extended Set for v2.1 ---------------------------------------

function CS_ConnectPath(Path,PerNumber,EndLine)
	local RetShape = {0}
	local Count = 0
	if Path == nil then
		CS_InputError()
	end
	if PerNumber <= 0 then
		CS_InputError()
	end

	for i = 1, Path[1]-1 do
		table.insert(RetShape,Path[i+1])
		Count = Count + 1
		for j = 1, PerNumber do
			local NX, NY
			NX = (j*Path[i+1][1]+(PerNumber-j+1)*Path[i+2][1])/(PerNumber+1)
			NY = (j*Path[i+1][2]+(PerNumber-j+1)*Path[i+2][2])/(PerNumber+1)
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	table.insert(RetShape,Path[Path[1]+1])
	Count = Count + 1
	if EndLine ~= nil then
		for j = 1, PerNumber do
			local NX, NY
			NX = (j*Path[Path[1]+1][1]+(PerNumber-j+1)*Path[2][1])/(PerNumber+1)
			NY = (j*Path[Path[1]+1][2]+(PerNumber-j+1)*Path[2][2])/(PerNumber+1)
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	RetShape[1] = Count
	return RetShape
end

function CS_ConnectPathX(Path,PerSize,EndLine)
	local RetShape = {0}
	local Count = 0
	if Path == nil then
		CS_InputError()
	end
	if PerSize <= 0 then
		CS_InputError()
	end
	PerSize = PerSize^2

	for i = 1, Path[1]-1 do
		local Length = (Path[i+2][1]-Path[i+1][1])^2+(Path[i+2][2]-Path[i+1][2])^2
		local PerNumber = math.floor(math.sqrt(Length/PerSize)+0.5)
		table.insert(RetShape,Path[i+1])
		Count = Count + 1
		for j = 1, PerNumber do
			local NX, NY
			NX = (j*Path[i+1][1]+(PerNumber-j+1)*Path[i+2][1])/(PerNumber+1)
			NY = (j*Path[i+1][2]+(PerNumber-j+1)*Path[i+2][2])/(PerNumber+1)
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	table.insert(RetShape,Path[Path[1]+1])
	Count = Count + 1
	if EndLine ~= nil then
		local Length = (Path[Path[1]+1][1]-Path[2][1])^2+(Path[Path[1]+1][2]-Path[2][2])^2
		local PerNumber = math.floor(math.sqrt(Length/PerSize)+0.5)
		for j = 1, PerNumber do
			local NX, NY
			NX = (j*Path[Path[1]+1][1]+(PerNumber-j+1)*Path[2][1])/(PerNumber+1)
			NY = (j*Path[Path[1]+1][2]+(PerNumber-j+1)*Path[2][2])/(PerNumber+1)
			table.insert(RetShape,{NX,NY})
			Count = Count + 1
		end
	end
	RetShape[1] = Count
	return RetShape
end

function CS_GetRmax(Shape)
	if Shape == nil then
		CS_InputError()
	end

	local Rmax = math.sqrt((Shape[2][1])^2+(Shape[2][2])^2)
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if PR > Rmax then
			Rmax = PR
		end
	end
	return Rmax
end

function CS_GetRmin(Shape)
	if Shape == nil then
		CS_InputError()
	end

	local Rmin = math.sqrt((Shape[2][1])^2+(Shape[2][2])^2)
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if PR < Rmin then
			Rmin = PR
		end
	end
	return Rmin
end

function CS_GetAmax(Shape)
	if Shape == nil then
		CS_InputError()
	end

	local Amax 
	if Shape[2][1]>=0 and Shape[2][2]>=0 then
		Amax = math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]>=0 then
		Amax = math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]<0 then
		Amax = math.pi + math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]>=0 and Shape[2][2]<0 then
		Amax = 2*math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	end
	
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if PR > Amax then
			Amax = PR
		end
	end
	return Amax
end

function CS_GetAmin(Shape)
	if Shape == nil then
		CS_InputError()
	end

	local Amin 
	if Shape[2][1]>=0 and Shape[2][2]>=0 then
		Amin = math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]>=0 then
		Amin = math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]<0 then
		Amin = math.pi + math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]>=0 and Shape[2][2]<0 then
		Amin = 2*math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	end

	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local PR, PA

		PR = math.sqrt(NX^2+NY^2)
		if NX>=0 and NY>=0 then
			PA = math.abs(math.atan(NY/NX))
		elseif NX<0 and NY>=0 then
			PA = math.pi - math.abs(math.atan(NY/NX))
		elseif NX<0 and NY<0 then
			PA = math.pi + math.abs(math.atan(NY/NX))
		elseif NX>=0 and NY<0 then
			PA = 2*math.pi - math.abs(math.atan(NY/NX))
		end

		if PR < Amin then
			Amin = PR
		end
	end
	return Amin
end

function CS_GetXYmax(Shape,Ratio,func)
	if Shape == nil then
		CS_InputError()
	end
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	
	local Xmax = _G[func](Shape[2][1]/XRatio,Shape[2][2]/YRatio)
	for i = 1, Shape[1] do
		local Temp = _G[func](Shape[i+1][1]/XRatio,Shape[i+1][2]/YRatio)
		if Temp > Xmax then
			Xmax = Temp 
		end
	end
	return Xmax
end

function CS_GetXYmin(Shape,Ratio,func)
	if Shape == nil then
		CS_InputError()
	end
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	
	local Xmin = _G[func](Shape[2][1]/XRatio,Shape[2][2]/YRatio)
	for i = 1, Shape[1] do
		local Temp = _G[func](Shape[i+1][1]/XRatio,Shape[i+1][2]/YRatio)
		if Temp < Xmin then
			Xmin = Temp
		end
	end
	return Xmin
end

function CS_GetRAmax(Shape,Ratio,func)
	if Shape == nil then
		CS_InputError()
	end
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	local NR, NA
	NR = math.sqrt((Shape[2][1])^2+(Shape[2][2])^2)
	if Shape[2][1]>=0 and Shape[2][2]>=0 then
		NA = math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]>=0 then
		NA = math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]<0 then
		NA = math.pi + math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]>=0 and Shape[2][2]<0 then
		NA = 2*math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	end
	local Xmax = _G[func](NR/XRatio,NA/YRatio)
	for i = 1, Shape[1] do
		local PR, PA
		PR = math.sqrt((Shape[i+1][1])^2+(Shape[i+1][2])^2)
		if Shape[i+1][1]>=0 and Shape[i+1][2]>=0 then
			PA = math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]<0 and Shape[i+1][2]>=0 then
			PA = math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]<0 and Shape[i+1][2]<0 then
			PA = math.pi + math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]>=0 and Shape[i+1][2]<0 then
			PA = 2*math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		end
		local Temp = _G[func](PR/XRatio,PA/YRatio)
		if Temp > Xmax then
			Xmax = Temp 
		end
	end
	return Xmax
end

function CS_GetRAmin(Shape,Ratio,func)
	if Shape == nil then
		CS_InputError()
	end
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	local NR, NA
	NR = math.sqrt((Shape[2][1])^2+(Shape[2][2])^2)
	if Shape[2][1]>=0 and Shape[2][2]>=0 then
		NA = math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]>=0 then
		NA = math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]<0 and Shape[2][2]<0 then
		NA = math.pi + math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	elseif Shape[2][1]>=0 and Shape[2][2]<0 then
		NA = 2*math.pi - math.abs(math.atan(Shape[2][2]/Shape[2][1]))
	end
	local Xmin = _G[func](NR/XRatio,NA/YRatio)
	for i = 1, Shape[1] do
		local PR, PA
		PR = math.sqrt((Shape[i+1][1])^2+(Shape[i+1][2])^2)
		if Shape[i+1][1]>=0 and Shape[i+1][2]>=0 then
			PA = math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]<0 and Shape[i+1][2]>=0 then
			PA = math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]<0 and Shape[i+1][2]<0 then
			PA = math.pi + math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]>=0 and Shape[i+1][2]<0 then
			PA = 2*math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		end
		local Temp = _G[func](PR/XRatio,PA/YRatio)
		if Temp < Xmin then
			Xmin = Temp
		end
	end
	return Xmin
end



function CS_SortX(Shape,Direction) 
	if Shape == nil then
		CS_InputError()
	end
	if Direction == nil then
		CS_InputError()
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end
	if Direction == 0 then
		local Xmin, Temp
		for i = 1, Shape[1] do
			Xmin = i+1
			for j = i, Shape[1] do
				if RetShape[Xmin][1] > RetShape[j+1][1] then
					Xmin = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmin]
			RetShape[Xmin] = Temp
		end
	else
		local Xmax, Temp
		for i = 1, Shape[1] do
			Xmax = i+1
			for j = i, Shape[1] do
				if RetShape[Xmax][1] < RetShape[j+1][1] then
					Xmax = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmax]
			RetShape[Xmax] = Temp
		end
	end
	return RetShape
end

function CS_SortY(Shape,Direction) 
	if Shape == nil then
		CS_InputError()
	end
	if Direction == nil then
		CS_InputError()
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end
	if Direction == 0 then
		local Ymin, Temp
		for i = 1, Shape[1] do
			Ymin = i+1
			for j = i, Shape[1] do
				if RetShape[Ymin][2] > RetShape[j+1][2] then
					Ymin = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Ymin]
			RetShape[Ymin] = Temp
		end
	else
		local Ymax, Temp
		for i = 1, Shape[1] do
			Ymax = i+1
			for j = i, Shape[1] do
				if RetShape[Ymax][2] < RetShape[j+1][2] then
					Ymax = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Ymax]
			RetShape[Ymax] = Temp
		end
	end
	return RetShape
end

function CS_SortR(Shape,Direction) 
	if Shape == nil then
		CS_InputError()
	end
	if Direction == nil then
		CS_InputError()
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end
	if Direction == 0 then
		local Rmin, Temp
		for i = 1, Shape[1] do
			Rmin = i+1
			local PR, NR
			PR = math.sqrt((RetShape[i+1][1])^2+(RetShape[i+1][2])^2)
			for j = i, Shape[1] do
				NR = math.sqrt((RetShape[j+1][1])^2+(RetShape[j+1][2])^2)
				if PR > NR then
					Rmin = j+1
					PR = NR
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Rmin]
			RetShape[Rmin] = Temp
		end
	else
		local Rmax, Temp
		for i = 1, Shape[1] do
			Rmax = i+1
			local PR, NR
			PR = math.sqrt((RetShape[i+1][1])^2+(RetShape[i+1][2])^2)
			for j = i, Shape[1] do
				NR = math.sqrt((RetShape[j+1][1])^2+(RetShape[j+1][2])^2)
				if PR < NR then
					Rmax = j+1
					PR = NR
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Rmax]
			RetShape[Rmax] = Temp
		end
	end
	return RetShape
end

function CS_SortA(Shape,Direction) 
	if Shape == nil then
		CS_InputError()
	end
	if Direction == nil then
		CS_InputError()
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end
	if Direction == 0 then
		local Amin, Temp
		for i = 1, Shape[1] do
			Amin = i+1
			local PA, NA
			if RetShape[i+1][1]>=0 and RetShape[i+1][2]>=0 then
				PA = math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]<0 and RetShape[i+1][2]>=0 then
				PA = math.pi - math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]<0 and RetShape[i+1][2]<0 then
				PA = math.pi + math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]>=0 and RetShape[i+1][2]<0 then
				PA = 2*math.pi - math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			end
			for j = i, Shape[1] do
				if RetShape[j+1][1]>=0 and RetShape[j+1][2]>=0 then
					NA = math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				elseif RetShape[j+1][1]<0 and RetShape[j+1][2]>=0 then
					NA = math.pi - math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				elseif RetShape[j+1][1]<0 and RetShape[j+1][2]<0 then
					NA = math.pi + math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				elseif RetShape[j+1][1]>=0 and RetShape[j+1][2]<0 then
					NA = 2*math.pi - math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				end
				if PA > NA then
					Amin = j+1
					PA = NA
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Amin]
			RetShape[Amin] = Temp
		end
	else
		local Amax, Temp
		for i = 1, Shape[1] do
			Amax = i+1
			local PA, NA
			if RetShape[i+1][1]>=0 and RetShape[i+1][2]>=0 then
				PA = math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]<0 and RetShape[i+1][2]>=0 then
				PA = math.pi - math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]<0 and RetShape[i+1][2]<0 then
				PA = math.pi + math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]>=0 and RetShape[i+1][2]<0 then
				PA = 2*math.pi - math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			end
			for j = i, Shape[1] do
				if RetShape[j+1][1]>=0 and RetShape[j+1][2]>=0 then
					NA = math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				elseif RetShape[j+1][1]<0 and RetShape[j+1][2]>=0 then
					NA = math.pi - math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				elseif RetShape[j+1][1]<0 and RetShape[j+1][2]<0 then
					NA = math.pi + math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				elseif RetShape[j+1][1]>=0 and RetShape[j+1][2]<0 then
					NA = 2*math.pi - math.abs(math.atan(RetShape[j+1][2]/RetShape[j+1][1]))
				end
				if PA < NA then
					Amax = j+1
					PA = NA
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Amax]
			RetShape[Amax] = Temp
		end
	end
	return RetShape
end

function CS_DoubleSortRA(Shape,Thickness,RDirection,ADirection) 
	if Shape == nil then
		CS_InputError()
	end
	if RDirection == nil or ADirection == nil then
		CS_InputError()
	end
	if Thickness == nil or Thickness <= 0 then
		CS_InputError()
	end
	local RetShape = {}
	local SR 
	local I1, I2, Index

	if RDirection == 0 and ADirection == 0 then -- R↗, A↗
		SR = CS_GetRmin(Shape)
		RetShape = CS_SortR(Shape,0)
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1] then break end
			SR = SR + Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR < math.sqrt((RetShape[k][1])^2+(RetShape[k][2])^2) then 
					k = k - 1
					break 
				end
				k = k + 1
			end

			I2 = k
			if I1 == I2 then
				goto CS_SortRASkip1
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				if RetShape[i][1]>=0 and RetShape[i][2]>=0 then
					PA = math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]>=0 then
					PA = math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]<0 then
					PA = math.pi + math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]>=0 and RetShape[i][2]<0 then
					PA = 2*math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				end
				for j = i, I2 do
					if RetShape[j][1]>=0 and RetShape[j][2]>=0 then
						NA = math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]>=0 then
						NA = math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]<0 then
						NA = math.pi + math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]>=0 and RetShape[j][2]<0 then
						NA = 2*math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					end
					if PA > NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
			end
			::CS_SortRASkip1::
			I1 = I2+1
		end
	elseif RDirection == 0 and ADirection == 1 then
		SR = CS_GetRmin(Shape)
		RetShape = CS_SortR(Shape,0)
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1] then break end
			SR = SR + Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR < math.sqrt((RetShape[k][1])^2+(RetShape[k][2])^2) then 
					k = k - 1
					break 
				end
				k = k + 1
			end

			I2 = k
			if I1 == I2 then
				goto CS_SortRASkip2
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				if RetShape[i][1]>=0 and RetShape[i][2]>=0 then
					PA = math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]>=0 then
					PA = math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]<0 then
					PA = math.pi + math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]>=0 and RetShape[i][2]<0 then
					PA = 2*math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				end
				for j = i, I2 do
					if RetShape[j][1]>=0 and RetShape[j][2]>=0 then
						NA = math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]>=0 then
						NA = math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]<0 then
						NA = math.pi + math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]>=0 and RetShape[j][2]<0 then
						NA = 2*math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					end
					if PA < NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
			end
			::CS_SortRASkip2::
			I1 = I2+1
		end
	elseif RDirection == 1 and ADirection == 0 then
		SR = CS_GetRmax(Shape)
		RetShape = CS_SortR(Shape,1)
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1] then break end
			SR = SR - Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR > math.sqrt((RetShape[k][1])^2+(RetShape[k][2])^2) then 
					k = k - 1
					break 
				end
				k = k + 1
			end

			I2 = k
			if I1 == I2 then
				goto CS_SortRASkip3
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				if RetShape[i][1]>=0 and RetShape[i][2]>=0 then
					PA = math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]>=0 then
					PA = math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]<0 then
					PA = math.pi + math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]>=0 and RetShape[i][2]<0 then
					PA = 2*math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				end
				for j = i, I2 do
					if RetShape[j][1]>=0 and RetShape[j][2]>=0 then
						NA = math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]>=0 then
						NA = math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]<0 then
						NA = math.pi + math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]>=0 and RetShape[j][2]<0 then
						NA = 2*math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					end
					if PA > NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
			end
			::CS_SortRASkip3::
			I1 = I2+1
		end
	elseif RDirection == 1 and ADirection == 1 then
		SR = CS_GetRmax(Shape)
		RetShape = CS_SortR(Shape,1)
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1] then break end
			SR = SR - Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR > math.sqrt((RetShape[k][1])^2+(RetShape[k][2])^2) then 
					k = k - 1
					break 
				end
				k = k + 1
			end

			I2 = k
			if I1 == I2 then
				goto CS_SortRASkip4
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				if RetShape[i][1]>=0 and RetShape[i][2]>=0 then
					PA = math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]>=0 then
					PA = math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]<0 and RetShape[i][2]<0 then
					PA = math.pi + math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				elseif RetShape[i][1]>=0 and RetShape[i][2]<0 then
					PA = 2*math.pi - math.abs(math.atan(RetShape[i][2]/RetShape[i][1]))
				end
				for j = i, I2 do
					if RetShape[j][1]>=0 and RetShape[j][2]>=0 then
						NA = math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]>=0 then
						NA = math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]<0 and RetShape[j][2]<0 then
						NA = math.pi + math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					elseif RetShape[j][1]>=0 and RetShape[j][2]<0 then
						NA = 2*math.pi - math.abs(math.atan(RetShape[j][2]/RetShape[j][1]))
					end
					if PA < NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
			end
			::CS_SortRASkip4::
			I1 = I2+1
		end
	end
	return RetShape
end

function CS_SortGraphXY(Shape,Ratio,funcXY,Direction)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if Shape == nil then
		CS_InputError()
	end
	if Direction == nil then
		CS_InputError()
	end
	local RetShape = {Shape[1]}
	local RetCalc = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		table.insert(RetCalc,_G[funcXY](NX/XRatio,NY/YRatio))
		table.insert(RetShape,Shape[i+1])
	end
	if Direction == 0 then
		local Xmin, Temp
		for i = 1, Shape[1] do
			Xmin = i+1
			for j = i, Shape[1] do
				if RetCalc[Xmin] > RetCalc[j+1] then
					Xmin = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmin]
			RetShape[Xmin] = Temp
			Temp = RetCalc[i+1]
			RetCalc[i+1] = RetCalc[Xmin]
			RetCalc[Xmin] = Temp
		end
	else
		local Xmax, Temp
		for i = 1, Shape[1] do
			Xmax = i+1
			for j = i, Shape[1] do
				if RetCalc[Xmax] < RetCalc[j+1] then
					Xmax = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmax]
			RetShape[Xmax] = Temp
			Temp = RetCalc[i+1]
			RetCalc[i+1] = RetCalc[Xmax]
			RetCalc[Xmax] = Temp
		end
	end
	return RetShape
end

function CS_SortGraphRA(Shape,Ratio,funcRA,Direction)
	local XRatio
	local YRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
	end
	if Shape == nil then
		CS_InputError()
	end
	if Direction == nil then
		CS_InputError()
	end
	local RetShape = {Shape[1]}
	local RetCalc = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local NR, NA
		NR = math.sqrt(NX^2+NY^2)
		if Shape[i+1][1]>=0 and Shape[i+1][2]>=0 then
			NA = math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]<0 and Shape[i+1][2]>=0 then
			NA = math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]<0 and Shape[i+1][2]<0 then
			NA = math.pi + math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		elseif Shape[i+1][1]>=0 and Shape[i+1][2]<0 then
			NA = 2*math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
		end
		table.insert(RetCalc,_G[funcRA](NR/XRatio,NA/YRatio))
		table.insert(RetShape,Shape[i+1])
	end
	if Direction == 0 then
		local Xmin, Temp
		for i = 1, Shape[1] do
			Xmin = i+1
			for j = i, Shape[1] do
				if RetCalc[Xmin] > RetCalc[j+1] then
					Xmin = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmin]
			RetShape[Xmin] = Temp
			Temp = RetCalc[i+1]
			RetCalc[i+1] = RetCalc[Xmin]
			RetCalc[Xmin] = Temp
		end
	else
		local Xmax, Temp
		for i = 1, Shape[1] do
			Xmax = i+1
			for j = i, Shape[1] do
				if RetCalc[Xmax] < RetCalc[j+1] then
					Xmax = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmax]
			RetShape[Xmax] = Temp
			Temp = RetCalc[i+1]
			RetCalc[i+1] = RetCalc[Xmax]
			RetCalc[Xmax] = Temp
		end
	end
	return RetShape
end

function CS_DoubleSortGraph(Shape,funcA,funcB,Thickness,PartShuffle,ADirection,BDirection)
	if funcA[1] > 3 or funcB[1] > 3 then
		CS_InputError()
	end
	local XARatio = 1
	local YARatio = 1
	if funcA[3] ~= nil then
		local ARatio = funcA[3]
		
		if type(ARatio) == "number" then
			XARatio = ARatio
			YARatio = ARatio
		else
			if ARatio[1] == nil then
				XARatio = 1
			else
				XARatio = ARatio[1]
			end
			if ARatio[2] == nil then
				YARatio = 1
			else
				YARatio = ARatio[2]
			end
		end
	end
	local XBRatio = 1
	local YBRatio = 1
	if funcB[3] ~= nil then
		local BRatio = funcB[3]
		
		if type(BRatio) == "number" then
			XBRatio = BRatio
			YBRatio = BRatio
		else
			if BRatio[1] == nil then
				XBRatio = 1
			else
				XBRatio = BRatio[1]
			end
			if BRatio[2] == nil then
				YBRatio = 1
			else
				YBRatio = BRatio[2]
			end
		end
	end
	if Shape == nil then
		CS_InputError()
	end
	if PartShuffle == nil then
		PartShuffle = 0
	end
	if ADirection == nil or BDirection == nil then
		CS_InputError()
	end
	if Thickness == nil or Thickness <= 0 then
		CS_InputError()
	end

	local RetShape = {Shape[1]}
	local RetCalcA = {Shape[1]}
	local RetCalcB = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, NR, NA
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		if funcA[1] == 0 then
			table.insert(RetCalcA,_G[funcA[2]](NX/XARatio,NY/YARatio))
			table.insert(RetShape,Shape[i+1])
		elseif funcA[1] == 1 then
			NR = math.sqrt(NX^2+NY^2)
			if Shape[i+1][1]>=0 and Shape[i+1][2]>=0 then
				NA = math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
			elseif Shape[i+1][1]<0 and Shape[i+1][2]>=0 then
				NA = math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
			elseif Shape[i+1][1]<0 and Shape[i+1][2]<0 then
				NA = math.pi + math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
			elseif Shape[i+1][1]>=0 and Shape[i+1][2]<0 then
				NA = 2*math.pi - math.abs(math.atan(Shape[i+1][2]/Shape[i+1][1]))
			end
			table.insert(RetCalcA,_G[funcA[2]](NR/XARatio,NA/YARatio))
			table.insert(RetShape,Shape[i+1])
		elseif funcA[1] == 2 then
			table.insert(RetCalcA,math.random(0,65535))
			table.insert(RetShape,Shape[i+1])
		end
	end
	if ADirection == 0 then
		local Xmin, Temp
		for i = 1, Shape[1] do
			Xmin = i+1
			for j = i, Shape[1] do
				if RetCalcA[Xmin] > RetCalcA[j+1] then
					Xmin = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmin]
			RetShape[Xmin] = Temp
			Temp = RetCalcA[i+1]
			RetCalcA[i+1] = RetCalcA[Xmin]
			RetCalcA[Xmin] = Temp
		end
	else
		local Xmax, Temp
		for i = 1, Shape[1] do
			Xmax = i+1
			for j = i, Shape[1] do
				if RetCalcA[Xmax] < RetCalcA[j+1] then
					Xmax = j+1
				end
			end
			Temp = RetShape[i+1]
			RetShape[i+1] = RetShape[Xmax]
			RetShape[Xmax] = Temp
			Temp = RetCalcA[i+1]
			RetCalcA[i+1] = RetCalcA[Xmax]
			RetCalcA[Xmax] = Temp
		end
	end

	for i = 1, Shape[1] do
		local NX, NY, NR, NA
		NX = RetShape[i+1][1]
		NY = RetShape[i+1][2]
		if funcB[1] == 0 then
			table.insert(RetCalcB,_G[funcB[2]](NX/XBRatio,NY/YBRatio))
			table.insert(RetShape,Shape[i+1])
		elseif funcB[1] == 1 then
			NR = math.sqrt(NX^2+NY^2)
			if RetShape[i+1][1]>=0 and RetShape[i+1][2]>=0 then
				NA = math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]<0 and RetShape[i+1][2]>=0 then
				NA = math.pi - math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]<0 and RetShape[i+1][2]<0 then
				NA = math.pi + math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			elseif RetShape[i+1][1]>=0 and RetShape[i+1][2]<0 then
				NA = 2*math.pi - math.abs(math.atan(RetShape[i+1][2]/RetShape[i+1][1]))
			end
			table.insert(RetCalcB,_G[funcB[2]](NR/XBRatio,NA/YBRatio))
			table.insert(RetShape,Shape[i+1])
		elseif funcB[1] == 2 then
			table.insert(RetCalcB,math.random(0,65535))
			table.insert(RetShape,Shape[i+1])
		end
	end

	local SR 
	local I1, I2
	local Part = {}
	if ADirection == 0 and BDirection == 0 then -- R↗, A↗
		SR = RetCalcA[2]
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1]+1 then break end
			SR = SR + Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR < RetCalcA[k] then 
					k = k - 1
					break 
				end
				k = k + 1
			end
			I2 = k
			if I1 <= I2 then
				table.insert(Part,{I1,I2})
			end
			if I1 == I2 then
				goto CS_SortGraphSkip1
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				PA = RetCalcB[i]
				for j = i, I2 do
					NA = RetCalcB[j]
					if PA > NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
				Temp = RetCalcA[i]
				RetCalcA[i] = RetCalcA[Amin]
				RetCalcA[Amin] = Temp
				Temp = RetCalcB[i]
				RetCalcB[i] = RetCalcB[Amin]
				RetCalcB[Amin] = Temp
			end
			::CS_SortGraphSkip1::
			I1 = I2+1
		end
	elseif ADirection == 0 and BDirection == 1 then
		SR = RetCalcA[2]
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1]+1 then break end
			SR = SR + Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR < RetCalcA[k] then 
					k = k - 1
					break 
				end
				k = k + 1
			end
			I2 = k
			if I1 <= I2 then
				table.insert(Part,{I1,I2})
			end
			if I1 == I2 then
				goto CS_SortGraphSkip2
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				PA = RetCalcB[i]
				for j = i, I2 do
					NA = RetCalcB[j]
					if PA < NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
				Temp = RetCalcA[i]
				RetCalcA[i] = RetCalcA[Amin]
				RetCalcA[Amin] = Temp
				Temp = RetCalcB[i]
				RetCalcB[i] = RetCalcB[Amin]
				RetCalcB[Amin] = Temp
			end
			::CS_SortGraphSkip2::
			I1 = I2+1
		end
	elseif ADirection == 1 and BDirection == 0 then
		SR = RetCalcA[2]
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1]+1 then break end
			SR = SR - Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR > RetCalcA[k] then 
					k = k - 1
					break 
				end
				k = k + 1
			end
			I2 = k
			if I1 <= I2 then
				table.insert(Part,{I1,I2})
			end
			if I1 == I2 then
				goto CS_SortGraphSkip3
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				PA = RetCalcB[i]
				for j = i, I2 do
					NA = RetCalcB[j]
					if PA > NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
				Temp = RetCalcA[i]
				RetCalcA[i] = RetCalcA[Amin]
				RetCalcA[Amin] = Temp
				Temp = RetCalcB[i]
				RetCalcB[i] = RetCalcB[Amin]
				RetCalcB[Amin] = Temp
			end
			::CS_SortGraphSkip3::
			I1 = I2+1
		end
	elseif ADirection == 1 and BDirection == 1 then
		SR = RetCalcA[2]
		local Amin, Temp
		I1 = 2
		while true do
			if I1 > Shape[1]+1 then break end
			SR = SR - Thickness
			local k = I1
			while true do
				if k > Shape[1]+1 or SR > RetCalcA[k] then 
					k = k - 1
					break 
				end
				k = k + 1
			end
			I2 = k
			if I1 <= I2 then
				table.insert(Part,{I1,I2})
			end
			if I1 == I2 then
				goto CS_SortGraphSkip4
			end
			for i = I1, I2 do
				Amin = i
				local PA, NA
				PA = RetCalcB[i]
				for j = i, I2 do
					NA = RetCalcB[j]
					if PA < NA then
						Amin = j
						PA = NA
					end
				end
				Temp = RetShape[i]
				RetShape[i] = RetShape[Amin]
				RetShape[Amin] = Temp
				Temp = RetCalcA[i]
				RetCalcA[i] = RetCalcA[Amin]
				RetCalcA[Amin] = Temp
				Temp = RetCalcB[i]
				RetCalcB[i] = RetCalcB[Amin]
				RetCalcB[Amin] = Temp
			end
			::CS_SortGraphSkip4::
			I1 = I2+1
		end
	end

	if PartShuffle == 1 then
		local Temp, Index
		for j = 0, 2 do
			for k, v in pairs(Part) do
				Index = math.random(1,#Part)
				Temp = Part[k]
				Part[k] = Part[Index]
				Part[Index] = Temp
			end
		end
		local RetShape2 = {Shape[1]}
		for k, v in pairs(Part) do
			for i = v[1], v[2] do
				table.insert(RetShape2,RetShape[i])
			end
		end
		RetShape = RetShape2
	end

	return RetShape
end

--------- CA Paint v2.1 ---------------------------------------------------------------------------

CAPlotJumpAlloc = 0x800
CAPlotVarAlloc = 0x8000
CAPlotDataArr = {}
CAPlotPlayerID = {}
CAPlotCreateArr = {}

function CA_ConvertRA(DestR,DestA,SourceX,SourceY)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	CMov(PlayerID,V(CB[6]),SourceX)
	CMov(PlayerID,V(CB[7]),SourceY)
	f_Atan2(PlayerID,V(CB[7]),V(CB[6]),V(CB[4]))
	f_Sqrt(PlayerID,V(CB[5]),_Add(_mul(V(CB[6]),V(CB[6])),_mul(V(CB[7]),V(CB[7]))))
	CMov(PlayerID,DestR,V(CB[5]))
	CMov(PlayerID,DestA,V(CB[4]))	
end

function CA_ConvertXY(DestX,DestY,SourceR,SourceA)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	f_Lengthdir(PlayerID,SourceR,SourceA,V(CA[8]),V(CA[9]))
end

function CA_MoveXY(X,Y)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	if X ~= nil then
		CAdd(PlayerID,V(CA[8]),X)
	end
	if Y ~= nil then
		CAdd(PlayerID,V(CA[9]),Y)
	end
end

function CA_MoveRA(Radius,Angle)
 	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	CMov(PlayerID,V(CB[6]),Radius)
	CMov(PlayerID,V(CB[7]),Angle)
	f_Atan2(PlayerID,V(CA[9]),V(CA[8]),V(CB[4]))
	f_Sqrt(PlayerID,V(CB[5]),_Add(_mul(V(CA[8]),V(CA[8])),_mul(V(CA[9]),V(CA[9]))))
	if Radius ~= nil then
		CAdd(PlayerID,V(CB[5]),V(CB[6]))
	end
	if Angle ~= nil then
		CAdd(PlayerID,V(CB[4]),V(CB[7]))
	end
	f_Lengthdir(PlayerID,V(CB[5]),V(CB[4]),V(CA[8]),V(CA[9]))
end

function CA_RatioXY(mulX,idivX,mulY,idivY)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	if mulX ~= nil then
		if type(mulX) == "number" then
			CMul(PlayerID,V(CA[8]),mulX)
		else
			f_Mul(PlayerID,V(CA[8]),mulX)
		end
	end
	if mulY ~= nil then
		if type(mulY) == "number" then
			CMul(PlayerID,V(CA[9]),mulY)
		else
			f_Mul(PlayerID,V(CA[9]),mulY)
		end
	end
	if idivX ~= nil then
		if type(idivX) == "number" then
			CiDiv(PlayerID,V(CA[8]),idivX)
		else
			f_iDiv(PlayerID,V(CA[8]),idivX)
		end
	end
	if idivY ~= nil then
		if type(idivY) == "number" then
			CiDiv(PlayerID,V(CA[9]),idivY)
		else
			f_iDiv(PlayerID,V(CA[9]),idivY)
		end
	end
end

function CA_RatioRA(mulR,idivR,mulA,idivA)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if mulR ~= nil and type(mulR) ~= "number" then
		CMov(PlayerID,V(CB[6]),mulR)
	end
	if mulA ~= nil and type(mulA) ~= "number" then
		CMov(PlayerID,V(CB[7]),mulA)
	end
	if idivR ~= nil and type(idivR) ~= "number" then
		CMov(PlayerID,V(CB[8]),idivR)
	end
	if idivA ~= nil and type(idivA) ~= "number" then
		CMov(PlayerID,V(CB[9]),idivA)
	end
	f_Atan2(PlayerID,V(CA[9]),V(CA[8]),V(CB[4]))
	f_Sqrt(PlayerID,V(CB[5]),_Add(_mul(V(CA[8]),V(CA[8])),_mul(V(CA[9]),V(CA[9]))))
	if mulR ~= nil then
		if type(mulR) == "number" then
			CMul(PlayerID,V(CB[5]),mulR)
		else
			f_Mul(PlayerID,V(CB[5]),V(CB[6]))
		end
	end
	if mulA ~= nil then
		if type(mulA) == "number" then
			CMul(PlayerID,V(CB[4]),mulA)
		else
			f_Mul(PlayerID,V(CB[4]),V(CB[7]))
		end
	end
	if idivR ~= nil then
		if type(idivR) == "number" then
			CiDiv(PlayerID,V(CB[5]),idivR)
		else
			f_iDiv(PlayerID,V(CB[5]),V(CB[8]))
		end
	end
	if idivA ~= nil then
		if type(idivA) == "number" then
			CiDiv(PlayerID,V(CB[4]),idivA)
		else
			f_iDiv(PlayerID,V(CB[4]),V(CB[9]))
		end
	end
	f_Lengthdir(PlayerID,V(CB[5]),V(CB[4]),V(CA[8]),V(CA[9]))
end

function CA_InvertXY(X,Y)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if X ~= nil and type(X) ~= "number" then
		CMov(PlayerID,V(CB[4]),X)
	end
	if Y ~= nil and type(Y) ~= "number" then
		CMov(PlayerID,V(CB[5]),Y)
	end

	if X ~= nil then
		if type(X) == "number" then
			CMov(PlayerID,V(CA[8]),_iSub(_Mov(2*X),V(CA[8])))
		else
			CMov(PlayerID,V(CA[8]),_iSub(_Add(V(CB[4]),V(CB[4])),V(CA[8])))
		end
	end
	if Y ~= nil then
		if type(Y) == "number" then
			CMov(PlayerID,V(CA[9]),_iSub(_Mov(2*Y),V(CA[9])))
		else
			CMov(PlayerID,V(CA[9]),_iSub(_Add(V(CB[5]),V(CB[5])),V(CA[9])))
		end
	end
end

function CA_InvertRA(Radius,Angle)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if Radius ~= nil and type(Radius) ~= "number" then
		CMov(PlayerID,V(CB[6]),Radius)
	end
	if Angle ~= nil and type(Angle) ~= "number" then
		CMov(PlayerID,V(CB[7]),Angle)
	end
	f_Atan2(PlayerID,V(CA[9]),V(CA[8]),V(CB[4]))
	f_Sqrt(PlayerID,V(CB[5]),_Add(_mul(V(CA[8]),V(CA[8])),_mul(V(CA[9]),V(CA[9]))))
	if Radius ~= nil then
		if type(Radius) == "number" then
			CMov(PlayerID,V(CB[5]),_iSub(_Mov(2*Radius),V(CB[5])))
		else
			CMov(PlayerID,V(CB[5]),_iSub(_Add(V(CB[6]),V(CB[6])),V(CB[5])))
		end
	end
	if Angle ~= nil then
		if type(Angle) == "number" then
			CMov(PlayerID,V(CB[4]),_iSub(_Mov(2*Angle),V(CB[4])))
		else
			CMov(PlayerID,V(CB[4]),_iSub(_Add(V(CB[7]),V(CB[7])),V(CB[4])))
		end
	end

	f_Lengthdir(PlayerID,V(CB[5]),V(CB[4]),V(CA[8]),V(CA[9]))
end

function CA_Rotate(Angle)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	if type(Angle) == "number" then -- Temp Var가 Angle로 입력시 _Mov(Angle) 입력할 경우 Temp Var가 초기화되어 버그 발생
		f_Lengthdir(PlayerID,V(CA[8]),_Mov(Angle),V(CB[5]),V(CB[6])) -- XCos XSin 
		f_Lengthdir(PlayerID,V(CA[9]),_Mov(Angle),V(CB[7]),V(CB[8])) -- YCos YSin
	else
		CMov(PlayerID,V(CB[4]),Angle)
		f_Lengthdir(PlayerID,V(CA[8]),V(CB[4]),V(CB[5]),V(CB[6])) -- XCos XSin 
		f_Lengthdir(PlayerID,V(CA[9]),V(CB[4]),V(CB[7]),V(CB[8])) -- YCos YSin
	end

	CMov(PlayerID,V(CA[8]),_iSub(V(CB[5]),V(CB[8]))) -- XCos - YSin
	CMov(PlayerID,V(CA[9]),_Add(V(CB[6]),V(CB[7]))) -- XSin + YCos
end

function CA_Rotate3D(XYAngle,YZAngle,ZXAngle)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if XYAngle ~= nil and type(XYAngle) ~= "number" then
		CMov(PlayerID,V(CB[6]),XYAngle)
	end
	if YZAngle ~= nil and type(YZAngle) ~= "number" then
		CMov(PlayerID,V(CB[7]),YZAngle)
	end
	if ZXAngle ~= nil and type(ZXAngle) ~= "number" then
		CMov(PlayerID,V(CB[8]),ZXAngle)
	end

	CMov(PlayerID,V(CB[9]),0) -- Z
	if XYAngle ~= nil then 
		if type(XYAngle) == "number" then -- Temp Var가 Angle로 입력시 _Mov(Angle) 입력할 경우 Temp Var가 초기화되어 버그 발생
			f_Lengthdir(PlayerID,V(CA[8]),_Mov(XYAngle),V(CA[11]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CA[9]),_Mov(XYAngle),V(CA[13]),V(CA[14])) -- YCos YSin
		else
			f_Lengthdir(PlayerID,V(CA[8]),V(CB[6]),V(CA[11]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CA[9]),V(CB[6]),V(CA[13]),V(CA[14])) -- YCos YSin
		end
		CMov(PlayerID,V(CA[8]),_iSub(V(CA[11]),V(CA[14]))) -- X
		CMov(PlayerID,V(CA[9]),_Add(V(CA[12]),V(CA[13]))) -- Y
	end

	if YZAngle ~= nil then 
		if type(YZAngle) == "number" then -- Temp Var가 Angle로 입력시 _Mov(Angle) 입력할 경우 Temp Var가 초기화되어 버그 발생
			f_Lengthdir(PlayerID,V(CA[9]),_Mov(YZAngle),V(CA[13]),V(CA[14])) -- YCos YSin
		else
			f_Lengthdir(PlayerID,V(CA[9]),V(CB[7]),V(CA[13]),V(CA[14])) -- YCos YSin
		end
		CMov(PlayerID,V(CA[9]),V(CA[13])) -- Y
		CMov(PlayerID,V(CB[9]),V(CA[14])) -- Z
	end

	if ZXAngle ~= nil then 
		if type(ZXAngle) == "number" then -- Temp Var가 Angle로 입력시 _Mov(Angle) 입력할 경우 Temp Var가 초기화되어 버그 발생
			f_Lengthdir(PlayerID,V(CA[8]),_Mov(ZXAngle),V(CA[11]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CB[9]),_Mov(ZXAngle),V(CA[13]),V(CA[14])) -- ZCos ZSin
		else
			f_Lengthdir(PlayerID,V(CA[8]),V(CB[8]),V(CA[11]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CB[9]),V(CB[8]),V(CA[13]),V(CA[14])) -- ZCos ZSin
		end
		CMov(PlayerID,V(CA[8]),_iSub(V(CA[11]),V(CA[14]))) -- X
	end
end

function CA_CropXY(X1,X2,Y1,Y2)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if X1 ~= nil and type(X1) ~= "number" then
		CMov(PlayerID,V(CB[4]),X1)
	end
	if X2 ~= nil and type(X2) ~= "number" then
		CMov(PlayerID,V(CB[5]),X2)
	end
	if Y1 ~= nil and type(Y1) ~= "number" then
		CMov(PlayerID,V(CB[6]),Y1)
	end
	if Y2 ~= nil and type(Y2) ~= "number" then
		CMov(PlayerID,V(CB[7]),Y2)
	end

	if X1 ~= nil then
		if type(X1) == "number" then
			if X1 >= 0 then
				CTrigger(PlayerID,{TTOR({CVar("X",CA[8],AtMost,X1),CVar("X",CA[8],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{CVar("X",CA[8],AtMost,X1),CVar("X",CA[8],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[4],AtLeast,0x80000000))
				CTrigger(PlayerID,{TCVar("X",CA[8],AtMost,V(CB[4])),CVar("X",CA[8],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[8],AtMost,V(CB[4])),CVar("X",CA[8],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if X2 ~= nil then
		if type(X2) == "number" then
			if X2 >= 0 then
				CTrigger(PlayerID,{CVar("X",CA[8],AtLeast,X2),CVar("X",CA[8],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TTOR({CVar("X",CA[8],AtLeast,X2),CVar("X",CA[8],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[5],AtLeast,0x80000000))
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[8],AtLeast,V(CB[5])),CVar("X",CA[8],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TCVar("X",CA[8],AtLeast,V(CB[5])),CVar("X",CA[8],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if Y1 ~= nil then
		if type(Y1) == "number" then
			if Y1 >= 0 then
				CTrigger(PlayerID,{TTOR({CVar("X",CA[9],AtMost,Y1),CVar("X",CA[9],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{CVar("X",CA[9],AtMost,Y1),CVar("X",CA[9],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[6],AtLeast,0x80000000))
				CTrigger(PlayerID,{TCVar("X",CA[9],AtMost,V(CB[6])),CVar("X",CA[9],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[9],AtMost,V(CB[6])),CVar("X",CA[9],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if Y2 ~= nil then
		if type(Y2) == "number" then
			if Y2 >= 0 then
				CTrigger(PlayerID,{CVar("X",CA[9],AtLeast,Y2),CVar("X",CA[9],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TTOR({CVar("X",CA[9],AtLeast,Y2),CVar("X",CA[9],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[7],AtLeast,0x80000000))
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[9],AtLeast,V(CB[7])),CVar("X",CA[9],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TCVar("X",CA[9],AtLeast,V(CB[7])),CVar("X",CA[9],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end
end

function CA_CropRA(R1,R2,A1,A2)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if R1 ~= nil and type(R1) ~= "number" then
		CMov(PlayerID,V(CB[6]),R1)
	end
	if R2 ~= nil and type(R2) ~= "number" then
		CMov(PlayerID,V(CB[7]),R2)
	end
	if A1 ~= nil and type(A1) ~= "number" then
		CMov(PlayerID,V(CB[8]),A1)
	end
	if A2 ~= nil and type(A2) ~= "number" then
		CMov(PlayerID,V(CB[9]),A2)
	end
	f_Atan2(PlayerID,V(CA[9]),V(CA[8]),V(CB[4]))
	f_Sqrt(PlayerID,V(CB[5]),_Add(_mul(V(CA[8]),V(CA[8])),_mul(V(CA[9]),V(CA[9]))))

	if A1 ~= nil then
		if type(A1) == "number" then
			if A1 >= 0 then
				CTrigger(PlayerID,{TTOR({CVar("X",CB[4],AtMost,A1),CVar("X",CB[4],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{CVar("X",CB[4],AtMost,A1),CVar("X",CB[4],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[8],AtLeast,0x80000000))
				CTrigger(PlayerID,{TCVar("X",CB[4],AtMost,V(CB[8])),CVar("X",CB[4],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TTOR({_TCVar("X",CB[4],AtMost,V(CB[8])),CVar("X",CB[4],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if A2 ~= nil then
		if type(A2) == "number" then
			if A2 >= 0 then
				CTrigger(PlayerID,{CVar("X",CB[4],AtLeast,A2),CVar("X",CB[4],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TTOR({CVar("X",CB[4],AtLeast,A2),CVar("X",CB[4],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[9],AtLeast,0x80000000))
				CTrigger(PlayerID,{TTOR({_TCVar("X",CB[4],AtLeast,V(CB[9])),CVar("X",CB[4],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TCVar("X",CB[4],AtLeast,V(CB[9])),CVar("X",CB[4],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if R1 ~= nil then
		if type(R1) == "number" then
			if R1 >= 0 then
				CTrigger(PlayerID,{TTOR({CVar("X",CB[5],AtMost,R1),CVar("X",CB[5],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{CVar("X",CB[5],AtMost,R1),CVar("X",CB[5],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[6],AtLeast,0x80000000))
				CTrigger(PlayerID,{TCVar("X",CB[5],AtMost,V(CB[6])),CVar("X",CB[5],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TTOR({_TCVar("X",CB[5],AtMost,V(CB[6])),CVar("X",CB[5],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if R2 ~= nil then
		if type(R2) == "number" then
			if R2 >= 0 then
				CTrigger(PlayerID,{CVar("X",CB[5],AtLeast,R2),CVar("X",CB[5],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TTOR({CVar("X",CB[5],AtLeast,R2),CVar("X",CB[5],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[7],AtLeast,0x80000000))
				CTrigger(PlayerID,{TTOR({_TCVar("X",CB[5],AtLeast,V(CB[7])),CVar("X",CB[5],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TCVar("X",CB[5],AtLeast,V(CB[7])),CVar("X",CB[5],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------

function CAPlotForward()
	return {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+14,CAPlotVarAlloc+15,CAPlotVarAlloc+16}
end
function CAPlotOrderForward()
	return {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+14,CAPlotVarAlloc+15,CAPlotVarAlloc+16,CAPlotVarAlloc+24,CAPlotVarAlloc+25}
end

-- function CAfunc(Table) local CA = CAPlotDataArr -- Custom Code Section -- end
function CAPlot(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve,CAfunc2)
	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ArrSize
	if type(Shape[1]) ~= "number" then
		local Sizemax = Shape[1][1]
		for i = 1, #Shape do
			if Shape[i][1] > Sizemax then
				Sizemax = Shape[i][1]
			end
		end
		Arrsize = Sizemax
	else
		Arrsize = Shape[1]
	end

	local TempAct = {}
	local PlotArrX
	local PlotArrY
	CJump(PlayerID,CAPlotJumpAlloc)
		PlotArrX = CArray(PlayerID,Arrsize)
		PlotArrY = CArray(PlayerID,Arrsize)
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				table.insert(TempAct,{})
				for j = 1, Shape[i][1] do
					table.insert(TempAct[i],SetMemX(Arr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
				end
				table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
			end
		else
			for i = 1, Shape[1] do
				table.insert(TempAct,SetMemX(Arr(PlotArrX,i),SetTo,Shape[i+1][1]))
				table.insert(TempAct,SetMemX(Arr(PlotArrY,i),SetTo,Shape[i+1][2]))
			end
			table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
		end
		if type(Preset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
		if type(Preset[3]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
		else
			CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
		if type(Preset[5]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
		else
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------
		CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
		CAPlotVarAlloc = CAPlotVarAlloc + 4
		CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
		CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
		CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	if type(Preset[1]) ~= "number" then
		CMov(PlayerID,V(CA[1]),Preset[1])
	end
	if type(Preset[2]) ~= "number" then
		CMov(PlayerID,V(CA[2]),Preset[2])
	end
	if type(Preset[3]) ~= "number" then
		CMov(PlayerID,V(CA[3]),Preset[3])
	end
	if type(Preset[4]) ~= "number" then
		CMov(PlayerID,V(CA[4]),Preset[4])
	end
	if type(Preset[5]) ~= "number" then
		CMov(PlayerID,V(CA[5]),Preset[5])
	end
	if type(Preset[6]) ~= "number" then
		CMov(PlayerID,V(CA[6]),Preset[6])
	end
	if Preset[7] ~= nil then
		CMov(PlayerID,V(CB[1]),Preset[7])
	end
	if Preset[8] ~= nil then
		CMov(PlayerID,V(CB[2]),Preset[8])
	end
	if Preset[9] ~= nil then
		CMov(PlayerID,V(CB[3]),Preset[9])
	end

	CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,TempAct)
		end
	CIfEnd()

	NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
			ConvertArr(PlayerID,V(CA[7]),V(CA[6]))
			f_Read(PlayerID,ArrX(PlotArrX,V(CA[7])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrY,V(CA[7])),V(CA[9]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
			CAPlotPlayerID = PlayerID
			CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
			CAPlotVarAlloc = CAPlotVarAlloc + 7
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end

			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)
			CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location+1,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
			if CAfunc2 ~= nil then
				_G[CAfunc2]()
			end
			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			end
			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{Preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CAPlotWithProperties(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve,Properties)
		if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ArrSize
	if type(Shape[1]) ~= "number" then
		local Sizemax = Shape[1][1]
		for i = 1, #Shape do
			if Shape[i][1] > Sizemax then
				Sizemax = Shape[i][1]
			end
		end
		Arrsize = Sizemax
	else
		Arrsize = Shape[1]
	end

	local TempAct = {}
	local PlotArrX
	local PlotArrY
	CJump(PlayerID,CAPlotJumpAlloc)
		PlotArrX = CArray(PlayerID,Arrsize)
		PlotArrY = CArray(PlayerID,Arrsize)
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				table.insert(TempAct,{})
				for j = 1, Shape[i][1] do
					table.insert(TempAct[i],SetMemX(Arr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
				end
				table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
			end
		else
			for i = 1, Shape[1] do
				table.insert(TempAct,SetMemX(Arr(PlotArrX,i),SetTo,Shape[i+1][1]))
				table.insert(TempAct,SetMemX(Arr(PlotArrY,i),SetTo,Shape[i+1][2]))
			end
			table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
		end
		if type(Preset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
		if type(Preset[3]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
		else
			CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
		if type(Preset[5]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
		else
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------
		CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
		CAPlotVarAlloc = CAPlotVarAlloc + 4
		CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
		CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
		CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	if type(Preset[1]) ~= "number" then
		CMov(PlayerID,V(CA[1]),Preset[1])
	end
	if type(Preset[2]) ~= "number" then
		CMov(PlayerID,V(CA[2]),Preset[2])
	end
	if type(Preset[3]) ~= "number" then
		CMov(PlayerID,V(CA[3]),Preset[3])
	end
	if type(Preset[4]) ~= "number" then
		CMov(PlayerID,V(CA[4]),Preset[4])
	end
	if type(Preset[5]) ~= "number" then
		CMov(PlayerID,V(CA[5]),Preset[5])
	end
	if type(Preset[6]) ~= "number" then
		CMov(PlayerID,V(CA[6]),Preset[6])
	end
	if Preset[7] ~= nil then
		CMov(PlayerID,V(CB[1]),Preset[7])
	end
	if Preset[8] ~= nil then
		CMov(PlayerID,V(CB[2]),Preset[8])
	end
	if Preset[9] ~= nil then
		CMov(PlayerID,V(CB[3]),Preset[9])
	end

	CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,TempAct)
		end
	CIfEnd()

	NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
			ConvertArr(PlayerID,V(CA[7]),V(CA[6]))
			f_Read(PlayerID,ArrX(PlotArrX,V(CA[7])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrY,V(CA[7])),V(CA[9]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
			CAPlotPlayerID = PlayerID
			CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
			CAPlotVarAlloc = CAPlotVarAlloc + 7
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end
			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)
			CDoActions(PlayerID,{TCreateUnitWithProperties(V(CB[1]),V(CB[2]),Location+1,V(CB[3]),Properties),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			end
			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{Preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CAPlotOrder(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,OrderShape,OrderType,OrderLocation,DestXY,OrderPreset,CBfunc,OrderSize,PlayerID,Condition,PerAction,Preserve)
	if Shape == nil then
		CS_InputError()
	end
	if OrderShape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local OLocId = OrderLocation
	if type(OrderLocation) == "string" then
		OLocId = ParseLocation(OLocId)-1
	end
	local OLocL = 0x58DC60+0x14*OLocId
	local OLocU = 0x58DC64+0x14*OLocId
	local OLocR = 0x58DC68+0x14*OLocId
	local OLocD = 0x58DC6C+0x14*OLocId

	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local CC = {CAPlotVarAlloc+24,CAPlotVarAlloc+25,CAPlotVarAlloc+26,CAPlotVarAlloc+27,CAPlotVarAlloc+28,CAPlotVarAlloc+29,CAPlotVarAlloc+30}
	local ArrSize
	if type(Shape[1]) ~= "number" then
		local Sizemax = Shape[1][1]
		for i = 1, #Shape do
			if Shape[i][1] > Sizemax then
				Sizemax = Shape[i][1]
			end
		end
		Arrsize = Sizemax
	else
		Arrsize = Shape[1]
	end

	local OArrSize
	if type(OrderShape[1]) ~= "number" then
		local Sizemax = OrderShape[1][1]
		for i = 1, #OrderShape do
			if OrderShape[i][1] > Sizemax then
				Sizemax = OrderShape[i][1]
			end
		end
		OArrsize = Sizemax
	else
		OArrsize = OrderShape[1]
	end

	local TempAct = {}
	local OrderAct = {}
	local PlotArrX
	local PlotArrY
	local OrderArrX
	local OrderArrY
	CJump(PlayerID,CAPlotJumpAlloc)
		PlotArrX = CArray(PlayerID,Arrsize)
		PlotArrY = CArray(PlayerID,Arrsize)
		OrderArrX = CArray(PlayerID,OArrsize)
		OrderArrY = CArray(PlayerID,OArrsize)
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				table.insert(TempAct,{})
				for j = 1, Shape[i][1] do
					table.insert(TempAct[i],SetMemX(Arr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
				end
				table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
			end
		else
			for i = 1, Shape[1] do
				table.insert(TempAct,SetMemX(Arr(PlotArrX,i),SetTo,Shape[i+1][1]))
				table.insert(TempAct,SetMemX(Arr(PlotArrY,i),SetTo,Shape[i+1][2]))
			end
			table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
		end
		if type(OrderShape[1]) ~= "number" then
			for i = 1, #OrderShape do
				table.insert(OrderAct,{})
				for j = 1, OrderShape[i][1] do
					table.insert(OrderAct[i],SetMemX(Arr(OrderArrX,j),SetTo,OrderShape[i][j+1][1]))
					table.insert(OrderAct[i],SetMemX(Arr(OrderArrY,j),SetTo,OrderShape[i][j+1][2]))
				end
				table.insert(OrderAct[i],SetCVar("X",CC[1],SetTo,0))
			end
		else
			for i = 1, OrderShape[1] do
				table.insert(OrderAct,SetMemX(Arr(OrderArrX,i),SetTo,OrderShape[i+1][1]))
				table.insert(OrderAct,SetMemX(Arr(OrderArrY,i),SetTo,OrderShape[i+1][2]))
			end
			table.insert(OrderAct,SetCVar("X",CC[1],SetTo,0))
		end
		if type(Preset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
		if type(Preset[3]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
		else
			CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
		if type(Preset[5]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
		else
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------
		CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
		CAPlotVarAlloc = CAPlotVarAlloc + 4
		CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
		CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
		CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		if type(OrderPreset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+10,"X",SetTo,OrderPreset[1]) -- Selected Order Shape (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+10) -- Selected Order Shape (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+11,"X",SetTo,1) -- Order Cur Index (가변)
		CVariable(PlayerID,CAPlotVarAlloc+12) -- Temp Order Index
		CVariable(PlayerID,CAPlotVarAlloc+13)
		CVariable(PlayerID,CAPlotVarAlloc+14)
		CVariable(PlayerID,CAPlotVarAlloc+15)
		CVariable(PlayerID,CAPlotVarAlloc+16)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	if type(Preset[1]) ~= "number" then
		CMov(PlayerID,V(CA[1]),Preset[1])
	end
	if type(Preset[2]) ~= "number" then
		CMov(PlayerID,V(CA[2]),Preset[2])
	end
	if type(Preset[3]) ~= "number" then
		CMov(PlayerID,V(CA[3]),Preset[3])
	end
	if type(Preset[4]) ~= "number" then
		CMov(PlayerID,V(CA[4]),Preset[4])
	end
	if type(Preset[5]) ~= "number" then
		CMov(PlayerID,V(CA[5]),Preset[5])
	end
	if type(Preset[6]) ~= "number" then
		CMov(PlayerID,V(CA[6]),Preset[6])
	end
	if Preset[7] ~= nil then
		CMov(PlayerID,V(CB[1]),Preset[7])
	end
	if Preset[8] ~= nil then
		CMov(PlayerID,V(CB[2]),Preset[8])
	end
	if Preset[9] ~= nil then
		CMov(PlayerID,V(CB[3]),Preset[9])
	end
	if type(OrderPreset[1]) ~= "number" then
		CMov(PlayerID,V(CC[1]),OrderPreset[1])
	end
	if type(OrderPreset[2]) ~= "number" then
		CMov(PlayerID,V(CC[2]),OrderPreset[2])
	end

	CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,TempAct)
		end
	CIfEnd()

	CIf(PlayerID,CVar("X",CC[1],AtLeast,1))
		if type(OrderShape[1]) ~= "number" then
			for i = 1, #OrderShape do
				Trigger2X(PlayerID,CVar("X",CC[1],Exactly,i),OrderAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,OrderAct)
		end
	CIfEnd()

	NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
			ConvertArr(PlayerID,V(CA[7]),V(CA[6]))
			f_Read(PlayerID,ArrX(PlotArrX,V(CA[7])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrY,V(CA[7])),V(CA[9]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
			CAPlotPlayerID = PlayerID
			CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
			CAPlotVarAlloc = CAPlotVarAlloc + 14
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end

			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)
			CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})

	-------------------------------------------------------------------------
			ConvertArr(PlayerID,V(CC[3]),V(CC[2]))
			f_Read(PlayerID,ArrX(OrderArrX,V(CC[3])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(OrderArrY,V(CC[3])),V(CA[9]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			if CBfunc ~= nil then
				_G[CBfunc]()
			end

			if DestXY == nil then
				f_Read(PlayerID,OLocL,V(CC[4]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,OLocR,V(CC[5]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,OLocU,V(CC[6]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,OLocD,V(CC[7]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CC[4]),V(CC[5])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CC[6]),V(CC[7])),2))
			else
				CAdd(PlayerID,V(CA[8]),DestXY[1])
				CAdd(PlayerID,V(CA[9]),DestXY[2])
			end

			CAdd(PlayerID,LocL,PlotSize-OrderSize[1])
			CAdd(PlayerID,LocR,-PlotSize+OrderSize[1])
			CAdd(PlayerID,LocU,PlotSize-OrderSize[1])
			CAdd(PlayerID,LocD,-PlotSize+OrderSize[1])

			CMov(PlayerID,OLocL,V(CA[8]),-OrderSize[2])
			CMov(PlayerID,OLocR,V(CA[8]),OrderSize[2])
			CMov(PlayerID,OLocU,V(CA[9]),-OrderSize[2])
			CMov(PlayerID,OLocD,V(CA[9]),OrderSize[2])
			CDoActions(PlayerID,{TOrder(V(CB[2]),V(CB[3]),Location,OrderType,OrderLocation),SetCVar("X",CB[10],SetTo,0),SetCVar("X",CC[2],Add,1),PerAction})

			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			end

			if DestXY == nil then
				CMov(PlayerID,OLocL,V(CC[4]))
				CMov(PlayerID,OLocR,V(CC[5]))
				CMov(PlayerID,OLocU,V(CC[6]))
				CMov(PlayerID,OLocD,V(CC[7]))
			end

			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),SetCVar("X",CC[2],SetTo,1),{Preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),SetCVar("X",CC[2],SetTo,1),Preserve},{Preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3],CC[1],CC[2]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CAPlotOrderWithProperties(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,OrderShape,OrderType,OrderLocation,DestXY,OrderPreset,CBfunc,OrderSize,PlayerID,Condition,PerAction,Preserve,Properties)
	if Shape == nil then
		CS_InputError()
	end
	if OrderShape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local OLocId = OrderLocation
	if type(OrderLocation) == "string" then
		OLocId = ParseLocation(OLocId)-1
	end
	local OLocL = 0x58DC60+0x14*OLocId
	local OLocU = 0x58DC64+0x14*OLocId
	local OLocR = 0x58DC68+0x14*OLocId
	local OLocD = 0x58DC6C+0x14*OLocId

	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local CC = {CAPlotVarAlloc+24,CAPlotVarAlloc+25,CAPlotVarAlloc+26,CAPlotVarAlloc+27,CAPlotVarAlloc+28,CAPlotVarAlloc+29,CAPlotVarAlloc+30}
	local ArrSize
	if type(Shape[1]) ~= "number" then
		local Sizemax = Shape[1][1]
		for i = 1, #Shape do
			if Shape[i][1] > Sizemax then
				Sizemax = Shape[i][1]
			end
		end
		Arrsize = Sizemax
	else
		Arrsize = Shape[1]
	end

	local OArrSize
	if type(OrderShape[1]) ~= "number" then
		local Sizemax = OrderShape[1][1]
		for i = 1, #OrderShape do
			if OrderShape[i][1] > Sizemax then
				Sizemax = OrderShape[i][1]
			end
		end
		OArrsize = Sizemax
	else
		OArrsize = OrderShape[1]
	end

	local TempAct = {}
	local OrderAct = {}
	local PlotArrX
	local PlotArrY
	local OrderArrX
	local OrderArrY
	CJump(PlayerID,CAPlotJumpAlloc)
		PlotArrX = CArray(PlayerID,Arrsize)
		PlotArrY = CArray(PlayerID,Arrsize)
		OrderArrX = CArray(PlayerID,OArrsize)
		OrderArrY = CArray(PlayerID,OArrsize)
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				table.insert(TempAct,{})
				for j = 1, Shape[i][1] do
					table.insert(TempAct[i],SetMemX(Arr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
				end
				table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
			end
		else
			for i = 1, Shape[1] do
				table.insert(TempAct,SetMemX(Arr(PlotArrX,i),SetTo,Shape[i+1][1]))
				table.insert(TempAct,SetMemX(Arr(PlotArrY,i),SetTo,Shape[i+1][2]))
			end
			table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
		end
		if type(OrderShape[1]) ~= "number" then
			for i = 1, #OrderShape do
				table.insert(OrderAct,{})
				for j = 1, OrderShape[i][1] do
					table.insert(OrderAct[i],SetMemX(Arr(OrderArrX,j),SetTo,OrderShape[i][j+1][1]))
					table.insert(OrderAct[i],SetMemX(Arr(OrderArrY,j),SetTo,OrderShape[i][j+1][2]))
				end
				table.insert(OrderAct[i],SetCVar("X",CC[1],SetTo,0))
			end
		else
			for i = 1, OrderShape[1] do
				table.insert(OrderAct,SetMemX(Arr(OrderArrX,i),SetTo,OrderShape[i+1][1]))
				table.insert(OrderAct,SetMemX(Arr(OrderArrY,i),SetTo,OrderShape[i+1][2]))
			end
			table.insert(OrderAct,SetCVar("X",CC[1],SetTo,0))
		end
		if type(Preset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
		if type(Preset[3]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
		else
			CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
		if type(Preset[5]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
		else
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------
		CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
		CAPlotVarAlloc = CAPlotVarAlloc + 4
		CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
		CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
		CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		if type(OrderPreset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+10,"X",SetTo,OrderPreset[1]) -- Selected Order Shape (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+10) -- Selected Order Shape (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+11,"X",SetTo,1) -- Order Cur Index (가변)
		CVariable(PlayerID,CAPlotVarAlloc+12) -- Temp Order Index
		CVariable(PlayerID,CAPlotVarAlloc+13)
		CVariable(PlayerID,CAPlotVarAlloc+14)
		CVariable(PlayerID,CAPlotVarAlloc+15)
		CVariable(PlayerID,CAPlotVarAlloc+16)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	if type(Preset[1]) ~= "number" then
		CMov(PlayerID,V(CA[1]),Preset[1])
	end
	if type(Preset[2]) ~= "number" then
		CMov(PlayerID,V(CA[2]),Preset[2])
	end
	if type(Preset[3]) ~= "number" then
		CMov(PlayerID,V(CA[3]),Preset[3])
	end
	if type(Preset[4]) ~= "number" then
		CMov(PlayerID,V(CA[4]),Preset[4])
	end
	if type(Preset[5]) ~= "number" then
		CMov(PlayerID,V(CA[5]),Preset[5])
	end
	if type(Preset[6]) ~= "number" then
		CMov(PlayerID,V(CA[6]),Preset[6])
	end
	if Preset[7] ~= nil then
		CMov(PlayerID,V(CB[1]),Preset[7])
	end
	if Preset[8] ~= nil then
		CMov(PlayerID,V(CB[2]),Preset[8])
	end
	if Preset[9] ~= nil then
		CMov(PlayerID,V(CB[3]),Preset[9])
	end
	if type(OrderPreset[1]) ~= "number" then
		CMov(PlayerID,V(CC[1]),OrderPreset[1])
	end
	if type(OrderPreset[2]) ~= "number" then
		CMov(PlayerID,V(CC[2]),OrderPreset[2])
	end

	CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,TempAct)
		end
	CIfEnd()

	CIf(PlayerID,CVar("X",CC[1],AtLeast,1))
		if type(OrderShape[1]) ~= "number" then
			for i = 1, #OrderShape do
				Trigger2X(PlayerID,CVar("X",CC[1],Exactly,i),OrderAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,OrderAct)
		end
	CIfEnd()

	NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
			ConvertArr(PlayerID,V(CA[7]),V(CA[6]))
			f_Read(PlayerID,ArrX(PlotArrX,V(CA[7])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrY,V(CA[7])),V(CA[9]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
			CAPlotPlayerID = PlayerID
			CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
			CAPlotVarAlloc = CAPlotVarAlloc + 14
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end

			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)
			CDoActions(PlayerID,{TCreateUnitWithProperties(V(CB[1]),V(CB[2]),Location,V(CB[3]),Properties),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})

	-------------------------------------------------------------------------
			ConvertArr(PlayerID,V(CC[3]),V(CC[2]))
			f_Read(PlayerID,ArrX(OrderArrX,V(CC[3])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(OrderArrY,V(CC[3])),V(CA[9]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			if CBfunc ~= nil then
				_G[CBfunc]()
			end

			if DestXY == nil then
				f_Read(PlayerID,OLocL,V(CC[4]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,OLocR,V(CC[5]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,OLocU,V(CC[6]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,OLocD,V(CC[7]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CC[4]),V(CC[5])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CC[6]),V(CC[7])),2))
			else
				CAdd(PlayerID,V(CA[8]),DestXY[1])
				CAdd(PlayerID,V(CA[9]),DestXY[2])
			end

			CAdd(PlayerID,LocL,PlotSize-OrderSize[1])
			CAdd(PlayerID,LocR,-PlotSize+OrderSize[1])
			CAdd(PlayerID,LocU,PlotSize-OrderSize[1])
			CAdd(PlayerID,LocD,-PlotSize+OrderSize[1])

			CMov(PlayerID,OLocL,V(CA[8]),-OrderSize[2])
			CMov(PlayerID,OLocR,V(CA[8]),OrderSize[2])
			CMov(PlayerID,OLocU,V(CA[9]),-OrderSize[2])
			CMov(PlayerID,OLocD,V(CA[9]),OrderSize[2])
			CDoActions(PlayerID,{TOrder(V(CB[2]),V(CB[3]),Location,OrderType,OrderLocation),SetCVar("X",CB[10],SetTo,0),SetCVar("X",CC[2],Add,1),PerAction})

			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			end

			if DestXY == nil then
				CMov(PlayerID,OLocL,V(CC[4]))
				CMov(PlayerID,OLocR,V(CC[5]))
				CMov(PlayerID,OLocU,V(CC[6]))
				CMov(PlayerID,OLocD,V(CC[7]))
			end

			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),SetCVar("X",CC[2],SetTo,1),{Preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),SetCVar("X",CC[2],SetTo,1),Preserve},{Preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3],CC[1],CC[2]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CXPlot 류 함수

function CXMakeShape(Ratio,PathData,...)
	local XRatio
	local YRatio
	local ZRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
		ZRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
		if Ratio[3] == nil then
			ZRatio = 1
		else
			ZRatio = Ratio[3]
		end
	end

	if type(PathData[2]) == "number" then
		PathData = {PathData}
	end
	local arg = table.pack(...)
	for k = 1, arg.n do
		table.insert(PathData,arg[k])
	end
	local Shape = {}
	for k, v in pairs(PathData) do
		v[1] = v[1] * XRatio
		v[2] = v[2] * YRatio
		v[3] = v[3] * ZRatio
		Shape[k+1] = v
	end
	Shape[1] = #PathData
	return Shape
end

function CXAdd(Shape,Ratio,PathData,...)
	local XRatio
	local YRatio
	local ZRatio
	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
		ZRatio = Ratio
	else
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
		if Ratio[3] == nil then
			ZRatio = 1
		else
			ZRatio = Ratio[3]
		end
	end
	local Count = 0
	if type(PathData[2]) == "number" then
		PathData = {PathData}
	end
	local arg = table.pack(...)
	for k = 1, arg.n do
		table.insert(PathData,arg[k])
	end

	local RetShape = {0}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end
	for k, v in pairs(PathData) do
		v[1] = v[1] * XRatio
		v[2] = v[2] * YRatio
		v[3] = v[3] * ZRatio
		table.insert(RetShape,v)
		Count = Count + 1
	end
	RetShape[1] = Shape[1] + Count
	return RetShape
end

function CXOverlap(ShapeA,ShapeB)
	if ShapeA == nil then
		CX_InputError()
	end
	if ShapeB == nil then
		CX_InputError()
	end
	local RetShape = {ShapeA[1]+ShapeB[1]}

	for i = 1, ShapeA[1] do
		local NX, NY, NZ
		NX = ShapeA[i+1][1]
		NY = ShapeA[i+1][2]
		NZ = ShapeA[i+1][3]
		table.insert(RetShape,{NX,NY,NZ})
	end
	for i = 1, ShapeB[1] do
		local NX, NY, NZ
		NX = ShapeB[i+1][1]
		NY = ShapeB[i+1][2]
		NZ = ShapeB[i+1][3]
		table.insert(RetShape,{NX,NY,NZ})
	end
	return RetShape	
end

function CXConvertShape(Shape,Ratio,Zfunc)
	local XRatio
	local YRatio
	local ZRatio
	local Check = 0
	if Ratio == nil then 
		Check = 1
	end

	if type(Ratio) == "number" then
		XRatio = Ratio
		YRatio = Ratio
		ZRatio = Ratio
	elseif Ratio ~= nil then
		if Ratio[1] == nil then
			XRatio = 1
		else
			XRatio = Ratio[1]
		end
		if Ratio[2] == nil then
			YRatio = 1
		else
			YRatio = Ratio[2]
		end
		if Ratio[3] == nil then
			ZRatio = 1
		else
			ZRatio = Ratio[3]
		end
	end
	local NX, NY, NZ
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		if Check == 0 then
			NZ = (_G[Zfunc](NX/XRatio,NY/YRatio))*ZRatio
		else
			NZ = _G[Zfunc](NX,NY)
		end
		table.insert(RetShape,{NX,NY,NZ})
	end
	return RetShape
end

function CXMakePolyhedron(Face,Size,Number)
	local Polyhedron, Length, Arr
	local gold = (math.sqrt(5)+1)/2
	if Face == 4 then
		Length = 2*math.sqrt(2)
		Polyhedron = {4,{1,1,1},{1,-1,-1},{-1,1,-1},{-1,-1,1}}
		Arr = {{1,2},{1,3},{1,4},{2,3},{2,4},{3,4}}
	elseif Face == 6 then
		Length = 2
		Polyhedron = {8,{1,1,1},{1,1,-1},{1,-1,1},{-1,1,1},{1,-1,-1},{-1,1,-1},{-1,-1,1},{-1,-1,-1}}
		Arr = {{1,2},{1,3},{1,4},{2,5},{2,6},{3,5},{3,7},{4,6},{4,7},{5,8},{6,8},{7,8}}
	elseif Face == 8 then
		Length = math.sqrt(2)
		Polyhedron = {6,{1,0,0},{-1,0,0},{0,1,0},{0,-1,0},{0,0,1},{0,0,-1}}
		Arr = {{1,3},{1,4},{1,5},{1,6},{2,3},{2,4},{2,5},{2,6},{3,5},{3,6},{4,5},{4,6}}
	elseif Face == 12 then
		Length = math.sqrt(1+(1-1/gold)^2+(gold-1)^2)
		Polyhedron = {20,{1,1,1},{1,1,-1},{1,-1,1},{-1,1,1},{1,-1,-1},{-1,1,-1},{-1,-1,1},{-1,-1,-1},{1/gold,0,gold},{-1/gold,0,gold},{1/gold,0,-gold},{-1/gold,0,-gold},{0,gold,1/gold},{0,gold,-1/gold},{0,-gold,1/gold},{0,-gold,-1/gold},{gold,1/gold,0},{gold,-1/gold,0},{-gold,1/gold,0},{-gold,-1/gold,0}}
		Arr = {{1,9},{1,13},{1,17},{2,11},{2,14},{2,17},{3,9},{3,15},{3,18},{4,10},{4,13},{4,19},{5,11},{5,16},{5,18},{6,12},{6,14},{6,19},{7,10},{7,15},{7,20},{8,12},{8,16},{8,20},{9,10},{11,12},{13,14},{15,16},{17,18},{19,20}}
	elseif Face == 20 then
		Length = 2
		Polyhedron = {12,{0,1,gold},{0,-1,gold},{0,1,-gold},{0,-1,-gold},{1,gold,0},{-1,gold,0},{1,-gold,0},{-1,-gold,0},{gold,0,1},{gold,0,-1},{-gold,0,1},{-gold,0,-1}}
		Arr = {{2,1},{2,9},{2,7},{2,8},{2,11},{3,5},{3,10},{3,4},{3,12},{3,6},{1,6},{1,5},{9,5},{9,10},{7,10},{7,4},{8,4},{8,12},{11,12},{11,6},{1,9},{9,7},{7,8},{8,11},{11,1},{6,5},{5,10},{10,4},{4,12},{12,6}}
	else
		Length = 2/3
		local Icosahedron = {12,{0,1,gold},{0,-1,gold},{0,1,-gold},{0,-1,-gold},{1,gold,0},{-1,gold,0},{1,-gold,0},{-1,-gold,0},{gold,0,1},{gold,0,-1},{-gold,0,1},{-gold,0,-1}}
		local Cut = {{1,2},{1,9},{1,11},{1,5},{1,6},{9,1},{9,2},{9,7},{9,5},{9,10},{7,9},{7,2},{7,8},{7,10},{7,4},{8,7},{8,2},{8,11},{8,4},{8,12},{11,8},{11,2},{11,1},{11,12},{11,6},{2,1},{2,9},{2,7},{2,8},{2,11},{6,5},{6,3},{6,12},{6,1},{6,11},{5,6},{5,3},{5,10},{5,1},{5,9},{10,5},{10,3},{10,4},{10,9},{10,7},{4,10},{4,3},{4,12},{4,7},{4,8},{12,4},{12,3},{12,6},{12,8},{12,11},{3,6},{3,5},{3,10},{3,4},{3,12}}
		Polyhedron = {0}
		for i = 1, #Cut do
			local ptr1, ptr2
			pt1 = Cut[i][1]+1 -- 꼭짓점
			pt2 = Cut[i][2]+1 -- 밑면
			local NX, NY, NZ
			NX = (2*Icosahedron[pt1][1]+Icosahedron[pt2][1])/3
			NY = (2*Icosahedron[pt1][2]+Icosahedron[pt2][2])/3
			NZ = (2*Icosahedron[pt1][3]+Icosahedron[pt2][3])/3
			table.insert(Polyhedron,{NX,NY,NZ})
			Polyhedron[1] = Polyhedron[1] + 1
		end
		Arr = nil
	end

	if Number ~= nil and Arr ~= nil then
		local pt1, pt2
		if type(Number) == "number" then 
			if Number <= 0 then
				CX_InputError()
			end

			for i = 1, #Arr do
				pt1 = Arr[i][1]+1
				pt2 = Arr[i][2]+1
				for j = 1, Number do
					local NX, NY, NZ
					NX = (j*Polyhedron[pt1][1]+(Number-j+1)*Polyhedron[pt2][1])/(Number+1)
					NY = (j*Polyhedron[pt1][2]+(Number-j+1)*Polyhedron[pt2][2])/(Number+1)
					NZ = (j*Polyhedron[pt1][3]+(Number-j+1)*Polyhedron[pt2][3])/(Number+1)
					table.insert(Polyhedron,{NX,NY,NZ})
					Polyhedron[1] = Polyhedron[1] + 1
				end
			end
		else
			local PerSize = Number[1]
			if PerSize <= 0 then
				CX_InputError()
			end
			PerSize = PerSize^2
			local TLength
			local PerNumber
			for i = 1, #Arr do
				pt1 = Arr[i][1]+1
				pt2 = Arr[i][2]+1 
				TLength = (Polyhedron[pt1][1]-Polyhedron[pt2][1])^2+(Polyhedron[pt1][2]-Polyhedron[pt2][2])^2+(Polyhedron[pt1][3]-Polyhedron[pt2][3])^2
				PerNumber = math.floor(math.sqrt(TLength/PerSize)+0.5)
				for j = 1, PerNumber do
					local NX, NY, NZ
					NX = (j*Polyhedron[pt1][1]+(PerNumber-j+1)*Polyhedron[pt2][1])/(PerNumber+1)
					NY = (j*Polyhedron[pt1][2]+(PerNumber-j+1)*Polyhedron[pt2][2])/(PerNumber+1)
					NZ = (j*Polyhedron[pt1][3]+(PerNumber-j+1)*Polyhedron[pt2][3])/(PerNumber+1)
					table.insert(Polyhedron,{NX,NY,NZ})
					Polyhedron[1] = Polyhedron[1] + 1
				end
			end
		end
	end

	Polyhedron = CXRatio(Polyhedron,Size/Length,Size/Length,Size/Length)
	return Polyhedron
end

function CXMakePrism(Point,Radius,Angle,Height,FillXY,FillZ,TopMove,TopRatio)
	local Prism = {0}
	local Half = Height/2
	local Face = CSMakePolygon(Point,Radius,Angle,Point+1,1)
	local MoveX, MoveY, RatioX, RatioY
	if TopMove ~= nil then
		if TopMove[1] == nil then
			MoveX = 0
		end
		if TopMove[2] == nil then
			MoveY = 0
		end
	else
		MoveX = 0
		MoveY = 0
	end
	if TopRatio ~= nil then
		if TopRatio[1] == nil then
			RatioX = 1
		end
		if TopRatio[2] == nil then
			RatioY = 1
		end
	else
		RatioX = 1
		RatioY = 1
	end
	local TopFace = CS_MoveXY(CS_RatioXY(Face,RatioX,RatioY),MoveX,MoveY)

	for i = 1, Face[1] do
		table.insert(Prism,{TopFace[i+1][1],TopFace[i+1][2],Half})
		Prism[1] = Prism[1] + 1
	end
	for i = 1, Face[1] do
		table.insert(Prism,{Face[i+1][1],Face[i+1][2],-Half})
		Prism[1] = Prism[1] + 1
	end
	if FillXY ~= nil then
		if type(FillXY) == "number" then 
			if FillXY <= 0 then
				CX_InputError()
			end
			for i = 1, TopFace[1]-1 do
				for j = 1, FillXY do
					local NX, NY
					NX = (j*TopFace[i+1][1]+(FillXY-j+1)*TopFace[i+2][1])/(FillXY+1)
					NY = (j*TopFace[i+1][2]+(FillXY-j+1)*TopFace[i+2][2])/(FillXY+1)
					table.insert(Prism,{NX,NY,Half})
					Prism[1] = Prism[1] + 1
				end
			end
			for j = 1, FillXY do
				local NX, NY
				NX = (j*TopFace[TopFace[1]+1][1]+(FillXY-j+1)*TopFace[2][1])/(FillXY+1)
				NY = (j*TopFace[TopFace[1]+1][2]+(FillXY-j+1)*TopFace[2][2])/(FillXY+1)
				table.insert(Prism,{NX,NY,Half})
				Prism[1] = Prism[1] + 1
			end

			for i = 1, Face[1]-1 do
				for j = 1, FillXY do
					local NX, NY
					NX = (j*Face[i+1][1]+(FillXY-j+1)*Face[i+2][1])/(FillXY+1)
					NY = (j*Face[i+1][2]+(FillXY-j+1)*Face[i+2][2])/(FillXY+1)
					table.insert(Prism,{NX,NY,-Half})
					Prism[1] = Prism[1] + 1
				end
			end
			for j = 1, FillXY do
				local NX, NY
				NX = (j*Face[Face[1]+1][1]+(FillXY-j+1)*Face[2][1])/(FillXY+1)
				NY = (j*Face[Face[1]+1][2]+(FillXY-j+1)*Face[2][2])/(FillXY+1)
				table.insert(Prism,{NX,NY,-Half})
				Prism[1] = Prism[1] + 1
			end
		else
			local Size = FillXY[1]
			if Size <= 0 then
				CX_InputError()
			end
			Size = Size^2
			local Length
			local PerNumber
			for i = 1, TopFace[1]-1 do
				Length = (TopFace[i+2][1]-TopFace[i+1][1])^2+(TopFace[i+2][2]-TopFace[i+1][2])^2
				PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
				for j = 1, PerNumber do
					local NX, NY
					NX = (j*TopFace[i+1][1]+(PerNumber-j+1)*TopFace[i+2][1])/(PerNumber+1)
					NY = (j*TopFace[i+1][2]+(PerNumber-j+1)*TopFace[i+2][2])/(PerNumber+1)
					table.insert(Prism,{NX,NY,Half})
					Prism[1] = Prism[1] + 1
				end
			end
			Length = (TopFace[TopFace[1]+1][1]-TopFace[2][1])^2+(TopFace[TopFace[1]+1][2]-TopFace[2][2])^2
			PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
			for j = 1, PerNumber do
				local NX, NY
				NX = (j*TopFace[TopFace[1]+1][1]+(PerNumber-j+1)*TopFace[2][1])/(PerNumber+1)
				NY = (j*TopFace[TopFace[1]+1][2]+(PerNumber-j+1)*TopFace[2][2])/(PerNumber+1)
				table.insert(Prism,{NX,NY,Half})
				Prism[1] = Prism[1] + 1
			end

			for i = 1, Face[1]-1 do
				Length = (Face[i+2][1]-Face[i+1][1])^2+(Face[i+2][2]-Face[i+1][2])^2
				PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
				for j = 1, PerNumber do
					local NX, NY
					NX = (j*Face[i+1][1]+(PerNumber-j+1)*Face[i+2][1])/(PerNumber+1)
					NY = (j*Face[i+1][2]+(PerNumber-j+1)*Face[i+2][2])/(PerNumber+1)
					table.insert(Prism,{NX,NY,-Half})
					Prism[1] = Prism[1] + 1
				end
			end
			Length = (Face[Face[1]+1][1]-Face[2][1])^2+(Face[Face[1]+1][2]-Face[2][2])^2
			PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
			for j = 1, PerNumber do
				local NX, NY
				NX = (j*Face[Face[1]+1][1]+(PerNumber-j+1)*Face[2][1])/(PerNumber+1)
				NY = (j*Face[Face[1]+1][2]+(PerNumber-j+1)*Face[2][2])/(PerNumber+1)
				table.insert(Prism,{NX,NY,-Half})
				Prism[1] = Prism[1] + 1
			end
		end
	end
	if FillZ ~= nil then
		if type(FillZ) == "number" then 
			if FillZ <= 0 then
				CX_InputError()
			end

			for i = 1, Point do
				for j = 1, FillZ do
					local NX, NY, NZ
					NX = (j*TopFace[i+1][1]+(FillZ-j+1)*Face[i+1][1])/(FillZ+1)
					NY = (j*TopFace[i+1][2]+(FillZ-j+1)*Face[i+1][2])/(FillZ+1)
					NZ = (j*Half+(FillZ-j+1)*(-Half))/(FillZ+1)
					table.insert(Prism,{NX,NY,NZ})
					Prism[1] = Prism[1] + 1
				end
			end
		else
			local Size = FillZ[1]
			if Size <= 0 then
				CX_InputError()
			end
			Size = Size^2
			local Length
			local PerNumber
			for i = 1, Point do
				Length = (TopFace[i+1][1]-Face[i+1][1])^2+(TopFace[i+1][2]-Face[i+1][2])^2+(Height)^2
				PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
				for j = 1, PerNumber do
					local NX, NY, NZ
					NX = (j*TopFace[i+1][1]+(FillZ-j+1)*Face[i+1][1])/(FillZ+1)
					NY = (j*TopFace[i+1][2]+(FillZ-j+1)*Face[i+1][2])/(FillZ+1)
					NZ = (j*Half+(FillZ-j+1)*(-Half))/(FillZ+1)
					table.insert(Prism,{NX,NY,NZ})
					Prism[1] = Prism[1] + 1
				end
			end
		end
	end
	return Prism
end

function CXMakePyramid(Point,Radius,Angle,Height,FillXY,FillZ,TopMove)
	local Pyramid = {0}
	local Half = Height/2
	local Face = CSMakePolygon(Point,Radius,Angle,Point+1,1)
	local MoveX, MoveY
	if TopMove ~= nil then
		if TopMove[1] == nil then
			MoveX = 0
		end
		if TopMove[2] == nil then
			MoveY = 0
		end
	else
		MoveX = 0
		MoveY = 0
	end

	table.insert(Pyramid,{MoveX,MoveY,Half})
	Pyramid[1] = Pyramid[1] + 1

	for i = 1, Face[1] do
		table.insert(Pyramid,{Face[i+1][1],Face[i+1][2],-Half})
		Pyramid[1] = Pyramid[1] + 1
	end
	if FillXY ~= nil then
		if type(FillXY) == "number" then 
			if FillXY <= 0 then
				CX_InputError()
			end

			for i = 1, Face[1]-1 do
				for j = 1, FillXY do
					local NX, NY
					NX = (j*Face[i+1][1]+(FillXY-j+1)*Face[i+2][1])/(FillXY+1)
					NY = (j*Face[i+1][2]+(FillXY-j+1)*Face[i+2][2])/(FillXY+1)
					table.insert(Pyramid,{NX,NY,-Half})
					Pyramid[1] = Pyramid[1] + 1
				end
			end
			for j = 1, FillXY do
				local NX, NY
				NX = (j*Face[Face[1]+1][1]+(FillXY-j+1)*Face[2][1])/(FillXY+1)
				NY = (j*Face[Face[1]+1][2]+(FillXY-j+1)*Face[2][2])/(FillXY+1)
				table.insert(Pyramid,{NX,NY,-Half})
				Pyramid[1] = Pyramid[1] + 1
			end
		else
			local Size = FillXY[1]
			if Size <= 0 then
				CX_InputError()
			end
			Size = Size^2
			local Length
			local PerNumber

			for i = 1, Face[1]-1 do
				Length = (Face[i+2][1]-Face[i+1][1])^2+(Face[i+2][2]-Face[i+1][2])^2
				PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
				for j = 1, PerNumber do
					local NX, NY
					NX = (j*Face[i+1][1]+(PerNumber-j+1)*Face[i+2][1])/(PerNumber+1)
					NY = (j*Face[i+1][2]+(PerNumber-j+1)*Face[i+2][2])/(PerNumber+1)
					table.insert(Pyramid,{NX,NY,-Half})
					Pyramid[1] = Pyramid[1] + 1
				end
			end
			Length = (Face[Face[1]+1][1]-Face[2][1])^2+(Face[Face[1]+1][2]-Face[2][2])^2
			PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
			for j = 1, PerNumber do
				local NX, NY
				NX = (j*Face[Face[1]+1][1]+(PerNumber-j+1)*Face[2][1])/(PerNumber+1)
				NY = (j*Face[Face[1]+1][2]+(PerNumber-j+1)*Face[2][2])/(PerNumber+1)
				table.insert(Pyramid,{NX,NY,-Half})
				Pyramid[1] = Pyramid[1] + 1
			end
		end
	end
	if FillZ ~= nil then
		if type(FillZ) == "number" then 
			if FillZ <= 0 then
				CX_InputError()
			end

			for i = 1, Point do
				for j = 1, FillZ do
					local NX, NY, NZ
					NX = (j*MoveX+(FillZ-j+1)*Face[i+1][1])/(FillZ+1)
					NY = (j*MoveY+(FillZ-j+1)*Face[i+1][2])/(FillZ+1)
					NZ = (j*Half+(FillZ-j+1)*(-Half))/(FillZ+1)
					table.insert(Pyramid,{NX,NY,NZ})
					Pyramid[1] = Pyramid[1] + 1
				end
			end
		else
			local Size = FillZ[1]
			if Size <= 0 then
				CX_InputError()
			end
			Size = Size^2
			local Length
			local PerNumber
			for i = 1, Point do
				Length = (MoveX-Face[i+1][1])^2+(MoveY-Face[i+1][2])^2+(Height)^2
				PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
				for j = 1, PerNumber do
					local NX, NY, NZ
					NX = (j*MoveX+(FillZ-j+1)*Face[i+1][1])/(FillZ+1)
					NY = (j*MoveY+(FillZ-j+1)*Face[i+1][2])/(FillZ+1)
					NZ = (j*Half+(FillZ-j+1)*(-Half))/(FillZ+1)
					table.insert(Pyramid,{NX,NY,NZ})
					Pyramid[1] = Pyramid[1] + 1
				end
			end
		end
	end
	return Pyramid

end

function CXConnectPath(Shape,Number,Index)
	if Shape == nil then
		CX_InputError()
	end
	
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end

	if type(Number) == "number" then
		if Number <= 0 then
			CX_InputError()
		end
		
		for k, v in pairs(Index) do
			for j = 1, Number do
				local NX, NY, NZ
				NX = (j*Shape[v[1]+1][1]+(Number-j+1)*Shape[v[2]+1][1])/(Number+1)
				NY = (j*Shape[v[1]+1][2]+(Number-j+1)*Shape[v[2]+1][2])/(Number+1)
				NZ = (j*Shape[v[1]+1][3]+(Number-j+1)*Shape[v[2]+1][3])/(Number+1)
				table.insert(RetShape,{NX,NY,NZ})
				RetShape[1] = RetShape[1] + 1
			end
		end
	else
		local Size = Number[1]
		if Size <= 0 then
			CX_InputError()
		end
		Size = Size^2
		local Length
		local PerNumber
		for k, v in pairs(Index) do
			Length = (Shape[v[2]+1][1]-Shape[v[1]+1][1])^2+(Shape[v[2]+1][2]-Shape[v[1]+1][2])^2+(Shape[v[2]+1][3]-Shape[v[1]+1][3])^2
			PerNumber = math.floor(math.sqrt(Length/Size)+0.5)
			for j = 1, PerNumber do
				local NX, NY, NZ
				NX = (j*Shape[v[1]+1][1]+(PerNumber-j+1)*Shape[v[2]+1][1])/(PerNumber+1)
				NY = (j*Shape[v[1]+1][2]+(PerNumber-j+1)*Shape[v[2]+1][2])/(PerNumber+1)
				NZ = (j*Shape[v[1]+1][3]+(PerNumber-j+1)*Shape[v[2]+1][3])/(PerNumber+1)
				table.insert(RetShape,{NX,NY,NZ})
				RetShape[1] = RetShape[1] + 1
			end
		end
	end
	return RetShape
end

function CXSaveWithName(FileName,Local,...)
	CSSaveInit()
	local CSfile = io.open("CS/" .. FileName .. ".txt", "w")
	io.output(CSfile)
	local arg = table.pack(...)
	for k = 1, (arg.n-1), 2 do
		if Local == nil or Local == 0 then
			io.write(arg[k+1] .." =\n")
		else
			io.write("local "..arg[k+1].." =\n")
		end
		local CSSTR = "{".. arg[k][1]
		for i = 1, arg[k][1] do
			CSSTR = CSSTR .. ",{" .. arg[k][i+1][1] .. "," .. arg[k][i+1][2] .. "," .. arg[k][i+1][3] .. "}" 
		end
		CSSTR = CSSTR .. "}\n\n\n"
		io.write(CSSTR)
	end
	io.write("---------------------------------------------------------------------------------------------------------------------")
	io.close(CSfile)
end

function CXMove(Shape,X,Y,Z)
	if Shape == nil then
		CX_InputError()
	end
	if X == nil then
		X = 0
	end
	if Y == nil then
		Y = 0
	end
	if Z == nil then
		Z = 0
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, NZ
		NX = Shape[i+1][1] + X
		NY = Shape[i+1][2] + Y
		NZ = Shape[i+1][3] + Z
		table.insert(RetShape,{NX,NY,NZ})
	end
	return RetShape	
end

function CXMoveCenter(Shape,X,Y,Z)
	if Shape == nil then
		CX_InputError()
	end
	local Xmax,Xmin,Ymax,Ymin,Zmax,Zmin,XCntr,YCntr,ZCntr,dx,dy,dz
	Xmin = Shape[2][1]
	Xmax = Shape[2][1]
	Ymin = Shape[2][2]
	Ymax = Shape[2][2]
	Zmin = Shape[2][3]
	Zmax = Shape[2][3]
	for i = 1, Shape[1] do
		if Shape[i+1][1] > Xmax then
			Xmax = Shape[i+1][1]
		end
		if Shape[i+1][1] < Xmin then
			Xmin = Shape[i+1][1]
		end
		if Shape[i+1][2] > Ymax then
			Ymax = Shape[i+1][2]
		end
		if Shape[i+1][2] < Ymin then
			Ymin = Shape[i+1][2]
		end
		if Shape[i+1][3] > Zmax then
			Zmax = Shape[i+1][3]
		end
		if Shape[i+1][3] < Zmin then
			Zmin = Shape[i+1][3]
		end
	end
	XCntr = (Xmax+Xmin)/2
	YCntr = (Ymax+Ymin)/2
	ZCntr = (Zmax+Zmin)/2
	dx = X - XCntr
	dy = Y - YCntr
	dz = Z - ZCntr
	local RetShape = CXMove(Shape,dx,dy,dz)
	return RetShape
end

function CXInvert(Shape,X,Y,Z)
	if Shape == nil then
		CX_InputError()
	end
	if X ~= nil then
		X = X*2
	end
	if Y ~= nil then
		Y = Y*2
	end
	if Z ~= nil then
		Z = Z*2
	end
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, NZ
		if X == nil then
			NX = Shape[i+1][1]
		else
			NX = X - Shape[i+1][1]
		end
		if Y == nil then
			NY = Shape[i+1][2]
		else
			NY = Y - Shape[i+1][2]
		end
		if Z == nil then
			NZ = Shape[i+1][3]
		else
			NZ = Z - Shape[i+1][3]
		end
		table.insert(RetShape,{NX,NY,NZ})
	end
	return RetShape	
end

function CXRatio(Shape,mulX,mulY,mulZ)
	if Shape == nil then
		CX_InputError()
	end

	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, NZ
		if mulX == nil then
			NX = Shape[i+1][1]
		else
			NX = mulX * Shape[i+1][1]
		end
		if mulY == nil then
			NY = Shape[i+1][2]
		else
			NY = mulY * Shape[i+1][2]
		end
		if mulZ == nil then
			NZ = Shape[i+1][3]
		else
			NZ = mulZ * Shape[i+1][3]
		end
		table.insert(RetShape,{NX,NY,NZ})
	end
	return RetShape	
end

function CXRotate(Shape,RotateX,RotateY,RotateZ)
	if Shape == nil then
		CX_InputError()
	end
	
	if RotateX == nil then
		RotateX = 0
	end
	if RotateY == nil then
		RotateY = 0
	end
	if RotateZ == nil then
		RotateZ = 0
	end

	RotateX = math.rad(RotateX)
	RotateY = math.rad(RotateY)
	RotateZ = math.rad(RotateZ)
	
	local XCos = math.cos(RotateX)
	local XSin = math.sin(RotateX)
	local YCos = math.cos(RotateY)
	local YSin = math.sin(RotateY)
	local ZCos = math.cos(RotateZ)
	local ZSin = math.sin(RotateZ)

	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, NZ
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		NZ = Shape[i+1][3]
		local PX, PY, PZ
		PX = NX
		PY = NY
		PZ = NZ
		if RotateX ~= 0 then
			PY = NY*XCos - NZ*XSin
			PZ = NY*XSin + NZ*XCos
		end
		NY = PY
		NZ = PZ
		if RotateY ~= 0 then
			PX = NX*YCos + NZ*YSin
			PZ = NZ*YCos - NX*YSin
		end
		NX = PX
		NZ = PZ
		if RotateZ ~= 0 then
			PX = NX*ZCos - NY*ZSin
			PY = NX*ZSin + NY*ZCos
		end
		NX = PX
		NY = PY
		table.insert(RetShape,{NX,NY,NZ})
	end
	return RetShape	
end

function CXCrop(Shape,areaX,areaY,areaZ,edgeX,edgeY,edgeZ)
	if Shape == nil then
		CX_InputError()
	end
	local Count = 0
	local Check = 0
	local RetShape = {0}
	local X1,X2,Y1,Y2,Z1,Z2
	local EX1=0
	local EX2=0
	local EY1=0
	local EY2=0
	local EZ1=0
	local EZ2=0
	if areaX ~= nil then
		X1 = areaX[1]
		X2 = areaX[2]
	end
	if areaY ~= nil then
		Y1 = areaY[1]
		Y2 = areaY[2]
	end
	if areaZ ~= nil then
		Z1 = areaZ[1]
		Z2 = areaZ[2]
	end
	if edgeX ~= nil then
		if edgeX[1] == nil then
			EX1 = 0
		else
			EX1 = 1
		end
		if edgeX[2] == nil then
			EX2 = 0
		else
			EX2 = 1
		end
	end
	if edgeY ~= nil then
		if edgeY[1] == nil then
			EY1 = 0
		else
			EY1 = 1
		end
		if edgeY[2] == nil then
			EY2 = 0
		else
			EY2 = 1
		end
	end
	if edgeZ ~= nil then
		if edgeZ[1] == nil then
			EZ1 = 0
		else
			EZ1 = 1
		end
		if edgeZ[2] == nil then
			EZ2 = 0
		else
			EZ2 = 1
		end
	end

	for i = 1, Shape[1] do
		Check = 0
		local NX, NY, NZ
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		NZ = Shape[i+1][3]
		if X1 ~= nil then
			if EX1 == 0 and NX < X1 then
				Check = 1
			end
			if EX1 == 1 and NX <= X1 then
				Check = 1
			end
		end
		if X2 ~= nil then
			if EX2 == 0 and NX > X2 then
				Check = 1
			end
			if EX2 == 1 and NX >= X2 then
				Check = 1
			end
		end
		if Y1 ~= nil then
			if EY1 == 0 and NY < Y1 then
				Check = 1
			end
			if EY1 == 1 and NY <= Y1 then
				Check = 1
			end
		end
		if Y2 ~= nil then
			if EY2 == 0 and NY > Y2 then
				Check = 1
			end
			if EY2 == 1 and NY >= Y2 then
				Check = 1
			end
		end
		if Z1 ~= nil then
			if EZ1 == 0 and NZ < Z1 then
				Check = 1
			end
			if EZ1 == 1 and NZ <= Z1 then
				Check = 1
			end
		end
		if Z2 ~= nil then
			if EZ2 == 0 and NZ > Z2 then
				Check = 1
			end
			if EZ2 == 1 and NZ >= Z2 then
				Check = 1
			end
		end
		if Check == 0 then
			table.insert(RetShape,{NX,NY,NZ})
			Count = Count + 1
		end
	end
	RetShape[1] = Count
	return RetShape	
end

function CX_Move(X,Y,Z)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	if X ~= nil then
		CAdd(PlayerID,V(CA[8]),X)
	end
	if Y ~= nil then
		CAdd(PlayerID,V(CA[9]),Y)
	end
	if Z ~= nil then
		CAdd(PlayerID,V(CA[11]),Z)
	end
end

function CX_Ratio(mulX,idivX,mulY,idivY,mulZ,idivZ)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)
	if mulX ~= nil then
		if type(mulX) == "number" then
			CMul(PlayerID,V(CA[8]),mulX)
		else
			f_Mul(PlayerID,V(CA[8]),mulX)
		end
	end
	if mulY ~= nil then
		if type(mulY) == "number" then
			CMul(PlayerID,V(CA[9]),mulY)
		else
			f_Mul(PlayerID,V(CA[9]),mulY)
		end
	end
	if mulZ ~= nil then
		if type(mulZ) == "number" then
			CMul(PlayerID,V(CA[11]),mulZ)
		else
			f_Mul(PlayerID,V(CA[11]),mulZ)
		end
	end
	if idivX ~= nil then
		if type(idivX) == "number" then
			CiDiv(PlayerID,V(CA[8]),idivX)
		else
			f_iDiv(PlayerID,V(CA[8]),idivX)
		end
	end
	if idivY ~= nil then
		if type(idivY) == "number" then
			CiDiv(PlayerID,V(CA[9]),idivY)
		else
			f_iDiv(PlayerID,V(CA[9]),idivY)
		end
	end
	if idivZ ~= nil then
		if type(idivZ) == "number" then
			CiDiv(PlayerID,V(CA[11]),idivZ)
		else
			f_iDiv(PlayerID,V(CA[11]),idivZ)
		end
	end
end

function CX_Invert(X,Y,Z)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if X ~= nil and type(X) ~= "number" then
		CMov(PlayerID,V(CB[4]),X)
	end
	if Y ~= nil and type(Y) ~= "number" then
		CMov(PlayerID,V(CB[5]),Y)
	end
	if Z ~= nil and type(Z) ~= "number" then
		CMov(PlayerID,V(CB[6]),Z)
	end

	if X ~= nil then
		if type(X) == "number" then
			CMov(PlayerID,V(CA[8]),_iSub(_Mov(2*X),V(CA[8])))
		else
			CMov(PlayerID,V(CA[8]),_iSub(_Add(V(CB[4]),V(CB[4])),V(CA[8])))
		end
	end
	if Y ~= nil then
		if type(Y) == "number" then
			CMov(PlayerID,V(CA[9]),_iSub(_Mov(2*Y),V(CA[9])))
		else
			CMov(PlayerID,V(CA[9]),_iSub(_Add(V(CB[5]),V(CB[5])),V(CA[9])))
		end
	end
	if Z ~= nil then
		if type(Z) == "number" then
			CMov(PlayerID,V(CA[11]),_iSub(_Mov(2*Z),V(CA[11])))
		else
			CMov(PlayerID,V(CA[11]),_iSub(_Add(V(CB[6]),V(CB[6])),V(CA[11])))
		end
	end
end

function CX_Rotate(RotateX,RotateY,RotateZ)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if RotateX ~= nil and type(RotateX) ~= "number" then
		CMov(PlayerID,V(CB[6]),RotateX)
	end
	if RotateY ~= nil and type(RotateY) ~= "number" then
		CMov(PlayerID,V(CB[7]),RotateY)
	end
	if RotateZ ~= nil and type(RotateZ) ~= "number" then
		CMov(PlayerID,V(CB[8]),RotateZ)
	end
	if RotateX ~= nil then 
		if type(RotateX) == "number" then -- Temp Var가 Angle로 입력시 _Mov(Angle) 입력할 경우 Temp Var가 초기화되어 버그 발생
			f_Lengthdir(PlayerID,V(CA[9]),_Mov(RotateX),V(CB[9]),V(CA[12])) -- YCos YSin
			f_Lengthdir(PlayerID,V(CA[11]),_Mov(RotateX),V(CA[13]),V(CA[14])) -- ZCos ZSin
		else
			f_Lengthdir(PlayerID,V(CA[9]),V(CB[6]),V(CB[9]),V(CA[12])) -- YCos YSin
			f_Lengthdir(PlayerID,V(CA[11]),V(CB[6]),V(CA[13]),V(CA[14])) -- ZCos ZSin
		end
		CMov(PlayerID,V(CA[9]),_iSub(V(CB[9]),V(CA[14]))) -- Y = YCos - ZSin
		CMov(PlayerID,V(CA[11]),_Add(V(CA[12]),V(CA[13]))) -- Z = YSin + ZCos
	end

	if RotateY ~= nil then 
		if type(RotateY) == "number" then -- Temp Var가 Angle로 입력시 _Mov(Angle) 입력할 경우 Temp Var가 초기화되어 버그 발생
			f_Lengthdir(PlayerID,V(CA[8]),_Mov(RotateY),V(CB[9]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CA[11]),_Mov(RotateY),V(CA[13]),V(CA[14])) -- ZCos ZSin
		else
			f_Lengthdir(PlayerID,V(CA[8]),V(CB[7]),V(CB[9]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CA[11]),V(CB[7]),V(CA[13]),V(CA[14])) -- ZCos ZSin
		end
		CMov(PlayerID,V(CA[8]),_Add(V(CA[14]),V(CB[9]))) -- X = ZSin + XCos
		CMov(PlayerID,V(CA[11]),_iSub(V(CA[13]),V(CA[12]))) -- Z = ZCos - XSin
	end

	if RotateZ ~= nil then 
		if type(RotateZ) == "number" then -- Temp Var가 Angle로 입력시 _Mov(Angle) 입력할 경우 Temp Var가 초기화되어 버그 발생
			f_Lengthdir(PlayerID,V(CA[8]),_Mov(RotateZ),V(CB[9]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CA[9]),_Mov(RotateZ),V(CA[13]),V(CA[14])) -- YCos YSin
		else
			f_Lengthdir(PlayerID,V(CA[8]),V(CB[8]),V(CB[9]),V(CA[12])) -- XCos XSin 
			f_Lengthdir(PlayerID,V(CA[9]),V(CB[8]),V(CA[13]),V(CA[14])) -- YCos YSin
		end
		CMov(PlayerID,V(CA[8]),_iSub(V(CB[9]),V(CA[14]))) -- X = XCos - YSin
		CMov(PlayerID,V(CA[9]),_Add(V(CA[12]),V(CA[13]))) -- Y = XSin + YCos
	end
end

function CX_Crop(X1,X2,Y1,Y2,Z1,Z2)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	STPopTrigArr(PlayerID)

	if X1 ~= nil and type(X1) ~= "number" then
		CMov(PlayerID,V(CB[4]),X1)
	end
	if X2 ~= nil and type(X2) ~= "number" then
		CMov(PlayerID,V(CB[5]),X2)
	end
	if Y1 ~= nil and type(Y1) ~= "number" then
		CMov(PlayerID,V(CB[6]),Y1)
	end
	if Y2 ~= nil and type(Y2) ~= "number" then
		CMov(PlayerID,V(CB[7]),Y2)
	end
	if Z1 ~= nil and type(Z1) ~= "number" then
		CMov(PlayerID,V(CB[8]),Z1)
	end
	if Z2 ~= nil and type(Z2) ~= "number" then
		CMov(PlayerID,V(CB[9]),Z2)
	end

	if X1 ~= nil then
		if type(X1) == "number" then
			if X1 >= 0 then
				CTrigger(PlayerID,{TTOR({CVar("X",CA[8],AtMost,X1),CVar("X",CA[8],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{CVar("X",CA[8],AtMost,X1),CVar("X",CA[8],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[4],AtLeast,0x80000000))
				CTrigger(PlayerID,{TCVar("X",CA[8],AtMost,V(CB[4])),CVar("X",CA[8],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[8],AtMost,V(CB[4])),CVar("X",CA[8],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if X2 ~= nil then
		if type(X2) == "number" then
			if X2 >= 0 then
				CTrigger(PlayerID,{CVar("X",CA[8],AtLeast,X2),CVar("X",CA[8],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TTOR({CVar("X",CA[8],AtLeast,X2),CVar("X",CA[8],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[5],AtLeast,0x80000000))
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[8],AtLeast,V(CB[5])),CVar("X",CA[8],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TCVar("X",CA[8],AtLeast,V(CB[5])),CVar("X",CA[8],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if Y1 ~= nil then
		if type(Y1) == "number" then
			if Y1 >= 0 then
				CTrigger(PlayerID,{TTOR({CVar("X",CA[9],AtMost,Y1),CVar("X",CA[9],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{CVar("X",CA[9],AtMost,Y1),CVar("X",CA[9],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[6],AtLeast,0x80000000))
				CTrigger(PlayerID,{TCVar("X",CA[9],AtMost,V(CB[6])),CVar("X",CA[9],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[9],AtMost,V(CB[6])),CVar("X",CA[9],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if Y2 ~= nil then
		if type(Y2) == "number" then
			if Y2 >= 0 then
				CTrigger(PlayerID,{CVar("X",CA[9],AtLeast,Y2),CVar("X",CA[9],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TTOR({CVar("X",CA[9],AtLeast,Y2),CVar("X",CA[9],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[7],AtLeast,0x80000000))
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[9],AtLeast,V(CB[7])),CVar("X",CA[9],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TCVar("X",CA[9],AtLeast,V(CB[7])),CVar("X",CA[9],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if Z1 ~= nil then
		if type(Z1) == "number" then
			if Z1 >= 0 then
				CTrigger(PlayerID,{TTOR({CVar("X",CA[11],AtMost,Z1),CVar("X",CA[11],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{CVar("X",CA[11],AtMost,Z1),CVar("X",CA[11],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[8],AtLeast,0x80000000))
				CTrigger(PlayerID,{TCVar("X",CA[11],AtMost,V(CB[8])),CVar("X",CA[11],AtLeast,0x80000000)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[11],AtMost,V(CB[8])),CVar("X",CA[11],AtLeast,0x80000000)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end

	if Z2 ~= nil then
		if type(Z2) == "number" then
			if Z2 >= 0 then
				CTrigger(PlayerID,{CVar("X",CA[11],AtLeast,Z2),CVar("X",CA[11],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			else
				CTrigger(PlayerID,{TTOR({CVar("X",CA[11],AtLeast,Z2),CVar("X",CA[11],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			end
		else
			CIfX(PlayerID,CVar("X",CB[9],AtLeast,0x80000000))
				CTrigger(PlayerID,{TTOR({_TCVar("X",CA[11],AtLeast,V(CB[9])),CVar("X",CA[11],AtMost,0x7FFFFFFF)})},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CElseX()
				CTrigger(PlayerID,{TCVar("X",CA[11],AtLeast,V(CB[9])),CVar("X",CA[11],AtMost,0x7FFFFFFF)},SetCVar("X",CB[10],SetTo,1),{Preserved})
			CIfXEnd()
		end
	end
end

function CXRound(Shape,Digit)
	if Shape == nil then
		CX_InputError()
	end
	local N = 10^Digit
	for i = 1, Shape[1] do
		Shape[i+1][1] = math.floor(Shape[i+1][1]*N+0.5)/N
		Shape[i+1][2] = math.floor(Shape[i+1][2]*N+0.5)/N
		Shape[i+1][3] = math.floor(Shape[i+1][3]*N+0.5)/N
	end
	return Shape
end

function CXGetXmax(Shape)
	if Shape == nil then
		CX_InputError()
	end
	local Xmax = Shape[2][1]
	for i = 1, Shape[1] do
		if Shape[i+1][1] > Xmax then
			Xmax = Shape[i+1][1]
		end
	end
	return Xmax
end

function CXGetXmin(Shape)
	if Shape == nil then
		CX_InputError()
	end
	local Xmin = Shape[2][1]
	for i = 1, Shape[1] do
		if Shape[i+1][1] < Xmin then
			Xmin = Shape[i+1][1]
		end
	end
	return Xmin
end

function CXGetYmax(Shape)
	if Shape == nil then
		CX_InputError()
	end
	local Ymax = Shape[2][2]
	for i = 1, Shape[1] do
		if Shape[i+1][2] > Ymax then
			Ymax = Shape[i+1][2]
		end
	end
	return Ymax
end

function CXGetYmin(Shape)
	if Shape == nil then
		CX_InputError()
	end
	local Ymin = Shape[2][2]
	for i = 1, Shape[1] do
		if Shape[i+1][2] < Ymin then
			Ymin = Shape[i+1][2]
		end
	end
	return Ymin
end

function CXGetZmax(Shape)
	if Shape == nil then
		CX_InputError()
	end
	local Zmax = Shape[2][3]
	for i = 1, Shape[1] do
		if Shape[i+1][3] > Zmax then
			Zmax = Shape[i+1][3]
		end
	end
	return Zmax
end

function CXGetZmin(Shape)
	if Shape == nil then
		CX_InputError()
	end
	local Zmin = Shape[2][3]
	for i = 1, Shape[1] do
		if Shape[i+1][3] < Zmin then
			Zmin = Shape[i+1][3]
		end
	end
	return Zmin
end

function CXGetXCntr(Shape)
	return (CXGetXmax(Shape)+CXGetXmin(Shape))/2
end

function CXGetYCntr(Shape)
	return (CXGetYmax(Shape)+CXGetYmin(Shape))/2
end

function CXGetZCntr(Shape)
	return (CXGetZmax(Shape)+CXGetZmin(Shape))/2
end

function CXPlot(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve,CXfunc2)
	if Shape == nil then
		CX_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ArrSize
	if type(Shape[1]) ~= "number" then
		local Sizemax = Shape[1][1]
		for i = 1, #Shape do
			if Shape[i][1] > Sizemax then
				Sizemax = Shape[i][1]
			end
		end
		Arrsize = Sizemax
	else
		Arrsize = Shape[1]
	end

	local TempAct = {}
	local PlotArrX
	local PlotArrY
	local PlotArrZ
	CJump(PlayerID,CAPlotJumpAlloc)
		PlotArrX = CArray(PlayerID,Arrsize)
		PlotArrY = CArray(PlayerID,Arrsize)
		PlotArrZ = CArray(PlayerID,Arrsize)
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				table.insert(TempAct,{})
				for j = 1, Shape[i][1] do
					table.insert(TempAct[i],SetMemX(Arr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrZ,j),SetTo,Shape[i][j+1][3]))
				end
				table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
			end
		else
			for i = 1, Shape[1] do
				table.insert(TempAct,SetMemX(Arr(PlotArrX,i),SetTo,Shape[i+1][1]))
				table.insert(TempAct,SetMemX(Arr(PlotArrY,i),SetTo,Shape[i+1][2]))
				table.insert(TempAct,SetMemX(Arr(PlotArrZ,i),SetTo,Shape[i+1][3]))
			end
			table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
		end
		if type(Preset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
		if type(Preset[3]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
		else
			CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
		if type(Preset[5]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
		else
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------
		CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc) -- Temp Z
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
		CAPlotVarAlloc = CAPlotVarAlloc + 4
		CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
		CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
		CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	if type(Preset[1]) ~= "number" then
		CMov(PlayerID,V(CA[1]),Preset[1])
	end
	if type(Preset[2]) ~= "number" then
		CMov(PlayerID,V(CA[2]),Preset[2])
	end
	if type(Preset[3]) ~= "number" then
		CMov(PlayerID,V(CA[3]),Preset[3])
	end
	if type(Preset[4]) ~= "number" then
		CMov(PlayerID,V(CA[4]),Preset[4])
	end
	if type(Preset[5]) ~= "number" then
		CMov(PlayerID,V(CA[5]),Preset[5])
	end
	if type(Preset[6]) ~= "number" then
		CMov(PlayerID,V(CA[6]),Preset[6])
	end
	if Preset[7] ~= nil then
		CMov(PlayerID,V(CB[1]),Preset[7])
	end
	if Preset[8] ~= nil then
		CMov(PlayerID,V(CB[2]),Preset[8])
	end
	if Preset[9] ~= nil then
		CMov(PlayerID,V(CB[3]),Preset[9])
	end

	CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,TempAct)
		end
	CIfEnd()

	NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
			ConvertArr(PlayerID,V(CA[7]),V(CA[6]))
			f_Read(PlayerID,ArrX(PlotArrX,V(CA[7])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrY,V(CA[7])),V(CA[9]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrZ,V(CA[7])),V(CA2[1]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
			CAPlotPlayerID = PlayerID
			CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
			CAPlotVarAlloc = CAPlotVarAlloc + 7
			if CXfunc ~= nil then
				_G[CXfunc]() -- Z좌표는 여기서 CX_ 함수에 의해 X,Y좌표값에 영향을 미침
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end

			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)
			CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location-1,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
			if CXfunc2 ~= nil then
				_G[CXfunc2]() -- 사용자 지정 함수
			end
			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			end
			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{Preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CXPlotWithProperties(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve,Properties)
	if Shape == nil then
		CX_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(Location) == "string" then
		LocId = ParseLocation(LocId)-1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ArrSize
	if type(Shape[1]) ~= "number" then
		local Sizemax = Shape[1][1]
		for i = 1, #Shape do
			if Shape[i][1] > Sizemax then
				Sizemax = Shape[i][1]
			end
		end
		Arrsize = Sizemax
	else
		Arrsize = Shape[1]
	end

	local TempAct = {}
	local PlotArrX
	local PlotArrY
	local PlotArrZ
	CJump(PlayerID,CAPlotJumpAlloc)
		PlotArrX = CArray(PlayerID,Arrsize)
		PlotArrY = CArray(PlayerID,Arrsize)
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				table.insert(TempAct,{})
				for j = 1, Shape[i][1] do
					table.insert(TempAct[i],SetMemX(Arr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
					table.insert(TempAct[i],SetMemX(Arr(PlotArrZ,j),SetTo,Shape[i][j+1][3]))
				end
				table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
			end
		else
			for i = 1, Shape[1] do
				table.insert(TempAct,SetMemX(Arr(PlotArrX,i),SetTo,Shape[i+1][1]))
				table.insert(TempAct,SetMemX(Arr(PlotArrY,i),SetTo,Shape[i+1][2]))
				table.insert(TempAct,SetMemX(Arr(PlotArrZ,i),SetTo,Shape[i+1][3]))
			end
			table.insert(TempAct,SetCVar("X",CA[1],SetTo,0))
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
		end
		if type(Preset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,Preset[1]) -- Shape Select (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+0) -- Shape Select (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+1) -- Delay Timer (가변) [2]
		if type(Preset[3]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Preset[3]) -- Delay Adder (고정) [3]
		else
			CVariable(PlayerID,CAPlotVarAlloc+2) -- Delay Adder (고정)
		end
		CVariable(PlayerID,CAPlotVarAlloc+3) -- Loop Counter (가변) [4]
		if type(Preset[5]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
		else
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,1) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------
		CVariable(PlayerID,CAPlotVarAlloc+6) -- Temp Index
		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc) -- Temp Z
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3}
		CAPlotVarAlloc = CAPlotVarAlloc + 4
		CVariable2(PlayerID,CAPlotVarAlloc+0,"X",SetTo,PerUnit*16777216)
		CVariable2(PlayerID,CAPlotVarAlloc+1,"X",SetTo,UnitId)
		CVariable2(PlayerID,CAPlotVarAlloc+2,"X",SetTo,Owner)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	if type(Preset[1]) ~= "number" then
		CMov(PlayerID,V(CA[1]),Preset[1])
	end
	if type(Preset[2]) ~= "number" then
		CMov(PlayerID,V(CA[2]),Preset[2])
	end
	if type(Preset[3]) ~= "number" then
		CMov(PlayerID,V(CA[3]),Preset[3])
	end
	if type(Preset[4]) ~= "number" then
		CMov(PlayerID,V(CA[4]),Preset[4])
	end
	if type(Preset[5]) ~= "number" then
		CMov(PlayerID,V(CA[5]),Preset[5])
	end
	if type(Preset[6]) ~= "number" then
		CMov(PlayerID,V(CA[6]),Preset[6])
	end
	if Preset[7] ~= nil then
		CMov(PlayerID,V(CB[1]),Preset[7])
	end
	if Preset[8] ~= nil then
		CMov(PlayerID,V(CB[2]),Preset[8])
	end
	if Preset[9] ~= nil then
		CMov(PlayerID,V(CB[3]),Preset[9])
	end

	CIf(PlayerID,CVar("X",CA[1],AtLeast,1))
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
			end
		else
			DoActions2X(PlayerID,TempAct)
		end
	CIfEnd()

	NWhile(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
			ConvertArr(PlayerID,V(CA[7]),V(CA[6]))
			f_Read(PlayerID,ArrX(PlotArrX,V(CA[7])),V(CA[8]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrY,V(CA[7])),V(CA[9]),"X",0xFFFFFFFF,1)
			f_Read(PlayerID,ArrX(PlotArrZ,V(CA[7])),V(CA2[1]),"X",0xFFFFFFFF,1)
	-------------------------------------------------------------------------
			CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
			CAPlotPlayerID = PlayerID
			CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
			CAPlotVarAlloc = CAPlotVarAlloc + 7
			if CXfunc ~= nil then
				_G[CXfunc]() -- Z좌표는 여기서 CX_ 함수에 의해 X,Y좌표값에 영향을 미침
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_Read(PlayerID,LocL,V(CA2[1]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocR,V(CA2[2]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocU,V(CA2[3]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,LocD,V(CA2[4]),"X",0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end
			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)
			CDoActions(PlayerID,{TCreateUnitWithProperties(V(CB[1]),V(CB[2]),Location,V(CB[3]),Properties),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			end
			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{Preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end