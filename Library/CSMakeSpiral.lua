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