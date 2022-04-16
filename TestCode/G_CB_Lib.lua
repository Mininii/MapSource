
function Include_G_CB_Library(StartIndex,G_CB_ArrSize,G_CB_Lines,DefCenterXYV,TRefeatXYV,ShapeTable,Repeat_CallIndex)
	if FP == nil then PushErrorMsg("Need_Define_Fixed_Player ( ex : FP = P8 )") end
f_RepeatTypeErr = "\x07『 \x08ERROR : \x04잘못된 RepeatType이 입력되었습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr = "\x07『 \x08ERROR : \x04f_Repeat에서 문제가 발생했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_RepeatErr2 = "\x07『 \x08ERROR : \x04Call_Repeat에서 잘못된 UnitID(0)을 입력받았습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
f_GunSendErrT = "\x07『 \x08ERROR \x04: G_CB_SpawnSet 목록이 가득 차 데이터를 입력하지 못했습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
G_CB_PosErr = "\x07『 \x03CAUCTION : \x04생성 좌표가 맵 밖을 벗어났습니다.\x07 』"
f_GunErrT = "\x07『 \x08ERROR \x04: G_CBPlot Not Found. \x07』"
f_GunErrT2 = "\x07『 \x08ERROR \x04: G_CBPlot Suspend Error. \x07』"
f_GunFuncT = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Suspended. \x07』"
f_GunFuncT2 = "\x07『 \x03TESTMODE OP \x04: G_CBPlot Sended. \x07』"
local Repeat_UnitIDV = CreateVar(FP)
local RepeatType = CreateVar(FP)
local G_CB_Nextptrs = CreateVar(FP)
local Spawn_TempW = CreateVar(FP)
local CreatePlayer = CreateVar(FP)
local G_CB_LineV = CreateVar(FP)
local G_CB_CUTV = CreateVar(FP)
local G_CB_SNTV = CreateVarArr(4,FP)
local G_CB_DLTV = CreateVar(FP)
local G_CB_LMTV = CreateVar(FP)
local G_CB_RPTV = CreateVar(FP)
local G_CB_Owner = CreateVar(FP)
local G_CB_EffType = CreateVar(FP)
local G_CB_XPos = CreateVar(FP)
local G_CB_YPos = CreateVar(FP)
local G_CB_FNTV = CreateVar(FP)
local TRepeatX = TRefeatXYV[1]
local TRepeatY = TRefeatXYV[2]
local G_CB_CenterX = DefCenterXYV[1]
local G_CB_CenterY = DefCenterXYV[2]

local G_CB_UnitIndex = CreateVar(FP)
local Write_SpawnSet_Jump = def_sIndex()
local G_CB_Arr_IndexAlloc = StartIndex
local G_CB_TempTable = CreateVarArr(G_CB_Lines,FP)
local G_CB_InputH = CreateVar(FP)
local G_CB_InputCVar = {}
for i = 1, G_CB_Lines do
	table.insert(G_CB_InputCVar,SetCVar(FP,G_CB_TempTable[i][2],SetTo,0))
end
table.insert(CtrigInitArr[FP+1],SetCtrigX(FP,G_CB_InputH[2],0x15C,0,SetTo,FP,StartIndex,0x15C,1,0))
local G_CB_TempH = CreateVar(FP)
local G_CB_Num = CreateVar(FP)
local G_CB_LineTemp = CreateVar(FP)
local CB_Repeat_Check = CreateCcode()
local Repeat_X = CreateVar(FP)
local Repeat_Y = CreateVar(FP)
local G_CB_WSTestStrPtr = CreateVar(FP)
local G_CB_WSTestVA = CreateVArr(5,FP)
local Call_Repeat = Repeat_CallIndex -- 유닛생성부


