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

local UpCompTxt = CreateVArray(FP,5)
local UpCompRet = CreateVArray(FP,5)

TempMul_254,TempMul_255,TempMul_1,TempFactor = CreateVars(4,FP)

OneClickUpgrade = SetCallForward()
SetCall(FP) 
	f_Read(FP,TempUpgradePtr,UpResearched)
	CIf(FP,CVar(FP,TempUpgradeMaskRet[2],AtMost,256^2))
		CMod(FP,UpResearched,_Mul(TempUpgradeMaskRet,_Mov(256)))
	CIfEnd()
	CDiv(FP,UpResearched,TempUpgradeMaskRet)
	f_Mul(FP,TempMul_254,TempUpgradeMaskRet,_Mov(254))
	f_Mul(FP,TempMul_255,TempUpgradeMaskRet,_Mov(255))
	f_Mul(FP,TempMul_1,TempUpgradeMaskRet,_Mov(1))
	CMov(FP,0x6509B0,UpgradeCP)
	OCU_Jump = def_sIndex()
	CJumpEnd(FP,OCU_Jump)
	f_Mul(FP,TempFactor,UpResearched,UpgradeFactor)
	NWhile(FP,{
		CVar(FP,UpResearched[2],AtMost,254),
		CVar(FP,UpgradeMax[2],AtLeast,1),
		TAccumulate(CurrentPlayer,AtLeast,TempFactor,Ore),
		TMemoryX(TempUpgradePtr,AtMost,TempMul_254,TempMul_255)
	})
		CDoActions(FP,{
			TSetCVar(FP,UpCost[2],Add,TempFactor),
			TSetResources(CurrentPlayer,Subtract,TempFactor,Ore),
			SetCVar(FP,UpResearched[2],Add,1),
			SetCVar(FP,UpCompleted[2],Add,1),
			SetCVar(FP,UpgradeMax[2],Subtract,1),
			--TSetCVar(FP,UpCost[2],Add,TempFactor),
			TSetMemoryX(TempUpgradePtr,Add,TempMul_1,TempMul_255)
		})
		CJump(FP,OCU_Jump)
	NWhileEnd()

	OCU_Check = def_sIndex()
	NJump(FP,OCU_Check,CVar(FP,UpCompleted[2],Exactly,0),{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x12\x07『 \x04잔액이 부족합니다. \x07』",4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	ItoDec(FP,UpCost,VArr(UpCompTxt,0),2,0x1F,0)
	ItoDec(FP,UpCompleted,VArr(UpCompRet,0),2,0x19,0)
	_0DPatchforVArr(FP,UpCompRet,4)
	_0DPatchforVArr(FP,UpCompTxt,4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]),VArr(UpCompTxt,0),5*4)
	f_Movcpy(FP,_Add(UPCompStrPtr,Str12[2]+20+Str22[2]-3),VArr(UpCompRet,0),5*4)
	CDoActions(FP,{
		TSetMemory(0x6509B0,SetTo,UpgradeCP),
		DisplayText("\x0D\x0D\x0DUPC".._0D,4),
		SetMemory(0x6509B0,SetTo,FP)
	})
	NJumpEnd(FP,OCU_Check)
	DoActionsX(FP,{
		SetCVar(FP,TempUpgradeMaskRet[2],SetTo,0),
		SetCVar(FP,TempUpgradePtr[2],SetTo,0),
		SetCVar(FP,UpResearched[2],SetTo,0),
		SetCVar(FP,UpCost[2],SetTo,0),
		SetCVar(FP,UpCompleted[2],SetTo,0)
	})
SetCallEnd()

CGiveUnitID = CreateVar(FP)
Call_CGiveP9 = SetCallForward()
function CGiveJYD_P9(Condition,UnitID)
	CallTriggerX(FP,Call_CGiveP9,Condition,{SetCVar(FP,CGiveUnitID[2],SetTo,UnitID),SetInvincibility(Disable, UnitID, P9, 64)})
end
SetCall(FP)
CMov(FP,0x6509B0,19025+19) --CUnit 시작지점 +19 (0x4C)
CWhile(FP,Memory(0x6509B0,AtMost,19025+19 + (84*1699)))
CIf(FP,{DeathsX(CurrentPlayer,AtLeast,1*256,0,0xFF00),DeathsX(CurrentPlayer,Exactly,8,0,0xFF)})
	DoActions(FP,MoveCp(Add,6*4))
	f_SaveCp()
	local TempPos = CreateVar(FP)
	CIf(FP,{TMemoryX(BackupCp, Exactly, CGiveUnitID,0xFF)})
	f_CGive(FP, _Sub(BackupCp,25), nil, FP, P9)
	f_Read(FP,_Sub(BackupCp,15),TempPos)
	CDoActions(FP,{
	TSetDeaths(_Sub(BackupCp,2),SetTo,0,0),
	TSetDeathsX(_Sub(BackupCp,6),SetTo,187*256,0,0xFF00),
	TSetDeaths(_Sub(BackupCp,19),SetTo,TempPos,0),
	TSetDeaths(_Sub(BackupCp,3),SetTo,TempPos,0),
	TSetDeaths(_Sub(BackupCp,21),SetTo,TempPos,0),
	TSetMemoryX(_Add(BackupCp,30),SetTo,0,0x04000000),
	TSetDeathsX(_Add(BackupCp,47),SetTo,0,0,0xFF00),
})
	CIfEnd()
	f_LoadCp()
	DoActions(FP,MoveCp(Subtract,6*4))
