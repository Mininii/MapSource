



-- ↓ Prev functions (v1.0) ---------------------------------------------------------------------------------------------------------------------

function CreateUnitPolygon(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main
		   		
		   		x1 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
		   		x2 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
		   		y1 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
		   		y2 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
		   		
		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitPolygonWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main
		   		
		   		x1 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
		   		x2 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
		   		y1 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
		   		y2 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
		   		
		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitPolygonSafe(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1
	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0

				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main
		   		
		   		x1 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
		   		x2 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
		   		y1 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
		   		y2 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)

		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(dX-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(dX-65536)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(dY-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(dY-65536)+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(65536-dX)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(65536-dX)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(65536-dY)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(65536-dY)-SizeofLoc))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 


	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitPolygonSafeWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1
	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0

				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main
		   		
		   		x1 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
		   		x2 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
		   		y1 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
		   		y2 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)

		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(dX-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(dX-65536)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(dY-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(dY-65536)+SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(65536-dX)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(65536-dX)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(65536-dY)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(65536-dY)-SizeofLoc))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 


	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitLine(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	dX = 0
	dY = 0
	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
	table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
	Level = 2
	Remain = Remain - 1

	while true do

		if Remain == 0 then break end
		   
		Case = Points
		while true do

			if Case == 0 then break end

			dX = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			dY = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))

			table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
			table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
			table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
			table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
			table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
					
			Case = Case - 1

		end

		Remain = Remain - 1
		Level = Level + 1

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitLineWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	dX = 0
	dY = 0
	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
	table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
	Level = 2
	Remain = Remain - 1

	while true do

		if Remain == 0 then break end
		   
		Case = Points
		while true do

			if Case == 0 then break end

			dX = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			dY = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))

			table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
			table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
			table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
			table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
			table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
					
			Case = Case - 1

		end

		Remain = Remain - 1
		Level = Level + 1

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitLineSafe(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1

	dX = 0
	dY = 0
	table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
	table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
	table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
	Level = 2
	Remain = Remain - 1

	while true do

		if Remain == 0 then break end
		   
		Case = Points
		while true do

			if Case == 0 then break end

			dX = ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			dY = ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))

			table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,dX-SizeofLoc))
			table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,dX+SizeofLoc))
			table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,dY-SizeofLoc))
			table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,dY+SizeofLoc))
			table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
			table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc-dX))
			table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize-dX))
			table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc-dY))
			table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize-dY))
					
			Case = Case - 1

		end

		Remain = Remain - 1
		Level = Level + 1

	end 

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitLineSafeWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,Points,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1

	dX = 0
	dY = 0
	table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
	table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
	table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
	Level = 2
	Remain = Remain - 1

	while true do

		if Remain == 0 then break end
		   
		Case = Points
		while true do

			if Case == 0 then break end

			dX = ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			dY = ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))

			table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,dX-SizeofLoc))
			table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,dX+SizeofLoc))
			table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,dY-SizeofLoc))
			table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,dY+SizeofLoc))
			table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
			table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc-dX))
			table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize-dX))
			table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc-dY))
			table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize-dY))
					
			Case = Case - 1

		end

		Remain = Remain - 1
		Level = Level + 1

	end 

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitStar(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,Points,StarAngle,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local StarRadius = Radius * (math.cos(math.rad(180/Points))-math.sin(math.rad(180/Points))/math.tan(math.rad(StarAngle/2)))
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	Points = Points * 2

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main

		   		if Case%2 == 0 then
			   		x1 = LocX + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = LocY + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	else
			   		x1 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = LocX + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = LocY + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	end

		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
		   		
		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitStarWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,Points,StarAngle,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local StarRadius = Radius * (math.cos(math.rad(180/Points))-math.sin(math.rad(180/Points))/math.tan(math.rad(StarAngle/2)))
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	Points = Points * 2

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main

		   		if Case%2 == 0 then
			   		x1 = LocX + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = LocY + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	else
			   		x1 = LocX + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = LocX + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = LocY + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = LocY + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	end

		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
		   		
		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitStarSafe(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,Points,StarAngle,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local StarRadius = Radius * (math.cos(math.rad(180/Points))-math.sin(math.rad(180/Points))/math.tan(math.rad(StarAngle/2)))
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1

	Points = Points * 2

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main

		   		if Case%2 == 0 then
			   		x1 = 65536 + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = 65536 + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	else
			   		x1 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = 65536 + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = 65536 + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	end

		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
		   		
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(dX-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(dX-65536)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(dY-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(dY-65536)+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(65536-dX)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(65536-dX)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(65536-dY)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(65536-dY)-SizeofLoc))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitStarSafeWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,Points,StarAngle,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Distance = Radius
	local StarRadius = Radius * (math.cos(math.rad(180/Points))-math.sin(math.rad(180/Points))/math.tan(math.rad(StarAngle/2)))
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1

	Points = Points * 2

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
				Main = 2
				Level = 2
				Remain = Remain - 1
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   		end
		   		Case = 1
		   		while true do
			   		if Main <= ((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1) then break end
			   		Case = Case + 1
			   	end

		   		Pts = (((Level*Level-3*Level+2)*Points)/2 + 1 + Case*(Level-1)) - Main

		   		if Case%2 == 0 then
			   		x1 = 65536 + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = 65536 + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	else
			   		x1 = 65536 + ((Level-1) * Distance) * math.cos(math.rad(Angle+(360*(Case-1))/Points))
			   		x2 = 65536 + ((Level-1) * StarRadius) * math.cos(math.rad(Angle+(360*Case)/Points))
			   		y1 = 65536 + ((Level-1) * Distance) * math.sin(math.rad(Angle+(360*(Case-1))/Points))
			   		y2 = 65536 + ((Level-1) * StarRadius) * math.sin(math.rad(Angle+(360*Case)/Points))
			   	end

		   		dX = ((Pts+1)*x1+(Level-Pts-2)*x2) / (Level-1)
		   		dY = ((Pts+1)*y1+(Level-Pts-2)*y2) / (Level-1)
		   		
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(dX-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(dX-65536)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(dY-65536)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(dY-65536)+SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,(65536-dX)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,(65536-dX)-SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,(65536-dY)+SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,(65536-dY)-SizeofLoc))
				Remain = Remain - 1
				Main = Main + 1

			end

	end 

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitFlower(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,PolarPointsNumerator,PolarPointsDenominator,Partition,RadiusConstant,CenterPoint,Halfdomain,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Draw = 0
	if Halfdomain == 0 then
		Draw = 360
	else
		Draw = 180
	end

	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	local Points = Partition
	local Part = Partition

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				if CenterPoint == 1 then
					table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
					table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
					table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
					table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
					table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
					Remain = Remain - 1
				end
				Main = 2
				Level = 2
				Case = 1
				Part = Partition
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   			Case = 1
		   			Part = (Level-1)*Partition
		   		end
		   		
		   		dX = LocX + (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.cos(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))
		   		dY = LocY + (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.sin(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))
		   		
		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				Remain = Remain - 1
				Main = Main + 1
				Case = Case + 1

			end

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitFlowerWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,LocX,LocY,PerUnit,SizeofLoc,Radius,Angle,PolarPointsNumerator,PolarPointsDenominator,Partition,RadiusConstant,CenterPoint,Halfdomain,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Draw = 0
	if Halfdomain == 0 then
		Draw = 360
	else
		Draw = 180
	end

	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0

	local Points = Partition
	local Part = Partition

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				if CenterPoint == 1 then
					table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX+dX-SizeofLoc))
					table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX+dX+SizeofLoc))
					table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY+dY-SizeofLoc))
					table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY+dY+SizeofLoc))
					table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer,Properties))
					Remain = Remain - 1
				end
				Main = 2
				Level = 2
				Case = 1
				Part = Partition
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   			Case = 1
		   			Part = (Level-1)*Partition
		   		end
		   		
		   		dX = LocX + (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.cos(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))
		   		dY = LocY + (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.sin(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))
		   		
		   		table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,dY+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				Remain = Remain - 1
				Main = Main + 1
				Case = Case + 1

			end

	end 

	table.insert(X,SetMemory(0x58DC60+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC68+0x14*LocId,SetTo,LocX))
	table.insert(X,SetMemory(0x58DC64+0x14*LocId,SetTo,LocY))
	table.insert(X,SetMemory(0x58DC6C+0x14*LocId,SetTo,LocY))

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitFlowerSafe(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,PolarPointsNumerator,PolarPointsDenominator,Partition,RadiusConstant,CenterPoint,Halfdomain,Preserve)
    local LocId,PLocId = ConvertLocation(LocId)
	local Draw = 0
	if Halfdomain == 0 then
		Draw = 360
	else
		Draw = 180
	end

	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1

	local Points = Partition
	local Part = Partition

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				if CenterPoint == 1 then
					table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
					table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
					table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
					table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
					table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
					table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
					table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
					table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
					table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
					Remain = Remain - 1
				end
				Main = 2
				Level = 2
				Case = 1
				Part = Partition
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   			Case = 1
		   			Part = (Level-1)*Partition
		   		end
		   		
		   		dX = (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.cos(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))
		   		dY = (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.sin(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))

				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,dY+SizeofLoc))
				table.insert(X,CreateUnit(PerUnit,UnitId,PLocId,ForPlayer))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc-dX))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize-dX))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc-dY))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize-dY))
				Remain = Remain - 1
				Main = Main + 1
				Case = Case + 1

			end

	end 

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end

