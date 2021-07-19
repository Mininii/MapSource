function Install_CallTriggers()
SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()
LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
	SetRecoverCp()
SetCallEnd()

local UpCompTxt = CreateVarray(FP,5)
local UpCompRet = CreateVarray(FP,5)

OneClickUpgrade = SetCallForward()
SetCall(FP) 
	f_Read(FP,TempUpgradePtr,UpResearched)
	CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
		CMod(FP,UpResearched,_Mul(TempUpgradeMaskRet,_Mov(256)))
	CIfEnd()
	CDiv(FP,UpResearched,TempUpgradeMaskRet)
	CMov(FP,0x6509B0,UpgradeCP)
	OCU_Jump = def_sIndex()
	CJumpEnd(FP,OCU_Jump)
	NWhile(FP,{
		CVar(FP,UpResearched[2],AtMost,254),
		CVar(FP,UpgradeMax[2],AtLeast,1),
		TAccumulate(CurrentPlayer,AtLeast,_Mul(UpResearched,UpgradeFactor),Ore),
		TMemoryX(TempUpgradePtr,AtMost,_Mul(TempUpgradeMaskRet,254),_Mul(TempUpgradeMaskRet,255))
	})
		CDoActions(FP,{
			TSetCVar(FP,UpCost[2],Add,_Mul(UpResearched,UpgradeFactor)),
			TSetResources(CurrentPlayer,Subtract,_Mul(UpResearched,UpgradeFactor),Ore),
			SetCVar(FP,UpResearched[2],Add,1),
			SetCVar(FP,UpCompleted[2],Add,1),
			SetCVar(FP,UpgradeMax[2],Subtract,1),
			--TSetCVar(FP,UpCost[2],Add,_Mul(UpResearched,UpgradeFactor)),
			TSetMemoryX(TempUpgradePtr,Add,_Mul(TempUpgradeMaskRet,_Mov(1)),_Mul(TempUpgradeMaskRet,_Mov(255)))
		})
		CJump(FP,OCU_Jump)
	NWhileEnd()

	OCU_Check = def_sIndex()
	NJump(FP,OCU_Check,CVar(FP,UpCompleted[2],Exactly,0),{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	ItoDec(FP,UpCost,VArr(UpCompTxt,0),2,0x1F,0)
	ItoDec(FP,UpCompleted,VArr(UpCompRet,0),2,0x19,0)
	_0DPatchforVArr(FP,UpCompRet,4)
	_0DPatchforVArr(FP,UpCompTxt,4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]),VArr(UpCompTxt,0),5*4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3),VArr(UpCompRet,0),5*4)
	CDoActions(FP,{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x0D\x0D\x0DUPC".._0D,4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	NJumpEnd(FP,OCU_Check)
	DoActionsX(FP,{
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,0),
		SetCVar(FP,TempUpgradePtr[2],SetTo,0),
		SetCVar(FP,UpResearched[2],SetTo,0),
		SetCVar(FP,UpCost[2],SetTo,0),
		SetCVar(FP,UpCompleted[2],SetTo,0)
	})
SetCallEnd()
Call_CPosXY = SetCallForward()
SetCall(FP)
CMov(FP,CPosX,CPos,0,0XFFFF)
CMov(FP,CPosY,CPos,0,0XFFFF0000)
f_Div(FP,CPosY,_Mov(0x10000))
SetCallEnd()

TempRandRet = CreateVar()
InputMaxRand = CreateVar()
Oprnd = CreateVar()
CRandNum = SetCallForward()
SetCall(FP)
f_Rand(FP,TempRandRet)
f_Mod(FP,TempRandRet,InputMaxRand)
CAdd(FP,TempRandRet,Oprnd)
SetCallEnd()

G_TempH = CreateVar()
G_InputH = CreateVar({"X",0x500,0x15C,1,0})
Var_TempTable = {}
Var_InputCVar = {}
Var_Lines = 55
for i = 1, Var_Lines do
	table.insert(Var_TempTable,CreateVar())
	table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
end
local CheckTemp = CreateVar()

Call_Repeat = SetCallForward()
SetCall(FP)
CWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Spawn_TempW[2],AtLeast,1)})
	CIf(FP,CVar(FP,RepeatType[2],Exactly,0))
		local Gun_Order = def_sIndex()
		CJumpXEnd(FP,Gun_Order)
		f_Mod(FP,Gun_TempRand,_Rand(),_Mov(7))
		for i = 0, 6 do
			NIf(FP,{CVar(FP,Gun_TempRand[2],Exactly,i),PlayerCheck(i,0)})
				CJumpX(FP,Gun_Order)
			NIfEnd()
		end
		CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
		for i = 0, 6 do
			CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)})
				CMov(FP,TempBarPos,BarPos[i+1])
			CIfEnd()
		end
		CIfEnd()
	CIfEnd()
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CSub(FP,CheckTemp,Nextptrs,19025)
	f_Mod(FP,CheckTemp,_Mov(84))
	local f_Repeat_ErrorCheck = def_sIndex()
	NJump(FP,f_Repeat_ErrorCheck,{CVar(FP,CheckTemp[2],AtLeast,1)},RotatePlayer({DisplayTextX(f_RepeatErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
	CDoActions(FP,{
		TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,P8,{energy = 100}),
--		TModifyUnitEnergy(All,Gun_TempSpawnSet1,P8,1,100);
	})
	CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
		CIfX(FP,CVar(FP,RepeatType[2],Exactly,0))
			CDoActions(FP,{
				TSetDeathsX(_Add(Nextptrs,19),SetTo,14*256,0,0xFF00),
				TSetDeaths(_Add(Nextptrs,22),SetTo,TempBarPos,0),
			})
		CElseIfX(CVar(FP,RepeatType[2],Exactly,187))
			CDoActions(FP,{
				TSetDeathsX(_Add(Nextptrs,19),SetTo,187*256,0,0xFF00),
			})
		CElseIfX(CVar(FP,RepeatType[2],Exactly,1))
			local BackupL = CreateVar()
			local BackupU = CreateVar()
			local BackupR = CreateVar()
			local BackupD = CreateVar()
			f_Read(FP,0x58DC60+0x14*0,BackupL)
			f_Read(FP,0x58DC64+0x14*0,BackupU)
			f_Read(FP,0x58DC68+0x14*0,BackupR)
			f_Read(FP,0x58DC6C+0x14*0,BackupD) -- BackupLoc
			f_Read(FP,_Add(Nextptrs,10),CPos)
			Convert_CPosXY()
			Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY,{Simple_CalcLoc(0,-32,-32,32,32)})
			CDoActions(FP,{
				TGiveUnits(1,Gun_TempSpawnSet1,P8,1,P11),TSetInvincibility(Enable,Gun_TempSpawnSet1,FP,1),TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00)
			})
			Simple_SetLocX(FP,0,BackupL,BackupU,BackupR,BackupD) -- RecoverLoc

		CElseX()
			DoActions(FP,RotatePlayer({DisplayTextX(f_RepeatTypeErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
		CIfXEnd()
		f_Mod(FP,BiteCalc,Gun_TempSpawnSet1,_Mov(2),0xFF)
		f_Read(FP,_Add(_Div(Gun_TempSpawnSet1,_Mov(2)),_Mov(EPD(0x663EB8))),UnitPoint)
		NIfX(FP,{CVar(FP,BiteCalc[2],AtLeast,1)})
		CDiv(FP,UnitPoint,65536)
		NElseX()
		CMod(FP,UnitPoint,65536)
		NIfXEnd()
		CAdd(FP,InputPoint,UnitPoint)
		
	CIfEnd()
	NJumpEnd(FP,f_Repeat_ErrorCheck)
	CSub(FP,Spawn_TempW,1)
CWhileEnd()
CMov(FP,RepeatType,0)
SetCallEnd()


Set_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{RotatePlayer({DisplayTextX(f_RepeatErr2,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP),SetCVar(FP,Repeat_TempV[2],SetTo,0)},{Preserved})
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,256)},{SetCVar(FP,Repeat_TempV[2],SetTo,0)},{Preserved})
CIf(FP,CVar(FP,Repeat_TempV[2],AtLeast,1))
	CMov(FP,Spawn_TempW,Repeat_TempV)
	CMov(FP,Repeat_TempV,0)
	CallTrigger(FP,Call_Repeat)
	CMov(FP,Spawn_TempW,0)
CIfEnd()
SetCallEnd()

local Gun_TempSpawnSet2,Gun_TempSpawnSet3 = CreateVariables(2)


Load_CSArr = SetCallForward()
SetCall(FP)
	CWhile(FP,CVar(FP,G_TempW[2],AtLeast,1),SetCVar(FP,G_TempW[2],Subtract,1))
		f_SaveCp()
		f_Read(FP,BackupCp,CPos)
		Convert_CPosXY()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY) -- 좌상
		CMov(FP,Repeat_TempV,1)
		CMov(FP,Gun_TempSpawnSet1,Gun_TempSpawnSet3)
		CallTriggerX(FP,Set_Repeat)
		CMov(FP,Gun_TempSpawnSet1,Gun_TempSpawnSet2)
		CMov(FP,Repeat_TempV,1)
		CallTriggerX(FP,Set_Repeat)
		f_LoadCp()
		CAdd(FP,0x6509B0,1)
	CWhileEnd()
SetCallEnd()


function Input_CSData(CSPtr,UnitID,UnitID2,Condition)
	if UnitID2 == nil then
		UnitID2 = 256
	end
	CTrigger(FP,{Condition},{
		SetMemory(0x6509B0,SetTo,CSPtr[1]),
		TSetCVar(FP,G_TempW[2],SetTo,CSPtr[2]),
		SetCVar(FP,Gun_TempSpawnSet3[2],SetTo,UnitID),
		SetCVar(FP,Gun_TempSpawnSet2[2],SetTo,UnitID2),
	},1)
end



local G_CA_LineV = CreateVar()
local G_CA_CUTV = CreateVar()
local G_CA_SNTV = CreateVar()
local G_CA_LMTV = CreateVar()
local G_CA_RTV = CreateVar()
local SL_TempV = Create_VTable(4)
local SL_Ret = CreateVar()

Write_SpawnSet = SetCallForward()
SetCall(FP)
CMov(FP,SL_Ret,0)
for i = 1, 4 do
	CIfX(FP,CVar(FP,SL_TempV[i][2],AtMost,255))
		local RandRet = f_CRandNum(12,1)
		CAdd(FP,SL_TempV[i],RandRet)
		f_Mul(FP,SL_Ret,SL_TempV[i],_Mov(256^(i-1)),0xFF*(256^(i-1)))
	CElseIfX(CVar(FP,SL_TempV[i][2],AtLeast,257))
		CSub(FP,SL_TempV[i],256)
		f_Mul(FP,SL_Ret,SL_TempV[i],_Mov(256^(i-1)),0xFF*(256^(i-1)))
	CElseX()
		CMov(FP,SL_Ret,SL_TempV[i],0,0xFF*(256^(i-1)))
	CIfXEnd()
end
CDoActions(FP,{
	Gun_SetLineX(G_CA_LineV,SetTo,G_CA_CUTV),
	Gun_SetLineX(_Add(G_CA_LineV,1),SetTo,SL_Ret),
	Gun_SetLineX(_Add(G_CA_LineV,3),SetTo,G_CA_SNTV),
	Gun_SetLineX(_Add(G_CA_LineV,4),SetTo,G_CA_LMTV),
	Gun_SetLineX(_Add(G_CA_LineV,5),SetTo,G_CA_RTV),
})
SetCallEnd()



function G_CA_SetSpawn(Condition,G_CA_Line,G_CA_CUTable,G_CA_SNTable,G_CA_SLTable,G_CA_LMTable,G_CA_RepeatType)
	if type(G_CA_CUTable) ~= "table" and type(G_CA_SNTable) ~= "table" and type(G_CA_SLTable) ~= "table" then
		G_CA_SetSpawn_Inputdata_Error()
	end
	local X = {}
	if type(G_CA_SLTable) == "table" then
		if #G_CA_SLTable >= 5 then
			BiteStack_is_Over_5()
		end
		for i = 1, 4 do
			if G_CA_SLTable[i] ~= nil then
				if type(G_CA_SLTable[i]) == "number" then
					table.insert(X,SetCVar(FP,SL_TempV[i][2],SetTo,12*G_CA_SLTable[i]))
				elseif type(G_CA_SLTable[i]) == "string" then
					table.insert(X,SetCVar(FP,SL_TempV[i][2],SetTo,256+tonumber(G_CA_SLTable[i])))
				else
					G_CA_SLTable_InputData_Error()
				end
			else
				table.insert(X,SetCVar(FP,SL_TempV[i][2],SetTo,256))
			end
		end
	elseif G_CA_SLTable == nil then
		for i = 1, 4 do
			table.insert(X,SetCVar(FP,SL_TempV[i][2],SetTo,256))
		end
	end
	local LMRet = 0
	if G_CA_LMTable == "MAX" then
		LMRet = T_to_BiteBuffer({255,255,255,255})
	elseif type(G_CA_LMTable) == "table" then
		
		LMRet = T_to_BiteBuffer(G_CA_LMTable)
	elseif type(G_CA_LMTable) == "number" then
		local NumRet = G_CA_LMTable
		LMRet = T_to_BiteBuffer({NumRet,NumRet,NumRet,NumRet})
	end
	CallTriggerX(FP,Write_SpawnSet,Condition,{
		SetCVar(FP,G_CA_LineV[2],SetTo,G_CA_Line),
		SetCVar(FP,G_CA_CUTV[2],SetTo,T_to_BiteBuffer(G_CA_CUTable)),X,
		SetCVar(FP,G_CA_SNTV[2],SetTo,T_to_BiteBuffer(G_CA_SNTable)),
		SetCVar(FP,G_CA_LMTV[2],SetTo,LMRet),
		SetCVar(FP,G_CA_RTV[2],SetTo,T_to_BiteBuffer(G_CA_RepeatType)),
	})

end

--[[
Line No.1 : UnitID(Gun)
Line No.2 : Pos.X
Line No.3 : Pos.Y
Line No.4 : Gun_LV
Line No.5 : T
Line No.6 : C
Line No.args : UnitSpawnSet or CAPlot VarSet
7~29

Line No.54 : GunType
Line No.55 : SuspendSwitch
]]
local CA_TempUID = CreateVar()
local CA_Suspend = CreateCCode()
local G_CA_Temp = Create_VTable(7)

RandZ = 227
Call_CA_Repeat = SetCallForward()
SetCall(FP)
CIfX(FP,CVar(FP,CA_TempUID[2],Exactly,RandZ,0xFF))
local RetRand = f_CRandNum(#ZergGndUArr,0)
CMovX(FP,Gun_TempSpawnSet1,VArr(ZergGndVArr,RetRand),nil,0xFF)
CElseX()
CMov(FP,Gun_TempSpawnSet1,CA_TempUID)
CIfXEnd()
CMov(FP,Repeat_TempV,1)
CMov(FP,RepeatType,G_CA_Temp[6],nil,0xFF)
CallTrigger(FP,Set_Repeat)
SetCallEnd()

local G_CA_Launch = CreateCCode()
function CA_Repeat()
CallTrigger(FP,Call_CA_Repeat,{SetCDeaths(FP,SetTo,1,G_CA_Launch)})
end

local G_CA_CallStack = {}
local G_CA_IndexAlloc = 1
function G_CAPlot(ShapeTable)
	local G_CA_CallIndex = SetCallForward()
	local Ret = G_CA_IndexAlloc
	local CA = CAPlotForward()
	SetCall(FP)
	CMov(FP,CA_TempUID,G_CA_Temp[1],nil,0xFF)
	CMov(FP,V(CA[1]),G_CA_Temp[2],nil,0xFF)
	CMov(FP,V(CA[6]),G_CA_Temp[3])
	CIfX(FP,CVar(FP,G_CA_Temp[5][2],AtMost,0))
		if type(ShapeTable[1]) == "number" then
			DoActionsX(FP,{SetCVar(FP,CA[1],SetTo,1,0xFF),SetCVar(FP,CA[5],SetTo,(ShapeTable[1]/50)+1)})
		elseif type(ShapeTable) == "table" then
			for j, k in pairs(ShapeTable) do
				CTrigger(FP,{CVar(FP,G_CA_Temp[2][2],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
			end
		else
			G_CAPlot_InputData_Error()
		end
	CElseX()
		CMov(FP,V(CA[5]),G_CA_Temp[5])
	CIfXEnd()

	CAPlot(ShapeTable,FP,nilunit,0,nil,1,32,{0,0,0,0,0,1},nil,FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
	CDoActions(FP,{TSetCVar(FP,G_CA_Temp[3][2],SetTo,V(CA[6]))})
	SetCallEnd()
	G_CA_IndexAlloc = G_CA_IndexAlloc + 1
	table.insert(G_CA_CallStack,G_CA_CallIndex)
	return Ret
end

function G_CAPlot2(ShapeTable)
	local G_CA_CallIndex = SetCallForward()
	Another_CAPlot_Shape = G_CA_IndexAlloc
	local CA = CAPlotForward()
	local X = {}
	SetCall(FP)
	CMov(FP,CA_TempUID,G_CA_Temp[1],nil,0xFF)
	CMov(FP,V(CA[1]),G_CA_Temp[2],nil,0xFF)
	CMov(FP,V(CA[6]),G_CA_Temp[3])
	CIfX(FP,CVar(FP,G_CA_Temp[5][2],AtMost,0))
		for j, k in pairs(ShapeTable) do
			CTrigger(FP,{CVar(FP,G_CA_Temp[2][2],Exactly,j,0xFF)},{SetCVar(FP,CA[5],SetTo,(k[1]/50)+1)},1)
			table.insert(X,tostring(j))
		end
	CElseX()
		CMov(FP,V(CA[5]),G_CA_Temp[5])
	CIfXEnd()

	CAPlot(ShapeTable,FP,nilunit,0,{0,0},1,32,{0,0,0,0,0,1},nil,FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
	CDoActions(FP,{TSetCVar(FP,G_CA_Temp[3][2],SetTo,V(CA[6]))})
	SetCallEnd()
	G_CA_IndexAlloc = G_CA_IndexAlloc + 1
	table.insert(G_CA_CallStack,G_CA_CallIndex)
	return table.unpack(X)
end



G_CA_CondStack = {}
G_CA_CondStack2 = {}

local G_CLine = 6
local f_GunNumT = CreateVarray(FP,5)
function Create_CreateTable()
	local Ret = G_CLine
	CIfX(FP,Gun_Line(G_CLine,AtLeast,1,0xFF))
		CDoActions(FP,{
			TSetCVar(FP,G_CA_Temp[1][2],SetTo,Var_TempTable[G_CLine+1],0xFF),
			TSetCVar(FP,G_CA_Temp[2][2],SetTo,Var_TempTable[G_CLine+2],0xFF),
			TSetCVar(FP,G_CA_Temp[3][2],SetTo,Var_TempTable[G_CLine+3]),
			TSetCVar(FP,G_CA_Temp[4][2],SetTo,Var_TempTable[G_CLine+4],0xFF),
			TSetCVar(FP,G_CA_Temp[5][2],SetTo,Var_TempTable[G_CLine+5],0xFF),
			TSetCVar(FP,G_CA_Temp[6][2],SetTo,Var_TempTable[G_CLine+6],0xFF),
			TSetCVar(FP,G_CA_Temp[7][2],SetTo,Var_TempTable[G_CLine+7],0xFF),
		})
		CallTrigger(FP,Load_CAPlot_Shape)
		CIfX(FP,{CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtMost,0,CA_Suspend)})
			CDoActions(FP,{
				Gun_SetLine(G_CLine,SetTo,G_CA_Temp[1],0xFF),
				Gun_SetLine(G_CLine+1,SetTo,G_CA_Temp[2],0xFF),
				Gun_SetLine(G_CLine+2,SetTo,G_CA_Temp[3]),
				Gun_SetLine(G_CLine+3,SetTo,G_CA_Temp[4],0xFF),
				Gun_SetLine(G_CLine+4,SetTo,G_CA_Temp[5],0xFF),
				Gun_SetLine(G_CLine+5,SetTo,G_CA_Temp[6],0xFF),
				Gun_SetLine(G_CLine+6,SetTo,G_CA_Temp[7],0xFF),
			})
		CElseIfX({CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtLeast,1,CA_Suspend)})
		CDoActions(FP,{
			Gun_SetLine(G_CLine,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+1,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+2,SetTo,0),
			Gun_SetLine(G_CLine+3,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+4,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+5,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+6,SetTo,0,0xFF),
		})
		CElseX()
			if Limit == 1 then
				ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
				_0DPatchX(FP,f_GunNumT,5)
				f_Movcpy(FP,_Add(G_CA_StrPtr2,f_GunErrT[2]),VArr(f_GunNumT,0),5*4)
				DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_Err".._0D,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
			end
			CDoActions(FP,{
				Gun_SetLine(G_CLine,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+1,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+2,SetTo,0),
				Gun_SetLine(G_CLine+3,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+4,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+5,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+6,SetTo,0,0xFF),
			})
		CIfXEnd()
	CElseifX({Gun_Line(G_CLine,AtMost,0,0xFF),Gun_Line(G_CLine,AtLeast,1)})
		if TestStart == 1 then
			ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
			_0DPatchX(FP,f_GunNumT,5)
			f_Movcpy(FP,_Add(G_CA_StrPtr2,f_GunFuncT[2]),VArr(f_GunNumT,0),5*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_Func".._0D,4)},HumanPlayers,FP)})
		end
		CDoActions(FP,{
		Gun_SetLine(G_CLine,SetTo,_Div(Var_TempTable[G_CLine+1],_Mov(256))),
		Gun_SetLine(G_CLine+1,SetTo,_Div(Var_TempTable[G_CLine+2],_Mov(256))),
		Gun_SetLine(G_CLine+2,SetTo,0),
		Gun_SetLine(G_CLine+3,SetTo,_Div(Var_TempTable[G_CLine+4],_Mov(256))),
		Gun_SetLine(G_CLine+4,SetTo,_Div(Var_TempTable[G_CLine+5],_Mov(256))),
		Gun_SetLine(G_CLine+5,SetTo,_Div(Var_TempTable[G_CLine+6],_Mov(256))),
		Gun_SetLine(G_CLine+6,SetTo,_Div(Var_TempTable[G_CLine+7],_Mov(256))),
	})
	CIfXEnd()
	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,CA_Suspend),SetCDeaths(FP,SetTo,0,G_CA_Launch)})
	table.insert(G_CA_CondStack,Gun_Line(G_CLine,AtMost,0))
	table.insert(G_CA_CondStack2,Gun_Line(G_CLine,AtLeast,1))
	G_CLine = G_CLine + 7 -- 1 예비
	return Ret
end

InstallGunData()



S_3 = G_CAPlot(S_3_ShT)
S_4 = G_CAPlot(S_4_ShT)
S_5 = G_CAPlot(S_5_ShT)
S_6 = G_CAPlot(S_6_ShT)
S_7 = G_CAPlot(S_7_ShT)
S_8 = G_CAPlot(S_8_ShT)
P_3 = G_CAPlot(P_3_ShT)
P_4 = G_CAPlot(P_4_ShT)
P_5 = G_CAPlot(P_5_ShT)
P_6 = G_CAPlot(P_6_ShT)
P_7 = G_CAPlot(P_7_ShT)
P_8 = G_CAPlot(P_8_ShT)


NBYD,Hive_1,Ovrm,CC_L,CC_R,Hive_2,Hive_3,Cere_L,Cere_R,CC_LF,CC_RF,OvrmF = 
G_CAPlot2({NBYD,Hive_1,Ovrm,CC_L,CC_R,Hive_2,Hive_3,Cere_L,Cere_R,CC_LF,CC_RF,OvrmF})




Load_CAPlot_Shape = SetCallForward()
SetCall(FP)

for j, k in pairs(G_CA_CallStack) do
	CallTriggerX(FP,k,{CVar(FP,G_CA_Temp[4][2],Exactly,j,0xFF)})
end

SetCallEnd()


f_Gun = SetCallForward() -- 건작함수
SetCall(FP)
	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
	CIf(FP,{CVar(FP,Var_TempTable[54][2],AtMost,255)}) -- 레어나 하이브 등의 건작일 경우
		G_L1 = Create_CreateTable()
		G_L2 = Create_CreateTable()
		G_L3 = Create_CreateTable()
		G_L4 = Create_CreateTable()
		Case_OverCocoon()
		Case_Overmind()
		Case_Daggoth()
		Case_Cerebrate()
		Case_InfestedCommand()
		Case_Hive()
		Case_Lair()
		Case_Hatchery()
		Case_Test()


		
		
	CIfEnd()
	Case_Various()
	CDoActions(FP,{Gun_SetLine(4,Add,Dt)})
	CIf(FP,{Gun_Line(54,AtLeast,1),G_CA_CondStack}) -- SuspendCode
		CMov(FP,G_TempW,0)
		CWhile(FP,CVar(FP,G_TempW[2],AtMost,(Var_Lines-1)*(0x20/4)))
			CDoActions(FP,{TSetMemory(_Add(G_TempH,G_TempW),SetTo,0)})
			CAdd(FP,G_TempW,0x20/4)
		CWhileEnd()
		if TestStart == 1 then
			ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
			_0DPatchX(FP,f_GunNumT,5)
			f_Movcpy(FP,_Add(f_GunStrPtr,f_GunT[2]),VArr(f_GunNumT,0),5*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
		end
	CIfEnd()
SetCallEnd()

local G_TempV,G_CA,GunID = CreateVariables(4)
G_Send = SetCallForward()
SetCall(FP)
	f_SaveCp()
	f_Read(FP,_Sub(BackupCp,15),CPos)
	f_Read(FP,BackupCp,GunID,"X",0xFF)
	Convert_CPosXY()
	CMov(FP,G_CA,0)
	G_SkipJump = def_sIndex()
	CJumpEnd(FP,G_SkipJump)
	CAdd(FP,G_TempV,_Mul(G_CA,_Mov(0x970/4)),G_InputH)
	NIf(FP,{TMemory(G_TempV,AtLeast,1),CVar(FP,G_CA[2],AtMost,63)},{SetCVar(FP,G_CA[2],Add,1)})
		CJump(FP,G_SkipJump)
	NIfEnd()

	CIfX(FP,{CVar(FP,G_CA[2],AtMost,63)})
	CDoActions(FP,{
		TSetMemory(G_TempV,SetTo,GunID),
		TSetMemory(_Add(G_TempV,1*(0x20/4)),SetTo,CPosX),
		TSetMemory(_Add(G_TempV,2*(0x20/4)),SetTo,CPosY),
		TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,EXCunitTemp[1]),
		TSetMemory(_Add(G_TempV,53*(0x20/4)),SetTo,Gun_Type),
	})
	
	if TestStart == 1 then
	ItoDec(FP,G_CA,VArr(f_GunNumT,0),2,0x1F,0)
	_0DPatchX(FP,f_GunNumT,5)
	f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),5*4)
	DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
	end
	CElseX()
	DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
	CIfXEnd()
	f_LoadCp()
SetCallEnd()
UnitIDV = CreateVar()
TempLvHP = CreateVar()
TempLvHP2 = CreateVar()
MultiplierV = CreateVar()
f_SetLvHP = SetCallForward()
SetCall(FP)
	CIf(FP,{TMemory(_Add(UnitIDV,EPD(0x662350)),AtMost,8319999*256)})
		CMovX(FP,TempLvHP2,VArr(MaxHPBackUp,UnitIDV))
		f_Mul(FP,TempLvHP,TempLvHP2,_Mul(MultiplierV,_Sub(Level,_Mov(1))))
		CIfX(FP,{TMemory(_Mem(_Add(TempLvHP2,TempLvHP)),AtLeast,8320000*256)})
			CDoActions(FP,{TSetMemory(_Add(UnitIDV,EPD(0x662350)),SetTo,8320000*256)})
		CElseX()
			CDoActions(FP,{TSetMemory(_Add(UnitIDV,EPD(0x662350)),SetTo,_Add(TempLvHP2,TempLvHP))})
		CIfXEnd()
	CIfEnd()
SetCallEnd()

f_Replace = SetCallForward()
SetCall(FP)
	CIfX(FP,Memory(0x628438,AtLeast,1))
	f_SaveCp()
	CMov(FP,Gun_LV,0)
	f_Read(FP,BackupCP,CPos)
	Convert_CPosXY()
	f_Read(FP,_Add(BackupCP,1),Gun_LV,"X",0xFF000000)
	f_Read(FP,_Add(BackupCP,1),CunitP,"X",0xFF00)
	f_Read(FP,_Add(BackupCP,1),RepHeroIndex,"X",0xFF)
	f_Div(FP,CunitP,_Mov(0x100)) -- 0
	f_Div(FP,Gun_LV,_Mov(0x1000000)) -- 1
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
	CDoActions(FP,{
	TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
	TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
	TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
	TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
	})
	CDoActions(FP,{
		TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1),
		TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV)})
	CIfX(FP,CVar(FP,RepHeroIndex[2],Exactly,111))
	CDoActions(FP,{
	TCreateUnitWithProperties(1, RepHeroIndex, 1, P8,{energy = 100}),TSetMemoryX(_Add(Nextptrs,19),SetTo,CunitP,0xFF)})
	for i = 0, 6 do
	CIf(FP,CVar(FP,CunitP[2],Exactly,i))
		CMov(FP,BarrackPtr[i+1],Nextptrs)
		f_Read(FP,_Add(BarrackPtr[i+1],10),BarPos[i+1])
	CIfEnd()
	end
	CElseX()
	CDoActions(FP,{
	TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100})})
	CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
	CIfXEnd()
	f_LoadCp()
	CElseX()
	DoActions(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
	CIfXEnd()
SetCallEnd()



function f_Recall(Condition,X,Y)
	CMov(FP,Rec_X,X)
	CMov(FP,Rec_Y,Y)
	CallTriggerX(FP,Call_Recall,Condition)
end
Rec_X = CreateVar()
Rec_Y = CreateVar()
Call_Recall = SetCallForward()
SetCall(FP)
	CIf(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Rec_X[2],AtMost,32*96),CVar(FP,Rec_Y[2],AtMost,32*192)})
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		Simple_SetLocX(FP,0,Rec_X,Rec_Y,Rec_X,Rec_Y)
		DoActions(FP,{
		CreateUnitWithProperties(1,71,1,FP,{energy = 100});})
		CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
			CDoActions(FP,{
			TSetMemory(_Add(Nextptrs,0x58/4),SetTo,_Add(Rec_X,_Mul(Rec_Y,65536))),
			TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,137*256,0xFF00)})
		CIfEnd()
	CIfEnd()

