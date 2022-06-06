
function Install_CallTriggers()
	local InverseOptionX = CreateCcode()
	local InverseOptionY = CreateCcode()
	f_Replace = SetCallForward()
	SetCall(FP)
		CIfX(FP,Memory(0x628438,AtLeast,1)) -- 캔낫체크.
		f_SaveCp()
		CMov(FP,Gun_LV,0)
		f_Read(FP,BackupCp,CPos)
		Convert_CPosXY()
		f_Read(FP,_Add(BackupCp,1),Gun_LV,"X",0xFF000000)
		f_Read(FP,_Add(BackupCp,1),RepHeroIndex,"X",0xFF)
		f_Div(FP,Gun_LV,_Mov(0x1000000)) -- 1
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		CDoActions(FP,{
			TSetMemoryX(_Add(Nextptrs,9),SetTo,1*65536,0xFF0000),
			SetCDeaths(FP,SetTo,0,InverseOptionX),
			SetCDeaths(FP,SetTo,0,InverseOptionY),
		})
		TriggerX(FP,{CDeaths(FP,Exactly,0,CurPlace)},{SetCDeaths(FP,SetTo,0,InverseOptionX),SetCDeaths(FP,SetTo,0,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,4)},{preserved})
		TriggerX(FP,{CDeaths(FP,Exactly,1,CurPlace)},{SetCDeaths(FP,SetTo,1,InverseOptionX),SetCDeaths(FP,SetTo,0,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,5)},{preserved})
		TriggerX(FP,{CDeaths(FP,Exactly,2,CurPlace)},{SetCDeaths(FP,SetTo,0,InverseOptionX),SetCDeaths(FP,SetTo,1,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,6)},{preserved})
		TriggerX(FP,{CDeaths(FP,Exactly,3,CurPlace)},{SetCDeaths(FP,SetTo,1,InverseOptionX),SetCDeaths(FP,SetTo,1,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,7)},{preserved})
		CIf(FP,CDeaths(FP,Exactly,1,InverseOptionX))
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,4096)
		CIfEnd()
		CIf(FP,CDeaths(FP,Exactly,1,InverseOptionY))
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,4096)
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,41)},{SetCVar(FP,CPosY[2],Add,64)},{preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,149)},{SetCVar(FP,CPosY[2],Add,64)},{preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,176)},{SetCVar(FP,CPosY[2],Add,64)},{preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,177)},{SetCVar(FP,CPosY[2],Add,64)},{preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,178)},{SetCVar(FP,CPosY[2],Add,64)},{preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,127)},{SetCVar(FP,CPosY[2],Add,64)},{preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,151)},{SetCVar(FP,CPosY[2],Add,-32)},{preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,147)},{SetCVar(FP,CPosY[2],Add,-32)},{preserved})
		CIfEnd()
		CIf(FP,CV(RepHeroIndex,148))
		for i = 4, 7 do
			CTrigger(FP,{CV(CunitP,i)},{SetV(OvArrX[i-3],CPosX)},1)
			CTrigger(FP,{CV(CunitP,i)},{SetV(OvArrY[i-3],CPosY)},1)
		end
		CIfEnd()


		CIf(FP,CV(RepHeroIndex,154))
		for i = 4, 7 do
			CTrigger(FP,{CV(CunitP,i)},{SetV(NexArrX[i-3],CPosX)},1)
			CTrigger(FP,{CV(CunitP,i)},{SetV(NexArrY[i-3],CPosY)},1)
		end
		CIfEnd()


		for i = 0, 3 do
			TriggerX(FP,{CV(CunitP,i+4),CV(RepHeroIndex,131)},{AddCD(HactCcode[i+1],1)},{preserved})
			TriggerX(FP,{CV(CunitP,i+4),CV(RepHeroIndex,132)},{AddCD(LairCcode[i+1],1)},{preserved})
			TriggerX(FP,{CV(CunitP,i+4),CV(RepHeroIndex,133)},{AddCD(HiveCcode[i+1],1)},{preserved})
		end

		CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
		CDoActions(FP,{
		TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
		TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
		TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
		TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
		})
		CDoActions(FP,{
			Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1),
			Set_EXCC2(DUnitCalc,CunitIndex,0,SetTo,Gun_LV),
			TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100}),
			TSetMemoryX(_Add(Nextptrs,35),SetTo,CunitP,0xFF),
		})
		CTrigger(FP,{TMemoryX(_Add(BackupCp,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
		CTrigger(FP,{TMemoryX(_Add(BackupCp,1),Exactly,0x20000,0x20000)},{Set_EXCC2X(DUnitCalc,CunitIndex,13,SetTo,0x1,0x1),AddV(EEggV,1)},1) -- 할루시플래그 1일경우 DUnitCalc[14]=1(BitMask)
		f_LoadCp()
		CElseX()
		DoActions2(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		CIfXEnd()
	SetCallEnd()

	
	local BCPos = CreateVar(FP)
	local CPlayer = CreateVar(FP)
	
	MakeEisEgg = SetCallForward()
	SetCall(FP)
	f_SaveCp()
	CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,_Sub(BackupCp,15),BCPos)
		CMov(FP,CPlayer,_Read(_Sub(BackupCp,6)),nil,0xFF)
		Convert_CPosXY(BCPos)
		Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
			f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
			CSub(FP,CurCunitI,Nextptrs,19025)
			f_Div(FP,CurCunitI,_Mov(84))
			TriggerX(FP,{CV(CPlayer,11)},{SetV(CPlayer,4)})
			TriggerX(FP,{CV(CPlayer,11)},{SetV(CPlayer,5)})
			TriggerX(FP,{CV(CPlayer,11)},{SetV(CPlayer,6)})
			TriggerX(FP,{CV(CPlayer,11)},{SetV(CPlayer,7)})
			CDoActions(FP,{SetMemory(0x66EC48+(936*4),SetTo,165),TCreateUnitWithProperties(1,184,1,CPlayer,{energy = 100,invincible = true}),SetMemory(0x66EC48+(936*4),SetTo,409)})
		
		CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)},{TSetMemoryX(_Add(Nextptrs,9),SetTo,0,0xFF0000)})
			f_Read(FP,_Sub(BackupCp,15),CPos)
			CiSub(FP,CPos,256+(65536*256))
			CAdd(FP,CPos,f_CRandNum(512,0))
			CAdd(FP,CPos,_Mul(f_CRandNum(512,0),65536))
			CDoActions(FP,{Set_EXCC2(UnivCunit,CurCunitI,0,SetTo,CPos)})
		CIfEnd()
	CIfEnd()
	f_LoadCp()
	SetCallEnd()


	SendEff = CreateVarArr(3,FP)
	SendEff2 = CreateVarArr(2,FP)
	RecoverEff1 = CreateVar(FP)
	RecoverEff2 = CreateVar(FP)
	Call_EffUnit = SetCallForward()
	SetCall(FP)
	CIf(FP,Memory(0x628438,AtLeast,1))
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	
	f_Read(FP,SendEff[1],RecoverEff1)
	f_Read(FP,SendEff2[1],RecoverEff2)
	CDoActions(FP,{
		TSetMemory(SendEff2[1],SetTo,131);
		TSetMemoryX(SendEff[1],SetTo,SendEff[2],SendEff[3]);
		TCreateUnit(1,204,"Location 1",CurrentOP);
		TSetMemoryX(SendEff[1],SetTo,RecoverEff1,SendEff[3]);
		TSetMemory(SendEff2[1],SetTo,RecoverEff2);
		TSetMemoryX(_Add(Nextptrs,55),SetTo,0x104,0x104);
		TSetMemoryX(_Add(Nextptrs,57),SetTo,0,0xFF);
	})
	CIfEnd()
	SetCallEnd()

	function CheckCP()
			
		if Limit == 1 then
			CallTrigger(FP,CallCheckCP)
		end
	end
	if Limit == 1 then
	CurCP = CreateVar(FP)
	ReadCP = CreateVar(FP)
	CurCPVA = CreateVArr(4,FP)
	ReadCPVA = CreateVArr(4,FP)
	CurCPStrPtr = CreateVar(FP)
	ReadCPStrPtr = CreateVar(FP)

	CallCheckCP = SetCallForward()
	SetCall(FP)
	f_SaveCp()

	f_Read(FP,BackupCp,ReadCp)
	CMov(FP,CurCP,BackupCp,-19025)
	f_Mod(FP,CurCP,84)
	ItoDec(FP,CurCP,VArr(CurCPVA,0),2,nil,0)
	ItoDec(FP,ReadCP,VArr(ReadCPVA,0),2,nil,0)
	f_Movcpy(FP,_Add(CurCPStrPtr,GetStrSize(0,"\x0d\x0d\x0dCurCPStrPtr : ")),VArr(CurCPVA,0),4*4)
	f_Movcpy(FP,_Add(ReadCPStrPtr,GetStrSize(0,"\x0d\x0d\x0dReadCPStrPtr : ")),VArr(ReadCPVA,0),4*4)
	Trigger2X(FP,{},{RotatePlayer({DisplayTextX("\x0d\x0d\x0dCurCPStrPtr : ".._0D,4)},HumanPlayers,FP);},{preserved})
	Trigger2X(FP,{},{RotatePlayer({DisplayTextX("\x0d\x0d\x0dReadCPStrPtr : ".._0D,4)},HumanPlayers,FP);},{preserved})
	f_LoadCp()
	SetCallEnd()
	end


	CallCXPlot = SetCallForward()
	SetCall(FP)
	DoActionsX(FP,{SetCVar("X",TCount,SetTo,1)})
	
	CMov(FP,V(Arrptr),1)
	CMov(FP,V(CArrptr),1)
	CallCXPlotEff = FuncAlloc
	FuncAlloc = FuncAlloc+2
	function CXfunc()
	local CA = CAPlotDataArr
	local CB = CAPlotCreateArr
	local PlayerID = CAPlotPlayerID
	CX_Ratio(V(TSize),540*3*12,V(TSize),540*3*12, V(TSize),540*3*12)
	CX_Rotate(_Div(V(XAngle),10),_Div(V(YAngle),10),_Div(V(ZAngle),10))
	CIfX(FP,CVar("X",CA[6],Exactly,1))
	CMov(FP,Arr(CXArrX,0),_Add(V(CA[8]), V(CA[8])))
	CMov(FP,Arr(CXArrY,0),_Add(V(CA[9]), V(CA[9])))
	CMov(FP,Arr(CXArrZ,0),_Add(V(CA[11]),V(CA[11])))
	CElseX()
	local Sym = {{1,4},{2,3},{5,8},{6,7},{9,12},{10,11}}
	for i = 2, TNumber do
	Trigger {
	players = {FP},
	conditions = {
	Label(0);
	CVar("X",CA[6],Exactly,i);
	},
	actions = {
	SetCVar("X",CArrptr,SetTo,Sym[i-1][1]);
	PreserveTrigger();
	}
	}
	end
	CMovX(FP,Arr(CXArrX,V(CArrptr)),V(CA[8]))
	CMovX(FP,Arr(CXArrY,V(CArrptr)),V(CA[9]))
	CMovX(FP,Arr(CXArrZ,V(CArrptr)),V(CA[11]))
	for i = 2, TNumber do
	Trigger {
	players = {FP},
	conditions = {
	Label(0);
	CVar("X",CA[6],Exactly,i);
	},
	actions = {
	SetCVar("X",CArrptr,SetTo,Sym[i-1][2]);
	PreserveTrigger();
	}
	}
	end
	CMovX(FP,Arr(CXArrX,V(CArrptr)),_iSub(_Read(Arr(CXArrX ,0)),V(CA[8])))
	CMovX(FP,Arr(CXArrY,V(CArrptr)),_iSub(_Read(Arr(CXArrY ,0)),V(CA[9])))
	CMovX(FP,Arr(CXArrZ,V(CArrptr)),_iSub(_Read(Arr(CXArrZ ,0)),V(CA[11])))
	CIfXEnd()
	CJump(FP,0x1)
	DoActionsXI(FP,CallCXPlotEff)
	local AddNum1 = 15
	local Ratio1 = 1
	local Total1 = AddNum1 * Ratio1
	CWhile(FP,{CVar("X",CA[6],Exactly,TShape[1]+1),CVar("X", Arrptr, AtMost, AddNum1*Ratio1)})
	local AddArr = {{2,1},{2,9},{2,7},{2,8},{2,11},{1,9},{1,5},{1,6},{9,7},{9,5},{9,10},{7,8},{7,10},{8,11}, {11,1}}
	local AddRatio = {{1,1}}
	for i = 1, AddNum1 do
	for j = 1, Ratio1 do
	Trigger {
	players = {FP},
	conditions = {
	Label(0);
	CVar("X",Arrptr,Exactly,Ratio1*(i-1)+j);
	},
	actions = {
	SetCVar("X",Arrptr1,SetTo,AddArr[i][1]);
	SetCVar("X",Arrptr2,SetTo,AddArr[i][2]);
	SetCVar("X",Var1,SetTo,AddRatio[j][1]);
	SetCVar("X",Var2,SetTo,AddRatio[j][2]);
	PreserveTrigger();
	}
	}
	end
	end
	CMov(FP,V(CA[8]),_Read(Arr(CXArrX,V(Arrptr1)))) -- X << ArrX[Arrptr]
	CMov(FP,V(CA[9]),_Read(Arr(CXArrY,V(Arrptr1)))) 
	CMov(FP,V(CA[11]),_Read(Arr(CXArrZ, V(Arrptr1)))) 
	CMov(FP,V(CA[12]),_Read(Arr(CXArrX, V(Arrptr2)))) -- X << ArrX[Arrptr]
	CMov(FP,V(CA[13]),_Read(Arr(CXArrY, V(Arrptr2)))) 
	CMov(FP,V(CA[14]),_Read(Arr(CXArrZ, V(Arrptr2)))) 
	CIfX(FP,{CVar("X",Var1,Exactly,AddRatio[1][1]),CVar("X",Var2,Exactly,AddRatio[1][2])})
	CMov(FP,V(CA[8]),_iDiv(_Add(V(CA[8]), V(CA[12])),2))
	CMov(FP,V(CA[9]),_iDiv(_Add(V(CA[9]), V(CA[13])),2))
	CMov(FP,V(CA[11]),_iDiv(_Add(V(CA[11]),V(CA [14])),2))
	CMov(FP,V(CA[12]),_iSub( _Read(Arr(CXArrX,0)),V(CA[8])))
	CMov(FP,V(CA[13]),_iSub( _Read(Arr(CXArrY,0)),V(CA[9])))
	CMov(FP,V(CA[14]),_iSub( _Read(Arr(CXArrZ,0)),V(CA[11])))
	CIfXEnd()
	Simple_SetLocX(FP,"Location 1",_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),Simple_CalcLoc(0,-32,-32,32,32))


	CIf(FP,CD(CXEffType,0))
	CreateEffUnit({CVar("X",CA[11],AtLeast,0x80000000);CVar("X",CA[11],AtMost,0xFFFFFFFF-128)},0,982,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,0xFFFFFFFF-127)},0,983,10)
	--CreateEffUnit({CVar("X",CA[11],AtMost,127);},18,983,17)
	CreateEffUnit({CVar("X",CA[11],AtMost,49);},20,983,10)
	CreateEffUnit({CVar("X",CA[11],AtMost,49);},19,983,6)
	CreateEffUnit({CVar("X",CA[11],AtMost,49);},18,983,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,50),CVar("X",CA[11],AtMost,99);},20,983,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,50),CVar("X",CA[11],AtMost,99);},19,983,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,50),CVar("X",CA[11],AtMost,99);},17,983,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,100),CVar("X",CA[11],AtMost,149);},20,984,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,100),CVar("X",CA[11],AtMost,149);},19,984,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,100),CVar("X",CA[11],AtMost,149);},18,984,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,150);CVar("X",CA[11],AtMost,0x7FFFFFFF);},18,984,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,150);CVar("X",CA[11],AtMost,0x7FFFFFFF);},19,984,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,150);CVar("X",CA[11],AtMost,0x7FFFFFFF);},20,984,17)
	CIfEnd()
	--	Tier1 = {17,19,77,78,76,63,21,88,28,86,75,25}
	--	Tier2 = {79,80,52,10,22,65,70}
	--	Tier3 = {27,66,29,98,57,3,8,11,69}
	--	Tier4 = {102,61,67,23,81,30}
	--	Tier5 = {60,68}
	--G_CA_Player
	function CreateOrder(Number,UnitID,Player,Start,OrderType,Dest)
		return {CreateUnit(Number,UnitID,Start,Player),Order(UnitID,Player,Start,OrderType,Dest)}
	end
	TriggerX(FP,{},{SetMemory(0x6CA010, SetTo, 640*3);},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXGeneFlag,1),CD(Theorist,1)},{KillUnitAt(All, "Men", 1, Force1)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,1)},{CreateOrder(3,11,6,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,1)},{CreateOrder(3,29,6,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,2)},{CreateOrder(3,8,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,2)},{CreateOrder(3,22,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,3)},{CreateOrder(3,88,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,3)},{CreateOrder(3,21,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,4)},{CreateOrder(3,27,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,4)},{CreateOrder(3,57,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,5)},{CreateOrder(3,69,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,5)},{CreateOrder(3,11,7,1,Attack,64)},{preserved})

	------ 원점 대칭 -------------------------------------------------------------
	CMov(FP,V(CA[8]),V(CA[12]))
	CMov(FP,V(CA[9]),V(CA[13]))
	CMov(FP,V(CA[11]),V(CA[14]))
	Simple_SetLocX(FP,"Location 1",_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),Simple_CalcLoc(0,-32,-32,32,32))


	CIf(FP,CD(CXEffType,0))
	CreateEffUnit({CVar("X",CA[11],AtLeast,0x80000000);CVar("X",CA[11],AtMost,0xFFFFFFFF-128)},0,982,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,0xFFFFFFFF-127)},0,983,10)
	--CreateEffUnit({CVar("X",CA[11],AtMost,127);},18,983,17)
	CreateEffUnit({CVar("X",CA[11],AtMost,49);},20,983,10)
	CreateEffUnit({CVar("X",CA[11],AtMost,49);},19,983,6)
	CreateEffUnit({CVar("X",CA[11],AtMost,49);},18,983,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,50),CVar("X",CA[11],AtMost,99);},20,983,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,50),CVar("X",CA[11],AtMost,99);},19,983,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,50),CVar("X",CA[11],AtMost,99);},17,983,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,100),CVar("X",CA[11],AtMost,149);},20,984,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,100),CVar("X",CA[11],AtMost,149);},19,984,6)
	CreateEffUnit({CVar("X",CA[11],AtLeast,100),CVar("X",CA[11],AtMost,149);},18,984,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,150);CVar("X",CA[11],AtMost,0x7FFFFFFF);},18,984,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,150);CVar("X",CA[11],AtMost,0x7FFFFFFF);},19,984,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,150);CVar("X",CA[11],AtMost,0x7FFFFFFF);},20,984,17)
	CIfEnd()
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXGeneFlag,1),CD(Theorist,1)},{KillUnitAt(All, "Men", 1, Force1)},{preserved})

	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,1)},{CreateOrder(3,98,6,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,1)},{CreateOrder(3,86,6,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,2)},{CreateOrder(3,70,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,2)},{CreateOrder(3,69,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,3)},{CreateOrder(3,86,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,3)},{CreateOrder(3,28,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,4)},{CreateOrder(3,22,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,4)},{CreateOrder(3,80,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,5)},{CreateOrder(3,102,7,1,Attack,64)},{preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,5)},{CreateOrder(3,70,7,1,Attack,64)},{preserved})

	TriggerX(FP,{},{SetMemory(0x6CA010, SetTo, 640);},{preserved})

	CWhileEnd(SetCVar("X",Arrptr,Add,1))
	DoActionsXI(FP,CallCXPlotEff+1)
	CJumpEnd(FP,0x1)
	end
	CXPlot(TShape,FP,nilunit,"Location 1",{SHLX,SHLY},1,16,{1,0,0,0,TShape[1],V(TCount)},"CXfunc",FP,Always(),{SetNext("X",CallCXPlotEff),SetNext(CallCXPlotEff+1,"X",1)})
	DoActionsX(FP,SetCD(CXGeneFlag,0))

	SetCallEnd()



	Call_CA_Effect = SetCallForward()
	function CA_Eff()
		local CA = CAPlotDataArr
		local CB = CAPlotCreateArr
		local PlayerID = CAPlotPlayerID
		CA_RatioXY(CA_Eff_Rat,186000,CA_Eff_Rat,186000)
		CA_Rotate3D(CA_Eff_XY,CA_Eff_YZ,CA_Eff_ZX)
		CMov(FP,CPosX,_Add(V(CA[8]),SHLX))
		CMov(FP,CPosY,_Add(V(CA[9]),SHLY))
		Simple_SetLocX(FP,"Location 1",CPosX,CPosY,CPosX,CPosY,Simple_CalcLoc(0,-32,-32,32,32))
		
		CIf(FP,{CV(CA_Create,0)},{
			SetMemoryW(0x666462, SetTo, 936),
			SetMemory(0x66EC48+(4*936), SetTo, 131),
	})
		


		function CreateEffUnitA(Condition,Height,Color)
			TriggerX(FP,Condition,{{
				SetMemoryB(0x66321C, SetTo, Height); -- 높이
				SetMemoryB(0x669E28+936, SetTo, Color); -- 색상
				CreateUnitWithProperties(1,204,1,FP,{energy = 100})
			}},{preserved})
		end

		CreateEffUnitA({CVar("X",CA[6],Exactly,1);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,1);},20,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,2);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,2);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,2);},18,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,3);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,3);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,3);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,3);},18,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,4);},18,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},20,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,5);},18,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,6);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,6);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,6);},20,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,6);},18,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,7);},19,6)
		CreateEffUnitA({CVar("X",CA[6],Exactly,7);},19,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,7);},20,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,7);},18,13)
		CreateEffUnitA({CVar("X",CA[6],Exactly,8);},19,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,8);},20,17)
		CreateEffUnitA({CVar("X",CA[6],Exactly,8);},18,13)

		CIfEnd({SetMemory(0x66EC48+(4*936), SetTo, 409),SetMemoryB(0x669E28+936, SetTo, 9);})
		CA_CP = CreateVar(FP)
		CIf(FP,{CV(CA_Create,1,AtLeast),CV(CA_Create,227,AtMost)},{SetSwitch(RandSwitch,Random),SetSwitch(RandSwitch2,Random)})
			TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Cleared)},{SetCVar(FP,CA_CP[2],SetTo,4)},{preserved})
			TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Cleared)},{SetCVar(FP,CA_CP[2],SetTo,5)},{preserved})
			TriggerX(FP,{Switch(RandSwitch,Cleared),Switch(RandSwitch2,Set)},{SetCVar(FP,CA_CP[2],SetTo,6)},{preserved})
			TriggerX(FP,{Switch(RandSwitch,Set),Switch(RandSwitch2,Set)},{SetCVar(FP,CA_CP[2],SetTo,7)},{preserved})
			CMov(FP,TRepeatX,CPosX)
			CMov(FP,TRepeatY,CPosY)
			f_TempRepeatX({CD(Theorist,0)}, CA_Create, 1, 193, CA_CP)
			f_TempRepeatX({CD(Theorist,1)}, CA_Create, 1, 186, CA_CP)
		CIfEnd()
		CIf(FP,{CV(CA_Create,1000,AtLeast)})
			CDoActions(FP,{
				TSetMemoryX(0x666458, SetTo, _Sub(CA_Create,1000),0xFFFF),
				CreateUnitWithProperties(1,33,1,FP,{energy = 100}),
				KillUnit(33,FP);
				SetMemoryX(0x666458, SetTo, 546,0xFFFF)
			})
		CIfEnd()
		
	end
	SetCall(FP)
		CAPlot(CSMakePolygon(8,256,0,9,1),FP,nilunit,0,{SHLX,SHLY},1,16,{1,0,0,0,9999,1},"CA_Eff",FP,nil,nil,1)
	SetCallEnd()
	EffUnitLoop = SetCallForward()
	SetCall(FP)
	for i = 0, 1699 do
		Trigger2(FP,{
			DeathsX(19025+(84*i)+25,Exactly,204,0,0xFF),
			DeathsX(19025+(84*i)+19,AtLeast,1*256,0,0xFF00)},
		{
			SetDeathsX(19025+(84*i)+55,SetTo,0x104,0,0x104);
			SetDeathsX(19025+(84*i)+57,SetTo,0,0,0xFF);
			},{preserved})
	end
	SetCallEnd()

	