CIfEnd()
CAdd(FP,0x6509B0,84)
CWhileEnd()
CMov(FP,0x6509B0,FP)
SetCallEnd()
TempRandRet = CreateVar(FP)
InputMaxRand = CreateVar(FP)
Oprnd = CreateVar(FP)
CRandNum = SetCallForward()
SetCall(FP)
f_Rand(FP,TempRandRet)
f_Mod(FP,TempRandRet,InputMaxRand)
CAdd(FP,TempRandRet,Oprnd)
SetCallEnd()


function f_Recall(Condition,X,Y)
	CMov(FP,Rec_X,X)
	CMov(FP,Rec_Y,Y)
	CallTriggerX(FP,Call_Recall,Condition)
end
Rec_X = CreateVar(FP)
Rec_Y = CreateVar(FP)
Call_Recall = SetCallForward()
SetCall(FP)
	CIf(FP,{Memory(0x628438,AtLeast,1),CVar(FP,Rec_X[2],AtMost,32*96),CVar(FP,Rec_Y[2],AtMost,32*192)})
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		Simple_SetLocX(FP,0,RecallPosX,5984,RecallPosX,5984,{SetCVar(FP,RecallPosX[2],Add,4)})
		DoActions(FP,{
		CreateUnitWithProperties(1,71,1,FP,{energy = 100});})
		CIf(FP,{TMemoryX(_Add(Nextptrs,40),AtLeast,150*16777216,0xFF000000)})
			CDoActions(FP,{
			TSetMemory(_Add(Nextptrs,0x58/4),SetTo,_Add(Rec_X,_Mul(Rec_Y,65536))),
			TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,137*256,0xFF00)})
		CIfEnd()
	CIfEnd()

SetCallEnd()
G_TempH = CreateVar(FP)
G_InputH = CreateVar(FP) --{"X",0x500,0x15C,1,0}





InstallGunData()





f_Gun = SetCallForward() -- 건작함수
SetCall(FP)


	Simple_SetLocX(FP,0,Var_TempTable[2],Var_TempTable[3],Var_TempTable[2],Var_TempTable[3])
	CIf(FP,{CVar(FP,Var_TempTable[54][2],AtMost,255)}) -- 레어나 하이브 등의 건작일 경우
		Case_OverCocoon()
		Case_Overmind()
		Case_Daggoth()
		Case_Cerebrate()
		Case_InfestedCommand()
		Case_Hive()
		Case_Lair()
		Case_Hatchery()
		Case_Formation()

		
		
	CIfEnd()
	Case_Various()
	CTrigger(FP,{},{Gun_SetLineX(4,Add,1)},1)

	
	GunPushTrig = {}
	for i = 0, 54 do
		table.insert(GunPushTrig,TSetMemory(_Add(G_TempH,(i*0x20)/4),SetTo,Var_TempTable[i+1]))
	end

	CDoActions(FP,GunPushTrig)

	CIf(FP,{Gun_Line(54,AtLeast,1)}) -- SuspendCode
		CMov(FP,G_TempW,0)
		CWhile(FP,CVar(FP,G_TempW[2],AtMost,(Var_Lines-1)*(0x20/4)))
			CDoActions(FP,{TSetMemory(_Add(G_TempH,G_TempW),SetTo,0)})
			CAdd(FP,G_TempW,0x20/4)
		CWhileEnd()
		if Limit == 1 then
			CIf(FP,CD(TestMode,1))
			ItoDec(FP,f_GunNum,VArr(f_GunNumT,0),2,0x1F,0)
			_0DPatchX(FP,f_GunNumT,5)
			f_Movcpy(FP,_Add(f_GunStrPtr,f_GunT[2]),VArr(f_GunNumT,0),5*4)
			DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_Gun".._0D,4)},HumanPlayers,FP)})
			CIfEnd()
		end
	CIfEnd()

SetCallEnd()

