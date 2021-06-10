function Case_OverCocoon()
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
			CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1)},{Gun_DoSuspend()},1)
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),SetTo,0)})
			CDoActions(FP,{TSetMemory(_Add(G_TempH,(5*0x20)/4),Add,1)})
		CIfEnd()
	CIfEnd()
end

function Case_Overmind()
	CIf(FP,{Gun_Line(0,exactly,148)})--오버마인드
	CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(4,Add,15000)})
		CMov(FP,ReserveBGM,5)
		GunBreak("\x07ＯｖｅｒＭｉｎｄ",90000)

	CIfEnd()
	CIf(FP,Gun_Line(4,AtLeast,15000))
		Input_CSData(CustomShape[5],56,77,Gun_Line(5,Exactly,0))
		Input_CSData(CustomShape[5],56,76,Gun_Line(5,Exactly,1))
		CallTriggerX(FP,Load_CSArr)

		CTrigger(FP,{Gun_Line(5,AtLeast,1)},{Gun_DoSuspend()},1)
		CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
		CDoActions(FP,{Gun_SetLine(5,Add,1)})
	CIfEnd()
CIfEnd()
end

function Case_Daggoth()
	CIf(FP,Gun_Line(0,Exactly,152))--셀브다고쓰
	CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(4,Add,15000)})
		CMov(FP,ReserveBGM,5)
		GunBreak("\x07Ｄａｇｇｏｔｈ",100000)

	CIfEnd()
	CIf(FP,Gun_Line(4,AtLeast,15000))
		Input_CSData(CustomShape[6],21,25,Gun_Line(5,Exactly,0))
		Input_CSData(CustomShape[6],88,78,Gun_Line(5,Exactly,1))
		CallTriggerX(FP,Load_CSArr)
		CTrigger(FP,{Gun_Line(5,AtLeast,1)},{Gun_DoSuspend()},1)
		CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
		CDoActions(FP,{Gun_SetLine(5,Add,1)})
	CIfEnd()
	CIfEnd()
end

function Case_Cerebrate()
	CIf(FP,Gun_Line(0,Exactly,151))--셀브순대
	CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(4,Add,15000)})
		CMov(FP,ReserveBGM,4)
		GunBreak("\x07Ｃｅｒｅｂｒａｔｅ",120000)

	CIfEnd()
	CIf(FP,Gun_Line(4,AtLeast,15000))
		Input_CSData(CustomShape[4],55,nil,Gun_Line(5,Exactly,0))
		Input_CSData(CustomShape[4],56,nil,Gun_Line(5,Exactly,1))
		CallTriggerX(FP,Load_CSArr)
		CTrigger(FP,{Gun_Line(5,AtLeast,1)},{Gun_DoSuspend()},1)
		CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
		CDoActions(FP,{Gun_SetLine(5,Add,1)})
	CIfEnd()
CIfEnd()
end

function Case_InfestedCommand()
	CIf(FP,Gun_Line(0,Exactly,130))--감커
	CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(4,Add,500)})
		CMov(FP,ReserveBGM,5)
		GunBreak("\x07Ｇｒａｖｉｔｙ　Ｃｅｎｔｅｒ",150000)
	CIfEnd()
	CIf(FP,Gun_Line(4,AtLeast,500))
		CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
		CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CDoActions(FP,{Gun_SetLine(6,Add,10)})
	CIfEnd()
	TriggerX(FP,{Gun_Line(1,AtMost,48*32)},{SetCVar(FP,CUID[2],SetTo,88)},{Preserved})
	TriggerX(FP,{Gun_Line(1,AtLeast,48*32)},{SetCVar(FP,CUID[2],SetTo,21)},{Preserved})
	CMov(FP,Spawn_TempW,Var_TempTable[7])
	NWhile(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Spawn_TempW[2],AtLeast,1)})
	CMov(FP,0x6509B0,FP)
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CMov(FP,RandSpeed,_Mod(_Rand(),2500),500)
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
	DoActions(FP,{CreateUnit(3,84,1,FP),KillUnit(84,FP)})
	CSub(FP,Spawn_TempW,1)
