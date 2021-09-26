
function TestSet(val)
	if val == 1 then 
		Limit = 1
		TestStart = 0
	elseif val == 2 then
		Limit = 1
		TestStart = 1
	else
		Limit = 0
		TestStart = 0
	end
end
function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end

function CunitCtrig_Part4_EX(LoopIndex,Conditions,Actions,ExCunitArr)
	MoveCpValue = 0
	local X = {}
	for k, v in pairs(ExCunitArr) do
		table.insert(X,SetCVar("X",v[2],SetTo,0))
	end
	Trigger { -- Cunit Calc Main
		players = {ParsePlayer(PlayerID)},
		conditions = { 
			Label(0);
			Conditions,
		},
		actions = {
			X,
			SetCtrigX("X","X",0x4,0,SetTo,"X",CCArr[CCptr],0,0,0);
			SetCtrigX("X",CCArr[CCptr]+1,0x4,0,SetTo,"X","X",0,0,1);
			SetCtrigX("X",CCArr[CCptr],0x158,0,SetTo,"X","X",0x4,1,0);
			SetCtrigX("X",CCArr[CCptr],0x15C,0,SetTo,"X","X",0,0,1);
			SetMemory(0x6509B0,SetTo,19025 + 84 * LoopIndex);
			Actions,
			},
		flag = {Preserved}
	}		
end

function f_GSend(UnitID,Actions)
	CallTriggerX(FP,G_Send,{DeathsX(CurrentPlayer,Exactly,UnitID,0,0xFF)},Actions)
	end
	
function Convert_CPosXY(Value)
	if Value ~= nil then
	CDoActions(FP,{
		TSetCVar(FP,CPos[2],SetTo,Value),
		SetNext("X",Call_CPosXY,0),SetNext(Call_CPosXY+1,"X",1)
	})
	else
		CallTrigger(FP,Call_CPosXY)
	end
	return CPosX,CPosY
end