local G_TempV,G_CA,GunID = CreateVariables(4)
G_Send = SetCallForward()
SetCall(FP)
	f_SaveCp()
	f_Read(FP,_Sub(BackupCp,15),CPos)
	f_Read(FP,BackupCp,GunID,"X",0xFF)
	Convert_CPosXY()
	CMov(FP,G_CA,0)
	G_SkipJump = def_sIndex()
	CJumpEnd(FP,G_SkipJump)
	CAdd(FP,G_TempV,_Mul(G_CA,_Mov(0x970/4)),G_InputH)
	NIf(FP,{TMemory(G_TempV,AtLeast,1),CVar(FP,G_CA[2],AtMost,126)},{SetCVar(FP,G_CA[2],Add,1)})
		CJump(FP,G_SkipJump)
	NIfEnd()

	CIfX(FP,{CVar(FP,G_CA[2],AtMost,126)})
	CDoActions(FP,{
		TSetMemory(G_TempV,SetTo,GunID),
		TSetMemory(_Add(G_TempV,1*(0x20/4)),SetTo,CPosX),
		TSetMemory(_Add(G_TempV,2*(0x20/4)),SetTo,CPosY),
		TSetMemory(_Add(G_TempV,3*(0x20/4)),SetTo,DUnitCalc[4][1]),
		TSetMemory(_Add(G_TempV,53*(0x20/4)),SetTo,Gun_Type),
	})
	
	if Limit == 1 then
	CIf(FP,CD(TestMode,1))
	ItoDec(FP,G_CA,VArr(f_GunNumT,0),2,0x1F,0)
	_0DPatchX(FP,f_GunNumT,5)
	f_Movcpy(FP,_Add(f_GunSendStrPtr,f_GunSendT[2]),VArr(f_GunNumT,0),5*4)
	DoActions(FP,{RotatePlayer({DisplayTextX("\x0D\x0D\x0Df_GunSend".._0D,4)},HumanPlayers,FP)})
	CIfEnd()
	end
	CElseX()
	DoActions(FP,{RotatePlayer({DisplayTextX(G_SendErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
	CIfXEnd()
	f_LoadCp()
SetCallEnd()
UnitIDV = CreateVar(FP)
TempLvHP = CreateVar(FP)
TempLvHP2 = CreateVar(FP)
TempLvHP_L = CreateWar(FP)
TempLvHP_L3 = CreateWar(FP)
TempLvHP_L4 = CreateWar(FP)
TempLvHP_L5 = CreateWar(FP)
TempLvHP_L6 = CreateWar(FP)
TempBakHP = CreateVar(FP)
TempBakHP2 = CreateVar(FP)
HPMul = CreateVar(FP)
f_SetLvHP = SetCallForward()
SetCall(FP)
		CMovX(FP, TempBakHP, VArr(MaxHPBackUp,UnitIDV), SetTo, nil, nil, 1)
		f_Div(FP,TempBakHP2,TempBakHP,4)
		f_LAdd(FP, TempLvHP_L, _LMul({TempBakHP2,0}, {_Div(Level,_Mov(10)),0}), {TempBakHP,0})
		f_LDiv(FP, TempLvHP_L6, TempLvHP_L,"2")
		f_LMul(FP, TempLvHP_L5, TempLvHP_L6, _LMov({LevelT-1,0}))
		f_LAdd(FP,TempLvHP_L4,TempLvHP_L,TempLvHP_L5)
		f_LMovX(FP, WArr(MaxHPWArr,UnitIDV), TempLvHP_L4,SetTo,nil,nil,1)
		CTrigger(FP,{TTCWar(FP,TempLvHP_L4[2],AtLeast,"2129920000")},{SetCWar(FP,TempLvHP_L4[2],SetTo,"2129920000")},{preserved})
		CTrigger(FP,{TTCWar(FP,TempLvHP_L4[2],AtMost,"255")},{SetCWar(FP,TempLvHP_L4[2],SetTo,"256")},{preserved})
		f_Cast(FP,{TempLvHP2,0},TempLvHP_L4,nil,nil,1) 
		--CMov(FP,0x57f120+(4*0),TempLvHP2)
		CDoActions(FP,{TSetMemory(_Add(UnitIDV,EPDF(0x662350)),SetTo,TempLvHP2)})
SetCallEnd()
WepIDV = CreateVar(FP)
TempLVWp=CreateVarArr(5,FP)
local UpVar = CreateVar(FP)
f_SetLvAtk = SetCallForward()
SetCall(FP)
CMovX(FP, TempLVWp[1], VArr(AtkBackUp, WepIDV), nil, nil, nil, 1)
CMovX(FP, TempLVWp[2], VArr(AtkFactorBackUp, WepIDV), nil, nil, nil, 1)
CMul(FP,TempLVWp[3],UpVar,TempLVWp[2])
CAdd(FP,TempLVWp[4],TempLVWp[3],TempLVWp[1])
CIf(FP,CV(TempLVWp[4],65535,AtLeast),SubV(TempLVWp[4],65535))
	CDoActions(FP, {
		TSetMemoryW(0x657678,WepIDV,SetTo,0),
		TSetMemoryW(0x656EB0,WepIDV,SetTo,65535),
	})
	


CIfEnd()

SetCallEnd()


f_Replace = SetCallForward()
SetCall(FP)
	CIfX(FP,Memory(0x628438,AtLeast,1))
	f_SaveCp()
	CMov(FP,Gun_LV,0)
	f_Read(FP,BackupCp,CPos)
	Convert_CPosXY()
	f_Read(FP,_Add(BackupCp,1),Gun_LV,"X",0xFF000000)
	f_Read(FP,_Add(BackupCp,1),CunitP,"X",0xFF00)
	f_Read(FP,_Add(BackupCp,1),RepHeroIndex,"X",0xFF)
	f_Div(FP,CunitP,_Mov(0x100)) -- 0
	f_Div(FP,Gun_LV,_Mov(0x1000000)) -- 1
	f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
	CMov(FP,CunitIndex,_Div(_Sub(Nextptrs,19025),_Mov(84)))
	local TempW = CreateWar(FP)
	f_LMovX(FP, TempW, WArr(MaxHPWArr,RepHeroIndex), SetTo, nil, nil, 1)
	CIf(FP,{TTCWar(FP, TempW[2], AtLeast, tostring(8320000*256))})
	local TempV1 = CreateVar(FP)
	local TempV2 = CreateVar(FP)
	f_LMov(FP, {TempV1,TempV2}, _LSub(TempW,tostring(8320000*256)), nil, nil, 1)
		CDoActions(FP, {
			Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo,1),
			Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo,TempV1),
			Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo,TempV2),
			
	})
	CIfEnd()

	CDoActions(FP,{
	TSetMemory(0x58DC60 + 0x14*0,SetTo,_Sub(CPosX,18)),
	TSetMemory(0x58DC68 + 0x14*0,SetTo,_Add(CPosX,18)),
	TSetMemory(0x58DC64 + 0x14*0,SetTo,_Sub(CPosY,18)),
	TSetMemory(0x58DC6C + 0x14*0,SetTo,_Add(CPosY,18)),
	})
	CDoActions(FP,{
		Set_EXCC2(DUnitCalc, CunitIndex, 1, SetTo,1),
		Set_EXCC2(DUnitCalc, CunitIndex, 0, SetTo,Gun_LV),
		Set_EXCC2(DUnitCalc, CunitIndex, 8, SetTo,1)
	})
	CIfX(FP,CVar(FP,RepHeroIndex[2],Exactly,111))
	CDoActions(FP,{
	TCreateUnitWithProperties(1, RepHeroIndex, 1, P8,{energy = 100}),TSetMemoryX(_Add(Nextptrs,19),SetTo,CunitP,0xFF)})
	for i = 0, 6 do
	CIf(FP,CVar(FP,CunitP[2],Exactly,i))
		CMov(FP,BarrackPtr[i+1],Nextptrs)
		f_Read(FP,_Add(BarrackPtr[i+1],10),BarPos[i+1])
	CIfEnd()
	end
	CElseX()
	CDoActions(FP,{
	TCreateUnitWithProperties(1, RepHeroIndex, 1, CunitP,{energy = 100})})
	CTrigger(FP,{TMemoryX(_Add(BackupCp,1),Exactly,0x10000,0x10000)},{TSetMemoryX(_Add(Nextptrs,55),SetTo,0x04000000,0x04000000)},1) -- 무적플래그 1일경우 무적상태로 바꿈
	CIfXEnd()
	f_LoadCp()
	CElseX()
	DoActions(FP,{RotatePlayer({DisplayTextX(f_ReplaceErrT,4),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav"),PlayWAVX("sound\\Misc\\Buzz.wav")},HumanPlayers,FP)})
	CIfXEnd()
SetCallEnd()



function f_ArrReset(Condition)
	CallTriggerX(FP,Call_ArrReset,Condition)
end
Call_ArrReset = SetCallForward()
SetCall(FP)
	-- ArrayReset
	CFor(FP,0,1000,1)
	local CI = CForVariable()
	CDoActions(FP,{
		TSetMemory(_Add(XY_ArrHeader,CI),SetTo,0)
	})
	CForEnd()
SetCallEnd()

local CB_UnitIDV =CreateVar(FP)
local Height_V = CreateVar(FP)
local Angle_V = CreateVar(FP)
local CB_X = CreateVar(FP)
local CB_Y = CreateVar(FP)
local CB_P = CreateVar(FP)
	function CreateBullet(UnitID,Height,Angle,X,Y,ForPlayer)
		if ForPlayer == nil then ForPlayer = FP end
	CDoActions(FP,{
		TSetCVar(FP,CB_UnitIDV[2],SetTo,UnitID),
		TSetCVar(FP,Height_V[2],SetTo,Height),
		TSetCVar(FP,Angle_V[2],SetTo,Angle),
		TSetCVar(FP,CB_X[2],SetTo,X),
		TSetCVar(FP,CB_Y[2],SetTo,Y),
		TSetCVar(FP,CB_P[2],SetTo,ForPlayer),
		SetNext("X",CallCBullet,0),SetNext(CallCBullet+1,"X",1)
	})
	end
	
	CallCBullet = SetCallForward()
	SetCall(FP)
	CIf(FP,Memory(0x628438,AtLeast,1))
		f_Read(FP,0x628438,"X",Nextptrs,0xFFFFFF)
		CAdd(FP,CB_Y,10)
		CIf(FP,{CVar(FP,Angle_V[2],AtLeast,0x80000000)})
			CNeg(FP,Angle_V)
			CSub(FP,Angle_V,_Mov(256),Angle_V)
		CIfEnd()
		f_Mod(FP,Angle_V,_Mov(256))
		CDoActions(FP,{
			TSetMemoryX(0x66321C, SetTo, Height_V,0xFF),
			TSetMemory(0x58DC60 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC68 + 0x14*0,SetTo,CB_X),
			TSetMemory(0x58DC64 + 0x14*0,SetTo,CB_Y),
			TSetMemory(0x58DC6C + 0x14*0,SetTo,CB_Y),
			TCreateUnit(1, CB_UnitIDV, 1, CB_P)})
		CDoActions(FP,{
			TSetMemoryX(_Add(Nextptrs,0x58/4),SetTo,_ReadF(_Add(Nextptrs,(0x28/4))),0xFFFFFFFF),
			TSetMemoryX(_Add(Nextptrs,0x20/4),SetTo,_Mul(Angle_V,256),0xFF00),
			TSetMemoryX(_Add(Nextptrs,0x4C/4),SetTo,135*256,0xFF00),
			TSetMemoryX(_Add(Nextptrs,40),SetTo,0,0xFF000000),
			TSetMemoryX(_Add(Nextptrs,55),SetTo,0x200104,0x300104),
			TSetMemory(_Add(Nextptrs,57),SetTo,0),
		})
	CIfEnd()
	SetCallEnd()
	local IndexJump = def_sIndex()
	WrPosSave = SetCallForward()
	SetCall(FP)
		CMov(FP,CurArr,0)
		CJumpEnd(FP,IndexJump)
		NIf(FP,{TMemory(_Add(XY_ArrHeader,CurArr),AtLeast,1)})
			CAdd(FP,CurArr,1)
			CJump(FP,IndexJump)
		NIfEnd()
		CDoActions(FP,{TSetMemory(_Add(XY_ArrHeader,CurArr),SetTo,_Add(_Mov(CX,0xFFFF),_Mul(CY,_Mov(65536))))})
	SetCallEnd()

	
	Call_VoidReset = SetCallForward()
	SetCall(FP)
		CFor(FP, EPD(VoidAreaOffset), EPD(VoidAreaOffset)+2001, 1)
			local CI = CForVariable()
			CDoActions(FP,{TSetMemory(CI,SetTo,0)})
		CForEnd()
	SetCallEnd()

	Call_ScorePrint = SetCallForward()
	SetCall(FP)
	
		local ExScoreVA = Create_VArrTable(7,13)
		local ExScoreP = Create_VTable(7)
		local TotalScoreVA = CreateVArray(FP,7)
		local DBossScoreVA = CreateVArray(FP,7)
		TxtSkip = Str10[2] + GetStrSize(0,"\x0d\x0d\x0d\x0d\x0d\x0d\x0d\x04 : \x1F\x0d\x0d\x0d\x0d\x0d\x0d") + (4*6)
		for i = 1, 7 do
			if Limit == 1 then
				TriggerX(FP,{CD(TestMode,1),CVar(FP,ExScore[i],AtLeast,0x80000000)},{SetCVar(FP,ExScore[i],SetTo,0)},{preserved})
			end
		CIf(FP,CVar(FP,BarPos[i][2],AtLeast,1))
		CMov(FP,ExScoreP[i],ExScore[i])
		ItoDecX(FP,ExScoreP[i],VArr(ExScoreVA[i],0),2,nil,2)
		_0DPatchX(FP,ExScoreVA[i],6)
		f_Movcpy(FP,_Add(PScoreSTrPtr[i],TxtSkip),VArr(ExScoreVA[i],0),12*4)
		f_Memcpy(FP,_Add(PScoreSTrPtr[i],TxtSkip+(12*4)),_TMem(Arr(Str19[3],0),"X","X",1),Str19[2])
		CIfEnd()

		
		end
		Trigger {
			players = {FP},
			conditions = {
				},
			
			actions = {
				RotatePlayer({DisplayTextX("\n\n\n\n\n\n\n\n\n\n\n\x13\x10【 \x06Ｔ\x04ｏｔａｌ　\x1FＳｃｏｒｅ \x10】",4),PlayWAVX("staredit\\wav\\button3.wav"),PlayWAVX("staredit\\wav\\button3.wav")},HumanPlayers,FP);
				PreserveTrigger();
			},
		}
		CMov(FP,TotalScore,0)
		for i = 1, 7 do
		CIf(FP,CVar(FP,BarPos[i][2],AtLeast,1))
		CAdd(FP,TotalScore,ExScore[i])
		Trigger {
			players = {FP},
			conditions = {
				},
			
			actions = {
				RotatePlayer({DisplayTextX("\x0D\x0D\x0D"..PlayerString[i].."Score".._0D,4)},HumanPlayers,FP);
				PreserveTrigger();
			},
		}
		CIfEnd()
		end
		CIf(FP,CDeaths(FP,AtLeast,1,Win))
			ReadScore = CreateVar(FP)
			for i = 0, 6 do
				CIf(FP,{HumanCheck(i,1)})
				CMov(FP,ReadScore,0)
					CIfX(FP,{CVar(FP,ExScore[i+1][2],AtMost,0x7FFFFFFF)})
					
					CIfX(FP,{CVar(FP,PCheckV[2],Exactly,1)})
					CMov(FP,ReadScore,0)
					CElseX()
					f_Div(FP,ReadScore,ExScore[i+1],100)
					CIfXEnd()
					CElseX()
					CMov(FP,ReadScore,0)
					CIfXEnd()
					f_Mul(FP,ReadScore,_Mov(2))
					--CMul(FP,ReadScore,_Div(Level,_Mov(10)))
					CDoActions(FP,{TSetDeaths(i,Add,ReadScore,4),SetDeaths(i,SetTo,1,14)})
					CTrigger(FP,{TDeaths(i,AtMost,ExScore[i+1],36),CVar(FP,ExScore[i+1][2],AtMost,0x7FFFFFFF)},{TSetDeaths(i,SetTo,ExScore[i+1],36),SetMemory(0x6509B0,SetTo,i),
					DisplayText("\x13\x1F!!!ＮＥＷ ＲＥＣＯＲＤ \x07～ 킬 스코어 기록갱신! ～ \x1FＮＥＷ ＲＥＣＯＲＤ !!!",4),
					PlayWAV("staredit\\wav\\LimitBreak.ogg"),
					PlayWAV("staredit\\wav\\LimitBreak.ogg"),
					PlayWAV("staredit\\wav\\LimitBreak.ogg"),
					SetMemory(0x6509B0,SetTo,FP)},1)
					GetPVA = CreateVArray(FP,13)
					ItoDecX(FP,ReadScore,VArr(GetPVA,0),2,0x7,2)
					_0DPatchX(FP,GetPVA,12)
					CIfX(FP,CVar(FP,PCheckV[2],AtLeast,2))
					f_Movcpy(FP,_Add(KillScStrPtr,KillPT[2]),VArr(GetPVA,0),12*4)
					f_Memcpy(FP,_Add(KillScStrPtr,KillPT[2]+(12*4)),_TMem(Arr(DBossT3[3],0),"X","X",1),DBossT3[2])
					CElseX()
					f_Memcpy(FP,KillScStrPtr,_TMem(Arr(SoloNoPointT[3],0),"X","X",1),SoloNoPointT[2])
					CIfXEnd()

					DoActions(FP,{
						SetMemory(0x6509B0,SetTo,i),
						DisplayText("\x0D\x0D\x0DKillP".._0D,4),
						SetMemory(0x6509B0,SetTo,FP)
					})
				CIfEnd()
			end

		CIfEnd()
--if Limit == 1 then
	--CIf(FP,{CD(TestMode,1),CDeaths(FP,AtLeast,0,isDBossClear)},{SetCDeaths(FP,SetTo,0,isDBossClear),SetCVar(FP,OutputPoint[2],SetTo,0)})
--else
	CIf(FP,CDeaths(FP,AtLeast,1,isDBossClear),SetCDeaths(FP,SetTo,0,isDBossClear))
--end
		ItoDec(FP,TotalScore,VArr(TotalScoreVA,0),2,nil,2)
		ItoDec(FP,OutputPoint,VArr(DBossScoreVA,0),2,nil,2)
		_0DPatchX(FP,TotalScoreVA,6)
		_0DPatchX(FP,DBossScoreVA,6)

		f_Memcpy(FP,DBoss_PrintScore,_TMem(Arr(DBossT1[3],0),"X","X",1),DBossT1[2])
		f_Movcpy(FP,_Add(DBoss_PrintScore,DBossT1[2]),VArr(TotalScoreVA,0),5*4)
		f_Memcpy(FP,_Add(DBoss_PrintScore,DBossT1[2]+(5*4)),_TMem(Arr(DBossT2[3],0),"X","X",1),DBossT2[2])
		f_Movcpy(FP,_Add(DBoss_PrintScore,DBossT1[2]+(5*4)+DBossT2[2]),VArr(DBossScoreVA,0),5*4)
		f_Memcpy(FP,_Add(DBoss_PrintScore,DBossT1[2]+(5*4)+DBossT2[2]+(5*4)),_TMem(Arr(DBossT3[3],0),"X","X",1),DBossT3[2])
		

--		"\x13\x10【 \x07P\x04layer \x06T\x04otal \x1FS\x04core : "TotalScore" / "DBossScore" \x10】"

		Trigger {
			players = {FP},
			conditions = {
				},
			
			actions = {
				RotatePlayer({DisplayTextX("\x0D\x0D\x0DDBossSC".._0D,4)},HumanPlayers,FP);
				PreserveTrigger();
			},
		}
	CIfEnd()
	

	SetCallEnd()
	Call_Print13 = {}
	for i = 0, 6 do
	Call_Print13[i+1] = SetCallForward()
	SetCall(FP)
		Print_13_2(FP,{i},nil)
	SetCallEnd()
	end

	ComputerReplace = SetCallForward()
	SetCall(FP)
	CMov(FP,0x6509B0,UnitDataPtr)
	CWhile(FP,{Deaths(CurrentPlayer,AtLeast,1,0)})
		CAdd(FP,0x6509B0,1)
		CIf(FP,DeathsX(CurrentPlayer,Exactly,7*256,0,0xFF00))
			local PointJump = def_sIndex()
			NJumpX(FP,PointJump,{CD(initStart,0),DeathsX(CurrentPlayer,Exactly,150,0,0xFF)}) -- 포인트유닛 리젠 삭제
			NJumpX(FP,PointJump,{CD(initStart,0),DeathsX(CurrentPlayer,Exactly,220,0,0xFF)}) -- 포인트유닛 리젠 삭제
			NJumpX(FP,PointJump,{CD(initStart,0),DeathsX(CurrentPlayer,Exactly,221,0,0xFF)}) -- 포인트유닛 리젠 삭제
--			NJumpX(FP,PointJump,{CVar(FP,LevelT[2],AtLeast,7),DeathsX(CurrentPlayer,Exactly,131,0,0xFF)}) -- 해처리레어 리젠없음
--			NJumpX(FP,PointJump,{CVar(FP,LevelT[2],Exactly,10),DeathsX(CurrentPlayer,Exactly,132,0,0xFF)}) -- 해처리레어 리젠없음
			CSub(FP,0x6509B0,1)
			CallTrigger(FP,f_Replace)-- 데이터화 한 유닛 재배치하는 코드.
			CAdd(FP,0x6509B0,1)
			NJumpXEnd(FP,PointJump)
		CIfEnd()
		CSub(FP,0x6509B0,1)
		CAdd(FP,0x6509B0,2)
	CWhileEnd()
	CMov(FP,0x6509B0,FP)
	TriggerX(FP,{CV(LevelT,1)},{SetCVar(FP,RandW[2],Add,100)},{preserved})
	TriggerX(FP,{CV(LevelT,2,AtLeast)},{SetCVar(FP,RandW[2],Add,50)},{preserved})
	SetCallEnd()

	LevelReset = SetCallForward()
	SetCall(FP)
	
	DoActions(FP,{
		ModifyUnitEnergy(All,"Any unit",P8,64,0),KillUnit("Any unit",P8),
		KillUnitAt(All,124,17,Force1),
		KillUnitAt(All,124,18,Force1),
		KillUnitAt(All,124,19,Force1),
		KillUnitAt(All,125,17,Force1),
		KillUnitAt(All,125,18,Force1),
		KillUnitAt(All,125,19,Force1),})
	
	f_Mod(FP,LevelT,Level,_Mov(10))
	f_Div(FP,LevelT2,Level,_Mov(10))
	CAdd(FP,LevelT2,1)
	CMov(FP,Diff,LevelT2)
	TriggerX(FP,{CVar(FP,Diff[2],AtLeast,4)},{SetCVar(FP,Diff[2],SetTo,3)},{preserved})
	TriggerX(FP,{CVar(FP,LevelT[2],Exactly,0)},{SetCVar(FP,LevelT[2],SetTo,10)},{preserved})
	TriggerX(FP,{CVar(FP,LevelT2[2],AtLeast,5)},{SetCVar(FP,LevelT2[2],SetTo,4)},{preserved})
	if TestStart == 1 then
		--CMov(FP,LevelT2,4)
	end
	--TriggerX(FP,{CVar(FP,Level[2],AtMost,10)},{SetCVar(FP,MarNumberLimit[2],Add,84*2),SetCDeaths(FP,Add,100,PExitFlag)},{preserved})
	--TriggerX(FP,{CVar(FP,LevelT[2],AtMost,8)},{ShUnitLimitT},{preserved})--19
	--TriggerX(FP,{CVar(FP,LevelT[2],AtLeast,9)},{ShUnitLimitT2},{preserved})

	
	CMov(FP,CunitIndex,0)-- 모든 유닛 영작유닛 플래그 리셋
	CWhile(FP,{CVar(FP,CunitIndex[2],AtMost,1699)})
		CDoActions(FP,{
			Set_EXCC2(DUnitCalc, CunitIndex, 8, SetTo, 0),
			Set_EXCC2(LHPCunit, CunitIndex, 0, SetTo, 0),
			Set_EXCC2(LHPCunit, CunitIndex, 1, SetTo, 0),
			Set_EXCC2(LHPCunit, CunitIndex, 2, SetTo, 0),
		TSetMemoryX(_Add(_Mul(CunitIndex,84),19025+40), SetTo, 0,0xFF000000),
	})
		CAdd(FP,CunitIndex,1)
	CWhileEnd()

	function SetLevelUpHP(UnitID)
		CallTrigger(FP,f_SetLvHP,{SetCVar(FP,UnitIDV[2],SetTo,UnitID)})
	end

	--TriggerX(FP,{CVar(FP,Diff[2],AtLeast,1)},{SetMemory(0x515BD0,SetTo,256*16*10),SetMemory(0x662350+(4*125),SetTo,16000*256*10),SetMemory(0x662350+(4*124),SetTo,16000*256*10)},{preserved})
	
	for i = 2, 10 do
		TriggerX(FP,{CVar(FP,Level[2],Exactly,i)},{SetMemory(0x515BD0,SetTo,256*16*i),SetMemory(0x662350+(4*125),SetTo,16000*256*i),SetMemory(0x662350+(4*124),SetTo,16000*256*i)},{preserved})
	end

	
	for i = 37, 57 do
		SetLevelUpHP(i,1)
	end
		SetLevelUpHP(104,1)
	for j, k in pairs(HeroArr) do
		SetLevelUpHP(k,1)
	end
	BdArr = {130,131,132,133,135,136,137,138,139,140,141,142,143,144,146,147,148,151,152,201}
	
	for j, k in pairs(BdArr) do
		SetLevelUpHP(k,1)
	end
	SetLevelUpHP(11,1)
	SetLevelUpHP(13,1)
	SetLevelUpHP(193,1)


	DoActions(FP,SetMemoryB(0x58D2B0+(46*7)+3,SetTo,0))
	CMov(FP,UpVar,_Div(Level,10))
--		for i = 1, 3 do
--		TriggerX(FP,{CVar(FP,Diff[2],AtLeast,i)},{SetCVar(FP,UpVar[2],Add,5)},{preserved})
--		end
	for i = 0, 7 do
		TriggerX(FP,{CVar(FP,UpVar[2],Exactly,2^i,2^i)},{SetMemoryB(0x58D2B0+(46*7)+3,Add,2^i)},{preserved})
	end
	TriggerX(FP,{CVar(FP,UpVar[2],AtLeast,256)},{SetMemoryB(0x58D2B0+(46*7)+3,SetTo,255)},{preserved})

	UpVarWepArr = {6,9,18,22,23,27,51,30,71,65,67,69,75,78,114,109,113,129}
	function SetLevelUpAtk(WepID)
		CallTrigger(FP,f_SetLvAtk,{SetCVar(FP,WepIDV[2],SetTo,WepID)})
	end
	for j, k in pairs(UpVarWepArr) do
		SetLevelUpAtk(k)
	end


	SetCallEnd()

	t01 = MakeiStrVoid(20).."\x04 - \x1C0000.0%\x04 - "..MakeiStrVoid(20)
	t02 = MakeiStrVoid(20).."\x1F - \x1F0000.0%\x04 - "..MakeiStrVoid(20)
	t03 = "\x07『 \x18ATK \x1F한계돌파 \x04업그레이드 (000\x04/\x1C256\x04) \x1F(Cost:"..P_AtkExceed..") \x03(A) \x07』"
	t04 = "\x07『 \x08HP \x1F한계돌파 \x04업그레이드 (000\x04/\x1C256\x04) \x1F(Cost:"..P_HPExceed..") \x03(D) \x07』"
	t05 = "\x07『 \x08공격\x0F속도 \x04업그레이드 (\x0D\x0D\x0D\x0D\x04/\x1C10\x04) \x1F(Cost:\x0D\x0D\x0D\x0D) \x03(Q) \x07』"
	iStrSize2 = GetiStrSize(0,t01)
	iStrSize3 = GetiStrSize(0,t02)


	iStrSize4 = GetiStrSize(0,"\x07『 \x08뉴클리어 \x04보유량 :\x04 0000000000 \x07』")
	iStrSize5 = GetiStrSize(0,"\x07『 \x07구버전 포인트 \x04보유량 :\x04 0000000000 \x07』")
	iStrSize6 = GetiStrSize(0,"\x07『 "..MakeiStrVoid(20).."\x04\'s \x1FExceeD \x1BM\x04arine \x07』\x0D\x0D\x0D\x0D\x0D\x0D")
	
	iStrSize7 = GetiStrSize(0,"\x07『 \x18ATK \x1F한계돌파 \x04업그레이드 (000\x04/\x1C256\x04) \x1F(Cost:10) \x03(A) \x07』")
	iStrSize8 = GetiStrSize(0,"\x07『 \x08HP \x1F한계돌파 \x04업그레이드 (000\x04/\x1C256\x04) \x1F(Cost:35) \x03(D) \x07』")
	iStrSize9 = GetiStrSize(0,"\x07『 \x08공격\x0F속도 \x04업그레이드 (\x0D\x0D\x0D\x0D\x04/\x1C10\x04) \x1F(Cost:\x0D\x0D\x0D\x0D) \x03(Q) \x07』")
	

	S1 = MakeiTblString(1501,"None",'None',MakeiStrLetter("\x0D",iStrSize2+5),"Base",1) -- 단축키없음
	S2 = MakeiTblString(831,"None",'None',MakeiStrLetter("\x0D",iStrSize3+5),"Base",1) -- 단축키없음
	S3 = MakeiTblString(816,"None",'None',MakeiStrLetter("\x0D",iStrSize4+5),"Base",1) -- 단축키없음
	S4 = MakeiTblString(129,"None",'None',MakeiStrLetter("\x0D",iStrSize5+5),"Base",1) -- 단축키없음
	S5 = MakeiTblString(MarID[1]+1,"None",'None',MakeiStrLetter("\x0D",iStrSize6+5),"Base",1) -- 단축키없음
	S6 = MakeiTblString(1480,"일반명령",'A',MakeiStrLetter("\x0D",iStrSize7+5),"Base",1)
	S7 = MakeiTblString(1481,"일반명령",'D',MakeiStrLetter("\x0D",iStrSize8+5),"Base",1)
	S8 = MakeiTblString(1478,"일반명령",'Q',MakeiStrLetter("\x0D",iStrSize9+5),"Base",1)
	iTbl1 = GetiTblId(FP,1501,S1) 
	iTbl2 = GetiTblId(FP,831,S2) 
	iTbl3 = GetiTblId(FP,816,S3) 
	iTbl4 = GetiTblId(FP,129,S4) 
	iTbl5 = GetiTblId(FP,1480,S6) 
	iTbl6 = GetiTblId(FP,1481,S7) 
	iTbl7 = GetiTblId(FP,1478,S8) 
	PMariTbl = {}
	for i = 0, 6 do
		PMariTbl[i+1] = GetiTblId(FP,MarID[i+1]+1,S5) 

	end
	Str3, Str3a, Str3s = SaveiStrArr(FP,t01)
	Str4, Str4a, Str4s = SaveiStrArr(FP,"\x04남은 \x08뉴클리어\x04 : 0000000000  \x05-")
	Str5, Str5a, Str5s = SaveiStrArr(FP,"\x07『 \x07구버전 포인트 \x04보유량 :\x04 0000000000 \x07』")
	MarStr = {}
	MarStra = {}
	MarStrs = {}
	for i = 0, 6 do
		MarStr[i+1], MarStra[i+1], MarStrs[i+1] = SaveiStrArr(FP,"\x07『 "..MakeiStrVoid(20).."\x04\'s \x1FExceeD \x1BM\x04arine \x07』\x0D\x0D\x0D\x0D\x0D")
	end
	Str6, Str6a, Str6s = SaveiStrArr(FP,t03)
	Str7, Str7a, Str7s = SaveiStrArr(FP,t04)
	Str8, Str8a, Str8s = SaveiStrArr(FP,t05)
	

	
end