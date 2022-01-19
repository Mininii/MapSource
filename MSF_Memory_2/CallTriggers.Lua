
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

	
	MakeEisEgg = SetCallForward()
	local BCPos = CreateVar(FP)
	local CPlayer = CreateVar(FP)
	local CurCunitI = CreateVar(FP)
	
	SetCall(FP)
	f_SaveCp()
	CIf(FP,Memory(0x628438,AtLeast,1))
		DoActions(FP,{RotatePlayer({DisplayTextX("다시 만나요",4)},HumanPlayers,FP)})
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

end