function Gun_SetLine(Line,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	return TSetMemoryX(_Add(G_TempH,(Line*0x20)/4),Type,Value,Mask)
end


function Gun_SetLineX(Line,Type,Value)
	return TSetMemory(_Add(G_TempH,_Mul(Line,_Mov(0x20/4))),Type,Value)
end

function Gun_Line(Line,Type,Value,Mask)
	if Mask == nil then
		Mask = 0xFFFFFFFF
	end
	return CVar(FP,Var_TempTable[Line+1][2],Type,Value,Mask)
end

function Gun_DoSuspend()
	return TSetMemory(_Add(G_TempH,(54*0x20)/4),Add,1)
end


-- function CAfunc(Table) local CA = CAPlotDataArr -- Custom Code Section -- end
function CAPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CAfunc,PlayerID,Condition,PerAction,Preserve,CAfunc2)
	if Shape == nil then
		CS_InputError()
	end

	if Preserve == 0 then
		Preserve = nil
	end

	local LocId = Location
	if type(LocId) == "string" then
		LocId = ParseLocation(LocId)-1
	elseif type(LocId) == "number" then
		Location = Location + 1
	end
	local LocL = 0x58DC60+0x14*LocId
	local LocU = 0x58DC64+0x14*LocId
	local LocR = 0x58DC68+0x14*LocId
	local LocD = 0x58DC6C+0x14*LocId

	local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
	local CA2 = {}
	local CB = {}

	local TempAct = {}
	local PlotArrX = CA2ArrX
	local PlotArrY = CA2ArrY
	CJump(PlayerID,CAPlotJumpAlloc)
		if type(Shape[1]) ~= "number" then
			for i = 1, #Shape do
				table.insert(TempAct,{})
				for j = 1, Shape[i][1] do
					table.insert(TempAct[i],SetCVAar(VArr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
					table.insert(TempAct[i],SetCVAar(VArr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
				end
				table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
				table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
			end
		else
			for i = 1, Shape[1] do
				table.insert(TempAct,SetCVAar(VArr(PlotArrX,i),SetTo,Shape[i+1][1]))
				table.insert(TempAct,SetCVAar(VArr(PlotArrY,i),SetTo,Shape[i+1][2]))
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
			CMovX(PlayerID,V(CA[8]),VArr(PlotArrX,V(CA[6])),nil,0xFFFFFFFF,nil,1)
			CMovX(PlayerID,V(CA[9]),VArr(PlotArrY,V(CA[6])),nil,0xFFFFFFFF,nil,1)
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
	function G_CAPlot(ShapeTable)
		local X = {}
		local Y = {}
		if type(ShapeTable) == "table" then
			for i = 1, #ShapeTable do
				if type(ShapeTable[i]) ~= "string" then
					G_CAPlot_InputData_Error()
				else
					ShapeTable[i] = _G[ShapeTable[i]]
				end
			end
		elseif type(ShapeTable) ~= "string" then
			G_CAPlot_InputData_Error()
		else
			table.insert( X,ShapeTable)
			ShapeTable = _G[ShapeTable]
		end
		local G_CA_CallIndex = SetCallForward()
		Another_CAPlot_Shape = G_CA_IndexAlloc
		local CA = CAPlotForward()
		SetCall(FP)
		CMov(FP,CA_TempUID,G_CA_Main[1],nil,0xFF)
		CMov(FP,V(CA[1]),G_CA_Main[2],nil,0xFF)
		CMov(FP,V(CA[6]),G_CA_Main[3])

		CIfX(FP,CVar(FP,G_CA_Main[5][2],AtMost,0))
		if type(ShapeTable[1]) == "number" then
			CTrigger(FP,{},{SetCVar(FP,CA[5],SetTo,(ShapeTable[1]/50)+1)},1)
		else
			for j, k in pairs(ShapeTable) do
				CTrigger(FP,{CVar(FP,G_CA_Main[2][2],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
				table.insert(Y,tostring(j))
			end
		end
		CElseX()
			CMov(FP,V(CA[5]),G_CA_Main[5])
		CIfXEnd()

		CAPlot(ShapeTable,FP,nilunit,0,{0,0},1,32,{0,0,0,0,0,1},nil,FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
		CDoActions(FP,{TSetCVar(FP,G_CA_Main[3][2],SetTo,V(CA[6]))})
		SetCallEnd()
		G_CA_IndexAlloc = G_CA_IndexAlloc + 1
		table.insert(G_CA_CallStack,G_CA_CallIndex)
	end

	function CXPlot2(Shape,Owner,UnitId,Location,CenterXY,PerUnit,PlotSize,Preset,CXfunc,PlayerID,Condition,PerAction,Preserve,CXfunc2)
		if Shape == nil then
			CX_InputError()
		end
	
		if Preserve == 0 then
			Preserve = nil
		end
	
		local LocId = Location
		if type(LocId) == "string" then
			LocId = ParseLocation(LocId)-1
		elseif type(LocId) == "number" then
			Location = Location + 1
		end
		local LocL = 0x58DC60+0x14*LocId
		local LocU = 0x58DC64+0x14*LocId
		local LocR = 0x58DC68+0x14*LocId
		local LocD = 0x58DC6C+0x14*LocId
	
		local CA = {CAPlotVarAlloc,CAPlotVarAlloc+1,CAPlotVarAlloc+2,CAPlotVarAlloc+3,CAPlotVarAlloc+4,CAPlotVarAlloc+5,CAPlotVarAlloc+6,CAPlotVarAlloc+7,CAPlotVarAlloc+8,CAPlotVarAlloc+9}
		local CA2 = {}
		local CB = {}
	
		local TempAct = {}
		local PlotArrX = CA2ArrX
		local PlotArrY = CA2ArrY
		local PlotArrZ = CA2ArrZ
		CJump(PlayerID,CAPlotJumpAlloc)
			if type(Shape[1]) ~= "number" then
				for i = 1, #Shape do
					table.insert(TempAct,{})
					for j = 1, Shape[i][1] do
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrX,j),SetTo,Shape[i][j+1][1]))
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrY,j),SetTo,Shape[i][j+1][2]))
						table.insert(TempAct[i],SetCVAar(VArr(PlotArrZ,j),SetTo,Shape[i][j+1][3]))
					end
					table.insert(TempAct[i],SetCVar("X",CA[1],SetTo,0))
					table.insert(TempAct[i],SetCVar("X",CA[10],SetTo,Shape[i][1]))
				end
			else
				for i = 1, Shape[1] do
					table.insert(TempAct,SetCVAar(VArr(PlotArrX,i),SetTo,Shape[i+1][1]))
					table.insert(TempAct,SetCVAar(VArr(PlotArrY,i),SetTo,Shape[i+1][2]))
					table.insert(TempAct,SetCVAar(VArr(PlotArrZ,i),SetTo,Shape[i+1][3]))
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
				CMovX(PlayerID,V(CA[8]),VArr(PlotArrX,V(CA[6])),nil,0xFFFFFFFF,nil,1)
				CMovX(PlayerID,V(CA[9]),VArr(PlotArrY,V(CA[6])),nil,0xFFFFFFFF,nil,1)
				CMovX(PlayerID,V(CA2[1]),VArr(PlotArrZ,V(CA[6])),nil,0xFFFFFFFF,nil,1)
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
				if CXfunc2 ~= nil then
					_G[CXfunc2]() -- Z좌표는 여기서 CX_ 함수에 의해 X,Y좌표값에 영향을 미침
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