function CreateUnitFlowerSafeWithProperties(PlayerID,Condition,Number,UnitId,LocId,ForPlayer,PerUnit,SizeofLoc,Radius,Angle,PolarPointsNumerator,PolarPointsDenominator,Partition,RadiusConstant,CenterPoint,Halfdomain,Preserve,Properties)
    local LocId,PLocId = ConvertLocation(LocId)
	local Draw = 0
	if Halfdomain == 0 then
		Draw = 360
	else
		Draw = 180
	end

	local Distance = Radius
	local X = {}
	local Main = 1
	local Level = 1
	local Remain = Number
	local x1 = 0
	local x2 = 0
	local y1 = 0
	local y2 = 0
	local Pts = 0
	local Case = 0
	SizeofLoc = bit32.band(SizeofLoc, 0xFFFFFFFF)
	local TempSize = 0xFFFFFFFF - SizeofLoc + 1

	local Points = Partition
	local Part = Partition

	while true do
			if Remain == 0 then break end
			if Main == 1 then
				dX = 0
				dY = 0
				if CenterPoint == 1 then
					table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,TempSize))
					table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,SizeofLoc))
					table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,TempSize))
					table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,SizeofLoc))
					table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
					table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc))
					table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize))
					table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc))
					table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize))
					Remain = Remain - 1
				end
				Main = 2
				Level = 2
				Case = 1
				Part = Partition
			else
				while true do
		   			if Main <= (Level*(Level-1)*Points)/2 + 1 then break end
		   			Level = Level + 1
		   			Case = 1
		   			Part = (Level-1)*Partition
		   		end
		   		
		   		dX = (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.cos(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))
		   		dY = (((Level-1) * Distance)*(RadiusConstant+math.sin(math.rad((PolarPointsNumerator*(Angle+(PolarPointsDenominator*Draw*(Case-1))/Part))/PolarPointsDenominator)))) * (math.sin(math.rad((PolarPointsDenominator*Draw*(Case-1))/Part)))

				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,dX-SizeofLoc))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,dX+SizeofLoc))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,dY-SizeofLoc))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,dY+SizeofLoc))
				table.insert(X,CreateUnitWithProperties(PerUnit,UnitId,PLocId,ForPlayer,Properties))
				table.insert(X,SetMemory(0x58DC60+0x14*LocId,Add,SizeofLoc-dX))
				table.insert(X,SetMemory(0x58DC68+0x14*LocId,Add,TempSize-dX))
				table.insert(X,SetMemory(0x58DC64+0x14*LocId,Add,SizeofLoc-dY))
				table.insert(X,SetMemory(0x58DC6C+0x14*LocId,Add,TempSize-dY))
				Remain = Remain - 1
				Main = Main + 1
				Case = Case + 1

			end

	end 

	local k = {}

	while true do
		if #X / 63 <= 0 then break end

		for i = 1, 63 do
			table.insert(k, X[i])
		end

		if Preserve ~= 0 then
			table.insert(k, PreserveTrigger())
		end

		Trigger { 
			players = {PlayerID},
			
			conditions = {
				Condition,
			},
			actions = {
				k,
			},
		}

		if Preserve ~= 0 then
			table.remove(k,1)
		end

		for i = 1, 63 do
			table.remove(k,1)
			table.remove(X,1)
		end

	end
	
end