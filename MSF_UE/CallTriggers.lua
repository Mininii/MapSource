

function Install_CallTriggers()

SaveCp_CallIndex = SetCallForward()
SetCall(FP)
	SaveCp(FP,BackupCp)
SetCallEnd()
LoadCp_CallIndex = SetCallForward()
SetCall(FP)
	LoadCp(FP,BackupCp)
SetCallEnd()

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

G_TempH = CreateVar()
G_InputH = CreateVar({"X",0x500,0x15C,1,0})
Var_TempTable = {}
Var_InputCVar = {}
Var_Lines = 30
for i = 1, Var_Lines do
	table.insert(Var_TempTable,CreateVar())
	table.insert(Var_InputCVar,SetCVar(FP,Var_TempTable[i][2],SetTo,0))
end
CheckTemp = CreateVar()

Call_Repeat = SetCallForward()
SetCall(FP)
CWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Spawn_TempW[2],AtLeast,1)})
	Gun_Order = def_sIndex()
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
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CSub(FP,CheckTemp,Nextptrs,19025)
	f_Mod(FP,CheckTemp,_Mov(84))
	f_Repeat_ErrorCheck = def_sIndex()
	NJump(FP,f_Repeat_ErrorCheck,{CVar(FP,CheckTemp[2],AtLeast,1)},RotatePlayer({DisplayTextX(f_RepeatErr,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP))
	CDoActions(FP,{
		TCreateUnitWithProperties(1,Gun_TempSpawnSet1,1,P8,{energy = 100}),
--		TModifyUnitEnergy(All,Gun_TempSpawnSet1,P8,1,100);
	})
	CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
	CDoActions(FP,{
		TSetDeathsX(_Add(Nextptrs,19),SetTo,14*256,0,0xFF00),
		TSetDeaths(_Add(Nextptrs,22),SetTo,TempBarPos,0),
	})
	CIfEnd()
	NJumpEnd(FP,f_Repeat_ErrorCheck)
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
		NIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,201))
		OverC_Jump = def_sIndex()
		NJumpX(FP,OverC_Jump,{CVar(FP,Var_TempTable[2][2],AtMost,48*32),CVar(FP,CPosX[2],AtLeast,48*32)})
		NJumpX(FP,OverC_Jump,{CVar(FP,Var_TempTable[2][2],AtLeast,48*32),CVar(FP,CPosX[2],AtMost,48*32)})
		NIfEnd()
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY) -- 좌상
		CMov(FP,Repeat_TempV,1)
		CMov(FP,Gun_TempSpawnSet1,Gun_TempSpawnSet3)
		CallTriggerX(FP,Set_Repeat)
		CMov(FP,Gun_TempSpawnSet1,Gun_TempSpawnSet2)
		CMov(FP,Repeat_TempV,1)
		CallTriggerX(FP,Set_Repeat)
		NJumpXEnd(FP,OverC_Jump)
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
function GunBreak(GName,Point)

