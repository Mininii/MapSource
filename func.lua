function f_SaveCp()
	CallTrigger(FP,SaveCp_CallIndex,nil)
end
function f_LoadCp()
	CallTrigger(FP,LoadCp_CallIndex,nil)
end

function f_Repeat(Line)
	TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{SetCVar(FP,Var_TempTable[Line][2],SetTo,0)},{Preserved})
	CIf(FP,CVar(FP,Var_TempTable[Line][2],AtLeast,1))
		CMov(FP,Spawn_TempW,Var_TempTable[Line])
		CallTrigger(FP,Call_Repeat)
		CDoActions(FP,{TSetMemory(_Add(G_TempH,((Line-1)*0x20)/4),SetTo,Spawn_TempW)})
	CIfEnd()
end

function f_TempRepeat(UnitID,Number,Condition)
	CallTriggerX(FP,Set_Repeat,Condition,{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,UnitID),SetCVar(FP,Repeat_TempV[2],SetTo,Number)})
end
function Input_CSData(CSPtr,UnitID,UnitID2,Condition)
	if UnitID2 == nil then
		UnitID2 = 0
	end
	CTrigger(FP,{Condition},{
		SetMemory(0x6509B0,SetTo,CSPtr[1]),
		TSetCVar(FP,G_TempW[2],SetTo,CSPtr[2]),
		SetCVar(FP,Gun_TempSpawnSet3[2],SetTo,UnitID),
		SetCVar(FP,Gun_TempSpawnSet2[2],SetTo,UnitID2),
	},1)
end



SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()
LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
SetCallEnd()
HeroVArr = CVArray(FP,#HeroArr)

OneClickUpgrade = SetCallForward()
SetCall(FP) 
	f_Read(FP,TempUpgradePtr,UpResearched)
	CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
		CMod(FP,UpResearched,_Mul(TempUpgradeMaskRet,_Mov(256)))
	CIfEnd()
	CDiv(FP,UpResearched,TempUpgradeMaskRet)
	CMov(FP,0x6509B0,UpgradeCP)
	CJumpEnd(FP,UpResearched[2])
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
		CJump(FP,UpResearched[2])
	NWhileEnd()
	NJump(FP,0x24,CVar(FP,UpCompleted[2],Exactly,0),{
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
	NJumpEnd(FP,0x24)
	DoActionsX(FP,{
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,0),
		SetCVar(FP,TempUpgradePtr[2],SetTo,0),
		SetCVar(FP,UpResearched[2],SetTo,0),
		SetCVar(FP,UpCost[2],SetTo,0),
		SetCVar(FP,UpCompleted[2],SetTo,0)
	})
SetCallEnd()

G_TempH = CreateVar()
G_InputH = CreateVar({"X",0x500,0x15C,1,0})
Var_TempTable = {}
Var_InputCVar = {}
Var_Lines = 30
for i = 1, Var_Lines do
	table.insert(Var_TempTable,CreateVar())
	table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
end


Call_Repeat = SetCallForward()
SetCall(FP)
CWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Spawn_TempW[2],AtLeast,1)})
	CJumpXEnd(FP,0x501)
	f_Mod(FP,Gun_TempRand,_Rand(),_Mov(7))
	for i = 0, 6 do
		NIf(FP,{CVar(FP,Gun_TempRand[2],Exactly,i),PlayerCheck(i,0)})
			CJumpX(FP,0x501)
		NIfEnd()
	end
	CIf(FP,CDeaths(FP,AtLeast,1,PCheck))
	for i = 0, 6 do
		CIf(FP,{CVar(FP,BarrackPtr[i+1][2],AtLeast,1),CVar(FP,Gun_TempRand[2],Exactly,i)})
			CMov(FP,TempBarPos,BarPos[i+1])
		CIfEnd()
	end
	CIfEnd()
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CDoActions(FP,{
		TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,P8,{energy = 100}),
--		TModifyUnitEnergy(All,Gun_TempSpawnSet1,P8,1,100);
	})
	CIf(FP,{TMemory(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
	CDoActions(FP,{
		TSetDeathsX(_Add(Nextptrs,19),SetTo,152*256,0,0xFF00),
		TSetDeaths(_Add(Nextptrs,22),SetTo,TempBarPos,0),
	})
	CIfEnd()
	CSub(FP,Spawn_TempW,1)
CWhileEnd()
SetCallEnd()


Set_Repeat = SetCallForward()
SetCall(FP)
TriggerX(FP,{CVar(FP,Gun_TempSpawnSet1[2],Exactly,0)},{SetCVar(FP,Repeat_TempV[2],SetTo,0)},{Preserved})
CIf(FP,CVar(FP,Repeat_TempV[2],AtLeast,1))
	CMov(FP,Spawn_TempW,Repeat_TempV)
	CMov(FP,Repeat_TempV,0)
	CallTrigger(FP,Call_Repeat)
	CMov(FP,Spawn_TempW,0)
CIfEnd()
SetCallEnd()

Load_CSArr = SetCallForward()
SetCall(FP)
	CWhile(FP,CVar(FP,G_TempW[2],AtLeast,1),SetCVar(FP,G_TempW[2],Subtract,1))
		f_SaveCp()
		f_Read(FP,BackupCp,CPos)
		CMov(FP,CPosX,CPos,0,0XFFFF)
		CMov(FP,CPosY,CPos,0,0XFFFF0000)
		f_Div(FP,CPosY,_Mov(0x10000))
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
--[[
Line No.1 : UnitID(Gun)
Line No.2 : Pos.X
Line No.3 : Pos.Y
Line No.4 : Gun_LV
Line No.5 : T
Line No.6 : C
Line No.args : UnitSpawnSet
...
...

Line No.29 : GunType
Line No.30 : SuspendSwitch
]]


f_Gun = SetCallForward() -- 건작함수
SetCall(FP)
	CIf(FP,{CVar(FP,Var_TempTable[29][2],AtMost,255)}) -- 레어나 하이브 등의 건작일 경우
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,151))--셀브순대
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,4)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Input_CSData(CustomShape[4],55,nil,CVar(FP,Var_TempTable[6][2],Exactly,0))
				Input_CSData(CustomShape[4],56,nil,CVar(FP,Var_TempTable[6][2],Exactly,1))
				CallTriggerX(FP,Load_CSArr)
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,1)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
		CIfEnd()

		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,130))--감커

			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,500)})
				CMov(FP,ReserveBGM,5)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,500))
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(6*0x20)/4),SetTo,10)})
			CIfEnd()
			TriggerX(FP,{CVar(FP,Var_TempTable[2][2],AtMost,48*32)},{SetCVar(FP,CUID[2],SetTo,88)},{Preserved})
			TriggerX(FP,{CVar(FP,Var_TempTable[2][2],AtLeast,48*32)},{SetCVar(FP,CUID[2],SetTo,21)},{Preserved})

			NWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Var_TempTable[7][2],AtLeast,1)})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CMov(FP,RandSpeed,_Mod(_Rand(),2500),500)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
				
			CDoActions(FP,{
				TCreateUnitWithProperties(1,CUID,1,P8,{energy = 100}),
			})
			CIf(FP,{TMemory(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
			CDoActions(FP,{
				TSetDeaths(_Add(Nextptrs,13),SetTo,RandSpeed,0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,RandSpeed,0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,19),SetTo,187*256,0,0xFF00),
			})
			CIfEnd()
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(6*0x20)/4),Subtract,1),SetCVar(FP,Var_TempTable[7][2],Subtract,1)})
		NWhileEnd()
		CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,20)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,133))--하이브
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,4)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,0))
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CIfEnd()
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,1))
					Input_CSData(CustomShape[1],48,55,CVar(FP,Var_TempTable[6][2],Exactly,0))
					Input_CSData(CustomShape[1],104,56,CVar(FP,Var_TempTable[6][2],Exactly,1))
					Input_CSData(CustomShape[1],51,56,CVar(FP,Var_TempTable[6][2],Exactly,2))
					CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
					CallTriggerX(FP,Load_CSArr)
				CIfEnd()
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,2))
					Input_CSData(CustomShape[2],55,nil,CVar(FP,Var_TempTable[6][2],Exactly,0))
					Input_CSData(CustomShape[2],56,nil,CVar(FP,Var_TempTable[6][2],Exactly,1))
					Input_CSData(CustomShape[2],56,nil,CVar(FP,Var_TempTable[6][2],Exactly,2))
					CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
					CallTriggerX(FP,Load_CSArr)
				CIfEnd()
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,3))
					Input_CSData(CustomShape[3],54,53,CVar(FP,Var_TempTable[6][2],Exactly,0))
					Input_CSData(CustomShape[3],55,53,CVar(FP,Var_TempTable[6][2],Exactly,1))
					Input_CSData(CustomShape[3],56,48,CVar(FP,Var_TempTable[6][2],Exactly,2))
					CallTriggerX(FP,Load_CSArr)
					CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CIfEnd()
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,132))--레어
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,3)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
			CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,131))--해처리
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,2)
			CIfEnd()
	
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
			CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
		CIfEnd()
	CIfEnd()
	CIf(FP,{CVar(FP,Var_TempTable[29][2],AtLeast,256)}) -- 잡건작일 경우
	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],{Simple_CalcLoc(0,-32*7,-32*7,32*7,32*7)})
		CIf(FP,{CVar(FP,Var_TempTable[6][2],Exactly,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,2500)})
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,2500))
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(6*0x20)/4),Add,15)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(7*0x20)/4),Add,10)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(8*0x20)/4),Add,5)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(9*0x20)/4),Add,3)})
		CIfEnd()
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,137)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,142)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,135)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,140)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,48)},{Preserved})
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,141)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,55)},{Preserved})
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,51)},{Preserved})
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
		f_Repeat(7)
		CMov(FP,Gun_TempSpawnSet1,0)
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,104)},{Preserved})
		f_Repeat(8)
		CMov(FP,Gun_TempSpawnSet1,0)
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
		f_Repeat(9)
		CMov(FP,Gun_TempSpawnSet1,0)
		TriggerX(FP,{CVar(FP,Var_TempTable[1][2],Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,45)},{Preserved})
		f_Repeat(10)
		CTrigger(FP,{CVar(FP,Var_TempTable[6][2],Exactly,7)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
	CIfEnd()
	CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,Dt)})
	CIf(FP,{CVar(FP,Var_TempTable[30][2],AtLeast,1)})
	CMov(FP,G_TempW,0)
	CWhile(FP,CVar(FP,G_TempW[2],AtMost,(Var_Lines-1)*(0x20/4)))
		CDoActions(FP,{TSetMemory(_Add(G_TempH,G_TempW),SetTo,0)})
		CAdd(FP,G_TempW,0x20/4)
	CWhileEnd()
	if Limit == 1 then
	ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
	f_Movcpy(FP,_Add(f_GunStrPtr,f_GunT[2]),VArr(f_GunNumT,0),5*4)
	DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
	end
	CIfEnd()
