
function GunData()
	local G_TempW = CreateVar(FP)
	local CurLoc,CurLoc2 = CreateVars(2,FP)
	f_Gun = SetCallForward()
	SetCall(FP)

	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
	DoActions(FP,{SetSwitch(RandSwitch,Random)})
	CIf(FP,TTOR({Gun_Line(0,Exactly,132),Gun_Line(0,Exactly,133)})) -- BdIndex LAIR HIVE

		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0),Gun_Line(0,Exactly,132)})
			CDoActions(FP,{Gun_SetLine(4,Add,f_CRandNum(80,395))})
			GunBreak("기지 \x18Lair \x04를",20000,2)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
--			G_CA_SetSpawn(nil,{54},"ACAS",{"NBYD"})
--			G_CA_SetSpawn(nil,{54},{S_5},{2})
		CIfEnd()
		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0),Gun_Line(0,Exactly,133)})
			CDoActions(FP,{Gun_SetLine(4,Add,f_CRandNum(80,395))})
			GunBreak("기지 \x18Hive \x04를",30000,4)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
--			G_CA_SetSpawn(nil,{55},"ACAS",{"NBYD"})
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 3, GMode),Command(Force2,Exactly,0,"Stasis Cell/Prison")},{23,74,88},{P_6,S_3,P_3},{1,1,4},"MAX",nil,nil,{3776,3808})
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 3, GMode),Command(Force2,Exactly,1,"Stasis Cell/Prison")},{74,88},{S_3,P_3},{1,4},"MAX",nil,nil,{3776,3808})
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 3, GMode),Command(Force2,Exactly,2,"Stasis Cell/Prison")},{88},{P_3},{4},"MAX",nil,nil,{3776,3808})
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 2, GMode)},{103},{S_8},{3},{10},2,nil,{3776,3808})

		CIfEnd()

		CMov(FP,CurLoc,_Mul(f_GunNum,_Mov(20/4)))
		CMov(FP,CurLoc2,_Add(f_GunNum,190-64))
		
		CDoActions(FP,{TSetMemory(_Add(CurLoc,EPDF(0x58DC60 + (20*(189-64)))),SetTo,_Sub(Var_TempTable[2],32*9))})
		CDoActions(FP,{TSetMemory(_Add(CurLoc,EPDF(0x58DC64 + (20*(189-64)))),SetTo,_Sub(Var_TempTable[3],32*9))})
		CDoActions(FP,{TSetMemory(_Add(CurLoc,EPDF(0x58DC68 + (20*(189-64)))),SetTo,_Add(Var_TempTable[2],32*9))})
		CDoActions(FP,{TSetMemory(_Add(CurLoc,EPDF(0x58DC6C + (20*(189-64)))),SetTo,_Add(Var_TempTable[3],32*9))})
		
		
		CDoActions(FP,{TSetCtrig1X("X",0x580,CAddr("CMask",2),nil,SetTo,CurLoc2)})
		CDoActions(FP,{TSetCtrig1X("X",0x580,CAddr("CMask",3),nil,SetTo,CurLoc2)})
		CDoActions(FP,{TSetCtrig1X("X",0x581,CAddr("CMask",2),nil,SetTo,CurLoc2)})
		CDoActions(FP,{TSetCtrig1X("X",0x581,CAddr("CMask",3),nil,SetTo,CurLoc2)})
		CDoActions(FP,{TSetCtrig1X("X",0x582,CAddr("CMask",2),nil,SetTo,CurLoc2)})
	
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0x580);
				Bring(Force2, AtLeast, 6, "Men", 1);
				Bring(Force1, AtMost, 2, "Men", 1);
			},
			actions = {
				SetCVar(FP,PaneltyPoint[2],Add,1);
				PreserveTrigger();
			},
			}
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0x581);
				Bring(Force2, AtLeast, 6, "Men", 1);
				Bring(Force1, AtLeast, 3, "Men", 1);
			},
			actions = {
				SetCDeaths(FP,Add,1,BonusP);
				PreserveTrigger();
			},
			}
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0x582);
				Bring(Force2, AtMost, 5, "Men", 1);
			},
			actions = {
				SetCDeaths(FP,Add,1,BonusP);
				PreserveTrigger();
			},
			}



		CIf(FP,{Gun_Line(4,AtLeast,480)})
			CIf(FP,Gun_Line(5,AtMost,2))
				CMov(FP,UnitIDV1,0)
				CMov(FP,UnitIDV2,0)
				CMov(FP,UnitIDV3,0)
				CMov(FP,UnitIDV4,0)
				
				TriggerX(FP,{Gun_Line(0,Exactly,132),Gun_Line(5,Exactly,0)},{SetCVar(FP,UnitIDV4[2],SetTo,55)},{Preserved})
				TriggerX(FP,{Gun_Line(0,Exactly,132),Gun_Line(5,Exactly,1)},{SetCVar(FP,UnitIDV4[2],SetTo,56)},{Preserved})
				TriggerX(FP,{Gun_Line(0,Exactly,132),Gun_Line(5,Exactly,2)},{SetCVar(FP,UnitIDV4[2],SetTo,57)},{Preserved})
				TriggerX(FP,{Gun_Line(0,Exactly,133),Gun_Line(5,Exactly,0)},{SetCVar(FP,UnitIDV4[2],SetTo,56)},{Preserved})
				TriggerX(FP,{Gun_Line(0,Exactly,133),Gun_Line(5,Exactly,1)},{SetCVar(FP,UnitIDV4[2],SetTo,57)},{Preserved})
				TriggerX(FP,{Gun_Line(0,Exactly,133),Gun_Line(5,Exactly,2)},{SetCVar(FP,UnitIDV4[2],SetTo,62)},{Preserved})
				DoActions(FP,{
					SetSwitch("Switch 2",Random);
					SetSwitch("Switch 3",Random);
				})
				TriggerX(FP,{Gun_Line(5,Exactly,1),Gun_Line(3,Exactly,0)},{
					SetCVar(FP,UnitIDV1[2],SetTo,80);
					SetCVar(FP,UnitIDV2[2],SetTo,87);
				},{Preserved})
				TriggerX(FP,{Gun_Line(5,Exactly,2),Gun_Line(3,Exactly,0)},{
					SetCVar(FP,UnitIDV1[2],SetTo,21);
					SetCVar(FP,UnitIDV2[2],SetTo,15);
				},{Preserved})
				TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,1)},{
					SetCVar(FP,UnitIDV1[2],SetTo,28);
					SetCVar(FP,UnitIDV2[2],SetTo,17);
				},{Preserved})
				UnitIDV1Table = {77,10,75,76,65,32,79,89}
				UnitIDV2Table = {78,19,79,81,66,52,50,25}
				for i = 1, 8 do
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(0,Exactly,132),Gun_Line(3,Exactly,i+1)},{
						SetCVar(FP,UnitIDV2[2],SetTo,UnitIDV1Table[i]);-- 레어
					},{Preserved})
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(0,Exactly,133),Gun_Line(3,Exactly,i+1)},{
						SetCVar(FP,UnitIDV2[2],SetTo,UnitIDV2Table[i]);-- 하이브
					},{Preserved})
				end
				TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,AtLeast,2),Gun_Line(3,AtMost,5)},{
					SetCVar(FP,UnitIDV1[2],SetTo,56);
				},{Preserved})
				TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,AtLeast,6),Gun_Line(3,AtMost,9)},{
					SetCVar(FP,UnitIDV1[2],SetTo,57);
				},{Preserved})

				for i = 0, 1 do
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,(2+(i*4))),Switch("Switch 2",Cleared),Switch("Switch 3",Cleared)},{
						SetCVar(FP,UnitIDV3[2],SetTo,86);
					},{Preserved})
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,(3+(i*4))),Switch("Switch 2",Cleared),Switch("Switch 3",Set)},{
						SetCVar(FP,UnitIDV3[2],SetTo,86);
					},{Preserved})
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,(4+(i*4))),Switch("Switch 2",Set),Switch("Switch 3",Cleared)},{
						SetCVar(FP,UnitIDV3[2],SetTo,86);
					},{Preserved})
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,(5+(i*4))),Switch("Switch 2",Set),Switch("Switch 3",Set)},{
						SetCVar(FP,UnitIDV3[2],SetTo,86);
					},{Preserved})
				end
				TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(0,Exactly,132),Gun_Line(3,Exactly,10)},{
					SetCVar(FP,UnitIDV1[2],SetTo,27); -- 나머지 레어
				},{Preserved})
				TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(0,Exactly,133),Gun_Line(3,Exactly,10)},{
					SetCVar(FP,UnitIDV1[2],SetTo,102); -- 외곽 하이브
				},{Preserved})
				TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(0,Exactly,132),Gun_Line(3,Exactly,11)},{
					SetCVar(FP,UnitIDV1[2],SetTo,98); -- 안쪽 레어
				},{Preserved})
				TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(0,Exactly,133),Gun_Line(3,Exactly,11)},{
					SetCVar(FP,UnitIDV1[2],SetTo,29); -- 안쪽 하이브
				},{Preserved})
				local BreakCcode = CreateCCode()
				DoActionsX(FP,SetCDeaths(FP,SetTo,0,BreakCcode))
				LV_10_11_AirTable = {21,80,28,86,98,27,88,21,80,28,86,98,27,88,21,80,28,86,98,27,88,21,80,28,86,98,27,88}
				LV_10_UnitTable = {15,87,17,77,78,79,76,75,81,19,10,3,65,66,75,78,79,76,75,81,3,10,15,87,17,77}
				LV_11_UnitTable = {32,74,23,68,32,74,23,68,32,74,23,68}
				
				for i = 1, #LV_10_UnitTable do
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,10),CDeaths(FP,Exactly,i-1,LV_10_UnitTableCode),CDeaths(FP,Exactly,0,BreakCcode)},{
						SetCVar(FP,UnitIDV2[2],SetTo,LV_10_UnitTable[i]);
						SetCVar(FP,UnitIDV3[2],SetTo,LV_10_11_AirTable[i]);
						SetCDeaths(FP,Add,1,LV_10_UnitTableCode);SetCDeaths(FP,SetTo,1,BreakCcode)
					},{Preserved})
				end
				for i = 1, #LV_11_UnitTable do
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,11),CDeaths(FP,Exactly,i-1,LV_11_UnitTableCode),CDeaths(FP,Exactly,0,BreakCcode)},{
						SetCVar(FP,UnitIDV2[2],SetTo,LV_11_UnitTable[i]);
						SetCVar(FP,UnitIDV3[2],SetTo,LV_10_11_AirTable[i]);
						SetCDeaths(FP,Add,1,LV_11_UnitTableCode);SetCDeaths(FP,SetTo,1,BreakCcode)
					},{Preserved})
				end
				


				local ZergUnit1 = {40, 54}
				local ZergUnit2 = {53, 39}
				local ZergUnit3 = {54, 53}
				local ZergUnit4 = {104, 48, 51}
				UID1I = 221
				UID2I = 222
				UID3I = 223
				UID4I = 224 -- Zerg Air
				CIf(FP,{Gun_Line(0,Exactly,132)}) -- Case Lair
					CIf(FP,CGMode(1)) -- Case Easy
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID1I,UID2I},"ACAS",{"L00_1_164F","L00_1_164F"},"MAX")
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],Exactly,0)},{UID1I},"ACAS",{"L00_1_164F"},"MAX")
						G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS",{"L00_1_164F"},"MAX")
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,"ACAS",{"L00_1_96L","L00_1_96F"},"MAX")
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit2,"ACAS",{"L00_1_96L","L00_1_96F"},"MAX")
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit3,"ACAS",{"L00_1_96L","L00_1_96F","L00_1_64F"},"MAX")
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},"ACAS",{"L00_1_96L"},"MAX")
					CIfEnd()
					CIf(FP,CGMode(2)) -- Case Hard
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID1I,UID2I},"ACAS",{"L00_1_128F","L00_1_128F"})
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],Exactly,0)},{UID1I},"ACAS",{"L00_1_128F"})
						G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS",{"L00_1_128F"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,"ACAS",{"L00_1_64L","L00_1_64F"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit2,"ACAS",{"L00_1_64L","L00_1_64F"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit3,"ACAS",{"L00_1_64L","L00_1_64F","L00_1_64F"})
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},"ACAS",{"L00_1_96F"})



					CIfEnd()
					CIf(FP,CGMode(3)) -- Case Burst
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,{P_4,S_5},{4,2})
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit2,{S_6,P_8},{2,3})
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit3,{P_6,P_5,S_8},{3,3,2})
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},{S_5},{2})
						CIf(FP,Gun_Line(5,Exactly,1)) -- 1st
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_4},{1})
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_4},{1})
							CIf(FP,{Gun_Line(3,AtLeast,2),Gun_Line(3,AtMost,5)}) -- Lv2~5
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_6},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{S_3},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{S_5},{0})
							CIfEnd()
							CIf(FP,{Gun_Line(3,AtLeast,6),Gun_Line(3,AtMost,9)}) -- 6~9
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_6},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{S_3},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_5},{1})
							CIfEnd()
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_5},{0})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_4},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{S_6},{0})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_4},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_3},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{S_6},{1})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,2)) -- 2nd
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_4},{1})
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_7},{1})
							CIf(FP,{Gun_Line(3,AtLeast,2),Gun_Line(3,AtMost,5)}) -- Lv2~5
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_6},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_4},{3})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_5},{1})
							CIfEnd()
							CIf(FP,{Gun_Line(3,AtLeast,6),Gun_Line(3,AtMost,9)}) -- 6~9
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_6},{2})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_4},{3})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_5},{1})
							CIfEnd()
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_5},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I,UID2I},{S_3,S_4},{0,0})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_6},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_4},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_5},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_3},{3})
						CIfEnd()
					CIfEnd()
				CIfEnd()
				CIf(FP,{Gun_Line(0,Exactly,133)}) -- Case Hive
					CIf(FP,CGMode(1)) -- Case Easy
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID1I,UID2I},"ACAS",{"H00_1_128F","H00_1_128F"},"MAX")
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],Exactly,0)},{UID1I},"ACAS",{"H00_1_128F"},"MAX")
						G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS",{"H00_1_128F"},"MAX")
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit2,"ACAS",{"H00_1_96L","H00_1_96F"},"MAX")
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit3,"ACAS",{"H00_1_96L","H00_1_96F"},"MAX")
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit4,"ACAS",{"H00_1_96L","H00_1_96F","H00_1_64F"},"MAX")
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},"ACAS",{"H00_1_82L"},"MAX")
					CIfEnd()
					CIf(FP,CGMode(2)) -- Case Hard
					G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID1I,UID2I},"ACAS",{"H00_1_96F","H00_1_96F"})
					G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],Exactly,0)},{UID1I},"ACAS",{"H00_1_96F"})
					G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS",{"H00_1_96F"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit2,"ACAS",{"H00_1_64L","H00_1_64F"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit3,"ACAS",{"H00_1_64L","H00_1_64F"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit4,"ACAS",{"H00_1_64L","H00_1_64F","L00_1_64F"})
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},"ACAS",{"H00_1_82F"})


					CIfEnd()
					CIf(FP,CGMode(3)) -- Case Burst
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,{P_5,S_6},{4,2})
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit2,{S_7,S_5},{2,3})
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit3,{P_7,P_6,P_7},{3,3,4})
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},{S_6},{2})
						CIf(FP,Gun_Line(5,Exactly,1)) -- 1st
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_6},{1})
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_5},{2})
							CIf(FP,{Gun_Line(3,AtLeast,2),Gun_Line(3,AtMost,5)}) -- Lv2~5
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_8},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{S_5},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{S_3},{1})
							CIfEnd()
							CIf(FP,{Gun_Line(3,AtLeast,6),Gun_Line(3,AtMost,9)}) -- 6~9
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_8},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{S_5},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_5},{2})
							CIfEnd()
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_4},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_6},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{S_8},{0})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_4},{2})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_3},{2})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{S_8},{1})
						CIfEnd()
						CIf(FP,Gun_Line(5,Exactly,2)) -- 2nd
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_3},{2})
							G_CA_SetSpawn({Gun_Line(3,AtMost,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_7},{2})
							CIf(FP,{Gun_Line(3,AtLeast,2),Gun_Line(3,AtMost,5)}) -- Lv2~5
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_8},{1})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{S_3},{3})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_6},{1})
							CIfEnd()
							CIf(FP,{Gun_Line(3,AtLeast,6),Gun_Line(3,AtMost,9)}) -- 6~9
								G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_8},{2})
								G_CA_SetSpawn({CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_3},{5})
								G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_8},{1})
							CIfEnd()
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{P_7},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I,UID2I},{S_5,S_6},{0,0})
							G_CA_SetSpawn({Gun_Line(3,Exactly,10),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_8},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},{S_3},{2})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID2I},{P_8},{1})
							G_CA_SetSpawn({Gun_Line(3,Exactly,11),CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},{P_8},{2})
						CIfEnd()
					CIfEnd()
				CIfEnd()
			for i = 0, 11 do
				TriggerX(FP,{Gun_Line(5,AtLeast,2),Gun_Line(0,Exactly,132),Gun_Line(3,Exactly,i)},{SetCDeaths(FP,Subtract,1,CCode(0x1001,i))},{Preserved})
				TriggerX(FP,{Gun_Line(5,AtLeast,2),Gun_Line(0,Exactly,133),Gun_Line(3,Exactly,i)},{SetCDeaths(FP,Subtract,1,CCode(0x1002,i))},{Preserved})
			end
			CIfEnd()
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		
		CTrigger(FP,{Gun_Line(5,AtLeast,4),},{Gun_DoSuspend()},1)
	CIfEnd()
	CIf(FP,Gun_Line(0,Exactly,216)) -- BdIndex Chrysalis
		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,10)})
			GunBreak("번데기 \x18Small Chrysalis \x04를",45000,3)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
		CIfEnd()
		CIf(FP,{Gun_Line(4,AtLeast,5),Gun_Line(5,AtMost,39)})
			TriggerX(FP,{Gun_Line(3,Exactly,0)},{SetCVar(FP,UnitIDV1[2],SetTo,80)},{Preserved})
			TriggerX(FP,{Gun_Line(3,Exactly,1)},{SetCVar(FP,UnitIDV1[2],SetTo,21)},{Preserved})
			f_TempRepeatX(nil,84,1)
			f_TempRepeatX({CGMode(1)},UnitIDV1,1,188)
			f_TempRepeatX({CGMode(2)},UnitIDV1,3,188)
			f_TempRepeatX({CGMode(3)},UnitIDV1,6,188)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(5,AtLeast,30),},{Gun_DoSuspend(),SetCDeaths(FP,Add,1,Chry_cond)},1)
		
	CIfEnd()
	CIf(FP,Gun_Line(0,Exactly,190)) -- BdIndex Core of Galaxy
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("심층부 \x18Core of Galaxy \x04를",111111,6)
		CIfEnd()
		local DisGunUnitID = {21,80,28,86,98,27,88}
		for i = 0, #DisGunUnitID - 1 do
			Trigger { -- TIMER
				players = {FP},
				conditions = {
					Label(0);
					Gun_Line(5,Exactly,i);
			},
				actions = {
					SetCVar(FP,UnitIDVDis[2],SetTo,DisGunUnitID[i+1]);
					PreserveTrigger();
					}
			}
		end
		TriggerX(FP,{CVar(FP,HondonMode[2],AtMost,0)},{
			SetMemory(0x6CA010, SetTo, 1707);--배틀
			SetMemory(0x6C9F8C, SetTo, 1707);--아비터
			SetMemory(0x6C9FA4, SetTo, 1707);--스카웃
		
		},{preserved})
		TriggerX(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
			SetMemory(0x6CA010, SetTo, 20000);--배틀
			SetMemory(0x6C9F8C, SetTo, 20000);--아비터
			SetMemory(0x6C9FA4, SetTo, 20000);--스카웃
		},{preserved})

		CTrigger(FP,{Gun_Line(4,AtLeast,1)},{Gun_SetLine(4,SetTo,0),Gun_SetLine(3,Add,1)},1)
		CIf(FP,{Gun_Line(3,AtLeast,2),Gun_Line(5,AtMost,(#DisGunUnitID)-1)},{Gun_SetLine(3,SetTo,0)})
		local DisGunTempPos = CreateVar(FP)
		CMov(FP,DisGunTempPos,_Mul(DisGun,_Mov(32)))

		CIf(FP,Memory(0x628438,AtLeast,1))
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
			CDoActions(FP,{
				SetMemory(0x662350 + (27*4), SetTo, (22000*256));
				SetMemory(0x662350 + (88*4), SetTo, (25000*256));
				SetMemory(0x662350 + (98*4), SetTo, (10000*256));
				TSetMemory(0x58DC60 + 0x14*0,SetTo,DisGunTempPos),
				TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(DisGunTempPos,32)),
				SetMemory(0x58DC64 + 0x14*0,SetTo,0),
				SetMemory(0x58DC6C + 0x14*0,SetTo,32),
				TCreateUnit(1,UnitIDVDis,1,P8),
				Order("Men",P8,1,Attack,2),
				TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
			})
			CTrigger(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
				TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
				TSetMemory(_Add(Nextptrs,13),SetTo,20000),
				TSetMemoryX(_Add(Nextptrs,18),SetTo,4000,0xFFFF),
				},1)
		CIfEnd()
		CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
			CDoActions(FP,{
				SetMemory(0x58DC60 + 0x14*0,SetTo,0),
				SetMemory(0x58DC68 + 0x14*0,SetTo,32),
				TSetMemory(0x58DC64 + 0x14*0,SetTo,DisGunTempPos),
				TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(DisGunTempPos,32)),
				TCreateUnit(1,UnitIDVDis,1,P8),
				Order("Men",P8,1,Attack,2),
				TSetDeathsX(_Add(Nextptrs,72),SetTo,0xFF*256,0,0xFF00),
				SetCVar(FP,DisGun[2],Add,1),
				SetMemory(0x662350 + (27*4), SetTo, (30000*256));
				SetMemory(0x662350 + (88*4), SetTo, (40000*256));
				SetMemory(0x662350 + (98*4), SetTo, (20000*256));
			})
			CTrigger(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
				TSetMemoryX(_Add(Nextptrs,8),SetTo,127*65536,0xFF0000),
				TSetMemory(_Add(Nextptrs,13),SetTo,20000),
				TSetMemoryX(_Add(Nextptrs,18),SetTo,4000,0xFFFF),
				},1)
		CIfEnd()

		CTrigger(FP,{CVar(FP,DisGun[2],AtLeast,127)},{Gun_SetLine(5,Add,1),SetCVar(FP,DisGun[2],SetTo,0)},1)
		
		CIfEnd()
		CTrigger(FP,{CDeaths(FP,AtLeast,3,GMode)},{Gun_SetLine(3,SetTo,2)},1)
		
		TriggerX(FP,{CVar(FP,HondonMode[2],AtMost,0)},{
			SetMemory(0x6CA010, SetTo, 640);--배틀
			SetMemory(0x6C9F8C, SetTo, 1280);--아비터
			SetMemory(0x6C9FA4, SetTo, 1280);--스카웃
		
		},{preserved})
		TriggerX(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
			SetMemory(0x6CA010, SetTo, 20000);--배틀
			SetMemory(0x6C9F8C, SetTo, 20000);--아비터
			SetMemory(0x6C9FA4, SetTo, 20000);--스카웃
		
		},{preserved})
		CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(5,AtLeast,(#DisGunUnitID)),},{
			Gun_DoSuspend(),
			SetCDeaths(FP,Add,1,SPGunCond);
			PreserveTrigger();},1)
	CIfEnd()

	CIf(FP,Gun_Line(0,Exactly,147)) -- BdIndex Monster Kraken
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			G_CA_SetSpawn({CGMode(1)},{84},"ACAS",{"Chry_1","Chry_2","Chry_3","Chry_4"},1,nil,nil,{0,0})
			G_CA_SetSpawn({CGMode(1)},{25},"ACAS",{"Chry_1","Chry_2","Chry_3","Chry_4"},1,nil,nil,{0,0})
			G_CA_SetSpawn({CGMode(2)},{84,84},"ACAS",{"Chry_1","Chry_2","Chry_3","Chry_4"},1,nil,nil,{0,0})
			G_CA_SetSpawn({CGMode(2)},{25,25},"ACAS",{"Chry_1","Chry_2","Chry_3","Chry_4"},1,nil,nil,{0,0})
			G_CA_SetSpawn({CGMode(3)},{84,84,84,84},"ACAS",{"Chry_1","Chry_2","Chry_3","Chry_4"},1,nil,nil,{0,0})
			G_CA_SetSpawn({CGMode(3)},{25,25,25,25},"ACAS",{"Chry_1","Chry_2","Chry_3","Chry_4"},1,nil,nil,{0,0})
			GunBreak("빅! 한 \x18Monster Kraken! \x04을",222222,6)
		CIfEnd()
		CTrigger(FP,{CGMode(1)},{Gun_SetLine(4,Add,35)},1)
		CTrigger(FP,{CGMode(2)},{Gun_SetLine(4,Add,23)},1)
		CTrigger(FP,{CGMode(3)},{Gun_SetLine(4,Add,11)},1)
		
		CIf(FP,Gun_Line(4,AtMost,1100))
		CDoActions(FP,{Gun_SetLine(3,Add,f_CRandNum(11))})
		CMov(FP,Gun_W,0)
		local TempR = CreateVar(FP)
		CMov(FP,TempR,_Sub(_Mov(1100),Var_TempTable[5]))
		f_Lengthdir(FP,TempR,Var_TempTable[4],Gun_X,Gun_Y)
		Call_Gun_LocPos()
		DoActions(FP,{
			SetMemory(0x6CA010, SetTo, 150);
			CreateUnit(1,27,1,FP);
			SetMemory(0x6CA010, SetTo, 640);
			SetMemory(0x58DC60 + 0x14*0,Subtract,128);
			SetMemory(0x58DC68 + 0x14*0,Add,128);
			SetMemory(0x58DC64 + 0x14*0,Subtract,128);
			SetMemory(0x58DC6C + 0x14*0,Add,128);
			Order(27,FP,1,Attack,31);
			PreserveTrigger();
		})
		f_Lengthdir(FP,TempR,_Add(Var_TempTable[4],90),Gun_X,Gun_Y)
		Call_Gun_LocPos()
		DoActions(FP,{
			SetMemory(0x6CA010, SetTo, 150);
			CreateUnit(1,27,1,FP);
			SetMemory(0x6CA010, SetTo, 640);
			SetMemory(0x58DC60 + 0x14*0,Subtract,128);
			SetMemory(0x58DC68 + 0x14*0,Add,128);
			SetMemory(0x58DC64 + 0x14*0,Subtract,128);
			SetMemory(0x58DC6C + 0x14*0,Add,128);
			Order(27,FP,1,Attack,31);
			PreserveTrigger();
		})
		f_Lengthdir(FP,TempR,_Add(Var_TempTable[4],180),Gun_X,Gun_Y)
		Call_Gun_LocPos()
		DoActions(FP,{
			SetMemory(0x6CA010, SetTo, 150);
			CreateUnit(1,27,1,FP);
			SetMemory(0x6CA010, SetTo, 640);
			SetMemory(0x58DC60 + 0x14*0,Subtract,128);
			SetMemory(0x58DC68 + 0x14*0,Add,128);
			SetMemory(0x58DC64 + 0x14*0,Subtract,128);
			SetMemory(0x58DC6C + 0x14*0,Add,128);
			Order(27,FP,1,Attack,31);
			PreserveTrigger();
		})
		f_Lengthdir(FP,TempR,_Add(Var_TempTable[4],270),Gun_X,Gun_Y)
		Call_Gun_LocPos()
		DoActions(FP,{
			SetMemory(0x6CA010, SetTo, 150);
			CreateUnit(1,27,1,FP);
			SetMemory(0x6CA010, SetTo, 640);
			SetMemory(0x58DC60 + 0x14*0,Subtract,128);
			SetMemory(0x58DC68 + 0x14*0,Add,128);
			SetMemory(0x58DC64 + 0x14*0,Subtract,128);
			SetMemory(0x58DC6C + 0x14*0,Add,128);
			Order(27,FP,1,Attack,31);
			PreserveTrigger();
		})
		CIfEnd()

		TriggerX(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
			SetMemory(0x6CA010, SetTo, 20000);--배틀
		
		},{preserved})
		CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(4,AtLeast,1100),},{Gun_DoSuspend(),SetCDeaths(FP,Add,1,SPGunCond)},1)
	CIfEnd()
	

	


	CIf(FP,TTOR({Gun_Line(0,Exactly,156),Gun_Line(0,Exactly,109),Gun_Line(0,Exactly,173)})) -- BdIndex Pylon Supply Formation
		CIf(FP,{Gun_Line(0,Exactly,156),Gun_Line(4,Exactly,0)})
			GunBreak("수정탑 \x18Pylon \x04을",100000,8)
		CIfEnd()
		CIf(FP,{Gun_Line(0,Exactly,109),Gun_Line(4,Exactly,0)})
			GunBreak("보급고 \x18Supply \x04를",100000,8)
		CIfEnd()
		CIf(FP,{Gun_Line(0,Exactly,173),Gun_Line(4,Exactly,0)})
			GunBreak("수정 집합체 \x18Formation \x04을",300000,6)
		CIfEnd()
		CTrigger(FP,{Gun_Line(4,Exactly,0)},{Gun_SetLine(50,SetTo,1),Gun_SetLine(51,SetTo,1830)},1)
		CTrigger(FP,{Gun_Line(50,Exactly,0)},{Gun_SetLine(5,Add,1)},1)
		CTrigger(FP,{Gun_Line(50,Exactly,1)},{Gun_SetLine(5,Subtract,1)},1)
		local PS_Create = CreateCCode()
		CTrigger(FP,{Gun_Line(5,Exactly,0),Gun_Line(50,Exactly,1)},{Gun_SetLine(3,Add,1),Gun_SetLine(50,SetTo,0),SetCDeaths(FP,Add,1,PS_Create)},1)
		CTrigger(FP,{Gun_Line(5,Exactly,12)},{SetCDeaths(FP,Add,1,PS_Create)},1)
		CTrigger(FP,{Gun_Line(5,Exactly,24)},{SetCDeaths(FP,Add,1,PS_Create)},1)
		CTrigger(FP,{Gun_Line(5,Exactly,36)},{SetCDeaths(FP,Add,1,PS_Create)},1)
		CTrigger(FP,{Gun_Line(5,Exactly,48)},{SetCDeaths(FP,Add,1,PS_Create)},1)
		CTrigger(FP,{Gun_Line(5,AtLeast,60),Gun_Line(50,Exactly,0)},{Gun_SetLine(50,SetTo,1),Gun_SetLine(51,SetTo,0)},1)
		CTrigger(FP,{Gun_Line(50,Exactly,1)},{Gun_SetLine(51,Add,Var_TempTable[6])},1)
		CTrigger(FP,{Gun_Line(50,Exactly,0)},{Gun_SetLine(51,Subtract,Var_TempTable[6])},1)
		CTrigger(FP,{Gun_Line(3,Exactly,7)},{SetCDeaths(FP,SetTo,0,ScanEffT);},1)
		CDoActions(FP,{Gun_SetLine(52,Add,3)}) -- 
		CTrigger(FP,{Gun_Line(52,AtLeast,72)},{Gun_SetLine(52,SetTo,0)},1)
		TriggerX(FP,{Gun_Line(0,Exactly,156)},{
			SetCVar(FP,Gun_UID[2],SetTo,16);
			SetCVar(FP,Gun_UID2[2],SetTo,193);
			SetCVar(FP,Gun_UID3[2],SetTo,179);
			SetCVar(FP,Gun_UID4[2],SetTo,80);},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,109)},{
			SetCVar(FP,Gun_UID[2],SetTo,17);
			SetCVar(FP,Gun_UID2[2],SetTo,192);
			SetCVar(FP,Gun_UID3[2],SetTo,180);
			SetCVar(FP,Gun_UID4[2],SetTo,21);},{Preserved})
