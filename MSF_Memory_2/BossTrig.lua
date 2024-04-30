function BossTrig()
	B1C = CreateCcodeArr(10)
	B2C = CreateCcodeArr(10)
	B2V = CreateVarArr(2,FP)
	B3C = CreateCcodeArr(10)
	B3V = CreateVarArr(7,FP)
	B4C = CreateCcodeArr(10)
	B4V = CreateVarArr(5,FP)
	B5C = CreateCcodeArr(3)
	B5V = CreateVarArr(5,FP)

	TC = CreateCcodeArr(10)
	TV = CreateVarArr(10,FP)




	




B1Mode = CreateCcode()
	CIf(FP,CV(BPtrArr[1],1,AtLeast),{AddCD(B1C[2],1)})--하템보스
		DoActionsX(FP, SetCD(B1Mode,4), 1)
		TriggerX(FP,{CD(Theorist,1,AtLeast)},{SetInvincibility(Enable, 87, P5, 64)})
		CIf(FP,CD(B1C[1],0))
		
			TriggerX(FP,{CD(B1C[2],15,AtLeast),CD(AxiomCcode[1],0)},{SetCD(TC[1],5),SetCD(B1C[2],0)},{preserved})
			TriggerX(FP,{CD(B1C[2],5,AtLeast),CD(AxiomCcode[1],1,AtLeast)},{SetCD(TC[1],10),SetCD(B1C[2],0)},{preserved})
			CWhile(FP,CD(TC[1],1,AtLeast),SubCD(TC[1],1))
				CMov(FP,TV[1],f_CRandNum(128))
				CMov(FP,TV[2],f_CRandNum(360))
				f_Lengthdir(FP,TV[1],TV[2],N_X,N_Y)
				DoActions2X(FP,{Simple_SetLoc(0,0,0,64,64),MoveLocation(1,BossUID[1],P5,64)})
				TriggerX(FP, {CD(AxiomCcode[1],1,AtLeast),CD(B1Mode,0)}, {SetMemoryB(0x669E28+116, SetTo, 0);},{preserved})
				TriggerX(FP, {CD(AxiomCcode[1],1,AtLeast),CD(B1Mode,1)}, {SetMemoryB(0x669E28+116, SetTo, 16);},{preserved})
				TriggerX(FP, {CD(AxiomCcode[1],1,AtLeast),CD(B1Mode,2)}, {SetMemoryB(0x669E28+116, SetTo, 13);},{preserved})
				TriggerX(FP, {CD(AxiomCcode[1],1,AtLeast),CD(B1Mode,3)}, {SetMemoryB(0x669E28+116, SetTo, 10);},{preserved})
				TriggerX(FP, {CD(AxiomCcode[1],1,AtLeast),CD(B1Mode,4)}, {SetMemoryB(0x669E28+116, SetTo, 12);},{preserved})
				Simple_SetLoc2X(FP,0,N_X,N_Y,N_X,N_Y,{CreateUnitWithProperties(1,94,1,P5,{energy=100}),Simple_SetLoc(0,0,0,64,64),MoveLocation(1,BossUID[1],P5,64),SetMemoryB(0x6636B8+94,SetTo,130)})
				TriggerX(FP, {CD(AxiomCcode[1],1,AtLeast)}, {SetMemoryB(0x669E28+116, SetTo, 0);},{preserved})
			CWhileEnd()
			DoActions2X(FP,{Simple_SetLoc(0,0,0,64,64),MoveLocation(1,BossUID[1],P5,64)})
			DoActions(FP,{Order(94,P5,64,Move,1),})
		CIfEnd()
		local B1PV = CreateVar(FP)
		DoActionsX(FP, {SetV(B1PV,100)})
		TriggerX(FP, {CD(AxiomCcode[1],1,AtLeast)},{SetV(B1PV,450)} ,{preserved})
		CTrigger(FP,{TBring(P5,AtLeast,B1PV,94,64)},{SetCD(B1C[1],1),SetInvincibility(Disable, 87, P5, 64)},{preserved})
		CIf(FP,CD(B1C[1],1),AddCD(B1C[3],1))
			CIf(FP,CD(B1C[3],1),{SetMemory(0x6509B0,SetTo,P5),RunAIScriptAt(JYD,64)}) --100~500
				
			CMov(FP,0x6509B0,19025+19) --CUnit 시작지점 +19 (0x4C)
			CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
				CIf(FP,DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00))
					CAdd(FP,0x6509B0,6)
					
					CIf(FP,DeathsX(CurrentPlayer,Exactly,94,0,0xFF))
						f_SaveCp()
						CMov(FP,TV[1],BackupCp,-25)
						CIfX(FP,{CD(AxiomCcode[1],0)})
						CMov(FP,TV[2],f_CRandNum(500,100))
						CMov(FP,TV[3],TV[2])
						CElseX()
						CMov(FP,TV[2],f_CRandNum(7000,450))
						CMov(FP,TV[3],24)
						CIfXEnd()
						CTrigger(FP,{CD(AxiomCcode[1],0)},{TSetDeaths(_Add(TV[1],2),SetTo,_Add(f_CRandNum(100*256),100*256),0),},{preserved})
						CDoActions(FP,{
							TSetDeaths(_Add(TV[1],13),SetTo,TV[2],0),
							TSetDeathsX(_Add(TV[1],9),SetTo,0,0,0xFF0000),
						TSetDeathsX(_Add(TV[1],18),SetTo,TV[3],0,0xFFFF)})
						f_LoadCp()
					CIfEnd()
					CSub(FP,0x6509B0,6)
				CIfEnd()
				CAdd(FP,0x6509B0,84)
			CWhileEnd()
			CAdd(FP,0x6509B0,FP)
			
			CIfEnd()
			TriggerX(FP,{CD(B1C[3],1,AtLeast)},{AddCD(B1C[3],1)},{preserved})
			TriggerX(FP,{CD(B1C[3],100)},{SetMemory(0x6509B0,SetTo,P5),RunAIScriptAt(JYD,64),SetMemoryB(0x6636B8+94,SetTo,125)},{preserved})
			TriggerX(FP,{CD(B1C[3],100,AtLeast),Bring(P5,AtMost,0,94,64)},{SetCD(B1C[1],0),SetCD(B1C[2],0),SetCD(B1C[3],0),SetCD(B1C[4],0),SetCD(B1C[5],0),SetCD(B1C[6],0),SetCD(B1C[7],0),SetCD(B1C[8],0),SetCD(B1C[9],0),SetCD(B1C[10],0),AddCD(B1Mode,1)},{preserved})
			local B1X = CreateVar(FP)
			local B1A = CreateVar(FP)
			local B1A2 = CreateVar(FP)
			CIf(FP,{CD(AxiomCcode[1],1,AtLeast)},{}) -- Axiom 전용 패턴
				CIf(FP,{CD(B1C[3],100,AtLeast)})
					f_Read(FP,_Add(BPtrArr[1],10),CPos)
					Convert_CPosXY()
					CMov(FP,DirSrchCenterX,CPosX)
					CMov(FP,DirSrchCenterY,CPosY)
					for y = 0, 4 do
					DCX,DCY = DirectionSearch({CD(B1Mode,y)}, y, 94, P5,1)
					end
					Simple_SetLocX(FP,0, DCX, DCY, DCX, DCY)
					DoActions(FP, {Simple_CalcLoc(0, -1, -1, 1, 1),ModifyUnitHitPoints(1, 94, P5, 1, 0),GiveUnits(1, 94, P5, 1, P6)})

					for i = 0, 3 do
						CIf(FP,{Bring(P5, AtLeast, 100+(100*i), 94, 64)})
						for y = 0, 4 do
						DCX,DCY = DirectionSearch({CD(B1Mode,y)}, y, 94, P5,1)
						end
						Simple_SetLocX(FP,0, DCX, DCY, DCX, DCY)
						DoActions(FP, {Simple_CalcLoc(0, -1, -1, 1, 1),ModifyUnitHitPoints(1, 94, P5, 1, 0),GiveUnits(1, 94, P5, 1, P6)})
						CIfEnd()
					end
				CIfEnd()
			CIfEnd()
			TriggerX(FP,{CD(B1C[3],500,AtLeast)},{KillUnit(94,P5),SetCD(B1C[1],0),SetCD(B1C[2],0),SetCD(B1C[3],0),SetCD(B1C[4],0),SetCD(B1C[5],0),SetCD(B1C[6],0),SetCD(B1C[7],0),SetCD(B1C[8],0),SetCD(B1C[9],0),SetCD(B1C[10],0),AddCD(B1Mode,1)},{preserved})
			CIfEnd()



			CIf(FP,{CD(AxiomCcode[1],1,AtLeast)},{SubV(B1X,1),RemoveUnitAt(All, 88, 53, P11),SetBulletSpeed(400)}) -- Axiom 전용 패턴
			TriggerX(FP, {CV(B1X,0)}, {KillUnit(88, P11)}, {preserved})
			CIf(FP,{TMemoryX(_Add(BPtrArr[1],19),Exactly,10*256,0xFF00),TMemory(_Add(BPtrArr[1],23),AtLeast,1),CV(B1X,0)},{SetV(B1X,100)})--공격중인 상태이며 대상이 있을경우
			CMov(FP,B1A,_rShift(_ReadF(_Add(BPtrArr[1],8)), 8),nil,0xFF,1)
			CMov(FP,B1A2,_ReadF(_Add(BPtrArr[1],8)),nil,0xFF00FF00,1)
			CFor(FP, 0, 10, 1)
			CI = CForVariable()
			
			CIf(FP,{Memory(0x628438,AtLeast,1)})
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			f_Read(FP,_Add(BPtrArr[1],10),CPos)
			CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
			Convert_CPosXY()
			Simple_SetLocX(FP,0, CPosX, CPosY, CPosX, CPosY)
				CDoActions(FP, {CreateUnit(1, 88, 1, FP),
				TSetMemoryX(_Add(Nextptrs,55),SetTo,0xA00000,0xA00000),
				TSetMemoryX(_Add(Nextptrs,8), SetTo, B1A2,0xFF00FF00),
				TSetMemoryX(_Add(Nextptrs,8), SetTo, 0,0xFF0000),
				TSetDeaths(_Add(Nextptrs,13),SetTo,_Add(_Mul(CI,100),100),0),
				TSetDeathsX(_Add(Nextptrs,18),SetTo,_Add(_Mul(CI,100),100),0,0xFFFF),
				--TSetDeathsX(_Add(Nextptrs,18),SetTo,_lShift(_Add(B1A,_lShift(B1A, 8)), 16),0,0xFFFF0000),
				Set_EXCC2(DUnitCalc,CunitIndex,16,SetTo,B1A),
			})
			f_CGive(FP, Nextptrs, nil, P11, FP)
			DoActions(FP, {Order(88, P11, 64, Move, 53)})

			CIfEnd()
				
			CForEnd()

			CIfEnd()
			CIfEnd()
		


		TriggerX(FP, {CD(B1Mode,5,AtLeast)}, {SetCD(B1Mode,0)},{preserved})
		CTrigger(FP,{TMemoryX(_Add(BPtrArr[1],19),Exactly,0,0xFF00)},{SetV(BPtrArr[1],0),KillUnit(94,Force2),SetDeaths(4,SetTo,1,BossUID[1])},1)
	CIfEnd()


	CIf(FP,CV(BPtrArr[2],1,AtLeast))--닼템보스
		CIf(FP,{CD(AxiomCcode[2],1,AtLeast)},{AddCD(B2C[2],1),AddCD(B2C[3],1)}) -- Axiom 전용 패턴
			TriggerX(FP,{CD(B2C[2],500,AtLeast)},{SetMemory(0x657A9C,Add,1),SetCD(B2C[2],0)},{preserved}) -- 일정시간 지난경우 밝기 회복
			TriggerX(FP,{Memory(0x657A9C,AtLeast,32)},{SetMemory(0x657A9C,SetTo,31)},{preserved})
			DSkillRetX,DSkillRetY = CreateVars(2, FP)
			CIf(FP,{CV(DSkillX,1,AtLeast),CV(DSkillY,1,AtLeast),CD(B2C[3],240,AtLeast)},{})
			CMov(FP,DSkillRetX,DSkillX)
			CMov(FP,DSkillRetY,DSkillY)
			CIf(FP,{TTOR({CD(B2C[3],240),CD(B2C[3],280)})})
			CFor(FP,45,45+360,90)
				CIA = CForVariable()
				CFor(FP, 16, 16*12, 16)
				CIR = CForVariable()
					f_Lengthdir(FP, CIR, CIA, CPosX, CPosY)
					Simple_SetLocX(FP, 0, _Add(DSkillRetX,CPosX), _Add(DSkillRetY,CPosY), _Add(DSkillRetX,CPosX), _Add(DSkillRetY,CPosY))
					TriggerX(FP, {CD(B2C[3],240)}, {CreateUnitWithProperties(1,84,1,P6,{hallucinated=true}),KillUnit(84, P6)}, {preserved}) -- 예고선
					TriggerX(FP, {CD(B2C[3],280)}, {Simple_SetLoc(0, -16, -16, 16, 16),SetMemoryB(0x6644F8+84, SetTo, 15),CreateUnitWithProperties(1,84,1,P6,{hallucinated=false}),KillUnit(84, P6),KillUnitAt(All, "Men", 1, Force1),SetMemoryB(0x6644F8+84, SetTo, 50)}, {preserved}) -- 즉사기

				CForEnd()
			CForEnd()
			CIfEnd()
			
			TriggerX(FP,{CD(B2C[3],281,AtLeast)},{SetCD(B2C[3],0)},{preserved}) --


			CIfEnd()
		CIfEnd()
		
		
		DoActions2(FP,{Simple_SetLoc(0,0,0,64,64),Simple_SetLoc(9,0,0,64,64),MoveLocation(1,BossUID[2],P6,64),MoveLocation(10,BossUID[2],P6,64),Order(49,P6,64,Move,1)})
		CTrigger(FP,{CD(Theorist,1,AtLeast),TMemory(_Add(BPtrArr[2],2),AtMost,8320000*256)},{TSetMemory(_Add(BPtrArr[2],2),Add,2500*256),},{preserved})
		CIf(FP,{Bring(P6,AtLeast,1,49,1)},{AddV(B2V[1],1),KillUnitAt(1,49,1,P6)})
			GetLocCenter(9,CPosX,CPosY)
			TriggerX(FP,{CD(Theorist,0)},{SetCD(B2C[1],100)},{preserved})
			f_TempRepeatX(CD(Theorist,1,AtLeast), 61, B2V[1], 192, P6, {CPosX,CPosY})
			CTrigger(FP,{CD(Theorist,0),TMemory(_Add(BPtrArr[2],2),AtLeast,7320000*256)},{TSetMemory(_Add(BPtrArr[2],2),SetTo,8320000*256),},{preserved})
			CTrigger(FP,{CD(Theorist,0),TMemory(_Add(BPtrArr[2],2),AtMost,7319999*256)},{TSetMemory(_Add(BPtrArr[2],2),Add,1000000*256),},{preserved})
			CTrigger(FP,{CD(Theorist,1,AtLeast),TMemory(_Add(BPtrArr[2],2),AtMost,8320000*256)},{TSetMemory(_Add(BPtrArr[2],2),SetTo,8320000*256),},{preserved})
			DoActions2(FP,{RotatePlayer({PlayWAVX("staredit\\wav\\Gun_Penalty.ogg"),PlayWAVX("staredit\\wav\\Gun_Penalty.ogg"),PlayWAVX("staredit\\wav\\Gun_Penalty.ogg")},HumanPlayers,FP)})
		CIfEnd()
		TriggerX(FP,{CD(B2C[1],1,AtLeast)},{KillUnit(49,P6)},{preserved})
		DoActionsX(FP,SubCD(B2C[1],1))
		

		CTrigger(FP,{TMemoryX(_Add(BPtrArr[2],19),Exactly,0,0xFF00)},{SetV(BPtrArr[2],0),KillUnit(61, P6),SetDeaths(5,SetTo,1,BossUID[2]),ModifyUnitEnergy(All, 88, P11, 64, 0),KillUnit(88, P11),SetMemory(0x657A9C,SetTo,31)},1)
	CIfEnd()




	CIf(FP,CV(BPtrArr[3],1,AtLeast),{SetMemoryX(0x665E44, SetTo, 0,0xFF000000);SetBulletSpeed(250),AddCD(B3C[3],1)})--탱크보스
	TriggerX(FP,{},{
		SetCD(B3C[1],0),
		SetCD(B3C[2],0),
		SetCD(B3C[6],0),
		SetCD(B3C[7],0),
		SetCD(B3C[8],0),
		SetCD(B3C[9],0),
		SetCD(B3C[10],0),
		SetV(B3V[1],0),
		SetV(B3V[2],0),
		SetV(B3V[3],0),
		SetV(B3V[4],0),
		SetV(B3V[5],0),
	})
		f_Read(FP,_Add(BPtrArr[3],10),CPos)
		Convert_CPosXY()
		CIf(FP,{CD(Theorist,1,AtLeast),CD(B3C[3],25,AtLeast)},{SetCD(B3C[3],0)})
		CreateBullet(206,20,f_CRandNum(256),{CPosX,CPosY},P7)
		--CAdd(FP,B3V[6],8)
		CIfEnd()
		TriggerX(FP,CD(B3C[1],0),{SetCD(B3C[1],1),SetV(B3V[1],0),SetV(B3V[2],0)},{preserved})
		CIf(FP,CD(B3C[1],1))
			CMov(FP,B3V[2],0)
			CWhile(FP,{CVar(FP,B3V[2][2],AtMost,359)})
			CSub(FP,B3V[3],_Mov(512),B3V[1])
			TempRand = f_CRandNum(360)
			f_Lengthdir(FP,B3V[3],_Add(B3V[2],TempRand),N_X,N_Y)
			CAdd(FP,N_X,CPosX)
			CAdd(FP,N_Y,CPosY)
			Simple_SetLocX(FP,0,N_X,N_Y,N_X,N_Y)
			if Limit == 1 then
				DisplayPrint(HumanPlayers, {"B3V[1] : ",B3V[1]})
			end
			CreateEffUnit({CV(N_X,4095,AtMost),CV(N_Y,4095,AtMost)},20,548,17)
			CAdd(FP,B3V[2],12)
			CWhileEnd()
			CAdd(FP,B3V[1],12)
		CIfEnd()
		TriggerX(FP,{CD(B3C[1],1),CV(B3V[1],512,AtLeast)},{SetCD(B3C[1],2),SetV(B3V[4],0),SetV(B3V[5],0)},{preserved})
		

		CIf(FP,CD(B3C[1],2,AtLeast),{AddCD(B3C[1],1)})
		
		CIf(FP,CD(B3C[1],3))
			CMov(FP,B3V[5],f_CRandNum(60))
		CIfEnd()
		DoActionsX(FP,{AddCD(B3C[2],1)})
		CIf(FP,CV(B3V[4],512,AtMost))
			CMov(FP,B3V[2],0)
			CWhile(FP,{CVar(FP,B3V[2][2],AtMost,359)})
			TempRand = f_CRandNum(15)
			f_Lengthdir(FP,B3V[4],_Add(B3V[2],_Add(B3V[5],TempRand)),N_X,N_Y)
			CAdd(FP,N_X,CPosX)
			CAdd(FP,N_Y,CPosY)
			Simple_SetLocX(FP,0,N_X,N_Y,N_X,N_Y)
			CreateEffUnit({CV(N_X,4095,AtMost),CV(N_Y,4095,AtMost)},20,548,17)
			CIf(FP,CD(B3C[2],5,AtLeast))
			if Limit == 1 then
				DisplayPrint(HumanPlayers, {"B3V[4] : ",B3V[4]})
			end
			CreateBulletLoc(205,20,f_CRandNum(256),P7)
			CIfEnd()
			CAdd(FP,B3V[2],60)
			CWhileEnd()
			CAdd(FP,B3V[4],12)
		CIfEnd()
		TriggerX(FP,{CD(B3C[2],5,AtLeast)},{SetCD(B3C[2],0)},{preserved})

		CIfEnd()

		TriggerX(FP,{CV(B3V[4],512,AtLeast)},{
			SetCD(B3C[1],0),
			SetCD(B3C[2],0),
			SetCD(B3C[6],0),
			SetCD(B3C[7],0),
			SetCD(B3C[8],0),
			SetCD(B3C[9],0),
			SetCD(B3C[10],0),
			SetV(B3V[1],0),
			SetV(B3V[2],0),
			SetV(B3V[3],0),
			SetV(B3V[4],0),
			SetV(B3V[5],0),
		},{preserved})
		CTrigger(FP,{TMemoryX(_Add(BPtrArr[3],19),Exactly,0,0xFF00)},{SetV(BPtrArr[3],0),SetDeaths(6,SetTo,1,BossUID[3])},1)
	CIfEnd()




	CIf(FP,CV(BPtrArr[4],1,AtLeast))--벌쳐보스
		f_Read(FP,_Add(BPtrArr[4],10),CPos)
		Convert_CPosXY()
		DoActions2(FP,{Simple_SetLoc(0,0,0,64,64),MoveLocation(1,BossUID[4],P8,64)})
		CIf(FP,{CD(B4C[2],0),Bring(P9,AtMost,0,191,64)},{SetCD(B4C[1],1),CreateUnitWithProperties(1,191,1,P8,{energy=100}),GiveUnits(1,191,P8,64,P9)})
			CMov(FP,TV[1],f_CRandNum(360))
			CMov(FP,TV[2],f_CRandNum(256))
			f_Lengthdir(FP,TV[2],TV[1],N_X,N_Y)
			CAdd(FP,N_X,CPosX)
			CAdd(FP,N_Y,CPosY)
			CMov(FP,B4V[1],N_X)
			CMov(FP,B4V[2],N_Y)
		CIfEnd()
		CIf(FP,Bring(P9,AtLeast,1,191,64))
			Simple_SetLocX(FP,9,B4V[1],B4V[2],B4V[1],B4V[2],{Simple_CalcLoc(9,-8,-8,8,8),KillUnitAt(All, nilunit, 10, FP),CreateUnitWithProperties(1,84,10,P8,{hallucinated=true}),KillUnit(84,P8),Order(191,P9,64,Move,10)})
		CIfEnd()
		DoActions2(FP,{Simple_SetLoc(0,0,0,64,64),MoveLocation(1,BossUID[4],P8,64)})
		CIf(FP,Bring(P9,AtLeast,1,191,10),{KillUnit(191,P9),SetCD(B4C[2],1)})
			CMov(FP,G_CA_CenterX,B4V[1])
			CMov(FP,G_CA_CenterY,B4V[2])
			G_CA_SetSpawn({},{128},"ACAS","Warp1",nil,3,nil,P8,nil,6+12+18)
		CIfEnd()
		TriggerX(FP,{CD(B4C[2],1,AtLeast)},{AddCD(B4C[2],1)},{preserved})
		TriggerX(FP,{CD(Theorist,0),CD(B4C[2],200,AtLeast)},{SetCD(B4C[1],0),SetCD(B4C[2],0)},{preserved})
		TriggerX(FP,{CD(Theorist,1,AtLeast),CD(B4C[2],100,AtLeast)},{SetCD(B4C[1],0),SetCD(B4C[2],0),ModifyUnitHitPoints(All, 128, P8, 64, 0)},{preserved})
		CTrigger(FP,{TMemoryX(_Add(BPtrArr[4],19),Exactly,0,0xFF00)},{SetV(BPtrArr[4],0),KillUnit(191,P9),SetDeaths(7,SetTo,1,BossUID[4])},1)
	CIfEnd()

	CIf(FP,{CV(BPtrArr[5],1,AtLeast),CD(BStart,1)},{SetMemoryB(0x6636B8+64,SetTo,62),SetInvincibility(Disable,64,Force2,64)})--프로브보스
	CDoActions(FP,{
		TSetMemory(_Add(BPtrArr[5],13),SetTo,640)
	})

	CTrigger(FP,{TMemoryX(_Add(BPtrArr[5],19),Exactly,0,0xFF00)},{SetV(BPtrArr[5],0),SetCD(ED2Clear,1)},1)
	CIfEnd()
	function InvDisable2(UnitID,Owner,Condition)
		Trigger2X(FP,Condition,{
			Simple_SetLoc(0,0,0,32,32);
			MoveLocation(1,UnitID,Owner,64);
			SetInvincibility(Disable,UnitID,Owner,1);
		},{preserved})
	end
	for i = 4, 7 do
	InvDisable2(189,i,{
		CD(AxiomCcode[i-3],0),
		CV(BPtrArr[1],0,AtMost),
		CV(BPtrArr[2],0,AtMost),
		CV(BPtrArr[3],0,AtMost),
		CV(BPtrArr[4],0,AtMost),
		CD(WarpCheck,0),
		CD(HactCcode[i-3],0,AtMost),CD(LairCcode[i-3],0,AtMost),CD(HiveCcode[i-3],0,AtMost),CD(CenCcode2[i-3],1,AtLeast)})
	InvDisable2(189,i,{ -- axiom 활성화시에는 브금꺼져야 부술수있음
		CD(AxiomCcode[i-3],1),
		DeathsX(0,Exactly,0,12,0xFFFFFF),
		DeathsX(1,Exactly,0,12,0xFFFFFF),
		DeathsX(2,Exactly,0,12,0xFFFFFF),
		DeathsX(3,Exactly,0,12,0xFFFFFF),
		DeathsX(FP,AtMost,0,12,0xFFFFFF),
		CV(BPtrArr[1],0,AtMost),
		CV(BPtrArr[2],0,AtMost),
		CV(BPtrArr[3],0,AtMost),
		CV(BPtrArr[4],0,AtMost),
		CD(WarpCheck,0),
		CD(HactCcode[i-3],0,AtMost),CD(LairCcode[i-3],0,AtMost),CD(HiveCcode[i-3],0,AtMost),CD(CenCcode2[i-3],1,AtLeast)})
	end
	DoActionsX(FP,{SetCD(WarpCheck,0)})
	--
end