SetCallEnd()

G_Send = SetCallForward()
SetCall(FP)
	f_SaveCp()
	CMov(FP,BackupPosData,BackupCp,-15)
	f_Read(FP,BackupCp,GunID,"X",0xFF)
	
	CMov(FP,G_CA,0)
	CJumpEnd(FP,0x619)
	CAdd(FP,G_TempV,_Mul(G_CA,_Mov(0x970/4)),G_InputH)
	NIf(FP,{TMemory(G_TempV,AtLeast,1),CVar(FP,G_CA[2],AtMost,63)},{SetCVar(FP,G_CA[2],Add,1)})
		CJump(FP,0x619)
	NIfEnd()

	CIfX(FP,{CVar(FP,G_CA[2],AtMost,63)})
	CDoActions(FP,{
		TSetMemory(G_TempV,SetTo,GunID),
		TSetMemory(_Add(G_TempV,1*(0x20/4)),SetTo,_ReadF(BackupPosData,0xFFFF)),
		TSetMemory(_Add(G_TempV,2*(0x20/4)),SetTo,_Div(_ReadF(BackupPosData,0xFFFF0000),_Mov(65536))),
		TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,EXCunitTemp[1]),
		TSetMemory(_Add(G_TempV,28*(0x20/4)),SetTo,Gun_Type),
	})
	CElseX()
	DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
	CIfXEnd()
	f_LoadCp()
SetCallEnd()