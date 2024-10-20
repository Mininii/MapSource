function LairHeroSpawnSet(Player,Level,UnitID1,UnitID2,SizeofPolygon,Radius,Angle,Points,Sw1,Sw2)
	local Sw1Status1 = Sw1
	local Sw1Status2 = Sw2
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
	local Sw1Status1 = Sw2
	local Sw1Status2 = Sw1
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
end

function HiveHeroSpawnSet(Player,Level,UnitID1,UnitID2,SizeofPolygon,Radius,Angle,Points,Sw1,Sw2)
	local Sw1Status1 = Sw1
	local Sw1Status2 = Sw2
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
	local Sw1Status1 = Sw2
	local Sw1Status2 = Sw1
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID1})
	CreateUnitPolygonSafe2Gun(Player,{DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)},1+(Points*(SizeofPolygon*(SizeofPolygon+1)/2)),23,32,Radius,Angle,Points,1,P8,{1,UnitID2})
end

function HeroSpawnSetForBYD(Player,Level,UnitID1,UnitID2,Sw1,Sw2,BYDOutPut)
	local Sw1Status1 = Sw1
	local Sw1Status2 = Sw2
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID1)}, {preserved})
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,Level*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+1)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID2)}, {preserved})
	local Sw1Status1 = Sw2
	local Sw1Status2 = Sw1
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status1)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID1)}, {preserved})
	TriggerX(Player, {DeathsX(CurrentPlayer,AtLeast,(Level+2)*65536,0,0xFF0000),DeathsX(CurrentPlayer,AtMost,(Level+3)*65536,0,0xFF0000),Switch("Switch 1",Sw1Status2)}, {SetCVar(Player,BYDOutPut,SetTo,UnitID2)}, {preserved})
end

function DisplayCTextToAll(Player,conditions,Actions,Text,RotateActions,RotatePlayers,Flag) 
	if type(Text) == "string" then
		FlagT = {}
		if Flag == 1 then
			FlagT = {preserved}
		end
		local Y = {Actions}
		local Z = {RotateActions}
		local A = {}
		table.insert(A,DisplayTextX(Text,4))
		for j, y in pairs(RotateActions) do
			table.insert(A,y)
		end
		Trigger2X(Player, conditions, {RotatePlayer(A,RotatePlayers,Player),Y}, FlagT)

	else
		local Y = {Actions}
		local Z = {RotateActions}
		local A = {}
		table.insert(A,DisplayTextX(UnivToString,4))
		for j, y in pairs(RotateActions) do
			table.insert(A,y)
		end
	
		if Flag == 1 then
			CIf(Player,conditions)
		else
			CIfOnce(Player,conditions)
		end
	
		f_Memcpy(Player,UnivStrPtr,_TMem(Arr(Text[3],0),"X","X",1),Text[2])
		DoActionsX(Player,{
				RotatePlayer(A,RotatePlayers,Player),Y
		})
		f_Memcpy(Player,UnivStrPtr,_TMem(Arr(StrReset[3],0),"X","X",1),StrReset[2])
		CIfEnd()
	end
end

function TemRotate()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CAdd(FP,TemX,Dt)
	CDiv(FP,TemAngle,TemX,270)
	CA_Rotate(TemAngle) -- SX 만큼 회전
end
function TemRotate2()
	local PlayerID = CAPlotPlayerID
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CDiv(FP,TemAngle2,_Mul(B6_RT,10),333)
	CA_Rotate(TemAngle2) -- SX 만큼 회전
end


-- function CAfunc(Table) local CA = CAPlotDataArr -- Custom Code Section -- end
function CAPlot(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve,CAfunc2)
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
				Trigger2X(PlayerID,CVar("X",CA[1],Exactly,i),TempAct[i],{preserved})
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
	NWhileXEnd()
	CJumpEnd(PlayerID,CAPlotJumpAlloc)
	CAPlotJumpAlloc = CAPlotJumpAlloc + 1
	DoActionsX(PlayerID,SetCVar("X",CA[2],Subtract,1))
	if Preserve ~= nil then
		if type(Preserve) == "number" then
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},SetCVar("X",CA[6],SetTo,1),{preserved})
		else
			CTrigger(PlayerID,{TCVar("X",CA[6],AtLeast,Vi(CA[10],1))},{SetCVar("X",CA[6],SetTo,1),Preserve},{preserved})
		end
	end
	local Ret = {CA[1],CA[2],CA[3],CA[4],CA[5],CA[6],CB[1],CB[2],CB[3]}
	CAPlotCreateArr = {}
	CAPlotDataArr = {}
	CAPlotPlayerID = {}
	return Ret
end