function Install_boss()
	CIf({Force1,FP},{Deaths(P12,AtMost,0,186),CGMode(2,AtLeast),CDeaths(FP,AtLeast,6000,GunBossAct),Bring(Force2, AtMost, 0, "Protoss Temple", 64)},{SetCDeaths(FP,SetTo,1,BossStart),ModifyUnitShields(All,186,FP,64,100)})

		local CBulletIndex = 0x1100
		for i = 0, 127 do
			local Index = 0
			if i == 0 then Index = CBulletIndex end
			CTrigger(FP, {CVar("X","X",AtLeast,1)}, {
				SetCVar(FP,TempEPD[2],SetTo,0),
				SetCVar(FP,TempT[2],SetTo,0),
				SetCVar(FP,TempA[2],SetTo,0),
				SetCtrigX("X",CB_TempH[2],0x15C,0,SetTo,"X","X",0x15C,1,0),
				SetNext("X",Call_CBulletA,0),SetNext(Call_CBulletA+1,"X",1), -- Call f_Gun
				SetCtrigX("X",Call_CBulletA+1,0x158,0,SetTo,"X","X",0x4,1,0), -- RecoverNext
				SetCtrigX("X",Call_CBulletA+1,0x15C,0,SetTo,"X","X",0,0,1), -- RecoverNext
				SetCtrig1X("X",Call_CBulletA+1,0x164,0,SetTo,0x0,0x2) -- RecoverNext
			}, 1, Index)
		end
		table.insert(CtrigInitArr[7],SetCtrigX(FP,CBullet_InputH[2],0x15C,0,SetTo,FP,CBulletIndex,0x15C,1,0))

		DoActions(FP,{SetMemoryB(0x6636B8+204, SetTo, 125), -- 무기변경
			SetInvincibility(Enable,"Men",Force1,"Location 2")})
		if Limit == 1 then
			CIfX({Force1,FP},CDeaths(FP,AtLeast,1,TestMode))
				DoActions({Force1,FP},{SetCountdownTimer(SetTo,1)},1)
			CElseX()
				DoActions({Force1,FP},{SetCountdownTimer(SetTo,180)},1)
			CIfXEnd()
		else
			DoActions({Force1,FP},{SetCountdownTimer(SetTo,180)},1)
		end

		Trigger { -- 브금재생 보스
			players = {Force1},
			conditions = {
				Label(0);
				CountdownTimer(AtMost,0);
				Deaths(CurrentPlayer,AtMost,0,440);
			},
				actions = {
				SetDeathsX(CurrentPlayer,SetTo,138 * 1000,440,0xFFFFFF);
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PreserveTrigger();
			},
		}
		--{"staredit\\wav\\FBoss.ogg",148 * 1000}
		Trigger { -- 브금재생 보스
			players = {Force1},
			conditions = {
				Label(0);
				CountdownTimer(AtMost,0);
				Deaths(CurrentPlayer,AtMost,0,440);
			},
				actions = {
				SetDeathsX(CurrentPlayer,SetTo,138 * 1000,440,0xFFFFFF);
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PreserveTrigger();
			},
		}
		Trigger { -- 브금재생 보스 관전자
			players = {FP},
			conditions = {
				Label(0);
				CountdownTimer(AtMost,0);
				Deaths(FP,AtMost,0,440);
			},
				actions = {
				SetDeathsX(FP,SetTo,138 * 1000,440,0xFFFFFF);
				SetMemory(0x6509B0,SetTo,128);
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PlayWAV("staredit\\wav\\FBoss.ogg");
				SetMemory(0x6509B0,SetTo,129);
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PlayWAV("staredit\\wav\\FBoss.ogg");
				SetMemory(0x6509B0,SetTo,130);
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PlayWAV("staredit\\wav\\FBoss.ogg");
				SetMemory(0x6509B0,SetTo,131);
				PlayWAV("staredit\\wav\\FBoss.ogg");
				PlayWAV("staredit\\wav\\FBoss.ogg");
				SetMemory(0x6509B0,SetTo,FP);
				PreserveTrigger();
			},
		}
		DoActions(FP,{KillUnit(101,11)})
		local FBPtr = CreateVar(FP)
		local FBH = CreateVar(FP)
		CIfOnce(FP,{Memory(0x628438,AtLeast,1)},SetBulletSpeed(500))
		
		DoActions(FP,{
			ModifyUnitEnergy(All,"Any unit",Force2,64,0),KillUnit("Any unit",Force2),SetInvincibility(Enable,"Men",Force1,64),SetDeaths(Force1,SetTo,1,101),SetDeaths(Force1,SetTo,1,102)
		})
			CMov(FP,0x6509B0,19025+9)
			CWhile(FP,Memory(0x6509B0,AtMost,19025 + (84*1699)+9))
			DoActions(FP,{SetDeathsX(CurrentPlayer,SetTo,0,0,0xFF0000)})
			CAdd(FP,0x6509B0,84)
			CWhileEnd()
			CMov(FP,0x6509B0,FP)
			
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF,1)
			CMov(FP,FBPtr,Nextptrs)
			DoActions(FP,{CreateUnitWithProperties(1,186,"Location 31",FP,{invincible = true}),GiveUnits(1,186,FP,64,11)})
			CMov(FP,FBH,Nextptrs,2)
			CDoActions(FP,{TSetMemory(FBH,SetTo,8320000*256)})
			
			DoActions(FP,{
				CreateUnit(1,101,26,Force1),
				CreateUnit(1,101,27,Force1),
				CreateUnit(1,101,28,Force1),
				CreateUnit(1,101,29,Force1),
			})

		CIfEnd()

		Trigger2(FP,{CountdownTimer(AtMost,20)},{CopyCpAction({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※\n\n\n\x13\x08최후의 적 \x0FU\x04nknown\x08.2 \x04와의 전투가 곧 시작됩니다.\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※",4),PlayWAVX("sound\\glue\\bnetclick.wav"),MinimapPing("Location 31")},HumanPlayers,FP)})
		Trigger2(FP,{CountdownTimer(AtMost,0)},{CopyCpAction({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x08※※※※※※※※※※\x07 I N F O R M A T I O N\x08 ※※※※※※※※※※\n\n\x04\x13적 이름 : \x0FU\x04nknown\x08.2\n\x13\x10능력 : \x04강력한 광범위 탄막 공격, 대상에게 강한 적대감을 느낀다.\n\x13\x0E처치방법 : \x04탄막 파훼 컨트롤\n\x13\x04당신의 \x03진정한 컨트롤\x04을 보여주세요!\n\n\x13\x08※※※※※※※※※※\x07 I N F O R M A T I O N\x08 ※※※※※※※※※※",4),PlayWAVX("sound\\glue\\bnetclick.wav"),MinimapPing("Location 31")},HumanPlayers,FP),
			GiveUnits(1,186,11,64,FP),SetInvincibility(Disable,186,FP,64),SetDeaths(Force1,SetTo,1,48)})
		local BT_Ready = CreateCcode()
		local BT_Ready2 = CreateCcode()
		local BT1 = CreateCcode()
		local BT2 = CreateCcode()
		local BT3 = CreateCcode()
		local BR = CreateCcode()
		local BT_0 = CreateCcode()
		
		local BP2_T1 = CreateCcode()
		local BP2_T2 = CreateCcode()
		local BP2_T3 = CreateCcode()
		local BP2_T4 = CreateCcode()

		local BP3_T1 = CreateCcode()
		local BP3_T2 = CreateCcode()
		local BP3_T3 = CreateCcode()
		local BP3_T4 = CreateCcode()
		
		local BP4_T1 = CreateCcode()
		local BP4_T2 = CreateCcode()
		local BP4_T3 = CreateCcode()
		local BP4_T4 = CreateCcode()
		CIf(FP,CountdownTimer(AtLeast,1))
		TriggerX(FP,{CDeaths(FP,AtMost,0,BT_Ready)},{SetCDeaths(FP,SetTo,50,BT_Ready),SetCDeaths(FP,SetTo,1,BT_Ready2)},{Preserved})
		CIfEnd()
		
		CIf(FP,{CVar(FP,FBH[2],AtLeast,1),CVar(FP,FBH[2],AtMost,19025+(84*1699))})
			if Limit == 1 then
			CTrigger(FP,{CDeaths(FP,AtLeast,1,TestMode),Deaths(P1,AtLeast,1,201)},{TSetMemory(FBH,Subtract,1000000*256)},1)
			end
			CTrigger(FP,{TMemory(FBH,AtMost,6320000*256)},{CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),SetCDeaths(FP,SetTo,300,BT_0),SetCDeaths(FP,Add,1,B_P),SetCDeaths(FP,SetTo,1,BT_Ready2)})
			CTrigger(FP,{TMemory(FBH,AtMost,4320000*256)},{CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),SetCDeaths(FP,SetTo,300,BT_0),SetCDeaths(FP,Add,1,B_P),SetCDeaths(FP,SetTo,1,BT_Ready2)})
			CTrigger(FP,{TMemory(FBH,AtMost,2320000*256)},{CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),SetCDeaths(FP,SetTo,300,BT_0),SetCDeaths(FP,Add,1,B_P),SetCDeaths(FP,SetTo,1,BT_Ready2)})
			CTrigger(FP,{TMemory(FBH,AtMost,320000*256)},{TSetMemory(FBH,SetTo,8320000*256),CopyCpAction({PlayWAVX("staredit\\wav\\HeroKill.ogg"),PlayWAVX("staredit\\wav\\HeroKill.ogg")},HumanPlayers,FP),SetCDeaths(FP,SetTo,300,BT_0),SetCDeaths(FP,Add,1,B_P),SetCDeaths(FP,SetTo,1,BT_Ready2)})
			CIf(FP,{CDeaths(FP,Exactly,4,B_P),CDeaths(FP,AtMost,2000,BP4_T1)})
				local TotalDmg = CreateVar(FP)
				local TempDmg = CreateVar(FP)
				local Load_HP = CreateVar(FP)

				f_Read(FP,FBH,TempDmg)
				CMov(FP,TotalDmg,_Sub(_Mov(8320000*256),TempDmg))
				CAdd(FP,CanC,_Div(TotalDmg,256))
				CTrigger(FP,{TMemory(FBH,AtMost,8319999*256)},{TSetMemory(FBH,SetTo,8320000*256)},1)
			CIfEnd()
			
		CIfEnd()
			CTrigger(FP,{TMemoryX(_Add(FBH,17),Exactly,0,0xFF00)},{SetCVar(FP,FBH[2],SetTo,0)})
		CDoActions(FP,{SetCDeaths(FP,Subtract,1,BT1),SetCDeaths(FP,Subtract,1,BT_Ready),SetCDeaths(FP,SetTo,0,BR)})
		
		local BossXY = {1024,2400}
		
		local B_A1 = CreateVar(FP)
		local BP2_TV = CreateVar(FP)
		local B_AP = CreateCcode()

		Trigger2(FP,{CountdownTimer(AtLeast,1)},{MoveUnit(All,"Men",Force1,"Field1","Move"),MoveUnit(All,"Men",Force1,"Field2","Move"),MoveUnit(All,"Men",Force1,"Field3","Move"),MoveUnit(All,"Men",Force1,"Field4","Move")},{Preserved})
		
		Trigger2(FP,{CountdownTimer(AtMost,0)},{
			SetInvincibility(Disable,"Men",Force1,"Field1"),
			SetInvincibility(Disable,"Men",Force1,"Field2"),
			SetInvincibility(Disable,"Men",Force1,"Field3"),
			SetInvincibility(Disable,"Men",Force1,"Field4"),
		},{Preserved})
--		DoActions(FP,Order(186,FP,64,Move,"Location 31"))
		TriggerX(FP,{CountdownTimer(AtMost,0),CDeaths(FP,AtMost,0,BT_0),CDeaths(FP,AtMost,3,B_P)},{SetInvincibility(Disable,186,FP,64)},{Preserved})
		CIfX(FP,{CountdownTimer(AtMost,0),CDeaths(FP,AtMost,0,BT_0)})
		
			CIf(FP,CDeaths(FP,Exactly,0,B_P))
				GetLocCenter("Location 31",BPosX,BPosY)
				local BRT = {"HLC","HRC","HUC","HDC"}
				for i = 0, 1 do
					DoActions(FP,{SetSwitch("Switch 1",Random)})
					TriggerX(FP,{Switch("Switch 1",Set)},{SetCDeaths(FP,Add,2^i,BR)},{Preserved})
				end
				for i = 0, 3 do
				G_CA_SetSpawn({CDeaths(FP,Exactly,0,BT1),CDeaths(FP,Exactly,i,BR)},{204},{"ACAS"},{BRT[i+1]},"MAX",nil,nil,BossXY)
				end
				TriggerX(FP,{CGMode(3),CDeaths(FP,AtMost,0,BT1)},{SetCDeaths(FP,SetTo,85,BT1)},{Preserved})
				TriggerX(FP,{CGMode(2),CDeaths(FP,AtMost,0,BT1)},{SetCDeaths(FP,SetTo,150,BT1)},{Preserved})
			CIfEnd()

			CIf(FP,CDeaths(FP,Exactly,1,B_P),{})
				TriggerX(FP,{CGMode(2)},{SetBulletSpeed(1000)},{Preserved})
				TriggerX(FP,{CGMode(3)},{SetBulletSpeed(2000)},{Preserved})
				for i = 1, 4 do
					TriggerX(FP,{CDeaths(FP,Exactly,100*i,BP3_T2)},{SetCDeaths(FP,SetTo,i,BP3_T1)},{Preserved})
				end
				TriggerX(FP,{CDeaths(FP,AtLeast,401,BP3_T2)},{SetCDeaths(FP,SetTo,0,BP3_T2)},{Preserved})
				G_CA_SetSpawn(CDeaths(FP,AtMost,0,BP3_T3),{206},{"ACAS"},{"Boss4"},nil,1,nil,BossXY)
				TriggerX(FP,{CDeaths(FP,AtMost,0,BP3_T3)},{SetCDeaths(FP,SetTo,256,BP3_T3)},{Preserved})
				CIfX(FP,{CDeaths(FP,Exactly,1,BP3_T1)})
					GetLocCenter("Field1",BPosX,BPosY)
					G_CA_SetSpawn(nil,{204},{"ACAS"},{"Boss2"},1,nil,nil,{0,0})
				CElseIfX({CDeaths(FP,Exactly,2,BP3_T1)})
					GetLocCenter("Field2",BPosX,BPosY)
					G_CA_SetSpawn(nil,{204},{"ACAS"},{"Boss3"},1,nil,nil,{0,0})
				CElseIfX({CDeaths(FP,Exactly,3,BP3_T1)})
					GetLocCenter("Field3",BPosX,BPosY)
					G_CA_SetSpawn(nil,{204},{"ACAS"},{"Boss2"},1,nil,nil,{0,0})
				CElseIfX({CDeaths(FP,Exactly,4,BP3_T1)})
					GetLocCenter("Field4",BPosX,BPosY)
					G_CA_SetSpawn(nil,{204},{"ACAS"},{"Boss3"},1,nil,nil,{0,0})
				CIfXEnd()
				DoActionsX(FP,{SetCDeaths(FP,SetTo,0,BP3_T1),SetCDeaths(FP,Add,1,BP3_T2),SetCDeaths(FP,Subtract,1,BP3_T3)})
			CIfEnd()
			CIf(FP,CDeaths(FP,Exactly,2,B_P),{SetCDeaths(FP,Add,1,BP2_T2),SetCDeaths(FP,Add,1,BP2_T3),SetBulletSpeed(700)})
				TriggerX(FP,{CDeaths(FP,AtLeast,256,BP2_T3)},{SetCDeaths(FP,SetTo,0,BP2_T3),SetCDeaths(FP,SetTo,0,BP2_T4)},{Preserved})
				CIf(FP,CDeaths(FP,AtMost,0,BP2_T1))
					CMov(FP,B_CA_Angle,f_CRandNum(360))
				CIfEnd()
					G_CA_SetSpawn({CDeaths(FP,AtMost,0,BP2_T4)},{206},{"ACAS"},{"Boss1"},1,2,nil,BossXY)
					DoActionsX(FP,{SetCDeaths(FP,SetTo,1,BP2_T4),SetCDeaths(FP,Add,1,BP2_T1)})
					TriggerX(FP,{CGMode(2)},{SetCVar(FP,BP2_TV[2],SetTo,70)},{Preserved})
					TriggerX(FP,{CGMode(3)},{SetCVar(FP,BP2_TV[2],SetTo,30)},{Preserved})
				CIf(FP,{TCDeaths(FP,AtLeast,BP2_TV,BP2_T2)},SetCDeaths(FP,SetTo,0,BP2_T2))
					CMov(FP,B_A1,f_CRandNum(1360))
					CreateBullet(204,20,B_A1,BossXY)
					CreateBullet(204,20,_Add(B_A1,128),BossXY)
					CreateBullet(204,20,_Add(B_A1,64),BossXY)
					CreateBullet(204,20,_Add(B_A1,192),BossXY)
					CIf(FP,{CGMode(3)})
						CreateBullet(204,20,_Add(B_A1,32),BossXY)
						CreateBullet(204,20,_Add(B_A1,96),BossXY)
						CreateBullet(204,20,_Add(B_A1,128+32),BossXY)
						CreateBullet(204,20,_Add(B_A1,192+32),BossXY)
					CIfEnd()
				CIfEnd()
				TriggerX(FP,{CDeaths(FP,AtLeast,500,BP2_T1)},{
					SetCDeaths(FP,SetTo,0,BP2_T1),
					SetCDeaths(FP,SetTo,0,BP2_T2),
					SetCDeaths(FP,SetTo,0,BP2_T3),
					SetCDeaths(FP,SetTo,0,BP2_T4),
					SetCDeaths(FP,SetTo,300,BT_0)

				},{Preserved})
			CIfEnd()
			CIf(FP,CDeaths(FP,Exactly,3,B_P),{SetCDeaths(FP,Add,1,BT2)})
				CMov(FP,B_CA_Angle,0)
				TriggerX(FP,{CGMode(2)},{SetBulletSpeed(1300)})
				TriggerX(FP,{CGMode(3)},{SetBulletSpeed(1700)})
				G_CA_SetSpawn({CDeaths(FP,Exactly,1,BT2)},{206},{"ACAS"},{"Chry_1"},1,1,nil,{0,0})
				G_CA_SetSpawn({CDeaths(FP,Exactly,256,BT2)},{206},{"ACAS"},{"Chry_1"},1,1,nil,{0,0})
				TriggerX(FP,{CDeaths(FP,AtLeast,512,BT2)},{SetCDeaths(FP,SetTo,0,BT2),SetCDeaths(FP,SetTo,200,BT_0)},{Preserved})
				CIf(FP,{CDeaths(FP,AtMost,24,BT3)})
					CreateBullet(204,20,B_A1,BossXY)
					CreateBullet(204,20,_Add(B_A1,128),BossXY)
					CIf(FP,{CGMode(3)})
						CreateBullet(204,20,_Add(B_A1,64),BossXY)
						CreateBullet(204,20,_Add(B_A1,192),BossXY)
					CIfEnd()
				CIfEnd()
				TriggerX(FP,{CDeaths(FP,Exactly,0,B_AP)},{SetCVar(FP,B_A1[2],Add,1)},{Preserved})
				TriggerX(FP,{CDeaths(FP,Exactly,1,B_AP)},{SetCVar(FP,B_A1[2],Subtract,1)},{Preserved})
				TriggerX(FP,{CVar(FP,B_A1[2],AtMost,0)},{SetCDeaths(FP,SetTo,0,B_AP)},{Preserved})
				TriggerX(FP,{CVar(FP,B_A1[2],AtLeast,256)},{SetCDeaths(FP,SetTo,1,B_AP)},{Preserved})
				DoActionsX(FP,{SetCDeaths(FP,Add,1,BT3)})
				TriggerX(FP,{CDeaths(FP,AtLeast,48,BT3)},{SetCDeaths(FP,SetTo,0,BT3)},{Preserved})
			CIfEnd()
			CIf(FP,CDeaths(FP,Exactly,4,B_P),{SetCDeaths(FP,Add,1,BP4_T1)})
				local BonusText = "\n\n\n\n\n\n\n\n\n\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※\n\n\x13\x02▶ \x08! BONUS STAGE ! \x02◀\n\n\x13\x04지금부터 미지의 존재가 쓰러질때까지 마음껏 딜을 넣어주세요!\n\x13\x04미지의 존재에 대한 딜량이 점수를 결정합니다!\n\n\x13\x07※※※※※※※※※※※※\x08 N O T I C E\x07 ※※※※※※※※※※※※"

				DoActions(FP,{Order("Men",Force1,64,Attack,31)},1)
				Trigger2X(FP,{CDeaths(FP,AtLeast,300,BP4_T1)},{CopyCpAction({DisplayTextX(BonusText,4),PlayWAVX("sound\\glue\\bnetclick.wav");MinimapPing(31);},HumanPlayers,FP)})
				local C3Text = "\n\n\n\n\n\n\n\n\n\n\n\x13\x043 3 3 3 3 3 3 3 \x07C O U N T \x043 3 3 3 3 3 3 3"
				local C2Text = "\n\n\n\n\n\n\n\n\n\n\n\x13\x042 2 2 2 2 2 2 2 \x07C O U N T \x042 2 2 2 2 2 2 2"
				local C1Text = "\n\n\n\n\n\n\n\n\n\n\n\x13\x041 1 1 1 1 1 1 1 \x07C O U N T \x041 1 1 1 1 1 1 1"
				local C0Text = "\n\n\n\n\n\n\n\n\n\n\n\x13\x040 0 0 0 0 0 0 0 \x1FS T A R T \x040 0 0 0 0 0 0 0"
				Trigger2X(FP,{CDeaths(FP,AtLeast,900,BP4_T1)},{CopyCpAction({DisplayTextX(C3Text,4),PlayWAVX("sound\\glue\\countdown.wav")},HumanPlayers,FP)})
				Trigger2X(FP,{CDeaths(FP,AtLeast,930,BP4_T1)},{CopyCpAction({DisplayTextX(C2Text,4),PlayWAVX("sound\\glue\\countdown.wav")},HumanPlayers,FP)})
				Trigger2X(FP,{CDeaths(FP,AtLeast,960,BP4_T1)},{CopyCpAction({DisplayTextX(C1Text,4),PlayWAVX("sound\\glue\\countdown.wav")},HumanPlayers,FP)})
				Trigger2X(FP,{CDeaths(FP,AtLeast,990,BP4_T1)},{CopyCpAction({DisplayTextX(C0Text,4),PlayWAVX("sound\\glue\\bnetclick.wav");},HumanPlayers,FP),SetInvincibility(Disable,186,FP,64)})

			CIfEnd()

		CElseX({SetInvincibility(Enable,186,FP,64),SetCDeaths(FP,Subtract,1,BT_0)})
			CMov(FP,B_A1,0)
		CIfXEnd()
local S_N_R,N_A,N_X,N_Y = CreateVars(4)
BClearT = "\n\n\n\n\n\n\n\n\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※\n\n\n\x13\x08최후의 적 \x0FU\x04nknown\x08.2 \x04를 \x04쓰러트렸습니다.\n\n\n\x13\x08※※※※※※※※※※※※\x07 N O T I C E\x08 ※※※※※※※※※※※※"
	Trigger2X(FP,{CountdownTimer(AtMost,0),CVar(FP,FBH[2],Exactly,0)},{CopyCpAction({DisplayTextX(BClearT,4),PlayWAVX("staredit\\wav\\clear.ogg"),PlayWAVX("staredit\\wav\\clear.ogg"),PlayWAVX("staredit\\wav\\clear.ogg")},HumanPlayers,FP),SetSwitch("Switch 130",Set),SetDeaths(P12,SetTo,1,186),SetCDeaths(FP,SetTo,1,Win)},{Preserved})
		G_CA_SetSpawn({CDeaths(FP,Exactly,1,BT_Ready2),CGMode(2)},{84},{P_6},{0},"MAX",nil,nil,BossXY)
		G_CA_SetSpawn({CDeaths(FP,Exactly,1,BT_Ready2),CGMode(3)},{84},{S_8},{2},nil,nil,nil,BossXY)
	CIfEnd({SetCDeaths(FP,SetTo,0,BT_Ready2)})
	CIf(FP,Switch("Switch 130",Set))
		CWhile(FP,{CVar(FP,N_A[2],AtMost,359),CVar(FP,S_N_R[2],AtMost,2400)})
			f_lengthdir(FP,S_N_R,N_A,N_X,N_Y)
			CAdd(FP,N_X,BossXY[1])
			CAdd(FP,N_Y,BossXY[2])
			CTrigger(FP,{
				CVar(FP,N_X[2],AtMost,4096),
				CVar(FP,N_Y[2],AtMost,4096)
				},
			{
				TSetMemory(0x58DC60+20*0,SetTo,_Add(N_X,-32)),
				TSetMemory(0x58DC64+20*0,SetTo,_Add(N_Y,-32)),
				TSetMemory(0x58DC68+20*0,SetTo,_Add(N_X,32)),
				TSetMemory(0x58DC6C+20*0,SetTo,_Add(N_Y,32))
				},1)
			DoActionsX(FP,{SetMemory(0x58F528,SetTo,1),CreateUnit(1,84,1,FP),KillUnit(84,FP),SetCVar(FP,N_A[2],Add,5)})
		CWhileEnd()
		DoActionsX(FP,{SetCVar(FP,N_A[2],SetTo,0),SetCVar(FP,S_N_R[2],Add,20)})
		TriggerX(FP,{CVar(FP,S_N_R[2],AtLeast,2400)},{SetSwitch("Switch 130",Clear),SetCVar(FP,S_N_R[2],SetTo,0)},{Preserved})
	CIfEnd()
end