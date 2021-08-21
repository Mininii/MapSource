
function GunData()
	local G_TempW = CreateVar(FP)
	local CurLoc,CurLoc2 = CreateVars(2,FP)
	f_Gun = SetCallForward()
	SetCall(FP)

	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
	CIf(FP,CVar(FP,count[2],AtMost,1500))
		Create_CreateTables(6)
	CIfEnd()
	DoActions(FP,{SetSwitch(RandSwitch,Random)})
	CIf(FP,TTOR({Gun_Line(0,Exactly,132),Gun_Line(0,Exactly,133)})) -- BdIndex LAIR HIVE

		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0),Gun_Line(0,Exactly,132)})
			CDoActions(FP,{Gun_SetLine(4,Add,f_CRandNum(80,395))})
			GunBreak("기지 \x18Lair \x04를",50000,2)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
--			G_CA_SetSpawn(nil,{54},"ACAS",{"NBYD"})
--			G_CA_SetSpawn(nil,{54},{S_5},{2})
		CIfEnd()
		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0),Gun_Line(0,Exactly,133)})
			CDoActions(FP,{Gun_SetLine(4,Add,f_CRandNum(80,395))})
			GunBreak("기지 \x18Hive \x04를",55555,4)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
--			G_CA_SetSpawn(nil,{55},"ACAS",{"NBYD"})
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 3, GMode),Command(Force2,Exactly,0,"Stasis Cell/Prison")},{23,74,88},{P_6,S_3,P_3},{3,1,4,3},"MAX",nil,2)
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 3, GMode),Command(Force2,Exactly,1,"Stasis Cell/Prison")},{74,88},{S_3,P_3},{1,4,3},"MAX",nil,2)
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 3, GMode),Command(Force2,Exactly,2,"Stasis Cell/Prison")},{88},{P_3},{4,3},"MAX",nil,2)
			G_CA_SetSpawn({CDeaths(FP, AtLeast, 2, GMode)},{103},{S_8},{3},"MAX",2,2)

		CIfEnd()

		CMov(FP,CurLoc,_Mul(f_GunNum,_Mov(20/4)))
		CMov(FP,CurLoc2,_Add(f_GunNum,190))
		CDoActions(FP,{
			TSetMemory(_Add(CurLoc,EPDF(0x58DC60 + (20*189))),SetTo,_Sub(Var_TempTable[2],32*9)),
			TSetMemory(_Add(CurLoc,EPDF(0x58DC64 + (20*189))),SetTo,_Sub(Var_TempTable[3],32*9)),
			TSetMemory(_Add(CurLoc,EPDF(0x58DC68 + (20*189))),SetTo,_Add(Var_TempTable[2],32*9)),
			TSetMemory(_Add(CurLoc,EPDF(0x58DC6C + (20*189))),SetTo,_Add(Var_TempTable[3],32*9)),
		})
		CDoActions(FP,{
			TSetCtrig1X("X",0x580,CAddr("CMask",3),nil,SetTo,CurLoc2),
			TSetCtrig1X("X",0x580,CAddr("CMask",4),nil,SetTo,CurLoc2),
			TSetCtrig1X("X",0x581,CAddr("CMask",2),nil,SetTo,CurLoc2),
			TSetCtrig1X("X",0x581,CAddr("CMask",3),nil,SetTo,CurLoc2),
			TSetCtrig1X("X",0x582,CAddr("CMask",2),nil,SetTo,CurLoc2),
		})
		Trigger { -- No comment (00F60EE3)
			players = {FP},
			conditions = {
				Label(0x580);
				CDeaths(FP, AtLeast, 3, GMode);
				Bring(Force2, AtLeast, 6, "Men", 1);
				Bring(Force1, AtMost, 2, "Factories", 1);
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
				Bring(Force1, AtLeast, 3, "Factories", 1);
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



		CIf(FP,{CVar(FP,count[2],AtMost,1500),Gun_Line(4,AtLeast,480)})
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
				for i = 1, #LV_10_UnitTable do
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,10),CDeaths(FP,Exactly,0,BreakCcode)},{
						SetCVar(FP,UnitIDV2[2],SetTo,LV_10_UnitTable[i]);
						SetCVar(FP,UnitIDV3[2],SetTo,LV_10_11_AirTable[i]);
						SetCDeaths(FP,SetTo,1,BreakCcode);
					})
				end
				LV_11_UnitTable = {32,74,23,68,32,74,23,68,32,74,23,68}
				for i = 1, #LV_11_UnitTable do
					TriggerX(FP,{Gun_Line(5,AtLeast,1),Gun_Line(3,Exactly,11),CDeaths(FP,Exactly,0,BreakCcode)},{
						SetCVar(FP,UnitIDV2[2],SetTo,LV_11_UnitTable[i]);
						SetCVar(FP,UnitIDV3[2],SetTo,LV_10_11_AirTable[i]);
						SetCDeaths(FP,SetTo,1,BreakCcode);
					})
				end
				


				local ZergUnit1 = {40, 37}
				local ZergUnit2 = {38, 39}
				local ZergUnit3 = {54, 53}
				local ZergUnit4 = {104, 48, 51}
				UID1I = 221
				UID2I = 222
				UID3I = 223
				UID4I = 224 -- Zerg Air
				CIf(FP,{Gun_Line(0,Exactly,132)}) -- Case Lair
					CIf(FP,CDeaths(FP,Exactly,1,GMode)) -- Case Easy
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID1I,UID2I},"ACAS",{"L00_1_96L","L00_1_96F"})
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],Exactly,0)},{UID1I},"ACAS",{"L00_1_96L"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,"ACAS","L00_1_64F")
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit2,"ACAS","L00_1_64F")
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit3,"ACAS","L00_1_64F")
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},"ACAS","L00_1_96F")
						G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS","L00_1_128F")
					CIfEnd()
				CIfEnd()
				CIf(FP,{Gun_Line(0,Exactly,133)}) -- Case Hive
					CIf(FP,CDeaths(FP,Exactly,1,GMode)) -- Case Easy
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],AtLeast,1)},{UID1I,UID2I},"ACAS",{"H00_1_82L","H00_1_82F"})
						G_CA_SetSpawn({CVar(FP,UnitIDV1[2],AtLeast,1),CVar(FP,UnitIDV2[2],Exactly,0)},{UID1I},"ACAS",{"H00_1_82L"})
						G_CA_SetSpawn({Gun_Line(5,Exactly,0)},ZergUnit1,"ACAS","H00_1_64F")
						G_CA_SetSpawn({Gun_Line(5,Exactly,1)},ZergUnit2,"ACAS","H00_1_64F")
						G_CA_SetSpawn({Gun_Line(5,Exactly,2)},ZergUnit3,"ACAS","H00_1_64F")
						G_CA_SetSpawn({CVar(FP,UnitIDV4[2],AtLeast,1)},{UID4I},"ACAS","H00_1_82F")
						G_CA_SetSpawn({CVar(FP,UnitIDV3[2],AtLeast,1)},{UID3I},"ACAS","H00_1_96F")
					CIfEnd()
				CIfEnd()
			for i = 0, 11 do
				TriggerX(FP,{Gun_Line(5,AtLeast,2),Gun_Line(0,Exactly,132),Gun_Line(3,Exactly,i)},{SetCDeaths(FP,Subtract,1,CCode(0x1001,i))},{Preserved})
				TriggerX(FP,{Gun_Line(5,AtLeast,2),Gun_Line(0,Exactly,133),Gun_Line(3,Exactly,i)},{SetCDeaths(FP,Subtract,1,CCode(0x1002,i))},{Preserved})
			end
			CIfEnd()
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		
		CTrigger(FP,{Gun_Line(5,AtLeast,4),G_CA_CondStack},{Gun_DoSuspend()},1)
	CIfEnd()
	CIf(FP,Gun_Line(0,Exactly,216)) -- BdIndex Chrysalis
		CIf(FP,{Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,10)})
			GunBreak("번데기 \x18Small Chrysalis \x04를",45000,3)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
		CIfEnd()
		CIf(FP,{Gun_Line(4,AtLeast,10),Gun_Line(5,AtMost,19)})
			TriggerX(FP,{Gun_Line(3,Exactly,0)},{SetCVar(FP,UnitIDV1[2],SetTo,80)},{Preserved})
			TriggerX(FP,{Gun_Line(3,Exactly,1)},{SetCVar(FP,UnitIDV1[2],SetTo,21)},{Preserved})
			f_TempRepeatX({CDeaths(FP,Exactly,1,GMode)},UnitIDV1,2,188)
			f_TempRepeatX({CDeaths(FP,Exactly,2,GMode)},UnitIDV1,6,188)
			f_TempRepeatX({CDeaths(FP,Exactly,3,GMode)},UnitIDV1,12,188)
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(5,AtLeast,20),G_CA_CondStack},{Gun_DoSuspend(),SetCDeaths(FP,Add,1,Chry_cond)},1)
		
	CIfEnd()
	CIf(FP,Gun_Line(0,Exactly,190)) -- BdIndex Core of Galaxy
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("심층부 \x18Core of Galaxy \x04를",333333,6)
		Trigger {
			players = {FP},
			conditions = {
			},
			actions = {
				SetMemory(0x6509B0,SetTo,0);
				RunAIScript("Turn ON Shared Vision for Player 8");
				SetMemory(0x6509B0,SetTo,1);
				RunAIScript("Turn ON Shared Vision for Player 8");
				SetMemory(0x6509B0,SetTo,2);
				RunAIScript("Turn ON Shared Vision for Player 8");
				SetMemory(0x6509B0,SetTo,3);
				RunAIScript("Turn ON Shared Vision for Player 8");
				SetMemory(0x6509B0,SetTo,4);
				RunAIScript("Turn ON Shared Vision for Player 8");
				SetMemory(0x6509B0,SetTo,5);
				RunAIScript("Turn ON Shared Vision for Player 8");
				SetMemory(0x6509B0,SetTo,FP);
			}
		}
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
			SetMemory(0x6CA010, SetTo, 12000);--배틀
			SetMemory(0x6C9F8C, SetTo, 12000);--아비터
			SetMemory(0x6C9FA4, SetTo, 12000);--스카웃
		},{preserved})

		CTrigger(FP,{Gun_Line(4,AtLeast,2)},{Gun_SetLine(4,SetTo,0),Gun_SetLine(3,Add,1)},1)
		CIf(FP,{Gun_Line(3,AtLeast,2),Gun_Line(5,AtMost,(#DisGunUnitID)-1)},{Gun_SetLine(3,SetTo,0)})
		local DisGunTempPos = CreateVar(FP)
		CMov(FP,DisGunTempPos,_Mul(DisGun,_Mov(32)))
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
			SetMemory(0x58DC60 + 0x14*0,SetTo,0),
			SetMemory(0x58DC68 + 0x14*0,SetTo,32),
			TSetMemory(0x58DC64 + 0x14*0,SetTo,DisGunTempPos),
			TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(DisGunTempPos,32)),
			TCreateUnit(1,UnitIDVDis,1,P8),
			Order("Men",P8,1,Attack,2),
			SetDeathsX(CurrentPlayer,Add,1,0,0xFF),
			SetDeathsX(CurrentPlayer,Subtract,2*65536,0,0xFF0000),
			SetCVar(FP,DisGun[2],Add,1),
			SetMemory(0x662350 + (27*4), SetTo, (30000*256));
			SetMemory(0x662350 + (88*4), SetTo, (40000*256));
			SetMemory(0x662350 + (98*4), SetTo, (20000*256));
		})

		CTrigger(FP,{CVar(FP,DisGun[2],AtLeast,127)},{Gun_SetLine(5,Add,1),SetCVar(FP,DisGun[2],SetTo,0)},1)
		
		CIfEnd()
		CTrigger(FP,{CDeaths(FP,AtLeast,3,GMode)},{Gun_SetLine(3,SetTo,2)},1)
		
		TriggerX(FP,{CVar(FP,HondonMode[2],AtMost,0)},{
			SetMemory(0x6CA010, SetTo, 640);--배틀
			SetMemory(0x6C9F8C, SetTo, 1280);--아비터
			SetMemory(0x6C9FA4, SetTo, 1280);--스카웃
		
		},{preserved})
		TriggerX(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{
			SetMemory(0x6CA010, SetTo, 12000);--배틀
			SetMemory(0x6C9F8C, SetTo, 12000);--아비터
			SetMemory(0x6C9FA4, SetTo, 12000);--스카웃
		
		},{preserved})
		CTrigger(FP,{Gun_Line(5,AtLeast,(#DisGunUnitID)),G_CA_CondStack},{
			Gun_DoSuspend(),
			SetCDeaths(FP,Add,1,SPGunCond);
			SetMemory(0x6509B0,SetTo,0);
			RunAIScript("Turn OFF Shared Vision for Player 8");
			SetMemory(0x6509B0,SetTo,1);
			RunAIScript("Turn OFF Shared Vision for Player 8");
			SetMemory(0x6509B0,SetTo,2);
			RunAIScript("Turn OFF Shared Vision for Player 8");
			SetMemory(0x6509B0,SetTo,3);
			RunAIScript("Turn OFF Shared Vision for Player 8");
			SetMemory(0x6509B0,SetTo,4);
			RunAIScript("Turn OFF Shared Vision for Player 8");
			SetMemory(0x6509B0,SetTo,5);
			RunAIScript("Turn OFF Shared Vision for Player 8");
			SetMemory(0x6509B0,SetTo,FP);
			PreserveTrigger();},1)
	CIfEnd()

	CIf(FP,Gun_Line(0,Exactly,147)) -- BdIndex Monster Kraken
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,f_CRandNum(80,395))})
			GunBreak("빅! 한 \x18Monster Kraken! \x04을",777777,6)
		CIfEnd()
		CTrigger(FP,{CDeaths(FP,Exactly,1,GMode)},{Gun_SetLine(4,Add,35)},1)
		CTrigger(FP,{CDeaths(FP,Exactly,2,GMode)},{Gun_SetLine(4,Add,23)},1)
		CTrigger(FP,{CDeaths(FP,Exactly,3,GMode)},{Gun_SetLine(4,Add,11)},1)
		
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
		CTrigger(FP,{Gun_Line(4,AtLeast,1100),G_CA_CondStack},{Gun_DoSuspend(),SetCDeaths(FP,Add,1,SPGunCond)},1)
	CIfEnd()
	

	


	CIf(FP,TTOR({Gun_Line(0,Exactly,156),Gun_Line(0,Exactly,109),Gun_Line(0,Exactly,173)})) -- BdIndex Pylon Supply Formation
		CIf(FP,{Gun_Line(0,Exactly,156),Gun_Line(4,Exactly,0)})
			GunBreak("수정탑 \x18Pylon \x04을",100000,4)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
		CIfEnd()
		CIf(FP,{Gun_Line(0,Exactly,109),Gun_Line(4,Exactly,0)})
			GunBreak("보급고 \x18Supply \x04를",100000,4)
			Trigger2X(FP,{Switch(RandSwitch,Set)},{SetCDeaths(FP,Add,1,BGMType)},{Preserved})
		CIfEnd()
		CIf(FP,{Gun_Line(0,Exactly,173),Gun_Line(4,Exactly,0)})
			GunBreak("수정 집합체 \x18Formation \x04을",400000,6)
		CIfEnd()
		CTrigger(FP,{Gun_Line(4,Exactly,0)},{Gun_SetLine(50,SetTo,1),Gun_SetLine(51,SetTo,1830)},1)
		CTrigger(FP,{Gun_Line(50,Exactly,0)},{Gun_SetLine(5,Add,1)},1)
		CTrigger(FP,{Gun_Line(50,Exactly,1)},{Gun_SetLine(5,Subtract,1)},1)
		CTrigger(FP,{Gun_Line(5,Exactly,0),Gun_Line(50,Exactly,1)},{Gun_SetLine(3,Add,1),Gun_SetLine(50,SetTo,0)},1)
		CTrigger(FP,{Gun_Line(5,AtLeast,60),Gun_Line(50,Exactly,0)},{Gun_SetLine(50,SetTo,1),Gun_SetLine(51,SetTo,0)},1)
		CTrigger(FP,{Gun_Line(50,Exactly,1)},{Gun_SetLine(51,Add,Var_TempTable[6])},1)
		CTrigger(FP,{Gun_Line(50,Exactly,0)},{Gun_SetLine(51,Subtract,Var_TempTable[6])},1)
		CTrigger(FP,{Gun_Line(3,Exactly,7)},{SetCDeaths(FP,SetTo,0,ScanEffT);},1)
		CDoActions(FP,{Gun_SetLine(52,Add,3)}) -- 
		CTrigger(FP,{Gun_Line(52,AtLeast,72)},{Gun_SetLine(52,SetTo,0)},1)
		TriggerX(FP,{Gun_Line(0,Exactly,156)},{
			SetCVar(FP,Gun_UID[2],SetTo,16);
			SetCVar(FP,Gun_UID2[2],SetTo,193);
			SetCVar(FP,Gun_UID3[2],SetTo,179);},{Preserved})
		TriggerX(FP,{Gun_Line(0,Exactly,109)},{
			SetCVar(FP,Gun_UID[2],SetTo,17);
			SetCVar(FP,Gun_UID2[2],SetTo,192);
			SetCVar(FP,Gun_UID3[2],SetTo,180);},{Preserved})
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
				DoActions(FP,{SetMemoryX(0x669FAC, SetTo, 9*16777216,0xFF000000);CreateUnit(1,205,1,FP)})
				f_Lengthdir(FP,_Div(Var_TempTable[52],_Mov(7)),_Add(_Add(Var_TempTable[53],36),_Mul(Gun_W,_Mov(72))),Gun_X,Gun_Y)
				f_Div(FP,Gun_Y,2)
				Call_Gun_LocPos()
				DoActions(FP,{SetMemoryX(0x669FAC, SetTo, 17*16777216,0xFF000000);CreateUnit(1,205,1,FP)})
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
							TSetMemoryX(0x669FAC, SetTo, _Mul(Gun_UID,16777216),0xFF000000);
							CreateUnit(1,33,1,FP)})
					NIfEnd()
					Nif(FP,{Gun_Line(0,Exactly,173)})
						DoActions(FP,{
							SetMemoryX(0x666458, SetTo, 391,0xFFFF);
							SetMemoryX(0x669FAC, SetTo, 9*16777216,0xFF000000);
							CreateUnit(1,33,1,FP)})
						f_Lengthdir(FP,_Div(Var_TempTable[52],7),_Add(_Add(Var_TempTable[53],36),_Mul(Gun_W,72)),Gun_X,Gun_Y)
						CDiv(FP,Gun_Y,2)
						Call_Gun_LocPos()
						DoActions(FP,{
							SetMemoryX(0x666458, SetTo, 391,0xFFFF);
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

		CTrigger(FP,{Gun_Line(3,AtLeast,7),G_CA_CondStack},{Gun_DoSuspend()},1)
	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,201)}) -- BdIndex Cocoon
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("거대 고치 \x18Overmind Cocoon \x04을",300000,6)
			DoActions(FP,{
				Simple_CalcLoc(0,-32*8,-32*8,32*8,32*8),
				KillUnitAt(All,"Sunken Colony",1,Force2);
				KillUnitAt(All,"Spore Colony",1,Force2);})
		CIfEnd()
	
		for i = 1, 3 do
			CTrigger(FP,{Gun_Line(4,AtLeast,10),CDeaths(FP,Exactly,0,CocoonGunCon)},{Gun_SetLine(4,SetTo,0),SetCDeaths(FP,Add,1,CocoonLaunch),CreateUnit(1,84,1,FP)},1)
			Trigger { -- 
				players = {FP},
				conditions = {
					Label(0);
					CDeaths(FP,Exactly,i,GMode);
					Bring(11, AtLeast,(200*i)+1,"Men",30);
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
		for i = 0, 3 do
		table.insert(Cocoon_JYD,RunAIScriptAt("Set Unit Order To: Junk Yard Dog",26+i))
		end
		table.insert(Set_Inv,SetInvincibility(Disable,80,Force2,64))
		table.insert(Set_Inv,SetInvincibility(Disable,21,Force2,64))
		Trigger { -- 
			players = {FP},
			conditions = {
				DeathsX(CurrentPlayer,Exactly,580,0,0xFFFF);
				},
			actions = {
				Set_Inv
				}
		}
		Trigger { -- 
			players = {FP},
			conditions = {
				Label(0);
				DeathsX(CurrentPlayer,Exactly,479,0,0xFFFF);
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
		NIf(FP,{Gun_Line(4,Exactly,580)})
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
			GunBreak("사원 \x18Xel'Naga \x04를",255555,6)
		CIfEnd()

		for i =0, 4 do
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
		})
		TriggerX(FP,{CVar(FP,HondonMode[2],Exactly,0)},{SetMemory(0x6CA010, SetTo, 640)},{Preserved})
		TriggerX(FP,{CVar(FP,HondonMode[2],Exactly,1)},{SetMemory(0x6CA010, SetTo, 12000)},{Preserved})

		for i = 1, 3 do
			CTrigger(FP,{CDeaths(FP,Exactly,i,GMode);Gun_Line(4,AtLeast,((8*i)+7)),Gun_Line(5,AtLeast,i+1)},{
				SetCDeaths(FP,Add,1,SPGunCond);
				Gun_DoSuspend();
			},1)
		end
	
	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,152)}) -- BdIndex Daggoth
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("완전체 \x18DaGGoTh \x04를",400000,6)
		CIfEnd()
		CMov(FP,Gun_W,0)
		NWhile(FP,CVar(FP,Gun_W[2],AtMost,3),SetCVar(FP,Gun_W[2],Add,1))
			f_Lengthdir(FP,_Mul(Var_TempTable[5],_Mov(64)),_Add(_Mul(Gun_W,_Mov(90)),_Mul(_Mod(_ReadF(0x58D6F8),_Mov(60)),_Mov(6))),Gun_X,Gun_Y)
			Call_Gun_LocPos()

			NIfX(FP,{
			Memory(0x58DC60 + 0x14*0,AtMost,4096),
			Memory(0x58DC68 + 0x14*0,AtMost,4096),
			Memory(0x58DC64 + 0x14*0,AtMost,4096),
			Memory(0x58DC6C + 0x14*0,AtMost,4096)})
				TriggerX(FP,{CDeaths(FP,Exactly,1,GMode)},{SetCVar(FP,Gun_W2[2],SetTo,1)},{Preserved})
				TriggerX(FP,{CDeaths(FP,Exactly,2,GMode)},{SetCVar(FP,Gun_W2[2],SetTo,2)},{Preserved})
				TriggerX(FP,{CDeaths(FP,Exactly,3,GMode)},{SetCVar(FP,Gun_W2[2],SetTo,4)},{Preserved})

				NWhile(FP,CVar(FP,Gun_W2[2],AtLeast,1),SetCVar(FP,Gun_W2[2],Subtract,1))
					NIfX(FP,{TMemoryX(_Mem(Gun_Level),Exactly,1)})
					CDoActions(FP,{TCreateUnit(1,VArr(UArr1,_Mod(_Rand(),_Mov(16))), 1, _Add((_Mod(_Rand(),_Mov(2))),6))})
					NElseX()
					CDoActions(FP,{TCreateUnit(1,VArr(UArr2,_Mod(_Rand(),_Mov(16))), 1, _Add((_Mod(_Rand(),_Mov(2))),6))})
					NIfXEnd()
				NWhileEnd()
			NIfXEnd()
			CMov(FP,B10_Cond,1)
			CTrigger(FP,{CVar(FP,B10_Cond[2],AtMost,0);G_CA_CondStack},{SetCDeaths(FP,Add,1,SPGunCond),Gun_DoSuspend()},1)
			CMov(FP,B10_Cond,0)
		NWhileEnd()
		f_LoadCP()
	CIfEnd()
	CIf(FP,{Gun_Line(0,Exactly,151)}) -- BdIndex Cerebrate
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,480)})
			GunBreak("정신체 \x18Cerebrate \x04를",300000,6)
		CIfEnd()
		DisPos = {4000,2240}
		CIf(FP,{CVar(FP,count[2],AtMost,1500),Gun_Line(4,AtLeast,480)})
			CereDiff = {"Cere_N","Cere_H","Cere_B"}
			
			
			
			
			G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{56,53},"ACAS","Cere_Z",nil,nil,3)
			G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{57,48},"ACAS","Cere_Z",nil,nil,3)
			G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{58,51},"ACAS","Cere_Z",nil,nil,3)
			for i = 1, 3 do
				G_CA_SetSpawn({CDeaths(FP,Exactly,i,GMode),Gun_Line(5,Exactly,0)},{8,17},"ACAS",CereDiff[i],nil,nil,3)
				G_CA_SetSpawn({CDeaths(FP,Exactly,i,GMode),Gun_Line(5,Exactly,1)},{86,78},"ACAS",CereDiff[i],nil,nil,3)
				G_CA_SetSpawn({CDeaths(FP,Exactly,i,GMode),Gun_Line(5,Exactly,2)},{98,81},"ACAS",CereDiff[i],nil,nil,3)
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
					SetMemory(0x6CA010, SetTo, 640),
					})
					TriggerX(FP,{CVar(FP,HondonMode[2],AtLeast,1)},{SetMemory(0x6CA010, SetTo, 12000)},{preserved})
				CIfEnd()
			NWhileEnd()
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(5,AtLeast,Hive_3F),G_CA_CondStack},{Gun_DoSuspend()},1)
		
	CIfEnd()

	
	CIf(FP,{Gun_Line(0,Exactly,148)}) -- BdIndex Overmind
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			CDoActions(FP,{Gun_SetLine(4,Add,480)})
			GunBreak("초월체 \x18OverMind \x04를",300000,6)
		CIfEnd()

		CIf(FP,{CVar(FP,count[2],AtMost,1500),Gun_Line(4,AtLeast,480)})
			CIf(FP,CDeaths(FP,Exactly,1,GMode))
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{21,15},"ACAS",{"Ovrm_X192","Ovrm_X160"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{53,48,56},"ACAS",{"Ovrm_X96","Ovrm_X128","Ovrm_X160"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{80,87},"ACAS",{"Ovrm_X192","Ovrm_X160"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{51,48,57},"ACAS",{"Ovrm_X96","Ovrm_X128","Ovrm_X160"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{28,17},"ACAS",{"Ovrm_X192","Ovrm_X160"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{51,48,62},"ACAS",{"Ovrm_X96","Ovrm_X128","Ovrm_X160"},nil,nil,1)
			CIfEnd()
			CIf(FP,CDeaths(FP,Exactly,2,GMode))
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{21,15},"ACAS",{"Ovrm_X160","Ovrm_X128"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{53,48,56},"ACAS",{"Ovrm_X96","Ovrm_X96","Ovrm_X128"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{80,87},"ACAS",{"Ovrm_X160","Ovrm_X128"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{51,48,57},"ACAS",{"Ovrm_X96","Ovrm_X96","Ovrm_X128"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{28,17},"ACAS",{"Ovrm_X160","Ovrm_X128"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{51,48,62},"ACAS",{"Ovrm_X96","Ovrm_X96","Ovrm_X128"},nil,nil,1)
			CIfEnd()
			CIf(FP,CDeaths(FP,Exactly,3,GMode))
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{21,15},"ACAS",{"Ovrm_X128","Ovrm_X96"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,0)},{53,48,56},"ACAS",{"Ovrm_X64","Ovrm_X64","Ovrm_X96"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{80,87},"ACAS",{"Ovrm_X128","Ovrm_X96"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,1)},{51,48,57},"ACAS",{"Ovrm_X64","Ovrm_X64","Ovrm_X96"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{28,17},"ACAS",{"Ovrm_X128","Ovrm_X96"},nil,nil,1)
				G_CA_SetSpawn({Gun_Line(5,Exactly,2)},{51,48,62},"ACAS",{"Ovrm_X64","Ovrm_X64","Ovrm_X96"},nil,nil,1)
			CIfEnd()
			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(5,AtLeast,3),G_CA_CondStack},{Gun_DoSuspend()},1)	
	CIfEnd()
	
	CIf(FP,{Gun_Line(0,Exactly,148)}) -- BdIndex Overmind
		CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
			GunBreak("빅! 한 \x18Large Chrysalis \x04를",100000,6)
		CIfEnd()
		CIf(FP,{CVar(FP,count[2],AtMost,1500),Gun_Line(4,AtLeast,480)})

			CDoActions(FP,{Gun_SetLine(4,SetTo,0),Gun_SetLine(5,Add,1)})
		CIfEnd()
		CTrigger(FP,{Gun_Line(5,AtLeast,3),G_CA_CondStack},{Gun_DoSuspend()},1)	
	CIfEnd()
	
--	CIf(FP,{Gun_Line(3,Exactly,0),Gun_Line(4,Exactly,0),Gun_Line(5,Exactly,0)})
--		GunBreak("심층부 \x18Core of Galaxy \x04를",333333,6)
--	CIfEnd()
	CDoActions(FP,{Gun_SetLine(4,Add,1)})
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


--[[
	
	
	
	NIf(FP,DeathsX(CurrentPlayer,Exactly,13*0x1000,0,0xF000)) -- BdIndex 양식
	
	Trigger { -- TIMER
		players = {FP},
		conditions = {Deaths(CurrentPlayer,AtLeast,1,0);},
		actions = {
			MoveCp(Add,1*4);
			SetDeathsX(CurrentPlayer,Subtract,1,0,0xFFFF);
			MoveCp(Subtract,1*4);
			PreserveTrigger();
			}
	}
	CAdd(FP,0x6509B0,1)
	
	NIf(FP,{DeathsX(CurrentPlayer,AtMost,0,0,0xFFFF)})
	CSPlotAct(CS_RatioXY(CSMakeStar(4,180,75,45,7*7,5*5),1,0.5),FP,25,0,nil,1,32,32,nil,FP,{Label(0),CDeaths(FP,Exactly,1,GMode)},nil,1)
	CSPlotAct(CS_RatioXY(CSMakeStar(4,180,75,45,7*7,0),1,0.5),FP,25,0,nil,1,32,32,nil,FP,{Label(0),CDeaths(FP,Exactly,2,GMode)},nil,1)
	CSPlotAct(CS_RatioXY(CSMakeStar(4,180,75,45,9*9,0),1,0.5),FP,25,0,nil,1,32,32,nil,FP,{Label(0),CDeaths(FP,Exactly,3,GMode)},nil,1)
	
	DoActions(FP,{SetDeathsX(CurrentPlayer,Add,1*16777216,0,0xFF000000),SetDeathsX(CurrentPlayer,SetTo,480,0,0xFFFF)})
	NIfEnd()
	
	Trigger {
		players = {FP},
		conditions = {
			Label(0);
			DeathsX(CurrentPlayer,Exactly,3*16777216,0,0xFF000000);
		},
		actions = {SetDeaths(CurrentPlayer,SetTo,0,0);
			MoveCp(Subtract,1*4);
			SetDeaths(CurrentPlayer,SetTo,0,0);
			MoveCp(Add,1*4);
			SetCDeaths(FP,Add,1,B_Chry_cond);
			PreserveTrigger();
		}
	}
	
	CSub(FP,0x6509B0,1)
	NIf(FP,{DeathsX(CurrentPlayer,AtMost,0,0,0x80000000),Deaths(CurrentPlayer,AtLeast,1,0)})
	f_SaveCP()
		GName = "빅! 한 \x18Large Chrysalis \x04를"
		GPoint = 100000
		Mode = 0
		GunText = "\n\n\n\n\n\n\n\n\n\x13\x08！ ！ ！ \x04적의 "..GName.." 파괴하였다!\x17 + "..GPoint.." P t s\x08 ！ ！ ！\n\n"
		Trigger {
		players = {FP},
			conditions = {
			Label(0);
				},
		actions = {
			SetDeathsX(CurrentPlayer,SetTo,1*0x80000000,0,0x80000000);
			SetMemory(0x6509B0, SetTo, 0);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 1);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 2);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 3);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 4);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 5);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 128);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 129);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 130);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, 131);
			DisplayText(GunText,4);
			SetMemory(0x6509B0, SetTo, FP);
			SetScore(Force1,Add,GPoint,Kills);
			SetCDeaths(FP,SetTo,3,BGMType);
			PreserveTrigger();
			},
		}
	f_LoadCP()
	NIfEnd()
	NIfEnd()
	
	
	NIfEnd()
	DoActions(FP,MoveCp(Add,2*4))
	DoWhileEnd({Memory(0x6509B0,AtMost,EPD(MemoryPtr)+200)})
	NJumpEnd(FP,WhileLaunchJump)
	NIfEnd()
	SetRecoverCp()
	RecoverCp(FP)

	--]]
		
end