function f_TempRepeat(Condition,UnitID,Number,Type,Owner,CenterXY)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	

	CallTriggerX(FP,Call_Repeat,Condition,{
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		SetCVar(FP,Spawn_TempW[2],SetTo,Number),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner),
		SetCVar(FP,TRepeatX[2],SetTo,SetX),
		SetCVar(FP,TRepeatY[2],SetTo,SetY),
	})
end

function f_TempRepeatX(Condition,UnitID,Number,Type,Owner,CenterXY)
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Type == nil then Type = 0 end
	local SetX = 0 
	local SetY = 0
	if CenterXY == nil then 
		SetX = 0xFFFFFFFF
		SetY = 0xFFFFFFFF
	elseif type(CenterXY) == "table" then
		SetX = CenterXY[1]
		SetY = CenterXY[2]
	else
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Spawn_TempW[2],SetTo,Number),
		TSetCVar(FP,TRepeatX[2],SetTo,SetX),
		TSetCVar(FP,TRepeatY[2],SetTo,SetY),
		SetCVar(FP,RepeatType[2],SetTo,Type),
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner)})
	CallTriggerX(FP,Call_Repeat,Condition)
end

function f_TempRepeat2X(Condition,UnitID,Number,EffType,Owner,CenterXY,Flags)
	if Owner == nil then Owner = 0xFFFFFFFF
	elseif Owner == "CP" then Owner = 0x7FFFFFFF end
	if Type == nil then Type = 0 end
	local SetXY = {}
	if CenterXY == nil then 
		SetXY = {
		SetCVar(FP,TRepeatX[2],SetTo,0xFFFFFFFF),
		SetCVar(FP,TRepeatY[2],SetTo,0xFFFFFFFF),
		}
	elseif type(CenterXY) == "table" then
		SetXY = {
		SetCVar(FP,TRepeatX[2],SetTo,CenterXY[1]),
		SetCVar(FP,TRepeatY[2],SetTo,CenterXY[2]),
		}
	elseif CenterXY ~= "X" then 
		PushErrorMsg("TRepeat_CenterXY_Error")
	end
	CDoActions(FP,{
		TSetCVar(FP,Repeat_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Spawn_TempW[2],SetTo,Number),
		SetXY,
		SetCVar(FP,RepeatType[2],SetTo,100),
		SetCDeaths(FP,SetTo,0,CB_Repeat_Check),
		SetCVar(FP,G_CB_TempTable[15][2],SetTo,EffType),
		SetCVar(FP,G_CB_TempTable[17][2],SetTo,Flags),
		SetCVar(FP,CreatePlayer[2],SetTo,Owner)})
	CallTriggerX(FP,Call_Repeat,Condition)
end





Write_SpawnSet = SetCallForward()
SetCall(FP)


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTableTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함



CMov(FP,G_CB_LineV,0)
CJumpEnd(FP,Write_SpawnSet_Jump)

CAdd(FP,G_CB_LineTemp,G_CB_LineV,G_CB_InputH)
NIfX(FP,{TMemory(G_CB_LineTemp,AtMost,0)})