--		TriggerX(FP,{},{},{Preserved})
--		Angle = Var_TempTable[53]
--		Radius = Var_TempTable[52]

		CMov(FP,Gun_W,0)
		NWhile(FP,CVar(FP,Gun_W[2],AtMost,4),SetCVar(FP,Gun_W[2],Add,1))
			f_Lengthdir(FP,_Div(Var_TempTable[52],_Mov(7)),_Add(Var_TempTable[53],_Mul(Gun_W,_Mov(72))),Gun_X,Gun_Y)
			f_Div(FP,Gun_Y,2)
			Call_Gun_LocPos()
			Nif(FP,{TTOR({Gun_Line(0,Exactly,156),Gun_Line(0,Exactly,109)})})
				CDoActions(FP,{
					TSetMemoryX(0x669FA4, SetTo, Gun_UID,0xFF),
					TSetMemoryX(0x669FA4, SetTo, _Mul(Gun_UID,_Mov(256)),0xFF00),
					TSetMemoryX(0x669FA4, SetTo, _Mul(Gun_UID,_Mov(65536)),0xFF0000),
				CreateUnit(1,205,1,FP)})
				f_TempRepeat({CDeaths(FP,AtLeast,1,PS_Create)},84,1)
				f_TempRepeatX({CDeaths(FP,AtLeast,1,PS_Create),CGMode(2)},Gun_UID4,1,187)
				f_TempRepeatX({CDeaths(FP,AtLeast,1,PS_Create),CGMode(3)},Gun_UID4,2,187)
				CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(3,AtLeast,7),CDeaths(FP,AtLeast,3,GMode)},{
					SetMemory(0x66F050, SetTo, 160),
					TCreateUnit(15,Gun_UID3,1,FP),
					SetMemory(0x66F050, SetTo, 87),
					SetMemory(0x58DC60 + 0x14*0,Subtract,128),
					SetMemory(0x58DC68 + 0x14*0,Add,128),
					SetMemory(0x58DC64 + 0x14*0,Subtract,128),
					SetMemory(0x58DC6C + 0x14*0,Add,128),
					SetMemory(0x6509B0,SetTo,7),RunAIScriptAt("Set Unit Order To: Junk Yard Dog",1)},1)
			NIfEnd()
			Nif(FP,{Gun_Line(0,Exactly,173)})
				DoActions(FP,{
					SetMemoryX(0x669FAC, SetTo, 16*16777216,0xFF000000);
					SetMemoryX(0x669FA4, SetTo, 16,0xFF),
					SetMemoryX(0x669FA4, SetTo, 16*(256),0xFF00),
					SetMemoryX(0x669FA4, SetTo, 16*(65536),0xFF0000),
					CreateUnit(1,205,1,FP)})
				f_Lengthdir(FP,_Div(Var_TempTable[52],_Mov(7)),_Add(_Add(Var_TempTable[53],36),_Mul(Gun_W,_Mov(72))),Gun_X,Gun_Y)
				f_Div(FP,Gun_Y,2)
				Call_Gun_LocPos()
				DoActions(FP,{
					SetMemoryX(0x669FAC, SetTo, 17*16777216,0xFF000000);
					SetMemoryX(0x669FA4, SetTo, 17,0xFF),
					SetMemoryX(0x669FA4, SetTo, 17*(256),0xFF00),
					SetMemoryX(0x669FA4, SetTo, 17*(65536),0xFF0000),
					CreateUnit(1,205,1,FP)})
			NIfEnd()
		NWhileEnd()
		CIf(FP,{Gun_Line(54,AtMost,0)})
		CTrigger(FP,{Gun_Line(3,AtLeast,7),CDeaths(FP,AtLeast,2,GMode),TTOR({Gun_Line(0,Exactly,156),Gun_Line(0,Exactly,109)})},{
			TSetMemory(0x58DC60 + 0x14*0,SetTo,Var_TempTable[2]),
			TSetMemory(0x58DC68 + 0x14*0,SetTo,Var_TempTable[2]),
			TSetMemory(0x58DC64 + 0x14*0,SetTo,Var_TempTable[3]),
			TSetMemory(0x58DC6C + 0x14*0,SetTo,Var_TempTable[3]),
			TCreateUnit(1,Gun_UID2,1,FP)},1)
		NIf(FP,{Gun_Line(3,AtLeast,7)})
			NWhile(FP,CVar(FP,Var_TempTable[52][2],AtLeast,15),SetCVar(FP,Var_TempTable[52][2],Subtract,140))
				CMov(FP,Gun_W,0)
				NWhile(FP,CVar(FP,Gun_W[2],AtMost,4),SetCVar(FP,Gun_W[2],Add,1))
					f_Lengthdir(FP,_Div(Var_TempTable[52],7),_Add(Var_TempTable[53],_Mul(Gun_W,72)),Gun_X,Gun_Y)
					CDiv(FP,Gun_Y,2)
					Call_Gun_LocPos()
					Nif(FP,{TTOR({Gun_Line(0,Exactly,156),Gun_Line(0,Exactly,109)})})
						CDoActions(FP,{
							SetMemoryX(0x666458, SetTo, 391,0xFFFF);
							TSetMemoryX(0x669FA4, SetTo, Gun_UID,0xFF),
							TSetMemoryX(0x669FA4, SetTo, _Mul(Gun_UID,_Mov(256)),0xFF00),
							TSetMemoryX(0x669FA4, SetTo, _Mul(Gun_UID,_Mov(65536)),0xFF0000),
							TSetMemoryX(0x669FAC, SetTo, _Mul(Gun_UID,_Mov(16777216)),0xFF000000);
							CreateUnit(1,33,1,FP)})
					NIfEnd()
					Nif(FP,{Gun_Line(0,Exactly,173)})
						DoActions(FP,{
							SetMemoryX(0x666458, SetTo, 391,0xFFFF);
							SetMemoryX(0x669FA4, SetTo, 16,0xFF),
							SetMemoryX(0x669FA4, SetTo, 16*(256),0xFF00),
							SetMemoryX(0x669FA4, SetTo, 16*(65536),0xFF0000),
							SetMemoryX(0x669FAC, SetTo, 16*16777216,0xFF000000);
							CreateUnit(1,33,1,FP)})
						f_Lengthdir(FP,_Div(Var_TempTable[52],7),_Add(_Add(Var_TempTable[53],36),_Mul(Gun_W,72)),Gun_X,Gun_Y)
						CDiv(FP,Gun_Y,2)
						Call_Gun_LocPos()
						DoActions(FP,{
							SetMemoryX(0x666458, SetTo, 391,0xFFFF);
							SetMemoryX(0x669FA4, SetTo, 17,0xFF),
							SetMemoryX(0x669FA4, SetTo, 17*(256),0xFF00),
							SetMemoryX(0x669FA4, SetTo, 17*(65536),0xFF0000),
							SetMemoryX(0x669FAC, SetTo, 17*16777216,0xFF000000);
							CreateUnit(1,33,1,FP)})
					NIfEnd()
				NWhileEnd()
			NWhileEnd()
		NIfEnd()
		
		TriggerX(FP,{Gun_Line(3,AtLeast,7),Gun_Line(0,Exactly,156)},{
			CopyCpAction({
				PlayWAVX("staredit\\wav\\H-020.wav"),
				PlayWAVX("staredit\\wav\\H-020.wav"),
				PlayWAVX("staredit\\wav\\H-020.wav")},HumanPlayers,FP),
				SetCDeaths(FP,Add,1,Py_Cond)},{Preserved})
		TriggerX(FP,{Gun_Line(3,AtLeast,7),Gun_Line(0,Exactly,109)},{
			CopyCpAction({
				PlayWAVX("staredit\\wav\\H-020.wav"),
				PlayWAVX("staredit\\wav\\H-020.wav"),
				PlayWAVX("staredit\\wav\\H-020.wav")},HumanPlayers,FP),
				SetCDeaths(FP,Add,1,Sup_Cond)},{Preserved})
		TriggerX(FP,{Gun_Line(3,AtLeast,7),Gun_Line(0,Exactly,173)},{
			CopyCpAction({
				PlayWAVX("staredit\\wav\\seeya.ogg"),
				PlayWAVX("staredit\\wav\\seeya.ogg"),
				PlayWAVX("staredit\\wav\\seeya.ogg")},HumanPlayers,FP),
				SetCDeaths(FP,Add,1,FormCon);
				Order("Men",Force2,64,Attack,2);
				KillUnitAt(1,125,47,Force1);},{Preserved})
		CIfEnd()
		DoActionsX(FP,SetCDeaths(FP,SetTo,0,PS_Create))
		CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(3,AtLeast,7),},{Gun_DoSuspend()},1)
	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,201)}) -- BdIndex Cocoon
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("거대 고치 \x18Overmind Cocoon \x04을",300000,8)
			DoActions(FP,{
				Simple_CalcLoc(0,-32*8,-32*8,32*8,32*8),
				KillUnitAt(All,"Sunken Colony",1,Force2);
				KillUnitAt(All,"Spore Colony",1,Force2);})
		CIfEnd()
	
		CTrigger(FP,{Gun_Line(4,AtLeast,10),CDeaths(FP,Exactly,0,CocoonGunCon)},{Gun_SetLine(4,SetTo,0),SetCDeaths(FP,Add,1,CocoonLaunch),CreateUnit(1,84,1,FP)},1)
		local CoTotal,CoCount1,CoCount2 = CreateVars(3,FP)
		UnitReadX(FP,11,80,64,CoCount1)
		UnitReadX(FP,11,21,64,CoCount2)
		CAdd(FP,CoTotal,CoCount1,CoCount2)
		
		for i = 1, 3 do
			Trigger { -- 
				players = {FP},
				conditions = {
					Label(0);
					CDeaths(FP,Exactly,i,GMode);
					CVar(FP,CoTotal[2],AtLeast,(200*i)+200)
			},
				actions = {
					SetCDeaths(FP,Add,1,CocoonGunCon);
					Order(80,Force2,64,Move,30);
					Order(21,Force2,64,Move,30);
					}
			}
		end
		Trigger { -- 
			players = {FP},
			conditions = {
				Label(0);
				Memory(0x628438,Exactly,0)
		},
			actions = {
				SetCDeaths(FP,Add,1,CocoonGunCon);
				}
		}
	
		Trigger { -- 
		players = {FP},
		conditions = {
			Label(0);
			Gun_Line(4,AtMost,480);
			},
		actions = {
			SetMemoryX(0x666458, SetTo, 391,0xFFFF);
			SetMemoryX(0x669BC4, SetTo, 3*16777216,0xFF000000);
			CreateUnit(1,33,26,FP);
			CreateUnit(1,33,27,FP);
			CreateUnit(1,33,28,FP);
			CreateUnit(1,33,29,FP);
			Order(80,11,26,Move,26);
			Order(80,11,27,Move,27);
			Order(80,11,28,Move,28);
			Order(80,11,29,Move,29);
			Order(21,11,26,Move,26);
			Order(21,11,27,Move,27);
			Order(21,11,28,Move,28);
			Order(21,11,29,Move,29);
			PreserveTrigger();
			}
		}
		Cocoon_JYD = {}
		Set_Inv = {}
		table.insert(Cocoon_JYD,RunAIScriptAt("Set Unit Order To: Junk Yard Dog",30))
		table.insert(Set_Inv,SetInvincibility(Disable,80,Force2,64))
		table.insert(Set_Inv,SetInvincibility(Disable,21,Force2,64))
		Trigger { -- 
			players = {FP},
			conditions = {
				Label(0);
				Gun_Line(4,Exactly,580);
				},
			actions = {
				Set_Inv
				}
		}
		Trigger { -- 
			players = {FP},
			conditions = {
				Label(0);
				Gun_Line(4,Exactly,479);
				},
			actions = {
				SetCDeaths(FP,Add,1000,TGiveforCoCoon);
				}
		}
		TriggerX(FP,{Gun_Line(4,Exactly,481)},{
			SetMemory(0x6509B0,SetTo,6),
			SetAllianceStatus(force1,Ally);
			SetMemory(0x6509B0,SetTo,7),
			SetAllianceStatus(force1,Ally);
		},{Preserved})
		for i = 0, 9 do
			TriggerX(FP,{Gun_Line(4,Exactly,481+(10*i))},{
				SetMemory(0x6509B0,SetTo,6),
				Cocoon_JYD,
				SetMemory(0x6509B0,SetTo,7),
				Cocoon_JYD},{Preserved})
		end
		TriggerX(FP,{Gun_Line(4,Exactly,481+(10*9))},{
			SetMemory(0x6509B0,SetTo,6),
			SetAllianceStatus(force1,Enemy);
			SetMemory(0x6509B0,SetTo,7),
			SetAllianceStatus(force1,Enemy);
		},{Preserved})
		
		NIf(FP,{Gun_Line(4,AtLeast,482),Gun_Line(4,AtMost,579),CVar(FP,CurrentChunk[2],AtMost,63)})
			CAdd(FP,CurrentChunk,1)
			f_Div(FP,CCY,CurrentChunk,8)
			f_Mod(FP,CCX,CurrentChunk,8)
			CDoActions(FP,{
			TSetMemory(0x58DC60 + 0x14*47,SetTo,_Mul(CCX,_Mov(512))),
			TSetMemory(0x58DC68 + 0x14*47,SetTo,_Mul(_Add(CCX,1),512)),
			TSetMemory(0x58DC64 + 0x14*47,SetTo,_Mul(CCY,_Mov(512))),
			TSetMemory(0x58DC6C + 0x14*47,SetTo,_Mul(_Add(CCY,1),_Mov(512))),
			})
			NIf(FP,CVar(FP,CurrentChunk[2],AtMost,62))
				UnitReadX(FP,Force1,"Men",48,V(0x400+63))
				CMov(FP,VArr(CocoonVarr,CurrentChunk),V(0x400+63))
			NIfEnd()
		NIfEnd()
		NIf(FP,{Gun_Line(54,AtMost,0),Gun_Line(4,Exactly,580)})
			CMov(FP,ChunkChecksum,1)
			NWhile(FP,CVar(FP,ChunkChecksum[2],AtLeast,1))
				CMov(FP,ChunkChecksum,0)
				for i = 0, 62 do
				Trigger {
					players = {FP},
					conditions = {
						Label(0);
						CVar(FP,0x400+i,AtLeast,1);
						--CVAar(VArr(LocChunkVArr,i),AtLeast,1);
					},
					actions = {
						--SetCVAar(VArr(LocChunkVArr,i),Subtract,1);
						SetCVar(FP,0x400+i,Subtract,1);
						SetCVar(FP,CurrentChunk[2],SetTo,i);
						SetCVar(FP,ChunkChecksum[2],Add,1);
						PreserveTrigger();
					}
				}
				end
			NWhileEnd()
			f_Div(FP,CCY,CurrentChunk,8)
			f_Mod(FP,CCX,CurrentChunk,8)
			CDoActions(FP,{
			Gun_DoSuspend(),
			TSetMemory(0x58DC60 + 0x14*0,SetTo,_Mul(CCX,_Mov(512))),
			TSetMemory(0x58DC68 + 0x14*0,SetTo,_Mul(_Add(CCX,1),_Mov(512))),
			TSetMemory(0x58DC64 + 0x14*0,SetTo,_Mul(CCY,_Mov(512))),
			TSetMemory(0x58DC6C + 0x14*0,SetTo,_Mul(_Add(CCY,1),_Mov(512))),
			SetCDeaths(FP,Add,1,SPGunCond);
			SetCDeaths(FP,Add,1,OverCocooncomp);
			Order(80,force2,64,Attack,1),
			Order(21,force2,64,Attack,1),
			})
		NIfEnd()
	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,175)}) -- BdIndex Xel'Naga
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("사원 \x18Xel'Naga \x04를",255555,8)
		CIfEnd()

		for i =0, 5 do
			CTrigger(FP,{
				Gun_Line(4,AtLeast,(i*8)),
				Gun_Line(5,Exactly,i)},{
				Gun_SetLine(4,SetTo,0),
				Gun_SetLine(5,Add,1)},1)
		end
		f_Lengthdir(FP,_Mul(Var_TempTable[6],_Mov(32*3)),_Mul(Var_TempTable[5],_Div(_Mov(360),_Mul(Var_TempTable[6],_Mov(8)))),Gun_X,Gun_Y)
		f_Div(FP,Gun_Y,2)
		Call_Gun_LocPos()
		DoActions(FP,{
		SetMemory(0x6CA010, SetTo, 0),
		CreateUnit(1,29,1,FP),
		CreateUnit(1,84,1,FP),
		})
		TriggerX(FP,{CVar(FP,HondonMode[2],Exactly,0)},{SetMemory(0x6CA010, SetTo, 640)},{Preserved})
		TriggerX(FP,{CVar(FP,HondonMode[2],Exactly,1)},{SetMemory(0x6CA010, SetTo, 20000)},{Preserved})

		for i = 1, 3 do
			CTrigger(FP,{Gun_Line(54,AtMost,0),CDeaths(FP,Exactly,i,GMode);Gun_Line(4,AtLeast,((8*(i+1))+7)),Gun_Line(5,AtLeast,(i+1)+1)},{
				SetCDeaths(FP,Add,1,SPGunCond);
				Gun_DoSuspend();
			},1)
		end
	
	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,152)}) -- BdIndex Daggoth
		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("완전체 \x18DaGGoTh \x04를",150000,8)
		CIfEnd()
		local CurTime = CreateVar(FP)
		local CurTime2 = CreateVar(FP)
		f_Read(FP,0x58D6F8,CurTime)
		CMov(FP,CurTime2,_Mul(_Mod(CurTime,_Mov(60)),_Mov(6)))
		CIf(FP,{TTOR({Gun_Line(4,Exactly,0),Gun_Line(4,Exactly,30),Gun_Line(4,Exactly,60),Gun_Line(4,Exactly,90),Gun_Line(4,Exactly,120)})})
			CMov(FP,Gun_W2,0)
			NWhile(FP,CVar(FP,Gun_W2[2],AtMost,4096/64))
			CAdd(FP,Gun_W2,1)
			CMov(FP,Gun_W,0)
			NWhile(FP,CVar(FP,Gun_W[2],AtMost,3),SetCVar(FP,Gun_W[2],Add,1))
				f_Lengthdir(FP,_Mul(Gun_W2,_Mov(64)),_Add(_Mul(Gun_W,_Mov(90)),CurTime2),Gun_X,Gun_Y)
				Call_Gun_LocPos()
				NIfX(FP,{
				Memory(0x58DC60 + 0x14*0,AtMost,4096),
				Memory(0x58DC68 + 0x14*0,AtMost,4096),
				Memory(0x58DC64 + 0x14*0,AtMost,4096),
				Memory(0x58DC6C + 0x14*0,AtMost,4096)},{CreateUnit(1,84,1,FP)
					})
				NIfXEnd()
			NWhileEnd()
			NWhileEnd()

		CIfEnd()


		CIf(FP,{Gun_Line(4,AtLeast,150)})
			CMov(FP,Gun_W,0)
			NWhile(FP,CVar(FP,Gun_W[2],AtMost,3),SetCVar(FP,Gun_W[2],Add,1))
				f_Lengthdir(FP,_Mul(_Sub(Var_TempTable[5],150),_Mov(64)),_Add(_Mul(Gun_W,_Mov(90)),CurTime2),Gun_X,Gun_Y)
				Call_Gun_LocPos()
				NIfX(FP,{
				Memory(0x58DC60 + 0x14*0,AtMost,4096),
				Memory(0x58DC68 + 0x14*0,AtMost,4096),
				Memory(0x58DC64 + 0x14*0,AtMost,4096),
				Memory(0x58DC6C + 0x14*0,AtMost,4096)},{
					CreateUnit(1,84,1,FP),})
					TriggerX(FP,{CGMode(1)},{SetCVar(FP,Gun_W2[2],SetTo,1)},{Preserved})
					TriggerX(FP,{CGMode(2)},{SetCVar(FP,Gun_W2[2],SetTo,2)},{Preserved})
					TriggerX(FP,{CGMode(3)},{SetCVar(FP,Gun_W2[2],SetTo,4)},{Preserved})

					NWhile(FP,CVar(FP,Gun_W2[2],AtLeast,1),SetCVar(FP,Gun_W2[2],Subtract,1))
						NIfX(FP,{Gun_Line(3,Exactly,1)})
						CDoActions(FP,{TCreateUnit(1,VArr(UArr1,_Mod(_Rand(),_Mov(16))), 1, _Add((_Mod(_Rand(),_Mov(2))),6))})
						NElseX()
						CDoActions(FP,{TCreateUnit(1,VArr(UArr2,_Mod(_Rand(),_Mov(16))), 1, _Add((_Mod(_Rand(),_Mov(2))),6))})
						NIfXEnd()
					NWhileEnd()
					CMov(FP,B10_Cond,1)
				NIfXEnd()
			NWhileEnd()
			CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(4,AtLeast,151),CVar(FP,B10_Cond[2],AtMost,0);},{SetCDeaths(FP,Add,1,SPGunCond),Gun_DoSuspend()},1)
			CMov(FP,B10_Cond,0)
		CIfEnd()
	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,151)}) -- BdIndex Cerebrate
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,480)})
			GunBreak("정신체 \x18Cerebrate \x04를",200000,8)
		CIfEnd()
		DisPos = {4000,2240}
		CIf(FP,{Gun_Line(4,AtLeast,480)})
			CereDiff = {"Cere_N","Cere_H","Cere_B"}
			
			
			
			
			G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{56,53},"ACAS","Cere_Z",nil,nil,nil,{4000,2240})
			G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{57,48},"ACAS","Cere_Z",nil,nil,nil,{4000,2240})
			G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{62,51},"ACAS","Cere_Z",nil,nil,nil,{4000,2240})
			for i = 1, 3 do
				G_CA_SetSpawn({CDeaths(FP,Exactly,i,GMode),Gun_Line(5,Exactly,0)},{8,17},"ACAS",CereDiff[i],nil,nil,nil,{4000,2240})
				G_CA_SetSpawn({CDeaths(FP,Exactly,i,GMode),Gun_Line(5,Exactly,1)},{86,78},"ACAS",CereDiff[i],nil,nil,nil,{4000,2240})
				G_CA_SetSpawn({CDeaths(FP,Exactly,i,GMode),Gun_Line(5,Exactly,2)},{98,81},"ACAS",CereDiff[i],nil,nil,nil,{4000,2240})
			end
			CMov(FP,Gun_W,0)
			NWhile(FP,CVar(FP,Gun_W[2],AtMost,359),{TSetCVar(FP,Gun_W[2],Add,_Mul(B11_Level,_Mov(3)))})
				f_Lengthdir(FP,250,Gun_W,Gun_X,Gun_Y)
				CAdd(FP,Gun_X,DisPos[1])
				CAdd(FP,Gun_Y,DisPos[2])
				CIf(FP,{CVar(FP,Gun_X[2],AtMost,4096),CVar(FP,Gun_Y[2],AtMost,4096)})
					CDoActions(FP,{
					TSetMemory(0x58DC60 + 0x14*0,SetTo,Gun_X),
					TSetMemory(0x58DC68 + 0x14*0,SetTo,Gun_X),
					TSetMemory(0x58DC64 + 0x14*0,SetTo,Gun_Y),
					TSetMemory(0x58DC6C + 0x14*0,SetTo,Gun_Y),
					SetMemory(0x6CA010, SetTo, 64),
					CreateUnit(1,29,1,FP),
					Order(29,FP,1,Attack,40),
					
					SetMemory(0x6CA010, SetTo, 640),
					})
					TriggerX(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{SetMemory(0x6CA010, SetTo, 20000)},{preserved})
				CIfEnd()
			NWhileEnd()
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(5,AtLeast,3),},{Gun_DoSuspend(),SetCDeaths(FP,Add,1,SPGunCond)},1)
		
	CIfEnd()

	
	CIf(FP,{Gun_Line(0,Exactly,148)}) -- BdIndex Overmind
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,480)})
			GunBreak("초월체 \x18OverMind \x04를",100000,6)
		CIfEnd()

		CIf(FP,{Gun_Line(4,AtLeast,480)})
			CIf(FP,CGMode(1))
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{21,15},"ACAS",{"Ovrm_X192","Ovrm_X160"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{53,48,56},"ACAS",{"Ovrm_X96","Ovrm_X128","Ovrm_X160"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{80,87},"ACAS",{"Ovrm_X192","Ovrm_X160"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{51,48,57},"ACAS",{"Ovrm_X96","Ovrm_X128","Ovrm_X160"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{28,17},"ACAS",{"Ovrm_X192","Ovrm_X160"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{51,48,62},"ACAS",{"Ovrm_X96","Ovrm_X128","Ovrm_X160"},nil,nil,nil,{0,0})
			CIfEnd()
			CIf(FP,CGMode(2))
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{21,15},"ACAS",{"Ovrm_X160","Ovrm_X128"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{53,48,56},"ACAS",{"Ovrm_X96","Ovrm_X96","Ovrm_X128"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{80,87},"ACAS",{"Ovrm_X160","Ovrm_X128"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{51,48,57},"ACAS",{"Ovrm_X96","Ovrm_X96","Ovrm_X128"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{28,17},"ACAS",{"Ovrm_X160","Ovrm_X128"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{51,48,62},"ACAS",{"Ovrm_X96","Ovrm_X96","Ovrm_X128"},nil,nil,nil,{0,0})
			CIfEnd()
			CIf(FP,CGMode(3))
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{21,15},"ACAS",{"Ovrm_X128","Ovrm_X96"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{53,48,56},"ACAS",{"Ovrm_X64","Ovrm_X64","Ovrm_X96"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{80,87},"ACAS",{"Ovrm_X128","Ovrm_X96"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{51,48,57},"ACAS",{"Ovrm_X64","Ovrm_X64","Ovrm_X96"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{28,17},"ACAS",{"Ovrm_X128","Ovrm_X96"},nil,nil,nil,{0,0})
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{51,48,62},"ACAS",{"Ovrm_X64","Ovrm_X64","Ovrm_X96"},nil,nil,nil,{0,0})
			CIfEnd()
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(5,AtLeast,3),},{Gun_DoSuspend(),SetCDeaths(FP,Add,1,SPGunCond)},1)	
	CIfEnd()
	
	CIf(FP,{Gun_Line(0,Exactly,150)}) -- BdIndex Overmind
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,480)})
			GunBreak("빅! 한 \x18Large Chrysalis \x04를",50000,4)
		CIfEnd()
		CIf(FP,{Gun_Line(4,AtLeast,480)})
			G_CA_SetSpawn({CGMode(1)},{25},"ACAS",{"Chry_N","Chry_N","Chry_N"},{1,255,1},190)
			G_CA_SetSpawn({CGMode(2)},{25},"ACAS",{"Chry_H","Chry_H","Chry_H"},{2,255,2},190)
			G_CA_SetSpawn({CGMode(3)},{25},"ACAS",{"Chry_B","Chry_B","Chry_B"},{3,255,3},190)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(54,AtMost,0),Gun_Line(5,AtLeast,3),},{Gun_DoSuspend(),SetCDeaths(FP,Add,1,B_Chry_cond);},1)	
	CIfEnd()
	
	CIf(FP,{Gun_Line(0,Exactly,154)}) -- BdIndex Nexus
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
		CDoActions(FP,{Gun_SetLine(3,Add,1),Gun_SetLine(6,Add,32*4)})
			GunBreak("연결체 \x18Nexus \x04를",200000,8)
			DoActions(FP,CopyCpAction({RunAIScript("Turn ON Shared Vision for Player 7")},MapPlayers,FP))
		CIfEnd()
		CTrigger(FP,{Gun_Line(4,Exactly,500)},{Gun_SetLine(3,Add,1)})
		CTrigger(FP,{Gun_Line(4,Exactly,1000)},{Gun_SetLine(3,Add,1)})
		CIfX(FP,{Gun_Line(3,AtLeast,1)},{Gun_SetLine(3,Subtract,1)})

		for i = 1, 3 do
			local Dif
			local PyLM
			if i == 1 then Dif = "N" PyLM = 1 end
			if i == 2 then Dif = "H" PyLM = 2 end
			if i == 3 then Dif = "B" PyLM = 4 end
			for j = 1, 5 do
				G_CA_SetSpawn({CGMode(i),Gun_Line(4,AtMost,499)},{57},"ACAS","Py"..j.."F"..Dif,PyLM,190,nil,{0,0})
				G_CA_SetSpawn({CGMode(i),Gun_Line(4,AtLeast,499),Gun_Line(4,AtMost,999)},{80},"ACAS","Py"..j.."F"..Dif,PyLM,190,nil,{0,0})
				G_CA_SetSpawn({CGMode(i),Gun_Line(4,AtLeast,1000)},{86},"ACAS","Py"..j.."F"..Dif,PyLM,190,nil,{0,0})
			end
		end

		CElseIfX({Gun_Line(4,AtMost,1100),Gun_Line(6,AtLeast,32*4)},{Gun_SetLine(6,SetTo,0)})
		for j = 1, 5 do
			G_CA_SetSpawn(nil,{84,84,84,84},"ACAS","Py"..j,1,3,nil,{0,0})
		end
		CIfXEnd()
		CTrigger(FP,{CVar(FP,count[2],AtMost,1500)},{Gun_SetLine(6,Add,1)},1)
		CIf(FP,{Gun_Line(54,AtMost,0),Gun_Line(4,AtLeast,1100)})
		CDoActions(FP,{Gun_DoSuspend()})
		DoActionsX(FP,{CopyCpAction({RunAIScript("Turn OFF Shared Vision for Player 7")},MapPlayers,FP),SetCDeaths(FP,Add,1,SPGunCond)})
		CIfEnd()

	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,200)}) -- BdIndex Generator
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(3,Add,1),Gun_SetLine(6,Add,32*4)})
			GunBreak("발전소 \x18Generator \x04를",200000,8)
			DoActions(FP,CopyCpAction({RunAIScript("Turn ON Shared Vision for Player 8")},MapPlayers,FP))
		CIfEnd()
		CTrigger(FP,{Gun_Line(4,Exactly,500)},{Gun_SetLine(3,Add,1)})
		CTrigger(FP,{Gun_Line(4,Exactly,1000)},{Gun_SetLine(3,Add,1)})

		CIfX(FP,{Gun_Line(3,AtLeast,1),},{Gun_SetLine(3,Subtract,1)})

		for i = 1, 3 do
			local Dif
			local PyLM
			if i == 1 then Dif = "N" PyLM = 1 end
			if i == 2 then Dif = "H" PyLM = 2 end
			if i == 3 then Dif = "B" PyLM = 4 end
			for j = 1, 5 do
				G_CA_SetSpawn({CGMode(i),Gun_Line(4,AtMost,499)},{62},"ACAS","Su"..j.."F"..Dif,PyLM,190,nil,{0,0})
				G_CA_SetSpawn({CGMode(i),Gun_Line(4,AtLeast,499),Gun_Line(4,AtMost,999)},{21},"ACAS","Su"..j.."F"..Dif,PyLM,190,nil,{0,0})
				G_CA_SetSpawn({CGMode(i),Gun_Line(4,AtLeast,1000)},{27},"ACAS","Su"..j.."F"..Dif,PyLM,190,nil,{0,0})
			end
		end

		CElseIfX({Gun_Line(4,AtMost,1100),Gun_Line(6,AtLeast,32*4)},{Gun_SetLine(6,SetTo,0)})
		for j = 1, 5 do
			G_CA_SetSpawn(nil,{84,84,84,84},"ACAS","Su"..j,1,3,nil,{0,0})
		end
		CIfXEnd()
		CTrigger(FP,{CVar(FP,count[2],AtMost,1500)},{Gun_SetLine(6,Add,1)},1)
		CIf(FP,{Gun_Line(54,AtMost,0),Gun_Line(4,AtLeast,1100),})
		CDoActions(FP,{Gun_DoSuspend()})
		DoActionsX(FP,{CopyCpAction({RunAIScript("Turn OFF Shared Vision for Player 8")},MapPlayers,FP),SetCDeaths(FP,Add,1,SPGunCond)})
		CIfEnd()
	CIfEnd()

	CIf(FP,{Gun_Line(0,Exactly,1000)}) -- BdIndex GunBoss
		GunBossUIDArr2 = {15,87,89,77,78,79,76,10,52,19}
		CMov(FP,UnitIDV1,0)
		CMov(FP,UnitIDV2,0)
		
		CIf(FP,{Gun_Line(4,AtLeast,200)})
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1),SetCVar(FP,UnitIDV2[2],SetTo,1)})
		CIfEnd()
		for i = 1, #GunBossUIDArr2 do
			TriggerX(FP,{CDeaths(FP,AtLeast,500*i,GunBossAct)},{SetCVar(FP,UnitIDV1[2],SetTo,GunBossUIDArr2[i])})
		end
		for j = 2, 3 do
			local Dif
			if j == 2 then Dif = "H" end
			if j == 3 then Dif = "B" end
			for c = 1, 4 do
				G_CA_SetSpawn({CGMode(j),CVar(FP,UnitIDV1[2],AtLeast,1)},{UID1I},"ACAS","GB_"..Dif.."1_"..c,nil,189,nil,{0,0})
				G_CA_SetSpawn({CGMode(j),CVar(FP,UnitIDV2[2],AtLeast,1)},{69,27},"ACAS","GB_"..Dif.."2_"..c,nil,189,nil,{0,0})
			end
		end
		CTrigger(FP,{Gun_Line(5,AtLeast,6200/200),},{Gun_DoSuspend()},1)
	CIfEnd()

--	CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
--		GunBreak("심층부 \x18Core of Galaxy \x04를",333333,6)
--	CIfEnd()
	CDoActions(FP,{Gun_SetLine(4,Add,1)})
	CIf(FP,{Gun_Line(54,AtLeast,1),}) -- SuspendCode
		
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


end