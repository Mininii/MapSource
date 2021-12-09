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

	Call_CPosXY = SetCallForward()
	SetCall(FP)
		CMov(FP,CPosX,CPos,0,0XFFFF)
		CMov(FP,CPosY,CPos,0,0XFFFF0000)
		f_Div(FP,CPosY,_Mov(0x10000))
	SetCallEnd()



	-- 저장된 유닛정보를 데이터 배열에서 불러온 후 재배치
	-- 0xYYYYXXXX 0xLLIIPPUU
	-- X = 좌표 X, Y = 좌표 Y, L = 유닛 식별자, I = 무적 플래그, P = 플레이어ID, U = 유닛ID
	f_Replace = SetCallForward()
	SetCall(FP)
		CIfX(FP,Memory(0x628438,AtLeast,1)) -- 캔낫체크.
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
			TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),_Add(CC_Header,((0x20*8)/4))),SetTo,1), -- 확장 구조오프셋 변수에 값 입력
			TSetMemory(_Add(_Mul(CunitIndex,_Mov(0x970/4)),CC_Header),SetTo,Gun_LV), -- 확장 구조오프셋 변수에 값 입력
			TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100})})
		CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
		f_LoadCp()
		CElseX()
		DoActions(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		CIfXEnd()
	SetCallEnd()
	
	local CA_TempUID = CreateVar(FP)
	local CA_Suspend = CreateCcode()
	local G_CA_Temp = Create_VTable(7)
	
--	RandZ = 227
--	Call_CA_Repeat = SetCallForward()
--	SetCall(FP)
--	CIfX(FP,CVar(FP,CA_TempUID[2],Exactly,RandZ,0xFF))
--	local RetRand = f_CRandNum(#ZergGndUArr,0)
--	CMovX(FP,Gun_TempSpawnSet1,VArr(ZergGndVArr,RetRand),nil,0xFF)
--	CElseX()
--	CMov(FP,Gun_TempSpawnSet1,CA_TempUID)
--	CIfXEnd()
--	CMov(FP,Repeat_TempV,1)
--	CMov(FP,RepeatType,G_CA_Temp[6],nil,0xFF)
--	CallTrigger(FP,Set_Repeat)
--	SetCallEnd()
	
	local G_CA_Launch = CreateCcode()
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
		
		CAPlot2(ShapeTable,FP,nilunit,0,{Var_TempTable[2],Var_TempTable[3]},1,32,{0,0,0,0,0,1},nil,FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
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
	
		CAPlot2(ShapeTable,FP,nilunit,0,{0,0},1,32,{0,0,0,0,0,1},nil,FP,nil,nil,{SetCDeaths(FP,Add,1,CA_Suspend)},"CA_Repeat")
		CDoActions(FP,{TSetCVar(FP,G_CA_Temp[3][2],SetTo,V(CA[6]))})
		SetCallEnd()
		G_CA_IndexAlloc = G_CA_IndexAlloc + 1
		table.insert(G_CA_CallStack,G_CA_CallIndex)
		return table.unpack(X)
	end

	
	
G_CA_CondStack = {}
G_CA_CondStack2 = {}

local G_CLine = 6
function Create_CreateTable()
	local Ret = G_CLine
	local G_CA_SuspendJump = def_sIndex()
	CJumpXEnd(FP,G_CA_SuspendJump)
	NIfX(FP,Gun_Line(G_CLine,AtLeast,1,0xFF))
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
		NIfX(FP,{CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtMost,0,CA_Suspend)})
			CDoActions(FP,{
				Gun_SetLine(G_CLine,SetTo,G_CA_Temp[1],0xFF),
				Gun_SetLine(G_CLine+1,SetTo,G_CA_Temp[2],0xFF),
				Gun_SetLine(G_CLine+2,SetTo,G_CA_Temp[3]),
				Gun_SetLine(G_CLine+3,SetTo,G_CA_Temp[4],0xFF),
				Gun_SetLine(G_CLine+4,SetTo,G_CA_Temp[5],0xFF),
				Gun_SetLine(G_CLine+5,SetTo,G_CA_Temp[6],0xFF),
				Gun_SetLine(G_CLine+6,SetTo,G_CA_Temp[7],0xFF),
			})
		NElseIfX({CDeaths(FP,AtLeast,1,G_CA_Launch),CDeaths(FP,AtLeast,1,CA_Suspend)})
		CDoActions(FP,{
			Gun_SetLine(G_CLine,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+1,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+2,SetTo,1),
			Gun_SetLine(G_CLine+3,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+4,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+5,SetTo,0,0xFF),
			Gun_SetLine(G_CLine+6,SetTo,0,0xFF),
		})
		CJumpX(FP,G_CA_SuspendJump)
		NElseX()
			if Limit == 1 then
				ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
				_0DPatchX(FP,f_GunNumT,5)
				f_Movcpy(FP,_Add(G_CA_StrPtr2,f_GunErrT[2]),VArr(f_GunNumT,0),5*4)
				DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_Err".._0D,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
			end
			CDoActions(FP,{
				Gun_SetLine(G_CLine,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+1,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+2,SetTo,1),
				Gun_SetLine(G_CLine+3,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+4,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+5,SetTo,0,0xFF),
				Gun_SetLine(G_CLine+6,SetTo,0,0xFF),
			})
			CJumpX(FP,G_CA_SuspendJump)
		NIfXEnd()
	NElseifX({Gun_Line(G_CLine,AtMost,0,0xFF),Gun_Line(G_CLine,AtLeast,1)})
		if TestStart == 1 then
			ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
			_0DPatchX(FP,f_GunNumT,5)
			f_Movcpy(FP,_Add(G_CA_StrPtr2,f_GunFuncT[2]),VArr(f_GunNumT,0),5*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0DG_CA_Func".._0D,4)},HumanPlayers,FP)})
		end
		CDoActions(FP,{
		Gun_SetLine(G_CLine,SetTo,_Div(Var_TempTable[G_CLine+1],_Mov(256))),
		Gun_SetLine(G_CLine+1,SetTo,_Div(Var_TempTable[G_CLine+2],_Mov(256))),
		Gun_SetLine(G_CLine+2,SetTo,1),
		Gun_SetLine(G_CLine+3,SetTo,_Div(Var_TempTable[G_CLine+4],_Mov(256))),
		Gun_SetLine(G_CLine+4,SetTo,_Div(Var_TempTable[G_CLine+5],_Mov(256))),
		Gun_SetLine(G_CLine+5,SetTo,_Div(Var_TempTable[G_CLine+6],_Mov(256))),
		Gun_SetLine(G_CLine+6,SetTo,_Div(Var_TempTable[G_CLine+7],_Mov(256))),
	})
		CJumpX(FP,G_CA_SuspendJump)
	NIfXEnd()
	DoActionsX(FP,{SetCDeaths(FP,SetTo,0,CA_Suspend),SetCDeaths(FP,SetTo,0,G_CA_Launch)})
	table.insert(G_CA_CondStack,Gun_Line(G_CLine,AtMost,0))
	table.insert(G_CA_CondStack2,Gun_Line(G_CLine,AtLeast,1))
	G_CLine = G_CLine + 7 -- 1 예비
	return Ret
end

	local f_GunNumT = CreateVArray(FP,5)
	local G_TempV,G_CA,GunID = CreateVariables(3)
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
		})
		
		if TestStart == 1 then
			ItoDec(FP,G_CA,VArr(f_GunNumT,0),2,0x1F,0)
			_0DPatchX(FP,f_GunNumT,5)
			f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),5*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
			ItoDec(FP,EXCunitTemp[1],VArr(f_GunNumT,0),2,0x1F,0)
			_0DPatchX(FP,f_GunNumT,5)
			f_Movcpy(FP,_Add(f_GunSendStrPtr2,f_GunSendT2[2]),VArr(f_GunNumT,0),5*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend2".._0D,4)},HumanPlayers,FP)})
		end
		CElseX()
		DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		CIfXEnd()
		f_LoadCp()
	SetCallEnd()

	f_Gun = SetCallForward() -- 건작함수
	SetCall(FP)
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
		

		CDoActions(FP,{Gun_SetLine(4,Add,1)})
		CTrigger(FP,{Gun_Line(4,AtLeast,100)},{Gun_DoSuspend()},1)
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

--	local f_GunNumT = CreateVArray(FP,5)
--	local G_CA,GunID,SVCheckV = CreateVariables(3)
--	G_Send = SetCallForward()
--	SetCall(FP)
--		f_SaveCp()
--		f_Read(FP,_Sub(BackupCp,15),CPos)
--		f_Read(FP,BackupCp,GunID,"X",0xFF)
--		Convert_CPosXY()
--		CMov(FP,G_CA,0)
--		G_SkipJump = def_sIndex()
--		CJumpEnd(FP,G_SkipJump)
--		SCast(FP,SVCheckV,SVArr(Gun_SVA,G_CA,1))
--		NIf(FP,{CVar(FP,SVCheckV[2],AtLeast,1),CVar(FP,G_CA[2],AtMost,63)},{SetCVar(FP,G_CA[2],Add,1)})
--			CJump(FP,G_SkipJump)
--		NIfEnd()
--		CIfX(FP,{CVar(FP,G_CA[2],AtMost,63)})
--		SCast(FP,SVArr(Gun_SVA,G_CA,1),GunID)
--		SCast(FP,SVArr(Gun_SVA,G_CA,2),CPosX)
--		SCast(FP,SVArr(Gun_SVA,G_CA,3),CPosY)
--		SCast(FP,SVArr(Gun_SVA,G_CA,4),EXCunitTemp[1])
--		if TestStart == 1 then
--		ItoDec(FP,G_CA,VArr(f_GunNumT,0),2,0x1F,0)
--		_0DPatchX(FP,f_GunNumT,5)
--		f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),5*4)
--		DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
--		end
--		CElseX()
--		DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
--		CIfXEnd()
--		f_LoadCp()
--	SetCallEnd()

--	f_GunTemp = CreateVarArr(5,FP)
--	f_Gun = SetCallForward() -- 건작함수
--	SetCall(FP)
--		SMov(FP,{f_GunTemp[1],f_GunTemp[2],f_GunTemp[3],f_GunTemp[4],f_GunTemp[5]},SVArr(Gun_SVA,f_GunNum,{1,2,3,4,5}))
--		Simple_SetLocX(FP,0,f_GunTemp[2],f_GunTemp[3],f_GunTemp[2],f_GunTemp[3])
--		
--		

--		CIf(FP,{CVar(FP,f_GunTemp[5][2],AtLeast,1)}) -- SuspendCode
--			SMov(FP,SVArr(Gun_SVA,f_GunNum),{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
--			if TestStart == 1 then
--				ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
--				_0DPatchX(FP,f_GunNumT,5)
--				f_Movcpy(FP,_Add(f_GunStrPtr,f_GunT[2]),VArr(f_GunNumT,0),5*4)
--				DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
--			end
--		CIfEnd()
--	SetCallEnd()
end