_0D = string.rep("\x0D",200)
if Limit == 1 then
	--	CIf(FP,CD(TestMode,1))
		TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunFuncT2,4)},HumanPlayers,FP)},{preserved})
		ItoDec(FP,G_CB_CUTV,VArr(G_CB_WSTestVA,0),0,nil,0)
		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
		ItoDec(FP,G_CB_RPTV,VArr(G_CB_WSTestVA,0),0,nil,0)
		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
		ItoDec(FP,G_CB_FNTV,VArr(G_CB_WSTestVA,0),0,nil,0)
		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
		ItoDec(FP,G_CB_SNTV[1],VArr(G_CB_WSTestVA,0),0,nil,0)
		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
		ItoDec(FP,G_CB_LMTV,VArr(G_CB_WSTestVA,0),0,nil,0)
		f_Movcpy(FP,G_CB_WSTestStrPtr,VArr(G_CB_WSTestVA,0),4*4)
		TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CB_WS".._0D,4)},HumanPlayers,FP)},{preserved})
	--	CIfEnd()
	
	end
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,0*(0x20/4)),SetTo,G_CB_CUTV),
	TSetMemory(_Add(G_CB_LineTemp,1*(0x20/4)),SetTo,G_CB_RPTV),
	TSetMemory(_Add(G_CB_LineTemp,2*(0x20/4)),SetTo,G_CB_FNTV),
	TSetMemory(_Add(G_CB_LineTemp,3*(0x20/4)),SetTo,G_CB_SNTV[1]),
	TSetMemory(_Add(G_CB_LineTemp,4*(0x20/4)),SetTo,G_CB_SNTV[2]),
	TSetMemory(_Add(G_CB_LineTemp,5*(0x20/4)),SetTo,G_CB_SNTV[3]),
	TSetMemory(_Add(G_CB_LineTemp,6*(0x20/4)),SetTo,G_CB_SNTV[4]),
	TSetMemory(_Add(G_CB_LineTemp,9*(0x20/4)),SetTo,G_CB_LMTV),
	TSetMemory(_Add(G_CB_LineTemp,10*(0x20/4)),SetTo,0),
	TSetMemory(_Add(G_CB_LineTemp,11*(0x20/4)),SetTo,G_CB_DLTV),
	TSetMemory(_Add(G_CB_LineTemp,12*(0x20/4)),SetTo,0),
	
	
})
CIfX(FP,{CVar(FP,G_CB_XPos[2],Exactly,0xFFFFFFFF),CVar(FP,G_CB_YPos[2],Exactly,0xFFFFFFFF)})
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_CenterX),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_CenterY)
})
CElseX()
CDoActions(FP,{
	TSetMemory(_Add(G_CB_LineTemp,7*(0x20/4)),SetTo,G_CB_XPos),
	TSetMemory(_Add(G_CB_LineTemp,8*(0x20/4)),SetTo,G_CB_YPos)
})
CIfXEnd()
NElseIfX({CVar(FP,G_CB_LineV[2],AtMost,((0x970/4)*G_CB_ArrSize-2))})
CAdd(FP,G_CB_LineV,0x970/4)
CJump(FP,Write_SpawnSet_Jump)
NElseX()

