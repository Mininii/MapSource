
function InstallGunData()
	function Case_OverCocoon()
		CIf(FP,CVar(FP,Var_TempTable[1][2],Exactly,201))--오버코쿤
			CIf(FP,{CVar(FP,Var_TempTable[5][2],AtMost,0),CVar(FP,Var_TempTable[6][2],Exactly,0)})
				CDoActions(FP,{TSetMemory(_Add(G_TempH,(4*0x20)/4),Add,15000)})
				CMov(FP,ReserveBGM,5)
				GunBreak("\x07ＣｏＣｏｏｎ",77000)

			CIfEnd()
			CIf(FP,CVar(FP,Var_TempTable[5][2],AtLeast,15000))
				G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},G_L1,{28,19},{"ACAS","ACAS"},{CC_L,CC_L},{255,255})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},G_L1,{86,79},{"ACAS","ACAS"},{CC_L,CC_L},{255,255})
				G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},G_L1,{28,19},{"ACAS","ACAS"},{CC_R,CC_R},{255,255})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},G_L1,{86,79},{"ACAS","ACAS"},{CC_R,CC_R},{255,255})
				CTrigger(FP,{CVar(FP,Var_TempTable[6][2],AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
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
			G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{56,77},{"ACAS","ACAS"},{Ovrm,Ovrm},{255,255})
			G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{56,76},{"ACAS","ACAS"},{Ovrm,Ovrm},{255,255})
			CTrigger(FP,{Gun_Line(5,AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
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
			G_CA_SetSpawn({Gun_Line(5,Exactly,0)},G_L1,{21,25},{"ACAS","ACAS"},{CC_L,CC_L},{255,255})
			G_CA_SetSpawn({Gun_Line(5,Exactly,0)},G_L2,{21,25},{"ACAS","ACAS"},{CC_R,CC_R},{255,255})
			G_CA_SetSpawn({Gun_Line(5,Exactly,1)},G_L1,{88,78},{"ACAS","ACAS"},{CC_L,CC_L},{255,255})
			G_CA_SetSpawn({Gun_Line(5,Exactly,1)},G_L2,{88,78},{"ACAS","ACAS"},{CC_R,CC_R},{255,255})
			CTrigger(FP,{Gun_Line(5,AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
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
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtMost,48*32)},G_L1,{55},{"ACAS"},{Cere_L},{255})
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtMost,48*32)},G_L1,{56},{"ACAS"},{Cere_L},{255})
		G_CA_SetSpawn({Gun_Line(5,Exactly,0),Gun_Line(1,AtLeast,48*32)},G_L1,{55},{"ACAS"},{Cere_R},{255})
		G_CA_SetSpawn({Gun_Line(5,Exactly,1),Gun_Line(1,AtLeast,48*32)},G_L1,{56},{"ACAS"},{Cere_R},{255})
			CTrigger(FP,{Gun_Line(5,AtLeast,1)},{Gun_DoSuspend()},1)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CIfEnd()
	CIfEnd()
	end

	function Case_InfestedCommand()
		local RandSpeed = CreateVar()
		local CUID = CreateVar()
		CIf(FP,Gun_Line(0,Exactly,130))--감커
		CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,500)})
			CMov(FP,ReserveBGM,5)
			GunBreak("\x07Ｇｒａｖｉｔｙ　Ｃｅｎｔｅｒ",150000)
		CIfEnd()
		CIf(FP,Gun_Line(4,AtLeast,500))
			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
			CMov(FP,Spawn_TempW,10)
		CIfEnd()
		TriggerX(FP,{Gun_Line(1,AtMost,48*32)},{SetCVar(FP,CUID[2],SetTo,88)},{Preserved})
		TriggerX(FP,{Gun_Line(1,AtLeast,48*32)},{SetCVar(FP,CUID[2],SetTo,21)},{Preserved})
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
		DoActions(FP,{CreateUnit(1,ObEff,1,FP),KillUnit(ObEff,FP)})
		CSub(FP,Spawn_TempW,1)
	NWhileEnd()
	CMov(FP,Spawn_TempW,0)
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
			CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
				CIf(FP,Gun_Line(3,Exactly,0))
					CIf(FP,{LvT(ATMost,3)})
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
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						CIf(FP,Gun_Line(5,Exactly,0))
							G_CA_SetSpawn(nil,G_L1,{56},{P_6},{3})
							G_CA_SetSpawn(nil,G_L2,{54,104},{S_8,S_6},{2,1})
							G_CA_SetSpawn(nil,G_L3,{51,48},{P_8,S_6},{2,1})
							G_CA_SetSpawn(nil,G_L4,{48,53},{S_8,S_6},{2,2})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,1))
							G_CA_SetSpawn(nil,G_L1,{56},{P_6},{3})
							G_CA_SetSpawn(nil,G_L2,{54,104},{S_8,S_6},{2,1})
							G_CA_SetSpawn(nil,G_L3,{51,48},{S_3,S_6},{3,1})
							G_CA_SetSpawn(nil,G_L4,{48,53,77,78},{S_8,S_6,P_5,S_4},{1,1,4,1})
						CIfEnd()
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						CIf(FP,Gun_Line(5,Exactly,0))
							G_CA_SetSpawn(nil,G_L1,{88,77},{P_5,S_6},{2,2})
							G_CA_SetSpawn(nil,G_L4,{77,78},{P_5,S_4},{4,1})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,1))
							G_CA_SetSpawn(nil,G_L1,{28,77},{P_6,S_6},{1,2})
							G_CA_SetSpawn(nil,G_L4,{79,75},{P_7,P_5},{2,2})
						CIfEnd()
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						CIf(FP,Gun_Line(5,Exactly,0))
							G_CA_SetSpawn(nil,G_L1,{98,75},{S_3,S_8},{1,2})
							G_CA_SetSpawn(nil,G_L4,{79,75},{P_7,P_5},{2,2})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,1))
							G_CA_SetSpawn(nil,G_L1,{29,75},{S_7,S_8},{0,2})
							G_CA_SetSpawn(nil,G_L4,{76,19},{S_5,P_4},{2,3})
						CIfEnd()
					CIfEnd()
				CTrigger(FP,{Gun_Line(5,AtLeast,1),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CIf(FP,Gun_Line(3,Exactly,1))
					CIf(FP,{LvT(ATMost,3)})

						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{48,55},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{104,56},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{51,56},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{51,56},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{77,56},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{78,88},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{76,56},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{25,56},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{79,21},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{51,28},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{86,21},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{75,98},{"ACAS","ACAS"},{Hive_1,Hive_1},{255,255})
					CIfEnd()
					CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CIf(FP,Gun_Line(3,Exactly,2))
					CIf(FP,{LvT(ATMost,3)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{55},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{56},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{56},{"ACAS"},{Hive_2},{255})
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{56},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{88},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{21},{"ACAS"},{Hive_2},{255})
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{21},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{28},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{86},{"ACAS"},{Hive_2},{255})
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{86},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{98},{"ACAS"},{Hive_2},{255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{29},{"ACAS"},{Hive_2},{255})
					CIfEnd()
					CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CIf(FP,Gun_Line(3,Exactly,3))
					CIf(FP,{LvT(ATMost,3)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{54,53},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{55,53},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{56,48},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
					CIfEnd()
					CIf(FP,{LvT(AtLeast,4),LvT(ATMost,6)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{48,55},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{51,55},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{104,56},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
					CIfEnd()
					CIf(FP,{LvT(AtLeast,7),LvT(ATMost,9)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{77,78},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{25,88},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{17,21},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
					CIfEnd()
					CIf(FP,{LvT(Exactly,10)})
						G_CA_SetSpawn(Gun_Line(5,Exactly,0),G_L1,{19,28},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,1),G_L1,{79,98},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
						G_CA_SetSpawn(Gun_Line(5,Exactly,2),G_L1,{75,29},{"ACAS","ACAS"},{Hive_3,Hive_3},{255,255})
					CIfEnd()
					CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
				CIfEnd()
				CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
				CDoActions(FP,{Gun_SetLine(5,Add,1)})
				CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
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
		CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
			CIf(FP,{LvT(AtLeast,4),LvT(AtMost,6)})
				CIf(FP,Gun_Line(5,Exactly,0))
					G_CA_SetSpawn(nil,G_L1,{55},{P_6},{3})
					G_CA_SetSpawn(nil,G_L2,{54,104},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,G_L3,{51,48},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,G_L4,{48,53},{S_8,S_6},{1,1})
				CIfEnd()
				CIf(FP,Gun_Line(5,Exactly,1))
					G_CA_SetSpawn(nil,G_L1,{56},{P_6},{4})
					G_CA_SetSpawn(nil,G_L2,{54,104},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,G_L3,{51,48},{S_8,S_6},{1,1})
					G_CA_SetSpawn(nil,G_L4,{48,53},{S_8,S_6},{1,1})
				CIfEnd()
			CIfEnd()
			
			CIf(FP,{LvT(AtLeast,7),LvT(AtMost,9)})
				CIf(FP,Gun_Line(5,Exactly,0))
					G_CA_SetSpawn(nil,G_L2,{77,88},{S_4,P_6},{1,5})
					G_CA_SetSpawn(nil,G_L4,{78},{S_4},{1})
				CIfEnd()
				CIf(FP,Gun_Line(5,Exactly,1))
					G_CA_SetSpawn(nil,G_L2,{77,21},{P_7,S_7},{3,3})
					G_CA_SetSpawn(nil,G_L4,{78},{P_7},{3})
				CIfEnd()
			CIfEnd()

			CIf(FP,{LvT(Exactly,10)})
				CIf(FP,Gun_Line(5,Exactly,0))
					G_CA_SetSpawn(nil,G_L1,{21},{S_6},{2})
					G_CA_SetSpawn(nil,G_L2,{77},{S_5},{1})
					G_CA_SetSpawn(nil,G_L4,{78},{P_7},{3})
				CIfEnd()
				CIf(FP,Gun_Line(5,Exactly,1))
					G_CA_SetSpawn(nil,G_L1,{80},{S_5},{2})
					G_CA_SetSpawn(nil,G_L2,{77},{S_5},{2})
					G_CA_SetSpawn(nil,G_L4,{78},{P_6},{3})
				CIfEnd()
			CIfEnd()

			CIf(FP,{LvT(AtMost,3)})
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
			CIfEnd()


			CDoActions(FP,{Gun_SetLine(4,SetTo,0)})
			CDoActions(FP,{Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
	CIfEnd()
	end

	function Case_Hatchery()

		CIf(FP,Gun_Line(0,Exactly,131))--해처리
		CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,15000)})
			CMov(FP,ReserveBGM,2)
			GunBreak("\x07Ｈａｔｃｈｅｒｙ",30000)
		CIfEnd()

		CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
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
		CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
	CIfEnd()
	end


	function Case_Test()
		if TestStart == 1 then
			CIf(FP,Gun_Line(0,Exactly,146))--테스트용 유닛
				CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
					CMov(FP,ReserveBGM,2)
					CDoActions(FP,{Gun_SetLine(4,Add,15000)})
					
					G_CA_SetSpawn(nil,G_L1,{77,55,56,104},{S_4,P_5,P_3,S_8},{3,6,6,2})
					GunBreak("\x07테스트용 썽큰~~~~~~~~~~~~~~~~",322322)
				CIfEnd()
				CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
					CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
				CIfEnd()
				CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
			CIfEnd()
			CIf(FP,Gun_Line(0,Exactly,136))--테스트용 유닛
				CIf(FP,{Gun_Line(4,AtMost,0),Gun_Line(5,Exactly,0)})
					CMov(FP,ReserveBGM,2)
					CDoActions(FP,{Gun_SetLine(4,Add,15000)})
					
					G_CA_SetSpawn(nil,G_L1,{55,56,55,56},{NBYD,NBYD,NBYD,NBYD})
					GunBreak("\x07테스트용 디파파~~~~~~~~~~~~~~~~",322322)
				CIfEnd()
				CIf(FP,{Gun_Line(4,AtLeast,15000),G_CA_CondStack})
					CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
				CIfEnd()
				CTrigger(FP,{Gun_Line(5,AtLeast,2),G_CA_CondStack},{Gun_DoSuspend()},1)
			CIfEnd()
		end
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
end