NWhileEnd()
CDoActions(FP,{Gun_SetLine(6,Add,Spawn_TempW)})
CTrigger(FP,{Gun_Line(5,AtLeast,20)},{Gun_DoSuspend()},1)
CIfEnd()
end

function Case_Hive()
	CIf(FP,Gun_Line(0,Exactly,133))--하이브
	CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(4,Add,15000)})
		CMov(FP,ReserveBGM,4)
		GunBreak("\x07Ｈｉｖｅ",50000)
	CIfEnd()
	CIf(FP,Gun_Line(4,AtLeast,15000))
		CIf(FP,Gun_Line(3,Exactly,0))
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
				{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
			f_TempRepeat(56,9)
			f_TempRepeat(104,15)
			f_TempRepeat(48,7)
			f_TempRepeat(51,15)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
				{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
			f_TempRepeat(56,9)
			f_TempRepeat(104,15)
			f_TempRepeat(48,7)
			f_TempRepeat(51,15)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
				{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
			f_TempRepeat(56,9)
			f_TempRepeat(104,15)
			f_TempRepeat(48,7)
			f_TempRepeat(51,15)
			Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
				{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
			f_TempRepeat(56,9)
			f_TempRepeat(104,15)
			f_TempRepeat(48,7)
			f_TempRepeat(51,15)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
			CTrigger(FP,{Gun_Line(5,AtLeast,1)},{Gun_DoSuspend()},1)
		CIfEnd()
		CIf(FP,Gun_Line(3,Exactly,1))
			Input_CSData(CustomShape[1],48,55,Gun_Line(5,Exactly,0))
			Input_CSData(CustomShape[1],104,56,Gun_Line(5,Exactly,1))
			Input_CSData(CustomShape[1],51,56,Gun_Line(5,Exactly,2))
			CTrigger(FP,{Gun_Line(5,AtLeast,2)},{Gun_DoSuspend()},1)
			CallTriggerX(FP,Load_CSArr)
		CIfEnd()
		CIf(FP,Gun_Line(3,Exactly,2))
			Input_CSData(CustomShape[2],55,nil,Gun_Line(5,Exactly,0))
			Input_CSData(CustomShape[2],56,nil,Gun_Line(5,Exactly,1))
			Input_CSData(CustomShape[2],56,nil,Gun_Line(5,Exactly,2))
			CTrigger(FP,{Gun_Line(5,AtLeast,2)},{Gun_DoSuspend()},1)
			CallTriggerX(FP,Load_CSArr)
		CIfEnd()
		CIf(FP,Gun_Line(3,Exactly,3))
			Input_CSData(CustomShape[3],54,53,Gun_Line(5,Exactly,0))
			Input_CSData(CustomShape[3],55,53,Gun_Line(5,Exactly,1))
			Input_CSData(CustomShape[3],56,48,Gun_Line(5,Exactly,2))
			CallTriggerX(FP,Load_CSArr)
			CTrigger(FP,{Gun_Line(5,AtLeast,2)},{Gun_DoSuspend()},1)
		CIfEnd()
		CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
		CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CTrigger(FP,{Gun_Line(5,AtLeast,10)},{Gun_DoSuspend()},1)
	CIfEnd()
CIfEnd()
end

function Case_Lair()

	CIf(FP,Gun_Line(0,Exactly,132))--레어
	CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(4,Add,15000)})
		GunBreak("\x07Ｌａｉｒ",40000)
		CMov(FP,ReserveBGM,3)
	CIfEnd()
	CIf(FP,Gun_Line(4,AtLeast,15000))
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
		f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(53,10)
		f_TempRepeat(48,7)
		f_TempRepeat(54,10)
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
		f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(53,10)
		f_TempRepeat(48,7)
		f_TempRepeat(54,10)
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
		f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(53,10)
		f_TempRepeat(48,7)
		f_TempRepeat(54,10)
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
		f_TempRepeat(55,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(56,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(53,10)
		f_TempRepeat(48,7)
		f_TempRepeat(54,10)
		CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
		CDoActions(FP,{Gun_SetLine(5,Add,1)})
	CIfEnd()
	CTrigger(FP,{Gun_Line(5,AtLeast,2)},{Gun_DoSuspend()},1)
CIfEnd()
end

function Case_Hatchery()

	CIf(FP,Gun_Line(0,Exactly,131))--해처리
	CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(4,Add,15000)})
		CMov(FP,ReserveBGM,2)
		GunBreak("\x07Ｈａｔｃｈｅｒｙ",30000)
	CIfEnd()

	CIf(FP,Gun_Line(4,AtLeast,15000))
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,-32*4 + (-32*7),-32*4 + (-32*7),-32*4 + (32*7),-32*4 + (32*7))}) -- 좌상
		f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(38,10)
		f_TempRepeat(39,7)
		f_TempRepeat(37,10)
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,32*4 + (-32*7),-32*4 + (-32*7),32*4 + (32*7),-32*4 + (32*7))}) -- 우상
		f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(38,10)
		f_TempRepeat(39,7)
		f_TempRepeat(37,10)
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,-32*4 + (-32*7),32*4 + (-32*7),-32*4 + (32*7),32*4 + (32*7))}) -- 좌하
		f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(38,10)
		f_TempRepeat(39,7)
		f_TempRepeat(37,10)
		Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3],
			{Simple_CalcLoc(0,32*4 + (-32*7),32*4 + (-32*7),32*4 + (32*7),32*4 + (32*7))}) -- 우하
		f_TempRepeat(43,9,Gun_Line(5,Exactly,0))
		f_TempRepeat(44,9,Gun_Line(5,Exactly,1))
		f_TempRepeat(38,10)
		f_TempRepeat(39,7)
		f_TempRepeat(37,10)
		CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
		CDoActions(FP,{Gun_SetLine(5,Add,1)})
	CIfEnd()
	CTrigger(FP,{Gun_Line(5,AtLeast,2)},{Gun_DoSuspend()},1)