Call_CunitRefrash = SetCallForward()
SetCall(FP)

for i = 0, 1699 do
	Trigger2(FP,{
		DeathsX(19025+(84*i)+19,Exactly,0*256,0,0xFF00)},
	{
		SetDeathsX(19025+(84*i)+9,SetTo,0,0,0xFF0000);
		SetDeathsX(19025+(84*i)+35,SetTo,0,0,0xFF);

		},{preserved})
end
SetCallEnd()
				--0x00XXXXXX 
				--0x0000NPUU 
local CallCGArr = SetCallForward()
SetCall(FP)
local CGTemp = CreateVarArr(3, FP)
local CGTemp2 = CreateVarArr(3, FP)
local CGivePtr = CreateVar(FP)
local CGJump = def_sIndex()
--CMov(FP,CGivePtr,0)
--CJumpEnd(FP,CGJump)
--CRead(FP,CGTemp[1],_Add(CGiveH[1],CGivePtr))
--CRead(FP,CGTemp[2],_Add(CGiveH[2],CGivePtr))
----DoActions2(FP, RotatePlayer({DisplayTextX("TGCheckAc",4)}, HumanPlayers, FP))
--NIf(FP,CV(CGTemp[1],1,AtLeast))
--CMov(FP,CGTemp2[1],CGTemp[2],nil,0xFF,1)--

