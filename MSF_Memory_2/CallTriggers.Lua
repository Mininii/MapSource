
function Install_CallTriggers()
	local InverseOptionX = CreateCcode()
	local InverseOptionY = CreateCcode()
	f_Replace = SetCallForward()
	SetCall(FP)
		CIfX(FP,Memory(0x628438,AtLeast,1)) -- 캔낫체크.
		f_SaveCp()
		CMov(FP,Gun_LV,0)
		f_Read(FP,BackupCP,CPos)
		Convert_CPosXY()
		f_Read(FP,_Add(BackupCP,1),Gun_LV,"X",0xFF000000)
		f_Read(FP,_Add(BackupCP,1),RepHeroIndex,"X",0xFF)
		f_Div(FP,Gun_LV,_Mov(0x1000000)) -- 1
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		CDoActions(FP,{
			TSetMemoryX(_Add(Nextptrs,9),SetTo,1*65536,0xFF0000),
			SetCDeaths(FP,SetTo,0,InverseOptionX),
			SetCDeaths(FP,SetTo,0,InverseOptionY),
		})
		TriggerX(FP,{CDeaths(FP,Exactly,0,CurPlace)},{SetCDeaths(FP,SetTo,0,InverseOptionX),SetCDeaths(FP,SetTo,0,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,4)},{Preserved})
		TriggerX(FP,{CDeaths(FP,Exactly,1,CurPlace)},{SetCDeaths(FP,SetTo,1,InverseOptionX),SetCDeaths(FP,SetTo,0,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,5)},{Preserved})
		TriggerX(FP,{CDeaths(FP,Exactly,2,CurPlace)},{SetCDeaths(FP,SetTo,0,InverseOptionX),SetCDeaths(FP,SetTo,1,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,6)},{Preserved})
		TriggerX(FP,{CDeaths(FP,Exactly,3,CurPlace)},{SetCDeaths(FP,SetTo,1,InverseOptionX),SetCDeaths(FP,SetTo,1,InverseOptionY),SetCVar(FP,CunitP[2],SetTo,7)},{Preserved})

		CIf(FP,CDeaths(FP,Exactly,1,InverseOptionX))
			CNeg(FP,CPosX)
			CAdd(FP,CPosX,4096)
		CIfEnd()
		CIf(FP,CDeaths(FP,Exactly,1,InverseOptionY))
			CNeg(FP,CPosY)
			CAdd(FP,CPosY,4096)
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,41)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,176)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,177)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,178)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,127)},{SetCVar(FP,CPosY[2],Add,64)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,151)},{SetCVar(FP,CPosY[2],Add,-32)},{Preserved})
			TriggerX(FP,{CVar(FP,RepHeroIndex[2],Exactly,147)},{SetCVar(FP,CPosY[2],Add,-32)},{Preserved})
		CIfEnd()

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
			TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100})})
		CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
		CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x20000,0x20000)},{Set_EXCC2X(DUnitCalc,CUnitIndex,13,SetTo,0x1,0x1)},1) -- 할루시플래그 1일경우 DUnitCalc[14]=1(BitMask)
		f_LoadCp()
		CElseX()
		DoActions(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		CIfXEnd()
	SetCallEnd()

	
	local BCPos = CreateVar(FP)
	local CPlayer = CreateVar(FP)
	local CurCunitI = CreateVar(FP)
	
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
			CDoActions(FP,{SetMemory(0x66EC48+(936*4),SetTo,165),TCreateUnitWithProperties(1,184,1,CPlayer,{energy = 100}),SetMemory(0x66EC48+(936*4),SetTo,409)})
		
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
		CreateUnit(1,204,"Location 1",FP);
		TSetMemoryX(SendEff[1],SetTo,RecoverEff1,SendEff[3]);
		TSetMemory(SendEff2[1],SetTo,RecoverEff1);
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
	TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0d\x0d\x0dCurCPStrPtr : ".._0D,4)},HumanPlayers,FP);},{Preserved})
	TriggerX(FP,{},{RotatePlayer({DisplayTextX("\x0d\x0d\x0dReadCPStrPtr : ".._0D,4)},HumanPlayers,FP);},{Preserved})
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
	Simple_SetLocX(FP,"Location 1",_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),Simple_CalcLoc(0,-128,-128,128,128))


	CIf(FP,CD(CXEffType,0))
	CreateEffUnit({CVar("X",CA[11],AtLeast,0x80000000);CVar("X",CA[11],AtMost,0xFFFFFFFF-128)},0,982,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,0xFFFFFFFF-127)},0,983,10)
	CreateEffUnit({CVar("X",CA[11],AtMost,127);},18,983,17)
	CreateEffUnit({CVar("X",CA[11],AtMost,127);},20,983,16)
	CreateEffUnit({CVar("X",CA[11],AtMost,127);},19,983,13)
	CreateEffUnit({CVar("X",CA[11],AtLeast,128);CVar("X",CA[11],AtMost,0x7FFFFFFF);},20,984,17)
	CreateEffUnit({CVar("X",CA[11],AtLeast,128);CVar("X",CA[11],AtMost,0x7FFFFFFF);},19,984,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,128);CVar("X",CA[11],AtMost,0x7FFFFFFF);},18,984,13)
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
	TriggerX(FP,{},{SetMemory(0x6CA010, SetTo, 640*3);},{Preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,1)},{CreateOrder(3,11,6,1,Attack,64)},{Preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,1)},{CreateOrder(3,29,6,1,Attack,64)},{Preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,2)},{CreateOrder(3,8,7,1,Attack,64)},{Preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,2)},{CreateOrder(3,22,7,1,Attack,64)},{Preserved})

	------ 원점 대칭 -------------------------------------------------------------
	CMov(FP,V(CA[8]),V(CA[12]))
	CMov(FP,V(CA[9]),V(CA[13]))
	CMov(FP,V(CA[11]),V(CA[14]))
	Simple_SetLocX(FP,"Location 1",_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),_Add(V(CA[8]),SHLX),_Add(V(CA[9]),SHLY),Simple_CalcLoc(0,-128,-128,128,128))


	CIf(FP,CD(CXEffType,0))
	CreateEffUnit({CVar("X",CA[11],AtLeast,0x80000000);CVar("X",CA[11],AtMost,0xFFFFFFFF-128)},0,982,10)
	CreateEffUnit({CVar("X",CA[11],AtLeast,0xFFFFFFFF-127)},0,983,10)
	CreateEffUnit({CVar("X",CA[11],AtMost,127);},18,983,17)
	CreateEffUnit({CVar("X",CA[11],AtMost,127);},20,983,16)
	CreateEffUnit({CVar("X",CA[11],AtMost,127);},19,983,13)
	CreateEffUnit({CVar("X",CA[11],AtLeast,128);CVar("X",CA[11],AtMost,0x7FFFFFFF);},20,984,17)
	CreateEffUnit({CVar("X",CA[11],AtLeast,128);CVar("X",CA[11],AtMost,0x7FFFFFFF);},19,984,16)
	CreateEffUnit({CVar("X",CA[11],AtLeast,128);CVar("X",CA[11],AtMost,0x7FFFFFFF);},18,984,13)
	CIfEnd()

	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,1)},{CreateOrder(3,98,6,1,Attack,64)},{Preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,1)},{CreateOrder(3,86,6,1,Attack,64)},{Preserved})
	TriggerX(FP,{CVar("X",CA[11],AtLeast,0x80000000),CD(CXEffType,2)},{CreateOrder(3,70,7,1,Attack,64)},{Preserved})
	TriggerX(FP,{CVar("X",CA[11],AtMost,0x7FFFFFFF),CD(CXEffType,2)},{CreateOrder(3,69,7,1,Attack,64)},{Preserved})

	TriggerX(FP,{},{SetMemory(0x6CA010, SetTo, 640);},{Preserved})

	CWhileEnd(SetCVar("X",Arrptr,Add,1))
	DoActionsXI(FP,CallCXPlotEff+1)
	CJumpEnd(FP,0x1)
	end
	CXPlot(TShape,FP,nilunit,"Location 1",{SHLX,SHLY},1,16,{1,0,0,0,TShape[1],V(TCount)},"CXfunc",FP,Always(),{SetNext("X",CallCXPlotEff),SetNext(CallCXPlotEff+1,"X",1)},nil)

	SetCallEnd()
	
end