local Text = "\n\n\n\x13- \x0E- \x0F-\x11 Ｓｔｒｕｃｔｕｒｅ \x04－ "..GName.." \x04 파괴!! \x1F+ "..Point.." P t s \x11- \x0E- \x0F-\n"
DoActions(FP,{
	RotatePlayer({DisplayTextX(Text,4),PlayWAVX("staredit\\wav\\SpeedMessage.wav"),PlayWAVX("staredit\\wav\\SpeedMessage.wav"),PlayWAVX("staredit\\wav\\SpeedMessage.wav")},HumanPlayers,FP);
	SetScore(Force1,Add,Point,Kills);
})
end
f_Gun = SetCallForward() -- 건작함수
SetCall(FP)
	CIf(FP,{CVar(FP,Var_TempTable[29][2],AtMost,255)}) -- 레어나 하이브 등의 건작일 경우

		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,201))--오버코쿤
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,5)
				GunBreak("\x07ＣｏＣｏｏｎ",77000)

			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Input_CSData(CustomShape[6],28,19,CVar(FP,Var_TempTable[6][2],Exactly,0))
				Input_CSData(CustomShape[6],86,79,CVar(FP,Var_TempTable[6][2],Exactly,1))
				CallTriggerX(FP,Load_CSArr)
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
		CIfEnd()


		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,148))--오버마인드
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,5)
				GunBreak("\x07ＯｖｅｒＭｉｎｄ",90000)

			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Input_CSData(CustomShape[5],56,77,CVar(FP,Var_TempTable[6][2],Exactly,0))
				Input_CSData(CustomShape[5],56,76,CVar(FP,Var_TempTable[6][2],Exactly,1))
				CallTriggerX(FP,Load_CSArr)
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
		CIfEnd()

		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,152))--셀브다고쓰
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,5)
				GunBreak("\x07Ｄａｇｇｏｔｈ",100000)

			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Input_CSData(CustomShape[6],21,25,CVar(FP,Var_TempTable[6][2],Exactly,0))
				Input_CSData(CustomShape[6],88,78,CVar(FP,Var_TempTable[6][2],Exactly,1))
				CallTriggerX(FP,Load_CSArr)
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
		CIfEnd()


		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,151))--셀브순대
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,4)
				GunBreak("\x07Ｃｅｒｅｂｒａｔｅ",120000)

			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Input_CSData(CustomShape[4],55,nil,CVar(FP,Var_TempTable[6][2],Exactly,0))
				Input_CSData(CustomShape[4],56,nil,CVar(FP,Var_TempTable[6][2],Exactly,1))
				CallTriggerX(FP,Load_CSArr)
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
		CIfEnd()

		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,130))--감커

			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,500)})
				CMov(FP,ReserveBGM,5)
				GunBreak("\x07Ｇｒａｖｉｔｙ　Ｃｅｎｔｅｒ",150000)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,500))
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(6*0x20)/4),SetTo,10)})
			CIfEnd()
			TriggerX(FP,{CVar(FP,Var_TempTable[2][2],AtMost,48*32)},{SetCVar(FP,CUID[2],SetTo,88)},{Preserved})
			TriggerX(FP,{CVar(FP,Var_TempTable[2][2],AtLeast,48*32)},{SetCVar(FP,CUID[2],SetTo,21)},{Preserved})

			NWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Var_TempTable[7][2],AtLeast,1)})
			CMov(FP,0x6509B0,FP)
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CMov(FP,RandSpeed,_Mod(_Rand(),2500),500)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
				
			CDoActions(FP,{
				TCreateUnitWithProperties(1,CUID,1,P8,{energy = 100}),
			})
			CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
			CDoActions(FP,{
				TSetDeaths(_Add(Nextptrs,13),SetTo,RandSpeed,0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,RandSpeed,0,0xFFFF),
				TSetDeathsX(_Add(Nextptrs,19),SetTo,187*256,0,0xFF00),
			})
			CIfEnd()
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(6*0x20)/4),Subtract,1),SetCVar(FP,Var_TempTable[7][2],Subtract,1)})
		NWhileEnd()
		CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,20)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,133))--하이브
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,4)
				GunBreak("\x07Ｈｉｖｅ",50000)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,0))
					Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
						{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
					f_TempRepeat(77,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(78,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(56,9)
					f_TempRepeat(104,15)
					f_TempRepeat(48,7)
					f_TempRepeat(51,15)
					Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
						{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
					f_TempRepeat(77,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(78,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(56,9)
					f_TempRepeat(104,15)
					f_TempRepeat(48,7)
					f_TempRepeat(51,15)
					Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
						{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
					f_TempRepeat(77,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(78,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(56,9)
					f_TempRepeat(104,15)
					f_TempRepeat(48,7)
					f_TempRepeat(51,15)
					Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
						{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
					f_TempRepeat(77,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(78,5,{CVar(FP,Level[2],AtLeast,6)})
					f_TempRepeat(56,9)
					f_TempRepeat(104,15)
					f_TempRepeat(48,7)
					f_TempRepeat(51,15)
					CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
					CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
					CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CIfEnd()
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,1))
					Input_CSData(CustomShape[1],48,55,CVar(FP,Var_TempTable[6][2],Exactly,0))
					Input_CSData(CustomShape[1],104,56,CVar(FP,Var_TempTable[6][2],Exactly,1))
					Input_CSData(CustomShape[1],51,56,CVar(FP,Var_TempTable[6][2],Exactly,2))
					CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
					CallTriggerX(FP,Load_CSArr)
				CIfEnd()
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,2))
					Input_CSData(CustomShape[2],55,nil,CVar(FP,Var_TempTable[6][2],Exactly,0))
					Input_CSData(CustomShape[2],56,nil,CVar(FP,Var_TempTable[6][2],Exactly,1))
					Input_CSData(CustomShape[2],56,nil,CVar(FP,Var_TempTable[6][2],Exactly,2))
					CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
					CallTriggerX(FP,Load_CSArr)
				CIfEnd()
				CIf(FP,CVar(FP,Var_TempTable[4][2],Exactly,3))
					Input_CSData(CustomShape[3],54,53,CVar(FP,Var_TempTable[6][2],Exactly,0))
					Input_CSData(CustomShape[3],55,53,CVar(FP,Var_TempTable[6][2],Exactly,1))
					Input_CSData(CustomShape[3],56,48,CVar(FP,Var_TempTable[6][2],Exactly,2))
					CallTriggerX(FP,Load_CSArr)
					CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
				CIfEnd()
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,10)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
			CIfEnd()
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,132))--레어
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				GunBreak("\x07Ｌａｉｒ",40000)
				CMov(FP,ReserveBGM,3)
			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
				f_TempRepeat(17,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(25,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
				f_TempRepeat(17,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(25,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
				f_TempRepeat(17,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(25,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
				f_TempRepeat(17,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(25,5,{CVar(FP,Level[2],AtLeast,6)})
				f_TempRepeat(55,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(56,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(53,10)
				f_TempRepeat(48,7)
				f_TempRepeat(54,10)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
			CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
		CIfEnd()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,131))--해처리
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,2)
				GunBreak("\x07Ｈａｔｃｈｅｒｙ",30000)
			CIfEnd()
	
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
					{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
				f_TempRepeat(43,9,CVar(FP,Var_TempTable[6][2],Exactly,0))
				f_TempRepeat(44,9,CVar(FP,Var_TempTable[6][2],Exactly,1))
				f_TempRepeat(38,10)
				f_TempRepeat(39,7)
				f_TempRepeat(37,10)
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
			CIfEnd()
			CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,2)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
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
		CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,7)},{TSetMemory(_Add(G_TempH,(29*0x20)/4),Add,1)},1)
		CIf(FP,CVar(FP,Level[2],AtLeast,11))
			f_TempRepeatX(_Mod(_Rand(),_Mov(#HeroArr)),_Sub(Level,10))
		CIfEnd()
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
	_0DPatchX(FP,f_GunNumT,5)
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
	G_SkipJump = def_sIndex()
	CJumpEnd(FP,G_SkipJump)
	CAdd(FP,G_TempV,_Mul(G_CA,_Mov(0x970/4)),G_InputH)
	NIf(FP,{TMemory(G_TempV,AtLeast,1),CVar(FP,G_CA[2],AtMost,63)},{SetCVar(FP,G_CA[2],Add,1)})
		CJump(FP,G_SkipJump)
	NIfEnd()

	CIfX(FP,{CVar(FP,G_CA[2],AtMost,63)})
	CDoActions(FP,{
		TSetMemory(G_TempV,SetTo,GunID),
		TSetMemory(_Add(G_TempV,1*(0x20/4)),SetTo,_ReadF(BackupPosData,0xFFFF)),
		TSetMemory(_Add(G_TempV,2*(0x20/4)),SetTo,_Div(_ReadF(BackupPosData,0xFFFF0000),_Mov(65536))),
		TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,EXCunitTemp[1]),
		TSetMemory(_Add(G_TempV,28*(0x20/4)),SetTo,Gun_Type),
	})
	
	if Limit == 1 then
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
	CIf(FP,{TMemory(_Add(UnitIDV,EPD(0x662350)),AtMost,7999999*256)})
		f_Mul(FP,TempLvHP,VArr(MaxHPBackUp,UnitIDV),MultiplierV)
		f_Read(FP,_Add(UnitIDV,EPD(0x662350)),TempLvHP2)
		CIfX(FP,{TMemory(_Mem(_Add(TempLvHP2,TempLvHP)),AtLeast,8000000*256)})
			CDoActions(FP,{TSetMemory(_Add(UnitIDV,EPD(0x662350)),SetTo,8000000*256)})
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
	f_Read(FP,BackupCP,CPosX,"X",0xFFFF)
	f_Read(FP,BackupCP,CPosY,"X",0xFFFF0000)
	f_Read(FP,_Add(BackupCP,1),Gun_LV,"X",0xFF000000)
	f_Read(FP,_Add(BackupCP,1),CunitP,"X",0xFF00)
	f_Read(FP,_Add(BackupCP,1),RepHeroIndex,"X",0xFF)
	f_Div(FP,CPosY,_Mov(0x10000)) -- 0
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

end