--CIf(FP,{TCVar(FP,CGTemp2[1][2],Exactly,CGTemp[3],0xFF)})
--CMov(FP,CGTemp2[2],CGTemp[2],nil,0xF00,1)
--CMov(FP,CGTemp2[3],CGTemp[2],nil,0xF000,1)
--f_Div(FP, CGTemp2[2], 0x100)
--f_Div(FP, CGTemp2[3], 0x1000)--

----f_Read(FP,_Add(CGTemp[1],10),CPos) -- 생성유닛 위치 불러오기
----Convert_CPosXY()
----Simple_SetLocX(FP, 0, CPosX, CPosX, CPosY, CPosY, {Simple_CalcLoc(0,-4,-4,4,4),RotatePlayer({DisplayTextX("TGCheck",4)}, HumanPlayers, FP)})
----CDoActions(FP, {TGiveUnits(1,CGTemp[3],P9,1,CGTemp2[3])})
--f_CGive(FP, CGTemp[1], nil, CGTemp2[3], CGTemp2[2])
--CIfEnd()--

--CAdd(FP,CGivePtr,1)
--CJump(FP,CGJump)
--NIfEnd()

CFor(FP,19025,19025+(84*1700),84)
	local CI = CForVariable()
	CIf(FP,{
		TMemoryX(_Add(CI,19),Exactly,P9,0xFF),
		TMemoryX(_Add(CI,25),Exactly,CGTemp[3],0xFF),
	})
	CMov(FP,CGTemp[1],_Read(_Add(CI,35)),nil,0xFF)
	--f_CGive(FP, CI, nil, CGTemp[1], P9)
	f_Read(FP,_Add(CI,10),CPos) -- 생성유닛 위치 불러오기
	Convert_CPosXY()
	Simple_SetLocX(FP,0,CPosX,CPosY,CPosX,CPosY)
	CDoActions(FP,{TSetMemoryX(_Add(CI,35), SetTo, 0, 0xFF),TGiveUnits(1,CGTemp[3],P9,1,CGTemp[1])})
	CIfEnd()
CForEnd()


SetCallEnd()

function NUGive(Var,UnitID)
	CallTriggerX(FP, CallCGArr, Gun_Line(8,AtLeast,Var), {SetV(CGTemp[3],UnitID)}, 1)--RotatePlayer({DisplayTextX("TGCheckPr",4)}, HumanPlayers, FP)
	TriggerX(FP,{Gun_Line(8,AtLeast,Var)},{Order(UnitID,Force2,64,Attack,64),SetInvincibility(Disable,UnitID,Force2,64)})
end
	
end
