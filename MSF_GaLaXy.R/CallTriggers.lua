function Install_CallTriggers()
	SaveCp_CallIndex = SetCallForward()
	SetCall(FP)
		SaveCp(FP,BackupCp)
	SetCallEnd()

	LoadCp_CallIndex = SetCallForward()
	SetCall(FP)
		LoadCp(FP,BackupCp)
		SetRecoverCp()
	SetCallEnd()

	Call_CPosXY = SetCallForward()
	SetCall(FP)
		CMov(FP,CPosX,CPos,0,0XFFFF)
		CMov(FP,CPosY,CPos,0,0XFFFF0000)
		f_Div(FP,CPosY,_Mov(0x10000))
	SetCallEnd()

	-- 저장된 유닛정보를 데이터 배열에서 불러온 후 재배치
	-- 0xYYYYXXXX 0xLLIIPPUU
	-- X = 좌표 X, Y = 좌표 Y, L = 유닛 식별자, I = 무적 플래그, P = 플레이어ID, U = 유닛ID
	f_ReplaceX = InitCFunc(FP)
	FRPara = CFunc(f_ReplaceX)
	UDataTemp = CreateVarArr(2,FP)
	FRJump = def_sIndex()
	CJumpEnd(FP,FRJump)
	CRead(FP,UDataTemp[1],FArr(UnitDataVoid[1],UnitDataPtr))
	CRead(FP,UDataTemp[2],FArr(UnitDataVoid[2],UnitDataPtr))
	NIf(FP,CV(UDataTemp[1],1,AtLeast))
	if X2_Mode == 1 then
		X2_Jump = def_sIndex()
		X2_Hero = CreateCcode()
		DoActionsX(FP,SetCD(X2_Hero,0))
		NJumpXEnd(FP,X2_Jump)
	end
		NIfX(FP,Memory(0x628438,AtLeast,1)) -- 캔낫체크.
		CMov(FP,CPos,UDataTemp[1])
		Convert_CPosXY()
		CMov(FP,Gun_LV,UDataTemp[2],nil,0xFF000000)
		CMov(FP,CunitP,UDataTemp[2],nil,0xFF00)
		CMov(FP,RepHeroIndex,UDataTemp[2],nil,0xFF)
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
		DoActionsX(FP,SetV(TempEPD,0))
		TriggerX(FP,{CV(RepHeroIndex,131)},{AddCD(HactCcode,1)},{preserved})
		TriggerX(FP,{CV(RepHeroIndex,132)},{AddCD(LairCcode,1)},{preserved})
		TriggerX(FP,{CV(RepHeroIndex,133)},{AddCD(HiveCcode,1)},{preserved})
		CIf(FP,{CV(RepHeroIndex,131)})
			TMem(FP,TempEPD,Arr(HactLinkArr[1],0),0,0)
			CAdd(FP,TempEPD,_Mul(Gun_LV,0x970/4))
			JumpArrI = def_sIndex()
			CJumpEnd(FP,JumpArrI)
			NIfX(FP,{TMemory(TempEPD,Exactly,0)})
			CDoActions(FP,{TSetMemory(TempEPD,SetTo,CPos)})
			NElseX()
			DoActionsX(FP,{AddV(TempEPD,1)})
			CJump(FP,JumpArrI)
			NIfXEnd()
		CIfEnd()
		CIf(FP,{CV(RepHeroIndex,132)})
			TMem(FP,TempEPD,Arr(LairLinkArr[1],0),0,0)
			CAdd(FP,TempEPD,_Mul(Gun_LV,0x970/4))
			JumpArrI = def_sIndex()
			CJumpEnd(FP,JumpArrI)
			NIfX(FP,{TMemory(TempEPD,Exactly,0)})
			CDoActions(FP,{TSetMemory(TempEPD,SetTo,CPos)})
			NElseX()
			DoActionsX(FP,{AddV(TempEPD,1)})
			CJump(FP,JumpArrI)
			NIfXEnd()
		CIfEnd()
		CDoActions(FP,{
			Set_EXCC2(DUnitCalc,CunitIndex,0,SetTo,Gun_LV),
			TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100})})
			CTrigger(FP,{CVar(FP,RepHeroIndex[2],AtMost,104)},{Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)},1)
		
		CTrigger(FP,{CVar(FP,UDataTemp[2][2],Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
		if X2_Mode == 1 then
			NJumpX(FP,X2_Jump,{CV(RepHeroIndex,104,AtMost),CD(X2_Hero,0,AtMost)},{AddCD(X2_Hero,1)})
		end
		CAdd(FP,UnitDataPtr,1)
		CJump(FP,FRJump)
		NElseX()
		f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
		DoActions(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		NIfXEnd()
	NIfEnd()
	CFuncEnd()
	


	f_Replace = SetCallForward()
	SetCall(FP)
	if X2_Mode == 1 then
		X2_Jump = def_sIndex()
		X2_Hero = CreateCcode()
		DoActionsX(FP,SetCD(X2_Hero,0))
		NJumpXEnd(FP,X2_Jump)
	end
		NIfX(FP,Memory(0x628438,AtLeast,1)) -- 캔낫체크.
		f_SaveCp()
		CMov(FP,Gun_LV,0)
		f_Read(FP,BackupCP,CPos)
		Convert_CPosXY()
		f_Read(FP,_Add(BackupCP,1),Gun_LV,"X",0xFF000000)
		f_Read(FP,_Add(BackupCP,1),CunitP,"X",0xFF00)
		f_Read(FP,_Add(BackupCP,1),RepHeroIndex,"X",0xFF)
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
		DoActionsX(FP,SetV(TempEPD,0))
		TriggerX(FP,{CV(RepHeroIndex,131)},{AddCD(HactCcode,1)},{preserved})
		TriggerX(FP,{CV(RepHeroIndex,132)},{AddCD(LairCcode,1)},{preserved})
		TriggerX(FP,{CV(RepHeroIndex,133)},{AddCD(HiveCcode,1)},{preserved})
		CIf(FP,{CV(RepHeroIndex,131)})
			TMem(FP,TempEPD,Arr(HactLinkArr[1],0),0,0)
			CAdd(FP,TempEPD,_Mul(Gun_LV,0x970/4))
			JumpArrI = def_sIndex()
			CJumpEnd(FP,JumpArrI)
			NIfX(FP,{TMemory(TempEPD,Exactly,0)})
			CDoActions(FP,{TSetMemory(TempEPD,SetTo,CPos)})
			NElseX()
			DoActionsX(FP,{AddV(TempEPD,1)})
			CJump(FP,JumpArrI)
			NIfXEnd()
		CIfEnd()
		CIf(FP,{CV(RepHeroIndex,132)})
			TMem(FP,TempEPD,Arr(LairLinkArr[1],0),0,0)
			CAdd(FP,TempEPD,_Mul(Gun_LV,0x970/4))
			JumpArrI = def_sIndex()
			CJumpEnd(FP,JumpArrI)
			NIfX(FP,{TMemory(TempEPD,Exactly,0)})
			CDoActions(FP,{TSetMemory(TempEPD,SetTo,CPos)})
			NElseX()
			DoActionsX(FP,{AddV(TempEPD,1)})
			CJump(FP,JumpArrI)
			NIfXEnd()
		CIfEnd()
		CDoActions(FP,{
			Set_EXCC2(DUnitCalc,CunitIndex,0,SetTo,Gun_LV),
			TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100})})
			CTrigger(FP,{CVar(FP,RepHeroIndex[2],AtMost,104)},{Set_EXCC2(DUnitCalc,CunitIndex,1,SetTo,1)},1)
		
		CTrigger(FP,{TMemoryX(_Add(BackupCP,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
		f_LoadCp()
		if X2_Mode == 1 then
			NJumpX(FP,X2_Jump,{CV(RepHeroIndex,104,AtMost),CD(X2_Hero,0,AtMost)},{AddCD(X2_Hero,1)})
		end
		NElseX()
		f_ReplaceErrT = "\x07『 \x08ERROR : \x04캔낫으로 인해 f_Replace를 실행할 수 없습니다! 스크린샷으로 제작자에게 제보해주세요!\x07 』"
		DoActions(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
		NIfXEnd()
	SetCallEnd()
	
Call_OCU = SetCallForward()
SetCall(FP)
f_Read(FP,TempUpgradePtr,CurrentUpgrade)


CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
f_Mod(FP,CurrentUpgrade,_Mul(TempUpgradeMaskRet,_Mov(256)))
CIfEnd()
f_Div(FP,CurrentUpgrade,TempUpgradeMaskRet)

CIfX(FP,CDeaths(FP,AtLeast,1,ifUpisAtk))
CMov(FP,UpGradeAv,AtkUpMax)
CElseX()
CMov(FP,UpGradeAv,255)
CIfXEnd()


CMov(FP,0x6509B0,UpgradeCP)
OCU_Jump = def_sIndex()
OCU_Jump2 = def_sIndex()
CJumpEnd(FP,OCU_Jump)
NWhile(FP,{
TCVar(FP,CurrentUpgrade[2],AtMost,_Sub(UpGradeAv,1)),
CVar(FP,UpgradeMax[2],AtLeast,1),
TAccumulate(CurrentPlayer,AtLeast,_Mul(CurrentUpgrade,UpgradeFactor),Ore),
TMemoryX(TempUpgradePtr,AtMost,_Mul(TempUpgradeMaskRet,_Sub(UpGradeAv,1)),_Mul(TempUpgradeMaskRet,_Mov(255)))})
CDoActions(FP,{
TSetCVar(FP,CurrentFactor[2],Add,_Mul(CurrentUpgrade,UpgradeFactor)),
TSetResources(CurrentPlayer,Subtract,_Mul(CurrentUpgrade,UpgradeFactor),Ore),
SetCVar(FP,CurrentUpgrade[2],Add,1),
SetCVar(FP,UpCount[2],Add,1),
SetCVar(FP,UpgradeMax[2],Subtract,1),
TSetMemoryX(TempUpgradePtr,Add,_Mul(TempUpgradeMaskRet,1),_Mul(TempUpgradeMaskRet,_Mov(255)))})
CJump(FP,OCU_Jump)
NWhileEnd()
NJump(FP,OCU_Jump2,CVar(FP,UpCount[2],Exactly,0),{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
		})
ItoDec(FP,CurrentFactor,VArr(UpCompTxt,0),2,0x1F,0)
ItoDec(FP,UpCount,VArr(UpCompRet,0),2,0x19,0)
_0DPatchforVArr(FP,UpCompRet,4)
_0DPatchforVArr(FP,UpCompTxt,4)
TempStrPtr = CreateVarArr(2,FP)
CMov(FP,TempStrPtr[1],UPCompStrPtr,Str12[2])
CMov(FP,TempStrPtr[2],UPCompStrPtr,Str12[2]+16+Str22[2])

f_Movcpy(FP,TempStrPtr[1],VArr(UpCompTxt,0),4*4)
f_Movcpy(FP,TempStrPtr[2],VArr(UpCompRet,0),4*4)

CDoActions(FP,{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x0D\x0D\x0DUPC".._0D,4),
		SetMemory(0x6509B0,SetTo,FP)
		})
NJumpEnd(FP,OCU_Jump2)
SetCallEnd()
MinGachaP = CreateVar(FP)
MinGacha = SetCallForward()
SetCall(FP)
	DoActions(FP, {SetSwitch(RandSwitch1,Random)})
	CIfX(FP,{Switch(RandSwitch1, Set)})
	MinGachaRandT = CreateVArr(4,FP)
		MinGachaRand = f_CRandNum(100001)
		ItoDec(FP,MinGachaRand,VArr(MinGachaRandT,0),2,0x1F,0)
		f_Movcpy(FP,_Add(MinGachaPStrPtr,MGPStr1[2]),VArr(MinGachaRandT,0),16)
		CDoActions(FP,{TSetMemory(0x6509B0, SetTo, MinGachaP),PlayWAV("staredit\\wav\\MMinus.wav"),DisplayText("\x0D\x0D\x0DMGaP".._0D,4),TSetResources(MinGachaP, Add, MinGachaRand, Ore)})

	CElseX()
		MinGachaRand = f_CRandNum(100001)
		ItoDec(FP,MinGachaRand,VArr(MinGachaRandT,0),2,0x1F,0)
		f_Movcpy(FP,_Add(MinGachaMStrPtr,MGPStr1[2]),VArr(MinGachaRandT,0),16)
		CDoActions(FP,{TSetMemory(0x6509B0, SetTo, MinGachaP),PlayWAV("staredit\\wav\\MPlus.wav"),DisplayText("\x0D\x0D\x0DMGaM".._0D,4),TSetResources(MinGachaP, Subtract, MinGachaRand, Ore)})
		
	CIfXEnd()

SetCallEnd()
end