DoActions(FP,{RotatePlayer({DisplayTextX(f_GunSendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})

NIfXEnd()
SetCallEnd()










local G_CB_Suspend = CreateCcode()


local G_CB_Launch = CreateCcode()
function G_CB_Func()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	CAdd(FP,Repeat_X,V(CA[8]),G_CB_TempTable[8])
	CAdd(FP,Repeat_Y,V(CA[9]),G_CB_TempTable[9])
	CMov(FP,0x58DC60,Repeat_X)
	CMov(FP,0x58DC64,Repeat_Y)
	CMov(FP,0x58DC68,Repeat_X)
	CMov(FP,0x58DC6C,Repeat_Y)
	CMov(FP,Repeat_UnitIDV,G_CB_TempTable[1],nil,0xFF)
	CMov(FP,RepeatType,G_CB_TempTable[2],nil,0xFF)
	CMov(FP,Spawn_TempW,1)
	CallTrigger(FP,Call_Repeat,{SetCDeaths(FP,SetTo,1,CB_Repeat_Check)})
	
end
G_CB_ShapeTable = {}

--Prefunc 작동조건 : CVar("X",CA[2],Exactly,0)


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTableTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함


	if type(ShapeTable) ~= "table" then
		PushErrorMsg("ShapeData_Input_Error")
	end
	local Y = {}
	for j, k in pairs(ShapeTable) do
		if type(k) ~= "string" then
			PushErrorMsg("ShapeData_Input_Error")
		end
		table.insert(Y,_G[k])
		table.insert(G_CB_ShapeTable,k)
	end


	Load_CBPlot = SetCallForward()
	local CA = CAPlotForward()
	local X = {}
	SetCall(FP)
	DoActionsX(FP,{SetCDeaths(FP,SetTo,1,G_CB_Launch)})
	CMov(FP,V(CA[1]),G_CB_TempTable[4])
	CMov(FP,V(CA[2]),G_CB_TempTable[11])
	CMov(FP,V(CA[3]),G_CB_TempTable[12])
	CMov(FP,V(CA[6]),G_CB_TempTable[13])
	CIfX(FP,CVar(FP,G_CB_TempTable[10][2],AtMost,0))
		for j, k in pairs(Y) do
			CTrigger(FP,{CVar(FP,CA[1],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
		end
	CElseX()
		CMov(FP,V(CA[5]),G_CB_TempTable[10],nil,0xFF)
	CIfXEnd()
	CBPlot(Y,nil,FP,nilunit,0,{G_CB_TempTable[8],G_CB_TempTable[9]},1,32,{0,0,0,0,0,1},"G_CB_Func",nil,FP,nil,nil,{SetCDeaths(FP,Add,1,G_CB_Suspend)}) 
--	CAPlot2(Y,FP,nilunit,0,{G_CB_TempTable[8],G_CB_TempTable[9]},1,32,{0,0,0,0,0,1},"G_CB_Func",FP,nil,nil,{SetCDeaths(FP,Add,1,G_CB_Suspend)},"CB_Repeat")
	CDoActions(FP,{TSetCVar(FP,G_CB_TempTable[13][2],SetTo,V(CA[6])),TSetCVar(FP,G_CB_TempTable[11][2],SetTo,V(CA[2]))})
	CMov(FP,0x57f0f0,V(CA[6]))
	CMov(FP,0x57f120,V(CA[10]))
	DoActions(FP,{DisplayText("asdafsa",1)})
	SetCallEnd()


function T_to_BiteBuffer(Table)
	local BiteValue = 0
	if type(Table) == "table" then
		local ret = 0
		if #Table >= 5 then
			BiteStack_is_Over_5()
		end
		for i, j in pairs(Table) do
			BiteValue = BiteValue + j*(256^ret)
			ret = ret + 1
		end
		Table = BiteValue
	end
	return BiteValue
end



function G_CB_SetSpawn(Condition,G_CB_CUTable,G_CB_SNTable,Temp,G_CB_LMTable,G_CB_RPTable,G_CB_FNTable,Delay,CenterXY,Owner,PreserveFlag)
	if type(G_CB_CUTable) ~= "table" then
		G_CB_SetSpawn_Inputdata_Error()
	end
	local X = {}
	if type(G_CB_SNTable) == "table" then
		if #G_CB_SNTable >= 5 then
			BiteStack_is_Over_5()
		end
		for i = 1, 4 do
			if G_CB_SNTable[i] ~= nil then
				if type(G_CB_SNTable[i]) == "string" then
					local G_CB_ShapeTable_Check = ""
					for j, k in pairs(G_CB_ShapeTable) do
						if G_CB_SNTable[i] == k then
							table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,j))
							G_CB_ShapeTable_Check = "OK"
						end
					end
					if G_CB_ShapeTable_Check ~= "OK" then
						PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
					end
				else
					G_CB_SNTable_InputData_Error()
				end
			else
				table.insert(X,SetCVar(FP,G_CB_SNTV[i][2],SetTo,0))
			end
		end
	elseif type(G_CB_SNTable) == "string" then
		local G_CB_ShapeTable_Check = ""
		for j, k in pairs(G_CB_ShapeTable) do
			if G_CB_SNTable == k then
				table.insert(X,SetCVar(FP,G_CB_SNTV[1][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[2][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[3][2],SetTo,j))
				table.insert(X,SetCVar(FP,G_CB_SNTV[4][2],SetTo,j))
				G_CB_ShapeTable_Check = "OK"
			end
		end
		if G_CB_ShapeTable_Check ~= "OK" then
			PushErrorMsg("G_CA_SetSpawn_String_Shape_NotFound")
		end
	else
		G_CB_SNTable_InputData_Error()
	end
	if type(G_CB_FNTable) ~= "table" then
		G_CB_FNTable = {G_CB_FNTable,G_CB_FNTable,G_CB_FNTable,G_CB_FNTable}
	elseif G_CB_FNTable == nil then 
		G_CB_FNTable = {0,0,0,0}
	end
	if type(G_CB_RPTable) ~= "table" then
		G_CB_RPTable = {G_CB_RPTable,G_CB_RPTable,G_CB_RPTable,G_CB_RPTable}
	elseif G_CB_RPTable == nil then 
		G_CB_SetSpawn_Inputdata_Error()
	end
	
	local LMRet = 0
	if G_CB_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CB_LMTable) == "table" then
		LMRet = T_to_BiteBuffer(G_CB_LMTable)
	elseif type(G_CB_LMTable) == "number" then
		LMRet = T_to_BiteBuffer({G_CB_LMTable,G_CB_LMTable,G_CB_LMTable,G_CB_LMTable})
	else
		G_CB_SetSpawn_Inputdata_Error()
	end
	local Y = {}
	if CenterXY == nil then 
		table.insert(Y,SetCVar(FP,G_CB_XPos[2],SetTo,0xFFFFFFFF))
		table.insert(Y,SetCVar(FP,G_CB_YPos[2],SetTo,0xFFFFFFFF))
	elseif type(CenterXY) == "table" then
		table.insert(Y,SetCVar(FP,G_CB_XPos[2],SetTo,CenterXY[1]))
		table.insert(Y,SetCVar(FP,G_CB_YPos[2],SetTo,CenterXY[2]))
	else
		PushErrorMsg("G_CB_SetSpawn_CenterXY_Inputdata_Error")
	end
	if Owner == nil then Owner = 0xFFFFFFFF end
	if Delay == nil then Delay = 0 end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CB_CUTV[2],SetTo,T_to_BiteBuffer(G_CB_CUTable)),
		X,
		
		SetCVar(FP,G_CB_DLTV[2],SetTo,Delay),
		SetCVar(FP,G_CB_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CB_RPTV[2],SetTo,T_to_BiteBuffer(G_CB_RPTable)),Y,
		SetCVar(FP,G_CB_Owner[2],SetTo,Owner),
		SetCVar(FP,G_CB_FNTV[2],SetTo,T_to_BiteBuffer(G_CB_FNTable)),
		SetCVar(FP,G_CB_EffType[2],SetTo,0),
		
	},PreserveFlag)
end


-- Line0 = UnitIDTable 0xFF
-- Line1 = RepeatTypeTable 0xFF
-- Line2 = G_CB_FNTableTable 0xFF
-- Line3 = ShapeNumberTable1
-- Line4 = ShapeNumberTable2
-- Line5 = ShapeNumberTable3
-- Line6 = ShapeNumberTable4
-- Line7 = XPos
-- Line8 = YPos
-- Line9 = CA[5],0xFF 루프 리미트 (트리거 순환당 소환할 유닛 수 / k입력시 CA[4] : 0~k-1까지 루프함) 
-- Line10 = CA[2] 남은 대기 시간 (Tick 단위 / 0일때 유닛 소환) 
-- Line11 = CA[3] 소환후 대기시간 증가량 (Tick 단위/ k입력시 1회 루프후 대기시간 k추가()
-- Line12 = CA[6] 데이터 인덱스 (k입력시 Shape[k+1]의 데이터를 출력함

	Call_G_CB = SetCallForward()
	SetCall(FP)
		CIfX(FP,CVar(FP,G_CB_TempTable[1][2],AtLeast,1,0xFF))
			CallTrigger(FP,Load_CBPlot)
			CIfX(FP,{CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,1,G_CB_Suspend)})
			CDiv(FP,G_CB_TempTable[1],256)
			CDiv(FP,G_CB_TempTable[2],256)
			CDiv(FP,G_CB_TempTable[3],256)
			CMov(FP,G_CB_TempTable[4],G_CB_TempTable[5])
			CMov(FP,G_CB_TempTable[5],G_CB_TempTable[6])
			CMov(FP,G_CB_TempTable[6],G_CB_TempTable[7])
			CMov(FP,G_CB_TempTable[7],0)
			CMov(FP,G_CB_TempTable[13],0)
			if Limit == 1 then
				TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunFuncT,4)},HumanPlayers,FP)},{preserved}) --CD(TestMode,1)
			end
			CElseIfX({CDeaths(FP,AtLeast,1,G_CB_Launch),CDeaths(FP,AtLeast,0,G_CB_Suspend)})
			CElseX()
			if Limit == 1 then
				TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},{preserved})
			end
			
			local G_CB_InputCAct = {}
			for i = 1, G_CB_Lines do
				table.insert(G_CB_InputCAct,SetNVar(G_CB_TempTable[i],SetTo,0))
			end
				CDoActions(FP,G_CB_InputCAct)
			CIfXEnd()
		CElseIfX(CVar(FP,G_CB_TempTable[1][2],AtLeast,1))
		CDiv(FP,G_CB_TempTable[1],256)
		CDiv(FP,G_CB_TempTable[2],256)
		CDiv(FP,G_CB_TempTable[3],256)
		CMov(FP,G_CB_TempTable[4],G_CB_TempTable[5])
		CMov(FP,G_CB_TempTable[5],G_CB_TempTable[6])
		CMov(FP,G_CB_TempTable[6],G_CB_TempTable[7])
		CMov(FP,G_CB_TempTable[7],0)
		CMov(FP,G_CB_TempTable[13],0)
		if Limit == 1 then
			TriggerX(FP,{},{RotatePlayer({DisplayTextX(f_GunErrT2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)},{preserved})
		end

		CIfXEnd()

		local G_CB_InputCAct = {}
		for i = 1, G_CB_Lines do
			table.insert(G_CB_InputCAct,TSetMemory(Vi(G_CB_TempH[2],(i-1)*(0x20/4)),SetTo,G_CB_TempTable[i]))
		end
		CDoActions(FP,G_CB_InputCAct)
		DoActionsX(FP,{SetCDeaths(FP,SetTo,0,G_CB_Suspend),SetCDeaths(FP,SetTo,0,G_CB_Launch)})
	SetCallEnd()
local Actived_G_CB = CreateVar(FP)
function Create_G_CB_Arr()
	if G_CB_Arr_IndexAlloc ~= StartIndex then PushErrorMsg("Already_G_CB_Arr_Created") end
	CMov(FP,Actived_G_CB,0)
	for i = 0, G_CB_ArrSize-1 do
		CTrigger(FP, {CVar("X","X",AtLeast,1),Memory(0x628438,AtLeast,1)}, {
			G_CB_InputCVar,
			SetCtrigX("X",G_CB_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
			SetCVar(FP,G_CB_Num[2],SetTo,i),
			SetCVar(FP,Actived_G_CB[2],Add,1),
			SetNext("X",Call_G_CB,0),SetNext(Call_G_CB+1,"X",1), -- Call f_Gun
			SetCtrigX("X",Call_G_CB+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
			SetCtrigX("X",Call_G_CB+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
			SetCtrig1X("X",Call_G_CB+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
		}, 1, G_CB_Arr_IndexAlloc)
		G_CB_Arr_IndexAlloc = G_CB_Arr_IndexAlloc + 1
	end
end


	function G_CB_init()

		f_GetStrXptr(FP,G_CB_WSTestStrPtr,"\x0D\x0D\x0DG_CB_WS".._0D)

	end

end