SetCallEnd()
function f_ArrReset(Condition)
	CallTriggerX(FP,Call_ArrReset,Condition)
end
Call_ArrReset = SetCallForward()
SetCall(FP)
	-- ArrayReset
	CMov(FP,CurArr,0)
	CWhile(FP,CVar(FP,CurArr[2],AtMost,999))
	CDoActions(FP,{
		TSetMemory(_Add(XY_ArrHeader,CurArr),SetTo,0)
	})
	CAdd(FP,CurArr,1)
	CWhileEnd()
SetCallEnd()

local CB_UnitIDV =CreateVar()
local Height_V = CreateVar()
local Angle_V = CreateVar()
local CB_X = CreateVar()
local CB_Y = CreateVar()
	function CreateBullet(UnitID,Height,Angle,X,Y)
	CDoActions(FP,{
		TSetCVar(FP,CB_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Height_V[2],SetTo,Height),
		TSetCVar(FP,Angle_V[2],SetTo,Angle),
		TSetCVar(FP,CB_X[2],SetTo,X),
		TSetCVar(FP,CB_Y[2],SetTo,Y),
		SetNext("X",CallCBullet,0),SetNext(CallCBullet+1,"X",1)
	})
	end
	
	CallCBullet = SetCallForward()
	SetCall(FP)
	CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		CAdd(FP,CB_Y,10)
		f_Mod(FP,Angle_V,_Mov(256))
		CDoActions(FP,{
			TSetMemoryX(0x66321C, SetTo, Height_V,0xFF),
			TSetMemory(0x58DC60 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC68 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC64 + 0x14*0,SetTo,CB_Y),
			TSetMemory(0x58DC6C + 0x14*0,SetTo,CB_Y),
			TCreateUnit(1, CB_UnitIDV, 1, FP)})
		CDoActions(FP,{
			TSetMemoryX(_Add(Nextptrs,0x58/4),SetTo,_ReadF(_Add(Nextptrs,(0x28/4))),0xFFFFFFFF),
			TSetMemoryX(_Add(Nextptrs,0x20/4),SetTo,_Mul(Angle_V,256),0xFF00),
			TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,135*256,0xFF00),
			TSetMemoryX(_Add(Nextptrs,40),SetTo,0,0xFF000000),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104),
			TSetMemory(_Add(Nextptrs,57),SetTo,0),
		})
	CIfEnd()
	SetCallEnd()

	




end