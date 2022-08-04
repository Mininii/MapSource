-- CreateUnitShape.lua v2.4  for Tep ----------------------------------------------------------------
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

function CS_OverlapX(...)
	local RetShape = {0}
	local arg = table.pack(...)
	for k = 1, arg.n do
		RetShape[1] = RetShape[1] + arg[k][1]
		for i = 1, arg[k][1] do
			table.insert(RetShape,{arg[k][i+1][1],arg[k][i+1][2]})
		end
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
		dx = CenterXY[1]
		dy = CenterXY[2]
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
			Y1 = (Ymax-YCntr) * YLU + YCntr
			Y2 = (Ymax-YCntr) * YRU + YCntr
			R1Y = ((NY-Ymin)/(Ymax-Ymin))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX+dx-Xmin))

			Y1 = (Ymin-YCntr) * YLD + YCntr
			Y2 = (Ymin-YCntr) * YRD + YCntr
			R2Y = ((Ymax-NY)/(-Ymin+Ymax))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX+dx-Xmin))

			X1 = (Xmax-XCntr) * XRD + XCntr
			X2 = (Xmax-XCntr) * XRU + XCntr
			R3X = ((NX-Xmin)/(Xmax-Xmin))*(X1+((X2-X1)/(Ymax-Ymin))*(NY+dy-Ymin))

			X1 = (Xmin-XCntr) * XLD + XCntr
			X2 = (Xmin-XCntr) * XLU + XCntr
			R4X = ((Xmax-NX)/(-Xmin+Xmax))*(X1+((X2-X1)/(Ymax-Ymin))*(NY+dy-Ymin))
		else
			Y1 = (Ymax-YCntr) * YLU + YCntr
			Y2 = (Ymax-YCntr) * YRU + YCntr
			R1Y = ((NY-Ymin)/(Ymax-Ymin))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin))

			Y1 = (Ymin-YCntr) * YLD + YCntr
			Y2 = (Ymin-YCntr) * YRD + YCntr
			R2Y = ((Ymax-NY)/(-Ymin+Ymax))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin))

			X1 = (Xmax-XCntr) * XRD + XCntr
			X2 = (Xmax-XCntr) * XRU + XCntr
			R3X = ((NX-Xmin)/(Xmax-Xmin))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin))

			X1 = (Xmin-XCntr) * XLD + XCntr
			X2 = (Xmin-XCntr) * XLU + XCntr
			R4X = ((Xmax-NX)/(-Xmin+Xmax))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin))
		end

		TX = R3X+R4X+XCntr
		TY = R1Y+R2Y+YCntr

		table.insert(RetShape,{TX,TY})
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

	local LocId,Location = ConvertLocation(Location)
	
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
				players = {PlayerID},
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
				players = {PlayerID},
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

	local LocId,Location = ConvertLocation(Location)
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
				players = {PlayerID},
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
				players = {PlayerID},
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

	local LocId,Location = ConvertLocation(Location)
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
				players = {PlayerID},
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
				players = {PlayerID},
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

	local LocId,Location = ConvertLocation(Location)
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
				players = {PlayerID},
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
				players = {PlayerID},
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

	local LocId,Location = ConvertLocation(Location)
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
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location,Owner))
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
				players = {PlayerID},
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
				players = {PlayerID},
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

	local LocId,Location = ConvertLocation(Location)
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
				players = {PlayerID},
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
				players = {PlayerID},
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

	local LocId,Location = ConvertLocation(Location)
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
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location,Owner))
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
				table.insert(Plot,CreateUnit(PerUnit,UnitId,Location,Owner))
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
				players = {PlayerID},
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
				players = {PlayerID},
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

	local LocId,Location = ConvertLocation(Location)
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
				players = {PlayerID},
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
				players = {PlayerID},
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
		local DirName = "\""..FileDirectory.."CS\""
		os.execute("mkdir " .. DirName)
		CSSaveInitCheck = 1
	end
end

function CSSave(FileName,Local,...)
	CSSaveInit()
	local CSfile = io.open(FileDirectory.."CS/" .. FileName .. ".txt", "w")
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
	local CSfile = io.open(FileDirectory.."CS/" .. FileName .. ".txt", "w")
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

function CSTSaveWithName(FileName,Local,...)
	CSSaveInit()
	local CSfile = io.open(FileDirectory.."CS/" .. FileName .. ".txt", "w")
	io.output(CSfile)
	local arg = table.pack(...)
	for k = 1, (arg.n-2), 3 do
		if Local == nil or Local == 0 then
			io.write(arg[k+2] .." =\n")
		else
			io.write("local "..arg[k+2].." = {\n")
		end
		local CSSTR = "{{".. arg[k][1]
		for i = 1, arg[k][1] do
			CSSTR = CSSTR .. ",{" .. arg[k][i+1][1] .. "," .. arg[k][i+1][2] .. "}" 
		end
		CSSTR = CSSTR .. "},\n\n" ..  "{".. arg[k+1][1]
		for i = 1, arg[k+1][1] do
			CSSTR = CSSTR .. "," .. arg[k+1][i+1]
		end
		CSSTR = CSSTR .. "}}\n\n\n"
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
		local CSTemp = io.open(FileDirectory.."CS/" .. arg[k] .. ".txt", "r")
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

function CS_ConnectPath(Path,PerNumber,EndLine,Index)
	if Index == nil then
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
	else
		local RetShape = {0}
		local Count = 0
		if Path == nil then
			CS_InputError()
		end
		if PerNumber <= 0 then
			CS_InputError()
		end

		local RetShape = {Shape[1]}
		for i = 1, Shape[1] do
			table.insert(RetShape,Shape[i+1])
		end

		for k, v in pairs(Index) do
			for j = 1, PerNumber do
				local NX, NY
				NX = (j*Path[v[1]+1][1]+(PerNumber-j+1)*Path[v[2]+1][1])/(PerNumber+1)
				NY = (j*Path[v[1]+1][2]+(PerNumber-j+1)*Path[v[2]+1][2])/(PerNumber+1)
				table.insert(RetShape,{NX,NY})
				Count = Count + 1
			end
		end

		RetShape[1] = RetShape[1] + Count
		return RetShape
	end
end

function CS_ConnectPathX(Path,PerSize,EndLine,Index)
	if Index == nil then
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
	else
		local RetShape = {0}
		local Count = 0
		if Path == nil then
			CS_InputError()
		end
		if PerSize <= 0 then
			CS_InputError()
		end
		PerSize = PerSize^2

		local RetShape = {Shape[1]}
		for i = 1, Shape[1] do
			table.insert(RetShape,Shape[i+1])
		end

		for k, v in pairs(Index) do
			local Length = (Path[v[2]+1][1]-Path[v[1]+1][1])^2+(Path[v[2]+1][2]-Path[v[1]+1][2])^2
			local PerNumber = math.floor(math.sqrt(Length/PerSize)+0.5)
			for j = 1, PerNumber do
				local NX, NY
				NX = (j*Path[v[1]+1][1]+(PerNumber-j+1)*Path[v[2]+1][1])/(PerNumber+1)
				NY = (j*Path[v[1]+1][2]+(PerNumber-j+1)*Path[v[2]+1][2])/(PerNumber+1)
				table.insert(RetShape,{NX,NY})
				Count = Count + 1
			end
		end

		RetShape[1] = RetShape[1] + Count
		return RetShape
	end
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

CAPlotJumpAlloc = 0xA00
CAPlotJumpLimit = 0x1000
CAPlotVarAlloc = 0x1A000
CAPlotVarLimit = 0x1D000
CAPlotDataArr = {}
CAPlotPlayerID = {}
CAPlotCreateArr = {}
CBPlotLoopMaxptr = {}
CBPlotOrderArr = {}
CBPlotFArrX = {}
CBPlotFArrY = {}
CBPlotFArrN = {}
CBPlotNum = {}
CBPlotTNum = {}

function CAPlotAllocCheck()
	if CAPlotVarAlloc >= CAPlotVarLimit then
		CAPlotAllocation_Overflow()
	end
end

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

function CA_Convert2D(Shape)
	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		table.insert(RetShape,{Shape[i+1][1],Shape[i+1][2]})
	end
	return RetShape
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
function CAPlot(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve)
	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
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
			CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
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
	NWhileXEnd()
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

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
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
	NWhileXEnd()
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

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
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
	NWhileXEnd()
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

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
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
	NWhileXEnd()
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

function CAPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve)
	CIf(PlayerID,Condition)

	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
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
			
			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TCreateUnit,V(CB[1]),V(CB[2]),Location,V(CB[3])})
			table.insert(PerAct,SetCVar("X",CA[4],Add,1))
			table.insert(PerAct,SetCVar("X",CA[6],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

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
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,1))
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,Vi(CA[10],1)}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CAPlotWithProperties2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve,Properties)
	CIf(PlayerID,Condition)
	
	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
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

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TCreateUnitWithProperties,V(CB[1]),V(CB[2]),Location,V(CB[3]),Properties})
			table.insert(PerAct,SetCVar("X",CA[4],Add,1))
			table.insert(PerAct,SetCVar("X",CA[6],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

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
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,1))
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,Vi(CA[10],1)}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CAPlotOrder2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,OrderShape,OrderType,OrderLocation,DestXY,OrderPreset,CBfunc,OrderSize,PlayerID,Condition,PerAction,Preserve)
	CIf(PlayerID,Condition)

	if Shape == nil then
		CS_InputError()
	end
	if OrderShape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
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

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TOrder,V(CB[2]),V(CB[3]),Location,OrderType,OrderLocation})
			table.insert(PerAct,SetCVar("X",CB[10],SetTo,0))
			table.insert(PerAct,SetCVar("X",CC[2],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

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
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),SetCVar("X",CC[2],SetTo,1),{Preserved})
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,1))
			table.insert(PreAct,SetCVar("X",CC[2],SetTo,1))
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,Vi(CA[10],1)}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3],CC[1],CC[2]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CAPlotOrderWithProperties2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,OrderShape,OrderType,OrderLocation,DestXY,OrderPreset,CBfunc,OrderSize,PlayerID,Condition,PerAction,Preserve,Properties)
	CIf(PlayerID,Condition)

	if Shape == nil then
		CS_InputError()
	end
	if OrderShape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
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

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TOrder,V(CB[2]),V(CB[3]),Location,OrderType,OrderLocation})
			table.insert(PerAct,SetCVar("X",CB[10],SetTo,0))
			table.insert(PerAct,SetCVar("X",CC[2],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

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
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),SetCVar("X",CC[2],SetTo,1),{Preserved})
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,1))
			table.insert(PreAct,SetCVar("X",CC[2],SetTo,1))
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,Vi(CA[10],1)}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
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
	local CSfile = io.open(FileDirectory.."CS/" .. FileName .. ".txt", "w")
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

function CXPlot(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve)
	if Shape == nil then
		CX_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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
			CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
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

	local LocId,Location = ConvertLocation(Location)
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

function CXPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve)
	CIf(PlayerID,Condition)
	
	if Shape == nil then
		CX_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TCreateUnit,V(CB[1]),V(CB[2]),Location,V(CB[3])})
			table.insert(PerAct,SetCVar("X",CA[4],Add,1))
			table.insert(PerAct,SetCVar("X",CA[6],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

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
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,1))
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,Vi(CA[10],1)}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

function CXPlotWithProperties2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve,Properties)
	CIf(PlayerID,Condition)

	if Shape == nil then
		CX_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TCreateUnitWithProperties,V(CB[1]),V(CB[2]),Location,V(CB[3]),Properties})
			table.insert(PerAct,SetCVar("X",CA[4],Add,1))
			table.insert(PerAct,SetCVar("X",CA[6],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

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
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{Preserved})
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,1))
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,Vi(CA[10],1)}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end

-----------------------------------------------------------------------------------------------------------------------------------
-- 추가 고급 함수
function CS_Level(Type,Point,Number)
	if Type == "Polygon" then
		return Point*(Number*(Number-1))/2 + 1
	elseif Type == "PolygonX" then
		return Point*(Number*Number)
	elseif Type == "Line" then
		return (Number-1) * Point + 1
	elseif Type == "LineX" then
		return Number * Point
	elseif Type == "Circle" then
		return Point*(Number*(Number-1))/2 + 1
	elseif Type == "CircleX" then
		return Point*(Number*Number)
	elseif Type == "Star" then
		return Point*(Number*(Number-1)) + 1
	elseif Type == "StarX" then
		return Point*(Number*Number)*2
	elseif Type == "Spiral" then
		return (Number-1) * Point + 1
	elseif Type == "SpiralX" then
		return Number * Point
	else
		CS_InputError()
	end
end

function CS_Delete(Shape,PathData,...)
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
		local Check = 0
		for k, v in pairs(PathData) do
			if Check == 0 and Shape[i+1][1] == v[1] and Shape[i+1][2] == v[2] then
				Check = 1
				Count = Count + 1
			end
		end
		if Check == 0 then
			table.insert(RetShape,Shape[i+1])
		end
	end
	
	RetShape[1] = Shape[1] - Count
	return RetShape
end

function CS_ConvertXY(Shape,AMax)
	local NShape = {Shape[1]}
	for i = 2, Shape[1]+1 do
		local NR, NA
		NR = Shape[i][1]
		NA = Shape[i][2]
		if AMax ~= nil and AMax ~= 360 then
			NA = (NA/AMax)*360
		end
		NA = math.rad(NA)
		table.insert(NShape,{NR*math.cos(NA),NR*math.sin(NA)})
	end
	return NShape
end

function CS_ConvertRA(Shape,AAdd,AMax)
	local NShape = {Shape[1]}
	for i = 2, Shape[1]+1 do
		local NX, NY, NR, NA
		NX = Shape[i][1]
		NY = Shape[i][2]

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

		NA = math.deg(NA)

		if AMax ~= nil and AMax ~= 360 then
			NA = (NA/360)*AMax
		end
		if type(AAdd) == "number" then
			NA = NA + AAdd
		elseif type(AAdd) == "table" then
			NA = NA + (AAdd/360)*AMax
		end

		table.insert(NShape,{NR,NA})
	end
	return NShape
end

function CS_InputVoid(Size)
	local NShape = {Size}
	for i = 1, Size do
		table.insert(NShape,{0,0})
	end
	return NShape
end

function CS_VectorPath2D(Shape,Ratio,VectorFunc,Path,Outside)
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
		local Ret
		local Temp = CS_CropPath({1,{NX,NY}},Path,Outside)
		if Temp[1] == 1 then
			Ret = _G[VectorFunc](NX/XRatio,NY/YRatio)
		else
			Ret = {NX,NY}
		end 
		PX = Ret[1]
		PY = Ret[2]
		table.insert(RetShape,{PX*XRatio,PY*YRatio})
	end
	return RetShape
end

function CS_VectorPath2DPolar(Shape,Ratio,VectorFunc,Path,Outside)
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
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local Temp = CS_CropPath({1,{NX,NY}},Path,Outside)
		if Temp[1] == 1 then
			NX = NX/XRatio
			NY = NY/YRatio
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
		else
			table.insert(RetShape,{NX,NY})
		end
	end
	return RetShape
end

function CS_GetLmax(Shape)
	local Lmax, Length
	Lmax = 0
	for i = 1, Shape[1]-1 do
		Length = (Shape[i+2][1]-Shape[i+1][1])^2 + (Shape[i+2][2]-Shape[i+1][2])^2 
		if Length > Lmax then
			Lmax = Length
		end
	end
	Length = (Shape[2][1]-Shape[Shape[1]+1][1])^2 + (Shape[2][2]-Shape[Shape[1]+1][2])^2 
	if Length > Lmax then
		Lmax = Length
	end
	Lmax = math.sqrt(Lmax)
	return Lmax
end

function CS_GetLmin(Shape)
	local Lmin, Length
	Lmin = (Shape[2][1]-Shape[Shape[1]+1][1])^2 + (Shape[2][2]-Shape[Shape[1]+1][2])^2 
	for i = 1, Shape[1]-1 do
		Length = (Shape[i+2][1]-Shape[i+1][1])^2 + (Shape[i+2][2]-Shape[i+1][2])^2 
		if Length < Lmin then
			Lmin = Length
		end
	end
	Lmin = math.sqrt(Lmin)
	return Lmin
end

function CS_MakeShape(Path,Radius,Angle,Number,Hollow,Auto,X,Y)
	if X == nil then
		X = 0
	end
	if Y == nil then
		Y = 0
	end
	local NPath
	if Hollow == nil then
		Hollow = 0
	end
	if Auto == 0 then
		Auto = nil
	end
	if Angle == nil then
		Angle = 0 
	end
	NPath = CS_MoveCenter(Path,0,0)
	if Angle ~= 0 then
		NPath = CS_Rotate(NPath,Angle)
	end

	if type(Number) == "number" then
		if Number < Hollow then
			CS_InputError()
		end
		if Auto == nil then
			local Rmax, Shape, RetShape 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			if Hollow == 0 then
				RetShape = {1,{0,0}} 
			else
				RetShape = {0} 
				Hollow = Hollow - 1
			end
			
			for i = Hollow+1, Number-1 do
				if i == 1 then
					Shape = NPath
					if X ~= 0 or Y ~= 0 then
						Shape = CS_MoveXY(Shape,X,Y)
					end
				else
					Shape = CS_ConnectPath(CS_RatioXY(NPath,i,i),i-1,1)
					if X ~= 0 or Y ~= 0 then
						Shape = CS_MoveXY(Shape,X*i,Y*i)
					end
				end
				RetShape = CS_Overlap(RetShape,Shape)
			end
			return RetShape
		else
			local Rmax, Shape, RetShape, Lmax 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			if Hollow == 0 then
				RetShape = {1,{0,0}} 
			else
				RetShape = {0} 
				Hollow = Hollow - 1
			end
			
			for k = Hollow+1, Number-1 do
				if k == 1 then
					if X ~= 0 or Y ~= 0 then
						RetShape = CS_Overlap(RetShape,CS_MoveXY(NPath,X,Y))
					else
						RetShape = CS_Overlap(RetShape,NPath)
					end
				else
					local PX, PY
					PX = X*k
					PY = Y*k
					local Temp = CS_RatioXY(NPath,k,k)
					Lmax = CS_GetLmax(Temp)
					for i = 1, Temp[1]-1 do
						local Length = math.sqrt((Temp[i+2][1]-Temp[i+1][1])^2+(Temp[i+2][2]-Temp[i+1][2])^2)
						local PerNumber = math.floor((Length/Lmax)*k+0.5)
						table.insert(RetShape,{Temp[i+1][1]+PX,Temp[i+1][2]+PY})
						RetShape[1] = RetShape[1] + 1
						for j = 1, PerNumber do
							local NX, NY
							NX = (j*Temp[i+1][1]+(PerNumber-j+1)*Temp[i+2][1])/(PerNumber+1)
							NY = (j*Temp[i+1][2]+(PerNumber-j+1)*Temp[i+2][2])/(PerNumber+1)
							table.insert(RetShape,{NX+PX,NY+PY})
							RetShape[1] = RetShape[1] + 1
						end
					end
					table.insert(RetShape,{Temp[Temp[1]+1][1]+PX,Temp[Temp[1]+1][2]+PY})
					RetShape[1] = RetShape[1] + 1
					local Length = math.sqrt((Temp[Temp[1]+1][1]-Temp[2][1])^2+(Temp[Temp[1]+1][2]-Temp[2][2])^2)
					local PerNumber = math.floor((Length/Lmax)*k+0.5)
					for j = 1, PerNumber do
						local NX, NY
						NX = (j*Temp[Temp[1]+1][1]+(PerNumber-j+1)*Temp[2][1])/(PerNumber+1)
						NY = (j*Temp[Temp[1]+1][2]+(PerNumber-j+1)*Temp[2][2])/(PerNumber+1)
						table.insert(RetShape,{NX+PX,NY+PY})
						RetShape[1] = RetShape[1] + 1
					end
				end
			end
			
			return RetShape
		end
	elseif type(Number) == "table" then
		local Index_1
		for k, v in pairs(Number) do
			if v == 1 then
				Index_1 = 1
			end
		end

		if Auto == nil then
			local Rmax, Shape, RetShape 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			if Index_1 == 1 then
				RetShape = {1,{0,0}}
			else
				RetShape = {0}
			end
				
			for k, v in pairs(Number) do
				if v == 2 then
					Shape = NPath
					if X ~= 0 or Y ~= 0 then
						Shape = CS_MoveXY(Shape,X,Y)
					end
				else
					if v >= 3 then
						Shape = CS_ConnectPath(CS_RatioXY(NPath,v-1,v-1),v-2,1)
						if X ~= 0 or Y ~= 0 then
							Shape = CS_MoveXY(Shape,X*i,Y*i)
						end
					end
				end
				RetShape = CS_Overlap(RetShape,Shape)
			end
			return RetShape
		else
			local Rmax, Shape, RetShape, Lmax 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			if Index_1 == 1 then
				RetShape = {1,{0,0}}
			else
				RetShape = {0}
			end
				
			for k, v in pairs(Number) do
				if v == 2 then
					if X ~= 0 or Y ~= 0 then
						RetShape = CS_Overlap(RetShape,CS_MoveXY(NPath,X,Y))
					else
						RetShape = CS_Overlap(RetShape,NPath)
					end
				else
					if v >= 3 then
						local PX, PY
						PX = X*(v-1)
						PY = Y*(v-1)
						local Temp = CS_RatioXY(NPath,v-1,v-1)
						Lmax = CS_GetLmax(Temp)
						for i = 1, Temp[1]-1 do
							local Length = math.sqrt((Temp[i+2][1]-Temp[i+1][1])^2+(Temp[i+2][2]-Temp[i+1][2])^2)
							local PerNumber = math.floor((Length/Lmax)*(v-1)+0.5)
							table.insert(RetShape,{Temp[i+1][1]+PX,Temp[i+1][2]+PY})
							RetShape[1] = RetShape[1] + 1
							for j = 1, PerNumber do
								local NX, NY
								NX = (j*Temp[i+1][1]+(PerNumber-j+1)*Temp[i+2][1])/(PerNumber+1)
								NY = (j*Temp[i+1][2]+(PerNumber-j+1)*Temp[i+2][2])/(PerNumber+1)
								table.insert(RetShape,{NX+PX,NY+PY})
								RetShape[1] = RetShape[1] + 1
							end
						end
						table.insert(RetShape,{Temp[Temp[1]+1][1]+PX,Temp[Temp[1]+1][2]+PY})
						RetShape[1] = RetShape[1] + 1
						local Length = math.sqrt((Temp[Temp[1]+1][1]-Temp[2][1])^2+(Temp[Temp[1]+1][2]-Temp[2][2])^2)
						local PerNumber = math.floor((Length/Lmax)*(v-1)+0.5)
						for j = 1, PerNumber do
							local NX, NY
							NX = (j*Temp[Temp[1]+1][1]+(PerNumber-j+1)*Temp[2][1])/(PerNumber+1)
							NY = (j*Temp[Temp[1]+1][2]+(PerNumber-j+1)*Temp[2][2])/(PerNumber+1)
							table.insert(RetShape,{NX+PX,NY+PY})
							RetShape[1] = RetShape[1] + 1
						end
					end
				end
			end
			return RetShape
		end
	else
		CS_InputError()
	end
end

function CS_MakeShapeX(Path,Radius,Angle,Number,Hollow,Auto,X,Y)
	if Number >= 1 then
		Number = Number + 1
	end
	if X == nil then
		X = 0
	end
	if Y == nil then
		Y = 0
	end
	local NPath, HalfRad
	if Hollow == nil then
		Hollow = 0
	end
	if Auto == 0 then
		Auto = nil
	end
	if Angle == nil then
		Angle = 0 
	end
	NPath = CS_MoveCenter(Path,0,0)
	if Angle ~= 0 then
		NPath = CS_Rotate(NPath,Angle)
	end

	if type(Number) == "number" then
		if Number < Hollow then
			CS_InputError()
		end
		if Auto == nil then
			local Rmax, Shape, RetShape 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			RetShape = {0} 
			
			for i = Hollow+1, Number-1 do
				if i == 1 then
					Shape = NPath
					if X ~= 0 or Y ~= 0 then
						Shape = CS_MoveXY(CS_RatioXY(Shape,0.5,0.5),X/2,Y/2)
					end
				else
					Shape = CS_ConnectPath(CS_RatioXY(NPath,i-0.5,i-0.5),i-1,1)
					if X ~= 0 or Y ~= 0 then
						Shape = CS_MoveXY(Shape,X*(i-0.5),Y*(i-0.5))
					end
				end
				RetShape = CS_Overlap(RetShape,Shape)
			end
			return RetShape
		else
			local Rmax, Shape, RetShape, Lmax 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			RetShape = {0} 
			
			for k = Hollow+1, Number-1 do
				if k == 1 then
					if X ~= 0 or Y ~= 0 then
						RetShape = CS_Overlap(RetShape,CS_MoveXY(CS_RatioXY(NPath,0.5,0.5),X/2,Y/2))
					else
						RetShape = CS_Overlap(RetShape,CS_RatioXY(NPath,0.5,0.5))
					end
				else
					local PX, PY
					PX = X*(k-0.5)
					PY = Y*(k-0.5)
					local Temp = CS_RatioXY(NPath,k-0.5,k-0.5)
					Lmax = CS_GetLmax(Temp)
					for i = 1, Temp[1]-1 do
						local Length = math.sqrt((Temp[i+2][1]-Temp[i+1][1])^2+(Temp[i+2][2]-Temp[i+1][2])^2)
						local PerNumber = math.floor((Length/Lmax)*(k-0.5)+0.5)
						table.insert(RetShape,{Temp[i+1][1]+PX,Temp[i+1][2]+PY})
						RetShape[1] = RetShape[1] + 1
						for j = 1, PerNumber do
							local NX, NY
							NX = (j*Temp[i+1][1]+(PerNumber-j+1)*Temp[i+2][1])/(PerNumber+1)
							NY = (j*Temp[i+1][2]+(PerNumber-j+1)*Temp[i+2][2])/(PerNumber+1)
							table.insert(RetShape,{NX+PX,NY+PY})
							RetShape[1] = RetShape[1] + 1
						end
					end
					table.insert(RetShape,{Temp[Temp[1]+1][1]+PX,Temp[Temp[1]+1][2]+PY})
					RetShape[1] = RetShape[1] + 1
					local Length = math.sqrt((Temp[Temp[1]+1][1]-Temp[2][1])^2+(Temp[Temp[1]+1][2]-Temp[2][2])^2)
					local PerNumber = math.floor((Length/Lmax)*(k-0.5)+0.5)
					for j = 1, PerNumber do
						local NX, NY
						NX = (j*Temp[Temp[1]+1][1]+(PerNumber-j+1)*Temp[2][1])/(PerNumber+1)
						NY = (j*Temp[Temp[1]+1][2]+(PerNumber-j+1)*Temp[2][2])/(PerNumber+1)
						table.insert(RetShape,{NX+PX,NY+PY})
						RetShape[1] = RetShape[1] + 1
					end
				end
			end
			
			return RetShape
		end
	elseif type(Number) == "table" then

		if Auto == nil then
			local Rmax, Shape, RetShape 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			RetShape = {0} 
				
			for k, v in pairs(Number) do
				if v == 2 then
					Shape = NPath
					if X ~= 0 or Y ~= 0 then
						Shape = CS_MoveXY(CS_RatioXY(Shape,0.5,0.5),X/2,Y/2)
					end
				else
					if v >= 3 then
						Shape = CS_ConnectPath(CS_RatioXY(NPath,v-1.5,v-1.5),v-2,1)
						if X ~= 0 or Y ~= 0 then
							Shape = CS_MoveXY(Shape,X*(i-0.5),Y*(i-0.5))
						end
					end
				end
				RetShape = CS_Overlap(RetShape,Shape)
			end
			return RetShape
		else
			local Rmax, Shape, RetShape, Lmax 
			if Radius ~= nil then
				Rmax = CS_GetRmax(NPath)
				NPath = CS_RatioXY(NPath,Radius/Rmax,Radius/Rmax)
			end
			
			RetShape = {0} 
				
			for k, v in pairs(Number) do
				if v == 2 then
					if X ~= 0 or Y ~= 0 then
						RetShape = CS_Overlap(RetShape,CS_MoveXY(CS_RatioXY(NPath,0.5,0.5),X/2,Y/2))
					else
						RetShape = CS_Overlap(RetShape,CS_RatioXY(Nhape,0.5,0.5))
					end
				else
					if v >= 3 then
						local PX, PY
						PX = X*(v-1.5)
						PY = Y*(v-1.5)
						local Temp = CS_RatioXY(NPath,v-1.5,v-1.5)
						Lmax = CS_GetLmax(Temp)
						for i = 1, Temp[1]-1 do
							local Length = math.sqrt((Temp[i+2][1]-Temp[i+1][1])^2+(Temp[i+2][2]-Temp[i+1][2])^2)
							local PerNumber = math.floor((Length/Lmax)*(v-1.5)+0.5)
							table.insert(RetShape,{Temp[i+1][1]+PX,Temp[i+1][2]+PY})
							RetShape[1] = RetShape[1] + 1
							for j = 1, PerNumber do
								local NX, NY
								NX = (j*Temp[i+1][1]+(PerNumber-j+1)*Temp[i+2][1])/(PerNumber+1)
								NY = (j*Temp[i+1][2]+(PerNumber-j+1)*Temp[i+2][2])/(PerNumber+1)
								table.insert(RetShape,{NX+PX,NY+PY})
								RetShape[1] = RetShape[1] + 1
							end
						end
						table.insert(RetShape,{Temp[Temp[1]+1][1]+PX,Temp[Temp[1]+1][2]+PY})
						RetShape[1] = RetShape[1] + 1
						local Length = math.sqrt((Temp[Temp[1]+1][1]-Temp[2][1])^2+(Temp[Temp[1]+1][2]-Temp[2][2])^2)
						local PerNumber = math.floor((Length/Lmax)*(v-1.5)+0.5)
						for j = 1, PerNumber do
							local NX, NY
							NX = (j*Temp[Temp[1]+1][1]+(PerNumber-j+1)*Temp[2][1])/(PerNumber+1)
							NY = (j*Temp[Temp[1]+1][2]+(PerNumber-j+1)*Temp[2][2])/(PerNumber+1)
							table.insert(RetShape,{NX+PX,NY+PY})
							RetShape[1] = RetShape[1] + 1
						end
					end
				end
			end
			return RetShape
		end
	else
		CS_InputError()
	end
end

function CS_ShapeInShape(Shape,InShape,Rotate,Angle,Radius)
	if Radius ~= nil then
		Rmax = CS_GetRmax(Shape)
		Shape = CS_RatioXY(Shape,Radius/Rmax,Radius/Rmax)
	else
		Shape = Shape
	end
	Shape = CS_MoveCenter(Shape,0,0)
	if Angle ~= nil and Angle ~= 0 then
		Shape = CS_Rotate(Shape,Angle)
	end
	local RetShape = {0}
	for i = 1, InShape[1] do
		local CX = InShape[i+1][1]
		local CY = InShape[i+1][2]
		if Rotate == nil or Rotate == 0 then
			RetShape = CS_Overlap(RetShape,CS_MoveCenter(Shape,CX,CY))
		else
			local CA = math.deg(math.atan2(CX, CY))
			RetShape = CS_Overlap(RetShape,CS_MoveCenter(CS_Rotate(Shape,180-CA),CX,CY))
		end
	end
	return RetShape
end

function CBPlot(Shape,LoopMax,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,Prefunc,PlayerID,Condition,PerAction,Preserve)
	if STRCTRIGASM == 0 then
		Need_STRCTRIGASM()
	end
	CIf(PlayerID,Condition)

	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CD = CAPlotVarAlloc+6
	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ptr
	local TempAct = {}
	local PlotArrX = {}
	local PlotArrY = {}
	local PlotArrN = {}
	CJump(PlayerID,CAPlotJumpAlloc)
		if type(Shape[1]) ~= "number" then
			CBPlotNum = {}
			for i = 1, #Shape do
				if Shape[i][1] < 0 then
					CBPlot_InputError()
				end
				table.insert(TempAct,{})
				local TempArrX = {}
				local TempArrY = {}
				for j = 2, Shape[i][1]+1 do
					table.insert(TempArrX,Shape[i][j][1])
					table.insert(TempArrY,Shape[i][j][2])
				end
				if LoopMax ~= nil then
					if LoopMax[i] ~= nil then
						table.insert(PlotArrN,f_GetFileArrptrN(PlayerID,LoopMax[i],4,1))
						table.insert(CBPlotTNum,LoopMax[i][1])
					else
						table.insert(PlotArrN,"X")
						table.insert(CBPlotTNum,0)
					end
				end
				table.insert(PlotArrX,f_GetFileArrptrN(PlayerID,TempArrX,4,1))
				table.insert(PlotArrY,f_GetFileArrptrN(PlayerID,TempArrY,4,1))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				table.insert(CBPlotNum,Shape[i][1])
			end
			CBPlotFArrN = PlotArrN
		else
			if Shape[1] < 0 then
				CBPlot_InputError()
			end
			local TempArrX = {}
			local TempArrY = {}
			for i = 2, Shape[1]+1 do
				table.insert(TempArrX,Shape[i][1])
				table.insert(TempArrY,Shape[i][2])
			end
			if LoopMax ~= nil then
				PlotArrN = f_GetFileArrptrN(PlayerID,LoopMax,4,1)
				CBPlotFArrN = PlotArrN
				CBPlotTNum = LoopMax[1]
			end 
			PlotArrX = f_GetFileArrptrN(PlayerID,TempArrX,4,1) 
			PlotArrY = f_GetFileArrptrN(PlayerID,TempArrY,4,1) 
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
			CBPlotNum = Shape[1]
		end
		CBPlotFArrX = PlotArrX
		CBPlotFArrY = PlotArrY

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
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5])
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
				CBPlotLoopMaxptr = ptr
			else
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
			end
		elseif LoopMax ~= nil and type(Preset[5]) == "table" and #Preset[5] == 2 then
			if type(Preset[5][1]) == "number" then 
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5][1])
			else
				ptr = CreateVar2(PlayerID,nil,nil,1)
			end
			if type(Preset[5][2]) == "number" then 
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5][2]) -- Loop Limit (고정) [5]
			else
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
			end
			CBPlotLoopMaxptr = ptr
		else
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,1)
				CBPlotLoopMaxptr = ptr
			end
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,0) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------

		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 10
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
		CVariable(PlayerID,CAPlotVarAlloc+10)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	CAPlotDataArr = {CAPlotVarAlloc-23,CAPlotVarAlloc-22,CAPlotVarAlloc-21,CAPlotVarAlloc-20,CAPlotVarAlloc-19,CAPlotVarAlloc-18,CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
	CAPlotPlayerID = PlayerID
	CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
	CAPlotVarAlloc = CAPlotVarAlloc + 8

	if Prefunc ~= nil then -- CB_Func 사용
		_G[Prefunc]()
	end

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
		if LoopMax ~= nil then
			if Preset[5] ~= nil then
				if type(Preset[5]) == "table" and #Preset[5] == 2 then
					if Preset[5][1] ~= nil and type(Preset[5][1]) ~= "number" then
						CMov(PlayerID,ptr,Preset[5][1])
					end
					if Preset[5][2] ~= nil and type(Preset[5][2]) ~= "number" then
						CMov(PlayerID,V(CA[5]),Preset[5][2])
					end
				else
					CMov(PlayerID,ptr,Preset[5])
				end
			end
		else
			CMov(PlayerID,V(CA[5]),Preset[5])
		end
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
	CMov(PlayerID,V(CB[10]),0)

	Trigger {players = {PlayerID},conditions = {Label(CD)},flag = {Preserved}}
	if type(Shape[1]) ~= "number" then
		for i = 1, #Shape do
			TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
		end
	else
		DoActionsX(PlayerID,TempAct)
	end

	if LoopMax ~= nil then
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				if PlotArrN[i] ~= "X" then
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[i][2],0x970,1,0),{Preserved})
				else
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrig1X("X",CA2[7],0x15C,0,SetTo,0),{Preserved})
				end
			end
		else
			DoActionsX(PlayerID,SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[2],0x970,1,0),{Preserved})
		end
		CIf(PlayerID,CVar("X",CA2[7],AtLeast,1))
			f_SHRead(PlayerID,_Add(V(CA2[7]),ptr),V(CA[5]),0xFFFFFFFF,1)
			CTrigger(PlayerID,{TTMemory(V(CA2[7]),Above,ptr),CVar("X",CA[2],Exactly,0)},SetNVar(ptr,Add,1),{Preserved})
		CIfEnd()
	end

	if type(CenterXY) == "number" then
		f_SHRead(PlayerID,LocL,V(CA2[7]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocR,V(CA2[8]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocU,V(CA2[9]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocD,V(CA2[10]),0xFFFFFFFF,1)

		CMov(PlayerID,V(CA2[5]),_iDiv(_Add(V(CA2[7]),V(CA2[8])),2))
		CMov(PlayerID,V(CA2[6]),_iDiv(_Add(V(CA2[9]),V(CA2[10])),2))
	end
	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,Vi(CA[10],-1)),CVar("X",CA[10],AtLeast,1),CVar("X",CA[5],AtLeast,1)})

			if type(Shape[1]) ~= "number" then
				CIfX(PlayerID,CVar("X",CA[1],Exactly,1))
				for i = 1, #Shape do
					f_SHRead(PlayerID,FArr(PlotArrX[i],V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
					f_SHRead(PlayerID,FArr(PlotArrY[i],V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
					if i ~= #Shape then
						CElseIfX(CVar("X",CA[1],Exactly,i+1))
					end
				end
				CIfXEnd()
			else
				f_SHRead(PlayerID,FArr(PlotArrX,V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,FArr(PlotArrY,V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
			end
	-------------------------------------------------------------------------
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_SHRead(PlayerID,LocL,V(CA2[1]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocR,V(CA2[2]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocU,V(CA2[3]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocD,V(CA2[4]),0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			elseif type(CenterXY) == "number" then
				CAdd(PlayerID,V(CA[8]),V(CA2[5]))
				CAdd(PlayerID,V(CA[9]),V(CA2[6]))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end

			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)
			
			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TCreateUnit,V(CB[1]),V(CB[2]),Location,V(CB[3])})
			table.insert(PerAct,SetCVar("X",CA[4],Add,1))
			table.insert(PerAct,SetCVar("X",CA[6],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			elseif type(CenterXY) == "number" then
				CMov(PlayerID,LocL,V(CA2[7]))
				CMov(PlayerID,LocR,V(CA2[8]))
				CMov(PlayerID,LocU,V(CA2[9]))
				CMov(PlayerID,LocD,V(CA2[10]))
			end
			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	if Preserve ~= nil then
		if type(Preserve) == "number" then
			if LoopMax ~= nil then
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0),SetNVar(ptr,SetTo,1)},{Preserved})
			else
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0)},{Preserved})
			end 
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,0))
			if LoopMax ~= nil then
				table.insert(PreAct,SetNVar(ptr,SetTo,1))
			end
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,V(CA[10])}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {{CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}, PlotArrX, PlotArrY, PlotArrN, ptr}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	CBPlotFArrX = {}
	CBPlotFArrY = {}
	CBPlotNum = {}
	CBPlotTNum = {}
	CBPlotFArrN = {}
	CBPlotLoopMaxptr = {}
	return Ret
end

function CBPlotWithProperties(Shape,LoopMax,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,Prefunc,PlayerID,Condition,PerAction,Preserve,Properties)
	if STRCTRIGASM == 0 then
		Need_STRCTRIGASM()
	end
	CIf(PlayerID,Condition)

	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CD = CAPlotVarAlloc+6
	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ptr
	local TempAct = {}
	local PlotArrX = {}
	local PlotArrY = {}
	local PlotArrN = {}
	CJump(PlayerID,CAPlotJumpAlloc)
		if type(Shape[1]) ~= "number" then
			CBPlotNum = {}
			for i = 1, #Shape do
				if Shape[i][1] < 0 then
					CBPlot_InputError()
				end
				table.insert(TempAct,{})
				local TempArrX = {}
				local TempArrY = {}
				for j = 2, Shape[i][1]+1 do
					table.insert(TempArrX,Shape[i][j][1])
					table.insert(TempArrY,Shape[i][j][2])
				end
				if LoopMax ~= nil then
					if LoopMax[i] ~= nil then
						table.insert(PlotArrN,f_GetFileArrptrN(PlayerID,LoopMax[i],4,1))
						table.insert(CBPlotTNum,LoopMax[i][1])
					else
						table.insert(PlotArrN,"X")
						table.insert(CBPlotTNum,0)
					end
				end
				table.insert(PlotArrX,f_GetFileArrptrN(PlayerID,TempArrX,4,1))
				table.insert(PlotArrY,f_GetFileArrptrN(PlayerID,TempArrY,4,1))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				table.insert(CBPlotNum,Shape[i][1])
			end
			CBPlotFArrN = PlotArrN
		else
			if Shape[1] < 0 then
				CBPlot_InputError()
			end
			local TempArrX = {}
			local TempArrY = {}
			for i = 2, Shape[1]+1 do
				table.insert(TempArrX,Shape[i][1])
				table.insert(TempArrY,Shape[i][2])
			end
			if LoopMax ~= nil then
				PlotArrN = f_GetFileArrptrN(PlayerID,LoopMax,4,1)
				CBPlotFArrN = PlotArrN
				CBPlotTNum = LoopMax[1]
			end 
			PlotArrX = f_GetFileArrptrN(PlayerID,TempArrX,4,1) 
			PlotArrY = f_GetFileArrptrN(PlayerID,TempArrY,4,1) 
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
			CBPlotNum = Shape[1]
		end
		CBPlotFArrX = PlotArrX
		CBPlotFArrY = PlotArrY

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
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5])
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
				CBPlotLoopMaxptr = ptr
			else
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
			end
		elseif LoopMax ~= nil and type(Preset[5]) == "table" and #Preset[5] == 2 then
			if type(Preset[5][1]) == "number" then 
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5][1])
			else
				ptr = CreateVar2(PlayerID,nil,nil,1)
			end
			if type(Preset[5][2]) == "number" then 
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5][2]) -- Loop Limit (고정) [5]
			else
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
			end
			CBPlotLoopMaxptr = ptr
		else
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,1)
				CBPlotLoopMaxptr = ptr
			end
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,0) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------

		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 10
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
		CVariable(PlayerID,CAPlotVarAlloc+10)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	CAPlotDataArr = {CAPlotVarAlloc-23,CAPlotVarAlloc-22,CAPlotVarAlloc-21,CAPlotVarAlloc-20,CAPlotVarAlloc-19,CAPlotVarAlloc-18,CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
	CAPlotPlayerID = PlayerID
	CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
	CAPlotVarAlloc = CAPlotVarAlloc + 8

	if Prefunc ~= nil then -- CB_Func 사용
		_G[Prefunc]()
	end

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
		if LoopMax ~= nil then
			if Preset[5] ~= nil then
				if type(Preset[5]) == "table" and #Preset[5] == 2 then
					if Preset[5][1] ~= nil and type(Preset[5][1]) ~= "number" then
						CMov(PlayerID,ptr,Preset[5][1])
					end
					if Preset[5][2] ~= nil and type(Preset[5][2]) ~= "number" then
						CMov(PlayerID,V(CA[5]),Preset[5][2])
					end
				else
					CMov(PlayerID,ptr,Preset[5])
				end
			end
		else
			CMov(PlayerID,V(CA[5]),Preset[5])
		end
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
	CMov(PlayerID,V(CB[10]),0)

	Trigger {players = {PlayerID},conditions = {Label(CD)},flag = {Preserved}}
	if type(Shape[1]) ~= "number" then
		for i = 1, #Shape do
			TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
		end
	else
		DoActionsX(PlayerID,TempAct)
	end

	if LoopMax ~= nil then
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				if PlotArrN[i] ~= "X" then
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[i][2],0x970,1,0),{Preserved})
				else
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrig1X("X",CA2[7],0x15C,0,SetTo,0),{Preserved})
				end
			end
		else
			DoActionsX(PlayerID,SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[2],0x970,1,0),{Preserved})
		end
		CIf(PlayerID,CVar("X",CA2[7],AtLeast,1))
			f_SHRead(PlayerID,_Add(V(CA2[7]),ptr),V(CA[5]),0xFFFFFFFF,1)
			CTrigger(PlayerID,{TTMemory(V(CA2[7]),Above,ptr),CVar("X",CA[2],Exactly,0)},SetNVar(ptr,Add,1),{Preserved})
		CIfEnd()
	end

	if type(CenterXY) == "number" then
		f_SHRead(PlayerID,LocL,V(CA2[7]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocR,V(CA2[8]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocU,V(CA2[9]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocD,V(CA2[10]),0xFFFFFFFF,1)

		CMov(PlayerID,V(CA2[5]),_iDiv(_Add(V(CA2[7]),V(CA2[8])),2))
		CMov(PlayerID,V(CA2[6]),_iDiv(_Add(V(CA2[9]),V(CA2[10])),2))
	end
	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,Vi(CA[10],-1)),CVar("X",CA[10],AtLeast,1),CVar("X",CA[5],AtLeast,1)})

			if type(Shape[1]) ~= "number" then
				CIfX(PlayerID,CVar("X",CA[1],Exactly,1))
				for i = 1, #Shape do
					f_SHRead(PlayerID,FArr(PlotArrX[i],V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
					f_SHRead(PlayerID,FArr(PlotArrY[i],V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
					if i ~= #Shape then
						CElseIfX(CVar("X",CA[1],Exactly,i+1))
					end
				end
				CIfXEnd()
			else
				f_SHRead(PlayerID,FArr(PlotArrX,V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,FArr(PlotArrY,V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
			end
	-------------------------------------------------------------------------
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_SHRead(PlayerID,LocL,V(CA2[1]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocR,V(CA2[2]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocU,V(CA2[3]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocD,V(CA2[4]),0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			elseif type(CenterXY) == "number" then
				CAdd(PlayerID,V(CA[8]),V(CA2[5]))
				CAdd(PlayerID,V(CA[9]),V(CA2[6]))
			else
				CAdd(PlayerID,V(CA[8]),CenterXY[1])
				CAdd(PlayerID,V(CA[9]),CenterXY[2])
			end

			CMov(PlayerID,LocL,V(CA[8]),-PlotSize)
			CMov(PlayerID,LocR,V(CA[8]),PlotSize)
			CMov(PlayerID,LocU,V(CA[9]),-PlotSize)
			CMov(PlayerID,LocD,V(CA[9]),PlotSize)

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TCreateUnitWithProperties,V(CB[1]),V(CB[2]),Location,V(CB[3]),Properties})
			table.insert(PerAct,SetCVar("X",CA[4],Add,1))
			table.insert(PerAct,SetCVar("X",CA[6],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			elseif type(CenterXY) == "number" then
				CMov(PlayerID,LocL,V(CA2[7]))
				CMov(PlayerID,LocR,V(CA2[8]))
				CMov(PlayerID,LocU,V(CA2[9]))
				CMov(PlayerID,LocD,V(CA2[10]))
			end
			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			if LoopMax ~= nil then
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0),SetNVar(ptr,SetTo,1)},{Preserved})
			else
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0)},{Preserved})
			end 
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,0))
			if LoopMax ~= nil then
				table.insert(PreAct,SetNVar(ptr,SetTo,1))
			end
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,V(CA[10])}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {{CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}, PlotArrX, PlotArrY, PlotArrN, ptr}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	CBPlotFArrX = {}
	CBPlotFArrY = {}
	CBPlotNum = {}
	CBPlotTNum = {}
	CBPlotFArrN = {}
	CBPlotLoopMaxptr = {}
	return Ret
end

function CBPlotOrder(Shape,LoopMax,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,OrderType,OrderLocation,DestXY,OrderPreset,CBfunc,OrderSize,Prefunc,PlayerID,Condition,PerAction,Preserve)
	if STRCTRIGASM == 0 then
		Need_STRCTRIGASM()
	end
	CIf(PlayerID,Condition)

	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

	local CD = CAPlotVarAlloc+6
	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ptr
	local TempAct = {}
	local PlotArrX = {}
	local PlotArrY = {}
	local PlotArrN = {}
	CJump(PlayerID,CAPlotJumpAlloc)
		if type(Shape[1]) ~= "number" then
			CBPlotNum = {}
			for i = 1, #Shape do
				if Shape[i][1] < 0 then
					CBPlot_InputError()
				end
				table.insert(TempAct,{})
				local TempArrX = {}
				local TempArrY = {}
				for j = 2, Shape[i][1]+1 do
					table.insert(TempArrX,Shape[i][j][1])
					table.insert(TempArrY,Shape[i][j][2])
				end
				if LoopMax ~= nil then
					if LoopMax[i] ~= nil then
						table.insert(PlotArrN,f_GetFileArrptrN(PlayerID,LoopMax[i],4,1))
						table.insert(CBPlotTNum,LoopMax[i][1])
					else
						table.insert(PlotArrN,"X")
						table.insert(CBPlotTNum,0)
					end
				end
				table.insert(PlotArrX,f_GetFileArrptrN(PlayerID,TempArrX,4,1))
				table.insert(PlotArrY,f_GetFileArrptrN(PlayerID,TempArrY,4,1))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				table.insert(CBPlotNum,Shape[i][1])
			end
			CBPlotFArrN = PlotArrN
		else
			if Shape[1] < 0 then
				CBPlot_InputError()
			end
			local TempArrX = {}
			local TempArrY = {}
			for i = 2, Shape[1]+1 do
				table.insert(TempArrX,Shape[i][1])
				table.insert(TempArrY,Shape[i][2])
			end
			if LoopMax ~= nil then
				PlotArrN = f_GetFileArrptrN(PlayerID,LoopMax,4,1)
				CBPlotFArrN = PlotArrN
				CBPlotTNum = LoopMax[1]
			end 
			PlotArrX = f_GetFileArrptrN(PlayerID,TempArrX,4,1) 
			PlotArrY = f_GetFileArrptrN(PlayerID,TempArrY,4,1) 
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
			CBPlotNum = Shape[1]
		end
		CBPlotFArrX = PlotArrX
		CBPlotFArrY = PlotArrY

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
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5])
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
				CBPlotLoopMaxptr = ptr
			else
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
			end
		elseif LoopMax ~= nil and type(Preset[5]) == "table" and #Preset[5] == 2 then
			if type(Preset[5][1]) == "number" then 
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5][1])
			else
				ptr = CreateVar2(PlayerID,nil,nil,1)
			end
			if type(Preset[5][2]) == "number" then 
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5][2]) -- Loop Limit (고정) [5]
			else
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
			end
			CBPlotLoopMaxptr = ptr
		else
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,1)
				CBPlotLoopMaxptr = ptr
			end
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,0) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------

		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 10
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
		CVariable(PlayerID,CAPlotVarAlloc+10)
		if type(OrderPreset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+11,"X",SetTo,OrderPreset[1]) -- Selected Order Shape (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+11) -- Selected Order Shape (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+12,"X",SetTo,1) -- Order Cur Index (가변)
		CVariable(PlayerID,CAPlotVarAlloc+13) -- Temp Order Index
		CVariable(PlayerID,CAPlotVarAlloc+14)
		CVariable(PlayerID,CAPlotVarAlloc+15)
		CVariable(PlayerID,CAPlotVarAlloc+16)
		CVariable(PlayerID,CAPlotVarAlloc+17)
		CVariable(PlayerID,CAPlotVarAlloc+18)
		CVariable(PlayerID,CAPlotVarAlloc+19)
		CVariable(PlayerID,CAPlotVarAlloc+20)
		CVariable(PlayerID,CAPlotVarAlloc+21)
		CVariable(PlayerID,CAPlotVarAlloc+22)
		CVariable(PlayerID,CAPlotVarAlloc+23)
		CBPlotOrderArr = {CAPlotVarAlloc+11,CAPlotVarAlloc+12,CAPlotVarAlloc+13}
		local CC = {CAPlotVarAlloc+11,CAPlotVarAlloc+12,CAPlotVarAlloc+13,CAPlotVarAlloc+14,CAPlotVarAlloc+15,CAPlotVarAlloc+16,CAPlotVarAlloc+17,CAPlotVarAlloc+18,CAPlotVarAlloc+19,CAPlotVarAlloc+20,CAPlotVarAlloc+21,CAPlotVarAlloc+22,CAPlotVarAlloc+23}
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	CAPlotDataArr = {CAPlotVarAlloc-23,CAPlotVarAlloc-22,CAPlotVarAlloc-21,CAPlotVarAlloc-20,CAPlotVarAlloc-19,CAPlotVarAlloc-18,CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
	CAPlotPlayerID = PlayerID
	CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
	CAPlotVarAlloc = CAPlotVarAlloc + 21

	if Prefunc ~= nil then -- CB_Func 사용
		_G[Prefunc]()
	end

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
		if LoopMax ~= nil then
			if Preset[5] ~= nil then
				if type(Preset[5]) == "table" and #Preset[5] == 2 then
					if Preset[5][1] ~= nil and type(Preset[5][1]) ~= "number" then
						CMov(PlayerID,ptr,Preset[5][1])
					end
					if Preset[5][2] ~= nil and type(Preset[5][2]) ~= "number" then
						CMov(PlayerID,V(CA[5]),Preset[5][2])
					end
				else
					CMov(PlayerID,ptr,Preset[5])
				end
			end
		else
			CMov(PlayerID,V(CA[5]),Preset[5])
		end
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

	CMov(PlayerID,V(CB[10]),0)

	Trigger {players = {PlayerID},conditions = {Label(CD)},flag = {Preserved}}
	if type(Shape[1]) ~= "number" then
		for i = 1, #Shape do
			TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
		end
	else
		DoActionsX(PlayerID,TempAct)
	end

	if LoopMax ~= nil then
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				if PlotArrN[i] ~= "X" then
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[i][2],0x970,1,0),{Preserved})
				else
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrig1X("X",CA2[7],0x15C,0,SetTo,0),{Preserved})
				end
			end
		else
			DoActionsX(PlayerID,SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[2],0x970,1,0),{Preserved})
		end
		CIf(PlayerID,CVar("X",CA2[7],AtLeast,1))
			f_SHRead(PlayerID,_Add(V(CA2[7]),ptr),V(CA[5]),0xFFFFFFFF,1)
			CTrigger(PlayerID,{TTMemory(V(CA2[7]),Above,ptr),CVar("X",CA[2],Exactly,0)},SetNVar(ptr,Add,1),{Preserved})
		CIfEnd()
	end

	if type(CenterXY) == "number" then
		f_SHRead(PlayerID,LocL,V(CA2[7]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocR,V(CA2[8]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocU,V(CA2[9]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocD,V(CA2[10]),0xFFFFFFFF,1)

		CMov(PlayerID,V(CA2[5]),_iDiv(_Add(V(CA2[7]),V(CA2[8])),2))
		CMov(PlayerID,V(CA2[6]),_iDiv(_Add(V(CA2[9]),V(CA2[10])),2))
	end

	if type(DestXY) == "number" then
		f_SHRead(PlayerID,OLocL,V(CC[10]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,OLocR,V(CC[11]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,OLocU,V(CC[12]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,OLocD,V(CC[13]),0xFFFFFFFF,1)

		CMov(PlayerID,V(CC[8]),_iDiv(_Add(V(CC[10]),V(CC[11])),2))
		CMov(PlayerID,V(CC[9]),_iDiv(_Add(V(CC[12]),V(CC[13])),2))
	end

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,Vi(CA[10],-1)),CVar("X",CA[10],AtLeast,1),CVar("X",CA[5],AtLeast,1)})

			if type(Shape[1]) ~= "number" then
				CIfX(PlayerID,CVar("X",CA[1],Exactly,1))
				for i = 1, #Shape do
					f_SHRead(PlayerID,FArr(PlotArrX[i],V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
					f_SHRead(PlayerID,FArr(PlotArrY[i],V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
					if i ~= #Shape then
						CElseIfX(CVar("X",CA[1],Exactly,i+1))
					end
				end
				CIfXEnd()
			else
				f_SHRead(PlayerID,FArr(PlotArrX,V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,FArr(PlotArrY,V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
			end
	-------------------------------------------------------------------------
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_SHRead(PlayerID,LocL,V(CA2[1]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocR,V(CA2[2]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocU,V(CA2[3]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocD,V(CA2[4]),0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			elseif type(CenterXY) == "number" then
				CAdd(PlayerID,V(CA[8]),V(CA2[5]))
				CAdd(PlayerID,V(CA[9]),V(CA2[6]))
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
			if type(Shape[1]) ~= "number" then
				CIfX(PlayerID,CVar("X",CC[1],Exactly,1))
				for i = 1, #Shape do
					f_Read(PlayerID,FArr(PlotArrX[i],V(CA[6])),V(CA[8]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,FArr(PlotArrY[i],V(CA[6])),V(CA[9]),"X",0xFFFFFFFF,1)
					if i ~= #Shape then
						CElseIfX(CVar("X",CC[1],Exactly,i+1))
					end 
				end
				CIfXEnd()
			else
				f_Read(PlayerID,FArr(PlotArrX,V(CA[6])),V(CA[8]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,FArr(PlotArrY,V(CA[6])),V(CA[9]),"X",0xFFFFFFFF,1)
			end
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
			elseif type(DestXY) == "number" then
				CAdd(PlayerID,V(CA[8]),V(CC[8]))
				CAdd(PlayerID,V(CA[9]),V(CC[9]))
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

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TOrder,V(CB[2]),V(CB[3]),Location,OrderType,OrderLocation})
			table.insert(PerAct,SetCVar("X",CB[10],SetTo,0))
			table.insert(PerAct,SetCVar("X",CC[2],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			elseif type(CenterXY) == "number" then
				CMov(PlayerID,LocL,V(CA2[7]))
				CMov(PlayerID,LocR,V(CA2[8]))
				CMov(PlayerID,LocU,V(CA2[9]))
				CMov(PlayerID,LocD,V(CA2[10]))
			end

			if DestXY == nil then
				CMov(PlayerID,OLocL,V(CC[4]))
				CMov(PlayerID,OLocR,V(CC[5]))
				CMov(PlayerID,OLocU,V(CC[6]))
				CMov(PlayerID,OLocD,V(CC[7]))
			elseif type(DestXY) == "number" then
				CMov(PlayerID,OLocL,V(CC[10]))
				CMov(PlayerID,OLocR,V(CC[11]))
				CMov(PlayerID,OLocU,V(CC[12]))
				CMov(PlayerID,OLocD,V(CC[13]))
			end

			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			if LoopMax ~= nil then
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0),SetCVar("X",CC[2],SetTo,0),SetNVar(ptr,SetTo,1)},{Preserved})
			else
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0),SetCVar("X",CC[2],SetTo,0)},{Preserved})
			end 
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,0))
			table.insert(PreAct,SetCVar("X",CC[2],SetTo,0))
			if LoopMax ~= nil then
				table.insert(PreAct,SetNVar(ptr,SetTo,1))
			end
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,V(CA[10])}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {{CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3],CC[1],CC[2]}, PlotArrX, PlotArrY, PlotArrN, ptr}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	CBPlotFArrX = {}
	CBPlotFArrY = {}
	CBPlotNum = {}
	CBPlotTNum = {}
	CBPlotFArrN = {}
	CBPlotLoopMaxptr = {}
	CBPlotOrderArr = {}
	return Ret
end

function CBPlotOrderWithProperties(Shape,LoopMax,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,OrderType,OrderLocation,DestXY,OrderPreset,CBfunc,OrderSize,Prefunc,PlayerID,Condition,PerAction,Preserve,Properties)
	if STRCTRIGASM == 0 then
		Need_STRCTRIGASM()
	end
	CIf(PlayerID,Condition)

	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
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

	local CD = CAPlotVarAlloc+6
	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}
	local ptr
	local TempAct = {}
	local PlotArrX = {}
	local PlotArrY = {}
	local PlotArrN = {}
	CJump(PlayerID,CAPlotJumpAlloc)
		if type(Shape[1]) ~= "number" then
			CBPlotNum = {}
			for i = 1, #Shape do
				if Shape[i][1] < 0 then
					CBPlot_InputError()
				end
				table.insert(TempAct,{})
				local TempArrX = {}
				local TempArrY = {}
				for j = 2, Shape[i][1]+1 do
					table.insert(TempArrX,Shape[i][j][1])
					table.insert(TempArrY,Shape[i][j][2])
				end
				if LoopMax ~= nil then
					if LoopMax[i] ~= nil then
						table.insert(PlotArrN,f_GetFileArrptrN(PlayerID,LoopMax[i],4,1))
						table.insert(CBPlotTNum,LoopMax[i][1])
					else
						table.insert(PlotArrN,"X")
						table.insert(CBPlotTNum,0)
					end
				end
				table.insert(PlotArrX,f_GetFileArrptrN(PlayerID,TempArrX,4,1))
				table.insert(PlotArrY,f_GetFileArrptrN(PlayerID,TempArrY,4,1))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				table.insert(CBPlotNum,Shape[i][1])
			end
			CBPlotFArrN = PlotArrN
		else
			if Shape[1] < 0 then
				CBPlot_InputError()
			end
			local TempArrX = {}
			local TempArrY = {}
			for i = 2, Shape[1]+1 do
				table.insert(TempArrX,Shape[i][1])
				table.insert(TempArrY,Shape[i][2])
			end
			if LoopMax ~= nil then
				PlotArrN = f_GetFileArrptrN(PlayerID,LoopMax,4,1)
				CBPlotFArrN = PlotArrN
				CBPlotTNum = LoopMax[1]
			end 
			PlotArrX = f_GetFileArrptrN(PlayerID,TempArrX,4,1) 
			PlotArrY = f_GetFileArrptrN(PlayerID,TempArrY,4,1) 
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
			CBPlotNum = Shape[1]
		end
		CBPlotFArrX = PlotArrX
		CBPlotFArrY = PlotArrY

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
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5])
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
				CBPlotLoopMaxptr = ptr
			else
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5]) -- Loop Limit (고정) [5]
			end
		elseif LoopMax ~= nil and type(Preset[5]) == "table" and #Preset[5] == 2 then
			if type(Preset[5][1]) == "number" then 
				ptr = CreateVar2(PlayerID,nil,nil,Preset[5][1])
			else
				ptr = CreateVar2(PlayerID,nil,nil,1)
			end
			if type(Preset[5][2]) == "number" then 
				CVariable2(PlayerID,CAPlotVarAlloc+4,"X",SetTo,Preset[5][2]) -- Loop Limit (고정) [5]
			else
				CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
			end
			CBPlotLoopMaxptr = ptr
		else
			if LoopMax ~= nil then
				ptr = CreateVar2(PlayerID,nil,nil,1)
				CBPlotLoopMaxptr = ptr
			end
			CVariable(PlayerID,CAPlotVarAlloc+4) -- Loop Limit (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+5,"X",SetTo,0) -- Current index (가변) [6]
		-------- Preset Limit --------------------------------

		CVariable(PlayerID,CAPlotVarAlloc+7) -- Temp X
		CVariable(PlayerID,CAPlotVarAlloc+8) -- Temp Y
		CVariable(PlayerID,CAPlotVarAlloc+9) -- Temp Sizemax
		CAPlotVarAlloc = CAPlotVarAlloc + 10
		CVariable(PlayerID,CAPlotVarAlloc)
		CVariable(PlayerID,CAPlotVarAlloc+1)
		CVariable(PlayerID,CAPlotVarAlloc+2)
		CVariable(PlayerID,CAPlotVarAlloc+3)
		CVariable(PlayerID,CAPlotVarAlloc+4)
		CVariable(PlayerID,CAPlotVarAlloc+5)
		CVariable(PlayerID,CAPlotVarAlloc+6)
		CVariable(PlayerID,CAPlotVarAlloc+7)
		CVariable(PlayerID,CAPlotVarAlloc+8)
		CVariable(PlayerID,CAPlotVarAlloc+9)
		CA2 = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 10
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
		CVariable(PlayerID,CAPlotVarAlloc+10)
		if type(OrderPreset[1]) == "number" then
			CVariable2(PlayerID,CAPlotVarAlloc+11,"X",SetTo,OrderPreset[1]) -- Selected Order Shape (고정) [1]
		else
			CVariable(PlayerID,CAPlotVarAlloc+11) -- Selected Order Shape (고정)
		end
		CVariable2(PlayerID,CAPlotVarAlloc+12,"X",SetTo,1) -- Order Cur Index (가변)
		CVariable(PlayerID,CAPlotVarAlloc+13) -- Temp Order Index
		CVariable(PlayerID,CAPlotVarAlloc+14)
		CVariable(PlayerID,CAPlotVarAlloc+15)
		CVariable(PlayerID,CAPlotVarAlloc+16)
		CVariable(PlayerID,CAPlotVarAlloc+17)
		CVariable(PlayerID,CAPlotVarAlloc+18)
		CVariable(PlayerID,CAPlotVarAlloc+19)
		CVariable(PlayerID,CAPlotVarAlloc+20)
		CVariable(PlayerID,CAPlotVarAlloc+21)
		CVariable(PlayerID,CAPlotVarAlloc+22)
		CVariable(PlayerID,CAPlotVarAlloc+23)
		CBPlotOrderArr = {CAPlotVarAlloc+11,CAPlotVarAlloc+12,CAPlotVarAlloc+13}
		local CC = {CAPlotVarAlloc+11,CAPlotVarAlloc+12,CAPlotVarAlloc+13,CAPlotVarAlloc+14,CAPlotVarAlloc+15,CAPlotVarAlloc+16,CAPlotVarAlloc+17,CAPlotVarAlloc+18,CAPlotVarAlloc+19,CAPlotVarAlloc+20,CAPlotVarAlloc+21,CAPlotVarAlloc+22,CAPlotVarAlloc+23}
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	CAPlotDataArr = {CAPlotVarAlloc-23,CAPlotVarAlloc-22,CAPlotVarAlloc-21,CAPlotVarAlloc-20,CAPlotVarAlloc-19,CAPlotVarAlloc-18,CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
	CAPlotPlayerID = PlayerID
	CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6}
	CAPlotVarAlloc = CAPlotVarAlloc + 21

	if Prefunc ~= nil then -- CB_Func 사용
		_G[Prefunc]()
	end

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
		if LoopMax ~= nil then
			if Preset[5] ~= nil then
				if type(Preset[5]) == "table" and #Preset[5] == 2 then
					if Preset[5][1] ~= nil and type(Preset[5][1]) ~= "number" then
						CMov(PlayerID,ptr,Preset[5][1])
					end
					if Preset[5][2] ~= nil and type(Preset[5][2]) ~= "number" then
						CMov(PlayerID,V(CA[5]),Preset[5][2])
					end
				else
					CMov(PlayerID,ptr,Preset[5])
				end
			end
		else
			CMov(PlayerID,V(CA[5]),Preset[5])
		end
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

	CMov(PlayerID,V(CB[10]),0)

	Trigger {players = {PlayerID},conditions = {Label(CD)},flag = {Preserved}}
	if type(Shape[1]) ~= "number" then
		for i = 1, #Shape do
			TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
		end
	else
		DoActionsX(PlayerID,TempAct)
	end

	if LoopMax ~= nil then
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				if PlotArrN[i] ~= "X" then
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[i][2],0x970,1,0),{Preserved})
				else
					TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),SetCtrig1X("X",CA2[7],0x15C,0,SetTo,0),{Preserved})
				end
			end
		else
			DoActionsX(PlayerID,SetCtrigX("X",CA2[7],0x15C,0,SetTo,"X",PlotArrN[2],0x970,1,0),{Preserved})
		end
		CIf(PlayerID,CVar("X",CA2[7],AtLeast,1))
			f_SHRead(PlayerID,_Add(V(CA2[7]),ptr),V(CA[5]),0xFFFFFFFF,1)
			CTrigger(PlayerID,{TTMemory(V(CA2[7]),Above,ptr),CVar("X",CA[2],Exactly,0)},SetNVar(ptr,Add,1),{Preserved})
		CIfEnd()
	end

	if type(CenterXY) == "number" then
		f_SHRead(PlayerID,LocL,V(CA2[7]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocR,V(CA2[8]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocU,V(CA2[9]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,LocD,V(CA2[10]),0xFFFFFFFF,1)

		CMov(PlayerID,V(CA2[5]),_iDiv(_Add(V(CA2[7]),V(CA2[8])),2))
		CMov(PlayerID,V(CA2[6]),_iDiv(_Add(V(CA2[9]),V(CA2[10])),2))
	end

	if type(DestXY) == "number" then
		f_SHRead(PlayerID,OLocL,V(CC[10]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,OLocR,V(CC[11]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,OLocU,V(CC[12]),0xFFFFFFFF,1)
		f_SHRead(PlayerID,OLocD,V(CC[13]),0xFFFFFFFF,1)

		CMov(PlayerID,V(CC[8]),_iDiv(_Add(V(CC[10]),V(CC[11])),2))
		CMov(PlayerID,V(CC[9]),_iDiv(_Add(V(CC[12]),V(CC[13])),2))
	end

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0)})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,Vi(CA[10],-1)),CVar("X",CA[10],AtLeast,1),CVar("X",CA[5],AtLeast,1)})

			if type(Shape[1]) ~= "number" then
				CIfX(PlayerID,CVar("X",CA[1],Exactly,1))
				for i = 1, #Shape do
					f_SHRead(PlayerID,FArr(PlotArrX[i],V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
					f_SHRead(PlayerID,FArr(PlotArrY[i],V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
					if i ~= #Shape then
						CElseIfX(CVar("X",CA[1],Exactly,i+1))
					end
				end
				CIfXEnd()
			else
				f_SHRead(PlayerID,FArr(PlotArrX,V(CA[6])),V(CA[8]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,FArr(PlotArrY,V(CA[6])),V(CA[9]),0xFFFFFFFF,1)
			end
	-------------------------------------------------------------------------
			if CAfunc ~= nil then
				_G[CAfunc]()
			end
			NJump(PlayerID,CAPlotJumpAlloc,CVar("X",CB[10],AtLeast,1),{SetCVar("X",CB[10],SetTo,0),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1)})
	-------------------------------------------------------------------------
			if CenterXY == nil then
				f_SHRead(PlayerID,LocL,V(CA2[1]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocR,V(CA2[2]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocU,V(CA2[3]),0xFFFFFFFF,1)
				f_SHRead(PlayerID,LocD,V(CA2[4]),0xFFFFFFFF,1)

				CAdd(PlayerID,V(CA[8]),_iDiv(_Add(V(CA2[1]),V(CA2[2])),2))
				CAdd(PlayerID,V(CA[9]),_iDiv(_Add(V(CA2[3]),V(CA2[4])),2))
			elseif type(CenterXY) == "number" then
				CAdd(PlayerID,V(CA[8]),V(CA2[5]))
				CAdd(PlayerID,V(CA[9]),V(CA2[6]))
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
			if type(Shape[1]) ~= "number" then
				CIfX(PlayerID,CVar("X",CC[1],Exactly,1))
				for i = 1, #Shape do
					f_Read(PlayerID,FArr(PlotArrX[i],V(CA[6])),V(CA[8]),"X",0xFFFFFFFF,1)
					f_Read(PlayerID,FArr(PlotArrY[i],V(CA[6])),V(CA[9]),"X",0xFFFFFFFF,1)
					if i ~= #Shape then
						CElseIfX(CVar("X",CC[1],Exactly,i+1))
					end 
				end
				CIfXEnd()
			else
				f_Read(PlayerID,FArr(PlotArrX,V(CA[6])),V(CA[8]),"X",0xFFFFFFFF,1)
				f_Read(PlayerID,FArr(PlotArrY,V(CA[6])),V(CA[9]),"X",0xFFFFFFFF,1)
			end
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
			elseif type(DestXY) == "number" then
				CAdd(PlayerID,V(CA[8]),V(CC[8]))
				CAdd(PlayerID,V(CA[9]),V(CC[9]))
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

			local PerAct = {}
			if PerAction == nil then PerAction = {} end
			table.insert(PerAct,{TOrder,V(CB[2]),V(CB[3]),Location,OrderType,OrderLocation})
			table.insert(PerAct,SetCVar("X",CB[10],SetTo,0))
			table.insert(PerAct,SetCVar("X",CC[2],Add,1))
			for p, q in pairs(PerAction) do
				table.insert(PerAct,q)
			end
			CDoActionsX(PlayerID,PerAct)

			if CenterXY == nil then
				CMov(PlayerID,LocL,V(CA2[1]))
				CMov(PlayerID,LocR,V(CA2[2]))
				CMov(PlayerID,LocU,V(CA2[3]))
				CMov(PlayerID,LocD,V(CA2[4]))
			elseif type(CenterXY) == "number" then
				CMov(PlayerID,LocL,V(CA2[7]))
				CMov(PlayerID,LocR,V(CA2[8]))
				CMov(PlayerID,LocU,V(CA2[9]))
				CMov(PlayerID,LocD,V(CA2[10]))
			end

			if DestXY == nil then
				CMov(PlayerID,OLocL,V(CC[4]))
				CMov(PlayerID,OLocR,V(CC[5]))
				CMov(PlayerID,OLocU,V(CC[6]))
				CMov(PlayerID,OLocD,V(CC[7]))
			elseif type(DestXY) == "number" then
				CMov(PlayerID,OLocL,V(CC[10]))
				CMov(PlayerID,OLocR,V(CC[11]))
				CMov(PlayerID,OLocU,V(CC[12]))
				CMov(PlayerID,OLocD,V(CC[13]))
			end

			NJumpEnd(PlayerID,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		NElseX()
			CDoActions(PlayerID,{TSetCVar("X",CA[2],SetTo,V(CA[3])),SetCVar("X",CA[4],SetTo,0)})
			CJump(PlayerID,CAPlotJumpAlloc)
		NIfXEnd()
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			if LoopMax ~= nil then
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0),SetCVar("X",CC[2],SetTo,0),SetNVar(ptr,SetTo,1)},{Preserved})
			else
				CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,V(CA[10]))},{SetCVar("X",CA[6],SetTo,0),SetCVar("X",CC[2],SetTo,0)},{Preserved})
			end 
		else
			local PreAct = {}
			table.insert(PreAct,SetCVar("X",CA[6],SetTo,0))
			table.insert(PreAct,SetCVar("X",CC[2],SetTo,0))
			if LoopMax ~= nil then
				table.insert(PreAct,SetNVar(ptr,SetTo,1))
			end
			for p, q in pairs(Preserve) do
				table.insert(PreAct,q)
			end
			CTriggerX(PlayerID,{{TCVar,"X",CA[6],AtLeast,V(CA[10])}},PreAct,{Preserved})
		end
	end
CIfEnd(SetCVar("X",CA[2],Subtract,1))
	local Ret = {{CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3],CC[1],CC[2]}, PlotArrX, PlotArrY, PlotArrN, ptr}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	CBPlotFArrX = {}
	CBPlotFArrY = {}
	CBPlotNum = {}
	CBPlotTNum = {}
	CBPlotFArrN = {}
	CBPlotLoopMaxptr = {}
	CBPlotOrderArr = {}
	return Ret
end

CBPlotTempArr = 0
FCBCONVRACall1 = 0
FCBCONVRACall2 = 0
FCBCONVRACheck = 0
FCBCONVRAAlloc = 0
FCBCONVXYCall1 = 0
FCBCONVXYCall2 = 0
FCBCONVXYCheck = 0
FCBCONVXYAlloc = 0
FCBMOVECall1 = 0
FCBMOVECall2 = 0
FCBMOVECheck = 0
FCBMOVEAlloc = 0
FCBMOVECNTRCall1 = 0
FCBMOVECNTRCall2 = 0
FCBMOVECNTRCheck = 0
FCBMOVECNTRAlloc = 0
FCBINVTCall1 = 0
FCBINVTCall2 = 0
FCBINVTCheck = 0
FCBINVTAlloc = 0
FCBRATOCall1 = 0
FCBRATOCall2 = 0
FCBRATOCheck = 0
FCBRATOAlloc = 0
FCBROTACall1 = 0
FCBROTACall2 = 0
FCBROTACheck = 0
FCBROTAAlloc = 0
FCBROTA3DCall1 = 0
FCBROTA3DCall2 = 0
FCBROTA3DCheck = 0
FCBROTA3DAlloc = 0
FCBCROPCall1 = 0
FCBCROPCall2 = 0
FCBCROPCheck = 0
FCBCROPAlloc = 0
FCBMIRXCall1 = 0
FCBMIRXCall2 = 0
FCBMIRXCheck = 0
FCBMIRXAlloc = 0
FCBMIRYCall1 = 0
FCBMIRYCall2 = 0
FCBMIRYCheck = 0
FCBMIRYAlloc = 0
FCBDTRNCall1 = 0
FCBDTRNCall2 = 0
FCBDTRNCheck = 0
FCBDTRNAlloc = 0
FCBDTRN2Call1 = 0
FCBDTRN2Call2 = 0
FCBDTRN2Check = 0
FCBDTRN2Alloc = 0
FCBWARPCall1 = 0
FCBWARPCall2 = 0
FCBWARPCheck = 0
FCBWARPAlloc = 0
FCBKADSXCall1 = 0
FCBKADSXCall2 = 0
FCBKADSXCheck = 0
FCBKADSXAlloc = 0
FCBKADSX2Call1 = 0
FCBKADSX2Call2 = 0
FCBKADSX2Check = 0
FCBKADSX2Alloc = 0
FCBKADSCall1 = 0
FCBKADSCall2 = 0
FCBKADSCheck = 0
FCBKADSAlloc = 0
FCBKADS2Call1 = 0
FCBKADS2Call2 = 0
FCBKADS2Check = 0
FCBKADS2Alloc = 0
FCBVECTCall1 = 0
FCBVECTCall2 = 0
FCBVECTCheck = 0
FCBVECTAlloc = 0
FCBSHISCall1 = 0
FCBSHISCall2 = 0
FCBSHISCheck = 0
FCBSHISAlloc = 0
FCBCROPACall1 = 0
FCBCROPACall2 = 0
FCBCROPACheck = 0
FCBCROPAAlloc = 0
FCBCROPGCall1 = 0
FCBCROPGCall2 = 0
FCBCROPGCheck = 0
FCBCROPGAlloc = 0
FCBCOPYCall1 = 0
FCBCOPYCall2 = 0
FCBCOPYCheck = 0
FCBCOPYAlloc = 0
FCBFILLCall1 = 0
FCBFILLCall2 = 0
FCBFILLCheck = 0
FCBFILLAlloc = 0
FCBDRAWCall1 = 0
FCBDRAWCall2 = 0
FCBDRAWCheck = 0
FCBDRAWAlloc = 0
FCBDRAW2Call1 = 0
FCBDRAW2Call2 = 0
FCBDRAW2Check = 0
FCBDRAW2Alloc = 0
FCBDELTCall1 = 0
FCBDELTCall2 = 0
FCBDELTCheck = 0
FCBDELTAlloc = 0
FCBOVERCall1 = 0
FCBOVERCall2 = 0
FCBOVERCheck = 0
FCBOVERAlloc = 0
FCBOVERXCall1 = 0
FCBOVERXCall2 = 0
FCBOVERXCheck = 0
FCBOVERXAlloc = 0
FCBMERGCall1 = 0
FCBMERGCall2 = 0
FCBMERGCheck = 0
FCBMERGAlloc = 0
FCBMERGXCall1 = 0
FCBMERGXCall2 = 0
FCBMERGXCheck = 0
FCBMERGXAlloc = 0
FCBINTSCall1 = 0
FCBINTSCall2 = 0
FCBINTSCheck = 0
FCBINTSAlloc = 0
FCBXORCall1 = 0
FCBXORCall2 = 0
FCBXORCheck = 0
FCBXORAlloc = 0
FCBSUBTCall1 = 0
FCBSUBTCall2 = 0
FCBSUBTCheck = 0
FCBSUBTAlloc = 0
FCBRMSTCall1 = 0
FCBRMSTCall2 = 0
FCBRMSTCheck = 0
FCBRMSTAlloc = 0
FCBXMAXCall1 = 0
FCBXMAXCall2 = 0
FCBXMAXCheck = 0
FCBXMAXAlloc = 0
FCBXMINCall1 = 0
FCBXMINCall2 = 0
FCBXMINCheck = 0
FCBXMINAlloc = 0
FCBXCNTRCall1 = 0
FCBXCNTRCall2 = 0
FCBXCNTRCheck = 0
FCBXCNTRAlloc = 0
FCBTCPYCall1 = 0
FCBTCPYCall2 = 0
FCBTCPYCheck = 0
FCBTCPYAlloc = 0
FCBTDELCall1 = 0
FCBTDELCall2 = 0
FCBTDELCheck = 0
FCBTDELAlloc = 0
FCBSORTCall1 = 0
FCBSORTCall2 = 0
FCBSORTCheck = 0
FCBSORTAlloc = 0
FCBSPLTCall1 = 0
FCBSPLTCall2 = 0
FCBSPLTCheck = 0
FCBSPLTAlloc = 0
FCBSHFLCall1 = 0
FCBSHFLCall2 = 0
FCBSHFLCheck = 0
FCBSHFLAlloc = 0
FCBSHFLSwitch = 0
FCBRVRSCall1 = 0
FCBRVRSCall2 = 0
FCBRVRSCheck = 0
FCBRVRSAlloc = 0

FCBPAINTCheck = 0
FCBPAINTCVoid = 0
FCBPAINTCVArr = 0
CheckInclude_CBPaint = 0
function Include_CBLast(IncludePlayer)
	local CVoid = FCBPAINTCVoid
	local CV = FCBPAINTCVArr
if FCBRVRSCheck == 1 then
	-- CB_Reverse - CV[1] = Start / CV[2] = End / CV[3] : Shape Limit / CV[4] : Shape[1]
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : TempX / CV[8] : TempY / CV[9] : X / CV[10] : Y / CV[11] : k / CV[12] : k-x
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBRVRSAlloc);
			},
			actions = {SetNVar(CV[13],SetTo,0)},
			flag = {Preserved}
		}
	CTrigger(IncludePlayer,{TNVar(CV[2],AtLeast,CV[3])},{TSetNVar(CV[2],SetTo,CV[3])},{Preserved})
	CTrigger(IncludePlayer,{TTNVar(CV[2],iAtLeast,CV[4])},{TSetNVar(CV[2],SetTo,CV[4])},{Preserved})
	CAdd(IncludePlayer,CV[11],CV[2],CV[1])
	CSub(IncludePlayer,CV[14],_Div(_Add(_Sub(CV[2],CV[1]),1),2),1)
	CWhileX(IncludePlayer,{TNVar(CV[13],AtMost,CV[14])})
		CSub(IncludePlayer,CV[12],CV[11],CV[1])

		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		f_SHRead(IncludePlayer,_Add(CV[5],CV[12]),CV[7])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[12]),CV[8])

		CWrite(IncludePlayer,_Add(CV[5],CV[12]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[6],CV[12]),CV[10]) -- Y
		CWrite(IncludePlayer,_Add(CV[5],CV[1]),CV[7]) -- X
		CWrite(IncludePlayer,_Add(CV[6],CV[1]),CV[8]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[13],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBRVRSAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBSHFLCheck == 1 then
	-- CB_Shuffle - CV[1] = Start / CV[2] = End / CV[3] : Shape Limit / CV[4] : Shape[1]
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : TempX / CV[8] : TempY / CV[9] : X / CV[10] : Y / CV[11] : k / CV[12] : k-x
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSHFLAlloc);
			},
			flag = {Preserved}
		}
	CTrigger(IncludePlayer,{TNVar(CV[2],AtLeast,CV[3])},{TSetNVar(CV[2],SetTo,CV[3])},{Preserved})
	CTrigger(IncludePlayer,{TTNVar(CV[2],iAtLeast,CV[4])},{TSetNVar(CV[2],SetTo,CV[4])},{Preserved})
	CMov(IncludePlayer,CV[13],CV[1])
	CAdd(IncludePlayer,CV[14],_Sub(CV[2],CV[1]),1)
	CLoop(IncludePlayer,2)
		CMov(IncludePlayer,CV[1],CV[13])
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
			CAdd(IncludePlayer,CV[12],_Mod(_Rand(),CV[14]),CV[13])

			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
			f_SHRead(IncludePlayer,_Add(CV[5],CV[12]),CV[7])
			f_SHRead(IncludePlayer,_Add(CV[6],CV[12]),CV[8])

			CWrite(IncludePlayer,_Add(CV[5],CV[12]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[6],CV[12]),CV[10]) -- Y
			CWrite(IncludePlayer,_Add(CV[5],CV[1]),CV[7]) -- X
			CWrite(IncludePlayer,_Add(CV[6],CV[1]),CV[8]) -- Y
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CWhileEnd()
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSHFLAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end
	
if FCBCONVRACheck == 1 then
	-- CB_ConvertRA - CV[1] : Shape Loop / CV[2] : Shape Limit / CV[3] : RetShape Loop / CV[4] : RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : R / CV[12] : A
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCONVRAAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		f_Sqrt(IncludePlayer,CV[11],_Add(_iMul(CV[9],CV[9]),_iMul(CV[10],CV[10])))
		f_Atan2(IncludePlayer,CV[10],CV[9],CV[12])

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[11]) -- R
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[12]) -- A
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCONVRAAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBCONVXYCheck == 1 then
	-- CB_ConvertXY - CV[1] : Shape Loop / CV[2] : Shape Limit / CV[3] : RetShape Loop / CV[4] : RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : R / CV[10] : A / CV[11] : X / CV[12] : Y
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCONVXYAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		f_Lengthdir(IncludePlayer,CV[9],CV[10],CV[11],CV[12])

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[11]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[12]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCONVXYAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBMOVECheck == 1 then
	-- CB_Move - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMOVEAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		CAdd(IncludePlayer,CV[9],CV[11])
		CAdd(IncludePlayer,CV[10],CV[12])

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMOVEAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBMOVECNTRCheck == 1 then
	-- CB_MoveCenter - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : XCntr / CV[12] : YCntr
	-- CV[13] : Xmin / CV[14] : Xmax / CV[15] : Ymin / CV[16] : Ymax / CV[17] : dx / CV[18] : dy
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMOVECNTRAlloc);
			},
			actions = {
				SetNVar(CV[13],SetTo,0x7FFFFFFF);
				SetNVar(CV[14],SetTo,0x80000000);
				SetNVar(CV[15],SetTo,0x7FFFFFFF);
				SetNVar(CV[16],SetTo,0x80000000);
			},
			flag = {Preserved}
		}

	CMov(IncludePlayer,0x6509B0,CV[5])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[14],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[14]) -- Xmin
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[13],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[13]) -- Xmax
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CMov(IncludePlayer,0x6509B0,CV[6])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[16],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[16]) -- Ymin
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[15],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[15]) -- Ymax
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	CMov(IncludePlayer,CV[17],_iSub(CV[11],_iDiv(_Add(CV[13],CV[14]),2)))
	CMov(IncludePlayer,CV[18],_iSub(CV[12],_iDiv(_Add(CV[15],CV[16]),2)))

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		CAdd(IncludePlayer,CV[9],CV[17])
		CAdd(IncludePlayer,CV[10],CV[18])

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMOVECNTRAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBINVTCheck == 1 then
	-- CB_Invert - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : x=X / CV[12] : y=Y / CV[13] : (==1) X Invert On / CV[14] : (==1) Y Invert On / CV[15] : RetX / CV[16] : RetY
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBINVTAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CIf(IncludePlayer,NVar(CV[13],Exactly,1))
			CMov(IncludePlayer,CV[15],_iSub(_Add(CV[11],CV[11]),CV[9]))
		CIfEnd()
		CIf(IncludePlayer,NVar(CV[14],Exactly,1))
			CMov(IncludePlayer,CV[16],_iSub(_Add(CV[12],CV[12]),CV[10]))
		CIfEnd()

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[15]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[16]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBINVTAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBRATOCheck == 1 then
	-- CB_Ratio - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : imulX / CV[12] : (==1) iMulX On / CV[13] : idivX / CV[14] : (==1) iDivX On 
	-- CV[15] : imulY / CV[16] : (==1) iMulY On / CV[17] : idivY / CV[18] : (==1) iDivY On 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBRATOAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CIf(IncludePlayer,NVar(CV[12],Exactly,1)) -- imulX
			f_iMul(IncludePlayer,CV[9],CV[11])
		CIfEnd()
		CIf(IncludePlayer,NVar(CV[14],Exactly,1)) -- idivX
			f_iDiv(IncludePlayer,CV[9],CV[13])
		CIfEnd()
		CIf(IncludePlayer,NVar(CV[16],Exactly,1)) -- imulY
			f_iMul(IncludePlayer,CV[10],CV[15])
		CIfEnd()
		CIf(IncludePlayer,NVar(CV[18],Exactly,1)) -- idivY
			f_iDiv(IncludePlayer,CV[10],CV[17])
		CIfEnd()

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBRATOAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBROTACheck == 1 then
	-- CB_Rotate - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : Angle / CV[12] : XCos / CV[13] : XSin / CV[14] : YCos / CV[15] : YSin / CV[16] : RetX / CV[17] : RetY
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBROTAAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		f_Lengthdir(IncludePlayer,CV[9],CV[11],CV[12],CV[13]) -- XCos XSin 
		f_Lengthdir(IncludePlayer,CV[10],CV[11],CV[14],CV[15]) -- YCos YSin

		CMov(IncludePlayer,CV[16],_iSub(CV[12],CV[15])) -- XCos - YSin
		CMov(IncludePlayer,CV[17],_Add(CV[13],CV[14])) -- XSin + YCos

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[16]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[17]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBROTAAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBROTA3DCheck == 1 then
	-- CB_Rotate3D - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : Z
	-- CV[12] : XYAngle / CV[13] : YZAngle / CV[14] : ZXAngle / CV[17] : uCos / CV[18] : uSin / CV[19] : vCos / CV[20] : vSin 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBROTA3DAlloc);
			},
			actions = {
				SetNVar(CV[11],SetTo,0);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CIf(IncludePlayer,NVar(CV[12],AtLeast,1)) -- XYAngle
			f_Lengthdir(IncludePlayer,CV[9],CV[12],CV[17],CV[18]) -- XCos XSin 
			f_Lengthdir(IncludePlayer,CV[10],CV[12],CV[19],CV[20]) -- YCos YSin

			CMov(IncludePlayer,CV[9],_iSub(CV[17],CV[20])) -- XCos - YSin
			CMov(IncludePlayer,CV[10],_Add(CV[18],CV[19])) -- XSin + YCos
		CIfEnd()

		CIf(IncludePlayer,NVar(CV[13],AtLeast,1)) -- YZAngle
			f_Lengthdir(IncludePlayer,CV[10],CV[13],CV[17],CV[18]) -- YCos YSin 

			CMov(IncludePlayer,CV[10],CV[17]) -- YCos
			CMov(IncludePlayer,CV[11],CV[18]) -- YSin
		CIfEnd()

		CIf(IncludePlayer,NVar(CV[14],AtLeast,1)) -- ZXAngle
			f_Lengthdir(IncludePlayer,CV[9],CV[14],CV[17],CV[18]) -- XCos XSin 
			f_Lengthdir(IncludePlayer,CV[11],CV[14],CV[19],CV[20]) -- ZCos ZSin

			CMov(IncludePlayer,CV[9],_iSub(CV[17],CV[20])) -- XCos - ZSin
		CIfEnd()

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBROTA3DAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBMIRXCheck == 1 then
	-- CB_MirrorX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : x=X / CV[12] : Side / CV[13] : 2X 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMIRXAlloc);
			},
			flag = {Preserved}
		}

	CMov(IncludePlayer,CV[13],_Add(CV[11],CV[11]))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		CIfX(IncludePlayer,NVar(CV[12],Exactly,0))
			CIf(IncludePlayer,{TTNVar(CV[9],iAtLeast,CV[11])})
				f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),_iSub(CV[13],CV[9])) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
			CIfEnd()
		CElseX()
			CIf(IncludePlayer,{TTNVar(CV[9],iAtMost,CV[11])})
				f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),_iSub(CV[13],CV[9])) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
			CIfEnd()
		CIfXEnd()
	CWhileXEnd({SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMIRXAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBMIRYCheck == 1 then
	-- CB_MirrorY - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : y=Y / CV[12] : Side / CV[13] : 2Y 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMIRYAlloc);
			},
			flag = {Preserved}
		}

	CMov(IncludePlayer,CV[13],_Add(CV[11],CV[11]))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		CIfX(IncludePlayer,NVar(CV[12],Exactly,0))
			CIf(IncludePlayer,{TTNVar(CV[10],iAtLeast,CV[11])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[13],CV[10])) -- Y
				CAdd(IncludePlayer,CV[3],1)
			CIfEnd()
		CElseX()
			CIf(IncludePlayer,{TTNVar(CV[10],iAtMost,CV[11])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[13],CV[10])) -- Y
				CAdd(IncludePlayer,CV[3],1)
			CIfEnd()
		CIfXEnd()
	CWhileXEnd({SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMIRYAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBDTRNCheck == 1 then
	-- CB_Distortion - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : XLU / CV[12] : YLU / CV[13] : XLD / CV[14] : YLD / CV[15] : XRU / CV[16] : YRU / CV[17] : XRD / CV[18] : YRD
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[31] : R1Y1 / CV[32] : R1Y2 / CV[33] : R2Y1 / CV[34] : R2Y2 
	-- CV[35] : R3X1 / CV[36] : R3X2 / CV[37] : R4X1 / CV[38] : R4X2 / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin
	-- CV[41] : R1ΔY / CV[42] : R2ΔY / CV[43] : R3ΔX / CV[44] : R4ΔX / CV[45] : ΔX*XCntr / CV[46] : ΔY*YCntr 
	-- CV[47] : R1k / CV[48] : R2k / CV[49] : R3k / CV[50] : R4k
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDTRNAlloc);
			},
			actions = {
				SetNVar(CV[26],SetTo,0x7FFFFFFF);
				SetNVar(CV[25],SetTo,0x80000000);
				SetNVar(CV[28],SetTo,0x7FFFFFFF);
				SetNVar(CV[27],SetTo,0x80000000);
				SetNVar(CV[47],SetTo,0);
				SetNVar(CV[48],SetTo,0);
			},
			flag = {Preserved}
		}

	CMov(IncludePlayer,0x6509B0,CV[5])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[26],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[26]) -- Xmin
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[25],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[25]) -- Xmax
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CMov(IncludePlayer,0x6509B0,CV[6])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[28],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[28]) -- Ymin
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[27],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[27]) -- Ymax
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	CMov(IncludePlayer,CV[29],_iDiv(_Add(CV[26],CV[25]),2)) -- XCntr
	CMov(IncludePlayer,CV[30],_iDiv(_Add(CV[28],CV[27]),2)) -- YCntr
	CMov(IncludePlayer,CV[39],_iSub(CV[25],CV[26]))
	CMov(IncludePlayer,CV[40],_iSub(CV[27],CV[28]))

	CIfX(IncludePlayer,NVar(CV[12],Exactly,1))
		CMov(IncludePlayer,CV[31],CV[27]) -- Y1
	CElseX()
		CMov(IncludePlayer,CV[31],_Add(_iMul(_iSub(CV[27],CV[30]),CV[12]),CV[30])) -- Y1
	CIfXEnd()
	CIfX(IncludePlayer,NVar(CV[16],Exactly,1))
		CMov(IncludePlayer,CV[32],CV[27]) -- Y2
	CElseX()
		CMov(IncludePlayer,CV[32],_Add(_iMul(_iSub(CV[27],CV[30]),CV[16]),CV[30])) -- Y2
	CIfXEnd()

	CIfX(IncludePlayer,NVar(CV[14],Exactly,1))
		CMov(IncludePlayer,CV[33],CV[28]) -- Y1
	CElseX()
		CMov(IncludePlayer,CV[33],_Add(_iMul(_iSub(CV[28],CV[30]),CV[14]),CV[30])) -- Y1
	CIfXEnd()
	CIfX(IncludePlayer,NVar(CV[18],Exactly,1))
		CMov(IncludePlayer,CV[34],CV[28]) -- Y2
	CElseX()
		CMov(IncludePlayer,CV[34],_Add(_iMul(_iSub(CV[28],CV[30]),CV[18]),CV[30])) -- Y2
	CIfXEnd()

	CIfX(IncludePlayer,NVar(CV[17],Exactly,1))
		CMov(IncludePlayer,CV[35],CV[25]) -- Y1
	CElseX()
		CMov(IncludePlayer,CV[35],_Add(_iMul(_iSub(CV[25],CV[29]),CV[17]),CV[29])) -- Y1
	CIfXEnd()
	CIfX(IncludePlayer,NVar(CV[15],Exactly,1))
		CMov(IncludePlayer,CV[36],CV[25]) -- Y2
	CElseX()
		CMov(IncludePlayer,CV[36],_Add(_iMul(_iSub(CV[25],CV[29]),CV[15]),CV[29])) -- Y2
	CIfXEnd()

	CIfX(IncludePlayer,NVar(CV[13],Exactly,1))
		CMov(IncludePlayer,CV[37],CV[26]) -- Y1
	CElseX()
		CMov(IncludePlayer,CV[37],_Add(_iMul(_iSub(CV[26],CV[29]),CV[13]),CV[29])) -- Y1
	CIfXEnd()
	CIfX(IncludePlayer,NVar(CV[11],Exactly,1))
		CMov(IncludePlayer,CV[38],CV[26]) -- Y2
	CElseX()
		CMov(IncludePlayer,CV[38],_Add(_iMul(_iSub(CV[26],CV[29]),CV[11]),CV[29])) -- Y2
	CIfXEnd()

	CMov(IncludePlayer,CV[41],_iSub(CV[32],CV[31]))
	CMov(IncludePlayer,CV[42],_iSub(CV[34],CV[33]))
	CMov(IncludePlayer,CV[43],_iSub(CV[36],CV[35]))
	CMov(IncludePlayer,CV[44],_iSub(CV[38],CV[37]))
	CMov(IncludePlayer,CV[45],_iMul(CV[29],CV[39]))
	CMov(IncludePlayer,CV[46],_iMul(CV[30],CV[40]))

	CMov(IncludePlayer,CV[47],_iDiv(_Mul(CV[41],65536),CV[39]))
	CMov(IncludePlayer,CV[48],_iDiv(_Mul(CV[42],65536),CV[39]))
	CMov(IncludePlayer,CV[49],_iDiv(_Mul(CV[43],65536),CV[40]))
	CMov(IncludePlayer,CV[50],_iDiv(_Mul(CV[44],65536),CV[40]))

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TNVar(CV[3],AtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		CIfX(IncludePlayer,NVar(CV[41],Exactly,0))
			CMov(IncludePlayer,CV[21],_iMul(_iSub(CV[10],CV[28]),CV[31]))
		CElseX()
			CMov(IncludePlayer,CV[21],_iMul(_iSub(CV[10],CV[28]),_Add(_iDiv(_iMul(_iSub(_Add(CV[9],CV[19]),CV[26]),CV[47]),65536),CV[31])))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[42],Exactly,0))
			CMov(IncludePlayer,CV[22],_iMul(_iSub(CV[27],CV[10]),CV[33]))
		CElseX()
			CMov(IncludePlayer,CV[22],_iMul(_iSub(CV[27],CV[10]),_Add(_iDiv(_iMul(_iSub(_Add(CV[9],CV[19]),CV[26]),CV[48]),65536),CV[33])))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[43],Exactly,0))
			CMov(IncludePlayer,CV[23],_iMul(_iSub(CV[9],CV[26]),CV[35]))
		CElseX()
			CMov(IncludePlayer,CV[23],_iMul(_iSub(CV[9],CV[26]),_Add(_iDiv(_iMul(_iSub(_Add(CV[10],CV[20]),CV[28]),CV[49]),65536),CV[35])))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[44],Exactly,0))
			CMov(IncludePlayer,CV[24],_iMul(_iSub(CV[25],CV[9]),CV[37]))
		CElseX()
			CMov(IncludePlayer,CV[24],_iMul(_iSub(CV[25],CV[9]),_Add(_iDiv(_iMul(_iSub(_Add(CV[10],CV[20]),CV[28]),CV[50]),65536),CV[37])))
		CIfXEnd()

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),_iDiv(_Add(_Add(CV[23],CV[24]),CV[45]),CV[39])) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),_iDiv(_Add(_Add(CV[21],CV[22]),CV[46]),CV[40])) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDTRNAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBDTRN2Check == 1 then
	-- CB_Distortion2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : XLU / CV[12] : YLU / CV[13] : XLD / CV[14] : YLD / CV[15] : XRU / CV[16] : YRU / CV[17] : XRD / CV[18] : YRD
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[31] : R1Y1 / CV[32] : R1Y2 / CV[33] : R2Y1 / CV[34] : R2Y2 
	-- CV[35] : R3X1 / CV[36] : R3X2 / CV[37] : R4X1 / CV[38] : R4X2 / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin
	-- CV[41] : R1ΔY / CV[42] : R2ΔY / CV[43] : R3ΔX / CV[44] : R4ΔX / CV[45] : ΔX*XCntr / CV[46] : ΔY*YCntr 
	-- CV[47] : R1k / CV[48] : R2k / CV[49] : R3k / CV[50] : R4k
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDTRN2Alloc);
			},
			actions = {
				SetNVar(CV[26],SetTo,0x7FFFFFFF);
				SetNVar(CV[25],SetTo,0x80000000);
				SetNVar(CV[28],SetTo,0x7FFFFFFF);
				SetNVar(CV[27],SetTo,0x80000000);
				SetNVar(CV[47],SetTo,0);
				SetNVar(CV[48],SetTo,0);
			},
			flag = {Preserved}
		}

	CMov(IncludePlayer,0x6509B0,CV[5])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[26],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[26]) -- Xmin
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[25],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[25]) -- Xmax
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CMov(IncludePlayer,0x6509B0,CV[6])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[28],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[28]) -- Ymin
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[27],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[27]) -- Ymax
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	CMov(IncludePlayer,CV[29],_iDiv(_Add(CV[26],CV[25]),2)) -- XCntr
	CMov(IncludePlayer,CV[30],_iDiv(_Add(CV[28],CV[27]),2)) -- YCntr
	CMov(IncludePlayer,CV[39],_iSub(CV[25],CV[26]))
	CMov(IncludePlayer,CV[40],_iSub(CV[27],CV[28]))

	CMov(IncludePlayer,CV[31],_Add(CV[27],CV[12])) -- Y1
	CMov(IncludePlayer,CV[32],_Add(CV[27],CV[16])) -- Y2

	CMov(IncludePlayer,CV[33],_iSub(CV[28],CV[14])) -- Y1
	CMov(IncludePlayer,CV[34],_iSub(CV[28],CV[18])) -- Y2

	CMov(IncludePlayer,CV[35],_Add(CV[25],CV[17])) -- X1
	CMov(IncludePlayer,CV[36],_Add(CV[25],CV[15])) -- X2

	CMov(IncludePlayer,CV[37],_iSub(CV[26],CV[13])) -- X1
	CMov(IncludePlayer,CV[38],_iSub(CV[26],CV[11])) -- X2

	CMov(IncludePlayer,CV[41],_iSub(CV[32],CV[31]))
	CMov(IncludePlayer,CV[42],_iSub(CV[34],CV[33]))
	CMov(IncludePlayer,CV[43],_iSub(CV[36],CV[35]))
	CMov(IncludePlayer,CV[44],_iSub(CV[38],CV[37]))
	CMov(IncludePlayer,CV[45],_iMul(CV[29],CV[39]))
	CMov(IncludePlayer,CV[46],_iMul(CV[30],CV[40]))

	CMov(IncludePlayer,CV[47],_iDiv(_Mul(CV[41],65536),CV[39]))
	CMov(IncludePlayer,CV[48],_iDiv(_Mul(CV[42],65536),CV[39]))
	CMov(IncludePlayer,CV[49],_iDiv(_Mul(CV[43],65536),CV[40]))
	CMov(IncludePlayer,CV[50],_iDiv(_Mul(CV[44],65536),CV[40]))

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TNVar(CV[3],AtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		CIfX(IncludePlayer,NVar(CV[41],Exactly,0))
			CMov(IncludePlayer,CV[21],_iMul(_iSub(CV[10],CV[28]),CV[31]))
		CElseX()
			CMov(IncludePlayer,CV[21],_iMul(_iSub(CV[10],CV[28]),_Add(_iDiv(_iMul(_iSub(_Add(CV[9],CV[19]),CV[26]),CV[47]),65536),CV[31])))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[42],Exactly,0))
			CMov(IncludePlayer,CV[22],_iMul(_iSub(CV[27],CV[10]),CV[33]))
		CElseX()
			CMov(IncludePlayer,CV[22],_iMul(_iSub(CV[27],CV[10]),_Add(_iDiv(_iMul(_iSub(_Add(CV[9],CV[19]),CV[26]),CV[48]),65536),CV[33])))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[43],Exactly,0))
			CMov(IncludePlayer,CV[23],_iMul(_iSub(CV[9],CV[26]),CV[35]))
		CElseX()
			CMov(IncludePlayer,CV[23],_iMul(_iSub(CV[9],CV[26]),_Add(_iDiv(_iMul(_iSub(_Add(CV[10],CV[20]),CV[28]),CV[49]),65536),CV[35])))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[44],Exactly,0))
			CMov(IncludePlayer,CV[24],_iMul(_iSub(CV[25],CV[9]),CV[37]))
		CElseX()
			CMov(IncludePlayer,CV[24],_iMul(_iSub(CV[25],CV[9]),_Add(_iDiv(_iMul(_iSub(_Add(CV[10],CV[20]),CV[28]),CV[50]),65536),CV[37])))
		CIfXEnd()

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),_iDiv(_Add(_Add(CV[23],CV[24]),CV[45]),CV[39])) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),_iDiv(_Add(_Add(CV[21],CV[22]),CV[46]),CV[40])) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDTRN2Alloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBWARPCheck == 1 then
-- CB_Warping - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : UFunc Init / CV[12] : UFunc End / CV[13] : DFunc Init / CV[14] : DFunc End / CV[15] : LFunc Init / CV[16] : LFunc End / CV[17] : RFunc Init / CV[18] : RFunc End
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin / CV[45] : ΔX*XCntr / CV[46] : ΔY*YCntr 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBWARPAlloc);
			},
			actions = {
				SetNVar(CV[26],SetTo,0x7FFFFFFF);
				SetNVar(CV[25],SetTo,0x80000000);
				SetNVar(CV[28],SetTo,0x7FFFFFFF);
				SetNVar(CV[27],SetTo,0x80000000);
				SetNVar(CV[47],SetTo,0);
				SetNVar(CV[48],SetTo,0);
			},
			flag = {Preserved}
		}
	FCBWARPAlloc = FCBWARPAlloc + 1
	CMov(IncludePlayer,0x6509B0,CV[5])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[26],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[26]) -- Xmin
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[25],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[25]) -- Xmax
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CMov(IncludePlayer,0x6509B0,CV[6])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[28],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[28]) -- Ymin
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[27],0)})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[27]) -- Ymax
			CMov(IncludePlayer,0x6509B0,CV[6])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	CMov(IncludePlayer,CV[29],_iDiv(_Add(CV[26],CV[25]),2)) -- XCntr
	CMov(IncludePlayer,CV[30],_iDiv(_Add(CV[28],CV[27]),2)) -- YCntr
	CMov(IncludePlayer,CV[39],_iSub(CV[25],CV[26]))
	CMov(IncludePlayer,CV[40],_iSub(CV[27],CV[28]))
	CMov(IncludePlayer,CV[45],_iMul(CV[29],CV[39]))
	CMov(IncludePlayer,CV[46],_iMul(CV[30],CV[40]))

	CMov(IncludePlayer,CFuncParaVarArr[3],CV[25])
	CMov(IncludePlayer,CFuncParaVarArr[4],CV[26])
	CMov(IncludePlayer,CFuncParaVarArr[5],CV[29])
	CMov(IncludePlayer,CFuncParaVarArr[6],CV[27])
	CMov(IncludePlayer,CFuncParaVarArr[7],CV[28])
	CMov(IncludePlayer,CFuncParaVarArr[8],CV[30])

	DoActionsX(IncludePlayer,SetNVar(CV[1],SetTo,0))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		CIfX(IncludePlayer,NVar(CV[11],Exactly,0))
			CMov(IncludePlayer,CV[21],_iMul(_iSub(CV[10],CV[28]),CV[27]))
		CElseX()
			CMov(IncludePlayer,CFuncParaVarArr[1],_Add(CV[9],CV[19]))
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x15C,0),CV[11])
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x178,0),CV[12])
			Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBWARPAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
						SetNVar(CFuncParaVarArr[2],SetTo,0); -- UFunc
					},
					flag = {Preserved}
				}
			FCBWARPAlloc = FCBWARPAlloc + 1
			CMov(IncludePlayer,CV[21],_iMul(_iSub(CV[10],CV[28]),CFuncRetVarArr[1]))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[13],Exactly,0))
			CMov(IncludePlayer,CV[22],_iMul(_iSub(CV[27],CV[10]),CV[28]))
		CElseX()
			CMov(IncludePlayer,CFuncParaVarArr[1],_Add(CV[9],CV[19]))
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x15C,0),CV[13])
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x178,0),CV[14])
			Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBWARPAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
						SetNVar(CFuncParaVarArr[2],SetTo,1); -- DFunc
					},
					flag = {Preserved}
				}
			FCBWARPAlloc = FCBWARPAlloc + 1
			CMov(IncludePlayer,CV[22],_iMul(_iSub(CV[27],CV[10]),CFuncRetVarArr[1]))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[15],Exactly,0))
			CMov(IncludePlayer,CV[23],_iMul(_iSub(CV[9],CV[26]),CV[25]))
		CElseX()
			CMov(IncludePlayer,CFuncParaVarArr[1],_Add(CV[10],CV[20]))
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x15C,0),CV[15])
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x178,0),CV[16])
			Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBWARPAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
						SetNVar(CFuncParaVarArr[2],SetTo,2); -- LFunc
					},
					flag = {Preserved}
				}
			FCBWARPAlloc = FCBWARPAlloc + 1
			CMov(IncludePlayer,CV[23],_iMul(_iSub(CV[9],CV[26]),CFuncRetVarArr[1]))
		CIfXEnd()

		CIfX(IncludePlayer,NVar(CV[17],Exactly,0))
			CMov(IncludePlayer,CV[24],_iMul(_iSub(CV[25],CV[9]),CV[26]))
		CElseX()
			CMov(IncludePlayer,CFuncParaVarArr[1],_Add(CV[10],CV[20]))
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x15C,0),CV[17])
			CMov(IncludePlayer,Mem("X",FCBWARPAlloc,0x178,0),CV[18])
			Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBWARPAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
						SetNVar(CFuncParaVarArr[2],SetTo,3); -- RFunc
					},
					flag = {Preserved}
				}
			FCBWARPAlloc = FCBWARPAlloc + 1
			CMov(IncludePlayer,CV[24],_iMul(_iSub(CV[25],CV[9]),CFuncRetVarArr[1]))
		CIfXEnd()

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),_iDiv(_Add(_Add(CV[23],CV[24]),CV[45]),CV[39])) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),_iDiv(_Add(_Add(CV[21],CV[22]),CV[46]),CV[40])) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBWARPAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBKADSXCheck == 1 then
	-- CB_KaleidoscopeX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : CV[4] - n
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADSXAlloc);
			},
			actions = {
				SetNVar(CV[15],SetTo,AngleCycle);
				SetNVar(CV[18],SetTo,AngleCycle);
			},
			flag = {Preserved}
		}
	FCBKADSXAlloc = FCBKADSXAlloc + 1

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],Exactly,0);
			},
			actions = {
				SetNVar(CV[11],SetTo,1);
			},
			flag = {Preserved}
		}
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],AtLeast,AngleCycle+1);
			},
			actions = {
				SetNVar(CV[11],SetTo,AngleCycle);
			},
			flag = {Preserved}
		}

	CiDiv(IncludePlayer,CV[15],CV[11])
	CiSub(IncludePlayer,CV[4],CV[11])
	CIfX(IncludePlayer,NVar(CV[13],Exactly,0))
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{NVar(CV[10],AtLeast,0),TTNVar(CV[10],iAtMost,CV[15])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1)),SetNVar(CV[16],SetTo,AngleCycle)})
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1))
					CMov(IncludePlayer,CV[14],_Div(CV[16],CV[11]))
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[10],CV[14])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1),SetNVar(CV[16],Add,AngleCycle)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CElseX()
		CiSub(IncludePlayer,CV[18],CV[15])
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{TTNVar(CV[10],iAtLeast,CV[18]),TTNVar(CV[10],iAtMost,AngleCycle)})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1)),SetNVar(CV[16],SetTo,AngleCycle)})
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1))
					CMov(IncludePlayer,CV[14],_Div(CV[16],CV[11]))
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[10],CV[14])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1),SetNVar(CV[16],Add,AngleCycle)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CIfXEnd()

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADSXAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBKADSX2Check == 1 then
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADSX2Alloc);
			},
			actions = {
				SetNVar(CV[15],SetTo,AngleCycle);
				SetNVar(CV[18],SetTo,AngleCycle);
			},
			flag = {Preserved}
		}
	FCBKADSX2Alloc = FCBKADSX2Alloc + 1

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],Exactly,0);
			},
			actions = {
				SetNVar(CV[11],SetTo,1);
			},
			flag = {Preserved}
		}
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],AtLeast,AngleCycle+1);
			},
			actions = {
				SetNVar(CV[11],SetTo,AngleCycle);
			},
			flag = {Preserved}
		}

	f_Div(IncludePlayer,CV[14],_Mov(AngleCycle),CV[11])
	CMov(IncludePlayer,CV[19],V(CRet[2]))
	CiDiv(IncludePlayer,CV[15],CV[11])
	CiSub(IncludePlayer,CV[4],CV[11])
	CIfX(IncludePlayer,NVar(CV[13],Exactly,0))
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{NVar(CV[10],AtLeast,0),TTNVar(CV[10],iAtMost,CV[15])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1)),SetNVar(CV[16],SetTo,0)})
				CMov(IncludePlayer,CV[20],CV[19])
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1),{TSetNVar(CV[16],Add,CV[14])})
					TriggerX(IncludePlayer,NVar(CV[20],AtLeast,1),{SetNVar(CV[16],Add,1),SetNVar(CV[20],Subtract,1)})
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[10],CV[16])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CElseX()
		CiSub(IncludePlayer,CV[18],CV[15])
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{TTNVar(CV[10],iAtLeast,CV[18]),TTNVar(CV[10],iAtMost,AngleCycle)})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1)),SetNVar(CV[16],SetTo,0)})
				CMov(IncludePlayer,CV[20],CV[19])
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1),{TSetNVar(CV[16],Add,CV[14])})
					TriggerX(IncludePlayer,NVar(CV[20],AtLeast,1),{SetNVar(CV[16],Add,1),SetNVar(CV[20],Subtract,1)})
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[10],CV[16])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CIfXEnd()

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADSX2Alloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBKADSCheck == 1 then
	-- CB_Kaleidoscope - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : Mirror Angle / CV[20] : 2*Point / CV[21] : Temp / CV[22] : Temp2
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADSAlloc);
			},
			actions = {
				SetNVar(CV[15],SetTo,AngleCycle);
				SetNVar(CV[18],SetTo,AngleCycle);
			},
			flag = {Preserved}
		}
	FCBKADSAlloc = FCBKADSAlloc + 1

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],Exactly,0);
			},
			actions = {
				SetNVar(CV[11],SetTo,1);
			},
			flag = {Preserved}
		}
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],AtLeast,math.floor(AngleCycle/2)+1);
			},
			actions = {
				SetNVar(CV[11],SetTo,math.floor(AngleCycle/2));
			},
			flag = {Preserved}
		}

	CMov(IncludePlayer,CV[20],_Add(CV[11],CV[11]))
	CMov(IncludePlayer,CV[21],_Div(CV[15],CV[11]))
	CMov(IncludePlayer,CV[22],_iSub(_Mov(2*AngleCycle),CV[21]))
	CiDiv(IncludePlayer,CV[15],CV[20])
	CiSub(IncludePlayer,CV[4],CV[11])
	CIfX(IncludePlayer,NVar(CV[13],Exactly,0))
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{NVar(CV[10],AtLeast,0),TTNVar(CV[10],iAtMost,CV[15])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				DoActionsX(IncludePlayer,{SetNVar(CV[3],Add,1),SetNVar(CV[16],SetTo,AngleCycle)})
				
				CMov(IncludePlayer,CV[19],_iSub(CV[21],CV[10]))
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[19]) -- A
				
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1))})
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1))
					CMov(IncludePlayer,CV[14],_Div(CV[16],CV[11]))
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[10],CV[14])) -- A
					CAdd(IncludePlayer,CV[3],1)
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[19],CV[14])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1),SetNVar(CV[16],Add,AngleCycle)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CElseX()
		CiSub(IncludePlayer,CV[18],CV[15])
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{TTNVar(CV[10],iAtLeast,CV[18]),TTNVar(CV[10],iAtMost,AngleCycle)})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				DoActionsX(IncludePlayer,{SetNVar(CV[3],Add,1),SetNVar(CV[16],SetTo,AngleCycle)})
				
				CMov(IncludePlayer,CV[19],_iSub(CV[22],CV[10]))
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[19]) -- A
				
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1))})
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1))
					CMov(IncludePlayer,CV[14],_Div(CV[16],CV[11]))
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[10],CV[14])) -- A
					CAdd(IncludePlayer,CV[3],1)
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[19],CV[14])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1),SetNVar(CV[16],Add,AngleCycle)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CIfXEnd()

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADSAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBKADS2Check == 1 then
	-- CB_Kaleidoscope2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : Mirror Angle / CV[20] : 2*Point / CV[21] : Q / CV[22] : R
	-- CV[23] : Loop R / CV[24] : Temp / CV[25] : Temp2 // Cycle = Q*n + R
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADS2Alloc);
			},
			actions = {
				SetNVar(CV[15],SetTo,AngleCycle);
				SetNVar(CV[18],SetTo,AngleCycle);
			},
			flag = {Preserved}
		}
	FCBKADS2Alloc = FCBKADS2Alloc + 1

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],Exactly,0);
			},
			actions = {
				SetNVar(CV[11],SetTo,1);
			},
			flag = {Preserved}
		}
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(0);
				NVar(CV[11],AtLeast,math.floor(AngleCycle/2)+1);
			},
			actions = {
				SetNVar(CV[11],SetTo,math.floor(AngleCycle/2));
			},
			flag = {Preserved}
		}

	CMov(IncludePlayer,CV[20],_Add(CV[11],CV[11]))
	CMov(IncludePlayer,CV[24],_Div(CV[15],CV[11]))
	CMov(IncludePlayer,CV[25],_iSub(_Mov(2*AngleCycle),CV[24]))
	CiDiv(IncludePlayer,CV[15],CV[20])
	f_Div(IncludePlayer,CV[21],_Mov(AngleCycle),CV[11])
	CMov(IncludePlayer,CV[22],V(CRet[2]))
	CiSub(IncludePlayer,CV[4],CV[11])
	CIfX(IncludePlayer,NVar(CV[13],Exactly,0))
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{NVar(CV[10],AtLeast,0),TTNVar(CV[10],iAtMost,CV[15])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				DoActionsX(IncludePlayer,{SetNVar(CV[3],Add,1),SetNVar(CV[16],SetTo,0)})
				
				CMov(IncludePlayer,CV[19],_iSub(CV[24],CV[10]))
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[19]) -- A
				
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1))})
				CMov(IncludePlayer,CV[23],CV[22])
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1),{TSetNVar(CV[16],Add,CV[21])})
					TriggerX(IncludePlayer,NVar(CV[23],AtLeast,1),{SetNVar(CV[16],Add,1),SetNVar(CV[23],Subtract,1)})
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[10],CV[16])) -- A
					CAdd(IncludePlayer,CV[3],1)
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[19],CV[16])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CElseX()
		CiSub(IncludePlayer,CV[18],CV[15])
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- A
			CiSub(IncludePlayer,CV[10],CV[12])
			CIf(IncludePlayer,{TTNVar(CV[10],iAtLeast,CV[18]),TTNVar(CV[10],iAtMost,AngleCycle)})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- A
				DoActionsX(IncludePlayer,{SetNVar(CV[3],Add,1),SetNVar(CV[16],SetTo,0)})
				
				CMov(IncludePlayer,CV[19],_iSub(CV[25],CV[10]))
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[19]) -- A
				
				CDoActions(IncludePlayer,{SetNVar(CV[3],Add,1),TSetNVar(CV[17],SetTo,Vi(CV[11][2],-1))})
				CMov(IncludePlayer,CV[23],CV[22])
				CWhileX(IncludePlayer,NVar(CV[17],AtLeast,1),{TSetNVar(CV[16],Add,CV[21])})
					TriggerX(IncludePlayer,NVar(CV[23],AtLeast,1),{SetNVar(CV[16],Add,1),SetNVar(CV[23],Subtract,1)})
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[10],CV[16])) -- A
					CAdd(IncludePlayer,CV[3],1)
					CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- R
					CWrite(IncludePlayer,_Add(CV[8],CV[3]),_iSub(CV[19],CV[16])) -- A
				CWhileXEnd({SetNVar(CV[17],Subtract,1),SetNVar(CV[3],Add,1)})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[1],Add,1)})
	CIfXEnd()

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBKADS2Alloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBCROPCheck == 1 then
	-- CB_Crop - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : X1 / CV[12] : (==1) X1 On / CV[13] : X2 / CV[14] : (==1) X2 On  / CV[19] : Check
	-- CV[15] : Y1 / CV[16] : (==1) Y1 On / CV[17] : Y2 / CV[18] : (==1) Y2 On / CV[20] : RetNumber
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCROPAlloc);
			},
			actions = {
				SetNVar(CV[20],SetTo,0);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])},SetNVar(CV[19],SetTo,0))
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CIf(IncludePlayer,NVar(CV[12],Exactly,1)) -- X1
			CTrigger(IncludePlayer,{TTNVar(CV[9],iBelow,CV[11])},SetNVar(CV[19],SetTo,1),{Preserved})
		CIfEnd()
		CIf(IncludePlayer,NVar(CV[14],Exactly,1)) -- X2
			CTrigger(IncludePlayer,{TTNVar(CV[9],iAbove,CV[13])},SetNVar(CV[19],SetTo,1),{Preserved})
		CIfEnd()
		CIf(IncludePlayer,NVar(CV[16],Exactly,1)) -- Y1
			CTrigger(IncludePlayer,{TTNVar(CV[10],iBelow,CV[15])},SetNVar(CV[19],SetTo,1),{Preserved})
		CIfEnd()
		CIf(IncludePlayer,NVar(CV[18],Exactly,1)) -- Y2
			CTrigger(IncludePlayer,{TTNVar(CV[10],iAbove,CV[17])},SetNVar(CV[19],SetTo,1),{Preserved})
		CIfEnd()

		CIf(IncludePlayer,NVar(CV[19],Exactly,0),SetNVar(CV[20],Add,1))
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
			DoActionsX(IncludePlayer,SetNVar(CV[3],Add,1))
		CIfEnd()
	CWhileXEnd({SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCROPAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBCROPACheck == 1 then
	-- CB_CropPath - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : PFArrX / CV[12] : PFArrY / CV[13] : Outside / CV[14] : Path Loop / CV[15] : Path Limit
	-- CV[17] : PX / CV[18] : PY / CV[19] : PX2 / CV[20] : PY2 / CV[21] : Intersect / CV[22] : Cond1 / CV[23] : Cond2 / 
	-- CV[24] : Path Loop+1 / CV[16] : RetX
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCROPAAlloc);
			},
			flag = {Preserved}
		}
	FCBCROPAAlloc = FCBCROPAAlloc + 1
	
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[21],SetTo,0),SetNVar(CV[14],SetTo,0),SetNVar(CV[24],SetTo,1)})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9]) -- Px
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10]) -- Py

		CWhileX(IncludePlayer,{TTNVar(CV[14],iAtMost,CV[15])},{SetNVar(CV[22],SetTo,0),SetNVar(CV[23],SetTo,0)})
			CTrigger(IncludePlayer,{TNVar(CV[14],Exactly,CV[15])},{SetNVar(CV[24],SetTo,0)},{Preserved})
			f_SHRead(IncludePlayer,_Add(CV[11],CV[14]),CV[17]) -- Pix
			f_SHRead(IncludePlayer,_Add(CV[12],CV[14]),CV[18]) -- Piy
			f_SHRead(IncludePlayer,_Add(CV[11],CV[24]),CV[19]) -- Pi+1x
			f_SHRead(IncludePlayer,_Add(CV[12],CV[24]),CV[20]) -- Pi+1y

			CTrigger(IncludePlayer,{TTNVar(CV[18],iAbove,CV[10])},{SetNVar(CV[22],SetTo,1)},{Preserved})
			CTrigger(IncludePlayer,{TTNVar(CV[20],iAbove,CV[10])},{SetNVar(CV[23],SetTo,1)},{Preserved})

			CIf(IncludePlayer,{TTNVar(CV[22],NotSame,CV[23])})
				CIfX(IncludePlayer,{TNVar(CV[18],Exactly,CV[20])})
					CIfX(IncludePlayer,{TNVar(CV[17],iAtLeast,CV[19])})
						CMov(IncludePlayer,CV[16],CV[19])
					CElseX()
						CMov(IncludePlayer,CV[16],CV[17])
					CIfXEnd()
				CElseX()
					CMov(IncludePlayer,CV[16],_Add(_iDiv(_iMul(_iSub(CV[10],CV[18]),_iSub(CV[19],CV[17])),_iSub(CV[20],CV[18])),CV[17]))
				CIfXEnd()

				CTrigger(IncludePlayer,{TTNVar(CV[9],iBelow,CV[16])},{SetNVar(CV[21],Add,1)},{Preserved})
			CIfEnd()
		CWhileXEnd({SetNVar(CV[14],Add,1),SetNVar(CV[24],Add,1)})

		CIfX(IncludePlayer,{NVar(CV[13],Exactly,0),NVar(CV[21],Exactly,1,1)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
			DoActionsX(IncludePlayer,SetNVar(CV[3],Add,1))
		CElseIfX({NVar(CV[13],AtLeast,1),NVar(CV[21],Exactly,0,1)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
			DoActionsX(IncludePlayer,SetNVar(CV[3],Add,1))
		CIfXEnd()
	CWhileXEnd({SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCROPAAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBCROPGCheck == 1 then
	-- CB_CropGraph - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] ~ CV[12] : CropFunc / CV[13] : Sign 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCROPGAlloc);
			},
			flag = {Preserved}
		}
	FCBCROPGAlloc = FCBCROPGAlloc + 1

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CMov(IncludePlayer,CFuncParaVarArr[1],CV[9])
		CMov(IncludePlayer,CFuncParaVarArr[2],CV[10])
		CMov(IncludePlayer,Mem("X",FCBCROPGAlloc,0x15C,0),CV[11])
		CMov(IncludePlayer,Mem("X",FCBCROPGAlloc,0x178,0),CV[12])
		Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBCROPGAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
					},
					flag = {Preserved}
				}
		FCBCROPGAlloc = FCBCROPGAlloc + 1

		CIfX(IncludePlayer,{NVar(CV[13],Exactly,0),NVar(CFuncRetVarArr[1],AtMost,0x7FFFFFFF)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
			DoActionsX(IncludePlayer,SetNVar(CV[3],Add,1))
		CElseIfX({NVar(CV[13],AtLeast,1),NVar(CFuncRetVarArr[1],AtLeast,0x80000000)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
			DoActionsX(IncludePlayer,SetNVar(CV[3],Add,1))
		CIfXEnd()
	CWhileXEnd({SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCROPGAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBVECTCheck == 1 then
	-- CB_Vector2D - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : VectorFunc Init / CV[12] : VectorFunc End 

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBVECTAlloc);
			},
			flag = {Preserved}
		}
	FCBVECTAlloc = FCBVECTAlloc + 1
	
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])
		
		CMov(IncludePlayer,CFuncParaVarArr[1],CV[9])
		CMov(IncludePlayer,CFuncParaVarArr[2],CV[10])
		CMov(IncludePlayer,Mem("X",FCBVECTAlloc,0x15C,0),CV[11])
		CMov(IncludePlayer,Mem("X",FCBVECTAlloc,0x178,0),CV[12])
		Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBVECTAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
					},
					flag = {Preserved}
				}
		FCBVECTAlloc = FCBVECTAlloc + 1

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CFuncRetVarArr[1]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CFuncRetVarArr[2]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBVECTAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBSHISCheck == 1 then
	-- CB_ShapeInShape - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : IFArrX / CV[12] : IFArrY / CV[13] : Rotate / CV[14] : Angle / CV[15] : InShape Loop
	-- CV[16] : InShape Limit / CV[17] : InX / CV[18] : InY / CV[19] : Base Angle / 
	-- CV[21] ~ CV[24] : Temp
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSHISAlloc);
			},
			actions = {
				SetNVar(CV[15],SetTo,0);
				SetNVar(CV[20],SetTo,math.floor(AngleCycle/2));
			},
			flag = {Preserved}
		}
	FCBSHISAlloc = FCBSHISAlloc + 1

	CiSub(IncludePlayer,CV[4],CV[16])
	CIfX(IncludePlayer,NVar(CV[13],Exactly,0))
		CWhileX(IncludePlayer,{TNVar(CV[15],AtMost,CV[16]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[1],SetTo,0)})
			f_SHRead(IncludePlayer,_Add(CV[11],CV[15]),CV[17])
			f_SHRead(IncludePlayer,_Add(CV[12],CV[15]),CV[18])
			CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
				f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

				CWrite(IncludePlayer,_Add(CV[7],CV[3]),_Add(CV[9],CV[17])) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[10],CV[18])) -- Y
			CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})		
		CWhileXEnd({SetNVar(CV[15],Add,1)})
	CElseIfX(NVar(CV[13],Exactly,2))
		CWhileX(IncludePlayer,{TNVar(CV[15],AtMost,CV[16]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[1],SetTo,0)})
			f_SHRead(IncludePlayer,_Add(CV[11],CV[15]),CV[17])
			f_SHRead(IncludePlayer,_Add(CV[12],CV[15]),CV[18])
			CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
				f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

				f_Lengthdir(IncludePlayer,CV[9],CV[14],CV[21],CV[22]) -- XCos XSin 
				f_Lengthdir(IncludePlayer,CV[10],CV[14],CV[23],CV[24]) -- YCos YSin

				CMov(IncludePlayer,CV[9],_iSub(CV[21],CV[24])) -- XCos - YSin
				CMov(IncludePlayer,CV[10],_Add(CV[22],CV[23])) -- XSin + YCos

				CWrite(IncludePlayer,_Add(CV[7],CV[3]),_Add(CV[9],CV[17])) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[10],CV[18])) -- Y
			CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})		
		CWhileXEnd({SetNVar(CV[15],Add,1)})
	CElseX()
		CWhileX(IncludePlayer,{TNVar(CV[15],AtMost,CV[16]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[1],SetTo,0)})
			f_SHRead(IncludePlayer,_Add(CV[11],CV[15]),CV[17])
			f_SHRead(IncludePlayer,_Add(CV[12],CV[15]),CV[18])

			f_Atan2(IncludePlayer,CV[18],CV[17],CV[19]) -- A
			CAdd(IncludePlayer,CV[19],CV[14])
			CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
				f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

				f_Lengthdir(IncludePlayer,CV[9],CV[19],CV[21],CV[22]) -- XCos XSin 
				f_Lengthdir(IncludePlayer,CV[10],CV[19],CV[23],CV[24]) -- YCos YSin

				CMov(IncludePlayer,CV[9],_iSub(CV[21],CV[24])) -- XCos - YSin
				CMov(IncludePlayer,CV[10],_Add(CV[22],CV[23])) -- XSin + YCos

				CWrite(IncludePlayer,_Add(CV[7],CV[3]),_Add(CV[9],CV[17])) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),_Add(CV[10],CV[18])) -- Y
			CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})		
		CWhileXEnd({SetNVar(CV[15],Add,1)})
	CIfXEnd()

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSHISAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBCOPYCheck == 1 then
	-- CB_Copy - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCOPYAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBCOPYAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBFILLCheck == 1 then
	-- CB_Fill - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : FArrY
	-- CV[5] : startX / CV[6] : startY / CV[7] : sizeX / CV[8] : sizeY / CV[9] : numX / CV[10] : numY
	-- CV[11] : X / CV[12] : numX Backup
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBFILLAlloc);
			},
			flag = {Preserved}
		}
	CiSub(IncludePlayer,CV[2],CV[9])
	CMov(IncludePlayer,CV[12],CV[9])
	CWhileX(IncludePlayer,{NVar(CV[10],AtLeast,1),TTNVar(CV[1],iAtMost,CV[2])},{SetNVar(CV[10],Subtract,1),TSetNVar(CV[9],SetTo,CV[12])})
		CMov(IncludePlayer,CV[11],CV[5])
		CWhile(IncludePlayer,{NVar(CV[9],AtLeast,1)},{SetNVar(CV[9],Subtract,1)})
			CWrite(IncludePlayer,_Add(CV[3],CV[1]),CV[11]) -- X
			CWrite(IncludePlayer,_Add(CV[4],CV[1]),CV[6]) -- Y
			CAdd(IncludePlayer,CV[11],CV[7])
		CWhileEnd({SetNVar(CV[1],Add,1)})
		CAdd(IncludePlayer,CV[6],CV[8])
	CWhileXEnd()

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBFILLAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBDRAWCheck == 1 then
	-- CB_Draw - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : FArrY
	-- CV[5] : StartX / CV[6] : StartY / CV[7] : sizeX / CV[8] : sizeY / CV[9] : num
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDRAWAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{NVar(CV[9],AtLeast,1),TTNVar(CV[1],iAtMost,CV[2])},{SetNVar(CV[9],Subtract,1)})
		CWrite(IncludePlayer,_Add(CV[3],CV[1]),CV[5]) -- X
		CWrite(IncludePlayer,_Add(CV[4],CV[1]),CV[6]) -- Y

		CAdd(IncludePlayer,CV[5],CV[7])
		CAdd(IncludePlayer,CV[6],CV[8])
	CWhileXEnd(SetNVar(CV[1],Add,1))

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDRAWAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBDRAW2Check == 1 then
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDRAW2Alloc);
			},
			actions = {SetNVar(CV[12],SetTo,0)},
			flag = {Preserved}
		}
	CMov(IncludePlayer,CV[10],CV[5])
	CMov(IncludePlayer,CV[11],CV[6])
	CWhileX(IncludePlayer,{NVar(CV[9],AtLeast,1),TTNVar(CV[1],iAtMost,CV[2])},{SetNVar(CV[9],Subtract,1)})
		CWrite(IncludePlayer,_Add(CV[3],CV[1]),CV[5]) -- X
		CWrite(IncludePlayer,_Add(CV[4],CV[1]),CV[6]) -- Y

		CIf(IncludePlayer,NVar(CV[12],Exactly,1))
			CAdd(IncludePlayer,CV[1],1)
			CWrite(IncludePlayer,_Add(CV[3],CV[1]),CV[10]) -- X
			CWrite(IncludePlayer,_Add(CV[4],CV[1]),CV[11]) -- Y
		CIfEnd()

		CAdd(IncludePlayer,CV[5],CV[7])
		CAdd(IncludePlayer,CV[6],CV[8])
		CiSub(IncludePlayer,CV[10],CV[7])
		CiSub(IncludePlayer,CV[11],CV[8])
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[12],SetTo,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDRAW2Alloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBOVERCheck == 1 then
	-- CB_Overlap - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBOVERAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBOVERAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBOVERXCheck == 1 then
	-- CB_OverlapX- CV[1] = ShapeA Loop / CV[2] = ShapeA Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : AFArrX / CV[6] : AFArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y
	-- CV[11] : ShapeB Loop / CV[12] : ShapeB Limit / CV[13] : BFArrX / CV[14] : BFArrY
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBOVERXAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	CWhileX(IncludePlayer,{TNVar(CV[11],AtMost,CV[12]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[13],CV[11]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[14],CV[11]),CV[10])

		CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[11],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBOVERXAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBMERGCheck == 1 then
	-- CB_Merge - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : RetShape Temp Loop / CV[14] : RetShape Loop Max / CV[15] : Xmin / CV[16] : Xmax / CV[17] : Ymin / CV[18] : Ymax
	-- CV[19] : RFArrX Loop / CV[20] : RFArrY Loop
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMERGAlloc);
			},
			flag = {Preserved}
		}
	CMov(IncludePlayer,CV[14],CV[3])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[13],SetTo,0)})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CiSub(IncludePlayer,CV[15],CV[9],CV[11])
		CAdd(IncludePlayer,CV[16],CV[9],CV[11])
		CiSub(IncludePlayer,CV[17],CV[10],CV[12])
		CAdd(IncludePlayer,CV[18],CV[10],CV[12])
		CMov(IncludePlayer,CV[19],CV[7])
		CMov(IncludePlayer,CV[20],CV[8])

		NWhile(IncludePlayer,{TNVar(CV[13],AtMost,CV[14])})
			NJump(IncludePlayer,CAPlotJumpAlloc,{TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
		NWhileEnd({SetNVar(CV[13],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
			CAdd(IncludePlayer,CV[3],1)
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	CWhileXEnd({SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMERGAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBMERGXCheck == 1 then
		-- CB_MergeX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : ShapeB X / CV[14] : ShapeB Y
	-- CV[19] : BFArrX Loop / CV[20] : BFArrY Loop / CV[21] : ShapeB Loop / CV[22] : ShapeB Limit / CV[23] : BFArrX / CV[24] : BFArrY / CV[25] : Loop
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMERGXAlloc);
			},
			actions = {SetNVar(CV[25],SetTo,0)},
			flag = {Preserved}
		}
	CWhileX(IncludePlayer,{TNVar(CV[25],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[25]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[25]),CV[10])

		CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[25],Add,1),SetNVar(CV[3],Add,1)})

	CWhileX(IncludePlayer,{TNVar(CV[21],AtMost,CV[22]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[1],SetTo,0)})
		f_SHRead(IncludePlayer,_Add(CV[23],CV[21]),CV[13])
		f_SHRead(IncludePlayer,_Add(CV[24],CV[21]),CV[14])

		CiSub(IncludePlayer,CV[15],CV[13],CV[11])
		CAdd(IncludePlayer,CV[16],CV[13],CV[11])
		CiSub(IncludePlayer,CV[17],CV[14],CV[12])
		CAdd(IncludePlayer,CV[18],CV[14],CV[12])
		CMov(IncludePlayer,CV[19],CV[5])
		CMov(IncludePlayer,CV[20],CV[6])

		NWhile(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
			NJump(IncludePlayer,CAPlotJumpAlloc,{TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
		NWhileEnd({SetNVar(CV[1],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[13]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[14]) -- Y
			CAdd(IncludePlayer,CV[3],1)
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	CWhileXEnd({SetNVar(CV[21],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBMERGXAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBINTSCheck == 1 then
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBINTSAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[21],AtMost,CV[22]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[1],SetTo,0)})
		f_SHRead(IncludePlayer,_Add(CV[23],CV[21]),CV[13])
		f_SHRead(IncludePlayer,_Add(CV[24],CV[21]),CV[14])

		CiSub(IncludePlayer,CV[15],CV[13],CV[11])
		CAdd(IncludePlayer,CV[16],CV[13],CV[11])
		CiSub(IncludePlayer,CV[17],CV[14],CV[12])
		CAdd(IncludePlayer,CV[18],CV[14],CV[12])
		CMov(IncludePlayer,CV[19],CV[5])
		CMov(IncludePlayer,CV[20],CV[6])

		NWhile(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
			NJump(IncludePlayer,CAPlotJumpAlloc,{TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
		NWhileEnd({SetNVar(CV[1],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1)})
		CJump(IncludePlayer,CAPlotJumpAlloc+1)
			NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[13]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[14]) -- Y
			CAdd(IncludePlayer,CV[3],1)
		CJumpEnd(IncludePlayer,CAPlotJumpAlloc+1)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 2
	CWhileXEnd({SetNVar(CV[21],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBINTSAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBSUBTCheck == 1 then
	-- CB_Subtract - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : ShapeB X / CV[14] : ShapeB Y
	-- CV[19] : BFArrX Loop / CV[20] : BFArrY Loop / CV[21] : ShapeB Loop / CV[22] : ShapeB Limit / CV[23] : BFArrX / CV[24] : BFArrY
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSUBTAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[21],AtMost,CV[22]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[1],SetTo,0)})
		f_SHRead(IncludePlayer,_Add(CV[23],CV[21]),CV[13])
		f_SHRead(IncludePlayer,_Add(CV[24],CV[21]),CV[14])

		CiSub(IncludePlayer,CV[15],CV[13],CV[11])
		CAdd(IncludePlayer,CV[16],CV[13],CV[11])
		CiSub(IncludePlayer,CV[17],CV[14],CV[12])
		CAdd(IncludePlayer,CV[18],CV[14],CV[12])
		CMov(IncludePlayer,CV[19],CV[5])
		CMov(IncludePlayer,CV[20],CV[6])

		NWhile(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
			NJump(IncludePlayer,CAPlotJumpAlloc,{TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
		NWhileEnd({SetNVar(CV[1],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[13]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[14]) -- Y
			CAdd(IncludePlayer,CV[3],1)
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	CWhileXEnd({SetNVar(CV[21],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSUBTAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBXORCheck == 1 then
	-- CB_Xor - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : ShapeB X / CV[14] : ShapeB Y
	-- CV[19] : BFArrX Loop / CV[20] : BFArrY Loop / CV[21] : ShapeB Loop / CV[22] : ShapeB Limit / CV[23] : BFArrX / CV[24] : BFArrY / CV[25] : Loop
 	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXORAlloc);
			},
			actions = {SetNVar(CV[25],SetTo,0)},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[21],AtMost,CV[22]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[1],SetTo,0)})
		f_SHRead(IncludePlayer,_Add(CV[23],CV[21]),CV[13])
		f_SHRead(IncludePlayer,_Add(CV[24],CV[21]),CV[14])

		CiSub(IncludePlayer,CV[15],CV[13],CV[11])
		CAdd(IncludePlayer,CV[16],CV[13],CV[11])
		CiSub(IncludePlayer,CV[17],CV[14],CV[12])
		CAdd(IncludePlayer,CV[18],CV[14],CV[12])
		CMov(IncludePlayer,CV[19],CV[5])
		CMov(IncludePlayer,CV[20],CV[6])

		NWhile(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
			NJump(IncludePlayer,CAPlotJumpAlloc,{TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
		NWhileEnd({SetNVar(CV[1],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[13]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[14]) -- Y
			CAdd(IncludePlayer,CV[3],1)
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	CWhileXEnd({SetNVar(CV[21],Add,1)})

	CWhileX(IncludePlayer,{TNVar(CV[25],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])},{SetNVar(CV[21],SetTo,0)})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[25]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[25]),CV[10])

		CiSub(IncludePlayer,CV[15],CV[9],CV[11])
		CAdd(IncludePlayer,CV[16],CV[9],CV[11])
		CiSub(IncludePlayer,CV[17],CV[10],CV[12])
		CAdd(IncludePlayer,CV[18],CV[10],CV[12])
		CMov(IncludePlayer,CV[19],CV[23])
		CMov(IncludePlayer,CV[20],CV[24])

		NWhile(IncludePlayer,{TNVar(CV[21],AtMost,CV[22])})
			NJump(IncludePlayer,CAPlotJumpAlloc,{TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
		NWhileEnd({SetNVar(CV[21],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1)})
			CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
			CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
			CAdd(IncludePlayer,CV[3],1)
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	CWhileXEnd({SetNVar(CV[25],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXORAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBRMSTCheck == 1 then
	-- CB_RemoveStack - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : RetShape Temp Loop  / CV[15] : Xmin / CV[16] : Xmax / CV[17] : Ymin / CV[18] : Ymax
	-- CV[19] : RFArrX Loop / CV[20] : RFArrY Loop / CV[14] : Priority / CV[21] : ShapeLoop / CV[22] : CVoid / CV[23] : CVoid Orig
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBRMSTAlloc);
			},
			actions = {SetNVar(CV[21],SetTo,0)},
			flag = {Preserved}
		}
	TMem(IncludePlayer,CV[22],FArr(CVoid,0))
	TMem(IncludePlayer,CV[23],FArr(CVoid,0))
	CWhileX(IncludePlayer,{TNVar(CV[21],AtMost,CV[2])})
		CWrite(IncludePlayer,CV[22],0)
	CWhileXEnd({SetNVar(CV[22],Add,1),SetNVar(CV[21],Add,1)})

	CIfX(IncludePlayer,NVar(CV[14],Exactly,0))
		CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])},SetNVar(CV[13],SetTo,0))
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

			CiSub(IncludePlayer,CV[15],CV[9],CV[11])
			CAdd(IncludePlayer,CV[16],CV[9],CV[11])
			CiSub(IncludePlayer,CV[17],CV[10],CV[12])
			CAdd(IncludePlayer,CV[18],CV[10],CV[12])
			CMov(IncludePlayer,CV[19],CV[5])
			CMov(IncludePlayer,CV[20],CV[6])
			TMem(IncludePlayer,CV[22],FArr(CVoid,0))
			
			NWhile(IncludePlayer,{TNVar(CV[13],AtMost,CV[2])})
				NIf(IncludePlayer,{TMemory(CV[22],Exactly,0)})
					NJump(IncludePlayer,CAPlotJumpAlloc,{TTNVar(CV[13],NotSame,CV[1]),TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
				NIfEnd()
			NWhileEnd({SetNVar(CV[13],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1),SetNVar(CV[22],Add,1)})
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
				CJump(IncludePlayer,CAPlotJumpAlloc+1)
			NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
			CWrite(IncludePlayer,CV[23],1)
				CJumpEnd(IncludePlayer,CAPlotJumpAlloc)
				CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[23],Add,1)})
	CElseX()
		CMov(IncludePlayer,CV[1],CV[2])
		CAdd(IncludePlayer,CV[23],CV[2])
		CWhileX(IncludePlayer,{TTNVar(CV[1],iAtLeast,0),TTNVar(CV[3],iAtMost,CV[4])},SetNVar(CV[13],SetTo,0))
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
			f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

			CiSub(IncludePlayer,CV[15],CV[9],CV[11])
			CAdd(IncludePlayer,CV[16],CV[9],CV[11])
			CiSub(IncludePlayer,CV[17],CV[10],CV[12])
			CAdd(IncludePlayer,CV[18],CV[10],CV[12])
			CMov(IncludePlayer,CV[19],CV[5])
			CMov(IncludePlayer,CV[20],CV[6])
			TMem(IncludePlayer,CV[22],FArr(CVoid,0))
			
			NWhile(IncludePlayer,{TNVar(CV[13],AtMost,CV[2])})
				NIf(IncludePlayer,{TMemory(CV[22],Exactly,0)})
					NJump(IncludePlayer,CAPlotJumpAlloc,{TTNVar(CV[13],NotSame,CV[1]),TTMemory(CV[19],iAtLeast,CV[15]),TTMemory(CV[19],iAtMost,CV[16]),TTMemory(CV[20],iAtLeast,CV[17]),TTMemory(CV[20],iAtMost,CV[18])})
				NIfEnd()
			NWhileEnd({SetNVar(CV[13],Add,1),SetNVar(CV[19],Add,1),SetNVar(CV[20],Add,1),SetNVar(CV[22],Add,1)})
				CWrite(IncludePlayer,_Add(CV[7],CV[3]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[3]),CV[10]) -- Y
				CAdd(IncludePlayer,CV[3],1)
				CJump(IncludePlayer,CAPlotJumpAlloc+1)
			NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1
			CWrite(IncludePlayer,CV[23],1)
				CJumpEnd(IncludePlayer,CAPlotJumpAlloc)
				CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		CWhileXEnd({SetNVar(CV[1],Add,-1),SetNVar(CV[23],Subtract,1)})
	CIfXEnd()
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBRMSTAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBDELTCheck == 1 then
	-- CB_Delete - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : FArrY 
	-- CV[5] : TX / CV[6] : TY / CV[7] : SizeX / CV[8] : SizeY / CV[9] : Shape Loop / CV[10] : X / CV[11] : Y
	-- CV[12] : Xmin / CV[13] : Xmax / CV[14] : Ymin / CV[15] : Ymax 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDELTAlloc);
			},
			actions = {SetNVar(CV[9],SetTo,0)},
			flag = {Preserved}
		}
	CiSub(IncludePlayer,CV[12],CV[5],CV[7])
	CAdd(IncludePlayer,CV[13],CV[5],CV[7])
	CiSub(IncludePlayer,CV[14],CV[6],CV[8])
	CAdd(IncludePlayer,CV[15],CV[6],CV[8])
	CMov(IncludePlayer,CV[2],CV[1],-1)
	NWhileX(IncludePlayer,{TTNVar(CV[9],iAtMost,CV[2])})
		NJump(IncludePlayer,CAPlotJumpAlloc,{TTMemory(CV[3],iAtLeast,CV[12]),TTMemory(CV[3],iAtMost,CV[13]),TTMemory(CV[4],iAtLeast,CV[14]),TTMemory(CV[4],iAtMost,CV[15])},{SetNVar(CV[1],Subtract,1)})	
	NWhileXEnd({SetNVar(CV[9],Add,1),SetNVar(CV[3],Add,1),SetNVar(CV[4],Add,1)})
	NWhileX(IncludePlayer,{TTNVar(CV[9],iAtMost,CV[2])})
		f_SHRead(IncludePlayer,CV[3],CV[7])
		f_SHRead(IncludePlayer,CV[4],CV[8])
		DoActionsX(IncludePlayer,{SetNVar(CV[3],Subtract,1),SetNVar(CV[4],Subtract,1)})
		CWrite(IncludePlayer,CV[3],CV[7]) -- X
		CWrite(IncludePlayer,CV[4],CV[8]) -- Y
		DoActionsX(IncludePlayer,{SetNVar(CV[3],Add,1),SetNVar(CV[4],Add,1)})
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	NWhileXEnd({SetNVar(CV[3],Add,1),SetNVar(CV[4],Add,1),SetNVar(CV[9],Add,1)})
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBDELTAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBXMAXCheck == 1 then
	-- CB_GetXmax - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX
	-- CV[5] : X / CV[6] : Xmax  
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXMAXAlloc);
			},
			actions = {
				SetNVar(CV[6],SetTo,0x80000000);
			},
			flag = {Preserved}
		}
	FCBXMAXAlloc = FCBXMAXAlloc + 1

	CMov(IncludePlayer,CV[5],CV[3])
	CMov(IncludePlayer,0x6509B0,CV[3])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[6],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[6]) -- Xmax
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXMAXAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBXMINCheck == 1 then
	-- CB_GetXmin - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX
	-- CV[5] : X / CV[6] : Xmin  
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXMINAlloc);
			},
			actions = {
				SetNVar(CV[6],SetTo,0x7FFFFFFF);
			},
			flag = {Preserved}
		}
	FCBXMINAlloc = FCBXMINAlloc + 1

	CMov(IncludePlayer,CV[5],CV[3])
	CMov(IncludePlayer,0x6509B0,CV[3])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[6],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[6]) -- Xmin
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXMINAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBXCNTRCheck == 1 then
	-- CB_GetXCntr - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : Xmax
	-- CV[5] : X / CV[6] : Xmin / CV[7] : XCntr
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXCNTRAlloc);
			},
			actions = {
				SetNVar(CV[4],SetTo,0x80000000);
				SetNVar(CV[6],SetTo,0x7FFFFFFF);
			},
			flag = {Preserved}
		}
	FCBXCNTRAlloc = FCBXCNTRAlloc + 1

	CMov(IncludePlayer,CV[5],CV[3])
	CMov(IncludePlayer,0x6509B0,CV[3])
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtLeast,CV[4],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[4]) -- Xmax
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
		CIf(IncludePlayer,{TTDeaths(CurrentPlayer,iAtMost,CV[6],0)})
			f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[6]) -- Xmin
			CMov(IncludePlayer,0x6509B0,CV[5])
			CAdd(IncludePlayer,0x6509B0,CV[1])
		CIfEnd()
	CWhileXEnd({SetMemory(0x6509B0,Add,1),SetNVar(CV[1],Add,1)})
	CiDiv(IncludePlayer,CV[7],_Add(CV[4],CV[6]),2)

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBXCNTRAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBTCPYCheck == 1 then
	-- CB_TCopy - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : LoopArr / CV[6] : RetLoopArr / CV[7] : LoopMax
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBTCPYAlloc);
			},
			flag = {Preserved}
		}

	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[7])

		CWrite(IncludePlayer,_Add(CV[6],CV[1]),CV[7]) -- X
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBTCPYAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0),
						SetNVar(CV[1],Subtract,1)},
			flag = {Preserved}
		}
end

if FCBTDELCheck == 1 then
	-- CB_TDelete - CV[1] = Shape Loop / CV[2] = FArrN /  CV[3] : Index / CV[4] : Loop Limit
	-- CV[5] : Shape Loop / CV[6] : LoopMax 
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBTDELAlloc);
			},
			actions = {SetNVar(CV[5],SetTo,0)},
			flag = {Preserved}
		}
	CMov(IncludePlayer,CV[4],CV[1])
	NWhileX(IncludePlayer,{TTNVar(CV[5],iAtMost,CV[4])})
		NJump(IncludePlayer,CAPlotJumpAlloc,{TNVar(CV[5],Exactly,CV[3])},{SetNVar(CV[1],Subtract,1)})	
	NWhileXEnd({SetNVar(CV[5],Add,1)})
	NWhileX(IncludePlayer,{TTNVar(CV[5],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[2],CV[5]),CV[6])
		DoActionsX(IncludePlayer,SetNVar(CV[5],Subtract,1))
		CWrite(IncludePlayer,_Add(CV[2],CV[5]),CV[6]) -- X
		DoActionsX(IncludePlayer,SetNVar(CV[5],Add,1))
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	NWhileXEnd({SetNVar(CV[5],Add,1)})
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBTDELAlloc+1);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBSORTCheck == 1 then
	-- CB_Sort - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : Direction / CV[12~13] : SFunc 
	-- CV[14] : kMin -> CV[16] : Save / CV[15] : CVoid / CV[17~18] : PX,PY / CV[19] : K / CV[20] : FuncType / CV[24] : SortType
	-- CV[21] : Step / CV[22~23] : Func
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSORTAlloc);
			},
			flag = {Preserved}
		}
	FCBSORTAlloc = FCBSORTAlloc+1
	TMem(IncludePlayer,CV[15],FArr(CVoid,0))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2]),TTNVar(CV[3],iAtMost,CV[4])})
		f_SHRead(IncludePlayer,_Add(CV[5],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[6],CV[1]),CV[10])

		CIfX(IncludePlayer,NVar(CV[20],Exactly,0)) -- XY/RA
			CMov(IncludePlayer,CFuncParaVarArr[1],CV[9])
			CMov(IncludePlayer,CFuncParaVarArr[2],CV[10])
		CElseX() -- I
			CMov(IncludePlayer,CFuncParaVarArr[1],CV[1])
		CIfXEnd()
		CMov(IncludePlayer,Mem("X",FCBSORTAlloc,0x15C,0),CV[12])
		CMov(IncludePlayer,Mem("X",FCBSORTAlloc,0x178,0),CV[13])
		Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBSORTAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
					},
					flag = {Preserved}
				}
		FCBSORTAlloc = FCBSORTAlloc + 1
		CIfX(IncludePlayer,NVar(CV[11],Exactly,0))
			CWrite(IncludePlayer,_Add(CV[15],CV[1]),CFuncRetVarArr[1]) -- K
		CElseX()
			CWrite(IncludePlayer,_Add(CV[15],CV[1]),_Neg(CFuncRetVarArr[1])) -- K
		CIfXEnd()

		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[10]) -- Y
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1)})

	DoActionsX(IncludePlayer,{SetNVar(CV[1],SetTo,0),SetNVar(CV[3],Subtract,1)})
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[3])}) -- for i = 0, n-1 do
		f_Read(IncludePlayer,_Add(CV[15],CV[1]),CV[14])
		CMov(IncludePlayer,CV[4],CV[1]) -- min = i
		CMov(IncludePlayer,CV[2],CV[1])
		CWhileX(IncludePlayer,{TNVar(CV[2],AtMost,CV[3])}) -- for j = i, n-1 do
			CIf(IncludePlayer,{TTMemory(_Add(CV[15],CV[2]),iBelow,CV[14])}) -- f(j) < f(min)
				CMov(IncludePlayer,CV[4],CV[2]) -- min = j
				f_Read(IncludePlayer,_Add(CV[15],CV[4]),CV[14]) -- f(min)
			CIfEnd()
		CWhileXEnd(SetNVar(CV[2],Add,1))
		f_SHRead(IncludePlayer,_Add(CV[7],CV[4]),CV[17])
		f_SHRead(IncludePlayer,_Add(CV[8],CV[4]),CV[18])
		f_Read(IncludePlayer,_Add(CV[15],CV[1]),CV[19])
		f_SHRead(IncludePlayer,_Add(CV[7],CV[1]),CV[9])
		f_SHRead(IncludePlayer,_Add(CV[8],CV[1]),CV[10])

		CWrite(IncludePlayer,_Add(CV[15],CV[4]),CV[19]) -- K
		CWrite(IncludePlayer,_Add(CV[7],CV[4]),CV[9]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[4]),CV[10]) -- Y
		CWrite(IncludePlayer,_Add(CV[15],CV[1]),CV[14]) -- K
		CWrite(IncludePlayer,_Add(CV[7],CV[1]),CV[17]) -- X
		CWrite(IncludePlayer,_Add(CV[8],CV[1]),CV[18]) -- Y
	CWhileXEnd(SetNVar(CV[1],Add,1))

	CIfX(IncludePlayer,NVar(CV[24],Exactly,1),{SetNVar(CV[3],Add,1),SetNVar(CV[25],SetTo,1),SetNVar(CV[26],SetTo,1),SetNVar(CV[27],SetTo,0),SetNVar(CV[30],SetTo,1),SetNVar(CV[34],SetTo,1)}) -- NSort
		-- CV[25] : ptr1 / CV[26] : ptr2 / CV[27] : Sum / CV[28] : temp / CV[29] : Stack / CV[30] : j / CV[31] : FN / CV[32] : TNum / CV[33] : Stack Total / CV[34] : j
		CIfX(IncludePlayer,NVar(CV[22],Exactly,0))
			CMov(IncludePlayer,CV[33],CV[3])
			CAdd(IncludePlayer,CV[29],_Div(CV[33],CV[21]),1) -- Stack = 1+Shape[1]/Step
		CElseX()
			CWhileX(IncludePlayer,{TNVar(CV[34],AtMost,CV[21])})
				CMov(IncludePlayer,CFuncParaVarArr[1],CV[34])
				CMov(IncludePlayer,Mem("X",FCBSORTAlloc,0x15C,0),CV[22])
				CMov(IncludePlayer,Mem("X",FCBSORTAlloc,0x178,0),CV[23])
				Trigger { 
						players = {IncludePlayer},
							conditions = {
								Label(FCBSORTAlloc);
							},
							actions = {
								SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
								SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
							},
							flag = {Preserved}
						}
				FCBSORTAlloc = FCBSORTAlloc + 1
				CMov(IncludePlayer,CV[28],CFuncRetVarArr[1])
				TriggerX(IncludePlayer,NVar(CV[28],AtLeast,0x80000000),SetNVar(CV[28],SetTo,0),{Preserved})
				CAdd(IncludePlayer,CV[27],CV[28])
				CWrite(IncludePlayer,_Add(CV[15],CV[34]),CV[28])
			CWhileXEnd(SetNVar(CV[34],Add,1))
			f_SHRead(IncludePlayer,_Add(CV[15],1),CV[28])
			CMov(IncludePlayer,CV[33],CV[28])
			CAdd(IncludePlayer,CV[29],_Div(_Mul(CV[3],CV[33]),CV[27]),1) -- Stack = 1+Shape[1]*tmp/Sum
		CIfXEnd()
		CMov(IncludePlayer,CV[26],CV[29])
		
		NWhileX(IncludePlayer,{TNVar(CV[30],AtMost,CV[21]),TNVar(CV[30],AtMost,CV[32])})
			CWrite(IncludePlayer,_Add(CV[31],CV[30]),_iSub(CV[26],CV[25])) -- table.insert(LoopArr,ptr2-ptr1)
			NJump(IncludePlayer,CAPlotJumpAlloc,{TNVar(CV[30],Exactly,CV[21])})	
			CMov(IncludePlayer,CV[25],CV[26])
			CIfX(IncludePlayer,NVar(CV[22],Exactly,0))
				CAdd(IncludePlayer,CV[33],CV[3])
				CMov(IncludePlayer,CV[29],_Div(CV[33],CV[21]),1) -- Stack = Stack + Shape[1]/Step+1
			CElseX()
				f_SHRead(IncludePlayer,_Add(CV[15],_Add(CV[30],1)),CV[28]) -- tmp = _G[Func](j+1)
				CAdd(IncludePlayer,CV[33],CV[28])
				CMov(IncludePlayer,CV[29],_Div(_Mul(CV[3],CV[33]),CV[27]),1) -- Stack = Stack + Shape[1]*tmp/Sum+1
			CIfXEnd()
			CMov(IncludePlayer,CV[26],CV[29])
		NWhileXEnd(SetNVar(CV[30],Add,1))
		NJumpEnd(IncludePlayer,CAPlotJumpAlloc)
		CAPlotJumpAlloc = CAPlotJumpAlloc + 1
		CTrigger(IncludePlayer,{TTNVar(CV[30],Above,CV[32])},{SetNVar(CV[30],Subtract,1)},{Preserved})
		CWrite(IncludePlayer,CV[31],CV[30])
	CElseIfX(NVar(CV[24],Exactly,2),{SetNVar(CV[3],Add,1),SetNVar(CV[25],SetTo,1),SetNVar(CV[26],SetTo,0),SetNVar(CV[27],SetTo,0),SetNVar(CV[30],SetTo,1),SetNVar(CV[41],SetTo,0),SetNVar(CV[42],SetTo,0)}) -- TSort
	-- CV[25] : ptr1 / CV[26] : ptr2 / CV[27] : Sum / CV[28] : temp / CV[29] : Stack / CV[30] : j / CV[31] : FN / CV[32] : TNum / CV[33] : Stack Total / CV[34] : Shape[1]-1
	-- CV[35] : Void / CV[36] : CVoid + 32*0x970 / CV[37] : dK / CV[38] : temp2 / CV[39] : prev / CV[40] : l /
			CMov(IncludePlayer,CV[34],CV[3],-1)
			CIfX(IncludePlayer,NVar(CV[22],Exactly,0))
				f_Read(IncludePlayer,CV[15],CV[43])
				f_Read(IncludePlayer,_Add(CV[15],CV[34]),CV[38])
				CiSub(IncludePlayer,CV[37],CV[38],CV[43]) -- dK = __SortRet[End] - __SortRet[Start]
				CMov(IncludePlayer,CV[33],CV[37])
				CAdd(IncludePlayer,CV[29],CV[43],_iDiv(CV[33],CV[21])) -- Stack = __SortRet[Start] + dK/Step
			CElseX()
				CAdd(IncludePlayer,CV[36],CV[15],32*604)
				CWhileX(IncludePlayer,{TNVar(CV[30],AtMost,CV[21])})
					CMov(IncludePlayer,CFuncParaVarArr[1],CV[30])
					CMov(IncludePlayer,Mem("X",FCBSORTAlloc,0x15C,0),CV[22])
					CMov(IncludePlayer,Mem("X",FCBSORTAlloc,0x178,0),CV[23])
					Trigger { 
							players = {IncludePlayer},
								conditions = {
									Label(FCBSORTAlloc);
								},
								actions = {
									SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
									SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
								},
								flag = {Preserved}
							}
					FCBSORTAlloc = FCBSORTAlloc + 1
					CMov(IncludePlayer,CV[28],CFuncRetVarArr[1])
					TriggerX(IncludePlayer,NVar(CV[28],AtLeast,0x80000000),SetNVar(CV[28],SetTo,0),{Preserved})
					CAdd(IncludePlayer,CV[27],CV[28])
					CWrite(IncludePlayer,_Add(CV[36],CV[30]),CV[28])
				CWhileXEnd(SetNVar(CV[30],Add,1))
				f_Read(IncludePlayer,CV[15],CV[43])
				f_Read(IncludePlayer,_Add(CV[15],CV[34]),CV[28])
				CiSub(IncludePlayer,CV[37],CV[28],CV[43]) -- dK = __SortRet[End] - __SortRet[Start]

				f_Read(IncludePlayer,_Add(CV[36],1),CV[28])
				f_Mul(IncludePlayer,CV[33],CV[37],CV[28])
				CAdd(IncludePlayer,CV[29],_iDiv(CV[33],CV[27]),CV[43]) -- Stack = __SortRet[Start][Level] + dK*tmp/Sum
				DoActionsX(IncludePlayer,SetNVar(CV[30],SetTo,1))
			CIfXEnd()
			
			NWhileX(IncludePlayer,{TNVar(CV[30],AtMost,CV[3])})
				NIfX(IncludePlayer,{TTMemory(_Add(CV[15],CV[41]),iAbove,CV[29])})
					CMov(IncludePlayer,CV[39],CV[30]) -- prev = j
					CJump(IncludePlayer,CAPlotJumpAlloc)	
				NElseX()
					CMov(IncludePlayer,CV[26],CV[30]) -- ptr2 = j
					CAdd(IncludePlayer,CV[39],CV[30],1) -- prev = j+1
				NIfXEnd()
				CIf(IncludePlayer,{TNVar(CV[30],Exactly,CV[3])})
					CMov(IncludePlayer,CV[26],CV[3]) -- ptr2 = End
					CAdd(IncludePlayer,CV[39],CV[3],1) -- prev = End+1
				CIfEnd()
			NWhileXEnd({SetNVar(CV[30],Add,1),SetNVar(CV[41],Add,1)})
			CJumpEnd(IncludePlayer,CAPlotJumpAlloc)
			CAPlotJumpAlloc = CAPlotJumpAlloc + 1

			DoActionsX(IncludePlayer,{SetNVar(CV[30],SetTo,1),SetNVar(CV[41],SetTo,0)})
			NWhileX(IncludePlayer,{TNVar(CV[30],AtMost,CV[21])}) -- for j = 1, Step do
				CIfX(IncludePlayer,{TTNVar(CV[25],Above,CV[3]),NVar(CV[35],AtLeast,1)},SetNVar(CV[42],Add,1)) -- if ptr1 > End and __SortChk >= 1 then
					CWrite(IncludePlayer,_Add(CV[31],CV[30]),0) -- table.insert(__SortMax,0)
				CElseIfX(NVar(CV[26],AtLeast,1),SetNVar(CV[42],Add,1))
					CWrite(IncludePlayer,_Add(CV[31],CV[30]),_Add(_iSub(CV[26],CV[25]),1)) -- table.insert(__SortMax,ptr2-ptr1+1)
				CElseX()
					CIfX(IncludePlayer,{TNVar(CV[39],Exactly,Vi(CV[25][2],1))},SetNVar(CV[42],Add,1))
						CWrite(IncludePlayer,_Add(CV[31],CV[30]),1) -- table.insert(__SortMax,1)
						CMov(IncludePlayer,CV[26],CV[25]) -- ptr2 = ptr1
					CElseX()
						CIf(IncludePlayer,NVar(CV[35],AtLeast,1),SetNVar(CV[42],Add,1))
							CWrite(IncludePlayer,_Add(CV[31],CV[30]),0) -- table.insert(__SortMax,0)
						CIfEnd()
						CSub(IncludePlayer,CV[26],CV[39],1) -- ptr2 = prev-1
					CIfXEnd()
				CIfXEnd()
				NJump(IncludePlayer,CAPlotJumpAlloc,{TNVar(CV[30],Exactly,CV[21])})
				local CAPlotJumpAllocX = CAPlotJumpAlloc
				CAPlotJumpAlloc = CAPlotJumpAlloc + 1
				CAdd(IncludePlayer,CV[25],CV[26],1) -- ptr1 = ptr2+1
				DoActionsX(IncludePlayer,{SetNVar(CV[26],SetTo,0),SetNVar(CV[39],SetTo,0)})
				
				CIfX(IncludePlayer,NVar(CV[22],Exactly,0))
					CAdd(IncludePlayer,CV[33],CV[37])
					CAdd(IncludePlayer,CV[29],_iDiv(CV[33],CV[21]),CV[43]) -- Stack += Stack + dK/Step
				CElseX()
					f_Read(IncludePlayer,_Add(CV[36],_Add(CV[30],1)),CV[28])
					CAdd(IncludePlayer,CV[33],_Mul(CV[37],CV[28]))
					CAdd(IncludePlayer,CV[29],_iDiv(CV[33],CV[27]),CV[43]) -- Stack = Stack + dK*tmp/Sum
				CIfXEnd()
				CMov(IncludePlayer,CV[40],CV[25])
				CMov(IncludePlayer,CV[41],CV[40],-1)
				NWhileX(IncludePlayer,{TNVar(CV[40],AtMost,CV[3])})
					NIfX(IncludePlayer,{TTMemory(_Add(CV[15],CV[41]),iAbove,CV[29])})
						CMov(IncludePlayer,CV[39],CV[40]) -- prev = l
						CJump(IncludePlayer,CAPlotJumpAlloc)	
					NElseX()
						CMov(IncludePlayer,CV[26],CV[40]) -- ptr2 = l
						CAdd(IncludePlayer,CV[39],CV[40],1) -- prev = l+1
					NIfXEnd()
					CIf(IncludePlayer,{TNVar(CV[40],Exactly,CV[3])})
						CMov(IncludePlayer,CV[26],CV[3]) -- ptr2 = End
						CAdd(IncludePlayer,CV[39],CV[3],1) -- prev = End+1
					CIfEnd()
				NWhileXEnd({SetNVar(CV[40],Add,1),SetNVar(CV[41],Add,1)})

				CJumpEnd(IncludePlayer,CAPlotJumpAlloc)
				CAPlotJumpAlloc = CAPlotJumpAlloc + 1
			NWhileXEnd({SetNVar(CV[30],Add,1)})
			NJumpEnd(IncludePlayer,CAPlotJumpAllocX)
			CWrite(IncludePlayer,CV[31],CV[42]) -- Set Arr Size
	CIfXEnd() -- Sort

	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSORTAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

if FCBSPLTCheck == 1 then
	-- CB_Split - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y
	-- CV[11] : Overwrite / CV[12] : Looper / CV[13] : N / CV[14~15] : Func / CV[16] : CVoid / CV[17] : temp 
	-- CV[18] : k / CV[19] : Loop+1 / CV[20] : Shape[1]+1 / CV[21] : Retshape[1]
	Trigger { -- {N,f(i)} : 1~N -> f(i)를 추가함
		players = {IncludePlayer},
			conditions = {
				Label(FCBSPLTAlloc);
			},
			actions = {SetNVar(CV[21],SetTo,0)},
			flag = {Preserved}
		}
	FCBSPLTAlloc = FCBSPLTAlloc+1

	TMem(IncludePlayer,CV[16],FArr(CVoid,1))
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[2])})
		CWrite(IncludePlayer,_Add(CV[16],CV[1]),0)
	CWhileXEnd(SetNVar(CV[1],Add,1))
	DoActionsX(IncludePlayer,{SetNVar(CV[1],SetTo,0),SetNVar(CV[19],SetTo,1),SetNVar(CV[16],Subtract,1)})
	CAdd(IncludePlayer,CV[20],CV[2],1)
	CWhileX(IncludePlayer,{TNVar(CV[1],AtMost,CV[13]),TTNVar(CV[3],iAtMost,CV[4])})
		CMov(IncludePlayer,CFuncParaVarArr[1],CV[19])
		CMov(IncludePlayer,Mem("X",FCBSPLTAlloc,0x15C,0),CV[14])
		CMov(IncludePlayer,Mem("X",FCBSPLTAlloc,0x178,0),CV[15])
		Trigger { 
				players = {IncludePlayer},
					conditions = {
						Label(FCBSPLTAlloc);
					},
					actions = {
						SetCtrig1X("X","X",0x4,0,SetTo,0); -- CFunction[1],CFunction[2],0x0,0,1
						SetCtrig2X(0,SetTo,"X","X",0x0,0,1); -- CFunction[1],CFunction[2]+1,0x4,0
					},
					flag = {Preserved}
				}
		FCBSPLTAlloc = FCBSPLTAlloc + 1
		CMov(IncludePlayer,CV[17],CFuncRetVarArr[1])
		CIfX(IncludePlayer,NVar(CV[12],AtLeast,1))
			CIf(IncludePlayer,{_TP(_TOR(_TNVar(CV[17],AtLeast,CV[20]),_TTNVar(CV[17],iAtMost,0)))})
				CSub(IncludePlayer,CV[17],CV[2],_iMod(CV[17],CV[2]))
				CIf(IncludePlayer,NVar(CV[17],Exactly,0))
					CMov(IncludePlayer,CV[17],CV[2])
				CIfEnd()
			CIfEnd()	
			CIfX(IncludePlayer,{NVar(CV[11],AtLeast,1),NVar(CV[11],AtMost,0x7FFFFFFF)},SetNVar(CV[18],SetTo,1))
				CWhileX(IncludePlayer,{TNVar(CV[18],AtMost,CV[2]),NVar(CV[17],AtLeast,1),TNVar(CV[17],AtMost,CV[2])})
					CIf(IncludePlayer,{TMemory(_Add(CV[16],CV[17]),AtLeast,1)},SetNVar(CV[17],Add,1))
						CTrigger(IncludePlayer,{TNVar(CV[17],AtLeast,CV[20])},{TSetNVar(CV[17],Subtract,CV[2])},{Preserved})
					CIfEnd()
				CWhileXEnd(SetNVar(CV[18],Add,1))
			CElseIfX(NVar(CV[11],AtLeast,0x80000000),SetNVar(CV[18],SetTo,1))
				CWhileX(IncludePlayer,{TNVar(CV[18],AtMost,CV[2]),NVar(CV[17],AtLeast,1),TNVar(CV[17],AtMost,CV[2])})
					CIf(IncludePlayer,{TMemory(_Add(CV[16],CV[17]),AtLeast,1)},SetNVar(CV[17],Add,-1))
						CTrigger(IncludePlayer,{TTNVar(CV[17],iAtMost,0)},{TSetNVar(CV[17],Add,CV[2])},{Preserved})
					CIfEnd()
				CWhileXEnd(SetNVar(CV[18],Add,1))
			CIfXEnd()

			CIf(IncludePlayer,{TMemory(_Add(CV[16],CV[17]),Exactly,0)},{SetNVar(CV[5],Subtract,1),SetNVar(CV[6],Subtract,1)})
				f_SHRead(IncludePlayer,_Add(CV[5],CV[17]),CV[9])
				f_SHRead(IncludePlayer,_Add(CV[6],CV[17]),CV[10])

				CWrite(IncludePlayer,_Add(CV[7],CV[21]),CV[9]) -- X
				CWrite(IncludePlayer,_Add(CV[8],CV[21]),CV[10]) -- Y
				DoActionsX(IncludePlayer,{SetNVar(CV[5],Add,1),SetNVar(CV[6],Add,1),SetNVar(CV[21],Add,1)})
				CIf(IncludePlayer,NVar(CV[11],AtLeast,1))
					CWrite(IncludePlayer,_Add(CV[16],CV[17]),1)
				CIfEnd()
			CIfEnd()
		CElseX()
			CIfX(IncludePlayer,{NVar(CV[11],AtLeast,1),NVar(CV[11],AtMost,0x7FFFFFFF)},{SetNVar(CV[18],SetTo,1)})
				CWhileX(IncludePlayer,{TNVar(CV[18],AtMost,CV[2]),NVar(CV[17],AtLeast,1),TNVar(CV[17],AtMost,CV[2])})
					CTrigger(IncludePlayer,{TMemory(_Add(CV[16],CV[17]),AtLeast,1)},{SetNVar(CV[17],Add,1)},{Preserved})
				CWhileXEnd(SetNVar(CV[18],Add,1))
			CElseIfX(NVar(CV[11],AtLeast,0x80000000),SetNVar(CV[18],SetTo,1))
				CWhileX(IncludePlayer,{TNVar(CV[18],AtMost,CV[2]),NVar(CV[17],AtLeast,1),TNVar(CV[17],AtMost,CV[2])})
					CTrigger(IncludePlayer,{TMemory(_Add(CV[16],CV[17]),AtLeast,1)},{SetNVar(CV[17],Add,-1)},{Preserved})
				CWhileXEnd(SetNVar(CV[18],Add,1))
			CIfXEnd()

			CIf(IncludePlayer,{NVar(CV[17],AtLeast,1),TNVar(CV[17],AtMost,CV[2])})
				CIf(IncludePlayer,{TMemory(_Add(CV[16],CV[17]),Exactly,0)},{SetNVar(CV[5],Subtract,1),SetNVar(CV[6],Subtract,1)})
					f_SHRead(IncludePlayer,_Add(CV[5],CV[17]),CV[9])
					f_SHRead(IncludePlayer,_Add(CV[6],CV[17]),CV[10])

					CWrite(IncludePlayer,_Add(CV[7],CV[21]),CV[9]) -- X
					CWrite(IncludePlayer,_Add(CV[8],CV[21]),CV[10]) -- Y
					DoActionsX(IncludePlayer,{SetNVar(CV[5],Add,1),SetNVar(CV[6],Add,1),SetNVar(CV[21],Add,1)})
					CIf(IncludePlayer,NVar(CV[11],AtLeast,1))
						CWrite(IncludePlayer,_Add(CV[16],CV[17]),1)
					CIfEnd()
				CIfEnd()
			CIfEnd()
		CIfXEnd()
	CWhileXEnd({SetNVar(CV[1],Add,1),SetNVar(CV[3],Add,1),SetNVar(CV[19],Add,1)})
	CMov(IncludePlayer,CV[1],CV[21])
	Trigger { 
		players = {IncludePlayer},
			conditions = {
				Label(FCBSPLTAlloc);
			},
			actions = {SetDeaths(0,SetTo,0,0)},
			flag = {Preserved}
		}
end

end

function Include_CBPaint()
	if CheckInclude_CBPaint == 0 then
		CheckInclude_CBPaint = 1
	if STRCTRIGASM == 0 then
		Need_STRCTRIGASM()
	end

	local IncludePlayer = IncludePlayerID
	FCBPAINTCheck = 1

	local CVoid = f_GetVoidptr(IncludePlayer,0x25C00) -- 64 * 0x970 공용 메모리
	local CV = CreateVarArr(64,IncludePlayer) -- 공용변수
	FCBPAINTCVoid = CVoid
	FCBPAINTCVArr = CV
	CBPlotTempArr = CV

	-- CB_Shuffle - CV[1] = Start / CV[2] = End / CV[3] : Shape Limit / CV[4] : Shape[1]
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : TempX / CV[8] : TempY / CV[9] : X / CV[10] : Y / CV[11] : k / CV[12] : k-x
	FCBSHFLAlloc = FuncAlloc
	FCBSHFLCall1 = FuncAlloc
	FCBSHFLCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Reverse - CV[1] = Start / CV[2] = End / CV[3] : Shape Limit / CV[4] : Shape[1]
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : TempX / CV[8] : TempY / CV[9] : X / CV[10] : Y / CV[11] : k / CV[12] : k-x
	FCBRVRSAlloc = FuncAlloc
	FCBRVRSCall1 = FuncAlloc
	FCBRVRSCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_ConvertRA - CV[1] : Shape Loop / CV[2] : Shape Limit / CV[3] : RetShape Loop / CV[4] : RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : R / CV[12] : A
	FCBCONVRAAlloc = FuncAlloc
	FCBCONVRACall1 = FuncAlloc
	FCBCONVRACall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_ConvertXY - CV[1] : Shape Loop / CV[2] : Shape Limit / CV[3] : RetShape Loop / CV[4] : RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : R / CV[10] : A / CV[11] : X / CV[12] : Y
	FCBCONVXYAlloc = FuncAlloc
	FCBCONVXYCall1 = FuncAlloc
	FCBCONVXYCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Move - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	FCBMOVEAlloc = FuncAlloc
	FCBMOVECall1 = FuncAlloc
	FCBMOVECall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_MoveCenter - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : XCntr / CV[12] : YCntr
	-- CV[13] : Xmin / CV[14] : Xmax / CV[15] : Ymin / CV[16] : Ymax / CV[17] : dx / CV[18] : dy
	FCBMOVECNTRAlloc = FuncAlloc
	FCBMOVECNTRCall1 = FuncAlloc
	FCBMOVECNTRCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Invert - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : x=X / CV[12] : y=Y / CV[13] : (==1) X Invert On / CV[14] : (==1) Y Invert On / CV[15] : RetX / CV[16] : RetY
	FCBINVTAlloc = FuncAlloc
	FCBINVTCall1 = FuncAlloc
	FCBINVTCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Ratio - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : imulX / CV[12] : (==1) iMulX On / CV[13] : idivX / CV[14] : (==1) iDivX On 
	-- CV[15] : imulY / CV[16] : (==1) iMulY On / CV[17] : idivY / CV[18] : (==1) iDivY On 
	FCBRATOAlloc = FuncAlloc
	FCBRATOCall1 = FuncAlloc
	FCBRATOCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Rotate - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : Angle / CV[12] : XCos / CV[13] : XSin / CV[14] : YCos / CV[15] : YSin / CV[16] : RetX / CV[17] : RetY
	FCBROTAAlloc = FuncAlloc
	FCBROTACall1 = FuncAlloc
	FCBROTACall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Rotate3D - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : Z
	-- CV[12] : XYAngle / CV[13] : YZAngle / CV[14] : ZXAngle / CV[17] : uCos / CV[18] : uSin / CV[19] : vCos / CV[20] : vSin 
	FCBROTA3DAlloc = FuncAlloc
	FCBROTA3DCall1 = FuncAlloc
	FCBROTA3DCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Crop - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : X1 / CV[12] : (==1) X1 On / CV[13] : X2 / CV[14] : (==1) X2 On  / CV[19] : Check
	-- CV[15] : Y1 / CV[16] : (==1) Y1 On / CV[17] : Y2 / CV[18] : (==1) Y2 On / CV[20] : RetNumber
	FCBCROPAlloc = FuncAlloc
	FCBCROPCall1 = FuncAlloc
	FCBCROPCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_MirrorX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : x=X / CV[12] : Side / CV[13] : 2X 
	FCBMIRXAlloc = FuncAlloc
	FCBMIRXCall1 = FuncAlloc
	FCBMIRXCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_MirrorY - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : y=Y / CV[12] : Side / CV[13] : 2Y 
	FCBMIRYAlloc = FuncAlloc
	FCBMIRYCall1 = FuncAlloc
	FCBMIRYCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Distortion - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : XLU / CV[12] : YLU / CV[13] : XLD / CV[14] : YLD / CV[15] : XRU / CV[16] : YRU / CV[17] : XRD / CV[18] : YRD
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[31] : R1Y1 / CV[32] : R1Y2 / CV[33] : R2Y1 / CV[34] : R2Y2 
	-- CV[35] : R3X1 / CV[36] : R3X2 / CV[37] : R4X1 / CV[38] : R4X2 / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin
	-- CV[41] : R1ΔY / CV[42] : R2ΔY / CV[43] : R3ΔX / CV[44] : R4ΔX / CV[45] : ΔX*XCntr / CV[46] : ΔY*YCntr 
	-- CV[47] : R1k / CV[48] : R2k / CV[49] : R3k / CV[50] : R4k
	FCBDTRNAlloc = FuncAlloc
	FCBDTRNCall1 = FuncAlloc
	FCBDTRNCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Distortion2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : XLU / CV[12] : YLU / CV[13] : XLD / CV[14] : YLD / CV[15] : XRU / CV[16] : YRU / CV[17] : XRD / CV[18] : YRD
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[31] : R1Y1 / CV[32] : R1Y2 / CV[33] : R2Y1 / CV[34] : R2Y2 
	-- CV[35] : R3X1 / CV[36] : R3X2 / CV[37] : R4X1 / CV[38] : R4X2 / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin
	-- CV[41] : R1ΔY / CV[42] : R2ΔY / CV[43] : R3ΔX / CV[44] : R4ΔX / CV[45] : ΔX*XCntr / CV[46] : ΔY*YCntr 
	-- CV[47] : R1k / CV[48] : R2k / CV[49] : R3k / CV[50] : R4k
	FCBDTRN2Alloc = FuncAlloc
	FCBDTRN2Call1 = FuncAlloc
	FCBDTRN2Call2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Warping - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : UFunc Init / CV[12] : UFunc End / CV[13] : DFunc Init / CV[14] : DFunc End / CV[15] : LFunc Init / CV[16] : LFunc End / CV[17] : RFunc Init / CV[18] : RFunc End
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin / CV[45] : ΔX*XCntr / CV[46] : ΔY*YCntr 
	FCBWARPAlloc = FuncAlloc
	FCBWARPCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 5
	FCBWARPCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_KaleidoscopeX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : CV[4] - n
	FCBKADSXAlloc = FuncAlloc
	FCBKADSXCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBKADSXCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_Kaleidoscope2X - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : Q / CV[15] : 360/n / CV[16] : +Angle
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : R / CV[20] : Loop R // Cycle = Q*n + R
	FCBKADSX2Alloc = FuncAlloc
	FCBKADSX2Call1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBKADSX2Call2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_Kaleidoscope - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : Mirror Angle / CV[20] : 2*Point / CV[21] : Temp / CV[22] : Temp2
	FCBKADSAlloc = FuncAlloc
	FCBKADSCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBKADSCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_Kaleidoscope2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : Mirror Angle / CV[20] : 2*Point / CV[21] : Q / CV[22] : R
	-- CV[23] : Loop R / CV[24] : Temp / CV[25] : Temp2 // Cycle = Q*n + R
	FCBKADS2Alloc = FuncAlloc
	FCBKADS2Call1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBKADS2Call2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_Vector2D - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : VectorFunc Init / CV[12] : VectorFunc End 
	FCBVECTAlloc = FuncAlloc
	FCBVECTCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 2
	FCBVECTCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_ShapeInShape - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : IFArrX / CV[12] : IFArrY / CV[13] : Rotate / CV[14] : Angle / CV[15] : InShape Loop
	-- CV[16] : InShape Limit / CV[17] : InX / CV[18] : InY / CV[19] : Base Angle / 
	-- CV[21] ~ CV[24] : Temp
	FCBSHISAlloc = FuncAlloc
	FCBSHISCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBSHISCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_CropPath - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : PFArrX / CV[12] : PFArrY / CV[13] : Outside / CV[14] : Path Loop / CV[15] : Path Limit
	-- CV[17] : PX / CV[18] : PY / CV[19] : PX2 / CV[20] : PY2 / CV[21] : Intersect / CV[22] : Cond1 / CV[23] : Cond2 / 
	-- CV[24] : Path Loop+1 / CV[16] : RetX
	FCBCROPAAlloc = FuncAlloc
	FCBCROPACall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBCROPACall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_CropGraph - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] ~ CV[12] : CropFunc / CV[13] : Sign 
	FCBCROPGAlloc = FuncAlloc
	FCBCROPGCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 2
	FCBCROPGCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_Copy - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY 
	FCBCOPYAlloc = FuncAlloc
	FCBCOPYCall1 = FuncAlloc
	FCBCOPYCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Fill - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : FArrY
	-- CV[5] : startX / CV[6] : startY / CV[7] : sizeX / CV[8] : sizeY / CV[9] : numX / CV[10] : numY
	-- CV[11] : X / CV[12] : numX Backup
	FCBFILLAlloc = FuncAlloc
	FCBFILLCall1 = FuncAlloc
	FCBFILLCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Draw - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : FArrY
	-- CV[5] : StartX / CV[6] : StartY / CV[7] : sizeX / CV[8] : sizeY / CV[9] : num
	FCBDRAWAlloc = FuncAlloc
	FCBDRAWCall1 = FuncAlloc
	FCBDRAWCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Draw2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : FArrY / CV[12] : Check
	-- CV[5] : StartX / CV[6] : StartY / CV[7] : sizeX / CV[8] : sizeY / CV[9] : num / CV[10] : -X / CV[11] : -Y 
	FCBDRAW2Alloc = FuncAlloc
	FCBDRAW2Call1 = FuncAlloc
	FCBDRAW2Call2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Overlap - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y
	FCBOVERAlloc = FuncAlloc
	FCBOVERCall1 = FuncAlloc
	FCBOVERCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_OverlapX- CV[1] = ShapeA Loop / CV[2] = ShapeA Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : AFArrX / CV[6] : AFArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y
	-- CV[11] : ShapeB Loop / CV[12] : ShapeB Limit / CV[13] : BFArrX / CV[14] : BFArrY
	FCBOVERXAlloc = FuncAlloc
	FCBOVERXCall1 = FuncAlloc
	FCBOVERXCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Merge - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : RetShape Temp Loop / CV[14] : RetShape Loop Max / CV[15] : Xmin / CV[16] : Xmax / CV[17] : Ymin / CV[18] : Ymax
	-- CV[19] : RFArrX Loop / CV[20] : RFArrY Loop
	FCBMERGAlloc = FuncAlloc
	FCBMERGCall1 = FuncAlloc
	FCBMERGCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_MergeX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : ShapeB X / CV[14] : ShapeB Y
	-- CV[19] : BFArrX Loop / CV[20] : BFArrY Loop / CV[21] : ShapeB Loop / CV[22] : ShapeB Limit / CV[23] : BFArrX / CV[24] : BFArrY / CV[25] : Loop
	FCBMERGXAlloc = FuncAlloc
	FCBMERGXCall1 = FuncAlloc
	FCBMERGXCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Intersect - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : ShapeB X / CV[14] : ShapeB Y
	-- CV[19] : BFArrX Loop / CV[20] : BFArrY Loop / CV[21] : ShapeB Loop / CV[22] : ShapeB Limit / CV[23] : BFArrX / CV[24] : BFArrY
	FCBINTSAlloc = FuncAlloc
	FCBINTSCall1 = FuncAlloc
	FCBINTSCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Subtract - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : ShapeB X / CV[14] : ShapeB Y
	-- CV[19] : BFArrX Loop / CV[20] : BFArrY Loop / CV[21] : ShapeB Loop / CV[22] : ShapeB Limit / CV[23] : BFArrX / CV[24] : BFArrY
	FCBSUBTAlloc = FuncAlloc
	FCBSUBTCall1 = FuncAlloc
	FCBSUBTCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Xor - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : ShapeB X / CV[14] : ShapeB Y
	-- CV[19] : BFArrX Loop / CV[20] : BFArrY Loop / CV[21] : ShapeB Loop / CV[22] : ShapeB Limit / CV[23] : BFArrX / CV[24] : BFArrY / CV[25] : Loop
 	FCBXORAlloc = FuncAlloc
	FCBXORCall1 = FuncAlloc
	FCBXORCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_RemoveStack - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : SizeX / CV[12] : SizeY
	-- CV[13] : RetShape Temp Loop  / CV[15] : Xmin / CV[16] : Xmax / CV[17] : Ymin / CV[18] : Ymax
	-- CV[19] : RFArrX Loop / CV[20] : RFArrY Loop / CV[14] : Priority
	FCBRMSTAlloc = FuncAlloc
	FCBRMSTCall1 = FuncAlloc
	FCBRMSTCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_GetXmax - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX
	-- CV[5] : X / CV[6] : Xmax  
	FCBXMAXAlloc = FuncAlloc
	FCBXMAXCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBXMAXCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_GetXmin - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX
	-- CV[5] : X / CV[6] : Xmin  
	FCBXMINAlloc = FuncAlloc
	FCBXMINCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBXMINCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_GetXCntr - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : Xmax
	-- CV[5] : X / CV[6] : Xmin / CV[7] : XCntr
	FCBXCNTRAlloc = FuncAlloc
	FCBXCNTRCall1 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
	FCBXCNTRCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_TCopy - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : LoopArr / CV[6] : RetLoopArr / CV[7] : LoopMax
	FCBTCPYAlloc = FuncAlloc
	FCBTCPYCall1 = FuncAlloc
	FCBTCPYCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Delete - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] : FArrX / CV[4] : FArrY 
	-- CV[5] : TX / CV[6] : TY / CV[7] : SizeX / CV[8] : SizeY / CV[9] : Shape Loop / CV[10] : X / CV[11] : Y
	-- CV[12] : Xmin / CV[13] : Xmax / CV[14] : Ymin / CV[15] : Ymax
	FCBDELTAlloc = FuncAlloc
	FCBDELTCall1 = FuncAlloc
	FCBDELTCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_TDelete - CV[1] = Shape Loop / CV[2] = FArrN /  CV[3] : Index / CV[4] : Loop Limit
	-- CV[5] : Shape Loop / CV[6] : LoopMax 
	FCBTDELAlloc = FuncAlloc
	FCBTDELCall1 = FuncAlloc
	FCBTDELCall2 = FuncAlloc+1
	FuncAlloc = FuncAlloc + 2

	-- CB_Sort - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : Direction / CV[12~13] : SFunc 
	-- CV[14] : kMin -> CV[16] : Save / CV[15] : CVoid / CV[17~18] : PX,PY / CV[19] : K / CV[20] : FuncType / CV[24] : SortType
	-- CV[21] : Step / CV[22~23] : Func
	FCBSORTAlloc = FuncAlloc
	FCBSORTCall1 = FuncAlloc
	FuncAlloc = FuncAlloc+4
	FCBSORTCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1

	-- CB_Split - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y
	-- CV[11] : Overwrite / CV[12] : Looper / CV[13] : N / CV[14~15] : Func / CV[16] : CVoid / CV[17] : temp 
	-- CV[18] : k / CV[19] : Loop+1 / CV[20] : Shape[1]+1
	FCBSPLTAlloc = FuncAlloc
	FCBSPLTCall1 = FuncAlloc
	FuncAlloc = FuncAlloc+1
	FuncAlloc = FuncAlloc + 1
	FCBSPLTCall2 = FuncAlloc
	FuncAlloc = FuncAlloc + 1
end
end

function CB_Shuffle(Start,End,Shape)
	FCBSHFLCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Move - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Start)
	CMov(PlayerID,CV[2],End)

	local RetAct = {}
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[Shape]-1))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[3],AtLeast,1);
			},
			actions = {
				SetNVar(CV[3],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSHFLCall1,0x0,0,0);
				SetCtrigX("X",FCBSHFLCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSHFLCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSHFLCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}
end

function CB_Reverse(Start,End,Shape)
	FCBRVRSCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Move - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Start)
	CMov(PlayerID,CV[2],End)

	local RetAct = {}
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[Shape]-1))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[3],AtLeast,1);
			},
			actions = {
				SetNVar(CV[3],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBRVRSCall1,0x0,0,0);
				SetCtrigX("X",FCBRVRSCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBRVRSCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBRVRSCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}
end

function CB_ConvertRA(Shape,RetShape)
	FCBCONVRACheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_ConvertRA - CV[1] : Shape Loop / CV[2] : Shape Limit / CV[3] : RetShape Loop / CV[4] : RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : R / CV[12] : A
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBCONVRA
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCONVRACall1,0x0,0,0);
				SetCtrigX("X",FCBCONVRACall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCONVRACall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCONVRACall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_ConvertXY(Shape,RetShape)
	FCBCONVXYCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_ConvertXY - CV[1] : Shape Loop / CV[2] : Shape Limit / CV[3] : RetShape Loop / CV[4] : RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : R / CV[10] : A / CV[11] : X / CV[12] : Y
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBCONVXY
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCONVXYCall1,0x0,0,0);
				SetCtrigX("X",FCBCONVXYCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCONVXYCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCONVXYCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_InitVShape(Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum

	local Temp = CreateSVar(3,PlayerID)[1]
	local Temp2 = CreateSVar(4,PlayerID)[1]
	local Temp3 = CreateSVar(3,PlayerID)[1]
	local Ret = {{Temp[1],Temp[2],0,"V"},CreateVar(PlayerID),nil,CreateVar(PlayerID),{Temp2[1],Temp2[2],0,"V"},{Temp3[1],Temp3[2],0,"V"}}
	local FXData = FArr(FX[Shape],0)
	local FYData = FArr(FY[Shape],0)
	DoActionsX(PlayerID,{ -- Recover
		SetCtrig1X("X",Ret[1][2],0x15C,0,SetTo,Num[Shape]);
		SetCtrig1X("X",Ret[1][2],0x160,0,SetTo,Add*16777216,0xFF000000);
		SetCtrigX("X",Ret[1][2],0x19C,0,SetTo,FXData[1],FXData[2],FXData[3],1,FXData[4]); 
		SetCtrigX("X",Ret[1][2],0x1DC,0,SetTo,FYData[1],FYData[2],FYData[3],1,FYData[4]); 
		SetCtrigX("X",Ret[2][2],0x158,0,SetTo,"X",CA[7],0x15C,1,Shape);
		SetCtrigX("X",Ret[4][2],0x15C,0,SetTo,"X",CA[7],0x15C,1,Shape);

		SetCtrigX("X",Ret[5][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape);
		SetCtrigX("X",Ret[5][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[5][2],0x19C,0,SetTo,0x200,0x200);
		SetCtrigX("X",Ret[5][2],0x1D8,0,SetTo,"X",Ret[5][2],0x4,1,0); SetCtrigX("X",Ret[5][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape);
		SetCtrigX("X",Ret[5][2],0x218,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[5][2],0x21C,0,SetTo,"X",Ret[6][2],0x0,0,0);

		SetCtrigX("X",Ret[6][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape); SetCtrigX("X",Ret[6][2],0x15C,0,SetTo,"X",CA[10],0x15C,1,0);
		SetCtrigX("X",Ret[6][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[6][2],0x19C,0,SetTo,0x000,0x200);
		SetCtrigX("X",Ret[6][2],0x1D8,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[6][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape+1);
	})
	return Ret
end

function CB_VShape(VShape,Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local Ret = VShape

	local FXData = FArr(FX[Shape],0)
	local FYData = FArr(FY[Shape],0)
	DoActionsX(PlayerID,{ -- Recover
		SetCtrig1X("X",Ret[1][2],0x15C,0,SetTo,Num[Shape]);
		SetCtrig1X("X",Ret[1][2],0x160,0,SetTo,Add*16777216,0xFF000000);
		SetCtrigX("X",Ret[1][2],0x19C,0,SetTo,FXData[1],FXData[2],FXData[3],1,FXData[4]); 
		SetCtrigX("X",Ret[1][2],0x1DC,0,SetTo,FYData[1],FYData[2],FYData[3],1,FYData[4]); 
		SetCtrigX("X",Ret[2][2],0x158,0,SetTo,"X",CA[7],0x15C,1,Shape);
		SetCtrigX("X",Ret[4][2],0x15C,0,SetTo,"X",CA[7],0x15C,1,Shape);

		SetCtrigX("X",Ret[5][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape);
		SetCtrigX("X",Ret[5][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[5][2],0x19C,0,SetTo,0x200,0x200);
		SetCtrigX("X",Ret[5][2],0x1D8,0,SetTo,"X",Ret[5][2],0x4,1,0); SetCtrigX("X",Ret[5][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape);
		SetCtrigX("X",Ret[5][2],0x218,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[5][2],0x21C,0,SetTo,"X",Ret[6][2],0x0,0,0);

		SetCtrigX("X",Ret[6][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape); SetCtrigX("X",Ret[6][2],0x15C,0,SetTo,"X",CA[10],0x15C,1,0);
		SetCtrigX("X",Ret[6][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[6][2],0x19C,0,SetTo,0x000,0x200);
		SetCtrigX("X",Ret[6][2],0x1D8,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[6][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape+1);
	})
end

function CB_Move(X,Y,Shape,RetShape)
	FCBMOVECheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Move - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],X)
	CMov(PlayerID,CV[12],Y)
	
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBMOVECall1,0x0,0,0);
				SetCtrigX("X",FCBMOVECall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBMOVECall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBMOVECall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_MoveCenter(X,Y,Shape,RetShape)
	FCBMOVECNTRCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_MoveCenter - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : XCntr / CV[12] : YCntr
	-- CV[13] : Xmin / CV[14] : Xmax / CV[15] : Ymin / CV[16] : Ymax / CV[17] : dx / CV[18] : dy
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],X)
	CMov(PlayerID,CV[12],Y)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBMOVECNTRCall1,0x0,0,0);
				SetCtrigX("X",FCBMOVECNTRCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBMOVECNTRCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBMOVECNTRCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end

	RecoverCp(PlayerID)
end

function CB_Invert(X,Y,Shape,RetShape)
	FCBINVTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Invert - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : x=X / CV[12] : y=Y / CV[13] : (==1) X Invert On / CV[14] : (==1) Y Invert On / CV[15] : RetX / CV[16] : RetY 
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if X ~= nil then
		CMov(PlayerID,CV[11],X)
		CMov(PlayerID,CV[13],1)
	else
		CMov(PlayerID,CV[13],0)
	end
	if Y ~= nil then
		CMov(PlayerID,CV[12],Y)
		CMov(PlayerID,CV[14],1)
	else
		CMov(PlayerID,CV[14],0)
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBINVTCall1,0x0,0,0);
				SetCtrigX("X",FCBINVTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBINVTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBINVTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Ratio(imulX,idivX,imulY,idivY,Shape,RetShape)
	FCBRATOCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Ratio - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : imulX / CV[12] : (==1) iMulX On / CV[13] : idivX / CV[14] : (==1) iDivX On 
	-- CV[15] : imulY / CV[16] : (==1) iMulY On / CV[17] : idivY / CV[18] : (==1) iDivY On 
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if imulX ~= nil then
		CMov(PlayerID,CV[11],imulX)
		CMov(PlayerID,CV[12],1)
	else
		CMov(PlayerID,CV[12],0)
	end
	if idivX ~= nil then
		CMov(PlayerID,CV[13],idivX)
		CMov(PlayerID,CV[14],1)
	else
		CMov(PlayerID,CV[14],0)
	end
	if imulY ~= nil then
		CMov(PlayerID,CV[15],imulY)
		CMov(PlayerID,CV[16],1)
	else
		CMov(PlayerID,CV[16],0)
	end
	if idivY ~= nil then
		CMov(PlayerID,CV[17],idivY)
		CMov(PlayerID,CV[18],1)
	else
		CMov(PlayerID,CV[18],0)
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBRATOCall1,0x0,0,0);
				SetCtrigX("X",FCBRATOCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBRATOCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBRATOCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBRATOCall1,0x0,0,0);
				SetCtrigX("X",FCBRATOCall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Rotate(Angle,Shape,RetShape)
	FCBROTACheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Rotate - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : Angle / CV[12] : XCos / CV[13] : XSin / CV[14] : YCos / CV[15] : YSin / CV[16] : RetX / CV[17] : RetY
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Angle)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBROTACall1,0x0,0,0);
				SetCtrigX("X",FCBROTACall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBROTACall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBROTACall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBROTACall1,0x0,0,0);
				SetCtrigX("X",FCBROTACall2,0x4,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Rotate3D(XYAngle,YZAngle,ZXAngle,Shape,RetShape)
	FCBROTA3DCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Rotate3D - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : Z
	-- CV[12] : XYAngle / CV[13] : YZAngle / CV[14] : ZXAngle / CV[17] : uCos / CV[18] : uSin / CV[19] : vCos / CV[20] : vSin 
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if XYAngle ~= nil then
		CMov(PlayerID,CV[12],XYAngle)
	else
		CMov(PlayerID,CV[12],0)
	end
	if YZAngle ~= nil then
		CMov(PlayerID,CV[13],YZAngle)
	else
		CMov(PlayerID,CV[13],0)
	end
	if ZXAngle ~= nil then
		CMov(PlayerID,CV[14],ZXAngle)
	else
		CMov(PlayerID,CV[14],0)
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBROTA3DCall1,0x0,0,0);
				SetCtrigX("X",FCBROTA3DCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBROTA3DCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBROTA3DCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Crop(X1,X2,Y1,Y2,Shape,RetShape)
	FCBCROPCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Crop - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : X1 / CV[12] : (==1) X1 On / CV[13] : X2 / CV[14] : (==1) X2 On  / CV[19] : Check
	-- CV[15] : Y1 / CV[16] : (==1) Y1 On / CV[17] : Y2 / CV[18] : (==1) Y2 On / CV[20] : RetNumber
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if X1 ~= nil then
		CMov(PlayerID,CV[11],X1)
		CMov(PlayerID,CV[12],1)
	else
		CMov(PlayerID,CV[12],0)
	end
	if X2 ~= nil then
		CMov(PlayerID,CV[13],X2)
		CMov(PlayerID,CV[14],1)
	else
		CMov(PlayerID,CV[14],0)
	end
	if Y1 ~= nil then
		CMov(PlayerID,CV[15],Y1)
		CMov(PlayerID,CV[16],1)
	else
		CMov(PlayerID,CV[16],0)
	end
	if Y2 ~= nil then
		CMov(PlayerID,CV[17],Y2)
		CMov(PlayerID,CV[18],1)
	else
		CMov(PlayerID,CV[18],0)
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCROPCall1,0x0,0,0);
				SetCtrigX("X",FCBCROPCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCROPCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCROPCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_MirrorX(X,Side,Shape,RetShape)
	FCBMIRXCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_MirrorX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : x=X / CV[12] : Side / CV[13] : 2X 
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],X)
	CMov(PlayerID,CV[12],Side)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-2))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-2);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBMIRXCall1,0x0,0,0);
				SetCtrigX("X",FCBMIRXCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBMIRXCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBMIRXCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_MirrorY(Y,Side,Shape,RetShape)
	FCBMIRYCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_MirrorY - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : y=Y / CV[12] : Side / CV[13] : 2Y 
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Y)
	CMov(PlayerID,CV[12],Side)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-2))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-2);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}


	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBMIRYCall1,0x0,0,0);
				SetCtrigX("X",FCBMIRYCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBMIRYCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBMIRYCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Distortion(mulLU,mulLD,mulRU,mulRD,CenterXY,Shape,RetShape)
	FCBDTRNCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Distortion - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : XLU / CV[12] : YLU / CV[13] : XLD / CV[14] : YLD / CV[15] : XRU / CV[16] : YRU / CV[17] : XRD / CV[18] : YRD
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[31] : R1Y1 / CV[32] : R1Y2 / CV[33] : R2Y1 / CV[34] : R2Y2 
	-- CV[35] : R3X1 / CV[36] : R3X2 / CV[37] : R4X1 / CV[38] : R4X2 / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin
	-- CV[41] : R1ΔY / CV[42] : R2ΔY / CV[43] : R3ΔX / CV[44] : R4ΔX / CV[45] : ΔX*XCntr / CV[46] : ΔX*YCntr 
	-- CV[47] : R1k / CV[48] : R2k / CV[49] : R3k / CV[50] : R4k
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if mulLU == nil then
		CMov(PlayerID,CV[11],1)
		CMov(PlayerID,CV[12],1)
	else
		if mulLU[1] == nil then
			CMov(PlayerID,CV[11],1)
		else
			CMov(PlayerID,CV[11],mulLU[1])
		end
		if mulLU[2] == nil then
			CMov(PlayerID,CV[12],1)
		else
			CMov(PlayerID,CV[12],mulLU[2])
		end
	end

	if mulLD == nil then
		CMov(PlayerID,CV[13],1)
		CMov(PlayerID,CV[14],1)
	else
		if mulLD[1] == nil then
			CMov(PlayerID,CV[13],1)
		else
			CMov(PlayerID,CV[13],mulLD[1])
		end
		if mulLD[2] == nil then
			CMov(PlayerID,CV[14],1)
		else
			CMov(PlayerID,CV[14],mulLD[2])
		end
	end

	if mulRU == nil then
		CMov(PlayerID,CV[15],1)
		CMov(PlayerID,CV[16],1)
	else
		if mulRU[1] == nil then
			CMov(PlayerID,CV[15],1)
		else
			CMov(PlayerID,CV[15],mulRU[1])
		end
		if mulRU[2] == nil then
			CMov(PlayerID,CV[16],1)
		else
			CMov(PlayerID,CV[16],mulRU[2])
		end
	end

	if mulRD == nil then
		CMov(PlayerID,CV[17],1)
		CMov(PlayerID,CV[18],1)
	else
		if mulRD[1] == nil then
			CMov(PlayerID,CV[17],1)
		else
			CMov(PlayerID,CV[17],mulRD[1])
		end
		if mulRD[2] == nil then
			CMov(PlayerID,CV[18],1)
		else
			CMov(PlayerID,CV[18],mulRD[2])
		end
	end

	if CenterXY == nil then
		CMov(PlayerID,CV[19],0)
		CMov(PlayerID,CV[20],0)
	else
		if CenterXY[1] == nil then
			CMov(PlayerID,CV[19],0)
		else
			CMov(PlayerID,CV[19],CenterXY[1])
		end
		if CenterXY[2] == nil then
			CMov(PlayerID,CV[20],0)
		else
			CMov(PlayerID,CV[20],CenterXY[2])
		end
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBDTRNCall1,0x0,0,0);
				SetCtrigX("X",FCBDTRNCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBDTRNCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBDTRNCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end

	RecoverCp(PlayerID)
end

function CB_Distortion2(dLU,dLD,dRU,dRD,CenterXY,Shape,RetShape)
	FCBDTRN2Check = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Distortion2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : XLU / CV[12] : YLU / CV[13] : XLD / CV[14] : YLD / CV[15] : XRU / CV[16] : YRU / CV[17] : XRD / CV[18] : YRD
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[31] : R1Y1 / CV[32] : R1Y2 / CV[33] : R2Y1 / CV[34] : R2Y2 
	-- CV[35] : R3X1 / CV[36] : R3X2 / CV[37] : R4X1 / CV[38] : R4X2 / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin
	-- CV[41] : R1ΔY / CV[42] : R2ΔY / CV[43] : R3ΔX / CV[44] : R4ΔX / CV[45] : ΔX*XCntr / CV[46] : ΔX*YCntr 
	-- CV[47] : R1k / CV[48] : R2k / CV[49] : R3k / CV[50] : R4k
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if dLU == nil then
		CMov(PlayerID,CV[11],0)
		CMov(PlayerID,CV[12],0)
	else
		if dLU[1] == nil then
			CMov(PlayerID,CV[11],0)
		else
			CMov(PlayerID,CV[11],dLU[1])
		end
		if dLU[2] == nil then
			CMov(PlayerID,CV[12],0)
		else
			CMov(PlayerID,CV[12],dLU[2])
		end
	end

	if dLD == nil then
		CMov(PlayerID,CV[13],0)
		CMov(PlayerID,CV[14],0)
	else
		if dLD[1] == nil then
			CMov(PlayerID,CV[13],0)
		else
			CMov(PlayerID,CV[13],dLD[1])
		end
		if dLD[2] == nil then
			CMov(PlayerID,CV[14],0)
		else
			CMov(PlayerID,CV[14],dLD[2])
		end
	end

	if dRU == nil then
		CMov(PlayerID,CV[15],0)
		CMov(PlayerID,CV[16],0)
	else
		if dRU[1] == nil then
			CMov(PlayerID,CV[15],0)
		else
			CMov(PlayerID,CV[15],dRU[1])
		end
		if dRU[2] == nil then
			CMov(PlayerID,CV[16],0)
		else
			CMov(PlayerID,CV[16],dRU[2])
		end
	end

	if dRD == nil then
		CMov(PlayerID,CV[17],0)
		CMov(PlayerID,CV[18],0)
	else
		if dRD[1] == nil then
			CMov(PlayerID,CV[17],0)
		else
			CMov(PlayerID,CV[17],dRD[1])
		end
		if dRD[2] == nil then
			CMov(PlayerID,CV[18],0)
		else
			CMov(PlayerID,CV[18],dRD[2])
		end
	end

	if CenterXY == nil then
		CMov(PlayerID,CV[19],0)
		CMov(PlayerID,CV[20],0)
	else
		if CenterXY[1] == nil then
			CMov(PlayerID,CV[19],0)
		else
			CMov(PlayerID,CV[19],CenterXY[1])
		end
		if CenterXY[2] == nil then
			CMov(PlayerID,CV[20],0)
		else
			CMov(PlayerID,CV[20],CenterXY[2])
		end
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBDTRN2Call1,0x0,0,0);
				SetCtrigX("X",FCBDTRN2Call2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBDTRN2Call2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBDTRN2Call2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end

	RecoverCp(PlayerID)
end

function CB_Warping(Ufunc,Dfunc,Lfunc,Rfunc,CenterXY,Shape,RetShape)
	FCBWARPCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Distortion2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : UFunc Init / CV[12] : UFunc End / CV[13] : DFunc Init / CV[14] : DFunc End / CV[15] : LFunc Init / CV[16] : LFunc End / CV[17] : RFunc Init / CV[18] : RFunc End
	-- CV[21] : R1Y / CV[22] : R2Y / CV[23] : R3X / CV[24] : R4X / CV[25] : Xmax / CV[26] : Xmin  / CV[27] : Ymax / CV[28] : Ymin
	-- CV[29] : XCntr / CV[30] : YCntr / CV[31] : R1Y1 / CV[32] : R1Y2 / CV[33] : R2Y1 / CV[34] : R2Y2 
	-- CV[35] : R3X1 / CV[36] : R3X2 / CV[37] : R4X1 / CV[38] : R4X2 / CV[39] : Xmax-Xmin / CV[40] : Ymax-Ymin
	-- CV[41] : R1ΔY / CV[42] : R2ΔY / CV[43] : R3ΔX / CV[44] : R4ΔX / CV[45] : ΔX*XCntr / CV[46] : ΔX*YCntr 
	-- CV[47] : R1k / CV[48] : R2k / CV[49] : R3k / CV[50] : R4k
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if Ufunc ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[11][2],0x15C,0,SetTo,Ufunc[1],Ufunc[2],0x0,0,1),
		SetCtrigX("X",CV[12][2],0x15C,0,SetTo,Ufunc[1],Ufunc[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[11],SetTo,0)})
	end
	if Dfunc ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[13][2],0x15C,0,SetTo,Dfunc[1],Dfunc[2],0x0,0,1),
		SetCtrigX("X",CV[14][2],0x15C,0,SetTo,Dfunc[1],Dfunc[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[13],SetTo,0)})
	end
	if Lfunc ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[15][2],0x15C,0,SetTo,Lfunc[1],Lfunc[2],0x0,0,1),
		SetCtrigX("X",CV[16][2],0x15C,0,SetTo,Lfunc[1],Lfunc[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[15],SetTo,0)})
	end
	if Rfunc ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[17][2],0x15C,0,SetTo,Rfunc[1],Rfunc[2],0x0,0,1),
		SetCtrigX("X",CV[18][2],0x15C,0,SetTo,Rfunc[1],Rfunc[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[17],SetTo,0)})
	end

	if CenterXY == nil then
		CMov(PlayerID,CV[19],0)
		CMov(PlayerID,CV[20],0)
	else
		if CenterXY[1] == nil then
			CMov(PlayerID,CV[19],0)
		else
			CMov(PlayerID,CV[19],CenterXY[1])
		end
		if CenterXY[2] == nil then
			CMov(PlayerID,CV[20],0)
		else
			CMov(PlayerID,CV[20],CenterXY[2])
		end
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}


	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBWARPCall1,0x0,0,0);
				SetCtrigX("X",FCBWARPCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBWARPCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBWARPCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end

	RecoverCp(PlayerID)
end

function CB_KaleidoscopeX(Point,StartAngle,Side,Shape,RetShape)
	FCBKADSXCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_KaleidoscopeX - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Point)
	if StartAngle ~= nil then
		CMov(PlayerID,CV[12],StartAngle)
	else
		CMov(PlayerID,CV[12],0)
	end
	if Side ~= nil then
		CMov(PlayerID,CV[13],Side)
	else
		CMov(PlayerID,CV[13],0)
	end
	
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBKADSXCall1,0x0,0,0);
				SetCtrigX("X",FCBKADSXCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBKADSXCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBKADSXCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Kaleidoscope2X(Point,StartAngle,Side,Shape,RetShape)
	FCBKADSX2Check = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Kaleidoscope2X - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Point)
	if StartAngle ~= nil then
		CMov(PlayerID,CV[12],StartAngle)
	else
		CMov(PlayerID,CV[12],0)
	end
	if Side ~= nil then
		CMov(PlayerID,CV[13],Side)
	else
		CMov(PlayerID,CV[13],0)
	end
	
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBKADSX2Call1,0x0,0,0);
				SetCtrigX("X",FCBKADSX2Call2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBKADSX2Call2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBKADSX2Call2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Kaleidoscope(Point,StartAngle,Side,Shape,RetShape)
	FCBKADSCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Kaleidoscope - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : Mirror Angle / CV[20] : 2*Point / CV[21] : Temp / CV[22] : Temp2
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Point)
	if StartAngle ~= nil then
		CMov(PlayerID,CV[12],StartAngle)
	else
		CMov(PlayerID,CV[12],0)
	end
	if Side ~= nil then
		CMov(PlayerID,CV[13],Side)
	else
		CMov(PlayerID,CV[13],0)
	end
	
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBKADSCall1,0x0,0,0);
				SetCtrigX("X",FCBKADSCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBKADSCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBKADSCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Kaleidoscope2(Point,StartAngle,Side,Shape,RetShape)
	FCBKADS2Check = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Kaleidoscope2 - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y 
	-- CV[11] : Point / CV[12] : StarAngle / CV[13] : Side / CV[14] : +Angle / CV[15] : 360/n / CV[16] : 360*k
	-- CV[17] : Loop / CV[18] : 2pi - 360/n / CV[19] : Mirror Angle / CV[20] : 2*Point / CV[21] : Q / CV[22] : R
	-- CV[23] : Loop R / CV[24] : Temp / CV[25] : Temp2 // Cycle = Q*n + R
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Point)
	if StartAngle ~= nil then
		CMov(PlayerID,CV[12],StartAngle)
	else
		CMov(PlayerID,CV[12],0)
	end
	if Side ~= nil then
		CMov(PlayerID,CV[13],Side)
	else
		CMov(PlayerID,CV[13],0)
	end
	
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBKADS2Call1,0x0,0,0);
				SetCtrigX("X",FCBKADS2Call2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBKADS2Call2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBKADS2Call2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Vector2D(VectorFunc,Shape,RetShape)
	FCBVECTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Vector2D - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : VectorFunc Init / CV[12] : VectorFunc End 

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	DoActionsX(PlayerID,{SetCtrigX("X",CV[11][2],0x15C,0,SetTo,VectorFunc[1],VectorFunc[2],0x0,0,1),
	SetCtrigX("X",CV[12][2],0x15C,0,SetTo,VectorFunc[1],VectorFunc[2]+1,0x4,1,0)})

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBVECTCall1,0x0,0,0);
				SetCtrigX("X",FCBVECTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBVECTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBVECTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_ShapeInShape(InShape,Rotate,Angle,Shape,RetShape)
	FCBSHISCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Vector2D - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[19] : CntrX / CV[20] : CntrY
	-- CV[11] : VectorFunc Init / CV[12] : VectorFunc End 

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if Rotate ~= nil then
		CMov(PlayerID,CV[13],Rotate)
		TriggerX(PlayerID,NVar(CV[13],AtLeast,2),SetNVar(CV[13],SetTo,2),{Preserved})
	else
		if Angle ~= nil then
			CMov(PlayerID,CV[13],2)
		else
			CMov(PlayerID,CV[13],0)
		end
	end

	if Angle ~= nil then
		CMov(PlayerID,CV[14],Angle)
	else
		CMov(PlayerID,CV[14],0)
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	if type(InShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,InShape,SetTo,"X",CV[16][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,InShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,InShape),
			SetCtrigX("X",CA[7],0x4,InShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,InShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,InShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,InShape,SetTo,"X",CA[7],0x0,0,InShape+1),
		})
		TMem(PlayerID,CV[11],FArr(FX[InShape],0))
		TMem(PlayerID,CV[12],FArr(FY[InShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,InShape[1][1],InShape[1][2],0x0,0,0);
			SetCtrigX(InShape[1][1],InShape[1][2],0x4,0,SetTo,InShape[5][1],InShape[5][2],0x0,0,0);
			SetCtrigX(InShape[6][1],InShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(InShape[5][1],InShape[5][2],0x15C,InShape[5][3],SetTo,"X",CV[16][2],0x15C,1,0),
			SetCtrig1X(InShape[1][1],InShape[1][2],0x158,InShape[1][3],SetTo,0),
			SetCtrigX(InShape[1][1],InShape[1][2],0x198,InShape[1][3],SetTo,"X",CV[11][2],0x15C,1,0),
			SetCtrigX(InShape[1][1],InShape[1][2],0x1D8,InShape[1][3],SetTo,"X",CV[12][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
				NVar(CV[16],AtLeast,1);
			},
			actions = {
				SetNVar(CV[16],Subtract,1);
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSHISCall1,0x0,0,0);
				SetCtrigX("X",FCBSHISCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSHISCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSHISCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_CropPath(Path,OutSide,Shape,RetShape)
	FCBCROPACheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Crop - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : X1 / CV[12] : (==1) X1 On / CV[13] : X2 / CV[14] : (==1) X2 On  / CV[19] : Check
	-- CV[15] : Y1 / CV[16] : (==1) Y1 On / CV[17] : Y2 / CV[18] : (==1) Y2 On / CV[20] : RetNumber
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if OutSide ~= nil then
		CMov(PlayerID,CV[13],OutSide)
	else
		CMov(PlayerID,CV[13],0)
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[1][1],Shape[1][2],Shape[1][3]);
			SetCtrigX(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x218,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end
	if type(Path) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Path,SetTo,"X",CV[15][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Path,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Path),
			SetCtrigX("X",CA[7],0x4,Path,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Path,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Path,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Path,SetTo,"X",CA[7],0x0,0,Path+1),
		})
		TMem(PlayerID,CV[11],FArr(FX[Path],0))
		TMem(PlayerID,CV[12],FArr(FY[Path],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Path[1][1],Path[1][2],Path[1][3]);
			SetCtrigX(Path[1][1],Path[1][2],0x158,Path[1][3],SetTo,"X",CV[15][2],0x15C,1,0),
			SetCtrig1X(Path[1][1],Path[1][2],0x198,Path[1][3],SetTo,0),
			SetCtrigX(Path[1][1],Path[1][2],0x1D8,Path[1][3],SetTo,"X",CV[11][2],0x15C,1,0),
			SetCtrigX(Path[1][1],Path[1][2],0x218,Path[1][3],SetTo,"X",CV[12][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrig1X(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x218,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetNVar(CV[15],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCROPACall1,0x0,0,0);
				SetCtrigX("X",FCBCROPACall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCROPACall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCROPACall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_CropGraph(CropFunc,Sign,Shape,RetShape)
	FCBCROPGCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Crop - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y  
	-- CV[11] : X1 / CV[12] : (==1) X1 On / CV[13] : X2 / CV[14] : (==1) X2 On  / CV[19] : Check
	-- CV[15] : Y1 / CV[16] : (==1) Y1 On / CV[17] : Y2 / CV[18] : (==1) Y2 On / CV[20] : RetNumber
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if Sign ~= nil then
		CMov(PlayerID,CV[13],Sign)
	else
		CMov(PlayerID,CV[13],0)
	end

	DoActionsX(PlayerID,{SetCtrigX("X",CV[11][2],0x15C,0,SetTo,CropFunc[1],CropFunc[2],0x0,0,1),
	SetCtrigX("X",CV[12][2],0x15C,0,SetTo,CropFunc[1],CropFunc[2]+1,0x4,1,0)})

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCROPGCall1,0x0,0,0);
				SetCtrigX("X",FCBCROPGCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCROPGCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCROPGCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_SetNumber(Number,Shape)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,Shape),Number)
	else
		CDoActions(PlayerID,{
			CallLabelAlways(Shape[2][1],Shape[2][2],Shape[2][3]);
			TSetCtrig1X(Shape[2][1],Shape[2][2],0x15C,Shape[2][3],SetTo,Number),
		})
	end
end

function CB_Set(Index,X,Y,Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Index)
	CMov(PlayerID,CV[2],X)
	CMov(PlayerID,CV[3],Y)

	if X ~= nil then
		if type(Shape) == "number" then
			CWrite(PlayerID,_TMem(FArr(FX[Shape],CV[1])),CV[2]) -- X
		else
			DoActionsX(PlayerID,{
				CallLabelAlways3(Shape[1][1],Shape[1][2],Shape[1][3],CV[1][1],CV[1][2],CV[1][3],CV[2][1],CV[2][2],CV[2][3]);
				SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
				SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X","X",0x158,1,1),
				SetCtrig1X(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,0),
				SetCtrigX("X",CV[1][2],0x158,0,SetTo,"X","X",0x158,1,1),
				SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CV[1][2],0x160,0,SetTo,Add*16777216,0xFF000000);
				SetCtrigX("X",CV[2][2],0x158,0,SetTo,"X","X",0x15C,1,1),
				SetCtrig1X("X",CV[2][2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CV[2][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
			})
			DoActionsX(PlayerID,{SetDeaths(0,SetTo,0,0)})
		end
	end
	if Y ~= nil then
		if type(Shape) == "number" then
			CWrite(PlayerID,_TMem(FArr(FY[Shape],CV[1])),CV[3]) -- Y
		else
			DoActionsX(PlayerID,{
				CallLabelAlways3(Shape[1][1],Shape[1][2],Shape[1][3],CV[1][1],CV[1][2],CV[1][3],CV[3][1],CV[3][2],CV[3][3]);
				SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
				SetCtrig1X(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,0),
				SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X","X",0x158,1,1),
				SetCtrigX("X",CV[1][2],0x158,0,SetTo,"X","X",0x158,1,1),
				SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CV[1][2],0x160,0,SetTo,Add*16777216,0xFF000000);
				SetCtrigX("X",CV[3][2],0x158,0,SetTo,"X","X",0x15C,1,1),
				SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
				SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
			})
			DoActionsX(PlayerID,{SetDeaths(0,SetTo,0,0)})
		end
	end
end

function CB_Copy(Shape,RetShape)
	FCBCOPYCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBCOPYCall1,0x0,0,0);
				SetCtrigX("X",FCBCOPYCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBCOPYCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBCOPYCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(Shape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Add(X,Y,Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[2],X)
	CMov(PlayerID,CV[3],Y)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})

		CIf(PlayerID,{TTNVar(CV[1],iAtMost,Num[Shape]-1)})	
			CWrite(PlayerID,_TMem(FArr(FX[Shape],CV[1])),CV[2]) -- X
			CWrite(PlayerID,_TMem(FArr(FY[Shape],CV[1])),CV[3]) -- Y
			CAdd(PlayerID,Mem("X",CA[7],0x15C,Shape),1)
		CIfEnd()
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})

		CIf(PlayerID,{TTNVar(CV[1],iAtMost,CV[4])})	
			CWrite(PlayerID,_Add(CV[5],CV[1]),CV[2]) -- X
			CWrite(PlayerID,_Add(CV[6],CV[1]),CV[3]) -- Y
			CDoActions(PlayerID,{TSetMemory(Shape[4],Add,1)})
		CIfEnd()
	end
end

function CB_Fill(startX,startY,sizeX,sizeY,numX,numY,Shape)
	FCBFILLCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[5],startX)
	CMov(PlayerID,CV[6],startY)
	CMov(PlayerID,CV[7],sizeX)
	CMov(PlayerID,CV[8],sizeY)
	CMov(PlayerID,CV[9],numX)
	CMov(PlayerID,CV[10],numY)

	local RetAct = {}
	if type(Shape) == "number" then
		table.insert(RetAct,SetNVar(CV[2],SetTo,Num[Shape]))
		TMem(PlayerID,CV[3],FArr(FX[Shape],0))
		TMem(PlayerID,CV[4],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[1][1],Shape[1][2],Shape[1][3]);
			SetCtrigX(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetNVar(CV[2],SetTo,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
		})
	end

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBFILLCall1,0x0,0,0);
				SetCtrigX("X",FCBFILLCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBFILLCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBFILLCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(Shape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,Shape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],Shape[2][1],Shape[2][2],Shape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,Shape[2][1],Shape[2][2],0x15C,1,Shape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Draw(startX,startY,sizeX,sizeY,num,Shape)
	FCBDRAWCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[5],startX)
	CMov(PlayerID,CV[6],startY)
	CMov(PlayerID,CV[7],sizeX)
	CMov(PlayerID,CV[8],sizeY)
	CMov(PlayerID,CV[9],num)

	local RetAct = {}
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})

		table.insert(RetAct,SetNVar(CV[2],SetTo,Num[Shape]-1))
		TMem(PlayerID,CV[3],FArr(FX[Shape],0))
		TMem(PlayerID,CV[4],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetNVar(CV[2],SetTo,-1);
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
		})
	end

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBDRAWCall1,0x0,0,0);
				SetCtrigX("X",FCBDRAWCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBDRAWCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBDRAWCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(Shape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,Shape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],Shape[2][1],Shape[2][2],Shape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,Shape[2][1],Shape[2][2],0x15C,1,Shape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Draw2(startX,startY,sizeX,sizeY,num,Shape)
	FCBDRAW2Check = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[5],startX)
	CMov(PlayerID,CV[6],startY)
	CMov(PlayerID,CV[7],sizeX)
	CMov(PlayerID,CV[8],sizeY)
	CMov(PlayerID,CV[9],num)

	local RetAct = {}
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})

		table.insert(RetAct,SetNVar(CV[2],SetTo,Num[Shape]-2))
		TMem(PlayerID,CV[3],FArr(FX[Shape],0))
		TMem(PlayerID,CV[4],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetNVar(CV[2],SetTo,-2);
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
		})
	end

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBDRAW2Call1,0x0,0,0);
				SetCtrigX("X",FCBDRAW2Call2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBDRAW2Call2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBDRAW2Call2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(Shape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,Shape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],Shape[2][1],Shape[2][2],Shape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,Shape[2][1],Shape[2][2],0x15C,1,Shape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Delete(X,Y,SizeX,SizeY,Shape)
	FCBDELTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[5],X)
	CMov(PlayerID,CV[6],Y)
	CMov(PlayerID,CV[7],SizeX)
	CMov(PlayerID,CV[8],SizeY)

	local RetAct = {}
	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})

		TMem(PlayerID,CV[3],FArr(FX[Shape],0))
		TMem(PlayerID,CV[4],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[1][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
		})
	end

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[1],AtLeast,1);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBDELTCall1,0x0,0,0);
				SetCtrigX("X",FCBDELTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBDELTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBDELTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(Shape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,Shape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],Shape[2][1],Shape[2][2],Shape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,Shape[2][1],Shape[2][2],0x15C,1,Shape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Overlap(Shape,RetShape)
	FCBOVERCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBOVERCall1,0x0,0,0);
				SetCtrigX("X",FCBOVERCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBOVERCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBOVERCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_OverlapX(ShapeA,ShapeB,RetShape)
	FCBOVERXCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(ShapeA) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeA),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X",CA[7],0x0,0,ShapeA+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[ShapeA],0))
		TMem(PlayerID,CV[6],FArr(FY[ShapeA],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeA[1][1],ShapeA[1][2],0x0,0,0);
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x4,0,SetTo,ShapeA[5][1],ShapeA[5][2],0x0,0,0);
			SetCtrigX(ShapeA[6][1],ShapeA[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeA[5][1],ShapeA[5][2],0x15C,ShapeA[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(ShapeA[1][1],ShapeA[1][2],0x158,ShapeA[1][3],SetTo,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x198,ShapeA[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x1D8,ShapeA[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	if type(ShapeB) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CV[12][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeB),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X",CA[7],0x0,0,ShapeB+1),
		})
		TMem(PlayerID,CV[13],FArr(FX[ShapeB],0))
		TMem(PlayerID,CV[14],FArr(FY[ShapeB],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeB[1][1],ShapeB[1][2],0x0,0,0);
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x4,0,SetTo,ShapeB[5][1],ShapeB[5][2],0x0,0,0);
			SetCtrigX(ShapeB[6][1],ShapeB[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeB[5][1],ShapeB[5][2],0x15C,ShapeB[5][3],SetTo,"X",CV[12][2],0x15C,1,0),
			SetCtrig1X(ShapeB[1][1],ShapeB[1][2],0x158,ShapeB[1][3],SetTo,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x198,ShapeB[1][3],SetTo,"X",CV[13][2],0x15C,1,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x1D8,ShapeB[1][3],SetTo,"X",CV[14][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[11],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
				NVar(CV[12],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetNVar(CV[12],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBOVERXCall1,0x0,0,0);
				SetCtrigX("X",FCBOVERXCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBOVERXCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBOVERXCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Merge(SizeX,SizeY,Shape,RetShape)
	FCBMERGCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],SizeX)
	CMov(PlayerID,CV[12],SizeY)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBMERGCall1,0x0,0,0);
				SetCtrigX("X",FCBMERGCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBMERGCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBMERGCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_MergeX(SizeX,SizeY,ShapeA,ShapeB,RetShape)
	FCBMERGXCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],SizeX)
	CMov(PlayerID,CV[12],SizeY)

	if type(ShapeA) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeA),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X",CA[7],0x0,0,ShapeA+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[ShapeA],0))
		TMem(PlayerID,CV[6],FArr(FY[ShapeA],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeA[1][1],ShapeA[1][2],0x0,0,0);
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x4,0,SetTo,ShapeA[5][1],ShapeA[5][2],0x0,0,0);
			SetCtrigX(ShapeA[6][1],ShapeA[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeA[5][1],ShapeA[5][2],0x15C,ShapeA[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(ShapeA[1][1],ShapeA[1][2],0x158,ShapeA[1][3],SetTo,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x198,ShapeA[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x1D8,ShapeA[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	if type(ShapeB) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeB),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X",CA[7],0x0,0,ShapeB+1),
		})
		TMem(PlayerID,CV[23],FArr(FX[ShapeB],0))
		TMem(PlayerID,CV[24],FArr(FY[ShapeB],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeB[1][1],ShapeB[1][2],0x0,0,0);
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x4,0,SetTo,ShapeB[5][1],ShapeB[5][2],0x0,0,0);
			SetCtrigX(ShapeB[6][1],ShapeB[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeB[5][1],ShapeB[5][2],0x15C,ShapeB[5][3],SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X(ShapeB[1][1],ShapeB[1][2],0x158,ShapeB[1][3],SetTo,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x198,ShapeB[1][3],SetTo,"X",CV[23][2],0x15C,1,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x1D8,ShapeB[1][3],SetTo,"X",CV[24][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-2))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-2);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[21],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
				NVar(CV[22],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetNVar(CV[22],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBMERGXCall1,0x0,0,0);
				SetCtrigX("X",FCBMERGXCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBMERGXCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBMERGXCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Intersect(SizeX,SizeY,ShapeA,ShapeB,RetShape)
	FCBINTSCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],SizeX)
	CMov(PlayerID,CV[12],SizeY)

	if type(ShapeA) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeA),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X",CA[7],0x0,0,ShapeA+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[ShapeA],0))
		TMem(PlayerID,CV[6],FArr(FY[ShapeA],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeA[1][1],ShapeA[1][2],0x0,0,0);
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x4,0,SetTo,ShapeA[5][1],ShapeA[5][2],0x0,0,0);
			SetCtrigX(ShapeA[6][1],ShapeA[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeA[5][1],ShapeA[5][2],0x15C,ShapeA[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(ShapeA[1][1],ShapeA[1][2],0x158,ShapeA[1][3],SetTo,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x198,ShapeA[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x1D8,ShapeA[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	if type(ShapeB) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeB),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X",CA[7],0x0,0,ShapeB+1),
		})
		TMem(PlayerID,CV[23],FArr(FX[ShapeB],0))
		TMem(PlayerID,CV[24],FArr(FY[ShapeB],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeB[1][1],ShapeB[1][2],0x0,0,0);
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x4,0,SetTo,ShapeB[5][1],ShapeB[5][2],0x0,0,0);
			SetCtrigX(ShapeB[6][1],ShapeB[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeB[5][1],ShapeB[5][2],0x15C,ShapeB[5][3],SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X(ShapeB[1][1],ShapeB[1][2],0x158,ShapeB[1][3],SetTo,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x198,ShapeB[1][3],SetTo,"X",CV[23][2],0x15C,1,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x1D8,ShapeB[1][3],SetTo,"X",CV[24][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[21],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
				NVar(CV[22],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetNVar(CV[22],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBINTSCall1,0x0,0,0);
				SetCtrigX("X",FCBINTSCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBINTSCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBINTSCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Subtract(SizeX,SizeY,ShapeA,ShapeB,RetShape)
	FCBSUBTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],SizeX)
	CMov(PlayerID,CV[12],SizeY)

	if type(ShapeA) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeA),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X",CA[7],0x0,0,ShapeA+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[ShapeA],0))
		TMem(PlayerID,CV[6],FArr(FY[ShapeA],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeA[1][1],ShapeA[1][2],0x0,0,0);
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x4,0,SetTo,ShapeA[5][1],ShapeA[5][2],0x0,0,0);
			SetCtrigX(ShapeA[6][1],ShapeA[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeA[5][1],ShapeA[5][2],0x15C,ShapeA[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(ShapeA[1][1],ShapeA[1][2],0x158,ShapeA[1][3],SetTo,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x198,ShapeA[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x1D8,ShapeA[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	if type(ShapeB) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeB),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X",CA[7],0x0,0,ShapeB+1),
		})
		TMem(PlayerID,CV[23],FArr(FX[ShapeB],0))
		TMem(PlayerID,CV[24],FArr(FY[ShapeB],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeB[1][1],ShapeB[1][2],0x0,0,0);
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x4,0,SetTo,ShapeB[5][1],ShapeB[5][2],0x0,0,0);
			SetCtrigX(ShapeB[6][1],ShapeB[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeB[5][1],ShapeB[5][2],0x15C,ShapeB[5][3],SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X(ShapeB[1][1],ShapeB[1][2],0x158,ShapeB[1][3],SetTo,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x198,ShapeB[1][3],SetTo,"X",CV[23][2],0x15C,1,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x1D8,ShapeB[1][3],SetTo,"X",CV[24][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[21],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
				NVar(CV[22],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetNVar(CV[22],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSUBTCall1,0x0,0,0);
				SetCtrigX("X",FCBSUBTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSUBTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSUBTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Xor(SizeX,SizeY,ShapeA,ShapeB,RetShape)
	FCBXORCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],SizeX)
	CMov(PlayerID,CV[12],SizeY)

	if type(ShapeA) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeA),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeA,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeA,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeA,SetTo,"X",CA[7],0x0,0,ShapeA+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[ShapeA],0))
		TMem(PlayerID,CV[6],FArr(FY[ShapeA],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeA[1][1],ShapeA[1][2],0x0,0,0);
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x4,0,SetTo,ShapeA[5][1],ShapeA[5][2],0x0,0,0);
			SetCtrigX(ShapeA[6][1],ShapeA[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeA[5][1],ShapeA[5][2],0x15C,ShapeA[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(ShapeA[1][1],ShapeA[1][2],0x158,ShapeA[1][3],SetTo,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x198,ShapeA[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(ShapeA[1][1],ShapeA[1][2],0x1D8,ShapeA[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	if type(ShapeB) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,ShapeB),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,ShapeB,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,ShapeB,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,ShapeB,SetTo,"X",CA[7],0x0,0,ShapeB+1),
		})
		TMem(PlayerID,CV[23],FArr(FX[ShapeB],0))
		TMem(PlayerID,CV[24],FArr(FY[ShapeB],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,ShapeB[1][1],ShapeB[1][2],0x0,0,0);
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x4,0,SetTo,ShapeB[5][1],ShapeB[5][2],0x0,0,0);
			SetCtrigX(ShapeB[6][1],ShapeB[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(ShapeB[5][1],ShapeB[5][2],0x15C,ShapeB[5][3],SetTo,"X",CV[22][2],0x15C,1,0),
			SetCtrig1X(ShapeB[1][1],ShapeB[1][2],0x158,ShapeB[1][3],SetTo,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x198,ShapeB[1][3],SetTo,"X",CV[23][2],0x15C,1,0),
			SetCtrigX(ShapeB[1][1],ShapeB[1][2],0x1D8,ShapeB[1][3],SetTo,"X",CV[24][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[21],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
				NVar(CV[22],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetNVar(CV[22],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBXORCall1,0x0,0,0);
				SetCtrigX("X",FCBXORCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBXORCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBXORCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_RemoveStack(Priority,SizeX,SizeY,Shape,RetShape)
	FCBRMSTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)


	CMov(PlayerID,CV[11],SizeX)
	CMov(PlayerID,CV[12],SizeY)
	if Priority == nil then
		CMov(PlayerID,CV[14],0)
	else
		CMov(PlayerID,CV[14],Priority)
	end 


	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,RetShape),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,RetShape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,RetShape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,RetShape,SetTo,"X",CA[7],0x0,0,RetShape+1),
		})
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,RetShape[1][1],RetShape[1][2],0x0,0,0);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x4,0,SetTo,RetShape[5][1],RetShape[5][2],0x0,0,0);
			SetCtrigX(RetShape[6][1],RetShape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(RetShape[5][1],RetShape[5][2],0x15C,RetShape[5][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBRMSTCall1,0x0,0,0);
				SetCtrigX("X",FCBRMSTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBRMSTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBRMSTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[3])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[3][1],CV[3][2],CV[3][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[3][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[3][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[3][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_GetXmax(Shape,Output)
	FCBXMAXCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[3],FArr(FX[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBXMAXCall1,0x0,0,0);
				SetCtrigX("X",FCBXMAXCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBXMAXCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBXMAXCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	CMov(PlayerID,Output,CV[6])

	RecoverCp(PlayerID)
end

function CB_GetXmin(Shape,Output)
	FCBXMINCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[3],FArr(FX[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBXMINCall1,0x0,0,0);
				SetCtrigX("X",FCBXMINCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBXMINCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBXMINCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	CMov(PlayerID,Output,CV[6])

	RecoverCp(PlayerID)
end

function CB_GetXCntr(Shape,Output,maxOutput,minOutput)
	FCBXCNTRCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[3],FArr(FX[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBXCNTRCall1,0x0,0,0);
				SetCtrigX("X",FCBXCNTRCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBXCNTRCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBXCNTRCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	CMov(PlayerID,Output,CV[7])
	if maxOutput ~= nil then
		CMov(PlayerID,maxOutput,CV[4])
	end
	if minOutput ~= nil then
		CMov(PlayerID,minOutput,CV[6])
	end

	RecoverCp(PlayerID)
end

function CB_GetYmax(Shape,Output)
	FCBXMAXCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[3],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBXMAXCall1,0x0,0,0);
				SetCtrigX("X",FCBXMAXCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBXMAXCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBXMAXCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	CMov(PlayerID,Output,CV[6])

	RecoverCp(PlayerID)
end

function CB_GetYmin(Shape,Output)
	FCBXMINCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[3],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBXMINCall1,0x0,0,0);
				SetCtrigX("X",FCBXMINCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBXMINCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBXMINCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	CMov(PlayerID,Output,CV[6])

	RecoverCp(PlayerID)
end

function CB_GetYCntr(Shape,Output,maxOutput,minOutput)
	FCBXCNTRCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[3],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[3][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				SetNVar(CV[2],Subtract,1);
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBXCNTRCall1,0x0,0,0);
				SetCtrigX("X",FCBXCNTRCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBXCNTRCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBXCNTRCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	CMov(PlayerID,Output,CV[7])
	if maxOutput ~= nil then
		CMov(PlayerID,maxOutput,CV[4])
	end
	if minOutput ~= nil then
		CMov(PlayerID,minOutput,CV[6])
	end

	RecoverCp(PlayerID)
end

function CB_GetXLoc(Index,Shape,Output)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Index)
	if type(Shape) == "number" then
		TMem(PlayerID,CV[2],FArr(FX[Shape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[1][1],Shape[1][2],Shape[1][3]);
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,0);
		})
	end
	f_SHRead(PlayerID,_Add(CV[2],CV[1]),Output) -- XLoc
end

function CB_GetYLoc(Index,Shape,Output)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Index)
	if type(Shape) == "number" then
		TMem(PlayerID,CV[2],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[1][1],Shape[1][2],Shape[1][3]);
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[2][2],0x15C,1,0),
		})
	end
	f_SHRead(PlayerID,_Add(CV[2],CV[1]),Output) -- YLoc
end

function CB_GetNumber(Shape,Output)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		if type(Output) == "number" then
	 	DoActionsX(PlayerID,{
			SetCtrig1X("X",CA[7],0x158,Shape,SetTo,EPD(Output)),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
	 	elseif Output[4] == "V" then
	 	DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,Output[1],Output[2],0x15C,1,Output[3]),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		else
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,Output[1],Output[2],Output[3],1,Output[4]),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		end
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
	else
		if type(Output) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);
			SetCtrig1X(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,EPD(Output)),
		})
	 	elseif Output[4] == "V" then
	 	DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);
			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,Output[1],Output[2],0x15C,1,Output[3]),
		})
		else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);
			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,Output[1],Output[2],Output[3],1,Output[4]),
		})
		end
	end
end


function CB_InitVShapeX(Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum

	local Temp = CreateSVar(3,PlayerID)[1]
	local Temp2 = CreateSVar(4,PlayerID)[1]
	local Temp3 = CreateSVar(3,PlayerID)[1]
	local Ret = {{Temp[1],Temp[2],0,"V"},CreateVar(PlayerID),CreateWar(PlayerID),CreateVar(PlayerID),{Temp2[1],Temp2[2],0,"V"},{Temp3[1],Temp3[2],0,"V"}}
	local FXData = FArr(FX[Shape],0)
	local FYData = FArr(FY[Shape],0)
	local FNData = FArr(FN[Shape],0)
	DoActionsX(PlayerID,{ -- Recover
		SetCtrig1X("X",Ret[1][2],0x15C,0,SetTo,Num[Shape]);
		SetCtrig1X("X",Ret[1][2],0x160,0,SetTo,Add*16777216,0xFF000000);
		SetCtrigX("X",Ret[1][2],0x19C,0,SetTo,FXData[1],FXData[2],FXData[3],1,FXData[4]); 
		SetCtrigX("X",Ret[1][2],0x1DC,0,SetTo,FYData[1],FYData[2],FYData[3],1,FYData[4]); 
		SetCtrigX("X",Ret[2][2],0x158,0,SetTo,"X",CA[7],0x15C,1,Shape);
		SetCtrigX("X",Ret[4][2],0x15C,0,SetTo,"X",CA[7],0x15C,1,Shape);

		SetCtrigX("X",Ret[3][2],0x15C,0,SetTo,FNData[1],FNData[2],FNData[3],1,FNData[4]);
		SetCtrig1X("X",Ret[3][2],0x19C,0,SetTo,TNum[Shape]);
		SetCtrig1X("X",Ret[3][2],0x1A0,0,SetTo,Add*16777216,0xFF000000);

		SetCtrigX("X",Ret[5][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape);
		SetCtrigX("X",Ret[5][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[5][2],0x19C,0,SetTo,0x200,0x200);
		SetCtrigX("X",Ret[5][2],0x1D8,0,SetTo,"X",Ret[5][2],0x4,1,0); SetCtrigX("X",Ret[5][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape);
		SetCtrigX("X",Ret[5][2],0x218,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[5][2],0x21C,0,SetTo,"X",Ret[6][2],0x0,0,0);

		SetCtrigX("X",Ret[6][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape); SetCtrigX("X",Ret[6][2],0x15C,0,SetTo,"X",CA[10],0x15C,1,0);
		SetCtrigX("X",Ret[6][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[6][2],0x19C,0,SetTo,0x000,0x200);
		SetCtrigX("X",Ret[6][2],0x1D8,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[6][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape+1);
	})

	return Ret
end

function CB_VShapeX(VShapeX,Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	local Ret = VShapeX

	local FXData = FArr(FX[Shape],0)
	local FYData = FArr(FY[Shape],0)
	local FNData = FArr(FN[Shape],0)
	DoActionsX(PlayerID,{ -- Recover
		SetCtrig1X("X",Ret[1][2],0x15C,0,SetTo,Num[Shape]);
		SetCtrig1X("X",Ret[1][2],0x160,0,SetTo,Add*16777216,0xFF000000);
		SetCtrigX("X",Ret[1][2],0x19C,0,SetTo,FXData[1],FXData[2],FXData[3],1,FXData[4]); 
		SetCtrigX("X",Ret[1][2],0x1DC,0,SetTo,FYData[1],FYData[2],FYData[3],1,FYData[4]); 
		SetCtrigX("X",Ret[2][2],0x158,0,SetTo,"X",CA[7],0x15C,1,Shape);
		SetCtrigX("X",Ret[4][2],0x15C,0,SetTo,"X",CA[7],0x15C,1,Shape);

		SetCtrigX("X",Ret[3][2],0x15C,0,SetTo,FNData[1],FNData[2],FNData[3],1,FNData[4]);
		SetCtrig1X("X",Ret[3][2],0x19C,0,SetTo,TNum[Shape]);
		SetCtrig1X("X",Ret[3][2],0x1A0,0,SetTo,Add*16777216,0xFF000000);

		SetCtrigX("X",Ret[5][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape);
		SetCtrigX("X",Ret[5][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[5][2],0x19C,0,SetTo,0x200,0x200);
		SetCtrigX("X",Ret[5][2],0x1D8,0,SetTo,"X",Ret[5][2],0x4,1,0); SetCtrigX("X",Ret[5][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape);
		SetCtrigX("X",Ret[5][2],0x218,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[5][2],0x21C,0,SetTo,"X",Ret[6][2],0x0,0,0);

		SetCtrigX("X",Ret[6][2],0x158,0,SetTo,"X",CA[7],0x158,1,Shape); SetCtrigX("X",Ret[6][2],0x15C,0,SetTo,"X",CA[10],0x15C,1,0);
		SetCtrigX("X",Ret[6][2],0x198,0,SetTo,"X",CA[7],0x2C,1,Shape); SetCtrig1X("X",Ret[6][2],0x19C,0,SetTo,0x000,0x200);
		SetCtrigX("X",Ret[6][2],0x1D8,0,SetTo,"X",CA[7],0x4,1,Shape); SetCtrigX("X",Ret[6][2],0x1DC,0,SetTo,"X",CA[7],0x0,0,Shape+1);
	})

end

function CB_TGetNumber(Shape,Output)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		f_SHRead(PlayerID,FArr(FN[Shape],0),Output) -- TNum
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,0),
		})
		f_SHRead(PlayerID,CV[2],Output) -- TNum
	end
end

function CB_TGetLoc(Index,Shape,Output)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Index)

	if type(Shape) == "number" then
		f_SHRead(PlayerID,_TMem(FArr(FN[Shape],CV[1])),Output) -- TLoc
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,0),
		})
		f_SHRead(PlayerID,_Add(CV[1],CV[2]),Output) -- TNum
	end
end

function CB_TSetNumber(Number,Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Number)
	if type(Shape) == "number" then
		CWrite(PlayerID,_TMem(FArr(FN[Shape],0)),CV[1]) -- L
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,0),
		})
		CWrite(PlayerID,CV[2],CV[1]) -- L
	end
end

function CB_TSet(Index,LoopMax,Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[1],Index)
	CMov(PlayerID,CV[2],LoopMax)
	
	if type(Shape) == "number" then
		CWrite(PlayerID,_TMem(FArr(FN[Shape],CV[1])),CV[2]) -- L
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrig1X(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,0),
		})
		CWrite(PlayerID,_Add(CV[3],CV[1]),CV[2]) -- L
	end
end

function CB_TAdd(LoopMax,Shape)
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		f_SHRead(PlayerID,FArr(FN[Shape],0),CV[1]) -- TNum
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[3][2],0x15C,1,0),
			SetCtrigX(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
		})
		f_SHRead(PlayerID,CV[3],CV[1]) -- TNum
	end

	CMov(PlayerID,CV[2],LoopMax)

	if type(Shape) == "number" then
		CIf(PlayerID,{TTNVar(CV[1],iAtMost,TNum[Shape]-1)},SetMemX(FArr(FN[Shape],0),Add,1))	
			CWrite(PlayerID,_TMem(FArr(FN[Shape],CV[1])),CV[2]) -- X
		CIfEnd()
	else
		CIf(PlayerID,{TTNVar(CV[1],iAtMost,CV[4])},{TSetMemory(CV[3],Add,1)})	
			CWrite(PlayerID,_Add(CV[3],CV[1]),CV[2]) -- X
		CIfEnd()
	end
end

function CB_TDelete(Index,Shape)
	FCBTDELCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[3],Index)

	if type(Shape) == "number" then
		f_SHRead(PlayerID,FArr(FN[Shape],0),CV[1]) -- TNum
		TMem(PlayerID,CV[2],FArr(FN[Shape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,0),
		})
		f_SHRead(PlayerID,CV[2],CV[1]) -- TNum
	end	

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[1],AtLeast,1);
			},
			actions = {
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBTDELCall1,0x0,0,0);
				SetCtrigX("X",FCBTDELCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBTDELCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBTDELCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(Shape) == "number" then
		CWrite(PlayerID,_TMem(FArr(FN[Shape],0)),CV[1]) --
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,0),
		})
		CWrite(PlayerID,CV[2],CV[1]) --
	end
end

function CB_TCopy(Shape,RetShape)
	FCBTCPYCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	STPopTrigArr(PlayerID)

	if type(Shape) == "number" then
		f_SHRead(PlayerID,FArr(FN[Shape],0),CV[2]) -- TNum
		TMem(PlayerID,CV[5],FArr(FN[Shape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(Shape[3][1],Shape[3][2],Shape[3][3]);
			SetCtrigX(Shape[3][1],Shape[3][2],0x158,Shape[3][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrig1X(Shape[3][1],Shape[3][2],0x198,Shape[3][3],SetTo,0),
		})
		f_SHRead(PlayerID,CV[5],CV[2]) -- TNum
	end	

	local RetAct = {}
	if type(RetShape) == "number" then
		TMem(PlayerID,CV[6],FArr(FN[RetShape],0))
		table.insert(RetAct,SetNVar(CV[4],SetTo,TNum[RetShape]-1))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[3][1],RetShape[3][2],RetShape[3][3]);
			SetCtrigX(RetShape[3][1],RetShape[3][2],0x158,RetShape[3][3],SetTo,"X",CV[6][2],0x15C,1,0),
			SetCtrigX(RetShape[3][1],RetShape[3][2],0x198,RetShape[3][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
		})
	end	

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,1);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,1);
			},
			actions = {
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBTCPYCall1,0x0,0,0);
				SetCtrigX("X",FCBTCPYCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBTCPYCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBTCPYCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CWrite(PlayerID,_TMem(FArr(FN[RetShape],0)),CV[1]) --
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[3][1],RetShape[3][2],RetShape[3][3]);
			SetCtrigX(RetShape[3][1],RetShape[3][2],0x158,RetShape[3][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(RetShape[3][1],RetShape[3][2],0x198,RetShape[3][3],SetTo,0),
		})
		CWrite(PlayerID,CV[2],CV[1]) --
	end
end

function CB_Sort(Sfunc,Direction,Shape,RetShape)
	FCBSORTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Sort - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Direction)
	DoActionsX(PlayerID,{SetCtrigX("X",CV[12][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2],0x0,0,1),
	SetCtrigX("X",CV[13][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2]+1,0x4,1,0)})

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,2);
			},
			actions = {
				SetNVar(CV[20],SetTo,0); -- SortXY/RA
				SetNVar(CV[24],SetTo,0); -- Sort
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSORTCall1,0x0,0,0);
				SetCtrigX("X",FCBSORTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSORTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSORTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_SortI(Sfunc,Direction,Shape,RetShape)
	FCBSORTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_SortI - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Direction)
	DoActionsX(PlayerID,{SetCtrigX("X",CV[12][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2],0x0,0,1),
	SetCtrigX("X",CV[13][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2]+1,0x4,1,0)})

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,2);
			},
			actions = {
				SetNVar(CV[20],SetTo,1); -- SortI
				SetNVar(CV[24],SetTo,0); -- Sort
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSORTCall1,0x0,0,0);
				SetCtrigX("X",FCBSORTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSORTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSORTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_NSort(Func,Step,Sfunc,Direction,Shape,RetShape)
	FCBSORTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_NSort - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Direction)
	DoActionsX(PlayerID,{SetCtrigX("X",CV[12][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2],0x0,0,1),
	SetCtrigX("X",CV[13][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2]+1,0x4,1,0)})
	CMov(PlayerID,CV[21],Step)
	if Func ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[22][2],0x15C,0,SetTo,Func[1],Func[2],0x0,0,1),
		SetCtrigX("X",CV[23][2],0x15C,0,SetTo,Func[1],Func[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[22],SetTo,0)})
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		table.insert(RetAct,SetNVar(CV[32],SetTo,TNum[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
		TMem(PlayerID,CV[31],FArr(FN[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(RetShape[1][1],RetShape[1][2],RetShape[1][3],RetShape[3][1],RetShape[3][2],RetShape[3][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),

			SetCtrigX(RetShape[3][1],RetShape[3][2],0x158,RetShape[3][3],SetTo,"X",CV[31][2],0x15C,1,0),
			SetCtrigX(RetShape[3][1],RetShape[3][2],0x198,RetShape[3][3],SetTo,"X",CV[32][2],0x15C,1,0),
			SetNVar(CV[32],SetTo,0);
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,2);
			},
			actions = {
				SetNVar(CV[20],SetTo,0); -- SortXY/RA
				SetNVar(CV[24],SetTo,1); -- NSort
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSORTCall1,0x0,0,0);
				SetCtrigX("X",FCBSORTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSORTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSORTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_NSortI(Func,Step,Sfunc,Direction,Shape,RetShape)
	FCBSORTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_NSortI - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Direction)
	DoActionsX(PlayerID,{SetCtrigX("X",CV[12][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2],0x0,0,1),
	SetCtrigX("X",CV[13][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2]+1,0x4,1,0)})
	CMov(PlayerID,CV[21],Step)
	if Func ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[22][2],0x15C,0,SetTo,Func[1],Func[2],0x0,0,1),
		SetCtrigX("X",CV[23][2],0x15C,0,SetTo,Func[1],Func[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[22],SetTo,0)})
	end

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		table.insert(RetAct,SetNVar(CV[32],SetTo,TNum[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
		TMem(PlayerID,CV[31],FArr(FN[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(RetShape[1][1],RetShape[1][2],RetShape[1][3],RetShape[3][1],RetShape[3][2],RetShape[3][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),

			SetCtrigX(RetShape[3][1],RetShape[3][2],0x158,RetShape[3][3],SetTo,"X",CV[31][2],0x15C,1,0),
			SetCtrigX(RetShape[3][1],RetShape[3][2],0x198,RetShape[3][3],SetTo,"X",CV[32][2],0x15C,1,0),
			SetNVar(CV[32],SetTo,0);
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,2);
			},
			actions = {
				SetNVar(CV[20],SetTo,1); -- SortI
				SetNVar(CV[24],SetTo,1); -- NSort
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSORTCall1,0x0,0,0);
				SetCtrigX("X",FCBSORTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSORTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSORTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_TSort(Func,Step,Void,Sfunc,Direction,Shape,RetShape)
	FCBSORTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_TSort - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Direction)
	DoActionsX(PlayerID,{SetCtrigX("X",CV[12][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2],0x0,0,1),
	SetCtrigX("X",CV[13][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2]+1,0x4,1,0)})
	CMov(PlayerID,CV[21],Step)
	if Func ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[22][2],0x15C,0,SetTo,Func[1],Func[2],0x0,0,1),
		SetCtrigX("X",CV[23][2],0x15C,0,SetTo,Func[1],Func[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[22],SetTo,0)})
	end
	CMov(PlayerID,CV[35],Void)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		table.insert(RetAct,SetNVar(CV[32],SetTo,TNum[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
		TMem(PlayerID,CV[31],FArr(FN[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(RetShape[1][1],RetShape[1][2],RetShape[1][3],RetShape[3][1],RetShape[3][2],RetShape[3][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),

			SetCtrigX(RetShape[3][1],RetShape[3][2],0x158,RetShape[3][3],SetTo,"X",CV[31][2],0x15C,1,0),
			SetCtrigX(RetShape[3][1],RetShape[3][2],0x198,RetShape[3][3],SetTo,"X",CV[32][2],0x15C,1,0),
			SetNVar(CV[32],SetTo,0);
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,2);
			},
			actions = {
				SetNVar(CV[20],SetTo,0); -- SortXY/RA
				SetNVar(CV[24],SetTo,2); -- TSort
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSORTCall1,0x0,0,0);
				SetCtrigX("X",FCBSORTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSORTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSORTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_TSortI(Func,Step,Void,Sfunc,Direction,Shape,RetShape)
	FCBSORTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_TSort - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	local FN = CBPlotFArrN
	local TNum = CBPlotTNum
	STPopTrigArr(PlayerID)

	CMov(PlayerID,CV[11],Direction)
	DoActionsX(PlayerID,{SetCtrigX("X",CV[12][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2],0x0,0,1),
	SetCtrigX("X",CV[13][2],0x15C,0,SetTo,Sfunc[1],Sfunc[2]+1,0x4,1,0)})
	CMov(PlayerID,CV[21],Step)
	if Func ~= nil then
		DoActionsX(PlayerID,{SetCtrigX("X",CV[22][2],0x15C,0,SetTo,Func[1],Func[2],0x0,0,1),
		SetCtrigX("X",CV[23][2],0x15C,0,SetTo,Func[1],Func[2]+1,0x4,1,0)})
	else
		DoActionsX(PlayerID,{SetNVar(CV[22],SetTo,0)})
	end
	CMov(PlayerID,CV[35],Void)

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		table.insert(RetAct,SetNVar(CV[32],SetTo,TNum[RetShape]))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
		TMem(PlayerID,CV[31],FArr(FN[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(RetShape[1][1],RetShape[1][2],RetShape[1][3],RetShape[3][1],RetShape[3][2],RetShape[3][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),

			SetCtrigX(RetShape[3][1],RetShape[3][2],0x158,RetShape[3][3],SetTo,"X",CV[31][2],0x15C,1,0),
			SetCtrigX(RetShape[3][1],RetShape[3][2],0x198,RetShape[3][3],SetTo,"X",CV[32][2],0x15C,1,0),
			SetNVar(CV[32],SetTo,0);
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[2],AtLeast,2);
			},
			actions = {
				SetNVar(CV[20],SetTo,1); -- SortI
				SetNVar(CV[24],SetTo,2); -- TSort
				SetNVar(CV[2],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSORTCall1,0x0,0,0);
				SetCtrigX("X",FCBSORTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSORTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSORTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CB_Split(Preset,Looper,Overwrite,Shape,RetShape)
	FCBSPLTCheck = 1
	local CV
	if CBPlotTempArr == 0 then
		Need_Include_CBPaint()
	else
		CV = CBPlotTempArr
	end

	-- CB_Split - CV[1] = Shape Loop / CV[2] = Shape Limit / CV[3] = RetShape Loop / CV[4] = RetShape Limit 
	-- CV[5] : FArrX / CV[6] : FArrY / CV[7] : RFArrX / CV[8] : RFArrY / CV[9] : X / CV[10] : Y / CV[11] : +X / CV[12] : +Y  
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FX = CBPlotFArrX
	local FY = CBPlotFArrY
	local Num = CBPlotNum
	STPopTrigArr(PlayerID)

	if Overwrite ~= nil then
		CMov(PlayerID,CV[11],Overwrite)
	else
		CMov(PlayerID,CV[11],0)
	end
	if Looper ~= nil then
		CMov(PlayerID,CV[12],Looper)
	else
		CMov(PlayerID,CV[12],0)
	end
	CMov(PlayerID,CV[13],Preset[1]) -- N
	DoActionsX(PlayerID,{SetCtrigX("X",CV[14][2],0x15C,0,SetTo,Preset[2][1],Preset[2][2],0x0,0,1),
	SetCtrigX("X",CV[15][2],0x15C,0,SetTo,Preset[2][1],Preset[2][2]+1,0x4,1,0)})

	if type(Shape) == "number" then
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0200,0x0200),
			SetCtrigX("X","X",0x4,0,SetTo,"X",CA[7],0x0,0,Shape),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X","X",0x0,0,1),
		})
		DoActionsX(PlayerID,{
			SetCtrigX("X",CA[7],0x158,Shape,SetTo,"X",CA[10],0x15C,1,0),
			SetCtrig1X("X",CA[7],0x2C,Shape,SetTo,0x0000,0x0200),
			SetCtrigX("X",CA[7],0x4,Shape,SetTo,"X",CA[7],0x0,0,Shape+1),
		})
		TMem(PlayerID,CV[5],FArr(FX[Shape],0))
		TMem(PlayerID,CV[6],FArr(FY[Shape],0))
	else
		DoActionsX(PlayerID,{
			SetCtrigX("X","X",0x4,0,SetTo,Shape[1][1],Shape[1][2],0x0,0,0);
			SetCtrigX(Shape[1][1],Shape[1][2],0x4,0,SetTo,Shape[5][1],Shape[5][2],0x0,0,0);
			SetCtrigX(Shape[6][1],Shape[6][2],0x4,0,SetTo,"X","X",0x0,0,1);

			SetCtrigX(Shape[5][1],Shape[5][2],0x15C,Shape[5][3],SetTo,"X",CV[2][2],0x15C,1,0),
			SetCtrig1X(Shape[1][1],Shape[1][2],0x158,Shape[1][3],SetTo,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x198,Shape[1][3],SetTo,"X",CV[5][2],0x15C,1,0),
			SetCtrigX(Shape[1][1],Shape[1][2],0x1D8,Shape[1][3],SetTo,"X",CV[6][2],0x15C,1,0),
		})
	end

	local RetAct = {}
	if type(RetShape) == "number" then
		table.insert(RetAct,SetNVar(CV[4],SetTo,Num[RetShape]-1))
		TMem(PlayerID,CV[7],FArr(FX[RetShape],0))
		TMem(PlayerID,CV[8],FArr(FY[RetShape],0))
	else
		DoActionsX(PlayerID,{
			CallLabelAlways(RetShape[1][1],RetShape[1][2],RetShape[1][3]);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x158,RetShape[1][3],SetTo,"X",CV[4][2],0x15C,1,0),
			SetNVar(CV[4],SetTo,-1);
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x198,RetShape[1][3],SetTo,"X",CV[7][2],0x15C,1,0),
			SetCtrigX(RetShape[1][1],RetShape[1][2],0x1D8,RetShape[1][3],SetTo,"X",CV[8][2],0x15C,1,0),
		})
	end

	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
			},
			actions = {
				SetNVar(CV[1],SetTo,0);
				SetNVar(CV[3],SetTo,0);
			},
			flag = {Preserved}
		}

	-- Call f_CBMove
	Trigger {
			players = {PlayerID},
			conditions = {
				Label(0);
				NVar(CV[13],AtLeast,1);
			},
			actions = {
				SetNVar(CV[13],Subtract,1);
				RetAct;
				SetCtrigX("X","X",0x4,0,SetTo,"X",FCBSPLTCall1,0x0,0,0);
				SetCtrigX("X",FCBSPLTCall2,0x4,0,SetTo,"X","X",0x0,0,1);
				SetCtrigX("X",FCBSPLTCall2,0x158,0,SetTo,"X","X",0x4,1,0);
				SetCtrigX("X",FCBSPLTCall2,0x15C,0,SetTo,"X","X",0x0,0,1);
			},
			flag = {Preserved}
		}

	if type(RetShape) == "number" then
		CMov(PlayerID,Mem("X",CA[7],0x15C,RetShape),CV[1])
	else
		DoActionsX(PlayerID,{
			CallLabelAlways2(CV[1][1],CV[1][2],CV[1][3],RetShape[2][1],RetShape[2][2],RetShape[2][3]);
			SetCtrigX("X",CV[1][2],0x158,0,SetTo,RetShape[2][1],RetShape[2][2],0x15C,1,RetShape[2][3]),
			SetCtrig1X("X",CV[1][2],0x148,0,SetTo,0xFFFFFFFF);
			SetCtrig1X("X",CV[1][2],0x160,0,SetTo,SetTo*16777216,0xFF000000);
		})
	end
end

function CSMakeSpiral(Point,Magnificent,Coefficient,Radius,Angle,Number,Hollow) -- r = M*exp(C(Θ-A))
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
	local TA, TR, pA, pB, pC, pX
	pA = Magnificent
	pB = Coefficient
	pX = math.abs(pB/(pA*math.sqrt(1+pB*pB)))
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
			   	Temp1 = ((Level-1) * Radius) -- R -> l
			   	Temp2 = math.rad(Angle+(360*Case)/Point) -- A -> A

			   	pC = pB*(math.rad(Angle)+Temp2)
			   	TA = (math.log(Temp1*pX)+pC)/pB
			   	TR = pA*math.exp(pB*(TA-math.rad(Angle)-Temp2))

			   	LX = TR * math.cos(TA)
			   	LY = TR * math.sin(TA)
			   		
			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end

			Main = Main + 1
			Case = Case + 1
		end
	end 

	return Shape	
end

function CSMakeSpiralX(Point,Magnificent,Coefficient,Radius,Angle,Number,Hollow) -- r = M*exp(C(Θ-A))
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
	local TA, TR, pA, pB, pC, pX
	pA = Magnificent
	pB = Coefficient
	pX = math.abs(pB/(pA*math.sqrt(1+pB*pB)))
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

			   	pC = pB*(math.rad(Angle)+Temp2)
			   	TA = (math.log(Temp1*pX)+pC)/pB
			   	TR = pA*math.exp(pB*(TA-math.rad(Angle)-Temp2))

			   	LX = TR * math.cos(TA)
			   	LY = TR * math.sin(TA)
			   		
			   	table.insert(Shape,{LX,LY})
			   	Remain = Remain - 1
			end

			Main = Main + 1
			Case = Case + 1
		end
	end 

	return Shape	
end

function CSMakeGraphX1(funcY,Start,Direction,Step,Number)
	local Shape = {Number}
	local NX, NY
	if Direction == nil then
		Direction = 0
	end
	if Step <= 0 then
		CS_InputError()
	end

	NX = Start
	NY = _G[funcY](NX)
	table.insert(Shape,{NX,NY}) -- 1st Point

	local TX, TY
	for i = 1, Number-1 do
		if Direction ~= 0 then
			TX = NX-i*Step
		else
			TX = NX+i*Step
		end
		TY = _G[funcY](TX)
		table.insert(Shape,{TX,TY})
	end

	return Shape
end

function CSMakeGraphY1(funcX,Start,Direction,Step,Number)
	local Shape = {Number}
	local NX, NY
	if Direction == nil then
		Direction = 0
	end
	if Step <= 0 then
		CS_InputError()
	end

	NY = Start
	NX = _G[funcX](NY)
	table.insert(Shape,{NX,NY}) -- 1st Point

	local TX, TY
	for i = 1, Number-1 do
		if Direction ~= 0 then
			TY = NY-i*Step
		else
			TY = NY+i*Step
		end
		TX = _G[funcX](TY)
		table.insert(Shape,{TX,TY})
	end

	return Shape
end

function CSMakeGraphR1(funcA,Start,Direction,Step,Number)
	local Shape = {Number}
	local NR, NA
	if Direction == nil then
		Direction = 0
	end
	if Step <= 0 then
		CS_InputError()
	end

	NR = Start
	NA = _G[funcA](NR)
	table.insert(Shape,{NR*math.cos(NA),NR*math.sin(NA)}) -- 1st Point

	local TR, TA
	for i = 1, Number-1 do
		if Direction ~= 0 then
			TR = NR-i*Step
		else
			TR = NR+i*Step
		end
		TA = _G[funcA](TR)
		table.insert(Shape,{TR*math.cos(TA),TR*math.sin(TA)})
	end

	return Shape
end

function CSMakeGraphA1(funcR,Start,Direction,Step,Number)
	local Shape = {Number}
	local NR, NA
	if Direction == nil then
		Direction = 0
	end
	if Step <= 0 then
		CS_InputError()
	end

	NA = Start
	NR = _G[funcR](NA)
	table.insert(Shape,{NR*math.cos(NA),NR*math.sin(NA)}) -- 1st Point

	local TR, TA
	for i = 1, Number-1 do
		if Direction ~= 0 then
			TA = NA-i*Step
		else
			TA = NA+i*Step
		end
		TR = _G[funcR](TA)
		table.insert(Shape,{TR*math.cos(TA),TR*math.sin(TA)})
	end

	return Shape
end

function CSMakeGraphT1(Parafunc,Start,Direction,Step,Number)
	local Shape = {Number}
	local NX, NY, NT
	if Direction == nil then
		Direction = 0
	end
	if Step <= 0 then
		CS_InputError()
	end

	NT = Start
	NX, NY = _G[Parafunc](NT)
	table.insert(Shape,{NX,NY}) -- 1st Point

	local TX, TY, TT
	for i = 1, Number-1 do
		if Direction ~= 0 then
			TT = NT-i*Step
		else
			TT = NT+i*Step
		end
		TX, TY = _G[Parafunc](TT)
		table.insert(Shape,{TX,TY})
	end

	return Shape
end

function CSMakeGraphX2(funcY,Start,Direction,StepLength,Partition,MaxError,Number,Loop1,Loop2,Alert)
	local Alert1, Alert2
	if Alert == nil or Alert == 3 then
		Alert1 = 1
		Alert2 = 1
	elseif Alert == 1 then
		Alert1 = 1
		Alert2 = 0
	elseif Alert == 2 then
		Alert1 = 0
		Alert2 = 1
	else 
		Alert1 = 0
		Alert2 = 0
	end

	local Shape = {Number}
	local NX, NY
	if Direction == nil then
		Direction = 0
	end
	if StepLength <= 0 then
		CS_InputError()
	end
	if Loop1 == nil then Loop1 = 24 end
	if Loop2 == nil then Loop2 = 12 end
	local StepLength2 = StepLength^2
	NX = Start
	NY = _G[funcY](NX)
	table.insert(Shape,{NX,NY}) -- 1st Point
	local TX, TY, dx, sx, CX, CY, Count, ER, px, Length, ER2, py1, py2
	if type(MaxError) == "number" then
		ER = math.abs(MaxError)
		ER2 = ER^2
	else
		ER = math.abs(MaxError[2])
		ER2 = math.abs(MaxError[1])
	end
	for i = 1, Number-1 do
		dx = StepLength
		sx = StepLength
		Count = 0
		while true do
			if Direction == 0 then -- forward
				CX = NX + dx
			else
				CX = NX - dx
			end
			CY = _G[funcY](CX)
			Length = (CX-NX)^2+(CY-NY)^2
			if Alert1 == 1 and Count >= Loop1 then Loop1_LimitExceeded() end
			if math.abs(Length-StepLength2) < ER2 or Count >= Loop1 then break end
			if Length>=StepLength2 then 
				sx = sx/2
				dx = dx - sx
			else
				sx = sx/2
				dx = dx + sx
			end
			Count = Count + 1
		end

		-- 2nd Point (√((CX-NX)^2+(CY-NY)^2) ≒ Length)
		if Direction == 0 then -- forward
			dx = CX-NX
			sx = CX-NX
		else
			dx = NX-CX
			sx = NX-CX
		end
		
		Count = 0
		while true do
			Length = 0
			local k = dx/Partition
			if Direction == 0 then -- forward
				TX = NX + dx
				for n = 1, Partition do
					local py1 = _G[funcY]((n-1)*k+NX)
					local py2 = _G[funcY]((n)*k+NX)
					px = math.sqrt(k^2+(py2-py1)^2)
					Length = Length+px
				end
			else
				TX = NX - dx
				for n = 1, Partition do
					local py1 = _G[funcY](NX-(n-1)*k)
					local py2 = _G[funcY](NX-(n)*k)
					px = math.sqrt(k^2+(py2-py1)^2)
					Length = Length+px
				end
			end
			if Alert2 == 1 and Count >= Loop2 then Loop2_LimitExceeded() end
			if math.abs(Length-StepLength) < ER or Count >= Loop2 then break end
			if Length>=StepLength then 
				sx = sx/2
				dx = dx - sx
			else
				sx = sx/2
				dx = dx + sx
			end
			Count = Count + 1
		end

		-- 3rd Point ∑Part ≒ Length
		TY = _G[funcY](TX)
		NX = TX
		NY = TY
		table.insert(Shape,{NX,NY})
	end
	return Shape
end

function CSMakeGraphY2(funcX,Start,Direction,StepLength,Partition,MaxError,Number,Loop1,Loop2,Alert)
	local Alert1, Alert2
	if Alert == nil or Alert == 3 then
		Alert1 = 1
		Alert2 = 1
	elseif Alert == 1 then
		Alert1 = 1
		Alert2 = 0
	elseif Alert == 2 then
		Alert1 = 0
		Alert2 = 1
	else 
		Alert1 = 0
		Alert2 = 0
	end

	local Shape = {Number}
	local NY, NX
	if Direction == nil then
		Direction = 0
	end
	if StepLength <= 0 then
		CS_InputError()
	end
	if Loop1 == nil then Loop1 = 24 end
	if Loop2 == nil then Loop2 = 12 end
	local StepLength2 = StepLength^2
	NY = Start
	NX = _G[funcX](NY)
	table.insert(Shape,{NX,NY}) -- 1st Point
	local TY, TX, dy, sy, CY, CX, Count, ER, py, Length, ER2, px1, px2
	if type(MaxError) == "number" then
		ER = math.abs(MaxError)
		ER2 = ER^2
	else
		ER = math.abs(MaxError[2])
		ER2 = math.abs(MaxError[1])
	end
	for i = 1, Number-1 do
		dy = StepLength
		sy = StepLength
		Count = 0
		while true do
			if Direction == 0 then -- forward
				CY = NY + dy
			else
				CY = NY - dy
			end
			CX = _G[funcX](CY)
			Length = (CY-NY)^2+(CX-NX)^2
			if Alert1 == 1 and Count >= Loop1 then Loop1_LimitExceeded() end
			if math.abs(Length-StepLength2) < ER2 or Count >= Loop1 then break end
			if Length>=StepLength2 then 
				sy = sy/2
				dy = dy - sy
			else
				sy = sy/2
				dy = dy + sy
			end
			Count = Count + 1
		end

		-- 2nd Point (√((CY-NY)^2+(CX-NX)^2) ≒ Length)
		if Direction == 0 then -- forward
			dy = CY-NY
			sy = CY-NY
		else
			dy = NY-CY
			sy = NY-CY
		end
		
		Count = 0
		while true do
			Length = 0
			local k = dy/Partition
			if Direction == 0 then -- forward
				TY = NY + dy
				for n = 1, Partition do
					local px1 = _G[funcX]((n-1)*k+NY)
					local px2 = _G[funcX]((n)*k+NY)
					py = math.sqrt(k^2+(px2-px1)^2)
					Length = Length+py
				end
			else
				TY = NY - dy
				for n = 1, Partition do
					local px1 = _G[funcX](NY-(n-1)*k)
					local px2 = _G[funcX](NY-(n)*k)
					py = math.sqrt(k^2+(px2-px1)^2)
					Length = Length+py
				end
			end
			if Alert2 == 1 and Count >= Loop2 then Loop2_LimitExceeded() end
			if math.abs(Length-StepLength) < ER or Count >= Loop2 then break end
			if Length>=StepLength then 
				sy = sy/2
				dy = dy - sy
			else
				sy = sy/2
				dy = dy + sy
			end
			Count = Count + 1
		end

		-- 3rd Point ∑Part ≒ Length
		TX = _G[funcX](TY)
		NY = TY
		NX = TX
		table.insert(Shape,{NX,NY})
	end
	return Shape
end

function CSMakeGraphR2(funcA,Start,Direction,StepLength,StepNumber,Partition,MaxError,Number,Check,Loop2,Alert)
	if Check == nil then
		Check = 0
	end
	local Alert1, Alert2
	if Alert == nil or Alert == 3 then
		Alert1 = 1
		Alert2 = 1
	elseif Alert == 1 then
		Alert1 = 1
		Alert2 = 0
	elseif Alert == 2 then
		Alert1 = 0
		Alert2 = 1
	else 
		Alert1 = 0
		Alert2 = 0
	end

	local Shape = {Number}
	local NX, NY, NT, NA
	if Direction == nil then
		Direction = 0
	end
	if StepLength <= 0 then
		CS_InputError()
	end
	--if Loop2 == nil then Loop2 = 12 end
	NA = _G[funcA](Start)
	NX = Start*math.cos(NA)
	NY = Start*math.sin(NA)
	NT = Start
	table.insert(Shape,{NX,NY}) -- 1st Point
	local TX, TY, dt, st, CX, CY, Count, ER, pt, Length, ER2, CT, TT, px1, py1, px2, py2, pLength, NT2, l
	if type(MaxError) == "number" then
		ER = math.abs(MaxError)
		ER2 = ER
	else
		ER = math.abs(MaxError[1])
		ER2 = math.abs(MaxError[2])
	end
	local k = (StepLength/StepNumber)/Partition
	for i = 1, Number-1 do
		CT = nil
		pLength = 0
		for j = 1, StepNumber do
			Length = 0
			local l = k*j			
			if Direction == 0 then -- forward
				for n = 1, Partition do
					local m = n*l
					local pa1 = _G[funcA]((m-l+NT))
					local px1 = (m-l+NT)*math.cos(pa1)
					local py1 = (m-l+NT)*math.sin(pa1)
					local pa2 = _G[funcA]((m+NT))
					local px2 = (m+NT)*math.cos(pa2)
					local py2 = (m+NT)*math.sin(pa2)
					pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
					Length = Length+pt
				end
			else
				for n = 1, Partition do
					local m = n*l
					local pa1 = _G[funcA]((NT-m+l))
					local px1 = (NT-m+l)*math.cos(pa1)
					local py1 = (NT-m+l)*math.sin(pa1)
					local pa2 = _G[funcA]((NT-m))
					local px2 = (NT-m)*math.cos(pa2)
					local py2 = (NT-m)*math.sin(pa2)
					pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
					Length = Length+pt
				end
			end
			if Check ~= 0 and pLength >= Length + ER then
				goto CS_GraphT2Skip1
			end
			if math.abs(Length-StepLength) < ER then 
				if Direction == 0 then -- forward
					pt = (StepLength*j/StepNumber)+NT 
					if CT == nil then
						CT = pt
						NT2 = (StepLength*(j-1)/StepNumber)+NT 
					elseif pt <= CT then
						CT = pt
						NT2 = (StepLength*(j-1)/StepNumber)+NT 
					end
				else
					pt = NT-(StepLength*j/StepNumber) 
					if CT == nil then
						CT = pt
						NT2 = NT-(StepLength*(j-1)/StepNumber)
					elseif pt <= CT then
						CT = pt
						NT2 = NT-(StepLength*(j-1)/StepNumber) 
					end
				end
			end
			pLength = Length
			::CS_GraphT2Skip1::
		end
		if Alert1 == 1 and CT == nil then Loop1_LimitExceeded() end

		-- 2nd Point ∑Part ≒ Length
		if Loop2 ~= nil then
			if Direction == 0 then -- forward
				dt = (CT-NT2)*2
			else
				dt = (NT2-CT)*2
			end
			st = dt
			NT = NT2
			Count = 0
			while true do
				Length = 0
				local k = dt/Partition
				if Direction == 0 then -- forward
					TT = NT + dt
					for n = 1, Partition do
						local m = n*k
						local pa1 = _G[funcA]((m-k+NT))
						local px1 = (m-k+NT)*math.cos(pa1)
						local py1 = (m-k+NT)*math.sin(pa1)
						local pa2 = _G[funcA]((m+NT))
						local px2 = (m+NT)*math.cos(pa2)
						local py2 = (m+NT)*math.sin(pa2)
						pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
						Length = Length+pt
					end
				else
					TT = NT - dt
					for n = 1, Partition do
						local m = n*k
						local pa1 = _G[funcA]((NT-m+k))
						local px1 = (NT-m+k)*math.cos(pa1)
						local py1 = (NT-m+k)*math.sin(pa1)
						local pa2 = _G[funcA]((NT-m))
						local px2 = (NT-m)*math.cos(pa2)
						local py2 = (NT-m)*math.sin(pa2)
						pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
						Length = Length+pt
					end
				end
				if Alert2 == 1 and Count >= Loop2 then Loop2_LimitExceeded() end
				if math.abs(Length-StepLength) < ER2 or Count >= Loop2 then break end
				if Length>=StepLength then 
					st = st/2
					dt = dt - st
				else
					st = st/2
					dt = dt + st
				end
				Count = Count + 1
			end
		else
			TT = CT
		end
		-- 3rd Point 
		local TA = _G[funcA](TT)
		TX = TT*math.cos(TA)
		TY = TT*math.sin(TA)
		NT = TT
		table.insert(Shape,{TX,TY})
	end
	return Shape
end

function CSMakeGraphA2(funcR,Start,Direction,StepLength,StepNumber,Partition,MaxError,Number,Check,Loop2,Alert)
	if Check == nil then
		Check = 0
	end
	local Alert1, Alert2
	if Alert == nil or Alert == 3 then
		Alert1 = 1
		Alert2 = 1
	elseif Alert == 1 then
		Alert1 = 1
		Alert2 = 0
	elseif Alert == 2 then
		Alert1 = 0
		Alert2 = 1
	else 
		Alert1 = 0
		Alert2 = 0
	end

	local Shape = {Number}
	local NX, NY, NT, NR
	if Direction == nil then
		Direction = 0
	end
	if StepLength <= 0 then
		CS_InputError()
	end
	--if Loop2 == nil then Loop2 = 12 end
	NR = _G[funcR](Start)
	NX = NR*math.cos(Start)
	NY = NR*math.sin(Start)
	NT = Start
	table.insert(Shape,{NX,NY}) -- 1st Point
	local TX, TY, dt, st, CX, CY, Count, ER, pt, Length, ER2, CT, TT, px1, py1, px2, py2, pLength, NT2, l
	if type(MaxError) == "number" then
		ER = math.abs(MaxError)
		ER2 = ER
	else
		ER = math.abs(MaxError[1])
		ER2 = math.abs(MaxError[2])
	end
	local k = (StepLength/StepNumber)/Partition
	for i = 1, Number-1 do
		CT = nil
		pLength = 0
		for j = 1, StepNumber do
			Length = 0
			local l = k*j			
			if Direction == 0 then -- forward
				for n = 1, Partition do
					local m = n*l
					local pr1 = _G[funcR]((m-l+NT))
					local px1 = pr1*math.cos(m-l+NT)
					local py1 = pr1*math.sin(m-l+NT)
					local pr2 = _G[funcR]((m+NT))
					local px2 = pr2*math.cos(m+NT)
					local py2 = pr2*math.sin(m+NT)
					pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
					Length = Length+pt
				end
			else
				for n = 1, Partition do
					local m = n*l
					local pr1 = _G[funcR]((NT-m+l))
					local px1 = pr1*math.cos(NT-m+l)
					local py1 = pr1*math.sin(NT-m+l)
					local pr2 = _G[funcR]((NT-m))
					local px2 = pr2*math.cos(NT-m)
					local py2 = pr2*math.sin(NT-m)
					pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
					Length = Length+pt
				end
			end
			if Check ~= 0 and pLength >= Length + ER then
				goto CS_GraphT2Skip1
			end
			if math.abs(Length-StepLength) < ER then 
				if Direction == 0 then -- forward
					pt = (StepLength*j/StepNumber)+NT 
					if CT == nil then
						CT = pt
						NT2 = (StepLength*(j-1)/StepNumber)+NT 
					elseif pt <= CT then
						CT = pt
						NT2 = (StepLength*(j-1)/StepNumber)+NT 
					end
				else
					pt = NT-(StepLength*j/StepNumber) 
					if CT == nil then
						CT = pt
						NT2 = NT-(StepLength*(j-1)/StepNumber)
					elseif pt <= CT then
						CT = pt
						NT2 = NT-(StepLength*(j-1)/StepNumber) 
					end
				end
			end
			pLength = Length
			::CS_GraphT2Skip1::
		end
		if Alert1 == 1 and CT == nil then Loop1_LimitExceeded() end

		-- 2nd Point ∑Part ≒ Length
		if Loop2 ~= nil then
			if Direction == 0 then -- forward
				dt = (CT-NT2)*2
			else
				dt = (NT2-CT)*2
			end
			st = dt
			NT = NT2
			Count = 0
			while true do
				Length = 0
				local k = dt/Partition
				if Direction == 0 then -- forward
					TT = NT + dt
					for n = 1, Partition do
						local m = n*k
						local pr1 = _G[funcR]((m-k+NT))
						local px1 = pr1*math.cos(m-k+NT)
						local py1 = pr1*math.sin(m-k+NT)
						local pr2 = _G[funcR]((m+NT))
						local px2 = pr2*math.cos(m+NT)
						local py2 = pr2*math.sin(m+NT)
						pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
						Length = Length+pt
					end
				else
					TT = NT - dt
					for n = 1, Partition do
						local m = n*k
						local pr1 = _G[funcR]((NT-m+k))
						local px1 = pr1*math.cos(NT-m+k)
						local py1 = pr1*math.sin(NT-m+k)
						local pr2 = _G[funcR]((NT-m))
						local px2 = pr2*math.cos(NT-m)
						local py2 = pr2*math.sin(NT-m)
						pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
						Length = Length+pt
					end
				end
				if Alert2 == 1 and Count >= Loop2 then Loop2_LimitExceeded() end
				if math.abs(Length-StepLength) < ER2 or Count >= Loop2 then break end
				if Length>=StepLength then 
					st = st/2
					dt = dt - st
				else
					st = st/2
					dt = dt + st
				end
				Count = Count + 1
			end
		else
			TT = CT
		end
		-- 3rd Point 
		local TR = _G[funcR](TT)
		TX = TR*math.cos(TT)
		TY = TR*math.sin(TT)
		NT = TT
		table.insert(Shape,{TX,TY})
	end
	return Shape
end

function CSMakeGraphT2(Parafunc,Start,Direction,StepLength,StepNumber,Partition,MaxError,Number,Check,Loop2,Alert)
	if Check == nil then
		Check = 0
	end
	local Alert1, Alert2
	if Alert == nil or Alert == 3 then
		Alert1 = 1
		Alert2 = 1
	elseif Alert == 1 then
		Alert1 = 1
		Alert2 = 0
	elseif Alert == 2 then
		Alert1 = 0
		Alert2 = 1
	else 
		Alert1 = 0
		Alert2 = 0
	end

	local Shape = {Number}
	local NX, NY, NT
	if Direction == nil then
		Direction = 0
	end
	if StepLength <= 0 then
		CS_InputError()
	end
	--if Loop2 == nil then Loop2 = 12 end
	NX, NY = _G[Parafunc](Start)
	NT = Start
	table.insert(Shape,{NX,NY}) -- 1st Point
	local TX, TY, dt, st, CX, CY, Count, ER, pt, Length, ER2, CT, TT, px1, py1, px2, py2, pLength, NT2, l
	if type(MaxError) == "number" then
		ER = math.abs(MaxError)
		ER2 = ER
	else
		ER = math.abs(MaxError[1])
		ER2 = math.abs(MaxError[2])
	end
	local k = (StepLength/StepNumber)/Partition
	for i = 1, Number-1 do
		CT = nil
		pLength = 0
		for j = 1, StepNumber do
			Length = 0
			local l = k*j			
			if Direction == 0 then -- forward
				for n = 1, Partition do
					local m = n*l
					local px1, py1 = _G[Parafunc]((m-l+NT))
					local px2, py2 = _G[Parafunc]((m+NT))
					pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
					Length = Length+pt
				end
			else
				for n = 1, Partition do
					local m = n*l
					local px1, py1 = _G[Parafunc]((NT-m+l))
					local px2, py2 = _G[Parafunc]((NT-m))
					pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
					Length = Length+pt
				end
			end
			if Check ~= 0 and pLength >= Length + ER then
				goto CS_GraphT2Skip1
			end
			if math.abs(Length-StepLength) < ER then 
				if Direction == 0 then -- forward
					pt = (StepLength*j/StepNumber)+NT 
					if CT == nil then
						CT = pt
						NT2 = (StepLength*(j-1)/StepNumber)+NT 
					elseif pt <= CT then
						CT = pt
						NT2 = (StepLength*(j-1)/StepNumber)+NT 
					end
				else
					pt = NT-(StepLength*j/StepNumber) 
					if CT == nil then
						CT = pt
						NT2 = NT-(StepLength*(j-1)/StepNumber)
					elseif pt <= CT then
						CT = pt
						NT2 = NT-(StepLength*(j-1)/StepNumber) 
					end
				end
			end
			pLength = Length
			::CS_GraphT2Skip1::
		end
		if Alert1 == 1 and CT == nil then Loop1_LimitExceeded() end

		-- 2nd Point ∑Part ≒ Length
		if Loop2 ~= nil then
			if Direction == 0 then -- forward
				dt = (CT-NT2)*2
			else
				dt = (NT2-CT)*2
			end
			st = dt
			NT = NT2
			Count = 0
			while true do
				Length = 0
				local k = dt/Partition
				if Direction == 0 then -- forward
					TT = NT + dt
					for n = 1, Partition do
						local m = n*k
						local px1, py1 = _G[Parafunc]((m-k+NT))
						local px2, py2 = _G[Parafunc]((m+NT))
						pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
						Length = Length+pt
					end
				else
					TT = NT - dt
					for n = 1, Partition do
						local m = n*k
						local px1, py1 = _G[Parafunc]((NT-m+k))
						local px2, py2 = _G[Parafunc]((NT-m))
						pt = math.sqrt((px2-px1)^2+(py2-py1)^2)
						Length = Length+pt
					end
				end
				if Alert2 == 1 and Count >= Loop2 then Loop2_LimitExceeded() end
				if math.abs(Length-StepLength) < ER2 or Count >= Loop2 then break end
				if Length>=StepLength then 
					st = st/2
					dt = dt - st
				else
					st = st/2
					dt = dt + st
				end
				Count = Count + 1
			end
		else
			TT = CT
		end
		-- 3rd Point 
		TX, TY = _G[Parafunc](TT)
		NT = TT
		table.insert(Shape,{TX,TY})
	end
	return Shape
end

function RegularPolygonGraphT(T,Point,Concave,Rigidity,Magnificent)
	local k, n1, n2, n3, m, c, Ret, p2m
	c = Magnificent
	k = Rigidity
	m = Concave
	if type(Point) == "number" then
		n1 = Point
		n2 = Point
		n3 = Point
	else
		n1 = Point[1]
		n2 = Point[2]
		n3 = Point[3]
	end
	p2m = (math.pi*m)/2
	if k > 1 or k < -1 then
		Rigidity_InputError()
	end
	Ret = c*(math.cos((math.asin(k)+p2m)/n3)/math.cos((math.asin(k*math.cos(n1*T))+p2m)/n2))
	return Ret*math.cos(T), Ret*math.sin(T)
end

function RegularPolygonGraphA(A,Point,Concave,Rigidity,Magnificent)
	local k, n1, n2, n3, m, c, Ret, p2m
	c = Magnificent
	k = Rigidity
	m = Concave
	if type(Point) == "number" then
		n1 = Point
		n2 = Point
		n3 = Point
	else
		n1 = Point[1]
		n2 = Point[2]
		n3 = Point[3]
	end
	p2m = (math.pi*m)/2
	if k > 1 or k < -1 then
		Rigidity_InputError()
	end
	Ret = c*(math.cos((math.asin(k)+p2m)/n3)/math.cos((math.asin(k*math.cos(n1*A))+p2m)/n2))
	return Ret
end

function CS_Distortion2(Shape,dLU,dLD,dRU,dRD,CenterXY)
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
		dx = CenterXY[1]
		dy = CenterXY[2]
	end

	local XLU,YLU,XRU,YRU,XRD,YRD,XLD,RLD
	if type(dLU) == "number" then
		CS_InputError()
	elseif dLU == nil then
		XLU = 0
		YLU = 0
	else
		if dLU[1] == nil then
			XLU = 0
		else
			XLU = dLU[1]
		end
		if dLU[2] == nil then
			YLU = 0
		else
			YLU = dLU[2]
		end
	end
	if type(dLD) == "number" then
		CS_InputError()
	elseif dLD == nil then
		XLD = 0
		YLD = 0
	else
		if dLD[1] == nil then
			XLD = 0
		else
			XLD = dLD[1]
		end
		if dLD[2] == nil then
			YLD = 0
		else
			YLD = dLD[2]
		end
	end
	if type(dRU) == "number" then
		CS_InputError()
	elseif dRU == nil then
		XRU = 0
		YRU = 0
	else
		if dRU[1] == nil then
			XRU = 0
		else
			XRU = dRU[1]
		end
		if dRU[2] == nil then
			YRU = 0
		else
			YRU = dRU[2]
		end
	end
	if type(dRD) == "number" then
		CS_InputError()
	elseif dRD == nil then
		XRD = 0
		YRD = 0
	else
		if dRD[1] == nil then
			XRD = 0
		else
			XRD = dRD[1]
		end
		if dRD[2] == nil then
			YRD = 0
		else
			YRD = dRD[2]
		end
	end
	local RetShape = {Shape[1]}
	local X1,X2,Y1,Y2
	
	for i = 1, Shape[1] do
		local NX, NY, R1X, R1Y, R2X, R2Y, R3X, R3Y, R4X, R4Y, TX, TY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]

		if CenterXY ~= nil then	
			Y1 = Ymax+YLU
			Y2 = Ymax+YRU
			R1Y = ((NY-Ymin)/(Ymax-Ymin))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX+dx-Xmin))

			Y1 = Ymin-YLD
			Y2 = Ymin-YRD
			R2Y = ((Ymax-NY)/(-Ymin+Ymax))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX+dx-Xmin))

			X1 = Xmax+XRD
			X2 = Xmax+XRU
			R3X = ((NX-Xmin)/(Xmax-Xmin))*(X1+((X2-X1)/(Ymax-Ymin))*(NY+dy-Ymin))

			X1 = Xmin-XLD
			X2 = Xmin-XLU
			R4X = ((Xmax-NX)/(-Xmin+Xmax))*(X1+((X2-X1)/(Ymax-Ymin))*(NY+dy-Ymin))
		else
			Y1 = Ymax+YLU
			Y2 = Ymax+YRU
			R1Y = ((NY-Ymin)/(Ymax-Ymin))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin))

			Y1 = Ymin-YLD
			Y2 = Ymin-YRD
			R2Y = ((Ymax-NY)/(-Ymin+Ymax))*(Y1+((Y2-Y1)/(Xmax-Xmin))*(NX-Xmin))

			X1 = Xmax+XRD
			X2 = Xmax+XRU
			R3X = ((NX-Xmin)/(Xmax-Xmin))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin))

			X1 = Xmin-XLD
			X2 = Xmin-XLU
			R4X = ((Xmax-NX)/(-Xmin+Xmax))*(X1+((X2-X1)/(Ymax-Ymin))*(NY-Ymin))
		end

		TX = R3X+R4X+XCntr
		TY = R1Y+R2Y+YCntr
		table.insert(RetShape,{TX,TY})
	end
	return RetShape
end

function CS_Warping(Shape,Ufunc,Dfunc,Lfunc,Rfunc,CenterXY)
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
		dx = CenterXY[1]
		dy = CenterXY[2]
	end

	local XLU,YLU,XRU,YRU,XRD,YRD,XLD,RLD
	local UXRatio
	local UYRatio
	if Ufunc ~= nil then
		if type(Ufunc) == "string" then
			Ufunc = {Ufunc}
		end
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
		if type(Dfunc) == "string" then
			Dfunc = {Dfunc}
		end
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
		if type(Lfunc) == "string" then
			Lfunc = {Lfunc}
		end
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
		if type(Rfunc) == "string" then
			Rfunc = {Rfunc}
		end
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

	local RetShape = {Shape[1]}
	local X1,X2,Y1,Y2,Data
	Data = {{Xmax,Xmin,XCntr},{Ymax,Ymin,YCntr}}
	for i = 1, Shape[1] do
		local NX, NY, R1X, R1Y, R2X, R2Y, R3X, R3Y, R4X, R4Y, TX, TY
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]

		if CenterXY ~= nil then	
			if Ufunc ~= nil then
				R1Y = ((NY-Ymin)/(Ymax-Ymin))*(_G[Ufunc[1]]((NX+dx)/UXRatio,Data)*UYRatio)
			else 
				R1Y = (NY-Ymin)/(Ymax-Ymin)*(Ymax)
			end
			if Dfunc ~= nil then
				R2Y = ((NY-Ymax)/(Ymin-Ymax))*(_G[Dfunc[1]]((NX+dx)/DXRatio,Data)*DYRatio)
			else
				R2Y = (NY-Ymax)/(Ymin-Ymax)*(Ymin)
			end
			if Rfunc ~= nil then
				R3X = ((NX-Xmin)/(Xmax-Xmin))*(_G[Rfunc[1]]((NY+dy)/RYRatio,Data)*RXRatio)
			else
				R3X = (NX-Xmin)/(Xmax-Xmin)*(Xmax)
			end
			if Lfunc ~= nil then		
				R4X = ((NX-Xmax)/(Xmin-Xmax))*(_G[Lfunc[1]]((NY+dy)/LYRatio,Data)*LXRatio)
			else
				R4X = (NX-Xmax)/(Xmin-Xmax)*(Xmin)
			end
		else
			if Ufunc ~= nil then
				R1Y = ((NY-Ymin)/(Ymax-Ymin))*(_G[Ufunc[1]](NX/UXRatio,Data)*UYRatio)
			else 
				R1Y = (NY-Ymin)/(Ymax-Ymin)*(Ymax)
			end
			if Dfunc ~= nil then
				R2Y = ((NY-Ymax)/(Ymin-Ymax))*(_G[Dfunc[1]](NX/DXRatio,Data)*DYRatio)
			else
				R2Y = (NY-Ymax)/(Ymin-Ymax)*(Ymin)
			end
			if Rfunc ~= nil then
				R3X = ((NX-Xmin)/(Xmax-Xmin))*(_G[Rfunc[1]](NY/RYRatio,Data)*RXRatio)
			else
				R3X = (NX-Xmin)/(Xmax-Xmin)*(Xmax)
			end
			if Lfunc ~= nil then		
				R4X = ((NX-Xmax)/(Xmin-Xmax))*(_G[Lfunc[1]](NY/LYRatio,Data)*LXRatio)
			else
				R4X = (NX-Xmax)/(Xmin-Xmax)*(Xmin)
			end
		end

		TX = R3X+R4X+XCntr
		TY = R1Y+R2Y+YCntr
		table.insert(RetShape,{TX,TY})
	end
	return RetShape
end

function CSMakeGraphXY(funcXY,areaX,areaY,StepX,StepY,MaxError,LoopX,LoopY)
	local Shape = {0}
	local NX, NY
	if LoopX == nil then
		LoopX = 16
	end
	if LoopY == nil then
		LoopY = 16
	end 
	local Xmin, Xmax, Ymin, Ymax, Xlen, Ylen, isoX, isoY, dy, sy, dx, sx
	Xmin = areaX[1]
	Xmax = areaX[2]
	Ymin = areaY[1]
	Ymax = areaY[2]
	Xlen = Xmax - Xmin
	Ylen = Ymax - Ymin
	isoX = Xlen/StepX
	isoY = Ylen/StepY
	dx = isoX/LoopX
	dy = isoY/LoopY

	
	local k, CX, CY, ER, TX, TY, pk
	ER = math.abs(MaxError)
	for i = 0, StepX do
		NX = Xmin + i*isoX
		for j = 0, StepY do
			NY = Ymin + j*isoY
			CX = nil
			CY = nil

			sx = 0
			for l = 0, LoopX-1 do
				TX = NX + sx
				sy = 0
				for p = 0, LoopY-1 do
					TY = NY + sy

					k = math.abs(_G[funcXY](TX,TY))
					
					if k < ER then
						if CY == nil then
							CX = TX
							CY = TY
							pk = k
						elseif k < pk then 
							CX = TX
							CY = TY
							pk = k
						end
					end
					sy = sy + dy
				end
				sx = sx + dx
			end
			if CY ~= nil then
				Shape[1] = Shape[1] + 1
				table.insert(Shape,{CX,CY})
			end			
		end
	end
	return Shape
end

function CSMakeGraphRA(funcRA,areaR,areaA,StepR,StepA,MaxError,LoopR,LoopA)
	local Shape = {0}
	local NR, NA
	if LoopR == nil then
		LoopR = 16
	end
	if LoopA == nil then
		LoopA = 16
	end 
	local Rmin, Rmax, Amin, Amax, Rlen, Alen, isoR, isoA, dr, sr, da, sa
	Rmin = areaR[1]
	Rmax = areaR[2]
	Amin = areaA[1]
	Amax = areaA[2]
	Rlen = Rmax - Rmin
	Alen = Amax - Amin
	isoR = Rlen/StepR
	isoA = Alen/StepA
	dr = isoR/LoopR
	da = isoA/LoopA

	
	local k, CR, CA, ER, TR, TA, pk
	ER = math.abs(MaxError)
	for i = 0, StepR do
		NR = Rmin + i*isoR
		for j = 0, StepA do
			NA = Amin + j*isoA
			CR = nil
			CA = nil

			sr = 0
			for l = 0, LoopR-1 do
				TR = NR + sr
				sa = 0
				for p = 0, LoopA-1 do
					TA = NA + sa

					k = math.abs(_G[funcRA](TR,TA))
					
					if k < ER then
						if CA == nil then
							CR = TR
							CA = TA
							pk = k
						elseif k < pk then 
							CR = TR
							CA = TA
							pk = k
						end
					end
					sa = sa + da
				end
				sr = sr + dr
			end
			if CA ~= nil then
				Shape[1] = Shape[1] + 1
				table.insert(Shape,{CR*math.cos(CA),CR*math.sin(CA)})
			end			
		end
	end
	return Shape
end

function __Sort(Level,Start,End) -- Sort용 내부 함수
	local Kmin, Temp
	for i = Start, End do
		Kmin = i
		for j = i, End do
			if __SortRet[Kmin][Level] > __SortRet[j][Level] then
				Kmin = j
			end
		end
		Temp = __SortArr[i+1]
		__SortArr[i+1] = __SortArr[Kmin+1]
		__SortArr[Kmin+1] = Temp
		Temp = __SortRet[i]
		__SortRet[i] = __SortRet[Kmin]
		__SortRet[Kmin] = Temp
	end
	
	if Level ~= #__SortRet[1] then
		local ptr1 = Start
		local n = 1
		local Step
		if type(__SortEra[Level]) == "number" then
			Step =  __SortEra[Level]
		else
			Step = _G[__SortEra[Level]](n)
		end
		local ptr2 = Start

		local Temp2 = __SortRet[ptr1][Level] + Step 
		for i = ptr1+1, End do
			if Temp2 < __SortRet[i][Level] then 
				break
			else
				ptr2 = i
			end
		end

		while true do
			if ptr2 > ptr1 then
				__Sort(Level+1,ptr1,ptr2)
			end

			n = n + 1
			ptr1 = ptr2 + 1
			if ptr1 > End then
				break
			end
			ptr2 = ptr1
			if type(__SortEra[Level]) == "number" then
				Step =  __SortEra[Level]
			else
				Step = _G[__SortEra[Level]](n)
			end
			Temp2 = __SortRet[ptr1][Level] + Step 
			for i = ptr1+1, End do
				if Temp2 < __SortRet[i][Level] then 
					break
				else
					ptr2 = i
				end
			end
		end
	end
end
__SortTArr = {}
__SortArr = {}
__SortRet = {}
__SortEra = {}
__SortMax = {}
__SortNum = {}
__SortSum = {}
__SortChk = {}
function CS_SortXY(Shape,funcXY,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, K
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		K = _G[funcXY](NX,NY)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__Sort(1,1,Shape[1]) -- Level1

	local RetShape = __SortArr
	return RetShape
end

function CS_SortRA(Shape,funcRA,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, K
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local NR, NA
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
		
		K = _G[funcRA](NR,NA)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__Sort(1,1,Shape[1]) -- Level1

	local RetShape = __SortArr
	return RetShape
end

function CS_SortI(Shape,funcI,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local K
		K = _G[funcI](i)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__Sort(1,1,Shape[1]) -- Level1

	local RetShape = __SortArr
	return RetShape
end

function CS_NSortXY(Shape,Func,Step,funcXY,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, K
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		K = _G[funcXY](NX,NY)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__Sort(1,1,Shape[1]) -- Level1

	local RetShape = __SortArr

	local LoopArr = {Step}
	local ptr1 = 1
	local ptr2 = 1
	local Stack, tmp
	local Sum = 0
	if Func == nil then
		Stack = 1+Shape[1]/Step
	else
		for j = 1, Step do
			tmp = _G[Func](j)
			if tmp < 0 then
				tmp = 0
			end
			Sum = Sum + tmp
		end
		tmp = _G[Func](1)
		if tmp < 0 then
			tmp = 0
		end
		Stack = 1+Shape[1]*tmp/Sum
	end
	ptr2 = math.ceil(Stack)

	for j = 1, Step do
		local Temp = math.floor(Stack)
		if Stack-Temp < 0.0001 then
			ptr2 = Temp
		end
		table.insert(LoopArr,ptr2-ptr1)
		if j == Step then
			break
		end

		ptr1 = ptr2
		if Func == nil then
			Stack = Stack + Shape[1]/Step
		else
			tmp = _G[Func](j+1)
			if tmp < 0 then
				tmp = 0
			end
			Stack = Stack + Shape[1]*tmp/Sum
		end
		ptr2 = math.ceil(Stack)
	end

	return RetShape, LoopArr
end

function CS_NSortRA(Shape,Func,Step,funcRA,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, K
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local NR, NA
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
		K = _G[funcRA](NR,NA)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__Sort(1,1,Shape[1]) -- Level1

	local RetShape = __SortArr

	local LoopArr = {Step}
	local ptr1 = 1
	local ptr2 = 1
	local Stack, tmp
	local Sum = 0
	if Func == nil then
		Stack = 1+Shape[1]/Step
	else
		for j = 1, Step do
			tmp = _G[Func](j)
			if tmp < 0 then
				tmp = 0
			end
			Sum = Sum + tmp
		end
		tmp = _G[Func](1)
		if tmp < 0 then
			tmp = 0
		end
		Stack = 1+Shape[1]*tmp/Sum
	end
	ptr2 = math.ceil(Stack)

	for j = 1, Step do
		local Temp = math.floor(Stack)
		if Stack-Temp < 0.0001 then
			ptr2 = Temp
		end
		table.insert(LoopArr,ptr2-ptr1)
		if j == Step then
			break
		end

		ptr1 = ptr2
		if Func == nil then
			Stack = Stack + Shape[1]/Step
		else
			tmp = _G[Func](j+1)
			if tmp < 0 then
				tmp = 0
			end
			Stack = Stack + Shape[1]*tmp/Sum
		end
		ptr2 = math.ceil(Stack)
	end

	return RetShape, LoopArr
end

function CS_NSortI(Shape,Func,Step,funcI,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local K
		K = _G[funcI](i)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__Sort(1,1,Shape[1]) -- Level1

	local RetShape = __SortArr

	local LoopArr = {Step}
	local ptr1 = 1
	local ptr2 = 1
	local Stack, tmp
	local Sum = 0
	if Func == nil then
		Stack = 1+Shape[1]/Step
	else
		for j = 1, Step do
			tmp = _G[Func](j)
			if tmp < 0 then
				tmp = 0
			end
			Sum = Sum + tmp
		end
		tmp = _G[Func](1)
		if tmp < 0 then
			tmp = 0
		end
		Stack = 1+Shape[1]*tmp/Sum
	end
	ptr2 = math.ceil(Stack)

	for j = 1, Step do
		local Temp = math.floor(Stack)
		if Stack-Temp < 0.0001 then
			ptr2 = Temp
		end
		table.insert(LoopArr,ptr2-ptr1)
		if j == Step then
			break
		end

		ptr1 = ptr2
		if Func == nil then
			Stack = Stack + Shape[1]/Step
		else
			tmp = _G[Func](j+1)
			if tmp < 0 then
				tmp = 0
			end
			Stack = Stack + Shape[1]*tmp/Sum
		end
		ptr2 = math.ceil(Stack)
	end

	return RetShape, LoopArr
end

function __TSort(Level,Start,End) -- TSort용 내부 함수
	local Kmin, Temp
	for i = Start, End do
		Kmin = i
		for j = i, End do
			if __SortRet[Kmin][Level] > __SortRet[j][Level] then
				Kmin = j
			end
		end
		Temp = __SortArr[i+1]
		__SortArr[i+1] = __SortArr[Kmin+1]
		__SortArr[Kmin+1] = Temp
		Temp = __SortRet[i]
		__SortRet[i] = __SortRet[Kmin]
		__SortRet[Kmin] = Temp
	end
	
	if Level ~= #__SortRet[1] then
		local ptr1 = Start
		local n = 1
		local Step
		if type(__SortEra[Level]) == "number" then
			Step =  __SortEra[Level]
		else
			Step = _G[__SortEra[Level]](n)
		end
		local ptr2 = Start

		local Temp2 = __SortRet[ptr1][Level] + Step 
		for i = ptr1+1, End do
			if Temp2 < __SortRet[i][Level] then 
				break
			else
				ptr2 = i
			end
		end

		while true do
			if ptr2 > ptr1 then
				__TSort(Level+1,ptr1,ptr2)
			else
				if __SortChk == 1 then
					table.insert(__SortMax,1)
					for j = 2, __SortMax[1] do
						table.insert(__SortMax,0)
					end
				else
					table.insert(__SortMax,1)
				end
			end

			n = n + 1
			ptr1 = ptr2 + 1
			if ptr1 > End then
				break
			end
			ptr2 = ptr1
			if type(__SortEra[Level]) == "number" then
				Step =  __SortEra[Level]
			else
				Step = _G[__SortEra[Level]](n)
			end
			Temp2 = __SortRet[ptr1][Level] + Step 
			for i = ptr1+1, End do
				if Temp2 < __SortRet[i][Level] then 
					break
				else
					ptr2 = i
				end
			end
		end
	else
		local prev
		local ptr1 = Start
		local ptr2 = 0
		local Stack, tmp
		local Step = __SortMax[1] 
		local Sum = __SortSum
		local Func = __SortNum
		local dK = __SortRet[End][Level] - __SortRet[Start][Level]
		if #Func == 0 then
			Stack = __SortRet[Start][Level] + dK/Step
			for j = ptr1, End do
				if __SortRet[j][Level] > Stack and not(math.abs(Stack -__SortRet[j][Level]) < 0.00001) then 
					prev = j
					break
				else
					ptr2 = j
					prev = j+1
				end
				if j == End then
					ptr2 = End
					prev = End+1
				end
			end

			for j = 1, Step do
				if ptr1 > End and __SortChk == 1 then
					table.insert(__SortMax,0)
				elseif ptr2 ~= 0 then
					table.insert(__SortMax,ptr2-ptr1+1)
				else
					if prev - ptr1 == 1 then
						table.insert(__SortMax,1)
						ptr2 = ptr1
					else
						if __SortChk == 1 then
							table.insert(__SortMax,0)
						end
						ptr2 = prev-1
					end
				end
				if j == Step then
					break
				end

				ptr1 = ptr2+1
				ptr2 = 0
				prev = nil
				
				Stack = Stack + dK/Step
				for l = ptr1, End do
					if __SortRet[l][Level] > Stack and not(math.abs(Stack -__SortRet[l][Level]) < 0.00001) then 
						prev = l
						break
					else
						ptr2 = l
						prev = l+1
					end
					if l == End then
						ptr2 = End
						prev = End+1
					end
				end
			end
		else
			tmp = _G[Func](1)
			if tmp < 0 then
				tmp = 0
			end

			Stack = __SortRet[Start][Level] + dK*tmp/Sum

			for j = ptr1, End do
				if __SortRet[j][Level] > Stack and not(math.abs(Stack -__SortRet[j][Level]) < 0.00001) then 
					prev = j
					break
				else
					ptr2 = j
					prev = j+1
				end
				if j == End then
					ptr2 = End
					prev = End+1
				end
			end

			for j = 1, Step do
				if ptr1 > End and __SortChk == 1 then
					table.insert(__SortMax,0)
				elseif ptr2 ~= 0 then
					table.insert(__SortMax,ptr2-ptr1+1)
				else
					if prev - ptr1 == 1 then
						table.insert(__SortMax,1)
						ptr2 = ptr1
					else
						if __SortChk == 1 then
							table.insert(__SortMax,0)
						end
						ptr2 = prev-1
					end
				end
				if j == Step then
					break
				end

				ptr1 = ptr2+1
				ptr2 = 0
				prev = nil

				tmp = _G[Func](j+1)
				if tmp < 0 then
					tmp = 0
				end

				Stack = Stack + dK*tmp/Sum
				
				for l = ptr1, End do
					if __SortRet[l][Level] > Stack and not(math.abs(Stack -__SortRet[l][Level]) < 0.00001) then 
						prev = l
						break
					else
						ptr2 = l
						prev = l+1
					end
					if l == End then
						ptr2 = End
						prev = End+1
					end
				end
			end
		end
	end
end

function CS_TSortXY(Shape,Func,Step,Void,funcXY,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end
	if Void == nil or Void == 0 then
		Void = 0
	else
		Void = 1
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, K
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		K = _G[funcXY](NX,NY)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	local Sum = 0
	local tmp
	if Func ~= nil then
		for j = 1, Step do
			tmp = _G[Func](j)
			if tmp < 0 then
				tmp = 0
			end
			Sum = Sum + tmp
		end
	end
	__SortMax = {Step}
	if Func == nil then
		__SortNum = {}
	else
		__SortNum = Func
	end
	__SortSum = Sum
	__SortChk = Void
	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep
	__TSort(1,1,Shape[1]) -- Level1
	if __SortMax[1] > 0 then
		__SortMax[1] = #__SortMax-1
	end
	local RetShape = __SortArr
	local LoopArr = __SortMax

	return RetShape, LoopArr
end

function CS_TSortRA(Shape,Func,Step,Void,funcRA,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end
	if Void == nil or Void == 0 then
		Void = 0
	else
		Void = 1
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local NX, NY, K
		NX = Shape[i+1][1]
		NY = Shape[i+1][2]
		local NR, NA
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
		K = _G[funcRA](NR,NA)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	local Sum = 0
	local tmp
	if Func ~= nil then
		for j = 1, Step do
			tmp = _G[Func](j)
			if tmp < 0 then
				tmp = 0
			end
			Sum = Sum + tmp
		end
	end
	__SortMax = {Step}
	if Func == nil then
		__SortNum = {}
	else
		__SortNum = Func
	end
	__SortSum = Sum
	__SortChk = Void
	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep
	__TSort(1,1,Shape[1]) -- Level1
	if __SortMax[1] > 0 then
		__SortMax[1] = #__SortMax-1
	end
	local RetShape = __SortArr
	local LoopArr = __SortMax

	return RetShape, LoopArr
end

function CS_TSortI(Shape,Func,Step,Void,funcI,FStep,Direction)
	if Shape == nil or Shape[1] == 0 then
		CS_InputError()
	end
	if Void == nil or Void == 0 then
		Void = 0
	else
		Void = 1
	end

	__SortRet = {}
	__SortArr = {Shape[1]}
	for i = 1, Shape[1] do
		local K
		K = _G[funcI](i)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortArr,Shape[i+1])
	end

	local Sum = 0
	local tmp
	if Func ~= nil then
		for j = 1, Step do
			tmp = _G[Func](j)
			if tmp < 0 then
				tmp = 0
			end
			Sum = Sum + tmp
		end
	end
	__SortMax = {Step}
	if Func == nil then
		__SortNum = {}
	else
		__SortNum = Func
	end
	__SortSum = Sum
	__SortChk = Void
	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep
	__TSort(1,1,Shape[1]) -- Level1
	if __SortMax[1] > 0 then
		__SortMax[1] = #__SortMax-1
	end
	local RetShape = __SortArr
	local LoopArr = __SortMax

	return RetShape, LoopArr
end

function CS_Mix(Shape,Preset,Looper,Overwrite) -- {Shape,f(n)} : 1~n -> f(n)에 복사
	local RetShape = {0}
	local LoopArr = {0}

	local Over = 0
	if Overwrite == nil or Overwrite == 0 then
		Over = 0
	elseif type(Overwrite) == "number" then 
		Over = Overwrite
	end
	if Over ~= 0 then
		Over = 1
	else
		Over = 0
	end

	local Check = 0
	local Limit = {}
	for i = 1, #Shape do
		table.insert(Limit,0)
	end
	local max = 0
	local index = 1
	local Num = 1
	local i = 1
	local Stack = 0
	local p
	local TSort
	if Preset ~= nil then
		if Preset[1] ~= 0 then
			Preset[1] = 1
		end
		TSort = Preset[2]
		if type(TSort) == "number" then
			p = TSort
		else
			p = math.floor(_G[TSort](1))
		end
	end
	while true do
		for k, v in pairs(Shape) do	
			if Limit[k] < v[1][1] then
				local Loop
				if Looper[k] == nil then
					Loop = v[1][1]
				elseif type(Looper[k]) == "number" then
					Loop = Looper[k]
				else
					Loop = math.floor(_G[Looper[k]](index))
				end
				if Loop > v[1][1] then
					Loop = v[1][1]
				elseif Loop <= 0 then
					Loop = 1
				end
			
				local l = 0	
				local j = Limit[k]+1
				while true do
					local Ret = math.floor(_G[v[2]](j))+1
					if Ret <= 1 then
						Ret = 2
					end

					if Over == 1 then
						while true do
							if RetShape[Ret] ~= nil then
								Ret = Ret+1
							else
								break
							end
						end
					end

					RetShape[Ret] = v[1][j+1]
					RetShape[1] = RetShape[1] + 1
					if Ret > max then
						max = Ret
					end
					l = l + 1
					j = j + 1
					if l == Loop or j >= v[1][1]+1 then
						Limit[k] = j-1
						Stack = Stack + l
						break
					end
				end

				if Limit[k] >= v[1][1] then
					Check = Check + 1
				end
				Num = Num + 1
			elseif Preset ~= nil and Preset[1] == 1 then
				Num = Num + 1
			end

			if Preset ~= nil and Num > p then
				table.insert(LoopArr,Stack)
				Num = 1
				Stack = 0
				LoopArr[1] = LoopArr[1] + 1

				i = i + 1
				if type(TSort) == "number" then
					p = TSort
				else
					p = math.floor(_G[TSort](i))
				end
			end
		end
		if Check == #Shape then
			break
		end
		index = index+1
	end
	
	if Preset ~= nil and Num > 1 then
		table.insert(LoopArr,Stack)
		LoopArr[1] = LoopArr[1] + 1
	end

	local NShape = {RetShape[1]}
	for i = 2, max do
		if RetShape[i] ~= nil then
			table.insert(NShape,RetShape[i])
		end
	end
	NShape[1] = #NShape-1

	if Preset ~= nil then
		return NShape, LoopArr
	else
		return NShape
	end
end

function CS_Split(Shape,Preset,Looper,Overwrite) -- {N,f(i)} : 1~N -> f(i)를 추가함
	local Over = 0
	if Overwrite == nil or Overwrite == 0 then
		Over = 0
	elseif type(Overwrite) == "number" then 
		Over = Overwrite
	end
	if Over > 0 then
		Over = 1
	elseif Over < 0 then
		Over = -1
	else
		Over = 0
	end

	local Loop = 0
	if Looper == nil or Looper == 0 then
		Loop = 0
	else
		Loop = 1
	end

	local N = Preset[1]
	local Func = Preset[2]
	local Rep = {}
	local RetShape = {0}
	for i = 1, N do
		local Fi = math.floor(_G[Func](i))
		if Looper == 1 then
			if Fi > Shape[1] or Fi <= 0 then
				Fi = Fi % Shape[1] 
				if Fi == 0 then
					Fi = Shape[1]
				end
			end

			if Over == 1 then
				for k = 1, Shape[1] do
					if Rep[Fi] == 1 then
						Fi = Fi + 1
						if Fi > Shape[1] then
							Fi = Fi - Shape[1]
						end
					end
				end
			elseif Over == -1 then
				for k = 1, Shape[1] do
					if Rep[Fi] == 1 then
						Fi = Fi - 1
						if Fi <= 0 then
							Fi = Fi + Shape[1]
						end
					end
				end
			end

			if Rep[Fi] == nil then
				table.insert(RetShape,Shape[Fi+1])
				RetShape[1] = RetShape[1] + 1
				if Over ~= 0 then
					Rep[Fi] = 1
				end
			end
		else
			if Over == 1 then
				for k = 1, Shape[1] do
					if Rep[Fi] == 1 then
						Fi = Fi + 1
					end
				end
			elseif Over == -1 then
				for k = 1, Shape[1] do
					if Rep[Fi] == 1 then
						Fi = Fi - 1
					end
				end
			end

			if not(Fi > Shape[1] or Fi <= 0) then
				if Rep[Fi] == nil then
					table.insert(RetShape,Shape[Fi+1])
					RetShape[1] = RetShape[1] + 1
					if Over ~= 0 then
						Rep[Fi] = 1
					end
				end
			end
		end
	end
	return RetShape
end

function CS_Arrange(Shape,Preset,Looper,Overwrite) -- {N,f(i),f(j)} : 1~N -> f(i)과 f(j)를 교체
	local Over = {0,0}
	if Overwrite == nil or Overwrite == 0 then
		Over = {0,0}
	elseif type(Overwrite) == "number" then 
		Over = {Overwrite,Overwrite}
	else
		Over[1] = Overwrite[1]
		Over[2] = Overwrite[2]
	end
	if Over[1] > 0 then
		Over[1] = 1
	elseif Over[1] < 0 then
		Over[1] = -1
	else
		Over[1] = 0
	end
	if Over[2] > 0 then
		Over[2] = 1
	elseif Over[2] < 0 then
		Over[2] = -1
	else
		Over[2] = 0
	end

	local Loop = 0
	if Looper == nil or Looper == 0 then
		Loop = 0
	else
		Loop = 1
	end

	local RetShape = {Shape[1]}
	for i = 1, Shape[1] do
		table.insert(RetShape,Shape[i+1])
	end

	local N = Preset[1]
	local Funci = Preset[2]
	local Funcj = Preset[3]
	local Repi = {}
	local Repj = {}
	for i = 1, N do
		local Fi = math.floor(_G[Funci](i))
		local Fj = math.floor(_G[Funcj](i))
		if Looper == 1 then
			if Fi > Shape[1] or Fi <= 0 then
				Fi = Fi % Shape[1] 
				if Fi == 0 then
					Fi = Shape[1]
				end
			end
			if Fj > Shape[1] or Fj <= 0 then
				Fj = Fj % Shape[1] 
				if Fj == 0 then
					Fj = Shape[1]
				end
			end

			if Over[1] == 1 then
				for k = 1, Shape[1] do
					if Repi[Fi] == 1 then
						Fi = Fi + 1
						if Fi > Shape[1] then
							Fi = Fi - Shape[1]
						end
					end
				end
			elseif Over[1] == -1 then
				for k = 1, Shape[1] do
					if Repi[Fi] == 1 then
						Fi = Fi - 1
						if Fi <= 0 then
							Fi = Fi + Shape[1]
						end
					end
				end
			end

			if Over[2] == 1 then
				for k = 1, Shape[1] do
					if Repj[Fj] == 1 then
						Fj = Fj + 1
						if Fj > Shape[1] then
							Fj = Fj - Shape[1]
						end
					end
				end
			elseif Over[2] == -1 then
				for k = 1, Shape[1] do
					if Repj[Fj] == 1 then
						Fj = Fj - 1
						if Fj <= 0 then
							Fj = Fj + Shape[1]
						end
					end
				end
			end

			if Repi[Fi] == nil and Repj[Fj] == nil then
				local Temp = RetShape[Fi+1]
				RetShape[Fi+1] = RetShape[Fj+1]
				RetShape[Fj+1] = Temp
				if Over[1] ~= 0 then
					Repi[Fi] = 1
				end
				if Over[2] ~= 0 then
					Repj[Fj] = 1
				end
			end
		else
			if Over[1] == 1 then
				for k = 1, Shape[1] do
					if Repi[Fi] == 1 then
						Fi = Fi + 1
					end
				end
			elseif Over[1] == -1 then
				for k = 1, Shape[1] do
					if Repi[Fi] == 1 then
						Fi = Fi - 1
					end
				end
			end

			if Over[2] == 1 then
				for k = 1, Shape[1] do
					if Repj[Fj] == 1 then
						Fj = Fj + 1
					end
				end
			elseif Over[2] == -1 then
				for k = 1, Shape[1] do
					if Repj[Fj] == 1 then
						Fj = Fj - 1
					end
				end
			end

			if not(Fi > Shape[1] or Fi <= 0 or Fj > Shape[1] or Fj <= 0) then
				if Repi[Fi] == nil and Repj[Fj] == nil then
					local Temp = RetShape[Fi+1]
					RetShape[Fi+1] = RetShape[Fj+1]
					RetShape[Fj+1] = Temp
					if Over[1] ~= 0 then
						Repi[Fi] = 1
					end
					if Over[2] ~= 0 then
						Repj[Fj] = 1
					end
				end
			end
		end
	end

	return RetShape
end

function CS_TInputVoid(Size)
	local NShape = {Size}
	for i = 1, Size do
		table.insert(NShape,0)
	end
	return NShape
end

function CS_TMakeAuto(Shape,LoopMax)
	local LoopArr = {0}
	if LoopMax == nil then
		LoopArr = {1,Shape[1]}
	elseif type(LoopMax) == "number" then
		if LoopMax < 1 then
			LoopMax = 1
		end
		local Remain = Shape[1]
		while Remain > 0 do
			table.insert(LoopArr,LoopMax)
			LoopArr[1] = LoopArr[1] + 1
			Remain = Remain - LoopMax
		end
	else
		local i = 1
		local Remain = Shape[1]
		while Remain > 0 do
			table.insert(LoopArr,LoopMax[i])
			LoopArr[1] = LoopArr[1] + 1
			Remain = Remain - LoopMax[i]
			i = i + 1
			if i > #LoopMax then
				i = 1
			end
		end
	end
	return LoopArr
end

function CS_TMakePath(LoopData,...)
	if type(LoopData) == "number" then
		LoopData = {LoopData}
	end
	local arg = table.pack(...)
	for k = 1, arg.n do
		table.insert(LoopData,arg[k])
	end
	local Shape = {}
	for k, v in pairs(LoopData) do
		Shape[k+1] = v
	end
	Shape[1] = #LoopData
	return Shape
end

function CS_SortTI(Shape,funcT,FStep,Direction)
	if Shape == nil or Shape[1][1] == 0 or Shape[2][1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1][1]}
	__SortTArr = {Shape[2][1]}
	for i = 1, Shape[2][1] do
		local K
		K = _G[funcT](i)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortTArr,Shape[2][i+1])
	end
	local index = 1
	for i = 1, Shape[2][1] do
		local TempArr = {}
		for j = 1, Shape[2][i+1] do
			table.insert(TempArr,Shape[1][index+1])
			index = index+1
			if index > Shape[1][1] then break end
		end
		table.insert(__SortArr,TempArr)
		if index > Shape[1][1] then break end
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__SortT(1,1,Shape[2][1]) -- Level1

	local RetShape = {}
	for k, v in pairs(__SortArr) do
		if type(v) == "number" then
			table.insert(RetShape,v)
		else
			for p, q in pairs(v) do
				table.insert(RetShape,q)
			end
		end
	end

	local LoopArr = __SortTArr
	return RetShape, LoopArr
end

function CS_SortTM(Shape,funcT,FStep,Direction)
	if Shape == nil or Shape[1][1] == 0 or Shape[2][1] == 0 then
		CS_InputError()
	end

	__SortRet = {}
	__SortArr = {Shape[1][1]}
	__SortTArr = {Shape[2][1]}
	for i = 1, Shape[2][1] do
		local NX, K
		NX = Shape[2][i+1]
		K = _G[funcT](NX)
		if type(Direction) == "number" then
			if Direction ~= 0 then
				for j = 1, #K do
					K[j] = -K[j]
				end
			end
		else
			for j = 1, #K do
				if Direction[j] ~= 0 then
					K[j] = -K[j]
				end
			end
		end
		table.insert(__SortRet,K)
		table.insert(__SortTArr,Shape[2][i+1])
	end
	local index = 1
	for i = 1, Shape[2][1] do
		local TempArr = {}
		for j = 1, Shape[2][i+1] do
			table.insert(TempArr,Shape[1][index+1])
			index = index+1
			if index > Shape[1][1] then break end
		end
		table.insert(__SortArr,TempArr)
		if index > Shape[1][1] then break end
	end

	if #__SortRet[1]>1 and FStep == nil then
		CS_IntputError()
	end
	__SortEra = FStep

	__SortT(1,1,Shape[2][1]) -- Level1

	local RetShape = {}
	for k, v in pairs(__SortArr) do
		if type(v) == "number" then
			table.insert(RetShape,v)
		else
			for p, q in pairs(v) do
				table.insert(RetShape,q)
			end
		end
	end

	local LoopArr = __SortTArr
	return RetShape, LoopArr
end

function __SortT(Level,Start,End) -- SortT용 내부 함수
	local Kmin, Temp
	for i = Start, End do
		Kmin = i
		for j = i, End do
			if __SortRet[Kmin][Level] > __SortRet[j][Level] then
				Kmin = j
			end
		end
		Temp = __SortArr[i+1]
		__SortArr[i+1] = __SortArr[Kmin+1]
		__SortArr[Kmin+1] = Temp
		Temp = __SortTArr[i+1]
		__SortTArr[i+1] = __SortTArr[Kmin+1]
		__SortTArr[Kmin+1] = Temp
		Temp = __SortRet[i]
		__SortRet[i] = __SortRet[Kmin]
		__SortRet[Kmin] = Temp
	end
	
	if Level ~= #__SortRet[1] then
		local ptr1 = Start
		local n = 1
		local Step
		if type(__SortEra[Level]) == "number" then
			Step =  __SortEra[Level]
		else
			Step = _G[__SortEra[Level]](n)
		end
		local ptr2 = Start

		local Temp2 = __SortRet[ptr1][Level] + Step 
		for i = ptr1+1, End do
			if Temp2 < __SortRet[i][Level] then 
				break
			else
				ptr2 = i
			end
		end

		while true do
			if ptr2 > ptr1 then
				__SortT(Level+1,ptr1,ptr2)
			end

			n = n + 1
			ptr1 = ptr2 + 1
			if ptr1 > End then
				break
			end
			ptr2 = ptr1
			if type(__SortEra[Level]) == "number" then
				Step =  __SortEra[Level]
			else
				Step = _G[__SortEra[Level]](n)
			end
			Temp2 = __SortRet[ptr1][Level] + Step 
			for i = ptr1+1, End do
				if Temp2 < __SortRet[i][Level] then 
					break
				else
					ptr2 = i
				end
			end
		end
	end
end

function CS_TMix(Shape,Looper,Overwrite) -- {Shape,TSort,f(n)} : 1~n -> f(n)에 복사
	local CmpShape = {}
	for k, v in pairs(Shape) do
		local index = 1
		local Cmp = {v[2][1]}
		for i = 1, v[2][1] do
			local TempArr = {}
			for j = 1, v[2][i+1] do
				table.insert(TempArr,v[1][index+1])
				index = index+1
				if index > v[1][1] then break end
			end
			table.insert(Cmp,TempArr)
			if index > v[1][1] then break end
		end
		table.insert(CmpShape,Cmp)
	end

	local RetShape = {0}
	local RetLoopArr = {0}

	local Over = 0
	if Overwrite == nil or Overwrite == 0 then
		Over = 0
	elseif type(Overwrite) == "number" then 
		Over = Overwrite
	end
	if Over ~= 0 then
		Over = 1
	else
		Over = 0
	end

	local Check = 0
	local Limit = {}
	for i = 1, #CmpShape do
		table.insert(Limit,0)
	end
	local max = 0
	local index = 1

	while true do
		for k, v in pairs(CmpShape) do	
			if Limit[k] < v[1] then
				local Loop
				if Looper[k] == nil then
					Loop = v[1]
				elseif type(Looper[k]) == "number" then
					Loop = Looper[k]
				else
					Loop = math.floor(_G[Looper[k]](index))
				end
				if Loop > v[1] then
					Loop = v[1]
				elseif Loop <= 0 then
					Loop = 1
				end
			
				local l = 0	
				local j = Limit[k]+1
				while true do
					local Ret = math.floor(_G[Shape[k][3]](j))+1
					if Ret <= 1 then
						Ret = 2
					end

					if Over == 1 then
						while true do
							if RetShape[Ret] ~= nil then
								Ret = Ret+1
							else
								break
							end
						end
					end

					RetShape[Ret] = v[j+1]
					RetLoopArr[Ret] = Shape[k][2][j+1]
					RetLoopArr[1] = RetLoopArr[1] + 1

					if Ret > max then
						max = Ret
					end
					l = l + 1
					j = j + 1
					if l == Loop or j >= v[1]+1 then
						Limit[k] = j-1
						break
					end
				end

				if Limit[k] >= v[1] then
					Check = Check + 1
				end
			end
		end
		if Check == #Shape then
			break
		end
		index = index+1
	end

	local NShape = {RetShape[1]}
	local NLoopArr = {RetLoopArr[1]}
	for i = 2, max do
		if RetShape[i] ~= nil then
			table.insert(NShape,RetShape[i])
		end
		if RetLoopArr[i] ~= nil then
			table.insert(NLoopArr,RetLoopArr[i])
		end
	end
	NShape[1] = #NShape-1
	NLoopArr[1] = #NLoopArr-1

	local RetShape = {}
	for k, v in pairs(NShape) do
		if type(v) == "number" then
			table.insert(RetShape,0)
		else
			for p, q in pairs(v) do
				table.insert(RetShape,q)
				RetShape[1] = RetShape[1] + 1
			end
		end
	end

	return RetShape, NLoopArr
end

function CS_TSplit(Shape,Preset,Looper,Overwrite) -- {N,f(i)} : 1~N -> f(i)를 추가함
	local CmpShape = {Shape[1][1]}
	local index = 1
	for i = 1, Shape[2][1] do
		local TempArr = {}
		for j = 1, Shape[2][i+1] do
			table.insert(TempArr,Shape[1][index+1])
			index = index+1
			if index > Shape[1][1] then break end
		end
		table.insert(CmpShape,TempArr)
		if index > Shape[1][1] then break end
	end

	local Over = 0
	if Overwrite == nil or Overwrite == 0 then
		Over = 0
	elseif type(Overwrite) == "number" then 
		Over = Overwrite
	end
	if Over > 0 then
		Over = 1
	elseif Over < 0 then
		Over = -1
	else
		Over = 0
	end

	local Loop = 0
	if Looper == nil or Looper == 0 then
		Loop = 0
	else
		Loop = 1
	end

	local N = Preset[1]
	local Func = Preset[2]
	local Rep = {}
	local RetShape = {0}
	local RetLoopArr = {0}
	for i = 1, N do
		local Fi = math.floor(_G[Func](i))
		if Looper == 1 then
			if Fi > Shape[2][1] or Fi <= 0 then
				Fi = Fi % Shape[2][1]
				if Fi == 0 then
					Fi = Shape[2][1] 
				end 
			end

			if Over == 1 then
				for k = 1, Shape[2][1] do
					if Rep[Fi] == 1 then
						Fi = Fi + 1
						if Fi > Shape[2][1] then
							Fi = Fi - Shape[2][1]
						end
					end
				end
			elseif Over == -1 then
				for k = 1, Shape[2][1] do
					if Rep[Fi] == 1 then
						Fi = Fi - 1
						if Fi <= 0 then
							Fi = Fi + Shape[2][1]
						end
					end
				end
			end

			if Rep[Fi] == nil then
				table.insert(RetShape,CmpShape[Fi+1])
				table.insert(RetLoopArr,Shape[2][Fi+1])
				RetLoopArr[1] = RetLoopArr[1] + 1
				if Over ~= 0 then
					Rep[Fi] = 1
				end
			end
		else
			if Over == 1 then
				for k = 1, Shape[2][1] do
					if Rep[Fi] == 1 then
						Fi = Fi + 1
					end
				end
			elseif Over == -1 then
				for k = 1, Shape[2][1] do
					if Rep[Fi] == 1 then
						Fi = Fi - 1
					end
				end
			end

			if not(Fi > Shape[2][1] or Fi <= 0) then
				if Rep[Fi] == nil then
					table.insert(RetShape,CmpShape[Fi+1])
					table.insert(RetLoopArr,Shape[2][Fi+1])
					RetLoopArr[1] = RetLoopArr[1] + 1
					if Over ~= 0 then
						Rep[Fi] = 1
					end
				end
			end
		end
	end

	local NShape = {}
	for k, v in pairs(RetShape) do
		if type(v) == "number" then
			table.insert(NShape,0)
		else
			for p, q in pairs(v) do
				table.insert(NShape,q)
				NShape[1] = NShape[1] + 1
			end
		end
	end

	return NShape, RetLoopArr
end

function CS_TArrange(Shape,Preset,Looper,Overwrite) -- {N,f(i),f(j)} : 1~N -> f(i)과 f(j)를 교체
	local CmpShape = {Shape[1][1]}
	local index = 1
	for i = 1, Shape[2][1] do
		local TempArr = {}
		for j = 1, Shape[2][i+1] do
			table.insert(TempArr,Shape[1][index+1])
			index = index+1
			if index > Shape[1][1] then break end
		end
		table.insert(CmpShape,TempArr)
		if index > Shape[1][1] then break end
	end

	local Over = {0,0}
	if Overwrite == nil or Overwrite == 0 then
		Over = {0,0}
	elseif type(Overwrite) == "number" then 
		Over = {Overwrite,Overwrite}
	else
		Over[1] = Overwrite[1]
		Over[2] = Overwrite[2]
	end
	if Over[1] > 0 then
		Over[1] = 1
	elseif Over[1] < 0 then
		Over[1] = -1
	else
		Over[1] = 0
	end
	if Over[2] > 0 then
		Over[2] = 1
	elseif Over[2] < 0 then
		Over[2] = -1
	else
		Over[2] = 0
	end

	local Loop = 0
	if Looper == nil or Looper == 0 then
		Loop = 0
	else
		Loop = 1
	end

	local RetShape = {CmpShape[1]}
	for i = 1, Shape[2][1] do
		table.insert(RetShape,CmpShape[i+1])
	end
	local RetLoopArr = {Shape[2][1]}
	for i = 1, Shape[2][1] do
		table.insert(RetLoopArr,Shape[2][i+1])
	end

	local N = Preset[1]
	local Funci = Preset[2]
	local Funcj = Preset[3]
	local Repi = {}
	local Repj = {}
	for i = 1, N do
		local Fi = math.floor(_G[Funci](i))
		local Fj = math.floor(_G[Funcj](i))
		if Looper == 1 then
			if Fi > Shape[2][1] or Fi <= 0 then
				Fi = Fi % Shape[2][1] 
				if Fi == 0 then
					Fi = Shape[2][1] 
				end
			end
			if Fj > Shape[2][1] or Fj <= 0 then
				Fj = Fj % Shape[2][1] 
				if Fj == 0 then
					Fj = Shape[2][1] 
				end
			end

			if Over[1] == 1 then
				for k = 1, Shape[2][1] do
					if Repi[Fi] == 1 then
						Fi = Fi + 1
						if Fi > Shape[2][1] then
							Fi = Fi - Shape[2][1]
						end
					end
				end
			elseif Over[1] == -1 then
				for k = 1, Shape[2][1] do
					if Repi[Fi] == 1 then
						Fi = Fi - 1
						if Fi <= 0 then
							Fi = Fi + Shape[2][1]
						end
					end
				end
			end

			if Over[2] == 1 then
				for k = 1, Shape[2][1] do
					if Repj[Fj] == 1 then
						Fj = Fj + 1
						if Fj > Shape[2][1] then
							Fj = Fj - Shape[2][1]
						end
					end
				end
			elseif Over[2] == -1 then
				for k = 1, Shape[2][1] do
					if Repj[Fj] == 1 then
						Fj = Fj - 1
						if Fj <= 0 then
							Fj = Fj + Shape[2][1]
						end
					end
				end
			end

			if Repi[Fi] == nil and Repj[Fj] == nil then
				local Temp = RetShape[Fi+1]
				RetShape[Fi+1] = RetShape[Fj+1]
				RetShape[Fj+1] = Temp
				Temp = RetLoopArr[Fi+1]
				RetLoopArr[Fi+1] = RetLoopArr[Fj+1]
				RetLoopArr[Fj+1] = Temp

				if Over[1] ~= 0 then
					Repi[Fi] = 1
				end
				if Over[2] ~= 0 then
					Repj[Fj] = 1
				end
			end
		else
			if Over[1] == 1 then
				for k = 1, Shape[2][1] do
					if Repi[Fi] == 1 then
						Fi = Fi + 1
					end
				end
			elseif Over[1] == -1 then
				for k = 1, Shape[2][1] do
					if Repi[Fi] == 1 then
						Fi = Fi - 1
					end
				end
			end

			if Over[2] == 1 then
				for k = 1, Shape[2][1] do
					if Repj[Fj] == 1 then
						Fj = Fj + 1
					end
				end
			elseif Over[2] == -1 then
				for k = 1, Shape[2][1] do
					if Repj[Fj] == 1 then
						Fj = Fj - 1
					end
				end
			end

			if not(Fi > Shape[2][1] or Fi <= 0 or Fj > Shape[2][1] or Fj <= 0) then
				if Repi[Fi] == nil and Repj[Fj] == nil then
					local Temp = RetShape[Fi+1]
					RetShape[Fi+1] = RetShape[Fj+1]
					RetShape[Fj+1] = Temp
					Temp = RetLoopArr[Fi+1]
					RetLoopArr[Fi+1] = RetLoopArr[Fj+1]
					RetLoopArr[Fj+1] = Temp
					if Over[1] ~= 0 then
						Repi[Fi] = 1
					end
					if Over[2] ~= 0 then
						Repj[Fj] = 1
					end
				end
			end
		end
	end

	local NShape = {}
	for k, v in pairs(RetShape) do
		if type(v) == "number" then
			table.insert(NShape,v)
		else
			for p, q in pairs(v) do
				table.insert(NShape,q)
			end
		end
	end

	return NShape, RetLoopArr
end

function CS_BMPConvert(Shape,FileName,Xpx,Ypx,Limit) -- Shape -> GRP 
	if Limit == nil then
		Limit = 100000000
	end
	local NShape = CS_RatioXY(Shape,1/Xpx,1/Ypx)

	local Xmin = CS_GetXmin(NShape)
	local Ymin = CS_GetYmin(NShape)

	NShape = CS_MoveXY(NShape,-Xmin,-Ymin)
	NShape = CS_Round(NShape,0)

	local XMax = CS_GetXmax(NShape)
	local YMax = CS_GetYmax(NShape)

	local FilePath = FileDirectory..FileName..".BMP"
	local GRPFile = io.open(FilePath, "wb")

	local XNum = math.floor(XMax)
	local YNum = math.floor(YMax)
	
	local XFill = math.ceil(3*(XNum+1)/4)*4

	-- Write BMP Header
	GRPFile:write("B") -- bfType
	GRPFile:write("M") -- bfType
	GRPFile:write(string.char(_ParseDW(14+40+XFill*(YNum+1)))) -- bfSize
	GRPFile:write(string.char(_ParseDW(0))) -- bfReserved1 & bfReserved2
	GRPFile:write(string.char(_ParseDW(14+40))) -- bfOffBits

	GRPFile:write(string.char(_ParseDW(40))) -- biSize
	GRPFile:write(string.char(_ParseDW(XNum+1))) -- biWidth
	GRPFile:write(string.char(_ParseDW(YNum+1))) -- biHeight
	GRPFile:write(string.char(_ParseW(1))) -- biPlanes
	GRPFile:write(string.char(_ParseW(24))) -- biBitCount
	GRPFile:write(string.char(_ParseDW(0))) -- biCompression
	GRPFile:write(string.char(_ParseDW(XFill*(YNum+1)))) -- biSizeImage

	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biXPelsPerMeter
	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biYPelsPerMeter
	GRPFile:write(string.char(_ParseDW(2))) -- biClrUsed
	GRPFile:write(string.char(_ParseDW(2))) -- biClrImportant

	if (YNum+1)*XFill >= Limit then
		BMPConvert_Limit_Overflow()
	end

	for i = 0, YNum, 1 do
		for j = 0, XFill-1, 1 do
			GRPFile:write(string.char(0))
		end
	end
	
	for k = 2, NShape[1]+1 do
		GRPFile:seek("set",54+3*NShape[k][1]+((YNum)-NShape[k][2])*XFill)
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
	end

	io.close(GRPFile)
end

function CS_BMPConvertX(Shape,FileName,TargetXpx,TargetYpx,Limit) -- Shape -> GRP 
	if Limit == nil then
		Limit = 100000000
	end
	TargetXpx = TargetXpx - 1
	TargetYpx = TargetYpx - 1
	local XSize = CS_GetXmax(Shape)-CS_GetXmin(Shape)
	local YSize = CS_GetYmax(Shape)-CS_GetYmin(Shape)

	local Xpx = (TargetXpx)/XSize
	local Ypx = (TargetYpx)/YSize
	local NShape = CS_RatioXY(Shape,Xpx,Ypx)

	local Xmin = CS_GetXmin(NShape)
	local Ymin = CS_GetYmin(NShape)

	NShape = CS_MoveXY(NShape,-Xmin,-Ymin)
	NShape = CS_Round(NShape,0)

	local XMax = CS_GetXmax(NShape)
	local YMax = CS_GetYmax(NShape)

	local FilePath = FileDirectory..FileName..".BMP"
	local GRPFile = io.open(FilePath, "wb")

	local XNum = math.floor(XMax)
	local YNum = math.floor(YMax)
	
	
	local XFill = math.ceil(3*(XNum+1)/4)*4
	-- Write BMP Header
	GRPFile:write("B") -- bfType
	GRPFile:write("M") -- bfType
	GRPFile:write(string.char(_ParseDW(14+40+XFill*(YNum+1)))) -- bfSize
	GRPFile:write(string.char(_ParseDW(0))) -- bfReserved1 & bfReserved2
	GRPFile:write(string.char(_ParseDW(14+40))) -- bfOffBits

	GRPFile:write(string.char(_ParseDW(40))) -- biSize
	GRPFile:write(string.char(_ParseDW(XNum+1))) -- biWidth
	GRPFile:write(string.char(_ParseDW(YNum+1))) -- biHeight
	GRPFile:write(string.char(_ParseW(1))) -- biPlanes
	GRPFile:write(string.char(_ParseW(24))) -- biBitCount
	GRPFile:write(string.char(_ParseDW(0))) -- biCompression
	GRPFile:write(string.char(_ParseDW(XFill*(YNum+1)))) -- biSizeImage

	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biXPelsPerMeter
	GRPFile:write(string.char(_ParseDW(0x2E20)))-- biYPelsPerMeter
	GRPFile:write(string.char(_ParseDW(2))) -- biClrUsed
	GRPFile:write(string.char(_ParseDW(2))) -- biClrImportant

	if (YNum+1)*XFill >= Limit then
		BMPConvert_Limit_Overflow()
	end

	for i = 0, YNum, 1 do
		for j = 0, XFill-1, 1 do
			GRPFile:write(string.char(0))
		end
	end
	
	for k = 2, NShape[1]+1 do
		GRPFile:seek("set",54+3*NShape[k][1]+((YNum)-NShape[k][2])*XFill)
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
		GRPFile:write(string.char(0xFF))
	end

	io.close(GRPFile)
end

--[[ 미구현 함수들 (Update 예정)
 Include_CVPaint
 CVPlot
 CV_
 LiAtLeast LiAtMost LiAbove LiBelow
 CD__ScanW
 CX_ConvertRTP <-> CX_ConvertXYZ
 CX_RotateRTP (구면좌표계)
 CB_Arrange
 CB_Mix
]]--

--[[
CVPlotFArr = {}
CVPlotNum = {}

function CVPlot(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,Prefunc,PlayerID,Condition,PerAction,Preserve)
	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId,Location = ConvertLocation(Location)
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CD = CAPlotVarAlloc+6
	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}

	local TempAct = {}
	local PlotArr = {}
	CJump(PlayerID,CAPlotJumpAlloc)
		if type(Shape[1]) ~= "number" then
			CVPlotNum = {}
			for i = 1, #Shape do
				table.insert(TempAct,{})
				local TempArr = {}
				for j = 2, Shape[i][1]+1 do
					table.insert(TempArr,Shape[i][j][1])
					table.insert(TempArr,Shape[i][j][2])
				end
				table.insert(PlotArr,f_GetFileWArrptrN(PlayerID,TempArr,4,1))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				table.insert(CVPlotNum,Shape[i][1])
			end
		else
			local TempArr = {}
			for i = 2, Shape[1]+1 do
				table.insert(TempArr,Shape[i][1])
				table.insert(TempArr,Shape[i][2])
			end
			PlotArr = f_GetFileWArrptrN(PlayerID,TempArr,4,1)
			table.insert(TempAct,SetCVar("X",CA[10],SetTo,Shape[1]))
			CVPlotNum = Shape[1]
		end
		CVPlotFArr = PlotArr

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

		CVariable(PlayerID,CAPlotVarAlloc+10)
		CVariable(PlayerID,CAPlotVarAlloc+11)
		CVariable(PlayerID,CAPlotVarAlloc+12)
		CVariable(PlayerID,CAPlotVarAlloc+13)
		CVariable(PlayerID,CAPlotVarAlloc+14)
		CVariable(PlayerID,CAPlotVarAlloc+15)
		CB = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		CAPlotVarAlloc = CAPlotVarAlloc + 3
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1

	CAPlotDataArr = {CAPlotVarAlloc-17,CAPlotVarAlloc-16,CAPlotVarAlloc-15,CAPlotVarAlloc-14,CAPlotVarAlloc-13,CAPlotVarAlloc-12,CAPlotVarAlloc-11,CAPlotVarAlloc-10,CAPlotVarAlloc-9,CAPlotVarAlloc-8,CAPlotVarAlloc-7,CAPlotVarAlloc-6,CAPlotVarAlloc-5,CAPlotVarAlloc-4}
	CAPlotPlayerID = PlayerID
	CAPlotCreateArr = {CAPlotVarAlloc-3,CAPlotVarAlloc-2,CAPlotVarAlloc-1,CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9,CAPlotVarAlloc+10,CAPlotVarAlloc+11,CAPlotVarAlloc+12}
	CAPlotVarAlloc = CAPlotVarAlloc + 13
	if Prefunc ~= nil then -- CB_Func 사용
		_G[Prefunc]()
	end

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

	Trigger {players = {PlayerID},conditions = {Label(CD)},flag = {Preserved}}
	if type(Shape[1]) ~= "number" then
		for i = 1, #Shape do
			TriggerX(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{Preserved})
		end
	else
		DoActionsX(PlayerID,TempAct)
	end

	NWhileX(PlayerID,{CVar("X",CA[2],Exactly,0),Condition})
		NIfX(PlayerID,{TCVar("X",CA[4],AtMost,Vi(CA[5],-1)),TCVar("X",CA[6],AtMost,V(CA[10]))})
			if type(Shape[1]) ~= "number" then
				CIfX(PlayerID,CVar("X",CA[1],Exactly,1))
				for i = 1, #Shape do
					f_LMovX(PlayerID,{V(CA[8]),V(CA[9])},WArr(PlotArr[i],V(CA[6])))
					if i ~= #Shape then
						CElseIfX(CVar("X",CA[1],Exactly,i+1))
					end
				end
				CIfXEnd()
			else
				f_LMovX(PlayerID,{V(CA[8]),V(CA[9])},WArr(PlotArr,V(CA[6])))
			end
	-------------------------------------------------------------------------
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
			CDoActions(PlayerID,{TCreateUnit(V(CB[1]),V(CB[2]),Location,V(CB[3])),SetCVar("X",CA[4],Add,1),SetCVar("X",CA[6],Add,1),PerAction})
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
	NWhileXEnd()
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
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}, PlotArr
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	CVPlotFArr = {}
	CVPlotNum = {}
	return Ret
end

function CV_MoveXY(X,Y,Shape,RetShape)
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local FA = CVPlotFArr
	local Num = CVPlotNum
	STPopTrigArr(PlayerID)
	DoActionsX(PlayerID,{SetCVar("X",CB[5],SetTo,0),SetCtrig1X("X",CA[7],0x15C,RetShape,SetTo,0)})

	CWhile(PlayerID,{CVar("X",CB[5],AtMost,Num[Shape]-1),CtrigX("X",CA[7],0x15C,RetShape,AtMost,Num[RetShape]-1)})
		f_LMovX(PlayerID,{V(CB[6]),V(CB[7])},WArr(FA[Shape],V(CB[5])))
		
		CAdd(PlayerID,V(CB[6]),X)
		CAdd(PlayerID,V(CB[7]),Y) 

		f_LMovX(PlayerID,WArr(FA[RetShape],V(CB[5])),{V(CB[6]),V(CB[7])})
	CWhileEnd(SetCVar("X",CB[5],Add,1))
end

]]--