CIfEnd()
end

function Case_Various()
	CIf(FP,{CVar(FP,Var_TempTable[29][2],AtLeast,256)}) -- 잡건작일 경우
		CIf(FP,{Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,2500)})
		CIfEnd()
		CIf(FP,Gun_Line(4,AtLeast,2500))
			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
			CDoActions(FP,{Gun_SetLine(6,Add,15)})
			CDoActions(FP,{Gun_SetLine(7,Add,10)})
			CDoActions(FP,{Gun_SetLine(8,Add,5)})
			CDoActions(FP,{Gun_SetLine(9,Add,3)})
		CIfEnd()
		TriggerX(FP,{Gun_Line(0,Exactly,137)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,142)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,135)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,140)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,48)},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,141)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,55)},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,51)},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,53)},{Preserved})
		f_Repeat(7)
		CMov(FP,Gun_TempSpawnSet1,0)
		TriggerX(FP,{Gun_Line(0,Exactly,139)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,54)},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,104)},{Preserved})
		f_Repeat(8)
		CMov(FP,Gun_TempSpawnSet1,0)
		TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,56)},{Preserved})
		f_Repeat(9)
		CMov(FP,Gun_TempSpawnSet1,0)
		TriggerX(FP,{Gun_Line(0,Exactly,138)},{SetCVar(FP,Gun_TempSpawnSet1[2],SetTo,45)},{Preserved})
		f_Repeat(10)
		CTrigger(FP,{Gun_Line(5,AtLeast,7)},{Gun_DoSuspend()},1)
		CIf(FP,CVar(FP,Level[2],AtLeast,11))
			f_TempRepeatX(_Mod(_Rand(),_Mov(#HeroArr)),_Sub(Level,10))
		CIfEnd()
	CIfEnd()
end